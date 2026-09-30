Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA33CC7CE;
	Wed, 30 Sep 2026 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764708; cv=fail; b=cny54O820fqhMQF6XNoPkgHhbOy8KB8dC9HPI5VoMs8FN6BJ3mS4TVS4QRFyyMidweiI7ZRsi2ZEP5Cy9eOhCGti53injoisaKtTu4YROV5/7TddejH83K+M4ajMgF34NruWrsMsK+J0Rhw6K3o6pvAWAinmqmDyC+evXvcQm0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764708; c=relaxed/simple;
	bh=qH4F2jYtlqLT/X1vRQ5wrnl+GGfDmimmXH4mpbNzdno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ak7DnAke49ZeNKSYjOfWApmIGfZosRojO0/EcvBT67K+oJW7jWeQrwC3WjfL/3V2NOvnwRHwyr3geWuvqLC2IlsQlcCVbeotoh5zdAwtDHNCh/zFWA4h5vLnuxu4kmhBKdKjftjxOvIbE0oi3lOwQddWmrn/fyL0ZFFvzKq7ars=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftNB3hSP; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftNB3hSP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790764704; x=1822300704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qH4F2jYtlqLT/X1vRQ5wrnl+GGfDmimmXH4mpbNzdno=;
  b=ftNB3hSPCnVqpPwh4HlX6t60d9QPKVt++K2Fqa6ajInZviYK+tb4tvQU
   wXyNZvmYJG+4WwD3cIVHSivo/yl3KyLPss1ATGsWqD6aCThd4KDcspm50
   wNBL8nYe5NmJj+rwVYr6JRq+m4LC5YB/DO1O9aqKY4X729p/D3ZhfmDua
   hN+cy3bynoubGAuXccZdxNFJxntMz77N2uAnN2Fs7gM+C8vuidD6SD4pL
   sI7MjjiDQnG6LIdAg4c+Or/mYlKFLfJ2ZnFAcJ4OYQ9nnbR6q2itdYESE
   dUeyVctCxyGjgWFtOzoelqSVtFjPS1sAV0BxualLYp0G0TcDWJsRzjL4j
   A==;
