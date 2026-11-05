Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793893119;
	b=Hh+XE1zVc9gFOA0rzF26s3FFZRb1Qz9/bxSF2tS8zRRg/zylEimeK0Z+U+i3Kz2rG2Si
	 +OzCu5uXNbUkFur2h3mM+3H9BEs/1LewcHIh+Ra9dULFJOigU+dUgqzYwM2KWbtjZezOT
	 ORoIfT+DCvSOE8q7GsRxdGcMeWBSZm1GmMB4HJvY3DAT8AwyP3mJ3EC5kZYBlPrCniN38
	 aktvk6w5jvgt6aWtMbEOUXqHEnBSaeLV//Nq4wB/PMmj9QgUXmhy5n7LluPq0khHjLS+U
	 6fADDgcDy2oYeMTCR05VyZNxvM18Uds22xdxr3B2uocNuLhXt32tywSAUn/TpqvimtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893119;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=ZsCwJWwYO+DYo37Szkjnuc5tz/l+TRyTs4C1udqAKtA=;
	b=40gIvphXp2dgG6XwqLFLLMUNXNPKTtsIGfx7gB1VuTYxGm3VgcRjeqdeRj7l2LQKs8QO
	 0UZNQ9JD8FXf/rzILmLbL5Z6bYAAU6sISVMdyd9s6PmTga53lVl8tr5Mv9f3VCKgAtZ7C
	 xdGqmosl/PBrAe5z9DoNrS16kpVKJ8x4l2Tl1MhM2h3fU1B6pnms0vGP6G+VfarmFCkqz
	 a9Z7O3BR5y5SWSkGum0A7PNq7ivm1N+/iQfQIBp2ypGsI1jpnD8xn90ATPZnQkkWdC1R2
	 3PRwlnH3UyzQI9xW0uCUBbDzqON51mLCWANm+kLmAD2MPbLF8uz5glLNvwrEpguKVTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="a/v6iXsL";
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2077606A32F
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 15:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2077606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a/v6iXsL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793893116; x=1825429116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+7VfYbAiRANjA0HzgQO3ojRBB2hJ5RkcM/5K/CBxlRM=;
  b=a/v6iXsLzyHCcCNO7MRbl+oJRKsTpY779zeZIbWy0Klbc2nVmRdVoaeo
   jjyZmzKnCT+H2b0Rwk6FXnMtyj7SS3NBZQh201QHlS8WBzZGT7VQycJ1G
   RrBZ6wz2s2lqNzrxsIBNkfT4Tyb1T1D2qtXka1TXnWhsdHhMnGkSXC6zh
   slNb0yrVZVLh4H8jpTMpwrvUK/wdnP7wZL8Mq8Rc+tOqysGELUbAapJVo
   JIYPEFHtfGmsUrwe9Qux3/r5JALe2vWdGLZ59hZuH2SOqh6RlFxgx1lNm
   grPliaSC2UevbaSVrIa+PtcY8VQYfQQmmr1oiBO1lwKehaMf2RdihLJRz
   g==;
X-CSE-ConnectionGUID: Wgl1iNKcR+WJlUv75WWNjQ==
X-CSE-MsgGUID: 3WIIPLlBS9K8UTG3nJsOmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2587840"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2587840"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:38:35 -0800
X-CSE-ConnectionGUID: drIMMmDyTPeIvdRxQ1SA4Q==
X-CSE-MsgGUID: Um2yL+QNQU+yd/UVwITbQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6870259"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:38:36 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:38:34 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 07:38:34 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.67)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:38:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLdNS5eZRgIkqrRQwlzaeXBmc0Q0GzR68yVuZ/uX3i/hHJj+xk6fGicE1rfjpbRIQ4x4Sf/vfPcqs3I7ENmYIzfMYWskTeSXK24H7UxB4SQ7H0hA+vrlSHlYkSMgF67F30hyE2L8udBUNC35AfhpVu0JLhlSgKDq6AdDzIaO7Nhqpu0/rJVHPeO5edaSXfnbH8Y1VJcBnYe4OHwr7/5+Fgz9bc4yx4KgkKZ/Gf4rNvWZeTcFb7edwaZnZWRxZwIhWWwarJQXxBKzC1yWvq4oabELaL4zNEPaSuCeyueEMUBohrDUyh+SpGGoJxcBm13mD/nHpu86XbKfGavnOsIytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsCwJWwYO+DYo37Szkjnuc5tz/l+TRyTs4C1udqAKtA=;
 b=yPQPODnkRcs97mIC34SJhmtw/DcJPMRpxQO3bScZsvEE3fxwbOLWiGAFcm8FYOiwBjAzOcInaN/WmtmAvb+O4aG7u8AFMzJrllIeBtyKyxaEbKeUl/IMmIu4JzfJ/40UhZMJp7PJ2/mPdB55dYBhl98trK1mozFPUd1uSFQvzJeOzusApUjLPDBSL++fsB+Zx0rgymFfWBrkMFciAM/DMdEcf5HOldRL1MmwGxeuFENiwL7dcshnW7L+CKapRoHE80h/xkOZkj9mFdwv1qkORuEmQsTBhDeA7D/2aRjNXzpKXYQXarizj2V6/V+mtvD71vLyET9i179Z9oEe3wbobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8039.namprd11.prod.outlook.com (2603:10b6:510:25f::18)
 by DS4PPFDB7809488.namprd11.prod.outlook.com (2603:10b6:f:fc02::56) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:38:01 +0000
