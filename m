Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F72438B124
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118520; cv=fail; b=UIAMb3oNVXOC0isct3SoJ7izTUi2KmQM2SKOlja9s2q7QHJ3W0wX2QDcEjcZOiOf4UNWhTeZbWSTZ6skuEpfJTjqDoDLgOyq9/zAU33KE+qadOQ7Y0RDR8NbDEbBIZ/1OROtRIYrSXLkI/6/0igoOVSsSm7tk2Aon+CHLdrvszE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118520; c=relaxed/simple;
	bh=Ia73iC7BY6+BwCrbTUotH5cvTTH8WPia56DguAvKwho=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uXiqRX+k9pNFMUHMC3Ld5Ra8IYR25HvgDw2vlxF1ygd7opbi/5RLncsOl1odd1pBwePxXHP+RFAs0E1PILv8ED3wJKRgr1tlLY2QFlSiEmRhede//wVYdQ7HlQnM6K1uiV5Zog/mBstG6W2cmC1m9NLelsMu41asIKRKMdRee84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXV7BaZv; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXV7BaZv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787118519; x=1818654519;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ia73iC7BY6+BwCrbTUotH5cvTTH8WPia56DguAvKwho=;
  b=nXV7BaZvi9BXAmQNEzedmoYZnvBzKAgYJWdBiIxW8280zLEb71gWAkfP
   3wNfvgXnsbrE7XOcW5IqAOgD3Wzttl49lMRMJ8MX1NN5f4LocnSvRx+Ol
   q4nJgqOO9NqZPoJ/i4ygx2Rfde4lSNRJb57Tar5PsJn044eJlJ6h+xdKn
   T1zkQf/0TXmUb5/QOacBSuptBqqyrnDXp/+ru+fxwM1y/JPzGS3R1umA7
   Yq3d94ibabXuft8O/Zn5ZHCUIMNP+Q76uFOG3ewyH92/gSqu2KuSQ3ZQh
   xs5ed8qWfcVG3uAwyAF2fBrM6ai3xgtvcNbXMrIQWFI3YkysCn0wXTkRR
   Q==;
