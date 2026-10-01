Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF0377034
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886286; cv=fail; b=KBEyjUAmpbVAEtZVhB/7PlVH2sDqbxC3nBk0sY7W3172BrEezbj5Qw/qk38AE0QZhvN5XmxYJGB/8X5FKA1u8hPUYC7/Mx6GWZoVY+AdTyXIct2a8OK+Hj/l3A8uo1IIOmD2LpFHCyTWq3aN/q1NVAji9UzG+wHmYQtTR+pmGW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886286; c=relaxed/simple;
	bh=M8fzqnkH7fSWBdDovHeOBDs39cU2hnrmXGeAWq1vNUE=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c34C+a/yR2rMnLAM3cE/o+S3zB3lg0UkXyZewfTfBMKfE/EHxyhYPk88IbHOppC59/DHKUZHSgWx1nEmBMxoWcvnNi4+T4XVXjBG7clLoaJp7G8SVmD1+eI3Cm+XGo92ohN72WiPRuelkjRgXtPgWnnjKCJwqGEkbsSgGkusGW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqyGcx26; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqyGcx26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886286; x=1822422286;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M8fzqnkH7fSWBdDovHeOBDs39cU2hnrmXGeAWq1vNUE=;
  b=EqyGcx26NLcaKIS7fksTg8MgybSNpU6HNpeC2pk2vAjEAtch2Fk5Pw5Y
   u2KSI8dUy6zlnhhPn4izrO6qmkJWq9HGXRmSoAZFlcNWk52CQebzyyo3u
   6dW6LlEyqmQRDg/+gi4eaqj2oNhLOBMgqO1FAXgfsftliTl0Os7Gj5eMP
   5sKExWaz4yMoQLrr/14Y1ywTyRAiJuMK1Sajzj1x483NQA+VuIHrl1Gci
   lfKHTjPAiiS6u54ctntiPZYn9Qp37nL7loPNkC2Y9gntWxBjxoQ4FFogM
   torAF6Mmk1Vgl9fWFNZUQ/mzarUUK3tpKanYWGJrYDuM1Y4ZH23JpNIVW
   g==;
