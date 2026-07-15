Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C73C584B;
	Wed, 15 Jul 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102000; cv=fail; b=UxshSviOMbLOQDRcIfinkwoBDrNU++ShrDrpT+Mx9e51f9BvOXsPwD5R/1XqcTeivkZD+EiurqxDeezdzolWc7xdVkKYM9jxWZHZHAMkNudlOnzL5Pp97+Fo6gudc4qf8ETHtLejQD3Ck90718U0Wrulx9IocKwVAESNXUfGEXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102000; c=relaxed/simple;
	bh=MWlBLE8oHGT0leZUSwTvYl861sXQBScASi7cwGCDp5U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GlI2hCqN8yZvlxkH2P2iFXeWU6mOzY+50q9Veuj03yEs2vdm8SXbdBwUBOzik0/7GE/nGx+vzisA+OY0lJ9piGJSkRAto5+DyHWViHkAyFYgKe8RJyOTcx/S4HS65WpDCt2wxUygyXjV+wWgu/4E4h2dKJKexbhYOlb8gBHF680=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjnKpCL9; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjnKpCL9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784101996; x=1815637996;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=MWlBLE8oHGT0leZUSwTvYl861sXQBScASi7cwGCDp5U=;
  b=UjnKpCL9TjiIf5mH6lCZpW83kS7IClD9/9u5Gu4MfPH4Vsjo2bvkibl3
   Nn49jD7ThYSd3blTQkqEL32sXqiJnaQViaW5JTK7ysKd8vyAI383ZsHXN
   IdfXwIKISHQ9z4e/fpY4bl4QXT/o3lVY1hcOtc/7UnCCv9MSWSS8f/Lej
   Ztip3EDLoIPfDGENqwp6C+MyaVxvUDvTXiFGFdldC1m0dhERzrwRX/ub/
   VvIwESYPwkPeD+JXK4w2bI5DSNMBY5tEdWWdmolHukpdLAqc5Eoa84amN
   EDSTR0B6vxJj8OK819rApprTkgalMrOk5igE2shV4Dyxx/b5USb+Hu7IC
   w==;
X-CSE-ConnectionGUID: asYXBwNGTJG2oKKsioC+lg==
X-CSE-MsgGUID: eXBSIjBpRheeqMLJPHIwIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="83853434"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="83853434"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 00:53:14 -0700
X-CSE-ConnectionGUID: A4/NSM92R5CI9QAYjI7h8Q==
X-CSE-MsgGUID: tg0hxuGaRk+8nFUpdOooFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="280535012"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 00:53:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 00:53:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 00:53:12 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 00:53:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VR2Rnas0JdhRtl0hiOYVUiLUdEbNATLDX5BTUGxAhi8TTc+QK6XdcDygKKAQ2AL7DyE8fxPlXX7PXT10GjOmuD+gtF5Jh06+6bpi5mKZ/LA7GyJhPmQAfdQwSkYiAHAWHUmA/i2CUwadOxzTyTy0Uib83C6oNFw0S44EJfMpZm4/SbdZe/pvh+UWDUreO+T2yX+O8ryClE+NlNvji/qn/0QxDtMfp0q2VSvJXcitE36Jz6ZRjH03L1YQzFCGpAjZu4eIhKBnAXaXT25FT3G1u+vLZMHSENIMt80nS91GseYAk0quBwZXu3UurfpRCNH07r4e+0EqxIhs9U+R3L5Szw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riDytRGkECD++EgvqewHL7Re/Uh28y9S+qZdq5Ju7tA=;
 b=VNV8TzZ+v8MRGqadBsSQb6xkU8SduLfEgjrSsJHjwryhpxLu0o683KJB5Odm1Wyn35dGsXTj6CDqhip2K2A3sUuPnGYeFbqEXQvWT7p4O9ybXKER33ZeRPjULrcFsNl7VYx7FIQmh2AfFwM/gbLIolgmFD69wMGMc/FNPCJOkxWhzHoUA9UGvusGlvgvIkKKhw3Yi60QCIIzDzf2EPNhV2l6UHpZ5JF8WXeUxirK2p99KtYIyYZGlACVRX4dH8F22k2DyBdgLZ2srd1YXrCUAI9nbz4bvy4ZXDIvFj7ywsMevAiY3IIJG8C036Qp49XlCyDXlV6XNDtDs9mZO7O8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by IA1PR11MB7892.namprd11.prod.outlook.com (2603:10b6:208:3fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 07:53:03 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 07:53:03 +0000
Date: Wed, 15 Jul 2026 15:52:54 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Michael Roth <michael.roth@amd.com>, "Hyunwoo
 Kim" <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>, Fuad Tabba
	<tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH v4 18/18] KVM: guest_memfd: Combine
 .gmem_prepare()+.gmem_invalidate() into .gmem_convert()
