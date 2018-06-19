# Kanban Tool SDK Style Guide

* Use utf-8 source file encoding.

* Use soft-tabs with a two space indent.

* Keep each line of code to a readable length. Unless you have a reason to, keep lines to fewer than 200 characters.

* Never leave trailing whitespace.

* End each file with a newline.

* Use snake_case for file names.

* Once your work is marked as production ready, never commit broken or un-finished stuff into the master branch.

## Naming

* Choose two_word names for extensions when possible, i.e. ```googledrive_integration```, ```archive_view```, etc.

* Use underscore

## Coffeescript

* Use TitleCase for class names.

* Put extensions in ```KT.Extensions.``` namespace.

* Put extension specific stuff under it's own namespace - i.e. ```KT.Extensions.MyExample.Popover```.

* Use camelCase for method names.

* Prefix private methods with underscore - i.e. ```_myPrivateMethod: => ...```

* All methods which don't need to be public (are not used by other class) should be private (prefixed with _).

* Annotate most of the methods with comment describing it's functionality, and use inline comments for any non-obvious parts of code:
  ```
  # Custom XHR transport for select2, which makes sure that current request is completed before new one is sent.
  # This helps to prevent congestion on the server side from concurrent requests.
  _transport: (params, success, failure) =>
    @_transportCallbacks = [success, failure]
    @_transportRedoParams = params if @_currentRequest
    @_currentRequest ||= $.ajax(params).always(@_onTransportComplete)
    return null # make sure not to return the promise, as select2 may try to abort it, breaking the logic

  ```

* If you have suggestions on how certain method can be improved, leave it as ```@todo``` annotation.

## SCSS

* In class names use ```_``` like word separator and ```-``` as namespace separator - i.e. ```KT.Extensions.MyExample``` becomes ```kt-extensions-my_example```.

* Encapsulate styles in proper class-level namescope - i.e. ```.kt-extensions-my_example { ... }```

* Inside the namespace, prefix private members with underscore - i.e.
  ```
    .kt-extensions-my_example {
      ._menu { ... }
    }
  ```
* Unless needed, avoid deep-nesting of SCSS classes. Usually a hierarchy of 2/3-levels deep is enough.

* Simple styles can be written as single line: ```._name { color:red; }```

* Avoid putting space between CSS property and value: ```._name {color: red; } // bad``` vs. ```._name { color:red; } // good```

* More complex example of desired style:
 ```
   .kt-extensions-my_example {
     display:block; color:red;

     ._name { color:blue; }
     ._body {
       color:pink;

       pre { display:block; color:red; }
     }
   }
 ```