X-CSE-ConnectionGUID: kdCXnwqwQIez5gyVNJnyAQ==
X-CSE-MsgGUID: u97UtzyeQGimF+N2v3tV4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90689086"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90689086"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:24:45 -0700
X-CSE-ConnectionGUID: thuyC/prQQC63zGzHe1u0w==
X-CSE-MsgGUID: oFsQwkgfQzSPpvIL5ASD8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275614855"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:24:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:24:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 13:24:44 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:24:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnlOm+e3PUiDZD7GOz4Rrx1H7BnUaCz2yOw9idWthAd+1TfBz6/M347p0NC3DILcv58R/Q553kQ3RtgzuxeIQt4rtvfIXjEGcasPtxzTMYualuPqvawt13hjSMPWU8DNFHG6tpNe/znwin+bf4VPLdjFsg+je7Ig4WH203JPSZWGhxf03NU6Aw/bYhJZXjCoHj5FajgVBfu4GDaXcOoMxe3qW4qPk+zhOTbiIw/8eU9SEtRbEQ6yFZ19t/UGxw9N0i5YwG4eIPrhJx4IBzxBDkOi3FvcfK+bPLkzFaV60WkRZhsQWD5WnKlf89VAAgVGmMX4tKyOGJYAAs8835tj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGK2MxomRmXF7PoRChbeyXgd36PM2TKjxA7dLyevyt4=;
 b=gvtC1r8AxBlarYLPIa/ptWHSeW6a/CBDMPqjUpVoNpGw00yr0Vn+AGLbn4yMZI7syZBBnnPEEaZxspdsNi32rHdkdaEdxDrPK+Gb3gbfmKTs9G0vzh9vdHSBU96yuZyyPaa2WU+XuTx0hZzifaZ1VauKzKG7Td8F3mBYF4n27BOi697UHi9xoO+QUm9VebIh6t3+Zvoddf9V8kFe0cEiGJS62z4tN3T4iF0KeI7S0e7OPBX7t0RZALL1zMrk7KXQQBUOvow+9jfc7bwlS1As9Ht4/GKdFONPvb2V2q2zSac1kp2Rr1/3QpReAatVMr1OevZiIztUxeN5cwDP82v4tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 LVXPR11MB9708.namprd11.prod.outlook.com (2603:10b6:408:388::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.26; Thu, 1 Oct 2026 20:24:41 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 20:24:40 +0000
Message-ID: <37abe64b-e80b-4c51-b4c7-f3c832157e90@intel.com>
Date: Thu, 1 Oct 2026 19:57:46 +0000
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v8 02/20] KVM: VMX: Save guest EGPRs in VCPU cache
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-3-chang.seok.bae@intel.com>
 <20260930215626.8BFEA1F000FF@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260930215626.8BFEA1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|LVXPR11MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 61553525-752b-4647-9ded-08df1ffa0594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|3023799007|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: +Q/xv9EszpmdyIqD7JBdD4YrjT6L5gfrY9Jl8mEjOz/Aw0pNNX7edfUvjSnmCKCLhIWVnpxxjOaaRmaYO9Lga4duaf6xh8gDNpVUapmKFJza8TO1FbzRmnuE7MTZFErlhq4UekLOs3BBaYksw29Eo9YTncvEmqEcZnnTo6Yy86k/3c/G/V6D2ai//Gk9aB1ACq2Ppo0Okb2raMVFmwiUI6hO/hrc7Mm3r5YzjTb4uxmezhvpcMSVOG0hte0fqAGnmPvJWvNogZ47kzv4QeAtMbxp/6hk2E+gRTs8aCN7pq46jdFK8pkcJxbDkr+BRRHH8BKvXP8UY2muD9HO7tF8BsCbXCzHhTBFFZ2/3s+rwkllvItPIhxRpz0EjUxljKNA8b49cU6sL3q14mc1UIAPpTloFchwtnh5XFbTWaA70MJBUc+WhImOyoER9/ZI2nmsTXlp25zyFlWyVeWC5Oa82kICGXkeWa02+qS/CqCcgzycOXEaWm1TTVbmgxarbliSmkO1vciJAesWMVdn0ODoyThRjJrk+wtkd7SSTWG2xH9gUktUNpST3doNX8+LnNtnpETPU1Y4UNwtn/15kCbn9jl3kABKU7HNQuKEP+A0xZj/YD45qr3DYCGIrZRGzNYg8b++MvYil6BG4PdOjIcl8H0jKK90pPcELBpxrMAJLQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzNOMXJOOGlOczhEWEtVVVM5UWZ2Z2c4L2s3elJEK1VqbTloNUVnUjdYbFg3?=
 =?utf-8?B?WitsVTNuQTNIOG8zbVNwVVpVdVNTbXZNYkNKMDNCRm9hQjluYVYxdWhZSWlr?=
 =?utf-8?B?eE0wY0I5NVpjbFdKTk1jSGlBNkZmOUN6S1NTVVVLMExoTWJoOHFmMEM5RVJz?=
 =?utf-8?B?bjUrcjU0Y2FSK21EMlFqSXlwSmF1cDk1MmR4UzJuMXg2RURwVXRjZnJISFNQ?=
 =?utf-8?B?MVNHYjJkTTVUVk1DUDNmeXpuQ2N5cndKTlR3Vm1BU3FQTWsxdmtxN3JrRCtu?=
 =?utf-8?B?YmJRNjJyZUdOK2o3aE5Xc2xXcmgrNWV1WHJCN09KUWFpK3o2VnQ2anJuMytz?=
 =?utf-8?B?Z0duKy90bkZGY204OUV5Qk1uSzN6eDhTN2xLVExkWTBNVFFhUGpqSFdsSTBs?=
 =?utf-8?B?VXJ1WFNLQjJHWlJHRTZDZnhGbkFMRDhPV3dUamFmMWt6NUpDTENnYUgvc3h0?=
 =?utf-8?B?KzlIZG1rNzdwempRRkZGQ1FMemcyOCtoSmlESWRoeGh1b283b0tHYU5CemYx?=
 =?utf-8?B?RTdobnE3T2o0aVBOaFJQM2Y2b3ViZlY3T3NpSzVaYTVQenVrcVZEVk1XQmZG?=
 =?utf-8?B?d0U4TlJZTWRLYVFGWmdDTXNLU0dtOTJxbVhMMEJoZVViem1iMm5ZWFg5WXkr?=
 =?utf-8?B?TlkyK3U3aXp5M0l2ZEZ0eEZTZE5UTG42WHkwVnhMeWxJMit1elJCeUhHTUVV?=
 =?utf-8?B?MitjOTFHdjlPMlBzV2lMd0hlSFgvWUluTEdWSm1sV3A3ZjlCM1hlSGJDRnh0?=
 =?utf-8?B?K0ZxSDFrQnBVTi9BZTJPSTByVXlmOVhzNTI5bkczbnFVbmdmNUUrVzVFeDl1?=
 =?utf-8?B?WjNOUzRFQmJ5ZDlMODBJeGZBcEpVU0U0bFJTS1BXcHpxMDdIVUkwdU5QWEZx?=
 =?utf-8?B?ODBCUDhQbU1TY0p5NDQ4NUwzNlJjT3lacU8zWVdkbE12RlU5dnBscVg3STN3?=
 =?utf-8?B?Szl2S0lFWFI1dmFST2U3bEZWNUJFTFFpSW1EemZweGxKYWxwelZrVDJydXFZ?=
 =?utf-8?B?WUpaZDFETW1xOWRYbjA5aWFhZ0lIL0UwdWdPQWxSenE4TjJSd1ZVckZqeEZI?=
 =?utf-8?B?Y2xxYk8yMkFrRjJ4SmFOMG94OTdJN0hlZjFDR2RMSys3YS9TNFZSZW5SNnEr?=
 =?utf-8?B?L1A4Y0JaMFVjSExhZ3JsWWF4RGZnMXZKYjloWm1UK2NyOG5FUnM4TDFud0dK?=
 =?utf-8?B?SHdLdWlJTzlMV3EyYzcvQ3FtWjZDYndCaTNJaisrMHhXKzRWS2svWFVObTVE?=
 =?utf-8?B?OTIzdkNPUFlFUXBxSlU4S3o3OFRkNjVhNnc5eXprcUNvQ1VZZHhQWWRjVkVB?=
 =?utf-8?B?eHErR1FuL3pndXcwSG01czFTL3pMY1VUa1ZJb0FkMXBIZW82aW55VlliWm9Z?=
 =?utf-8?B?Y29oQjNpczQ2LzJta1FUMUc5Mzllb2hrSGlER1Z0ZDd6Ymw5NjdBdXlmQklu?=
 =?utf-8?B?cVMzbUhnMCtNWWlDeUg3S3EzQUZKYjhRazRQK0orVCtFbWFXS01ZWVMzWDFa?=
 =?utf-8?B?RlRpeSthdWlDSGJXMHIrVi9TaUFsSmpnOGIzamQ3RFFxcUt5WDJxUVVJcWNO?=
 =?utf-8?B?a2E2WEc3dWFOZTBac1RqeStTTFRscmtzMzlSQkltb3RiWE85SGpHamFVVWNI?=
 =?utf-8?B?aTZ6Y2J0eTEwMndITzd3aWdvOFhNYUJoYzhMdHNjVGcyZnFFeUkzWkVucUp5?=
 =?utf-8?B?emxZQlNmWmFNUjhWM3hXZlRuOElEQ01Kbzh2d2RISTNKUmNVSlQrQ2xhTGJq?=
 =?utf-8?B?NjJsemprUnhJVFhVeXFBcWtJdFh0Y1g3bUlheXBHUThNNFZEZjJJSGZaNUVC?=
 =?utf-8?B?Zi8zVnozZkR2WVVVMEozcFJjUXJ3QUEwSXEwTFp5UTBHc2VhY3p0QTRVNWZm?=
 =?utf-8?B?MlFiTlMrK0xYTlk4Rit5ejlCWE8vRUhlUWloUVJhS2o5MTY2NzNCemtGRHhi?=
 =?utf-8?B?cXNjNmRjMDdtUkk2MGFtWDRpMEFTc0xzdHQxRVZFTVN5WHVmSUpxazdPTTRT?=
 =?utf-8?B?M2c1UjB6Tk55M21kUDFXRmVlVk5waHdZYTViRlNiU0hDR0pxNEJZN2ZocE5E?=
 =?utf-8?B?VnpZSlE0UVdOeEFzVEZiWWZCYXM5M3ZvOXZKTno4aHpsNG13WHZvdkh6QUpQ?=
 =?utf-8?B?L1Jvc0V3eUpENzQ5UXRkTnFXUG1tVG5XeXdabmlyTDVvcEdoeDYzTDVkUTNQ?=
 =?utf-8?B?bUJ0VC8wUUdsLzNQTkxQWEdCOUN6WlRUZVc1TXJOV0dJWFROd0RaMXFiQ253?=
 =?utf-8?B?TmFQT3FzVEtUeFVSaXdOR3RCODdxazlMMGtlWjluU3hqUlNFMEJJZlhLK2tC?=
 =?utf-8?B?QVRuZnRqRFVCc2I0U1RuSzF6ODlXbFcwWWFzRFcxNWdLRzZMZHB1QT09?=
