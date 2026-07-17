Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88E391501;
	Fri, 17 Jul 2026 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324677; cv=fail; b=DvpiZ1GKg/nUT/srqgWLo9ZAeonF6bHEJaMBH8HUV4b5BRihvNxyJBh9OmREjcD1BFVJ2A0XGAWoEaIgaXNTBF3NN3Cm1lZtRrKaVyinHrih3cBKHkOqnDC/8K7dPDA7pcgSO+hErWDHCCF0BK3O616agEOTzBOvrxNhQOfi7vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324677; c=relaxed/simple;
	bh=Qul3MUBAm9Sti5bFiLROG3IoU5phnRUJR4XMyOMhIn8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gx41hXSfgV1v6Go+qZNGQfmBzzeYpSkE+QlIGK9auVVhoWdp2d/4Yw+LrYBW6l0mNhWsoX8dAG6sCvXqLIZCiJP8QJSwfxwTBptrGgXgliLp3yRkheoCbueu5GNhYTCZFh5TZq6+wVn4YzWS5RiCo+267/00/rC/ljp6YvTQ038=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUHfkeFp; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUHfkeFp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784324673; x=1815860673;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Qul3MUBAm9Sti5bFiLROG3IoU5phnRUJR4XMyOMhIn8=;
  b=HUHfkeFpLBFNkILxZOSY/yKz6msrnVx4QwTrHota3CDXE63U2Kh9Nr08
   fWb0MT2Q87QZiGfZLPrV04uRieMU0jV+PuDAIgSyVdN7hGXYk8kJ+Md+I
   XJdrqU7R7e3lkspmIN2uzabcHR8Bj8KMIMSsWpQruzMV0v71e+fKKBDo8
   KlOfcdMMMMHaFRZNQfKuCnlRGzSM3wEuNh4+PyVND58fSdCUGLqVqVRW8
   JQCVHP4i9n77dAbHGJqRKgpzGoDNNEBI2LhzyR5Jk1rndqaDE6MPvdx20
   JoeEUlevxgkryf3dX+bUE9CGFyhMgzeYcWDV9JePjQ5r2UGpSpyrNBioY
   w==;
X-CSE-ConnectionGUID: TXyDSbUAQgWh+rBCAogecQ==
X-CSE-MsgGUID: ZIuzsfLATcOiE5Vcdjc9YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85201756"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="85201756"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:44:30 -0700
X-CSE-ConnectionGUID: n4qSuRoeTEa8vpz7cOPHFw==
X-CSE-MsgGUID: 9GuQAyyYQ26E2yMn8cj1JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="255720252"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:44:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 14:44:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 14:44:29 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 14:44:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSuHkk7IdJs+oEt2A5Yg2nM9E9GsZg3yIYZQmH0K18p30uIudPai8Cj5evus69PiVoG9/e8K1wQ4BMBL2LP1mBNAcGhCofmeJZrCQM88joXDE4xdxuAnqjeTo8X7ZNRynnVykmOf/WeDghHw5VKnpdddx80xnb7GLL1vRoHvCz8xsIFfMVduQQgQzfT44ByexV2t4uvJdB4XewGzxE8X896Kat0v9F2Shsclrqm73hw02jwx7v2Kabvv5xAHyelmL9nhuG/Ep43d0qBHANxdjDoZoOfp5FRtWaUUiEQooqc+KSatH3VX5w11ymidzlkfkCfvCii8/bR8+4rQnmIukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeXcE+TRb4IP9aIicCBfv3tW/weIV3TYN/jlxGWV6yU=;
 b=KDhnfibKoMbB6fJ/ARGqZjdwvr+r/RuvTtX1xJdRt+OJIUaVu8BYVvQyENuaBAgRdsjcS70YlTqGFA7z3ZVN7Oll0p7yVNL/pNr+FCdPZMWBd+jY6JKxItTrJmK+M85vdUjMcTO1EJrCxQaOfrhnN7x1n7brzetDEbSnSxsZKPU7A1rv/PL5CzRo3Jr+b9donXe9UAC+hnCsbeU1pOk1PpbaqBnhyrkvqOFQDFMKL5SNYjQHBHw+7e9e+KF3ZzUdSTJNev2xSO9FzNXDbbpKMg8ENaOhfc2V3cc0Fkn2qudkY5seJaTKvPSieB5poBD374eS0H/maY+wocHQ1HDwnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 21:44:26 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 21:44:26 +0000
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, Peter Fang
	<peter.fang@intel.com>
