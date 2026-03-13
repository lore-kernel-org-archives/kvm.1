Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FFE36495D;
	Fri, 13 Mar 2026 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388976; cv=fail; b=ExGZf74Ja2UsaDHdO/Kcrtyw8sKYYujg+WcehV/ecbYk7ev9+BkcJlgLVpke4PNnNni42QDPUFw158CO6GnysVFNep0fhvMxz6OjTQXP49sLicwJ0n3k5I6gU/p4Ko/Sih+iIR0eSM7Ykllv4o7JzFHMhPpl33Ky9HrSV9Oi3s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388976; c=relaxed/simple;
	bh=6Pipxjldv8dQqb3O2EY+AvzkTgzDe/nWEkO/WatJ2PA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pGhxFKiM+BAR5FKnpduXhHtlQYmEBy0EAZ/WmmS1bNmaZ/CbMErc7we5PXBY7TfWHDz2tnqJb0Pgb9v3A9Qq2n9NCgX6xYid35q7jbmjwWcatqZbMRFRmtUHCyAxv5OPVC/XJlFS/zIjcbb3h5GBIljAlOKEMa1i+IyWWRE1wx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAk3q3S8; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAk3q3S8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773388974; x=1804924974;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6Pipxjldv8dQqb3O2EY+AvzkTgzDe/nWEkO/WatJ2PA=;
  b=CAk3q3S8IkXgG0Qka/hrmT1veymxxN5RZN0Z5DnIyuiG3uXvGozdobXs
   +fwsfJfHTzb3W1cVlSAAwv0sNtbIM5bCbZmGCUyVV1GZDl5X+INyjbljm
   4tOtO1h4Uhm7NgcMKrh8F3orD0GgPxtyJxonu1XM15fBZ75PMV9ugMaqg
   39u41dbHCU1wmPPqb5Ro30NCAwiPTV7rO2WVhzegDzkA8elxTHtG3cbZg
   cYDZARJx9cRSbHKV1PoGDtkh9wnkP4ru043GvQhQMtvpXjYeQaGSMUqdg
   SdO2hGWOyQrof/zdY+H1zAw1+XE3u+CJygUt8GC0PzjAh+R4Fa1T11P+2
   Q==;
