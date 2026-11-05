Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793893118;
	b=EEM0tsiyBh5+51BcalARqlhMENx2rMGnZjSSIHO+56DsYVEtKjV0wrIZ711HA0ni5Ja5
	 3XU37aumyxJlOzfyd/nk3dbgycQoNiJ8XBRsTaIgv1JSBs21jGkXdHiS5kqq26kHzPBmP
	 0eZ5+bYkICUQ6v1QC7fea4uvda5BvuDlgjBgkwCMJ181kSNkvvbiz/FyE6wb8ZtwLQpC9
	 4lF0bjgA2hXEMU1M2BjdRbIXX1GI/CJY7xhnc/sLeVxSp9pAzckY5myfCWrtfTjez2qOH
	 FsPTOJxnXtty3epL1gExA9yQcD9xVsNLHMDCyq6KaNt/MjGSfjDVdTdqXu4Ue2sH/lQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893118;
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
	bh=nunMrOmifRBrmoX93ePw5jNWS1IKKEvoMXCbYMOwzEE=;
	b=J5NkIjDr86/H3/WR8EQ97tnjGn77kGrf5feQN+K6LkNRYs9Po6k7g+ez9ISLaEMysgRd
	 RulaxdTOZwAnJcnJaPZnahSYD7Ax5qHcAyTymqvNCT9r3+v8JbsTd041mE7yQbCcHGfiG
	 ryWPy52b8Nfj0zfqJBqqsU8XDeYzNJRELwJk89P3Db/SQRfIQBMRDoLLxtINzgGT0iq1C
	 /LGi5hHPLCaMxx5/X7T27n+AB23cA34tfkTeQogIYD962g7rCqBJmZdGPLXv5wTE5crg0
	 JwH5wdzTtm2sz884dSBlvY8/Ew84t3NSABH5IzAtFlMTyTyqLigq8jt2Qjiqxx+rrAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kFmgBCXX;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBEB606A31B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 15:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DBEB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kFmgBCXX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793893115; x=1825429115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=A4NhxFKNl76MjLP2tSemGl/aHePvOxPjnc1/m5PuTT4=;
  b=kFmgBCXXHI4zgj8ZQLKAtJpCyZ6BcFC0w1/tc/SAuY9JZww26dOdJDTQ
   U4lNzntHBMI0YczU0H33xshHXx1LHub4uFnZ/yMWAB/3K+DP9iOGELRX/
   eIzUtTe5GXWn9CfAXbqTzpyLy8/ru8sKQR5ASbXqL7xhcnPl/9Z6w4+YK
   8rzCJ3amJF7Y60SzoaW9yZ6zq3PeeYsbnRO29FU8044SxxLeAvBHwAz84
   hC9/rcRvVryudKtlApmfOF9VPrg5xqBFDKrtKmwbgvTLlfd2y+fzBOH+k
   alPcILBRRmHvBOzfOKXJOdi17hA5C/2qDobRm5nMGXt3UeVRhxx8thq5b
   Q==;
