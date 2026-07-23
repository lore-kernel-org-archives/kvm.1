Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1539B3A5434;
	Thu, 23 Jul 2026 05:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785192; cv=fail; b=GRQGA7cuVnBLWz7l/HPIE/HTzypMSuCCIwuPW76bcMDxnpl8jQPUFYpXW0ET5kDBfCqvV61CiA228TlOKpHClbCXT44Ge9MKlLKgfBqwTWJmVCvKBSXNPqxTMaE5D83zsxzejOOaoJb73qy3HKm6sjsc3eRkurP60KrZNybO2Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785192; c=relaxed/simple;
	bh=puHiH5qM9Y4+ZDVYi1a+PB5vUFrrij8OEX/dxMPeB7c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sqbHkWgmYiUAlxk0p0FOu5SZnaWLSU2sTKMr1/hwTFTAMxKLZiUJ3LJoH/T43sWyGbupHBA0rjLAneCjFesRHnC8XzWu51VJa9TDtJft1bhs70R9iRuFnrOs6h8O+Jd7ftdKPns17U9V5IRee2TzGHp20KL+tNX9REPaG5bXR1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtiinopV; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtiinopV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784785191; x=1816321191;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=puHiH5qM9Y4+ZDVYi1a+PB5vUFrrij8OEX/dxMPeB7c=;
  b=mtiinopV6ttAW1+KHu6cWWwZy22qh/rNE2rrudB9J7wZd6eG8ck4jpBm
   BwXb9fv0bO2CANOsd5mgMyWstPnokNUer/jxG3Wr5xlSn1aenJTF5bMG7
   8z37hHCCPo+6TMPw+Fd/s6zP/aiuYD9MHJ1VZ0Hgc1ZZcUwZyobRfHS7u
   maOqvjam83HldYVciIoTBPVMjhcc5JxMiRgAR3OrXl2t2dZ9+qb1GZG9w
   eCnKYgRpoM6SeVTwzD87QRyVWmv4PwM8E/TDgDtsbP8X8uDqPf75uyy3E
   +q3M+96aokqOr0Sp8QZeF56E6k4FLOHCf1dh9C5UUpjqseZ3w/mbNQR4k
   w==;
