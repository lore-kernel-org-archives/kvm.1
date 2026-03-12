Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB224390C99;
	Thu, 12 Mar 2026 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339004; cv=fail; b=VHjnZOscACG244K7JCqub33aoBaQB/PJyJhxgMkmO1z+5DL5M+AC/fwgWnLcmC+DytmMLHEFmDfAF3Md39VsUE7xTaFVTN1u8aLCzBdfxxIzf3FaSOMUul0gpSLVxOTt5tzO3UdkTh6knJqfnOZDNq6kKb0Y8A+yG7LAwBsyhwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339004; c=relaxed/simple;
	bh=FVS+hi1m0Q9dUDtJzkMI3XxQtWyjFzJOiNHokAWsg7Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I/dIBTBm2vkVM3Jcjp+bM1w6q++3RYtI4ErrkY/pIH341Sr9nQVZVQGZAYbIca54olGOKlQH/X9kQcPsj9yxO9jSPy81J5Me35O4UUAMbyJjg4gz5QouQoaC7KUB5Pq0KuVoqJH/3fAZvMTFtkSdAv6uhO5h8MoKv4M1FldN9/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjAEOAxr; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjAEOAxr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773338999; x=1804874999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FVS+hi1m0Q9dUDtJzkMI3XxQtWyjFzJOiNHokAWsg7Y=;
  b=HjAEOAxr0f9aw/DCSlk/lKf1qiSq+aZO/asvFoCxf/6G8Qt3hMwxee7w
   7YfvY54S7dq74k6V58lszcU6BCjhj7VC7oKOU4v1udr0IOl2suc7AcVzt
   PMzsfqevvjPUoa7XX8q23hgHb9P4rXzXG3OJIHaO3GU9Mi7j8zG5CRXrw
   kFFI8AYY5P67XEMgeSw3sl17vDkRKIvilg5EyEXdOPEAAjB1nSW5awN2o
   eQ3ekc2OKQ4bbwtjRplV2SJtk0RruH6edlj0/duXfm6dlefVDvwDNznbj
   2gljSz0E2fkjIUuWInzE2C25FjWw5FRp3z0hp/1ez4b8cutwf8PKJPvZp
   Q==;
X-CSE-ConnectionGUID: xT56IsZGQz26H8sjKxrONQ==
X-CSE-MsgGUID: FCBhNfFcS5GGJfFeHdcTaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="99903571"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="99903571"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 11:09:58 -0700
X-CSE-ConnectionGUID: k2O+U1qoRjGZvMOusoGyeA==
X-CSE-MsgGUID: iepl5G1ETEG+Eb9alCj0Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="218692059"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 11:09:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 11:09:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 11:09:57 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 11:09:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9HmshUx0r2UZ1UQpenv0bJ++3BpD3/ulvnnglp58hdbsFF0Y9Z5SXTSQ7qClteB/xbxaHN9SHlB0+fkujsDv7GdH6Zbsz/e/XnCtwxq52ZkslhPgYQjQGxJwrs4syXFJODvoe7R7pCVt/4UChrloCVRo9aRnFDhbeBqNcZirBAnAeGsCAMyIgpipmBVNbhJVWD4MlfnrEDPF5FcoYqvytNT/e6v9XGXwQpqqfnRBwM6KUiOesfNh9AW1ATHtXy2tSwcW2Mem1QtqY162DMLXd4mVJtTv9RQEuN9VtILK56ggyXNxWXi/MjFJ/uS4+dHTkHYZy4ias2jQiBIxuCe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKFJr/fmX9etlsvwXTM+1s08iTuBjN0Tyad4fBEm4N0=;
 b=kEfMImQtnO0jNyv7io8GYng0a1YRZ6Kdg8zeBbz8+PDzbCq77V7TRRSIsioVyjPLI6sOLvrSuYsqzw4MHwyfYt9JdBDyKLj5zDshgOWilXI/QQQWVlzX8INHsVJVkrb24msFc79xDPPjAGZPv7kM+29lJdT5uOhk+L4PtxCafbL2H/2fxAM8WGrM9O26jcSNk18PrJhT89f0g8R9tkhkElrxBj+j7KgEHFidPoxdQdSfVcHBgjY8+nfN3vyVITqs7VWY1Y6UEdSt6FYT+6QF5L92S2ZbOCuWQxwlRNmSj9o8+ieI6nfS1LqCMgAE4Hp1R8feoRWPliw/nFVG2qa7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DM4PR11MB6503.namprd11.prod.outlook.com (2603:10b6:8:8c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.6; Thu, 12 Mar 2026 18:09:53 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 18:09:53 +0000
Message-ID: <13f67190-b51c-4719-a409-13d813549d7c@intel.com>
Date: Thu, 12 Mar 2026 11:09:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
To: "Nikunj A. Dadhania" <nikunj@amd.com>, Dave Hansen
	<dave.hansen@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Borislav
 Petkov" <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<xin@zytor.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<x86@kernel.org>, <jon.grimm@amd.com>
References: <20260226092349.803491-1-nikunj@amd.com>
 <20260226092349.803491-2-nikunj@amd.com>
 <20260309134640.GOaa7PQJli_C9QATGB@fat_crate.local>
 <cde957ba-3579-4063-9d17-3630e79ea388@intel.com>
 <20260309161516.GAaa7yFMulhdzNQ-pt@fat_crate.local>
 <70644e1d-dd0e-4f0f-81c0-fd095e46e50b@intel.com>
 <7ca205d6-b01b-4ed3-959d-db31a6496d79@amd.com>
 <505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
 <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
 <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
 <cb492a37-3517-4738-b435-73311402e820@intel.com>
 <ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:a03:255::34) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DM4PR11MB6503:EE_
