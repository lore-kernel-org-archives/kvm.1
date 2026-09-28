Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23411369D5E;
	Mon, 28 Sep 2026 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622800; cv=fail; b=KRfh9fC60lBR15wmJ/92e/HDlefeSHSktxJlqCyXlpFCjtfaF1ngiohspwOeOOSofwDJ5TxPZkkq23nwWHAqjN4bMzr5ilos3ZU46lNIyB2P+28l6ysZ4s0xy6P9q7ww+aAUbtmmiHgHgO0LS6fh0NTeOYVUvxDYyqS4w4xkGYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622800; c=relaxed/simple;
	bh=aDk3W2nBVDib54pCEuKWdqlbtwGRrdaT5wOusGmgzwo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JbzpuO1JHaqLbsiaIm6DZVemqvNWDggcHFkyx8y7pk1tqYS5Tz5vuG4iG9iNlHpJss//46LsJ05ElCgaDifUqyoQE4jK4gbdQIQA2+ZpfT7vKRjT2oWk+CygYDNrlJMGQBQ6ZQljNugo7k8eKLh3twMOWS2TCc4D9iKJaeD65DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qo4dvWmR; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qo4dvWmR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790622798; x=1822158798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aDk3W2nBVDib54pCEuKWdqlbtwGRrdaT5wOusGmgzwo=;
  b=Qo4dvWmRBFXtrzwHFTTjzCUuFQDog9+9v4DlySiPz18dSoCHTiq02cpH
   X21DFLCMaDCOVjHtzbEcmW0ztfqzPQmlaYZxlecyiBB38XeKx88fiubGq
   UZlylSry7XtZpwyihMplocgztub8hRhfkJJr4+M3kn/oKFktXsyXuRI7n
   Y3BIO4wkeYTjC+tpDQzIkstezDl2Ijpo6szP255bJsGRx0mb55RMSYgH+
   PQIk3MmttoXPcSUW8CDQbnm0PyKhaEg5xgF5id1trYdbRIVSzMpdfC5bV
   apex6oUXFCLGaeMla7kcG+GZ01rP6R+NGwwncK5+OzlEc7mNHlVxixmLp
   w==;
X-CSE-ConnectionGUID: yBxOk6/lQi+n8MaeLIQwog==
X-CSE-MsgGUID: wsV5chLXSNu9U+ajRoGIsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="94046982"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="94046982"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 12:13:18 -0700
X-CSE-ConnectionGUID: oy1vFzfRR52BsF3ZGyEzDw==
X-CSE-MsgGUID: LbjO5dZdTle5jnosMb9BBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="274646729"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 12:13:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 12:13:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 12:13:17 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 12:13:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jV9ZBCS0UCVzErk+2hA1r19mmm4LPCa/m9NqSHPZqW6SAW+4Cv+DA8Kix8piA1WPEKs2sNRCR0WDoggMKmcuzhNYuiy6orxcJKyLMmK/GF2iJEi7DW7LPxVW4FcjYwLXfg6zbaKVqvdI071eyye9cfVwcTSbagib7RGJPsJCWY9kT2SinaykkkMyucJFPB05lrXwlTRoiq3/CN5G7S/zriJf90K1iDCmqbAHdIlHOcgUv2Ym/T9u7ivnNLXLwJalVmdBgV/kwhREqZFZO+VmNjsvU4aA807jwefZb2fx5jOy6dMz1TfKOwVrRs4EDkHyNkqD7aitGeOAepnk/3rknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDk3W2nBVDib54pCEuKWdqlbtwGRrdaT5wOusGmgzwo=;
 b=FH+204seACFHepUizEnoMhG1Ada9QiL/l6LSCR/Ug+CVGI7Nvl0uENQVSlOxJby9KfrwuV0xba6Ya4yyqGALGXu7gERxmshaxPdx0JwgMmGC6d0INGMRux3poeM3NzMh9AjdRKETTaCkGdJ3xugS0k3AMdqySRL2NPzjATN3JAUAwmqlF+Q5gaHbAP1AiPkgpC4Koe6kkFaBNUjSXAb+l1fpuIpDgVYJh2+g2jj2qIDQ8SbqYkpOChRQidcNCH1yAisbtD3S7BHXju1uhM5DZo1TaNW19MqY8sY3VnalqJ1wJ6nKjFL7fU40YJZ8MYAkHhXiBv3G84Yj1W0G0cLgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ0PR11MB7156.namprd11.prod.outlook.com (2603:10b6:a03:48d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 19:13:12 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 19:13:12 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>, "Fang, Peter"
	<peter.fang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v5 4/6] virt: tdx-guest: Add a helper for the Quote buffer
 size
