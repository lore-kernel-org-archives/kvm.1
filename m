Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC145429039;
	Wed, 23 Sep 2026 05:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141156; cv=fail; b=TRCDetqARYhX51CDL8xdp9VxE+2ZlbMIfr2Rrbh6Ou+95KDJJFKXvdlbrpmOt3TOZGuUH730at7E29KtBVmVoxt6ZzGE4OWos1p42VZqdQf2TnZ+nBZB5EGmKBamQqszY87x+mlxmLrcZ/9wJPe0VZXxl/tZ35Kb33MoSdibHD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141156; c=relaxed/simple;
	bh=UFK6ooNVWcxjZqQB4OjCaXwlo9UyU6zNNpRWcuEXsjY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iuI3qUIMgjn3VR7v/E6b8c3WvHlMC0fEq6GKhKezwaAKtpgcg83Uvn8BclMQXX9qkjO9m4lZW7963pr4Ktkm5A2EeV/1fhy1QvVQVocvxqRI79EY9AKr/b8/pbPuawBbXsv52u2yaUCMzwcxdZ+MzQHqNLRvdjQSVAgDQiR5IOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Htt0/aEe; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Htt0/aEe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790141155; x=1821677155;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=UFK6ooNVWcxjZqQB4OjCaXwlo9UyU6zNNpRWcuEXsjY=;
  b=Htt0/aEeefzihXivSUMQ/Fv2F8VD0DgQD/XSWn7h8IvAe+/eRnU2gzI/
   JqJZrlbUZ0mMp+QoODtCNfAkOdNABy9IYkH02ng6opUKICVeXWY/NELlC
   rLnXdRLurphfUN6gvMYKmlFEAA3PxmLzKJlNplNTFMXVvPA5cb0s+gmid
   bGAtT45/PETFDr9MAv7/H/zExXx9V0ITVF3unwWTWg8yPtyY7W5DtlN77
   cUwAbaMtLapxDidDmvBK0gwOGKWII8hnT1KgaYmnbtZcjOdA4t+3OVSkU
   KrSgwWhdMiKoVk1WiRI8JSoa5b4fDu3SLA3S2QOQygmn5E1pNBZ7KqJYe
   g==;
