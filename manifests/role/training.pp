class bootstrap::role::training {
  include epel
  include localrepo
  include bootstrap
  include bootstrap::profile::splash
  include bootstrap::profile::cache_wordpress
}
