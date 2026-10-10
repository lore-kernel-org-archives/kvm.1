Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE8F22F388;
	Sat, 10 Oct 2026 03:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602943; cv=fail; b=EBVnZDteoWBoLTL7hrXrTN4Ui/vhN8ES4/CL/j6owd4dI8BLRP+fcUhVYBeg0grvw84g6wPOTCWYOXyMyf/LrfMBnqO5Iwgkfys9cKN9zNxUIogtKCS0VmIQsdkoEKybFFoCF4dlaaVOwaeWjrHhIHfC0fWZxJwbpj6EjVpdvbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602943; c=relaxed/simple;
	bh=UJgvEuQfb0LI/tDTgPY4V01AMlEvXcmQ/1A7ZTvXkdU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y35QLUnS8/eL1lXN3vuwHtQ0mjfRcb8KChrGs7NSt74uNNV/JCC1LRx86DN1Mf1XglFkIyrZSBsWlqrBS2HI9YP2AftYkbT4U8HRr0SUc4mAeg6ZYA/ULLSE6JRe5/0JkZgtNzptuQ9YVtoJU/bYwO+nvy1f/8nVglbVn5VqqX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYod7yW9; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYod7yW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791602941; x=1823138941;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=UJgvEuQfb0LI/tDTgPY4V01AMlEvXcmQ/1A7ZTvXkdU=;
  b=lYod7yW9kIiwx/rAHCNzuK+fzFsz63sJck6bECs/pc8eB1ckkmgynSPc
   PcphUIodMqumUZIUoZ7952BC6SWGYqeJK0WMuE17vhdmvdTkoDVztrPPV
   cguNQp79IgB4fphrDiTJe1ZbfF1hDS/PLuhsUuv9Q5v2rjavnrqokau8O
   atbZzDc5o2kprugC2vw95zU9eDbkTknTj9MvkRsd86B3C7qbU7ciP5gJ0
   yYIOSWOH8qdX9JluKCtMRs8hqXLFn5h2CFsMQVwvFRPuOptFGKHoAqKt8
   lKsQQlNb95kwTjXZA6wdBhRjvZdvKlrD0oJ1cs7b2WbYrtCs8bRgwE2gO
   Q==;
X-CSE-ConnectionGUID: z7lAsfOVSGiwN7DFDqDwWA==
X-CSE-MsgGUID: KiVaxn8vRxGq43On5QWO4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="284710"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="284710"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 20:29:00 -0700
X-CSE-ConnectionGUID: /0mgZFLcRJiZxQU3zoKBUw==
X-CSE-MsgGUID: oPTOIidFTh6OHhftOmlqCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="583558"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 20:29:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 20:28:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 20:28:59 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 20:28:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=th0YUsVpMhmiuwkHMnZneLsE1IqWDzyEa/ARB+71up9nCleauonKfA8gZwP6oMQsX8BioM9SBif9nmhfGI/zkK/7vO6r1Qc0PqjnuuhO8DI2PpM4MnmMMpyWDtHGkkJGMVEmBAbq4OqrTASPejYPqBn47YJbHgvzT30xdcC/hlcV3ujUrYnuxfoiMeBbXid1BvxKDVUzUF47eiIkE4zwKrV9RsoLNOlaQx2Cb7mo7z0M+1fstpFKbmtEAovCI1km9UYhPAvLpwTgOmWrJAcsnBKPn8EAW4T9/sm1zF475YCYWvoQu0g2u4G8073owwQdDV/N3osmjcMknSKtZ/dYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2khdJ8avNTbp+01/jI2XVKxA7Yx8PoAxEegUY6nlks=;
 b=J1u+5jzHULTdlIGdv0a9h57RlPFlmR9RMBk6N8tFBjVaQ18ThAh4FDfKrviUb5nsoolBTghWnNAUtNerUDfNzDEw7LTnmUh181wg3QPf3HZuYMN5C0Ppq9R08fo7kURxdgTJZ9oapI3EyW3HEb74cFitmXVEKwar6hDnJuYUMFj21Gv8N+e1E1Q6RYx6Xxzj132NMWgo4FFRYhkaj6gxgZTHC0lT3FCTQ+3/DzE+Z2WY2/+exInqAjl6wCx5SENt1GPh/xIyPA8ERMbJB5rUYv01LhlIJZtnNN3gbalq8oHFKzhv5einq2ouqz1QOYf5zeqg92vJTDbwbh7zn+OB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3243.namprd11.prod.outlook.com (2603:10b6:5:e::19) by
 DS4PR11MB570107.namprd11.prod.outlook.com (2603:10b6:8:4f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 03:28:55 +0000
Received: from DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1]) by DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1%4]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 03:28:54 +0000
Date: Sat, 10 Oct 2026 11:28:08 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>, James Houghton
	<jthoughton@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Ackerley Tng <ackerleytng@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, Sashiko Bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 2/3] KVM: TDX: Synthesize SHUTDOWN instead of
 returning -EIO on unhandled EPT violation
