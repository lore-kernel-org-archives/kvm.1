Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6293DB63B;
	Fri, 13 Mar 2026 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425125; cv=fail; b=RswK4wM2Rhk0dImNGQfvux9n3NsBIyYxYLKkIDybsildLsEfB9LHJpbi9KVLEl6DySI8xib2hkBbLM3QSEf1Y6P41cOLvFFX74Gkew8jO9NOK5NncAhm79WZo0Wlc6q+itCubE02HxKsPTjR6xrclzKYuCI2RHCoxsUsWMuTboU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425125; c=relaxed/simple;
	bh=i1UfdY6hF3YbFgQp01bi6Z/yIkxXxyDOeeoFmM6czcs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M6wRLQ0lnBSOIBaOBy8SUqJ2KlPVBNpMMI1vVYZ2sCuSJVTHlKIW7/ezyWHIMShHUuBzPh6O3O39b9vVd2yV6pGt8SoUjM4w03wl+YpAI1Mpz/o+5Wngcd/q/59xbEF1WaG+PZMXq/l6ef4LledUW8spT/xv4vU8C7jVWXiC3xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJ7kKaA7; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJ7kKaA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773425120; x=1804961120;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i1UfdY6hF3YbFgQp01bi6Z/yIkxXxyDOeeoFmM6czcs=;
  b=VJ7kKaA7+0k8GNBLeKl5FTDkL2zJRCS8BdnIhdLNdrNjQS7zfm+gw0jX
   xPNiKCiKMsKVTdLjyoAfVnkiPt20oxnzH3vkJQM99yrPdi1pep8UVCXNu
   Gf5XXo8v6h3i8uHqR7y6fV5RFbJjkQ50HPUSLSjKocqRgI/ZM44A03TbJ
   YQni/aHWBWEGSI4+6FY0XZmPvvAxuastki0xeqtUtMpQVmfxw9TOubveb
   +C5bOsNAIg+BiPyXt6fuJ1TPJOznOjCYCmZafymvBudgKhJHo0qcZ06Vp
   nLMp4oSI+/9iTw+xemdx82N9eB6bJCfzp0UInzNKigVdmz8O4YxpayYkc
   Q==;
