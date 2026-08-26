Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C24B3B71DB;
	Wed, 26 Aug 2026 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733138; cv=fail; b=VBbsqC5X3lCu4hAnvmJpa46JcnvpHEDzBfMECjco1umq0uyNdcmqtsvi+SmZJLl2uWlyR84kSa1I7UA64kV7/p+3/lDq4cZImeevc6vGpF7dLNNo+Naq7SpV0pz3XasERaiIqMJ4d3XDEdFJVuhAH0LHRXwhOeGj2l7yd+hHzXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733138; c=relaxed/simple;
	bh=NGemC1q6zVkWlZBKCs64Qjcbg1tPwjL0t6J/W9dUsqA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X/MVAAchsfEE2eE1SErKW35MWs0PP4sN9RIvu6upgcf4wazQpinTfnBd+LPBY3bcX7tb9pqUFRklvOVMBih4JCrB2TnimiRq8SimEjacWPMua1PPZGkAyu6Eztd+SAsM+Zr81RC82tk0fo1eTwWMGOB1lkjnrn7EWoGpFxuZU3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IybTnH5z; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IybTnH5z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787733136; x=1819269136;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NGemC1q6zVkWlZBKCs64Qjcbg1tPwjL0t6J/W9dUsqA=;
  b=IybTnH5zBDms01Sueiby6/hf1L9A6yj4fQtncf0rUN6eL0c6+wt2bhLi
   QN7aeDLzH0+ZySgQatche0mEb4RXZN0QfXonnsEevq9W0L2gwIFTpzba6
   MqZ1MkGKNcZ7EMlslTyKTgNxm7RfEpyRgW8k7Vf+PjZqpZeOIUbMz871r
   GY4bX0Ravj725SOTrj0L3/IiAbpFTlbOBlJxqPAXC1wlJfevlcvOSvzrK
   aQgPpbd2quZtYesf0xQSRf6MURTN5l9V8eRLSkj3pdnhh4jhZsAp9OOQZ
   mbhnFgHxffZSv9N23YI6ab9CvGa1HJ7h0fzr3eg65pHAsCpm+uKKlo+II
   w==;
X-CSE-ConnectionGUID: i/2hQDlbQKCWbIFAIB+yAA==
X-CSE-MsgGUID: fE99p5lmRjGb3z02q1nrGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="92026581"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="92026581"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 01:32:15 -0700
X-CSE-ConnectionGUID: EHrBy+dSTj6pME2DGV0Phg==
X-CSE-MsgGUID: +QaUeF+DR3uxqAJ3fR8VMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="269465844"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 01:32:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 01:32:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 01:32:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 01:32:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdDImKV6NGsa242OwLPM3DO2W7LINwOxrk4BgIrsvHYDCyyh0eslsd7P2vxRgM9CmJBgf9tVKz5/RkN0U2HNCBEfH4pu5gIN+rWt+jxt+EI/42eO8r+B9jgZOloxkso9SwtDEHes097U91FLq5N6Nbd1WacliM2RyxoLN4iEHu39wJRjB2UkgO4uZ2nZAQuXYEQGejGc4nmYrdIv3wcHlP9eXRSh0sLufcTJr8mPHBvWf8WwJiUR9XNYKy6juODvmXl+dj+Zul6drfh5gSkbVecXW7E5F/IL6rSjCsmDEiQ86SUe1p2bQSc1IgpB1Z9ULkqyxA+2QUIvNTq8yWwlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/B91HlqCuC45mLSjz89z98Yvgc34f8xraaOj58D+II=;
 b=UGa0tbVbm8D8nYBVAEt82cws1Gq5FFLFXuIRofoHIGmNXAV/Yh7Raf8dqGsk43evBcsAjOfmksTmC+eOLKgBXF1S1e/5PdZsTN36I9iHuxFuAuJ599yUHCs43VO5usvAFWv6kzwrZZrigVyjZY5xxUEqATqxxi09Ha4YduSbv6GnoXfaCucH+0kNmIvCD+mXMnIqaIvpoD33oJf3KTMcKi0m2+QA8jtd9zvUcuNlWl5FPUv0MpYUQBotUi2hZz8/XmYhvIyijTNR3i1l6Q8N/EN5XtFhbYw8IzM+l/V8qjrzZLgj0e+9ErCr2z3gHKGQCSSgt0ufTltNsX+LXRKEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by LV2PR11MB227099.namprd11.prod.outlook.com
 (2603:10b6:408:412::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Wed, 26 Aug
 2026 08:31:59 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 08:31:58 +0000
Date: Wed, 26 Aug 2026 01:31:55 -0700
From: Peter Fang <peter.fang@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Ackerley Tng <ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>,
	Ira Weiny <ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang
	<runanwang@google.com>, Ryan Afranji <afranji@google.com>, Sagi Shahar
	<sagis@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds
	<jmcrey@google.com>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v14 10/22] KVM: selftests: Set up TDX boot code region
