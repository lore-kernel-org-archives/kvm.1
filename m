Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E77368964;
	Fri,  9 Oct 2026 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791515764; cv=fail; b=su8S4coNjlx/3vUyQaqIop5WReLfjAQpJ8zvsaxO6+06HTcOUPCjy7VoVR9XD0QOWVAyxFp6vFiwdndY+sQJzjuZLwpTE5nhBtZNtpu6w+bDirxSWe9IoSryqHvPCyA6iNUqUETG81pxsAa9rsJVRGB6gxnAGgL9nI6mD5ouoRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791515764; c=relaxed/simple;
	bh=ID9GkTciwMVWVy4a1/i067VOKAYl23CQmovlk0kfgCg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hlnWT3uvz+qFVq4Cy7HS53hOuFi+mO//qLLqI2CVRgI1CmS47xvBTvmLOeyEfw2jqR6/DN0yOBnkvF24TtXPZ+SWqQjC6SjfMARYLXdwnhKKLg4gKv+MTJRmWnnmCJAiNfshE2jSz3vAvBBEdhNQzbvUcvW3vVVni1sphjQ1Sfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOx/q/C5; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOx/q/C5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791515752; x=1823051752;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ID9GkTciwMVWVy4a1/i067VOKAYl23CQmovlk0kfgCg=;
  b=hOx/q/C5d4dyNKuOp8SyvOpYW3KCstPG/4DgFAYlb24eZfbWdxYOEkxM
   2wnZgZPzwbtAAvPOIA0V0NHgfPvlvRlLtuHERXHp9nnbgmi+cH3DeOMh1
   LbK5gfkfYQoIDaJV+rrLnPR2TRtU52vDrTwFCS2X5zNywReWcR/JOygS6
   EZq6yWQ0IfeKP0J7VQ0iO2shB/7CCD0vqlSCEKzJuUw215pkpVXkUjTGO
   LfDZDPdObbCqaVmfNKhUAjjXMhDFhmIoNrtFKrmBhSCtEYW4aGNJ/fYr7
   78cgnvFIr1NYeCmfPqvW7sO2NbgxIL4XKamlVYMwObOLv9UnAkNBu8YmV
   Q==;
X-CSE-ConnectionGUID: dZ6DSSeoTGKB81t4NSGu5g==
X-CSE-MsgGUID: ckrhF6KGSyebtHFDvLMkfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="204964"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="204964"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 20:15:51 -0700
X-CSE-ConnectionGUID: XrK3i9/XT2ibw/AMl4XoXw==
X-CSE-MsgGUID: HfdrzeaoRq+irZ/BNy8HaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="535801"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 20:15:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 20:15:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 20:15:50 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 20:15:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnWFYAg8nXN3oE4G1nILzGc0woIHRamrsNhqeq22L17moCsiVtGCzXB0scWk5eXEPHiPwLzQI9poXol6eCyrDD2DrOvWTtQvUI5bEmxBGZVLM9VMwVgEoW++9bsrP1lyEfnb1kgbJwr9uVrJWHwNtHAko3odInNR62vHitGXxXrSEcB1roORMBKFyGb3xCc0Euu1w9/x/W1MIny5InRzuAwBXOu6CsLtkkVoX5a52Uh+JePbs1kxAhBQ0QXQ6mqAFX7KJWYJS05BlkDV9uWRzN9iCVC0xxUbng1d78EZky8t1grFdzvF/HHOJa4G48sKLAJP/9TxmdTaaiykRUGQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1yu6LgxeVz0seCSJJPepwx1piBXy4BmocEYoFBEc6w=;
 b=NA3Vwd5rKD6r85QgrnV1YC1ty4KP03lapYZDf0QLKHoKupowtUTzyLVr5bOhzcXDixn0mjzsQqJ4rraniB0K2d47RF/a1yMGgDk5NDpxs7d2JS6ScAKzlUamQir36wk5T1NHoosjSg+SqwlZln+3rNwSkn1aJ8UdoeI+uUeJtv6oHdMAylPVdI1vjVhwQocWrugOzzLsvvuQCUfj4TETYyaLg8VcpvrDzOYQcyFMi0fo3mJAWqyjrh7/+qesrgEiuTMj6/cQH1PH/XBD7Fh60ITxuttwKG+Vj9jsUVt7uJlRmJpg6VsLyRkdqJJKXsSJZPOlAorF9iTRxGy3r64WIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by CH0PR11MB5283.namprd11.prod.outlook.com (2603:10b6:610:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 03:15:47 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 03:15:47 +0000
Date: Fri, 9 Oct 2026 11:15:36 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<tony.lindgren@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v3 02/10] x86/virt/tdx: Convert the version metadata
 reader
