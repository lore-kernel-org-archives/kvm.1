Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE764DD3DC;
	Mon, 28 Sep 2026 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627884; cv=fail; b=Vv6qL959DFa0mDo30YsG/LGO6O9sYkykpGD+CaFzUGUCG+lcq0v0b0Q+wzi85DjGZbY/HJj5MGjSVptANf+8BpOnP+eCzPnHd3sRmRNOouXNH/4BKC4q/0F4LYkU7CtqIEtyaODMP5AFx+tq95vmSxvPud964l8nYGRM6ZcRExo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627884; c=relaxed/simple;
	bh=HrScm6Zx2MtFTBeFhUhDR2fKhIrrEGeDzG8YOYp1EGw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pd6L/gQh9XeSdSiiSaeU1wG0eshb2qK/SZdxE8LXm0+yhqBjKVA7JB+kBnAVWzOU8SicLoW4maF42WtD4b5PkqyTEwdFsgwigNTDvDoDrs3EZVYuh6KUrefGRVDykJbDA9HCD5/pZJIhfJiGLKXeaE8fOkDZddI6InNxajHLCfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNfMtoGx; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNfMtoGx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790627883; x=1822163883;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HrScm6Zx2MtFTBeFhUhDR2fKhIrrEGeDzG8YOYp1EGw=;
  b=hNfMtoGxAzVgQtjEPCPKtIELsM/lKQFeM3buDcP2qfxp3oiOh22zRx8i
   lK+kPrHS+Y56kYInyjNJL6uhApExCPuLyLcLMZKSxaas9wkW/cH8q5Jb0
   7SwgRV28/zIaSHEi2UiWeXy5H6OD4a+WnR0kRRFkIVV4jaJJTRs0yZh8z
   1oD2T5Uivqnz4ybNA5NiDMfqlpEtWg53g8rgyvJyUqmUHxspsraMopbZM
   zIqIePgB1lzzEjvYcDs0JolQYv5zL/15AHVN9f6XKooDkodmcFpGHyeUK
   RKaqBWiURQkkgPUHFRMUm2+kD+kSntsVm1w1MW1H8wCDilORtWJofn5AZ
   g==;
X-CSE-ConnectionGUID: Xg+KOmvuTjSIOBLExjfjvw==
X-CSE-MsgGUID: tbFpNmdSQja8+SDNSIy3YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90104486"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90104486"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 13:38:02 -0700
X-CSE-ConnectionGUID: 5vGFR+NLT12snHYA/0gngg==
X-CSE-MsgGUID: J0vwFWrJSwukG3EgrfkYfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="283238027"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 13:38:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 13:38:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 13:38:01 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.33)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 13:38:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iChXcWyiujaSGsxjpIOYKhuS60BAZTbkEY5tqEEsx2pfPSSvzDN3S++VgqVNlX6O8ARK+oEPwO33XBDOGvyqRvTl9OnQ2xkKjrBaAHdsPTYBAw/XKHXIfhbAqNF4/pzDkDMj8LexOY476wmeeMD/ifqTi0pEqibwWbtWfQYGYzJ8a/D3v4dpBy6Nr5gvuJfEub8vdVVq/A0pZ7lqucYYNbAVv1SWODbY/7ibHG6W0ImVctmdjCGvHK8iHadTJa2LsWHPeuvnIevBzPOWZ0OZm+iyjfnuDbw/ZWz/AcHIRlfdSpgarN28Xh11n8mXcQSfZLPuyUk11Fa9VdZS/3LNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN1xUG+IyH+VkgQRbKucc67KZiCNw39UvTQjVEgJEgU=;
 b=mjhtAh4xVOD15PVSl4K+D/evZkmwW4hNFj4bv+4cGzq8L3aI4CO2Phhlp+aZC/HbjVGkw1Bsd9ScJN3TYAeww54z+VtwjvJXoo/uqPJFS1hKXenQhlMErQzfWPGT03fcSyikLPmmsEezmTzpMLU5e75mGsI+OjATYjuMifsJOa839L4eHBvNOdq/L/lqhQuMaFoFH05wMvVJpvWUMQyMtkjNk9Hjx0R4d3VnJfPcIoXPXXLutUAwfBkjBOV1pA42FX7QnwXxRSfbQgSrzi02iF+KeObGgq7FMm8M+JXo4JahdmYYcC6E5jS7oafix2bSZmoNPtniOOIggqD/pAT8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by BL3PR11MB6387.namprd11.prod.outlook.com
 (2603:10b6:208:3b7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 20:37:58 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 20:37:58 +0000
Date: Mon, 28 Sep 2026 13:37:36 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v5 1/6] x86/tdx: Take the Quote buffer as a generic
 pointer
