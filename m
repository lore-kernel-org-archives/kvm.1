Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792426718;
	b=wB87WF0l73I/lOviD+tYY3dOdMpA3NkRGZ72SX4DpxDJlqu2G0jD1/hR57QFacN6nwAg
	 REFvRyVcOs2LbYcfJ2UQjzg+vVvd8TaRitAHoXLiPY45XG4z8H3Il7D4llR4yoMl3OJQR
	 iZnASUQHdkM09ljXpeh4NAud3DM95CaysH/GXVPvjJ1PynDMjK28tYm3wbn+1Nw95+bLA
	 +v0hz4lq2Oh1wFvvCUJVX7J911+MxXwnVo9ydYC2/ht5xLJzSQzqJh7slylxkSbbvQPew
	 vYTinlv3czwYY3/bA1/AFRp3LjXgeKT2VU6y9m4MWyZNLg2jbKeHkMnXxum8pEva+KQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426718;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=yImE2PLbQqg6tWPMyC6GwMEVJfMq4UFqouQ0eOkvYG0=;
	b=sz6OCu6Bfx5Pu04xf5+kxN1cN68vwqQsLKXfm1pClwEqMmQLT2m+zEj3smkO0NW3h81d
	 KttVdrBX637fGBfmNSWi7JJaaMA2BO4llv4hZQfDN+Ic/TL9x+P8a2wZJGztkQyVP3ax+
	 AoN6wwrxf4q/dER+Px5yr9feMWq0MvI0bN1Cqr1+Mr7qQKeGml58Fp1BEgsQ3jrgQYEH0
	 Wr1/tXrvOLA1yGN573Pb7lznR4L7ijNBr0KVXd6NA1vI5oNjdYyEnhpduso0Cx8Cz63Eh
	 RTwFIaOnebY2HaiM1pLq3KU6ci2IkWIw106FW1R+V+mTMMg3xZ8AwDT1uvkg/M7PeAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LQnJ44Wk;
	arc=fail smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC287606A31C;
	Mon, 19 Oct 2026 16:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC287606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LQnJ44Wk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792426717; x=1823962717;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/bVdCjGjMITeUl05/2ISkyUUZONTb5yilozRwsiJBGo=;
  b=LQnJ44Wk9ArB8bcJrhSCea2nKwSklhBFu8diRcOFMtXe1YudOhD0QM92
   V/YKnxTRnwFZigceBTnfxPSkENMIXlcnlAxQZUZiE144GfACk2XrTbz4L
   uRjKSzc5Za4vNdWpPj+OuPQlxNfprhRQsejspEKKtEblIf5xqZjIznYMV
   U6dYKQhsoBOKa77eZr8YO4Nno66yJVMrajmf+WU5yCTHy8BzKPcR17lZ+
   rfoLBkQ5VgVNCoGVKLq/UVFvinvT55VVCtbB7iS+gQXSnRIwdU0yA0sWL
   QCTgsgAF+l4ayAFomdIeE1YiWzHtF5r+SgJKZYV236BZjOD2/uGoshsyN
   Q==;
X-CSE-ConnectionGUID: M4xM8GAuSASEZcrSJegQbQ==
X-CSE-MsgGUID: Og2loLIrS8utqkF7tlBm7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="998583"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="998583"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:18:37 -0700
X-CSE-ConnectionGUID: vRVEHUjuTdadCIKAFeDpBw==
X-CSE-MsgGUID: czIYzHWTRT6p1gFq44bLbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2633774"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:18:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:18:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 09:18:34 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:18:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbX7dbom8PAOhPbYC4ezojKZF8dSWp7YdbHDrU6XpsU/LRxGjbXfGeP9ZlErl9HUQkOXgXt4Woj7U6DRciFVfR0AmSEmRpHdK1P1gZuQ6PBE7z6txh4xQjoUTRYnLlewpx2sDYQBAurgVzSEbF6mvGaVXm/rSZUdm1PnBw7vHLh5LPOHFAFrvi5uvZl4teSXcUdCuCnaPjBp80/R9ybcSuLct/HEpzVmyZcy54vxekyXm8pKoAD9UMuKGDQu36HrNJ1BnW4/4ggfry/+JWCaCR/z2yh5prFj7p++bQ/Fq6T3VU6GVDNuRXdGxkeGTosgRiIMiZUlci0IKu79Sp3BZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yImE2PLbQqg6tWPMyC6GwMEVJfMq4UFqouQ0eOkvYG0=;
 b=XAlUEc0PhCubTL+riF6WeEzzM8UoZju4jtvzuJt4TjFqx2g05clj9oVb7g49fagDpoJYSeKRy1IQq+LKU0vLHP6/QOiwku/w4AFHQzzrcKa51UIhHgt12A8zQVmVseZhxZPC5OSrzLr3pRCM+MPyLfKXkCj9rTBMu/DOkUMyuSeZkGUZ1WigZy58jLdY5y7qJP8/+vqdQ1yXH01007dQBMHlTOda2X2mf93gsQCCeIfdFKlxqZk7K2eEup3e/Tx9fmBPIIf0ql10anu72oaDbUk3l6d6SAEjad3uOwMgpKiB6mxjgrcGffVLcPHJtLoCC/YtU9nu74BieMoUQV85xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:18:29 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:18:29 +0000
