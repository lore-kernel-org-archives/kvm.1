Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A96F2F2;
	Fri, 13 Mar 2026 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404264; cv=fail; b=e47vF7mXjMWBwtdJXXqL9fTZSDbcC0p3DLDsuMTheYDKoE4S6XHvDdh/xalbZQ9Ca4IlGuLJieNG/TdlZwHtWpOMv1IGva4bQsEPUW71NX8AlqvkRwLMXXFM7Hl+O+MlvkuoJftvZOJj1iJ0qD4S8qUvAsyllgXKxHbndz26R5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404264; c=relaxed/simple;
	bh=YI/bz6sf8ldSfBBQEBEWeTkUJZqi4hwGn8riLR8Csdc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n12pjGYA0IqFdfsbrcLwWrKNTcH/sU1gAob/8FCaL45pUu0V1FcFiFFIxwKfESncBGn82nWf20xd2s28FkpaMdCoavv4xq+907Yvk3fMvvr9F/QNvFYC7Kk5kwfvu1QpGOtlQD3d1p70MJNsPUCsejhpgETiEKRDyhLp+BuKS1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyHuywUZ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyHuywUZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773404264; x=1804940264;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YI/bz6sf8ldSfBBQEBEWeTkUJZqi4hwGn8riLR8Csdc=;
  b=EyHuywUZeHeMx7pc1j/puMpmgBxVIEI/5FMlO3LrYsByZovt9ibK0dTt
   IPiBd7bzQN1RIb3U9wAEik+wGLydbr/8V850AsyBgMfXNPBDERUpJ1z/M
   glCAqbIIOed3IoCIl9g4PqsCv/qCvZvi0en5zW8Au6aDHMaNbmmx+81sY
   HOHPf5WffHQBmMH+YgBL4YcZAkhO1D5d73+Zepy26SLd2XoXzIpYuphFK
   xhVFBFifCkz5T/veSGqBsAMKn6Uxs3eItpQGD3L/E/KgH1BplymRyXKVt
   8tPO1hD6Gys90KtdlR0rSPBqbuJRTN7mGcmM1XecDHQzQ2Dpi2RSzzh+K
   Q==;
X-CSE-ConnectionGUID: Soa7L3yQRJmY1D+bfCF5cQ==
X-CSE-MsgGUID: 1MSE1o4LQBSX6FUueKSZRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="91891502"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="91891502"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 05:17:43 -0700
X-CSE-ConnectionGUID: E0v8f8eWSe2eiIAvNFYf1g==
X-CSE-MsgGUID: /v64OwdzQgmIm0mPfysEuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="221092902"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 05:17:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 05:17:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 05:17:42 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 05:17:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhmBXvCf899CUipSJJf+3j9ORkv1YBfzQV/FxYwTJd4Thg0YhdQupcT9ByWssaAjnya+WszjHeQ3ITq7RmsFtoHaKnjoAGTAabOd/w1dc7MVFFS+sdn2BwUJzL+9r+pzeRqJPu1L6UhHcHeoQVsZ9gJINyc5hdzBTk0Q90yAdb3gHQMKarnhZ6seUC8SJPDVSVZIhMOKwLWgDrcLg4DxWglx4umqaPBUk6QgHcVOQBFLMBsNKrFLPskqvA1R5Vnjcuymvhuqscqg4O+msNNUZUkyy9Zo6dYSqgBIFwevLhnzI0thmoZk7WBid7AqloePOXZyHFGb+UnD04Ztc4sa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I07xdFUzh+tHd0N2L/3w5DwFTUTulSqcZHRydAmCxac=;
 b=AY9aVZSIxWq64+ke6DR2mYKalAk8aHoS+59LndVZaWOFjuKKnqlSBUYKl/78kPreLV3D5S8gNkhNwXHt8ncVnX7DQWz6odVLg8nrgJfrDmmfNPigmFPP7EIgN/Pca5JQyUxPJnNyH789SujgA6jM3B73MYooLIpEmyDc/dm+FxW9mD6vRC8YOYpWVjc52qo+fXYrwPoqFqTLo9WtBDb/TbY5OnC4eu2XGXdQ638LCiXxFsw5vQX5MotFXO2AuHy7DQP4/Inhc12e1tgVO9lV8FK7zRrksB22yiohvAMCdXKGnKmebP8SZEFoXTYql7F9D+EGSXcHYne3U2x0j8W4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA3PR11MB9350.namprd11.prod.outlook.com (2603:10b6:208:574::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 12:17:37 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 12:17:36 +0000
Date: Fri, 13 Mar 2026 20:16:55 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Zhao, Yan Y" <yan.y.zhao@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "Williams, Dan
 J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 10/24] x86/virt/seamldr: Allocate and populate a
 module update request