Message-ID: <alc8Vi9yNIFR/yGE@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260709204948.1988414-1-seanjc@google.com>
 <20260709204948.1988414-19-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260709204948.1988414-19-seanjc@google.com>
X-ClientProxiedBy: SI3PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::10) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|IA1PR11MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d46ab3-33f2-4ec5-6e01-08dee246193f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|56012099006|18002099003|22082099003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: L++5/S510k2YVzZBepAzpslWmpbcodphYZRPeglRKag8A04I50gFIANjvuNJCP4FqSQDIo0MnnaOiSoQF8dtdUS9iDtPbwMVUgROLDoAMKuPwtV5Byv68jdNFXLQEmBS/ZacnfYCRMw31j4eBag7NltG9F3oLE56baa+258SeQAGCL7uoFA1z0bQM+cWWyy4h1nV5NiJHuNkrny8PWqHR1JKCNht5kKD2kJcOCWv14fEOb9CPx+U+9dKTIVTDGPzBCVACLQ9oD2jL4yqcBo1VwBUUVIn7vyidpcTivrjQBC+c6r+sCEseMDEKE3etVv9cn7UQkKTwDKhsiXl2fsd3kksYbz8lFcQKPRTDrT1BgKrgZrPlDGQqkv+7DpYPOHQ7ewsp3gi4OT7wA0a+JyBng/BijhvQzlSBqRKLPSag0UZ2GOfgOOIGTeW7x1CGfyAPTTtUIeR647xT2rjL3DsrPs0H1VektW2ZVXQZFGaTvu7K9/NTfBpJzfvyFpWCYEA+6gyF0neAsKEIiGAj1TY85SLfjKtL43tzP6w0YFSUCiSUCrerl3DRNgiodqvsd64MI6hcoc+Z93D5JBgWEULaNviVtcbNWfqW0RLd91Cwz5bvTZIX9KcWLCN96iwJkqvcGHzBCEz4Bm1BsxGelvk36x2tiDrPg6aG/jPeHtntcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(56012099006)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DOrwq1XeTFs6vb8HOp/NblNhw6c4g0qLthWgn4vrBC236JhZ510BNHnNI2yZ?=
 =?us-ascii?Q?ZopIFjOlsjlDkcJ2G1jt1FqKXAKRwQ3a306U9XoTMHj4gIhUhwrw0O2lbzUP?=
 =?us-ascii?Q?rVN8vhp22uCyo5nk0pmmehy45NNN5Nf+NVFY0BM8N/xi+qrk7q9qKTbIJeNc?=
 =?us-ascii?Q?3llaMi4II62F1ioG54Esd8PqHqNHZ67pEQIu0aAlg78mPdxRRz8JafiwbK2p?=
 =?us-ascii?Q?MCK/NZOIRO+qa1kQ8ppPQrNOFxNWdREdn6q/6Et4atU5Wowzjo4CYztkQkRw?=
 =?us-ascii?Q?1muS7g7V+2c5FHUaSlBnjRL9mfxYLyRErpbhcJOZEz+ovFyvJ/0FH8zflemR?=
 =?us-ascii?Q?SaYQVr7gr8BOz3uvJR1+1c9ej5gROgYD4R4Z5i0m9zSW+1ojdMFgOf6fAljl?=
 =?us-ascii?Q?iO724RR0JKeBmnGGDXlZE4VzxLI4jXxACDKMkLIHUBvjI7hO3oeCqpxrqb/g?=
 =?us-ascii?Q?9yYR3oR3O0lI5bf2ERn4LlWgawtfZLQ3h08WtMuJnlm4PPtYi2EqWYP9DhaD?=
 =?us-ascii?Q?IvsKH4wSh2zMtKnQIFeBTcF94OQSOlpd8UZOX1s4en1a6+IoJ9jkms5T+57G?=
 =?us-ascii?Q?e9ue9OnY1Ot8y64lajzhF+ifdrdE0rKXj+g7+MkE5Hn15tBqbWAUe4vkYjlO?=
 =?us-ascii?Q?fKWR54Ou/eNu1whU3clDPB4VQdogojfEXGtTDp9wAZXU2ksFiYJ74pnUwttK?=
 =?us-ascii?Q?TpDj/KYSUZOGynls8XxrcbBOD0UimySU+mrNFYYFjU2JxzwfYNeWtMGhDJyh?=
 =?us-ascii?Q?+BAkQQUaXaoJIqP6W6eNIyfJlnzEC4xCVhLJI9ESqUAd8G3QzJXzwDMIxllH?=
 =?us-ascii?Q?2Yg+JkEuEWCd3kUQOC1eRNOR4wpQE2ShhVxX+zlXbj5Uc6GK4NxIdgQIB/SU?=
 =?us-ascii?Q?Ht67vF/STX5PZJBczqdpkt4zQ0TG/G6y1Eiy77pp5V//HSxuwqxq8vyKo+XH?=
 =?us-ascii?Q?UUcUf/tG2gyfMZocCxtCKdkL/iqu0Cjk+nNwk1Ye6TbwLs9ZCSlOSSarx/9j?=
 =?us-ascii?Q?PgzUnl/TBbkgOhZWhLVgNXApWQphxtzArIzHQceZBcMSasJtt8m+YC/rGaY8?=
 =?us-ascii?Q?hqIO7KQwYIEFUS/MjZ1/6XbYzKyfdg1AGkx3bEMUf2yFkYPgV3KIGoDw+5fx?=
 =?us-ascii?Q?Le+5A8Bpvs5qxzgpawt71c9LYAFlUnMTLPD4O1cvba0zDSpiE5OEARDd13ka?=
 =?us-ascii?Q?SB7NZk/AfVRPXwMYoJZRQlBPxFec8KbxOZC30gVvkl4ntQilbiW4Bm8Akwwa?=
 =?us-ascii?Q?ueG14Uk0YCw85E2/lTfME9XiXnyBc1FjOG7BIJhisCGVgNLD3Nv7tlsF235u?=
 =?us-ascii?Q?pGcyiCOfBMelHrfKG0CCF5bemY3aPt18pAW3kGAmCMuv6utSV85FyR5CtGGb?=
 =?us-ascii?Q?L3/2NKRw6f+flUrDlhTOPf2N7ZQi9RzW436I139D/FzCtUjth3vOLzX4+oOm?=
 =?us-ascii?Q?puzA/rFBURDwXzrMOPXK4TWTHTXrPQ2DK/ebeHhdMnuYtbPoyssYysBjcYzS?=
 =?us-ascii?Q?OIlS37tZS+Atc97JjiNsPE2sTV5GQybx9iEZ2XcXdjKxrz+q+LX5mMMJo/y6?=
 =?us-ascii?Q?5MY3YrpKwJFL5ZeFr/ilH/Jzq4T7jjI1Zo6M20S7vPkmMRvmr9/WYVEZUetD?=
 =?us-ascii?Q?fY1ajfkWtFzsk7ODUvArHo/Oa0LBtaVbDJQHjVNv6HADgJIttZHNhKUrpyvu?=
 =?us-ascii?Q?02k8U4NV/q5vQGjLBxK2sR9JWmFc/5tHIGbdM4Mi8r9dD5wkICTWS6c33QyI?=
 =?us-ascii?Q?zuO6sq/xnA=3D=3D?=
