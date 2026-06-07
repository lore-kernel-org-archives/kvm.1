Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24201224F3;
	Sun,  7 Jun 2026 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780807088; cv=fail; b=HpscdOoZ4Z1VZi7VNbPuZm49D1A+hWgqC7NF6NhjITKrzL41b6Kl90Zo/qe1dIh4JY7RUQwY6xMKZg5XeoiIMKHNh0X8qLULavOKH3cnajCPKglyj+iOmM3dhKL8FW/N/EynyeBMxux4VxuQb1IEyRs6C5BhHx7n1bwpEwC94uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780807088; c=relaxed/simple;
	bh=Z2xh+DtCoeZewUcZLATcDSMFac7qnSgAIiDLr1QsL8Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W/mzRd4Rz4aJP71nZkZkDGiu75tXQIxrlCBhZsfBCgWtH8mIu6I9pEwjeRDCAMRsKEwMG8RPZHetYFS7Vu3fCcixROQfKF1IqtxyhfU/fGV3T+p4YebJTc3RajnuDMkQqvhyoXlFFoh4LH0xXkb7NdT6vVi6+F4OvwMVlYSDu5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezOYx0U1; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezOYx0U1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780807086; x=1812343086;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z2xh+DtCoeZewUcZLATcDSMFac7qnSgAIiDLr1QsL8Q=;
  b=ezOYx0U1sioAlHSfMi3EiOYphsH3tv83pUMfgOuM9H07L8NEdw0ijw/0
   LmsemoOmp2LeTMRNtxI/ot1gE8Z4pU/kExqOV5okuR89cDNMl8oSRsOoR
   7AwAqFZV47t+TSCCPNPgxSO957k8WPbR/0D+I9OINX3aYnfLOLIYJsMzv
   yis5e4nsCmHLhRGC/OLozqFx24vbM3k3OJz+Rd4UZt1txUuUew5TctIRT
   lnYbpK15RzmO2bJVbYpAqkapxrJRzcn6wh5lPCIhrPfeQUfAD5rl53QtS
   gXEoNm91LR7wXV/of7WXxkCV2/aTTpFc3n+3e5/S+XhRYLMDdOeenFQ+t
   A==;
