Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3540DFAF;
	Fri,  3 Apr 2026 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775174737; cv=fail; b=YmVUGYBJ6N1fcDjDWZ6o0ivgqxN5XCYerX4i/0urPxYaeAQM/30cCsNMzpKI1CaGaH55DF38xJVJmuN6rctJfdKQmFdoircFBjAQQbVB9nqbDwdDdNo3k9mWXcuVUuPRN9C+CQJabVcqbi4kuS2nZ03kEYp/NQcSOjmbE/muJHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775174737; c=relaxed/simple;
	bh=PfIK/ehQCRR15PrYLeaN4P86pkwYxDpvLBnd9Xl8sro=;
	h=Content-Type:Message-ID:Date:Subject:To:CC:References:From:
	 In-Reply-To:MIME-Version; b=VOOJ+td0kigcVL31U99frTgpL3A4wZLXWycMIuhJRNzABKPJrOiXqX+xb9wuZ7QogeLYlUYUluusKf+ukkHbdi8AzJgqOeLCQCVT7WVkCIHKUFLumgpCHdFOvgSCOR95driLIn/zaZyHqfcRUVOiiPd/vfijvsmtgS6YnQ67Q0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuQbdGmB; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuQbdGmB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775174735; x=1806710735;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=PfIK/ehQCRR15PrYLeaN4P86pkwYxDpvLBnd9Xl8sro=;
  b=UuQbdGmBttNchLkW0XmQd365r59JZH2YZxi5w1QkmO8CBBZED+zWDNah
   V2NGpI6bHgyECjFyj02C88X6LXZftBvomgx7ZPkYJCBKu866l3ZFvbE+q
   tTTzbVGW+HNjGxZzwOtgBictPfSF6xIi5FQhwTEcMxYvioJ1TZ1Zyum/Z
   g7T7BJDmBnrW/aYw7497m57ZgK/A/lTXoUsuyYcY1takllpaaPg+HWWGu
   ek87z9sLqoPNXLu29/laIijBfOS0TmnmLTMFLndzPMqzCFH/IVwpgMn31
   aU7D5ekgYZv3gbJPMiWhtPaugKOarNxiEH077oTEbXqYN5pnLdECJHq4c
   w==;
