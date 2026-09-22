Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18E39F17F;
	Tue, 22 Sep 2026 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099113; cv=fail; b=UZ4ooJRk1nxWPDt/FBGYxV8mZ26qHqppECtydcm2StKC4fvC9Uw0itAql8TlRjf6bbzhbki0GJzKezVtC3MYjWjRmnyfI8CZEcebzT835ZTEQfWTcL6AtfdLIR3ww0dY6kHyypN9OmhSo+46WeNlY65Ckyopvz5KoczKP6Q3tm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099113; c=relaxed/simple;
	bh=Bp13uafFpJ+Toco3xrQW/adbDbu7M/+mGxLU+0IlW+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZDrN5exTiF2gO7CbQDI0MIK0mwS27J7QACUJpNDsG99iXoZ5lQpizwfOWVsyO2QDSVGUb6a2GxL5XEOyGRBsoEeyJ8nPw+UmjcdMb2PWNKdEoH39WuhQG7v7Yray8MM8eUmZJJH2+7NT+4D2HAXhjACR8qiR/uFb6oN06Svbmbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=godJcvX5; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="godJcvX5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790099112; x=1821635112;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Bp13uafFpJ+Toco3xrQW/adbDbu7M/+mGxLU+0IlW+k=;
  b=godJcvX5biX4vdtYRWBRaJbs7Ya/Kh6eNoJ3JJqwROTfMh0TtZtK8zo5
   /pX9x7nU5tpnYExtHKBgHkLQHA3BfuXiMM4I3LIyCNNrXq5qVk4IyABTE
   yhSmezi9E6gPkoKGr3OHqOm2iIbvrICUgiM8xDsVyqXqEatt5AWzdsArb
   0VemsgfPhZqCR7RF44FDYyjHTDBSA//QIgj2o/5TbJqRlkqaUWfEtGX6o
   AlAnjaIINNPnOxB9z60gVZON1J/A2HtZ7kii2NR+Y6Vsu259Y3eJmYjqB
   YpQAuW6G/tb/thaUHQPDjZ952v0pFgyiGgHnff6mT5et3T7NhGOTyyfeg
   w==;
