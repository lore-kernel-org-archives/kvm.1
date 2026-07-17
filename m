Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BA539446B;
	Fri, 17 Jul 2026 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324681; cv=fail; b=NsuacNiCpO4rktUALBpYB2Rh3K3rujVeI6/8+AJWZ4OAKdVMXeHAo1tOyyLxCSNG/LTNJiVYj9Vi2qUwQpKg39dXN4Aox0f4bD1OGwCHJQneGlTtmnTCeV5Fz8OF+655rwXeU/dECd395t2hZPJANJPS3Ogn1z5O+xxV62OKies=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324681; c=relaxed/simple;
	bh=0sDq6vyH4eOOFzyn6+paGhgU72x7Rc3AiJXffLYIC1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aL0FcbL29ovF+IVenrRYKQPjKi3gTzuTG6bNa3Zf4scdEj8LO//xEvHlExlFsTawAx2sa0WTvUzvz5x2Yc4OPe44cmJG5KgCv4b9VdyXdG7Onv1JCZJ5wsGK4/pAEJ9hZ7DLlE7EYdaCQXg3nSLaXSDFIxkg0N+doncsNYkBNYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeGI70K8; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeGI70K8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784324675; x=1815860675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0sDq6vyH4eOOFzyn6+paGhgU72x7Rc3AiJXffLYIC1g=;
  b=BeGI70K8RfeNDnI1MtBfA/Q6udJ5o8wxjkK84pjihO3DI/l54oTlAMSt
   QbofXwZijVd0tcGeZqaYqtYMdwzQ8kUu6TE9v9WfyvgfLY+jgi7DQ/oij
   dmNGc80XuVyNBkyepAscc8dBdbPWNdQteGJqA3dbuJxofOhu1z66ZCVpi
   NH23t+/iRP+TK1r2u+plrhoXlVPtBuRCNn9YLVPACk6WXnoF6aYOub8kx
   C4uPxENDP0cTFXkzhWL13hZsQgBQFvDppCwrQbI4ri/ULqUP+tTxog6q4
   VvnHG+aFhQhw+i89YX1avwEz95kO6aDhBvrX0+nWfUR8tlkKaCyn9TmlB
   g==;
