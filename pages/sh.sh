#!/bin/bash

for file in References___*; do
    awk '
    BEGIN {
        processing = 0
        icon_line = ""
        exclude_line = ""
    }

    # Capture type line and start processing
    /^type::/ {
        processing = 1
        gsub(/^type:: /, "")
        type_value = $0
        next
    }

    # Capture icon and exclude lines
    /^icon::/ && processing {
        icon_line = $0
        next
    }

    /^exclude-from-graph-view::/ && processing {
        exclude_line = $0
        next
    }

    # Skip empty lines while processing header
    /^$/ && processing {
        next
    }

    # Start of bullet list - output header and convert first item
    /^- / && processing {
        print icon_line
        print exclude_line
        print ""
        # Convert the bullet list item properties
        gsub(/^- /, "")
        print "- type: " type_value
        if ($0 != "") {
            gsub(/:: /, ": ")
            print "  " $0
        }
        processing = 0
        in_list = 1
        next
    }

    # Convert remaining property lines in the list
    in_list && /^  [a-zA-Z]/ {
        gsub(/:: /, ": ")
        print $0
        next
    }

    # End of property list
    in_list && /^- / && !/^  / {
        in_list = 0
        print $0
        next
    }

    # Regular lines
    !processing && !in_list {
        print $0
    }
    ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
done
