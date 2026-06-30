Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6D3E1D17;
	Tue, 30 Jun 2026 05:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796823; cv=fail; b=FNPdY0aaiTK7AJSlN40ckNL7XhieN2/Rv7qWg68+Rg8DI0hkLYPCDuG/8CYwnQJQmienkz0o5yaQVrViJpgcez3P5qfUxgSIRFm+U/pHR6ZdmupfRSeL/ax40R9T0w2j0stenKnmd1TIbCAh/tfsH/qnhv20v6T3mCNy0yJmLsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796823; c=relaxed/simple;
	bh=4CB12UZ3sXFAY1n80xzy+Pk4NEf4zuSFKp1ZB3pvsBE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z1yJGyJqFMWd6G3qYUnIlUjGXIZXp6sKLCqFRfi3DZCNvNVmzjJnzrNTa4SNhup1DekT0LAYnuhijQcdT8SSs8hAs2+hgJIamVxM0SqTTz9ORnD8UantAfsM+FvjOdRJbOQ3G+u9fLJwDfBngNMWd8dCoguxMX8ohpkyLxscdJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1wKiXWp; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1wKiXWp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782796822; x=1814332822;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4CB12UZ3sXFAY1n80xzy+Pk4NEf4zuSFKp1ZB3pvsBE=;
  b=M1wKiXWpGrmf3KI2ZhHCn0inPkudCtMDbQJflazwNsUvGCRHF1qGvAlo
   0sSWPsB6itfV4Ze9vYO0ZajaQ7SPfPuOfCABoaxA06kZ7ZXLfCtuF8/r+
   lqa8SG+ynkBNA8KgQFvjiVre8aDAjwpJNg6m+vGyvdqPVdO+onziPI/w1
   QIWmxzrHx/KH+YfJY0RI4blcYpAxbmcu2FzP+IAg1m7z8arYUiHExZU/E
   OB7mWWTlqB9TENFbUNpuX15hg5cFiG0M6QEbc77kRmeV3ogIjAAcA/0Qf
   FSYs0MMJp5zQEuVC+Eo1aDR3ZGFiB9gSDnQXCX16cjjk/IDac0RCISw6u
   A==;
