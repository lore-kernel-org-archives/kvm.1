Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A7B4973BC;
	Mon, 28 Sep 2026 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590272; cv=fail; b=ttTxESqGMD1WlEwz4peRqPm8AKalxSdpaEV4V7XNvbpbK3HfPfwK0dsAdCBBwKXFQ1JInG4AJPU5qvitSdZd2xiWLEIkdkL9VwYxcFZaPmc9imfCkLgy2HCjNtPcXBVjMmBCRv+op5x58JCU4bfgh/tGyBD7SYIqeEVfePPqj8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590272; c=relaxed/simple;
	bh=Snvqc79QIOysA71XaGspmIglM8Lst8sQiRMXGtbalPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TpsT5kxEpEnCREGMpV8nbSu8JAsek4BOfEPARHWeKHQ/Jpk2IadY/xHv4Ax1SBAYRtsk7KzuLPtV+PwaKUR2ZdsLc2fb1/REKEJPflOyMZAuXjw75QxtEQM2mM9o+eZ83j7zPV0fp928sVkt13nagoyrGCbXbkIej0qHW1PmuBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvE90DwV; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvE90DwV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790590270; x=1822126270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Snvqc79QIOysA71XaGspmIglM8Lst8sQiRMXGtbalPY=;
  b=PvE90DwVI6lEc/IcwFHufZD698ZeWrpMy2I+2mUSiVT/YUxTzJ9P3Xis
   l5HJswr86/KYmyz4Uj0QXKCFG5mF3HN05xiwKnvgmkml0nPNn7G1F5VTX
   jRWdcV8kyD23KSL3dnZlvMZFoz+QVDOmL7swatZPXTfoblkgxAdCd7rtg
   y1+013pxw2rZyfKCkztqDVUOP+YO7KYm+3w8xCAa5UicvQXI+wNCmko9n
   8F+DH6xR87q55rtXjzX2HHUsJPqftpHFvphKYBRY8VaKzr+4g0Kt5Tn3s
   2+xt+ell4ym0+OMucWLKp6w59IC7H8c5FFG/603lLe6NAIG/FMD+rSBYM
   w==;
