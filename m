Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794996105;
	b=aASBHDXWpx8No5DusHI8OWWYXzquW8Xsu0EFAXXycW/7DpYbEafdzdYyVIaAPgQj8Rgs
	 MkF44E6pwIGt70SmC0zQf6Htm/um1t/052Nu143kqqSBdY+sj+uNTyWdTR75zpU1Uwgua
	 fh85j7DbNfr9AO7oaYGdVV2yhwXVQlcLit0lBlxFuUVK0927DCelN+QfV5V/aJGHYWvBp
	 1eaylH3rfOIhlYtiyt+MmWWpoB+Lg2/Omj9z9ndV9iG6csCuqsVXx7ovRzYcioCb6yyyN
	 /cIRC+CBd1XMxU28M60947VVOm8Ej+Hx69CZ+GgTHJ/5rv+zn9eJ0DOPNuoGyPEL+Bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996105;
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
	bh=p12lkhC7FXrxblgIXJozAe7t1duiM/m5iM7/Y8MMs3Y=;
	b=Bm5I4ORCv8eGdaVHgMxoB/5MHLP6jQ9PtfsDn3eFlHEtCNOqQ7Jxi7kJ5O2Vm7y8047W
	 4x3W4E4c+MB1Nrxv+L1Hah/Uj9q3kGaVLN+v3Cv1aPkygubq3eeEWhSdZBnmNHMBxFu3k
	 +j50fEXgR5oWtR/AftPBBD+1LQSOgpfoEkgHyIZ7CLFisWlgqNeGJZSOdX3hQulR+2GXC
	 VMhHE1No0NUeEIxanlPfBetfXAUpSf/iAEt+7s0A4gutrWz4H0TY6t8KH/Zu0+bqVgNGF
	 vs2O8aW8EDbx37PvpDdZmjndQ2HtRgjzNevh6JDHd2QJ30PwSxRhpBuPMHhTEF2qEQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R83AjDOj;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=k0w7UkSY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05063606A31C;
	Wed, 18 Nov 2026 10:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05063606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R83AjDOj;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=k0w7UkSY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794996105; x=1826532105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SGHxktkOFebvvYqMt8jgC2/2HURRnqYxiBLMkOUsLKQ=;
  b=R83AjDOjQvrEfViU3T8EUl1bwJ75OtQ/rdDHfbDjounytxz3YyWzcVcw
   sQa2yz5+Cv/AGLyHmRm7Kf5gobIJ/EgdMQJJcT8nZ4+qckfs7ltLOwess
   TGeJibH1iU4fM4vBUgeFjWEqYCKR6M+vtZLBvio/obAxBuUri4Ngt6oRX
   OWpOGVsThDZNCHEVD++XQbHTTnqlLnhExoU15+G0Mj8kOaUNk2vbSCt30
   UiiIhV8x9dHNAUoP26PIdBCs4s/n16ZckN4wN9ZMqLM1K43Kh102Rzyoh
   fKGVkE4pfX0/iqLQhAgOVcSeM1lkR5oz5vVsomg+MPzbbuUz+ijbSMQiA
   Q==;