X-CSE-ConnectionGUID: 44HRs3gcSQeu4WsBG8STPQ==
X-CSE-MsgGUID: nJiP5ytKRtSTI2sU06aj5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94883794"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="94883794"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 22:20:20 -0700
X-CSE-ConnectionGUID: zcXuE9GdRSm76XEn6bZQUg==
X-CSE-MsgGUID: 438TNNTtThKTA1AsnIA5WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="252305247"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 22:20:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 22:20:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 22:20:19 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 22:20:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UR0Mlwn/obGJI7W52BM1+uqPjPecFRT8xH891ViCF/gt4PSfpiVzMjLZGdMxsYI5DrOoLlOu977oSwsvyikMwjl9i5OrPqLafifhjcs+fg6DkHXk8mLJRZABE97YTyu8YiyF1E700u/OljtshVspAFI/Xvkwlg+CWYiy3gbfVUgf2r+X5JfAd4hPo1EU1Ja/ZB57Gm9xgGIvrTSNa/MS51d+Rk8spheChZFv1y/MH+LBVZl7pdTyR8B8sQD5CmYnVziu+lBrjnD54xaNQz88QVa0AmP0zoriqe/i6WdPUgNEPKn20opXS+7rDHoeAxOYsho4/U/sgVVk7PG+xFrZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhY+jttF//CTLuHgFEbjhjAyWj82FOHNtxCCLsJp7JA=;
 b=QTIILQLciTQOZHWb9iyV+cHs+XKUB64ENfvNUONPpWHdF7FPdqk4Z8IVMXMlWUyq/wQ8VDaU7CVecYHSntwrDyVLptrBMolqOx6LUOK57aJm+eTVUDWErVQQOwLipzw80r1P8Cy5rdVH2GM6Dy5JWwyzxmJOO0v7iJ2i6wOMnnwlwevMG22Hxf/giLIXYOEm98g7n+gX/+xm2QnqpsozaTonPRDPcav9XRJRllj5AQOp1RG11cgvO6zd2sbihxvCZOmsdqK8BstzKrJGpRYGYQZMsSUV4t2IDKkDLXuAtfpZCVQq7ub0UrrWcpcHUJJVVyoMXK8e9jpSBjqnhxC05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by CHAPR11MB9654.namprd11.prod.outlook.com (2603:10b6:610:302::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 05:20:17 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 05:20:17 +0000
Date: Mon, 29 Jun 2026 22:20:16 -0700
From: Peter Fang <peter.fang@intel.com>
To: Chao Gao <chao.gao@intel.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <x86@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <djbw@kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <tony.lindgren@linux.intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<dave.hansen@intel.com>, <dave.hansen@linux.intel.com>, <seanjc@google.com>
Subject: Re: [PATCH v2 07/17] x86/virt/tdx: Initialize Quoting extension
Message-ID: <20260630052016.GD1743876@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-8-yilun.xu@linux.intel.com>
 <akIt1b9jJl1crp1A@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <akIt1b9jJl1crp1A@intel.com>
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|CHAPR11MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8eb1b1-7c3f-4aa8-97ba-08ded66745df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Df4sS96P9YNOo1DWFiIzUg+51w8zIqcsCYb7TEN5usgajHdNj5029Eore1Mt3ce9Z7k0smvFc0yc7wQqMXB8WDpLPOpFeVdEkyTzz6qkwZcHXS4ql54qdLHHHaK9cuS2vCawOK7pltOGE67BDrh8okQK2jfoDvBYxdfuBquU9j8ESKTIrjtINJsR05zLvMP7lq3JkwChdmVP/vhamguyEPnjKN9TmgzFwjrY0uOLdcLayKAeCU6WT31Y4yAVXBwvDxCFkVlWO43ilInFud8jU2UZtXX9+33tgAl+foJIaoqk5DOJD1WWxNSw9MBTcgCiP/FWk8g8zFDwE5pnZylTXPiuPpaqmly4E1RZhUeO2WhoTqN088huy7G5tuFZ6V4ahQN6KlvI8H0NJCh17lp/J6wzjac0r0ycWDVMROgQ5slnTdq6SMVyJ3hxhkM2h14QUN6Elyz/4YLZ8FT7RAwtxeBydepIMNqZfU0drhEZv5cWxMKetiPd0pXLDChgeizwCgp5yFwJ66tbPX4wcagsAuQQOEKFfFx8QZQnSiMCKiwJ0WAWR+PlZ0VuGmaBzuwwLnjIvzZfFWb3h4qFZjxQpSZ6IvRVVeWY4knFWYY51dHVpCffFKt+XXREEBruHcDUxTlb1RABImSfHyOekKNlm1e/yNNTasqifyLD68O19H8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ztJuijhq+bUaPwyk3ZIU0Uvn8w2jSTShkpUE/jq+KaTP/aBfB9tFsU2XywTJ?=
 =?us-ascii?Q?LA/t3ATmoVyb+UUVVdImYKcQsb/NdmI8toiRFwC5R8OPizBoH+LKnF6kECdj?=
 =?us-ascii?Q?5K9c8BV5yST5qaI2gyck2cW0uhhjBvnwKTfPj2RQzFYD87KYR/Mbq/YFAXrv?=
 =?us-ascii?Q?6YNSDb04TaTGh8kfdAhUSv7MdLS3a05NdbZ5RjUG1E6V0bNBrQZiHUXPWq5S?=
 =?us-ascii?Q?l6u7HHJ4LkVbMZGPvIGMJlQZ+33Xs4GsC0dlLZgHPG2vaPHapiYdxtNVFJn4?=
 =?us-ascii?Q?TMTByMie2pbdiQP9IqjUEiKaiDW6BaTOZy1jGx5yBuJzRE+fmqaj7viH4C6A?=
 =?us-ascii?Q?saZY9/FRsueDPETsSazalRA/cawQ9HyGkoWHcFBAb7b3Zh0ORF9TyMJYQz2T?=
 =?us-ascii?Q?NBnwUKu/T9N2Zw+KMCtI8AKEUtSTuiQ1HFZ1Gxqh+jdQYhFRb5hU5pZ+CNf7?=
 =?us-ascii?Q?karwkfJnVRbRFYKc7AA8tYp8zggDejnTzBgIhp5m2vfEycZbDUzAiJxUSmcy?=
 =?us-ascii?Q?hrmL9N4OZSNfg5CyT6we5SNjNhOf4uxmIvG3CX/AyfcAUHcFSFjaxrPz5AaF?=
 =?us-ascii?Q?eWMam9/a3GyCKuW9pydbtucoFs0GOBZ1LRJEoihcRDVz+wI4etkldKP6guIe?=
 =?us-ascii?Q?+UPo9Ke9SeCtfpsUsA8AfOPbhnor0PQHVg6fBjkFsYj6JKRCvZdhygvySSAl?=
 =?us-ascii?Q?8EBlsXTnOHFAfB9zXLYcrNdxfciZG+FvYuhIzyRgQvcjEvb5J8mJrANRghSh?=
 =?us-ascii?Q?zCmGJhsqmxDX3OSJNM+E1OrpPaI8UM+uThQ6jJAgHBcHfVLH1b+RShH9NCDw?=
 =?us-ascii?Q?zwr+Y56f4rAcVhd23rIIV/QO23Fe0yCVAO0iXbvWyVATfqPhwr5byQp9ySDZ?=
 =?us-ascii?Q?PcSESVIu8e6jJ4AYFXlxcN+0vV6GujcNrYaO1eBRy1dcmVbyeGXi4+MHRkS0?=
 =?us-ascii?Q?1+82ay7oEcu6qsN0qWiUBHPfZo3jAJjgDRI6j9dOuqVWMaR9w8Ho6eIzuI7D?=
 =?us-ascii?Q?Kc50hfu2xT7O8xEbth7ZBtn/C8VkOWsAhv9kqfgceF0mtv8R3jHhCKD/27xk?=
 =?us-ascii?Q?3gzrIymVoa7Hp3eYgcQKEkw8ihazFmaL4dLLJF4AP95MLsGXUR5PpqHKaBRB?=
 =?us-ascii?Q?tNshgCo/u1yoj7wZ4zQre0YdexHFalDi66HiBDkFU2j/gGpzI2G+DLid8DYP?=
 =?us-ascii?Q?8aIK1MFo3wVhVcc5lTS0uGrD9N7mcmQ7a3dnbWPCrqQJa6BFn5CgkvT7QXsh?=
 =?us-ascii?Q?UTSE08UlZ0nOoE7YanZCrrk6Jp3HwIGX5+VDbjVZlyiQWP6fRqPyjQ3gDZBJ?=
 =?us-ascii?Q?dLFL8HZHrl8esujFI/Soc9fNeRhrANI8/L5HuF5r+ya0rrVHhiU6k0zh8Nwn?=
 =?us-ascii?Q?IPjAfdN3MmZLfyO9cDYa8MI3mnRINlWfkREA58IJHlgyLmPn1Fob5/kwDgAk?=
 =?us-ascii?Q?5uS5HyBh5dRXxrH41op6onKFbNziiNPcHfRnZr+GE9MQW2I9MO5Uh/psjwYB?=
 =?us-ascii?Q?8GvbYa16KP734JZAL64YP4wdvyRi95Q2KP9nKZ701W3N5IAeFATyhbfd/Gh9?=
 =?us-ascii?Q?XyKy0hAcmfm9bzu+Ut7r67IOLfbpLKuJuhy3kUPD+yBWlyIN1zQFq1rjSUU6?=
 =?us-ascii?Q?O4N84Obo5Ksl/pUzkugHTPKWxCcDpSpnGRS5ptG7Ak/idESrvRjgBfuTdGPw?=
 =?us-ascii?Q?Plw4tfSPPGJgEwCFqcIeQkYyoMSVTMQ7CT9pqnL3/5xL89yG7ocV+mSUK+Zd?=
 =?us-ascii?Q?lm0NssQaBQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: CWx2d21jg2yF34NIgNlBNrsHEmChnxpf+UdjLuHuvSQRUI1AhaaxPd656/NvjTTKEPM7aD3/mSKHsF+3NBYx0fwQSAqZ5rqRgBCNPnDPmxb89Ss8b8Qx9uG+ee4M1p+Swx27tAefIYD+26C8V+bBnhW4wKDIktZNS1UuuzPVTNxDOh2HIQz8u+lGB4zruLmKfi8oPj4PBVpMgXunThtmC3OpdLXGX2pZJVkq96aB+OFW8zg2Kowldx73vHFqqXtOTlNYzngr9DoHo1VudDQHqt+S5BdVRdo/5315gLaZ9eBh6Cj5UxUHfHjcdjMP0aWDOBkGMqQWW/aCq8HIp2NEYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8eb1b1-7c3f-4aa8-97ba-08ded66745df
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 05:20:17.6691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoL/kIrOVYwIol5T6/1HqwbDwacSQhmNiXTuzR1fcAQnpCwMoEgzSwXC/E/90hv3XQT2Vti2DV71lrSXHGmOuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9654
X-OriginatorOrg: intel.com

On Mon, Jun 29, 2026 at 04:33:25PM +0800, Chao Gao wrote:
> On Thu, Jun 18, 2026 at 04:13:45PM +0800, Xu Yilun wrote:
> >From: Peter Fang <peter.fang@intel.com>
> >
> >Initialize the Quoting extension during TDX bringup, after enabling TDX
> >module Extension.
> 
> This jumps into what the patch does without explaining what the Quoting
> extension is. A brief background would help reviewers who aren't familiar
> with it.

Yep, I'll add more background in the changelog.

> 
> >diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> >index 4d2940f4538a..06c42b86b05e 100644
> >--- a/arch/x86/virt/vmx/tdx/tdx.c
> >+++ b/arch/x86/virt/vmx/tdx/tdx.c
> >@@ -1167,6 +1167,32 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
> > 	return 0;
> > }
> > 
> >+/* Initialize quoting extension */
> 
> This comment isn't quite helpful.

