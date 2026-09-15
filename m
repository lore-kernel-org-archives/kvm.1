Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BE147B43E;
	Tue, 15 Sep 2026 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464458; cv=fail; b=ec0itG19KA1XNieIIdw2LOoMt47YjtJw5A5aS901WNW8XIEWfhbEvd1qcf7dHAlBlkSWanBrrlln5BC72zdZGUw7lh8VEI1pAY4AEFXeb6PECWZXQEr7dtUbNqB6hBtJSv8VK/OOiHmSKqG5yncazaUVAd1+lLhW91cmn2dpS6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464458; c=relaxed/simple;
	bh=4042QXwvYopnhPV5bb7vwp3I5t1NG1xzgOoErBfEUko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AldvZpueH0O4CAB3x5aajIXLcs4U0n2caD2Cg/QsRtcsbvPrGLQAFU+fDa5NXR2PwevXMXQiFE7YykEKQAZ7wxu3w9PY3aN4+r7ZBF794O5lRpgLYKhbFSV8T5ULDPD/EMmCDN69OrA6Yr4UVw75MkfMeXvjFKu17gLnZLtY+78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3ZsOvVk; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3ZsOvVk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789464455; x=1821000455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4042QXwvYopnhPV5bb7vwp3I5t1NG1xzgOoErBfEUko=;
  b=b3ZsOvVkoiEsgJI+0ACQ1e2SZaTj1ZbZro3XCPvEEhPcXaTyPSoyab3w
   mOEFde/ow4qqSChTWa+C11koNErJDhaCvpTwjeZnVXNQTIXXhVPPMWksb
   RelrltXSdft/qeCMeJkGfuZH4WyUx/YWO7JYkiylkx1RwW7ErJWFQEyYT
   IRHVeRpXOyATXpVsfD9SzMa+rcJEvCMpZc74MEUEaN/tEhlXApwXxNtLW
   hC0KiwIDdHztp7EZ097M759Snd2SNDLuOSfz46h/YX1ppUkJ1IfMudb0O
   l/6eWVBySW70usGwsorQ/oyzwNtu7QX1EW0+LiTEREAdAOKy41Kv4ObZh
   Q==;
