Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69822F5328;
	Tue, 19 May 2026 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173319; cv=fail; b=sAS0GFq8gdlhR/bOUqLZFkoj5sfpP48JdfML2MACOytNJjA/6h9v8ruzER867JnxPCWZXbYSd3xXb04f0tvOAWICF9A1ARG3mIJ7BPQtX1hk56s69JdxRZIfBKrJ6G5mahW0YgFqBDDyPnsa0GJEs/yfJ6ruOCEF2duqBMoqx/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173319; c=relaxed/simple;
	bh=aMTyEPRpfzGWBBwMSHSK8PUEMgOvcLd5B+A00LjUm98=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QfbwyDQWBVAVg+We3HwgMVYgxqQbi5LJYFS14fH9fGAmB+IF+sX7BV2ZyfBGcYFOYzhDR28eqTctKK9k1u8XrnFzrnnRDXf+na+pCFCF/5uYYDWW1FN1vQclf7dswM7O+Wvxl1oN/UzZoJQbOt5r234IKjGdWpEMNztQRhI2nGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X47qbqpa; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X47qbqpa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779173318; x=1810709318;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=aMTyEPRpfzGWBBwMSHSK8PUEMgOvcLd5B+A00LjUm98=;
  b=X47qbqpa7vo0JzmmiCKa86GUbz6NpUbrwOuS7nFtVc0Q8NUeOJmaMeYG
   CAP0ciobo8W7jZPeGEltdSqD9ZtGZp+mu98qk7ghB4JDyOtpPpgqnVema
   0rsUwX4+8BDuFVkAg5pahgD8M2gL4wBqhlwfy7oQLPDOxFaFkdeR1dCc8
   PD+aewe2wNhq4GPw+CRPsUgM2W6gkPEvIyCoktpjhQg+WBat4T1a0TuZI
   S7TVRW/gittNQuaEV6EhK9tcJyUaXUZr6Wgnyodq4WPSu8w12VkpeIeLM
   8lPk4FYN9geUzxydgmZMQVFISmWzgGu16QL8WoljmK0iXeIpQ634JsoNA
   w==;
