Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA122395AED;
	Fri, 17 Jul 2026 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324683; cv=fail; b=G3iiT9qXyytSK0lhjn8I/Lfv9z2//2Y6NRPCAlPqcD8oKKA8CdHHyz05Ayq0GmEYvDf/4INWtmCQRWjFzKeFnZdqet5LqcC3btMmmcwDLRA4uEvOiUWxcSKkZKoPFPttARMDSlCzMvz/IQuG0MAyngx91R17RWzCXqSx+sQ6QA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324683; c=relaxed/simple;
	bh=Xqn0je3Z8D9qo8RLkkHH9IMJk24CatgIXy7cu2XbBfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dqfBhRSEi3orEaIqmbdgozUFa8kkZ1de9aVILWPxXlZR3Nz9V/EEXjIHOYb+DHez/Vhl2GSzeJoXiIOvmxihb/3tNmYvhOiVq8NJzgswxbT2jfB2WbY8pW6gHWdn/maP2Ns9FLIe7Wsi/11PrpJeKId3lHhEwj0Ll3gZCEQWUB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJvp65tW; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJvp65tW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784324679; x=1815860679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Xqn0je3Z8D9qo8RLkkHH9IMJk24CatgIXy7cu2XbBfA=;
  b=gJvp65tWOf0Q7RM/xsRZ4p8CKbnCE8VNUBMZYLTGILs54RIj7RL+sRh8
   uAhlLwl3eTxeT50zf2gjUnIIU5hKcxTVnO2H0Sed8fNaZjKDgZH4BsKgK
   KoYtO7rn/6rbPhh5VjdkpWRgibblebVT35V9r5BPQpcxonK4BOBGluDre
   ejXHPQZtS/yCPoBbn6xlYJces9m/zWrFFmw3jDJDMHqirfMnaiutbPbQ9
   ArPiKlPOyRkpD2DaafzPsr1iBkRfTtLsimti8otoLaRnn1t+7lJmm4S8P
   jvRO0aHYOv8TYMQ7cZd1OCH9kL/N2wc0+wa4QM4FD4FUJ7WgfA0VESWyN
   Q==;