Message-ID: <a62cd7be-fb69-4d4d-8416-fc85f5b7a4a0@intel.com>
Date: Mon, 19 Oct 2026 09:18:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/18] fs/resctrl: Introduce kernel mode states for
 resctrl
To: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <d98872b26051bfad280f72da3bcddea1e978b37c.1790867441.git.babu.moger@amd.com>
 <b2c67318-b52d-440d-bf40-fde40b47ae07@intel.com>
 <351da689-6f30-4f56-8f3b-ea62cc501d7e@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <351da689-6f30-4f56-8f3b-ea62cc501d7e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0139.namprd04.prod.outlook.com
 (2603:10b6:303:84::24) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|BY1PR11MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3adc0e-d639-4234-a840-08df2dfc9cc5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|6133799003|18002099003|10067099003|22082099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: HxuxVsasf0CSg48FppOTGUGg7EZipLDZbRnZQjEdjOp2cFEE0+SWxBXRlovZRMGVBaqY9Ms6i6ZV5joRsb9C4UTn7jrCqhRjhEQ6J5tTKEsEXHan7dGnNg8LmhjlOAfYm3wDQJr0DYh2sAvNV51/dLqcyY46SqVEQaX2uzwUWhTq1ABwL3n7J2hVeFSb363/0JuZv55gySWpFD+nJ4wFNqUpKar2u6aWTC7vrQMUSOXUAEHYvEGIMR2zr88r+rezrkLYMTSzDAwVpzROoATuNj3iJuYty3cjB2/vJ87iVNCq3WosXiGJBTGbuQccfq930d5RuZSI6ZrbnHnZw6PW799EWhsqn14F3KvDwlYEDWbRG4N5CWNdYq0lBMnuo1U/bOesDBhur2GEIRKKGqeXtLe9PWq69NCGto0pkjCzzWTSzoBwkjQ5SrPQWXANApYaYMKhVBcJKJDFKyo6fU9vcBkrpV1irSH0bYOqo1GbvhznHB9KaQgqcMdrZZ6cq8SNEpJosGEUnuFbqELbp2eQ8qev6OMiduApq8RJ6gx0W6FHyW5Hk07Wl6bTSfi+xETUlQXR1Jgnq16XyH1d7y8Msa/quqJh6v7yv8pE6zPCleOYjdjG48ftB/ltwJ855/JFW4stCDQiJtaMYUG46Rbwt18xTMOwac3MoAs3pSKozYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0dEWHhqa3FxclM2WURCR0IrZXZHekJoNlFjbW02WWREcmFFajdZd0VyWnIz?=
 =?utf-8?B?M25EdDlldVVkK1ovREU2Y0RGWkh6T0lEUndRemkxQ1BEVEVFcUJmVUtsWTkz?=
 =?utf-8?B?aTRMaDJyd3FxWUF6QThqazQwNmxxSkZQblQ3Y0p2d25WOUlqeHRrMFU5SGNn?=
 =?utf-8?B?cGNsMk5IaUZQZHV1SXhnZTAvRDNvUDFtOE4zZitLZjRmdEduVjNoWHJVLzhm?=
 =?utf-8?B?MFJRRkZ1RmNJQWVXYzZUVGYzSUZaRlZiL0xLaENyUjJESUtIYmhrc3ZTeTht?=
 =?utf-8?B?RUtuV1puNGNPY2l4cGtGVi9VTEYzR2lnK21YOXRUTjNXKzBMUkttRDZvYlVM?=
 =?utf-8?B?cnRsUTJzdXI4czlMUmFYcFdSbUlManViZThvS1ZWKzMvK0xvZnVuOG40Q2JG?=
 =?utf-8?B?eExYM3BGaHZ2VTdNSHZQUUowR1F3TjNHV1VFbzYzUWR4M2VNbHFxMmlFWEl6?=
 =?utf-8?B?N3ZSeklzNm9TTFEvSnZCQ2dWaitsU0h5RkVEMjZFeGVvckIxelJoa1dMdURt?=
 =?utf-8?B?bGE4UGJ6Nld3dVFIK08vMndrbHp2dXZlbWJaMWY4eWlPSjUydHdpdVJ6eDFt?=
 =?utf-8?B?bGRkeWxrQm52NXFBbVZwNllsaG5nMmwrSSs1YjFhTVc3NHRkU0RpQ09XWHNo?=
 =?utf-8?B?bEVqc2ExK3N6ZTZqT29DZzgwTVlwRjZPRHNTeDI2dGFJWUl5MVUvNTYvM25z?=
 =?utf-8?B?ZmhRd251VXIzZHloa1pOZTIwT1E1VExsbmFKTlhVbXVjd3BYUXNDTUllYW95?=
 =?utf-8?B?T21raHh3THBmMTloejgyTXJNYlBjSVRuZkp3Y3RQZzdYc2dzSmw4OGhIVmtl?=
 =?utf-8?B?LzJKb0wrNS9iTk1jUGlCa1JZYm8zbm1kNXlYSXhNVGkwYzcyTXZkVmFlQmF4?=
 =?utf-8?B?N0NIWFh1VkZKNFhVamdBS2E0b2V2ZFB3bFg0OUhhZGJZT0hMU1NZMnB6dm1u?=
 =?utf-8?B?Q2l2eWN3RTc0YUpTRGR6S1dZMlhwbGFQSFpvSXk5Rm1rOXgvVmI2SE1Tb2d6?=
 =?utf-8?B?eEVGRVhscHZneDRWT2lUdE50NzgyRVd3MWxsRUtPOWt1c0tvZzJvMy9mWnk2?=
 =?utf-8?B?Qk9JeURZOU11YjZSRDgvQkorWkhjbUZHVXUyODA5TU5ENXBDQVE2c04vNDZm?=
 =?utf-8?B?cTlFb09oYjlIV3RGOXZmbjZVVkREbWJrM3NYN3FJUCs5ZWlBV1BWbDJ1WVN1?=
 =?utf-8?B?QjBueUxEWmJ0dmxNTGdRR0p1N3UyMXpWcFYzeWtXdEp3amplQWhNcVprRms2?=
 =?utf-8?B?T295ZVdsRjRTUk5tc1JoMjNrTkUvRVdkZGxwV2xvcTNEMTE2V2RkV0NGanN5?=
 =?utf-8?B?T29XOEZPYW85QW9kZmRVY2k0NUxvRWpJQ0llN0lIamgrUmtXYjJYRUg5YTRQ?=
 =?utf-8?B?elJBeVdkL1dud1RGT0VWYW9kOUlHSUNSMDNrTEZCdjFXeUQ0QU5odElOc0dk?=
 =?utf-8?B?SU44YXZ2dENOS0tRTEpKaVAweFNVSWk0N1JRa01VZ09uVDduNWZIVDlJQnZY?=
 =?utf-8?B?bVh2Z2x6TDYvMjk0alRmRUphQjF2NUdPT0dWWlh2L2dUTmZVR0REOW9sV3F0?=
 =?utf-8?B?KzQ3ZjJoNXoxd29JTUVhSFNvcjFZNnk0TStuK2I3WXhKbDZIRzhqd0JMN01S?=
 =?utf-8?B?N09Mekc1QjVzMTkwTGtkMVlmY0lzV2pmeUk3eElQL3NsMVA0OUpVeGt0MWY5?=
 =?utf-8?B?ZWZNY3B1Wk5RL2g0RSsxdzJJbmgwcEJDSndjMWJBVVhRaGdUMnRSa1BnY09B?=
 =?utf-8?B?bEFuNXNKT21VemdFbHJRZTl2cXZkd1RTejVIZERxUjQ5VTg1bUk4VW1NV0gz?=
 =?utf-8?B?dFRGRzRUQlJPV09oUHI3a0NjZ2dPa20yaVREOWxNdmRsQlpmMnphQU5WYW1U?=
 =?utf-8?B?TXkvTGRROXRqQ0prQ2ZaRVF2Sy9wcVBxbGVwYzhraVVWSWxPOVJZNFUzZ1l1?=
 =?utf-8?B?STBxdWs0aVozTFU2MzlseHlXZkZWc3hDT2lkQkE4V3ZsR2pNSS91dGNDTVN4?=
 =?utf-8?B?Q2tiY1dvelJaSHF1NVl0Tk5IZ0t1SHhubUJLM3hDNkFEbVNDWVkxVWJidmdP?=
 =?utf-8?B?R0R0TjhWZ2FlV1lEdm5YUHh3MlRZTDFSdHp2MDdYTlRYMTNWUHY2QzQ2eW81?=
 =?utf-8?B?OVBxKytYdzVXZHFESXFrUk92aEdKZGNWcUFBcGFmVSs1Mlh1K205Mk83ZzA2?=
 =?utf-8?B?R2c3dGxFTktkcm5xOW0vOUZLTjNTUGgxZ3lqNGpPWUxWdnI3bEJLU09BdW9l?=
 =?utf-8?B?M0RlYzBUaktsbG1yVGYzTEdIVS9lekJKZjRNcGJZTC9wSUtCbjhVT2U3c0c2?=
 =?utf-8?B?NHdnR2llSzhGb0xML3ZGY1RVQ1diVHpGR0lHdC8wdVRWOTRNQWpPQzMrajNl?=
 =?utf-8?Q?+rR+oDdp4Ikn4ezY=3D?=
