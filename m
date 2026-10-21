Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792543183;
	b=kTeR7fv28b8Do/KJGTk/9ujAy3oRI0ViKXlr9ZEnOdt6H3lFHgEgGfZ3SBxzQQIP741L
	 95HARXLLuEWmdHDsjY+b3JX92Itbs8QSPNgmRXr48m6f2CcbI8ZzCt1RqjvhNPjHLZcqc
	 +CiDfHMYo5qNahCfdgbfws5nOaZWHhCNJMXZ8gCVqq8TlGBe3Ryy6nxnrYEzcvxbpbtqO
	 LjnWMgTrTS1Kw1VHFDWDV8IHh7PaoK+QzFZJ6EM8PVpYHHi+bGaQEAZL8F2bQYSWF65il
	 dX73Q749wdb+1vBvex5ofikiKOwsRThtyg26WRHJDAE94VWQafX+yW8AGSgoRux9Eew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543183;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=WGcUiVY4jws+B4jp3G4iZ3CxGhFlpq0jCXESu+h8pyw=;
	b=Jnm9j8X0n5UR3+I9M5zbABTvRWS2ovmLpgGVroReNXM15xCLrzx87WU92lQJb60dez8W
	 QDKSuBMbFBzOcOCgwt9je9tihh9IlK9hSE6B8Q5EiXy2VKsMtYDOgb257mUIa9EUvavir
	 rySxCA7/jM+l3D72juqGBBZRs6yItOBXAtx6nSFXRR34uJvyIJQ5hT4pD5ZwaU32Sg5i6
	 UqVgLRTCBtmMM/tTO3YdLqopX3XXKrvpzdRWwH9GV5qZf0GWMwXfQ0Y+3ecfHIdoOgJKS
	 IK4nSBCs6lWLqk0pFJehK1hn3hS7HN61NMTcT1K7G6g3UBiyhA8FcyguYsJSoLyvwwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UvWHC1BO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2DA606A319;
	Wed, 21 Oct 2026 00:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B2DA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UvWHC1BO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792543182; x=1824079182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WGcUiVY4jws+B4jp3G4iZ3CxGhFlpq0jCXESu+h8pyw=;
  b=UvWHC1BO3pflBMoukuRIDNFL1ee8u557qTBTcjgdqlkZrlN0mYCDcqLx
   4IvJJrt54NrwTzXRdrEburakGuiVAFolPQ7QPhNnJVK4Qz3bSI9eQ1fhe
   jmspy6ArRjlhcb/cj6Wk0Bdrdvg8Bg67NnJb2eN75uK2dBgcXGyscHbq4
   C3Uqs9nj02y3H5mLbM6jUipZVIDd8e+w3zgp+QlaQfYKviQhKhvGflxgy
   invSyh8i1wR/FNuUx9t3l6Gt802b/7vcZC+lLSnI/F+3TCOk5YzAy+fy8
   gBWSQjc0uGMfnn2xzFnHkrJPmV7YuWPVrY7IpFt2ponTveF1VBVX/rp4j
   w==;