X-CSE-ConnectionGUID: zjHD/eghSr+A3fpw9+8bag==
X-CSE-MsgGUID: RdPEJC5uTy6p6NsJ24wCzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="91388366"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="91388366"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:11:07 -0700
X-CSE-ConnectionGUID: sJWwquQuREWt74J2IhU0yw==
X-CSE-MsgGUID: O+C4BJg6SpePVkPiN/Lxkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="279735421"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:11:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:11:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 03:11:05 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.65)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:11:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZivXgBrk0pZjteBzPzawreuRrC1F9Att9SC5smTfJ/ticydKQs94JjbFkAJu7AGhTdNWLbWJTWt8Pb+mPIeZ8qtkQzKsQmJscQJcJUMdGf2jshgIiZLMBzVTjA3QBY0jp6IjHInhfs7ofRjtoxJ8MKVNqlrMEudqWyCzcZXJMgqO7exWlziKtssurxPULgJ1Xy0CJpAIATkF8hAS1+W25wvxKrXeSMyW7esWHiG7gyTdxWEhURTEFRFFZx9gCq5Mtfw5DHDK2TDMo3AtLA3T0knvlp/JC0SnE3gP2EsuQ+ClEhq4BXPQzNxT0OGmq6gS5ehwHFU+JRyFsdie25pkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWjxxxP+d/IjNIfaRshyZicd3Esu66/bRMjmA3FPCFU=;
 b=EBWTZ32K+EUC+wz9Rc8Dvc6R5nDfRuoaTyj7Ixe/KJ3RBEUWW4mHdNUCKmmIq1cqiC/A8pu4WuSxwM3+6iJKtmnBRQMKpKgCYmxgk5hKraBWZr5SdNEsvckKW8BauKhiWMFHAIvWxz2e0zrtB+y+PIFpWvq17X1I51NpoD7ocxMxEfRunQkPEthiifvKqXPFKECy2ByR1HdMbrufP5lgPZHvCijWWKjlvmLSCex4t5uIXTMLJHKk/GsZssGA15Zx3WaFk/YJko6nitntm6uiEu9+vJ56i+Ax5vExZAgKFr4AS6bulT9xMt1HD2oIzrUbLT/c8BnKia/JV2UoXf7zRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DS6PR11MB896703.namprd11.prod.outlook.com
 (2603:10b6:8:499::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:11:02 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 10:11:02 +0000
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
Subject: [PATCH v5 4/6] virt: tdx-guest: Add a helper for the Quote buffer size
Date: Mon, 28 Sep 2026 03:08:15 -0700
Message-ID: <20260928100913.2265687-5-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3490c32d-08a5-4a09-0890-08df1d48cd34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rHuM+tMa5n2sBqbeY01tsAPl5NIINWWgjaO4mxFz1uQbrKfdCqGCHnYGw3lbe1XqRJRh5G5fBgOAYV7ZRbO/TJas625K2muuLXbPiRaHC/Xj1nuuTKTyCxQTs5JbBm5ZEaRrqkFoM6ILaUNtGagL+1bUd7P/nuUzlm67RMcAZ58IHsSE3h3Kxyd9BOTGz2x3wDTYUIm6xM8ilsvBLG7ihQHMvEZqMetX0LbLG30HX8Mntwy/vf+0gV1fOOCj8Iz5oHd9A380br2jOV9Rhhh/bn+Ctdhm+0UYWm9WHF7lDWfaaNPjCDPtM88Io7xngki0v7a1+EMLl2Lp3NKstrlsLRxPihrLFmKuRL1j0ng7HwmYYR+hHpfdrOJXabrbiQIfTqIOvlnZEBfHIY5W8JQO2gKsyAOdB02pVT9FZSzmYZrn9/JI5ECGdJy1iFOYhJi3lIXZHJekY8Msiv9aOGEi9o6vz+M9T8xSY2sjCjhHT2psp63Kxmb2qASpHV0Ga1cEI9by7fB96zJ8fhyqCpniBpshbVWJFV+bBLIG/8NfOg/EKX1IGTphbLA/zoMLtJvvXlm+HwcGBkctauv5OFsiB5DnwMzOI76Aj5+9nIgysGS+jtXN4ZGM/lp2edrVnK+YBzvcrU/gUl1UM86kJ4wI+VlYLz9utsbgtyAWPdiQl7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Qg1pDb3n9VZMibpcIh5jjYbCJ7OzcF/skVHo5CktoDHcx2pUZI4oQANg4Hr?=
 =?us-ascii?Q?xdpPzTWGYVUWNILr837OUJYJnUYr28HKq0U4yBa4dyHzY9jVIUmqw8Lha7I6?=
 =?us-ascii?Q?aCzREf9pnH/FMGN+UKKDkimVz+OV+ikVBXyNgSXPyzdBfUNlI2qwJGEuqqox?=
 =?us-ascii?Q?QuUp+/nhefg1REm+EXVCuj2L8vSoNOAa1qGDlp4Mvc9shI5dLCmNJtJVtMMK?=
 =?us-ascii?Q?faaSTF9u/iFkaXfv+lpI+H1+gfpN0mCeaL+rr4rkAIlqW6eWACgDydPmvvOk?=
 =?us-ascii?Q?nva9RbnMpgZCyGHkp/0AHJ14OH1OcK03N8MwkVllSiucpw3tCGcvWZqxtHcU?=
 =?us-ascii?Q?PBH65/PuxYOSihsQnZS+rsOOANrb5VQa7uMWwehxzxoGxkzFpD/3F0O3blMw?=
 =?us-ascii?Q?cVoZh+2kr5foAIobbMHHl4e23ICMM7AE4aQzvk/BADM/JhY2GGb51FmwDK06?=
 =?us-ascii?Q?j5xtvLrRy4Wbop4bFblNF+jnh7iYWkpJZ3UOikVHlTrUAKKA6wUZxVXPOa0j?=
 =?us-ascii?Q?iNysitPE4nisjxcfrZLdAodh95tz1c2L6AdUrfO4STPPTKBU89NpyT4LVwKT?=
 =?us-ascii?Q?PjdwZNQeEh0ViE9WRrLstd8xntjr+Xar2vkSIoi6Mo9OLQ3MpypZGuXpEJAx?=
 =?us-ascii?Q?e+Te1NGYFIbtgAcLGLMpBxZ8mt9qquc3F7xggaZmPIIOOiRKm182SKzAH+4s?=
 =?us-ascii?Q?0lpB9xThbWX/MtZ/0hjvgT5A3+xMauj0rTiTpCzQPnd77LKey8ZcauTozO3i?=
 =?us-ascii?Q?21y6oodnyOSQ57Tm6jloBdiJKREX/NOkVQv27pkGrrI0u9HvNObCnCTH68E+?=
 =?us-ascii?Q?j9CLsGQgTJlZCOPPH2BFQXBmS+eA4vovs4GsQ+1m2y4N6VNJs83gHJy21FLU?=
 =?us-ascii?Q?VN0lDFeci45X2LWnqdmdQaGu05l4XdGdIqXxvwr6/YtC1c9DOuqBcoFOJi1v?=
 =?us-ascii?Q?KetuWYbbYBNj9XofYtTetm+pvyH+eQfhaWUaVOthmgvFGpgfux2rQqoRnqGe?=
 =?us-ascii?Q?KBiipyv90X2E9MX2KnKE5E97kOtg6vGcTDH8n6TH9+gw2VSKRs7TLP5X6VcL?=
 =?us-ascii?Q?91V00YO5rDaeBpsN+maI76WfHVZC+REP1vCR5mzthxGKY8TFtsGHzphzl88l?=
 =?us-ascii?Q?mZ8mm8WqUE5ODaE2CfBNcoQOIm74rH2fNbxOSPJuMxUpoMoTEwcBMSRdAU+F?=
 =?us-ascii?Q?mbRYhyVE4bXkni2xrvsyXpVmDh61H/YSvlfUlWGDm0I8A0AbpAo7VcmcWtM8?=
 =?us-ascii?Q?0g05TM8529O0ZQy4KScIkZFUK65dXo3GY/T2vNrKI4K5zTtH5YVzgMQzzO23?=
 =?us-ascii?Q?iUzVTsawAVEz8FxECJOrSAnn0zNCBOYhuayxTe0Q4Mqhsq09mUHXUQxsSWaN?=
 =?us-ascii?Q?SrQkOxvMr1yrbHKmsCor1430N9WnXAu5VOK4AMfEouoS5zcFDn66W9AH+OBD?=
 =?us-ascii?Q?WgOT4c6AjoG4cKJvaVXTuFxUMKScCTUSd12mDHzLZmGpEqfv/yo3bCkL/tAY?=
 =?us-ascii?Q?BI5RUXYT3WuD1LMllQvNAJl5VGFkQQgVe5rROWudrrnrT7NRdbvmSdUJ1Ko1?=
 =?us-ascii?Q?MXFslo/X50ZLXWENyzL1DOm7lEzW4rkRCIhbvpilNUpnQFAIfQzO58jfYBvR?=
 =?us-ascii?Q?zA02A7JreU0bZ6hltmoiuPJ2nTjX6DqUgDarvS7c7r+qhVsuRiWyIKk65w1r?=
 =?us-ascii?Q?mrSTBpRutKX8BKVwh9fbImf7nFVphatGz0/jfr7Hlsj3JSIZxUGpyCbfMVw6?=
 =?us-ascii?Q?dTelU6PEsw=3D=3D?=
X-Exchange-RoutingPolicyChecked: z5n3mekX7rwsEcZpo4+A60IriL23Vqo/FFVG93jvwl6PbV8cOrUnr7M5nnal2WnLrpL189hNkuQCMR8zJxvjQuMSqNzGvwO2yUSvV9pWuku+NzwaI/LcXShLQoeuxqzGHO9n/3sfzjKEP8aNb7VibdZ2q08fLwoCCwmZwP7jcdFfFn6ukelnWZ61If47HUBYoSjNuxVT6wrQPdK3+fBf8Do9/2OnOji1Lp8YHJOL1o3XOhmpt/1A8Eb4uYGTNRAZ3nbxl2i0qvysL4jebT3R1daq4yYvGGXP5mERE8Rkx1SajOpgCHDELlTUBCr7h4KxZIovh+S7OwCzZSnHRchrFQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3490c32d-08a5-4a09-0890-08df1d48cd34
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:11:02.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBm366O7F0WOAes0AUg+XSTrZQxmEFg/uVMA7mkYBaf7kFgChUBRH5+rofaIz12+2LMxhhzQIx7r5/HAi1sULw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB896703
X-OriginatorOrg: intel.com

The Quote buffer size is a constant sprinkled across several places.
Read it from a helper instead. And rename the constant to avoid using a
verb.

Cache the answer in the helper, so a later change can make the size
dynamic without new plumbing.

AI was used under supervision to collect/apply feedback, review code and
workshop logs.

Signed-off-by: Peter Fang <peter.fang@intel.com>
---
v5:
 - Reworked v4 3/4 to use a helper instead of a global. [Dave, Xiaoyao]
 - Use TDX_DEFAULT_QUOTE_SIZE instead of GET_QUOTE_DEFAULT_BUF_SIZE.
   [Dave]
 - Use "size" instead of "len" for buffer size variables. [Dave]
 - Drop the RB tags, as the code changed substantially.
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 37 ++++++++++++++++++-------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index b30439584886..b79b4325da3a 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -162,7 +162,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
  * DICE-based attestation uses layered evidence that requires
  * larger Quote size (~100K).
  */
-#define GET_QUOTE_BUF_SIZE		SZ_128K
+#define TDX_DEFAULT_QUOTE_SIZE		SZ_128K
 
 #define GET_QUOTE_CMD_VER		1
 
@@ -209,26 +209,42 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
 			     USER_SOCKPTR(req->tdreport));
 }
 
