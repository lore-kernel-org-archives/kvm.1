Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871F53D093E;
	Thu, 16 Jul 2026 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190653; cv=fail; b=hjQTOQGT337Y/rZLrehu9j2nf73LyzXJpkRjxcoC/mrx/yPjeBqSp8WvNxEgm+jn7Rii/mLczlsWDXbO6RJunGguiMbE5GOwy9l1X6Q/FQb3FHk7dNWl3jMipHjhimCeQ9fVs2uPhtzr8ZkJUOnZYRxCi4kYqnnWhUcHGsp6y74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190653; c=relaxed/simple;
	bh=WMGukpUUYoULiaSVqt+Tn4AgOV2Q68LhzU4GdU/gHF4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PNlKNid21cxWv1oKOZax5FunDDRksebb/BvsbPB1Ca1/kXntY+LdRnDuFQfXd1weogdb6D/CmWfdsG9BrXf7koJ09OTSKLeqxcDNaFMed2DY2zms5mIibkQ1hzid2Tx+B4YakUP7KmSnvMhCuSz9NfR1pbC8izmV5g8f0FaaltQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOEE4QQ/; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOEE4QQ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784190652; x=1815726652;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WMGukpUUYoULiaSVqt+Tn4AgOV2Q68LhzU4GdU/gHF4=;
  b=dOEE4QQ/lmpBGZquICz09BLLOfXk/M6WsPb9QXJQ8lubkHVWT/fIduSB
   Wnib5CS8x28PrTN8nY+qPqURHgcjeLL/oaZMkhpyWd73N0wRvEH+b6Si9
   d0weGOjjFFGnEjo0JmmKR/Hx2tA5JaGBAb8Dx8OMXZojqnh0/vO4Vvrn/
   PTaeo9plgAkb9Xxb2WX4l6ENuUE/Hu71WdaPOL5j0pU4DB5hphaNsJN1K
   XHqfT8vzEATkKOiN9BA/zqDoa0seEmTNm8HcXoOFGayDsP7fpKT673UmX
   bQPygvPyZOqtW5BTfyqZSZX7mSdVvEfzBTp4EMtpH2j7tNKH2TxswsjKs
   A==;
