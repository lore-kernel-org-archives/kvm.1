Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1533FF1D0
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634468; cv=fail; b=CzSDIHOILhB73eQpuZ/8NFcfbWUHN8owvYUuFospi9Z9PH6CGaX4Ou2DWQYdmyo18gjgSZRb6qmSJeWGQTzM4uSK2dhrYrxbYsZ1TNtVxz7N1d33gNTQuVhCCE46GznaX6cN6gJ+LiuAdt7a5DJwSCjFMPvUSz4fDE5ex0URvUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634468; c=relaxed/simple;
	bh=ddhwyW0czLxPbRV1EiV8hmyj6CDMDFF0VtzElWRtDMA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZZxJWyYVKJ01lqxNrbCxofkEooIh7enTs6GwrplxQtBNsAJuVtI8Lfq2DXo8FqVps0ltjqyL3ZTgGnbGOEsL19wnx3d7DwYU12rDUmiEcF4zS7rbbHfyrb7XKBHJAnUtF4do2vkydcGwHGMRvKa+QhvoD34kY2O5dZV2h2dzUC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boLT2xnr; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="boLT2xnr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784634466; x=1816170466;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ddhwyW0czLxPbRV1EiV8hmyj6CDMDFF0VtzElWRtDMA=;
  b=boLT2xnrCJ6Nd2Md8OAqy//N8lofmsFZ6xaGAJiscRA9gv0xULJpMoR+
   BXQfdH9GnInJInU8p3UgEyyOXqDyKtTzgEtqueyNvLo9MV36LHknU7cIA
   hli+Pmm8X29K4SYcUMlIR4DCBx8WK0VYKPJJ0k80p51qpPXVeTiRsgjDf
   lKqGtenc/dEx522Esx9JpwGYj98qXIlXHssmKLxT7eOYfqkHzQX/MHzxL
   GL5lhl7nwvoypyovMxJbeWg6ZHv7QKyD676eJsNyULZeo659VNOpCmfFF
   oWF/G16zbkrOj8qPHMbWQ/IZ47/NIFrCNvYwIR7kbWCMEINdVvPdepALQ
   A==;
X-CSE-ConnectionGUID: 5YesdtiPTDSohiup+R2bDA==
X-CSE-MsgGUID: +619g6W7Ska+Nl4/8fd99A==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85431809"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85431809"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 04:47:46 -0700
X-CSE-ConnectionGUID: GKb6hhZLQ/6e0Ctrp5tikw==
X-CSE-MsgGUID: vInf7Kd5SkuizkV7zDpJ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="295951523"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 04:47:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 04:47:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 04:47:45 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.26)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 04:47:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZMfSiGxV+tJ8WjL/YgQ6a8mH21Ij5JtSFkhhivdCmLVMn411JucDaIxNUNU6mUCtgK/KpIXNSb+s2UE+L92tJXJiSBIfAqI4SvSnMsQkF9iGU7paGOxJASgUULxSg6jAsoXXIbBPZewmwvn10ds4Ys0MF2wR4jr34RXBeVDemi4dkWhP32oY0BGEKU3N/BRF4N2rx12XyESJoOyll/GChIUCUNhshVaGMiKkLn6gLVvjW80UOfCr05VcyCWDBj0gd4dKAeCOHhjp0GIJ0RXEbvlMOzkeO2AuTMc0MKuRVwg6qzBr2z+9TQspyJgL7X+xHyMb1eRmSIDguvHI8kOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3z2JkradJyw6tsFy293I7OUij3Kp/4BmqtIo4KWZCo=;
 b=WGCJFFQpN7fxNPN/3as4Q7Or2LcyqVTmfxh2hIZlqf8MguXJmMRdUF9QG9HAq0rzYHEwd7UnXcoOCtA/zZ8msuRmAr8zaNoVpQ4b5OdY5FC0lf5z9P/e//0maNMHkUxFuWe5ooGv9CF5R/36FQv0ztoFxTK+yWuODe/Hg4B0rN7c32Vkm1xdsbJXM3/WRDlcnv5XHDTppyGvAQciNf7ySOkfq08KCfHkcGNw3icBKt5OMA0Bokc37T3qkq5r87AU0RqnjCcX0Mc6tVVMNPx42z+ROFnGQqBAmUdZC0qpgWRwshORZAdVAlMTTjWqD5hnsXejIUTfyxQjYBXFgeHIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4450.namprd11.prod.outlook.com (2603:10b6:a03:1be::20)
 by DS0PR11MB7832.namprd11.prod.outlook.com (2603:10b6:8:f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 11:47:42 +0000
Received: from BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068]) by BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 11:47:41 +0000
Date: Tue, 21 Jul 2026 19:47:36 +0800
From: Chao Gao <chao.gao@intel.com>
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v2] KVM: VMX: Cap VMX preemption timer to work around
 Intel errata