X-CSE-ConnectionGUID: 4kksztt5SbWM/lK+6uJ07Q==
X-CSE-MsgGUID: 4EC7uNbJRy6GdrnOxZZmCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2587834"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2587834"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:38:34 -0800
X-CSE-ConnectionGUID: RuxsJ0I4Tf6vKKdl+9EUnA==
X-CSE-MsgGUID: 5Gh9UL5XRAiPZtkx5lZGqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6870256"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:38:35 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:38:34 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 07:38:34 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.67)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:38:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtOsnm1Qm1pMuV3qCbNpyQaLK7CUfJGf0mcKKE+1tJ4yrKJOdne8lNm/gRwxOWaECAOMM44n+l6Oq8egSIiBonG+cJFSYGyjekb/0iGsO9p5tQIAnGyDqgfioGjcp6ew0SkKvRV2KkhLP/BGX0RCROstA7T/2LXHhnm2r73gnnK19GKoaaQ34/81kAqRwGJqSonpAKdv2Q5CstcHH24pIXO075An6uPtLOA9+hLOnBvmuvL4SRnirLJMIG77tDyOM2OirGXJJdMJi3uRC3cyI6lGZlPdlMxwe4GZQOm8usJZfWVz3G4vX+c3qT2BvjY7yNQweRszK7x/KbHMgrKvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nunMrOmifRBrmoX93ePw5jNWS1IKKEvoMXCbYMOwzEE=;
 b=uvewckpUHwPOyI77z7wcrD+snOBsUMDzP9LYwJBopkYmG/6b6wDRS6cvs0ngO2H+XLeLmsQE+c4RxIOAtX1CG+CQJMGd6AYzjF1Hlmu19nTtg3Q4HsHknyTjv+trfC10MlOvcpNBW7iZ2mTWlfKtJDDo23fka4I4Ex9W/vLwqppaU1kheNB9JwbN9jAaSDvTztDw4JYuK42cjC8V3xr1aa3pGoXlT6bDc9/Dg5FDs+bnt6WZQJX8vPqn6byw041uC2IJHUzf4I3Aqvz3cHZ+ILI3wCXN8gOM5Nnw5/Utr56WgJUi6Ok3K+qZt6jWAlY6AvvkEzy8jn5tXEu/ea9h9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8039.namprd11.prod.outlook.com (2603:10b6:510:25f::18)
 by DS4PPFDB7809488.namprd11.prod.outlook.com (2603:10b6:f:fc02::56) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:37:57 +0000
