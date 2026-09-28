Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B034963C1;
	Mon, 28 Sep 2026 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590252; cv=fail; b=TH2YqR+zBgREUFOv8Z0I0+8Rp/s0XSLyN9adleQHfrkeduL8wBz0A/3hSwjgmssU4tsPEfmQoq2jHusxZve9XGIxw3B5JzL9hZDoefyt86kupoIHbVC5XsMI5zmkjqDdSM7qkoJrFOiALj3XkTg/AiOo0GSMaKQ3CG1mJKBaHtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590252; c=relaxed/simple;
	bh=JoTYXi5XvAbfSeEUECnno44TH40LWkgi4n5DsQJthxQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uCeguLbG4qivtj5hCacda32ikr5sMSP0L0IBWgJ9gVrScBC3iiGh2modH+DMjUXsNCBoYcfzJEpA6NbVISFvqXBiZRRze1zO598aHWFau6+cELoQKQBAQ7Jy1rjvTtmkUd5vINCQNG1N5yzi4Crz8WSRTyvOLr37umknnf82cvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jiJw+Xqi; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jiJw+Xqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790590249; x=1822126249;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=JoTYXi5XvAbfSeEUECnno44TH40LWkgi4n5DsQJthxQ=;
  b=jiJw+XqikUfIEjtDzkYxUlmRyNt1f4iIm+dZa4EYozLeFP3WGWpiFpc9
   sYtgn6ovuhNxtkHq/YOAZKwKZvWBxjQIVUdcwoNbP4Wv62JA8gXcI5fHj
   rwsk9o4rc9AP2Mqm/NGnOZRixJy+uu29JVlngr930ITZ8gZQ6QpzeA1of
   PZQS25b4GDI7VO5kDBvqxj26pePoPdbAdxHEGQobVkYaUV6BTTNQMg4YV
   wA3cMYYMzyJuDnAglQbdKrUlZDwSDnSenKaF5rIQDeW5IM0FA1yxUDCwx
   XUSPIf8IXCrLEFtOPJ1xoGoIVrt+kF++vMZ8gHXmYPcsvkifrt4i79FvT
   w==;
