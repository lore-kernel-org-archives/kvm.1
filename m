Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252E9439F83;
	Wed,  7 Oct 2026 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791411830; cv=fail; b=jmlhMZ/zhXUSZjHXNV2Le/Wwerqwc/nF/PN99pOh/Y6JO6GuiiBMd5kml9QEk8q8kWAu+Yv0cR+fQTnBqZw1YYI6zLoHQaKGthN/VDsPFMc3kk5ZNbUU4Th5Mn90NmIpOCYhm7kYwjKU9pNXmH5dklrVIahPimE1snrDTb0lcaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791411830; c=relaxed/simple;
	bh=F54uTM9RbFphHCzKzegFVLoIOhVp81IZwBxe/5eFSp8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uwLIArlLyo/Qlw8kn72JxS39mtAOIMHhSYjAHOWOlr8QUY9zlBNO9/X2cDU66lBJaenml7loSNQAVqM+1wxdBmXOIBTgF43hdU/h7juDkqAswTHwWA1hI35YKjQvXc1N2nfxB+Q+ru5G9T08g/uNhtGSVVrq4rTmpPw2upWzohk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2RXDX6a; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2RXDX6a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791411830; x=1822947830;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F54uTM9RbFphHCzKzegFVLoIOhVp81IZwBxe/5eFSp8=;
  b=k2RXDX6aH8anke7dw8Q9mg91CzAQzIA0DJE0wTUIMhk3gAxarrWfbeDd
   B4Th0RioXDFN4K5OclZ4pdgkd+xcDmUI4NBT+s2kkcZmyOsLzxpPbiGkZ
   nRo3WPSqI0+FeQTTI3kMcyC5TqqeYTouz3XUdCb9YevPvvSQ8XDwA/NRi
   6Xohs4qsQNgRTSVJyi5Axy4He4WTAtc394Ds2V85E49E/Fabg8ny6z4FG
   Z4NGAxLLFmoKJ4kZqcqj2/PiKCcM67yNCfOUU3Zh0a5YEb/uZO42Pnayt
   8rw7fuXWvPuFLb+996bzXvZl8EmQj8UbeMKhBsb5QU68NEZBYKOgt0rCz
   w==;
X-CSE-ConnectionGUID: aXI6Yat1Toi7w3RpqZ8ROA==
X-CSE-MsgGUID: XvJD+4z0RAyQ3/5/B16qzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="188397"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="188397"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 15:23:49 -0700
X-CSE-ConnectionGUID: 4XIf6n1YSUu85nDmbWjIvA==
X-CSE-MsgGUID: DEq0xY8aR2uI1fimy3JmhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="282380092"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 15:23:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 15:23:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 15:23:47 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 15:23:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1d93naH+laH86wnmVlkWORfEoLAt3imzISi7RS8fGwn6LAIEM2WAleAbjSTF4LlYEbdpAm7Ubtt8EcaVHqGWmx1YDvPAsHBlxev4BngJlB/3tVN8vZ65hIBokvjulZXlJ8BNxPTzzJWvy5St4/Mk01qWM3JPCDZSL1a05aaDBB5Xfx5tD5gPca0bMfaWyaVrgTeQhJN9pHJjRYkkUuoERMXEZJG8QPANzaSHuJ5LWjgsXMSmjXXGNAuPvcTchcE8zIUJjpaqRU/IC1yMD81ykSUBP1rYns3UFxLgzcKk84AnRuUedG/Qo0Bo59GoUh9r2Ih54ElB5fZ/TvRjVT0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi5ZYFAjMmnBhnAehnwKOzbZdG+Yr2mRDTKX8IU+ANo=;
 b=tmPJGfygXI72F0wk8U/+osbCaxUovUo2D9GmUrpaFF5dyY5wsVQn0KJIOeFGaKJODBPCYovN8i1Cl3y1IipEHRobal7vhul8GSb+kMd9GIVAyBRSyA/hLmk7wxLQQCtjAAqaEppOXm1wtx9XWDwGW2PXqbMjNNvTn5l41zzYRKJ82rU7bB2fJFDOZ+/x4M7JwpI6UqIW5e+wKNhePmvYMZab4Fz+deTciYWLndsEPCglMTqBP8gfzkFt0HWjL5EkW8f7hd3kUQUNrb6padMXpRTXBjfTv/pxW4vroDxQ+iagECoiuYgVAZYRfxIB6OAXr4W7g1cZL0quLwYad3/1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8384.namprd11.prod.outlook.com (2603:10b6:610:176::7)
 by DM3PPFCBDC4B878.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 22:21:54 +0000
