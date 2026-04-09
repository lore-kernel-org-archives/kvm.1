Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE60A2F5337;
	Thu,  9 Apr 2026 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720062; cv=fail; b=nSpir+pyuYd5rtrDnsn5xfuOdOZ2Fpz/DJAphsrIgTq8C0YV5HVRnxGcVry1X7gFjLh6Gnboolja6yc/2cOHPUiPOvAHYZbLrQB/j/a0bjkzm/azxHK22gzLPcdVurJ83XOMz9JlXJF2qhCMzF8Wd0V3OAVenMg4zOMRZGSvm1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720062; c=relaxed/simple;
	bh=aFZa4OG7dJ1vwPcvTmL/5ZxdsjVTSWgjpHODW5zTRXI=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ki2ULEeb9B8hrum9kJiOubQa2uo4oXdSII2Xc81R2eReCMA40fYz4RraqAh8xgJ1+fxnR3aCwlbljHmDDCFFMSWaNSzgbHsKSxsNTzkr0dba7n3diLAInAsllBBop0nx/jQEFCTGl0e4CF6gtE6DTm6m10wUTNnYotksEdHGxmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0UQJ02/; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0UQJ02/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775720061; x=1807256061;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=aFZa4OG7dJ1vwPcvTmL/5ZxdsjVTSWgjpHODW5zTRXI=;
  b=U0UQJ02/8fDDw3niiHOVYldodEC5tZojl+FGalgQdx527RIW2P4yxuoP
   WHxTQYDNe8q+85cSAH0yXUNG9TBZl7INz3tAmaVEjMVjZTmr6QYslqDI/
   4zT9R2REpfbakjax5lyOAhmTfTYFhNOaLIckDyVUzDT8cf8YhvovQUnlC
   +ey44/EJl+xmNQjFevlFDflshLtLJe6POV4g5qSyA+P4p065q0Y8+IWIZ
   NMfO6x5AB2sG7woYalczz7s2/R/3RNSFnmZGJ9U5cVnSgs+z0S4HmxCig
   P0tWaNpoB4cwwY9nM9ZMgVhKMqqQl0CJagjLN9PIqbkaJN9kh7r9YFzzB
   w==;
X-CSE-ConnectionGUID: XwIsU2eVSu2OJF8tJpylAA==
X-CSE-MsgGUID: Y5LB5BK/Qz+zH6L1jvyLKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="99344262"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="99344262"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:34:19 -0700
X-CSE-ConnectionGUID: lHzpMTdXR4KjUBChZ7H0Ug==
X-CSE-MsgGUID: +braU8YbTFigncZlr8h/BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="227697259"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:34:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:34:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 00:34:17 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enAuFjL4HQipMvMnEAuZD8aO3p6+qb3wGCW7V2uh7WSk7HuKkUjtBzOR9ysGzl6bTwm5JxBdHJl9jXcl7Q5XhAroqsCtCv8ICgz6427yXDMvmWxhy7YPVP8Px+k45mhQ3aC5uUJ/pF95HpgJvpNHAOAHo5cxJCs1HrjL8K1JpbjBo7D2zTSFWifNr8p8X647iw+A4OHVJ00PcFrct/uYRfEyo91SvpZ3me8nNoNq9Z9xPY4Jq9o4ngK/1kv8pUCwCqcdxFzf4ldntn9FQkzLGgXVKMHiXAAK7lOAMjPzdDQQiB6Q1oWDhhfrh8KcgSBnWGokxOapYM9w/8EBh1IK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EMYhh3278VaisV+6+wfjX7TYA2cQKtPxVcXPFbNkMM=;
 b=YTC6f4YP1n3GCHYkYh7CBqFNFo00DTeutby36fGiFMomtvHwXcEenzFztrQa9P43NjQn9eh8O/QwQ97kifUjjR0MhuZrHoxsWCbJY65hkl9xRoIaiXHOYvJH/Lc77vqqBOHhbdzsJbf6x0ml7cBb3VEyPuHw0iUJYJlaqrojOkc8U+iUUnp0B03YngXavjFMyo2ZliY2xU7tjgDoDI9Ws3/O8+et5s9fcW2lwiis+8fEbIvNQP0MMgOtUt+uXa2bzbNcg7nsneZdkfZ4z2RfnRkLlhn8WoGgieSOsmiHGY5g/pbJgsc2vRgqXdlQDQizPI5RJs6+12UEan6F66mRQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 07:34:06 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 07:34:06 +0000
