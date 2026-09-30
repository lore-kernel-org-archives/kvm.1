Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FC51E433;
	Wed, 30 Sep 2026 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804240; cv=fail; b=kSQ2GqBdIo2ukNZoMTdlJ87b+QnlaVqn7vKmwWXfm4x9g6TNMc8AvJGABkVGbcOVJQ/eLh3f1hkng+ofWMibZekF+3MrOKyeaOhMh0cyNQeqYrxDC/pFfYHOQ1LwM+nTuuLEYmFCoQ0qwwEKlNkG34TohoY5m5oULfKrQg9EELs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804240; c=relaxed/simple;
	bh=PHAivjfS7zjCjPgvYw7dxmwMyZJjn3G6gbn3rQE5AE4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tjfJxp7a1jAMBso+zeQ1znkAJcMhjVxVmwBnTJ3jDXPXUfVTXPS4pg1FErroFTBWJbdhQ5l/cPBJO1hxfrIv8SbxpGQ9Wz3ydtSdqixEsP9nxBWKy1p/kGRWaA3c1t0XRaDcOGyo7dCcqsZKzSNYaBohibt8tmqhUOpSARYbG1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjMShIX8; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjMShIX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804239; x=1822340239;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PHAivjfS7zjCjPgvYw7dxmwMyZJjn3G6gbn3rQE5AE4=;
  b=OjMShIX8cIxKwHOsC/qkp+QfzTMdcNPLVaJqQv3rjiWUO56E0JC3vXh6
   yZz/hx5NSwJzRRGJRBzxvJAf8NY+uYQ/LBJOHaff/ptMGaEkOwdkYT5GC
   kDd0K0eq1nfvlwcA51ebTDP9YvsmMjyHBiYGAhgEgvRXAziA68TkhJhVv
   az4RtP9lCfzs6DF0+gEF0HXt9qD0N1ZKsPvFeEZXGOwSfkPcpY3VEgZ7l
   f2EQYhYv9vNx0twNnTK3VlnRs4IhRiVHSpn9uzN7GJTGqemQZiu/E+ze/
   g8hxt/Nz8QSCSlmIchRE47EhLCxCgs74HtU4b7ddnfr1KvPn3y15L750g
   A==;
X-CSE-ConnectionGUID: 57XNU0mCTvWMQgEDvo9Lvw==
X-CSE-MsgGUID: voWT85GdTVCRbU2u1iLlxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90767986"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90767986"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:37:19 -0700
X-CSE-ConnectionGUID: QrBPR1WlRx+jyRnY2vjoSA==
X-CSE-MsgGUID: RrmUZILATkG8/AzusbVQvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="302064754"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:37:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 14:37:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 14:37:18 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 14:37:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0M5n/n2el0yfFz5fo/SX0eoFwpGgRZdqY+Yro+P1ZXPOicAJglgMKwIB/A1paKhrrPyY21ijLkMvHWi33HjVbn4mEhMLbGRKiAwoplTixhP+D9kTNLTRe3+khM0RFdkH8025qASzfrJPf3vLqJLkCaNcCPAdqXmrH5f63iY/uIaD+RB668JBo9rzKr1u+c+/JGhRLqTqplDUVmZ8QNULfX76hxZyddjbMQbpEXsMfWD3yakS5Q6dsu9PODvNQsKj3pJek6lCRjx89zQwpWFd5wtCKnE8KzirgI+owfzafbIf8XOg6ZPYUj/8o8syfH8C5PnSPZS+Aze3rupZ97X0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9kg3tGfkVCE+pHtD0hF21tpLicG+AFkFJQaTX8OqfQ=;
 b=by5+608w4fVTbjdUVuGgdsy4lzv5jXKUYhkYm+Tyw3EKc/UMfODW4BpmBAK0nCEi0oNNVqJOZaME/3rSyqc1TBPfPuJoKnOkUVJNkHT+HJY48N6teaVBwZLh9fKnrTCcZ+BDiT40lUHL0ffnHWVLg5g0GQSKgS7iSulkduSJRB4G2j5v0fzXcdSqUYqBft1peqgjPrGqCXKMMZevQ/SKXwVBvMWpTHGr9PvfOrAqzuHnUaj0mV2fc1BqUHmhHMDbWI6ZeXK+zGzR0MONLf53Pyt2CMJpcybaBfBMUzyaA220+tGtoPydNON/XVL3blzAyBFzQ88A73LdgyN8Xj19xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SA2PR11MB4985.namprd11.prod.outlook.com (2603:10b6:806:111::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Wed, 30 Sep 2026 21:37:16 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 21:37:16 +0000
Message-ID: <47f5e946-4487-46dd-b144-cb2f026bed0d@intel.com>
Date: Wed, 30 Sep 2026 14:37:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/20] KVM: x86: Enable APX for guests
To: Zhao Liu <zhao1.liu@intel.com>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
 <arOyMJmOZVRp7Byr@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <arOyMJmOZVRp7Byr@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::21) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SA2PR11MB4985:EE_
