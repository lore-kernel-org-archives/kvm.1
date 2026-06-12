Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637DC390219;
	Fri, 12 Jun 2026 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262615; cv=fail; b=BrPVhZJz1YetE7mgx00THT+CVZ47ZuP1dH73wRfy4i5TUVT0YvXcx2Yw3P2TcoInPwWaY/j2UifbmOwt2dR7O5qUSwt3a7THDZY/8bd7ri0xlGrfIlLMxwijZpj3KGtfb+x+8xB3WMUcty7McRwG6uSmxJhYVq2iDwIOvENtjY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262615; c=relaxed/simple;
	bh=/8MGwZ8WZoGybHd7in868DPqxpagnIqRS+u9xMdOSkU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D49maxzpN77NUWd0SvTN0aaOSfa5cF4eOYaW9G6dUjps8jCPYpcz7/fbSX9ETWWhgAbev42/R05emw9pMkUGhqcLSbcWzY8GnfoJkkJbT1Tj2cTToVvh9bXwfmRGs1lWn0aBICLoRKeFcqzUoGU1dX0Ve9SgrdAH1HBzLoDmUxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOvqGTkS; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOvqGTkS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781262614; x=1812798614;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=/8MGwZ8WZoGybHd7in868DPqxpagnIqRS+u9xMdOSkU=;
  b=nOvqGTkSkyN0UzjikOCjATYpF4ZWexW/7ZPLAsLgk38qHGCgMcMjx5Mx
   hrAr+0RUWSHBFbay3+RNgeQ7XB8vd9mgG3lZNzaIVETY9f8DsC1jd8Gzd
   Z5yisiTAlrPh4U3LhkmJPICHp3AgZSngJzFm5RLzKPgFSD75gaMKCbTGj
   aQk9uspyqVlLw6Mft7wz4As9R2nCowTNJ1Ti8Kvg+bgEP+TSvZVuz4idr
   JMUam5oxQrj6oQ/YctBepF7IiuNaHrxKVINWcNq+iWJPF93cuoCim/bom
   pBIFW5cZmZYajt8Meu5FB2015wg+LJZ5o4Gyl4YZm8nFWnT9xOuWOe5Yj
   A==;