X-MS-Office365-Filtering-Correlation-Id: 158c17f9-f10b-4d37-d48d-08de80628f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Br/XepZrjJ+2LTVQhILd9mzPod8AB4oHhZzzAV3jZvu7V29pA/6po0UuAz0qcL+gSfIMt4CLwIFvqIkXUK6bwt63Wu+MTNxMU0SZ5qyRKCOcMncOJ8Bw77GEXy9ask49k+NMebPuJRvZaTLiVG09WZ4GMXmh6FpFZZlF6NX5BezGtjFPV8ACwGj3VxrkrBqhnvRdCqZW42alPTCgZL+nPhc3TC2j7UdBpCUPdleVFMoH1dthEvc413xzF95BFcySJzI+a/6csQLBwqT3LeADWl1Gg/cIeNvE9rf7lT82Tu20a6lYtFK1MCoKFwvQQ3bCDTP+6kAiHLNs1+9Ia+1wvjKaAnsq+L1lyIz7W7Uykn8yGOUKnlsKgpNgUhvUJZI4MRmj1Rk3Dq9SOHI6ic+TlRH6c5Jh4layDa2cQ8+ezAsl8NXR4SbgjZHQcJhjJTWrrweTWAgStX3HbNXKoIflbysNUjA5DSeDnaB5CWdP/+Ui6c+QATdY6RvJfFeesS8pKejpjpxDWShP/CMQuVD48Wgs5HQM4NdLIchUD+DvzzC2wNr7Wfkm7wWyutqgYW3H56MMNYHE6ahh28Q9cETEc6uvRk27rcl9BFNp47GpMlDiqlfcT/bvK9ibPjruJ+Tf+jfzPbmFY9nU2vXwBPDYb93coTPNtlkcVOWa8fTE8EDx8Ncuav360LZ1PYGTnRXDNJfdjorFL6seucSBFgg+HgYsNZpTfSBMInLgeQEtyf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk5wNjhjdHZGMG5MWENsRFVJZzZFaTRKa1E1K3J0WFhBNnFkSGMyWkhIdVdS?=
 =?utf-8?B?UXJ4Q1FRejJGTUZjQm1FeGVEVDNmUGVZQVhManVNMkNFUFVuOUs2ZzJUWW1M?=
 =?utf-8?B?S0kxYTNtRzJXWTFhMUFWUC9lakplT3Z0ZGNsVklMb1dSU0d4QUh6Sm5GYlJJ?=
 =?utf-8?B?Rmlhemxta0pRcjRvWU1USThUeWR6bnlDQXR6WVViMk10OHB5eHU1czBTYisr?=
 =?utf-8?B?eUs2Vk9oNWxyUjk2dm42aHdKLyszNWpoSGhMYkdiWWg1bWNTZ1M2d3JSRXFX?=
 =?utf-8?B?UDNtdWw4TzBXT2dNbXI1UWxJNFNrdzFwRVlxNi9BTHRqekZOdE80MllxM016?=
 =?utf-8?B?YzArdm1zU1dLTVBHNDJqbDdEYU5UN3czQTNFam9XbFQ4bWpvRmJoOUQyeGVy?=
 =?utf-8?B?RnpvRkV4Q2FGRGd4YVRudmNQb0JJTDA5TjRIWmFubmRPSVN5Rm0vOENBTFhH?=
 =?utf-8?B?WmV2SmFOdkRzMDVKV2RpY0ZMQ2xiYVZtQVhvb2o1L2IvR2h0WHdxYjhibU45?=
 =?utf-8?B?Y0RvdWQrSFQ4VlFQTU5oQndpdXBBckxLUjkwSnFFS2orYjRsNGptb0hFb1A4?=
 =?utf-8?B?MFpPOHJoeHpMUXA5dk5CalJTZytZUkF4VGJyMExtNEhpdGRla3ZQQ3dGNWRI?=
 =?utf-8?B?amYrSnQrMlFucVUwT3BjUllYTHJaajI0NGFtQkhBTUlsZFlrejRiMkx3czdx?=
 =?utf-8?B?enoxbGlBVHlmWmVXM0NQeHpPVjJQQ2NYUlNHSXlIUGovK3BDOExuYXE3RHZw?=
 =?utf-8?B?VGdYOG9hOXhLb1dHT3hBM2tYSGNBRGhheDBUNXlva0RpK0NTNWMrNTZlS01K?=
 =?utf-8?B?blZWM0lDd1ZYZlQrS1c1c2VCSDZET3JJaUNJOFNFbWRZb2gvK2FweWhVUzUy?=
 =?utf-8?B?SURaOVhPdW05RTdFMVZobEtJNUNJMFV1M28zS0syRkZsaXkwdDFTZUhiRHhL?=
 =?utf-8?B?ZE5mbGE4TGlTVlRGTDJkazZ5amc5K291M1Jtbjd3bGtjQU9saHFzU2ZmSmU2?=
 =?utf-8?B?a1V3MzFaRGlYdGZxU1h1QVFzTFBsZjdvM3c1NHdrZ2pJWXdYSVkvSjJiV2dr?=
 =?utf-8?B?cVNBQzJCOXdaK3FnM2VGR0pqN1k1bDU0Zkovclh5ajFMb0hIZUd5ekJ3ZTM2?=
 =?utf-8?B?MXl4MUNIWGRsbEljNTBsVVJOZXhwRlIrM0tua3c2eEZBeVBYN0t1TWZTcUJW?=
 =?utf-8?B?OW42RjFWa0hsUWJpRXVSUmNqSk90aHRtZWN4bGEyaTBtWkl5aC85b1o2L1Rl?=
 =?utf-8?B?TUgyMXpseXRnb3NheXlmZjhhR3FKdGRIUzVHV0FxRGk3ZU9tMjc1NmxFNkIw?=
 =?utf-8?B?Zm1mKzQwNTUyamVhMXRudWZOQTJzemd3WEVMN1NNbktnazFTQXFxKzVWTFRl?=
 =?utf-8?B?WkdvSVcwWTBmMXBGanY4SnFkSHFIa3ZCdDlYZWVLSUpIZXE5SUs5MTV2Rm81?=
 =?utf-8?B?L2paQmFPbDJKaTArWm9HeG0zRllPUGtyalQzQlEwbEZ0blk5STB3SG9FK0hS?=
 =?utf-8?B?YjA2S1BEWk5uNytIOGlrbUUxdWpZU3g1YldaN09LU3ZmR0ErdFAzTE53cVlx?=
 =?utf-8?B?c0N0T0hJb1I3YWhQcm9DZW55NllTT1hzVzI4NGVuUnZFeU9RbFFNUVV3RDRw?=
 =?utf-8?B?am4rQmhXT09oR0pGNmNQQ2MyQUE4Z2pqek42K2owVWFyMmRYbnRBZlFoUEJR?=
 =?utf-8?B?K21vcWxpQ3Izem5RRjB0NHNFSXFaKzJYb3JZVGc0aVlmWGQ1UXlvQlEwMlZR?=
 =?utf-8?B?TmhydFVpT3FxbTFkaEhlZU1WZmF6bThzOFZSSEpRVkdwWUk5UFIxMVZmMmJS?=
 =?utf-8?B?RXFPY3V6akN6WXg4K3BLaFVrNW9IZFlvWG53WWxQNm1pL29rUTdKcGpHU2VB?=
 =?utf-8?B?blovbThvZXh3YWVkRnpJY1ZzNDNrTC9DM1pSQXlzZFh3TDVMdjVCYjkrcjBK?=
 =?utf-8?B?dUJ2RG5YeEtPOGxvTGVsWGtXN2JuUVk4aUJkZ2xMNUJEZ3ZSeVl5M0FmdEdK?=
 =?utf-8?B?bWcxN3pnQ0NSVXM0TXdNemd1V3pzREl4UE9Vb0Y1ZmZCWHdtWkFnSU5Sdm1l?=
 =?utf-8?B?RnZ5REQzWlY2b2JGcDM2dy9NeTRFY04zZVArbGRDcFJRdnNCenRYTnpxdFMw?=
 =?utf-8?B?ZGpkb1RyYTZaWGUrNlZ1RmRpWnVKVGNEMDJ2NjR5ZmloYzZaTzRObVlCMDRo?=
 =?utf-8?B?RFduY3JoM2NCUFNBcW5xa05zc0tGcjFHR05MOEF4dmliL0xtYjNZU2s0aW56?=
 =?utf-8?B?SmZ6Snl6NDFWRkRodVk5bmc0Szg1eXRQdUVoYXk0dTlyU0FRWVU1NW5YUjZj?=
 =?utf-8?B?azlBdU1DOE8wc1JDQi9RdHNSU3I5UCtlMmZaaVl1ZDgxNzIxV2prUT09?=
