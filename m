Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA630401A08;
	Tue,  9 Jun 2026 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012327; cv=fail; b=QXdrnRdQvoLksNtqyGWwInM0qx9TI2NjVy//UqNxvgHAXivv7kUwmBmmHSbOTSScU60Y+Rkg0QF7wBDRSuvCmf4q+SYvVYWdF9BlwTj/VuCt/HZ2Tu7VbyPnHodL0Bmrf3Af8tyAonaQXqbjXdVVD3Ft+w9uLRZk6d+5uo7tn/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012327; c=relaxed/simple;
	bh=16HW0S8XewRqeIF+tRa194xyoStVJdvMZND7hlY8+BM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I8gaS0CbspMzfhwTEY+ZaBqxzdWXi1oeXTLFZIeYZednOV0xWObykHRkZY2kntmbWp5QmmouyZlNqDh4rRASr4AT3xxnenidik+Ob0GMiJfXoeW5eXGmAcFgBh0Kg+nkAwF2F5MsIOeXFGv0q3lyiGSj/uNDXAGMRP2Kh7cxfKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aP4XhkGD; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aP4XhkGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781012326; x=1812548326;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=16HW0S8XewRqeIF+tRa194xyoStVJdvMZND7hlY8+BM=;
  b=aP4XhkGD8JmHvzkEuE+i4xGYPsps0Do2ozV50w6oyPjVpX39iZNyRHgG
   5xj2vfp5G4ELFeVDKTxWlXmalUnISQF9sQL7cxH/75JoOO/I6CVakvBn9
   MK0sYHU6FMldMB8SUnABrrj2h6r6A0qG2AzOaspYeaRaOnxt1LxhjqwjQ
   JWIaFnyPrZt08XeT37ycwo1vwT53G47nf3x2yIhsifMu1g90dDErZrrOf
   D9TtfMwz98V+kMxvj7Iq+PkelkJQFQbKn0jWci6SZjcW0Im4bVyseXKKl
   MN4ZviZOniSbganLsuUk0UgOlxLtXGMvD6rUkbGQ2pOuI0QQZ1bGL6vl2
   g==;
X-CSE-ConnectionGUID: 9HloIrvOS7SI/LQ4iwCmiA==
X-CSE-MsgGUID: N7sn2MFsTb2Z2co6lrbTUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="80793347"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="80793347"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 06:38:45 -0700
X-CSE-ConnectionGUID: 9LbJvBaJSqGMbmvQEnVuKw==
X-CSE-MsgGUID: 9s5+XnGNRJ63ieEfA6pXhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="283944480"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 06:38:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 06:38:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 06:38:44 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 06:38:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2uaGcC8Z4Dca/gwGvR41qVqLKaz76eiHfFVRkGuA2Gyn2FSWbeJHi+0AqZAes6gqI4rGYuRUlAoBdjSrMgOSYjn3swEIf1gsrmE19mjfZzlpB33LdGAnqaxukGdrj003t4w8jLBFDNbO8TF+z8q4nCmXsSDT5leGR+yxDFdDcyU9RC4tUG+HtWIfpQRfrFaqZnpEGBDqg88OZm3dd+qCEl49GdxmGhso8m5LHB0wiUh9K6yAK/Nr62iHJY8JNrNGUFQQBZrBIbzRTrMwDHTBUXXnIb9h3LPmlU8wjDywBLPVY72NCsmFttxd5Nx4dj7TiwytWEsn4n3090NRW6deg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPbfFJ1YZuFGpQI8NXuqfAd4fz7wRh+wRrJNZouy2Fs=;
 b=LYiegfYL1z6xbuWHYkzir52xCpP6K/zljOPay7G4elWTBEfm0d418IYvYvoVJxqajFbYHm4078FFghmYKmN7J4l1ZXkU85BxzyMG9uIaHYVyDLpWS8szb2lqQ+deU5vYl/ZgcR9tuIR9jtO8j5KIBr42PJTGTGx9otCQh7u2CiNxcFl1lutv3xiVJtrpBe93kFj72JmYzOvNtFylgQbLn/lm7QYDUoStnGsynPWjbrNMYywBByShZrndceMqyNkKrWvkjuwqyFwaJghYsVMiyDrJt02d2ZZSEA38vTLtWzmwOn1IhRNmyLtnZ8H9PElb/EzVqIokcKAJO+03lBjknA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 13:38:39 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 13:38:37 +0000
