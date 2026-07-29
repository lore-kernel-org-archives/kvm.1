Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F7A47ECCB;
	Wed, 29 Jul 2026 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328228; cv=fail; b=lh03ywhnkdyAQX8RDQ4lV4iuoOawhkGcvN2zSNpMgNMB2wjrdCJIrUvJgR9G/4h5pps1snTIrTITjBN2Wcvp79Sgf2PzegK8VKwRWRvdkhqM9JCARYzQUfDyArg5HWJHExqxuOaD/gsfxLsnIOQm2c7D/c0X3a51MsyOZjmbBkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328228; c=relaxed/simple;
	bh=f03+lV3/7m1Y/6/2hKXuTclsegEFkBk/CPNaKBT33hQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rYz1Su6HNlSxGLGyCZzQ9WXWlHTMOnWR08O1/tfwFSxBBa3gTB1zOvGw5v6EYtwvh8iox34XWodt7AxWXzWq5JkUY9zWTmOtcuD3MxkH91JE9BdSiBUmuE1F8m6Dw2x5uXoTxddiHK2k4grLj/XPwa+s+z6rWNWWtz3p9dRQsfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BW+yrPKI; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BW+yrPKI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785328224; x=1816864224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=f03+lV3/7m1Y/6/2hKXuTclsegEFkBk/CPNaKBT33hQ=;
  b=BW+yrPKIRHAQ66h7C6xh50mpf8C48sZ49rB/va8AzG5mfstIN3YsKyt9
   4W3w95StWUBz37eeXFijStntArngBl+d4pX4bFd9PDLcrcf5fiEefznvc
   7WPqvS+VaXtGTAH5CPwPb11Cm7hX2ACH1OlbXzwOFwSlRe19eFhcdldB0
   RA9WBifNptJIHBvBiAMABSJihWhEvn7W+JHVI+xQnPMLQ8FQseZleHiY7
   1Gy8xjx8VznibnF5gGkSYkU5qD81KwPiJVda+cE91kTeyCplU9cv9Gaac
   bmnNnhtIgMDNFY5e+ZMDC66W8r0DV0f5JBpH1lEOKZAIiIb7i+FlfI0FF
   g==;
