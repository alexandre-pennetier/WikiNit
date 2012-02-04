module pagesModule

import pageModule

# Contains the list of all created pages
class Pages

	# All pages
	var pages: List[Page]
	
	init() do
		pages = new List[Page]
	end
	
	fun addPage(page : Page) do
		pages.push(page)	
	end
	
	fun findPage(link: Link): nullable Page do
		var pageFound = new Page		
		var found = false
		
		for currentPage in pages do		
			if not found then
				if currentPage.name.link.length == link.link.length then
					var nodesMatch = true
					for i in [0..currentPage.name.link.length - 1] do						
						if currentPage.name.link[i] != link.link[i] then
							nodesMatch = false
						end						
					end

					if nodesMatch then		
						pageFound = currentPage
						found = true
					end
				end
			end
		end
		
		if found then
			return pageFound
		else
			return null
		end
	end
	
	private fun resolveLink(link: Link, parentLink: Link): nullable Page do
		var found = false
		var concatenatedLink = new Link("")
		var page = new nullable Page
		var parentLength = parentLink.link.length
		
		for i in [0..parentLength] do
			if not found then
				concatenatedLink.setLink("")
				concatenatedLink.link.append(parentLink.link)
				concatenatedLink.link.append(link.link)
				
				page = findPage(concatenatedLink)
			
				if page != null then found = true

				if not parentLink.link.is_empty then parentLink.link.pop
			end
		end
		
		if found then
			return page
		else 
			return null
		end
	end
	
	fun removePage(pageLink: String) do
		
		var page = findPage(new Link(pageLink))
		
		if page != null then
			pages.remove(page)
		end
		
	end
	
	fun getPageLinks(pageLink: String): nullable List[Page] do

		var page = findPage(new Link(pageLink))
		var links = new List[Link]
		var pages = new List[Page]
		var empty = true
		
		if page != null then
			links = page.links
			empty = false
		end
		
		for link in links do
			var pageFound = resolveLink(link, new Link(pageLink))
			if pageFound != null then pages.push(pageFound)
		end
		
		if not empty then
			return pages
		else
			return null
		end

	end
	
	fun getSuperPages(pageLink: String): List[Page] do
		var link = new Link(pageLink)
			
		return new List[Page]
	end
	
	fun getDirectSubPages(pageLink: String): List[Page] do
		var link = new Link(pageLink)
			
		return new List[Page]
	end
	
	fun getPageBacklinks(pageLink: String): List[Page] do
		var link = new Link(pageLink)
			
		return new List[Page]
	end
	
	redef fun to_s: String do
		var str = ""
		
		if pages.length == 0 then
			str = "One does not print inexistent pages."
		else
		str = "Pages list : \n\n"
			for page in pages do
				str += page.to_s + "\n"
			end
		end
		return str
	end
end