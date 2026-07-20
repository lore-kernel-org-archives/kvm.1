Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C7B3FC5A6;
	Mon, 20 Jul 2026 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580968; cv=fail; b=hJjqWJBzt/L241VLQV8xlqFdbZGhDm3saDLe+wfXZNj2g+HwMOItkq0KV/iffi3vte3hU3fCuZITTYkcWH+iO+/2w8nB64WgyJJD7gDNa3Z0b8TPVGpjXFGN4CxeNE4JTC3OZBe9yZriJ0MwIQ3VPX6HyuxVN5afgUGvDupPZz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580968; c=relaxed/simple;
	bh=Q3ndBLRM45z3cK2+8XZTI7zxUcr3YqxHo+UJ/tg1po0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KSZbhECdxbsN5LvR3ZpOagELa0IuQs9+njokhOYp0OOlOWD62gT24IFompbJcG2zDBsulufkf2AD+iq3ugZrwTjZJzj5Z+qsu8rhqdLQusXrQUIRNMincCmOtOfr6BdPQTnQTbvkdu7OLCWnio+4CzqWSCoGGf+Qkx1heqfjVM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+kM20b9; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+kM20b9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784580966; x=1816116966;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q3ndBLRM45z3cK2+8XZTI7zxUcr3YqxHo+UJ/tg1po0=;
  b=T+kM20b9GSIl+datSQSYfdBl7+3ZBxP4++TMZlsXZZYtFT+ZSY8dXj1S
   44AH9mexPnWUw6kINPkw80BFu9LfLTndBWMoDT2zONx1e/6Lm9o/0B4xH
   bEKgOmJVlWaVKasCnHIFq4rKJH2l5G2HLxDnVdkYF0DA6iOHZ333wIlS+
   r4yi01++MUcV9CWLs2XrbQOE629fY3n4taqRfmAzKhclE/H0224KGEpKz
   GGqy0L07U4FrfYaCur0Wixq20i4ptKhA4EnHqYZmbLG3Uu3nM8hM/qY3h
   UaOjEIzK6e+op9fEBUKBASwsP5Cp8aSkSeT9WHUN4UWAG7UQIXi8LwlvQ
   A==;
