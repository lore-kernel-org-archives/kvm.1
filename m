Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4376A4A482F;
	Thu, 24 Sep 2026 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279625; cv=fail; b=i/u8OkqiDMQxRHAK1bhbL5/pcyNVNYOxGsG7nNDEiA8tCm0i2ekdvrUdSQC0D9lI67XRFHp9FMueVSQNi/QYIUWKuNufyP5w20i2i89cZ3iX4V4hkxolvZpUAXpHfOoZiL4De5g8e+9mvrPFXKkABNOLRs8lrgWns/5qTi6bSr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279625; c=relaxed/simple;
	bh=Hm+1w88sP55li+R3xeYlCdl2raVguj1Cvlx3Bw/liaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QahkH5HjzPU9wo7tkZPebScqmfqiwv3HCcPO3H2rQ3ityzwUPUKEGPv4LmzGnu83Fa7SvFW/whI8wu5aLAbliwkLkgxBV6I15r2xC5+DTbQ3ik0DzYxs78CJvXEC62vQMIn96tFE9FLANVzY2xbB2w9lRiCxCVg3W1RNyjHQlsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvmaX02E; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvmaX02E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790279623; x=1821815623;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Hm+1w88sP55li+R3xeYlCdl2raVguj1Cvlx3Bw/liaU=;
  b=QvmaX02E3XHSPBgW4etCfhjClItAV7hmhhPdgz5JWBh1gBYdZzZFIFWm
   hvspJj4NFUwo0Ddvy6sL8V3G0mF4mrMsY3gd4Zp07YtJgVFWlkLHrgfnL
   SwCtUN4Rq1KbaKDorOWaeiF8LbhTuKFax8gQC7ygm48mxQPhJzGoRpSkW
   XvgMIiebl8ZYTdHNNg+H9tVxeX6lsPkCBbZJvsbrmGIS/ab1ZNzVguamb
   F824VLTYAA80fVuML2RmYIQy6kmzh1BRnTB966YnYgFkImrLWybDnKtwc
   t3minzooKJ9p72lMCULDxGP41HuWaam5adGOt3X6DHICQKtFW+PhA6ahu
   Q==;
X-CSE-ConnectionGUID: MjkeZMeRS4yKG9FjN60K9Q==
X-CSE-MsgGUID: Qqj1pkohTBivQfd+3q6C2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="102425415"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="102425415"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 12:53:42 -0700
X-CSE-ConnectionGUID: 9xfIrpIrT2yK7pBdxviCGQ==
X-CSE-MsgGUID: j62/SPtwTvSXy695aOgQ7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="312039865"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 12:53:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 12:53:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 12:53:40 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 12:53:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBh32inxfgRhYJB20dcBEv+vvojjDyN/ijCs/rpuBCNpEBJUSjvGq0+vY8o2kGt1DVlcB25wMFAOY1roaGOxdrLvrekL660mzuo3zerXx0Yyh1lnIkiYY2iBzCCKZX3g0kzFQkX9qNOWLzPgc+8oFgmLZMbrQBypfyibqe0cFMZKBCU/obb/d6L9dglkGFuYWap8lzpmKV4sdLpy2nJGMKTgxl3/Xm38ZBJMagEPezyNOiJ5DLjFFCPsdaXfi9pi9IkfiN5G7/4hEF2oBNzteRpXpltskHMkwqq6OdzIXlcaXASdpmugSYkNk8bftxbuCMF6zkPFc8q+z1mvLi6k2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hm+1w88sP55li+R3xeYlCdl2raVguj1Cvlx3Bw/liaU=;
 b=qimBzW1BeqmM90vRz+xanBWApreBANKrdprusbV+EZEYFtxjDKcY0xOMySChw9Hq6N3ptNyDDAqWVoSxvFi/gdrrR28Zm+rmgyDnbH4rJ/mAE7v1ykiJQNEXF2VUNVzvPsE28BfxYeSjLwCItbXZBfzsX/KSLWhJ8cULylyDge5dO42HdCe2hLysMUjaG4P5EL4+ANVUfjLbQlynwxw50Awcj+fGZMCzkV0aF/G28aRvjdSP4XDTUSZBUDVKRGih5eWrMmSj3Bh1W31p2glKEPCzgrYK5ir7+V8kkckYLolNuN9R+7PY6r65iBawa4PxS9qcr/8OBsqomSopiXcg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH3PPFF8B8D6872.namprd11.prod.outlook.com (2603:10b6:518:1::d61) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:53:37 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 19:53:37 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "tglx@kernel.org" <tglx@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"kas@kernel.org" <kas@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH v2 02/10] x86/virt/tdx: Convert the version metadata
 reader
