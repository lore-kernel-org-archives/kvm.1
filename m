Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57DC377EBA;
	Wed, 30 Sep 2026 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764706; cv=fail; b=pZTNYEahM42PmXRO2BQAJ6sjRU/sSX+KphQyphjssbLip2f9RxIgibRSRAHYPWq0lM3uIEbM4ZuvZmCbuTc6l7Dq40cepFc7rchu/Ocx+ZFbAYkI7TlGyZlsOHTUs5ed6Gv0eeJHWD0xhbWCNvecEtWux8xGYTckFtPKI6zz75E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764706; c=relaxed/simple;
	bh=oardSHxrJCpOfLs7S/IaPMw1ZDAk6LDg4hU7y4Z6gOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y9y8XNhNII5Mc8G1T0flozu5VcAjfbpYn08/5FgTTedgPF6Z6xN6MGcc9drBIWRWACGPivPIfbTMHSLJ9g5co+SLT8QjYDDhayMxcTDz5kVcw1Vvv8Tz4dHoEZ+dS5DOu6O8Y2twktawI4k7mmBmaSWS6ltwxFCQHy2SxsFYWDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eB0MPKxa; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eB0MPKxa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790764702; x=1822300702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oardSHxrJCpOfLs7S/IaPMw1ZDAk6LDg4hU7y4Z6gOw=;
  b=eB0MPKxatWcw+0GRTZaeJD2/V6RNYJF+1p5Fqar+W6U9LJnTVYpsu9dl
   sWh0dz+BGE1vzcupvqeHmvSCYswlLMdHtFGPqffAOGbFi2u/bjLgq9ijG
   KDsTXwYZxxJgBQ0r0CnIoqvpQX5vGKLv4NOGgytu2QR6l138qpVgh1zS6
   //agbZJUEtuzjuy6HSXNU4yYfV4m4HJ9LpBSgZBlWqwZNa5U+xjs9P47E
   7Yd9rL//GsGywnZqU/ajoun+qJrrSFZPciYjFCeMRxXGNgFYh2NJEZq01
   uJTSfeZVo8vHSfKEZwZoCW6Nku7uWWSnT7D3a4iOVBAg3Qef0g2EhnKsZ
   w==;
