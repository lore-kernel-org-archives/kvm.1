Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D23EA94C;
	Fri, 26 Jun 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467938; cv=fail; b=mxhwDs3E8uo+vYbYgry5P27ZTL2S+eglBqABWWiyIsI6xquPjwAwIUbKfmsf1zhigiYTkcHB7da9z68hAg2nQYl4t+41Gcnh8ICen3H5AKupXYRHlR44ZoVgsyp1e94L5kqYWOlkmAnmFa2APfZ5XonZ3E4Tjr0oI7PL7e+MIrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467938; c=relaxed/simple;
	bh=2Qv6cAPIu8stJFbnf6RVVLGJd744++hAOl2n+zuqtXM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SnFjLbk3yIxDOxSPJqRTYhGwi+OS9vqMseMVRhnyO+V5afi9hOAIiWuWQ7FB5U7vRthqoQC3AoP8rCFyu5L7vuDVhQHURVoToHixAssKUz/kC0FHTJd6m0TIdFIJ/X/pRtaBHj3Othm6MxqahY+BecMuQHmeDjQW9n2LyQqTRfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMZUIhnL; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMZUIhnL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782467937; x=1814003937;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2Qv6cAPIu8stJFbnf6RVVLGJd744++hAOl2n+zuqtXM=;
  b=jMZUIhnL4ClWDrCJsZd6cTdoNyafotAam8WbdAwPuZgw0VG1KMCFd6hY
   HWXVb+o4HsF8YjEJzknE0ewr8hDaIB2UXiarXrU3WpDE4Q17uPs8Luoyo
   FHSwzeAu6WRacO9Nc8Mbty3SZZod7zhKCNajgWEAOQv6SvdOxGft96/Ko
   rxgZx8V4FUL2vZkTjXzZMpKZKOwnv3lwAXoB6houPHWCGEe3NfokW4KAc
   SaAebExPX+qdzPdA8Fxyw9sCFiRR2wVJCL13j5um6ROqLv0dQsGhnGbS1
   4rVuadtb6QYu8hTPNubFKW+nGjBb/mxRi2xo3PkDpi5iJ4tXI+ppoIzLZ
   Q==;
X-CSE-ConnectionGUID: lBPOuW1hSCSKAtH8qZ5q8Q==
X-CSE-MsgGUID: /xROdIPSTZCDnc0TQJu81Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="93612787"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="93612787"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 02:58:57 -0700
X-CSE-ConnectionGUID: WRLHes9FR/e3mbpiqVQz7Q==
X-CSE-MsgGUID: ziqtkoX7S96xD66zu5rTQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="247919337"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 02:58:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 02:58:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 02:58:55 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.29)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 02:58:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tov7ccPB6tEel5LYy+sOPfD1LQYDefAW8CQhn3QvThQYXgNAlbrz8x+9spU5jPpP4vzb1OkKK000KF7XVqM2XUpANTyXVzL9FklUqUaf2ixlzaWHG41gxuKllcPkEiyCVPTnO8XAMbYbdEpKqAhVdBC6N8r9wGz9+ncGu0KSFh8R3RegEzk4gyZwd7FYsEVUSq1jA5KqXbB9X4RAHvvFGyaLAU0tWSxiuO3YqYjaqRX9fvR2f+XmNcXvGGaeGVTjRqnPS4iuPHfTRTwx3bVeU6whZmvVtJ66ppulgOrrc6KFHKybvtSFm7L7Eu6hVY2mnRa0LYtmY0gHFL43xk511A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmHxmu+QMQYw8nbMyCDth+cnlgpGP62utVoU5kuy59M=;
 b=NXb0iliFpWMLyFwuE7GOcmdNkNgoi/og4I/xyJ9wHBwngWFCI1OzhFu01p14b/r96fvnGUuiFBHHQag1nanRxXpOKb14H8HaH50634uDgOhT3bZBNRWwepLAmMxAFMpEH2CLQHM4W21fJlNz6huGMdpvb3m19Zvjp6rljNJnJW69Sa2F91tp48hTUX09/Go3Ar71/Psdcs1qYXk8d+bqqvLOtDV5ObOFntu8CM5499mqCHdXrZzPW4RMXVRJtPNNCLxXPBF457wsW8YXYkQ4cDPXl/OBqfwJvrzIvwX5PN8d0FCYCm1RNNyq3F9QZKxw0akLbWcvhDCOGhlMDa5mzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by CH3PR11MB8443.namprd11.prod.outlook.com (2603:10b6:610:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Fri, 26 Jun
 2026 09:58:52 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 09:58:52 +0000
Date: Fri, 26 Jun 2026 02:58:33 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "djbw@kernel.org" <djbw@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 09/15] x86/virt/tdx: Add interface to generate a Quote
Message-ID: <20260626095833.GB1600180@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-10-yilun.xu@linux.intel.com>
 <a10ad58ed8092e4e7d81be1995438efd21647fde.camel@intel.com>
 <20260614112948.GG3200182@pedri>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260614112948.GG3200182@pedri>