Got it. It makes more sense to add it in patch 12.

> 
> >+static __init int tdx_quote_init(void)
> >+{
> >+	struct tdx_module_args args = {};
> >+	u64 r;
> >+
> >+	do {
> >+		r = seamcall(TDH_QUOTE_INIT, &args);
> >+	} while (r == TDX_INTERRUPTED_RESUMABLE);
> >+
> >+	if (r != TDX_SUCCESS)
> >+		return -EFAULT;
> >+
> >+	return 0;
> >+}
> >+
> >+static __init void init_tdx_quoting_extension(void)
> >+{
> >+	int ret;
> >+
> >+	if (tdx_addon_feature0 & TDX_FEATURES0_QUOTE) {
> >+		ret = tdx_quote_init();
> >+		WARN_ON_ONCE(ret);
> >+	}
> 
> nit: Reduce indentation of the main body. 
> 
> 	if (!(tdx_addon_feature0 & TDX_FEATURES0_QUOTE))
> 		return;
> 	
> 	ret = tdx_quote_init();
> 	WARN_ON_ONCE(ret);

That's better. I'll make this change.

> 
> 
> Also, why two functions? Can we inline tdx_quote_init() here, or push the
> feature check into it.

tdx_quote_init() has a second call site in patch 12
(update_tdx_quoting_extension()), during runtime TDX module update.

Adding the "if (feature)" check inside a SEAMCALL helper doesn't seem
like a common pattern. I'm a bit concerned about making this look
inconsistent.

> 