X-CSE-ConnectionGUID: MQO3nAv3SGuX61I+kokdhA==
X-CSE-MsgGUID: 1/jQIJdUSPy+l2a2welFcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="117028814"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="117028814"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:38:18 -0700
X-CSE-ConnectionGUID: 6UsrC5ydRCywfkurvhKPdA==
X-CSE-MsgGUID: ghZjUB6NTbW4rAkavOXJBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="280393097"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:38:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 03:38:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 03:38:17 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 03:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kd+cis1K2+7NlNyUdLAyfjDNiypequnLNLjzbbH/t9pqBZHDuJz35MMMfBcW+Z5ZMToMldRhiE/8NYIhl5LiOfZq1wSyec+HGluNNwPlW6uvZoMJ/aXTwNn78OAlWyS/J0G+BUUfbfNVcXSqncMroYlNmoDIOwaWI+KKRRv1B/HmGN+teEXJawb2reuECQjJ+Msiywe2p6SlEocJGox5zqeEB7RXwOpglNmf3pHRBkJPyplepK0xyQZeCdo/P/nUymp4f1ulkNNC4fUiZhYDhMNW+Ne2FdGKQLC7ba4XBszUk6Ed60C7kv81b4ej9hR2txOP/oMOTPbg6SKMurCbYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhJpjhsA4qUSMWWPOJ5k3fo/QuijyN9rRpN61GE+S/c=;
 b=Ihb6EX7RANJL+cFqo/U07Y/ifmSQxphKsV1AP4+JaDLvchvUnq0E99MxZoPgdErqfV/mMeLhHosrV4oaWLYkcM3gfFWWUJMOkIuG7edyPTwSBIgk8If4YZZYJevav2NuFnFP4dzH9SP6+uzDiLcYHoAWJSRVXLM4QZaf/XEmquqNpqr5WmJdgN7Iy5Si9KQ3KbC16Hhvh09+/xYn4YthlokNrlhcv9P8JUdL1eqvK8sstaDcxaHzRzLIl2eHeFe5Y877wUGBKvAq5hkQfGTXijt9unr/sf2vN3Cy5ENoI69l37z3hb2DQPeRMkn/K/NBS0EGYFMbmlORqHIDjS59hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CO1PR11MB5154.namprd11.prod.outlook.com
 (2603:10b6:303:99::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:38:15 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 10:38:15 +0000
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
Subject: [PATCH v6 5/6] x86/tdx: Add a helper to query maximum Quote size
Date: Wed, 30 Sep 2026 03:30:54 -0700
Message-ID: <20260930103739.2851980-6-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32c92cfc-e167-47d2-08e2-08df1edeef09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|10067099003|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zq1UezCFXPcWAMREYwiN7qJCnK87dMQqYopXoNWI8Lz+grZdXd/ZGCWIGKiW6fo/MvwtNseQ0RxtuDweeXMZ+aP4UANDlhl/ymjBZuOhbkEBoWDsDGV6ul9KpJbhuPXRqZiPcpjyaKOacvNvE2C4FKnIZg5PYmkfxMPRVWwIW9Zq+0DGiLUnsK8QHv2vjK72TueV9pxPszzLlyKfvXDJOQHHL9oULznpfbj2QuRalOs04cflNy4esFvdVU6zcBEzp0cZWU7UEQ8q7C1cBG5+qLPC4c6qa1ewpTSt6aWy8YiYOCaYerucNMQIdvTqyQUuICoZCb79XYTAXIkiokK1v2XCi2/nxbaawfPbvWcE4gyeNlYyqtQ/nLUkWWje8sP0pXUtZu/q/omntvTCf0uL2MbnkXA6h2LYiggho4fe5c08whJd2c4rAfElS5RnWBxIltLCBeYvst1tTZO58jcIbMns/b3jrutfuJfTPH1lztOx8wN34sxLKA40hmoAdpMqZdD4LVXqY7RwyeAHFwUKmgRgR6nVn33sVTY1KPI+zZr+cFk2jey9n1aPE2vNWQLzIKgMYrYRbabm4WBqpeKn+WxQCEbHo0Vc8qSdIun0/V4rOQBq4rFX9gmML8PKYEL0EE9RPHve35ek84VyFfo5IIskFbs5RI/jH6eiNsta3KU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(10067099003)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G+Y3WNCPO0WGIoWnmXVqnz1zZVH6QpmDewn2hluj5sXn/ZxWREdLvgepwBzp?=
 =?us-ascii?Q?T6f2GlreRypTMGpyGjRFPUu9At7xK9Ojc3GbFQnldvTOLjrqT1Rwkyb4jhBD?=
 =?us-ascii?Q?pUyn1C54KvWZW8lDzHyAXPbrAcYfD0TFSGrgor9WFUDhgA9TttIaFCXUmFqq?=
 =?us-ascii?Q?e6wylRtiV9/bDkTVESAPJR31ZsYYpuONNbLop+dM33LlMK0vvWcY7U3Nm6IB?=
 =?us-ascii?Q?0xyyINnd8gnidXGhvgJ4fmUonTDluv1qAkttmg2dkJ8ranSqNguIBU+nHnzS?=
 =?us-ascii?Q?fomRTUlAXR3sa72KMnhX/zU/k3hOxnjOXzHJtJvvClvECW4SCC+GuPpXn/ge?=
 =?us-ascii?Q?B8Uq0UjRqa75ycw7aooE7ja0Kr/585PvHyMcR+pzCAW4XTqC1EoHfa7/+bem?=
 =?us-ascii?Q?uEScpTOf5+hGYe6ELTDBAs3RCBiRxD/ACrziOE8+Hqc6f2Zhy0IgF0x9cTxx?=
 =?us-ascii?Q?iX4USw7pjKN7o2c+n7zLMUCZJITLMsgAy61F1IYVMHnWvot06e2GfSpcHGDS?=
 =?us-ascii?Q?aKx2uqPc99hIcOztJifmhgKAp8R6joBilmuAQtj5oWSNfSm6I238g03b0mZG?=
 =?us-ascii?Q?Ztajok4diWyg8TLkKZuT6QhI/0/6gu1pRaFvi48j1mkuRMKfLDvMZ7tcoehu?=
 =?us-ascii?Q?IpJopnZPyoexB1PWOcD2w3EvTcOiJk9bNaVc9FwNmR8ED+bQnVp1c1KsM4t7?=
 =?us-ascii?Q?OQTf6BQBPZa1abM0Y/sFMvu1v8isbuk8082OtEbUSb1fdEVIPF+oA2X391On?=
 =?us-ascii?Q?KQPCGyjsaBjPJ03FgMpKeBgsul/61JxLq+j69xjIP1Z2uHuNFw2NiF25QX05?=
 =?us-ascii?Q?XnbDzPJBXJGGRJMS5LD4k91Av7GMwAneuoSDhJ2qw3q41Y4EqfGwT0CUMmR3?=
 =?us-ascii?Q?rEemTJ7Z0DI7wUcCdF4uk2YrlSoOegBbbeP0W3aVmQ8huC9nwYnrOmk166Oi?=
 =?us-ascii?Q?BkPp5HXtcrZ5kUXINDQXn/T8wlpgf9xngqR2CYifFtQaLt8WIBOxXzeCYV0v?=
 =?us-ascii?Q?6sGpmLOHtX9xc24byHeN2i/WxXPvi4mmILZzA4g2+ivFq4mVRYhRZljGFKQy?=
 =?us-ascii?Q?0lhr/RIIrT1Bwk8pUrAAMzRDhoNHMQPYtk0CgdiUJjpaJaRSDeyCXNvQ2Hgl?=
 =?us-ascii?Q?HZo9nAS/Igj4/wmBP3gCbpAMfo0eCFNRr8dAyJblgvWFEz9JM7XI1iYwPE/B?=
 =?us-ascii?Q?j4+WSyrsVp/UmsFyeUAKNBfUMigSs68k6LbEKXOctayuh2FYMx5lodgbzK17?=
 =?us-ascii?Q?L6DPKtwYyu+IfWqMNSnPBxQoxvmPyUjesLfXFOPBfz5uTZOT8/3iKQDru8RR?=
 =?us-ascii?Q?vIvLicsutk7Hpc/KOFqr+oYbo30acZpBYNaL0QkoHGqro5+lVKAYL+h/jabZ?=
 =?us-ascii?Q?Hm4Z/ScjalTUc4UWqLI5hO4PL7yUDWBFko86Oi7ShuUYsSLSPlw7jTAPrlOR?=
 =?us-ascii?Q?LgADpUMpj/OLjxLIWMXwXYzBNAPzpCRhPczM6QNuImkL1STE/r9cmKtNHXLl?=
 =?us-ascii?Q?N8+Tm2TJp7tdAUN9sHumMpPnN6t60R7mmPWpmGW+lNb6dLRxG73l15jKfyol?=
 =?us-ascii?Q?/+Z9boeTvuDCeIWOzYKeFI6Qg27XXr0vnI7j0gD46iVuxKZMtb28Qrvf9EA5?=
 =?us-ascii?Q?jdYtBEDcAxWRW9yRVuPX61H9gZNk3W+uh/ChW+02yeovgwDC4khCDqbtTyNV?=
 =?us-ascii?Q?UAfXnL44fEeH7JW4AjjxtKRpbz3K2MBjL/4vvceGfZswYPxIO4PAdSoyplad?=
 =?us-ascii?Q?rP+6OgvwHA=3D=3D?=
X-Exchange-RoutingPolicyChecked: Fa2N50zetzZcX2FbTU+FOQk2iUk62dUIoo+0R1j/A2cLeAf0kGS4StG2Oqz8tPGGr/oaYHzBQCZ++R/Q3SihbJZNM7MlBcqKpgyvG1thUkJ0Sp2IdugZwL7uAPkAX2UquZZN+UqV6qBC6VXcQUtCl7jzIVsLoGMzshcC+ITlQ3xCPCsf1m5mcuIPKc+8ehOg6z5XBx9T5Ufy4neVYSac6Z1Yc23fgfOwJIQGNEbjHODa39iD7BoWEIg9QNTWhSKD/XIGBxVbe2ITfdL6M5Evq5dvDQHQWNygNMh+VH1mQQHsOBMZ4wo2dXPvBCPH2C4uOfoF8TJ81fz2szYuqTuH+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c92cfc-e167-47d2-08e2-08df1edeef09
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:38:15.2505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0W44EbRRoXCR8wcoSSzIVUUGxz6JmGdkbaFQ1mK0LssBavS5dEecG7FxXgb6QjWuVcFWvy3nD+teMigJJhvoYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
X-OriginatorOrg: intel.com

Newer crypto algorithms can make Quotes larger, so guests can no longer
rely on a fixed-size buffer.

The TDX module added a new ABI that reports the largest possible Quote
size via a metadata field [1]. Add a helper to query the size instead of
exposing tdg_vm_rd() directly, as it can read arbitrary metadata fields.

The reported size covers every Quote type the platform can produce,
including SGX-based Quotes.

AI was used under supervision to collect/apply feedback, review code and
workshop logs.

[1] Intel TDX Module ABI Definitions, August 2026, TD-scope metadata
    field "TD_QUOTE_MAX_SIZE"

Signed-off-by: Peter Fang <peter.fang@intel.com>
---
v6:
 - Drop the Xu Yilun credit line. [Dave]
 - Mention the host platform in the helper comment. [Rick]
v5:
 - Drop unused EXPORT_SYMBOL_GPL(). [Dave]
 - Use an error code to report failure. [Dave]
 - Drop the u32 cast. [Dave]
 - Replace the kernel-doc comment with a one-liner. [Dave]
 - Drop the RB tags, as the code changed substantially.
v4:
 - Update the TDCS_QUOTE_MAX_SIZE encoding to 0x9010000200000007. [1]
 - Provide documentation for the metadata field. [Rick, Kiryl]
 - Document that the reported size covers every Quote type. [Xiaoyao]
 - Document that a module update does not change the reported size.
   [Tony]
 - Add Tony's Reviewed-by.
v3:
 - No code changes. Add Binbin's Reviewed-by.
v2:
 - Keep the explicit (u32) cast to document the metadata field width.
   [Binbin]
 - Note that Xu Yilun's suggestion was made in an off-list discussion.
   [Sathya]
 - Drop the Assisted-by tags, as the code was not written by AI.
---
 arch/x86/coco/tdx/tdx.c           | 16 ++++++++++++++++
 arch/x86/include/asm/shared/tdx.h |  1 +
 arch/x86/include/asm/tdx.h        |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 92c243851171..02c2871b99d1 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -198,6 +198,22 @@ u64 tdx_hcall_get_quote(void *buf, size_t size)
 }
 EXPORT_SYMBOL_FOR_MODULES(tdx_hcall_get_quote, "tdx-guest");
 
