project('vala app', 'vala', 'c')

dependencies = [
    dependency('gtk+-3.0'),
]

sources = run_command('find', 'src','-type','f',check:true).stdout().strip().split('\n')

executable('main', sources, dependencies: dependencies)