X-CSE-ConnectionGUID: yNOkfZ/jTtmbE6G9cIIMeA==
X-CSE-MsgGUID: VMCKH2BsRtiSX6Zv3ULJeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85201770"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="85201770"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:44:32 -0700
X-CSE-ConnectionGUID: Z1ARqyysSNSw3Qi33GSCsA==
X-CSE-MsgGUID: yyAskRuNT2OO9wQ5RQZTCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="255720258"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:44:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 14:44:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 14:44:31 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 14:44:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuLeyba4WR9edN458tuxsoHldRZadGsxgZbbS7WvcQ0va11mzDMxl5ku+AEQOrhQkueO/BbbAa5t4QMam3CRDz4CEtsbhBSorvQhLA6Nr3QVBfLgtr22LR7mTQ/yIsfzmUUM24g8lNcZjBWqM22f/xgnUjzWDMuryCu05wzz3yJz2IS2WD+sFZsISLsiAlsmxKWRxf0fZJOLK4puQeZJmtXtl9kuz0u+/ifBWJCsSEUZ33QAEg3IHjZRpqCTeaH5pQkZywwLuatTTp1EgAaxiL4jeac0r2rR0y3SstEuREYtmjsE+zqSJd21KcQkVIWpVk/CFxHL2/ux+csPKMdl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/s6fsslQzdczx83jXRzdCWaojr6VSFC5T4H6AzYqnM=;
 b=AetDf7bAiINuWM6vC/zwaG35kQuZr+3CHLF2HhVbRClyVKaSOoIn7XLiGjX3ROfoQX9m3/J0oTFJEGqNyiYcQI3tsGGGT4kYaORpuOm/wUO9baK6RjLtuca7zIOQ6eVvk2UG/hRqC7q/opmVwwVxMqNIY5RPt5bERG/iBDoa2Ojnh69AqVEbURA+whWrN66dz9h2Cu3qLtXvXSlV19as4ymyzB1JUJAZCJC8g4sJVSkvjYJBTXfWRaNUlZAgsVbBdqeNFrQGnwD3lKrd/Tlr7o4nltBLfcBq+bWD+KhvFKFxif4br9+epziv9B47Gxn8aqyYeScx70mELT4c66t8cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 21:44:27 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 21:44:27 +0000
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
Subject: [PATCH v2 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Date: Fri, 17 Jul 2026 14:43:12 -0700
Message-ID: <20260717214349.4075994-3-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717214349.4075994-1-peter.fang@intel.com>
References: <20260717214349.4075994-1-peter.fang@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|DS0PR11MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: f12346e6-af95-40fa-b564-08dee44c9306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nTCvVnZmmdX695EuBQPeQPXBRG8XkgRk2qzJiQ2wjS7JzNjOLJmb//l8mjrwBUoqBAmq7p+GVqhC15PrD5PiMWfvdyO8m+tuKPGdgxcI0mf8WgwRSkVuyiD+YECZ5BG1VrwM2i/chmRrEwxe+ey3bJCwcZDoEXTd+tgPefhpfC20eADj/ejr8dY0BxEz7RCiIZvwznV+gGxB56B0+HGK98O26ndxJFDnDNWAposU4qcD2OAkaErtjPOOwVptyCG/pDVG59S8ey5qJIlMIgz8K34bGFNfzbKnO7pFcGklAKVO9Us+kTSYM2NWrb4sKeW9lXqTANgMTxQltHOl3BfA0QMOFFnkWFOcNrPyvF8CPNUWnCK8kKafXAbTvH1rt3rdKn5JCCEKR5QNy98i1/0c8iAEWU384YACKdwfKqB5xLwz5oNy4vPFbQ1LzY/U9KencXrTTO6n7WIzMSXLI/W7/k8OsosZHFXKeeW/cmKSXmuhthzdh9gahGNFA2OVZwSf5HtAjl71TrUcBOKP29kD3mGvQGnsLQNAjvchfl6k6Qj0sPXC6ORTdqhTEvhN1R5bKR2orAxlsHtED55ga+usQB/UMUEvN7K0jnX87NdXiZAraPfuWbW9paJ0t9H+2rVI6l1GtoEIQLlXKV92WAw36XUN16UmwdVAoG//uHd3Lk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GFKwAwtB4KeG+PGc8a2MewbqHRL5qN1LZ72dXn+CWGpVzEzuzQqkuORQXRY7?=
 =?us-ascii?Q?0TRK7LduX0BTNX/cASrFh9VycvBK4UhlU9GsEpju7NvfV3hIAgDhn/myK6lw?=
 =?us-ascii?Q?XSlFi6QK/DOaVFck+g0uMuQ44CVleUKfNZNotuyICvYtasHEtraUwpeG6Lkx?=
 =?us-ascii?Q?dAcN94wnjU1ocEmCSUOXztw8zLmXKq7rLXDPpZX47oeElCJUktLTTWgEs4AW?=
 =?us-ascii?Q?xazhr0BxhBc3a7Mpjm6QtORQVVhmrrNhj9WvrgfmZFDhc8VP8H42iLCCBsx4?=
 =?us-ascii?Q?IGazy0azd99sWuuqFvrTDzBKcWPwRMEFXCWReOF5eQZtzgo2y/RHB2p3xyQt?=
 =?us-ascii?Q?8ZWxngo2eCF6F5GRyjNWzX4BxJMKvh0BPUeOKmzHWl3GUKImUaXTZ7t+c4MN?=
 =?us-ascii?Q?RMk0xP6W9Csrdsja+sVOwoAPNEhWzKCzf4ItcbVML57s3agagyZFrUITbjBU?=
 =?us-ascii?Q?9izMQzXJAN8SyrR7ciV2n3zncqN5MpU6LSgIxvcSbcIjvWuh0PaUuZzYlW15?=
 =?us-ascii?Q?PiNw3/Fh3YZPYDkUBAjky6LvuvXcwHj/oV8lz5iOEVMP95VTb0AlQbBXQF/p?=
 =?us-ascii?Q?jojgWBN531aLm91Jw9eYmI9M7C4HAIZunL4cetN0Fa26kI0wxPPhimJO6Pbp?=
 =?us-ascii?Q?lKZeYbTkiM95+SCOuXCFfvCbVkAlZSgVsH730ZqYjl6Sn5pY+Yi7ceoY6i1G?=
 =?us-ascii?Q?iI6KJqUglS3KcXet4dsoK8f3kRhCl/+ZoTAEhYcnGIzNtp4eHncYLr8+Fof8?=
 =?us-ascii?Q?XoycqQy1CAWBy5bL6FhwqUjb+0fOrXX592mZ1b3UNT8ie/LN6olgCZkz+aDc?=
 =?us-ascii?Q?cHTnAtlVmTobi6EVB9j0gkAG0pBcGMJra2+bqphr2bGhFBTGXny9qF7UI5JM?=
 =?us-ascii?Q?bDW1bzrRW20NxTDydTmfc1KkDVYV1sHeAY+5zqW4cWyFGg7M+8QMEnPr8Kb7?=
 =?us-ascii?Q?W9FS6l1oca6Zzo2JMf1noGdqoPa6J9nn9HYrcQwwYzJcEy03PdB6SYlyCZBE?=
 =?us-ascii?Q?du7tABm+lw4qyu7P8XnpBKrCYHzafonh2HbCh1c1/PRqyzzYXNewHv9oMAyH?=
 =?us-ascii?Q?fTsDc4bBU/k8XcwyMgW93LrV8obwownd1KIwE2ZoxTpWSSmzPzJI5ZMZ3HfF?=
 =?us-ascii?Q?efdD3sUGei/JyWAcpLt2ghp9kmr0BlK82pIn20rFeR1wGZ13PemhiPTYFgB0?=
 =?us-ascii?Q?ZDAdAoU+Dsm7SwHjpE8n5hbZ4dLDjCCQTMBaaWJIO7nXq1+PKvmENCz4p9KJ?=
 =?us-ascii?Q?BuRrY3GJGo4oezlU/lsY2XXeXmjUNNz+xWgYmZAGn2222XAErxqIOWkFetVF?=
 =?us-ascii?Q?HNJajE1/ULEgo8Ze4sCcT2kuFL5dEB5+TexjyYMSsuEiWmnJiyPZr8NhPXZh?=
 =?us-ascii?Q?rLSFWuLltzRFwlkLLc+xGY96OuWRRzct2GYHw2zRePBF1S3cWTu/AzCSQnNa?=
 =?us-ascii?Q?o+ooFTJh+gzRKnaJtEVFL9MsCkPti/hgyf74jGVxfXdP5Cdefhbi5Y05VqyW?=
 =?us-ascii?Q?YqqQ+MCMbKFYsDtArVNUhCo1+KfPElMFovYR0Rn8nDgWONdZWYYKnKGf0VvH?=
 =?us-ascii?Q?UiaQ590+kRupxvWbQS7HYFfiw0yiJiI3tG5JesGpd84QVyYKbmzUAkm4m+qA?=
 =?us-ascii?Q?PpfhuOq1gXsGaq1JoWFGHizie62qb0ee35eT24LonTBBFblm4KSwG52Gd/PN?=
 =?us-ascii?Q?NUFg3/sn54NwNWZWIPExGn1NiaQz7xuQr3a1DHOMNGNKtlNsMdT6k6SVsppr?=
 =?us-ascii?Q?xG3bFmsSsQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: o8zuk5FwlwkaHFl6vO5wQCv0Qm6SDyOos8hoJz0NZL3G0HeAT8whOhFOJDM4YOFG53JZZUUV/QIiCpKiUv8fDojhlo0h+KUrUgkwyG5HISS4IiSCuokseXrSPIDQz3MgqEQmthxoKIdmslLZRiXHwiiV3VxERkrKQrNC/x7fYIeWL024W4FsZO1Cw+pC9+7nQp/SWsbzrwn2JbTsPjmNc7SdPVN+DNpIQYCMGO5ENYYyyq/J+3QVaQ/+PjotZ2sHe4QXcd48jE+g8amDr30qSA06Ot5l6Nx12YULmzTQAtnEehKrStKl1hqA+Xsk1KwkBU56cNltWCXOvac4n+z3zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f12346e6-af95-40fa-b564-08dee44c9306
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 21:44:26.9804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IX5wzc2lN/eDqrp2h3FRwj08sbnUBvuTNhIFsG2VfZOLVFgEz+W+wkH9lk2LHE0EM50EXiBnmWvjzg+MspIriQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
X-OriginatorOrg: intel.com

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

The TDX attestation driver currently uses a fixed 128 KB Quote buffer
shared with the host VMM. This may be too small for Quotes using schemes
such as post-quantum cryptography (PQC), where larger certificate chains
can increase the Quote size significantly.

Allocate the Quote buffer based on the size reported by the TDX module
instead of always reserving a fixed-size buffer. This avoids wasting
memory on platforms that do not require larger Quotes. Older platforms
fall back to the default 128 KB buffer.

Because the Quote buffer must be physically contiguous, its size is
bound by the buddy allocator's maximum page order (4 MB), which should
be sufficient for current attestation needs.

struct tdx_quote_buf has a trailing flexible array, so use struct_size_t()
to calculate the buffer size.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Peter Fang <peter.fang@intel.com>
---
v2:
 - Use struct_size_t() instead of offsetof() to compute the buffer size. [Kiryl, Binbin]
 - Pass __GFP_NOWARN to alloc_pages_exact() so an oversized size fails quietly. [sashiko]
 - Reword the description to avoid implying Quotes can exceed the 4 MB limit. [Binbin]
 - Rename quote_data_size to quote_data_len. [Sathya]
 - Drop the Assisted-by tags, as the code was not written by AI.
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 55 ++++++++++++++++++-------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index d0303e31e816..ce2c2ef74676 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -162,7 +162,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
  * DICE-based attestation uses layered evidence that requires
  * larger Quote size (~100K).
  */
-#define GET_QUOTE_BUF_SIZE		SZ_128K
+#define GET_QUOTE_DEFAULT_BUF_SIZE	SZ_128K
 
 #define GET_QUOTE_CMD_VER		1
 
@@ -170,7 +170,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
 #define GET_QUOTE_SUCCESS		0
 #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
 
-#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
+#define TDX_QUOTE_BUF_LEN(n)		struct_size_t(struct tdx_quote_buf, data, n)
 
 /* struct tdx_quote_buf: Format of Quote request buffer.
  * @version: Quote format version, filled by TD.
@@ -191,8 +191,9 @@ struct tdx_quote_buf {
 	u8 data[];
 };
 
-/* Quote data buffer */
+/* Quote data buffer and length */
 static void *quote_data;
+static size_t quote_data_len;
 
 /* Lock to streamline quote requests */
 static DEFINE_MUTEX(quote_lock);
@@ -209,9 +210,8 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
 			     USER_SOCKPTR(req->tdreport));
 }
 