X-CSE-ConnectionGUID: 22U+0gx7Q0WIsspaMpxieA==
X-CSE-MsgGUID: AJ3Q9ItDSKydRQAHJ7c6vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="92110582"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="92110582"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:05:19 -0700
X-CSE-ConnectionGUID: t+4N5amvQHqco3J1mJSxtg==
X-CSE-MsgGUID: JvPVkp3vSUqaejv5N5wYkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="218560529"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:05:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 11:05:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 11:05:17 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.52)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 11:05:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiwzIxhgevw8wYmyisY2ZWH/Vdh6eaykzdO+Qj/ki9olI3KgsseP9o6aUoysVx+PgDAkcHBCBEx4USPNZmKrP91fnoIK6go7foykVQDfNwaJrpF+eXXe/TRwIYRwHF4Gk18yrx5vTwdILKMkSq/oplTsPvCjQ6USbUBVES14CsYqOupAwJUT5O8OSUqErQ0QONIaeJHvDONeWdfNvWe3KSFhQHhfhAELMhEK/XLjDc3UF5TnxFZ4KG1+jNAqP/kk4pYzvjO37Q214dBgvCrpJPQ3xTEA08SkVr2Dmj+riOS8KlVlPrkCJWCeBvkvtNRlzRDTYTQzg1fwj5FHR34JFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/M+wL1TRAuPF3to1/D6+8I1bbUrRp9DOPGGAyPMMHI=;
 b=e8QijHi4nBrpqfvy4M1HcR7hdwgJNMhLEYKNHkUfSmzku1UfpW5TYFxk4QvlwyPkeFBnzXti9QqwmPsF1wRthe7wPOWyhs/EbZ/7pSs/k4oSdw+wN4riR8btIeYgG3pBR1ZZGHBK2F+ykj0y1Qp1VyVWpudyzsoauYfSoROp1txlK03kjg3wo20Be7UlJSv6Mu+97kiUYjXfvQydum5QSD5JJpGA7RzFbjb8VKP9DnmIxgK9H1BXwOiVFmMbbmSrrIihqLowryLKHzJvHQMbhHDLda4pdRdXUINWHnbH4jMjd+zYNr1AFcZGAsLFb5Wxpj5ySAqHwqJM+IOtb7nSBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SJ0PR11MB5917.namprd11.prod.outlook.com (2603:10b6:a03:42b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 18:05:12 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 18:05:12 +0000
Message-ID: <dc1c5944-934d-4203-8c9c-59db802e39fa@intel.com>
Date: Fri, 13 Mar 2026 11:05:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
Content-Language: en-US
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
 <13f67190-b51c-4719-a409-13d813549d7c@intel.com>
 <1439b4f4-ff0c-4b6a-ac86-5c0da2d26cf5@amd.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <1439b4f4-ff0c-4b6a-ac86-5c0da2d26cf5@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0057.prod.exchangelabs.com (2603:10b6:a03:94::34)
 To DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SJ0PR11MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a3f109-2864-42e8-8a05-08de812b126f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: QCh2wlemcJ9cQevfPwJsGj2x5MlvCzMEoEM3I3jBNmwPQFGPeXQaU7Wx/YINRJxFbMP5r1YsezW3KS1vZCFq/6AsewMsrOMJQZi9ByW+imHjO+jhCZvrtmoRwbrpsS2vR56Fozrv7bXqznEAK3E+sKxwmjidgRxpi6g+W0hI+vj14mQFy4xjiTWIjOWO0aTizCs5RsuUD1xSo+jQ+KofA95AJxCXGVdf5dQaprVZAdpsVpWo40ayHdzwMrs0CSOr+02nilL/YBOr90BaH7w2bCqb8y9tV30cxXvxstAQNtRQVIZHW+EZpPHZE0tdn4Kq9xuYDIcv2kWxVaNrjifZtpgzjE0VkS33IyHI41S+0vFZZME5H7npaXrYCYRjkxmlU4ldP4kHY53H1B1ghpy6BE0yFfn9UVRQbi6kiWuiNsmKb1wKE0TSOIDuqeeZnFOs/PgeZRb4MXqqLJgg5Gd/xww3YIX8MZLoKbl54hUOXcb5Rg0dzXKAoZA/tcAQkgz/JRqVX23qsoi8DSNHezpeVaC6cZwPkXYsh5v66v95mTnJq54WW7sjPxhyPCHIMnPNYrXISRq3eJP5Cgf+bEVXlWXx1UKYfOVBt3AzW9/W24JTRfnknd/vbA2rBpr8QdD1mdPM48PJL3VfH6mpo22JqH154kvJn6hWRDTV5L6nvIxm6TF/KV7ycTBnSHQcciHyTFMA8QHl4iPTBfsUDGyC+V0GKzATIdmTWrcdAQTpBs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ny9XLzhmM0ZVRVZ3blBoanBsTVJIeENTY21US1R0eFg4ZkxoUmwyUGY5TE9x?=
 =?utf-8?B?enJYK24ycDZITEs5S2xCU2hFQlFYUVJvQ09vakszN1pSQjMvMzRIM0JaejVo?=
 =?utf-8?B?K0kxZGhEUXFCdG5iY1lNNlcydVBkSGlPVThYcVpmYXVmRldiVzdkSVJTZG9p?=
 =?utf-8?B?by9haktFallkUWtFWERpcCtDSzcvZVlOZmw1MWhlYVJBRW1nYW9VS1p4eGhN?=
 =?utf-8?B?SDVKcEVYN09oQUx3Q0RFOFZsVk9lQm5Nb1BhSjh6Rm9QcjhaekhzUHdzSkVK?=
 =?utf-8?B?akJVZTZSMXZmM01DWXIycU9xQ3FYT2c2Uk5teWpwSHJwa3MwTHNhZ1Z2M2RO?=
 =?utf-8?B?NUdpZERabmhBbkJaL0I2ODdVc0wzc1RxT25tNUVwRHhBV0U4dkVjdkZuTk4x?=
 =?utf-8?B?dSt2NFNpdFBJcVJEZnhjeFM0eXJka2FudUtUcTdzWWNaUEVSeUp4SWh5NHo1?=
 =?utf-8?B?Y08wTjFaOS8xSzkwbGtKME9xRkhybm5Za3d1Tzh6VWErQW9IZlVrMlJHYkRs?=
 =?utf-8?B?THI0Uytlb0ZyVE1ySUFiOWZFQWNPRUJqYVNoWjFjMzRpdWhmeDcrMkdWRXJQ?=
 =?utf-8?B?S3J0REVsd1YzMHJNWVRUZHJJbnVHS3UrdENRUENxVVpNY3cvQ0VSS0pOenll?=
 =?utf-8?B?Tk83aE95Q1ZVQ21UbWwxRmg0R0dPajVGZzRKY1JZUU9rWVVWdkpGRWE3a2lY?=
 =?utf-8?B?SW00bDcrMjBkRzdnc3lkZHhEcVJDZUVDbnlYdTg5OEJ2UkpyTmF4N05JS2FF?=
 =?utf-8?B?NForODlNb1VKUmJHQ3FGbUMyOHR0NmpoNnhGK0VaTVk0ckFwWmRwWWpUS2RX?=
 =?utf-8?B?VmREUzliRDdVdGY0cHRGNERkNDBzeHc5QTBlUXJ6M0xWQjN1b0Y1bHBjNnJO?=
 =?utf-8?B?SFFSdFdHcTQ5WGdvNGYwby81am5XSUhqMWh1UDFybEFjZ2NCWUZSeDgwbFJY?=
 =?utf-8?B?Z3JkekdnKzEwNkpqSEJIQkluRUVUUmxuSzU3bHBxNEZxRUNaTE42SlgvN3RP?=
 =?utf-8?B?UUhwWTgrSTNQNTdQYWxWVDd1WWYxOUxGalcyWW9ZZmZRM0hxRzFZSSs3blVM?=
 =?utf-8?B?RUNsbStKNFFmbFRpa0hsS0wzRVlibVRld3QyS0RBWVpJanVDMlV5WkRFcXpJ?=
 =?utf-8?B?K0xuMHZmNkJlbjVXZlZHb2hFR3JWa2lkV3ZpcGl0K2xlMHE3TGJzY1BBZnRF?=
 =?utf-8?B?RTZnNGZrQm12UXB5L1VRK0ZiU0pkR1BXeGRVc2oxNG44ME1xOTBsdFZ3ck4z?=
 =?utf-8?B?TFIvM2MweW1teHhUS3d3dk1IMU4xaCt2aVlVR200RERRc3dhR0J5UW93dHpG?=
 =?utf-8?B?cjlGYWIyL0NxdmlYcG5mZk5HaUE4SW9Eb29vS08yRmQ1NHFPN0o0bStRR0NU?=
 =?utf-8?B?eEgzSWdyUTlNd0JpWnVnd3ptbjhaTm9OL3haaUpMaExnSWJqQ1RnM2pKMFk1?=
 =?utf-8?B?MUdlTjFhZkFFckwzaFVnWUdBRVkvMURqMFgzc3hhU2ZTWVB1WmhXcXJ4QlBR?=
 =?utf-8?B?VGY3TkMwSFFiVk44S245SXBGNTlJRWZUbVNNdndROFFvenBWczYvMkZKMFhW?=
 =?utf-8?B?Mkk3Z0pFZHFrcXpvWXZOTk9QOG93L3pMUVFMUmhsbENIU3MwaUM1WjlzbXE2?=
 =?utf-8?B?TFlWaFlsamRNTmV0TjdyVUJiSlFkd2NhSGVmSEhoOXRkSEhvTndVR2VjNTVE?=
 =?utf-8?B?TFRmQ1FDTXZYZ3laNnA0SXcrK054VjlkOFpGcjdpQ3FPemtSNFd4NVVENkhQ?=
 =?utf-8?B?YlNjVzNXeHdqcTh4WHV1Q0RFRmMyQlpnaWtyV1dwV2RrOTE3TUdNVEpGMEFI?=
 =?utf-8?B?Z0I4MkJUMk1wVmlKYWpYM3BwOGxRTy85SDh0OHdHam5zSUhqdDRWVzNLcCtE?=
 =?utf-8?B?MEZzNk8xdU1TUmtZTmFjekVTSXZxN3k2ZkpRbm5aV0tTMEg0TmtYUnYvNVVx?=
 =?utf-8?B?bXNrVXVxUFQ3T0lpTCsybUlLa0VrNXNWYm9aTlE0a2grK0NYU3BMT0VnYXc3?=
 =?utf-8?B?T0lBRkdyUXRNK0tLOGh5USt1YzJ5UWxxdGF3Z0JWZTVpZ29NdHQ0QXFpSjBS?=
 =?utf-8?B?dFRic21PUVhNNnJaeWJEVUFuS05uZUpBbFJZaDVkMUZ1RFpEOUxpdmxxblMw?=
 =?utf-8?B?MWdTdUUrcU9CSmZMS2diSysvN0I2V0N1d1ZxUm13eXlyb1NTMVdmNW9adVRR?=
 =?utf-8?B?WVdQYnAxcnoyei9TeXpzbUgvWGpWcUZYUStQOGdxcFBza1BBTWVUa2t3NDU3?=
 =?utf-8?B?NXc5TjZuMTFOUTVqeGgzSVJRVlc4RjNYQk5ZWE5VOEswYlc0dS9xOHY1bTBN?=
 =?utf-8?B?KzZGOUNCZUNoV0FqOUhKRjk5NGNMWThzZmZEaTAyVWZiTy94VnhnZz09?=
X-Exchange-RoutingPolicyChecked: e4wygYXQmDzXeXqMQ0OZzR68u+posUy/70UepVAclxiMPqgk1KaYeJBv49oYeSbopms6ZrnYIgAnK/F36nfW6RmM70Aqilw+g9Ii1lQ37623Rwrq2FuVqnMXMeQAiMrKVoA4OL1rqYAkKjF1eWqpQO1/R37enWLNYWy1lQ3cNcIF7P/jPQ8LXiALkfWogZ8mznePBJWoY8sq87oKsHIJUyzjBlXgwoQlWo+42FkLpmezHMzzQ+xWrTEy7bBkbpag7bwzgEkJiadN1NGWpcOeSlB0NySxGJZtf/gnuWD9csHaFJGFMdpBOZT6Wk2Deaka5Ta0MnZe+daD+YIOfnuOVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a3f109-2864-42e8-8a05-08de812b126f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 18:05:12.7289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdFNyitsjlP8LnrlZMkDZekrgVsDDp3n6ic5K/mOuHQCGvqb41pBlqS/0JStRJDNDzFq9FGruFE/YMws+Gkeyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5917
X-OriginatorOrg: intel.com

On 3/13/2026 1:35 AM, Nikunj A. Dadhania wrote:
> @@ -2413,6 +2407,16 @@ void cpu_init_exception_handling(bool boot_cpu)
>  	/* GHCB needs to be setup to handle #VC. */
>  	setup_ghcb();
>  
> +	/*
> +	 * CPUs that support FSGSBASE may use RDGSBASE/WRGSBASE in
> +	 * paranoid_entry(). Enable the feature before any exceptions
> +	 * occur.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_FSGSBASE)) {
> +		cr4_set_bits(X86_CR4_FSGSBASE);
> +		elf_hwcap2 |= HWCAP2_FSGSBASE;
> +	}
> +

There is already a lot happening in this function. If we end up going
this route, I would suggest moving this to a small wrapper function such
as setup_fsgsbase() or enable_fsgsbase().

cpu_init_exception_handling() doesn't seem to be in a hot-path and
cpu_feature_enabled(X86_FEATURE_FSGSBASE) is generally expected to be
true on modern CPUs.


>  	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
>  		/* The boot CPU has enabled FRED during early boot */
>  		if (!boot_cpu)
> 
> Regards,
> Nikunj
> 
> 

