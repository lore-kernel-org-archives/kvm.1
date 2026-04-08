Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC692E7F2C;
	Wed,  8 Apr 2026 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775615393; cv=fail; b=CvY3q4g/7ZIIS2W+K+6DsFH2R2rCZHs4eKmJKTrBROwYmvTQlm66Gx08N7AXkv3+Yi4SgH20WtTS3fXgvc1Zpz8W6Xxragy2zEmJNR6X+RWH+wmMw2cPx+bXxLY5Sg4SWIxbl0WL8rjfTJsUxz1R62yV0P0F7AUe71Vq8HFA6E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775615393; c=relaxed/simple;
	bh=GhTWsCteYS8Gxk5T1dTMIS4sNDmTkRCM3q4Z88hkCN4=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LiXDaWoz4MRRpCBceiTyuqs0fqglxaqvO0EMq+fj6CggYADKpof/Y8KNcTD1A1QqzKy7g5Az+7XRLLuCrWaH72P7VRIPEySLpHXQPspcTB6qTTc8+bey/leYcaMmNAWUhGMe8yr812aGi9uPKjNczhlV990sjX8zdy2olOLw+vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpYayz2+; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpYayz2+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775615392; x=1807151392;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=GhTWsCteYS8Gxk5T1dTMIS4sNDmTkRCM3q4Z88hkCN4=;
  b=dpYayz2+gOIzJ154km1VmfbwP4EbmHGD02FLvmPovuU/WCfcE1V/koSP
   2R0IGGAblnYFwRqcTZJq2R13T+Vl9NbB2oUyfxs6KgIK7cXjzvD8zg/Mv
   TqEJmouZD57SQ5u+nIF16df/Mtg5X2gxBzM8JpFK1oDKnBgh2nraMVo2C
   m3cqJBi6qX9WEJXos4NYwpcGXQZ+qHZWPLVRRviVI4N2UBhhbdpM2Gd19
   XyS5FOv4Zr50HWyY/F/ARSj42eJ2VT6z0jeYp6hTLpmBPFypE4Mrig2Hk
   4o+fFar2Abw70UOyGnWAchOxN+Rf8vVk0fRXcLfklRxzAl/tfxNX1lWFK
   A==;
X-CSE-ConnectionGUID: qGgdf2mJTCODTXxz8xoGAw==
X-CSE-MsgGUID: Spng1oW/SYa0gyBouFLJbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76777726"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="76777726"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 19:29:51 -0700
X-CSE-ConnectionGUID: xpVjVdr6TWGaAfwmkWx4Ew==
X-CSE-MsgGUID: c7GFiaQWQCaSrtH2SzPVBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="228275120"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 19:29:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 19:29:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 19:29:50 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 19:29:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMU9qbrtH7Ew2sQ3MuwpwLvNlI8Fqhg6FjK3qBx7tkazIvNhqhUvwoAoDZi3oVIOcC5p7It/dwrIGncynP8DW6adEAmsDp5pSUB8ubO/oC3cphrfZtIuljgJYHlfVWz56qeSLMrWOSkh2NES0/gq44V5tZTn8nmjX1VtQMPIVhMDaqbtBiercn6Y8m0UsJ8hgwvH5ejNV/gjBeYsNOeZXHewj7XhXXxUNFWA/BtAWx7HweiakPyE8HCH7R089oO2MLn4/dODWmZYGqP/ON11kw8UaX9+dYpIT+vJiXT/lz6XjfFW7bmUCvYivwGvuVd+bAjGN0xGESU4nJpJqi6F2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L426dMsyWI5RfcOs26VPhTSpysG55OzrUnmuxHavazQ=;
 b=lJyVijAUEk9xKviGdKhuSNOIGkmEHMAUdQmY0GW7LEIdumTabkNydkPjMYxOIkKCTWBwHQY0Ia6hxD/0VW1LgVebbJfx8wD4ab8nD2ioLjDDn+Thd3Id5mwDhIbzjxMUGop+Cd0DRU1IwcOG6CY3LyrtqQjegpkE378ulGM5T6+bo9SO/tZ72ThKocsWS1u1HvnBlz069KvcqlPch0112VHCaC6QXTDfrEPtyhpG8ZU9tbKXHwMnPIlFGg7qIxmwEIsuKif+sklqRtZvMtFQp+FbCuGgIP9DGXtVV1zMzUIXKrPQhQzA4UMMFh3L3mGZmRhjN5Km0iKJjzzzTq2IaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DS4PPFC60125F65.namprd11.prod.outlook.com (2603:10b6:f:fc02::4b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 8 Apr
 2026 02:29:47 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 02:29:47 +0000
Date: Wed, 8 Apr 2026 09:50:10 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>, "Huang,
 Kai" <kai.huang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Message-ID: <adW0UnemWlCBa11c@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
 <aczYjEVkva3zOpwz@yzhao56-desk.sh.intel.com>
 <2b1d462bfed958e163eef913a1149a807453892b.camel@intel.com>
 <ac+XbE/EfvV04mkz@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac+XbE/EfvV04mkz@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: TP0P295CA0031.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::12) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DS4PPFC60125F65:EE_