X-CSE-ConnectionGUID: vm3olUudQEOwImEhYcbu5Q==
X-CSE-MsgGUID: N1NcWRYxSnW0EoCbVdx6bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11809"; a="81325473"
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="81325473"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 21:38:06 -0700
X-CSE-ConnectionGUID: X7SXjg2GQiyH4pDau6aqXw==
X-CSE-MsgGUID: xsMrX2JMTIe8z7e07WK9zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="247064392"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 21:38:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 6 Jun 2026 21:38:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 6 Jun 2026 21:38:05 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 6 Jun 2026 21:38:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjStDFiB3sh299I6XQpooEG/EDLl7AOvjxJ+kdIELvL8jyIqnPzKSxNurBMSkFLlmMEjNb2yCyZzcCpvmxhNQVQpbwb7Pye4j2FtLft5jLt7Hhygt6Z+stKjQOdgBOpnCVmHzu/dlJ55uwTQe6B8+ANHpAyoh1i5ICapTdBw3ywoHE/sXNtWydulTGmHtyU/wrlIBXFYtFtnBGp5fOCyQqow2q2BtZBYfoyWUcNfevtMk7r4fNL8mXK6i4Nx+Fsq9dbaNZkl3atK7mUpUMkexX/yE03wEV/l1fpEMyL8v172awHvtUuUZnxpo2UMNbBCFUYVjZ9n0+tsUpyxGt6rEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toWvyjHwrpiR8hcuk85mFrxXSnLGb4xGsssBxVbTIdk=;
 b=qmuWPwCt2haNXyMS1Hc8KzGgDnvySxyXHexXXY1icnpIQSnEsnFlRzAX7G6oIY6J4JCMuG3+E2+EfxSRHpOB/SKChBBWRbmOGatQdjM2sj3ZomLaxAEl5CyEyD8U1LzbOPWbmK90GanylFFGnVni9B0tIYSbyqsJ0lbcjabAx+tsxclZ/gzmOILZbKrVPy9Ea69gXzF7Z2LwPyJsVvcXbl51ioCUUjPQ6qvseguba2pKw52Ofbqn44P1wlvqrbzlN/fkoIXpPNLmeEbg3W18YDDJIpDChS22juFpMmBYXf4VViemCwbQ03QTo6h7Q/ar2iHUT7CjGyDzLtDmHtWH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 CO1PR11MB4978.namprd11.prod.outlook.com (2603:10b6:303:91::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.11; Sun, 7 Jun 2026 04:38:03 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0092.007; Sun, 7 Jun 2026
 04:38:03 +0000
Message-ID: <f44d997e-49fe-4d48-84e3-e260bb9d3164@intel.com>
Date: Sat, 6 Jun 2026 21:38:00 -0700
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
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20260522034128.3144354-3-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::21) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|CO1PR11MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: 0970acd3-1f13-4a90-671a-08dec44e8f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|11063799006|5023799004|6133799003|4143699003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: H5Cb6Gvy7TgyI67JvPXVoY9WJWOBWD5xSaLFvkcdVjPXKnYf+uxf4RJ8qUpvOsr2FhhiTGDdJm5zycUmHoyqYkUN/ur4aWVF270vY2V6C8A7W4Ldnk+RHN9lpZitubqvWFGK7Kho8N/vEfvF0wng+WqpQ3k1bIL1Bny+IpEqvDXOGIe6tLWsJNRpFl9ChrgwL9SVXYu3VINGzZKxjD6D5Lr7UkWprYXaQHaXTfgdqKfxOjLtTMSJxdtXNJS7Bq+0VXck3asLe8OZYdBboZ15mFrVqLZ9PexDZT+1D0sFoUgBL2DNfr0XXQviKdkgG+C50mJIGJwlh5XtszfNsGacsetB2GWqQePydw51e9lHNmlVRSwPyYFhP43QtfsPWsEYfigHJ/ABLQPGVcaJzK0v5PRV3mhPskrGcZAfoF6WxY9CaZpjlV+KtpNVNKU+FD5/vOQKu1TL8+ztwcaL3e/0l1+CKx1d024G8MF9lSnkWCqTsbJ75UmkY1qOlSwri3rcGNmRtIGYHlo+jEhPK7ENXgwn2NBIU/bBXbHvz4lYdEPboSgx+Ur//Sjk4OpF8ix8lNhC7S8SE7GjTuqSskAHdqBoYk7BtNkerT66fjOMp81jM+kxrDltwSAvhZ0VLAUE1HmyapEVNNjhXG91d1JQi6Rv/zTRAqSEjKc1pH4Y6nHMXHi5RGY++aeeb0UY6WvS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(5023799004)(6133799003)(4143699003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFlyalR5NW96a01zVUJGUk1JWWJMeTN0U1l1dHFKYW1OOVp0RnVNTkprSjJW?=
 =?utf-8?B?eHVFVjc1L2ZsSm1VQW9EcTRQK1dSb09ZU3BxMnR2bGEyWFVQZ0tEQXJhN1ZL?=
 =?utf-8?B?bHRCd2JSRWs0VUFYTzcrczlKSjBYRlFadkg1UDc2WEVsbDFodklXb1FEQnND?=
 =?utf-8?B?aHJGSUFGM1RIYWV0NDVjM0p2TEtFRkxja0QxOWR3VW45cHkrRFFNODdnNC82?=
 =?utf-8?B?ZzEyYzNEWG5GeTZoQlhzNlRta2draXdvZ1IyVGc0c1Rtc0VhRmIwNy9peVJx?=
 =?utf-8?B?eTFsWmZSYVJaQWhNSGdjUjJ5TlpTaTAxME9xMDhIWkY5WVNHY0J2cjg5SHp1?=
 =?utf-8?B?cnM1Sit1cmtvN01kM2ZWQ3ZoQ0psdTI2ZDlLZ0ZXTEI5QTVQVXpvcmNZQTdB?=
 =?utf-8?B?UzlFL3FpK3ErNHYzWVFac2FiblVRUTZ6bVBCajF5ZG85TkxmYnJwMDdUVHRM?=
 =?utf-8?B?ajNpNFNPamR1QWZuRjhqQTI1VW9UbVhwaGRzTWt5UHVWSFdEc1p1K1lmSG40?=
 =?utf-8?B?dXpjdEZIUjV1Ykh2QWgrNFhUekFXTldISE9od0k2OEJNdjFqdG96WGFSK1E2?=
 =?utf-8?B?SW9sVjA5VUpHQ1UvN3pnTTVUalcvL29KRFphUEJReEh2Z2ZQZWlzRVNBZTNH?=
 =?utf-8?B?OGI1R0JhMnMyZzR2anhyUjA2eHl6ZTVaREVkWE9hOW1US2xRWS9hK2dqLzdm?=
 =?utf-8?B?SDgyd0lIYTRUaXdFdnczZTRiVkNmSkxEWDBSNEY4K0p2UVAvSSt2NDZQUXJn?=
 =?utf-8?B?QjA1WEgrdTBRb043eVBZdk5lOVJ0Q2dMdFZpRkdDcEZFbVNQMmZ1b2hwS0V4?=
 =?utf-8?B?eW9vVFVZM3dkeFdXMndJbEdvTU9UWTRMeEdmMUxvRWk3YXBhZVQxM1dFNXhZ?=
 =?utf-8?B?RFlWMzhqVjlFTTFnWndJSE44dHFvSnJpNHAzbnR1Q1ZDNDVOd0JrWmZNL2xQ?=
 =?utf-8?B?aGJ4ZWFOOUh3M0dMUVYyaWcrU3Zsekt5d3RrTitZM2p3azBJdEhaZ1J0LzNO?=
 =?utf-8?B?RVFmeld6cUNSZXRBY2JkT2gySVFFSFcwczVwekZlc29TRjBFOVpjNXdwVzJ6?=
 =?utf-8?B?OHNkRm00eitWbXN5OGo1dGdIZVVMMmxHcU9YKzhEWXdnSytZQkhnVHZoZ1ls?=
 =?utf-8?B?RGZYMUc1TEFIRGs3N3hZeG42eGhPLzB0UUdoT3pUYnQ3NlpWZXJhd2FJK2d2?=
 =?utf-8?B?cW5Rbk44NVcrVTZNU2YxbmdWQzViZzVlZWdOZUFOMzdlcmNMdnRwcm5PWUJ2?=
 =?utf-8?B?UE5TZVAycWVOY2hCbm1CWEc4bFVvcnV6cFF6SklVUDZvQkFzQi9SNjA5dzlM?=
 =?utf-8?B?ZGNLOUIyVmRVdzdtd1VLcFFpamxkV0MrN091UzRYcFJqUm0xNy9ZbGRmaGQ5?=
 =?utf-8?B?NVRSTGJNZVMwNHpJeWdMLzJ2U0p0eWg4L1gzM0lTNWdLYjlZZTNEYXhldXhq?=
 =?utf-8?B?ZmNvOFRwY0QwQ2ZpUWkzdEdCTkZQT2VibFJxd2tWK0h3Tmkvem9ZelJMYkQy?=
 =?utf-8?B?ckVEbEhXdGVQT2l0cmhxSTZMTjd6WmNtQ3JVYjN3TFJIcTZXSjFxOEFmdW9u?=
 =?utf-8?B?OFllVUJaNk5SdkJOWHRVaGFQYm9wVEFFbzBGeGZIWDA1LzJjdkpsMHZ5YWF3?=
 =?utf-8?B?OTZKV1hKMStwMUpUUTVvcVl1SE4wUmdJcTRITWMwZ0ZqU2E4eEhYZGpPYVRR?=
 =?utf-8?B?TzdNcFlWOHEyS0tra2NaOHZhdDhRRjdUTUJNZVBaNzVtRmt1S0o4c2J6b1hh?=
 =?utf-8?B?KzdOUm1JUTJESTZFQWczSkxZTGRQQ1VqdFU1bFBBRWpZL0xxR1pjTnVHQVo3?=
 =?utf-8?B?enlGTnZMYmhPamlDWW4xMUdyeU5MV2Z4bWgyT2FqRVd1NFBEaDlQSUp2VTdG?=
 =?utf-8?B?THJVeXFPL1BmeGp2N3p2aDkwa1l2ekZtaGNjYnE3NkRkaER3TVNldG1DczJX?=
 =?utf-8?B?WW9KZm43a216YjVtZlpyczZBVzIyNEpyUVI3dGo1K2JBSVRta2swWTlOVXJH?=
 =?utf-8?B?ekJMdzlVcDhWOU1ITithdHFqcHRwd3M2MjBScklBQWRVUXN1NkR2QTNmVS91?=
 =?utf-8?B?K1piVGVFdFMyZkNJRGc2Y2RVcVZzUFMvcmdET2t6eXZ1dHNTdktyYXRaQ2l1?=
 =?utf-8?B?OUFscEFsZndEdXlZVVY0anBEWEZwQ09ya29ad1BMenVvaE94aXRpMHVuWERR?=
 =?utf-8?B?Ui9xUVVIUU5aZEpJeXVoVG9xSnlvUElhRWpGaWREYjU2T2tGVTM0dWlzTExD?=
 =?utf-8?B?dnh1ZGdOdTZYQWZKYm5jeGdaRzlIL0crOXZsd2hWZXBnY1g4TTkvSmtXOTE3?=
 =?utf-8?B?Zlowd0ZXakJFVEZwVSs5Z3pOc1dkMVV4MGhNTUtLV2dqazZOWWx3Zz09?=
