Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6770390C9E;
	Tue, 15 Sep 2026 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464447; cv=fail; b=LAR2BoIwgypGRfQM3W0Yu0bUyRt+GW8cGzat82Zw32GjiRKUQu7oAQK0MWWmyjosL+pSwWrYQ85aTrmfTc5zReVXzvIMW8clPsaSs2XfUHggGiAXEEUGsae0C9sjCG6yeHMNpQgjfbF10YeqFVbNzLamd9hRlfpK89jh0yIF6Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464447; c=relaxed/simple;
	bh=vhqRtbQo8HyZeZkha2I9Lky5oXww09di+r5D7xM0SQs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TUct6nl/WRk10EwOl0OjpB1Gc21QVGpjNRz79MidKT6+0tWrJtAqaqDmF3xoR+PuoOv5RWzEsYM/KrxhBtd/tdtP5G4MZmvvd+Fonoorc2cPWu4a70jYyT8VEK6T26th0qSvJjmWWmqtbAXZYpM3VFeOdd7jzwsskccJFuE03ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZTbu4Vc; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZTbu4Vc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789464445; x=1821000445;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=vhqRtbQo8HyZeZkha2I9Lky5oXww09di+r5D7xM0SQs=;
  b=GZTbu4VcSsRwNroMvUiI1qAsB/p1nRwjT/jRv0CxkVf6lcdFj6A5b8Oq
   OsebIWqacNbV5Tvw7hKGbJhU59ojkZ88nAnrNKjgOb88yD+7KqWvMparG
   G3jYUbBYVbA0qPb2PB2xIMeHhnfTyszfEHecLimuLHUGA5uVppsQqvBkA
   Io7aYJzMIMIqoGXsjflUTUrUlpvyp9p4mVoqoYUPkJ6XQE3vgC7tePoyI
   6qK2nZZxYmnz5Cbz3mK1LAyZyojR6Nw9TS1naWI9zfCX1v59uIsU0d+CK
   xSWwRatL2oWoI+OPm5a/3cYTKaSYYEPyUFd0McNM4dUn3cMJaJsQZytCN
   A==;
