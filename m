Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B91A9B58;
	Wed, 29 Jul 2026 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328230; cv=fail; b=AU88C6rExg/xqvN6HNZpBkl6Hgpw+/71I12Q0AYe6L3CLEJiiR3qMzYHwBeRop8FwYLnEnKnUWWgvGyWc12lRbhx7JIl25O/ZbKU8wGqFjQl3W+JEhpi0/iNaR7y1St69saTKT2FV5zuzHUXzvykvwLM7rvMt5k0j+L5qnHVNBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328230; c=relaxed/simple;
	bh=Nvy8a4HpCbVfx0MN780IWHih9Q/bpQZegSIpBt0kMM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dFVjXygw5IioVGJKx7+P7FvxxABJfiNhJO6m89AofvNHMcb0q/muEjDpnYUKbwH60jHZxv9z6VzklPLgRr57HJfWfUpBSf/OeJc57eNY0NqJ3pRrX64xVa1jJPCBPMlLl6EbKyw+K6aYvJU3Omd8uGoaZDRhYHCI4pN9eCIOHeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfE1UeGW; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfE1UeGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785328226; x=1816864226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Nvy8a4HpCbVfx0MN780IWHih9Q/bpQZegSIpBt0kMM8=;
  b=hfE1UeGWoCxJblipBW/sP63iAbNPs2tqd3r/R5NmQZQQlu14Df9OTeSb
   dtXv17T/1eFIWj5KfqudZaJHne246vPoP315mbjh/KHs3sDIQYPBVUVNs
   hZnetPFsyi24Z/BkN5OIe7T2j6iYKwbHqHrZowlTqTzcPbVq9JlOGkXN1
   JsNLNrnj0HaLTsN/gkSiKUEsSTkiucd7wqkxiuSytc2Ofz982NWc7B0ny
   DTnPBbLnoqi9dY1m/O0fzY2DD7USg5HkY0UYR/+cwygYdIQz9sfGYCLXi
   jVwKcjpOEMIGTMKWqEecln5OFyWoj5ZfDNIf/LkjRj9OzCXAPd2MI/vAk
   A==;