Thread-Topic: [RFC PATCH v2 02/10] x86/virt/tdx: Convert the version metadata
 reader
Thread-Index: AQHdR3IW9Vo4ecSFX0OAytf8FV4/R7bcxk+AgAB754CAAOurAA==
Date: Thu, 24 Sep 2026 19:53:37 +0000
Message-ID: <bbae95eb8f510aef404741b56779aff72a3e5439.camel@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
	 <20260918132946.76533-3-chao.gao@intel.com>
	 <390fc4d56769f87d91949e900262640b52b505b7.camel@intel.com>
	 <arS6D6KoPbqVBtPl@intel.com>
In-Reply-To: <arS6D6KoPbqVBtPl@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH3PPFF8B8D6872:EE_
x-ms-office365-filtering-correlation-id: 1448ecb2-b911-4357-06f8-08df1a75861d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|38070700021|6133799003|10067099003|11063799006|5023799004|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: v2oO4iF0zAa5LgcODk8awslqFJqK2XAHyDJD9x4C8T2G/Y1wVwJ6S9g25ggUROM9jaQe4U7O+iu7PROUVHMGA3m3QSTfjvfcHl0e1lk5H5Hz2UpEGZsYmg1UFxYT5P0EoQM777QfZueRAYFP+zCrlNnSzEVgGGEphc8/1vB2Noh4pdEI3kAD92KrKNwMQlXdV91LVrxTR1rvexsjBxol/KEZFRnWTlVYzFyYGBMS4xZUyTSywsplJHohwXCwRWyvKE+aRg29oEiK3jk3pfVidFItC5lRQP6Ny3fQGr16eOrE2wOjNuEhPoewa1WTGQmWihG/IvKAND/SEDxAWcXjIfwc3M1i8HxEKtpFhhTfJGzDx9aPZBdj8lp1MObYeW2DDI+sc7hMELYSiH6QHA+NAE5IinWX0XF3nHwpEpOwnRoFzkAIaDdee8no9/eba+hbnCYS6j9k0WUMJoKQxy+Hn0mmZGSiTRi4bk6fsVaByjigk40cxbYsSS5NhINeVBGhklJqVjLlMqemj2k2kHGplSwG++eKEDiRKA4vPDFgQdl/7BcLoSNg60cBN+bWPZaGa+VybgtnYGD8uOZRpBdzX1tMskcP1wRR8x1JZJOMpuCpoRjeKiygOHhf0KYL8llS/gMUuSPZt9DUvUVx9pcrXydVeDjfZbNmDXHuHylImyNsA9Cgj3tR2BjMwFinhwH04Ev1asPh7lJnDdDrWgv5HZNuBtWbQ+voMmz8CFlC3Eg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(38070700021)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFNHL2NLZ3dvazdOeWhTRXBac0NRV3gxM2JvVmtvY3lrM05GM1hEOStBREdH?=
 =?utf-8?B?Yk5ZbXI0RHMxRm1OTkcwRStKVXBwZXhXZjhoSVYxRUdORnAyVEJWeUJodWVn?=
 =?utf-8?B?WEtraDFpbXFRY0g4eXVKUnBWUE8vRTNleGFmc3RmSVNyelRSTEM4KzZWWGZx?=
 =?utf-8?B?UHdBUVI3SVZrdmJkejRrZkxtZ3dodFplUURwTHBKdllvdm5NNnhQcWpUaUVi?=
 =?utf-8?B?Sm5IYkNzUUdmbTV0K1FncXhqc0ZaeHE3K2FuaEZmQlp3QU1jSmVXNVdYQWUz?=
 =?utf-8?B?amJXWXQ4TE9kMXpMd3IyYzJFcjZiS05IWXBmUkVjZWZPaEJaaS9WTDFWSC9N?=
 =?utf-8?B?M2FadHU3cllFY3pOM2tocnlDcU01NDlYU0ZUUmRYM1ZqelEwbThsTmZRaWF1?=
 =?utf-8?B?ZXVYcGhVUUE0S0pDMTgrRVFkMkVYKzZuOFB1Rk0zcHlHYjV2TXVsM0RlY014?=
 =?utf-8?B?NTNHOE4rbzR2M251ZzRvemlTaWxiaC9YUHdVS05GdkFJZldDTHUrMXFqVUMr?=
 =?utf-8?B?UG9lZDBWZWZtUjdjZEFnQS94NkZsaS9oT1hTZVJSNjhRbHlzenFuaUZvZk4y?=
 =?utf-8?B?TytjbE5RK1o4NmJzMHVpR3VVeWFuUnJsZGZtN3k1ZjBHdG1TUDUxT2p6NFZy?=
 =?utf-8?B?RFA3R3Z4bWpqTXptNllSb1FyZ0poZ2xqOWVLNkF1RDFEeDFpY05tdTQ0S0N4?=
 =?utf-8?B?LzZtak8vNzhtZTFIUzk3UllKUHk1NFgwRFNwM1d2T1o5UVgxSDhlQUFSQSsz?=
 =?utf-8?B?MWNkeUV3QTBPeFVDc2twdHlOMGJGWHFkMlg1UXFOU1dSekNTbURadE9oTkNu?=
 =?utf-8?B?YUJmV3RZR0tRQmpXUlJuWGorWTdlYXpxVFU2Y0lFc0lWalRlUjRMZjBaQllq?=
 =?utf-8?B?dzNod2U5Uy9FTjFqQ3kzZDRVUGRyMnZxcDJRRzBGT1BSOEFMaXF6dm9uOFZz?=
 =?utf-8?B?Y1gwa24yNUJLejZubkRNaWdPQUJqVXVqTWtYdDI0ZUZ3TW0yYjIzRjlRTGR5?=
 =?utf-8?B?Z0FIcnBFaG5FbDFLS2NOQlF6NXRTZmVBOVBLWHA3dE1QNGZSTzViblg5U1NM?=
 =?utf-8?B?VWZxUUlRK2x1ZEMxZnExaVZsd0p5LzhmazBFT05BaTJIamVoY2kvZE5EKzBi?=
 =?utf-8?B?cndqM3BFaEJTNURFY1Nqd3dzUG9MYjNwbUZvTUVPT3k4amtGSGtCQU5MSisz?=
 =?utf-8?B?UVdwVCtSa0oyOEdVeE91UDBONERpd1JVcnVMMFZJdXlZR201bXVDRkl1TTBF?=
 =?utf-8?B?VUhMVlRhTUJUV2V0L012Tk5DZTlnQnlndUNaQVpicExRZ0RpeWdZa01HdmxT?=
 =?utf-8?B?OGNrTWpyT3FSM2R6K1ZrK0pFeWRHZ3BoeGYxNEYzMzg3eDdLUmhjWVlqcDdX?=
 =?utf-8?B?Z1Y3UjBUci9qNWlrRjBiRGlrMCtlUW9TMHN3Y1hONkhXQlRwM0hEaVhYSzBi?=
 =?utf-8?B?c0RIQjgrWDVWTmR1VnIzbWxtZmF6SDhFTFFCWnl1K2cyd1Blc2xzY2VBYStP?=
 =?utf-8?B?aCtZWnFSUEh2V0xjUnp4alUzUUNZbUNlQkl0MnEzUlU2clh2N3A3R0p6S2NV?=
 =?utf-8?B?emg4K1ZzRFNVdGtEcEFiSlIvTGhSL3BkZlNvNXFMR2QrWmp5MWk3QjhrNlBj?=
 =?utf-8?B?cWQwL0x4YWVDUTgvNXpsTExudlN5S0NlZUNmZnZ1THMvYytob3kzSVJVNkR4?=
 =?utf-8?B?YUlzQlMwQmhEMjJ1RjU5akttU0NNaUk4VitYZHY0UFZlUU5udG8waXZlbSs1?=
 =?utf-8?B?dmtSc0RNa1RPdXdpOHBmdlFlRkZvaE93emZsNEZxT0luZVpoeGlrYXpRZ1VL?=
 =?utf-8?B?VE9pVjUzUUw4NHVGOVltazFOeGZFMnRwS0xwcE5PNDNzK1lLVVA2REJHTXRF?=
 =?utf-8?B?aTY5a05VNGxGVDVYdkQ1dUUxOHh6Wm9MaG5hQWpYMUJSeFhucWt1OHpoV2lK?=
 =?utf-8?B?YWlnd1FhNzRKL05LTWg5ZEVJSDBZT3JJNkFZdTRYTE5hRU5XYWJNemdRK3Yx?=
 =?utf-8?B?T3hVTzhsdmlaNXNMSFEyUmR6aVhhejJKZlpqbTF2ZGNQVTB6NGVaN0cwb2VW?=
 =?utf-8?B?QjBTZXZVVkRldnl3SGR1N3Z4bkQzMTdEMU1tUFY1S3lGK2poWm5kRFZZU05J?=
 =?utf-8?B?WGIzL0p3KzBNVEJZNHFscnZNY29IaGt1SFp4SXd4TWN1VEZ1SVN4SGluOFNS?=
 =?utf-8?B?emdxbnpyMlQ5b2dtTW1NVU5aT2dVZkFITU1TaE9qRTc1RExycjF4UmhzcHRi?=
 =?utf-8?B?QmNiVi8wVGg3YmJEbFgvcG5uWmpYNlY4aVdabFJaNUZYVGcrdzVkTkNWdzhQ?=
 =?utf-8?B?Mzh2UHo2U0pvZC90dkl3TERSZGpzd21wVHZZOXRjR2tyL2xDOUxpNHRZSTRn?=
 =?utf-8?Q?AREItNa9IlIQvy8Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D652BFEB75087C4E88615AE455628302@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BE4oqPKu0r72sR05IcTNoJx5F3hnsUZF/tqy/Zsm2BmF7nEkhgdcX4LQiyFIYNQ8GDZHlZPPbuj/BdpQiq+mUSAjB5hjVeTGQ+ishFjuipuBmIppjWuTY0oieqNXAWVW4c70cpP1MCwmJxNHMHV8hwqaZFgtQY+6Mwgq5YpGzIE3wKnsDU2/Xc8M905aSdjTEnlhs2i3uUhURTxlQMV51d8ejstPKd4pfU/NZ6mtN/HKBWn9Kcp5B+AFQ11ibj4KyJnD7f9ds0ZT21eBBfrrFcoa4KbKLTzlOXflh6jorEMZIGwRiHRqCX2lnkrGe2oHv9MqpJiLbTWcuWmWfwlRLw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1448ecb2-b911-4357-06f8-08df1a75861d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 19:53:37.3181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9mlAA3IiG8mLn/uo2AC2Icxqu3AN+PQnrM4QC1iW/zr13Iq2CRKu8yCqneIpapQHNNNuI58qwNa1uuzwiEZnbXYrQ2IBnknWVJQcl4qSiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF8B8D6872
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTI0IGF0IDEzOjUwICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiA+
ICsjZGVmaW5lIHJlYWRfc3lzX21ldGFkYXRhX3RhYmxlKF90YWJsZSwgX2RhdGEpIFwNCj4gPiA+
ICsJX19yZWFkX3N5c19tZXRhZGF0YV90YWJsZShfdGFibGUsIEFSUkFZX1NJWkUoX3RhYmxlKSwg
X2RhdGEpDQo+ID4gDQo+ID4gU2hvdWxkIHRoaXMgZ28gaW4gdGhlIHByZXZpb3VzIHBhdGNoPw0K
PiANCj4gSSBkaWRuJ3QgcHV0IGl0IHRoZXJlIGJlY2F1c2UgdGhlIHByZXZpb3VzIHBhdGNoIGRv
ZXNuJ3Qgc3RyaWN0bHkgbmVlZA0KPiBpdDsgdGhpcyBwYXRjaCBpcyB0aGUgZmlyc3QgdXNlci4N
Cg0KV2VsbCB0aGUgZnVuY3Rpb25zIGluIHRoZSBwcmV2aW91cyBwYXRjaCBkb2Vzbid0IGhhdmUg
YW55IGNhbGxlcnMgZWl0aGVyLi4uDQoNCj4gDQo+IEFkZGluZyB0aGUgbWFjcm8gaW4gdGhlIHBy
ZXZpb3VzIHBhdGNoIHdoaWxlIHN0aWxsIHRhZ2dpbmcNCj4gX19yZWFkX3N5c19tZXRhZGF0YV90
YWJsZSgpIF9fbWF5YmVfdW51c2VkIGxvb2tzIGEgYml0IG9kZDoNCj4gdGhlIG1hY3JvIHJlZmVy
ZW5jZXMgdGhlIGZ1bmN0aW9uLCB5ZXQgbm90aGluZyB1c2VzIGVpdGhlciBvZiB0aGVtLg0KDQpF
aGguDQoNCj4gDQo+IFRoYXQgc2FpZCwgSSBjYW4gbW92ZSBpdCBpZiB0aGUgb2RkbmVzcyBkb2Vz
bid0IGJvdGhlciB5b3UuDQoNCkknZCBtb3ZlIGl0IGJlY2F1c2UgaXQgc2VlbXMgaW5jb25zaXN0
ZW50IHRvIHB1dCBpdCBoZXJlLg0K
