# zip
cat logo.txt | gzip | base64 -w0
# unzip
base64 -d <<<"H4sIAAAAAAAAA7VQQQ7DMAi7T9ofuLWVJvGhSOwhPH7YTtmy7VoOVmRsBzCzQNlXxVkLuXb/OEHO5/1m5pTkGu3mdC2NtDwf9Pw6i9nj6Oy0PWZM9L8VrawgQxIpKRUa0V/JaGKmtBBzD/QGvrRR8CyFomneOF6RjaXl3DmzSUEINAwgKbKx1yG51w7sed8gudgbqVIqpw80jpZ+GHCT0OkwfhY8wsPnWSNxTZLZCJ+OPGgFeooVQqq5Lyjudk128hAvg6QIG94CAAA=" | gunzip
