class f3backup (
    $backup_server = 'default',
    $dirname = $::fqdn,
    $ensure = 'directory'
) {

    include f3backup::common

#    # Select the backup server, but allow override
#    if $::f3backup_server {
#        $backup_server = $::f3backup_server
#    } else {
#        $backup_server = $server
#    }
    $backup_server_final = $::f3backup_force_server ? {
        ''      => $backup_server,
        default => $::f3backup_force_server,
    }

    @@file { "/backup/f3backup/${dirname}":
        owner  => 'backup',
        group  => 'backup',
        tag    => "f3backup-${backup_server}",
        # To support "absent", though force will be needed
        ensure => $ensure,
    }

#    # Install the client's host ssh key on the backup server
#    @@sshkey { $fqdn:
#        ensure => present,
#        key    => $sshrsakey,
#        type   => 'ssh-rsa',
#        tag    => "f3backup-${backup_server}",
#    }

}

