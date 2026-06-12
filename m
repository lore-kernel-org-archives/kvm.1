Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9383644C9;
	Fri, 12 Jun 2026 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262612; cv=fail; b=urUNicQgPqCrS6ka99LhkSTSCsuzje92DT2E/SIR6Qsv7ZCrhztHQ8GciyXGb6yoGPMt+if4RI0wNStg+gh4PVovU8QjLyep3uCyspn8hSw0s73fhyA2z9DF+FOVlyzuyo1YBLuVndC+7wxG7CAO5THjcFOD/c8m9gdbKpF0qoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262612; c=relaxed/simple;
	bh=AOtPuzfMcRM7M8uX8wSqngSTblkf+K4M9krZoay+Q08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KUDzKVoaCvF9riupnqVA2vhoUv7TC/urdsRS3quSsS+kKnrPHQRZ4rBOC9Ih95auW11QP2RcxqkZnzzGs7dWtfsJHfYCaHSS5LwH8KanFj/xOM83p1raZtMfnHffZe4Qm488s4/MjDmcO5mHTzNErDGTfMWqEA639McTbKE6Nmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOlpsto0; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOlpsto0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781262611; x=1812798611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AOtPuzfMcRM7M8uX8wSqngSTblkf+K4M9krZoay+Q08=;
  b=jOlpsto0wC3lWs1KyMJBKLdgxAsvhfz6vnGLd80lrmxw5mtSV/6v/HQR
   XLYOR9/cvRiFJqbO5iB7WeZezq4eG6M3t4SI6SDPBH4904kkprG6X5Tnq
   ssKDB4axUccbuMFeUM0yohh8Cx6kZzJAqNhn/Hlwi7vLTO91hW6MR19qr
   fUyZXdYEwNJYGV10Ll1jPQA/siXF0wwSG0uuhMJdpQkjTkSLLXoUYYSd9
   11r+Y+REuT84u0U97PZ98rxp6tBWVHrItqzw2IvybCbdb6HK70G2gmSbY
   JC23A0plk1JRiZOLHTEMwnR34xtPlARepBRGa+GN9mO1u9hpQgFMhhEmd
   w==;