-static void free_quote_buf(void *buf)
+static void free_quote_buf(void *buf, size_t len)
 {
-	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
 	unsigned int count = len >> PAGE_SHIFT;
 
 	if (set_memory_encrypted((unsigned long)buf, count)) {
@@ -222,19 +222,44 @@ static void free_quote_buf(void *buf)
 	free_pages_exact(buf, len);
 }
 
-static void *alloc_quote_buf(void)
+static size_t get_quote_buf_size(void)
 {
-	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
-	unsigned int count = len >> PAGE_SHIFT;
+	size_t buf_size = GET_QUOTE_DEFAULT_BUF_SIZE;
+	u32 quote_size;
+
+	quote_size = tdx_get_max_quote_size();
+
+	if (quote_size)
+		/* Reported size does not include GetQuote header */
+		buf_size = TDX_QUOTE_BUF_LEN(quote_size);
+
+	return PAGE_ALIGN(buf_size);
+}
+
+static void *alloc_quote_buf(size_t *buflen)
+{
+	unsigned int count;
+	size_t len;
 	void *addr;
 
-	addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
+	len = get_quote_buf_size();
+
+	/*
+	 * This fails if the requested size exceeds the buddy allocator's
+	 * maximum order. Use __GFP_NOWARN since the size comes from the host
+	 * and should fail quietly rather than warn.
+	 */
+	addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN);
 	if (!addr)
 		return NULL;
 
+	count = len >> PAGE_SHIFT;
+
 	if (set_memory_decrypted((unsigned long)addr, count))
 		return NULL;
 
+	*buflen = len;
+
 	return addr;
 }
 