X-CSE-ConnectionGUID: x+aUEUjiRV+5QEFBvNpR6A==
X-CSE-MsgGUID: lcNyXOPlQauBguWXTDQEXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="88471306"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="88471306"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 05:30:23 -0700
X-CSE-ConnectionGUID: byGoWisBTy2yq1c11Dg5nA==
X-CSE-MsgGUID: 2hPAYmLGQQqB4g/Dw1VddA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="256668820"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 05:30:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 05:30:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 05:30:22 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 05:30:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJ4IT4StUjn6XPw7DQd4XcAk8O/02Ai+xPuilJPdqEsYd1gJSfzoxBw+S4D8svyvsuurOtQ/LDsg+gycUat5mtSAAumYLozQEAxfRhMD9RvMtzTV68fGH4n5M4T9OKdIoZRhdBZlQqr/q59hHZtIyFoBsuU54RXkUj0MBWpv3gSWqgO4SG5kT9/asGw1DkE67Nf0ohS77S2dW/IJNZPXILOEl8+HtH9iCArSp6t310f1zJdWJV1o+YLd2efydcaZ7ZzNKoF5/R/Tc65YTDXpScePV/EgVQgi7HokLUv9+wzFJXTTU5Ht6KNhyuCDFwimkhqLoPw2uLN39YABR2Vctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8X3xkrsMweRb2vgwZLJEIyTJcOhDLxvQfTvPArZHHM=;
 b=HhGcaaR7Qk+NCj4+zqzjAcfDuHz+3jo9QdkyiDYFjjcOM1pkK95oUOeou/Rnb2RkAu3SIskD6D8k9B1xUrsNIReBbpQIx1G6ahzuxFw+Wj4Ue/tWBbY491JpSBgCkieud7oJwvEr476/x104t9DqQ2gJzfPRgKA/TKTUfjUY9IDlzf/5rb6WvzTmrUoy6xeUsEVuRxnuqt61tWhlbjYyoKRVDLXYl6avi4tJ4maln3AY0pevxxFLaQx9K6MQ8u3ooji5P5hwin3vCiXf0UZdg3foOwy39QQqMIVo3WCKzmwk7I1Q7nvRnMW5NQbnc/FevV/L04sYIHtZCZHjWf8B4w==
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
Subject: [PATCH v3 4/4] virt: tdx-guest: Allocate Quote buffer dynamically
Date: Wed, 29 Jul 2026 05:29:34 -0700
Message-ID: <20260729122939.1340412-5-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9a36911e-395c-469a-bc35-08deed6d2235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vwNHJxgO3QfUrH73l+n8Gmp+FytkpbFEXXQ6vH6o9J1AlvjTGtLOF/ug2nbAUnAkLw6rKm7gjnyVIYvhreBibe0wAhlXT/lPeu7ATWssZBzbbNwkqyBGTNrxojNtFFURY7lpgcUm5Mf6HKmv1jBnK9FBgQu+YVPS8Y4eb8DigNDA9PWupRNMKz8pHW8T3HWtvSWVV4u1qb0xJnAx4kW3m2pcM/xnsptbHXCbIljXHd58Mgr708RBDH4y25mcNpHgJorOd6z+5v8zokyF/ns15s3+5gFnmNvTOz9PHyt9BDmHOioqyvZ7FcolFueEKh6Fkf3GGeiO9gDrR/G/xznuW3zrimuKt2JeIgbZGObZQkXC6H9cxdCFbFKRhz6xL3fAyciyDyw676vOK/EVsOb7KLIJfycFnfpPp0qbm4XJlJx1xm8MDRzoVT2IGv7IvJzSe/2YnBPZbM+NvNPywddwGOzUb0qBPCTbS1JtpnsQ0MzxtNdkvLQz0/BJbtAuyma+07bYG4K3urF9lP0c6cKyxoHSwFv5gbEuu93qBhrQc9tJJ1nrDnFidQkG+N/pZMObU3MTsoRxuUVCNPjWlHD5DXCt3LJ4637p2Vo5DFY59MXk+tqvK+tFVp0yWTqdrJzv0Rvt9AKMf3wKvnN50dT1EUcYxUppgbi3Qiu6j/lOnOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XcixQ3Wl2sBLDILhMdWsfQatzaJS3QPVL7wZvw5LfVq2B4+cwXpC2f3vOF5S?=
 =?us-ascii?Q?b/qaJxAu+8YWu3bTscIYZY39NGkqGp8S3Gt+w3ud1ZupuSRqIpKTGQg68s8a?=
 =?us-ascii?Q?CPF8ny9uJN2Rr38EayPnaGrJ8OLsScM9GKum/Ge76UbrbKeRryyMll+TMrzb?=
 =?us-ascii?Q?xcQoQGqoDSj6hYQlmQMQnjUzRU9WCwKq9te/Fqk0Y8XB0BvyW8b7qa/zFo+I?=
 =?us-ascii?Q?wAMjLiqqlzWgtmH5miWW06apmR6ocDQ0XubTyW2XO6DHYHVB6P6l0GBxWfQR?=
 =?us-ascii?Q?8tjrbcqUUiwGOvgYFsyrw72nPcNMgyzQnRCPY3NCL0dndZMl4l8dWmmZFBSt?=
 =?us-ascii?Q?W2+bEA4wKSbx8PwcvOx6E3kGd5W/O3KSxMRKhIxbW07qJwsHGcNuVkQFbjZ5?=
 =?us-ascii?Q?vNYwEIvt4g0o4C6tYDCAP2X28KDjn1C7UQwV49e1AOEn+boiH9rYHRA4bmip?=
 =?us-ascii?Q?Uv9AtrW99HwSt29LDK/OYWTObTn5cLBthPDBV77tjC7+ealzVKDD4/ZROJtd?=
 =?us-ascii?Q?O0EnJg4uRnJ4L7pIRkIrE1NcDar/eTrdRYn+jLf7CPm6TlLatmyL9xLZmj2r?=
 =?us-ascii?Q?Ic5kUBK8JhFOsYEH403fQsXzTdQufH+z/b6n+W61VNgI9nKofCz+96Hz0DnU?=
 =?us-ascii?Q?Ns9eMBBaMpnvydoDw3kd2t+Ny9UThyxvB8kE7yzgfHln/ZQb7eeayJ5XUO6o?=
 =?us-ascii?Q?uZpFOjdmoGyhIxU8sB/3W2laMxPCJFxge8GLQAjf1vpO6h63tc9/1TQPYSRk?=
 =?us-ascii?Q?yHpW8J/4yJfGCflAQIypHBBVMYnuAsdlj+mhBgz1NsesJ9MHCOGnojY82/hS?=
 =?us-ascii?Q?wKNKJSkPbNUCB9l0BFf4MJIgx44Lz7hdJHRD974+N1ZKp03zTABMkR4px3Hm?=
 =?us-ascii?Q?l5juYwpSLY7mmXH+J73+8ZJec8axF+N7DKsDil3r/OCZY3pJeq4NlqVewIWk?=
 =?us-ascii?Q?+guaw6hrLd5Ie44ADN8xqJGPH5cqZdYyigoHR70XdriB3ZH58xYCD/UArQIR?=
 =?us-ascii?Q?qdM0oXDi6Vhxq1UNvau1Ok+mlu1JisAbsw5BuLtMQrhwams1NK3A6dtkAJuP?=
 =?us-ascii?Q?Nsz9mfIMLeJbKRC7NnFen+t33kaYTgqH9KglmkjGNUUlEwpZ0gEAz/SXuCE5?=
 =?us-ascii?Q?BVt8UfR6OYUKvVUzfUfkh/1hahhasW9tXb9DbKcFYUV3gr16KtDdXJWmC1DB?=
 =?us-ascii?Q?ZycXjG3ddR741f5vp+tWJZcLfkiS2NHnm/B+MOdgQVB3HRwB/oUNR4giGRi0?=
 =?us-ascii?Q?amJE3RBbUtTNy4bgZyI8jdR6OEYupYviektK69dr4c6EzglYWcIJ0gtpqgv2?=
 =?us-ascii?Q?8XaHTYq+vvUmgZY7V8VbkFdpjXirfFc1vegt/vhGnUWZGVTlLaokqdsdcIj3?=
 =?us-ascii?Q?pQM3Lde35gfcxX3qIFOaCfsizIQe1knYgqDOWd91oPzak2nkhWE4DYjIXks1?=
 =?us-ascii?Q?4GlWWaerT1qamlIjxDYY2ULlA9IIZKOHbSa7evKbMlWEiZnZXxxMXfrYQZRY?=
 =?us-ascii?Q?kM//7eO1FY1XFE1EsxF4w2sF0hgwHCnBWrMZp+5UJXYIvrZKON49hqFo9YQ1?=
 =?us-ascii?Q?r7q8dNrKLpIxCoaoi9LCK04TQbdWcveR5/j5y1fp8Erd6wF3Z4O5OYtdQsFN?=
 =?us-ascii?Q?8XhB1O1b69QjtrwhRnKlU0rqVx7UVcs8e18OxJQdldMRdIs99Tk7Gvj1KfkF?=
 =?us-ascii?Q?/20J/snMRixkvPNnTSSYwOf3HVvaLfh00GeOz7d/V4zokRqZ6PXeFDJlPLsy?=
 =?us-ascii?Q?I45DBJaWeQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: SEdIzT9PvIXfu2U+z5+MBbV4X/FAGpdGp8dL6yNpbew6i3QTysdn7UQmsKZM4cBde84MOgwwSVgXIUDLNzruJBomwRXd/6u0u8IE+X1Kx8NrcUtJuoAB3V9TRezCz9zsSv4Y7UtIFi5Ex3ICWDKx2hCyZGfOcDy81Bcnbm5tBCMEHPJ6Al7ddI2L7wUJyeQAu+PsmhDCVSUEIOqW0TfDmpwkANcKNRE8K31mGMjki9J/CPjNpGw/DcaW5Ut2n+rXN1vojB0VWvS8ZAqlDIKKXlmKavD3qNkKJDBmafoach2IoRyZkK59hrYmkx2TtVflTb6Zm+GeqEKgyaPrWo92YA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a36911e-395c-469a-bc35-08deed6d2235
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:30:11.7483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2yNCmJeXENw6WPKQn9rfEW+Z5Lfqpd02DCK6zG/41mOeEf2ZIWdJQbjLGGRFPA2ZOEqduxdW7XGmUguyygr6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
X-OriginatorOrg: intel.com

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

