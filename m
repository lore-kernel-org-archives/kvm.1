Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D333AA504;
	Wed, 29 Jul 2026 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354414; cv=fail; b=hms53VGNdD6m88R/NhBSPY9nUB5vRjlP5VyxinElEc9g45QXiNWexC30NvoHsaLfjhYlUdA706iZsErisu78CrZZJ+13TAuh+KtbHvd4NR9PHf9jM8LLn/pG2hk/TcelLDECB7FRXkAKvHKnP2F85NL64wsQgXXOEd/OcAUXo08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354414; c=relaxed/simple;
	bh=ch8HKktOtUAfnH1rTgillJIjapcjoGh7Rb/FI2Kjgc0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f28/iKyasevgLAFPR/BXbeI8fYV1rgpVBYsLAkIklNYRbBXXcRAMLcO2MFf9bzeJfUtCjjonJAFm9PlnTS6KzqTr946SB7KhlYdoQa76Peqk6IL9fAbQbKwluthYft+isWI02cnCpf3Fb6BEA8w+tAXwnfgKAvqooa9Ntjh8LVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEBj8cTM; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEBj8cTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354411; x=1816890411;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ch8HKktOtUAfnH1rTgillJIjapcjoGh7Rb/FI2Kjgc0=;
  b=TEBj8cTMf/3Rl5jY1AWDe2MOW8gcolwHsxeM1+UPilhJ6kbrnx1ql7Tt
   YlKYM2CW8m2zZAzeh46KJZdVF8BdIdrsSJUA/Fp7eVhxd/y2BXVw1HL+R
   E8s+UIKVpPyI7LxvOiIMTdkMlFRKf7/xmltQ20FJBWd1rxg1MHFMS5lIJ
   S+ot5EYD8VLXC+LtuKroyLWZ9Mb0U3t0r3HGQ49adges2GVt7ipGtzkDQ
   1RZaxnRLTIXGNqj/yJzfpOnyRgeisBV+W+cvsjkK/YD46hUVxwvTF4GCI
   729YCYSB2Czy+k/TxG0NAZ2A5lDAXXnx2BGx8I0Tytro0MHStAOGNfd33
   g==;
