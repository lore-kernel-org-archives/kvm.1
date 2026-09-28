Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF3A4963C1;
	Mon, 28 Sep 2026 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590263; cv=fail; b=pP/xNJzJbqDNs+wMU+G+qjh1QwhhZ9adSYdRL4s12eodDygLRh+ON+GUza9F4RBjVx+zc4JXw2aHsM7tNhgM9ED65oKtZ9vbav3a80JE8yps9Bvl+5FO1It0FLvqPLonnuGuoAY+IoJ+jcsWwfmOitjBNTmW7e0/sB6msU9EY3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590263; c=relaxed/simple;
	bh=yRLECzLCohbZYtMtdiddTJ9GFV/bV807mdRLBLhMxQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7WL2RK67YjQU+arpdAjQIBOg1mmglKcs0xHiqseY+pdpEtvYGoePPBxTQWpwl/S6rx4Wl1CCAM2V8Mxq19AQxZFsOh2Jcr0EysS+1jdIBxKUKDCRscuCJWzNTk930hLqcMcVRVQd+zbrzwF656PgnFAGi/8BLNIFWkzNs+cVDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUMS5EZP; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUMS5EZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790590261; x=1822126261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yRLECzLCohbZYtMtdiddTJ9GFV/bV807mdRLBLhMxQo=;
  b=VUMS5EZPuu2hSzxG6W7srcPts6jNBHP8KmbXKu+9PPQRt+4GW5CMGCV9
   kkUhDTj6/3XJryRSmmJyjXmqAssWhpj76gJMl7nwOeSwkMyQfjablBK0x
   RRt4DMcR9/04mYM3anmH+gmH7nkm5GFicaUy+QOvcoi2Umn4SJrxzRrEP
   9vg8f4ox4pfHFcUMa3CnzdZE4YQf+2UZFKJS4XaSJLJrDRmdJyDsueo3V
   gIjqwkZbwnk03PUlO1s5WwtFH4V4Bb5YVjLXBPdTnNjyJsvCNa6Zx6cS7
   CVYAPPI5xKdjUx6vcI/sPAETB5GisZZ0fpQMQVc651abHL8VjCcWdR4Be
   w==;
