Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0414F3E5A07;
	Wed,  8 Jul 2026 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545667; cv=fail; b=AtbNR6ds0cxN7jcMmGRw1ldI8tmQdFawYhOortb/RtzmWQDMr12OEWDTuUY7dXiOiFIGnCXN8EJHJEGN0+TmQI1QdpKEL/WboxF2RyHqRynd7HpzS7hSSZebsixJW2IXeiM/ITLUMNIwdRJRY+Erh23m21h/oS9Q1sNmQbFfwfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545667; c=relaxed/simple;
	bh=gSNWgW7qxakvDM6VKLwbGzTynqi3WBwb5C6Y/TcR3w4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DyMGRCY3APuN1M6J27hYGLWrAoSoKQyc9WOAnE8FTSqjfgy3VlCBepV7gY2p1v/r/g7TrZxMvRzZMcxeEt72lRJTvstgBfVqINK4HrZuWgSdIA1RGIqaLGBP1hzaZNDfscX+jV7gge9Y+b1sg9jZe9wnuHbPFsDNA245e0k94t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRR8TXOG; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRR8TXOG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783545666; x=1815081666;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gSNWgW7qxakvDM6VKLwbGzTynqi3WBwb5C6Y/TcR3w4=;
  b=CRR8TXOGxFBX6GHxK70bL1XfKxRF8nI0cq4CjgJxup3uE/HoK5fwEubZ
   ZRdSSSFkD8UDkFmGaAP15Re3tyapPF3KNtmtrE6G+OE4cub5XQem15cWj
   qepGOrwfpqo5LbLo4baKaVYYCSR5PoBfw6tHMPHdxsjJoc9Az+7BR8QHB
   xu5hFaTx3hCDpoDHpSXe23mXa82nxqhtdGEYDapzeF/EfEc9CLNSWOcsz
   y8DGUy4KfpIfIdp8pLxgsXZkMe+vTLiNYGaLMB+R+ByphpYsk0mXvMWlh
   bqxIdm+iP/b3lnmcp1b3yK2y4nC/f40QXTEz3kuC5sa8EAAFnAH0tJTzs
   Q==;
