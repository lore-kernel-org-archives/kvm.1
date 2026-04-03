Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0582222E3F0;
	Fri,  3 Apr 2026 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775214777; cv=fail; b=meF3U2Y8dUw8Kzz3naJ/I2JnahhpiQN8/2C+GtBdd7Kf1h9zOI/6PXRr5M6/mkgbR2z/HX1NavqYe1Y8rO8nTjVwUyMkh4rnmXhA2d5s4sBlUydgO1BxJQIgC3Lh33Rvor/0IVJUPC09VhsFTuNdyf8cBOpYNm4mcj1Lj8XF0XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775214777; c=relaxed/simple;
	bh=ORQ1EB5TqIyKWpG+4EnQpjBwTYjBDcYJnilLVUfJ19o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WoU0IYmbVBeSKGSj8CZbdgffOHXkYHI2rYyr0IJYhvfikrWXWxsKLr5NfeUuIH2o6v5EoK4q4YN2bYfuaNpdcWYuBGhpKZCo+rmS5K5I4bsSVeYLiChfReihKdJrRuK8Twiw066/2+CbINku/hyvIvDJNcetY2tdt77Z/F/49E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZZDLq/x; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZZDLq/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775214775; x=1806750775;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=ORQ1EB5TqIyKWpG+4EnQpjBwTYjBDcYJnilLVUfJ19o=;
  b=kZZDLq/xcpP8u/ZLqof5R0KbbDmPJ9awKTe2yb5n4vmhELX/+gB8q9ye
   VMHU/7SxyGpekPV9cVTJjx2qubDVE0kJ3jtdyeWaYd4TkTaaNgnlZ6eS7
   LyDkspqoPvqzWUe45W4Z5/ggMdXquJzYDgqIysrapaMDahYbF1J+iockU
   vHXePB7ht6Lhr6BC/6doko+dyw733Y5Eb0c5wXP3gmk381FUlZn6klpE5
   FyEZEHeNXmYuaHtloHghaLT3/SnSvJdsB5WxquIDcoDcoxTvT/bN11g3E
   iZgl0O1RONCuE8w/LQMuKxqO2oNQathj357JpAQG0VXD5XQH86ncfw0yH
   Q==;
X-CSE-ConnectionGUID: jEcVUMZrS9uiVCByLU6c/g==
X-CSE-MsgGUID: TfeW65VmSOqfXgtjVMLG4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76162415"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="76162415"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 04:12:55 -0700
X-CSE-ConnectionGUID: 0PWQpqq8RyOmddfWVpG0ig==
X-CSE-MsgGUID: HrrqBEoDS9SAFhc8UN/zag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="226393254"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 04:12:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 04:12:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 04:12:53 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.49) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 04:12:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eK2MwOM4mrybEHHYlLB9NoAvHA1JOJ1iadbsYyLNxKV76oh0ij8LoExNUfKsaed0KoRYaD9q+3R75ctEOozuwc+CdDCCEZ3cV0TP1nb7iG/gtQZ89EdIC6AVgzt8kFwe3+GKEfKVO0rbMDtFIyQFUBD2PwkEkwqTdBD0ZHhqJ0jQdGih2ked8r8089mwunhZ2707jhISGYDWQEC29Ofgm75Z/cxB+bZRpIRlTrwHbXmLZYzO/3a5WjzoWO+Xuw1liJiqYD3Hb8z6qAbwUfMsaAeT76Rbwbbds3lJo3GlKrV1uddh+nwh7kL06oF8SiDs2uiuj33Tps1gQRipXthNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In7/+HAfxTazebDtQHde18giylCQm2SauQphd0JDOAo=;
 b=iCCySVj2bNfOhmx8VG7iMli4H1KWsYXZpijPrAcnRLRfnBG8s7BqG+YtZi7//vJN1P+dhRMyB2aGapgfNgd+WsH/gYNf3fF4ch6rsD9taJnEh00BkCMtI3LkS52uvchmaOmfDC/6kOybB6M8vVD0+JIJoKa5HVeiLlCw5P4ESSmC1XWGRBj77yzW3RFQZmFY+Cx756lkUKnDLoc/57QZd5KNbUSQrj7wEvEZMq4YX502k7iJ3bnxRdwwBBJwhjp7YHTFjS20XG8LZXP2GHO5pezXOzC3J6YIr4+ZQt/uf7/tGkNSMjTdl6a1CLjROR68GjO5PeCd0E9lWwFSt00tQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 3 Apr
 2026 11:12:51 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 11:12:51 +0000
