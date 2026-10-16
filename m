Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06F254B03
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 04:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123374; cv=fail; b=OOu9x61fLhhFWGSr8T8fcqFnVKt8ysdCtAmFOz+h3DptG2b4BRtbAnofjBOJzcFay3GGJNuk0175i/zJ05u9AuZhXH6wFp0eXbUlAmCXnDoVdCLYRLNq4K1hUFspd14voO9SznyGITbSTXM1oloo0ica+9UlSzuBQxNaFarFqrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123374; c=relaxed/simple;
	bh=Jz/GtHKUZ4EtrxM10RRmEy8B5VVTJVD4xwYKJMWEf8s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uLO6rxafeQwjk+jIw6cwqGBISNv+EmEJ8ujJv7fn5g18eo20PlbU7V00eX3puYe1PQX3BRX5SmCFBPPx5koZgImInMI2jRWwssNghX7/h3ATqG1X7aivvcEzlvpmxRzJm3EOiJeDTavcz3RLN+4ZKRD6NW4REmyOQoSm7TWKZ3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFomSTVN; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFomSTVN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792123373; x=1823659373;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jz/GtHKUZ4EtrxM10RRmEy8B5VVTJVD4xwYKJMWEf8s=;
  b=bFomSTVNd3PHFO//Mati9S0KwGO67SlPF7kkMGObZkL/YLEp/8PEONl8
   us6ys69HPh15GkaYfeC/9b7z8o5wtdZpiuDrgV09zU4peHzlzK89bF253
   EvqknBwoPRxLFqATl6CQOeZ4urgE5lwDC9YQG13uxCM8o2yYrFBuyMNCQ
   LRMRRtfhluFY+rUNy2uZEs90qAsCQ+9s+IEMI+Y7iJw5Bj3Yv/zBFABr/
   27OrSeSexFg1nL788JsXVk98YLqAAs2pzhO6FoJo+LbpGhfKlrI0b3Fdq
   Qfzp9aUHUvhak+u9uLAkxwuiqBS0Ql7Kky3A9vAwLGVmTDdP6BCM5/jhd
   w==;
