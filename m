Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85752DB794;
	Wed,  1 Apr 2026 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775008670; cv=fail; b=OHHgwJdsX7/3e8uqmLXP7H28l7Ls/cuoFwexOUkU7GiwPPtqbS2jOaUvUopEll4pDuUOL8cqv6fAFXEIj+FZe8OzCl2DqaQxE2739toxQbpqXipSkk+rlvvcU39DskVw93p84xIq+j6MzkZ8M+Pt2CU+uT3HustskJ7BXwsOfFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775008670; c=relaxed/simple;
	bh=kJoPU1fA4CELgy5irr1qavJRoYSFw7spUBKK6pk9MJc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Awq0UnSPlMhWFb88edUzQRbPKBNKqQRc+LTi7SvmyZghFDg1YwBH9sRi5RaPJVz4ToQKOvo+WFfuyD/1VZwzCxQSlIxAS6LEEwu/78/swbNpcWjHxyGl8Edae6OErAp4HqJhHSE5kA4a5CYA83gwjowDB2CavTqm2zyd4jyRGLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGGogRrc; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGGogRrc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775008668; x=1806544668;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kJoPU1fA4CELgy5irr1qavJRoYSFw7spUBKK6pk9MJc=;
  b=aGGogRrcYsQAISDZxB56JujfpuLAb6lgtGW7fdZXuwTaWmbp1nUTGFoF
   i4As8779qNtzwuwmKE0bN0v5MV8b2yY7oI6ukcStaoSb73fGoy7EL0jkU
   dtaNAVq2Mqo2BVqLjHDFuZWaDKptBphZh5CyqOReXlaUw/5aFix6UrlCs
   xyFNf8FUw5e6fsqgyLkfB9rr9RmACg/OpDUkoD+Zj4KdnDNt5hHH91+bZ
   HiLM+DPJsYrgIVN14KViqHQ2k5Wlhm+iJEroCELSRzzyvb6DTFWnLZk/B
   XHqPZRa8qIKYd8KDG7Vnvp39DZsWA2DEcVNLZRg+hupDQtgp55gsug3wl
   A==;
X-CSE-ConnectionGUID: mGPLT02eQ6es6Q/zDQHm0A==
X-CSE-MsgGUID: t/PIYRt6Qc2Che7yp8LQPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87113643"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="87113643"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 18:57:47 -0700
X-CSE-ConnectionGUID: kKRkUQK7QHyAeTJoG4Ku1w==
X-CSE-MsgGUID: IX6v9h50SHOxGHLtBI4zGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="219879491"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 18:57:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 18:57:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 18:57:46 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 18:57:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bW4z/qEkXA9mcDrvwCWNLczVCOFVK79sWANzuCT5xXcLIe1m9YY1Te7n+c1ygM03OZF+9zEQ6Xtc1Kf1MtP5HdWt5TxPDCFaEWfVuvy6DD1hHB95i2NOcuqszY/wyW17GSJUCicjyPjaZcXNNdbzJyT3rvAsya7bwCxzNt0SzKsPYU/Z+iPL/pxKrxwem8N+YWo4yNJ+ftcj+wmH4Beg7E+8BZM7KJJLszkUw1LLQOlf53ItRClucBBicaOmb7gCgLH3S5U/XrsxdLIBu3DCn3mH6d/2EWeD1IZW5VF4mjJGB+KuEFXWefUeBZsqwYTrjfSvTdro1Dx4IEvi4NE44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJoPU1fA4CELgy5irr1qavJRoYSFw7spUBKK6pk9MJc=;
 b=S2ZsFonoviiBCkJ4TCaYZ19r3Tb6dHEkJIz+55xl0hwvtb4aRfFmmgl+jjBqyU4tJ4PBFeIyBFjUOpDgcg34a8hx/O3mmD0ycVWKG+qfkvurmzIRt3UJ3/if52um4cssZnbUKSZBiyo4qj7IECYVc/G2/ETAwzPZZ08joYe66TYn/3Av6RNO2z/BaWXC5U8fEkTO0eg8lonixct4DCqmznczPKN0TNYpvHtRvfvzmU3wmttDqzj4smdYTrX9OhwMxgeUBg/ZHFg2DW1Eey1pnaONkQ6GtC6sMDlCO3D1dO6jC4gk12FSqqKgT7y8QWUOT/Kz7O7vW+BG0tJlNUE/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA4PR11MB9082.namprd11.prod.outlook.com (2603:10b6:208:56a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 01:57:41 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 01:57:41 +0000
Date: Wed, 1 Apr 2026 09:57:23 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <kas@kernel.org>,
	<nik.borisov@suse.com>, <paulmck@kernel.org>, <pbonzini@redhat.com>,
	<reinette.chatre@intel.com>, <rick.p.edgecombe@intel.com>,
	<sagis@google.com>, <seanjc@google.com>, <tony.lindgren@linux.intel.com>,
	<vannapurve@google.com>, <vishal.l.verma@intel.com>,
	<yilun.xu@linux.intel.com>, <xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 06/22] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
