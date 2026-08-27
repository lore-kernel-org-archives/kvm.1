Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE22D5A01;
	Thu, 27 Aug 2026 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870497; cv=fail; b=mnF63jbULznypHf1OTMUBC8751VnuiopcQSnVwMgEYX9SBCHNxy4p1BXGMCPKDrqmL+qQZefA6sTpBXX91RLpFNlbOdTAF2//5Yh67QO6865UctX4JzqZQ5zzWlh5PTDBEeZTVD9nOkTY1h8zIXmV6lv6L/ZviPrQcPmceCBuko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870497; c=relaxed/simple;
	bh=O1kwCrZrCR3WCKIyx2jAjo5R+C8VDvGETPMP9sgxEbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kvPok8mP5AijfLRV/VsmrYND5IC1TXQhT+ykFffD9zZ4GHGIvxM7Q4UXjn14GCorMO+znCk5YmrHOTzuBCVr7R4IZTeK/A6oIbPG09Hl3iYSjPNVgu9Jrg2qaAK4LAJnfJRgWf7l1BnHS6PBjk1VSfnRjkG3KQhL00s5kcEykXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jli+jAUe; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jli+jAUe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870496; x=1819406496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O1kwCrZrCR3WCKIyx2jAjo5R+C8VDvGETPMP9sgxEbM=;
  b=jli+jAUe+Y8Jxp0KRBre1rfH+eF6nUpYpR3SqUPm220qHcsHSnwo2Uv4
   wYbaFm6kbrMDsq6dx2Wn97bNZNPc+q826OCXblU4HMsr3dl7OxetcWYKD
   cwSPTpn8I4T+Rwbbirup3eu5PZHKtDm/EjEhjiPPMWIl2834tq2o0be9F
   arOdPGMy00JqPPWyLadtJbyp4S8xIrQCwans9MXHM3qPaWZ5r/U2V8vx6
   /YjXnp2T0be4eNWncJEst7CjEC+kdNKoGNSV0hS20HdnrlHMOu7+jiQvY
   bk1tPnJIk6V09EdxnF2J0MHiaX8RtIn0MKSQRTvZE3hpUAEMmgrb2Ivy/
   A==;
X-CSE-ConnectionGUID: JGptxlsUTPaDyotiplHBqQ==
X-CSE-MsgGUID: k6M9UGSQTNq0OyoHdWvG0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="98977976"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="98977976"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:41:35 -0700
X-CSE-ConnectionGUID: /in2k2qXRJ6WCmCOtxk1yQ==
X-CSE-MsgGUID: ZDPJhUQfQ0q7h0GCE9SS7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="297899697"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:41:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 15:41:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 15:41:34 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 15:41:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbI3rxnx9VQTnwgILeO3UIqHW5ZwL9xj8et+40AKztvem8gTjH38JUVV/HOF+o06RBRONlDzGValzcKkKoauubi46j0fnyh9xSvKUdSukgETpkCPD3A+gZkbFjibn33ksfuAiL0189BXevTeoP4U7mbYwjJf7eflLfZCnxgw947Rbv5SWYyvqwpgpgF+KRK+IZb1l6kCviCeaPadKncIPJx6AQ2RE597FpTmZrQ0GYhYv+6K4TGk/6VZ/8UQLMZceWRCc52z6mZonzpedvZtx7sGD93GIn/LCa/nWgKElr5ol1nUHWdQLREEXxn+8H1sIe5undqN/cJiLbCqNGZ3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1kwCrZrCR3WCKIyx2jAjo5R+C8VDvGETPMP9sgxEbM=;
 b=KpPvARkmZhP/8fZcraLxTS0MSUEn7gVRmrwyl1W6hm2GbRM/DILd3W9XkB5tOMTcEegJ9oS0Gtrhhnp4klsSUaxHDvDqhdrTy2C8x08ip+L3N8SavPDPvQJJm755Xl1aTsdlx27j0vFouCCbeRx7yh7mD9TzvtJOBwO8U+V50PHecIvdacd3RlErLgEX2/aFXq9T4cHGcoe2B8B5K7B4snWK1XNJjnOfAy9XvVDRTE3YpXRiF6OY1ySpCOAz4VxNp+ntk5TNW66BeAz86wgZJSGF8u4gDOvl0QLDldRvkq7sstZ7WYtfSMZZbovk93ftsPEZfcsP78HlAvwxWW6NqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ5PPF8EC896901.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::844) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 22:41:32 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0339.012; Thu, 27 Aug 2026
 22:41:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdH1YE/ME7/hSMIEe/+GB5P8Iam7aFAbAAgC2kzwCAAAU9gA==
