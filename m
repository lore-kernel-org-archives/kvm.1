Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793732138;
	b=c/fVHSfNY32YGNKG/80CfefZ56ED4M2Cs+LB01ARgq2KNlFK4a4vDY0KsgvRrn5A0//c
	 hLp7ZUzd7QvC72vsTOELYw6TnJNzFFv5gQOZ7K5mTrT+32iljPrJFsnRTz+KOP8KeK0o6
	 Wdo2PGAc3g2woAyosaDpdHQFcPaNOpgHoAW/9VG0IU2BG9sPfO8cMMf6LKu0EMvDu7JdZ
	 gMv3LsrQisbup9DzrhVbQfomgCPUd6kAPNSN01PhGxAG2ZSrt9zAKO/iLmM3QVznvr6HW
	 PLXtUOLTMa9yySv0bM4y6vaIImLYSwGBtUb7PRxe5CL5NiaO25kPz5/HP6h6OwaosoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732138;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
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
	bh=vp7V7j4kcAfyrV89jz1SIOJFnDKiPypgj6R3B/MpJQI=;
	b=IXWL7O8xbjg0QnsaBYZwhcrcE1FBLhCDSl1uAaUP3FEZExsfe+cND9JgkaJvJV/Tzz46
	 41eI1zT+jhVBgD2/yOoKAfp74rMj7EeG7nuJO+0Dcqlt9w9Pkvu4p7EZMSjtDLAd7+52Y
	 URq80nYH7e5CszwiQaZeqf77is9sXON1Jh4U1rSR0AnPID5BcywcNRzImwQ0ooPUTd5/b
	 GvPN5cvbVBWF/C0O5Sw3r156L1A5FnqF/q5GN17l3WiUDcD5Arv9O++m3+zgRKlvEfVIZ
	 ci/o6NyWppXmUu/kNOZ+xPYxMmV5VYH7IIe7TmjSQ4utouLWJGbX81uI3LWjG7uW9rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IvNQsnyy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2462606A337;
	Tue,  3 Nov 2026 18:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2462606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IvNQsnyy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793732137; x=1825268137;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vp7V7j4kcAfyrV89jz1SIOJFnDKiPypgj6R3B/MpJQI=;
  b=IvNQsnyy48kmtkGlMH5JBqqByJ8EiwvsmvvcFjNbsQDyiCSlno4hOVkF
   lDHetBT1T8wZZpnWAMvWsXrbZh1QJxUwrFLcxqCknrICHBKaVbJVC1DLN
   KDtwlxP73EV5OMT6ri2O0ESeWhXV+5fxYwJzS6ue0/pE4JFBwvAwJS+oQ
   gk9GcdXxZAqFkF2U79g26vfHcFhvIv9h+80nYFAYpShLNRki9hjXJamnG
   GQZjAoa2KimrhdUYGGObtcZQjgtfRBY2gBqdfX6FmDLtZlLizNt9H6wI8
   bLSl2/mtvT+EVD0uesvtKZFcCq6yPj+hzkSPA84sWz9ewloUF3DRTfkfo
   g==;