X-ClientProxiedBy: BY5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::21) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|CH3PR11MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 593203bf-157e-4847-650a-08ded3698679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: V7ZBh2OcgRtYLqcSYyU/g56Rh0DE8JOLZFGBCQ8ttOAmcxFpVkYuyaQML8hIGpk/RqlVyPYQVzDA+x8+vdqy+wIegdlXmjc3rkkdgl0FzOqgNzCA970x4nZ/bUW8rr0fgzA3FGXAHj9VIGDtJ8TcNtf52pT++iaLyNxD0+7vdJKP2D3PelxwhnEIENxfuvwLJyn1tn03ZHjLOw03cW8YSBRvqOdEDoNZTqZEC448EL1KfCqvnjeO2u9QmRKSNdoH2o4Kaj5Ael+2o6hL9M2eYzYGIo0+dZwgzSlapd/OizNQouSDVEXBVTJPo+N0u/FKvAas89txo8jfEtz6ijk7eT+KoStBVcO4BJ9jhkRzN9/YwY7py8TchhblUpIN4E2CbZrgoj5rvNabkugRLWoxlCkWnesZHlfZk8aODoykjSX2pYXJfUuv2YyIhZeI4aD4c2HgOLMwtXLlNxFDzKvqd+9Z9gE5LF2ae88MkI43pJJLs+5VuRvC9ToJh/aiNCpDWmyObKw71ykRzm9mc+Pc9Yi8EWFrQ7Cl8GV2Xq1vhS/trP0mMzThpov/W5JogmqyYvVMGbdFHQx37ndEG9NspCFYHJ67B9XXTDxN5jAHInkQR1KcfdT1HgeyJfOBgWO8cuOyGMq2XaalUv56dv2drVZegdXfjhU/0LX7qHFj3nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fFsH36sLtzwKRm5PRPZ0VZmLNW2lWlZBLOfgU46VBre9HROlQ7T6TdZdnrIO?=
 =?us-ascii?Q?fqOFKof0m0sdCvo5XPUeKLijn7uNOp64XOEOgChQif/0sVjMSFPTN4zsmsPp?=
 =?us-ascii?Q?NuR0ObShxo2QYNFl05hQk43lRcZutYkRj8yBB/PSOIaT2Uh4O12foCXem3/K?=
 =?us-ascii?Q?0zCF41q29+5Nt8rXWWZCDajjMV0Noe3VyK05PBConDS1T3Qb/MKxkdGUto8b?=
 =?us-ascii?Q?yhjOgUUw1580LwqiPtQtYIEzsBjLarjAcS7xLyWZ2adNP3LrNeZ+BahKaJDc?=
 =?us-ascii?Q?zNrjKy9qIPf+YXyBBcUzEvPROmlkL2CBQV6AaUM0YvH4/uUcJf6PW8mxfHUB?=
 =?us-ascii?Q?tahPHIEgIOuZHdN/0pIqOwnxHc++uvYUlO6oqfJZ/5WJxRlx6cDJ/y9ZHVAj?=
 =?us-ascii?Q?JBv2nuV2XRw+ah7aNUKcvtIRegKs8pyqTRSeJo8DVK6drcn/0acEmyWvGVMf?=
 =?us-ascii?Q?UuvTVSzxx0v+7LoctlmtyTqZg0jdgNWEXa+MiQX/2ZAQmjHBuV/yJIenlm6f?=
 =?us-ascii?Q?9wI+KeAXyVlmAvzF34fZvOFF7R9V8Y40mwIPk8MrGx1HXRue4u5okUhlUXwW?=
 =?us-ascii?Q?Ac66xCk6KpiQWY+SAhGGlfK8FhlbrEubHnILSSftRu+YSE2KE2CJwx+aEcpl?=
 =?us-ascii?Q?hj8L+8knsvHvJBaSqpztQnpnvgedIq+HCE81Bo+XZunl50r8UEoW9fUGTl80?=
 =?us-ascii?Q?+b5JixMz5AEpjw2mmS2WcAoaQX4vp1OQyR8GaIQITQL1l/ZnttNie9QgGQ4U?=
 =?us-ascii?Q?ZlJ3sCKGEDRhcGxoIMSlzkHqZpjVHEiCplVCJMB6fhctOyn0b/Ot+2+7gOV3?=
 =?us-ascii?Q?uGWCsn/N38cleugCmhODYo8XNMSzlKV+9E/3pkr7KjebjMLSNxGV9mE4WBrQ?=
 =?us-ascii?Q?5r+WClbWL2B8UQVh56OWctJCPPMXu1gbgi/sZaA2e0BXuvOtjK9mdb36giJj?=
 =?us-ascii?Q?2k2JjdNSjzVRwkfn0N3Xk7hBtuFzvuf8jLleAqeq5gxF4/C9NLJehneafru1?=
 =?us-ascii?Q?8TQInQRvbsoyY//xVZVC6zyKiA0ToausZqGP9/4PM0X4g25Y+zGd+R4PCzV7?=
 =?us-ascii?Q?6T7juU/x0gSymJbEp6A8gzpGZXE9yboNYnd0eEJq53oUnb2Gl3mp2iMXSjxK?=
 =?us-ascii?Q?3nhzF1C4/YTHtKr4o3/K1sHpFO3WGGTW3IauiV6W0ugj8mRQ7pB6ftxPKIo9?=
 =?us-ascii?Q?gKLnlyXWAIhlLSnk7bJGYsCZDgNJlME0pSPcItMdp5C8K4gtDpzUOofuVrks?=
 =?us-ascii?Q?jNgpPyB8yITA+W7YKPwXPwvQluKXIQgmZrYVWleYUkJteQaSG+a7tMT9Yp12?=
 =?us-ascii?Q?raHanalHsdF9wPXSkq2u6p5BJul8qXgE6gx17TjJdncIXcIC2NapVlskccCP?=
 =?us-ascii?Q?dF+XS9dTQ6Pr/uYbd/cbmGc0gQngAAPplvSJ5Re9FOlzjzD4JbHVnoboFn/6?=
 =?us-ascii?Q?8QAbRW8ZC1bKZJOSQ5HGW9WwiFu94tFEbURbWI/s3dBBlEP4RsHrsqL7MXff?=
 =?us-ascii?Q?beZsclCgl6x8n6rz2yD4c7uyTJMjapOjABymg6UyRQZ9wR9BKatQI/oQd7Hx?=
 =?us-ascii?Q?pRCvxpT6jhv1UzGXp/IL4TqiV0Is847dzutzKQ8tXv5I6SEkNXrRVHm/ZqAv?=
 =?us-ascii?Q?emdtNOl2pjfkg1DKmODQ8Y6Y1f6+02umsCxEXVHcdkER9LRIB4kvC93VfDp3?=
 =?us-ascii?Q?Q7bgJRx9XPmH+6GMuVM71KTC2m7/KpjnYbGKZna3qMri/ZLi9gCOH244fbru?=
 =?us-ascii?Q?T9M/wB32Pg=3D=3D?=
