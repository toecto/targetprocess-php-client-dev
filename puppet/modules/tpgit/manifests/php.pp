class tpgit::php {

    $php_packages = [
        'php5-common',
        'php5-cli',
        'php5-mysql',
        'php5-curl',
        'php5-gd',
        'php5-mcrypt',
        'php5-memcache',
        'libapache2-mod-php5',
    ]

    package { $php_packages:
        ensure  => latest,
        require => Package['apache2'],
        notify  => Service['apache2'],
    }

    file { 'php conf':
        path    => '/etc/php5/conf.d/tp-git.ini',
        ensure  => present,
        source  => "puppet:///modules/tpgit/php/tp-git.ini",
        require => Package['php5-common'],
    }

    exec { 'install composer':
        command => "bash -c 'curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer'",
        require => File['php conf'],
    }

    exec { 'install composer packages':
        command => "bash -c 'cd /vagrant && export COMPOSER_HOME=/tmp && composer install'",
        logoutput => "on_failure",
        require => Exec['install composer'],
    }

}
