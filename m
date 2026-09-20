Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090893FA5E7
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789948591; cv=fail; b=QvYaznWGIR53oOljsfhx0CHs8i6UQzfpLU0bXuXYs74yF9l2T98YDZIW9RxZ6nS4nOb4YhepFdKYGbFtf8qLdV1deCp2ITG3nW4V3X8eKt7CZ6c93oT7nJZDxvOkjrrhabLv4lT1T08qqmuOC1Ty1HNctDDxUEjCh4SmU6o26G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789948591; c=relaxed/simple;
	bh=B4hf9Z/nmYZubsbk+Is4ONTkIFI1V/UoxDv0u15EcNE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TOQGU5+hWcU7XH5lAsOpM0NRzDNFv+mb5cjCDRbllDrDlyzEN1Lp4KISk0JUkQqj8J+yUbP0LKZ3BpreNfRn/vT68xePpq9uNJo3e74evC9LvFruqlFPhM8hFwysOdnDuB/Cl8ttS7y4UaDCmdC01FkV+vz88jopIZPq2w+RdsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hk9ECErw; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hk9ECErw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789948588; x=1821484588;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B4hf9Z/nmYZubsbk+Is4ONTkIFI1V/UoxDv0u15EcNE=;
  b=Hk9ECErwzaOd3hpOCCtbsubqOLlfvNB+JSKfsLEuJ1ha4Cfx5UFjOnbJ
   bpZ95ZpFO6YAB8su9Iy2j78/Bav0IshKJ/STcRpPWJTqB6cXp/vKA+rzb
   D3J3ZOvykTDPdNTSwwgO7Xnbl40Q/f2cC5WfmOt8B1WNGZ5l71oiWWlSL
   2lesHM+VNEf8koJ/Bj6neYqAcLNDvJ0L280YDqR4MByyGDz4sHW0nLOxj
   NFum6YvZa+ICU4o0dFskv/DFIEA9We9RP8H9tN3fGBVuZjcTj7ooB902R
   kf9D7pwO/1bJ0JzN1N8Dp01SHdAYjeXH8bAQwAQe4kmEpsYJDmcmYhFQ5
   g==;
X-CSE-ConnectionGUID: l/80G759RNCSdt4F4h3vBw==
X-CSE-MsgGUID: 2pVEv2LGQFCfsyf+fun2lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="89364151"
X-IronPort-AV: E=Sophos;i="6.27,112,1787036400"; 
   d="scan'208";a="89364151"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 16:56:27 -0700
X-CSE-ConnectionGUID: 3tckwOPHRmmF8tHTkuG2vA==
X-CSE-MsgGUID: QEqEIpuTRrOhc74uGtwGTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,112,1787036400"; 
   d="scan'208";a="3433014"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 16:56:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 20 Sep 2026 16:56:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 20 Sep 2026 16:56:26 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 20 Sep 2026 16:56:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuoFxBmIrG5gbUWw+8m+nwm2/6fplFTUYjIVu4vD1+NO5+BknL2tCveuxSOU7mqpS9HnUfNKCzu8jKFcWZfqbLVJ+hFWtJAlu7UAI7pZnew3VDVrf9xW6eMPimmS1YqAJ8YDhiOMX3/Z2HrOpz7hoMpZJM89qA67KVieLCWtdYnfRC40hvLkFCFRZlNQ7Qp7097Tzi/1PLlzXrTfqrQrI19jcMsKp1KZeayyaTzPaLovf3wiPvS0IUzw2yx+1bJZ4+e5NU/EXFxkdBUWGdk2iEn2im2LfLpLs8/e/Mv4XrZRgGYhhbY54iM3fJ3KvNmHoBjQRQ1fXItQnP2plcEf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/jQelG60LPJ+C4CuwZAJUmKO3XVylPU7n4AcI9IE98=;
 b=EkLhkZURXYmEgtgHMMRNrQUJBAl/TwqLz0rqWyHcFgy7Ohad9luWJFLp5Tl+FPHttKTpmd0zcb9MkDvd4vin05ZPi/AAAaWmecZd2Fman6OmPIL6bdF2HqMT5FUw1AR7KQ0g8OQmgcVKZJ2h97W3oNw5hLAZsEqeACR+LKsHIehFYdR3VykV9WW8E5vCqryMdc7BFgF5/SQoJacCgf5vt8EHPCc2WshSkmiGpUhOYlvP10ZhxvS9y4liknZYTUIUih1GdqoXOVKDffDn8grsK8rixLCqcWSkv23aC+gmpx8yYwfY6xcOvHRIieo1pQTVBEC5vMlOlkhxn9u0lDceJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.16; Sun, 20 Sep 2026 23:56:22 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0428.015; Sun, 20 Sep 2026
 23:56:22 +0000
