Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493C470121;
	Wed, 23 Sep 2026 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173556; cv=fail; b=CRg+gwEAB7vjChcb82kEaTAGlNJePlxWsM+SCBQcdh2OcsjqNyfFtCSUUaL80C20Z7o8pUXTyQXJEfd1Nd9q8DEN46BaR8Kb0Iyqt5ZT7KaAnEx90LAq9svWvuTdcrgTtZzJuYFcATNTDVTLU0/baZa6lwZxZwAW/Vo3Rd3/Ct4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173556; c=relaxed/simple;
	bh=kuDjE/QrLwkGaJ4orabnPILeuWpqz/FqHc80V1p2yGQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UFNHq6z44GndpEWS6pDSTg4GsYrOV2KxNvemO8MPwwSOjoZW68JV7SDyVBH5rY/pO5+oell90POBqONGqm4KNQ5eqKbLC+JwdoQve+22ljADTMA4D9WbH6Cp3SFWAP6DpxU2WmO4+5b2FR5crGWJ6UuIJ9LeDrL+p0BtJR8GL4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqOx8Nx+; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqOx8Nx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790173554; x=1821709554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kuDjE/QrLwkGaJ4orabnPILeuWpqz/FqHc80V1p2yGQ=;
  b=UqOx8Nx+EdwZ19mcxiHBX5W4jmsgK5x2xg3sNc15YK5TtyBTJl36Hnge
   DcB6Y73/WuoR2TG0gL0zhjbqVa6pWv9NpQflzWL5CHuKXkRzP4jCdOJUS
   HvtCnVNEbFF/8q+BIkrbXxUgrxWkEd+Z6IMApkn8VUsEGX3v9fMy+Z0D5
   D8cHzjbmxdtTVODaLqg7IfeZqV7yKhBX2PaawQs+O1fo2qEr21N5WxyRV
   mnFTqcB7SN0MypNcYpjYt04eGyOBD1NyXgumYtnlR7dYIhSllawdqGyyL
   L1FdKjxqhT83jO1tgqYwRkniBTrtPLZ3UFYxZ/4znIw8/kJyEBWA/r4Vi
   g==;