X-Exchange-RoutingPolicyChecked: wo83sg7YhP/vDf1Necrme0bJrlgdF9MQ1qvPPuN3VFkP4E/5gzuCJMU7am3F7uii2dG6MVlktDLFgMnTNfJmFlBulgFSw4DUKWvkIT6R+NKNKwU7cAypyXxy9hXHZ0M/GtraiVKjOZczmZtT54Yab0b27Wp4sRneVuai43W/t5uAlZ1rBQpCc5Ii+8mvb/bLRmwKT2G0c6LnxJUBJgdIzGLJ6YXvB581nvQMxwGqYR6G7kp5WZdl3JtGZfUXdj1iUGTCJKox0K87O4SLtWa43eNcQxE2LZMHw6a1QB1QtAfNqv/vO69KiNdUSjr1PnPYYuHXFntMrwh9CHGiTx0xqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3adc0e-d639-4234-a840-08df2dfc9cc5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:18:29.6550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cncZ2c8+hLJ5fJZjfLRFLvWuxHxDadpTHykjrozc0jDdpJym5pRMQOOhej0Nk0hY/wANPDYQFjGSXve9Mr0QTcK1WBU4cl8+GyJ26R8ScgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
X-OriginatorOrg: intel.com

Hi Babu,

On 10/16/26 8:10 AM, Moger, Babu wrote:
> On 10/15/2026 9:37 AM, Reinette Chatre wrote:
>> On 10/1/26 8:10 AM, Babu Moger wrote:

>>> +/**
>>> + * struct resctrl_kmode_cfg - Kernel mode configuration
>>> + * @kmode_sup:    Bitmap of supported kernel modes.
>>> + * @kmode_cur:    Currently selected kernel mode.
>>
>> Adding this comment during a second pass ... please consider later motivations
>> about naming of these fields. This field is introduced as "kmode_cur" but when
>> considering the language used in rest of series "active" seems more appropriate.
>>
>> @kmode_sup could also just be @supported (the "kmode" is redundant).
> 
> Sure. Will change kmode_cur to "current".

Please do not use "current" as it is generally used to represent the
current running task. 

Why do you find "active" not appropriate? The text usually refers to it as
the "active". Consider the resctrl.rst text that reads "When the mode is
not active ...", changelogs refer to it as the "active" mode, user messages
refer to it as the "active" mode, the functions are named
rdtgroup_kmode_global_activate()/rdtgroup_kmode_global_deactivate().

Reinette
