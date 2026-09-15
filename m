Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106947AF43;
	Tue, 15 Sep 2026 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464457; cv=fail; b=MtO8YQtUZjTuFo8gJPLfPE2hkp37bO0J3xPGDAiVSvlZN6uROODC/rQ/XRDmxc0i7byS1bx0MuRXgDu+XDjAj89P5rBc8AelxWcvd6qfrRxl/UR3tFsdk4dc9Tv5uBXraWhqqzVGmtp6Nvhf5+rftwnRzD6UQhx1quAuZO6ZALs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464457; c=relaxed/simple;
	bh=vcfztzDddCW7nJDQPR7qqgwhN8RQGULNTHQxXdt7eVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hT/LXfY3JwGxey5ooyAsrfH0Xfqbx2qEiblp/ac1F/GyEhdPxHzPm+XKeQjc2nC8Kb+KnRCWngNi7yiwxZMZmTB+LZAV7Z5vmVqI87W9T28eUDRWy/QpZVpm0L49qGcMbd0MGk9tQMYoi+c/1W8s/FJ3knAjnfkvhMiGx5eI45A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yfk+5mJJ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yfk+5mJJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789464454; x=1821000454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=vcfztzDddCW7nJDQPR7qqgwhN8RQGULNTHQxXdt7eVU=;
  b=Yfk+5mJJEE8Gs/tn1122zanAdudRYIead8RH34k14dXqnxXARU1xb8kL
   aA1LRE+G+irAtCQ665NPuZi1LNGdRlW5O3XXn1qczs/sOX/7NadC2xaNv
   YWA0+pjbQYssNEIqMwCIA44m4GLfH4FNoCTZq3pVMgNgUQgsaddB5qFN3
   g4vBHxDKHdVoXpfBrhtT4nnNNkboD9vUviJPc+18Rv0viWCFuRFdOMZso
   uEPDrbM+D7fl+vf+PXhgTxCETntqS3eosDqy4H9t/VOGTEy7qdcwNsvpC
   NHPf2qHvZIdhgXpWr8Kmd1RrWMjLLzQZF6fDZCjsB3zOGnoqIKPBAvPJI
   w==;
