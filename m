Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B873FDBF8
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788419111; cv=fail; b=fj3BBJuqMUt+sjTbHh/fCi3yfnaEAst0/4Ru4dYoISAe0+u/Uinr9mD1tVmhyV2AED8aEFhCln/U4UXndgy4A4jqmcxB5FuFUYjveiNA2AhxVL1GZAMwFrxOc1yeXAYcZmdso2o6w6gAHut7w3zS3l0/bIxK4k5b6+dbz0Gyp4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788419111; c=relaxed/simple;
	bh=oQhlzxswRQ70DVYYv50xHttkYMor2XH75szKd7AXYnk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BfjID1xLfQ9IPex4UrL7xNYIqc/EM997TZOQ/+hwhvLHN1CDf9ZZ0msIp95PyCemIkpZFkIi2w4pjHpDyQUvA8dnDxcdFZlEZpgBPRaUp8VbqoCWWZyJiByVfnP0TAE8uUK2MvWyIwhyLIoqdsi+xY7lWi+Ej/vadDaaokdql6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0VeunZd; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0VeunZd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788419107; x=1819955107;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oQhlzxswRQ70DVYYv50xHttkYMor2XH75szKd7AXYnk=;
  b=a0VeunZd3uo7ioeQRJOyTpvcqcQJzqBXg+JJ6ioJ3eIIrluIlWp+cw+X
   iUb1tyltW0EFwpPXEzLnC/ywgKJDzbGlO7sYHTUB7oVyKG8TJ3E2x2L3U
   H1ITmXrabkn0BfjOhLIa9UoFtm4h162j79rkEFEZC5thrO59ef3GcFn4f
   jnPVKqzaj+nI+NwUITMkgEz5PIEx6k8EA6DcLN04C3YnfEPCCu7pb4Db+
   E9WK2xo1uWIjl/+afRe5xkCIDUXK7rBte2z86zMLuEq7LvGwhEBpbAnu3
   3uDj146LYfmr0hmG73FK4VloxN/7Z47ii7+0fhLk2uLhGVqfQNULyFYJs
   Q==;
