Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F71E5B88;
	Thu,  2 Jul 2026 03:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782963302; cv=fail; b=ImFaEMzhJ7b5Zs7+sPN24EWaNvois+/W/qL9ah6iGF/qW+YYneRMNbBHXJ4U8fF61VJD/THi8zTSp6eT0soefPeRJU9F8Uu06qvozsdqqX9/l2vVWW6ZUmkq2WNEgLFXNmjBWJV9PRPNafLeHE/8jTQJdEQGS25Zwr3IDUYTaM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782963302; c=relaxed/simple;
	bh=WsgjUG1FbrRE0qmE22GllhMqsgAh+bHoA80rZXfHa0s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QmXzgqezyHm8vzKDSJRh6K6pDW48azTLjbG1FIGqZGjmu+IjCJPIah6WEFqT05ljqDJT+m5+GLbIw+dPji+6wds995YeGTfzkSimqNto7SjtxH1GftsfUgYpSp8igr9DHXei7aBzaxSjrTEwnT+YizKjMphpnU8alua9joyQX/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QC6Ec2dp; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QC6Ec2dp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782963301; x=1814499301;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=WsgjUG1FbrRE0qmE22GllhMqsgAh+bHoA80rZXfHa0s=;
  b=QC6Ec2dpjwY88ckVrJz5ICfMXTRyMaam1d1e0O1q6P4C931G045N/qF/
   ksJfeEfDsngTHh8TpIXmf6ypjmS9/YSkLdkVO6UVi4tWeOuves/GujoWM
   Ah/m8xinWqeOSpIEJL9Kqd8WOJgI6peKyAfZdBds7e4K8T1PdeHuWbMXZ
   gIO3rhOzgA49Dqo9kB6Ga4FW3v+DUJPQVxv4nVuWF1evYo0/tgS5bYKY+
   BYbVJCD11Jqt1D4UsuzjR49j/rd7BzeVQLpTZuS1LhI9eWhmE2p7aukc4
   swQ5oi80Ktl4yxtRwLTmYqDTLTyF990Rbtk0dBcivfH+9aD/8/CXOIuaP
   Q==;
X-CSE-ConnectionGUID: 7Mdee1NKTYqKSRUh7EBvsw==
X-CSE-MsgGUID: O3W0LH0BSbC9tqacwNFdYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="94358066"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="94358066"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 20:35:00 -0700
X-CSE-ConnectionGUID: xjieCnSoT0GKEqF2jTzNqA==
X-CSE-MsgGUID: qiL/CUYzQ3iY/ydjnKFl6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="275945821"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 20:35:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 20:34:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 20:34:59 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 20:34:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHA6tSrpTqulLwspyyktXkawk/sn2IgLO34cF4mzzEMpGm+RKvt/CnGhCTlDAK0lrF8kUUZmFAQ0QrT7fmnYmh8aRet/lWLZX7aZou4K1jeNusHtRE+EfM7zv0be29+mksK9OxSbF/oRBKxQY80Eu2pjanSvBXiipqO2XBnhfaF+v6KsWLkmuCjofKdXgVZ9/chjRmXxWqkgcp9MhtrJpCQmaocyujAJpfZgbBrbcCMD7XwYAytS0jW53UGYzvFZyUP3SLgUPUd27EQSg8fDWwpGWdAgbwH85q+a9I9hJnAj7pROOQCM8YTq3Gce2VcsUdtAFzLK+Th/fdaOC04k+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkHvf56Q/YN8SrCAZgpUy/fFtuPSGG7zedUibvHt+qU=;
 b=vsyoXzryyHS/aCd6ksPKjGIeIgaQJyPwbwYr/KaHii1aplMoYChzqnB+BL1uNIwPO9U1PbzXDunsdoY2TV4CpRr8IA1dtg2oUHiETSTtpxfjazuaVCgH0AKLc7maA0y3Y0+AKPnUJ0FBjiBIsG70JzRXfF/ZO44BUthv/BFqfou7VtmhVwAwyj//bJiZ0juFTR7niL1adEKqplC2u3mbB9D3DeA+Y2mVjzPo42b+zraQ82er0+KxlHmWbrGvBoG0iehVUuSxm8kXQN/Ev+PbGP0cQW3PV+thCtJ9JOdGMqg04CcAZqo6yhPwt40GELXIl8f+2obYILx2QpVEISia0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by IA0PR11MB8302.namprd11.prod.outlook.com (2603:10b6:208:482::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:34:44 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 03:34:44 +0000