X-CSE-ConnectionGUID: oajCOjsPSxmC71XYnwX1rw==
X-CSE-MsgGUID: Lb8uqwiSS9ifHi6qlyV61A==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81934999"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81934999"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 04:10:11 -0700
X-CSE-ConnectionGUID: 6NfXb5cSScuVA94Lb3+uBQ==
X-CSE-MsgGUID: EaGRiA1pTSCT0+DIYZ8niw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 04:10:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 04:10:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 04:10:09 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 04:10:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgTpj2nRk9fAMR/zgrL70UqiEkzDbf2Hx9p1Qqk3DSzAY+I4OT0SW3yGBgRryAhpl9CRCDdIHYZIEr6ZkmPiWEnCeYf4QIAIiZmtp6HJDwof8UC2A/8vxshLsZRGNKE4cxaVxckoAnbQmBlchrjcyt1DTaUl1qyhnj2GcdO32jiixWhA7XmB5yHBiW6n6HqDI4M2YTRvSbvhU7HIaea8Yc1yliwdhP2dc7TROJqYPbjpVwRcf3ecOQPF938gQtT9biHhZsVttUSZfvfXfaUo405NblH187tPouVlZKZfc2Ctr1haAC50OAEuYFPVUydumXCMUipwd60uUQn6i8c9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtCqTvYCv9eXihMUZMpEQo6JEC8TUB5R2uMPq/Ql558=;
 b=srVUIHpfjiGSB66kePWonj3TtsNeDH00U1xodfktNkha+8tta+2XkBvE6MOATF1ek1zz3cotAcRSwwGU6OAM9TjmffXCDzQTf+Olqe50aWqEpisleymjsvjuLv2Ktb7rBk6QrzDw8IFoPKtDtPPL8a5MOw+44wFw4i8Js8DeITHTDnSv3xWLQqWuEOXS6BGFdhpAqeu+E+CG+M0P5uYW6rkkgW3gcUCVRsyZfp4ym2iMoSNYYn4Ne7EHcOBwe8z+1+b1S/cdSF2DHUEx+7y9ykIB4efuQXGbCU829cBg18lHmZd96maZdTJjcRtJ0C2zeKnZSFihog520KEbKX/+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by PH7PR11MB6452.namprd11.prod.outlook.com (2603:10b6:510:1f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 11:10:04 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 11:10:03 +0000
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, Peter Fang
	<peter.fang@intel.com>
Subject: [PATCH 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Date: Fri, 12 Jun 2026 04:08:49 -0700
Message-ID: <20260612110853.3188196-3-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612110853.3188196-1-peter.fang@intel.com>
References: <20260612110853.3188196-1-peter.fang@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:a03:333::24) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|PH7PR11MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 16bceac1-d944-4ac0-369c-08dec87326ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Qog7GVH+KBDxmtoNBT2SssqlYSj/JhevXdlkoVZqh78wiRKr1RfhLszY1duYpoC9nMZc/5OabDi6yVmbQXikihsSi5ZZcmqvcX+7R41br+dh1cq859xVrkC4PNhIb0PwHEAIu5hgnuf0qDWX1h62SO30MwKVv6lyvwRAFK0jbYdEhvQ6sT0r2rKrpQcF15H4MI34NrPeW053LRMIzfqWH0ByKhXhXAUsZNN49RwXeFwhtKCpD3zYThScdE6MoGyE4o2hXIv4JLf2IZpvbA85iUsMX294s6h0+nye/K+mF1hAwv3HxsI+pD04SJfkFhL/yxozCV7DYPRML+YYGY7MiZmQ7TJcoUw6K4dYfumV29o/dG2BKpLcOfdODuL3y6rY4D7DG1ZYCYaBfXfhREC42gmsY+Xdnu1kkURxwXWwsoqo6stu06AlJFlgxK+i6zGUIShL+pEQKphhSSJLT8geHzqkJbEyia+L+L+yBaQbfNeL1PxXHsJIw5cSLZ0oAguSJhJ9xpEZC1FrgmImLsxvqd3V2ICjsmmwpNfSFrqpUu3dbWGitEg76P7ueMGcOQadq/jYlhMa3mZJEKzxk70+PU3RW7vkyFYPpyF3DXOJD+aYyxLnltKmHuZv0U2PhChAYx5Ezc35KxkD/GsabVLDb2sll8UgMSmvBthOgK/fIPK3v4NJ5J2uPqsr/8xIYQp7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pUtiSXC2nfny+WIsxwl6DLMNGgHxR4tH2v6moiLR9q375f64r7j+Xzcm3iDS?=
 =?us-ascii?Q?SEHAvG6h6bnXrAdRnBRbDjMjWdsfYT4KCjOvWYAFyjAtP3ju7oReQKO5dAwT?=
 =?us-ascii?Q?GjLPthWNNn1OAu56JknzAc6cwTeJB2CJ6Dz9J5bDDdodQ96RkLjk/nS/k1C2?=
 =?us-ascii?Q?FYyofbIbrT+xJ+yQ7+WGGd3TPpNzNltwHB0/amuWDRVh6SYM0bxH5+wwOb1L?=
 =?us-ascii?Q?JEbjR4QuqGXdGDEalLn2JbHQiMhRDR0o3oo2bfjOQKWHP2+4wsLQU/I4/Zcg?=
 =?us-ascii?Q?N/7YdTvzy5KcCn4jDSmekRT+KEfRXS/oU9znJjFOri2IuMQ/EoV2qPGqz9XV?=
 =?us-ascii?Q?2nQf63ARnD24nvorWo48AqqRk4KvghForsuuEaviOvTCs2h3qsIh+WcZnVO1?=
 =?us-ascii?Q?xAf0p8BECGC9ogMeDQLEzALx9EUP9WeVbrQYd7vHN0Ti+uxCqH4pDYbVh3K2?=
 =?us-ascii?Q?UciD+V3YjnJXPktMjZxTMdtkJc64Oowh9jmeAq1ltk/QGBtYKGg7GHkQUQmF?=
 =?us-ascii?Q?TxDm8sCsyKnPtzrewr9yrzdIBaWa3DXe7tbvZi9F1621rdfK5fHnFbKuHIyq?=
 =?us-ascii?Q?pBEOa6gyu8snWkVrI8odfe1W1StEQnkxSRjNT72ixE8zP9SbaoJ+yBawabAq?=
 =?us-ascii?Q?1Vneo+m0+hGfoirKYdesVIo3mBZ1w90DPGv/ARPmtUhoXQAGJdBFOGx/KRHf?=
 =?us-ascii?Q?xyZqEgil741hw5g1Owe8KRWdcghQMjQOt0ctr6iBGvhmERGS22eb/O6SHKhD?=
 =?us-ascii?Q?aJo78WXEG0DNIq4P6SkxvL3Txz/g4STBTfat1UhPui8ioYQi+N2RX3dGXzzM?=
 =?us-ascii?Q?Xu55pRdVSpXctz+GZhY0PHUmeqcZXURUZtMobHn3HiEczN1eet3Rqq3V1TQO?=
 =?us-ascii?Q?DVvBE9JwSPgEXLSlb6HLrW32nPd5tQvwHuu5UR7misFgEHU6wfh24sDjnqah?=
 =?us-ascii?Q?C025ZG15elzVfMRz7uezaPeUAF9u+8B5lH6VlhETtxxhQboO9HjmKAdHeq/E?=
 =?us-ascii?Q?X2tUEG/4dN3krdToLijp73uM3yTisD8iPyShRWXOQ7aJuuPGnjk/iLnAyAME?=
 =?us-ascii?Q?BgOh3QOWOy7a8GvFZCsTx7mTMjUj4SYzBNlY6YeCorP03xcqrYHsZ9suYUrF?=
 =?us-ascii?Q?4ajRnyuM9/Sk/2opRivGIo17Sntk9oJTLOG5y0Nbj5HW9LCExhv2XdLsiBra?=
 =?us-ascii?Q?/hMO1ENhVbMMYZKCTubkm1//3BrbhV3H7buxpvCPyiWmIU3CPlyY9O6IR5nb?=
 =?us-ascii?Q?2dNxByOPEOycA3TMb8Pz+m8sfdCrRpASFNmnv0ocrg+GjrSILblPfKT/22oE?=
 =?us-ascii?Q?KA6dbMR4OobFf9AkzVS025zZwYDfvEXBxO2peFDrNFskdHbGfN6xrMd7zJMX?=
 =?us-ascii?Q?rEH3oSok0kNbeOjhEeJqghuQnUBMq5xt0IRYuTxdpF28jo1b6VhlnUa+YZqW?=
 =?us-ascii?Q?jMgiM4cmmzyf15yKe/0XloE8WqQTC0C/DdAJCVcYjNcNxJwb66TYL2Ph34yS?=
 =?us-ascii?Q?hiuD5c3fUklw6hix9+DJrZXSB5KJvCnflxsEhAfkLym6+R8OYqrvRDGfwXlH?=
 =?us-ascii?Q?fFFJ5CN83hmTGW86TJWNBIYYcrRG/FudvJWQ7LfcjW+gm8WYKpHDOZ47Qwcu?=
 =?us-ascii?Q?M0srqj3rWpOnklMVSK2IqJkpvdO6cU+ATcxVaNgMUlKcTIC+kqtJJURHibnd?=
 =?us-ascii?Q?O7Kh6abLouXMNThjJkW1zs9BsWUwmCcJzk4oz6DsYuCSptK2wQX3avWiZgy6?=
 =?us-ascii?Q?M4hMp0c93A=3D=3D?=
X-Exchange-RoutingPolicyChecked: XlxdgpXHDnwfs2Zl+cOvUV6ay90vH4E08AtIWLg69FOX+wsO3UysI3RmED6sycO+57VjKms+jvee5P5WqH3cK0W8yRzB91FaOHrEKKXleqG/l10h4n4EJF5yMmgeByhHZUu7dEHKApN5UVqTWMebElYqBU6nSVGWzCYglibayL2WgXncaMM+jtSzZXldz7DhG+3aH03FnSMgzwDnE5oUz6utTLmaxACORHhZBEvDsp7oMOU+5PXxACCDqlc5lMVKjhKDQf9bGlDwp7fTLajpMSuYOYt7yLvWzwFJM5Oy6SrHO3yetVeUZkRQHZyLXZ1mbYF8SjlctyZSXnMMnBGNIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bceac1-d944-4ac0-369c-08dec87326ca
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:10:03.7600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ztRiPT+1QKebMq0m1R5asarBk6Gg6FYtC6QgRIBeNCdr5zM0cNMUjGdWWduSJn1UpfgGz53E5ZJBmfHWdcs2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6452
X-OriginatorOrg: intel.com

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

The TDX attestation driver currently uses a fixed 128 KB Quote buffer
shared with the host VMM. This may be too small for Quotes using schemes
such as post-quantum cryptography (PQC), where certificate chains can
increase the Quote size to several megabytes.

Allocate the Quote buffer based on the size reported by the TDX module
instead of always reserving a fixed-size buffer. This avoids wasting
memory on platforms that do not require larger Quotes. Older platforms
fall back to the default 128 KB buffer.

Because the Quote buffer must be physically contiguous, its size is
bound by the buddy allocator's maximum page order (4 MB), which should
be sufficient for current attestation needs.

struct tdx_quote_buf has a trailing flexible array, so use offsetof()
instead of sizeof() to calculate the header size.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Assisted-by: Claude:claude-opus-4-7
Assisted-by: GitHub Copilot:gpt-5.4
Signed-off-by: Peter Fang <peter.fang@intel.com>
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 52 ++++++++++++++++++-------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index a9ecc46df187..162fb47f3fae 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -163,7 +163,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
  * DICE-based attestation uses layered evidence that requires
  * larger Quote size (~100K).
  */
-#define GET_QUOTE_BUF_SIZE		SZ_128K
+#define GET_QUOTE_DEFAULT_BUF_SIZE	SZ_128K
 
 #define GET_QUOTE_CMD_VER		1
 
@@ -171,7 +171,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
 #define GET_QUOTE_SUCCESS		0
 #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
 
-#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
+#define TDX_QUOTE_BUF_LEN(n)		(offsetof(struct tdx_quote_buf, data) + (n))
 
 /* struct tdx_quote_buf: Format of Quote request buffer.
  * @version: Quote format version, filled by TD.
@@ -192,8 +192,9 @@ struct tdx_quote_buf {
 	u8 data[];
 };
 
-/* Quote data buffer */
+/* Quote data buffer and size */
 static void *quote_data;
+static size_t quote_data_size;
 
 /* Lock to streamline quote requests */
 static DEFINE_MUTEX(quote_lock);
@@ -210,9 +211,8 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
 			     USER_SOCKPTR(req->tdreport));
 }
 