X-CSE-ConnectionGUID: uXD0qVRfR+6rBJdU0y6UTg==
X-CSE-MsgGUID: U7Ls/3dhTwq6EpJlMm7TUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110391550"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="110391550"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 01:30:50 -0700
X-CSE-ConnectionGUID: MoWmA5uGRJ6Ut134tJhQ9Q==
X-CSE-MsgGUID: R673mwlQTMeskCLrqp4RVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="254680278"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 01:30:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 01:30:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 01:30:49 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 01:30:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jO4a+OdHrdRVMcxFzFyWK6AGyG0SP4CBoVbqmAoteBuSUQJZiJvhHa8v0MCHTYndNtDsXwjnJmM8uinn/cKmNxw9F/AFfOKZlT1tVZrWi69tuKJ7le3Ccc22RgdSIHUHLYykaCkI32NqOa1TVeAy3B0JyzFbTT1mBEiNUBznh6pxT49IoSFqLKtKtdYtDzBUf/Ech0TKEDS2WCVACPN3CIhjzXuUB0yiqtjwk4S+D/x5OIseI+JHxjiW7EPmptnVI+NDiK/c7+pXwRocR4J/lMjoomdjFrp7S5bI6z/D44zXcqzrj4+wLKnA6SI4M7V9Nnkj2WAKR57TegSIgzH5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n400zjL+5bAbc67spDObP69md19UZS2OqGkjHOG+4tc=;
 b=nP1aay+QaJs9lvHqvSm50GYXSOGJanlgZ0LXNKxRYfh2yhQNzkSU51pppQbH1d7RSNjhUJCuwBX29BjI5yblGHQgpZuypB7giaDa5HkyzPS16nPsUtqEBmAdtTOQwUmQ97rIH8lSKka1pMpOs0f5yb7zE/M51+dbPDjjePl2jNXe3Z6ZkvPWhVXlPzRoFg4EDMwLsLcK4pc9sZ1AdmMybztNiNmOssPfITRkkA/FInC7oUW/dA0MnVVZrjUloxFmN0bb79WAmyu2Jgz8Yk0YFIqgFeQg7FPul+dFkDZpgpskzMIx0UKgvsq6YiZhUJB/WaWZwC327HRlCE8WaP0NYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by SJ0PR11MB7155.namprd11.prod.outlook.com (2603:10b6:a03:48d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 08:30:46 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 08:30:46 +0000
Date: Thu, 16 Jul 2026 16:30:26 +0800
From: Chao Gao <chao.gao@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>
CC: <kvm@vger.kernel.org>, <isaku.yamahata@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/36] KVM: VMX APIC timer virtualization support
Message-ID: <aliWoldWX9/9tqNn@intel.com>
References: <cover.1772732517.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1772732517.git.isaku.yamahata@intel.com>
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|SJ0PR11MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f157719-6587-43c5-9ce5-08dee31485f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EqmaWRVuFOMu24cejyQ6gdzZk+NXzSxItqfl/ejxAS+MWqWs+L9ZXt/CesHZWBkABgJ/ofSB5AtA13SYI0D+L78v3IKU/xMBXWgpMKBaTnq7TSBDLdieGyDZVuehDd94CXwtEzuTYbQutBpfgnGob4DUzhFDxprGz6HjsrB/Gl9XETA2YDXEkWfy3cZsPjpTlDxjGeTaXm6eb/He+pKJRI+S4IGzy8PJTiidpnhNkreEVl+pxBm0tnhKSA/5wxUld5mCZEHMBMKkcBqEpsjRjLT+gCafAtvSQlIUx0O+nJP7Oi637qkj1xnlg61gtPlYOvCtTiN/EuQC/wQ+StNv+n6GHTf7T2mHqIu9cC6J+newkNaBVhaRFQdlXN9RPSUDu2EkyNxXbNfBJxlsZEewH4HZeIOX+IUCP5FCK8vtcKUevTBpG9tdEy17TTansQqX360ZY6KTl0QmA4gzxCw0kw5ONPmqgBd0/DVRB4anhES1sPV7YpQFCdpC7PpDDdpoBX2K4nMY2OPF9rkDMG7AeajhWRVDJGbTwjmRUDahN9sdTVTqYfCGvR5eeh8/66/UsPv7heTZd3aX+K3JCyBha2Vir7eOQOB8fLmC1rNGbCawVsFqPxKJv2zu0bIpv2BfGs34Qk+798Rf73PD0K6VChCCtF+tHdDdwajqgEG5Y/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jEpp3JPN6bLrrMdOp/xfDGpt6X7lmevYgd+xQpiRO9HyM4zfptyU3mnzee7w?=
 =?us-ascii?Q?7jTEbONnp/no3onUIOGxCwEQZQcJlebWSraACM3R/XbE9/kg1wJAbdNTVxSc?=
 =?us-ascii?Q?wLH7chRRxVrkMaY5+bvNfQr2oDv/qqaZUzQ+h7xVulqltvlvXcU8/TN1rV0c?=
 =?us-ascii?Q?oN9kdPmiMwhU5GolwDgcQZHfCDvvHNGvjo4cIOJfSOJnZ2Hl5JYJ2ig4aU1f?=
 =?us-ascii?Q?n8nA3k6+MRdwlgjVP4vXZ3QqoZs5WdZKfHseWfi7ORlVlwbKr31ohf0husya?=
 =?us-ascii?Q?RkxPZ34zLLViFpj/B04QoYt3qQFn2gaLVR/KPBKi+nNTCpsDhBElSqUMqiV5?=
 =?us-ascii?Q?10I/jCWdzLD2WdPcoMRPoqIGZRxHel1chXzj/PE+7i8lKMtIYOX1Xb1DVqyF?=
 =?us-ascii?Q?3W8ViMDIwktL2oa3q9hEzTO9v3fhiCP8zMqWklMsUB7T+8VDNuwV7tPTM0g+?=
 =?us-ascii?Q?wO9+YH14wMAFtvULPJI7Mbu4J1xBOozbzVqSQCqO6WMHxPzisbV2C2MgpN7k?=
 =?us-ascii?Q?QgVRJqz25VOzhSr1q2ISziCtRHiN+q3lYjyg05TAPV50HtihKzOpKgmLFWJx?=
 =?us-ascii?Q?m0plt4vuKLPWxiJdJywJ5axq41UWkqjphkPFZRk2ZRu1d1Y3pfJArPHInBbA?=
 =?us-ascii?Q?DfXkTC+Y9hTJuoc0N5OJ5Kn5Ag2FZNWx9ouEc8YVNMRBGEkcxYIMt24BdihN?=
 =?us-ascii?Q?xYoVtSYbYIT3PcIYAc4PqH+RvdUzEPT9DTJ9tg7i14HwLBNVXf1rm5kwxGNQ?=
 =?us-ascii?Q?QUAqXD4a2Fzp34r0Uw8Sf8KdQrhyioOGz9kIqDIB95n1wqSeX+C/PNbTRsGW?=
 =?us-ascii?Q?VZQgr8vjPXVTBfbQ8kEpiiHYE5ov7qTPTFr5AxXaOVRQa2OmGWpNhCRGYX+0?=
 =?us-ascii?Q?S6nLuAu/XdQsbP/W14RA93OVMt4HSfQSMsMjgQg5XFQZR3nkDQJELwaalYrd?=
 =?us-ascii?Q?aRiKadx9BzKX1kIb5nbeMizRawetC0iPQK3Q/8iJKL3Quvo4WkwwlhzKHXs7?=
 =?us-ascii?Q?j3h7tovw4pSX+TlzgpjljkUBCl5BrwaPMusJXi0q8xyBhiEGF7+MYLGaxYZY?=
 =?us-ascii?Q?yO2AMOR5Je5c8FYJyGqD7rlSx7KjxadFQODWMOCwl3NEgAKAX+PMbAHtZgq+?=
 =?us-ascii?Q?D7qmnKybLjrsR2zxTwVgMOVZcYPWoPAX5sidWoDvZ1QKnEvwIBD34DaPDcXD?=
 =?us-ascii?Q?NJOgSTN68UMcVeSElw/4HXFkVaXUi0XOPKrQLSlzBjAo5wLUkzJDsXM0fc8L?=
 =?us-ascii?Q?/4CVPKf72Lyq41FnfA20kBLs3Al5zYrdpzorb52Qvj2c6UrO1gv2VqV+f03k?=
 =?us-ascii?Q?ka5YzTSA+n1uTnTGS5syna8xORNntu4gzOyHoRJk4SurO1QzGGDOCzq7TlbQ?=
 =?us-ascii?Q?6CoQ8WfVK2epY5O+JxtF6eI6ff7MB50/Ps6gY0KBhUvhdyqHvcbEw0l21Ict?=
 =?us-ascii?Q?t0RVO/XhyjKsUQw1R+wXdmUOnS0vTieDuNP+UnUCE89O+U9dq0hMgdpsLiKc?=
 =?us-ascii?Q?XkKB6iiL6XWnSZztKqC7YH9T7aKjj7iKo7vc+dAROOoY5THgi4yCg3hPPY6s?=
 =?us-ascii?Q?uyNr3wdJJrcAwItRm12G45SZSfoXt9Yeg/b11pK10z+9Q+PDc6XAzePUeoVB?=
 =?us-ascii?Q?6LLZdNO6kaAyXXIFFAR396cjDvD5iFbPuUzB0PZHLe+U0xGfPLEgLa92HUjR?=
 =?us-ascii?Q?im8xWjKGJylQhiy/+/LRzaigRpBwmSA154ZlxuONFIYZp1mLsRMEmtxcolSS?=
 =?us-ascii?Q?QbTgUv/gpQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: ip5qaTiA9bh9sbzbXwlxj7bzH/yKcn9D7tWx2LJx68jhSnDvQZpP54kWE8jGiVVMQGapa1wRI1cPXlZdy0Pvh1uxTokx5ZIY1YT/Si3KkmclpwM7vZSokMs0QD4ZPhkdojUSbslUSEELVeBi7LP+g0CSIWGAtHakJBCz51dd1B70zRRFlS1k7oBKPTOn6Aql/D51puCGunUrC7un96W84UePpsiNMBXd0xYHad9OIpbhYmBmS05Xv1lU6nShut3Z12VE7RA2ej6vM8jBtkYqO7vZ7/PWDX6KQpDgt0sGvwlQ6tFPT+mHt+5yH0rxmmR7/H4Uv6qz9T6f8XY0/EJCAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f157719-6587-43c5-9ce5-08dee31485f6
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:30:46.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tx2dM1D2mVruqEALBQwNbEZ9NtaiflBs8QJvPQHOvUcBMTQc9s8M0irBYUm4+AmZa7Fl5FT7u9unCdFAyddDSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7155
X-OriginatorOrg: intel.com