Date: Thu, 2 Jul 2026 11:34:41 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>, "sagis@google.com" <sagis@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "Annapurve, Vishal" <vannapurve@google.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH v5 30/45] x86/virt/tdx: Add API to demote a 2MB
 mapping to 512 4KB mappings
Message-ID: <akXcURIYNROPFgnp@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260129011517.3545883-1-seanjc@google.com>
 <20260129011517.3545883-31-seanjc@google.com>
 <aip1eO7wvJDxKtBX@yzhao56-desk.sh.intel.com>
 <9c22a8bc7f326f81effdff27fd72c3c5339e5053.camel@intel.com>
 <akMryYJGxIk+FnbO@yzhao56-desk.sh.intel.com>
 <212aa1eee0c19fe9cabc1ab8cc2b217f1ee0b7ca.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <212aa1eee0c19fe9cabc1ab8cc2b217f1ee0b7ca.camel@intel.com>
X-ClientProxiedBy: SI3PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:295::9) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|IA0PR11MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4ae3c0-c759-446f-db0c-08ded7eadba4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|6133799003|22082099003|18002099003|5023799004|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: H5PdKd/1c/UVhEXmY5U+pRsmhjcoiiaEYXEGYNJ8Qye9SYcSPH1LX10p73K6SQn/T/SrYkRUeyLOyS2qgtk06uYTaPwWJ/VpBROPfJXJ16k/irctoqtee53VDCDD2tc5H/FTdLMDwWafVxkqAeH19A9rlLztJe+uw9vi4GbsqIQu2su4bFKQ+rX7XJK1tP06D6xxglKBfT9OFqlw89ud8LXOwqGKNso5Qn35aOClQlQAETdR22juXYukPqGMYf08eKeI3wtinQwxDaHp/s9h736th9cqG5zDKKUTXNTjuXKfh8ezZfQoNPSYH+5lL5lKiQYIPbcsgzYCjaFVLLKl3diHTYridKXKHFV4NXwUdrcQyo6gM58A8cioWGqSiY5uvk8NjVEyp9ibBI89v+e35kNgTvP7zEU8i3ChFgsgFT5JbiWPrQCbUt1WaJDTpQyrLLeL2fbYROso0W5FL3yMspPUMkEYyGgJCjgKHhEjaEE3Ey4MDKg/EYmtq6SMySGo+WPsmpa6JlzJMEGYyuogfWsug0nFCA/5ghsUFOR4TTEGrT5O/K4EAD4h0l/R3yHZ95twqRzpiWnho0Aekez3jpg6C0bw/e/bPfaKENHRU5SVAf8JJ16LjUNij5X4ooazpJkpN+nPtFHXDxgfvSpLi4AgiIB/b/uJsPFmnMBzRn8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RxlEFR0Uz8/IixcZSKCaslxK7WxIxLvYQSojNlOmYQx1w9B2QVc1Zw1/ZdCE?=
 =?us-ascii?Q?b/9l2eCsbDBLP8B2IbcaHa7WtmKmEpTk9EJ3SWjeiqjmhOVxDtFvAgsLF43t?=
 =?us-ascii?Q?g5tTWCiFsa0MHRIMW26Wa2iHlPUaZ27CuH6lyGAUs0G5InzCnSZmcsA5wBKz?=
 =?us-ascii?Q?ADASwG3Wm2J9i5K9xZR62gGdiYpV8ipfSSZLHB4OhzVW9E7cwKdDi3c4zE7Y?=
 =?us-ascii?Q?sqa/SGBraJehC4JeWKe0kh70K01VQPYVl0mx0hlNR4im1tqGAaEjQM7fFjus?=
 =?us-ascii?Q?YmXzUcEl10csDZiK4ZUPLAtqN2ejlDwlB6ha+tY0Rr8mLh0aXKITzaz95Ih2?=
 =?us-ascii?Q?x48Ijhq8mqcF7Y501gjIRhCURqdNp+UNA4O7zDdz0JwJrYu1ZCuNcgqneQ3l?=
 =?us-ascii?Q?LYO+N6mIDoyYX1AR8jlhUirCrVM8RZUZiI2zUGfv8Oxfy24FrEHxcd+qoDp+?=
 =?us-ascii?Q?7HjIIztZfL7yjeHMRP2J5v5IWcbZftfAd1/s3D68xh6ZAPEVk9YT7yBB1dTX?=
 =?us-ascii?Q?fFHZoo5r/aaJQNe034YMACULiXdeWR7BOQpC3vMS6McD4GU/Vh60cqrkFrY5?=
 =?us-ascii?Q?Lk1GILUkTiW6GL5qy1xBAd78tVW8WEu0AsFACX7QIP1+D7FyJLpR8dfiM6Kn?=
 =?us-ascii?Q?owuq6uzcPNetnl1AQsG+qUMUKliP6gybLhkuivGwTTsVl3PkdwcFoBOTBpkX?=
 =?us-ascii?Q?tpUeCmmuQjfiywaVWZetRgD8lFfn6mgclEJ/lldKAcBSmMrlr/kL18/7rfJG?=
 =?us-ascii?Q?v36jU9vL3cSYlD7wZyTeJ2vx/W07jrRTSVjuJsxVMjvizS+rhWdlbgPWkEL8?=
 =?us-ascii?Q?yKRXCBcH8dqttrDWI1J/7Fet8BjztCrAy8UTqBJDC3PPvNQu8QduuibabOFA?=
 =?us-ascii?Q?SvZexD4Pi5WarrFq9wpWDtuuzp8B+PmgmATxOHLf94rymwtawqAZKHcBC4Qc?=
 =?us-ascii?Q?Zre6Z6LDo1tVJw6FbRzZR3JAX0OGd0msrbHMebTYFzk49b5cFpGy6z+tQh+G?=
 =?us-ascii?Q?176dFVmmXuwBa7XDJ8cPocZotV8+dBbsei6dDqx8zF/k+8VS5ihi0Ix9fAbz?=
 =?us-ascii?Q?90w16TVDz5b4W5oG8NodiCYD+zt2f1+5qd4qPuxOpUoPhSLj00/UD+XC5ffu?=
 =?us-ascii?Q?fpR7E5zPpgMrzmwZuoxZIWFfGrri3Z6aUn8OPjPH5+CWNwnpvC10LsOJmVEz?=
 =?us-ascii?Q?C+JWZsQCtWWGxf+D+yToTVNHDF+tKCTrRx4+v+hzkNUmTAq+rmNwQJzCXH90?=
 =?us-ascii?Q?Tl/YYnaaKG3YpBesxJJ1vBRz0MsfsJiJrbrCcnF8kv1IK+BxB0n9pPTbfdsg?=
 =?us-ascii?Q?wqnCbd9J2lYB2MSbA11VQpbsqGxA/V/VagIoTEl3wKEp8d/Cx9PHs2dPzio/?=
 =?us-ascii?Q?nP8LiSzoW8czJgum0Fbyt48ykcbRIQsdUzkhFfoTtDkArLbHIS36qv6jFJZR?=
 =?us-ascii?Q?RXhMo39EGywwON+8w399HVz6s2n6X3QyQMGvIWwk4JEsIDtETxnzqAG1cg5t?=
 =?us-ascii?Q?LmtqlcpiPophPHQBUPoMpDOGyEjveIwJHc2KZsqaNF0LjFInpvf4W7G5E9n5?=
 =?us-ascii?Q?idxGn99STc9HmyvncXuUF9xgmI2PJRmT/H9yaPC95iFmY3+5WkzFI5VALuPI?=
 =?us-ascii?Q?JUneh66E+q1SjaqftHD7POm1/u9lzh0rVo3biFV7YgiofxBe5/5sPuvPjTgf?=
 =?us-ascii?Q?+2tz0XwHyEeGM8OsdZApC+glhqiSPf2R/cVruksIUEdBjKLWtUxCubtOArZt?=
 =?us-ascii?Q?A8DBrOlZ7w=3D=3D?=
