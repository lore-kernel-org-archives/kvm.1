Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93263264C0
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279553; cv=fail; b=ElKX2DRrSWNZhttNprEzpM5KeG1PrDmyO+BHzjXV9PnuQwSrWOKiboBnTBcE1IGiK+lKaomsubwObqDfSugma81w/a+Pd1Dw9ljSIcyGZlUqQZ762gVHpyol8VIjH7K+cMUl1I3JCCbuAJNsfBEG0yAd3rbjyU+EN9oStbXL448=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279553; c=relaxed/simple;
	bh=tq7mQrSq/IAuFillNd56U/TavX6LWqN6JusHxHgjupA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qKFqSDL/lrUjWEml4P4hEUNwIjlp7heDrtGLGXWriWVPSQj4layH93dOwowVWi0UfFCrW1Ry+ICh7pWbECIItYMhkD+EXklxBwD/wu/l91PFtCeioUlAO7zYuE2aLHOyBGuURCjYiQ1V4SZZMmWA28Ukj1qljSH5hH0D3+kwIV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JX3hEuQh; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JX3hEuQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776279551; x=1807815551;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=tq7mQrSq/IAuFillNd56U/TavX6LWqN6JusHxHgjupA=;
  b=JX3hEuQhOL1vqJl6j6t4BrIYYBsSAI1g19FBTRKhfDZuuRYfHX7JISw0
   r4vTE2CNmyzZ953N5QY4Xy8Q24RE+nXJ0IcDW0I4cm+RNs5kJua6uZrBc
   hqjAOBiFwWejoXxpv1NPScF7pi7zAWfBGju3fAd2kGiTeGrt6I5e6vNia
   WKWEsyxlQqhFvuzri11Hs2Ew69nNYP/1uuKhbnUmMgE+cVoQSGEvyxfLw
   dwAF/xXBQ/q3WQ7yuaIhYvH2blhOFOX8fWrOW0MKs5xI5+XdJnmzP3Szd
   S3H7GBx2Dt3DSA/HBhcQ6b129VaH9T8jjAlVYNtPKMtxERRRHY281cvoF
   g==;
X-CSE-ConnectionGUID: 4DkY6/ZjSyC3HoLdbri90Q==
X-CSE-MsgGUID: FJN7CBuwQ1qeCXiMK7JgLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="79853442"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="79853442"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 11:59:10 -0700
X-CSE-ConnectionGUID: Pqy6QZ/5ROKOYQP2RpduUQ==
X-CSE-MsgGUID: yJM58O7UTAGqZXsSNpUYyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227338767"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 11:59:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 11:59:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 11:59:07 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 11:59:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfb56amdjOqzg+Uv42Q7FiLlcXVvrVbYmYLDpEUAh6osGlFb6q4ygeG9u2/o1uhaazDoPfM6lv/Y3tdVqjxveJFp6J7YbQYREv5jV4oQZJ+xg4Qmf7nh3pTcqCqzMrUVE6lkLD6jj6ukVZzACvn24Vzut25dQdhsTazRPwYmh6GQJkewg5jlrNp5r5pKG4RCIueb1iRuHaxgEdKYnukweM+eJ2SkjHT2fzQGsIVy1kJBIrDubASzMm2Rfg05EqgoaHXk84XhlKZAQ2nflZ0sp3LgVn+jVMCeFbiToXMU96m47qt17DV96Vs4/PnM/eNae8uytG7vSHjd8DHhrWEqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq7mQrSq/IAuFillNd56U/TavX6LWqN6JusHxHgjupA=;
 b=SQPmZnC9CZU1pLRhrP2HYHfhrH/XeB8J0MASyIhkhMmhyq0ze2x1fqf3LBNw4kjqtdFg+pliTdN3mT9Ld/FKd5oQmRpyRp+5a/ZZmrnxekoK5oyIoZC4za54Esl2Fhy2QYPNZ8fmLRLHPE3kFF6EYqlswMYiX5rNehLuR4/PHjtPlz0pHpIeGY90ysOUEqtFsobEASza3USpPIouAR3xnIwmy3Ku7XobdrWm55H9DQGcTLfHQxNvLIIS/BSHYROyflWOK8Z4hUIPqsJo/7Ay/LAZoRc4BmJjg7Z7SEHHF0V+oBzfRIMky02GN3jJ5qnUyFTDKilWybOPPxXxUN3WRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 15 Apr
 2026 18:59:05 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 18:59:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "michael.roth@amd.com" <michael.roth@amd.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "djbw@kernel.org" <djbw@kernel.org>,
	"Weiny, Ira" <ira.weiny@intel.com>
