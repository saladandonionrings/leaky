import argparse
import html
import re

parser = argparse.ArgumentParser(description="Leak standardizer (utf-8)")

parser.add_argument('-i', '--input', help='Input file', required=True)
parser.add_argument('-o', '--output', help='Output file', required=True)

args = parser.parse_args()

# Regex patterns for different formats
valid_ulp_pattern = re.compile(r'^([^:\s]+):([^:\s]+):(.+)$')  # General URL:email:password
domain_like_pattern = re.compile(r'^[\w.-]+(?:/[\w./-]*)?$')  # Matches domain/path format

standardized_lines = []
skipped_lines = []

with open(args.input, 'r', encoding='utf-8') as source_file:
    for line in source_file:
        line = line.strip()
        if not line:
            continue

        line = html.unescape(line)  # Decode HTML entities

        parts = line.split(":")
        if len(parts) == 3:
            # Possible ULP or domain:email:password
            url_or_domain, email, password = parts

            if valid_ulp_pattern.match(line):
                # Already in valid format (URL:email:password)
                standardized_lines.append(line)
            elif domain_like_pattern.match(url_or_domain):
                # Domain-like format (e.g., signin.ebay.co.uk)
                standardized_lines.append(f"{url_or_domain}:{email}:{password}")
            else:
                # Invalid format
                skipped_lines.append(line)
        elif len(parts) == 3:
            # Handle misordered formats like email:password:URL
            email, password, url_or_domain = parts
            if domain_like_pattern.match(url_or_domain):
                standardized_lines.append(f"{url_or_domain}:{email}:{password}")
            else:
                skipped_lines.append(line)
        else:
            # Invalid line
            skipped_lines.append(line)

# Write standardized lines to the output file
with open(args.output, 'w', encoding='utf-8') as output_file:
    output_file.write('\n'.join(standardized_lines))

# Optional: Log skipped lines for debugging purposes
if skipped_lines:
    skipped_file = args.output + ".skipped"
    with open(skipped_file, 'w', encoding='utf-8') as skipped_output:
        skipped_output.write('\n'.join(skipped_lines))

print(f"Standardization complete. Output written to: {args.output}")
if skipped_lines:
    print(f"Skipped {len(skipped_lines)} invalid lines. See: {skipped_file}")
