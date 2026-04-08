Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C511F1537;
	Wed,  8 Apr 2026 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775613794; cv=fail; b=lGEZAHWmf/f3DFbMC+ERlwd3QFFYlI9gbXITr9Gc6hujFR3sU67+dsMuPXdLMnkyBftxRn2KW8rauyTbYKPeMyvpLEPCKB1mKjqN0Efs9uLHNlgn7nrkGLrWlVYqf7APh8OMoG4Vuft3iSObMzz+Mrm7mSMj0RE5FHrRbRUYCQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775613794; c=relaxed/simple;
	bh=vGrwfnCEJ/0KGBpePx23AWcOqs2qNGzAS1VzLeczUlY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B/E+pa59kShezpp7E0ZL1NgOrPpSp7kXEvgI9VA4ogh+riWXD0PE7Ay9VdacKBC47VcLhs/zn7Fgp0W6YSQWR8klFGhkvGzZ4LL+WVgmn4Sqp41bkNfY8nAtlWNgEhtSd9EgU6UdyndatOfogOgaep1GFULo6ASuFwkuPeEOwCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0oF1OX8; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0oF1OX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775613792; x=1807149792;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vGrwfnCEJ/0KGBpePx23AWcOqs2qNGzAS1VzLeczUlY=;
  b=D0oF1OX8MPbUZ5V/QD7u9Rh93PESBwB48en8JOrBHXzCVr4pzQuIpNQL
   o0G+rCckCrGcudSlZ97NgMYsI0attdxaTPKriI47r33L7sUO5MeJY317M
   byHSvHUfuGL55RBh9R4Y7ZCQENAi50cHvekyqEuKqSXfsEcdWbMrfnv2y
   Q/cRK1V0xclJNn5N1BG7YIAIgNlQAHG0iCgHeV8jS+1v3QuJxiu9F5vBj
   GzGEdiq2eqUoOjYC7/yrg1m/4xr0cbnPUDmZa7IuQdK//vJhdxFDozfNj
   rEjOmq1bm+tGuKBJ4693jfvTd2KzhNEHNkwhHZOEsQY/6xiCol5wJuOui
   Q==;