On Thu, Mar 05, 2026 at 09:43:40AM -0800, isaku.yamahata@intel.com wrote:
>From: Isaku Yamahata <isaku.yamahata@intel.com>
>
>This patch series is v2 of VMX APIC timer virtualization support.

Hi,

I'm picking up the APIC timer virtualization work that Isaku posted [1].
While reviewing the series, I noticed that APIC timer virtualization and
the VMX preemption timer share fundamental properties:

  - Both run only in guest mode, requiring KVM to switch to a software
    hrtimer when the vCPU blocks.
  - Both are armed/disarmed by writing a VMCS field (a countdown for the
    preemption timer, an absolute TSC deadline for APIC timer
    virtualization).

These are exactly the properties the existing hv_timer infrastructure
was designed for. This v2 series treats APIC timer virtualization as
an entirely new mechanism, introducing a separate apic_virt_timer_in_use
flag with five dedicated hooks and helpers to arm/disarm and manage state
transitions in the common x86 flows (see [2]). I think we can avoid that.

The idea is to reuse set_hv_timer()/cancel_hv_timer() for APIC timer
virtualization, with two additions:

First, the pieces specific to APIC timer virtualization:

  - Configure the timer interrupt vector in the VMCS.
  - Disable MSR interception for TSC_DEADLINE when the guest is in
    deadline mode (so writes go directly to hardware).
  - Re-enable interception when the guest leaves deadline mode or masks
    the timer.

