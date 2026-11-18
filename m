Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794991014;
	b=phSXr4v5oPjkkIhm3VVyqUpc5R1Mv4uL3vz49A4Re/Z/CPFdPZnm2Bl8ihpuEEccvF5H
	 PS8hX6u5vK48YoYCV0DSit3dtgJK29OKjFwnBg1ABsrKxJvZ2FYbEnQOHiTBeuwqgGbHT
	 2ydCD4br2kIIXBW+YcA7Z6oEhczbG+xp6YMqlo27Tdyh7xcco5KrI0kpwwkkev0nu6ob6
	 oDKW0uB6Up9P/k6rBaW9sMVNzq6Ya3up+QVdyzEJh43KUuHL+T8zLl1Q1JtMZxwqkmcrE
	 YmlMzrs85adwvaNeLKWFGvl9QXOARqiBlRqfuTbBbyzbfNj6ugI7MyAt/uR5MS7G1nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991014;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:Content-Language:To:CC:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=ysMJumJw24ROBj/NJjqhg38yEXiiRpQVDxwmTIMDQUU=;
	b=pDDFo0yAEpskrSrODkBI216M2fSPAuiS4pnxa/XNWAp/w5H5qYygJEBlEorpSE3xnrUp
	 2ISx8awJT+i28XIdNLR7yaLYsif7XVhId8TnDPugClW/GeBqNBqDhlMGXJ+7uGR2XLJYl
	 UutR1ljGCw+3uXCaNAFsSSfXun34pVHXn4z3VYKX2MSlYE280pDpWvEab81pATfSOHJG6
	 iBO6vL0ajUOqp/Gg8/Y9xvXjzEnfu4UYJwYfHEMLy5A+pJCYsqlBNBFe/YHIatXqeZm19
	 my+9+7B74c1U3K4gWvH/RUPPaUaDQ8T2K7NB9OwyTjo5heoPJAJZP2S2XBddk0JThDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Alt02F5q;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=d8pnHclp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495BC606A31C;
	Wed, 18 Nov 2026 08:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 495BC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Alt02F5q;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=d8pnHclp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794991015; x=1826527015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zR2NLTkJw2Hiif2GUwNbF7GeSrWDH7Tg/Gt/JqXb5gA=;
  b=Alt02F5qcBY8aCpIGbHpto7M50BnEFHZOjOMnWf5MQokJoS7FMObxIeG
   mVozSS4Op+lPXEFC9bwI4ycY8t3Ne28fOHq+AmSBTm0OvJHn5Q6rsBdxY
   fJaefbdcMB3LO/DQpu06VPCs0KBYEYQeys1VCY/vkZd2UshUIgPKLHE+z
   BDn/u9eSkFWK5BuRpJgaKnR0DYPsP82RPMr0ToMZpqFpo0lA7IWbTUFrU
   680HA+sRnbYPNzYnSuPWGIMw5wQDJjtU4/DYiUQZefhaLSn9yBnkd+G4r
   zs+7mLyUS4chmo/F/hxVrC/oTX5s+kiJyDWKU94/v6kKbAMSzb2gj0WFq
   g==;
