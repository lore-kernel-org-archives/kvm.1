Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A766A48AE17;
	Wed, 30 Sep 2026 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764710; cv=fail; b=ZA4GWY36VOSwDQ30v5KkzKudqHvzUH1M1G/c/vKTi21rUq4hVLJQjaxN8wO9Vt6fgkUCnlcxfl30yTfbNo8Lfo6nRcj/LGdaJMHWbZ5vNYsWqyZvz1ufAS1CdyrD+ZIoJ3CEzXOjh0uJcFhaXd6SNs1gjlabckQ3pd8l6nQab9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764710; c=relaxed/simple;
	bh=PBL7uDBuSTYepnSHacRv2DIo64QGUB3pUplJW1fcX64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R2I9YoeHRN92GJbKUYMmZYlefISkXjf7NurVltqW66gJIiOJbsUmtcHMVFSXEj/ZGQYKMIrD2IZc3ZqMUGW7Pd2XVNy7h3gVGuCbV+Gl6DzPl5Nm326gV6kKL1/RS4uLxCKXVLYQpB3RT6tCVT8O1Ds4udhH+3WcD/WGX05gDPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTuImPQP; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTuImPQP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790764703; x=1822300703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PBL7uDBuSTYepnSHacRv2DIo64QGUB3pUplJW1fcX64=;
  b=ZTuImPQPZEOyX5jZVxm/Iy8NTCAderVALJ2Fx9MoH4vJMt7+reUnmGl8
   J1pkJ0nb35saiICWrNS4xv7okwHcFxE9xH+1YMDf4vTXz12aLVTOYfFMO
   Sxr1m7uon7VB7kLt8eoTy5b8yyuyiJ0HFNNxh6ACgup0M4iHCf8PrZ081
   SP89HTqcD6ijf4w9iSjQSa+IwFXBhgrlUsjdLljWJpIg0eVocKN+g4v74
   +oly2CtHC32w4ZtfkZfFmuSEhD4DU301wlf8NlIl9KVrdXi8RYYn6TS8H
   VwljFeBALSF9JUKBt+uxCme9WFgwNrqCrNdgpUHlIbjCRREoXn65nMZqx
   Q==;