X-CSE-ConnectionGUID: Nk1EyuCKTXG5jE/7EMdznw==
X-CSE-MsgGUID: YzwMylFPRs+wpYJb6ePuTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="924828"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="924828"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 21:02:52 -0700
X-CSE-ConnectionGUID: NcOrj7l4SUmSF/ENNAxBGg==
X-CSE-MsgGUID: qgz5WOwdTcuL7fkoLZ7a3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1758969"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 21:02:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 21:02:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 21:02:36 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 21:02:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXJcKR9xM0vEl7d2ErMz1DdSb8OMTcMZ9+QbQcLQHt4vCZW2Mtx/3q+bQEw9XSNBNfpWF9rZDTP9HCc46Z1MdR3v+M7OKFEljc2l07W4bE8ZjEMYdkVb8vIcdVpAsS3RSzOCQxqsp3ciBf8v76q2KWgmxVPk8wJkNesoopxh8x9fvGyB7BU5zEOq07zKzfSH/21wrWGCciuY6vAO6tMvf44GwYb9w22+5XBQq21dDPLImRQ2fVai5lPPL833b/XUeSq5AM95zCMeyuRXiTIh43MBTnnVYv0msv/CvyyNCwgq+2nj8l3lNB8gEQzlVmjD16pYC/nTHiXleI+dQ5NwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fW+PWJCEFa7Ej/pLs0fp7GXw+KPjKOJDqhvAMq2mfiQ=;
 b=Qt5vumJWcUKd9YY4TBpxF9M88/z3NDz4aMwMMON8NI7htJ3pD2jmGi6fTRiIvwKrcNxpT42VJiRkFItgRzKYTlVup5LBttEteq/IabjeYFYsrzT9wCPXcJHcwTzgg1dtOn5QIuZq3ChmfD70tTyF3xR8JOmRRq88OiUMmktGhSvWRbTOaxUi7z13IZAYgyEEqQJ6GS05NWQIImJE2QJSCmlO+lwPi5nHzY4mNkkxBJMyTk9vNVJcPWrpzpv3xn1pYRyfq/NRwyDapnaKsR7TkhQ0qwghclF2ohjaXt1GE7kAqj8FOTCzYQNZjgS1sIRXNPRUsRVIzltnimb5EwGzUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 PH0PR11MB4934.namprd11.prod.outlook.com (2603:10b6:510:30::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.14; Fri, 16 Oct 2026 04:02:33 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 04:02:32 +0000
Message-ID: <cc271637-ffe9-4307-8240-965ac68c6354@intel.com>
Date: Thu, 15 Oct 2026 21:02:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
To: Peter Xu <peterx@redhat.com>
CC: Artem Bityutskiy <dedekind1@gmail.com>, Tony Lindgren
	<tony.lindgren@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Sean
 Christopherson" <seanjc@google.com>, Fabiano Rosas <farosas@suse.de>, "Jon
 Grimm" <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup Patel
	<anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	=?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Vishal Annapurve
	<vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, "Kai
 Huang" <kai.huang@intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Peter Fang <peter.fang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	"Xu Yilun" <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <a4ec3af5-5494-4fb4-bf66-e3a8b67325e3@intel.com>
 <arRGYbvXgq8LLYQH@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <9fa229ea-818c-4ba9-81c6-be7ead5cb60a@intel.com>
 <araC0YkwLVPhGfy0@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <784c4ecc-da9d-44b8-9adc-1d1e92d20ae3@intel.com>
 <ar10Ncg2-GhzgBR9@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <30006d88-6679-4274-87fe-f1ce8732577c@intel.com>
 <asan7ETOVEZqRehY@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <asan7ETOVEZqRehY@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:303:2b::19) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|PH0PR11MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c54641-6826-48be-f8c9-08df2b3a4de8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|56012099006|11063799006|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: U4LpImww6HdsicJ6nvmn0F1FN7fo8NgGuNwX53g/sVgjzuv9YcGpmuOevqXrlPWgRuBEVFjCfdagLRLz8y0xrRZ+lv1vlb2lsFnRXm7pzAJUL7EnyXEF7X+HeIy+Ku5yUbzTsh9+iXBUHrHwtsNoLPEPWuDMyGa9HQjT5PgRWaxBkxNcTbotRM/vwlTVlx8cATA6s2K8EvCznFN+ErEuSpv81u+fy45tLiuL5IM7DNYF7q2RVtRm+AIkmq8D2yZShwv6cg1VAqAUDK3aJGop8pr5Jk6jDz9JoLTdnQAEPpzxfRe0WB6vnlQjid+ZGmX5SaOg/lNgupWV+VT6m+jx6z3BeVkAlaf7lgwXTj15q4iJTui+8Wv2/rMnUppjFzZ+eH1dLz9FGDFiSbwmsEFAoJ8t+kyS50bzch8/iJurwityEgMkZTr0QywzjVcu7fWWOCa07XPljJSk/EUGXqIhIllEMekjvmpF/fRZgOPGZ111Oh7g6dxcDhFjf6HSbdUkQD/rFcTUmEe7hQh9oOfUYamc46xHEWA1sYfbLoSDdS5i9F+qbvOcae8Q7mW/DkumSgbvWcq3siqO4xmkAwRAOj5HqoNmuE2IeJEB5/zmK/+r6SRD8wJTft3VllowOudmv6NvTsfvWsPY7S/v84OSdCdJI9DuENZ3Rr7hXclSLKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFRMZDlpZHNGY0NJZ3JQVlVDcVdxQnRVWXBSbXhsaVNVZW92NzZhRlhZcHUz?=
 =?utf-8?B?NCtSOXFacCs5a0ZUYyt2U3ViY2k3QlNLV3FuZi9QZUdRV01nZC82c0NKU0RL?=
 =?utf-8?B?djF3NURkS0tZTE1UMDFTZ2laa1NXTDhndEVIT0lqM3J4QU1BVE5aZ1BQaUMy?=
 =?utf-8?B?c1ZtU0F3ekpmSDJHbHFqR2ZOUnh5WUZsaDVaRWtNTHNJdzhPUVRYNEFNak9m?=
 =?utf-8?B?V2MzR2w5aUoxZUw1cEpoMkoxelROVG0rZFdKTkhOcFVYTnM2TUZJMnhyYW4v?=
 =?utf-8?B?MWtKY3g1dVE5MER2R1pLMHVvRjJ0WUtrcmIrSXZnekcrRHZiQmVlbG4yTGVz?=
 =?utf-8?B?SjVJV3ZxTk5VZmprV203Vm1tRFpEdGhUSW14bklNTElGL1QzeUV4TVpReEh6?=
 =?utf-8?B?RWRZb0N5YnlBcnphRUV1Y2RuK2lvc1JDOE92RzdNYkhaMG1nd2NBQ3ZTMUlQ?=
 =?utf-8?B?bmRBNXJUL1pnYTlFeWNCV20rS2Y0WVpTTU4vakcvTXFJVFQ0S0Y4cVVWdVRG?=
 =?utf-8?B?cm1Tdy8zMWxTbzNGY0ZlaitSTUdrMWFaekdoeGppR0NkeFRlQVFZanpjMkUy?=
 =?utf-8?B?TlNEVlRHZEVZYnhGY2F6RlhwYjZTNnBhKzRUT2prMG81QWtkMzY5WEZsNmhm?=
 =?utf-8?B?aW9ud2JMQXM3b0drMDVEazl4S2dXU0UydGRiZUx4MDhOaU9PQ3crNGI3OFRB?=
 =?utf-8?B?SXBaSTNRMVFxdE9KRW5tZ3Q1Z1pGSjN0dGJRVHM5Mm5sWVp0V2tzcEljanRG?=
 =?utf-8?B?aXZSQzdZNkhyQ3FYV1hXV1ZnYkM1aUNIdmdjaUhkVmVrOWRMd2wxTUJzYkpk?=
 =?utf-8?B?QmhIbVp5REEyZTM1aG1IYUZ5bHExZmRsQlVudUg1b01yZGJQRkV1d3FYSjkw?=
 =?utf-8?B?SlpNQkYxbXZEdzVkWXJ2azRCRm5heldSeXNLbjAyUk5qRi9nS0h0V254TDN3?=
 =?utf-8?B?Smg0WHk2VzNHdU5kdFA2amMyQWl2a3VuZzI1MDZhcFFSWm1TWWhNcEZwSDFz?=
 =?utf-8?B?YkVFMitrZm1VeUd0U25UdlUvOVdDOFV1SWJiQWtWWVZGaEQwR283QzIrSEFw?=
 =?utf-8?B?K3dvL3gyRWxmYzNUb3A1WkJPYnZXQW44cUJCZWVQNE5CM2xnNjl0Vm9nc0l2?=
 =?utf-8?B?Ri9OZXNxeEFnWkhSY0tZZVVCMmtKNkx4Q3FZYkN5OStBcHM2R3NwUVV6dXJN?=
 =?utf-8?B?YnlDOTFsbHR2djgyM0tVazBhNHBCaytiamVMWlQ3RmJBR2U1YkZqWS9OU2J3?=
 =?utf-8?B?dlNxWmVkZXdiejh1N3ovR1llR2VDbTlaYUJ0NlRhd2RSdzdoaElIUmJBcjdH?=
 =?utf-8?B?bTlOWEg2VGVwZHVWTkRSSHBud2F2VW5TVml4dE5KV29ManpBNXFvb0YyNDZh?=
 =?utf-8?B?TFFIUDRNRnRSMjdjeTFldC91UlEvMDBtNWNIcm9xSmx2ZGxyQzRwQW4zRFRW?=
 =?utf-8?B?Q1dtMjg4NGlDNXRQOUc4RnhMNlBrNG05RDhVQ1oyWFRIWkt2b0FZYTRyeVd2?=
 =?utf-8?B?KzhrWWk5NDh0M2RjQ3l0cUZ4RFU3OW5KaWtkRmVjdDhIempYd2tHWWtZNFU0?=
 =?utf-8?B?Y0Fja3QwUUk3SjMzb1JOTnN4TTJiUStYN0hKTGsxYU04WTdMMnNnd2FMNjM4?=
 =?utf-8?B?Tm95clhzSlYvWkJPRGdDWGx0dVBsank3dWpHUTIrdHV2N2hiWkVxTEIySCtS?=
 =?utf-8?B?NjB3akhtaU14RXRRNG54SzJiS0FIUW9pZVNRVUxKditVWHk0ZmVoWEMxdDBu?=
 =?utf-8?B?UGdDeDFwREtmTVFoRnlJUVBuNTdFT1orU3l6NGtmNlZ2bG5wb2pheXk2NGph?=
 =?utf-8?B?MGdGWnJ4ZlppY1ZuZDJtMjdiWGN2TGx1YzM4cmREcUZzK3NBRXVCajc0R1k3?=
 =?utf-8?B?ME0xeUZ4Z3BadWlyN0pCelkyYXJCZUVJc1lWbzhaZi9XR0h5LzhzeVJ6M1NP?=
 =?utf-8?B?VFVDRlZZRlBlVVgrRFViazNTczRwZTJkQ1UycStUZVVFclNjNFNsMHcrTWhJ?=
 =?utf-8?B?VjdCSm04cWppdzIveUFKNWlLMEhRSi85WlpuQ1I3eXp5VytjTWtYb0x0RXA5?=
 =?utf-8?B?Znh6SHFVeE5oemYyQWFzQWk4N0hTZWU4SFE2QUJoQWdhSmFMSzBCQnJheUVm?=
 =?utf-8?B?QlI1eVh4cWJsQVorTGpyNU9oVEl6eTI4QkZZdmJid0VOOEMzT3o1SkxNVnZq?=
 =?utf-8?B?WnEzbFRlbTA5WFB0VFg0Y09IMUJwV1RFYlFkYWRSUjE2dTZsUlhpdkM5QnJz?=
 =?utf-8?B?NzlONTNEZ2d3MWVlU3dib1RxNXlEUWxGV21tc1ROQjd2MFlmWjJLZHk1eTA2?=
 =?utf-8?B?b3Z1clltQ0FFdnNxRUFXQzVvWjhkU053SFFMY0pzR2dPNEdadFpQdz09?=
