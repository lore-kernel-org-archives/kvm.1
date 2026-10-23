Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792721069;
	b=ZWKjZO6KoE856gyqmmLNnw99SJSiB+1tLazsHZFr4VCbse2xs8tU59ahz1A61N+z3ui1
	 EUcRK/HDCrldmQPA3shFlkGhwOKHhBDP+P9jm/qj1X36oDOn7oMN1Z38xe7xvUUNb0Xag
	 yjL/r4CqAEn7cYOs3MLMLfcA39Z484xeqjmpWJgAq72c7Zoznz0duldO1k8NJbvbcM05t
	 V/vHje3jgJPl+pBKyx2b1WyET6wzX7rHq9s1Bu0RMBxwYOiV/zwnI/e4k+Dv4t2IMozPs
	 4YNGiwi2iWALuesagg9+uqFtisAxS6ds6R0fbPcseQ8pe1YcaHSrXzo0dUh9zjPBWOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792721069;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 Reply-To:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=FUMFbwNcMZf2BjOyfH4fkuzZBoL1gFU/Z8HzijYoKtI=;
	b=4SnIKS1UyxGAxy1abqNzDAIjvcOn2gSXFZhCW6EoOatoeRZajFj7F1lP/hj5srfokA+j
	 7Zyn8Qdx4N0lkQHUR8b/ZZvM1GJm7976appRUT637Q+Gi8Q+HuaRjkVGEScP48j6k+Q5x
	 udo2WCLfZsuCdB00bg2VFA4xi53HkR6YeFUfhEefvf2gGVslwSXBNH1md8UjvIvTCGPbV
	 VlkbiXMSS0Y87XqpwIUYZx3Pm35/nNH0Uf8QUlAwo0FPDLAYV4reCArklZcztTGD2C0fv
	 yuOAPmwxR3VDNQk+WGO4irIFOw0cMNNGBVfUla1/r9Gw+0vvtEd8R1I21iMQuUd9vTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QUZ9sBN2;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D657606A319;
	Fri, 23 Oct 2026 02:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D657606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QUZ9sBN2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792721067; x=1824257067;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Zokhs9vfLBaEFgM9mhiUHeTYRLFp1EXbkMkPwFLl6ks=;
  b=QUZ9sBN2i2VzpjauH+MTFSW9HM4S94jtheUfJDjM8RZ2FJI9dQLXbgcC
   ImbeFR2WYHiaAfsWVKqimxKvbMIW8iRMW2lARDvhoTYT1XwjItl/+1uJ4
   zGioqTXSR0VXDnFX5FjDj9D8poRvzQ5w7Fs8o0qzAyAVxQsLryG+L/l+B
   8umEVGVL04gxK2V5OsYxd8Dkjwy8g3nCeQeBpkN/kqpRyP9k7ELo+dIQE
   +QRbDrYQ7rxUpjedgnbqZpDShZgwpIQjbB7f99e4TaKrwR51kjeb9Wosd
   evHc8+Z+YIsHkH0rQ3EF2x2H/S17YmVhA4XFbrnt8d8omEcOvu83uenMV
   A==;