X-MS-Office365-Filtering-Correlation-Id: bce31bdc-4dff-4545-2b7d-08df1f3afee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fIyPQ4Qf7ctxUPDT/7V3YwixnDHM/9/m5xaZBWfLaHe/umsBx1kUSHAZ2F4V6fH99liGxehS7JshcZhgHGAwaDf1iLR4breXUEvQf0qM6qh3juXFrl3LrN4h8LFQBSso672YBs4Bhzetln2eHhFM1Hjubefu2IQK7bYqFnHh7hqQXsmADQlw3QsqHGtHLlgIIWrBx+OumVLvIFHRxmD3548v0VhXYj1GzGmW379oCjbr65FQ9V4CZJHKec9x+l8FC8pZl/sq8DvqFFnoT1nVwVTJ3xFWnocyFFJ31E5KC/ihvnu+VSGy+vG8wa+nv4jocM30cexvVmhIGRSm1G7kUSuH/GguMBbapWwyZignzLNIWmVtdIBXiqCQ9nRevu4LZxcpu3q9sHNhQX06fWm+EbTdED8Q9M3z7VmddvQCCmeTKGLeoTSO0QiMxdfRlgJOl6WqEI9lKCTHOpAk6gqKmF4oyWrOyHR3e25Xq0WdhieJxnH3ia/hT0TmIxTsFJzXZG1VnlVSOvIhap2YBMCQXQt+zfrUY4dy2BIpWCcBkVstrNHxWo1lMArSTG76ZA7UMQJR4DZRz8TPrZKmbiWSm9o4c+kc37x9sJ2/ATfNg8OGkoxYeUH1VKPUwsbQnklKpSDGKR7wczYN6JQPKa+6rrWfB8/s1xItIEETwDJu57U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUxVSElaZ2dPaXc1Q2IxaG56Wk5lbWRnaEVaQkFIeEFwTzlpKzZZTVdpNWxQ?=
 =?utf-8?B?Um5LbGkxalNmc0R2VGVlcDVyaFdaWTBkOHJ4ZGZtWVB4WWFFay9jMmtHUWFj?=
 =?utf-8?B?akZFejA3R1pDTEdURzNXKzhjRFZYODh2TjczdzYyMjJqeUJwbmJuaWkvNVZF?=
 =?utf-8?B?T3o0YWd5SzVaY29VazQ5OGZoWTBGZk5GNzkreUZqeUY5Vm5GZHFxUjVRYUtM?=
 =?utf-8?B?MUtDb0NQYllaN3Y3WmNJMGtkdm16VGw2aEZBUHNvWklGdjB4STllLzNIMDE4?=
 =?utf-8?B?bTNKVEp2aEJ6N3MrR0xXNEhvM2ZZcmt4VG9NOEMwWWNWV2t2TFNDbkd4dGNa?=
 =?utf-8?B?elJvbHdNVysrcTF3YkNVdFZxYkh1TjNZVllRS3dxSTk1VUd4c3RmL1l2djkw?=
 =?utf-8?B?Umx0Ymd0N1JIUXFaRjRyUHBNM0xxa01NZjZScVZSTWlxVmZQQnZkQUw1R2Qw?=
 =?utf-8?B?aytLM3RZOFhzOFlialAzTXM0U0tUNHVlbU16NUJ6YVNJa1hJbHFMdlRqakRW?=
 =?utf-8?B?Z2wyVzZmb3M2S05oRnp5d2wwMzJieFpGbjAzS1NSbHB0NTl6ckQ5WXRMRUdw?=
 =?utf-8?B?TThKcEp1ejI3aUxSSk1GZFlUME5pdHcrSW0wcnpuNVdWN0lheWphMm9XdytF?=
 =?utf-8?B?d3VQSDJKaWZ5REdjRUc3QU5iczA3STFmU0t6Tlp2TmZoWHpLU2J2bDBIaGoz?=
 =?utf-8?B?MExhM3JRNU5lVzhleXVVWDBZM0VzNkpydUFxUHBRMUV3NDhBSVhpYjhuMHNx?=
 =?utf-8?B?Y1NCV29QSUpXVkZkOVdNaERxV1Fub1NOY3VLVHNlanV2UmVhU2hhYjFjYTNj?=
 =?utf-8?B?MFVyd0RJQTYxRlpTRjJrV0FZYVdhS1I1UENUVkVnZjN6V1U0VFdxV3c4SFFX?=
 =?utf-8?B?OVJMY1k2dVI1VEY2Y2c2YmlVa2IvTTFmRFBsdFlZelZDUEptT2Vkb29VL3FX?=
 =?utf-8?B?cHdEZmFhQXJlMVFQUFNQNVF3QnNtcHVESUc3R3RlUXRSMEhnbVgzZm5zTGxY?=
 =?utf-8?B?SjBOdHhFSVplbWF2TFhPcVVNaVlURW9VZXk2emVLTDF6dWdVTDF4Y3ZYZkN3?=
 =?utf-8?B?eGNpL2FtejdlMldwYzRzd2hMSy92Ukg1SzI3bHpFTllZWFVlNWpWQUM0TDV6?=
 =?utf-8?B?ZWdiMmlOSS9oYkZ6Y2xCamwxN0lkZ2JxOWo0Z2wwYkRBdlhZRTJCOW12MVBx?=
 =?utf-8?B?bVFqcGViOW1aU3R2bEN5cDRKa0t0S1BJNlV0RTZiVytJN3dlZ1ZCWDNYMU5h?=
 =?utf-8?B?S1hDRU9MVzVmbzQvaTNhKytGbkg1c2F1RnJmL0k4OHordHhLYUpPdCtmcEJ0?=
 =?utf-8?B?VG9hcGxpN0RyclQ0UUx4MEVtcnJ6NExKL1g3SDMxcThIUjFWcFpQTW1vR1Qr?=
 =?utf-8?B?ajRRTWthMEJUaDJsY09mK2VWZGdjdTJTSDdSRk5SMlBRcjE3dkpKWEtOSVJQ?=
 =?utf-8?B?d0pBcDhGWnIxVTFMZHVSckVJZTE4NXNITk5GbUdIbkRsd2d6MzNuMDdyWjMy?=
 =?utf-8?B?R3ZlaUJYd01vaTNtb09xb2RrVzVCUDBkZjlieC8vRGFKa2dDMUhIOTEzM2tl?=
 =?utf-8?B?L3pBYUppczNHazQzZEtjK0pHZSticUZUdTBSVU1IRndrQk9vWHo3cmM2QXVk?=
 =?utf-8?B?T3lRaWNKdzhIdUs3VENKYmNJMXEvMllWbkh3dlFoeEV6RUhFOVFzUkNmYysw?=
 =?utf-8?B?WlJhSVVGalU5Z2hOZWJZODVFMGVrNno1T0pGQTRONDBuZm9adHlvOEJaaHF4?=
 =?utf-8?B?Z3pYZ2NnMGVhQmRvejhxd2ZqWXo4ZDJRSmdKU1h6S05NSWZtZXZjRnFjNXZ4?=
 =?utf-8?B?eVNuUHAxeGNPNXowbDNCTXJzVEpEemJ3VEowbS9TYi9TWEdRaC95YndiMXhJ?=
 =?utf-8?B?RGpwWUF0MHdwTXFGbm01bGNOTkU2RUFzT2l0dllteVZlNEdYTERLcXlQdWND?=
 =?utf-8?B?SEgxcmNyVG50QlQ3MlVKMFNqc3NJYXUxUFJJNWpBMU1JS3IxbXptT0oxSS8x?=
 =?utf-8?B?bjFweEJKRTFyd0UvQUhZSGF5Vnk0YmlueFNKVFFqamJ6ZVFwSFVOWFFIbzFM?=
 =?utf-8?B?SjJIUnVKdUVBYm96K3VyMStSM2NOampoUjR4UmhzWUt2N2syNW5aeCtYWU5i?=
 =?utf-8?B?RWFrRHQrWUhpK0cwaFNvTVBxaFExMEwvZXUyMFh5SUFaVFp2am83Yk1UNkh5?=
 =?utf-8?B?MmxXUHJEbDNQT0VCZ0Vpd2c5Ty9jWk9FOGhITHdSS3hDTVFkd1ZEV3l3R2cr?=
 =?utf-8?B?NHJTU2w2c0tUeWUrMkkzK21FT1JReTZuVWZTYjNHRUlidVIvUy85bnVTMzhP?=
 =?utf-8?B?TGw0TEpEM242SVczNzhlc052R3VCUlpUOE53cTV0RDVVenh6MUpGZz09?=
