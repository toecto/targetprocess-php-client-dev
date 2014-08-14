class tpgit {
    class { 'tpgit::essentials': }

    class { 'tpgit::apache':
        require => [Class['tpgit::essentials']],
    }

    class { 'php':
        require => [Class['essentials']],
    }
    #-> class { 'mysql': }
}
