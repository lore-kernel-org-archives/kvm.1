Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794016184;
	b=4u39kMDGi/J6p6kRSD4ldx6DFAdcNbXiiMLdldT01NxaTxL5UCVyWB6d9jc+wJfPMoU3
	 FL78rBZXbKi4ZmytpurGAdJFxhoV5WIGRI1khWqqbZRLJmfNcESucbRU3WJ9qMJ6UT7oi
	 dIsOKP0pI39x4H/UPRx6XopB2ftj4ffPZxSoaco4iSnBe9MZETNRtTMgNr9TJ7IM/hnJJ
	 ykrOIUtScjBReiTYkUMknuU433lHgFj3a5Vp33PC+bhkr/s6yiKDyN6O8GK4Wgk9jsIn5
	 mNLyqqoBaVtBVhqTbM9JeRiaddb17kwTLORvPl8V6hETyundPAkTsn8F75romicrIkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794016184;
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
	bh=Elh60yIPbCoV3a5PHEIMfhMM+sx1B+1iApOzf6cR/hw=;
	b=w28UsurHtx+UXdkxi6MdtzeJThsAuvoqCUJjELMuZIMmcXYpNddsCpdyT1Cl4cOKYVl3
	 u94zLsVHsJCXCK9jKumULTYPXwNQAa9yn+mlv6fFm1jv4juQHOvO/e0mjqzsAZpxKUY/h
	 AFewlEK62RhteP3C3MkZ0dhxGuh9Tg6dRGc0khsj1WVYTesEahJuoQMC09xHykSLG/CH1
	 UfbD8w3mKCadhseJDC3kXqQdZ+gZC7yUBYMC6ESyFlYIZ8siUSoZaqM67cIKnYNrX7fUx
	 OxJq7F2AkEll7GAa3QON7HW01mzuz1CpejWrPpsQ4CBnfZXzujpKxJr4+C+5b5dgCOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eFRGgLHV;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA8606A326;
	Sat,  7 Nov 2026 01:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96BA8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eFRGgLHV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794016183; x=1825552183;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q6p0GW5TMs0zlHx1NOefvVVuMzvm3YR5EZTcsR/5JDE=;
  b=eFRGgLHV3fTaKAsLZRD4nIit4Ozwz1H2iPA6d5yZ9xWuO1FwmcuthoNw
   PnF0SJdK7gbp3cCIl5qCLUNSnsDUwp2+V9QVLlyAB4Xpt7wS4fFW7eZqi
   IalFnClvcPyya+6SDgsbUy5txPPlzC5YNvVccPMZFSAItlhjP5iJQ6e0L
   5OBjtemZeAUYkebmcW38YKJvO3JnWXKZO5l98EsyRZdZC2MBekW4CE5FA
   HGHEtiEsswECdo0gqGrO6GHsVcyNMnLAyaWxuMhjZD2v3vVpJLihIGSUX
   AjulNCSDNE8gFVGnEKmEDGHnYNKCB82Vnm987Mfp+MTwa/PZPMF1RMxXQ
   g==;