X-CSE-ConnectionGUID: 8Y52JiU1SMSw7LSY7z7Ktg==
X-CSE-MsgGUID: uTBARuThQa+VDZ4TYgowTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1371258"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1371258"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 19:04:26 -0700
X-CSE-ConnectionGUID: 7JaXWccHSo+LWBGOeAGR3A==
X-CSE-MsgGUID: QcJB1TaVRoWLDJDPyUd2EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3902885"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 19:04:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 19:04:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 19:04:25 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 19:04:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k95h6B8WHzjWjz29eUUTVcoOrSbUvuZ4Psso5qDXwDf1PNQRHm0FxnmQYZLM3vYTWTLHKze/jkPtBECx7QTyuGkrc7aISc3F2SMh8UsPInmHbY//yuP3UuqY1Dn3KHTrp5U8o0Y1miALff6+TdCykJs+Ofl8jsN9Mto5nqwq48h6vknns6sO03qmOLPNkc/7UpfTu8Gsf0c80LVw5T6hVR5lTmvflLTBeMOUn23jGi7QO9bsVO5g/qN/uFP14g/vxCXoOlAJo/842fbwPUkPjK+eDCTDh1/lMMarbq8K0njyVMQdazcLnSU2Wxl+a3YzgInuQhgfHGzrMD+fvSS65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjrjdivYz5D0avBl3nA0qRJqybaWFAM4fxcQ2WWEiuQ=;
 b=CeY5eUStKx0bDGkeGbHtC85izD23UbkkRY3NdFf+dexNLji2A95scp7BZDwVmkxU/mJr0G5j7fMMmowlh9uWOCnwfyYgmcpev/F2hGKWUZaUcDBQi/djSIUXYEQGrMG+/6QBS0F44MLkwSQYS+nBiDsul68FXTN2BI4Z2JWTEn3ROEIrGiNPRrjkvgS5Ml6INxCE3BySDRL88IFAdAdvIwZS8oLYoLiA2mG0fXFGaaGY+ik6Fd+ZPfrsjQldgKmPfdzERIGQYw9Sbw71zkb1eibSyW7Q1CLEilNSg3w7Pk0ZHpIJmIb/3RDwz89cajHk4uRGwNBG0mW5fa5hhKUBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Fri, 23 Oct
 2026 02:04:17 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 02:04:17 +0000
Date: Fri, 23 Oct 2026 10:03:18 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kai.huang@intel.com" <kai.huang@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"Peng, Chao P" <chao.p.peng@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Message-ID: <atrAZhEINeaieBxN@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <as8UwKoAaT/1HgNr@yzhao56-desk.sh.intel.com>
 <71682b712350b5270e4a0f5cddceb1da12341b9d.camel@intel.com>
 <atBaxwAG84jlOywE@yzhao56-desk.sh.intel.com>
 <25927de50b85816956e8989f402ff6ccfa8fa0ba.camel@intel.com>
 <atV5fDnckj+3V0D/@yzhao56-desk.sh.intel.com>
 <ca53c3bd37218828822a9b990a0900ca2541fd9e.camel@intel.com>
 <atm6NBNrwYc+Y8yo@yzhao56-desk.sh.intel.com>
 <55ccf641218c6553b2f43f4394b92c23bd8b5d98.camel@intel.com>
 <atqjeaPTXmCfiQmo@yzhao56-desk.sh.intel.com>
 <29790651d7a5d8727f956985823c17e3dfbdcc24.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29790651d7a5d8727f956985823c17e3dfbdcc24.camel@intel.com>
