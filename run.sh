#!/bin/bash

process() {
    if [ $# -eq 1 ] && ([ "$1" = "-h" ] || [ "$1" = "--help" ]); then
        show_help
    else
        launch_containers

        while true; do
            case $1 in
                "-b" | "--build")
                    rebuild_images
                    shift
                    ;;
                "-i" | "--composer-install")
                    run_composer_install
                    shift
                    ;;
                "-u" | "--composer-update")
                    run_composer_update
                    shift
                    ;;
                * ) break ;;
            esac
        done

        echo -e "\n\nEnvironment deployed."
    fi
}

launch_containers() {
    docker-compose up
}

rebuild_images() {
    docker-compose down && docker-compose build && launch_containers
}

run_composer_install() {
    docker-compose exec web php -d memory_limit=-1 /usr/local/bin/composer \
        install --no-plugins --no-scripts
}

run_composer_update() {
    docker-compose exec web php -d memory_limit=-1 /usr/local/bin/composer \
        update --no-plugins --no-scripts
}

create_alias_console() {
    alias docker-console="docker-compose exec web php my_app/bin/console"
}

show_help() {
    echo -e "-b, --b" \
        "\n\t Rebuild the docker images" \
        "\n-i, --composer-install" \
        "\n\t Run composer-install" \
        "\n-u, --composer-update" \
        "\n\t Run composer-update" \
        "\n-h, --help" \
        "\n\t Display this help and exit"
}

process "$@"