X-CSE-ConnectionGUID: CrZchXIzTvyddu2bzpCmJA==
X-CSE-MsgGUID: xqIO84jURdSQ/HdQzxcmew==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2735206"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2735206"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 17:49:42 -0800
X-CSE-ConnectionGUID: JAnvb7IgTxWMkrt1eu6DwQ==
X-CSE-MsgGUID: t5vyCMUkS+OZftR1hAEAyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9187972"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 17:49:42 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 17:49:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 17:49:41 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 17:49:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atzOyI43cNNXDFY7Vilc9TLqJnI+spjbpoaiy/7qelk9RbeAf1JkyGFZwEXN08L5xmsi5MDKHyws518xKbUWKj78wQKL3J0OnEZeIue2s8KR2u41aTCsgocthVcOG8lFt0Mz2ucMkIZzxLUXIsIiX0b6rFOpGITzoOzLXae2M2At5kf715nRffATJV120OAAm/7XeTx9E+x/6L6D/FpnKJwFO2uHX0ZziijzOGNNJp0lgpBloeamdT239GaSmgf4ohcMq7geHiBLhpemZFO8zCYsccf60H20DGmOYOzm/0AEQc0Fq8Si3OvhKMqetSZGtT5xI+ZfOzdCNsLyaQ8edQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Elh60yIPbCoV3a5PHEIMfhMM+sx1B+1iApOzf6cR/hw=;
 b=nVvWiWTWiumMZvou3HpXiLmCR58VrCR8PcfDtRAeNARvcAPaJ87vK1Vw+Tl+O00a+fVrnInaVXEOjHfA9MZElEo8uaHh9E2YLGw5TF6KxiW5go85EornNWsByQEWGrIN6fM2E12Jg/84uf+4dH2cQriCUO/j81Yohg1VV2/WtVNcLlMpocDqk+hyJ4pE4Gis9i9D+n3cu1bruDzsMK30PYBH6qSd+hm8jA78PqMFoK1lwYByhP9yFEaA0/aBNRUFzGwBBKZvaqL4r7+Y0xEuK6+O6CwJNAQJ++rP70QGmAJ82SMqr+M7DCSnT29tHeDGB5QTj59pssNQbQ4AAd3DBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by DM3PPF9D56E7727.namprd11.prod.outlook.com (2603:10b6:f:fc00::f3f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 01:49:38 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 01:49:36 +0000
Message-ID: <4e5494a1-49d0-409e-b459-f07ffff4c298@intel.com>
Date: Fri, 6 Nov 2026 17:49:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/28] KVM: x86: Include CR4.FRED in the emulator CR4
 write mask
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>, Sean Christopherson
	<seanjc@google.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
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
 <20260911213659.2025974-16-sohil.mehta@intel.com>
 <8fd0bb21-c273-4f43-8c08-5e82ea1ed8e5@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <8fd0bb21-c273-4f43-8c08-5e82ea1ed8e5@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::22) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|DM3PPF9D56E7727:EE_