X-CSE-ConnectionGUID: tF24UMiGTNCo88w2QcYyZg==
X-CSE-MsgGUID: Mah6tfPhSIiNZJvqzzSnYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107333590"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107333590"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:27:24 -0700
X-CSE-ConnectionGUID: LGTdOIv1QDGAc4x1KHhL3g==
X-CSE-MsgGUID: GLBvjkJvTiOZK+Er0oK87A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277063407"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:27:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 02:27:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 02:27:23 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.15) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 02:27:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpGAy1lvETgHdBoCh8YMbrUju4nUH+c+LBPurKziYGo7bV6pkXMusbJyb10FdAUp757FlAUk0YbNYoPwK2c5uOYGWXhrUHyrb8c8NRBtkeQP8/pjaH+Qfy5isfPT3wsDchzYeJfD9hO+SG1LqooHZD5/QVqlVQOid0l8pX2KbfLLiz8oBji/XKrdHX2i4qAQV59dV8VQ4PFvNWP6d5cEIX4SKllkqn0CUqlNO9El5Ni6RfCqP2n5VOCr9GSZpg0+p5/+sED1+K5J51aB/t1nMVgG/ORA3ZvPQn0Pymuwb9HOO+sw3ItTqF63D1UwYku+BWZ+HQX8sBSKECPNvb3CfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jr6Rp4km/v4/5EHn3lKTxVZjiyxsXrLLQgu8GaRff5g=;
 b=izUsJXYZn+nxCnAD8cAne9jES692qgWm6DzUlj1HKfA9MGaN8WrD+BfkjX+fpYmsO4MO3+JSQDOu77RliegT6ZZnoVyDkkmpLo8hI8N9oD5bWjTCfNENR6zn12Yrq+/V18+MkosAr5lR9K4mVdB6+4aSpg4isgCtlguWmWwpdiEjNv1593diAAgpNjQSXVkNW+z06SexYwfBJolq+ERBNppS+sMu43KTAeE0dQ+gAD27ssG63BR7e5MxFABuQfdXxryZcXeG+Ep56IH/IWbM/18s6cpaaQjgCA11mMZwu/4UlGMIv02Yv5MM8LPT7a7FN5Eh9GKn7kboHO9geJrDsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH0PR11MB4808.namprd11.prod.outlook.com
 (2603:10b6:510:39::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 09:27:20 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 09:27:20 +0000
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, Tony Lindgren
	<tony.lindgren@linux.intel.com>, Sean Christopherson <seanjc@google.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>, Peter Fang
	<peter.fang@intel.com>
Subject: [PATCH v4 0/4] tdx-guest: Make Quote buffer size dynamic
Date: Tue, 15 Sep 2026 02:25:59 -0700
Message-ID: <20260915092632.2822169-1-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::22) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|PH0PR11MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: e3cae64b-d17a-4890-4e03-08df130b8aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: GNZxqK4TLsPT/NuzCO/DeMdkgLLxVHx/Fdx6HaIiJG7KQDKkl2yBxbQ1VvAXLfWSsMJ1kTSJugyR7KrM24ayU+Np+3fp/skUwsp1Yr7QyHxbN6tXmEkEm5Lidj5jvqoKaVzFlOHnmg13TNTeX31pOa5BI91A3H8MD4CrhcOCq5ycSjCxyLxkGnlh88knMlWvjBxNWAsKxHuYMeW7mh1hPEvX6kShQKTp2jS73xxLfmDf+0sWLGm3iKDjUmEpQx1+ADlxQIyHtJvraMtuai1Z7FMpInUJ5afQTz516EtHRV/h/UuKhbHf8uKlwfnbB7DzDKt5GvzIQdxhLsCE25jtlG8wXZaxyPRcTEalyCD5Py+JMbrW2qwiNoHvRRWczJm85pfr6U1rFTPikDbsjADUP+oTd4eBgBpx6JIUAlqxbCo+oXKU13Ys6grDPJRkWgKtXFiCtlsU+59xK4+LBZcQ1TKaajCPaJD1/JTSkQ9JxYh3q3Mswoozql7/m2dLoESc8B5vazJHW4nVIBbNjk6L8Es2etc8htSU3LIh6nxRUn42tSRzDwluhyrkTxq8SpsZNfidSKom6mvMxPOfFan0psjAAlozgBt7PCk4BqBU342xksyTfFPBxKeHmh2XhRzwBe3tdl2mexxYLB40jAJuwbd/nwBrxj+KsQN56X0tWos=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SDYVY1sKjKwEB73/SG+2sulZOiEmz0OinKA045vosQ9o643WvVyVuU+BgPII?=
 =?us-ascii?Q?yGe/ij/VPxH3KdHJEhEk3wLdU1xqvM3+OfPjjQRjzlWNyhuMk7zEsCXIMR6z?=
 =?us-ascii?Q?uTGciGRnVZAHNdykdtmKtA+eBalG1k0hi9qN6dU6U/rVTiMvPGHYFojK2wN/?=
 =?us-ascii?Q?mzwIAOnN+lYywaDMEvKUnVFvLqG0sc1F4BGFMDLdDD7Oasl4COUyzuKI/ndk?=
 =?us-ascii?Q?yexF2SVa67BCu6/SdchzNulGruuE6iL0LZ0jAK1t91MCOpIqJxUEsttZEf3v?=
 =?us-ascii?Q?ijbm9S7oTWUh602IBcpQrZE7HoxJVXo3+GFdURN0HsxW2MSxWC+u64H5iFKE?=
 =?us-ascii?Q?dKqM42/mJuhDWtrhSCR/P04W/6qbMSVjAkXVhqVhjj8sq3/kfnueluCGOB9K?=
 =?us-ascii?Q?vret1tLSjegi0adEen1oKAUS3y0qYipWaFP+/MRSr2puyyKZq4K2gZxY3p2a?=
 =?us-ascii?Q?7F8ty8nfCAsUczT4JGngwUxk1sVriw+SgQe9M/S/ILjfCICJy79rpZ2kXn3O?=
 =?us-ascii?Q?vfzz6wLo42R2qTnD5aBoWErpZrcpuycEuSlwxFmFdMZgazZ30vFDiTfnzmrC?=
 =?us-ascii?Q?2SpNUzmj/R5OGY1g5Dqf9akQuxwbawYvw+YsutAYDXbQZ1odjbDwu2LGel1v?=
 =?us-ascii?Q?9H08D3wAeID1ucd0P+D+aJPHlKAGpo9T7E14rcqaqpiEBWo/xDcxvDcbsci0?=
 =?us-ascii?Q?Su6nQQHRWbK1CxikEK1wytdUs9Fy4JA1GhzW8TUfYodo7NV06vIWIQwvm2Pm?=
 =?us-ascii?Q?lwjOoXe219wHVJvNTwnV08JXHfmvv3KL4whMw5bZqXqK9jr08L2cutuCHp+/?=
 =?us-ascii?Q?xxgd1Gh4uxcWqMEzNS6qZ4MfESjRcx0JqbPIEmk4350iAiOvsbOkjDjAvXcm?=
 =?us-ascii?Q?YCabgvkEbODh7a4Is7Pr8hve85WAr0coKHXzdaJZ16KfCmLgBrtDshaCcJ9L?=
 =?us-ascii?Q?PmwelVpiND/qqmOf4mgt2TPDDXNk1NFzAoqPXK+npt7fv71Kqyv9xg8E4iGa?=
 =?us-ascii?Q?BOIFW41uQNJ2erJ5EQt6bZQoqbw0xpQPFVYYJmCikybdLMtVrBgIqYytvgs0?=
 =?us-ascii?Q?Zgq+9KAipXnMmbPc+qo0fEr6Nqv1JJAnmerPegHYBo8R1w+7ZZ1AVtZF6B1y?=
 =?us-ascii?Q?KUxI0Di6ApRhhHIqK3OeJclu2HmKjRsmTPpIQwm6grmWAl54N7I4e6O1MwQS?=
 =?us-ascii?Q?9qheFu6jT3eIxKxPrFcEZDTCTrTTbW9KJ+T766axrbT1tqnTrAjjp00tXG5q?=
 =?us-ascii?Q?KvqgPCMB3p84q9BTizgI2xE5X+8IbWPap2o9q348LESh/R/tI06dMYQq1L9q?=
 =?us-ascii?Q?GXXCqlFCwQkIZcbbOweRBeyKstIovMyslUhwzL7myv9Vt0Pmc1mY2Tj9RG/f?=
 =?us-ascii?Q?ep442TIwmNgSPMnjOX2/+jMcLZGQIcEjRnhvI+T4QeHsd+63nlBgTbvGzR9b?=
 =?us-ascii?Q?vTqreTHi7GGCqKH0oNWGd21W+JiLoNVh2+q4NuBSFhu1xUXGyWZNcoC55bJj?=
 =?us-ascii?Q?UXXFg9JDMKRGyh+Qh7/6UQNs91x80dGRtJS3EjuDdwU82AYcAGN4vuLTN0CH?=
 =?us-ascii?Q?rjlqISmL1w0d9EpOc2EEqMeVCOPnNaogEo1AoCCGxU1UQRCuM65yeS3WwFu+?=
 =?us-ascii?Q?QxI2VvuhzHvJVWZxD6ffXYZrvFo9VgQEVQeBBThWYgMy5zDepOfpMz0vIFxZ?=
 =?us-ascii?Q?dey4D8QNVWZptNQvi6Nv6/D1gNZFqrndwOWZdJ1uc0UJwAcX24Ek3JpA54U1?=
 =?us-ascii?Q?07yX7ulfOg=3D=3D?=
