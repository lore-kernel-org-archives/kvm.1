Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792618122;
	b=H0bu/0LGjTRecF+SEr9IoFW+9j5yoxOqxaPE2ixYs0tJ1PJ8O45k8h9/Awqvm+F1DxPO
	 PDAuH8VAIZrsQW5ugNdS/D/R4BWBvQryX1LLSrMss3NcerKJRM1M9OCWphsuwVVBQuYHJ
	 EANnOlLQ8sgvZzo3xNAL+/lMViEY6JV82kKcROD2DSdvd5BqxIg29KTJGfoi0v2CL42hx
	 /Bv/0cXJJyZrqxUmoWYpczm7/U0AkpCw51vf+Cuz4mfnXKFEdv8+pSmSbr3oOubltpOmR
	 xdMlrrDFcrJBN5BNina2hdrJjSXWgGnwRYkMqSM3Yme6uKr7I7N4hQIBciqi4lbK8Ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618122;
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
	bh=mcqhnauXFYF8WFDm4olPTogSWtaVxljL2I++UatGUlo=;
	b=vKpdQ2xaMsyR5WF9EcrQCAyLLADBaWADVruFkSxfUu0t4O73z5PYWALNjfGAii24b5A1
	 6I/CgksUGBZBOfUAjoOQfzPPhYj5l45Y9L/Phn6YHOfRH00V+IiywQVlOrI8ARCMiQoIl
	 nqOHng4j1mdOBN6gP3qZofjTSTlL5yDqNeaSwYdXxYR74Vo5xyIyZGopJgmmhBlfVu6c5
	 mvFAlZ1enVKTR18VqMuVpKHHksSvH9PXnt4GC+gBIql+UOldDXfG6SXzbirJz8tYyQECy
	 aVZgalcYx8f3rU1HYsTajpiCY7nbABwDtgWQslNTCTiwFqIbLk24t2Hr+4Mwmc/3iFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hIr86++d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF7606A31A;
	Wed, 21 Oct 2026 21:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73DF7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hIr86++d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792618120; x=1824154120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mcqhnauXFYF8WFDm4olPTogSWtaVxljL2I++UatGUlo=;
  b=hIr86++d+LGABcLKk8kpuSGyg4fc/ff0frmIsg2v5u6m96C8BeaDS/cx
   l62x3P+yPWFq2ylUSovZy3mz09o1CMOab/Rbk9d5P/FRHp/BtlbkRgTfd
   BLs0fLB0euLAkg8N7P4tdEfkJav2Pagynm1VOLlzcj9A0l3mwgnxjFsN8
   oy8UV9livfQy7yfttJxp9lSjM5qWI6/MW0JhbjWjttpYfeOE99YsfCu4t
   jZx2OnF1eix+RVaUoVRGSIkOhxjOVgQL7U5pMmKNoVxXexPsqmiKHsH8e
   EYaDh9tXkZG/0DDGiuvqCBp9AC4rMH6/z4NlmO6gKQF8dal2pY5Ek1tth
   Q==;