X-CSE-ConnectionGUID: iEh6JCw/T/WTMtP+FGyUxg==
X-CSE-MsgGUID: AQ8bki2yQXKnd2n9Z6YQIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="107884851"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="107884851"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:38:17 -0700
X-CSE-ConnectionGUID: fvJxVj5bS+ethR22eD60+w==
X-CSE-MsgGUID: 7TAY1LdbSXGdr//rMULjSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="273445842"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:38:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 03:38:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 03:38:16 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 03:38:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iW1GSUmje5xWvx6Y9GkytaPP62iHaYaHeLE8wjKRRJNyqv3Q+XxfHAD9+aEo2UukeQlubjYhJt+vHaRK3MRBUxpUAiZAjSFmKy3HzcSAWk1wn9MvVhL8HU51McTzcTznp4b7waYITavdEQOGC+zz8/TAmnmIKcdDCtNKtO5CCkpLeSY/apAuRcdgVf82hYOOR4fin0jVVWjfLZ9dxiCPf3Vz9u+ODLU+1RZMOQgseZE+wGLq3wKEgMXrNunfXBz94u2FoRpp0VvNHfXGNuAp4PhuhSIowtuMgy3n/PDLuVk4o3fiQzaokaWjMiKqxv2VSc+G4OS+lwDxgKihnh5F2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rv5x9BUcvt/nnpcxv1Rx0IuLEHB1ERFh33j1I1BT4so=;
 b=VIO9llqNwppVWIMaFwVV2OtSQksn84uUKvt8S1tWPYxN6Uu/2KX2WzcBuiTddBrYIPmjhccoFUuymycxacoYxaMi0LZccqf7lm+PlHt49XUVG8ED/moeGQg88OMumci/gcM/+w3/uEal4NPiEnLGE5hUZbJeIZSktJSLfxufZ0YjTiM8OjOBv6B1M21OH9qpbdYH5K1mqFYfxPKRLAXgr6ESHc/F6rYPaaZtpQIoc06gkex/WTAqJRtAvJPT0YVOnv2plp9I6Xoher0eUtV4q8IxCiCCPXLTHMMVY/rpZiDz+WldgSsCI0/meSczxQXNbBQv5BRFsZEXHUUgcP0yHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CO1PR11MB5154.namprd11.prod.outlook.com
 (2603:10b6:303:99::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:38:14 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 10:38:14 +0000
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
Subject: [PATCH v6 4/6] virt: tdx-guest: Add a helper for the Quote buffer size
Date: Wed, 30 Sep 2026 03:30:53 -0700
Message-ID: <20260930103739.2851980-5-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 91e2da28-0f7e-4f26-95fa-08df1edeee3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YFI5OEUxflW0cOU5Ca45bKsCpS49UO9+xa5a1c700SXXR+MHPZkGmwmcYyYAinZFsF4rbFlVUgmLGjHMICiU/1ce9iNJMjtTFZHkofZR5o5acDHnQHnRpkcLFuHLmq2/Us8nHaBSgd3xo/DJ8cOlN8cdcYeU0/inQcOqX2bFb51rxgW5MqjzjS04n8LPije754bszO+ANjD6qEnRzpkmsjQkWSAmdL4iJWLCF7xlN3I1qcdT0D/nlQjvudOKGYP/My9TPiEekNqzuGmJiuFQg+8SQ9Zo1AO+zQD9EHOlD2nc6mViYLJhFSzbDjHE8D2y6/Oe1pWLPq5iW+9x+azBmGPjM80vn9AR/gcsd43O7b7gQ3pKFrhOKehFZhXdyvYF1XNMbjw5LE6+uBBBg3bswQCxS87+k26/NMmAg73M8C0f/81s1ka4OZgZtlX+ZvhhfZc6uwUl2VMHSXqG9riQtZmMDCU7irxcNsUJNwztnNfh6UIlDBe/RdVZ8XVyxq5pgGDkbbMf8zNYRvqwl+pCT1sxj0xXiWABR80QHoXpEsEf4jyxytK8WWI9jAEnEAVU9LmaY/8Snwi3cU9n7f6wwELq/1xLfN5A4zU2ydYWkaL5CNmyXK1yopvCtzh24ryuTwop3cgPq+Dgmz7PQWfJ0o19saArbD+b4rrreGndeKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gwhfqKz3by0A055isX6lbrh/W2E29IbEoKSoyFcpmBvmdI+WrJgLLXdRvvk9?=
 =?us-ascii?Q?DBZ2KzWPak+WUVatpsDMckr9T8AscNz62n+WSS2d/zYDCmVeg2gS02FTSzQh?=
 =?us-ascii?Q?Fq0wjeXbeVWuvbKY9ay9LxKa4mkG4VTzC7z+YlikSxlDpwYEC4OqSrJEQy2F?=
 =?us-ascii?Q?3zDTcA4xi92OwS/SS61VA+WP1koQ7kbK1Dle3BzYH3wSZ2QbAUEWvbJgEcoy?=
 =?us-ascii?Q?b/9YBFWMFr5tkrNJ7bz9+jJxNellxPnR/ZAfnzVU0aupcBI0qRj2w3NTON0F?=
 =?us-ascii?Q?7G7cMYwOac83g6m8dtyySl5bqEpz6k754hD8IdKLfC2zEJAWPRJnPy6XxC6t?=
 =?us-ascii?Q?enDOr2KgF1fnwYjMv0RufMKlZUqdgXVUdvWCAS9yKw0cOQb9exIPIrP4Gyfz?=
 =?us-ascii?Q?cqqqZcDHL6b9GeBc4PCFt+uqv/8LIfaymkzxYLmTr+TafpOs1h1MgGz8RrT8?=
 =?us-ascii?Q?fbDFBsnGqC0ifSAn0Qm4OGAJfpRgOSZ1BTvqgxCabqYO3cG+wjkEiEZHSWJm?=
 =?us-ascii?Q?J2Os4x/hcSrgvgCYx88kbdeDZXadUdbC9AvDSXE/Y70UFYr3lLi3oJ3nUHgF?=
 =?us-ascii?Q?AKbrSbFkSuet5NT955dZ6oSSZq+33wAOs1c5hw6Mq0tbHBzhiEhqkVk2UZpH?=
 =?us-ascii?Q?XtDfsOsrT0+fugoUcRvdYEYyGYnM1S7JzCG0yBvPxSLvabvOpwGQULnF+1hN?=
 =?us-ascii?Q?5aMSrDBbG6teMhs+kGkyAcGmtZL0FeDqkFu60KDbkXEt0Ji5vAFc0KMY4Cv/?=
 =?us-ascii?Q?55A897slZ2hF382zz+bgQw2vK7Lb5atbTVdkcpSms++vKrLr2g+aIQi+Ot+9?=
 =?us-ascii?Q?r1g8mfhdhgxEjoOciHYGOgPlvnjPiId5wHO0+qyEjuLeQt5yFKL999jCe2Bp?=
 =?us-ascii?Q?5xlMkC5WMlFKHrV7vA0m3q51+2N5XWTM+clfG8a4GmYMUpmUQHsEelrAwS9t?=
 =?us-ascii?Q?OBGAtTboy3VS6ZFaVp8frKJU0WDUOLXTqDPr3ELgguvk2r68k22Yl/tekYOp?=
 =?us-ascii?Q?mjpSXreUXxspOgc4KeLp869zeKggvwaWIjST/vDGW75oKHg0m68a1f5ADULQ?=
 =?us-ascii?Q?he1qdBGyGSVMB7dvusTzNSf1KSa/2MUSzBnhKfPWH6wqzNMZRcDEd3rlWeQh?=
 =?us-ascii?Q?rK7yjn42R8hmc9UQOrcThgY9wBCd80jvQ4qT6wVYeiz+QKbIPP2Y9D5wixzf?=
 =?us-ascii?Q?2Gqg4dahhbY/LlnSU+VpuNsV1zgfuie4lqfndIA90kqw0cb4YnRYsz4tPgOq?=
 =?us-ascii?Q?5ituquTdGGOIkPY/ezDoSFD0lZSq1oOJVwv/637zEMOWdWF3aXl+ctf9Tu6Y?=
 =?us-ascii?Q?JSXpkvOAMldCI+okVWqMCXu+oExW6vUBi4XZYS9lAWs9+RNl4ngrLuEjs3Qf?=
 =?us-ascii?Q?BpeChTUXvfwbKuPw8NrRDa5azL/qMSrSjf/bJvwuO/X89sQhsmRYZ0naR8e9?=
 =?us-ascii?Q?L1InpfvmBc6FIQ+sfd1Kwqlvyah2p1Yx+shHKF0BcPeiJLQ/V9UPSV/3K/Xe?=
 =?us-ascii?Q?rDLMsx24IYITBUpM4XLlxXiQguS/eWQxtrN7h+uHCSyd7D0Wa09uIaBnkvj0?=
 =?us-ascii?Q?ztJaoOawQelUFlt7Sw5JlWPhi++RYb0rIwIGv4852hlT4izDkQv/chLc4j5/?=
 =?us-ascii?Q?xI8kee5Dkz97n9vC9b2mOC4oQDsWBuBsgLE8CobF3K9rlG24LbKBlbE/4pLr?=
 =?us-ascii?Q?j+lODy1D8/76X1/4B2XNHQSpNjz48n0cVhTPqZcsCbO0hBfDMZ3D4VUZ9WMv?=
 =?us-ascii?Q?kVUMSyU/3w=3D=3D?=
X-Exchange-RoutingPolicyChecked: mOvpfjgwhzgp1qXu1FqxRXGW2NMVb18MxcMrsidTe439gkWcmeuMZ06E1JRrt8UHXJVmbDrRcOXFpiBfNdZXuiMNHSQ36GLwiK5xGloQ0vlzNA6jMIez7VVqx7cFQsQEFVgN5BvSZDYaPTTMMKqoWCwXy7Y0VlsRFl9NqSDtztIMPEyIxHQFlI6oTaIUr38atjg9n8Rg+t7U8i6rcdplq4394IwwtRON6BvYd6ZFurWTTnNevWKbwN+5JI9bGzVciJ2yrWKlHxonifGE4W0wPLccsn5n/xBqFDk8smKn8sih0kzPuYR79YE8Ycrg+f4AvZriiHGkBEtklN1RpYXthQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e2da28-0f7e-4f26-95fa-08df1edeee3e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:38:13.9255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tGzcZMnUfkTK4MFYDPxiCw23GkpTo/GU3janrkL8ICOq/UdbxB7bW26pMeAfdR7ouhhsVbgtHsq8vYUzbZqtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
X-OriginatorOrg: intel.com

The Quote buffer size is a constant sprinkled across several places.
Read it from a helper instead. And rename the constant to avoid using a
verb.

This sets up the plumbing for a later change that makes the size
dynamic.

There are several "sizes" at play here: the raw Quote data, the Quote
buffer (the header metadata plus the raw data), and the allocation (the
page-padded Quote buffer). The helper returns the Quote buffer size and
leaves page alignment to callers that need it.

AI was used under supervision to collect/apply feedback, review code and
workshop logs.

Signed-off-by: Peter Fang <peter.fang@intel.com>
---
v6:
 - Don't cache the size in the helper. [Rick]
 - Let the callers page-align the buffer size. [Rick]
 - Add a comment for the helper. [Dave]
v5:
 - Reworked v4 3/4 to use a helper instead of a global. [Dave, Xiaoyao]
 - Use TDX_DEFAULT_QUOTE_SIZE instead of GET_QUOTE_DEFAULT_BUF_SIZE.
   [Dave]
 - Use "size" instead of "len" for buffer size variables. [Dave]
 - Drop the RB tags, as the code changed substantially.
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 31 +++++++++++++++++--------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 77c63c3f820f..0cf078f09a73 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -162,7 +162,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
  * DICE-based attestation uses layered evidence that requires
  * larger Quote size (~100K).
  */
-#define GET_QUOTE_BUF_SIZE		SZ_128K
+#define TDX_DEFAULT_QUOTE_SIZE		SZ_128K
 
 #define GET_QUOTE_CMD_VER		1
 
@@ -206,26 +206,36 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
 			     USER_SOCKPTR(req->tdreport));
 }
 