X-Exchange-RoutingPolicyChecked: hKy4jLRZgJ5yjCv50LUSXIMolkrs/ZHGrVPdFqQlBrIHoiyVDr09dkZrSHSMsUiMCnFk/czYe6SETwvfTkrtxGgpu4SGntVMwLwh0L8Z239sHXJ0quLhRe3Hjnxde8ktERmAlhw7fWQRGE6bCA5NaPUzwMTClmL+HIZPXL5l/GS0B/cZUL5xrUU6iMj2BUeD295enRGmdkteMnJR2gfzvrDrT1zwIkGt2lpByORmlS25T0b+f/l8iAU5/OaTuc0QSrC9doOqLRdUYO8QcBeh5zZC7ih+bQ4ObZjN1nvZT6cR19dxw3b6CMuaJcvXADoMMjVcCOVCIeo+RiQON/yRZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0970acd3-1f13-4a90-671a-08dec44e8f8a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 04:38:02.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmBRsWCFRQb53v12VxcxhL+N65TweauEH8uJQHiRWbGIs7stz9ntL+fOiw+frpQCaC+vC52IWLj5HElxkDAoeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4978
X-OriginatorOrg: intel.com

On 5/21/26 8:41 PM, Xu Yilun wrote:
> TDX Module introduces a new concept called "TDX Module Extensions" to
> support long running / hard-irq preemptible flows inside. This makes TDX
> Module capable of handling complex tasks through "Extension SEAMCALLs".
> Adding more memory to TDX Module is the first step to enable Extensions.
> 
> Currently, TDX Module memory use is relatively static. But, the
> Extensions need to use memory more dynamically. While 'static' here
> means the kernel provides necessary amount of memory to TDX Module for
> its basic functionalities, 'dynamic' means extra memory is needed only
> if new add-on features are to be enabled. So add a new memory feeding
> process backed by a new SEAMCALL TDH.EXT.MEM.ADD.
> 
> The process is mostly the same as adding PAMT. The kernel queries TDX
> Module how much memory needed, allocates it, hands it over, and never
> gets it back.
> 
> TDH.EXT.MEM.ADD uses a new parameter type HPA_LIST_INFO to provide
> control (private) pages to TDX Module. This type represents a list of
> pages for TDX Module to access. It needs a 'root page' which contains
> the list of HPAs of the pages. It collapses the HPA of the root page
> and the number of valid HPAs into a 64 bit raw value for SEAMCALL
> parameters. The root page is always a medium, TDX Module never keeps
> the root page.
> 
> Introduce a tdx_clflush_hpa_list() helper to flush shared cache before
> SEAMCALL, to avoid shared cache writeback damaging these private pages.
> 
> For now, TDX Module Extensions consumes relatively large amount of
> memory (~50MB). Use contiguous page allocation to avoid permanently
> fragment too much memory. Print the allocation amount on TDX Module
> Extensions initialization for visibility.
> 
> Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>   arch/x86/virt/vmx/tdx/tdx.h |   1 +
>   arch/x86/virt/vmx/tdx/tdx.c | 118 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 119 insertions(+)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index a5eec8e3cc71..2335f88bbb10 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -46,6 +46,7 @@
>   #define TDH_PHYMEM_PAGE_WBINVD		41
>   #define TDH_VP_WR			43
>   #define TDH_SYS_CONFIG			45
> +#define TDH_EXT_MEM_ADD			61
>   #define TDH_SYS_DISABLE			69
>   
>   /*
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index c0c6281b08a5..622399d8da68 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -31,6 +31,7 @@
>   #include <linux/syscore_ops.h>
>   #include <linux/idr.h>
>   #include <linux/kvm_types.h>
> +#include <linux/bitfield.h>
>   #include <asm/page.h>
>   #include <asm/special_insns.h>
>   #include <asm/msr-index.h>
> @@ -1179,6 +1180,123 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
>   	return 0;
>   }
>   
> +static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
> +{
> +	u64 *entries = page_to_virt(root);
> +	int i;
> +
> +	for (i = 0; i < nr_pages; i++)
> +		clflush_cache_range(__va(entries[i]), PAGE_SIZE);
> +}
> +
> +#define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
> +#define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
> +#define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
> +
> +static u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
> +{
> +	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
> +	       FIELD_PREP(HPA_LIST_INFO_PFN, page_to_pfn(root)) |
> +	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, nr_pages - 1);
> +}
> +
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

The retry loop compares the full return value against TDX_INTERRUPTED_RESUMABLE. Should
it mask with TDX_SEAMCALL_STATUS_MASK first, in case the module sets any
lower detail bits?

Ditto for TDH.EXT.INIT in patch 3.

> +
> +	if (r != TDX_SUCCESS)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int tdx_ext_mem_setup(void)
> +{
> +	unsigned int nr_pages;
> +	struct page *page;
> +	u64 *root;
> +	unsigned int i;
> +	int ret;
> +
> +	nr_pages = tdx_sysinfo.ext.memory_pool_required_pages;
> +	/*
> +	 * memory_pool_required_pages == 0 means no need to add pages,
> +	 * skip the memory setup.
> +	 */
> +	if (!nr_pages)
> +		return 0;
> +
> +	root = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!root)
> +		return -ENOMEM;
> +
> +	page = alloc_contig_pages(nr_pages, GFP_KERNEL, numa_mem_id(),
> +				  &node_online_map);