Received: from PH8PR11MB8039.namprd11.prod.outlook.com
 ([fe80::42df:f465:90a8:df92]) by PH8PR11MB8039.namprd11.prod.outlook.com
 ([fe80::42df:f465:90a8:df92%3]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 15:38:01 +0000
From: =?UTF-8?q?Pi=C3=B3rkowski=2C=20Piotr?= <piotr.piorkowski@intel.com>
To: <alex@shazbot.org>, <kvm@vger.kernel.org>
CC: <intel-xe@lists.freedesktop.org>, =?UTF-8?q?Piotr=20Pi=C3=B3rkowski?=
	<piotr.piorkowski@intel.com>
Subject: [RFC PATCH 2/4] vfio/pci: Allow hiding BAR ranges from the VFIO user
Date: Thu, 5 Nov 2026 16:37:36 +0100
Message-ID: <20261105153738.1938345-3-piotr.piorkowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105153738.1938345-1-piotr.piorkowski@intel.com>
References: <20261105153738.1938345-1-piotr.piorkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::18) To PH8PR11MB8039.namprd11.prod.outlook.com
 (2603:10b6:510:25f::18)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8039:EE_|DS4PPFDB7809488:EE_
X-MS-Office365-Filtering-Correlation-Id: c9277e83-ed6e-44d8-1352-08df3b52c628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|8126099003|10067099003|18002099003|6133799003|22082099003|56012099006|5023799004|11063799006|261022075727099003|261026121527099003|261102130727099003|261022105027099003|261026140227099003|261028144727099003|261102123227099003|261022113327099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 6i533fB4xX+6uDKHPGqCvQUxgw6kwEdNWi2BjHL9i45DW+PsR83q23RqMHqPBwC5pZ3CcKS0WRoresmYLPOT0DvLamITCqaJBSEE30LohJpC1Wv03R6YbNXMeTqW9sBLkD3uXYnbwg3r+4TON4rKqHIuZwTKqS5HwTFWb/ZS9YKpNdG5iCKpNWkwW+gcuSXv+Z+ju/oYtCBgERbUzfGvxe1VYZmT2acrp0HX4V8YE0y3aktPW6Kp6xHGrUxMCZxzOruKuUscnopzQvbLaqAhqHEO/G9psx8/xRHFtd5AO95lYiH6QoSMY2exFZeNSZY7YGjBYH1NpQd6AsDakWb3KFYFNPk9VNSs29KJG3s4IDS1YGCbQvO2iaiCvWrn48k2h43468p02Gw5bB//ZJ2rKHtsUzE4oMDtADELuOmshcB2iSnjdd/qLrkyV7i8qKcravUe9Go2Mqwxd4k0KI/drsGLwNzXW2+UFVIpuo7qLyipfUg3bJ7CBzZcxNBNQOVS5mGRFJT5HtcYhNtTKB8WenvJbOGo2XPJQ+sHpxuBRBw5h0uOL0kar+M6K4+Yhbq8p63bw2l9wG2jZaKkGtqZPaeA3yANY9rHyTpVe+AUF8r3XfE3gOXZ88IOCj/LTt40w9431nASWE34a4i3b/77gwEqnG2T5fshEWQdIAb/PSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(8126099003)(10067099003)(18002099003)(6133799003)(22082099003)(56012099006)(5023799004)(11063799006)(261022075727099003)(261026121527099003)(261102130727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022113327099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUhJQ2krV3dKWHUxMTU5UFBBVGkwMWNqWStTRDR3UXUzS0dPekgyRmYydTdx?=
 =?utf-8?B?QkRwNGR4bjVWamxEeVdJakNyR0Y5RThXcDhxLzFnS3NDZUpOZFQva1ZTalBl?=
 =?utf-8?B?czh1ZzZxNzVndHVmc2p1TWNqOGFpY3loelBtNnJOYS9yZUpTcXJtRmExeG9I?=
 =?utf-8?B?Z1JlMjZlZE9FQTEzT0ZFaVBGa29VNDRPMG5kaUdNQ1ZUQVdzd1R3T3ZIdTNX?=
 =?utf-8?B?dXgyR0l3NE00Z29weTAwcTNvR3FnL3MwMTQ4QUxSbjBzemlJRnY5Q2hQTEts?=
 =?utf-8?B?QVF1VVNBLzZGQStVSklvTEhpK2NlcUtGakFPSkp2STUxcmFMeFd0ZVk0Q2Zh?=
 =?utf-8?B?OVR3eVQwZnJXWEpTcHBoV29DQjByYi83TWZhSy96TFBkOW4wUmFDUkF4TlNa?=
 =?utf-8?B?NVhOVXJhdFhJOUNvZUN6NkJaRXMramFmSlBjZTRLY2djYXpOdFJ4NGN5Uk9l?=
 =?utf-8?B?elgxcFZDYUtQc3gwR1U4SUpERHJ5Mzc3K3lzOXFJVVBjNklNSFphekhzYnhx?=
 =?utf-8?B?b3VxODllZ2hQN1dUeU1MN0I0RjFPSjl0TUh0OWJzYmxJaDM4MlA4bGJFSVln?=
 =?utf-8?B?OE01LzA0UkoxS1pGK3RSM2JRNEpobTNpNVhjYW1XeXBFelZFZW50RW9rL0FZ?=
 =?utf-8?B?cDM5WUl3aitYZFBmZXQwekNPUmZ6TjFrTWc5aGxaM0Zjb3FuQ3NXUFUxaEwy?=
 =?utf-8?B?OElmdWIwaCsrYUl2MmNlSkVnZmRhUW00d2Mvb2VJSDdMd3Ird0F3MGZsSENw?=
 =?utf-8?B?Z1lId3g2M0svVHlvWUZqWkRvYk8xSkV5U3QwM3FSVk5oeGlQZWIzRVlQUTRZ?=
 =?utf-8?B?MlBCYlFqSVdTME5FUWN2Uks4cllXd0dYRkIvRVhiQmhWdU1MTHNFeE9mcTlG?=
 =?utf-8?B?M1J6c0dacHF1L3JnUkxLbnV3QXN3ZWx0NGpJbFVUejhHZml2eGhqUWpXRkI2?=
 =?utf-8?B?Vm55eU9paWgzcTF4TGhCRGY3MFNwMHRoNzJNUHF3SEJBUHRka0FNbUFuUC9D?=
 =?utf-8?B?OFVKdmxlVDQ3NWZOTndNa2JTMTZ0NzArUmRqUnhUNVc3VThBRi9yNGRvU0FR?=
 =?utf-8?B?QUR1UTkveVRsYmZZbUhEUTYyUXBqRS9oMjZHUkI1WlBpeHgxMU9jY2Y2dTg2?=
 =?utf-8?B?TVc3TzBTaVlQU0tuS01PcWlCb29HdmxqOFZQbmhaMWF3Vk5xNmZLWlVHTlNi?=
 =?utf-8?B?TGp5bGtLVUhadXp0ZmlhbFphUWsvZlNCL1pJNWZXMGZoV1BxdWVrY0p2cTQv?=
 =?utf-8?B?SVpRZjRBTkxmZHAxYXpQaUdDVVhJRmVoRERuaTd4ck5PQ2pjbit5OXdXRWdk?=
 =?utf-8?B?NG1URU1RU0tzZCt6eEJCdmQwS2ZHMkpybGJrcm5UTnArcUlwa0xRMjFMb1Jl?=
 =?utf-8?B?RU5CRTNMaVJTb2ZHK3AxbzdyZXU3YTVZN054b1I5NE5NR3IwQUJoaytTZFlN?=
 =?utf-8?B?cjhDdjBxMWRXL3JMZExoMU11VWx5dE9FUEV5cWV5UTFRUFJSK3JKa0J6bDh4?=
 =?utf-8?B?TUpZNjZMZFdZekhJN1VxTVVZd0xMcDArV1h4Z3VFTjlNcGh4V3hvajVyZlBW?=
 =?utf-8?B?ZmRudzcyQlMxeW8vZkkva0p1aWRqUiswTDNBd0RDTS9NeDJTODV4MWNsaFR6?=
 =?utf-8?B?aUgveExIN0tDQlFOZjZiMnJoalB2eFhUeVlSazBBaUpKYWV6ZlZDZklzVW8r?=
 =?utf-8?B?eGpCNEpoTmtDTTVBTGU5aWoyR3M5ZmEzTi9mUUxlZjNMd3EwT04wMVNTQmlx?=
 =?utf-8?B?ZVpIdE4vZG5YM0RCbDZvMlcvWTlOb2tSZkVDN0FyeWlHV3VycWRGYmFESllx?=
 =?utf-8?B?eitFODZ6UEJXS1N3NUdwLzIvbXlLaUYzTTdNSmhsOSsrTDlXcWJjTXBTa1c4?=
 =?utf-8?B?R25WSTZ1N3FyV1Z2WDBZblBLa2ZqQUFmV0VpSzJFRzJ4V0dXT3VIcDZKaGky?=
 =?utf-8?B?a3FJc1FNWFpqZWtDMklJcUNUSk1GRTBKalAzUU94czlwcWlHbXZQZWJOaGJW?=
 =?utf-8?B?TFowaXNCZU9ESFQyT3ZySFduK2VNL3ltZlBEY0JKVlNMMDZjY2lxQ0doN3Br?=
 =?utf-8?B?M1habUNjMDh6cG1KR05vVC9RbjZWcTdzSlFZMm45UWM5Wkp5VG5tTEJwekl5?=
 =?utf-8?B?OWcwakhYcUc3TzcvKys4Wm5lQ3YyQ3puUTNjWGlYTy9ZSSthVS9xemdnNjFI?=
 =?utf-8?B?QmtoT1ZZK1ZJb3ZDN0FhVFJ0SlNubzlFZnBLc2pCd3diVmRoZm1SbmZSM1Bu?=
 =?utf-8?B?OG03U1FNaVQvdlZ5YlVMUkJTZ2VXN0xLM29mVjVTNzdGSnJYSnN0M1lpejg5?=
 =?utf-8?B?elB4Zm5hbjBUcm84Vnp6V24wcVZPMTA2bVdMcEFJMkc1K3hIT0xXWWZVYzFv?=
 =?utf-8?Q?W3to+sPqaQWotMuE=3D?=
