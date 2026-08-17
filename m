Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850033BB130;
	Mon, 17 Aug 2026 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954326; cv=fail; b=O0DDUx9pSsmAZ5O81APR+hoHuQ0hGkTum3owizLWUwsPJI9nmk42dmlyMgkFIlbdJI/X80CQOUnC90spGLJzhJyQneUr8IudOca9DjsJmyia0wYhpDNLJ4WxN0TMblSVNN8d9bcbqHDkzfBBN5ebgVtLXXQ5SbKEvELoQVnIc7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954326; c=relaxed/simple;
	bh=hv8S6r2JUzJxl2fB8hIpGRaRxJrHpL6Ijv2DU/G3r/A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ingl2PAqShd9K22+AgmHHXbRlFDRlR9MTYSO5T1V0pAoUP8gxEFc//JJ7uqGGuhVIKgAWwW0wc0VVwIOoJm3f9eCmyiyBMbwIDLdtAvPl5yjLG9Bq+SSRuktxOZdifHvMoeFAsvYptTBr3xEEOmjf1ieqjAQ7JzW8URTML4ZFp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FC7zcpJq; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FC7zcpJq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786954325; x=1818490325;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=hv8S6r2JUzJxl2fB8hIpGRaRxJrHpL6Ijv2DU/G3r/A=;
  b=FC7zcpJqgbxc/VwfR0nawqHHOiVTez7zgYxqy9RWmUcLfBjcj+0zFGpo
   vm9FmLd3ZJGR1Xc7mRe7lBwmiAQsXGRbD4Oaf8+CEFRYRYCZQPItAwWjY
   +uHPcpC4uYmOaphwKPkkL4cSTZP6N4CAmblLGbjEUTOrtY9CQhN+aI3qD
   2tXogMee/qMbH/swvwNT9wvwCZjA6Vdq3wvVJKj2+4ibL4uoP/pFMgBmC
   7ykPRX98NqaQGtzjWkcQyQoXejgIJBwbPyrapiCnk4Unf52mMqYEMzID7
   8jev5rPoNSoDJTzjJ3+SLoN0P+iYfeJzeG5iFwYP7evdlG+W+ypeod8oY
   w==;