X-Exchange-RoutingPolicyChecked: RTN8pw68U4SlCM0esAscQETuYJHbx5kDhh7C8q/BZTMhC+Dt2aCxtha/h97eNvAZFIa6zmeka7rmrfTpySfR6r3VUjNG8HLri4jCHqZ9LpJreA0XmzA67BlzFiIibt6xBFNC68B8Byr8m3EDG6kNAjNSVVA8GLqI5lEaJ3Bj1jUWX4mhahwZMr+t6IufchNexMroO8jDnZuzauMFtHXJI+eTvcU3UaLp5FeFiYFIcBiwDY+nyX+qjYoK+6j+YC2GRNsgdnPOlcJGafX0EsNL5Z9Dg1K84ZqRUlsGxPgclVGwOLl2F48wJPykmsikY5whPSqjw4EDt67WRxhZz0NvTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 593203bf-157e-4847-650a-08ded3698679
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:58:52.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QL1wev663fpBS5jtQegnPpHDT0plPhQPmXZdeXVEYXZaj5dwD9yuszquV1j1WHSZASjvpn7g7+4xOO0MCsfQBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8443
X-OriginatorOrg: intel.com

On Sun, Jun 14, 2026 at 04:29:48AM -0700, Peter Fang wrote:
> > 
> > > +		goto out;
> > > +
> > > +	/*
> > > +	 * The quote buffer is a shared resource, so use it only for the
> > > +	 * SEAMCALL and copy the data out as soon as possible.
> > > +	 */
> > > +	quote_dup = kvmemdup(quote_data.buf, out_len, GFP_KERNEL);
> > 
> > So at init time we allocate a vmalloc for the quote and pre-populate the
> > hpa_list. Then we use it every time and copy the contents to a new vmalloc.
> > Would it really be that hard to keep the hpa list allocation around, do a
> > vmalloc here and update the pfn list. Then do get quote on that and pass back
> > the vmalloc we just allocated? Just feels like global reuse way has extra pieces
> > in it. Compared to the whole quoting operation, this vmalloc_to_pfn() loop is
> > probably not very expensive.
> 
> Hm interesting idea. But a Quote buffer could be close to 4MB in the worst
> case. Let's say max_quote_size is 3MB, that's 768 vmalloc_to_pfn() calls
> each time... That sounds a bit excessive right?
> 
> The extra bits mainly come from using kvmemdup() I think. Having to use
> kvfree() on it does feel a bit annoying but that was the tradeoff I
> made...
> 

I didn't change the design in the v2 series, but after some discussion
with Yilun, I now realize this is actually a really good idea. Having a
static buffer does complicate the code a bit. I'll probably try doing
the allocation on the KVM side and just do vmalloc_to_pfn() calls each
time. Thanks.

> > 
> 
