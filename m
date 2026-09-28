Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562CB47D45B;
	Mon, 28 Sep 2026 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590264; cv=fail; b=Dfot6TVEAvbq/E0yHU3XTEacdv+mDOqbC298OBH76088xz/nXLcVuI+AZbIMzkz23J9T77quMrqSYRZqttLyN9Ptvt4WUGYJeZbtLB0sXe803f0WJ4M74+R6YKbkhMIh+7IUWui24WIAoXQq6p/WWCQkNIv30jT7ueZj2Wdj1Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590264; c=relaxed/simple;
	bh=MJjzMrbaESSrRL7V/HvnZ5r4OUEukg2QY6ZvBMmwhBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QRW4ZS6r1JSjYFVNRt1CCX7zO6/GDfmyfie3i5dIyOqk97LcN+hqVtRCDN6N7bn3nZdPn3NnR7ppi8Kg4FRBKgLLpOsENvAUb6LFgLZlv2rVLwZMaMVRDOtWQsDOOL1yBv5RHwSp43bsQhj2bk/ZkeishDscsxs0TQXvW8s8lOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXxnWZMn; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXxnWZMn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790590262; x=1822126262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MJjzMrbaESSrRL7V/HvnZ5r4OUEukg2QY6ZvBMmwhBU=;
  b=GXxnWZMnVs9fZO/t35D9aAeXjr1/++fQZ0kSRGphzgZX5nYC5HULdJ28
   5na072or+z8/r6ZOSGME5Ow4WhROJnoAziKx+E+FTH5uhf6kULDfrL4WR
   uC1fyfbxS17SIiaoA1g+R+xo2FR6CvAzqdPVPZc/Ek3tfTauxUbrO2yLS
   9nhPhH9T4+OiIH7hUjV5Qthofj7fnxrFI1rnSyY13Q2EnODQ7EgvKVIqM
   4ZhE4y20auFm4Xbbq24VIFbGN9Fe8CBK5VJ+iN1ycZUuNCcTQM9rjsDgd
   Ag4FbBzhxV27RxKGonrLXoUbpLb+uDKl2CEmfuyb8vyRobg8bVrmMcKOu
   A==;
