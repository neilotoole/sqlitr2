# neilotoole/sqlitr2
`sqlitr2` is a trivial query tool for SQLite written in Go. It was
created to test cross-platform Go/CGo builds using GitHub workflows/actions,
GoReleaser, and [fury.io](https://fury.io) to host deb/rpm packages.

## Usage

From `sqlitr2 --help`:

```
sqlitr2 is a trivial query tool for SQLite.

Usage: sqlitr2 [FLAGS] path/to/db.sqlite query [QUERY_ARGS]

Examples:
  sqlitr2 --help
  sqlitr2 --version

  # simple select, will print header row
  sqlitr2 ./testdata/example.sqlite 'SELECT * FROM actor'

  # same as above, but don't print header row
  sqlitr2 --no-header ./testdata/example.sqlite 'SELECT * FROM actor'

  # same query, but the SQLite db is first downloaded from
  # the URL to a temp file, then the query is executed.
  sqlitr2 https://github.com/neilotoole/sqlitr2/raw/master/testdata/example.sqlite 'SELECT * FROM actor'

  # execute a SQL stmt (note the --exec flag, as opposed to default query behavior)
  sqlitr2 --exec ./testdata/example.sqlite "INSERT INTO actor (actor_id, first_name, last_name) VALUES(11, 'Kubla', 'Khan')"

  # execute a SQL stmt, but supply query args via the command line
  sqlitr2 --exec ./testdata/example.sqlite 'DELETE FROM actor WHERE actor_id = ?' 3

  # create a new DB file
  sqlitr2 --create path/to/db.sqlite


Note that if the SQL is a SELECT or similar query, output is
in TSV (tab-separated) format. To execute a non-query SQL statement
such as INSERT, supply the --exec flag: in that case the count of
rows affected (and the last insert ID if applicable) are printed.

sqlitr2 exists as a demonstration project for neilotoole/xcgo which
is a Go/CGo cross-compiling docker builder image. sqlitr2 makes use of
the https://github.com/mattn/sqlite3 package which uses CGo to
incorporate SQLite.

sqlitr2 was created by Neil O'Toole <neilotoole@apache.org> and is
released under the MIT License. See https://github.com/neilotoole/sqlitr2
```

Usage example, with a remote DB file:

```shell script
$ sqlitr2 https://github.com/neilotoole/sqlitr2/raw/master/testdata/example.sqlite 'SELECT * FROM actor'
actor_id	first_name	last_name
1	PENELOPE	GUINESS
2	NICK	WAHLBERG
3	ED	CHASE
4	JENNIFER	DAVIS
5	JOHNNY	LOLLOBRIGIDA
6	BETTE	NICHOLSON
7	GRACE	MOSTEL
8	MATTHEW	JOHANSSON
9	JOE	SWANK
10	CHRISTIAN	GABLE
```


## Installation
This section is the raison d'être of `sqlitr2`. After any of these
methods, run `sqlitr2 --version` to verify your install.

### go get
The usual Go method will work (although without `--version` info): 

```shell script
go get -u github.com/neilotoole/sqlitr2
```

### go install
Or, if you want to install from source (again without `--version` info):

```shell script
$ git clone https://github.com/neilotoole/sqlitr2.git && cd sqlitr2
$ go install
```

### brew
Install on macOS or Linux via [brew](https://brew.sh/) ([formula](https://github.com/neilotoole/homebrew-sqlitr2/blob/master/sqlitr2.rb))

```shell script
$ brew tap neilotoole/sqlitr2
$ brew install sqlitr2
```

### scoop
Install on Windows via [scoop](https://scoop.sh/) ([manifest](https://github.com/neilotoole/sqlitr2/blob/master/sqlitr2.json))

```shell script
$ scoop bucket add sqlitr2 https://github.com/neilotoole/sqlitr2
$ scoop install sqlitr2
```

### snap
Install on Linux via [snap](https://snapcraft.io/docs/getting-started).

```shell script
$ snap install sqlitr2 
```

### deb

```shell script
# This script requires curl and gpg to be installed.
sudo apt update -y && sudo apt install -y curl gpg

curl -fsSL https://apt.fury.io/neilotoole/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/fury-neilotoole.gpg

echo "deb [signed-by=/usr/share/keyrings/fury-neilotoole.gpg] https://apt.fury.io/neilotoole/ * *" | sudo tee /etc/apt/sources.list.d/fury-neilotoole.list > /dev/null

sudo apt update -y && sudo apt install -y sqlitr2
```

### rpm

```shell
cat <<EOF | sudo tee /etc/yum.repos.d/fury-neilotoole.repo
[fury-neilotoole]
name=fury-neilotoole
baseurl=https://yum.fury.io/neilotoole/
enabled=1
gpgcheck=0
gpgkey=https://apt.fury.io/neilotoole/gpg.key
EOF

sudo yum install -y sqlitr2
```

### tarball
Download the appropriate `.tar.gz` or `.zip` file from GitHub [releases](https://github.com/neilotoole/sqlitr2/releases), and extract the binary from the archive.

### docker
You can also run `sqlitr2` directly from the published [docker image](https://hub.docker.com/repository/docker/neilotoole/sqlitr2):

```shell script
$ docker run neilotoole/sqlitr2:latest /example.sqlite 'SELECT * FROM actor'
```
^ Note that `/example.sqlite` is included in the image. You could also use a URL:

```shell script
$ docker run neilotoole/sqlitr2:latest https://github.com/neilotoole/sqlitr2/raw/master/testdata/example.sqlite 'SELECT * FROM actor'
```




## Acknowledgements
- `sqlitr2` was created to demonstrate [neilotoole/xcgo](https://github.com/neilotoole/xcgo): see that [README](https://github.com/neilotoole/xcgo/blob/master/README.md) for upstream acknowledgements.
- `testdata/example.sqlite` database is a tiny
stripped-down version of the [Sakila](https://dev.mysql.com/doc/sakila/en/) database.
- `sqlitr2` employs [mattn/go-sqlite3](https://github.com/mattn/go-sqlite3) to demonstrate CGo usage.
- And of course, [SQLite](https://www.sqlite.org/) itself.
