#!/bin/bash

# Корневая папка проекта (где лежит run.sh)
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

case "$1" in
    build_generator)
        docker build -t generator "$PROJECT_DIR/generator"
        ;;

    run_generator)
        mkdir -p "$PROJECT_DIR/data"
        docker run --rm -v "$PROJECT_DIR/data:/data" generator /data
        ;;

    create_local_data)
        mkdir -p "$PROJECT_DIR/local_data"
        python "$PROJECT_DIR/generator/generate.py" "$PROJECT_DIR/local_data"
        ;;

    *)
        echo "Пока доступны: build_generator, run_generator, create_local_data"
        exit 1
        ;;
esac