X-Exchange-RoutingPolicyChecked: pkGd/F5YaO7vMLniec/qbiQf+Zn16Eyo4VQDQbsGZwMq38cAxSvKSNyojr43Y635b2mpbQjOqRvvtGi7gVotAwzBtnEZwjuAijmYTrji2CA64/gAFHKJ2wx5lm4dqfSk0G7ACd+qwVUhMIvLJpXUTYp4l6eiKDzq+c+qaEFany43YQPRUBoEp8pVw8PT4DLKCLkSsZsQc+ZLSz3H7chMhi1lgWuKA9pcOBTREzsp9I8FvD49MTa8wEHemtd2hzJpOy9FAw0iwU7DSZyEYhTpwkQI3t+2U4u8gFUgSB3aDO3e4rDS+/MCzOiDM4tddnFJ0aMJ9YEIgE6IO9gmrWjW2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4ae3c0-c759-446f-db0c-08ded7eadba4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:34:44.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jz64aUy7KKKrcFbeyjXOp5hh5QlorP/0NCKkRjbSIkoMy5DVJkqs8OZXayZGLja7BOQkwqWtcVpcze6Ru0gavg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8302
X-OriginatorOrg: intel.com

On Wed, Jul 01, 2026 at 12:35:34AM +0800, Edgecombe, Rick P wrote:
> On Tue, 2026-06-30 at 10:36 +0800, Yan Zhao wrote:
> > > It feels kind of hacky. The refcount stuff is already a bit hard to follow.
> > After demotion, there would be 512 4KB mappings for this 2MB range.
> > Then, in later tdx_sept_remove_leaf_spte(), tdx_pamt_put() would be invoked
> > for 512 times. That's why we need to set the refcount to 512 after a
> > successful
> > demotion here.
> 
> Oops, I thought I deleted it before I sent the mail. After thinking more, it
> seems reasonable. But I didn't check it thoroughly with the other flows yet.

