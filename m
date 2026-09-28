Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3BF498935;
	Mon, 28 Sep 2026 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590270; cv=fail; b=MnPzYinZhLmI/x9L/yC/e1B13D98EiZw3DKWb99OfywDRs5gPCtAWbXCkUAY78RdXEo024vkDaiAT01OVdfl+2311olPLERawFXWS61D+Al9ZQuFR+XfEIvMI3BYmTXAyNNKVvQpDRz1RLCnaj8oIeJZF1w79wRLluNu9pAXBjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590270; c=relaxed/simple;
	bh=LyfRkSiirpISXHB3c1OdLlc0lyUZOnqoD/WORAFOVDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tSEoGTzjeGldtupSynxaOHWZJQir/90zRAngBHSFd1hJ9yyhCsoOGtCJcDwQJ08TgBJj118IQXK1+Jx7SRi7EGNgGdPI1qDXYlk4iYialDeAhzVGsOcRAWTZx1MI7jBdDh02NIzhfOXRJpRb/fgvsg5l8N5bdOZpt1gBAOm4aiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUJ96DZw; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUJ96DZw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790590268; x=1822126268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LyfRkSiirpISXHB3c1OdLlc0lyUZOnqoD/WORAFOVDU=;
  b=BUJ96DZwjVfysZW9c4tJMYlL3RNHX7fYSN2FDLyRfK95zlO4yyveeJcS
   MLaMSslqQvPstbuAOwlqVhC9t9k+7JWU0EOfCh7FJvE+PUVdWL5mVsILv
   U8wAPmIfHPXpm204YV/Rp9m8vDqwnSZcK3lUZ8qN4GFONBp2lgiudnZDK
   ZKV+EYWSoyyz3rckKkYK9vt1hBCA3QGXQVEatdikLUsTvKPdske0cBLf+
   GHK6AvGWVSAtDVJnbkSFRdEPn5hsOawCDBshsPbIsTl9HgVnB0GNEUkOm
   OaiHvqA4vyN2qVYliGsKUlT03Mb8wyt8O6+eurX2TdaYG81gxlhMehqv6
   A==;