Message-ID: <a4ec3af5-5494-4fb4-bf66-e3a8b67325e3@intel.com>
Date: Sun, 20 Sep 2026 16:56:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
To: Peter Xu <peterx@redhat.com>, Artem Bityutskiy <dedekind1@gmail.com>
CC: Tony Lindgren <tony.lindgren@linux.intel.com>, Paolo Bonzini
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
	"Xu Yilun" <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::32) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|MW3PR11MB4620:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f993351-0ac7-4f5f-ca4f-08df1772c5e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|56012099006|5023799004|6133799003|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: aOyqLF6IreZ1VAoB7EsStnUj8It9zDqZsDanX/czHyojTEJx9zy2IJbWd3Aa2loFkXBv9PLxGsBdjUEEnik9XukvsDUjWFGKTIvAGJWNve9sTSqJtBUvsTwpAOmADTFchi38FNs9RmloVNm5UpPOn4UBU96msGc8QuijI0KP8MliZxvmpROWQQQyxKM1xmQuWkzUUflmdE9sVvN6zzI37zpUkIZLICxAuZ1SW7NAlbWTeSgG2tBKpEQ2ceb9JSR6RtwnUFCM1qv2lZA0HU9ZcT4RgZ+u044oFdasH/hy0BTrEYefPBJsUV/bpraqouZ2GE/8RKbejAF7ElrT3MfKDW/hhwRkUrFciVZx9vYpXJvgp8CNHx0NUKq3wi5GkmA7WK6SXEQ8y3WSoLCeoHOKR6qjfsQmvHB1fz9bcDzRbq54CanTqlR5bFw+Ptt3eFDfVtlIHo0bdr/5ziLMVNYUtu3gQS/kju4nUNCyq1jOdHIe5mGm2wWLb5OUVC0jM1iZ6Cv5EGytM1fvjqXYnE0QF+IajFcqajF2I/RA50VaVYLQLLPuni9p7U38palNgTxnka/fPNtyxEykyZt/i0akqtZDtTV4VFv71q/6D+CDPjy21bidXntChk9kvU/VgXGOXkPQNHaYQEHeesRcKMRsgOGYmJCRXNn+yMEGNOYQyKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(5023799004)(6133799003)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dER0UVZNTnZLQ25hanpxd3d2Mmxnb3lGeEdPZHA5bVVZczIwR0JiSyszWGdY?=
 =?utf-8?B?VjJIM2VxL1MwUEdKbFpQOWVVRVJoNzBZOFkzSEYzeWFZcnlaTDI2S2tlZ0Vo?=
 =?utf-8?B?RVpTSG9WVzU2U290aWwyZWtzbGZPRDdWTmZOU25nMG5VOUZhN3V4UEN1TFhJ?=
 =?utf-8?B?bDcxNHlJT2JsdkRLREhMalV5TGZWd1pmblM1T3daWER0NDJ3K1RoZE8zc096?=
 =?utf-8?B?VDFndkladXJaaTlqSmNSd2tSc2g5QTNpdG5nTEpQYlo5VFFiUVVrTk4zdHM0?=
 =?utf-8?B?V0Iwby9tNXRVUlEvM2pFVE1iUzNOYjNramtmbURZSzJrZGs3Zy8wTWk0S2Nn?=
 =?utf-8?B?QW4zYU0rVit2MFZmNjdDQXhFK1VBTnN6OG5HMERydm45aTQyamtBTkd3R1Fy?=
 =?utf-8?B?eFNMZGNWM0FGL2NMaTZOYzJaM0E5dXArYmg3V21memVtR3YraERpUytFMUdl?=
 =?utf-8?B?THlUM3JDMWU5QmhSaTY1WVhrTThxdmhrZ3ZTRHI5Nm1iZ2xJMjJvQllaVU12?=
 =?utf-8?B?S0pkOEpTWHhUcG5aK2Uwb3I3dGhGYkQ5VGV5K0xvOHJVaVFCL1Z4cDA4M1Yr?=
 =?utf-8?B?ZWdHY3RqYmJOQWVyc0hnUW9NWkxycElkazZub1R5R09PK0l2R3dHRVpYWEdw?=
 =?utf-8?B?czE3QitvenFaNmJYSk1vM3VOTmpWNDBTVUpUNmNCREtQS0NTWmQ1L2xpbVZ1?=
 =?utf-8?B?YzFxNWdnUFJFVnFreGduUVlRcUY4cFYrNDZiUm4yWndyOW9tY3YvSXBXcXZB?=
 =?utf-8?B?S3FsTENiOFhXV1M5b0ZoRW9FZDFjb1Fhcm85VGhieCt5RzVLMTJrWXdNY2hy?=
 =?utf-8?B?Tm1rdzJFSDlmaVVrSVNpUTN5dnppRGc0V2ZYSzExY2xkVW1kbTNMaGF1a1Y5?=
 =?utf-8?B?UTRpY0lFY0pZakZ1ZTlBZDN5TVlBSjZwZjNyWE5kZmxrUmZZeDVNcFpLRStQ?=
 =?utf-8?B?TkwwZFRGbUpSS3Rzc0p4VlFoaEVCOENCNlZMckd3UDF3K2E4SHpoNk5kSWRJ?=
 =?utf-8?B?bUx4Z1U0cVc3WVoyQ1FsTHYyOFhVck90cG9qRkZHVU1sN2NXdzk2V2p0aEFC?=
 =?utf-8?B?ZCt6UkgrSVN2aUh4OVZ2N3BrdmsvazI2M3Y5NEJIb2VDTWRoM1lNMWl0cmI2?=
 =?utf-8?B?T1NrSzRNblBVZVZzajk0dWEycVpmMklrR3MyVVRrVFE4YzFEVWpWZnpaUENq?=
 =?utf-8?B?N0JQSDVEOW5HdW5SZzNWNDdPbzlJVWNCLzhIQjR6bExVQ3pUNXlWaDlHVks0?=
 =?utf-8?B?QnlqNXVWckRIcFZ0RkNTVlJmMkRQdlF2NlZYT0ZILzdFNVVSUjJFanRiUHBm?=
 =?utf-8?B?SnhBTGl2TUlpbVUwQXoycngzMVp5UEhLejl1V0NsRC9oMXp2djF2cjRmeHk4?=
 =?utf-8?B?bVA3cmdMUGZYNmU1NGJsK2tJRkhUbGVtYS9ac0U5eVRCbHp5NVI4WVV5Qnpj?=
 =?utf-8?B?czFNdk9PQ3dVdUgzVjE0Z0d0WUR3K2swdzR2bUo1MXVscDc3cjJXN3pZbzg0?=
 =?utf-8?B?cEY3elpLQUhCbkpSRU9Oczk2dHlzeUNQQllsbjNaMEhYZnpKUEt2RnByT0RE?=
 =?utf-8?B?NEg1ZmdrT2JWSWlvMXFjMklFQVJ0TGZPa21PNTB2azk3Sm11dTFTN2Z3UkxN?=
 =?utf-8?B?WEdNN2oxcjEzU1ZRMk0yM1VMYzBkOUhnUldxSE9hVVJCcmFmM3FTWkZnS2pF?=
 =?utf-8?B?N1E0a2Nyc2JtSThGT1RLaUNPSXhnSHJDZTZ0MU45aWJYM0tkM2JkYXROVzJu?=
 =?utf-8?B?Vk9TcVo4V3JZTTJGcHp5RTlDa3FTVHlNZk4xL3Vnc1Y1b3h5ZEpOT2YwN2VW?=
 =?utf-8?B?V08xLzhRcTAwZjJaUXZEdGZaUktKS1NheVpYc0hhdjlxeWlMNkJJd1ZXaHla?=
 =?utf-8?B?Y3plOVBuT3NkaUVYd0pUQjlWYkRLa0wzWlFTRkhFUEFwQWZUMjhERWN2UzVV?=
 =?utf-8?B?YVFNQXFSUFJKZDN4R3J4UnBoYW1pSXdaVWdDMlZRS1hxMk9mQVJmNnZnTU4x?=
 =?utf-8?B?UVkrK3N5YjkwVGFBclNydTBaWlFpTkwxYW1LYlNubG8rMGQyeW9tZnU5eVh0?=
 =?utf-8?B?YVhyUzZmNjB5ZU03U004cE05OGN2T0JtNldiZTdtN3puTWJQclFKZTgrUjBl?=
 =?utf-8?B?d1MvbmtySWNldWhhY0I2OXNHS04xb0pSeVF0dFVHeG5xL2pDb0dVRnJ4bTFx?=
 =?utf-8?B?MXZEcHk3aUZWMytDQ0lHQ0pzTFlSVHlNYXZYdm1lTDVLK2JGdmZJYzFySzN1?=
 =?utf-8?B?STRQblI0bjlPWnJOcm1COEFoWE91Y3BZMTJ4WXBmSW1pdVRhd2ZONHBJRXV2?=
 =?utf-8?B?M1JoMVRGU0xmN2FkN1ZNUHJHWU5ITER0R0YwcFpIMVhKbmN1eTYzUT09?=