X-CSE-ConnectionGUID: +Se/I32qQ/6usDwEwHK2rA==
X-CSE-MsgGUID: GG0cSoI5RIiHepVx98OpnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94868749"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94868749"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 14:21:05 -0700
X-CSE-ConnectionGUID: 8WJAMXUOT9eEbwn7lrfuXA==
X-CSE-MsgGUID: SgM28qHSSxy/0v0KjLc/Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277626207"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 14:21:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 14:21:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 14:21:04 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 14:21:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/tsmPGso0gmjzh3aCINA4NxllSIeD3aMoY6AwdAYqiwBQEIV2Ob/nk6Nd5s8EK7aw3CJo4iaPo89XHEnJrIvwXPKJMyxrhnPaAjzac/p7xVK+1iJMaJZUVSHpZOq4ClxcAmX/dSaW8bfMBR5AG7Q9kWXT6jQDAJG1mK3eRBUVBx92rOaO5uJbGR9jRAqJtZdjqtWRb2GObw+L40lcyqC3vuduyCVPx4pHCOLbOhrfYekRa34g40Qr5EIr/axOg9/pWHdZrZEeI3L4R046g1N4wlb3FPAG7MmggTV0v8SZZpWM/NpBhV+e7oyGeUEbC7j/dz+m851sVzk1+mkWg4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6PecvvMSNzt/cSNUK94EYZdCKaGSxafHfHfPPfIK9w=;
 b=EyeNbhxnPvw+PzJtJ2lJOnmkGeX/weuz5KYQ8kuZrM13FjPyvO3YC9hEkvLbnT4y3B0ZcvjfKWm89/194Llmc8LWyAnRHdvVgb1aB0ZjH5em4Vgefe3t7tblBl2IUJdsOIo+ZD/GNc8Qrm41vePk5lr2zVBY5TyaHsvv6e/AR8nUWl/p0URYhdocYiOkM0yemUKobLBnjeTF36R65/BohCh9AYjBPaqbNN0B2gdepJJn0vmMAHjtWKUPNybQbE8GwMQYDWf8o9St3MXlRNsZk9ya6SpLm4cMPW+voR6KRLtINUctl2OqbFSjQR78lShLZRlCFchx9BJ4S0zjgn88aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DS4PPF0084F97E3.namprd11.prod.outlook.com (2603:10b6:f:fc02::4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Wed, 8 Jul
 2026 21:21:01 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 21:21:01 +0000
Message-ID: <ffc656cc-c05d-498e-94a5-6ee150ee1bc2@intel.com>
Date: Wed, 8 Jul 2026 14:20:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-3-rick.p.edgecombe@intel.com>
 <efbff823-7b4e-4349-bdc4-72a244699d76@intel.com>
 <a724bce3e92e8a8dfb04798bc21860ba9be786d9.camel@intel.com>
 <818e0de368588836810718106e3b592323aaa0f1.camel@intel.com>
 <a058a3e9-711b-4034-b9a6-28444aef3b5a@intel.com>
 <64f1cebe15f013fb8ca11c8133d416e97c2ba001.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <64f1cebe15f013fb8ca11c8133d416e97c2ba001.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0132.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::17) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DS4PPF0084F97E3:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e58e721-d615-491b-2fea-08dedd36ce8e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|11063799006|4143699003|56012099006|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: gYyTCRv0H7sJ9ZuMAmixc410MgLBPezsF6uf/DsFQKVaDsZ5jfJ4NBxQfwkRjVHjHSrDc7mvUiM2HDsT6aUdPIZ/kM867htBaWnQRGAeSb1n+2no5xMvPPAPEaN1L4epIqmF0Tb+W/1Ax0kdK7BIcCzl7QoKhodnvNePlNbcXdyT8WPdlkrOg6pCwVFTZ71e5gHeQnONLHbfJvHtVbtu3Gr/ZMeAxVfd7Q0U8p0hVwL11AL9txqyBewZQfxzrWWEjijAR80m1xHjwWKaqk0c7lIcLvnZuXrjypomn7sN3Nmlol2+uvTb2vhd9f/40WYPzhoEctFyrERtViXm+akfJrRf2VpLJLiqz4QXwEVvgrpy1B91PH5L51LCmuJupZljuLCqw3yAVWxtYgM+Q8tYYa+IwQKia1djNmOIYI1DwbbI/YIR9Fk54X5nFnF0tryxf+VQ+btgpQEeKRHxArbmKPWzsmYNu/BMYJU5lvgFTGgsGYFWlulvK0EK3Go6Q40IJDLj7MumJH1R19UdC9RooiF0Vezx1dSN3fx2BnqPZOyvX8tAH5qxbeAPCO2iWwj23wtYnO9/wGboLEXSipdXpu3TqScrw5gD+w59huOcfMcq4aoDVyt0DL1cH8vvNzguUWSWaFpDb3Up+rfORAYOpaHlMpbDpsfy7FrNAXCmYCB9ewDo19O9Jn8c9X/0bXz5a0dAm2cGDE9mBSg+hCBipw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWdjbThabXJrWlFoNXhoY1Iya1UvQVRxbTd6empRUUtBQXhRQW83ZmNQMjFZ?=
 =?utf-8?B?V0JnMWR5aGdaZnVLQmE4N3JaMmxJNkNPYWUrbjJ1MnNjVTZvd0xxWGNOVmdI?=
 =?utf-8?B?QnVOcVI0cXRJUjlJL0tQU3ZpakFiOFQ5VWFXcHlvOEFDVVBpQ0xPSWdnRWZw?=
 =?utf-8?B?WVdqVGpOQjBxSk1RTjJtY0E2aDV6bVQ3VVBhVmV2bzdoakpTaFN0S1Rkbk1C?=
 =?utf-8?B?WGY0QTV0eGJoZXd4cDU0WU01MEpqd21Ld2NlMGFGS1oyaWVURktrR2lzSTd4?=
 =?utf-8?B?WnBzOVNKbWg2NEhyQ2xlYzg5MnlWTXNGem9xY2drN1JFMXRCMzhqcEc5WGo0?=
 =?utf-8?B?ZDRBaXNGVmNid2RpbFZaUXczUTZkRHowTHg2U0IzQ3Y4NXo1TDlySDVDalhL?=
 =?utf-8?B?TXBwU25KZjBtanczK2xiUkp1WjlzeUNlM1ViaVc1UWtOMXpIMlNsRVVaNm1x?=
 =?utf-8?B?cVRqeU5iOFlyNTEyZDZJZ1dFbXhEYXhka3lqSUZrQ0N3S2htbzM5N2tieXRT?=
 =?utf-8?B?K1VMdTZCWE1GbTcrR0V4dldBTm1pYWppSlhtMkJFWmZ3QU9DOEtLZFVNaDJq?=
 =?utf-8?B?aXhRNnVuSFZRZmNWZkhqWkdQcWhsbjcvTGw0MXpkNDF4NGRJSnFJQnBESHlm?=
 =?utf-8?B?TGh6bDhuNHRodGlqVEREclRoZkFiaklkbkJ2RWQzaDhsQnVvaXZ1KzB2djFm?=
 =?utf-8?B?cXV2VVZhY1l6RUdKU1ZHd0dTdHA3VWVHclBoanBQcGJjb0RXOGFuVERXZE5u?=
 =?utf-8?B?Y0hGU0ZrSm5wMTFPancwalcyVzNDRnFIcnBQaFVMRXFHUzQweXV5d2N3YWxP?=
 =?utf-8?B?S0E4bFJKazk5alExTXMwWjZyd0ErUXVYVVJhZFA5c0xnMGFwRkJvV3V2MjlH?=
 =?utf-8?B?c3EyUHgzYTI1eGkxQkNRankvcXRFNjI1dWJMTHhLQzdpNGdBMFVpOXpzaFZm?=
 =?utf-8?B?d1dPd2NnMDl5eHJrVVo4a1A3WFNBNzlmMklJZGRyNTJlVEtUR1ZLdTNwZDZ4?=
 =?utf-8?B?N25OODRKVjQ5WXZjdDZqbVlOWGtiQlhKYlFkdmtNZlRScWk1RGdWSGJsd05z?=
 =?utf-8?B?MitRaUhMNk5rTUtVeWtzd2NsZ3ZIRE55T25adTZJeWZiM1M4Z2J6QkJrNzFr?=
 =?utf-8?B?Rkd6eXRjaWh0bElESzhaVmUyUTVwT3VkekdNcERDL0lRcURwZ1B0YlByZktG?=
 =?utf-8?B?V1BPVnBtd0lydmRMckIxZUNsdzZ0UmUzdGQwbjNsRUVUdCtka1lwZTdNNTd0?=
 =?utf-8?B?OGFnamlZK3MyRU9ZK0JLWCtPTEU3emdNQkZNWk5WQjVYZU5TT0plU2pNci9l?=
 =?utf-8?B?ejZjMkNTY2t1Rzh2UVBjTWtpWEhhdWVLUklqM2xaZjJJQUQ4Uk9ZbmVoNDNL?=
 =?utf-8?B?Z1RaRG9QbzRFTlVsdzZFYUUvTHNaNnpsRXdESVpGNnUxK1dQVGNXTXJIOHpK?=
 =?utf-8?B?eEpwY01neEp5M2t4UDJ3UHl3U2hFZ2laZnhEVW1abmVTOTlWcTlHbjhLZVVv?=
 =?utf-8?B?WVNoS0RSNHcvYS9oOXovS1NHSHBvWEZyNEhQbHlTbHBnNWJaNTd6NXVhVmZx?=
 =?utf-8?B?OXBleWZYM3lveGNnN21TWjM3N2pRL2JjU2l5dHZaMGZaM0NSTjFPY004S1FF?=
 =?utf-8?B?dnBFUHBlaUhocGpOQnVmbHB3TFdvcFRiR0tQWi9SUmJ4MXE3WEJOU1FXMm5r?=
 =?utf-8?B?dC9TeFgxR3A0LzZoZXNTTlJYZVpybHlZL0R5alBsNEFua2creFNCdWJYQitU?=
 =?utf-8?B?MmU2UmN2cGQvSEVXT3RVdFpqZ0dZSXJKdW5vWnpQQ3hJZE9wVzAzYUZzSzdK?=
 =?utf-8?B?Yjk4YTE4UzhTNCtWc0RMczFsRzFVaFBMdXZ4MmRHL3VrNGpoU2IrZ05HZ25m?=
 =?utf-8?B?R2FhaVVzSmZlQ3BpZDZNWlZFU0paTHpsbDhZZmlzY1JNWDJVV2lCMVhLSUZs?=
 =?utf-8?B?QngyQjkxZTBEdWIrSDloVXpqYm5JQjFKZzJlZzdsWHl0ZXlQcTRQdnhUYWJp?=
 =?utf-8?B?SU9NVnlWaGhYUlh6NmMrcjAyN09PN3o2K1ZoSFFNenEwc2tvWkNPRjJVZFlN?=
 =?utf-8?B?TWltaUJPVHpoNHRiNlo4SXZlemx2ck1qUnhHWS9wWGsxOG51VGtRWnB6N1Jz?=
 =?utf-8?B?dGZRdktDVVFRL0N0S2Z2blBzcDFZQWlSMGRHMkZ2MW9IV1hDV0lHbDgvTlVy?=
 =?utf-8?B?QnNqZ003UlBVZjJra1puL09TcjRtYkNDVWR1bjFzRFhzcHIrbWoxZzB1VTg1?=
 =?utf-8?B?UmhaWWNyQytSMEpDckpKK3AyZzNqVTZydEtCc2Y5Y29RNVNTMnY5V3pvMVNZ?=
 =?utf-8?B?alZzYmttelRpNGtyVXQ5b3VKYzUyM2hjWkI1alM1a0hWOGZpYVBVQT09?=