Message-ID: <asmwyCYDyaLwfmCV@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260930001127.3170009-1-seanjc@google.com>
 <20260930001127.3170009-3-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930001127.3170009-3-seanjc@google.com>
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To DM6PR11MB3243.namprd11.prod.outlook.com
 (2603:10b6:5:e::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3243:EE_|DS4PR11MB570107:EE_
X-MS-Office365-Filtering-Correlation-Id: 598befaf-5214-4c07-d863-08df267e9c51
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|261009223027099003|22082099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: BYglIF4wqyPI2nejhL4o2TTKir2x8OVViElv3mW1mycX6ZTp2VTOXnbJViHqmtIDBACcLLuJOcYpoWoXjM9FEl9HgkvfQ97QwKa7eyIsziPSkirdmEMUuEZRoIb3z+6RcdoYliiNmuAib6c6ySIjJVM4nIXHLR3xg34D5BHFX9tTTFDChRV1bBsPTDAZdj5sJBnwQZSE3jn+xRvaBt5lvURgi/8SgL2uw2D9/+l3z7bAi60C6k4Ll4NVZN/sCqbEzLSCci2fz2AEGAuqzU0brF/SU213Ot4QIcD8f6zdtW1U3m4m2//Gc4o+raiQcoXEC4N2RHD/u++wuGhvLA/fANy+apNYD2n1/Qlt3dr/+dYYxpv6vr/Rq740qbG8X6gp3E8JRQOOdbNy5qZPSVBI8mtncIAaXz5x4J9IP1Ubf+IYV34gu+o7YI4i+MlaC3T/e1Hdz4KkhaXtTljJut53WFNhY9TIydaseGIQCGTZ5/mk777zrNHaR67aN00PnSAQhvyAhUIaAMriZlTh1vykcqsRaLnUKynF+9HFbbSD55LpMhlcLfJsAjUociiHCzfZlFlIBMV3Mu16JCcFwI4UwV0ZjL9zdbvV0GQRu8rhbJhQPsAJHp0GSwTDV/1lvz/1si7qNLehbmsW4LWpd5C7H6nJT4ziJo7WxELyBNIp9Ko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(261009223027099003)(22082099003)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A3xlAjpvR9ORLVvy3wj4i3mi+QerV7NzNn3r0F0rGUaYLaDdLSU1sk+MoEyf?=
 =?us-ascii?Q?Lwxff65L2w3DF83VKKeoE+sLLmUtRGVCn4ZwKd7dAWE71hBiY0o90eKkPz6K?=
 =?us-ascii?Q?IMSgET8X3hohs+SClzLyaff9DDWFSiMq//HbLrTHJGiCd291DTYUk6cyz2Lm?=
 =?us-ascii?Q?yFWsEtIpwYMAFbcbijO7jVaMixfgb1NAjBmkZiXl01ImgPrZo9bLKKoAPowK?=
 =?us-ascii?Q?0zmOjkqaPok5nT5YJik7ZB2icQgyOd3xL1lzfHd6XNoxW363yIHQUqvX1Sim?=
 =?us-ascii?Q?pecF3YLAWlnaBztOYeRLPWeSETqX0jt7lnOdG42RTL+ZKUqpddXUcfGnE6ya?=
 =?us-ascii?Q?EcnsRRIAnb2Idli44++8q2e82co8WP6HB+vntASpof4c0YuuhmfToOOjJBTy?=
 =?us-ascii?Q?LFl7pgdRNAU0/n0k5Zbp2+k9e8DNXgriEqXag1MX3O82r/bMYw7uDREv6HE1?=
 =?us-ascii?Q?oEovRdi/gfqhqEzvrotTV3KBxRZlo5iLl6WTYynJ2U8Q1+yjTXYsfqlOcFS4?=
 =?us-ascii?Q?6Hbc7z4K91glxSwEbUWbFXvPYOVIKVNFV3NidV73Z2feDETF5PoYgIylqe/0?=
 =?us-ascii?Q?ke8yopeXjKZNv+r7uZ6R5w/GvhWUfjZw3Uellpz16leLLqD+mZxsGEwIGC4D?=
 =?us-ascii?Q?1tFLxuXqEWUlqW/QGjMV/jwiqMT+TcGr6e34acCrBAEyW8zDvI9x1eBQAfDt?=
 =?us-ascii?Q?3LxBfD6HthkGPSs0SbbPjywPqjAUZ2TObXArWfj2oCnzLeeoWN+0eas7iLjI?=
 =?us-ascii?Q?J0PbflRWme3+qSRV4wJ25wWt0gWcq+YpL/Wg/HdSlEuEdG5QtMxAEqs6uOIE?=
 =?us-ascii?Q?+j+U6WgAb2qmzkWWy5YRgqtCxUZ9SkbS4M5l2OgLSoMlWqrrp6YZX7pUWm4m?=
 =?us-ascii?Q?iGbHmelqhXJ5Vs11qfpk/Aj67PjkvgFUPGW4JDBCq0NCAswislg5KBHZVB4u?=
 =?us-ascii?Q?dsV4LSzqzFKBVTbUrNLS2OHp65GQGj5j1gKt+375hBd522aHA99x+Jfl8Si8?=
 =?us-ascii?Q?nGS9amRY+rMQMvVlQwygT9adj+PLm7bW1BevgfPtJKt1r1gaM9A/55LmytPM?=
 =?us-ascii?Q?wi+DAJbAQWgDW2gJ0EjzRA6pqg4njVyJrIcFLUgKM8QIdzrW89K3uK7nS9Ip?=
 =?us-ascii?Q?PuHBVxfnr7ZztGkvjU+lYglN3zsFy3SbI5nhJxndG9mTZehrZIK6mHvMT5sQ?=
 =?us-ascii?Q?StQpWsv+g816kDyrSWIWrfklVscwIlRWUwLNoQ5WftNymqkNLJNY02FYnpua?=
 =?us-ascii?Q?61TXWoKbpWwSL7c+8850PuY4CsNiMIJYE0RJtpNJjMzSrtv7paj3T1RoYeod?=
 =?us-ascii?Q?wijjeYkippTl/gOiTcAWeYj6XXyyAxmOi9K/+o0a+vfuuNvINH3kJSP8R8rw?=
 =?us-ascii?Q?Xs3J18lmSWUIpiLvPFIM6Xv4J+DRflnujXi94O903Ne1bOWJzi2gcX5TmxNM?=
 =?us-ascii?Q?urqUs7QA1i6PjP35ahVpNwm9bqyKritpORJCmG9nr7bht3K6Xh4YWU/psOpg?=
 =?us-ascii?Q?m2ztWcKSoQv/hpnzpdFcZiymg0ZFABH5+q8eqGOdG12Qr34ZbL+duiQym4qP?=
 =?us-ascii?Q?h/QnHSLGDA+DhtKW90y7E2GdRRIQUKdZeRLOoIsvJO2slRAnrGPRxSTuBF0k?=
 =?us-ascii?Q?9XyO8UwXZfA+IZS9sx/fBy0ehET8WPbwwIwPGKMWczK+GcZSa9mKJBqS45Bf?=
 =?us-ascii?Q?P9QhQQ089gHzi7srIv7fQoMAQhBGiDCgslxYLiNduis74RG5uJPU9geGLvlD?=
 =?us-ascii?Q?9ZRNbBzlTQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: mzoI1B86VYZMrGRGC7h+xYCMma+9n6ebb/YZVHA1HOksQaVyUS4p5bnoONkXdX5XE5sZ9WowwEhJ/tMBT3wF6thot4u829pDqFn4PiTU2d4B8DkN8fED/9oDcXu0eXRpwewuU6SqcAR3CDFs31Yx/cAHlCFeOvfsCvq0e7dOXveonts+QusmWwlomgvGiW6S8t01Zr0BKlh/MGARv9YixR3RPl2mlNqpf0yQtlBY4VdIVAXB4c7v/A4MbvfanOjpqigNF0ulWHBAdU0iFX+nrnhzsng6Tux0meqG9ooAuUrRR/Qd9IRnlMlGqA7OAgHmai9JAjDnhPQNoSZydcWo8g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 598befaf-5214-4c07-d863-08df267e9c51
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 03:28:54.2475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qHEse+t02z+OuLS1J55vywbQYoMTwVnkc2yH5iYQmrOibRyT5c4UQABdAopHQrhNdf86iplQZ5PtbqztA4jiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB570107
X-OriginatorOrg: intel.com

On Tue, Sep 29, 2026 at 05:11:26PM -0700, Sean Christopherson wrote:
> Exit to userspace with KVM_EXIT_SHUTDOWN instead of returning -EIO from
> KVM_RUN if KVM encounters an EPT Violation due to a guest access to a
> pending page.  Returning -EIO implies KVM is buggy, and most VMMs will
> respond by completely terminating the VM, versus rebooting the VM in
> response to KVM_EXIT_SHUTDOWN.  I.e. give the VMM the option of trying to
> keep the VM (from the end user's perspective) alive.
> 
> Ideally, KVM would probably exit with KVM_EXIT_MEMORY_FAULT, but KVM would
> need to extend run->memory_fault so that userspace knows the fault can't be
> handled.  This scenario specifically occurs when the guest has deliberately
> disabled #VEs on unaccepted memory for security purposes, i.e. the guest
> literally disabled the mechanism that tells it it screwed up.  But, because
> this is fatal, and the whole point is to NOT try to fixup the fault,
> jumping through hoops to return MEMORY_FAULT instead of SHUTDOWN doesn't
> make a whole lot of sense.
> 
> Don't bother bouncing through KVM_REQ_TRIPLE_FAULT as
> tdx_handle_ept_violation() is a top-level exit handler, i.e. there is no
> need to worry about failing to actually exit to userspace.
> 
> Fixes: e6a85781f783 ("KVM: TDX: Detect unexpected SEPT violations due to pending SPTEs")
> Cc: stable@vger.kernel.org
> Cc: James Houghton <jthoughton@google.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Cc: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/tdx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 29d4751f37fb..e3723f1222fc 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1939,8 +1939,8 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
>  		if (tdx_is_sept_violation_unexpected_pending(vcpu)) {
>  			pr_warn("Guest access before accepting 0x%llx on vCPU %d\n",
>  				gpa, vcpu->vcpu_id);
> -			kvm_vm_dead(vcpu->kvm);
> -			return -EIO;
> +			kvm_prepare_shutdown_exit(vcpu);
Would it be better to exit with the reason KVM_EXIT_SYSTEM_EVENT and type
KVM_SYSTEM_EVENT_SHUTDOWN or KVM_SYSTEM_EVENT_TDX_FATAL?
By defining a specific flag (e.g., KVM_SYSTEM_EVENT_FLAG_TDX_UNEXPECTED_PENDING),
we can stuff necessary info like gpa, vcpu->vcpu_id into data, so both pr_warn()
and pr_warn_ratelimited() can be dropped.

> +			return 0;
>  		}
>  		/*
>  		 * Always treat SEPT violations as write faults.  Ignore the
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
