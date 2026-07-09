Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539F013A3ED;
	Thu,  9 Jul 2026 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581477; cv=fail; b=b9sRm05JJnqV7KUixGlE8KoCzwIt8DGjzFfcAki2ONaqvCW/izT8+n2PfoO9xJVY2UJPdmR+H4IV8zHH8juYi7b6j8Hm3xWlbr8wWyAGLk5YsDFYWfloMMtolo5+piR88UTH8mKeA6lxGqqbuk9MgWds152jCQeAstjmJYcK8No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581477; c=relaxed/simple;
	bh=/VIK0Hz5IVFkp98Dkt5FvmpIYbSFN4IpWmY/vGUQ9zE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uRW8XbCr73suG2mS3rxq7bUQdEbmXdvhYJj5IFn6kkgVCX+XjjRY5TmFcnvOg1tFuNSGbcgNNiECYmE/qIXvPNW89feCkOPM0+R8q9kiBOT7Eb3N2ldadv7tKMZga6TSXOQH17FyRJcFmjXizuViq/9g0cu1awhFph0pYXpBDhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBVNbYNh; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBVNbYNh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783581475; x=1815117475;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=/VIK0Hz5IVFkp98Dkt5FvmpIYbSFN4IpWmY/vGUQ9zE=;
  b=cBVNbYNhrSDC3UiebhG/Bus40iAB1k/LVGdDYDZj8K6V7wB1xevx6RRb
   fSgv7HOp+u2Ij4Vy8qRK7iD0C5QSeIN8PKl1dd9l/I18mugAcuaIsJzNm
   iUOp2LGZVWUTiRPxmhg5ymvpzitNe4JV9aytvRiRc6NF4Q7NteGeN+Mvq
   OKyFI/byMohOXtBW9Ejc6N8In2SSGOgz4tfTMSic1OSZ9LsiPXrddeSDG
   Mlo7tgleWsZ9qgRZpxdTNlMxloqNv1Uw47aFKnJ65mpRQfzVSXnlXEY+r
   MNbXCu2S1/btqQk+wayBOYbDj4rb2qXJ0Y7yYSc9be5iDMmHdxn3eGnQL
   A==;
X-CSE-ConnectionGUID: FzYNzxtySVulB1vBzbSSuw==
X-CSE-MsgGUID: 0zAlOWoeSRG/1vUtN8mQmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88170132"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88170132"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 00:17:54 -0700
X-CSE-ConnectionGUID: 7+FSGkP9TNSbZncEfpPqbg==
X-CSE-MsgGUID: f+bcBInqQMa8cpfLB8LSkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="292697432"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 00:17:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 00:17:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 00:17:52 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 00:17:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9NDf6sANd+qyMojahhIaBCigTWqRgy+ua/sFTiMkGUYsa+WO5WcU3H5nYiS+Fxy9ZizsaufQq52JUVP7oCiv5nWSen3RZ0jMgInMojh8jbssfAn6q8560xfG99ZPzHFGUnp/ivKDasFMdpUckUhKswfsa0A9VVuBS+5jtIvwumzxK1Vg+48SiLzyhmTbZPbH5m9e/SwRiromWjEatPpP/BHHGuFW+fA/h1zFNYbS9YkG9UhCXnHQ6Fd658Oba3Du2SO7hPg9DAdQ28ktIpbS4BtIMzcfV1gP7v+7i4bTXf90qZZLdOwFyv4gnOtpubrRVmOCx66izuMfJaMMFjkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQT6m8GwHmIc75IQSlxSQXulgbAnIghJTGbHa+p8D00=;
 b=BJ7MnGpC6pEk39qFLzPQxQE4pcsc+JsJyPfpzdC9cRrW0B/5P+MxEN59zeY6utWptCrzFh4MrUpFODcnvj6JudFBzqPEZgSzZMV2Trvem/tFNfkk8rJVwTtDXu46Eio2m+ZCQ/sl5MUQ14w6xolHldKyYKKaOLXMTb/tjJVUKGBDz83n3bBaWsHAXtKLzsg5SrMU+C3d3/8JSFwoosqQSqN+oUkfP0LsKnigshxhx9rFMTy5wPq13t2BrjNXdoCbwWs9gmDdJDLhgjeeWdBNpNkMZRBmUC1DHVXou3MeaiLtIYTfMtYaA4oYCgoXnhv5Gj5OUAKwL0QjKNWbNhVgjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 07:17:42 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 07:17:42 +0000