Received: from PH8PR11MB8039.namprd11.prod.outlook.com
 ([fe80::42df:f465:90a8:df92]) by PH8PR11MB8039.namprd11.prod.outlook.com
 ([fe80::42df:f465:90a8:df92%3]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 15:37:57 +0000
From: =?UTF-8?q?Pi=C3=B3rkowski=2C=20Piotr?= <piotr.piorkowski@intel.com>
To: <alex@shazbot.org>, <kvm@vger.kernel.org>
CC: <intel-xe@lists.freedesktop.org>, =?UTF-8?q?Piotr=20Pi=C3=B3rkowski?=
	<piotr.piorkowski@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas
	<yishaih@nvidia.com>, Shameer Kolothum <skolothumtho@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>
Subject: [RFC PATCH 1/4] vfio/pci: Move the excluded range handling out of vfio_pci_core_do_io_rw()
Date: Thu, 5 Nov 2026 16:37:35 +0100
Message-ID: <20261105153738.1938345-2-piotr.piorkowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105153738.1938345-1-piotr.piorkowski@intel.com>
References: <20261105153738.1938345-1-piotr.piorkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::10) To PH8PR11MB8039.namprd11.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 27d07e72-5511-4331-4d4f-08df3b52c408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|5023799004|11063799006|261026121527099003|261102130727099003|261022105027099003|261026140227099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: F2OMWn4YH7fDaVAts+3ymoPUTxL8ONvLMv0AakMDZBJ7Wc6AdyHQY1dHdgJluv3X6dw1psSnyt/uXuzeJ+nnJcYLoclQACGJ+78/IUHHD2GISEaY97NEsNxOQ2nqvP9AL6CbOXpFZoFcvl63kGxCjTvJcBWSg8rNsGk7d7Wbc/Jgj3koY/LlOs9QDMXB42AhTfuT7o04mOtCBhHGE2hUCqm08gr14TB/YPATDHhMiBdpBblK4fo15KKIYOk43m1ccC1Cxzw8g1s68o7ZwwvaZTfZWyrz5ItTI6Meu1QJ/+lyEW+MFUxxM4k1dVHoCLm48irPQFiCmW1pqdv8KOQTdmRPJ3OG0apUICLnuZ4jtoRitRv09uJZJ00Q2WBRzgeluOyKA6PMqgN2msj6g/UGQDGl6wPhjtNwy4p5mV5S6OQZigD3L6TvQQpFmhqh8FYFrrzwlJK5TGjrLAgYqrjBVpezi8Tmvs0XPc4MsH9KL1/BRZQk35mEAQUQPpG1TwpDxzBPikbP989iEygYJjA2hnZf6m2UzmIBQNDnjXKr13GSctlwTLAVKkE3Y7zK/LBx3qNaD1RQnD1phjYDZBu4QGyECv96u6MuZm48h0FyUkK2N8PLAIZ1tZiFtgkw0OvkBtrldX2tEiChDHjyqm1c1Rin22OvxhkYZmRlxQ5ZU/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(261026121527099003)(261102130727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amhjYWQxS1VxV0dYZXh3Z1pHOXpPUjJaL1hvdWdia0tCbktJYlF5VFNkUWJN?=
 =?utf-8?B?S2Zzd0ZYUzNMS050aHNWTVdNREF5MUxkdDJ6OFhpUTBHZE51OXZ5cXkvakJh?=
 =?utf-8?B?bWpFUkdwNHBRdklZbE1QSDg0ZFdDNEhaY3Jtdm9VRG1WSlNWUFV2VTNDbjlK?=
 =?utf-8?B?S2VVZ2taNnhDTnpyMmF3RTRYVkphdFhCY1lWVEtiQTk0NnE1TzJHcVhMc1gx?=
 =?utf-8?B?M0UvUUtMbEtBK08zSk1acngvMUYxRklOdVVnYVpVdG9zRjR6SWpDVGQ2TDFJ?=
 =?utf-8?B?WTR6U1pKa1Z1SzVKdXdSMzBXQ1ZsaTFKK1o2NWpmQThhSUhXUW5XVXJsUEZl?=
 =?utf-8?B?U05uMjRHQXN1RGlvVXFXVlhodHhTTHZ4U0dCdlVkcCtZK3VTSlFaa1JmUWxC?=
 =?utf-8?B?T2hQNmprTnVBZ1F4Mk5pOEdxbUEzcmpzUGR0TkRLMm9jMWFBSm1oZjZuZFZL?=
 =?utf-8?B?NWwzcXUrcWlPdTBaWS9mRkJkNkRIdEpBdEYxZkRIN0FYSVJGMksra1J5Ulc0?=
 =?utf-8?B?ejNuUEVoK1NTdzI2QW1NZEtJTjdrMmZ6YUZidWlwT3Y3eWJhVTNpYlQrTEw4?=
 =?utf-8?B?M2JEQUtFYi9DNGhDeW95UkorVmFDZ1JyV0Q2YU81TEN0cUhPdjg0UzZBeW51?=
 =?utf-8?B?NkVmNU1qQjN5RWhwREdFNEJGNXZoeU9MK1drVzNraEtBZXpScjBIaFYrY0sz?=
 =?utf-8?B?VkQ1NG9OckF3ei9ITldvc2oybzl2UkpZN0RuQTVVNUJMVkJYZFQxdVNqWkJP?=
 =?utf-8?B?VHMvdWVjUTN6ZTFvazJOdVRCd216NGt0STJjcW1VaHliYUpkZktURm1FMlFz?=
 =?utf-8?B?eGtCQktkNGV3OE0venNQVWJkelg0dkNtcEVDcTNHSXluNGR5cS9ZNXViOXov?=
 =?utf-8?B?VVpuOWhXM0hadjdPeDE5dUozTk4yZmo3SXZkaGlQaDRjS2NrTmFRTU5iNkFj?=
 =?utf-8?B?bnNOa2hHb1NsRjF5OE5ueE9iV2FrVTlVazNBemhWREYySVZVSVpkcjRwajN3?=
 =?utf-8?B?SHJjVEJFdFZsNVFsS0poMXdiMFd3Q2dzaWQweFkzZTlIaDRrTTZOd3JiQVZ3?=
 =?utf-8?B?SmRyR241ejNOVVdNL3krMkM1YmNxWVNDekl0bDFmbkFIRXV3d21lTytlRmlL?=
 =?utf-8?B?ZkljZFgwZXR5MUt0UHhoc1RBTEVuNUpNZnpNaEgyNXZLUXV4ZGp4K2RFSjYy?=
 =?utf-8?B?QkdncExXcyt4Ky9qNTUyMGhyOHNCWDNReFJjUW1ON2RZR1FoZUxsTnMybnp3?=
 =?utf-8?B?Q3RpR1lSYm9IaHYvQnZVYStVbWUzV0M1YnMrbXV0UjhJK2k0ZXFMSlhCUGli?=
 =?utf-8?B?VDNaZnNqcmViQWxBeHJIaFVjWnB6TVp3dlFvMzl5TVJ2VVhheVRVOVBOSGIr?=
 =?utf-8?B?QmtMZWxoZ2dDdUFka1lUTFRycjVzN2FJeTY1ZTRiTmJQQzZxTTN2dmwrdW95?=
 =?utf-8?B?OW9ISzhSd3J5ZGM5VUJpcm1Ma0w1L0Jwd1piWTNLbk1wditsYlVKc1RtUWFn?=
 =?utf-8?B?Z0NYTTJIRnlHUUtVd3pRRnRPK0krNHVxQ1FaNkE4Wjc2OUVVc2ZuNzNoTDhT?=
 =?utf-8?B?RU85aDgzTlQ5T016UGJaWHNGN2tGeXdKME5kTXVWMDRJNmo0d2kzZFZZeWZh?=
 =?utf-8?B?WWo1bnM4T3BpL2J1QWNrNWcwb2FXeVhFQ1VVQjI0VG1TRUFPK0dwOEQ0SFg2?=
 =?utf-8?B?ZlYxZFV2Y3A1WmFlSExhM3l4a1Nxci9aelUyWkZwU0lkUjVXTnhFTkwyUjQ1?=
 =?utf-8?B?VmF6cXBNL2tQSEI5Wlc1S3F5a1dQTzA1SXVScm9xVUNVVFVSamZFR05vR0Z5?=
 =?utf-8?B?emJiamJEZlFub3hWUlhHK2V3REdpM3JmdU1zT1RWRE1idjBpMUdYb2F2dU5r?=
 =?utf-8?B?Vy95bDRrcVdUYmdRRnd2bmdrQlVjWkdYZ0l0SU5jcDNJcXpjMmlnMzhTNGdC?=
 =?utf-8?B?M2VoeXpGNE42dnNpWWRXckU2VTZTU0hwczVWT2gzcTR0SlRzNTN4SExHU3Yz?=
 =?utf-8?B?eklHcUgreHhwUDI0aHZrTmJOL2xXa2lsSE84UnV6VG84ODlPdGZIQWZ0alNt?=
 =?utf-8?B?YmtmcDVRcHN4aGNhakpCd0oySWt0OC81TTY5U052Qlhsa3N6UFZzUUtiRk1Z?=
 =?utf-8?B?QlRSKzh6NWpTeStsb29TemFNTGQzeVRSekJPL3pDa0VqaDNIWU9GaVRYRjNY?=
 =?utf-8?B?M2lLUVF5bTBlSmRUZWhWanBZVW1TNU16TVEzdFo5VzFCYis5N1hmZUZXN0Jx?=
 =?utf-8?B?bVpqeUJzR1hCMTMveHgyVDFoZjJNem04c3BFdk1ESkZGckxTdXpRMDgzSmU1?=
 =?utf-8?B?Q2Rpbm54dmJhS1VMeGJpeElKNW0wcnRQSmJhNklrSnZxb2pLandGdU5wZmth?=
 =?utf-8?Q?3T5C0VPaloWiYE6o=3D?=
X-Exchange-RoutingPolicyChecked: PMQki7bedVnwnXLYG5GQVmIIZg/o4HWKlh8u6kVfjFgfjyrTKpvq++AnRbiZvswVLrFCiV45kf/eDVg2wWanMV4QWIQBbyOGJ5yl2CsxiI84WflIBbX6Kwm5cGQ/lSSKqBSOXbJp6qJDZyxNs48cy+s/RYjUZmu4Sj2cVNMPGfT2snJK2Iymv+z1KDIHmjHKOgIycUeTFfPCfrLg6c73z/uE+caytzzD90fPJudnschlXDLIGNoyM8U64byRSRtfZEF/xrp4fyvReejb94h5p5S1y9zbCKQNThnVvXgPWuoSMjKrSs2CpDShw45XgB6FOtX1BwJr3UkT5Dcjx2WMoA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d07e72-5511-4331-4d4f-08df3b52c408
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:37:57.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyYvGqIgJDqcIUUeSWOObtnCnhk344nnyaCNmPKA7tnq2Aw0kGf9gknfJJnvGPYVIvwhClLri08W769ZAv9YgwcGBS/iCG+0MOK0VzbgfxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDB7809488
X-OriginatorOrg: intel.com

From: Piotr Piórkowski <piotr.piorkowski@intel.com>

vfio_pci_core_do_io_rw() takes an excluded range, but only
vfio_pci_bar_rw() uses it, for the MSI-X table and the unused tail of
ROM BARs. Move that logic to vfio_pci_bar_rw(), so that
vfio_pci_core_do_io_rw() just does the I/O, and let it skip more than
one range. The next patch uses that to skip hidden BAR ranges.

No functional change intended.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yishai Hadas <yishaih@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Ankit Agrawal <ankita@nvidia.com>
Signed-off-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c |  4 +-
 drivers/vfio/pci/vfio_pci_rdwr.c    | 94 ++++++++++++++++++++---------
 include/linux/vfio_pci_core.h       |  3 +-
 3 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index 5ddec340b73ba..432f6b9c2842b 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -787,7 +787,7 @@ nvgrace_gpu_map_and_read(struct nvgrace_gpu_pci_core_device *nvdev,
 		ret = vfio_pci_core_do_io_rw(&nvdev->core_device, false,
 					     nvdev->resmem.ioaddr,
 					     buf, offset, mem_count,
-					     0, 0, false, VFIO_PCI_IO_WIDTH_8);
+					     false, VFIO_PCI_IO_WIDTH_8);
 	}
 
 	return ret;
