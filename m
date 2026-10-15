Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF2F4E50C4;
	Thu, 15 Oct 2026 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073808; cv=fail; b=bwylyYeHqJQ3Zd2V28aZGuX7wVvzkgYlnFPbytDxhdBOVB6onzSbaogii8qR8M0CrAdBzLo6Xtkn8961aPUrCJWj3jQed0do8raj+0IeAwl1aY+H/P1UEpbHEss1+m4ch5sirFzKhTvyPS/t4Ipbs7XDwNbH3AiPndnSqTtKAJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073808; c=relaxed/simple;
	bh=fURyFm+WYw56RdCrtS3oeKnp+iSpiNmanYga+ocBzFY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UFiLKV066vWKdWqHiqHnqmzCWVXjCX2R1r3Mti1B3l3hXOLH4kjqC30Cs/jfKze9w+o4eX3sOnNj2BjTxdsoDCFdTnb5dqOtH5h8ktq1XRay8j8GSFS/inRULsZVD+W9Q4j8Xo/K9vK1hOMMdDVXJr9RwseIdFegJc4H/qexrBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqAGPvFJ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqAGPvFJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792073807; x=1823609807;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fURyFm+WYw56RdCrtS3oeKnp+iSpiNmanYga+ocBzFY=;
  b=dqAGPvFJwC4vhbnO12a4nEcmIPI0N+D/fFmVhLs/RJtMk2v85DKYgH+p
   lWc4w+nTnl2DxTLQKXsvnbImvMe2Sm7j8O2kqbkyszYTLQa2rWRfa1oyq
   8YYuCcohpbu665k9SL+fjm93LelTkT/JNMao6UhpREFweX1T1R4oKdL/s
   LUTdpktihzN9TFKArWZvDEQXs0hUu8lo1/pigHNtfZ4M14nIXgXBfJlJQ
   Qamx+CuhaPh1ei0pjy0uZC8PS22rEwSnw6IICLT3deoL2ESRleJ6EX5Du
   gIc3RdG5lAmKVZzfr03ajf+ccJiXSSsCsPO8Rb3RrGRRP+p8QW3kU40qx
   w==;
