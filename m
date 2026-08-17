Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891DA222590;
	Mon, 17 Aug 2026 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952045; cv=fail; b=Xhe2eaOOCzFWcnr3XzdMpwL+nlEvxAuEWmtEkpyWnEoLwUj9esuZt0ejWG6RStrX5FcD8GmBPxKrvebTgM1XCG1Kr0ouPsnjo3FyinlRtr/RwDq+jS0RwIO1BCVf6BsWBejhtL2yGw4eEBeALfS7PgOwx3pY4hiEGrLwUWU/juk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952045; c=relaxed/simple;
	bh=lnJ1ftbqYnOzLc6StgNIJkeXTVASNX6OyqJe51SKnL4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=glVd4vlS54pQmc4TJzVlyU1pNx91AwZoZ1qmiPl0OEIjuMWnx4r+wu4j4TdFRp93BC5ay+mAyUSjXrytP/ZtsCBIoCp/53gVjCljxu6kr1R+ZDKRexnNXZ5DFM49xRd3J3Kx3DHrhzOl9lpTlS7X4N80iCkpPOdmyDhNcg3M2Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ej0vICQZ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ej0vICQZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786952043; x=1818488043;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=lnJ1ftbqYnOzLc6StgNIJkeXTVASNX6OyqJe51SKnL4=;
  b=ej0vICQZOKBgKiEW5QTGpzF0LHdeBZduBUOVVp2RM6WqdWPqC1023Trt
   8EunQnUrbS9+mDCbJ8e2uZitGRwsAEtkOMmXvn63VFhmjwqIjpJXiwEVE
   T+WxunftH2Qd2rqpVOosrU1c7zDvwacAPJ942PRsky8PC0VFmbtklRgD+
   nA7U3f7coiMavNuMvdCwOYh2PQg001G4j0vngIZHG4ov8KZVd80tmLd5d
   x5zd4xJTjm3fh2wxOPM6vzpNQbA+/AxGWO5sYPbPYxJa+kxQFDcC7alke
   cc8zFLTn/4M7oQQ82peQ16uKrw+n1v6TmR49rgwfewxue8BEkxi85BmOt
   Q==;
X-CSE-ConnectionGUID: Q3ALzzxqQuqVkrj3uU+wEA==
X-CSE-MsgGUID: tS1A6VW+RhK63j4GQQi/pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="104955471"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="104955471"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:34:03 -0700
X-CSE-ConnectionGUID: LqHLlHgMQqGZI8FJpFfBgw==
X-CSE-MsgGUID: 0QqRW5QOTF+gxegHyahpjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="265456092"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:34:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 00:34:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 00:34:02 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.38)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 00:34:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/lHn0R5CNEeyFKfrtarf3fVT2AF+QR0znyw/LU9q8pLofGxott3EYaf2svR2W/DqSt9wGXYuwdTwB5oY24SUOyDYNOFhWiniLAhcfQjCL7kJa6GBb/XUQIufa3lkDXSQsHdRWckoHfOkfNRPoQN1VLgdB/CwYFIb4hzRysbqiFXGofIW2oteW7A/6d73o2mefjJZFMEGp9CQxrYn5ez/OG4usv1sJY9cC3dzrI61Ys9iOLfzih7hIHjMmVBAMg09KgjePVVNk9Dcl4cZdH6lmL7VaJrd5CjOcNaWwPXTj5ia4Cv1hJSmX7qGux9ikg69v4Nr33Zg5By05a6JOWnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4DSTp8xKFOA0I1+CPi+xoh6ZigcCQjGMiCrgr25fbo=;
 b=Ht/4kS8mfr+AfltqlFX72G5fwwg1zjtIOkG/LZHYeSUe73RsR2c8m4NSwBLGUcNh+7S3+wiamK25SGdAlC/YdGjjJFHiP/PZ/BTspshUeWxqO7uXmM1XdZuXFyL1JRBR9zMGQhmiIZUCxPy5yoKpP+fBMV6hU4vjKfOvP2xxkOksTECf8U+Ntp3sbbd8a85PxsepwHk33+Je3AEKJmba9pvPhjyw0S8Qt4BGsklexyp/03et5FoQDS5foOzfu3MJ0iIWFEUMnHYFoyQEXtlsBtJqTOB1jWTa095M8jJ6a/bpooCu6mXwmFrskjy8sTFdmEN9qeAhdkAtJr/tXpZijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LVUPR11MB9589.namprd11.prod.outlook.com (2603:10b6:408:3a4::10)
 by DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 07:33:59 +0000