@@ -925,7 +925,7 @@ nvgrace_gpu_map_and_write(struct nvgrace_gpu_pci_core_device *nvdev,
 		ret = vfio_pci_core_do_io_rw(&nvdev->core_device, false,
 					     nvdev->resmem.ioaddr,
 					     (char __user *)buf, pos, mem_count,
-					     0, 0, true, VFIO_PCI_IO_WIDTH_8);
+					     true, VFIO_PCI_IO_WIDTH_8);
 	}
 
 	return ret;
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index df88480876815..f3ab8d6531e8f 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -126,77 +126,108 @@ VFIO_IORDWR(16)
 VFIO_IORDWR(32)
 VFIO_IORDWR(64)
 
-/*
- * Read or write from an __iomem region (MMIO or I/O port) with an excluded
- * range which is inaccessible.  The excluded range drops writes and fills
- * reads with -1.  This is intended for handling MSI-X vector tables and
- * leftover space for ROM BARs.
- */
+/* Read or write from an __iomem region (MMIO or I/O port) */
 ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 			       void __iomem *io, char __user *buf,
-			       loff_t off, size_t count, size_t x_start,
-			       size_t x_end, bool iswrite,
+			       loff_t off, size_t count, bool iswrite,
 			       enum vfio_pci_io_width max_width)
 {
 	ssize_t done = 0;
 	int ret;
 
 	while (count) {
-		size_t fillable, filled;
-
-		if (off < x_start)
-			fillable = min(count, (size_t)(x_start - off));
-		else if (off >= x_end)
-			fillable = count;
-		else
-			fillable = 0;
+		size_t filled;
 
-		if (fillable >= 8 && !(off % 8) && max_width >= 8) {
+		if (count >= 8 && !(off % 8) && max_width >= 8) {
 			ret = vfio_pci_iordwr64(vdev, iswrite, test_mem,
 						io, buf, off, &filled);
 			if (ret)
 				return ret;
 
-		} else if (fillable >= 4 && !(off % 4) && max_width >= 4) {
+		} else if (count >= 4 && !(off % 4) && max_width >= 4) {
 			ret = vfio_pci_iordwr32(vdev, iswrite, test_mem,
 						io, buf, off, &filled);
 			if (ret)
 				return ret;
 
-		} else if (fillable >= 2 && !(off % 2) && max_width >= 2) {
+		} else if (count >= 2 && !(off % 2) && max_width >= 2) {
 			ret = vfio_pci_iordwr16(vdev, iswrite, test_mem,
 						io, buf, off, &filled);
 			if (ret)
 				return ret;
 
-		} else if (fillable) {
+		} else {
 			ret = vfio_pci_iordwr8(vdev, iswrite, test_mem,
 					       io, buf, off, &filled);
 			if (ret)
 				return ret;
+		}
+
+		count -= filled;
+		done += filled;
+		off += filled;
+		buf += filled;
+	}
+
+	return done;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
+struct vfio_pci_excl_range {
+	loff_t	start;
+	loff_t	end;
+};
+
+/*
+ * Read or write from a BAR with excluded ranges which are inaccessible.  The
+ * excluded ranges, sorted by their start and possibly overlapping, drop writes
+ * and fill reads with -1.  This is intended for handling MSI-X vector tables
+ * and leftover space for ROM BARs.
+ */
+static ssize_t vfio_pci_bar_do_io_rw(struct vfio_pci_core_device *vdev,
+				     bool test_mem, void __iomem *io,
+				     char __user *buf, loff_t off, size_t count,
+				     const struct vfio_pci_excl_range *x,
+				     unsigned int nr_x, bool iswrite,
+				     enum vfio_pci_io_width max_width)
+{
+	ssize_t done = 0, ret;
+
+	while (count) {
+		size_t len;
+
+		while (nr_x && off >= x->end) {
+			x++;
+			nr_x--;
+		}
+
+		if (!nr_x || off < x->start) {
+			len = nr_x ? min(count, (size_t)(x->start - off)) : count;
+			ret = vfio_pci_core_do_io_rw(vdev, test_mem, io, buf, off,
+						     len, iswrite, max_width);
+			if (ret < 0)
+				return ret;
 		} else {
 			/* Fill reads with -1, drop writes */
-			filled = min(count, (size_t)(x_end - off));
+			len = min(count, (size_t)(x->end - off));
 			if (!iswrite) {
 				u8 val = 0xFF;
 				size_t i;
 
-				for (i = 0; i < filled; i++)
+				for (i = 0; i < len; i++)
 					if (copy_to_user(buf + i, &val, 1))
 						return -EFAULT;
 			}
 		}
 
-		count -= filled;
-		done += filled;
-		off += filled;
-		buf += filled;
+		count -= len;
+		done += len;
+		off += len;
+		buf += len;
 	}
 
 	return done;
 }
-EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite)
@@ -204,6 +235,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	struct pci_dev *pdev = vdev->pdev;
 	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
 	int bar = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
+	struct vfio_pci_excl_range x = {};
 	size_t x_start = 0, x_end = 0;
 	resource_size_t end;
 	void __iomem *io;
@@ -261,8 +293,10 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		x_end = vdev->msix_offset + vdev->msix_size;
 	}
 
