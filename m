Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0866A4399D3
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757336; cv=fail; b=HGjOx3lSvO0qqufBDZildZa3MCoayi6MVYquqUqbMDw6rLqg7J6oyGdnTXIMFimf+vJtU3oitbpGzQNrwpALGAMV+Lke9yEcuRJq7FZHUxENO9tkG/hSCHS+I+/FWvaCq8eBIic1rEYDQnhDXhuQmbRNKXblNIYOI2OuvtcrnIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757336; c=relaxed/simple;
	bh=y5KkIoBnv7pLUF+M2qnHNC4rc3cLt+uZ4DKQxkBy6AA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SI7/ozcWyZntLeP7/U/Rv9Djagop/scSP3rFR9gH/cLlSLxcWUKQb6TTZ8pgHTPbHqvNNnkxHT9mjSLjU+eHTjsYfslsRh+9cxGUfb3thI+GKW0Jr4qlwmQaVAHOe7WO/th7jAvw0mbUE8CwxUb6t16U6liU2tYLklKr5AJWMNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQlpouzP; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQlpouzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784757335; x=1816293335;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y5KkIoBnv7pLUF+M2qnHNC4rc3cLt+uZ4DKQxkBy6AA=;
  b=cQlpouzP9dWo8EJYr6MBQto+g0HtbPBt+u62crtV7yLhadoVd2p4pvQR
   2eT68JFPndavQq9XiRJaOCtcMevC5NCqhe2x6ViEdAx4r+gEGezGF5WGs
   +ufUNPsrLy9E5BrkSxUMtgn0PHi456r83p/SWfevFlCAPPPp2zZmto61d
   gLBbI/JMsgoFEQffOS2rb4WrdHAWGVFVz2Ow938jISprkgfGA1SsuMeuj
   YqaleRqNDSrUus4YBC0xi0nSQo9y7IYsEo1AA9jx9X9ki50yI8hZvJkLP
   jFbRyNY2fMEum/Q8Q0pqOuwhLXvwyyFTVGW44yFYwNZdIYBhDbxDuna8W
   A==;
X-CSE-ConnectionGUID: 8rVMNsXARd2sJi+EXm3W0Q==
X-CSE-MsgGUID: 1+ot+as0RnaVYDECn5yqXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85167266"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="85167266"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:34 -0700
X-CSE-ConnectionGUID: QHTinrJWT+KcjKAEgGXkPw==
X-CSE-MsgGUID: OE5TQreTStmwXyUOJD3mFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="253852790"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 14:55:33 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gb3PKsYOF+k0xKwk+rGOXrC139xcKbrOdjUjCSxM/iqaDYO7XjIZCzPiHBLdLjZ2BURh8fICFDHgnkutpDQ97eK/4/K5d89AZA567thYNyDqjrjujDvTcIAnbHjlGj+JdUhku3mEWlvoxrch64R3f+tzkEXwdHq35mKEW6ngpLMhttGCBt+dnzjZdiXHsLNqNKELDzZLmHLj8ncFhZwQaSB9x+WGuk5e/hitO0A3wD8vf2bovTIOBURjsTlbPhuobO6G0CNnrkFGbfomQ4prOK9JqLWiLGkP8U1XsVIWcp6dlaYP7KUhnYEpjvMygiqpjq3VxbrdSEWAOzJOt5YJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHY5dvVn3SY3HL2FSq7UojIJyNnqTdLZbdje8t9Ce2M=;
 b=TCXYRUlGfRBVeGgrUb+7Nf0pNa9RiI1qp1rdUz9RPqNcn0+lNDr/ObNf9rQAS9ScyPVEKHJ0gno+oO0WDd80uHI8QSNjC83Gi9k6jVmS3hGCPePEz86NA5caMnl5DAx2fqyuAUGGSdfVulj8QPy3xtsdkT/+O4IBsxqMoeintGf9kYwFatWbaqa9R3+J9ztXeguy5P9XYOHLt4UGY8YfdADUoPB72UXKUmMiukBz3bl80YrexY++dDxxujE+Uyv6R6UY9awOcMclfQ1WxIfLt9nhTkPClnDKlMBnUMRML23yJ1SJeskizrYuR+bBwT6+I6FtE6RSDHphgr9XlMBWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 21:55:31 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 21:55:31 +0000