+/*
+ * Ask the TDX module what the largest Quote on the host platform might be.
+ */
+int tdx_get_max_quote_size(u64 *max_quote_size)
+{
+	u64 err;
+
+	err = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, max_quote_size);
+
+	/* Old modules do not support this. Tell the caller. */
+	if (err)
+		return -EINVAL;
+
+	return 0;
+}
+
 static void __noreturn tdx_panic(const char *msg)
 {
 	struct tdx_module_args args = {
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index f2cfa71cf0ea..f1c543958028 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -50,6 +50,7 @@
 /* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
 #define TDCS_CONFIG_FLAGS		0x1110000300000016
 #define TDCS_TD_CTLS			0x1110000300000017
+#define TDCS_QUOTE_MAX_SIZE		0x9010000200000007
 #define TDCS_NOTIFY_ENABLES		0x9100000000000010
 #define TDCS_TOPOLOGY_ENUM_CONFIGURED	0x9100000000000019
 
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 97bf6c8e0d89..1fcfaed515fe 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -84,6 +84,8 @@ int tdx_mcall_extend_rtmr(u8 index, u8 *data);
 
 u64 tdx_hcall_get_quote(void *buf, size_t size);
 
+int tdx_get_max_quote_size(u64 *max_quote_size);
+
 void __init tdx_dump_attributes(u64 td_attr);
 void __init tdx_dump_td_ctls(u64 td_ctls);
 
-- 
2.53.0

