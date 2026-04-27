Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053E30E829;
	Mon, 27 Apr 2026 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312304; cv=fail; b=di0OxpUZNbTpaAt+6DxMGDreD+i3N/chWKt2VUeQWQNa46BaImXh5YzONHceVyDnE2JqNUeWZDSYioqmzh5ANf6GldUs301O+Es87nx6C8PTTmIgon2X4kQNVexoBmBDGavsTfda1qwpJp2aqTjaHKg4KjtncKAh42M5dD10tUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312304; c=relaxed/simple;
	bh=NbgvKjADnkZw5IGfPdZktjVinNDxtfV8IJ1QNzQ1d/Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eUeQS1UFwa6hp+mYEGidTi+7Zkczocw6a5mFU8K/IEBddQ7xwaJpTAqTnwEl/4AJ75OU3y76SHHB/Ll7Jqgyk2PCkyI6nDnTuYd6jlOvJBnN+iaDeosCcqdVJ1QdBbsc3xAHHlbKt2Xg3QJey9dKb4Us8X64gTb7SFkTddlzB2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxMEuJEC; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxMEuJEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777312303; x=1808848303;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NbgvKjADnkZw5IGfPdZktjVinNDxtfV8IJ1QNzQ1d/Q=;
  b=WxMEuJEC9tD0cw92l9r7KIk6h6wB5C4bGWG7qD+tzwGZzBA7rKhjOA5f
   Ld7bKKqiDiWRZeB48ApwMOLXBv4qkEztwcOjAWUw9UBE8Wd1dXLpNiwFX
   izXBP3cR2KEXoSbBvWnXdGoAGC6sfXt+fHv4YaOXEgwvWqiw9aAXm6KNG
   BtGYxvlK3DL2BK0kAF+jHRrz5GoiVMMfXPcaWpenHuyM3HtudCJ2OfMLH
   PGHE5Z7svF5eNhBaELFs0glb1R4I+LFQZgWfle/6Wr6TgWlc4HmgqXi8S
   u50Zg4AKIusAHi8i09MzXeFY+5b7SoAY5eF9HaqOOa+DTtQwmMJFmVWtH
   w==;
X-CSE-ConnectionGUID: cLAugrbARhGkCwyoz4TAhQ==
X-CSE-MsgGUID: DKxNZW87QfKcHkfvIpB9ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88810667"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="88810667"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 10:51:42 -0700
X-CSE-ConnectionGUID: 6t+fgr8+Q8ydlNEq44zt3A==
X-CSE-MsgGUID: hrPLG0/CQvukIWgTLhIelg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="238689360"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 10:51:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 10:51:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 10:51:41 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 10:51:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZJE5eN1Ih8Pue/figKoi1sPtEru0PZRGbHMtQsb09YUjxk5u4ReVClflgt8aoYLMpQYsBWMa0fP56gl0Mb+JihC8Za0W4uUGxjz1sGWr3ONqJ/2jgn8rvR8iIXydHB4iS6UmzhHYJ2SYm576JpH42Fk7B6e/DaB5u6VX/HVrq8+1fCHhOoEMa3L5EM5gJM1KTgNxTP47O90oL44QzDTFYHanTHtiHu22O3p4NGy1b/PZ/JtHfRDSZB3hA6+L0ghPr33QtkDmJQYiAQXYT46TpW3kJiqjZ29/3+bXbJsc9PQtuJj2w5LNprVgpOWW6KnWjuPkC4va8PG11JD3HRuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKFJ0kYOTMB3OcYEnbOHiCVzJrVkx+zFlPvcfZDl8HU=;
 b=L4/XpbTMEwH//SZtQlJ82XvudmzjLth29Gi6RYRCmVgs0b3piT7NWbWbbdeSbtXReT0fLVkR41Cdj1euySsBR7q3VmmR0fAB8mpjYcOEB6V1zV+KZpCCU1RZS2Lz0/+jdCd32GVxsRFabuGJkhmJJV5NiG2KXrkl8oYWvhBPCIwf8ufd03BLfziTKaxMatc239KuAeGnjcVAnAZnKjY3FjR/BjggE91xcv4tQ9naE7ZXwBBCYxWOspmhgaIJkZvVvq9vsARz2qe2PNQO7YW0QLwE46vVd7h8XMzNQZE2+cf80jy1/utNqr6zk/D9DSP54VOtyLRN7LuMSX4MlZ9kXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH0PR11MB4984.namprd11.prod.outlook.com (2603:10b6:510:34::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.20; Mon, 27 Apr 2026 17:51:38 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 17:51:38 +0000