X-CSE-ConnectionGUID: c0yHKALgREqENd8o5V/9/g==
X-CSE-MsgGUID: HBM4Hhf+QRWUo9S6mKpt9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108299589"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="108299589"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 22:25:43 -0700
X-CSE-ConnectionGUID: MKg8cpAkRV2YAhDaBMRKxQ==
X-CSE-MsgGUID: H7uj66zHSqeRW/KRGNgi7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="301368911"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 22:25:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 22:25:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 22:25:42 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 22:25:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3wapcLlDTgp67hyNTM1xLJuV7aLasGZOHcaoy8ga11SfsqSokcJsHUPp08ilYyCcTEt8DByRKzta/HxvZDeuou+szHYV8i6m9GlbrC24+wV0XmsvFIurF2sBbpac4F1yyfwkSAu5XT9a6+FhFDumLZActGGGfn+LYBSDxRsHJQeRNKjlouJhIv1CYGTTpd+1muEKt3BhyWSe4QHTdXzkYVf+pSGeQ4DxHrvmdk+I2UTaDswGOQEJfjAZ8nU3fVWd4KqKb/zuB0+tnLuB7Lk2Eaf8Q57Ll1XnqFk53TXCW0LL2cc6FmvBipMzY8GHjd3mnH9bysPUuqLpxlBOxEt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqc5a89HnlDtqBdCWVTmAioq6byAxk+7Gj4ajP7DGtY=;
 b=s482EJdIIbt/S+YS9wzqlcCpwqpWJhOjryj8emlNWMDW/qgwbl/MnjhbH8GuwN5AAu5SiZJLaSEkdkHgUl6ct2VMjADvWk/jCAFWMcQjvKR38MEQr71aJQeEC78VAKiDgXT8/3K0bruq1FrI52HAOXqOJd4rI28LGpwj1vRw9Ea/p9iz7yy6hD+X6UgzWhhGfeTricfv9QaZlEKU/epTK6EbaicEwHJWA/ThAdEO45scVht3OTxj7hNzk2VZmZfQf4YVCKxdRXVW4JDUmFPJX+ePzVxY58VaYLql9+si6b67njlnt2ctn3Q4Ec8JQgSMkh3NiB0aVvQyefxf1hMxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by SA1PR11MB5826.namprd11.prod.outlook.com (2603:10b6:806:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 05:25:38 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 05:25:37 +0000
Date: Wed, 23 Sep 2026 13:25:00 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <pbonzini@redhat.com>, <dave.hansen@intel.com>, <seanjc@google.com>,
	<x86@kernel.org>, <kas@kernel.org>, <adrian.hunter@intel.com>,
	<binbin.wu@intel.com>, <xiaoyao.li@intel.com>, <chao.gao@intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Drop tdx_clflush_*()
Message-ID: <arNirJownovqY66q@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
 <20260922205215.870563-2-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260922205215.870563-2-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: KUZPR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::10) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|SA1PR11MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 7575dcbc-9691-4d2f-2e2e-08df19331994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: uuLddNj8ndtmAFhQHAdLBQZtFoTYbt46vmmytiOwwF4Y82G4NjXUj78PaHxCLrrbJgCalRVI0uC+ymUYCxbk9NeBnrSj+5dSid8IYzO5pyu5i4H/95gc/wSO6vY/mza1AAX+BYjxzgCmQ5ZAI6q8eBxZpOnMgGjX5MxJUnJL/ek3mumfW2IYILoD9qfYwdFQP23TklQ/jPzusVqv2DOrY5iblOkMdDSayPV0X2cvdwSb7RTZRii4a7B7+hWzKOjfUbA/yLOV2+Ps0JfMdZoeN33iBG/SNg1ngbLDP7dt7Pb9FCKC2H0BA6qayEpD2X4t+Wpo7IufmqVOF/UElKGoriJZZBiNAF+FFN4yy/I4jtcpYzcjGtdTYSOh5fe+6BsVfjOYgVg414eTlbzVyFF4JpqFsfiDiESA5zBIkRKMIM5jFQIi+HG7G9mCicUq0BEZkkgI/M7geM2WcIQD96laGBFsGPTnh5Ee0rkiT1ZO39tr6GMssAr0qawBW4UVKKfw1kP0SIh9ohh5IuN/F2U2lCT4NlVnFI8Tl/CEsG8Zs2wUTrhVvip2L8OwxEFlNTYnUOGkBnhNKnbw76A5/FrtXiXAgKCaie+p8CcK6eDjJKI1y9e9BRVfRZRxXySdsSGTLqcwc+TTbEdn+Ie/okAqK5J2zNoEL8z0rwagKwH1gs8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BZNQQc6IISNetafilBzZMhYRECW3VbgPdaMqL0+rN/17LcxE+iD2cALOaYge?=
 =?us-ascii?Q?NbS9/6IdBUR2tXm4zdyqtIbCWdcjc5WSuKeUA8LD5N4MZyyqnJ5vwe0KIuey?=
 =?us-ascii?Q?vibFina1VfLZvKmXCRU4YV5z/IOKivqfu3Si2F/SUKmwHxh8ze9N6o2RWUHR?=
 =?us-ascii?Q?SV+94UmlPqWUbFVqbVS8r/EQuj3l6d7HMeHa9cPV0PI/e/2K8YRZfwHPcxvy?=
 =?us-ascii?Q?9h1RCghRCLGIGzOEx4NbCP12d4YNdbm8jPlGRcPbOGIsJ4XvhUXZfZieLj79?=
 =?us-ascii?Q?oi9KfD6L6PckKkJh9vzZojiSl3JsRzdcNhbt19DCgKw/Z0TsZzqew4DwCDqE?=
 =?us-ascii?Q?LFC756GI3RRq2UwaKEKgweZ/otikCIe+nN+xAACEMEeD5Lk1mNJ4jqnvQjkN?=
 =?us-ascii?Q?e294b+vFMko7IrIwBEWn4RnrM8LGDdKoOT9oy7ff5NZvI5BqIYh3mHxWzhPx?=
 =?us-ascii?Q?SSG2/R2WtTihU9UsDQlU3V33ctDlllH22nkVWMIfsPpEIQCUmWcnpvUOTxSS?=
 =?us-ascii?Q?m7Ig8Lgif8DagWtIPK42fwajezojzeVPz+I6nPebq4la5UlwQLAo3Z3CBkWj?=
 =?us-ascii?Q?UBxi9Mm9H7T5aQQvWfwbybGPO0eOEHfBWC+WDhV09vzlYKaGI8LesFUG7IGj?=
 =?us-ascii?Q?QCmb1O/yTHveWzz9ZK0jTBuakP4eHdCl1re1UHxlLT10LDKfEGT1ib4MV7ue?=
 =?us-ascii?Q?b4W5//GXpbJFodChB9CqHmT5ucJpKAMSpCPYLSVkJ0TecdbPaSNM6W6r5fMH?=
 =?us-ascii?Q?qC8bNFsm8Rw9Zc5b6lDySYYr+6OAlwnnQwbedw53wDu/uvxx4oOs0okRmcNB?=
 =?us-ascii?Q?cAT2brdJl0rQR/r/2OjEQLYtUe79kdz13DGXpK6Lxx6BOx90hkmcLYdp3deQ?=
 =?us-ascii?Q?+A5Pdg3VxQFhpfB0oo4c2g3eCi+3c5f+X20Wm0dYCIoGncThlG5wZcRInym9?=
 =?us-ascii?Q?0kjgtJZ/syc0wdz9np0QRobfwoFtDda4kI/pQu8hXlLM2XVPrIe09LKGvquD?=
 =?us-ascii?Q?aSqSch7FYGx6Wgin4Eo760Uql62iFn/MVeOqttBpsaqqGpuxCHZ5vzLyMWZR?=
 =?us-ascii?Q?8I4GjUJBbJ4o7plvToXSW/KeAj4VwUWY77AXRwoH2sKvV6AJ4UqgP2j92RFb?=
 =?us-ascii?Q?br7F3MOWGlrypDRXiQu0dx8BousMjt3FvhnyzX+0nkUUOPLVd7AFBs8Q5EWR?=
 =?us-ascii?Q?eMh2IloJfihaufBfrBRVKukfASb8FFaIS696yEifh7/zOUIDw4y3yJpr03Aj?=
 =?us-ascii?Q?QGO59WgaOj3+NOgif8q/flzBSeZpgHUJhXGs9DEgKOsgt7zOqOsYvS22+xZ4?=
 =?us-ascii?Q?QtUXWy6Aoa5AOtgSMWxGlhoCNyUxLNVoYjvHXT9j3ElUZvKPmXJE5gzh4SzS?=
 =?us-ascii?Q?+Oo4TTmC/KeH8JShJ7TwKuLXdch3z09WYtw6WzBBq5Wqm+nuq7P1ywAyKMs7?=
 =?us-ascii?Q?0NMtdliuJNlQesBO0rH/nmtgLgjT1TNiaFGTvAs6IA+rXfqmyOqPSZdQpt9Y?=
 =?us-ascii?Q?Kg25HWHnj2jPLQf8eKRQx9m/4dEIFebVyMtp3C3z2t6zrI0Ki5Ny8PKbYErM?=
 =?us-ascii?Q?w1zVXrbuICQHUJXYtnkF4qPsDzmEQuZNpQCGPVgRit25VsmVsbG599xKGhFd?=
 =?us-ascii?Q?mIfHkETMzjrWu1nuL3evpC2AWdsJOp500IfRBrN2dOT2CgxhaXW28YhToT9S?=
 =?us-ascii?Q?iwAQX9uK/mjIWRSfGAyurKdZX5o6MWDCcuXdWJWobIlVSKF2jw4YQGGhm6fk?=
 =?us-ascii?Q?GEjdqp/19w=3D=3D?=
