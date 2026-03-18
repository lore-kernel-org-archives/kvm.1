Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0E3D88FD;
	Wed, 18 Mar 2026 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842095; cv=fail; b=mqk3MZmp+vCuq/xBO6AK/d2sIk+yts7Fem3D8gH2nbiIWxAHY90lTRHeYfnHmrCJcupuJUjygdNNUgQF/r/dkl5MZYvlnWdrkYJxVx7RzWQwbCyFpV2BDksCt3pbXtFhE/P9WYYhc3ULcoPo6BCBoZsyc/mQAYQxn8sK4zlsOPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842095; c=relaxed/simple;
	bh=MotjLGYLuxgG2IbY0dxLRnkHnOVhvXG0jgekKFN9QHM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EJyfBcYVPfDD9bD7nYOfFn6Vf0LfrcF+ETGvSvxqnfbbB1RZ09At+5jU1yrGGlhfc4Xuv7KlP/v/ulZmTaS8YjEVILnNEulig8AreaURJRhmQAPrDCXutSqFt0dw5rORi2ddFKajRW1GXGJHRXLiQ6Ak8wnVpJuaxMkD2/xgWB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N28xRQmq; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N28xRQmq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773842093; x=1805378093;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MotjLGYLuxgG2IbY0dxLRnkHnOVhvXG0jgekKFN9QHM=;
  b=N28xRQmqx+jBiwOFC9utFHdRq0CEQ8yXVM+fQzKUN7+S0SGNy11g4fC7
   VwnBr8cD/KHdPWqUR5xQT0g8GkXtRAyfJBq7OQtn+WXGA0q7DHIqnU474
   Ck9P6RZ1TgYx2woCocC6mnO7K2MbN7bAE+tyUMaViPmFE5bt0q2PA2vDZ
   i23ZZj//LWprkCk+GO20YXvtXrn9wie72nJgDQrOpYHtbTM+jg1tcPvTR
   S+RkNxNTHHMtDjDIC5RBaswZqI2aAHgJbyzwZQk+W/ginVYv3f7u2CYqa
   Oa1iSjCgnof+tLfQvaqySstNsOGMVGI8PHYTgWrVrL4mUn7PqpmzMcXsT
   w==;
X-CSE-ConnectionGUID: 8yhH1n+JT+SKbfSgpJX9TQ==
X-CSE-MsgGUID: 1N8EYsfqSAyJtQ71cs/g7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85591063"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85591063"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 06:54:52 -0700
X-CSE-ConnectionGUID: yJagJYpRQ/uklEEzquPM5A==
X-CSE-MsgGUID: 2ggJAaW6QL2H2/u+fFTv/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222602055"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 06:54:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 06:54:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 06:54:51 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 06:54:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sml89+/RJUHcGDbO9abM7FlaPAS2vEzMmSc8toCpXt2QmXxFa3msmX6Q/GZb0uubg2WAvcIJKmtYpCVcUdMUUk/i7hZlXA17lR2QwmOMCnQ5aUnwQIbZrPT2WriCsU+hERyqGAo1u6XvcLqBmDlHDl4hIr7v0jMWNe6JHGUh7Pm6UD+cM6jnQbu8x27s+OiJGPFYyR6s8FGP052xrJKiAUd3ikF/ZLhblDtHw7sIRSEjuKK1NnoXNvpRGQDlvkDnYOoIMjkErTXujsnxmskvQ9v7mtORlCKDobLs0+gJAdsxYBpn1/r5iC1xMEIOgvNH8AoGzoKGx+ThbtxfdEnqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7q+KqpXsNeXDYK/hcmfGogLiaXQaP7K9WKVySUqu7s=;
 b=dDUC2OupV0myoHiz2ZVoqW6fjKQSoxN5hoE8jobMrEBpsbQ6Qpc/1ypozyjAmKF0m/gHH1Z8N5y1AMpLNQDHKJiDornknBx60NRq3xpuRINDDTviFrxHR4BvxK7+V7AUp/GnvJyboWlc1sVQKcM6UlQbKmeUmL+zf1YyvC5TLNLHISNvTJw5bkjstKPlLFZg8yxuA1Q9P7eQ7Mrb9lqVSPnCufGPUlXVn3e4M3ffp3zru7tN/+mCgGpeKfF03paI9T1NG+MfVE46lUztfqgF8Duh3JZlR+Drcz1vdIOUvr15mFB97EmARc1M1ZdZks5yrNpKzvxuiZjN8WWBXVB+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 13:54:49 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.20.9723.014; Wed, 18 Mar 2026
 13:54:49 +0000