Date: Fri, 3 Apr 2026 18:33:16 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Message-ID: <ac+XbE/EfvV04mkz@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
 <aczYjEVkva3zOpwz@yzhao56-desk.sh.intel.com>
 <2b1d462bfed958e163eef913a1149a807453892b.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b1d462bfed958e163eef913a1149a807453892b.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0037.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::9)
 To PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|PH7PR11MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: b54f613b-692e-4eb7-52b2-08de9171f1cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: EdWcqIq4Bq5cHeKluL2hlFGh5fSgXgp9YUwJ6BxJiOT556iKN7Bt2RxjjAY5i94o4OH3brDwd9SP/q5L8unQrXWK1DD0VDnSVsIKrk51Ijy30UKuOoiXQ9KzwjnP1nunBNjFxiNdo6+RSlCIao3Tt1FV5XPPRAb2ivmvs3a/b3sgVIoC2FdbXSy2dXaVZGTCX9Pja0BDovvMWb1mI4c8Ym9sBhy75EBKZup56JtIkmcHQnEKhnEUuH6MK+d9oDq+Elj4H9Gu5YDBriiHfyiEczbS+PqmZ6YQ6pghgpfayQeAMcsKc6Vy2DFk427xY3GBi8DBD4MhraoVIi8VNBaYw9pYRl9PYH4mSLjMk/w2/Woj+S0Hfe0ozg9SdWscOrr0jVGG+jK2SRqA6kJYh4hZbsFTltATr/zW9Kq3rQ79b0fbJaM3yokOt+K51KjAFWk3rDBCKOAEenC+eIdi6nM7rSdZeR8RcBMUtKcigdcq+M7/6B4BNHkV72UKHBJJ5hAEmwItcEEXj2mwaQKO4kxvNseB2unUgHe1Px0TJ31R+GDtD8089ZjDlRipaXiUM2WLujqK6Zo0AYZZofJcFLOgLv/oR4AlLekylgDXrMb6AK4l2MJjt18lW4hBj2qov9VpLhU4f+f59i7kDPukOEIMbHIQFexwRqrAVeNbpdWNTEzSBRf0vc+jsTNICb4i2vikJVsXwGcMbAyZwyI9bObLW6HGxY4r1wgu37ffpJS3pzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bRVOjoL6JFc3FTe4wOdPA9fa8orM0TcAcj4CusYaMItes4uK81tWgJAE2oHZ?=
 =?us-ascii?Q?8BYdInATFs2MsyIFWzgSJRmpnPif/Kf37Gi6QCpws9LTGwDivaha2tHTlaeC?=
 =?us-ascii?Q?Vf8njwRqHr40S5iz3pFhMWI93TnykKQSQhYblHCD7MrVs/jNNn5ZNFSW3qVb?=
 =?us-ascii?Q?ybGug/oOcb4fS27vnlklisnXN7ljvHGEi/8O7qoaoiUtiYmEAylsKLQCHEBs?=
 =?us-ascii?Q?Eh9akRKrt3szpQFMJdf+Vbhlt8fYzylHlrnojB6xPANtQI2GrLwWvllMDNoU?=
 =?us-ascii?Q?+trY/iaXDwHOUfn+ZxmIlwH2LnVhWOCtm1tDrg7mc2vkWULWoIx9i6VvDgzW?=
 =?us-ascii?Q?naiHJj5FZLNYojbSWizSKqv2pMVE9M106B3WiJ441Pgapxx3dFnHmdTcaLIV?=
 =?us-ascii?Q?Yp+yht8WmqnTP2NQpsJa7z31v7AP/PVAse/+iadTgCkwZ7SZJNoV9lBVwKL9?=
 =?us-ascii?Q?l0qzYDhtTRQ3fOX93jxk/w7Op2i/88oaJ9b0RClWnha51a9cwtXpVzfyn4ve?=
 =?us-ascii?Q?PPC56r+LRg3Mu5FqaSL/c91mrD1SRmNFt8nkp3nokVx0TX2SIdN3zdRIreqL?=
 =?us-ascii?Q?f+KhYgU091qKV9TeANyx/ZuXIlpuTGytBIqqW6VW2mftJgw6869+05LFtL0Q?=
 =?us-ascii?Q?rs1ZhIfkTmrW87CriRYtnc0bEejpe9jZEV+uQjpZWXhvihGFWqE94gSSBB7/?=
 =?us-ascii?Q?zYexfFev68b+TqaE+AfAuOCDsKsJ3QGRSV4i0aqyYDZ4jgdbAOhBCgUUW7Rz?=
 =?us-ascii?Q?m1Mh1tY3fY31juLr9BGQLZ8UpOgu4bpf4dl7jVfaLjl65Bi1/rrwAVq+KTQ7?=
 =?us-ascii?Q?ryJi4YbV5h7CJjaz39epTdo4KzuvhyFM3cBFr7s0WPGAJ/GpYAHHP8CFGMSK?=
 =?us-ascii?Q?DctKDAPj7PJ9UCsOZjpfRjweqi1GsNEAO/wCe9K8L4K4wnb+rLLtK/yNPy+P?=
 =?us-ascii?Q?e+j8/jWBv/D8aaGeq7xa9Zi6yoYs6opiVNMDQLLYVcwOZBvcHgnE1L7tYFVZ?=
 =?us-ascii?Q?56t92Df5L64UUcitDM1F/y1FAKyNc5o9VsrXf8OBPXqYe/XoLw2b2k77mW1f?=
 =?us-ascii?Q?zEc9ShUMZptHXaSghOkJJ+peeKyMeC+axFAqmb2Ndtr2G+4VCcaooK4Fdln2?=
 =?us-ascii?Q?1dyRtAhbMP4hruAZ4otzJ7/LSktKSvzmz9TV2KqMCysYBkAJ4/vjb4vnt/I1?=
 =?us-ascii?Q?QeBkwb5xMEWNbfpR6Q1aKEqvMqoZvmrDIz5+xfkGqpkX2QOQxHUvYhIOMBxR?=
 =?us-ascii?Q?O45GQyIZLZGsMUaSIWHfaVN4FmODMSXATxt//X0UgkAucWaVj10JxJeByxGl?=
 =?us-ascii?Q?vBPPjUPCWXYeNm7RGdzm+xl1v0oL/BQ/RdvyAw1QISkiHthUlfdI6iq0iEcI?=
 =?us-ascii?Q?J+8yqnBCEm5TCMTOzyVL3EpcYRhTvChAVGegTV2n+8Ll/Xfbmo5aDmN7eXDc?=
 =?us-ascii?Q?LhiJ7kryhc5CXLaIOm7JlU8mEw01oETgFFcypYCMMX5Gx5vDxNJklGpcNt1I?=
 =?us-ascii?Q?jBSMsEpZ1QLg2eLkcAH6XyxuAhnkuagNA0QhiKQq+WzM1z0IVY1Yo3rouyHZ?=
 =?us-ascii?Q?nPsmXwtZPPaKSnuxVCJinvPncrxEv5yGPYiEG/ymaA+pcHA57JWTka0ArY5K?=
 =?us-ascii?Q?cLB58MKbzvyGR/sRZEnLQvwSgNR/6JiVVK5oUJ5rO8ku9hZLeIG+dksi21p6?=
 =?us-ascii?Q?NV/4VzVjdUvuSG7BnvRhaXtMDoH/q/ZVgkss6sIi1H59v34+ilixERQ16Dxe?=
 =?us-ascii?Q?DS1H2h0KwA=3D=3D?=