-	done = vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM, io, buf, pos,
-				      count, x_start, x_end, iswrite, max_width);
+	x.start = x_start;
+	x.end = x_end;
+	done = vfio_pci_bar_do_io_rw(vdev, res->flags & IORESOURCE_MEM, io, buf,
+				     pos, count, &x, 1, iswrite, max_width);
 
 	if (done >= 0)
 		*ppos += done;
@@ -336,7 +370,7 @@ ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	 * to the memory enable bit in the command register.
 	 */
 	done = vfio_pci_core_do_io_rw(vdev, false, iomem, buf, off, count,
-				      0, 0, iswrite, VFIO_PCI_IO_WIDTH_4);
+				      iswrite, VFIO_PCI_IO_WIDTH_4);
 
 	vga_put(vdev->pdev, rsrc);
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2f3fa2787737a..b7225be31e308 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -196,8 +196,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev);
 ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 			       void __iomem *io, char __user *buf,
-			       loff_t off, size_t count, size_t x_start,
-			       size_t x_end, bool iswrite,
+			       loff_t off, size_t count, bool iswrite,
 			       enum vfio_pci_io_width max_width);
 bool __vfio_pci_memory_enabled(struct vfio_pci_core_device *vdev);
 bool vfio_pci_core_range_intersect_range(loff_t buf_start, size_t buf_cnt,
-- 
2.34.1

