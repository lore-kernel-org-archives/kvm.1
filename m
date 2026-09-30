Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD263D647C;
	Wed, 30 Sep 2026 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764706; cv=fail; b=QnQ2SII0luEYSisYesIiesV3hFkdvgGTFjEu2raXkLqYGJoFsI06aDooS2Cr4n41I5vf04KBdA1yswOFf4vw7TNMd8oaVqay3TDQxrgIL3wZX9DNMXze+8tOI+M9IjE+nghMSglcDRbjsHylX9nZ4bLCEhiGS3axx+vdVwP2lns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764706; c=relaxed/simple;
	bh=7/WQCr3IP3SzMCNvd0mTDrbg6ULQJRTkUmjgVFGastY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BWYNud1UWUmKe+PmPLGI2aA4rokaanA55ggIIfYbJo+xzTaLmAPubL9LhGUAPpFFRWuM9TOE9PL6vvmqUrzsrDKfj2rt7iXtG8GQA8Xm/3KYLU/zI5UW2zTYWCol5ae10i3eTGNVsPikl5L22ig5LGH7NVUEibvCYPM7rM0zLkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSPxerpH; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSPxerpH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790764702; x=1822300702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7/WQCr3IP3SzMCNvd0mTDrbg6ULQJRTkUmjgVFGastY=;
  b=iSPxerpHisFJmFE56G1BN4K5uWmp+/HxuhKQ+PQiuz3klyKdU49jPyjI
   d1xoGkotB+6AJ8HJW6xg9WWjv93tXa1+JGMECVpLgtOjHio64wdVC2vZg
   JKr6A3kNKiPJ9IsGeNYMN0S/VWI1FK/1fvn4TnHQ44jux2GT2LhGFtlmJ
   acfurpYc+qjTrW4mTCcL71iMrKpUZYAJt3N6I3pdw9Ji/Gtwk16E8C0mJ
   0V5MM/By+O4rFpCb7xTST6rRjEYfy1z4oUrCsKXTUhAQQG+4nKsUpBmWI
   3SWkNa5SQ0WIVj+xz0QPzwrgDmMgMhjCqiwCzZzWrShDYyZQfGeNBFO2i
   g==;
