Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027242903B;
	Thu, 24 Sep 2026 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241758; cv=fail; b=ZNdNaM4SwNj5uvBbjHWAUZ1hA99bgwolu7uXa+itH9UYiQk76d8jpmZKA4cB3mN26ulsFdCJr4ej9b+ZAU27NUT9S8t9aTFZRHO6qWemBrkqtVkICL1EXfTiHEuYoqlB/05hexrLiN7/CYF8HhVyYy0wIonbzpTDZUlUiB+RkSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241758; c=relaxed/simple;
	bh=LHpUSNv7mUQpi8ChUes7kZEwSAdfsw3Gfk8OlpDQsyg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vCFAMmrgOtTter7pKAT5TwmEH2mZL0adR5m0IARb2equTjAqa6EAyVifqdTtrMVIChoAgs653HlMEFLn0lUvKv+hUVH/WOHl1Tg4wjW75RX2zRMM7s2iiNGA1RqixdepgQbC3kiGrkBSJG0hzrRNky+YEYx3KEpzuhldX6Xpj/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OpTlj6mi; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OpTlj6mi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790241755; x=1821777755;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=LHpUSNv7mUQpi8ChUes7kZEwSAdfsw3Gfk8OlpDQsyg=;
  b=OpTlj6miLC1guABEVIX41lnoZyYovBSxja6ESy4vD2HY1lbiPXrDAWC0
   pwX2LU+PhwTXZpUPyT+CdrGwfbBAhq99IMpguZR+fxhsiqbjumn0OLCgx
   +tCN+LNGiJtPM0GSy7aHH03FAKL2scXWFD590I/SUeH/miq/liw14r0rn
   E2t5qQA5xe3SMXvqGLOC0siDGNHByflrl36Yl0aiH9zGSyuM0RJSGcAoT
   gk12knHjFY5GueWTn+NCv7AYWHwotAqHKxHv7KBIsEATZy8aH6RcVbFir
   tPsb1OhrcDRwmytl3jYFBJeLWOSN9Ksydex+8x1oEpUaQRiXANSBeRjNa
   Q==;
X-CSE-ConnectionGUID: QucbRAnhTZ2rk+ER00y92A==
X-CSE-MsgGUID: gXNbTwnBSFiqiAr6ybVdXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="107391675"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="107391675"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 02:22:32 -0700
X-CSE-ConnectionGUID: Ug2QXdCvTjCBfvaJUxeP7A==
X-CSE-MsgGUID: E+A6ct+/QZGlEeTth2lerw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="277136484"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 02:22:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 02:22:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 02:22:31 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 02:22:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL/UkLRIz8QaQeqsBv+mcLs1ISB4P/WhaQyUPV8T5FLOdYwK8E0de5xooiFZtsijeGDbatfTXraBPUQ+htUwQ0NrheNd1/FMBR8HzGJm5WOpQfbdv2YXx3scnttrhD7OUKAlNQ9Thij6tNy4MQc6+T0z3jmhM/NT1IVJivIVQUvnRH+P3OOfwnh7fBgjk4j/dzy0MOtRBrZfNSOrzsHrX3Swcd41bvf/ZU2hIg+gwu/GMyNwp7FOuffv8yYNzhc0VpylpaPKJcA8vc92Z8UCUK57F31h/Ed9yLxa6I6OdqfcLNkDlFr/gbPmuokHCOrDdKKLiFs+Kc2SxecY2UZmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQSaE+kWt5zJxAvYokS6LRe6DXS5tPL5NmvO8YGCdMY=;
 b=n3Wt2SA1DkuoDFNUxlyqWRc/WLK1oI8TtqqXpnME6SXKEYpAXNIFpzM+98bmi/jZZyZkq+kz0EAlnJIKJZexmj4NUAYsE/3LdGtFt8B6Bxk/G0dALys6YUWnp9mgLrGT4kVqgF4dmDGr6L0zvClUb2cjCUDDI7RktMmgpE/RL4UEPWv0khnRpbJbD2tZCXuYipBzWgRVfF42JogUxeQ/+FBa1Wm94i5U0yNQI1m1VZ2vtGlm9yIDqnJH4V8dwynipp8kjQFgQJAc8EiZ/eRs//1lFrm6vWP+VVVd+FMtX3+GQJtzo5gvMVmPBItzGhJbRVqxdDt3klNemoKKIwkmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by DS0PR11MB7903.namprd11.prod.outlook.com (2603:10b6:8:f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 09:22:28 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 09:22:28 +0000
