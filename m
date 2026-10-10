Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D723D7FF;
	Sat, 10 Oct 2026 02:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599928; cv=fail; b=Ant5zS5E5TFKrOBnsw7Eg66K9CPOB40Sb/HA4cIwjsxxr5NlXxISaknb2XYWskmF7c8x2kAXMgimZowtbD0RNIinYYCuDiGNLjPcyYuCZFrpOgtSpaCXfAKwWcZWmVbKQbqldiw5/5Yg8XR4sVP63TT6IHbgOpwK/aEySKwQtL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599928; c=relaxed/simple;
	bh=U/5Rxl+YW2+DFhEzROAlAlV9ts9iqAlFSZnQpDrVND8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QsL4wKhcgwUqfd+WOJENMWFg1MZtQh0WQepViABjD/p1aGeId9QGdcSa+AowlLV82TKCub1/Dv751KM3w0zN1+ne08ON8SdCnGxrt+BATs6Y9lc4AxO/kgV0hkOOXqxCAVrY7jpw4fd3ElmhxzPgkDkMQIK5ecs9Fh4RiUYeTfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLMC9RrH; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLMC9RrH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791599927; x=1823135927;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=U/5Rxl+YW2+DFhEzROAlAlV9ts9iqAlFSZnQpDrVND8=;
  b=CLMC9RrHe+iStm2UhwEeX9FQSNrKfz7WmeoYNHUSI7tPyp9/faWIlETa
   hHBEzMZNalbGf9ZAwWDVp9H2eqY7wGFtgnJPLNmVx3+r0IY2lGufMIocQ
   +uHtcz61Ora2aEQEvI5/Jh8QGyZps9hegpvjTQ81gUBrsE8sBeFlSP4Qj
   T7qJC/YwnwFq11Ftl7Ag/vt6JljwuGc0+ovA0Yn6KI/K46VJXSURgkkyn
   Ge2qUx0lP+h+4/5+z+5LIRgDHPMqaClGLBFSjr6Rjvh6wnVV2kDCskBfi
   AsuADOBK+s09T5bpbwm1KegQUEgKsD5bahuqxnhVx/p96Axda5bh0dUMC
   g==;
X-CSE-ConnectionGUID: ozHwN4nvT5q5sP9Mt2U0gA==
X-CSE-MsgGUID: ean4COMZRkWhI8Gy9UIsww==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="393769"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="393769"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 19:38:46 -0700
X-CSE-ConnectionGUID: /+KlCqHqQ/ecY9Bt8oF76Q==
X-CSE-MsgGUID: 2rsuhjewT1mqRH9OvUtaRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="576434"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 19:38:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 19:38:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 19:38:45 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 19:38:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaJAtEN8uHWVTvL2MhgV65WvitIK4tSuISOQVAkBwHO1BpkweHBhtKClqLE0M++mAtUoqGLvcXQjWvor9v6NcsK3RnFyM00bT8S0uI9y8gAH9YkS684Twbj9MPz5DYVv+MZD7V7mT8c7FmRBEX8BGhn91dHKrrSFgwd3qDVpUU5KjYGqI5+590tCtSd7E0lraYiMWDKjywMwjhZ0SkGZ/bFqBKrk2JzP2WXUZCypypeDf4T/GGjzBMadqS+Apr+qRpbaFRLwuh0D7/r1vzEvv9yaunhwMDbbvEpHyRKsr1Gr8ZtKmhoylKPpxaHlxgM885IlfJkjo6Kx68kyInx3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwaUBiDE2Tr7A9Hvq5u30/ze+8EYBXgMmUP+/qT7/aI=;
 b=haDrPnfcg2gfZ1fBi07BM4J/2wJ2XO9csijCNe61po9pvP9aJHhu5VOKQdeHMw5fPHfourZf6Opfcmtm6mFOLkHspwsLrQKwWy3eoNGl+QnIMguwPxJ954TvJ0Iyidb8HkLrhE2w6EuotFgkrFd0KDPjtnqtuMq0rguKJyKQcGvkRB7ius0Qck0GenyIrU40NCbPo4YhDMviJ+kAcGlEbjq98q37L8Ykl/FqPpZ0cPaNTxYAsmD06fR+9cfWTu3/OPkBr9Ku/akpjtFkEkfVNQsVDzO+NVG4e7g/u63nYuDVSqDOLYDzIzlu7dXd3TmRZhAW7id7tqtbzEKMn390yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by LV8PR11MB8747.namprd11.prod.outlook.com (2603:10b6:408:206::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 02:38:42 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0496.017; Sat, 10 Oct 2026
 02:38:41 +0000
Date: Sat, 10 Oct 2026 10:37:54 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, James Houghton <jthoughton@google.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>, Ackerley Tng <ackerleytng@google.com>,
	Vishal Annapurve <vannapurve@google.com>, Sashiko Bot
	<sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 3/3] KVM: TDX: Ratelimit the "EPT Violation on pending
 acceptance page" warning