X-CSE-ConnectionGUID: mkctqy98R+ebkb5P4x0VkQ==
X-CSE-MsgGUID: BnTC1avfTd6GHzBLGsy/pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="102082116"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="102082116"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 10:45:11 -0700
X-CSE-ConnectionGUID: Ov0G+aHxRNGQq3QgbVuPgQ==
X-CSE-MsgGUID: RAquoijqQI2rOjJSnxzbSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="4524763"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 10:45:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 10:45:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 10:45:10 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 10:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKOfie/ixpIdwf/4iAjLsQ1RW45OyE98wtqajPpAIClvt7ty3WWEOx5dPNTnKkPYK+wXKyWhodXbvX7zsGGeNSnBkLtfpur2j7XWtrfRKjxmthHuA/OEpzSg63yF91cljg1l9CwvfT4kCT4qzSxXQMjsYH0D+4fUdvTNelPhi3k0ofAkYINXc+SyPsxw/Q/Z/MWktj9zb1py+d+Ij793oEXgQ/T+NGlZrjVcFsTDUzw1FOdxkscelfrqdiZM+hb6eU7QiT04fIDLgwKROqwcJeu0Bda8mEVKcHn/lKvGVRQ5QxWgRUMvLHwhvnULUOz7X19HL8vFHkVNawK821Rplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp13uafFpJ+Toco3xrQW/adbDbu7M/+mGxLU+0IlW+k=;
 b=FpoRxLu685tyGAeqoPCByrsB0TiGYJ/nYtydY4b6zRkcuB3F7G6diEBl1vTK0rUQFxHHjTUwC83jEqX8xunLPKHrkyzuJ2VfcRTL3l8wvG1O+7Pfx14bkFm0FMNxVnvx+YKPI+zh7XFqtK3eMJgdFoaCjYOIez4iV6vtmvAj26JAhbDvHARbTLZLHFd5iudavCsdA+ntssgwADkISMHSqtJWILeql/A8gtLURpyIV8L3Mu7HuP61RKnVZaTVJnLPPyJj1Bq2urw9A96kMdgZ+bdPqJotufHCTrnaky49TNABKPDM5S+wySf4queFsiUtv5o1N4dXDxQNc8EhKR+wQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22)
 by MN0PR11MB6133.namprd11.prod.outlook.com (2603:10b6:208:3cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 17:45:03 +0000
Received: from SA2PR11MB5162.namprd11.prod.outlook.com
 ([fe80::70e1:28f7:f440:ff0c]) by SA2PR11MB5162.namprd11.prod.outlook.com
 ([fe80::70e1:28f7:f440:ff0c%6]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 17:45:03 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "kas@kernel.org" <kas@kernel.org>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "ak@linux.intel.com" <ak@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/tdx: Remove the early #VE handler
Thread-Topic: [PATCH] x86/tdx: Remove the early #VE handler
Thread-Index: AQHdQVJI5eTV/fAKY0yXdX2Qs0UGg7bIRmSAgADp84CAEGsDgIAA2b6AgAB8cwA=
Date: Tue, 22 Sep 2026 17:45:03 +0000
Message-ID: <d940f1bb8bf51915c7efb19f79760859ad8a45df.camel@intel.com>
References: <20260910-b4-tdx_remove_early_ve_handler-v1-1-bf47a4d360c5@intel.com>
	 <b41da075607d1eaa9d96eddbf3acc24502edd604.camel@intel.com>
	 <aqPTIyi--7f2Fzxm@thinkstation>
	 <4238bd74efaeea1a6158b79f9475a5f8d1aa7e0a.camel@intel.com>
	 <arJVpaAi9TqEfV7E@thinkstation>
In-Reply-To: <arJVpaAi9TqEfV7E@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB5162:EE_|MN0PR11MB6133:EE_
x-ms-office365-filtering-correlation-id: 5e4bef7a-21ef-41ad-76f3-08df18d13b72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|3023799007|11063799006|5023799004|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: VNNIXJ7PmTrnlzUC7INT+Vpx5KMwW7tFiTjR3Qc3QzDLWZrnPnpMNvG8ZLeke/b6hRn7zKrpNLhj/4yGNwjTRmhxiQMG+uEj01MH0kMPy5T52Z8YwBy/A2Af7t6pvxiR+Yy5tQCV+5+JTe79q/uZrBi9AqKiIppjUhttPdEH8kTQjE9QEOF2+c8bb6mU+bSjAsx9w84ZghdboR/D7aVtcfDQVXAhMgNJvXob4qUIjLY9+omr6cEIZrS+mtJmRRPrzBYBvBThL31+VzmyaVGkjlUDfGX/O5B3kl0sPScWZQWgyS38UDaFlqweH920GbJMev0ji8mZdmCpFUz9utbXooo2yRYOfSfhnkQx5xtzRx31IVN9s4rSETQZGbbGcQNVBaaxCYlAg3n8V/uWBYWn7/pDNYSrubAk7aruUb8+wOxflhCXnh3UoRwj+GR0d9/HENR/Jwsy05xqUjtxfp6GqRdp/AEmEATUwYnHKnuBY3uAQfVizwJdetoyjLDTZIDMG5JuC2nA+Ku/HVnLULPyxqBo8DJrPXGnY+59pcow32GslN6fbkmNhedlnLN+8CPfY+lk9hwzKEt2tBfXVqBMjR21E3KUrz8iSrYRK+nYnj1q6uRrmOBlZ75cLEilnR2dknd00eeikYSyuLeFLFyXwpEFhYuX5UgcFtVMV5dZdiknEEOIQgxbNxDCmzaZeWZITT+K50nuNlSH6wzzRA7+bqKXyAxosmwx3rYxVAwQ5oA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5162.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(3023799007)(11063799006)(5023799004)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUlzaE9GUkMxZG1FbFM4akpSVTJSeWNacmhidDdkUzlGMU9ocjE0R2pRUEZD?=
 =?utf-8?B?cEg5dEJPU1FIdVZIWkdYbzYrb1dYT3FOeGswV1Zkd21ENXFqRWFicVAvM2Mw?=
 =?utf-8?B?dWFZK0pXdkVTTjdENjV3dmZVUHlJRlU3aHpWOU5SRHhwMXl2ak1TNWo0MkhT?=
 =?utf-8?B?MzJ2UHN1WktwcTFlUDgrQXV0WWYxOHFDU0ZXenR4MmV3SVRrUnBrclpPT083?=
 =?utf-8?B?S1lvREN6OGRUZFdRdUhkRHZKSnlkTi94SEtBN2xEeCtCdUVpTXlNVXRqdTVH?=
 =?utf-8?B?SzZXSHNhQ1BEWUE5TXA5YWlTMExKL1Avbmd5eXNQOEJZbHJZVVh0aTE4NkN4?=
 =?utf-8?B?WmNWcEdhRHRERkkrTVJLb2tGVmlOTHlNR1oyYXhRT3FUVDBOL3NyZUdrSlU2?=
 =?utf-8?B?QzVqM1RIN3hoN2N3Q2dnQWhiTDF5ZDdiWExBWUJLTVUzcDl3eHlDRUJ1SnhN?=
 =?utf-8?B?S3lBVjZvYlQ3eXdtbCtEMExhOFhrdnoxU1B0Y2ZGelY5WHQ5NGJ6c3RoNlJa?=
 =?utf-8?B?S21yWHF2SWg5VjZzdCswQk10QlBNeFhkdzkzUGRibGxLaURuTVFRVWJEVzRL?=
 =?utf-8?B?a1JoZnZoNlIwaElqSldQOGtuaVVZMk9SQ3F2dFd1RGNtOEl0YzBOSUtPNzl0?=
 =?utf-8?B?TmF6Qm9qR3dKNlZQcGRxQk1qOG5Hc0tMbGZUdkorcngzRlZZME1mY2FxV1Jr?=
 =?utf-8?B?Nk83ZzdFSnVGL2pQSGNHUjVUS0lDT1Jac0tmWUZMVEtHNlRYUGQ1NXNHTDdJ?=
 =?utf-8?B?UUZnYU1wVjBvb3E1alI1M3gvemNQaTMydzBNekkyVGJiOTZUTFFYZkphUGQ5?=
 =?utf-8?B?NTdGUGFnTWZEL3JXK1dUU2NCQ0hiVVNZMDVtVWFxSHBxQ1dHL1hkbXBxaDhu?=
 =?utf-8?B?QXdDL1lOK1dPVDNndGpaMmhtNnRSbDZBaE5TVmtFRnhEVzBjWHZFTmdFczlF?=
 =?utf-8?B?ajluNERCV1hrSzUxVjJhUHl4ckFPNnVZb0w1V0pLREwwTytWSWdMUmxlK1dL?=
 =?utf-8?B?V3VnZUo4eU5GU1ZtSWJVSXN6eEY4N0hhNjJJdzVnbHpDZlpJSGZ0U3RFMTB4?=
 =?utf-8?B?OTQrdW5Lc2xjQzA5WHhUakFTaUJvQnhCTTZxdkhmRS9FYnBaSmMvWXhadWFv?=
 =?utf-8?B?SWdWNkV1VU1rdlJ3RllYTGhqT1hmYTNMZXBkcyt0RGd2Tk45VEFJZERYVnB6?=
 =?utf-8?B?dWg2S0RySHMrUFNqekZWSkVJUXBlSUFlTmFiNldEdmFGQlcrdUpCRkJYaDho?=
 =?utf-8?B?eUszd0xLNlAycndqSk1Fc0xkTVpxaVYxYkx2ZXFrTzB2bjZqaXF6RGVUaUFa?=
 =?utf-8?B?SCtzMWNMSG1FVXNrcXIzZGRuU3hSWVZaaGYxZDhMZEQyem0rdDZ2MldaaUlv?=
 =?utf-8?B?YkJDNlpwMGFtaGMvbUF1cE41UkJvTUJIcjJDM3BzcTF4b1hQb3p3a1RLOUxZ?=
 =?utf-8?B?L3F5Vkx1a1dHY294em5OQjN2YUZ3UHg3T25NckpnK2lkcVdNMncrM1hlZHly?=
 =?utf-8?B?UDh5anJwYWEwRFhGZ2h2c1NGYWszVWptR3ErTkIybmFITG9zN1IzQmJWeVJs?=
 =?utf-8?B?U1lzU3JHUUpXMDR1WFY2WVFaTmRKdHJMTXg5cXhOTWVia05ENVBZRTVjYnNs?=
 =?utf-8?B?QldQeDluV3ZuMk4xN0Njd0Y0ZitoVG5hUnNEK2x2bnlQREFYNThtSUxmL1g5?=
 =?utf-8?B?UzY5aXFnWGFMTTJUcldlcXMvYmdZOWZaNnNDdGh1L2Voc3prSGpwblZnYWtY?=
 =?utf-8?B?ODdnQjkrOFpiWkgxVk5jMWZ1ZCsrNHJFZVYvUndWdVhRNzFYL1ozc2JGUUZm?=
 =?utf-8?B?WlpuWllWMVRtT2Z3U1ltbXkzK1VaSElOemlqbFI3ZmJhU09nMDY1ZE93bVlz?=
 =?utf-8?B?bXk3RTRPbjBQVkhkeFNTM1l0TENUTHpzU25VYzVWWDJIY2J4cU5jVk9qSEEw?=
 =?utf-8?B?SXdHMmQwbFBoeHRJOHgzbzE5Umwzbm81bHR3Y3FGYVZBTExDWHdLa3RCRzdQ?=
 =?utf-8?B?QU9RY1V4VXFHWEYyYWUwQlF4RFBaR1JLemZZWXpXVDIrYnJyNUhGWlorN2xF?=
 =?utf-8?B?d1RpZ0h1TU1xSDlteUQ0WHB5cG1XWlliM3ZHZ3JuTkRtcTdiVFJ1Nmw2OEZm?=
 =?utf-8?B?WFdhelRnaWZZUzdCclZRTGlmZnhrU2d5d05mUnFxTkg0M0piSDB2dVpENWNn?=
 =?utf-8?B?V3I4eGtncDZCMHJxYXkwNnoyTmtGbXhodWU2Ym8zbDlCRHNzcTNJLzBjWVk4?=
 =?utf-8?B?NjVPVnl1cm5ySC8zSUJCYjlyNVkxOTFpUzRFc2NqbDc1VzBUNTJjT1A2dEdB?=
 =?utf-8?B?dC95cVN4ZlJsUEQzNE95WGFVSEZvSHhCbFlPYVlIOThnMFJRUFNyZkYrbExN?=
 =?utf-8?Q?jGYL3fHuqofz/UYE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <706995628CBCBD47B503F3F1894F061B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: d5ycqwnAdNeWw+ipKf8RpO2vC8JhRvX6qq9K5tqS/0GUEtE5riUcxFPCY4WMdtRLsWk8PCxx7ZufP5xp2CDfNGMZ+JxzyWHQjIDlpY8bMPby1Unrv5zi9nFqtLQcyMpFn3daKbtxtdGC5HinwaKxUYwYRUjX0srKxQR98qQymS703sDJc0tlmmBsn35Lp5LyLwFkrnERbfxRi4xQjLFVOSbnPxaXxHTRZAFUy8ueuIRYgogfbG4/AzJJMtSWskaPeqsuAZqcShMfcG4UnYx3ejaerThcT44D56C9HpUYDrD2xFggVRdh7uXKy+tn879S3uEcSU4yT4vrvh97ofOmeA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5162.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4bef7a-21ef-41ad-76f3-08df18d13b72
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 17:45:03.3996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2wUnhBuZvB9kJrYNGiN5qYIMUwcnSqT2Y3y9qHsPNXYQn2qF6XcyqVaoY9kGex34INa3UjnE2p0RCfXbjLWCFcW+gKJbnH7GmYAz5kJzhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6133
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTIyIGF0IDExOjE5ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+IA0KPiBDb3VsZCB5b3UganVzdCBjaGVjayB3aGF0IGhhcHBlbnMgeW91IHBhbmljIGVhcmx5
IChsaWtlIGluDQo+IHRkeF9lYXJseV9pbml0KCkpIHdpdGggYW5kIHdpdGhvdXQgdGhlIHBhdGNo
Pw0KDQpUZXN0ZWQgdGhpczoNCg0KLS0tDQoNCiBhcmNoL3g4Ni9jb2NvL3RkeC90ZHguYyB8IDMg
KysrDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvY29jby90ZHgvdGR4LmMgYi9hcmNoL3g4Ni9jb2NvL3RkeC90ZHguYw0KaW5kZXggZjkw
NGE2MzZkNDQ5Li5mY2IyZWNmMDU1ZDEgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9jb2NvL3RkeC90
ZHguYw0KKysrIGIvYXJjaC94ODYvY29jby90ZHgvdGR4LmMNCkBAIC0xMTkyLDQgKzExOTIsNyBA
QCB2b2lkIF9faW5pdCB0ZHhfZWFybHlfaW5pdCh2b2lkKQ0KIAl4ODZfY3B1aW5pdC5wYXJhbGxl
bF9icmluZ3VwID0gZmFsc2U7DQoNCiAJdGR4X2Fubm91bmNlKCk7DQorDQorCXBhbmljKCJlYXJs
eSAjVkUgd2luZG93IHBhbmljIHRlc3QiKTsNCiB9DQoNCi0tLQ0KDQpJbiBib3RoIGNhc2VzLCB3
aXRoIGFuZCB3aXRob3V0IHRoZSByZW1vdmFsIHBhdGNoLCB0aGUgZ3Vlc3QganVzdCBoYW5ncw0K
d2l0aG91dCBhbnkgYWN0dWFsIHRleHQgaW4gdGhlIHNlcmlhbCBvdXRwdXQuIEkgZGlkbid0IGFk
ZCBhbnkgcGFuaWM9DQpjbWRsaW5lLCBhbmQgQ09ORklHX1BBTklDX1RJTUVPVVQgd2FzIHRoZSBk
ZWZhdWx0IDAuDQo=
