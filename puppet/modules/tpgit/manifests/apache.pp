class tpgit::apache {
    package { 'apache2':
        ensure => installed,
    }

    file {'apache tp-git-settings':
        path    => '/etc/apache2/conf.d/tp-git-settings.conf',
        ensure  => present,
        source  => "puppet:///modules/tpgit/apache/tp-git-settings.conf",
        require => Package['apache2'],
    }

    file {'apache tp-git-site':
        path    => '/etc/apache2/sites-available/tp-git-site',
        ensure  => present,
        source  => "puppet:///modules/tpgit/apache/tp-git-site",
        require => Package['apache2'],
    }

    exec {'a2ensite tp-git-site':
        command => "bash -c 'a2ensite tp-git-site'",
        notify  => Service['apache2'],
        require => File['apache tp-git-site'],
    }

    service { 'apache2':
        enable    => true,
        ensure    => running,
    }

}
