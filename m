Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B273E95AB;
	Tue, 18 Aug 2026 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033543; cv=fail; b=sth3YN8AvvxkERfCwI1oOW/MOJUQFz2CD4suTrP4NQXRsVpdVPY6XSaKVrPnJZrHQ1scGCmavpXO3oWT4HQFAeul8fr8L56Dd4iCiQHlUREEMFRqc1iDAFeFItEOmIV+uD1x9McXR8urN2zAUQYf2l8A7Cizjn/fex1eMnccVcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033543; c=relaxed/simple;
	bh=PAP+6b4nATXz6R/fvxXHnW4B3pxAEHrFwu2ybgN7pZc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Moi/gGgNtBSqGfAFYILhe1Kg5FF5qKEvBxOHfMNS7ATrnUrZasnD/L7vOF7T8th0ORWrvYySJoOPSO/iW5PF6BrcctFFXDqeYXWGpDoBapuV54GwmX0CJUx/qm9wCJ7GrEAb29GcotfxwuaDc3KwfOQkKXmYfl3FQfWVjF9bD00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQ3K/xl+; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQ3K/xl+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787033542; x=1818569542;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=PAP+6b4nATXz6R/fvxXHnW4B3pxAEHrFwu2ybgN7pZc=;
  b=OQ3K/xl+YMr9TfBAFOHa9p7p6KADYrD1rc7E1yzuo4ABezT8ZIQtvSAT
   Dmjvq5sg5HrEiAqfxmp3XphztH1f9ufmqVJxMq1PvUiLYHr2SK/bwrEIf
   n4mj/20GVbx7KEA2aZ6L48SyA2UiF7jrls/4OWb3orlnimYd44vdGJ6wx
   W0Xl+REHckU+DTs0UgtkStasVASqIDXJM33V2sG5n8K+uTNCCrPh+bK+l
   5vPvB/VXaWIgXIYD057qeIRY8uLuyAP5/FYkuaBJoVd8uWy6epPrXWHQ3
   rICM5qj1fuAqaMTX4HxOQfcCpm6VOFv956FGXkwCi0toTkyuWn+iCes6h
   Q==;
X-CSE-ConnectionGUID: EgcGnvsKQU2zTiCm1KcnNg==
X-CSE-MsgGUID: RWIosNKpTq+AajBogADAXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="86477391"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="86477391"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:12:03 -0700
X-CSE-ConnectionGUID: 5p8PPKC0RlyJKzuYI/GyqA==
X-CSE-MsgGUID: 8/ncOat4SoG9CuSLbXkGaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="263397368"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:12:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 22:30:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 22:30:50 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 22:30:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kblujKnlMgj5lb4W8OBaxgY/Ja2nYE5N1+ipO/mwLz4fav4TmRGO9SZ+R5E/oYAdejROn7bry8G7YwaH/X55GGiPOCe0rsvNcjAhkxYb4g6O1i+5rQEANYRZnOdezxYAyWcaJGI4jaVXeqBOO2bwNpdm24hGIDnpeBuSq8sww8xq8dwrv862SGZaOlB9NmCZtz1PZr017n4726sSowEHco7Rrkk8224K1DMwlMoYAWRqgeVCwPGZIqnybTOGjaVcfNtZX1TqetfAw3/sRUGRCtlMcwcAK3DgkBTo4B5v5mKWM9KCP8Q67macQ+o84qg4upizaf5NYL0YAivKcvcwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s13acC0+Dp8gjz4W3F1p7GzNTjzOcKwKkScvZCDvD04=;
 b=bULYjpenJbX2NNifML1rBnw6RkpT0zyuofhbuB9O/lcvOhW3+O7n7CU+Vl+52YDImZwR1dgGaMQOaUiW2PA6eG0c61kQE8ppozO/OIwNIJkRIKUYHzAegLS/MAUdDcANg7ZkoVPqWqWMuMpAuQxs2S3K5BJtc3DqHjgAfLd29uMjVfxrslH1eYGrJsWyNckUmYlMT7L4pqRr1sUvkUceFmpyAHBkSvw8RYdlZo0RAZI3wVoswuxZZ5gw80CtUE0XDkSe6vTPW68fBw0UDTKU4sfcmelO8+PP6SXT1Foio6R6PUc6FOXHQsE9IXwYTHBpdWuzsRkK8wbM731aa+3KGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by IA1PR11MB7775.namprd11.prod.outlook.com (2603:10b6:208:3f3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 05:30:43 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 05:30:42 +0000
Date: Tue, 18 Aug 2026 12:49:48 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH 4/4] KVM: x86/mmu: Add sanity check to detect stale page
 faults in "map private PFN"