X-CSE-ConnectionGUID: lzOsRd/YQVqf7bQ6ML3aiQ==
X-CSE-MsgGUID: GH3D8K7ET8Kx51lNrNamNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89954853"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89954853"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:27:34 -0700
X-CSE-ConnectionGUID: GHMBnLG/T1WkqED77Um0wg==
X-CSE-MsgGUID: +zxd5PekStqhEmP/j3l8NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="302808754"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 02:27:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 02:27:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 02:27:32 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 02:27:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZiWS9Is9QjxFAaJOxoksJde6+9mSFU4CTMDbKODO/6MhxezHYcuFjEKGqyQWalOcgeulH3YgrBqCs8esWlM/P6WpcmD1sM/q5k2cCitpFqqOSxJd7GAhvF6iTEgFOtJ7YmqlkfiIohSUgBraBV3RHML1S4RJv3Ay150YFVuuZMIJ+GPYCi02rSyyChvyextIGqufHDHPweWeKnKysRsS5AyidXNNOzanL6Tm4LwyC7/Q0rpNlB/K9mYW5wlrRK13UKPHIvZOnfqwnEmiQkcRETQMw3bSUqHe4N3uVLuJMPaQsqijI3lxP1Gdt/lYLCHaRDxWLzag3J5ETHJfW7MTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is7Sf3oLtz69bwE940tW0O0efXedRsr8aEUyYEdjGMM=;
 b=dLSzbbjzAHrsKnCMitnDzww0eTTBOuALXmmuOGgILsnzVY7tzyJWXF11QrUy9uanZUa35Q9AfFA4lpMbTBkf/vfjOfN3Nymfu6ebB9OrhvVSqlz18986/84bn0Pv0jZyzj6XFf64qLSOYHFuTrspFH14dYi+VgW0gbV4D//eVb22wK4ZC+kRYaZ0ChohiWxyf3ulOv4nPnhly4O1+UX0E34H3TFYgdgfVb1U7zUx7vPjUrZTHDGMgX+wza6ZQkAFdyK34HHpwbUyyVJC2koaqrkISRahwhif99OhftzxsSEm+M2um1o+pw7K40ygGS+XmB70G8WK648rd3tMmkBdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH0PR11MB4808.namprd11.prod.outlook.com
 (2603:10b6:510:39::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 09:27:26 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 09:27:26 +0000
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
Subject: [PATCH v4 4/4] virt: tdx-guest: Allocate Quote buffer dynamically
Date: Tue, 15 Sep 2026 02:26:03 -0700
Message-ID: <20260915092632.2822169-5-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 21abccaf-ca4d-4ba6-c60e-08df130b8e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: X50R3Xtk2RpCcDpx3FbICvm1+vBb636vG1M6Uf0o70LEZcebVOtm294hK666B/VrysWgwjCD0nVjXwhfGFzfUPLE5aEMkkWn2pmZPMP3JSkh2XsgD66N+LsjBCcWj+Qc6cIdsUr/qmsNbWXW6rS8cXkdebfUKARR3T4wq2aBAwz3azDLdpXI0XHI3NJQKPq7TqDkRbm0R+kq14zw/7UQPD/Yn34vTLjEgarGPMQ0rNeJ6xrd2nc6FVZuzk5oH6f1uSOfjWtYihclF2wLXTh8xVcyWedK5ZkzOZJpWBsOerkFv9A31UTqQV7jVok5y88Cyvo3DMDDAHW7ykPT+qf5ObjAfWlQ2RJnTgQ2Fc0H+oNReb9LqsrFunXSkFIcL5eapQr3SOQcpjTNcrOiE0OSVWyTHCKUhXENwhrM6NhAVJtU0FhUN4QzRmRfUaDDOcyxv7udGADnoWfiQsv1MUgEUpF1ckoyqg/aRzfcgvGYiM7MXB2QCRQIURz8OFCesKG6FcfElQKtMNoiVBRwWirRleJta7HV6T0XbLd4yUINDqbpScK4fZXA3vEz1oKxukV6XUHUyXUP2u/uajfH2axjdjoYLBPM2oCoQ+PEro56dmIz8Kec8ibZ1gVyMw3HWlgxcp3IM8X0ZISjitO7yyYJDw9w+K4C8yW/GWEYfjJifm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qsn4lPR0h8YAFHpqPvVjECCi3fGObXG6SKX8ry5Tg4WcXGhvuKvw7IGQEyCr?=
 =?us-ascii?Q?lF1zCmZJ6L/tW5NynU/wfWAKsi5kLK4h+5njBLanNXS2Qah2ZehNSSfnhHYH?=
 =?us-ascii?Q?pB97PrFXue/o/3BpuQqEYhQgdkYD0hN5WhG/DI9WFj8fhfFNvqk2i1zSYyt7?=
 =?us-ascii?Q?r8hQDnGgMcK/nHdYhVUPg+1HBCbVkub12me7JA2lj9laYrtxg17VRVatJVIX?=
 =?us-ascii?Q?L7LJnmZWHro+U1dD/gOBNBTLOkgI9jhPsJX4DOYpMCmUOy8xNihGX+10+zDa?=
 =?us-ascii?Q?BX0sR43R28O0NqLrKASATj50W3TbkwsPzvjR44IXPgv5y/UOMIWsq+14UA9m?=
 =?us-ascii?Q?kMzGzVSY3hvfwH/gRIHiUmUhhYAYFxleTrbJNaOLF6eAatsV6bToKzSd0cE9?=
 =?us-ascii?Q?YdVqZsph9+2InVvF1yIekyXLZ/HW3FdLQyT3x0Efm69ENQq3xJaISvgnOlTM?=
 =?us-ascii?Q?2RJen3rQHTuOZwszM340fDUX4xbLyuQg+Z3SV6T33n37aeINeuqdFmgSb6GP?=
 =?us-ascii?Q?Sp2DZR/XOP1ErWdOZNg25szmka9J2cRHmr0uMQoLe/21kqwSjZ7vpwzggGR/?=
 =?us-ascii?Q?RHE8JGAp10sWUhYIdpTkERcKFSkdDYGcf0MK43VApIZ2EO6hAg3kAh5Qeydj?=
 =?us-ascii?Q?EMyXhu8nTu9NVHKDxZ/0zlvKg3I4sX9YCQkr2GAxUf6dLYZ8Ee3LQ5ySXTq7?=
 =?us-ascii?Q?pzOrMxr+Uzx+sXx/tr6LhUsMloB0/j8qtmIcozC/3XOvCggKyIefJb11d0xy?=
 =?us-ascii?Q?v+cYWYAfs7pbvr7f2Xd8J3hDpcVA+lZc7y64IsnwCA/02728xM98UODL2S64?=
 =?us-ascii?Q?axVWmM3RRezg4pK5Ww2TEYxZ4HdtJk+Lgi010eJGb0T1/UbE47B9jZlcjqpl?=
 =?us-ascii?Q?OzVpWpCkrOq1UWyZ4R3TYtpxzz/4aFbZHLu27KMUcFh4Ze+cZceh15YmH2gZ?=
 =?us-ascii?Q?R0aBxjAfDPf5oiI/h76S1fzuUfvVQONoJLgxLS1Sz+be/CawO7zvnlQ+D3Dj?=
 =?us-ascii?Q?WHOXzt2U57uEhx6SE8ZQphvs/Hj33fNJVlx8CeR0M5E2WCloZ2Z71lc/f9tN?=
 =?us-ascii?Q?oi3iH76wHiyuxb0kon93wiyIX6bb8BXuP0pqLIwYbUefOcCxL5D5rGhnqbBU?=
 =?us-ascii?Q?CWbQyVhRcMkUAr4hiHrHeVTLmqj99N9B4eyajN0lfPtscw6UOci1MwsqnHBy?=
 =?us-ascii?Q?bfMt3j1nrLnryMtpT11F3+WB4mg5XMN7HlYliGexampRuO7MH76hyqQKY9Qz?=
 =?us-ascii?Q?rPQdzt0fq6P0nsePN+wdULBMc1ZSfO4oZ+mgAK8TCHgvrHVNmRHxa0qEYVUu?=
 =?us-ascii?Q?Yg4voQFZ2JWwttmw2pheN0objJGgjO1vXzHu5RKQ3TrXx75+CbfPPPLKywiM?=
 =?us-ascii?Q?aR6BSs+3Tiqn1Bh65/DGgIVCYj+gVUSD70LOFSgHSQkgpZ1WecwW6j9ifQ2f?=
 =?us-ascii?Q?fVSIYTPd7Msnzu7abV4TiJo1uvye5EB4XqBL2DAGwv38nPO3LQmGjgFWXg74?=
 =?us-ascii?Q?VQnhEPc9yL1NDIn0ff71Lz1h+z3P4poljqoblbObRU4yJMggaat4RTdmRSiW?=
 =?us-ascii?Q?TS9H7AshtwuFbrKuPsU7o5lGr9To1GJ4bvvk5f43fsQgP2CruFhIkgYAsMVa?=
 =?us-ascii?Q?ozu6ZaEFr3qRQraB649mkApSsnEyzxqEMFate+h7eyiUqIJl/rH++WwUXzcX?=
 =?us-ascii?Q?5OSy/pQqkBOdbd5mDwSJ360KCyZfY3D9t0job47ymQF1LQbqLYw7ITxGESYI?=
 =?us-ascii?Q?BzvOdUZTDw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 4/OHaMAnEjAgWKiaLCXFGxdaFSTMtpbxFlSyhA2lCXvcmLSTwEMuyNMUJr1MxdkwlwjyF/WOFAB/X1v12IqX0j47ADuimZB5S3F7v1uqVc0uwY8fsV/66DovBY71m64yYM0gHKd/RJH0kQabJpWSzmKNoeIZgY1dYLSgeqeS9ojwtWUnceW8Qf/Y141dQt7M5ZP94kVTVUAU6WllOOXq2xCeto9xUsXHKND2JCkdlZg0K/kzNWMQEBCB46CpXQFkbhAU9AfBH8r5wnFbs6nySzmftqGPyByEycFMQg7IVhKXUeX0UsSwGvwOth7zmkF+X0m89spyni01gsfV/FmK6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 21abccaf-ca4d-4ba6-c60e-08df130b8e4d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:27:26.3675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIDHvMFrKweNbdA2ZP5IBQpKexR8XkawaRQeCjGDoVIY3YV3GE9K7k2dfHHQMh7g9FLWsdEGnUiHNZluImv38A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
X-OriginatorOrg: intel.com

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

A new TDX module ABI reports the Quote size limit in a metadata field.
Prior to this, the guest driver uses a fixed 128KB buffer. Intel derived
this number from current Quote types, but that is not sustainable as
Quotes evolve. 128KB may be too small for Quotes using schemes such as
post-quantum cryptography (PQC), where larger certificate chains can
increase the Quote size significantly. With this ABI, the guest no
longer has to rely on some empirical number.

Allocate the Quote buffer based on the reported limit. This avoids
wasting memory on platforms that do not need larger Quotes. Older
platforms fall back to the default 128KB buffer.

As a result, the maximum size of the "outblob" file in configfs-tsm now
depends on the TDX module.

Because the Quote buffer must be physically contiguous, its size is
bound by the buddy allocator's maximum page order (4MB), which should be
sufficient for current attestation needs.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Peter Fang <peter.fang@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
v4:
 - Move the PAGE_ALIGN() out of get_quote_buf_size(). [Xiaoyao]
 - Improve the get_quote_buf_size() pattern again.
 - Document that the reported size covers every Quote type. [Xiaoyao]
 - Document that a module update does not change the reported size.
   [Tony]
 - Add Tony's Reviewed-by.
v3:
 - Split out from the v2 "Allocate Quote buffer dynamically" patch. Add
   the dynamic buffer feature on top of the refactoring. [Dave]
 - Improve the get_quote_buf_size() pattern for better readability.
   [Dave]
 - Drop __GFP_NOWARN so an allocation failure warns. [Dave, Rick, Kiryl]
 - Drop the Reviewed-by tags from v2 (Kiryl, Binbin) as the patch was
   reworked.
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 31 +++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index ec886c401fcb..7224a66b65d1 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -162,7 +162,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
  * DICE-based attestation uses layered evidence that requires
  * larger Quote size (~100K).
  */
-#define GET_QUOTE_BUF_SIZE		SZ_128K
+#define GET_QUOTE_DEFAULT_BUF_SIZE	SZ_128K
 
 #define GET_QUOTE_CMD_VER		1
 
@@ -222,11 +222,34 @@ static void free_quote_buf(void *buf, size_t len)
 	free_pages_exact(buf, len);
 }
 