X-CSE-ConnectionGUID: sgGKBM1XQz+2WIEnCcOrOA==
X-CSE-MsgGUID: 5nm1hMBnTvOe3bjHuKkx7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="78837762"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="diff'?scan'208";a="78837762"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 17:05:34 -0700
X-CSE-ConnectionGUID: vmdhOdwCS8uU7J8nSEbMaQ==
X-CSE-MsgGUID: P6JAj0FFSc6/QA4VGInn8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="diff'?scan'208";a="220481863"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 17:05:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 17:05:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 17:05:33 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.55)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 17:05:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwYFgE3QjjEVfmjZDpunAUjKxZDwbZzB2R03fKKXIVi42d7C04Vk+wo/y+DIasjnKynpO7buj8arSCCD+ldkge0En9SIKO2PGYr2ygqVysrjFqXHUQxh5vEefstWb9iM3hI3I1vbP2Tcp/pc09/6301ljrybGNyzvEhLYOUM+fL7zxaXugzLNFDIh+B+u0/PiQmfveVR47yGAJrLuD6y0+EOIfRkCwb8Jsas4AzwPxUUeqQSBFQGMqGU7IvfJ2tl6u6ZAArbp3lBs4qmtTa3dGWtArcvNuU3qj17lo1OxfMmP99X/jsR0CtNlM3gcvFJRhht1uNfCsBvWA5Rhi3PzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eq2rWx8VVnI+Io2mfFs1JuZMzHo0AuNeeMl3ajNbms=;
 b=TNLZ8gNi/nNfqkvvJj0y5emO/tzcN1/1/JK/JP6MEnU7y7KDvoTWXU9pvdj02uY9rlqqw9VdIe3tZmzLuqP2guP3wETaCIbRgFqW2lrR89Cfrj5zIzYMtdbSxsaObqfrI/ILqBhqmDjxRmyJBCbpO9q/QJUmIIa9srmTNml3zc2cT55peLjMY7Ym5ULae4WVTXJdj7YYDHS2FjEUx0T2OBqwrZXfu1kQP1Oq+dVhkbF287/Je9JlNp/Y0jzK7UzN+4r72+LwN90XeUGNBs0BEkgHLMEA0VmoS7JTitmNkzeHpNSN0gxihng5RH1PiQe4hBvdUiz7VVeaSLV7VLw0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH0PR11MB7616.namprd11.prod.outlook.com (2603:10b6:510:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 00:05:29 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 00:05:28 +0000
Content-Type: multipart/mixed;
	boundary="------------P6g9LxYWmozGQwdKLlmy9JFy"
Message-ID: <476f4107-1f0a-4ab4-b1d9-d680fa44b70b@intel.com>
Date: Thu, 2 Apr 2026 17:05:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260311003346.2626238-1-seanjc@google.com>
 <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
 <8853f8d5-57e6-4ea4-b9b5-8a0182d0d012@intel.com>
 <abL8SW5JS1aV5goa@google.com>
 <3051c067-048e-4388-8c22-1e275d8d3b5a@intel.com>
 <ac72z1cfXnpUmkWv@google.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <ac72z1cfXnpUmkWv@google.com>
X-ClientProxiedBy: BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::9) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH0PR11MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c7cfdc-ac49-4b51-92e6-08de9114b697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|6049299003|22082099003|56012099003|18002099003|4053099003;
X-Microsoft-Antispam-Message-Info: nn4fq1bYDi+BF4eemtrOlZyEeN00MgKEM5xofjwst8y+eBLEwUxU/Gy0Yj/E/6gu9mwWH+NjSp4oz/lC7VC+BBmu0FN0RVr7H2aKWodbv3UsmNpImmCCMjvRmap9j2TDrxIalwaRWlgvhHqHr/kXOCnu3CKZQgD/SXp60pLL9qh3GkJte1nyM3M15D6dh9k1YGN54BQocolWwnUR0tj+z3Q0HAcvVlRbKbqSUPO7d+nwHUwAzd7vwvCVkqAkvXFPBCPYY/CBCAY5lQzKtgelEP20I+i6WUiJhq62CHFPSu4aToqGM+np066kvzTx4D/6E90kBVurb0hLCwnFstKsOkfqET4gEaOG7vwYwtfw2CqmXJz4IDJWHGNLR2a1bz1m93AHTKGv/BkDEJoLNUI7DG8ZeOoZkWn4azw2dOW6bMSI+o1fa004RVkYYaOzDTP5m68NTgaGEtFXiweGNBTsECaEiqhB8OefYkczWCEzCYxShUPJdQo93mnDuxrg3Aas419BHAbteSh0api6Rh3QpHmMyFyBITkgtiOF4xEth5R/5rI+CacVDH6RX0fIik+i+fUpNWSDuibWhaQXyqUpxyBP4yIj39intlktt8UHa9g3X833hDaPHA9zrSnb6yeA8AnNt2ifaFsJUWMj2BSAxArrq+VIjjLaosoCuiJy5lzKtULsazkem88tQ1w3IttP2u6Ki2n0TxX443oY4qpC1bok+ZPFfTv9F0p7b1ij6K0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(6049299003)(22082099003)(56012099003)(18002099003)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXZyemdDbnhKUjBkNkgvZmFWRDRzK205WTE5T1pkSEdhdUQzcjMvSUk0b3l2?=
 =?utf-8?B?QVI4azdlbSs3cnZSYm45Wjl2WDhLSFBTT2FYL0g5NkFCYXd3bndXMFAzYzJO?=
 =?utf-8?B?NVZ2UDN5czNDZHcwc2xDL3JZZUZ5aDZ6RXZuaFc5MmJqM2pIc21xdjk4ZU1S?=
 =?utf-8?B?L0IrZ2trRzBnZXljM2MzK3QxUzhweERyUTdKNVVOV1l6RmxaVjVrRnhhcytR?=
 =?utf-8?B?eWdxdDJ4QXdaYmgydW1MWkcyRnFOZVdaSnhubHZNdzhtK1Z5UFRUUjMraVk4?=
 =?utf-8?B?QzJZbjJxTUtsWWRGK3l0USt1Yi9uckxaeGZwdFJraXBnTms2NGJXMGplSnNI?=
 =?utf-8?B?bzg0bVRZTTZieS9LbFRNNGk2anZUd0t5blBOUnNMRlc1empzU2RCSkpRU0k0?=
 =?utf-8?B?eitUMUpJdlRwY1NVdnFmRE1TcERiWkN3Y1dhZTA2U3QzUzJ0TmtleXp0VjVI?=
 =?utf-8?B?NjZ5TW4xRjFLUnA0Z2lEUWZxWkhOWU5GTFRnOC9zZmJpK3o4M000cDZNUGpX?=
 =?utf-8?B?YjU4MzJGYmlNWUhlQVBTVmNqSG5kMEt4RVR5bmVhYVN0S0crU1hTYUUrSURI?=
 =?utf-8?B?ZmQrWWkzQ2VKMGNUMTJLdUpaekdXaHRtMk1XRDdLbzY2UnlPQmhTdDBmOEVs?=
 =?utf-8?B?V1JqMThWb3MrRXFtZzNTVWxtaXM4UEpra2Y5L09QbTV2dHB4N0VZdER2RHY4?=
 =?utf-8?B?SUZCK09od0JuWlFqYWVRMm9WUmduZDcySjlQZFdiN3VzWXBqK2xHd01nWG9W?=
 =?utf-8?B?UFB5VVVzMFZHekU0eEpWc2pvalFEejhkeDdPeEtocXk2S2lPNk51R1JsdlVm?=
 =?utf-8?B?ZHNxY21YdWtpWG1FK2RIU1F0US9EN1dVUUtQZHBlZU44UEsrRVJpdHZueU5q?=
 =?utf-8?B?RThUZXBFVlcwU1RGYkszSENBSDFaanYvN2pZQVVtckRPdWxlVGNraDZSL1Jn?=
 =?utf-8?B?K200a0pkcDZzUTh4cUtiUkpCTEx2NGxUUjBoQm5Ud2phSjBOYkM5anAxTktS?=
 =?utf-8?B?YnllK0UxOGZVbklqc3NMVzJyOWZvQjFJakQ1TGFnc1VHWkYyNlJ2YlJFZVcy?=
 =?utf-8?B?aHo5bmxYdkJXTk54VGdzYTV5aHhNTWg5alBHckJiN2k4dTFMYzJIbWthRk9x?=
 =?utf-8?B?M1Z6clJ2eHNGZHpzb3BJSWQyQXNlcFpta2pjTStkZFBPUlgzcEJ0QVRvWUFp?=
 =?utf-8?B?OU9jT2ZnaTY0Q3JVaXJhRXVrKytkU1NWbUJlUVlsNFN2dHFGQmxzZ3JCVmlH?=
 =?utf-8?B?ZkVWOFZaQkx6NWEvYm9WSjAvRXJRV00rTW12SWJjMHdnSktoSUJSMEoxaEor?=
 =?utf-8?B?eWVBOWd0dDFZdEVWaHVaRnMva2lrSGo1VW9yN3Z4WVRQZFk4RjdralhTYlow?=
 =?utf-8?B?eTYyNDVSL2IvcTJRSVhyYTVCWUV1MkpoVzVsekc5ZkZGdUhSQnBaRVJwTk9o?=
 =?utf-8?B?TTBDbk1CaVhBWjNudUowQWIrMS9qR2hacDB2b3RZSjJUSTBJMXVVODl2d3hL?=
 =?utf-8?B?OVQwTzBWR1Qwakx1WjAyMjZKMFlHbXRsdWxyODV2OFV2SXFTSzZZMXlRRVM3?=
 =?utf-8?B?K3FseXR1T1N5Q0htaVVaUUVPS2diaVRUZFk4OU9qcnk1Y1NBZmVtNU1PQUt4?=
 =?utf-8?B?RnROb0JOUFpMVS9BYWNaZkRBMW94QktkWmNsYXpCQ21PTzI0eGtpVVAwNFBQ?=
 =?utf-8?B?dzB3VitRbkZhcko4dWVyNHg3WDcybmR2QWZia3E1NTUraWFTWkZkSnhFbTNz?=
 =?utf-8?B?VE92WjV3ZlBMeWlzMmlYb0ZWaTFtQWtmNzY0bUNTZ05zRUlEUm1NY1M1cEtD?=
 =?utf-8?B?c0V1RVpKS3RhWmRjOG81QnUwNUloOFg2RExXa0F5WDdxR1JyVWpBeTRrcFdh?=
 =?utf-8?B?ZFlRODArbGtyTS94REdwYk5XSmZSdk80cGNCODNGejhjUVVlakFvNG96dzU2?=
 =?utf-8?B?Z1dOVERkeGYxeGVqZWNnNXAxcjFNOHpLbVNHcFNRZU9MQnN4VytKdXRmS3pW?=
 =?utf-8?B?RW42MEswQW80eC9tWFppaEVXVXFORGFFejZFWUJjM050cWRISnN5UnRqcVV1?=
 =?utf-8?B?Ukt4eW52NUhwcmhBbDM2VjRWQThMelQ4OTMrak8zNGhrRVFQM2NWNmpPaWlO?=
 =?utf-8?B?N1VZTi9nKzV5TGNWUm5sZlF5SEZVWnd6V1R6dlVCNnFUb29LMWE2b1Z0ZWc2?=
 =?utf-8?B?MWQ5Vjlodm1sT1FjZFRjb1BXR3pBUURuWmpvaHc0bUJQalg0K1RncElEY2NO?=
 =?utf-8?B?WXZtSS8wdHpjaEQwQXVVYVNqTFU4dDBSNm9EaFV3UHNJMk95UHROYVVDR05a?=
 =?utf-8?B?ZDBNa25yMjdFeWlCL1Y0cXlUbXR6Z0YweWEvcElvMTdUdlhwU05hUT09?=