X-CSE-ConnectionGUID: 9fVwa+YoTyCXJBOzDD28Tw==
X-CSE-MsgGUID: ZDv5pEE7Su+w0JEp35QohA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97343856"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="97343856"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:46:48 -0700
X-CSE-ConnectionGUID: qYo75p43QFmIw3rP09rrZw==
X-CSE-MsgGUID: Oen1Ch8PQlOkoVvf9w42WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="260715332"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:46:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 12:46:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 12:46:48 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 12:46:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2V6YpXlHEazLfI4jN/Ez9q7utglEbR+BUGHv1kQXyZFKQ1GIInUYbhpZaJNtaS1lV7RbibZ/Iwou95Y9JwPv4Awp2WV9613tM7kQ2/lEvBa6KDrck+mEmTQxn87mkxOqe04v02+13BglEoS6iGzQ5Yr455cNq9V1/9KSyY6DCcnHJZILnkDiPRynGpuV0QFDwoOf8enaNhfHVmJqbndRtaYCk5/v/31rWyzzEE/U4w73sWbWot99GjXDIR22s37dViXY81ECOW0khxZIY4J6rpI4Ekq0ysB0xfs66K5WJo97XQDGK8XC4F/5txbcEG4cRWcsWLjFnbISwTULI9phA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZ+rqHq2ua8tktfEcbsCtsbm99EPXgaW2Pog30Bb/Kw=;
 b=p+F4LGwANy3C8K8l64rQVNey3jsTKQikNxWUp4NrHuwD8z+OPVnbeXEn4v1xpKvoADLt5LLn5Rb2oYirs8geuW4fNMPBGp6EJSyFWnWTEw7iVKnMxZkMY/nP8gDjgyW6gsh3Wbs10UmXDVvkeDqqOT4MpWdA7B/235fQsfDsg8F9lIMtQ+ggrrOQ0QjgCqNGncdHMsu11q0XL2elS3E2yTqyVfPOGWDlivt32qrQn66ES6K0uUpldKKLDtlTqqh+GDM5xbe2xRxGr++tYitvN4dH/imSN38NErqh8lK6n7pq+x1nnm1iRxdX2nofEtKdgDbkJOr0H0AjlpGD3ckmTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SA1PR11MB9683.namprd11.prod.outlook.com (2603:10b6:806:4df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Wed, 29 Jul
 2026 19:46:46 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 19:46:46 +0000
Message-ID: <e21fde7b-f765-41c1-8dc0-88cb1e1a418e@intel.com>
Date: Wed, 29 Jul 2026 12:46:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] KVM: x86: Enable APX for guests
To: Oliver Sang <oliver.sang@intel.com>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <amgJObo15jsluTtY@xsang-OptiPlex-9020>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <amgJObo15jsluTtY@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::10) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SA1PR11MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: 91643b2a-a5eb-4999-ca35-08deedaa1f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5XFBa2q9Q40AB2ex1/Z3jg+oJM7K+SUjIe690SinfMy70ELBptoHYM5iWCzafRMF91pTep7QYGWYSnxLQ48Z68GvkWc1KZMA2xUbIa5oUC0ShbvhLMIoV7dPXp+ZCoOoJC106FPstXuui9wey425K3veCLDxp0/uhrp4rs7q5ol+2gQFcpIYAhBTpBZ1aBaBzOxCeIu/ZLGhjPgSBLFCdDviYbJFc5Rpo8+W1h+fvbBFN0zOcmR+kKxn6l1TDB3Yc+aWDQN9JmGlu2cZzLDlrHTCLUYRCYFYP8Y+cAKa6hukXzxth8kO8aLcqxlTgie1uDY08LySSMOdQROos3I02sqeHPQXsqva3ezgNLLIF3+OrtvMHIlrcC6xFJTHJL986XmqeqLAKCqIjuX2vzdaPjxuVI7OERhVhP+mfM3xSNWtS7su6Yg6f3zvMW3fbMOGgi0f5vp8aoiGbhYvKwU2o5tHIFnMZsPoKMLoSLcbr66NCn+awP922oSSYdXsChq+N4WR7aN0sJLOai/A3YgCcDIqJfl/NqN5sO1SFeh0aM/ucjimQnlQSpENVFm3gAnrnHQeOg0Bton6fhjQZZmNzynetyvuBliOOy0UlDQBwoMnzvtIBMIyGSVKnGvaywCgnwhkMcXUY9vk6HxVoECwJ0bKgHrxoJ/f1g+bvzPq+eE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1B5OE9zY0V4eWpQd1dqMnhhVHZ5OG5MQmV0YmJZclhvS3RsOW1YM3pZSUxl?=
 =?utf-8?B?Z1JNSmQ1czFtYU11VDB6d3lJS1lCQ3V4TjJEdnFNOForMlJsYkJCWkFZU0hn?=
 =?utf-8?B?RXNLd3VUZHdkTEc0aFEvdTl3RGFvMG1vOGlnZVJKZlFac2p2akhzaFFBWUcw?=
 =?utf-8?B?OHZRVityTU8xZTFJOUs3RDMwaFpwWGRaSERBK2VqMGMrZHl6N3VnWi9DNW9a?=
 =?utf-8?B?dEVKSlZvcjVHSDVWdVhoWVBhVWlrVSs0VVlmNWdNOWJ0VC93eUVvWUwyL0Nh?=
 =?utf-8?B?NEo3aS9XYnREWG94VkhoZVRKTDlZSS81ZlZ0aVMrbDJPbkFNbDRFc3dVc0ww?=
 =?utf-8?B?RTZ1SU54Rzdtd0NQQzFXdXdXZmFLZnMzVVIyV3RpM2VOTTRuT3RxMEdWbTJs?=
 =?utf-8?B?VWp0RTFKVjJkYVdRNmdITWp1T0dJS2ZzY1lOTEtaREtDMEI1amUzVzNSWEU2?=
 =?utf-8?B?R1cxMUgyVjRLdXM0NTNoZHpNMTZmRHg0NnFXUzVqa3VCSTZTZzVYb1RlcXBt?=
 =?utf-8?B?Tld5aFUyemlHUGdqbTVSQlJqalNqb25uWXF2bmEyOFJxWDRwREJrVmpFSEZW?=
 =?utf-8?B?Um03YmNTVytia1FsYThlVDdTRC9YcWxCczQ1M0d0Q0RaRk8vN1pTL1ZtSkNP?=
 =?utf-8?B?aUlHZDRkNTJUaGNtcm40OGxnQ3BOSjdYZTZNdXpFb3lmK1Y4MlZkTDg5UFZE?=
 =?utf-8?B?c0REUG52alVYWW52ZmowaDVMb055aXFrbFRDbU9lRThOQ0dLVDlGU3YySkFY?=
 =?utf-8?B?NEhWK1pGK0pTbVVhamJvUFQ0UnZKMjdSY2daSWEzdk9FQ2xKTFhsaGZybWM0?=
 =?utf-8?B?VjRISGxCcFpqMk1wemdjMnFJYWRDbFZzeGZJcnBTbWg0aW40Zmc3c1IzbytN?=
 =?utf-8?B?TzJrWkdWa2k0SDZqS0t4Y0V4K2t2SVBJT1VzS3dyUTJBb3gwN0liQUx6YU1t?=
 =?utf-8?B?SkVpUGp5cmhCaVU0eUVWOG5DR0xtUVRBaGFvQWpvWFR2ejNZS0dEUFpLYWRJ?=
 =?utf-8?B?L3YzRTlBWHdBaUwzakdwSGhwNGFWdXpOVnNlNTdhTmYzR2JwK29XYkNSVEh3?=
 =?utf-8?B?R2hqdmtsUmRpbkNqTUd2RGhGOTBpeG9VbVR0Y2JsVkpZRU0xY0dHRWZWY2lQ?=
 =?utf-8?B?a3N6Z2VLSFRCUDhBTitORHE3a2h0SWlQZUlUeU0wL3NNWHlWQWdBdzlWRnRp?=
 =?utf-8?B?UE5qMWZRWnFEeStRSlQ4aGlrZXVVY3dLR1VWRHczVkduc3hVSkljcE5OVzRm?=
 =?utf-8?B?T1ZwcXFodGNQZmJJYnBFcGVNR0dWdmtiN0dDYXRlTEpoYnJwazdTa281RU45?=
 =?utf-8?B?WHBINlhrSTNrV1NkdWlLZlZ3OThHRld5S3I0R0d5REo3WHNFcEVzVkFRQkI0?=
 =?utf-8?B?ckJiUmhuWWgwRVpHWVk1RWxoRWYwSUtZaUNtVmw5NXZuZUdNTEEzZlZia0Nw?=
 =?utf-8?B?dmU5OVF2MHE4bk5nT0RCNnVkNWUvWXF3Qmx4VEFWYyt0OFpiV0dabHR0Q3Z0?=
 =?utf-8?B?ZEJERGZxQkhMV25IZDZ0bHExSVJOeitzeDc5VXZ4bW40RjJMQXE5N2FyZDNS?=
 =?utf-8?B?YmoyZ2pPYWZrTjY4U0pWY290VTZadkg1OGkzY2d2QkhnVHdyVWhrZXJtZk9E?=
 =?utf-8?B?RW90WW1MWmRLSFhXSyt1c0RoWE44YmpoZ1NSOFowZm5ZNkJId3BzNUx4UXlv?=
 =?utf-8?B?SkdPd1BaNjJGL2p4TTE5U055blAvVjk0Sm4zMVFmVFN6SHFOK0ZXemU0UVFY?=
 =?utf-8?B?U0ZudE1RZWpCVUozZzFjdng2amlWWTh5YVJiV3lzNlM1N2JvZW4yZmlWL0p4?=
 =?utf-8?B?WjU4WVZ4TG1DNkdDWnd0TlhycldPVUZ5SysvNW1QMUJqaFc1MFdCaGRTaGlx?=
 =?utf-8?B?ZXhnWGtnOWhGUWZTV0lleC83eTlMSDk5T1A1TkNWY3VCL0FrdG0xUmhYVTJx?=
 =?utf-8?B?RUNuUE9IVGhRWENwK3UrY2VsZkpZZytWMy8xVXJ1NkU5OGlNYmxEU05DVGZU?=
 =?utf-8?B?eEgvKy9mb2RJWEZEQnFkUWpZSC9hTHhBTzZLOUI1aFFsWXJOTTFxNTlqMmU5?=
 =?utf-8?B?NjhWVUhjSmFiSWhVVnNnNTNieSsxY2gvbmJQWlJINkpGWEQrTkpqaXZjYVF0?=
 =?utf-8?B?WnYzSWVxeW1xU2V0NHJueUJWck1tbUNsTUtyYkd6UVY1K3JxbStFSzV6NmJX?=
 =?utf-8?B?ZDIvSjFvdTJoaFZWeEVnc05ETHJ3TndjOHFTMjVpWndlN1ByWElCdHJhUi9u?=
 =?utf-8?B?MlNrdWNnZmJ0MUxaMGp5bXBqQ0hidmpGbm5IUUptQ0d4Rm0rL3BSTW1XMWpQ?=
 =?utf-8?B?TzB0bFhhSG1LTGRDU0dCRTIzNFZZaWwzcWU1Zk1VekJtOVZxaTdZUT09?=