X-Exchange-RoutingPolicyChecked: 4/Xe9z6W+wnhRQf560Tishp9X9s0+ei2M5LHPiBHxeOIDTiUtn9+2SLiSHHJlQjo7SvLkbvu8Pb9re6aug+uY2F26/NcgDV6+Jm0smdFo0yxHGobKVZlfgokWCYzUmMymug7ZMUD1rOQ5jQG7YZowX6nZVshBqI4WjNjWJryltiI0uVJUctaIXaRrTaIKKBlC/MuDdvZ9oxcVocNmoieUpZD8svA8u1/IYNhCKMXDt5q3XXzZnAnVHBJv9HqoXeAOwUgtCM72h8ld8c1H+i0MLWiDrZWprLzYny8AJoYdYA6jDLNou3hLEwXIvO00RrdhnDPdl1iIcDudPL8EWJcjg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7575dcbc-9691-4d2f-2e2e-08df19331994
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 05:25:37.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beNfoLIw9+ALYQBZIco3w5+t7YWzwFBgrKbo25DacDcv9mOmybuezWpxih5jauwVR22v5xHUREY6cf6do0DBvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5826
X-OriginatorOrg: intel.com

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>

Just some nits to the commit log. Free free to ignore.

On Tue, Sep 22, 2026 at 01:52:14PM -0700, Rick Edgecombe wrote:
> The TDX module exposes a bit (CLFLUSH_BEFORE_ALLOC) to say whether it
> requires some memory to be flushed from the cache before being handed
Drop "some"?

