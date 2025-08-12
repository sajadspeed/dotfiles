function on_chapter_change()
	local chapter_title = mp.get_property("chapter-metadata/title", "")
	mp.osd_message(chapter_title, 3)
end

mp.observe_property("chapter", "number", on_chapter_change)

mp.add_key_binding("c", "show-chapter", function()
	local chapter_title = mp.get_property("chapter-metadata/title", "")
	if chapter_title then
		mp.osd_message(chapter_title, 3)
	else
		mp.osd_message("No chapter available", 2)
	end
end)