Message-ID: <al9cWDWvIK6RCrnN@intel.com>
References: <20260720231639.1592848-1-jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260720231639.1592848-1-jmattson@google.com>
X-ClientProxiedBy: TPYP295CA0039.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::10) To BY5PR11MB4450.namprd11.prod.outlook.com
 (2603:10b6:a03:1be::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4450:EE_|DS0PR11MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: e631028a-a068-49db-8cfe-08dee71ddf12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: NzZdhGtYx4zyrmeXLOMoiVY14YBPDAniqcAD4XREAf5nI/WoYl+cZT5vozq5uwum+f8sdpO6jQx+9iS8ArAz54dxR7I/0C65Vtt6gleBxBDgc6lBo9oYC1Na/TCQOhtLoxCivwWYEoZY/6IEbCoghBKP+TBnzdmY/Yib9VunFcB9TIBuKicnQwB8s0qhI1lgoAL6dGr3AcmqFCWNoMwvxT4X2B78C+4y5fWL8AfA77T7JbXZGYjOBDn4HxgcJXldMHqSAA8EeK/W3/pj/Jizm2N9GdPzJgbprKC9AJUVKnrzNMEfbOoFe3f1VJ8HIR7pdVa9y3UMspZXJUUkRktSK+irUCXKyGo1jpWlg4txAwrxONxGKd8WAaEK5HxPdWUvdwteYrEpBF3UyMZq1O3Gzwfv0UR2pDjjFOK0uEYMMV/AxRLOZIti9UsI5n/aI4oAE0n1lBn+OkeD8SCRtbIYYMGt1PldvSDyThDM1K+nw6pDOZ7NXiZ6GN8xIsz88agY9yxBw4/zX+QiBj5i128O5feUgWldzrGQulq7xmq6cjp56R+/6JO4ql2J59wHbxxLIho1eVNzNSu5b3w/L0yCpgIGK3aXjmHPNdK0Nh84PRejdvGmr2u2ujczP9rCi12e++136CXfC8+no07HyIj93+UPQZ5sOcKVxowjCjpxJ9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8XwMWOSq/G5/6GtOcjFSE0k4kyUEaVqKxfscWNKMZo6c5XtQQbalqQ6e9pHy?=
 =?us-ascii?Q?N3YsCiPzcNho+UwqSl/a5c0jLjxUaMYgrxVv+KAvGppAHtpOdjvUEpCzhE0b?=
 =?us-ascii?Q?LAzZLY3DvOdL5Kvww4LsQL5VMa4ebr/UycpXFKSatHnVtaZvvT6YUuC29psC?=
 =?us-ascii?Q?pPzhW8Z4RQRTObc6Ghqf8AbsSFYLxBVc2ZlfIOgv/11lhP/vE5BKpzXz3HPP?=
 =?us-ascii?Q?CFqMGwHD6hqFCBsb+4LpnqjvNKbpjIM3HLxmuxM4DjLatP6y6+xOnwD54+Ef?=
 =?us-ascii?Q?2j5z/OIAI8xdCRJPHK8xiVgOfENOFphhBk2JwkNba9x2UFeYO5tmu/GoHyzv?=
 =?us-ascii?Q?NQ0IYjOSYHCyJ9DZbapv77+17Cf5d6kWMnsby+tyz3b+BkQQOsf2jCtjO1uR?=
 =?us-ascii?Q?CYQcSWyDglVpEfrM7AoM0TvPP0y06oNfRa6QAr4CIRtf3ZwPx57HYm5Nemdv?=
 =?us-ascii?Q?8f52WcyISWYze+3mB5h3sbeMremfb0sLNtQLXqz2ywAkW9nZCqC3kNjbmS4u?=
 =?us-ascii?Q?JI6O4b9sWG6asG0y8BYGgPXJPOe2Z6iMPojkrc71Tf6DWxBtA4FoD6fw+5il?=
 =?us-ascii?Q?k1ovovI0ai9qnGIs4uoN9yLPG/B0F1rnyneKv+GWfOC2z6Y6JCPAxGFZ2kAq?=
 =?us-ascii?Q?9Po2RyacMQiOuetxEUQuQsYq619S0+z6uAqGkJ1AIkDtiLus+GMy/AeWMoj4?=
 =?us-ascii?Q?dvwz16xDLAt6f7zNKEiYrs1r4STCWOkMXeu+ZDWUxlF6OT4mm6cNEIayMCU8?=
 =?us-ascii?Q?YLuRdrFePvr2YRUhN+XxFpN7nbC5/0DEqEBLZidQ83LatcJLDA4uBzQVPSo4?=
 =?us-ascii?Q?A+SQBO8dsLhxQP8cFgq4YWE35CslJ1ykVMCWyxuCeiqF0pbtzFCEiZ9Se/oH?=
 =?us-ascii?Q?ZD59hti9BtMGtrsjJlkqsDlJm8YZLOI/6VUT1CN99bsB9P0rKcu/4JGH6edG?=
 =?us-ascii?Q?0S4kXAHRA4Ieiu0j39E2CBHys5rBehSxy/mDAVb4aFRTv5C3BVMe9I5tRvmC?=
 =?us-ascii?Q?KohEwPWt1wQKtiDIX0BWGCCCX5gampVlHK8rUxYXk+gBEanzvS5f8cbmBANp?=
 =?us-ascii?Q?fOASaf7/A2xIhj3dLLAZdYWO0cI7Qf/Ygu8JmgNGuqOENn5AHEjnDBmiu/g9?=
 =?us-ascii?Q?e98z+QBEErWf1ntPt9zI/gvvQLwvgq9/sqJ3CPGhrpaMhDZ8FyaePBDVNQG0?=
 =?us-ascii?Q?ewZcFvbTvrAmfJdKFAVRMq2ygpgkhmM/wLa44zbFSydfQfw+PM/DOtWTTL2W?=
 =?us-ascii?Q?LgQ1NKm3tXfJ12VDF9H3hr+tO5mdEU6/QQBkDM0wqsq0odmNnNQHgdbu6xvv?=
 =?us-ascii?Q?9JVMy3gaw0quze6f9d5lyKWqokdzcOf85lNKl/M0hX2ne36DwW+YVhlAyOlB?=
 =?us-ascii?Q?C5SPGOd8i0lwYn8R7gPQg2Zr2bGvdoZkIm9SdQp+WHvbTTRcClney7xn1P85?=
 =?us-ascii?Q?HNfdFJW9iCxM7g4i02+ny4a3NaiTAnwmVOj5bEymiVP4zbS/migrvWF8IXCi?=
 =?us-ascii?Q?w3Kmba5z/wpCyY76zJwrv5gS0EqjAMFiYo6h40+AXQyAds0l9xbsrSXJHeDy?=
 =?us-ascii?Q?yrOB6EnMnmPVPUYlOWEA6L+dFAqxTsY+CUaMzASKDj11MQYJNCvUvUNmVmFb?=
 =?us-ascii?Q?DQMaTa61eAklSTlwNgnoY+d322BxQkqBa2TcL62kpneX/6pG4e09dz+4K79B?=
 =?us-ascii?Q?vlw2LXmY0zBatxc+1pqveWcda6DCBT6E6mkBOwCmPjV7k2oBFQSWZoSDqVuq?=
 =?us-ascii?Q?ZRMPyz/PGg=3D=3D?=
X-Exchange-RoutingPolicyChecked: jdMVuvy0aKkCoaOP+v7sLWYIEjxO7ZhymcXs4klMxCAkgfMAv2HaOwUY+EPxsw5rJuD2IukwK2lrE65KTeLje2DMic1+5lQkBEViXuAml1JLtbl2sx3VJwZVHFEkYbdZD64gahx/akT1hnPjX6UvIgt4ZeVvXJlziajLoMsrY1gZKVKCQQCLm2k4KUgbUyDWvBBvik1s7Qnh4xzOhMeYvLCg1OdPE5HEkiZuP/X0ve5eLz07mdxXgkgswiIAMnHpHQqkWwGJjTrJxLEjIvTJ0ORKc1kfOM7MFqGqe++1PTtbmo9YdvX06dCOBryKk8a0qmP4MQEMulOLSOmJoQE59A==
X-MS-Exchange-CrossTenant-Network-Message-Id: e631028a-a068-49db-8cfe-08dee71ddf12
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:47:41.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFiGHVLdSEHs4X7Q9Zsx4aPZsH9LC6uAUjnwjcEAf/FBkYVZHmKVrjRjZI6AdcuPa5AG9pHkA5ggaiCl60NuEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7832
X-OriginatorOrg: intel.com

On Mon, Jul 20, 2026 at 04:16:39PM -0700, Jim Mattson wrote:
>Due to a widespread Intel erratum (e.g. EMR158), programming the
>VMX-preemption timer with certain large values may cause the timer to
>expire earlier than expected.  The recommended workaround is to cap the
>VMX-preemption timer value to strictly less than 2^25 * CPUID.15H:EBX[31:0]
>/ CPUID.15H:EAX[31:0].
>
>Calculate preemption_timer_limit during hardware setup based on CPUID 15H
>when available, and return -ERANGE in vmx_set_hv_timer() if the shifted
>delta_tsc reaches or exceeds preemption_timer_limit.
>
>Reported-by: Sean Christopherson <seanjc@google.com>
>Closes: https://lore.kernel.org/all/Zn9X0yFxZi_Mrlnt@google.com/
>Suggested-by: Chao Gao <chao.gao@intel.com>
>Assisted-by: Gemini:Gemini-Next
>Signed-off-by: Jim Mattson <jmattson@google.com>
>---
>v2:
> - Use div_u64() instead of 64-bit division '/' operator to fix link-time
>   error (__udivdi3) on 32-bit x86 builds. [Sashiko]
>
>v1: https://lore.kernel.org/all/20260720205230.1457146-1-jmattson@google.com/
>
> arch/x86/kvm/vmx/vmx.c | 29 ++++++++++++++++++++++++++---
> 1 file changed, 26 insertions(+), 3 deletions(-)
>
>diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>index cc75feec05da..e43ed863d5f9 100644
>--- a/arch/x86/kvm/vmx/vmx.c
>+++ b/arch/x86/kvm/vmx/vmx.c
>@@ -151,6 +151,7 @@ module_param(dump_invalid_vmcs, bool, 0644);
> /* Guest_tsc -> host_tsc conversion requires 64-bit division.  */
> static int __read_mostly cpu_preemption_timer_multi;
> static bool __read_mostly enable_preemption_timer = 1;
>+static u64 __read_mostly preemption_timer_limit = 1ULL << 32;

This is set once at init, so __ro_after_init may be better and no need
to initialize it at declaration.

The rest looks good,

Reviewed-by: Chao Gao <chao.gao@intel.com>


btw, KVM is using 0xffffffff as preemption timer's max value in a few
places (the use_timer_freq sanity check in vmx_hardware_setup() and the
soft-disable path in vmx_update_hv_timer()). I am not sure if those should
use preemption_timer_limit - 1.