X-CSE-ConnectionGUID: OiaNqYNURYmtBuAqIDGoGg==
X-CSE-MsgGUID: O0F7hacZR5yuFEVtU87nPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93581377"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="93581377"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 04:10:11 -0700
X-CSE-ConnectionGUID: w8YuK/QfSue8+ruNAYzFNg==
X-CSE-MsgGUID: E42F9GOBRdmWc9vk45hf3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="245904941"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 04:10:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 04:10:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 04:10:10 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 04:10:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVRLIJHzrVsaTxAYb1Et5ypW8DUwFokLSg9gRo7zsz/9LEC7s7manaSjTwJe0eTTzwVfb/L7E2erqICs3vhvDBGMOpSsQEDdhfcIIatoCzkuXrsVGVBmNqlSYLtBFUhqxX/kSACDc6bQlSrzLHeQkoa4JheRu561dGu6D8DW6yIwD/l43KM4P+OkvylKElnPCXUok+fmD5Ciw3YAJbrph+awTRAQLDifbpNl6Uax4erg1Jjl6Dzdw+kOdbmW0c3Lt5DgJb4IOWOIBLgZhzQpyc0EpYOWtkedAsYWWmrcJUjGcN1LUvHyWbnQ5CurHyXrwD5c+S7WZiKMQALgxzkrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzgJBLb3K2zmftzT5IvUb5wEiWq1fqLOiA4xYBdiBZ4=;
 b=n5pN/4OQbNb2dhvVbd45IIieXVmhM5OZH8EAWSu9vhaeZ1KhZ5roO4r+0i0w6HHX/Ebc35JDwWxwJAv0EwBxdP4QGLwBxPgTQwbQo97YM4qHQhq0QXXpVdyErYuJ1tBVM/JCUvMFAlnN/jmYQZQJ5pQjuqKJo5VKyA06NGJQcwM8t5nqGOvTwagBbib4+c6ARETcw4g8vETXULEHnJFPoODynEEffv8/L+OfdAVBvSM7IY0wohIO7Ufdo2cXNLtgCI7L4SJJBsJHhPi4oPxFAKI235vWE+dcEaqVaa0UzKybtmMY/Jr9HRII0r07ikqasOkpr8r4Q4JFh55FmLH+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by PH7PR11MB6452.namprd11.prod.outlook.com (2603:10b6:510:1f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 11:10:02 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 11:10:01 +0000
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, Peter Fang
	<peter.fang@intel.com>
Subject: [PATCH 0/2] tdx-guest: Make Quote buffer size dynamic
Date: Fri, 12 Jun 2026 04:08:47 -0700
Message-ID: <20260612110853.3188196-1-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:a03:333::24) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|PH7PR11MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 2165a19b-550c-4a8f-5919-08dec87325ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 103AQgixnMUMIxp+56vN9vHZIKBVJuVsgLqT7sExIjeT6/6nWyFPZzcckEBEKH2+2Psidxy3zMFhCHhKNDLbIBForCfXeqyo7ZeJfziOpbjvKhwwwuCNI6czGP9GI6xQE44vx/P8JthzlM7hZ/i+/qKI3TKNXSvmxBuwzDQZy3lfESNHzGaIbeSxUmd/jj6KfQAGDJCIpGN5IDt6DYQ5zZcjR4RpsxLv0o2Yf8zOnYsSO5taSDh1PNH03+Km+/m5B1VlU3vGPcZRdXcPegEd23oYTsDbtFMWJooSpbGl4xBu1tqlWBVNlmiiz0u2/uGJrI/piGNhmbvKYvQ15nOOW9lj0FsA5snJI0t7SgmRogqRPmTRbDopg/xK4p1wB7Tqi97ObAILvyNmJPjxNuHZqykB/0CWT8wYde0ocBpWciXMKbvWPrb+PAl2dgyYyb7aLACVeGgfpcJHa6AVfygzUXVZQAa+/Fkpv4P/z3RU+YJXShkVbagbQ1qPouZngTkBAnDXBJ+zWUWG0ej+byrEjrrvDgoYt/FNNXd4cKWV9mYzJeTgpSHG5XLCFeQqdNKDELO3YOhfFC0ce/dOseu8k8Kr/zrC89IXFhBbV4H2R5ZT/yZ8HfsGURRJgSuh5oVmxyFYEOqLOMiRvRWQzHhrnrpG9zTmsBpPsEv6QsySuaYRIASL0HStAtDt1OOKY0Vy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FCawmFWMx4lMMJ22koy+uSg/tDj/tfOz9dnZyjDW6B+XjKy8zcTdBghTyvO5?=
 =?us-ascii?Q?tGY5x0DN/jOypIrnzKjA+aIp7cXAbUFZeQW60U2cGJQYEBi8GX+WIIQeCqct?=
 =?us-ascii?Q?kunvgg9ClCAijJxQbawXtHxJO+R2cGfQF+x8sdPC/eP9oJXT2C7iIfKmBqKu?=
 =?us-ascii?Q?QMrEvtH723GdQmalF8QObtzfOBXge7WOlZGG2MpOaVSkrTxbxtoiWiHGQJQf?=
 =?us-ascii?Q?OjyFTp66HGypDcCg92eViKzluuQUgz6UjsbMF3mYPZuXkjQ7esCtKPy2nAAo?=
 =?us-ascii?Q?xQa1ZQp3RuyZaDhvH1Mjt9eyQbmv9kCAxUAt/WOyHE4vmnW2Bcz+JiFuPRJJ?=
 =?us-ascii?Q?URkPwWX9r8CshjApfXrswj/GD0/1CScYslIGrqHyAXXXmLil5HysxZoi3EH+?=
 =?us-ascii?Q?R8ai3Qe3FYmRwDmbUigwULUb7m13PeMmQmKr4LJTL2qK6DcOCmVrypeLVgOc?=
 =?us-ascii?Q?SYmErxJw+dH6GiDZcmr9OAX4SGW81dwLlYKi6bDvHmA+l78dPjszVwoPwEFx?=
 =?us-ascii?Q?gFuymC37y1tqFbdG+5yMNFV3oQ9Xjt2MZAlsGEKM5x25qdOFHuMY3vgZFyzb?=
 =?us-ascii?Q?t7dTU1o/k2UnR5vGfTzX6zH6bFi9yLMA38iLnOSL9LtTq9nfp/xxnqS/x4QK?=
 =?us-ascii?Q?mcVi3YBQWrMdZMk3JQjZywontDIqAwwNepv4GOhDLR8cPf2mUTPXp/0rb5d6?=
 =?us-ascii?Q?pNb/i9en9PI+zv7hwWAzyoLbe1zGk50rX+anKd6xfuWIkJ4G44OQLlwK7KkU?=
 =?us-ascii?Q?YJ3fGZzix9ufeNMR8Av7B334j5A3oCJ7ikCeZnid0BFUNMpydIqAWWw3zQ7o?=
 =?us-ascii?Q?W6y3jZjIwQp+X0pWJExIARjEbTE+8FXUBpxgth05wYff01SkN5yz8Oz/w4CU?=
 =?us-ascii?Q?rW5eqWjtihq3d2QKjV893AUZxTkUYgvVVhRZ499HD7KRdrwUY1kHgGQ2ci26?=
 =?us-ascii?Q?GIJFQNeZf2wO3WGTmz+fl71XSRtqr5O9jPDovwVTjJeDFqmPZQRcfll4ux4m?=
 =?us-ascii?Q?gtxhCnjkjVlfGl9UMWAdVyWrU2m6+CtG38fBeQteKBkr1soKxGtOtVIep2+v?=
 =?us-ascii?Q?dfPSsl1lWfozm3PVl41i1Z32jPInIyU9SD13CbS4fyrAAEydAVywhBS8MUQb?=
 =?us-ascii?Q?uQ4i5+sI8O43+P0MmVOJ9J1uErKuwc9a/X8xTTKfmGRJofHBqXZsnqIhUkNo?=
 =?us-ascii?Q?RVumGXXESlrRbHr3Ql79Pl64RGueMsP3xKGmxLeiGWdP+pgT67BCuRcrUpcp?=
 =?us-ascii?Q?cPDyPf4HzkpsL/qtn2FTBio3YwP67+0bm0rvFR7peCxSDEKAHi9ataZnXVi8?=
 =?us-ascii?Q?ARxIaIAnagJkJ56aEesdyRKSP99qmA/wPsMj4GJsGs/Foh8UOS5EAoiAItng?=
 =?us-ascii?Q?T2w8kiEwvb3t68VdUe7w0FvE9tj2SI3l668mQCBvTNLa5CFrHPXbi87v6/la?=
 =?us-ascii?Q?1aHXA4bRC8WsxOSnRtkECcRSvIaq87XnQKkKdFBZT5ZzqKRv1O2ZRq7FIpeS?=
 =?us-ascii?Q?PbvspPthac1senVxToMdvc4SOTKh8mjNroapEHSrP4AaMUGNROTdGyVMGhxW?=
 =?us-ascii?Q?5Qg7SmcUcwJ1xDiLPz6iZm1K4aJ/4uRHt1a3buibOeAzSRtmG1u6hiLqJHDk?=
 =?us-ascii?Q?AtX+er0IQzVOX92P8/kb6PyGJrPi/GtKFl/FdLDdb29fa+c7Q3hx4wFDXmoJ?=
 =?us-ascii?Q?3fj8100njTUao+KJZfBoNRap7gt20C+hiIHNP/kzwy3QLW9Lj8THUTKB3lrx?=
 =?us-ascii?Q?w3//7mL+pw=3D=3D?=
