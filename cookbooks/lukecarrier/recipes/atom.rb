# Atom text editor

include_recipe 'atom'

if node['platform_family'] == 'debian'
  package 'atom'
end

atom_packages = [
  'atom-ctags',
  'autocomplete-clang',
  'editorconfig',
  'language-cmake', 'language-glsl', 'language-powershell',
  'linter', 'linter-alex',
  'minimap',
  'Zen',
]
atom_packages.each {|atom_package| atom_apm atom_package}
