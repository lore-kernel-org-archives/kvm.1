Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A741A9F96
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779771153; cv=fail; b=KKtQ4IEXrXZ5k6Jw9jBm/Hd1nhdYLB2nYUYrTlP8yWlPenJiA1me2HBB/uT+L1BObHO6z9fXr2/k1XmSQvmY4zAOVG6qURHpWpzI+TynJ+VHP/dA8zsfNushM1rAjvOeecGn40TAzWvxs+Y/MgU4UsfZhvWQQwx7XaMInmKGI8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779771153; c=relaxed/simple;
	bh=F7ZPeRaboDnQpDWYQq31qlBOwb1NP7+RSR94sAznU70=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RVLzF0FiTd09EQnwLBfFeU5xm2Z3RDKdJ3YCuFaRidwqqzx4dsSDwTTp5C5pMzjG3uYEYJ7Lu0ceBKL4hVZ9N5KVyDlLxE3whyOexSGTvq0JQjE97mHEQo0UkvF/p8WBMDvJJr/DVXDb2Ai5H6UKxob12JExkXPAy/eKiSvfw/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvrJ6IDb; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvrJ6IDb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779771152; x=1811307152;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F7ZPeRaboDnQpDWYQq31qlBOwb1NP7+RSR94sAznU70=;
  b=ZvrJ6IDbV0zSgqK5A6Wi9D6uzsgQm8eYs9YuojoMHYke+ypAMaH9okmT
   oqwH/CC9o9ggV1uN3bZlbalJ5AMZcJ8zvTJUpqqvK3LriMdyQOWsY6/Te
   muHfycFE/sVhMpH6lVpXFyBHXJwCQyE8IYk2IfaQx7udV1u2GcxuJLZZ1
   iiauqqUuG1rbI3Z2iwqk2mJ6m5+Myjyp6RFDkb5kdY+mJy913et/JZX5h
   DcXECSJYZ0DwStGi+6xmoyrBDFbSbiTq3B95jWMdPEuFgk7TouclnQYGo
   MOJ3dmTv/t8jltqFWyFLKjtw2CGG1xeaEFMCw62OLJakLjJILkOiV1YSQ
   Q==;
X-CSE-ConnectionGUID: Y4kVC40HS9uSFy9xq7fD7w==
X-CSE-MsgGUID: BVQbT+nYS3Keo+N/m4zaIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80561062"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80561062"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 21:52:31 -0700
X-CSE-ConnectionGUID: dG1lN6odQ4254AKbvKRFOA==
X-CSE-MsgGUID: NFgaShuPQGSVLT2N7Mr2xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="240756094"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 21:52:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 21:52:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 25 May 2026 21:52:30 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.49)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 21:52:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6uecpDJEFh0sTmrS1eZL7GP4aR2aQYLl4Pp/xF+evioCKHbQArl8ru/dp+bo4cSH/pfL9SJ/7o1kwkDR5V9ZVWLWWYgMQpp334BE7UZVco0RdCP8zCTxDyqfn5FGY9O5KoDwNeHiAMfSMLejvav6XMJ0XkRLmAVgJxrnC6FzGpx8UnsIS4cOMD9AVaQf98eCPHDmwXxUSzJogScHcP37Egu1WpNBw8TkyqerrEqoSbO5XeSYN6m9Gl+Vb3ZEMks/rsi7jP3PFe6sVu/hc6Va1u7YGtUcmEcE6sPjO/YtA5ejdC/gLcSUZMRblFxJAP3IpY1312a3NsajVQ14KS30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IavYUCKaeSDd62t5REG6e7xC8pt7jvYfFuAFmxMOCbA=;
 b=Rwyv5l83UErtiUagt1Wjdxzvn98VMahsjv91A2Lxc5gDZuUBv9Qsyzc7XTUAlAjfes0kv2WjJJTB3xeu9gaRCM8uOPx7QrNjLlfMGIgZruVjymMfXE40lZ2L5mQCG0Eg0K1dZFmzTdeEu9uzik16ZemgWSJWx62DIcPK6AIU3kT0q9qo4qcL6ojsb/NYrcB2aJsWjAuqeroY54AT6rp80BduUKe4C36dhB7SJO89JVFe3kAvzNm/g0jdacpKB4+jki/Pb7NS+/+hAUpB/ETgiqw06QAxeMo7QzYel2wzxjW2zuABzikVOQKPIvm9t5e81Gly13raxJJkRtOGYCigOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CH3PR11MB7721.namprd11.prod.outlook.com (2603:10b6:610:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 04:52:22 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 04:52:22 +0000
Message-ID: <a67bb8f4-1b26-4399-a532-4d8ab1e18cea@intel.com>
Date: Tue, 26 May 2026 12:52:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 1/4] nVMX: Remove the IA32_DEBUGCTLMSR
 access in debugctls test
