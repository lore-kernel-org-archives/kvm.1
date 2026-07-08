Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC24028D8;
	Wed,  8 Jul 2026 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499753; cv=fail; b=qoTiNPGZACrX/9+ttdi+U2b2u8xUdjSZsr8HzlLYFP4QSMyy6Ee1xX2BaMu9Ch0L/4HisatXRUeYcPaY9RtZ1miLZ3UTeil7YmsYpIY00e6dX2zWSMAGrFkL0KapHO1g5V491Vne5dqRudPxnoUHWUpymu3AB9o03QjJnZ/1Cu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499753; c=relaxed/simple;
	bh=PiREt+2ESdGoNg6vz0uQMfcTYrhtQCI6ZFzxHRt5xpc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gaSw/jhA7h6jyK3+h3txpg6gFFgOibzNa21MBJQIhd5sQpP6GwYhpJ2o+JQop/HXLSpcc3VPi9Tl7VmfeOHiRXTTHDvjI4I+0e26BitrkZIGgv2TRsKAQLCDxz6tgJFTxG+P/mA4LIjYZQ28tqjSj79KP1fsDZNuMtlMSm3M9UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MukvqoGB; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MukvqoGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783499751; x=1815035751;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PiREt+2ESdGoNg6vz0uQMfcTYrhtQCI6ZFzxHRt5xpc=;
  b=MukvqoGB13C6EapDwPkdBmX2Gr1fe8pf6/NLuBCHIEHfQuvsFUUWl/sO
   ik+XK8heTPVhphFDNrG7Y6aynUGYV81sLMoLw2hAsYi3+ugxzQjiKQiRe
   5D/ldgAI9ZZAESDKogSMT0cS6wqxwtXxJ/fjvXQ1fTP+Eelp3TZFaH9Py
   g7xxAguqdYW5Y2ZcEsk7MrSPORl9d16MN3fX1DaDUpylJjrDiy3VPGShg
   CKdfEzCAQQp2nodJllNJ38nzOzZJRSmPwHHx1ah5Q2HFiBl7MP6qBIY7O
   PJQoX9888tDZysBX4P9Qh1Qc7EagWvWAejYkf8KxiR2Pa5euMpRfVcvey
   A==;
X-CSE-ConnectionGUID: egkmOFFZQbSY7A1cH/ldAA==
X-CSE-MsgGUID: XOY5kSdfQgCW9B+IBXIFYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84275495"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84275495"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 01:35:51 -0700
X-CSE-ConnectionGUID: 2yiIAGw/QqGkjpLer0t/OA==
X-CSE-MsgGUID: 0946r057TH6lLAqJQoXp3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254870306"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 01:35:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 01:35:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 01:35:50 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 01:35:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7zb51A/QVix9uM1rhL4fazm+QszH/xetXvQVPuYVL/cjTrf4gxU59/y8c3zC6cftMVS8Zv+uUKe8XY9/CkrStO8LAo3a9LTy9V123ABVKM+eN0B6qez1tqutdTvo9ZuJfgu1rY6vHNCeXbsmCI5p2xvTRiRgwbzTgWUm08F9OSXjpbs1rorif2MIUJMtW5Eth8l4Zm/adS4J6mPg1IXiri4F9qnQ4fvTh5GxdEhu4579GpBz0QEmqRDSCA522ijMyjgKNq7ygSEiIdsS7my4k4bv61Tzzg28R2lV4uljlODTjkBnWCfFX76oosmG5cGrqVvR+f/o1TCQRaDrPJcOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZznFCGJt89tU+fPu1+FDCV9hx4JW2d3rOG2XeT31gYY=;
 b=R3U3gVw3G4jKuAUCv3IKvaKkbm9oAKfPGdvxw4R6aQf2XvP/n+G6wY81s6i7wNqVLg4lvTJTXOotrbe8PqRCD6q9ODO//2hdtmx0a9wlMS9uW2piCu/RsaHFb3s8UTG5v2itC1FzZqR39sEkGVgubn0RnfqSLOE4fa+J/ixInG21I0mka9TLQ9OpQ+j/QG0lUQb5qb+K9Yqm4oUsHKnj8Scj6YtsWZJhV5KqssVUrBfrZqxtMieNnbxCyQBD1gNoggrcPxJQ8iDa1Rgcz2+junofLAv54thSdCnz1szLVciBatpcItc8hlv7XQMsnDYGh7LRTqXSkD7mXOZQi9uoSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by MW4PR11MB6786.namprd11.prod.outlook.com (2603:10b6:303:20b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 08:35:47 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 08:35:47 +0000