Message-ID: <20260826083155.GD3694338@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-10-15ad654a50db@google.com>
 <20260824192702.GA3694338@pedri>
 <aoyi4nhWkhFrlIfs@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aoyi4nhWkhFrlIfs@google.com>
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|LV2PR11MB227099:EE_
X-MS-Office365-Filtering-Correlation-Id: 846867ae-42ac-4b55-8dc2-08df034c7e65
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|3023799007|56012099006|4143699003|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: m3I7QYREt3ETS0m48AKlYVuKS/HuaaKlY/pPEZgsU8J60kdDvJRvV37igbjoveU/gGDW8ZhJ3YjaJOaYyjxOXAKUBEaF3IwTQ55vjV+Zh8P+3FnOzLhBP4VnCWBQw0MUokReK8gOtPWLIpBDZcAUj6l2ajhyGvd01l8QlhjSgVyZPd9ZSJL1odDY04l1crHUmXe9Wb7ZwufPwdHcm3wHpsX/WbYo7Qp+lCMNQoJycDBQH3kKzAYMM8WXzIQ+zWV1JANhTv2w412kZZ6E+RNKiZigKKxJQlW318hKOC+ydpXm/JI3My6tDkAqMOiDnQg2xVNKpIaCk5/iQSWnrpfdU/tYamkV113Bzn7Ou8xhK/40sPlkPGOSI6XHQyP+FAu8ZteouegRKp56qLJcLHfyPeYxcN732h199LX6kOoW1y/VTnqxYU1Dud346frnu7RPjbd7moiH4MaeQ9S4ZuoBbd+Y5PoLnDLb5nS5NvI/MnB8lmrLNFs7lclzt9JyrReOtMG+QAxN3rYOC4V8PZptgz7UabRGyog7xknqOvK5HdJsb2keZoCdYop1bGP1h22rh5w6fG0pxUvOkAAgvbcq8Jmch/2LA+mpDzbuNSgSH2SW+l+Yexbducm7eiaRVlrz9yyKj+XFZR/1aaUKh6R12ZfKfzVEDllQ/Y+v42Zk7ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(3023799007)(56012099006)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lY6TS5eMDgx9eAMYWob6fkzQleRJs3mJ+nRuHDBuMiNRS3wpF7nDp/PWvP3q?=
 =?us-ascii?Q?7N4gGCUXPyAVuDo7TDT/5KBA8E0+3mHNhLXgOpLYI0fEo+YcvfzTLv5LDPZ3?=
 =?us-ascii?Q?WJ6/8YV2xz/Pd5HWx6tIhe+SC3pPkW9UjCq8oe8Kl83rGIGhzRRe4VT+gW2R?=
 =?us-ascii?Q?zrGK1IZcPnvJ9NthVK6GzVaNwv3lJ7yjuf1YThlmjJItvXErz4XIhhc4JHrL?=
 =?us-ascii?Q?BCNfZHTHdODqrxcJ3H2G4THDFboRnMvedY7uO5Uk+B0FnbwJ0actehdvXv+U?=
 =?us-ascii?Q?NtwyL/xdpQSjfGLhIGkukfuqEENJ8dzad6pQ8zcNgZAHpAdicj20u8pTz4uQ?=
 =?us-ascii?Q?AyYRctSz3l2b1MpXOD+fvihzxCiuuxmxb5y/lQ4Ut4d6DccyF2aCcEBLlxwl?=
 =?us-ascii?Q?8qJWkatTvTybcuoXEmR5GbNyGTKOAJW+oqSlBG5TtZpKpsh5KSJHuMtup1D5?=
 =?us-ascii?Q?Hriv/ChdbmIqjgDPPy/zq5y+NF40gfwnhDHzeLUA76QBYku+1WB6CsUUgFT7?=
 =?us-ascii?Q?OD06GdAc+pKVW/NfUZPTrbFuGDldOEO3iiHtYhgWxhbckgtxwYpwiMZrtFO1?=
 =?us-ascii?Q?GJrUy3oUfs6JU2ejJbfhGweJKepIf5czpQk3P5MEBUJA9I4VCo72B2at4REI?=
 =?us-ascii?Q?XR+A9ii0hrwQcB4V2j/YwcbF8nZBinzaH4fgabxps/qBTtJCMs+y2R++/c1P?=
 =?us-ascii?Q?8Rww/X75th8ipUgf+cUW/eIxDo2nuXxkdxKTRIm/+86sIP30nedLFSCnYHmZ?=
 =?us-ascii?Q?eRudbt8ZdGay9Yf6h+X71wLM9f/pIBVHh02jiWN0l4PqZ1Y5keYkbvXbWGp1?=
 =?us-ascii?Q?IbzGFl5n2t0GCg4vnA08OWVrj6+YsI/yJD4bYwSNrNkf9Bz0djCy53NPKLu0?=
 =?us-ascii?Q?laASGIuSCZnFsTZeLOKcE3GDYDXK2YLCgvVG0ZkhYBJVNRHR3EpaNJkhJxi+?=
 =?us-ascii?Q?5apBJcCrNWX9anZ13UzLNwtCkjjtStCluqtHreKT7ZG7hCys7T14s7zymACB?=
 =?us-ascii?Q?z6oR9e+KrYg9XKJNisdDMXVCe5wW9SWPOwMUzJH24WQretZopAhY1XrXAL4m?=
 =?us-ascii?Q?E3ozj0SqfDssHQcGgCYOIqPQ+OWmVB0Ph5V0q+s80TkkLtUTz+8TPhYR+NEP?=
 =?us-ascii?Q?ot4deBVncElJiPuLVTOmxGHTN0/O+JoEjNTmky5Qri4s+E24KuUH2Y322f5d?=
 =?us-ascii?Q?jvHsdRPoTe8o537OMEODOghLHZ4+AFNIMd2iECLUXlDZYm7ZJ5elkPNjhKRX?=
 =?us-ascii?Q?TKFBdL4zXkaEaunejuKBSbP/UnQ5D+ngMREOLNbB/c0SWQKhjcszMHZxlUif?=
 =?us-ascii?Q?WQpLF34BvofuB8Mh3INHXhHi5st4q1s/WS0kashg54EYflK+J4779zfS0sDz?=
 =?us-ascii?Q?/YU+LCauLJTV2tAmhL+jCwFUyCJeA/Sq4iFye7/Gkx8AP/93WWtcVTA471yq?=
 =?us-ascii?Q?gOmUndMciAwQ3k5wTc1/cW7csrNKilZgDRL25pMpmfP6H09bMkm2y9ccu+qG?=
 =?us-ascii?Q?86N9zg/eEHUoyyK23yHA983SxeHkAOTllwMhfO9YH14PPXVysgT+v5b5lIPM?=
 =?us-ascii?Q?WlZMxM40Zte60rAdmpWPZBgiWovkK0Uur4VrdWzHmSGaCadofAXZJLF9To/U?=
 =?us-ascii?Q?GVFuOtWQCGADGVaG+1sMPD88THmH7rAEv3gXydiUBrhql1v/pUosGdehlD2b?=
 =?us-ascii?Q?RNulTm6FUWxOP1UTAE+M1tw2C896hCK7KRiITMkrXgKIYuosb/rQQr5rFQOn?=
 =?us-ascii?Q?hj3EQ7sugw=3D=3D?=