Message-ID: <acx7g1uMz027CWum@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-7-chao.gao@intel.com>
 <114e44e8-b06f-4b45-b962-fab2e6c03b68@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <114e44e8-b06f-4b45-b962-fab2e6c03b68@intel.com>
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA4PR11MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e472901-cd08-4416-aa1f-08de8f920eb2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 30t5CiWOVvqzYXJDcWjE4a+C311oaFrH2XldCb38sxiZmzIBuT9nLthFCUOg26BW8tCrQ4NX+HmMjzf8zXsb7qaCJvAsu4wc1//C6VPB3MR/QT6rqsRZQkhlfvtOWSJyTh/W0wxUua0HKFgT94/OLgVRx2e9242i6oVYfH00vbsTvRH+zZtIMeVnpRHjxSErx4ZpOQy1ccNFDVKs6QMmiE/r8K/46W8WQZNUi4eTCSrJwOU6AESWRSwM3W+t/s25bAoEPsbv4UlBzUCr8vWxf4Vw+23e63pODVR+xKSJ913hiYlcJ4pg88kSFGoIkCivRERYYKbL4CURQMIWlqNbwAs9CmpJbAXkEkbU7I/UitOh85btr3ff/sHrDwSPDLhcQAIJmPp35Uqi6e5DOJo2Ks+z5TNsIaXfmQNcuge4Z6+YT8/Ftr1GXJ5CRUbSDaGfFE3sdmG7+9nKapFRcUMseUAtqYoChwu9555xHoUTERl09NnN6aP8GN8hlCJS6a0lcCq8q17YjkGDyaYYuTEuKsMFX7VaE9s6EUSJYpaBao8eZ/SQUC1qYhQnpvlOzVQ13gMBscUBShJzqU3ubnxcZSylu/z/PPCtc1t4bro6clAbRdncmkMn8tdFUVRglg2hl82Gd/3HwoXYOc7kXUekZ8JEqkl9fm4G8FDNQa0691MjxA128bCJB87EteFmxlLJZSqch6YP7D4ZF+K1GKlN3ooO4Sf0GVKBGaf5n0f1/aE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RaJP+4ufwbEe0JTspGuo0O0FSt62CznKhyoxArFq++jWJuY/4X4MRh+yVPZP?=
 =?us-ascii?Q?jJYOvoiWhlGkMNrUyXg2/jhXaw9R7rKTdLdSq1o5wULKuY59BDMWfkNgyOVk?=
 =?us-ascii?Q?o7BpDzauuJiBHhjNFn1mLZDBYdjKhuBf68I7QeUu6rpyaIe8sR1h1ahcuQgH?=
 =?us-ascii?Q?B+X5gj9olIfJazp6TKit+DqMAt18gmF7uyFpvMMzBk+t8e0VGBMbfdsTRER2?=
 =?us-ascii?Q?1ABattKbjmX4Hs+ROx6uCt1QZCAUqbxt/SdjBJaw152HP9Vb5BIQQN+Um5+v?=
 =?us-ascii?Q?QClUdrn6NFW3J4Mv/VTzHq3BCYMEqivqtHyXu4Mk19OBbtTdLcUkp7MlQ/fG?=
 =?us-ascii?Q?6tk0qrOn8dTZOvphONqHdcLW8NwYc4WiOL9FY6muzGmTLitHIYbHKnr1CZe+?=
 =?us-ascii?Q?xcNOXTLdoI0JUkuJ61xlKGkXGYIBnmXBGB2G6fd8LUHqEWRdCFVJZdpj5C+d?=
 =?us-ascii?Q?M6KG1ubW/OhiBdFVFWFrYzRol1USbzgAx261AN5JWn0jBFxI57DAaqkoHlzx?=
 =?us-ascii?Q?NdykOW8e46Dx9pXk2Hh90yEdJMAtnSNvvr2tVKPNiENO1ICTVo5lqlDQ7x8F?=
 =?us-ascii?Q?8mjTn+qUC2ATqa42AFg5BxGgOR5p5xt9aDR6gPvgg6zSx2qp8gequtKy9n1E?=
 =?us-ascii?Q?WD9Rr7UNkGwBtRNQH810trlMm25n5b5fS0UrWT0c5ga5GVxOYGC26f2Am+hz?=
 =?us-ascii?Q?HUWHoiCX1Nps9bXCPzFLZYnldkxox7H9FzoSxJwNOchIbrQZnLrNpbjn6X7+?=
 =?us-ascii?Q?CixAV9qFqYWunbbEYvknz/wZnB9eJZrll4eCVzPBdRPRNseBP9Bk+qenoJs8?=
 =?us-ascii?Q?jZqv2GIG9eGRRMmzm4xAWWDnMEDp5wdhQ4qA2s78tVznC9ei/ijzHEFA//Nh?=
 =?us-ascii?Q?nbbHh/te10b6UBo28uXNz1lMY9DbLN9288YAedF674vH6kG3w9QaHpEBusoB?=
 =?us-ascii?Q?KNANTON4iAylWukue4HEjKYZ/SWKU1pdayddHK5BId4Kvdc+W3TVHNZwYK4j?=
 =?us-ascii?Q?RQhBqEiabdMC3cKpBYATbOcqu3exmP44JavJpIuQ7P+tCDvWNOUiv5vRdwAL?=
 =?us-ascii?Q?fteq1RXQlU3SjxRRXCGb77lCcKhd4+kZKwnd+YvP1jfA+gwwGA849no6cj9g?=
 =?us-ascii?Q?4wNw+RekDKMLEBrCbX+W9zNm+UZDPSvnEcNNh/xJG5WvZuOVxMaOSm8X5Og/?=
 =?us-ascii?Q?efTvx27CCMtIN6sTI2dtD1PjRaARXBT0yZ+bP3ETgL3wiEIXpqtM6gUBkXCd?=
 =?us-ascii?Q?sW2KisK0m+DirP3L0rnBFKNfgYG3Sc6vfInN+2/NOA/7f/STPUAXIGzsknYQ?=
 =?us-ascii?Q?9eZ+NM8Y5htBXirv2cggsCf4AWkyNjn1/SFYyVfX3MhIr13CRBk5qPinkd3z?=
 =?us-ascii?Q?PvDghiwEuYTM0AfCmcZHeBEq1JgeVZGaYNZIEJcFr+eKegWAga4TI39la5O8?=
 =?us-ascii?Q?HXWDTPFEEluoscrL9d89nMLIGzoCfhmXgFeZn1hVuhxyg6JhJhgaRfN7oYV+?=
 =?us-ascii?Q?fA4nsdX7flnMrSlwQ+dexmd/5+SIyY6LLUGRARWpDAhNVC6onYb4IbdoPwzx?=
 =?us-ascii?Q?/UMDw0MwXwu6+Lu9WaTmeG7OyTW4KmxyuWybXej+JcddkdCwZN/YAoPQoPrh?=
 =?us-ascii?Q?IQXxHrpudnGmxPrz0pcT/t5yg4bs9Ud31foJiZ+4Tve+UoKw7lLWww8fz2VI?=
 =?us-ascii?Q?mLV5Jsgx9KWBS6wefnR63xWs7MZ9akigiXU4WdZ5H2Ju3jOWY7Odbn29L6tI?=
 =?us-ascii?Q?4kkY8YpmIw=3D=3D?=
