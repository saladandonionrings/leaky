import argparse
import html

parser = argparse.ArgumentParser(description="Leak standardizer (utf-8)")

parser.add_argument('-i', '--input', help='Input file', required=True)
parser.add_argument('-o', '--output', help='Output file', required=True)

args = parser.parse_args()

with open(args.input, 'r', encoding='utf-8') as source_file:
    content = source_file.read()

decoded_content = html.unescape(content)

with open(args.output, 'w', encoding='utf-8') as output_file:
    output_file.write(decoded_content)