To: Xiaoyao Li <xiaoyao.li@intel.com>, <kvm@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>
References: <20260526031704.109102-1-chenyi.qiang@intel.com>
 <20260526031704.109102-2-chenyi.qiang@intel.com>
 <a5ac59f9-7215-4345-b67e-6a850a98cab0@intel.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <a5ac59f9-7215-4345-b67e-6a850a98cab0@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|CH3PR11MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a10aa98-f552-4b80-0b50-08debae29292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 5wpGBm5NtWegFt56TsDq9yyTI+qRYLFtmz0jUu8kdWoJprK7dUZvTV8rhte7p3psT/gd7aqNrf09Do3m4Z2fbTaggCCBgrRcmSJgdaQk00bUMJDbQKE6RCBojxnK274/2nDjDWWi43j3RnSqrmd7Xp3YTjD0H6eoSFJCrQBTk+xe6GohBURridRnB+CoUYUSDV2sIa+2YdXmH7oEs3XvxfbxkSp33KvEwE9vut/7i3+IB3JtHv0KMltr3VfsqE69UW7xDu2tHFuGtn+IsibkFEgTdkcaRQs9xgRe7pu1TY6v3pKJC3GhBh51IFtxmTVryLJrICZVPlEfE0z+jagaaseWgYSpst+yIGefM37bJ7ftUaTnw0nmR1cg4h5OEN9kbcMei3/s4c7dFiPH1TtXHmoapws3VNU8iVH3bss42cU6gHsRcw82teO8KWYD3cKC3pk6oojHkOzKh4wfY3/vEwK7OGV0FPSJNxERrAO8YO+BQ2Lh27ndOZbFAeLrup2AR8wQ6kcdtUM5nTXO8w0VVLZ32dvwbzXlsUuzEHuc7IoxJUAPIitLq7APtfPu72515PbXil/m43hdvzxQeINZDoB+oqpGlvp8IjVF8RvBTt3EVB2AgekU8um2UXl09VvU4wt3hCgsx7EGgD8cOxBwyEiXqh7MQ3Jfuvyk2eV8wmcj5k6d1Sp9IYUqVLUPuVLu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU1KaFNZWGw5aVFncWtFL1NUaGx2MWFnc2ttTEt2RTlZakV6aE5TT1gvbHIz?=
 =?utf-8?B?WHJtYlRQc1hrMWt0aE5hNHRnQW5wYlY0WFA0VFZLS0M1b2I4QTcwdjVMalNn?=
 =?utf-8?B?VkQ0RUhRRkI0VjgvQVZTVXVkMkZaQXRLVUZ2ZWdBRGc3U0YzbUZXRmdMeW9P?=
 =?utf-8?B?QnBHYVVJYlBFZUUwY1UvcmcydzZDbmkrUmVmTzREbTFXblBGSjMzR0tGMGJt?=
 =?utf-8?B?Y2FMWjhtRzZyYjlScVJkckEyN0RhS3BvNENRVEZQcXlqL3dHUTNvTThOb2FT?=
 =?utf-8?B?amZhWnpFM3RJeURMRG5KNWdvUUJnemc0V1lPekZ5TE1IMmgwTzBqTy9BakdE?=
 =?utf-8?B?cnZibTliV0FPRGx3MVVVdHNhR3VqY2ZGS3lyZFgzT3U4K0NqMlBtUW9yR1BG?=
 =?utf-8?B?eDkxK1o2QzhUMVdyZ1NMNUovL1BjV0xwdVI1bEZHR1c3eFBZMG5UR3E1d21J?=
 =?utf-8?B?L21qWkNUUHdzK0xzYUdJU2grZFU0aHQvRzJSREpZR1pHWDRZelk4Q3lLL3dq?=
 =?utf-8?B?Z0djQTF4eDJMblp0dUpGTm1ER2N6Q1dxRzR2SnpVK0E0WDdVQnVLdm5rUXgx?=
 =?utf-8?B?MnlBMm1DZEpYUjE2WFNOckNMa0RXMGh3UUVBWXF0U3JGMFRBcC9SbWp4UVFp?=
 =?utf-8?B?MkdWdGRWd0gvK2FIcXhGNzFJYmdpbjJyL0tRWW93WnV6ZU9RNnpFRlVSUCtO?=
 =?utf-8?B?djlvSGhHMzlQOStCOGhIRzg1cHJ4ZENVOUtBN1JmelJmQlV4Ry9wY2hSN1FX?=
 =?utf-8?B?Mi85SVdudk5aTU40S2I4ZDRWTFljTk9MWTZMQnUyay9wTFhOU3lGdytoZnNz?=
 =?utf-8?B?UXFwaFFNb1Q2c2Z6VG5ZaWJKRjBxQTU2aGVWWmttRW1mMFlGOTgyMTJ6Q3Fn?=
 =?utf-8?B?Wk96RG0rMUpLOHFPaGZsR0ZrTUl0UTM5a2ViYmlqRzZKeDI0MkxwVXZNaDI0?=
 =?utf-8?B?MEc3RHAwQkNTMHZWVWdTUXpDeEZTVkpWeTc5MnpPUXRMZk9KQjhLUVB3M09O?=
 =?utf-8?B?UktncWNscE9MZmM4cVN5Nk1jcDczd2NUZ1NXYmEza1Rob1p6Z2kwdmF1d0ZD?=
 =?utf-8?B?UXYwaGNRb0FocUd2OXJqZ1BDU2Rwd1ZDS205aUp6ejAxZ1V6SnFYK2hZUVBE?=
 =?utf-8?B?TUN0YldKa3lUcTl0VFFqbHkyRzQzRlNHL3ZwY0JKWkF5YTJMZmJpcUt2c2Jq?=
 =?utf-8?B?UExVSnZwVmRERFFYcWxMWE5UbWp1VlBJakRzNS9ZK1MyNm1sLzJOaGJENXpO?=
 =?utf-8?B?emJtVlV3WERmTDFHYTNLV0VLSjY1c2FNcWNkVHN2QjJ6bE9CREtyUXpVaHEv?=
 =?utf-8?B?UjkvdFhjR1BaVlJ5akNBMnB4RnVqaE5LeWR0VnplQ2JUSXBiRW50QU1vbUpR?=
 =?utf-8?B?ZzQ1YVNNU0hWbzEzQlJoSDl4MnNFaWtxMktBZkNTekpNdENadURlMktZSXNV?=
 =?utf-8?B?WXdJVnpyQkt1MzJ6Um9PakVqQmhkOWxpdGtadEdvQVY1aGZWbk9BNTcrNUNB?=
 =?utf-8?B?MElPZCt4MDg5clZad3NScXVuZnpGYWUrcmplcXR5ZHlHQlhOOXNCdjJtaFJ3?=
 =?utf-8?B?REQrYjArTGtaTVlLVzlNTE1IS2doeGRkdWlMMS9DWUtPc3NqSEZGa1ZkSG9s?=
 =?utf-8?B?WFlGZTlDekxxZEw3dUl0Z3JlL3VkdUdIUjBGVWNhODhqWFoyS3FYajA0cW55?=
 =?utf-8?B?MlhaQnQxMWlncGVEblo2SnVRODNNaHBwL0U0MFljY2llRXdpS3Ixc1BRMEwx?=
 =?utf-8?B?ZmdIYXR0V1l2dm1MbUhqWjBzbWVRZlJSWFIxanpRYTJZcFpiUE54dEw0WVd5?=
 =?utf-8?B?ZnQ2QlA4K3RWQngrOEQyZGVucko2elR1cnRSaXRPdno0VFdoVHB4RE83Q3Bo?=
 =?utf-8?B?SkJSL2V0UUMyZW5QQldjcE9YbDkvYXpZOXdhU256bE0zcDBycVNkbDNMRU42?=
 =?utf-8?B?b0tmTklVeDU5MWdzTG5VZVBUc0lrWklQMUpyVGYrV29yUWUyUlZLdi9rekIv?=
 =?utf-8?B?Z2FFdmw5WjQvYXlNdWE2dSsxbnlNLy9TTFVVK2V0dGY4WkYyYTkraWhrOWdU?=
 =?utf-8?B?WnRscldjVjlYRUY2cUNJYmc1eXRTNzlrUnBGRnFXV0IwcDhLRUdmOGlKVENp?=
 =?utf-8?B?MUZDajVLMk9HcUs1RE4yZVRzbDk2RVB6eGZOazFIZUg1ZXBzTWoyU0V6Slkv?=
 =?utf-8?B?SGd0bU0xZ1ZFOVZvVXoxWk1xY0E1S0dWUmcycGxjak1LR2VpL1ptbURoK0pZ?=
 =?utf-8?B?K2xKYnBhb256RzNEOEdpcGJsdXAvYi9xWmovc0ZuWXU2QWZmcEV0M1h1Y3pt?=
 =?utf-8?B?R01SS0Z0QW1JeEN0TWhNWEphYkZvY0ZReWNxQWpFa0xpMkZMT0JvUT09?=