> to the TDX module.
> 
> During the initial TDX upstreaming, it was decided it would be simplest
> to just always flush in these cases, rather than checking for the bit and
"in these cases" is ambiguous.

> having conditional logic. So currently the kernel flushes in several
> places when handing memory to the TDX module.
>
> In practice this bit has never been set by any TDX module, so flushing
> is unneeded. Going forward the TDX docs will be updated to clarify that
"Going forward, ...".

> CLFLUSH_BEFORE_ALLOC will never be set in any future TDX module either.
> 
> So make code even simpler by just deleting all the CLFLUSH_BEFORE_ALLOC
> handling.
> 
> AI was used to review the change.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/virt/vmx/tdx/tdx.c | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 1b9ff749dd8e0..8f9d3588f200f 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1619,22 +1619,6 @@ static inline u64 tdx_tdr_pa(struct tdx_td *td)
>  	return page_to_phys(td->tdr_page);
>  }
>  
> -/*
> - * The TDX module exposes a CLFLUSH_BEFORE_ALLOC bit to specify whether
> - * a CLFLUSH of pages is required before handing them to the TDX module.
> - * Be conservative and make the code simpler by doing the CLFLUSH
> - * unconditionally.
> - */
> -static void tdx_clflush_page(struct page *page)
> -{
> -	clflush_cache_range(page_to_virt(page), PAGE_SIZE);
> -}
> -
> -static void tdx_clflush_pfn(kvm_pfn_t pfn)
> -{
> -	clflush_cache_range(__va(PFN_PHYS(pfn)), PAGE_SIZE);
> -}
> -
>  static int pg_level_to_tdx_sept_level(enum pg_level level)
>  {
>  	WARN_ON_ONCE(level == PG_LEVEL_NONE);
> @@ -1656,7 +1640,6 @@ u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page)
>  		.rdx = tdx_tdr_pa(td),
>  	};
>  
> -	tdx_clflush_page(tdcs_page);
>  	return seamcall(TDH_MNG_ADDCX, &args);
>  }
>  EXPORT_SYMBOL_FOR_KVM(tdh_mng_addcx);
> @@ -1672,7 +1655,6 @@ u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *sou
>  	};
>  	u64 ret;
>  
> -	tdx_clflush_pfn(pfn);
>  	ret = seamcall_ret(TDH_MEM_PAGE_ADD, &args);
>  
>  	*ext_err1 = args.rcx;
> @@ -1692,7 +1674,6 @@ u64 tdh_mem_sept_add(struct tdx_td *td, u64 gpa, enum pg_level level,
>  	};
>  	u64 ret;
>  
> -	tdx_clflush_page(page);
>  	ret = seamcall_ret(TDH_MEM_SEPT_ADD, &args);
>  
>  	*ext_err1 = args.rcx;
> @@ -1709,7 +1690,6 @@ u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_page)
>  		.rdx = vp->tdvpr_pa,
>  	};
>  
> -	tdx_clflush_page(tdcx_page);
>  	return seamcall(TDH_VP_ADDCX, &args);
>  }
>  EXPORT_SYMBOL_FOR_KVM(tdh_vp_addcx);
> @@ -1724,7 +1704,6 @@ u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, enum pg_level level,
>  	};
>  	u64 ret;
>  
> -	tdx_clflush_pfn(pfn);
>  	ret = seamcall_ret(TDH_MEM_PAGE_AUG, &args);
>  
>  	*ext_err1 = args.rcx;
> @@ -1769,7 +1748,6 @@ u64 tdh_mng_create(struct tdx_td *td, u16 hkid)
>  		.rdx = hkid,
>  	};
>  
> -	tdx_clflush_page(td->tdr_page);
>  	return seamcall(TDH_MNG_CREATE, &args);
>  }
>  EXPORT_SYMBOL_FOR_KVM(tdh_mng_create);
> @@ -1781,7 +1759,6 @@ u64 tdh_vp_create(struct tdx_td *td, struct tdx_vp *vp)
>  		.rdx = tdx_tdr_pa(td),
>  	};
>  
> -	tdx_clflush_page(vp->tdvpr_page);
>  	return seamcall(TDH_VP_CREATE, &args);
>  }
>  EXPORT_SYMBOL_FOR_KVM(tdh_vp_create);
> -- 
> 2.55.0
> 