Message-ID: <ashcWFDIDt_V28UL@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
 <20260930053901.22528-3-chao.gao@intel.com>
 <asfJI+15tQivvy95@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <asfJI+15tQivvy95@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: SI3PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:295::9) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|CH0PR11MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc38613-1cee-4ca1-e8b0-08df25b39ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +S01iQ1Cy3+FaQ5THqZ8Af7XNHXS950JxlSIvCTva/IVDZqrT1qN55SBFGXPz2psy/zU69gXBnmi726DTox003Bm7nHzO5aNHzTBji05DZF80lzTgkhufz592kLthnqs1GOUGJvxrsCzkmVZD+Dy6ui1A8eDDyH4IBb0E3CRW+RHoDMoMzb2qU/U10dAVzA6exG9GxyRfLh9GZJ0V2koKbTjzzcRhOc6s32upXzmEjYHElU1e+lscNPpKRmIjTjZNmTTSzZTBMrXPLSUL154owLpFUf8Jaz+isWcpSm1T5aQy+te30SEt/ZXpJc82BwzpPxOfdRYGvIE2vn53xc+UirLkSSFY8RHr5y2ZLry3r3om4kNSM9BT0TMVPuUaZIRGBYHlKf4W3e45M23obGpEbNMYQrfp8iB6feCZORSEZuwY52AKsIvTZV6qOcWoC02+vQ8ntpanJqXTM4z6t87gJebFCIcqaSg5TSxqXT6Wf3pfwVSSINWI8uat8/d/zVSut0q3Q58TyaMcE+fr9MDvIAhEdXPW3BjnfeZSxZca75GyqDszzybWsVjfLVssolXS3ikcV1xxxmiVFd3r+BKq9/Jauj8VeDFP0EtcYKWsWjS2gVEzepjWLeMNVv5iVSbf4PByvQQkn/dNjLLRuvggQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Bl+YhDDX7QiWAbgp/61Ku0dVBLg3XDSklkZkh/OthHVBij99ep3Csanp9mk?=
 =?us-ascii?Q?J0G9wtjdkR+R6uD4ibj4clDrR4VGd50/njvsHLqZIro+oGemDeyxlhiVxqND?=
 =?us-ascii?Q?Rr8XI1VqIo8O3KfEssHgqzBUYGcuUy/MJHBVlmrDkGggPJ3LRFw+HbgAnRZN?=
 =?us-ascii?Q?MBChdaqHyIGSpitMNLVKavV1ovamjt1XKYK0cNs+wZYVRH2xK+NDVDVwa/U/?=
 =?us-ascii?Q?n92fpYrbrck90D0PV34PfnFgE+GhcQWXGp1AYsZZOgQkpNN8dqBAQOFivASN?=
 =?us-ascii?Q?J8to1IJs9gWGBh2tTTmvxDdjtpDweA6AWSNaNcj6O8Gl0Mc9lq4XDB1KjeTq?=
 =?us-ascii?Q?eeNAMk/Ot38QTW7AltuuC+lodQU4ljLCId6nWrYwjdRrb+DUPgNk5vn0bMY/?=
 =?us-ascii?Q?VnMkkOpKtC4fGBMNq1CzU7ShlMbMUxIIdRXnnA4O8jL7An097S6EimvBbIPQ?=
 =?us-ascii?Q?oHMlNzpnTCJP3UnPSKAtYcfPAqWokcLQDr2KIC1rgGZPlA6M4Ua0FJCi4krz?=
 =?us-ascii?Q?JbQiEMxYw6vADKYfsZH3HZMg9fJYgg0VfJB2JzQl9xGY8/BYriGBB40JoWlf?=
 =?us-ascii?Q?32vMOIMPMF9h8mg8Ou9KjXkqDWK5EY6b7lCF68DgY/M8xfXc4r/aXkJghgEG?=
 =?us-ascii?Q?x9cbkEWnjpdn0tzMS0w+2hbnRzG3+aovlQhpTrNsY+V++GMXEy1s/AAnVOlq?=
 =?us-ascii?Q?KwyTjIxYOJRr2TdU9PsbV9vgFis8JBPV6hDfdCiBtVqUWTx78hbi68uMmg3t?=
 =?us-ascii?Q?+tEZfmGHG/u7Xdxo6F5W9ZzCHyu8OsufoMSGG+5e9VyofCf2qmecKWnDDoMB?=
 =?us-ascii?Q?l2h8g3To5NCDfrlYxX47f8Lotk90/Gr3x+7r9ROfwRw+wRLEUs9IOcYYnGyv?=
 =?us-ascii?Q?TWnT3Ucq0uzBqXQe7wNcIvHEDT0VpNiiU3Kqnv3qtytDZxNi8JYvOxhDsXvm?=
 =?us-ascii?Q?bxAva+NX4620nFkEMCgGkTZBg5D3oBniE6WjG7lWEW/01jGVdP39BTKq+gLI?=
 =?us-ascii?Q?cb8BorZCxOzPCJL3zpA0f1KQQVyF94917qIMTAI2D5CvzEkqfa0FZLnogBJc?=
 =?us-ascii?Q?oGUznXPWXBCUGUV3cMryjh4jwXhVBuYdyjTFHcftsagxGAVZtwFqunWVbUrd?=
 =?us-ascii?Q?B63m6lMEE2nvk8UyPQ7WDUlNwVWk6gV8aOAwvFGS4P3Aycm4R48gR1XBI09K?=
 =?us-ascii?Q?7r0mmkNrwb8IBDYm9cawr+osS1vLpfBkV0raWlkGWTbrEFn5ygqnr9p+97Bx?=
 =?us-ascii?Q?BK1NKxsqZ0VrWuLo6UXHnDRCZ+kcKoPQy1NDFNmmx7kg/6ClXfetEc3YfaPE?=
 =?us-ascii?Q?t2vyURs7eWIYu5P3PxMAXFveWkTnsUMvS/Nqehm9rUPSq1KJEOKJNntnbPWO?=
 =?us-ascii?Q?kd8EWOBOzM53J2Mhch2XgA7BD2vSWAzlkod7FtQPpLGbAUMEhRhDECukCmkL?=
 =?us-ascii?Q?/lRpR5qr4fcxejKxPD1mxnTpbVnDk8fbCllLhmm51QgZknfMeUTCeffQ9XpG?=
 =?us-ascii?Q?k3Pb6kLdShSWszeSINPaDZLAcb/GeTYAo7Q2Ff194UANeKfoQ2hiuWO9lahq?=
 =?us-ascii?Q?ZUuCaHs6nVPRmGdP9Rk3AXqktWhQusLML1DvvIo2BU8+fTGRIToHmjmWigs4?=
 =?us-ascii?Q?R8/VK1w19dfmA7l6apSxH/v32khAkFh8zaDdxtHyYvKWvqroD8EpFwhiz1E7?=
 =?us-ascii?Q?xDMM3lCLfC/WPDtWHE8R8Iuj4gVW8yeJj8Hfajd2UpJuNKaN4tcUN/FBrKPs?=
 =?us-ascii?Q?/yp3RqBc7A=3D=3D?=
