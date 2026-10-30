Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793398096;
	b=U0CRvmsvJHsHzWmIdqctqJkHY3/EnN4sMW5so/3c1uqxQrpg++L0CMwsiZFkqMs53j0i
	 DPKHwrf/IgENL+QWsk96EiVy1axGS7CCRTSSu04L/Vgs42brJsCB46c6M3h94/SBUB1kX
	 rW8vGri0VrwflV8ARRJsvyqc0Wf1DheNsCC9H3BFeCJfmMv5jUGkyyc15F0u0yR6snpJP
	 27l7tbmTJKNNyFF1SvOQg/gVF6k+hCDieOXMKPaLHgBwi+IvnucVlXKsmlftArNO5X0kG
	 J5m22GJjoKcKRBanub5o5UjEj9T8IpYfDsrFwEdN99il963G+VoZi6DMXnCnlj0IKSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398096;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=4xkAlUaGSnm/5CyQJDbUGTE3ltA70WSJ2qsT+bzFgZQ=;
	b=L7HYEpTuVxs77+sU2SsOtVlsl23/sp4uw443CtsYZY3P2o+zzmEtT6KmacG2DDLtSZY8
	 AcjgdB7ITchEKt0Lv/eqIW37J5tGKNj9wHYnrhbIlnaXjCH9UpOzmILq/9W1E+Souh9vG
	 e7NcU0TE4CR5WO1/PA55BzhDU8UK8DN/rtzNtKc7cDuvZPS+B86rm0pazvJuTAIds9eDH
	 o3JpjqN2ri56DBHUZo6rylq6jDWkMOwbBLBXI82xFmePh/GckYXvSfoPc3ThNTC+TAEHS
	 14qR1MtTZq2u3O6eRQNIJkJ52mW6b+7sfYxTmZSMLhjCML+yZIHZ0YGn/L6MacTbmiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BDixnfyo;
	arc=fail smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738F7606A31E;
	Fri, 30 Oct 2026 22:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 738F7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BDixnfyo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793398096; x=1824934096;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HH4/V/2eMXM+7fzfHVcualgICbdzkUa1dj7m5DIMjGU=;
  b=BDixnfyoSskqhHUGqZ1A8Ec87of6PaE0Yzi0O7LZXGOS1dPNCekkjefB
   1ZfaokEt3WScg1fZpcBrWXVaaUjViUwSisdDGPFUASQC7xtysug811OV9
   Gh8zOv9AtQBpV+gZVHYd91Mdic8Cux//f+f39CQqYLi/pZma5lpwQqiDs
   VdXKfRzLF0v0SF51mpiQnX+NR2YQl4IFWaPGht0woomjIwNcPWHCq0Zdv
   VaM12t+qeFC3xxYLfCWdFGhDspOwCmfP1tRnFYLPcB5NEVqIXGylXWdWl
   fU4LLsD/hvLa/q1jdMaZh7zMXz9irCrhUEiN2+9Uae6os04V8EFKxsXrZ
   w==;
