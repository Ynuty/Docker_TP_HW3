#!/bin/bash

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

    build_reporter)
        docker build -t reporter "$PROJECT_DIR/reporter"
        ;;

    run_reporter)
        mkdir -p "$PROJECT_DIR/data"
        docker run --rm -v "$PROJECT_DIR/data:/data" reporter
        ;;

    structure)
        find "$PROJECT_DIR" | sort
        ;;

    clear_data)
        rm -f "$PROJECT_DIR/data"/*.csv "$PROJECT_DIR/data"/*.html
        ;;

    inside_generator)
        mkdir -p "$PROJECT_DIR/data"
        docker run --rm -v "$PROJECT_DIR/data:/data" --entrypoint ls generator -la /data
        ;;

    inside_reporter)
        mkdir -p "$PROJECT_DIR/data"
        docker run --rm -v "$PROJECT_DIR/data:/data" --entrypoint ls reporter -la /data
        ;;

    *)
        echo "Доступны: build_generator, run_generator, create_local_data,"
        echo "           build_reporter, run_reporter, structure, clear_data,"
        echo "           inside_generator, inside_reporter"
        exit 1
        ;;
esac