X-CSE-ConnectionGUID: PfNQm5C3TJigEfVhr4EyBw==
X-CSE-MsgGUID: 4p2dobLxQWy6VPP3un+Rzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="93373403"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="93373403"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 07:25:53 -0700
X-CSE-ConnectionGUID: 0skt/PRXRYCL4FCC5vvzDg==
X-CSE-MsgGUID: w6sS6CjuQIuHTAM+fm+R/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="273108993"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 07:25:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 07:25:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 07:25:53 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 07:25:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3JxU3xDemMawpN4VyPqsvV1qGoB7oIM2PnYlJRpaQ9Xrp4Ougv0txvBTFvN6HvzhJQYYpGYFe0U2VikJsMUxOTPsw5UbRlW6miTIcOLwOP0v6GV/fOblJuWnIGmroLoWwsqWm9xqd76c6HQPz+1SCUHD5g21NuZNyQZd68CvdmsE+QETW0xAcUDuh9BTal0LK7y25p5XL1zhrOeLHoPDj0+BMKd4D9AYrBZA0iWQK0WODY9MIA6mxsDlsEroL1Q0C867qOq/hTgfiinucgQ89fLrIOONHmYserk/g1y4U3vszNhNaX6stIQgHxnAvCgMDq+3l8Ggz9JI+dS3V3B1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuDjE/QrLwkGaJ4orabnPILeuWpqz/FqHc80V1p2yGQ=;
 b=j11Xh1YGt28jVMwGEj9LOiF/G2dqoWFO3JQyCG0fPzLq0EwbTaqed4qT8l6IpMcsvKNf6RsjGKE0mlpugGkoM9c+iAMEmn+D0vVVlXeLjpVnjt6ZrpB8eA34ptKIfY0nWHry1gQUKO8g9aXe5c+zPr0DGRl+L0HwdczMgsu8tofpQH9f+aRWvkJHYzX4ot6AJ4SccXNdGeSn3yQB+eD7IV92hEDX+CeyjVMFg1cZkF75bwo23bULLzxlKirXneeh722woMV34P7idg3HN14ibSOd3A6WFl5xF+45qrQuYHQU3NHNmyiftcptHjIsEcD+N15O944UWE+eWwzojVG8xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ0PR11MB5895.namprd11.prod.outlook.com (2603:10b6:a03:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 14:25:49 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:25:49 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Maloor, Kishen" <kishen.maloor@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"dedekind1@gmail.com" <dedekind1@gmail.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
Thread-Topic: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed
 by KVM
Thread-Index: AQHdRnUxZ7ir+OFvoU2rBazg3q+3u7bbUJEAgAADgoCAAAiJAIAAA3OAgAADVACAAAIvgIAAqPoAgAAzZAA=
Date: Wed, 23 Sep 2026 14:25:49 +0000
Message-ID: <a085134ba1e80e04ec5737dffaadd5abeb8c6d68.camel@intel.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
	 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
	 <a8ce5d830a04d99ec47cdc727e1761bd4031d544.camel@intel.com>
	 <5ff81fc4-d144-4b2b-8375-d2f63e0dd618@linux.intel.com>
	 <419b23f264af219da3be93a9d246b5401bbbaf13.camel@intel.com>
	 <a436a059-b003-4e84-bd11-014bf2f17e97@linux.intel.com>
	 <5168e058946a61f3be1cdb13f886dd632739d312.camel@intel.com>
	 <ddba739a-b4b5-4c0f-84f1-803857f34179@linux.intel.com>
	 <2cc4bbc3-11d3-48bd-9a9b-a9659fc101a1@intel.com>
In-Reply-To: <2cc4bbc3-11d3-48bd-9a9b-a9659fc101a1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ0PR11MB5895:EE_
x-ms-office365-filtering-correlation-id: b80a4c04-b122-42ea-68ad-08df197e90ab
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: fxvC0vs/g2mRQac3MZcW9K0ttEpaWlryeeFASGmKS5P7W5W+9NqIOpcIc0JFJcmfvzeQen3WwSNwOJ0g+ec/0oIDK+BgpyhXAR57FMNnnxmpvzi83irGjerYovJcxSVyAgWLqnTb4l6xoS8Fp6WoCLR5I+fasV+Ur4mLEyhOgYIH8DHl+i11kejydXYsFtT+V2Hh15IXLmUyk5wfTxwR3oEhDobprt448/xFmkQTJ4OVoRl8uJCBRudkzyIumagZONLuIGYhSVjagXhiiAhGH4NXjGrfHExY5SurcLVOiJpCDvWBrG/C+p0jU9eE4exE9NBUujRLg6tFWVyuchURR8crWfqiiKFC0vVC8PpCyUPcxqybvLhu63uGbNE9D2TNwWHc9/QrrlSO42gH44JCOyoNxsiEDt/yWs6FpCrupCU4YYMDpz0IaalBY+dlGPOh7iu/9s+J1KhXkJuoX60OsGklurfY7YkP9S8k3MQ7R8dOdX/mPGSBlvxl77+QbOmpWPWiHvTgeHvQHHVMyu8XrhLzKBrLxjEqnKjB3CJu2LIRp9KtiVrXUg0q5ePhn521kocFsULGliyzrD6SFhVk8mo6+SY4g6Ebtc32z61NqK6Y//xF10QdP81cJjVcebGoY+1/Mdjyf5A+cAupxHXYckzcagJJObrfO9S1XZxePkkrg7CQgI7amWbKhAMb4fRyG5e1NuFyqSsmFo+zTSQ5NAdzikJvNxtu5QrSJxAA9Mg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTFuV05SUWJIOXBnT1MrVEhTQ3VPbktnN3dsM2tBQ2diZzZsRGZHUjBZWVVL?=
 =?utf-8?B?cWdjSnRmVHBkaHdoRytXbkw3NG95N1RTZGxwMDJEbyt1V3h3WnM4T1UwZmhl?=
 =?utf-8?B?bHZlUTc1ajl4NmZ3WWhUb2J3aFhTL1hnSDNHbzFCeFJ1QW5XNFcvaW8ycEJ5?=
 =?utf-8?B?THBJZG5YcFpocnM4RGdYTmRZR2VmNzNobFNYU1RtclZCTFhuQUROWHlCc0Zk?=
 =?utf-8?B?Wm51UjljeUNKZWwrNmpuTUhpblZDRnJPN1IzdUovR0dQNUFuNU45RHZoZFpk?=
 =?utf-8?B?V1grME1rRjhXL21hWW1ENVpBM29Id3lPN1dlTkxYOVFVZ2IzRkxnbzgwMHpp?=
 =?utf-8?B?TFpLZ2JTT1h4ZElLbWlmRzNYNjNQeXZSdnJYZkhLMlUwM0Mzd2d5ZWkrYVpm?=
 =?utf-8?B?ZGF6L3d4cHkwWVQ2eHVaUDd5WFJhWU9LSkQ3WlBjcjZ0M0xSZ1dkcTI1VHJK?=
 =?utf-8?B?aDBGa1dwMGx4dGVRS2QrSXhjODQ5aUxsSjUzdElFazM0WHhmNUlMZmx1T1dt?=
 =?utf-8?B?VmpJUTFEUkY1RHNQYW1rVDZoOUpLbEt6T2w4YTJCOEZaTzRMN09rOXZnMit2?=
 =?utf-8?B?anV3M2dPQm15VHF1MFdDcEM0b1ZLLzhqQi8zYlR4bElYOGdOSHdSbFVOdzV5?=
 =?utf-8?B?QzJ0TjVuR25lQ1lHSVkxQ2pxSHNIMWh0bXJsMnJRZlBuVnI4d3p4ZmV3WmNJ?=
 =?utf-8?B?UmlFUW0yNmR5TUFaK2V5OENaTU1lNzVNdzJMYlVzcFllYzRNMHVSMnFVNFNy?=
 =?utf-8?B?WkZ5VEw0MVY3VHFFYlplMHdkSVJVczMvNzBWRWNBd3doUkQ0b3B2SzAyQUds?=
 =?utf-8?B?UThjRDdkaUFkRDdibWZTS1BialBNK1JGN3dSSGJhd2NWdG5ZWXVHWG40Wkwy?=
 =?utf-8?B?cW9mamdYem5oZjVNMFlSVEhyYjB6WWR5S3pqcnczaWhCZnNzNFlzZkhiWFlJ?=
 =?utf-8?B?NmdMaG4rM2dNYk5FRE5Uc2c0dWwySHVZSERXSWI0OTBWQUJxNVBTc2gwZkxy?=
 =?utf-8?B?WDJ5c2VBYnVuUURRNlhNZzhyZ1JiUFROSUNKclpnTjdYSEExdkpRVWpXaTRP?=
 =?utf-8?B?NGlMS1dKYmtQbzFRVnp6ZloyNGJRMWNWSmwrSVlWQklueEJhV3FMR2hOOUN6?=
 =?utf-8?B?SjVDYWpzTVlhS0F4Nk5wd20wakViMExqRnZ2VjFram5CWTYzNlRXdlZDTUF4?=
 =?utf-8?B?MzhBc1dOSzFCWkh3R1hmL3ZGcnpXd2ZlZ0VSckVSZlY2UVgyRUxMV2JXQ0oz?=
 =?utf-8?B?U0NZVEtMNXljeDFnV3FNd2lCR3AvVDhYdTM1dFFKWWFJNk90TkxkZEhqNU5T?=
 =?utf-8?B?Qm5qbnZCMHJKQlJ0S3ZFdlZRa3dhZEd2THRWczFSNkM5NTVaWTRIc0N6amNY?=
 =?utf-8?B?U0ZmZ0NWb0l3ZHZBdmEzSExRN2NzVW5YZDNiYTVNQSsrWjNJWFZEREcvTXJK?=
 =?utf-8?B?MmJRVjNzNW8vUE45M1JWcmZSNktOVkEzRnQydFdtRTBIbUErU2QvU2JtYmZi?=
 =?utf-8?B?TDRhalVOWWhybWdSSE9aRHAySWQ0QmNyYW5lR3FhWGx1czAwMm1oK0RrWnRq?=
 =?utf-8?B?aCt0YXNCRHdhcjk5ckVQWXFoNW5JY2xTazdycG5GL3VtRWU4QXZiVkQ3Wjhv?=
 =?utf-8?B?NlpYd3BCeExQSkI4eS9rS2tORmp4TkVzUXovcCtjZkpmRk5McCtVbnhsdXcv?=
 =?utf-8?B?M0tzVVMzM0RuMmxFdkdNOGtnMVVWSncxYlg1Q2t2UCtxaCt6QVh3ZDZCYjZy?=
 =?utf-8?B?cmNVSFNQL2JOdGJ6ZVJNaTBlUW9HYVNIMjNTaXZIZ0drWlVaQXNZL0hhbnNG?=
 =?utf-8?B?MW5VcTVPSzNzWktrNjVrZ1o0ZStkMlJUMVphYmdRSWErUE9VUElGZy9HcUhL?=
 =?utf-8?B?TkxJM0hBenRWUlREbWxiZ3Q1TUpsNHV6Mnpsa3RiMkJpYldSUXRvNEEzdjd4?=
 =?utf-8?B?VVN5SENWMFA1dUNDa0F6aVJQcndtSDdUVmtaWGZjS2VTcjVMcmFneWZKcER2?=
 =?utf-8?B?N3BoZnd3YjVmWWovTHFoclBJaVhtUGtNMnJZalpqdWgyY0lEdDRYVk9XRDBl?=
 =?utf-8?B?UGsyOThtVXYvaDNPYVRBT1I1MHFvZVZRY0luUUs4bE5CeHZyUnM2ODVyV2Jw?=
 =?utf-8?B?VTRESEJ0L0t2QSsrb1pzWFQ5YjBvOVhaYy9zcmJSNEI2N2N0UXozcXk2RU5O?=
 =?utf-8?B?dENvV0JSRzdJbkJiSkNIVVFQbkdTYkRWVG1KT2tENitqTDd1WTNsMW05bWp0?=
 =?utf-8?B?UkNWN3djS2N4UmtSemloY2xsK0gyaDBXdVV1elNVL0p5aG9yQ3crcGxDbU5T?=
 =?utf-8?B?RE5yV2IrRVZDZVNxdHJncG5mK1BrbXE0bGFKTXlRVm5zR1hFR1BwcitoOEdy?=
 =?utf-8?Q?iNXl6KMuRQgDF2Cw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0B669F28AA19C4EB40BBF807A9AB46F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pLum+OMO/4Lh1pH6g4PP3d4iDaEfyOUF0ZTDzoR/oD3CuB6wfzFS2QMWFwr7pIkjv8ySYL7qwOe3sblQ9d4X4YV8AncnnQLiiZT8p37tUzw85rJDup+1KTukbUVvM7ZlmsH/E2ERrVBdCK98UCOFE0GE1Vs+N/HPRUJ50NqYm8UWkzVJfLpbIJ6Ore592zW/rywOXTXqZEHAUpqckST8cIYWDTPcWN6+/C/pfgvjjDCSQQVRn3lYP/6D7UxuHIB50e2pxgQkzb0uuZ/bm4BkJ1BAFUoIScM/pyZ5iX3l/UIuoxUqNODPlK38wFo6sLeeNeAFG3ButtWpc5F7K0vMrA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80a4c04-b122-42ea-68ad-08df197e90ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 14:25:49.3119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TIyOVpNMjq9bbcC92Xz9WtYxS3psODR0guNovXV/EzKInIMaBFChPyT+8JvaF6Wk79bJIeVsJ2xno6LXyuHCEz6N0NP2o2IlLqJH12R4TxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5895
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDE5OjIxICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiA+
IEJ1dCB1c2Vyc3BhY2UgZG9lc24ndCBrbm93IHRoZXNlIGJpdHMgYXJlIG5vdCBzdXBwb3J0ZWQg
YnkgVERYIG1vZHVsZSBhbmQNCj4gPiBLVk0uIElmIEtWTSByZXBvcnQgdGhlbSBhcyBzdXBwb3J0
ZWQsIGFuZCBpdCBjYXVzZXMgcHJvYmxlbXMsIHdlIGNhbm5vdCBzYXkNCj4gPiBpdCdzIHVzZXJz
cGFjZSdzIGZhdWx0Lg0KPiANCj4gSXQgc291bmRzIGxpa2UgYSBidWcgZml4IHRvIGV4aXN0aW5n
IEtWTSBiZWhhdmlvci4NCj4gDQo+IEN1cnJlbnQgS1ZNIGRvZXNuJ3QgYWxsb3cgSExFL1JUTS9X
QUlUUEtHIGJlY2F1c2UgaXQgbWlnaHQgY2F1c2UgYmFkIGVmZmVjdCBvbg0KPiB0aGUgaG9zdC4g
QnV0IGZvciB0aG9zZSAjVkUgcmVsYXRlZCwgdGhvdWdoIEtWTSBkb2Vzbid0IHN1cHBvcnQgdmly
dHVhbGl6aW5nDQo+IHRoZSBmZWF0dXJlcywgaXQgZG9lc24ndCBjYXVzZSBhbnkgaGFybSB0byB0
aGUgaG9zdCB3aGVuIEtWTSBhbGxvd3MgdGhlbSB0byBiZQ0KPiBjb25maWd1cmVkIHRvIFREcy4g
SXQgb25seSBjYXVzZXMgcHJvYmxlbXMgdG8gVERzLg0KPiANCj4gRm9yIG5vcm1hbCBWTXMsIEtW
TV9HRVRfU1VQUE9SVEVEX0NQVUlEIGFuZCBvdGhlciBLVk0gQ0FQcyBzZXJ2ZSBhcyB0aGUNCj4g
aW50ZXJmYWNlIHRvIHJlcG9ydCB0byB1c2Vyc3BhY2UgaWYgYSBmZWF0dXJlIGlzIHN1cHBvcnQg
b3Igbm90LiBJZiB1c2Vyc3BhY2UNCj4gZXhwb3NlcyBhIGZlYXR1cmUgdG8gZ3Vlc3Qgd2hlbiBL
Vk0gcmVwb3J0cyB0aGUgZmVhdHVyZSBpcyBub3Qgc3VwcG9ydGVkLCBhbmQNCj4gaXQgY2F1c2Vz
IHByb2JsZW0gdG8gZ3Vlc3RzLCB3ZSBjYW4gc2F5IGl0J3MgdXNlcnNwYWNlJ3MgZmF1bHQuDQoN
Clllcy4NCg0KPiAgQnV0IGZvciBURFgsDQo+IHRoZXJlIGlzIG5vdCBpbnRlcmZhY2UgdG8gcmVw
b3J0IEtWTSdzIHN1cHBvcnQgY2FwYWJpbGl0aWVzLiBBZnRlciB0aGlzDQo+IHNlcmllcywgS1ZN
X1REWF9DQVBBQklMSVRJRVMgY2FuIHNlcnZlIGFzIHRoZSBpbnRlcmZhY2UuIFNvIGl0IGxvb2tz
IGxpa2UgYQ0KPiBidWcgZml4IHRvIG1lLg0KDQpLVk0gbmVlZHMgdG8gc3VwcG9ydCBhbGwgdGhl
IGJpdHMgdGhhdCBhcmUgMSBpbiB0aGUgVEQuIEVpdGhlciBkaXJlY3RseQ0KY29uZmlndXJhYmxl
IG9yIGZpeGVkLTEgb3Igd2hhdGV2ZXIuIFVzZXJzcGFjZSBkb2Vzbid0IGZpbmQgb3V0IHdoaWNo
IGJpdHMgdGhlc2UNCmFyZSB1bnRpbCBpdCBkb2VzIHRoZSBLVk1fVERYX0dFVF9DUFVJRCwgYXQg
d2hpY2ggcG9pbnQgaXQgZmluZHMgb3V0IHRoZQ0KInN1cHBvcnQiIGluIGEgaGVhdnkgaGFuZGVk
IHdheS4gU28gSSB0aGluayB1c2Vyc3BhY2UgZG9lcyBsZWFybiBldmVyeXRoaW5nIGl0DQpuZWVk
cyBhbHJlYWR5LiBBbmQgYXMgbG9uZyB3ZSBkb24ndCBoYXZlIG5ldyBmaXhlZC0xIGJpdHMsIHdl
IHdpbGwgYXZvaWQgS1ZNDQpiZWluZyBmb3JjZWQgdG8gc3VwcG9ydCB0aGluZ3MgdG9vIGVhcmx5
Lg0KDQpFeGNlcHQgZm9yIGV4cG9zaW5nIFREIEtWTSBQViBiaXQgc3VwcG9ydCwgd2hpY2ggd2Ug
YWxyZWFkeSB0YWxrZWQgYWJvdXQgZG9pbmcNCmFzIGZvbGxvdyBvbi4NCg0KDQo=
