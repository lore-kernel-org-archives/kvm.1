Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E0B4AA1DC;
	Wed, 16 Sep 2026 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595425; cv=fail; b=qnG3gE1bWU8nYkT4vtF7lojuoD4YmP3G4wlERE1jcxbZ2jiwREyDvc5PzbGuSFUyYL9lk6nIJE/iYBokWQNE//fcpXt1blcCgzNobl36/lCBBlODguS/yXjkvVvsWzUCWB0/7Cv+koiO1ExS2WqJEkWjUND9j45QmXAqBgTteEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595425; c=relaxed/simple;
	bh=b9M3Z5QLGY+3b72PN5ozJzjqjYWywCwG3TxBVzut5ts=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TKNBppANd5+P/CsQ2MKho9z+nccNuK8jS1TJLFKQYHTGVq6xY3cjTS9JjaNyFVHTkcvU1YRjkl9SUtDzMDYSVscb0fuM1ndURBiYPypYY8tOvdp2d6zJoxD1RhWuTD8vbz++kPMu0bhySi9Gt5qT4Kzhx4OLAqBNA3dnibKPGyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1SBDzwR; arc=fail smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1SBDzwR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789595410; x=1821131410;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b9M3Z5QLGY+3b72PN5ozJzjqjYWywCwG3TxBVzut5ts=;
  b=i1SBDzwRn1881c8G7GLzatVgg78j4HoFycD6Zx9y1eu2FDtUO907xkX8
   7lHQFrfXPHCS2tveGZzjSwin0E+CIquzuEFLRnZ7feTGlkhgHuOdqYMRO
   abKAbEzib6ww+xNsH9SzNvI6fVyBqjj9DsHyvu8AsaK+1qOTRJPCuiXWz
   mhEYLrz0xy0r2cnl3mE+NRAFBkQXYs8Tp6t/Ywq8uzOjkPziUsX9OwU7h
   ulEHNvzvQD5iKtNTJv6Z0DxNhFlEy/D3SDjMkdE4ZC6C3latY8W1cgvYv
   MTHMxv3ARoPsqHdagqTB/6JMCysaA+eNScGq1oLX0MNONu68hhXwrd8Vq
   Q==;
