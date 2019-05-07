define systemd::target(
                        $target_name   = $name,
                        $description   = undef,
                        $allow_isolate = false,
                      ) {
  include ::systemd

  concat { "/etc/systemd/system/${target_name}.target":
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Exec['systemctl daemon-reload'],
  }

  concat::fragment {"${target_name} unit":
    target  => "/etc/systemd/system/${target_name}.target",
    order   => '00',
    content => template("${module_name}/section/unit.erb"),
  }
}