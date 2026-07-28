Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B668A280329;
	Tue, 28 Jul 2026 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203016; cv=fail; b=dyVVrKSP97k+jiyS9Jf2hCZQyLWtFXQHywCr81W+E/VLHB34qLoUFuapIrMCLnzGwhIkvZ99T9KUQTlMbZ9lF6m7Qnkw2rvTyMWu5EIVt7lQK0pabJAiaBDecOriac/kXQ2w8+eFmJ03Y+gj7Xu5uYN0Fw5iNq+0gFIRz8grKTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203016; c=relaxed/simple;
	bh=jMxcbVqKsQLRKALw2nmK27DWyQJCVqlvi0yZrqPeol0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ElrH0pevJc7bYVoczg99wKA2bgXMfiOV1mutSCto6sBQ7ySP4WFSpaMgqQVZp5tEhJb+YqssV7MYE017oJZgHVOgr26Hk/vnWmc8O7r9bI9SUeGZOb16DEKhBuxKRBuOfTDDdd+yLcm5Ct7N4RXzmudG+fD5hQqbFrpfFQttlVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iF5EP35G; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iF5EP35G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785203014; x=1816739014;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jMxcbVqKsQLRKALw2nmK27DWyQJCVqlvi0yZrqPeol0=;
  b=iF5EP35GNwdxWCk0CGvbbF3b/rGi85NALMhAWxKVKDjek9jAuHfJWus8
   8BE7omjMMNkvUAhzfAoX3wK4HBI6+W0CpeAJbatQLtVzfBvziJsbyi1P8
   cMZzZWBRgSwEJx890nLS4kDy2MNPDy758TTGyQ8+ZaKQK2lP842cZlAkn
   qImZD1srONvb0TK7lbDy42J98A+Zsm85zdbDWUPJqIkrrlKfghBgAAcT4
   DxcHY1WPTMLz58htJ1gtZ5pzfns5szrIqYjaJJCrDo3yenpCgA9pZNNvc
   BsD0SBsxfBI3lYS+AP3C9t8/VDwAaqNXjxABQCi+qxf3Dxsj2Qm5HYims
   Q==;
X-CSE-ConnectionGUID: FmEd2bCwSr6CZl59jXlmYg==
X-CSE-MsgGUID: 0/45MoRvSiirVLBCxBGhdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="96440193"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="96440193"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 18:43:33 -0700
X-CSE-ConnectionGUID: 8iktfo83To+w6bX/8HxYcg==
X-CSE-MsgGUID: 2gr7ZCGzRtSGFCMP43ESoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="257774349"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 18:43:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 18:43:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 18:43:32 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.71)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 18:43:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euHy335nNKDz7tpq6tWGCO3/+1FfkEBeUYqUvb2Lpe6YstVa+b+fPn8cq8wN8KGezGBFVM3y0jHGtRtGi/p7XG1nsVgWQw4KC2hevD5W0WvUOJD67RhtmWmIHeVFvx9Jv3XqKm3Rz2dtKTtE9HESUaX/VL8dpM9zA5alju9yJx0LHTFmw6UME0yfGtQzlnpjFGLTIOyfkWdeKXfwoAybCCaKOam5ZsOebKLX65RZI9GaoigqJKHBbNp/rG6b1JfuiXG28bBpNu4UqQ88L6y74hzJfFg7yIabPflRLFJuSCi95/Z3dhDamP0H/EU5Oz78bKB01mg8fkV3LoLgFri+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clseACvsO9MVNz57RymFrRQvn9F5p6xmgKd7DngTlns=;
 b=dVItofyxSLPfRsIEzJMv0zk4r6cQd/JH/mtopRBlk9Vpi5jEjEdE+3E0cN5/zJOTxrQtVYx9KMrKHRaZxrQ+B36ZbawyFlD0lypox2heTXQZYYqF7qgF1A5jIo8yVZPQZB3kVd5C3HQ4LFqFeMAkz91YFh65/NL/rVkA4ZfV3xmJu2+NIxjvwcDZAmBfE6lGlizbOWHTNtPGHCT5bLLuMRIctMwFK0stnQRijxTu5plXAxx/P3WxRIIz+jjt2HvIssZp6CRwjnmBXhvC424OwSF9W4U5fDt/W5qP8jvEFdJv7pxbJXgRUBC/gix3FbIykQx8S2Go45bgyfFtgyEPWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 01:43:29 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 01:43:29 +0000
