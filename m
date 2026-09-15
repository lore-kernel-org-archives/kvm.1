Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D86476CF2;
	Tue, 15 Sep 2026 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464451; cv=fail; b=LCsQm221BOnJHeTS2/vKAZ7tRkWsLEG9XPMHF8wftpoys4SK25bqVlwwXBvfw0C3GUFLPbQAuedqKinqV3zUiedmIOkgpQwJx3ccv+hxq1bAXCMtFzNB4S87Wt1YYZtee1JhSS3dppK5geEjWIbOtD4r/cFikMCWZeeucYftzyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464451; c=relaxed/simple;
	bh=XBOytDDa3toUN4sbMIRuiTQrJJk5jWh8+WxKnE/0xrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgZXbZRKHtPheLhP+KrAvxvoSGFLDe3yUy2Qy/y58s1m2cXuRRRGUJaNyXYVEHqXoMr/ZD895/Tl8hV6pTC556GNln7GD6m64qgHA4u3KSyT8L6ysN+yAMFWFcLoAFPrpXkjXU41ZvxhhAQeH1qRxbO++KyW8Mcx56GzmW7sOds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bn88dGYI; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bn88dGYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789464449; x=1821000449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XBOytDDa3toUN4sbMIRuiTQrJJk5jWh8+WxKnE/0xrw=;
  b=bn88dGYIWeg7i5Ai35xtOWXImMRpZ2vKZQwUNXojwQUocgMhLS8AFk3j
   zFy3Tjb1qRSCRQHYCMyuAKEEHnSzuxDGojXtlVoHHQtNQ2HqOo6gyne4c
   R5cnYgowL8GfnXr8plnN7r172PFUR06wGQ7fTJ1TEdoE38UvUDBi+ZAOZ
   U3vvlZcW9jtEg3oywkMfs0ZKqpaDZSYn8KhTQdYlESogpsGbJPJmWEKld
   0GLmHs7UZEhIll2GJ6UhTE5zRELf4m4b8Gi8J9qeTJJTNXgVV2L/PB+O8
   ehVVHLULGZ9hE22A6V8nBE5PszIYvG3GyTjXto6ou/ldECieR5Y0epaQw
   g==;