X-Exchange-RoutingPolicyChecked: nJO4a8TNWH/hYj7pIu9XIRwrX/UGjC6nDtQt3Hvi2P6TsMOsFliNL1y0WsafEZ6ywQnM+avS90db4zSb+zsO5tBusQhpaRaPPiIACJLzCL7nfA51zAPZ7ErK2HsnO01gTfKjvjG9jEL4ymljMHYWRVJ0/iEt5ukj6ulntuPxwHUUy2WJz1iCLxJa8/TJoIJfxJBirn/4neDhqGZCF8L0xH9nLJSh52NPhmzsCc/fXF3qKGUntDjVH7+26BiPFRYpFuOkalJuUIJxwcQbQEdr8DidgY++PugdmUVKqNklYQd4zbR0eJkyyhmAnet2WbJCfN08+8ov5KXhq8wuzAM5Fg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a10aa98-f552-4b80-0b50-08debae29292
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 04:52:22.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQGjErECOBZ94IbOdZxOmYeuF61SsqX3VvJi5pQSDmUSkt+6j2cxMYirrcomLt/TOKNptIoW/ky+CC40daOcXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7721
X-OriginatorOrg: intel.com



On 5/26/2026 12:39 PM, Xiaoyao Li wrote:
> On 5/26/2026 11:16 AM, Chenyi Qiang wrote:
>> "debug controls" test was added by commit dc5c01f17b1a ("VMX: Test
>> behavior on set and cleared save/load debug controls") to verify that
>> "VM-Entry load debug controls" and "VM-Exit save debug controls" are
>> correctly emulated by KVM for nested VMX. But due to the limitation that
>> KVM didn't support MSR_IA32_DEBUGCTL for guest at that time, the test
>> commented out all the value comparison of MSR_IA32_DEBUGCTL and leave
>> it to future when KVM supports the MSR.
>>
>> The test doesn't check the functionality of save/restore guest
>> MSR_IA32_DEBUGCTL on vm-exit/entry, but it keeps the write of
>> MSR_IA32_DEBUGCTL. It leads to
>>
>>    kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x407de7 Unhandled WRMSR(0x1d9) = 0x1
>>    kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x0 Unhandled WRMSR(0x1d9) = 0x2
>>    kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x40936f Unhandled WRMSR(0x1d9) = 0x3
>>    kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x40cf09 Unhandled WRMSR(0x1d9) = 0x1
>>    kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x40940d Unhandled WRMSR(0x1d9) = 0x3
>>
>> to the kernel log. Though it doesn't break the test, the log confuses
>> people to think something wrong happened in the test case.
>>
>> Current KVM doesn't support some bits of MSR_IA32_DEBUGCTL but they
> 
> This sentence doesn't read right because my version used "does support", not "doesn't support".

Oops, thanks for catching it.
