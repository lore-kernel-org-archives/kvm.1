Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08514412BF7;
	Thu,  8 Oct 2026 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446655; cv=fail; b=p2B6mhJ0ig+uSrinsQYtAHvcxE8y2T09vp9WUF8+0NmSSF1PBk8jGp/az7amb8sU65UJtHOLgy+1eI2pq2I6Ia8+t0iCXsRfGxuID3ckh2JemZ6WJ0+VlJ45NPwMgJEi3xwq2mlmZvQ9y12b6jRHwWWhMgArwPNSfZDBhiPSetM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446655; c=relaxed/simple;
	bh=I8gNoEXNKFOkDApEoX7ezAbtkune1Ub1eZJovw6ZOSM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kdaYcTF+ahO9HXskMSOkGx/o2i9BDKCSWmmV95wpEum+eicqZFCpwIDpZ8Wy5qRmW8bWx/hBtyOePI2NGLB+z4c32ikSwTdLoGLzWSk+DOSxTruwLzoHZ20EHht8umGlPKEfY9LE5tI9JXfcRpYIjXFNyv0D9Pw2qc85LLyHdTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1t4HSIO; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1t4HSIO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791446653; x=1822982653;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=I8gNoEXNKFOkDApEoX7ezAbtkune1Ub1eZJovw6ZOSM=;
  b=g1t4HSIOMweH1XBt0aI8NJ6SuatWOSOxfLHNb6+QPD5bLDc92D1c6Uvh
   qhym4Z7QcwM1MLCM6H0D1U9PFCxtHmzzCHMGfzz43QRZ7h7ngoiJ8Q1eM
   TmT981j0bIapid8QP1/uOSnR+TB/5BEL6japKDkEGiK4ZFxoARmgnQvQy
   NjqDJEO+4Impc+T3LF6E2sBEDBjHd+kZgTUFBzqxnK/4tp4swFZ0YD1vB
   xtln+4fyYSBhMm6lilDmWGLrVRRN5IC5wEcTFjJE0zjTAqF5HsQFA+UyT
   NwCQMzWU8VpYZlsuMS8asrD/BmaXnj/MSi8dtVa2dLx92sgI4FGMd/Lev
   A==;