X-CSE-ConnectionGUID: RphMFHLqThOnVuqJnoDU6g==
X-CSE-MsgGUID: I5VzZKonRUy9shVW0ZvqiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85625313"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="85625313"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 22:39:49 -0700
X-CSE-ConnectionGUID: wEdWeFoCS6GJZV2RrgxDXg==
X-CSE-MsgGUID: qEbS/PgpQXu/v0R8rjudFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="281598283"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 22:39:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 22:39:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 22:39:46 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 22:39:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ek64QRXdHKt9bGgbukbuX+V3Tim4uUn8oBOnOaXySfrT84uMHb1zIabkiLFihl5BB41bGuQGw3MyC7s9mVm+Gh+jUb9dGYE+vk/oMvLxg4XX+ozLRGJVpL+PMckf2CI47ql/qH9hbxxhLU6lqHdk0WSOFcBm60EmxmGMsC/Rif1pH0BlaeODqZmcWCO2VCK0UJp6YXqO2jDDqD870+vn/daHtQaKVjOuAlb3RIsh7/Y9nPMHREgalcbZZUnrShXAo8vANWAEMqsQdbG3bsaguEE1wmCLNd146SS/8QGAr3Lm6avnpRA6cTQc4JQDtW5TeMI4h1ZSmb0I225kP6exaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haOQNdm+A47FemnfJySP4o5TFZZzYJn8MS9V+aih7c0=;
 b=M05mx4ZMlpfuq8MKwT3q0qZHfBe6AfCW1lltuPCs0pGpDCK0yh4G+4+TIsOET4v7eH/E3cD66DB1IHnjJhWke3VkO3NQwm6bVDnMoaQxf/mLKod7RKxnbo+BaMXNvaDOA06TbAqHaJx8CJGzTNi1meac6nzYsh3+B/T8tVdIdv+LLV/uPkCaiF5hlYZskB/hbfGKYuqpnT7FVbORdZgLFPRXfDU1FVOg8sR2ucMYbaCMEVZezJk6kZUfkbgLZlbnRjA60DXMlhnkNb4wd3LSxT1nVyoGNPGffjMtMZDaJyngzv7mj1JiXDUVvcKZYLZbPDW61qCKUOu/aQhER+nBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by PH0PR11MB4808.namprd11.prod.outlook.com (2603:10b6:510:39::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 05:39:44 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 05:39:44 +0000
Date: Thu, 23 Jul 2026 13:39:28 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>, <pbonzini@redhat.com>,
	<seanjc@google.com>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost
	<matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
	<rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
	<gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, "Alistair
 Popple" <apopple@nvidia.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Neha Gholkar <nehagholkar@gmail.com>,
	<kvm@vger.kernel.org>, <rick.p.edgecombe@intel.com>,
	<vishal.l.verma@intel.com>
Subject: Re: [PATCH] mm: mempolicy: fix automatic numa balancing for shmem
Message-ID: <amGpEEqxoLq/Y7ZO@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260629163337.1264881-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260629163337.1264881-1-hannes@cmpxchg.org>
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
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|PH0PR11MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb3a698-e291-4a23-17bf-08dee87ccc78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: eBpAOqSqS4WOkUNU39ZMD9vl+m+vvWu8wRhKAAewebnCtQGqqEMZ7sli83JK80osTHsl/YRp4kGj8BVv/rJms4B4Jg3ipgXmR+5jm3X8ba1If8BT01xGOHAhgxIJkUMgDtlkg4O5XvktTg0vqdzGkCnonWHXe06/CGdV5JfGjhFdq5jQRPVCQN8JH54ZQfsihS6OqGCVtxNZUztSevr8BOTOs+IZ5CAT963C3vnvXeEGrpH00XoOydRisaXMttvg1q1d9aLaKaxgFARMLpUW5CHyjeq3HpI/uR3Fnn4k4gLKzjsMRbEv/ddOEGmfUSoAaSYCaDaZbeT41Jla8FL7DhrWJ9z1ZzsKXTTDeCIo9nOTSNltjGLbJvWSwXDmFHCuMTQ45JcOsJVaoNH+3Z/80MJu6Tb7sstDtJU0jMS8n+JoVhPCzvCj8OwMsBhbmc76xLS3z2tP5+mXSSBULb7qAPz8o5E9bkHvqMnbPgtAnmR7Rtdyo5TmoIyO6t3XDlmP1GZinX6loVoQX52F7JuXYKeWFR3QEfLaXeVx/yRNXUz1xd+YgZJZOscsAoBhwjDy8ewFrLcYlsBa4JZC3Fl7pJGKmQzqb5ISYYj2JpeVFWq4UmupkPgK5gUIeYbO3NRnwwju8Jy9QkXqDB0LbnconFnYrz/zeT8ugoZLNisLntA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QsXx8Rx+WCHM7XwgpjhWAVD9SdjQ1Tnft8OEFhFHQVcmAXKAlsnDO7IuT3yO?=
 =?us-ascii?Q?JjxaWyuVZl5QYEmvpcZcOHxTESguH/DCxUyEd2l3/3kx1KAHhtliLse0/ob+?=
 =?us-ascii?Q?pDzFa4AyuL7b2H2AfEWfZ5nNKuN/MZVQ1qzej8mqgHwwe1PRqgsHfpcPu9dg?=
 =?us-ascii?Q?ihCwonchE3r8/izOU0AQr11Ev8eWmC3OJzVELg7d3uSbZEXJFgWqqPWfhMQU?=
 =?us-ascii?Q?jmuBORF8gBfgXwBPS+Ifk3LQ7nC2zVly+HGewDtCKyS6gZs5fBrVbMDn056M?=
 =?us-ascii?Q?RonTM1l2wto3KgDV5SFKPfMTZ6YAgebdztUWp+8Lib12k32wtMN291BP1Hd7?=
 =?us-ascii?Q?tME0zMcrlVqIGQdDzDoi/EFvhsx3PDXv7M7LSiU02xm4Vfou2ELLsav/dJyC?=
 =?us-ascii?Q?Yjp/mQ1zTidORxnm3tIy01SswTRWq2aJysUGrt9kIloiY09WYUVJZ9yLlxZD?=
 =?us-ascii?Q?YGbmKoAkA37gL7bE7qjVlp/ZV9GHR+SR0jIfhX3GEY56oxV53Cp7KQNKEFGc?=
 =?us-ascii?Q?c7WmoVvVRbNRDyl08KsKfBYC3VthdUk0Nst9hSo7347I+hy8RVOCLHa5cvCq?=
 =?us-ascii?Q?9n2a8b3Nee8bLiqRcu+xYb21Fn72jj8N4mpu85kjxXXAqnlSMQcvmX7rS1Nu?=
 =?us-ascii?Q?ppJqt9eB/1Cvhmbk3nA2auitssP5mYPYrzcpV+E2zu94mcZ3Yy30rQonPeQh?=
 =?us-ascii?Q?SLU7o3q1IiX0X847tl3C8O1cTTNuq+XxKIOuJGy8aQPT5dIC/5FfyIfC64YO?=
 =?us-ascii?Q?dt8Wv0HsZezvFQWJovXHltve+ZFiHOVooFrIs4MSz5dtm5/iQGBLIb5NCvpq?=
 =?us-ascii?Q?6+Taym6jeuRJfLgkxG+j9Lh8X5IuhmofWPmdHD6vdbB2Y7kscX7LrsJsMRS2?=
 =?us-ascii?Q?CdZrabB04ot95HDugAgz/+0szkGhmL2yuRT0tJt7EaFRqacdpVjKJSgNEvzr?=
 =?us-ascii?Q?iSkK1ybf0Ou3LZoUA44NMH70to6dlKPtEnV60ctbgpuW0rRMp8xRhD8FUZcY?=
 =?us-ascii?Q?iyQkSJxFi1D5F3vZ7f9MUbaE+MzPOtZswQPSfVOzOCsRoaY3oQHSLBdA/UvM?=
 =?us-ascii?Q?r2Bb84BaOgzS+d82Iq3B5fV+liNjpISawpb9NXOSmXHZRoSL6eFImnD0DX0F?=
 =?us-ascii?Q?CXGW5UzVWTV5n/luzUv4hupy4HtGrzqy59ggx6pbZu9h4en9hEYx4rk51Wci?=
 =?us-ascii?Q?fXnkX2vdgmZa+NhBdd6ogeAJFEPg4tXJiSWd0vQiXXIUElXNeqpju9xnHPlE?=
 =?us-ascii?Q?lyy2xDOpU62UvjIyE59Zg4olR2NUFYlDgEEwIRUk/hz6iVfGv5j2Ysi2Pk9v?=
 =?us-ascii?Q?759NoxYjgnm5brbRwr8qfkgSotbQwhY7ACfF/zgUATLLj/ZApEIiOwqeuarB?=
 =?us-ascii?Q?KzlQUkmCS4Ho76wXQWoOZbz9lNCZNTEU+J8CduS3rIX7oOfoPkOooq43FRgX?=
 =?us-ascii?Q?rbQR7KXm5X6Dz+xg4+vQwa9uJ3FrdrQVnniRXLnwVoNhI/uEFa3cxOpWfTHa?=
 =?us-ascii?Q?dD/E5vWgrkzZA/NBrDjxnfhOMalXaJdnwa3UqDlXYAGq8D0d401c5BmaWXrF?=
 =?us-ascii?Q?KxuduE50A9oO2u2mxYp2/mtoPeJ42jKLfB3XwWp8VRTOPxpIwWcyFxZ65L8u?=
 =?us-ascii?Q?n1NNkAJ8expRWKE0BPItPF6icDIkQ2QSxUMki/d66tZqEgLHUzuqaBS+ZN8l?=
 =?us-ascii?Q?R8jw80ZTjCn73Bdr3JAyjcZpdLNCv1mG4Agh7e7HR2CKpejEE4zgcuhr6gpd?=
 =?us-ascii?Q?kIBvsD7PXg=3D=3D?=
X-Exchange-RoutingPolicyChecked: HDKFg3i/CPF+j36jd7Au5VQjvuUMZ4DR/HWpfwVJ8bdj0YEBPwSU2sd3p80wtHa79QURW/jElAl+B58chnixX6MezC4d7BIcH86M2pQCz03oM4JPZkevQo9XhjjPpSf2MubYgVfqG+IfAoYj0TD/45b2A4yuOKKZsgLtJ4YVyXF2eizO5dwRWDw05hXe/W6U8hbFVJJIUuzBglh3XuHjfpgoyCHW9LRBRaFmRnBaYEDpNte6f87JgtVxhF50QbR1AXONwGrNFQlHqMldZoOahMKW8hFlGypycNm5UBWkJbHYYXgiy3EC7Be+lFJU95gU0toB8DeV4OjImIHufM3WEg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb3a698-e291-4a23-17bf-08dee87ccc78
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 05:39:43.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpNeOHOCJO2oU91azEszUbjnwUh8FLGlStvYamy8kiRr3VT+FiSeES62brEx/T1cXw7DFelvmOp3GPVYyrdleQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
X-OriginatorOrg: intel.com

On Mon, Jun 29, 2026 at 12:33:37PM -0400, Johannes Weiner wrote:
> Neha reports that mapped shmem aren't considered for NUMA balancing,
> noting convergence problems and bandwidth bottlenecking for cachelib
> based workloads on tiered memory systems.
> 
> Looking at the code and going through the git history, this doesn't
> actually seem intentional:
> 
> Commit fc3147245d19 ("mm: numa: Limit NUMA scanning to migrate-on-fault
> VMAs") added a vma_policy_mof() gate to task_numa_work() so VMAs whose
> policy lacks MPOL_F_MOF are skipped from NUMA balancing scans. The
> motivation was a real usecase: Oracle was pinning shared segments with
> mbind(MPOL_BIND) so trapping faults was both expensive and pointless.
> 
> The handling of NULL from vm_ops->get_policy, however, treated "user
> explicitly opted out" the same as "user never specified anything." For
> VMAs whose shared policy is absent - the common case for shmem - the
> scan was disabled too.
> 
> This issue is old. It probably hurts less in conventional NUMA. But it's
> very noticable on tiered systems, where entire tmpfs workingsets can get
> stuck on lower-bandwidth memory.
> 
> Fix this by having vma_policy_mof() use __get_vma_policy() directly, and
> thereby handle the fallback to task policy (-> preferred_node_policy()
> has MPOL_F_MOF per default). Every other consumer of vm_ops->get_policy
> already handles it this way, the scan-eligibility check was the outlier.
> 
> This preserves Mel's intended fix: don't scan stuff the user explicitly
> pinned. But allow default policy vmas to participate in balancing.
Hi,

This patch introduces a performance regression of a KVM stress test, which I
addressed in the KVM selftest itself (see the analysis in the patch log).
Could you share your thoughts on whether the userspace fix is the appropriate
approach?

Thanks
Yan

From ee442e9b7bcbf38148644d6a1e7158947305124b Mon Sep 17 00:00:00 2001
From: Yan Zhao <yan.y.zhao@intel.com>
Date: Fri, 17 Jul 2026 15:55:53 +0800
Subject: [PATCH] KVM: selftests: Set MPOL_LOCAL explicitly for mmu_stress_test

Set mempolicy MPOL_LOCAL explicitly for mmu_stress_test to avoid its
performance regression (around 30x slowdown) after commit 212d76bef49d
("mm: mempolicy: fix automatic numa balancing for shmem").

mmu_stress_test allocates a large amount of guest memory (128G by default).
The backend of the guest memory is memfd (2G in size by default). To reduce
host memory consumption, all memslots share the same backend, which makes
mmu_stress_test vulnerable to zaps due to MMU notifier invalidation, since
any .invalidate_range_start() notifiction on the HVA of the memfd backend
invalidates all GFNs.

When auto NUMA balancing is enabled, if the VMA for the memfd backend is
not skipped by task_numa_work(), mmu_stress_test suffers severe performance
degradation since any mapping creation would need to wait for mmu_lock or
retry until the invalidation completes. Moreover, there is one
task_numa_work() running on each vCPU thread, each of which triggers KVM to
unmap all memslots, contending KVM's mmu_lock. In a kernel with PREEMPT
configured, the contention could cause KVM's unmapping to proceed very
slowly due to frequent releasing and reacquiring of the mmu_lock. In
testing, this could result in around a 30x+ slowdown, e.g., from
"run1 = 16.297574092s" to "run1 = 482.587258504s".

Previously, the mempolicy of mmu_stress_test defaulted to memfd's policy
when there's no user explicit policy. Since memfd's policy is NULL,
vma_policy_mof() returned 0, causing task_numa_work() to skip the VMA for
the memfd backend. However, after commit 212d76bef49d ("mm: mempolicy: fix
automatic numa balancing for shmem"), vma_policy_mof() now uses the
preferred node policy (MPOL_F_MOF | MPOL_F_MORON) when both user explicit
policy and memfd's policy are NULL, causing auto NUMA balancing to
constantly zap the VMA for the memfd, overwhelming the test with
unnecessary zaps on all guest memory.

Therefore, explicitly set the mempolicy to MPOL_LOCAL to avoid unnecessary
zaps caused by auto NUMA balancing.

Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index c799e0d0694f..0c8b12e28602 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -16,6 +16,7 @@
 #include "guest_modes.h"
 #include "processor.h"
 #include "ucall_common.h"
+#include "numaif.h"
 
 static bool mprotect_ro_done;
 static bool all_vcpus_hit_ro_fault;
@@ -269,6 +270,11 @@ static void calc_default_nr_vcpus(void)
 		nr_vcpus = nr_vcpus * 3/4;
 }
 
+static void set_memory_policy(void)
+{
+	kvm_set_mempolicy(MPOL_LOCAL, NULL, 0);
+}
+
 int main(int argc, char *argv[])
 {
 	/*
@@ -304,6 +310,7 @@ int main(int argc, char *argv[])
 	max_mem = 128ull * SZ_1G;
 
 	calc_default_nr_vcpus();
+	set_memory_policy();
 
 	while ((opt = getopt(argc, argv, "c:h:m:s:H")) != -1) {
 		switch (opt) {
-- 
2.43.2