Date: Thu, 9 Apr 2026 14:54:23 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	<seanjc@google.com>, <dave.hansen@linux.intel.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <kas@kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kai.huang@intel.com>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@linux.intel.com>,
	<vannapurve@google.com>, <ackerleytng@google.com>, <sagis@google.com>,
	<binbin.wu@linux.intel.com>, <isaku.yamahata@intel.com>
Subject: Re: [PATCH 2/2] x86/virt/tdx: Use PFN directly for unmapping guest
 private memory
Message-ID: <addNH83aBxVTXfKH@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005808.9013-1-yan.y.zhao@intel.com>
 <623ac08e-07a7-4823-bd0a-777d8df5c128@intel.com>
 <abubmi7BjMwgnrvC@yzhao56-desk.sh.intel.com>
 <b74acb4b-4658-4113-9fce-9faf972975c4@intel.com>
 <abu6MVdXar3MmTdF@yzhao56-desk.sh.intel.com>
 <5b3110f4-4e46-4573-b68e-54e220ae1c19@redhat.com>
 <adRTWttGqVfIHaNf@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <adRTWttGqVfIHaNf@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DS0PR11MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 61598841-72a7-4da5-5b84-08de960a6106
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: R9Oxim5V/xXmUb2I5ATe1ndPOuarjGEUPm/yIv3WUTgTaypnNQ4Ree9+t3TPFCFU8eEGnlJJfduoKdzX362+6+RBi4EZbC9qYelGYi4NOuubHzqFiNUMAo85tvJBnv+8rP8yZDLEr+TFoRPhT4ChbLxcnYdGW+khq5YiMrRjrDgIdPvyqAlkJgIKBIXH+hq9CoJX5HqqV9V45rYodGKGWy3fcNuLfGdLbHDkkHaeIj3nhMfNEZgWmj9098yMjrJJHtwknGHpf7+rtuu5ATlto07oSvwZdErmU1fqv8NVYRx19Zcx2bi5tV8HeWSEVSysYk3gMxh4GvRUhkLtVtdDOrJfk/YMjM5uTXj7RSVGyA/GhocxwNDlca/74eHU5XsaUqAuIA8fzAgDwB2HYMTuDwyYt8tbRLEdR/XHzB2XxbyRE6vf8ZcNH+OAIIifP9ROhnrtoyuVFi8F/vO/NRL/yRQZg5EeGnyKU24HVRV1Qwa9p0/st6iciBINlxlnd/pqZ5ULf84GXgQfYK4WpgOMqsCeX1lJHZFie8yAzxEYh1pbgGvmtUn4scaveQfAtCow5/Fm8gJ+NpDB7lk7KCUCQYCaE95/OVKSPhMgY74kBponRSWk2rJRQ3QufOFgEck/V9FDzItktmV9Kyj1z22LZxKjTeFe9utbqFrv4PiavZ+YQyhzVY3TbmKjHlW2pa/ijhiM1ud6sXzupct8eeYNgQNkiAKKBPJIGWawDwzrtroahWmzDiPYZhhJevhrZgkOPz3Mc9AqBJwwvrEkMnGV+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EpZg7PwFxjI5V7ranOi4HPH5nmm9Z8SjtPWxIY06vDFMUcjNAE1WdoaY56PI?=
 =?us-ascii?Q?Rkt+ZMtjLoILJVYY6v3fjjydyxYMYwIlCgyE+FMBatRlvG++rFXq/NW0UvCs?=
 =?us-ascii?Q?BY5TfF3DpdpPMQbsxAFYU9y9edE3PVEAGKFlQaGiwbf3FNLuITpTRABvxnX3?=
 =?us-ascii?Q?kTRdvDFexHts7IjKxtvvNG/WvMIiDD2g/gusATR88oyfQNBzt9L3Rg16q+za?=
 =?us-ascii?Q?U+GAsHj7KAcD94ypzKz3jmEwMEiBmvKCGF8j1nK64EPRI79GhBYcyxDl74Nk?=
 =?us-ascii?Q?F20qhvHVpS65XO70HtvzdJtTLHLTB6O/dEKWQzmtvO9d169tUSL+YhMbnKLe?=
 =?us-ascii?Q?ramgL+0ECmnlUyAXjJIT67wfCNGA92cCAaCeuoZcixVcclkJVqGXz5WyhcGI?=
 =?us-ascii?Q?rmzqBwXqjDXPwmvwn5iDdLfsqfLCdWLEGgBdhuQIVUazHZzm+CelGYk1XmTL?=
 =?us-ascii?Q?CG7QPB28vCKb3Y/ErBO9t4BkLNhx1mNLKOHKhYmGIYJCcXtl5C5eILca2yqF?=
 =?us-ascii?Q?ChCNq4Zs+gv3PcOX4wkrAYomY6CvYGu/6Kbe459omX6hE058frW5EpLcchHP?=
 =?us-ascii?Q?u3gT0eABCliTenNg5UVDUZyFacyWha5hJr0i4lzWzgHJKgowy7Kph5xaiTw+?=
 =?us-ascii?Q?WinPm7uVaY9Cveh2JvfvPgnh9zKI17goxBnPbUyMV6BHOSfD5c1u4imaRncw?=
 =?us-ascii?Q?SJ5qlebhIjsTYr0YTxfS3O7Phk1J3WIaQ4VEmWX5f2kspOYqx9SihWqP8mvS?=
 =?us-ascii?Q?aypnK0PFmRVP47qFgscj0O2z0YIjgP20JuUY+EIUQ/8yjRqw7DS7uu13r0vt?=
 =?us-ascii?Q?81k5fgKjZ9as9xAzE6kECMIQcRengyJxCGWF0RdwQCYmwLD6EvYJGpwbbUH2?=
 =?us-ascii?Q?ZhhbgvSR6fwk+vYZgoySitI/7jh+FkEGuWBqA81TTNDAvJPMFiMX1EbSCbon?=
 =?us-ascii?Q?/tFoONnpYux1Gg9uXHa0oNaQP2DL1UDCF7HhHF10id/NhL9sIEbOYDorLlGg?=
 =?us-ascii?Q?XhdHybAHcVCl2YWB+cPkFVGNc8s4LcIWC30IstTe5gCVUX+q28OJAnDPKtqW?=
 =?us-ascii?Q?ZbyXTeFqD5q8doPU2rOfsIsKk8D5mqD4xsJ34D7a18kV6x3RlgDyFHyhxhpu?=
 =?us-ascii?Q?wmI4e1358qRPTk/fSbO50zM1y+n8dRgtQDtaPglRoG04eY0GuzCRhcSS1l//?=
 =?us-ascii?Q?392aQoc6LKPb1UjpThpG1/KcfSK9GTpR+E16y11MPTGrF5P97zpX97pZ2yFO?=
 =?us-ascii?Q?vSaI26gVTFYWkpUUT6eXUmHVGHAS/nDSybHY1PRhEgdpsMR9jiYEG1pmaIJw?=
 =?us-ascii?Q?smjBT7ocrlVM7HgIgQAuom6AcIu5cBvxkcLXlH7DRZHqZK0aakAEX1x5aYy+?=
 =?us-ascii?Q?essLvtv7w9JzegI6v2utP89xs/dlY4DzKWl7BPuJxU/6gUGqbhIB1rcol0ZU?=
 =?us-ascii?Q?Ka0vI72FxfPrybwwb6uXawEfoz2smo2N6JP+upZF6En9RiHNBlgEJ7wFMBEA?=
 =?us-ascii?Q?kkgsbueGTNefh2oWp6p+vF+zP/05FTCrbgt2/9ZDZOXBedsXGxy8Qo90Ox2T?=
 =?us-ascii?Q?OwcWwXpw8HJo9LVLXpEndSv7x//wU7Mqe+xtM7FmgzA75+xJZrwUyniICCCc?=
 =?us-ascii?Q?PCMN9Fv6RiJOt+8JZ49T0azXOSncJefXfOiln/uuupdxV9Knf5YSBOP8UFA8?=
 =?us-ascii?Q?rWparggJOj2Rg5349HeCXBliUCKEZsAjF9GAHgJNNfMNoZBrA6D9xRMpz/iy?=
 =?us-ascii?Q?BUt4KwK35g=3D=3D?=