+/*
+ * Return a buffer size large enough for a Quote. This covers all Quote
+ * types supported by the platform.
+ */
+static size_t get_quote_buf_size(void)
+{
+	u32 quote_size = tdx_get_max_quote_size();
+	size_t len;
+
+	if (quote_size)
+		/* The reported size does not include the buffer header */
+		len = TDX_QUOTE_BUF_LEN(quote_size);
+	else
+		/* Older TDX modules don't report the size, use the default */
+		len = GET_QUOTE_DEFAULT_BUF_SIZE;
+
+	return len;
+}
+
 static void *alloc_quote_buf(size_t len)
 {
 	unsigned int count = len >> PAGE_SHIFT;
 	void *addr;
 
+	/*
+	 * This fails if the requested size exceeds the buddy allocator's
+	 * maximum order (order-10, 4MB).
+	 */
 	addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
 	if (!addr)
 		return NULL;
@@ -416,7 +439,11 @@ static int __init tdx_guest_init(void)
 	if (ret)
 		goto deinit_mr;
 
-	quote_data_len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
+	/*
+	 * The buffer size remains the same throughout the lifecycle of the TD,
+	 * even after a runtime TDX module update.
+	 */
+	quote_data_len = PAGE_ALIGN(get_quote_buf_size());
 	quote_data = alloc_quote_buf(quote_data_len);
 	if (!quote_data) {
 		pr_err("Failed to allocate Quote buffer\n");
-- 
2.53.0

