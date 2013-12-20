##############################################################################
# Configure dotfiles
##############################################################################

class dotfiles {
    pkg::install { [ 'git', 'tree', 'vim-enhanced', 'zsh', 'bc' ]: }
    user { 'vagrant':
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
    exec { '/tmp/bootstrap.sh':
        path        => '/bin:/usr/bin:/sbin:/usr/sbin',
        creates     => '/home/vagrant/.dotfiles',
        command     => '/tmp/bootstrap.sh',
        cwd         => '/home/vagrant/',
        user        => 'vagrant',
        group       => 'vagrant',
        environment => 'HOME=/home/vagrant',
        logoutput   => true,
        require     => [
            File['bootstrap'],
            Package['git'],
            Package['tree'],
            Package['vim-enhanced'],
            Package['zsh'],
            Package['bc'],
        ]
    }
    exec { 'vim +BundleInstall +qall 2&>/dev/null':
        path        => '/bin:/usr/bin:/sbin:/usr/sbin',
        command     => ''vim +BundleInstall +qall 2&>/dev/null'',
        cwd         => '/home/vagrant/',
        user        => 'vagrant',
        group       => 'vagrant',
        environment => 'HOME=/home/vagrant',
        logoutput   => true,
        require     => Package['vim-enhanced'],
    }
}