X-CSE-ConnectionGUID: DFmdOqJyQ5S6TUJDpEMryw==
X-CSE-MsgGUID: VgoKe9TOR2K92Apn+ganZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1257885"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1257885"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 14:28:40 -0700
X-CSE-ConnectionGUID: yB+8lIB5S56Xgi0U9bwgxQ==
X-CSE-MsgGUID: s1js7QSMSRecJ8YHCLMjCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3135218"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 14:28:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 14:28:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 14:28:38 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 14:28:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrhYLkAKp5t28yBCjKVWWcyiTz7J9PoiKBYl3Xt3fcajh9LTsBnBKGedk1vvopNVMtlSu6vnLm5fmBL6BGd0aX4EYfWMx7oI9mUTnVPJz4g33MpnS5uAW1wrPh8o6T1dt5rUehRdHcTbcB64HKgDg5hWJwWoqGzv7YIi5VJT/p1ja3CxhU8QwRTF7ILg3n/Q7MrdwLTyjwzYloB9N3aKMDxfZiLJL3FPQ3Q4oRZBDIjN4LiGsYy22LBceIFL+hRIvHYtoXuELyTBKVnxSRoc00ek4LrX5YHgXFhFyAtOPbhCCdrfW8MewGXG3MFC4oDAwp4LvvuZVoc2pKMMl+1B8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcqhnauXFYF8WFDm4olPTogSWtaVxljL2I++UatGUlo=;
 b=rDJ4ak653stDo088FN3w9ZvUSldwkKvGrRr2E5suw8r4eKCIAFWrxphq4S8QuOE4tUv0LmSfzJsVn201ErUUdtqza9Kl+ve4swdufYNSfTrGpBPtqPaAQtzs4lxGwOY0lsbdju8VvuvqWDc7wGnnaMaFUZq8/dbclMNXpr40RT4jYzq1z/NJXHIx5OpJ9KK5Zs1VklqGHcj+GKv2rpQU1jroD8ZBaPVw221u8h54rM/7bb0R4OxHW2pGftkeH0hcIUMc/v+yp1+aVAHCKbA5MkwKnNaKzJ3hgH1BsiUIaePlVJ1/3tldeneDtEmhud6dIEVc3nIfvwrGfLFZGX4Hxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by SN7PR11MB6996.namprd11.prod.outlook.com
 (2603:10b6:806:2af::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Wed, 21 Oct
 2026 21:28:33 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 21:28:32 +0000
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
Subject: Re: [PATCH v4 01/17] x86/virt/tdx: Enhance tdx_pamt_get/put() to
 support huge pages
Thread-Topic: [PATCH v4 01/17] x86/virt/tdx: Enhance tdx_pamt_get/put() to
 support huge pages
Thread-Index: AQHdTykCb/i0a5FVc0eZkBiALVPvabbpU5eAgA1PggCAA/5+AIADbkMAgADzGACABYa6AIAEHkAA
Date: Wed, 21 Oct 2026 21:28:32 +0000
Message-ID: <ca949948073ba2079db578b7a27108db6991dc1a.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928090808.15484-1-yan.y.zhao@intel.com>
	 <e494996660b45273590860e961b36378c4099c03.camel@intel.com>
	 <asoQ/P7sghrEVDQs@yzhao56-desk.sh.intel.com>
	 <ea3584fd5613223ee066fbd368272dc7070bceec.camel@intel.com>
	 <atBLdGBCsPwMK7Sh@yzhao56-desk.sh.intel.com>
	 <896585225b67cb215db0ce66dece20ba8fbb919f.camel@intel.com>
	 <atW6Il1yN85IA1Wj@yzhao56-desk.sh.intel.com>
In-Reply-To: <atW6Il1yN85IA1Wj@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|SN7PR11MB6996:EE_
x-ms-office365-filtering-correlation-id: e422776a-0453-499f-f11f-08df2fba421a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|22082099003|261021121427099003|11063799006|38070700021|56012099006|5023799004|4143699003|18002099003|6133799003|10067099003;
x-microsoft-antispam-message-info: h8b17qFt4jK9kWBHmz4cIB6e92JKAzb6yq/6xeYxPM3SWzX9Cde/T8e2qALg8NKUkJNuKRst4Wu4Kv4O8HRhtP5jFdjELdCB3e7k1OY/3mbz6IrY4LzxUeEueR7wbicJtYMllHioQpOD/v1sTq5R6ocECywylvqnt/uw6VN0TnE3IAWm/DUieg00dOamz6r7hyC3q7uxLZ55tUagmiM6TgeoesX4Qv/zTwm2Y46qmy5+oQQrofyEVgRpdeDVg13Y467NsJz31I595R28LBq7c09//CWxw2ABwyt6hcfoWuXAqiUUJGkE0RXfFOA0pSfRNM/hnEvfar3mSVQ8q5aWSNy8BSNvwOBi+54rRAtNdV4ZEP76BkMz6Jyzf6T4EBu/s2q8D5jU1DJnZsdWyxQi37R1Vr3kXb5ClIVSkRc/4X7mAXl/DPPFnCbbULPwPBVDtnI1VdudsV+/c2YdZPGPuyB0p/MqlHv5mwMSHMuT4F+pd8GevXH4x3v0px6hwNwEw4Ew0mrfWA1d1rem4LlGhMM6LlWSZW1h9fs1qP0SpPIgQp7MnORu9rhsZRorNmg4rC4VOWtRGiYjDU7D8j10x1rzQ43l6jfYLHiJD3d9Bm2pZEhWm8Gocqnyma7WhjRP3qwgC16WDTPNX9AY2AKPeZXrD1L9o8jQlKOwQnsbznA1M6K1izhk5j7MbXO9GpycmJOQM9jOupoah55Mj2iB0LbZDmKb1We15ux5HBxngng=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(22082099003)(261021121427099003)(11063799006)(38070700021)(56012099006)(5023799004)(4143699003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlZYTjhzUi9iTUlSZ3U3dmhlUGhuM3JrUDRhK014UTF0bW1LZk9qUWdRK1lO?=
 =?utf-8?B?Z2JFK0RyRVFTUTBRTHdIdEltTm1RSm54YjVlbWJTcVZ1UkVhL1pJdjBxVTVG?=
 =?utf-8?B?bGxCbVhxdU5GMEtRNlpzQ08xNlhPNXMrZ1l6V2NXU0hnNUJDdmM1R25IWUxK?=
 =?utf-8?B?ajE2OHBjaTUyNDl1Q2VPRzdRb2hlMmlxNkFuOHN1SndOZTRXaHZUNTlZNzZu?=
 =?utf-8?B?ZFY0alBKYlBKNTUvNEhvNERlTmhKZnN5akpla0ZLVjFXK0hUcmdScjRCSjdq?=
 =?utf-8?B?cmFzWndvem04SzNqY1hUd2U5YU8zYzFHbUJvOHc1VmZ4OWpmZDMvVm9LdXVM?=
 =?utf-8?B?aThUTXhRWEFLRkVwZjlUdW4zNTlBTG93NXF6NUcyRmVTSnY5RmF0OFlGWUQ0?=
 =?utf-8?B?V3pqNnhrcDJrUG5TbjZZOTl3NWw5UEhZa3BFZHU4ZFE0NTQzYW9nK1o4Q0tx?=
 =?utf-8?B?YXRXZUZrd0pGazUxSEF0SnIxMkhRRjVkWnc3UDQ1di91ZHRodHRBR2xYVVZv?=
 =?utf-8?B?VUpmaTE2M2N6dElBUkFKL3c3MkRLZ2tBbWVFN1N6VENTNTFkV0gzemkzTGtv?=
 =?utf-8?B?clRXVzN2SGlGUkc2Z0tlRWJWeFpHVDFMd3Z3eGxhMjFiN1JFNDkrZFFaZVhH?=
 =?utf-8?B?MFdwRTI3SUI1bThiZUw2ejhVcmx4VnVSR2UwTGhybTZmUXNtdmJxN0wxK05L?=
 =?utf-8?B?dll4TlJxSllEUVpMcXRta2FsWFMvRE9DazgzbjFoRTIxdWVycHVDazFvNkV0?=
 =?utf-8?B?SkwrMXdBcWRLSGo1K0o1ZFRSbVhNSVErb01MUk5QMUg3b1cwYlp2UEZyREpG?=
 =?utf-8?B?VjZ1UEt1NTFVU2tBSXEzemt4cnNqekdYY2IybDJqdTJ5cFA2NVdDa20zTG9H?=
 =?utf-8?B?Mm1haHZuQVAvbTF1TGE1K29mcER5a2ZvVUdOdGdBS1RGTStEZElnRTZ3eHNx?=
 =?utf-8?B?RnVNcXFyejdrZnpwMzJWYktVK05zQU9hdnBEci9RVE4ra0lCa1p5eUNVazgy?=
 =?utf-8?B?dlBZbHIvNHRHTVNIWUs3aldBNlBpUTVMek1GcHRIMzhpdnBQeTRTRDlmTEx3?=
 =?utf-8?B?N3RDODdpMUtNVEtFemFmOCs3MVViOTg2QWJUdVVkYXpUSE9BZkRJTkY5czIw?=
 =?utf-8?B?YjdYMTZwL0Rsdm5tZjI0dm5QZU5LQzV4emtkSXZycmh1T3JjWUxhTGpVZ1pp?=
 =?utf-8?B?SHpnbWxnRUdZb2tuUkp4dzNteHRKOGFOUk9hSnNEalpnbzBIRGEvWDVWVjBK?=
 =?utf-8?B?Vk5NTFNlN2xiMzBoY3ZoN0pXRlYwZWVPSUk5c3dTQmNnY0c4SlJkdnMzVWQy?=
 =?utf-8?B?a09xSENxUHBOQ2NlRXhBTElHOXU5cFN3QlZVc0pWTWJ2TVgva0pyTFlUT0l6?=
 =?utf-8?B?aFdrL3NJWjloSmd0WS9nMUswSEFjMVFYVXVXRGdhWG83MkNCTUNqOTVlSEtm?=
 =?utf-8?B?TFFTMUVhb2FhODJXck5KRWpzMHA4em9uWENscHFGZHY0bEM4cjhxOFJhSjJP?=
 =?utf-8?B?cnozMW5NaG9qWkh3cGQ4WUxsaloyQzhTKzVwQU9QN2t0bFBpbFlVOHZlV1FS?=
 =?utf-8?B?TFRMU0RBbW83NmVwTGlBNmo0Qkw4Qkx0QUZNclFWRnBGcjhGM2VMSkhqMzJl?=
 =?utf-8?B?c3NkV01EOUorVk4zWjc0bCs3UWVYajloZkJiWHVEZ29Kc1pDaGhaMStOYTZu?=
 =?utf-8?B?Tnp3cmc0QWpvV3p0TGVkRHpUVGNJbkp1MksrRFdzdVZ5cUtxQkVmVFQwRGxF?=
 =?utf-8?B?UFJsQ3pqZXhSSWdGMmVYN1E5UkpYNTJHSmU5RU5NcXNXNG1aR3JqdTFoR1Z4?=
 =?utf-8?B?aElCRFJNMjV5bUNuR1I5TXBQOVJmbDBuOWNIQS9OczltK05RRlpmcVdLQUhL?=
 =?utf-8?B?OXFUYzlneTJLY0YxMS9yWXVNTGFMdmpDcWRWMVN6WUpVMkRucXNndUdVRUw4?=
 =?utf-8?B?WDJuOWxvbUFFdVVKTWNDTUtYM1N0Zkt3dkZ1ZEZobXZVMlg0QUlQWTBVUTFL?=
 =?utf-8?B?M1RJVGNpbmR2NmxOSktLV0lzbmd1dU5QZGdUZldZcTViUjNyQWMvUTVLSUN6?=
 =?utf-8?B?b2tmUUJRVVh0VEJEMGNkcHFNZ0dPSDdWZW1CeU01NTI2ckhrcHdFVHRvSWxJ?=
 =?utf-8?B?R0FveHpWQzByaXpzdkM0dlFFVDhmNXUzMUZxbEMreHRnVXFEV21nc0d1Y25o?=
 =?utf-8?B?K2h3ekxIUHdQRm9EQjAyUFN4U3ArVW5OMWlhVEVmcnA1am9jc21FZXdEakc3?=
 =?utf-8?B?enVBc2M0V2piYUZ1Qmg5ajE5UGh3R1RWT2FyekxNNnhJdUY3bGl3d1B4T1pz?=
 =?utf-8?B?MkxmWnpVZkpXYTBRNzRZbGJYa3BWeXBlbGJLVmlLZ3ZLaWlHd0Jvdm1sWnVS?=
 =?utf-8?Q?tLbVZR3iI0FOmfZg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CE1D9D9F82D1D408FB43FA346D43DE1@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: MY7jfqucIIcKKvz2ogqObddAZMyrBQAZD0eiSGSKgP3xmKGQ6+6ArJ/kavPGnqJzyeruThe/dwom3LixH19Ntkxe92nr1YFxktQEoHh/l4t/ytcIQ+VwZsgfy/vb+dqCwsK7gzBC+DiCeUIQPKMRFJ9euPg5IZnE4NTEbylkJk2HiEiyUrfVlDZYA/v/d32xu4BnkT7WG/VJKtJSaJw8oJ+GjJV/jf+/MjmRqqZt/W43/JIRIOa2D/KFQwO741UraaSLuKUA/3T/4sppqQeMSLsRJ30De28kx+vNcYERIS8jppoGSK66IzzYElkTqD14bS1ssQtIDaWhBirdypmSKQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e422776a-0453-499f-f11f-08df2fba421a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 21:28:32.8789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36cGRzVVEzODBAuWotPz7zoVuVSjfY3M8JvBa9i8Zad9wsEZnzI8pq+sjFUTP1DEsSFKEIrqY4DUx+Nb+orMcVsbKzl8S70JOJp+ntEUwmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6996
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTEwLTE5IGF0IDE0OjM1ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiBU
aGVuIHRoZSBjb250cmFjdCBpcyBzaW1wbHk6DQo+ID4gDQo+ID4gwqDCoMKgIFRoZXJlIGFyZSBv
bmx5IHR3byBwb3NzaWJsZSBtYXBwaW5nIGxldmVsczogMk1CIGFuZCA0S0IuIFRoZXJlIGlzIGEN
Cj4gPiByZWZjb3VudA0KPiA+IMKgwqDCoCBmb3IgZWFjaCAyTUIgYWxpZ25lZCByYW5nZS4gVGhl
IG1hcHBpbmcgbGV2ZWwgd2lsbCBiZSA0S0Igd2hlbiB0aGVyZSBpcw0KPiA+IGFueQ0KPiA+IMKg
wqDCoCByZWZjb3VudCBmb3IgMk1CIGFsaWduZWQgcmFuZ2UuDQo+ID4gwqDCoMKgIA0KPiA+IMKg
wqDCoCB0ZHhfcGFtdF9nZXQoKSBpbmNyZW1lbnRzIHRoZSByZWZjb3VudA0KPiA+IMKgwqDCoCB0
ZHhfcGFtdF9wdXQoKSBkZWNyZW1lbnRzIHRoZSByZWZjb3VudA0KPiBJIHRoaW5rIHJlZmNvdW50
cyBzaG91bGQgbm90IGFwcGVhciBpbiB0aGUgY29udHJhY3QuIFdoYXQgaXMgbWVhbmluZ2Z1bCB0
byBLVk0NCj4gaXMgbm90IHRoZSByZWZjb3VudCBhZGp1c3RtZW50LCBidXQgcHJlcGFyaW5nIGFu
ZCB1bnByZXBhcmluZyBQQU1UIHBhZ2VzIGZvcg0KPiB0aGUgcGh5c2ljYWwgcGFnZSBLVk0gd2Fu
dHMgdG8gaW5zdGFsbC91bmluc3RhbGwuDQoNCldlbGwgZ2V0IGFuZCBwdXQgYXJlIGFscmVhZHkg
cmVmY291bnQgYXNzb2NpYXRlZCB0ZXJtcy4uLg0KDQo+IA0KPiBXaGVuZXZlciBLVk0gaW52b2tl
cyB0ZHhfcGFtdF9nZXQoKSwgaXQgd2FudHMgdG8gZW5zdXJlIERQQU1UIHBhZ2VzIGFyZQ0KPiBp
bnN0YWxsZWQgYmVmb3JlIGluc3RhbGxpbmcgYSBwaHlzaWNhbCBwYWdlOyB3aGVuIEtWTSBpbnZv
a2VzIHRkeF9wYW10X3B1dCgpLA0KPiBpdCB3YW50cyB0byBlbnN1cmUgRFBBTVQgcGFnZXMgY2Fu
IGJlIHRvcm4gZG93biBjb3JyZWN0bHkgYWZ0ZXIgdW5pbnN0YWxsaW5nIGENCj4gcGh5c2ljYWwg
cGFnZS4gU28sIHBlcmhhcHMgYSBtb3JlIGFjY3VyYXRlIG5hbWluZyBmb3INCj4gdGR4X3BhbXRf
Z2V0KCkvdGR4X3BhbXRfcHV0KCkgd291bGQgYmUNCj4gdGR4X3BhbXRfcHJlcGFyZSgpL3RkeF9w
YW10X3VucHJlcGFyZSgpPw0KDQpJIGRvbid0IHNlZSBhIHJlYXNvbiB0byBjaGFuZ2UgdGhlIGp1
c3Qgc2V0dGxlZCBwYXR0ZXJuLiBJdCB3ZW50IHRocm91Z2ggbWFueQ0Kcm91bmRzIG9mIHJldmll
d3MgYW5kIG5vIG9uZSBldmVyIG9iamVjdGVkIHRvIHRoZSBnZXQvcHV0IHBhdHRlcm4uIEFGQUlD
VCB0aGUNCm9ubHkgc2NlbmFyaW8gd2hlcmUgaXQgZG9lc24ndCBmaXQgZm9yIGh1Z2UgcGFnZXMg
aWYgaXQgaXMgY2hhbmdlZCB0byBhY2NlcHQNCmFyZ3MgZm9yIG90aGVyIGxldmVscy4gQnV0IGFz
IGJlZm9yZSB0aGVyZSBpcyBub3RoaW5nIHRvIGRvIGZvciB0aG9zZSBvdGhlcg0KbGV2ZWxzLiBB
bmQgdGhlIGNhbGxlcnMgYWxyZWFkeSBrbm93IHRoaXMgYmVjYXVzZSB0aGV5IGhhdmUgdG8gdG9w
IHVwIHRoZSBjYWNoZQ0KYXBwcm9wcmlhdGVseS4gU28gdGhlcmUgaXMgbm8gYmVuZWZpdCB0aGF0
IEkgY2FuIHNlZS4gQW5kIGZvbGxvd2luZyBmcm9tIHRoYXQuLi4NCm5vIG5lZWQgdG8gcmVuYW1l
IHRoZSBmdW5jdGlvbnMgYWxyZWFkeS4NCg0KPiANCj4gVGhlIHJlZmNvdW50cyBhcmUgaW50ZXJu
YWwgaW1wbGVtZW50YXRpb24gZGV0YWlscyBvZiB0ZHhfcGFtdF97Z2V0L3B1dH0oKSBhbmQNCj4g
YXJlIGhpZGRlbiBmcm9tIEtWTS4gSXQgaXMgdGR4X3BhbXRfe2dldC9wdXR9KCkgdGhhdCBkZWNp
ZGVzIHRvIHVzZSBwZXItMk1CDQo+IHJlZmNvdW50cyB0byB0cmFjayB0aGUgaW52b2NhdGlvbiBj
b3VudCwgYW5kIGVuc3VyZXMgdGhhdCBQQU1UIHBhZ2VzIGFyZQ0KPiAodW4paW5zdGFsbGVkIG9u
bHkgb25jZSBmb3IgZWFjaCAyTUIgcmFuZ2UuDQo+IA0KPiBUaGUgY29udHJhY3QgaXMgdGhlcmVm
b3JlIHNpbXBsZSBmb3IgS1ZNOg0KPiB3aGVuZXZlciBLVk0gaW5zdGFsbHMvdW5pbnN0YWxscyBh
IHBoeXNpY2FsIHBhZ2UsIGludm9rZSB0ZHhfcGFtdF97Z2V0L3B1dH0oKQ0KPiBhbmQgc3BlY2lm
eSB0aGUgcGh5c2ljYWwgcmFuZ2UgYnkgcHJvdmlkaW5nIHRoZSBsZXZlbC4NCj4gDQo+ID4gwqDC
oMKgIHRkaF9tZW1fcGFnZV9kZW1vdGUoKSBpbmNyZW1lbnRzIHRoZSByZWZjb3VudCBmb3IgZWFj
aCA0S0IgcGFnZQ0KPiBTaW5jZSB0ZGhfbWVtX3BhZ2VfZGVtb3RlKCkgb25seSBzcGxpdHMgdGhl
IG1hcHBpbmcgbGV2ZWwgb2YgYW4gYWxyZWFkeQ0KPiBpbnN0YWxsZWQgcGh5c2ljYWwgcGFnZSAo
d2l0aG91dCByZW1vdmluZyBhbnkgcGh5c2ljYWwgcGFnZSksIEtWTSBkb2VzIG5vdA0KPiBuZWVk
DQo+IHRvIGludm9rZSB0ZHhfcGFtdF97Z2V0L3B1dH0oKSBmb3IgdGhlIGd1ZXN0IHByaXZhdGUg
cGFnZS4gQXMgcmVmY291bnRzIGFyZQ0KPiBoaWRkZW4gZnJvbSBLVk0sIEtWTSBpcyB1bmF3YXJl
IG9mIHRoZSB1bmRlcmx5aW5nIHJlZmNvdW50IGFkanVzdG1lbnQgZm9yIHRoZQ0KPiBzcGxpdCBo
dWdlIHBhZ2UuDQo+IA0KPiBPbiB0aGUgb3RoZXIgaGFuZCwgc2luY2UgdGRoX21lbV9wYWdlX2Rl
bW90ZSgpIHdpbGwgaW5zdGFsbCBhIG5ldyBwYWdlIHRhYmxlDQo+IHBhZ2UsIEtWTSBuZWVkcyB0
byBpbnZva2UgdGR4X3BhbXRfZ2V0KCkgYXQgbGV2ZWwgNEtCIHRvIHByZXBhcmUgZm9yIHRoZSBu
ZXcNCj4gcGFnZSB0YWJsZSBwYWdlICh3aGljaCBpcyA0S0IpIGJlZm9yZSBpbnZva2luZyB0ZGhf
bWVtX3BhZ2VfZGVtb3RlKCkuDQo+IA0KPiA+IMKgwqDCoCBUaGUgbWFwcGluZyBsZXZlbCB3aWxs
IGJlIGRldGVybWluZWQgYnkgdGhlIHJlZmNvdW50IGFmdGVyIGVhY2gNCj4gPiBvcGVyYXRpb24g
aXMNCj4gPiDCoMKgwqAgY29tcGxldGUuDQo+ID4gDQo+ID4gSWYgeW91IHdhbnQgdG8gcGFzcyB0
aGUgbGV2ZWwsIHNvbWVob3cgaXQgaGFzIHRvIGJlIGNsZWFyIGhvdyB0aGUgcmVmY291bnQNCj4g
PiBhbmQNCj4gPiBtYXBwaW5nIGxldmVsIHdpbGwgYmUgYWRqdXN0ZWQgZm9yIGVhY2ggY29tYmlu
YXRpb24gb2Ygb3BlcmF0aW9ucy4NCj4gV2hlbiBhIGxldmVsIGlzIHBhc3NlZCB0byB0ZHhfcGFt
dF97Z2V0L3B1dH0oKSwgaXQgaW5kaWNhdGVzIHRoYXQgS1ZNIHdhbnRzIHRvDQo+IHByZXBhcmUv
dW5wcmVwYXJlIFBBTVQgcGFnZXMgZm9yIGEgcGh5c2ljYWwgcGFnZSBhdCB0aGUgc3BlY2lmaWVk
IGxldmVsLg0KDQpBcyBhbHJlYWR5IGRpc2N1c3NlZCwgdGhlcmUgaXMgb25seSBvbmUgbGV2ZWwg
d2hlcmUgd2Ugd291bGQgbmVlZCB0byBkbw0KYW55dGhpbmcuDQoNCg==