X-Exchange-RoutingPolicyChecked: VnFrjegQYIc1aOYWTyZyg22NkS/eRzOymuvv75rpxbg3ZT99Ij2/9R4qstT4dYum0otVvDPHqhUG8qa7yCWrEWHpTs/5756dOQLMREbCUlqh5pB0koSIjk9NNPRCGRgSLj+S2XR7EeCH/ErMihssPHXBar1TJiA4PxNQAqIaQusInXuAo5zEfSvNDPCA/ub2EaKvAwdiVMy0DOTACXG3RFiHfE/FV+v+x+rIN7preGgSCwnmBEQxUi6Y8uykasUZ5vG6Y9T27+0DpRctsJrFaaW5p171vtg88HJ8u3HPuFvu5dO7pxsKxA2O4KL3iwo58yZqkXR2C/ugGxSSKgX2Yg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 158c17f9-f10b-4d37-d48d-08de80628f44
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 18:09:53.3611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uRu2JmWOWV69LTyk60lqw23uq6ksz9nStjM7sj8RIXuNEjj6Z7PIoQUSJ0BZJHCecVq/lSahVrLrafSuskpXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6503
X-OriginatorOrg: intel.com

On 3/12/2026 7:08 AM, Nikunj A. Dadhania wrote:

>   1) Universally set X86_CR4_FSGSBASE in cr4_init() and call cr4_init()
>      from trap_init() on the boot CPU


cr4_init() seems like the wrong place to do this. I don't think this a
primarily a CR4 issue. Deferring CR4 pinning maybe have uncovered the
FSGSBASE issue.

But, essentially the difference lies in when we enable exception
handling related features on the BSP vs APs. It involves setting a few
other things than CR4 programming.

See:

/*
 * Setup everything needed to handle exceptions from the IDT, including
the IST
 * exceptions which use paranoid_entry().
 */
void cpu_init_exception_handling(bool boot_cpu)

IIUC, anything that is needed to handle exceptions should be initialized
here. As FSGSBASE is used in the paranoid_entry() code, should its
enabling be moved to cpu_init_exception_handling()?

Note, we already have other things there for #VC handling:

	/* GHCB needs to be setup to handle #VC. */
	setup_ghcb();

>   2) Disable CR pinning during secondary CPU bringup
>   3) Add #VC handler for FRED and use boot_ghcb during early boot
> 


