Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9950948D890;
	Wed, 30 Sep 2026 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764699; cv=fail; b=Oja/aP7m5IM+bJOmfqevov1GWyl2Vy/0qTwz2epMdjsn5iaIcEYUc4CL38CDYzkkRl94epzd5R3JOFie7Et33qXoG2Q3Auwm/qIdqr0qWVfPztc893d1z61u24av8n3QIeyILfGu+FhQ6b9x/opHutSLrxNRWXtVWrU261MRcJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764699; c=relaxed/simple;
	bh=sKHb4wLIxY/1cjpcPhBxXosyP9Rqbinus8xfo++dT5Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=noyesQPpABHkypNwPN9T0L47PNCfToJf8KKtNgQH2pyMgoNHuzyc1E7x9G+C7i/DtYaXi+62IDkSkUR1/kDX1aBGf55UVD7SiFqQOmOoHtgyeq68+AzHNqHDe96wh1zHFDB36E1aJxZ625auoZQj/vuizkkAScIz5q+KMEOPTzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UtvC5vga; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UtvC5vga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790764695; x=1822300695;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=sKHb4wLIxY/1cjpcPhBxXosyP9Rqbinus8xfo++dT5Q=;
  b=UtvC5vgauWDEOa7RAMswSaZ9S7bWoKThvq+KcHPrPjuguIDsELURkU2M
   kRZbUME2ocVBJl3EnvG1hOf1Ctu7MycOL6uHsqZDyCZ0ISwxVe3F4654K
   axyqWuPD6P82efrXf6tHDoZdzW5wXrysMeiEV+ckZzoiWt7nPihRRIYrd
   hF+iCbiTp4qVc9EaQfq6eyMlaypsGepHvedKjS+NgRQ77/Q7LPIsf7KLL
   o9CAL9g4p8IuuVnxIrg2j2qnknm4ca/sNAsUP32ycrcHf1cDcQwpWxjDr
   Feg5ATc3XuMihNjwg0/zXkdahKIe9bxmp9DnADU/t45GLL2uPCiN8+ynn
   A==;