X-Exchange-RoutingPolicyChecked: r6wvav1QGCEYEBj+ecjBN/3ipeDej+AFS7stSxfaJfsE5gaxHhMn9VBYC2vFGeBoRTK09A/RDgeJEtQOEimPweX/bSiW30bjdnTHg/dSbNPR6ovkcsgdxzbvUgTTNI9YPltgS22CBj6jg5EfZVr+QriG/huTSeqB5RIujFrgAHbcAFMCGM4FDoggwVQE4Ub91Xbed3v9r4NcX1M8YO7ULkC8soQhiorjb3GfNrzoaAwOp8Ja3hnY1tyOh+erRpGiODvkMx/NS5o4GuNFlvl/YG3RGifvc9zE2sHSbo3paaNkR5tv2nHMya5anPANcQVyZRLngxygCFoNiepEtDfdsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9277e83-ed6e-44d8-1352-08df3b52c628
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:38:00.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XidNAKl0Fa4gQ4wmKiAZMJq7ypX8ZGO5VFJzb2vqKICmXLLw2XDZLdW3vbUtTv4FDiE9IrtYtGJOsOsT63oZZtKXut10IHf3VyG6igCZJCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDB7809488
X-OriginatorOrg: intel.com

From: Piotr Piórkowski <piotr.piorkowski@intel.com>

