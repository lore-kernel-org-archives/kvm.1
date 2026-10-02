Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9D495040;
	Fri,  2 Oct 2026 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942982; cv=fail; b=EId+tZ3qVjEknSw3YRDYGco1pHfj70KQoO2U3ZZd8Q8rjpQLhZx9EkFDt00h1Hly6RVr+osuEKGR3WZn4uO6USQ4g+IjYwUbrTDoQLLKnJroOrABUKgreQyPcgJNi84yP0VkuHjK1A8XICPw77RmfuiP6mFIyWQq25YyCd24s/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942982; c=relaxed/simple;
	bh=MwiLDw/2N5/9+phyrfG3BnYNwE+9BJCBSCar2DWbh0A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rq3Lg9Ag9DquzqdtoErYwR2GfUHvxIljabmsBZnhDMIQOGfEm76uX0txy2IP5GN8YQTAy5RX8sSdlV9l1j9I7OsUZXtuAp9MkZqAfXrcj93km/tnAcs4PyKOJZA4vzoGIWV+yRUreR/lBgJ5n1ZnElkEal+Bgludv5GWQmUv2/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3+s5sJN; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3+s5sJN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790942978; x=1822478978;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=MwiLDw/2N5/9+phyrfG3BnYNwE+9BJCBSCar2DWbh0A=;
  b=h3+s5sJNm3LTQ6ah3iggf8nIZ4vxvM6ikjq8miNrZcgfc7UlJKZ0mM89
   737fNYQ0Lr4IlsmSL+m5JKYu4P93UEhJYF3r9TsJjS0eLVRF8PCoWIrLa
   B+VstbbGQPrRS2/fP+PKQH3VkbVTMcoBrGj3jDBA3auvgVvu4X0sXS/l5
   ZNnk8SsEkt10I9hIyvlGOABJbKNrGIkkxJDlmE+AvOEkNuA+5RWfECI0q
   1lNHQ0JEDKR9GOtzqNJDrZRmBOXIKfcerFypuqLuIMM6mfZnc/Qq5tvUE
   5sr1QUGD2vxPrKGFUGxj0WLMRekrQ0utgAHYkWxwXcQgp0bfHBijGuqRR
   A==;
