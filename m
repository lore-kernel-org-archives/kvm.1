Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961754657F4;
	Tue, 31 Mar 2026 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993586; cv=fail; b=p/TfyCiNV4hHGKa+LIk4nFWVIYzFGVhFcrEtbXvKojdXxDgLtNYOZo4LcO9zLHsiazVHQAXaj/PiRpElQ6nodCH9+1NbXtszrjoJ1eO01wU1xrMvo5An+4wJb6oaXhmeZOXQsmc5RyZydb2ocr92AiQFLsqLgXnVg0xOkj3pl+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993586; c=relaxed/simple;
	bh=/kVg/BhYFjT+9cgFePTRGpiBw3ePkiGeVs1ZvTq7uE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=skRKH0xh6qQCiKvqlDczAdKvBTTw249DTPie5zvvZudIssq0RkvKNH1NYn3rPIxgrdEjfidVwsasBi7mdKajIAxYLz1+Q4odjHvtFxSxERAgkJ34tTOj5Czut7Jtv2RLOj9El87xH7H586y37Itj4Sj9RSn3WxcYchON6EZ3f3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiqIbps1; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiqIbps1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774993585; x=1806529585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/kVg/BhYFjT+9cgFePTRGpiBw3ePkiGeVs1ZvTq7uE8=;
  b=WiqIbps1PEsQZLOWAhRhZDOG88MgluE/rn17k8XOasu0HjK2AKzLMHeO
   hE4VgiLbHcse951sfTXcvqbd7VxNSQIvaRhfkL4JnLH94oC+doY6QzuAl
   PMugTZq5eXO1remklJP+52U+Woz+iS5WD+hCMzuHUbZbmUOtoebfOU6Y8
   wfekQXxvANwFeamhgnSvL2u9Am6Z2S9lP8A46p/i2iG1SfPVyroHaXgZj
   Re2K2rq1SEkyhka17VbzWIEsMmPWmgzvs1NHxUzxUrb2yi0VWqBiPOkvK
   JRq7jS4SX0iQ80p78rx0O5s9flhlTueaw3GDgY/mEfD1WXBy4T4SaCuuc
   A==;
X-CSE-ConnectionGUID: NCbIglDzSvew1pwsaJCA/g==
X-CSE-MsgGUID: uOekZ8dHQBaf0mZhvUmQGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86324955"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="86324955"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:46:19 -0700
X-CSE-ConnectionGUID: ouOi2C9tTxush1HBfyKEHg==
X-CSE-MsgGUID: e1/56p1VRje/l75hSDcjpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="264413406"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:46:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 14:46:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 14:46:18 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.23)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 14:46:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZBQkg6PfVHRgTg6yCI3lgC1wBeqdBLMq3vd9ulTdmYCz5QpJyok5oepUkuDg478QRUb+3N4DZML090a8H9VN0UxtEhGhzg2eD0AHlY6HMAxR8W0C8WIEu87wtfhpT1t6hB2LDRIzFZczWgBZDedGmVdsW7YIWe3Kvg0um1+wOnwy7DXlMzb3Pvi00LyJjSudnm1BpwGTBvQ9wPCt7NEaiwIaAMJndNdnPTUzTEZY0ogDy6e5PW4G6GaO6AMJ1el8INxBM7SvxGiBUF5YnTx45rGlblWcGVED4x+LzUM7ryYNujha112sHgsRdZclZLKfiloKk8SdS3xer+DY4JXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kVg/BhYFjT+9cgFePTRGpiBw3ePkiGeVs1ZvTq7uE8=;
 b=WxeVsxS7m7VkVDMusjcaGSvT1CAFoAXbUyuNQa7HbyT/G/bkoJeg2A1x6Hrle8Gm8y2t4g4qNiuiZMOUjX/A2ffpbgl+cPVjWsy+G8B1MEVoquLfUjbctGFjOYug32m8NBLpcLjGgS3krLfDSMoF7sb0F/xLJ0bVtl/1vqtlncTja3u6XeeKa6HwlzZM8tN3ZMOTl7rCQNhy44l63aZAuGgKHJ82QMQapp8mXurq/2hSjRvf7eFBoq3lsTo1xS512pa4MZODzh6dQdI0/fcn+xwmculMajarDdOBnp/LoLlsnakdhGjo7oKuink+TVfapv+5i9euqyEJvYb0bomgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13)
 by IA0PR11MB8304.namprd11.prod.outlook.com (2603:10b6:208:48b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 21:46:14 +0000
Received: from LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::893d:78de:7a85:7c8c]) by LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::893d:78de:7a85:7c8c%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 21:46:14 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] x86/tdx: Move all TDX error defines into
 <asm/shared/tdx_errno.h>
