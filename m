Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB9A48D88E;
	Mon, 28 Sep 2026 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590271; cv=fail; b=IXl0j0EOZ/mtsqVMnET2k3in6mmRQBqCLheNi6qUs5mi9uzx5mRdiOtJcBCAHwjWLdO/a3XKexuhXmOnBh2YRHiHqvSDVzhnC6p19XLLY9DM9+0FrmmQlNbx4JxwsXFU4xRj+o3L++5CUOAiYmQbwrBJog+hnJsKdYy9Fukpi5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590271; c=relaxed/simple;
	bh=oTAldj9Tq2c2Um6pHmMzma5vJZIUqXQwGmbfTZgjMog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cb89xfY7GlTM9COTvQCOqq3EWhAYci67yBV8Y821i/cs7IfNREPZm6oN0Kt8zwc8QYDBEVrhKGA4DgZwSkv4oF4MkR5OAuu6MY8Fmb3tUN59GO3o6lnH5GBTOkTobfuuFLNlIImq2e5321+jw2GPKMNlO6rcNjXJk1kwHFnR+Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hR79oYoq; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hR79oYoq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790590269; x=1822126269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oTAldj9Tq2c2Um6pHmMzma5vJZIUqXQwGmbfTZgjMog=;
  b=hR79oYoqGZOwiy1He1dELTeptLS1PIzxWZmMTTwEZejjLbvCNJxJJSge
   WRcf9vBhqCNFwP4M8zONlLRA00GU0+hVOzc3nIB+k3u2NOT+3EwgW9OFz
   CksivMlynrqdWJex6YsB9dpjkPWaitst10gk1sZV0U215X2Z6aWg2xDIS
   0uTTk14EhnFNC2ye1X6CyzFGWF6fNLRUmYwQMg+GIdSE4ISup6Ua44/Md
   2rWmf2p6cGgWnTSQzs4J3VO8QpOsOyq+ycTvgYpwQzyV8xNpVcj+qYh81
   c9DOUQX4B2jktFVkayqSnYSohwQVstRNC0Mi/jpVZ6QeBLFOW9/ZROndH
   w==;
