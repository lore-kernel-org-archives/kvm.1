Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793135725;
	b=K9g2tCpPBuz9UpegZn19LivuGzwWcU2yRi5aFqOH913wTY5yCeBT7wxf3sg8Msi3ag3i
	 GenR1YtHak1FIDM/Lr1GXp90QDvvbJZmkLNeMZ+UfqpuWSRjztS02T4UI3pTj3QuVLSLh
	 Z44DBc1rFCxySTtnuoVVYrDPol15KbFW9cx4yGR1CTWaMp/ceD/A2sPtM05y85sIdJDen
	 7QTL/jRSoSF3hThn4kOFaKIBUa3QmaQMcQiO6Q95L20ekFgzHGXdHxDkfOWOhIcopipJD
	 xSEbmBPEFvEsmR4i35thbbOUCRyJRYBP+TTcExXxTTT3u0h3j3U66wLXCj18ZHQouAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135725;
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
	bh=RDzBP5MP5wwtOoqmFoA4KHJ0hZMvJ5CVIVu4w3meH+I=;
	b=wYOH5AnC5vhYpzBCqptW3TVyPAjir5tKcv656ZTzqNU2EctvjGVOPvr3iSmk0uuHTpky
	 y+OHmHf1Z8hp7Fyn09wbpDA/xvTvKC98KEJgWDtt3xP7HmdJJPpSTEYJhBcSAXcVsNtF4
	 pfRPlcT2rpfEdsRkUY8Phkt+I/aX3iaoWcCxF20Mta8k3tw6l6+YgXEFdLIPNjipMF+hn
	 vs/vAuUruelO9utvsLZWuY5PhDc9EhFJ4Dq3ZXHjT+mtNH2tppMIuZSbHkOYBHUlm+n1u
	 619Mt5QXm8J8pyW2sYG0Qpgfg9PfIDRwC7YTHkK3WJLzifFEhw0w5yHp+sTEwMBeqlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fQlngQtA;
	arc=fail smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D86F606A31D;
	Tue, 27 Oct 2026 21:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D86F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fQlngQtA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793135723; x=1824671723;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zt/woY7IJz7BWXRorZyma7ds8UXbVaDXlRbRDxfha+s=;
  b=fQlngQtAjBnGn/XC+BvmWoikINztk9c4gCymvPkkNYMxvQRxV0bp11TP
   yX9I2ae9B5Gvdy6qMoWuyVOGkmRmGfPO0AzayR1Nutoh8hziQPmSSAnIy
   zB6rW6IK7Y3U4t09IrtETLl0hryfTX4UuJVyrVnxKxGn11uwe9EvFFMLh
   /+G8EnIkgQO2copwzBGagGTxSMEBb3nN9ty3Er0QYAdplt3wLBx8FnGcf
   W2KjnSr24SkO1q37qZMGo3kDXDW0ZSt/ZJjX/1eSD3TxHucJkNuWTHK3A
   mwpZAOnw/DMSbVjtOCRU+sXZSR1FfH9OlF/r7AINWZ/pkCwK7eEtCvUJ/
   g==;
