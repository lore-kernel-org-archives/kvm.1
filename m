Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CE63115AC;
	Wed, 23 Sep 2026 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790124310; cv=fail; b=eoOZ2Cb67RUbfUTSZ7yUT+CpOohjCIgN2JRp99cIiAjAA+4fn53GHkPb4DXCvgf260T94uZRulA7Ujxn8cfR18BfC5iylFP0KBwFkTKzQaHyWgwC8U0/u0zO4KQyWF0iMH+ybQadzy1I5aS5q9VNara9vjdvfT6k/E1XfiMWgy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790124310; c=relaxed/simple;
	bh=x6sGCD9kh+evxfvdl53h6N41FzkdmvV2MP2+6gfdQ4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mb+yM1mn7wA73UMkI6YY92T+J69UVizExXjzp5/R6uaFtjDiXOE7jhMHKHlZy55TyaAY1yoUKdpXypEOQU/tKWMaYOd2ItjTEicxHhm73eg9lAZaJ6tygCOIKAZOO2D42gd/ptGWcXLCUOghGay0YHn7OdAcIc28wyEvPZuHPuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axMWIgYI; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axMWIgYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790124309; x=1821660309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x6sGCD9kh+evxfvdl53h6N41FzkdmvV2MP2+6gfdQ4Y=;
  b=axMWIgYIjVKi1ljqCR/AxUEFWKXbhZaAUaH01D2vcuCsENiRLqlFcURQ
   XH9jhJ9cekPX4YejSasuLjCDRg52cCxIsaVg1539briSZvqUMJfxsPF/o
   PBvbF+QkU1xOa5EE/3d5qPDCtFaTRtDyYJPkRlt8ydWyKwSD6svYMPxi7
   X0UyNxb2XA8Pp/Sy2u2LYf5JwChd7C81COW4Uhr4kHvX+VKfCinIvkyz6
   c8m3X6WlLSR4Gr/in/09GUO2lkROLmpI/fLLJ0YPUnUcbWOen3TK8EDYK
   OaIFAZG0A43soV63Zobo1EeJVmsiw2XH6SBNLb6I9MCcUVa9+Hq3Fx0BW
   Q==;