X-CSE-ConnectionGUID: IPKOg7npQTu1MFgWUR8bLw==
X-CSE-MsgGUID: 6MCZYcLSTyCLF58LiRO8hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="79066283"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="79066283"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:38:13 -0700
X-CSE-ConnectionGUID: RLKk6n4MSHGmW8+pfYGJdg==
X-CSE-MsgGUID: AJwcwmMvQjqfB1JHEIaK4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="303588998"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:38:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 03:38:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 03:38:13 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 03:38:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYtKTTnkztoc9nfY5Rt2Y724O7VQuXIzfAN0cI12zLRugJ/kCIook4zZ0VLnsp5oAEK6ed3mcaHT0tD4+IJxNGLo/8HwYRjGhWAd0Z+5iYA0nupwmRjn3UsI6F1tmlgjQBVN/feK6z8alR5VfI05JovcysZupgsDXtGiLrGzlLmoSiWWg5gcF4Ye9hOoMra3lz3rsNRjGuBHWCAC0FbPNPTaBkrdO/WONroSDcpiwsqBKaQpt6dxnmQH4I+UhJ6MgHsaNl09k1obzZdBmXGBdjI04vTojuqwyBhDKlwUcXwHRxluIEeXBBMNiBq52zN4tnDUXovb3Bv6eboyLtMNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWgpd/d2BTJS8xE3mipvvCK28zlTQT2gf/i6RIv4G0Q=;
 b=HNi3g0gju362WORRt3xj/6MJE+lU08dfiGgsYQg5XsvhrKYEZO+GG26yzP1PogdU06nghM2wdJsROfqG4a1GCQvxRU2URc42nNOkPviVEPh0yGSyZx51jpb0lgfbaN8xkZLlNEb3M1n+2FjyeOoLOIlFGbbjLUO8+Wnx1wYmtqBSMqzLoSqQ5D/A1A2s0Fc87BhtVP8Jk63/MqYgph1h0JYwVYY7x9cBnlRID0v0W8ruwbj00EA4uXyyhY8dAxG0oYv8tD14FtNIf7xVgeWVwjz97VftpoCVunlWF4cx8kh7uOXb67BlL90pmCpAPZItuNjUeLxiadkKQ3PaQc3UFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CO1PR11MB5154.namprd11.prod.outlook.com
 (2603:10b6:303:99::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:38:11 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 10:38:11 +0000
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
Subject: [PATCH v6 2/6] virt: tdx-guest: Give the Quote buffer an explicit type
Date: Wed, 30 Sep 2026 03:30:51 -0700
Message-ID: <20260930103739.2851980-3-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: ae8ad826-dcd1-4b6f-c713-08df1edeec9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LizfKWl7FTkB0avQEI0ZgkZ5uV6Xi4ijbDeWG6l+E18f8gfuuuZ5x2yDNeyQts8DS70pL/u6tP8XvJJLWUT92kC/GnMtOfE2XOh08Cyqizz+igTsofUMlwLPzfjoRbPDMYAxruGncf1HdaKI5Rt35HCrpTtOnBzu0j5fFEhldZzTJCha2bFkD8TPSmqvzXjljO281I6+v0cl76u8JCIb0MHgEr1+fErlSjdMkADo8P2VsnbnPEYHgG8D+UXUTU8HiNw9IF+gPF4kRFeoGlT/+rHFFF53s7EyeQGMc3i1YsonYFCI5JtzBblaVVHey+sZYh/wm/Qzn7o76Ojd+qy9Mnh1M0M9lbDnlRuMTmyKo3Sbac3BCagxqw35UAJX/oHgFhuNZbqnfdVtOw/0EPcmISf/714Q5TgbRAGtpfwjg6oX3JRvhVRBu9Fq++YrbzB6eWIbcBJaRyEMSUodXkuPl/gdjV8Oa/b+955dOAKs7dqLcbM1/M1xUyzaR2TELQPvegAHB7ef9UPj93hxyVATA9XxN4oMEsWeGE3qXnnM2qQ5EGtQxjR4NlhwMZ57it3QJ9/xcspjBCkA+k5M7GnBD/hcmf7RMCMi+5fN1oA7W7FpaStra2Q9gBVRQ+a8UEImprp6cjziAZ9Zs6SaXOWbXAgl5RZ1LD6Jkce+xl7Bypo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1hk1UTubu9JpvNXbcW8nF/JGFMRPlv82iv/9mktaxz9e7dUu+IjrWwPUVyar?=
 =?us-ascii?Q?jMmtSXuN5zk9WwtxgOlj8QMRGjHhOyUqyAxVV1lir59A/091K+4/xjemAcu9?=
 =?us-ascii?Q?W/GZNuTklxGVvrv94zbYU6UBVyrAozIXeHLdmhvzfbcnDZwvSeTfxwn8szfk?=
 =?us-ascii?Q?+sHMI44R+4HvUBeNqhE5rvdfSFDvUZAfFU+I+ORA7Wz3CDCjcosRQKi47dmS?=
 =?us-ascii?Q?+kzTW7l9ItLTmBljyYdRZ1oObs9gwbJME88bCBb0lYnJLeGzH885S9pKy8e0?=
 =?us-ascii?Q?++fxaww4idvutfXYnlz2nvjTf2dtkwwMwsPuD7vr7KmQkUNqQ19ftVWWDJVl?=
 =?us-ascii?Q?MylDHunQS/pM+dbAbHql1HbfkwsWTBmixnZBJP/bjCy9m3V21oxdzTyXL98f?=
 =?us-ascii?Q?pyF36zeq1wVMmrWUsy/tEndOQVRcjv7Mt20zBMAp21MKDlU39AL6W5qOGdRJ?=
 =?us-ascii?Q?2BIxgyVSyXiEm23K/PXw8cd/6Ua/PK1RBwq49mo1H1t+ISWfJ1a0k62iPG5r?=
 =?us-ascii?Q?YHTL23OIS2CKNNvn0wW+7V+YkKqqrFGzyWXdYf6jj8W9GDonOVTVWrG+RGaL?=
 =?us-ascii?Q?TX1V0+1zSNFLEGZCFnRnEvqLYRGQTxRRq9HrI3B/8dumqyvSQVzTRbyUiqDI?=
 =?us-ascii?Q?cS/FB7bmoEDeeBsKiKvqv+QmBgbGf62sbELKXK3fgXefLlSAMufg9ZVDZUoL?=
 =?us-ascii?Q?86F/GGLHtTSvURB1ke2b2tiAVGfGNaHFt69vCOmeIQcvSAFaBzR4V6Blj7lP?=
 =?us-ascii?Q?DFmRuNq2CWnslYg2HQkCkuGJG9qefDRuhM9VciU1/5PKPKR50idyGqmamrdD?=
 =?us-ascii?Q?psx8vBp90rBJc4n2rM8IZ9CE6wfapejizl6TGHfPpdvAvwY33q9t2XQex08S?=
 =?us-ascii?Q?eliVbCgghQIgpbKQfJU5WQ7+l7CPLPI0lT5K6Nh/tiYNPIaRLsP7lfghbF9f?=
 =?us-ascii?Q?g8tP178ix2m3Rmmivdp6+FEZ0qcAmesG3Weq1cdPIhsabfuGAD71vAxZIpi/?=
 =?us-ascii?Q?b7kp/XmBfqtJU8oNjzythnHlZroYdDRz48jkrcfZeJdr954Al3Tl6hKVFmhj?=
 =?us-ascii?Q?WIltwsdQNHzTLZ4G4B/YQoppYoB8d928PAsQuUT4B3bmqvw1W7eVsDQmk/A0?=
 =?us-ascii?Q?EAWIFw7QZJX+7L24GgsMk5iho0q6NB08ufi7q/cl0UDzs9eNduZjoPH97HPb?=
 =?us-ascii?Q?8j6rHjCQiAEjK3lX5Wy2aN+8SfDgfMwnAoiRt4Yn10ijzXITQ5sAHH4okb/a?=
 =?us-ascii?Q?t3Ck2ZKb2xrrnVMU9q0I16DxP/xmSLXbMlYmda61OLN71sRRzswruQPfK5C/?=
 =?us-ascii?Q?zk/eGOMhXxj5vGHB9PdZ8DXdpDc7BDnJvfjh+mGqDHjHTCk2H+2wtjAxZVXm?=
 =?us-ascii?Q?1GFilgvQTtMO/4FQrhG5wpaUm5xISgljmwCLlvqk34a0l0GyEsNSb52BTSLJ?=
 =?us-ascii?Q?f5g4vdC1y+ox1NlJW75XVH/5IGasrtVMvwx9hFTQNuGcXyUSZUV9rw5tSHWw?=
 =?us-ascii?Q?QEYj98Md47i4h2MT1T7KRuFBPEuW2+sdzQVe5I+nviweRJPQ2p0RlV3riafs?=
 =?us-ascii?Q?lYJKpNSnOo2WO8YaW+DkSSfNf0KFFewr4sSmLrgZ8fdHVa8/wDYAWHbfMKWt?=
 =?us-ascii?Q?U5TgaXnBKfDG352DvM+QRTdcnGfosdPyFEg1bn+H1cUJjv35eroTzHjd+8UQ?=
 =?us-ascii?Q?QWrW7sQGXi+QNag9lhQLoIFbeMn27jIXfmC6sInSazRoB0R3m7cHo33j7v3b?=
 =?us-ascii?Q?71FB1RT+nA=3D=3D?=
X-Exchange-RoutingPolicyChecked: ntMU4bjTQi6NE0yVx7JNwc+hYG379U0h2+mJY0zWMEIpT53QxPjyAzAQlyyf5GLV5iGhhm57NIKalYNfGwPfCufy1VF579l0QpPRPhu0kuZa9N1PuQw+UcpoKijQq3iLuHSS8yWdy6O3+sLzRbXIPtpxlh1jSVxZsW+0G7Q+O+x8N/IERRc8xRzE2H8Q1VuQBBc/YUM6wTKQDR4G2saiwzF6cTWcD6qXnmyLjYbjHL/zv2EZoyAbb8FKtixiWPpUBq8AG/Hk5uvMXEm5C25pnI2G6H01ALCwEXpZJmjBEp7WWHyAvWZMLB+5e2XltgQ1LJfimsII8a2Rd0Lwvkgzqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8ad826-dcd1-4b6f-c713-08df1edeec9a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:38:11.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJ1/ReqV6gHl27vM7ZkBRnsKR2XLLVj1pA6bcI/rqPGsbEUAUM4drAgVEDVl+h8cze9jFOZXvJGz8SSyERWcxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
X-OriginatorOrg: intel.com

The Quote buffer is always a "struct tdx_quote_buf", but its global
pointer is a "void *". A function would have to convert it back to make
sense of it.

Declare the global with its actual type, and give it a better name.

This creates variable shadowing in wait_for_quote_completion(), so
rename its parameter for clarity.

AI was used under supervision to collect/apply feedback, review code and
workshop logs.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v6:
 - Drop the comment about the Quote buffer global. [Binbin]
 - Add Reviewed-by tags. [Rick, Sathya, Binbin]
v5:
 - New patch. [Dave]
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 36 ++++++++++++-------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index a21bd0376b74..83322cd7673a 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -191,8 +191,7 @@ struct tdx_quote_buf {
 	u8 data[];
 };
 
-/* Quote data buffer */
-static void *quote_data;
+static struct tdx_quote_buf *quote_buf;
 
 /* Lock to streamline quote requests */
 static DEFINE_MUTEX(quote_lock);
@@ -209,7 +208,7 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
 			     USER_SOCKPTR(req->tdreport));
 }
 