X-CSE-ConnectionGUID: oGl2zmKbTxS3iRSUi/H6Ow==
X-CSE-MsgGUID: Pvzo00k0SsKPAhl1i79V3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78344849"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="78344849"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:02:54 -0700
X-CSE-ConnectionGUID: PTflmGEqSGCjwMOVUr1Bwg==
X-CSE-MsgGUID: 6KVPfA8ZRm+3xmLwIiw5+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="244119435"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:02:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 01:02:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 01:02:52 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 01:02:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fH+ErhaxEc+eC96f9Cs9EABCXJPU/cplDxN9ie/7OzvHo8FWxF3/P1PaD3JTKU24HfYoVia/2obu1AICG5DRgIFWlAkPp4lFgkUIftUNacI83aXUAgNQwbLPwI1s1YzLBh+pEKy9qfQj3yatwHEOz3DXR4Xq4LQkx1W66HQg7x0jDbFvp/P+h+WSYVO0b4Xobrj+41nAuQgsJlzgL1pio8zUYXALr1kC9WH4X6V0M2WyDMM6h+K3nU8KvPV4JJz2goZUrwJyv3EN56WS4HGFJEtPH3qd3BTEww5rRuxNCULWrOGOvwqbisOQYv2LJgmCKaC3zBv/MgZ+Q2DIrskiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXqJqarLUq5kUz8yKkY0Vp9ie9AXVdivynPXJAu3dKQ=;
 b=Krmu1psBIVIG+CUdUz4aB7G+IPcgHhdYmX/9JjFpgZLniWt5XMOgGBjvsozok2U1Yj46E0W6cAruH8Mw8AbfPN3J9ByF/8fNJoxr8rZ4WLzSvQCZ/nGbrZnJj48b8DLYnb7Sg+DadFH9fHRxXnB3YIybWZM+/nacZFE/q9ickZ1nqGfIFx7Z+n9fVxRuEdzqw+fNAVOEkGUC0O0Tv3xEC1kARj0gHeW9aUtH7Eun0ffEiRH8oXzzYUuV0VVAPQ2117G8L9JI3oHByiF/zuc1ibQMp5h5KxcUkwgx0CZzsZhbYKHIt6TSK3EJt4/QpBaAnimVQhAAxz+giS4ZlcMQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SA3PR11MB8073.namprd11.prod.outlook.com (2603:10b6:806:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 08:02:31 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 08:02:31 +0000
Date: Fri, 13 Mar 2026 16:02:18 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <reinette.chatre@intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <dan.j.williams@intel.com>,
	<yilun.xu@linux.intel.com>, <sagis@google.com>, <vannapurve@google.com>,
	<paulmck@kernel.org>, <nik.borisov@suse.com>, <zhenzhong.duan@intel.com>,
	<seanjc@google.com>, <rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<dave.hansen@linux.intel.com>, <vishal.l.verma@intel.com>,
	<binbin.wu@linux.intel.com>, <tony.lindgren@linux.intel.com>, Farrah Chen
	<farrah.chen@intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin"
	<hpa@zytor.com>
Subject: Re: [PATCH v4 04/24] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
Message-ID: <abPEit+Ckeqmypv+@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-5-chao.gao@intel.com>
 <85e42dab-865b-425c-bd31-fba7ff5d3443@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <85e42dab-865b-425c-bd31-fba7ff5d3443@intel.com>
X-ClientProxiedBy: TP0P295CA0006.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::6)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SA3PR11MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 0248e8ff-c588-4200-7a77-08de80d6e050
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: tdaGgsX7gfERshoUrF3toRhwmFqvudMY9yS8ESOLtNLOlWTi29HiTEeMaPK0mdU1Tddj3puKLex9z2ACyC3zvYAEGjag+BvVrkuLV7nSjzD+lmKmvrtzSCQ9QaaNZUiRtuPXBXSr/A4m+ZLrxpFb7gSosprI3KoueMqZllLNA+hT8XoSFtxfCGn1uwAwOlbrQl/4jmP0J17o/bxkus9KgOJZzof7xTlOCicqQHBWhpmVAS+eSXIVAfV8zPPU3qK0ERQZiKU3/86B2Q6/4g1ML/x8Yt0NNHVzC6zO0niEo2oIOcYvoWTVqUcfEnU1kyyoHiMyRQp6/5VFPuVbj4UjBwED0p0AjHwz3xeXgIM74Og3QhWQ30pHHvLmcsv/ZxLekUq3Nnixbu2NG0ta6OD5b6CzB8K8BnWbulimMCYLpnUHf456+pfGFzFwNkyYCifggZtXC2FWQSnpKQhRW0hOPyGaeH7E+LlHKaxwXUJakbJnoYPYzc3zXBMn3YU1VeZDQuQtWcRiKX2Bi8H9mTdxwTp8tZ3PBMblzMRlo2pxAV1F3wr2TbuAvT3z3B/dZurb6o8LQFKhZfnAxgwjF6Ig1gEj+cGnBWBMGhw2i4GP2qdAS7h+AZjaxTGO3Fw2sRBErVfw/ECo28/yzI0yow9rBV8ITlRogJBJ2oQyso6p44PL6KlWXxJ9yiWvX4IUKb4+Btiy2sXDmvot9aKybvC3EXSGDUlA0DBcwB5rD0Af/So=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cj28cSMjjWI3HJrilLTNNoDkI3QV1EIIlEPVbt27NehaRBtT/fcK1rfkP2ix?=
 =?us-ascii?Q?vDE3v965JLHWy1H1N+1a+rEoWHqjaRbU+tYC+lKOKdSaAe0zI6+6yQZ9Jw3P?=
 =?us-ascii?Q?tLaRd9rWqjxb0+muvHY32tYS8zaygvh5OJBNNK8NvoT6GgDtwgSi3IuDgNU1?=
 =?us-ascii?Q?4tzIAigr8KJLLZKjIRtVJmvkAVev86uyG2vx9hOvHTE2PfZ9EQNsKXJwNuLE?=
 =?us-ascii?Q?tbhhY6aklxycVl+XBEGuSY2ppdqsEzjiXt7nfVUzH+iQex3VoaukGM8aU8tb?=
 =?us-ascii?Q?X92uumTyExcmznMr3LRt/olEVXcgrwQj8fwMMAKQnOClIsMa86zgXOsyd/dp?=
 =?us-ascii?Q?F/8iF8c3jkB2Tn7CI02JTZFKb8ZS1p31F0u+dVb/oz4PUfHRtv9+AgUzS0Ej?=
 =?us-ascii?Q?WmTLoVA4RkqP6NvC4kgW6Bt+fTtuCvjWN89StPIakSWqdiPcToqqICctB9Cc?=
 =?us-ascii?Q?ixZTzhtfMF51OotsS81KBPyy4v8Zi/y/VFyattxct1Dq+byRJKYHwivAL8Vc?=
 =?us-ascii?Q?bxsNFSPcUQz+eKVJFByvRK1OUYVFpXsghEfBV53d6sGsXQLLn/0Z53tEAAYK?=
 =?us-ascii?Q?gPRJIjfOBNCEg3mU98t1lFZ6UXWqGDgqWygisSyupBH2tmgrVnyalq7JRNmF?=
 =?us-ascii?Q?VPwSIteT5H4wW0EosiG/CkFvZYXBV6HBKs7s2iOb81PmHCQ5L+tfvP0BDnCa?=
 =?us-ascii?Q?pEzWn8EqkAHw3GSkc7wqdybpG25ljfahShIFqwwwJcqkRGstiJ02QEg8/DMm?=
 =?us-ascii?Q?bVFWga1ig3Gr3oKrPaPxoXZkAORzhZSU3yhBqVM0FOE2N9MhxRxsPr/zw1cz?=
 =?us-ascii?Q?C8qu/9yrCFYD7wGwvZBMzp1PfV4rqIw4ML7cY4QpOyzEfFTJGG7ig8zAf5hB?=
 =?us-ascii?Q?tIb0q7UaYOLvuZq2nz66QABQKazURF1QqpMJVB3Gis3MKHYcq4+pzJg83Ik0?=
 =?us-ascii?Q?BTRuQDoxQx/XrCR9uxpjIKKIlv8iLRCgS5MTxOToAH1L+GlUvOuna16aPZZp?=
 =?us-ascii?Q?oBs9d+TJCDCMBWl5Z1UfxWIuSLjOyUlQTS1RxRg3DX6gJE8TtQFSrEJhE4w7?=
 =?us-ascii?Q?i7FZXcB1PtQMqTuLmFV5bp3UJLp5K8AFCLCge+FSDE1JMqvmQBqgT0+6p677?=
 =?us-ascii?Q?8teVWcWl2zmKm2z5p304BgWvbeos1X8cC8oaWq4/MaY2TMiIbbglD/Y5rLO3?=
 =?us-ascii?Q?BpzOIwLE0mkIU+dnoDYpWtU2ntVsWyho2dF2dmiciOo+QY+UdVlPq3sPrOw4?=
 =?us-ascii?Q?ekPl1bwLEIylZXtiIZplGmghl7zjLXV2Pc1ykHh6ktMhaWBpLOr45uDfbbUD?=
 =?us-ascii?Q?2VTSeFXdNXPyM9apiz8fbLpVGuhai0FeCrGLewri3RSQleAyXJvExgGXSimd?=
 =?us-ascii?Q?KSy/I791SWruJjTJZIiJ26m2J+362iXWLIMtAWu+r/BJPDHZSyFs6h1K+C3x?=
 =?us-ascii?Q?8B+W7lnwkLNwEg627TElXN8ztc5GaN4/orzTvJYuKF0Q83mGgsS0u8TjGVRs?=
 =?us-ascii?Q?gcPkqqaOTCaWoWN9lF4IuQs5V3NEqZ32h9awlwA9QnVznud9L6Rf8a+gfE8p?=
 =?us-ascii?Q?pUOJdGl5PwStrmfQmLk4Etr4Hy6YzwrdH443py1ppKiAEQcbZz2w5Cc8nox2?=
 =?us-ascii?Q?Y58L1WgUfLlzY6Cc34yNV9ouYq2vkahvS/QVcYjP1Aml6TJogW7YI69dIGvs?=
 =?us-ascii?Q?290HVG1VHtX9l9ILtQYysh5E5DXRERb/tYEPoDXsw+zFoeSo6o7SDsnK9nFa?=
 =?us-ascii?Q?maWs0sxEWQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: oL41uPIC7X1WdYCPfv4cPh9y8YnExhz5gBoH6Sl6f2ioLrXfTOpVGcdWpAhynL0ckWTsxSUZufRBgLMU1kqv8XNtfBCzaTsDy/NTKd5Egpz6kxTqC7ByShknTtPevIi/ST3dIrig0tUgvL53x0sdTWc6zu10DcGwfQYgJxwCW4BGjEc++2gwPsH7LHpZB/qfiHt/3Gr9bWqrlC1ebQBUUoFRTjJ0o4Un9Bilvb+p6KYC0ZQP5IP2SjzhgyYRYLbd4GZhBD9UCsIVugioKhUnuvsiswa7P5gmO2PrK9a+Ss+MfGwhW02ZqDnIv7/zNE/mCgGgoa3O0tvbn259eb2m3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0248e8ff-c588-4200-7a77-08de80d6e050
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:02:30.9847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkDoSr8ql+vtz3S95MztIoMQYDV8BV9/tnTxYXa7i/PyTOkQlpFCN4eVIlBpR0wzLPwVIPYQJU568S7yNY/u3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8073
X-OriginatorOrg: intel.com

