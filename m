Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4B1A683D;
	Sat, 11 Apr 2026 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871343; cv=fail; b=cIkZEpOa/O5OXI9Ub83NPA3pJehNzt+lzTe9w8TTTmzNW66FnNRKSG9eA2FHWoORcWweYMg/jr1bX1QVAuiRxHrjCEOu7EgW/Wd769dqVNI4EdyOELLxAejls4qJlpw3m2BqETFLxZSuLgWABmuRHwxOoBfsBoem0qZGWkTf6AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871343; c=relaxed/simple;
	bh=IEbn7ZKbhpW/HN3nEY1hQzbOFg1wiSo6t0fZLyBJ8bw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P7OSlUWGBvRM6IyaA6bapBK5cc7nj61Gbyva1ebfFGiLl+ZfAtJoHB7BNveq5tc3yUfBtC+HvM2iDYEK8btseNtERSsSR+ZQV3kRzJeImCBZ2/BX2yTmKKXrPeCycg6a7962VJF70caGNzuyZI0+6xCgcCyEcrtqz0R6ozBKw6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBrlnqwp; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBrlnqwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775871341; x=1807407341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IEbn7ZKbhpW/HN3nEY1hQzbOFg1wiSo6t0fZLyBJ8bw=;
  b=VBrlnqwptbjkf0HD9T4NUW8iXsRmuQQkblCA/sR9iFIA+UMtFLJV5Lg/
   G/kl/2efCUMyP810tkxRTVZuZSYRGJOxZixwb+X/Vyg9VgQsUK31+1MIk
   Ab8w/ABMOa43+DcxImUaHc11qnxBSJQxdLVkx1bmCQmiIeVoIK9QP5Z1M
   c6aIZxYbCHOt//iI0DUr105vyZhT0jVKWKfYI+g+OFRRZ+ktExyQDzw5q
   LIRWwxvfCV3Oy9wuHctyyFj/wPgQHdcF/rgN9deiorXIXQfwX6/OFc8S4
   P50lxiNSAwrsuTh7EGzrx3/zRTeL+XeX48hwG7F/2slhHw+W8P+y5tVSn
   g==;
X-CSE-ConnectionGUID: TQ14KQuoQA6XYtx4rWpRFQ==
X-CSE-MsgGUID: ygQuJYlpQqS2lVnDUB6fGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76803074"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="76803074"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 18:35:41 -0700
X-CSE-ConnectionGUID: j3pFbzP/RxCPQMwlnsfKIA==
X-CSE-MsgGUID: LoQ00o7BTyCwR0Db27q1bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="226533290"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 18:35:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 18:35:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 18:35:38 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.71) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 18:35:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ipxf7aUrM3GVcGZWhM+3rIRn203wgMm70FSoXw7cIho3gbHZPdva3YNzlu/898PpWC/mqn8/WLnDYCqw7P8iZlxHP+cduPC3Feebq9vx9ksl2QlIoqhx8619RFAnEwLP3O643E9I9ZSd7tHWX01YG1Xqe6/nDbdLX/73pst2M7MOR7rXRMxPcGQV3QK6Pl2uO8wkiHw5uouSA+PjVI18LqAUWIrHCM1M0jOIvd3cHSt7MDRRqOqKvy72kBhIGHABohpHLj3Hdtva2bSoB/m9NVEUGmdDnddlq0X5souclamaQg+k+xa5nitwqJjCX4z8yLG7s41bgmV0m7eX6D7lmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEbn7ZKbhpW/HN3nEY1hQzbOFg1wiSo6t0fZLyBJ8bw=;
 b=Ql3RGBVvELAsP/dj0xG0vPmRBcuDgbNLluD3pSmKNqHE+T/EjCJsgz6rgLkOhLN/Ln4201XbA161iHHw/f+cZU6omC3vMtShx+yTDj0EORbj1xIuzehFizg3xJAE+DNPlnG1fKFHEwBzgcEOCe+brFuTwnYAIC4n+y2gpW306uOaLBEXIwznMmiiEGVYBaPVF51ok5BZzjs5Z242K1o6W5Fqod08BjqUTp/NFlsLPfGozBzKtFgkaWYsgOe0vsPe0nEFD8GFz2VUtXQ7dcRbwb5c3x8dwFk56B1vnaQdrHDJy6vW7OV9QkA4FfhwihN9uV77/gqY7a8Jpvf6Q1IZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB6786.namprd11.prod.outlook.com (2603:10b6:303:20b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Sat, 11 Apr
 2026 01:35:32 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.014; Sat, 11 Apr 2026
 01:35:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 11/22] x86/virt/seamldr: Shut down the current TDX
 module
Thread-Topic: [PATCH v7 11/22] x86/virt/seamldr: Shut down the current TDX
 module