Date: Tue, 28 Jul 2026 09:43:21 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/20] KVM: x86: Enable APX for guests
Message-ID: <amgJObo15jsluTtY@xsang-OptiPlex-9020>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260720171949.498680-1-chang.seok.bae@intel.com>
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DM4PR11MB5309:EE_
X-MS-Office365-Filtering-Correlation-Id: 060e0593-2cff-49b3-6573-08deec499ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: O3MQDY0v092Df3FrkXgimgeLYuXQatJpkIZpElL8hqy+/fxBYfHlpU/0A58EXWWBrYvNBhHLErJWVbd1M9KD5nwujK866k81YmfPLc3jZWpHZrRWKfJIB3RVgOr5bKhxuwwCT6XTwAtHizQY4vbxnedBhQmZ99VWens2GK1Sug4/a3B17GxuY5gkwqFpxeBt74fqipkAyqUGpT8fI7GMJ519/g4om4+nMXwg8e09jDJBzEAHQD3sy0+CYezFJ++2LpYzsv79wv1S53RkviYU5CMcjKmHBsHckF2KramEf4T9U3r1OVkRTBbTl1eGzZ+wdBhlXISuFOFF3uVRgwcRMmfUX3VU6ubsCRWRpMBFLTdCf19HOoc2hYzu8G12zu1KmLX1UIZx0bamcUWpdEgFqs6h2gl5yQmZBZhvEUOSXxN3t+mN7RCQjc18156sMOMtLFveoB/35Q/RUgXpokHY2O0jGxtdY7XDNI9pGRISZMZexpu2pbZ8NrQrye3KVWsxhgR4FzOLNEsq6yT88C4W8QTvY5VO6/14IfXPPUk/778x1TGLFkLfxHx3QzRZ/33mk6ckwbc5LuzoWb3QAkoiMhZP/6WW+vu4MPYOQ9hqvXKhOtQNnkt9cMHtrY+UhthDtxPGm6p8QoMPAd/WozxNKaW9z4lOBJjha3KeYVqQYUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ILsYQRL0PGRRXddcN43UbQ4oYrLwouzK1SNrFFq3EUAe3L/X/CCjjcfUUOom?=
 =?us-ascii?Q?cI4PCTOdfF9JELbZh/nBYk0MTH4GAvgor9LCbpW76VJxuSNJDMD+5ULknJOp?=
 =?us-ascii?Q?/w46fP/SQiXG7L8TY7CAVgOdNBj9aRA4hTgOjbJsrMC5TXk7uO0zA3yWf7sa?=
 =?us-ascii?Q?RDw0g2R7yPK8hN3HN91FFnkCAnwt8GFqnSMZTTN+W0rxbkjIQ9rz+jwl3+AQ?=
 =?us-ascii?Q?u/JeY/znSY7R+1rX8px0DWVk1RVW9Aj6DtyfLY0t2XsVsttXu4BeCpR3AF3D?=
 =?us-ascii?Q?Xqusjp/EeEmZdK5GcHB3Nal30toirssmUewU1S9jIdX0dKVIljeFYc6jJsO0?=
 =?us-ascii?Q?PBkllpUUEAEMJ9acXJcfaldrshfkzt10O8mAJT6VIrWvOUo0oMwJ4tISMAqY?=
 =?us-ascii?Q?PNLo70oln+8zsuhd0rKbvnF++EvRtyIa0Xe36OZJm8RNEALufpIaLE8GSCMD?=
 =?us-ascii?Q?V0uakVu5MDgL/ueFugpj8yNlcQWpnTyJxJCHb2gzxfESILUtuSggGUxi1Ac+?=
 =?us-ascii?Q?rl/AZwAIh9GXMUTgdVnfbFMQizRc/qMmgIpmmsjhou7zjxEnYvOu0UH3bFNu?=
 =?us-ascii?Q?PPWRjmF+GjRjOUhonePCqxWetxQEhyK4Cc4ISexujsDg/7MiJMmecgi0wihM?=
 =?us-ascii?Q?ovTi4swnxg59mQik4mjfkWHFToxpKu3m2RzAtVdZWCX+C1lRnL3+SubLvPN8?=
 =?us-ascii?Q?DVuvGgwQFwKnDuaRZiXyAkKkZ/R1N2Ek/aRPXnjCT+9xY1XVLQmGpk6TX4kB?=
 =?us-ascii?Q?I8ZVWQcCKvVrYKWVc4Ogt8zdN7U13EvJwVAqy4Ni883GSTkmYSmk6uilhxrc?=
 =?us-ascii?Q?VJtH7IuSXDjioH5gD253j7K+zhcstem2M8X9MbrOKAueDMs7jyN9tUDuWiVf?=
 =?us-ascii?Q?edMSi30GahwzQL/MyyXXEDkAlkQ3A4f9c+ry2GoR3li3V2UmKbfs5R69A+Ng?=
 =?us-ascii?Q?r+ymd8d982QqdA0cN4ArZRF99jhCb/Y2slNMkHcI2JxYCMsaFzzIv4B3/9K4?=
 =?us-ascii?Q?TcQTS0vNKRH11A73CDoNwiGkG8/0w9TwJpZjLdMDDzrnza9Ip6rcivBb2T0s?=
 =?us-ascii?Q?YEFlyQP2hmaXa1ZykRH5nW1SCoBGldSPLzxc4sZCuz9Hr1bQup8D0mWjFR4Z?=
 =?us-ascii?Q?/CjpiYEO4QMbdSb9sRyk0qG3jVwOVO0eZzuX9PB0FO6aqHVqgFIRD0JreY85?=
 =?us-ascii?Q?iYxDj9kzIKZBbe6ptFUsZzmNl2ALPHuui6NfvW1QSOkAYWsgFHdzbsDdOrMS?=
 =?us-ascii?Q?nYXJtjtYNn92oFj/Ugqex/1LykjG4HV9p/p9sMRCdfqmWjcJGg2n/hnkyhnN?=
 =?us-ascii?Q?RF/76IlAQR25jVPvjHdegDUzL2uWSYKkbXheiVIFkLiVxOaPi0GSgI7BDnJS?=
 =?us-ascii?Q?QTdWks8w7vKWGdAAeAA5hoppSAWKpbr0g8Q1RPTsiLrUKNifGxGiH2Mk8WsA?=
 =?us-ascii?Q?mbG4y82fWg65OPeLTlie4NOSpXmgWSGkMvdt5mbtMBor8lH3U4Vnxk+XmtP+?=
 =?us-ascii?Q?8rLP3FobYzoMvecE0txsMd2igUz6NG9UCHgGrfAgyOYdU0vubpprkgPY2WvY?=
 =?us-ascii?Q?lHZ5lfQs/PftZrFF0pKipTu4VB8HOXndVFOTaHgSrADMXVsIaQH9BGgmZGpQ?=
 =?us-ascii?Q?qsdSqjA81RLXAHodNXWf35zm9PsYndE4FjS4cIfn6TJ0EgMznO4Sb9Q5xNZa?=
 =?us-ascii?Q?pHEgXmHpXcEzehcUFfgFteiHmG9vSqdJXlCRwRtFgXnOysLTHd/n2+EEg3hz?=
 =?us-ascii?Q?il8nDQyflg=3D=3D?=