X-Exchange-RoutingPolicyChecked: lYopCzMVO76k8ABNKUN4qtF1W1fa0FaxT3LhAlb1glRD6QRb756quma07dMedrxvT6FcgDBGG1/T1Tk7BMiY4cUvhdn1G9HuQE1whJz0eOQHK/BZ4BDHdXGSUtMI3p76f69GPIRdDsmlfK10jGw7I/+NFj4COS/D40qKQQZ+uPnB+eTQnW9Ux/5E6eMMhFRy0yrCDqDlm7KZcFgKLiObVi0IUBLbPwlJ3MPCrGv/nuoL/rolNV7wMmPYo/UdejsqIwb8bTwpujUOVbSAE8K+QnL2Jo4RhEFhc/jcMPkbqt6KZeVmJqJ8d9jyYzx7uDc+pIpKZ352Q1sjSNNPnnZ1rg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 61553525-752b-4647-9ded-08df1ffa0594
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:24:40.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OORTWgxPUTzU6Y0TAElPuBFVs6CAGtZIpXR+DR20S+LJc4lK6QI5dzpV0XW+pzLADuvHfx3LtaWbL/41kkdRdzJ/SfZbLxIrmYlO6gX+Mmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9708
X-OriginatorOrg: intel.com

On 9/30/2026 2:56 PM, sashiko-bot@kernel.org wrote:
> 
> If the host kernel is compiled with APX instructions (which this patch
> prepares for to allow future usage of APX registers in the kernel),

No, this patch does not necessarily prepare for the future EGPRs in the 
kernel. This approach may have benefits if it really happens.

Note that commit 63edf5a009ae ("x86/build/64: Prevent native builds from 
generating EGPR use") currently in the mainline.

Thanks,
Chang
