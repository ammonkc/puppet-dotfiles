##############################################################################
# Configure dotfiles
##############################################################################

class dotfiles {
    pkg::install { [ 'git', 'tree', 'vim-enhanced', 'zsh', 'bc' ]: }
    user { "vagrant":
      ensure    => present,
      shell     => '/bin/zsh',
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
        user      => 'vagarnt',
        path      => '/bin:/usr/bin:/sbin:/usr/sbin',
        command   => "bash /tmp/bootstrap.sh",
        require   => File['bootstrap'],
        require   => Package['git'],
        require   => Package['tree'],
        require   => Package['vim-enhanced'],
        require   => Package['zsh'],
        require   => Package['bc'],
    }
}