Date: Thu, 9 Jul 2026 15:17:34 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <chao.gao@intel.com>, <kai.huang@intel.com>
Subject: Re: [PATCH v6 08/11] x86/tdx: Add APIs to support Dynamic PAMT ops
 from KVM's fault path
Message-ID: <ak9LDmWBIp52wv4X@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-9-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-9-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MW4PR11MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: d64da262-7683-48be-78d1-08dedd8a2a7b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|4143699003|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: y6GxbrEIPJaWbeHtFO+ek5JkylY0TD1YfHHj+1NTwF9DlaJGJZLngtOiZcekhjW3hIiztz6VplXtR4rEblTYUmklrJI7sJLoIfqXdJz0vt7yHEUxq83M7FY5wjHXSdpJyLNlVVydGea6qHNu88zHoMsrZ5A/oYNxuNucZFlonWNamsSXZVZaVu7d4Z6KMJb/z0cM7P3lFLk+8Z7v45LzCwrejT/16Ti/i6DBPr6O3IyUpZbd1lHgoJl6yoDtm2gg1IR5QPge7Tfli8H1FFtkwg81iyj6AA+TnwsmTZh6ha06PrQYzmPNi1E14m4R7TVuFfj1iPqicTSpG3FFDUmG0R4Zi8SzM59JtXKYuvhhm4+e2Mmil6YvRO5iU5GVK3UWKV7+ZgXXUpvJ/TLlh4AzDBEJAim5v3oj0ZtXei3MvhASeLl2QV9W5N81QCq1LS5HxJ06ursZedxnDtLjPLiUiGaZ7DASTYmmwa9JSU81y0zPvVLx8kge8uHFSthKk/Rn1R0jqrrvS99BPeUaQ/i2vi9oY3+0rNvltFGHHrn2oLDURCQd5xaSbl8ryM1qzvU4ot8KG6AmmjlnzOky36gtIq8wCFkkUsS9vmKW971zKxuRK2ebPTVd/DbMIMcY1vmm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AJwjskJFU8siFwGL1/8U6YIDBRO4l9HZn7yol92aoTrhhT+PnwRP70WgyHux?=
 =?us-ascii?Q?50D77AFnFGj+nEmHj3eqhZSyd36ksoUPkSDtMwDpHeN/NS7C3SZzpD2u0WWj?=
 =?us-ascii?Q?pSInmuyrjeJWXvGfrIW55Z6cQmeLT2RrQ49AYdP6ctagc42OsG8/r8QzYlBM?=
 =?us-ascii?Q?mPgV8zhw6kBO5zt0gbL9WhXckBRRLAE4HbbF/tJUxM/Q/Z/+5AdnvpkV/aMx?=
 =?us-ascii?Q?ZlNdD9+IJiKy3INk1uqbfZ+zfvSrjqclpfaaPlBwQp/gD7N6DK3Ynj99GJIo?=
 =?us-ascii?Q?0+ydB+XXQZLvugK3ohBly5CSRTbeSVXwioTK4JTv3c+4LkLQqQZX1fFhAxbs?=
 =?us-ascii?Q?uGQwrXIjYO2noOz3eitrEqZ9nBHa2w5hfd6SohUsD9YCz8YK+vaTSdYMdyqj?=
 =?us-ascii?Q?v6CcmvQXVCSYer2Db87E0rmadmu9k2y1rjp43AZqNmI2eciEM0+6p1P1ENT/?=
 =?us-ascii?Q?4a2HOzzpnbOJofxjKaLy09tUE+oiyLBINHxg4CzCf7tmB8ms3/YZ3O5aAGTm?=
 =?us-ascii?Q?VSdHdh1pF6EiHosR+jRiz+mxPCZa1JQW2pxSJwbDPiWl6HOco+bC2R5a3Rhx?=
 =?us-ascii?Q?+88aMf2hlnvYclFYvuvmu0VfgyTz7RWfCiKxd+G+VwUUfGH0j9D562yOXDq5?=
 =?us-ascii?Q?etIoPwLOYckh+6Kfdaxv2nIc4tFL6A/EbYfxjcXTlaTQuHygW6FWtqy3OJ70?=
 =?us-ascii?Q?I0KdKabseBrk8g67Po9WQNI9NBORm+CYhqqTgBd5JPP1uFqJz187qZFMTgDR?=
 =?us-ascii?Q?8TRgMa2Hn3lPw6NSahH18BZYpK3jluVq6i8RBL9yupQZxuDe5MIcGwtYsNXg?=
 =?us-ascii?Q?D0IHbAa4XLnfKiKZa5Wc+x6INaZYg0+dueXqqUnnPYFAAOKvgvIXEGiYvg+j?=
 =?us-ascii?Q?1COglZegM0CA4IcrfFX4MWj+gdnlOYn16TIN54klNcHipqd+8YezuiUEcHan?=
 =?us-ascii?Q?obBYEB4dkGPkXXyUVYwzD9TCuQ1ZlQfFriY5sJcoX+BZstbBLERU69ivKwKP?=
 =?us-ascii?Q?IExfLQ0JbXbCLrWiwSe11jIr0kLW+sEJ5CBD8R9z1egCspb+hnLLVzzpdi6y?=
 =?us-ascii?Q?CDVLrVhegr/E6TjagXCqilzq4hRhOb52wr4fD8nMyk/uwu5oQ8WkwfBcFCMZ?=
 =?us-ascii?Q?z709iz+Z4520eR2lzQZIHAxJBHEq/PQUK+w+rm//Qko/9IXNbuhl2KJyJiGq?=
 =?us-ascii?Q?wSWvzbAp/Ff9cZyvAu9DVHk5KJXF2xL3mtj19eEyuj5KfQ1pEqNjF7aFLXug?=
 =?us-ascii?Q?x+Di68LUMZ3xBsANppTdqy7NICIDC3VSkm6jkreRJg0BNi+mBO//6kWcTWRc?=
 =?us-ascii?Q?fxE9hdR3gEkcQkdjbK0WKCTinR7sCO5u0r6iSY/Myjlg44JVuhLNArJc7nWZ?=
 =?us-ascii?Q?4rcqdFkNssfI1EjN7yUIzjRRIQlXAd3zD90lgwTvncLWcMqKEODsjzT1x8zm?=
 =?us-ascii?Q?rMqD6U7XoouW5BbvlUEODdDdP4eS0B8RPTVTVe0lFnf0z6j15qoYWwDVMD7j?=
 =?us-ascii?Q?MfwrEkVMf2uF9+TFAUCDIXbORDTKh8Cc4QVdn+0Dx0buC0F3P4b7I1yM+ji3?=
 =?us-ascii?Q?j7SAxzltdS+zp2EfBJRz82PRx7Grks1wMC+1P2kz37IwKQXwgktehpuK9U2M?=
 =?us-ascii?Q?sGSV4JJmQLP2HTRmV3rHnqnLc4PXLwHIF6l3Dn+D1o2Eqj+NrH3j7WN8fAUw?=
 =?us-ascii?Q?22fNRagSQOQr2dv3J5ZdfXubdcpLvXPJ3LHI4Lk2iqhje3h56r0ikMvAmrhi?=
 =?us-ascii?Q?yLgl9tCGTQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: Bwgo/4j+lX/RenuSE3g4G5gDLF3JSYeTDOnokuM2a6RYg5rJzeqe7/EUkb0763Hm7lhi7j5FWnVBw3adracpmifMc+ecwsiB53w9twGKcig2UXfkssCvkRqv75xLngokM2KeMN0ndzc2mIpjDX8hutzl+7wSTNWG2csMXEmFtFzeN63q4wBlw2q15Aye+ccgjiCjLG++v9LrZAWhE9NnIZGYNY3pVlvMSDnxmIZxzdg32GzUc9SXJMBuj2Z7rN0zLvDHQYkLkJlp09fTph39kyTV9xlTq36Jm0rBwUAZ4DcrWNS/w8mE5QQa8C+1g3wtrw8mw8sTs8o7UG740u3fZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d64da262-7683-48be-78d1-08dedd8a2a7b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 07:17:42.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtbCyoi/EPOjqIEIVlWkg6t+fDYmFvXL161fcQR6ubLIvu8fGjYMH2vkuNFjuaQtXS3+m4Jh0/PXZ7+nTXcbXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5776
