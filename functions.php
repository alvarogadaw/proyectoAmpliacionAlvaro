<?php
function mi_tema_corporativo_setup() {
    add_theme_support('title-tag');
}
add_action('after_setup_theme', 'mi_tema_corporativo_setup');

function mi_tema_corporativo_scripts() {
    wp_enqueue_style('mi-tema-style', get_stylesheet_uri());
}
add_action('wp_enqueue_scripts', 'mi_tema_corporativo_scripts');