X-CSE-ConnectionGUID: UhTrcEXFTFKYXxmFwV0OmQ==
X-CSE-MsgGUID: /m58yXhKSrulwX2T6jCTlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="79066276"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="79066276"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:38:13 -0700
X-CSE-ConnectionGUID: 2/cz0zSHRG65mjw2ZvMMqw==
X-CSE-MsgGUID: t0/Py3dHSIaLR3tncol6aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="303588994"
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
 b=n+Dqa1bPP3H3BjdnBTUJZDw/PK4+vJkKLxY7MQet5ZYEjUav1Z5XNBjwazpI6sEK/d38vRBjcM/C8tD34YX3HW18e5SuTGprqK2WspA24nUOlgttwwoKi2jvy8NFCAyTPVzGE/Al9J5lXxopkV6PHf/8GpLzir9C+HUrwVsFcy0mGERCqi4woRFeXFPQN5kost6ZqWlgAWz5yMFZvuXJ1bsbJAFtLsOov0rTUVgT4lOQIFAqG0PQz2RrbkoMi2WWy64uGOlMP6MY4ICbdsv1ganr3351qPEuYyEHyJ76ykJMFrON/EEX3Ll38xKuxz8pwXJMxRzLz7NV4vhYuhpNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quqMHPIGi4Dxw8DzAffa//zRCc+QiWoZrIaMdm0CFgM=;
 b=YxAXAUcHFqsmhbAVf63fXkY+FcYRhLK3JkujMU+ceVz56kvkdHgsSB+IaSRLMYWKd9ZTIiXWU6PnPLmrLWmPTBwfXej427CHPaAGHmEImPfVDCGSKovTrwVC083YDPXel+DA2Mh9UysAFwGKUKSoS3IxAAs6edAc4+Bu0W0O388xq9rGZAF5Obw9P1Ewyuud71j04XUSW8tfukzXg4HavAP8hBJHBMFzFKchGeTAOwCUCjU8QU4G4Ev8BkI/GHDBAEHC1PrSAhu5Hmg/lHfzoiWiydx5Be+T0Hhfp0pm4PfXaij3qQIud2Q05tuh0POX67haIdS+8oFLnZqhkYeimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CO1PR11MB5154.namprd11.prod.outlook.com
 (2603:10b6:303:99::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:38:08 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 10:38:08 +0000
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
Subject: [PATCH v6 0/6] tdx-guest: Make Quote buffer size dynamic
Date: Wed, 30 Sep 2026 03:30:49 -0700
Message-ID: <20260930103739.2851980-1-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-Office365-Filtering-Correlation-Id: 5215bdb9-d5df-4957-dd6a-08df1edeeb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|10067099003|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 9C9j9a/2ocCDW/s774HzV0wDNG/8/AHiNUEuqOUWMOGfmdMPsaH6sGlQLdj9/nr2Zx/PSfr/Pk1l0pKtpIRSNoe2vtwngVoNU54GwViR1dyqFbwEpO076xd/X5rN30KomRyZqusO8BQKS6E+SmZ3nMARMDbVWO2zzF4prMacv1WgTTFgC6N2sYxa6M8sKO6TM3Lwsqo+ENhT35lU6/QgFKl8SaBytos1ZgG23pt6CVK2AGqitDAUr2WsO77M7SrEB1hSPrAtfFfi37NGJWHQozWMkxfHJYXjOIZP4OAkYHTQyY69VXu5hYwxilStlMQfKFN5aHGzMjkWX1h9/zfbdHbT0kmR5VPIa8MmONgF1eGFNt5HItEmZT3HDWk8UPMwt9towiHJzdeothnSxzuDSHGojYkyAyv+DbVXakcFOVfB4fW/OSTc5uf3oIWaoG9rn8L9auHxXeiJdvydaghcrHsIfEy8i3oL6du4udJoBJhxSeyxxu+/BQbOhU2NBkB5Nx34wEEPgZzOZ9OSuL485juwpp4V9pMGkyhgBmhq0EciMS5XIQ58A0ye7G+9uvwPh5mPYtyktDlnztnRZ03C9ClPU/IEn0m/2IEtjQQx35JQYxfI/EA0fL5qp9bW1bup
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(10067099003)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VsbE4NbwhfPgSxeWTGCtKcjGIGjOpQb2SXXcPDfXlclvC0zcQAbU90SmX1Nq?=
 =?us-ascii?Q?K6QWnSJPm/enGImIzOvCP/QoUMk8mVVO+czfYMhCSYIgwSM0Ckny1H5vIT9B?=
 =?us-ascii?Q?PkU9zbcQE6RV5VZgEcC0pEkYtKyqeBY6yCKjzdwGedbIdIYqzHE4DWUuYYex?=
 =?us-ascii?Q?4cFL/uoFc8z3kn+0FO9TGwe2a1HSSFR2BjPXO+pyT5C9CFA6m9s1K84GpCoW?=
 =?us-ascii?Q?m7spbAKaWlqn0ymdmEghTWbibgs4yaicoW9XdkGn18f1sYne+oShwIFVCxEl?=
 =?us-ascii?Q?VJF57YRFUOA0KcJzgdnFDz1OnHcx84G5B14yFb7ePvZATT5Bzzv2RNWbKvFc?=
 =?us-ascii?Q?KhgHf8oW2yHH+6M7rkBsdpVdNDXBx1tBDe2g67MZ0QPcMIE5YJqgE2XcfquL?=
 =?us-ascii?Q?31y+fZ9h0QDSxREC0lrtgOSbO3tdE8kDRo2E035a5xZO0dP8D+HuZsrLHjUh?=
 =?us-ascii?Q?okMwXGQjlgU1HUvheRS1mk6nMBv+EAtGQ1ElinX5XEyFUi9Q9/o+FcPLAtsA?=
 =?us-ascii?Q?irbSy1s6DDXLLKT5GDTy3h1J3UFC5j8gohhISL2rkCpCk7Rs+yjTO1dVhSAS?=
 =?us-ascii?Q?HrltskfXiZsTZHG278evxMgpBKqEocUxMsE3fdLM5h3iYW1p/KQB5ZBaC4jb?=
 =?us-ascii?Q?0tZVb4yPDSDvHGFsE4RcBRO0d+6vYA4ALQBt8yCGeSCXDjgm52lHb62uH/bF?=
 =?us-ascii?Q?DQTOk6ay1AGB7c5qGQPJEzrfDe+gSmxVa25enYVcK/A6PPw5RuidV825kzwI?=
 =?us-ascii?Q?AjxYRwGCmfAyLrq9PyBB0qhJYsVu54fWPwAxOqLkLlpcIyZCwlasYAD14ekA?=
 =?us-ascii?Q?IAzCT5hRBT9LBvMqo3C6xD6oFXklbV9u5QzJyeozmhf8vHcDPHClJqc8eLu1?=
 =?us-ascii?Q?KTZ8f8Tz2CAYFgU5lJ2fhAjXhBh0Pc0EyLMq8+F2oHLuHqP43y94l5MQthwW?=
 =?us-ascii?Q?FvcxqmHi7mL+Fv17BFEtwkIaLAkT2LGhyFCgq0eax8rfnwmPB5e31hCoZ/5u?=
 =?us-ascii?Q?cUDhX7GmnpuaENHBZRl1UYvanWLcJSCrdDzHEl3psWzTYbzPVdme2z150BpM?=
 =?us-ascii?Q?fPnNIoyHrDAkVofyBRsdLglo1Oghxr+3Xwua92I4akA9tG0duJPg2OioVYv4?=
 =?us-ascii?Q?QQCuhFzxIa5RZ8MmMPSBcGLElXxJq3SAY+Rb8Ljv5QCUJsJhrsqEgn/4cv+M?=
 =?us-ascii?Q?LC3kQiv+189Qso3ujRHj3P2j3CQ9JqBEbNVWWOVQ3sULVSh6JPIUm8UcZ+8O?=
 =?us-ascii?Q?kdj9O5i0d4KKI15usrWf9ZExEpFDfGL3RwivLJE4kVFzDjrHKRta+nvmU72Q?=
 =?us-ascii?Q?ov7kyZWK+sUbhSbUdkY3NL67IsFXT1xb0dus/DUzFc9CzuvHSYfSme18l26W?=
 =?us-ascii?Q?ggldVEgsFzjm50lGeArsG2LueRU8NaTMyMVvB9reS2lZM60B6kTDmINFotu2?=
 =?us-ascii?Q?aFX0avVhkxgCma4wAQ85s1OryUTQbpIOY38jQ8aQ+4EX0+dGEppOjJ9NoenL?=
 =?us-ascii?Q?8r4wwHhYmoBPMq1x9Nq24hFmwpgKbxZrkO0Lf83euMYjbmrNstumjhv4G/av?=
 =?us-ascii?Q?3SKF1jOc/UTwSn7NQBhCpNRGfz9pPS6GRi/+GprzhoS58ChEUgk/93CkqBmi?=
 =?us-ascii?Q?HJFiRbBePbGUCNZaQsXjHMBiUXBJF4f0EvcGPz8Wlz6pe9eqQB9XxcWboYkD?=
 =?us-ascii?Q?WW5+Y0OwgHRjxAZ+VaD1+ZwCmA6aROKkXqt5n5QevNYPfiac4xL54Cy7FSz8?=
 =?us-ascii?Q?/7qn0RKldQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: Q2P8dB+zKOefjmTN0hGQiNpSb84LZXrc3AHlLZtS7XLxjP9j8KyzVk9AD2BjTSNFIKfnuAg62URqlIemUpY74JfgRhvxXj+RI2bwirsthrcoqWvbQBraxUgNw4XfZRiquH4xRSJlmuMuxPnb1WVdwRuQlv1oVWA4ckeIVRqbLMTymCOIlHjtlx8upr3b8dMD5r7dZ/cjgaGrpiJ3zVpM7PvJVwCai+R0ZimfxxO863zQX7e+jdfb8oUUgKSKUjoWAzNOrbPJD01dQIOWScg304XVSP2wZiL58d4SFykBpXYwtlePcXOf2fTTrPjGRbmS5c4EqXEyd5jdUa9FiCyrxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5215bdb9-d5df-4957-dd6a-08df1edeeb15
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:38:08.6473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8j92oniIiYH+he4IM6Ev4M3Hkt27q4fk5aM72QMgx62FJBeIAMAVbx7ALVSax58CXsMklcKN4402eRKQWkUnwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
X-OriginatorOrg: intel.com

Hi,

This is a quick v6 of the dynamic Quote buffer size series. It mainly
simplifies the buffer size helper. It no longer caches the size in a
static variable and leaves the page alignment decision to the callers.
So overall this version adds fewer LOC (7 lines fewer).

The no-cache implementation is based on the expectation that the TDX
module always reports the same size limit. So there is no need to do
defensive programming against it. If the host somehow manages to load a
broken TDX module, the guest is already compromised.

Another behavioral change versus v5 is in the existing -EFBIG defense
against a weird data size (introduced in [1]). v5 uses the page-aligned
buffer size for the check, while v6 uses the actual maximum size without
the page padding. Even though v5 doesn't cause the kernel to expose an
innocent page, v6 is the more correct behavior. Thanks to Rick for
calling out the page alignment issues [2].

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
Patch 3/6: Calculate the Quote buffer size with struct_size().
Patch 4/6: Read the Quote buffer size from a helper.
Patch 5/6: Add a helper to read the QUOTE_MAX_SIZE metadata field.
Patch 6/6: The final s/FIXED_BUF_SIZE/queried_buf_size/, when available.

Base
====

This is based on tip/x86/tdx.

AI use
======

I used AI to help edit this cover letter and the changelogs, and to
collect and apply the review feedback on lore under my supervision. The
series also underwent AI code review. In v6, it caught a missing page
alignment for the GetQuote hypercall. The other comments were limited to
style suggestions and existing issues. Sashiko's __GFP_NOWARN suggestion
was adopted in v2, but it was dropped in v3.

v5: https://lore.kernel.org/all/20260928100913.2265687-1-peter.fang@intel.com/

Changes in v6:
 - Rebase onto tip/x86/tdx.
 - Use struct_size()/struct_size_t() directly, without the macro. [Dave]
 - Don't cache the Quote buffer size in the helper. [Rick]
 - Let the callers page-align the Quote buffer size. [Rick]
 - Add a comment for the Quote buffer size helper. [Dave]
 - Document that the reported size is fixed. [Dave, Rick]
 - Improve comments and changelogs. [Dave, Rick, Binbin]
 - Add Reviewed-by tags to patches 1 and 2. [Rick, Sathya, Binbin]

v4: https://lore.kernel.org/all/20260915092632.2822169-1-peter.fang@intel.com/

Changes in v5:
 - Give the Quote buffer an explicit type. [Dave]
 - Replace the quote_data_len global with a helper. [Dave, Xiaoyao]
 - Simplify tdx_get_max_quote_size(). [Dave]
 - Use EXPORT_SYMBOL_FOR_MODULES() instead of EXPORT_SYMBOL_GPL().
   [Xiaoyao, Dave]
 - Rename GET_QUOTE_DEFAULT_BUF_SIZE to TDX_DEFAULT_QUOTE_SIZE. [Dave]
 - Pick "size" over "len" when renaming TDX_QUOTE_BUF_LEN(). [Dave]
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

[1] c3fd16c3b98e ("virt: tdx-guest: Fix handling of host controlled
    'quote' buffer length")
[2] https://lore.kernel.org/all/42975a72efc3a0f96200c065cb86970e8f452625.camel@intel.com/
[3] Guest Hypervisor Communication Interface (GHCI) Specification,
    Version 1.5, Section "TDG.VP.VMCALL<GetQuote>"
[4] 43185067c6fd ("configfs-tsm-report: tdx_guest: Increase Quote buffer
    size to 128KB")
[5] Intel TDX Module ABI Definitions, August 2026 (community review),
    TD-scope metadata field "TD_QUOTE_MAX_SIZE"

Peter Fang (6):
  x86/tdx: Take the Quote buffer as a generic pointer
  virt: tdx-guest: Give the Quote buffer an explicit type
  virt: tdx-guest: Calculate the Quote buffer size safely
  virt: tdx-guest: Add a helper for the Quote buffer size
  x86/tdx: Add a helper to query maximum Quote size
  virt: tdx-guest: Make the Quote buffer size dynamic

 arch/x86/coco/tdx/tdx.c                 | 19 ++++++-
 arch/x86/include/asm/shared/tdx.h       |  1 +
 arch/x86/include/asm/tdx.h              |  4 +-
 drivers/virt/coco/tdx-guest/tdx-guest.c | 76 ++++++++++++++++---------
 4 files changed, 70 insertions(+), 30 deletions(-)


base-commit: a49e2d257594931772ab8f0024708c3076f3aa1d
-- 
2.53.0