X-CSE-ConnectionGUID: K9Hy6OhdSSyjtOG2i4nROg==
X-CSE-MsgGUID: uMxkFdw3Tt2M+q5bufj3Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79942022"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79942022"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:48:37 -0700
X-CSE-ConnectionGUID: nXZmu4dkSw+L6OBIHakH2A==
X-CSE-MsgGUID: 4E81lJ58Sca2Yz6eAW5ScA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233288594"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:48:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 23:48:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 23:48:36 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 23:48:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmdLuS3IaQe3NMCaODNz/+nsVVPwgBriPnNZhpYj1FLEfeXmbrRhY9RyQeU9s+cqzI6l9RQdw26Vg5gVkQ/2hfuMX6pUIJQtHxWlWbXmvfZZuUC82JGPRDEQf6uwxHYZ34ddY4Fn9GX9LiClwFGCnWaROU6uSuri8WcbY8/oRD8wvEFQi6Dadc9piG1pFlSHYVKq3IQ9pYqj2V4bTQs+VOIRZz9WJbYPAADs/1CEKIGuJ4KKn3B82RxBgWEdKfW7cFtGMNDOWai1G63RNKplhsdFnKWrifvDr3DIzg1LCDWwS04WYxFQaJvtoIJl4+idKsaesYVPhnuxidHZnyE5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwGokUtzRz4Dv2ZK5/mLjHvvUKZKeTFGO4g7rwpKDnM=;
 b=O5r1IlIObSYVsvzx23bchCQ1laTdspaHBVmEUZOOLShIQGDQyXffdsXA732jWt9pQ+NKjuC2o9D31TRjcQc8+oqxSVRukhgPNzdXd8o8BNCAhvKQI0Py32ggijNxbS80g/LxQF+X5k8VADNsxRSmW7CoCcZAT6VwqNaPeVaIm7/pWRPu0azCV9kJ0u4WPEW8xvnp2Cm2YBrEUYulwQSmjQWZAfA8TpRKtLq3ZCddiuQJzpoPH5VGwzHMinzmmZgvnG+hgfGW1a4MUXK3z6+T/bGZbCGdkOK3pSx+9GsYTePxcf1OzK10IERJBO3EOc+XMBtVPpr5mnO+Rwk72FBIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SAWPR11MB9757.namprd11.prod.outlook.com (2603:10b6:806:4cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 06:48:32 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 06:48:32 +0000
Date: Tue, 19 May 2026 14:08:26 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, <dave.hansen@intel.com>,
	<kai.huang@intel.com>, <binbin.wu@linux.intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [PATCH v2 09/15] KVM: x86/tdp_mmu: Centrally propagate
 to-present/atomic zap updates to external PTEs
Message-ID: <agv+WkQvZTRP+z+R@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260509075201.4077-1-yan.y.zhao@intel.com>
 <20260509075634.4274-1-yan.y.zhao@intel.com>
 <agu+UsizlbUYsjp6@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <agu+UsizlbUYsjp6@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SAWPR11MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: e084ed7f-eec7-4b49-5777-08deb572a48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|921020|56012099003|22082099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: jeX97kSedkGKa5uOopypLkk74sK10mBhBKdvDQvMFHWS2d+1O98sRdkgLP9Qme1NgaXYZo3d4EqKtlF+2On3CEj+jJgTXWm+EYmaiHXCuZezYeC0TPXKxCJYOVEd4Q5SSmzM1nP4SVXM6Cb5A4kVEAvSP+9K/GBPhycS5/qmk3CAGYa9evs3Wl04XeHhOGRTvSxLmE+Z63zMhhNe8QgfqM17nnrwyUuopFQ9KQvQBZDtO6uobAeZd2p+fROlXTrrqdW+EZ5pgCjMQwehJCA2Oq708vgL0jPDUx795JR/i5hcYFlCQy4h2BWK73I594eQ26E3yN0Hn5W4wwrM0fWqmxcBQK15zJCWtrWeD/cPt0BjPcJgmhKc+J5v6hUPrloQbgYXjdd01LncEoJKyi74PgI0afrM7+2EgAUU3HS4aSC7Flxu33xkcaw79vWCd1KCbHrnuugnBW5Wqy9/SQZhsP9rPqGRVSaFzk1c0irxnnzMtJvjofV5CCavJuhdA8mrZSk/mMPN6ZY1dGO9gpL4FzEGDu1kilrN3dyCTu33uuR7zHdyfW7MroBqhOix6ruAL6gz1Y0Nf/mO+xfAlT2i3HYyJ7RTAHZbQmJE4ZCjpcf98Qzt8U3QYKggsU4EtBNzhC6L/3k5I/3Cyytt+zaheduvMrt/cEXpFQE53F0VHeqrnfPGqKpKAr1I0pUHsqmzHOoLq2igrglVFTzQ7USkR1NUhaaU2URi1kqUpBFVyas=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(921020)(56012099003)(22082099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KLEmkYe5NSnzqOIpiy9EYdBgCouhM2VwVl5WxI3hxalnFvSAIMtq67JRQX+I?=
 =?us-ascii?Q?59/B4TMHlALH+jjyuVJ9ZFrDm7aFEbuQ4Hcdt4tkrt3+9kQ0Y/4yawMjevpj?=
 =?us-ascii?Q?QpTk1grp52LF/1nZR29vBHGB6/9RzV4MA8CUi1c16RcJEDigIOfhE2fRfT2N?=
 =?us-ascii?Q?w7vt4PYV4/KU63Ju2sceiq69oSAVihclTNN0h1zz0J2nNXfeTKfmHjyy9c2Q?=
 =?us-ascii?Q?nHqDYlJu7LMfL/nQmuiyv6D9GEfMnrD4F7yxImfaTUXqdZvnmQ5vGBHZn16P?=
 =?us-ascii?Q?Q13AOqC0cPfNXf0CgKpTh2Qn3WfwOAGP0JKOxNVJwk/cg503glMfR6l1a3TL?=
 =?us-ascii?Q?bxSP0bcVAUbE1rio9/hOSojo2zqpn3b8e56d5BCUnns8lyixIEO9v60f5ULY?=
 =?us-ascii?Q?YdgzNTTLWhN6AbX4GYt7QxV+mc0eO1n6SSZoWVRWOYNsnwzzWOAHSo+mvLJi?=
 =?us-ascii?Q?5LmbiKrwoV3iV81BzwFAZT7WL5TipHpX5RCjtVmZDG95iioLjgrJCjiMlVzR?=
 =?us-ascii?Q?cdFKSSc14LfhuakFQxz24EZE0zX9dTZanoZQQbgJ5mhllj17dlV6If1W3M8R?=
 =?us-ascii?Q?OdSfI26F2YwtmJvpQPLfrls4eqyR6EUYSx0RefvRaBU0DxbYcz5i8yFgToj/?=
 =?us-ascii?Q?K6mTjE+HShiGAW0bxEV73sj1gjGBJU+GfBFivgNtNlFrAmCL5ozip6B4rHtx?=
 =?us-ascii?Q?XQmx+mqEThQV9cvnrftHRxCyBv2R8PbP2FiOBVIzuCn9UnespuhGfyzBTVcr?=
 =?us-ascii?Q?XAa8RI7eMk7l+U531dDz2ZaaI8+rye1OXWyAABeb+rcg6hzsrujzz1FABwwe?=
 =?us-ascii?Q?NhhY6f3c6g8yeummFIlajOOysOUA3V0Y6wt4p2Fc/hqWlxENzGJEW8hoTBoZ?=
 =?us-ascii?Q?qwmevJ5QOlwJofGfx0gDQwh7ySeQoKSa/68vycx0CU0lEN9WlCYMG82nc+T+?=
 =?us-ascii?Q?4RtYzLU7ZS6I6YDVLShyFEbLrAPXA8o/r/xUZWbVtfkvpB3h1ltp3RKlntkt?=
 =?us-ascii?Q?r2fB368UgIVYYYN7zpnXEI8h+IDKbNl464g7Tv9IHavJN5Fnvi87Z1gchhNs?=
 =?us-ascii?Q?aqJlw8oZD5hT6sSacr6GNkCLOGYp8WEVIKDVq+xuWbUT87/w/tGo04EHKpk6?=
 =?us-ascii?Q?t8HrOk8Te0QCPWWfXncIjxKUJP1BxYxmuaHlz8bFZzg8olST7aRGFgSHlCRh?=
 =?us-ascii?Q?Zn91jD60kKrl0u0orjIjXauXgZh5lRIMauT7FdD7aOCLNGm4GDRPth7Gu0XA?=
 =?us-ascii?Q?mRzzgT/Xws2I82Wd0uY7RA1ewMF+WVcs7JGULssAQCqKE6c19stR2Wr92EVT?=
 =?us-ascii?Q?ANAklKk9HnOWgXwbYjeOMcfue7oerRpfdfARxJq49s4itmUBecmfTcucAx0H?=
 =?us-ascii?Q?1//Uwb7eWm6RtQBWF5bQudVNAB+8OFuoNsvyzAX29E4nibOtgf6wq5iZ+E2Y?=
 =?us-ascii?Q?szZlxX7r6xwDdkqOp58dryNlq1RHEKmaYkWqcmwT1mFymyAcGAFFsLMJafvP?=
 =?us-ascii?Q?sNNdgQmVWrXH7/GNAPrAgG5kOImywr6Li7WIyleIqySbaiIyBrbhLveTeHWZ?=
 =?us-ascii?Q?rZxc5dK51sDuO8NZIvN3xQkuPZdTHYCAxp0DhIvGiWfinbiATjyb17mNpYVx?=
 =?us-ascii?Q?+EkyLdmFIRc4kj4hvgIJaZDUlUhIpfGTY1KynHwt4GNS0S8vmQoO9T1J9fiu?=
 =?us-ascii?Q?X7ze3PnJFq7q0sKisfe1qiRmPdTRoOb7v5t1quayUpLt5B+NeWOXkrmnTr6o?=
 =?us-ascii?Q?50FHZE0/hw=3D=3D?=
X-Exchange-RoutingPolicyChecked: kjA5E1ZzpFHVdTkereV2JK1QJi0tcpZMYtqv9qscKuT0VjLgUuYU9AlkQVhBKgjR5RS7BMUoqh6qFKLXzSGBUX8a7RdE8hAytg8FlQzf3nfzTcHI4bNCf7Tp2iXPLR1SlSPSJ/myEf+IikUBJn2bsd8aJbjjD7Ra5hzifR4GlEWaFHciO+yNxjfxqy9Q2NXbVhvG+BOzk5r21isBij5UrFgYCcpkxNSsSE8eR3+oPBhikurBIlgs6/kFOWa1b/fkX5dXzFtZAvwseiuhv2wsN/yO92iPDy7Md4lQc2W/lgojTbDYEasPR49iUYYQQu5ysBzHMjQAwY/yN3tw43C4pQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e084ed7f-eec7-4b49-5777-08deb572a48e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:48:32.6768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcV6Pbs7lbyxRNmxzhY8SBSW4hUXfuzwThboDOmS4ADc8Vl3ieZeHNzJETf9xSsTuI8SzQUN8xoLy3dSqw4D2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9757
X-OriginatorOrg: intel.com

On Tue, May 19, 2026 at 09:35:14AM +0800, Yan Zhao wrote:
> On Sat, May 09, 2026 at 03:56:34PM +0800, Yan Zhao wrote:
> Oops, this patch needs a small fixup (the internal sashiko found this issue):
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index bb18e9e61542..e783886296c1 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -535,34 +535,36 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
>         if (!was_present && !is_present) {
>                 /*
>                  * If this change does not involve a MMIO SPTE or frozen SPTE,
>                  * it is unexpected. Log the change, though it should not
>                  * impact the guest since both the former and current SPTEs
>                  * are nonpresent.
>                  */
>                 if (WARN_ON_ONCE(!is_mmio_spte(kvm, old_spte) &&
>                                  !is_mmio_spte(kvm, new_spte) &&
>                                  !is_frozen_spte(new_spte)))
>                         pr_err("Unexpected SPTE change! Nonpresent SPTEs\n"
>                                "should not be replaced with another,\n"
>                                "different nonpresent SPTE, unless one or both\n"
>                                "are MMIO SPTEs, or the new SPTE is\n"
>                                "a temporary frozen SPTE.\n"
>                                "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
>                                as_id, gfn, old_spte, new_spte, level);
> +
> +               trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
>                 return 0;
>         }
An alternative fix:

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index bb18e9e61542..5d7c83d74ade 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -572,7 +572,6 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
                if (r)
                        return r;
        }
-       trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);

        if (is_leaf != was_leaf)
                kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
@@ -586,6 +585,9 @@ static void handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
 {
        KVM_BUG_ON(__handle_changed_spte(kvm, sp, gfn, old_spte, new_spte,
                                         level, shared), kvm);
+       if (old_spte != new_spte)
+               trace_kvm_tdp_mmu_spte_changed(kvm_mmu_page_as_id(sp), gfn, level,
+                                              old_spte, new_spte);
 }

 static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
@@ -683,6 +685,10 @@ static inline int __must_check tdp_mmu_set_spte_atomic(struct kvm *kvm,
                 */
                KVM_BUG_ON(ret, kvm);
        }
+
+       if (!ret && iter->old_spte != new_spte)
+               trace_kvm_tdp_mmu_spte_changed(kvm_mmu_page_as_id(sp), iter->gfn,
+                                              iter->level, iter->old_spte, new_spte);
        return ret;
 }

