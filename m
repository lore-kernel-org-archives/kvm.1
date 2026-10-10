Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4B2C0F6D;
	Sat, 10 Oct 2026 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791612072; cv=fail; b=mFMBTFMAcptGKGT/tTYgGRLnP2litsdP64JWRDMATaxux9VgdEI+p5TnTrVjaI+2esOUeSpVb/31vWsNWeSJo0jq2DaYZymde4KkzNu43ntm+uHI4BMah1mAOTokuFskAhI1f411UsaRZgXD/bxKmuhsew0ZMknr3msfKNYosRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791612072; c=relaxed/simple;
	bh=dUf9qr2fxKtAIWP75zYxoV/MBsCR4bVeuenygeyfRPo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LvQyD9X52T3NP/Defwa0YzjVS0h9kTsA9cGAW0KMGXl1yj9R2ZblOLrNhawfuguWXZgBzp/r7Ih6VTZLrFp8w1IFLzon589HyHpCCupqNecc7CjmHWi84+b6dbi1EsTndscHIBUjy4qvizcrjk8wsaq6M8y45SHsSjEqFq3zB0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U87UplwN; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U87UplwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791612070; x=1823148070;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=dUf9qr2fxKtAIWP75zYxoV/MBsCR4bVeuenygeyfRPo=;
  b=U87UplwNd/mHlSRn/mIFUsP0LUC0bxUgTZBL8F6HAFHGQHHsYz9vQhes
   6+BJ5a/HMVTwWoPlXt66yg5GiFs4zPIKE8jHlqttx9oLqgImbKWKe6bum
   /X54dxj8BC5QFwKulmKp6f/pl/q3a9X3DOF2uX4hQ6Rf4f69okKDiRXgb
   tjKLFCSEPmXPs1Hi03XSMYGdse0Zd4/F0GLlCphsEFFlhkp9k9GL2ygw7
   JX646dey9Z12Q/DWy3Z6aNgB3wvGrnFwhBvgc0HEtaQ3zV8IDTL3mu7Pc
   jlInWYl5mZ60LeKHZggyJPOnQB1cvzuXpCaNcsUYKbZuiIgbhL3oJ736t
   A==;
X-CSE-ConnectionGUID: 9lEypRHDQFm/12xG1rLBqA==
X-CSE-MsgGUID: +UvMDLVmTq6st+3330mjjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="300226"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="300226"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 23:01:09 -0700
X-CSE-ConnectionGUID: zhVmDA3qQlSsc9t9kj2KkQ==
X-CSE-MsgGUID: wPjK0v6RRiOWpENhfWQbjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="481244"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 23:01:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 23:01:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 23:01:08 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 23:01:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNwsjLfkRH4VYDcbjwy+cRbGfUi96yGB+IduFx/cxmgXeKpi9pN5xRLqV+i6abnZLngP3YT+Y0UwiWo4iTCMj2WX7ZebEr0WgvpGmMCKMRZKewNbyVZVWCfhjtSWcK2uOqLG9mwMHZLSKbgcOOMnsITRazbIvlhYxr3QiwrrpOwTEwAdxGFtbscgkq6NuwHMgOb1JAbnu1I3ldp39Mqh0t/UGF90lPL3UeRl4+WWBnKJjdPgNInOxV9xcsXaKjVUL6007A7d0Nehf87BORYME0qVWmlc0rFjDL0LmDKSMsGmfSIEiJFtbS6YZ1+EPr12SO5mOowbLZDaVIwSxioVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsjBJbTNwNPt5pcqoJJ0pndH0zp2WCkKiMVc3NqPfCQ=;
 b=FYB7TcwoAdUd5LX+OlhNv/OGYqPfEGY61i0ix4TUwAiUPVIOCbIF2A8ZoenCPa3OKao+Oevh99pDmRNfbhpas5ZCIj9nuDXrw0T9pQQu8Ho5d9+60H8Qs9KR24FdqjpdW8hyMfAgVZE6fDNdaxf5A50U+jsdnui2Bh2BFW1hobO40WcnFebLmjSEDlcb5FNxuNrWnyTR6AHe+x++fap+RyaKHCQQaJaaWBV1NzduFdLYgGZNEn81gFgNvXNnUgV4U2pVGUVGqW8rFU/7iCp/CS0JhoHCTf14Z6hwgwlFHDykUMGIz9+Cu4Dji2fY3hEC5ag7uBr94qpBH9jMUl6+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3243.namprd11.prod.outlook.com (2603:10b6:5:e::19) by
 DS6PR11MB203949.namprd11.prod.outlook.com (2603:10b6:8:49a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.18; Sat, 10 Oct 2026 06:01:01 +0000
Received: from DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1]) by DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1%4]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 06:01:01 +0000
Date: Sat, 10 Oct 2026 14:00:10 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 09/17] KVM: x86/mmu: Introduce
 hugepage_set_guest_inhibit()