X-MS-Office365-Filtering-Correlation-Id: 92687ac0-ec61-4d4b-a808-08de9516b3bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fldhkafQY8q3q3XekwMRBBZ14Nqu71RBsLrGw5Tja67V/cEU50FQATxmcMyeDK5vP9k5fh4WUXi4guc/WQsmWiWdeq0ics2/blzVZvKsTxri1/WNdUGFG7xMdDZkISXTBAra0XPplOmaZx+8ZgeDZY8+Z9RgWp0s/NeWluFRGCgGp2r7FVU6cTYvAAzZkvJqK/1kzKL5GbQIKvL67LmrtNa+FDGv1pZGYZuCka/5aO9TpFLBrfGvkRyqAVyh0B92/6TFYm1HXynzu7OHkXsZMm3sdPBNeS4B5poDdvIx1GEQRQNd5iHPAzdusTH6o1P3U3Y+oG9v4L+bahakkj6/vvhhApwYgEX9qvWrWwOBzLrxKjXWJpOuFrweb7AgoIEKxsJXiP/imprFZRbDd272y3RjH4pyXzUjiGMNmlO42m4MP5+1dR9jFVj+dFakntrzXE88eNLJ+uJX8zucfnxVe4zTQzqEhvjcjQaH+CqZUwKnLHi+rWK0A4FhjhrUr5zVUenttD3/n1MyLC0Zsk4espIne4WjUr0m+VHp0ReZtkXtBSbW/ndiSWMgm1Y3h71WezLGt2cqu95HNIBc1zdS5ZbPQBXksWWjmRxfKsuXDnhhTk1jzQEjQ3BUFb4gkfo6kE1ccu8YQwsEfuHx5wXftW89NoYcrlV0LmnwFi7F16b1TkKgffv0BT+P7lZhvE3hMKnhf3Ic6Hm5xjQ+AZj8WKl4hl6/0Lq9q8hPq0soR6Rv8i6bsbLMF7SbCpLUeFHHQSzG/+O29EZm4jtLLWyHxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XQbKs7W7jd0AEStVg78mvaTVc9sS64+aQhGOL0vTTx1+vjQmVfDQCTi7hCMY?=
 =?us-ascii?Q?SIiGDyhlC555qrJQg2IKym30FraEnHOC8TBLj/bZ6BL1m+SwMYR4/c/WU6SZ?=
 =?us-ascii?Q?zVd53lezSDRbVU1N591WhhR+VCW+XNMjYIxmFEp6gDFLbSVBt6R7fxpA4zsn?=
 =?us-ascii?Q?5QI6C8HklGFRsiyXmPe975KcQL4tnovYzwBxZsL3coZ927tcZSY9zGxakR2u?=
 =?us-ascii?Q?EpXWiFqP+1xK5PI2JVf5lWc8vynAHbhlPt8cDUlv2eiFKeWS86TSRXPCsmpt?=
 =?us-ascii?Q?/bg2YXG0fjzg8EKuIcQS3RRk2ODZ7vPUVHo/4iHj9X++D20QZmzf8UidRikb?=
 =?us-ascii?Q?qybwl2q3DYdmIOcEeTwxOApGWdaMF9tQywjqEpN04TMCs3L5stsAYaiC6aXj?=
 =?us-ascii?Q?lnQoHSNTw0pcHMwNpYan0xJ/QmKG3GRHa4hpve42vhRfAfKLFzA2TzAHe25n?=
 =?us-ascii?Q?K1vEb/XlVSOb87enP7qQbn5AoWXQN+sCO5UoSN+byaahxW1Fba/mUrArs2at?=
 =?us-ascii?Q?lEHGVNQQW42/mLRONSsK/UvmCczKVRTnYkT0f1CP7/qCnCn3IDJFznFK4kT8?=
 =?us-ascii?Q?zrSx4lsYBi1e1143O4XNCeE9tueHoorBLB42vs3V+FP4ypIUUj2GtZUpQYkj?=
 =?us-ascii?Q?ehYseywn63lh+ozr+gzKuavX3+GiLyvmThSIkplwtv9leUVJZhipjY5iDLhq?=
 =?us-ascii?Q?RUmQBLVeVn73PBI8GxJchkM4rylRo5PU5vI0z6L7LPQh5TxCz9IMPOQNZIIz?=
 =?us-ascii?Q?/ywIxIeANe3LFzzk+Gc6ik8bi+WJcL6Ku+zsVeDHtC90HPJIjbS5KXGqtgtr?=
 =?us-ascii?Q?i9S2ZsYpmuK72636kBox+4F/nrY6DNtXZrT3iqJu0xPkTgTX9b0mnckgWaeN?=
 =?us-ascii?Q?m76uDfxz3Zy/embgJLXCEAv8Qpi3rcrr1sT9xNSFK+qTKNwTI+Hyp0xF9p/j?=
 =?us-ascii?Q?6T0bIvYFwEWob/dvvhZMkKJjxo3n3JRrvJUenw3TXMDWDUdVDgTGk3BGwtO3?=
 =?us-ascii?Q?pvIsSDREl2c7Z+9QPDsFFtiu+BVv3iSS/dP80096ORmZBvpDzWb/oLf/jrJ3?=
 =?us-ascii?Q?3Ds5DnmBQeTxIUcw18tMAuSUGv8MAFKYHcdQ4ypu6U9AWt1vgNd1goTL3KVM?=
 =?us-ascii?Q?eLQvirmxj2y4gLL/yrnxS7qYpvFhnECWscs04Xz+dxK+Kb9p9OJMk5igeW/d?=
 =?us-ascii?Q?F61n8Zp6w8IWLZZQG4ChLjR+a2fns6P/CCi5N4TwmDv+bufW7SLnme5MlF7z?=
 =?us-ascii?Q?ireY2bq8KsWb8qX06I56p8ls2WHxZrpoQFqPdIRnHV59pdM+dSsgSTG8hE3c?=
 =?us-ascii?Q?Ize5XwZI7pIQgp2Eiob05OqwQgMWjpRt5B+TNVJZP/4fMt5ioEKJlH7gpZvo?=
 =?us-ascii?Q?LXrTcLj10ToBXmlS6ikps5WmLOgB+HGVtAYRtaCrHKsT0mcF/FxAawZoA/0x?=
 =?us-ascii?Q?SHfPvLbzhRpiU+oLkl98tgyLtjaUCEqOMP0+SC2dyijBmbV7g8i2bIoc0vLY?=
 =?us-ascii?Q?QHNuxhcpqxuQ+SN9ZjxB9Rjw1wFRQPUjlxy4x3YiprhQ+I+Oe979G2IFAANv?=
 =?us-ascii?Q?2lESROKwJ3igz29OtcgTNkXsWwgr+3DyQx7oEdMALAQSWquXNjiLdOGKVkvW?=
 =?us-ascii?Q?GaZyLAh9/1oW88KqaI86XHXFpUq0N3/TvYFxqpuG2cYMtoMERzflWdngOHxW?=
 =?us-ascii?Q?SqDhyEtB05+zJRkySZIuHRD3sI2ZRMeMBTbn61gVJ0nH7gKS/3FFUG/7rVqd?=
 =?us-ascii?Q?aO+dGIQHhw=3D=3D?=
