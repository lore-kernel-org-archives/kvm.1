Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD1547FAE0;
	Wed, 29 Jul 2026 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328233; cv=fail; b=HmTgXKfI8Qn3obK2N75MpN7XmSkw3LKTKgyGkJm4UOUsPcCTPiqVITH6pgugruUVXBnCTuBetXTNhIyVoMt2J3cQJE7CmqpqpCQxZKDID6/u+CXx/ZGGtXvC1GKQJcifMdWWYOmwG6Mr6IgIk1cIDk6aJYGlnIeiovFCIV+GqyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328233; c=relaxed/simple;
	bh=RHsFqqqaRBeTWywcQQJYxeNFgqVGtV07EsRt1tjCyII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DaO3Lpf8nFISqV1/NXRDWOXRImrKm6tDPAFpQY0CS/DgEsIpDy5dt9oO1zY59DtZEvlHsEY6o3EoDVqjXFdwuElyrQULOb+5tvH5mj+xE3vmUykEpL6ORGmxAxxi/iIdNpSx9Q3jgP48W89cATYbv1TJh/+oI9bb8Zww5ykYz4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKBs/UpM; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKBs/UpM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785328229; x=1816864229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RHsFqqqaRBeTWywcQQJYxeNFgqVGtV07EsRt1tjCyII=;
  b=OKBs/UpM4nkxAkXn+Ax772xOTSrLRva6V9wW5aiTOlQEyTMGQOrol2QI
   wWqfILjIcMRSzvbckl0bWYexQp0s8/1fbPKok1d+0PSHuugwd2XgljumM
   3Kk6mXr1+pnfZXoTdZ9QQLvjWAYFVRTjE03qgvP1SMTig5xrKC5CjpssF
   DSNa3DA8OcYybqevSzDeZBUt+mSIdbrsdlAaWplXsLKl/vMLV+LPwzMNG
   oyVNf8/dy22Yb3MjzzezCjcurOJh7W8q24SrTazinM4fDfwtHd497+lex
   OzOpXtGHhXkZno0rF4jgV529EUWpibMvnARNboAHcYlhW9Wtksy6D+xCw
   w==;
