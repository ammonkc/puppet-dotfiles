##############################################################################
# Configure dotfiles
##############################################################################

class dotfiles {
    pkg::install { [ 'git', 'tree', 'vim-enhanced', 'zsh', 'bc' ]: }
    user { "vagrant":
      ensure    => present,
      shell     => '/bin/zsh',
      require   => Package['zsh'],
    }
    file { 'bootstrap':
        ensure  => file,
        path    => '/tmp/bootstrap.sh',
        mode    => 711,
        owner   => 'vagrant',
        group   => 'vagrant',
        source  => 'puppet:///modules/dotfiles/bootstrap.sh',
    }
    exec {  "dotfiles bootstrap.sh":
        user      => 'vagrant',
        path      => '/bin:/usr/bin:/sbin:/usr/sbin',
        command   => '/tmp/bootstrap.sh',
        require   => [
            File['bootstrap'],
            Package['git'],
            Package['tree'],
            Package['vim-enhanced'],
            Package['zsh'],
            Package['bc'],
        ]
    }
}