Date: Thu, 24 Sep 2026 17:21:53 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Stefan Teodorescu
	<fane@google.com>, Dennis Tighe <dtighe@google.com>, Sashiko Bot
	<sashiko-bot@kernel.org>, Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH v5 6/6] KVM: guest_memfd: Drop superfluous WRITE_ONCE()
 when binding a memslot
Message-ID: <arTrsZGayO7U0Jjv@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260922001332.1121266-1-seanjc@google.com>
 <20260922001332.1121266-7-seanjc@google.com>
 <arJsKA8MkSdpQxNm@yzhao56-desk.sh.intel.com>
 <arKG2UnTWySdOAkc@google.com>
 <arNa66B3tmJc7Kbd@yzhao56-desk.sh.intel.com>
 <arPhfHnMNbvthwGu@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <arPhfHnMNbvthwGu@google.com>
X-ClientProxiedBy: TY4PR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:405:372::17) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|DS0PR11MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: c41e8852-b7a2-4679-01ce-08df1a1d5a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|11063799006|6133799003|10067099003|56012099006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4e9wRHqnGRn6YYwcymlZt2Sn8Fpdbxn/lIpv2nDXxy67nKidMqZefZIoSgjVJQAOGgPDeg0d5ekRtixbrH7ilr2TTcmCA4YKTOXRaKwkyNuorSmJPfqPIlJKZMlmozCL7//ZpU+DGDBIjnYEUnfyo/4bpNuWFu8Cp4XPOtcHBvUBZbhUQil6UGhCS8P/7tj/C41Xk9M93WpPaRjulN5Jbt4w66Yosz6X6zQo45sdV9p9GV8x9WD85iMLqbz/8lhxqj7T6Ys+1b0WUE1GDulaOMJn5Cg5iT2V8sHxfzOTAdnam2lo2JsOxAuwiPu7kJTnxC2rlAFJ/dhekA40mY/a3q50aG3stBlT7X/EBkKQEbOHwB6Dl90valz0V4tI0z20SUhbckZuz+s7V3z5WpLwMNqt3na/xioSgGyktcFC59ISqwOd1A4G8880bs04+ja39MxnydFbibItV383aPf2wTZYEIOcRoLp8waUX6qu8CMdsPF5hKbNy8oGAepkTninQ5JlFKIiIKIZkbMEKQX94nwx4qSEGGFYC0AaGY0YfsoXn+MkLXJMlU+uWkEiE9yUiI/6RVgDDBTDEIo3MfWDgZAktO1M1TMajigE3uEjem94ujEp3bLeKr9624MAvM9bXKFUeBsT2XomoMBLlWxoMyk6En+Klnu8OqpkD1fZ8dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(6133799003)(10067099003)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FVqBDmPCyM9CEq2gTdFVvqHh2nBsXzYLiEp8f9KIUxVjIfWEEPMq9Hq8PAgy?=
 =?us-ascii?Q?wdi6c+xnVZVg7Tk78Xi42/KZclHiQELDYU6z+4NCipQBehbqk/WrvsXzVN+Q?=
 =?us-ascii?Q?B9chTmrfn5ezAmMKNJhsfdxEA0r77Q2RWbTHNGa6aShhOrUlzaJwkQ1McumA?=
 =?us-ascii?Q?PWNE1tmhMtFOJKkvTEoXqsD67ISuz5VPjAHzD3Q2iFTkTzNzd4qhA8F7Uy+6?=
 =?us-ascii?Q?BLZMVXI12YvAD+ZT5/jI2KYVby6gmaDcD1BtDpGofAslBkTJFbx8r+8JAiJj?=
 =?us-ascii?Q?d7kVPalziDsxXb7n5Ff2iMoLW/txlKPXkcu8qO7z9qidmvwqmLL9LLMW3UhZ?=
 =?us-ascii?Q?yinYBWFuLf9LPBq4MJZ40jn7C7pLLuwnNT4nCZNpQTjEXNeS/OyhB59Aqms1?=
 =?us-ascii?Q?lQOX4/jH12tETEX4v55rbgkqouS1Boe2ioF2DJOH9oSjfy3u04d2g500eyId?=
 =?us-ascii?Q?pykbHx6bi5w7Ur8zxztH64sJpJ/YnFPyEAWd9nBS+RXJX+rrEGlKMa9XXmdj?=
 =?us-ascii?Q?luK5NHeZFGpytVwsnI94PtJfQpM4Ly1x4yOi4OVARuttFxyns4Zh9vJnIaom?=
 =?us-ascii?Q?t6mlzt09kpgXvYX+GOKQ7ecKjGRkyPT5l94BfTCIg2ks+fCJApo5ifeIPMZd?=
 =?us-ascii?Q?VEMtaemv4STYaePd1JuFTEYdI+CXUoxW7pCYTMlqUwPF/p8SfS9PtjezhOO5?=
 =?us-ascii?Q?Daqkl5AE208a5SEYE+W75qYjmv3gpj/g1Vucd0HN/TbkBTvXX0YlOf2m0M4i?=
 =?us-ascii?Q?yu810WhwVpqt/eNc1I0KxmYKQhyNBP+IP3ngJQNUcWfYK5ehvS6ZgUV5YbYr?=
 =?us-ascii?Q?2vw6bLQFxyv9Pcz7v3KB9ZYBJlQ4dz96xsN5vGI3FuL8yPExTCPOzzHomi+0?=
 =?us-ascii?Q?ps3kSE4w6k7kG0C94btP6v2ENq3Za64RrVmk3pb9LxGBpKqQSmFcavZbtcMh?=
 =?us-ascii?Q?ZnYAy5rZjRjATqkipcaT9g+VrPc3gQpr38grGCY8bxhoj59zXIJfmqirIJ2u?=
 =?us-ascii?Q?iyG9jYEOntPHWu/y5iF11t9CvSULpvhDAa6cuIwH5EZ6LWDg7k+juHHoRLpO?=
 =?us-ascii?Q?geuWdeglFAnwhkS+KpkT5aZivx+HD1mjUWsq/79/Fd/WZuk110QJBYmZQ7GI?=
 =?us-ascii?Q?lo0HJJDPrrFlVvM3Rq2g2XqZTPpucQZf+PBVFYzol146xjmDkf1X9wLjISNo?=
 =?us-ascii?Q?MlQiSNvRwsqdMeYbZ/lRCam/Lj8UuXq3Qir1nfyp35lKKk2HqIWUSFgWpT5B?=
 =?us-ascii?Q?qqR6QmobyESAY28+8FuDvWHwk3xZYmO85uV5nug5IxjV+yfcnulLe/8UZNAy?=
 =?us-ascii?Q?8sBDu/SSzo94LJ+hGkfGe4CsW1Pu9kurjGyqAiwsl0nTDMi93jecJYBG5qUC?=
 =?us-ascii?Q?LtFMuvyzH3XuVdiyPt1PPCcR5a3cildHUs4rK5e6w9EayHFCjPj0gdwkYtE/?=
 =?us-ascii?Q?qKPMgSnFlenPAeWnqQkRU0h710CVAe0IcxVvnwxPWTSwsYyaaj+04d/nEPVu?=
 =?us-ascii?Q?ButjdvHYEB7yZqcM5ImFAhVa82rWrX3vCWDU05sCldRAoHQDty6siuzrew0q?=
 =?us-ascii?Q?breg/Yn7mBjpwHTD3t95+51iAqsgOiJaD9++TQkp2WLN0QiLus/3qBP5Qpoz?=
 =?us-ascii?Q?3uEKFzV6SDDHLhzoVDmjF08TlYT/Nl6xHAo9x6XmHYYyFpgF1mGa2LB248Sh?=
 =?us-ascii?Q?/JqhfdhhZb0zX55iLPqrUqYsxD/CU2f6Z8XfxA24mDaiTgaCQeHEjb2SlbEV?=
 =?us-ascii?Q?chHUGt9mzw=3D=3D?=