X-CSE-ConnectionGUID: ywD1g8UxQviXa8Tfg2sOnw==
X-CSE-MsgGUID: Opam4cxzRaGm+PdznVz30Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="117234587"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="117234587"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 05:09:36 -0700
X-CSE-ConnectionGUID: G24XTe2EQ/eZSnQ4YXjfTA==
X-CSE-MsgGUID: 66vEjmexSN+E0zgZtf7NTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279974537"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 05:09:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 05:09:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 05:09:35 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 05:09:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p70QEPWJ31D9oiM9Wd1tg7FAvUvZrjtAIgkCXRC9yL4wxz3pFnygXMhyTwyqiKn4Xm0mDjusY8r4q7YmII94a52uth5cFC0lqPMMx5G/MOE3YEwhaY5EXzz9p7QXlv3DFurR0CR2lbxht00UdTJR0E30Kxi5z9D8lo+XhZJNHPy8Etbt0dd7OrX6gEZOPy5MKxIxE0ugrcv7mtFip+4+XpVmQZ/PcnE2hxYn0jWFXZ5wVQpA5fVkbuJanJUYNX1s2jRI+NyZVr4Lyqi+M7RSZvSCBgLqNiUjtcS+VRY1g5qAngORmPV2tST+r7lYAq7liFlUGwEIZSAgRPkRU+x2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5tPj3zJFQHphOsuFLK3/4lAYBCanWSx/Jr5og30aX8=;
 b=oCU0gKv/cS85udynkQW4nNzkd0YPpqr2rAHitFkyH+TsgFSr4KoWczFkXpMWex81Slt/qSPMyLRVkWUhKdRmtq0gyiFnn+mmVCJ9yy2Ir1QkeKCW/VXBbvX0+BoaW2MhOUkVQXBgV7HvEhDVDE85HOHXwc0lpE8IgRXQGVl8HGgXGHlj6J7zQcWE6M2tunkDJt180xHCIvG0t1Iu8Gebm125D6ob89g92o/t81Z3au4BSLUQrOKNnIuhIlo/Kj2vRfa5Sy0ctJmROcmejoFRJI/4cZg6HPmAqkDgTHhS9q7IxYRiJYz8mF1jyDUR270jQdY3JZmeqx+BwRs+Ukhycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by SA1PR11MB7013.namprd11.prod.outlook.com (2603:10b6:806:2be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 12:09:32 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0451.026; Fri, 2 Oct 2026
 12:09:32 +0000
Date: Fri, 2 Oct 2026 20:09:21 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Nikolay Borisov <nik.borisov@suse.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, <yilun.xu@linux.intel.com>,
	<binbin.wu@linux.intel.com>, <tony.lindgren@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Kiryl
 Shutsemau" <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v3 02/10] x86/virt/tdx: Convert the version metadata
 reader
Message-ID: <ar-e8WzRS7IUKWgH@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
 <20260930053901.22528-3-chao.gao@intel.com>
 <5fe666c8-55ad-4f06-b853-a532d73c35be@suse.com>
 <824738e9-ff22-45b2-b7ee-b9dc86d1686f@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <824738e9-ff22-45b2-b7ee-b9dc86d1686f@intel.com>
X-ClientProxiedBy: TYCP286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::18) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|SA1PR11MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bd1064-799d-49d1-c07b-08df207e0408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pIDkWjDBdu44ogL2sU7dZ6eZSC8rsw4U7woL9Dp9xAXoCOLjvfmZjmU6jG41bQKq9tCihI+VFRulYM7E74Fq6OvBAHQvJwvZLHLZDfwiGrtUHHzeTCuzKg0IN7Ifliaiu+yiLDUwseYNO3A9dghp6gg6YYTNngMQjekMaXlVrvdh56ZtRltoNozezQGT6g27cfPv9H/J3jGmwJ0vDM/W7TQxabWFoT95Ik137XMKiZ34vbsgs31SSLXBCAM7krA9QgPfbAHr+Z9irxfVmXjfw+Lcl8PLfYuuYdJkJmnXRpjN5sOQTDJJOzucN2Z1Id7nmAEPVjsb3dumiDZsqup75dyvACwGyaYafs64iWq/u4IkRLtbEbC5LMRNwmSHwsNt2OKumpHKzVnN/3W2mh3ywDoBNdsgB0B103LPtwH7ZgtNzm2D2qznO4GkafGEwcHWfxDmqdybrmrv33I628PximlW0Ghi3xCPQapdaSbz75lV3jnbfu65WqH/yje6fiwknZs9eahGcPCCyX+8WwfZzuSJ/m76dsW3s5BC0s2F+8fJ+WNCXMGt1iEeB+Z8YQJUBy8qxjW0JsaHY+ToOYN16/V0+w4h4Tg8CfrgWzcQDlRFL0XvLCOB63P3czY4D4OCPA0A0gcJRMNtX4QVLT7Dp8yPRRR83RXkU0jBgQVBiV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QW04TduLS8khAv2cVOgsR/klh02V6uGDv2QGIKBwhotE6s1i9gFMjTCjMr?=
 =?iso-8859-1?Q?LT1bdTK25PYvp2yxEvdbDQ9wuV0len/LpVJNLmSrkNHaeJYiThN/kC4Qql?=
 =?iso-8859-1?Q?w9EiEpOP7pJ1nReGDBx/4vY9ufbU4ngA3YQAGlFpNqHwG++nnOhtcqCGQM?=
 =?iso-8859-1?Q?nvmIiFD1HODCjsDaEwANcnu/e7ogVLQ7ZfeyRkzaUBMca9pk5OhPys+Lcd?=
 =?iso-8859-1?Q?L/XKaP7p4/Mh2E+UyavoSTIIjF8SPHVt8H9JJSNgj+teQJNCM9tjD2Z6Cj?=
 =?iso-8859-1?Q?xXAF6MkCBSvNxOVumJVin7qzHA1go0g6WdzxQxJrVcjFtvY3jFBlU49lPI?=
 =?iso-8859-1?Q?uu0PxYkqGWwdeJB/0CFA82VsnDdBlxmgSO7b5cDsLsWJohwvb2KlOdJ0jF?=
 =?iso-8859-1?Q?F7OP37Tm1HWWitUaY/mH+DKThdmZQVGirPQrAm+RWbKfv/RbUWT4zPA5P9?=
 =?iso-8859-1?Q?lLxnm4toP+wkCpZAU9Kz0y8YqLEsvgCAb8ajlprDpa8GXSJppa6XqmW6QE?=
 =?iso-8859-1?Q?UMc9KYwjwOH2aM679dPqIgsX5OtkesWTO678/3b/tu5UB09cS7L8nCnJmz?=
 =?iso-8859-1?Q?ncCpcsrVJkvT5Jq1T12Sv2iziYzNZg42aIY2AivzCCzCvEIN9TMjNAniJ7?=
 =?iso-8859-1?Q?vuBBRxxd85qs4WlwAuiypB22yTZ+K0bGx9kOom6ghQRf/NXlzbmz8xntRo?=
 =?iso-8859-1?Q?XhdIIi7OP54Z5kePuTDmV/XXM9sezct/ICQT5iBb/vhdxyTQQT8siCpFAK?=
 =?iso-8859-1?Q?+BeKGQS38wkbn7bej8bSjtNEOeB++WlYXlc0MY5xxacESYwTfOx/nA4jjp?=
 =?iso-8859-1?Q?PSYJIMlvElk/AG9VvxVja/bZBDY0dWTWZxjApKCDMwOWJ12Km5KFLcrBFm?=
 =?iso-8859-1?Q?fKb2bpxutnH0YGTlOQ+QKiFMEL+O6VB5vkDy+MpdHFwC0J/qco4OEkJ76E?=
 =?iso-8859-1?Q?piOwJ9JMwBP4J7sH3uI6OJzJCffL8ao9eCieNLoKfZ/YHd1HyUIYqwexRm?=
 =?iso-8859-1?Q?6sKfM8ZOc93Tov8gKtCV73OthD93wcTTY2Fjt6R1yZ6IHplWIvlAxkI85+?=
 =?iso-8859-1?Q?bjZJGVe1/zyT/dVTfl1xPkJ+bpLEL5QqTbrNrRJYMC8Eikq9hDsAEqZwPO?=
 =?iso-8859-1?Q?CQVcsCn0TcJst+bQyLnWwO/bQkIn3JEnrgJekcuUfLI5w6TGaMCKpvlxjf?=
 =?iso-8859-1?Q?DZ3dgP+kPobEqLUJAl+2FUJeIPpQn77n/ABFM1gmQQoohx2JpDa1ytK+BY?=
 =?iso-8859-1?Q?T0WE8l/hByLkcO+YAsyyGyvxYh4IJZyGt/K/W+DqUU2UY+qBswn2DNBbaK?=
 =?iso-8859-1?Q?hYsZohRUQKRkeW4N7ew40Ad3X57EDh35IA/HnSAif52j2oeOVajs5ANkRd?=
 =?iso-8859-1?Q?WzWWgbH62O98wy+M2++01g6Zi8Ou9d8MMjEJi9uzaMOojifNquxXlDfZHH?=
 =?iso-8859-1?Q?oPMKF2Fv6OA2muOCqLV/r4ybKwg1RkbL/3CJnMEt0HqyA8S4T99i6MdR+k?=
 =?iso-8859-1?Q?3mMBieiHQIPvb2PL1ImRUY/w33p8QMIzsGQnh/W4KO8ap8ph0B9AGCVjNy?=
 =?iso-8859-1?Q?aF0P/m5+ON7yROOq/NHFHfyCt7ROTHYd4fApbo7/D4Vtgm2r+C5A3jFx3O?=
 =?iso-8859-1?Q?Ua35uV4xQAcomkldA5+ZVDW97wxEd/hkNcW6gGSvZqYg9G26hLATkEHzWl?=
 =?iso-8859-1?Q?iiuaDWlNoALJ2NIAM5b0WCBJdRc+v9dX8TRYOFzB+XYhqC5l+32XABhDMF?=
 =?iso-8859-1?Q?kB1+bIhOGA3jjwdYLB5fyr1X67B8qhq8sp3H2gWwFRq0yOs1c1i3WTJYfs?=
 =?iso-8859-1?Q?VH771cNR1g=3D=3D?=
