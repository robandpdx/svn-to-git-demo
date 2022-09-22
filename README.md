# Converting SVN repo to git

This project is meant to demo converting an svn repo to git. A good svn repo to use is [this one](https://sourceforge.net/p/circuit/code/HEAD/tree/).

1. clone this repo

1. Edit ldap_get.ruby replacing `bindDN` `url` and `baseDN` for your org.

1. Fetch all users from ldap by running...

	```
	./ldap_get.ruby > ldap_users.txt
	```

1. Edit settings.sh to point to your svn repo

1. Make the authors.txt by running the following script…

    ```
    ./create_authors.sh
    ```
1. mirror your svn repo…

    ```
    ./mirror_svn.sh
    ```
1. initialize a local git repo, and convert to git…

    ```
    ./init_git_repo.sh
    ```
1. Sync from svn to git. You can run this ongoing weekly or daily until your are ready to cutover.

    ```
    ./svnSync.sh
    ```
1. When you are ready to cutover, add the new origin, push `main` and other branches and tags to github.

    ```
    cd local-git
    git remote add origin GITHUB_REPOSITORY_URL.git
    git push -u origin main
    cd ..
    ./push_branches.sh
    ./push_tags.sh
    ```
    