X-Exchange-RoutingPolicyChecked: ibrKnjseIwLafXAcFKt6TAaJ2/zo1B+dKitqteb6g5P4/X7InbHzQtxZkLiVQT0GuoLH5rzi1nA30KJlx2zR8EDfyX6D1c5r6o2RJQGc06VPmxQ5AKRg0PaZRRZkgnWXeiPT1fxSYwwGBaOuO8pl6uKHSDiW6RUeX/q5Z7VD336vZmGABMnIY9WPUP9M2GcifrXgz6PGBlOTGG3B5GzwzySMgQarmruTAfqj5KDyPXEm6zZRh+PuaAadyKMNXakiWsRVG9qRUd1vbtMiagLWEyjLT9vPBV+ZCs1SvO0JdxIpiUZehRSmVLA9qHFImsnQ+sSHac+pXVbWN7mPLoyhHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f993351-0ac7-4f5f-ca4f-08df1772c5e6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 23:56:22.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxxqW5Uj7Bhonz3wRrSexrNvW1PpAKr3gkOFvs4Pat1MXQxFJeq2Uq9wWrohIOTjL62vebwroQaFhCcQQT50EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com

Hi Peter,

Thank you for your comments. Just adding a few other details to
complement Artem's response. 

On 9/17/26 2:27 PM, Peter Xu wrote:
> On Fri, Sep 04, 2026 at 09:24:25PM +0300, Artem Bityutskiy wrote:
>> On Mon, 2026-08-31 at 10:13 +0300, Tony Lindgren wrote:
> ...
>> - Should the same uAPIs also support traditional VMs? But the only use-case
>>   I imagine here is "for testing purposes".
> 
> This is an interesting idea, I think this could be useful.  Especially, I
> wonder if you already have it done and PoC branches you can share, so that
> I can play with it.

