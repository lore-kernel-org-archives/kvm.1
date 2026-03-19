Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67436C58C;
	Thu, 19 Mar 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773923979; cv=fail; b=jOs/NYsykf7+lOGrXOcUw0ezMBcl7j8XrgJmocguYPv2bgpHjGMTuJ1XrBSPQc6K9wDe4+Z9l6rOx6xEWWO3w5790zskpR65clL3Pp6Y/yUYz2Xtb6p+HYBeLoG44yPP9bLZoH9TCHBivAtB0fsKJqRtRGzSziP3Hi0u2l1vKZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773923979; c=relaxed/simple;
	bh=dzPe0R7Z1I5CPmjBSZ7+Dh0TCbyCY5OFZv3I0jRVx08=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P146O7D1Xvvsm1GyE0LMeFnXYzfF65rn11wbAEm7V2V1EPcEvDp341nJn16mUl6h84vdMuo1F6O4lJUzt5I0waAmRiJ1iOPOELWDJJG22ybYOmrGZbIiSpNhE8Hn8PryzG4iPwHKs5PDy6noCXHIAzjdde6eZUpJhwP21VInEH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrjP/Yln; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrjP/Yln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773923975; x=1805459975;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=dzPe0R7Z1I5CPmjBSZ7+Dh0TCbyCY5OFZv3I0jRVx08=;
  b=nrjP/YlnXfqnjP7TT4xOGrTK0ZkHdCoZiKjWkKEk0b/HLPoBavjTirTD
   wfADeMtSD6dl3kgyolliVF2eY9q2JbPl//1UIMhPZL/bJzriZhi+3UQqF
   dzKIbQT+HZcK1UAIh7Zo+kTutpBL9GsBFXaiw29uVQhylVxfI3VsMAEsK
   lDhIDlk3hXGBjFgm4DHuSozmcF6CQMb0qO633/WlwxYooilJTic7sA7AQ
   ubeeqAU5Xz4HT3paMI1dV/IQmDtDPFmlbunSq2oO3JBgT4Muc5YRPDb7g
   j4tgGlOpCucFVa4LxFE+hFrvsnKwJNVqqQKcD7I9+STdO3UG5gXvC3VQC
   Q==;
X-CSE-ConnectionGUID: MolQ1GhbRv+oeR+2NrdKLA==
X-CSE-MsgGUID: 9Wszsbr7QKSuEYvqAhJuag==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74880696"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74880696"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 05:39:34 -0700
X-CSE-ConnectionGUID: H/e4MTrHRq6HLTxqk9u0bg==
X-CSE-MsgGUID: VshtUcIJS8avnnWmNJXUSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227637786"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 05:39:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 05:39:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 05:39:32 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 05:39:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0UK5HVOQ9uYXn5SP3DiYYNEzFpbGGaMyZ3VK4Hlq+cSPnBEwEELAu7SCSe62dnyaipYeHUIPkjRE2DjxTDg9Q9Vc81nvDgS+tPZ7P/pnRwhaHa8UxwR3ybUa8JB4zccmeCFs4Uc/2a0GSJxpe0exYFC7BsKQcR4iFV/rspfR1dBQmr9o53zZd4z9hPSDXuM55QWwl6zDaHXvvMKQ8Ua9vjlljAuXalbvwtCER6l4+pr8yMpn68vps4Sx88Dou+hsLX6zrzbfZBOkrPZXMdNUgrkrO6Lf+jVlh3obZaF3pkjD5qVcBpEr8F5+4HlmmBwleMXVq3gd7GlnQGdV0CNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaTFU7/DB+abp34F23B+YX5jrE5hf0iBJ0MCVXbvg6E=;
 b=HCbS7tEnO5Ki1587Zv/XYZuIK5dGmpGREBbe7BoMOn1n5h4CgPBXgu40rd85zvC5egK8kS3TkJvXcQ5JZlZDsdAixmt2hEjOV7utGKsrbhjPky+mDQmNGSP4o4GNFOUREihIvL8c7qTGrX7Cezw/k6bta9PWq4M/OVy0myuZeRdVNaspcOBGKVKxSprw/td9pm2bHQzc67TirdKCQA2GJ2wNS7VRYaWP3l4B1FHDfXuYzaZjwQiJRvhSQvZoeYFuixfmrtGv3qTC6HntD5VJviMrnLKU7qowMET+86eL8PnXGPTPRaNpdX8jdYfcQbeK3CztrhiGs0Ima5CwWUIa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SJ5PPF50B3E12BC.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::828) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Thu, 19 Mar
 2026 12:39:21 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 12:39:21 +0000
