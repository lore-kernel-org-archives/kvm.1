Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B383B1EFC
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757294; cv=fail; b=qcS5w5xeDp9niQSyr33Th9Jc4Zq/ZtGskCUy/HX7P5ZNu3MQoKi2Td5e9dQTUjHGxgMYUIFSh7AudlsDXQrV0tj5OTCLQ+oA+IsDHKsVHC5f0EH2zGJIMez2EB6TwxWMKN4OK4m90Z04c79JzSeECVK6qT+Q1yIg41CQl86Eoek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757294; c=relaxed/simple;
	bh=JRtI1UjrAiyVtu5kOl4YOA3WP6fhi4u8bVs3y2T4lHE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FAEGuTafcF+AhT6lGnYylK0C6rXtrwGYD/MWcn8pdcVAd/B5MYSktP9i/q1BTDpurGHIqga98Xx27N4rajOKV04Uo5edIfjsZOq0ZHXSu+YCm3HmmuiM0K5WpCLaadg/Aj1gKGKSpLY1lFK/EgJ0gsN/l2fez2sPKAEwOW5cv1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=anq73eMr; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anq73eMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784757291; x=1816293291;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JRtI1UjrAiyVtu5kOl4YOA3WP6fhi4u8bVs3y2T4lHE=;
  b=anq73eMrvUgucUbLMDKaC03mf3wi3cvwNO+/tWIKno05oGuaIy3yYBCF
   CYbpotdIuIxTepFZx7cXpSHIWVMRFJynsY+3UFt2Gc66cxnCZDjODS6LU
   dx6lKKEK4+J5dj3Utcak4npJ2JvEzv2iH+Y8aS5SM9IwoAJ9uppr4GU09
   2dju1NjNObiknctnwAbaFEXDE4wcFN/27Brla/EFA0s0a6aBnLe8dR27M
   HiyNJ5Olgm1fSWHuWsFnJIw2IOw6MY7gcRS951T47tHJqqtDPcRrOpuOm
   dlNGIRyTouKoSecomvZFhMEdxb7cjD9H17l9uiayc46+daQMxLRoxICeN
   Q==;
X-CSE-ConnectionGUID: IPBhxw/NQimzbrMfgX2DNQ==
X-CSE-MsgGUID: 86uiPjrbQVyl/nLqaFAkaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="110949065"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="110949065"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:54:50 -0700
X-CSE-ConnectionGUID: eSGDZagSQWmXefmKiKtM3Q==
X-CSE-MsgGUID: T9k5+YZiRjOx0Cm9kEAz1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="288212967"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:54:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:54:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 14:54:49 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:54:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lX1jgBm984CkNm8JGrSdr7j9xCQ9qjxcY8laRk+PlD/1gtYPUTTtlOhHZJs1ZGPiR8MTroaK22+GlBqNV34NLP/BqmysFt77IJ7C+ob4PU7QWOsAzWTWRl8fX3gX2cXgPQ1Sz/kY/wcAvxQLZzcjxbwxamljPITojAX3sZI/qErSEqnDVvFWBcAJtOkTUOCDHgYjAb2GLeUl4uYJwz3ZrR6ccKhdBjj5ZUc49/FJURx5KkG5Hr5INlWEebpSraI8qgzZM1rZM+fgQ6yBPg4yjYt/FJL8BbAh4wkhD8z6TD4TRG2+8amcifE+7oqFPswi/sZ8WEdWdz8hmZge2ygFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+ec8osqvGpiVhsEMTdMNQv/eIXPNz5vDq705bcGKAI=;
 b=JCrDxwW6RlwAJMWaUSA8psnWJ6i67yozIjMD7aFKk1ZE38F/SOaP0Bf8P6WUXbBEpVU3Gz6FDPLQ6AXb/Bix6EEA9L/bNLx5+Z/r5yw+El2Xv1UDkEQxlnc+GLy28a6uhhtpvLz6tHdH39dzNEOePHLI60H9RtZkgiBUcYhLm59N389I8Zo0Uqrmc6ogaxhHxZXp4952da8s3dXD19omxPok0K2YdsPPstNGMJcC8JYyMlEUAigHWGwzCY+l6yse0lVNKp2xS8K6HM7fL12WrqNiFznoJp6FSwZMzZp5N09bQgqnLNRpsWEinFC04z2cb13QQl3Va+ga52wMWMAEUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 21:54:47 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 21:54:47 +0000
