Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99399346FA0;
	Thu, 11 Jun 2026 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169909; cv=fail; b=PJ4echGYc8xtUYM2EiQ2PinJ4DmjEQ4liHYizIrrh++ZOQJijCV2Mga0AZnUzZBiyZ2G6DHTH4HWhWFF6E/zzP29VNSnSFV+LNYkaDCPQo4lq3r8rc5Ju4Mg2L///3XASD6JGI7xtWgQy9jQMYvjGxZpm3zhUvKdVLcGkfDHaA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169909; c=relaxed/simple;
	bh=VmXtG2kemNS+rjfDiqH1wieTYjTkHPG7JENB3SNG42k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y6IFVGZYdRLsXUiOQkFf91l9I8aMsADJlZPQmW/IXiFc5gN/vhTeuugSEHltXJHNac8hjh/WK/7nHXihMeX0IMOKTV81WWvIP3AAKoGZ2ZtHvPWVkd4xeGYw9nADxnCm3PJZh62V19rPITY6+XdgVi8MuuztL2ehXwKjkpMedfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZvBk3YK; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZvBk3YK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781169907; x=1812705907;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=VmXtG2kemNS+rjfDiqH1wieTYjTkHPG7JENB3SNG42k=;
  b=YZvBk3YKUVz7dtYsPP9ZNCIw7mmRUfzTne/OK38eGfRNAoSGr08GgQSR
   FOhPvC83+UG5q4HwBykuEuSQwt6Dk6dQ+7KrSomK8+iZWD1EzstLtgbQd
   sPWofEH0KAx9hFDO1hRPHIqkezPaN+Hhl4D/HPpMdpNxZwFa1HjrDnlT7
   19uBMl/veCl+wzMT2DTjBI5MA9DXMF+Y8CJGBNPRvwCep4c5kplcP+1Mt
   Myv77nm5Xks4sDuVzBpzSZSIPc0nqAetxYXtISbZ0loraabRDQaGbkVTi
   kj7Cu5EKRIiJafdSUaF+tbaO1f68ZUXDe6Gl62YyT2no+uuGjCRmAwF5S
   w==;