-static void free_quote_buf(void *buf)
+static void free_quote_buf(struct tdx_quote_buf *buf)
 {
 	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
 	unsigned int count = len >> PAGE_SHIFT;
@@ -222,25 +221,25 @@ static void free_quote_buf(void *buf)
 	free_pages_exact(buf, len);
 }
 
-static void *alloc_quote_buf(void)
+static struct tdx_quote_buf *alloc_quote_buf(void)
 {
 	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
 	unsigned int count = len >> PAGE_SHIFT;
-	void *addr;
+	struct tdx_quote_buf *buf;
 
-	addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
-	if (!addr)
+	buf = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
+	if (!buf)
 		return NULL;
 
-	if (set_memory_decrypted((unsigned long)addr, count))
+	if (set_memory_decrypted((unsigned long)buf, count))
 		return NULL;
 
-	return addr;
+	return buf;
 }
 
 /*
  * wait_for_quote_completion() - Wait for Quote request completion
- * @quote_buf: Address of Quote buffer.
+ * @buf: Address of Quote buffer.
  * @timeout: Timeout in seconds to wait for the Quote generation.
  *
  * As per TDX GHCI v1.0 specification, sec titled "TDG.VP.VMCALL<GetQuote>",
@@ -249,7 +248,7 @@ static void *alloc_quote_buf(void)
  * or error code after processing is complete. So wait till the status
  * changes from GET_QUOTE_IN_FLIGHT or the request being timed out.
  */