X-CSE-ConnectionGUID: hX8rgEMFRCGgdPMhNG4Pcg==
X-CSE-MsgGUID: XGSjCOJvQPWGdB8acZ+8gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2273886"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2273886"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 15:08:15 -0700
X-CSE-ConnectionGUID: c8F0YIlkTvelfFwqzlp09w==
X-CSE-MsgGUID: GX/dn1pAQcObbHaAxvha3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7365449"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 15:08:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 15:08:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 15:08:14 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 15:08:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKUbisRWOquQctI42D6TuqwssImm9xikiBMgbkRzD3sZd5ovEr5Gf34xKukf1yZu6rDyEkaN00ELLa8KDkZbPalqGRRW47KgXM3HX6huyj7XNOs2IjUMgSKhaxIbDppPjJosPs+7RPadILrpgXq1RXYfTpb5wdB6dHLYywLxfz1bI6L+R3eL1PHfMeBQf9T+3JIvzdcw6KvZEbcrn6dUSF5oIYUj+tbbXgxE37Jqx6xYYr6puw828gcEPfL9HMJEGboIAKtYoSqoRUkNXVdx+y2dwydQc7/jmTsvkRXcnplMkDxdHdcAqrPk8fQTVpPAjJfTGwdTJPBaWEeFMwpgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xkAlUaGSnm/5CyQJDbUGTE3ltA70WSJ2qsT+bzFgZQ=;
 b=hx44q1ytMaiZvp2DmWvVM6h7oGL/OJEfB/FXmBzqvDNx2P0ALoeAAhkAxffw+IUZ04vvesv4k0givpEJkXsZmo6iyJqH1DLrSM/7f20Oftltq/zmiOw7Ae95KO1N61SSfsQJa70FlzebRf+ZoofL8n3tCk+1uoYOziF/qnyJNbGJGyz1zIa1jwBmQOqVQ6SrMRVda9hjKw635RyKqSqP99o2Ku+w5VrBYoWiBgCbxpk5Nte7tWdAQkKPPX2d2MGEY4cDmdgU2iXq8nYRpmo1O+kbEaIVvr+Ovmsy4nA3TOTCjdy3Ott6K7nj+RwRf6H6wDl2PZlxLJiHKBfzybq0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by PH5PR11MB880693.namprd11.prod.outlook.com (2603:10b6:510:501::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 22:08:13 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0546.016; Fri, 30 Oct 2026
 22:08:12 +0000
Message-ID: <3ebc7028-c559-4add-800a-614b29d66ba3@intel.com>
Date: Fri, 30 Oct 2026 15:08:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] x86,fs/resctrl: Keep mbm_assign_mode in default
 mode at boot
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1793392128.git.babu.moger@amd.com>
 <c1e5ef23e83ea663e9aa969e301fac20723a988a.1793392128.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c1e5ef23e83ea663e9aa969e301fac20723a988a.1793392128.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::22) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|PH5PR11MB880693:EE_
