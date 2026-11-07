Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794020327;
	b=F+aJ0GSzBYkl6MUfHiSFhpv60Uky+R6A9F675sAMCLsCeWwIRQ/f8AvqOWUY9+AylPKl
	 a6NBg0cCJhPxdnELlbbSi86LOPdjoxlsk6a19rK57LTF0nboCyHTAcMAuBHVtXaxGKyni
	 3FVKcTXw4V9ffBnfIe2JJ6tCEKy/XuQktGJN93GldL7W+2DNcKdYw/ghyUKkmZFXmVjba
	 gygUZeXS6ffqDrerZX0lW004YDYOkjceB7C3JknZm/2vLRykXn6jfVZhySC6jXMzGYHLl
	 vpzAH/YKQGPK79pLYulOWjMv04dypXqOUHfpR/gHHL1WLHQr/Gmm2OAwiRM9zLj8czA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794020327;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:CC:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=rhUw5e9gyGAvCI9mrnh+VdtFm0kgD8UJASJ0p6UVO0I=;
	b=lOrsiuDqiT17bVJgzGpfDimz2OX5hGCzRO9UCU+ztBuDPA25lDWqQ3uKFGUm5aIKBafU
	 9LFsiPVdLYUfzf0V85Yhm3DT0nAhC60QoeVV+5W3Polv3hQwyhwAMKhyONN1/ELw5gNeL
	 seJsRSMBfQF8vGE1a3k1UpRUZ+LxplruBmu4y+EGg95IrXFGl4fTPkCrcf2glw7I3zkj+
	 vPng9chjty+RPR2iXADFlyIUfekwPODwVflK6RVfn2IC2TVNYy3XsIh51rmzReyFo3cg0
	 Rc0rM9U+Dr+e+O9GnLzMGVzBzbusP2P2XXtpsv/0eJ/W+MY3AGAsTZLRD503j/MOH4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HMpG2ixq;
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C33606A32C;
	Sat,  7 Nov 2026 02:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78C33606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HMpG2ixq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794020325; x=1825556325;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LfN52XoECIkFa2MTE/Fzo9aHv2lK2kohuqZSHId4X8I=;
  b=HMpG2ixqo2pKFekWmciHoyxXdaWtp4OB+uutRWniAHxcIaK0ygUvU0ks
   9dh5nF4KpX/YMNgiK75mqWuW92MeOZydgFz5B/dolZJFhim7itIoejWxk
   VFRDCugx4tZ7n0Sh+WbKdnWOofhjfNt7keq0dAA1CFk9aHSBFQtdVWJcQ
   3S4IkEZHS7Kb8Vh0Mk5848ce3lfr7JS5spR+RAJidGYNZTy6C9kwv/HPa
   Fc9G/0l9NfUe/UkB/UGo2AupR3jsCbA9gLgoPu4cSkIXN9EA0K/8poTlq
   mMYmKozEZygjM+ddRSxq9UotTdCsL55YTqYEwqOkbXZVIG48O1zLo7xvC
   g==;