X-CSE-ConnectionGUID: cYlBxQsJQjKGwkmEKhJaOg==
X-CSE-MsgGUID: BFcZmk42S9CZ+Y+YWSZxJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3799378"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3799378"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:36:54 -0800
X-CSE-ConnectionGUID: S2QpdxGARUOxmXciZwtzUw==
X-CSE-MsgGUID: Uqfiyi1lSUyNc1BaTb+bfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="12031330"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:36:53 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 00:36:52 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 00:36:52 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 00:36:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QK2JObqxPSg47yf0YgtvStE4+xcTCO2eJGuXKfzqZofUA5OUt162QwZ7KSZlD6I9o8chr1zp2kxuWw2e/MxI3bV7B04YhiyatICojr8Po1HHm58GqkHt9xtxTc+qTlCy77Fu6VudZqhidULheQtzkfzolvLD/O42Y3Bxch04RL774G2crhiFMkVZcFanYX49deNz89nd/3D0LCTsqGxscEXJHdapTFoyh1z7RR/HhZVm9MaRVOddzYUt3zo6ABsp0ASPB1fG8j3aD05sR6stmBh60Gz2PRIcAcGxYY/tsjsbuM2wPjoFCaETfnTSw9S0iqhJ2zoUDlm6CcBSUcrj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysMJumJw24ROBj/NJjqhg38yEXiiRpQVDxwmTIMDQUU=;
 b=gpQjcrye6Epjgw71GbTVry7mfHUOM7OL6F5SYla06KpEVk0NTaWPvj0GIYDv2WWPFvTUW2vJpYynK38Kv96eJKIu3adYQaMtUMEb3Dh9PLFHyTHAKSD5ALmWgwGhhRfZyp5LicE1jmEhdxdHPcimePySyKPxlwchVbAf2MhhAAD1dTTFC4jPxRDVPN27BNsbo0WEF4q2tuMmIfJwhwq2KVT/qdSQOK32dusZH5E97N/C1pLX9HYwmDeGMP9EWiT8EJvRFonc+qmXc9y6UAnhosOOhxdOsDQKzwwnsihxbvNJ2MEwE223GnuRcfRInBkOBoF/rKs1Pz/SGOgJAGCH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysMJumJw24ROBj/NJjqhg38yEXiiRpQVDxwmTIMDQUU=;
 b=d8pnHclp4hABghcBH9kgATcg8uG1j/Iw2ojHezqhKbayhkf6BceUF4MapCiMONyD5WNEsMZBw+JheABal7duqsuAjVc6ONOMTnTMTX1D+JAVA9doWnke6DQ4Sg7pXr7qObRHwYu/hg0IVzKgk3nEwdJkegEYKWAQ+uDS8eMRR0s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by LV3PR11MB8741.namprd11.prod.outlook.com (2603:10b6:408:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 08:36:49 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0615.009; Wed, 18 Nov 2026
 08:36:48 +0000
Message-ID: <9bbd702e-7a99-4f42-a560-b75aaa2700c0@intel.com>
Date: Wed, 18 Nov 2026 00:36:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 21/28] KVM: nVMX: Handle FRED VMCS fields in nested
 VMX context
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
 <20260911213659.2025974-22-sohil.mehta@intel.com>
 <508329e9-a3b1-4143-830c-44439d459fe4@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <508329e9-a3b1-4143-830c-44439d459fe4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0136.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::21) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|LV3PR11MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e3ec22-7cd2-4936-80b0-08df454f163c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|4143699003|11063799006|56012099006|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: 7ilEcpnvcgBF++YnKBV0hDJU/iJbmM0G2GnUbtJx2WhPGfdkOgH4XWQAWGCN8cl0WUUKsfPbgatlID3ufeD5j6YDR6DYIB2vtA8t86PygzF2bT+6wSdPkphjT+qbgnX7CY/TUZQzIcLtULJCvvk87gv3/4ZUbltlMuTRC4oZgC9SkovzqhlEUgkfXg1J3acTT3xz/r126zbpAAq6kaJf64vnS6P64cUfMp3xK8xP5fMd3y4a/h6VDg3pDT8leV1sE8AN5/doHxCjnBkgw360nE3u5eL2DIulH5TNIHChYROQtgbrmvyKFFX+anSKBeIV9M2UHQUHqOtNQzBqRwx53kSFQC50BmlXKrmSVglSO6JyxGJH29CrVDgXUSfA2HHArYlscPmWTrfZRzLPrDas9Pf4QUPbev8INKKNZvWc9zvWDebyecooM/PKJ8SmfyelNZP63ly9XtXBXTyEq60JNEi0niX7lZCPVcvTUfypgsR7avupXBfzvhfB4BjPYY/eQdqwEX7FIBgKD3FcGK3blT9KCcrGMkbsdMSj1aqtVEG3PN/2NHGSCiUUGrNPxR99V6k/YU7u00/pDtqT2+fbcfcet2YQSh7Xh0j899iaY9n/shELMb36xvhyeXBiFXImaI3e05rIBk64IYfi4XixN11DCrRyNafcrR1jXdkgWi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V09PUFBNTWVhaUZqYVZ4cXc0SkY4V0E2b3JMUmRrUnI4T1FreXgvUmk5YXFY?=
 =?utf-8?B?d0swaUlWTElyMnpHWUVobXNsUi9uYUdNQkJnV2RUdWpSVXlHSTZEVUFLS1dD?=
 =?utf-8?B?NVltWmJvZTRwY1Nmd2gyZFVkVjU0dUNkZ3k5ZTQ2eVRYVTJPU245WDlSYmt6?=
 =?utf-8?B?Q1BKaDJGM080RTRzVXByM0ZIQWpBRDZRY3hZejBlYytRL1hpRUhRQjhhVmVs?=
 =?utf-8?B?VEdHMXp3a1crbmp4aEtKSlVFY2FSR3BHYUtxMmIzQkxuVkV4SEE1YUlObkVM?=
 =?utf-8?B?MFlVWFhWSEpHdExRcUZ1ajlOcjc0b0RWNUttQW9RVDVJZFBVUHpBTkF1TWYz?=
 =?utf-8?B?RTRjajBNT0tyOU5IakpJek0zTVV1c2creWlQUENrQysvbldXYzErQ1JWc3dm?=
 =?utf-8?B?SFRpUGRUbmFCRXV3UTRORE9mUk5yUDRhWmRhbXFkbytldHRqQXJNRkRvS3Nw?=
 =?utf-8?B?QzJMWkZ2bmx4REtJUUVtdlc0eFpwdDBzUWdZMm1ublQ4enVoMU1lTEx3eFNm?=
 =?utf-8?B?dXVDdU55MGo3dUpValp1STVPTTBJYkJuNVVzeXg1YXM4SVBEblgzSytZcnUr?=
 =?utf-8?B?dzBlSnR5NkdaZXNVeUozMkc3Y21oZnUySjJwc1NkdjlFdkZIYmdsWmxVQjJl?=
 =?utf-8?B?U1dPSXRxWXVEMVR0RS95UGtDbjhpblpnaDVsb0psQUZ4QUJBSTh6aGZWclZk?=
 =?utf-8?B?ZnA1cWNvN3ZtUDRhWEdLcnA1dGVxY29uTXJaTmg2aFk2VDJSRVpJdDIvMy9Q?=
 =?utf-8?B?Z1ZDMEdOMGJEUEoyVThYbFZsOEJBL2J0cjhhU2NDK3U0dDlZS2o4Y2VzaHVk?=
 =?utf-8?B?ZXVXR00xOEdXQjFzUTM3OGFYZ2NNY3VkNUdSWlFSKzJrMytwVjZSaEhIdThS?=
 =?utf-8?B?MTNTUkIyb3ZneVoyaGhrMWtWempzMFNhZFNCZ05Sb2NTcWVSTy8vZUdpU3FX?=
 =?utf-8?B?YkRWczJXZ3laK3AxL2pUY0tCak9yTmhRSzB3anIrSWJKWlJHNHhqR0JlK1Bu?=
 =?utf-8?B?YW50S2JFVDZ6SGkyd0U2OXFGWkw3MVA3NnZaaENRQ25NT2M5RUlMTVNVNElT?=
 =?utf-8?B?V3Z6aVRveGpDNFAwZC8yZm9zWVNSVm13U25Pd1JRWlBBOXlmRTZpenNtTWYv?=
 =?utf-8?B?Y3Z3c1dESHJ6alhpMHo5bjNmMXFyTHFtQmpNbVlPOWVJUDIza2ZQaGh0S05N?=
 =?utf-8?B?ZVJHRmZPSVh0UDNzbjJFWjRvbFJibnRyUUV5Qy9ZalVSWEwvczkvZTRQTzRX?=
 =?utf-8?B?STE4UzBkVnFSZURSeEREenpTbURGWkx4Zjl6QVhZNkcxSWlJK3RXM0dvM3VF?=
 =?utf-8?B?Y3VoUitXSmpQT2cyeklwL1pmM2FIQ1FBNGpnWkQ4Zzg3MHBLOWxwMkVqL3BY?=
 =?utf-8?B?cU1qMm92UVY1YTJSNHVuZzBVYk5CUVI2M05IMmo3VHNKSk5rRWdJZGdyclpT?=
 =?utf-8?B?K3gxeUNzWjdZUWsyMXh2bm9XTmxVbVhvNmZIcXhSUUJFMjNaUktEY0hvTS93?=
 =?utf-8?B?MG1hakVUeElUc2pjVitjelVUY0k2Q2NNK1Z4RUhsQkwyUHdWK005ZUZKVW83?=
 =?utf-8?B?TmFDM28yZjUxNjNqcTZvT1Qxc3g4ZmJ0dWVSMmZxdlZla1NlalZNWUV0VU1t?=
 =?utf-8?B?K0I2L0Y5Wm5nVVhzME9wRFRoUGNYZFplUjJER01wYTdWcllic2VhVkxFNzl6?=
 =?utf-8?B?VGd4YmRjR1ZQQnJvVG9oZi90R21JRWhPRDRWcGIrU0QxRUE5NzdCR1JVMUoy?=
 =?utf-8?B?aU0wSER3NEFsaHdDcTBQSVB4alIvMkI3MVprRnVrRUJ3Sms0UVNPM1RWK2FD?=
 =?utf-8?B?ZTBsbFZ6ZnJsUHlWamo5a1c0RU1DcTcwbEZJeFV3Y1V1Slg0bjhveVh3TSsv?=
 =?utf-8?B?MWpMVEIwekp3cHlrUzUwVnRVMTU4OXJPNzhMQUxzMW5Qb0VXdlBTNUNUd1JK?=
 =?utf-8?B?YXJRWFlCeGNmWk13Uk53dVdNeFdQdEV6R0dIOVozeXV5dzFTUDJDclUwZ081?=
 =?utf-8?B?c2F0TjhHM1NlRndCNW9VUDVwa21BOVJNeEsvcklXNUZNRTFmVHFOeGZVem8w?=
 =?utf-8?B?TFF2cDQ4Ym9zeTR5SWN2TmZJZVlTU2FvKzZiRDBKRS81NVZyL3lUTmVidlpV?=
 =?utf-8?B?U0NyQUtDYVNUdWk0eEJ6Qmk0UzZBQW9tVVFGdWx5dDVZT2UrZ1VSdi85VDVG?=
 =?utf-8?B?Ym43WE53OTFQNndzOFpSTTFOYVFQaTBLalk5UThRb1E0UEd3bzl5MElqTWpW?=
 =?utf-8?B?bHl5SWMrZVhydWY3SDRoK1kxaXN2Tkd5Y0NPNUZ0YzkxNzZ3cUFTeVdnRnVa?=
 =?utf-8?B?M2tsM0NQdU1iN2krSEdOMUxMak95MDNzMjV4SDNmQlNMZmtiaXBxZz09?=