Date: Wed, 8 Jul 2026 16:35:11 +0800
From: Chao Gao <chao.gao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <yan.y.zhao@intel.com>, <kai.huang@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 09/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Message-ID: <ak4Lv+CQIG1P3k/f@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-10-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-10-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|MW4PR11MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 871dd234-2dc6-4230-281c-08dedccbe85d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gQMhqoZ6C9Lzju0VZScjxjDdgYITXELYNmD9jtPCcPjuyylz155J3Kf/d5PBK0/Kdy+eqz7j5zA6rZ6VlB9UKzHwGDJUTR7cmEdVT2kCDm1lRoQKe33+j17SOGTO100YThrI2PkXajuXDUJOwDtrvOH5uyemvESBALzLikd5h5HggbDkSWfxnPbcuoMPR547EhI7UpKb3uVQBusd1U8IWL0+CQM4a2uvq6adfS3CJebc5fxburGG4EdSFKhEU+WxG27BH65HRMNqgxnYoR5kyROKcBN1RwQMlFcitFTtWGRftu5Be1OyEmSz7zQlmpJ5wOmvLtlMlxVvAwzGnzZfXWSJQoY+OHOLWO3e0ZNfWy89PkcNH912xKpF9mJF3nCSGVvXJnuFh7rkXCVFfBtbh3MH3khePdUYt914d6yeaXddei3sUtxaOnLD7ir6zlcHlGiEbh31g7cEgh4RBT45xVWMwcKxzVdzNfKyTAeACApSNBO5sIccvAQNIqLcECSuqMJF22zGBhWUn4igRnAFZhYyktYq8ca5Wv42itQd0icBQqkqwIy2Sj39ff+X+Jhff9NV0cILl+1t7XI+q6GohuO/OkzmdnugDhEQL8ZKBR6BFu2e/e8ysxm52y3NbsltblZ/gf7373YkUycx7H1sRl5TyrL1dH+khO58txWB59w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?61mdzYtRqOZPmTgOQ+n/INz0pxURO9OI2oGb9G3D0Faqk8rwSGOXqbIWc50V?=
 =?us-ascii?Q?PsCEx0F+rLD4KOUOeLBkprcPGnwVhznKISxoZ05mAu8xXfGuAauD1CVqkVf1?=
 =?us-ascii?Q?7kzzajq62QVNYJKYrPuFqti7xJ3fcZ9m25/WQgoNQpL15XmktfZuh4El+08Z?=
 =?us-ascii?Q?C30IyAZskGPTqfAtI3OTOX6V1zct9XmGTiK+9zJLF1NARcvAKA8twgQRpRv7?=
 =?us-ascii?Q?WT7CPf82I5CyInjWZtqKOxUhTNg0OgMaYVACquAFcTrY+AkSy3tOw4RI68ar?=
 =?us-ascii?Q?agrdsrukFLYkWRW2Aj4st0rRtiL7SxHQPxN8JWTubGWOj7z5dsty4ucfpQaN?=
 =?us-ascii?Q?iXqEoG22bDexmVkb4wzTQSB3VUwJ7STZIeWwrtchD/2kqjm+Cf8YGkwvblj3?=
 =?us-ascii?Q?RIMVLPFLVrIns+qU/TDU7hnpuLQXz0GAI2PETaZ0CsYud9LbKKQS7gAxd3Rc?=
 =?us-ascii?Q?uHAMYKKXhW6pyyIClq1Hvs/nI5Hvq2Qu8k4TsXd3Jd27A/mt2hCtMzEJZi3+?=
 =?us-ascii?Q?GV9uFik6U9o2D8p28Z3+Nu5ladhjW0ESibaP26Yl5YtEz7NQ7FoOXnKtcs+S?=
 =?us-ascii?Q?fiG91AefOlAhdmDa432ixpuZpJ1mbKD1sgaOB88Qiu8mPkAY0mBhXLeC2QgQ?=
 =?us-ascii?Q?oxy8XhGMhsyKGZDDwuGh/qN29G+R810F2jZpuD+BNoLNrcVoSEFNsRMY1Nt4?=
 =?us-ascii?Q?XCg6zXZXdAn1u4XmA8bMacBK6p6SPQ41S70qU8j62UkOSL1yaE0QyEXWAekJ?=
 =?us-ascii?Q?TPzMAx7EdSeQAWVJ94w9VAEsIxxP7YpKYEy5caCQm76zEn0yyhsLPPWNrw9s?=
 =?us-ascii?Q?22gT78d7AeZ52YLhBzFnlNVa0XNJi2DM18PlQNQfGWqWFR5PM5QX0hRWUA6F?=
 =?us-ascii?Q?z1B9HzYLLBjSGaYACV9wK7ThCZUmdR0G6NN8dnkISbaOImjdCQTRfrWhYzY8?=
 =?us-ascii?Q?ptmTUyWTnNBgsgoobKLifQXHGx1TPVG1ebnZeS5vWEJhMl/FAR4b0ujBr5ST?=
 =?us-ascii?Q?vrEGPvkykibXgutQABJMJMBYgumNcb6ChMcoQk0hb0e5+Q4LtY8GoqjYAaaw?=
 =?us-ascii?Q?tAg+wpxaRYoEstWvWx08aeNjE29HYWWggc0SkW5tkwkicc3+1/KqNmaB0IU8?=
 =?us-ascii?Q?QRHVao+RCdgJ5iI/elRY1tNOu4pswEiQLk4i528RiKMC/GYI7Wq/m28H1s3P?=
 =?us-ascii?Q?5u3LR31CPXElYhdQ9Gz0i3TVS8fXFP0eRrV9Myj1f3kFP+s6ObQd+EiucoSu?=
 =?us-ascii?Q?y1hsvAL+lygyIpWGbjN5tQ7cXMZytjHm3GmrvtTtFZ2wLWlbrfZ7QAD5lZlG?=
 =?us-ascii?Q?sRNJ1P4rmo23njiu/GZmIM+ExiVJkZMjAMPxVfoOP7cpWxbMX1DFOtmX8LdV?=
 =?us-ascii?Q?b1xeEBGn4wAsm4dd63u6/jcU978Zmv/s1ZLdfKzYoL1rML5MXbz3WiMvDRae?=
 =?us-ascii?Q?JT2piAqz8zgGPR62wG3AgAjOvL53ElHZEnR0lFCdZvgFqerF50naZ3a/q2kG?=
 =?us-ascii?Q?Fg6dBmdHvCj013eNlmI4PTBtQNUgHnkdv6yy9MSgKbXTAykgf4C+LhVMmoTY?=
 =?us-ascii?Q?QSwy+Q6pX+TDoYUAo5gnysy8IDSfPzeQzxSLjhOWuLQVmkmjj1uH7aXPoCnu?=
 =?us-ascii?Q?bGfZaz+VzFDPkEUty8iDiJ0r3swX1ib4U3/NM4qMe2KCnOIve9OJQB0fOirI?=
 =?us-ascii?Q?zfnoTBrsxDC/wl79QLDCy9cZ3zDwOlA4aa+i9hcBnbMrU2aVIQm6MN8BxGzV?=
 =?us-ascii?Q?FsHob9TBPw=3D=3D?=