X-CSE-ConnectionGUID: uovEHsI+TM+FcQ+sgdwTdQ==
X-CSE-MsgGUID: vD+I9KIrScqCcsvz9W09Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="84908605"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="84908605"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 05:30:22 -0700
X-CSE-ConnectionGUID: BM3wlvCbQEahSwh3vVMndw==
X-CSE-MsgGUID: YpG96cWxQTSHEFEuQHNnpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="253654898"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 05:30:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 05:30:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 05:30:21 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 05:30:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSOItk2q4eBtqIOhPqMG+aYrcY++m2VbvPFNDxeHZ7LU9p+25XauJRSxdPdgxDJaJmbb+pUIMVbOcr9SJsbp1u0jZWh8uBJlPtVWeRszLgP57mUoI/h8BMaCvm0/ZTvW6ExYfrIVJ3zHF6cbm9nR7A/fLAvbqfyHqWgCXQzkGfkGNB1Ut+f9SttrCdNCdP6TeDBUnHoPncA77P7s1BXyyV8yZiorNe1M5w9feppLJkutxn3OOe5j0zhGWyDhMcYzhzBPFIbdOpjFu2P6jUj99pPv5zD0n9oeyIdlCgVHQt90kLn2W9pZOMvwD3ERVQBR4bU6SSkqWWYPjIaPJqhKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRSoGpQ8dVSVquzwCKv0B7t33dHWttN6oogbCEijuMY=;
 b=lCqpiPDBPZ1U0Pd9w1sZrMQfOLI1Z6A0V/xnTgKem/NsQfO8sfmwD7hDTBOCKPb08FLcdDZ89Ucvodql022GiAQbOrwpx1fginObyqWcxq7hZ9SSKcrLb4m0NjZe8semx7YCYAGBtf1Lh30WvmHF52atAJdb5EggwvSiR8Y1ipd9AxOwcMi3nKQDKMDHHwce9ecuP/ImJQHNTFNDTCd02/Slh1txWfgU4COa+2RKVFuqBTxdFC3BAbgsgEJlYbBG3eWI44DkixIO+rfEvMUCsiyXHQOzG8sGo4aDdxm/qq6buWlmseAcIJhrDpHdG/T/rSayCdEoYLKa41p0MWxfCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by DS0PR11MB7622.namprd11.prod.outlook.com (2603:10b6:8:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 12:30:18 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 12:30:18 +0000
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
Subject: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the Quote buffer size
Date: Wed, 29 Jul 2026 05:29:33 -0700
Message-ID: <20260729122939.1340412-4-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 78cab085-de31-43d0-b085-08deed6d21d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: X9FiO69ucSNakrdPsnq/gDaM/TzT/RC/8z6JR6146ER5EWHu+facuoLPxrdGVQxWIGNcX2HJLBJjYO19khBm92kxiN+Q45g8jXBgNJ+trFDuP+XRrlxvDL4j+dLImyhSZAs8el98uuGc0JAfBMYxmaaTWYCpcmfQFwToxf95RoubFnpE5vEiJZ39/hiOTjpfYlnfYfPEKMUjlnzh1sq0wQo7dKvBfwoqx0s3k5Bq36DDNFvWLevMbhqG2A5tuGso+GmCBhcj5/98xYNnCiY6VMHSoeSZqEnYMuwe5/c6YQex8SNnStu1dHDtTA2PZMFnJvm30r6T1SeqLQIONrU/tddDIF23ge9Wc0fKMKrtkN36m6AXP1XWHOJ1foTTseS7n61ZTAG0OCwdgusot97uMJhYx4gDYxPzd8GgAoJI5rCzhy9TMxwRMP4Jc0+ahQtxlagbWRp3wv0ZMQs4HfIGuntwKbYbr3Bas3z4qpS2sD1tz559/gtf5aIh9x3Cnak8YilJf89fvfv4qeXjTjSbFzCfJeu3mnu8Xd2PSMXsbgWBobcqMctVBoCsfdJbQpauRWkywKm6WTtk2i9nPDFOQ7X7VFhStuPq9MWpwV16h+Ox9vmYKLK7rG4ajkvDgIoeWcagA30Wmwsd8THHirdYYyQZbzatsa+K/rG2pw+aQ1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/EDzbOh0mCB7DYk1TzTMyWPAsyK5YGHAb0TjkD+dVH3MPvsxb0AV5WaYCWDl?=
 =?us-ascii?Q?CiRSHrwgHENSRwLnCE84KiLQIw7SoBWk8lJRVdahelMi0McjJu2yl3WMLCO4?=
 =?us-ascii?Q?9WoBGFExhD7Stsw8gzQvNHZTiOp/8wMvos9sOYqq1aHxcm2RAzF9JV08hc6I?=
 =?us-ascii?Q?q2HxVwn2q6ABh45Pw7cseA3ls9BpS2woy8huV8djanLgMiQFWhbopna6ZQTx?=
 =?us-ascii?Q?tYKLR4B0a58N+lRr+tFFOXZgtBruKuWrM8rJocqj9Y5SXAFCMC/m7Ae2KL5p?=
 =?us-ascii?Q?5H5K/BCiPkppB+liDfOUID4O6sCR4q7ajsvkzLwXPgXozzsa/EZRr2jXVBul?=
 =?us-ascii?Q?gvXFy81Ywo3wBXPcfcgu+H6Gbwl9uBV0HsUa+skmVc97aEaG8B+nQLg84fS5?=
 =?us-ascii?Q?rpSnxxrUfzW18ulMwHMMsaX8se/VAcUHiBpYUTckoM28Fk1SpvMiBLQqEnK0?=
 =?us-ascii?Q?9RCQMrw2BoGEEKwgsoXI4ztmZgHaWL7PRIvntAchpLXBSNV4zdNaU569UDWN?=
 =?us-ascii?Q?q+/pCoPRaGMOwd2SD4bOBmb68Q/QUu1DPVR3ln3DIqZ7gHrtaLngM4YWLAkS?=
 =?us-ascii?Q?os7OSx6T2j+2yinpGgXVjBXwb8ZyGv1tfReq6JLySugSJ5AnM/0I8ipAfOY4?=
 =?us-ascii?Q?MLOaO3rcYD6wag3OqZyZYZj3CWtnytcTfFeW8QGBIVy6PP0c+wZioilUZtmg?=
 =?us-ascii?Q?PWqji/b+JXTso99lyxR1Tlnc9zxp7UuViNkBg2J5jV2NYviJaIQ37RJyg9Qh?=
 =?us-ascii?Q?+YEFHK4if6LVkzlmHNt2FfMf7sFkyI2NfNCk+BLi8BaP4KBbMDqAcWW1QTqX?=
 =?us-ascii?Q?unMy1sl6X+UP8C908VIwi/GUZMsYZRDraA0HMgflmQx0FszilXBhd882SI1r?=
 =?us-ascii?Q?nDheK1AQgEllPzXEIUdMoOAYWxBC0amoh+9b4mD0f0c64ao6AudjfmYHNtaW?=
 =?us-ascii?Q?uelaY8JGXguRoxPtRyE2BKuFZ/K8VLY7AIdz9k1KoNKTCeQJGzJvNyh7pOdE?=
 =?us-ascii?Q?GNcJC7nzjmPoEAY2MaCf0Kbpg3HPtOruL8ykbaE/wBDXyXcSZHzkcQgG3OK5?=
 =?us-ascii?Q?Od1DsPgb6XNLHE8eOHEQZmiRdUG1wtBGWg7eBIDzaQwImKD1dzVE93GyDTt2?=
 =?us-ascii?Q?89uyUHlWRcsPoXXmrvwFTRDVZ/HF7ocmzHB6uotwQRLFBmWD+saTPS7AjjUv?=
 =?us-ascii?Q?EozxKwN8VWLOCgxPIcgyPbcXEmAzh0X3y17iFKfjwmTY5usqQVuu7fz2MSQx?=
 =?us-ascii?Q?/cgUzYafRidXjcOp+Q5nC1jSZuCPo8bJEXpWtzj4S5WKS0bSpL8uVpFoyV0w?=
 =?us-ascii?Q?4d8tnRY3PCznb2g9CXL8TNTFh3hilpTZXjOYiTcn+OljOToGOaBpCKWLPxs1?=
 =?us-ascii?Q?LoERUxutrbItwADFQzHGKFV1Y3xZMcMOKfYd3TchX+O/ZucVoJFURR6au/Ik?=
 =?us-ascii?Q?Q5PAOgcQspz8qbVmz0EkbqIqNpUucEyTlEvMdUbbbFJYzBN6vROWB3mi8Cpy?=
 =?us-ascii?Q?2eGovgkKIo0aUNYgAnyDpTfmqNQ208wC1Nwc2a7itKaFM6AfNyYrlb+4XKyX?=
 =?us-ascii?Q?G62N3LMjg9OcdQB8x85ttVIM+hpjmPSgR9dROIaSJcVW6rWgnCvb32an5UNp?=
 =?us-ascii?Q?z5PJZGNjaVCNVkOc/kVUJvqfSyR68d8VW5HAlQzlIlhfxM20SMT3NXf9puKe?=
 =?us-ascii?Q?cSzORxLMnx0jpADBm8w8BfMvJigc4n1eAkB/tkSo/IglHa8cfP5AD4ZDnwMc?=
 =?us-ascii?Q?X1hHYRvNyQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: DXtbFOY1V13ekrvQXV/XtpIgqrtauhDlxKg7PWUTu+2X7ZR0vC4KSmQgj6PY1bAsVb2VqDfp0YGA0uItjjt60OM5be78dqmM9Mcjjx0MapJEzieIcC3ooD51XqytJKTa5vQR5z7f8qFN1wO+dWLzhgaqr3QAjl6rqlFQDxgAg0vYGJwM+//fKkWg3Tz6VVkk5Aux+LNdblGbZJAUHeCC8yQJAvZnxeDAI6MnDE5IZQeovO4W2lDe+Ejw4z7FY3MzJ0vUj3yfZQRFVzFmvGyawsId05UXqr9n/jyC1EaSMejFZ+EP4oMsy7o01uP6XN2RoKF8LAYpsqWW8425lPkTyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cab085-de31-43d0-b085-08deed6d21d4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:30:10.9822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrnhkDy0a0rcpvBL4SLR5j8eueSleDH/aEkN90+oat8In33krGLVZRlBIGGhVcmd2CO9X9H2PGjMzpUq0zZlNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
X-OriginatorOrg: intel.com

In preparation for dynamic Quote buffer sizes, replace the fixed size
constant with a variable.

The size is currently a constant sprinkled across several places. Store
it in a variable and have all the users read it from there.

Signed-off-by: Peter Fang <peter.fang@intel.com>
---
v3:
 - Split out using a variable for the buffer size from the v2 "Allocate
   Quote buffer dynamically" patch to refactor first. [Dave]
 - Pass the buffer size into alloc_quote_buf() by value. [Dave]
 - Drop the Reviewed-by tags from v2 (Kiryl, Binbin) as the patch was
   reworked.
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index f47c5429d002..3d3f79ab45af 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
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
@@ -222,9 +222,8 @@ static void free_quote_buf(void *buf)
 	free_pages_exact(buf, len);
 }
 