Message-ID: <asmlAodYOm2y9uRL@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260930001127.3170009-1-seanjc@google.com>
 <20260930001127.3170009-4-seanjc@google.com>
 <ascJReVNL2N4lJau@yzhao56-desk.sh.intel.com>
 <2036b58e-d2cb-4992-97d4-cb136bb0a387@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2036b58e-d2cb-4992-97d4-cb136bb0a387@linux.intel.com>
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|LV8PR11MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 4662859a-b73b-4a3e-4f67-08df26779897
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|261009223027099003|56012099006|11063799006|4143699003|5023799004|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: D1X1LdTjyD1ahKuxA9MII1JVH8mcZpCK9VfyjybJy21TYxzhWexmhwPit9rleqpuJQwyudp1S5wTfDGQHcGaC99Lz+YQsnQ1HPHrTljq+g+2ezUK+HAb82zWybnmTvC81Ev0Ys6DJzLBMR3tDDJq40y122FFZY9qX9Bi0GS6h2MYhTi33Kb/Ci82TrlQh3r+aU5s5i63bwvbcOuC94vmsrK76T3DtFIlAfP9RihICtdYo2q0LGTfhiovsuwOMJMGoAhf3CnD2xSg1doO11ouqHs08kWMuh8JlWz0NY/JbWvodd9lYAMe7mxn3AnUETwmun1VhS2089k5A60ZvNIQ2dw8WSOcf0MuWF5TyPTfRZz5hdXDY+Cm8tkfmg8EHEZQXzuKuGe0eTNI3RkRRpbcQOM7gURi2yAummP5uBf1T5NFwgoZ1qxonJ0tFKAUBuoIFnQzMx73qCNtII4XraaBsfz9uPJdhL/C8JFzJP9Y49tu9mz4RDiDgYPyr65cT/lqhEmbcXTzbqnEGyLPtb+WwN70aKoIev+wYGS6s6awajEsLAoMYWmkR/hhGm/ZjNEbIGwEDm0pwn/HCPF4BncNioqBz1zS+RB5Wr3eW/thIDkqpx0pr4lnMlPLfttYM9Wc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(261009223027099003)(56012099006)(11063799006)(4143699003)(5023799004)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oKODVp0z3Lhli9XGgxgmJxWrQi4UlLVU9cDrrZ+B+jZqY7a2SHMuxCnaLg7s?=
 =?us-ascii?Q?u5rgmhU4iQnGxezk5rSE/Skx5MjVcaRtAL/LFc95HmvPt0gKG3MZ4f4N7TeW?=
 =?us-ascii?Q?GEmcr7jOGdKc87W+c6yXbCqStKYJCDzLn2vRHqy7f5hK4PTA0QO2MnF0vCCk?=
 =?us-ascii?Q?oBvINsIp+qMiOvcCKFPyEscEh6+xbITuIk1DBbVJ4xQzPxsyoCkrbA/njmf9?=
 =?us-ascii?Q?7YCUed8Ub/xO8AkSwR8DzQO9Tsey52aEMoMQUcQmv8pHFcSpPUAnWka/B7xd?=
 =?us-ascii?Q?ze7dnGtX7eXCEB2skJlOBQ65UTjYfPQ+b9Zn0hQRYsXNTZxo32jjVyqyzlXz?=
 =?us-ascii?Q?Mjz+WEtdBDSU/RTP9/DFlIkZ/OmU3Ed43BJ8rVmSXAyq6HuSkQLIekNOPf16?=
 =?us-ascii?Q?kVDS2+1ZAIJyfoKu5U5exFUZsnp+j9kbLEwkCW/nnOZrjqLhbBll6uUwh+Kx?=
 =?us-ascii?Q?cfZKFO6aMcPj3KOFcfS/08YEUJTQNy6dr0MVyWzyAogBOjWzfAd8F00iuZ0Z?=
 =?us-ascii?Q?2JbjFcSDTToiwfsoUxOMiH0jLYfFwfD2qnvcgbiWzldbpTANAfOZPKGWJSO3?=
 =?us-ascii?Q?Au/GEZ3yd56DBV8WfJkZNoLDLYjmtkPHh0ZP8eOzxvL7TR1VkBipyEEt8G2t?=
 =?us-ascii?Q?etkSltO+4brT46udTgA/PA11oG7qz/YQpLexcvOdHuTBfr/PYsGtyphlM+82?=
 =?us-ascii?Q?q3cQf0qXLKSf7bFuf34y0IScRKwp+laYMZembr82MZ7vURw2uysERb8/gxgT?=
 =?us-ascii?Q?vUAHuTu2kFMWLY9Y6Q+BsUrwtFyn+9h3jci9xKL2arbNlm8Owhb4vGPzD/Zo?=
 =?us-ascii?Q?69u/PsofTlM17W+tE0K2SfSYBVrDAvrn/RHA5Od289xzO501DmqXupvGpxWW?=
 =?us-ascii?Q?SNCOzBacfbJskNoY9Wrzz/CN9dniGWbhWL1GLeoqkpBfkxGAo9lhfH390c7V?=
 =?us-ascii?Q?Gncky+1ZSkdxW87/bBFZ+X/h4YmIFTZYWgptEqcysczn7gsct/7TlB3QfTJF?=
 =?us-ascii?Q?wZ37bkphbRNF7W3zW8wrTVlbMHGH5q2G2IY96CylMvuN5l0tr49jpI9kJ5PC?=
 =?us-ascii?Q?Ie8tCkEn3wvkwsJvGC+iLnHhAUOp8CNRkD22Mxf9zrIoVhodhDT/DKswOK8L?=
 =?us-ascii?Q?ON7BS5sn67iGFJT1axCMxWFGVc3MNrCQN8CrAeeMWzHbR2NcAOPkbpiSSsfQ?=
 =?us-ascii?Q?IGObP4v64w9oCqT1i7UcrCHv7LWGP0OwdRmHBCalKzMAVZ4BWqqxE2kq+XxN?=
 =?us-ascii?Q?Ha/w4j8GCLZANliN59dOzpu+fyMoNuiRrlzcSYb4HjUMfNACd/vtrsMKgkbw?=
 =?us-ascii?Q?MX52VM4XQTdx1XX2csHDHok45IkHXr7Gt1NffxTw8Xf1fO/eCFNeQK+6soy8?=
 =?us-ascii?Q?nPLZ7phxjgQmlmYsneQcI0whK/1lrvHI9XOOMxclQ85shZ7rooRJ5sOu1n09?=
 =?us-ascii?Q?y6eeZh/VuwXW8lLJ3K+JllMMIJqVrRr5ZRJ80b1Tw8UTQDAE6p0vufSC5lYQ?=
 =?us-ascii?Q?NPg8Rh7zaXU+5v1pS8XGf8uIZupNPj8HnSSBat6fRNWDUWlfE0/LvxSwpKfK?=
 =?us-ascii?Q?PISwIxBld3lfjyUUdga3XcaA4Ku+CGiyr7uF0nmcjF0/1cOzGbfIVz6dDp3V?=
 =?us-ascii?Q?6yrsWwCvRK1LsWya6tiBFcvoNLR1sHwcWIgTMqXicqPqt9FjSAOmAtSSh1ya?=
 =?us-ascii?Q?N7obWyX7p+97ZkykC97juMHPCiQMpE0ZQRAZzWP8Sr8L1D43LKtzjI6SMcIV?=
 =?us-ascii?Q?2lNR0utGtw=3D=3D?=