X-Exchange-RoutingPolicyChecked: ljY1HywyXlghvYKHJGC6Usiz9Bxhbj+zhB5nZM4zplZ+MSnoG3XR1NcNo9nhat/GAhUIBm50VyaYOpqXFNAGdDXHZUmTbSgetJsf44iCJKztElLr0sTmP+tCORc/CjUbVrydiVH8F3ROnhLBzgNtBm5n/xM8oQA318gz1Qmupq8RSIqeAGF78u3ZngkgZsOKu0FgvxY/zgvcyPqfTSfHYUXGDjr4srgOCqzB47fMaux7B8pTU1Os65koM4jthNi//sCRdx6NGIymVQyiQPyeDLVIyhP/5KLms1aWqIu1pLNRsKasD4g6Lo1WY10i74sfAEnu1heiuYBn5Q7EWRsD2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: c41e8852-b7a2-4679-01ce-08df1a1d5a68
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:22:28.4163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CECcusC5pxpfUhDH7zT6AOD/urztPbWgnmc696kGoT23JS+RdL1fpoxM3bhDKKO3hL5DxKq3pB54fZcpJ9ZY0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7903
X-OriginatorOrg: intel.com

On Wed, Sep 23, 2026 at 07:26:04AM -0700, Sean Christopherson wrote:
> On Wed, Sep 23, 2026, Yan Zhao wrote:
> > On Tue, Sep 22, 2026 at 06:47:05AM -0700, Sean Christopherson wrote:
> > > On Tue, Sep 22, 2026, Yan Zhao wrote:
> > > > The WRITE_ONCE() in kvm_gmem_unbind() and kvm_gmem_release() are also invoked
> > > > when the memslot is inactive and unreachable -- are they also superfluous?
> > > 
> > > The WRITE_ONCE() in release() is necessary, because the file could be freed/released
> > > while it is still attached to a memslot.
> > Ah, release() can occur on an active memslot, so WRITE_ONCE() is needed to 
> > ensure the READ_ONCE() in get_file_active() works correctly.
> 
> Yep.
> 
> > > I _think_ the one in unbind() is now superfluous after 0ee2c883b62d ("KVM:
> > > guest_memfd: take the invalidate lock when unbinding a dying file"), but that one
> > > needs more analysis.
> > Hmm, the line "CLASS(gmem_get_file, file)(slot)" in kvm_gmem_get_pfn() is not
> > protected by the invalidate lock.
> 
> CLASS(gmem_get_file) can never be protected by the invalidate lock.  Or rather,
> doing CLASS(gmem_get_file) while holding the invalidate lock is nonsensical,
> because taking the lock requires a reference to the inode, and if you have a
> (stable) reference to the inode, there's no reason to get a reference to a file.
Yes, I mentioned that with the hope of proving that the invalidate lock does not
make unbind() safer about dropping WRITE_ONCE(). :)