X-CSE-ConnectionGUID: 2Aw6DO6ZSBSztgTErpON8w==
X-CSE-MsgGUID: zhj9GFrDRj2S4YUOYeVhSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1250197"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1250197"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 17:39:41 -0700
X-CSE-ConnectionGUID: 9Ul/fpewRY+frjvcDDTLcA==
X-CSE-MsgGUID: YqC8EOlDQIW5uHstKC8i3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2898244"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 17:39:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 17:39:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 17:39:41 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 17:39:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0tJBBA83ZJG6PVIC2rgOeoeRw2QxjC0/9QfwjoItr43rqY6DSzaPfrtg9v8eNXmrTikxSyOxVe6+ydiFg+O8Yn0gNcxcqXue4q3gsDySZyBonKkxbfbE9QcRZESRGMSVPwkZj20hjgb8I6qJ23h5omodTFZVfc2lpGTFyQrIktIalDJZ1HSDfFsZ2XZJcvNMsD6HnlF6u8FxxrY89+jIPNpAXqhNgeV8zciO6iNEerxhgCZREKqTtKqdiv4cWTSsBuv456L/6DYSi+OeIayJIus0sH9bqwKQ/abmsBAC+Aj/GXBRCmjS9+fdPpeZdRTRraOdBFO0+o6biVU7pYB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGcUiVY4jws+B4jp3G4iZ3CxGhFlpq0jCXESu+h8pyw=;
 b=kk/alU6xDUL/97Lb16Ar8k6wfsljPylm0HDJh2ykJsu4zOKb3ElTC9JsxAhiJtVup/08Z335f5RhFwnDddSVxRClrHGPrWmtkycRiT6WEhPm3DDdhDLqn1U2NyFKguMQaUG/WI/6ssz07nk9RzlQVEeoaSjK9ocElOJj9NydcGGY+t+gH6nmduy8vhysRk47FGREcSDEhfLbGm6J4BAWEc2zkt6LyMsd6aHYOam53XQNnKljx6CPbvvQUU9IQ/KX1h0UyTAnvA8mg4Ps+aqxZcs8QoAY2zL0te35L75vnJCAXi0gk1FI+oiSQJKxkH9wGwrrbFjlxmSKnDbHnwa9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 00:39:38 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 00:39:38 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>
Subject: Re: [PATCH v5 4/5] KVM: TDX: Report only KVM-allowed CPUIDs in
 KVM_TDX_CAPABILITIES
Thread-Topic: [PATCH v5 4/5] KVM: TDX: Report only KVM-allowed CPUIDs in
 KVM_TDX_CAPABILITIES
Thread-Index: AQHdXU5ES2ZpZQtqB0uCCFQIpVd2H7cHLrEA
Date: Wed, 21 Oct 2026 00:39:38 +0000
Message-ID: <b69f075f475bb8c09c74cff621ae23f76da50795.camel@intel.com>
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
	 <20261016091422.3182216-5-binbin.wu@linux.intel.com>