X-CSE-ConnectionGUID: grtKeIUHSZmQI0AUy30/rA==
X-CSE-MsgGUID: JDLGoxJpQqWfmebUzNCfxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="93977822"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="93977822"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 19:03:12 -0700
X-CSE-ConnectionGUID: TawRSm3eRo6LGonN5UoEqw==
X-CSE-MsgGUID: yJBoBex2ThuKcfi0kF1WOw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 19:03:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 19:03:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 19:03:11 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 19:03:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h345iEzacleus5KPIRWKC8oBYfBDMj+N6jkvkynLnWQz3RNcEhdG2/A6YyjERYDAS4NMCXcYbbqUHpOJYopLojmJk3HOoGIC8NhslVxr9MdIr7q9IyyhqDsWQCKlyj+ThfJRJHoLImdKIPBWdppuQAR+Ug5xAZ78ddBnvuJnpRUNprYeWtHmI7/RCz90G/xWEwZdpWAHRrWzky7HJwBEULlEswuHQgmnVj2S6BVQ7U1axxukTuedRZAnVNK2mZCQtZ9f4AwhErGJVYBAsbPa94p8jnm4PWDDUP5zfvvhdrv8p0m1jgi8Lk5kB+iLzMeaFnME0fNCw84OS2ICmeilxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1O9Zm0p12kkNeGFdrBXIvDi9xbfYsxryTODAi8II9g4=;
 b=WSp0ikdhXKEQ16bRlA+mYGq4QeP8usOZhUfYoEbeEAeNpTAqjvXAyiXhWew0NWZ9yaFzQaeDyCpvG9amfBo3kkEPqtEkktS2jQ2v6sXcYB8zUSNoOhLAlFsaiwPlJrJ3aUA2x+aywls5D2rbq9oP2XvyeUXSGRDr2K0kUUrET8lprVc5n859zJNa4bxZ3qtQCODgP7D4tbdkDxxqPGQ1SGcJ+qcQwQAINGxxtbPIoV6Fnn5B0/vNovJl40K5v27QByMxCNqRF8md+qNtB39QhOpdt0rqsuDLyGsTa+cKn1YZXYYEHmBRJ6DurrX5DzLyp5lEEA2Y1+EOKYh/msd4EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by PH0PR11MB4885.namprd11.prod.outlook.com (2603:10b6:510:35::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 02:03:08 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 02:03:08 +0000
Date: Wed, 8 Apr 2026 09:23:30 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Message-ID: <adWuEkW329lcbaeL@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
 <acoUt9vy8OPU1SW9@yzhao56-desk.sh.intel.com>
 <8a107d4da92d4cf910f9a70991a0e67b42e04d4f.camel@intel.com>
 <ac3Ng7IZpzJczZ2x@yzhao56-desk.sh.intel.com>
 <4dfb4c106c834cd13da78872bfb262e98581fa55.camel@intel.com>
 <ac77oSNltyE6vkVD@google.com>
 <ac+C9FdF34JRNLWH@yzhao56-desk.sh.intel.com>
 <d4319635e971e38534509b7424c6c08fa729209c.camel@intel.com>
 <adTBiKPanE15vtjS@yzhao56-desk.sh.intel.com>
 <10949597e3e49a0e59ecb2345be9e06554646d96.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10949597e3e49a0e59ecb2345be9e06554646d96.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0013.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::18) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|PH0PR11MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2a84aa-1ebf-4a26-1120-08de9512fa60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZTuc1iziK6UVOFY8TFBFD+b8nSdQqmzJt5wtXZumRhPMey/6flKOKLuzfj5ThA3328wk0IiHYId5j/wz/fsVlS+l9ZAEr2SYaPiaKthFLOO9Ov+6ShSIptVEmVyhRCFLxqPhm+vzk7KhSKq9/i+htnPLVCQWf13Cjo1+fEpPPjEMBJYZObyXmagi3EZSk3YLzs6gr6axX6gLyq+yNr7cnlCEwbdboZrdH/dwSgxtdV9CMjD9R+fSJaVlct9R3P6QAb2utZeB/eLae8XlOLGaUhqyBYXlH+HYTEYO0g+d7EDecleZ2ZVdND1eGRMuUTVv4DK5sSaLcbQ0lY2AJOOVvmiaAPCr8rW6YTZreDI9Wn50ctFu10x+Qsm2j5O+4TPnK+g07DgqvUWgx9aMiJjKpO0hEBhwDm1iIXH+7wlCi4iDqCe9XKqCqCjjsJW4k7RcooCy0uplNPm3lPnydPkdleVNbzDQHf7pmRAIhKOkTuF7kRL9gy56WoHyOxM0m2Nv5u2miuF8YBFCoRpBRdx/ymKC5m0pjPtg50YxXAf21avsdcsEeNMfBQh5gageeGi/JI7N7YSGzKKmSqSospocJxp8ykZCPIujUMaN5nzeYq0PRX/SOAbnfqYDdIpPr2u7auC3+BZHsidy6Pd963utJCFA2bCVIiezeWOlsRRWywfX0m75aLEpqCvPYWs3WSaa7hx0dKvSRsgYfFcvob3HrP1aaGkokdF9vpaQFKXU6N0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6WjPOm/7Y/UXSjlsB8EgJf+1pLsXtAua6VIVXiH1/z2H8aLaE0MuydifUi?=
 =?iso-8859-1?Q?r1WP3M149zDAKzUFNdg/SGZ4rnYUeEVtyFIwnkY/2zcROrBQe6KRn4BNY+?=
 =?iso-8859-1?Q?Fo6uyIAGc/Gz3R3hO/Y1Ia8aXN0XcIBZ/8LWo5L6Zs2+bMz5/M9k0bY1cq?=
 =?iso-8859-1?Q?6tgxPTrO3ihMk2UZI76LfRaErzf3SWMxdv+2AF0+g4eO6PoE6es89EggZZ?=
 =?iso-8859-1?Q?uqDMlDEyrGvG0dipXttIlekVUCquhp9ufcVV+68KFeBuzHwIuqpQC1HvGF?=
 =?iso-8859-1?Q?lwq2STFV1HvCHAuN215mGYZbE98SZXezrOPWbfvcq+Q9zU8kN9lWFLYoR0?=
 =?iso-8859-1?Q?tekAqexwPHSUnrhC/01vfblKhvcI2P+DXTQDUv3tetJjgFVSsLnGpqUTW+?=
 =?iso-8859-1?Q?YyUN3ctyypNdimM6W0HXrc5aIxULA1gvL39XCL238sSaX0JWMM+eJPyvVi?=
 =?iso-8859-1?Q?qqzixLBpyR1odKKg8RcZNOaZAmod8KhCKO61pkvtNwyTmYz3olbj3CKmSl?=
 =?iso-8859-1?Q?2GCwAS8+8W2XzSVw6PKIe7CiX9ctdQZXeJGIcNqdl0839hRF5loP/SZ0VE?=
 =?iso-8859-1?Q?nQfYr5qqXLM4UP2KvjHZvvwclx2ShPFhJmt95FeOLi6sVkyMzkynQgZzyi?=
 =?iso-8859-1?Q?QperYTc71VfGN9GaPDgcHxuwnqJIa/m0aCEqXZ5sUjpSd16soazQBq92Lm?=
 =?iso-8859-1?Q?St5a5zYnVaqUBee5qF/+UYvoBGiaQbRhy1lS4A5g6NaVD+1bBxKS9PtiKR?=
 =?iso-8859-1?Q?aYskB9PTknaFDN0DS3TXvEZ5l9ui3X7fr5POHkU8bHtKGJEBGEM90xyzl3?=
 =?iso-8859-1?Q?y/rGUpQLt2+D2dZTSQG4DGUX+IsQGwCWb1vYT6D3vPV5L76CiWy7viq09+?=
 =?iso-8859-1?Q?DvgxY1PsWM/K0ySvd7oAH2P5zS/6lwM4gfuYedo+SCDyNguWt3EZo1pF+P?=
 =?iso-8859-1?Q?F1ZMsPtuCHBugrnXoiwvwea2ezmnzTfT8y//vOibQuNwk7Th6Ze6S/fHLd?=
 =?iso-8859-1?Q?5HORyAIdV11oIV05tNOtB6QD4GNVyJ4P8RumPjsKQJog1EYxlvn8KToGxV?=
 =?iso-8859-1?Q?29+nHmKgCFZzkUToS9zGUYOTk7Ji9XFhBnJKrChGCSxYPeLmWdZ/uL+ss6?=
 =?iso-8859-1?Q?ogGmTiY8EjuFGB4h0Gwo3VTP4bCrvJ9nQOTRfAQMpL9BFvwqWDwgHYdES+?=
 =?iso-8859-1?Q?npZf3byqzY+jkEX49YQDp3GykxjoFBllb7ldrXljeCLqhvvbJW95Xgrowj?=
 =?iso-8859-1?Q?6x/VLguueVkO3EUCWbRvBmyFCtILVsa4wJvqqrGxo/sokQWugqNeZTHonq?=
 =?iso-8859-1?Q?agTMEqyi0/LJgKfkkog/GX6LUAgZWyCLEYYtRD+p0qqBili+ASj/WjiAhZ?=
 =?iso-8859-1?Q?ijflAMxp3fLEpg7dgrXIyVQ/eCvsY68wizbHPHhS0KD8aJBvA4Ed0/awM6?=
 =?iso-8859-1?Q?C+GeeVfFeI71y5FRpr4leVeeraD27HkGHf0RzceLI/35diqoLdLsHDkm96?=
 =?iso-8859-1?Q?HelOhKeI/T3nUv4j2OPvdMNaII8Y2EInmh7e2ZGapvVMkwxd2TPHBraYCQ?=
 =?iso-8859-1?Q?mBP5rEkEEm4lMvMi8daReYXBqpyxJYREYs064tgBNmE+OqugkR0LRF+P7e?=
 =?iso-8859-1?Q?gvACqIEkn5efXUj3zZ7hh5V7oiW3GLu17lQCkNdPgrsMTcYuL9ercYNshp?=
 =?iso-8859-1?Q?sAgRE3n7qhp4/o2yp8M4m6wWYBBWHYQ5SM45vQXJRjOiAPKyKakYfwL8Cm?=
 =?iso-8859-1?Q?dD9+odhhSv7iYmaDGc0/NczdSszniGwIkyfNNnEv526x1Gy+WhZgbhE5Se?=
 =?iso-8859-1?Q?XLeICzy2Mg=3D=3D?=