X-CSE-ConnectionGUID: ltkoWt2aQsybP7lIA0zggw==
X-CSE-MsgGUID: jZUvkSWUT1aaOUcyhIZXvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1752121"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1752121"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 14:15:22 -0700
X-CSE-ConnectionGUID: 7isYiE3wRLOx9WXeXk6KqA==
X-CSE-MsgGUID: J88CRSlPS7qGZoZlq7y+1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4647646"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 14:15:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 14:15:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 14:15:21 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 14:15:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8rjnYWCc0k3/TmT597p8vFbi95+bVG+EJ7NEjm4/Pibrw27qPtfwyJZGoUv0T9GQ5L1wsogW+HA+ppRblKfxV+m433S5PFmuFp5CCFjQAUdr5PsC2VPFWU9yWUnBpVN0CAlemFkpDgEs6eyzN9up6xm3IqvHD50GEdaKhpaG400pASLbLHdq6Ze/7gqeVSO0qcYM4IFvwFalij7lBkXp73J44hTOniuGNVPO7b+CNOaOmLe5MrhpcceW0zHPXgxQOBRMOcxVgPNr5/+qyKE8cAtiuSgqkSlS6WPkBTpDuz2zzJHrO4E0T82B3iSTaWs72GFwjSO5J1l4qqfl65uAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDzBP5MP5wwtOoqmFoA4KHJ0hZMvJ5CVIVu4w3meH+I=;
 b=M1gD7CO3zWJOFyxksbmyfta8BTTw2zgZe75OPv+xq56zCq6Z0uCOIt79UD194NFuSFRZEKb5MJkErlwGmONT/IkxoH3k4KAWr29jJVooU+spFYEAnz9VZNATV/qcuJKqM0/pmFg3TIngWwq4Pu11S3VsceQILuu8dHsoo0jyAzI4ujcMtBU2/6d1HwzXU+6ut68Zw4kbUCDAs5+dgQOjkSDWH/4YmjwtkQlYrMpEqH4U9ov5UXHYUHf+X5H5SWQLO63JZI27QdhbEl//E2kDgbV53XelbWIlSDr61U5235MBEEeZpHMU2aioQlgeuzM2OG8aY1XNJUPYTslEFi8j+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by SJ0PR11MB8296.namprd11.prod.outlook.com (2603:10b6:a03:47a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Tue, 27 Oct
 2026 21:15:14 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:15:14 +0000