X-CSE-ConnectionGUID: OV/qRwlZT1WhFjZVEZVrug==
X-CSE-MsgGUID: Ropi8jsFRQGcmW0QwrxDfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107333599"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107333599"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:27:29 -0700
X-CSE-ConnectionGUID: W2PBQfT6RBGpzAaFPLTWVg==
X-CSE-MsgGUID: s6QBUcvOT1Oz/0EWi09QpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277063413"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:27:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 02:27:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 02:27:28 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 02:27:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxM/0sT5dUY+ckKJdqWCMGQDO/xfyssc9eEdS73rII6NmVsq7O4RPXUESed9I8H/UXRP9yyjYkfIYuzOwbWpI9dFwe2Aaif/NBUYO6ytPis2C2Qwulw1UY4eKsq2/5xMnpnnN+o1eTvsdusN0f3pGmAo8kXoMErKI4//Icvdx4NZPOxL7O4TGpEC8bg2e59i3m3sTmUTiMVSIwTP8EYRb9CVZRnUUPAamvLsjsACQ/IEe0FXEo4rfCA1nZwn6yyRcxtWZxqo9e8WeHWZhmD0+e6UrTL8lp2d7SUw2w8hgRUKCQR6b5spIypXpNFL/ZCKiYRWVzd+dNSmnIzrRQtE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vx8qT9JroyZ3lqCR6JSQHPxFKXhK60VHDImsBdEnTU=;
 b=tlFANPMBIsApsTOAiWgiDsqGD63KZ8jLykCpc3EhSqbCoAquVEUPRaeTn2Zl7K+olAbsk2AHcqv6SWn+Ya/XWs0VfTCQ/iA8ugHV5x5o9AaFuVpVNMHVDUGCTnbYBUBr0sgSGyoAns1USV1NRa+unAEA/yFwltkqU0eRtGbxI1f+e0U4Q/4gBIw/boljb7cOJUvtGkICrvM+ke1pFaS5XQSiczsjYdq0FkZeM+zVnPztEd9tetXpmPipirKO+JxQYquQGOqTFLZDEflPJxndShhAOCNC5tvlWYX6hemmkXxVBiybwuj66H6aPJOJ/CEfB12VkiexYsqfWZA+Rw/z8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH0PR11MB4808.namprd11.prod.outlook.com
 (2603:10b6:510:39::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 09:27:23 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 09:27:23 +0000
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
Subject: [PATCH v4 2/4] virt: tdx-guest: Calculate the Quote buffer size safely
Date: Tue, 15 Sep 2026 02:26:01 -0700
Message-ID: <20260915092632.2822169-3-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6ca866e-1a16-4c87-c599-08df130b8ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mtaHQAuGc147pClPsy+coUFai96F5tYM3GMT+AXH5uH1gWNQ7HvObgEWynTB8pUg9xNkjv9dqsVO4pFGgjvrcbEg4SwZxOylk46u2o+dlSBoxDvCGdRhiee5IgWIk7KL62Zz7NaYtLmawBX0Ydeq/5+0u2MyMs7iGEEZL3Nei9QwIFpV6zwpp4E+IgcsOfBLGgvWbniFv60e4cLOJc+HVqnhSTGJxk3MFV0vB0bEXbXwpVnI8H9Lte4WUbRIKR+ywCIOatBxnvhW92s+26+xrvUXKpFDip/fRj6nHDzpvosfAFZoHW3QMa8rSwzefauBetHvTbugkKbwLZelHfpKcQ1LExv/Eu7p2tefHwqxP8easC+he9HuYF5jH+wEesnR08d9mRIZVWdtzjyOSGrawZUSgFPanTcbGmr/MvM3mtZ/O5LY9o6OGct/DE3smQDyOHOZRvKfchfTVuAYFZglamhnfKaGiNjUrxqMvOhZbBu2n2X2Kq1JhvEUT23DVcVqXemvPCE5GEy6O08k03Ehdnu7KHXDfeJce9rNFa2eHN3Shqpl197t78rOI8ZckwOhgqTVyPnhVd1FoJyS+BWBNrBNs7VjhTYRWwNXtGevHrDEBhAXDc5N73gEkOpWvKBvs19JuVkJSLKu2wr042WSo/zoWiHzR8HD4P6ymHkz8Bk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SmCQvtiyTqJaPjCGADLDruwTZ8ktae59BWnC0vgxoHTPPKW498iPoiPvP0VH?=
 =?us-ascii?Q?uUgoVCpr0staic9vJokwap8k8AV6pO/q9LE5m/nXBx5DiN+69v2OKq94j6MF?=
 =?us-ascii?Q?3pDTvprVbn+3gTpNpBnkobLKFjK3+fOGE+TwcJCs7cysCU0K1Q5P2YlO7R/x?=
 =?us-ascii?Q?TwJG9xdp+r8WgNJ/dbGLrThDjjjFiChPv5X37jHkokWhITBLC2ekNbowfXFL?=
 =?us-ascii?Q?YiHwYEt7KJK9kDc841fkrWododYUJydizsA8buspo10YXYZiVYw2C7zM22Su?=
 =?us-ascii?Q?ST0JpUJvm2/3Z5o8ZUeeJ7dCzCQ9XCrEpluz2HvEOSoJVM3olQST1+0SG/K/?=
 =?us-ascii?Q?JQlNub2tYAuoDsnObgnCBdScqEf9gUXHFJoB479qpz1w3u4e6JKqFYBBTWMs?=
 =?us-ascii?Q?JrZ8BfFgZPfj5baIx/sX2H6r/UqfJAIkHlGvX76S8L44sUW3qhU02z1ZuAw+?=
 =?us-ascii?Q?y405MxrH/FpjUMfFxRJbYmGZ9tsQcq+lTvg+KMPmg2oa/btq5IUW136gZwVY?=
 =?us-ascii?Q?Lpo1fxHVwIOuoQs+v55LESkiNykd9QkkDyW7WtwD/Gx5rPZWQ3GZO7HmRimY?=
 =?us-ascii?Q?JHnJXz4YS4FdOMyFuqvzfsvzU4w4xtT2nshPKtsPOOSYrKCOhCqIUvpXwTDO?=
 =?us-ascii?Q?XMclKzcXjSmD7+MQOgUOaUcISrosb/Ksbb3mUjGzYZeXWDw56QM+q9d4XsLG?=
 =?us-ascii?Q?zqib2kGqyMBsBw1vVobohGJDTCfxXzC3BnkFBmqqVGH0DybfpDdEetV8HnY8?=
 =?us-ascii?Q?rSlkzA2thwFqH4G6oyuTNXbUt80IRd7LYYp80irjwW6wx0XlL8YPW+OoDBIQ?=
 =?us-ascii?Q?jRCrchg5SrGlIRWgDgBjdW/0epfbntvJ+H8Nhe42Y7QZq27uJhk5cm76CFLy?=
 =?us-ascii?Q?IeEVndKzQDzsPnK6pc7EXJEqSucEYbeV5HdIN6Ta+J+fSZ3fN+atOIi5H3FW?=
 =?us-ascii?Q?hkYVTKsALb5PmWFmJTi7VhL8AZTd8tvAEa98ChCIU5xDaLOKJ0HjfS/8dbMP?=
 =?us-ascii?Q?d2NL6YidP307VGj673fPH3harZGQ/jWUPmqHWbtrkfWcbphrbtrha1uePBN0?=
 =?us-ascii?Q?oD9zGrkwd12LyKSH7t4u8G0bXnmrdSXkoj6RJfjWRTkjg0mUt2PdjiGG/bhR?=
 =?us-ascii?Q?cYzUjM/fFeS6n1atwx24yt2W2bRoVFQJ11tAPcIuEuRrK4xNlgWyajTdY5dr?=
 =?us-ascii?Q?AtAAE86WhTok4898SehIqEP9cdeFXm0y9Xwf9fy+i7eY70zVnzMUgl+ZbIX2?=
 =?us-ascii?Q?eGi4dJc4A+Wqe4zhPJX7RMLsRyokClQtIdcIAyVaeOkYRPsW25ow39+06/rW?=
 =?us-ascii?Q?IUWAnJGpHCSwJgUcOLoCHZWYLvqStPZcxBYQ0TSaTRWaLO2szQipWqv9Ld93?=
 =?us-ascii?Q?KFs1dxkxZQiWRfjzY3QAImrYwOXqSmp4Yt9ElD69TJFhbMZeJ/RzF/sWxQYO?=
 =?us-ascii?Q?DkggC/y44E/2JvCxcFrUjW7ISYni2Xcq4locgZBLjERXJsQ63Fu0DASwNpUM?=
 =?us-ascii?Q?y8fTVcSIQyYtmTxjaoxPP8cB3boYEWK4sw8kOBJbDXzvwYq+1fyyyt5dhf/H?=
 =?us-ascii?Q?dqzSBdHOhmFKRyddruQYzf8g72tCrffw0F0Yvt+RGUZCY42WSbePPHU/maaw?=
 =?us-ascii?Q?UJj/H1Fh7TaMMOaXv0zJg8pQFro23M8sJdYbOqL239nkSoNCVDd4UUGIT2tY?=
 =?us-ascii?Q?YG0wzpdFvfk5Q+aOxT2dWc5v3H/2GgAdCPvAY+W/cO0BvaI0ripH5ouOk+UP?=
 =?us-ascii?Q?dLhBuA3T4A=3D=3D?=
X-Exchange-RoutingPolicyChecked: WiHMEmDuowUAaxvA6yDoaTIWG7HxZXGrO4qDcwA9NhaWs3cSnxOaFNk7G5vhaDhz6aRx8VFIVKxfBrEI+V6JuknFq1X+3NgU6vU6IPKPY5YHl75D1OyHktc6J/8lQ6KDtcFHp91ZZ9nWeI2aj6bUIa/LmJR6jNMfmcUfVWfnOpCHXZ71wtPFwqjKtyj2lRIKcwCCF4KrYaPR/GbC8f96Uph70GziouEJeXzqHlSRLIOFh27Vv4+CnjCDbzjnSCGqYg5WH5bJAFwfpyERybrD6r6OcrgZgimLcps1XJQuHx97If4/X8nRj3GUKv7ADGyV0yH7n4kMlrkf7Hk6qNMXbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ca866e-1a16-4c87-c599-08df130b8ca2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:27:23.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5lhoGJjTM5JBJ73th4O82vm/My+Slb+TvP+uRwXlkDtSXHo/TPkdA2ZpUuum4mZt+xh/NJ4JnOWFyd6tKFSrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
X-OriginatorOrg: intel.com

struct tdx_quote_buf has a trailing flexible array member.
struct_size_t() calculates the size of this kind of struct safely. It
handles overflow, which helps since the Quote size comes from the host.

Use it to rewrite the bounds check logic, since

  "header_size + data_len > buf_size"

...is more readable than "data_len > buf_size - header_size".

Signed-off-by: Peter Fang <peter.fang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v4:
 - No code changes.
 - Add Reviewed-by tags. [Sathya, Tony, Xiaoyao, Binbin]
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

