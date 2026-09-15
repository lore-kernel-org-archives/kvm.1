Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4F472F97;
	Tue, 15 Sep 2026 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464449; cv=fail; b=VY1UC8p//Vgw5KWzq/j5x5qqQniuQHKga3goL8vRrnNFCYSKueoGefoRMcpBb+on4PwRVwzchtt3PDXNpZFe0e6iL8ZYl/ZJGO3jCFUAebbQW8uTZWo2eC2iCwP8ECqFtff8UyZ0Fk4bCA5BSJaMstNcp4i9qMo9g8A0HKobZN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464449; c=relaxed/simple;
	bh=hweB310VjrQUYCsSCUtORavJjYPdbKDbgmWPwup8I9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RaZihWBT7uIE/5NRkfsnsRWQYZUtRKFX5uYKt1D6eTnyVtw1w4vboYPCjqHd+2UpWrfz1nsU0VzoCYz7xHuzK9r0LFYm4IRDXBWHKQnZnxDUcyhg7anmbcyPAN5PRA7remedAi0wRHBUlOvujKQzVhzAEfXve4we57YjXm2ePy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdnX5oCF; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdnX5oCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789464446; x=1821000446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=hweB310VjrQUYCsSCUtORavJjYPdbKDbgmWPwup8I9M=;
  b=CdnX5oCFkRJSPUwsdQx5nry6TwuYzky9xwm82YYKVHUz4nCNW6TdMILe
   IVKjEef7N0jEc3Uk9npy0NC+Spr+cBhuIayuaKt1Alkbm5ZCJvLuoFcCg
   bOzERMxSesR0TKM/CqDQ/OJLomaVRyYL02bQRRannS+q0wn0gi6yvLLd0
   CccvpwfJ0yh8kW/7WpbQJN3JHaVYyq67SusHANAQwRiX7GJuHbT78O7AI
   scq7qBnq21C6OnprhxDF1uG2O/4VI8sL8Ee2Eu4POpjVGv7ndezL43G0s
   PgFUE+e7uaOx51ChN8xAzUjLTfrWzFaV95BX09IjOzOrv4tHXrxmmhFyA
   w==;