X-CSE-ConnectionGUID: 7LRBY71HRiKSt8xR/Woi7A==
X-CSE-MsgGUID: sKBd+BDvTqaCShtcCl9Kyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="91388354"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="91388354"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:11:02 -0700
X-CSE-ConnectionGUID: 6RS0mZ9HTDWTJHTTQ2KR4g==
X-CSE-MsgGUID: mDZGcF/QSu2aBOlt9P+DoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="279735407"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:11:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:11:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 03:11:01 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.29)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:11:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkWR3FT29WWmhFzk4cvEr4L7npeJmxtRZ5spqcIxLW76ektFMezUMBTnAMyv/ps+Wiy2+YQ5RTTGwKN7drMIqUWyA62KYjSGBsMShc/Hq3DJPxXJmXcvBG1ncab1++Sp6aqUSPtms2DW2JG1bj3LMxLdippNV1di/roof4/EIPUIls+j6FGADTJfOwQXYg8htH2oLmVP4kCGd7D2YfURBwr3RqOyoRQej9G1uWr+eEEeWEhGNhUAO9Ml6CJhsmrCZxuYFIYgRDedRmsQ/Tx5JjDHYq2rwHK7MBHQJTrYCEMZgBMWZMBnxoBCjFCQIGqac5/JGYymgFaBezOGqTqrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Kh6UTGJ1mhQgQQxAI4Ua8p/Arx4JIpIMice/a8odZo=;
 b=RIlESjCVkeZK13BpB6xLdcEFxmt/4y0bDyUDIbbQVFs2hGrdQM/u9Y+O9X0AqlUFG5iANpN2MjhMP2iwysgPw9qgprxaLEGDTJOtPm0lgA3/2uP5gMcbap5BZgI99WKudpvem0an1t2eONkcHLN5Iq0x+x8xOS1ijFGyPukis9uc3u72Muql8rYViNmOwSkU201tk5wcuTZNd/n2zRy3AiTwFyth7zmE6TCwykkgdm5tDpMSXQxr5hDbZnx3waCwlEl3xje7pz6VMTrifWKXvfEUsLAzq5WaVh6LSokGyX9kKTw7nEoaKVKPkoSLuE4WtTTEJeNDZvSVLjrBoOhsvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DS6PR11MB896703.namprd11.prod.outlook.com
 (2603:10b6:8:499::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:10:59 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 10:10:59 +0000
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
Subject: [PATCH v5 2/6] virt: tdx-guest: Give the Quote buffer an explicit type
Date: Mon, 28 Sep 2026 03:08:13 -0700
Message-ID: <20260928100913.2265687-3-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ac450c8-b7b4-4fac-3714-08df1d48cb4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AY3Yq68j5RZEqaHYYuU5V4TqKh5+2qrZQ/Gfew1qbP0PbIaxyqFIqCsSwgd/KmbXfMIJrjgANUvZ5bkWrstNuctccFSYttKOI2TlMBuYdaOek0RfICfugFCFh/F6x4EG3wr89xlvxS38THsDY5Gjnr2HuukZ6/bWKRuV5bL9czfsKrET+BpOVq0jk3iXOD3pcv9onOCE/Fa2v1oJILKdKVA6+BQMy9s2N1MlX8wXllOlUmQcTrxja+lqzurMLp2rCwdd7U0iezpxjClSg2CQ73vDrrL6uaEBozDd1zSIdIHE2mxBpx6WCHMhSCEiaHSI/ftnz1UINhyshCzYaHPWDJIko7OclCWf5sM5IunoE3YD2J1whSvPjuHhVduvfIwIJ3YyDbH97vYDQ+krI6s2v14ogUar2BPbutxe1iMqgBLA01c3HD/GF2kmxbPjPp9hVlev0ryGLr59TYEW5d1LdSx9bJsqX3jQrExIVR0CTSRjaJdu2xVEeUdX8SeIx4O1Z4mDl7vv6jR33Ho0gIg33JWj19KfC/7uQJLhrI7yMxK1UPn7Z9e+iD0BOe4CYbBMRgeRV5XW24Pl/PiX8e5t28d2vT0yyx59V7NzejTFe8XafJXylUGBrEv3sPxS5y55aWCGHadOTBRwtrlnQdARx78yo9Ihs+US+OSzjry1RkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nTCeFZVJs3fUuC5Ps39giNG8PRWz3yOEC3dRt99eZXc+HnY5ukl2ShvlCJ+8?=
 =?us-ascii?Q?yCfZG3a3egzZcl7/uZYVW6vSw5XXnibda+yZApNjlI20sTbVRrOUlKmzYZ9i?=
 =?us-ascii?Q?3gOwIXndfPisbB75SW3b0xb7vbaZkvv/3kSZ80JHkYeYJbtIKmhKMsK/+vyS?=
 =?us-ascii?Q?M7kaTfbtYrjd/vSooLeiz2Pu8qn+2JHhndSPnqquvStZM6y//DgCD84TqHk+?=
 =?us-ascii?Q?V7Bhid6ODHRow77fu+c19ay0Z2/jdrPgM18jPtWaYDU4NpIZHq9wVP/0Bxb9?=
 =?us-ascii?Q?AkSI1zdZjqVShI6O4+d+ypEyS0yfqQATNYbSFwiE+Frgr5ePoIXaLyiE9MK0?=
 =?us-ascii?Q?II/4uUR56y7UEdc/YUqKVv0nx6ubEfLchka8TZkPkQTRSc0PMfy7ZVAiRJp9?=
 =?us-ascii?Q?gNDt0M4a00OHrNJJZYcOfiigJtbyy04y5Lbsh9e0sMiTfOTr4M70Uxn/48tN?=
 =?us-ascii?Q?Tta0g0IHFJMlVxU3RCxU9NKl282pRCjvBBf/xAA0x4FsPlXiPaIPk8a9pr2v?=
 =?us-ascii?Q?HeFx4fpKqVqTATECIEuPcG+YOQv8w82kMAoxopFdsfGgcX2RcFoHr4a0Pog5?=
 =?us-ascii?Q?mdXz8YTLhwZOUwzePoR/e+YL0FJDNKeb9gajyYUpHxU+MpZoqwCPZ89x4+4c?=
 =?us-ascii?Q?4RBZXncHUm7OmXyjsbIVGF+yNTWVjFao9IOsdDKQ8W1v86mWPHJrRhq2PQsn?=
 =?us-ascii?Q?63qKaRc8nNB/ZFY3JgRrLK+kPxcCJZRRWmQhDrZqALG3aYXvNnqh/vYcWLrq?=
 =?us-ascii?Q?qKg42XQ1piklWqDVJrEWEy2cJKkhcDEa/xH/h39JU9VenLFj7tnmAtwqhehB?=
 =?us-ascii?Q?te88XizYG9kWHqF63pRPWVI+cuLJln5tHB9fRs32FZ26I0hJBVL8MEcI/gwc?=
 =?us-ascii?Q?Q86Wiiu7vQy3fJb8NvnxMRzaWBRz/d9E9NG7gCSfRv1ipmXC/KdCeBi2gkUb?=
 =?us-ascii?Q?GwVyseeZ7WOjdg9PZpahcFke/emFnzTj4DE2pB72I5fRdApvpaDhRmdhzuzk?=
 =?us-ascii?Q?PO9x0Y1ESYRskIYj1tVlxEC3PTxl2aZG2+cb2sgMiQnyFpZLaLdDhyiTWao4?=
 =?us-ascii?Q?2RmCryClvdskgN0oF7RcP107EuEIzusWD+Y7Lqc56hXf4tP6g0uJC7xlSVqP?=
 =?us-ascii?Q?dCNUJo6qvVPlkrgo/UBxGNP+odPd7QqjDZIEOtAxA884f+UC2erh+/o3fO+1?=
 =?us-ascii?Q?wkIVqYzCbxAKuPdKO4NIN3hRtPD5ObpkM/qVLDa1txA3qvioAFkNHGYHbULT?=
 =?us-ascii?Q?tFZs2ad/PYDNmQYrQz10iHOwX5ygujG82ST3UGiprojUjtbfEgjVfIgV1Eth?=
 =?us-ascii?Q?uDya4ybG/h7BhLdeKmFTTuujpwU83BB/YewK2uzvo+sDr67PVkV+XsL+8/sI?=
 =?us-ascii?Q?/KjVUo79tu1kM7GG+xkOTk6Zi4RBnrGm1y0kNy2LWiMkNEvWEzDBMaN7HbpD?=
 =?us-ascii?Q?6U9aYDWEZNskFJ+BXq34C3tBM2/4Kti6kPFFfQXVLMjDk/tnSJftxXRirB6r?=
 =?us-ascii?Q?zQV/KvVKNns4hoPxDTcvZYvn2JP3Ra+LTCNvlH6NMIR5nc8W2+doNlnjxDX1?=
 =?us-ascii?Q?260qrDo9SDsgLgwlr3fAm4fi9WcGy91lteFAeV+wSZ4LPrgYnHl6+juKh83Z?=
 =?us-ascii?Q?9YtneyE/9ZsY2qJQ7omvDkEv3YugAS+UKlDWC3KN9WqHcaPODiVrwjAfclrq?=
 =?us-ascii?Q?wFLTTKG8gzPMJBww7nnk7Ao3No8ZVekPTZCFZcKh+xCxTFzNd6GWPFuOizyo?=
 =?us-ascii?Q?VftvVzK+lQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 5lon2G70HahjOrvaCweYISfKvfZVOzyMRBfxjtyrZD9Y23HfgVEsd2XyroqZlxlc0UmBuk6kf3BiAGbqX+0mhZvX3BYJjxzkE6cQP1ibWnSqy5yTkSALpwxeaJlPTJkEUlAklPjM6mAi7i5y4BwGzYD0Fhl/QpdrJnaMKeqIJxpu8fSYLTMzNyzpzX/fitgu/mPzTkzct3bXgaAGqH6F7TW9LJWPCu3ELx98TZEgtzB/HMG8h3EkEz1QFICCED8QejSk/uyLy0cXOhL5bfFpmSPLMTqgMKL0LU2Icl44IY1kC3rXMegRTlWxuQ++FwOyCo6ZaXznQgl/pfSV8+C3QA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac450c8-b7b4-4fac-3714-08df1d48cb4f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:10:59.6614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3u3s/zvNULTyS/GZlwlLKVxAWlD21Nk/+k6xzzU8EyNQMdEvUPIWVD3jBX5AjmkqbOsKHZ/dkL0E1D2OvGx6nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB896703
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
---
v5:
 - New patch. [Dave]
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 35 ++++++++++++-------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index d0303e31e816..896eb0a09c4a 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -192,7 +192,7 @@ struct tdx_quote_buf {
 };
 
 /* Quote data buffer */
-static void *quote_data;
+static struct tdx_quote_buf *quote_buf;
 
 /* Lock to streamline quote requests */
 static DEFINE_MUTEX(quote_lock);
@@ -209,7 +209,7 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
 			     USER_SOCKPTR(req->tdreport));
 }
 
