Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793123041;
	b=pI1K2upPTl7+AvAj1KmimJT2z+8SlbwCXCCVl8tSyE97690LsO1lQLkMHEG/z4FVL2SG
	 zJ32Aa0ZKnRT9G1ta4TRPzAXZMo82kz6PptrqqyC58sBOG1I8fubZ3aAl/lbmI5oJ+r95
	 q8qHB7Kp5JGQjzKK2Q5H5jFV+inZlRIV0guP9dWafEocziTsvHvvACPD1700iyNPhT7pa
	 u6n4Yb3pNMlr7h/++OxIKgw8W5ZiDe5IMiXPjGE5JuQrziAruKKudOz1A6x1zV13YGg1M
	 Xxld5YyZN2jj4qMt8bO337dxoFJkKA24ukvOD1f2CmAfm97KUyiSDARgThd9zwn6Okw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123041;
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
	bh=yQ3frfMHO5bKT4JF1Uzsxmo6rVgofRoU3YtNxoRuz5M=;
	b=JzspzJZUk6ydV9DN507k87tPEL/Jssra5wsP6UhrDwumNtFZgVRNbEFp+khhfhhOWlyt
	 fdPX0jT/ed5GsW3QqJl1ZIc6WSDfVNz05GhVy2QMtpleFvZC8tf7dv5qZKMbWgb2i2faz
	 wxiyHMYcJVC+VEK+UDAvFOQ7RhGMkI31OQJfu+am6cNx1iUPoa3OG8RZ2lQHvVHb8TCq2
	 y8loRyhUnsuXMx9TpXJBwJvPfmnU8PgojQtERF9aajl+oR0q1F3Eg9Imok0/CPKJp6O0Y
	 Fv8gcCo8LJKQJyXL1AksLvA6/RPlS5nWXiLXQ8UqXd9Xun4vCykVslU0DbmleMRBejg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wauqosbf;
	arc=fail smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98000606A31A;
	Tue, 27 Oct 2026 17:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98000606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wauqosbf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793123041; x=1824659041;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WyJeRXSJ85G8yg7mWT5e+IZNKY4ZYUBYzGi1HePg0Sw=;
  b=WauqosbfFLRRQO9ns5FYxmzdTMbyB3wp4RiRjU9sG0HJoBj6IUCgzOjc
   3dzwPYG17W2fmDchv3ps8LxTP14/wV+H99c1I1ZcFivFzUsj0ugAr1d30
   Xd8r62nEhibZyPhLQ3cKIRtbFF1j9tvLvb3o7HGyzeWHu7ckpkNQNG9Q5
   9UkO+X3i40UFb6tO3U/cDvA7TJ7j+/MIEUPgjVLfBUoSgBNWf5hX0MKde
   vS4u44vKola52Zf/Vi72YAdcyzV7K0AM9hDOwIJhJ4M8C63IltJD2OmgD
   1G7PP7Th/EY7JOF4YjuTtKJm06+Tzb6EtYZJcwnMbPCoO/B7PEPX6iH2e
   w==;