X-MS-Office365-Filtering-Correlation-Id: dca0ddb0-f647-4b20-8a87-08df3c7160fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|18002099003|22082099003|4143699003|11063799006|261028144727099003|56012099006|261102123227099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003|261026140227099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: V59eI3XdmtXSJXGQziyn/hU2S+4NTD5B8Y4Lh6FkgETLvaJJfmMaKJ4j30LGH9RR+Rqmkv+lxWtacxhVp94JDEnwswkXl6G6x2kdXdj5vbHQtXBP1+zRbEUtPHhK1kjia4BodD0Ctv39tVmx8w6J0Rluv0/P6+V/0cIJJjwIGx3WdUqpFYEC122/OhSXZzd5QIxDZYA2izEpv/TRPWHXizDIoz28w08RskmZui/zHLb4NrlDt/6OVZ05YWpz+b59M9cGfCmT0EOjsFmQhy0YYwiwaIWOmSloJADzkwQWvnozsZ4z3hMfVE6Vl/HxbaX9DUxdbMC3Nq9bb5a5g+5NGn6uMzo+c90RT9dBapmjxwFx2t8EU2EbMjbUlzdoH2sg7RryLRiu6Tcam96wNwUmyNsYFYW3Huk0zAhh+MJg0PkzZcwQeaVKMpS7YuYyw5Xivt1lD2Am51oikDIrk9zmah3lhTWpjGFA+x+pnGkOcT/5KShzVHTCmJzNsrpewDKvrQ3O+ySzZF7nNogBqEQ1r5AgNU0rSxFmtEV4ISBb3NqDHareeHlOzzqrKCDCb0iU7jWZ75kTFE5eM8bgCCiZFTkJ9MiryeBDvKp50+VAzZ094kdNWN5MbTrbjcJxEneE/suMi51poipLVOfqDNJB1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(261028144727099003)(56012099006)(261102123227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003)(261026140227099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkNYRzdNL3htSUhvMkpkN3J0MFVZYWNWVjd3WHpieUdWMUNTT2kwa2NodkM5?=
 =?utf-8?B?Z3h6WC9OdXZXbDVwdStyRFcrOUFkaWpNWTlLVWFiNEhLZGNFU0M5QWgycFdL?=
 =?utf-8?B?dXdHdmNjOUNqcEw1bGlWbmhvdmdVdWtqMDEycGtYVDlsTndpT3NyRGlmQnZr?=
 =?utf-8?B?TS9pcnVnOTdUb29pSk5lWFhIam5tZGFJdk9tYXNjNGRYd3Bua24rMWpYMTlw?=
 =?utf-8?B?dUtCMi9sWjdQK1JWQXRWQkJJMWNzZHowT2RRdUJ2T2srZis3ZzN5U3p6MUlh?=
 =?utf-8?B?T3RST21ubG5xSWRzeDBWamIxVkVmZG1CZVF3TjhjNnJaVVN1UC9pZzlrcTVv?=
 =?utf-8?B?NHBaWWNZdmh1elQ2T1JZNkJaWGVKSnVIMm1NNzFXcFNkR3RWUHFWdUorc3Fk?=
 =?utf-8?B?dEpKdHl4SU1Qd3lBb1pDRUs5cWlabWVYR1FuOW81NFVHcTZDS3pGaVgxQ09R?=
 =?utf-8?B?ZFBZYW9ZMjFkOUtOUUhjZ21HejI3b3NZb3lmYS9aYnRSNHgvSjBnY2VkRWJJ?=
 =?utf-8?B?YWpxYStBdWZHV2JSMUNrdlpybUkxWU1mMVdsSFlPcEdrcWltQisvQjZtMFZO?=
 =?utf-8?B?TWJsQktiZTRHbyt2TVVMMTRJdFR6NTM5aHVOZlpTUVpTd1FxQkJYVkZ6akJw?=
 =?utf-8?B?NTFjR3N0REFGLzJPN3pNK3FvOGdYdTBRVGxiTHorOWI0anZaSTIyT1RDZFoy?=
 =?utf-8?B?Y2IwYnFBYUNCTWxnRnRRNTNmK2xIWC9ubzdIU3Fld2xpQnNUblIyMklHdHdi?=
 =?utf-8?B?MEdvTzhmMHFYampHVWlJSk42RFdMY2FKSExmekx3QUhHTzBsR3lVVFI0eW1K?=
 =?utf-8?B?YlpxRWhLREZFVVBBSFlFeHhVRm1yQjh3TTN2SXJ3aUFxbzd3VWc0V1JsbEN5?=
 =?utf-8?B?T2dWQVo2MDg0Q2gzQ1FXRzNMdm1JVjZZNGZaQ0p2SUg1VE9OM3hIRDZvcUxD?=
 =?utf-8?B?SXFqaStod1hteEFldlB6RGxEQm1ocXF2aG9NeGtka1NNZzJBR3dGU011eEJp?=
 =?utf-8?B?dHRXckU2Y2lOUEhCQ0phNCtVVXFzRFZ3Y053ZWYyVlFzUzZZSk12dlkvK3Bh?=
 =?utf-8?B?bjN4NWthRVE1Sld3MnpwZEhQZDh6a2w5RVZISkNOdEhjR1JkcTZ3UGI3ZTV1?=
 =?utf-8?B?N2NuVjB1VHlUMDZzWnBua3hzNEhnUE9XaHRtK3BPN2R2d3c1ZTlGVW5XdGxj?=
 =?utf-8?B?dnRZZFV0SUJGeUdKRitBZE9adGc1T0ZJZUV3eGZ1MWJadHpwZnltcGtsVzFJ?=
 =?utf-8?B?VVVPNUlDRzU0M2IzZlNDR2NscnZkUDZoVUY2MG5tMEFtOFpjK1BHQUxsYnkr?=
 =?utf-8?B?amZkMENJK09GQnAvTG5FcWljNDJkRTBESWNFbjc4TVpIc0s1STJYb2l4Ymlq?=
 =?utf-8?B?WmE3OFBBNk5RV3dUd1JwSEJYa0VQL3phenFqUHNTSWFvengxQmRmMzJGTVFQ?=
 =?utf-8?B?U2pWcG5zY2FuMXBtWkZJZkZPQS9MRWZzK25JanByaU9iVEUycjduRXM5MXhS?=
 =?utf-8?B?aEpIQkROUVVjYnNrNDNJZ1B1RjhYTElyL1JuWlVlZmVVMzh1R1Vsc0RDK00w?=
 =?utf-8?B?eUlIZkxQdS9mb1pnL1FUK2RrUnBWNVJCYzFlV2xjRkR0bm9EMkZJMkpyM0Nk?=
 =?utf-8?B?VklXejJ4S3BSaTRLUFhEa01SeWZkL0RFOEVnMmd3c3JWMHNZRzVRK25kOFRQ?=
 =?utf-8?B?YWlZMVJmSUo5QndIb1FNZjduZ0dOZ2hqV1lJTGttbW1YalNRR0ErZmcvMUFj?=
 =?utf-8?B?MkhNb2NldDBTVDU3YVdyb3JxWXRVN1JMNkJPZVYwS1cwaWswNG83OG4wTm9H?=
 =?utf-8?B?OHpsbkpvNlU4T0xSdEppSG53a3BoZ1VFYTlhZXY4cENnSTljc0RiKzlyb2RU?=
 =?utf-8?B?akgvUTBXTmFNbnNId2JBeXZXSzc0a2dKeEZDTis1elpQZHVFd0VZakRjOUVZ?=
 =?utf-8?B?ZGtnaWplZE92cm92MG9CRXdCL2NNTXdWSUg5T0ZPZU9vaWZhSCtGek9hR3V1?=
 =?utf-8?B?aG13UmRVNjU3NHJhZHZHSTk4MS8yQkNCWFpEK0NqeDI0WEt0RUVQcUtxMVRI?=
 =?utf-8?B?aEtuT3FHcGtNYlNTdVU4MmZ3RERTZjFTbVlxTm9maXQ3YXpKbFZ2b2xXOUw1?=
 =?utf-8?B?ei9BQzllYkZuTU9RamFwU25PeWxxY0tpWFYyaytJVlVmVmVXdkVQMGo0dlVE?=
 =?utf-8?B?TmcvNXRjdENwc2ozUThkL2RrSXFPSXAvaHhmd3d1dmUyZ1hhTjA2VFlWWXhR?=
 =?utf-8?B?cUZjb1J6YllycTNwSGRyQUlRblh3Q3ZvdDhESXhHSWhCYlV1eXFacG9RQU1v?=
 =?utf-8?B?WVJ1M3pKa0dkbzFldHVBaVgxb0dFSkdYWTI2U2dOaHFtUjNnc3hvQT09?=
X-Exchange-RoutingPolicyChecked: hlnqZZZi6st56yW4bwK2+gStMiaTs5hDlxiAFyNFLfuwDHlmOgDUidLShk7SjZbff0FLFh9w/2h2OBvgFId+EQmPS5wOWbanJDUBM+8ExehsJaQxWWJvCspQNLpw+V5Ws4CPssNxbGXymkCcnkEsrwYNLAz3tBwMrkgUsTHvuCtmuxVjsO1/Q1sbYQck9wNHtqpgEyLRjHcwJB2wTWlcETaIPoulY7D6rLmNo1qjFqp+fS5P5fzjVW2wPIqotGX8ax361EV1z1wBTWjb0aPi1ApyVMI/aEwqQ+uQQjYPYeJPJIXlUbw7+HIzHGW5kyzeJcHSZEfX8sxPTN574WwvBg==
X-MS-Exchange-CrossTenant-Network-Message-Id: dca0ddb0-f647-4b20-8a87-08df3c7160fe
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 01:49:36.7769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyGdxrJ0kaeJMzHziOl80XbC7GxVjDbuzzMC69gSJnMO1aeGDPVT/ypGr3Kxt3YWYlNN5DZ1/vaASCycQ8UDBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF9D56E7727
X-OriginatorOrg: intel.com

On 10/29/2026 11:26 PM, Binbin Wu wrote:
> On 9/12/2026 5:36 AM, Sohil Mehta wrote:
>> From: Xin Li <xin@zytor.com>
>>
>> Add CR4.FRED to the emulator's CR4 write mask.  Historically, CR4 was
>> restricted to its lower 32 bits in the x86 architecture.  With the
>> introduction of FRED, CR4 is expanded to use its higher 32 bits to
>> accommodate the FRED enablement bit at position 32.  Update the mask
>> to ensure the emulator correctly handles FRED initialization and
>> prevents the inadvertent truncation of high-order bits.
>>
>> Signed-off-by: Xin Li <xin@zytor.com>
>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>> ---
>> v10:
>>  - New patch
>> ---
>>  arch/x86/kvm/regs.h |  2 +-
>>  arch/x86/kvm/x86.c  | 12 +++++++++---
>>  2 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
>> index 4e641a6c20f9..ef46918daf43 100644
>> --- a/arch/x86/kvm/regs.h
>> +++ b/arch/x86/kvm/regs.h
>> @@ -8,7 +8,7 @@
>>  #define KVM_POSSIBLE_CR4_GUEST_BITS				  \
>>  	(X86_CR4_PVI | X86_CR4_DE | X86_CR4_PCE | X86_CR4_OSFXSR  \
>>  	 | X86_CR4_OSXMMEXCPT | X86_CR4_PGE | X86_CR4_TSD | X86_CR4_FSGSBASE \
>> -	 | X86_CR4_CET)
>> +	 | X86_CR4_CET | X86_CR4_FRED)
>>  

