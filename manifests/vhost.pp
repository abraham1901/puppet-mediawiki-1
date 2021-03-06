# == Class: mediawiki::vhost
#
# create vhost definition for mediawiki on $fqdn
#   
class mediawiki::vhost {
  # @todo these file belong in apache::vhost somewhere
  file {
    "/var/www/${fqdn}":
      ensure => directory,
      mode   => '0755';
  
    "/var/www/${fqdn}/htdocs":
      ensure => directory,
      mode   => '0755';
  } -> apache::vhost { 'mediawiki_vhost':
    port          => 80,
    priority      => 25,
    vhost_name    => '*',
    serveraliases => [],
    options       => 'Indexes FollowSymLinks MultiViews',
    override      => ['None'],
    apache_name   => 'apache',
    docroot       => "/var/www/${fqdn}/htdocs",
    template      => "apache/vhost-default.conf.erb",
    logroot       => "/var/log/apache",
    servername    => $fqdn;
  } -> Webapp_config['mediawiki']

} 