Message-ID: <arrQEH9c-bVm6E06@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-2-peter.fang@intel.com>
 <5e4e97560352666d55033fbcb92f2f183fd42086.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e4e97560352666d55033fbcb92f2f183fd42086.camel@intel.com>
X-ClientProxiedBy: SJ0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::29) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|BL3PR11MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: d22a0009-6995-4b23-3375-08df1da061fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jqBJvxhD1K5MrY6wQvQenV6crly6b9GNHlENIk/L2njxfkcOVd8HrptSRDiIjfS2EVCFbTqPuZT/PumDpE65WQo18O9HDLTgLakYk7jJ+KQmN7FTvCJSJMRQhXz6b5GlMrujJKBjrkh6hHDUHA3BBIRIPczYZXjAkPx6lakBx4hWLOMDbqn2fBQzTSqFlzvxqFALtfPBFsSHqUed3y5YW9bXkLRG4iAz2Wel5znSFotCA7h4NiGIwU9sqThvqa+kUGq3XsUnBul3xO9Uo0wD0LNtzpHpnxROJuRHYtN3UX8ycyZMM3CWFE6nhhRDP0kcKAvIycpGPTj9E7ZrSVgi7wX3QSmpeMDfgTdEHBJEoHc3phBCrEQ3VwlgQHBlhbvIGwg/44fbUQZ3eSDNTzhodq+Y5m8aG/RkYHf7k89U8c93mQXR/BcxhyuBRJ30XUK2jjIdtXFv9I2VFoTyI+H0sZDAbt/RNFX3Bk0sytTfxxRo7yjIrvvlVdzHn/LlWRiMeDKbh1/+roPo39LLrxxPY0AWxufXDtQnd2Oetp5ApmyEPyld4YFXpBjgMUzCJeNSHqGhdlF/+52NGQthHbW4rPq4A2uNxOnS1OGGbtA1uHMqTh/C8h4JylfnCzXLhy6+R9bnuJvahDL3Go97kRQtY8Y/tsmJv3M5VdHsxvsVBWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVRUdVpVSlRmYzZuSnpJVjcrWkRoaktlUXFiOHROSWcyVDllVDlpOWdGb0wv?=
 =?utf-8?B?TzM3RzhBQXpCNG11enp3cklsYnVBVFFGa1JKWUR0c2Z2MVhrUmcvaDlCdHFm?=
 =?utf-8?B?eTdIbVFrYWFMSzFtY1FDWW5EbytSVUdtUXlaUndlYndPWkprb2R1S0wzRytM?=
 =?utf-8?B?NUlzcjdYL1AvYUxSenhFYlVBVXZRcVB0Sm0wdmJqd0ViTDBTenlyRjVzVkNF?=
 =?utf-8?B?WjhNNXEvRUJXWVE2YVU0UXB5QzFUT1dkQmZUN1RpSmE2ZHNISXp2WkJEcGsv?=
 =?utf-8?B?MUhhWDJSRGtGbzhMWkdQdStUV014NHE2Z3p5NGN3MmdEYlloc0xPdnU2ZTcy?=
 =?utf-8?B?SXkzbHk4YVlaOVN2K2ZlYS9laTl0QjdZcGdZSVJNbTZTL2l6WXIwcy9JK1Ar?=
 =?utf-8?B?cXhhSWxhZFNYcVVuanpDbWdmYXRmOFh5c1VnZFAwZ0ducElxTmxEdHlqYmRy?=
 =?utf-8?B?NUtackxPWkYyWE1RQkFMNzlxanFqcERmSTlyNWMyaHQrQnNyb0pLb1VTNC9M?=
 =?utf-8?B?V0t6Q3RnUDFrNVNiTjNNemF6eVF1c01BdFZxZzNzb3RmL29rcTcvNVRmcWp2?=
 =?utf-8?B?TVptRUVLOEkrRDRWbUJGV0dpQi9YemJSNVpMblhjbVNFL2Z4ZkMrSlhtVmhW?=
 =?utf-8?B?bE9OTjNBbHluRmlieHdmcit2azJxdWRMZmZXd0RRTnJCUVJLUDhhRlJqcjR5?=
 =?utf-8?B?SzNlV0oxMThZTllNYWI1TlJLbnJSWGpuMTNTbS9OVjNVaG9NcFdFdy9ZWjBN?=
 =?utf-8?B?eUJnWHRuVnpaeGY5eTc0bnlyY3VRbUQ0WktNZ2dQM3cvclE5Q1RybzJ3SGtt?=
 =?utf-8?B?aTl3bFhreXdxUWpkM2NKNndzcGZwMElhQWNQbG1GUEF2U2tUNU10K0haWjVk?=
 =?utf-8?B?ZytTSjJWdW4rNDVvcXBVSyt4U2d3RzdKbG5YSzY3Q0tYTkNTTCswTlFzdGhG?=
 =?utf-8?B?dWdxd3FxTHgyQW4yaXFQMGd1TXNxRWpuRkF0dHc3WDlvNzFDblZMekV5Yk9i?=
 =?utf-8?B?L0IvR05EMnhGYzFESVIwK0c3THpvZUh4NlZybGJXV2xFN0hhZnRYN3A4alFi?=
 =?utf-8?B?ZDRFMU1pYzRPUVJHdjVXUkV0Q3JiQ3FVTElRUm90UWZma3VZUG1GaXFRZWVR?=
 =?utf-8?B?SnhIcG5xblZBMkVGenZjcmFZbHdoSzlWQ1V6Y1ZpYUlOQnJQT3FwOVhFSU5p?=
 =?utf-8?B?QlgrazNmUFkxYUtraDVWZGtiWkNYZGZSbjBhNDZGeUpNQ09SNW1LeHEwU1hu?=
 =?utf-8?B?aUlQUERYT1Z4Z1pVRzMvUmp3ZEVJaTE5K3JJdDhScWZpaEMwTWx4b1haTy81?=
 =?utf-8?B?OC9TM20xRmhtOCswK2k0cGNYLzJIWENhQ21hclJVNE5EbTI5aXVLeUZGbHc4?=
 =?utf-8?B?YjBQSXdiaTZ1VTk5KytMcHVzMFVPU1VMdG02L21TSGw0bkJ1Z1N5U0FYNlRM?=
 =?utf-8?B?MVprTHI3Rkx0bnhQbkhuY0kvZlhZbkJiOThROXhTVGhHYkQ5YSt6Ym9FTTJi?=
 =?utf-8?B?T05TN0h1UFVaMm9rZjQ3SjdRRUtlQlV3QVM4MGl5R2dackxOTktLSFhEWmlq?=
 =?utf-8?B?YXFiS1E5VXFmVDRBQ1lwcVhjTkNyemZOSDVpUmtLQlVzN1lRcDVlNVNuT0kr?=
 =?utf-8?B?NmpGWFdwa2hUQXpQQUJnWjVYWkRHODI1QVhLOGdQRHZ5QzdONjRCK0dOanFF?=
 =?utf-8?B?eVUvanByYThnbDY1Nm5teW1qd1pIMVMzU0xXMWVMUWJGMmdTN1F3WVNGQ3NC?=
 =?utf-8?B?bEtWV090K0UvNGFXMDBNMEE4TjVSTlp2T0h6ZTg0Z1ZIbWtUTXZNSyt4UXgx?=
 =?utf-8?B?bVlIWndWTGMzc3VNbXQzTjZzbUI4V1Z6YWhWb2M0cCt4QUgyb3AzVUZXQlR5?=
 =?utf-8?B?Vm43dittQjlDcmVKMWxGS005OWVHSXRCck84REs2TFFJKzV0QTAvY1JmQWI3?=
 =?utf-8?B?amllb0RaMXFnZCtGQWMzaExMZ0RDelRqQnJFWjBPRE05b0ZSOGRybDVHMU5G?=
 =?utf-8?B?WU51cTEwT0tRaGR6cWNaZDI5dGpqTFpyTTFOQjArSUZOYVZoSWNXZUNMYkRj?=
 =?utf-8?B?TnZmUW5KaURnUzdKek05OFBsZHQzQkxBSEJVQ1ZFYXVNKzlGUXpxY0d2anVm?=
 =?utf-8?B?aDNwM3RQaDB6SHgwZDBidWtPalNSdjk0UlppS0R6THFHcmNxZVF6bVpidmRo?=
 =?utf-8?B?eTZrczlDeUloZTFzYUhLZHlrTDE3T2VmN05IS1lGaUVZWFZ1SjJsWW9VNFNS?=
 =?utf-8?B?RFEyT3JQdXVTODYxdjVIMGhWTnlRQy95UjlPMXpMdVdKZjhkRWJsQzAvTzRE?=
 =?utf-8?B?Zkd0Ni9hbjFwMnI0T3VvZmtITnp5TGpaZUxuWEExV0s3VEdERTd1QT09?=