The SEAMCALL takes a scatter list (HPA_LIST_INFO), so the module
doesn't require contiguity. If the goal is just to avoid scattering
pages across many 2MB regions, maybe dense, 2MB-aligned allocations should
achieve that without a single pool-wide contiguous block.

> +	if (!page) {
> +		ret = -ENOMEM;
> +		goto out_free_root;
> +	}
> +
> +	for (i = 0; i < nr_pages;) {
> +		unsigned int nents = min(nr_pages - i,
> +					 PAGE_SIZE / sizeof(*root));
> +		int j;
> +
> +		for (j = 0; j < nents; j++)
> +			root[j] = page_to_phys(page + i + j);

Would it be better to allocate per-batch (i.e. one root page's worth
at a time) rather than the whole pool up front?

That way an intermediate TDH.EXT.MEM.ADD failure wouldn't leak
all nr_pages. Also, a batch is up to 512 pages (= 2MB) and its allocation
could be 2MB-aligned, addressing your fragmentation concern.

> +
> +		ret = tdx_ext_mem_add(virt_to_page(root), nents);
> +		/*
> +		 * No SEAMCALLs to reclaim the added pages. For simple error
> +		 * handling, leak all pages.
> +		 */
> +		WARN_ON_ONCE(ret);
> +		if (ret)
> +			break;
> +
> +		i += nents;
> +	}
> +
> +	/*
> +	 * Extensions memory can't be reclaimed once added, print out the
> +	 * amount, stop tracking it and free the root page, no matter success
> +	 * or failure.
> +	 */
> +	pr_info("%lu KB allocated for TDX Module Extensions\n",
> +		nr_pages * PAGE_SIZE / 1024);
> +
> +out_free_root:
> +	kfree(root);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused init_tdx_ext(void)

Could this be named init_tdx_extensions() instead to disambiguate
from tdx_ext_init() in patch 3?

> +{
> +	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> +		return 0;
> +
> +	/* No feature requires TDX Module Extensions. */
> +	if (!tdx_sysinfo.ext.ext_required)
> +		return 0;
> +
> +	return tdx_ext_mem_setup();
> +}
> +
>   static __init int init_tdx_module(void)
>   {
>   	int ret;

