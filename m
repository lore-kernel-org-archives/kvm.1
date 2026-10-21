Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792620158;
	b=Of5M2/s2rEf5suCQAHY3P+ml+uTWqmStIS/JwnuQg3b6DB2obaUxeYJsjPZFDWDY9NeO
	 SsLhLPsfJv9h996JHnunHF1vMy0T5oi8qmZ5oyN/r6xTjHFUC9RCQMkkfcnnAEsgaS7Or
	 Wi0i4dS2lTs3J3gtRMamPiGvhJ/w/AzIUnsLBykjWRLeoik0t3EXW/QgsWFvhyhvXbL5b
	 O38A/4qS1682UdpYCCxgQz0kagEvWUz+dG/X0SLo63U/FoDSeX36nhhK8IZptCwaLuTov
	 h+8JpnWX2amHnKSfRyX5GFtJpSyqOBtkkRfUCXrpjLgNwN4o9p5nLhCy5IYg0+7Wt3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620158;
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
	bh=81KCEIvVTzfhAEMqQBB2A9Gaq+8ImuHSPVHVHiuOhwA=;
	b=I5ZnU0PAnCvVydnLwPvPCcqiLNExacZN+tzVBJatAucR1lNHg7kt2HtDpDfLm4sTSVFA
	 mnJOftmcH5L/4HXBuS9CeJeLoT4WhRRZ5BZVHBZx21MdkN0pi99dKV5XzVzC75gfKlK4H
	 aNU668mAMBP4lPcmBLITVuiJh2EL3MtP3Hqdo8rdATnOZN60GCCjaCYRDkESAXdS4kVod
	 Shw2IMv1Cny5kOEh8XoHKdcvSXMwqBNkeWWbyY4Xm+TKMa6pHAEBxhSTAvV6kxrDAJ5fC
	 I4xyMUG2DtMfzY6WVJK5BUc6FLDSnMTXiq45E1cWPNy8TaRWtjZEwlacn37Z9fNxRGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ThDPlYLj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31685606A31A;
	Wed, 21 Oct 2026 22:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31685606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ThDPlYLj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792620157; x=1824156157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=81KCEIvVTzfhAEMqQBB2A9Gaq+8ImuHSPVHVHiuOhwA=;
  b=ThDPlYLj4vWtxOtw0tEr6+DbDa2iRp5nbO6dot+hn1vC2AOazWyDnUaf
   ihti98opA4aquY3FJJIMf/AeyLHjWNFgQDJ4BtRXhP6Nju2P9aRTplUcu
   2Pt5fGTR/6LfStN8ou4WLVhXnzDOHxSYws8t25jsxHRV/4qkLpZJLJd5p
   BP2/DR7cmisz4AD7AKcGyNbS1MRVeIfahSDVK7hlDIDhifhf1NVSw+Lnu
   lmKIeQXMe4GDeLNkrSfkA33PPgD8v95AdkANSpOOoxOq7KUKIswnhkY9b
   BotgU30KM8YEl8SO2SjXQxg47olsmJI/uZ123Z5QtvFPONZnP2X1Ntzei
   w==;