X-Exchange-RoutingPolicyChecked: QnfxjMANdO+t7YhvdMedxijFlIptNdiICLtfyks/5nfIBkOeuELNq+l84EFIk/r3+o3fyZaO4J/fOWO/5gROyeZaw+mST0cxScuLcBYGTlr+bytsSkq1Y1JCn9OQESxWSIyPn2blJz9/GEDQROjEnK42iYrLFRPyWzT9Qo7LF7MV122JwT7GWpbLmUrzdcpNrEG9ayjsIj5PI1XZQWIrgs0TVnYTKpwj8vVOD1t4RBz+fwNqzhLF4A5CCc9/T7rqEGa93Ieqq014WkAtyHTjUUciifSzaIMhV5g74+OkHqbSBTxjOHWswBrDhbijvn87U0+ZcRjH+fWbXzv4/Cw8+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 92687ac0-ec61-4d4b-a808-08de9516b3bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 02:29:47.5060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XI6fsrzl+Aky8CNIn7nrJPW2dwBJTN1zkYTtTM+KzemwZDMg4h/oYeAAVEBwWM6wQBKePvZrDR84nAmEAC50A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC60125F65
X-OriginatorOrg: intel.com

On Fri, Apr 03, 2026 at 06:33:16PM +0800, Yan Zhao wrote:
> On Fri, Apr 03, 2026 at 07:46:21AM +0800, Edgecombe, Rick P wrote:
> > On Wed, 2026-04-01 at 16:34 +0800, Yan Zhao wrote:
> > > Thinking more about centralizing TDX hooks, could we be more aggressive? i.e.,
> > > let TDX just have a single hook set_external_spte() for propagation of changes
> > > from mirror page table to S-EPT?
> > > (below change is on code base with TDX huge page support).
> > 
> > I was asking Yan internally why this works but Sean's earlier attempt failed.
> > Yan, let's finish the discussion externally now that Sean is poking around.
> Hmm, I guess why Sean provided op reclaim_external_spt() (now named
> free_external_spt() in this series) is because the old_spte and new_spte
> required by op set_external_spte() are not available in handle_removed_pt(), and
> also because there's a "call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback)"
> in handle_removed_pt().
> 
> So, if I'm not missing something, we may have 2 options for further unification:
> 1. pass in required old_parent_spte and new_parent_spte to handle_removed_pt(),
>    and invoke op set_external_spte() (instead of reclaim_external_spt()) in
>    handle_removed_pt().
> 2. as I proposed in this thread (see below key changes), assert that RCU read
>    lock is always held during __handle_changed_spte() (which is a reasonable
>    assumption in TDP MMU) and invoke op set_external_spte() for reclaiming
>    external pt as well.
>    
>    Though invoking call_rcu() occurs before invoking op set_external_spte(),
>    tdp_mmu_free_sp_rcu_callback() should only occur after invoking
>    set_external_spte() due to __handle_changed_spte() holding RCU read lock.
>    
>    However, I agree it's odd to have call_rcu() invoked before reclaiming
>    external pt :)
> 
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -461,9 +461,6 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
>  		handle_changed_spte(kvm, sp, gfn, old_spte, FROZEN_SPTE, level, shared);
>  	}
> 
> -	if (is_mirror_sp(sp))
> -		kvm_x86_call(reclaim_external_spt)(kvm, base_gfn, sp);
I'm wondering if the reason Sean didn't unify this op into op set_external_spte()
is because of the return type.
A void return type can make it clear that freeing external spt isn't fallible.

>  	call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
>  }
> 
> @@ -563,9 +560,17 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
>  	 * changes to the external SPTE.
>  	 */
>  	if (was_present && !was_leaf &&
> -	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
> +	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
>  		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
> -	} else if (is_mirror_sp(sp)) {
> +
> +	if (is_mirror_sp(sp)) {
> +		/*
> +		 * Can also propagate changes to remove external pt. Since this
> +		 * occurs after the call_rcu() in handle_removed_pt(), the RCU
> +		 * read lock must be held.
> +		 */
> +		RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
> +
>  		r = kvm_x86_call(set_external_spte)(kvm, gfn, old_spte,
>  						    new_spte, level);
> 
>    
> 
> > I'd be inclined to kind to call the cleanup a win and leave further unification
> > for the future. At least not going turning over rocks.
> I'm ok with leaving it to future refactoring.
