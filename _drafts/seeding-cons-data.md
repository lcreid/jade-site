---
layout: post
title: Seeding Configuration Data
author: Larry Reid
tags:
---

It's a common pattern to store some aspects of an application in a database.

One of the challenges of this pattern is that application behaviour depends on something that isn't under version control.
* Deploy requires an extra step.
* Promoting application through test environments requires moving data as well as deploying code. But not all the data.

Moving the data isn't necessarily easy:

Sometimes the new data overwrites old data. E.g. you may have ten rows, and you want to replace them with seven different rows.

Sometimes the new data is a change to a subset of the columns in some of the existing rows, so you have to match on some fields, and overwrite other fields.

Sometimes you just need to delete existing data.