X-Exchange-RoutingPolicyChecked: CqfR83JtqkGSgr+oa4GLUwGyYz3aKYpXwGhdZiTILvs2Nq710NFlguGnuxCTZ4XP3KXKy2boHM66w5kqDDPMmbj+/IGnFjNppz0Y40JLGxvAydzELGet4yIZoOEKeJThBsEcYHOzxAbFz2LpBgzn5l32b2GA1ayPPGtpPgmITlRO2bTOsC+o+if4RzDrN3kMS7i+TXqTXn6tSI4EqFCETkUuGNO644d7QiOn3gmXNkGWt0F+iWPTAdbXBFr99JVt4b/Oda+8s7XtHfCdOEu4mDAAH/261fQZwa+6gHK6BE0s4G6lygzbgxARRnaA5sOm/DvmE8g6qqIJOp1ntDuRlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2165a19b-550c-4a8f-5919-08dec87325ec
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:10:01.8823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSL1UJk1jfrtq8eBL0ZeEg/ZwBnd7KAz+emjzFxHzcxlYWZKTQ0/T2vZ+tuvyFPxcI7p19l4j6btXValT+xHbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6452
X-OriginatorOrg: intel.com

Hi,

This series changes the TDX attestation driver's Quote buffer size from
a fixed constant to a value queried from the TDX module. So effectively:

  s/FIXED_BUF_SIZE/queried_buf_size/g

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
commit [2] increased the guest driver's fixed-size Quote buffer to 128
KB to accommodate DICE Quotes, but it may still be insufficient when
those Quotes use post-quantum cryptography (PQC). PQC certificate chains
are roughly 10x-15x larger than conventional ones, which can increase
Quote sizes to several megabytes.

What's in this series
=====================

To avoid changing the driver whenever the Quote buffer becomes too
small, newer TDX modules report their maximum Quote size via a metadata
field. The guest driver uses this value for its Quote buffer when
available. Older TDX modules continue to use the 128 KB buffer.

The changes do not affect configfs-tsm-report ABIs.

Patch 1/2: Add a helper to read the QUOTE_MAX_SIZE metadata field.
Patch 2/2: Replace the fixed Quote buffer size with the queried value,
           when available.

AI use
======

I used AI tools (Claude:claude-opus-4-7, GitHub Copilot:gpt-5.4) to
proofread this cover letter and the changelogs. The series also
underwent AI code review (Claude:claude-opus-4-7), but the feedback was
limited to style suggestions.

[1] Guest Hypervisor Communication Interface (GHCI) Specification,
    Version 1.5, Section "TDG.VP.VMCALL<GetQuote>"
[2] 43185067c6fd ("configfs-tsm-report: tdx_guest: Increase Quote buffer
    size to 128KB")

Kuppuswamy Sathyanarayanan (1):
  virt: tdx-guest: Allocate Quote buffer dynamically

Peter Fang (1):
  x86/tdx: Add helper to query maximum TD Quote size

 arch/x86/coco/tdx/tdx.c                 | 19 +++++++++
 arch/x86/include/asm/shared/tdx.h       |  1 +
 arch/x86/include/asm/tdx.h              |  2 +
 drivers/virt/coco/tdx-guest/tdx-guest.c | 52 ++++++++++++++++++-------
 4 files changed, 60 insertions(+), 14 deletions(-)


base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.53.0