+static size_t get_quote_buf_size(void)
+{
+	static size_t quote_buf_size;
+
+	if (quote_buf_size)
+		return quote_buf_size;
+
+	quote_buf_size = PAGE_ALIGN(TDX_DEFAULT_QUOTE_SIZE);
+
+	return quote_buf_size;
+}
+
 static void free_quote_buf(struct tdx_quote_buf *buf)
 {
-	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
-	unsigned int count = len >> PAGE_SHIFT;
+	size_t buf_size = get_quote_buf_size();
+	unsigned int count;
+
+	count = buf_size >> PAGE_SHIFT;
 
 	if (set_memory_encrypted((unsigned long)buf, count)) {
 		pr_err("Failed to restore encryption mask for Quote buffer, leak it\n");
 		return;
 	}
 
-	free_pages_exact(buf, len);
+	free_pages_exact(buf, buf_size);
 }
 
 static struct tdx_quote_buf *alloc_quote_buf(void)
 {
-	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
-	unsigned int count = len >> PAGE_SHIFT;
+	size_t buf_size = get_quote_buf_size();
 	struct tdx_quote_buf *buf;
+	unsigned int count;
 
-	buf = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
+	count = buf_size >> PAGE_SHIFT;
+
+	buf = alloc_pages_exact(buf_size, GFP_KERNEL | __GFP_ZERO);
 	if (!buf)
 		return NULL;
 
@@ -269,6 +285,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 {
 	u8 *buf;
 	struct tsm_report_desc *desc = &report->desc;
+	size_t quote_buf_size = get_quote_buf_size();
 	u32 out_len;
 	int ret;
 	u64 err;
@@ -284,7 +301,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	if (desc->inblob_len != TDX_REPORTDATA_LEN)
 		return -EINVAL;
 
-	memset(quote_buf, 0, GET_QUOTE_BUF_SIZE);
+	memset(quote_buf, 0, quote_buf_size);
 
 	/* Update Quote buffer header */
 	quote_buf->version = GET_QUOTE_CMD_VER;
@@ -295,7 +312,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	if (ret)
 		return ret;
 
-	err = tdx_hcall_get_quote(quote_buf, GET_QUOTE_BUF_SIZE);
+	err = tdx_hcall_get_quote(quote_buf, quote_buf_size);
 	if (err) {
 		pr_err("GetQuote hypercall failed, status:%llx\n", err);
 		return -EIO;
@@ -314,7 +331,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 
 	out_len = READ_ONCE(quote_buf->out_len);
 
-	if (TDX_QUOTE_TOTAL_SIZE(out_len) > GET_QUOTE_BUF_SIZE)
+	if (TDX_QUOTE_TOTAL_SIZE(out_len) > quote_buf_size)
 		return -EFBIG;
 
 	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
-- 
2.53.0