X-Exchange-RoutingPolicyChecked: k7PLXwcNgSNwbtFX3/Qf6j2KOzIITrxYAOV8qoAzoV01dcuM2TmKgrYvzki/byRcU7rGUPy434P1BmmHtiVk0llQMg3Q5tTkGjqAnAHsTMUJ7Fm0LIUMgsDWEq/HZD7gPO/Jqp8RLoKNkZzRrWv3jbvn9KQoT4zUSk8WRu6Lj6pqif1mvT94e3E6AmTS7G6gzRJzggPCuPte6nnZUXCx1+WWt8xJFaNIb5fmhc7CH0wNnzPI99GLmKOvA5u2c0WZKY2czRnfR1OoPTDGnOa0g3xojfkWlgm1iDw7ihNI6IvDdp8YoClHrRnzMDGqUV3uVBV2OJnUzNd+cEBHN91Ssw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cae64b-d17a-4890-4e03-08df130b8aef
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:27:20.7472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0LJj9H8CSIi35A90oTj2Uo06avAqZwkU/NIMlS2BiW40sizHXnDyHIX2JqqZCUH72JQolWoHrQpr+y9Jhctow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
X-OriginatorOrg: intel.com

Hi,

This is v4 of the series to make the TDX guest driver's Quote buffer
size dynamic. The only functional change since v3 is an updated
TDCS_QUOTE_MAX_SIZE encoding. The rest is documentation, changelogs, and
stronger page alignment for the Quote buffer size. It also collected RB
tags from several reviewers. Dave, Kiryl and Rick your review would be
much appreciated.

Newer TDX modules have an ABI that tells the guest how big a Quote can
get. The Quote buffer no longer has to be a fixed size. So effectively:

  s/FIXED_BUF_SIZE/queried_buf_size/

...in the TDX guest driver.

Terminology
===========

A "TD Quote" is an attestation structure signed with a platform key. It
contains information about a TDX guest and the platform it's running on.