X-Exchange-RoutingPolicyChecked: at6nhT7gVSWnzw271zrK/gI6LGXAf6b2VGXft+QLluw2sXFWP475604WOn7psrz8fR5lpa0VhLr734q6bX3CQFci6YE+ZKaaeStGL7k4NTLT48uvPoXg9Tm4NH/plI3+8MLyn9BJ9b6JyuEwhl9P+B5qB5ZsWgdZWWgvx52xU3JEFz1MPy5cKq7sYui+rdlMXqrEm1j1q4TN5xdBtfsH9oHrAIPejzWfn1W9JDNuDi76GfdoN18VE9WRidN8yJz8en2JWux6eFuyZ/T0MieJRzZViilyaNlxCUX1FLonkBXpyvq9ZAhnIhm1HpuQxcAQHqUSESyHt5gD+/+SPKWa/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 846867ae-42ac-4b55-8dc2-08df034c7e65
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:31:58.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8V/sIGYu/unizqot4An4ot6DIfLeMF+cc/CyIEQDeFhPt7b6YeqgpayK/Cu2r43xAywLvuXMW5XmnHCsBYqiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB227099
X-OriginatorOrg: intel.com

On Mon, Aug 24, 2026 at 01:00:34PM -0700, Sean Christopherson wrote:
> 
> Ya, looking at this with fresh eyes, AFAICT there's no reason to handcode anything,
> it's just basic arithmetic.
> 
> Side topic, this series doesn't compile for me, so the below isn't even properly
> compile-tested (I hacked in arbitrary literals to get past the undefined references).
> 
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:26:(.text+0xf): undefined reference to `TD_BOOT_PARAMETERS_PER_VCPU'
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:30:(.text+0x17): undefined reference to `TD_PER_VCPU_PARAMETERS_ESP_GVA'
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:33:(.text+0x1d): undefined reference to `TD_BOOT_PARAMETERS_GDT'
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:37:(.text+0x26): undefined reference to `TD_BOOT_PARAMETERS_IDT'
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:44:(.text+0x2f): undefined reference to `TD_BOOT_PARAMETERS_CR4'
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:46:(.text+0x38): undefined reference to `TD_BOOT_PARAMETERS_CR3'
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:48:(.text+0x41): undefined reference to `TD_BOOT_PARAMETERS_CR0'
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:54:(.text+0x51): undefined reference to `TD_PER_VCPU_PARAMETERS_GUEST_CODE'
> 
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> index 89cf6c3485be..439d6f10489e 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h