X-CSE-ConnectionGUID: 5yDhiREuQMOdQ7VFjqpyzw==
X-CSE-MsgGUID: HX7NhyAMTZeK7U910/9SGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="91388345"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="91388345"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:11:00 -0700
X-CSE-ConnectionGUID: BmMjxPz/SS+w6VwoVFHTag==
X-CSE-MsgGUID: /+G8kmE0Ss+ci1O/G5c0lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="279735403"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:10:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:10:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 03:10:59 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.61)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:10:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTXDpNkeAjIpL/2e4RMPGQyt3xFjmX5gtKnKWWBDyNnjZHavzdsPRMv2KTuyqp/ctHIOJiPEt7ttDqPjlmSCUtwwVZINspxlI01wAvTr7MEbMx+yb+zEElp4xKBXln0ZBhua4ReYpqNCQEyfKrogoQCqOCqUcgWHz/KLz7JjDNaAlR8huLHSKFwrAhhU5MMFuECT8jDYaNQAJO9qu7cNSw6vI9Dm96AohgTw6VCKAQtxPdgAKDRd7ol7DbMj2Pkf5Qr/6Aaq/zENJndfBZPBdH5l5MMiHRsuOX0uD2V/UKsPGJOC8stAnUO5U2Yhv483b9xv/5GLqX2+0bmRG0fiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRSRtYcTVaIYd+LxzWqnGvEubPkgO1WWl2/eKSTnq1A=;
 b=HkZuP27heCjjYmDC0DBkY58mmMzSODyE4aOwz1D4fpCu9kuRpg25w8q16DqnvlywoWvRRaj48y30kY4LjU5SskXrrRAmzV/RXLi6VycfQ3wvgowFgOiiayvL+BMOD6NhevEmSxQwptWCX/U6s8tqG46QlEuIGTCOIXtAvcM1trWL2FQwJYevvcUPRmQuHvFPQXdC1jNTGT52l885a/8pfoKufZuYMq3TagHj7L0MfO7wpGonR8LCqhflzb581wdMGmlmClbv1M2vqpZI2XGzP5FmIM2pmMV6rEnRzfjCNDxZz36QyOLdwUTPGsGy4nxJTKN5EYNXIWFatW3u9emGhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DS6PR11MB896703.namprd11.prod.outlook.com
 (2603:10b6:8:499::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:10:57 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 10:10:57 +0000
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
Subject: [PATCH v5 1/6] x86/tdx: Take the Quote buffer as a generic pointer
Date: Mon, 28 Sep 2026 03:08:12 -0700
Message-ID: <20260928100913.2265687-2-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928100913.2265687-1-peter.fang@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|DS6PR11MB896703:EE_
X-MS-Office365-Filtering-Correlation-Id: 82353790-fd6e-43e8-6499-08df1d48ca39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: M8Y2xe1fk7WAsZcnyhbU/k7pZqYcM9trQOCfohURhv+8wwa35IGMhDZLGo2z5HIYdKPr07dkkl8zXKcGTPwx4CnKIlrgxTWAVu4nhTqt5atG+0BVgDItO4/NCQqL/ZY3IymrkoRFxK0iq7UY++5Y/7YyNPpSaKTbtgNr32IRp2cgSPdRY0SL38wNWaifizsqbFVFZ0jgvxtFAKGOpsVzZVtbMM5E0xtXUC2bIIM8QAvuWT8y8x9cytaVodABnDnOfxo5gaHUsaGsL9LSkhn4PZ4q92AQPl+gVgWFt/uL1LJWjWI+JAGzZk8w4UIINSlkFY2apu0g4SG7C9nRQU3+BNnH1SVzYf6Qfx+T+TNLm5sO5qv3j5WhIZ5fsot/kGFYfmL1yMtxXPL6OotLpdgfw8EqmuWUxMpSjN2iEiza981KG/zzhMOvAMQNxIwMuTlEPAaVJqLa4Qtr+fiGZxLiMBm/5yAJqJo+0ldlYA/a2drUUsFwAACVKo9y2qcP1jFxjF6tExSOw798qQ+ceXZlcx8m/NbKCVxHvX0cg+Ov2IwUWn1GpMFN8D9h96nTQePoqQ/sT+h3G29ZQoJYUofekKPqPh/SH0jBe9y+wIZDRQJBbq35Ou3AquSVuUoEMxTLNQiTky0U1p/+6vhHyT+iGex4u97s3DSNfWjzkeEgExs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?368JAsi93T4KwO5DtkYqiVYNJQU5bibcRCRiSPvfgfj80bgXYfNQTNRQTFDb?=
 =?us-ascii?Q?+i52Qp04neHTK7cF3/prCvitbVfs6NEs1W5Eb/bzjZnLkpLSOshUO/I3ymCn?=
 =?us-ascii?Q?qmYh2m+ptpxVS3ZAW+0JPbyrzHmfPgir6r9s8AkCufYf6ja6O8o5N6JHpbgB?=
 =?us-ascii?Q?wmRQ8uJ1S1eKbxZRASGrVJYCZUTBwEgRzkUZk5r7xNeLQOZm3RSKTRZ01X3r?=
 =?us-ascii?Q?uu11F3XVqz6d3uQCaIKxJBqHI7hQstGK3O19gmnhrDGaqfqf3cDAzEkoWEuD?=
 =?us-ascii?Q?wPm3JEQSdoB0A2I91DnUUp89aCJbE5LBPqtOESvSS8Fu5gZ1SdIMmGEKeyh/?=
 =?us-ascii?Q?1eF13hzCMbqpGl4uE77iVDxfvk3FF8Xa4hH7DHvUpptp308XSNxBevFZS7El?=
 =?us-ascii?Q?PrvSwKt+dB4xMZyQdmGyevlIGx0B3ZjTPIlbFTP5EYjbmSLycrxAdwyWNNEk?=
 =?us-ascii?Q?A4NXtkGur9kwFhSQI+fCR4k3Okqtv9JcO5Nkh3rvbPK+yotrKTZr/wWSKVSh?=
 =?us-ascii?Q?c3ind9pIGzEuw4Ne8o11Acy1xpLNsX/K0BCGs3VnMLim15/dU007Cbgmi8Tf?=
 =?us-ascii?Q?rotut3Bh28/kGs0yotU5L9+580VX5y9M4N9NaCSNX4wHmEAzTy120HW9TvHa?=
 =?us-ascii?Q?dXcW7nIXwjVGArsibNNkr8oEjowaPwtM1YgImGA6MV4RjnKsqXD1WrHyGTRV?=
 =?us-ascii?Q?Me48FCkxmbceWSiTxduI3obEwYlpgyfB40JHyoZTXeHx5O3mdWCAAvLGHrxE?=
 =?us-ascii?Q?t5vtW8qfgYhVz3J+p0ODM9TunplWtU7yElUF57B3pjCHoO0f0cG7h198mXhN?=
 =?us-ascii?Q?juwvmlImHYBD/BsizQzdCp8vu59RBy9886DYaV9JP48DDOpTEF5dwFBrCgbq?=
 =?us-ascii?Q?tp0DIcMLqxQV0gYSiwWTcW28/+ZZKYF2QuKsSGLSJFMQefg/BAa8f4r23WmE?=
 =?us-ascii?Q?dQXZCKP8nSA1pgUOsmVKyko8GCB6fA+Nl4j9xbvWEVcattEPMqiU5RTmft1C?=
 =?us-ascii?Q?NkfNV9aytC6ex5ohpff8DuDzGGbgaLa76BfNF8dzVyWtEhgwCl16T1bSel9v?=
 =?us-ascii?Q?ORqJAYWwonw8KyopMcJpK0BQxfwfPBOaDLW++ELLlEHksig3FOBXFtgKB7My?=
 =?us-ascii?Q?17xgSUQSbG2U7m6dMkeF5wPfb+ab7ZkrObqUsf+KMbcviFG8DY7dHEHsIEXJ?=
 =?us-ascii?Q?dcKR/Fxc+NBHCW15gD6PHo1GovhkDG0W+RT7lzdomgZxrzKEVKUTh/TwwAZU?=
 =?us-ascii?Q?a64ld/NdG1DHB4vuXb1HccA8AMQPm/WvJIFSMFv2RCRw+PIY/sBf4CPG6nDL?=
 =?us-ascii?Q?O3E/uNyALmS04c0lcgML1z7MHHWilUJdv+ay+NvUXusFIC4MJRtUVMtaiA+i?=
 =?us-ascii?Q?pD5Ct2dYjuUKZZAiqHr2ligHQMigVgwes+u8DiIIXVVhIq9EuD+iIMQuGGJM?=
 =?us-ascii?Q?g6Weqs/5MCIBQ/14nXf9TM0rRTBjAQP6xqzbeescitwm1/7Dk8JMF75PtCIp?=
 =?us-ascii?Q?2z14ssbTJR8FiVTtJbI62RHSl2ujV835HYPLr1UM12X/WlFfE9qgzCSNoH9O?=
 =?us-ascii?Q?f3sP/Q1q5N118pwPFVV6Rkrsu29FOAyT48ZBsUG0QavOIvMkakncxvBPkRvn?=
 =?us-ascii?Q?AUmoaLTu+A1txnwZMqG1QQj7S701g3yc+zWl6QBn+t5pmMUZ2m6WEfPqe3LU?=
 =?us-ascii?Q?YJnlPZyozgYd3TnMaQnjHp64BQraMx244EEA1dRkMIzVaFuWyChVx0crrOV7?=
 =?us-ascii?Q?FPydzQP5fA=3D=3D?=
X-Exchange-RoutingPolicyChecked: f3fRobMMyICFdeeGFZxdy+yOknsfivChlzAyVm04a2uorkb3xlVPcY3erAYli1a0d0C33TpUFFu6wNqprT4Kj5FS7bJRk8p8tKhBDdZQPJYv8SwDRTlcQr3TEuE9xLejViHAejrq7WW4L+9TgOKGYFTknuViiQqz3prC4m4E4IQ0vnpcTqzuOzPhdqQwa74DMrVFobf7nXM8JZ82reaHvRnfWWd/PwvHIoPJ8Io+X5stBi48CuSKLcHjbKpXN5iF2lJwxudgj++gtOg3mgOK8e4hnzg6AONCRrQTzNiYGrayw9xSP9Y5OL/cpCVPm95/73SHyO1gvVMqz2VX+/cjAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 82353790-fd6e-43e8-6499-08df1d48ca39
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:10:57.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhhielKVps8m4MagJDdvftCjywhLBy/Mvb/SC5OfbG1SP6gg88iev8fh60XTn5A0m0S3sg7x7SU5b4zga+0rug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB896703
X-OriginatorOrg: intel.com

tdx_hcall_get_quote() takes a "u8 *" buffer unnecessarily. It is never
used as such, since only the buffer's memory address matters. Let the
guest driver give the buffer a type internally and just accept it as a
"void *" instead.

AI was used under supervision to collect/apply feedback, review code and
workshop logs.

Signed-off-by: Peter Fang <peter.fang@intel.com>
---
v5:
 - New patch. Prepare for a typed Quote buffer. [Dave]
---
 arch/x86/coco/tdx/tdx.c    | 2 +-
 arch/x86/include/asm/tdx.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index f904a636d449..bcaf4180a8db 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -191,7 +191,7 @@ EXPORT_SYMBOL_GPL(tdx_mcall_extend_rtmr);
  *
  * Return 0 on success or error code on failure.
  */
-u64 tdx_hcall_get_quote(u8 *buf, size_t size)
+u64 tdx_hcall_get_quote(void *buf, size_t size)
 {
 	/* Since buf is a shared memory, set the shared (decrypted) bits */
 	return _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(buf)), size, 0, 0);
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 89e97d5761d8..a3c37d61e676 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -81,7 +81,7 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
 
 int tdx_mcall_extend_rtmr(u8 index, u8 *data);
 
-u64 tdx_hcall_get_quote(u8 *buf, size_t size);
+u64 tdx_hcall_get_quote(void *buf, size_t size);
 
 void __init tdx_dump_attributes(u64 td_attr);
 void __init tdx_dump_td_ctls(u64 td_ctls);
-- 
2.53.0