Message-ID: <b5f7be3c-5378-4245-ac72-b199c32696ea@intel.com>
Date: Wed, 22 Jul 2026 14:55:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/20] KVM: x86: Expose APX sub-features to userspace
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-19-chang.seok.bae@intel.com>
 <20260720181022.CB96F1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260720181022.CB96F1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DM6PR11MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: 17956bac-7a97-4650-fa85-08dee83bf32f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|3023799007|4143699003|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hD+rQlCsZepKJ+OZ1OPCBSkM2SIVOUH968w8tGYjlOHegk9Em3NIOVlMd3NP4w2fbD0OUTGkFBE8MExafyB2nbU1PJOaTYqydGe6zigZ8lyeBRjtVdDnK4jTq2q/u8tCFDEE5P4Y4kfEeCUAXjjXBQvqYPqnAp4G+GQLIFAWqEWncCt9huF/eOyqlV69CC4xdAhp/tsnpo7tUFfzaOq1g1e4b3B/92o972IkVfOnzkgEhuYhtyOD96SI22XigJngbhF9ONB7zYKsGFp+UcdYMDiZDdLtj00iquen33bQkDIc6ZP+vUyrl8L7L2qRaFH6+ucoiV8gFNOOB9ZHjmymguC6ouVv3i055zgFhVYIhnq5Aduuvd+xQh1aqgIZK8VTaHFTciHCu2gGW9+AdYte8a491nNZsrd0dF3YomIaguB1c2kCnO3i0cNEO5va6+pCH6hxImHyzOtYezUcYdyTgMuYreaeqIdR50m2tKygZeII0q81Qw7sl5yR/67mo0c5NoV7ePaOwNNmXrXcRP6P6pWKB2sbYZrcOCzyb7wTD3n83QoDIkcG3xIRIT0nnQKMbNGS1uotiOONtKdQBApXSP5PndXW7RiS8Hmr3Zg3BS24zsh4tgOcpGjfIi0bKf7NHle1HmTNMKbXu7r5VArWOuwhPouWNAJhJyJ6nihyjxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(3023799007)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlAyUEIzK25mZ3dIMkVCNmxRS25pUTVidFBvejJYaGJEb25FZTh2RkxIeWVD?=
 =?utf-8?B?czNCb0pQRUFiUjdHeXY5MG9KQzZCbDhGbnM2UzBQdU5QVXZ0N2thUWdvS3JB?=
 =?utf-8?B?QytBaW1WQTlZYVZPSGQrZ1RCUlVxL0loV0UzSzdZV0RmbjZIMjN4eERRQkRK?=
 =?utf-8?B?SGFJTmpDWVB2OXZXOENrY09SWFo4ZUEzQ0lKWHNoaGh6NDFrK3ZpazhBOExQ?=
 =?utf-8?B?NldmQStmd1Ixckk4SHZCSGNFelNRa01ZS3grY2pCQzNWMFBSYlBWa3JxN01z?=
 =?utf-8?B?T1JNSXgrUHJ2ejNUb3I3M1JFVWlpZzBEWEpzUzZPRDd6QUp6clRuNDlTY0NL?=
 =?utf-8?B?U25ybFp6Q2t1TGNHdlQ0ekxzRDhYcko2SER4UjJENzFOSXdIU3d6TUNyTXFz?=
 =?utf-8?B?OFBIKzh0UGIyMUU1dTd2emdQS2RIdk9xK1AwK1E4ZkZBQ2lDUkFQT2hVTUMr?=
 =?utf-8?B?OXVwc3pZVzZPcFBpcUpraWdtOVBqRU5heFRNNktvSnRyNzEyWFlrdm1zTVJo?=
 =?utf-8?B?UG1CYzVHZFRCaGMzQjAxS2F3ZFJJK3lJOXgwc2VyNzQ2NWFLNCtQVUFmaWIz?=
 =?utf-8?B?U2xQcGIxYVc0ZjFKZUg1eWJwcmNkT0xJK1J3ZjZvOElyZW5rTExmUEhzU3VK?=
 =?utf-8?B?ZFVybllPbjhaMExRbjZ2SlVJbmZWSTdSUjloRlV0enh4Ujc2bDVjcWNHaUkx?=
 =?utf-8?B?N3JBeklsbWRPeFM5RUNoMGt1WFQvTzdqMmhLTHM1RHFLbzcwN3FRUWNEcEd4?=
 =?utf-8?B?MkM1VDBoNlVNYnQ3dEFLc0NsYUZYWGdhWU9ScmVER3V0TWVwc2VUYlFSUk5l?=
 =?utf-8?B?UjU2RVBmM05WT1pQT2VLdkhITWRkRnh4TThkSGNQc2Y5Y0gremZxU2JJSUpx?=
 =?utf-8?B?bG9jUlNiOEpHb2F4NjBRTFJHY3lOSWs0OWVlQTdXendwTHJ1L29ONGdzK1ln?=
 =?utf-8?B?d0ZSblpSdzNYdUNQbmtQUmZxOXNnVE5ZNE5hRlQ1N1BnazZ5RVlVSW1ibDZv?=
 =?utf-8?B?ZU9DdFYvcXhuMnZhOXMyTkVDWEpxdHJlR1JnMndjck1oQzZKY2U1MDQ5dXUw?=
 =?utf-8?B?ZE5XRytDb2Q0dENDZHlHOUdOb1FneERFUnBML0czdndheG4wSXV6K1p6MlBJ?=
 =?utf-8?B?cE14dWhzc2NEYWFRQkdsRnZMYm1Zd0VpK3BLVEFVTjhPa2g3SGVxa1Q3RFF1?=
 =?utf-8?B?Q1FPR255ZDd1TSt4RHpzN3d6UXoyamtqaUtNZjdIcllrNFRMc3dwdnltU0VS?=
 =?utf-8?B?aUt4S2xjRFBlaDRubnR3MzUxRjRnZWg3VHQ3MUFTeG5Cd0VqMEdRUUZDdmhp?=
 =?utf-8?B?aWNXcmtnRmNCdjVGbFdTMzhSZDR4WWtPMzlrS08zVUh5cjErS0psamlrQVo0?=
 =?utf-8?B?Vk9Zcmczeno3Z0VBWEZqNi84NDJEcmNUVzY1OFRTQ25LV1lCaDQrTmc5ZGNL?=
 =?utf-8?B?MW9RQW90NmtqUE1KRGl6WDZnSzhyelc1cGh6djhXa3VZbXZTV3o4NHdhQ1RY?=
 =?utf-8?B?Y2VlVkdJejdpeDVPSXNmKzlZQUR3U2FhaVZGczFWdGEzYlFaejdiY0JtQkJ2?=
 =?utf-8?B?bnhwV1labGJjU09yMWJQKzZ5ZzBRaWRaSlJaRnpFUGorUUhGM0NkS21VTEl5?=
 =?utf-8?B?YlZ6dGZ4Q0NPZGYrYzcwWDNkUmt0Zk10TFFOWm1uMmZlZmFwU0RURmpGNXFU?=
 =?utf-8?B?NUk1a1Y5OFNWaTVwNm53Mmhhb0xsZ2h5OWF3dG9CTjBSVnFjN2t4YVRjeWJC?=
 =?utf-8?B?NVpLQVlDWThIaC84ZDhmbGtjZXU3dVp2MjNyT3JXNkhKcFRVeHUrakk0L1Q5?=
 =?utf-8?B?TUdNM2R4YXVOY3hmMENXa2JuNlpUdGNlbjFJWm9rRytUV25QeDFZRkdiUzlF?=
 =?utf-8?B?Y0w2R2p4QnYvZVpKNUVaT2V5NlM0RzR2MEtrYkV6eTFYdnZCUWoyTHl3YjRs?=
 =?utf-8?B?R25icythdW40ckJPZE5jZVdZRS9tSVY5bnVZVGFxZGRHNEJjSlQ2em4rSGY0?=
 =?utf-8?B?cWtLYkg0MTlJb0IvS1Z3eVhhT3ZTcVhQRWtsL0NWTjJQS0IwRWtnODdlYTZ0?=
 =?utf-8?B?UitUMTRPZlBwVFAxRVBnT3JCRUorc2dGSFl6NDE2RDlJeUpnZVE3bS8zK0g3?=
 =?utf-8?B?bFdncENDNVl3UmZreHpTUnF1QU1IbDFkQm04Q0t6TzRUNDZGMXFPYy9wMVcw?=
 =?utf-8?B?SEFpU2MyZDlOQlFCbXZFcDdIeXRrVEdGTkp3bTh1OHk5TEwzWlkvUDF3cXNG?=
 =?utf-8?B?Zlhnem9WY2Jnc3dWbWQrTHNvQitFNy9rY1lRdUpwWlVuQ2NGQW1ISU9udHN2?=
 =?utf-8?B?dGhhOC9QRy9YL1h5L0hDR3FNYlhzZ0F1WWljNTF6SEhVK25QR2V0Zz09?=