A new TDX module ABI reports the TD Quote size limit in a metadata
field. This size used to be fixed at 128 KB.

The guest driver's Quote buffer is shared with the host VMM. The current
fixed size may be too small for Quotes using schemes such as
post-quantum cryptography (PQC), where larger certificate chains can
increase the Quote size significantly.

Allocate the Quote buffer based on the reported limit. This avoids
wasting memory on platforms that do not require larger Quotes. Older
platforms fall back to the default 128 KB buffer.

As a result, the maximum size of the "outblob" file in configfs-tsm now
depends on the TDX module.

Because the Quote buffer must be physically contiguous, its size is
bound by the buddy allocator's maximum page order (4 MB), which should
be sufficient for current attestation needs.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Peter Fang <peter.fang@intel.com>
---
v3:
 - Split out from the v2 "Allocate Quote buffer dynamically" patch. Add
   the dynamic buffer feature on top of the refactoring. [Dave]
 - Improve the get_quote_buf_size() pattern for better readability.
   [Dave]
 - Drop __GFP_NOWARN so an allocation failure warns. [Dave, Rick, Kiryl]
 - Drop the Reviewed-by tags from v2 (Kiryl, Binbin) as the patch was
   reworked.
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 3d3f79ab45af..8919b1a1154e 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -162,7 +162,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
  * DICE-based attestation uses layered evidence that requires
  * larger Quote size (~100K).
  */
