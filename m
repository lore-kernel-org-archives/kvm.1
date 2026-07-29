Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF6D47DFB6;
	Wed, 29 Jul 2026 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328228; cv=fail; b=AorMqAkIpCIm3VUenWq9tiMn6/qfMv7JtNdPd0jjvnwS7hrMobmYqBXNuC9X1MY3dZ798fHgdSFfIRv+Pp4Owe5Mky7q14FiEwf9ncKcJ8ZDz/ystG+avRQrNtvnSFf+ZDOHb8GlE8cyJsbSN3vQ8rhNVV//telRoQOr0XbG62s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328228; c=relaxed/simple;
	bh=B6DQcpvtBKDOhH53snVKMx0ZI72kopkVPUIT6QUrnjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kKjjUFW/7UveKGqHveCFIyMoSxRgAKIA0BJmDMCxuC79Jq9NAYOWhZ6NpIuOj4Q/+ltanH/iHrfLhlA092de5IH9+pP3pmZ6WrLAO9u37GoMQKQ1FCG+dhvrv2dfcF6EosnqdJtAsvtamTsFtZOA9Sku2XN0z7rRDj4MPlkx8yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJ5i+9RE; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJ5i+9RE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785328224; x=1816864224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=B6DQcpvtBKDOhH53snVKMx0ZI72kopkVPUIT6QUrnjM=;
  b=oJ5i+9RETDEre2SxctdSnGU4Jt06VtKIhh1cEp3UyyYrLnig+sFSmiY6
   cAYO34Mzs+yyjd9ZN235VCFKkBn9bz3jgoapf19Wc0Be0nBRgJ0dnrIzW
   AWAsR0ZnYWYDqRTjYpWgj5yITwnuQqXWm8ypbV0csQwIrlZk3s7UCS9fI
   D/a8QbkaCfDxGLqshiTUZvLdWc3tD0zr/Aqrc7HpE1tYxVHERqBGCnh3Z
   BLMjNwPe+WH63D+Nqp/TeYYVMNXA+aR76rIZoMyXx4vdzS2T/2NIHmBYa
   QuWqMmyUeBfaSPCuwdp7YnORoNJWz31jxo8pUWuiaG656Z7X3Vr3aAsuS
   g==;
