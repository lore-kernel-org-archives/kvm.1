Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21FD3D3317;
	Thu,  6 Aug 2026 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054983; cv=fail; b=UUC2z6/8gA1bjdIpI6tzEKY0JAGXFoqYdZVIsRGnYfG3Ayj3eA/IzpII8vpuif73gR10zvE//EARGGO0xckelWqQztomgE4KGY4WfPBj1SB5bSjilCeFeah2hMPPCK7jSiOZ57hHjdRUKiHvSaLFrkYiIPeirRFeGbkK4uWnsXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054983; c=relaxed/simple;
	bh=wDb28ZmzF0qfiCxwd4XXdRu8pVuUohH/pIgwGNyPmdo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NA3yHGuabT45PdJe9nG59Fe6mKOBF2jmkNwfv2woEA4e/G5JBTRccSAK++89NXctqZzlH2l0cEcUlvUd4Rc3cVXh1xK4r03635T5lXueF6kAYFDYwrIZZ2dq7B6PoIIPxlL40PPKSO6pd4X/LvtfWqSrt0/BzxcjdCy+oMpJSwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxKH5rpc; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxKH5rpc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786054982; x=1817590982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wDb28ZmzF0qfiCxwd4XXdRu8pVuUohH/pIgwGNyPmdo=;
  b=MxKH5rpcFdInfGxYkkCEHfEFfnuoxIMkS50Vk3ID0Tkrydf+4Io/BYt0
   ZonNPze9bpwJBz4GWFqhFeYlRY64OSwCDfHBUPw1Bo2rbySW6qazs+DLm
   WImoDJuqujN+FMlBeeKQmdDQEa9Vw3LGkZsoVqVVZh1HbTYvFiM8Oh0uY
   t721pcVDVEauet0C5sx6qC9RiMKg0q+1rOOISJfTOUdvmczFLxvI7RxoH
   5ThsmeWLIm27qjn1d0JThzjNbGXp1aHg2JnRwQobdnfrMEzvynELcqETz
   YbAFY+1zlQzROhpKSAXFi51hirVcHFzZ3Huq44egmVPTBFcAts2FLhRsT
   g==;