Message-ID: <f7238ced-73a0-44f3-8a50-23eb5a2da5dc@intel.com>
Date: Tue, 9 Jun 2026 16:38:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <sohil.mehta@intel.com>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-3-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260522034128.3144354-3-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::13) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 22009af7-b59a-4c62-b8e3-08dec62c689a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|3023799007|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ebutndULSxCeYDCf5bzGgOxkDHL0ZZeHbSejP70kQnoIXjF5AJ2+coU/FOfcSa7wMHxBLV5vGWhzJ4AJE829vs+635ayd7plLXiKBLAD7u09iqTXdOFvXTcKQbJ5UtQwfYBwg66FAAWOol6Xwkn1WbOIPibjCNqqc8bW4LJRQnFcC9MQBYoCn/z333STIDWiahRiBJ82ByLTQJZ1Xlt2S2z6/Z0TYN/w2BtwjtIzCn3sxOrdfkscq5pm8f5E9evqQmh0fJLxOM4E7RHeWePZW4tjGrKSbPdb/yKIdHv+v15XwAKhOzDxLI0h1d6vlgDW01AaBy8F05Mg3c/2ebdiTql35SmUbLXxQ3xAS2aSvxvmuPk7f8ZMvOuF1Iyr4Q60tPNBq4sN/a3Xke6Nxm0izxF4GB5fkCoeIuG1yXildsGDayxe/K9K50j97I3RI/45W+S1FpYV8NrbhLPcubPJBUyOLqaP0Q5WTXcoPN5aEwhlA/XYbORxUBf9lVhQfmdIjVBNsdJLRdksjFpZz/JbJZZ9gTlgdkjRB7CdaSFYd/4Pk5mYknHkj0hUmiRc5MQ8HEVfGpMzpnkcgbcUzMLBCc+L0/r2ehpa+g7LLLkTgGG6Vryrh83rXSmluW39/XnqKViDL1GwcMx2zuop465RwGDpU6AY7dLEk5ohJKyiOA/3SuNd24Rvr/wafet8Erae
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(3023799007)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnFIcE5LTEZlWW1lR1dwZUJSN05MYmw1U1cwRW9TOTYzRm5jaGx3N1FnajBV?=
 =?utf-8?B?QWViMVZaaUJmQ00yYkFIeGNnSmxIMnBYUXhCazJPakluMmFGVW1uVGxYOGpr?=
 =?utf-8?B?VUlRZzc2Wi9vM25YRXBkVXZzMVA5ZHczT0tNV0xyOWlpaWExTVl5ZmZqcWc3?=
 =?utf-8?B?TjhHeXdnSUxPR29Sakh5ekorNDZNSDBmcm1WT213YUdQZk5Fb2M5YnBiYU1I?=
 =?utf-8?B?MU1Ga2k5UmRqVjNJcTdBaldjUTZIWXFGdDdHY3JIT1poQkwvN2FLaENuTUU4?=
 =?utf-8?B?L2NIa3JldGIyUWhiT1VudTNoNXk0clVNWGlxR3VpR0dzd1hZTEFPRU9mNnNX?=
 =?utf-8?B?aDczTVRZUGRraHU5Q2NkU0pLT2pvVzNLT1BMSGhGY29QbFhMQUx5NEFoR2tK?=
 =?utf-8?B?RlI1cTZHcDhqVmNIdloreGZ4WDFsdklZS1Y1OVJSNTZqV0EwRkVONkU5cGpj?=
 =?utf-8?B?TEFrRkFHbHMyYjhxNDIrd3Iwd3puMk5kWTFHdERRN2E5R1RMM3M2L0lITk1k?=
 =?utf-8?B?SCtmbEdaN2FsdWxGZzZTZGR1TzRmUWFvdlJWVVc4elJvcmNnY3RtMVhMTEV6?=
 =?utf-8?B?K1dCeGpMQnJBZGpGOTV6Q0wzcHBLUTF2NWNUUUd6Q25xWTNwZ1BpNjA2b0Zq?=
 =?utf-8?B?YVRyOVRFWmdoMUg4eXZocUlnVmpUYUFiYUdFajYvVDQyN3BkU0tJczVmVjBB?=
 =?utf-8?B?VmVHUW1SZUVKb0pqQng4empNdXg4VzNXRTlqanZuQVp6VE82cXJGbkx1dFhr?=
 =?utf-8?B?RmUzTlRHTnhUUE5pTFkrVUNjYytzbysySTZLODVraktIaEFPL1JjWXZIbHRH?=
 =?utf-8?B?OXlJR1dVMlFOOFZHVGcyNnVMYmF1VFFpa1RvOXlwVm9ZMTNXTUw1eG5iYWtX?=
 =?utf-8?B?VERCZml4R0M1RExIc2VXRlJ1NjE1Nk5WTDMrcGdtcFBxRVl2T083aG94TVFx?=
 =?utf-8?B?YTFaMmVKQ2pwbm55dXJBdVYvMzZkQ1VUVCthaU8xT0NhTFNPL2FYRDcrSEdM?=
 =?utf-8?B?Sml3UzgzRUtwYjhQalhDSVFFOHRZeWVzT2FaOFBRVXhBNjE2UXpycUdJeG9k?=
 =?utf-8?B?cDhsWnRtRWkzLzVxRTJkaENscXlXM2VpRjN5d0VPTWpKWUNGQ0pyWFhQSTRz?=
 =?utf-8?B?NTRVbm9pd09MMjUvcGx1a0RvZVJ6Tlpib2Z6OTh4b2NDd2JrQWtaZmRGd0kz?=
 =?utf-8?B?emVWckk0V2JMbHQrWDRHZlZkRUxNK2FNUmc4cjNydDdUc0RsUFFIUjJRVnlp?=
 =?utf-8?B?S2x3SzN5S2poQzZGS2h3ZFJUdWQ4WmVVRUFGQkVPcmYxcENCbGRLaDV1UkZ6?=
 =?utf-8?B?UDd3MXdldVFKQjdNNzhjaUZaTm9iUVJaZFlCUldJbHVkWGx6MzFzb3ZrZFF1?=
 =?utf-8?B?d2ZmbllCK1phclRoUDM1eG4xWC9INHY1cFUraGo2WlYrd3RtVmdKWHZnOGV4?=
 =?utf-8?B?WnJYMlFta2dTUE1PWnlneTF4S3pESVoySGNzc0lzZnNqUEExOGVxQnkrT3Iv?=
 =?utf-8?B?Ym1aN1VvdVZ2UmVjbWlBeEw3ZmJ2Q2pYMkRsejg0bEZHcWEvTmdiUW5mOFBD?=
 =?utf-8?B?Rk00N0tDbDl6KzRVSlJlNjhlNnBHQi8xdENsOHlDQXV6alNsd2htVUFCeXFR?=
 =?utf-8?B?N2VsM2xsUEdnMVBTZDh0dHVubjBhOFZKZjJWY3RjdmQxaGJsaVZrekJZL1hj?=
 =?utf-8?B?VTRHOEFGTmUvaGRrZVdJL2JvSDZBcjg1bi9yeUdWaitSZ1ovZlRpMUZuejZq?=
 =?utf-8?B?R2hHcS9lL2wvMUJXMy9pN0lvODUxQkJpaDlPeWZhRktvY0RmOGs1Vld2ZHVL?=
 =?utf-8?B?NU8ydC9ZNjh3UmRwTmc0Sk5ibWpvQnBPL0Exb2tmZ2VVWmNOaXh3TXJpQmtF?=
 =?utf-8?B?L1BqbHlLeTN2UFJUeThtTUFzb0UxclJSQnBnSEcxR2tKdzBsZVhHV3hxbzhT?=
 =?utf-8?B?alFQQjVHODQ2bHlBaGY3MkFZVVFubzQyZzUrelplUE1YY2J0RGsyZkM3ZWlI?=
 =?utf-8?B?cXpUUEduRkN5am5KbHFnQk5ad1hDQzFMd1UybGRwZmZoS1dLYmhVTjJma1lK?=
 =?utf-8?B?Mk12QWczL1VTQnVNZUllT0ZaUmZuUHhkbHVDOGlUZ2JxNHFUYmJ1aDgyTWNE?=
 =?utf-8?B?WWgxZnZ4dWo5RjRFUTlKb2UyckNlRWh5bDJEcXUyVE93c2ZJbXlvbmVleHF2?=
 =?utf-8?B?NS9QWUFjOHRBUDA5Y29OQzhoVTdYZXhybVRaN0twOHA3Z1ZRcnR4TEwvUFZW?=
 =?utf-8?B?U1FYS0dTQUtrNnpMbWNCMFVNZGxDcWNFOGtkK0NhUUFQZkx4Z1NzaVAwamdt?=
 =?utf-8?B?Ym9YcVVZWmk2S20wNUlnenpBa2x0MVBPU1czdXpjMzZsWWlTWU9KL2RnSERm?=
 =?utf-8?Q?ftPToMd0oSZXIkWA=3D?=
