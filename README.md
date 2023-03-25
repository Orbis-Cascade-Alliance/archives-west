# archives-west
This is the code of the 2022 Archives West server, which uses BaseX for indexing EAD finding aids.

## Ignored Files
This repository does not include all files needed by the website.
- The defs.php file above the public directory, which contains definitions of paths and connection credentials
- The .htaccess file, which handles redirection of ARK links and differs by server
The aws directory, which contains the [AWS SDK for PHP](https://docs.aws.amazon.com/sdk-for-php/index.html) used to store backups of uploaded EADs in S3 buckets
- The google directory, which contains the [Google API PHP Client](https://github.com/googleapis/google-api-php-client) used for Analytics reports
- The repos directory, which contains the files of all repositories participating in Archives West

## Set Up
[BaseX](https://basex.org/) (for indexing) and [Zint](https://zint.org.uk/) (for QR codes) must be installed on the server.

In Apache, an environment variable AW_HOME must be set to the root directory where the defs.php file lives, for inclusion in other scripts.

Information about ARKs, repositories, users, and jobs are stored in a MySQL database. The structure is not included in this git repository.

Other setup details can be found in the [BaseX Development Documentation](https://docs.google.com/document/d/1Hjj5mskZhz3TlZAsPmczKCQQ6DnsALVBOjNAhNDSWHk/edit?usp=sharing).