X-Exchange-RoutingPolicyChecked: h3cMVP8EH9HunR1BW8C5lOS5yJ9Iyt1qsU8LbdkGbi9Y9VOVd1MIoxon5ZX516eStX8IHDQ1PqXnH7isgP/BK7eqIzIBLpERBgV8JFWQ3l/IEx+FHIG5T3CoPlPJy+kjkqzeO6W2ZdAYTrm4hDUXBZ9aIl3FMBOLRrYglUkhhkTZ04tbUQe9KRk65kxypwAasZa448/joH/K8oFy2V06pihOmk/Whej/QWHEvR76mAczrNhOKTjcy0khNFvOoP2pRtgBRmS/kNhYbMJyMLX3Z4ys9oqH/G53V02EBQf8zDDocmJevMWa3DDFM0L0mlBML8aeuZGvmPnVEOVpcGSW8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e58e721-d615-491b-2fea-08dedd36ce8e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 21:20:59.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KLQOx/twCEANpNJFz5rNChvXmNjhREfSyZzYRWBmoYZkYUcsxLWju7fZ1Rt8vamW8CmeMVrl+HaTcpxcPJU4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0084F97E3
X-OriginatorOrg: intel.com

On 7/8/2026 1:50 PM, Edgecombe, Rick P wrote:
> I tweaked it like this, seem reasonable?
> 
> 	/*
> 	 * The kernel supports using TDX without Dynamic PAMT, so
> 	 * avoid reporting failure if it's not supported. Don't try
> 	 * to support buggy TDX modules that advertise dynamic PAMT
> 	 * but don't expose the metadata.
> 	 */

Looks good.