X-Exchange-RoutingPolicyChecked: VNmqThQa0KczcvZn5zfc6Ef3/Oe+3rtq5JiSqJeqG1pIFofuPK42eCJlIZxGhRYtFGljQ9EzjjwMMroFgpQuVl1FYKoHlib2EBoOmYRIc7n1+8OsgHXIvpzXJBE4krF89dQHACSfT3FHqhHL6xV7Lp1dxe1OFAPi6aO+asnp+v48+5dSvdkifF5U09YBcoYG013GNdfY2SLM+WGtoucDyMHAA4icCEZr84P8iqMRaS40zKafD+3lVeFVWQM2Umvv/sOmTSqxcelIDaMb2wYyT8rkA+wy38eypi6H1fro3Ci6sSREIDffc4Y+5fIOP2bMQDNK8Nditf2u/TfNGXpRIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c54641-6826-48be-f8c9-08df2b3a4de8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 04:02:32.6263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6RBdUEvpQPG2qnpajB/R+N0hI+eYviirSNfLuPN0IvnntmVXnQLeVaoBKszc10YX/X0vllITFVKUxqjnsZAIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4934
X-OriginatorOrg: intel.com

Hi Peter,

On 10/7/26 1:13 PM, Peter Xu wrote:
> On Tue, Oct 06, 2026 at 09:27:47PM -0700, Kishen Maloor wrote:
> ...
>>> Especially, MEM.IMPORT seems trickier to me: MEM.EXPORT even if described
>>> in in GPA address space, can be converted to other address spaces at will,
>>> as long as QEMU has full knowledge of the mappings.  MEM.IMPORT, OTOH, may
>>> not trivially work in GPA terms, if memory mappings can overlap.
>>
>> I can appreciate that. Working in GPA terms assumes that a GPA reference is
>> unambiguous over the duration of migration, which holds true in the TDX case.
>>
>> But it would break if another backend is able to point a mapped GPA at a
>> different protected page while keeping both pages valid -- essentially
>> the PAM case on regular VMs.
>>
>> One option that comes to mind is to add a 2nd optional identifier to
>> kvm_memory_transfer consisting of a guest_memfd fd and an offsets array.
>> That would be at parity with QEMU's block+offset and directly reference
>> specific storage units. Then QEMU and KVM backends for a platform would
>> decide what identifier to use.
>>
>> The value might be that a bundle could be accepted by a backend for
>> storage that isn't currently mapped in a memslot.
>>
>> OTOH, slot+offset as an identifier might face the same problem as GPA in
>> this case when a particular RAMBlock's storage isn't mapped at the time
>> on the destination.
>>
>> Not sure if this idea is viable or even makes sense; this is mostly
>> for discussion, but would appreciate your thoughts.
> 
> Yes, I would think (gmemfd, [array of fd offsets]) a nice interface.
> 
> If we say gmemfd is the container of data in KVM world, then if it can
> provide all data accessors it feels all natural and fit.  And yes, it also
> works for overlapped.

Yes, this idea was an attempt to address your UAPI concern for cases
that allow overlapped GPA ranges where a GPA-keyed IMPORT could be a problem.

Also, I suggested it as a 2nd identifier, i.e. in addition to the GPA.
We could, e.g., add a flag to kvm_memory_transfer selecting the
addressing type, as Tony mentioned.

> Said that, it's a matter of if, TDX or any other solution, will use GPA to
> be part of attestation process when loading the data.  My intepretation is
> GPA was part of TDX MEM.IMPORT workflow and required, but now since you
> proposed gmem for indexing pages, maybe I was wrong.  In this case, I'd be
> more than happy if I was wrong..
Yes, TDX's export and import are GPA-keyed: an encrypted private page's
GPA is recorded into its MAC, and IMPORT needs the caller to specify a
GPA alongside the page, so your understanding was correct.

Since you think gmem_fd+offsets is viable for those other cases (and
thanks for your feedback!), we will keep the option on the table. It
remains to be seen whether a CoCo platform uses storage-based
operations (instead of GPAs), like QEMU does for regular VMs. If any
do, then the UAPI would require this 2nd option.