-static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeout)
+static int wait_for_quote_completion(struct tdx_quote_buf *buf, u32 timeout)
 {
 	int i = 0;
 
@@ -257,7 +256,7 @@ static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeou
 	 * Quote requests usually take a few seconds to complete, so waking up
 	 * once per second to recheck the status is fine for this use case.
 	 */
-	while (quote_buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
+	while (buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
 		if (msleep_interruptible(MSEC_PER_SEC))
 			return -EINTR;
 	}
@@ -268,7 +267,6 @@ static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeou
 static int tdx_report_new_locked(struct tsm_report *report)
 {
 	u8 *buf;
-	struct tdx_quote_buf *quote_buf = quote_data;
 	struct tsm_report_desc *desc = &report->desc;
 	u32 out_len;
 	int ret;
@@ -285,7 +283,7 @@ static int tdx_report_new_locked(struct tsm_report *report)
 	if (desc->inblob_len != TDX_REPORTDATA_LEN)
 		return -EINVAL;
 
-	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
+	memset(quote_buf, 0, GET_QUOTE_BUF_SIZE);
 
 	/* Update Quote buffer header */
 	quote_buf->version = GET_QUOTE_CMD_VER;
@@ -296,7 +294,7 @@ static int tdx_report_new_locked(struct tsm_report *report)
 	if (ret)
 		return ret;
 
-	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
+	err = tdx_hcall_get_quote(quote_buf, GET_QUOTE_BUF_SIZE);
 	if (err) {
 		pr_err("GetQuote hypercall failed, status:%llx\n", err);
 		return -EIO;
@@ -417,8 +415,8 @@ static int __init tdx_guest_init(void)
 	if (ret)
 		goto deinit_mr;
 
-	quote_data = alloc_quote_buf();
-	if (!quote_data) {
+	quote_buf = alloc_quote_buf();
+	if (!quote_buf) {
 		pr_err("Failed to allocate Quote buffer\n");
 		ret = -ENOMEM;
 		goto free_misc;
@@ -431,7 +429,7 @@ static int __init tdx_guest_init(void)
 	return 0;
 
 free_quote:
-	free_quote_buf(quote_data);
+	free_quote_buf(quote_buf);
 free_misc:
 	misc_deregister(&tdx_misc_dev);
 deinit_mr:
@@ -444,7 +442,7 @@ module_init(tdx_guest_init);
 static void __exit tdx_guest_exit(void)
 {
 	tsm_report_unregister(&tdx_tsm_ops);
-	free_quote_buf(quote_data);
+	free_quote_buf(quote_buf);
 	misc_deregister(&tdx_misc_dev);
 	tdx_mr_deinit(tdx_attr_groups[0]);
 }
-- 
2.53.0