X-Exchange-RoutingPolicyChecked: oUyRvVxfm5iGwQdkpK8VGe4Q511x8aUvc25xfo46OQxxxAiS4fOSb6ViJEfts9cEm06Vdahhr8uuvHWAKE2o4Vc2C/G4Ga1K3U+MStoj7IchkPtZB4hTsCWc+IlKoIqvsC1W93PKap9HWzyDU6gwAu6q8LKiHya2UYy7J9y6c+U2bYIxori4PR/YAQl1tvblkSjuMiGweeng88s5H0kn84QC10WQgPKmPB7h/ol8ufEXrZhv2SZhOfhvKSBVciC6EcNv7gj/IvPv+9Ld9m9S8QgoPmWmdk+Whvt503QWVOb5IiCxXgDbKE3yG7FNcvCOPXPcxgdqPKkrdwg59TrzxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc38613-1cee-4ca1-e8b0-08df25b39ce5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 03:15:47.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHfMs8IhxL5hQgvKzOBB04ywqxL/jwduJotFN1p/EJaByu8gi3pYrC5AtmXu3FEAbzz+vTPTMa8GdcfotXqdXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5283
X-OriginatorOrg: intel.com

On Fri, Oct 09, 2026 at 12:47:31AM +0800, Xu Yilun wrote:
>On Tue, Sep 29, 2026 at 10:38:36PM -0700, Chao Gao wrote:
>> With the helper to read a table of metadata fields in place, the
>> existing metadata readers can be standardized on it.
>> 
>> Convert the version metadata reader: add a table that pairs each field ID
>> with the 'struct tdx_sys_info_version' member that holds its value, and
>> read all version fields by walking that table.
>> 
>> Name the field IDs for readability, so the table entries don't carry raw
>> hex literals.
>>
>
>[...]
>
>> +#define TDX_SYSINFO_MAP_VERSION(_field_id, _member) \
>> +	TDX_SYSINFO_MAP(_field_id, struct tdx_sys_info_version, _member)
>> +
>> +static const struct field_mapping version_mappings[] = {
>> +	TDX_SYSINFO_MAP_VERSION(TDX_FIELD_MINOR_VERSION,  minor_version),
>> +	TDX_SYSINFO_MAP_VERSION(TDX_FIELD_MAJOR_VERSION,  major_version),
>> +	TDX_SYSINFO_MAP_VERSION(TDX_FIELD_UPDATE_VERSION, update_version),
>> +};
>
>[...]
>
>I think something like the following is quite clear to me:
>
>  static const struct field_mapping version_mappings[] = {
>	FIELD_MAP(0x0800000100000003ULL, struct tdx_sys_info_version, minor_version),
>	...
>  }
>
>  or even:
>
>	FIELD_MAP(0x0800000100000003ULL, version, minor_version),

