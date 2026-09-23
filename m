Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB032B989;
	Wed, 23 Sep 2026 05:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142131; cv=fail; b=bY9SaErpaJsMQFXDqBv0tET+Qlve+3GPo5UJTSeGrt6VZkW07oAK6IJx0jHM/km8kJbGi9ENlEvKG96MLWVBIRQ1CqcD60kbZEnneu2XIFPdNhfUC3EfU09OHV3AAfOa1O6eyO2hMoMDzZ6ESD69uUaHmPsiX8u4Lq+c7Vk9Flw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142131; c=relaxed/simple;
	bh=ECVcRVOgJDLLAnP1L0SFuhKBU0EBGT5rb7v16Jq/DXo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ra6WNg2SCGn0cY3gm/vx4fB4hMm9WUns8Sz3xiP7IYidk+tlh235M4qLgpBwObBXcekeoN7uXpvwYdKcDCs/DoWQD1Vtu8U8Yg1Pk8TBUGoEaLdGWjJQMeKvqeVR/4C+YhtmaslUjZ5pN9aB3gWo08rDU7y8hUs+r/BWCyb2Tu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBv9wMVX; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBv9wMVX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790142129; x=1821678129;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=ECVcRVOgJDLLAnP1L0SFuhKBU0EBGT5rb7v16Jq/DXo=;
  b=aBv9wMVXu1tqvkAvmQZhy+X7t95nY4f4TMEc8/V/GlOnJFLhsJFcPEvk
   eHRUebjsULqtD2wIuUk6FmtzwN5xgQN+JKiGM6Ii/xl4Teg9kkSnxYDyw
   3pdo1lELw4qUfFNpJF/d3xYbOc7KAfeCUmi4wd0tvyt3OZWJCL70oNog9
   zPGqXCqNN7rEjzNhX1l6lUf/T0kzxsBhrCPOeVof8lZ21g7UJg8lL0Zgi
   +GFq7Opeoq3aRlL1Tqism/3NGRF0dsYhMFQbNYt4r5yOJ8snDkqAzehTB
   k95f0iuvpHOd573y4njE8km6yK5nMHglB8LXNT3cRpbB6xFTqasAhf48u
   A==;
