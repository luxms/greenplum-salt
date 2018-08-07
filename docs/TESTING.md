# Testing

> **Development branch, not yet ready for production use, but we're working on it !**

-----

### Documentation

| Readme       | README.md |
| ------------ | --------- |
| Building     | [docs/BUILDING.md][DocBuild]    |
| Requirements | [docs/REQUIREMENTS.md][DocReqs] |
| Testing      | [docs/TESTING.md][DocTests]     |

### For testing

##### List minion keys
```sh
[mdw] salt-key -L
```
##### Accept minion keys
```sh
[mdw] salt-key -A
```
##### Any commands
```sh
[mdw] ./tasks dev link
[mdw] ./tasks dev test
[mdw] ./tasks dev testa - async run
[mdw] ./tasks dev top
[mdw] ./tasks dev info
```

License
----
MIT

**Copyright (c) 2018 Luxms Inc.**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [DocBuild]: https://github.com/luxms/greenplum-salt/tree/dev/docs/BUILDING.md
   [DocReqs]:  https://github.com/luxms/greenplum-salt/tree/dev/docs/REQUIREMENTS.md
   [DocTests]: https://github.com/luxms/greenplum-salt/tree/dev/docs/TESTING.md