X-CSE-ConnectionGUID: CgRVPFdHT0WAAWfQd9Ja4w==
X-CSE-MsgGUID: lD94cWJYQrG4rKx63HoBPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="80994788"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="80994788"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 02:25:07 -0700
X-CSE-ConnectionGUID: zhy5eLNhSnOHqjfNDiWc6A==
X-CSE-MsgGUID: mv+YZUtVR1ynzNrpEwBZ7g==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 02:25:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 02:25:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 02:25:06 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 02:25:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbIHSMyTzr0xYxmo1EU9LwB/SAR7Esj4Hk6Em4iN6WG/Zy51ljQUgwl2P5C3kCa5MzIYVgjAKz22EDV9jqeo1yvrni2G3pgjjRCG6BzT0uFGP3NxMmz2z64wWGcPveL+aj5u910jOaVyX0R5bjZVHEY5LJHJX+Dy0qvc3KbL1O1e0M2yFlCjegKz5uc79uJ4XYhcb7lC2Qu2/8gK1j1IvMWlgbPDaQNgwWxkffHyefd1IHUSbTcJfgwV1cfNrJqoNrEBJkM02UkAZL3k5Bz/t2wCeK/iWbQ9Q6we/VM2AvOcPM6QCIzUY4lDOuXckbHRsJGlVLyH1UKGOaM50s6y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXkRjToGkqKpkSNT6CYzV9MjXS4auEi5QfBqcMgklrw=;
 b=flrFnDJB2fNneGk17fGZAB0C4dVkIXqCero4tQZDUZdG1dPgylp0UqhPaj46GQmD9VjGqOO39ahtS4OAUC7tXcavgPHjiySSse4zronGmHnRiT1lAWWOru74SRRPjCPn7QiYdiYE0uA5nCJm67P5WV4gMkZOkxiNSsuCy6BA4QOu0hmxUZjZG/qZ7ltyqlzEtLqdfD3VAPLCpfn0S4H2Bj6lJl5smzm/tvCRfyZY8U5cZjUt4Wv/29AZypmSdXw4ncLA/frYGcUa7+dSVRNvy3IB+zvaLqEZDHCb1BKXV4+cV+tter/kuzQVNySfHlENH/VZ5OPCYIrnIUN17nftiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by CY5PR11MB6415.namprd11.prod.outlook.com (2603:10b6:930:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 09:24:59 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0071.014; Thu, 11 Jun 2026
 09:24:59 +0000
Date: Thu, 11 Jun 2026 16:44:40 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, Kai Huang
	<kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Vishal
 Annapurve" <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Sagi Shahar <sagis@google.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Subject: Re: [RFC PATCH v5 30/45] x86/virt/tdx: Add API to demote a 2MB
 mapping to 512 4KB mappings
Message-ID: <aip1eO7wvJDxKtBX@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260129011517.3545883-1-seanjc@google.com>
 <20260129011517.3545883-31-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260129011517.3545883-31-seanjc@google.com>
X-ClientProxiedBy: TPYP295CA0004.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::13) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|CY5PR11MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 5befcd43-ca88-4f0e-74dc-08dec79b4f32
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|6133799003|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: jqB/zT/I6Y2IUA3aJ/lAGnjOrZgt1fjL7a8vAQK+Ff8GN36UzCn0TH4TNlY01rXCFZOid2gMT9ZLyFuQzXK4nmVHrWCuZZWKBsCOPo5ES8shPoZj0Y3JZgFHWuGYBYLNsr2JCfCU0KYS6Kw9WGtF2nHybJmGmlCr6oaOEu6KdOzu6z5so2VgCD9MXAdcD8cME2OWL4hS93sWoSqjXYVvhay/ZfUREh43bhvOQshCXZku2XFUAarKB478baOMpIjxqYWVSKNtmYAku3Ag1SGVzlae15qX+oo9EuV5CPrMXvMf+LfBjAjnahQR4zDlxldBrpe9TurCR/Xvk/jdg8IeMvHb/PXfKtp/pi0zORJVp65ik2JqR1zfhtRm3tGmVAN4GIQGi1aU7720ROsCfy6Bl0QN+SUjQM/lrS/jDnYyUegf6Tg8d/DbpSHcJo7Ee594Qw4OukmFRBQigPcPIV/QLWYHDQMx29oImgArR0YxSxuY5mzfjybQsMeB48kMhd4aH/gI11+3ZfgnLKMoWhnrt5DpwYTGBRC67xspf7u6LV4FbVxGj6qy5i9T3W7iPr/QWFyhchvzQuuPTgQLygKi/AknalhVswP8OhninJc8r5Tuhrp3wHsiYcdvRY/D3MtUYgwBdyNVDGKgJAL7LQMglHrtCF92QB/7zBWQnm+nbxl//pxmRBCKlhx3M50r34F9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GgoiIJAjqzVclMAqATTVx9ierl40T74x7JkhYwJe0Nt2bmW7OFj0ykMwH3zn?=
 =?us-ascii?Q?Ka2bCeoCPou9GlbfKKWKvNnpK+rbYFHSBt+r8wDDt1B0APM5KZMWEdMLpapg?=
 =?us-ascii?Q?DprmjJeJdDGCvNuWD9zzXxyIumC9mFJy9SxJ+yhSwqqJCwubd5lNH1ARgTkc?=
 =?us-ascii?Q?ZnDxmhjsl6T+zrOJoYF1IJ9cbx807twdSLDi3xSUhS/sUWaS1SPGmZyQiTE6?=
 =?us-ascii?Q?Rxq212sjqGgvdt1J07De5/veBeMV8CyqGy48aVMXngBoEFJOog8VEQx8IuLw?=
 =?us-ascii?Q?AFIrXjuXW2/X6dqIcwVYJFuqCnZlv/9Dc/34qSHm62xhbQFKHLfmbJdUQMm3?=
 =?us-ascii?Q?iBrFpcmv3FBGikF9R56qFFg6UN9Dmrz6W+VQjkWgohtE0WQgVGgR+1pd8hIe?=
 =?us-ascii?Q?W8DvpQPOHyw4psKUldByFuqvblYCL4/QBpK542Gs5p9cjn7CkkbxcfgHZF/j?=
 =?us-ascii?Q?mCkHvi9kPoSH0bgv6NBxB3P31a0qizR+dXIXVzD2eEsVSWqM1B/ZzNPFCZfh?=
 =?us-ascii?Q?Cjphf1eurqHam7xNX11uYWiVXf9Rh8fX57UMayDinT/ZM03COJoeiNzqD6L6?=
 =?us-ascii?Q?DrOS8wL4jhu0KfWxg6CV2C7WWJB/AofJoRZloWTtNKUgp0qvoB5A4LUG2LPh?=
 =?us-ascii?Q?nOzOpMvLk0BWFjQGLdQzMjpKj+mHzThYBYVfIThO/QIxYY81AK/dOUlysnM1?=
 =?us-ascii?Q?SRev/QK/OrECu2XS7ucrlyLyuJnHYpBfKZRPyUHg1O8zp4IqazjRjwTFexjf?=
 =?us-ascii?Q?KubwUgBrcAwiQk3ARB9y8wPA3CfNp/1v8tCaBmNcGREJ6c0/tnV7t9iPrlOc?=
 =?us-ascii?Q?QvQXbRLCr0NTGP+kexjumlzOwTSFe/b475NHXCfuz+xYKyON3wrx3vYXicNt?=
 =?us-ascii?Q?nA2A78iGb4Xs6HYBiSAcVkHrgYzLKp9dgeF5Qj55+jU5HNuIfoJV8g6MHxq+?=
 =?us-ascii?Q?U9Hjj4Pwv68Y7xQPXJq3MU7gre02wpwDB4t34kB8GvLra4mAWR9WmylmDTGt?=
 =?us-ascii?Q?RNLBUMvlG/wUv0CxuuCTJa3LL8gb4BmwdNwNSM3cBDMmlxyPOOI81MuzS9p8?=
 =?us-ascii?Q?PXgmTSChcHKQ3DG476mnwYG/gVnNacpeNbDCoNnYV8yki64L+lUtZm5xdGp0?=
 =?us-ascii?Q?rsnOD7kFgadwA4gNYFl1JggL2IOLMww3iN9lnYJ6v1kHB/ndyku9pgG32DMN?=
 =?us-ascii?Q?cdo8n8UpK9X2fyya4owEOT6s40pt9xgMs7mDxITTUISvUESDn+LZMqE2WRLM?=
 =?us-ascii?Q?hXuXtGZInr7VR379RBjHenQ1DkOXnAWSNv2RzFkxXO+06SSPyg42mCLpvilT?=
 =?us-ascii?Q?eim2t4KMamf4pASBBqayZ4qUbN1YGfJjraq/1MZal/Ogix8ISG8FpCKneuHZ?=
 =?us-ascii?Q?gYRHBujt+LdGDArKCGbCPCLFHgNNAmCzO/UoFw4UBncMABInl7fy3Hu+NzPm?=
 =?us-ascii?Q?Ur8R/lvj0B3z5NexZ4daTzWxyLSVAsF8Fm/juwKCGLiVrsjD1SEfF451aqe7?=
 =?us-ascii?Q?EOvq8cKw5IY/n1Y4Hg62uAaLJ1b92HZ4ObItJ7Bo6c60hrIMpdQxVyLYfDvo?=
 =?us-ascii?Q?Pf7qTeSyiXDEL5Or1m8Q0BxlCLNYy9Xxh3RQjK7z62o1gryCwVuIFoR3zUGS?=
 =?us-ascii?Q?3I4w+a5CoX+4Q6o7NzbuHAvy/oTFAR6aI6fLJN1/LpnRtgkRUKj7WxhASmwD?=
 =?us-ascii?Q?RqEGRNtNg5E6D3/5MJKxibCxibo+UVSDIlHHjgKXiDAaeiN9lWdmbF8HRMom?=
 =?us-ascii?Q?mO53xHEcsw=3D=3D?=
