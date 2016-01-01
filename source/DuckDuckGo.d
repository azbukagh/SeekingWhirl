module DuckDuckGo;
import std.conv;
import std.json;
import std.net.curl;
/**
	* DuckDuckGo API for D
	* Authors: Azbuka-slovensko
	* License: MIT
*/
class DuckDuckGo {
	///topic summary (can contain HTML)
	string Abstract;
	///topic summary (w\o HTML)
	string AbstractText;
	///name of source
	string AbstractSource;
	///link to topic page
	string AbstractURL;
	///link to Abstract's image
	string Image;
	///Abstract's topic name
	string Heading;
	
	///instant answer
	string Answer;
	///instant answer type
	string AnswerType;
	
	///dictionary Definition
	string Definition;
	///name of Definition source
	string DefinitionSource;
	///link to expanded page
	string DefinitionURL;
	
	///icon asociated with topic
	struct icon {
		///link to icon
		string URL;
		///icon height
		long Height;
		///icon width
		long Width;
	}
	
	///external links
	struct result {
		///link to topic
		string Result;
		///first url in Result
		string FirstURL;
		///icon of topic
		icon Icon;
		///text from firstURL
		string Text;
	}
	
	///array of internal links
	result[] RelatedTopics;
	///array of external links
	result[] Results;
	
	///response category
	string Type;
	///!bang redirect
	string Redirect;
	
	
	/**
		* Search
		* Params:
		*	query = string to search
		*	appname = name of app
		*	no_redirect = true to skip HTTP redirects
		*	no_html = true to remove HTML from text
		*	skip_disambig = true to skip disambugation (D) Type
	*/
	this(string query,
		string appname = "",
		bool no_redirect = false,
		bool no_html = false,
		bool skip_disambig = false) {
		string url = "http://api.duckduckgo.com/?q=" ~ query
			~ "&format=json";
		if(appname)
			url ~= "&t=" ~ appname;
		if(no_redirect)
			url ~= "&no_redirect=1";
		if(no_html)
			url ~= "&no_html=1";
		if(skip_disambig)
			url ~= "&skip_disambig=1";
			
		JSONValue j = parseJSON(get(url));
		
		this.Abstract = j["Abstract"].str;
		this.AbstractText = j["AbstractText"].str;
		this.AbstractSource = j["AbstractSource"].str;
		this.AbstractURL = j["AbstractURL"].str;
		this.Image = j["Image"].str;
		this.Heading = j["Heading"].str;
		
		this.Answer = j["Answer"].str;
		this.AnswerType = j["AnswerType"].str;
		
		this.Definition = j["Definition"].str;
		this.DefinitionSource = j["DefinitionSource"].str;
		this.DefinitionURL = j["DefinitionURL"].str;
		
		try {
			for(ulong i = 0; i < j["RelatedTopics"].array.length; i++) {
				this.RelatedTopics ~= result(j["RelatedTopics"][i]["Result"].str,
					j["RelatedTopics"][i]["FirstURL"].str,
					icon(j["RelatedTopics"][i]["Icon"]["URL"].str,
						DDGNumber(j["RelatedTopics"][i]["Icon"]["Height"]),
						DDGNumber(j["RelatedTopics"][i]["Icon"]["Width"])
					),
					j["RelatedTopics"][i]["Text"].str
				);
			}
		} catch { }
		try {
			for(ulong i = 0; i < j["Results"].array.length; i++) {
				this.Results ~= result(j["Results"][i]["Result"].str,
					j["Results"][i]["FirstURL"].str,
					icon(j["Results"][i]["Icon"]["URL"].str,
						DDGNumber(j["Results"][i]["Icon"]["Height"]),
						DDGNumber(j["Results"][i]["Icon"]["Width"])
					),
					j["Results"][i]["Text"].str
				);
			}
		} catch { }
	}
	private long DDGNumber(JSONValue j) {
		try {
			return j.integer;
		} catch {
			return 0;
		}
		
	}
}