Looking at this again. I am not sure if this is accurate. Sean's comment
in v9 was that KVM should always intercept and emulate CR4.FRED writes.
IIUC, by default the bit is KVM owned. So, adding FRED to this guest
list seems opposite to that preference.

>>  #define X86_CR0_PDPTR_BITS    (X86_CR0_CD | X86_CR0_NW | X86_CR0_PG)
>>  #define X86_CR4_TLBFLUSH_BITS (X86_CR4_PGE | X86_CR4_PCIDE | X86_CR4_PAE | X86_CR4_SMEP)
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index e10ac6b280f6..f264bc9c35f9 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -5552,11 +5552,17 @@ static int emulator_set_dr(struct x86_emulate_ctxt *ctxt, int dr,
>>  	return kvm_set_dr(emul_to_vcpu(ctxt), dr, value);
>>  }
>>  
>> -static u64 mk_cr_64(u64 curr_cr, u32 new_val)
>> +static u64 mk_cr0_64(u64 curr_cr, u32 new_val)
>>  {
>>  	return (curr_cr & ~((1ULL << 32) - 1)) | new_val;
>>  }
>>  
>> +static u64 mk_cr4_64(struct kvm_vcpu *vcpu, u64 curr_cr, u64 new_val)
>> +{
>> +	u32 shift = guest_cpu_cap_has(vcpu, X86_FEATURE_FRED) ? 33 : 32;
>> +	return (curr_cr & ~((1ULL << shift) - 1)) | new_val;
>> +}
> 
> It's a bit weird to do it based on specific features.
> 
> Also, I am not sure this is needed to do the special handling to preserve
> the higher bits.
> emulator has zero extended the higher bits in fetch_register_operand() if
> in non-64bit mode. I think we can just take the full 64-bit new value?
> Did I miss anything?
> 