X-Exchange-RoutingPolicyChecked: AthROWu8baj42OJ47CECccdtNnnQiuXlfMPZTf9AapcpIZKVM/roYsoEAT7FnDUiNvE0TievPKYrKMj133Ll4wJaAx7IKjZX3mV6RTxq82s8ZQMrlvij0q1WbceGkyvsOxcuncKOoH9MUwTZAz3OgsUhcNv5W5Iw51xdjpnTzRsxlHC450hH1Rqv2qG8MisiXS2ecDik8a10lR+ELa9wxf+bxSPgcRFm0++ILBoTZ56AUXfvkIW9jkRrlgq37cl4AFAYh5WS0MfthIQmI+YFywrKVeHiWV6o+ZdeIG7Nyf02vPB1dqrFyICkZ+TeyofkR7rmjRyXXph616pBChe8Ug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5befcd43-ca88-4f0e-74dc-08dec79b4f32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:24:59.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gi5hjdnxEh7IK5DZCLiPYn7WAZh1VcuUP0pmcSCy9JCXByCuk5794B4W8x6vZl2VNuFddcI4iIyGcbHl+cQZPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6415
X-OriginatorOrg: intel.com

> +u64 tdh_mem_page_demote(struct tdx_td *td, u64 gpa, enum pg_level level, u64 pfn,
> +			struct page *new_sp, struct tdx_pamt_cache *pamt_cache,
> +			u64 *ext_err1, u64 *ext_err2)
> +{
> +	bool dpamt = tdx_supports_dynamic_pamt(&tdx_sysinfo) && level == PG_LEVEL_2M;
> +	u64 pamt_pa_array[MAX_NR_DPAMT_ARGS];
> +	struct tdx_module_args args = {
> +		.rcx = gpa | pg_level_to_tdx_sept_level(level),
> +		.rdx = tdx_tdr_pa(td),
> +		.r8 = page_to_phys(new_sp),
> +	};
> +	u64 ret;
> +
> +	if (!tdx_supports_demote_nointerrupt(&tdx_sysinfo))
> +		return TDX_SW_ERROR;
> +
> +	if (dpamt) {
> +		if (alloc_pamt_array(pamt_pa_array, pamt_cache))
> +			return TDX_SW_ERROR;
> +
> +		dpamt_copy_to_regs(&args, r12, pamt_pa_array);
> +	}
> +
> +	/* Flush the new S-EPT page to be added */
> +	tdx_clflush_page(new_sp);
> +
> +	ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);
Note for the next posting:

