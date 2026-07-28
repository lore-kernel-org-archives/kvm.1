Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526483AFAED
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 05:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785215784; cv=fail; b=iOoUo4zmG1pQ5qYD/5ahtx0KXfbEjJqCum3yzQTPyjSZ8s0XvzQK9sTxHCdnhf3S2PaQkLqgRm7HS4EfXnnGDEnvWy+T451vOhh/Ze+xdpNzFLjOxvjlhYpJtHvq3sgnVLciIn4BaeggqBLKkde1R23pjtwMUpFQ3C4OrZfrHVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785215784; c=relaxed/simple;
	bh=cRSe/GJJoJKL5Kr2NGGHJ/acG17srqr4U0YnE5/x6fc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GmGdlQ7iYmfAwE6z0eDlpoacEgxmn3GqKUjt0gfYQb3DkfDJ4ahMlqq5UzLku9qAW3TW7bB5BFxmRQbv1AZBu9MkxjuS/7Lj/EzwV2CHUJJX+/qpPScJ7nUjrudjgcfqrSD44rioZaTdjuZn0yevYHL0j0+KxDg5z967v+EeTSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4M6Asik; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4M6Asik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785215781; x=1816751781;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cRSe/GJJoJKL5Kr2NGGHJ/acG17srqr4U0YnE5/x6fc=;
  b=R4M6Asik+FGL4dJVMDfZmNkP9BgUxxAzJ/3+O00dnZXdrKTe3CKyRWFV
   oqWiVLrsG67pmN8NkXJlkgrlniGztEvhK3SNfJPUqOWEU8woAbcJNDHGK
   3kMxtB9CxONHPDxv7HYL6CcUQsesmjjnFFvvYWQsCoQVJ7M92nNnC8pt1
   sl1pm5Iz3444KG/bwJTl0r68XQU8AyUQNY69V/IV09klHCgG4P37zsrHl
   CeZggzZtU72gJpZvTuChOwE4TCqfiITPMTgiVbokTpMzcczkSFVuLtxhz
   7nYEP2VTIuB6Zief6R9cbIJUXuTfOURyf0o+eJKz98dsNeV3CBeKSN3ne
   w==;
X-CSE-ConnectionGUID: LI9wqezDRACtsw+e/vSQ6A==
X-CSE-MsgGUID: /I4DxXYeR4m0nEgVgu5OVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89463396"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="89463396"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 22:16:16 -0700
X-CSE-ConnectionGUID: S17Eo9FaQZyd50Xi2AfD5Q==
X-CSE-MsgGUID: u5jt5gVhRwqQ7tAK+HV4tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="255295640"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 22:16:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 22:16:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 22:16:15 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 22:16:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMnOXBder+goa19IBkrzoVq+QL0pJOpry6WRYqqYA39tDxCtVbKuEEVRtrzY/vlmrSuez9nQyvPEaCuUQcslTIJURVtjt9yBYP1lzEXD2PY/wUDQadJAX+6jGXhXoCoFjfOJSdr6LmwtyudPQnk9dGaoqBDCCBucWJYzETzoVXEGl7Q57G22LgpClc87n3Zil7FoX2f90H23g/5VTgJqXtzE5FfWWsQKPWpSRr5ltZXTUtp4AFdIRvP690dzKJe/9cn2/InS0nAH8j4YnDmUASKWDvWEvi7wCYcmqm4kmkiRQ81ZC/5Eq/ytUzAUGTzS0SFcfjhmXy2vcAmEIpAKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+Z+aaT+LFshZOMx4UsFv0yg92x8FqRb9WhJqqi+gUc=;
 b=ITH3+zaiGQl9+EikoAGlurHtjnJlEp0KUmLX0KsxJ63m/+JttBlTDiQ1q9ivLw/OCCsC7jQBurG8ceI+MPiM3Pt8QRalTCuqstoOGwNZbiOCQQOEVkTRad1y6sIpsYsHYYKoMj8yIShk20XEDZF+O5ZIRS9dP6N9xe3PzKxu7vKxXSeuUfybsvttC5NrRVO7bOL2k28qd0HW478rEHXp5mgP6P5xrOtYLEI6qIxdoE3VcnW5midX+OO5f5cICtxYG3k53FHVx/Q/1LsJSd4GJ4XQXQTpvOBz556jfzJNaWlkgv9y9E+L4szlOZSgJPdlrKutx56H0arn9rNMEB/JEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4450.namprd11.prod.outlook.com (2603:10b6:a03:1be::20)
 by LVXPR11MB9705.namprd11.prod.outlook.com (2603:10b6:408:387::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 05:16:08 +0000
Received: from BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068]) by BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 05:16:08 +0000
Date: Tue, 28 Jul 2026 13:16:01 +0800
From: Chao Gao <chao.gao@intel.com>
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] KVM: VMX: Bury all of the VMX preemption timer
 code under CONFIG_X86_64=y