-static void free_quote_buf(void *buf)
+static void free_quote_buf(struct tdx_quote_buf *buf)
 {
 	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
 	unsigned int count = len >> PAGE_SHIFT;
@@ -222,25 +222,25 @@ static void free_quote_buf(void *buf)
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
@@ -249,7 +249,7 @@ static void *alloc_quote_buf(void)
  * or error code after processing is complete. So wait till the status
  * changes from GET_QUOTE_IN_FLIGHT or the request being timed out.
  */
-static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeout)
+static int wait_for_quote_completion(struct tdx_quote_buf *buf, u32 timeout)
 {
 	int i = 0;
 
@@ -257,7 +257,7 @@ static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeou
 	 * Quote requests usually take a few seconds to complete, so waking up
 	 * once per second to recheck the status is fine for this use case.
 	 */
-	while (quote_buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
+	while (buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
 		if (msleep_interruptible(MSEC_PER_SEC))
 			return -EINTR;
 	}
@@ -268,7 +268,6 @@ static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeou
 static int tdx_report_new_locked(struct tsm_report *report, void *data)
 {
 	u8 *buf;
-	struct tdx_quote_buf *quote_buf = quote_data;
 	struct tsm_report_desc *desc = &report->desc;
 	u32 out_len;
 	int ret;
@@ -285,7 +284,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	if (desc->inblob_len != TDX_REPORTDATA_LEN)
 		return -EINVAL;
 
-	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
+	memset(quote_buf, 0, GET_QUOTE_BUF_SIZE);
 
 	/* Update Quote buffer header */
 	quote_buf->version = GET_QUOTE_CMD_VER;
@@ -296,7 +295,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	if (ret)
 		return ret;
 
-	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
+	err = tdx_hcall_get_quote(quote_buf, GET_QUOTE_BUF_SIZE);
 	if (err) {
 		pr_err("GetQuote hypercall failed, status:%llx\n", err);
 		return -EIO;
@@ -417,8 +416,8 @@ static int __init tdx_guest_init(void)
 	if (ret)
 		goto deinit_mr;
 
-	quote_data = alloc_quote_buf();
-	if (!quote_data) {
+	quote_buf = alloc_quote_buf();
+	if (!quote_buf) {
 		pr_err("Failed to allocate Quote buffer\n");
 		ret = -ENOMEM;
 		goto free_misc;
@@ -431,7 +430,7 @@ static int __init tdx_guest_init(void)
 	return 0;
 
 free_quote:
-	free_quote_buf(quote_data);
+	free_quote_buf(quote_buf);
 free_misc:
 	misc_deregister(&tdx_misc_dev);
 deinit_mr:
@@ -444,7 +443,7 @@ module_init(tdx_guest_init);
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