X-Exchange-RoutingPolicyChecked: oGww1+/6Udum76OCoZnQKWNwAPb1S+hnorDmNFmwIFy1wusUteB/yRTkuOPAx0GiURTgiwvBwXAuF0iG0SHUACzIL62CKSAkOnocLY/1Q9nx66bD1q209X9YYH1Y1iAzMyBPNhGR85ajRTp9fpiAleXleMeC/nUfCGt47600hqpPG/yoekZd4RQl3NJEgJnQFuCdTyqSNmO4M93nYF5O9PjT2z4yf9O8hV2QqYmMfzmWffJUe4GDcQFbjgBJ0cwj3L8U7yZh1D/NTE3a7LV4mjxLCUIZvrllHbXY1iv1eASsxzGEMyuzrlUotbCjgXNW/OvVIXIgm89PmLNYs63QHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 91643b2a-a5eb-4999-ca35-08deedaa1f7b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 19:46:46.3600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bq8D1WfdYFYxHHaZzhg/wSoK8X+OTaWFClF20mi5qaAXzvNGfcvSiai+R62uFg/GakMZL/d/uJShpZzXocgNeIG+cDC6hpsqiUK9KZY140s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9683
X-OriginatorOrg: intel.com

On 7/27/2026 6:43 PM, Oliver Sang wrote:
> 
> for previous version, we captured a regression in ltp.kvm_vmx01 test, now we
> tested upon this version again and confirmed the test passes now. thanks!
> 
> Tested-by: kernel test robot <oliver.sang@intel.com>
Thanks!
