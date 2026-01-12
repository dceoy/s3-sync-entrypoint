# s3-sync-entrypoint

Bash entrypoint to synchronize data with AWS S3 before and after command execution

## Installation

```sh
$ git clone https://github.com/dceoy/s3-sync-entrypoint.git
$ cp -a s3-sync-entrypoint/s3-sync-entrypoint /path/to/bin  # a path in ${PATH}
```

## Docker image

The image is available at [Docker Hub](https://hub.docker.com/r/dceoy/s3-sync-entrypoint/).

```sh
$ docker image pull dceoy/s3-sync-entrypoint
```

## Usage

1.  Set local input and output directory paths as `INPUT_DATA_DIR` and `OUTPUT_DATA_DIR`.

    ```sh
    $ export INPUT_DATA_DIR=/input
    $ export OUTPUT_DATA_DIR=/output
    ```

2.  Run a command.

    ```sh
    $ s3-sync-entrypoint \
        --input-s3=s3://bucket-i/input0 \
        --input-s3=s3://bucket-i/input1 \
        --output-s3=s3://bucket-o/output0 \
        cp -r /input/input0 /input/input1 /output/
    ```

    The above command works as follows:
    1.  Recursively copy `s3://bucket-i/input0` and `s3://bucket-i/input1` to `/input` (`INPUT_DATA_DIR`).
    2.  Execute the command (`cp -r /input/input0 /input/input1 /output/`).
    3.  Recursively copy `/output` (`OUTPUT_DATA_DIR`) to `s3://bucket-o/output0`.

Run `s3-sync-entrypoint --help` for more information.