X-CSE-ConnectionGUID: TOOUAw9TRnqSK2VuBOCatg==
X-CSE-MsgGUID: yaYZb/6qSMqeh49/Y0D2Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1297301"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="1297301"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 22:42:08 -0700
X-CSE-ConnectionGUID: cdxJUSbsQmOP88mcwvKNdA==
X-CSE-MsgGUID: RxY+CltzR1G9u+KqoVOC7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="301372104"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 22:42:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 22:42:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 22:42:08 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 22:42:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBdrRrKNAySCEF35QiALAdCHpSSXb6MWVm6ctzWosPj7i2TUu72mw0stWCZH1xnkAInv4uaM77XpSm3Dx0D0/e7UjnwOFnt3UiuHBCNLW6/VMyHFNnDCtprGEPy5gV0MXODW0FHbNqHtXDZb4Fs+L64D75yWipKQyKWyjuMOjNHGfsSJR0r/MSx1XwtGTTZUYOXZOMo2zJs+pBkTcNT9zr59CFHOBDfmMLZ1LTZTXWzwmCQ6ZpIaoC49tRcgO3/b4Xe+xt4sIBh2/ELSJRbBeviTVMS2orJ2qZcD1vp2es3dh5mkacHrDwShM2zpZM6xLqubblcH5dCGk9tF2j+ycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piuHRymx7qeFG5BZm79iLEdIeH4yn50/079dgYvhB9U=;
 b=JGLtuSoKqlEoqjFHyHwUCWKTxBxrTSYd77dqXI0scPh4G/ZPNzHx/moMslmQK+h3W1gAZFfU3+UyJbEfIxdvxtYsd4Q8BKMsHvHvMQLi+dIavSSPAadgVzQ99m4S3Wv+C/NEl3jUS8v+5UR7Mi/esdG7Bb/Iqf3CgijaavDE0yO4q6M5boRbkECJ9UrvTqcc5jQhTfVmZeL2vq8BwkkxlC0d8d17tArAHXHByKzn33ThuGoyodW7d5jtwatjRNfQEysKgN60xy8IwrwtzQJPuLKY5zhk3F4Juqc2pvZ5jiFUCH33VK0zWSx2meLiT+yw5DyRvQyUm2oXftVh8kqxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by CH3PR11MB8434.namprd11.prod.outlook.com (2603:10b6:610:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 05:41:59 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 05:41:59 +0000
Date: Wed, 23 Sep 2026 13:41:24 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <pbonzini@redhat.com>, <dave.hansen@intel.com>, <seanjc@google.com>,
	<x86@kernel.org>, <kas@kernel.org>, <adrian.hunter@intel.com>,
	<binbin.wu@intel.com>, <xiaoyao.li@intel.com>, <chao.gao@intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
Message-ID: <arNmhCROSxo2H/kO@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
 <20260922205215.870563-3-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260922205215.870563-3-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|CH3PR11MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: f478678e-cd19-4f16-d19b-08df193562d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10063799003|18002099003|22082099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: v1bmfPN+DFuRktth+bAdqZJC4mm8GkgZQCmXkgJ4L3ermYGMCbnFou2J5Qw/qo+lESEOtiBDchyICrAP75oY7k+qbCwiFUIH1jJxG0Jhop8J7uygKjbm7+HlX/vcFkGey1CUSOoY4ZnNQB64RZrkUIdlVjff+M8jcYKtno9XCpQuD3LZAWMfyrcf+o0M9AY0QpvrjaINwZR6htnOjR7gOhXxZPGKIbIOctmqCVSpK1dOjNtJeFQTAjbN2Q/3Ri2lOlCEFcsGKerpAvCaNN0oghwNouQ0qNq+47n1EmfZssykotI4z3azrVe0/FsxUVSPhdEa3M++T8s6EyJtKq7rUIKYhcwFCyoZc5LLVcoxeSyzvssQEgbm/ezzKSpIS3kMIQSk+HSjlZC5xresL6L3i36YVMN62Hi76ERZZJEkwMGYBNPXhuo5dKowHCHeAIcvFYvzDM+iD64c0RR7+x4R27CvY/O04lQxYYzI9Bk8rHakU7VZxuQFUNDLpZ8xox6UKs/D7/6FPADbt506hQw7J4tcpwJ2mCTyTZsfX7qbTDiYWH8wKCdp2Tu+Hf4PFW9ZVjtOEpAfqDQUbJyJ6UH3C1sihGdrcnVr57VkWOD7iF/Z+bKwWY9ah6DwxINYxsUx+OCxHBoZlIO0V1q9c4dPFWSM4HDnJYSJd6oMjol6mH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10063799003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GvOULH/HXj5z7oA2OM0iNp2GTVPX0KhbXQqjbGAH1us9Ke2mnVhC8Htrk2Q7?=
 =?us-ascii?Q?sYLI0JTul8Jpb4A/FoEbyfZ3us426pQizzT4kRxq8NqiWVuKdH9uDlLzNAQL?=
 =?us-ascii?Q?udsbiZRibvcahHK4SFr9qrwBpwQlR4ga6j0IyC4VkkxatzthfBafIkIWl0Zq?=
 =?us-ascii?Q?AiUJLBOvQ/oKt90sWa/YSKCbKRwo2FM1zQW9f/YOOV8jcGRZpjlt2iZY9Dge?=
 =?us-ascii?Q?GOuwd94CV1MBLHofZI8avzHOMIOfx3bUIFb6Tbmj9Q9dAsiN7kHjnX3ci+va?=
 =?us-ascii?Q?k5//qDiXxWpBP8N6JL0jJ425vU8i+0zVzxRW/ar5bodXzrRnia08KN1RNbXi?=
 =?us-ascii?Q?TMkSHg7PF0viJmgHgR2HyssFgDN/ZvxTGTqt+nzHM9/Ii55NCEiPidmXX3Po?=
 =?us-ascii?Q?J8EA4NCCaBzVXfitE4cHl0l8pYs4Rl7MU6UcSRG99iEbFdgiMrTdN+RX8iKK?=
 =?us-ascii?Q?KM6NsSFgm05n4oVdy+PgUu9YfHSsa/DII1z1mpZtMT/GAfzatRMR11GXwuv0?=
 =?us-ascii?Q?H7oqqDQAqMUvfkvsGn+fUZAfi4VYIUV4dhpLWW5kfG8DwUsm/0fWF6cxil2k?=
 =?us-ascii?Q?wXokS0fNwfV0uBUV50+CL5LkoKgl0mgLMXg3H5bdeJg74ouZkGypBj9X/lZS?=
 =?us-ascii?Q?sG2r11htNueSey8eOeOI/LVPg4lqnJlCgqBusN9qrtHgYOCt5eP2q/sqlPpo?=
 =?us-ascii?Q?GFp5un83ACFOb/qoQbOEmzCUmVGUcMr/NmFF27o0XsC6uDXvDQ1/BQm1rFF6?=
 =?us-ascii?Q?oAvfToxlUoJw3gtBHqDzxO4NmFfGq9BVraRz7s4B2xKFUz50J481fpUlk9ep?=
 =?us-ascii?Q?CYiJycnH34l0CeUljx3YmqI5LFCsDolBQolcdNJUyULeqvR4zOv1fERBBu2f?=
 =?us-ascii?Q?MMJcBPXjzqbBNuuzykO6zLzRfxIX7+I5O/gdJWAfRmWzpUmxcvzaqhCTyPxI?=
 =?us-ascii?Q?ZLF7Lpal/uG8bnEyJdGRTkef1t4DeEyZA11KYKYHwxjllIXzT5Gs2z5U3/y2?=
 =?us-ascii?Q?TghAeomq7uTwB7E8vfrpvyB3c+Al5HOnr+w83o0S99XPOiNsbrq/hs8dlTkx?=
 =?us-ascii?Q?d2R3PQV9HSjPJPDwwyY48KkgKUpU/K2muG+ia8iLISLLxmQpVSzsJpqQ/4Ic?=
 =?us-ascii?Q?0mpDZ9tXIoA177DWqd0H/pvAf5cC5BhCq+HYeOK9ZLXVUsGoRdxDs57vMZrB?=
 =?us-ascii?Q?OhN8k9DJyde3wZ6ijozrljTb2tPREcRQI+MfYfhXLWpcrGJDOAhpEuVu2Yk8?=
 =?us-ascii?Q?58lB0PsorG8y5wM3OXpvv19+Qt1PiHyjGKZetyekQiIQIAY3e8TJwFFODA4V?=
 =?us-ascii?Q?dI7pE/ox/CJGZfMTW9a4fjHenZ8tBshrmnjR7ZGHmlqf4ysjQd3iacH0tLsI?=
 =?us-ascii?Q?L0Q/HOeuiQjVf0IoZSuJjJLkWV4BUniijNiSMIG36TxpV2M79noIpFmC7sWB?=
 =?us-ascii?Q?M/qs5m3KyIHJPLaox+kf3tUTP8nv5UwDZM4x/RGEGXTsSQu521Kp67AJ5+lN?=
 =?us-ascii?Q?M33KKU8Gvw9fj9toWy+KvegxmPhHkwrfsfdezFP+ZlRv0iC1M2X2h7p81Cwe?=
 =?us-ascii?Q?9hh6mQX4kB4/9ejwgQd5WacPufGVTackpVaDMz8n7V6zYmMcNHeQhV4n5/Ua?=
 =?us-ascii?Q?XDjbKp+QEbOspX6+o2VZWnP5eB0Ry//VCvFQwvbfT+3OYh/klrfa5g8Kp/wQ?=
 =?us-ascii?Q?zYMJ6x1vOnkiuY6LofulaodJ2CnDSCIaM+RVkrzf2lR9OWAWs+lbE+yERtpt?=
 =?us-ascii?Q?U2BYH6CKDA=3D=3D?=
X-Exchange-RoutingPolicyChecked: aU5l5jT2dkh0/ovgMHjPbFe2G1LTWwt+Y33y9LInFe7SqceJsHuRKNX6opNiBfeAgDdCNsfHvGz5YUhK2lFk+bzT8wYWn4EMZo495qxmWTYyVM2ypVeRqQaXkHqdNDexWGOCKT1/qgcYE/67rcNb5cWMPmhdmYGsC461OMDrNtzpwA+2+BnFd6D9jJJPUhE56dMgYSxqh7mwv14AXYnABqj8G1XsQSu+B08EbLpoVHYgX1KR7ndSVDJAEABHroTJ7cJfWxVfe0NU8cRNL7ZDA0VgMnBVTRWxqOxn2B5IOZScxTaUzQdbf2wy6BRc6k3AMdbtgUc+KO8adjOIaU+EmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f478678e-cd19-4f16-d19b-08df193562d4
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 05:41:59.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEcgQ2o0aZQUqTzwEMyLVICUrjq54zUmcShH88UQ9yPJ7odSNXCEwwEo65U4OpZP9BxgEDurrYyFEn+hIUpQNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8434
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 01:52:15PM -0700, Rick Edgecombe wrote:
> In the early days of TDX it was expected that pages being reclaimed from 
> the TDX module would need any cacheline from their private KeyID alias 
> flushed. The TDX docs describe doing this in a couple cases, for example 
> reclaiming the TDR memory:
>   Flush MODIFIED cache lines: this is required to avoid corruption due to
>   cache line aliasing. Note that all cache lines for all other TD pages
>   must have been flushed before the TDR page was reclaimed.
Is the spec quote necessary?
The mention of "Note that all cache lines for all other TD pages must have been
flushed before the TDR page was reclaimed" seems irrelevant to this patch.

> For a similar reasons as why the CLFLUSH_BEFORE_ALLOC features0 bit was
s/reasons/reason

> never actually set in any TDX module, this flush of the private KeyID
> cachelines turned out to not be needed by the final TDX solution. However,
> the TDX docs were never updated to reflect that.
> 
> Since private KeyID virtual mappings are reserved for TDX use, the TDX
> module has to do the clflush itself. The TDH.PHYMEM.PAGE.WBINVD SEAMCALL
> leaf was created for this purpose.
Should this paragraph appear before the last one "For a similar..."?

> So drop the kernel code that calls this SEAMCALL and the two helpers that
> facilitate it. With the removal of tdh_phymem_page_wbinvd_tdr(),
> tdx_global_keyid no longer needs to be kept around as a global variable.
> It just needs to be selected and provided to the TDX module during initial
> setup. However, don't churn the code to remove the global variable because
> it fits neatly with the other KeyID partitioning global data. It is also
> foreseeable that this would be used in the future for other SEAMCALLs that
> require the passing the global KeyID.
> 
> AI was used to review the change.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

For the patch implementation:

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>

> ---
>  arch/x86/include/asm/tdx.h  |  2 --
>  arch/x86/kvm/vmx/tdx.c      | 14 --------------
>  arch/x86/virt/vmx/tdx/tdx.c | 26 --------------------------
>  arch/x86/virt/vmx/tdx/tdx.h |  1 -
>  4 files changed, 43 deletions(-)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 89e97d5761d89..39e3c1f8a48e1 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -174,8 +174,6 @@ u64 tdh_phymem_page_reclaim(struct page *page, u64 *tdx_pt, u64 *tdx_owner, u64
>  u64 tdh_mem_track(struct tdx_td *tdr);
>  u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, enum pg_level level, u64 *ext_err1, u64 *ext_err2);
>  u64 tdh_phymem_cache_wb(bool resume);
> -u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td);
> -u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn);
>  #else
>  static inline void tdx_init(void) { }
>  static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index b272c20586a74..51327b5d5784a 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -550,7 +550,6 @@ void tdx_mmu_release_hkid(struct kvm *kvm)
>  static void tdx_reclaim_td_control_pages(struct kvm *kvm)
>  {
>  	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
> -	u64 err;
>  	int i;
>  
>  	/*
> @@ -578,15 +577,6 @@ static void tdx_reclaim_td_control_pages(struct kvm *kvm)
>  	if (__tdx_reclaim_page(kvm_tdx->td.tdr_page))
>  		return;
>  
> -	/*
> -	 * Use a SEAMCALL to ask the TDX module to flush the cache based on the
> -	 * KeyID. TDX module may access TDR while operating on TD (Especially
> -	 * when it is reclaiming TDCS).
> -	 */
> -	err = tdh_phymem_page_wbinvd_tdr(&kvm_tdx->td);
> -	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
> -		return;
> -
>  	tdx_quirk_reset_paddr(page_to_phys(kvm_tdx->td.tdr_page), PAGE_SIZE);
>  
>  	__free_page(kvm_tdx->td.tdr_page);
> @@ -1814,10 +1804,6 @@ static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
>  	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_REMOVE, entry, level_state, kvm))
>  		return -EIO;
>  
> -	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, pfn);
> -	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
> -		return -EIO;
> -
>  	tdx_quirk_reset_paddr(PFN_PHYS(pfn), PAGE_SIZE);
>  	return 0;
>  }
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 8f9d3588f200f..21f7fce38aa46 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1956,32 +1956,6 @@ u64 tdh_phymem_cache_wb(bool resume)
>  }
>  EXPORT_SYMBOL_FOR_KVM(tdh_phymem_cache_wb);
>  
> -static inline u64 mk_keyed_paddr(u16 hkid, kvm_pfn_t pfn)
> -{
> -	/* KeyID bits are just above the physical address bits. */
> -	return PFN_PHYS(pfn) | ((u64)hkid << boot_cpu_data.x86_phys_bits);
> -}
> -
> -u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td)
> -{
> -	struct tdx_module_args args = {};
> -
> -	args.rcx = mk_keyed_paddr(tdx_global_keyid, page_to_pfn(td->tdr_page));
> -
> -	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
> -}
> -EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_tdr);
> -
> -u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn)
> -{
> -	struct tdx_module_args args = {};
> -
> -	args.rcx = mk_keyed_paddr(hkid, pfn);
> -
> -	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
> -}
> -EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
> -
>  void tdx_sys_disable(void)
>  {
>  	struct tdx_module_args args = {};
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index bdfd0e1e337ac..3289be59d14fc 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -43,7 +43,6 @@
>  #define TDH_SYS_TDMR_INIT		36
>  #define TDH_MEM_TRACK			38
>  #define TDH_PHYMEM_CACHE_WB		40
> -#define TDH_PHYMEM_PAGE_WBINVD		41
>  #define TDH_VP_WR			43
>  #define TDH_SYS_CONFIG			45
>  #define TDH_SYS_SHUTDOWN		52
> -- 
> 2.55.0
> 
