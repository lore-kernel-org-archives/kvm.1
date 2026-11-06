Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793930455;
	b=t6jXKmLF7UUIlD8DcnugrvdXrlauWNUo2sJOFYOlXHRn5nfHaCod6vyewvvMVuLbJVBX
	 RbK594gjX/VXlW46RBL6TcDdzcwt8jJpncNVNQMxrSSbLkZ/LTigakZDdfKhj8BpldtSV
	 KJs5729zV/52A8i7VtLN6O7iNfapuZAK+W4BUrbq7Ysvmbu4DtezIXFGxFyJs0MH0dhuM
	 smQJ4wakX5CfLZQ8+s/LmvciU7fsICl8qJO/U/G/VMi69TBST5k1Q8j3NLi9V63t4a3zl
	 gnaH5jmReEbFOciK3QkgG8nj45a4VqAGbUcL+eRSBQ7GYIJiIzlbkhRNVZ6CK1WKVNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930455;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=W68Rzb1ibsbAQiOFlMS5gqbWeuOiY08lQAqDEAWYOsQ=;
	b=BAQJthhO9/ph2ZISDQu2n6BC1u1CpYXMIM6bsGX15fNCw1Y1BumZkvjP8sxK9KUK/Nqy
	 162RKqhAf3QzBIEozZXK0kmXONja1VXt9fo6o7VuXBgEKsA4Hpxzb/q+c+mSROX+y9XBD
	 YPtnZfoT1jHCTG57AUI82KG32BTvnU+ZeTZzxGnCW1YqUffdGj/EHTkEMbQvng/fgjVdQ
	 cnyGPHp9bAGLlY0wSWS3ozNoi/IA2INrmDDKzJ9FgnpZTKPFiha2lTXnH2Jc8S630qvxk
	 Z6gGwRHe1e70eSPb8G9uCeapIs8PK+DnCe85wTNDTibCEuBpx3AgzxCNr3iuPO1OfNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dZ3vGgzj;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A36C606A337
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 02:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A36C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dZ3vGgzj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793930454; x=1825466454;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wZ0QIXI05LMMyTuRLWQcuZ5shGuXrHiJ5/kLY7tstkI=;
  b=dZ3vGgzjNWVmouUS7I22YO06MGPJ7uOrXhEO7Wk9h6vPuMlH4kb/ACSZ
   81hHBQ5qQGZjTWFzx5ouTYrPV3pFDKiUo/VOJbvXAIyI0v+31oKIC/Q7a
   bG37EmqxtMjVStxKXnvDcVJiMzwCbd6HRNWxus6FOKzcTofYvsOQt/LZb
   quezeZn3yhoRzQ/7/RizbTn3RlwYfRD1ZBStOBcIIuqr2Z6z86RCL1HJT
   M4Wjng/7EiBvUXOr0vpQSLOhwNOzGNpNf45VVyN78OZSuRC9pNfllku0p
   FOSmxIbSuxbJrFBv5oEBr1ThEWNZeaQUsdsnfFgBsg4Ft76tMDw9wsjzb
   A==;