Thread-Topic: [PATCH v2 1/5] x86/tdx: Move all TDX error defines into
 <asm/shared/tdx_errno.h>
Thread-Index: AQHcuwfykctwToI5YEmNtfk4P89Wv7XJE3wAgAAmCoA=
Date: Tue, 31 Mar 2026 21:46:13 +0000
Message-ID: <cc7b3bc5987cc2b29f21d931aa93995348da5028.camel@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
	 <20260323-fuller_tdx_kexec_support-v2-1-87a36409e051@intel.com>
	 <acwgvBzK01IrAAeU@google.com>
In-Reply-To: <acwgvBzK01IrAAeU@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB5976:EE_|IA0PR11MB8304:EE_
x-ms-office365-filtering-correlation-id: 77af568c-fac3-4158-490a-08de8f6eee50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: YQzHOj2rqk24IUWQ8dNAfiqnp+g3EZgSAM4q4TrnQW8znXqcTXm9+gt33sw+WNjfmM58iZBELUFE+fHddNLU2yCVRqjsH7fCDGksgJwGHpTQ9axaYdicDDInV2Z56dFasiiiuTNOCykLYhmRGBUEKjOEO93sQs7AIZt77FHynyMzSwBay4r3cIkwH/7c/1zY8nlMigBzMjVOh31LsPSEk+FtupX89/i1FD+FhtlkQZc2IZvge3Mi/wfeNcnasb7FC/Y0nndv6mEFAcLCEi2NIsEfn82nbFo72lij2Zh8CU2p8YHXyIlMEGbKUoZ+a45jl888+kZPJ0HabKcGS6570O9nTGHZyPJuN94mey1zjdsJZ8eVgDKRX1m3tM2OkpslSNbnQRjOQWD87nADQc1GUYQnjel1BINrq/U/ttciWcM/Zg8ziC9Y0aW+VsflT0pQhbBqO9MOHnRPHXneFRoVqpHlNuslTb6uCOofbSjlpj0BVaBtwQzwn/iQb4Pf4j43o4lItH7NiCf1BrXwP/bVU5QJbmKjcL2fQCITDfwSkpN9JmtH5stRcN0mjf+xSo19ZWvmSJJAEDfNhhR7/nUwUF1LQcPE3TFAVe31WZwGqTQ93XzMPcIKVH+3GehBrimzYiLcHvnXev/eyTNzWFYosLrYWLdGPNz1c7x8nt96w7PHck89OKxy4ywo/PF/I38swZmzT51BtAJy3Qwyt9Ve8DWaJJnb5JiDRsBEWh7UC72HuA4m3bVsYdwopBpLY3Sru099Qrwll60rNe8qIPJFPiOjFbKJxd9KhkD8Nq472Do=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB5976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkF1OFIwVG9wNjF5dGR2RENqK2ljWEsvQTdkdmZkMHJwYmp3ZEdBRGN5Y2Rn?=
 =?utf-8?B?QzRKUWUyekFZRmdVY1VYOEYwZ3JoSFlwZkZGanVZN0VSMjJQWTNwZ21VT2RY?=
 =?utf-8?B?R201eUd5TXRFTVZic1RWSUhOYkIvN3pTTWJxRmJjaXJkbjVVdUxxZS9XRjRy?=
 =?utf-8?B?OWRzOVZlemNEMjBuS3RNR2ZMRzZsbUVEMjZJV2U5N1pRakFKWDZ6NWdzMk9W?=
 =?utf-8?B?WTRvZkk5SXkvc1B3L0dmdTZTSWxjUzBYVFozMHpzUU5Ed1BrOCtURC9hWlky?=
 =?utf-8?B?NTdQbCtRQXJOenhLb2t0QjhuSWlUL3BvOG9uZW04UTU4UWg0UmlRWE81Q1F2?=
 =?utf-8?B?MHBYUHdtZ0VXODEyT0JnYXdmcVlmTmZMNHRRVzhlbC84MjNPUEJNM0E1NGNB?=
 =?utf-8?B?OWhSMm0vU09VVkJXSGthZWJwaWFsdjhJUzdBSEtGd3d5Yyt3emxOM051Y0hO?=
 =?utf-8?B?dkJzRnBNaS9XMEdMNUYrZVV0MnVIOWtCUjNQdlFHcW1yWm5ERGVYbFpvcjFV?=
 =?utf-8?B?MHREMFRlbitMd1cvNVVscTRBVEZ4eDU4VUFNVmx6akZDQkVRaGt5SFZkYlFi?=
 =?utf-8?B?UmVOTEZaQlZGM25NMjhnZDVmSVQzQ2JPRjBkUXVjbjdhc21Da3VVU1lFaTFX?=
 =?utf-8?B?aDVEbksxcHZaRXpNS0l2OVdLbHhqb3NwRVc5T1BKTEppQ0pyQlhBMnBRam8r?=
 =?utf-8?B?V2p1d25oUHM0Q2dETG15KzBYOUI3V0xlS1l5TGhSZkpPeUEvL3Q1TDI0SEZN?=
 =?utf-8?B?Mk5CNVc3QmdBQXA3MHZHdnAyK0NSSHNuOHZ0anlyeDBaQ3VUL2UvUy9kTDVv?=
 =?utf-8?B?enQ5em1tNitXNktGSW1GM3NvNkZsL3R1TUtVd212S0ZYVVlXd28xUC9sbVFD?=
 =?utf-8?B?TWlFbG5PNGFrT2hjZDRDd053M3d4SnRqb1p4V0xoYkJhR1hhcUhRbTJwZlk2?=
 =?utf-8?B?Z0p4ODgwaTJMR1BldUpZV0doQXN1QUZlNkhpMjVINzdMWUx6dFRFdWtFR1N3?=
 =?utf-8?B?dTBWU0RiTSsyVmx4Ukt6aFg0VEo4a2lKanlHdm5aWDkvTkZQdjRuMCsvUFd6?=
 =?utf-8?B?RHJuVlpCREpULzN2d1hsalRJOThFYTdjM05jaDk4ZG80cTU4VnBlQWFscERB?=
 =?utf-8?B?TEprTTVKelQ2SDJ2cEFGaXJnWDFJNk9kWWY1ekNmRExiMGtETTFNSWdmR1hO?=
 =?utf-8?B?UmJmaDBZa1BLREw2WG1YWDAvbUp6Y3lNZDA2WXp1c0gyOGNsRVNHc1o3Ung2?=
 =?utf-8?B?N29uMThGTW9FVVVFYU5DNXUzNHU0cTlCSHA4cTBCQUpWT0x3Vk5iWmhZS0xH?=
 =?utf-8?B?YnBBci91b0pxQXorSFY2MUZ2RFBvT2llak1KZ0RHdmY5SVFlaktnU0xSWFVu?=
 =?utf-8?B?VGVlQzBiUmdUMmZwMlNKcmZmMks2dGR2dUlac2xneE9yaWQ2ZVFjYXpKckp4?=
 =?utf-8?B?Vkk0STNUV3plVWlPUnVpUDlkS3pyNnBaRk1VRHhuRHMrTm90ZHFZclVEV3Q0?=
 =?utf-8?B?a09YT0RYR21WQStNYkUraDc3MTV1a2JYTUNTejVTY3B0eFJsU2g5YytENEYz?=
 =?utf-8?B?aHFDVlRUZGx5eXV4Q3Fac084TkVKVFl3L29JUUhycnZsWXFJK1dibm1NRDZ3?=
 =?utf-8?B?SlRESVAvYm9NUVhFallFU0pyUHV6Um9EOXZIRWZid2dXU0h4eWUxeE5TUTE4?=
 =?utf-8?B?ZDlMdzl6Q0R1TlFtU0xybWk0ME5wY3JIRzQ4UjcrSFJBTi9JRmVNTnR0WDVW?=
 =?utf-8?B?ek52M21BZlpQakd5MTNXS2loM3BWdmdJam41SkhiN1NrWU9ud1JyYVNRZGNw?=
 =?utf-8?B?WVIrWTdhZzdSTEdhZ1VKNkZqb2dvNjRzY3N4ZmVVV1pKMFMxckYyeFdIazEz?=
 =?utf-8?B?Vm5wamhSbWlaZE1YeUFqUXRJWThhYW9iOHowL0FKUnBqRmdEYXdYdCtZRzY3?=
 =?utf-8?B?MzVzZmNrRkJtM1FOVkp4NVRKYjJxMG1rNkk0ZnBiMit3SEcvay9zYytXYU5x?=
 =?utf-8?B?UFFMTzRrWDRKU2RwQmE4OHE4SFBFblJNZzZ4Skc1YVlXR1daQmdmOWphUTYx?=
 =?utf-8?B?QUUveHE2b3lYTkgzcUc1K3NncFZLWno1SVNmYmw1UVNHdnYxQUtvNG42UnBE?=
 =?utf-8?B?WE1DWkpENE5RWFpGVUFITkExTFEvWjFYYjJTYkZKYWIzNXVaVzg1WThjNTV2?=
 =?utf-8?B?M005V0hUNm42WGcvbHNzNCtmUFpZRzlOalNZMWNNQnJ2MDBvOTVHOHdQMUo4?=
 =?utf-8?B?Z0FEKzRtS21EN0N0bWx3dEFNVVhjdHlMTlpLaFZpWGFML3hCSWVNeDIxSnBN?=
 =?utf-8?B?WVhEMUhNWmpKVFVjQ3kzZUs5MHFEeThHNWVLK0FrWmgzQk5nQ0VSK0JFdWY0?=
 =?utf-8?Q?5hSTmOwJwobmo51E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B45618A9E435C94C9D60CFC8ED04A94C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QKDuo3/ybn+NkdIkAKM5Gp2wdYVND1NI/yUsi6V0zIOdpAqfArQdECr7iipxmx2LQerbwM40OAQY7LwnYXuEQslfZkpkcngH6EzBc+o2niR6iQ1zt53pKWU2F1k4GtS+/Hv8v7i8EnMtqhFQaFquxjgQ2EzA1B2k0fUDkPchafjABzry+Vd1f4qnk9fppwG8Z5rdrUCScD9z6JDqhii2nqRx5F3wQ4aO3h2jOHLEREVfDXPMf3mWahbaZWEEGfdDcOLFUbKXxnC9PrCSXdNPpbG5upNAMoIMxhW43xBYausgdbeUmr3q3ioBViKJkaYp8xgW5jX5kCRPtgoR40wsLg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB5976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77af568c-fac3-4158-490a-08de8f6eee50
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 21:46:13.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhh0l+QAQa+4vV9+DZSIjVaEN9ikOT7E/Jcrn/wG8nzpBee82MjPZdL9eThy1JDitX4p0c85F7/Q0C8y/0JZWl99lGLW8RaAIR3ZlzVWq9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8304
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDEyOjMwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiAgKyNkZWZpbmUgVERYX1NXX0VSUk9SCQkJKFREWF9FUlJPUiB8IEdFTk1BU0tfVUxM
KDQ3LCA0MCkpDQo+ID4gKyNkZWZpbmUgVERYX1NFQU1DQUxMX1ZNRkFJTElOVkFMSUQJKFREWF9T
V19FUlJPUiB8IF9VTEwoMHhGRkZGMDAwMCkpDQo+ID4gKw0KPiA+ICsjZGVmaW5lIFREWF9TRUFN
Q0FMTF9HUAkJCShURFhfU1dfRVJST1IgfCBYODZfVFJBUF9HUCkNCj4gPiArI2RlZmluZSBURFhf
U0VBTUNBTExfVUQJCQkoVERYX1NXX0VSUk9SIHwgWDg2X1RSQVBfVUQpDQo+IA0KPiBJIGRvbid0
IHRoaW5rIHRoZSBob3N0J3MgU1ctZGVmaW5lZCBlcnJvciBjb2RlcyBzaG91bGQgYmUgdXNlZCBi
eSB0aGUgZ3Vlc3QuwqAgVGhlDQo+IGd1ZXN0IGNhbid0IGV2ZW4gbWFrZSBTRUFNQ0FMTHMuwqAg
U28gdW5sZXNzIEknbSBtaXN1bmRlcnN0YW5kaW5nIHRoZSBwdXJwb3NlLCBJDQo+IGRvbid0IHRo
aW5rIGl0IG1ha2VzIHNlbnNlIHRvIG1vdmUgdGhlc2UgaW50byB0ZHhfZXJybm8uaC4NCg0KU2Vl
bXMgcmVhc29uYWJsZS4NCg0KPiANCj4gUmVnYXJkbGVzcywgcGxlYXNlIHNwbGl0IHRoaXMgdXAg
aW50byB0d28gcGF0Y2hlczoNCj4gDQo+IMKgMS4gTW92ZSB0ZHhfZXJybm8uaA0KPiDCoDIuIExh
bmQgbW9yZSAjZGVmaW5lcyBpbiB0ZHhfZXJybm8uaA0KPiANCj4gQmVjYXVzZSBJSVVDLCB0ZHhf
ZXJybm8uaCBob2xkcyAqb25seSogYXJjaGl0ZWN0dXJhbGx5IGRlZmluZWQgdmFsdWVzLCB3aGlj
aCBtYWtlcw0KPiAoMSkgc3VwZXIgZHVwZXIgdHJpdmlhbCB0byByZXZpZXcgYW5kIGFjay4NCg0K
VGhhbmtzIQ0K