Thread-Index: AQHcwQwBQdKo1xDEBkCS+uvoFa2Ab7XZJN+A
Date: Sat, 11 Apr 2026 01:35:32 +0000
Message-ID: <a50bb8a4d8c2bdcb0795eca4551567fb5a577215.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-12-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-12-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB6786:EE_
x-ms-office365-filtering-correlation-id: 5f937f1b-3089-4bf0-1b2c-08de976a9efd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: gaI6u7iVbUiitop6Xv7hFJicvOymBTWMeklKPvb4B6/cSavAeUQtHcl3LlHLXOyuRMkrRguD3F8ksXmwsSVGI9KpTOSxodScjOET1xcIuvavyHaFFeSTaYwTSDJA5P9wGmh1LP7R8eESH4plbDb67cmyCZ/ztte+Mw3tEE7oFYMxuVNzROUaUICBmWoyD5DrjQk1dN8qhaUfaJAoRh1AAMM9YzYp83VBeFcjilv+q3xP12eHpGww4QCT/3BNEzqPaRUcCg5jnJRe9+hKdoWnw8yE50UhJXEUfiLc4VeEOrI5F10fvVWJTqL0mJaSrFGK9ajcwdDV8/pmPXaSpUmr8+HbPE8Z76zTRW0ILf5/WTSnS/jtvvpqWDWyTYjKgsU/fkNjQkjEpCJO+MkaVICYBjfTJ50gAfhmjKhW1PwCh3c/TX8GKIH21XUgES0673UfyPOK5/bpHzH65BmkmoyD3Y6UA6k/KrgzKf49abXEXZbBlRPPLD10iz6XvQVmNx24J9JAbmt4EgM+2LKFTPY7AbWU71KzWncZAFKJABtjzr0IFM4VYBrji3RjAweOidq879tU19V4RpUfEDSgQlod9An+mxszDhwl6KBzSApUvY1T+nFgkfnZ8hE8x4tK47lyEPGpvJ0je48+5ASdQGa7HBRkUHfCvTceWzS65dKrxBxGbgLHXAXm4FK3kQRaGzvDE01r6jo7tKyu35JlMvkx48/V5BdPh3ORgWOHTq+/ZwIHZQOZe9TbV/NCXI8o5yUFrW8llGbkt9X+WMY2dYmVK2vM6VEPu2rW8MumtJEHb7E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWJqeVdjYlQ4ZkVKWmRsdTVZeFVMRTIzWkxiT1JZSTRrTU1hM2RDRmJ3cDRY?=
 =?utf-8?B?VVluR080UDEwZFFhNjB4UmYrNERnZDd3eDFBOFgyL3c2amhXREt3Q0hsTDZS?=
 =?utf-8?B?Z2s5bjZUaVllZ2RvSm92VVBGdzVEcFA2RUdacGhDUWpRTThaWE5CNUxEK0I5?=
 =?utf-8?B?RXlnSDV5TXlJbmRWekl2WU5USFJyS25pZTE1V2ZXbWxIdUdDVVlUVkxKMnZN?=
 =?utf-8?B?WDJWZGs2Z2VTbitmRHM0YzFEaFl6U2pFbFFHTUZmK2NrQkRWdnU0bmhyNVho?=
 =?utf-8?B?T1phc09kY1I0UHhvSXNCKzdadlJJdTRmdXA1T3pGdjU2cGdLM3RmY0wvU0sr?=
 =?utf-8?B?RWVQb0RHMGZJM083UytnRWkzTGRRdkRqaE9Ga3BHbXpZR3gvQUZGaXlWVllY?=
 =?utf-8?B?clAwMGMyM3J5QlovbnFPRDhrYlhOcUdJNGpLZGZYUGN3RitvZEJmWGh1WGFN?=
 =?utf-8?B?VGwxZmIvRGhpOG1MbUE5bjdPK2QyWlRvUnF1aDA1VER6S0hUWDhvTENCQVYx?=
 =?utf-8?B?OWx5Nzdob05pNXNZaEs0Y2Q2YzNyS2RqRzN0ei9Vblo4bU5mWnNiMm0yaEE1?=
 =?utf-8?B?TmZzOTM3T3NPdVBXNTMrVldrUmhQeFVvaml2T3dYT25yKzkvbGZaMWoxUlNU?=
 =?utf-8?B?bHZjSENHOXFKdDg1OURtZ0E0TCtOcmQ4RExkaHdPWDdTZ2lmbzRKc3FDbzBs?=
 =?utf-8?B?ZzB2V1NBeEdZUmh5ZXdpWWoyMjc0cjhyK2tpSVdBY3JoK3NPRE8zdHg5Nyt4?=
 =?utf-8?B?ZlJlOFAza3JFZWtZdmEyWWV6dENldC9QOVNwQmJJRXQ0RDFQOW0zMkFhTjgz?=
 =?utf-8?B?ay95KzRMNGY0QjhOM1dXNTJGOTJaTkdUK0dISDZlVVplSUVRb2sycTc3SFYw?=
 =?utf-8?B?NEJIcStFQWcra1dwNmdxN0QwOVdQVXRBdDYwUFJkdlNtWlBNaHpydGpUVnpU?=
 =?utf-8?B?NENLckZ1R2gvdVVpR3VYWUloZ1YwbWRUemJMbXVBWmJaZWJrV2s0R3dRU1Vk?=
 =?utf-8?B?R2lMMG1Ob04zczBVNDBkNlV6bWdIR2pvaG9aaDFPTjVic0xaTGFVWGhYS0FC?=
 =?utf-8?B?cEluREd3UmtGUGVPNC82QW0zNHJXTlhWV3lBaEZDakNoS1BOTmNubmlJRDEw?=
 =?utf-8?B?SXNlNGNRQk1VQmpRNHV5ZEhvN3BEU3B0VEViSWNQenN1SEZjWS80Rzh5bThz?=
 =?utf-8?B?YmN6d3p4TmZ0K2JXSXY5bkFqY202L3IwaWQ2UmtORGxiSjg0cjVqUGVkSm90?=
 =?utf-8?B?UWwvQU8zMjlxKys4Unc1c0VNUytIeTZ4djNJOVVvMHJNN2xmU2lINlcyTGt5?=
 =?utf-8?B?RTE0aDFLU3Fzbnc2SXg1NnpNZWdVd1E0U1VpOSs1S3hPYmVIbk9FYmY1ekRO?=
 =?utf-8?B?QUIxbXJKbkpJM0ZGckx4dk5PQU1rZ1FNZVY2QlBZTm1BRW0zMy81eFUwVzZK?=
 =?utf-8?B?blZ3bzRhMEJvcWFpZ1UzSFlYQVBEU0dzSFVIM1cyRGtiS3VGV0ZiZHkwN0x3?=
 =?utf-8?B?YlFKNVFVajB6MTJhTEZYMWs2UmloU2luZkhwVFk1ZlFnRVdyS0Ntemgwek43?=
 =?utf-8?B?K2hIc21rcXBFT2VmUXdyaFRTSFJwTHdOeDhmR2hNL0FXQ01MMXRVSmhjTDVj?=
 =?utf-8?B?RmZ1ZkdnUEM0MURRWGl2UTdZR1g5RmZmRHVPT2ZuRHNYakNsSlZaelVJSWMw?=
 =?utf-8?B?eFJLekhxdGVqaEhpdGlWdE81OWVJeGlKSlVURE5Mc0xVbCtiYW5OT01TcnBw?=
 =?utf-8?B?VnVMZjYxZDA4QnFabkUvUVMwL3AxOG9KWTFDRDZPQTVZVHlWSmlDd3A4QVAv?=
 =?utf-8?B?L3JmYlRaSVM1NzQ1a0NoL3JaUHNRTS94L1duUnYvTitkak5xNUt3ZDU5aWV4?=
 =?utf-8?B?d3oyWElxbEJZV0RVTDQyd25JZkVRUUNTTGtQbzMxV2xBcHFkSHFuWVMzbGcy?=
 =?utf-8?B?REo5Y2RRczVlbVBDTkQ5dXR1NHA4N2tCWkZlc3VhT3ZuWllOYUlSUWpyNnpk?=
 =?utf-8?B?OUsxRUlCQ09OSHQ2aUlZbGdXMUtaNzYwU0RPcm9QeWxhOUgwVWF5NHVXZ1pk?=
 =?utf-8?B?VEJrRUtQd3BwT08yZmtOL0dmcGhHREsrWjVINkM0VG1GNGh3aXNGWG5EVUhO?=
 =?utf-8?B?bHFocDNtRWp3TUVTc0puYWt0ckc0VVM1ZVEwUjlKV25XQkJzVGtKNmNPVW5X?=
 =?utf-8?B?enl6VmVwbVQyZjNyZGFVQlZ3WERuUWdxYU12dXZXNEdqWmNwaU1mVlptYXpv?=
 =?utf-8?B?UDZlYURXMTFIU0R4NDRiZlc2Y2ZZdEJqVDFTZ29TcVFtYzJIUk5ZNjlYTDU5?=
 =?utf-8?B?SlNzdHJxdUt1dTIvbmkxV3pRWEJsS2tJaHNOZVlIU2syWWFjSHJRdjhIUm5Z?=
 =?utf-8?Q?OuXJ5NHmDsIGlQQQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99B337547EC36B44A968288295C7B460@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JOAyK2Jaobmx7L4szUF0QjBN3hYjPbYMYX1J+hYZmpqfPytZSlTvlYHjYkqE35vW9jOr9072s2AK5LzTOIRYg+3FkShduLn/oAZ/f+B/6KpfsGgQjpBYaohhKfsXhfQzFuzUKFYWIRKhOPIxIGZQplXIjvKDCaMNJ1cP6nlI/GLyldo6rUMfgT68nDNnQBa3WX4VpPmLZsdt50UgUec30rqK4MEFYWETwhF+Q0einW69MLWUKmbpdKUM4SMbxCx1jD+N3siIxyH8NgQPpwX8+2vkVoKhonPZbKi0HdYNqE0OjxDlJW5us+3/R4925K2S80ghHPhWo47Z5LKWxojh4g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f937f1b-3089-4bf0-1b2c-08de976a9efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 01:35:32.2601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uq1XsE4nS5xpDAjR7TMi7qCwo/L4Rt0owBHfcNm5NVORwkqGLHimDp1ezPE4HWDUO9zO/IuQl2hk/dNjPEeneoGbLv0+Z0vJ19JBngtVYCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6786
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVGhl
IGZpcnN0IHN0ZXAgb2YgVERYIG1vZHVsZSB1cGRhdGVzIGlzIHNodXR0aW5nIGRvd24gdGhlIGN1
cnJlbnQgVERYDQo+IE1vZHVsZS4gVGhpcyBzdGVwIGFsc28gcGFja3Mgc3RhdGUgaW5mb3JtYXRp
b24gdGhhdCBuZWVkcyB0byBiZQ0KPiBwcmVzZXJ2ZWQgYWNyb3NzIHVwZGF0ZXMgYXMgaGFuZG9m
ZiBkYXRhLCB3aGljaCB3aWxsIGJlIGNvbnN1bWVkIGJ5IHRoZQ0KPiB1cGRhdGVkIG1vZHVsZS4g
VGhlIGhhbmRvZmYgZGF0YSBpcyBzdG9yZWQgaW50ZXJuYWxseSBpbiB0aGUgU0VBTSByYW5nZQ0K
PiBhbmQgaXMgaGlkZGVuIGZyb20gdGhlIGtlcm5lbC4NCj4gDQo+IFRvIGVuc3VyZSBhIHN1Y2Nl
c3NmdWwgdXBkYXRlLCB0aGUgbmV3IG1vZHVsZSBtdXN0IGJlIGFibGUgdG8gY29uc3VtZQ0KPiB0
aGUgaGFuZG9mZiBkYXRhIGdlbmVyYXRlZCBieSB0aGUgb2xkIG1vZHVsZS4gU2luY2UgaGFuZG9m
ZiBkYXRhIGxheW91dA0KPiBtYXkgY2hhbmdlIGJldHdlZW4gbW9kdWxlcywgdGhlIGhhbmRvZmYg
ZGF0YSBpcyB2ZXJzaW9uZWQuIEVhY2ggbW9kdWxlDQo+IGhhcyBhIG5hdGl2ZSBoYW5kb2ZmIHZl
cnNpb24gYW5kIHByb3ZpZGVzIGJhY2t3YXJkIHN1cHBvcnQgZm9yIHNldmVyYWwNCj4gb2xkZXIg
dmVyc2lvbnMuDQo+IA0KPiBUaGUgY29tcGxldGUgaGFuZG9mZiB2ZXJzaW9uaW5nIHByb3RvY29s
IGlzIGNvbXBsZXggYXMgaXQgc3VwcG9ydHMgYm90aA0KPiBtb2R1bGUgdXBncmFkZXMgYW5kIGRv
d25ncmFkZXMuIFNlZSBkZXRhaWxzIGluIEludGVswq4gVHJ1c3QgRG9tYWluDQo+IEV4dGVuc2lv
bnMgKEludGVswq4gVERYKSBNb2R1bGUgQmFzZSBBcmNoaXRlY3R1cmUgU3BlY2lmaWNhdGlvbiwg
Q2hhcHRlcg0KPiAiSGFuZG9mZiBWZXJzaW9uaW5nIi4NCj4gDQo+IElkZWFsbHksIHRoZSBrZXJu
ZWwgbmVlZHMgdG8gcmV0cmlldmUgdGhlIGhhbmRvZmYgdmVyc2lvbnMgc3VwcG9ydGVkIGJ5DQo+
IHRoZSBjdXJyZW50IG1vZHVsZSBhbmQgdGhlIG5ldyBtb2R1bGUgYW5kIHNlbGVjdCBhIHZlcnNp
b24gc3VwcG9ydGVkIGJ5DQo+IGJvdGguIEJ1dCwgc2luY2UgdGhpcyBpbXBsZW1lbnRhdGlvbiBj
aG9vc2VzIHRvIG9ubHkgc3VwcG9ydCBtb2R1bGUNCj4gdXBncmFkZXMsIHNpbXBseSByZXF1ZXN0
IHRoZSBjdXJyZW50IG1vZHVsZSB0byBnZW5lcmF0ZSBoYW5kb2ZmIGRhdGENCj4gdXNpbmcgaXRz
IGhpZ2hlc3Qgc3VwcG9ydGVkIHZlcnNpb24sIGV4cGVjdGluZyB0aGF0IHRoZSBuZXcgbW9kdWxl
IHdpbGwNCj4gbGlrZWx5IHN1cHBvcnQgaXQuDQoNCkkgZmVlbCBsaWtlIHNvbWV3aGVyZSBpdCdz
IG1pc3Npbmcgd2hhdCB0aGlzIHBhdGNoIGRvZXMuIEl0IGV4cGxhaW5zIHRoZQ0KcmVhc29uaW5n
IGZvciB0aGUgaGFuZG9mZiB2ZXJzaW9uIHNlbGVjdGlvbiwgYnV0IG5vdGhpbmcgYWJvdXQgaW1w
bGVtZW50DQoiTU9EVUxFX1VQREFURV9TSFVURE9XTiIgb3IgYW55dGhpbmcgbGlrZSB0aGF0Lg0K
DQo+IA0KPiBOb3RlIHRoYXQgb25seSBvbmUgQ1BVIG5lZWRzIHRvIGNhbGwgdGhlIFREWCBtb2R1
bGUncyBzaHV0ZG93biBBUEkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIEdhbyA8Y2hhby5n
YW9AaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogVG9ueSBMaW5kZ3JlbiA8dG9ueS5saW5kZ3Jl
bkBsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBYdSBZaWx1biA8eWlsdW4ueHVAbGlu
dXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwu
Y29tPg0KPiBSZXZpZXdlZC1ieTogS2lyeWwgU2h1dHNlbWF1IChNZXRhKSA8a2FzQGtlcm5lbC5v
cmc+DQo+IC0tLQ0KPiB2NToNCj4gIC0gTWFzc2FnZSBjaGFuZ2Vsb2cgW0thaV0NCj4gIC0gQXZv
aWQgInJlZmVycyB0byB0aGUgZ2xvYmFsIGNvcHkgd2hpbGUgcG9wdWxhdGluZyB0aGUgdGR4X3N5
c19pbmZvDQo+ICAgIHBhc3NlZCBhcyBhIHBvaW50ZXIiIFtSaWNrL1lpbHVuXQ0KPiANCj4gdjQ6
DQo+ICAtIHNraXAgdGhlIHdob2xlIGhhbmRvZmYgbWV0YWRhdGEgaWYgcnVudGltZSB1cGRhdGVz
IGFyZSBub3Qgc3VwcG9ydGVkDQo+ICAgIFtZaWx1bl0NCj4gdjM6DQo+ICAtIHJlbW92ZSBhdXRv
Z2VuZXJhdGlvbiBzdHVmZiBpbiB0aGUgY2hhbmdlbG9nDQo+IHYyOg0KPiAgLSBhZGQgYSBjb21t
ZW50IGFib3V0IGhvdyBoYW5kb2ZmIHZlcnNpb24gaXMgY2hvc2VuLg0KPiAgLSByZW1vdmUgdGhl
IGZpcnN0ICFyZXQgaW4gZ2V0X3RkeF9zeXNfaW5mb19oYW5kb2ZmKCkgYXMgd2UgZWRpdGVkIHRo
ZQ0KPiAgICBhdXRvLWdlbmVyYXRlZCBjb2RlIGFueXdheQ0KPiAgLSByZW1vdmUgISEgd2hlbiBk
ZXRlcm1pbmluZyB3aGV0aGVyIGEgQ1BVIGlzIHRoZSBwcmltYXJ5IG9uZQ0KPiAgLSByZW1vdmUg
dW5uZWNlc3NhcnkgaWYtYnJlYWsgbmVzdGluZyBpbiBURFBfU0hVVERPV04NCj4gLS0tDQo+ICBh
cmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHhfZ2xvYmFsX21ldGFkYXRhLmggIHwgIDUgKysrKysNCj4g
IGFyY2gveDg2L3ZpcnQvdm14L3RkeC9zZWFtbGRyLmMgICAgICAgICAgICAgfCAxMSArKysrKysr
KysrLQ0KPiAgYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jICAgICAgICAgICAgICAgICB8IDE1
ICsrKysrKysrKysrKysrKw0KPiAgYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5oICAgICAgICAg
ICAgICAgICB8ICAzICsrKw0KPiAgYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeF9nbG9iYWxfbWV0
YWRhdGEuYyB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDUz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS90ZHhfZ2xvYmFsX21ldGFkYXRhLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS90ZHhfZ2xvYmFsX21ldGFkYXRhLmgNCj4gaW5kZXggNDA2ODljOGRjNjdlLi44YTllYmQ4OTVl
NzAgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RkeF9nbG9iYWxfbWV0YWRh
dGEuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHhfZ2xvYmFsX21ldGFkYXRhLmgN
Cj4gQEAgLTQwLDEyICs0MCwxNyBAQCBzdHJ1Y3QgdGR4X3N5c19pbmZvX3RkX2NvbmYgew0KPiAg
CXU2NCBjcHVpZF9jb25maWdfdmFsdWVzWzEyOF1bMl07DQo+ICB9Ow0KPiAgDQo+ICtzdHJ1Y3Qg
dGR4X3N5c19pbmZvX2hhbmRvZmYgew0KPiArCXUxNiBtb2R1bGVfaHY7DQo+ICt9Ow0KPiArDQo+
ICBzdHJ1Y3QgdGR4X3N5c19pbmZvIHsNCj4gIAlzdHJ1Y3QgdGR4X3N5c19pbmZvX3ZlcnNpb24g
dmVyc2lvbjsNCj4gIAlzdHJ1Y3QgdGR4X3N5c19pbmZvX2ZlYXR1cmVzIGZlYXR1cmVzOw0KPiAg
CXN0cnVjdCB0ZHhfc3lzX2luZm9fdGRtciB0ZG1yOw0KPiAgCXN0cnVjdCB0ZHhfc3lzX2luZm9f
dGRfY3RybCB0ZF9jdHJsOw0KPiAgCXN0cnVjdCB0ZHhfc3lzX2luZm9fdGRfY29uZiB0ZF9jb25m
Ow0KPiArCXN0cnVjdCB0ZHhfc3lzX2luZm9faGFuZG9mZiBoYW5kb2ZmOw0KPiAgfTsNCj4gIA0K
PiAgI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWxkci5j
IGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1sZHIuYw0KPiBpbmRleCA1OTY0YmJjNjc5NDQu
LmE4YmZhMzBlZTU1ZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1s
ZHIuYw0KPiArKysgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWxkci5jDQo+IEBAIC0xNSw2
ICsxNSw3IEBADQo+ICAjaW5jbHVkZSA8YXNtL3NlYW1sZHIuaD4NCj4gIA0KPiAgI2luY2x1ZGUg
InNlYW1jYWxsX2ludGVybmFsLmgiDQo+ICsjaW5jbHVkZSAidGR4LmgiDQo+ICANCj4gIC8qIFAt
U0VBTUxEUiBTRUFNQ0FMTCBsZWFmIGZ1bmN0aW9uICovDQo+ICAjZGVmaW5lIFBfU0VBTUxEUl9J
TkZPCQkJMHg4MDAwMDAwMDAwMDAwMDAwDQo+IEBAIC0yMDcsNiArMjA4LDcgQEAgc3RhdGljIHN0
cnVjdCBzZWFtbGRyX3BhcmFtcyAqaW5pdF9zZWFtbGRyX3BhcmFtcyhjb25zdCB1OCAqZGF0YSwg
dTMyIHNpemUpDQo+ICAgKi8NCj4gIGVudW0gbW9kdWxlX3VwZGF0ZV9zdGF0ZSB7DQo+ICAJTU9E
VUxFX1VQREFURV9TVEFSVCwNCj4gKwlNT0RVTEVfVVBEQVRFX1NIVVRET1dOLA0KPiAgCU1PRFVM
RV9VUERBVEVfRE9ORSwNCj4gIH07DQo+ICANCj4gQEAgLTI0Niw4ICsyNDgsMTIgQEAgc3RhdGlj
IHZvaWQgYWNrX3N0YXRlKHZvaWQpDQo+ICBzdGF0aWMgaW50IGRvX3NlYW1sZHJfaW5zdGFsbF9t
b2R1bGUodm9pZCAqc2VhbWxkcl9wYXJhbXMpDQo+ICB7DQo+ICAJZW51bSBtb2R1bGVfdXBkYXRl
X3N0YXRlIG5ld3N0YXRlLCBjdXJzdGF0ZSA9IE1PRFVMRV9VUERBVEVfU1RBUlQ7DQo+ICsJaW50
IGNwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsNCj4gKwlib29sIHByaW1hcnk7DQo+ICAJaW50IHJl
dCA9IDA7DQo+ICANCj4gKwlwcmltYXJ5ID0gY3B1bWFza19maXJzdChjcHVfb25saW5lX21hc2sp
ID09IGNwdTsNCj4gKw0KPiAgCWRvIHsNCj4gIAkJLyogQ2hpbGwgb3V0IGFuZCByZS1yZWFkIHVw
ZGF0ZV9kYXRhLiAqLw0KPiAgCQljcHVfcmVsYXgoKTsNCj4gQEAgLTI1Niw3ICsyNjIsMTAgQEAg
c3RhdGljIGludCBkb19zZWFtbGRyX2luc3RhbGxfbW9kdWxlKHZvaWQgKnNlYW1sZHJfcGFyYW1z
KQ0KPiAgCQlpZiAobmV3c3RhdGUgIT0gY3Vyc3RhdGUpIHsNCj4gIAkJCWN1cnN0YXRlID0gbmV3
c3RhdGU7DQo+ICAJCQlzd2l0Y2ggKGN1cnN0YXRlKSB7DQo+IC0JCQkvKiBUT0RPOiBhZGQgdGhl
IHVwZGF0ZSBzdGVwcy4gKi8NCj4gKwkJCWNhc2UgTU9EVUxFX1VQREFURV9TSFVURE9XTjoNCj4g
KwkJCQlpZiAocHJpbWFyeSkNCj4gKwkJCQkJcmV0ID0gdGR4X21vZHVsZV9zaHV0ZG93bigpOw0K
PiArCQkJCWJyZWFrOw0KPiAgCQkJZGVmYXVsdDoNCj4gIAkJCQlicmVhazsNCj4gIAkJCX0NCj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyBiL2FyY2gveDg2L3ZpcnQv
dm14L3RkeC90ZHguYw0KPiBpbmRleCAxNzJmNmQ0MTMzYjUuLmY4N2ZhZDQyOWY0ZSAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2L3Zp
cnQvdm14L3RkeC90ZHguYw0KPiBAQCAtMTE3Niw2ICsxMTc2LDIxIEBAIGludCB0ZHhfZW5hYmxl
KHZvaWQpDQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0ZPUl9LVk0odGR4X2VuYWJsZSk7DQo+ICAN
Cj4gK2ludCB0ZHhfbW9kdWxlX3NodXRkb3duKHZvaWQpDQo+ICt7DQo+ICsJc3RydWN0IHRkeF9t
b2R1bGVfYXJncyBhcmdzID0ge307DQo+ICsNCj4gKwkvKg0KPiArCSAqIFNodXQgZG93biB0aGUg
VERYIG1vZHVsZSBhbmQgcHJlcGFyZSBoYW5kb2ZmIGRhdGEgZm9yIHRoZSBuZXh0DQo+ICsJICog
VERYIG1vZHVsZS4gVGhpcyBTRUFNQ0FMTCByZXF1aXJlcyBhIGhhbmRvZmYgdmVyc2lvbi4gVXNl
IHRoZQ0KPiArCSAqIG1vZHVsZSdzIGhhbmRvZmYgdmVyc2lvbiwgYXMgaXQgaXMgdGhlIGhpZ2hl
c3QgdmVyc2lvbiB0aGUNCj4gKwkgKiBtb2R1bGUgY2FuIHByb2R1Y2UgYW5kIGlzIG1vcmUgbGlr
ZWx5IHRvIGJlIHN1cHBvcnRlZCBieSBuZXcNCj4gKwkgKiBtb2R1bGVzIGFzIG5ldyBtb2R1bGVz
IGxpa2VseSBoYXZlIGhpZ2hlciBoYW5kb2ZmIHZlcnNpb24uDQo+ICsJICovDQoNClRoaXMgb25l
IGNvdWxkIHByb2JhYmx5IGJlIG1hZGUgbGVzcyB2ZXJib3NlIHRvby4NCg0KPiArCWFyZ3MucmN4
ID0gdGR4X3N5c2luZm8uaGFuZG9mZi5tb2R1bGVfaHY7DQo+ICsJcmV0dXJuIHNlYW1jYWxsX3By
ZXJyKFRESF9TWVNfU0hVVERPV04sICZhcmdzKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGJvb2wg
aXNfcGFtdF9wYWdlKHVuc2lnbmVkIGxvbmcgcGh5cykNCj4gIHsNCj4gIAlzdHJ1Y3QgdGRtcl9p
bmZvX2xpc3QgKnRkbXJfbGlzdCA9ICZ0ZHhfdGRtcl9saXN0Ow0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvdmlydC92bXgvdGR4L3RkeC5oIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5oDQo+
IGluZGV4IDgyYmI4MmJlODU2Ny4uMWM0ZGE5NTQwYWUwIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4
Ni92aXJ0L3ZteC90ZHgvdGR4LmgNCj4gKysrIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5o
DQo+IEBAIC00Niw2ICs0Niw3IEBADQo+ICAjZGVmaW5lIFRESF9QSFlNRU1fUEFHRV9XQklOVkQJ
CTQxDQo+ICAjZGVmaW5lIFRESF9WUF9XUgkJCTQzDQo+ICAjZGVmaW5lIFRESF9TWVNfQ09ORklH
CQkJNDUNCj4gKyNkZWZpbmUgVERIX1NZU19TSFVURE9XTgkJNTINCj4gIA0KPiAgLyoNCj4gICAq
IFNFQU1DQUxMIGxlYWY6DQo+IEBAIC0xMTgsNCArMTE5LDYgQEAgc3RydWN0IHRkbXJfaW5mb19s
aXN0IHsNCj4gIAlpbnQgbWF4X3RkbXJzOwkvKiBIb3cgbWFueSAndGRtcl9pbmZvJ3MgYXJlIGFs
bG9jYXRlZCAqLw0KPiAgfTsNCj4gIA0KPiAraW50IHRkeF9tb2R1bGVfc2h1dGRvd24odm9pZCk7
DQo+ICsNCj4gICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3Rk
eF9nbG9iYWxfbWV0YWRhdGEuYyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHhfZ2xvYmFsX21l
dGFkYXRhLmMNCj4gaW5kZXggMzRjMDUwZDc0YjU2Li4yMjVlMTU3ODA1ZTggMTAwNjQ0DQo+IC0t
LSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHhfZ2xvYmFsX21ldGFkYXRhLmMNCj4gKysrIGIv
YXJjaC94ODYvdmlydC92bXgvdGR4L3RkeF9nbG9iYWxfbWV0YWRhdGEuYw0KPiBAQCAtMTAwLDYg
KzEwMCwxOSBAQCBzdGF0aWMgaW50IGdldF90ZHhfc3lzX2luZm9fdGRfY29uZihzdHJ1Y3QgdGR4
X3N5c19pbmZvX3RkX2NvbmYgKnN5c2luZm9fdGRfY29uZg0KPiAgCXJldHVybiByZXQ7DQo+ICB9
DQo+ICANCj4gK3N0YXRpYyBpbnQgZ2V0X3RkeF9zeXNfaW5mb19oYW5kb2ZmKHN0cnVjdCB0ZHhf
c3lzX2luZm9faGFuZG9mZiAqc3lzaW5mb19oYW5kb2ZmKQ0KPiArew0KPiArCWludCByZXQ7DQo+
ICsJdTY0IHZhbDsNCj4gKw0KPiArCXJldCA9IHJlYWRfc3lzX21ldGFkYXRhX2ZpZWxkKDB4ODkw
MDAwMDEwMDAwMDAwMCwgJnZhbCk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4g
Kw0KPiArCXN5c2luZm9faGFuZG9mZi0+bW9kdWxlX2h2ID0gdmFsOw0KPiArCXJldHVybiAwOw0K
PiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IGdldF90ZHhfc3lzX2luZm8oc3RydWN0IHRkeF9zeXNf
aW5mbyAqc3lzaW5mbykNCj4gIHsNCj4gIAlpbnQgcmV0ID0gMDsNCj4gQEAgLTExNiw1ICsxMjks
MTIgQEAgc3RhdGljIGludCBnZXRfdGR4X3N5c19pbmZvKHN0cnVjdCB0ZHhfc3lzX2luZm8gKnN5
c2luZm8pDQo+ICAJcmV0ID0gcmV0ID86IGdldF90ZHhfc3lzX2luZm9fdGRfY3RybCgmc3lzaW5m
by0+dGRfY3RybCk7DQo+ICAJcmV0ID0gcmV0ID86IGdldF90ZHhfc3lzX2luZm9fdGRfY29uZigm
c3lzaW5mby0+dGRfY29uZik7DQo+ICANCj4gKwkvKg0KPiArCSAqIERvbid0IHRyZWF0IGEgbW9k
dWxlIHRoYXQgZG9lc24ndCBzdXBwb3J0IHVwZGF0ZSBhcyBhIGZhaWx1cmUuDQo+ICsJICogT25s
eSByZWFkIHRoZSBtZXRhZGF0YSBvcHRpb25hbGx5Lg0KPiArCSAqLw0KPiArCWlmICh0ZHhfc3Vw
cG9ydHNfcnVudGltZV91cGRhdGUoc3lzaW5mbykpDQo+ICsJCXJldCA9IHJldCA/OiBnZXRfdGR4
X3N5c19pbmZvX2hhbmRvZmYoJnN5c2luZm8tPmhhbmRvZmYpOw0KPiArDQo+ICAJcmV0dXJuIHJl
dDsNCj4gIH0NCg0K
