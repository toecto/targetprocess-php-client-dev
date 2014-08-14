node default {

    Exec {
        path => ["/usr/local/bin", "/usr/local/sbin", "/usr/bin", "/bin", "/usr/sbin", "/sbin"],
    }

    include tpgit

}