X-Exchange-RoutingPolicyChecked: TklUUpivKHdsXufiMBHjGikHB8dbiuxrEAJI0CAJdfBsUn5GQpjUaPn9v2FLuDY2/rA7MRNNIQ1AuUeFsBWopPkB04qW4emsJdVxSaW2T5cwwkREXi8PIhNf0CI7ATPUi7cw5y4U2gi6oa45W8sxDDX+u4TYeEieR3E88KQEF73oyx/qHn1Rx7DYnAzHiA18rDLESwsGO7pzVyziDPm8c0ZuvIHDzm5C19adeqqJ883boB1iiSHGwOvIDn03gJqLtwhbqfOkyjm1VpSRtkWnoOpnsgXa7YdHgmV/WLULdmzr5Xl8/jtoH2TlRQlyJuM9oKpr9d0hkpG+Jy7bdAqpKA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4662859a-b73b-4a3e-4f67-08df26779897
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 02:38:41.7326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqEJlsa87MQ/qSNpNQ7EPweuD23msZSyLNldyCvVpCHJE1/nTo4F0aWtfKxE6Iq2B3xfbl5gz5o76yZRjjEBNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8747
X-OriginatorOrg: intel.com

On Thu, Oct 08, 2026 at 04:04:06PM +0800, Binbin Wu wrote:
> On 10/8/2026 11:08 AM, Yan Zhao wrote:
> > On Tue, Sep 29, 2026 at 05:11:27PM -0700, Sean Christopherson wrote:
> >> Ratelimit TDX's kernel logging when a guest accesses an unaccepted page and
> >> has opted to disable EPT Violation #VEs for unaccepted accesses, as the
> >> pr_warn() is trivial for a misbehaving userspace to trigger.
> > Since the pr_warn() is previously accompanied by a kvm_vm_dead(), which kicks
> > off all vCPUs and disallows re-entry, a misbehaving guest should not be able to
> > trigger pr_warn() more than once.
> > Or are you concerned about the pr_warn() being triggered by multiple misbehaving
> > guests? But would it be better to print for each guest?
> 
> Sashiko reported the issue due to the change introduced in the patch 2.
> 
>   Will this change allow a malicious or buggy userspace VMM to flood the host
>   kernel log?
> 
>   By replacing kvm_vm_dead() with KVM_REQ_TRIPLE_FAULT and returning 1, KVM
>   will clear the request during vcpu_enter_guest() and exit to userspace with
>   KVM_EXIT_SHUTDOWN. If the VMM ignores this exit and repeatedly calls KVM_RUN
>   without resetting the vCPU, KVM will immediately re-enter the guest.
> 
> In this case, is the Fixes tag pointing to e6a85781f783 needed?
Upon further reflection, in an extreme scenario where 100 vCPUs access the
unaccepted page simultaneously, pr_warn() could theoretically be invoked for
100 times.
So pr_warn_ratelimited() is still the better choice.

So, Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
> >> Fixes: e6a85781f783 ("KVM: TDX: Detect unexpected SEPT violations due to pending SPTEs")
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> >> Closes: https://lore.kernel.org/all/20260923164348.2DB2D1F000FF@smtp.kernel.org
> >> Signed-off-by: Sean Christopherson <seanjc@google.com>
> >> ---
> >>  arch/x86/kvm/vmx/tdx.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> >> index e3723f1222fc..4cac43299851 100644
> >> --- a/arch/x86/kvm/vmx/tdx.c
> >> +++ b/arch/x86/kvm/vmx/tdx.c
> >> @@ -1937,8 +1937,8 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
> >>  
> >>  	if (vt_is_tdx_private_gpa(vcpu->kvm, gpa)) {
> >>  		if (tdx_is_sept_violation_unexpected_pending(vcpu)) {
> >> -			pr_warn("Guest access before accepting 0x%llx on vCPU %d\n",
> >> -				gpa, vcpu->vcpu_id);
> >> +			pr_warn_ratelimited("Guest access before accepting 0x%llx on vCPU %d\n",
> >> +					    gpa, vcpu->vcpu_id);
> >>  			kvm_prepare_shutdown_exit(vcpu);
> >>  			return 0;
> >>  		}
> >> -- 
> >> 2.56.0.rc1.315.gc6ed9934b7-goog
> >>
> > 
> 