Subject: [PATCH v2 0/2] tdx-guest: Make Quote buffer size dynamic
Date: Fri, 17 Jul 2026 14:43:10 -0700
Message-ID: <20260717214349.4075994-1-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|DS0PR11MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: e655e007-6daf-41ad-8845-08dee44c9263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: W5h47xwltCrjMGXO1xsQgdaSiRjhiqISwEH6a/Y3GrqFHy1qtO5awdOVLWZhnWS2VxdjD8U9Lrv4Iqk4DMf5RYl4vYZuXySbPS2N1eM6WaJay2n12/T+x5U6ZITyC8BUq9zOfSb3wYGBhjPEg2BOgHNxt3Eq1pYb8x8GuVmrfqqieOTwMYblYmnb+cT/ihA8EqhyhLgCRwMw9SCdvVJ69mFikQIXsvZhDu7/h4dPCuvzroBL3mnxABiS9esKX2wm5V5lZyG2zn2U/JBsjJvfo1fZhrTTCNJefZNsM4QC/DEcjo4I1uWA2Bbq4MPh3pcmWQABaFWEP8iPU+KyBTpaQfJudRKxl0UcmExmwMGmDX1fbquvT+I3sXL07SW9iMGKJTbbHqQ5A8JJV4YT78WiV2il+ALfg7Se8LGOnZv36nc4JSyaf0wi+e+oipFwy58oZ5Ybvsuz6dZwJUabG+uVSd1kd0FZJ8RMXxyAVmOL8YHl4ku0Y6Uh4TAkVAFbHynEHngkU3m/qS/AS/cXt9tMtsFZ3Od8ZqhyPf3sHEXO4+PGeMJaHv1vbaCVHxo1coMazo1Im0pCHZeEZqwIEujOdK5vSopVahIKp8rjcefdsoGRzGIHePtHaGFd6MXmldOuySajN6KWGmmZJuPsqNocT7MNGJH2ESCLjs1WHuDGaYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uVbFI6ftJ4jVJQWsJ93crcMUqBc4YphibyH2gl13GELagkrow9e+i1Y2PcG7?=
 =?us-ascii?Q?Xz5+oKTQycKwT1VidAkh6CVNQtv0cOinEHt3Qxcfn+RrfdmqZ9et9mYNAOx0?=
 =?us-ascii?Q?pGuoctMuXvpvW7UrbIGKxA40/atkjmTQcHYEMhUDvBpTTDEPFTEuVhik5HgK?=
 =?us-ascii?Q?A2SsWoiHm9IIgmwxLrTvX3VZsqEbLnNgTBK2x5P0lxyW3sYmXnduNQPiKzai?=
 =?us-ascii?Q?JH2fegoo4ivMZUuQ3zRME1jKfpHaegpO+cN03VNCB533W1BrsVZsHyzbbcuS?=
 =?us-ascii?Q?ur7ALQRhICGQIORNFvJCukdjOXxA4vPIu7PINnKe7JNM2gwmJX1V2Wgrkg4E?=
 =?us-ascii?Q?wTNwA2FBQWxRpDTTd+hcI7qM8geDchsyQ5x5YGFzlO/PVTy0poUjOD/0kavw?=
 =?us-ascii?Q?aiwhRlekgCn4ax75+pk42W0dLMcHhtnFh77alkLANB0lwtrSPYnouPja3aEy?=
 =?us-ascii?Q?sk1IEafWwcQc/eQgIiQmNNl3DBTm2E1XWppxnzfo36SxXQAJovy4j+J5zpIV?=
 =?us-ascii?Q?EiUUraUJbou/7m4AHyz+qYt9W4xJASNxP2IyiDXk+SgWTaiSdNlXHGzsROI+?=
 =?us-ascii?Q?+qyRfOHgRlge8Y9gCPIKej3ODgZkZuuFRwKjEiuVUmeOM88tQevDQpPMVW8r?=
 =?us-ascii?Q?U+XmGxgNMxL9FpJUQJvJM4A/gO5IPsCba9WasOKjqKwX6GdtObBwv+sXM4l3?=
 =?us-ascii?Q?ewAc2BZCHGSGwAR435JPUg5n4+wTb0ZIME2bpfxj/qLSeGrPlxXjM0y1+yfL?=
 =?us-ascii?Q?/rutywqOclwB1OoEUiJycEsrTFKq9EIOibONsMwhApj1yX6W4qWk16qIfYXL?=
 =?us-ascii?Q?MffMosmJYWYLXM+wp3o8esjnEFt+h+d59mD1sOiZ/Q1jcoNZhUICbIi5lJIw?=
 =?us-ascii?Q?y6wlGk1DUW9bkwkWF6aqciJXVAnhUI+8tNfmOSIgANsdKLDOs/ZaklrKky+j?=
 =?us-ascii?Q?2hkykhs9HdR2Ay23lE1y3UUoEgPjgPw7cxJBNxE1BJscuaW5T2gV9pOa2X53?=
 =?us-ascii?Q?0oajvay50+z2QHEEVTDqB6RjFlo6qipSqMwfqm6XcQPFE3wB4ADP3aHgHfSe?=
 =?us-ascii?Q?/wi2mR9pM45hws9dyew4V7psiBipuzx3s5fPar74PKUzShOa43xcrjCqGpUd?=
 =?us-ascii?Q?JdFEoXUpJAvoa+nZQDoZ1dSxd23m5mACEl92G4Hh3MyIxAws2BaNtwLr9Fwb?=
 =?us-ascii?Q?tqs0VhRTYiOo7dhv4XWgumJ8YD5tfaOlF6m74G0QKRQcGshXKAbDLm3R7vzo?=
 =?us-ascii?Q?qQIyvNCpV6CMRZPJnwS7laMsPm2kxO1Lt+JMaP06xl4sXBf8lGxp2X2113Ur?=
 =?us-ascii?Q?arAusWOWRUUlwrk9TqaXUPSXfikM6thjxqzTTFEqPJ5WPqnt3sG+1vq8HmQ4?=
 =?us-ascii?Q?FQCY72BXiO5Nqu2Q785BrYG+wtwCvLcUPOp/2tOddqIkkJE3BMzzdRvvccZW?=
 =?us-ascii?Q?DhBIX4fdFb1ftF2lLgY2ji5pOptbPnHC1xxw52pf6m/aeOGBezueqsd9gjEw?=
 =?us-ascii?Q?5k/sQZfF+7BL5wT2wv73nutk4Ezt0oefal6kqkvT7mNLivS89D68RkRkTrnb?=
 =?us-ascii?Q?4pH7Rm95v3zu7JRYbsvRMCg0ZGYdF0AFrN14UHbYy+B6mFUWjxcYe9sxvh3x?=
 =?us-ascii?Q?25VHZlWggO/aPjpGvt2XRrRf4qpmJ98SCh9nuvLFo4wr3BT/1YTxHHvUfyVb?=
 =?us-ascii?Q?l2EmPidy34gdCZXTaEtUffkwge2/VRE1pvMegTAQ4cX2Yy0ISAY3zkoB45kY?=
 =?us-ascii?Q?gutjjnGgbg=3D=3D?=
