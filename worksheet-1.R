# create a shortcut to your data

file.symlink(from = "../data_r/data",
  to = 'data')


# confirm that data is accessible
file.exists('data/README.md')