Message-ID: <36b8ed8d-7e44-4e8b-9d2e-e46c8db51c5d@intel.com>
Date: Wed, 22 Jul 2026 14:54:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/20] KVM: VMX: Save guest EGPRs in VCPU cache
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-3-chang.seok.bae@intel.com>
 <20260720182042.9D1731F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260720182042.9D1731F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DM6PR11MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: 081c0e34-3f89-47e0-9a37-08dee83bd8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|3023799007|4143699003|56012099006|11063799006|5023799004|10067099003|8076099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mS+JwOmoChUr0fr2kEWUcRExDaKAoaoYA5bW/QmhTKUpU+1Tlo5zqyLtxWCG0CsnwQxrdicDmz4d0XhcdaEAEBF7qxI62GhKSMzdcePIXCTsXqnKknmxk4uzXVJw8nNN+Mw4VmVXKvMv5dfLXjHyQkHteojcBqKijm7ilHbMKU3mzZQlpgvkThdkeLWqxiZi4aRsYrKBUxs48qseh0fOMhBNt9IeTZ8Sd/WF5OfzFpxs1JsUNFyZABtvpSDEkR4ONayqSBtDN5TC/hoOZeZAg74TN2EPi45ksxueePyYsisVrWDkR9inW+K/Nxk2x9nw6AxnAtWzC+tPIDimEfWi3t62Fffx2kxIzALOdB/5kWASTuBiu4lYgM54/oifbOcm1pnv9TZVLskShXlb17YJEux60TGJq3o2/c21jy2A7bmcCMRD+fWEIurhHJZCOu/e4wsdKOJsEXnOH+YjrxtRmiU7JvdKC4W6KlRsZChjpVKct2+o7XxqnYzcsy7LtK4ozIhp3ov1x97n9vdw+4zs2B+8+KiIl4Zi2O0rQFJiXYxC/1rGstN2XH7y4iJf90M7uwMomDFiOyMOGYszvyvw5TirBP4siKuMcFxQrjzeBo7C0KXA7ZWBao7dH5buXF8vyu13zq8eD/tzcgC/+vFlnb+HHA8eq4KEX5dMf9dyoSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(3023799007)(4143699003)(56012099006)(11063799006)(5023799004)(10067099003)(8076099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHhMSW53TmlFd25UbjYvVlJkZlVtK2pqS1hqaXBjdndNcDlqeHFEL1RqWkVr?=
 =?utf-8?B?bkhBbDdUalVzUHI1d1hmT2xxRFZOYWl2REx0d0dWWTU4L01tWXRhcFdvSlZ5?=
 =?utf-8?B?QUN5TjFDeUdxalZmTWN5YnpsZ3BqRGlMYXprR3RxR1NrTXczL0RZTU1jTHVu?=
 =?utf-8?B?Sm01SkZCTnhCakg4MWtLUXdOd1NDbmFwcGhiZmtuRzBWOFU4TEwxWGJaVWda?=
 =?utf-8?B?UEczSmVwWHl5eERTMzMyNUw0T3h4eTZJZnNCN054RjgzRU9QTUxVOTYrYXFG?=
 =?utf-8?B?SVdIZzlJMWZZZCs5NXV4Y2syV0d4Z3luZXZoUU1ZTWY1ZlR1b3lKcU5NVGFJ?=
 =?utf-8?B?MnlMNS8ranB4d2lWMEJGRTBMMXVxWVMrMFNBNEdGbGF4dGVFRmhnK1N1MUtL?=
 =?utf-8?B?ZDBVVStqYnhZcE41dDBqZVFoUXJVdEFMVWQ5am5EbXJGNkRJcGhVSVcvbVZh?=
 =?utf-8?B?YzhOSmhQV0RWYjlLYm5RN3VORi9PSVBMZWRRczVOSjMxbm53MVVxa2x4a3NE?=
 =?utf-8?B?UEw3RDJhVkg2NnN1LzRwY2VaNnN1VUxuaEJMdWljWHFuVXZTTmIxRjZpNnll?=
 =?utf-8?B?eUNPUmN0aG84aGdSY3FxYzN1c1ZPVHNpWjdIcXMreW0yVXM3VnN0cUlEeXdX?=
 =?utf-8?B?M09GVitpYldmS1FmUjZwalFpN0V4MXR0cTJlR292Ry9vU1FUVWZETWZlVWVy?=
 =?utf-8?B?dzdqOGpKTWV0MWQ0eG5ZQm4vQkp0bllvUThSejZGenVrNjFOQ0lyOEdiUnJG?=
 =?utf-8?B?akRMUDVhZGlXK2NTVWdkNTZ4Mk9lQkRKNThCYkQ0djhrRXhMSnNmRHp2cjNJ?=
 =?utf-8?B?SFQrelN3QWdJemtEN3N1SjFBa1pGQlo0QzRucmdwMGl6aHVic2tGcTA3T211?=
 =?utf-8?B?d2lFS3RjQWxwb0phWUEray9IdVR1TVV0Q0J6WmQxWGhHNXZlbEo0Y3Mxbk0z?=
 =?utf-8?B?b1hhNjdaY3pBZkVPYXVyUjNMSVhRUDBNQWRjZjFtMEdtOUo0QTZ4NElLdlIy?=
 =?utf-8?B?YzFnWjJxTjVzeVZMcWo2eTVrK2hDN1BGVFlac3Q3eXphSW9XYXBNbkRZRUZD?=
 =?utf-8?B?V1pnQit5d2lSU0UxTndvR2s3QytXbmZZT0NLcUpuZVZpVlloUzFUTkZVNThD?=
 =?utf-8?B?RzhvcDhJajlwNGRDelh4NzJjTUFuT1grUUdmMDYrTzBoZ0t5bHZ6UmFCR2ZH?=
 =?utf-8?B?aE5sUWttcE8xeDdJbFE4b1NERTIzaFMvVitwdWNLNUQrc2dFSkZscG40VE9x?=
 =?utf-8?B?UWhqdFBRMzBlVVJYZ0k4TFJkNHpRYUNSWVE3NGpGOUFXT2NXTko2cU0zdSs5?=
 =?utf-8?B?QjcwTVBLeXB6OStQQ204aHl1SHpIL004aTVvMUE0ZXRSVWZOZVExUFI0VXNk?=
 =?utf-8?B?MG5wOU1VdENab0J1cjg3MnNBRHJaTDR4NG9IMlVOaFo1alJBeDdEbGRMdkNX?=
 =?utf-8?B?bzNWeXdJUkNGL2F5N2ZHRmZYZDlKTmY5MWlIWXZheDhlS2RGV2tNSm1LVmN5?=
 =?utf-8?B?TnMrMjVMc3lSVTVvYW5udWp1eWxtK1lNSzFqS0pOL2F2cHV5VkZaOUluOWoy?=
 =?utf-8?B?anc5MFduZ1FtektiTUY4L0lWSEt6K05JYTZIcEoxQ1NKbnZJOGhMc0xOUE1s?=
 =?utf-8?B?aVhSQ2xEMUdjTG1iSk9SSHBKeVl5MWtDOW1zRXJGL09zZGdhSURGa2RLSXJM?=
 =?utf-8?B?Vm4wWFpmS2MzNDk4WHpxZWxJbHFXTjc4Vmw3bmlkQ1dNV1BCazJtZWM0TmJq?=
 =?utf-8?B?RHZ0WVRKYkw3Q3JML05oWFovSnc1aGpxa2FmTHF3OTM2M2J5UU02TzNKTExX?=
 =?utf-8?B?dFNrVGNldnJ2aEtVN21PN2ZMbERqbTQ3YUlQbFF6bkFvcjdnbFg2NGVtRWda?=
 =?utf-8?B?TlhJN1NuSDZDV1lYenNOYTZvbDA1UmNIbUIrQ2RBeThjaWMyUzF6ekF5ZTQ0?=
 =?utf-8?B?VDEvUVp2S1piTFEwNlRaWTNLQk9LaWd1Z0J1TFZwT1dDU3ZEd0N1N2ZMSitv?=
 =?utf-8?B?M29LRDNTVVoxWnRTcWM1ZG9vQWg1QXdzWDNQNURXTkNLei93Y0dkSWltMHho?=
 =?utf-8?B?RkMxK2w2WWRSS2pIV3FKSG55WVlXTjNxbk9MOTkvZHNIenBmUkNDSzlneEFE?=
 =?utf-8?B?WGs2OVJYUmNqYUpIdk9ZRUp5RkRqOEtpMXVPMmtsdWpidVJndUQvUVkwRzJ1?=
 =?utf-8?B?L3Vtb3ZrUTBTTENONnRtdUZCb3VPSTdUeHNYMlFqNStTY2oweUpPa2ZWZnZN?=
 =?utf-8?B?OGxXYytTZSt2dTN3QzZWdE9wZDVKYlF5R2x1bk9aNDJabDI4SlJ2TnFWREFN?=
 =?utf-8?B?dSthREZGMmFTYkQ1M0hWVFBqSTMrS1N0SWRUcEtGUDdscG1qKy9XUT09?=
X-Exchange-RoutingPolicyChecked: ISbh9plQcSlQoB3qaRhPhrYzRlDXXUO/LQPItshvqGTws295Q9VfIDuyHusPkqJD5HBGb7u+Wz/kjH7KOYVoMS3Jj0S3uylxcWPSA4AuHTOv2nxgWS5w7bh8iOd0VEFsmUveWDt76PWgCBT4i87NwfQt8YxjaL9DuhmDzl5cQqfzELXbycY8o9xIGNe40UXaRsWREsyxiyLwAshORHfummro/QIdgWIKMN+4gb9Vy4/m80pZbtSBOgAhR4tgHzzQ0lIY+DGnUng3+G+/n62UAKvPnzjXFbKuoI0EJfEqh8OwzoecR3nbMleaVDwwp7rfDZ2t5/pZOMv2AltqKvMC1w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 081c0e34-3f89-47e0-9a37-08dee83bd8a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 21:54:47.1749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvQM2S8KQhk4RT0nMbmELbrKby6Uf4dGQZe6r6nrnnSe+V8dLqwuDn4OqBXstVw25MzUHJStRItir0xSKRpxu0oU4fnz7aMZntMZXRwHelU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com

On 7/20/2026 11:20 AM, sashiko-bot@kernel.org wrote:
> 
>>      The register restore path is placed after SPEC_CTRL is restored, so as
>>      to avoid any mis-speculation into EGPR accesses when APX is disabled.
> 
> [Severity: Medium]
> Does the placement in the code match this description?
> 
> Looking at __vmx_vcpu_run() in arch/x86/kvm/vmx/vmenter.S, the EGPR load
> sequence is placed before RESTORE_GUEST_SPEC_CTRL_BODY, which contradicts
> this statement and could expose the host to speculative execution using
> guest EGPR values.

"Register restore" could be imprecise. While the point may stand here 
along with the code change, rewording to "register saving" can help for 
the clarity.

>> +#ifdef CONFIG_KVM_APX
>> +	ALTERNATIVE "jmp .Lload_egprs_done", "", X86_FEATURE_APX
>> +	testl	$KVM_ENTER_EGPR_SWITCH, (%_ASM_SP)
>> +	jz	.Lload_egprs_done
> 
> [Severity: High]
> Does taking this jump create a speculative information leak?
> 
> If the guest disabled APX, we skip loading guest EGPRs but do not clear
> the host's values from the physical registers.
> 
> While the guest architecturally cannot read these registers without
> triggering a #UD, could it execute an APX instruction speculatively before
> the #UD is recognized, potentially exfiltrating sensitive host kernel data?

Today the host kernel does not use APX internally, so there is no host 
EGPR state to leak. If in-kernel APX usage is introduced in the future, 
the point may need to be revisited.

>> +#ifdef CONFIG_KVM_APX
>> +	ALTERNATIVE "jmp .Lclear_egprs_done", "", X86_FEATURE_APX
>> +	test	$KVM_ENTER_EGPR_SWITCH, %_ASM_BX
>> +	jz	.Lclear_egprs_done
> 
> [Severity: High]
> Are guest EGPRs left in physical registers during the VM-Exit speculation
> window?

I think this code still follows the same entry/exit assumptions as the 
existing GPR handling -- clearing after the guest state saved before the 
return.

>> +	/*
>> +	 * Unlike legacy GPRs, saving could be conditional here on VM-Fail,
>> +	 * which however isn't in fastpath. Instead, simply saving EGPRs always.
>> +	 */
>> +	STORE_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
>> +		   %r16, %r17, %r18, %r19, %r20, %r21, %r22, %r23, \
>> +		   %r24, %r25, %r26, %r27, %r28, %r29, %r30, %r31
>> +	CLEAR_REGS %r16d, %r17d, %r18d, %r19d, %r20d, %r21d, %r22d, %r23d, \
>> +		   %r24d, %r25d, %r26d, %r27d, %r28d, %r29d, %r30d, %r31d
> 
> [Severity: Critical]
> Will this cause data corruption of the EGPR state across live migration?
> 
> Because hardware EGPRs are zeroed here, KVM's subsequent host XSAVES in
> fpu_swap_kvm_fpstate() will commit zeroes into the guest's FPU state buffer
> (vcpu->arch.guest_fpu).

No. The VCPU register cache is the authoritative copy of the guest EGPR 
state. Clearing the hardware registers after saving them does not affect 
migration state.

>> @@ -991,6 +991,19 @@ unsigned int __vmx_vcpu_enter_flags(struct vcpu_vmx *vmx)
>>   	    kvm_vcpu_can_access_host_mmio(&vmx->vcpu))
>>   		flags |= KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO;
>>   
>> +	/*
>> +	 * KVM intercepts XSETBV and thus always tracks the guest XCR0. EGPR
>> +	 * save/restore is gated by this flag. The resulting behavior is:
>> +	 *
>> +	 *  - When the guest enables APX, KVM restores EGPRs (initially zeroed).
>> +	 *  - When the guest disables APX, EGPRs are preserved in the VCPU cache.
>> +	 *  - When APX is re-enabled, the saved state is restored, which matches
>> +	 *    architectural expectations.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_KVM_APX) && cpu_feature_enabled(X86_FEATURE_APX) &&
>> +	    vmx->vcpu.arch.xcr0 & XFEATURE_MASK_APX)
>> +		flags |= KVM_ENTER_EGPR_SWITCH;
>> +
> 
> [Severity: Critical]
> Can an unprivileged guest crash the host by clearing XCR0[APX]?
> 
> Host XCR0 is restored only after executing a significant amount of
> compiler-generated C code. For example, in arch/x86/kvm/x86.c:
> 
> vcpu_enter_guest() {
>      ...
>      exit_fastpath = kvm_x86_call(vcpu_run)(vcpu, run_flags);
>      ...
>      kvm_load_xfeatures(vcpu, false);
>      ...
> }
> 
> If the host kernel is compiled with APX support, the compiler may emit EGPR
> instructions in these generic C exit handlers (like vmx_vcpu_run).

Not with the current kernel build assumptions. Unless the kernel itself 
is compiled with -mapxf (or -march=native on an APX-capable build host 
[*]), the compiler will not emit APX instructions in these paths.

[*] this fix is work-in-progress right now.

Thanks,
Chang