You are right. The value is already the full operand in 64-bit mode and
zero extended otherwise.

> And also for CR0, is the special handling needed?
> 

Yeah, this whole thing is unnecessarily complex. I think we can get rid
of mk_cr_64() and drop this patch entirely. How about something like
below (based on kvm-x86-next-2026.10.13)?

>> +
>>  static unsigned long emulator_get_cr(struct x86_emulate_ctxt *ctxt, int cr)
>>  {
>>  	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
>> @@ -5593,7 +5599,7 @@ static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
>>  
>>  	switch (cr) {
>>  	case 0:
>> -		res = kvm_set_cr0(vcpu, mk_cr_64(kvm_read_cr0(vcpu), val));
>> +		res = kvm_set_cr0(vcpu, mk_cr0_64(kvm_read_cr0(vcpu), val));
>>  		break;
>>  	case 2:
>>  		vcpu->arch.cr2 = val;
>> @@ -5602,7 +5608,7 @@ static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
>>  		res = kvm_set_cr3(vcpu, val);
>>  		break;
>>  	case 4:
>> -		res = kvm_set_cr4(vcpu, mk_cr_64(kvm_read_cr4(vcpu), val));
>> +		res = kvm_set_cr4(vcpu, mk_cr4_64(vcpu, kvm_read_cr4(vcpu), val));
>>  		break;
>>  	case 8:
>>  		res = kvm_set_cr8(vcpu, val);
> 

KVM: x86: Stop truncating CR0/CR4 writes from the emulator

Pass the new value directly to kvm_set_cr0() and kvm_set_cr4() when
emulating MOV to CR, instead of taking the low 32 bits of the new value
and the upper 32 bits of the current value. Preserving the upper half is
not needed, as KVM never allows a bit above bit 31 to be set in CR0 or
CR4. In practice, mk_cr_64() only truncates the new value, which allows
an emulated write that sets a reserved bit in CR[63:32] to succeed
instead of generating #GP.

Truncating the value is unnecessary to begin with. MOV to CR is emulated
with Op3264, i.e. the emulator provides the architectural value: the
full operand in 64-bit mode, and a zero-extended 32-bit operand
otherwise. Note, only the emulator is special in this regard, VMX and
SVM pass the guest's value through as-is when handling CR access exits.

Dropping the truncation also readies the emulator for FRED. CR4.FRED
(bit 32) is the first CR4 bit defined in the upper half. It now needs no
special handling as the full value is passed through.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..a6f94595ac75 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5541,11 +5541,6 @@ static int emulator_set_dr(struct
x86_emulate_ctxt *ctxt, int dr,
 	return kvm_set_dr(emul_to_vcpu(ctxt), dr, value);
 }

-static u64 mk_cr_64(u64 curr_cr, u32 new_val)
-{
-	return (curr_cr & ~((1ULL << 32) - 1)) | new_val;
-}
-
 static unsigned long emulator_get_cr(struct x86_emulate_ctxt *ctxt, int cr)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
@@ -5582,7 +5577,7 @@ static int emulator_set_cr(struct x86_emulate_ctxt
*ctxt, int cr, ulong val)

 	switch (cr) {
 	case 0:
-		res = kvm_set_cr0(vcpu, mk_cr_64(kvm_read_cr0(vcpu), val));
+		res = kvm_set_cr0(vcpu, val);
 		break;
 	case 2:
 		vcpu->arch.cr2 = val;
@@ -5591,7 +5586,7 @@ static int emulator_set_cr(struct x86_emulate_ctxt
*ctxt, int cr, ulong val)
 		res = kvm_set_cr3(vcpu, val);
 		break;
 	case 4:
-		res = kvm_set_cr4(vcpu, mk_cr_64(kvm_read_cr4(vcpu), val));
+		res = kvm_set_cr4(vcpu, val);
 		break;
 	case 8:
 		res = kvm_set_cr8(vcpu, val);