X-CSE-ConnectionGUID: AVYpaJMJQ5+ug0gpmJ3fBw==
X-CSE-MsgGUID: EVTYKH2jQb6Je1Eivs8hew==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85201763"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="85201763"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:44:31 -0700
X-CSE-ConnectionGUID: 9Dhl4UEwS8qqTnEjRyvAJA==
X-CSE-MsgGUID: 25B7OvnbSHWItKSo9tCDBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="255720255"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:44:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 14:44:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 14:44:30 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 14:44:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtXeuExi6vQL1AyhkgD5q7e2G8VrZ8UrygluHvPzHUiPlhh6KmSTtibmv2vHTgMDQBMnw1z2wPkFR+a/Bweuv1sIE1uQK2UYaC0cb3yKkr1g35whbO3Bggoaq/MvnH8ZHWqse93pgUl24Bh7sNGH1x4yK8Y4uap61PxpGvIylg9I0+VTWsHo6Cc79Gs11CZAAViHDZyVTc6wlLiq3iuh6KNrVAAtx+UV5yxC1ndVtnbkBzLfaw1nSMoZwORVlggmmx57nMM0pz89fGZOjEf6xaT1726KqTDOgdrdiYYfTSoNgERRDPJICJ5MmKzKs71KrxFzTZeCjyc+8oCtn7IlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2Bric1CtwvThvUfIyHBRZkdgKKy9dxd02UePg7BtQg=;
 b=n2rOl83s5hNVQHmDkM1tQ95VqwFTCb62srFGTgX1i0Qo+VRJslH1T3nwVA1/H0bL9ilPqY7IDMn/UlBgY9rFN0yAPefvCSSIAhHGQxyr0RRCW/iI8/KGikhkHzmEi+G0/H7qybx3pA9li7Pe2vwWmi1kinFi5aImVmCAEtm1tLWGTvNTVtOcgvUg5y73IrbpK1MqX+Acsuu6DgAy1DwBDqbpp54+DwUV1zg/aud0VPu9CtbQwWDsSS/7A5xIY/zC8tbZei12BcaG+S/vkJ13J73atkyjKIzH5BFJXYkrKpc15d78J4aDG5uXzAen+esZUeQDlNWW2XkO1yolIJSasA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 21:44:26 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 21:44:26 +0000
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
Subject: [PATCH v2 1/2] x86/tdx: Add helper to query maximum TD Quote size
Date: Fri, 17 Jul 2026 14:43:11 -0700
Message-ID: <20260717214349.4075994-2-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 336ca6e6-a8b5-4f98-d865-08dee44c92ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6nxbOp87/kGmGL1mTCSzWcRJpYSnXoXHlfTqNzQzxisB5Blm2iHEdLbBOcrfCGtYQUo6RUq08snrKvrgW5IGr9FIm3YqaLOJChIbY79wauH/oCJuK1+983zb/Qlk1P0L1oCEtcMArNKYMVcVtVDqJzbDShGH6m9Wx0+rZcG/f7UvWJDebLKrVpJpWfHwRWIMHIhcUzAfnEo1ySVAVinpEVLGljoS9NBi5hoCWx57bWDzbKdBkzt7sf26Cc1BN053zUtv4dwrT8Ej6/l+QQD7WRya7L2A6a/KwwtUg0d38KhVQ+xx7Q4pdNRC9MxVDyz0vdiMX4x0Mgw1KMeRArvG5iT37EdOMbKsCBOSyH6zE2cy7aGQOVhsSg7F4WGDwg9Ue0cmj0XVU9DAtyQ7lhuCm7X9uHyzpwaXvCbTUhH5RvDFSl4yNFry1zFxlYcxdLeGZ5Oi2cUWOhzBnq/Bcfar+WcuTZvO65bryOHOsj2+4mB3iqw5eT3E51gKIwOmqMvacOcJJsD5SJeVZYjvn9Rjj0hfGFGU0tv/Yn9LYxCntOgxucvI+dcK4J6eQRG/2YB28vqe8zLKPcWnsFEtxDFVu/kNPYPKeA/eUMiIZAhpS8PnuxQmYK5iwLh43rGPhVPwIchSzL2PnkDOzswiM5MYa0Bu7kJsrGDpeCpsn4dzkQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aOXCUtHAbkyGMkPL2XK2jz/WAg6Pk31uTqatqBS3R85x0ZdvgGim6SJeVEpM?=
 =?us-ascii?Q?o5AJZW0fYSGgFMRYfLNrTmPD7Lx8ZRMa/2PHZ9ogwNuvLB9GsCEoviL+4HjA?=
 =?us-ascii?Q?Dp9a8nadu+lNEDBRCE5zuNI3pbi00R08emQoEebO1GRgqsV8RwSx19yo73E5?=
 =?us-ascii?Q?4ZQPQzqxZdvulNRe3aCtVRN/IvLdfOpyYm/xyEeV7XP84FVLXfOItuW6QsuQ?=
 =?us-ascii?Q?vknHZuCOT9DrtpQlOAuys3evRbLpTkpodlhfzm71qBmKJIQUQcVBmREDdC3h?=
 =?us-ascii?Q?dlolcnjN5mOwyUcOVB7BTulRwb+tXERNlrDTiqS3x7AWqj2dDWtP23c8NAC7?=
 =?us-ascii?Q?O1JEe7VQjoAC6YXxB+eTfnwIjVrRe6tTJyqjmrJlrHy1KTAx+XwacOcwmEMj?=
 =?us-ascii?Q?ghaRtm1CeaIE8SiN+vM742ujANW9LcDr7rrm1O38v9U+ofLBlksnF8XJMWTn?=
 =?us-ascii?Q?nuED3nxPZkXT+Ot9u61VH3C5QGlN7jBCucMgwFB2ur9gsB9bULrzO9crGYx9?=
 =?us-ascii?Q?0hf+6ovT3TR/uKMg9SVH5XpMTr3e87wPwsnEOC6IInZgZWzOYZACMWgK4qqt?=
 =?us-ascii?Q?gLRYBiuk5E8YtSs94TFmyNmlJJramYZCgsh6JHrQBKr46ZynRHM+YrxfKcSh?=
 =?us-ascii?Q?yKZ5QmXk0vsc1Mtz4J7BjHE78GC3/Kajal2DxesX2rdAbZV3qWZIkqQzENAY?=
 =?us-ascii?Q?TiS4hCowlOebryFaxuafy18PKasiaY/ghfnEFLqXlbLTRERJnjwKS+TRA9l+?=
 =?us-ascii?Q?UryHDBFOlkkxa+WlcVZPpsq6PvXfHsFO8fdL/PK8RRCYWEcUdIYdmSdrdZmp?=
 =?us-ascii?Q?KtU9EJaXlKPl47aLy2JuZ0wfleLo26hjZa0ntdiLz/m6eC5lmGTIR8m2P96u?=
 =?us-ascii?Q?QOhQmI4MTjBY/7RaQjzuxlNlB9zfZabk0OqUaVOpU5PKi8dfg3QW+BY2LBKn?=
 =?us-ascii?Q?Qjc462EDDPbnUWaFNmeeLcsBi2Hz7K31PoxLhuVZAKDqeXmJaUI4gUePV4ct?=
 =?us-ascii?Q?yWm1pR9rK8l6HJXFc1i3QaDmucCSz5jLWUatYQa5WywiFbaupdld2qNmT+oY?=
 =?us-ascii?Q?x8ho9r9d4YURhg/9nZFSIFJrirfL451W6EQMHJlhMPA3Tq85l6Zx2N+v9KrO?=
 =?us-ascii?Q?8JoB61MzsL1PxNaZ3hcgjkNW0flwrmNn7jQnEHpNSrGIgPTe308Uy8cNeyn/?=
 =?us-ascii?Q?X/ndXigugXxC5/Xiwf/stPEjF/s4sgSbhA3Au+FbVQrySqbuqyGKmGDVV4g1?=
 =?us-ascii?Q?y5IT6JPHyOf5rLa3+2Hq3ViEX0hldqouB8ETxU6bkdm04o2TGrc+7vzrpCZr?=
 =?us-ascii?Q?iCkgDnGolNpYzCoZACeczHCHgq9NiEewL0xiFbpzWmPiB7iZ5e1z43aSPkTf?=
 =?us-ascii?Q?zuJn7b+WUfRZ9q7kBRKMZTfGFkOauAeqAjfUGv976E+i/5Qq/FruTb9bBdG1?=
 =?us-ascii?Q?DIdSCLHqJB1Umf/SezlVg79saOAXBAv/9XvUgaxgBhrqL5Fi66Db4lWnF7ze?=
 =?us-ascii?Q?OqzwQMmGzCUGycxXoNF8YmbyQa9dOM4V2VA/PcO2+KGKr53WJ0v/EByuMPBq?=
 =?us-ascii?Q?aGF7Axr5+VWTIz3ZV4kopmzfH3W6puQ2SqaZFpJYDrt6TuSj5IMHzOL36PS7?=
 =?us-ascii?Q?E7k6i/tgoJIsBrg4uCHVldZuJaVaW2ddWUz3z9EuDXSIS9k3lJF6l+NsWR3j?=
 =?us-ascii?Q?Usc1QctoK++D5WaWXXHuGigJbiFxpn9B5BN74rntLU42ChGjZhOCBx3PNhFA?=
 =?us-ascii?Q?fQkU8NrYkQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: HWzcVs4UPQNUcZP23NXijyK/5mh5mwKVMQQzfMPkJ4w1YfwPQlP3SiFBE6mdUsmnDRHKozrpys+XQE2Th5hka5v3EuNZ/IBywg6W0yOAgauG9uB9WjCmjUEQKpDUY+omjO9snCOQGLVq+EKZM+xGt03tt9JCVFXe5TD1JYaM6BJQfeDUwJEHaeaECp06Xhi+60mra84KqfE61kp0pHMPwl8hgBra7sksBpxl2BA+iO/eVI3ckSXifuEjpmF8vAvZ2lSEkizzQt56Z/SOhYpGXXVYfCHNGERrZ1As1H+hu12NaWDbt6xput8WQQARqnazP9wVMn2Y5J//WPf67h/56w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 336ca6e6-a8b5-4f98-d865-08dee44c92ac
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 21:44:26.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gi93RnBaN+xb3078cpFfSZZVwJx5wOF7sXrkHDAK+gCU9a0yKF7cPOldlmFibjt9SDHEfCTb/NOeSghLO79qow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
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
Signed-off-by: Peter Fang <peter.fang@intel.com>
---
v2:
 - Keep the explicit (u32) cast to document the metadata field width. [Binbin]
 - Note that Xu Yilun's suggestion was made in an off-list discussion. [Sathya]
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