Thanks Sean! This diff is pretty much what I had in mind. Just one
comment below...

> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index 831b0e5160df..170354dcdb66 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -15,10 +15,11 @@
>  
>  void tdx_vm_setup_boot_code_region(struct kvm_vm *vm)
>  {
> -	size_t total_code_size = TD_BOOT_CODE_SIZE + X86_RESET_VECTOR_SIZE;
> -	gpa_t boot_code_gpa = X86_RESET_VECTOR - TD_BOOT_CODE_SIZE;
> +	const size_t total_size = td_boot_code_end - td_boot;
> +	const size_t boot_code_size = td_boot_reset_vector_trampoline - td_boot;
> +	const gpa_t boot_code_gpa = X86_RESET_VECTOR - boot_code_size;
>  	gpa_t alloc_gpa = round_down(boot_code_gpa, PAGE_SIZE);
> -	size_t nr_pages = DIV_ROUND_UP(total_code_size, PAGE_SIZE);
> +	size_t nr_pages = DIV_ROUND_UP(total_size, PAGE_SIZE);

td_boot_code_end and td_boot could both be non-page-aligned, so instead
this can be:

        size_t nr_pages = (SZ_4G - alloc_gpa) / PAGE_SIZE;

>  	u64 gmem_flags = 0;
>  	gpa_t gpa;
>  	u8 *hva;