X-MS-Office365-Filtering-Correlation-Id: dccf91c8-b0e8-42f2-255b-08df36d24a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|11063799006|4143699003|56012099006|261009223027099003|261026121527099003|261028144727099003|261021121427099003|261022075727099003|261022113327099003|10067099003|261026140227099003|261022105027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: dycCBpE99BcrZIMtvki+EwBeSbNMuohoKouqjg5Bmfko7VglhKygjmCC8n2lgEAJBGcPGDLHQDiRAe72P9uofyKdSQalN/uK/jDxuVHKgrtnqhnyp3sAravCEdLrlHQYDdF6SuEVMmsqeP3Sv21BEBcHyElxCV+CDlaswv5BoGpJ5xo+Ac7aG2s1HYxFoC4J8LOwUoN+X0WnmpqE8NBnLl4jve1z2it297rLPwYdThvaznE9oeUysUxdb0QfdyxW9f65//GkloZbVTaNivyIls1b/7AP5mpOx77ZEaAoRjBa42oTHJVLXP30QYlTsxPAhaIOYvX9F28CXZdz5Z5HfANkzwqYRxWpYEeMF1qD+toz6+JYY83XdUytIuVb49tFL2U4rNntCLxokIzj4cwI1/cXDpWIsl78oPt+/waxWffqYwuA5p/2A7MKygakewfIG+83ANfvSTbis+PbfW6/ZDDojnxQMJ7gxPRVws4O4VsUZ2dp7ZkHI+cMImWWJVQc5Vn2IMvqjaJPdUyhpufswbTxzVsqE6k9URPdbW6jc0KybAdlP7VsCoumjS1Pp6zlpG9pnWa1gWZDJ2OJ//t7Z/E/PP38le2tEWKckE/OG8+Cz9Z+S58Yf9PuUEOUAMCR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022113327099003)(10067099003)(261026140227099003)(261022105027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajFramRrdHBuOUlIRWFMRTFQU3VobkNxUXdSQXdTMllLQUJiTjAvWnJ0Ri82?=
 =?utf-8?B?OWVZMWYraHhxZ0Q1WGZPNUg0Um50elpLNlVKczh1Q2RwZTFyeTVJS3hzaS80?=
 =?utf-8?B?bCtrQ3A5QmVIMUtOTnpOMklCNGkzVlcrOGtNSEcySzNjbkxsZVRJQjdXTkFh?=
 =?utf-8?B?c2pjS2RmMjEyY1JnaXJjZDNnQlhYQVI2U1VXTC9ML3BUS3djblkzbVFkS3pa?=
 =?utf-8?B?ekJlZDlML2dDS0JGNzJDOGR4NFpONHlxZzZCeHNaRzFUb3ZuZWNwbGRvMnlX?=
 =?utf-8?B?S1p6WC9LU2FhUkhjVVJmV2N3OXc3ZlNSS2dmbGR3czBkSlRwNDJrNkFQdW9k?=
 =?utf-8?B?Nll3UnI0ZmlQNElnWHYva3B6OVFXRDVZUk5ad3NlNHM4UnpmVlh3QXdablFJ?=
 =?utf-8?B?QkUyUXoydkN5ZlhlQzV5bnNGTjlwNHhlVnREaVBYa0F2TTIrWi9WZnQxSkFD?=
 =?utf-8?B?TmlHTklpaUFWSUxpbnRCdURUVHlibkRnL2hWVjdsWFpBNDQ3cTdYaVQzNXFF?=
 =?utf-8?B?eFRRbk5BakxyUmxITC9tVUtLQkxxc3dJN2p6eEZiR2hIZUFJT3A0ZmxUVEx2?=
 =?utf-8?B?WEhOV0QzSWpYZDZVK2p0TGVLZEdiY0w2VlRxRG1WQmRhWFlkcnEyNmRjU0pH?=
 =?utf-8?B?SHBENVI3QXlZem5BZ0NmSWVvL0RzNGJTeG45VXhBWjRvYlpUeFh1dFI1NFdz?=
 =?utf-8?B?L2Z1b3o0WHlhZ0ZHN2NFOGRqSk1tN2J5eUFDTTZ0YW9BelRPRlhnTGFZWDEz?=
 =?utf-8?B?VDJEV3VpU2oxZFo3S09FOGhPS1FrZ3RuZ2g3QzRkS2NxcW9pWkw3RlZmQWtz?=
 =?utf-8?B?dGFzekUycmUrZWZxUWdINEc0MlpnUi9uSTRSWWhrcUw3QnJ4dUpYUVQwN2ZN?=
 =?utf-8?B?VjRDZnlTak5lZGtZaXVZaVlUaGZnNENwcHMvVlJZQnV6VmVKLzNlU3dkVGhM?=
 =?utf-8?B?S1Z5ODU1ZE9XNlJVSEhCMlBtMkpIY0Y5TXZQZGdYaDFubVNWR2RLYm9pZVZ4?=
 =?utf-8?B?VHlMRU9DQ3cxOE5JZkRhbVd6dnZLRi9jSWJJVjdGWmtWd2tleWVQaEtYcnoy?=
 =?utf-8?B?ZU9JZFFCV3g5YzFobkRTVThndXM0K1ZtbVBmdk5xL3JtRGlHMlErakQ2bkIx?=
 =?utf-8?B?aEhoYWVhZ1hzS25KYnV0YmFibElEVTZlMis3SU1zbDZaeXE4Y0FuOGtRc2c1?=
 =?utf-8?B?UjJIRXkzMENBMVJBQkxWcmNleWlHbG5KVkk3bnNaTU9OenlGc1J3WGR3VmZL?=
 =?utf-8?B?bWRweHduaUkvYWl5cnZDWXBnQjBCbFFRSlF4RGZzQ2M4OUZwZDl1QjBrZWlo?=
 =?utf-8?B?Q1BvbU5kNU5QcXk3WkYrSElyQy9xSnltSGhPN3VpSzhkL2lnVDFrcVU5TFdu?=
 =?utf-8?B?OUptZjNBWWFsUWpsYjlvemRKUnd0MHBVQnlIcEJma0hNaFA4OUxYZklPU3Fs?=
 =?utf-8?B?Yit1WDdHTGJ3T01rRFFtV0RnSUFscWpsMklCdHNkQTBDZnY5dCtxQzk2Yzlq?=
 =?utf-8?B?bi9pZlB6WVd1VnY4ZXZ3NTRyN0JsanhLK0IxclFWMUJjVndSbXlVdzB4aStY?=
 =?utf-8?B?L3NNdmhkUmFkVUtPMlAwV3JmcVI5NEw3TmpjVkowbStnK25GQ2lvZis3alN4?=
 =?utf-8?B?Y1BjR0orSFRxOEp1V3Nkd3U2S05YKzlqSmRRQmRJR1d6bFdlQjdFQ0QxYjZs?=
 =?utf-8?B?N0lzVWRDWmZ0YnFCY3E2bUlhWDl2Vy8wODhGTG84VGpHeDJaR1JHRVZaeUw2?=
 =?utf-8?B?YVVKMlBXR3BuUnVqVlhKa1VkQkd0b280L3V4UTFEeno3cnRseTFaY2ZrZHRW?=
 =?utf-8?B?NzZtdkd6MEhOMk0vVDJwT0QxZyt1dVhaTk5YL0J5NmdPL3Q4OGpoTlNJTm1J?=
 =?utf-8?B?UFNvUWZoaWRPRzdjTVVDSEUydi9wSDE5MjRsNFhmeTZvV2t2S20xeXdZdjVV?=
 =?utf-8?B?ZmNHbzRNRHl5aDZ4R2hUVHNtWFhQTElwdkx5WEFOLzFETGlMTUFXK0pJTytz?=
 =?utf-8?B?NXh0bWpXUlRDN2FVc0VBZW13MHlwMExkbHJ0WC9PWitQK2xTVk00ZStBeFlR?=
 =?utf-8?B?WFN6cXdHRUI4a1dIVngyZ05nRE5PdmtKNnBrTnVTeHI4blNCVitpd2pVemM0?=
 =?utf-8?B?cW56aG1KNzAxUlVTRUhOclRINGY5TTVLc3A5SGtiajQwWWJCQ0Y1T3lRVU9a?=
 =?utf-8?B?cXZqbHZwSmxPYmszdWIxTGJTcldWMFNZMDJkMlRpNW9Kb09qVDA4dEVhLzNr?=
 =?utf-8?B?QlVHR0RqRGNONVRCMWpKUzB4UENiVTZIVkJwTHNKSDJxaE1DY0JsT3U5OWpG?=
 =?utf-8?B?TitSRnRFMis0c0lSOTd0SzVneTl2RUlsNHU5a2Y1bmVtWEZvTHZPTE1DcDZ6?=
 =?utf-8?Q?NpcSPafeLpvoNfos=3D?=