-static void *alloc_quote_buf(void)
+static void *alloc_quote_buf(size_t len)
 {
-	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
 	unsigned int count = len >> PAGE_SHIFT;
 	void *addr;
 
@@ -285,7 +284,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	if (desc->inblob_len != TDX_REPORTDATA_LEN)
 		return -EINVAL;
 
-	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
+	memset(quote_data, 0, quote_data_len);
 
 	/* Update Quote buffer header */
 	quote_buf->version = GET_QUOTE_CMD_VER;
@@ -296,7 +295,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	if (ret)
 		return ret;
 
-	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
+	err = tdx_hcall_get_quote(quote_data, quote_data_len);
 	if (err) {
 		pr_err("GetQuote hypercall failed, status:%llx\n", err);
 		return -EIO;
@@ -315,7 +314,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 
 	out_len = READ_ONCE(quote_buf->out_len);
 
-	if (TDX_QUOTE_BUF_LEN(out_len) > GET_QUOTE_BUF_SIZE)
+	if (TDX_QUOTE_BUF_LEN(out_len) > quote_data_len)
 		return -EFBIG;
 
 	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
@@ -417,7 +416,8 @@ static int __init tdx_guest_init(void)
 	if (ret)
 		goto deinit_mr;
 
-	quote_data = alloc_quote_buf();
+	quote_data_len = GET_QUOTE_BUF_SIZE;
+	quote_data = alloc_quote_buf(quote_data_len);
 	if (!quote_data) {
 		pr_err("Failed to allocate Quote buffer\n");
 		ret = -ENOMEM;
@@ -431,7 +431,7 @@ static int __init tdx_guest_init(void)
 	return 0;
 
 free_quote:
-	free_quote_buf(quote_data);
+	free_quote_buf(quote_data, quote_data_len);
 free_misc:
 	misc_deregister(&tdx_misc_dev);
 deinit_mr:
@@ -444,7 +444,7 @@ module_init(tdx_guest_init);
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