These are naturally scoped to LVTT register writes, so a single
update_lvtt() vendor hook is sufficient.

Second, tracking the timer state. With the preemption timer, KVM
intercepts every MSR_IA32_TSC_DEADLINE write and knows precisely when a
timer is armed. With APIC timer virtualization, the MSR is not
intercepted and the guest arms and re-arms the timer without KVM's
knowledge. When the vCPU halts, KVM needs to know whether a timer is
armed and its deadline to set up the software wakeup timer.

The solution is straightforward: on VM-exit, read back the deadline from
the VMCS and update KVM's existing tracking (hv_timer_in_use and
ktimer->tscdeadline). This is one vmcs_read64() per VM-exit, negligible
compared to the exit cost itself. The existing vcpu_block() path then
works unchanged.

I prototyped this approach [3] for enabling APIC timer virtualization for
L1 guests (nested support isn't considered). The result is roughly a third
of the code (110 LoC vs. 300 LoC), with details of hypervisor timers
(preemption timer or APIC timer virtualization) fully contained in VMX. The
only change to common x86 code is a single kvm_x86_call in apic_update_lvtt().

I plan to post a series based on this approach and would appreciate
feedback on the direction before doing so.

Thanks,
Chao

[1] https://lore.kernel.org/kvm/cover.1772732517.git.isaku.yamahata@intel.com/
[2] https://lore.kernel.org/kvm/727502c8f79850fae6a8a476a624e5902861db39.1772732517.git.isaku.yamahata@intel.com/
[3] https://github.com/gaochaointel/linux-dev/commits/43056263022fe57cc9a10ebf2828f0f29611d6c