X-Exchange-RoutingPolicyChecked: VWHh+J0XVGpu7qHTPNXkM9GACE1L6FfzXL2ktfB8DDP+VlsNVqULEI1QzInWbys2NOeSuibyO9NJzn3EkSUHCHxmU+XJEJtvvCJb+4+H5scJ1r/xjhWxZYvzFJ1byRCU4nWXC9Lxl4uGASRzpUt1Cle1rAD3J5bGIbLZ+ZD42bpIv3QH8qXTTBIFcVUu26PpuZERIJbBPIhxV6tSB/L+n+NGYExEgDuxnfCG3QBryYVooItBvwC/ITTc8Vjt1NxnbL60QJcQA2PaJ2/mt9VK9fBm8sijuFyvQCJKYy/2qLn7eaX4XFNLTx2yR21oMGSuTsGE3BrvNGAlzKgSFWzjvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c7cfdc-ac49-4b51-92e6-08de9114b697
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 00:05:28.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgadfhLCJSS1rY1fn1oegjzd+GhSjmyN/oJCzoSV5hJgcUbmeGS/n4YMXYcqrubeMFDJRCaxy0WjqIzDCYdj4QvGFTAne4IrqyocXXB/JkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7616
X-OriginatorOrg: intel.com

--------------P6g9LxYWmozGQwdKLlmy9JFy
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/2026 4:07 PM, Sean Christopherson wrote:
> On Wed, Mar 25, 2026, Chang S. Bae wrote:
>> On 3/12/2026 10:47 AM, Sean Christopherson wrote:
>>> On Thu, Mar 12, 2026, Chang S. Bae wrote:
>>>>
>>>> However, that is sort of what-if scenarios at best. The host kernel still
>>>> manages EGPR context switching through XSAVE. Saving EGPRs into regs[] would
>>>> introduce an oddity to synchronize between two buffers: regs[] and
>>>> gfpu->fpstate, which looks like unnecessary complexity.
>>
>> No, this looks ugly.
> 
> Sorry, you lost me.  What looks ugly?