X-CSE-ConnectionGUID: w4oNW7i3SJ6Zekyo2IXolg==
X-CSE-MsgGUID: 7ZURP3C+S0Sdg+zXh0A4vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="730633"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="730633"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:16:46 -0700
X-CSE-ConnectionGUID: jMDo1sKsRa2JdkNcELN9bQ==
X-CSE-MsgGUID: Bl4QBh+mTqKV0ktQhFAaAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1951452"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:16:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:16:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:16:45 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.66)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:16:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSGNeLuSus6BdOXKgxHk6p29tQtz8HoKdvJX5TA+b7Ocp5sIXDostQkcgaHlNiTpTcmEjxhpaSFp4JAR+v67f7a7NCxpix8trWEnNdZ2tn8WCO3/biwqpy+3OURzl2VbwruitCZqFUkyROqJdkOz2hyv53cD3j2pl2ROrHvjW8b+LCV3uO1XtTzNRJaeavvVdjBeVzO7py0kl7QR16/uG22N1Ws6bMoVqD4Kn3OJrtj550TMxGBtftqwZ4tSKsBPkLhOHDY1f2YAc9/+qxREE7AfjTUMGmYKeQ+6RaVeUBfz81IRd0FS365lxgLN/WV3TKpst7aRszwroOO8IrdYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aq2vJI879IkQFH2iXQg3+6C5qYmoaGEXp1CMIXKlmfI=;
 b=fqibgrbKufl5RSekFohiZufo0Q7WFKkTAtnA7b3H54GbACOD54UuHIlHOYWA6urPXIo6fIWQVXXpgO5Qz96QwinMTb2S0thftWtmeDYH5inR30CSIwLzAhSyU641yBfUXorO0PAGWqA6Nri0Mb91G66CR5rXLtY1gR22j28+wnWLdWCrQzSxCSJUjoDKwFBRHf8TAe175RNjV8gZeFhowvKbFUm8SuOdbAxZjtA5ZPczG2m1qiJ3uW/k4rmBXNkugBCxxN5YkmWiYUk1fOQn72SM3XrP5hv3QGafG8bmHt6FlNlRKCpzUHQV2rfc9IuLsthwCsr4sVUen5xtmo85JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by BL3PR11MB6531.namprd11.prod.outlook.com (2603:10b6:208:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 14:16:39 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:16:38 +0000
Message-ID: <a421e579-f6ab-429e-aa00-4fe8e02a6773@intel.com>
Date: Thu, 15 Oct 2026 07:16:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/18] x86/cpufeatures: Support Privilege Level Zero
 Association (PLZA)
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <6d0336754b14f33fbc3c5e276ffd7ab12e0d0435.1790867441.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <6d0336754b14f33fbc3c5e276ffd7ab12e0d0435.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:303:2b::18) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|BL3PR11MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 04336e8f-d2f0-42af-37c3-08df2ac6ed04
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|56012099006|11063799006|4143699003|261009223027099003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: Q0Gn/H+0eYKPGnKpwc+yZH1zhlfNGSVAmtEF3PCurGoTThlDYw5QQT34WbEA4bT/DcgF5F49cNKlDGdwuVBn1EmuLGXAjEgcgYO6sazkvdl9yHBo+Y0WuZJtwzuqpxHTSeqmPsZNxhu3hAQ2O8D+Eek2zgpyUnunfuSIG2XFuBQyf16cOTiBs+sAnKg7G1N7rxHJpbQ3/wo4AVrJQsAXizUIIIdTQs+RQL3wS4SXl2eJRMlnQosUKgdMDvBb+qm9ctRZ1WT0SUKZu3LpPOgSe46xrlTIu33NHkGpq7zqNlD4urjSsPlllPzgNfw+DGtVoa8thwi+zrNyE7AFpK7xfD421FIED0FLr1qaVL7oa5I+R6bLiekpeNYrCY2FqkPHygUteBUFOnX5SSTNuSza0GxHe9nbp2w8q7xCejxVULGM0Ga7vghGEQFYcp+MELJA+IlNR+RTnxAbF4pQ+G2Bov4438K3MuFEd06SxQoMWo6c6p+vqVMWlkUCtF9O2sZWAZLimp2RmAbrjPDNxyXkdmg1L/aOvwx+dpJF5n/N5nKdiJvwQ2t29VTz5T7GYfPyxeN2HRvyjnzxf0A6nuFy5k8NBmMDWhz/i0XE3my9fIXF0PGpAzPcrnzU85/cICRc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(56012099006)(11063799006)(4143699003)(261009223027099003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1ZZaWJqZjk5dDQxbkRFRXplNjlwb21JLzRGRCtSY1hzL0dwYWxsOXZyUzhQ?=
 =?utf-8?B?b0E0Nnd3WUs1a056Z1dvZlVyWGVUSWNURllnMDhTc3lrSXVQbnc5OHpnTmxW?=
 =?utf-8?B?VW1DUDRreEpseDBQaDZOTytURE5HcFZMR2pQN1ZiSlVtd25rVVU3Q2Y5b2ZM?=
 =?utf-8?B?aEJTbzNFMzRrdmFNTGFrNksrN3ZUVWpZU3R4a2FucXZGZFMwOVcvNTUyYTd1?=
 =?utf-8?B?NDNCT2RlQVF1VU1FcW9qQUs2ZEpidldkekVwa0hscUlpalROZ2ErZmhOVDQ4?=
 =?utf-8?B?Ri82MnpEUExGL0RVNkx3NmRmL1IxelVQZTZNdk1pMjlNYnYvRm53NW9JTGxx?=
 =?utf-8?B?WkVGYzZSVXpmSWhVUFdpZTdSSHRKYkhPOVljRWp6ZE15ejB1aFZwOEJ6cS9n?=
 =?utf-8?B?cDNoN2dTZEpmazNhZ1dYL1NQYnNBWFBMVmxNcXp5dGYvTktLNXI2bUN4blIz?=
 =?utf-8?B?T2dsR0FaR2NtaU54SXA1K1BPZDFqM2NmSTJHdlZjVFdMOGg0cTNFMW1nakNF?=
 =?utf-8?B?R292cjRyV3gwQW1iSEF6N0VJeVgrR3Rpd1ZkY2dsQXd0K0dsOWQ0N2hrdElp?=
 =?utf-8?B?UE56RXFlczQvNkVGK1oyODIrSXczV1VqYkJwbkVPWU1mUXdNQnE3RW1aTVEv?=
 =?utf-8?B?UXV4aWVXVTBiZFJUamlhSDgzVVJ5QzlVMEZPMVNUMjI3a09BK2l6LzQzb3ZC?=
 =?utf-8?B?cVBmUmdmamN1SXhwMlVLdUdteFZZRG4zU2pGa1dkN1B1V0d0QmtQNWpodDdQ?=
 =?utf-8?B?QkxCeHRBOFBja3ppSG90RHdOMTZFeFZGZHBvL0FMUHdWZ2p6a2VaV0lsQlNU?=
 =?utf-8?B?dXlITG5jbFhkRG1wdDhVOHhJWnhuQU5tTTNXTXlxSWorM3FXYVVHL0hiY1Z5?=
 =?utf-8?B?Y0lXVkl4YURhRHhYbFljVGdmNWdNRXFxQVM0cHI3SDJqS0NlNTlRVWxGempZ?=
 =?utf-8?B?bmZ2c21PTDVEb3lpaUJxMFNZenhZSU9vUlBNS3ZITjllS3JEY1dKbWJqUloy?=
 =?utf-8?B?bm53ZFNsZnlrcWZUMXpCSHZQVG1uRFhycEMvZFd3WndnbUxGSVRUZXJ1eWJs?=
 =?utf-8?B?dFpHcmhSOEZ2UVJ6YStEQ1R2S2VxMWxleldmTldCR0xsaWRiUnhWWmNpdDJR?=
 =?utf-8?B?SzcyZkgyWHVlMTQxSEdBMUlXVStqcG9zSGYvV1MyeE5LaXNHdFRWTnUrM1hW?=
 =?utf-8?B?YTd4aHhkSGtSdHFGVDBJWGdaRjFmdlpEM1dZTVM3aWRBb2Z3NGx4clBCY1ZR?=
 =?utf-8?B?UzZ5a3RxSlRFSXFvWUpLUHJMVEZvVThzT3RDUXljbjBBS2d2WENBZ040RmF6?=
 =?utf-8?B?WUM1QzN4YmNxNnBCY3c5MzVpSDB4YzdrSXZPczNOckt2TnVLNjVTMlFZNWhW?=
 =?utf-8?B?aVMzNDYwbHNTQU85VCtWbm9Cb1c3cFNNTzA4S2twRWFaS25lTnU3ODljQkdk?=
 =?utf-8?B?ZXhscEdNZi96Nk9zaUNBV0duMmVKclR1NXFRSVNNTHRkaDhKa2Focms3dlcv?=
 =?utf-8?B?QXJsYUNEbjlQYktjWkVmZTJJKzBzRlRjRDM4bVZiamNBUEY1aWUyeFVUbWEw?=
 =?utf-8?B?ejNVeTJ3d2txeGdZSlBHZE9GU2NLVTFKUlY1VVo0eml3UFYyc1dnK1BXcmhL?=
 =?utf-8?B?OEY0dDRRenM2Q1BuUG5UNVFpaUNMWGlMTDJjY0JuMVdOV3BXOWtzMG04Yjl1?=
 =?utf-8?B?bThqNVZNcG9Za1FOSzUvaDNGU1ZkZFFNNG5ZYVBZRU4wanpJZXhFUnNJR2ZK?=
 =?utf-8?B?bWN6Qk8wQlpUN0tUa0pvWnk1Z3BwekNWZnYrZU4yTmlsbTZmeWdROGpYUnov?=
 =?utf-8?B?N1RkM2ljN2VicDh1a000ZGZZaFk4NGtubm5kL1FBSEFTaG9vYnhmVjRMMXps?=
 =?utf-8?B?dTFRL3NwaFNuU1dJMGlYVWxSeG53dEo3cm83WnFUQ29WNTV6WElrbnRXTEty?=
 =?utf-8?B?dzFOMlp5QzdrcmZ5aTJaOC9vUWVaTjdYdkxwQVRrUjVFdHY1dlZhOVVXNUp3?=
 =?utf-8?B?NmxPc3Q0eVNNVXMxR1gwWUt3b1pZSm5IWW1Tc2xlekFCOXNFdXBDZmUrK2Y5?=
 =?utf-8?B?d0ZwaE9VZ043a20xbkw2UzlxZlVXdHV5UGkyZUp6anprbVJwaUh4bXVsUmM4?=
 =?utf-8?B?d0g4bDZ2QjVTOC9pZnpPSDhvbkpvenYwTmhtZG02Q01UM1JDZVE2cmJoTDNN?=
 =?utf-8?B?N0tEVHVGcCt5Mzg0cy9PaEdkQTcxWFRZdng0UlNDdHZhVk5UR3dROWNJa1M1?=
 =?utf-8?B?Y1g1RGk1RjNmR3ZMb1B2WThoV1pqejVDL0wvM1ZNQlpwSm9nVHlDV29JSWw1?=
 =?utf-8?B?Y1ZIajBrVjFlMTBQYWVKaWQ0TEwza2JqdjRRN1BJNWV0R1NyUWhrQTZyamtU?=
 =?utf-8?Q?oaDIKUYOJMItR324=3D?=
X-Exchange-RoutingPolicyChecked: 3KmSz5eKK1OZVhku0YpPYD8bigNo4FxHVtdAsMtmn8Vu9M5oXRyj6h9tuWpwXtjRf3GHfo+iCI4Str9hsmMWxZI6I7GZ4+LErbX3La5QxoCjykaui4aIlAtHjkzkaGXXK0KdHO+FhNALhgMABDL+BbrazAm92VuQfTnlJXyh1WNeB/uVPDBaY/x/KTPU1z3KZtJEK/gp3wxhFMsm5xsUuDA/o9VVQhNnXq507Z7+upy9dtP8g1xMJX8G89GM7q6YM615H6YQjLIWz4HdLb287lZAvG3gVL1LGMqlRu3S+1wuOBlZSMYtmS8n8LP2ukqckeeARVri7npSeB8J48CJGQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04336e8f-d2f0-42af-37c3-08df2ac6ed04
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:16:37.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VD7F+oAo7x8RQSBSYFTvis3PaA2ARy6eKJ8LuExHW092MT0H9xEVxRwZdv5s2a2cxAW/Rs9/TiaiOZIdFI9/rOYA6wVeKAcYO24ktJ93wks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6531
X-OriginatorOrg: intel.com

Hi Babu,

On 10/1/26 8:10 AM, Babu Moger wrote:
> When memory bandwidth associated with a CLOSID is aggressively throttled,
> and a task with that CLOSID moves into kernel mode, the kernel operations
> are also aggressively throttled. This can stall forward progress and
> eventually degrade overall system performance.
> 
> AMD hardware supports a feature Privilege Level Zero Association (PLZA),
> which allows the CPU's CLOSID and/or RMID association to be changed during
> the transition from user mode to kernel mode. This allows the kernel to run
> using a different CLOSID and/or RMID than user space, which can improve
> system performance and/or allow kernel work to be monitored separately.
> 
> Note that PLZA feature associates CLOSID and/or RMID to kernel work, and
> therefore influences resource allocation and/or monitoring for all
> resources, not only memory bandwidth.
> 
> The feature is detected via CPUID_Fn80000020_EBX_x00 [Bit 9]: Privilege
> Level Zero Association (PLZA).
> 
> The PLZA feature details are documented in [1] available from [2].
> 
> [1] AMD64 Zen6 Platform Quality of Service (PQOS) Extensions:
>     Publication # 69193 Revision: 1.00, Issue Date: March 2026
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