X-CSE-ConnectionGUID: Hw9dE2zmQTC+UfALLBaIoQ==
X-CSE-MsgGUID: kI38PVP8R0qcauV4qy8CDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2831354"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2831354"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 18:58:44 -0800
X-CSE-ConnectionGUID: 6pWM6EcYRk6XnKpz2VJuWg==
X-CSE-MsgGUID: ejT0/YTiThK2MaxlkgdLRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7747767"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 18:58:44 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 18:58:43 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 18:58:43 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 18:58:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZNLVpQJw0D0Ig2UQQ1+A+KtQvPdPimROt5tPKuNmQKXMvk1UGyAH1oreNF7GxuuQIYAs284H/Ul7Oc6lCrfaYvba3+TZOdT1SAfxugpW67SdxK54v0QI2URiQFistHOg0X92IFaGoBgPPgEgoiMgkGUY2ibK5zpnnZPGkUwE22Wi99bLq3GGuF4j7orbe3pF5Detge03mNQAyuh2xi00y+liaGmRwQcObF4C4WTjB0+hrnSc61BUvKnGaHU+CxAsf2v7cVZl+YGSLkJfDT0qfOtYbSNL3uDsyb6Mgz+B1ZIST3Y88bVWj+Jz3yGCspjCGwLXt3eePImLB2VA8obsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhUw5e9gyGAvCI9mrnh+VdtFm0kgD8UJASJ0p6UVO0I=;
 b=RK0YTvJ7W7kJRV1kGxNHNVNLNU+OzUyG7G0kJEIfT76yMGczxUNFtD8ec6DvwAbTqDaxRlvjgQ3oBaZbwjZIyvXElQUkOA3nnxdVIqoCbODg07SxXf+/s/Xk9t8wEkeppxRgatklKNfEtB+X9BjeY/WdkcxD1E4tmbaw2Pax9v8fOUVRzZOPftOcUM1PivoVC+Bp12ZALsMxFN84IShg87jiEkxtFPrI5Xx3NN5tsJfG4irGTJt1P75ZgxIm+WiiaMauEdjeZ15AQxR69e+LHjIVw605sYF6bOVMVX+qDRpCrLFiFTzc0KprR9EEaX1uZY1rxAn1p0Qi5GgULFhGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by LY0PR11MB842426.namprd11.prod.outlook.com (2603:10b6:404:234::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 02:58:35 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 02:58:34 +0000
Message-ID: <fa702160-cd0d-418e-b8e0-daf6bc598d3d@intel.com>
Date: Fri, 6 Nov 2026 18:58:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 16/28] KVM: x86: Mark CR4.FRED as not reserved
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Nikunj
 A Dadhania" <nikunj@amd.com>, Shivansh Dhiman <shivansh.dhiman@amd.com>,
	"David Woodhouse" <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Zhao
 Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>, David Matlack
	<dmatlack@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-17-sohil.mehta@intel.com>
 <51fb9ceb-3fff-401c-8e6a-2a249e3f358f@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <51fb9ceb-3fff-401c-8e6a-2a249e3f358f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::9) To CY8PR11MB7846.namprd11.prod.outlook.com
 (2603:10b6:930:79::14)
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|LY0PR11MB842426:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fd7ec1-1e15-4077-220d-08df3c7b037d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|10067099003|4143699003|11063799006|261026121527099003|261026140227099003|261028144727099003|56012099006|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: q3jC7SGxf+cOBIghr35B3Gdd5V1x2Gn8zOjscikeWmULy2ynuq0fwiNzSNlNRgUw6WFzMnNwF9zEj9XxLSQvvw32405RjrNfQvxCzy2iep0UW5W1nWqyS9Bs7w42cgR0d6c1JB0SabTymFnLRDemvvjpPJOUz8y/Mk25D+Omu16n+wxLReqhnGA2pUACeSuACz8KpFwS8d0UpE1Mf5G/YvUkPzHOGUd0aeaLRJDS1dmR/TYGd3KYkTyoZ41o+lBgq8cu6Bl/vx6+jyXCX0ghJnGCKgDmZBJ5SarGTCDuzuQDPy9w6YIKsAK/qCKmeT+OpV0lGvy4k8tXilUsz3vm2snl4iK0D6xTaEt++h3tNW0qfiFmdm6QvRhhGNq6ps7HNHh3sNPvAUsg/42YFdh4mnDDJisD2tTigqF41iMbxS5X7BTAOxxutGTc6bNr+S0tskFNWxDY73ILRJmdjuePTDQCWNtVIxLLMK7H+2Kyc9omOg/GeR2Y1czE7MxRzw3EcfdUstROX1KkHF5W1/tI4i6FyWdPa4GNDJTvv764Zi2xBs/1a2RGXmci547cEJfz6VEaN3w0rLcSRkbvEHKPnTJ3+iDctV5uGE9dL6GbwrpKqP6vJoHA184yHOwJ4588aq6cfRqRhILzG1xNFHyurv4UzQfGnAh+7wa/1KS3N5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0hoa1ZBR1Fja1ZTRUI5THZhM2J6UHc4b0lOOTU0akROc3owVFllVTRaZmtn?=
 =?utf-8?B?bVN6cTFzMFR6NTNjWmpsVGdPRFg2eEVDRUdxNWQxMUt4WEtzMjVWcm9QeW45?=
 =?utf-8?B?b2YyK2xaeEVEelgwVjNydWZhZVNHSkd0dVlyNDRQL3JoRjRkVmF4c0tNY3By?=
 =?utf-8?B?K1FldHJCNWVrWndjeUxBaGM4SEs4ZlhLZU1hRnh5ZElUeTBHNjlEUGs0c2Z3?=
 =?utf-8?B?cG81TlJiYmF0MVhLdmR3OUNBQXhDOUo1REQwYTdZV2NKbnl6eVhFR0RrVG5S?=
 =?utf-8?B?NGc4TmhhWXlybmovSytub1BTaFBiNmpOU3JXRHhxbUUwUUtWQmVJdytsZm1Q?=
 =?utf-8?B?L2NTbDkwbUJ6VDQ3L1YrQS9IenEzRks1R2xVNUdrU1lWOXcxVXJiVkY0OGlS?=
 =?utf-8?B?ZHJKL2oxTDU2dXRZS1ZMalNBdUYvZFpjeUd6djdPT1lXcVVDd0VVcWQvSHVz?=
 =?utf-8?B?aXFraEo1ZWRjTW83OXJwSmZLcWxSMFh0cEJMcHNZKzdCTnZxeVdDVWtwaCtV?=
 =?utf-8?B?RkdoS2ZHcHJZNjVnNE83TGNBK1dpL1p6OGExcHZwcXVHRHQ1bm1VbWYvTzRC?=
 =?utf-8?B?S05FV2ZadzZMWURaVWpIT3RqWUtBeFdVU1hOWm44L2M4QW5hZVdNM0p0R0V2?=
 =?utf-8?B?VFRTa2gvOFBjUi9BcVQ0TlMzejlTQ2tvZUJzbkZaVldPczZNb28vWWN4Sm9Z?=
 =?utf-8?B?TGNtWWtlRER5LzFYOUppREp4RkNKUUo3bzlwWVVTTEdLYTMzUG1JS1hWeXhl?=
 =?utf-8?B?enpWVVdDM0RqYlJZajhFT2pZYi9DQmpjQU4rcEJQUC9rNGJZNi9kUGxDdG85?=
 =?utf-8?B?ZXNacFNJM0h4bER3REVZYURFZUkrc05OTU5uUVk3RGhnRnhnY3l2Y01hQXUz?=
 =?utf-8?B?NUg1QXpsM2VIVUJlblJFYWE0ZzlqNkYyazJZYW9pVFRrekwxVVRQSGlNV1dT?=
 =?utf-8?B?Nm41TVNUZGtMaWtMLzE1bnljOTRLdDF5UE5lVEcyYkQraHpPY21hYTRhbEZZ?=
 =?utf-8?B?UDVCNnB4ZHAwMFJJUGZ1dzU0cU92TVZsQ210YVlZR21MV2NUWXZqOVlpTXFJ?=
 =?utf-8?B?cEZpNjdzSnltVFhpTGhJMU9CZ2YrbXlua0dzVW10ZGtIMnNYVlFKYWg1MURF?=
 =?utf-8?B?VloySDdqdFFEQWc0d3JGdy9LNVFsWTlwYTBXdmdWVWVYcW9ORHBhK2tmUFpn?=
 =?utf-8?B?RVozRHo1MENXNldwT2xnRHBsQnJ6aVl0Nm9pZlhsZEs1b0lMVHhTSk9Ea2dV?=
 =?utf-8?B?MXQ5TkNFVGNCRXFLMkZ5MTdrMW5IVW1GSGllbW9Da1JhaXJXV0dsVkc3emtw?=
 =?utf-8?B?eUw3OXJkN3MvNWdERDkyN3ZROVVVRms1bi9NdWV4YXlLYmJoaTVOV0RNaCtK?=
 =?utf-8?B?OFVxb0p2aE1aWHU1MWg0YWhxM1pRZWxSaFpEb2pDTlkxcVZxMW5pTHRjTUVW?=
 =?utf-8?B?bjYyM3p2RDNGQUdISDVCNWRPYkt4aGdwN1pWMElCUGJsT2drb3VHQ0RaVHVX?=
 =?utf-8?B?ZXJjbzA3ekE3aU81aXk1cmNoTEgwcER5RVVJNkhaOVk0bGlOa3A3dnpIZDE5?=
 =?utf-8?B?SjZGbHRvdUJtaHNpVEZEN0tXck9OdFVKbHNFcmpsZEpFeTUrUEVwbEtpMkZS?=
 =?utf-8?B?UlY3SHhqcG9odTZMcVNIVGlWbVhGTzM5d3gwU2hOVkJ6eGl0bjdZZDZKNjBG?=
 =?utf-8?B?K1BzMWcvTUl3bk9KMTZIaWJlNlRncnQ3Sno1eGp0bmRwRitYLzhjUmJPMC9J?=
 =?utf-8?B?SkdmaklqMFpNY1I2VXZlMndQUVhROGgrcVFTK09BL1AyOVpzNU5Od2JwZkJx?=
 =?utf-8?B?TE91dnRaRXdaUGpITnJ4eno5M3E3dDMrYWdJbG1MNjh4enFhQ2lHN3RsRXNI?=
 =?utf-8?B?MWE0QnY2K2l0YlhicTZqVWVIbFU3Sm04Q080WWRhaEFsa2w1YUhYN1V6YlNu?=
 =?utf-8?B?c2JHVW40YmYySUloVGRXNitQNGYyMGRZN2EvTUxqbWhzT1VsbzMwQ1hRT2Zz?=
 =?utf-8?B?L0o3UjNmWkpKL0lzNXd2NEpVQ0JWTFVJZkZRNnpaRndtQStrQVd0cHVBVlBy?=
 =?utf-8?B?dFR1YmhTbmF3VitQMHZpM0FMZ0UyTVlXM2c3ZHhtckUzSGRNa2hJQm1lZFlh?=
 =?utf-8?B?KzRJRUZZMzREanlOc2NFK2dhMGs2NVkyZ0ErRlAwSCtUWDVXMUEwUkZwVkhF?=
 =?utf-8?B?ckNEN29tczJndjFwd1doYXlPSnoxWlRISVV4dnM1UnFTbVFkeWJTa0p1WHJS?=
 =?utf-8?B?NkZpL3VwOG9oNzFWTlE1WTUveDdKYXNLeEVWMjE1MEY2T3R6d0hucTQrVDF0?=
 =?utf-8?B?K1FQZ1h5TlFIbmkxS2VsMUxxSjdzOUJpS0x5UGRVV1NEeks5Mk5kZz09?=