X-Exchange-RoutingPolicyChecked: rc5c/H7S0L/JHuJmHsZyajBSZs+OwsJNHB9lX+Wbfp+oSr/JX9ioLxHi1NRsFZH+vh6if/CI2PGLtqk3AmJNfeSp/MKSty+/Itya4CBbCD/PoNRpiwTyTv3IHFLOyPFHw731WSVAEMi+F8D3Zi+mf/yYjB242gu9I279a+DcZjhNZ4clQpedBvqTfiuKBedlhwUWB94tsUGAueD6nM8ZHaRBzi/0OGnJdERxM7maSGUnhU7X3PN21caNavhqP1wevZlORR/29QF8DnLVM8/+MGxnb9TxITScwBzOTZygwy9+iOunn0nuBr9ox6NTotybpzZs8zG4CclrAPJnM5xblA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 871dd234-2dc6-4230-281c-08dedccbe85d
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 08:35:47.3958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9DsVo75Rj8wHpGcSZdCS5U4kMbRVCSgy8jTKQ8DBsX1kufEg21aoQrFXg9cIqkDF1Td66ZXbZwou9WUpIjyHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6786
X-OriginatorOrg: intel.com

On Mon, May 25, 2026 at 07:35:13PM -0700, Rick Edgecombe wrote:
>From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
>Add Dynamic PAMT support to KVM's S-EPT MMU by "getting" a PAMT page when
>adding guest memory (PAGE.ADD or PAGE.AUG), and "putting" the page when
>removing guest memory (PAGE.REMOVE).
>
>To access the per-vCPU PAMT caches without plumbing @vcpu throughout the
>TDP MMU, begrudgingly use kvm_get_running_vcpu() to get the vCPU, and bug
>the VM if KVM attempts to set an S-EPT leaf without an active vCPU.  KVM
>only supports creating _new_ mappings in page (pre)fault paths, all of
>which require an active vCPU.
>
>The PAMT memory holds metadata for TDX-protected memory. With Dynamic
>PAMT, PAMT_4K is allocated on demand. The kernel supplies the TDX module
>with a few pages that cover 2M of host physical memory.
>
>Releases are balanced via tdx_pamt_put(): every control-page free goes
>through tdx_free_control_page(), and guest data pages are put directly on
>the successful tdh_mem_page_remove() path and in the
>tdx_mem_page_add/aug() error path.
>
>Assisted-by: Sashiko:claude-opus-4-6 GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
>Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>Co-developed-by: Sean Christopherson <seanjc@google.com>
>Signed-off-by: Sean Christopherson <seanjc@google.com>
>Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>---
>v6:
> - Don't have topup op take a min param (Yan, Sean)

The topup_external_cache x86 op still takes int min_nr_spts. Did you
forget to remove it, or am I misreading this changelog?