Some devices have BAR ranges which shouldn't be exposed to the VFIO
user, but the only part of a BAR vfio-pci can keep out of reach is the
MSI-X table.

Add vfio_pci_core_hide_bar_ranges(), so that a driver can hide parts of
its memory BARs. Reads of a hidden range return all ones, writes to it
are dropped, its pages are never mmapped, and ioeventfds and dma-bufs
covering it are refused. The hidden ranges are listed in sysfs.

This only works if all the BAR accesses go through vfio-pci-core, so
the driver has to opt in by setting hidden_ranges_supported.

Cc: Alex Williamson <alex@shazbot.org>
Signed-off-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
---
 .../ABI/testing/sysfs-devices-vfio-dev        |  13 +
 drivers/vfio/pci/Makefile                     |   3 +-
 drivers/vfio/pci/vfio_pci_core.c              |  22 +-
 drivers/vfio/pci/vfio_pci_dmabuf.c            |  11 +
 drivers/vfio/pci/vfio_pci_hidden_bar_ranges.c | 289 ++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h              |  17 ++
 drivers/vfio/pci/vfio_pci_rdwr.c              |  80 ++++-
 include/linux/vfio_pci_core.h                 |  29 ++
 8 files changed, 447 insertions(+), 17 deletions(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_hidden_bar_ranges.c

diff --git a/Documentation/ABI/testing/sysfs-devices-vfio-dev b/Documentation/ABI/testing/sysfs-devices-vfio-dev
index e21424fd96662..e689dd206b71e 100644
--- a/Documentation/ABI/testing/sysfs-devices-vfio-dev
+++ b/Documentation/ABI/testing/sysfs-devices-vfio-dev
@@ -6,3 +6,16 @@ Description:
 		 vfio driver. The layout under this directory matches what
 		 exists for a standard 'struct device'. 'X' is a unique
 		 index marking this device in vfio.
+
+What:		/sys/.../<device>/vfio-dev/vfioX/hidden_bar_ranges
+Date:		November 2026
+Contact:	kvm@vger.kernel.org
+Description:
+		(RO) Lists the ranges of the memory BARs hidden from the VFIO
+		user, one per line as "<bar>:<offset>:<size>", where <bar> is
+		the decimal BAR index and <offset> and <size> are hexadecimal
+		values prefixed with 0x. Reads of a hidden range return all
+		ones, writes to it are dropped and the pages containing it
+		can't be mapped. Empty if no range is hidden. The list is set
+		up when the device is bound to the VFIO driver and doesn't
+		change while it stays bound.
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 6138f1bf241df..be3bf15505c3b 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
+vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o \
+		   vfio_pci_hidden_bar_ranges.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da860e2a..cd6cb3d829b51 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1147,6 +1147,10 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 				if (ret)
 					return ret;
 			}
+
+			ret = vfio_pci_hidden_add_sparse_mmap(vdev, info, caps);
+			if (ret)
+				return ret;
 		}
 
 		break;
