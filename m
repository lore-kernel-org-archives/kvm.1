Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C4B31352D;
	Wed,  8 Jul 2026 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481747; cv=fail; b=uBMLrqCNIjP62u5RMLFWn5BqT7FBGD1G8jmAuyYkATu05NQNV1bSWhkCq3GSgm9rbr8HGp4qwAFTeu4UFcF5stxyHOLSdcyD3detgPkpVNoDJM9k5U8dlFjqvwOz+SnXfJ79mggf/PkRqIQE+0XtCbSqr76Rq2n+bVqJqzWPcvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481747; c=relaxed/simple;
	bh=JV1SwMpUKoNRyWGLK2NUxVJTO1Tla9iSyaWu9d4S9Y8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hGewzMMbmMLOdHYXgvNCFIWBwyjOFMp+JnFD9pAfpCL3FRKx1Jk/2dgsZpbkeLfamB6Y/YI1BaH3FBxFT4mDnlSx0BAPPMSWj+r2IYQsOGrw81feOBer9DRWYEDvne9hPFRGlIWlG6wR/ALNeP4iOPLnH2dtnO9n+6+a3+ZjdGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUuYesMr; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUuYesMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783481744; x=1815017744;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JV1SwMpUKoNRyWGLK2NUxVJTO1Tla9iSyaWu9d4S9Y8=;
  b=AUuYesMromCQT9KotTZALpor29bA+0SDgGN5IkkE2xDM2R8iHpG2z6JH
   ovTsWLsRLjbITiwA1EmifzsMhMyyFdTXFbMBWnTBMpeFN0bJHQcXVleLu
   Ulws67ykLilLLKpC83DLnT8R9P7EW2XWn2BpMB7hWortmHyKcyMYnxhln
   QhhYjcidzQT2y37aD7JZYBYRpMSUOOSpbujEPTrqsaX2PSZKBUXtdNOGq
   bK+uT4FPkA0ALL+XwRdxrfxUzyth9SOQwtoqC+xM76bUW4MlhN/G3x1gF
   F5jpwkkD+b7X19S+JilHXhKuZlbkH548abKcNYQ/nj1oJilSgv+WQrGbd
   g==;
