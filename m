Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844274AA3F7
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789597932; cv=fail; b=Lgq7zBgpSq3bUoL6haHTsLbIR574L/o61PHrKJwg93ZY26MgEHMGN+KQGzkJf6LedAqJiY0N7eA6QQrStCQYY+ChRUZUbY+verd8++cd7CKAKRmcfm2FDz/2rElGguCw2kOlVYpcYmiIISGujVHoHSzVO1tcI2+q25cx040gSUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789597932; c=relaxed/simple;
	bh=gRduqrSWCcaqTON4zzN1+Rbdx87bjs2j5JGN/LDI3xA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fSmZgvwLHcB+Oid191CGyi+Fa4866geoQ8tlCFs6NYPj0FXA5R8kL9FatUrO5iz160tIJe/3TKTugCYGrEInEigEX3V19u/vEAtz8YoPMlvDFo90JrEc1E/7CEuO32srbFPBZbCuPn7LEiTIz8deMCz9O0rJDipcVu4+nwJIxgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O62J3E/q; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O62J3E/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789597923; x=1821133923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gRduqrSWCcaqTON4zzN1+Rbdx87bjs2j5JGN/LDI3xA=;
  b=O62J3E/qfXwOXccbWqtduaRdNMQngn+oS/l1aWkG8kdoCXEwUxLQerOD
   aMppDG4w9KEtCVkDQ6P7UPJT3KBMSpRbpLs7mjfHkftvzCrOKBuuE55WJ
   2xejODWth69NXS5Y+Vn8bn/Fp9te6HJWJZYzZPHHBU7je2F03YAFnlrCI
   7Goa3r8wAD2IZ/C5de9YyFPYrugW8RJ47jMk5HCJQ8K5UGrT/n07SdDn/
   n13sCNw0bYYIwdVb1LC9ORgxKd8CCjFXH11LUjhTit+I7ys8NqJubaruw
   x94Yf1ViLypUWNiDKFOme08Qvq7MRqtoLzAc0BFfksbmrRP8oeJE8BQ7z
   Q==;