@@ -1771,11 +1775,20 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 	unsigned long addr = vmf->address & ~((PAGE_SIZE << order) - 1);
 	unsigned long pgoff = linear_page_delta(vma, addr);
 	unsigned long pfn = vma_to_pfn(vma) + pgoff;
+	unsigned int index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
+	u64 bar_pgoff = (vma->vm_pgoff &
+			 ((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1)) + pgoff;
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 
 	if (is_aligned_for_order(vma, addr, pfn, order)) {
-		scoped_guard(rwsem_read, &vdev->memory_lock)
-			ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
+		if (vfio_pci_bar_range_hidden(vdev, index, bar_pgoff << PAGE_SHIFT,
+					      PAGE_SIZE << order)) {
+			if (!order)
+				ret = VM_FAULT_SIGBUS;
+		} else {
+			scoped_guard(rwsem_read, &vdev->memory_lock)
+				ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
+		}
 	}
 
 	dev_dbg_ratelimited(&vdev->pdev->dev,
@@ -2279,10 +2292,15 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	if (!vdev->disable_idle_d3)
 		pm_runtime_put(dev);
 
+	vdev->vdev.device.groups = vfio_pci_hidden_bar_ranges_groups;
 	ret = vfio_register_group_dev(&vdev->vdev);
 	if (ret)
 		goto out_power;
 
+	if (vdev->num_hidden_ranges)
+		pci_dbg(pdev, "Hiding %u BAR range(s) from the VFIO user\n",
+			vdev->num_hidden_ranges);
+
 	vfio_pci_core_debugfs_init(vdev);
 
 	return 0;
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d68..409b327926478 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -227,6 +227,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct vfio_pci_dma_buf *priv;
 	size_t length;
+	u32 i;
 	int ret;
 
 	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
@@ -260,6 +261,16 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	if (ret)
 		goto err_free_ranges;
 
+	/* the importers access the BAR directly, bypassing the hidden ranges */
+	for (i = 0; i < get_dma_buf.nr_ranges; i++) {
+		if (vfio_pci_bar_range_hidden(vdev, get_dma_buf.region_index,
+					      dma_ranges[i].offset,
+					      dma_ranges[i].length)) {
+			ret = -EINVAL;
+			goto err_free_ranges;
+		}
+	}
+
 	priv = kzalloc_obj(*priv);
 	if (!priv) {
 		ret = -ENOMEM;
diff --git a/drivers/vfio/pci/vfio_pci_hidden_bar_ranges.c b/drivers/vfio/pci/vfio_pci_hidden_bar_ranges.c
new file mode 100644
index 0000000000000..666820dc24080
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_hidden_bar_ranges.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VFIO PCI BAR ranges hidden from the VFIO user
+ *
+ * Some devices expose registers that must stay under control of the host,
+ * e.g. device management registers, in the same BAR as the functional ones.
+ * The ranges of such registers can be hidden from the VFIO user: region
+ * reads of them are filled with ones and writes to them are dropped, the
+ * pages containing them are never mapped, and neither ioeventfds nor
+ * dma-bufs may cover them.
+ */
+
+#include <linux/device.h>
+#include <linux/mm.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/vfio.h>
+
+#include "vfio_pci_priv.h"
+
+static bool vfio_pci_bar_ranges_overlap(const struct vfio_pci_bar_range *range,
+					unsigned int bar, u64 offset, u64 size)
+{
+	return range->bar == bar && offset < range->offset + range->size &&
+	       range->offset < offset + size;
+}
+
+bool __vfio_pci_bar_range_hidden(struct vfio_pci_core_device *vdev,
+				 unsigned int bar, u64 offset, u64 size)
+{
+	unsigned int i;
+
+	/* treat an overflowing range as hidden, the callers clamp it if needed */
+	if (size > U64_MAX - offset)
+		return true;
+
+	for (i = 0; i < vdev->num_hidden_ranges; i++) {
+		if (vfio_pci_bar_ranges_overlap(&vdev->hidden_ranges[i], bar,
+						offset, size))
+			return true;
+	}
+
+	return false;
+}
+
+static int vfio_pci_check_bar_range(const struct vfio_pci_bar_range *range)
+{
+	if (range->bar >= PCI_STD_NUM_BARS || !range->size ||
+	    range->size > U64_MAX - range->offset)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int vfio_pci_add_bar_range(struct vfio_pci_bar_range *ranges,
+				  unsigned int *num,
+				  const struct vfio_pci_bar_range *range)
+{
+	unsigned int i;
+	int ret;
+
+	ret = vfio_pci_check_bar_range(range);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < *num; i++) {
+		if (vfio_pci_bar_ranges_overlap(&ranges[i], range->bar,
+						range->offset, range->size))
+			return -EEXIST;
+	}
+
+	if (*num == VFIO_PCI_MAX_HIDDEN_BAR_RANGES)
+		return -ENOSPC;
+
+	for (i = *num; i > 0; i--) {
+		if (ranges[i - 1].bar < range->bar ||
+		    (ranges[i - 1].bar == range->bar &&
+		     ranges[i - 1].offset < range->offset))
+			break;
+
+		ranges[i] = ranges[i - 1];
+	}
+
+	ranges[i] = *range;
+	(*num)++;
+
+	return 0;
+}
+
+static void vfio_pci_remove_bar_range(struct vfio_pci_bar_range *ranges,
+				      unsigned int *num, unsigned int i)
+{
+	memmove(&ranges[i], &ranges[i + 1], (*num - i - 1) * sizeof(*ranges));
+	(*num)--;
+}
+
+static ssize_t vfio_pci_show_bar_ranges(const struct vfio_pci_bar_range *ranges,
+					unsigned int num, char *buf)
+{
+	unsigned int i;
+	ssize_t len = 0;
+
+	for (i = 0; i < num; i++)
+		len += sysfs_emit_at(buf, len, "%u:%#llx:%#llx\n", ranges[i].bar,
+				     ranges[i].offset, ranges[i].size);
+
+	return len;
+}
+
+static int vfio_pci_hide_bar_range(struct vfio_pci_core_device *vdev,
+				   const struct vfio_pci_bar_range *range)
+{
+	struct vfio_pci_bar_range merged = *range;
+	struct pci_dev *pdev = vdev->pdev;
+	unsigned int i = 0;
+	int ret;
+
+	ret = vfio_pci_check_bar_range(range);
+	if (ret)
+		return ret;
+
+	if (!(pci_resource_flags(pdev, range->bar) & IORESOURCE_MEM) ||
+	    !pci_resource_start(pdev, range->bar) ||
+	    range->size > pci_resource_len(pdev, range->bar) ||
+	    range->offset > pci_resource_len(pdev, range->bar) - range->size)
+		return -EINVAL;
+
+	while (i < vdev->num_hidden_ranges) {
+		const struct vfio_pci_bar_range *hidden = &vdev->hidden_ranges[i];
+		u64 end;
+
+		if (!vfio_pci_bar_ranges_overlap(hidden, merged.bar,
+						 merged.offset, merged.size)) {
+			i++;
+			continue;
+		}
+
+		end = max(hidden->offset + hidden->size,
+			  merged.offset + merged.size);
+		merged.offset = min(hidden->offset, merged.offset);
+		merged.size = end - merged.offset;
+		vfio_pci_remove_bar_range(vdev->hidden_ranges,
+					  &vdev->num_hidden_ranges, i);
+	}
+
+	return vfio_pci_add_bar_range(vdev->hidden_ranges,
+				      &vdev->num_hidden_ranges, &merged);
+}
+
+static int __vfio_pci_hide_bar_ranges(struct vfio_pci_core_device *vdev,
+				      const struct vfio_pci_bar_range *ranges,
+				      unsigned int num, const char *source)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < num; i++) {
+		ret = vfio_pci_hide_bar_range(vdev, &ranges[i]);
+		if (ret) {
+			pci_err(vdev->pdev, "Failed to hide BAR range %u:%#llx:%#llx from %s (%pe)\n",
+				ranges[i].bar, ranges[i].offset, ranges[i].size,
+				source, ERR_PTR(ret));
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * vfio_pci_core_hide_bar_ranges - hide BAR ranges from the VFIO user
+ * @vdev: device the ranges belong to
+ * @ranges: ranges to hide, of the memory BARs of the device
+ * @num: number of entries in @ranges
+ *
+ * Must be called before vfio_pci_core_register_device(), so that the ranges
+ * are hidden before the device can be opened. The ranges are hidden by the
+ * accesses done through vfio-pci-core: region reads and writes, region infos,
+ * mmaps, ioeventfds and dma-bufs. The driver must declare that it doesn't
+ * access its memory BARs in any other way by setting
+ * &vfio_pci_core_device.hidden_ranges_supported first.
+ *
+ * The accesses crossing the boundaries of a hidden range are split, so the
+ * range should match the access granularity of the device, e.g. its register
+ * width. A range overlapping already hidden ones is merged with them, at most
+ * %VFIO_PCI_MAX_HIDDEN_BAR_RANGES ranges can be hidden on a device after
+ * merging.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int vfio_pci_core_hide_bar_ranges(struct vfio_pci_core_device *vdev,
+				  const struct vfio_pci_bar_range *ranges,
+				  unsigned int num)
+{
+	if (WARN_ON(!vdev->hidden_ranges_supported))
+		return -EINVAL;
+
+	return __vfio_pci_hide_bar_ranges(vdev, ranges, num, vdev->vdev.ops->name);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_hide_bar_ranges);
+
+/*
+ * Advertise only the parts of the BAR outside of the pages containing the
+ * hidden ranges as mmappable, so that the VFIO user traps accesses to those
+ * pages instead of trying to mmap the whole BAR and getting SIGBUS.
+ */
+int vfio_pci_hidden_add_sparse_mmap(struct vfio_pci_core_device *vdev,
+				    struct vfio_region_info *info,
+				    struct vfio_info_cap *caps)
+{
+	struct vfio_region_info_cap_sparse_mmap *sparse;
+	u64 start = 0, end = PAGE_ALIGN(info->size);
+	u64 hidden_start, hidden_end;
+	unsigned int i, nr_areas = 0;
+	int ret = 0;
+
+	if (!vfio_pci_bar_range_hidden(vdev, info->index, 0, info->size))
+		return 0;
+
+	sparse = kzalloc_flex(*sparse, areas, vdev->num_hidden_ranges + 1);
+	if (!sparse)
+		return -ENOMEM;
+
+	for (i = 0; i < vdev->num_hidden_ranges; i++) {
+		const struct vfio_pci_bar_range *range = &vdev->hidden_ranges[i];
+
+		if (range->bar != info->index)
+			continue;
+
+		hidden_start = ALIGN_DOWN(range->offset, PAGE_SIZE);
+		hidden_end = PAGE_ALIGN(range->offset + range->size);
+
+		if (hidden_start > start) {
+			sparse->areas[nr_areas].offset = start;
+			sparse->areas[nr_areas].size = hidden_start - start;
+			nr_areas++;
+		}
+		/* ranges may share a page with the previous one */
+		start = max(start, hidden_end);
+	}
+
+	if (start < end) {
+		sparse->areas[nr_areas].offset = start;
+		sparse->areas[nr_areas].size = end - start;
+		nr_areas++;
+	}
+
+	if (!nr_areas) {
+		info->flags &= ~VFIO_REGION_INFO_FLAG_MMAP;
+		goto out;
+	}
+
+	sparse->nr_areas = nr_areas;
+	sparse->header.id = VFIO_REGION_INFO_CAP_SPARSE_MMAP;
+	sparse->header.version = 1;
+
+	ret = vfio_info_add_capability(caps, &sparse->header,
+				       struct_size(sparse, areas, nr_areas));
+out:
+	kfree(sparse);
+	return ret;
+}
+
+static ssize_t hidden_bar_ranges_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(dev, struct vfio_pci_core_device, vdev.device);
+
+	return vfio_pci_show_bar_ranges(vdev->hidden_ranges,
+					vdev->num_hidden_ranges, buf);
+}
+static DEVICE_ATTR_RO(hidden_bar_ranges);
+
+static struct attribute *vfio_pci_hidden_bar_ranges_attrs[] = {
+	&dev_attr_hidden_bar_ranges.attr,
+	NULL
+};
+
+static const struct attribute_group vfio_pci_hidden_bar_ranges_group = {
+	.attrs = vfio_pci_hidden_bar_ranges_attrs,
+};
+
+const struct attribute_group *vfio_pci_hidden_bar_ranges_groups[] = {
+	&vfio_pci_hidden_bar_ranges_group,
+	NULL
+};
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 4e7162234a2eb..a3d42a37176de 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -44,6 +44,23 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
 
+bool __vfio_pci_bar_range_hidden(struct vfio_pci_core_device *vdev,
+				 unsigned int bar, u64 offset, u64 size);
+
+/* inline, so that the devices without hidden ranges don't pay for a call */
+static inline bool vfio_pci_bar_range_hidden(struct vfio_pci_core_device *vdev,
+					     unsigned int bar, u64 offset,
+					     u64 size)
+{
+	return unlikely(vdev->num_hidden_ranges) &&
+	       __vfio_pci_bar_range_hidden(vdev, bar, offset, size);
+}
+
+int vfio_pci_hidden_add_sparse_mmap(struct vfio_pci_core_device *vdev,
+				    struct vfio_region_info *info,
+				    struct vfio_info_cap *caps);
+extern const struct attribute_group *vfio_pci_hidden_bar_ranges_groups[];
+
 #ifdef CONFIG_VFIO_PCI_VGA
 ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index f3ab8d6531e8f..fc4d4537ee01a 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -12,6 +12,7 @@
 
 #include <linux/fs.h>
 #include <linux/pci.h>
+#include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/vfio.h>
@@ -178,11 +179,32 @@ struct vfio_pci_excl_range {
 	loff_t	end;
 };
 
+/* a hidden range can be large, fill it in chunks and let others run */
+static int vfio_pci_fill_ones(char __user *buf, size_t count)
+{
+	u8 ones[128];
+
+	memset(ones, 0xff, sizeof(ones));
+
+	while (count) {
+		size_t len = min(count, sizeof(ones));
+
+		if (copy_to_user(buf, ones, len))
+			return -EFAULT;
+
+		buf += len;
+		count -= len;
+		cond_resched();
+	}
+
+	return 0;
+}
+
 /*
  * Read or write from a BAR with excluded ranges which are inaccessible.  The
  * excluded ranges, sorted by their start and possibly overlapping, drop writes
- * and fill reads with -1.  This is intended for handling MSI-X vector tables
- * and leftover space for ROM BARs.
+ * and fill reads with -1.  This is intended for handling MSI-X vector tables,
+ * leftover space for ROM BARs and BAR ranges hidden from the VFIO user.
  */
 static ssize_t vfio_pci_bar_do_io_rw(struct vfio_pci_core_device *vdev,
 				     bool test_mem, void __iomem *io,
@@ -210,14 +232,8 @@ static ssize_t vfio_pci_bar_do_io_rw(struct vfio_pci_core_device *vdev,
 		} else {
 			/* Fill reads with -1, drop writes */
 			len = min(count, (size_t)(x->end - off));
-			if (!iswrite) {
-				u8 val = 0xFF;
-				size_t i;
-
-				for (i = 0; i < len; i++)
-					if (copy_to_user(buf + i, &val, 1))
-						return -EFAULT;
-			}
+			if (!iswrite && vfio_pci_fill_ones(buf, len))
+				return -EFAULT;
 		}
 
 		count -= len;
@@ -229,14 +245,44 @@ static ssize_t vfio_pci_bar_do_io_rw(struct vfio_pci_core_device *vdev,
 	return done;
 }
 
+/*
+ * Add the hidden ranges of a BAR to its excluded ranges, which hold the MSI-X
+ * table, if any, keeping them sorted by their start.
+ */
+static unsigned int vfio_pci_bar_excl_hidden(struct vfio_pci_core_device *vdev,
+					     unsigned int bar,
+					     struct vfio_pci_excl_range *x,
+					     unsigned int nr_x)
+{
+	unsigned int i;
+
+	for (i = 0; i < vdev->num_hidden_ranges; i++) {
+		const struct vfio_pci_bar_range *range = &vdev->hidden_ranges[i];
+
+		if (range->bar != bar)
+			continue;
+
+		x[nr_x].start = range->offset;
+		x[nr_x].end = range->offset + range->size;
+		nr_x++;
+	}
+
+	/* the hidden ranges are sorted, only the MSI-X table may be out of place */
+	for (i = 1; i < nr_x && x[i].start < x[i - 1].start; i++)
+		swap(x[i], x[i - 1]);
+
+	return nr_x;
+}
+
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
 	int bar = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
-	struct vfio_pci_excl_range x = {};
+	struct vfio_pci_excl_range x[VFIO_PCI_MAX_HIDDEN_BAR_RANGES + 1];
 	size_t x_start = 0, x_end = 0;
+	unsigned int nr_x = 1;
 	resource_size_t end;
 	void __iomem *io;
 	struct resource *res = &vdev->pdev->resource[bar];
@@ -293,10 +339,13 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		x_end = vdev->msix_offset + vdev->msix_size;
 	}
 
-	x.start = x_start;
-	x.end = x_end;
+	x[0].start = x_start;
+	x[0].end = x_end;
+	if (vfio_pci_bar_range_hidden(vdev, bar, pos, count))
+		nr_x = vfio_pci_bar_excl_hidden(vdev, bar, x, nr_x);
+
 	done = vfio_pci_bar_do_io_rw(vdev, res->flags & IORESOURCE_MEM, io, buf,
-				     pos, count, &x, 1, iswrite, max_width);
+				     pos, count, x, nr_x, iswrite, max_width);
 
 	if (done >= 0)
 		*ppos += done;
@@ -457,6 +506,9 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	      pos >= vdev->msix_offset + vdev->msix_size))
 		return -EINVAL;
 