X-Exchange-RoutingPolicyChecked: GZ/sLscNqg0cucPeFChtdKhmRIKPxaEMiJasDsAlAupJKWxq3ovhXIwKJCvPvq2hdpXfa29FGwoGRk80B8euIx9QEv1wXsrRWfNT5Fqcxp4jZgCX+J5WN8XnqzZ4Pua1y2AncJWm+43Z5iFWDoLPmQpt30kRNyuwrg6scl12ItGBIFuWlNDligdQ1Tc6snmFOL78/jqp1Cxte2Yb7/v5U+BN50ENztTedbOuRySS4PV9Sd1/wMdgmj6gta/I23t+qfiW381A3bD53wgCx1tRGSgOBJpC/sWIPhodmsaP9waCrK7r9g+b/+TtTSRf1eLq0y4rZbhpyPuOdFeOW2twow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e472901-cd08-4416-aa1f-08de8f920eb2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:57:41.0421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMxzwFtAViBNB/2VAmhc6EiFl5zatC40rzIw6o6KhugosXrE5sgyskCvWJQir0cIvNVYuUD2nQFZZvrJKAxxSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9082
X-OriginatorOrg: intel.com

On Tue, Mar 31, 2026 at 07:58:02AM -0700, Dave Hansen wrote:
>On 3/31/26 05:41, Chao Gao wrote:
>> Expose them as tdx-host device attributes. Make seamldr attributes
>> visible only when the update feature is supported, as that's their sole
>> purpose. Unconditional exposure is also problematic because reading them
>> triggers P-SEAMLDR calls that break KVM on CPUs with a specific erratum
>> (to be enumerated and handled in a later patch).
>
>The erratum is irrelevant, IMNHO. Or it *should* be irrelevant.

OK. I'll drop the erratum mention from the commit message.