Message-ID: <asnUanihqLgni9WR@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928091049.15615-1-yan.y.zhao@intel.com>
 <a8f22a0650c25f37472e505c7666c7d66a8ce401.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a8f22a0650c25f37472e505c7666c7d66a8ce401.camel@intel.com>
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To DM6PR11MB3243.namprd11.prod.outlook.com
 (2603:10b6:5:e::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3243:EE_|DS6PR11MB203949:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a52e24-ab61-4cbc-02c8-08df2693dc60
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|6133799003|10067099003|22082099003|18002099003|261009223027099003|11063799006|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: +xdDGOffALrKSCpS2EIwiaLO1mRnI0ii1NPeSIbxcSISDOQbUmV+gyZDFqfCtgU+Jg9+IBTk9psqbooe7Ckzc/uB4HsPA/iZWLRZwK9ZdCYiBMeHvX2YT+fZw2xiURuegqD5d6t2+v84KAexigUB0lJ71Cn5sFiyYwlCqrZ3pqtY4KQrjtQV1rP7S6e6vswzGBmD466p7WzDlwzp37Hq+YX7fBa4dbZXeIfLf+fylnlA6ptAgL04oYuCdJCPRbZr3tZ21vnqaA1QkJQJ4rmiQNud2AgGQp4LN3xkxyTj0P/OzUr15ndVE9RopynEwM6gpsKrnKLakd6s222UFEm3Zy+iTvsp5r1YyorqsdybZRubzbrk2E0/+2oWFMHqMaEX1tiRYzbMW4W37zTjDGEprkFrO3WRMMEQDoxIncWFjRfLyPuwYdJ8d4JaKK9SLQZOQ2w2NRKkJEMTKHElrJ9xILkzuLp9S8L/4l9VovFnbSuGZfr2iWCkX2q10OPb6+Mc2PxGtP5f5SBGiulexBu1ZncaAByAfDM7Y+LUq/2ZJJkMNY5hdh218AEMAGGaYjl0idu85MMKmlzsYFpbVvzyEudzb7Q554xvl5PpxGVcuBDFBqxCqNgSJGLg8sCc44uOa3451b38mKkHUBMxpKiv4lgmQKHxkNiLvR/iGMLRNFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(261009223027099003)(11063799006)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3p8PljDHE3CnIBEOltxSEZVVVddk3HWodNfvtns2wD/WRLZTpFDJ1xeUyo2r?=
 =?us-ascii?Q?cIpKRPjmk+60YJ5ktFDY6U7myLpCRCz0j2gpaS3WsUqXcTRihfaK06xx3D1i?=
 =?us-ascii?Q?vSkTNikGEif8m15g+q96BoKL9TEZS4ZAFEYTA3enkzirY6OrFwcsqxf5aLMN?=
 =?us-ascii?Q?rc5Siqnr+0Avm4JP5Kn2Ta9/+K8NhX7GXGg7GyioYWPapSmAuGKftXZ3qdB0?=
 =?us-ascii?Q?7eLYVj3Zy759LtbjO37kFKKkw9l8Bwdp0SGKj08NXLRLxmvmukMCV26Qhyzq?=
 =?us-ascii?Q?bYJoN2tqPO8a8BzSLPRq+/5Bpn1ui4yvVYYpNsKdTpQyldS7oDEIiNb6iSpI?=
 =?us-ascii?Q?zq1vpKeziV8QSoANA8zHyKzv3kZOyI2QoOTs1uwa9yUOjcf/XwwFApwmfnB8?=
 =?us-ascii?Q?UoXqsyGY09i2xyjMW3usGQApgEpnxjYEPGP7ttz+NXB7ZowrduAcpTg/aAfs?=
 =?us-ascii?Q?sUX1BmXOC4GeB0rdpD8dVV5UztY+I4yL31Vk6KJcuts2sTOPLCq3hWwEh+u3?=
 =?us-ascii?Q?np69zjX6JQyBX70LmwgoNPCz8olKioDaXwNQcnlo/dVTBCBKRg29RGskflum?=
 =?us-ascii?Q?J0YesiBCyuAEeWZ4ggEn/hB4fDV6zeHNJkGSF2FFw6vF3qvQWcw2ueTEp2PV?=
 =?us-ascii?Q?YcAhmF5+kem6M7vuUC3V6/wwuZLNyEim920j5NMVD64ZTqbSDE2Naf8hD0oo?=
 =?us-ascii?Q?i6WiHN1ST0pHgp9gMHeDwmXD/o/TwLu+GJlNhjMIP6+zUAQwSpcgReCV7s/y?=
 =?us-ascii?Q?pelhGUDGBcqqD3Zr6saj+9jCLvUqowJM/UtimYlT9IekFj4vQU2iiwV0OTy/?=
 =?us-ascii?Q?K8/nzes89X5ZXRT6PepD3qycXPe8Vfhw7alyOUTpecVmJoCvPIn6r7u/yPrT?=
 =?us-ascii?Q?QDtFODBT7gzjXA1vjNh5hsNpaA4wWd7W/hZpoUjv88EwLr0pphxnlMFS1nfp?=
 =?us-ascii?Q?/YR5CSacmsGlopiYFywYjT5Ko/Wouyw6wIev4ToU8Bc7ZSa1FKh5M9FhwHg6?=
 =?us-ascii?Q?3twph48q46RqD+u5fkF68Pl3KLL1k/FBTD7BMyGP8YPW54+QtEDLqmI8jw8s?=
 =?us-ascii?Q?izf6RuDBlhrgSWGxTmJsDDC28nNsh+R5nNVSOU3W814JPO6nV/jr/3PFs/Qg?=
 =?us-ascii?Q?Va6TdIwjbiNh4hKcTJ5LG5XpM4xc1yQS8yT123mjX9S9py8RRBcgpAuC3lpg?=
 =?us-ascii?Q?LQK48gPZdcs3fRTwr40OxLAGDmJGWffTu5ytCgAXsRp1Sy5twVYpRKxiugUK?=
 =?us-ascii?Q?y1Trjxb78WbObq5rfKPwatAutu+0wTVNTh7NQPnfdwn7YC1RCYysBxckx6yo?=
 =?us-ascii?Q?bBS1eNqythoRZeuAi2+9A7f7CrCSUrwX+a3gyLkmf48RA8Q2kRxbWnuwLwtP?=
 =?us-ascii?Q?qdA7oigi9cABkrO8+1rsCT0OCAB0sywMJXFtoM98+NIEQVLUjfS5tjna/zZ8?=
 =?us-ascii?Q?MuNbTap7feNVD6sD1DVThlVSBGqUsOSbvNFWor9X2B3wfUXtsMU/ef5SWxSG?=
 =?us-ascii?Q?bJVmHMhLpS0/3S8f+PRkUlDcGhMyO3eeS2Krc8HCr0PwOnoFJIQObwMSVT+s?=
 =?us-ascii?Q?83jSGv1dkOe/PMGjGsHOP7eB9Iio29iNtNpyy9GIpHfI+ut6zVrJ2OivPcWa?=
 =?us-ascii?Q?3Ug4IjyYhTrqZmjBwBWYv2K5dzPLywR9x3UTY8oFSjfMJUsfTET98gGaIyJI?=
 =?us-ascii?Q?xaqPnOAa6zSPfD5ltAmMpZ++ipAj+3pichF3egBZ3KRESmSBQlrpviiqXi0t?=
 =?us-ascii?Q?+z1IhbCdJQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: Ta8BdvPotdx2UwAedkhx98VL8nvV9ydWdeXc0zRqYKgryqSIzEFTxicc3UBcBVNJ5PCt8Gh8aIIUsF2QUvZ3eZEQTuiBDc2zoaU7RDazeSNDDPwBTc0t5zpNOtHhpM5Pw/5XHW3GuXghSZN7D9V4GhARE4pI+pTSMfNHO8LJGalvBEZYNIYtroNHGELJxoMj3zSsrdC/qA9S/Bzx0Y5VUAmj6AOEQ2uUCqDwpj0wZv4xqTOP/ccgpIFmdboOP58PMhlIiaYO3KihXoaFMI+/KyqNtfANPzybzQKji1i/5tKEw+ocuwmMaC5MjOmIKQ5yIBHpN9dlIyKHlX3XlYQu8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a52e24-ab61-4cbc-02c8-08df2693dc60
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 06:01:01.1497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmI/LqPsl5lkW8J4X4C+cgAXPORTkEHS/fJaFSe4z3YZ5fopDUfB4amsxHZD3/IlhsC5aCOECMLsGcCa8wzY6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB203949
X-OriginatorOrg: intel.com

On Thu, Oct 08, 2026 at 07:57:37AM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 17:10 +0800, Yan Zhao wrote:
> > TDX requires guests to accept S-EPT mappings created by the host KVM. Due
> > to the current implementation of the TDX module, if a guest accepts a GFN
> > at a lower level after KVM maps it at a higher level, the TDX module will
> > emulate an EPT violation VMExit to KVM instead of returning a size mismatch
> > error to the guest. If KVM fails to perform page splitting in the VMExit
> > handler, the guest's accept operation will be triggered again upon
> > re-entering the guest, causing a repeated EPT violation VMExit.
> > 
> > To facilitate passing the guest's accept level information to the KVM MMU
> > core and to prevent the repeated mapping of a GFN at different levels due
> > to different accept levels specified by different vCPUs, introduce the
> > interface hugepage_set_guest_inhibit(). This interface specifies across
> > vCPUs that mapping at a certain level is inhibited from the guest.
> > 
> > Intentionally don't provide an API to clear KVM_LPAGE_GUEST_INHIBIT_FLAG
> > for the time being, as detecting that it's ok to (re)install a huge page is
> > tricky (and costly if KVM wants to be 100% accurate), and KVM doesn't
> > currently support huge page promotion (only direct installation of
> > huge pages) for S-EPT.
> > 
> > As a result, the only scenario where clearing the flag would likely allow
> > KVM to install a huge page is when an entire 2MB / 1GB range is converted
> > to shared or private.  But if the guest is accepting at 4KB granularity,
> > odds are good the guest is using the memory for something "special" and
> > will never convert the entire range to shared (and/or back to private).
> > Punt that optimization to the future, if it's ever needed.
> > 
> > Unlike hugepage_set/test_mixed(), which are placed under
> > CONFIG_KVM_VM_MEMORY_ATTRIBUTES since they are unneeded when per-VM memory
> > attributes is disabled, hugepage_set/test_guest_inhibit() are invoked when
> > per-gmem memory attributes is enabled, since TDX huge page support is
> > intentionally enabled only when per-gmem memory attributes is enabled.
> 
> Not sure why we need the above paragraph. Especially the gmem part. It looks
> like it was added since v5. Was it an AI review item?
The internal Sashiko review suggested explaining why
hugepage_set/test_guest_inhibit() are not placed next to
hugepage_set/test_mixed(), given their similar naming, which seems reasonable to
me.

> With that addressed:
So what about:
"
Place hugepage_set/test_guest_inhibit() near kvm_mmu_gfn_(dis)allow_lpage(),
rather than next to hugepage_set/test_mixed(), so that they can be invoked
outside of CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
"

> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Thanks!