X-CSE-ConnectionGUID: V8d7W28TR7Sw+WZp1QnMyQ==
X-CSE-MsgGUID: DS/ZuvHgRRiZrGFYqwe8Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89954846"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89954846"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:27:33 -0700
X-CSE-ConnectionGUID: hQGXQPEeRaOEboJCAXn06g==
X-CSE-MsgGUID: fy1DZtiMSY+CPn5P+Np+cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="302808748"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:27:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 02:27:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 02:27:30 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 02:27:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=um2ab7b4spQqt3hk0CE1ecgOh3owsILVhaKeipgmYmYPJrEnzdZ454+g3Vowrool+8KWQW/jdLSEVBh7NzZd4Q2dMzdOiiK3vKoRoUM6c25FmNCBUE9176+Co5VBPy6PAFZuRfVC7ykeBb4VUxb/qVgm7xurM/5l9QZEcSy3Ya61qlEluJmEUmzRaFGTUACIbl2WnsuPvgAPAWPmW4mIYwMc4vtWpQTqlbYn0m4JqulzF/NXRqf7JhpRuuWvdBMFqnGVs5ul2LjIlA3pr+U1TQxdCgthM4CjKeRzHNSni0n05YNBTRpgkeqh0NA4V92xKSIcdPrSrKWXw25HCl7O7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucvbzI21e0uoaACAmhxOsEQ/0yQUCnWBB2/kcVNTYG4=;
 b=amiabFrHNAXEPVx6W3KoiIhcMF3C+aN9cVmpCzf2tlwKC6L+nhqbu64gK5VGG63WQJ1ynyEbbRGAX1lJjgUNSxwwPJb1yPxrkdtOTQKiBX3aNeUsvawQtL3hsfwrdfkuuSY7+wq3GrjcyH2l/aKWy1BVizWpotcxfLpY0MdX2Fg5dRYbfGQA+UNjNHGrnUL6sJvqFY2p2T1vVXVx/LkZU56o4Gu+JzwHsUitSQ+knT+H+OoIYr0Md4+rvrMoIt/iHAl+5ba3jbyAbtP2Kkc9IfIvMsdFalpasKwoobW2tR51R4hhkhkoxl0ATZMgeWu5kwoyy8YBN/Bgfx6L4+/32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH0PR11MB4808.namprd11.prod.outlook.com
 (2603:10b6:510:39::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 09:27:25 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 09:27:25 +0000
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
Subject: [PATCH v4 3/4] virt: tdx-guest: Use a variable to store the Quote buffer size
Date: Tue, 15 Sep 2026 02:26:02 -0700
Message-ID: <20260915092632.2822169-4-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915092632.2822169-1-peter.fang@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90a7d0d0-3f6b-4fef-0757-08df130b8d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qGeo9rHLDOHUySBl9L/RDse6ahHVeSszU2GKBO70sPQSy3y2S0nyJ+lriclUCt/gqhJ8oZV/KhYFPxRH/svjXgkSwjY6OvfERYNdgbaxxFA7aZ8EVzipoRvL6QUSw+qyb0enzEdINX2vlof41zWBv22WRYh6l50bpvURpuLSADTJ0gHz4a6wG8KQ01G8MfXy/009IKupZTM8ImMihPzHWC6hGxHssxAUJ1QUPIfC03i50wYZmLpV9wFXuF6legHr37ECjLoTFJzmXzszTiQwCTVNZMPSBmb54dAS1LGYaZT8MY6E8TlZ1W9GYjkwV22ea7x4AaWPcyNoL4Y1QUbUYO06+fT1/07Rr0p8r+P9s9ZzQhbQZZjz+oScCaNoZAVxUJTUiM/Ih2AyeO00+mnJ6qogrFLEYvO1NzwFUrVq1MetWtxrGSHe8cNaEvEUV7vIKmXc0B6XzsXclg+6ycD1u9Ygvaag0xs8eN8rwTQuU2aExYyJufONYYsv2MIWmumtQh55S5Fk5swiG4GyQhEL3v7ktxKqksFK5l4D9v2eW99PV1JgEUtdmqZ1dRslXZw0wSxbuxSRtIHuMTx9cGjepx7VQ+5nfsbm3mENL3UqFiYKHcYhYam8BUda/N7WgNIvRIc8BcLOFffRzLyHNIGF7SNlBUkN7xTiYz32tIaCzFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sMhzcFvaZx9tyz3Q1Zp68uTSnD4NibtcWSng2Z+pX8TSgCKcd3BGTZ5fh9+j?=
 =?us-ascii?Q?xVqnCt+skswrIOvjIzKzYwbqokunm7kkgI/wYrWA8mPodsH53wi6jiPbbUZX?=
 =?us-ascii?Q?Ue4BZiKyh7yguI8TylSrXvUz6BDuhN1Zn1YYwKoh4UMw/ERCFBp469BIL8kF?=
 =?us-ascii?Q?t0i630uOimaoUWlq/sPZj878HiQq+0LZho9vGtltmsGVfAq9HfAI91m2TqVa?=
 =?us-ascii?Q?vygFsstVb1rUcgIIVtro0xZwJVbqMVRhdHn+9uU9S6F8Nvw6uHxKKDOq7XgP?=
 =?us-ascii?Q?DepY1rIYBAvM9uTD/xyHgHvbbWmZX7bYJrTEd5IYdjAgsPUVo+gLo1B/m8k1?=
 =?us-ascii?Q?5eqJeVPQQXoy1Qk+TMTjCOSbmKbxCIBIPZJGgJlSuQbxrScrtbuTba0FcZGk?=
 =?us-ascii?Q?xKKw4Dy22N/P6DxykEtgXrTIH3fMkjtiJQK7eBuS6KsyuIXWszkErqm+F3xb?=
 =?us-ascii?Q?gBPhhnWgTbcHT3GD4gSOqzrseLgn4JZTJXu+mE1FPrGm7YZR6O3XCFCDrDwL?=
 =?us-ascii?Q?zZKsrbNLrIwqYyzFjwoIL3A8mQy5tUZ4gmALJjtukOAF9r5AFEiiacgBXZup?=
 =?us-ascii?Q?9grZVtnIJD95Nd3liaANPHp3wt6XcT9ckrJnfq76hGvTktRSyUHqmbNqgDvF?=
 =?us-ascii?Q?zlliAVninAb/qeTSyMO/uyLa2Z1qonnHZuU3+xlYzFcbz1xCxxtbMITbC/hF?=
 =?us-ascii?Q?HRKXPm00hiGTi0E1EYuzI6Cn02pfG1PP834c6pJcZjgHEJRlgwfoS8+YR1Tm?=
 =?us-ascii?Q?SMt//LBsc4zMa0fikJPcPESsn1MPGly2Ijn2rB1DzSGa85i7u26ODvD1kJgY?=
 =?us-ascii?Q?mRPCS25Uawi2/3HcmCv5nzp3InOBEdzIk+vFO8Bardvbxsb+pNGQeSNJR8JV?=
 =?us-ascii?Q?b7aQHUWmdtyHojd+Zt14onqEiIRVJ2BLXMGJhHsQN/5+9fy0k3RmxT8mY2nY?=
 =?us-ascii?Q?qfq0YF5coKocRnfbbiUVICpC2hM544ikP3rw/IXgIBIHy3W/ltDuaA6HE3Vf?=
 =?us-ascii?Q?6E0hT8dMNu21ZgmHwoSbUdoULSBF2vCb4kfT5y6qoemXuAROIYhAv2Ettez0?=
 =?us-ascii?Q?0bLV6avaVp76wunXkzhM/faIj04ZowFUmycFXElE3Z70ugKFkgQduL5IgNC0?=
 =?us-ascii?Q?fuzIA/ZF7gexRjPJTL0070y+/tfymEGhMU0ZZRQDDGonf7SNrdZxYDTlYukT?=
 =?us-ascii?Q?Ul4ti7GUfZ/ySQXRlpnJETmZmuQxMU4+1s/q/oWXdnu9g8DgGAoRlVPExnur?=
 =?us-ascii?Q?nnSkSjLFinsUqzPtanNFaDsG8UZgy2Crk0JJOtT4brfwMb5T3tFTlV7fodIP?=
 =?us-ascii?Q?+FOZgkuMK42L0zVW/QGDWRyJ6JHKxGretxLPBsb0Spp7+xk/+S/a+qm7pFU5?=
 =?us-ascii?Q?MNJVval3qyKQjG27E4qrjZGoEjqR+5VzVbUDsnYXgNivADegsrohhyoSQvi9?=
 =?us-ascii?Q?5qbwPFDAXwD/7YOapNGKyb2kwlS5SfIcRjBmz2Nnhvk/ZYetDnXQE9sNHpk3?=
 =?us-ascii?Q?RInG+mWlCifx4HWSndgO2eA+iWhp/0JgtXCB6QqeT3PKx+NcBvY7VczcULfB?=
 =?us-ascii?Q?XAUfhk03Ef6jqiTx00ajj0M2ORQyfd7lBVteVKuWPHUuJf+eEMLge3MzvkQj?=
 =?us-ascii?Q?3HsYCeObDCTymdu6mw8RMV8IyuDhAWmrJztxSV5NPCUhKqXhExWwYLZ9G+1W?=
 =?us-ascii?Q?PmrhwYqdTBpVLSwOHj9tRY+k+jPvgfx4S6jZl4tCkN7zCRG7LEuHDUGyhx0R?=
 =?us-ascii?Q?ku4Dscj7OA=3D=3D?=
X-Exchange-RoutingPolicyChecked: oDndJJDr1AAPmraoDx419zoxwZOR3ynuIHzvHu1Yu59RiIGgi5hZwwuT+RvWKkD3UL8mikNXJeaPlyZ0P/e3OIsZqB+Nnz4tSCM9DDFWKL31bYmI6moBTFJHtT9qOOgGed5Raffp9wcvTz7vsB0iGAh0c0RHCkFVI5xKGrfTT1zoJcfZVJO+PmJUmWSg9VWhUuB1Oo4/PVumFK4rPMpkJ7pNSEATTg0wgKHdwBOeA4PywWnsi+VQ5IbM0Qp64ioKDIG6nMQBCpyczGvN311F74QFq5swHjJFhtPBKQ3yZf0bNpDu+qd+uTiyzd9LqGs3QJJrjrigDJShZpw11Pny2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a7d0d0-3f6b-4fef-0757-08df130b8d7a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:27:24.9806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYD9UX03GiJ6e/FyLHXD5toD4DJmTPGv9cdtGSbVW45D+uDPXv7hE6qrerR3MSWMBP7mxWxW/PRCWoXhKVb9aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
X-OriginatorOrg: intel.com

In preparation for dynamic Quote buffer size, replace the fixed size
constant with a variable.

The constant is sprinkled across several places. Read the size from the
variable instead.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v4:
 - Keep the PAGE_ALIGN() when initializing quote_data_len. [Xiaoyao]
 - Add Reviewed-by tags. [Sathya, Tony, Binbin]
v3:
 - Split out using a variable for the buffer size from the v2 "Allocate
   Quote buffer dynamically" patch to refactor first. [Dave]
 - Pass the buffer size into alloc_quote_buf() by value. [Dave]
 - Drop the Reviewed-by tags from v2 (Kiryl, Binbin) as the patch was
   reworked.
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index f47c5429d002..ec886c401fcb 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -191,8 +191,9 @@ struct tdx_quote_buf {
 	u8 data[];
 };
 
-/* Quote data buffer */
+/* Quote data buffer and length */
 static void *quote_data;
+static size_t quote_data_len;
 
 /* Lock to streamline quote requests */
 static DEFINE_MUTEX(quote_lock);
@@ -209,9 +210,8 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
 			     USER_SOCKPTR(req->tdreport));
 }
 
