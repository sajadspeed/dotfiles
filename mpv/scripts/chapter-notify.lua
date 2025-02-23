function on_chapter_change()
    local chapter_title = mp.get_property("chapter-metadata/title", "")
    mp.osd_message(chapter_title, 3)
end

mp.observe_property("chapter", "number", on_chapter_change)