X-Exchange-RoutingPolicyChecked: SAlx8AfRPw7MzvR2lDlAfrfdHE2+l2tS/FVd/m45L946GTRtNDUMQ9PsvTWCwfs8LeLRAYvCFz7LiNLcass4+TIUG7rI0iZMxMMrJmurCAlEsisnzrIJb01Nn+SxS7MFtUBmyUuZn0TuQ22YtWUwnPzNAOZ9zDlhaIo9N/nldHA78HFEHwcDjP32fa/8UiprdBfcA7r5E9SfwOusEOFfRsCvRqRja7o9twmlf38PpPXmyiNNBRNEMdxEvYM+MPuEh1PqC+P88iYBj6+K8By+zVvayiJadeIEPvHr/TZXAXd2FXGTDeo3Ib7MV7CO5bAWaffTMjXxAAlK0I6FxL5dFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d46ab3-33f2-4ec5-6e01-08dee246193f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:53:03.3890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHWudGeW1XG+hJ8xtMKWMRxxznaN0cOoHknr+jEECzoYBXeN86mYQjfyQzGN7NAuEWbjYDQH0KuBW2Uuxs21+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7892
X-OriginatorOrg: intel.com

Sorry, I just noticed this patch.
Though it may be too late, I have some questions that have been puzzling me for
a while :)

