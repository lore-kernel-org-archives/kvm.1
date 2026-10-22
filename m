Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792684316;
	b=Uvzw0XYD0hkdhf2BttfljOCqSdekvCBGWCcxw7mIhKs4IaTiQu8565Mc0fvMDI0lvRNv
	 jBy9afkZDOMCMtPUhqX6Bu9Ux/1uurF9nb6fJ/TIU186AoWdsr/u045e27z7rdru45Wwy
	 NzFCqsWFy+GOwa2IKhWogGIxwL1hW9Qis4MLav0T8nSKGgnxjzxAr1E2Yj5ehgxVAsfpK
	 TPIdGzExrL5ogcL6wAeHswhTZf6baRNfzHjjR8h7jp3N9SXAnJBjJuhw2jrmvU72LEp21
	 GWgX8a6pJB4XAaeTdIxcev8P/Y01KFr6tlVMkQ0A80r1lMpJwhoEkSTMpHqJvEUJ7XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684316;
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
	bh=2O5pdFg7uDdea+2IAkjSO4V/uRJMtJLE8NFplWC+a5w=;
	b=RX9svzeD6UQg08G3KqSaFuWaKBf9HpGiDateN2dq3ui+bOdZHAQXsn7jg1vkr7e7Sf94
	 /ep4Ihn/lfxKhetyZoNH/DdzZs2EGDfKPYMtk+paYIq7IitRuWe80cdgv55xg/vtD6baj
	 zsLQl7LHKq9RXiKzbbV32dp/+Fi+XXDmQCkilat/WeFWK64AbLqbXP7SqQHoTHAtFiHZl
	 oW6kpWAzTpvIXBb8qFacTgiwabCu6TYXyVlRL9hG0NumRWptzsUHZZJHcHW/1SUQVHoJT
	 48iB8AI1sJDnkz8MScA2Q6MJNuAfR3Lw26I/i8PIn0zKArJ1+ZV5wo1gdrCCvpvsoDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="dthhhzY/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AA5606A319;
	Thu, 22 Oct 2026 15:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0AA5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dthhhzY/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792684316; x=1824220316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2O5pdFg7uDdea+2IAkjSO4V/uRJMtJLE8NFplWC+a5w=;
  b=dthhhzY/p1NTlGGgMFWdora4uGQDMveBPfBP6NZqXb09GyVrhc1zQNen
   xs5svyvLGqyOCrwlVFCIIoj1QuuGu3Lb0Rm5eq4MgE6uavQrSh6AVCF4s
   OKB2VLI7BOhgZVh1eTWr9jTQgaTFAsvK3BaNKoqb6+YJ/ms6DbnvxPBkR
   A8ucPBzHvEtD4/S/3iynWCJKnqB4yHJlJtPuor3yCrE0QMwDEdpINiU/o
   wdAv/E4oM62UlVsg/mJSidUoRWZZWiSSToU78pVU2clwLaT18eEFaNdd4
   D+qe7JLxAlPx/fiBo1GzpkCiG6LgdRRsX0hA/Zm4njzALDd8LOzRXvi0f
   w==;