X-Exchange-RoutingPolicyChecked: zIFiSg/YK9krrRK2eZ2yXXl0i5ZJqjV5E4jFq+jqv3x01/QdzBdWBO3n8q8EYazrJkVKInVvwE2DZL8r+KDOZ5fZfZf7K3l/33cggENUCeFknghNWZkQxM/55loFq9V/Be9ymaTzpFb/F7Dq7MburASuSiXYPKCWYe/6PWDB5KqgbKaM18J3u/PQ+juZSH79bvt/MY+Sxko6NVVxQFcmwn3SefPpY+kZbT9m0KfqGh18ALMUtj0IzMz/FqLeyqXYJ1dVfqffO3uCmVgNW5ldAflmSdPpHy/s/+qrfcyTjR7JI/BjkUno7yNboUZ2Z9WkvgJ+ApzgXVwM2XYPFnGyRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fd7ec1-1e15-4077-220d-08df3c7b037d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 02:58:34.8897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcxGbo/Vx1KObnvzID57KzbugB4mc0Dpzc4EbUuo2d1o0dkis6fwD60o4rNyUwCruIUjkG8Z5k2HA3zEN2Ztog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR11MB842426
X-OriginatorOrg: intel.com


>> diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
>> index 8f66438989e4..ba6c8856b4ff 100644
>> --- a/arch/x86/kvm/regs.c
>> +++ b/arch/x86/kvm/regs.c
>> @@ -429,6 +429,13 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>>  			return 1;
>>  	}
>>  
>> +	/*
>> +	 * FRED can not be enabled when EFER.LMA=0.  Note, MOV to CR4 outside
>> +	 * 64-bit mode clears CR4[63:32] so only emulation can get here.
>> +	 */
> 
> Could you elaborate what "emulation" means here?
> 