Date: Thu, 19 Mar 2026 19:59:53 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <dave.hansen@linux.intel.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kai.huang@intel.com>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@linux.intel.com>,
	<vannapurve@google.com>, <ackerleytng@google.com>, <sagis@google.com>,
	<binbin.wu@linux.intel.com>, <xiaoyao.li@intel.com>,
	<isaku.yamahata@intel.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Message-ID: <abvlOcnY4assk8DW@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005703.8983-1-yan.y.zhao@intel.com>
 <abvR2A19S4ZtpAli@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abvR2A19S4ZtpAli@thinkstation>
X-ClientProxiedBy: TP0P295CA0024.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::6)
 To PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SJ5PPF50B3E12BC:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6af471-f17b-4759-d449-08de85b48b67
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aUc0GgdoWVRQFT5rMfJTBTwGPNqvCocqn/9VLkPLN6J66Ri5xajlw2IovsBr51ew37GXTyH3Zep6iFcX1YfmZDr7dG7xTiOhfEmFeulB4sppCub4sYVGnoIPCIOpzXOyBOF7aKLfyxV2bUjwInIRT/d2iB2ObN0Kw1dGVAsQ4iQndkPePJYiQrW0Scs2md1rN7tNEuWIVUu4iHML7oWRoaVcsuGdWoKc8W6E/yQBzJualRzNHu0G8/hdjDIBeWMrlCnFl53lgJjWAHg6sdxW0tVu6gvkljzh0Itsy038I22V7JvIKd3CVcH8/i3+ab/MmMciiE25ycLZQYxSbeQWJkuf33cYRae5PMVtEYicG3usyDmLSuwY1feT0zJHYDGy1k0zfHLCaM/3bS0IPtqJLC3LtbLuy2gB1DYG1qm5RmNmQSgdafEoJyUFWW9AywOn4ayO6buPcFiNJuoJghSK6MTN1j6rHdhu50JNnCTIOSSGGxOkCygmvt6t7PSvLzsl6Vog/JjTxFnz3wh9b6Ol96oVztT+eIARl6ZzSb4qH/eEDVsm1bWV/27JMmeMENCb40C64NqUxkQagHlNrzSBgU+Pbcfox5Ntf3Y/Prxz7tv9iswzIb3+78gGX/wa3+J6L6Bt8c98v7LnwXxJuspwIQpu28YVfSxifrvRG+Gq/F9DX/gP1zY5gelAIX5g8CfB/2YnmeK0F50vUH/sY4c/uz3YJpL4GeTIURSKRhSdd1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tZFWloEhdDTFZUKhno78tUH7iN1mxZN8FzW25paOCzJqtLJrOzWbWsvIywMV?=
 =?us-ascii?Q?kkwpAI1przS/HrQ+cymLGNMVvjOnK7Vxn1zp+Hgap7cWBlWKtTLL052YKQSB?=
 =?us-ascii?Q?3LOh6CMh4g0lhd9qQ4oYcRhExlv3PsOtJg8zHwXRhu+JUCvFO/ehfkj/fFJs?=
 =?us-ascii?Q?QSBHfDRElHNr2xzxePvE6l+3zK2km2Pezj4r0OM55FW5QbHEng1BK03n+9sY?=
 =?us-ascii?Q?ulr/KrpFxJThHueJI8BmYVE0ZhpckecHAwxoeK7vT1Y2iuyCZR7zSVG6sGwL?=
 =?us-ascii?Q?cGsTZRR2QmSJxeGqvYBVM/Exg/LNnVsvW2Z3q+YZQZBbj1+TWHn7zdCAvivj?=
 =?us-ascii?Q?JawAYKbv+B+XZJoS0J0ImzmXnw2f3eXKsIBajJmN0vVydYbSU9HsEBz7W7/m?=
 =?us-ascii?Q?tP67AO2flRT3sCIjZX3HwQeGc8siyCOHxdwWlVZbvur49vSe8GNnIsQ+vbk7?=
 =?us-ascii?Q?6z4B88JbfkfHZ+kNcOzC6zmBzxKX0Xdo8LfWGlydO1lkH9xIX+JI48TA2hpI?=
 =?us-ascii?Q?PXdiW0ALqSPxFLHXJ70e/akCZpdDWKDAAuPUQm8CK7lJMXJCtm13j9QHZOGC?=
 =?us-ascii?Q?FLoYx/kbyTxuMML88DNJNHJTlwTcqnII+ApsQKZmNEUjB6TpN2SOTv/0kL9L?=
 =?us-ascii?Q?Ms+AsAy68jYdsjDaY+p+gLoDFy4/FmCmT5en80Jj7MAdBM6AEwlmpRpyMnEK?=
 =?us-ascii?Q?PZ0MgiD7BKalsfKBTY5+Gw1z68Dr5rb//ctXIz6MdABHVWLnCYklAdjjStaM?=
 =?us-ascii?Q?gU3qwyCDPCR5ES77y2sjwNs3NNdgwY3OjbEdCwP9VlACRTZ9NiuIwEXxFXjk?=
 =?us-ascii?Q?Bw4EkGOQnfauP+k5Bw0n1lewHASaeKePXx64f7anKtv0a191RAPAsn6cdJaf?=
 =?us-ascii?Q?UOZ1TvdTjp+vOtPm2spg5lWF1x5+TTpxT5EnrfzZPuHO6cS1/y2IYr0R9wb+?=
 =?us-ascii?Q?/Uw2Ij7y9g32zYbz1gXAfLt4luTsV1QMMcpMWPoepdc7+J30Sc4YznNy+Np9?=
 =?us-ascii?Q?43zBccQokKpmHbU+TBQOKy5t4+bChQaWu+vEhqQML/vYxcc2EcmjCg6OZz/X?=
 =?us-ascii?Q?/AfhEfT+yi2pRspCsJ1U87SSK+km3GIo7OaMED25Mb28F1PvK91eTy5tFTH4?=
 =?us-ascii?Q?watr/tLpsaqIxsbaWg7qV+VRTjX8jgf9on5iFZkZUdpQUHnmu1Ba4cqja7+R?=
 =?us-ascii?Q?4ubCnotHVn+8T27nepIMfWHFghsPeYzEnHcSJF/9OxthS4zc5THX2hOJFW0B?=
 =?us-ascii?Q?QPAJHOIhqHd3GW40EIUvxQnJj73JuumsW9XldEjNtbRogR0vNjfGN7R+ATuQ?=
 =?us-ascii?Q?5Y/YVgxRfkpxyvjw3Rlbimv8hPVN69eqS2ecbnoI4T5CGSCuu8rxPx3nykHL?=
 =?us-ascii?Q?PNSxoAk8yNH+FjwMun1NHB3W0Crb58vwWdAtfh/fb3uNGAmZvDhc6Gz9MrLp?=
 =?us-ascii?Q?BndWYSXjX8hjChCRVq5L9zJctpyo2cIsDWYnBsd+YEjaFcAWsn3OUvxYWI+w?=
 =?us-ascii?Q?2KhlacqLKEtRI/aOYRh7uZO4OkzDi7P+mSWvpW3nUhExT9b4a+HIbksErjim?=
 =?us-ascii?Q?7D3pwKvfTBpAor7yQKS7B5NiQVnUwY5r2NlDrr6VYo2k0llACA7THVVwIUeo?=
 =?us-ascii?Q?9JLuyKqRFk2QugZiAY8n71wn6NFcBRMmkY7dOppW5eB94Z3iYIspborHa3Sm?=
 =?us-ascii?Q?8ZbqORqeRDVB1RIT+2Ggi1Q3XGhrHCaaImoNJwIkVEmB6fkxC+Lld7lm2ioi?=
 =?us-ascii?Q?kfml+WbQEA=3D=3D?=