Received: from LVUPR11MB9589.namprd11.prod.outlook.com
 ([fe80::6158:db0b:38aa:9c5a]) by LVUPR11MB9589.namprd11.prod.outlook.com
 ([fe80::6158:db0b:38aa:9c5a%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:33:59 +0000
Date: Mon, 17 Aug 2026 14:53:06 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH 4/4] KVM: x86/mmu: Add sanity check to detect stale page
 faults in "map private PFN"
Message-ID: <aoKv0vneW5hleZ9F@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260806214050.78058-1-seanjc@google.com>
 <20260806214050.78058-5-seanjc@google.com>
 <anpr/H5Hxw1EMkTj@yzhao56-desk.sh.intel.com>
 <antX6NCs4-C_ChXD@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <antX6NCs4-C_ChXD@google.com>
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To LVUPR11MB9589.namprd11.prod.outlook.com
 (2603:10b6:408:3a4::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LVUPR11MB9589:EE_|DM4PR11MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8b8062-cf7f-4560-5958-08defc31e71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6NO5BVjg0OHIccM99KaJzAwONsX8aH34DKxO4Xqv6GuCGQGOFBbGQ6YqtoC4fb+aOOU7ARAyzmQkIL3XMhRBe9EmFwFoAMp9exI8STz24JsPzWR3r1hqVovaGmcoja6qRPPl//eKwXCWCHJKwPwkYHKPJVo2YZXo4gZSriu7FxP5uwaNQU0U8IA3zVKAVF/5BI/wl80x0UFjwY8rIzQkrDrCnh1HKdI+Nzm0vAvqG1z1IVT0PlFw0ldfhKdRzfiRYouFVsFNvLwDloAzD9aa97RyNPPvG/GDOkdQMUuis/3n/iHE1sM8NGUwAKNxLXh9E51HpMvkH4arg6AtKwxsfBVTCXi/f1QRm284ds4O1rZF3Lsf4Td+GupsWuQxmWdSdxQ7I0l70rgvIcRzKX5+MgtFYIQRS8ZuY8hF3IcZ5X1iTYTIBno2idQNpT4qL7tjKh1Lq542TKL5cjp4DojYxWHmdw6EEjCtZJ4AmVx/o720b8wf9peYd2c9cBSFPYsS8uLcD/QzsYRKS8ycksaWhRoViRyqmmOC/2ZPOeuXTCUnStP+kjun46Y8qCNEYlzHjPHUArFjOHDPGxjuflMX0PVCeHiTdaoJWRtMM6WmSp0s0UoyDP3PsNVYBCuJxp2eOn3DvlcznB3xBSDyBvoGQ2hu8ruk6Ku0c44xDkkV7R8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVUPR11MB9589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G8AaLZGP4FAt6TuggrW8jykg+eOdAIHFMFqfc8vI3SWfc4C0BaPwLPiNcLA4?=
 =?us-ascii?Q?0TyZpDCGyFWdlTWReOri7o0Q/BpcxMlY1rXUS3FlpFLgvfzObLJptFKB3AMk?=
 =?us-ascii?Q?TZetw3Ib/ckdbPhVJaILS1rAMl3rRZBSiTECVKTHIK7gVnDuasmfvrn8tyC3?=
 =?us-ascii?Q?gp3kI0NUNfC9dCjoT45d5nvZefiU+eMwYvJJm0fiJkAMNftlAHkywF2lfgBz?=
 =?us-ascii?Q?OgXdbjjloIRJtwfZO3bX6pd82suagcLh10/VIC0VMmvSnUGG9XDFoLbAvKfk?=
 =?us-ascii?Q?99yZWa8AVR1qj+K2KywItkcZJvNlTvmn+Nm4OLt8C4p+tvHYQHBnpQ2fnF+l?=
 =?us-ascii?Q?GSvRdPMPU5rNbieDUMgxgOYhw+dFtYpEnkmQt4YE6yBFvnDXjuppZ0i0hWfZ?=
 =?us-ascii?Q?Ys9OKxVP+QhAL0VaUebC+ZnH6YbtGAaP52a/CEE+97fIKLASmCDj2mCekwks?=
 =?us-ascii?Q?VmUKve78NuRdjHJeLEOsZzOOzoQpaZGlzoqiXsSN5Mi4VhVlt6feEilJwfvN?=
 =?us-ascii?Q?ZitcruIhXqSTaMirUL1iWZ9YhNRztGi0Fo0TYMhNe/jGTLYTs9g/O9E2yAN+?=
 =?us-ascii?Q?GAZaj6Zx48Pd1YzXSuEmNjATBJTzufdfqwM1TcySCal9XINv67H134bd4fjh?=
 =?us-ascii?Q?tYmnYMHaRDfJOH4mkWOayhGGx77Hh6vcnBaI6wpiIEPyCzBR/uSZn2RH6try?=
 =?us-ascii?Q?gv9QoK6j5/L3aX71MWNt5bfvCUJ4yG3XFJn7XTTfXQ/yrUKA1c5fc0BG6eZ+?=
 =?us-ascii?Q?df+yANzeey6wtztCrsWduO6v7p0OrohkGlz0M9L2B3KZ0YBDrn+sLNARejQG?=
 =?us-ascii?Q?MDyf8AP319YDSdzIjayyLDpSkVW/ug2KQ9VZ06Ibtjctx6ESR/qJHJosdzAo?=
 =?us-ascii?Q?gDQMEM474TLiu6F0VFKANXlQ8ZEuwV5w7kKhbdZwJ9ufBZl1cavQQErVoMCj?=
 =?us-ascii?Q?NKa7cySOMAnITj+rqXsixlvPmts8rFcCghDAKGZ4OBZ4S8b/jp473MpKFS1o?=
 =?us-ascii?Q?tx122OtLKIDgjoVC6cVsaHNM66M+x72QS07UpFAW18CA9nj5Ot1OHGmgOZMr?=
 =?us-ascii?Q?F2LdHaWywYoRHBHCCbvYK5LUiqPwWrRMiEAhV6RbVhGQC3t5btdryHhxoN0O?=
 =?us-ascii?Q?kFoNj3x+ahC21DDSf1QVljKpJ0a1MNzti4HIt4MSgXki791IwEAVVPdp9B9K?=
 =?us-ascii?Q?d7PN8rtPXyTN0aqigVLgWc6aqglFyhc+joYR3/feoyujJ5x0Z1Nsl3xqCbg7?=
 =?us-ascii?Q?7geacfpVcX6sZMgGW9p2hBZDu3Fvotk+m7JZ21YPLmR7T8P+zVw4kfCvpvBo?=
 =?us-ascii?Q?h6j1rgogu7psA1583QxyoMsMJNEYj9FSwFzBUb49ltPL35niVwnAUiTDW8+4?=
 =?us-ascii?Q?4XGjskA5f3gXAcxEdW55IFNH3CBcluT3HkTgcn4i7hb7UN4JH3rSPgMf0mAY?=
 =?us-ascii?Q?mwqzsvKv02IF822t+mo0qpVYpOi+BxOAxy6BbozG6+sZsyIvFsLv6r4OgYRY?=
 =?us-ascii?Q?bSY7lEBdR8QWcF7/bYnRa0Tsik3PQl1pRUKoV3oyOLXQ1gMy7TLhcIzK/bsD?=
 =?us-ascii?Q?FCAxeAaeOVczpu6K63I5VPyXG801V8ACWreWI3RJMoI/qpHpA1BNy0wQPdk8?=
 =?us-ascii?Q?Q29FCOJcNyI30W51h94nq4CX58QjEfPHGGGHBi6rNZmFGp/m8wJn35aGiPlX?=
 =?us-ascii?Q?NZkaOO6cyfj3616sEMKMhT8YYwxbmG1nT22hXpA1wh2P7fD3uT/DDvTiulIY?=
 =?us-ascii?Q?j/8Wsrfekw=3D=3D?=
X-Exchange-RoutingPolicyChecked: hrGaW9JwcsTwQngIx+cVtFoDsIfXm7iRQyja4JZkJh/moo6ORhh6tn7fomArovWBRxBZ3BBzAtG2bkqB2CKVheLzQmm2JL665c9c7OEXI0Lv1GwQa11gO3zWWWFgE7oJlvSQGe938/aPvV8iIc1j68wusiuHboboz0HUgfLDo9CoRm1Kr90tPccTQwwCtSMwQK26TIgl8sI+UQ1hfmo7GNk6OzrRS8XxfG0nIGwbkx5QOw4hmJrx7U//JlZVgEZHwhxmLnTrvPaiQYdc+7wxGxT9+BuZI3P69JkJ3MrxZF7UC8lbIPQ8Z60XVj0ZYDVsVMkO+zKdRC6iezqmFjs4yQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8b8062-cf7f-4560-5958-08defc31e71b
X-MS-Exchange-CrossTenant-AuthSource: LVUPR11MB9589.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:33:59.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8IvQSta5IbPA6whGyhvH8KpSiWFwQ7bmWghPrhMcYJY89jWPffCQ6zd7KubDySKBKZwUKnwXimOQjfiKfVzMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6238
X-OriginatorOrg: intel.com

Sorry for the late reply!

On Tue, Aug 11, 2026 at 10:12:08AM -0700, Sean Christopherson wrote:
> On Tue, Aug 11, 2026, Yan Zhao wrote:
> > On Thu, Aug 06, 2026 at 02:40:50PM -0700, Sean Christopherson wrote:
> > > Harden the "map private PFN" flow against potentially-fatal bugs or future
> > > KVM changes by checking for a stale "fault" prior to actually mapping the
> > > PFN into the guest.  While it should be impossible for the "page fault" to
> > > become stale, the sanity check is cheap, whereas a broken assumption would
> > > have a high probability of leading to a guest-expoitable use-after-free.
> > > 
> > > Snapshot the invalidation sequence after acquiring mmu_lock to avoid false
> > > positives, even though doing so completely voids anys and all protection
> > > against unexpected invalidations.  Pretty much the entire point of
> > > kvm_tdp_mmu_map_private_pfn() is that it allows mapping a PFN that was
> > > gifted by the caller, i.e. the caller would have to mess up its one and
> > > only responsibility.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kvm/mmu/mmu.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index 379f570ef04f..76e3cd717324 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -5210,6 +5210,16 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> > >  		 */
> > >  		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
> > >  
> > > +		/*
> > > +		 * Snapshot the invalidation sequence counter after acquiring
> > > +		 * mmu_lock, as guest_memfd guarantees the validity of the pfn,
> > > +		 * i.e. any concurrent invalidations are guaranteed to be
> > > +		 * irrelevant.
> > > +		 */
> > > +		fault.mmu_seq = vcpu->kvm->mmu_invalidate_seq;
> > Could you explain more about the conditions under which a fault is stale while
> > guest_memfd guarantees the validity of the pfn?
> > 
> > Given that kvm_tdp_mmu_map_private_pfn() already asserts holding slots_lock and
> > invalidate_lock, I can't think of one. 
> 
> A non-guest_memfd mmu_notifier invalidation bumps mmu_invalidate_seq.  And because
> the range-based invalidation checks are deliberately coarse, in-flight invalidations
> could also trigger a false positive if GFNs N and N+2 are being invalidate, while
> kvm_tdp_mmu_map_private_pfn() is trying to map N+1.
Could updating fault.mmu_seq in each iteration cause a false negative?
I may be wrong, as I am unaware of the specific bugs or future changes you
mentioned below in 'defense-in-depth against bugs and against future changes'.
Could you elaborate a little more on those bugs or future changes?

> > If we add the sanity check because it's cheap, why don't we save
> > fault.mmu_seq before getting the pfn to guard against stale pfn as well?
> 
> Because as the changelog says, the whole point of this API is to provide a stable
> PFN.  I want to add an is_page_fault_stale() check as defense-in-depth against bugs,
Ok. So adding is_page_fault_stale() is not intended to ensure that a private PFN
is stable (i.e., not stale).
Any background on why we cannot update the code when the bug/future changes
actually arise? :)

> and against future changes, e.g. if we extend is_page_fault_stale() to cover more
> reason why a page fault can become stale.  The downside is that is_page_fault_stale()
> is susceptible to false positives; the funky code here is to minimize the chances of
> a false positives, while maintaining a reasonable level of safety.