> > It should be superfluous even before commit 0ee2c883b62d, since "the caller is
> > responsible for ensuring the slot is unreachable before unbinding" ?
> 
> Yes, I just haven't spent enough time thinking about it to be 100% confident :-)
> 
> > > > Do we need the READ_ONCE() in __kvm_gmem_get_pfn(), considering that other slot
> > > > fields (e.g., slot->gmem.pgoff) are read without READ_ONCE()?
> > > 
> > > Yes, it's needed, because of the aforementioned release().  The other slot fields
> > > are only ever modified when the slot is inactive, i.e. unreachable.  That's why
> > > I think the unbind() WRITE_ONCE() is unnecessary; KVM should only unbind when the
> > > slot is inactive.
> > Maybe the READ_ONCE() in __kvm_gmem_get_pfn() is not necessary?
> > When __kvm_gmem_get_pfn() is invoked, a file refcount must have been taken, so a
> > concurent release() is not possible.
> 
> No?  KVM doesn't hold a reference to the file.  Oooh, you're not talking about a
> long-term reference, you're talking about the reference acquired by kvm_gmem_get_file().
> 
> Oh, duh.  That READ_ONCE() is purely for a sanity check.
> 
> 	struct file *slot_file = READ_ONCE(slot->gmem.file);
> 
> 	...
> 
> 	if (file != slot_file) {
> 		WARN_ON_ONCE(slot_file);
> 		return ERR_PTR(-EFAULT);
> 	}
> 
> So it's not strictly necessary, but since the entire point is to verify the slot
> pointer hasn't been clobbered, we do want the READ_ONCE() to guarantee the check
> is actually performed as intended.
Makes sense!

> But given that it should be impossible for release() to run concurrently (see
> above), and should be impossible for kvm_gmem_unbind() to run on a live memslot,
> then I'm pretty sure we can do this:
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index a13445c26d9d..1aeffb5bd2b0 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -1130,14 +1130,11 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>  					pgoff_t index, kvm_pfn_t *pfn,
>  					int *max_order)
>  {
> -	struct file *slot_file = READ_ONCE(slot->gmem.file);
>  	struct gmem_file *f = file->private_data;
>  	struct folio *folio;
>  
> -	if (file != slot_file) {
> -		WARN_ON_ONCE(slot_file);
> +	if (WARN_ON_ONCE(file != READ_ONCE(slot->gmem.file)))
>  		return ERR_PTR(-EFAULT);
> -	}
>  
>  	if (xa_load(&f->bindings, index) != slot) {
>  		WARN_ON_ONCE(xa_load(&f->bindings, index));
>
LGTM.

> Or just drop the check entirely?   But I think it's worth keeping the check,
> especially since __kvm_gmem_get_pfn() will run under the invalidate lock once
> in-place conversion lands (see "KVM: guest_memfd: Introduce per-gmem attributes,
> use to guard user mappings").  At that point, the check would actually provide
> meaningful protection against KVM bugs.
I see. Thanks for the explanation!