On Thu, Jul 09, 2026 at 01:49:48PM -0700, Sean Christopherson wrote:
> Smush guest_memfd's prepare() and invalidate() hooks into a common
> convert() flow, as they are effectively two sides of the same coin: they're
> invoked when private/shared memory is about to made accessible visible to
> the guest/host.  I.e. prepare() is really "make private", and invalidate()
> is really "make shared".
> 
> Using a single API fixes the wart where invalidate() isn't actually doing
> invalidation, avoids adding yet another gmem Kconfig, avoids having to come
> up with a name to describe the "make shared" behavior, and will yield more
> intuitive code when in-place conversion comes along.
This is reasonable for SEV-SNP, and there is no functional change.

> @@ -802,7 +801,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		folio_mark_uptodate(folio);
>  	}
>  
> -	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +	r = kvm_gmem_make_private(kvm, slot, gfn, folio);
What puzzles me is that kvm_gmem_get_pfn() can be invoked to fault in pages for
gmem-only slots in normal VMs, where kvm_arch_has_private_mem() == false.

Would it be odd to invoke .gmem_convert() with to_private being true in such
VMs? Or do you plan to add something similar to the following in the future?
        if (kvm_gmem_is_private_mem(inode, index))
	     r = kvm_gmem_make_private(kvm, slot, gfn, folio);
	else
	     r = kvm_gmem_make_shared(kvm, slot, gfn, folio);

Otherwise, would it look asymmetric with just:
        if (kvm_gmem_is_private_mem(inode, index))
	     r = kvm_gmem_make_private(kvm, slot, gfn, folio);
in kvm_gmem_get_pfn()?

Asking this also because there is a .gmem_convert() for TDX huge pages [1].
In [1], .gmem_convert() is invoked to emulate a to-shared conversion in
kvm_gmem_punch_hole(). However, the per-gmem memory attribute for the range to
convert may not be shared after the punch hole. Is it acceptable?
(To me, the .gmem_convert() in [1] behaves more like .gmem_prezap()).

Additionally, would the .gmem_convert() to shared in punch hole be duplicated
with the one in kvm_gmem_free_folio() when CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM is
true?

So, I'm writing to understand your considerations behind this for our future
direction.

[1] https://lore.kernel.org/all/20260129011517.3545883-44-seanjc@google.com

>  	folio_unlock(folio);
>  
> -- 
> 2.55.0.795.g602f6c329a-goog
> 
> 