X-Exchange-RoutingPolicyChecked: hYoo2jmqPpvZZerEN5JLhOvCx7wyiX+HfZ4CYIB9/s35b4xT4PkeGF4UPPHiTCK7mxxwUgUuxY7LqkwAaF5agY3qKCDEMFNRJGdphU7qafoFVJKlilwOI9kGnerYdFFBWdKNI7lWM/wcmv6M98mNs6MDR16bbnTIHZLz3Z2rprkxkK8lD3/Ey9tTYcCbzl81o3YpOhqOjyiDj4W98FpUV+ttd0T9RR3y2CXlxWfnupUdOCfCPedFUpj2IoyQ6exlDpPxFHw1m/8fZPXSftWgfSZ/0izDteqG5bfz8yrrxlM/I3LJ9oEtwrVC6vCxTdxqoOM2D2rx0P5N1CCIBUx/zQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 22009af7-b59a-4c62-b8e3-08dec62c689a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 13:38:37.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuNvfp3HJCHaXBihqvbyTuPwoXCGXc57bgrU4RQZ/9OuLvGYvYCtZu6KaOHn8V3pwzRQAiQVJkVc9HhIhiyvmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6605
X-OriginatorOrg: intel.com

On 22/05/2026 06:41, Xu Yilun wrote:
> +static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = to_hpa_list_info(root, nr_pages),
> +	};
> +	u64 r;
> +
> +	tdx_clflush_hpa_list(root, nr_pages);
> +
> +	do {
> +		/*
> +		 * TDH_EXT_MEM_ADD is designed to use output parameter RCX to
> +		 * override/update input parameter RCX, so the caller doesn't
> +		 * have to do manual parameter update on retry call.
> +		 */
> +		r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
> +	} while (r == TDX_INTERRUPTED_RESUMABLE);

Kishon already mentioned checking only the status

> +
> +	if (r != TDX_SUCCESS)

Similarly could this also be TDX_EXT_MEMORY_POOL_FULL?

> +		return -EFAULT;
> +
> +	return 0;
> +}

