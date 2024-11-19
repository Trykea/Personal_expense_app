Instead of using SingleChildScrollView we use Listview
since it's a better widget.
To use listview we must give certain height/width to
its parent.
There are 2 type of Listview:
    1. Is normal Listview with
a child widget but it render all the list exist even if
we don't see them
    2. Is Listview.build() which render only the list we see
that is good for performance and we should use it.
Inorder to use Listview.build() we need to use
itemBuilder and itemCount (see in transaction_list)