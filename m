Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072143B47DF;
	Thu, 23 Jul 2026 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788677; cv=fail; b=DOSBQj+wOfpcceOoiCfNyiXFa0uknPu+QEKxYfGsPDaiUrayn6hMnTFjpHGeRTG0oUv+97WPW6hmhVjLo63cEPDthFDYSyIT0gr2/o5o/tFk1Y2SG6OPEbv+PjndYbRZJoW14HSeAhHZrhHGwc0VMsQ0sG4I0kiqbBzk3A5R5aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788677; c=relaxed/simple;
	bh=fJWM1EZP2s+RbytHr20bPLbh1AFaufbHJzU4Ly6/5jc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IYhHcGlQWAqUvAtw+lQeE3ehMWzDrIPoxBK6NDAd3iYfAZDNPsuQFebRG+VPxNDyQZuBHohzc43CU5+Y4WZDoJkCpMwr0OMRVngkrnb/0Iq3t3TnmlHO8t0akTGB/QhwzpDGtbGSyqfPVwncGh9CttRIURSzhUSQrEdo08mPj5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HllIucg8; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HllIucg8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784788676; x=1816324676;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=fJWM1EZP2s+RbytHr20bPLbh1AFaufbHJzU4Ly6/5jc=;
  b=HllIucg8Am2iY7zr8aVA6OBOmJmD8uqYWvMdQtWJz//R0eoSyPNo+LS2
   5pJ8bzqFRT+kt8TKMofj1TP62+tQ4CxzrFrNaWilQdtxCDXwGlyhu8Z7l
   0IZ5p7+o9pAiefFoIU5NX4yawZRzDiIK8x5FMg93GJnXmN+RAnPli/q0g
   dFdiG2sNtF6KmKDvyPR5DCdSiZb1pmtvYjBqNbWdxgZUndRRd8zpkD+I0
   Q+Wa/uxp1DCGzNWUXpRA//BrS4RapyTKTn3kjZN1whsLlbkAq51gRz78C
   W/AlhMyiNYNOeNfHggPVbQ+jo2n6dD4onik9+i/3yzdqKeF9QK4cFQtwG
   g==;
X-CSE-ConnectionGUID: SmHK0IOTRtWBKUNdqJgaJg==
X-CSE-MsgGUID: KmV+kbjMTwWd75/BpJpPDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96025292"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="96025292"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 23:37:55 -0700
X-CSE-ConnectionGUID: Lioo7rK9QXibwz9sMYDTvQ==
X-CSE-MsgGUID: J+iiCVqERKO5XZsei4wwFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="256515350"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 23:37:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 23:37:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 23:37:54 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 23:37:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zz8TQLwmZiRw4+VnTGJvSm0alWMNyiNNruNUwOMRGuBjGyyRqZkyqFfsMpD1bJAut2volrgfD7wV6wvq3pdT+j5kZm0l2EUSMqT8oZhVDZnl3i121Ij+Br0bxAucIpXo6B1Jdh9S810xgTE78fxv6NcGus0U8vo4QQmwb0vVFM9ink0pF5h5lo3/XKEYyAgoCWiF6AAxM4bBkGGp1igdsUSciSAjC8SFKzYQ84jdoqwtL+5FW67kuuHsGUSEkzUy17avimVDnOSaDWvfmFRjALiaBKTDMO7BAnCD+aofN54Uf5RgTBDUtOR/WMqGrSMjW61b/OVWXCfptrr+lyHkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqcwcu0jN4BjP6qx0rfM+9rJuIGDLPNB5kh0TlZl7JQ=;
 b=VwHwZAwImfLWOZCJFeXuJDmvVVBsGUE4+gZMjYvF23FpBjOFwgkNT4bsrpF3It9oUu1xQWvUU5FyYsUYohgOpGDzxQEjZyid6Ka6IRqCMN57eKgsQxpZzSeW9l/A3cCpZBNzWC0VC8R77gCcSSxM+8s0P7fKSZypTy4WNjd0aR+lSodwNmAdXG3qpSSLK795NByUPZ6lePuf4mgS+O6UNS/J3fkGwWBHmTKxFid3di3+TOu0uhkYMH8rmrfIcgjXN7fbobcLzduh0VmOTsmPpLpyi5Ku1JAIhT64bY4oC+FLiZorrGkt1Q/W7wDbtOsalK//dbg5Wi0qCn5vpEKIVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MW4PR11MB6982.namprd11.prod.outlook.com (2603:10b6:303:228::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:37:47 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 06:37:47 +0000
