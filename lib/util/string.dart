class UtilString {
	static String ltrim(String from, String pattern) {
		int i = 0;

		while (from.startsWith(pattern, i)) i += pattern.length;

		return from.substring(i);
	}

	static String rtrim(String from, String pattern) {
		int i = from.length;

		while (from.startsWith(pattern, i - pattern.length)) i -= pattern.length;

		return from.substring(0, i);
	}

	static String trim(String from, String pattern) {
		return ltrim(rtrim(from, pattern), pattern);
	}
}
