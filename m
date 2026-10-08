Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E039E16B;
	Thu,  8 Oct 2026 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791428989; cv=fail; b=ci1TrBYSOq6O1FPCHCSk/JFs5FBxTLlKxofKbBk5EvZEQxXdtYVBMAg0SC8GMFwybqdST/rsebwbjAOCd7D/mtVfvrqMeff6zrKok+TUxwg0x2aQbSzYDnqAmtVO4Nj/A2eeGZ5wFcvR6bg4HjVMT0QMHMrFEeP5ljHei5vltjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791428989; c=relaxed/simple;
	bh=XdwGcb4TiENcL/myr0ju0BtzaOx3lQPmqcZe8cN94QE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KO8BwhPhOkegQMU2YrBJx+08ZKgi66NGqeeFFCqp8IHnXhGpAcBykZULhHY3Tn0YSK3/f0SwPcOg13HrR39DqeUSrHbxC/v77NCdKC2zkkrX6AJ0TS6x+r1eW+mHnEGN47et4T8cIfK0PFODYnDZko+5e8DywQMdSGi2VQ1mkyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSznXSpF; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSznXSpF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791428987; x=1822964987;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=XdwGcb4TiENcL/myr0ju0BtzaOx3lQPmqcZe8cN94QE=;
  b=dSznXSpFAN/q6sO4BSJ2j3owQ4Ic6kZpmy3p1o7EBdBR0fRvyVm+BPP+
   bgWpczVrwRUpy/gVgX0OTOrybYpBO30KAdqEBtcOPlrSACUmyyupJV48D
   3ulJJKuEgjFUpp/BHmtWC2LT3NqQ1HZOJkisaAQdARTvYdnL+bfrk7vjx
   w+B73Pp3l/O4ckX8OiH6RuvU/Bjv94UmRi73eYf3nfW2VDTolCg/8xB9Q
   PrFQY8hZ8zdxlqDbuzRSAqiz7hZVfaQ6qKE92LJBeWZRyi+mwSjsYg57e
   yBPdwmfO+ftm+t5otRo8jjJ1LSn+4Mz8fuG1A4P/lqBhDZjk/Xt+qzx8m
   A==;
X-CSE-ConnectionGUID: DD3SEnFETSqLk71GtV7U5A==
X-CSE-MsgGUID: SHWUL19rQzepD2LBe2R8Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="85696"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="85696"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 20:09:46 -0700
X-CSE-ConnectionGUID: krQcmdEfSe6risDzwqKoYw==
X-CSE-MsgGUID: OxD/BFTZTQyu8in4vPsDfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="218942"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 20:09:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 20:09:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 20:09:46 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.35) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 20:09:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2mnNA3IuBDIxB3MET24lS4HeenJl6zxPe/gfIvVix7raHV63th2xFH802ByAAiSL1lc256K/gMujfgQ2Kno/4/6bsRN7u3vgfD4rnZnQrDajUn/kqv01U/ILgcq82No0PkqPQ6rEiPVxZ71X4edPGAh0pm5om3IG9iK5oHFzMKylKN7in/ItJvVEoiUXfv0JDTSGl3s6xV4Wq2kFxak8F4mwAc2epCKTfCa6WT6sLUD9mBCJu/BQO0YyJf1/XKdUJMI/cV05oXpfgXGvgjRhCGmjx/kidRCE0pxXvhYk0IU0f+/qNp5SSxJK5gFhVMYiuSDsQgdGu8TFK2RqjJh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j8az3qc9/t7cUwaSSJG8KZIMV3y7Ju99jEVq+wnmj0=;
 b=Fax//Zy/43gAbwjAifaqBrmB0y/CnucMAFOq7PjzvcCEvq84HMg+YUWVaPKQrdxK0fdakx9dtRejzlnPCjWcZO+hMW3SAhcRSaq+yPlp3O9JVqJPUDURiLnbsDMFpQf7TtIeJ9ID9lYvriZecack/Qrh+Y8Wx4m5Nbcaq2UU5rpX9w4p7SolrLeejRFz5tYs0ixCEbsT6a1L03O4J5O8SUGC6Qkb1isu+HTIkYzTZ/Ds1cES2cZh6vA7TwAtKqcnKIiqL3FOLdJdeTgxlnH7enUm+tT5kp/ia6oLoSy6ftEoTPYC1QtH6u3i6Y3Ah8QthTO1nyWSWXXZquWP8sb+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by IA1PR11MB7810.namprd11.prod.outlook.com (2603:10b6:208:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 03:09:42 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 03:09:42 +0000
Date: Thu, 8 Oct 2026 11:08:53 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>, James Houghton
	<jthoughton@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Ackerley Tng <ackerleytng@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, Sashiko Bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 3/3] KVM: TDX: Ratelimit the "EPT Violation on pending
 acceptance page" warning