Date: Thu, 23 Jul 2026 14:37:34 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, Kai Huang <kai.huang@intel.com>, Dave Hansen
	<dave.hansen@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, Binbin Wu <binbin.wu@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, Vishal Annapurve
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, Chao Gao
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Message-ID: <amG2rkuE5WqldZxM@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
 <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
 <20260718061050.E17B01F000E9@smtp.kernel.org>
 <1417841720b8435f8fb95ac0bd95be6e0e9390d4.camel@intel.com>
 <amDd1Ip3XTvKSTcb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <amDd1Ip3XTvKSTcb@google.com>
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MW4PR11MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df1e178-7d37-4c99-d557-08dee884e8f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|56012099006|5023799004|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uNClBz2/re6tnyLZRO48LEkLSYYEycZcUznEyNpkCVm1W/m+g1CzobTpp1eUgYMkWdq30GNlbPWahRSHDiUlryVob9Ei/rRm2xwVXf+YXiFhM0RAvM3LEvvBXg3SrEtTihmV8mNHUcBS9cvFNjbOdH9dF9O2QxNuts3F95PzOfnmq26hx7F7ZsL/W6su4CLGgLsL47UgdQBCoYhS974XbvhPauwY881N5QNAkZrrvgNTrmN1WdlV44htzNYN/FO9gX6NxUDVP6jncHZadcOTlZurW7S8mlHt/Y80srmVlz9XLVPLoVdY5tEYcy2vrXD32RJ+xsdGtVIGvNk77GzyH8zxc6KZ8wNmVb9o8GaeLJc3l2Bec8NNjqap5rKEON/QcAnkNJBjS26dimdeRMJsHlzsZf5N4gObrnHYdaWD8agqheEM+xSHua1Y8rTpcGHyV1H6TnAnkDi+Vc89ysjXYl6EssFUee8nUcHmf/yzzjARcqcckNSt3d19ofJVH1ggPE7zvOstDcqzB2v/vegOjAajabqCmtXUEulRnu4qOl3fIkSsasVA81sOyepN6MUrFnKc6soJmCeaweZXT+QqwOkYN+gSm4XaW7ovfEu1yIFrW5ejVnH7Gd1hhBHt/0K1ReDWnFBypGB5Q9VSIWFwsr67qaRczKXE2R6PvWzn4hk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o6Ls92aay1gagtE+7mOv0qvNY1lecV/VO09k7pHhHvP1GfwgdwsJVcCrkbxr?=
 =?us-ascii?Q?uVzvtQZ/iqHnNieOyDmfQluvx05RqD3yXOkiokZ7UdwhNti1YuE8TrdLZygV?=
 =?us-ascii?Q?uRxblnvOHVqkgWB1Mxskz4nlb/J/rNCjx+Rurl0e1/sguxh+nkPxR7GbE7LG?=
 =?us-ascii?Q?s9m0/1Lv0v9kqs52tYGIWF4HVmLFtsGM/Fvxtgpsi2seUfXSthfyG1dvhevy?=
 =?us-ascii?Q?fzJ0f5cIUaQ870+roIUJUgGvDcU7mP2CafLJ0SzUmn9gcyMutYuLNcH4s3Jr?=
 =?us-ascii?Q?Omno5o3DZooMmGl9+zhWPpfYdd4lT7YytrmdwiLzbpI/4KExXs3xqThYNNG+?=
 =?us-ascii?Q?Yl8p7yAOoVakLrkc3+2qCennw+HCpqlXICi0sJrdmyNcQADBRj2MYMhvFO+i?=
 =?us-ascii?Q?3V6qk38m5pWhPwVe0vLtJuYTis+npzdsIuVcBEEGMqwzXhVJVS73I5qxdRcy?=
 =?us-ascii?Q?bn+PdlS1HeE/S9epmEmVaYIcLtsbWlDKw27k4TuM1gdhKYsPuCz0mYZPPzlR?=
 =?us-ascii?Q?t1C3h7YStY7lk90MOg83tWpELDmzJHJswrNZ3IrlrkgKatUHxCll2GUg3FX8?=
 =?us-ascii?Q?7+qPmV4dp96ZdIiF1sydFPFQgc8mVsGLXspJhwMe2aNK7HS0r3Kj8vV1L8xL?=
 =?us-ascii?Q?e1Cy7C+SdCJpMyTzxdclzQd/kU2NUPNMFRYzqHEBOH1j8moz4XEGzw+cNTam?=
 =?us-ascii?Q?/J65yQgHPsX+TXpf0EC4rok9Xc4/yFTMYVavSO3ycuXL5fQIBQ1YZjwYvHH9?=
 =?us-ascii?Q?ZmvDcd8zFKppui+cpjrOlfNMugxKIIR4BqClM9/SuEhseweSEBrmA3QTiSv1?=
 =?us-ascii?Q?Mc2z93OViAHTJRKu46NSWrcMfp44FY+5DftlqgoIANX+pHf264IPJOuWMMnM?=
 =?us-ascii?Q?SsPr+2efoBUJ1FSrqfbFRptTL0LEyG02h/YSrtX8Mk66zkO9ZqqbsH72cO84?=
 =?us-ascii?Q?GLwiqDNHeGImc3X7cjhQ9Ku7/WHO7NpWrV9D22xxKt7EKmmnNHtVXPNYoKTe?=
 =?us-ascii?Q?tE+19bTU1laKxvwoUVznKFNqEzSBDcbU3UkKnLfw63L3aTc8IapQ0e16RigC?=
 =?us-ascii?Q?eNtmxttAUy6sZwQhXaD/sZ2C0q61tyb2mAPdrc+/xoykj15uV8jNBhrZ7Mdj?=
 =?us-ascii?Q?lxKNEGqjdb+c1TWoLzomvYQGvX1JeQOU7LwExkBV93C/hERwRw6EWPalTw1/?=
 =?us-ascii?Q?FLZu/m8+1WZuqIjBHnz4jh5BBPNRA4o2wiV7i6Uq1lMkiihDumASawMxgNIJ?=
 =?us-ascii?Q?/EIElYaz2MSWhDY9ukibFJtev+1vK0jcO315fDdwVckrM6uFCXReRgImabCv?=
 =?us-ascii?Q?QaZMurbw37+bZIf+NiRSeaGpyTHhX32ZNF+7UHIbzf6Ej3Fp+zeId8Hu984n?=
 =?us-ascii?Q?ssRqPR4VI7fItEWh876qMuZ8KsYkuw9ZvSAfaYeTxGansbos3nR4hoEqWiT9?=
 =?us-ascii?Q?LkERLTcoVWLL+QM0hFeV6c1utc3o+3cyPdvBBVJsSsRr6bsEvt+4b4EIdxVk?=
 =?us-ascii?Q?yQdCtosTZRJnJynfdePK0/CUqXr9J9BCrh1Tq4tO0hLw1KIBd9oCP1APu63s?=
 =?us-ascii?Q?n+SDUN8/stBFf/oITQ25njPL/xAKyPw905pzVquz4CHmyRyertJPlGYyDlPZ?=
 =?us-ascii?Q?tHhrSHcMT+LEAVDNCd+l/RpICyLIE3vz29FHs79Z4TVPsQzlVXaEzGL3Vr+9?=
 =?us-ascii?Q?AO+r7lHCdDsVD2SVR4ZZK4a9oTxcuajWZLZ/T/uN5lpp43ULapzWkvh1oEYr?=
 =?us-ascii?Q?yzDHScqiMQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: FmbCtEuXe5E+DB+3+WRzsbYbjSd6HQ/drbP8be8iLCiaBHINQ0m5asr8A0I6GL/NXp/QQJqzwgUAzTGuKcbe0XhDefZu3wnDYnM6NLbmwl7+eNtG0XBnke/VDlXSoOoeiC0g6CHhaDWOTr1Ae7j+A7qFDh8xMT88wgwtdxuIpjg8XWuvITJeAAremDBWqlpvMOSbPsjFbVboGrwPTKKaKKCuoOMVlxuBzac5h4nY+fp0QuUiaRN7dFg0v3E/6MO5j/vzdA6CbX0E5c7fko13ARWWMFhEj6c3w7AEWPyDHtRUJPwFjv/M4OgJX7oj4QA2im56Q0g3LMhjn6gJSQLCwA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df1e178-7d37-4c99-d557-08dee884e8f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:37:47.6306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYu1c+3K7McyvmWTO7L1Yd6+Fbbu+J+ALGMaO/CVYzUuwU2rXcHLp65SW7W9eVcvMzSqdlox0bj9yyr0SB/Lhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6982
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 08:12:20AM -0700, Sean Christopherson wrote:
> On Mon, Jul 20, 2026, Rick P Edgecombe wrote:
> > On Sat, 2026-07-18 at 06:10 +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > - [High] Infinite kernel loop in `kvm_tdp_mmu_map_private_pfn` due to permanent PAMT cache depletion on transient TDX module contention.
> > > --
> > 
> > Our internal Sashiko found this too. It's a false positive as a real bug.
> > 
> > Today kvm_tdp_mmu_map_private_pfn() is only called tdx_gmem_post_populate()
> > during TD setup. It holds the heavyweight tdx_vm_state_guard which grabs vm-
> > >lock, kvm->slots_lock, and all vcpu->mutex. So there should be no contention
> > possible.
> > 
> > Any potential confusion is not new either, because a similar thing could happen
> > with the external page tables.
> > 
> > But Yan and I were discussing that it would be a good cleanup to fix this anyway
> > because the reason it is not a functional issue is not clear from the code. For
> > improved readability (and quieter sashiko reports) the topup can happen inside
> > the retry loop. Either by moving the retry loop or moving the topup.
> 
> Hmm, yeah, I think I agree.  Super duper technically, that's a fix for an existing
> flaw.  Because very, very, VERY theoretically, the cache of page table pages could
> be exhausted.  E.g. if some other task managed to free non-leaf page tables while
> mmu_lock was dropped, thus forcing kvm_tdp_mmu_map_private_pfn() to allocate from
> its cache over and over.  In practice, that's likely impossible thanks to holding
> slots_lock, but given that (a) retry should be rare and (b) kvm_mmu_topup_memory_cache()
> is basically free if no work needs to be done, I don't see any reason to do topup
> outside of the retry loop.
> 
> The other thing we should address is the call to kvm_mmu_reload().  Like cache
> exhaustion, it *should* be impossible for the root to be invalidated/obsoleted,
> thanks to holding slots lock.  But as evidenced by the rash of recent shadow MMU
> bugs, we don't always get things perfect, and lack of defense-in-depth can be
> *extremely* painful.
> 
> I don't think I want to just move kvm_mmu_reload() into the loop, because KVM
> should provide stronger guarantees with respect to the validity of the loop,
> versus the population of the caches.  I.e. I want to WARN if the root becomes
> obsolete after the initial reload.  And more importantly, KVM really should
> check the validity of the root after acquiring mmu_lock.
> 
> We can't simply call is_page_fault_stale(), because mmu_invalidate_retry_gfn()
> is inherently fuzzy, i.e. could get false positives, even though the pfn provided
> by guest_memfd is guaranteed to be valid.  E.g. if shared gfns surrounding the
> to-be-mapped gfn are concurrently invalidated.
Past you said "No" to checking is_page_fault_stale() [*] :)
[*] https://lore.kernel.org/all/aPken0s-0MfdSd5o@google.com/