X-CSE-ConnectionGUID: 4vaUqMesTYmxaFMZHSoM3Q==
X-CSE-MsgGUID: hn7yiMzXTNKwXDQerdB/fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="117028824"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="117028824"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:38:19 -0700
X-CSE-ConnectionGUID: GknF+4SSRy2Y+zPE6voyMg==
X-CSE-MsgGUID: 4MIYD821RA6WArHOSK50OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="280393101"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:38:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 03:38:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 03:38:18 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 03:38:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsxpOH0SQi7cussww4tD8ZTSvMpNk+lYM5+z/1sqq0XXaI47XqoRWwlGbPzU7Pk4IXvw+9+Wl+UMoP3vnK6q/F5/Fvud5nd2HVg/dcm8K9kS6U3/7+gl5+NVqnczVw1eqMVULgp2F/+M/SaiZkoyQKQ7RepD9xapOQar9oPA4vreUj97a++Wvc56oXyM9dcGim1mL6gLPAgC+QKYXCmP1Vjfpxy+Y2e79SsveaBaHEHMuKWg+Ini5/Wl6r/wMf0SUT/AoeonwINRipABSsYdAc/6oSLOpPLpzbRlZVa6YgnZNeFejlfVquPa6Wt1cTnjdT8Wp0dhd0ym3zrF+QQ07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqwCxQ/5YQzyVpyDzZamDDsOcf9+FygYBDzhmaMskbU=;
 b=DeXECzPgn80wOh1O2hdpPiQOxmTn1cq2JspiqbIgCl3Mfx+/VgGwD8TfO+7La5DF4nuBt+bwiuIFCfC7edH3GpnndRMS/leZgR9BJ3BGNYuXPuUJ5CabquOs/tINgcR2Ico2bvP+cLFwXwbZ5BgAzth340SjzT7qVhy9avvS2ccIo4Arpy6eXGBN2hCFZWWSkBGI4pwpx1ErYWuL+ZwASBKtB5AOsfYYJyRs9g/L+iZQg1yfczZmOoMvIDpHGmtrgl4QG3bISnIGv3OI62UfwMetr3sVvRnoH+ttR4hikTupWkj2AQIXz7G1ysfyME2vifMbueok9s1rBjFoJHYBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CO1PR11MB5154.namprd11.prod.outlook.com
 (2603:10b6:303:99::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:38:16 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 10:38:16 +0000
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
Subject: [PATCH v6 6/6] virt: tdx-guest: Make the Quote buffer size dynamic
Date: Wed, 30 Sep 2026 03:30:55 -0700
Message-ID: <20260930103739.2851980-7-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930103739.2851980-1-peter.fang@intel.com>
References: <20260930103739.2851980-1-peter.fang@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|CO1PR11MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 7427aec6-ec0e-4434-0efa-08df1edeefcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|10067099003|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5lKRVJmyHfE0KD3iyDHBd+dfsfWgo7PRo6G5aWPgxuwu0USBwXkDEKXH4ZACPjPSQif94pv7WsDlKI9fsglcJK+XHz0Tj+6yBeVusEKQXfA9k20QqdyuSgH2Ot+e0VfaJ7LinBhIjFy1hboPnt3aOKvTAY5psHfO8QnqnLI7ZjlvqNjNHFDiy8qhXceBfeH4qIDpFE/baQFEEGqbmLgSbBwtQkJ/GCpveqOs6dYSmMz1xunPO8QtDbh0dkA8AnPSgd77gPaSOJjBqJHefrwf4tLasg6hf2IGR2AK2HC2iCRyNpHkgr4cCnQoTnsE06lXBkQTBJeErDOBIU7kVu+RbJjZ/xfzoiR4S4To52dCA4Lq2CHjSbQ+ZGiWGdwjZcxEGWX+Lb/Bx3oW+J8odfB12yhTOr/DHzCTF+nryiop1mxuPPH+UzZx99aTmJD37PeWGEmvvffxNaBJEIQJFBwX/vLSVTii1GT8EhJyX3zEAyDTbzpWTsnzAXJSwLZQz1EXNXL6xxa9Us0C4UfdmDD2qF+4xfBCvmlCVlcDNlst/cTz8GPL2diKOgGNmNJbtu62bspWa8am/LcNG6JGjcuXCyOa+Xansa9lwB3zgo/sbJyvoEzyFmILzDboMtGiPY2+bgUqKbJTuofxpb8TEJJ7xN3+zGPv0Km+Ik0BwlJXAmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(10067099003)(3023799007)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amSFl6kVCUijpnOYvuXKN1mGDsNfKJ1T8ZYeVRv8XLTlCTA0KTcd5BGDSzCz?=
 =?us-ascii?Q?6l7ZDxhu1hkWVZm2mOwQLrp3jaQLXL+m+l5NcPJ0ZG5lcD5cMkuyLXsKvMHE?=
 =?us-ascii?Q?xnPJDrIY/rNqjEQzF3XHWDlDy2RRtZR4+1xdj62npwBLZ7naKRMArwAnFbGx?=
 =?us-ascii?Q?3pyjvMnyJ8mfLEQhU2W7G1uyf9kdjLSrdpSuKCGJ1xwt+frXtdwjN73hFv7E?=
 =?us-ascii?Q?htA2UHVsMdfWaO6IQOjulMFcSRVcLhge9/QpWj7dfRwy3j3y8hfMjx/YSQnI?=
 =?us-ascii?Q?NWhqm2/j0yI7H7CeKsSvPrTfQFGbxnHJ/OPVp5Oi55uq4wcRGnnYTF1f0gu3?=
 =?us-ascii?Q?nqtc2eZ3JT/SM42y9ODf0DBPzgCeuesV1VfH3BtoezeMvoG6/X3UhW8aXNBJ?=
 =?us-ascii?Q?G/DSgWe8a4JNfmPzgAHEwdLYo0RROV+znia4FW+GWBWa1MYZzkS67gAkTUdL?=
 =?us-ascii?Q?KOGR4Qhcj7r4ePILkyUWdb/njoeawsN1iSYQ5iRDUoYkkueYRpt/6F2X9Ys7?=
 =?us-ascii?Q?IzQVSZUeCd57jBdrfEuBvk20v13Td0Dc42eZOfkLkEhqDUeri9nIKd1Wn58Q?=
 =?us-ascii?Q?nFTTt3xS67eQfHgLetWa8d3stIgPNPLIxTNZx/l6uyNBxmc3ugUSSvzDJEpw?=
 =?us-ascii?Q?MeCFm8Qa1A1bTIMOLThO6goAOmbG9e1kTIeGHsyi9/SbMO6Ron0aPKSKDCNO?=
 =?us-ascii?Q?uxsvTzUykYELJC6Oj5hw8O4amRw3Ki0tuYbjU4fzLs9tPS0ID72caLBc0RVd?=
 =?us-ascii?Q?Tz/+Iz/QWdLolsfQrAuJiUYXr2Ah60YX+8D2I2KC2R3ql7OdTyuyE1yO7S9p?=
 =?us-ascii?Q?OwlAVnUpNv9F1uSUhAKcgIZtl354Vdb5NRtrcyalQJea4LdcPhkM1cfhBJ5N?=
 =?us-ascii?Q?FIGHcgNRia9hbvGLgfMByJH44Kn3PcG2Y1H9qud7RE7TMKEoertGYkuS9dUE?=
 =?us-ascii?Q?PQztLuBg+LvIZYyRKJ//+0R5CCE7LfFU6O0rwhbp8kzOZarSEPlXTWs3nvUS?=
 =?us-ascii?Q?htlXoXgnS+x1L/gELqnIcdUIJrePy2JBzN/P1fbXxUi6DlJf+x73ZEvKRRTg?=
 =?us-ascii?Q?EoBuqnc014Jpt+wywW8J6RkZMQ3JDjfifIHq8mbNsovpJLpTNTkBQDpKYh4M?=
 =?us-ascii?Q?0MjWjPxX3+7mJvs0S7SOET+frXHz1U/VvyVQ2ItUlmc13v3KmPnE6rBbsOUC?=
 =?us-ascii?Q?Utp09M8auFnXCOaA/BJru54VB02UH0CCPA0wbF2SMYM6E3TGWjcAEqLvElnb?=
 =?us-ascii?Q?d63dnfpNxjtJgvjWrra37Xi+VjjKPzW0Hcp9g+GqTiN0LO3znrs3jgYqWxF3?=
 =?us-ascii?Q?y1WcllCLZUVvGILBc04I5+WrgnJ2d5uhMhMcO9g1pg9KLzc4ed4yR6K1Z9dj?=
 =?us-ascii?Q?GgFBmgEfmwusoseYH7BnTqIx45vl2hSLxR2y4RG0xcDnZDMvLE2P81SkFakD?=
 =?us-ascii?Q?VxxOITMun300g5NSs4q4R7BEB1SrVnj8yQIu1eP/n7/vjW3vPd2m9DJoEhST?=
 =?us-ascii?Q?qpI26jrgZsMbxYTr4xRCdWp3GNkCsWET3vJXGR0CmgBSDN5XqyjajAMK9BSK?=
 =?us-ascii?Q?RebCz2D6gFyaniDuYAR1sAbk+d7HrZ33f9BGoh7NUI4y93aRXNBCIuMH2q0g?=
 =?us-ascii?Q?zuFOkJxV80B9HwaYcf7lKk1UFkPHyVoWjzB69922REbYYiQpRky30GJ9Qdg3?=
 =?us-ascii?Q?j0d/xFOIN+/tUExVK5tXP7MCDXAOmQucqFOJ2cmfFysA5P9VBPa2nYMV0Tla?=
 =?us-ascii?Q?Yvyvv5rzKQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: cpBXmn4cR0YSqi+G+D4DET75SphDSuDcYd6fDHtayIpmOFmmJLVjayl+N5EwEkEYlbn+eNbzpXbdxRKwUy5HXzrIgVeMLzIPBJVC6n0O5tCgdps9kiRHjT+m/bQQS3LcQHKng3bnCl1HVFgTGuK2095m23+QD1Cz9Hh/wmGmMtSWVDEfbXEjf+vIiD4ejAboV8Huo7j4yJI3noy56ojL/HZ+X8dW86sk3TIP7OEYXCesroUXBOwL1WiJr65AyABFb2+yEH62ZyR45pTF9z9PLrQMj6m90j+z3IeFjdmzLT1dLOo/SUl9v9DlIYpy9k7LgWGsVDzIEkF7z5VfUV5Z2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7427aec6-ec0e-4434-0efa-08df1edeefcb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:38:16.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUfj/FXJQ7PlIwkM38KxGeX0Fc+1TkJBtw0xlR/owjutEULK1X6hNLer63B58lYDgf51zWRAI+bodbOpexiX/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
X-OriginatorOrg: intel.com

Support a new TDX module ABI that reports the Quote size limit in a
metadata field. The fixed 128KB buffer in the driver may be too small
for Quotes that use new algorithms like post-quantum cryptography (PQC),
which can produce much larger certificates. With this ABI, the guest
sizes the buffer to the platform's needs and no longer has to rely on
some empirical number.

The shared buffer comes from the buddy allocator, as the host expects it
to be physically contiguous. The allocator's page order limit should be
sufficient for current attestation needs. Platforms that don't report
the limit fall back to the default 128KB buffer.

Assume the TDX module always reports the same size. It is a TDX module
bug if the size changes.

AI was used under supervision to collect/apply feedback, review code and
workshop logs.

Based on a patch originally by Kuppuswamy Sathyanarayanan.

Signed-off-by: Peter Fang <peter.fang@intel.com>
---
v6:
 - Use struct_size_t() directly, without the macro. [Dave]
 - Document that the reported size is fixed. [Dave, Rick]
v5:
 - Do the export here, and use EXPORT_SYMBOL_FOR_MODULES() instead.
   [Xiaoyao, Dave]
 - Drop the comment about the buddy allocator. [Dave]
 - Drop the RB tags, as the code changed substantially.
v4:
 - Move the PAGE_ALIGN() out of get_quote_buf_size(). [Xiaoyao]
 - Improve the get_quote_buf_size() pattern again.
 - Document that the reported size covers every Quote type. [Xiaoyao]
 - Document that a module update does not change the reported size.
   [Tony]
 - Add Tony's Reviewed-by.
v3:
 - Split out from the v2 "Allocate Quote buffer dynamically" patch. Add
   the dynamic buffer feature on top of the refactoring. [Dave]
 - Improve the get_quote_buf_size() pattern for better readability.
   [Dave]
 - Drop __GFP_NOWARN so an allocation failure warns. [Dave, Rick, Kiryl]
 - Drop the Reviewed-by tags from v2 (Kiryl, Binbin) as the patch was
   reworked.
---
 arch/x86/coco/tdx/tdx.c                 |  1 +
 drivers/virt/coco/tdx-guest/tdx-guest.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 02c2871b99d1..ad489f2abcf1 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -213,6 +213,7 @@ int tdx_get_max_quote_size(u64 *max_quote_size)
 
 	return 0;
 }
+EXPORT_SYMBOL_FOR_MODULES(tdx_get_max_quote_size, "tdx-guest");
 
 static void __noreturn tdx_panic(const char *msg)
 {
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 0cf078f09a73..11d741da3b35 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -209,7 +209,20 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
 /* Size of the header metadata plus the largest possible raw Quote. */
 static size_t get_quote_buf_size(void)
 {
-	return TDX_DEFAULT_QUOTE_SIZE;
+	size_t buf_size;
+	u64 max_size;
+
+	/* Start with the default buffer size, which includes the header */
+	buf_size = TDX_DEFAULT_QUOTE_SIZE;
+
+	/*
+	 * Override the default when the TDX module reports a size. Add room
+	 * for the header metadata. The size is fixed during TD runtime.
+	 */
+	if (!tdx_get_max_quote_size(&max_size))
+		buf_size = struct_size_t(struct tdx_quote_buf, data, max_size);
+
+	return buf_size;
 }
 
 static void free_quote_buf(struct tdx_quote_buf *buf)
-- 
2.53.0