X-CSE-ConnectionGUID: mpau6E4MRX+4ifLILpbUgQ==
X-CSE-MsgGUID: 9GoY/n+xQ/yeFNViUPyj3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="109680859"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="109680859"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 20:35:43 -0700
X-CSE-ConnectionGUID: i6XdqEfBQcqe6t3LbiZYVw==
X-CSE-MsgGUID: lalIOJTkRpq5jVIvma9sJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="259077159"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 20:35:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 20:35:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 20:35:43 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 20:35:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DygwEbXSYUqwZq6LxwnnVvz3T9HuBH3WV3i5EebojYeDuU9c4je99aRyDjFnkhJlUXchzpYRF5TkEsl7FyIsw+UpC7vjGaLGhnl70xbsMvRIxm0P6fYPgm5EYCKaE/jTrKiAuTLdG5xBXHkwF3ygCz0LbvUJQCrjRxaT6IKGHkTJMsIJfWNvQ60/S27vMIPnRaRxyP3Z38hKzh4gdr9IrW92c9rbZjYTUL9C4hshiCw28TBnIMjt0uzJNYhiJlhjSmLE48NvqPVBgdU5Hp/+JCRHkOxylphAGkgbNbaMRMsPeYD+4npd7hutSk9nndS04gIqme98cxaG3jxSEDl7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOpet5GJvcffc6N/Q7Tn7mDV8a9gQ2kdaplfDW626ug=;
 b=Ko62mrmfwmKGaIIN372vkXrYm4EL18tbn6P3igFneMNbuvb+4foosTftVg/ze7G92BrgTnVgAT2iUFm6HXcul44mwm7ElouEri2z3dOwHeDZSo1cenDd/0w/Hxj3cWO9A+7NrqgUnfLEnTkMILgqASBeUnS4P2SBBozmx4BizDtnzc4FZ/aBzOEqvETMTqd71SHyq7Y/JwziqS1PWYu0PGjYmaFUJx7eCzykg2GZCWWggj/1A89qoL/S7m/z/DCOWXfOkaQc2TOdOUnithX6Xe4rcGBjiH0tEuTauryn0L48be/CIOUgGuH+VA0Tg2EYFm15H+uLwhiE8oBs5535ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CYXPR11MB8731.namprd11.prod.outlook.com (2603:10b6:930:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 03:35:33 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 03:35:32 +0000
Message-ID: <a058a3e9-711b-4034-b9a6-28444aef3b5a@intel.com>
Date: Tue, 7 Jul 2026 20:35:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-3-rick.p.edgecombe@intel.com>
 <efbff823-7b4e-4349-bdc4-72a244699d76@intel.com>
 <a724bce3e92e8a8dfb04798bc21860ba9be786d9.camel@intel.com>
 <818e0de368588836810718106e3b592323aaa0f1.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <818e0de368588836810718106e3b592323aaa0f1.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::6) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CYXPR11MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 9671931c-03f3-4110-413d-08dedca1f716
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|4143699003|11063799006|6133799003|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NUramc3Yc4vBRAVbyFf/vh6ecVKbqDWyT1spqVsbX9HpWr8LUKsnjZ+mt9XYV44XlrNqaf8Pq7R/WtuwwH72IhyxoZSkIczDLBby4q43ZhQFFUkGlxl6h4dKwiD3iaQKhBKbAAmZfovZkOmQvibGGPEtw1eOsOgCefYIDi6RUNtj1+P7nNRFXKrCv1ZTvSskMeIaKqRTsU8dNbB5LI2dusPCFNlt7c8+jgUjPM+Tgz/gWZXQDDc7TZR53lZoFltOtCEHolr6vIVWK3vYLxlh162XavsI45dv7EoV5FfO1h+cWLxzZO2tLDIEanyZrTGzuNC9OaNK89FvyIGEn1189JDVfKYlcvrETTHqgeYMeqOXQHINq4eHLFYsi0A/xVb8CRJqQ2UkL83/9fQraWg2pl5DsMz8XT2tYKG4Wdjx+K7gAjdu2U4eOfVqGSdUmSmHWxZWEjHplXq+qd8QduICAYPAPucqwjqzwsMt9jKDcnRLcV+WOKY7EbZKPIdFtik9KsdRI8C13HE8qWfy8hYJmMVCjK0QGfO1jkB/h/xcjUIpxVaBaY8RZBmkPEF2CbEzBo78lEiZm5B9fUXu9Xt4aUCsEpkyE3kYumlVegqL0tq3vOmYnv1q+RWKVva6BXB7v+xCN8VjHVcsBQ2VS0cUJLP+VojQfRVk+qY3dJ1HM+OfodwXdiYvMXtaH8we7oUkoRqZt67Q+Tsi+fSt8d8ZtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(4143699003)(11063799006)(6133799003)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUZGcEtCMGhNVTc4blRpVUE4ZjZXbFkyT2M3SWZReGNxTmwwVk5GSW1OWi9M?=
 =?utf-8?B?WWJyWHhNQTRIaDArS1FicGFvVmZaVGxEN2tBMHNFaWhrdkR2RlhDd2Y0RW5O?=
 =?utf-8?B?eXpLK3FreW1BNGlFZkV0Rmx5N2pRQUdEWUllaVhyQWlkd0dmZzRZTnNSZ0xa?=
 =?utf-8?B?NDdMUEdkNlZ1VXZ3dmRDV3dNeW0yZzZuRkgrQzN3TjNVUG1ESk44UUV6UTFx?=
 =?utf-8?B?SmhCQXVtSGtNaHhpbGlReHNpY1UwcEVxT2hQeUhPdUgyeEllSWlSdXdWcm14?=
 =?utf-8?B?WEtKcklxSTBZWUpNK3BBcXN4cWdNalBOSVVYRUlXTlF1NWNTUmRCRUwvbVc4?=
 =?utf-8?B?alUxSzYzUTdvei9VRGVGa0xXQ0dmeDh6cjY0UHZhSDlzUmMram96YzI0VmQv?=
 =?utf-8?B?SW1NaFZXMkl6bjd6ZmpuZndPNU1zTkhuU3BrK21lMDVZOG9jL0RxRHpmcWNG?=
 =?utf-8?B?MHlGdnRLWkRBcW9BUkNsM04xMmJzeXlLU044amh3TXpuV0loYS9zcjAyYjBC?=
 =?utf-8?B?RW1wbXVwbmhxSTV0ZmorSVBTUHl1NFdSTzQ4MTh5ZklCMnl3YkR5OW42dnZT?=
 =?utf-8?B?S1o4UU1TWk8xWG5aZ1k5c2E5MlFyekhra2o5RDc1bVg2ZE53WFRJLzdyMnJO?=
 =?utf-8?B?RG15Rkx4S0FhVHg5dkNCV3o3U3pxeXdqQVBmSHlHZUpEVi81aUtEZjRBS3Ry?=
 =?utf-8?B?RS9SUkt2c25hcmZRV3lVSEtqSVdBSTZvVGUwWnNpWVp1aHJnVGZUV0hBUEJL?=
 =?utf-8?B?b28yQitQVGZRUUQ0bi9mV1pGeFFJVzZ1MkV1R2p1TnNVbis1bm9OeC9CUVNt?=
 =?utf-8?B?emRlaXBvVlo4RGJBNTNoRlFsOEpZblNiMk93T1BzU3U1U2pyMmJBQ2lGYTRK?=
 =?utf-8?B?WkNtajZTcGVWSE14SHdtek5LenR0MG5HS1ZsZjMwU2hqeW91SUJ6RzFuM1Ba?=
 =?utf-8?B?ak1uNDd1RGRJdzVaVWR2b1RJQnlXR1NYaWE3akhPVkJqNk03K3dXLzJ1K3ZB?=
 =?utf-8?B?YkdodTBEemZ3dVdBUm14UVZISCtBT2R4MmRYMWRYZUo0T01RVlRabkhWTWZ3?=
 =?utf-8?B?cTQ1U3krZ0FselV4MER3VHIrWGw5TkNva29Zc2Q4MGFSdlZzSXphUXpIOWFj?=
 =?utf-8?B?NHlGTnY2TERYRlp3MVdac2dOTGtXMzhhZVN6U2wzVjJWc3R1ZHB1Wk5vVnRo?=
 =?utf-8?B?OVJBSGphWXZvQ29rZDZOOXlQaTNTUytuemt2d1NOV3VzbFAxUE5hc0cvbSs3?=
 =?utf-8?B?L0Q4TENOOU51ZWlhVTl1UkRyWm9USWp5dFozNXZnTXJzc05rWDB5SGRVREkw?=
 =?utf-8?B?R1ltdGFWSHpMaU5lRDF0ZTFSNll6YWpNV1g1MmxEMFlvd1VzN2l2YW1DVTNq?=
 =?utf-8?B?Y2VFSnljM2ZWV3FGL25lQlhha3dhcm9oMWlLam45ODJXVTlWQTZ6eFI0cVVS?=
 =?utf-8?B?ZlZqc2dDdjVCaFBUR2FBODg2b1BUZ3VGSGNIS2tYbExMeUVRMDdVMU1lUjhF?=
 =?utf-8?B?ZHJEZzNuV1BCODZQY2tyWFhmaitoL2dHSElBc1FHNEpUUjZ2cEE4aW1KVmF6?=
 =?utf-8?B?d2gxMGJhY0MrNERlTEJSSFVVMUlMY1dCOWM5WGcrMmxEMFI3V3VFd2hZenY2?=
 =?utf-8?B?SmdUWlkrZDliTVJnOFBjVWwrNVNESExtbFJCOWxVKzZwK0hNZWNsVjdxdStT?=
 =?utf-8?B?ZmUzMVJUcERHUFRvT1IvRmlWdmRQRm5qVnh0TFM5N3JSSDhCSTNndHlPd2tD?=
 =?utf-8?B?S2t1QkNGanFIczVqZHVEN0p0RW1wY01NdEo4akw0MzZ5SmkxQlU5VVRVNG41?=
 =?utf-8?B?TFNkQXdBa1pDVVNYcG5oMWN2KzlSQnJiWmE3U1hVRjEvY1ZuVEpVeXcyYXFk?=
 =?utf-8?B?SmdsR0U1a29qVTdmTTE2ZjR6dzNIdFVyY2s5T0pjTHFlaWtudTJYRFpWSTFC?=
 =?utf-8?B?ODk0VGhKZmxPMDY4ZThWbmcyVEtDcGhaekw5Z3kvNTViM05sTm1obG1qUzBi?=
 =?utf-8?B?QzZLWkhtRHR2MFdQUVFuR2FZU2w0OWtmSlh0VWFoY0dpZHlpTjlHL0R6K3ho?=
 =?utf-8?B?dlNIaU9iL3FsY1dDZ3RHZlk0WkptYllMR2YybnRJWm5IR05nc0tUNzVYVkJH?=
 =?utf-8?B?MmVnWHRnTWpRam1nNVFNNTYzYkVrZk1JV3BYd2JlKzlpOFBFSTdwL1FDalpB?=
 =?utf-8?B?KysyYUJ5SFBXZXczNUNOSHpXU3U3SmxGZTdDU1BMTUhDTWNEcHlaZWRsd3JS?=
 =?utf-8?B?MS83ZlFPU1Mra2I1ZEJSZUU2L3dGZ1pCTTJEUDduUC9xdUZ5RXlJSElEZm5y?=
 =?utf-8?B?OXYyODhkVDFtK241bGIxNDdaSkJkSGhqTlhjdVc3dCtTdXdxci9BUT09?=