X-Exchange-RoutingPolicyChecked: reCm5yRFNZX/ljUAG47XigHgqbwiGA3c9C+oiYtqLBVLSY1xI8mTIqmWQzA6CkMyg3R2ekMmIuSscMS6PQZaL8LJG37goDqNtmfOPJHxalGdkQLY7bzGTUL+a1cJogwK5rtXrQWuxv/EerHTHFK2s5hjlV/0HNdWz+8HmXyK/eSw+WNDPUvbT6PP9D7ZMTKQjiPrbDYa7I5QWEFGeTXveRDGJRfa0x5g8PzNO2FcbTyjR/JQCiU0DQ10IUhtHxb1OpJNwEc/NaPLOUnGtTCC9lteGs3TiCVDTqjPdOlhgr934wzPX/4W1IycSqtUNzznkHHsmjRyb+jDnpdtFF6FZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b54f613b-692e-4eb7-52b2-08de9171f1cb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 11:12:51.0415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ik16nvR/hbv3toYBKLNQvI227CSAhrxHsO1XIbxnmawixkeosk4aFJDfOlbG5x0QPhrwTUaYYCNBuQWUP6cqOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7098
X-OriginatorOrg: intel.com

On Fri, Apr 03, 2026 at 07:46:21AM +0800, Edgecombe, Rick P wrote:
> On Wed, 2026-04-01 at 16:34 +0800, Yan Zhao wrote:
> > Thinking more about centralizing TDX hooks, could we be more aggressive? i.e.,
> > let TDX just have a single hook set_external_spte() for propagation of changes
> > from mirror page table to S-EPT?
> > (below change is on code base with TDX huge page support).
> 
> I was asking Yan internally why this works but Sean's earlier attempt failed.
> Yan, let's finish the discussion externally now that Sean is poking around.
Hmm, I guess why Sean provided op reclaim_external_spt() (now named
free_external_spt() in this series) is because the old_spte and new_spte
required by op set_external_spte() are not available in handle_removed_pt(), and
also because there's a "call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback)"
in handle_removed_pt().