X-CSE-ConnectionGUID: RrYZxIODSZWwdpos0i+Jtg==
X-CSE-MsgGUID: Fwf+SL47SQiNHDN/VxPZCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89954827"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89954827"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:27:25 -0700
X-CSE-ConnectionGUID: jBVhvIRsR/mHZ0cbqJMlAw==
X-CSE-MsgGUID: s7TiIY+ESCqjHYWnYe3P4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="302808712"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:27:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 02:27:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 02:27:24 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.15) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 02:27:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmkPXI80omBAoH7XJFa32mEVCTYx30ubtUa+VFQMTM8KmRDhk1KS2/44gy1V4r9CVeqiYFzwrpZZEaAg2KZGgDpH+oAWUjqWtJ99yijaQkDuf+16ZH2mT9AVCJMQ1X+coZh8RVMnC77c8FjSyw3cYXln9qd8rne/P/z60tt+sEoypMn6ENa5fACkfmevhZRxOaVZGog242pUS1/Vsyi8lLs8//8geRaT1PW20NmIaNKnHzxyVyKy0wwt8Ccw2wEGqx06U/8XH8t2it08PB3QUEswr+A9RP/lQmcHRhR3CYWlXk3gMZy8K4yC2Y4HmJzxHR9wypMCgHIbSbR4r+ffSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9D9RhWecuzcnz6CYbxuCpQI6o3KEhe4zoCxBaE2Tnk=;
 b=NMIzTTRjhMQgTtTQBnzEl+sJNejhsXm7VCmnm7V+xlfdKmyvvnltsYOOpg7gjo4LNGFVEKeOlPjINy89sgfCZBv8Tl+VPiUl+hxU6d/WN9sClNRyRbTVKSG1Tm0SVgm+lbEXimKTtU9b35crtgLNq+TFzGyW188lTEczbh3+x1kHqamauE2G0n7v2KU0hjDwIJ0Z+oEdb/uE33rEVor1wudZdkhEuw8U4ypxt3G/UGEsxF/vfQmUPy+7Lh0GQjPdzJ+RbBIkyWyLrek4lTvL0xueuKPH+JlwJKmLIC3+2zWrrkNxncSGSu5BKVI2GtEhNbb2QhfaKQwCo1I8+oNgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH0PR11MB4808.namprd11.prod.outlook.com
 (2603:10b6:510:39::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 09:27:22 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 09:27:22 +0000
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
Subject: [PATCH v4 1/4] x86/tdx: Add helper to query maximum TD Quote size
Date: Tue, 15 Sep 2026 02:26:00 -0700
Message-ID: <20260915092632.2822169-2-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6172067-1d5d-45bd-1e31-08df130b8bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: SEvjMnm/KOHmvmQsmnpYZzvRe5Fj8vUIvG2P1wCsi0bzJmuYDGJL6YXvaquFjVxXwDiQjg5kVaDGwi7craNt/eZRZuVgTV9uh7/bAb0904czpYm5TyfUPNwEFncdU3Slcmf+Djfgr8t3zGUjqVlcDlHsZr17najfuvy7LCIYVjoZaDwGRLw4i8EXOg+0GIRTl3sLSUENoDw0g7TP17uV6YOxYtduNleb1W0ph9cpfF5GlwAYep6+on/nVmY7qeTVCDBT909sXexfTlqw3DtM9AUoYjSwSD5irI/1zgym1mAti+cKkVFF8Is9rHe87Xsd+9CsLllzM+HrX90vOSRgkNtD/jRUQ7kuOXNHq5X/FbhJwiIowp59iwgQU43XVuUgcpm/6XuQMEXptxKunlp0zOW5HC2eCexAeBTCt96B/UNjVJZsiM7i1bNNYH30d2l9HyzmE8KsOY0zw+MWn9t44RT6Aszg19nmCxxdO3Xh2yIhi59SCEB6X3y0CrjRps6Slf/R8wHJEmQTj8jcX89H8PQrXZXQoovPgqOP8e4JBRK/kBYtBAJMvlMYuMvthcKsGF/ogYeizbgJY/i7Lt1DXTfIGbJY6UIdDCyTZVCgFm443ZjqmxmkQLfuEZN1XWh7ckbc0jdphYZ9MMU5uO0cXthluFd+rjB3MYDDtA7NGOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RjfDuVI41kWUeHYklv2uZ4v40F2b2aGWbrejl+fmaoEuvZswmJt8/CP8U9qN?=
 =?us-ascii?Q?51ViJMSbrH5eZqsPzcwly+ru9XVRriFivNaS2W2ScWyUCPfdQ94+PNi6c/Wh?=
 =?us-ascii?Q?BPgW+UpQkKdOpX/NL9en2d8KexXjIiweP/cDvHnydhRnbvgstgBNfBAUXLiF?=
 =?us-ascii?Q?eCJeg3pQvOGXQPOr2vCCuB/fsj/yzuay1LvWYhrL1h2trM7V4YsyXHnd9aUc?=
 =?us-ascii?Q?hoz1F9EX9t5fWQnN/0cy0RPKkbEV1uX3ddNoqNsEdfLY9YdhIyjugNytKYxg?=
 =?us-ascii?Q?RxnVFT0ib15/fWU56fyaoSKhPv/14OE/MvAML15zLQvkKTA8YGiAiwEoEv+z?=
 =?us-ascii?Q?cclRlkp/j9qqSts/dlbRPD1N1L6N2Csik2g36Z6WJ5iXARB++3Y8Sy9y6Va0?=
 =?us-ascii?Q?zq3S/3YrAqwAesSuFzqcVueO8b8bRT+YOr6ePXIxRR0z0uGDjoPjOhLrav25?=
 =?us-ascii?Q?+vqJnD3paSjyy9xIZLQ4m2DuOtcv3gMhKYk535/rFHMV86xNT481fQ5fjfGL?=
 =?us-ascii?Q?hmbBZ+8sJeXOmBuX4fzGixvuSG8Eyf9jXWByEtNvYpsG6/dpYTIS8kW/lhDH?=
 =?us-ascii?Q?pX7m3GJA4UZfZEWkB1srLrymppqk72FgNXvEpE8V0JkyTxLW0eBo3Y2JVt/J?=
 =?us-ascii?Q?qLX3Bmqoi/nep4/cUFOZmOkzQy/Hi2DhcCznmCAZaFGuoEqivpsIAFZlF03S?=
 =?us-ascii?Q?8Ka7PolrjNN4AEHrgpxmpSCqlQzzsw8bszSC/Sj2c3k+WONikULtkkCqej16?=
 =?us-ascii?Q?/9Nzpg34uTzKPF6WN0OS7cphidH9wgh7JPolcQMuKlwwex5HEPD5/uzT46G4?=
 =?us-ascii?Q?kcgEAZJLOGq1gh8tbpjQ2mVOit0BJoLhWikV8imFV42mbb3bXc7cVCpxdF2T?=
 =?us-ascii?Q?a2VK+IuFQoHklnSONEoiQYyly60C/kINS0Szy8LUcFYbfgqHHVsOI7/CgWX/?=
 =?us-ascii?Q?SK+XgBrSySj9MqV4S3PLWAByZeqyWzl5fvMS3racZOcura4EUrDIjXc0GomM?=
 =?us-ascii?Q?2FLDuUPvdeOUhYzJL5/K+X+XjcnCtmIY6dpFfnMH5r39y82p7LVG/myAT2fm?=
 =?us-ascii?Q?SHTeBJRrTMst9U7wzVidFU14+SafetfxPNDt5E15L4DHHWxmA773JEg9Dtlb?=
 =?us-ascii?Q?Ke5Z7x2T4rzoAygibRHdz43CxV7ieYEvAX7KwZuBasYkQwILdTFUZBOzQDal?=
 =?us-ascii?Q?Yi9jwvD5+uRsMUsKn4bl3iyUro40dUEVm+HlFwDKvKeDtloUTbIueCdWc+Jz?=
 =?us-ascii?Q?mdrPL5DHQscqi2HPcjYits0fA4myTYZuB8+YVWKSy7BfIhtodws1TEVGWZKY?=
 =?us-ascii?Q?CX4eWusJAAXdvAA93TGEPrcyjGeqUF383iOn3Xo91nFXc+v2mzbukMyGk+mz?=
 =?us-ascii?Q?Brbc9ocuOZcC+cNqwa08MMULh3tlxMTz827dQtrK3zG7FoLFCey8UIGdg5fS?=
 =?us-ascii?Q?IoLH0j0gBBq50wlYS4Wxdu3xUgU6I2z9Ak58eERazMzLrXCXh0CZFs4T9/g9?=
 =?us-ascii?Q?RW4c6pxyoSEepVYr1keZyLku/mDIbzwPr1zi/Kvu8t9n2AFqjqZCn3N8JwLs?=
 =?us-ascii?Q?KMGMIFYNkMxVTtvXxuF7v/Jplq3A8WkzWiFLuvHy1gvh4GXdORfmIruoBSNI?=
 =?us-ascii?Q?OvK1ZOQvgZzynS2i5TWX3h1NXXksSK0XZArbkcEy4BjEnEAwCmijOAq/hUmH?=
 =?us-ascii?Q?6ID9GnRtyPjeR0Cq3K0ufE3z0jVYuvu9GZfFeYOVLM4n6QRJg/tBjGAWYQXc?=
 =?us-ascii?Q?XGD4I0TbuA=3D=3D?=
X-Exchange-RoutingPolicyChecked: ljWKNXtdBH/DbTf2ZSF+SY5MiiPgjighb+QDISlORGlKL/MPjrILRr6umJahT1gJ3oYgf3dVU84YkpNIMB1skxu0jBHYPfd4vOK4gWaAuabn9h/6+s95mjTvjBmk6IbS4qd9eDDtOIMS2akRQ8wHAvarFy33tr5HMuLGGdsok7El65mi2aD60W2nAOiZvGipfzYSngb13iel4YTxqcj8L6oWqTm0VGGaXOS3cpZNnIGRtWj/o1LzrTGRv851x5wJZd2kU62fxKbP2v+YMfK6WI5kc+osKFrxOp81yf0tZM+aUWNDaop4uADZLhAQXZ7PdHwtlHNc++IbemTErvKrdw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6172067-1d5d-45bd-1e31-08df130b8bcb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:27:22.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEGNuA1nuow4nzPNeLzB5UuVuMrJuT8j2q5tgRN55UMajwi5lBXBzQoHqeOFl5GJ85LtQdUEmCSkuOzXbl5Nbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
X-OriginatorOrg: intel.com

TDX attestation report ("Quote") sizes can grow with newer cryptographic
schemes, so guests can no longer rely on a fixed-size buffer for the
Quote.

Newer TDX modules report the maximum Quote size via the
TDCS_QUOTE_MAX_SIZE metadata field [1]. Add a helper to query the size
instead of exposing tdg_vm_rd() directly, as it can read arbitrary
metadata fields.

The reported size covers every Quote type the platform can produce,
including SGX-based Quotes. A runtime TDX module update should not
change the size. So if a Quote does not fit, it is a TDX module bug.

Thanks to Xu Yilun for suggesting this in an off-list discussion.

[1] "Intel TDX Module ABI Definitions", August 2026

Signed-off-by: Peter Fang <peter.fang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
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
 arch/x86/coco/tdx/tdx.c           | 24 ++++++++++++++++++++++++
 arch/x86/include/asm/shared/tdx.h |  1 +
 arch/x86/include/asm/tdx.h        |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index f904a636d449..b98058d7d244 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -198,6 +198,30 @@ u64 tdx_hcall_get_quote(u8 *buf, size_t size)
 }
 EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
+/**
+ * tdx_get_max_quote_size() - Get the maximum TD Quote size
+ *
+ * Read the maximum size of a TD Quote from a 4-byte TD metadata field. The TDX
+ * guest driver uses it to size the buffer for Quotes. Older TDX modules do not
+ * support this field and return an error.
+ *
+ * The reported size covers every Quote type supported by the platform,
+ * including SGX-based Quotes.
+ *
+ * A runtime TDX module update does not change the reported size.
+ *
+ * Return: Maximum Quote size in bytes on success, or 0 on failure.
+ */
+u32 tdx_get_max_quote_size(void)
+{
+	u64 val, ret;
+
+	ret = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, &val);
+
+	return ret ? 0 : (u32)val;
+}
+EXPORT_SYMBOL_GPL(tdx_get_max_quote_size);
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
index 89e97d5761d8..a75dbbe004bd 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -83,6 +83,8 @@ int tdx_mcall_extend_rtmr(u8 index, u8 *data);
 
 u64 tdx_hcall_get_quote(u8 *buf, size_t size);
 
+u32 tdx_get_max_quote_size(void);
+
 void __init tdx_dump_attributes(u64 td_attr);
 void __init tdx_dump_td_ctls(u64 td_ctls);
 
-- 
2.53.0

