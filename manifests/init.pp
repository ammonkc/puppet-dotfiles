##############################################################################
# Configure dotfiles
##############################################################################

class dotfiles {
    file { 'bootstrap':
        ensure  => file,
        path    => '/tmp/bootstrap.sh',
        mode    => 0544,
        source  => 'puppet:///modules/dotfiles/bootstrap.sh'
    }
    exec {  "dotfiles bootstrap.sh":
      path      => '/bin:/usr/bin:/sbin:/usr/sbin',
      command   => "bash /tmp/bootstrap.sh",
      require   => File['bootstrap'],
    }
}

