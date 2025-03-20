<?php

use PhpCsFixer\Config;
use PhpCsFixer\Finder;

$finder = Finder::create()
	/*
	->exclude('somedir')
	maybe we should parse `./.vscode/settings.json`
	looking for "files.exclude" / "search.exclude" here?
	*/
	->in(__DIR__)
;

$config = new Config();

$config->setRules([
	'@PSR12' => true,
	// 'indentation_type' => true,
])
	// ->setIndent("\t")
	// ->setLineEnding("\n")
	->setFinder($finder)
;

return $config;