Building the struct name from "version" needs another macro:

#define FIELD_MAP(_field, _type, _member) \
	__FIELD_MAP(_field, struct tdx_sys_info_##_type, _member)

This shortens each table entry by 20 characters. The struct name is no
longer greppable in these tables, but I don't think that matters here.

Dave and Nikolay earlier suggested dropping the per-class macros to avoid
excessive macro nesting, and this adds one level back. But for this single
generic macro, I think the shorter entries are worth it.

Dave, Nikolay, would you be OK with it, or should we just let the entries
run up to 100 columns?

>
>It clearly tells the mapping for the class, the field, and the field_id.
>
>So I'm not sure what's the downside of a literal hex here. To me, a
>TDX_FIELD_XX MACRO only creates duplicated names in one line and
>unnecessary touch points when we add a new field.

Naming ABI constants is the usual kernel convention. It is true that the
surrounding code makes it clear what 0x0800000100000003ULL is. But I think
it is even better for the constant to describe itself.

Not all fields go through FIELD_MAP() tables. The CPUID config arrays are
read in a loop, as TDX_FIELD_CPUID_CONFIG_LEAVES + i. A literal there has
no FIELD_MAP() nearby to explain it.

The TD-scoped metadata code already names its fields (TDCS_*), so this
keeps the two consistent.

I agree that naming the ABI constants adds one touch point per field. But
I think that is a small cost.

>
>
>> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
>> index db209541d3cd..10cbc2d77a5a 100644
>> --- a/arch/x86/virt/vmx/tdx/tdx.h
>> +++ b/arch/x86/virt/vmx/tdx/tdx.h
>> @@ -52,6 +52,16 @@
>>  #define TDH_PHYMEM_PAMT_REMOVE		59
>>  #define TDH_SYS_DISABLE			69
>>  
>> +/*
>> + * TDX global metadata field IDs.
>> + *
>> + * See "global_metadata.pdf" in Intel TDX Module ABI Definitions.
>> + */
>> +/* Class "TDX Module Version" */
>> +#define TDX_FIELD_MINOR_VERSION			0x0800000100000003ULL
>> +#define TDX_FIELD_MAJOR_VERSION			0x0800000100000004ULL
>> +#define TDX_FIELD_UPDATE_VERSION		0x0800000100000005ULL
>
>I think these are unnecessary touch points, metadata readers never use
>these MACROs.