On Thu, Mar 12, 2026 at 01:14:33PM -0700, Dave Hansen wrote:
>On 2/12/26 06:35, Chao Gao wrote:
>> +static __maybe_unused int seamldr_call(u64 fn, struct tdx_module_args *args)
>> +{
>> +	/*
>> +	 * Serialize P-SEAMLDR calls and disable interrupts as the calls
>> +	 * can be made from IRQ context.
>> +	 */
>> +	guard(raw_spinlock_irqsave)(&seamldr_lock);
>> +	return seamcall_prerr(fn, args);
>> +}
>
>What SEAMLDR calls are getting made from IRQ context?

No, I confused IRQ context with interrupt-disabled context.

SEAMLDR calls happen in two scenarios:

1. Userspace reads num_remaining_updates/seamldr version (interrupts enabled)
2. stop_machine() calls SEAMLDR to install updates (interrupts disabled)

Both run in process context, just with different interrupt states.
(I mistakenly thought case 2 was IRQ context)

>
>Why does this need to be raw_?

In RT kernel, a plain spinlock becomes sleeping lock. it cannot be called when
interrupt disabled (in case 2). I verified this by changing the lock to a plain
spinlock, I got this splat regardless of _irqsave version is used or not:

  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1772, name: migration/192
  preempt_count: 1, expected: 0
  RCU nest depth: 0, expected: 0
  1 lock held by migration/192/1772:
   #0: ffffffff834747e0 (seamldr_lock){+.+.}-{3:3}, at: seamldr_call+0x3a/0x1c0
  irq event stamp: 1070
  hardirqs last  enabled at (1069): [<ffffffff828ea7e8>] _raw_spin_unlock_irq+0x28/0x60
  hardirqs last disabled at (1070): [<ffffffff814a1ae0>] multi_cpu_stop+0xc0/0x140
  softirqs last  enabled at (0): [<ffffffff81313dcf>] copy_process+0xaaf/0x22a0
  softirqs last disabled at (0): [<0000000000000000>] 0x0
  Preemption disabled at:
  [<ffffffff814a1397>] cpu_stopper_thread+0x97/0x140

So, I will use:

	guard(raw_spinlock)(&seamldr_lock);