When DPAMT is enabled, part of the DEMOTE SEAMCALL performs the same function as
PAMT.ADD for the guest page, with the DPAMT page pair specified at args.r12 and
args.r13. So, DEMOTE has the same contention issue as PAMT.ADD [1].
Consider the following scenario:

      CPU 0                                     CPU 1

(1) DEMOTE adds pfn A1=0x1b090c,         (2) PAMT.ADD adds pfn YY, pfn ZZ as
pfn B1=0x119b4f as DPAMT pages            DPAMT pages for pfn A2=0x1b090d.
for guest page XX=0x511a00

(1) CPU0 needs to acquire a shared lock on page A1's 2MB PAMT entry.
    Since A1 and B1 are added as DPAMT pages, they don't necessarily have DPAMT
    pages installed for their own 2MB ranges.
(2) Assume there're no DPAMT pages installed for A1's 2MB range.
    CPU1 installs DPAMT pages YY, ZZ for page A2, acquiring an exclusive lock
    on page A2's 2MB PAMT entry.

Because pages A1 and A2 reside within the same 2MB range, either DEMOTE or
PAMT.ADD will return TDX_OPERAND_BUSY [2].

Though KVM holds write mmu_lock before invoking DEMOTE, which prevents
concurrent PAMT.ADD within one TD, the above BUSY error could occur if a second
TD invokes PAMT.ADD while the first TD is invoking DEMOTE.