X-CSE-ConnectionGUID: vmlpZcj6QvOmirxEO4NotA==
X-CSE-MsgGUID: pX3p4IIkTXmDxf46Z5NpPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85970240"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="85970240"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 05:30:21 -0700
X-CSE-ConnectionGUID: mBupOWdvSmSRjMpcdo0rNw==
X-CSE-MsgGUID: 1DbR/Kr/S/uZWVjl2LUIMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="260056841"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 05:30:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 05:30:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 05:30:20 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 05:30:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/tYOeXdHyx/Og8Uw7w4xB1QpiRvE0W0aj3/rJGznx9Y0S0+H0vFdPhWtyK0pOYDeo9p22T61nLs0qQ8KZgug1WIkYO//B37ygUBpGo3aLpmaCYde9nNlMuUJzRtGrZlJxiKUiTb/Wwy8CjmZXFpqRGOVoKNn/v5s5hnIZIrsfka/zagWypiEhl0PMKi+TpFHaaDwsjGJB34tKNmLR3pNfh5yywWuKP53SWmu0q+k0PXfAz0MFfLQVx5blo5Iq9kXoHYsAFLXs+Ovo2/9Cuev6H4xc/b4fFQl1K6N1/GnDpnhTYBuyIjQkRzXSEnIuE+NH/xArc/XPtF/gsNa7X2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBZxmK98hMradjdcRgzA5dscOpBXkjV2NL1OfLI6f6Q=;
 b=rXFKJvGUxBXKuNa40JOEkFVbCKtRYjkocuE1Mt4Lp44QsGJpRV4exvTYrzf9tpgI5AgKZifdM870YTQo61nynCzm9dpQ3/OyfEi9npQ0nCq+4oze87eMRPbA/tnsh5VBPQxj04y/+TLX2U51P3f6YGAUyxdfTnX+o9UyH9OgUu/jO58oVS4MRhVCZ7Mg+/nJHx8LsAp9a3m+zNEFd9+dP21bgeRTVwKtWjYTuSCfJgsZxo03H4ztABCsanJqZKkFosQN5PPUcNJ+UZa2NOl5hOD64I9Bv9EiNFCIYzGYdnUpgsMi6OS9ErX/u9kA709UTiMtiYT/lhOCyH1JmmHrgQ==
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
 12:30:15 +0000
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
Subject: [PATCH v3 1/4] x86/tdx: Add helper to query maximum TD Quote size
Date: Wed, 29 Jul 2026 05:29:31 -0700
Message-ID: <20260729122939.1340412-2-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 94add149-eeb4-4d8c-e8f1-08deed6d2112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oKJgaC0s0noFLu4WBBguf+W2q82Ebc6IRAVd/MYGI65JmCbvRLxWrYyscd12GFBvvbSmcUA9YAlV5CqDik77wP/YWs7H8E2P1pobxvV57wlaid1O1+qfRcJdEgKBv27s1Frt2w1FsUBvK5XXRw7/uKFss3zCHGjG0kPXaguogCcdD+QygL0mh7Tdk/HhznLFRdAONojlbhAVWiii4uzvpVsu5vvHbkch6ohiOwPqOPVaVzXig5TuaN5rnAitR0EGrp97nwcRihRCHyF2+zcoxh/sSKGexL8soGlrab0ktxtjcY25Dttpgw8ZukDNDjM2syC50Z8pSXjjY59CHtOF0JXFBWZ0nXfXnqxw70YYsl+JUf3YtSt6ydOn5T1oUQNmJnhqjMeK6BKCbGk2V30XQIyPUzpY1dUqsQnNb5Fr3KtVpOD6fRyFW8OZcqQW7kEN9DzcxLt4m9sGx8NUzLQqIK3lzz/PPV4B8xYlp5dyW35Sisshpxa40B/Klz0r/rTSob0Kzd/PixTBioXrCJQRHGcJsCkC1ohuXoyuXJUTL3HDXyUvO74hCW4AZs/NWjwoQtagYSSNsj5hpAqahpLtDM+gzKaK12WLWqLAUILoocmkn8/kFICgYkQS+LbZIMIJaNgEC45GNOGHpYSgZi066GIKqwhcUuEZFbM98yeWv58=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?flwRyKf1vGCl14z03yVMLDtJv+pisYloeepQhH8Yil6EOvNvq7xpbz4qW34c?=
 =?us-ascii?Q?CUv5wkX8dOJaHkmHMqJNbo1j5Rv5Att2BxX/2Jx0XWbS1vcfh4RbWNyBs73i?=
 =?us-ascii?Q?Dil0zDe72jrQuOBP0l86kCHURVoeyuewHTaQEUEj2Tjm2vWUIAP3FQ/ZerZe?=
 =?us-ascii?Q?AuhNty74O5Q8Bp/W5/3/dcFagzyKalOoYfkmsIhrNKel0ryHVdSToZbP519R?=
 =?us-ascii?Q?z/a54PZmB98wu8F0vjUak9ghdPIrc4WxOvZhvlzaRF5NFbse3WdT9sIZzbEy?=
 =?us-ascii?Q?H9SBrDdDm6zHMrSgDUPCsCjr0cO4N9AI32xyEQcTMZAOgl6LvX1G+ynVp5pr?=
 =?us-ascii?Q?Dzx86sUw2jpOQdU0hwhTxQ/1t8Kc225RnKUP6dDe8SEiDaAprrDxLlDPmyI/?=
 =?us-ascii?Q?RwsRLi0CzdH8WrrQ+fgRMrdIgsQRoUq0UacxE7fD2xBjLROThRE9lwBpgQNM?=
 =?us-ascii?Q?PB4c7lB8iRCJisGrGJ+vOGk/4yuSKvos8CVB+/iNA49sNFhK6fnIywQMQtmu?=
 =?us-ascii?Q?W4CXP6HCM5YrVyiOKk8vrgRrTnaXswPNsrdfL54O02ETlk5NHTToaiDfwvC6?=
 =?us-ascii?Q?l5pr/1gS2cwoiSpORVNymZgov2HgGBC5hV6EUUCcWin/wyV62pLHHUrAMhJj?=
 =?us-ascii?Q?+JqjYETyPh0PE06HYpBZEL0Pz98TSC84BBpAYPuyzG/AstnR6EwB2rkynvfq?=
 =?us-ascii?Q?vPidYFM7ZmoW7X2Tbu/ybXRfmg7qwQDZFVjhvNXnDPMSd7TdZ8SgIzhxir4j?=
 =?us-ascii?Q?H98n1uFdeyJ6Eb1dVU0ONy01Cixoh/1zoqvYUD6l5Bkk22hi0p9Hu8XEnmZd?=
 =?us-ascii?Q?EHsKeu4ARfTRjKK4TgGAchwGde1D/MxeIQCkGQch8E8LqK+KnmxpNgWWCGRK?=
 =?us-ascii?Q?u2RZtUQKM0wnGVYhCOfiI6HlxJ/48OY3GxyLI4HCz7iEaZ8Xq+T2Ew1ZjaaF?=
 =?us-ascii?Q?rueZm3zG6e4A4NJhNdyNJedsqpOfHFL67rwQKLYzTDKXYrjiHSIgGNms5G6a?=
 =?us-ascii?Q?hXm7i8PUhn1ebkOXASMYdwWcIvRI813Xqjd6JBxl2eUNpKxP4FdiNGimt/7H?=
 =?us-ascii?Q?jUa3IcvDjid1cs6wYtQNl69SA2iEiBRyGu+RyxIokjZhFl8zLgMXZ9c29iDW?=
 =?us-ascii?Q?nnu43FM8/JrEkN87HH1iLXl+nIXrLWPNwEKj0w83qUVb6HPG6+ZeinFmxBtU?=
 =?us-ascii?Q?uXcXJ8f2ybiLlpIULm6DjgruuXEfcId6UNpBuoGzByrE4yRZK5mbciBNF5Mr?=
 =?us-ascii?Q?mdWb9ECuA1xEPgDNCoRVtMVkLQyRwKzw9AImUBWq0taLwaq1q33XDIDbVc9S?=
 =?us-ascii?Q?BB6P4bLFJNDUTlyyqUG/GeQoLPzz+bfMEdS4znvLrDjsQNK+uiizfQYbY6XX?=
 =?us-ascii?Q?fBVgSAqTZV46MytYchAocFdl0xuNnjKASoga3sFguYHUYv4R5o1/Dvpc51RX?=
 =?us-ascii?Q?G2J0DwgNLBLbRGp3tZyOAz+oOnfsfiqgOgPgkqpSdAWyPiA6+ScB4k+QKySu?=
 =?us-ascii?Q?OlpwrWcfGBrZuzrOVlOYMZTQcio+jIzXPgSfWqRuRQqdzRqtaYv3wG6onY/v?=
 =?us-ascii?Q?GAET2j2DA2Akl4k/H4VtAb7XEDtOUrlr0g1NkJtwDrpvh8VSgM90oJ5KZzz/?=
 =?us-ascii?Q?JHizdQoHsL7OOxaLrxTfbCHFhHcdnbe5Tv32n+Pp0RHQXtXyPTxvbJEf3lET?=
 =?us-ascii?Q?mfrzsbgjQ76fEjTaItJZOOpfvtmTVc6+gO25YHonwK8KFEH3j2InVKFMwASQ?=
 =?us-ascii?Q?PCIqa80VBw=3D=3D?=