X-CSE-ConnectionGUID: kXdnKE2rQa6UBu2q7AA7+Q==
X-CSE-MsgGUID: 5SFsnkS6TySLozeKPz+oBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="488948"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="488948"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 14:50:03 -0700
X-CSE-ConnectionGUID: Ww3f5KaCSe6hB8uS36AeLA==
X-CSE-MsgGUID: QPVx21FjQdKNRXSaMQ1tqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="298543326"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 14:50:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 14:50:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 14:50:01 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 14:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOgr3CaWCXPWpiCXr4RrBbwX95OGqrIlwB4gTGk6sSkWZikyL2oeZfPdhgr4D0hO7pe7RkSA375XTTL0iN5mBzeU+iXD405fSQs1rMZJonIWDJ6mNl/k0U7glrWm4sBVuBEVm3dg2q3xa1SaZfm8pYpCKUzbgsFIbdbOFLedS5/FwUMt/UPg5PD4Fyn9U6EGMaKFCcarqncclZ1zvYdqJxILrARNkOYWza8xQ/6EjrchXA3z+kJFz93gIi4Z92335A3IdpPpzhir/phnlmWx5G+gsKIKMQxyetJdlUTd47Bl0dDf93cdrbpiYjJj2z71jt1QKgP0IC9xf6VMUkP6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgVfwzxTnv8K31//07bhKuIXmSbZ1Swk0xvcQsn8KP0=;
 b=Zw+z+1h6dY26qknx7g0FgYitRioHQeH0BESN+dBJRcNlnqKoBtEXcozk0I9FRHuoTFwHSl9889HxDaD7/uovr3M5pdFH8yFq0hj71KnlR4AgR/cPJMdtGcyxC5NWSViR3Umdxw2bB/bIjPqgzDubvlLWxfIVfZ4GUAUo0Ln25gCfQQzSHjqrDG4kkxQytf9MCh7FBGaZEBCR87Fl/FMjlj782vn2gdX3kV1fZp5PxdWJBoThE39HZeIAcekY98hxWuNiHaJzmdNqA6QYcAIwf+g1g7+mHeCmtBXCKZHAumdY3g58b/8owdYv+jSekjAQpRjEkGM5PHkLXAK98CUUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5)
 by SA3PR11MB801469.namprd11.prod.outlook.com (2603:10b6:806:58c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 21:50:00 +0000
Received: from PH7PR11MB6932.namprd11.prod.outlook.com
 ([fe80::cca2:8c49:b4b1:761e]) by PH7PR11MB6932.namprd11.prod.outlook.com
 ([fe80::cca2:8c49:b4b1:761e%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 21:50:00 +0000
Message-ID: <ba819246-e7d5-4fa5-afd7-50ff1e8adff6@intel.com>
Date: Wed, 16 Sep 2026 14:49:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] KVM: VMX: Implement LASS violation check
To: Sean Christopherson <seanjc@google.com>
CC: "Chang S. Bae" <chang.seok.bae@intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Binbin Wu
	<binbin.wu@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Kai Huang
	<kai.huang@intel.com>, Fuad Tabba <fuad.tabba@linux.dev>, Chao Gao
	<chao.gao@intel.com>, Yosry Ahmed <yosry@kernel.org>, Claudio Imbrenda
	<imbrenda@linux.ibm.com>, David Matlack <dmatlack@google.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Kishen Maloor
	<kishen.maloor@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
 <20260806011536.4172258-5-sohil.mehta@intel.com>
 <e6220b0e-0f5c-435f-823e-318b527eee8a@intel.com>
 <c5076e4a-0335-4ed1-8049-a3ddf486ea03@intel.com>
 <aqlQgQgnLDf2CHqx@google.com>
 <f4fdef08-fdf0-4af8-bf59-07c48625b282@intel.com>
 <aqriCQTG7F73aEpX@google.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <aqriCQTG7F73aEpX@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::31) To PH7PR11MB6932.namprd11.prod.outlook.com
 (2603:10b6:510:207::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6932:EE_|SA3PR11MB801469:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee536cd-88cb-4ff0-ded0-08df143c74cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CScszkmHoeGuz94VkIT+DymJqJmsrttgFTBe5zHDROtJjWfnMafXiERl+e8rZ1a9iozmnUh7s89F53u84poQST5378R5S0azebdhLSA1T/hxD+qLGgqirOxmG1BYisQv0Hg3R3YZdBcg/RpaIWcjH5xLfqxgUQ4CJ45am6woRYVFXipCRRvoMw2n7CbFI7MhiM1njajEtoQjaEf6lS8t2hHBy/QH+tRaJFyaXUJAJ154j6S5607JelJnfrW3W2yjbdSyTfwAYdBzwWNE78vwVns7mvuwwSe4zF0aBP7RILbiH3sUQbLQ0QjbmP0uGOCJ1EmriRy7ekv/UU5phUUHbGYsMcevedUrp6aurPm/WsFXSx8MMsqlEdRdTUeLfQ0Nk5aiPecRxOuDkKtuyGYuZtJJZfQbXejYaws2SeXSc96Z9jvk076fOWlgQX1h0B2hv8bvAfEN5Bw7Tb790nR3mYMoaaOganHGoOXFTOX85FT+Nou/Z6gzN7HTb2Fd1AdgFTVQpevEZg90+MN2MNXMtAzu2FDZ9rwbNCvWfH26fnOL+Q7PlFFFQW4msHiFEKtXsz9NZtmXaQyf7BiMZLyj+BA3N/d8H2VQRYPycux5AjttN96TxqK5vBXLj7oysXxASgCFGR4Ogn1UKkjjA0RrTw9J0PyebIaM9UotK1QPDo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6932.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WktXVktRNHNoZGdmWnZuUE4ybWVOUEUvSzB4M2lIS0NMQm1iaUlYanI5eXF0?=
 =?utf-8?B?dHZLV2hILytvdHBBWGJjYlVMbkgvaXorTmJjbkV2VkY3RGovUzVRamdPNGdR?=
 =?utf-8?B?d0RIK3ZKcTFsTExXTTVma3ZMT0toNWtUUWgwZGh5eHFaRGVpbDVJZjVaR3ps?=
 =?utf-8?B?Z0NpRjdiN0dGQzFOdkJldzBmVFFxTTBqbjRZL1EyTmtZSjdITWJXTENxVjBY?=
 =?utf-8?B?ZTNmVG40UkNReUdzSFlPRUpvS3lUeC9HSFN2Ty9BalM2dDJKSFhVQkNtS1lj?=
 =?utf-8?B?UVFMMS9NZjk2WFBlL09RTzNJMHZ3YlBMN3NPcC9iQjVMTVhyV2k0cFY5cjhr?=
 =?utf-8?B?R2Y2Sm9iZXRaaHZ3MjdyUmFSTTVnMml5TjEyaEIvNzQ1Z1M4bVVLWnNOVGVo?=
 =?utf-8?B?aFd6ZGU4dFowdnBZS1NGUHExSE96UlRsWmhXbXNFQStKK3VQUmtVcjZRRXZm?=
 =?utf-8?B?c2RhL1BjSSttNTQ4SUx0QmNsYzZvQytIbFo5N25DdFRYdXJUTXJmaERZQmND?=
 =?utf-8?B?Tm52ZkNIN0hIaTl6d1ZQa05FcEJYdlI0MVc3a25wUmgrcnF1aCtQR1FxeWtF?=
 =?utf-8?B?NDJLTEVuTzcvWUtVbURtZFB6aWV6bzJmSnVqVkp2L0VrRXVQTkZGSVZ0QWx0?=
 =?utf-8?B?OTdsU1EzKzV6MHJnUXNabjhUcWJaY2tIZnBTQ1RtYXArS1BEclhFaEFHMG1a?=
 =?utf-8?B?U2NxdEdMbVA4RlViNXpPdm1OZzRFMnVnY1c1eThNZHF2WFZZcjdTYWJ0LzFG?=
 =?utf-8?B?R2VCR0ZKTVlZeWJEUFlDb0hYcUNicklOMS9lcVdYWWhEOE4rNGowaExGQzEv?=
 =?utf-8?B?MzM0TVRFcDZVUlVrRjFjdW5hL2lub1dYTkFLSXMzL0s3UEthMTJEeVRYK2tw?=
 =?utf-8?B?WFVGSVR3TFZtLzZCQlNrb0FFcGtvTVVLMHJFVUdESWppakQ0d2dkV2dtL3h6?=
 =?utf-8?B?SWxMUjVYNDB6ZjZZRVFjekNUa3l5dGxFTjlDalV1S1U1WDBsbGpCSmc5Tm1W?=
 =?utf-8?B?QWw1S3ZVRVZkMGRtdkdpeGUwenlRK0hwME1GWkNGVGJsaUtjTTc2UmVxQTZh?=
 =?utf-8?B?MldDM0FabThma25lQXZjUXk5bE41ZGx5Z3NOZ29CRDhJSzBEVjQ0OW9jTWpa?=
 =?utf-8?B?OUVpTG9yMUZ5VTJCeldWNmRSckVtK05rYU1VanA1ZzVFMiszVTlZeE5nQ2Vx?=
 =?utf-8?B?bTI1cHI3VlZjc2dKRS81SWgrb21jNnljZjVGQlBUN09TUUQ2bjlpeDF3TWlp?=
 =?utf-8?B?V1k3UkpLSExZaGNBdXJzOS9mdGQ3VUQzSm5iYVdEN21Wd0NZelpORitVUmhH?=
 =?utf-8?B?eGF1aFZtOU8yY3ZTa1l6OFdiclljV0xna0pRcGRpckJsdy9NUWl5dkZGRnNU?=
 =?utf-8?B?U3EwZE95UTQ3bTNoWlZDTWRHLytsbGpjalpxdDkvL00wUmtwa25ENmp5NFJS?=
 =?utf-8?B?NCtmU3hOR2RnTHMwYjhQUTY3QlhEUE13a3JWcGZJdWlMbjBGc3F5MGVteWFp?=
 =?utf-8?B?U3NFOGgyK3N1TllFaWliazVXalgrRjFXRmFRTFQybGw2SUROTXpPQVU1OFQ0?=
 =?utf-8?B?SVphN1RuV01semVFcGg5Kyt4cEJkdDhtUkgybHpXQ1ZoeWdZKzBYaWNwVFhQ?=
 =?utf-8?B?QWFnMGJsbWsrWVR0VGloSysrOWlvYjZBbTBWRWZocVlyYUczZTRtVFM3a2Nx?=
 =?utf-8?B?eVhNWmZKNndNT3FHa3VDeTRBaCt0d2FxSXJhRGZkMXJtdTBoWk50dmJmRjlU?=
 =?utf-8?B?a0pSenJGYlQyaDVXVWxHMlhRMWlZMlB3QW9UVnVsWGZ4MHNHbXdrS0tPOVhS?=
 =?utf-8?B?M1lsbFB4RFV3RUFWVnJLK3llNTh6bktCNmQ1M1FuZUdWdTBLdGl4Tm8yUzBI?=
 =?utf-8?B?UkpvN0U5TTd2TXdBQi9hb2F6a29UY2c3dDJpVTU3U1BaTDFGOTh0bVdSMC9v?=
 =?utf-8?B?cXNmZzRlSUZSbzhlODQzTk5QRHhzWjEvU2RjRXhvSEh0dXYvSVk1MmtLTFFJ?=
 =?utf-8?B?MkdkbkFWV05Cd25SMlhQN0dIdjR6Wll5Qy9ZNEdrdUthY0FxV3V4UXVaRGI2?=
 =?utf-8?B?UXIxdzFhZXpkWi92UGp3TGtVSVdNNzVveW5RcFZlRGdvenRMblB1UjJ5MHJ3?=
 =?utf-8?B?b0h0K0gwRDljVGJORlljSnFsWXhDdHBJMHpqc2JVcVZKMG41ZHZVZ1hWZEQw?=
 =?utf-8?B?aDdOVmRCdW1DaWhBb3VITDBBRkdrbHRzWG5hNzAzcEswVVhLWlpyQUp1VHVS?=
 =?utf-8?B?bzdUd1BnYzZFT3djTkRybWhqcVJ5c1JRMCtIYS9WZTZpLzZsS1pHMi9KdHFx?=
 =?utf-8?B?QjdFYVhQdzkxVHhyeXhhT216TnVaMmJ1QXFCa1ptWGNvRTZwUlJyQT09?=
X-Exchange-RoutingPolicyChecked: orl/KytNI1HZrxOKceev0T6ISbbUeEEzJJDs0irBt4bfrnA+BiCmmwJXDosd9zk66ckcFbwSbgoVbiN9J8cijjRh17m4hOz4qoafaMARbjdR3f3S4XGPTgdv8nQfpUbr0XP3DUfffbt+gtFqVG8h9WvnBwj/vmQfFiIVrYiM7mc08wbIg8P6ba2cvXf58AhsdpbDx39+ThNsoxP7JL7XPgiiX1igEpyOhGvMWrRp/WwEZhM1iEQHpVVQFErWGm3shC4uCUVPn3Hund838GKxp+TCPhe6KJXHn4CZfwTVSZM99B3mLon4qXpBJrx3PtVB21Zbqto9NqVMieLjBtosog==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee536cd-88cb-4ff0-ded0-08df143c74cf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6932.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 21:50:00.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjdp/yOjqQxja49N4pfJZ/hfIYuHpRwKwwBz38jEfzKz2ou+Gy/Ak/hB8x32bqaK2KpgeZ6WAlNlV9S57m9X6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB801469
X-OriginatorOrg: intel.com

>> Sean, other than this, do you want to see any big change in the series?
> 
> Dunno, I haven't looked at anything else in the series, I just saw that I got
> summoned :-)
> 

:) Appreciate the feedback.

> It's on my list of things to review, but I'm behind on reviews this kernel cycle
> for a variety of reasons.
> 

Sounds good. The patches apply cleanly on the latest kvm-x86/next branch
(kvm-x86-next-2026.09.14). So, I'll wait for you to look at the rest of
the series before I submit a v5.