X-CSE-ConnectionGUID: bwLIWCQYRXiJOjm5KbkDng==
X-CSE-MsgGUID: yOeBJUrSQEu0xxIqHDzPAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2779232"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2779232"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 18:00:53 -0800
X-CSE-ConnectionGUID: 6arZxG4fS3Cvh6gr0yJrAg==
X-CSE-MsgGUID: JxEoFfz9RgWOfyEu6mlb/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7485123"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 18:00:52 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:00:51 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 18:00:51 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:00:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCWBbWQ3bxC9KkzMInw/HHRpU0e5kJ1G0Z8s85gP+sTe9h4HrGOQ2YZqlQeeTCIj63qHJfmowDdbfFWrMu6WS26LQUBMnxn3Ffjr71Kviy5k+4dfVZ2rwkMPTI7RS4Ln8yTFvWdCasFIMIaBmQ6CypCJgQa707T6tMUbNH+JI3Vb3ppdt83u3qUS/gREIGyjuHMe6YiOltSdNU1fWGBBxZ1HhM/pNaQCm7kMKwm3AAQdYkr+IpCroOoF5A663XxqSxUuXM1rCM70bEgJpOdqvVbKmmFbVLqhjuOGig9PXiMxxNr9BEJPrDGR0nlwt/LihFLqmoN02A1N68DJkhisWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W68Rzb1ibsbAQiOFlMS5gqbWeuOiY08lQAqDEAWYOsQ=;
 b=zEio2ayG/hetVjR6etFSeq0SVOtHu/jAEalsX4MUVLJloyBajv/J9M0IBzrkeRklGoV/J8CnphaldE9elW5jizv+fLcUMSwm9AvSsfWsqbiezl5qCWuboEqdxWiCjknDN9Sll5OSh/fuJQ7/67WG9pYNXbSRLM7nY2zN+InuZmzLYfHFuSAyxeJT+aJf++w7VqkdFYq2vgoTVVC2wf62Fq1+DnGPiv+k7GPORWmV9pN6pQ6AEZdv5wJ/tjW4sK50BIQruVKbbKW1NrBgSbm3QkwZnKU0xUMurBVhlmRR9bW/S8tE87DL8RU5E3wGXGARW9pw4fpv5PyTNXiTggFmcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF5CBB3CBCE.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::82d) by CY8PR11MB7107.namprd11.prod.outlook.com
 (2603:10b6:930:51::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Fri, 6 Nov 2026
 02:00:44 +0000
Received: from SJ5PPF5CBB3CBCE.namprd11.prod.outlook.com
 ([fe80::3937:e6d:c0f4:8918]) by SJ5PPF5CBB3CBCE.namprd11.prod.outlook.com
 ([fe80::3937:e6d:c0f4:8918%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 02:00:44 +0000
Message-ID: <c77156d1-5a47-4a93-a18b-392081fad3ff@intel.com>
Date: Thu, 5 Nov 2026 18:00:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: TDX migration model
To: "Serge E. Hallyn" <serge@hallyn.com>, Artem Bityutskiy
	<dedekind1@gmail.com>
CC: "Serge Hallyn (AMD)" <sergeh@kernel.org>, Peter Xu <peterx@redhat.com>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Fabiano Rosas
	<farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>, Pankaj Gupta
	<pankaj.gupta@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Marc Zyngier
	<maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Steven Price
	<steven.price@arm.com>, Anup Patel <anup@brainfault.org>, Samuel Ortiz
	<sameo@rivosinc.com>, =?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?=
	<jakub.ruzicka@matfyz.cz>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>, Elena Reshetova
	<elena.reshetova@intel.com>, Kai Huang <kai.huang@intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Peter Fang <peter.fang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	"Xu Yilun" <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>,
	<David.Kaplan@amd.com>, <Mathias.Brossard@arm.com>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f4f34bc3dd22c0e47b5ee764b1a4db8940cbbbec.camel@gmail.com>
 <auyZnIfxMnxYD8rT@shallyn-amd>
 <85f899cd277b2188cd4b33f8f21b206fa2ff6f6f.camel@gmail.com>
 <auyx8C67zCnbPpuL@hallyn.com>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <auyx8C67zCnbPpuL@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::27) To SJ5PPF5CBB3CBCE.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::82d)
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
X-MS-TrafficTypeDiagnostic: SJ5PPF5CBB3CBCE:EE_|CY8PR11MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e911c9-9f66-4405-befc-08df3ba9c456
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|56012099006|4143699003|261026140227099003|261022105027099003|10067099003|11063799006|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5xd9j7QGo/JVXJnlyYYsyIkRRjJ8cfVZ6lCZkJq1GTQQfVadhk4yP8DXKluAOH1pOiDXMpKzcgMhq8xeRrxahNohiwgQW+z6kb/2ASBGJHycWmzQ3udA/tSvVTnzMpkfu65S6zF2xaLRaf+A9z8LCAkmQO3McjsLpgO77ZTsCvZEVx8wU8yzTgSQ/1tQlgR9VekNJoQhNHXu5n8D1Wyn8jFP5jbNyBQ9CpM4sG+2IZYYz2lvblEUHe7pzredz6ZHTjLgqplG2P014a3QXxHrBdDmETZKEPZKsCc4/ifiOltWo2b0ndjxuLPIfIXuAo7nZRG+Hap2sWPJqsH7HJ39otU8mRXTOaLmFHh6WgDJHxEp+9Tn3BGqyROjnNtWmI3kxQyVp5zYzsFDUDjppIFpBRwkcleNlgywtN5ONdt8Sk2F6oFl6HmQvKpSSNM/WpV078bdNQV7SrQId4iZTPfhKylzCxvcL9lLJuzwFtnPe73rS0x58hamJptCGli9BPPMhrslm6uC2HZeK1rd2YRxIlMrqWxttuTa47G2Iq//Z//FZw2vqazzZGXqwbQ4usYpORAAeoUJ32Vnt+Vtn9gi5kC8ueBRtOABbuZTRjqcWsblsIUEyPU52Fc5Z+t5jdQrhg0+dXRdv1HLtDWmj82BrikSNIDLxqiuQyTcvuNmLHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF5CBB3CBCE.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(56012099006)(4143699003)(261026140227099003)(261022105027099003)(10067099003)(11063799006)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YThIWG5oS3JmZERlRUdqVGJKb2MxMUtNMlFBUFRmS3BXenFTWGplQWZGMVdy?=
 =?utf-8?B?OVVpeGZMR1pMSjFEUVpsTXZJaXRZcWpEL2p4R21yNys3Z0pWSjZlbU9aRGdn?=
 =?utf-8?B?cHRaNFplUlFRQTQzVG5hVzBVczJUZDFveTBPVjdMR21FOUtrOGtvU1oxWVdt?=
 =?utf-8?B?NzY2L0lqV0o4S3R6VlFKQmtLNXBENUZlTDZRZ3dhdnFRVHRRR0Y3N0hCUnVx?=
 =?utf-8?B?aXlIeDM3YkxaSWM1OWpGekpoNnNyaTBML3kweklDeHZsNDlZUXRDelhFb0Ev?=
 =?utf-8?B?dVdRUlE1b01nNlhPSUE5SWFzcllVOVdsdDZ4bjYwbXdSQ0paR2RNbS80WmQy?=
 =?utf-8?B?VmxreHcreXUzL0p3aUluTjJ6SEFxV1A3STExc2NXNjVVVXRtOTB5cXF5bHU3?=
 =?utf-8?B?akhRa1NabC9Peit3c09rUUJrZDZNa0hGR3M5eVI2OERtS1VkZklMZHNHV08r?=
 =?utf-8?B?WWNNU1FqRS9adng2ejBVb2phZTR4b1RTTjgyelRkeVQvUmFwU3dXMVd2WXVF?=
 =?utf-8?B?T2dLQTJ5TlZYK1g4cVM3WXBJSkNpZlBpckd5RzBrZEF6bWhXclZsc1pGZ1Jt?=
 =?utf-8?B?eExPYzVGV2Y4S0VpZTlTeGRzallhRHdwWVcrdXd1Um12SW9IWW05enFhL2I0?=
 =?utf-8?B?SWRsUlJ1UXo5RFE5VWl5ajdyNzBWUmhDNlNuZE5pN29rZlhHbE9KbnpobTVs?=
 =?utf-8?B?M2V1aVFmUUN2Wlk3a3hqaXMxd2JNeGRBSjl0SVZUeW9XbjF1SVo5eEJlWUxj?=
 =?utf-8?B?aGsrVXJKNHpBeWhkdHlDdzFjQWZXTFBkd3NORW1KaTVSYzJKMjJRQ3NCbmh4?=
 =?utf-8?B?LzBvWitnKzF6VzdOVW1nZU5CaDB5RXpMd1ozUkdUNHdrVlhMWlcySFpmZVN4?=
 =?utf-8?B?L3B6Q2hibnhueVNRbm05aXRWK2hwdU0xNFFjUkJaR1dkcXdzcFVQZ0hqODFP?=
 =?utf-8?B?LytFTEpENWxRcmdoWlM1dmxHY2NIZTBqOFNZNGZyaFVETDJEelIzekQ4NGRa?=
 =?utf-8?B?M3ZmakptT2pQWTJjanh5VzdvdUdGdkdQRC8wWTA3UWdwVlVHT1Z3M3FtcWxM?=
 =?utf-8?B?RmIwclpsTmNkWi9wM1NoZnhOUWpEekF2V0pXNFl3Uzd4THpZaDBDVFdBajE2?=
 =?utf-8?B?cE5wc0hvU2llNXNCdm5jR3RCdEtuWmVQUjllTTdmK2ZXNzhxUzcyZklPeDhG?=
 =?utf-8?B?YmFqL21zM082c2lsT2JPQkcxenA4RkR5SzZWNmlhOXdva1k3Nk5nZ2RuRWtI?=
 =?utf-8?B?SC83VC80eUk4SU5DUnhySDVkRUp4WkF2VGJwUzdVaWZzWmJubUxoeDNuYnlC?=
 =?utf-8?B?SmVtaUt5czVBcFFpd1RueWlVclk3bDNWay81aGMxRmpxQU52MEdPcGo3MkVo?=
 =?utf-8?B?Nm82SlB0REkvTTh1UjgrUkZxYUQwVTgwS2NKbFg2QUY4L0h2V2Yxb3ZtWXhs?=
 =?utf-8?B?M0Z6ZUFVcDgwdkR3WHhRU1A2MS8rWWF5eUxYdDN0cURRMmwzY2FKaGYvb1VL?=
 =?utf-8?B?S0J1TGJIU1FtMkNvSk81SEtPRVRFTmduQnNRWVVvOU1QV1gvZElaS3N1ZnNP?=
 =?utf-8?B?Skx6cyt5YzI0RXFhTEdOMUlJc2NZRjRFVDUyZmpPWXhMRVpqZ1NUYk1qZndX?=
 =?utf-8?B?Mjd6L1pzV1JhdVIrNDJkQmJObndqNVQxaSsyWE1ydGFnS0UwR2RaYkxKNXBP?=
 =?utf-8?B?RUEwQ3R3VnJrY3IyeWhLZElVam1mTEJJdDBzKzNsYjBENUQ0akdWS2F4WEYv?=
 =?utf-8?B?Yk5OTlBtdWJyVFBrN1ZTRjlycmxSS0Zvc1h4OUwwK2Zvc1Bya0dCak54OGFz?=
 =?utf-8?B?aEg0WkFCNUVxaHJuY3huV2hkbnNBc0FGRTFvdDNIVWV6SnZBcTVVUFdCZ3RF?=
 =?utf-8?B?QTd3ME8zQ2MrcHhIbVBaWWdCS0M0cmdwVGdldTFVeVUreUFSWVJHQm92SUNv?=
 =?utf-8?B?czduSDJSVFdPckNsS3dMTzNTTi9CdU1ScTRTd0NjY2dWNU53ZUgvWWZ1UGx6?=
 =?utf-8?B?MWlJalBsSTNCUjVweUVuUFByTHcvOTByb3VPMDZ0MmxrMzVVcWsyMkgrNzVj?=
 =?utf-8?B?UC8yMWZ4eFBhUlV6M0E4dFNnVXhFQkUzQU5yYzE4QWhIZHRxWkJOLzdPdFdy?=
 =?utf-8?B?a08yVGMyWHdkcXNrcjNENTJXUHJpMEFvUkJRSmFBcnIvVEY2Q3NmZWtCQk43?=
 =?utf-8?B?em53KzJYVEh5b2ZwT0U4UEVqSkZYdFBVVWlKdm9aTHUyUmtwbXBiWTB0NWJi?=
 =?utf-8?B?VFJmazhVS0FOTEJYVXh3ay9rRmlDRlBzOVVEeGNSKzA0cHYrdEVkVm1lV2h5?=
 =?utf-8?B?RU8wT1gxNDNkTmdmNVRoaFdPeHAvUHh1WGk4SnZPV2hXYzQ3SE0zUT09?=
X-Exchange-RoutingPolicyChecked: fj+T1BC6nPRJpj5B2Qt8hKtFhbmeubi4zLa7u6FUN6dbBXcsd0mxIIWh893HXt+BYLT3nyBPx/zOxtNHKOQ8n94D6P0QAvrb5EoWxr7sTnAQI3MPXJKoQQ8DiRiFJeZat2OCkigvQb9wVAntzH1pdFlPi6AL3mF4snpuEVbNhZUuumLzfJ3EUx1Gu92vERZUO9EsBZNPYYmvtCTRt72ieL7WD1rb+THXxvkljgCek6mUDUGmkMbnlpBiE94GnwYiSixtZkpgwRJLQc9XVEoW0aDeudWwf2ltJSQ8hA9K7p9pjcxXhIszH94AoJ3GsaweTR9vFHYbrJ8S4LgQYZeKmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e911c9-9f66-4405-befc-08df3ba9c456
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF5CBB3CBCE.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 02:00:44.1318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBQNyGMnfZ4Ct5U3Tzrq3kBwdB0fX4vL6Zj7xYWzNYVcUYsJRCbc10gTxSGfIthKNASU1Ah/wzI8jX0RT4BCzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
X-OriginatorOrg: intel.com

On 11/5/26 8:42 AM, Serge E. Hallyn wrote:
> On Thu, Nov 05, 2026 at 05:59:01PM +0200, Artem Bityutskiy wrote:
>> On Thu, 2026-11-05 at 08:58 -0600, Serge Hallyn (AMD) wrote:
>>> ...
>>> So, looking at the section '### How the Setup Session Works', is it safe
>>> to assume that you are using the qemu migration fd for the message
>>> transfers?  So basically qemu loops over KVM_MIGRATE_SETUP calls, which
>>> ...
>> Yes, that's the flow. I’m not sure about the migration fd part, I believe we
>> pass the setup session data via ioctl buffers. I am sure Kishen will can
>> clarify.
> 
> If you mean pass via ioctl buffers from tdx->kvm-> back to qemu, which passes
> it over the migration fd to the other side, then that's what I expected.
> Othewise I'll be interested to the details :)

Hi Serge,

Your understanding is right. Migration setup requires a handshake of some sort
between the source and destination. So the messages KVM_MIGRATE_SETUP returns
are transferred over QEMU's migration channel to the other side and processed
by a matching call.