X-CSE-ConnectionGUID: zeBGyaIhTMyTQA4aiWXLkA==
X-CSE-MsgGUID: sK02Lu2eRjumaHSWY5vpWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="116814239"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="116814239"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:10:48 -0700
X-CSE-ConnectionGUID: bnS3PfGpR3yXmYRaknV0Sg==
X-CSE-MsgGUID: E8OxASXYQY6vM4s0nKzmQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278376484"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:10:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:10:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 03:10:47 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:10:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOKTjMxQkDWoC4ZXyL9q4K3nSoqgMiAp5jw4W0AZFCA+fK2dhfz5j48VG7A4KZulHPxLQNqSeHGltW0ENXwKDTxijJW+25QswO6v81Z+Dlu+NkPSKILyxhDXqIFJSnHFa8iSQTAnjyCAExFSx1BnXQNsr3DJvHEh+YOALTA8OPyAKusEzpEqo/w0mAwhygApGR4So7psFI/2GhYQivDSkzvUan8JmcmFNfVvwZbTc4f7IUwz0crrAhbeXDfnF7L7dABY8vWgdEaeJNtxLBQ6LPb7NipY2OZ5wkvMXW3xVX+Kj0kiUdIUCOG+310cUgHSWRKp13nf/pSdq+VKyIRNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W9hIeHXFo2KZhXsBm0vZRot/DLR/dMn1PpRBnMGVvo=;
 b=k+zFTRnFp+AeIE8Koab9bgdHhznhOeUWK2vRm6FvwXfNImus2HVk7E0JcLIHwTHMNf4FH6cc5xH8VGDamBrsIffZA5tuKuit1Irm1FYSV9+p51vnTUphK4iD844wMH/dnpx2wz4zSnTYgp9xp/wYeOEF0kMLiv6pfR2XDPQbXEzPeMi2DXkyuirjsdvIR67bCFfIqVjMZnUfTep1pLI4BUOwPmYFizjnqvZUuRejnxNrxsXwGXc4gOb4r9uXLAbTCVEm5tdHIYsngKpZ7ZfX2PNUBz8t7m1DhS1t6NgEi6sIRObdcohW0fbsp11TqgL2NxEaiOevZCMpbhD8FgbTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DS6PR11MB896703.namprd11.prod.outlook.com
 (2603:10b6:8:499::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:10:43 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 10:10:43 +0000
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
Subject: [PATCH v5 0/6] tdx-guest: Make Quote buffer size dynamic
Date: Mon, 28 Sep 2026 03:08:11 -0700
Message-ID: <20260928100913.2265687-1-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-Office365-Filtering-Correlation-Id: 0012b35c-94c3-4a85-61c9-08df1d48c189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: wgUjLZsmVDyr8A0XHaF6T+51O8Gj4VfbjJ0AF8vAluwzKcejt7VqbCGDX3tK4bnvGsFT5rJ8aEFpv4mPDPmARju0s+D/INO4uozbRjHcXn7s6XhMA6EUGs3AwtI4aYMbKpSVoPhQ+xY4y8N27wGAuspLGQyFXx2P/CNHFoDDDERCdSASeZwMTn9t9RWS21+FL++CBf8TX57A3XhKR+/ebVR+zuZz/ojUaRWGREhSDSYK9zSk6COitbX22XFGhGYz3FFoqWs5dQqD/Lxoyh5KR1aUjR2nmIFXnfMJrZkOO0uRXAgDz4xmx4P1mHDDluNircdULlBhx0EU8zt9OKA5zoiQ3CiejH8MI6Wg6cda2Jrvtb6m0evzMtaRYbetO1CDarkVgTDIU0X9/9GDTqLX3ixb2+YulcqXpV/+cUGNA51MibVvTq2d4pL91x8Hzr26S5joz8ps3WoeFgdwzO0feRStOYHEFWKcvlqBHe+Y9IiTsngSznA/WKQ0XuuxYw2TFCAvDhCtH3ePE5efLTBVkABbWEKMdkRSJwF8PiB7zHfss8pRNHsiH7aityK1xANlCKgyhjVLUP8vWE9eTTmA37uMvM3KcfoL6ReLFaMTB2f93f/AAvsSed0pL7gtQCC7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HaiJ2EJvQo+TEsQjBm2BuY89NXcLRmmvD80cJZMAccLOJ9lGvXrSPKe8CmYR?=
 =?us-ascii?Q?kWnVVXlTPmiC6mnBNeIc0IGSU2VMjJQAuDxO+x4AbvoY970VEN9aZnbZGLSz?=
 =?us-ascii?Q?Y2oGV/YxUjNh9xBNDISs5AP/PK8rEFYwE2FjmjM3bCm8eq2QojBDh9m5tCov?=
 =?us-ascii?Q?5u9xFnxhliIeYhD+IwuYeQgad/qn2FiS+/2XKuvuLIxPNce1nO2337YLIqMI?=
 =?us-ascii?Q?+C9U67vxwuNVEk7IKPBtgfEvQi0pLg3ZzYo5p7g0nLR0h/f+682DhHHK+TO3?=
 =?us-ascii?Q?9gCajPr8s9SxOV7VfXRgzRmy4jwmGGb1UsyP6eM2pKzUtktjZH6B3l9V3eAD?=
 =?us-ascii?Q?JhEKv6cDZ16GSkG9dcS3TPMUmx13Ef1Uf6t/QermA3FUKfrJbOqToMeFdP9x?=
 =?us-ascii?Q?/GMqPAjQf75FiQ8QlH+DI3rnxVh0WR9+qwrPD0t/F3Bq6N04EH99z296KVwS?=
 =?us-ascii?Q?3AY03uwmcDYn5KcYEn9V1Vokt10fqC7LV5z6nofY3VbZH498gIIOgQtIKbzD?=
 =?us-ascii?Q?9hQVETJLIGXEb1Yi0tBklx9OHHd7pc/eqh2jhFgEOBPbUrrEjPzQ6Nu4TYLn?=
 =?us-ascii?Q?M1CrrY0Z4WXPylWOS1c7jA3OXDeoJ3mlB9ce6HdDayEtqQwdAczF32djElKv?=
 =?us-ascii?Q?ZM8tmmD/VG/+uXnKFf34y8RUKillTeKIgiEfLnXJ5hVbvj2ny7vIuCtSUAcz?=
 =?us-ascii?Q?N8WEgoutocPNATEiEaDzarhx3Z3REtyQWAGHq7y+ntUJ6xnL/WR8AVZI6GNp?=
 =?us-ascii?Q?cSr8D9Hx2xJljyZYWBcnWTStu8RAcBnge2GZ+rK23aEbnCEEr0oYzYCRAc47?=
 =?us-ascii?Q?zjphoC4JNXyf3A78RlJsKS25d7wwXgjRTSxQG7f+tOk53qHVXm7LpKh+7C0T?=
 =?us-ascii?Q?58LN4QOVN36Bfzu97bT38m8poTmOI4KjvMoqW+EGCZijDMhTAZRG+lbDu8kU?=
 =?us-ascii?Q?XfL3/MI5FX6OPCbbjWOWBLTZMW6em5k6uhLafp4PeS3bZ4o3ZBNfHuBdmPQ6?=
 =?us-ascii?Q?xQdBjmt6Dq0oaG/4xeVBJlLcU1I1fjv4Iq9sTUK7EZEYriXaOb55RUDAs30A?=
 =?us-ascii?Q?/LcJet+ZueQw/UR20ERAktLF2PqgNu1QCtxeStfrd7yZJ5qkD0lhLhPPlbB3?=
 =?us-ascii?Q?rZBbj+iFQu4xYsMFaahgcZYVCgaYxHqVnHCs/1OsDSap0gNQDQsG31bXyRFP?=
 =?us-ascii?Q?Cy6M2Uw8OEbiKzrBGgaJnG14crOR0kBsbIzQJrhJ+36zX/yHCm7aTyrd/Rz3?=
 =?us-ascii?Q?LwAISLQ1Ndo9InF60TigQSHyJYcJ8SBVhfECuRemDqZzJdpe+UWHJvSJ94XL?=
 =?us-ascii?Q?oo69Q7uO0pcx5B2ieBNwndeS1Aorh4KmcubBsEfeID0rZvVB5kF8LcCmdp4e?=
 =?us-ascii?Q?1f6cCvEBOSgA6j+2mH7h2+PLv2e6Lgh+3oAecQR21ZdGM0CiS/beQ8VXycm7?=
 =?us-ascii?Q?A9Qs1YHFgumoMZsCxuxCqPnWEcMKpMGipnFHJlmMNKjtNNrMzHOSay+wLXfe?=
 =?us-ascii?Q?kP3Olj072KPXyRWHlXwWtlwZXQjg8A0D7f4+CRLdG6FdYqSZLf4aT24JLYFL?=
 =?us-ascii?Q?/Yk35nMXZOBdeXRrtsMPqwdggq2SORRdiRSXcK0KVPtCGjnLpStMW7SKT04W?=
 =?us-ascii?Q?TIpv8JtIeKIJVR1wj1p5XQGw8r9mSr6kb6YCATspCS9MGyx/yM3B9jLFZdA3?=
 =?us-ascii?Q?lvvZqLF6OixGbkPxjkUsyCMf/z6b5BYBQaxSThL4nGNWDaRLNNUhZPNB6OE3?=
 =?us-ascii?Q?GCRJfV0J2A=3D=3D?=
X-Exchange-RoutingPolicyChecked: qK1wCVJ0iCLNrj842cysXW47gcrjRNBBoBxMumM6dXnZ/kd6NvXbPNQH5XzCb8xpghrAsS6mK9NNBCpd6/wqAtiawr+OROeiqE/kliwLordDA462T6aTAZWW3pTYuwtcij0tW7zCm8OGvOeJT30wybvEZrmvmENJKLc0g6iXZ9KtsiRsgWiaw2BzodvBV5Persy3q75ALPrhklydzR7v8JZxh+mzpD1R45HizMYz7+PjTFztuiSpFxnu5AruAr+fTy5LB7tRv0iuNa01LPZB21aIeiOTH0peWFWcJgne0RbEeaev18QBCRuuZ/xzSri/LLAgoNabEznx/p5S6gPY2Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0012b35c-94c3-4a85-61c9-08df1d48c189
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:10:43.3087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRquIqWY7cWpWqjp29dUwTwcoDwDJsI17QVTeeIG0RIk82oKGNbC4m6JGacHWg21vBL970k4XXLarjngyOj/Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB896703
X-OriginatorOrg: intel.com

Hi,

This is v5 of the series to make the TDX guest driver's Quote buffer
size dynamic. There is more refactoring in this version, which added 2
more patches. I also reordered the patches so that cleanups/refactoring
come first, and the last patch focuses on the dynamic size feature
itself. This means they're no longer grouped by subsystem first, in
favor of the logical order of the changes.

One thing worth mentioning is that I used EXPORT_SYMBOL_FOR_MODULES() to
export the symbol to the driver, even though I argued in the past [1]
that this is a new pattern for guest-side TDX code. This is because a
separate patch on the list [2] is adding this pattern to
arch/x86/coco/tdx/tdx.c, so hopefully everything will eventually come
together nicely.

Newer TDX modules have an ABI that tells the guest how big a Quote can
get. The Quote buffer no longer has to be a fixed size. So effectively:

  s/FIXED_BUF_SIZE/queried_buf_size/

... in the TDX guest driver.

Terminology
===========

A "TD Quote" is an attestation structure signed with a platform key. It
contains information about a TDX guest and the platform it's running on.

The "Quote buffer" in the TDX guest driver is a memory buffer shared
between the TDX guest and the host VMM to retrieve TD Quotes. It has a
header defined in the GHCI spec [3].

Device Identifier Composition Engine ("DICE") provides a framework for
layering attestation evidence. This replaces the SGX model of contacting
an Intel server to obtain a certificate.

Problem
=======

The fixed-size Quote buffer approach is not sustainable. As
cryptographic algorithms evolve, TD Quote sizes also grow. A previous
commit [4] increased the guest driver's fixed-size Quote buffer to 128KB
to accommodate DICE Quotes, but it may still be insufficient when those
Quotes use post-quantum cryptography (PQC). PQC certificate chains are
roughly 10x-15x larger than conventional ones, which can increase Quote
sizes significantly.

What's in this series
=====================

To avoid changing the driver whenever the Quote buffer becomes too
small, newer TDX modules report their largest possible Quote size via a
metadata field [5]. The guest driver uses this value, plus room for the
header, for its Quote buffer when available. Older TDX modules continue
to use the 128KB buffer.

Patches 1-4 refactor the existing fixed buffer handling. Patch 5 adds a
helper to query the new metadata field, and patch 6 then makes the
buffer size dynamic.

Patch 1/6: Take the Quote buffer as a generic pointer.
Patch 2/6: Give the Quote buffer an explicit type.
Patch 3/6: Calculate the Quote buffer size with struct_size_t().
Patch 4/6: Read the Quote buffer size from a helper.
Patch 5/6: Add a helper to read the QUOTE_MAX_SIZE metadata field.
Patch 6/6: The final s/FIXED_BUF_SIZE/queried_buf_size/, when available.

Base
====

This is based on v7.3-rc5.

AI use
======

I used AI to help edit this cover letter and the changelogs, and to
collect and apply the review feedback on lore under my supervision. The
series also underwent AI code review, but its comments were limited to
style suggestions and existing issues. Sashiko's __GFP_NOWARN suggestion
was adopted in v2, but it was dropped in v3.

v4: https://lore.kernel.org/all/20260915092632.2822169-1-peter.fang@intel.com/

Changes in v5:
 - Give the Quote buffer an explicit type. [Dave]
 - Replace the quote_data_len global with a helper. [Dave, Xiaoyao]
 - Simplify tdx_get_max_quote_size(). [Dave]
 - Use EXPORT_SYMBOL_FOR_MODULES() instead of EXPORT_SYMBOL_GPL().
   [Xiaoyao, Dave]
 - Rename GET_QUOTE_DEFAULT_BUF_SIZE to TDX_DEFAULT_QUOTE_SIZE. [Dave]
 - Rename TDX_QUOTE_BUF_LEN() to TDX_QUOTE_TOTAL_SIZE(). [Dave]
 - Drop the comment about the buddy allocator. [Dave]
 - Reorder the patches so that cleanups/refactoring come before the
   feature.
 - Add Kiryl's Reviewed-by to patch 3.
 - Drop the Reviewed-by tags from patches 4-6 as they were reworked.
 - Change the author of patch 6 to me, and credit Sathya in the log.

v3: https://lore.kernel.org/all/20260729122939.1340412-1-peter.fang@intel.com/

Changes in v4:
 - Update the TDCS_QUOTE_MAX_SIZE encoding to 0x9010000200000007.
 - Provide documentation for the metadata field. [Rick, Kiryl]
 - Document the reported size's properties. [Xiaoyao, Tony]
 - Page align quote_data_len unconditionally. [Xiaoyao]
 - Collect Reviewed-by tags. [Sathya, Tony, Xiaoyao, Binbin]

v2: https://lore.kernel.org/all/20260717214349.4075994-1-peter.fang@intel.com/

Changes in v3:
 - Split the v2 "Allocate Quote buffer dynamically" patch to do the
   refactoring first, then make the buffer size dynamic. [Dave]
 - Improve patterns for readability. [Dave]
 - Drop __GFP_NOWARN so an allocation failure warns. [Dave, Rick, Kiryl]
 - Add Binbin's Reviewed-by to patch 1.
 - Drop the Reviewed-by tags (Kiryl, Binbin) as the patch was reworked.

v1: https://lore.kernel.org/all/20260612110853.3188196-1-peter.fang@intel.com/

Changes in v2:
 - Collect Reviewed-by tags. [Kiryl, Xiaoyao, Binbin, Sathya]
 - Keep the explicit (u32) cast in tdx_get_max_quote_size(). [Binbin]
 - Calculate the Quote buffer size with struct_size_t(). [Kiryl, Binbin]
 - Add __GFP_NOWARN to the allocation since its size comes from the
   host. [sashiko]
 - Rename quote_data_size to quote_data_len. [Sathya]
 - Drop the Assisted-by tags, as AI was not used to write the code.

[1] https://lore.kernel.org/all/20260623044411.GB923079@pedri/
[2] https://lore.kernel.org/all/20260925131808.2415177-1-nik.borisov@suse.com/
[3] Guest Hypervisor Communication Interface (GHCI) Specification,
    Version 1.5, Section "TDG.VP.VMCALL<GetQuote>"
[4] 43185067c6fd ("configfs-tsm-report: tdx_guest: Increase Quote buffer
    size to 128KB")
[5] Intel TDX Module ABI Definitions, August 2026, TD-scope metadata
    field "TD_QUOTE_MAX_SIZE"

Peter Fang (6):
  x86/tdx: Take the Quote buffer as a generic pointer
  virt: tdx-guest: Give the Quote buffer an explicit type
  virt: tdx-guest: Calculate the Quote buffer size safely
  virt: tdx-guest: Add a helper for the Quote buffer size
  x86/tdx: Add a helper to query maximum Quote size
  virt: tdx-guest: Make the Quote buffer size dynamic

 arch/x86/coco/tdx/tdx.c                 | 19 +++++-
 arch/x86/include/asm/shared/tdx.h       |  1 +
 arch/x86/include/asm/tdx.h              |  4 +-
 drivers/virt/coco/tdx-guest/tdx-guest.c | 79 +++++++++++++++++--------
 4 files changed, 75 insertions(+), 28 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.53.0

