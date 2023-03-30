Warning: This tool is highly destructive and should only be used in extreme situations where data security is the highest priority. Use with extreme caution.

Secure Apocalypse is a Linux-based security tool that creates a new user named secureuser. When the system is accessed with this user, an auto-destruction script located at /root/apocalypse.sh is triggered. This script overwrites the main system disk (/dev/sda) with random data from /dev/urandom, effectively destroying all data on the disk.

This tool is intended to be used as a last resort in critical security scenarios where ensuring the confidentiality and integrity of the data is more important than preserving the system or its contents.