X-CSE-ConnectionGUID: XclwBo5tTHKbIfML3G7MbA==
X-CSE-MsgGUID: Hq+znRGAQbaeM7Whu2gXSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3809019"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3809019"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 02:01:43 -0800
X-CSE-ConnectionGUID: bPqfiB8CSF+MWgTo9f7xMQ==
X-CSE-MsgGUID: DaMVf2vHRnWVm8qPPf1+cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10245935"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 02:01:43 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 02:01:43 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 02:01:43 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 02:01:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaFqWdIuhP4+/rukXtY9kyY212ZOvmwzr81oTFKVlEpJPBpdxC9DhLgZHCW0jYC9U/S7F9lzjNO3uOFYdQSiakO2nQEJEbpud/qSff5R8Y8kOHvehCXJtHIeTP/WVr59Oc9BbhkPhg5z+xoOXcWK9s3bQzeLkcwtaafrYW1zX4NYR2JQsz9FYt56wSXSWlYZBOTVKnu0cJWyzrJVZCZC0SNel1xW0+tYavQIdFQGQmPrLLCmJ2IVWD3faVrBNcqyfn1se/Q+s12utVU51+SjeCTR7ePiZah7VrlCgdTxtmcAEJOJeBRL0MQ5nIGn6g9VKf+4/SLB1qyr/DU6x1R+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p12lkhC7FXrxblgIXJozAe7t1duiM/m5iM7/Y8MMs3Y=;
 b=jAgmSAjSI3GD4O3fbEdLa4aZC5PwJIhlucNbtLcl2vonbomXHzUpM4n3is6urrlFSSSAmiTwzlxEyz63SaOSI4dOc6mmk/Cvf5p+Ji8HFckZ4OcNuaf31lJS95p1ze1nSiaUUqtW901BHv3TTFVSrud/KkCbQ4u+rpX+5eTlIiyet+7abzFBQmuJklJjSjWdVaasnzMUxu2NnYXibZvzbthZ2+HpIZ5+76VzXPu3t98bmj47U4MZ/mHr1oCRuDQmS4PbHkngjQjMMVCyCeIUmkdbmK5+Rdkc8JkoFBQw8zPjIAL8OapdQkSuukbZwvlw6OtBy0MXyOc7jvPr8Uswzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p12lkhC7FXrxblgIXJozAe7t1duiM/m5iM7/Y8MMs3Y=;
 b=k0w7UkSYLX6njRL/B9a32EUe2cqmeHogaqg5nxvrlosV8WV7jjCtnc1kRZvoQKeO7xcZsvYOIOGCyYPSCXY9p3/fPNXe2ct5QxYyHtVlBEmxWIE2es6FIlkBFJmnBP3jxkKs97ar6cByyjX3sPTkcIsJZLtXEmSUXwXNvjZ/il0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by IA3PR11MB9206.namprd11.prod.outlook.com (2603:10b6:208:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 10:01:41 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0615.009; Wed, 18 Nov 2026
 10:01:41 +0000
Message-ID: <12f686a4-a9f8-4347-a7f4-c0f893addfb9@intel.com>
Date: Wed, 18 Nov 2026 02:01:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/28] KVM: Enable FRED support with KVM VMX
Content-Language: en-US
To: "Chang S. Bae" <chang.seok.bae@intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li
	<xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed
	<yosry@kernel.org>, David Matlack <dmatlack@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <609c2e22-db8f-417a-93b6-c4fcafe79bc1@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <609c2e22-db8f-417a-93b6-c4fcafe79bc1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|IA3PR11MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dbb12c5-997e-4fe0-40bc-08df455af118
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|261026121527099003|4143699003|11063799006|56012099006|261021123027099003|10067099003|261102130727099003|261022075727099003|261022113327099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JGI4H0nkqq9Tux7stRMiAi4eTTPV0vAy8htS8NZBW9MytHF9hOd0mvQz/tu/hpR7aMLjjSIW2+vVKUdFs/F5NgtpSEdqLzq737RlDpgrC7gIPSUmnrJSubTqLwZXfQWs6BkfLsxp6xLPnKhsvW59ChjFtdPlIDzPB2DAeYAaf2fhG2vNn27R8JF1nCoAAPHxjzmNgD0IypsPuyE4ck3DKKJ8dB9WxFYZKQyquCEqUgZqw2UNArZud80t9V0ow7O29h1rEA0jkrN9QLxrbTHfUy6mndU35dTNA0YF7KtwTnrak+gjy3LWXe0D6ljBfe0EQazfP8NasTh1cq9+DdTuBGnmarXcYCgelEtTkt3E/t/vH7NsuHmeZfmdAH/2CLzd0KCZY0EzwDyAmLnY3ymGnOePbs9oJi/0Rvn9ORUQ3XZUlabyYz79/UBAOkj8PCjc473VSLBmMrQCynxdqor23iRgYHXxAgl6G/RJKS9zybKxrXEQCxzMCWmXgiWRDjBLaHFS+uCcjGB/jSs6EWGc1JMI5TtPMUL+OPnohIi548AUMEsesEzCLHlMcFaVCN6/3HUfvm+WhSX3E7Rlh7W5pUH7wbIp0PVssRTmsEJqWPvz+RI1/FCvkdtLtInuan1WJiIeUXlBOdOBGaxI42YmtibyXBBi1RwyKiEVYlfxoRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(261026121527099003)(4143699003)(11063799006)(56012099006)(261021123027099003)(10067099003)(261102130727099003)(261022075727099003)(261022113327099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejhmTmh3UjNOUklCRmNtb1FLRkNxVXZ1cDUxN0VWa0hJb2ROVkpxcGZUdU53?=
 =?utf-8?B?TFRXdExzcE5za2dFQW44UStwcWsyWllvSGx3TkZ0RzExc0lnSjZtNUhyTEpH?=
 =?utf-8?B?dzRCblkxTzliTTVuemtLWFlRUTlDWkJnSE1vMTNNdzZrOVdtcFRWZWhHejh4?=
 =?utf-8?B?MjFwTmZLOUZhRlYrKzF4N2N2WE9sNVl0Z2dKWFZyVVExcU8zZ0VVUjBSbEVL?=
 =?utf-8?B?RW5aV3NqV0U4Tlk5QkZ2TTExcjNqZENwME96Y1JEWWphcWtrUW93SUY3WDZs?=
 =?utf-8?B?dHpKRzBqYWEzNlp2MnMvSUtUSFQxcnMzZkh5YmovYWJ2RnI0ZVlYaHUwL29k?=
 =?utf-8?B?cEdGaTRQMlYzcml2K1hVRlFZYkZHcEFoYlBZc1ZlV1pGbTRyNnJnNVpqaUpn?=
 =?utf-8?B?emROalh5NXBacjZ3aXFacGh6RVVxVElmUFJxcUZCUXo4Q2VpWHRONmF0OWU3?=
 =?utf-8?B?MVhRUGZoSm1wM2p6RGxHNnh0ckRwTGxhOGw4S3cyZ1Q0UVJOYVlhSERBTG5P?=
 =?utf-8?B?bm1uTit0YUxnZXBrc3JERzJjcXhTZ1lkR3BsQnpaNDFGQmpqMEExSm9XUW90?=
 =?utf-8?B?enJqMk1ENTdqNTcvNlNJbFIzU2pmdmYyaGplVm81ekxuYjNManBlMXVKTDNi?=
 =?utf-8?B?TGhobDQ0N055K1BIc1R4S3BsV2lLMnhub0dmNXBFbnQwcUxUalNVdW8yYTFL?=
 =?utf-8?B?VEcyalNMYm5GOVpFekZmbzlmSVgzQStPSExjcVVSTDBtOVdnd0ZESU03M0ps?=
 =?utf-8?B?c0J3WTlvNzJCYlhGdVV4aTBmRmRtYkVRSkZZS1JUNkZJVlYrbHZaSVc1S0Jq?=
 =?utf-8?B?M3FHWitabTdBakdhRDN3VGtZd2hHTXFadmtOUlg0UTBFdHdqNGd6ZzBxTm5r?=
 =?utf-8?B?NzVBemNxV3BpZkZtdFI5WjdOY0xoekhOWnhwbG9QSklBOFZ0ZE5EbkVRR0Ey?=
 =?utf-8?B?bVYyL0Z2Y1hhQWlmWXVhNHFzb1l3elJpcWJwdGEyMFd5akxJdUN3ejJTLys4?=
 =?utf-8?B?azl5SkRwQWhSM01lUUxVRVE3OFN2dS9RNXozdTNpNkw4TTM3elRtUVNNZTJZ?=
 =?utf-8?B?cUsvVWgrUU5oNjhROTB5Qk56U0NpZ0VRWUc4cHcyUTJ2a2RscHdhbTZLcWpS?=
 =?utf-8?B?dTBzbU5wdXJMRG5saDVOblFCUkcraUN3S2NBbmlPckpyTnJSWjh6V0p5dExL?=
 =?utf-8?B?Z1N4eEU2WTNRMnR2WEl1bjVNNDhsWmFJSlhwTXBKa3NNQlZCTWhUVlh6dGg5?=
 =?utf-8?B?Q3pvMVZ1Y1Fzdk04dVozZ0V3dlJhaXFnRXMwdEF4N0FGaXpZdFRKajNjSEVE?=
 =?utf-8?B?RDBiQ1FDa0xBM3NwNHJ1M3ozdkRhTlZVak1SWEFHSldkSUlZRzdTU1kyODg2?=
 =?utf-8?B?bXJQZXZPbkY1MlV1WlFxN3pUSW1hYXdzNXUraC9oaElxUWVRdHNPTGQ5bGcr?=
 =?utf-8?B?Smlub2Q2TmNRVXpZeEluY2xFbWZuek9obGFMT2c0Mk5zWW9HVWY2TjFrTVcx?=
 =?utf-8?B?RzVGdWdlVEJLOStOSWdNWmhCSm10WUM2ODJHenF5Z1g5QTVUaEwraTkzM2Jq?=
 =?utf-8?B?b1gwWW95QnE5WEZwTnJVU1JyMU8ra2ZPZSsybmhvWHdwTVU3cTdDclZ2d21B?=
 =?utf-8?B?MitlcXpZU1h1ZExxVDU0VGR1TVJacHl2RThudHBKWHByaG9GMjc1MENheEZX?=
 =?utf-8?B?azZ4d05QMW5QODQzdDd3c29sOHd4QnhaOU9yR3c4ZmwwYThKOGNCSEpielN3?=
 =?utf-8?B?b2l6SlczMVVydkNaeUEvTGkwcFlaTlY2U2JhZHl4eVRweHlJbmdJMlhqQjM5?=
 =?utf-8?B?SkhsUXhtUW5MaG5JVmk2Z3lIUDU5SnVpaFYrSE9RT284WjJlL0FhcVFTMWUv?=
 =?utf-8?B?Q2IrU0hIU3g0L0lNYnBwdTVRbjMzQXFqNUw1aUQ0Z2diaXN2ckxJcmcwVGJq?=
 =?utf-8?B?ODhyU0VUTFBCRjhmc21qdjRZVjdtQXdTTU5UbjdObkZJUXMveXZoeE5Zdndv?=
 =?utf-8?B?RTF2N2pWVkwzN09iaStCVTV2M1FyNElZbTE0VTZ4Qnk4RHhaYTBaWlJVWVRh?=
 =?utf-8?B?eHRLbVhUd25YM0FpTVBTTVZoZmFnMzAwajhSWGF6REM3Q09NdGY1NUZTeVBP?=
 =?utf-8?B?Y2plNE9jKy9mZ09hTXNBNWpHVDBhSStJZjJiWFl6M2gwVHFwVUwyaGN2STJy?=
 =?utf-8?B?Y2EyQ3UrakdTYmpPb2JXRkozajc0Zm5JbEpnQlRINXZ6b0UyNy96NVpYbGZx?=
 =?utf-8?B?ZW9iUU5JL0xLa1k3cTRtSVJtS0gxRXVtVFhpWll3dndwcThBck14RHBrd1c3?=
 =?utf-8?B?ZkpiMHc1WWlWVy8zcm1nSzJIL3FRQm85QnRFZFFtbGRLUFlEemVTZz09?=
X-Exchange-RoutingPolicyChecked: PTwdDWMuUBEE64+KFp0Ak7E/iXzgBH6Iw/Y39p/WT3SD77QlXF4Y9pB+o6jwRwxATbOxmL1Ugc+9V3vQ4J79PMMH0tfcKYaQkOsnFrhzMLT0fwBuGJB6XcevIK6Z3kS+DUvaWZ/AHpAGnn6VD5figA/R94owIw0mGBlFjfU297NTql7pIJolGLkBhD5irpP3rvjpEwEfgZOmSHqInOCZTGu/Np165GE7G9VF060sNLNTimr2Bv4Ttta09oYLKmc8T4sQiVniCAW/dg7dqRsRc2sJhekJmOK7fe/pUbm+BxWpGLIl6oUudrS9eE1BNdA39IaeCnUmkibKZyHK7Vnkuw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbb12c5-997e-4fe0-40bc-08df455af118
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 10:01:41.0816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7127w90OOIRb0WbaqZ0FE6+F3NGsnT30Zyuebc+J8laWj+CSfxAv4Op9DYYR/0GN912GQGBQT0AnaepXCwjag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9206
X-OriginatorOrg: intel.com

On 10/30/2026 1:53 PM, Chang S. Bae wrote:
> On 9/11/2026 2:36 PM, Sohil Mehta wrote:
>>
>> Patch structure
>> ---------------
> 
> So I'm more interested in how those pieces could be organized to make
> easier to follow, review, and integrate going forward.

Thanks! This is good feedback. I've been thinking about splitting and
making this easier to review as well.

> 
>> Patches   1-6: Enable the VMX controls and export the host stacks
> 
> These seem to be preparatory changes for supporting the state and
> extending event delivery later in this series.
> 
> Would it make sense to put the x86 core preparation up front rather than
> having it in the middle of the KVM changes?
> 

Sure, I can move the x86 preparatory changes to the front of the series.

Actually, some of the x86 patches are good cleanups independent of the
FRED KVM support. I am thinking of posting them separately and maybe
those can be merged sooner to reduce the load on this series.

As you suggested below, it would be great if we can separate out the
nested VMX support as well. But there are issues (like the one discussed
in patch 19) that link the L1 guest support with the nested support.

I believe if we separate out the secondary VM-exit controls
infrastructure (L1 and nested - independent of FRED) then it will get
rid of the dependency.

Here's the rough structure I am working towards:

Part 1) Core x86 prep (3 patches)
Part 2) Secondary VM-exit control infra (3-4 patches)
Part 3) FRED guest support (16–18 patches)
Part 4) Nested FRED support (5-7 patches)