X-CSE-ConnectionGUID: 4VsT08zOQkS2vzuzVlYRxA==
X-CSE-MsgGUID: k0IDnhKLR9uQH5EDQNxDbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="331677"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="331677"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 01:04:13 -0700
X-CSE-ConnectionGUID: sjMnYEGhSN69HgRb8ayOtg==
X-CSE-MsgGUID: pmcnKofbTgmgxEsE/6QU1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="301059"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 01:04:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 01:03:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 01:03:56 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 01:03:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaqBGF8BfIuHLOGwADtlYvXaOsk/1Hm2SkZXo69I68aO4FvpwRjXh7RVkPgdACBN7JXUMnYtmN0A47GpLwg8ibpl/T4obobdLVL9GHDS7HhJ1d6umEiraQyxy/BKZYMIcHpA5hIbYHC0esakf0oENDvTGbALkXexpswX/S1rKSusg1du9QivA5SCaqe35JvyWFTfnJghxkbK/Tn15BoJFFQ/H7OaXPmQSrtatx5v6y+jBiTJeq5b3EjnzDdmuiznti1RhfsbwjvkPB4e/5WDM5xFUqb2DpttEyAh1zdP0+1VjZdBTFaa1WF5leiUrmIpXV9ppW8PnkK0wY3TfhRciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC9BUVkAl3zRJWEQFCV7iMlHMqyCE5xMHpTlIyQUk1I=;
 b=xkDzQOBFjcGBUtl2ttoOtH2XL360zyDLwzHrxXi6jNxMY3YJkYWJ0bxRVCvBA/43Kt+TTEO9U3BkavwgAcwMpqSqRgL+oPH/FWg3bvQV6msnJMdUjaulAlPSVwhFvliW5Vv69AGF1ONRyVQ+qNS2hgH0ELpBDpbnjiV0C6/Iua9HFl0VKIyX3nldgM+ZFhiwqZvmwpW319Nyrwqr6HRvI3SBbTH7hApw5ipttxqXokitj2pQZbHNCgVzmy6RCEB/YJDl7zafnhG9ummA/kJ/PFJQmKkytnAGR4qT0YGT5oDqeAGiW51UJ/wwDWigYLlCGiR7BpKP0exNNCwYmYrCUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by DSM1PF9CBAC92AC.namprd11.prod.outlook.com (2603:10b6:f:fc02::14c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 08:03:52 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 08:03:52 +0000
Date: Thu, 8 Oct 2026 16:03:05 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sashiko-bot@kernel.org"
	<sashiko-bot@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ackerleytng@google.com" <ackerleytng@google.com>, Vishal Annapurve
	<vannapurve@google.com>
Subject: Re: [PATCH v2 0/3] KVM: TDX: Syntehsize SHUTDOWN on unhandled EPT
 Violation
Message-ID: <asdOF41hqDpycXKU@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260930001127.3170009-1-seanjc@google.com>
 <3c0ee89f560b0235f293b32019327186785aa795.camel@intel.com>
 <arxd78Pn6WWL6TGq@google.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arxd78Pn6WWL6TGq@google.com>
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|DSM1PF9CBAC92AC:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6d5fbb-acc4-48aa-3718-08df2512b105
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|4143699003|11063799006|5023799004|6133799003|10067099003|56012099006|22082099003|18002099003|20046099003;
X-Microsoft-Antispam-Message-Info: MAvvOE1TU2KWTNGnQ1Z7qRyru0D4PioVOweWERMGqaEW7LyQhvRTF3DPruyE4ijDatv1ihqVlGRi9BZKuOCdUU3lWLAczj4Eb0o+dVg0JNV5CCV+ZNAxglsBmTRh5dO+l3xFfa5f4OlIJaSPEK3uc8YFiEnHHeuOgTKmWulfbK5mG5R86EQiLonFO1Llq4GLWjVf10mpvAmYGrWQ6tf0oGxR2h1m30K7cly0rmfXkS+XdDuE6S6HticctUvWB+eYqqnrr9PWsRWj0kGFwcRffDpHbbqQOz2Sp6NipPaAyOgeYGo7WVQeN+skaRPiSdmiCTyNYyHflKJ3rEBrrdDzAUE3Ds1LXyg+AZIR19n+uA0maBlVU082Q6RS8RPro1QFkIRQPVXbx5sAVWzMI48J9Wuz5JyXIanLZ2wnUt8eiFOtynOQDnuDQPlkysjfq77Y3Su1UgSG7Ff5+gm5aBua/SLULqzFpoNI0qo9NLN1jmqxXHM+5yryderT4Cxob8gkHWdVNNpqnHi+tySEbnDnlg/Fy4EKZzR8CZ9vVUOSJ5sYGy0BN0Q1GbKC1F9RXiDWPw4xYO7JR35dvDcqf0qkuYuLt2MTuORJjFc826zEvu0tAHcEWi3uHtniednQvPHnLxzWbolSq2EJOlAjbDAe4/AvwUsWXs0W0oHtxjc9GC4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(4143699003)(11063799006)(5023799004)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?PAfsvSCtLHD9iPW/NN3syzE506WwH9+kDFZwoJz7CAACIT3VuPQI3ia4Lk?=
 =?iso-8859-1?Q?hEG1nUxyg+3ckpqtVXtTeL+xZ3Oib3P6MlaRzPq+9Q7Rm+Wb+CYc4pSeh5?=
 =?iso-8859-1?Q?OhJFVCXVYIVVAER87lFTzo+qNhYn67+yTkpbVTAazzvjOVRj/u8Ge+QGES?=
 =?iso-8859-1?Q?GBgPSd3/aU/cPu8a+Cd+DEIS0ODDOeVmLN/ubrmbG8LawUVU5WEL+kTtUk?=
 =?iso-8859-1?Q?LyFF/CbH3Yxk4kp6Hh05ArhzvghnWHlQMbJ+LXR4ZIc63ihPd0vLHFxMZl?=
 =?iso-8859-1?Q?i+21nlT3PVW86wKCT7JetXVrscyzRpsyvW7vWFRyW6HwmvzZCQQj6R7yAY?=
 =?iso-8859-1?Q?8GINxKAQDh6x9D1CB1v/XQvTn6/Vxcj1wwYYE2atuwZZ54+qZDR0nxuqoh?=
 =?iso-8859-1?Q?72E42Q5NRHrJcc0aFC2gM5h+/VzumL8Lhn6yCnlBBt9O2hKDz9KwzyFjWV?=
 =?iso-8859-1?Q?TQ55+lqrD5xf5gfkumX09V+mf6tFVJaYOaSSy7N2ytNZs/ux5A+YyUXBXi?=
 =?iso-8859-1?Q?SHi+5QxznkyoG4nrHOaQnCi88a5z4gHHDTqyfOV+M4dui1xO2En3zv/jGZ?=
 =?iso-8859-1?Q?q3k0F2+jzR8qzcF7dphZo3YTGa5Maor4oPy8cwvUwePLwt9yW4Os2+O96l?=
 =?iso-8859-1?Q?H3t6LZmnncR8no4ADDOv5SZUYmw5CmIRqTm7vQPnCYRqLIiGN8BMUmNbPH?=
 =?iso-8859-1?Q?0h4/GdaABjAOU+efaU/9YDLkeHPqEPpjjuCitCp4Wx36ngvz/Tdk5m/cYp?=
 =?iso-8859-1?Q?DEtJ+pjx9n2SxIjcBwmM7xUpYgaWoDbjyh40F06dyTdzFfhYBb7udBqiPM?=
 =?iso-8859-1?Q?A0k45A5lk1FVizsmql9HFvRN88zIaRhK4jw0hBTg7tC+hxKxR/jNb+sHWx?=
 =?iso-8859-1?Q?wHi2e/TW+FTFa+PKjl6xsbuJnivEiUCyQLNuU+JR4x4axVrle1P9I3TZG7?=
 =?iso-8859-1?Q?C91KahWZCrEu6bY+6ZBl/xTqUuLDhOwuFDYiypf5nQnR+dDo3oDSpnV8RR?=
 =?iso-8859-1?Q?6w9gVMZrEEfoCgh9MEwag3hVbDGaBtG+YuZFZW80b1riiS9nzbn2sWJ11f?=
 =?iso-8859-1?Q?x8oXCUI+5oxWqdD30NUpVoKCYqa2+rOkIbctSFc0JkReR9079EJ8koLHF+?=
 =?iso-8859-1?Q?HBlVZJaGOYeocnir8W7VR4L7dO3Can1vvG2gPiNSmA8pgNR/VW5Yja7KKc?=
 =?iso-8859-1?Q?23AdD63de/HwdFlfcDc+8wF8f1qvFjvxyS+xPWXihhUcZevORfePbZKyiQ?=
 =?iso-8859-1?Q?Rc9T4OjctW4YvwxATVLSJ+eM+l0sQJXMpGcWWXPIThagvvH3Ti2DnT2U+S?=
 =?iso-8859-1?Q?8taPSDXLuquE1609rcnri58SaBUp59gWX4AxJcctiBPUsp143l6Iv5OvrW?=
 =?iso-8859-1?Q?kjA5yvkWrfGxcOF1Ftqe7S1su+nRG6aOsC6M0uIUfyVXE9b0pen27Lte+I?=
 =?iso-8859-1?Q?bnboIXy+OmQVZcYWElVCRS5gupjouMXhF8+Yje3SI3w+E1GScw8vdRHh50?=
 =?iso-8859-1?Q?LrxZnhxCG3RW3PKKKSXvoBO+VAgrGB0sEoIKLZVgytlR8iOjaAlLPODkPI?=
 =?iso-8859-1?Q?yKTQwQVvKObIfHA5O6j+DISUZN+XUi1lR36dChB4GamqGuJsCowRyN78Me?=
 =?iso-8859-1?Q?Z6kcotaxs8ZQmBWeTvxsvbkTdnzN27Ljl0UcbozqEATPBgUQD0oggHCMhv?=
 =?iso-8859-1?Q?epdNrYcAeg085TmKa0B1EDUnvmo1ne7JnxGit0dPfgSMMbIS+BpDBENkU6?=
 =?iso-8859-1?Q?5vyB/+Au0O4TMcFmtGDgikuthRetEsTwEgIsPCld+Ef4wED757z+eVCNgP?=
 =?iso-8859-1?Q?togESYLdqA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 2LcrXaMz4Je/JjSSj42wMohJwpfnfKY5uZzOuEI2sXFXGjwH0GPXEI5CTshDB1OgRqOq2noUn3J6CrCLBsrTA0wK8a3HTUmW0tEsnyePZ7wzOQHJGsneR9pxyYhMqbw6MJAVJXXVRLTp4p80CtwGF/KecttQun/cT5hp7AhbzTf9PD6WGOe3kK1zP5OsFpZO3Hr0BK4JfSdLiDpZtuQNbQCGZsezmFYKEYgHMfr99Yh7FKnRmy6IEAmQnxikO70p2ud1KGvob62MhsMfESRetY1Cy1jF57Kws2jldp+lLJJmzA8X6F6fWFtFXKgYqr8yBUlOXORQRpC5I1ndTtcuIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6d5fbb-acc4-48aa-3718-08df2512b105
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 08:03:52.4440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUhkygNwznhDXdNI5hh+AbMegn2mmXMmcNUKTlYIXf1BXTzCgG6rXj8Dz4aXzFbJ3tGwAlBTQQBJlWNT4ewRoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF9CBAC92AC
X-OriginatorOrg: intel.com

On Tue, Sep 29, 2026 at 05:55:11PM -0700, Sean Christopherson wrote:
> On Wed, Sep 30, 2026, Rick P Edgecombe wrote:
> > On Tue, 2026-09-29 at 17:11 -0700, Sean Christopherson wrote:
> > > Signal SHUTDOWN instead of -EIO if the guest accesses an unaccepted page and
> > > has disabled EPT Violation #VEs on such accesses.  Returning -EIO is all but
> > > guaranteed to mislead the VMM into thinking KVM (or the VMM) messed up, and
> > > will likely result in the VM being terminated instead of rebooted.
Hmm, it's by design in my previous implementation to terminate a VM when the
guest accesses an unaccepted page and has disabled EPT Violation #VEs on such
accesses, according to the TDX module spec:

"This happens if the TD is configured to TD-exit (instead of a #VE) on an EPT
 violation due to accessing a PENDING page. It normally indicates an error
 condition; the host VMM may decide to tear the TD down."

So, for the initial implementation, we chose to invoke kvm_vm_dead() and print
out the exact reason as a hint to the system admin. (Previously, reboot was also
not supported for a TDX guest).

Returning -EIO was based on the following considerations:
- vcpu_enter_guest() returns -EIO when kvm_test_request(KVM_REQ_VM_DEAD, vcpu)
  is true.
- A request to handle a specific EPT violation is rejected by the firmware (the
  TDX module).

> > I'm pretty sure Yan had a test for this path, and I'd love to see it actually
> > exercised. What is the urgency on getting this fix upstream? Can we wait a week?
I triggered the EPT violation in the kexec path, and successfully had the TD
- killed with error msg: "qemu-system-x86_64: cpus are not resettable,
  terminating" on an old QEMU, or
- rebooted on a new QEMU with the msg printed:
  "qemu-system-x86_64: info: virtual machine state has been rebuilt with new
   guest file handle".

The TDX selftests we are using do not handle KVM_EXIT_SHUTDOWN, so if such
an error occurs, it's silently ignored by the TDX selftests even with msg
"kvm_intel: Guest access before accepting 0x8000c000 on vCPU 1" printed in dmesg.
 
> Absolutely.  It can probably wait a month and no one would care.  IIRC, this got
> hit by someone (internal to Google) deliberately crashing a guest kernel and doing
> funky things with kexec.  It showed up on my radar purely because our automated
> madness alerted on the resulting assertion (on -EIO) in the VMM.
Though I didn't realize that returning -EIO would mislead the VMM into thinking
KVM (or the VMM) messed up, such an error could also be introduced by a VMM bug?
e.g., VMM removes an accepted page without any notification to the TD configured
with TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE bit.