X-Exchange-RoutingPolicyChecked: ej8R8txM7uVYmCbiIIy2eMOJ/qEnMbjHRFP0XZkEqoR9zywXNZCkcB4++F4Ji/1QodlOMeV5+Lp9tARVBRBLARdHLjvssO1ZNiKgDRmsoeB7MbpXP9Co2xNZe1YBjJt1yzzTrFM33SaFIrZdzd50+Oa2iJIui6/TwFa7RkCmPJTjJ1/vuTNBNB7oHGZ85jPagYPF/BafF+K3UM+3klTux8VS3vxCW+S+DvIryXY5Qg+Lpwhmam11lnsTYVCrZxVMYFb2dZKwmn6EoRjCQFMiRPeYJVjx/+jyXtUbyE9tP6AYm8cbiB3jHL0n+QblhVsb7t+2MT2qIjOwOQMWT9Ck8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: d22a0009-6995-4b23-3375-08df1da061fa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 20:37:58.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mL6BGDyAFpHHiNr0VZD+4ZB3W6MzC9kuJ8DcLxx/bcq1d66Kpks13qNMjAe1//ardDokyqB7gyWrcdQ2bYfXXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6387
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 12:04:30PM -0700, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 03:08 -0700, Peter Fang wrote:
> > tdx_hcall_get_quote() takes a "u8 *" buffer unnecessarily. It is never
> > used as such, since only the buffer's memory address matters. Let the
> > guest driver give the buffer a type internally and just accept it as a
> > "void *" instead.
> > 
> > AI was used under supervision to collect/apply feedback, review code and
> > workshop logs.
> > 
> > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > ---
> > v5:
> >  - New patch. Prepare for a typed Quote buffer. [Dave]
> 
> I guess this traces back to a comment by Binbin. Which had a specific reason.
> Changing the global from a void * means a cast would be needed to pass it to
> tdx_hcall_get_quote(). I had to go hunting back multiple versions to learn this
> because the log didn't mention it. Otherwise it looks like misc cleanup. Can you
> explain the connection to future changes in the log?

Thanks for pointing this out. Yeah some of the review history got lost
in the shuffle. I'll document better in the next version.