I had once attempted this and hit a breaking case while migrating regular VMs.
I didn't dig further since the primary use of this UAPI set is with CoCo VMs.

Here's what I gathered: KVM-mediated transfer needs KVM to resolve a GFN to the
HVA where the data lands, and on x86 QEMU mutates that mapping at runtime in a
way that is opaque to KVM. For the PAM window QEMU overlays a separate region on
top of pc.ram, and KVM sees only the flattened view, the winning memslot, with
no way to address what that slot shadows. On the source, firmware reprograms PAM
and QEMU drops the overlay. On the destination the firmware never runs, so it still
has its boot-time layout and the overlay is still in place. So importing, say, GFN 0xc0
lands on the overlay's backing store, which is a read-only memslot, and the GFN->HVA
translation fails. I suppose even if it were writable, the data would land there
rather than in the pc.ram underneath where it belongs. Without mediation, QEMU is
able to write to the HVA directly, so the problem doesn't arise.

Generally, I think KVM mediation only works if KVM's view of memory is authoritative.
TDX skirts this issue entirely because QEMU doesn't create overlays for TDX VMs.

> ...
> Could you elaborate this ITERATION operation?  Is that something the
> userapp must do after full scan of a round of guest memory?

Essentially, yes. TDX migration architecture delimits such pre-copy rounds as
"migration epochs" and emits an epoch token at each round boundary that needs to be
consumed on the destination. It allows the TDX module to verify that everything from
the prior round has been received at the destination and that two versions of the
same GPA aren't sent in the same epoch. It is userspace that decides where a round
ends, but any deviation from this model and migration would fail.

