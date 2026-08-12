Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB39370AF5;
	Wed, 12 Aug 2026 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577241; cv=fail; b=Fp+1NxxLPFAp0uH2mhOEZyfefqDkhpKXfKbvidQ68EikimwEXlfg9AnBAGFuvBG9TaSfOhfIJ2eT4dl0hYmgm3aMj9XXchV+DThRfSzWu7Y0RG5bV2HHfEtPxACb9JfLf9xUxZZ+aP6GvSsbwrUzgXb9riuzyj5KfhUOpw1Vr0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577241; c=relaxed/simple;
	bh=grp3wKlkJ1k9UhS71FvmRpmsCBYhLUyCWwI5dTFkM1A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MahJvSBgA0N0FnlFG5YGBDTuw3RR5TYAGs1/IpTBln0khhGDX8DWc/KeCqSl+7eDmVU+pewCdfam3cYVWQcZjyG5RqULi5uM0+wnW/UD5yDRLNcEr0XD7TfLx0oUmtJ2APwTWRptfaNLk/W/TuJpKqryptNENdiEPaAL0iGABg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+ro2lkJ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+ro2lkJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786577240; x=1818113240;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=grp3wKlkJ1k9UhS71FvmRpmsCBYhLUyCWwI5dTFkM1A=;
  b=Q+ro2lkJz4hlx4AHfiF66+gAXk03yAzdXY69SmnUGqBsOB2J6JQa6js9
   66Hc6wnUThI+3tPrbrmeaYC7hjiZQ9NucsxKy3fNb76T/D2y0OrwmbEYG
   bVlNMy03m1D2oLXfl+CA8/Izdsy/b8+Ex1+2jimOTX1tHsmP5rKDVtc+b
   ZT7IchCcqJxrl87WK9MldDPUcrd3QIMZkjR8wYqqJGpPQjxgNSsy5Jy6D
   eGvbRd8DjJFAFMeUMpQ7Mo0XvTVOP7HzwrfmUwZmfitRnF93SzM7yjnaP
   8phuM1i+KJr7w32epYacwekB892ezt16RjP+U8K7/iJ4AbHEeLH7hT+DS
   Q==;
