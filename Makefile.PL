# -*- perl -*-

use inc::Module::Install;

perl_version    5.008008;

module_name     'MojoX::Renderer::Mason';
all_from        'lib/MojoX/Renderer/Mason.pm';

resources  repository  => 'http://git.goingon.net/?p=MojoX-Renderer-Mason.git';

requires        'HTML::Mason' => 1.40;

auto_install;

WriteAll(
  sign => 1
);