X-OriginatorOrg: intel.com

On Mon, May 25, 2026 at 07:35:12PM -0700, Rick Edgecombe wrote:
> When handling an EPT violation, KVM holds a spinlock while manipulating
> the EPT. Before entering the spinlock it doesn't know how many EPT page
> tables will need to be installed or whether a huge page will be used. For
> this reason it allocates a worst case number of page tables that it might
> need as part of servicing the EPT violation.
> 
> Under Dynamic PAMT these pre-allocated pages will potentially need to have
> Dynamic PAMT backing pages installed for them. KVM already has helpers to
> manage topping up page caches before taking the MMU lock, but they cannot be
> passed from KVM to arch/x86 code.
> 
> The problem of how and when to install the DPAMT backing pages for the
> pages given to the TDX module during the fault path has had a lot of
> design attempts.
>  - Extracting KVM's MMU caches requires too much inlined code added to
>    headers.
>  - A few varieties of installing Dynamic PAMT backing when allocating the
>    S-EPT page tables. [0][1]
IIUC, [0][1] here refer to design attempts that had various problems, right?
However, [1] looks exactly like the one being adopted in v6?

Did you paste a wrong link? Should [1] instead be
https://lore.kernel.org/kvm/20260129011517.3545883-21-seanjc@google.com or
https://lore.kernel.org/kvm/aYYCOiMvWfSJR1AL@google.com ?

