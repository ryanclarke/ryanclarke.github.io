---
title: "Wrestling with CheckedTextViews in an Android Multi-Choice ListView"
slug: "checked-multi-choice-listviews"
wordpress_url: "http://www.ryanclarke.net/post/checked-multi-choice-listviews/"
date: 2014-04-25
tags: ["android", "code", "SEP"]
categories: ["Technology"]
description: ""

---

I was building an Android ListView in an AlertDialog.Builder that allowed multi-choice. It displayed a list of accounts and you could select the one or more you wanted to operate on. I also needed to be able to set certain accounts as checked by default.

![Android MultiChooser AlertDialog](/images/multichooser.png)

I couldn't use the built in `AlertDialog.Builder(context).setMultiChoiceItems()` method because it only accepts an array of strings of display data and I needed a custom list item view with the more complex AccountSummary object.

Here is the getView method on my adapter.

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        AccountSummary account = getItemAt(position);

        if (convertView == null) {
            convertView = getInflater().inflate(R.layout.account_multi_choice_dialog_item, null);
        }

        CheckedTextView text = convertView.findViewById(R.id.text_view);
        text.setText(account.name);

        // Set the CheckedTextView to checked if its a default here

        return convertView;
    }

Everything is standard except for the need to potentially set the item as checked. You would think this would be very simple, just take the CheckedTextView and set it to checked.

        CheckedTextView text = convertView.findViewById(R.id.text_view);
        text.setText(account.name);

        // This does not work
        text.setChecked(account.isDefault);

**This does not work.** For some reason you can set CheckedTextView to checked for an hour's worth on mintues in a row (I sure did) but it will never be remembered. In fact, I even tried checking the TextView from the 'outside' by accessing the ListView from my activity, grabbing the correct CheckedTextView, and setting checked there. And that didn't work either.

It turns out, as I understand it, that the ListView maintains the checked state of its list items and ignores the state that item says it should have. The following small change in the code makes everything work charmingly.

        CheckedTextView text = convertView.findViewById(R.id.text_view);
        text.setText(account.name);

        // This, quite charmingly, works
        ((ListView) parent).setItemChecked(position, account.isDefault);

Instead of checking the item, I tell the ListView to set checked on the correct item. According to the Android source, AbsListView keeps all the checked state in a SparseBooleanArray so the checked state in the TextView goes nowhere and has no effect. I'm not sure I understand the full picture, but just set the checked state on the ListView, not the list item.

So now you know.