X-Exchange-RoutingPolicyChecked: CEmlJjsOTa37vX0HnusT+7F3KRUKHAYdIIeIcL/TcBEchDCN5pQYL5WbhGm9NWRRkD8it7OVfzRT70tpEhn586PtrEoWfFpjqNHBEI7Rw7HcwEi1rGSkWqatqzLNWdNh6gfuSdWhRu5T3SVuDmdTMc+uO1aY/zkxn/gU+xzVbTI+AD8SgCPxnQwx3LpygPJ3OxAHWa+A7iHEVgO2IkvpqWcK7KTXUdStz+nR/cdlU1shYjjVeskB8gpkyWSUyPwaYfy46OgYCZEetl25TAm/ucsPd8HYldriPYrepaY7OiP24bZ2V3dkF4TxwPkkN1gFgbzRFMf3PQhoZ0Lv/SF/1w==
X-MS-Exchange-CrossTenant-Network-Message-Id: e655e007-6daf-41ad-8845-08dee44c9263
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 21:44:25.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daiiKG9QO0BVR5j0Uay6QiNS26bhqnk9TGg1iKKxURjkMk1Vo7mDXWdkvZQ0ryimcexh7x30hxiw9cL3Q6Ecvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
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
Quote sizes significantly.

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

I used Claude:claude-opus-4-8 to proofread this cover letter and the
changelogs. The series also underwent AI code review (Claude:claude-opus-4-7),
but the feedback was limited to style suggestions.

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

Peter Fang (1):
  x86/tdx: Add helper to query maximum TD Quote size

 arch/x86/coco/tdx/tdx.c                 | 19 +++++++++
 arch/x86/include/asm/shared/tdx.h       |  1 +
 arch/x86/include/asm/tdx.h              |  2 +
 drivers/virt/coco/tdx-guest/tdx-guest.c | 55 ++++++++++++++++++-------
 4 files changed, 62 insertions(+), 15 deletions(-)


base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.53.0