X-CSE-ConnectionGUID: dmDExHrdRlimAryu1xtRZw==
X-CSE-MsgGUID: zIMPbZflRdORjTrXvqVV6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1845453"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1845453"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 10:44:00 -0700
X-CSE-ConnectionGUID: EZQ2qfDkQEyya0rkAa5XlA==
X-CSE-MsgGUID: mI1AwOCDSRavLPCMXfbYsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4608633"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 10:43:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 10:43:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 10:43:59 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 10:43:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sj6yxuno6R1Q2f+kRGQYiD7wdqhPFX4Lrl3K+IwLTeSHsSHIOWyDisH6I2xaO+zSL50mKZWGm2tpqJIMhL7Z0ESdF9n5aLN7Ejx682aA9G+Br5HsHSrl+MGJ+3pIeMlDt3DpOGNHfVz7Vytl5tcpGx3P/XXc0FezWvNO7xbhUBzNNnx/FBPZQ5j+gubHfjJsXJTllaJxycspOU95IzjbmVkmE8m1e48pLn0A5vX1OqfIpH4V6SIbX6id+CsKPU6t/qd/0ewUrLRWN45bDa92Uw/kkW/X3WWeJCcZdpcBvpbYEM2FP1IOmmlVkIoGZHksR3RBZuxQlIwkTV4iBXZIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ3frfMHO5bKT4JF1Uzsxmo6rVgofRoU3YtNxoRuz5M=;
 b=SurQl5TgnlR/oPc6uFDItyIpjCJlcjPnjlPAg21R8emios5Q4dtyjtunzMcFY9wMKapgAgR0W8myRvQCvggS2SkUaBY/5R7edU+tqsXT0sxpSzBqtw6ESHGl7vw1KU4G9QmayNJKOf0sbCKrNm+ZKa6qgnUbp1vb2HEhlh/xOKqksXSqHRhcbsTi6nrEYmNs9akCz3cqwDm47wLH1yBzuuBGaKR02tBD6fXQ9nmhVWc2fufZKeHQ6JoRgDcD5B4xva6Oq2XMUXxE5qyUMJ4lC+umHTaLo/iGZe7Jjlh6K75XN0lM4B8ho0HgtKZ9ajD7j8YV3nQmA6Yw943zZTrf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by SA3PR11MB7434.namprd11.prod.outlook.com (2603:10b6:806:306::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 17:43:54 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 17:43:54 +0000
Message-ID: <92a58644-8251-4796-aa8e-2117f53ec86d@intel.com>
Date: Tue, 27 Oct 2026 10:43:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/28] KVM: Enable FRED support with KVM VMX
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
CC: Xin Li <xin@zytor.com>, <kvm@vger.kernel.org>, <x86@kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed
	<yosry@kernel.org>, David Matlack <dmatlack@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <E7D55C5F-91DF-45AC-BCC8-BD2759CEE0C4@zytor.com>
 <9467c7b6-d797-4462-bee1-1406bb8469cd@zytor.com>
 <at96Aex_dl8-yUk6@google.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <at96Aex_dl8-yUk6@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::9) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|SA3PR11MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: efc8b9f3-926f-4686-9d3c-08df3451de90
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|261026121527099003|4143699003|56012099006|11063799006|261022105027099003|261021123027099003|10067099003|261021121427099003|22082099003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 5b80IJGrrdXnwpnGuCL3rHYqObl1+8fdKysM0U6MKAfUPwgMi7j/rZ7acqDsx4SMNnzpFKf0uUZ43clKu5sW49YnUFSvMYQ9MzpKToVCRoZAmqQ9n2F2u0RHkvK30a8P2ufMpkH92fZicgD0GhrQB8hJgpQMmGTOQznwMjbpQLoO2P40mqzWUKXIgl1v5xGLCJwUJDoGVvBetJMSMHlBwUgod8fP/PPfr1sUL6Z38GLHjJ8HZYgB/B8QDqJsm5qvrDDH0UlcXg89iuPO/2+ZGDiwDJ6wmq7e1k9E+EMWzeTbnVAyKuMGMpwzyMLaRkFIkMOS2KcfRW5XGUoQCZ5TnQvR6IU9FemtwsPOW57JjMjrCc6FXykuINuc1++d/xLDV0fDfnbCNfqLTk7YmZbz3+QOOZEVgN/LCckGWcNbFFmRDMLGDM7ScruJMengTqkpnwv4pfoAge/UsB0fxosWXG2ubLuYMu4y7H2HrlmoxlVFyK85raSIwyy++05KWSJUkVZnbQ+i1uIK2AwVZUMY5lgs05Va/QoBsAhL8SnZRQn0L+2Wu8ZngkofseNPvEMNyX6oXQSyDCYK1PtGpgVUm48DHS/DECtcbeB+LCF2osJANknNkk0JBiJbwsBzMa6kEUYzuKgUOJ6lIyyKYJW9aGIz/e1wLq6YXQJvTzbFZPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(261026121527099003)(4143699003)(56012099006)(11063799006)(261022105027099003)(261021123027099003)(10067099003)(261021121427099003)(22082099003)(18002099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXpEdm05Z3duLy9IcEF2Q3NLcXl4WUd4R2V5MEZZRllXVk1lUUl2NisrZzJZ?=
 =?utf-8?B?dDltTlI3RnRVSWs4Q1prZG1ScldKU0JkWjR1SVFnRHN0U1JxbmFQSW45ckYx?=
 =?utf-8?B?T2ZiQmlqZmtqZ1dhUUk0OE93ZUFvMUY3T0xSTGczdFVjczE1SjVsaGF5OFA0?=
 =?utf-8?B?ZVBDN0k5NURQMDVFcCtjWmVCN0JqRTJkWjRCbWdkd3dnM3UzRkRYUkRRNkxW?=
 =?utf-8?B?WUVGdTBtRHZCejcrcW1BSHcyMTZwZGxueCtRek5Xb01OMUJiWFB4R3R6L1U4?=
 =?utf-8?B?N0kvcFJmS2VBN2hnMkJRSThvekQrWXRYUEhIandHY0x6amJkNVZWRWlJTURY?=
 =?utf-8?B?OUpUbEJ2VEs0bFJVMkJsL042dTdBcHZtc1hZYWJvK0llcW1RV2FtUEFhOXJT?=
 =?utf-8?B?QzNDUU5KbmdIMFQzNjNOaUQxRjFDTlgxNm1ITTNvTm1KZHZRN2ZKemFNQzZQ?=
 =?utf-8?B?YllMaHJqTTZyZFpwOUFsQ0lDamZxd3JYR1A3VGdaVFBJZHU0em5GYXZHTWJE?=
 =?utf-8?B?Qm8xc1pZQ3NEdyt5Mk9MYWZaNFZSN0FkbmxtR2ZJUGhPNkNMeW00eDBPODVk?=
 =?utf-8?B?cjRFWHVIcnpxL2VDRHhWL0grNWpBMHl5N1lmeld0REU4K1pDSytDc0JzaW5P?=
 =?utf-8?B?OHNYaFVMODRKTlJGeGNBenNkRDJ0U0xraUZqVnM1bUlCWGo2ZE5iUzgwSk11?=
 =?utf-8?B?MkFvU1phMGE5MjJ4Qitjc2t2OWhZNVNEY3BCbnhqSDhCY0J6UmUxOHhhWTBX?=
 =?utf-8?B?Nm5hTWNYb2JWbEwrbWtJVXRRZDJlbUpBaHJnRFJxd1hiaVdtZW5mNWpBM2JB?=
 =?utf-8?B?TDFtN1RPeWRyM3BCZ1JRb1REcXNGRUtzeDQ3cU5WR2Y0NzI2eTRpNERsdERY?=
 =?utf-8?B?RzVPRjJxbnlpdy9nRGU4TDhIR0JrczMwZkVTd0JLVFNSQkw4eGF2K1ptbkN6?=
 =?utf-8?B?NEUwSkRrbjN2WFN1K2dKLytJWlpCUXdHMy9hampZQTVYN3BUQlpuZVcwMGNs?=
 =?utf-8?B?R2c1Zk5HZ3VZNE04Q2U2MFBpeGVJRU9IYTN5NHYyOWhZZGxoQ2htK21FTmhV?=
 =?utf-8?B?RlZqK1JISzJQcXpTNXNnQVlJTGtzWEhQYm1qTkpBRm1ld09QUHBuZmtTeHZY?=
 =?utf-8?B?RkVzZDd2bExiZE40c1pFMW9SZmRLVzlrbkhNSi9TbkhxUVZiM20rL2hGc0lm?=
 =?utf-8?B?MDN0TGFaT21zRGwyMTJrQWpWWk15cWZZcFB6THAydi8yalJtSVZRWlI5bk1t?=
 =?utf-8?B?RFA1NU5qUUJPcXJCY09QR0pQYmRXVjJiZFZYR05TUDFMSXp0YXBhUGo2bTQ5?=
 =?utf-8?B?UnZqeG5ndmJTNTlWVW12dDE3WjRiaFFyYnYyRnh4bE84QlNTbnlkT0h2WE1F?=
 =?utf-8?B?OGQ4TkR6RGw5ZnZtMGk0eUsvVGFEN09OYytXbWhRVEN4QUEzbm1STWJjajRs?=
 =?utf-8?B?QlhOZFMvekpyd2grWVEzbWZjRVVxTmJYcnZjeTRKdUxXR3M0aU1idWkvMVFv?=
 =?utf-8?B?OVNzNllIdjd2cHhIKzhRUkNJc0cyN1NSNDdicFpZR3haSmVTR2V0OXdoYWxJ?=
 =?utf-8?B?eFpyTkxCYTRxalNkTnhidGJheTI5R3lyRXJ3K2lJQjJOQ09QNlhvU25PQkZZ?=
 =?utf-8?B?QXBlTjd3c3FESWVFRnM3WVNwK0xVL0RxbUt1MGpHVlJzVkNEVFFxaWV2VGNw?=
 =?utf-8?B?Y0UzWk1jR2NZZzBsck1ZWVR5ZzVZRkpxZUI3VzZ3aC9kQjJDeS8vUmNMWmNB?=
 =?utf-8?B?RjNqQmRReTZPbTNjdUp5VkJKNWwxNFRUUk83V1RHdXByRUdzT3hXYnR1UE8v?=
 =?utf-8?B?WFcrNGdvcmE5cWYyeXhFUlE5TzFvV0hHY0gzKzF5L2I1Y3hWY3lKLy9PYlh2?=
 =?utf-8?B?aklmblhtdnVvMGV2dXQrNkpTSGhzQjZRRnpFVU5LUnd6QjExUTU1bDRSTXpm?=
 =?utf-8?B?ZmQyQVNXdDlNUXZoekRKYUFucVMwWTB1VVhQTmtQNDN2dmNPS29zUjZGZEFv?=
 =?utf-8?B?d3Z0SThQUHhiamFpQmJENktwNFFhSkUzaFRkUWh4ZWFtaWU4TlpjMEFLQ1h0?=
 =?utf-8?B?bGl1RDZLREVtVXRZbGFhMjc0aHFjaUJ2Si9TN01XTUlBUXVOR2tOVFhPOWd2?=
 =?utf-8?B?TTlMVjFmaU9OcXlLeGhVNm1HNlRMRDJaVFBqTHNYMnM0VHJvS0VHbU8zcXF6?=
 =?utf-8?B?Sm9hOGc2engxTUxMRTdvdkVUTWdKcCtLL09mM282Q1oxcStJL0E5VzRrNXl3?=
 =?utf-8?B?OGRDVG5mVHkxcFRoRG5ib3JIV1YwRVQyQVdNVDQzT3FSa1B4eU56SWZRMEcy?=
 =?utf-8?B?eWJVZlVNN2dqalFQNGxsMWs2MDFOVWtoaFpmS3J4RjJENnlGQU1hUT09?=
X-Exchange-RoutingPolicyChecked: wfk1oObrjcb89w0rRWzvTD+HWw6udq1Y4S+zXLoNPhw5n+PbH0jW2GK7JujBk3ge2vIzkpjW0r40mbohsn0VPqEe7+DKBzNNTMIa4XTDbpJtW1OKIqv3B77g89yNpzjyTWSp/mZVfJZzrxl4H0CGvJOkdl0DhlM+vg2pi7UaxdRPVWVm9CoIYG7REna/rLBAVDruQ2TRH+dQtEi0f4fnAFnXfNbbDxgLh4PIQbQ2goqPJJkoZbRJGus5gnwuiScldG//IxLJwXKc8ZwXZLnc2hmEm6DIscQEV1Bf4VR9oscIc1fmnb6fFkNiuJIFTvTAtSYuIu3zHYPekabU9xrmEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: efc8b9f3-926f-4686-9d3c-08df3451de90
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 17:43:54.2477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVy+37yx0BCm9hr1Otj6P1RrgCHqANfAEZZGKdcFQX5a8JRlstGR1L75PlYuvwFc5+tVi1glZQS8pI51RiEF4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7434
X-OriginatorOrg: intel.com


> From: Sean Christopherson <seanjc@google.com>
> Date: Mon, 26 Oct 2026 07:37:03 -0700
> Subject: [PATCH] KVM: x86: Don't bother loading host values for SYSCALL MSRs
>  when FRED is in use
> 
> Elide the WRMSRs for the SYSCALL MSRs when returning to userspace if FRED
> is in use, in which case said MSRs are never actually used in Linux.
> 
> Note, KVM never saves/restores MSR_CSTAR via the user-return MSR mechanism,
> as the MSR is unused by Intel/VMX hardware, and SVM unconditionally context
> switches the MSR via a dedicated VMCB field (along with all other SYSCALL
> MSRs).  Include MSR_CSTAR to provide a contiguous range of values in the
> case statements, e.g. so that the compiler can optimize the case statements
> into a simple bounds checks.
> 

Sean, I assume you will post this separately. I don't think it depends
on anything in this series. Please let me know if you want me to do
anything additional here.

> Suggested-by: Xin Li (Intel) <xin@zytor.com>

BTW, Xin no longer works at Intel. For any of his *new* contributions to
the kernel, he has been using:

	Xin Li <xin@zytor.com>


> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/msrs.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
>
