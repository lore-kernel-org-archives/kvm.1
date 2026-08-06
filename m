Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545CC3E1203
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053286; cv=fail; b=aEIYpFO0zJ4faStDq2MFhMYKkAKSy8j4iPqiCvdn54pE6EQxlBgTlHk0HmcZ4cnFMUKbe/bUInlUYJ/PL11dzKk/cXiQ7bToNKJBHNocbFltkRQs1ZIuj5RFBCan4FmobrEDYYhSTZaWY205e0nZfhX4K2enNy5714RPredz3cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053286; c=relaxed/simple;
	bh=+0kO4Yoz5aDtvMb37ZXcuhFy2fCgnDPZTrp5nNXcEVY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NIzBn2EMEtbsNDz47YT38OvEMeADFRZ9fXTnNcnRvwMQXIY/hO/sjmUcBO21oLZzcv0CbDDCkXS3/Oon/uyuwJR6vxIzShtf2J8rXx/nH9G1TUFUs9CIAvM3lhT7iPzw9ehyypcQ93p5+YixA0Ss/bQ+n1gdnjR2AF44ixuRPeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNLHW1XA; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNLHW1XA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786053286; x=1817589286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+0kO4Yoz5aDtvMb37ZXcuhFy2fCgnDPZTrp5nNXcEVY=;
  b=bNLHW1XAM9+4MzRr3SQ9bgTXCZjwAsrgJVwstOB7jZZvZGQADsdFUR36
   +OenMw66kEHWfuE+m39Qii0e7HszmzV6o1RORClXz3Ax1YPGz4BnaEjOi
   Q1MkdEDnPq8he3ekzO1Ya6BW7Noocry5u/8IH4U2Djt3BvsyFn0SZKacM
   ccWQZ1mLtVmJV376MJt5l7JVp6JbaQLJwlT/ln/GC1f/zanquP3X9FGNx
   uMRXSZvu73ovRvd8xyJs2DebuHxv1HIG/SHI9l2APOakVdsfegOvmU4MU
   L0+LwMLqv0yABo2nI+9OtgZu6wEpIl6VU17xT7sSi8BPgRhs5USvM0JlD
   w==;