Message-ID: <abQAN8WnNYepeYLX@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-11-chao.gao@intel.com>
 <abIlr/gnH/Emc/9X@yzhao56-desk.sh.intel.com>
 <abLPaonGMoEm2GFg@intel.com>
 <89d69e852d3d822b51d3623d02ef6637239ccad5.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <89d69e852d3d822b51d3623d02ef6637239ccad5.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA3PR11MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f60004b-3e54-40ae-6911-08de80fa8341
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: WCnGhuOOXXczMF+LhHi1Xuetfm5/Xct3WWdfjQcPxn0R8zCool7FB1ege9BQUj8has2LB4V0g8RqiqoZXbjY6kGfONwNAgx5R2ckDYx7N3t4BS2yMx+a79f/9AnLlOKMQR3zNSyLmabNrZDITOcBBF//9v0WC0aAkbjW4NYzQAMCAcnJHJsVGHo8GRWJRaS6Nr7ezxY3IBNrRtK9toKcDPdxWxRe4xUo171Y8g/GtvPLnMg0PNrzggKf23hLsljPaJI7KB1JIcF0pWu8uCuBAyYYvONOmOjaVpi9FQBfoQhlw25Eb8loN0g7B+224qCs/abjCkoRxymkfP8jfRGXhJiyw1Tw/zHBs43siUISmPYQiigj/HCrXOQsbq+kj8czHABr9Gl14PYfQjS6ErN7qLqQPkOWwJ45Wy/uoKSvq6dkRNa7BO+G8hbp7N5Zxk3ADCqgEKxgqQ09L/7a0jrWMfW3EH/NhBqv4vCQIV96oNlRK7veg3zr8rfIRstlGH+65oEA4XYvNkMpaXEMbrQQXH5i2w1C8w9BvPNNPLyJJCv243MVUkJljPow6ws/yxeOAgGmBJ+QyH04daXUmhD0xMMgqTo1ZTNJJwEhitU7J7yvSwgNkTV8jvx9qRfzpRRQNM8nUbwlQtRkb2c3pGinvK9hait81KLVtm5EXAJ/RKD9I805T0CJoEhrrTsdKthXXT2fR09Imoz/r9f3uHgmry8PnKDnqEJV8UWD08HhJkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KVfR2Bq5Ehu7Q8UigVtHN0VUbGPomCihCJDmLJHhZ5Gnno+B5Vaxj7w0rByo?=
 =?us-ascii?Q?z8iDIkfxkPRVcq9y1z3dxXyagGNmyCrHFKOlL1VUMn7hQGsCDSlQ7/W+2DmU?=
 =?us-ascii?Q?QUoKDQLyVxZy6MQG/c7jnF2vjiGM9v70NGV9xBgCOMTE/WN0DaCfXRQ16ukz?=
 =?us-ascii?Q?ludKPu3XgUZ1NaTnalfNyr7m85WSNuy5dZZSa0GR9q8t4T4XJys87KUGAivd?=
 =?us-ascii?Q?zeUz5qOCjX+Dnp/t/peYXHEGxuCrd6f3kCKYuIEwMDMrUCxbfCD1MpDukttu?=
 =?us-ascii?Q?PqddFMRyihp2KD5wSCEOooWw+0vLEUrruOCQByukPJhrxnufSneM+N784/kr?=
 =?us-ascii?Q?fTpZxjQp0Rsnv2HkXlgHxeHl415s2WmMnsa1BN1ayMETT72J+n18ym/LPeTx?=
 =?us-ascii?Q?ok9+98nrWOI/MGKpz+Q98ANXDgeYAQbxq42oERBV+zXAqVuYsJEctcNTXTgH?=
 =?us-ascii?Q?fKTxzUZGC3JIwguQGkD7AgGAJWjxmatb/zOTYkp3E8JN2epqIDN+Ma9EgBPK?=
 =?us-ascii?Q?d09iDVNH0MBTcWmdrYo/p8hDcQlrdvKq4ATyWcOSD0cvcjZzWM4X/OBDcidI?=
 =?us-ascii?Q?YjXFZlBkQsFTlHugTolxclt02Y9mdauSgvb43xb4hIzI+4DtwPUpcqCCtQ8F?=
 =?us-ascii?Q?g2kjH3+T48M6Y2b01YerN4f/akm5JEZJHw5mqpJP5p+P7/myvj/tfrChqI27?=
 =?us-ascii?Q?S+8Cei9tfvHgf29X9FSF0yF/jz7M3aPQNQjLjQ8jaFP1MuVkiGDcNOxJAFLG?=
 =?us-ascii?Q?aGez7At0lUkIiade8bFgnyXzhdF7PearVBSOmydljC61b5RgPTdVZZPAS2r8?=
 =?us-ascii?Q?2WbB//j9LTLoI9gN+oekcCoUS3Sfc2kpKbRjtNhiGlKjyqAC0APeyUvswGsp?=
 =?us-ascii?Q?VDAKNk1arfPMHCMFlbDoNg8Gitkj5yZbrwIJm5MUteiF5tmBYQJktsDPSSYw?=
 =?us-ascii?Q?TWiaLOIHKW+1aaf9kh4Jh/8vHCO7/XzdQyd7g8Ta4pW3SVATiu7yggz3VUm8?=
 =?us-ascii?Q?rkzcmBuSRd4LXM6ksNsmH9dRmb+Zw/Sme9X+U7QdykmIVNo/Th39pgsKIDc+?=
 =?us-ascii?Q?1o8bsKfOxm+Sx6K1UAF4sK4Qd4aACvzobg+l5krpsnHO0hnfrffEf6t7yj0E?=
 =?us-ascii?Q?P5TFF9/bB216tXlgKFWqYW2EHARF6SVcbi/vw6f/q5lJpM/t6ibhYV5V0MN6?=
 =?us-ascii?Q?U3F07lFiw2upmOAfnTbRsPe7QVNWwRg9AztA0257I1ar22LmlI5LLrS5ZIdy?=
 =?us-ascii?Q?NgA40vmXqH+YW3jslfX6ldBL+uq7fVvnaZfEKb8eBBv830eznDSNzBzjY/4C?=
 =?us-ascii?Q?79tk4LKhIGT9Rtn98P5BEieGV7oDWIayRG/851Z+G0D9Q8y4WUeouvqwl6LZ?=
 =?us-ascii?Q?OpjOYkkqEMCSMGpjUls+cTyjXAplY5aG4aBgUU0Wwrj3tzU9iAnB/kzlEO8H?=
 =?us-ascii?Q?1hUJy1kVDYKX7GXyevrrRJCyg9LQLaR8fP7aECzpRSAEbvaIwSo6UPlJnWZl?=
 =?us-ascii?Q?eHacR2QpSyWuYBABnEX9m7UzoOjl0qq+2IDsLG3xHXxhmTLjguLLW4uMiXHK?=
 =?us-ascii?Q?NNqx0NAZoAqYUJoIS/ET8bBTQyrPqwBrh2g9xpaXV6IoGMaNOFU3ekUs9F3I?=
 =?us-ascii?Q?UsbwQ0/oeMv/KRUnIxHFQb2lFhkrSWY2AY7xhdYD4UTXz8VixGTHtT+gvS8r?=
 =?us-ascii?Q?zVzfGdeHnhaTQC8hauCaCeysA03DRteSEL6XNyaC2CTJNibZQXGSkLgZzBfH?=
 =?us-ascii?Q?fSiJAZlhqQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: gDuucmHD04xT6eQT27DpFUbwfaC1okEV3/Y6d0j2BCbE7XZI4+mOp5oPKTwuoG7J3b3AfYEvNCi3MfycyKcdAnkf1w0eZy77J48+Vvx+UmjjDt3ZGk/Qs0GXGl+7SKrd9sRfyqVyWbO3ZMo/K4voaqDQf/eUNUHgh1nIAhLPZEdkhYcMm3HNmzy81OrGP+bg2ZKEq2l6Qq+c/V3oCMD+htMC65HQ3PZ+v9rZs24DsS1E/PS5oE9Lyr8iyB0ESGRa/OZ6Xap5tRUjxBGcwHYl27SM3XEOXJjaE0mg57c0ijquJYZ/CvaQYCyIfcUKQ/78AOcru/qnaLsGyZ4e0NnvTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f60004b-3e54-40ae-6911-08de80fa8341
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 12:17:36.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29FRTULPBIPui7gk6QfkHpApK6Id3A2mE3xfv0id7MeKdjAlzWprlqLR8sz4762JC2oVCZoVHodnI6AsCjsNcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9350
X-OriginatorOrg: intel.com

On Fri, Mar 13, 2026 at 12:56:19AM +0800, Edgecombe, Rick P wrote:
>On Thu, 2026-03-12 at 22:36 +0800, Chao Gao wrote:
>> > > +	if (blob->version != 0x100) {
>> > Do we need a macro for this 0x100?
>> 
>> Maybe not, as this is a one-off check (i.e., the version/macro won't be used
>> anywhere else). If someone has a strong opinion on this, I can add one.
>
>Seems like kind of a magic number as it is. What would the macro name be, and
>would it make the code more understandable?

Yes. Adding a macro can improve readability. So, will do.

Thanks, Yan and Rick.
