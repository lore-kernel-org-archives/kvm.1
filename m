Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8771A6820;
	Mon, 20 Jul 2026 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784529022; cv=fail; b=koNklN7UelH7re3k5UyIpyYnFRfdYa3Jwulor17T1M+LSHb1HUXPAlZsDfZdoBzIA5eURDkUuYjrpdHYgQxOZWfFEYHIBa4gLMHZfgkmMyg5Z+ocFI7QqeDaQhAqJkCorj5ShC6xTEckOBOn0K5CE+e4hoxbEk5/cTyckZebc4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784529022; c=relaxed/simple;
	bh=v5XqGbYgBPsTfXegCC/1COBd0VfeCuGRYJg1aJaI/j4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EpUnUiJKpXjfC1ZD52GJTjyqBfsPRMVqITJbm33hTbHEJ8nlxVIV/3PaDokIriKKynt5ZECVFsHdGgUd4LqDPAUR5J5A9qJpadA5DUObNkRh43oPPz9AVLiCxxHtfSF5MI0gj7zK8fAQcUIFZDLawR2G1nc7qaWic6LoEFsFhwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdiXsXjp; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdiXsXjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784529019; x=1816065019;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v5XqGbYgBPsTfXegCC/1COBd0VfeCuGRYJg1aJaI/j4=;
  b=EdiXsXjpT29nY80e6NAc0b8B1vmKtdqXu3nvCtCTy0ajy2qMjQ4Uj0YB
   pgtZt7VR0cwQw/pRTvwVcqpkxWMwQA8nGK4q+iSRfrRZ2X22bJfTHQyHp
   7s3Yy04EX17jnMgcz7M+Wx6UvJPFjYLqd6lTdH4ygwKQjLzL8UqO1TMn+
   k1cQahiin5CBB87vorDP1dfTNkOgPpd/xpF008jDDxfRBfLcaN9kyomb8
   mgc774f7eHuXAKDeUpTgZh3XfKtgg/BdPDo2av8/NqFkvC3izxwENa8m5
   swVA6iaiD16KUVwNQuradZXOuOSHqvrD+iAlyBJGihjGIcA2Ewxba2d4S
   g==;
X-CSE-ConnectionGUID: hivcQ4NiRO+ZukllULGTTA==
X-CSE-MsgGUID: /YqkjjesT2ukWiTC9aBslQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="84981142"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="84981142"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 23:30:17 -0700
X-CSE-ConnectionGUID: J2uPJT02Q92jFMs9GWVCZw==
X-CSE-MsgGUID: JqOS5PuVQESISjj+gGdwYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="253963498"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 23:30:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 19 Jul 2026 23:30:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 19 Jul 2026 23:30:16 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 19 Jul 2026 23:30:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFivPi6fqqbbj5/tA6lCQihGUkaH3RLT+j2bS1vCCHF0s1Xt8/S2i26bPieCqS1YfVtTkO8+ndWreQgZesy5XQUQyg+nyswOJUtYygXyHPnhliIghlgB8rUZ9bvDwa3Q0662GYxuF4akPTQCmfCxX3axAebr/AC3YTZC8ZT8kvhh6ZSZ3GqM4+LrhnyCDQjdRgxTwytHcTIBztjiuQBAM6C7BhKMAH6aZpD4n23XIZhHWQc46isgGV6ux6yB4/yuGroVCehef8XKEWPm1lDLtRa3RDFXi7CQk+NrZa0uIJXtIgaR/baKhQJ9nGVrSq9Ptwkpj63LnVNDajgxKUTbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIegmsZg2X+PFZ74gR7o+XBwEc46RcFPZVNHTqVslPo=;
 b=wyLQrCPpUBBudoZdQWHClA8ElPEz5COXjmnjdfhIxnjSbieVx0ZblF8OcVCDzfkuNYe5Pw0T+6csLtzjXlsWauHpA2T7hB3FgCmLDYb99YODbYRthbOgBp/RxY2RLt2/9HcsZ6z7d04sX9Z+BTmvkBz34Aw/dReCcQ/JtfXHPjtRzTRF2OKkzW9kZKBC0fmzGJSUU1lNdBeQA9H2B5vgtWq4vF9/xGMVLVZ6PpjW+o04X8XpuEfN2sJ3u9v2WdMyPYnrdE2BC2EcGsUaaBAw4vansUbOISdjn+b9+8vQ9oxLjShVq7a9J3K2JcI6GVBFNmwD6ZaExAm0S18g6qU5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4450.namprd11.prod.outlook.com (2603:10b6:a03:1be::20)
 by SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 06:30:09 +0000