So, if I'm not missing something, we may have 2 options for further unification:
1. pass in required old_parent_spte and new_parent_spte to handle_removed_pt(),
   and invoke op set_external_spte() (instead of reclaim_external_spt()) in
   handle_removed_pt().
2. as I proposed in this thread (see below key changes), assert that RCU read
   lock is always held during __handle_changed_spte() (which is a reasonable
   assumption in TDP MMU) and invoke op set_external_spte() for reclaiming
   external pt as well.
   
   Though invoking call_rcu() occurs before invoking op set_external_spte(),
   tdp_mmu_free_sp_rcu_callback() should only occur after invoking
   set_external_spte() due to __handle_changed_spte() holding RCU read lock.
   
   However, I agree it's odd to have call_rcu() invoked before reclaiming
   external pt :)

--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -461,9 +461,6 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 		handle_changed_spte(kvm, sp, gfn, old_spte, FROZEN_SPTE, level, shared);
 	}

-	if (is_mirror_sp(sp))
-		kvm_x86_call(reclaim_external_spt)(kvm, base_gfn, sp);
-
 	call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
 }

@@ -563,9 +560,17 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
 	 * changes to the external SPTE.
 	 */
 	if (was_present && !was_leaf &&
-	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
+	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
 		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
-	} else if (is_mirror_sp(sp)) {
+
+	if (is_mirror_sp(sp)) {
+		/*
+		 * Can also propagate changes to remove external pt. Since this
+		 * occurs after the call_rcu() in handle_removed_pt(), the RCU
+		 * read lock must be held.
+		 */
+		RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
+
 		r = kvm_x86_call(set_external_spte)(kvm, gfn, old_spte,
 						    new_spte, level);

   

> I'd be inclined to kind to call the cleanup a win and leave further unification
> for the future. At least not going turning over rocks.
I'm ok with leaving it to future refactoring.