X-Exchange-RoutingPolicyChecked: LyzAfKXpGM+x+xK/nDMIBSJtMVL6YdZsOLy1EbyBLLY/vKlnMLMUGWSAvOiXcM9amp4fEUXNIyS1u1rmsbX53oAO+u8lam6hrNDmJPZl6YKqa7uhtXfD429T2kYRUwT7XVqUkOY9AazRKImZ2TlQQaLPRx3bRV6EBCEFNNvfLaD0YrZx9I4CT3LxNiiZFbpHapPg6RnlMfhGZxPmNrH4HMHuJwP0c+nshfR6oVPvqk2hX3EbwJ0qE/Bf24xNPOpIygyNN4O92eWFuGpI8E48DwKSt5fQ1LkNLEXymG7gxC1D9UQ7UVCMinw/ZAgLKtwHksEdGFGosuEme6CtAiwxyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 94add149-eeb4-4d8c-e8f1-08deed6d2112
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:30:09.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqvFKyqYd5CpP3kWbf2ggppj7hu9J0SggS+8Scq5++SThaJ73RriLPgdRv8xolwN2UWNDH6ka2fRm/EWmI3eGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
X-OriginatorOrg: intel.com

TDX attestation report ("Quote") sizes can grow with newer cryptographic
schemes, so guests can no longer rely on a fixed-size buffer for the
Quote.

Newer TDX modules report the maximum Quote size via a TD-scope metadata
field. Add a helper to query the size instead of exposing tdg_vm_rd()
directly, as it can read arbitrary metadata fields.

Thanks to Xu Yilun for suggesting this in an off-list discussion.

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Peter Fang <peter.fang@intel.com>
---
v3:
 - No code changes. Add Binbin's Reviewed-by.
v2:
 - Keep the explicit (u32) cast to document the metadata field width.
   [Binbin]
 - Note that Xu Yilun's suggestion was made in an off-list discussion.
   [Sathya]
 - Drop the Assisted-by tags, as the code was not written by AI.
---
 arch/x86/coco/tdx/tdx.c           | 19 +++++++++++++++++++
 arch/x86/include/asm/shared/tdx.h |  1 +
 arch/x86/include/asm/tdx.h        |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 29b6f1ed59ec..fa2ed012e736 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -198,6 +198,25 @@ u64 tdx_hcall_get_quote(u8 *buf, size_t size)
 }
 EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
+/**
+ * tdx_get_max_quote_size() - Get the maximum TD Quote size
+ *
+ * Read the maximum size of a TD Quote from a 4-byte TD metadata field. The TDX
+ * guest driver uses it to size the buffer for Quote retrieval. Older TDX
+ * modules do not support this field and return an error.
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
index f20e91d7ac35..a58751321613 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -50,6 +50,7 @@
 /* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
 #define TDCS_CONFIG_FLAGS		0x1110000300000016
 #define TDCS_TD_CTLS			0x1110000300000017
+#define TDCS_QUOTE_MAX_SIZE		0x9010000200000008
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