X-CSE-ConnectionGUID: S4UWnn78SsyRpAUvwaml/Q==
X-CSE-MsgGUID: ta8fMDmjTBmzaMKBV1vnbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="90479119"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="90479119"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 15:23:01 -0700
X-CSE-ConnectionGUID: u8ujbXGZTQuANFKMzXP/Xg==
X-CSE-MsgGUID: ZDs8tmy+Sru5EiN9oklMGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="266066053"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 15:23:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 15:22:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 15:22:59 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 15:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCqk6xgrB36V667keifd31P7Jp++SgjkniRHaumZemrFcxS7WvurycjaTlXRXULioLZWaurD6F0eWtVdS/sg2v8t9S9U9m9r0CmLEF+lL/1NpNvFoYa5RcjNVqAonhtPHBhGV82c8+H1L8oUAx1lVqQSmYvWhEtLubtsEi1CeOn153PAUWgn1Da3BExs6FXxsOQDOTjLArZoPRmafwJ0AVzoQiIJeVobUX8cCeyZQGNyxyeiROHMaIdZxJ3BqTSibTkVW0RgH7QGwNbcnaK2fNs7/g6CrQ8GNm882hGK7qQu0k9/qUiAoKXiTLLxhNuT0uFeNI/FLw/6fp36SjPHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDb28ZmzF0qfiCxwd4XXdRu8pVuUohH/pIgwGNyPmdo=;
 b=fKivA0p9zfnX1tbynPozs/DW0pMCH7aNU61jc+Nv5uLqqqlxUPYGoYYX+46/xeE0EGV69OQZXLgnZDlVzg6myNLJT7Verz8On+Go9/ZbKSX2vi7K4y39UQ8rAnJNHEPO4Z+qQKSviTuw91CMYgVM/eJHLxObA9hwQg1xudC3BbCRUh2Ci3LBMrPHnDdc+6rrotx6lw94mHeO8lNfws4oRLXuoR9HzUq1yg5HONQH5AcpKzht8TyN/si+wUIuVodql8Sk3MQeaksFYju2sWVQgpzRF0HeaUAx/l0d2cGdT8dnZB8hnAoqGr0HPbA7dTUBhRMprFHfmhERyEYZWGVdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB7557.namprd11.prod.outlook.com (2603:10b6:8:14d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 22:22:56 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 22:22:54 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Wu, Binbin"
	<binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"hongyu.ning@linux.intel.com" <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH v9 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Thread-Topic: [PATCH v9 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Thread-Index: AQHdJUiUgfNOhpex5U+4sSzG4igyzLaRRGkAgABVP4A=
Date: Thu, 6 Aug 2026 22:22:53 +0000
Message-ID: <b48394cf6cd7e4bf365197986746116e435d6c11.camel@intel.com>
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
	 <20260806020850.1221381-4-rick.p.edgecombe@intel.com>
	 <84deae0a-2922-4d69-9e8b-4b1b18968c6a@intel.com>
In-Reply-To: <84deae0a-2922-4d69-9e8b-4b1b18968c6a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB7557:EE_
x-ms-office365-filtering-correlation-id: ade6444a-e2fc-48bb-cf9c-08def4094258
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|921020|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: A6V5jFZ6jkfm+498Z1LTRDarKKUPaYksbbSeMVe/syfvBbNTeeZYAszzJ8BINfCYcZkH4HmOmgTkRgamQbVofOymO5AiEjwJjlmH5/8StIe/Ye+m5rf4smKbHSWz4fVyX+Wocfk79quCVPKwM0YXZsjlsivUwmN1AjUSOt/UT4qZIJd45/Zdt4tvUMNUsOZG776WjGFDHt1HaDHyzuHfv/Gnqd37GnSpj16z7jhGPXMHx7cbTmD7ZaVzze3mQvwlbnM5czeB04KaKF/Vt1jdg45DY2dUsJCAkEUQQqZqS+i8vEE5uUYQoTOtM+DO75wcPsaDhLn1JvKpiNORv6rXnL/5/aStD8IpnFYTXR7TakE5Aii24d/D5FWqh/rXaYGt5uBCMQwsXC9pYFWki+8nCQb/guOlP6dt3A/BvBrFyJUd1hBOFbAa9P7samGDlWhwVDkIiLxYGSy9ghvTtZj39iSz28ShnIpLn46f+LjG9jwvhCfO1KFjKlwBZ8F6u+cF0r+Hoe4IHZDbW4NMEOm+wEJQTIw+f3d+iGgMnzK9mz1COLYGL5jdbaqEHktqo51ENn3S4PcarKJ84stainyx7yDficab+r4if8KxOUfi3MLlN5TvOHUVc2XXiWRcW1ks+rAwmwwqUpRj9AZKIPzu8oTq01U5Ihkk8nDNVusF4HTLzVMWu9FfOwIbkb4i9Jcc0YRH1TBi6E7ATz6M/HOo1b1tkO7vaCn/qfB2IpKtnFnwlxhxd9/V2/fSFtzQVPZt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STBLVnhNT0tTZFpHaVhham90WEp3NXJqdGpTeTJvcWlEdytJTFZmMjA4L05r?=
 =?utf-8?B?VE9qU3lLMVpUbEVTTnhiall2TkxBRDcyTE5GK1BIOWN2RzZNNmNkL1J3Ymg1?=
 =?utf-8?B?Uk1tM1hUd1dHZnp6cXE2SEZ5aTVBc285WnRMVUNOalRpbE4zcy92SmxsU3k3?=
 =?utf-8?B?U3FTcUFJc2dKdi9Mb2g3dXN2cFdvMnpPOURaM09QMlJsdVFrTXV1WW9qS011?=
 =?utf-8?B?WnkwUERKKzNLR1A1SEcwL0NvY1RwY3JTb3krZ0c4T25ZMEhPZ2lZZ21SQzlZ?=
 =?utf-8?B?WnBaMkpGRllzYzhNTzdqTEI3RzhvWGhUT2lNWFdpK3drMkZ5dWJUSmkwaXBI?=
 =?utf-8?B?Y1RleFJGb2d4ZkxlMmp6cCtsSkRqMGV3WjQ0YVBwQXVDbFYya2loaFowdEU1?=
 =?utf-8?B?TGdEY0RRa2dMYSsrT3greXVlUUhCYlhyVzFYOGlqa1RzQ2RkNVNDaW14RU1F?=
 =?utf-8?B?eEQzdUVVNGsrMlYxckRVMFpCa2cwY3JGVU5PNXNPQmVvTkU3OWZYN2RJSXd4?=
 =?utf-8?B?djNxcEtQWm43M3ZVSTByNFRhT2lBRWJtZFNjdVpLRkl5clMvSTVXN0w5ditC?=
 =?utf-8?B?V0ZiMGovbmtHeUQ0WkdZaW5ZUDRNbC8zNGNmU09sZ3hxcVpmMDNjMEtlZHpy?=
 =?utf-8?B?dzFpbmFBWVlhMkYxTHVIdWpUbjI2YVl1MC9GZlBkRk10V3NBbzd3U0JmUFkz?=
 =?utf-8?B?L1pndkg4ZnVmZWFiWXl5ejMwVHlDWm5JZzVFVWNNR3VoOFJwdUZ3MHA4MVdE?=
 =?utf-8?B?UzRFUFEwOGFEV05sN1BPWGJDaHpuRmNGbmlpZlFjTFJDM2RMK3V2RER2UTlN?=
 =?utf-8?B?b0MwYjYxYU5IMVg2b0JiZGtJNlpPV3h0V0t0Rm1HaE1KRTZFc05UZlZtRE1j?=
 =?utf-8?B?SEJyOUJNcXRncHc3SlJFRFZ6RzhhNGJBUDF4SDNod25Yd21ZZTh1MkVOYVNl?=
 =?utf-8?B?a0Z1V1RFKzh5SlhDb0ZMNDU2ck80am9sSzU5ai9rc2UzcHhWSDk1M2NHS1Bw?=
 =?utf-8?B?b1BZeExYZEZXbE5GZExFRG9OL1VVVEg5WlhXcG5vR1ZtQ1VGd0V0KzZFVE5E?=
 =?utf-8?B?WFJDbkZFQUdDelVEWC9kSDIzaUMraE01N3JhK0pTbDBFN1QybnpTeC9SZDZE?=
 =?utf-8?B?dGxqemw2eEx2UFpyVHY1VnlTOUFtM284U2IvSUpvMWdlZlN5bnZPaGQ0T0dz?=
 =?utf-8?B?NXcxeFhxa3hIQXg3Ui9SK3RQYXpvT1YvY0lIc1R1eURxUCtiNThHZHdNTEd4?=
 =?utf-8?B?QkFKUmp6SlRqRUczaGtPY1RoT2tBVmJSeFMrSlBQSzMvU2Mrb2VWNmg4OWQy?=
 =?utf-8?B?Zm9wNFFCTkt4b1RNajVQeWJBczBBcFdML05uTWFYQjExQnlvcmNvMDI5cThs?=
 =?utf-8?B?WksxQ3R3VmhQY2VzcHNFSWlUVTBFbXRWQ0w1TFkwM1diVFlCbVNKcTI5NnNq?=
 =?utf-8?B?N1Q3TUd4Vk1qSjJRL1grWDNwVG85ZC9tZjNnVGdVNktXYVl3QVAxWTNBMmlL?=
 =?utf-8?B?NXFuUjVBWG9WNS9tNEFycUg5cGs0YVF4WUNNanhBcVN5akE1ZUZtbzBrVklD?=
 =?utf-8?B?Ri9nOW5xODVDQXdTbFcraldPOGw0MzhWV0NyMUVjOWVqYnYwOVdORkcwaDFj?=
 =?utf-8?B?Tmtwem00VHlMTnpacUI1VFJhRW1Ca2xkaEhrMk5JRzRMK3Y1TERoVlhINjhC?=
 =?utf-8?B?TkNuT3V6cDQrL3N6L0NtUDNxY09Pa3FiMjU2Wmx2NkcycDd2VVZWM2dwTmpX?=
 =?utf-8?B?TlYyYWUzd0plaEZHUGU1QmN5ZWZWR2prcFJuZzBuK3Vwb2tBK01SUHliVGNv?=
 =?utf-8?B?RUdmeXJjbi8xckhMSWxpTnpERVA4eU0wOEVhblRaTEczSTgxQm9iZW1EMmlE?=
 =?utf-8?B?NHQwaFpBQjV4enlWdDFyQTZaTlFvNVYxbVJmT1BMSDloWXhXRWZlTEIxaS9X?=
 =?utf-8?B?SXJONWxxTGRub2xlUkx4SkNGclJNZTZjd0ErTzFTTjdwakxFSit5OVJaUUhx?=
 =?utf-8?B?U1pYOWwxS1R2RU1PMFd1K0FNOE9KcWtPS2dVbXdhWlJuT0dVY25vRlloWE9j?=
 =?utf-8?B?S0YyUkJNVmJjZlFqSThhVE1ob2J1SmhJQ2dFU2lFSWVPMVFxT25VTHRrYlFY?=
 =?utf-8?B?ek14Y0FmU0RMMW41RWhWd0NYcXVjRjBxQ29vUXd0VWoxWkZRaGMwUUJWZVFW?=
 =?utf-8?B?dE8zL0RvMTFSVi80aTdWVi81VnB0VmhLTnNpYi9xbTRoKzlHc1dZbGVsQjNk?=
 =?utf-8?B?UGVDM3c5ZFRLbXJJaFoveGw3dDR6N2NvKzNsV1N1TzR5YXNwOTF1MHRoT3Rx?=
 =?utf-8?B?R0RwVmVqOGQvQkdsQldzblgrelUyM0NyZVNnSUtKOTU0eDAzN0xMTGZuVVla?=
 =?utf-8?Q?WvT3jvu+u15/bvig=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11DB6939C701384281CAFA975D0563AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UEE7Dj79iOYL1jt1FfVoglnQ8kIUYthBVS50S3iI5cJHE5fErElFG3QvRv/mGK5DdXrUAoHJ9K2J4DhVcskIv+O6hOojsTp0uSGa8GHtkotRiGnh09Vn1lIgGKGuj0yupKct3GPM347fNdZUxIrGP/zoUT7MhL4SB1YK7PELTFWGeijwSmyqIF3qR1Tnrp4X6fRxP3GU9b/oMi2memoiREUUvO19gCgVx45ERg7PbYTpsEyYPHg29xWYko31IpFCAHsfxj+d7tqUvVGbhkn8vKdGWU7ucNgO2nKQOggzIje+pwrtPBxtnP/oazxwc3wStc32/8NRbXa8iJE9AQJSaw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade6444a-e2fc-48bb-cf9c-08def4094258
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 22:22:53.8095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RoJEeYy07z0u6o6XG1qaP4jTG8EKeuNT8mNlgWZdxM14q4qCjmEVAmr2jeXox8QtP9jcN29GFet3fbj4jyScx6VQdN3ARtRPWnPCZB4J8gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7557
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA4LTA2IGF0IDEwOjE3IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
PiArLyoNCj4gPiArICogQ2FsY3VsYXRlIHRoZSBhcmcgbmVlZGVkIGZvciBvcGVyYXRpbmcgb24g
dGhlIERQQU1UIGJhY2tpbmcgZm9yDQo+ID4gKyAqIGEgZ2l2ZW4gNEtCIHBhZ2UuDQo+ID4gKyAq
Lw0KPiA+ICtzdGF0aWMgdTY0IHBhbXRfMm1iX2FyZyhrdm1fcGZuX3QgcGZuKQ0KPiA+ICt7DQo+
ID4gKwkvKiBBcmcgdmFsdWUgd2lsbCBzcGVjaWZ5IGEgMk1CIHJlZ2lvbiBvZiBwaHlzaWNhbCBh
ZGRyZXNzIHNwYWNlLg0KPiA+ICovDQo+ID4gKwl1bnNpZ25lZCBsb25nIGhwYV8ybWIgPSBBTElH
Tl9ET1dOKHBmbiA8PCBQQUdFX1NISUZULCBQTURfU0laRSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IGhwYV8ybWIgfCBURFhfUFNfMk07DQo+ID4gK30NCj4gDQo+IC8qIEhlbHBlciBmb3IgYnVpbGRp
bmcgZHluYW1pYyBQQU1UIHNlYW1jYWxsKCkgYXJndW1lbnRzLiAqLw0KDQpIbW0gb2suIEknbSBz
ZWVpbmcgYSBkaWZmZXJlbmNlIGluIGFuc3dlcmluZyAid2hhdCBpcyB0aGlzIHRoaW5nIiB2cyBh
bg0KaW1wZXJhdGl2ZSBjb21tYW5kIHRvIHRoZSBmdW5jdGlvbiB0byBleGlzdC4gQW5kIEknbGwg
Y2hhbmdlIHRoZSBjb21tZW50IHRvIHNheQ0KRFBBTVQuDQoNCj4gc3RhdGljIHU2NCBwYW10XzJt
Yl9hcmcoa3ZtX3Bmbl90IHBmbikNCj4gew0KPiAJLyogRmluZCB0aGUgMk1CLXdpZGUgRFBBTVQg
cmVnaW9uIGZvciAncGZuJzogICovDQo+IAl1bnNpZ25lZCBsb25nIGhwYV8ybWIgPSBBTElHTl9E
T1dOKHBmbiA8PCBQQUdFX1NISUZULCBQTURfU0laRSk7DQo+IA0KPiAJLyogVGFsayBhYm91dCB3
aHkgdGhlIGZsYWcgaXMgbmVlZGVkLi4uICovDQo+IAlyZXR1cm4gaHBhXzJtYiB8IFREWF9QU18y
TTsNCj4gfQ0KPiANCj4gDQo+ID4gKy8qIEFkZCBQQU1UIGJhY2tpbmcgZm9yIHRoZSAyTUIgcmVn
aW9uIHN1cnJvdW5kaW5nIHRoZSBnaXZlbiBwZm4uICovDQo+ID4gK3N0YXRpYyB1NjQgdGRoX3Bo
eW1lbV9wYW10X2FkZChrdm1fcGZuX3QgcGZuLCBzdHJ1Y3QgcGFnZSAqKnBhbXRfcGFnZXMpDQo+
ID4gK3sNCj4gPiArCXN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgYXJncyA9IHsNCj4gPiArCQkucmN4
ID0gcGFtdF8ybWJfYXJnKHBmbiksDQo+ID4gKwkJLnJkeCA9IHBhZ2VfdG9fcGh5cyhwYW10X3Bh
Z2VzWzBdKSwNCj4gPiArCQkucjggPSBwYWdlX3RvX3BoeXMocGFtdF9wYWdlc1sxXSksDQo+IA0K
PiBTdXBlciBuaXQ6ICAgICAgICAgIF4gc2hvdWxkIGJlIHZlcnRpY2FsbHkgYWxpZ25lZA0KDQpB
aCwgeWVzLiBUaGlzIGlzIGEgcmVjdXJyaW5nIHN0eWxlIGNvbW1lbnQgYXQgdGhpcyBwb2ludC4g
V2lsbCBhZGFwdC4NCg0KPiANCj4gPiArCX07DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHNlYW1jYWxs
KFRESF9QSFlNRU1fUEFNVF9BREQsICZhcmdzKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArLyogUmVt
b3ZlIFBBTVQgYmFja2luZyBmb3IgdGhlIDJNQiByZWdpb24gc3Vycm91bmRpbmcgdGhlIGdpdmVu
IHBmbi4gKi8NCj4gPiArc3RhdGljIHU2NCB0ZGhfcGh5bWVtX3BhbXRfcmVtb3ZlKGt2bV9wZm5f
dCBwZm4sIHN0cnVjdCBwYWdlICoqcGFtdF9wYWdlcykNCj4gPiArew0KPiA+ICsJc3RydWN0IHRk
eF9tb2R1bGVfYXJncyBhcmdzID0gew0KPiA+ICsJCS5yY3ggPSBwYW10XzJtYl9hcmcocGZuKSwN
Cj4gPiArCX07DQo+ID4gKwl1NjQgcmV0Ow0KPiA+ICsNCj4gPiArCXJldCA9IHNlYW1jYWxsX3Jl
dChUREhfUEhZTUVNX1BBTVRfUkVNT1ZFLCAmYXJncyk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJ
CXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJLyogQ29weSBQQU1UIHBhZ2VzIG91dCBvZiB0aGUg
c3RydWN0IHBlciB0aGUgVERYIEFCSSAqLw0KPiA+ICsJcGFtdF9wYWdlc1swXSA9IHBoeXNfdG9f
cGFnZShhcmdzLnJkeCk7DQo+ID4gKwlwYW10X3BhZ2VzWzFdID0gcGh5c190b19wYWdlKGFyZ3Mu
cjgpOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsvKiBBbGxv
Y2F0ZSBQQU1UIG1lbW9yeSBmb3IgdGhlIGdpdmVuIHBhZ2UgKi8NCj4gPiArc3RhdGljIGludCB0
ZHhfcGFtdF9nZXQoa3ZtX3Bmbl90IHBmbikNCj4gPiArew0KPiA+ICsJc3RydWN0IHBhZ2UgKnBh
bXRfcGFnZXNbVERYX0RQQU1UX0VOVFJZX1BBR0VfQ05UXTsNCj4gPiArCXU2NCB0ZHhfc3RhdHVz
Ow0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlpZiAoIXRkeF9zdXBwb3J0c19keW5hbWlj
X3BhbXQoJnRkeF9zeXNpbmZvKSkNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArDQo+ID4gKwlyZXQg
PSBhbGxvY19wYW10X2FycmF5KHBhbXRfcGFnZXMpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQly
ZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCXRkeF9zdGF0dXMgPSB0ZGhfcGh5bWVtX3BhbXRfYWRk
KHBmbiwgcGFtdF9wYWdlcyk7DQo+ID4gKwlpZiAodGR4X3N0YXR1cyAhPSBURFhfU1VDQ0VTUykg
ew0KPiA+ICsJCXJldCA9IC1FSU87DQo+ID4gKwkJZ290byBvdXRfZnJlZTsNCj4gPiArCX0NCj4g
PiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArDQo+ID4gK291dF9mcmVlOg0KPiA+ICsJZnJlZV9w
YW10X2FycmF5KHBhbXRfcGFnZXMpOw0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30N
Cj4gPiArDQo+ID4gKy8qIEZyZWUgUEFNVCBtZW1vcnkgZm9yIHRoZSBnaXZlbiBwYWdlICovDQo+
ID4gK3N0YXRpYyB2b2lkIHRkeF9wYW10X3B1dChrdm1fcGZuX3QgcGZuKQ0KPiA+ICt7DQo+ID4g
KwlzdHJ1Y3QgcGFnZSAqcGFtdF9wYWdlc1tURFhfRFBBTVRfRU5UUllfUEFHRV9DTlRdID0ge307
DQo+ID4gKwl1NjQgdGR4X3N0YXR1czsNCj4gPiArDQo+ID4gKwlpZiAoIXRkeF9zdXBwb3J0c19k
eW5hbWljX3BhbXQoJnRkeF9zeXNpbmZvKSkNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiA+ICsJ
dGR4X3N0YXR1cyA9IHRkaF9waHltZW1fcGFtdF9yZW1vdmUocGZuLCBwYW10X3BhZ2VzKTsNCj4g
PiArDQo+ID4gKwkvKg0KPiA+ICsJICogRG9uJ3QgZnJlZSBwYW10X3BhZ2VzIGFzIGl0IGNvdWxk
IGhvbGQgZ2FyYmFnZSB3aGVuDQo+ID4gKwkgKiB0ZGhfcGh5bWVtX3BhbXRfcmVtb3ZlKCkgZmFp
bHMuICBEb24ndCBwYW5pYy9CVUdfT04oKSwgYXMNCj4gPiArCSAqIHRoZXJlIGlzIG5vIHJpc2sg
b2YgZGF0YSBjb3JydXB0aW9uLCBidXQgZG8geWVsbCBsb3VkbHkgYXMNCj4gPiArCSAqIGZhaWx1
cmUgaW5kaWNhdGVzIGEga2VybmVsIGJ1ZywgbWVtb3J5IGlzIGJlaW5nIGxlYWtlZCwgYW5kDQo+
ID4gKwkgKiB0aGUgZGFuZ2xpbmcgUEFNVCBlbnRyeSBtYXkgY2F1c2UgZnV0dXJlIG9wZXJhdGlv
bnMgdG8gZmFpbC4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKFdBUk5fT05fT05DRSh0ZHhfc3RhdHVz
ICE9IFREWF9TVUNDRVNTKSkNCj4gPiArCQlyZXR1cm47MA0KPiANCj4gV2hvc2UgZmF1bHQgaXMg
dGhlIGJ1ZyBoZXJlPyBQcm9iYWJseSB0aGUgVERYIG1vZHVsZT8NCg0KSW4gdGhlIGNvZGUgYXQg
dGhlIGVuZCwgaXQgaXMgdGhlIFREWCBtb2R1bGUncyBmYXVsdC4gQnV0IGluIHRoaXMgcGF0Y2gg
aXMgdGhlDQpjYWxsZXIuIFNpbmNlIHdlIGRvbid0IGhhdmUgcmVmY291bnRzLiBNb3JlIG9uIGhv
dyB0byBoYW5kbGUgdGhpcyBiZWxvdy4NCg0KPiANCj4gPiArCWZyZWVfcGFtdF9hcnJheShwYW10
X3BhZ2VzKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArLyoNCj4gPiArICogUmV0dXJuIGEgcGFnZSB0
aGF0IGNhbiBiZSBnaWZ0ZWQgdG8gdGhlIFREWC1Nb2R1bGUgZm9yIHVzZSBhcyBhDQo+ID4gImNv
bnRyb2wiDQo+ID4gKyAqIHBhZ2UsIGkuZS4gcGFnZXMgdGhhdCBhcmUgdXNlZCBmb3IgY29udHJv
bCBzdHJ1Y3R1cmVzIGZvciBhIGdpdmVuIFREWA0KPiA+ICsgKiBndWVzdCwgYW5kIHRodXMgb2J0
YWluIFREWCBwcm90ZWN0aW9ucywgaW5jbHVkaW5nIFBBTVQgdHJhY2tpbmcuDQo+ID4gKyAqLw0K
PiA+ICtzdHJ1Y3QgcGFnZSAqdGR4X2FsbG9jX2NvbnRyb2xfcGFnZSh2b2lkKQ0KPiA+ICt7DQo+
ID4gKwlzdHJ1Y3QgcGFnZSAqcGFnZTsNCj4gPiArDQo+ID4gKwlwYWdlID0gYWxsb2NfcGFnZShH
RlBfS0VSTkVMX0FDQ09VTlQpOw0KPiA+ICsJaWYgKCFwYWdlKQ0KPiA+ICsJCXJldHVybiBOVUxM
Ow0KPiA+ICsNCj4gPiArCWlmICh0ZHhfcGFtdF9nZXQocGFnZV90b19wZm4ocGFnZSkpKSB7DQo+
ID4gKwkJX19mcmVlX3BhZ2UocGFnZSk7DQo+ID4gKwkJcmV0dXJuIE5VTEw7DQo+ID4gKwl9DQo+
IA0KPiBIZXJlJ3Mgd2hlcmUgSSBzdGFydCB0byBnZXQgbG9zdC4NCj4gDQo+IFdoYXQgYXJlIHRo
ZSBydWxlcyBhcm91bmQgdGR4X3BhbXRfZ2V0KCk/IHRkeF9hbGxvY19jb250cm9sX3BhZ2UoKSBp
cw0KPiBvYnZpb3VzbHkgZm9yIG9uZSA0ayBwYWdlLiBCdXQgdGR4X3BhbXRfZ2V0KCkgZG9lcyBh
biBhbGxvY2F0aW9uIGZvciAyTUINCj4gcmVnaW9ucy4gU28gaXQgaGFzIHRvIGJlIGFibGUgdG8g
ZmFpbCB0byBhY3R1YWxseSBhZGQgUEFNVCBpbiBzb21lDQo+IGNhc2VzLCBncmFjZWZ1bGx5Lg0K
PiANCj4gUmlnaHQ/DQo+IA0KPiBIb3cgZG9lcyB0aGF0IGhhcHBlbj8NCg0KVGhpcyB1c2VkIHRv
IGJlIGNvbWJpbmVkIHdpdGggdGhlIG5leHQgcGF0Y2guIEkgdGhvdWdodCBpdCB3YXMgc3RpbGwg
YSBiaXQgYmlnDQphbmQgc3BsaXQgaXQuIEluIHRoZSBjb21iaW5lZCBwYXRjaCBpdCB3YXMgYSBm
dWxseSBmb3JtZWQgZnVuY3Rpb25hbA0KaW1wbGVtZW50YXRpb24uDQoNCkJ1dCBib3RoIHlvdSBh
bmQgU2FzaGlrbyByYWlzZWQgY29uY2VybnMgYXJvdW5kIHdoYXQgYWN0dWFsbHkgaXMgdGhlIHJ1
bGVzIGZvcg0KdGhpcy4gVGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgY29kZSBpcyBub3QgKnJlYWxs
eSogYnVpbHQgaW5jcmVtZW50YWxseSwgd2hlcmUNCmVhY2ggc3RlcCBpcyBmdW5jdGlvbmFsLiBJ
bnN0ZWFkLCBqdXN0IHRoZSBjb2RlIGlzIHNwbGl0IGJldHdlZW4gdHdvIHBhdGNoZXMuDQpOb3cg
aXQgZmVlbHMgYSBiaXQgbGF6eSBpbiByZXRyb3NwZWN0LiBTbyBJIG5lZWQgdG8gZWl0aGVyIHJl
YXJyYW5nZSB0aGlzIHNvDQp0aGF0IGVhY2ggc3RlcCBpcyBhIHJlYWwgZnVuY3Rpb24gdGhhdCBj
YW4gYmUgcmV2aWV3ZWQuIE9yIHNxdWFzaCB0aGVtIGFnYWluLg0KDQpJJ20gbGVhbmluZyB0b3dh
cmRzIHNoaWZ0aW5nIGNvZGUgYXJvdW5kIGJldHdlZW4gdGhlIHR3byBwYXRjaGVzIGFuZCBsZWF2
aW5nDQp0aGVtIHNlcGFyYXRlLiBGb3IgdGhpcyBvbmUgaXQgY2FuIGhhdmUgdGhlIFNFQU1DQUxM
cyB0aGVtc2VsdmVzIGFuZCB0aGUgZ2V0L3B1dA0KaGVscGVycy4gSSdsbCB0YWtlIHRoZSB3YXJu
aW5ncyB0byB0aGUgbmV4dCBwYXRjaCwgc28gYSBjYWxsZXIgY291bGQgdGFrZSBjYXJlDQp0aGVt
c2VsdmVzIHRvIG5vdCBjYWxsIHRoZW0gZm9yIHBhZ2VzIHdpdGhpbiB0aGUgc2FtZSBodWdlIG1h
cHBpbmcuIFRoaXMgaXMNCmZlYXNpYmxlIGlmIHRoZSBjYWxsZXIgaXMgYWxyZWFkeSBob2xkaW5n
IGEgd2hvbGUgaHVnZSBwYWdlLCBidXQgd2FudCB0byBnaXZlIGl0DQphcyA0S0IgdG8gdGhlIFRE
WCBtb2R1bGUuIFNvIGEgcmV2aWV3ZXIgY2FuIG1ha2UgbW9yZSBzZW5zZSBvZiBpdC4NCg0KVGhl
biBJJ2xsIG1vdmUgdGhlIHRkeF9hbGxvY19jb250cm9sX3BhZ2UoKSBhbmQgZnJpZW5kIHRvIHRo
ZSBuZXh0IHBhdGNoLCBhcw0KdGhlcmUgaXMgbm8gcmVhbCB3YXkgdG8gdXNlIHRob3NlIGhlbHBl
cnMgdW5sZXNzIHlvdSBvbmx5IGNhbGwgdGhlbSBvbmNlLiBVbnRpbA0KdGhlIHJlZmNvdW50cyBh
cHBlYXIuIEJ1dCBpZiB0aGV5IGNhbiBvbmx5IGJlIGNhbGxlZCBvbmNlLCB0aGVyZSBpcyBubyBw
b2ludCBmb3INCmEgaGVscGVyLg0KDQpBdCBsZWFzdCB0aGF0J3MgbXkgaWRlYS4gSSdsbCBzZWUg
aG93IGl0IGZpdHMgdG9nZXRoZXIuDQoNCj4gDQo+IEkga25vdyB0aGUgY2hhbmdlbG9nIHRyaWVk
IHRvIGhhbmQgd2F2ZSB0aGlzIGF3YXkgYSBiaXQuIEJ1dCB0aGUNCj4gY29tbWVudHMgaW4gaGVy
ZSBuZWVkIHRvIHNheSBzb21ldGhpbmcgYWJvdXQgdGR4X3BhbXRfZ2V0KCkgYmVpbmcNCj4gdW51
c2FibGUgb24gaXRzIG93bi4gVGhlIG5vcm1hbCBjb252ZW50aW9uIHdvdWxkIGJlIHRvIF9fIGl0
LCB0b28uDQo+IA0KPiA+ICsJcmV0dXJuIHBhZ2U7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJP
TF9GT1JfS1ZNKHRkeF9hbGxvY19jb250cm9sX3BhZ2UpOw0KPiA+ICsNCj4gPiArLyoNCj4gPiAr
ICogRnJlZSBhIHBhZ2UgdGhhdCB3YXMgZ2lmdGVkIHRvIHRoZSBURFgtTW9kdWxlIGZvciB1c2Ug
YXMgYSBjb250cm9sDQo+IA0KPiBOaXQgIlREWCBNb2R1bGUiIGZvciBjb25zaXN0ZW5jeS4NCg0K
T2ggeWVwLg0KDQo+IA0KPiA+ICsgKiBwYWdlLiBBZnRlciB0aGlzLCB0aGUgcGFnZSBpcyBubyBs
b25nZXIgcHJvdGVjdGVkIGJ5IFREWC4NCj4gPiArICovDQo+ID4gK3ZvaWQgdGR4X2ZyZWVfY29u
dHJvbF9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKQ0KPiA+ICt7DQo+ID4gKwlpZiAoIXBhZ2UpDQo+
ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4gPiArCXRkeF9wYW10X3B1dChwYWdlX3RvX3BmbihwYWdl
KSk7DQo+ID4gKwlfX2ZyZWVfcGFnZShwYWdlKTsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9M
X0ZPUl9LVk0odGR4X2ZyZWVfY29udHJvbF9wYWdlKTsNCj4gPiArDQo+ID4gwqB2b2lkIHRkeF9z
eXNfZGlzYWJsZSh2b2lkKQ0KPiA+IMKgew0KPiA+IMKgCXN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3Mg
YXJncyA9IHt9Ow0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4Lmgg
Yi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmgNCj4gPiBpbmRleCBiZGZkMGUxZTMzN2FjLi5h
ODg2YzU0ZGVjYWFkIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHgu
aA0KPiA+ICsrKyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguaA0KPiA+IEBAIC00OCw2ICs0
OCw4IEBADQo+ID4gwqAjZGVmaW5lIFRESF9TWVNfQ09ORklHCQkJNDUNCj4gPiDCoCNkZWZpbmUg
VERIX1NZU19TSFVURE9XTgkJNTINCj4gPiDCoCNkZWZpbmUgVERIX1NZU19VUERBVEUJCQk1Mw0K
PiA+ICsjZGVmaW5lIFRESF9QSFlNRU1fUEFNVF9BREQJCTU4DQo+ID4gKyNkZWZpbmUgVERIX1BI
WU1FTV9QQU1UX1JFTU9WRQkJNTkNCj4gPiDCoCNkZWZpbmUgVERIX1NZU19ESVNBQkxFCQkJNjkN
Cj4gPiDCoA0KPiA+IMKgLyoNCj4gDQoNCg==
