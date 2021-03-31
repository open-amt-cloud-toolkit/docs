## Localize Strings

1. Create a new directory in the `ui-toolkit/public/locales/` directory.  The directory name must match one of the [codes listed](https://developers.google.com/admin-sdk/directory/v1/languages).

2. Copy the *translation.json* file in the `public/locales/en/` directory to the new language directory. 

3. Customize the required fields in the translation.json file. 

	!!! example
		To support Kannada language:

		1. Create a new directory `kn` in `/public/locales/`
		2. Copy *translation.json* from `/locales/en/` to `/locales/kn/` directory
		3. Update key-values in */kn/translation.json* according to Kannada language


4. Open the *i18n.ts* file in the `ui-toolkit` directory.

5. Modify the file to import the newly added *public/locales/Language/translation.json* file and update the 'resources' constant to include the new translation. 

	!!! example
		To support Kannada language:

		1. Create new import statement as 'translationKN'
		2. Edit resources constant to include new translation

		```
		import translationEN from './public/locales/en/translation.json'
		import translationKN from './public/locales/kn/translation.json';
		const resources = {
		  en: {
			translations: translationEN
		  },
		  kn: {
			translations: translationKN
		  }
		};
		```

	Rebuild and generate a new bundle before testing the changes.

Language can be changed in the browser under langauage section of the browser settings. English is the default if no customized translation file provided for the langauage.

## Get Localized Strings for Web Consoles with Localization Enabled

If your web console already has localization enabled, make sure to add the [translations](https://github.com/open-amt-cloud-toolkit/ui-toolkit/tree/master/public/locales) of the UI-controls into your web console's translations file.