-#define GET_QUOTE_BUF_SIZE		SZ_128K
+#define GET_QUOTE_DEFAULT_BUF_SIZE	SZ_128K
 
 #define GET_QUOTE_CMD_VER		1
 
@@ -222,11 +222,31 @@ static void free_quote_buf(void *buf, size_t len)
 	free_pages_exact(buf, len);
 }
 
+/* Return a buffer size large enough to hold a Quote */
+static size_t get_quote_buf_size(void)
+{
+	u32 quote_size = tdx_get_max_quote_size();
+
+	/*
+	 * Older TDX modules do not report a maximum Quote size, so use
+	 * the default.
+	 */
+	if (!quote_size)
+		return GET_QUOTE_DEFAULT_BUF_SIZE;
+
+	/* The reported size does not include the buffer header */
+	return PAGE_ALIGN(TDX_QUOTE_BUF_LEN(quote_size));
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
@@ -416,7 +436,7 @@ static int __init tdx_guest_init(void)
 	if (ret)
 		goto deinit_mr;
 
-	quote_data_len = GET_QUOTE_BUF_SIZE;
+	quote_data_len = get_quote_buf_size();
 	quote_data = alloc_quote_buf(quote_data_len);
 	if (!quote_data) {
 		pr_err("Failed to allocate Quote buffer\n");
-- 
2.53.0