X-Exchange-RoutingPolicyChecked: peJ7EOlpdt4aM1xgnFtE56h37KJjv41Z3G7dbWZXARIdAI0YkoEnxCx0Wlad6b6Ha/kfn6JyX965hyLLjK8mmQQ1Ov2aBrhNNhbn8V9cUr62Otdg5IFkcU6fnk5JORNsCaKGq7bzs4WedNN+Wj8JXBbYMm3hdnPpjsotuIZ/pD6vSS+ciHsSDpyzxJgcmikQk5VbXOq2HrS4dnZYwVz1iAMY8DhpSORb9jYlfSc16EohZPFP6/Oy7BepQlgRqEszGvHyFSj+AMs/2P2KXX/T0oTZTrzLKHb9m4qpMdTCnAnIH2stKnUTVlE0TCwia0PnSlsR/0uzbS1iCNgYEHEPfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2a84aa-1ebf-4a26-1120-08de9512fa60
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 02:03:07.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gblBg6Yv3wprIr+PeDOKKz63BZYloWoaiAbG90IBQfh1xQGIlqBlGw5dED5auYH96nGSFaMB6yu9kaDUJiYR8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4885
X-OriginatorOrg: intel.com

On Wed, Apr 08, 2026 at 01:21:26AM +0800, Edgecombe, Rick P wrote:
> On Tue, 2026-04-07 at 16:34 +0800, Yan Zhao wrote:
> > (a1)(a2) May hit KVM_BUG_ON() in handle_changed_spte() if
> >          tdx_sept_set_private_spte() fails due to contentions. e.g.,
> >          tdh_mem_sept_add(), tdx_mem_page_aug(), or tdx_mem_page_add() may
> >          contend with tdh_vp_enter() due to zero-step mitigation or may
> >          potentially contend with TDCALLs.
> > (b) Promotion case. Currently unreachable in mirror root.
> >     Need more complex changes in TDP MMU if we want to support it in the future.
> > (c) Will not hit KVM_BUG_ON() in TDP MMU, but will trigger warnings in
> >     tdx_sept_remove_private_spte() due to lockdep_assert_held_write() or
> >     TDX_BUG_ON() caused by concurrent BLOCK, TRACK, REMOVE.
> > (d) May hit the KVM_BUG_ON() in handle_changed_spte() due to failure to remove
> >     child S-EPT entries and will trigger warnings in
> >     tdx_sept_remove_private_spte() due to lockdep_assert_held_write() or
> >     TDX_BUG_ON() caused by concurrent BLOCK, TRACK, REMOVE.
> >     May also trigger TDX_BUG_ON() in tdx_sept_reclaim_private_spt().
> 
> Ok! I wonder if we could (not for this series) encode this information into some
> centralized helper on the TDX side. It's nice to see it all together. Not sure
> on the idea.
Maybe some code comments to tdx_sept_set_private_spte() and
tdx_sept_free_private_spt()?