Message-ID: <35947596-538b-41d8-9be7-4eddffc4e1c3@intel.com>
Date: Mon, 27 Apr 2026 10:51:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] KVM: SVM: adopt the same VMX_RUN_* flags as VMX
To: Paolo Bonzini <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
CC: Binbin Wu <binbin.wu@linux.intel.com>, Uros Bizjak <ubizjak@gmail.com>,
	Sean Christopherson <seanjc@google.com>
References: <20260427105848.44865-1-pbonzini@redhat.com>
 <20260427105848.44865-5-pbonzini@redhat.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260427105848.44865-5-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:254::13) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH0PR11MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: 432d8ef2-9e61-45d8-c2d8-08dea485a187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FvUjeBydP5rKSgmVQocPBQSIq3pvXoBbAvMv+sIu64YJBpq6Tdabn69diWgBDWqLzEiHf3IOsAHAV0IqoI753U33Mq7v7+KVFhb0uBgY0YZM0F5HpLgqaSgZSSXRK3fF82Hc1oGeqZFwKLuDxND8unWCUoq3t237/5whQ2PPLBLz3IPQMbNmGJYKl4uuToQ1l1oPzgIL+Qbt9GS3sKfgtUc9ZdZ4R5sVMPRn8vzC4xmdCL250cFAFgboY0mNRBA/ahr5F8wXHPuCmv9HKlJUvbpng9q4TZ/qeMohIti1s87fP/1zyW5ztrxaNCjiBCiuUWjOH+3Zzy6qPO3C5b0B1t3Qr7LP+2HzTyzNNaWrm8CNM9XUQxJygN+EVcWl47wHi81vO7haqTqPNuS4vzSIyTCQ90k9MslVkpTk8PfIbObtcdV32YudenmvGJ/lyS5Y1dAnB6h4y+5Lfwf84eqJ/ULEL80n6tXjt36gtY9oGvKotDsIhZmUolOhauKKgrfwr8x61hE+9WtvN1/BY2sAQDQjWa9VDlPFmM6T66HFmCtThNFb3uDIPXYb+0UnAZEE5DfEAdiftPCAvKF4lubaYaKvPWY9DMxsqY36h8qjZJo3LKkCbPTYhnWQgVPh2uBGQ1DLRop6Y34+lhWc4Mx5eWB7SbWxAtGbqhhp+4QbKw+lUIUv5RIyH8gaXG/rcXkBAhYNRN8O4ZwYUPmcfpTMKHLpldDWE5RjLb4NgCt7pjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGJKTWFoK3pkb282ZjZoMzk1MHhtOVc2NHkrVm5nT3RJSkZ1QUkwem9TS1JJ?=
 =?utf-8?B?MzR2ZVVDWVJXbCtsVHhZaDF0akoxK0FvZXJIQU9pR21aT0o2RUxCVHUzVmpM?=
 =?utf-8?B?eUkyMzM0dzFWWjBVRi8vOXI0ZXF4VlZVYVp1ME42Q2lsY3c0TW94Y1diMFBV?=
 =?utf-8?B?akI3d29KNWcrdWdHeW5oVG5pTHhyYkxDcHZ0VlBjcHJUbkIvSlNRS1dxS1V1?=
 =?utf-8?B?Y0JoT1IwcmV4a2d0TjVnaUJSOC9iaDJyVE1MZE9uUEU4dFRPWU5oRzA2clhh?=
 =?utf-8?B?SUdyTkd3ek5kem9IQUFCSGdDa01JcnplVzZNczdQR0pZU1NEd2hkdDBVY25S?=
 =?utf-8?B?QWpEQ1ZWQURoMjJxdXVlL1hjdzhDMFBTS09CSzJjajhMNm14K3hPNzNqSmps?=
 =?utf-8?B?aVIyNjArV1FSbUZBQXU0WHJ2bm9MUGFpUFUydjd5eWNKWllKTGVOd3ZzQUJR?=
 =?utf-8?B?a2F3S3RESXNqdHBlWFVhVjIwNXd0MnRHaXFqaTJYMloxMk4vcUNFWTNUbk9X?=
 =?utf-8?B?TVRTVU9IdmNyN0tSOXUyaGJsaXBjMWJZdXZSb3hWSU1hOXJHUkpnQko4WGtI?=
 =?utf-8?B?MUlwNUJKS2UwbzVCL0Rrc0RHZEY3N1RiZTJUNDBjZHFiNStEY2swTzBQZUlu?=
 =?utf-8?B?ay9taHFBTHBqZEREOXNqT1pOV1JsVnJFSHlwZWNWUjh4NkE2NzNZWWk4Z2ha?=
 =?utf-8?B?MWwxVzl2OWdWdjdiMExNVDZ5WVpJQmUweU1hVnp6SFBYVTBNUHFMRUlab1RI?=
 =?utf-8?B?OTlEeFFuOHNRVG94LzBYY2xWUWZYaHh2SmhJc3pZRThxejFUU1VuTC8xbkRK?=
 =?utf-8?B?MExKQm1ZSkgxYWticS9NN3htWldKTzI3bjk1N1NJbzhBaVl6SWs1OEFQeVhM?=
 =?utf-8?B?UWpFMXhLa0lSNjN4cnoraVJWNkk2WTFQdlk0bEVBTytSdjMycXpRMXoyUWVT?=
 =?utf-8?B?NUVDWWh4V1FQelF6c1JKNmVXNXVBc3Z1WUpVSC9KWE1kR28xcnJyaDcvNEJK?=
 =?utf-8?B?R25sRzNLamxLS0Vra1NpOWJGRHNlTW9adUtVSm1YQzYrNlNJRVhUK3dVWjVt?=
 =?utf-8?B?VCs5UWJTNHBuelJQUEFLQlN5NVN0YlBEUW9wdW9JNEtsM0c4VXZEb1IxNVMy?=
 =?utf-8?B?cFpZM3gxNVJFdE83QUNOV2hmalJJTkxMbGkyK0ZkUXFWZ1JKcmJXMWRwTnFG?=
 =?utf-8?B?N1ozTjN6NHhNcC9wNXE4d0k4azRzSmVzclQ1RTAzWXp0d1dMTXBGSkVML0ZC?=
 =?utf-8?B?SUxFWWREejR6dGMvK25vRHRWZ2N4a3VkRWpQRWd2eXR4WmdMay9rczM5amxi?=
 =?utf-8?B?Q2lGTHVqVlBtejN5SUZqR2tuLyt4Mk1neDM0OFdiZGNxZFdmWDg1Ymh5WGZC?=
 =?utf-8?B?Y3hDRnZVNTloWExMZFJTUnc3b0JQdS9GcWhyMlY5RDViUE9vRnJJM09Ia2ps?=
 =?utf-8?B?QlRZZ0JBeThza0hHck5RMjNXMlZxTUJEUG1GQkN0RTkyRDY0TGxxUUtydGV2?=
 =?utf-8?B?V2Z0YWpZRno4SmlubHBoS1BRRzJITUpWd0U3bEh5LzZxR1dNRHBvR0wzWmNq?=
 =?utf-8?B?T3k3K1hScnA3SXVORVkrcmIvWTBnaU0rTVpiSkgxcHhnWTRDaWpSc1l1QXNB?=
 =?utf-8?B?ejVWZmZWR1M2UEtYQUNybnl2Z2JVc2xoRWhVMlZRVDRUcjlINGtJOGlEQU5r?=
 =?utf-8?B?RUQ0c3hzM2RwSU41OVpLZi8yNEVLWDh6YzVCOW9ROEtkS3hFUjNqVG42d1NG?=
 =?utf-8?B?L0lSVDArOXpqWVc5bHR6Q0V4TkU3TEFpUXZLd00vbnJEd2dOVVVTVjdFZCtv?=
 =?utf-8?B?ZkJVeU1pVlIrSE9SelhRMFlOM0puNTF6TGVlZ2M4VFhvN3BnL1hqVXhpdEFM?=
 =?utf-8?B?ZVM5dEMwcDJEK2dOQUR4cVd0WXlXaThDVzdnWjM1NklpclZJc0JYNTFCeFFk?=
 =?utf-8?B?eEo2bmJoU2ZKYnJXczdJcFB2bkhIakQrY1dPK1ZxKzFNYVhrLzFnVnNSdzNH?=
 =?utf-8?B?ZzBDV0NjMEdoOTlrdzQwWUtJdDg0T2hVcFlmZU15QzBRdEJQWi9DeEplM0d6?=
 =?utf-8?B?azArT09GSWo4TFF2djRqTUNvNU83MVp6QTBPdk5BaGFzZmFMSVZQSkttTjIy?=
 =?utf-8?B?ajFweTlkNE1SWlp1VkVLMytPdjVPaHNwY0JESzJaY2k4Ym5oRVB2czBEVThv?=
 =?utf-8?B?MmJPUVJRY2IxWG40SCtEM212WGlRdzJOTDZxS2c4d296NUdvR1gzNnJ0cVZp?=
 =?utf-8?B?bXhvNnlsbUZpK3MzRTEwbndpNEtTZU04WEZNOFlDVGhZN05aSXlnanpnbkFG?=
 =?utf-8?B?VytqcnN6VmM2c1pzVndNdk54Mm9SSEFtZWppbTBKcGpSOWJiVGlaZz09?=