Message-ID: <amg7ER/JswQUpqk/@intel.com>
References: <20260724234914.987987-1-jmattson@google.com>
 <20260724234914.987987-2-jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260724234914.987987-2-jmattson@google.com>
X-ClientProxiedBy: TPYP295CA0024.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::13) To BY5PR11MB4450.namprd11.prod.outlook.com
 (2603:10b6:a03:1be::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4450:EE_|LVXPR11MB9705:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cfa696-1df0-4123-e299-08deec6754d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: f0BR3akM0U0demAzMChZHpwS45jCzqGGVXjFhIZ4n8iFnWfJFSFo9pbaynZYf2K2rqNy/YCqVWfS2CaZ0ZZrpmRgW757KVCLatJfD7qMYzmhYmO8fh4a8dSQMd6wYzKGCWw6+gRGWV27iL9r1qmIPjT32eAX/5/KW7aLMBLx4Cab1GGYID42KbEfOWIokF5bgKGPZQEGl1MMO4XCPlmP10s8Ud0x/B5jHuUFCBHa6v0AF2nQ8jDO3qyz3HNdkws0RszGhZxFtat329lvP4W4nbbmclW9NduhxChBO5iNq2hrmxBva4m50MVE44mDcBu9rb3rrI3ur92RlOtaQ3z4JxlQUxtRXYklefU7+Jo/WSkOHFrYGkSGUkCy2j7DplPxQdOXip1OmesjKZDnTiS220mYr58ZH3epffdaKbiQY7ivH6O2h6ycpOIXnLBJQeAWn8z4jE4jKtmKN+ZXkfODOsrpd0e3ALupi/N0c8ZMEuUhG+eYe7rXqp9sZo/q3zI+sLuTc1wubioHYjqKVa7gaSdW9NJl6vEnWdelVqSGTawrIzhnvgpKWtF606Ys1tkCNj1AV628CRANya1BfwjS4cJaoEEFYNwioJCOeK7MWlVXVOdWtDRKptBX2ILqvHZs2rN6be+rpuB3Kv/HuOSzkVMMcFI/XIYLRrnXVKnbcd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i6PKn4THmqGQbceSksl4oM00cicbV1X6dxDMkQ5e4DXrFqOWNHART9WgiO7A?=
 =?us-ascii?Q?0J7GS/NSCla6KX1ITybIFVf4cmi6vIZoQog+mi5S4h+3dKaHTGzVdrBb4qo0?=
 =?us-ascii?Q?CxQ6qwSoBqpMdmnIroEghyC0G1lU0HvYlJg+b2I8K/ZhG/uselBQwnOvfQh+?=
 =?us-ascii?Q?CA3vL8ObXTFsSN3+d2odqOOcZ0j8S48fHrkvTpISmgFmFBOVVmA/ssM5NuIG?=
 =?us-ascii?Q?rMAk7p1PPabwmcNAYR23BDZUfkhsHMq/Vvx0i3rp6Qpp7t/guY9Mm8V59MGr?=
 =?us-ascii?Q?3N3a1Lqs3FUz6FJV9b5qpTC4Vc/RvJCY3ZkVs0+2zw7b+VPRZs0awndZllmM?=
 =?us-ascii?Q?Ei2pzd1eZThoDzqLjtaT20VSH/EM4b5Rzu4LfOBqcFs63Gnf7zWSIMe2La/A?=
 =?us-ascii?Q?cQAqxUf7sQJ0k4zjfb0T+rwYkSH31lgBS6/znn5v1SWoByFTirAvmtkgbhuJ?=
 =?us-ascii?Q?xAmgU+VJDFHKgP4LJNVqn6kXA/44g011sG0PKWkd2jNrIfm3a+c+x/pTieBz?=
 =?us-ascii?Q?EiE5AuTZ4+jL2VOYu9V6AYeaZjZNlntSyLGfl6pewFWQndZghf50II2aVKMf?=
 =?us-ascii?Q?aQsKq7zBfYwvFRQiqP063GrUTfH8h30Zn0z5VLq6lNzjbxk2IFBOlM4rXJHw?=
 =?us-ascii?Q?ZTv9up2IoWFtVvK2Z+32MYL4si+hZynm2ghM9mZ0/raGhXq6g4+FVtan7W6x?=
 =?us-ascii?Q?/bSOn2rOvVo68OU3oWegeCu+lC5heMmD7BS8knqjkpxPXdMHSZ6801SxlO1e?=
 =?us-ascii?Q?SKH7MeHzsDfUA5UmKwLHuU55rU/aceb5xtoJcZFCs0yJtBHjws6OjaZHDMVo?=
 =?us-ascii?Q?41qVqvRUredo3jHgGMy1V+0FhEqiaTVsUEUABOorPa4WAsmIf7WRbYD8Knsa?=
 =?us-ascii?Q?Rf83Sg6hJzVXdm8oh9sLB91JjPaQpxHvOoOefJkKHpbzlNYFq5w7c9Bw8Qrr?=
 =?us-ascii?Q?g4DIDvGFuSpt6AA3KK8ZDGDuZXWP5wZb7I8nT5KeoW67yRSbz5dUi7qsdh3s?=
 =?us-ascii?Q?v672f68H7o28w1DZUi2O/YKBCOm5MOYiYBEC5cQTwsb2TmATt0s/cVCQcnIE?=
 =?us-ascii?Q?Fw+PoYHzDSGWUzZnTMb9BSgENDRhq28uyvaTc9yNYoslgba0UhvwRmYUeltw?=
 =?us-ascii?Q?DfEBA8S9QXYIhVhy0EacCa1VFN8VjPJ6+WnTgkvwc+5iE2qeAJC2opDkyHzl?=
 =?us-ascii?Q?lMRgO1ttqdV0RPol6NyyYOs6V0VBzJ2qbXa7sbvdu0i06SjOT+vnOE2Oiqx2?=
 =?us-ascii?Q?EgQIU4fD3MwheJubR9B/YtyoapYpg0K379F0Hw6e9slEevvBEL7886YvTD8m?=
 =?us-ascii?Q?hhSPBXWeOsohOAwbvT8DhB7/rBXk35s9KgNmSoiA96JRRaIkPKgzxh7MSY0k?=
 =?us-ascii?Q?BSluONyTg+mURt28+vMhcWnzKVPFif01mNqJZaNWgM298pYfKIeUAcbOctZW?=
 =?us-ascii?Q?7zLDawc4UgKdDwmCtg1+TsKRo5nlA3j6wsui0Up/H63IqSrBGZv1kovjQfd5?=
 =?us-ascii?Q?Sxiy02h5FtZflUAsZSUwBqtxycrcOXL5yh/kytsDQmWyV1hSVAxZLvsSJ9Bc?=
 =?us-ascii?Q?k98S4bGnHvRnTrmvx3Jf7Sg6r4cCDfzJ1N625vYHM+gQNBsvxwJ5q4RBKgt9?=
 =?us-ascii?Q?fYcQAE3Qc28xOf+hL85Sa0HXWvXgSKZWsyr5uUHmV+6k6vUpWoQNJLBI5qI7?=
 =?us-ascii?Q?tDXPO2DXgXyVLq8c/MkHPkgCicVnjqZNattvXBcv395dgFM0F+8cRmHe9758?=
 =?us-ascii?Q?qR9f/DeNvQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: JiWXGu8cyODOu+vtMmkpBwxOcCwp42k6ob3cESXenwx1iuK5rkdMByq1k5e1tlMFkOBo8bKFZYgdGqFutlPbGj8bBtZ+Zveea/f1WpTOTmiN8aH6LIUDWYq92XCISB1bGAyVPfrRu3eJn+WSOm/46L60+tEG4IOBiXWj6UhR3HfYZA9Sr5BuzrVyBbLJR4foTNahbtA4bs9D6wSs6CuzgyVjdcb2gPo8c6DSfdHn8LPXRbkfvQdSLRIYKK+/iAdDDeoIm0zJMKgGyhKVFkVGFN1JGjp57zeJI7hEps+fWPWqxdGn/SV3hmCbHTPzJlgwldvDA4x7jTfRKSXZPPDweA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cfa696-1df0-4123-e299-08deec6754d3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:16:08.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VL5eWIlRWK3CXLXfNEMyXi3T/TbR/fl46WXud2gb8mtIIfszooH5ML0Jt2G2re25cFNvQ3e+3fcyr63FJZIGbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9705
X-OriginatorOrg: intel.com

On Fri, Jul 24, 2026 at 04:49:13PM -0700, Jim Mattson wrote:
>From: Sean Christopherson <seanjc@google.com>
>
>Double down on using the VMX preemption timer only for 64-bit kernels, and
>bury the setup and runtime adjustment code, and all global variables, under
>CONFIG_X86_64=y.  This will allow addressing various Intel erratum without
>running afoul of unused-but-set-variable and __udivdi3() warnings/errors on
>32-bit kernels.
>
>No functional change intended.
>
>Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>