The "Quote buffer" in the TDX guest driver is a memory buffer shared
between the TDX guest and the host VMM to retrieve TD Quotes. It has a
header defined in the GHCI spec [1].

Device Identifier Composition Engine ("DICE") provides a framework for
layering attestation evidence. This replaces the SGX model of contacting
an Intel server to obtain a certificate.

Problem
=======

The fixed-size Quote buffer approach is not sustainable. As
cryptographic algorithms evolve, TD Quote sizes also grow. A previous
commit [2] increased the guest driver's fixed-size Quote buffer to
128KB to accommodate DICE Quotes, but it may still be insufficient when
those Quotes use post-quantum cryptography (PQC). PQC certificate chains
are roughly 10x-15x larger than conventional ones, which can increase
Quote sizes significantly.

What's in this series
=====================

To avoid changing the driver whenever the Quote buffer becomes too
small, newer TDX modules report their maximum Quote size via a metadata
field. The guest driver uses this value for its Quote buffer when
available. Older TDX modules continue to use the 128KB buffer.

Patches 2 and 3 refactor the existing fixed buffer handling. Patch 4
then makes the buffer size dynamic.

The "outblob" file in configfs-tsm no longer has a fixed maximum size.
The limit can now come from this new TDX module ABI.

Patch 1/4: Add a helper to read the QUOTE_MAX_SIZE metadata field.
Patch 2/4: Calculate the Quote buffer size with struct_size_t().
Patch 3/4: Store the Quote buffer size in a variable instead of a
           constant.
Patch 4/4: Allocate the Quote buffer using the queried size, when
           available.

AI use
======

I used Claude:claude-opus-5 to help edit this cover letter and the
changelogs, and to collect the review feedback on lore. The series also
underwent AI code review (Claude:claude-opus-4-7), but its comments were
limited to style suggestions and existing issues. Sashiko's __GFP_NOWARN
suggestion was adopted in v2, but it was dropped in v3.

v3: https://lore.kernel.org/all/20260729122939.1340412-1-peter.fang@intel.com/

Changes in v4:
 - Update the TDCS_QUOTE_MAX_SIZE encoding to 0x9010000200000007.
 - Provide documentation for the metadata field. [Rick, Kiryl]
 - Document the reported size's properties. [Xiaoyao, Tony]
 - Page align quote_data_len unconditionally. [Xiaoyao]
 - Collect Reviewed-by tags. [Sathya, Tony, Xiaoyao, Binbin]

v2: https://lore.kernel.org/all/20260717214349.4075994-1-peter.fang@intel.com/

Changes in v3:
 - Split the v2 "Allocate Quote buffer dynamically" patch to do the
   refactoring first, then make the buffer size dynamic. [Dave]
 - Improve patterns for readability. [Dave]
 - Drop __GFP_NOWARN so an allocation failure warns. [Dave, Rick, Kiryl]
 - Add Binbin's Reviewed-by to patch 1.
 - Drop the Reviewed-by tags (Kiryl, Binbin) as the patch was reworked.

v1: https://lore.kernel.org/all/20260612110853.3188196-1-peter.fang@intel.com/

Changes in v2:
 - Collect Reviewed-by tags. [Kiryl, Xiaoyao, Binbin, Sathya]
 - Keep the explicit (u32) cast in tdx_get_max_quote_size(). [Binbin]
 - Calculate the Quote buffer size with struct_size_t(). [Kiryl, Binbin]
 - Add __GFP_NOWARN to the allocation since its size comes from the
   host. [sashiko]
 - Rename quote_data_size to quote_data_len. [Sathya]
 - Drop the Assisted-by tags, as AI was not used to write the code.

[1] Guest Hypervisor Communication Interface (GHCI) Specification,
    Version 1.5, Section "TDG.VP.VMCALL<GetQuote>"
[2] 43185067c6fd ("configfs-tsm-report: tdx_guest: Increase Quote buffer
    size to 128KB")

Kuppuswamy Sathyanarayanan (1):
  virt: tdx-guest: Allocate Quote buffer dynamically

Peter Fang (3):
  x86/tdx: Add helper to query maximum TD Quote size
  virt: tdx-guest: Calculate the Quote buffer size safely
  virt: tdx-guest: Use a variable to store the Quote buffer size

 arch/x86/coco/tdx/tdx.c                 | 24 +++++++++++
 arch/x86/include/asm/shared/tdx.h       |  1 +
 arch/x86/include/asm/tdx.h              |  2 +
 drivers/virt/coco/tdx-guest/tdx-guest.c | 53 +++++++++++++++++++------
 4 files changed, 67 insertions(+), 13 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.53.0