-static void free_quote_buf(void *buf)
+static void free_quote_buf(void *buf, size_t len)
 {
-	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
 	unsigned int count = len >> PAGE_SHIFT;
 
 	if (set_memory_encrypted((unsigned long)buf, count)) {
@@ -223,19 +223,43 @@ static void free_quote_buf(void *buf)
 	free_pages_exact(buf, len);
 }
 
-static void *alloc_quote_buf(void)
+static size_t get_quote_buf_size(void)
 {
-	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
-	unsigned int count = len >> PAGE_SHIFT;
+	size_t buf_sz = GET_QUOTE_DEFAULT_BUF_SIZE;
+	u32 quote_sz;
+
+	quote_sz = tdx_get_max_quote_size();
+
+	if (quote_sz)
+		/* Reported size does not include GetQuote header */
+		buf_sz = TDX_QUOTE_BUF_LEN(quote_sz);
+
+	return PAGE_ALIGN(buf_sz);
+}
+
+static void *alloc_quote_buf(size_t *buflen)
+{
+	unsigned int count;
+	size_t len;
 	void *addr;
 
+	len = get_quote_buf_size();
+
+	/*
+	 * This fails if the requested size exceeds the buddy allocator's
+	 * maximum order (order-10, 4MB).
+	 */
 	addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
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
 
@@ -286,7 +310,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	if (desc->inblob_len != TDX_REPORTDATA_LEN)
 		return -EINVAL;
 
-	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
+	memset(quote_data, 0, quote_data_size);
 
 	/* Update Quote buffer header */
 	quote_buf->version = GET_QUOTE_CMD_VER;
@@ -297,7 +321,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	if (ret)
 		return ret;
 
-	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
+	err = tdx_hcall_get_quote(quote_data, quote_data_size);
 	if (err) {
 		pr_err("GetQuote hypercall failed, status:%llx\n", err);
 		return -EIO;
@@ -316,7 +340,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 
 	out_len = READ_ONCE(quote_buf->out_len);
 
-	if (out_len > TDX_QUOTE_MAX_LEN)
+	if (TDX_QUOTE_BUF_LEN(out_len) > quote_data_size)
 		return -EFBIG;
 
 	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
@@ -418,7 +442,7 @@ static int __init tdx_guest_init(void)
 	if (ret)
 		goto deinit_mr;
 
-	quote_data = alloc_quote_buf();
+	quote_data = alloc_quote_buf(&quote_data_size);
 	if (!quote_data) {
 		pr_err("Failed to allocate Quote buffer\n");
 		ret = -ENOMEM;
@@ -432,7 +456,7 @@ static int __init tdx_guest_init(void)
 	return 0;
 
 free_quote:
-	free_quote_buf(quote_data);
+	free_quote_buf(quote_data, quote_data_size);
 free_misc:
 	misc_deregister(&tdx_misc_dev);
 deinit_mr:
@@ -445,7 +469,7 @@ module_init(tdx_guest_init);
 static void __exit tdx_guest_exit(void)
 {
 	tsm_report_unregister(&tdx_tsm_ops);
-	free_quote_buf(quote_data);
+	free_quote_buf(quote_data, quote_data_size);
 	misc_deregister(&tdx_misc_dev);
 	tdx_mr_deinit(tdx_attr_groups[0]);
 }
-- 
2.53.0