Subject: PUCK follow up: Trusted IO call details
Thread-Topic: PUCK follow up: Trusted IO call details
Thread-Index: AQHczQnudqrpzk3JFECXhnBHj5eLAg==
Date: Wed, 15 Apr 2026 18:59:05 +0000
Message-ID: <1f6e9052c0c748f023e880503ed0001a9a919599.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA0PR11MB7307:EE_
x-ms-office365-filtering-correlation-id: 3b428c23-ea2e-4bcb-8bb0-08de9b2110e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: RG60tKroRyHHp/PdfWkeNXX4GSLLNDH8+0BrPVgUvSAs4sXTeRzImKxGRxuB0oHbk+5xfzbtPKVxR3YGPGFXi9U+UDC/yn44Ak6rCdXU0aKKkfEIfwrKHLl3QbT/xyQjnETnxQ0nfnY1Rukm5+RCqmHvtDrsL5Lkrc6TID0YOt5qGgQlrccemXCJvEcincpN+dzQvZQ2rqiHdbrujA55wiMLgdAUmj/r+SGRf2/V1IdcUzYI/z/fNuvL042wF5hRg5FlOG5KsqJ7xWGN+O2wdh6tsq3ljFyZdUkTPtONc+J0VdUo9qKfFMJ/UboE9cSEJ473K7qx2c7HVnK7faIK04aaH51PuPv8bfnzcjzZmKzTx9NU9WCc/QZZrp76+6zUHrAy3bgw66rgx24g5pjKhGP8ZgOITVYYdWR21SFIzu0VdFja0CTNn73/ZZJQEPzg/2cHLzie7iPtDR53s8KHLvL+qg5HoYU1ghSf12EDHaGVALBUJKjBcg5Esd10H1AuS27d21Uwm3WQKQCCos4gI+WYTYiIdL8YAb6WvnUSxgdeLX+TqXcohDDI4uCGKzii4NEo39UK9jSV9UYpxrueDE4WI8AaQZtxhKYxX0V7gMRiuCQSlkeOSFTqtRbd/xi/4me3CZgXywI1bwEFHAXV6qynjpzIIG51SkP/FntMWCCUTT3DTyuYPVxI167KBv8PzD63IhPYeeoso9Af9PUxydDmcBDmAZy13NXvwxfcUes=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFBJdHlwbndCZzh1bW9TaXU5YW43MXVFVjRNSndyaklmTm1PRkpNNzVCeUNV?=
 =?utf-8?B?UkR2dXJEdWptOXo1eEViOWlMV0Vzd09uaGdyR1BJd3RhVGN0ZGxUdm8zYVBn?=
 =?utf-8?B?cEVjVmMwcUxqb21qdFpiQnhJMGdiaXBXbWM4OFU3U0V0NzQ2bjkxK2ZHWi9j?=
 =?utf-8?B?UE1WS0ZDZ0lmNnl3YXpKWVZMZ1NMSG9maHM1anJ3MEJiRklpSEY1blk3cm1L?=
 =?utf-8?B?SUFJNEtMdzFNeXQ0RWxrVmxhQXY1WURLSGxDajFMeWdQMW5DUTc3V1lTQndV?=
 =?utf-8?B?Z2FjZ1d1OEZKQldGbDg4N28vNHJWbWlFdCs3MGxEcU9RdTdaTjVnQy94SEdI?=
 =?utf-8?B?RkVQSGJjQTk4ZFZCMkJYU0k4TWI1alpQRzUxeVdJb0Ixc01BYnI5MTUvNXRB?=
 =?utf-8?B?elRXMWVCMW55UHV6aDM0Q2Fxek55S3RUZ2dTME16WXp0L3pZMVhESm9nY3ly?=
 =?utf-8?B?cURvbm5iLzRXUWRrd2NiZ1p0V2hpRUw3YnZueEpML3NBODBpOFZZWHNWeGZN?=
 =?utf-8?B?NFdIN3RTMXljdzNxcXg5cnBIOTkrL250dVpLV2Z6VnZxQ3ArM1RGa1VwUlZ6?=
 =?utf-8?B?VlVCczQrWWs3S3MvVHl2TGFsc1RDS2RVSUFoeUowQnFJZ0NoUk9pblYzWUt2?=
 =?utf-8?B?WUhTY2ZDeWd0NDVhOUt5ME02T0F3L3E2ejZkakwvWjU0RDBlSU5hTGExUkVP?=
 =?utf-8?B?YzZVa2JoUVlBWkN1U0NNV2xON05RZUlDM25OY2xBMFBCNGFPWTR3VDZQLzBW?=
 =?utf-8?B?Rk1OUGp3b2JzTE90cGV0UEhrVktjZWwvL0ttbGY0N1pjSmVZSS8rNTNudS9j?=
 =?utf-8?B?d2hsYzViSWJnSXRRRmpoeUN1UHZweHE3Zjk0NGJ1TEdZT3pmMVVhUmYzbWRn?=
 =?utf-8?B?M2xNbGJManJFNCtPQ05FL0dkRGJyenlwT2F4MUZWSTBEOFR1UXNDcWxBZUwz?=
 =?utf-8?B?ekZSbGpiVmJuUGJzNDRjbkU0amJ2SkgyZjlWYzU0ZU9ZNVhhR1o0OHlRek9Y?=
 =?utf-8?B?MEQ0TWpnSm9FeWQyOHZxRFNpakFDanlBeEJ4SUZEWk1FQzk3TTk3cW15WFZ1?=
 =?utf-8?B?cWRRc0hKZUxGSTFqMTk4R2YvdVZKQ0cxakVqTkdCT3R5YkxrdWQ4aU9ZUXN2?=
 =?utf-8?B?L1oyS3djWXJSN1F1OWZLeW5TWDAxaHQxUXUzTGNuQ3lDZGFoZUM3RDM1SWtH?=
 =?utf-8?B?WHhKNFFMd3VQK0RSWGU2R09RaDNXZlVHd2FaSC9taUsrbEJBaVUvNmRHNzls?=
 =?utf-8?B?SHRST3dTZTJybkpLZ0kzUkl0c0d4VU5WQ2RKZVBnbk9kcUErb2o0M0VSY0xr?=
 =?utf-8?B?b3FLK20vazNKSnhPcDF5WU83WHZ0RTBSSCtTLzJXRTRpUjBRK003bS9ZV2FR?=
 =?utf-8?B?N3VpVDJCYzBJNll1UVJ1dW9HcDA4bUU5Vkg0TFNGbWozR2NWUFEwQXZoYWVL?=
 =?utf-8?B?eElvSElhazc2MlN2UHJMaUJMY1hVTkQ4cEpVT3V4SFNhL0w0cEpMa3ZGTkJq?=
 =?utf-8?B?MWhta3FPNGcyaHVQNUEyUU9VZ2tTaWIyZnFVRHA0TVlzbEhwanZISHJWWWJu?=
 =?utf-8?B?SEtjMG92L2FGbkZBY1RNa0VOelU0MFFYZ082aHdsdzM4TkoxQ3pMUkhzbXNi?=
 =?utf-8?B?WTZhL2hqYUdPRHFzZDFaRmI1V3JLY1JSUVh2NFAvcmkycmpqTEp4R29GS05K?=
 =?utf-8?B?bENNdkZyZU10czdBZUxwVjZiWGdjenBjVVVSSGszOHR5UUtGSUhURkRkVG01?=
 =?utf-8?B?RTN2Mm50Vnp3Z2FvMnVIN2svU2I5TnFoZ09WMW1jVjJhRkloK09qMDdoMW5p?=
 =?utf-8?B?RlUxTU14SjFMeW5yTWtiVCtkYWRPVDlaRE16T2Q1ekJyRDNFQkRaZHNOTk1v?=
 =?utf-8?B?MGFXeXY3NW4xVUhBOTVtTm56R1NCRHQ4dUgwSFVZelhRbWpBNDF2eXp2Unky?=
 =?utf-8?B?ejUyMDJpVUl1Wm10U1kxcTlLb04yNXlNVEltZDhWOHVjZG5hZjkvVndwMlVR?=
 =?utf-8?B?UUR5emNEdGUvdXlucGg4Y3c5aUswUU0yNW1BWTJOUnJ2Zm16VXdkTW96T1h0?=
 =?utf-8?B?M0JleHArT1c0cElFa2dPbnJOc3ZUbmNLRVNoMTRCQ2VyelZUbEwzWGJMK0hT?=
 =?utf-8?B?d3ZkNFY0ZlBNcHhHdCtCMlZpaHU2NVRvVm1yaFZWblB4TUt4clhNWWVGWXg1?=
 =?utf-8?B?RGpFZjk0K3lRdE0zSnJ4WUt6YkU4MXFNdVN3Sk5IWk9iQjJiWVNMMmVjb28z?=
 =?utf-8?B?ajR0MmhEQ20rZ0FzK3pTZHozZTJxS1B0QUJVWCswMG1QbjFKMXpwc295SVJ5?=
 =?utf-8?B?MnN6RVZqZWVVdU1QUVRWa1gxelpJUHlpdXlLSm9VRFdaaXJwckZmNWlBZVBL?=
 =?utf-8?Q?/9xrKXNLK12PaJYc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9669FD8E1A15DA42A1210CC300873757@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: G4Arnaqq/9/gtst9RBD7WF24cnCv6BcSdgGttp2DxDc+GjyaxxaNWHjbvbgLzivYu6XRiSiRUxFjmsYADoBoGc7Gq54yeNWVMJjWJ+k9NBx6SssGThI/cdYoYvRL3OoKgNCs7e57YifgnqZCmxt/WicMLyYu4vIwhZ3kuD8gooVfbHu8J9bQgBhpnL3uMt96XYaySJmw1kHlIoQUfdFrIP1uyHQpq8fZhbLVNvROQMnQ7kiRqQt/ZtZ6QYZ1ACoAo0GGWwgxYXIaxZFwttVo9Tx2HElQS/X+TAq1UlsYnn+aXf9pdfs3iUhCIuVqw5FSgxIjXQ6gCvyTD/5rJythpg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b428c23-ea2e-4bcb-8bb0-08de9b2110e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 18:59:05.2922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qQvrt2pwyBqMhzcc2XXU/j9FJKg1U/mZyRS02rGzluJJbUVOBcF+3ahC4wFuCEGAYQnGhKfbTHqUKq8ZDxJzLDXHs5EQHGG+Y1x7d5fd+as=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7307
X-OriginatorOrg: intel.com

VGhlIGNhbGwgSSBtZW50aW9uZWQgaXMgb2ZmaWNpYWxseSBjYWxsZWQ6ICJUQUMgU3ViY29tbWl0
dGVlOiBMaW51eCBLZXJuZWwgU3BlY2lhbCBJbnRlcmVzdCBHcm91cCAoTGludXgNCktlcm5lbC1T
SUcpIi4gVGhpcyBzZWVtcyB0byBiZSB0aGUgaW5mbzoNCmh0dHBzOi8vY29uZmlkZW50aWFsY29t
cHV0aW5nLmlvL2Fib3V0L2NvbW1pdHRlZXMvI0xpbnV4LUtlcm5lbC1TSUcNCg0KUGFvbG8sIHVu
Zm9ydHVuYXRlbHkgSSBkaWQgcmVtZW1iZXIgY29ycmVjdGx5IHRoYXQgaXQgaXMgbm90IGFuIEVV
IGZyaWVuZGx5IHRpbWUuIEFsc28sIGl0IGFwcGVhcnMgdG8gYmUNCmNhbmNlbGVkIHRoaXMgd2Vl
ay4NCg==