X-Exchange-RoutingPolicyChecked: id6sJBJ416AxwJ5oTv7RBsU+rEdvHdNHbS195BNrFe+rXnxxwQZNixNSu2AYSayS2CLqw9AQFqOj8Dg/CWJJDKfras9cISQz9MB0PB+FQlNxU6fOY1lk9ERmln9ZYsD58gjMYbOPptumoaeTOsA+LLhm3LMhrtfgXpxw+8B+hlIrafO88FOL1LFqrKlvIXJ2pHePDs7x3icYjyMtRN6eYaBd2MSzNPDR5O+JZYDDj1hAgmOKn65CU4P86LUJ/cH6/faSxY9QD+ytprf9yTjkk4cDvUaLxpbpX1t4Dl0sDS0iT50MTg3ULGQBmK+SP3dRc/eRsLCDcRaz6lyN9aWWMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 17956bac-7a97-4650-fa85-08dee83bf32f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 21:55:31.5308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARebXhZRLWJpww5/2G7JM+5AxeNstR9w0m0SyfxJYWPsEy4C2Pz0oJUlxU8Vlzjv9kXF2miJPGU54OrsKhKnJ0dzufrN9jCNuY+VQtYiKjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com

On 7/20/2026 11:10 AM, sashiko-bot@kernel.org wrote:
>>   	/* APX sub-features */
>>   	case 0x29:
>> -		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
>> +		if (!kvm_cpu_cap_has(X86_FEATURE_APX))
>> +			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
>>   		break;
> 
> [Severity: High]
> If kvm_cpu_cap_has(X86_FEATURE_APX) is true, does this bypass capability
> filtering and expose raw host CPUID values for leaf 0x29?
> 
> Looking at other leaves in __do_cpuid_func(), they typically use
> cpuid_entry_override() or manually clear unused registers to apply the KVM
> masks. Without this masking, it appears a userspace VMM querying
> KVM_GET_SUPPORTED_CPUID for leaf 0x29 will receive unvirtualized hardware
> features, which could then leak into the guest.

Without -mapxf (or -march=native on APX machines [*]), the compiler 
shouldn't have no EGPRs in the optimization options I think.

[*] the fix is work-in-progress right now

> [Severity: Medium]
> Does cpuid_function_is_indexed() in arch/x86/include/asm/cpuid/api.h also
> need to be updated to include 0x29?
Commented on patch17

Thanks,
Chang
