project('vala app', 'vala', 'c')

dependencies = [
    dependency('gtk+-3.0'),
    dependency('webkit2gtk-4.0'),
]

sources = run_command('find', 'src','-type','f',check:true).stdout().strip().split('\n')
libtoy = library('toy', sources, dependencies: dependencies, install:true)
executable('main', 'main.vala' , dependencies: dependencies, link_with: libtoy, install:true)
foreach plugin : run_command('find', 'plugin','-type','f',check:true).stdout().strip().split('\n')
    name = plugin.split('/')[-1].split('.')[0]
    library('toy_'+name, plugin, dependencies: dependencies, link_with: libtoy, install:true)
endforeach