X-CSE-ConnectionGUID: /rbp0EOaRumFqjVTWOu7ZQ==
X-CSE-MsgGUID: DPFm7+HnQYSbHWy5RsFlCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1326761"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1326761"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 08:51:54 -0700
X-CSE-ConnectionGUID: QljeGpTHTO2IHlKLq5Fsig==
X-CSE-MsgGUID: ASEUwBkCRjKCBH/UFNa8Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3402433"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 08:51:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 08:51:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 08:51:53 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 08:51:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LC05HxC5d3Q9R4HzhLVTz2U0F9U47x4otFhdD7poPxK+4xW+7yaaYo1V5j1yrx4AfYviQy2f5ytaCoxF32U0dskSYlWJHNPqhKRwoLpbsYyLaaXa5sHUbhdgNv5LaSkuKH2nSwcs5jQYMEUiL9eyLABeoaxjooPQF7omsOFbXeP73TcaT6WuX73S4nzAHlofH09M80u18RAgJmdf3P8L8NlA03wrgN4QbNgmBn9fjN4o9XkhR1S3XSAbE0qYmbwJiS62nqifLipXsSdP4hG+ior+cELHbuzRxFrBT55C6sW7wCd29WdzpDORb0YIRwotGUgZjy4MLSUWjiUWTc0YnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O5pdFg7uDdea+2IAkjSO4V/uRJMtJLE8NFplWC+a5w=;
 b=EGoyblW0wtwMNVYCWb5M2KPmodFrdtxUTf+MFCX/o8BVFXy2gGh7shexT86eYCE9j1OzzuxhkR2ekfkwgpyVSHckPsGqK52ALrn3DaxjbqttJeyiZAo2hoOVe5DP0mTP2Js42SnGMOjF0cLsAS0MAinZcu0Lc873UGgb0aeEVzShpcCWYe32PZIcQTyGFoa8btOPJpNTjqw0wNlwfF8Wg/vuiP23rjYuPtXzPpvpFc/A5GN4JzRpr9mkL2DwoP31ELxJJgpzForP4EtD3L/wRxHhx16gmu9pmJ161AV8fjmw+AcNGl9m6ihJbAuLKW6JCB/ZUqiJ84jvWYZDHbbcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by MW6PR11MB8368.namprd11.prod.outlook.com
 (2603:10b6:303:246::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 15:51:48 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 15:51:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kai.huang@intel.com" <kai.huang@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "tabba@google.com" <tabba@google.com>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 02/17] x86/virt/tdx: Add a SEAMCALL wrapper to demote a
 2MB huge page
Thread-Topic: [PATCH v4 02/17] x86/virt/tdx: Add a SEAMCALL wrapper to demote
 a 2MB huge page
Thread-Index: AQHdTykMi6GQTjL+gUG+CUOLydf/JLbpcr8AgBBH4gCAANXIgIACUXEAgACUo4CAAMNTgIAANu8AgAAF7QCAAJGaAIAFzIUAgAPcj4CAALP8gIAAdteA
Date: Thu, 22 Oct 2026 15:51:48 +0000
Message-ID: <830974c6774c59048c04e1cdf7b7b007a40f97db.camel@intel.com>
References: <asyo+Pr7aCje1AZ6@yzhao56-desk.sh.intel.com>
	 <94e930e88046fca1f53d2234d581aae593367d95.camel@intel.com>
	 <as9OHnM4mceEre/2@yzhao56-desk.sh.intel.com>
	 <a0936473c0ac5a2ca0cfb30bc61c9d5c374c712b.camel@intel.com>
	 <atBupzmYqvnB0Qcu@yzhao56-desk.sh.intel.com>
	 <atCcvJoCwQyP1z9e@yzhao56-desk.sh.intel.com>
	 <atChtNfitK1PJCqJ@yzhao56-desk.sh.intel.com>
	 <ce6a1dde0089b0d357b11e58d2771596943c1239.camel@intel.com>
	 <atX5JpdqDJIrue4v@yzhao56-desk.sh.intel.com>
	 <19661a3ed2089304fd69ab4ca117eca7ceba425c.camel@intel.com>
	 <atnNZWj1t9aiOF84@yzhao56-desk.sh.intel.com>
In-Reply-To: <atnNZWj1t9aiOF84@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|MW6PR11MB8368:EE_
x-ms-office365-filtering-correlation-id: 558845bf-cfab-4017-3d33-08df305461cd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|22082099003|18002099003|261009223027099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: 4ivJ8VT5atWS+NOIsb2gw+/dcSWq+t5gfG6GOxRkbSv2nUtHb2Im3CYh0IPeFUSJlszbDqNAkopeknix0SByhuxxDA1M1Zwee1anBLOHA4Po0X6WE3LrNLMEoq5YnqCFBuLv0L5YJwuLJcmscEyM+fgZ5GsO+X9B7Y81n5+sz13RKHZPXJPvbqT9Y5Bpi/nes1pcC0qH3+xgdfYPNDMlowVNGydUl6IYVr+TrDr49lnDFJ4kRV0C2dmGdzNM9yd7g+XqcF6n+08qtMCt6OYve8RPSadQpxhu9JzoWkGtPGx91wzj0c0/5UchNGYjIHecqnsAFIq9AsEaGUiH3v0dQLiU+tHe1IQ0ndjOA+pUyTjsy87NdTnWoRRw9ruPJ7DQX6YhkWYkFuDmZmFjiSJ3PAWQJHrU29tSz90ALe0sqc2xh1nv9AqjF240moA0VS+V612xTOHGTo6KRPEEXoj65yAY4xAxB/Q4uV0PcLxgdZms431h6RE27rs+zq+VELDErrywXzndJjrjYqtQ6gkSF1hUMPo01gz4/Jm39EuZYSrCO5n2lAWJz6TM6nWOWHY/uOV8NUkykVacGFrnz1hf2NU6AmctLL64jhzE4hz3s0sTLNOXC6XACCSHgEJCB2ibqhbocMfZ7ZfXwiKZxlAmbFkyw3Xgmpq6xxaOva61JYTRcAIehvyj11zxbhQqHzTT5bBTI3XsXQGwHG6Zr2q7FSzoiaDbYumTvpHkX6nTEg0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(4143699003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUZxcitGZGRMdzI0dXFkc3Y5bGw1VUZaanJGRHp5TThCUWVYdktIc1EwSHhT?=
 =?utf-8?B?VW5veG1XdGhqUllHUDJCd24yTERYM2hmV3F4TW1jRzhLVXFMSnhGQ2lEUU9p?=
 =?utf-8?B?aU5FaThNTHlCSnlRMVdxbTZXRGVFaDJRclhNa3orcE9OSldkeXBzbUJpNHNl?=
 =?utf-8?B?V2FsWWNrbjJYMGMzbE9KTnIvK0w1SGE4bkRXTmJJejVEeTRjTDJUeEFwUzVE?=
 =?utf-8?B?aUpkUzh4OGt3MVVVYnJBQndKYkZ4UHZ1WFAzYW5RSG5PSjhHaE9qN0pxc0g1?=
 =?utf-8?B?TFpRSm1GS2RrZUNidjNzUGtYc1BNMkg3RGNweVA0cE03Q0FYcDMyYmZMNVVu?=
 =?utf-8?B?bkZPUG90a1kvcncrcW9jMFVDYkV1SzdCS2VsL3hJR1AyRDh6ZksvNXdIS0Rt?=
 =?utf-8?B?VGs4WmRBRWRTTlUvaC9wZldKdzhMRDVsT0RnaWFmVW51ejBUWDFRQWxrdmgv?=
 =?utf-8?B?cmhjS0tmT3gvbEZwNnJlTUhDSGJXL1lVdFdVYjRSUjBKd2ZvcjFpY0o5aE93?=
 =?utf-8?B?cnA5TFpDSWU0V1VsUjRFNUVCc0c3R2ZYNElJWXJNRlh1cXRvRlNnNURkcmpS?=
 =?utf-8?B?RVVabHpNWEU2SVk1c05ZZVVCb3B3WlFpQU56ekF1QitjaWI5czhCS3hpbSty?=
 =?utf-8?B?Smh4Q2FzaW5FNVgrYnhodmZtTk82RjQ3TkEwWkM2dlhJelg1QnpyS3RJdDlu?=
 =?utf-8?B?S2JsSEVpTTlDYnhrSW96SkVGVlhBZkZwK3V2ekRBYzRYT2hQMmNvL2hEUHEz?=
 =?utf-8?B?Q0tTZjBlSFROKzNLSjJCTUNGTld2enpJTysvdi8xdnZOdjRPcnJJbXFXd3VQ?=
 =?utf-8?B?NUhkbnVBczh3TVRoM2trWnZtOVdqYlpxeUVka2Q4U0xYVGRwQzJNOGRLN2cx?=
 =?utf-8?B?S0NuMDBtOGVIVFFxaVJIcHA5QkxlTFErbmdnTTFiZFZJZi9lUXFKUEpXazFU?=
 =?utf-8?B?bFllaWl4L2UxeUxaTHc5c0hkbXNEeCt0eGZsbGUwNk0vdzhRN3Q1Q1I5dlh1?=
 =?utf-8?B?bkJuWFBMQWNxM2lWWFU0NkpabXhVdDdJMjNzMXdhK0VYYXZiL1VnNktEK1pK?=
 =?utf-8?B?NW9vUUxmZE0rcGE0dHNiVHRTTkM1c09Dck04anNUQlpwQm1YUG95RklUV1hK?=
 =?utf-8?B?YzM1Qks2aUpYY21XeWE5blNmVnFqRmxpamFhczYvZyt5aER2TXJFdmxxVjJi?=
 =?utf-8?B?UUJFa04vQlM1MU0vQzhTZmNVVWJqbDVST3Q5QUxRRHUrRVIzRGR4SXAyRDlt?=
 =?utf-8?B?c1JxNGdyWXgxREduSWdUempmeWFlR1MwOFJLczlDUERBL0U0VktmZ2pFVXJD?=
 =?utf-8?B?Q2ZLVHFVdGY2czRVZXpsVnBCY0tmdTVzeFIzNUJzZUFOV2xkL0lmT0Z5YUxv?=
 =?utf-8?B?cXEyeXJIUXlLcmhCR0tvYXIxT2VPSkwzb2V3WXJHNDBlb2s4Vkh5MzlWaVJ1?=
 =?utf-8?B?b1FyTUtXTGFmN1Y4SGFJRFhtbVhuN2R6SGsxVFQ0VTZoVkxRZTlrSHg5aWFi?=
 =?utf-8?B?amRtZ3RkM3VYQnJRS2NDdkFMNC9jUnU0SzNObnNwMndkTGV3eGpJZFMxeTZT?=
 =?utf-8?B?SnV0MXJGaU5xRmhoLzJZZHNTUjNDNUVWTFplQ0ZoQ0dad3Z2RURmY2g0TkFV?=
 =?utf-8?B?YmVJNHVpU3VQVUZ6SDFBclZDbEdHY2t6cDRiT2doMG8yYlBWZXo0MnJmWUli?=
 =?utf-8?B?eEtGWVFmWVpqMW9zTXBRMWdGUFlCSmNNVkl3U2I2VXlva2l1QlBIL1BxSkN1?=
 =?utf-8?B?Wjh3Vno0YUJzUmZvdDhZVjNqYkwyK1g1b2RGQU1Ta0RLbmZFNmNUR0FvZnlF?=
 =?utf-8?B?RnJEVGt1MWI0anQvcmV4cW1tZXlZRFAyMnh1cUJDbTFnQWhxZzBYL2dRd0Rz?=
 =?utf-8?B?VWk2dm1zSDhHQWI2c2w1Sms2TUozQUlqNUx1T3QwVy85VFY3UU40WEdqdC9m?=
 =?utf-8?B?Q2R5M0dCdVVLVlNHL2NwL1NhN1BBZ1doektobkxJWGZScjUybDRRRmsvaHFr?=
 =?utf-8?B?eXJ3Zll1dlpUaXFIQ09IQnhGdDN0UFBtVlYzWldEcnNTTG9jTDVUZm03bWhF?=
 =?utf-8?B?Rnh4M0FpSkRLUEg3YUcwQUxFOHZMendSdldLL2s4L3M4ODRadEpneVlvKzgv?=
 =?utf-8?B?a1pMV0ZWTk5vbFpKWlBKbXBKd2prdExaWTZWZjRmVUZoak1IQlJ0S0lTeklr?=
 =?utf-8?B?RkNBWGx6VEFVUGRVdk1qZm93TUNEVGxvZ2ZtNUdpZytvNDArTXErSzEyTDhn?=
 =?utf-8?B?cWJpV0ZXK2FobXozd25RTE1XemQzWkh3WGMySzB0RzNweUNVakxQa1B0RlZQ?=
 =?utf-8?B?djZwdUNCWXpmeldTQWlNYXdCZVN5cTZ4eEhPenhieURaSWNOZW1IKzFKVjV4?=
 =?utf-8?Q?zuIU8bD8OrPU00h0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D36720BAD1903478F47ED54DF2FFA5A@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: va1d9AXS+m6GP3HL6JxMoAC72BjmMtuknyHw+makzs8W4mgPDWr1aK4GrMrZ+2uQDroHzTDbah22JeRAr+7oOfnZ2jnN/EKK5fJ+AqfKM91dk5KBZVqiOQgSmXK+j7yh+Rd1UtxoVls0/qZ6wUkJ/Pmv4LBSzYKwjFmicgDfmrmH+3Jnzu9KZZdp4ekz+t4nVtC1zWD7ckrUkR4Gve9v8uzenpMpGrCAH4f/PhL2yhvhpJYE+MAsZzggzVpFEGjR2qtT94pDtIxcNQn8tNP8e7eUfpqyZo1CyPg+33HhO4iZGSr7RKvaehYQisHJ3827UsrgQmcorMJv0CokG87m6Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558845bf-cfab-4017-3d33-08df305461cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 15:51:48.6052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ti+jX/ps6aB3t0OrmKOn2Lib+Oq/r3v7uvcW4KgTytl7y1//s64Bh3Y4jCn4FsHjZ1irWIdW+wXtydSV2Mwzt4T314hsQEgCjcHmEIHoDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8368
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDE2OjQ2ICswODAwLCBZYW4gWmhhbyB3cm90ZToKPiB1NjQg
dGRoX21lbV9wYWdlX2RlbW90ZV8ybWIoc3RydWN0IHRkeF90ZCAqdGQsIHU2NCBncGEsIGt2bV9w
Zm5fdCBwZm4sIHN0cnVjdAo+IHBhZ2UgKm5ld19zZXB0X3B0LAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdGR4X3BhbXRfY2Fj
aGUgKnBhbXRfY2FjaGUsIHU2NCAqZXh0X2VycjEsCj4gdTY0ICpleHRfZXJyMikKPiB7Cj4gwqDC
oMKgwqDCoMKgwqAgc3RydWN0IHRkeF9tb2R1bGVfYXJncyBhcmdzID0gewo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAucmN4ID0gZ3BhIHwgcGdfbGV2ZWxfdG9fdGR4X3NlcHRfbGV2
ZWwoUEdfTEVWRUxfMk0pLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucmR4ID0g
dGR4X3Rkcl9wYSh0ZCksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5yOCA9IHBh
Z2VfdG9fcGh5cyhuZXdfc2VwdF9wdCksCj4gwqDCoMKgwqDCoMKgwqAgfTsKPiDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgcGFnZSAqZHBhbXRfcGFnZXNbVERYX0RQQU1UX0VOVFJZX1BBR0VfQ05UXTsK
PiDCoMKgwqDCoMKgwqDCoCBhdG9taWNfdCAqZHBhbXRfcmVmY291bnQ7Cj4gwqDCoMKgwqDCoMKg
wqAgdTY0IHJldDsKPiAKPiDCoMKgwqDCoMKgwqDCoCAvKgo+IMKgwqDCoMKgwqDCoMKgwqAgKiBG
b3IgaW1wbGVtZW50YXRpb24gc2ltcGxpY2l0eSwgb25seSBzdXBwb3J0IGRlbW90aW9uIHdoZW4K
PiDCoMKgwqDCoMKgwqDCoMKgICogRFBBTVQgaXMgZW5hYmxlZC4KPiDCoMKgwqDCoMKgwqDCoMKg
ICovCj4gwqDCoMKgwqDCoMKgwqAgV0FSTl9PTl9PTkNFKCF0ZHhfc3VwcG9ydHNfZHluYW1pY19w
YW10KCZ0ZHhfc3lzaW5mbykpOwo+IAo+IMKgwqDCoMKgwqDCoMKgIC8qIEEgTlVMTCBwYW10X2Nh
Y2hlIGlzIHVuZXhwZWN0ZWQsIHNvIGZhaWx1cmUgaW5kaWNhdGVzIGEgc29mdHdhcmUKPiBlcnJv
ciAqLwoKT24gdGhlIGVkZ2Ugb2YgdW5uZWNlc3NhcnkgdG8gbWUsIGJ1dCBvay4KCj4gwqDCoMKg
wqDCoMKgwqAgcmV0ID0gYWxsb2NfcGFtdF9hcnJheShkcGFtdF9wYWdlcywgcGFtdF9jYWNoZSk7
Cj4gwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqZXh0X2VycjEgPSAwOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqZXh0
X2VycjIgPSAwOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gVERYX1NX
X0VSUk9SOwo+IMKgwqDCoMKgwqDCoMKgIH0KPiAKPiDCoMKgwqDCoMKgwqDCoCBkcGFtdF9yZWZj
b3VudCA9IHRkeF9maW5kX2RwYW10X3JlZmNvdW50KHBmbik7Cj4gCj4gwqDCoMKgwqDCoMKgwqAg
YXJncy5yMTIgPSBwYWdlX3RvX3BoeXMoZHBhbXRfcGFnZXNbMF0pOwo+IMKgwqDCoMKgwqDCoMKg
IGFyZ3MucjEzID0gcGFnZV90b19waHlzKGRwYW10X3BhZ2VzWzFdKTsKPiAKPiDCoMKgwqDCoMKg
wqDCoCAvKgo+IMKgwqDCoMKgwqDCoMKgwqAgKiBUaGUgZHBhbXRfbG9jayBpcyB1c2VkIHRvIGF2
b2lkIGNvbnRlbnRpb24gYmV0d2VlbiB0aGUKPiDCoMKgwqDCoMKgwqDCoMKgICogVERIX01FTV9Q
QUdFX0RFTU9URSBhbmQgVERIX1BIWU1FTV9QQU1UX3tBREQvUkVNT1ZFfSBTRUFNQ0FMTHMuCj4g
wqDCoMKgwqDCoMKgwqDCoCAqLwo+IMKgwqDCoMKgwqDCoMKgIHNwaW5fbG9jaygmZHBhbXRfbG9j
ayk7Cj4gCj4gwqDCoMKgwqDCoMKgwqAgcmV0ID0gc2VhbWNhbGxfc2F2ZWRfcmV0KFRESF9NRU1f
UEFHRV9ERU1PVEUsICZhcmdzKTsKPiDCoMKgwqDCoMKgwqDCoCAqZXh0X2VycjEgPSBhcmdzLnJj
eDsKPiDCoMKgwqDCoMKgwqDCoCAqZXh0X2VycjIgPSBhcmdzLnJkeDsKPiAKPiDCoMKgwqDCoMKg
wqDCoCBpZiAoV0FSTl9PTl9PTkNFKHJldCAhPSBURFhfU1VDQ0VTUykpCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2ZyZWU7Cj4gCj4gwqDCoMKgwqDCoMKgwqAgYXRv
bWljX3NldChkcGFtdF9yZWZjb3VudCwgUFRSU19QRVJfUE1EKTsKPiDCoMKgwqDCoMKgwqDCoCBz
cGluX3VubG9jaygmZHBhbXRfbG9jayk7Cj4gCj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFREWF9T
VUNDRVNTOwo+IAo+IG91dF9mcmVlOgo+IMKgwqDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZkcGFt
dF9sb2NrKTsKPiDCoMKgwqDCoMKgwqDCoCBmcmVlX3BhbXRfYXJyYXkocGFtdF9jYWNoZSwgZHBh
bXRfcGFnZXMpOwo+IAo+IMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gfQoKTEdUTQo=