>  - Using mempool_t to transfer the pages between KVM and arch/x86 doesn't
>    work because it is the component is designed more around maintaining a
>    pool of pages, rather than topping up a continually drained cache.
> 
> So don't do these as they all had various problems. Instead just create a
> small simple data structure to use for handing a pre-allocated list of
> pages between KVM and arch/x86 code. Model this on KVM's existing MMU
> memory caches.
> 
> Add a tdx_pamt_cache arg to tdx_pamt_get() so it can draw pages from a
> cache when needed. Not all DPAMT page installations will happen under
> spinlock, for example control pages. So have tdx_pamt_get() maintain the
Nit: In patch 9, S-EPT pages are regarded as control pages as well.
So maybe
"..., for example some control pages." or
"..., for example control pages other than S-EPT pages." ?

> existing behavior of allocating from the page allocator when NULL is
> passed for the struct tdx_pamt_cache arg. This prevents excess allocations
> for cases where it can be avoided.
> 
> Export the new helpers for KVM.
> 
> Assisted-by: GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Link: https://lore.kernel.org/kvm/de05853257e9cc66998101943f78a4b7e6e3d741.camel@intel.com/ [0]
> Link: https://lore.kernel.org/kvm/aYprxnSHKHUtk7pt@google.com/ [1]
> ---
> v6:
>  - Filled out log from Sean's series
> ---
>  arch/x86/include/asm/tdx.h  | 17 ++++++++++
>  arch/x86/virt/vmx/tdx/tdx.c | 65 +++++++++++++++++++++++++++++++++----
>  2 files changed, 76 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 74e75db5728c7..191da84bbf2a1 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -155,6 +155,23 @@ static inline bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
>  	return false; /* To be enabled when kernel is ready */
>  }
>  
> +/* Simple structure for pre-allocating Dynamic PAMT pages outside of locks. */
outside of spinlocks?

Pre-allocating Dynamic PAMT pages are still inside mutex, e.g., inside of
kvm->slots_lock, vcpu->mutex...

> +struct tdx_pamt_cache {
> +	struct list_head page_list;
> +	int cnt;
> +};

The rest LGTM.
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>