In-Reply-To: <20261016091422.3182216-5-binbin.wu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|CH3PR11MB566895:EE_
x-ms-office365-filtering-correlation-id: 0f4bb074-cf2c-4031-af28-08df2f0bc9e6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|38070700021|4143699003|11063799006|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: KuZ778EmyqhVRwOEXJB5d/Ult/UzFsfFfBHlA3CMtYeE3tOGPlCNbE0uiZnmJRv3g3xH+Q9XvPgBXq2fOocDoxgBSiPD3xy7/erDVp4lsrTZXb4/BGsqVOFGHTVv08cQ2vbGYgun+CFSUEl9ECaclOdVKpA6mV4LPa3cgdtRb/Fxf1DmXBlkYGBwV305PzsZ0TSGYBzGx0GrXzr62KUBdbNiPivPcnZtA5/Ibpe+87mlfTZAkG5To4TLwT6KzPMnT3w1SLcwTq19rqlyVr9tid7fvrQ1oWxzVj4QXxy0Xu42LoFKMAtnggSOby8eQZZ95J82x8gmnBf0/s5nYUWKWDFH5lV2tvo48rQfkeL/QwBeoINT2gmVv/Q2c8CD17XE9/9+AukQlc+0WI3z8zPl4blFQcgHTLPp8yyl7sq6DbT/r49pwFWJtCRht//05eDXWx/PhTMxJU1DUe50J3M/XVJz0EakqvN8b2ayAxL1rQu40ejdcO7sAUxclBwYwLjMjczwkFWBjlpOS7/2wnmgTlcUjxof7pH+5iThHoTeWnNe1c8r+0YYG4CRDk4at4I5cAemissEX1mhIesbiIFZLu+L5Fr1w2Dp2cRZeUfksgLPWORA7jmypHePKlcqJ44y5otEacSigk9LK5v5UTFmyadAWAYsoIHlRKKltK8/Pppne9ZknJa/VjG/CxC3+Wz4uuG0o0mAylZKEEeuG/e6OEAivHl6C+SohO9fvnEmeHc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(38070700021)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnl3Q0JUb1o1SjVtZ1JMMjNMRGg5ZDVyWVJweHlPM3NuQzRKWnViWkRFMXlF?=
 =?utf-8?B?ODR0TlRaSUVrTDV2T0d0VkUrdURxdzI0NnhRTUwzUnpUc1JXY2dmeVlJMGli?=
 =?utf-8?B?WGk2K1BxRndRa2JLWm9VZmFRL3lZazdhKzY2Z0NBaWt5TVlLNzIzYXR4TUpG?=
 =?utf-8?B?T2EwN25YK0MvaHc1SEJKWUVjY3VYMTVaTG5TMnRRMmJjVVVkVVpiczFqVzE0?=
 =?utf-8?B?d2tXeHJpaysvWjVFbmozWVVIQmxoWjZKamFIdWdEVzhoVWVZU2hIZXA0Y1pU?=
 =?utf-8?B?a1NLLzR0NGdteGxiZUlNeFEybDdWSUhWamVHZEFlUE54bzNCa3N3V2xEdkIx?=
 =?utf-8?B?SVI1NENOazVHV1UxZXQ5ZHNJbUI4bVFhZGlBSGtYVE1YKzF1VmFLdHNzU1dQ?=
 =?utf-8?B?eFJrQmMyendlaFpNV0pOK1Z6MU5OdFRITWw3WTFHaFovWThVSzZPbDNUT0xN?=
 =?utf-8?B?Z3JxZWVUUHc2cGtiUUw0QlRqU3Z0ZE91Rm9qR2hzZ0d3UWcvS1NVcHdxaTZQ?=
 =?utf-8?B?QjZaZ1ppNnNNMURNK2hVTWJ4QnFkbzdJTzMxN3pVa0xTekZFZE41Q0ZzNkxU?=
 =?utf-8?B?dDV3NGRGUmptZWFLeHhuZHhXYk90TjIyTWtNdHVwVk9zaGgzNjZuZTRHWDIz?=
 =?utf-8?B?UEZqWjN3a0FJK0xyczJZczB4d2VDZW5XRVplanB5SDZyYjAwakxoS25ieFNI?=
 =?utf-8?B?VmVTVC9SOU4wbGNmZEtQaEdMQWl6NjkrL0UxM3U2RTJUV3dmZEF6M1FWRzRR?=
 =?utf-8?B?M0ZzNzVuQzFINTVlZnluQjNVQ3o4aWxNUzd1QWcwWS9yQnJmMVQ3Rk1LOUd5?=
 =?utf-8?B?aEprK09ONk5naVhWKzRlRUdneUZDc2JLcVh2K1hGRkpVWDhlNHA4a3JsS3do?=
 =?utf-8?B?R0FvZEZ6WEphT1AvOGRBY1ZnNmhKM0QzRFlsU2FaWk9YTW12U1lkbzhkc3Vu?=
 =?utf-8?B?a2w2aGw3Sit6ak9yMjdXMkZ1dW90YURRWFFGUStLUkdXQzlGUkl0aStVMHZP?=
 =?utf-8?B?WFNTNjBwYUcxalpQcVZWcUxUc0FoY3RIMnh2RktRRUZydnRPRFM0LytPdTE1?=
 =?utf-8?B?QjFITEg0NmgyTUVIdE5ad0tpTDc4U3NBV0dNNEpLb1pNR0d3emFwM1M5SjhF?=
 =?utf-8?B?YVZLa20weUdaMDE3RlpzSmJIbjJVNzhtZVppU3FwcUY1STlwNTB0NXVxNzVE?=
 =?utf-8?B?WWRTZzErYkpDTmRVZFkxSmVrRUJXTTFSOWc1NHZ3QVQzQWV4aU1RNnVjVlZK?=
 =?utf-8?B?Mkp6VUhkYWdLa1ZDNktvNEw2NGNvZ0tEekJjMU5VTU5VUHA1V29CRzFZZ21Q?=
 =?utf-8?B?M2RaZU45ekFQTm5LY01ZQmx4bE43alM5MnB4enNpSXdPSm5TTU1zVGtUdlgr?=
 =?utf-8?B?aGNKV2s5V3NyYjJMYTN3amszUHhsaVdkQWlGYmJZeGNjMVdadGtvUC8zU2Rm?=
 =?utf-8?B?N29STDBLazJtVkJMRGlvdTBuRWhlNitOU0Nub1paS0tPRmNlcGZWL0x2c3c2?=
 =?utf-8?B?YVBnZzVlTGhWMzZNSjdGbHp0bkZ5OGU0dUQ3SWpNdGNYelJuZ2hXeGIvdEhn?=
 =?utf-8?B?aFJoMjR6cHp1VHdIcUVqS0JxWVh1djBjbkZydk51YzVnRUo4UU8yUUk2RHE3?=
 =?utf-8?B?UkJiSFVXSVQyZU9nclduZ0wrb2djNEVyVyt4cmdBUzVROVozL3NZZXVscjdw?=
 =?utf-8?B?MGdtbThrbURXaEhFZFUyTERqMlBGcGxPZkczMTZtVnZYdlUrbGFsQnpWOWlw?=
 =?utf-8?B?dEpmdllFRC81ZWowbUdMNENNM1REYVM0Z3l6Qyt6ajBNeWpleURiWThtSDVC?=
 =?utf-8?B?MVRvWFd5WWc5Um9LOXNGdFBhbmkwNmZna2o1eEUyazZJTjZKS2UyU3NIQmZF?=
 =?utf-8?B?Uk9lSlh3WkJXL3h0Z21kWVlBRDB4Uy9WYWdkSEU0WmEzSGVsbHFub2w1TEtX?=
 =?utf-8?B?WFhYVnI3dGhhWXJQOVhyUFBaL1JIbjYzdmtLcXZRN2NGVVc3MlhYZy9IVlZP?=
 =?utf-8?B?Tk9zaHpWd09GbDF0TFl6MEtRcFJDSzhmUEhLcEFsaHVVdndkd2xEZDBaOEI4?=
 =?utf-8?B?UEJmMnM1cmJ4NVJXMFBBVjRNd3FUOWNiWnVPTGRyV2t3QUtwWUtZR1RaL0p1?=
 =?utf-8?B?UUFYUmhhaXpVRW5DVmZYODcwdHlGU241ZDZoUG5maE1nVkl6UGVCYU5qYVFR?=
 =?utf-8?B?WjVhcE1mekhRTWhzZWJkMkt0cllNbnJxdmhUOXZrN29GbGdHTnIzNWw4bU9C?=
 =?utf-8?B?WWp5bG1KL0hqdUFlck1QQllOMU4zTUd2aDg0OG1KVU5GNVloZy84UGhWYW1K?=
 =?utf-8?B?Z2lxT3ZoYThmWGhZR3UyemUwdUF4YzVNMEU1dkRLNlFhMkgxeXR0UlB3N3Rp?=
 =?utf-8?Q?M2nz+BrcoUq5TAAE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B282DDD6DC26824CB9BFA17463B5C3D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: udgxcEN8s2RjY6aVnL1KdIrkhimi5Xo3F5QGgI1hW0T4uuhzjm7s7x/gafe1OzYdXekDAuxIvPqlbEGy5I+and/fFiJemoYKtehjZBKnlt8rtkRdyfnnQyFT+8ZY4wAbHVtZLvfFwFVWe4uZ0/Yb6fPxIfTKwF0cWDo31pfxJgVWGstNbe/Rjh+crE21RW/0Duyrid5ag8y09gYA6EjFYVzoMfhA4EteD22NfgnlbgeYf0i18PkiuzXsBVsl6biuORJgpTFtuJ85GfYc41d/iMJKYFgyRfG5Ddgnft2WbCNHGyXbfveTFobqAoy5sMZpBFZt3psbXeaXxFchT2+YAw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4bb074-cf2c-4031-af28-08df2f0bc9e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 00:39:38.8352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVKaKSjwJ2ScR42z3MoQNt/eu8gnWMgNFN6zWIHyUbbnjOPfU9utapaMjkqe3YdndcpjgQ6bHjceFkpWiOcYqH3bOm+a2CJtnIresExCS48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB566895
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTEwLTE2IGF0IDE3OjE0ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+IE5v
dGUsIHRoZSBjaGFuZ2UgaXMgdXNlci12aXNpYmxlLCBhcyBzb21lIGJpdHMgdGhhdCB3ZXJlIHBy
ZXZpb3VzbHkNCj4gcmVwb3J0ZWQgYXMgY29uZmlndXJhYmxlIG5vIGxvbmdlciBhcmUuwqAgVGhl
IEFCSSBpdHNlbGYgaXMgdW5jaGFuZ2VkOiBLVk0NCj4gYWxyZWFkeSBmaWx0ZXJlZCB1bnN1cHBv
cnRlZCBDUFVJRCBiaXRzIG91dCBvZiBLVk1fVERYX0NBUEFCSUxJVElFUywgYWxiZWl0DQo+IHZp
YSBhIGRlbnlsaXN0LCBhbmQgdGhlIHNldCBvZiBjb25maWd1cmFibGUgYml0cyBhbHJlYWR5IHZh
cmllcyB3aXRoIHRoZQ0KPiBURFggbW9kdWxlIGFuZCBLVk0gdmVyc2lvbnMuDQoNCkknbSBub3Qg
c3VyZSB3aGF0IHRoaXMgaXMgc2F5aW5nLCB0aGUgY2hhbmdlIGlzIHVzZXIgdmlzaWJsZSBidXQg
dGhlcmUgaXMgbm8gQUJJDQpjaGFuZ2U/IENhbid0IGJlIGJvdGguLi4gc28gSSB0aGluayB0aGVy
ZSBpcyBhbiBBQkkgY2hhbmdlLg0KDQo+IA0KPiBUaGUgY2hhbmdlIGlzbid0IGV4cGVjdGVkIHRv
IGJyZWFrIHVzZXJzcGFjZSBvciBndWVzdHM6DQo+IMKgLSBVc2Vyc3BhY2UgdGhhdCBob25vcnMg
S1ZNX1REWF9DQVBBQklMSVRJRVMgc2ltcGx5IHN0b3BzIHNldHRpbmcgdGhlDQo+IMKgwqAgZHJv
cHBlZCBiaXRzLCBhbmQgS1ZNX1REWF9JTklUX1ZNIHN0aWxsIHN1Y2NlZWRzLg0KPiDCoC0gQ09S
RV9DQVBBQklMSVRJRVMsIHdoaWNoIG9sZGVyIFREWCBtb2R1bGUgc3BlY3MgZGVmaW5lZCBhcyBm
aXhlZC0xLCBpcw0KPiDCoMKgIHN0aWxsIGFsbG93ZWQuDQo+IMKgLSBUaGUgZHJvcHBlZCBmZWF0
dXJlcyBhcmUgZWl0aGVyIG9ic29sZXRlIG9yIHVuc3VwcG9ydGVkIGJ5IEtWTSwgYW5kIGluDQo+
IMKgwqAgdGhlIGxhdHRlciBjYXNlLCBhIGd1ZXN0IHJlbHlpbmcgb24gdGhlbSB3b3VsZCBhbHJl
YWR5IGhhdmUgcnVuIGludG8NCj4gwqDCoCBwcm9ibGVtcy4NCg0K