X-Exchange-RoutingPolicyChecked: ACqtGXBjTUr9YrhGh7daO6YYwVCwib/MOiwSRQHZ9mVTws/7t5PSGhl6GUgVPU+tqE6Brebhq/+qPHIEEx959TTTsFlpo7hC8EqMsMgFY0lN8ljPfFH8KDZ/nyNc7LdGswlU4MqJ9Yuu5/MV8JgRSF4fkQ/P9/91x/bOVWmN/Al1+79bibUG7y/uh/i+t8+gJxroMRBp1T4xb0peIjw48Ycmy6xGv1TpLJ2IaWoBUjHdVdN+4ulRTaomsGgZ6bqM4dPuord7vhf1ldu3XXGrSCN7hUIEqlStB43DgcHwbHRVKX3HqOYdFLOIcZ3EKAW6HoDf7QMbdArO4rUpYVZ78A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9671931c-03f3-4110-413d-08dedca1f716
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 03:35:32.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBi4yoTizXrjqAGer89dUsUrse3n5XXLKw06v6ZXsY11dJjcd1d5TglqxbsD1atp3YjPjdjsFZH2/mawYSFp1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8731
X-OriginatorOrg: intel.com

On 7/7/2026 7:10 PM, Edgecombe, Rick P wrote:
> On Tue, 2026-07-07 at 19:07 -0700, Rick Edgecombe wrote:
>>> I think you can avoid the comment altogether in that case.
>>
>> I don't think it removes the need for a comment. The point is if
>> tdx_supports_dynamic_pamt() is not supported. The comment should be more about
>> "why", than what the code does, right?
>>
>> How about:
>>
>> 	if (ret)
>> 		return ret;
>>
>> 	/*
>> 	 * The kernel supports using TDX without Dynamic PAMT, so
>> 	 * avoid reporting failure if it's not supported.
>> 	 */
>> 	if (tdx_supports_dynamic_pamt(sysinfo))
>> 		ret = get_tdx_sys_info_tdmr_dpamt(&sysinfo->tdmr);
>>
>> 	return ret;
> 
> Actually this really stands out from the autogenerated code now, how about:
> 

I thought that's a good thing. Eventually, we want to make this file
conform to the standard kernel style, right? The autogenerated pattern
in this file to "check any previous failure" before doing the current
step is odd.


> 	/*
> 	 * The kernel supports using TDX without Dynamic PAMT, so
> 	 * avoid reporting failure if it's not supported.
> 	 */
> 	if (!ret && tdx_supports_dynamic_pamt(sysinfo))
> 		ret = get_tdx_sys_info_tdmr_dpamt(&sysinfo->tdmr);
> 
> It why-ifys the comment more, but only gently moves from the auto-generated
> patterns.

Sure, that's fine if you want to continue the style in this file.

BTW, do you also want to clarify why we fail the init if
get_tdx_sys_info_tdmr_dpamt() fails?

Is it because:

If reading the DPAMT metadata fails, something is really wrong with the
TDX module. It is better to fail the initialization in that case.