X-Exchange-RoutingPolicyChecked: gVLKzf2wmG6gK3ReqRBd7QJPpm8vzHde2OafhiXX3fG6hyPEcersO6xptUIcsbcrs6a94GHMBGW8WENYdDWlOLxsjGMdtoEyTn/0Y9BAhogGpAoJFzoP3u6RmZgaw0flFvMaXg39oqVeSmCiJh8UMsdZ4LsCSVmJQzNj3jtaDsOmSqcNREkyFNmp7dBlXN4k2td2E1P7UcRSM1W1CxViok3hELaG83pLPBfRlAHG+z8csYRcEiBEWw5OE9ddJyy15b1PCILDTjbkwboRjKgEsRnhrf7WT93/cq/46mkVR5a68s+/8oVlROVSPu9F0fbilAVfWl2LVg7DGwL6G6spaA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 060e0593-2cff-49b3-6573-08deec499ffb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 01:43:29.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zw/4l7tsneLpiwVisKlP4jxVxxYi8slEQItaAMZQ7PmGaZpfEdy178nPI7LmqYNE8cD5nrTpw6eMQm+Ojihg9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
X-OriginatorOrg: intel.com

hi, Chang,

On Mon, Jul 20, 2026 at 05:19:29PM +0000, Chang S. Bae wrote:
> Hi Paolo and Sean,
> 
> Here is another iteration for this enabling series.
> 
> One topic worth highlighting first is about how to handle userspace
> writes to the APX state through the KVM XSAVE API, following the
> discussion here:
> 
>   https://lore.kernel.org/CABgObfaocwfLdUBKJYYYEDH8X3n6iEbMsscbaCe_C=8JNnhDBA@mail.gmail.com
> 
> So what this revision ended up with is just to keep those copy paths from
> userspace and acknowledge the redundant copy to VCPU cache / guest
> fpstate. Patch3 has more context on that.
> 
> Besides that, this revision has several fixes and improvements. Sean
> gave feedbacks. 0-day spotted on an issue.

thanks for mentioning us 0-day.

for previous version, we captured a regression in ltp.kvm_vmx01 test, now we
tested upon this version again and confirmed the test passes now. thanks!

Tested-by: kernel test robot <oliver.sang@intel.com>