X-Exchange-RoutingPolicyChecked: CEJMwibTKGOpJBQlPMVOzFHnIOSzPlAxr8OPrNs6Ytmty+J6dhvBQcN1bVGarrcpfAkcPPkqf59eYl9Ee3m4z7gh729ctes8m9EkE6MAZT/7qJLEm4l/CujLVo456L0cnelQ+jAz3MyIItGtH38xwB8rWoEsgllW6qRiTOlYn4DGRUo2E9YiOlJpPBShAjQpMlzsZ2NSJvIu1PabtAb7XfIfmgZ+P7Jrh7ug+3h3KnrPtfG1Y/2hwjctiAgYYv7CLQVI/7OrUcYWE4YAKTkGulAXZjzp3PywzpJ1xoQJbgJG3MxvP+rzhy1UzLTFSgY5Q0Ou/QtNnFgeSDMTeRveYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 61598841-72a7-4da5-5b84-08de960a6106
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 07:34:05.9513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: megUExbKrsczae5KvwCX8AjmG0aYxHktC2cBwAcMNObVWHfTCX9vbZMK5wvVamSVqUNvoquu3/EodChFZR2rIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7444
X-OriginatorOrg: intel.com

On Tue, Apr 07, 2026 at 08:44:10AM +0800, Yan Zhao wrote:
> On Sat, Apr 04, 2026 at 08:39:00AM +0200, Paolo Bonzini wrote:
> > On 3/19/26 09:56, Yan Zhao wrote:
> > > On Thu, Mar 19, 2026 at 04:56:10PM +0800, Xiaoyao Li wrote:
> > > > So why not considering option 2?
> > > > 
> > > >    2. keep tdx_quirk_reset_page() as-is for the cases of
> > > >       tdx_reclaim_page() and tdx_reclaim_td_control_pages() that have the
> > > >       struct page. But only change tdx_sept_remove_private_spte() to use
> > > >       tdx_quirk_reset_paddr() directly.
> > > > 
> > > > It will need export tdx_quirk_reset_paddr() for KVM. I think it will be OK?
> > > I don't think it's necessary. But if we have to export an extra API, IMHO,
> > > tdx_quirk_reset_pfn() is better than tdx_quirk_reset_paddr(). Otherwise,
> > > why not only expose tdx_quirk_reset_paddr()?
> > 
> > That works for me, it seems the cleanest.
> Hi Paolo,
> To avoid misunderstanding: you think only exporting tdx_quirk_reset_paddr() is
> the cleanest, right? :)
Could I rename tdx_quirk_reset_page() to tdx_quirk_phymem_page_reset() and only
export tdx_quirk_phymem_page_reset()?

The "phymem_page" is similar to that in tdh_phymem_page_wbinvd_hkid(), indicating
it's operating on physical memory of page size, so it does not confuse people
even though it takes PFN as input. Another benefit is that callers have no need
to specify size, which is always PAGE_SIZE.