X-CSE-ConnectionGUID: WgUGjKxIQCqfb53wHRxe7A==
X-CSE-MsgGUID: Tnf1Nq7WQeC16dIbfg6R5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97732874"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="97732874"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 16:27:19 -0700
X-CSE-ConnectionGUID: BFZSE6ebS1GEY9VYrxZ80A==
X-CSE-MsgGUID: T3GzXJGGSbOwUXl29Nzoxg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 16:27:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 16:27:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 16:27:18 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 16:27:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bur9wY4LhtbA9ty/0to9OEKyDiCSFZJhzEILBp4YE2/m/+M1SCCJuu79YCBAVZNNvgjVCE4XwnxszvAbPhAUDFxeAfvclwwqWWw1MI0/zusw0p6yBu0BQlLasMt8LIAO5ShzOCZWW2kERvEQYJ8M7GaCSnCPmfWKTh2pcjj8JEJw9qVMBMiPRr4kntSfFhfyKECAodWcIlGkxBNoRwmi6Rfik0ZlrDHNEi9C9Xmx+v7UGNuR/OowKV8avVbtyUXJY2G6bE08goHugrZyTKWYMuCCZsbm7EJ5dfMXcubSlyy0zIk0YPkV3Mtt8daLw/Jxk61x5QPuzrbOzXxiX09V7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P41YmUe1eUXch/CIPfbWMUUnvAs2M6/bIjx/krzysMo=;
 b=DICKDbzkSMGu2WGrFkAf5bZPK++7PEjv+DrcJmuVmPK6jZsCA5tg6liWSmDeTtb7NGHueJTXUfY2hiRplw94jt89ivMX1TeIsqeOxikUKFm31RV2Z2KEi6mdu+l0AY4dq0MJOZSY6vPhHcWSFgc0QnKFIHdmfVV8HaroBs5+Hvsps6ilYshMVilSQtoUcjdvo13Ec/JG0gCQjljJbqJ3CjQfE72OVOlJsJaP5W2ht0YeCQ4pT+ioGimMSphWncj3zLW9lIunJxl6wuTYfSnx9CCU4icnCwcQ9W0TyI5yVbjCVN4GE9iZVA4ugbFajxzcQJp3u+SLTdEAXA6ezKhaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SJ0PR11MB4784.namprd11.prod.outlook.com (2603:10b6:a03:2da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 23:27:16 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 23:27:16 +0000
Date: Wed, 12 Aug 2026 16:27:14 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "kas@kernel.org"
	<kas@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Bityutskiy,
 Artem" <artem.bityutskiy@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Message-ID: <20260812232714.GE1013044@pedri>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
 <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
 <anxvwV_Pz4UYaxxt@google.com>
 <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
 <anyiwqi9i0NSv0QW@google.com>
 <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
 <20260812223707.GD1013044@pedri>
 <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
X-ClientProxiedBy: SJ2P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::11) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SJ0PR11MB4784:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc0a609-2d8c-47f4-d5fd-08def8c93eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|11063799006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: AeRtzGsCBtYQQUsgytn7lHSMIkYmGsByPaOd3dspu+U/2N6KIdzRCs48L2UETFwqftJg7MRxfjPBuFIkekuaVl+qfeIsXKEpzw5jaFB8W1zM49GMpyb/aNTM8Vt1mZPvyw+7z2khLzbGstPJMJSlYDAf8XBNkmxMtiuTm+LDXKnnvM618Mq0px9ogwYDDSMIi+LyqwbWMMFGQl5dMyPAQK9o7Ls6lnEC1o0NrtB7p7n+V4W2QIj0PFZaSTpPJpOy+CMXYBbeUuZ2YZskYwbAEZZya88vJdD8Xw94mxAaCws962u73qoVkl92Sv1sE+BJ7/wUMWlpYd4B/oh962zYh0WVyrkBt94jywuTmmyucbFXfrr360aa84+AnivghM3F5KrXDeHpLfUUom58rLiy5XG219TFyrC+e4sTBZTHxf8kAioVLqkQkva0DVckbzVqPrO9/G9qqSh1xIooMDuV4Q3ffGDNK4P7Ohhsde9T2aGwFqp4jPuX7COIRj1N2B5/JeWnMduMOMDV4opNy36hlG+cwjD4+AuEDbq0ZBOZo7FAKn6QC6qauNZZbKW2XJYRGVyYw0Fv/iAl2XSVMepGYciyWpnlh13LkqU7Cku/EnG4bfP5P9d6QqBthc0lQIG9p/Mz6bHIGQdzpM7rYs8BM7T5GEKIdnIR9lMACvpKw/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2ZabHRHcm43RkVqaUV5RkRiSDBUYkU4RDA3UVA2UjdIZDRRWTNxdnZKYW8w?=
 =?utf-8?B?ZFlLbkR1RGU5NTMySGhKbkVEM2dKTEptWnpsRnFMRitndjF2OHJ5QWFySzZV?=
 =?utf-8?B?NEJ3cmtjamw5aHd5SG9UdjhxZ1Q5aXhrNStOYW45STBHbUpKQjZVRVB4RUg1?=
 =?utf-8?B?ZTlKVTFBRm0zaXlZQ052WlA4eWI0NU5DMmR6Nkh1QXpWenZHemE4cE9SMGpE?=
 =?utf-8?B?KzVBaDU4Uk9tTHBtUFB0d0NVdHVlSU4rSVF2Wk1zMHIvNzY5VGJaOGxKZE9M?=
 =?utf-8?B?RWJBSnBUYnNOamZ1SWpYVDZpTzFYS0dMNXJSWmNlWDBTaWU3YjE2K1AzSE00?=
 =?utf-8?B?dUR2N2JJcnZZM0RDSS9HSklOSWY3SjBQUnVONVZ4SlFBZUZ0VWloT0tqblpQ?=
 =?utf-8?B?dXYrVUpVcHlSOGtETncva0tHaFRJOU5SakVPM0xZR0FJK2tEYTl5R3E5MTYx?=
 =?utf-8?B?MWpaNUpocjc2cHc2cHEvdTJXVDJJQXVxaEJEdlZOM3JoOTFOOE1md1lrRDdi?=
 =?utf-8?B?M3U3L2l6WVg3aklnUXpCMkt6dHZ0TGNtY3pGVEpiYVVON3ZVa29qWEQyV2FO?=
 =?utf-8?B?UUtsRklHNHFJYmgwT3dINnoxZGJBaFJoRWdBVWtxRks1ZW52VTc2Y2tOdkVU?=
 =?utf-8?B?NGsvdG1QbDZONVdpOXNSV0ZJN3MrT3gxY1I4SVl6MWc2U2g0ZTZTRVZPOUgz?=
 =?utf-8?B?elBJNVJMRi9QaS81Zk1LYng3WXZlbnpZQTZxQ0ZYc21xS01uUVIzNE01Y3Q5?=
 =?utf-8?B?Q3BwMUVXd0lzcTVKcXhnckZ3bWxsZkZKNnpwcjZTVVNmdlhhQVhBSmtWd0JR?=
 =?utf-8?B?ZjdJblp4ZngvbFNOWWRCaWMrU1I5b09sTXFnMjBvWmowRlBBTGp5ZnVubDRY?=
 =?utf-8?B?QWNTSm05bGZrL0ZCQ1lzbnVvaFhyUkRjT0hyWHNwZ3oxam5kL0R5NE5rNkhC?=
 =?utf-8?B?ckhhZ3FmNXJIRy9TbjZrSU55WTZkaG1NVlFHOERqV05jQjhrY2hGMWVBOWM4?=
 =?utf-8?B?UGZ0VFZSdVFQektrdGx0UmN0blpsMmdVRGlSQkhHamdZYW5xSjFLSnV5OFB0?=
 =?utf-8?B?QlNqcGUzbkw1VnUxcE1Ocjd6VzR5b1kyS2E3VUdPUHhGNFlIN00wTkR5QzU2?=
 =?utf-8?B?b1IrSFYvbjV2azYrazRIT3A0QTNpTkxxanF0aVFZaXlKeHI5ZjhvWHBkVXMr?=
 =?utf-8?B?VmRXRFNDRW1xekNESXNOVVlsUEZCL01VM3ZacWE4QytQaFU2SUJTMjdWbCtQ?=
 =?utf-8?B?NnBVZFFCUzZtT2NsZGpLaHd1REl5eDVJdkgxR0ZaTGVkV3IrNi9kY3BRUXln?=
 =?utf-8?B?V0ZWTE1tWVlPS3lRRzVLUzBQNnBpSFhnSWx5UE55aitGd3ZkdjNGMitPdDA5?=
 =?utf-8?B?bklWQVpNcDNqTXQ0djZxTi9NZWhqYXorWVZXVkh6QzRKYU8rWmYrK3FVcnpl?=
 =?utf-8?B?YUlBUXA2dkRWQm1IVUg2bVczVmFyQWxRdDRORnlPU0hkdzNvaDVWbnpPQWtq?=
 =?utf-8?B?REQ5djN5Tk05ZlpOSW01UVA5OUpvVFJNQnZYajkrMVF6MVlTaG8ySjBOUmM2?=
 =?utf-8?B?NTlESzNKS3M0aGNDRVk4WTU1UmFpZ3h3OC9tWXFBcWVHRDlXaG5yZExXSDNt?=
 =?utf-8?B?Nnd0ekRUYy9mMW9zdHBOcHFhQjVKV3RwL1BQd2dmYzNJUHJ6U29jRTJmTzJz?=
 =?utf-8?B?Q3FrZVBVejVoMXVJanUvWTBNUlZVMnRpQnpPTk9wYnVVOU1tRDV1N0E2TlJD?=
 =?utf-8?B?ZmVPdzFnNmVKazRlRHRFbW9qMndBZTV0NDlQWC9LS0I1bG5EQ09oaTBzcmRy?=
 =?utf-8?B?QjZaZlpVY1NYZEdHSVVwdy83dXZkN21US3pBOUp5T29lNDB0SnB3WUVkd0FD?=
 =?utf-8?B?N2hGM2ZTNE10VzBFT3owQVFCNGZXRlh1aGpZUVlxNWN0WHhzWjVPbVE1TUFW?=
 =?utf-8?B?ajlWeUZjczl2dVBWV3Z3S0h3bkdHK3NCYWxFeERwNUpsR05ueDRldm95Wms3?=
 =?utf-8?B?cEMzdjNTeVhxdXk3T2RhVmgzdUxwOTE3SU8wb3JEdWJWL2hWNWtnUlZpdmtn?=
 =?utf-8?B?NGxuUXFKcFZIaEkvcmNSV0NlY1RaQzFZOEJUalp2VlJid2ZXbU1mVm5JaWVG?=
 =?utf-8?B?OWJRRnpDcFVEYUhGMHZnaDJPWlFIMlZwd2ZuMVBhTHZPRTZBclU0bGZQT0pW?=
 =?utf-8?B?VHIzdHE1UjNsNytjb2Q1MFUwanNnQ0htQUFlSDVad0dBb0R5QlJCc2Y1eUdv?=
 =?utf-8?B?MGppWERtV0NWbS95SVgzRkJTeW42NlBuTUZZNVJyY2paZEFRb01HeXN3bDVI?=
 =?utf-8?B?amVKNHZ2RXFhRytYY2FVRGNkblg1WHRLWmtlTnNRVU0zMS9aelpYQT09?=
