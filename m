Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBC48EBF3;
	Wed, 30 Sep 2026 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764699; cv=fail; b=BzGEAwaxpQeytmd0zQIJrk3wFzIRf8O+n862Qh74J5IptHoxxpS6+34Lmn8ouYOsYA4U/KY1sTxW58MzmzB5fegOKeLk3qzu/FU751XEASZ3oOBkXHRW816x/cDxQsFjmKOI58ZJ/l2sHsUuUk3WC5CgKGMI6tN3/2MGJhv810s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764699; c=relaxed/simple;
	bh=PvX/ASVCuZY+sXYYWHjY5LIT23p4MHdlqefUgJswaJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sH+kffRcjd//ZyJ5NggvM8CxqGUf2yfOj0LNQmd5eHLk9EAydlcvU+7rYm4wtd/NrB4ZbtQtQ4i/fcUApBZRW4vwv2I9JALzEn6YG+ZAfLxx+ANxIcdvJ/m+k794ss+tDLJJ8T95RX40sQ6YjPFki3UxyfettrGxX5I8bZ0oaaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5/l410g; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5/l410g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790764695; x=1822300695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PvX/ASVCuZY+sXYYWHjY5LIT23p4MHdlqefUgJswaJo=;
  b=B5/l410g3I6b4dOl3J0wg4HVsdbaEI/fp2B1kcNmyV+BIQNCTw8oqnWk
   vFJWpF3kZsnEWgA+QugcEYZcFmDIWVzOiFlsJ9YzaZXwhfj7A4IQEg6cK
   u6p4/7pKE1P4iLEZRwCeKrd/llMn0gTIdWajj7oCEKDkTHCgVx0zO1i0b
   kL7ArwV2PGsl2E3cyexlrTkMZcwBB2sf/m7eyL+5H/8+0oBTUqS5qhj1a
   L2vc5PH17LOV5zRrfDAU19nvhCF7OWh4VlHO3NBPoJddnAMYEehS1wDoX
   lm9e47w/N9UDiT0HCt7chinu78FfELrKL/G3JsYtc7LMfXUUqM4m+MDWD
   Q==;