The new wrapper implementation is as below.
I adjusted the pamt_refcount part and made TDX huge page rely on DPAMT.
Will add the following justification for the dependency on DPAMT:
A TDX module supporting non-interruptible DEMOTE usually also supports DPAMT.
Having TDX huge page rely on DPAMT as well simplifies the implementation.

u64 tdh_mem_page_demote(struct tdx_td *td, u64 gpa, enum pg_level level, u64 pfn,
			struct page *new_sp, struct tdx_pamt_cache *pamt_cache,
			u64 *ext_err1, u64 *ext_err2)
{
	struct tdx_module_args args = {
		.rcx = gpa | pg_level_to_tdx_sept_level(level),
		.rdx = tdx_tdr_pa(td),
		.r8 = page_to_phys(new_sp),
	};
	atomic_t *pamt_refcount = tdx_find_pamt_refcount(pfn);
	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
	u64 ret;

	if (!tdx_huge_page_demote_uninterruptible(&tdx_sysinfo) ||
	    !tdx_supports_dynamic_pamt(&tdx_sysinfo) || level != PG_LEVEL_2M)
		return TDX_SW_ERROR;

	if (alloc_pamt_array(pamt_pages, pamt_cache))
		return TDX_SW_ERROR;

	/* Flush the new S-EPT page to be added */
	tdx_clflush_page(new_sp);

	/* PAMT page pair to track the 2MB guest memory */
	args.r12 = page_to_phys(pamt_pages[0]);
	args.r13 = page_to_phys(pamt_pages[1]);

	spin_lock(&pamt_lock);

	/*
	 * Before demotion, the 2MB guest memory range is tracked in a
	 * statically allocated pamt 2MB entry, so the pamt_refcount of the 2MB
	 * range should be 0.
	 */
	if (atomic_read(pamt_refcount)) {
		WARN_ON_ONCE(1);
		ret = TDX_SW_ERROR;
		goto out;
	}

	ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);
	if (ret)
		goto out;

	/* After a sucessful demotion from 2MB to 4KB, set the refcount to 512.
	 * Subsequent removal of each 4KB mapping will decrease the refcount by
	 * 1.
	 */
	atomic_set(pamt_refcount, PTRS_PER_PMD);

out:
	spin_unlock(&pamt_lock);

	if (ret) {
		free_pamt_array(pamt_pages);
		*ext_err1 = args.rcx;
		*ext_err2 = args.rdx;
	}

	return ret;
}