Oh, this is against my comment above. Keeping regs[] <-> guest fpstate 
in sync will be unnecessarily complex without clear usage (continues below).

>> If guest EGPR state is saved in vcpu->arch.regs[], the APX area there isn't
>> necessary:
>>
>> When the KVM API exposes state in XSAVE format, the frontend can handle this
>> separately. Alongside uABI <-> guest fpstate copy functions, new copy
>> functions may deal with the state between uABI <-> VCPU cache.
>>
>> Further, one could think of exclusion as such:
>>
>> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
>> index 76153dfb58c9..5404f9399eea 100644
>> --- a/arch/x86/kernel/fpu/xstate.c
>> +++ b/arch/x86/kernel/fpu/xstate.c
>> @@ -794,9 +794,10 @@ static u64 __init guest_default_mask(void)
>> {
>> 	/*
>> 	 * Exclude dynamic features, which require userspace opt-in even
>> -	 * for KVM guests.
>> +	 * for KVM guests, and APX as extended general-purpose register
>> +	 * states are saved in the KVM cache separately.
>> 	 */
>> -	return ~(u64)XFEATURE_MASK_USER_DYNAMIC;
>> +	return ~((u64)XFEATURE_MASK_USER_DYNAMIC | XFEATURE_MASK_APX);
>> }
>>
>> But this default bitmask feeds into the permission bits:
>>
>> 	fpu->guest_perm.__state_perm    = guest_default_cfg.features;
>> 	fpu->guest_perm.__state_size    = guest_default_cfg.size;
>>
>> This policy looks clear and sensible: permission is granted only if space is
>> reserved to save the state. If there is a strong desire to save memory, I
>> think it should go through a more thorough review to revisit this policy.
> 
> And I'm lost again.