Message-ID: <d3140cf6-e61a-40a5-8153-300d5fe07954@intel.com>
Date: Wed, 18 Mar 2026 06:54:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] x86/cpu: Enable FSGSBASE early in
 cpu_init_exception_handling()
Content-Language: en-US
To: Nikunj A Dadhania <nikunj@amd.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <bp@alien8.de>, <thomas.lendacky@amd.com>,
	<dave.hansen@linux.intel.com>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <hpa@zytor.com>, <xin@zytor.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <x86@kernel.org>,
	<chang.seok.bae@intel.com>, <jon.grimm@amd.com>
References: <20260318075654.1792916-1-nikunj@amd.com>
 <20260318075654.1792916-2-nikunj@amd.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260318075654.1792916-2-nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::14) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|LV4PR11MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c50e22-32ab-41ff-91f7-08de84f5eba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BhxYrm4e7A+AVOR1i/dDazkXu2MdMWm7B2I8wGVNV+ER1SfeA3ydy8ndyEsLNBu1u0+l0FeqXNiyaz4olEIF3sdDxS5KUC2MRUHs059TFOxACg57QDV1y0q5/+fzaHrkVaHu3A/EAvg3yVe5atwtiQgK7NQu32BdTr270CqAK7CD6LxtXRaZUvwWRy1suslB12WtOyBnnS1utcD0o0A5z83COcQa9jjdxxuYnhiqEH3REpBlQllv8gH5+MkXHGPMKQQLHhFLmiGFOl9J7rJVFA8z0nCZhylcJhGmw01Qg227lnzYRGJHayrK/uz539LOZIXMEl6naLLLy0lpoyYiDvkuS/IHqu90b8L6rAFSHXkfmrX0MG6N3Dtvem+NmW3jsJ6XXynNX8PtOLfYJCyrK42Reb9s9ltLdrGrg+fVitK675L9EiNcUnGeWsZ1WXSi2xtTKp/lNUm2KTNMb+auJkAoe2krUiVoWNB91NGZT3LQFYfEATAJn7BIV5kiT0ufc6AivrCjEQCLbvu1AAdGSpX0a1W/QNhfrAGQPp+kxjCu5Pb3EY0IP/ieyTAjXjGbjyOrL5UEDOcTJTKByGTMgfiVh4frneRTkOsSwOMBqwuKwAg15cTxpidzh5l05VgMU3Nek7WqzviDviMOOwFIn8XnvxVwrBBI88f+JTV2iNuTpYPEKsr9P6I2CCOn555tRdpYu4ISLmqXoheiOE7c+15jByter58CO7k7tGS81BQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnVxRndkM25wdnRvMG5VekhhTEk5RlU4UTNGQjFCaWJCekdlTGZIa1FzbXY2?=
 =?utf-8?B?QTl4U2ZFdm9kdVV3eDQvUHNaN090dlVjWU01dFltQ0xqdHZveUFHd2s3bTdK?=
 =?utf-8?B?T2xTSVIzZTZnUWFqbmh1Uys5ZGRLSnlMdzdRUzdUSTk3bm5hSG16YWg0cmZZ?=
 =?utf-8?B?QnJwWnlWSjNEYkVodGhPZEFsWUZocjVVTjNWMlRnU2hMYnJEQlJyMXdaMG9v?=
 =?utf-8?B?R0FRc0tpRTdETGF6RmVuOXRXeTc1N1FNWGpyZ054aS9nUEo0cHlQUllneVpR?=
 =?utf-8?B?VTY4YWVuR3JNdENjMmgwODk2SFdLMllhZU5NLy90aDY2WW16Y09CcTBBNjBU?=
 =?utf-8?B?UEdxWERKY2lxakxvREh4cWlWME1sRjcwMEx6YjFoUXEwcVYwNU5RTU16d0Z3?=
 =?utf-8?B?V1BBSW4rdmI5Y3ppcVRvdlpWS2trTHJrZmxsUTZOd0E3cm0wVWtibllCVjZW?=
 =?utf-8?B?MU5lZE4reXpDekdYcGZQVEcwUFl4TXRRMkNzWHMyTnUxbHdWck9mTzB5dWlR?=
 =?utf-8?B?dUpPYW9LRjNPeEFBSXNGdVJHMTRPTnFYOTR4eE5RdnU0Z1JsV0EvWFNQbktM?=
 =?utf-8?B?NkpLNlZuaDJhMmVNWlY1dkRJSzhaRWgvd3dNRDFBMXFKcWRnTUxYK1d0OUdk?=
 =?utf-8?B?eFZuOHFHTUJOcS9GQ3A1Uk4zd3RPa090QlI5ZkZwWE9MeWh3MEJjWjlPUW00?=
 =?utf-8?B?TmpuMFJwRUxhNTBKMzFsU21BRnV3TklzOVBhNlRLOCtjM2hKM29NMDBTbUFD?=
 =?utf-8?B?eEVmQnhiTHY1OTgwSk5MMzV4NFB5ZmRCQlRqcGNCYng0NDhxQUwxaFZFdjRa?=
 =?utf-8?B?dC9zejFpOER3aFkveGt1YWJIS0pwSjdxTlhEUERtT1JaMGN0SkU1QkFSM1I5?=
 =?utf-8?B?UGlHamtKaE1QU2tDNmN6SW9pVVVTZlFtUnZLcXo5V2tqMjQrVStqTk9mTUZr?=
 =?utf-8?B?VHZNSzlMYmtlekhoL1YyVGkvRmo2SEFZSW1TY3dtbXhUWUI1dGNuNlRYQkZk?=
 =?utf-8?B?VThWV1JjZllua0NFRUgrY3hBeS9tc2NtSERENHVZMkRzbVMyRktMZUtXYjN4?=
 =?utf-8?B?L3RQTXo4a0txZFEvdzAvRktpVlBPT0hocHhOL29yVjdxZTNnK3oxQ1Q2c3dR?=
 =?utf-8?B?Z3JpM1MrZjUwZmdldVVRTStRQkFrcklndDJXTFFlRjluaWJ2eUxleHJ0bmpR?=
 =?utf-8?B?UGhpeURPQ0pjUklQVXdTVC9rNXpWTGxpdzZXSlBlYmxHYUFucEllc0UzNjBv?=
 =?utf-8?B?enBIaFNBZlhrMmlxRFZ1ZkNQdW9wT1c2Z2hXNkVwUTZPSHpQeGJyMDNidFNy?=
 =?utf-8?B?QnlFM1JsTDZETkZISnMxTmY5QWdOMTR2N0xFdGtIN1J3OXo5d0RpMElGU01N?=
 =?utf-8?B?OVJsVTl3UmtDUEZWdmROOGpvR2lvQWR3bFNQREF2L3hVLzRXcm5HT0ZjL2ps?=
 =?utf-8?B?YyswdjhiRGxRMXJoWDZYK1VXemhoN0k3SEh4Mm01MldmSTRTM1VTY1Q1Mkdq?=
 =?utf-8?B?V1ZKUldoeTRHK2E0RWZZY25xZklSa2hCNitrZW95Yno5Z2p3TVhoYkJaRndl?=
 =?utf-8?B?NDU2NENrbHhJQXRGeWFFV3R2SEZqRzJqVithT2ZiVzhkL0xzajYvZkxJRjBJ?=
 =?utf-8?B?Y0NRTHRJSTZkc1ZpRW10VTNGdTRzQWtOaUxDWHdES21PN2JYQUNnQmVQUFg3?=
 =?utf-8?B?Q3dwOWxVV0NhMUo2WVhvNTd2RXVuTUlxbkZ1Nm0wZ1VTT3RwRWIvWUFBcTZ6?=
 =?utf-8?B?YkdoUU5PQTdLQU1EWUVXYlR6aUJzdUU0UnpPOXBPaEc4RXFQRUxvWHljUXY0?=
 =?utf-8?B?OTRkWkNMbDdHTzJnaHE5T3BHdkxiY200L0hJdlFmeVQrZ1RqV210dG9BMnV0?=
 =?utf-8?B?aVdjVExrUkJ1eU5YaU5Ic1pzOUU0TVJjektJYVZPOG5oMHdwNE9TMFFFdC9t?=
 =?utf-8?B?d2JEK1ozVUFaQlUybXhtT2dleHc2TVlWN2locDNuQnRTOXpMeE4zZFFOV3lW?=
 =?utf-8?B?ekNZMGFBQi9DRHY0WHZBa2xEYVA0Q2RZZ1d4MXRlNlV3aHViRnFBYXVXdWxh?=
 =?utf-8?B?Y1pPcFZaK2w0YTlXSDV2VWRES2NRWWNIVU5Fb1JkRG5pMzFrV3ZNN3Z4cGlG?=
 =?utf-8?B?ck1haEhKSDRiWlVOSkxkSElDTlFUSUlMd0Z6QjNROUNnb3ZVMXJqeFgxU2Q5?=
 =?utf-8?B?QXY2YkFFQUxjcHB2MTNPcGJvMGV6NEcwTG1jYy9rYUNjVHpkNEZWZVhOa1lw?=
 =?utf-8?B?eXN2cnN3cm4vY1VhY0orbUJBa3dUSFFpaklJOXc0QlNkK3lZdi9sNDZWNFlT?=
 =?utf-8?B?NmJVS1h1dEUrQ0NTaEZZenB2ME9SMEJnK0RvNHl1VGRlU0txU2R1dz09?=