Message-ID: <1160bdb8-c5a1-47fe-90ed-07dd7a5c7efb@intel.com>
Date: Tue, 27 Oct 2026 14:15:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/28] x86/cea: Use array indexing to simplify
 exception stack access
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>, <kvm@vger.kernel.org>,
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
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>, David Matlack
	<dmatlack@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-6-sohil.mehta@intel.com>
 <64e27c4c-23e1-4539-a812-e81d5f322003@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <64e27c4c-23e1-4539-a812-e81d5f322003@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0148.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::33) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|SJ0PR11MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d1079a-2ac4-4ba6-9250-08df346f6461
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|6133799003|22082099003|18002099003|261026140227099003|10067099003|261026121527099003|56012099006|261022075727099003|11063799006|4143699003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: TYL76Bco4yVuysiu+eLiGgu7Lp7FmNYwA9byw8rtdL46rZhHLz8Cd7V0dptX79x2eGCY+0VKyLJROxFiJ7OFMVbN5iqKNEXM8AW7cuf5WMvufEBckhzwKM+jwSKSnwpyYgEjxfPAzYlU3SGxw6TT/7QSQ7Bod3YaRizX0411DjWUaBExyZC96Rsa5N1ZkxL35k+LXM4wBF1OSLmMqkGveF7bPqkTQ7/5iqSUG0jkxeeWz2xfrVPq2pq7mNTPmT8IyiXtYDNBmtIHAYS8IJYusmwRGeDVB34IvaM5vGqIH9wjiAE6/TpW7QLKY/40a8jJ37nmLEwRM/knwUtVUBNYYlxRbyaVRCZy79P7V+Fc66OvNSq98PewrJ5arGB68qeu6rBVDreeLEsKJFmyer/HtfVpVp/CquTD1Ru2JI2vAC7CImPHHaNfxkCrMHLW0iXiIwlqi0HObIGqhhlhKNAsyP3OUE1ChaWECVjurBedVwsJENEDh3N05jzCp/PmP/ovB0L0UijyCS+8J35atdCdnkKZKkQ7MNUgrVEkKZx7HjyxFguJGB/Cyz+56/NayiMKNuJrToW3lUq4jaKNR4fQazfM+qUNgID6PmeIQ2NPL6IygN+1712BE3y+/EbtowfpzfvxBeroBYxEhEElF3uxkLzef9wP00y3ESZS9FEX5GQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(6133799003)(22082099003)(18002099003)(261026140227099003)(10067099003)(261026121527099003)(56012099006)(261022075727099003)(11063799006)(4143699003)(261021121427099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVVzTGdVRVJ5b2syMXk3SjNBZzFkbEI4MTNEWVlmSEx2SkhKQ0lhenNBdjl5?=
 =?utf-8?B?RGRLZ3lYdWNVT1BRUmJYSFRlWDBWMFhXZGZMb1M3aVM3NnFsQlhyS24yMG5E?=
 =?utf-8?B?QzVReE92KzgrbTRMc0pJb2RDN1kwZnhPak5GZDV6MHlURFZyelNPbjcwNWxJ?=
 =?utf-8?B?RUlQSXVxUXNYVHJRdGF3SVhNb3padHNuMmg5Vm1wdzc3M1NmK01ObDZzZGl6?=
 =?utf-8?B?SUwyVTJlQmVTamVvMjQ4Nk9wRDN5M1V2OTc0TnAxTHpzZlBtOUZqZDIzOUdy?=
 =?utf-8?B?VEV5OFBORW0rUDRsVlE1S0lWeXhoeWhzZHFuUVNGOTlOR1ZMM0dYdEFCOEcw?=
 =?utf-8?B?Um40bXMrMmFrUnZtMUFqQnZZZmo4bHowNllKbmF1c1RkSDJsdFNaVkdpZ1Nk?=
 =?utf-8?B?M3Y1OFRRS3ZGM0x1eUFvelpkOGxyRU9QZGtUOVI5dEVuTnYyVnQyQ0pVcTVz?=
 =?utf-8?B?UStNR0I3MUpmRUQzRkhNSUM0Um9MeFZZRW14dkdiMCthay8zSStLeVcwT0M5?=
 =?utf-8?B?SWE3SnZ3MDVsZGM3K2VKT1ladkhHTlJiNGk5Tk0rSVhTQUkvYU4zVWovSjdD?=
 =?utf-8?B?ZnlKRWlVT0lQOWxuenVSa1E0WEpCMTBCcGI5bFZzcUxHWW8rbVVKZEN5bzB0?=
 =?utf-8?B?WUhCWXZDNEttRHRjWVIzakNWZW1Wblc2cjJyMm5ZOFhpU21zcnRzZkZGa0hT?=
 =?utf-8?B?TlZOdFl2NGpXMzdHSkg5UHBnTXpzNmRXYThOeWpJUWxTc0hFMTJNSElQR1Fo?=
 =?utf-8?B?THdtVnFjUXVaSGpvTU5UaW9IaWhEeUkxL2p0UE05a05rMlJrajZYZkRHV3Ni?=
 =?utf-8?B?eHBwSzdWbVEzZHVCaTlJQmxSUTFFTmdCaHF1YW84ZDZMV2hKdWxhb2F1NTlt?=
 =?utf-8?B?RnhHOVUzeGVCQWQzenlYUFllUXBJYjJMUThrMGxCZHFZZE05dks4ZnQveWQx?=
 =?utf-8?B?RFp3YjFRemY4MklIa0R3Ymk1TzZRMXJUWkZLY0ZaM28rQ1Exc0xIY3FmdU10?=
 =?utf-8?B?OVR5WlRZaDhPWlpqbE10cDNDZ1JHLzdqcnlEK0M0eFlML1lOR2FyRVBzYzVG?=
 =?utf-8?B?cVBwOEhqSmVzeHVrcUJLZzJRSDFlUWlmcDd2UzNrb0hjdjJObk5wV3E0TWlG?=
 =?utf-8?B?ZGdzMVp0K3dOcVEycElqSTRkRndvb2hYOEpRcy9aVHFhTlkzdWNwMWJpY2Ja?=
 =?utf-8?B?YlM5R0krRHJTeDFOVTZNcjA3MGF4YzBZL0FlajVHWkQxdWs5dVJTUDIvd0hn?=
 =?utf-8?B?Mnd4bTlkNSt4aWpJb2tOWFQ4cFZvM0JmQmttclBiSGk5WkhEeXBwbUk1UHZU?=
 =?utf-8?B?empNWVJUN2M3dWpOai9KNDQ5NlFVLzQ0SnMwVko0aThNSHhtV3RBREN4UU9x?=
 =?utf-8?B?UmUxL1oycm82VWo2TllORTlCejhwUmQ1K1JzY29la2FzNG51UjVTOVNHK1lr?=
 =?utf-8?B?cXFBcDBGVmU3SWJhdE5Nd1hFNDJQKzI5dHhhZllRZ3JUYkN4UDlZZTA0cC9u?=
 =?utf-8?B?WXVkbUxrZzI1b0piaURGektvNm05R093emdGYXhud05JTzBvQW1IdFlIdU52?=
 =?utf-8?B?TG9yM1lwMFQ3ekNISlhKMmxIeE9aVnEwTHpaM2tvLzd4NHJ2MlBPTkN2QlI3?=
 =?utf-8?B?WngxZkdEQmFqd29MMzBaMzJDTTVBSGJpMkhnTkpLbnovRys2N1VXcUNaaHNq?=
 =?utf-8?B?cWpJZXZVSFV2UVdyN24rM3hGK1NnUDMyVDlYbDZDa092WXJiK204enJBR2x1?=
 =?utf-8?B?VmxCRWJoZ1dpcDJDQThkUnVJeGh1Q0x2YjFNOUE0N3dBN2pXdnhPMlBQN3pY?=
 =?utf-8?B?b0ZLVkVraDJuNE5ibUoyUUpFVTNtTXorZ05QNWNCbUtoc1JUUHlsUnVBUnhD?=
 =?utf-8?B?T29vQ2M3SG9XWE9OdHN4c0t6RXUyVVdRVy9DeWx3eXZWMkkzdW9qcmR3OG01?=
 =?utf-8?B?RGtsZkVWNzJVRS9mdEpOeVFhQTlRMWFZNFl4Q1FSMXRZc1VmZnJZemZxS21B?=
 =?utf-8?B?ZHFLUWFJVHc4Yk5GVldVSk8zTm1VdFpEc1llM1kwTkhrLzRjR2dPb05QaDJD?=
 =?utf-8?B?a01uTVlyS0tlZnd6eDZIK3RQc3BPRURncXk0ZkFqOFFLMElENDJUOWFBYy9F?=
 =?utf-8?B?L2N5SENwb243QjVXWW5EdjAzMi9Rb3pUbDdXMlJqVThhWEpYeDc2UmtiYmtm?=
 =?utf-8?B?L2Rxc01CUDRNRTgrelRWcWVsWStuV2tINnhsbEpVUjM5Y0lXMEZ5OVdpbmNq?=
 =?utf-8?B?QUVmVU5vTDdhZk5UVHVkbFNXQXRyRUJhNnU4czlQa25FSllSTW04M3NoK3Jl?=
 =?utf-8?B?dURaM0RSa2dsclRvcVJHN2JOckxWd090c0dLRm9QK1Y4KzN2MlhFZz09?=
X-Exchange-RoutingPolicyChecked: fnyA4nPgGTsX0IGoW3hzsRWfpVJP4Ui0Icor0iE8fT4yrAUTAOsBTKfaV490fXjo6dK71lOqqbH3ZpjRFzsEglWIwrzetzaLJq6+N4gpTZCBtRgNIaorfzqhsoKT+UpHnVKbBNS9xGhjV9ov+wxQotNRoqG1WPEATuMdYtoRJUAlao8yfU8zV8vPHabLykEXlOXKWhvxhEjN2xUNn3mXwRoA3s6fY4dRxW+Z14xMeXsua2emrsjEjhhcxjJbSnYVwyER1SxS4rjhSMrFBP0BPQbVBiSY37mNZShkB1Hnd3P7fWmAeQE6OfW8zpLep7AQhSgC6RUJH3DLLfmuEleRGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d1079a-2ac4-4ba6-9250-08df346f6461
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:15:14.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpN77GiZkVsXcFj97m5ROEcncmFNZsXHWAay7+gO/dhu5KGNXd4aG+lgFPBWbXgEuQDpTnXLY7bzXZZWv50BKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8296
X-OriginatorOrg: intel.com

On 10/22/2026 11:07 PM, Binbin Wu wrote:
> On 9/12/2026 5:36 AM, Sohil Mehta wrote:
>> From: "Xin Li (Intel)" <xin@zytor.com>
>>
>> Refactor struct cea_exception_stacks to leverage array indexing for
>> exception stack access, improving code clarity and eliminating the
>> need for the ESTACKS_MEMBERS() macro.
>>
>> Convert __this_cpu_ist_{bottom,top}_va() from macros to functions,
>> allowing removal of the now-obsolete CEA_ESTACK_BOT and CEA_ESTACK_TOP
>> macros.
>>
>> Also drop CEA_ESTACK_SIZE, which just duplicated EXCEPTION_STKSZ.
>>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> 

Thanks!

> One nit below.
> 
> [...]>  
>> +/*
>> + * The exception stack ordering in [cea_]exception_stacks
>> + */
>> +enum exception_stack_ordering {
>> +	ESTACK_DF,
>> +	ESTACK_NMI,
>> +	ESTACK_DB,
>> +	ESTACK_MCE,
>> +	ESTACK_VC,
>> +	ESTACK_VC2,
>> +	N_EXCEPTION_STACKS
>> +};
>> +
>>  /* Macro to enforce the same ordering and stack sizes */
> 
> Nit:
> Is this still hold ? ...
> 

You are right. The comment is stale now. Overall, as the changelog says
the ESTACKS_MEMBERS marco itself is redundant.

I am wondering if the remaining single use of ESTACKS_MEMBERS() should
be simplified as follows:

diff --git a/arch/x86/include/asm/cpu_entry_area.h
b/arch/x86/include/asm/cpu_entry_area.h
index 509e52fc3a0f..f34062c7bde1 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -31,21 +31,10 @@ enum exception_stack_ordering {

-/* Macro to enforce the same ordering and stack sizes */
-#define ESTACKS_MEMBERS(guardsize, optional_stack_size)                \
-       char    ESTACK_DF_stack_guard[guardsize];               \
-       char    ESTACK_DF_stack[EXCEPTION_STKSZ];               \
-       char    ESTACK_NMI_stack_guard[guardsize];              \
-       char    ESTACK_NMI_stack[EXCEPTION_STKSZ];              \
-       char    ESTACK_DB_stack_guard[guardsize];               \
-       char    ESTACK_DB_stack[EXCEPTION_STKSZ];               \
-       char    ESTACK_MCE_stack_guard[guardsize];              \
-       char    ESTACK_MCE_stack[EXCEPTION_STKSZ];              \
-       char    ESTACK_VC_stack_guard[guardsize];               \
-       char    ESTACK_VC_stack[optional_stack_size];           \
-       char    ESTACK_VC2_stack_guard[guardsize];              \
-       char    ESTACK_VC2_stack[optional_stack_size];          \
-       char    ESTACK_IST_top_guard[guardsize];                \
-
 /* The exception stacks' physical storage. No guard pages required */
 struct exception_stacks {
-       ESTACKS_MEMBERS(0, VC_EXCEPTION_STKSZ)
+       char    ESTACK_DF_stack[EXCEPTION_STKSZ];
+       char    ESTACK_NMI_stack[EXCEPTION_STKSZ];
+       char    ESTACK_DB_stack[EXCEPTION_STKSZ];
+       char    ESTACK_MCE_stack[EXCEPTION_STKSZ];
+       char    ESTACK_VC_stack[VC_EXCEPTION_STKSZ];
+       char    ESTACK_VC2_stack[VC_EXCEPTION_STKSZ];
 };



>>  #define ESTACKS_MEMBERS(guardsize, optional_stack_size)		\
>>  	char	ESTACK_DF_stack_guard[guardsize];		\
>> @@ -39,37 +52,22 @@ struct exception_stacks {
>>  
>>  /* The effective cpu entry area mapping with guard pages. */
>>  struct cea_exception_stacks {
>> -	ESTACKS_MEMBERS(PAGE_SIZE, EXCEPTION_STKSZ)
>> +	struct {
>> +		char stack_guard[PAGE_SIZE];
>> +		char stack[EXCEPTION_STKSZ];
>> +	} event_stacks[N_EXCEPTION_STACKS];
>> +	char IST_top_guard[PAGE_SIZE];
> 
> ... Before this change, ESTACKS_MEMBERS() is used both in exception_stacks and
> cea_exception_stacks, so ESTACKS_MEMBERS() can enforce the order and stack
> sizes.
> 
> After the change, ESTACKS_MEMBERS() only used in one place, so it doesn't have
> the capability to enforce them.
> 
> The order consistency depends on the consistency b/t ESTACKS_MEMBERS and
> enum exception_stack_ordering now.
> 

IIUC, there is no ordering requirement left to enforce. The mapping is
done per stack by name in cea_map_stack(), right? Also, the size is
already inconsistent due to VC_EXCEPTION_STKSZ being config-dependent.

I think the change in this patch doesn't change any behavior. It only
refactors the macros to improve clarity and converts a couple of them
into functions.

>>  };
> 
> [...]