> Also, since the preparatory
> patches have been merged into the mainline, finally a review bot could
> provide some feedbacks as well. The major changes are:
> 
>  1. VMX Instruction Information Extension
> 
>     During the time of V4, 0-day reported out an issue with patch7.
>     Fixing that also revealed patch4 was missing another function.
> 
>     With a review bot's feeback, patch7 was also updated to ensure EGPR
>     indices for handling debug-register accesses. Also looking at
>     associated macros, patch6 was added for further cleanup.
> 
>  2. Emulator Register Tracking
> 
>     The review bot at hand also found a potential shift-out-bounds issue
>     in the register tracking. Patch10 was fixed.
> 
>  3. APX Feature Exposure
> 
>     As per Sean's feedback, the APX XCR0 and userspace exposure were
>     reworked a bit in patch14-18.
> 
> Along with the in-tree KVM x86 selftests, this time I ensured running the
> x86 KVM-unit-test comparing between:
> 
>  * Baseline - Paolo's `queue` branch
>  * This series on non-APX systems, and
>  * This series on APX hardware
> 
> The full set is also available at:
> 
>   git://github.com/intel/apx.git apx-kvm_v5
> 
> Thanks,
> Chang
> 
> Relevant Posting
>  * V4: https://lore.kernel.org/20260512011502.53072-1-chang.seok.bae@intel.com
>  * KVM-unit-test patch: https://lore.kernel.org/20260420212355.507827-1-chang.seok.bae@intel.com
> 
> Chang S. Bae (19):
>   KVM: x86: Extend VCPU registers for EGPRs
>   KVM: VMX: Save guest EGPRs in VCPU cache
>   KVM: x86: Support APX state for XSAVE ABI
>   KVM: VMX: Refactor VMX instruction information access
>   KVM: VMX: Refactor instruction information decoding
>   KVM: VMX: Remove unused control-register access defines
>   KVM: VMX: Refactor register index retrieval from exit qualification
>   KVM: VMX: Support instruction information extension
>   KVM: nVMX: Propagate extended instruction information
>   KVM: x86: Support EGPR accessing and tracking for emulator
>   KVM: x86: Handle EGPR index and REX2-incompatible opcodes
>   KVM: x86: Support REX2-prefixed opcode decode
>   KVM: x86: Reject EVEX-prefixed instructions
>   KVM: x86: Guard valid XCR0.APX settings
>   KVM: x86: Add APX in supported XCR0
>   KVM: x86: Expose APX foundation feature to userspace
>   KVM: x86: Expose APX sub-features to userspace
>   KVM: x86: selftests: Add APX state and ABI test
>   KVM: x86: selftests: Add APX state handling and XCR0 sanity checks
> 
> Sean Christopherson (1):
>   KVM: x86: Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init()
> 
>  arch/x86/Kconfig.assembler                    |   5 +
>  arch/x86/include/asm/kvm_host.h               |  19 ++
>  arch/x86/include/asm/kvm_vcpu_regs.h          |  50 +++++
>  arch/x86/include/asm/vmx.h                    |  22 +-
>  arch/x86/kvm/Kconfig                          |   4 +
>  arch/x86/kvm/cpuid.c                          |  27 ++-
>  arch/x86/kvm/cpuid.h                          |   2 +
>  arch/x86/kvm/emulate.c                        | 121 +++++++----
>  arch/x86/kvm/kvm_emulate.h                    |  21 +-
>  arch/x86/kvm/reverse_cpuid.h                  |   6 +
>  arch/x86/kvm/svm/svm.c                        |   8 +-
>  arch/x86/kvm/vmenter.h                        |   1 +
>  arch/x86/kvm/vmx/nested.c                     |  75 +++----
>  arch/x86/kvm/vmx/nested.h                     |   2 +-
>  arch/x86/kvm/vmx/vmcs12.c                     |   1 +
>  arch/x86/kvm/vmx/vmcs12.h                     |   3 +-
>  arch/x86/kvm/vmx/vmenter.S                    |  31 ++-
>  arch/x86/kvm/vmx/vmx.c                        |  28 ++-
>  arch/x86/kvm/vmx/vmx.h                        |  77 ++++++-
>  arch/x86/kvm/x86.c                            |  92 +++++++--
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../selftests/kvm/include/x86/processor.h     | 120 +++++++++++
>  tools/testing/selftests/kvm/x86/apx_test.c    | 191 ++++++++++++++++++
>  tools/testing/selftests/kvm/x86/state_test.c  |   3 +
>  .../selftests/kvm/x86/xcr0_cpuid_test.c       |  19 ++
>  25 files changed, 801 insertions(+), 128 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86/apx_test.c
> 
> 
> base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
> -- 
> 2.53.0
> 
