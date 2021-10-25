# zip
cat logo.txt | gzip | base64 -w0
# unzip
base64 -d <<<"H4sIAAAAAAAAA32PSwqAMAwF94J3yE4FsRcqvB4kh3fSD+KiTWg+jyFJzeamlvZtwTg+IEkRrLp6G1VA0QElCicUpENWAHKtiKFbBsqw2U65/VxXWyclIGdigrzlAfb3IJLR5ZPDx8nL38Wsz16jqE70JgEAAA==" | gunzip