X-CSE-ConnectionGUID: jE1vaLDwSyyYoz+tlUAOAw==
X-CSE-MsgGUID: ORZlHZ9HQkS6D1z60W+1Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="116814260"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="116814260"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:11:07 -0700
X-CSE-ConnectionGUID: p1YZCLInR9G9CAnF5vigWA==
X-CSE-MsgGUID: 1tFk54lGSbmXHcqyp5Oa+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278376583"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:11:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:11:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 03:11:06 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.26)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:11:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+nsM3o3TNVOB9VNidkg8EUMsVU5KUBmceCigSi+lnc9RinMrE8+GGQR2YK+HSoS9k3G7dPTHq2RxtHVRN+khEzEcGDJISwGhTZRbRMFBe3S9FtS8aPDGFZpOeF+cSoa1348mr+Idu+xfAtvkPZZqTLlGi1zkO7Vb4OkEXZt6o7ZjcyDvTAPfuZrpmL7gq4eeELIfK/mSDr227fwpdWmRyGBU11LGmYvphtvP7t4eTIWEcqk+qHNEmRg2CkBDpDoWSV4JiTRowygY/5h/JAT/rM3P3OTwzRNRmWv+l5KQH94vfHuFqd2CJJR4jPhYG8871osSGW4LaAkx5EBaNY0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhY2qY9rzJCOG+aJ/hNtv9cjDOeq+wse/1p3qyiW33A=;
 b=usZWQcqG+4CK6cKXmbvFY/H0glaGCBR+NhiAqTwiGjgtKKpKAL8YUvgX36zzcYNrA2WpbycmTv3Jv8nQrVl0yAaOiTznT2oJ8lagvuPqoiqjq8IukGYcMnSmr611mlColT4zKVs/QSH4L+KlKY8KP9zEWRwgnZJGxd5qNhK24QDhKZ5wKTrfNhauus3VNjLcsnFGUw7c/iSuVpGRmfB4PlwG872zI9ws6gv/N+LW3QFTnK8hFpOksXoEQ6oBEohvWQCflrP5CAW9fS1IgjLRmBsvygs+rYVLiuxFVPHb0t4ViD5TVrceC8SERtGGGX4eFTV+irCuxgjoRVRyvKM0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DS6PR11MB896703.namprd11.prod.outlook.com
 (2603:10b6:8:499::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:11:04 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 10:11:04 +0000
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
Subject: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Date: Mon, 28 Sep 2026 03:08:16 -0700
Message-ID: <20260928100913.2265687-6-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4fff95bd-3e9e-4f8e-1619-08df1d48ce2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lel3VLMMMGTZ6vM0WqCtngCCsQ2Hi/R/AJqK9B4aShowwhaZX5HzXYqjQ22l+IIpvHP5NghETtcVCy87kF0ndiGuhxGTR43Vi27cOXe1bFI65C0kdJ4zMGTjRIf7VCdBrv7mk6iSaEhZ84ILqWUFPytShFBdCO6VGUPRHVuQCMA/owWUP0dK8Oc5cKgSI0vNYCJHAaF1Cd+MbWC/5mIUFECeegrNxPQS2uvFf/BUwED0uXueAM1R5ywFn2b2kyYPeCTNTgc+NrbG4iF+rybypJO/+spNSZwI7WGtGPzmz7Gj1skYAXdTdIO2UeZ4Ui8f4lq3zFnYUxjb/92qXu9/Q7Pa5H8oR3GSEEc+67F+wh9z8i912ArnvVas+LX7H4Ui0LLYMf6FPrX4buFneaDjdXocgUoAH2kK6V1X6S2Pm42M0cwIdhqIHnqzHfq6UiECuA9Lp61xcx3ZlEwIprar362/xXuP5nHGJ4HdkZvS4o/aFGLOv0RPDB7f3gymVN3TTSdptjnsJzo1h/hWVbIgDpxYuAZ6I7JV26VZrIsRuhxI/QXGTD3lJ0H5ZdBMjN9s2SUocCG4A6YSfjSwWw2N5tm/9QO59T7Dr3QYnpyWeKOrV8bGo08KlOoppv9uCcqx7dTDxmVRd70mdy7kOMRoEtpOrPEOEvihiiLe1jtb6SE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e6CYtRA8QIY3+xuR0LxPuZiEO6BKLxwqGKzOvers8W7271FZW1nYVBRguMQO?=
 =?us-ascii?Q?RJ2A6zOHZyGK1rSqwHflZwMUznFpj9rOHQtPyNTbsuGBc3FKzbLlWS/OWxY8?=
 =?us-ascii?Q?JOcj3V56uDMcpFBZd8Exyr7Bg8rNsaNVB+FrOQpCXM1QH2Aa/DM+TCOMBfGy?=
 =?us-ascii?Q?rfOeXArP+iL/m5adsei5AdYO1hsXkSoRW+zZgAcTUyWX1i7uhojAR0k1Mtoa?=
 =?us-ascii?Q?Q5W0bVKOi1UReQkmr2bHaZXfhVxDVzZTa8IW6c+caBqnnmWtWKkvV61YYDzE?=
 =?us-ascii?Q?dKv2n//e0OlTjmMTeYzoMbkNldhPJWoz3V2FFpJo7HFJmH1aDHyEUCtBEUbG?=
 =?us-ascii?Q?WqI0vik0jcJzgMYmvhrN/HKCDh3OMMAWXjykVmqn0/ua7iZDbM7e8SrdAjBM?=
 =?us-ascii?Q?Cubo/IM4ru9IpEox3ajTGKYYz8ZPNVjWaOwBDsUHz9oPaJk1oXz5KGyuNgns?=
 =?us-ascii?Q?0hCggOnIJS3znEPqvTA5n0UbH1CvvfUlmmpeuVKrJZDjWt16S7S+7LgcTe0X?=
 =?us-ascii?Q?NZ4DCzpcvUCGkknYOhn+fL0JL4HiXg7LLpJKHW3sMo7llzwFv5FXe+Jg3UlK?=
 =?us-ascii?Q?ZCF2YgMV55BQdG7NX4UmVlILeCDzWsPIn2PAnR4DDNhOOprRrxRjYD63tTdn?=
 =?us-ascii?Q?kdrSuUKbJNHLR0uY0yuBRIoSa42GuksC5/LmEqOHjcpk+3HcL/A3l2ICdTiK?=
 =?us-ascii?Q?3KR9IOQ76i66qLlC4oWOxKSIuXsXApJktGACTLHyi9x6LLCHPj82AKmO1mU9?=
 =?us-ascii?Q?a0zX253pmRjiZ8jBUxwPjH30Q+4JbDd12Zrhgalq9BH5jB43qO7blupmIBhA?=
 =?us-ascii?Q?ssOQc0vPxTPXpkLrnojzKBIhRFyYsE83DQWhnglO5tommCcKQm/AKeJbtMA6?=
 =?us-ascii?Q?oC09xJ0QwWZ9s78HtmcHZoBMcfyYVFH56veE2lgFCahZ+2a7YrhlGGSpe3wI?=
 =?us-ascii?Q?PadeWmbOt0OmdXWyjXnazD6+42YWVyStD0P2ULBwfaam8MyqjrUDoejcJWHQ?=
 =?us-ascii?Q?U0hymWIf6VbVpVSGfI9PjyssKQylcaRs1zlfPN/r7fLxE8dI2EsF8uTrdB0a?=
 =?us-ascii?Q?zgrL3/RwODdl7/c6FSOCSghbjNFSTDke+sESqOpR9u/GhqqIJQToZK2dYiST?=
 =?us-ascii?Q?22NYYs77bY+kCgfwJM04gU9tAFq4aZqgDQFMbXhU4M1+uQaDhZYFmV8mUDhu?=
 =?us-ascii?Q?tsa4FiLOV4lJmzRpj0CTpn6JpPvYR5LijoMK8lCRSqCyiedYiTNXwgHQ1Kyh?=
 =?us-ascii?Q?kifBvXeOayfQ3zVUcaE/3Jk70bK4hkoB8owyAJUEV53BthxvEYEzxz0vUc3Y?=
 =?us-ascii?Q?Yyk7c0Vdd9v+68gx1mrFRbXBJ9ykLUxghbMK3e2EID8Db0ofQeUX2cEGH8iv?=
 =?us-ascii?Q?8KwIV7LmS5yn1iOH0Hu88TnOXb2ej7GN70e/EXqGcEjld/LLhoRmGhx605T2?=
 =?us-ascii?Q?xiWoMJMHT7KO3bPsinr19EMAzeCBhY7BAFuPWGyAjCYJeCkU/vfsoHxyvpUO?=
 =?us-ascii?Q?hIgEONLl4U+hqQsJLFGC9QcLlJbmjkZRYWCNqaWLxiLsQSifobjfXBXNw3ro?=
 =?us-ascii?Q?9mFjhR0bzWmmWUCsP5I6v5LVUkgCpjsCPmr+hB4tMBIeMmQX/2R15VB4+Jot?=
 =?us-ascii?Q?ARTPrgzM0XeciaY7y5FMqJaUT+VljNQhRfFNhJ+xW93crxQVNi/MqRUqFAtD?=
 =?us-ascii?Q?Ghu0WkRtv2YpEn6zRmyOOKMuKbKzR0OoQwHSJs6jgO3Aqwl0dEjATG+42/1/?=
 =?us-ascii?Q?yG7Zp1+l8g=3D=3D?=
X-Exchange-RoutingPolicyChecked: 0X8NtLwzCL8ZBjFyHWExdIhScsgCfRwpxNsylTSA44MYg7mQQTDuT8TtpEXUwrHdfLj2KFzsl6dTF9/0Io5+kCOnuOC0ZXQwmnE95lWbEBnn2yk6Mv8Bmvg9sI0fOqxtNk5QJNY+yRbexIAxc1IhycPtqWAgF2qZ0XZOsEtWNdIMDwLDLYZ2OtujHawe8RPhH8fjtUEQtJnHLh3FsyMaXuXpa8Bav16jUc45VBLPqnlooaahv4PLrE+a+aXQMuQMJukxo6qwrcSe7c9J83a/BAXZA3SdSIDQP2T3ypF8yKxHlP1VxKL+dFtptQv8OWhGCloE98mFFdv4KmN/wwL4Ww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fff95bd-3e9e-4f8e-1619-08df1d48ce2b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:11:04.4512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m36inFoI8BgdtY0u6wso3+k8nYrmIqvRDkNBfOVxIRGtgphgyVnFt295BPqGT6j/UcUV+M+nPxrgRHz8kAJ/pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB896703
X-OriginatorOrg: intel.com

TDX attestation report ("Quote") sizes can grow with newer crypto
algorithms, so guests can no longer rely on a fixed-size buffer for the
Quote.

The TDX module added a new ABI that reports the largest possible Quote
size via a metadata field [1]. Add a helper to query the size instead of
exposing tdg_vm_rd() directly, as it can read arbitrary metadata fields.

The reported size covers every Quote type the platform can produce,
including SGX-based Quotes.

Thanks to Xu Yilun for suggesting this in an off-list discussion.

AI was used under supervision to collect/apply feedback, review code and
workshop logs.

[1] Intel TDX Module ABI Definitions, August 2026, TD-scope metadata
    field "TD_QUOTE_MAX_SIZE"

Signed-off-by: Peter Fang <peter.fang@intel.com>
---
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
index bcaf4180a8db..323e1efc78ea 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -198,6 +198,22 @@ u64 tdx_hcall_get_quote(void *buf, size_t size)
 }
 EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
+/*
+ * Ask the TDX module what the largest possible Quote might be.
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
index f20e91d7ac35..6f106d4b1a58 100644
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
index a3c37d61e676..6a465827d8f9 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -83,6 +83,8 @@ int tdx_mcall_extend_rtmr(u8 index, u8 *data);
 
 u64 tdx_hcall_get_quote(void *buf, size_t size);
 
+int tdx_get_max_quote_size(u64 *max_quote_size);
+
 void __init tdx_dump_attributes(u64 td_attr);
 void __init tdx_dump_td_ctls(u64 td_ctls);
 
-- 
2.53.0