X-CSE-ConnectionGUID: 8AzajS35S12oeDq75ocFQA==
X-CSE-MsgGUID: SZ3Z+Pp1SvWZhfULza0VtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="106256054"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="106256054"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:05:02 -0700
X-CSE-ConnectionGUID: g1Wy6/14QYunWUhKuIOkcw==
X-CSE-MsgGUID: +Su92CdqTs694G89dSb0jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273131891"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:05:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 00:05:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 00:05:01 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 00:05:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYvGswrKB9DTb03vRLvt5BUPXYSXWLQFG/w/6HGL7FyybgZidssVNR39vz92+xbjrOpqY4XaLIiHl5UYwFVa90vJ/X0wgw3vmbWsp0gnI+uP/v+nm3ovO6wy0aV8PToyIR4wG674bVwgR/E50u+h1dK1Hco+OX5Obw1T8uC0rjCt38zwJtb5Dl9yNvC7bdkrrhXAU26RyfogGsgireiQsbMwmCmNmo6OcQRoXWhz0dmwuvf4dh7QLdRBeRZkZBZQtAiMrCQdkWiMgOk4N9qCZus98jP1o0vZZhJUtvxMAr6tcBD+/vUS8SheApGnlGYe8zWlmfQYdWDJ5mWJL+yyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVwSW+BU+fVuemAMU53FGGq5C+RTG+MHyLcbS86IIOc=;
 b=c7p/Ts2aEXnOK+Ma56umFR+JiMH3E6OWh861l3jhIZE527OS6LAAgf3vRkhGgnd6ioe923nWO17BzuNHio2R5T4pqG6qalAAWpTBGi4VQxCDOksj/BNj4b2o/hCkPYxOloun+DLsofI451+yBZ6w7o/iJIRbdg4E7AJeQMbsjEyw4lkATsaAcpM+RgCIX1Y8uKg2mM+Ku4258wElgCgm7WgDea4i7M6v6SKyq/LBnChVZDmzEzNuOL48CXM0zasKf2IXXQgCH7DeF6oNL76ws8jLiHq0GhtVrR1DsNqAMnPdS71A6sXPmTTInpv5B8ZHaj4OKPWVvZwvxi6ml9kz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DSVPR11MB9960.namprd11.prod.outlook.com
 (2603:10b6:8:3bc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 07:04:59 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 07:04:58 +0000
Date: Thu, 3 Sep 2026 00:04:53 -0700
From: Peter Fang <peter.fang@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <apkcFclEw1LNd96h@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-5-peter.fang@intel.com>
 <20260729125524.48FD91F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260729125524.48FD91F00AC4@smtp.kernel.org>
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|DSVPR11MB9960:EE_
X-MS-Office365-Filtering-Correlation-Id: fa084895-d1e2-4863-7f7b-08df0989aa8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|4143699003|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: ev0nRNDq2wOyuxGz1oms2eiU35w5phVkKuORoqyhz+oCfsj6wEceENGeZImBPEkEhMe32XWhmDHDbpd5s1PRZKV7wFga+WVnWoXgrhai80Ir/mcqSzxkpBvRionJ+aul7NPvw2G3wR2iemy+tui5d1lM4LOaTl4GEzBzDCLdlujXsKV9JHZw+N5RfgZActdn2NkFfgVmWFBobjWEGfXKRQuHDd38rk5guHG1+DFPkYd3lYzt90QN78XinMhpEP4jCgaL4lXHKNdttRQqAJRQ6NM6cYHwyQbNxJOzi3d2Ajn8MN+MESRC9dENg8bq/9BdGK/qGJaTl5ZJCJLoeFUApJVi7YZkcgjlPC8UGudX5S+zF9ckZE1SicRLY1Pk8RaG+VHKd8wN9Te0l2LhZ+8Asok/MUymfIgylAZkT7JBN0V0KPHlFiUz0dX5kwf7FOcaRz3EjneLXgSYDASX84joL23Nv7/ISLvSelCxzzYegPy68/sVEzeQ+IpFGP5HhkdoUriXqGks1HUFdpTTQJMyF7/RWnwPTPhCVsdtCZ0uXmaCzor5EGKBGAF7xu+lkHjls9iO/S7VBrL+BEh05spvsDAFxLsuScQhxf5FS020ci4MubcHgbGoxiNeCaOVhVHTsp5Z8gD/wQLz9KkwK/ulBc4Um6oOoKfjENiR2++1Jnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+gumhISSu2dNl0tTkLwqgKnphuq06CJqQpnrbjFyLhSDaauH07nWibwJXwiG?=
 =?us-ascii?Q?6DiSW97IMHzjAZs56cBzLgOEXIHfXCBbHANAn06m+zwIffWLOZUiugE31+ZW?=
 =?us-ascii?Q?/vutR5Y6XanTO4q3qmB5722LcW6sBigeja20iP/3eDz7XWh7BmJ/eAAivJ34?=
 =?us-ascii?Q?IyXRNa9Vx94P4crlpdKLqasTtP/UbEdXfTml5oS3d5Jft1Qb6REZ9VOOV+7T?=
 =?us-ascii?Q?bkhGGXqTSqZJ1A1LlqYIpErJunh5BdgHZCBUfUrtUJRg7XhQTSM+JaWPlrpM?=
 =?us-ascii?Q?gE0CI72BPUBB+QEH4/JemvurVzntUfW1q3w6UDUImgT1BlpzXOVmNg4sMohD?=
 =?us-ascii?Q?U9s1joV7eflxHT/XaqC26nlviL+xpKmEwFKgtXoE3Ddx1B8F3L5ofW4v5kHw?=
 =?us-ascii?Q?HRcpiYh9593jGk51AWdEPMacjiG/9Py2FCmE75baI++2L2iAErnwUxB2+iqB?=
 =?us-ascii?Q?AKUOx/0XQdyFqIuCuQ/kVvlRpdx9mOjOvEWdDebLpFdm818zlrOtEJ/KpIk0?=
 =?us-ascii?Q?9n8yGBnamIKj+hs1/FAkzYeBb4KuDxsTnj+BN6N2xXne+wcgdovDCljMe96s?=
 =?us-ascii?Q?Yu7hj2CjuG9ZMkHsPl4mdo0SN2pufckf8jTZryLYNWEhkUopFhBo3VRBQVY8?=
 =?us-ascii?Q?ssgVi7ztGHM5Cvb8o5/3zlT1atS9UpyXuEMxfUe/p4nHn+N1CKMDIgtXAAGl?=
 =?us-ascii?Q?qS9Z7JzKLCYkENPLJG6IG6L6BfS94j0Tlm3Xfg6q75W7Vk1dMVpahg5p5Y26?=
 =?us-ascii?Q?vraa5xmQ2sh+4PH6mRj0rMp1dGDUS7jsVwWw4+7A0iv4Epkaxp3o5iMIwjjM?=
 =?us-ascii?Q?3GqxcsFNiWnpsJFgHJ4KJfOOuwhO2kNLKiFSLXoYnf4X4lgF6CY5PlxnCKKh?=
 =?us-ascii?Q?psrD8SSX+vWFPM+ddc5qb6LemCE2fCDj1LVdSosaiqTkx+XaoTWL/KAzGUmB?=
 =?us-ascii?Q?rQzcrPEslCLy2JkZiTQ2PtPnZ+Vrvpkh0IDoCPuWwSJ+EocjN7LKmaYEVnxH?=
 =?us-ascii?Q?R7j/rjuEZrlAfUcB/ycMZb+8O2EL4VUDhpjKbuLMAdnKhlgsWninqXyQVxsb?=
 =?us-ascii?Q?pnIpEJW44CDKLFoNGO9d4WkcLPuqIZUeFTgLD2M1WuZHXL8NiCAdHtGrCLBp?=
 =?us-ascii?Q?EauMnCz7jN4kVjC38HaU6xJlxL5DaANpBR9F7Ti3DUxuZWA6f8WxsWgJ+PL9?=
 =?us-ascii?Q?kulSQMuelKoz7HQ3e7m+Xu3hzY3YE2u9QZJjqA3jL8KWuZUYMooBoXs9/KF7?=
 =?us-ascii?Q?ZaQ6SFnX1HoXY+Vysff5t+DITirg1VQZEYlMvdoFkMaNj3yvYexksADH2NpO?=
 =?us-ascii?Q?kjEt1w0Y4dBEPcEXXHi04i0EtPnjzBtmK7iSlUV0wVkb1fX9A4UGkqX4Jq0l?=
 =?us-ascii?Q?8eJBqAnPBAipOg98GUWLsIQddKZc8M79j3ywkxDGZQcCUvhVRdEb+tXfVyB8?=
 =?us-ascii?Q?dgNYSdDhCYOsayTkctoSM/Kubw7A1zEz3qrwSJ/kRqtsSlnwubhwbFrhKCBJ?=
 =?us-ascii?Q?YiMKVztuw0ktG0XslMK0nXx/C0is6NrihfozRaT7a3vqVK6zd1LvLXGAZfLP?=
 =?us-ascii?Q?Ek9xsIPKAUKphxqYuL2qKNIfT3PMEmxO0TE7/6LF2RSoQ9rjov1jK1OEuf1m?=
 =?us-ascii?Q?9hrMnBfzIU2czz7/qZBpbbdYUMz7bf+ljDDTFALkA3IWDRku7RtkxUbMfOb6?=
 =?us-ascii?Q?cGjZENOlXU6GG90a8qoFtYNJjbhHprxZHQZvMn6KsOAN2GgX/CGN/pV4rTyx?=
 =?us-ascii?Q?VzVkhmCbAg=3D=3D?=
X-Exchange-RoutingPolicyChecked: DnO9BfVTwGWWTMLdlkSB+rEBbFxz/zR5h8ZaxaNYy44lKH8fmGbK9s7OB1jtpJrTKSZVpFu8EZyEllfjaDSvz2mAyrK9DC0DIWmn+s7iqS3U1ZLrfPLA6rWlgX0LtCUF8Qd2x3yvHF0Wh5Zjt8dFqrG2HOZyiLrIlLCUoBo3WvZ/BzjcIlbkfwjjSDE5EZXbVhb2AK9Pk1E1hHVXuIiCfJv7X2CKn5rpuarYRQwgUb6rxZe90tUimr72jlOjVd3iKJR0d7CU8BtcwuoLminpJowxZMh4PwCknTRbtgLRaLV1ejgK8TPdBmNd9LKKLZZ6juiGiIDxZmuZ3/vm9Sp22w==
X-MS-Exchange-CrossTenant-Network-Message-Id: fa084895-d1e2-4863-7f7b-08df0989aa8b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 07:04:58.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiBpfJNvxZYwIlgJd6BiiP6xyBSRb3dx0P828XIUB6OaVEWpVX2rO5jGUQaO3addQN6gYKRE8IoYi5kxkgCPJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9960
X-OriginatorOrg: intel.com

On Wed, Jul 29, 2026 at 12:55:23PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Untrusted VMM input `TDCS_QUOTE_MAX_SIZE` is passed directly to the page allocator without bounding and without `__GFP_NOWARN`, which can trigger a kernel warning (`WARN_ON_ONCE`) and panic the guest if `panic_on_warn` is set.
> 

This was discussed in v2 [1][2]. __GFP_NOWARN doesn't make sense here.

[1] https://lore.kernel.org/all/741eb8b8b83dd10d39f304133a7625f4232ab793.camel@intel.com/
[2] https://lore.kernel.org/all/amCv00f5Q6QlztyY@thinkstation/

> Pre-existing issues:
> - [High] Pre-existing UAF/Use-After-Unload race condition if module initialization fails after registering the misc device.
> --

Sashiko reported this in v2 [3]. Added to my todo list.

[3] https://lore.kernel.org/all/20260727101350.GB482062@pedri/

> 