X-Exchange-RoutingPolicyChecked: 2OelY5vjz2h6Fh+9stQLLsBjt2LdwOB0t5YSQsEcXA3iLHtEysvRlxdT+Hom1oRb3Dwzb46hJp+mEbBHqjfL0uWNc1yKaOCC/vsyF9yyO6f1U+ogMRbAkXJXByuLBaIC7WzNBxMnuzD43dAP53MKpUg6xlRFpxL34497obwNwTLeS5UC28KkvhCChsg7H5r3p2GqZnam3RWhnmd6QL0JosgoAhDrbta4zrTHEYF6TzxRJdQIsqLdtbXaiGl2RtpleqKCmTHUIN/yKzD79lkFbMMsxCNrjxtKMM4SuXQMl3IwdbHG9BeuH8FVKIaojXXqcQhn89JBFIc9Ykwg6PjUZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e3ec22-7cd2-4936-80b0-08df454f163c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 08:36:48.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5cbVyJGCsuluQmzLBcurTOq2G/uCBKJYVcxIh6vzv/ouO4W/1WDYjqonalYlWAtyore+o4tzXdgbFMQWZQq1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8741
X-OriginatorOrg: intel.com

On 11/3/2026 10:43 PM, Binbin Wu wrote:

>> +	/*
>> +	 * Used to snapshot FRED MSRs that may NOT be saved to vmcs12 as specified
>> +	 * in the VM-Exit controls of vmcs12 configured by L1 VMM.
>> +	 *
>> +	 * FRED MSRs are *always* saved into vmcs02 because KVM always sets
>> +	 * SECONDARY_VM_EXIT_SAVE_IA32_FRED.  However an L1 VMM may choose to clear
>> +	 * this bit, resulting in FRED MSRs not being propagated to vmcs12 from
>> +	 * vmcs02.  When the L1 VMM sets SECONDARY_VM_EXIT_LOAD_IA32_FRED, this is
>> +	 * not a problem, since KVM then immediately loads the host FRED MSRs of
>> +	 * vmcs12 to the guest FRED MSRs of vmcs01.
>> +	 *
>> +	 * But if the L1 VMM clears SECONDARY_VM_EXIT_LOAD_IA32_FRED, KVM should
>> +	 * retain the FRED MSRs, i.e., propagate the guest FRED MSRs of vmcs02 to
>> +	 * the guest FRED MSRs of vmcs01.
>> +	 *
>> +	 * This structure stores guest FRED MSRs that an L1 VMM opts not to save
>> +	 * during VM-Exits from L2 to L1.  These MSRs may still be retained for
>> +	 * running the L1 VMM if SECONDARY_VM_EXIT_LOAD_IA32_FRED is cleared in
>> +	 * vmcs12.
>> +	 */
>> +	struct vmcs_fred_msrs pre_vmenter_fred_msrs;> +	struct vmcs_fred_msrs at_vmexit_fred_msrs;
> 
> I understand that the two fields are both belong to FRED, but the comment blocks
> are for at_vmexit_fred_msrs, not for pre_vmenter_fred_msrs.
> 
> Should pre_vmenter_fred_msrs be put together with the other pre_vmenter_xxx,
> since the comments above the pre_vmenter_xxx explains why these fields are
> needed.


Sure, I'll do that in the next version.