> 
> So, this?
> 
> 	r = kvm_mmu_reload(vcpu);
> 	if (r)
> 		return r;
> 
> 	do {
> 		if (signal_pending(current))
> 			return -EINTR;
> 
> 		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
> 			return -EIO;
> 
> 		r = mmu_topup_memory_caches(vcpu, false);
> 		if (r)
> 			return r;
> 
> 		cond_resched();
> 	
> 		guard(read_lock)(&kvm->mmu_lock);
> 
> 		if (WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu)))
> 			return -EIO;
> 
> 		r = kvm_tdp_mmu_map(vcpu, &fault);
> 	} while (r == RET_PF_RETRY);
> 
> The other option would be to gracefully handle an obsolete root instead of WARNing,
> but as above, I think I prefer to WARN.
> 
> 	do {
> 		if (signal_pending(current))
> 			return -EINTR;
> 
> 		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
> 			return -EIO;
> 
> 		r = kvm_mmu_reload(vcpu);
> 		if (r)
> 			return r;
> 
> 		r = mmu_topup_memory_caches(vcpu, false);
> 		if (r)
> 			return r;
> 
> 		cond_resched();
> 	
> 		guard(read_lock)(&kvm->mmu_lock);
> 
> 		fault.mmu_seq = vcpu->kvm->mmu_invalidate_seq;
> 		if (is_page_fault_stale(vcpu, &fault))
> 			continue;
> 
> 		r = kvm_tdp_mmu_map(vcpu, &fault);
> 	} while (r == RET_PF_RETRY);
> 
> My only hesitation with manually checking KVM_REQ_MMU_FREE_OBSOLETE_ROOTS is that
> if more checks/functionality were added to is_page_fault_stale() in the future,
> then we could end up missing kvm_tdp_mmu_map_private_pfn() and introduce a bug.
> 
> Maybe we can have it both ways?  WARN if roots are unexpectedly made obsolete,
> but fully check is_page_fault_stale() and gracefully handle an obsolete root
> instead of effectively terminating the guest.
> 
> 	do {
> 		if (signal_pending(current))
> 			return -EINTR;
> 
> 		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
> 			return -EIO;
> 
> 		r = kvm_mmu_reload(vcpu);
> 		if (r)
> 			return r;
> 
> 		r = mmu_topup_memory_caches(vcpu, false);
> 		if (r)
> 			return r;
> 
> 		cond_resched();
> 	
> 		guard(read_lock)(&kvm->mmu_lock);
> 
> 		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
> 
> 		/*
> 		 * Snapshot the invalidation sequence counter after acquiring
> 		 * mmu_lock, as guest_memfd guarantees the validity of the pfn,
> 		 * i.e. any concurrent invalidations are guaranteed to be
> 		 * irrelevant.
> 		 */
> 		fault.mmu_seq = vcpu->kvm->mmu_invalidate_seq;
> 		if (is_page_fault_stale(vcpu, &fault))
> 			continue;
> 
> 		r = kvm_tdp_mmu_map(vcpu, &fault);
> 	} while (r == RET_PF_RETRY);
> 
BTW, since kvm_tdp_mmu_map_private_pfn() is currently solely invoked by TDX
during the TD built phase, and was introduced to avoid redundant
kvm_gmem_get_pfn() calls in the gmem population path, are there any foreseeable
future users of kvm_tdp_mmu_map_private_pfn()?
If not, could we simply drop the RETRY loop, given that the locks in the TDX
path already guarantee that a RETRY error will never occur?"