X-CSE-ConnectionGUID: h9uIt41GQ1mIeC51HsA2eA==
X-CSE-MsgGUID: wAbZJiBhSoWAT+op9biqeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89696984"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="89696984"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:45:08 -0700
X-CSE-ConnectionGUID: r9yOE+YBTHOPVryjXezytg==
X-CSE-MsgGUID: qp2bIXr4Q5ully7i6Cwqiw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:45:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:45:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 17:45:07 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:45:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5ItYM0HrriQD7UMA7RzO43FXHMBPCQJtsabao4xrtS7bqgILubVG0VuHARqhz8MBB9PZ9vJSuN8VfBQTIPmDzKKhulJgoewsosUf3HUS1ViliYXhaaNAF+lYYiNjxSIgl5N8ZxezAad9CbjiqQ/Adex8pPi95yTDQE9j6a/hrFWa9h/+nwVaT4CTsGFevm+w4Lkclf7d0iTQNhhUz4OgA8EVzSY4ba5e0CwNAcY8qXPPIISLkPaP9V9pdPVIYj7+CBLc0hlGSUpP3ZtCIkv4mY0IKWkEscws68zcTrblwMpbn2C82ovYjLkSo7RASPvZHHtNVKcRybhQuxSTQ34iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6sGCD9kh+evxfvdl53h6N41FzkdmvV2MP2+6gfdQ4Y=;
 b=aui9JfST5q1yAbOfO5A4180YaZg89JOhytKeJxqUpOJbOvCTHrI55MqA2Kn3qIDm6opzeck0R1JEGdBts9TRjmiHfy7gSCNcmxjS+zBA7faSSFj7abPAom/vIHEdjE/I5zykiGEAcCU7NII09GQF93Ge3WcNiEWYu8DVCqB8RUgiSSn3O0I0UCvJV37LwFHckcapUjJX8TxUqvyVHQh0kXwwvTRNvECgPNUP5imVE0wtLU66+6ibo/uczx3DgxzocxapNRUJhUtvvVpn+R2kNO2+uoSAq27FekVv/feoD6RyNA7cctVS6fJjRSJTGTG9ZbbbdiFm+XeNyeXWk5CeXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CH3PR11MB8657.namprd11.prod.outlook.com (2603:10b6:610:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 00:45:01 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 00:45:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Maloor,
 Kishen" <kishen.maloor@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
Thread-Topic: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed
 by KVM
Thread-Index: AQHdRnUxZ7ir+OFvoU2rBazg3q+3u7bbUJEAgAADgoCAAAiJAA==
Date: Wed, 23 Sep 2026 00:45:01 +0000
Message-ID: <419b23f264af219da3be93a9d246b5401bbbaf13.camel@intel.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
	 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
	 <a8ce5d830a04d99ec47cdc727e1761bd4031d544.camel@intel.com>
	 <5ff81fc4-d144-4b2b-8375-d2f63e0dd618@linux.intel.com>
In-Reply-To: <5ff81fc4-d144-4b2b-8375-d2f63e0dd618@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CH3PR11MB8657:EE_
x-ms-office365-filtering-correlation-id: 48d1abc5-f7a8-495e-f592-08df190be6b3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|38070700021|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: tzlRzpZaojcqRPk6xsA0wgbHeo/RaJhuurmUal/ltf+R2EexH4QWHLfkrfOA4kSwSGVthSDxGd2A2VBsbUO/EewKO8XvLKmIqA+v0nslIZYE6YT7PgjQA2aC+9zoUe/1TUdVUwp9qitTsCpWp5wdWmcvHvpmNLlgY+Leu7pUZJQkOneNogC9jtJJGpf661CysPRrOmFdPIkG5vmUM2WT+WOrPwnucSceZGu2d0PB5hr+6GR6phiKvD3/9VrkvCS6b2zi7xEOkuwbYvsk7s92J1gJHIfpU7ySWijDlxux5VTDgCMYmx8ar1g1gJVvGcr+4pHh6XrmTuLEYJNKH/LNANzDDKGSiSsme6DzTCwCAFQ5WskE8FQKdvaoUny/riIKtwgiXANUpnuuHO1KEI+qbIIouwnRXl2AvAkslMFTPdsvQG4QkU3viiUyZKBjSMT+P2ianMOa+7ANkJtBSG0LjRjgd6VTO6si4Y8cJLZpZ4nMPqsS/T5V9VuPmcmBALibuhR104uoJCQRuX75nnxD656rjL7uN+M1iJxdt5CwBM0iMbXBxq3ngC9DE7nLfNkrYzgmYDW6oG2GWPf/+j93wHdTZKZK5m5H3Hl3AQDy9XmjHsxphFVtjC2ujZzj4fSkfqyPi7CY55I3yZlqK05d73UVhj5Pl+ywX4aTM/Rcc3ewH4nJFe7Fgx63ud0Z/qu8lfRm9u3H7Yqb+fAzRRh8E9UdBuu39N4e5J3gFsYG4pk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVlrLzBIcU91SytScktBTUlWMVBjblMzM0FINnNuQmtQU3hYNUVVRkpybjJW?=
 =?utf-8?B?SW5LRGx3Y1I4cHNDZUFHR3RHVzBGckpoQkZNWjgvRm1OOUJod3FhSEIxRFYv?=
 =?utf-8?B?bzNaZzkwSFRkWS9RS0NXOTJOL1ZSVVl1NVkxVGpLSUhNNC9DRTQ5OGZKWnBJ?=
 =?utf-8?B?amljWUVBcnRTK1VYd1ZFN0dNM2pCbFhOK0Z6aC9DZ0w5Ymk5bDgrNlNLYlRE?=
 =?utf-8?B?emxYTERucUs5d3dGcVRvU0Jya2RhU1NUaDJBMVA3NmZyZkpwMzVHZ1J0M2hU?=
 =?utf-8?B?ZWtTWFhLM0FTNXl1bTdCbm5zWXp4NFM3QU11em95WHlmcExtT3o3aGYrVFlS?=
 =?utf-8?B?OE45N2xoZVlSa3l4bnlvaDl1ck5hQ2Y4K2ZDdG43Y1lweC9LNGdyaVZzQUdM?=
 =?utf-8?B?clBiN2tUeFFOakRFQ3g3TWhwek53WXl1aXhhYitBUytEQmtMQm5vVXFpYm5o?=
 =?utf-8?B?WHhXS2Vab1g4MXBkRGVxb21BNnpMUVBkZUxWVEpSUkJVZ2xSSE9GYWJhbkZj?=
 =?utf-8?B?bEhHcmlhOW9ySC9EQkN1QXJoaFlmTUdFYzYxL1J1bElOeFc0bmtuS1dxZ2Ru?=
 =?utf-8?B?cWRHUDZ4L1U0aGtLSTR6NUJVdTVTR3VRVVlBWk9jWks5U0p6dzd1LzJVSllI?=
 =?utf-8?B?V0RqdktnMjhRUjVjSVBPS2c5WTZtaFBDNnE3MVBOZEtSTEVTQXdnallua3Bu?=
 =?utf-8?B?MkIxcEVGN0Q3N0xZSlRwM3R3cml1R2lST0tmcmZJc0VWSjQrL2xERjVWOUlJ?=
 =?utf-8?B?eGZJenowbUh6N0srdGxKdkxGYXJoWGRYRThWSTlKazFWa3V2YVo1dTVQZWVM?=
 =?utf-8?B?OG4vcU03WkRSdVJ6Z1JuRkNmVXJBdjBJb2dNNlRKTDd1ZzI4TExNMGNENWhM?=
 =?utf-8?B?MEVzUUZCRVhCbmhFdW9VMTl6b2hBNURWVGxmYUhtZkVJME92UjZRN2xFMzQ0?=
 =?utf-8?B?N0NhWEd6bVl6M0wydEd3OFY4UThiSTdlcTFwemQ0ampyVmlJL3FxZm1RL3B4?=
 =?utf-8?B?QzcwdU4rcm8rK0lFZkh3THYrWGUxc0s2ZnNRRlVvYW5LS1Y0VTNhR3BNemZm?=
 =?utf-8?B?a3Zrdm5aS1RiUWpzYjRwUzdSMTlFc1Fsa0ZTNXA4c0xUM0laM0xsenQxRFdZ?=
 =?utf-8?B?eTZDTFp1eTJKaEFzNW5pU21oc3NIS2dvWWd2RGM2endpNUtPMmZLNnk3OFpV?=
 =?utf-8?B?SWVjVHhEaW1OcGpLa1hyR3pPa05PYjBsMnRZRVVNN09KY1Bya3g0VmNyVndM?=
 =?utf-8?B?cUd2c2RielBqZ3pQVW1rU01menpvM0VBcW9iRW83WEIrdUkwaXBhK2NyTFN5?=
 =?utf-8?B?RFgwWGJITmNFRkx2L1RScFFJeEFTRUI0WEpSU1c0R05hSkRkK0V0UWVWQVpo?=
 =?utf-8?B?Rzh4bHQ5MEpKeEUxbG5hdEJpUkxGVk1VWjZXVVpMWDc3K2hNZ0p6bjJ5N2VI?=
 =?utf-8?B?NENqbm4xMnZ0V1ZybTZsbk9QV1drcXdtNC9uUVY5ZysvYVdZT0QvUlpMQ3Ry?=
 =?utf-8?B?K2hISVNPejNhSGdzWDBla0Nlb2JyV3NnNzZ5dkhqbEhnaWgzSjA0dVM2U3ky?=
 =?utf-8?B?OGxWd3lMOURlL1V6TFdINFR1Q0YyUTVyMk0yb2ZsQ2NteEdsc0dkdXdkZVhQ?=
 =?utf-8?B?OGwzZ2tLOUZYaGdWR3pMZ3N5ZWJacFh2ZmpONkFUZ2hudkNJS0F3LzlWMFd5?=
 =?utf-8?B?aE5Ddml2bEcwdVJiNitFVkxoMU9VVFZDZVdPdUhlbWtoUyt2MjZmNlJ3Sm42?=
 =?utf-8?B?OGxJVWZoWXJlS2tsK3I0Q0VTNzk3KzZBbStkQUR6RTlxT0lnR1BRR1NxUlE3?=
 =?utf-8?B?NmhwRUUxV1I4OUZIWFZ1UzN1QUdNbWlXeVVkbjM5UWxBNnlTWkJZby81S08z?=
 =?utf-8?B?UmxqYzkzMmNBTm1tcVl2ZkYvUXpQQ2I4SXROMlM5THJJWk83b0R1VU9YWmtO?=
 =?utf-8?B?b0ttWndreFRmV0VRVDNjL0NhMlJlbTRwUmg4Q2FvWTdyOXdXaXNzMitDUzhY?=
 =?utf-8?B?eDBIZGZoZkpMQUU1cjNkMEtONE8yd1QzQ0wycXFUVmF3VkthREg0RkNmbXZC?=
 =?utf-8?B?d1ZCbndzNEtsNzFJY1Q5RFkzd2NHMmFSZFg0dVdWcVFHb2tzVWZtdWQ5K2NQ?=
 =?utf-8?B?RUNxTFBVMDdXNHlWU1JRU1dDY04xS3NPVUorSU8wdnM0THg5Vys2cUpManRL?=
 =?utf-8?B?b09pOGhRVFZwVW5jOXhBaU9GN21JdW45WGg1ZjIwbU5sMzg1a29nNk5lNCtr?=
 =?utf-8?B?VDNRSnlQWFc5Z0N1d0pkem0xZXVRYkdBV0w0VlFRS0RlL1Jxc2hhYlhoQ0tr?=
 =?utf-8?B?a3phV3pjNjQxWkFYdjY0UzZoNWZtcS9OSWpzbm1sUmMzaXgzQ2lQSHJKMjBI?=
 =?utf-8?Q?OSxh0gUIgDh2bMHQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D3C1987693D4D4DA0B466394FA2B9D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nXJRZO6rphBmuhjDt/0HFQHy1kL300e5LDhovy69qd+TQ+F+YrqMJxQYQSh+ECcNZPsa5yewndwd6h3Dpxnju38B/TqZTTtGRsi+03dQWeEnKwrkLRxF7NNrEZeJGNhDXGEf8a/bc9e/pov9P5qpYWDuFvoPZVYM83jB9ucWajv6BXz0OAEznltuLbuGD0YDcEAh+tTuzmR6lonmYspefgGqK2Z7lqzZEbL0RpGSr2GozPdn4t0EF/HgELZcTiavGzi6KGl9HlFCuyrO33oOj7TppN86B9TdnEv3cKrkdXEZX/J4Nfg4afw0LecP7QffNTRjWwr2DPTvSPpdAirb2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d1abc5-f7a8-495e-f592-08df190be6b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 00:45:01.5253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vst7HSR+SgVFHboAMZLH0HzWvfcDaa9YuJtwNRWoxoGxHpvQYGoli2HoVsVwc3niR75sHZIXt+N/KSVaOjFX8kUYUNaoCHTfgJZ6GmKjkMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8657
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDA4OjE0ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+ID4g
U29ycnksIEknbSBub3QgZm9sbG93aW5nIHRoaXMgbG9naWMgZXhhY3RseS4gVGhlIGd1ZXN0IGNh
biBjb250cm9sIGl0J3Mgb3duDQo+ID4gdmlldw0KPiA+IG9mIENQVUlELiBXaHkgZG8gd2UgbmVl
ZCB0byBmaWx0ZXIgdGhlIGhvc3Qgc2V0dGluZyB0aGVtIHZpYSBkaXJlY3QNCj4gPiBjb25maWd1
cmF0aW9uLCBqdXN0IGJlY2F1c2UgdGhlIGd1ZXN0IGNhbiBjaGFuZ2UgaXQncyB2aWV3IHRvIGV4
Y2x1ZGUgdGhlbT8NCj4gDQo+IA0KPiBUaGVzZSBmZWF0dXJlIG5laXRoZXIgc3VwcG9ydGVkIGJ5
IHRoZSBURFggbW9kdWxlIG5vciBzdXBwb3J0ZWQgYnkgdGhlIEtWTS4NCj4gSWYgdGhlIGd1ZXN0
IGVuYWJsZWQgdGhlICNWRSByZWR1Y3Rpb24sIHRoZSBhY2Nlc3MgdG8gdGhlIHJlbGF0ZWQgTVNS
cyB3aWxsDQo+IGNhdXNlICNHUC4gSWYgdGhlIGd1ZXN0IGRvZXNuJ3QgZW5hYmxlZCB0aGUgI1ZF
IHJlZGN1dGlvbiwgI1ZFIGNhbm5vdCBiZQ0KPiBzdXBwb3J0ZWQgYnkgS1ZNIHNpbmNlIHRoZSBy
ZWxhdGVkIE1TUnMgYXJlIG5vdCBzdXBwb3J0IGJ5IEtWTS4NCj4gDQo+IFNvIHRoZSBndWVzdCBj
YW5ub3QgdXNlIHRoZXNlIGZlYXR1cmVzIGFueXdheS4NCg0KQnV0IGRpcmVjdGx5IGNvbmZpZ3Vy
YWJsZSBiaXRzIGRvbid0IGhhdmUgYW55IGRpcmVjdCBjb25udGlvbiB0byB0ZGNhbGwgcXVlcmll
ZA0KYml0cy4gVXNlcnNwYWNlIGNhbiBzdGlsbCBzZXQgdGhvc2UgdG8gd2hhdGV2ZXIgaXQgd2Fu
dHMgcmVnYXJkbGVzcyBvZiB0aGUgYWxsb3cNCmxpc3QuIA0KDQpTbyB0aGUgYXJndW1lbnQgaXMg
YmFzaWNhbGx5IHRoZXJlIGlzIG5vdCBleHBlY3RlZCB0byBiZSBhbnkgcmVhc29uIHRvIGFsbG93
DQp0aGVtLCBzbyBzYXZlIHRoZSBjb2RlIGluIHRoZSBhbGxvdyBsaXN0LiBJdCdzIGEgInRoZXJl
IGlzIG5vIHBvaW50IiByZWFzb24uDQpNYWtlcyBzZW5zZSwgYnV0IEkgY291bGRuJ3QgZ2V0IHRo
YXQgZnJvbSBleHBsYW5hdGlvbi4NCg==