X-CSE-ConnectionGUID: r7sdM/7wTNmpcxAarc3PQg==
X-CSE-MsgGUID: Uo38EFCrTGOohUxWBOu2Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87684720"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87684720"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 22:48:38 -0700
X-CSE-ConnectionGUID: RAaxsbXUQe+ZiaQQBlhKhw==
X-CSE-MsgGUID: Y4JCnXayTZaj8qxodGsQzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="267403618"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 22:48:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 22:48:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 22:48:36 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 22:48:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXPb0Ty2s7Uh26Po9U6+dTNmMqYq3AMICir5v/yMvl/AZsWaHrEeItFWb5SOK3ZRjpGtVei8xSDTAGwB9SEs3U2Epybzvd/vYmrI5OERjaHRT9dHny/JVrrf5HGKkgyQdbkK71bzTJZunmn3E63abToXx35hDQ5i7wWj0w75wScqQl9UNIG8+w5S/TEYtSGfGIRBQ3fuVP6LQJuW7YGGkyVfLpQCt73vI4VnoZJ4TA7n4nejzBTzbY/+9MPJL1kqceRa7slUnWCRKFMuAsihJYKvdeXwgNdy62H1PJUPHVdidycvaY/bxIVV5yvOYvy0Unv32Gv3V21/gfpudC8WVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia73iC7BY6+BwCrbTUotH5cvTTH8WPia56DguAvKwho=;
 b=Z94SKaj+4JxJbsteMCahFhqmwU1rZGYCFv4beOKtrjuSa6r9ye2P/e5Jiw5ajRn6Lyog2Gb4CtwI7+QVvvV6rkohK7b7LbC+NUkfn2IVBQIM1H4HMM1KAb3ZcK9mXIdTwFr8+fh5p4xYOu9rmc9UpaiOzoX7WB2z+AZeXb8kDb82vhEPq3l7VdgjqknTvnT++ywlVj1FQwb4viZwIJ0DeRHeq6aS1OT0Y8qJOyEKniICcllBtqt8Bzg6dOJj1mvsnl2LpgzztK3mEuAlNz1F4HK+fFdpsTbzjcy/+0f5Qmh/+r3IrdN+ZV7Ygr7DjEPt2iy2zvopRHVakGuoArcfjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by PH8PR11MB6855.namprd11.prod.outlook.com (2603:10b6:510:22c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 05:48:27 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 05:48:27 +0000
Date: Wed, 19 Aug 2026 13:48:18 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
CC: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<joe.jin@oracle.com>
Subject: Re: [PATCH 1/1] KVM: x86: lapic: update apic_base and APIC ID
 together
Message-ID: <aoVDogaO_0IYZQwm@intel.com>
References: <20260818234238.618158-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260818234238.618158-1-dongli.zhang@oracle.com>
X-ClientProxiedBy: KL1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:820:c::18) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|PH8PR11MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af4ff83-af1b-44ed-0026-08defdb57db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /3Bemljd/ak33avzJCWufHQAJTsdktTVeb6/4olL6SxrZafIdze3VjbaYZIbF82FtNXXynqUP/PWlJvvBj84Fp45UthM7+ONU5/7V/YX71Fsn1MTzCj8dPd4Lj8SvRraZP6VyuHrUI/okIu8xDGitlgxIgnsSzBz2YWoAkQY7u4+tTbsXINxWH4IQqOr6EV1jFcHkYCPPppblo8jhGlMqm8Rp1whjcIaQKJzpfOF9jOUgoe3IC5l2QsKGxkORAsbdUBGwpS7YiIJlQNYjNG9gr85cpd9dRsJ6LUaXezg/h42S9mfwX7m2FF8FyvhqsMNFPdG9JQpHzpYPHJuYfq3TLrnmeaFErUt8/q21y473Ybd78ln3981+SQZV8j9Z2dJdGDrGVrP9l5vxxDTKYtKh+jH4+QM6OjPUK5VGx6yoK5WTustKv60cPT6QtP3YfWyhhu3K9qQxZnf420neK9sSp1P1Vu8cDL0e+UO2S4or42DILJEuOme13aUhBJHF8VkINGOcDJvGNCbClNBHMfMxOTFb5BYhMvmwgpWBivO6idj9U7pehVQUsYFkLjyGA8HL8gBTe8BMnh6CNhN6kfi4Q6wIwnO3+hPhK4AgY36xEhQOvZ3sBXlNyhReJHTM/PkY2zs8JiEQRaatQdJtrqib2GqeKoIzzBuMWQdTpPF3R4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eK+JR6m+u/ftjxTcYt7W5gsmf2hWjK15kAJlO+vRDPjWXjATUPwP/GUDhh0h?=
 =?us-ascii?Q?pPP6wdF/eig3tbYfcNKdcyAionm9VkXP+Q4jz5ilGO7E+iQmIoP38NowcbHn?=
 =?us-ascii?Q?gn/OxaoslcjOBrP1ivA8rqcCxOZ8qltLGerr+5cCxwvk196vnKA49RuVF5Iu?=
 =?us-ascii?Q?unl9/TUxrMmB9XAi5A+sYhfJS+2FiR4s4VqyGrLs30kOYgBMmp6L0wdvGjx2?=
 =?us-ascii?Q?XQImdsrFzTkfG9FQ8Tg5SYTSJAEoQ42YWIItElpcfdvTbDQIwwi6Pn4oAw92?=
 =?us-ascii?Q?YNzBfmWTF8TizB5ancsXBX2KF59In2f6cUsWK9fAvH6FnwfxhVkxKNvFSHVw?=
 =?us-ascii?Q?KP3YJRU9dvaQVREuboLGPaXVjzR2LQYhcj91LDAPDbu5GIjOuI3lpdIo2VXK?=
 =?us-ascii?Q?pZxM5pw466n1HZNpDCKxMRHvhJ7+sCIJL6LgR2KexroHhji4XdTFfp5+YG1f?=
 =?us-ascii?Q?5o4dN/XrPE6lhWYFMfvdObGrvLTOZUIDrNBCTwzOmAZIOeqzCJjeycZTMx5V?=
 =?us-ascii?Q?gjd8VSBkIZ2sLuv31caU2lDNy10rICR6LFeD/xo24MdSZkIrKwG/nd4vjptj?=
 =?us-ascii?Q?OM4dvlNvj6oWZuwLCChJiFzNq/rOuqB0wdvFAKquG2RQ9PZSh138j4CDCFtK?=
 =?us-ascii?Q?TpEw1WVA0tk/D8uzz+vZCUueT3eTW9tidLQL2kj09xpMyf0KZ6hKGg1fO3oA?=
 =?us-ascii?Q?gkKMqA9a12ByxyXbbdvGVmZPetuOrxKKB94PoYGXfpToq+/+koS3Jvr01EIk?=
 =?us-ascii?Q?XKUHjyeb7o6puZXueEylRh6A3LpuwSDtAHqrDzJGtVKNFMTSfkQ56KP3ucFX?=
 =?us-ascii?Q?iTFPwjHOfdghK6bMo/CJWqYHL6ZjpyS999CXTsVOMzYHkIoSRpIyjDs0Retg?=
 =?us-ascii?Q?xEw6Iw4OmmncdLIXyFzGKSge2jGQezoMIHxu6zpWAwfaLlnRhnAujRdd0f3n?=
 =?us-ascii?Q?evW0yRPPVs4cj8BNk/9mWvmJdgvUN7GwqlS60QbnIdfMHdhj3F4G6QkgSz52?=
 =?us-ascii?Q?R2SmCxctwoOlkwcrA0nGc0dU6DK17cGNgYyOQumFdMcQaraeQve5dach1GLq?=
 =?us-ascii?Q?Ux6JTev6JJC7iWlEuI/K4wEom/FvdngE06sso2wgMkmoN+EUFGLYxmNTK4j7?=
 =?us-ascii?Q?7ZARbhtouW5XmER4U94bgFTgEpdf6ApMSMXdX9G3l9tgV4rw/gDbEMAlNBNr?=
 =?us-ascii?Q?iD0BTCAXVmhfZitrXiEQlGuEYD7vcs6gwegeCeR0z9jxXFHzbbd9QvMtVV0d?=
 =?us-ascii?Q?VxIvANZhC+SEKhrBIOLq649UMLIH5N32ewSIfc2f+d6Q9nUKBdb2DfsI6mNj?=
 =?us-ascii?Q?gmVcFWLozz8bPFka0vGDi5pr6Vb7tSpvpguEvXZ0TKPdDb/pxsidf7qbUbEl?=
 =?us-ascii?Q?RS4w+aNlM+RNGYS10Z6Z1p+nQk3BnYInLY7V0syyqX3E5EZlzeXjGgt/dESw?=
 =?us-ascii?Q?nVOcy+TkYMfvzkKidIIfCXJvNY8xX4mJs5K5HprWPv9/dz60mYjWv0S2HmNT?=
 =?us-ascii?Q?BEnHbzUsfSHQaU9U7qR30D0CiD0dWyHosWCHQ7WdzUHpDWhH8rcyzbUA8no8?=
 =?us-ascii?Q?mFOKcTE6ohCrRaoKfL3fA5aUXPE7QlwtfM0XwyPMA6V0fsu8hMC0jFvxaHQG?=
 =?us-ascii?Q?Mj/YlHGkWd8cuEtZPjTxZbic6wgvZojqb+d2kbuaxGeOKoHxiex08qoHMbUE?=
 =?us-ascii?Q?twKUM4bTFJm31pd5FHy+JIVf5hjI9w86Gn7FiaLJbgVBWcKIvZf10+03WAFj?=
 =?us-ascii?Q?iYsl8nUtlg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Kpw2l3ZqPQOH4bQywqr1IEojCHB3CDFIOkdvh9C5udicXUOxwmdgPSjVaD1IcViewTRInfZRx+p7UtKdFwYJqBzWQNIgZn1HeuvCQzQhwWdiiG52FSkwRVVy/sDPAIAtaeNJTC1kcmIUenbSRJAesKnqFgyLXqvU0FNSlG0beW2zZdKt9nFdWXQXdhcctlWIrxYz0+QHRNpxQcJXsKKSDWyE1z3BVjdoyBzvhkq+VEC4ecN34J4c3wMOzN3/6wW3VdxmKpZjPJuYszgspeWF5zuMH1tNrn95gA7KqXyEmRtkjFGLuVI6DtF0VO7gJFxa4J7a9BMhgrMdEtPIAkdI8w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af4ff83-af1b-44ed-0026-08defdb57db8
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 05:48:27.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4LRajn5PjG9iPUvsdIwQHDy4O0cD5H4UQyCs61Op0GV2p0Ng/ie5g4AtyfP0w1yGvDGnJ1GHwY/1JetBsjmUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6855
X-OriginatorOrg: intel.com

On Tue, Aug 18, 2026 at 04:42:38PM -0700, Dongli Zhang wrote:
>The commit b2849bec936b ("KVM: VMX: Update SVI during runtime APICv
>activation") resolved the loss of EOI issue when apicv is activated after
>being inhibited at runtime. However, it does not resolve the cause of the
>runtime apicv inhibition.

Why lead with commit b2849bec936b? APICv is inhibited and re-activated for
other reasons regardless of the race below, so that fix is needed anyway. The
race is at best an orthogonal issue.

>
>The inhibition occurs because apic_base and the APIC ID are not updated
>together.
>
>Although commit 052c3b99cbc8 ("KVM: x86: Reinitialize xAPIC ID when
>userspace forces x2APIC => xAPIC") reinitializes the xAPIC ID to the
>vCPU ID when userspace forces the APIC to transition directly from x2APIC
>to xAPIC mode, the updates are not performed in a single transaction.
>
>If another thread calls kvm_recalculate_apic_map() during the window
>between updating apic_base and the APIC ID, kvm_recalculate_phys_map() may
>set xapic_id_mismatch and temporarily inhibit APICv.

So the goal is to avoid a _transient_ APICv inhibit in a corner case?

If so, please spell out in the changelog why it's worth fixing.