X-CSE-ConnectionGUID: AAARCE11Qoi7OPFHAVpXyg==
X-CSE-MsgGUID: b/93fgLnT5igZcY33o45xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97013332"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="97013332"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:54:45 -0700
X-CSE-ConnectionGUID: suNvTCdtQo294t/X8u22Tw==
X-CSE-MsgGUID: f/rI8TsPQuihGi0v7WGMiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="292113047"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:54:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 14:54:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 14:54:44 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 14:54:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdNtGu8csdrCG+z4wzs/+SRJdccAJZT0jLGImaBlF7BTRcNVEIlQB6CJvzYuHnKpdzh5y4AmO6ZnmV+Dv3sX2TNLPCNnimEWLPFS830sIs54tF9vBJnAQ/fmfCgU9hLuW+o4evC9EK6kQkeZCJEJtLNCwOvonBhPle69ptpluX1p5DUrEb6C2lNIZ21XpETkF9JJigjPGAzqho2j11QWHrgSfmuWt3ERT6vAvQ7uJtJnGw0GkedSkRHmm2m4Cylur9LCUWeiWdTNQ2uBSuMinIjsbUzJM+UvKLdOvwdUdr6BIh9CulH7Mf4wf8Y35kUF5GnRa+OtZk7yeJKXrXH25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0kO4Yoz5aDtvMb37ZXcuhFy2fCgnDPZTrp5nNXcEVY=;
 b=uo6CDzxdOzTsIWvqDmRzkBKEJ/fCsNWKy7bM43ugNnbQ+Kd9tCGX7RFVegeQl8fEtyp0N6+RodWK1PAeekv0qmQ6hCVOOcAB3Y+PcyhjlOu9JS/iyDqBHBI3x5/VISkp4/r5088C6o2XfQs4hW0D3WfVUG6jaZwIqBdGxDBPRPWsYbLnDyoCkDOYSMOISn9e6AdQpdka2f6a/ZzVhqrajxJiPXlpY69OMLiyB1MAlBY4UFN9iTM8p9gOqgWxSddc19rF9aQLU/w/yR3iV6Ec2pmehzsclGtduyrjku2UJr914KsVc/lhatnp51SkD8mISHl3vQ+bDhUJG13eb+Afqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA1PR11MB9471.namprd11.prod.outlook.com (2603:10b6:208:5b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 21:54:42 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 21:54:42 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v9 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Topic: [PATCH v9 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Index: AQHdJUiUy3+j1SbwZUmV0abDsS16ObaQnGQAgAD1aIA=
Date: Thu, 6 Aug 2026 21:54:42 +0000
Message-ID: <ab6c4f0db53c15fbc1300d1074dd3bf3eb56d759.camel@intel.com>
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
	 <20260806020850.1221381-9-rick.p.edgecombe@intel.com>
	 <20260806071621.3EACF1F000E9@smtp.kernel.org>
In-Reply-To: <20260806071621.3EACF1F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA1PR11MB9471:EE_
x-ms-office365-filtering-correlation-id: 9993236a-fcfc-414d-04b6-08def4055253
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003|6133799003;
x-microsoft-antispam-message-info: eZ/S4mqFgVVAAlF+0ocLh0kx8QYOkuurydzjj6kdrzP0jqV4YyBK9c4EAjvehBjG5rrCROVFnYWAeD+IlVTvk5ZI2vf+Yvsubv1BaZNXmcGo2+k6ADEFotVeRM8ADDz5C79BhC/PbELlZgdAKgqE4Xkjydd5fMJ2xGjvPYFf3+7VRKKxQiIB7OpM4rl3gzX/EmIZw+2LqjrNtjUhHH8QOxVDK0CDxwIO4Gabz8kX2fBE95qTmpFZQUTV7rKkNa7+2zOZtOgfvVY2CnkLbrwZjQjDN/im11yMORvQm9i5kqSaZRqqFJxXX0pH5p2psb1RQtTmpwOm23roL94T88AJYbWidbjtzi5Pt3ObexLRwEh32iHL84xGijNivaFaRPSMwQIHSgkFel4cRpbwcUP2ru3LE6H1iMjAApgo3PT8fTaL8vP+L4hC5MKdskZa31AcO+SRntCg1XWppBEiWzlkG3+/zHVuayqgAyj4bEwgPUrBzC6uAWY1g2WO6FbiDUJ/G7EGpbDjnmPL7niBzeiFVgKPwNYAXRAKXGaFYYjDte/qPWqSHMrye7d/Iso48TOpu3G5I2Ea+tJbbtwvuDqAzgyEbNSmBZiLp5ThLM1KjMKotavCCoquKLiGycL/TPR1gt/aX2Tf+KCBn7s2gBM2+P0ZhGdry6FX2AjkrcdPUXaZKTPzgMw3yJicm7D2pVgiprCBEotbXXohtjevKtfGfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEsrOHArYndYdEcrMWgwK1RscmxYTURkZWFtditxZ3cra0VLdlU1VTB1OHZI?=
 =?utf-8?B?TmFBVjRTTWN4MHZRTVVsOFppR3pLdlhHTDJvWFFlTUhPbFlXUFpUdkpaTVNH?=
 =?utf-8?B?bXYxRHI2T1c5UVpZai9wVlJtdVFsd2RlR0lkdVpYcGd5VzFPN3kwY3ZMenRW?=
 =?utf-8?B?NmViV05tNnBzQ09vVEt1SERrUDBoRzZvWWh0YjB2RWNMVHRCcERBVy81Zm9C?=
 =?utf-8?B?YUlobGVDMkNrNG1Bd0lzcWZma1hickl2NHhvK3gwN3JNR3VSblBQS1BaZmsw?=
 =?utf-8?B?YXVMd09FSlkrcGIxYVp0UTYwQi9WcThIYzVma2MyZnIvK081OTRUZktJU1BB?=
 =?utf-8?B?dm5zUUNyWVpqVnpoN0crSnUzRUxpNFVjei93ZHVlSUQzMk44dXBqdEVibGlj?=
 =?utf-8?B?bjkra1o2MmR1dngwKzhnSjhlRXpUSURzMDE2cExsR0lCR2w1NFZGL1dNRFAr?=
 =?utf-8?B?VzA1aGUwbTZBMmw4WTlvRTV1UmxhcHQvMEdwMTNBTHpSNDlZTkkySmVzODY2?=
 =?utf-8?B?a1Y4RE5NTmtMZjlBZjZtU0FrcFl6V0RkZGFyZkZvc1RDN0xiUCtjUCtFUFFC?=
 =?utf-8?B?WUlJYStycVh1M1VGQ1k5UDJ1MTdENXJnT1FaS3J0V0ZrSk1TbFpwbUxBMGpa?=
 =?utf-8?B?RnJoemxiSVQwR2NXck1OSXIyNGE3bUUxU0x4RnVGZVY5RFJGa3NyUTA3Rmly?=
 =?utf-8?B?WFBOVHhjbklGTVcxUzVDWC83VzhzeVl0ODRWN2VPZjlEVC9ML2RySDB2ZVI3?=
 =?utf-8?B?YkpBR3NsaGlHbHhoM0tsWUQ2bEQ4dHFwZERIT0swMXJPZHJkbkJ3RE13cGhT?=
 =?utf-8?B?d0hKOWI0WlExbnU5TXJTS2NmT3pEb0xJdXZwOUQweitucTMrMUM5c1ZhTVBu?=
 =?utf-8?B?ZEk3M0JjZmFDQnc3SVM5ZkxON25YaGNvNE5ZaTcwbWdPUFNvZWMvWXlaZHh5?=
 =?utf-8?B?YTdkSnBsTStWWnhoODFhZ1U1V05WMmVhZ3ZvV3lCNndUUGlkdUptdHJpMjVN?=
 =?utf-8?B?bHdIT3N6L2QxTC9DZUFHNGpVdDVYMXVKSnNwRmlPb20yNUU2bmpZSkV4Q3FN?=
 =?utf-8?B?aXNMajRTTzZYS25KeGxuRHN3K2xlQUh4YWx5dUhLZ3RFTk1QNTQ2OVlGZit3?=
 =?utf-8?B?aEkzTUk2SHJvcm9PY0pUZ3VRU3hjRGMxa2lybm15OTZRSS9EMTJQNDJZdkxj?=
 =?utf-8?B?dm1UZGNDZnFXZHpBWWZZb1BhV3R2MzAwYy9SOFRUQmZHVHVCdVJZWk9uTklh?=
 =?utf-8?B?RXpSNGRybHBBVms5Nms3NkthOTR6aExvTEs3N21oTEQrV0Q5TllrcENXd0JU?=
 =?utf-8?B?QjBPcjhkWDlTdFR5MlI2blovOC83UFdzZk5XWHUwNVJ4Y0QrbjJ3cGtPVnND?=
 =?utf-8?B?eTdranlLYnRTYlkxOE16RVZ6UDBrYWxlRGRRR2szYmRqWEU0S2tPTjdUZ3J3?=
 =?utf-8?B?aXM0REhIN0tHcXpKR1B5WDBramJ2dGRMS0psR3J3MmV1ZnYrdnVkNXVJQ3RC?=
 =?utf-8?B?Z3E2VXRuQk1laWJEYkxFb2lnTTRGajZqQWkySXJUZTZhSlBHVlkzUVdxRWEx?=
 =?utf-8?B?RU5rWTkyT2k0NEZGcHRTemtkbWZsc2xHVXlSZC80eGo0WEVqQmlTdm41L0Ja?=
 =?utf-8?B?RXpjV1dHWllwZ3ZxTG4vMXNrWmkwaFZ6bTZaeXhCODZ3MS9KSG9reGxQc0ta?=
 =?utf-8?B?b1dyV1lNNnBxVEpRQTQveFZ3RE4rdm5IZzVRdGJsL01RWm1RRzJZTUVqbktj?=
 =?utf-8?B?Tmo3Q1NHOHJQNE9NKzhBV3dzOFg3UzFvV2JiM0lTcVVsOXU5SjNndVVROGNI?=
 =?utf-8?B?Q1dDNW5zU0doTnZTdk1MYm5NejVmbS8yUEVycHBxUTJOc2Ura05oRmtQeENk?=
 =?utf-8?B?Q2tzelE2YUtpaHA3QVRsTGs3cTErQVg4dXdQM3c4ZEo5OE1FSGoxU0s4WkIv?=
 =?utf-8?B?RFFFSDYyL0YzY2Z4c2RMbW1oWTg2L20xc1Z6MzJXc3ErZVQ4eU8rZmVySnpK?=
 =?utf-8?B?M01PU2pUTnVPeGpJSGJNSDdaakRhRSszN2hXd3k2L0xzdDc0eGZqNG1BVExJ?=
 =?utf-8?B?Rno3U1g5UFZrMHNtS1dlSkhhRCtGeThqa3ZvVzdKcHRKcnhENVEyc1IyUUla?=
 =?utf-8?B?RUpGUHJJWU5hczFDMXorZ0F5MG1EKzNXSXJvR1lIOWI2RXplNzV1ZDlwbEhB?=
 =?utf-8?B?dlduR2xxbkQ2VkNxQkovN1BobkcxQ0RpaFMxa0dQOE9ySi95TTNoREoyeGRl?=
 =?utf-8?B?V1VIV2x2aG0rRWVveXlObU9GS29RTHdrWmc4RkNtaVBvQUZpbC9BYmIwMFlm?=
 =?utf-8?B?LzBHbzRSQXcxVzZCdllWOTRJU042djQxdURGVmttQ3d1NytudzlyOUQ2VDlp?=
 =?utf-8?Q?Me31xKpOc+r0VgOw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3CE263FE64918438A26D6BE34DD15A1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rtSbZY3v1xtqb3t8KXR6yOpYZBprMnIFe4GuwJjBazpi1sqgc6MqWxgp/UbJ/OUmZBGr8Jq1GeLEce/ZTd9UK2MZhZOAArKvofylkrJXO9ExysgLbkUbbUBnwpgfW3WP3oXFa1Bc3JEH78ELFRa8FmkkPaNUs+p67+R4Uh2EelWJEvHRp79dJ07lhy/jR+DzGLE+dFXPVsLMTqi6hdjQHoOYT4Bgp+BmFy/7LUItJ5YcXNEwVMOfrdtSWzOXVAH1ajRvsDzcBaGCwg+UWAoLS5U0d24tqOOjF9sD2+FW+DexCRY5FGIUliWpfPYCgWlMGzd6fgAQ0D0bXrQ5PTPq5g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9993236a-fcfc-414d-04b6-08def4055253
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 21:54:42.6353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YXszViiCOPZphd6ChqPTk+QCDYDYUYbaZqd2giowfWZPRc3hFx4uaRRRTC5GYh6QudnHI5p+8mQfHz91+KRLDKyyofYXtR/Akcs710C8IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9471
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA4LTA2IGF0IDA3OjE2ICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiA+IFtTZXZlcml0eTogQ3JpdGljYWxdDQo+ID4gV2hlbiB0ZGhfbWVtX3NlcHRf
YWRkKCkgcmV0dXJucyBhbiBlcnJvciBsaWtlIFREWF9PUEVSQU5EX0JVU1ksIHRoaXMgcGF0aA0K
PiA+IGNhbGxzIHRkeF9wYW10X3B1dCgpLCB3aGljaCBmcmVlcyB0aGUgcGFnZSBiYWNrIHRvIHRo
ZSBnbG9iYWwgYWxsb2NhdG9yDQo+ID4gaW5zdGVhZCBvZiByZXR1cm5pbmcgaXQgdG8gdGhlIHZD
UFUgY2FjaGUuDQo+ID4gDQo+ID4gU2luY2UgYSBidXN5IGVycm9yIHJldHVybnMgLUVCVVNZIGFu
ZCB0cmlnZ2VycyBhIFJFVF9QRl9SRVRSWSBsb29wIGluDQo+ID4ga3ZtX3RkcF9tbXVfbWFwX3By
aXZhdGVfcGZuKCk6DQo+ID4gDQo+ID4ga3ZtX3RkcF9tbXVfbWFwX3ByaXZhdGVfcGZuKCkgew0K
PiA+IMKgwqDCoCAuLi4NCj4gPiDCoMKgwqAgZG8gew0KPiA+IMKgwqDCoMKgwqDCoMKgIC4uLg0K
PiA+IMKgwqDCoMKgwqDCoMKgIHIgPSBrdm1fdGRwX21tdV9tYXAodmNwdSwgJmZhdWx0KTsNCj4g
PiDCoMKgwqAgfSB3aGlsZSAociA9PSBSRVRfUEZfUkVUUlkpOw0KPiA+IMKgwqDCoCAuLi4NCj4g
PiB9DQo+ID4gDQo+ID4gRG9lcyB0aGlzIHJlcGVhdGVkbHkgZHJhaW4gdGhlIHZDUFUncyBtZW1v
cnkgY2FjaGUgd2l0aG91dCB0b3BwaW5nIGl0IHVwPw0KPiA+IA0KPiA+IFRoZSBsb29wIHJlLWF0
dGVtcHRzIHRoZSBtYXBwaW5nIHdpdGhvdXQgY2FsbGluZyBtbXVfdG9wdXBfbWVtb3J5X2NhY2hl
cygpLA0KPiA+IG1lYW5pbmcgcmVwZWF0ZWQgY29udGVudGlvbnMgY291bGQgcXVpY2tseSBleGhh
dXN0IHRoZSBjYWNoZSBjYXBhY2l0eS4NCg0KVGhpcyBpcyB0aGUgc2FtZSBmYWxzZSBwb3NpdGl2
ZSB3ZSBnZXQgZXZlcnkgdGltZS4gRXhpc3RpbmcgaXNzdWUuIFNlYW4gd2FzDQpnb2luZyB0byBz
ZW5kIGEgY2xlYW51cC4gT2ggaGUganVzdCBkaWQuDQo=