Parts 1 and 2 are independent of each other and can be posted and
reviewed in parallel. The selftests can be posted with the relevant
parts if appropriate.

>> Patches  7-19: Virtualize the FRED context and advertise it to userspace
> 
> I think there are a few sub-groups here:
>  (1) patch07-10: Support FRED state context switching
>  (2) patch11-14: Extend event delivery
>  (3) patch15-17: Handle CR4
>  (4) patch18-19: Advertise the feature, etc.
> 


> At glance, (2) looks a little difficult to follow. Patch 13/14 in
> particular appear to mix the FRED support itself with some preparatory
> changes. IIUC, the code is saying everything outside of the
> is_fred_enabled() path has no functional change.
> 

Sure, I'll try to incorporate this.

> Perhaps, the changes outside of is_fred_enabled() could be separated
> out. That would make the actual is_fred_enabled() path easier to follow.
> Also, the part introduces the ABI immediately after adding
> is_fred_enabled(), before showing up the callsite of is_fred_enabled().
> This flow is a bit abrupt.
> 

Yes, I have identified a couple of simplifications to make the flow easier.

> For example, extending kvm_requeue_exception() alone could be one step.
> The next step could add the code under is_fred_enabled(), initially with
> is_fred_enabled() as a placeholder that simply returns false. I think
> that would better highlight which parts are actually FRED-specific and
> why this dynamic check is needed.
> 

I am not sure if the is_fred_enabled() false placeholder would buy us
anything. is_fred_enabled() is expected to be false until the feature is
advertised to guest. But I get the gist - Separating the non
FRED-specific parts would make it easier to follow the FRED-specific ones.

>> Patches 20-25: Extend FRED virtualization to nested VMX
> 
> Since nVMX support comes after exposing the feature, does that also mean
> the series could be partitioned into two parts, one up through the
> advertisement (and tests) and another for nVMX support? Splitting up a
> complex series like this may make review and integration easier going
> forward.
> 

Yes, I am working towards making this possible.

> Thanks,
> Chang