X-CSE-ConnectionGUID: hH9Bm7z+Rnao1FG1Njihhw==
X-CSE-MsgGUID: U/LBie0qQ0m3i+Tc0LubgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87444001"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87444001"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:12:04 -0700
X-CSE-ConnectionGUID: OQuEUIpIRe+r9VIIztaltg==
X-CSE-MsgGUID: LHuSj6O4T2Kbo1jv2CWRqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="262221270"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:12:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 01:12:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 01:12:04 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 01:11:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4nuSeXza4FgYI0hWtw1TPP04zcwpHtm6WsZnvCZy0bxKplCNtcGCrvn0JRupNcGU+LSI6S6OJ8ecl+5AgmdS6C0ESpksjz/k0TS8y51iI8wffX31tTPcgSvGvwNhUcRBGlO3wKBqomLKWKcG9URKppQ5L332UGCUz0/0RWQq8PTlZUi13bciaHOfB8ex6ZPAhchQBCgCPA5dSOCmrYbeMYiqukhjyB5rvwRNC2KIQx3NsxzhLgKgJrUJiDI0xloak2qYaMJ29L+X1IaJAn8sTOBs8DMxQJYYa67sVomjKcZJvz2EM068gVuNzCMy0Z0f0yPP2PMecPnABoE0JY85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yfx1zUDR0/z0vIiINifxXShzzxLTWneSsFqO5ORDl8=;
 b=wzCRFpfYFsO7lNGPwBlQA9mBvk/YtFDkix2KNOrXi1ROCOVRMrE2WoC+31CNHqaVLW9x8aTEnajo4K/ZPvnPsbfu+R7+1/CHnhCUGtE0HmG6rfUnrkn0NYjMFjcW8bdu7IgLDHEEqsrKOjC+mFqk7qPxTf4gfjCQqNZNx8Rcu6Zlp+so2Cwm+huT8Dom06SY2SkLx4o7Vf4nGXJ4lUCGuZzrsp3pGt8+DY21tEnvV8XDlDIU8L7nBKaJ+A+JhEO9t6wFjAmOwsO8TpVIMIP45qtK+tB6C7WXgrSmFtW13rnMlV6T0oO0odpHscXLswts+I64LONQnPi+PCaZrKiVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LVUPR11MB9589.namprd11.prod.outlook.com (2603:10b6:408:3a4::10)
 by SA3PR11MB318319.namprd11.prod.outlook.com (2603:10b6:806:588::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 08:11:52 +0000
Received: from LVUPR11MB9589.namprd11.prod.outlook.com
 ([fe80::6158:db0b:38aa:9c5a]) by LVUPR11MB9589.namprd11.prod.outlook.com
 ([fe80::6158:db0b:38aa:9c5a%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 08:11:51 +0000
Date: Mon, 17 Aug 2026 15:30:59 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
Message-ID: <aoK4szIBYjaJ6RS7@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260806214050.78058-1-seanjc@google.com>
 <20260806214050.78058-3-seanjc@google.com>
 <anrI0WZ3rA0q6X+Z@yzhao56-desk.sh.intel.com>
 <antW3aKeEabMCsyV@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <antW3aKeEabMCsyV@google.com>
X-ClientProxiedBy: TP0P295CA0036.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::15) To LVUPR11MB9589.namprd11.prod.outlook.com
 (2603:10b6:408:3a4::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LVUPR11MB9589:EE_|SA3PR11MB318319:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c20ddb-a05b-4aa4-81ed-08defc373177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gOxteQSTcJc3W2rc6c9NrLriIQyMWq6AZaCCUkqbx8ThEfqv5sOWq/kL+DffE6CWot7s19Lzks16VFb/mJ0agzFmbWFwGo5qkKg11As2Vmg71O6YELobj2yrIJB/Q48xpA4YRfovvFmhR9rcsurDX2w/1jMTh3rZXrRKmrSm5gD9WBYz7f3n7REMpY4uT00YQIjw9EqDjWdY1ixB4+5KlGMK9znqOjSsexvTunQKirOLMWLA01PD8QI2yAl8t6QDd/fZIjDeJjr1MjaTBp7I3eiqc8s3fuLc2NCfmkGRRW7r04xmDJ3H8FA7SWJ4GVral+Tszdkx5ZbNmB3t1/JKGnw8Fq6qVtT9Wf1HkA3hgpT08OgidG/Z7yn9dtzvKIUQTBRaynB9HZr3fFgVPYEku4dWpAcDT1zu7LZ1pX2BjC6ku41Vg0ZCTH2ngbm4mmklUkO5haJ2dPzXJPo4HGDDOQz1Ox8HY4bwRr5egxex+ebEB80wm8DAneHbRL4kZPb3d1+vvH7+WUE7y+Dm+Ftrdr7nKpOuI7w+aty8Kaea+cNuhSQh5HEtjhsYCzZq+WS6VGqRx9sXnFpkqzx5LZv8K56iuG0MBRz5pnu01b1qvaibW6AJjvq2kAhbnWNKT5lnqNNNH7hb2nTF7pn1c+iuMWl1f1gPzzUrYltrnMS8VF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVUPR11MB9589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dzrfS3KumqHOldEOP9WHESd+ZEnl9lzWgnLNRTLgjzGi+CwD4oMnu9XGn/W+?=
 =?us-ascii?Q?KZWQw6v1Jg1tQ6jM0bFxsR2/AehETfoN8614qJG+T0lRNh84PpcLRRE/OKHX?=
 =?us-ascii?Q?SIuCiu23MCIy2m9MuyTiyTQ9A8T84cq3ajpfslxQCqUrJ3Q7pTduFLaGvp/3?=
 =?us-ascii?Q?U20yBv+lh0Ds+5MI6uBgH0DzOGC4WBO3M+4eRrftasB83kkXqUaiJ3IUw3GH?=
 =?us-ascii?Q?dw6SJuS9ZvMT229t/8xZUb4Vs6oPwAAYCxvgMmzreds2mnaZ0AgPBd0dxlNd?=
 =?us-ascii?Q?rH3YoWFqqcB/vNSjOACpYde0tKkE7JerLDfjY6enXSbK8IAhG7+rcMgPNfg9?=
 =?us-ascii?Q?oiDllAQPewFfVJI0vMnozbBBQKzDqUaxU/9w57G4435hwS7o8XmttU6Cu3Tj?=
 =?us-ascii?Q?zGJxr8+b1g34J2W9womc81VnNjaAC6lrLkreb3U6a7loi9ajLXfKPgqSyaL4?=
 =?us-ascii?Q?uD1SpY3DjRnGH4PDF4VufiXbrVR+pvDdA/Su/e2cTDoiFMbYjGGAr2BLDdkd?=
 =?us-ascii?Q?YIaDzO6UEXS3Kt8Z7Ut8GZ62hj1CwIkQfBdqhOWMbX7mKrTh6ukS+bei6AUF?=
 =?us-ascii?Q?1BcWQlBY5Wc7U22UrD9JVc42x6K7+wwrY+6DFcND0wi1zexSEs4OxhWodhbP?=
 =?us-ascii?Q?Qp41U1JKwTYgoU9Sfzg1yEx5XWNphh249LvI0pWq+eLxokdLZ4MrvzfcGMur?=
 =?us-ascii?Q?AJtsV0PqYgjCVTZhET6+QXXVH1FuTjLoZ18PbL/1GRGw6oqSQce2jz2YbfRH?=
 =?us-ascii?Q?fjInNf5Ozof6e8wxDOKiMNz/VjoG1r8KLfrB0LcYhpx90rin59P0ADKejAF5?=
 =?us-ascii?Q?W9AKe8UJ+amVeTQqCxYM88gFYy3KKOY0eYggSVb91Snu1hjy41mBTxzu/u1f?=
 =?us-ascii?Q?nHJqmHAZr+SyOSwjObRq4V2CCyOwFyVi9PmZZldJENNKoFiOafv00PNKNlrR?=
 =?us-ascii?Q?W5+FOD7seWPFtFKIbkrtme2p6D59X59bys8llPUH9C7eBAJz4VkQjjB61Sy1?=
 =?us-ascii?Q?n8pJkI0G/1r5iIbulKof5ISArfNAOFtBFpkjHkSVHp8jjsAm2v8+YGCo6+24?=
 =?us-ascii?Q?BzLX6UQEWDjbIV1WsIp81voJTUj/gnDYFHVkQ2t8KpLAJPiAFz71RfpQXXN7?=
 =?us-ascii?Q?2SI4JtmO2OgvG5L1PAqR0Hq5fQ9/Jjci1XcwRz8IaaJ04O56JjIMRgRNzQoB?=
 =?us-ascii?Q?moSX+/uqNJE08kcqz+UxsNaq+2RzuZfj6wI1WZ+n4REwZm0EZjQ+PQcAxEUD?=
 =?us-ascii?Q?mSJg/d4CGyhqHsDu7zqDeQod+CoIMzsPwosJscAh//vXo4XCuHlUd/yvuV3o?=
 =?us-ascii?Q?+laXTS6f+yTlEEPsvGZLW8bU14WpA0eF/F7ECaQDAE5aN0OwYiG2ta8XScCK?=
 =?us-ascii?Q?VEv5BRkizwRRyw13zAuqKnH3aDiYHTeoD61i9NcAkpNH3afpI0zAsPfLRwf+?=
 =?us-ascii?Q?LBfeg3Br3hMWcfIHsJxzg1GlgirRfQlciSeH5j6Xhvi4FV4r8Z+EwPBENFQ/?=
 =?us-ascii?Q?+Ycn0NhzSHIQoOC8a0Xl3u7mrQ6aidP4otbiEzeIhzuXdJza7i/LhnEl+hoh?=
 =?us-ascii?Q?w+FASrGAxrYxxcS/OoseRW3IpDLp6s0MoSguFr7AbWAPh4jdRBQ2gdbVgzHH?=
 =?us-ascii?Q?2p6ttz3t5bMWk/MOo4yje4Bv8S0GdchaKOIKE8FXJxY1+XfAgAP1MqWzpqvO?=
 =?us-ascii?Q?fVmaRxQ5SocOYuwoX9J6K6+/TZmUfqT7ag6qGBzcWJP28xbMKJ+n2APzjUHN?=
 =?us-ascii?Q?uxEUglRqlA=3D=3D?=
X-Exchange-RoutingPolicyChecked: irQit+zWa/Ho57BdXWO1DvNCXf+cm0oKt+4TcpFxPjOllnFzgkpcD4J34ZuXLB1u3zlx/E175bn+JgPbL+COOs4hO+OI+Hj1xKE8AbiqbzLQRKWjZWm9FxHDVmq0OpNfZysdJzakIW+hNyUEodG787tKbUHBNdeDTGCJB6/HJqvEy1OZpKPrkjSl9qDDtfuQkAOQ3m/+Qnb8Esx5d7Og/L0sNNfk3tsJrxuyeHaK9YEd9NOXI/5ZsgEoRXBoCJw9gejrK5Kd14qs07Hwic/dOl4w0e2ys6aE/zVhh07HCtnk/koJlq4ZkPCMe2VxVp8rReHILW9dxmgiyDKG34LXmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c20ddb-a05b-4aa4-81ed-08defc373177
X-MS-Exchange-CrossTenant-AuthSource: LVUPR11MB9589.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 08:11:51.8245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zq25s5DlCkiWxZZ4d045G8D/9vRlxAvoldEC9ECtP0liO2b5MniTy6zxlXHJ6KsQiA+r5leo/rL571a5yNFHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB318319
X-OriginatorOrg: intel.com

On Tue, Aug 11, 2026 at 10:07:41AM -0700, Sean Christopherson wrote:
> On Tue, Aug 11, 2026, Yan Zhao wrote:
> > On Thu, Aug 06, 2026 at 02:40:48PM -0700, Sean Christopherson wrote:
> > > Move kvm_tdp_mmu_map_private_pfn()'s reload of the MMU into its tight loop
> > > so that an unexpected root invalidation has a better chance of being
> > > handled gracefully, even though it should be impossible for the vCPU's root
> > > to be invalidated after the initial reload.  As is, encountering an invalid
> > > root is *guaranteed* to put the task into an infinite loop (albeit a
> > > breakable loop that honors NEED_RESCHED).
> > Note: without the newly added is_page_fault_stale() check in patch 4, an invalid
> > root would not put the task into an infinite loop :) 
> > 
> > BTW: As noted in [1], is_page_fault_stale() only checks !mirror roots, and
> > kvm_mmu_reload() reloads mirror roots only when !mirror roots are also invalid,
> > since an invalid mirror root was considered impossible. (up to now, no?)
> > 
> > [1] https://lore.kernel.org/all/anrD8nI8RfYoNvbf@yzhao56-desk.sh.intel.com
> 
> > > Add a WARN to try and detect bugs that break KVM's expectations, along with
> > > a comment to explain why it should be impossible for the root to be
> > > invalidated.
> > And there's already a warning in kvm_tdp_mmu_map():
> > "KVM_MMU_WARN_ON(!root || root->role.invalid);".
> > So the warning also seems redundant.
> 
> No, KVM_REQ_MMU_FREE_OBSOLETE_ROOTS can be pending even if the current root is
> valid.  And once the is_page_fault_stale() check comes along, the WARN in
> kvm_tdp_mmu_map() is effectively unreachable.  The patch ordering is weird, but
> there wasn't a great solution because adding is_page_fault_stale() first would
> create an obvious infinite loop.
Ok. When KVM_REQ_MMU_FREE_OBSOLETE_ROOTS is pending, it is only for direct roots.
This patch still holds that assumption true, right?

If so, since mirror roots cannot be invalid after the first reload, any
subsequent kvm_mmu_reload() calls triggered later in the loop would only reload
direct roots.

Is this necessary for kvm_tdp_mmu_map_private_pfn(), which only maps private pfn?
Or is the purpose of this patch simply to avoid the potential infinite loop
after patch 4?

> > > Cc: Kai Huang <kai.huang@intel.com>
> > > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > > Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kvm/mmu/mmu.c | 15 +++++++++++----
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index 621b0a42f2a1..c6cac893cbad 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -5184,10 +5184,6 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> > >  	if (kvm_gfn_is_write_tracked(kvm, fault.slot, fault.gfn))
> > >  		return -EPERM;
> > >  
> > > -	r = kvm_mmu_reload(vcpu);
> > > -	if (r)
> > > -		return r;
> > > -
> > >  	r = mmu_topup_memory_caches(vcpu, false);
> > >  	if (r)
> > >  		return r;
> > > @@ -5199,10 +5195,21 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> > >  		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
> > >  			return -EIO;
> > >  
> > > +		r = kvm_mmu_reload(vcpu);
> > > +		if (r)
> > > +			return r;
> > > +
> > Since kvm_mmu_reload() is moved inside the loop, should we also move
> > kvm_gfn_is_write_tracked() inside the loop to prevent unexpected bugs?
> 
> I'm leaning no?  That check was extreme paranoia in the first place.
Hmm, ok.