X-Exchange-RoutingPolicyChecked: yYKZNvfoJSyPNb2zzShQ5DXPHfWhQmW77Ntob3B3ixxDoJ7/2agmzI+XCG7LktvemHp5KWvfgobUVpjbj8oohlsenoKB4ZSpHtz8/O8CaKvEfdSlcXAnaxjy5z4i6S+1OYUv/PDogUM+6wx7HJwtRSho52pq1J2bYI8rupperCPjiHKL8Ex8tdKH10kqy+Dqgudd+80bsdd46Gi8R2NZ/bsAYGkOBjn28UBxthDR7rZeeUNUn3aC6CpAQuohmlzpKfJyowQ9IKAYyDiMfxnDnZxc+mHUItZkO2Z7zTWV0kgtWpR1zoKlUIyQMUWldsuuwQvDCkeSVDofTTZvwkx2cg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bd1064-799d-49d1-c07b-08df207e0408
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 12:09:31.9708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvbQMbpdK2pxF/XB/U68eV2MF/IX8lFSuMpVIYXRvZgy8xKFydLn2RQsbvCgDY+bRX4sRc+SoWfVhjm4w9gO9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7013
X-OriginatorOrg: intel.com

On Thu, Oct 01, 2026 at 09:27:57AM -0700, Dave Hansen wrote:
>On 10/1/26 09:24, Nikolay Borisov wrote:
>> nit: I personally dislike adding this level of indirection, albeit
>> rather shallow just so you don't have to repeat 'struct xxxx' in every
>> TDX_SYS_INFO_MAP. Same goes for the rest of the patches. In the past I
>> remember TDX code also suffered from, in my opinion, excessive macro
>> nesting.
>> 
>> Dave, what's your take on this?
>> 
>>> +
>>> +static const struct field_mapping version_mappings[] = {
>>> +    TDX_SYSINFO_MAP_VERSION(TDX_FIELD_MINOR_VERSION,  minor_version),
>>> +    TDX_SYSINFO_MAP_VERSION(TDX_FIELD_MAJOR_VERSION,  major_version),
>>> +    TDX_SYSINFO_MAP_VERSION(TDX_FIELD_UPDATE_VERSION, update_version),
>>> +}; 
>
>I'm kinda ambivalent on it. The width of the structure doesn't really
>matter much. It's readable either way and it's already got *PLENTY* of
>duplicate gunk in it.
>
>I'd try to remove the macro, and make sure the structure definition
>doesn't get too icky.