X-CSE-ConnectionGUID: c67XUD2QRbOMAhYigcxJvg==
X-CSE-MsgGUID: w1R6Qg2cQS6UlRTYBPR6jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93810093"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93810093"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 15:32:00 -0700
X-CSE-ConnectionGUID: bdjIsLFMTF2/P57hySMYlQ==
X-CSE-MsgGUID: /nknnSq+QWmeGEsZ5NYr0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277023107"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 15:32:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 15:32:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 15:32:00 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 15:31:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szoNQICLGeYW+rIWR2KEit0mpUkM52JyveShfnA8e53lMsvr8IAXttOjxG/1+OGt2jD4aXtezLRkOiL6opY4pkyIMJbXcOBQB6vRoS2l/w9Pfk0holjlRF7b/U4OrCHjvZbl12gahbNLvC9VnrvpGdcBgu+Tr80nlGo+UQ45I5JF2LqVv5gaS5j3vNZKoaJgTwkpEiy+Dx4UXvmoD1+y7olvY4zlBfZ2yiNV/yQ+AfeuyZK20FCHPRBvoSGISAtERkz2K4thO2hK3CnB1D6Shsb3mg4BiPx2+mp/3IgdEQZYeP5WpHyOVi04W1n+WN/a6dUa+i77hGYnZdGqWbdCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRduqrSWCcaqTON4zzN1+Rbdx87bjs2j5JGN/LDI3xA=;
 b=yeZJ24TO4iFFS3ujhwwpeV9u8RcL+BLvrjsp4kpti4BGQR5IlEfAIwUd3roaFR2BHpA2ASDbPjalneM636fPQx6F9xiTksqSmqRLNmRm2UKFKlSMqShi7VbC60sC8xWTzixcGeXRh7s9AVb6NOBtRC3q1LO2OyhyfWAsQDODdCNT/981RR6cx1aVFDwLd2RZEekaGA4jYzbDd0YCu68q+GwPu0uZY2I+AjgEP0KcPFO8WKEAtT84PxhfbjLilc80uZpDV8B9oCX8VcW2+Obzul+nLqno495pXF4EDPTPQy0/tSFNNA7VVSIV38YNAdyL55+ThZSMjOjKREXvwam7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SN7PR11MB6876.namprd11.prod.outlook.com (2603:10b6:806:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 22:31:50 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 22:31:50 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>, "Annapurve,
 Vishal" <vannapurve@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Fang, Peter" <peter.fang@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: TDG quote analysis
Thread-Topic: TDG quote analysis
Thread-Index: AQHdRXUGnV1D6jtpckytZt9IbBOCMLbRf7KAgAANsICAAAqMAIAAM3uA
Date: Wed, 16 Sep 2026 22:31:50 +0000
Message-ID: <dae5a64112c9c949524226c66efac9c669df5b92.camel@intel.com>
References: <24a751d16ba0dc37aa7774df5739f39734cf9aca.camel@intel.com>
	 <aqrZUZtSZ-YItclT@google.com>
	 <736a9315f3cc3d8ef7079b784bfcc7b014386bd8.camel@intel.com>
	 <aqrtprn5YaMijVdZ@google.com>
In-Reply-To: <aqrtprn5YaMijVdZ@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SN7PR11MB6876:EE_
x-ms-office365-filtering-correlation-id: 00b56d1a-6bbc-45da-1279-08df14424d2a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|4143699003|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: Pk3jhBohO7WQT3VlsQ2ercl1HXUTKwxmratVM0E39bRH4qHZmCHl3eq6QDd/Yqk7FgNe5uZgsrpIvdTdWdiQ+lHdYsO9I/HaUXNn6elXYHF4UbZJoyPPt6xWIL1jNSPaa3l5XXf/4wgMBZm/H7lYilidh5wksfDIwVWpluNQIokl+zOC8+kjKsM3LQByRAdW+UI1AMLOdmRoYjDjWkB1V64wLdmgw0OQxvZfTJGOMJpxo1f/i9mwKYh8/VKmmkH7YiXkAGBHZvN7GQRzssIWQrAwRYmcfjuK0yBKRYShshl7qR68IERN0FgMZUCcfev0Oj9UTVkOxyqiFbRHMHSg3E9u63lqjZxCbawHECuwlUQlQKnY1V+8dUxIUE7Wiuvq3lq9Uh5b266xmFEHaG18QLUo3UI9rtjlXkkIwU9XlAX1MZeoAMQDW9pLZYvVGMtFqB2CVAHVq5VXbUFRdlwcT+SRH0sIXIWa6advAQIdcJ0XlgUsXLivRJthhUhKcqqVKfNmJgX62zn1GHG7K/b2PdMO4tNO8KqMlAOWJOsu/p8zUtYhsnWnA449M0bTJ8zVfY7JIbbIHdxHg7YXt1KpAOLEZ/+evvYJBodhZMH+4ZeVI+2nVkIEkF4fL80B3YXsXkHD3e0WEsGc7sA2hVo2VzNF4x9nN8Od0H1d3DG/iBLAhY9GzP2bjEeZyveyZgJkgi0ZXAQr2gNUoyl1E/yC57ytnjGydXGCiBtCy2NLO6U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUxiTHN4VFJBaHlLNnM3L2tEclN1SUdFc2tDN0dUZ0hvVE0yNERYWnYwdzFy?=
 =?utf-8?B?SHp1cGtxZFRyL1o0MncweXJlQkwzekdONWNzZmtiTFlKOEx1ZGdjdmxPcVUv?=
 =?utf-8?B?bGEwMGVMWmNQRGRaTFRWUUQyNDFobU9DQUdzckZUQ1laZjZSRjgxczA1OHVj?=
 =?utf-8?B?MFNUbUszQitCTzBnamNSL3BpTFVOVUdqSExhSXpDTTJLR1BxTFBNWkZzUkpw?=
 =?utf-8?B?ekh3SlRQQkFVRUNiOXl0cTJIUHVDOGpwaC9taDFYTGQ0ZCtUMUdwM0NIeUxP?=
 =?utf-8?B?bERCOXRNd0FxOCtVZEg0UnY1K2RLM21GWTYvd1ZCWTlVckhtQTdhNkU0WkZE?=
 =?utf-8?B?UyszeVRteTlveGd1YnZ2Znk4c1JFUk11R0VDd3A5WEw1dzl6bVlqZmdtR3Fo?=
 =?utf-8?B?aHduV2dGdXBqZElISzMrazFZU2NjSGErQk96ZGU5OFZQVjZFbDB3STlURGVt?=
 =?utf-8?B?U2pNY2JLY2VrdGdzdWxqaGdWNDNXZXpYNzlUSHNGOFI5MTE3cDg1QkRFTTV3?=
 =?utf-8?B?eERCdExQZ2dlL0p2SCt1b1hMbTB6a3lZLzhrZG8ybGgzYzZvbllnOG45QXRQ?=
 =?utf-8?B?Z2t0Q1JLbFJKTmllMlpVMWdZaFQwR2Y1QUxZZS95OG5HMzNxN1hxaUtPWk9p?=
 =?utf-8?B?K0lBenFRRHJacW1tMVk4d1ROQ3lld1RxcTJzcXF1ZDZTZmxHWWxORURrSS8y?=
 =?utf-8?B?N1ZwclBpNU9jazQrdzBuN29jTTB4WjVaNUlVQy9oYzNrUll1YXhwdDlWbUI0?=
 =?utf-8?B?TkhIeFVScnIvU3g1T0g0Q243SkVubmxVZkxjbWdncHZxdThxYXN0VjlxZFBU?=
 =?utf-8?B?WktiOWEwMHNmWEMxZ1M0WXNSUmJtcTZyYW5RYkxocFI5RGVoWFBRYnlPRExP?=
 =?utf-8?B?bERURW5tckpFWDVCVjF0Q3E0bmJWOVM4QThzR3IxTjk1VTJGazRNcU42YXZE?=
 =?utf-8?B?Y2lBS1ZoUVcrOVdIZFRveWVRYXQyam53WWJMRjFobDhMdTg0VHMwZ3pjR0dH?=
 =?utf-8?B?dFh5V3FJQTgvZEgyblFzclQ5QUlsc1RBZzBDUGtpYVlHancvc2U5UEErRmhR?=
 =?utf-8?B?ck1DcXpyWHFCSmxzZHhPM2N1K0d0eFBXczRHY01pTlB5Q1ErSGh3TjMxNHRy?=
 =?utf-8?B?Z3UyRFJWRGlmRzRoUEJadkQwc2hRUGQrK3d1R29Yd1lITk90RWhYU3dtWXJ5?=
 =?utf-8?B?TnQ5c2FPZUpqWmdKQTRyWitCdXFEWXFEWjNHeGdJSlJIdFk1dERDazdDM1Nk?=
 =?utf-8?B?NEtPQSs1TTlJR0dmSW8vM2RBV25YL1FUSmd3UDhuZVBXR2lISCthYUNza3dB?=
 =?utf-8?B?ZTN1SGN2MEFPUzg5dDNMcnRTNE1YS3hpWGNuN2xMYmUxZVVSeTB2dW9ST1Yw?=
 =?utf-8?B?U29maFZKOW1aOGIyayt5WEd1WE5NZHhPeTZ5UEs4Nlc5aEdhZ1psOEMwQlBv?=
 =?utf-8?B?RlV6eXlYSTBIbkZSVVU3RkNSQ2FBNkhGNURMeW56cDdwZlk5bnVTWGI1ekxN?=
 =?utf-8?B?cXFCOTNiK3ZZTFNTclN2UktjQnJBak5oaEVDSm5zYVJBR0ZNbExqNWRvaVdj?=
 =?utf-8?B?L3hwQXdVTXJ1NThLS3JhWGFLMXZkWHd4ZUM0VVFHWHRtVThmdzFIcE50bmFj?=
 =?utf-8?B?dlFPOWFCRVNPRG5iT3VJelcycXFEUW5aR1NxaWNBbnZaWjlkQUlZdTYrVUhq?=
 =?utf-8?B?dGRXR0FpVDlSbllLaXoxTjByNWV0bHdJL3ZlcVRQWFhNRGMxS0cwZGZSL2pX?=
 =?utf-8?B?WVY2Z2FENXlXVnhZQTIwYkZ3RUhvSmJLZjBTaHVNZzlES1lrdW9ZczVlQ0hK?=
 =?utf-8?B?blR2ZlZxSHhEM3Z3M2x0VHc5WjJRc1d3WmlHbzIyY2t6OWZmdGJINGtoZUUw?=
 =?utf-8?B?U1pBYmFVNVhiUnZ4bUNzdjJpNkcvbkhSbzZ0MEY5TzV0Nk1KdDVnbytUVytn?=
 =?utf-8?B?S01ldHpKL1BCUHM0WlZrcHd3L1lVVHRWYVpMa3g2akdOb2V1b1h4YmNqcDRq?=
 =?utf-8?B?NVFOVmIxR0RJSG9JSEl4a2ZTYXV2OThQS2MzZzdLd1VFOFh0eXZmUXhDa1ls?=
 =?utf-8?B?ZUx4TDZnWjBJNW81OTFjUDRSR0o0a0hHS3pwU08rRUthb0s3R2I2VSt4aW1Z?=
 =?utf-8?B?ZUlWYVF0enBMNkpmZFRXank3YzV6bGpDWTZ1end0eVJaRGtTZWs1eGJlME5C?=
 =?utf-8?B?ZitKbENWM0JIOHdrWlFwOVNXcndyQkJ0bW5KWWpRSkZ2RGRXTHN3M3VieDRP?=
 =?utf-8?B?dEd1eXEvd3hLL1lRSStrSUVjZCtRbi85TjJ6L0RJSW45TTRlVFZZQTN2aStI?=
 =?utf-8?B?L0tuWjBRaDV0V1Y3Qzc2YXg1dENoRmNNcDBKYS9OYm1KQlBwWEVTWm9xMjNR?=
 =?utf-8?Q?wrPceYH48Tr3qjMs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6466059C1095C04FB979854E22ED7016@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Sv4hQramlanPk7K4C//1r6VeTJHXvGQRjriGXxcENTSmyrGN99JyhCACW3aa71Y4AK5xiveVWAQ1jmeEhWcmVBywmDVJu0UQJJ+v1FQ+ce8LEd1MQjRj9nBhA6aQdzgiFTFZoKMyJDc9OgBr3hXcOH9J06Lz5mryJC64YPeoCD0HpQzEsnm1m9NBivxbGmowvC0vitWv1LTgAxWRdERbdx6w/2xqBllK1jE6NbXNsyhwLY9ADRlNGqmUZkIGDYlXm60mhriwJU/ljmu+2exKl7faqoyVZ5G8NoaTvxKAJfASAC49KpxQrKRE4720t+n4hquz/iS52kYeaQ4QK+QBEg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b56d1a-6bbc-45da-1279-08df14424d2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 22:31:50.4308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X710xe8xris6aXKzcPKvisDMw3Itp52sTd1tDzVL+uut2JWzzSpk3mynS9lhCuiR//Nyr33sfJWvFiTHUuvjfhBgVE3mCCnJUGNjUivIU4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6876
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTE2IGF0IDEyOjI3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IElmIHlvdSBhcmUgdGhpbmtpbmcgdGhlIGltcGxlbWVudGF0aW9uIGNvdWxkIHB1
bnQgb24gaG93IHRvIGhhbmRsZSB0aGUgZ3Vlc3QNCj4gPiBpbnRlcnJ1cHRzIGZvciBub3csIHRo
YXQgc2VlbXMgcmVhc29uYWJsZS4gSSdkIHRoaW5rIGV4aXRpbmcgdG8gaGFuZGxlIHRoZQ0KPiA+
IGhvc3QgaW50ZXJydXB0cyBjb3VsZCBub3QgYmUgc2tpcHBlZCB0aG91Z2guDQo+IA0KPiBJJ20g
anVzdCB0cnlpbmcgdG8gdW5kZXJzdGFuZCB0aGUgc2NvcGUgb2YgdGhlIHByb2JsZW0gd2UncmUg
dHJ5aW5nIHRvIHNvbHZlLg0KPiBFLmcuIEkgZG9uJ3QgdGhpbmsgYW55IGRlc2lnbiB3aWxsIHNh
dmUgdXMgaWYgZ2VuZXJhdGluZyBhIHF1b3RlIHJlcXVpcmVzIGENCj4gQ1BVIHRvIGJlIHNwaW5u
aW5nIGZvciBtdWx0aXBsZSBtaWxsaXNlY29uZHMuDQoNCkVsZW5hLCBhbnkgdXBkYXRlZCBlc3Rp
bWF0ZXMgb24gQ1BVIGJhc2VkIHF1b3RlIGdlbmVyYXRpb24gYW5kIEhXIGJhc2VkPw0KDQo+IA0K
PiA+ID4gRG9lcyB0aGUgVERYIE1vZHVsZSAqbmVlZCogdG8gcHJvdmlkZSBhIHNhdmUgc2xvdD/C
oCBXaGF0IHdvdWxkIHByZXZlbnQgVERYDQo+ID4gPiBmcm9tIHJlcXVpcmluZyB0aGUgZ3Vlc3Qg
dG8gcHJvdmlkZSBzdG9yYWdlIGZvciB3aGF0ZXZlciBpbi1mbGlnaHQgZGF0YSBpcw0KPiA+ID4g
bmVlZGVkPyBUaGF0IHdheSB0aGVyZSBpdCBkb2Vzbid0IG1hdHRlciBpZiB0aGUgZ3Vlc3QgbmV2
ZXIgcmVzdW1lcyB0aGUNCj4gPiA+IGNhbGwsIGl0IGNhbiBvbmx5IGh1cnQgaXRzZWxmLg0KPiA+
IA0KPiA+IEkgd2FzIHRoaW5raW5nIGFib3V0IHRoaXMgdG9vLCBidXQgdGhvdWdodCBpdCBzb3Vu
ZGVkIGEgYml0IGxpa2UgdGhlIE5BS2VkDQo+ID4gU05QIHNlY3VyZSBBVklDIHBhdHRlcm4uIEF0
IGxlYXN0IHRoZSBURFggbW9kdWxlIHdvdWxkIG5lZWQgdG8gaGFuZGxlDQo+ID4gZ2V0dGluZyBh
c2tlZCB0byB6YXAgdGhlIGd1ZXN0IHBhZ2UgdGhhdCB3YXMgZ2l2ZW4gdG8gYmUgYSBzYXZlZCBz
dGF0ZSBzbG90Lg0KPiANCj4gQnV0IGRvZXNuJ3QgdGhlIFREWCBNb2R1bGUgYWxyZWFkeSBuZWVk
IHRvIGRvIHRoaXM/wqAgSXQncyB3cml0aW5nIGd1ZXN0DQo+IG1lbW9yeSwgbm8/wqAgU28gaXQg
bmVlZHMgdG8gcHJldmVudCB0aGUgcGFnZSBmcm9tIGJlaW5nIGZyZWVkIHdoaWxlIGl0J3MNCj4g
aGFuZGxpbmcgdGhlIHF1b3RlLsKgIEp1c3QgcHV0IHRoZSBvbnVzIG9uIHRoZSBndWVzdCB0byBw
cm92aWRlIHRoZSBzYW1lIEdQQQ0KPiB3aGVuIHJlc3RhcnRpbmcgdGhlIFRERy4NCg0KV2hlbiB5
b3UgbWFrZSBhIG5vbi1pbnRlcnJ1cHRpYmxlL25vbi1yZXN0YXJ0YWJsZSBjYWxsLCB0aGUgVERY
IG1vZHVsZSBkb2Vzbid0DQpydXNoIG91dCBpZiB0aGVyZSBpcyBhbiBpbnRlcnJ1cHQgcGVuZGlu
Zy4gSXQgbGV0cyB0aGUgY2FsbCBmdWxseSBjb21wbGV0ZSwgaWYNCml0IGlzIHNob3J0LiBEdXJp
bmcgdGhhdCB0aW1lLCBpZiBpdCBpcyBvcGVyYXRpbmcgb24gcHJpdmF0ZSBtZW1vcnkgaXQgd291
bGQNCnRha2UgaW50ZXJuYWwgbG9ja3MgdG8gcHJldmVudCB0aGUgcGFnZSBmcm9tIGdldHRpbmcg
emFwcGVkIG91dCBvciBzd2FwcGVkLg0KDQo+IA0KPiBJZiB0aGUgaG9zdCB5YW5rcyBhIHBhZ2Ug
YXdheSBmcm9tIHRoZSBndWVzdCwgdGhlIGd1ZXN0IGlzIGhvc2VkIG5vIG1hdHRlcg0KPiB3aGF0
LiBJZiB0aGUgZ3Vlc3QgZnJlZXMgYW4gaW4tdXNlIHBhZ2UsIGUuZy4gY29udmVydHMgaXQgdG8g
U0hBUkVELCB0aGVuDQo+IHRoYXQncyAxMDAlIGEgZ3Vlc3QgYnVnLg0KDQpJbWFnaW5lIHRoZSBz
Y2VuYXJpbyBvZiBhIHZDUFUgZXhlY3V0aW5nIHRoZSBUREcgcXVvdGUgb3BlcmF0aW9uLiBGcm9t
IGFub3RoZXINCkNQVSBpbiB0aGUgaG9zdCwgS1ZNIHphcHMgdGhlIHBhZ2UgdGhlIFRERyBjYWxs
IGlzIHVzaW5nIGZvciBpdCdzIHNhdmUgc3RhdGUuDQpURFggbW9kdWxlIHdvdWxkIG5lZWQgdG8g
a25vdyBpdCBjYW4ndCB5YW5rIHRoZSBwYWdlIHRoYXQgd2FzIGFjdGl2ZWx5IGJlaW5nDQp1c2Vk
IGJ5IHRoZSBUREcgcXVvdGUgb3BlcmF0aW9uLiBTbyBJIGd1ZXNzIGl0IHdvdWxkIGhhdmUgdG8g
bGVhdmUgdGhlIEdQQSdzIFMtDQpFUFQgZW50cnkgbG9ja2VkLiBUaGUgVk1NIGNvdWxkIHVzZSB0
aGUga2ljayBzY2hlbWUgdG8gYnJlYWsgdGhyb3VnaC4NCg0KQnV0IEkgd291bGQgdGhpbmsgaXQg
d291bGQgbmVlZCB0byBrZWVwIHRoZSBzYXZlIHN0YXRlIHBhZ2UgZnJvbSBnZXR0aW5nIHN3YXBw
ZWQNCm91dCBkdXJpbmcgdGhlIGVudGlyZSBxdW90ZSBvcGVyYXRpb24gYWN0dWFsbHkuIChpLmUu
IGJldHdlZW4gdGhlIHJlc3VtZXMpLg0KQmVjYXVzZSBpdCBpcyBwcm9iYWJseSBub3Qgc2FmZSB0
byByZXNldCBkYXRhIG9uIHNvbWUgZXhlY3V0aW9uIGNvbnRleHQNCm9wZXJhdGluZyB3aXRoIHNl
Y3JldCBrZXlzLCBldGMuIEluIHRoYXQgY2FzZSwgdGhlbiBzb21lIG90aGVyIG1vcmUgZGVzdHJ1
Y3RpdmUNCm9wZXJhdGlvbiB3b3VsZCBiZSBuZWVkZWQgdG8gbGV0IHRoZSBndWVzdCBzdGlsbCB6
YXAgdGhlIFMtRVBULiBCZWNhdXNlIHRoZSBraWNrDQpzY2hlbWUgd291bGQgbm90IHVubG9jayB0
aGUgUy1FUFQgZW50cnkgaW4gdGhhdCBjYXNlLg0KDQpUaGVyZSBtaWdodCBiZSBzb21lIG90aGVy
IHNvbHV0aW9ucyB0byBhdm9pZCBzd2FwcGluZyBvdXQgdGhlIHBlci1vcGVyYXRpb24NCnN0YXRl
Li4uLiBOb3Qgc3VyZS4NCg0KPiANCj4gPiBUaGUgaG9zdCB3b3VsZCBwcm9iYWJseSBuZWVkIHRv
IGJlIGludm9sdmVkIGluIHVubWFwcGluZyB0aGUgcGFnZSBmcm9tIHRoZQ0KPiA+IFMtRVBUIHdo
aWxlIGluIHVzZSB0b28sIHNpbmNlIGl0IHdvdWxkIG5lZWQgYSBUTEIgZmx1c2ggb24gZWFjaCB2
Q1BVLg0KPiA+IE90aGVyd2lzZSB0aGUgZ3Vlc3QgY291bGQgc2VlIHRoZSBpbnRlcm1lZGlhdGUg
bWVtb3J5IG9mIHRoZSBvcGVyYXRpb24uDQo+IA0KPiBEbyB3ZSBjYXJlP8KgIEkgd2FzIGFuZCBh
bSBhc3N1bWluZyAibm8iLsKgIFVubGVzcyB0aGVyZSBpcyBzZW5zaXRpdmUgVERYLU1vZHVsZQ0K
PiBkYXRhIHRoYXQgbmVlZHMgdG8gYmUgc2F2ZWQsIGl0J3MgYWdhaW4gb24gdGhlIGd1ZXN0IG5v
dCB0byByZWFkIGhhbGYtYmFrZWQNCj4gZGF0YS4NCg0KSXQgaXMgYmFzaWNhbGx5IGFza2luZyB3
aGV0aGVyIHRoZSBleHRlbnNpb24gb3BlcmF0aW9uIHdvdWxkIHVzZSBzYXZlIHN0YXRlIGFyZWEN
Cm1hcHBlZCB3aXRoIHRoZSBndWVzdHMga2V5aWQgb3IgdGhlIFREWCBtb2R1bGVzIGtleWlkLg0K
DQpUaGlzIHF1b3Rpbmcgb3BlcmF0aW9uIGlzIHdvcmtpbmcgd2l0aCBzZWNyZXQga2V5cywgc28g
SSBkb24ndCB0aGluayB3ZSBjYW4gbGV0DQp0aGUgZ3Vlc3QgbW9kaWZ5IG9yIHNlZSB0aGUgbWVt
b3J5LiBUaGluayB0cnlpbmcgdG8gZG8gYSBzZWNyZXQgb3BlcmF0aW9uIHdoaWxlDQp0aGUgZ3Vl
c3QgY291bGQgaW50ZXJydXB0IGl0IGFuZCBsb29rIGF0IHRoZSByZWdpc3RlcnMuDQo=