X-ClientProxiedBy: JH0PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:990:7::7) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
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
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|SJ0PR11MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: f9666457-5fd4-4ac0-7171-08df30a9f1ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|22082099003|18002099003|261022105027099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 4y0DqbmFtybpGxaxpd7H1FChZFdcXFVhh0hPvmvuG98bXp6XQORakTfwpJAKgf9tSoSjuv9slDtSeHkkeEeDXxerwCY4F4DOksQkrRrOZWq6eaJ8m2VsA1tnUBR88eRrqonj1iaEBJ4j10BZD2pjwxRAvgYOk3ShcHVicJ3JuNTkTyvnNTmrzbt/qdJlNW3mpfwTbm3aPSpZfvlymrC4mu4FXzDyO5vZWRuV/tEbiIoNtqrljClTqeCyk/8RKroZh/8yoBmHeYgP1ffsLMlSNL/eMTZIZFBL7A92uWPAN0FnRfMGSdoLfdU63765P3kF1BP/lEbsAgcAg6stOansSFWwYDixVVcyEvIT2+6c3Ffwb24lV5hYQOUlEV/SombLzGG2N0JX8PIy6gEy5W9uFYC8ZdZesFT5cGGtZTh/WetjRT7cBvxfwsJq0BL7EuloNGC/3j0bc4M7mN8UCJIw7cVjL4LH8q1pOHPB1udTRp/Oz1+Og3IYG1Vlxu6hb9KZIa5KH/gg0WgnCD256Q2K9EfhB+lJXxJZyDPDx0bUvpswbR2Ppz5n0PGKvKTHlQSZcMRvUeuq8nrKPh1LRcrx4PCPzB15El0qPI9cvUn4kFSO6BT/0KKu7esi7TeviPuV3dzPTxMUTcP3+WW6r4Zjzr8VPF6JoBx0mb+AqvYcyLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(22082099003)(18002099003)(261022105027099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?n0aTP7XzanhnQypYMmvL2EtQkJRccPLWYz2Hq1zSMqSSMKMM7bNN0sJlLk?=
 =?iso-8859-1?Q?aV3V6p6AM1IjLTVNSSElPs/FE0kG2Xappxqlul1fPDlyWPtuAnyvqwnP8s?=
 =?iso-8859-1?Q?czB52w8Gl2epIpo6BM8nqnxg+MNtFOldSho/bnOT/AOQbeQE9StBuPqauu?=
 =?iso-8859-1?Q?ejE9lUIcObspdOKQ6Kji1KK2AY8ifhZEhTJ6ZPACkXmQfogiHUqCWTJtq4?=
 =?iso-8859-1?Q?pmE3CbLm1cJPo48JDrkOrDz1Ckph7NrULbBJNygClmqTVUoy7zdcAkkF4s?=
 =?iso-8859-1?Q?bYbD4t8/nRO0SIClYUWzf913qkCpKbjQZsg2uFBoqJNajPrIZjN/qsv+rI?=
 =?iso-8859-1?Q?flZfh+k6VyoVbqSTxT7Cwo7q/4wd9usJXespZkepSk1vik9+PaX9lPwcAd?=
 =?iso-8859-1?Q?13FebFxzPYKSFmNdMzUVbEvQHPKbIOZOnXyVWmWnFCO2Z/LTEAtwoV+K6n?=
 =?iso-8859-1?Q?NJ3nGBzKOCGaqhs6LKXfA//3FTn2w2o9u8/rkVc0YGK+iqlfU6sdYq8RW/?=
 =?iso-8859-1?Q?5YBa2ZM2ZK86wpX0Bwiq/t32V8IsjijndDCM6T+BU7nyttntJPpw62B9Q0?=
 =?iso-8859-1?Q?jZnmVu/YBp44JNRAnKBvPJKxreAAWom1CIBNmEokSdgtvS2gY9x8BsA04l?=
 =?iso-8859-1?Q?xQ0wya8vuTFEO12c3USivCm6u/5TsyuuDrIHnw8zkBLs+yTaP1Po+xmdF+?=
 =?iso-8859-1?Q?tgf83ml6FWamQlA54RvXar6n+iuEm3uivjlaWHDqxEnKTCMv5WGnqrUXvp?=
 =?iso-8859-1?Q?p+rNYGgq18VLmVzSHelpfixHq5TF/7Hx5HIVmorFQkANS2VyF9iY9Z0TA8?=
 =?iso-8859-1?Q?lZ2yo/heksG7r4QxjncSuPCJgdqH09QoDE38pkkEUfNSV3WklHGqgGB1+C?=
 =?iso-8859-1?Q?0JPVeG4uBtkNv8IUYE+LruvxbIA27i21hv2+qLc6dnNCuhqBC0u5KPKtGk?=
 =?iso-8859-1?Q?WDdx82mlN8PmSjf65P/TeLoRrDsNNEbSkKSwofbsrODXVOEU7HBneuAwzM?=
 =?iso-8859-1?Q?MPhN4Ob6t89JplrjdoZn6T9fj5I1q2KKMq+QZBEBKhgesyTCecr0tYzUa2?=
 =?iso-8859-1?Q?k38gtuQtozaaOFOkaCYtDAY1FECOXl/U20LIbXnXMAzQ+HWb1ooCblqZOT?=
 =?iso-8859-1?Q?JV6eKXumBAW8lEbwYIP8LLxwap3z2iinqafWHBBi4pxNY6WD/4LfTJ9WhJ?=
 =?iso-8859-1?Q?rUeXomJ4OPHmBwrOB7/ByZxC4ygONTcVmU75meojNUC2T4xU6FQESZLOkU?=
 =?iso-8859-1?Q?I1NEaHMBr3QpFMDAa4UPMb7/M1swy8HtN1FSFWniCyy6Fvyy1aPH4QWLGr?=
 =?iso-8859-1?Q?S9/xWErzDv/kab23JxzLhd0stMs5uxBuJV7jRIQvwfdfTfCePwj9MrCj4Y?=
 =?iso-8859-1?Q?kHRB8COdPQBFs+iBUmTb8hl0i4txtd1YymwdJxUsr4E4PFSm1qWxuPq9JB?=
 =?iso-8859-1?Q?jDQr+Hn60pbfcWUSQ65zYCkpkWZqQtAhWI92CthtJp9Y6Z62RYE8U+gE7z?=
 =?iso-8859-1?Q?TFoNZgX1uFZf2eVkhJPLbRN9HAXwMpBDGBxJFXjhuF0UsCyR9O9jCoBKcq?=
 =?iso-8859-1?Q?dc1j5D+x80/v+rw2fibZAZkmG90eDxVgnxQOP0Tn0CadjQLMew/l1XAa3f?=
 =?iso-8859-1?Q?qV7U6evTptLRPyjpK1Wdz5PkzILw+NRpU7hRU2K+ui0jdKc35IlYOzbM0y?=
 =?iso-8859-1?Q?6osHXHGw0IzGzRWLQDUP/8yZILtz8SYbYw4IcV0jmp2YgQdSsUpOBXZA6a?=
 =?iso-8859-1?Q?foNV4CMlM3Vkw6qax+OYg1pgitjcsMdiEw19gbWky5oFjGnwCU0lMN1D9U?=
 =?iso-8859-1?Q?UX2PexfgNQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: V6B5er/VAm09LjjdghpCOonEI30p7iPjyRf3MDiTFOGCstgiLAoUJ/LDEYEhr3RxcqTToWabzATcGs5uiFeCWKDtdV9fT1S3yIvEzHbVhb+o0NiOg102y0A3jgtLwK80/ZOXc7vKysTzX4mk8y7X/0RIf/ThY1rmsIffbIHqEHBHCo1VoCAuJx3jHF2qBHjwiIROz91GFes1YBSI7y40fADcB35eTzwS9k89hXTUpGytQKO7KqFKYw89n1ziU3jMCsyHGRW8ywJFqRRdZ/lCiwCwDwOIzTJnumPk/L6zrd5PngrHJI7MqMoZWmcbYmIXTed9pKJnyuEivJyNioxkCQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9666457-5fd4-4ac0-7171-08df30a9f1ac
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 02:04:17.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARfOtKXR+Sy+MX/p9t4ROAH6qt4IJqyCJVFx/+/bmhk6v1osWEXNXMjU6RgKGrAblkTw96VYNM87xX06u63UOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056
X-OriginatorOrg: intel.com

On Fri, Oct 23, 2026 at 09:56:06AM +0800, Edgecombe, Rick P wrote:
> On Fri, 2026-10-23 at 07:59 +0800, Yan Zhao wrote:
> > > Yes this looks much clearer than even the upstream code. Do you have any
> > > better
> > > ideas than "4KB guest private page" though? Because in the split case it is
> > > actually for 512 guest private pages. We should put an artful comment to
> > > explain
> > > both cases while not making it look like something that has a better
> > > solution.
> > > Because I'm thinking there isn't one.
> > 
> > What about a comment like
> > 	/*
> >          * +1 pair to account for mapping a new 4KB guest page or splitting a
> >          * 2MB guest page into 512 4KB pages.
> >          */
> > ?
> 
> Can we mention why we only need one for 512 pages, what about?

But "2MB guest page" should already imply that the physical range is 2MB
aligned. Instead of expanding the details in the comment, would it be better to
put the explanation in the patch changelog?

> /*
>  * +1 pair to account for mapping a new 4KB guest page or splitting a
>  * 2MB guest page. Since the resulting split 2MB page will be 2MB
>  * aligned it will only end up needing one DPAMT page pair to cover all
>  * 512 4KB pages.
>  */
> 
> 