OK, I will remove the per-structure macros. I would also rename
TDX_SYSINFO_MAP() to FIELD_MAP(), which keeps the table definitions
within 100 columns apart from MAX_RESERVED_PER_TDMR and
PAMT_PAGE_BITMAP_ENTRY_BITS.

static const struct field_mapping version_mappings[] = {
	FIELD_MAP(TDX_FIELD_MINOR_VERSION,	struct tdx_sys_info_version, minor_version),
	FIELD_MAP(TDX_FIELD_MAJOR_VERSION,	struct tdx_sys_info_version, major_version),
	FIELD_MAP(TDX_FIELD_UPDATE_VERSION,	struct tdx_sys_info_version, update_version),
};

static const struct field_mapping feature_mappings[] __initconst = {
	FIELD_MAP(TDX_FIELD_TDX_FEATURES0, struct tdx_sys_info_features, tdx_features0),
};

static const struct field_mapping tdmr_mappings[] __initconst = {
	FIELD_MAP(TDX_FIELD_MAX_TDMRS,		struct tdx_sys_info_tdmr, max_tdmrs),
	FIELD_MAP(TDX_FIELD_PAMT_4K_ENTRY_SIZE,	struct tdx_sys_info_tdmr, pamt_4k_entry_size),
	FIELD_MAP(TDX_FIELD_PAMT_2M_ENTRY_SIZE,	struct tdx_sys_info_tdmr, pamt_2m_entry_size),
	FIELD_MAP(TDX_FIELD_PAMT_1G_ENTRY_SIZE,	struct tdx_sys_info_tdmr, pamt_1g_entry_size),
	FIELD_MAP(TDX_FIELD_MAX_RESERVED_PER_TDMR, struct tdx_sys_info_tdmr,
		  max_reserved_per_tdmr),
};

static const struct field_mapping dpamt_mappings[] __initconst = {
	FIELD_MAP(TDX_FIELD_PAMT_PAGE_BITMAP_ENTRY_BITS, struct tdx_sys_info_tdmr,
		  pamt_page_bitmap_entry_bits),
};

static const struct field_mapping td_ctrl_mappings[] __initconst = {
	FIELD_MAP(TDX_FIELD_TDR_BASE_SIZE,	struct tdx_sys_info_td_ctrl, tdr_base_size),
	FIELD_MAP(TDX_FIELD_TDCS_BASE_SIZE,	struct tdx_sys_info_td_ctrl, tdcs_base_size),
	FIELD_MAP(TDX_FIELD_TDVPS_BASE_SIZE,	struct tdx_sys_info_td_ctrl, tdvps_base_size),
};

static const struct field_mapping handoff_mappings[] = {
	FIELD_MAP(TDX_FIELD_MODULE_HV, struct tdx_sys_info_handoff, module_hv),
};

static const struct field_mapping td_conf_mappings[] __initconst = {
	FIELD_MAP(TDX_FIELD_ATTRIBUTES_FIXED0,	struct tdx_sys_info_td_conf, attributes_fixed0),
	FIELD_MAP(TDX_FIELD_ATTRIBUTES_FIXED1,	struct tdx_sys_info_td_conf, attributes_fixed1),
	FIELD_MAP(TDX_FIELD_XFAM_FIXED0,	struct tdx_sys_info_td_conf, xfam_fixed0),
	FIELD_MAP(TDX_FIELD_XFAM_FIXED1,	struct tdx_sys_info_td_conf, xfam_fixed1),
	FIELD_MAP(TDX_FIELD_NUM_CPUID_CONFIG,	struct tdx_sys_info_td_conf, num_cpuid_config),
	FIELD_MAP(TDX_FIELD_MAX_VCPUS_PER_TD,	struct tdx_sys_info_td_conf, max_vcpus_per_td),
};

