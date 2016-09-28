class profile::windows::ad_dc(
  $domain_name = lookup('profile::windows::ad_dc::domain_name', {value_type => String, default_value => ''}),
  $domain_admin_username = 'Administrator',
  $domain_admin_password = 'Puppet123',
  $safemode_admin_username = 'Administrator',
  $safemode_admin_password = 'Puppet123',
) {

  validate_re($domain_name, '\.', "domain_name of '#{domain_name}' cannot be a top level domain or empty")
  
  if $facts['msad_is_domain_controller'] == 'False' {

    notice("domain ${domain_name}")

    ## Install a DC is guarded so it doesn't accidentally try to move a
    ## DC to a different domain. Bad stuff happens then
    #reboot { 'ad_dc_dc_install_reboot' :
    #  message => 'AD DC installation has requested a reboot',
    #  apply => 'immediately',
    #}

    #dsc_windowsfeature { 'rsat-adds':
    #  ensure => present,
    #  dsc_name => 'rsat-adds',
    #}

    #dsc_windowsfeature { 'ad-domain-services':
    #  ensure => present,
    #  dsc_name => 'ad-domain-services',
    #} ->
    
    # First DC in a domain
    #dsc_xaddomain { 'ad_dc_domain':
    #  ensure => present,
    #  dsc_domainname => $domain_name,
    #  dsc_domainadministratorcredential =>  { user => $domain_admin_username, password => $domain_admin_password },
    #  dsc_safemodeadministratorpassword => { user => $safemode_admin_username, password => $safemode_admin_password },
    #  notify => Reboot['ad_dc_dc_install_reboot'],
    #}

    # Additional DC in a domain
    #dsc_xaddomaincontroller { 'ad_dc_domain_controller':
    #  ensure => present,
    #  dsc_domainname => $domain_name,
    #  dsc_domainadministratorcredential =>  { user => $domain_admin_username, password => $domain_admin_password },
    #  dsc_safemodeadministratorpassword => { user => $safemode_admin_username, password => $safemode_admin_password },
    #  require => Dsc_xaddomain['ad_dc_domain'],
    #  notify => Reboot['ad_dc_dc_install_reboot'],
    #}
  }

# TODO Export a resource with the domain information so that other resources can figure out how to join the domain correctly.
}