X-Exchange-RoutingPolicyChecked: upghg7zm2OIU3PIYQ8NKWuZ2luXCCQO1DbvrzPR1UkAyk4Fp1yCLcNLgSoQSlwTeEl7oEmW0xJT34dTPc2ZrvszcZXFQQUonmdgRocYlNAqI4TYwUM9hPof9vyWOtcwOhcy0fklAx9JO7N9XySDnnal80qFl3PLuvgNHNXiuI05+FcGpo88jLJjHVDQgAKmn2bW/svqgkAz88HCKcUnJkkw3tswln398PColvntBq0H7LcO0C1c36WTSPDumyDA6IXoELqqhoLYzS9uvS4dSq1For4q+TSnVankSdg+sR5yxT6XviLlRvL5CLD/gH6hJ/lyuyDuaaPlZBT7gVwSXBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: dccf91c8-b0e8-42f2-255b-08df36d24a17
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 22:08:12.5722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER4ZTqAWCUdWCsczdm8kBKmLn6V1p7UpC61ViQSkCkjVsh8ZDi9FDjHyEoiIq2EO6tiercdEmP/0Hdl3qFQKJjYFNvvzSfmBAG3SgLHpbHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR11MB880693
X-OriginatorOrg: intel.com

Hi Babu,

On 10/30/26 1:28 PM, Babu Moger wrote:
> The mbm_event mode assigns hardware MBM counters to RMID/event pairs.
> It is intended for deployments that need to manage counter assignment
> on platforms where the number of monitoring groups exceeds the available
> hardware counters. Hardware counters are scarce on these platforms, so
> mbm_event mode suits workflows that monitor a subset of groups at a time
> and rotate assignments as needed.
> 
> x86 resctrl enables the mbm_event mode by default on hardware that supports
> it. This breaks the pqos tool [1], which assumes the historical default
> mode. It creates 16 or more monitoring groups and uses two counters per
> group. On a platform with 32 counters per domain, that exhausts the
> mbm_event counters pool, causing additional groups to read "Unassigned".
> pqos interprets a non-numeric event read as zero bandwidth and reports 0
> MB/s for those groups:
> 
>   $ sudo pqos -m all:0-4
>   CORE         IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>      0        0.69         16k       192.0         0.0         0.0
>      1        0.40          3k         0.0         0.0         0.0
>      2        0.44          1k        64.0         0.0         0.0
>      3        0.39          1k        64.0         0.0         0.0
>      4        0.43          1k         0.0         0.0         0.0
> 
> Leave mbm_assign_mode in default mode during initialization. Default mode
> uses one counter per monitoring group. On existing AMD platforms, the
> default active counters pool is 64 and may be larger on newer hardware.
> The active counters pool is the number of counters that the hardware can
> actively track in default mode.
> 
> Deployments within the active counters pool receive accurate bandwidth
> measurements in the default mode. Users can create more monitoring groups
> (for example, 4096 on current hardware) than there are active counters in
> the pool. Beyond that pool, readings may be misleading or report as
> "Unavailable", with no user-visible indication.
> 
> Default mode is still limited once the number of monitoring groups exceeds
> that active counters pool. After hardware re-allocates a counter, a read
> may return "Unavailable". pqos still treats "Unavailable" as zero.
> Successive reads can be a count, "Unavailable", then another count. pqos
> treats those jumps as wraparound and can report an inconsistent rate:
> 
>   $ sudo pqos -m all:0-4
>   CORE     IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>   0        0.76         60k        32.0         0.0         0.0
>   1        0.45          1k        32.0         0.0         0.0
>   2        1.57        107k        64.0         0.0 17592186044184.9
>   3        1.62        276k      4928.0         3.2         0.5
> 
> Users that need stable measurements beyond the active counters pool should
> use mbm_event mode and rotate assignments as needed. Enable it with:
> 
>   # echo mbm_event > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 
> Fixes: 0f1576e43adc ("x86/resctrl: Configure mbm_event mode if supported")
> Closes: https://github.com/intel/intel-cmt-cat/issues/311
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Cc: stable@vger.kernel.org
> Link: https://github.com/intel/intel-cmt-cat # [1]
> ---

To help future readers understand how we landed on this I think it may be useful
to add a link to the decision that resulted in this fix. For example: 

	...
	Leave mbm_assign_mode in default mode during initialization as decided in [2].
	...
	Link: https://lore.kernel.org/20260804191608.GDanI6eK2Q07w6pNcb@fat_crate.local # [2]

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