Here I made myself pursuing the approach saving/restoring EGPRs via 
regs[] on VM entry/exit. Then a couple of follow-up questions:

   1. What about APX area in guest fpstate?
   2. How to support the state for KVM ABI?

It surely departs from the "XSAVE - the single source of truth" model. 
Then,

   Leave the APX area in guest fpstate unused.

   Copying APX state directly between regs[] and uABI to preserve XSAVE-
   based ABI like in the attached diff.

That's all I'm saying.
--------------P6g9LxYWmozGQwdKLlmy9JFy
Content-Type: text/plain; charset="UTF-8"; name="kvmapi-apx.diff"
Content-Disposition: attachment; filename="kvmapi-apx.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9jcHVpZC5jIGIvYXJjaC94ODYva3ZtL2NwdWlkLmMK
aW5kZXggZmZmYmYwODc5MzdkLi5iM2FiMmFjODI3ZTYgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2
bS9jcHVpZC5jCisrKyBiL2FyY2gveDg2L2t2bS9jcHVpZC5jCkBAIC01OSw2ICs1OSwxNiBAQCB2
b2lkIF9faW5pdCBrdm1faW5pdF94c3RhdGVfc2l6ZXModm9pZCkKIAl9CiB9CiAKK3UzMiB4c3Rh
dGVfc2l6ZSh1bnNpZ25lZCBpbnQgeGZlYXR1cmUpCit7CisJcmV0dXJuIHhzdGF0ZV9zaXplc1t4
ZmVhdHVyZV0uZWF4OworfQorCit1MzIgeHN0YXRlX29mZnNldCh1bnNpZ25lZCBpbnQgeGZlYXR1
cmUpCit7CisJcmV0dXJuIHhzdGF0ZV9zaXplc1t4ZmVhdHVyZV0uZWJ4OworfQorCiB1MzIgeHN0
YXRlX3JlcXVpcmVkX3NpemUodTY0IHhzdGF0ZV9idiwgYm9vbCBjb21wYWN0ZWQpCiB7CiAJdTMy
IHJldCA9IFhTQVZFX0hEUl9TSVpFICsgWFNBVkVfSERSX09GRlNFVDsKZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2t2bS9jcHVpZC5oIGIvYXJjaC94ODYva3ZtL2NwdWlkLmgKaW5kZXggMDM5YjhlNmY0
MGJhLi41YWNlOTlkZDE1MmIgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS9jcHVpZC5oCisrKyBi
L2FyY2gveDg2L2t2bS9jcHVpZC5oCkBAIC02NCw2ICs2NCw4IEBAIGJvb2wga3ZtX2NwdWlkKHN0
cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTMyICplYXgsIHUzMiAqZWJ4LAogCiB2b2lkIF9faW5pdCBr
dm1faW5pdF94c3RhdGVfc2l6ZXModm9pZCk7CiB1MzIgeHN0YXRlX3JlcXVpcmVkX3NpemUodTY0
IHhzdGF0ZV9idiwgYm9vbCBjb21wYWN0ZWQpOwordTMyIHhzdGF0ZV9zaXplKHVuc2lnbmVkIGlu
dCB4ZmVhdHVyZSk7Cit1MzIgeHN0YXRlX29mZnNldCh1bnNpZ25lZCBpbnQgeGZlYXR1cmUpOwog
CiBpbnQgY3B1aWRfcXVlcnlfbWF4cGh5YWRkcihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwogaW50
IGNwdWlkX3F1ZXJ5X21heGd1ZXN0cGh5YWRkcihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwpkaWZm
IC0tZ2l0IGEvYXJjaC94ODYva3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4Ni5jCmluZGV4IGMx
ZTFiMzAzMDc4Ni4uMWYwNjRhMzJiOGI3IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMK
KysrIGIvYXJjaC94ODYva3ZtL3g4Ni5jCkBAIC0xMDgsNiArMTA4LDEyIEBAIEVYUE9SVF9TWU1C
T0xfRk9SX0tWTV9JTlRFUk5BTChrdm1faG9zdCk7CiAjZGVmaW5lIGVtdWxfdG9fdmNwdShjdHh0
KSBcCiAJKChzdHJ1Y3Qga3ZtX3ZjcHUgKikoY3R4dCktPnZjcHUpCiAKKyNpZmRlZiBDT05GSUdf
S1ZNX0FQWAorI2RlZmluZSBWQ1BVX0VHUFJTX1BUUih2Y3B1KSAgICYodmNwdSktPmFyY2gucmVn
c1tWQ1BVX1JFR1NfUjE2XQorI2Vsc2UKKyNkZWZpbmUgVkNQVV9FR1BSU19QVFIodmNwdSkgICBO
VUxMCisjZW5kaWYKKwogLyogRUZFUiBkZWZhdWx0czoKICAqIC0gZW5hYmxlIHN5c2NhbGwgcGVy
IGRlZmF1bHQgYmVjYXVzZSBpdHMgZW11bGF0ZWQgYnkgS1ZNCiAgKiAtIGVuYWJsZSBMTUUgYW5k
IExNQSBwZXIgZGVmYXVsdCBvbiA2NCBiaXQgS1ZNCkBAIC01ODA0LDEwICs1ODEwLDMzIEBAIHN0
YXRpYyBpbnQga3ZtX3ZjcHVfaW9jdGxfeDg2X3NldF9kZWJ1Z3JlZ3Moc3RydWN0IGt2bV92Y3B1
ICp2Y3B1LAogCXJldHVybiAwOwogfQogCitzdGF0aWMgdm9pZCBrdm1fY29weV92Y3B1X3JlZ3Nf
dG9fdWFiaShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBrdm1feHNhdmUgKnVhYmlfeHNh
dmUpCit7CisJdW5pb24gZnByZWdzX3N0YXRlICp4c3RhdGUgPSAodW5pb24gZnByZWdzX3N0YXRl
ICopdWFiaV94c2F2ZS0+cmVnaW9uOworCXZvaWQgKnVhYmlfYXB4ID0gKHZvaWQqKXVhYmlfeHNh
dmUtPnJlZ2lvbiArIHhzdGF0ZV9vZmZzZXQoWEZFQVRVUkVfQVBYKTsKKwl2b2lkICp2Y3B1X2Vn
cHJzID0gVkNQVV9FR1BSU19QVFIodmNwdSk7CisKKwlpZiAoIXZjcHVfZWdwcnMpCisJCXJldHVy
bjsKIAotc3RhdGljIGludCBrdm1fdmNwdV9pb2N0bF94ODZfZ2V0X3hzYXZlMihzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsCi0JCQkJCSB1OCAqc3RhdGUsIHVuc2lnbmVkIGludCBzaXplKQorCW1lbWNw
eSh1YWJpX2FweCwgdmNwdV9lZ3BycywgeHN0YXRlX3NpemUoWEZFQVRVUkVfQVBYKSk7CisJeHN0
YXRlLT54c2F2ZS5oZWFkZXIueGZlYXR1cmVzIHw9IFhGRUFUVVJFX01BU0tfQVBYOworfQorCitz
dGF0aWMgdm9pZCBrdm1fY29weV91YWJpX3RvX3ZjcHVfcmVncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUsIHN0cnVjdCBrdm1feHNhdmUgKnVhYmlfeHNhdmUpCiB7CisJdW5pb24gZnByZWdzX3N0YXRl
ICp4c3RhdGUgPSAodW5pb24gZnByZWdzX3N0YXRlICopdWFiaV94c2F2ZS0+cmVnaW9uOworCXZv
aWQgKnVhYmlfYXB4ID0gKHZvaWQqKXVhYmlfeHNhdmUtPnJlZ2lvbiArIHhzdGF0ZV9vZmZzZXQo
WEZFQVRVUkVfQVBYKTsKKwl2b2lkICp2Y3B1X2VncHJzID0gVkNQVV9FR1BSU19QVFIodmNwdSk7
CisKKwlpZiAodmNwdV9lZ3BycyAmJiB4c3RhdGUtPnhzYXZlLmhlYWRlci54ZmVhdHVyZXMgJiBY
RkVBVFVSRV9NQVNLX0FQWCkKKwkJbWVtY3B5KHZjcHVfZWdwcnMsIHVhYmlfYXB4LCB4c3RhdGVf
c2l6ZShYRkVBVFVSRV9BUFgpKTsKK30KKworc3RhdGljIGludCBrdm1fdmNwdV9pb2N0bF94ODZf
Z2V0X3hzYXZlMihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBrdm1feHNhdmUgKmd1ZXN0
X3hzYXZlLAorCQkJCQkgdW5zaWduZWQgaW50IHNpemUpCit7CisKIAkvKgogCSAqIE9ubHkgY29w
eSBzdGF0ZSBmb3IgZmVhdHVyZXMgdGhhdCBhcmUgZW5hYmxlZCBmb3IgdGhlIGd1ZXN0LiAgVGhl
CiAJICogc3RhdGUgaXRzZWxmIGlzbid0IHByb2JsZW1hdGljLCBidXQgc2V0dGluZyBiaXRzIGlu
IHRoZSBoZWFkZXIgZm9yCkBAIC01ODI2LDE1ICs1ODU1LDIzIEBAIHN0YXRpYyBpbnQga3ZtX3Zj
cHVfaW9jdGxfeDg2X2dldF94c2F2ZTIoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAogCWlmIChmcHN0
YXRlX2lzX2NvbmZpZGVudGlhbCgmdmNwdS0+YXJjaC5ndWVzdF9mcHUpKQogCQlyZXR1cm4gdmNw
dS0+a3ZtLT5hcmNoLmhhc19wcm90ZWN0ZWRfc3RhdGUgPyAtRUlOVkFMIDogMDsKIAotCWZwdV9j
b3B5X2d1ZXN0X2Zwc3RhdGVfdG9fdWFiaSgmdmNwdS0+YXJjaC5ndWVzdF9mcHUsIHN0YXRlLCBz
aXplLAorCS8qCisJICogVGhlIGdlbmVyaWMgWFNBVkUgY29weSBmdW5jdGlvbiB6ZXJvcyBvdXQg
YXJlYXMgbm90IHByZXNlbnQgaW4KKwkgKiBndWVzdCBmcHN0YXRlLiBUaG9zZSBub3QgaW4gZnBz
dGF0ZSBidXQgaW4gc29tZXdoZXJlIGVsc2UsCisJICogbGlrZSBFR1BScywgc2hvdWxkIGJlIGNv
cGllZCBhZnRlciB0aGlzLgorCSAqLworCWZwdV9jb3B5X2d1ZXN0X2Zwc3RhdGVfdG9fdWFiaSgm
dmNwdS0+YXJjaC5ndWVzdF9mcHUsIGd1ZXN0X3hzYXZlLT5yZWdpb24sIHNpemUsCiAJCQkJICAg
ICAgIHN1cHBvcnRlZF94Y3IwLCB2Y3B1LT5hcmNoLnBrcnUpOworCisJa3ZtX2NvcHlfdmNwdV9y
ZWdzX3RvX3VhYmkodmNwdSwgZ3Vlc3RfeHNhdmUpOworCiAJcmV0dXJuIDA7CiB9CiAKIHN0YXRp
YyBpbnQga3ZtX3ZjcHVfaW9jdGxfeDg2X2dldF94c2F2ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUs
CiAJCQkJCXN0cnVjdCBrdm1feHNhdmUgKmd1ZXN0X3hzYXZlKQogewotCXJldHVybiBrdm1fdmNw
dV9pb2N0bF94ODZfZ2V0X3hzYXZlMih2Y3B1LCAodm9pZCAqKWd1ZXN0X3hzYXZlLT5yZWdpb24s
CisJcmV0dXJuIGt2bV92Y3B1X2lvY3RsX3g4Nl9nZXRfeHNhdmUyKHZjcHUsIGd1ZXN0X3hzYXZl
LAogCQkJCQkgICAgIHNpemVvZihndWVzdF94c2F2ZS0+cmVnaW9uKSk7CiB9CiAKQEAgLTU4NTMs
NiArNTg5MCw4IEBAIHN0YXRpYyBpbnQga3ZtX3ZjcHVfaW9jdGxfeDg2X3NldF94c2F2ZShzdHJ1
Y3Qga3ZtX3ZjcHUgKnZjcHUsCiAJICovCiAJeHN0YXRlLT54c2F2ZS5oZWFkZXIueGZlYXR1cmVz
ICY9IH52Y3B1LT5hcmNoLmd1ZXN0X2ZwdS5mcHN0YXRlLT54ZmQ7CiAKKwlrdm1fY29weV91YWJp
X3RvX3ZjcHVfcmVncyh2Y3B1LCBndWVzdF94c2F2ZSk7CisKIAlyZXR1cm4gZnB1X2NvcHlfdWFi
aV90b19ndWVzdF9mcHN0YXRlKCZ2Y3B1LT5hcmNoLmd1ZXN0X2ZwdSwKIAkJCQkJICAgICAgZ3Vl
c3RfeHNhdmUtPnJlZ2lvbiwKIAkJCQkJICAgICAga3ZtX2NhcHMuc3VwcG9ydGVkX3hjcjAsCkBA
IC02NDY0LDcgKzY1MDMsNyBAQCBsb25nIGt2bV9hcmNoX3ZjcHVfaW9jdGwoc3RydWN0IGZpbGUg
KmZpbHAsCiAJCWlmICghdS54c2F2ZSkKIAkJCWJyZWFrOwogCi0JCXIgPSBrdm1fdmNwdV9pb2N0
bF94ODZfZ2V0X3hzYXZlMih2Y3B1LCB1LmJ1ZmZlciwgc2l6ZSk7CisJCXIgPSBrdm1fdmNwdV9p
b2N0bF94ODZfZ2V0X3hzYXZlMih2Y3B1LCB1LnhzYXZlLCBzaXplKTsKIAkJaWYgKHIgPCAwKQog
CQkJYnJlYWs7CiAKLS0gCjIuNTEuMAoK

--------------P6g9LxYWmozGQwdKLlmy9JFy--