X-CSE-ConnectionGUID: Wa0Uu6adSWK03m9XtcoUpA==
X-CSE-MsgGUID: XPRCzgmyR6GUG/26wTRJhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1238947"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1238947"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:02:30 -0700
X-CSE-ConnectionGUID: Vjxw8fpTSTS5ca5FsucXlg==
X-CSE-MsgGUID: 10fSmMnjQkmHcBssyjOUYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3254304"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:02:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 15:02:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 15:02:26 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 15:02:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOgInjcmLUpd3I8z8l1DpctXV0dmgwWy3I0athTqm9Ui4TJ4yrDMgvXtRbdHKkGQ7NRagNbyIj3c++DzU4LRpQMlRskrBbmM/XjtiFSDTeN9KAxuo+NlxhC8Eg91ziBCeqo4khOJERW4uIXm+rgWXzvHvvY9nwWmKNNFiBvKf1xzf/h2jnbpfaN1JSOg9BY04vG9/bVUFt+CQAdxUIU07mWvU7HuMAO3e6zzF2iEV2Pr3QyGECLY3SHcB+yZNa/ZBZWMjNsk5EzjW/kdZ9t3p1IWeipIr/YgquM2oNItcl5Kmcv38fXfIthxv72Ih0+9DPvYAcSLurA6XZiAOt6O0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81KCEIvVTzfhAEMqQBB2A9Gaq+8ImuHSPVHVHiuOhwA=;
 b=bgx2lyf9bSn6DwTf2Ayq4DQ8QixLaDFaiqZztFoWnNIAOl9oEVD/NGFo6hLXJdaGM6Rz85/4HaS7FlVmlNZQtu91THIUgdg7TCTBa+z3x2FvG0NMqsrHgfpLaq4KRGdYx4W9TqjCAreHHa+gUiniHC1KXlXBc5L8NZ6XKCvluaALz1h8+kEkKprrTTxtNMSdene5uoUUWlgmk1LEKPjZDX0oW3/TBgWfGENO8r9+m325WSf1gqSSpFVw7I/fI/WKnNl1vhfOF5BBD7Xv9GJlWFHtDO8WL3EDDtNA/KnUBdH86FjkQ/SP/S4d+93SpsDr4in5EYYKd+9qwsHNUbBJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by DS0PR11MB7802.namprd11.prod.outlook.com
 (2603:10b6:8:de::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 22:02:19 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 22:02:18 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kai.huang@intel.com" <kai.huang@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"Peng, Chao P" <chao.p.peng@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
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
Thread-Index: AQHdTykMi6GQTjL+gUG+CUOLydf/JLbpcr8AgBBH4gCAANXIgIACUXEAgACUo4CAAMNTgIAANu8AgAAF7QCAAJGaAIAFzIUAgAPcj4A=
Date: Wed, 21 Oct 2026 22:02:18 +0000
Message-ID: <19661a3ed2089304fd69ab4ca117eca7ceba425c.camel@intel.com>
References: <20260928090831.15502-1-yan.y.zhao@intel.com>
	 <9016c06a883bde489957ffdf7933cbbf6b8e6b03.camel@intel.com>
	 <asyo+Pr7aCje1AZ6@yzhao56-desk.sh.intel.com>
	 <94e930e88046fca1f53d2234d581aae593367d95.camel@intel.com>
	 <as9OHnM4mceEre/2@yzhao56-desk.sh.intel.com>
	 <a0936473c0ac5a2ca0cfb30bc61c9d5c374c712b.camel@intel.com>
	 <atBupzmYqvnB0Qcu@yzhao56-desk.sh.intel.com>
	 <atCcvJoCwQyP1z9e@yzhao56-desk.sh.intel.com>
	 <atChtNfitK1PJCqJ@yzhao56-desk.sh.intel.com>
	 <ce6a1dde0089b0d357b11e58d2771596943c1239.camel@intel.com>
	 <atX5JpdqDJIrue4v@yzhao56-desk.sh.intel.com>
In-Reply-To: <atX5JpdqDJIrue4v@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|DS0PR11MB7802:EE_
x-ms-office365-filtering-correlation-id: 51dd0ab5-aa79-497d-caf7-08df2fbef99a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|22082099003|18002099003|261021121427099003|261009223027099003|4143699003|11063799006|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info: YO1xQRRBB/26TwPq2OHSRK7QhkLmBwdu72E4BHEasVpYZkHKbm+fw/YODKOp7BFBR7v+kHanLbZMYYFpBVojx9zvs/FbMq7KsfelnAsn2zbkuyOlDB/Ib/o4ys5laPjtHllK9wJared/xTwmtFKGmldWKm38ue8nUyxXIszCAIUXxnX2S/wT1bHpOT3p3U7sPWL6hzcvNGUncy/695BDA5xPWcjexwUHraGfuU+5LOc7b44y3KlKSwmF4YMMpBKnym0d7RFtENYn3KPrcmcS6gt6+6m0Lr9yv03hI2hfKE3PmQ8ohYWndyEjQi5vZh5veFGU4zWZfKxMFHL23d7SPKMRWZhwx/WXPHUkBHRp1g7JUccewLFXRAoGnM7AdH6Hlom/UsrvLAKwUs0sRvFDgFQip/4iOoK6DPZHkZ5A8LGjORdbuO+Pr28FAFGOpvzjM+aDEJYqkOO0ZpQaFHmreyClaxVs8tftoY2IUDWwrUWvxkD52ztQhTpBF3XzV/X0c2R+YMgXIs3aOfNxanaVA+bXxRXu72ffo7wDnz5vzd8n1j5TFQZfdZKg7/QOuwCjGrNgSeCJrwFy6R87DH1F1IfdkzV6tayYBq9lTu9fXuL2axI3Nw9qkRrFDyeowT3Qx8umSLyco5D98ynebyvUSnsHf44IaTBuD05z+yj9oW4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(22082099003)(18002099003)(261021121427099003)(261009223027099003)(4143699003)(11063799006)(10067099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHpvLzJaQ3NIdUNxVk1wYmNSR2hrTnc3OStHcVdLUHBJYU1KdXROMmowdldr?=
 =?utf-8?B?TjNGOFl2TjI1RTZmN1BNQkFrUW5USGpDcEtJODNOVml4bkYyMnRrenlWWTNR?=
 =?utf-8?B?THkrWitZN0N6Qmo2SjVjOXU3U053ak5IazdPaDZMbGRvcld3cG1DQStnS0VI?=
 =?utf-8?B?b0duazB1NjlHRkl6YkRNdWVsR3NremlXQ1VmSzljTHBhYUpuemtURzIxeG5G?=
 =?utf-8?B?bWFGT2JhaUZyUnhIODIwYk5kNlNIOWsySWJzMitBQkNLdnNrcXpydmF6cTl0?=
 =?utf-8?B?eUQ5MGZINTAyUVZBZzdSOEFXaWo3Uk1TS2EzUktpcCt4ME1vNmpXcitxTlcv?=
 =?utf-8?B?VkdjTkxOSDlwaHJTU0lpdXNMdnprRThNd0thclBncXc0R013MUg2bjcwK1Fj?=
 =?utf-8?B?Wk1lVFUwamNQYWsxY3l1ekpCR0ZWMkdmTk92eGNOdjZlZVlBT1plSkJSR1VU?=
 =?utf-8?B?MWZ5KytmMXlBOVducmdJWHRoU0ZOeng4OXN4cHNkSkZRT3duYnNaL0RZS0t4?=
 =?utf-8?B?Q3M5KzR3ZmVESGV3aTZqNWhrQXVnaGx0NEtGSmxpQWcyM1VZcHhHMU1TQ0dP?=
 =?utf-8?B?VVhaQlc5MVZiZnVTSS9CdnpXZ1lSQ2lIL2xYQ2NCd21SREJSYTQwYWVxT2Jo?=
 =?utf-8?B?SFBRa0Z6T2RxR2FMOFZMb3F6aVpPdGFSSjR3NlE4UU0xTjhTdktYaWdsNEhk?=
 =?utf-8?B?bnl1SzQxSHRQSjV0Yy9rZGNmODRkV0ltRUlYN1lWYTNrdTQ2cFdSWmZtR0Fw?=
 =?utf-8?B?d01NZzhIT1hYL2FMb3YzWWJoYzkvQnNRK0dvVzlvTFAxL1M3OTNzV3RPY1BJ?=
 =?utf-8?B?THhSRHVDcW5kNmpLUWZaYlFzY2ZsZzVwS3htTjlrSGpJUTlkRTEvWUk0TVp6?=
 =?utf-8?B?OWE4Ky9OVUN5VVlnYzFOTGJxVjhCcDg5YUpTMzZSVGV4YjEyR2pLWXpvMXJE?=
 =?utf-8?B?WndkWTRVT29EOHZPMzJJYW5PcXJWbzAzeFFLKzZJOVdaREliMkFSUFZwTTJH?=
 =?utf-8?B?eURyMmNIYzBKdTg1cmxESU5uWWs4VnAvRTlSM0FxMVA0UlZFZ2oyVkZZdjN4?=
 =?utf-8?B?cEdkc1gxM2ZjR1FkWDQ1ZkdmRURDUXdOYWRYZ2FoNldka2xPOEFnQXlpSjQv?=
 =?utf-8?B?REZLb053azdjSjhQUEtMc3g3SVloN1pXVnlMTXZTMlZvUi9QRGlNY0RaUnFz?=
 =?utf-8?B?MTloL0N3TmNyQWhuck5jRy9DdUVmcVNuOG9VU2NBbjNlTjEzczIwL0tpdkFK?=
 =?utf-8?B?UHlXVUJja2RtbnZ2VDhvTHZ1cUExcmZKZnYzNDZOKzZMckNWV1EraWJpczhw?=
 =?utf-8?B?dWlha3FRWlU5VFluVS81Nzd1SSs5SzZLTTFIeGVTVFhvZTd2elUrRjVrZWJE?=
 =?utf-8?B?ajBaeThKdXZqek5UcURMU3YvMmhhVkVNMzh3OHFCclBHMVVvdG0rWjBsRHJs?=
 =?utf-8?B?eW90QnNzclIxMDBEbWJCc2M3UlpJUElSZElOZFplRGhJNk5hMGdPaFZWUzM3?=
 =?utf-8?B?MmZWd0Y4TDVpOWF0YWZOYzFEK2FsMXdmNmgrMXEvWnBFbU9RV09XL2pucThP?=
 =?utf-8?B?OC9sdmRDVjZUNzhjOVF5TzhaWEZCSTBzSUNrRkRWVytqblVMK0FZcEpvT2Zp?=
 =?utf-8?B?SXVPZWJXTzN5ODNPdmF4T25KQWFQbTFTR1NIaFdKTXhubTZueVlCdFFydjk1?=
 =?utf-8?B?Z0V6MG5ic1RtTUV2MWxBSEovc0lFVTBIQ0JoY3pRb1BialBuQ3BwbHlESDNT?=
 =?utf-8?B?bkQrQTZvYko4Q2tnRnBGRm04ZGR5Rk9EVUxscEdKRHFuSy9jWjFuNVBlaE1D?=
 =?utf-8?B?UjkyaVlsaDQzVmR4SXhSbzBVYXlkL21kaE5tNVBlWERrZ2tOaTcxMGpQbU9X?=
 =?utf-8?B?SUR3UmYrWHBEcUNtZG5XVG5WTVZtbXlGWEpNUElLdStwcXhwcU5YQVhra0VM?=
 =?utf-8?B?WlkyUGhxSzg3a1VMNmRFOU1mRkhhSm5DMkYxeW9XeERKejkxUkFtaTdadGhS?=
 =?utf-8?B?cWU5OUxKQzZDRUxxSkowdm9LeURCb0pvbDNSYU9rYzR0UXhDb3JXWVhBRW9H?=
 =?utf-8?B?ZzhpYmZrN2RBQ3kzQndlb0hDczZZMGpvdzNiRUZ0aHoycUNTZHFZY0RPdjM0?=
 =?utf-8?B?VGw4WkgwaXcrR1AvRTRQOHBuaDJsMlhFSUx0eGdETGdUK2tmaGlRYUd0N1cr?=
 =?utf-8?B?WkMwdVRHSlRtSWw5d0d0UnhXaWJLak9GWHE2T0hES3FrR1RrNmdNajc4eWFX?=
 =?utf-8?B?K0w0YVlMdmphLzMzTWI4aFoyb1BHQ1QxSkY5VnRaaFBmZnFwNEJ5bkYzeWRT?=
 =?utf-8?B?aDFLaUdBUHg5UEZTS3RwL0JCNXNrb3BwdHV1a2ZZRU1mako1Q3J5TnNDVVBm?=
 =?utf-8?Q?CqPP9VcrAB1EygRw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08FCC5A71324A4498D458DC2CB7A8DDF@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: dfAv6M8kW4DmVmZtckbYYwHq0NnlM9AQedlMG8KLkJxAFdZ82OQNBlzq0xCOFY4e8zKqXdF+SNkq7bG0y7tTbJOZeH4ugFPcQ90h9FYWFGl8dTZ379Ll5pDR9eK3HrI6ojdfFRGQcQZl9Oh0CcfiU2Zbsyckj2h9HDj2MXgdFnhGlP71VcWXpnggbaOHVjG40pliS3eVtiusk29K7u/fRZPvC0Wokb5DFeFJQqj2sQ+TgX8/pXisYUoVFfuttH9iE0NoOOf38zPjBpxUsWA6q6+Avos/hPTlEYSGXuzjYZcGlv+68UyE6P2PVvGRecZZFfrgZKE2VlNBzMUwvWztyA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dd0ab5-aa79-497d-caf7-08df2fbef99a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 22:02:18.6927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vu1vgJrnFQliZIA8Fuwwk3lp4Li4N1//cfaRKEm9CTGd+ZMloWPwQHQzG/dzfmPqjm4Lgm/NmFK25qd3VswM5PfxfahwdHFBLgaYWMqMO2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTEwLTE5IGF0IDE5OjA0ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
RnJpLCBPY3QgMTYsIDIwMjYgYXQgMDI6MzA6NDlBTSArMDgwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gVGh1LCAyMDI2LTEwLTE1IGF0IDE3OjQ5ICswODAwLCBZYW4gWmhhbyB3
cm90ZToNCj4gPiA+ID4gdTY0IHRkaF9tZW1fcGFnZV9kZW1vdGVfMm1iKHN0cnVjdCB0ZHhfdGQg
KnRkLCB1NjQgZ3BhLCBrdm1fcGZuX3QgcGZuLA0KPiA+ID4gPiBzdHJ1Y3QgcGFnZSAqbmV3X3Nl
cHRfcHQsDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB0ZHhfcGFtdF9jYWNoZSAqcGFtdF9jYWNoZSwgdTY0DQo+
ID4gPiA+ICpleHRfZXJyMSwgdTY0ICpleHRfZXJyMikNCj4gPiA+ID4gew0KPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgYXJncyA9IHsNCj4gPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnJjeCA9IGdwYSB8IHBnX2xldmVsX3RvX3Rk
eF9zZXB0X2xldmVsKFBHX0xFVkVMXzJNKSwNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLnJkeCA9IHRkeF90ZHJfcGEodGQpLA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAucjggPSBwYWdlX3RvX3BoeXMobmV3X3NlcHRfcHQpLA0KPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgIH07DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0
IHBhZ2UgKmRwYW10X3BhZ2VzW1REWF9EUEFNVF9FTlRSWV9QQUdFX0NOVF07DQo+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqAgYXRvbWljX3QgKmRwYW10X3JlZmNvdW50Ow0KPiA+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgIHU2NCByZXQ7DQo+ID4gPiA+IA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgICpl
eHRfZXJyMSA9IDA7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgKmV4dF9lcnIyID0gMDsNCj4g
PiA+ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKFdBUk5fT05fT05DRSghdGR4X3N1
cHBvcnRzX2R5bmFtaWNfcGFtdCgmdGR4X3N5c2luZm8pKSkNCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFREWF9TV19FUlJPUjsNCj4gPiANCj4gPiBXaHkg
ZGlkIGl0IGNoYW5nZSBiYWNrPyBCYXNlZCBvbiB0aGUgIm1pcnJvciB0aGUgb3RoZXIgY29kZSBm
b3IgZXJyb3IgaGFuZGxpbmcNCj4gPiBsZXZlbCIsIEkgZ3Vlc3MgdGhlcmUgY291bGQgYmUgYW4g
YXJndW1lbnQgZm9yIGNvbmRpdGlvbmFsLg0KPiA+IA0KPiA+IEhtbSwgdGhlIG90aGVyIGNoZWNr
cyBhcmUgYWJvdXQgbWFraW5nIHRoZSBjb2RlIHdvcmsgdHJhbnNwYXJlbnRseSB3b3JrIHdoZXRo
ZXINCj4gPiBQQU1UIGlzIGVuYWJsZWQgb3Igbm90LiBCdXQgdGhpcyBvbmUgaXMgYWJvdXQgaGFu
ZGxpbmcgY29kZSBjYWxsaW5nIHRoZSBmdW5jdGlvbg0KPiA+IGluY29ycmVjdGx5IChzaW5jZSB3
ZSBkb24ndCBzdXBwb3J0IGh1Z2UgcGFnZXMgd2l0aG91dCBkcGFtdCkuIFNvIEkgdGhpbmsgSSdk
DQo+ID4gc3RpbGwgcmVjb21tZW5kIHdoYXQgSSBzdWdnZXN0ZWQgbGFzdCB0aW1lIG9mIG5vIGNv
bmRpdGlvbmFsIHJldHVybi4gV2l0aCBhDQo+ID4gY29tbWVudCBsaWtlIHlvdSBoYWQuIEkgYWxz
byBkb24ndCBzZWUgYW55dGhpbmcgYmxvd2luZyB1cCB0b28gYmFkbHkgaWYgdGhlDQo+ID4gd2Fy
bmluZyBpcyB0cmlnZ2VyZWQuDQo+IE15IGNvbmNlcm4gaXMgdGhhdCB3aXRob3V0IGJhaWxpbmcg
b3V0IHdoZW4gRFBBTVQgaXMgbm90IGVuYWJsZWQsIGludm9raW5nDQo+IHRkeF9maW5kX2RwYW10
X3JlZmNvdW50KCkgd291bGQgY2F1c2UgYSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UuDQoNCklm
IHRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkIHdoZW4gUEFNVCBpcyBub3QgYXZhaWxhYmxlIGluIHRo
ZSBtb2R1bGUgKHdoaWNoDQpzaG91bGQgYmUgcmFyZSBnb2luZyBmb3J3YXJkKSwgYW5kIGl0IGlz
IGNhbGxlZCBpbiBhIHJhcmUgc2NlbmFyaW8gZnJvbSBLVk0gdGhhdA0KaXMgbm90IGNhdWdodCBk
dXJpbmcgYmFzaWMgdGVzdGluZywgdGhlbiB5b3Ugd291bGQgYmUgbGVmdCB3aXRoIGFuIGVhc2ls
eQ0KZGVidWdhYmxlIGNyYXNoLg0KDQpJbiB0aGUgY3VycmVudCBjb2RlIHRkeF9nZXRfcGFtdF9j
YWNoZSgpIGluIHRkeF9zZXB0X3NwbGl0X2xlYWZfc3B0ZSgpIHdvdWxkDQpyZXR1cm4gTlVMTCBh
bmQgeW91IHdvdWxkbid0IGV2ZW4gY2FsbCB0ZGhfbWVtX3BhZ2VfZGVtb3RlXzJtYigpLiBTbyBp
dCBzZWVtcw0KbGlrZSBleGNlc3MgcGFyYW5vaWEgdG8gbWUuDQoNCj4gDQo+IE9yIGNvdWxkIEkg
cmUtaW50cm9kdWNlIHRoZSAiZHBhbXQiIGJvb2w/IFRoaXMgd291bGQgYWxsb3cgaHVnZSBwYWdl
cyB0byBiZQ0KPiBzdXBwb3J0ZWQgZXZlbiB3aGVuIERQQU1UIGlzIG5vdCBlbmFibGVkICh3aXRo
IG5vIG90aGVyIHBsYWNlcyBuZWVkaW5nIHRvDQo+IGNoYW5nZSkuIFRoZSBvbmx5IGRvd25zaWRl
IGlzIHRoYXQgaXQgd291bGQgaW50cm9kdWNlIDMgYWRkaXRpb25hbCAnaWYnDQo+IGNvbXBhcmlz
b25zOg0KPiANCj4gdTY0IHRkaF9tZW1fcGFnZV9kZW1vdGVfMm1iKHN0cnVjdCB0ZHhfdGQgKnRk
LCB1NjQgZ3BhLCBrdm1fcGZuX3QgcGZuLCBzdHJ1Y3QgcGFnZSAqbmV3X3NlcHRfcHQsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdGR4X3BhbXRfY2FjaGUgKnBhbXRfY2Fj
aGUsIHU2NCAqZXh0X2VycjEsIHU2NCAqZXh0X2VycjIpDQo+IHsNCj4gICAgICAgICBzdHJ1Y3Qg
dGR4X21vZHVsZV9hcmdzIGFyZ3MgPSB7DQo+ICAgICAgICAgICAgICAgICAucmN4ID0gZ3BhIHwg
cGdfbGV2ZWxfdG9fdGR4X3NlcHRfbGV2ZWwoUEdfTEVWRUxfMk0pLA0KPiAgICAgICAgICAgICAg
ICAgLnJkeCA9IHRkeF90ZHJfcGEodGQpLA0KPiAgICAgICAgICAgICAgICAgLnI4ID0gcGFnZV90
b19waHlzKG5ld19zZXB0X3B0KSwNCj4gICAgICAgICB9Ow0KPiAgICAgICAgIGJvb2wgZHBhbXQg
PSB0ZHhfc3VwcG9ydHNfZHluYW1pY19wYW10KCZ0ZHhfc3lzaW5mbyk7DQo+ICAgICAgICAgc3Ry
dWN0IHBhZ2UgKmRwYW10X3BhZ2VzW1REWF9EUEFNVF9FTlRSWV9QQUdFX0NOVF07DQo+ICAgICAg
ICAgYXRvbWljX3QgKmRwYW10X3JlZmNvdW50Ow0KPiAgICAgICAgIHU2NCByZXQ7DQo+IA0KPiAg
ICAgICAgICpleHRfZXJyMSA9IDA7DQo+ICAgICAgICAgKmV4dF9lcnIyID0gMDsNCj4gDQo+ICAg
ICAgICAgaWYgKGRwYW10KSB7DQo+ICAgICAgICAgICAgICAgICBkcGFtdF9yZWZjb3VudCA9IHRk
eF9maW5kX2RwYW10X3JlZmNvdW50KHBmbik7DQo+IA0KPiAgICAgICAgICAgICAgICAgcmV0ID0g
YWxsb2NfcGFtdF9hcnJheShkcGFtdF9wYWdlcywgcGFtdF9jYWNoZSk7DQo+ICAgICAgICAgICAg
ICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gVERYX1NXX0VS
Uk9SOw0KPiANCj4gICAgICAgICAgICAgICAgIGFyZ3MucjEyID0gcGFnZV90b19waHlzKGRwYW10
X3BhZ2VzWzBdKTsNCj4gICAgICAgICAgICAgICAgIGFyZ3MucjEzID0gcGFnZV90b19waHlzKGRw
YW10X3BhZ2VzWzFdKTsNCj4gDQo+ICAgICAgICAgICAgICAgICAvKg0KPiAgICAgICAgICAgICAg
ICAgICogVGhlIGRwYW10X2xvY2sgaXMgdXNlZCB0byBhdm9pZCBjb250ZW50aW9uIGJldHdlZW4g
dGhlDQo+ICAgICAgICAgICAgICAgICAgKiBUREhfTUVNX1BBR0VfREVNT1RFIGFuZCBUREhfUEhZ
TUVNX1BBTVRfe0FERC9SRU1PVkV9IFNFQU1DQUxMcy4NCj4gICAgICAgICAgICAgICAgICAqLw0K
PiAgICAgICAgICAgICAgICAgc3Bpbl9sb2NrKCZkcGFtdF9sb2NrKTsNCj4gDQo+ICAgICAgICAg
ICAgICAgICBXQVJOX09OX09OQ0UoYXRvbWljX3JlYWQoZHBhbXRfcmVmY291bnQpKTsNCj4gICAg
ICAgICB9DQo+IA0KPiAJcmV0ID0gc2VhbWNhbGxfc2F2ZWRfcmV0KFRESF9NRU1fUEFHRV9ERU1P
VEUsICZhcmdzKTsNCj4gDQo+ICAgICAgICAgKmV4dF9lcnIxID0gYXJncy5yY3g7DQo+ICAgICAg
ICAgKmV4dF9lcnIyID0gYXJncy5yZHg7DQo+IA0KPiAgICAgICAgIGlmIChXQVJOX09OX09OQ0Uo
cmV0ICE9IFREWF9TVUNDRVNTKSkNCj4gICAgICAgICAgICAgICAgIGdvdG8gb3V0X2ZyZWU7DQo+
IA0KPiAgICAgICAgIGlmIChkcGFtdCkgew0KPiAgICAgICAgICAgICAgICAgYXRvbWljX3NldChk
cGFtdF9yZWZjb3VudCwgUFRSU19QRVJfUE1EKTsNCj4gICAgICAgICAgICAgICAgIHNwaW5fdW5s
b2NrKCZkcGFtdF9sb2NrKTsNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIHJldHVybiBURFhf
U1VDQ0VTUzsNCj4gDQo+IG91dF9mcmVlOg0KPiAgICAgICAgIGlmIChkcGFtdCkgew0KPiAgICAg
ICAgICAgICAgICAgc3Bpbl91bmxvY2soJmRwYW10X2xvY2spOw0KPiAgICAgICAgICAgICAgICAg
ZnJlZV9wYW10X2FycmF5KHBhbXRfY2FjaGUsIGRwYW10X3BhZ2VzKTsNCj4gICAgICAgICB9DQo+
ICAgICAgICAgcmV0dXJuIHJldDsNCj4gfQ0KPiBFWFBPUlRfU1lNQk9MX0ZPUl9LVk0odGRoX21l
bV9wYWdlX2RlbW90ZV8ybWIpOw0KPiANCj4gV2hhdCBkbyB5b3UgdGhpbms/DQoNCkFkZGluZyBz
dXBwb3J0IGZvciBhIHNldHVwIHRoYXQgd2lsbCBpbmNyZWFzaW5nbHkgbm90IGV4aXN0IGluIHRo
ZSByZWFsIHdvcmxkIGFzDQp0aGUgVERYIG1vZHVsZXMgZ2V0IHVwZ3JhZGVkLCBmb3Igb3VyIGJh
c2ljIGluaXRpYWwgaW1wbGVtZW50YXRpb24/DQoNCj4gDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKg
wqAgZHBhbXRfcmVmY291bnQgPSB0ZHhfZmluZF9kcGFtdF9yZWZjb3VudChwZm4pOw0KPiA+ID4g
Q2FuIG1vdmUgdGhpcyBsaW5lIGFmdGVyIGFsbG9jX3BhbXRfYXJyYXkoKSB0byBtaXJyb3IgdGhl
IHNlcXVlbmNlIGluDQo+ID4gPiB0ZHhfcGFtdF9nZXQoKS4NCj4gPiANCj4gPiBUaGUgbGVzcyB0
aGF0IHN0YW5kcyBvdXQgYXMgaGF2aW5nIHRvIHRoaW5rIGFib3V0LCB0aGUgYmV0dGVyLg0KPiA+
IA0KPiA+ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gYWxsb2NfcGFtdF9hcnJh
eShkcGFtdF9wYWdlcywgcGFtdF9jYWNoZSk7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgaWYg
KHJldCkNCj4gRG9lcyB0aGUganVzdGlmaWNhdGlvbiBmb3IgV0FSTl9PTl9PTkNFKCkgb24gYWxs
b2NfcGFtdF9hcnJheSgpIGZhaWx1cmUgdGhhdCBJDQo+IHByb3ZpZGVkIGluIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC9hdEJ1cHptWXF2bkIwUWN1QHl6aGFvNTYtZGVzay5zaC5pbnRlbC5j
b20NCj4gbG9vayBnb29kIHRvIHlvdT8NCj4gDQo+IENvdWxkIHlvdSBzaGFyZSB5b3VyIHRob3Vn
aHRzIG9uIGl0Pw0KDQpJIGRvbid0IHNlZSBhIGNvbW1lbnQgYWJvdmUgYWxsb2NfcGFtdF9hcnJh
eSgpLiBJZiB5b3UgbWVhbiB0aGUgY29tbWVudCBhYm92ZQ0KdGR4X3N1cHBvcnRzX2R5bmFtaWNf
cGFtdCgpLCBJIHRoaW5rIGl0IGxvb2tzIGdvb2QuDQoNCj4gDQo+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBURFhfU1dfRVJST1I7DQo+ID4gPiAJCcKgIHJl
dHVybiByZXQ7DQo+ID4gPiA+IA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIGFyZ3MucjEyID0g
cGFnZV90b19waHlzKGRwYW10X3BhZ2VzWzBdKSwNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCBh
cmdzLnIxMyA9IHBhZ2VfdG9fcGh5cyhkcGFtdF9wYWdlc1sxXSksDQo+ID4gPiA+IA0KPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgIC8qDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRoZSBk
cGFtdF9sb2NrIGlzIHVzZWQgdG8gYXZvaWQgY29udGVudGlvbiBiZXR3ZWVuIHRoZQ0KPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqAgKiBUREhfTUVNX1BBR0VfREVNT1RFIGFuZCBUREhfUEhZTUVN
X1BBTVRfe0FERC9SRU1PVkV9IFNFQU1DQUxMcy4NCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
ICovDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZkcGFtdF9sb2NrKTsNCj4g
PiA+ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgV0FSTl9PTl9PTkNFKGF0b21pY19yZWFk
KGRwYW10X3JlZmNvdW50KSk7DQo+ID4gPiA+IA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIHJl
dCA9IHNlYW1jYWxsX3NhdmVkX3JldChUREhfTUVNX1BBR0VfREVNT1RFLCAmYXJncyk7DQo+ID4g
PiA+IA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgICpleHRfZXJyMSA9IGFyZ3MucmN4Ow0KPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgICpleHRfZXJyMiA9IGFyZ3MucmR4Ow0KPiA+ID4gPiANCj4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoV0FSTl9PTl9PTkNFKHJldCAhPSBURFhfU1VDQ0VT
UykpDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2Zy
ZWU7DQo+ID4gPiA+IA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIGF0b21pY19zZXQoZHBhbXRf
cmVmY291bnQsIFBUUlNfUEVSX1BNRCk7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgc3Bpbl91
bmxvY2soJmRwYW10X2xvY2spOw0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gVERYX1NVQ0NFU1M7DQo+ID4gPiA+IA0KPiA+ID4gPiBvdXRfZnJlZToNCj4gPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmZHBhbXRfbG9jayk7DQo+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqAgcmVpbnNlcnRfcGFtdF9hcnJheShwYW10X2NhY2hlLCBkcGFtdF9wYWdlcyk7
DQo+ID4gDQo+ID4gSXMgInJlaW5zZXJ0IiB0aGUgcmlnaHQgbmFtZSBoZXJlPyBJdCBpcyBqdXN0
IGFkZGluZyB0aGVtIHRvIHRoZSBjYWNoZSBhbmQNCj4gPiByZXNldHRpbmcgdGhlbS4gU28gd2h5
IG5vdCBqdXN0IGFkanVzdCBmcmVlX3BhbXRfYXJyYXkoKSB0byB0YWtlIGEgY2FjaGUgYXJnDQo+
ID4gaW5zdGVhZCBvZiBhZGRpbmcgYW5vdGhlciBmdW5jdGlvbj8gSW4gdGR4X3BhbXRfcHV0KCkg
cGFzcyBOVUxMIHNvIHRoZSBwYWdlcyBnbw0KPiA+IGJhY2sgdG8gdGhlIHBhZ2UgYWxsb2NhdG9y
LiBNaWdodCBuZWVkIGEgcHJlcCBwYXRjaC4gV291bGQgaGF2ZSB0byB0ZXN0Lg0KPiBXaWxsIGRv
Lg0KPiANCj4gPiBUaGlzIHBhdGNoIHdpbGwgZW5kIHVwIGdldHRpbmcgc3RyaXBwZWQgZG93biB0
aGUgbWluaW11bSB3ZSBuZWVkIGZvciB0aGlzDQo+ID4gc2VyaWVzLiBBbnkgbmV3IGZ1bmN0aW9u
cyBvciBleHRyYSBjb2RlIHdpbGwgZ2V0IHNjcnV0aW55Lg0KPiBJIGFncmVlIQ0KPiAobXkgb25s
eSBjb25jZXJuIGlzIHRoZSByaXNrIG9mIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSkuDQoNCkFz
IGFib3ZlLCBsZXQncyBqdXN0IG1hdGNoIHRoZSBleGlzdGluZyBjb2RlLiBPdGhlcndpc2UgSSB0
aGluayBpdHMganVzdCBnb2luZw0KdG8gZ2V0IHF1ZXN0aW9ucyBhbmQgbm90IG1lcmdlZC4gV2Ug
d2FudCB0aGlzIHRvIGhhdmUgYXMgbGl0dGxlIHRvIHRhbGsgYWJvdXQgYXMNCnBvc3NpYmxlLiBJ
ZiB3ZSB3YW50IHRvIGNoYW5nZSB0aGUgZGVmZW5zaXZlIGxldmVsIChJIGRvbid0KSwgaXQgaXMg
Z29pbmcgdG8NCm5lZWQgYSBidW5jaCBvZiBwcmVwIHBhdGNoZXMgaW5zdGVhZCBvZiBqdXN0IGVt
YmFya2luZyBvbiBhIG5ldyBwYXJhZGlnbSBmb3INCmFkZGl0aW9uYWwgaHVnZSBwYWdlIGZ1bmN0
aW9ucy4gSSBkb24ndCBzZWUgYSBuZWVkIHRvIGRvIHRoYXQsIGFuZCBmb3IgdGhlIHNha2UNCm9m
IGdldHRpbmcgYmFzaWMgaHVnZSBwYWdlIHN1cHBvcnQsIEkgdGhpbmsgdGhhdCBpcyBhIGdvb2Qg
dGhpbmcuIFJpZ2h0Pw0KDQo+IA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7
DQo+ID4gPiA+IH0NCj4gPiA+ID4gRVhQT1JUX1NZTUJPTF9GT1JfS1ZNKHRkaF9tZW1fcGFnZV9k
ZW1vdGVfMm1iKTsNCj4gPiANCj4gPiBPdGhlcndpc2UgbG9va3MgYmV0dGVyIHRvIG1lLg0KPiBU
aGFua3MhDQoNCg==