X-CSE-ConnectionGUID: dN2eUsHmTMuo5IryKidRSg==
X-CSE-MsgGUID: 4RDpSHDlSuuXsFG8glyPqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2346721"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2346721"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:55:36 -0800
X-CSE-ConnectionGUID: TZWgYdfhT9eIsexbO5c2kQ==
X-CSE-MsgGUID: f2VOLwNkSxelauc89y/3Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6877255"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:55:35 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 10:55:35 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 10:55:35 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 10:55:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObOTNEVp0KEToCvQBqwpxTUcjNDjOe/tWK1XK8W4QnRuQ+Ca+ijEJ5w5dUa0/gp1rlKEc6DBIGciI3wx/zqAjAPsLZ8Ro9IhZioPiXBK5qLBuysq+jahGV6rwIsKTECzSRMHhh118+NCTWBP1SEVHGRFElZ09iIhLYu2J/0xvKaTnN+BIBfb3vYTSVhTpIGIY9Qi6rZ7dp2vA51Zv8M5DSQLT0inIy9oEepr7qrA4+2ZXO3GCiLOGmS+H57d7n4baJAnSwQWPweHEXb4NNVXxqtzrw7jzel0AToLhqIiewwTJB2+XEOnQFBeTK5tio/1FMIRTnKIF4dFUurbv7wR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vp7V7j4kcAfyrV89jz1SIOJFnDKiPypgj6R3B/MpJQI=;
 b=hKvNLXHkkYiDBjvSPsvFmgxy37RagFMwoLKAMfQvgnebJQQQa6KYFyDTYp5EM5YYLb2ubelhb1xsqIOuv4lv6OR7c6XHjfKNAgG3Dl6hTGD1yWt/Ld3aHCFgd7lCHE5RparYPhJ6NZVMy+RXyNZI5oWd9mhaoyOIYevhJciSsNb8cmBFcv9lWPYf7DlAoApMcb1ZT6YpWWqu856lVye5MDbEvHvkPwCZrvqUDNgbgSLtLuPoYde64JVzWTzcJWaj4KYVxhIZYwW4Ke+EpxmBiV9BWZcyFVWq/dhDaiat9JXV34qs8At7u1/OINxWkNoTll5hLTaaK9zvTVa3GXQugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by PH0PR11MB9725.namprd11.prod.outlook.com
 (2603:10b6:510:396::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 18:55:33 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 18:55:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "tglx@kernel.org" <tglx@kernel.org>, "Van De Ven, Arjan"
	<arjan.van.de.ven@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [RFC PATCH v1 1/3] x86/virt/seamldr: Allocate 'struct
 seamldr_params' after image validation
Thread-Topic: [RFC PATCH v1 1/3] x86/virt/seamldr: Allocate 'struct
 seamldr_params' after image validation
Thread-Index: AQHdaEwsfP/W+e/vM0GR/C30kquYp7cbe2iAgABtrQCAANAegA==
Date: Tue, 3 Nov 2026 18:55:32 +0000
Message-ID: <489dffef0e65571d439ef23b6340f5e9e3aafb0d.camel@intel.com>
References: <20261030085304.3886520-1-chao.gao@intel.com>
	 <20261030085304.3886520-2-chao.gao@intel.com>
	 <5397736259f9743da43ad41b2e2a995e6372f1f7.camel@intel.com>
	 <aul_jq5X63s7QnTS@intel.com>
In-Reply-To: <aul_jq5X63s7QnTS@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|PH0PR11MB9725:EE_
x-ms-office365-filtering-correlation-id: 553f7f24-76ab-401a-64fc-08df39dc0974
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|6133799003|22082099003|56012099006|261102123227099003|18002099003|10067099003|261009223027099003|261021121427099003|261022105027099003|261022115727099003|261022075727099003|5023799004|11063799006|4143699003|38070700021|261026121527099003|261028144727099003|261026140227099003;
x-microsoft-antispam-message-info: 9sFdKAN3IoEQnYnKgHgaZzkcWRZmKjWmvbkgxokRdQQEcN0+VR0fymGpWs0Ssj/OxEc5jqnB7IloX3LX8UF611fx6D52IEqa+VC4E4rAGjK/KoGlxhierIXqRWSASKlmDdOQ4aaCWLFG6TCtPrh6iUu9MaOfKKgbN2KjQZNcpwCO14ofE/oLNTeyET6wTkGWyE7gZ3B+khH7xxIelQo0qDhPUwC09N2/5d137BSbKOshrHVL5vJLha0eWRWrrytp6q2WY4/ddVaraROEAjB5BwIh/XybLigcIXZN8HLaz/ADFg7x56ALqDekZd+nGQL7q+StpuIr1hMdssAhHEcVJ7fGBsOTgtkNA0D8bnkX/JBJlabWgGUJBoD0Y4fNy7JdUwf9sTrKlUXTeXu0k0YGYe+JB9xOmkU+BUpwRw2KamzIh6SQ72grEJP2W6c6qy6gh/ip+Gzac8SUR8r7gcjdeXpva+oWNiW1AJAdGWEVYywWC3bIs8HEdDb+pViY6AkHJ6jgJtUMMjGY8qEkXZ5euhLTjHEx3wduJf7sQJ1foa7VXpTar6PJ5xdhzm76Yk1M6c+PU4SF2njHS/IjzRPE6WA5ZvD2JqE1jglGfcv2ZeWn9L39TsIbXhTrgCnCnG6FdBeK1PH5L2iWgWMio1uxt2/E0u4raeS9sIxPV5lAn9bx54z2350Fc8qQCni6pEtA/YqjUsO3ffdjmk4lhRxF/aQ/1EJZImmDURHIKNOxPa4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(56012099006)(261102123227099003)(18002099003)(10067099003)(261009223027099003)(261021121427099003)(261022105027099003)(261022115727099003)(261022075727099003)(5023799004)(11063799006)(4143699003)(38070700021)(261026121527099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dk5WM2JqY0d0T0szZEI5cUlJbVBDdmxpQk1sM3FsQWU3My90OUVkb0NJM3lB?=
 =?utf-8?B?eTlZVFB1bVFjNzMyRHZMKzRRMys1T0tOY2J1VGNBbWtVeHVmVE9UMmxYM3JC?=
 =?utf-8?B?TXF0VmpsRk0rQ0djT1RQQTFYanZoQWM2ZWFRL0lzRFJVRkdtN2JEUmVLMFky?=
 =?utf-8?B?dnY5MFhCY2EzZmpCaEZWQXk1OGtDWTBKTzRVbnBXNDMyUFZaNURTOStjRmIy?=
 =?utf-8?B?MVlDMFUvd2t3aSt5d2JVTllpTUdRNTQyNUhTa1V4ekNIWXdJVDVyUnZST3J1?=
 =?utf-8?B?OThOM0lad2hXU2lkVlFtYlVBb3ZmekJINU9iRHA2V3B2SENSNEF2OFk2ZC9k?=
 =?utf-8?B?V2ZlNjhScVdSSVhtZWY0Mm9DdFozRTNqUGg5UVhwMnZFTVo3ODQ1T0JsdEc3?=
 =?utf-8?B?MFRYWFcxYnFsMVhoYkt2N1lockc5MjV2MnRGcFJUTWZGYTNZSmVUWnBIWmlk?=
 =?utf-8?B?TkxlZ3k0SlpUSk1ZK1JkUHl6WXk3TWN0anBSRHA5bnVDdDgweGYxU2JTSHFM?=
 =?utf-8?B?N0R6cnhpY1ZJMFNqbDltUTR0c2p2NWRPeDNyY3JoU2tkM1R4ckFpQnREeFdz?=
 =?utf-8?B?c28yWXJFdWZNN2dMeVFoREJ0a0xsdjBrWGVIL25xekNteUV2N25YYkxHRzE2?=
 =?utf-8?B?d3lVM2xITEhMTW1uNmVYbm96YkxTUlZpcWhnNFRhb1VZR0JpY0lJV3Z6SFJ2?=
 =?utf-8?B?V0k1S1UwSHdpMExKby8wVFJDZkM5c01WcTM2YmJreHg4ZFdNaUZyZllsbkZJ?=
 =?utf-8?B?aFZVeTlrNEZIWVZodEJrSHZFOWpiZ3RiQmRRMncxakRmSXllSFE1eWRqQVpw?=
 =?utf-8?B?U3R3TVA2anpya0Fia3JlTS9uWUREMklXWCtGaXlheEdJdzZHODNJTHV0SStk?=
 =?utf-8?B?bEVmdXhBV21kRStFQTFvcm1acldiTy9UN09ZcnJvS2UrNTRCNVc1VHhkTmdm?=
 =?utf-8?B?Qk1uSzgwVWxud2pvaDM5dFR4UmxYUUgrL0FrZWdqNUJlMlJ5NVo1YzNzZ0dD?=
 =?utf-8?B?NGdpMm9oL3FMTmcrT2oxb3BNQVVPMGFYaGZ6Z2p4cnJBRFRhK3lYVFVySzdZ?=
 =?utf-8?B?VmNNS2VVUXpVeFBLU3NDd3NNdjRBSHRBSTJtYnY4ZVB2YW42QU1Jc2UzUXdu?=
 =?utf-8?B?VkVhaXBFY1VjZzdvWWs4RzljK3FqbVRXVWFKV1pNc0VpZ0JJVVRLbHlVQUZw?=
 =?utf-8?B?SEU5ekRyMDJsbExWK2pkQzFTY1F2RWhwbnRGOFZ3a1NVdlRNZTVoNW85OWtw?=
 =?utf-8?B?Vzd3Ti9OQm9XdVZuNlhBK1ZIMlprU0RPTmYzNlZsM0dNclhiR0dtb3ZnMzBz?=
 =?utf-8?B?UFUzZ1NPQ0ZDRDQ1bEE5T0RTcWRmOG9wNUo3R3JMZHpUK3F3LzdCaXFSLzlk?=
 =?utf-8?B?dG0vbVVMSWFqTGwyNGhuT1lFYkFqMnVhbW9RRXlpcW9icm1ueDg2b0EwYUQ2?=
 =?utf-8?B?dHRVb2JIa1ljdDJsNlpIVWk2VlRGcXdicDhPWWNQbmM5TC82L25mbTkwNk43?=
 =?utf-8?B?SmNPNkg4Q0J2OHY1MCtsMjJIY2g4cTNtT244OVlDNmJ6b1JPbWNMUGthTG5P?=
 =?utf-8?B?WGl4OG5LN2lNM3ZQenlXSWlrOHlza0Y3L3ZqRUVkODJndFZuVlZTOXMveE9p?=
 =?utf-8?B?QWJjNkcxb3IzUXdSSUR4d2RyVVFEeGNaZGVza2dwc29ScTYreWhRTlVianJU?=
 =?utf-8?B?NHFnY3JBTGRqb1FFSzkwemc2YVhVR2hBdDlmd3RwRExPdm1JeTlrWUU2dC9I?=
 =?utf-8?B?ajF6U1NEbVBKc0tFRUlsUXFOM2RvcTMwbHFBZjA4QnB2d2J0L2ZEUjA4NHpS?=
 =?utf-8?B?UzlxYzU4TlFtRFU1S2JNay9Idkx6Y2kyKzZ2THR2VEdoS2tGWHljU3B3RHVx?=
 =?utf-8?B?YXpqcHZHOHVsN0QxaDYyWDNWSkgzdTN6VXpFbGZSQ0krVGFKUnkyT0RDSWN0?=
 =?utf-8?B?TnNsQjM1WWRLd2x5bVlGZElWUTJEWWd6dDV0RlpJcTFEZGFtaXlMdmxZL0dh?=
 =?utf-8?B?Tm1DMS9TNVZaNVhjL1lJSjZiK2FMTG5MYTIyb2RkbGQ0dXFQRm53N3NtVmxI?=
 =?utf-8?B?NXEyVHBoZlFJUTVoRkdqUWxaOW5iSEpkYVVXazVUYkpXS3BLd3plTk1zMVpN?=
 =?utf-8?B?QUF1S05CdVcwSS9IdVpDRFpvVTFqSGlTMDRaQVZHRXY4MjUxUU1ia3RvYmRt?=
 =?utf-8?B?OWZKTldFeWZER1JPSUxvMFdkd0JrZFUzZzRqU2FPaXhpTElQcWVUTWNXMVJC?=
 =?utf-8?B?R0EyRWIvNUNKb0hoSGUxM1RHb29OYzVFMnhkakFldVVCQkhvQkMxNG1NN01M?=
 =?utf-8?B?L3pHcjhSVWhuMTdtcHljQnc2WDlTMU1YdC82V0kvRFhQSmJRVjVlZGVZM1Yx?=
 =?utf-8?Q?8R2PZPDA5lPENIQs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A07A1FC5407BB3459E7760CDF1D2D7FD@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: ahq9aTZyiXY5ceOaEGnu/yd0Jx+7nH1AKJHB1Y05g/tJASImnt9OUClSEniFuWMfG7Puh9bplFrra4RWH01Z8+4LrVs+1C24eAt/Z07RdVGufHnj/fidl4l+cQqf4/8nlsEQMrOQ6PX3j3uILv6G3Zz81lFAuKmKg5lVKlxhNjRtvP7mlSKbG9ktSUXgNwYmH7p/ShQOj6MMaCHBIfGCb7ykOWzQ3zweP1em2tOrjW0N16i0YC+ROtqzu0i4lyffnT40xqC8Rd0YAIzQB6ly0xdb9rCOPjuB2PVgAjgOMcZmSXrGILdW34niAzkH3GcVKHyH8VoawMzIQjWrYPIrmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553f7f24-76ab-401a-64fc-08df39dc0974
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 18:55:32.3676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXZF4Om4n2ns8y+KVoO5YIFVpn8s+fDTTrHHRL1cs7L7hO8PCuZPrRcvP2oTUoGVg9dZH7glwjujQzA/VAHhRqzYdasnrG/7SoJGaUiRaBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9725
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTExLTAzIGF0IDE0OjMwICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gT24g
VHVlLCBOb3YgMDMsIDIwMjYgYXQgMDc6NTg6MDZBTSArMDgwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gRnJpLCAyMDI2LTEwLTMwIGF0IDAxOjUyIC0wNzAwLCBDaGFvIEdhbyB3
cm90ZToNCj4gPiA+ICdzdHJ1Y3Qgc2VhbWxkcl9wYXJhbXMnIGlzIHRoZSBpbi1tZW1vcnkgQUJJ
IHRoZSBrZXJuZWwgcGFzc2VzIHRvIFAtDQo+ID4gPiBTRUFNTERSDQo+ID4gPiB0byB1cGRhdGUg
dGhlIFREWCBtb2R1bGUuIEl0IGhhcyBhIGZpeGVkIHNpemUgYW5kIGlzIGFsbG9jYXRlZCBiZWZv
cmUgdGhlDQo+ID4gPiB1cGRhdGUgaW1hZ2UgaXMgdmFsaWRhdGVkLg0KPiA+ID4gDQo+ID4gPiBU
byBzdXBwb3J0IGxhcmdlciBURFggbW9kdWxlcywgdGhlIEFCSSB3YXMgZXh0ZW5kZWQgdG8gbGV0
DQo+ID4gPiAnc3RydWN0IHNlYW1sZHJfcGFyYW1zJyBsaW5rIHRvIGV4dHJhIHBhZ2VzLiBUaGUg
bnVtYmVyIG9mIGV4dHJhIHBhZ2VzDQo+ID4gPiBkZXBlbmRzIG9uIHRoZSBtb2R1bGUgcGFnZSBj
b3VudCwgd2hpY2ggY2FuIGJlIHRydXN0ZWQgb25seSBhZnRlciB0aGUNCj4gPiA+IGltYWdlDQo+
ID4gPiBoZWFkZXIgaXMgdmFsaWRhdGVkLg0KPiA+ID4gDQo+ID4gPiBNb3ZlIHRoZSBhbGxvY2F0
aW9uIGFmdGVyIHRoZSBpbWFnZSB2YWxpZGF0aW9uIGluIGluaXRfc2VhbWxkcl9wYXJhbXMoKSwN
Cj4gPiA+IHNvIGEgbGF0ZXIgY2hhbmdlIGNhbiBhbGxvY2F0ZSAnc3RydWN0IHNlYW1sZHJfcGFy
YW1zJyBhbmQgdGhlIGV4dHJhDQo+ID4gPiBwYWdlcyBhcyBvbmUgYnVmZmVyLiBSZW5hbWUgdGhl
IGZ1bmN0aW9uIHRvIGJ1aWxkX3NlYW1sZHJfcGFyYW1zKCkgc2luY2UNCj4gPiA+IGl0IG5vdyBh
bGxvY2F0ZXMgYW5kIHJldHVybnMgYSBidWZmZXIgcmF0aGVyIHRoYW4gZmlsbGluZyBpbiBvbmUg
dGhlDQo+ID4gPiBjYWxsZXIgcHJvdmlkZXMuDQo+ID4gPiANCj4gPiA+IE5vIGZ1bmN0aW9uYWwg
Y2hhbmdlIGludGVuZGVkLg0KPiA+IA0KPiA+IFNvIHdlIHdhbnQgdG8gaGF2ZSB0aGUgYWxsb2Nh
dGlvbiBoYXBwZW4gYWZ0ZXIgaGVhZGVyLT5tb2R1bGVfbnJfcGFnZXMgaXMNCj4gPiB2ZXJpZmll
ZCBzbyB3ZSBkb24ndCBhbGxvY2F0ZSBzb21lIHJpZGljdWxvdXMgc2l6ZS4gQW5kIHRoZSB2ZXJp
ZmljYXRpb24NCj4gPiBjdXJyZW50bHkgaGFwcGVucyBhbGwgaW4gb25lIHBsYWNlLiBTbyBtb3Zl
IHRoZSBhbGxvY2F0aW9uLg0KPiA+IA0KPiA+IERpZCB5b3UgbG9vayBhdCBqdXN0IG1vdmluZyB0
aGUgb25lIGhlYWRlciBmaWVsZCBjaGVjayBlYXJsaWVyPyBXb25kZXJpbmcgaWYNCj4gPiBpdA0K
PiA+IHJlcXVpcmVzIGxlc3MgY2h1cm4uDQo+IA0KPiBJIGRpZG4ndC4gSXQgd29ya3MgdG9vLCBh
bmQgd2UgY2FuIGRyb3AgdGhpcyBwYXRjaCBieSBkb2luZyB0aGUgY2hlY2sgaW4NCj4gYWxsb2Nf
c2VhbWxkcl9wYXJhbXMoKSAoYWRkZWQgaW4gcGF0Y2ggMikgaW5zdGVhZDoNCj4gDQo+IHN0YXRp
YyBzdHJ1Y3Qgc2VhbWxkcl9wYXJhbXMgKmFsbG9jX3NlYW1sZHJfcGFyYW1zKHUzMiBucl9tb2R1
bGVfcGFnZXMpDQo+IHsNCj4gCXN0cnVjdCBzZWFtbGRyX3BhcmFtcyAqcGFyYW1zOw0KPiAJdTMy
IG5yX2NoYWluX3BhZ2VzOw0KPiAJdTMyIG5yX2RpcmVjdDsNCj4gCXU2NCAqbGluazsNCj4gDQo+
ICsJaWYgKG5yX21vZHVsZV9wYWdlcyA+IFNFQU1MRFJfTUFYX05SX01PRFVMRV9QQUdFUykNCj4g
KwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ICsNCj4gCS8qDQo+IAkgKiBOdW1iZXIgb2Yg
bW9kdWxlIHBhZ2VzIHRoYXQgZml0IGRpcmVjdGx5IGluDQo+IAkgKiBtb2R1bGVfcGFnZXNfcGFf
bGlzdFtdLiBNaW51cyBvbmUgYXMgdGhlIGxhc3QgZW50cnkgaXMNCj4gCSAqIHJlc2VydmVkIHRv
IHBvaW50IHRvIHRoZSBmaXJzdCBjaGFpbiBwYWdlLg0KPiAJICovDQo+IAlucl9kaXJlY3QgPSBT
RUFNTERSX05SX01PRFVMRV9QQV9FTlRSSUVTIC0gMTsNCj4gDQo+IE15IGNvbmNlcm4gaXMgdGhh
dCB0aGlzIHNwcmVhZHMgdGhlIGhlYWRlciBjaGVja3MgYWNyb3NzIHR3byBmdW5jdGlvbnMuDQoN
ClllYS4NCg0KPiBUaGUgY2h1cm4gaXMgYSBvbmUtdGltZSBjb3N0LCB3aGlsZSBrZWVwaW5nIGFs
bCB0aGUgY2hlY2tzIGluIG9uZSBwbGFjZQ0KPiBoZWxwcyByZWFkYWJpbGl0eSBmb3IgdGhlIGxv
bmcgdGVybS4gVGhhdCBzYWlkLCBJIGFtIGZpbmUgd2l0aCBnb2luZw0KPiB3aXRoIGxlc3MgY2h1
cm4gaWYgeW91IHByZWZlci4NCj4gDQoNCk15IGNvbmNlcm4gaXMgbm90IGp1c3QgdGhlIGNodXJu
LCBidXQgdGhlIHJlc3VsdGluZyBjb2RlLiBXaGF0IHVzZWQgdG8gYmUgYQ0KY2xlYXJlciBzZXBh
cmF0aW9uIG9mIHJlc3BvbnNpYmlsaXRpZXMgb2YgdGhlIGZ1bmN0aW9ucyBpcyBub3cgYSBiaXQg
bXVkZGxlZC4gSQ0KdGhpbmsgaXQgY291bGQgdGFrZSBzb21lIHBsYXlpbmcgYXJvdW5kIHRvIGNv
bnZpbmNlIHRoYXQgdGhpcyBpcyBhbGwgbmVlZGVkLA0KZXNwZWNpYWxseSB3aGVuIHRoaXMgc2Vy
aWVzIGhhcyBiZWVuIHByZS1zb2xkIGFzICJhIHF1aWNrIGZpeCIuDQoNCj4gPiANCj4gPiBIbW0s
IGFsc28sIHRoaXMgaXMgYW4gYWRtaW4gb25seSB0aGluZyByaWdodD8gV2hhdCBnb2VzIHdyb25n
IGlmIHRoZSBhZG1pbg0KPiA+IHVzZXINCj4gPiBwYXNzZXMgYSBodWdlIHZhbHVlPw0KPiANCj4g
UmlnaHQsIGl0IGlzIGFkbWluIG9ubHksIGFuZCBub3RoaW5nIHRvbyBiYWQgaGFwcGVucy4gQSB1
MzINCj4gbW9kdWxlX25yX3BhZ2VzIGNhbiBhc2sgZm9yIGFib3V0IDMyR0Igb2YgY2hhaW4gcGFn
ZXMuIEFueXRoaW5nIGFib3ZlDQo+IEtNQUxMT0NfTUFYX1NJWkUgKDRNQikgaGl0cyB0aGUgV0FS
Tl9PTl9PTkNFKCkgaW4gdGhlIHBhZ2UgYWxsb2NhdG9yLA0KPiB0YWludHMgdGhlIGtlcm5lbCBh
bmQgZmFpbHMgdGhlIHVwZGF0ZSB3aXRoIC1FTk9NRU0uDQo+IA0KPiBTbyBpdCBpcyBub3QgYSBz
ZXJpb3VzIHByb2JsZW0uIEJ1dCByZWx5aW5nIG9uICJpdCBkb2VzIG5vdCBodXJ0IiBoYXMgYQ0K
PiBjb3N0IG9mIGl0cyBvd24uIEV2ZXJ5IHJlYWRlciBoYXMgdG8gd29yayBvdXQgd2h5IHRoZSB1
bnZhbGlkYXRlZCB2YWx1ZQ0KPiBpcyBzYWZlIHRvIHVzZS4gVXNpbmcgdGhlIHZhbHVlIG9ubHkg
YWZ0ZXIgaXQgaXMgdmFsaWRhdGVkIGlzIG1vcmUNCj4gc3RyYWlnaHRmb3J3YXJkLg0KDQpIbW0u
IFdlIGRvbid0IHdhbnQgdG8gaGF2ZSBhIHdhcm5pbmcuIFdlIGNvdWxkIHBhc3MgX19HRlBfTk9X
QVJOIGFuZCBhZGQgYQ0KY29tbWVudD8gSXQgc3RpbGwgdXNlcyB0aGUgZmllbGQgYmVmb3JlIHZh
bGlkYXRpb24gdGhvdWdoLCB3aGljaCBsb29rcyB3cm9uZy4NCg0KSSB0aGluayB0aGlzIGxvb2tz
IHRvbyBtdWNoIGxpa2UgaGFtbWVyaW5nIHRoZSB0aGUgY29kZSB0byBtYWtlIHNwYWNlIHRvIGph
bQ0Kc29tZXRoaW5nIGluLiBXZSBuZWVkIHRvIG1ha2UgaXQgbW9yZSBuYXR1cmFsbHkgY29ycmVj
dCBsb29raW5nLiBNYXliZSBpdCdzIHRoYXQNCmFsbG9jX3NlYW1sZHJfcGFyYW1zKCkgcmV0dXJu
cyBOVUxMIG9uIEVOT05NRU0sIGFuZCBidWlsZF9zZWFtbGRyX3BhcmFtcygpDQpyZXR1cm5zIEVS
Ul9QVFIoKS4gT3IgdGhhdCB0aGUgdmVyaWZpY2F0aW9uIG9mIHRoZSB1c2VyIGlucHV0IG5vIGxv
bmdlciBzZWVtcw0KZGlzdHJpY3QgZnJvbSB0aGUgb3RoZXIgb3BlcmF0aW9ucy4NCg0KPiANCj4g
PiANCj4gPiBJbiBhbnkgY2FzZSwgSSB0aGluayB0aGUgbG9nIGNvdWxkIGJlIHNpbXBsZXIgYW5k
IG1vcmUgcGxhaW4gd2hpbGUgc3RpbGwNCj4gPiBleHBsYWluaW5nIHdoYXQgaXMgaGFwcGVuaW5n
IGJldHRlci4NCj4gDQo+IElmIHdlIGtlZXAgdGhpcyBwYXRjaCwgaG93IGFib3V0Og0KPiANCj4g
wqAgJ3N0cnVjdCBzZWFtbGRyX3BhcmFtcycgaXMgdGhlIGluLW1lbW9yeSBBQkkgcGFzc2VkIHRv
IFAtU0VBTUxEUiB0bw0KPiDCoCB1cGRhdGUgdGhlIFREWCBtb2R1bGUuIEl0IGhhcyBhIGZpeGVk
IHNpemUgYW5kIGlzIGFsbG9jYXRlZCBiZWZvcmUNCj4gwqAgdGhlIHVwZGF0ZSBpbWFnZSBoZWFk
ZXIgaXMgdmFsaWRhdGVkLg0KPiANCj4gwqAgQSBsYXRlciBjaGFuZ2Ugd2lsbCBhcHBlbmQgYSB2
YXJpYWJsZSBudW1iZXIgb2YgcGFnZXMgdG8gdGhlDQo+IMKgIHN0cnVjdHVyZSwgc2l6ZWQgYnkg
aGVhZGVyLT5tb2R1bGVfbnJfcGFnZXMuIFRoZSBhbGxvY2F0aW9uIHRoZW4NCj4gwqAgbmVlZHMg
dG8gY29tZSBhZnRlciB0aGF0IGZpZWxkIGlzIGNoZWNrZWQsIHNvIHRoYXQgYSBib2d1cyBoZWFk
ZXINCj4gwqAgY2Fubm90IG1ha2UgdGhlIGtlcm5lbCBhdHRlbXB0IGEgaHVnZSBhbGxvY2F0aW9u
Lg0KPiANCj4gwqAgQWxsIGhlYWRlciBjaGVja3MgYXJlIGluIG9uZSBwbGFjZS4gTW92ZSB0aGUg
YWxsb2NhdGlvbiBhZnRlciB0aGVtDQo+IMKgIGluc3RlYWQgb2Ygc3BsaXR0aW5nIHRoZSBtb2R1
bGVfbnJfcGFnZXMgY2hlY2sgb3V0Lg0KPiANCj4gwqAgUmVuYW1lIGluaXRfc2VhbWxkcl9wYXJh
bXMoKSB0byBidWlsZF9zZWFtbGRyX3BhcmFtcygpIHNpbmNlIGl0IG5vdw0KPiDCoCBhbGxvY2F0
ZXMgYW5kIHJldHVybnMgdGhlIHN0cnVjdHVyZSByYXRoZXIgdGhhbiBmaWxsaW5nIGluIG9uZSB0
aGUNCj4gwqAgY2FsbGVyIHByb3ZpZGVzLg0KPiANCj4gwqAgTm8gZnVuY3Rpb25hbCBjaGFuZ2Ug
aW50ZW5kZWQuDQoNCg==