-static void free_quote_buf(void *buf)
+static void free_quote_buf(void *buf, size_t len)
 {
-	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
 	unsigned int count = len >> PAGE_SHIFT;
 
 	if (set_memory_encrypted((unsigned long)buf, count)) {
@@ -222,9 +222,8 @@ static void free_quote_buf(void *buf)
 	free_pages_exact(buf, len);
 }
 
-static void *alloc_quote_buf(void)
+static void *alloc_quote_buf(size_t len)
 {
-	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
 	unsigned int count = len >> PAGE_SHIFT;
 	void *addr;
 
@@ -285,7 +284,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	if (desc->inblob_len != TDX_REPORTDATA_LEN)
 		return -EINVAL;
 
-	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
+	memset(quote_data, 0, quote_data_len);
 
 	/* Update Quote buffer header */
 	quote_buf->version = GET_QUOTE_CMD_VER;
@@ -296,7 +295,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	if (ret)
 		return ret;
 
-	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
+	err = tdx_hcall_get_quote(quote_data, quote_data_len);
 	if (err) {
 		pr_err("GetQuote hypercall failed, status:%llx\n", err);
 		return -EIO;
@@ -315,7 +314,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 
 	out_len = READ_ONCE(quote_buf->out_len);
 
-	if (TDX_QUOTE_BUF_LEN(out_len) > GET_QUOTE_BUF_SIZE)
+	if (TDX_QUOTE_BUF_LEN(out_len) > quote_data_len)
 		return -EFBIG;
 
 	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
@@ -417,7 +416,8 @@ static int __init tdx_guest_init(void)
 	if (ret)
 		goto deinit_mr;
 
-	quote_data = alloc_quote_buf();
+	quote_data_len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
+	quote_data = alloc_quote_buf(quote_data_len);
 	if (!quote_data) {
 		pr_err("Failed to allocate Quote buffer\n");
 		ret = -ENOMEM;
@@ -431,7 +431,7 @@ static int __init tdx_guest_init(void)
 	return 0;
 
 free_quote:
-	free_quote_buf(quote_data);
+	free_quote_buf(quote_data, quote_data_len);
 free_misc:
 	misc_deregister(&tdx_misc_dev);
 deinit_mr:
@@ -444,7 +444,7 @@ module_init(tdx_guest_init);
 static void __exit tdx_guest_exit(void)
 {
 	tsm_report_unregister(&tdx_tsm_ops);
-	free_quote_buf(quote_data);
+	free_quote_buf(quote_data, quote_data_len);
 	misc_deregister(&tdx_misc_dev);
 	tdx_mr_deinit(tdx_attr_groups[0]);
 }
-- 
2.53.0