Received: from CH3PR11MB8384.namprd11.prod.outlook.com
 ([fe80::5e40:8c87:950c:993e]) by CH3PR11MB8384.namprd11.prod.outlook.com
 ([fe80::5e40:8c87:950c:993e%5]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 22:21:54 +0000
Message-ID: <a76ccccb-7070-43aa-8bf6-1db8091824ed@intel.com>
Date: Wed, 7 Oct 2026 15:21:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] x86,fs/resctrl: Keep mbm_assign_mode in default
 mode at boot
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1790976400.git.babu.moger@amd.com>
 <b969687be3162715e10242424b5a489857d67f2a.1790976400.git.babu.moger@amd.com>
 <200d21ee-3041-40f2-9032-18e8544a7030@intel.com>
 <c2ca9eec-57f2-41b2-b8fa-4ed193b5b2dc@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c2ca9eec-57f2-41b2-b8fa-4ed193b5b2dc@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To CH3PR11MB8384.namprd11.prod.outlook.com
 (2603:10b6:610:176::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8384:EE_|DM3PPFCBDC4B878:EE_
X-MS-Office365-Filtering-Correlation-Id: 454727fd-f24b-4b83-4839-08df24c16490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: edYnqz2a42EJoU/6eCDZBzdrtq6QfR1Ssgk2Q/8XMtswU9GlTl/AOH87YR/fvvwkCKenC1/k12366bMTmr/AIK/3Nf3ythVAdyA0x5pJFZ0+IBAJz19oaQbfGauoeWaFdHvEsxMMk9hlyQLs2iSpzqjydFjxCNY8m5TL+HhJE0U8GMJOHzvCtV+cgzZPDRS87or/caUKsFW3ZzmC74wxEwGn2oqgMSkpXgszZ7SoDr6W6MibR/E4kJ74u3j36sd+F1hROM0IHdEEDecONn8Nw+zjaHukVSJ5f3jOLoV0gRIVJXv1+DH/iECYnd5zrHjSv6IBJmaDmxqRUy7+EE/jIt8gYS+CvBci7CKoFKxltsy0rAZMYc27I3sxTFLux68Gny2jZjobJ3coRsiz/p66+dn0cbpsrrhZL221bDoI+BBlVRQSycYBKgcwo/JLUMMqGbXZ6Z2uL+ABdGtpW85VfX0h28cZL4YCiX4ORAOacP49ZqEUVaaJxZE3vwIsT2rPct9vTM9WGH1nK/7I3Slg+CGIlh7g3cT33gtRfKuak3I98tjFvM0dCBiZcxxUCbhJ9XJ9pAegAgiPvUMhSO2t4AtYZu2Y5nMNK+GV8vM2OdfECWt+v7usFcUt+ec1ent68wzjXS5eLeESgrCo1JSPjsKqTQcHM6k1GKqxBFp7YlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTk2VmdnVVZlb1Y2c0pQQmtobkloUmlTNzQ3cWFTeGJQRFlzaHdnWE5zTTd2?=
 =?utf-8?B?d3dacHQ0Ry9DcktlcWNjQ0VVL3pZQ09UMkNraGdpUkF6dVNEa2crUVBXYWVr?=
 =?utf-8?B?QWtxbG9MMlJjcXdFTy9wQlk1WXBnYittUnd2ZWVRejNKcmZ6VXpBK3BWUllm?=
 =?utf-8?B?azhGSTRqNnM2Vlk5UTFOTkFFd0lsMmhSbDRLUURET1RXSndkcm1MUi9aQnRl?=
 =?utf-8?B?SEdCdm9lRXVNbEYrMk14OHFZRDRBNGVlNzVZZTVOVWNVcllPb0NLWVphZEZI?=
 =?utf-8?B?bWNzb2NaeGJmaHYvQm1Va3A1Zk5rWVo0dHFoNzQ4aTBKMk45VGNBbSt5c1dF?=
 =?utf-8?B?YWRaWXJ3L3RkOXdBcDdkenRlVGJYOVVySE1hVEx1Y0F1SVFzRmJKYVFQZmh1?=
 =?utf-8?B?QWZXTGdiVDBqMFhYbExNTXFkT0t5c0dEd1Z6aW4rck13eUVYQlkyOTkwZHN3?=
 =?utf-8?B?MUVqYU8wWG9LQlp2eUZGRnU1Mk9ySlNCcXZjYXQzNXFlM21PbFQ2UHBQelhh?=
 =?utf-8?B?VTk5NHVDb05JUjhGRXdEd252bXhKcDUvdE1Kbm54QU5pZ0poUzh6TzluZjV2?=
 =?utf-8?B?KzBDR3d0MDhwQUt5UFJCRzFZOWdjcHh2dzIyZkpLL3lWZStTZkJ3KzZwVnFV?=
 =?utf-8?B?TzZ1QXhXRTkvcmFaakJYQStVbzh3VW1DT0d2bXhXZEdBbGpzYmRsY3Z3N2RL?=
 =?utf-8?B?UkdxSzFEN1J3Wk1YaUZ2WGkvYUtybm9WbHArNGhoSUZ6VjBWQ0FiampUcVZz?=
 =?utf-8?B?dDhLZVF0SnZPaElhZWR2R1A1UHg5SndSRnVzNHh2bmZnNGp0STB4MHJtODJS?=
 =?utf-8?B?NFhKdmZSL0VmV2hZT2pXVU1tcy92b2JYaWMrYkdDWUdPS2hVdXprL1RPMkpi?=
 =?utf-8?B?TWtHY0tRUVViNzc1cE9iVWVlWk8zK0FqTDFQMm1CMnBXTkJDUW80VFhybktD?=
 =?utf-8?B?Ull2MTVwKzNlNXplTFd1UGZxTWowTW93R3Vxa2NXTW9xK3IrZUV0cW5ubnE2?=
 =?utf-8?B?Ri9aSnhNbzFLbDJaQUN0QmRCbXA2UnE4YkhzQzFMcEo2RVpWOW92OHB2SnAv?=
 =?utf-8?B?eGhmS1g1NG82QjM4QTdXMmhka3lOdCtjMVpveHBlbXVrcEsvUjlkSDFnZFZj?=
 =?utf-8?B?RTFqQWJJcUZ0UVB3T0NwdVVhbFNoaFJJd1VhRVJuMm1QK25zU01UQzNkdnpo?=
 =?utf-8?B?dC9CanZkRklyTmxKeFN0cEtwdnJyczBrWmNPTVpKa2F3aDBTcis2aTNLZG9h?=
 =?utf-8?B?Vlg4MlVLQUFzc0dWbU1WMkRrT2Jja0E1dFc2bTZweTBxNUNyditkR3BsdXQx?=
 =?utf-8?B?VTIyeGoyRUJjaUJUOHdkdXVlZG5HNXRSUityc0o0djJtSFViaG90S2ZDMkRY?=
 =?utf-8?B?UXd2dnBoQnlYaHpjQ20zQTQrdytQeXphU3FtRGx4SEVNMEZjMlBRd3IrSWR6?=
 =?utf-8?B?NjJUMk9wTUU3amxYY2Y3WTJmajRwTWJNV3VxVzJJM2FoUzFQWURCS1dYTjhJ?=
 =?utf-8?B?U0NFTWtFZW5iREJIdnF5TEhKZGVhWURObjQ4MHFkb3pmMGVNaDhvbzJ2Q2xV?=
 =?utf-8?B?VGhUUktvZGVzWmlYcjVmc01wRkJZM2RNWE83blFtTDVkTGFJS2p4ZENpOFZG?=
 =?utf-8?B?M2JyT0VER1pKY0IrMlMvYzZyWDhpN3ZyOWRuR1ljcDZicThyWlFwOWd2ajRu?=
 =?utf-8?B?elJaRU80ZTFRbnRLWDlZWllub3VCcmc0Q09Bb2N6WkQ0WlR1TWQ4MnRkT0t2?=
 =?utf-8?B?Y1pHUWxsOTc3OVY2RFh5SGZIcStMZEpta0FDb1pmeE01L1RiZ0kwbzNzRllN?=
 =?utf-8?B?Q21TSDBneVFNOEVZNC9xd0J5RHo5cHVRVjFHSEhXcjJZM3hFVTlQWlQ4QXJZ?=
 =?utf-8?B?VW1BczAzUHhtazdTUERSa1AxdXhlUlRWYTBvcnE2blZMcXp5anJWbktyWmFu?=
 =?utf-8?B?V1FhaGJWTStQemxKbUJsY2ZlY0FpUEJLbUZJak9PMHMyQUZDV3hLWVhiVnhr?=
 =?utf-8?B?MEw4VUxjMzBSaGtNNnp5eXpTdEJVODNtbWIydm1PZ0YyUmdsT0UyL3RSU1ky?=
 =?utf-8?B?N05zZ1luZlBIZDBqQU4wRTBRYURTNFg1V2kyd3lFRkVDeGNwMVN5MTV1aU5M?=
 =?utf-8?B?Ym9VV1M5S01oOGovMzJDMndQRlgxNnlkbXZ1T3Y5dTNCT0lJUTB2RURmS2Yr?=
 =?utf-8?B?SUpBbG1OVVZGUXJVd3hvU0xBUHgzRVVpdTN6bVlEWFh5MXdKTks1QUJoNUhr?=
 =?utf-8?B?T05NNEdyRnZQSlZGT0s1Zi9wNTU3cVhiMHgyVEgyRmF1SWFYUzJ1aUMrc2pI?=
 =?utf-8?B?Sk5pZzZrTm1sK1ZkS0xUQ0hOcXVUQVdMZ3FuTWpXM1h3OThNaGxiUkdYcm5S?=
 =?utf-8?Q?xjf4zMl1FsY2JdGA=3D?=
X-Exchange-RoutingPolicyChecked: QIkmMokfGn8k7JyjYWRrHMHtYDOAzdDISPIiiPfLnkbJkg8P7GMUDLbZTdPenG9/mBRD/POct+zx3TmxgRM0uUvX4U6yZHBNV0J6e6UF2zQYC86xV/vRl1LS7Zb/qdVg2NyZjsRVQp+Z8Hdx2JdaUqh5nScsm6fhWAwErdlLVAVZdV3HzRl45kzlwFB7yWbCuvDmQIBzRpZVXSjt9GtJJSCSqoESrQC8whUY56j9oYjBVfmwk2a9ej4MHM/Q8ECH7MEOPQfiIADXfGl9L+roBWrnE+tjRI8GNsjHgShzdTIXpNQrrXpr66c+ij7dzC7pDctfot3XezLCIIdWkLP8Eg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 454727fd-f24b-4b83-4839-08df24c16490
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 22:21:54.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9/oRi1DKCkyzGUbnOqARbTAjsXinILpAEW/8YszWYRnMy7kZeMYsDLC8kJ+TY1ESKYB9BuWBmX4tuWnmXjsfjUyvrZq2MTowP2PDeCyqTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCBDC4B878
X-OriginatorOrg: intel.com

Hi Babu,

On 10/7/26 11:54 AM, Babu Moger wrote:
> On 10/6/26 12:53, Reinette Chatre wrote:
>> On 10/2/26 2:26 PM, Babu Moger wrote:
...
>>> workflows that monitor a subset of groups at a time and rotate
>>> assignments as needed.
>>>
>>> resctrl enables the "mbm_event" mode by default on hardware that
>>> supports it. That breaks the pqos tool [1], which assumes the historical
>>> default mode. pqos treats a non-numeric event read as zero bandwidth. It
>>> creates 16 or more monitoring groups and uses two counters per group.
>>> On a platform with 32 counters per domain, that consumes the pool, so
>>> further groups read "Unassigned" and pqos reports 0 MB/s for them:
>>>
>>>    $sudo pqos -m all:0-4
>>>    CORE         IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>>>       0        0.69         16k       192.0         0.0         0.0
>>>       1        0.40          3k         0.0         0.0         0.0
>>>       2        0.44          1k        64.0         0.0         0.0
>>>       3        0.39          1k        64.0         0.0         0.0
>>>       4        0.43          1k         0.0         0.0         0.0
>>>
>>> Leave mbm_assign_mode in "default" mode during initialization. Default
>>> mode uses one counter per monitoring group. On existing AMD platforms
>>> that pool is 64 counters and may be larger on newer hardware. The
>>> "mbm_event" mode uses two counters per group, so 32 counters cover only
>>> 16 groups.
>>>
>>> Deployments within that pool receive accurate bandwidth measurements
>>> with default mode. The hardware supports 4096 monitoring groups. Beyond
>>> that pool, readings may be misleading or "Unavailable", with no
>>
>> At this point I am lost because the word "pool" is used to mean three
>> different things. It is used for the number of "ABMC counters" as well
>> as the number of "non-ABMC counters" that exist on the same platform,
>> above it seems to be used for number of RMIDs (number of monitoring
>> groups) also. Could you please add some context at beginning of
>> changelog to introduce the various counts applicable to the description,
>> associate unique terms to these counts at that time, and then use
>> those unique terms in the rest of the changelog?
> 
> Sure.
> I can name as "ABMC counters pool" and "default active counters pool"

hmmm ... "active counter" is new term that, when grepping this series,
fs/resctrl/*, and arch/x86/kernel/cpu/resctrl/*, does not appear a single
time.
If this new term is needed then please include a definition as part of the
changelog context that makes it obvious what it refers to.

Reinette