X-Exchange-RoutingPolicyChecked: HA07Y/jM8/eWb/1/wuVjAVgpyODbVmGCOFAUSqgRVIQ+KyXCJLg2piBE0O+YbN956Mszo31k6/YRKrxCuxoNNJIB1B+ep1PVa3Y1lMUodRTxMthh4e/rROGj4ahkGCW2dxtLAN7KkXkieqc8shkozMhXthjebZl9TSwZ7/02vg6DcaJZVWJuojI+ecCYAjuLvi+PEjt+eSlWYO1HYkOpy6O+0ESP9L5cxO3OlYoxAN0JhFF4+P9WPRsAjVCTneuFx3SANvdLZewAQ3ojG+zoGyHuYXVLhouFl2Ea293dOc30+bGAu1f8tBVIGNnioKlHoi7vVjEMC8Wz6gwuHZkLig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6af471-f17b-4759-d449-08de85b48b67
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 12:39:21.4253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPDN8eg83KHUKwX/sYWJmLYB/V74Xdnjo+UcEteZzxBEnmHwa0DFCT6/prFVZhSHaJIE72IIpAt7h7uqhPJWoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF50B3E12BC
X-OriginatorOrg: intel.com

On Thu, Mar 19, 2026 at 10:39:14AM +0000, Kiryl Shutsemau wrote:
> On Thu, Mar 19, 2026 at 08:57:03AM +0800, Yan Zhao wrote:
> > @@ -1639,16 +1644,17 @@ u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_page)
> >  }
> >  EXPORT_SYMBOL_FOR_KVM(tdh_vp_addcx);
> >  
> > -u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, struct page *page, u64 *ext_err1, u64 *ext_err2)
> > +u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, kvm_pfn_t pfn,
> > +		     u64 *ext_err1, u64 *ext_err2)
> >  {
> >  	struct tdx_module_args args = {
> >  		.rcx = gpa | level,
> >  		.rdx = tdx_tdr_pa(td),
> > -		.r8 = page_to_phys(page),
> > +		.r8 = PFN_PHYS(pfn),
> >  	};
> >  	u64 ret;
> >  
> > -	tdx_clflush_page(page);
> > +	tdx_clflush_pfn(pfn);
> 
> This is pre-existing problem, but shouldn't we respect @level here?
> Flush size need to take page size into account.
Hmm, flush size is fixed to PAGE_SIZE, because this series is based on the
upstream code where huge page is not supported, so there's 
"if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))" in KVM.

Though tdh_mem_page_aug() is an API, it is currently only exported to KVM and
uses type kvm_pfn_t. So, is it still acceptable to assume flush size to be
PAGE_SIZE? Honoring level will soon be introduced by huge page patches.

If you think it needs to be fixed before huge page series, what about fixing it
in a separate cleanup patch? IMO, it would be better placed after Sean's cleanup
patch [1], so we can use page_level_size() instead of inventing the wheel.

[1] https://lore.kernel.org/kvm/20260129011517.3545883-2-seanjc@google.com/