X-Exchange-RoutingPolicyChecked: N2uW7FwPxjvQOMZXAv3rjWK21ndV6+pgZVPZSblkB7sKTO13ZNnrKOzzBrC8xNcEaKvCAJqgZwpln4Kma9+/n3nEPrlbzvRp8xvWXsqoJGNXCS2ihloNaPjb/MvZt1t3kj+KWUvc6uk3ymzc37Xx37/zz3QrkFJnEyzhF1Ja31zNjJXngarJE4Pwy1AyWWuhf+6TMAdiFLKKKCWv2wZYd+85k2Cp+yxY1RnEzt8UeWm0T+/48tMI/ggQ+G+lBhCLUHyG/SdC0zSXbZEoTnm0lfec+3JOLH/eI0SFd/vU3azF6C1es+hnx38UT84Avc3G1s3qjV/H8NDgzNTCUKkCoA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 432d8ef2-9e61-45d8-c2d8-08dea485a187
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 17:51:38.3377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42p94dJFjtz9iqOsgb9/Gd9+EA2FI/cXUCrHz4181L7ZQb/KTOSwRg8d6J6w8wVicWyqiJ5Jv4kdCm207GmxYkq57IKf0GVR74uCfhkuPe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4984
X-OriginatorOrg: intel.com

On 4/27/2026 3:58 AM, Paolo Bonzini wrote:
> 
> +	if (!msr_write_intercepted(svm, MSR_IA32_SPEC_CTRL))
> +		enter_flags |= KVM_ENTER_SAVE_SPEC_CTRL;
Unlike VMX code, SVM looks to want @vcpu