> 
>>>        |    (repeat until convergence)                  |
>>>  CMD(STOP_AND_COPY/PAUSE)                               |
>>>  CMD(STOP_AND_COPY/TD_STATE) --- VM state ------> CMD(STOP_AND_COPY/TD_STATE)
>>>  KVM_EXPORT_VCPU             --- vCPU state ----> KVM_IMPORT_VCPU
>>>  KVM_EXPORT_MEMORY           -- final memory ---> KVM_IMPORT_MEMORY
> 
> When read/write encrypted memories, two questions:
> 
> - Is there an upper bound of the buffer size per-page?

Yes. For TDX a 4KB guest page produces exactly 4KB of encrypted payload plus a small
fixed amount of ancillary data. The bound can be pre-computed and userspace 
can size its buffers accordingly. The UAPI itself doesn't impose one. The vendor 
implementation decides how pages and ancillary data are laid out.

> 
> - Does this operation supports concurrency?  If it supports, how well it
>   scales per expectation (e.g. is there known big lock for that)?

Yes, these operations can support multifd and kvm_memory_transfer carries the
channel ID. The encryption/decryption work is per-channel, so it scales as multifd
does. The one serialization point is the epoch boundary, i.e. the ITERATION call,
which has to drain in-flight transfers for that round. That's inherent to the epoch 
model rather than a lock that could be dropped.

> ...
> IMHO we should really take postcopy into account when designing the API and
> state machine.  We don't need to implement it in the first version, even
> until merging, but we need to make sure postcopy will be new ioctls on top
> of existing and it should have no major loopholes that it'll need a new set
> of APIs.

Agreed. We honestly haven't looked at post-copy in depth, but supporting it thus
far appears to be additive. One item that comes to mind is a new command in KVM_MIGRATE_CMD
to mark the post-copy switchover point. On the source, vendor code could send all
previously exported and dirty pages (deferring all un-exported pages to post-copy) and
prepare to serve pages on demand. On the destination, vendor code could make the VM
runnable with incomplete memory. This is based on a preliminary assessment though.

> For example, I think we should consider KVM_EXPORT_MEMORY being usable
> after END on source, KVM_IMPORT_MEMORY while TD is in operation, etc.  We

Yes, though I think some of these details could be handled in the vendor
implementation -- e.g., KVM_EXPORT/IMPORT_MEMORY might not need to know that
they're servicing post-copy.

> should likely also need to still picture the rough process of postcopy,
> reserve those APIs since the start (but return -EINVAL or something).

Agreed. We shall attempt to sketch that flow. Your thoughts and feedback would 
be very helpful as we work through this.

> ...
> Could you elaborate what's the relations between TDH.MEM.SCAN.RANGE and the
> GET_DIRTY_LOG ioctl?  I recall above mentioned GET_DIRTY_LOG will be
> available even for CoCo, which makes sense assuming dirty information isn't
> confidential.  However then I don't understand what TDH.MEM.SCAN.RANGE
> plays the role here.

GET_DIRTY_LOG is the UAPI, but the slot dirty bitmaps need to be populated somehow and
TDH.MEM.SCAN.RANGE fills that gap for TDX. It is a SEAMCALL that scans the SEPT upon
request to return the list of currently dirty pages. We wanted to avoid inventing a new
UAPI for this and GET_DIRTY_LOG seemed to be a natural fit. In our current PoC, we've added
a barebones kvm_x86_ops hook that is plugged into kvm_arch_sync_dirty_log(). The TDX
implementation of that hook invokes the scans and records the dirty pages into KVM's slot
dirty bitmaps that GET_DIRTY_LOG serves up to userspace (as usual).