Thread-Topic: [PATCH v5 4/6] virt: tdx-guest: Add a helper for the Quote
 buffer size
Thread-Index: AQHdTzGrpyv2GJzwpkGpI0tjfVPUWLbkKiCAgAAySoA=
Date: Mon, 28 Sep 2026 19:13:12 +0000
Message-ID: <42975a72efc3a0f96200c065cb86970e8f452625.camel@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
	 <20260928100913.2265687-5-peter.fang@intel.com>
	 <0c6bc71f-53fb-4240-83a3-c52d090044d3@intel.com>
In-Reply-To: <0c6bc71f-53fb-4240-83a3-c52d090044d3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ0PR11MB7156:EE_
x-ms-office365-filtering-correlation-id: 54bda66c-0d11-4835-991b-08df1d948a45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: 2TRDybnBTyXpY+eSIxdsS1C2yrpuhqjZ+IcmQeS9s5ttjJuwfmPEs8qM7g0kUMobfgNlhfBrA60lsH4m2Grildr8FcUPMQUsw58vwGSt53u981VsdWOlCWytRIR5W4pPkc3LO0MtRPvo1jgAZN3GRK4UQrm2Xnv6r5NDJansE1Ia75UiSZfRobYBLjv2PUbEhzoxQ1dcbxGKexp9fO57QSO6ar/d6Pq6jGQybwGHU3H4XY2GmJmvKWP2Q0CClwoaAzsn2u+tLRBych0K+RYMcSO+4WHlX285xpwxUaVPQQuErXCT1nRk1UmVLYuQQVXTM4bt6vq3DptL/yOlmO2uBQb4lWIOVEimE//IbpqLeGw3YDbs5quVFlelizLDQPRy5zHnzsQnIMwtk1QoBJBPl0iLHfpBGNJTyp12bWh8+bWdwMNvWIs0iRTpa/M6KeQZ+wm1ij1dXAkqUSUGwZ0q6HEv5J0nNIu/fwYTXLTHN5eBX2NObgGk4uiPr0ymublVCZrcvslcRT6BiJaQB6GCB9cijQD8DdYTPn8PbJ98/FCQP/e+GnM3F0YzJel54gPlWKTo8Z8SYR8BN97BEeh+rlfP8vJBNmIrhfayeQvOA5+F/uXnhb0a9E07VfQdpsv+uWqKLGQuP2FUK0wER5Wknx82H90lVGzVkwnkPxOWt19xJa0BYW1SMtEHqjNNDAGknSvU3uZw+95qfF8VcqzOhzxVvbr86z6Qe6ghxhk15ic=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGREZ3dsVjhpYk9VWnovSlFvYko1aEFCWWJHdXltTEF5Uk5BZEQybXRTWlNT?=
 =?utf-8?B?T21lODl1aS91WXU2YXNpa0djVTVuL2V2VlR0Ym03V0VDVkpiZjcxUUV2clZQ?=
 =?utf-8?B?ODhlWEF6QlF0SjB6elJGemJNWWFVZjRWN2gvSUxnS1d1eHJuSURTU21BSXBG?=
 =?utf-8?B?Zi9VL2E3UE9lYWdyRnQ1WmRpd2szaUVFSmNkdHYrcWRDcW5ybU5oRm9kaWRB?=
 =?utf-8?B?d29RVkU5bnpLRzNFeDNEOHZkZVc3SU9aSkEzREN1dlFhT3dmU1JwRUFsU3Ba?=
 =?utf-8?B?dzhkZlBCRmdwK0wwZEtKYm9iNy9RZ0gxOXRDWmowckdLSGxkcEtJWGpNaWZH?=
 =?utf-8?B?cnlJZzl0dHljMU1pM0h3RDk0cVFsV3NicllKamZManJRNThFcnpIZ25BVkxH?=
 =?utf-8?B?c1BtbHlUZE4zS3poaTlZVFNGTFkydk1xT0ZaYWxjNkV5U09RZEpzY1lyN05X?=
 =?utf-8?B?T3gzbEJaZ0F4KzhrZVlQM2x1MnJGS1BYOW1WWmV1K2hiclYwZHgzeEI3Nk00?=
 =?utf-8?B?UUJTbUE0cEZSWTdaR3lvN0NZcWJXMnl0cjZ6U1N2RkdBRkpxcmlRRTFLby9K?=
 =?utf-8?B?SlJ0WWFkRlBtTDFnRTFPZ3dFS2s2U1ZCbENwa3ZSQXgvc1RBLzRzOThPTEpL?=
 =?utf-8?B?clo2VURvay9EckZGa0grOWY3dllvMDRHVElzN0V4NU93bEMwNXZZUEE1eGc5?=
 =?utf-8?B?bWlESjZ6elhldzdrS09GaWRxWk5hYXJEZ05UYS81bWJTOXNNM0Z6Tmc3U0hi?=
 =?utf-8?B?M2wvYy9vdWJDb0VqS0JWVXM1elcvb3lxNlJYcHJnOUxJQ1I4OG1sUnJFa3pP?=
 =?utf-8?B?T0I0L1NvR2ZrTk4yTlg0S2JTbTI3aDBtSkhZNndIc2dZRmlTUS9yWVM0ektE?=
 =?utf-8?B?VE5IZ05nRVlhbkxaYXVjWi91aXhSdHhMUDY2M0dxOG1vT284Yk5HMFVSOVRs?=
 =?utf-8?B?WURQcmJTYWpBZnRoQmxYdEcxUCs5N1FEeTQ0bFYwUmNBOVdhYjJXNUNOYnM1?=
 =?utf-8?B?WS8zUHJIWkIyaEEvVjE1dzhSaUhHek1ybkgza3VKM3NodTE2elhHc3BDNWZQ?=
 =?utf-8?B?a0c5N2tIRk1kQWt6cHl3KzRpYTJ0c0xQMTBIWjRtS0F1aW55dVJ3OHhsNy92?=
 =?utf-8?B?Szc0dVpjTnpadEdLelNldlg5aEF5NmVRMGcvNWJwQnNQRTdzT08zeDc3b2dz?=
 =?utf-8?B?cUVueGtpRnFoa25CdHhMSTlIcWswZlFud0l3SzhPMmhyS0JWQjNqcnBBdVp1?=
 =?utf-8?B?T3pRNzE3OG0rVGdMZ2xIbE56NVdvM3JyN0xmeVFzRXhIUGxQU3BadEYwRmc4?=
 =?utf-8?B?SlB1bldrVGFMQjQ1KzVpOWpDOGxBcStNL2M2bTBxM3FmcVFscGhNM2pvVWtC?=
 =?utf-8?B?OUEwWmVjVHlrejlvM01EOS9YNGlKWEI1bHI3dDhDVVBmVEc3Sk4rQ05TNVJY?=
 =?utf-8?B?azlLeWtJMlNMajZ5ZzlnbkFvOXR0djIxdDllOTR5ZUVuajdsTzJyZWNRdkY1?=
 =?utf-8?B?WDVqYUhJcTQrVjBUQnViMjdBczVldG1MRFB0bnRUeHQrV2hvMFpOM2pkRUdQ?=
 =?utf-8?B?NXhmR3QxVE9OTEFuODhxVnMzNDJuSHBEYUQ4d2R1ZkZucnp6WmR4SWR1SUpu?=
 =?utf-8?B?bDNJKzdzREt6dENhNk5vZkFtUk1EMTkveVJCYUdrK3NnWklVWE1sY0hIUTRN?=
 =?utf-8?B?Q250Z0loR0ZSYnFvQnpTa2V3NGZUa2xWdkxDQ1Y5YXZEYkNjK3F2d1JzWjhq?=
 =?utf-8?B?VjlyYmN1czlqaUhTQkVNV0hUOTNYallSVVpsR3p5N1pSMWtBRFArWmR6bmFl?=
 =?utf-8?B?MHgrU09vaXdNTFlpYS9uSjM1dzh3dS9OSHA5YjE2RlhRVHJTQVFEQzR5bUVL?=
 =?utf-8?B?NHBXaUloMXBzSkFMaTFXeGRtU0dVRFlMalFvTC9Icm85Vi9NMDFFVEhQcUFV?=
 =?utf-8?B?SHFtekFxeFpGQ2RDNGVHTnp4VUNyV1c1Qi9IR0FkZXJ1b21yQThFODUrcHp3?=
 =?utf-8?B?aTg1a1Q1MUtMMDRmdDZrY1RieW5RMFJidWZsUVBMdSt6UFFtdU1mTWZBM01m?=
 =?utf-8?B?M1d4OE1IaVM2RERJamxJckZRcGFFbW1mTjN0dzVKZGlReHMvVko0TFhKUlRr?=
 =?utf-8?B?RGZzWlFRK2U3OGhJT3dUSXJPWjh4bUN5WVdNei9GaXZ3SjdwNVFUZkFKYmlW?=
 =?utf-8?B?SkFZTnRNSDhiRFdCZ2pQajJmU3UzMVNxWWVzYXJubHE2SjdaTmtTaHhQKzIr?=
 =?utf-8?B?Wmtud0NvL0xTT2tKaFpMNnVwM2ltZVhvak5GN1p3YnJ5YUEvU1BEakdtWGJ5?=
 =?utf-8?B?R0lQZUMvbFlMU1czSE8zTUlrYk9nMk5uYXJXUHk3dXlkbzlrd1NoU2hBL29C?=
 =?utf-8?Q?RmdsCiUl4bBniswI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB20201C5EBA544E8CE79A63E8D50AC2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fVUYNWfsZPPyWNEXlKRjRJqMwaR+f+aj7YAEQ9xAgzwpl1BOacuKXDKYrSAGXOE5cZHRncTvNgwCRzI5g/mAyrg96gjGVpcAG+nXR5LYUANsgtpdV3c5EfHiiAfH4yaCT3W4gCDnzZ7Eho1k5rGRYFmywWgtCi9kYkGnVNn/SbWDzs95yBYkSSQY6msYikD7B9kfJA+GIpE3qoW5Y3pmwQeQAcoAOn29Vt0jnAPhQGFIJt8gzdJqKOh80CV5i2ACvHle7hWm8Gf1V+SPfn2Zen/GWquH0Lrt3x48xnfnshuPfL+ikldcQX7sYjiqxfPaeta0EefGcuj4iTD9912JEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bda66c-0d11-4835-991b-08df1d948a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 19:13:12.1650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qWVRQQBeU86HPa4yhG8KiET6rXtATePTMLt5L8zQ5EmriXuqaAhS5oagrGzpb3MsBCOIcXFbFRKUjjVjh/bX+Z2P6KKU0rKeLaDZB4RcEwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7156
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDA5OjEzIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
UGxlYXNlIGV4cGxhaW4gdGhlIGdvYWwgb2YgdGhpcyBmdW5jdGlvbi4gV2h5IGlzIGl0IGRvaW5n
IHdoYXQgaXQgaXMNCj4gZG9pbmc/IFRoaXMgc2hvdWxkIGFsc28gZXhwbGFpbiB3aHkgaXQgaXMg
cGFnZS1hbGlnbmluZyBhbmQgY2FjaGluZyB0aGluZ3MuDQoNCkknbSBub3Qgc3VyZSBpdCBhY3R1
YWxseSBuZWVkcyB0byBiZS4gSXQgc2hvcnRlbnMgdGhlIG1hdGggaW4gdGhlIHBsYWNlcyB3aGVy
ZQ0KaXQgbmVlZHMgdG8gY2FsY3VsYXRlIHRoZSBwYWdlcy4gQW5kIHRoZW4gaW4gdGR4X3JlcG9y
dF9uZXdfbG9ja2VkKCkgaXQgc2tpcHMNCnplcm9pbmcgdGhlIHdob2xlIGJ1ZmZlciAobm90IHN1
cmUgd2h5IHRvIHplcm8gdGhlIGJ1ZmZlciBhY3R1YWxseS4gU2VlbXMgaXQNCmNvdWxkIGp1c3Qg
emVybyB0aGUgc3RydWN0IG1lbWJlcnMsIG9yIG1heWJlIHNraXAgaXQpLg0KDQpCdXQgYWN0dWFs
bHksIHRoaXMgc2VyaWVzIGhhcyBhIGxpdHRsZSBiaXQgb2YgYSBjaGFuZ2UgdGhlcmU/IEJlY2F1
c2UgYWZ0ZXIgdGhpcw0KaGVscGVyIGlzIHVzZWQsIHRoZSB3aG9sZSBwYWdlIGFsaWduZWQgYnVm
ZmVyIGlzIHplcm9lZCByZWdhcmRsZXNzIG9mIHRoZSBxdW90ZQ0Kc2l6ZSBiZWluZyBhbGlnbmVk
LiBUb2RheSB0aGUgY29tcGlsZSB0aW1lIGNvbnN0YW50IGJ1ZmZlciBzaXplIGhhcHBlbnMgdG8g
YmUNCnBhZ2UgYWxpZ25lZCBhbHJlYWR5IHRob3VnaCwgc28gYWN0dWFsbHkgdGhlcmUgaXMgbm8g
Y2hhbmdlLg0KDQpCdXQgc3RpbGwsIGEgbW9yZSBsaW1pdGVkIGNoYW5nZSB3b3VsZCBoYXZlIGdl
dF9xdW90ZV9idWZfc2l6ZSgpIHJldHVybiB0aGUgdW4tDQphbGlnbmVkIHNpemUsIGxpa2UgaG93
IHRoZSBkZWZpbmUgaXMgdHJlYXRlZC4gVGhlbiBsZWF2ZSB0aGUgYWxpZ24gbG9naWMgYWxvbmUN
CmluIHRoZSBjYWxsZXJzLiBBbm90aGVyIHBhdGNoIChub3QgaW4gdGhpcyBzZXJpZXMpIGNvdWxk
IGNoYW5nZSB0aGF0IGFuZCBtYXliZQ0KbWFrZSB0aGUgbWVtc2V0KCkgbGVuZ3RoIGluIHRkeF9y
ZXBvcnRfbmV3X2xvY2tlZCgpIG1ha2UgbW9yZSBzZW5zZS4gSG93IGFib3V0DQppdD8NCg0KSSBn
dWVzcyBpdCBqdXN0IHNlZW1zIGxpa2UgdGhpcyBwYXRjaCBwcmVwcyBmb3IgdGhlIGR5bmFtaWMg
Y2hhbmdlcywgd2hpbGUgb25seQ0KaGFsZndheSBhZGRyZXNzaW5nIHRoZSBhbGlnbiBteXN0ZXJp
ZXMuDQo=