@@ -285,7 +310,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	if (desc->inblob_len != TDX_REPORTDATA_LEN)
 		return -EINVAL;
 
-	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
+	memset(quote_data, 0, quote_data_len);
 
 	/* Update Quote buffer header */
 	quote_buf->version = GET_QUOTE_CMD_VER;
@@ -296,7 +321,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	if (ret)
 		return ret;
 
-	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
+	err = tdx_hcall_get_quote(quote_data, quote_data_len);
 	if (err) {
 		pr_err("GetQuote hypercall failed, status:%llx\n", err);
 		return -EIO;
@@ -315,7 +340,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 
 	out_len = READ_ONCE(quote_buf->out_len);
 
-	if (out_len > TDX_QUOTE_MAX_LEN)
+	if (TDX_QUOTE_BUF_LEN(out_len) > quote_data_len)
 		return -EFBIG;
 
 	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
@@ -417,7 +442,7 @@ static int __init tdx_guest_init(void)
 	if (ret)
 		goto deinit_mr;
 
-	quote_data = alloc_quote_buf();
+	quote_data = alloc_quote_buf(&quote_data_len);
 	if (!quote_data) {
 		pr_err("Failed to allocate Quote buffer\n");
 		ret = -ENOMEM;
@@ -431,7 +456,7 @@ static int __init tdx_guest_init(void)
 	return 0;
 
 free_quote:
-	free_quote_buf(quote_data);
+	free_quote_buf(quote_data, quote_data_len);
 free_misc:
 	misc_deregister(&tdx_misc_dev);
 deinit_mr:
@@ -444,7 +469,7 @@ module_init(tdx_guest_init);
 static void __exit tdx_guest_exit(void)
 {
 	tsm_report_unregister(&tdx_tsm_ops);
-	free_quote_buf(quote_data);
+	free_quote_buf(quote_data, quote_data_len);
 	misc_deregister(&tdx_misc_dev);
 	tdx_mr_deinit(tdx_attr_groups[0]);
 }
-- 
2.53.0