+	if (vfio_pci_bar_range_hidden(vdev, bar, pos, count))
+		return -EINVAL;
+
 	io = vfio_pci_core_get_iomap(vdev, bar);
 	if (IS_ERR(io))
 		return PTR_ERR(io);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index b7225be31e308..3745911fb2f1f 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -97,6 +97,20 @@ static inline int vfio_pci_core_get_dmabuf_phys(
 }
 #endif
 
+#define VFIO_PCI_MAX_HIDDEN_BAR_RANGES	16
+
+/**
+ * struct vfio_pci_bar_range - range of a memory BAR
+ * @bar: index of the BAR
+ * @offset: offset of the range in the BAR
+ * @size: size of the range
+ */
+struct vfio_pci_bar_range {
+	unsigned int	bar;
+	u64		offset;
+	u64		size;
+};
+
 struct vfio_pci_core_device {
 	struct vfio_device	vdev;
 	struct pci_dev		*pdev;
@@ -151,6 +165,18 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	/*
+	 * BAR ranges hidden from the VFIO user, sorted by BAR and offset.
+	 * Set up before the device is registered and not changed afterwards.
+	 */
+	struct vfio_pci_bar_range hidden_ranges[VFIO_PCI_MAX_HIDDEN_BAR_RANGES];
+	unsigned int		num_hidden_ranges;
+	/*
+	 * Set by the driver before registering the device if all the accesses
+	 * to its memory BARs go through vfio-pci-core, so that it can hide
+	 * BAR ranges.
+	 */
+	bool			hidden_ranges_supported;
 };
 
 enum vfio_pci_io_width {
@@ -170,6 +196,9 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
 void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
 int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev);
+int vfio_pci_core_hide_bar_ranges(struct vfio_pci_core_device *vdev,
+				  const struct vfio_pci_bar_range *ranges,
+				  unsigned int num);
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn);
 long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
-- 
2.34.1