X-CSE-ConnectionGUID: PQFej4SDRsSYmZeLUxqVhA==
X-CSE-MsgGUID: 52uFimzcRdiRIc5SaHueHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="79066269"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="79066269"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:38:12 -0700
X-CSE-ConnectionGUID: yy5QXya3Rna7DwOyhcMOFQ==
X-CSE-MsgGUID: StA7esDeSZSR49h9zGSGJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="303588993"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:38:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 03:38:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 03:38:12 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 03:38:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBpzQGsMMm6djnkwaCSX6fo8yPH+fogSCP0D2jsBjGOu/cWDkri0YSG7eoNlNYiaWqo7IBjn3kA8/smGlBWwxjAyZKa7vbqwfJQqjgxAZRG2W83KiRTJqSbt6Ddwyz25yToGk6nyKCSMTYIUnii5nRWEcDGOXT9fjOrz3PWPlI1pww6ROMyCnHC0VVO8hv52/4P/8uIMkNzXRs8gM9ORw1W3VBgP/X4IY2Po3Xgn7Zq2IrnTFIyxoOSWwb8oDcx6+5sc5HW2MjFzcMacgahlCSaWoxQ+35RkmoAl2heDQtqC6cbqLeq1sOOZBuJa1qYXrkqn5Soyz/k5qTPK3pRN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTrppPaLb0UZZudOJVw1P6nAqg99UMTvaG2fWrvLUks=;
 b=Z2wAz/zYOtmWBjfjSfjOuzy8Hcao06B2mzCsqAt+QpQzHbnVMQKNTpBxZEZuY8u7JO+cgHCSlupxWr2CabVcgcjiaMqCS1lBn5j4wCUtXKLq4CzAQo4KPu1cnAXpnoXyu6HfpLBRmwCGXobt5PEGjFs+VVD9qe1VNjjdS9kFXwtfuA2NPs6UJ3Dkkv6TIF/RAAR/oqWOj0eCK/5mrhM33uec3nPIf+HMJShW+rJJgrilJrUhGFTqayBMCaSU+h8x1RDhOjX67cjqpUu/s4ikeIEcMBdJl8ZUr6/bKf9pbAJnamDarDw8Xewfd2R/3+O8XC9FTZ8VQNY3fIkv6XWoBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CO1PR11MB5154.namprd11.prod.outlook.com
 (2603:10b6:303:99::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:38:10 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 10:38:09 +0000
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
Subject: [PATCH v6 1/6] x86/tdx: Take the Quote buffer as a generic pointer
Date: Wed, 30 Sep 2026 03:30:50 -0700
Message-ID: <20260930103739.2851980-2-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930103739.2851980-1-peter.fang@intel.com>
References: <20260930103739.2851980-1-peter.fang@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|CO1PR11MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 82028c72-70ad-4271-c84d-08df1edeebda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|10067099003|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZBgw3p5gFZMZuopTR8lDJvugjSijnF9Wkg+yLQW8SV9AY2TamMzrInjTYA9amUU7kHghW3voAK0pYHk0t35VV70+10NfIRoAwMlLQqUyjk8yikZiqTLZn950xbfTs5Z4bySvcOLh4XJU6SqXTh3di1xZs+lIKzbgemj0FDzO3fF6JsK8MqF9oM8A68PSa+TxbGzQx1IoJ3YXItBp2f13s3cnTpkIWhnlDS4ZnQedAe7eFkzQDk5lCZvYWhnD8PWgBummtd7kzRiXpPyjeqsTYYllXGfDzowaG3i5QRmOQRh+H72+MrzydODyn03FreBMqXIHhSS0HX34HVz7dUTR+Xdgf44Wc+cF5pHooUEf2zr5DprYAjGN27Kv/grDFiITg1aR8lfAOIIqAj59s9I+yZ03B7wCNwoqNx2y5WjkXsyfqE5P0lFlO+TUVIm1R9cQ1CnQ5bk9SvFL+1l9qaxqfWkKWmZQgFolgEgZPVbbZL6RmpTY+E7S1zIQU2+h2rVcjAZiP2eJCrdD3AKR2qN+s/DaTnIlPiRmEh3MpF8YOCexMwc4Z1KizXr1fUmyeFW6o2ZpSq63lI4N/1GanGTgcyeoOI4MsRB+gHHu3TQ2LWHfpW3Bx97TltN67Q3vziBFjGVAFyYX8WABRBQ7ScV27QrUuVI0Surp5VxS5u180BM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(10067099003)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sTvlFmjegqM5Kd5OmIAwC30thDle5QQ6VXA5N86b82zEJzg2EQv8Mfz3uK8n?=
 =?us-ascii?Q?68IAm0sYZ3giIB7CmdFQo5KiuKu+QugPdhXUMBoADhLGxz23ko29nVxFrG9N?=
 =?us-ascii?Q?cwZumVohzmeEO1c30XJHLPPamLsP7F2p1o/YM9HySjQ1auXlUxUJmrDwP0f9?=
 =?us-ascii?Q?VkGLSePxcikWVU/ON2C36VrmzMeSqqliMHr0SD69PJYvVajLtLaFz4oBA/Y2?=
 =?us-ascii?Q?lUvLPmnmTOArKQ95k6QiIvtDUfbLQYIl4fbxKbmP5V06KNd0NzVzn+ENK0Sj?=
 =?us-ascii?Q?D/nVeCjFd8KfHogY6Q2YVen2qNxGnLwkT1m6kjCowC/akrLlrmStwERz3POl?=
 =?us-ascii?Q?5IwfBQf2voo/GW97J/cp5EPoDAJVspXl1pLT1QIFbKBKvMn+G9AN5rbpVMBX?=
 =?us-ascii?Q?WSfq/0xOj8DnTmoBs9ResedFeatZp207Au8fOsjF3oe5aDG/Ff863rbIj/3v?=
 =?us-ascii?Q?iPrHYPmBpqaciOtKprA6dje5Pbi99ks6GudzGT/Pi3pZ5UaiTMue8sFR7TR5?=
 =?us-ascii?Q?13ws7yCnMR22r40prW8s1n93gQP8VWUKK1aKeG0oAtYEeu8IT9M5tZcR/0FV?=
 =?us-ascii?Q?PTnQLBt6oiJOBUapYj/h7s5ZH5JekhSJEZtrNAosmiWb9Ibg+o0NPgPmXmcB?=
 =?us-ascii?Q?KrTq9dbk9gixMOb3e5ExY9nUPy0XWl6l12BidzyBFmEh5DWE0WBzg7V8eVpP?=
 =?us-ascii?Q?BxXH0twn/EzF4mpzh5184fS+gwITKEH0sFOsyjnGwNGau82j34q3yanVKVhj?=
 =?us-ascii?Q?O94hrK8sZls7HJzPAm1NSbZCRuKR/DBL+q5HYLbGxy30Pn6QwWXvwoUbWs47?=
 =?us-ascii?Q?sZTDF0V5re+HWfSNvTdeO5s1gyqQNK+bDNbVnBUlbNjsSalSTalv7d0x1v1B?=
 =?us-ascii?Q?pOCaI9k0FbyFHe9rEdcF1xJstfvIC0zm2KkH6Vk1cW2RFkzdhXAxvQ6Llczp?=
 =?us-ascii?Q?hhpMw4HfRYmS9slyTpzf7Qn1tWOoqLs1C7EYyvQHNtZ2/Quv+1RRSfVzOHmJ?=
 =?us-ascii?Q?wV6S0ANbVr0TJqgv431NWSQQlTFeo6wmdmZL09848J1Zdo/XvVWwjrfuT605?=
 =?us-ascii?Q?9OFq8FdUjlqM4hqTySg0P0785NwpzD81D8RbY1odL0J51Bx/EUSkFd0a1+fi?=
 =?us-ascii?Q?gRI4BH9oYGahePyVPWVUrt5JACvKERvaEsBFwb0ve9PpCq93gvUYpaSeaCId?=
 =?us-ascii?Q?PbfnksnysXL05opWOnlRRB/XHXYHUaO2MS9C4yHYSlrPa2mqB9IPmDW+4X25?=
 =?us-ascii?Q?PyVvYA9gwyx9jjpmygeE8aTbe4YDcS1W1ZBtlrus4lUAdDCOOtnexwxj3HHK?=
 =?us-ascii?Q?11NvgxfqGtJaJPBkr1hMru9c0KwvUDK9HGqQE0QujDyH18yMNGZNM2VL1zPb?=
 =?us-ascii?Q?gmeiKub3PZ3mpeE/a76NVYLoDvI5CfIM0M2BuaGBZ+bWicWOW/Q3grzqltHa?=
 =?us-ascii?Q?dvJdPou309qPn9ASgz/QXCV/YC/b54gF64/ZBuvwSu+ypnRMgZZk1jPiKXQ+?=
 =?us-ascii?Q?CITJ5ZYfohnrkar5HVt4hwfr0uu1uQ4Zaz96tE7ZkttccVPWIW06xaZH2l5R?=
 =?us-ascii?Q?LtTZ+ajv7WQtzj0/MZFiQ/PNlZGzS1BE9bpnpaKA1OR1dscPjw3KsK7gpiRj?=
 =?us-ascii?Q?H0XOPf9ECVbUra0KhMWzBBa0a9PX7Rmqx99z5gmd3z1IRbU25wKMsOiYucPK?=
 =?us-ascii?Q?iHXOpMER50Ay4EhZaRnTfASWEHA6vFbY/iypnqo+PfNgSNS0fdtUku2xefUa?=
 =?us-ascii?Q?RaHmFYyHjg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Et8lAYFYTpdsUUiBXQqRSKfNZ5jiZ5drMPMAluc3zJyGSBBvdVo+0f0Xo4GQm4JA1ZrfTMQ8AM0q4ZLMGqnKk57a2RokznJxAIt0SvrjH6L9FCMSZfLdimhU3HWgKudUJHCDuVIZLSsg4yyw6fMqiMxatemrRuBc9VuL28A29/DaScMgzpAjhGwOtOedHCk19FfK1R6rqhbpDf0dZcXm+KKfL6jTVXqdooNAoLcnjJ6c2z/r/5qjOHUOcqvnaV6F83qQgrgFcKcb2ukjiCwlpAN6n0EUDkCWYORtYDoKwMmdnW7uXrKDBC4IrLzhwG7YdzE9rEnK5g/4h92G1y/P/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 82028c72-70ad-4271-c84d-08df1edeebda
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:38:09.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Om8WssQpP0hDe7Qi9lW3WuiZPqcwG0qGKZtMVl9gLS4hL2x7rajpRwWAUCid8n4vBcJCIVy0Vw3sJYZzK/uSAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
X-OriginatorOrg: intel.com

tdx_hcall_get_quote() takes a "u8 *" buffer unnecessarily. It is never
used as such, since only the buffer's memory address matters.

Accept a "void *" buffer instead. This avoids a cast to "u8 *" when a
later change gives the guest driver's Quote buffer an explicit type.

AI was used under supervision to collect/apply feedback, review code and
workshop logs.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
v6:
 - No code changes.
 - Explain the connection to the explicit Quote buffer type. [Rick]
 - Add Sathya's Reviewed-by.
v5:
 - New patch. Prepare for a typed Quote buffer. [Dave]
---
 arch/x86/coco/tdx/tdx.c    | 2 +-
 arch/x86/include/asm/tdx.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index a38e44401840..92c243851171 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -191,7 +191,7 @@ EXPORT_SYMBOL_FOR_MODULES(tdx_mcall_extend_rtmr, "tdx-guest");
  *
  * Return 0 on success or error code on failure.
  */
-u64 tdx_hcall_get_quote(u8 *buf, size_t size)
+u64 tdx_hcall_get_quote(void *buf, size_t size)
 {
 	/* Since buf is a shared memory, set the shared (decrypted) bits */
 	return _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(buf)), size, 0, 0);
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index e186dfe5bf88..97bf6c8e0d89 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -82,7 +82,7 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
 
 int tdx_mcall_extend_rtmr(u8 index, u8 *data);
 
-u64 tdx_hcall_get_quote(u8 *buf, size_t size);
+u64 tdx_hcall_get_quote(void *buf, size_t size);
 
 void __init tdx_dump_attributes(u64 td_attr);
 void __init tdx_dump_td_ctls(u64 td_ctls);
-- 
2.53.0