X-Exchange-RoutingPolicyChecked: Ub0YTlgpZupTc8u/n53Nittz86AqbcMFiYTgz4I3tqCeS+TxAQo47vJMGuWfoAQGu4kKOM0kWd8ogll60SL3DZvUvlwK+shtSR5ZYflnq4DVB/rijkrzvCn27JYOaIAWQ40I3lWbupWgolNu4n41tZ6F4CKC+IwwPftj7J0k8h3KHSxwA8MbLfmXZXtuplCxI6IxCxIyquGK9SzVyPmXZmG1F1K5znqHLhEwZvHEwUg+0f8IFy2p1IrD7IPtmFlYmWLC/XD/3blFvVykyEdPNPEG14LXvppDalMfbOqg30ACy+kH5Kn7OZxnR7FeaTTLSP1m0LT9rwyazVyGDWyrAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc0a609-2d8c-47f4-d5fd-08def8c93eb7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 23:27:15.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8WS0kTASiEcTLp83zkFaV+07X7SIqKstFTiqOVaLeGVzANEjImWXd8WNYSW/IYwvD+g4VqnSXYWi3k1iepdbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4784
X-OriginatorOrg: intel.com

On Wed, Aug 12, 2026 at 03:47:28PM -0700, Edgecombe, Rick P wrote:
> On Wed, 2026-08-12 at 15:37 -0700, Peter Fang wrote:
> > > 
> > > But part of this too, is that "DICE" is an industry standard [0]. Some of
> > > the existing TDX attestation format is TDX specific, and moving to the
> > > standard is expected to make the verifier better. So TDX does not have full
> > > flexibility in choosing which bits go where. There is some. But I'm not sure
> > > which.
> > 
> > In the SGX era, a lot of this attestation stuff was Intel proprietary
> > and that caused a lot of pain. To follow the DICE standard the bits in
> > the report have specific places to go inside the quote blob. IOW the
> > DICE quote doesn't just carry the report like an attachment, and so the
> > two can't be separated (not without breaking the standard in some way).
> 
> Yea that was my suspicion. I'm not sure if separating them was really Sean's
> understanding or not. But the other part is that the verifiers and other VMM
> infrastructures are already expecting this standard format. It would have a lot
> of downsides.
> 
> But the "grow the report" or "grow the report and quote" are still options that
> leave the quote in the expected DICE format, right? Sean I'll assume you still

Yes, the final quote will be the same, in DICE format.

> prefer the "grow both" option for the sake of kicking the quoting
> responsibilities out of KVM. If so, let's see if Dave can weigh in.