I think the only emulation component that can currently get here is RSM.
As we discussed in patch 15, an emulated MOV to CR4 is Op3264 which is
automatically zero extended.

FRED spec Chapter 12 describes the RSM implication for FRED (see next
patch). In a nutshell, with KVM's RSM emulation it may be possible to
call kvm_set_cr4() with CR4.FRED=1 but EFER.LMA=0.

This check mainly handles that situation and makes RSM shut down.
Though, I am not sure how important it is to correctly emulate RSM. The
checks were simple enough so I added them.


>> +	if ((cr4 & X86_CR4_FRED) && !is_long_mode(vcpu))
>> +		return 1;
>> +
>>  	if ((cr4 & X86_CR4_CET) && !kvm_is_cr0_bit_set(vcpu, X86_CR0_WP))
>>  		return 1;
>>  
>> diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
>> index ef46918daf43..5db01693ad07 100644
>> --- a/arch/x86/kvm/regs.h
>> +++ b/arch/x86/kvm/regs.h
>> @@ -28,7 +28,7 @@ static_assert(!(KVM_POSSIBLE_CR0_GUEST_BITS & X86_CR0_PDPTR_BITS));
>>  			  | X86_CR4_OSXSAVE | X86_CR4_SMEP | X86_CR4_FSGSBASE \
>>  			  | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_VMXE \
>>  			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP \
>> -			  | X86_CR4_LAM_SUP | X86_CR4_CET))
>> +			  | X86_CR4_LAM_SUP | X86_CR4_CET | X86_CR4_FRED))
>>  
>>  #define CR8_RESERVED_BITS (~(unsigned long)X86_CR8_TPR)
>>  
>> @@ -423,6 +423,8 @@ static inline bool __kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>>  	if (!__cpu_has(__c, X86_FEATURE_SHSTK) &&       \
>>  	    !__cpu_has(__c, X86_FEATURE_IBT))           \
>>  		__reserved_bits |= X86_CR4_CET;         \
>> +	if (!__cpu_has(__c, X86_FEATURE_FRED))          \
>> +		__reserved_bits |= X86_CR4_FRED;        \
>>  	__reserved_bits;                                \
>>  })
>>  
> 