X-CSE-ConnectionGUID: 78GisrqoTxiBQGD8IU/Isg==
X-CSE-MsgGUID: 1AveH48KTU2CPiW6sQAi9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="84908616"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="84908616"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 05:30:25 -0700
X-CSE-ConnectionGUID: IeuDj0aOQ5K+qvmO31FfQA==
X-CSE-MsgGUID: fbO77KWhQYqXmyZAckJ2BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="253654914"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 05:30:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 05:30:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 05:30:24 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 05:30:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBR9X7ophmL1zkwdMpUlfTRYGtLXmwAk8ty5NgV/BDJaXpR2XLJ7mDjVzt79AkuZzUYhqmGX0MvgJBiz5AvLlmKsO/l44NCJb9AzsgO2uGIhPsUt0IPrcdKRZ4KZY+A6UG1VbvEzLTemPhVu+Q31uJ0GKdv0pVJTpUzGSke7OTcKY5S2WNOOZqmx5TRquyf8PL35p2IjO1VeNWqI5ok2HYUaIPC10L+Au5N8GIvTYFg2VLBaqm5N+/z9Rn13rXGaQZfBZzSmQc6jHTUliWSzuQOwuAHTNAO2jroST3tIBLypQSp/Ku2FEpxw3ATSgWxMCCxscJVLGllYXdx3GiquVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yV3DyVSUpuKatDbmLuCDEDRHiJxrfdf3w43uOmm+qM=;
 b=BXgYSZn47vvrf7IH9jFIEb30yHKNbvKKxCcJrrhQHaftYrSyTenkJsMu6dUxw1Ef9Pu61mz7jzVI248+lmmR9TqFsww6xnHkrIv6M6hBqMieMw/OQ01dMAbbDwRzk1LajJgQ8QYIzRXBKa+HpK6QOKgPJy2VLY4uafZWdxBIBCppA9c0MN1ASF2TMYisEkLZKpZUtdb+aic7xgNR/G6/4JI3DgNnPAU5xfFgyGgRb6e7mScv8BGUF0Yik/RuoeGQgQPRN1im6AzE7NJCid3O36M9kSbasdSEZjX8uk3VpcdEInK0MDsvpgwNdb8vh9Piw27vBg8ASJXTdGx0tk/vGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by DS0PR11MB7622.namprd11.prod.outlook.com (2603:10b6:8:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 12:30:17 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 12:30:17 +0000
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
Subject: [PATCH v3 2/4] virt: tdx-guest: Calculate the Quote buffer size safely
Date: Wed, 29 Jul 2026 05:29:32 -0700
Message-ID: <20260729122939.1340412-3-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729122939.1340412-1-peter.fang@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:a03:338::34) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|DS0PR11MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 90df64e4-53dc-4a55-2f61-08deed6d2162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TDPMm9Q9rTMLIzMGsHkddy9t9rbl/CbLjV44p9bQyz34HgzeFlkLwOopNZoYD0ySpUbPmaGlPOGupAibqY7FNAI5FgwabWv+T5ZKt4oDBVEq91HM88Ao9BAK4p9n6o7oHdwB/3PdxCbu67ObEsVlhyqrWjJXo4fSru2fWkpEzjNz/R91b+1bZXC+4k5QWwOvw6p/rgvRonX5DxlnF9s8eV6F3V4IabhRJV5261diRqpx9qVapED19ywpbsHqUXN0OY4TiNsBZ1cRjLWlaxf9PWRG4nP3MY1lCNq18fTOz/N9xGH6U2YMm4cVMdBqHNrR/t+YYUipvuP5zznsG6F4IRDGv+2RaJIZrAImITrYeQjCaz3ui5YWX5FlH5zySd2f9pbfG8oSWf0jO6T+72kbVidTbPiLtBIl1QZH7eZk+TbPh7kFXUjGP1fUOjfBzT3cTxF7fB+ilY9oaTc3DSBOaZhDQmPKOhhswyWaFA/9bEzM7dOblLpBE1JRk+t+DnuRBxyg0PnKREVGeLOboHX6W6fqth4WtUvryowjQZYvEOZDpDUwh28ujv/ZIcFuDa3LsTFANBLxjK2/u7bDPcIBsvtrCmX11ehIH40Tp4P8SMM8Ahne7THxUSK035Txw86EDskKT7MWQT/Z4/GsWWHE4+nbbXouASDRNY8RjANI1ZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sr148xHwrCxxsk3Ouz7nkbw9geB/dQZIc7VKbsubYGXfTFhZsNU1BxkXTfL3?=
 =?us-ascii?Q?Hf+yr4lgoIFNlS3jesoTCuXNQ3N3U43Kgumv9bQv0GNjIAjT2TFiQQg5UUhJ?=
 =?us-ascii?Q?wls3gVuHG9VwgTtlXU/1402ySXBwnmAM+8RYzU9ybGOq96tjob8T8QxkSkFw?=
 =?us-ascii?Q?QX2IpS6/pyePf9uAaAyW8Wgum8ZHv/+sZbhp+od75B9G3ulLF8oiYUiCBeFJ?=
 =?us-ascii?Q?M5JT4OVzaVc4aX3GgxZyiIveToA8wdQP2IPIemGvnkdy0z5g4B1cZ+D6GdZe?=
 =?us-ascii?Q?IdCPN24BJ96Vd6kqPXrvpMmZfWfuUaqipIeQ4+gz79BTMAvpRwgsy6dIq2gz?=
 =?us-ascii?Q?r+i7VsAguK3YyLIQIGUej3l+3y/b2Dw6UgM8UZJ5jN3jlOB+9vjRBEg/XS42?=
 =?us-ascii?Q?QUEP06WA2Uxt1RIQrOm1uBkTC17wSUaNudcxjKCu2moLMOm7iEHz5IUUFUHY?=
 =?us-ascii?Q?bwTShsqsX1lICdzz/WWjsBJGbx/vGMi+2qeU2nRLZcYQNJnkW9J3ajZel06R?=
 =?us-ascii?Q?tTPmh0MANC0Crk6nXHZ6iIIfVCJluHN3MagqCLCHxRFYA7ueD0vuoZZ4kz/R?=
 =?us-ascii?Q?B40zJrtLJu1DBUDqE9T7OtA1EbrDUsrM7pL01UIOysP7UtePS+5riZjtc5q6?=
 =?us-ascii?Q?/R00cQl6LUQOgQZuRGLyG520/R8JDceav+kPTZWYdWr4hYhRdNlcvqFbJ84Q?=
 =?us-ascii?Q?cEHZ7jBBnf47gm6cJLVp3rOqipNRJYNQBybJvdGAiIywxYtiDigxq/k+FRR/?=
 =?us-ascii?Q?HnjdCVWJctHujq9DH4WkvIEYGzkYcnqDOlBCB0/ZQYbicirxbDyw+QxVTonj?=
 =?us-ascii?Q?eAzRouIUM9tCN0llndZX4A9GauKJI+MK/NuX2uwhuDu/xdGNFpT0MfU1ioIg?=
 =?us-ascii?Q?xfuARc8klCs26DV5gBVZww9h/L6XndG/G+JUj3c5+b1S/5YVP4Kmk/n99SnD?=
 =?us-ascii?Q?oybcEYz4HBZGFMH6+yZ/PRhwr4+Z1oHEI66MLMmAA0GdhkX8XcX6w3waCwug?=
 =?us-ascii?Q?PS4UcChKsDWiYrTnC/CNP2bNr3BGsdS6e71DuDiUO3978USXqtVwCRH25dyn?=
 =?us-ascii?Q?xTn6hFp9bL1wuJHobpOlwbLR04pcZMbE0Og4k2laOGumM6Axsh0rXxRC+rMK?=
 =?us-ascii?Q?qnRhfIe7LnmnqhlW6PKcoJOw37Fvv1qPO1WoHaR/bV7j3t+qxagin/QkNv4z?=
 =?us-ascii?Q?pBvrQgrj6aMMyKoryZ40VLDRWdURsS4wA07PPtFM+XoYw6IOoDsXRe+IyZbV?=
 =?us-ascii?Q?rVufkZCm2Ut5k1dXWGE8nQgv2vwxLDWdb1cu9rQaXbEOdd/f2YUJFi56F+6d?=
 =?us-ascii?Q?tPGCPKzq3irXS0eEBy76E5CwnrJgHAxsEK1sLPVFL+EKXdpSW/bRafDE5AR1?=
 =?us-ascii?Q?6gy/5YXgmjge/sFZtgqylkyQFeCin/hZlJFuDenfFUhxefQU3KdryGzf/JHS?=
 =?us-ascii?Q?HjowSnLm2rQRc5IUonylIwVWJMf1DTCCDFSqYWKCfXG+ci+1TJyVz64F0MMY?=
 =?us-ascii?Q?mDb4ldPLia6QtWxvwJ2z/8Vf16wVqRaknFfQImslEkAEeq0CFjVPgyTNoGWr?=
 =?us-ascii?Q?1YkMw2iUrd+3WWTkdDhsO6zJeqstR4FEtpLm0J5a7mqjG3zXy1Lc4SsDeZYx?=
 =?us-ascii?Q?g6Quuq0PEQIxhGi4RtP2DQXUBgnR5980gbHzIIHN6f7UzksDeIaSsRo9ho1t?=
 =?us-ascii?Q?XdiC+luQ3FgfaBfWZOyDivV57SHLtJeS71U6Q7NH5EbiRtUdsS4nY93kQqkB?=
 =?us-ascii?Q?RAwSnCoTgw=3D=3D?=