X-CSE-ConnectionGUID: XlaZCmUqQ22NZY/pvvhxIQ==
X-CSE-MsgGUID: K+w/U8mHRp6igaPTRR9K8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101944062"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="101944062"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:11:09 -0700
X-CSE-ConnectionGUID: 5q3NhsCwRQKezVpbki7a8w==
X-CSE-MsgGUID: hWy0WEQqRhKOBRHzhqr/QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="274524290"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:11:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:11:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 03:11:08 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.47)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:11:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7S//6yiHWUhJYN84CbBXoR8hiCE/vCMIco9a9eieCfCShbdcfNXWgI/XFS8mGaTJau3ioUHKVJ5nN3m749+pi04ejxhQ94pnSB8CKpqAbCmn6q5W1OomdZV+oCYKcFl5IPzYO+9Fn7lPXKCjIlRHPTr2UQ6EkagmIAMsMuaw0lfyLpvnGRAqO/BpZrkzOm+l7KczaLbw39prXAB4R82S/u+iZnyjH8ncSTE8E1iF7atzqryRRK5aKRCyQHruNVZk4/lcCYnDv+r/QYRg+Tkh5jBr5F1ySpI9Asj5o9iHWYIEsz2VWVqhlEBYisp056Xn4unhLY1Ttbwj/hilJknFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrPbFo0+e5LKDWhCtuyu7dFNLeaYvy4WZIC2dabv/m0=;
 b=SY+PxdePt6OTm8q/wDPXD8mr3ud1mZ9jp1lPxRMVIxJIhwLyurwLjP1y3gyKDNdJNPWmJQd4HPKMPhgDKTfTYORr3XAAObz0rGVjM8zcDoR1QcY9WWq/qnYYIsUAVRMXC+NB52VoJHQ6/JdqXH4FzzZXwWe8BgzAa1wdN0hQq8gX4g+Ls7VcjsLWnjRY0HaUOnD5mdREyva30dR2A5FFAIhMJTQfR+k0Vq0tn5OdzcL82K9SVugXFXjUcTEHul/vStRFEQq9VuplQR8nWhtbJxdCuSvNKgPcBB3oXcnJQ+8MoO5j0x/V3SVVrd1YttJDd17T5khnRq84ZY2qlX+eag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DS6PR11MB896703.namprd11.prod.outlook.com
 (2603:10b6:8:499::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:11:06 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 10:11:06 +0000
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
Subject: [PATCH v5 6/6] virt: tdx-guest: Make the Quote buffer size dynamic
Date: Mon, 28 Sep 2026 03:08:17 -0700
Message-ID: <20260928100913.2265687-7-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928100913.2265687-1-peter.fang@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|DS6PR11MB896703:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0fff47-7430-41c7-76e5-08df1d48cf1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zHS/g0zJ76ne7rYsw4EASh95Z9KesMFXooFSY7LNP8tuUBv2OLDdHc+1kp2wf3t7iZjDC3zbd64A1pv8Y3kqqRlgudmMBfdy1OWqIljgaz9SMtAMCjY+5xx8njJeuYkXSN+X5S5vWHIobIPI2bhhtk2Cr9D03oN9UwRrm9AhWbhNqVVb683GPblXMg29x3RnLhdVrQR4jHmHysX2L+ONC+87XJ/FtLsPT0CkAvVX9xaeuNWENlQ5NEnFeaH3kj9YlxwCoCCxQspvAFDDgH0Sv221zKOoNTwBeOtA2T3aihmAakIkHdP+QiXdsbwc9I+3UNT1TZZe+XlVFfJhuHL7zN4U86aEkVj1WD7h6b37kFEooYSHuSMqfvYW6hqV17/9dzogl+Y+TXYuBoiIvoT3NWsbbDJBtTJNlH61qgF1BZG7++4RslKChdmCrqsr3cpLSdfgUdbs6CI0hzPwqPKpAfWGP6GxpmBBWalgwLoSnPeLbhFALHcDhSHYmHtKZHLQ37cRtI8a78CHvkFv95ibhIwFEGLz1iRl242f+a6t4V1+AsMBSERMONaKGHM7f7k6jtOlyposPu9+k9jWgvdyufJK3nth94nBeAhOWg/EfkZBbTU30OZKzzhZ4HJ1odqg9rE4Xwv9CA0SAVNii+n9Ll9izspxbyJPdQ9nHyTCLtU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8r4/X8rMFc7P2zaE7mDu6yPFRAHoXSjICYixcCoD7QD8R4CKCKMwqdr8TZ+D?=
 =?us-ascii?Q?ZR1Qsf3xZ+rj+h6ctS27fWf5hcHeQBxGAUHUM5LxJgcYekq7c8tA63GpYRQm?=
 =?us-ascii?Q?EE/+qE+YtbglhuNsfBBKIOCC/EuNd+ZnmQM1doJfpFHwK6RrfysjgVRDdXlp?=
 =?us-ascii?Q?SHJ/Jy9/dvsOUMJeMNZwLIQHBTNstFDTTsaSJ2aEfS9+bV/G3dX9yU1y+fpj?=
 =?us-ascii?Q?Jkg/hcTBfbqIon+Grx0NSEQY0cBTbClleoGHPekW7E4oZXNyPR3sgAwuZJTT?=
 =?us-ascii?Q?fFbaM5qNJlONagTQYSVoKu4GGJXtOY2JTm1/sBsrlMN7GJSnkEer9CojoulF?=
 =?us-ascii?Q?9hm0DDuX1WZz9IAhNw6ZSjWDlYcHrPyG/VXwPI1lzZ61CxOJC8WkYqbeCqDR?=
 =?us-ascii?Q?BoSEN8TVc4KHwju4ANcJA/0SI9vtWIWDDjZU6dbVrtqHwX/wUyruimTyWoiV?=
 =?us-ascii?Q?t+Fi58eMDb67WAcvest6gLx3UPHyF8fadKOwqBd6aJSmoS9tVsXKf3c2wNVN?=
 =?us-ascii?Q?XmPcMq+HSnJTzL2GoZdCToMnU3p93sYhhZuinFYOMDvUii5DZkGjl6KYjiTT?=
 =?us-ascii?Q?BtcVruJxz9ozhTiHBQ2kHyPa2g+cpM23tMW5VCmjb3seia8VNRMa0JcwDBDz?=
 =?us-ascii?Q?nPadivQuYyMDBUxFLWcb2xkLF0wDumUN5peJqaiExrd4sl6q5L1IDa4keCjT?=
 =?us-ascii?Q?b225q4H43ImUBw6gvVqxcVubH4IBpRpxmgjXsAajBgyZLxWJNpyRx6iT2tF8?=
 =?us-ascii?Q?ICxHXMisLUxCGJPTFawS66Eb4X8cii8jNR/ytLryPZn6N0LGl/W2IG2wue+6?=
 =?us-ascii?Q?8r0HuF5d4fn4BW3YI36yq/g7UbohNjRtG8ZkWUxY7+zLKtnXh3zEDur89mm6?=
 =?us-ascii?Q?311mTcZXXgph3I11G9OAj1R/xsHkBnn3F4PekUEkAy1kU8pZXdMnuksMiuj7?=
 =?us-ascii?Q?S95KxLZQrBUcUS0p20RfqAx6YkCcZw9hlqXyelbuyv+Uuq0cfbdeTlCOX5Rw?=
 =?us-ascii?Q?6XN+qzYbOvJtz304fLh5gHIAIFp9und6dTUN7NkQOi9wYfhJGUx1NuBqJ7mb?=
 =?us-ascii?Q?tIG4o7XGjAwGWcwgCh4SGoHcewiKAZJ/QAh6kqk9DYoMMe/xPShxRqeOttif?=
 =?us-ascii?Q?xPHzJah0IiH+E55azgsj3EnQ4H4HkXDZAjjZEj3Zf7kXvKek9TQIdb+NZFaf?=
 =?us-ascii?Q?AG2e4EOuQ/ETeCh1tX4vqtV2/r4NmjjbRAbsHiJr+GG43wDHzkDepNZNY9Bo?=
 =?us-ascii?Q?YWDQw7sHsQ2DJPXiiScsxa7kDTEOyhWQh8EmBzxXF9o2Wc5OAaKCB9rFNUJO?=
 =?us-ascii?Q?lX4VVi9kQYqAGfPOtyZsOIFSgnUDErwU8i44nRrVhUVlDAiVb/REDxg6jGAH?=
 =?us-ascii?Q?6w0DSYGIL/K2wEvYl6MbfiuJLy9l+xgT5s1AnNMOqdBjy8wF5Ua50kNVEqRv?=
 =?us-ascii?Q?GnTysQeOUBrn8FF/5bvxH0VA2GV05ZrMVpUb+X/pgkIS3YnIAjbYk2r78+aB?=
 =?us-ascii?Q?3xYJ17B1pAdbyRzuSPnSgZyMX1I/Mgjwm+jFXzLh29p6OkInMshHHlhJ8bQw?=
 =?us-ascii?Q?hO3N0SvsMYwCFE9uUl9tfdyXmyXRHVK3vS5+OlllSumuPEN7QEtAGBUCjmiu?=
 =?us-ascii?Q?KuQPCYaYz3seIEIxL2uHSkzHCso2nCSKE/p38r8e5E67kCka3TWQNNcWHODz?=
 =?us-ascii?Q?1JR/KbrDt3FyY7y4JBeGAvMflWP9kqtSuIM//8mlpraZqzbTjy9RyKaqi3dD?=
 =?us-ascii?Q?RJky2jQdJw=3D=3D?=
X-Exchange-RoutingPolicyChecked: I/9QIv8x5cLcZErzIEb6BDhSCCFjMyuVwKRUlifJvwW+QMF2wnIU7/WS7a9HKjpY1sh9zicGiwPGgkb5O1tFNBXGS1L4Jyy533Cfc1xf/nQcyD/HxFIS7BwU/w5aQ5f3Pjs9WeV2Igc26cyjbb9o7HpTsvY0lrmUDqULdsd4Po3lQVuo9uYBKrkZ5OArf01mx2zOPV9JR6Jn0ofTPqRXMwFJjlDVVwGNLtsUJ0TeF37sZfoC21oAEv6DIUE8LfS48lEnRNNabKxlCe7K1Fu1EzyNAV7RGvXWN5g7qwtTwq7qO9/sGabxNTDttGCa1ZlwtvB+W8U/wx8BUF64hQPQ3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0fff47-7430-41c7-76e5-08df1d48cf1e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:11:06.0415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: we7u6xzEBlis/zmNREVr9HwFs1XXJqCfO+EXXEeVh8TSnOxQIM5hACD1I1peO9NyBqztXaNtkDZ1u19lV2CQgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB896703
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

AI was used under supervision to collect/apply feedback, review code and
workshop logs.

Based on a patch originally by Kuppuswamy Sathyanarayanan.

Signed-off-by: Peter Fang <peter.fang@intel.com>
---
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
 drivers/virt/coco/tdx-guest/tdx-guest.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 323e1efc78ea..847430fc639f 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -213,6 +213,7 @@ int tdx_get_max_quote_size(u64 *max_quote_size)
 
 	return 0;
 }
+EXPORT_SYMBOL_FOR_MODULES(tdx_get_max_quote_size, "tdx-guest");
 
 static void __noreturn tdx_panic(const char *msg)
 {
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index b79b4325da3a..ad2cb4740898 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -212,11 +212,22 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
 static size_t get_quote_buf_size(void)
 {
 	static size_t quote_buf_size;
+	u64 max_quote_size;
 
 	if (quote_buf_size)
 		return quote_buf_size;
 
-	quote_buf_size = PAGE_ALIGN(TDX_DEFAULT_QUOTE_SIZE);
+	/* Start with the default buffer size */
+	quote_buf_size = TDX_DEFAULT_QUOTE_SIZE;
+
+	/*
+	 * Override the default when the TDX module reports a size. Add room
+	 * for the header metadata.
+	 */
+	if (!tdx_get_max_quote_size(&max_quote_size))
+		quote_buf_size = TDX_QUOTE_TOTAL_SIZE(max_quote_size);
+
+	quote_buf_size = PAGE_ALIGN(quote_buf_size);
 
 	return quote_buf_size;
 }
-- 
2.53.0