X-Exchange-RoutingPolicyChecked: EGucLhvEabJLkC96nzSB7jUsCEElzxPm61zi9n2N6FKYamTCBdmZKtHID/peTBP9i8RV5jQ5cDmrtsaNgFxd4iBSlteXX7z2LcOhy422AOKexTcZgItFx/MA7VwqD64Aaqq6ylYUPvwDJytz5tzs/N3oaSj3t6tCU5cct6mGd2IuVZvqlSHzZTz2Dje+G8ShqkPppZDXlXaeui+PAEvMaxNhJq5M+9zjMNf6Iqz+lmUCKgJDFoiLxXGu/n91FsfWN8+FvD3wxlMLgfkfUZQmsf3ct/Z8XCm29gqY4DkFYGU9gU5iFJb4EGd3sAWWJqaq/NDiZ2rtBC8xOEJaRWU9Ow==
X-MS-Exchange-CrossTenant-Network-Message-Id: bce31bdc-4dff-4545-2b7d-08df1f3afee9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 21:37:16.1905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uY2MRy89KgKYyRAiqiNg/pC4pKHcR4wyhDytP1vBpB3+DIMR/5lkrKC+cyMctpmuOmC1Eg/KEp5YDHHC3AtolRSK3FziPctUgfdm4XSjn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4985
X-OriginatorOrg: intel.com

On 9/23/2026 4:04 AM, Zhao Liu wrote:
> 
> All tests are passed at my side, so,
> 
> Tested-by: Zhao Liu <zhao1.liu@intel.com>

Thanks, Zhao!
