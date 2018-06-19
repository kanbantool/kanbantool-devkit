# The extension development kit for [Kanban Tool](https://kanbantool.com/)

DevKit provides a scaffold for development of custom Kanban Tool Extensions and Power-Ups.
If you are working on something simple, you may not need it at all - a [custom script](https://kanbantool.com/developer/sdk#custom-scripts) is much easier way to get started.

If you haven't done that already, check the [Kanban Tool SDK Documentation](https://kanbantool.com/developer/sdk) for reference on how to write custom extensions.

## Installation

Install Ruby with [Ruby Version Manager](https://rvm.io/)
``` sh
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
$ \curl -sSL https://get.rvm.io | bash -s stable```
```

Make sure that Ruby was installed correctly and works
``` sh
$ cd . && rvm current # should return i.e. ruby-2.x.x
```

Make sure you have bundler gem installed for dependency management
``` sh
$ gem install bundler
```

Install the required dependencies
``` sh
$ bundle install
```

Run the devkit development site on `http://localhost:9292` with
``` sh
$ rackup devkit.ru
```

or compile production ready, minified files with
``` sh
$ rake devkit:build
```

## Development

1. Verify that once you run the development site with `rackup devkit.ru` the compiled files are available on
   `http://localhost:9292/devkit/kanbantool-devkit.css` and `http://localhost:9292/devkit/kanbantool-devkit.js`.

2. Open up the dashboard view on your Kanban Tool account, and navigate to `Account Administration > Account settings` page.
   Open developer tools in your browser and run `$('.im_a_developer').show()`. This will show a hidden pane where you can
   specify external script sources to be loaded. Please enter the JS and CSS URLs from the step 1 there, separated by newline, and save changes.

3. Once you go to board view, the devkit will be loaded, and you should be able to see the "Devkit Example" extension on Power-Ups page.
   Any changes you make to devkit should get reflected once you reload the page.

4. Create your own extension in the `devkit/kt/extensions` directory, and update the `index.css.scss` and `index.js.coffee` files.
   You can base it on the template from `devkit/kt/extensions/devkit_example`.

Happy c0din3 :)