Received: from BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068]) by BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068%6]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 06:30:09 +0000
Date: Mon, 20 Jul 2026 14:29:57 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dmytro Maluka <dmaluka@chromium.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Zeng Guang
	<guang.zeng@intel.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vineeth Pillai <vineeth@bitbyteword.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>, Aashish Sharma
	<aashish@aashishsharma.net>, Grzegorz Jaszczyk <jaszczyk@chromium.org>
Subject: Re: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU
 creation
Message-ID: <al3AZSxl9aWR9YQh@intel.com>
References: <20260716160801.3155582-1-dmaluka@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260716160801.3155582-1-dmaluka@chromium.org>
X-ClientProxiedBy: TP0P295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::18) To BY5PR11MB4450.namprd11.prod.outlook.com
 (2603:10b6:a03:1be::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4450:EE_|SJ2PR11MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e329cc-508f-46f7-7962-08dee62858a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ToUBhpgSgBLQZAw3sigcPr8Jl4eranaNVt1duJH+99ZzvwrTOMiCYBR+JzFuEqpmi5hg7trgnloELXXbAQHS5flL5O/vL66ZQJOiYSHvfYUaztkopQRAGzyfBbbAWm5IL/qIuJ7FmHkAY5FxlUXT524BzDNm6D2W7YV485LrTXtYv4UPlf6yUIIa/s8CkP8NBRoiVUGOnkVt/pL4oky3dRQyZckHTUo14dNzvvuDLhkl4EDwLaYT/vj2iCJy6cOHmh6+FMP7ZG0FwBtDm2lbIXf85BNyH7X/BtWptuR1dW28i2bHwVIZDgTBkA4akip1IXuH9iBPKOu6uhMkcmkiOQNvGA+rhw7V12CKEiCjSan1EW0NipYMHO+alZoIJ5SnjCv/OkpnNo6unv5rHLtUn6sTN639ZVGMNeA+o/kkhPQ8+HrwgTpGM/mIWbHaBY4buH6N8QgSccpKjh+JzWH+pN8Ehzbxys7qZW7T0xJWAs5Lmxyt8uWmSqF6tfgN13SCbvXndwL1cLgglJnubH2tn/s6RaKMdkDhHfJ8z77UH14SMOfxT59Kc1LvxgVl8Q7drxTzCLPkZ8Q4gwSOIGzKO7yAe2/r8Si2pLpUTmxrLP7P+bH2FXfs9mUvXlPqcBg66OVpVYYM2T2f6dwdeq2zJjjbQCRhI+t6ylKkUtgBiYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P+5fC4+K4uCzchwMM1ESTlq82TBqo8DCj1h0AaY6w2ZMEHshIU8+fuRRXbjh?=
 =?us-ascii?Q?/amTJ1cfsZYT8e/gARXKx+7DtOJCEAciMGlGA4d1AzVYxK3ykSPH7ee/g9q4?=
 =?us-ascii?Q?rK4k9nyIocs3VoXlkAEstV98aGziB5B1koNfUTXynAZ4kraF6zg/fCvxY845?=
 =?us-ascii?Q?VU3OSzf4VRz+yxzXERFzhPWoQ9xOT48hWlAGHU8XUvQyuDf87EpyH//xYzCz?=
 =?us-ascii?Q?GU/0k0bd4XDUSXnw10+Bsycg01i0+Sg1s+c0spk6nvNi01JIPiu/NVIdTLmu?=
 =?us-ascii?Q?zdQD9Y/JLfYVsjQ7ypBaxK+58OcT7w4DwtZQNALJjcEOw2fuFz3F9jn1SzzN?=
 =?us-ascii?Q?/76HdwTv5hxXFhXQ8mnljlB3q4D4gZgMk8TFA/qYvtkIf57GDBYTnZWaSuqi?=
 =?us-ascii?Q?GiZa6HD5kPEFNTxgkk9PirruF9iq0MfHC4KiosxOvG+lHf8+6vpe5VuDRxIj?=
 =?us-ascii?Q?6yVQX/KcQcqNy++cxcJPIavV1T8+zdPRBF5RfjGOd9rzPSgvNWSBHGXTlsY6?=
 =?us-ascii?Q?Yrv1cQMqvflJtDTe7IEpYSWRhiriY8PzIWFMuL7Qy37YqIiWu9PXfRfS5H+J?=
 =?us-ascii?Q?DnecIih2tYBsKlvxNJystp3DV+I0LZjM0BE+x1j/Yk8HebZsAZqcSKAkQm7G?=
 =?us-ascii?Q?I3uKF539L5f+XzlDG4pSTY4tiAeH3Egz6W4UU16biv4rfIJ74Js56l59etCw?=
 =?us-ascii?Q?vFS+pKs92KHfO0Mh2ssKLcB54px1MSGI5MGq98BlniWUIxX3Bik6ZA1Ifh5/?=
 =?us-ascii?Q?bdPqR6ahrUts1yIWuM0BjcMWHS+WWQD54CD+LJbDcIz+Ky6tApMAerAO7g2G?=
 =?us-ascii?Q?BczMNot94SX8rnaHd7HsgUtH8pVjzks/8G/7XRD77i2oUYQQyWtoGb2MIVxv?=
 =?us-ascii?Q?9/OcPDHrB2kxaOVdZDFAjReJtUQzMhrT4eubkl/QSGBoyAZL6kePHcNlAjM4?=
 =?us-ascii?Q?q5FSPi8iSqCXGB2zVcbtDaDGFQk4TmduuzByZlDMQ0iXx8pUGaB4stWUi7gI?=
 =?us-ascii?Q?CFliI1Pj+IPaz4sL0bUHoKJP1BqlHwFqVZblVuAQntZdN8Sd37MK0joAAJcg?=
 =?us-ascii?Q?oR2sXGWgnJ69u6fLxAI/pnNu+cGGye5vj4pL9FXROFCt1AZdfYjP5+lOo5bZ?=
 =?us-ascii?Q?x6beO3fkwJOHkWBikpSS+mdMFLlI5qb2PhEPhR0A3CPhjjdTvYNpVFIOJ6oa?=
 =?us-ascii?Q?7v4RdIWcMc4yZrobM2x73Pn+/Kr9yffbQa4FAJS20GCPZNTuhvRLV3MxI60/?=
 =?us-ascii?Q?J4lfwvdhV5pmTrsmDVZOZU8m/7Yt6loNOxYVwy2kjzqerSNQFfVtJM+jpbRB?=
 =?us-ascii?Q?hPar2MkagglD4Af5Md7Y28C2Q8oCNbhWqs1HBupMXQgvfVSkKfdWQqBCXguU?=
 =?us-ascii?Q?v7rWCdDwSL4PSl2rbw6qp9v0Xr3cU6bI/UyhK96Tmj5QPIN6Dkeb7eFHhiHC?=
 =?us-ascii?Q?0mMp+GnVvaFeSfdgzFe494LOeiL5ragFgkiC+yEDmgNFqXcyd6Ei6XdN8+j5?=
 =?us-ascii?Q?CkQ47ioETWJgV93Eb6zV4P44LxBHNsPlGIJ2dj/l11mrbQfZqv6DF3600bfb?=
 =?us-ascii?Q?RC+AcJx5vCid87Vx/ysH9ZVmKHZiuelL77pWPTm2g0+4LWj8680iu4gO40A7?=
 =?us-ascii?Q?D5BbVCbWs6ZaZ3TuQbfj9JaCR5m8EKW3gpLvAndAhzyvNp4G9908o5zhT8Hj?=
 =?us-ascii?Q?+/KzKaAxM+Xr5iO4L7yPKamhrbIBADMkjhSNfGzANmZNqyFnj90IutDS2Hz8?=
 =?us-ascii?Q?swVnEy3c/g=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZFWSEyYVlc7f+e6wauW2/vWHsocv5DnC9YgtKT+FUv7fHt7NDLD3sDovR/eEp3T6ZvrUJWdmLrBpIN9bs+C4YL+RBEr8Ib0i3qZW45nH+qtFiTY/RRDvxgvdihNT/KFeV2ntbZpDkbO8XRfnNxOMsxYFmVS159sCWLNndywFXd11bUyrGQph6MnaYeaiq/0nLq7YC3uiQob7KNDd14EZ6chUsTGngKnXYIvP9DyNhyyyyAR+6tND6RNjV+nPAF0S56IoJx+iHjrG4/GBBjHUJC5tW0Rro6RXF7+g++JuqdVznWZb67dAlIYy5WP26ne6o2BmEvRr9xFvQAXKPOUAtQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e329cc-508f-46f7-7962-08dee62858a7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 06:30:09.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcLllFzRGtH7BNI/36RiN8dMJV5E5AulZujdlOb47EfMUs0K/Z4dSME5LK79Yxul/w9tuDGyTI9rg2dWOR84AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8370
X-OriginatorOrg: intel.com

On Thu, Jul 16, 2026 at 04:08:01PM +0000, Dmytro Maluka wrote:
>vCPU creation in kvm_vm_ioctl_create_vcpu() may fail after
>kvm_arch_vcpu_create() -> vmx_vcpu_create() already succeeded. In such
>case kvm_vm_ioctl_create_vcpu() destroys the newly created vCPU in the
>failure path. However, that leaves a side effect: the IPIv pid_table
>entry remains configured with this vCPU's pi_desc address. As a result,
>when another vCPU sends an IPI to the APIC ID of this failed-to-create
>vCPU, it will cause HW to write to this (freed!) pi_desc memory. [*]
>
>An easy fix would be to clear the pid_table entry in vmx_vcpu_free().
>However that would be still problematic, for the following reason:
>userspace may try to create a vCPU with the same vcpu_id as an existing
>one; vmx_vcpu_create() will succeed, and only after that
>kvm_vm_ioctl_create_vcpu() will check for the duplicate vcpu_id and
>fail with -EEXIST and then free the vCPU in the failure path. So in this
>failure path, vmx_vcpu_free() would clear the pid_table entry for that
>already existing good vCPU, i.e. effectively disable IPIv for that vCPU.
>
>So instead fix the issue by moving the pid_table entry setup from
>.vcpu_create() to the newly introduced .vcpu_postcreate() callback
>called at the end of kvm_vm_ioctl_create_vcpu(), when we are sure that
>the vCPU creation succeeded.
>
>[*] Although, since this memory is freed into the kvm_vcpu_cache kmem
>    cache which is only used for allocating kvm_vcpus, _maybe_ this
>    memory will only be reused for pi_desc of another vCPU, not for
>    anything else. So _maybe_ this will only result in delivering the
>    IPI to a wrong vCPU (possibly of another VM) in the worst case, not
>    in a random corruption of kernel memory.
>
>Fixes: d588bb9be1da ("KVM: VMX: enable IPI virtualization")
>Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>

Reviewed-by: Chao Gao <chao.gao@intel.com>