X-CSE-ConnectionGUID: BWArnSVvTA2D6qUHlmY8Hg==
X-CSE-MsgGUID: MdeiT64tQwuD4nusF1lAeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85374276"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85374276"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:56:06 -0700
X-CSE-ConnectionGUID: +ccAbWqZTO2ZZS4GDio3Aw==
X-CSE-MsgGUID: onNWPLo2T2K+KrrzaEivtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="258201570"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:56:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 13:56:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 13:56:05 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 13:56:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCq3dnj5Wbko/tncxTpl46uOPRJUsafkqWy4JlkU2QSgwL+E0W3+xUlfIGfZqCmyZZGN+JJlkmUJEWxPQvFCUOQXX6Ho5H7dJGGKG5tYs8oEzPOI99dhxjlBZoqN3G8H/z7+eNbvEQdWB584YXCmMbUpesUYmKR9g8+RHZMgv7BZ9S903/Gnt4ht9Hqrle1WFL5nBFKjr+cHqTifLGFS+i3oyV2HMeD1bIVe/hTFT4QfKxWw/V5maouqzxAwzgSzcA26iTVvSLsNVcnKLLCEU/0nwdAUECRN2sDyhphNBMDqQwhT3DKPjK1hwfZV/x+YqR8uzZxfeOE01IM7vQXVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHsW7+5tJbNx7yisI6wnhO2UOhWArITgx61Uig11gZ4=;
 b=koZmjeivfDrdJW3P9UV/yIKAdieulUR/sjlMVg5Ia9AvGiyVdQjH+9xvPyDYIAw5kjQtug4zdbUXcB3U7Bc1KwVmrJq0tPOOFzgwCiytRFJc8tTm/z4g6TLzoyS6d+LKnrjyT3WZ6qREUYAlXYc21pKrmk3SRbXcChsSpvLPLPLmOUV320Q9+OEN6EcF5Of+rVeMYf7A2vO5IaV3SAQXZvHJ37GaiGU+6F6lwRe+KFTJQcQmy2NZnxSc2TrOn43NDWyFF0oUy55mF7mTZFo2f+YeDgvJALpEvtym/J4atgnolqgKAIkXjvOWWYbsVfgT6VtTP68bYSn1hMKZi3opJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 CY8PR11MB6963.namprd11.prod.outlook.com (2603:10b6:930:58::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.18; Mon, 20 Jul 2026 20:56:02 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 20:56:02 +0000
Message-ID: <5fa1e72a-18e1-45ea-a2e1-22b6557a5ef3@intel.com>
Date: Mon, 20 Jul 2026 13:56:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Remove AMX-TF32 enumeration
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260708210118.402005-1-chang.seok.bae@intel.com>
 <c4343410-c5fc-4171-a120-a3786ea38a20@linux.intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <c4343410-c5fc-4171-a120-a3786ea38a20@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|CY8PR11MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc5c0ad-6355-4447-a2ad-08dee6a14e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: ETOfY1R/U7Jxnjz+cUF3yO9rFdWFSdoVjOlbzWmR1fzVQNkgF1gIMD6dmCpukvezO/hmicOjIXper6otMn7xZb8YOVWLBKln44X2A2qd9S3TPUyK+NnfzOK7uysp0m5LBqZZ8urXDOwm5m3F8kKIJ3PdERfRqU1nDbn2H0K8kZIfU+LlMvT9fq3xAskwRwMNKGqB73589DWY9MM/qFJnbp3HVV714ZiDLu//1MYudokKpuNtiEmGkqMyf6XuaTNGfCfAPQWl+RmyWPj0dDH0RV7G8+lr1OV/1QJBMqhAWyb/96qDzXVVq2rTRtvYIBVOXcTzYkDZrkWF0cStHD+MMNjwSw2kKHUYESYU8I9oXw7Kdw4BExc5rapyK8LBucQid1Tw4gdqMUxgaMkdU1rLo9oDO78dqbVCMMS5Fq8pkwPF6d3wdYmhRvD1Lt57O4/Digqlp0rjADrLzad90UG4ROvGr1yULr1iI/t+Aj1VV2LiEww1ffqKTlTvb86uzo1EH0+8nWyWme1dG4OOV2rbM9MgN2hvQ2pP1eW5FriVPcaNITqJB6RgwG3KJDLJrIz+nLE+0g4k07xtVi4VbgnWsTVT88tf6uT1cXhM++LAQlxyH4LjKRzFzjGwqs5L5Zl8eRH+hYtmJLdZcJfK8+/nNAcVk/y7eMvSfvoiNVf5G1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXhxQTlRWmtYbWZqSGJGU2pjRWlTS3VWWUNmanlrZDkzbUN3VmR5WEhkMXhw?=
 =?utf-8?B?cHRQb01KR2RwRXFBSmtzbnZmcEJ2ays2VTRJTHdjeG1uQUxINXZMZVhxUGdJ?=
 =?utf-8?B?TmJVZHhkNFJIbEdiaDVvZTJXQyt3M3hWSmF4YkgrTE83U1dzSFZFY3d4RkJU?=
 =?utf-8?B?TmVzSXRrOUY0ZUNNRWxjdGZORlV2KytFcWZiaFNRWHg1RmVzdHVmSEc2UkR3?=
 =?utf-8?B?bUZ4VHNGN3FnOGlXTmlPaVkwTjEzU3pDTVYveXBQYjNtMnBTMW16OU40ckJ2?=
 =?utf-8?B?S2pXWm4vbmJRcDdWejR1TmVuUld6bGw1eGdwSDhMNFRXc3hoZzNHL0JnUjhs?=
 =?utf-8?B?bnJwdkJteS9jaHVieGxHVWdwRDIxVkI2R0VtQTNma0N3NTVDOFBTd0hqN095?=
 =?utf-8?B?MDlTNmkxMFhzRDFBZmpueE83aHJvakk2NkR3QTdqREJKMU9HOWx2SEVQb2w3?=
 =?utf-8?B?MEVFVUdNVEhIaG9sRFJNd3JEekVHaWlVN2tzNWpTTnRFWnV5eEtsRnlWMXh6?=
 =?utf-8?B?cDNIVWFKblRlMmp0ODJlRXlBTUlrQStDTFp6TERraHlhT1pPV1UzUEUyOEsv?=
 =?utf-8?B?R1JUQ0I2OFBlelRRN09maExpNjNRSTcwRFBkVnUxOXJiVjQ2cWxyd1FUQmxq?=
 =?utf-8?B?TjExRUhZZEVSbCsramM3QWlJTWkvQnJxSmozWFVGQ2ZnTFpZWW5iSUlESzFW?=
 =?utf-8?B?YW1rRFpnYUhMSFBFTU4rMGo4K0poejZxN2dvREg4bkJjUkNQU3JsWlBTY1hI?=
 =?utf-8?B?UmNzdXVjYkp2eTk2ZDcxZGNPckFyRTdVT21rZ2hCN3FHUW5KWnlxclJ1OG1P?=
 =?utf-8?B?SUtrT0VzblpxRnFsOUlXNmJwanROY3JDUk4xYjJsMFhQUTVwUWJxdndoMENS?=
 =?utf-8?B?QW53ZStzeEdNL0RhNkZ1OE1sMzJUNUcwSU8ydUovM3IwRlFFd1U1Z2pRN3M4?=
 =?utf-8?B?NkdpbTV1Z1lnSUVhMnNnd2RqbjZ3NkNFaWYvdGNJL21TaWU3VmxxaCtvU3M0?=
 =?utf-8?B?TTArdHJnUHZ2cHZidWxCMzVGR0ZhR1NVRW0vcGR2cThkMlJuejhySTRCQ0cy?=
 =?utf-8?B?cUhhOWJLSFB4b3pVL0hTR3YyQ29EbHJBSnZRVloxNTFrZzE2MURZVUlHS1Vx?=
 =?utf-8?B?NTdSYnZ0QzVTNHkzQ2hrQzZSYnBJTGhIeEZtRlRjOEJGaDh0aFBiWEJyU2JS?=
 =?utf-8?B?T1BsL05oTkxyL1FLOWRheFdwTU4xd2dwZjBuek1mU29rNTNmeU5Ea0pzeVQ4?=
 =?utf-8?B?RWZoUytseW4zZ1NzNFg3cURmUDY4TFhMcmZORTZ4M09hekdxblZDdDkwZDJ5?=
 =?utf-8?B?a3ZlSW03L2xXOHlPYVE5RHdPWlBJZVdkUEplbWM5RlI1S085UDdpZXpXYWgr?=
 =?utf-8?B?ZVZNR1d5RjRqWEhCa1RnZkRKRlZOY3l3ZG1RdU9LelZkV1F5SnZaY0dPaGhT?=
 =?utf-8?B?R3pScFpuR2xXV0JlUWRJZGJTSHNDUS9aMitUSkZBcGJ5K3Q4YlpxVFJ6R2ZV?=
 =?utf-8?B?SWtSdkVMeXZKclNtWldQNmNycUVHQkpkanNVb2Zqdy94dmFMZnFNTC9GRk9q?=
 =?utf-8?B?U2NieEtvTmpNMk5nOU5oWHBjZVc4d0JuWkZNa3BiZHVyUzhyWEozSFJ0cDlR?=
 =?utf-8?B?TVdXUkYwNGRCa2E0ak1WYnRsbkNGaWZDMzV1Z1d4a0FVRHppR1lYRXNvL0VE?=
 =?utf-8?B?VzZVTkhWbzdKN0I1MHltNENrY1IwdlZvaW91UWFqeFdZUGYyUlIyckZqaVZW?=
 =?utf-8?B?dUVNZVpmQUhLNWhSTncyRXB5UjBiK0tZMFN3clBEeEh3WVZuKytkVTNkLzRj?=
 =?utf-8?B?UEthUGFMZE5EREVxQyt0dHBIamdrUThHbEVSRldxRWNzQnNsTzh6dGw2RStl?=
 =?utf-8?B?ckQyOVZDZGhHMWdXREhoTDZ2cFZHMWpZUnRDbU9qdzVGK0dkUE5HaDNrUThD?=
 =?utf-8?B?N1FRYUNyMm94ZnJXbnNiTEZYd3BSYURFNWVnUGhqWitKUHR4eVlxM09Zemdo?=
 =?utf-8?B?Ui95OVNRNFpkeE1YUUtsaHgxVTFrSVpna1E0WndRSlhDWUIzRmJ6cEVLdndu?=
 =?utf-8?B?dnNkRER4c3lOVWpNaGhnRkR2ZVRhUG1xQ2pUejNwNHVqZDZjTnpoNjFmYzhH?=
 =?utf-8?B?SlIraUZHT3hjRHg5WmJZK1grYmFVRXRJWmJERncyUkNtV20vYmtvUDZQL1Ba?=
 =?utf-8?B?NU5JblQ2MEtTcENERGhvOEsvSmJYL3JJdXlZak85c2lFc0VwaW5vblRtOFJ5?=
 =?utf-8?B?S2p0MEVnNWx6cEEwYmV0bnh0QnV5OFY1Zkgwb3RBMW80ZXhyNFBWcW9RdzFC?=
 =?utf-8?B?YXVPalMvS25kYUlkLzN0bU1ZNHppRmFUdWRNTmN4ck9zbDV2T21WQVBGOWhE?=
 =?utf-8?Q?gsQmcOinlW7ZKWjo=3D?=
X-Exchange-RoutingPolicyChecked: MUsk/MPrSuEnh89xAmmiTjZSog/42kFQjqX5sdqQAymPmwSJMluRHKw/oO2y3qm/CgyI6uyoDMGFLvuDfXS0fAIv+opYyfCFU39vuJxXCTeMlqfeh7P+hQyeFJ39j2SQWAVEG5/8sv20lZ9cQtaC+asmIktv9VvE/4ZCxcDYi1s+CQes0L5ultsvbo8DvrX8Q7VYGZle6gLEIViD20Zw1AYW1vwGwhKLwUosWRHLUjA7cUHyBdY8PA7yxSpSYN4ej+S3cj/ffGkEkYuW/JNXq2aWnQDbE/XEDOHsIzks7EIWnX44Gwh1xmRuxMlqDPg51lGPcjVlRBjdMFE9Fz1bvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc5c0ad-6355-4447-a2ad-08dee6a14e97
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 20:56:01.9453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQ3oRRnwJpoMiR8CuubntD0aVOaOrANHvBUNP9De/RN8ecdJd7TCsrU0gGh9PP/15Arfdie6XTgONqPDuT23er2crLjYRArUUAacIBaMsuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6963
X-OriginatorOrg: intel.com

On 7/19/2026 11:11 PM, Binbin Wu wrote:
> On 7/9/2026 5:01 AM, Chang S. Bae wrote:
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Thanks!

> 
> One nit below.
> 
>> ---
>> Note: The feature first appeared in the September 2025 revision of the
>> document and was removed in the June 2026 revision.
> 
> IMHO, the note is informative.
> Is it better to move it to the body of the changelog?
Will do that.

Thanks,
Chang