So, fix this issue by acquiring the global pamt_lock around DEMOTE. See the new
implementation [3].

Since this contention should occur rarely (e.g., when there's a second TD
invoking PAMT.ADD concurrently while the first TD is invoking DEMOTE, and the
DPAMT page pair to add for DEMOTE must reside in the 2MB target range as
PAMT.ADD),  a possible optimization is to avoid holding the global pamt_lock in
the first invocation of tdh_mem_page_demote() (e.g., by indicating try or fast
mode); only acquire the global pamt_lock if the first try returns busy, ensuring
the second invocation must succeed.

[1] https://lore.kernel.org/kvm/aNX6V6OSIwly1hu4@yzhao56-desk.sh.intel.com
[2] The contention is verified with an internal POC.
    Error logs:
    a.1) DEMOTE adds PAMT pages pfn1=0x19c0a0, pfn2=0x1b572f for guest pfn=0x519800
      2) __tdx_pamt_get() adds PAMT pages for pfn=0x19c0a1.
      3) DEMOTE returns error 0x800002000000000c.
    b.1) DEMOTE adds PAMT pages pfn1=0x1b090c, pfn2=0x119b4f for guest pfn=0x511a00
      2) __tdx_pamt_get() adds PAMT pages for pfn=0x1b090d
      3) PAMT.ADD returns error 0x8000020000000001.

[3] New implementation:
u64 tdh_mem_page_demote(struct tdx_td *td, u64 gpa, enum pg_level level, u64 pfn,
                        struct page *new_sp, struct tdx_pamt_cache *pamt_cache,  
                        u64 *ext_err1, u64 *ext_err2)                            
{                                                                                
        bool dpamt = tdx_supports_dynamic_pamt(&tdx_sysinfo) && level == PG_LEVEL_2M;
        struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];                       
        struct tdx_module_args args = {                                          
                .rcx = gpa | pg_level_to_tdx_sept_level(level),                  
                .rdx = tdx_tdr_pa(td),                                           
                .r8 = page_to_phys(new_sp),                                      
        };                                                                       
        atomic_t *pamt_refcount;                                                 
        u64 ret;                                                                 
                                                                                 
        if (!tdx_supports_demote_nointerrupt(&tdx_sysinfo))                      
                return TDX_SW_ERROR;                                             
                                                                                 
        /* Flush the new S-EPT page to be added */                               
        tdx_clflush_page(new_sp);                                                
                                                                                 
        if (dpamt) {                                                             
                if (alloc_pamt_array(pamt_pages, pamt_cache))                    
                        return TDX_SW_ERROR;                                     
                                                                                 
                args.r12 = page_to_phys(pamt_pages[0]);                          
                args.r13 = page_to_phys(pamt_pages[1]);                          
                                                                                 
                /*                                                               
                 * Before demotion, the 2MB guest memory range is not managed    
                 * by DPAMT, so its pamt_refcount should be 0.                   
                 * Set it to 512 after demotion succeeds, since removing of each 
                 * 4KB mapping will reduce the refcount by 1.                    
                 */                                                              
                pamt_refcount = tdx_find_pamt_refcount(pfn);                     
                                                                                 
                spin_lock(&pamt_lock);                                           
        } 
	ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);

        if (dpamt) {
                if (!ret)
                        WARN_ON_ONCE(atomic_cmpxchg_release(pamt_refcount, 0, PTRS_PER_PMD));

                spin_unlock(&pamt_lock);

                if (ret)
                        free_pamt_array(pamt_pages);
        }

        *ext_err1 = args.rcx;
        *ext_err2 = args.rdx;

        return ret;
}