X-Exchange-RoutingPolicyChecked: nO6Gqd8onH5WCrYysxBihvJAQnuKKibO5qsypFGXwvRXFC8tMzJ5Tg4oB1T8iRo0pPYreAsbSdAQImbxwMqxZMjkb8SEUlJfH8WcPAAXQ88L03W687egc/945f49f2bw3uks0hgWlraKIBtzoSPToe1lhEAxeYPdb3ByjudwLjzi3nE/joJCtc3QjusSuS9zGJJTKZeMq2fCT2u6Pr1X3L4hQS8UPMPQYl5s72KDm6MSC3yxD5H9FMU/7LUTplyi/mG+qMLnn5Y4qZQu7HXGdP99Y9P3pjkJjWAkPOjPsIM+a1ZUZQJsRO2QV6AsXMm7S01P0Zm4APaniYKJNlw4+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90df64e4-53dc-4a55-2f61-08deed6d2162
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:30:10.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hu52udlYiLWGUgWkBfJrDmJ/VzwaxfR7s6OwhCe9zpjoqHeUjujhhccnB+ezAHFh91N1S8MMuYTn6OZ7he6vuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
X-OriginatorOrg: intel.com

struct tdx_quote_buf has a trailing flexible array member.
struct_size_t() calculates the size of this kind of struct safely. It
handles overflow, which is an important property since the Quote size
comes from the host.

Use it in place of the fixed length limit.

Signed-off-by: Peter Fang <peter.fang@intel.com>
---
v3:
 - Split out the use of struct_size_t() for buffer length from the v2
   "Allocate Quote buffer dynamically" patch to refactor first. [Dave]
 - Drop the Reviewed-by tags from v2 (Kiryl, Binbin) as the patch was
   reworked.
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index d0303e31e816..f47c5429d002 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -170,7 +170,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
 #define GET_QUOTE_SUCCESS		0
 #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
 
-#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
+#define TDX_QUOTE_BUF_LEN(n)		struct_size_t(struct tdx_quote_buf, data, n)
 
 /* struct tdx_quote_buf: Format of Quote request buffer.
  * @version: Quote format version, filled by TD.
@@ -315,7 +315,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 
 	out_len = READ_ONCE(quote_buf->out_len);
 
-	if (out_len > TDX_QUOTE_MAX_LEN)
+	if (TDX_QUOTE_BUF_LEN(out_len) > GET_QUOTE_BUF_SIZE)
 		return -EFBIG;
 
 	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
-- 
2.53.0