X-Exchange-RoutingPolicyChecked: SumwU/yN9qohcPXjxP6HsmVtHXr4r5y5JJp6Z5MEt/UQ1lp+RjHxj6z39vLkNzz8nYMp1kFGKo8To+Tm/eNETFlMAqFrzwuofS/DqZLq7MpVUD/9YoC8l6ztwEgWJLUxOmJmrtlKXFQjwdprIRYnTi7JU43FXSc+8nBmE6BEVyuHq6YnNLDQrCpLWLjE8BvBuljGVB+ZN9NFtLWBGhiBfSvC8sbmXCJvUKD02LDjOYRlVUoQmttCHGB1wdkkW0zTPMJTuteT67EvTQPoPEj9Hn/cowwLg/BC0QztiMlbiKtXhFDOR/mfSnmfUeBUvafE7sbDuvEkNcIzbok7y5Yyyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c50e22-32ab-41ff-91f7-08de84f5eba6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 13:54:49.0250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPEP+NrrJBCO2s07f0YiZ4bZRnuPpSjudieoNitHeonRM/QoA+Uuzj4C4Jwy8fRzLYA5f7U8xM41NPvdwGeVOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9491
X-OriginatorOrg: intel.com

Hi Nikunj,

The code changes and the commit message looks fine to me. I would
suggest a minor correction to the code comment and the commit log. I
found it slightly misleading. It can probably be fixed up while applying
as well.

On 3/18/2026 12:56 AM, Nikunj A Dadhania wrote:
> Move FSGSBASE enablement from identify_cpu() to
> cpu_init_exception_handling() to ensure it is enabled before any exceptions
> can occur on both boot and secondary CPUs.
> 

It would be more accurate to say ".. before any exceptions that uses
paranoid_entry() can occur.."

I think early exceptions such #VC can still occur and the
bringup_idt_table is set up to handle those.

> == Background ==

...

> +	/*
> +	 * On CPUs with FSGSBASE support, paranoid_entry() uses
> +	 * ALTERNATIVE-patched RDGSBASE/WRGSBASE instructions. Secondary CPUs
> +	 * boot after alternatives are patched globally, so early exceptions
> +	 * execute patched code that depends on FSGSBASE. Enable the feature
> +	 * before any exceptions occur.


On similar lines. I suggest getting rid of the last line: "Enable the
feature before any exceptions occur." The rest looks fine to me.


> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_FSGSBASE)) {
> +		cr4_set_bits(X86_CR4_FSGSBASE);
> +		elf_hwcap2 |= HWCAP2_FSGSBASE;
> +	}
> +

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>