Date: Thu, 27 Aug 2026 22:41:32 +0000
Message-ID: <6d47965f12754eb808ccfd93ff4926962de82740.camel@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
	 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
	 <20260827222246.GE33657@pedri>
In-Reply-To: <20260827222246.GE33657@pedri>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ5PPF8EC896901:EE_
x-ms-office365-filtering-correlation-id: 59b104a5-9dd6-4929-21ae-08df048c57cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: nm0nHzDsrD94211eOecWoQt29PcOEf5rswi4TI8gYvYFiu35FVZ9NSD88TRtRDwhBRSmfQLMrK6dKmBGqTDPv52fmoYai0aitBWZk2/0KwraEGD5g+7Qu4oioApdSPZ+iFJkR9LkG/b+F08xZE1fgmiyf8wPtW6QkSow5XEm5GxdEYE1kk/XypNM0VJmWNM7UP5cUzu1ZlzAdapseZ6WzNpV6DsVCX3z1YR0Mg+cY25xD5pAxKfTGJTNHMxGIB9f6Ks6L58Q7P5NozSrPta8/vTzp8DGi12yqzH3uuaa2ifrXeCcGtz7Ck+eNT3wRTkdHS9HAkD60tJcYIMPKGomZfhZmwivJDn5H/n23K5OHJt6wGRjVgi6h3FNqNqnPKItHQv2ZAZn/7gz5s5aTIPctT+utBRG41OKNAf1OnCUhvmIWbhe7kzuJEAqW/V4h3QQvGxE6tE9qIU2u3NAQp+zrA8ie/8JTE1bI+iIhSf169TtPh1+mZsWbhqDj3OUQplD+YEEaKdKzKA1ORpmGo8G+WnXN6QV3Y5u+3marAEj2izzrzCxJ1j0uRDOW2YLNIGQDiCyJHJ1+bkyVD8sh7W+vnQSuwnsP2Poz3PZceT4l0MnntuHi4s7i1yEPWxbaHJrj50JDFKiuUVRKjValrz4SPMiOPXRUa14ZTRwQlFTclgYlM1keciHfZC0TWEtT64nM5GDEQ371nt1LP/wuEcERKwLPG/GssJh63KOo2ZKVoA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z29HTS9STmNWOGlDSkpUWEovY0V1KzlQMkd5SUxMUFVlV2lUZSsxellBR0Iw?=
 =?utf-8?B?OWdDM3A2K0tZT054MU8wYktmaEYzUXRMQmdFZ3RtcDZPcmVjN3lKMG9MWGVq?=
 =?utf-8?B?L0YyMGVRS1hiditXWUo3TUtNTHlzZTc5S0dhVnRPVm9QUlMycVFVd0xkUDBi?=
 =?utf-8?B?aWZ3UUhKZUhYUXJlWW1IRGVTbUV6RzlzclJXOWFFbkp6Qk9xVjlCQjBoQitx?=
 =?utf-8?B?cmhtR1Jxem1pT1FHenhzdXNJM29PaGViQkp4bUxKYXg4eVpPckVWeUxoY3py?=
 =?utf-8?B?a0VZRTZzZG5yRG5PV0tWYTNMZEdMZnV1a3NMRGxjNUVlNjNpTkJnbGk3bm1w?=
 =?utf-8?B?MzJMRjZpWDZtRnFpTzdLdWVEWnMwQXJCeklyenVPd1NSV0RSQ2RKbE0rZEtI?=
 =?utf-8?B?dDZHNng0cWFndHBHMTh2aFJzT0V3TmRqMFNGN1JCY2F6WHlFalRrQ3p4b3VI?=
 =?utf-8?B?RjY2Z2FXUWtnaGtFMmovK3h4SDB4OE9pUTVzSm9yQnErVWdWM1BaYjhuMVBr?=
 =?utf-8?B?N1JtTFlGTGRYMExRZ1M1ZjhLZUhGc2w5YnJ2T3ZnelBTWUFnRUhMWVBPRkVj?=
 =?utf-8?B?Sm5RZ3N4K0prVGxPZC9ZMUpRTGJwdlpkNGdQWEdibklqYWZtM0pRR2R2QnJm?=
 =?utf-8?B?WldNWlJxeWNkck9rM3FNUnJZZ2Z2dG8rSjZKcGpvbnRBdWdiQjRRMHhoQU1n?=
 =?utf-8?B?ODlOS1d4QU95bDBLQkxQRXVDenRoWGRIR3lmZHFhcnA5QXBVQy9OTm9hV2pX?=
 =?utf-8?B?NndkZ1B4WGE1akVKSEpGTFpUUmtRL0w4SmdsNHRSTTloaDJ5L01QWU90MXUw?=
 =?utf-8?B?Qk1DNXQzTWlTQUZ4Ny9yTlV2YTZkejJ1elAxazk4QnVVTUN6TC90L2I4SGxV?=
 =?utf-8?B?U3VNS0FLK2xkdytXK25lM1RBWUxtSmVyU2JMbW1ZaEhaWXZvb1pVUldvNFBp?=
 =?utf-8?B?Q0hGOFZvSkhPS0dOVS93QW9WdFoyOXIxRytFdk4yQklDbjJKRXdhcTBSVndh?=
 =?utf-8?B?bWlwQzk2YlcyTWZEL3EvSHBscHdyaXFNOUlGYzJYdEc4MGVnb0FZQktGOTU0?=
 =?utf-8?B?cDd1ejNlVnN1Vk91eWJmNlMxbm4rYmhLU2dJRGw2aVpVWlczREVjNHMrNllX?=
 =?utf-8?B?bHFPUno2OCtmeGEzSVh1U094UnVpNGpKM3M5dCt4WUh0TEhEbThISFhXcklJ?=
 =?utf-8?B?WUtWdzI3eW0wa2dzOGpFdk16OHlHVWYrQXdoRVBobTBkRzN3ZXlNVnBCbUxh?=
 =?utf-8?B?b01STFV6OGVDLzh0T2FKNHlTM1liYS8yekRSanlUS09HSlg4VkpHZnpZVTlW?=
 =?utf-8?B?ZTN2TFZUbFhsMlhaY00yclllZ1g0RUJrc1RWcjUxcE9lVWJsM3JDeWxzT3E0?=
 =?utf-8?B?N1FRbkVYajdDaWlMUjQ3elJianNTQ0RtOHJNTDNIMDV0dy9FeFRTVURQME9Z?=
 =?utf-8?B?blZEb2VsZDhxcnpOZUZyOWpocEJaWktPN1N3UzliMzU1c0VtSmdwOExqMHBC?=
 =?utf-8?B?b1c4blZ5WDlITGI5WUZxSTYxTHdQWnozczRyemEvZ2FEbDlqclROenRMV25V?=
 =?utf-8?B?ZjFJWWNIaTFnWEVRazk4VDdTYTV3V2F3S2E3VW1QYzNDMjdoazlXUDlYOWpS?=
 =?utf-8?B?TFF1N3hVQjI0cTE3K1FENTNzSjhNMEhIeFBGSUt4S1dlb01PSitJY3hBdDN2?=
 =?utf-8?B?ek1QdEtSTjdxZ2FQcDl5TnF2MUNXYk5VMU9EMks5azBBWW9BRU4yWjlWVy9t?=
 =?utf-8?B?WG5vNld0QzJyWG9BR2FuRit2ZHhuS0xQYXo1WTFSK3R6N01ORkpxeFdPWXdU?=
 =?utf-8?B?dWgrdEtWeVFwRHR2ZkJrM1dFL0EwQ1c1WEcvNDdtZGpmT1dIVXpUMFB1YzZT?=
 =?utf-8?B?OTY0K3NMamVhQVp3VUhTSWNWZlpXc3lBZVR1a2xDWFNUcHNsMitBeDNLVnMz?=
 =?utf-8?B?WmJoRStQaEVMS1JLaHJTL1ZiQTgrczIrU0FDYkFQbUdPMUxvL2o5KzRSNUo1?=
 =?utf-8?B?S3Jsb3FGTWNxMnhyZVVsRzl2QitFbEF5ai8vOFE2NTRTWW9NQUJHUGxuT09Z?=
 =?utf-8?B?NXZrNk1FQ1UxN1VjREVhZkNreWVtK09pWmRhZ2l5Wm13WG9wREhhNys2b3lm?=
 =?utf-8?B?Mi8wVlVxV1ZLaitEVHdhT2JuL3lSS0pDTnJxQkFyQlRGL2dOS1Z0eFVUSHRs?=
 =?utf-8?B?bTYyK0FsdWFQNVBBaWxXVkRlRndtVWFwelNrTFZ1eGZiM2hzVVBKVTZjRkhR?=
 =?utf-8?B?bGswUUZMeHM1UXZRbTR0NlgvdU8yTlM4R09DWFE4V3ZHTy9rVFhob1R4ZGVq?=
 =?utf-8?B?dnJQWDRKQmk4b0lrOGlsbGZxdXhXcEJ6WXl5cmJ0ZUlIZCs4MHdTR0dNa0p6?=
 =?utf-8?Q?LOZW4BQRGwxRxflM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4E0CE04E8818A4FA5CBC05F52CA1EA1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vOrm+tfomzz0u8wqEqY2ULdFOxBlSX4RvWK9HaIrSUPIWWCEYIbe6vPMObjkRBCM+7CtVjtqGD0kO8cio9kgJMpcU3XdQiJ2P9JuMRPCeIoGVRg+pqVq+g33kjrblLNCzpVxcvvLwjQIE93RWmYITbwKEmN2w4cfExJAJ2Q/Ij5FWBkygu+tS85k63Iv/eErBgyzk+u3/LH0fpc3+UVHs21E14qNuQt/oR1+wjL8FnzIdD7YZcPL9YpVCQFPRjipismcMO4YqE8gRLziy6dboiGrdZetHeVooY+m6z2a3sUxBr8wlGdYsIYb43HlrwHaWM8yimvDx6Qw+5rmtsi16Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b104a5-9dd6-4929-21ae-08df048c57cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 22:41:32.4536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwgZP3Ft9i5oONgpmGYKl94oAcywbxHhMO7tVUiXCPGk9rNZ+14ptOBsUDd8ZNhsSNzUwpwgQsGLYOpLsVkD9GomTZEtCotgVYmT/fSXk9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8EC896901
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA4LTI3IGF0IDE1OjIyIC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiA+
IEZvciB0aGUgRElDRSBob3N0IGNoYW5nZXMsIHRoZSByZWFzb24gZ2l2ZW4gZm9yIHdoeSB0aGUg
aG9zdCBzaWRlIHF1b3RlDQo+ID4gb3BlcmF0aW9uIGlzIFREIHNjb3BlZCB3YXMgdG8gYXZvaWQg
Y2hhbmdpbmcgdGhlIGd1ZXN0IGJ5IGluY3JlYXNpbmcgdGhlDQo+ID4gcmVwb3J0IHNpemUuIEJ1
dCBhY3R1YWxseSwgYXMgdGhpcyBjb3ZlcmxldHRlciBwb2ludHMgb3V0LCB0aGUgZ3Vlc3QgYnVm
ZmVyDQo+ID4gc2l6ZXMgZG8gZ2V0IGNoYW5nZWQuIFNvIEkgdGhpbmsgd2Ugc2hvdWxkIHBhdXNl
IHRoaXMgc2VyaWVzIHVudGlsIHdlIHNvcnQNCj4gPiBvdXQgdGhlDQo+IA0KPiBUaGlzIHRocmVh
ZCBoYXMgbGVkIHRvIGEgbG90IG9mIGdyZWF0IGRpc2N1c3Npb24sIGFuZCBJIHRoaW5rIHBlcmhh
cHMgd2UNCj4gY2FuIHJlc3VtZSByZXZpZXdpbmcgdGhpcyBzZXJpZXM/IFRoZSBtYWluIG9wZW4g
dG9waWNzIG5vdyBzZWVtIHRvIGJlDQo+IHRoZSBndWVzdCByZXBvcnQgYW5kIHBvdGVudGlhbCBh
bHRlcm5hdGl2ZXMgdG8gR2V0UXVvdGUsIGJ1dCBub25lIG9mDQo+IHRoZW0gY2hhbmdlIHRoZSBm
YWN0IHRoYXQgdGhlIHF1b3RlIHNpemUgaXMgZ3Jvd2luZyBhcyBjcnlwdG8gc3R1ZmYNCj4gZXZv
bHZlcy4uLiBTbyB0aGlzIHNlcmllcyBhcHBsaWVzIHRvIGFsbCB0aGUgb3B0aW9ucyBvbiB0aGUg
dGFibGUgcmlnaHQNCj4gbm93Lg0KDQpZZXAsIG1ha2VzIHNlbnNlLiBEeW5hbWljIHF1b3RlcyBz
aXplcyBtYWtlIHNlbnNlIHJlZ2FyZGxlc3Mgb2YgaG93IHdlIGVuZCB1cA0KZ2V0dGluZyB0aGVt
LiBCZSBpdCBiaWdnZXIgZm9yIFBRQywgb3Igc21hbGxlciBmb3IgcmVndWxhciBmbGF2b3IuDQo=
