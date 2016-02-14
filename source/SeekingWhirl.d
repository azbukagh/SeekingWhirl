module SeekingWhirl;

import std.json;
import std.net.curl;
/**
	* DuckDuckGo API for D
	* Authors: Azbuka-slovensko
	* License: MIT
*/
class SeekingWhirl {
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

	private {
		string SWAbstract;
		string SWAbstractText;
		string SWAbstractSource;
		string SWAbstractURL;
		string SWImage;
		string SWHeading;

		string SWAnswer;
		string SWAnswerType;

		string SWDefinition;
		string SWDefinitionSource;
		string SWDefinitionURL;

		result[] SWRelatedTopics;
		result[] SWResults;

		string SWType;
		string SWRedirect;
	}

	///topic summary (can contain HTML)
	@property string Abstract()	{ return SWAbstract;	}
	///topic summary (w\o HTML)
	@property string AbstractText()	{ return SWAbstractText;	}
	///name of source
	@property string AbstractSource()	{ return SWAbstractSource;	}
	///link to topic page
	@property string AbstractURL()	{ return SWAbstractURL;	}
	///link to Abstract's image
	@property string Image()	{ return SWImage;	}
	///Abstract's topic name
	@property string Heading()	{ return SWHeading;	}

	///instant answer
	@property string Answer()	{ return SWAnswer;	}
	///instant answer type
	@property string AnswerType()	{ return SWAnswerType;	}

	///dictionary Definition
	@property string Definition()	{ return SWDefinition;	}
	///name of Definition source
	@property string DefinitionSource()	{ return SWDefinitionSource;	}
	///link to expanded page
	@property string DefinitionURL()	{ return SWDefinitionURL;	}

	///array of internal links
	@property result[] RelatedTopics()	{ return SWRelatedTopics;	}
	///array of external links
	@property result[] Results()	{ return SWResults;	}

	///response category
	@property string Type()	{ return SWType;	}
	///!bang redirect
	@property string Redirect()	{ return SWRedirect;	}

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

		this.SWAbstract	= j["Abstract"].str;
		this.SWAbstractText	= j["AbstractText"].str;
		this.SWAbstractSource	= j["AbstractSource"].str;
		this.SWAbstractURL	= j["AbstractURL"].str;
		this.SWImage	= j["Image"].str;
		this.SWHeading	= j["Heading"].str;

		this.SWAnswer	= j["Answer"].str;
		this.SWAnswerType	= j["AnswerType"].str;

		this.SWDefinition	= j["Definition"].str;
		this.SWDefinitionSource	= j["DefinitionSource"].str;
		this.SWDefinitionURL	= j["DefinitionURL"].str;

		try {
			for(ulong i = 0; i < j["RelatedTopics"].array.length; i++) {
				this.SWRelatedTopics ~= result(j["RelatedTopics"][i]["Result"].str,
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
				this.SWResults ~= result(j["Results"][i]["Result"].str,
					j["Results"][i]["FirstURL"].str,
					icon(j["Results"][i]["Icon"]["URL"].str,
						DDGNumber(j["Results"][i]["Icon"]["Height"]),
						DDGNumber(j["Results"][i]["Icon"]["Width"])
					),
					j["Results"][i]["Text"].str
				);
			}
		} catch { }

		this.SWType	= j["Type"].str;
		this.SWRedirect	= j["Redirect"].str;
	}
	private long DDGNumber(JSONValue j) {
		try {
			return j.integer;
		} catch {
			return 0;
		}
	}
}