Message-ID: <ascJReVNL2N4lJau@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260930001127.3170009-1-seanjc@google.com>
 <20260930001127.3170009-4-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930001127.3170009-4-seanjc@google.com>
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|IA1PR11MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e3b119-dddf-4622-7d95-08df24e99907
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 0LGIUwlQ8Rex0NMG7gTfs2sne6DSik6uLoEj7M4l/R96yDGfM0l81x2px385Fu1KYqbBsNE//zkOn5rgCCpc013S7A1nVaiclJo5kE6o0vuajXx5bqVHOwiK9SsnspmeWUO8aj3y8UGO/BgNfruTvlFGMV7ih0+jaJP83g0/iRxDjYJPae0mXfb9sXuNWgUvxMNDf+8r/Z5wjjUnhi0M+ZdAPBLUBX6ld0d3Q1znJW/eawEO9zK8SZ1a/LHu7GAKrN3J+QmgXs8swTon94hxWvEVxXAqU0o/TeBHijhChOVaTB/zxblcRqq8lX6cjILz9Hq78nnBMFpARa0ovw5GkNXmg7RQp/uTU17z8DroJRq/gsl6wnVZ+bp9LFpMYgMA15rSmAWGDsQG3pDnP9pCm5bMri9sSgiQgme/31NlP6FQijv7gBYSgLqbApXGE70rJQsSzTaMrjrf7ZX4G1dokYulN46ElyIkKkEK7DgrqHF4k0b4Y2hXK971wDLAqAGctJ93gf7IHmk9XI+5U1cBFarY8JtCypee+JwP8xQi1CJunWEM3SX6KfihbBplgFTX6gL4jYhyEQtz7TuGaETnPY5VMfh5BRbbZP4bk8oDq25P/mKFlDHqIpv+05paWQEz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yelXEUb336AI564sNb4QSQo9X1szOOOazEvJo1iNmqIZigcPie9fabnrgKVN?=
 =?us-ascii?Q?xOVJBCYJcrX5/8EiqMJxQLSWC0rlI8LErCasxkm8u40QP7ssiXXg4MX+Nrvr?=
 =?us-ascii?Q?mN/V27426Gdc3najM3PcRjzwahnGR/x4mhmiS0jNUS+h52tQim2q5mpVG2RX?=
 =?us-ascii?Q?fvKcR47FBCqf9xuq1SO1uDTWRKJzvrmdxfaRHq8xY5JntZR0YBMVGrfPDcpF?=
 =?us-ascii?Q?XgLvyU7thGhLQEOca5j2xxdVHlIQnpBRqlIk7WH55oT05AHIhp6PqvXMbYrf?=
 =?us-ascii?Q?nL1pevZuWBViAsCqmlgrs2U4+crgwc6bYyWw2bGHRcYZjwvtiRdbH3ZMG3Py?=
 =?us-ascii?Q?e8ZmbLo0Nvg9BRoRZxpJZ6FHHv2pB5Ox1l4ebtTU/dQbth6kufdW1j10Kphk?=
 =?us-ascii?Q?4Y7srSa/8cFLNS82vx8JU8zV+ozxWH/wmG9zIvktT3vCPAkxhSvUOChXctml?=
 =?us-ascii?Q?5S5djfv2f9tnh0V+6TC0YLzylZtQ08L/fua3Y+Yh7uPlcSm00vEV8U0a3dR4?=
 =?us-ascii?Q?jaSuAo/c0ybDkIVuwHPB3xIZyw1Vq+7lQcNihl6q9AOkfyhuCzdOv6+dUSzw?=
 =?us-ascii?Q?xV/PyMMLFl+NR43VhAnf1h1zoHTC/YYHZNjQS12XwwfFJaxc6K+dyNKsdkVE?=
 =?us-ascii?Q?lmU3xBGDHsv/qSvHmFJmPj7JKsO1rJ1xehfmtZmdoWPkOXVqhd7ZIwnYX8zw?=
 =?us-ascii?Q?UrXJT0pQK0kWGDFSfLKyRRfhOcRb9XU2VmovX+FNfvKYIDkD6x1J/ehnrym1?=
 =?us-ascii?Q?E/wrpfcK82rnsbjgBdDjqipBn6tzG5TZ5BS69XMiwd6VM+LxxMc0wAtiYSAd?=
 =?us-ascii?Q?Qbsg2GrCha2RoNLifAciGzl/EM1w43vaMspR/2/CdopP2u4a/Buk5jKkfIiY?=
 =?us-ascii?Q?unhKMdNJHyBm1Yam+qcZTiCwQcghpUPotwdurlIM0aXPEH2SUyU8rNQN1nLI?=
 =?us-ascii?Q?VdJDsQgYZzB3rzKMfl/eBAzeRGxK3OamaI4PyhFdILB79Rq8pN8ZzJDZms0m?=
 =?us-ascii?Q?xCzQHZ6s2mHjox0ZckL+eMjxBc5iuX2/OwFhcRkb0NiBeO0l4eSPUh/KUGNX?=
 =?us-ascii?Q?RcgkzlCG+T0LEeU0NT/kEya1B1eJkKcb9gfv/QujzZOmIM7xvW1HEBpA3HaQ?=
 =?us-ascii?Q?MEe0nbXdgdyzceZdNmlfGoJo26LgXUacYboCP9XsGICi5BP1dc1LeOnUyfIE?=
 =?us-ascii?Q?I0sJOg43aZFpZRsIepQJmKp3o3clbIJxXUcFjM0yqqdqFxEmEfz7QAfChzj+?=
 =?us-ascii?Q?n+nq8NB1gcYnL/KTx6blUNPBrLMfKrU4ILNHkcB59ubMqKMwdA7aEyN0hjKt?=
 =?us-ascii?Q?2FkMUtpcPPXe2yWTuSRm+3ILEkqXLIbu8p2UmsruW+LV6th8IIrIZV+80rH7?=
 =?us-ascii?Q?VsllrGvJLvXht5R69Qruz/UtkwOeqCupEDbzhbMoidNg3DfoTTl+yg+JEf7n?=
 =?us-ascii?Q?MOYyebpKlEiBuL7rgwr1gG+XHSV708IZBOQEi1Hg979j+G5cknREHeHOFbrq?=
 =?us-ascii?Q?/sDvSXbRS06TVlEtXBJkk+djE2iykiIsioLAA2Q78fLzRnWpSEGwM0v/xWO2?=
 =?us-ascii?Q?iR6Vrw3CrDmCwHyGee7j+NPtZk8r9/Dth4ey+PDtdNgmWg73ArnR1Z/5OTvK?=
 =?us-ascii?Q?ViQuk4ek7f1BMpPuE69dl/8JExZmZjDkrGqcgt0QTeKzKTVMWASScznqWEkm?=
 =?us-ascii?Q?kPslgRij+Bq8UPC7GJ4tT7qvNoVnr7U0Rl2XmB5MCkz4e1FfnfPBZFQG+qJQ?=
 =?us-ascii?Q?YymoVwanYQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: Sve9UkHgEBUxDYZHyD0c5Dhi7NqMwXbKqa8rkJXBlRqjW+9/QTsVhlr+hGt+u59TsF2kFyy4GBS9l/R061+tYXmenmI93D//GJoq3vzTcFHlO+/Qs2RlyFZAkaRtCH6z7qsCfW9uwJoUAFTWr7mG+L5i10334DRzW1040AM4GmUCTc9wjnS2RdaZGk4l08gvd3PapTyIXCbtC9NUbuqy4PFjgQOoK2J0Na+hV2tO4tvQhbCA5Z/U8dPSpkRIerbKRh0Y8g6U7kX61ngBB9J9BAui3mt4PLWC4M2FiW2HZoDk1O47kkPhF93whI84qEbvTYseRFRQntupRoF56SUtbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e3b119-dddf-4622-7d95-08df24e99907
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 03:09:42.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 834d9OnyNa5uwWpGURiD0CUWSnv2GZ/eis7yoQ828H6zEw8v6JXS2TEJ/vglu/1+6KkHgAYHewCR7D/h5oPSng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7810
X-OriginatorOrg: intel.com