+/* Size of the header metadata plus the largest possible raw Quote. */
+static size_t get_quote_buf_size(void)
+{
+	return TDX_DEFAULT_QUOTE_SIZE;
+}
+
 static void free_quote_buf(struct tdx_quote_buf *buf)
 {
-	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
-	unsigned int count = len >> PAGE_SHIFT;
+	size_t alloc_size = PAGE_ALIGN(get_quote_buf_size());
+	unsigned int count;
+
+	count = alloc_size >> PAGE_SHIFT;
 
 	if (set_memory_encrypted((unsigned long)buf, count)) {
 		pr_err("Failed to restore encryption mask for Quote buffer, leak it\n");
 		return;
 	}
 
-	free_pages_exact(buf, len);
+	free_pages_exact(buf, alloc_size);
 }
 
 static struct tdx_quote_buf *alloc_quote_buf(void)
 {
-	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
-	unsigned int count = len >> PAGE_SHIFT;
+	size_t alloc_size = PAGE_ALIGN(get_quote_buf_size());
 	struct tdx_quote_buf *buf;
+	unsigned int count;
 
-	buf = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
+	count = alloc_size >> PAGE_SHIFT;
+
+	buf = alloc_pages_exact(alloc_size, GFP_KERNEL | __GFP_ZERO);
 	if (!buf)
 		return NULL;
 
@@ -266,6 +276,7 @@ static int tdx_report_new_locked(struct tsm_report *report)
 {
 	u8 *buf;
 	struct tsm_report_desc *desc = &report->desc;
+	size_t quote_buf_size = get_quote_buf_size();
 	u32 out_len;
 	int ret;
 	u64 err;
@@ -281,7 +292,7 @@ static int tdx_report_new_locked(struct tsm_report *report)
 	if (desc->inblob_len != TDX_REPORTDATA_LEN)
 		return -EINVAL;
 
-	memset(quote_buf, 0, GET_QUOTE_BUF_SIZE);
+	memset(quote_buf, 0, quote_buf_size);
 
 	/* Update Quote buffer header */
 	quote_buf->version = GET_QUOTE_CMD_VER;
@@ -292,7 +303,7 @@ static int tdx_report_new_locked(struct tsm_report *report)
 	if (ret)
 		return ret;
 
-	err = tdx_hcall_get_quote(quote_buf, GET_QUOTE_BUF_SIZE);
+	err = tdx_hcall_get_quote(quote_buf, PAGE_ALIGN(quote_buf_size));
 	if (err) {
 		pr_err("GetQuote hypercall failed, status:%llx\n", err);
 		return -EIO;
@@ -311,7 +322,7 @@ static int tdx_report_new_locked(struct tsm_report *report)
 
 	out_len = READ_ONCE(quote_buf->out_len);
 
-	if (struct_size(quote_buf, data, out_len) > GET_QUOTE_BUF_SIZE)
+	if (struct_size(quote_buf, data, out_len) > quote_buf_size)
 		return -EFBIG;
 
 	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
-- 
2.53.0