Message-ID: <aoPkbHEBif3hmlaj@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260806214050.78058-1-seanjc@google.com>
 <20260806214050.78058-5-seanjc@google.com>
 <anpr/H5Hxw1EMkTj@yzhao56-desk.sh.intel.com>
 <antX6NCs4-C_ChXD@google.com>
 <aoKv0vneW5hleZ9F@yzhao56-desk.sh.intel.com>
 <aoMP-1OGrkhtliYz@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aoMP-1OGrkhtliYz@google.com>
X-ClientProxiedBy: KU2P306CA0008.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::6) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|IA1PR11MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: d575840f-40cd-410c-22ee-08defce9d879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|11063799006|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vdqnQXWiI6nNeW7NNneU01n5KP9efj04r49a2248ayUNp2hi9ri5VNtpUqdJJVMg8miL0bI/VL11XkiWBERA+7JYTdJW0PENqINPZuPoRO7wSCTNoL0G1RoaIMLAaatt8keU8w29DPAbMQ6wrb0dtrT3ASTWg3H6hihR58sy96lYnESPPkAQET16urX7qhbRpKsZszEIBPFgZUPKbRj791p92u9D0+XmuQWHQYncqCrmF9np1fsUCLcdRrQ4i3mRwxH+8uCRgwPceRpfl3QrlMKuw6XqlsOhLqqSO5jiDQWCgIPPpxwyxvdQPwNdN8hjPaSSd+Ok72D4i/vs9Vugcy9JDuM1frrS80fE+Q+9SUCd1FVvSyqzc4YqHbwisw0NcaDMMWPyzC2L4RCoC/4pQZ0OYKG/9XAEun0rcgftMxrOSYxuHWGlZsGVNJcMZANyOmE0nYcJ4VGLGBwdfAALgzOhxqO08v69nFadYJf+EoeLV0E4QXvVY3KIaVZUFYnKoHUqho88wjCVDV9ROnkJGJ4g6OS3hdAzF1A8t/33iJnYjvzT12mQDF0UaUsGHD2FGL/WeolWH7aqz0NORM8b+Rp1QpQB3CR6IqUo/FEPIhFTjy6f4qiT+9lEllun1Hhwe8xvWrWC/HdtQzvEMIN6ayQj41qXkJiWMOx9bGpEJ6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(11063799006)(6133799003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pdMDfVF4fn93zV4iGtZlIdvutbZ7l7jegS6v7T8CSvGO6ZP7D6Lz0cRFZWMi?=
 =?us-ascii?Q?M4SkEaMKY5O4HEQU68tcHoT8kNPvxQFTU+7h3NwCLC9mjY6Bs6vAbSFvMkrS?=
 =?us-ascii?Q?mW36T7kiYGFEShv2+4pjw1v+2I0RZ8LtS1j03JwTGke+qfLxBdVuJKKEmaet?=
 =?us-ascii?Q?XGzJdMNj7aZnsTyou3Bgj8q5gsXAS+W+vex7nkgjsSg+xmKzOynu1ss56a7/?=
 =?us-ascii?Q?p6u1HmdJCDygU4is0CYCNvL8c5jXmKKiCnUUnB/aPnH/t/tm1NE3S8yJWxVK?=
 =?us-ascii?Q?GMFpBfNrxoJqOG3qI4t+ZV0VnhSSG3uKgd0UwqQ4wRLPueVIFXyB2J2MVBaG?=
 =?us-ascii?Q?2/VmGlHAxmQRB1Vv87mk3YrhU9lWfijJcvD7UQkduU80F73ikTejkA6+SSAf?=
 =?us-ascii?Q?yfNtYLBVSdfTTGDBDWkY6lfKOQjYIQU7PGWgJN4hLMzfpV9r9yof2J3gzNiW?=
 =?us-ascii?Q?M/fhKsEiGL6s4ATFYXVGePQtjOItXCFNdQ1pvVdGiMfF2ydrEUkQN1aRmxWp?=
 =?us-ascii?Q?P2GQg7rtDUrL4G0WBa/NFhkHn4WdzjXRJIUwuQX+9ml3hdemTsq84DtYHRnJ?=
 =?us-ascii?Q?uwu495uwJJwqHU9e9FsXQG6sYbfzUdtgwwo8sad7cNC+OV44jdBDSGoxRqfT?=
 =?us-ascii?Q?IhadZavF3OTd7lpkA+n6cnXKAs8sgozmyAGHlAgECxaGD/LxmFu8vhI1M5uH?=
 =?us-ascii?Q?/I747n0k0CpQvsdNxc7nAWNKEBakJMxpqiNpMAunRfBaZTTy6M5nBOVFvnJ3?=
 =?us-ascii?Q?psniwnR4QOeaBTl+yXoRTXkhDES4ZpcRJMIPOPPSWPtB8MLL8z7jOuWtJc5R?=
 =?us-ascii?Q?CClYSSnsisM9M/Ql55QQnilnqVw8Ue22MHLSGBvvfnIXtSVYGgyCFF5zk+IH?=
 =?us-ascii?Q?VLMZ214vDPC0W1le64W4GGY4QVz/DSavh9guUfce/A+99j1P3eueCEV77aB7?=
 =?us-ascii?Q?bbPlkLzAWkriB97uUskLLAGsiPP+QHgqR2Qsf+bCvaxVIuhdxzEZd/0Zmc4i?=
 =?us-ascii?Q?tyog0Hn8bLVt/vT56RxY1zJhcrvnk1Sy6yktFHqrns0AtVtLlV2jH8UOFOHz?=
 =?us-ascii?Q?F0+TUFJYbcunzx7rfQR4nRwgxuEKduoj/JWQhAg1aOdnWtBiXAL4O+1pFAfJ?=
 =?us-ascii?Q?DOAwR9wGbLHWCf2uPmOxhn4zVsnuufrD1xf6yhac55zFijZRZtdfp90aCXsY?=
 =?us-ascii?Q?QRZOdK4wAynsLIYK61i31nai6ATgcknWskwzdaQRzkIo3w1ly8/D8OainbkH?=
 =?us-ascii?Q?4xKAf/htrJj8isHEBa47ityGnjGmEfLVD0o9IjaD1aGirvA4I1l/ogLM9ckW?=
 =?us-ascii?Q?dAa6VqNzYqB/QzGVXZ+5DekuiV+q7E30rEyirU30d4RFgIXUGS3lWZoJKOLV?=
 =?us-ascii?Q?Lij0bXXqFS0y3N5CquTLZU9JQWz53HolPqsTq/UMSMtOQDmmdTLqVCINp90o?=
 =?us-ascii?Q?yRS9xyRuztrWc7AYkGbSPUTZBfmcmUwjQ9sq7lmGhMjRI+YheIjZdu+aQLLH?=
 =?us-ascii?Q?sUesfwsWWzj9b8HS7J6JsT12pgT+Xc69LAQdgh7nVspQ0N1y0D0x4Kt3/O9G?=
 =?us-ascii?Q?i35UxkhmChA7jbwMPpgiklb5lVMtdTI3GU+t7FMXDLA+C47OOfjumxd5/Nq8?=
 =?us-ascii?Q?bQJokxXFSmjca3qwgM3hucV7ih6RtY+KlvDwbeWGl7VfgmsVHvO0QJMsRrmR?=
 =?us-ascii?Q?RAG6Q33+jutdB+pO2sneHDTUpcCEZ2AoG5U731ISTf8Sz2wMEntWmj77/ctR?=
 =?us-ascii?Q?bhSLsEmfdA=3D=3D?=
X-Exchange-RoutingPolicyChecked: SaypQhoWtfJtGWo+MrPngWgd5rs+0j7uuCc1WGs4J09yXORzA1/apOzjwHUZOTA9y0T29vWd+T7oLtr1IDDJxJYQVfBhuBtXpU6OHrUGAMODWMBqp1QNnONGStdpkZCoJZzhcSGvTzeZJhA6koVG+GKTvA6bhRlSvPkfGT8SanHVmY8S2nNZ5RNH9wTdquSFsPN0SfyVjaa3ORL06n/T1g9VmgYm6KZlMicHS2BG9dZsid2AfMZvymLdsNjhXZcY/f/LD+oOnewG9pVAPwzs8uRgYmVshJIkn2hYhz8TmzTVQI36RIU8GEx7/y9e4okXQyUOsy2fUcDZhaK0bVjxog==
X-MS-Exchange-CrossTenant-Network-Message-Id: d575840f-40cd-410c-22ee-08defce9d879
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 05:30:42.5099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2uMbkLULaqD+W0Vpn4NoBUO1gM8MThWFfvNU1zHssKcI9KU9cxdTH/Me4QNht6jsKPescGfe9BUPCVPPtQ2cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7775
X-OriginatorOrg: intel.com

On Mon, Aug 17, 2026 at 06:43:23AM -0700, Sean Christopherson wrote:
> On Mon, Aug 17, 2026, Yan Zhao wrote:
> > Sorry for the late reply!
> > 
> > On Tue, Aug 11, 2026 at 10:12:08AM -0700, Sean Christopherson wrote:
> > > On Tue, Aug 11, 2026, Yan Zhao wrote:
> > > > On Thu, Aug 06, 2026 at 02:40:50PM -0700, Sean Christopherson wrote:
> > > > > Harden the "map private PFN" flow against potentially-fatal bugs or future
> > > > > KVM changes by checking for a stale "fault" prior to actually mapping the
> > > > > PFN into the guest.  While it should be impossible for the "page fault" to
> > > > > become stale, the sanity check is cheap, whereas a broken assumption would
> > > > > have a high probability of leading to a guest-expoitable use-after-free.
> > > > > 
> > > > > Snapshot the invalidation sequence after acquiring mmu_lock to avoid false
> > > > > positives, even though doing so completely voids anys and all protection
> > > > > against unexpected invalidations.  Pretty much the entire point of
> > > > > kvm_tdp_mmu_map_private_pfn() is that it allows mapping a PFN that was
> > > > > gifted by the caller, i.e. the caller would have to mess up its one and
> > > > > only responsibility.
> > > > > 
> > > > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > > > ---
> > > > >  arch/x86/kvm/mmu/mmu.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > > 
> > > > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > > > index 379f570ef04f..76e3cd717324 100644
> > > > > --- a/arch/x86/kvm/mmu/mmu.c
> > > > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > > > @@ -5210,6 +5210,16 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> > > > >  		 */
> > > > >  		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
> > > > >  
> > > > > +		/*
> > > > > +		 * Snapshot the invalidation sequence counter after acquiring
> > > > > +		 * mmu_lock, as guest_memfd guarantees the validity of the pfn,
> > > > > +		 * i.e. any concurrent invalidations are guaranteed to be
> > > > > +		 * irrelevant.
> > > > > +		 */
> > > > > +		fault.mmu_seq = vcpu->kvm->mmu_invalidate_seq;
> > > > Could you explain more about the conditions under which a fault is stale while
> > > > guest_memfd guarantees the validity of the pfn?
> > > > 
> > > > Given that kvm_tdp_mmu_map_private_pfn() already asserts holding slots_lock and
> > > > invalidate_lock, I can't think of one. 
> > > 
> > > A non-guest_memfd mmu_notifier invalidation bumps mmu_invalidate_seq.  And because
> > > the range-based invalidation checks are deliberately coarse, in-flight invalidations
> > > could also trigger a false positive if GFNs N and N+2 are being invalidate, while
> > > kvm_tdp_mmu_map_private_pfn() is trying to map N+1.
> > Could updating fault.mmu_seq in each iteration cause a false negative?
> 
> Not really.  I mean, yes, technically it could, but I addressed this in changelog.
> 
>  : Snapshot the invalidation sequence after acquiring mmu_lock to avoid false
>  : positives, even though doing so completely voids anys and all protection
>  : against unexpected invalidations.  Pretty much the entire point of
>  : kvm_tdp_mmu_map_private_pfn() is that it allows mapping a PFN that was
>  : gifted by the caller, i.e. the caller would have to mess up its one and
>  : only responsibility.

Thanks for the explanation. I wasn't able to gather that meaning from this
paragraph before :)

> > I may be wrong, as I am unaware of the specific bugs or future changes you
> > mentioned below in 'defense-in-depth against bugs and against future changes'.
> > Could you elaborate a little more on those bugs or future changes?
> 
> There are non, AFAIK.  It's a statement saying "things may change at some point
> in the future".
I see.

> > > > If we add the sanity check because it's cheap, why don't we save
> > > > fault.mmu_seq before getting the pfn to guard against stale pfn as well?
> > > 
> > > Because as the changelog says, the whole point of this API is to provide a stable
> > > PFN.  I want to add an is_page_fault_stale() check as defense-in-depth against bugs,
> > Ok. So adding is_page_fault_stale() is not intended to ensure that a private PFN
> > is stable (i.e., not stale).
> > Any background on why we cannot update the code when the bug/future changes
> > actually arise? :)
> 
> Because finding bugs of this nature after they've been shipped to production isn't
> very fun.
Ok.