On Tue, Sep 29, 2026 at 05:11:27PM -0700, Sean Christopherson wrote:
> Ratelimit TDX's kernel logging when a guest accesses an unaccepted page and
> has opted to disable EPT Violation #VEs for unaccepted accesses, as the
> pr_warn() is trivial for a misbehaving userspace to trigger.
Since the pr_warn() is previously accompanied by a kvm_vm_dead(), which kicks
off all vCPUs and disallows re-entry, a misbehaving guest should not be able to
trigger pr_warn() more than once.
Or are you concerned about the pr_warn() being triggered by multiple misbehaving
guests? But would it be better to print for each guest?

> Fixes: e6a85781f783 ("KVM: TDX: Detect unexpected SEPT violations due to pending SPTEs")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260923164348.2DB2D1F000FF@smtp.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/tdx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index e3723f1222fc..4cac43299851 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1937,8 +1937,8 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
>  
>  	if (vt_is_tdx_private_gpa(vcpu->kvm, gpa)) {
>  		if (tdx_is_sept_violation_unexpected_pending(vcpu)) {
> -			pr_warn("Guest access before accepting 0x%llx on vCPU %d\n",
> -				gpa, vcpu->vcpu_id);
> +			pr_warn_ratelimited("Guest access before accepting 0x%llx on vCPU %d\n",
> +					    gpa, vcpu->vcpu_id);
>  			kvm_prepare_shutdown_exit(vcpu);
>  			return 0;
>  		}
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
