Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ACB3A63FB;
	Wed,  8 Jul 2026 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783471759; cv=fail; b=ogmuROIB45WO/4A5wzpc86nWHqa0ki318ZwRpwmpZeEuNPXVep/Vakxa+soyYA6rR1s/1P1vCBPRCRHCzr0Pky6xgY4ztt1SGV1SsdtqDgumR5ZBCy89jWovTCxyLxclTXrMeAVu9cNcycq4EGLqMCeO+/UqSAghJ0CglwqH3ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783471759; c=relaxed/simple;
	bh=6clZxCw5ORwYUuL+NIOj8Tmsqg98j5zZ5PVM9dpwgl4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a214BVTd0BuDiyz0YgVPCrXOfUOiFGJCYZF06TWu7653A/kBwI4zGQkbMZhgCLaiRBvAIWTZt3bgVbCvpV20d6Mi2y/MVv5+gYSQKPxXb5R/ghETAr9KVME7dVv3VrPraqebQzjuWnJz2isOmpSTV8uh832VqjHiYWtl9jJul4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jw53GMDk; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jw53GMDk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783471756; x=1815007756;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6clZxCw5ORwYUuL+NIOj8Tmsqg98j5zZ5PVM9dpwgl4=;
  b=jw53GMDkazQH5u4qIZUR4BQ9s523ETwhIPfFyyyaT/TMp6fpN0ojcXN2
   Ax2zki5vPE8hLPzxIP4lbvq9ylIynxkrzhXMvlFVeLZc5yMcxuHE4gBe7
   HAwWqZapbH1tGiD0NQlyA/u8heTdr+1ufyY/Gq7QBhNSojbcMiZNAdtNg
   jEaNKVzoxwYqjdYlW+KkpxSc6sX+UAEwDPUM/flbA56EKZiso2T8u293e
   ZqgvwiATVt0PV6KnlanMMgD69QDEQnW9mQTO6UKkxHdgdZQ477Ey1eJo9
   Gj9OqIF7gc7mKIXY67z6FSFL7ltxuqsC+fLCRV84KHrV5+6UySk80ieic
   A==;
X-CSE-ConnectionGUID: mCBMmLM6RYyzOrucr4gp0Q==
X-CSE-MsgGUID: SmeSUnUgSXOR6Z7J3ZuPtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="101678952"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="101678952"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 17:49:16 -0700
X-CSE-ConnectionGUID: 56ZfArubQA6gWa+bt0Vhcw==
X-CSE-MsgGUID: gzOoxB6xTKuXmQTwpb+JGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="257728097"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 17:49:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 17:49:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 17:49:14 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 17:49:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWi71iULMXEVi3SOhxRW7q/gI0E35GGw6zr+gevZbekAqnuQRGlsEoPW8oDRGLwQVavzfpJpJAfRT8zKCXpKC/mD+mK+8j0SAAsreVQ+9sxDW4XqJZQyozLyIz/11aPL6ynoiVqeHJT4Dlf+CAhvfRgVGBuIDLGHvoPPRBMftoDpqPqMlCFUGA8PRS49LEVc6giVXaJ8aglg/mmLkNGLgqPAS5UfyYuYGI0+o+TG3i5mum6H50xNx1slIbBs3VX0r7qI1/+lUZa4Wvv0PdxZOb6bc+T7+i8RldjU7k8ZQLIQpUXK3OZBgpM4j/eNJrPjOoOeLEGKgNB6QIh8x6ZfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NH+wbQN7JvSQ+TTmvb+8pJrmS2OcdjHtlRk/IRdUTkY=;
 b=Icc7SieYzrXGfLKC3v2WUb8drDAvopwxttYZnoDhUZPuhF0ongNEMzW+2edaW63FA7cU8lOUV/ISu7fiTtx2wH7sTX0pleKELBTArpWRymuPM8LR8lM2Alht2/gm1X1Sbn2bl8ZaivO6CJmWWT8YfheYI6WG8c+0LSct1wPpV3kM8wrrK6VMUDmvUp50pA9uivDOgAi+oZv+8RmNpS0HOiKdYRPukmf6HxBVvw+HZ1yefiDf6mcwqgeuCPxjdSu5soXOYsVgA8bTI7y+zMm3g1i0FwL0r+Xh4z/6BU97zhjSiCX8lvgXhd6h6/nLGufUDtRwuWglcYx8ZC7l7CM53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SJ0PR11MB8295.namprd11.prod.outlook.com (2603:10b6:a03:479::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 8 Jul 2026
 00:49:07 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 00:49:06 +0000
Message-ID: <efbff823-7b4e-4349-bdc4-72a244699d76@intel.com>
Date: Tue, 7 Jul 2026 17:49:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Content-Language: en-US
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, <bp@alien8.de>,
	<dave.hansen@intel.com>, <hpa@zytor.com>, <kas@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <chao.gao@intel.com>, <yan.y.zhao@intel.com>,
	<kai.huang@intel.com>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-3-rick.p.edgecombe@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260526023515.288829-3-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SJ0PR11MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 198c6b82-9e16-4043-237b-08dedc8ab69a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|921020|56012099006|4143699003|11063799006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: A7jSTXDAmcy2RsPAnaBwobdWhxd3UzWtqeTLbRFRN/k9W8KVUD9e6eXby0+JYot67Q+wmfLuBuLU/SbyWu/36ifEgXpu8AXK/MhRKNUUs1zUMj5QLme68cIAiAASTV71TyUZ8xGyX6H1WDdaZmBenMBpdHCMhyM955DNDpn+6fCgVYFZDkq0h7zCl/quWyt73elarzOjBO+aZaeMq7Zvg9GGCjFLLy85E7bq2WyJxZTxcGRG68pFWEr0q9FqGyv6un50a434ar3LLdKY09hORQRPGs/JOLahqIL2Jw8Qtgc4yo9RNMrEkIP0e/G5YqThC5A/HfJ9cJkOU+MR6tUVN3kwdzTI9Y1HoAiRcRSS12YPXE8ZqgmwuM/skR0TmrRkSuQM2hUZSwU5GS8e/EgUSYuu/SL6srph++cq8TUs8Dk5hQe7UP86rm6LYiy4B4lwk1lD9byFYaUKBzty54475d6cDaYtjgQTzJzGNG3HgcmSnkwRb25xzHS4lRISvotMvkmd6OvQgr5VfoJM22DvY6Wd7AnYhspFQbYpGfc5W/IQA9rb7v5P5nBpmB9RcSLdzeq3n1a6XtrKDzJkylyp9OuaGH/Q/fAsZx6PUXEFNpiLnyLYIeJdRFxCzK9JrSnt4T9H9GXDJaT1oQNsIxPg+JkmBfL+R3I4e0ARdQyYfjrzDvpysDmNK8IKGkRo4PAclFjhawpNZFt01LfPDsxRPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(56012099006)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhxenc1UDVIZjI3cVpkaE1aWXFESzBOa0VUK1FBeUYxVG5taTRWNXFpTVB4?=
 =?utf-8?B?OWtNTTdHaVhvQk9qdDBHYXJhNkw3Wkhqb3ZnaWFKY0tKLy9PaVBuWlhvYVpJ?=
 =?utf-8?B?R0p6NU9oOTlKOUdqeVIyK2w0U0NpaGNpTTgyR2RYOGgzRjNWaUpHOHBlUFdT?=
 =?utf-8?B?U2lSdEwxZFUxOFpnZWpFTU1COTVhcktRS1FQSWc2RjREVHFIdzREMXNjNE1S?=
 =?utf-8?B?Q2haSTB5MEd3bWI4QzF1QTNCbThwb1MvT05CeXNGWUx0WU5lM0haVFR6UUVv?=
 =?utf-8?B?UmdWVlZiSVRkdXB1bzQ1djZiekJhaE13eUpFcHJSZEV3VTZBT1ZrS3cwaXh4?=
 =?utf-8?B?OW9ZZGVDSFBpY1hrOTlvSXBVQkYwSE94UC96RTdzb1hnaVhGbUo1MmJoN3hP?=
 =?utf-8?B?MWxVZFRlTlR6dndQcXBqU2hvY1JDMVlRTHFGaytVbnpiZHgvcURVc1h2MXRN?=
 =?utf-8?B?TlFiNzRhRlcydi9PdjFwTUg4eUZscEpLVEx5L2JGOW1jWVg2c1ZzTHVtb0VZ?=
 =?utf-8?B?UmdBOWpqUk84R3dQaDdOODlQY3hRYUc1OEJzdnpFRnNVU3E1VWdscDE5YThG?=
 =?utf-8?B?a1RhZmM1NEJSaEtIY1RscXY2YXgxYktmNXNiSTdxa1pHR0xMeHJQZERURFR0?=
 =?utf-8?B?cXpjY242L1hkV3RxV0ZZaEJhcXliSVptUVE5N0h0KzE4L3JiNzdBSE9yOXBN?=
 =?utf-8?B?cWNUdWladExxSXlBK052dGtMQ0ZNc2FIN2c1Yk9RTjFnc3VtL21VamdkN1Bz?=
 =?utf-8?B?RWE3MnVGaE5UQU8wTXhEQnV6REdHeGZqaXUvWVR2TWtJcTI4WDF3MDdOMU15?=
 =?utf-8?B?UVh4TFBvU09GU1kwbnREejRDODdST21SVVJKNlA4NW80YzJyd1p4V2U3SWV0?=
 =?utf-8?B?anhLYlcrQTF4R045MXdQeVhydnNlQWMzZEFTdU9RQTdiVnlvOEFJUDdDZTBw?=
 =?utf-8?B?aEwxWlJJQ0x1d3gvemQySXkreENrdkRuWENiaHM1b1dTeDF4RWRlcnJrSXY0?=
 =?utf-8?B?Q011NzhBMG16SnNZUzh3R1J6ZzlUYVN5OVgzOWtIU2tFTU9pbC8ySDJKN2Y5?=
 =?utf-8?B?YkFYeXoyb0wwZXdSbGE5akd0bm9HYXVmdERIc0hkZ2dCVTRoeUo0UFpETkkw?=
 =?utf-8?B?Q0k5eGIvZEtoNEhQTnpkWHRkTElqdlhIRUM1cmpSUkdOMk5CTTlFRzdNekhv?=
 =?utf-8?B?UTFoN2p3aFlZOXJiMGp5SlVNOUkvSTBOc2JnVEpPbHJjK3RnRmJNcFFPTUR0?=
 =?utf-8?B?VjZLU3VueHlJWjJWWVB5YkpoQVhvSm52L1cwVmZTVDlPR0U1VTNidFFHUUc2?=
 =?utf-8?B?M2tQczRmSTI5UTFGWkR6QTlLSUlTcGhsWnZIYnF1SGs2ZTh3Tm45alYrNVhh?=
 =?utf-8?B?dWNIbUdUcHljcTl1NFpyalhjNW5XZHNtMW40OUdyTVE2aElFaDNnQ0lIWWZw?=
 =?utf-8?B?dnF1am1Pbi9zMjBJRFc5RlZMNVI5bi9iOWJDMU50UzBOTU1Dbmg1VWNDalYv?=
 =?utf-8?B?cE5iMGNjb2kvbjBDdzFUOEVsZVpRdHV5TEg5bEsxWXQ0ZENsdHMwK3ovLzZj?=
 =?utf-8?B?R2RqR2NhaTVhQ3Vvb2JkalllZ3FLMjBVWklzamttSndQRyttZ0xNTStnM01o?=
 =?utf-8?B?aXBtdDRHbDAwcFdUT2xwaTA0Z25VWTNXek1KdGdnNEpvZmNnaEN2QUdEOUZ5?=
 =?utf-8?B?ZFUrNDFka3RxVS9LTm9QaUx5K1NISHlTdVcrWE92U1N4d3dBSWgvUHlGU01o?=
 =?utf-8?B?V3R1UDQ1VkU2U2UvVmlQVzNoM1FLOVN0VEdzdWc5WGpDck1mVUR4ZEV3bFAz?=
 =?utf-8?B?MjU4em9kRHQ0emtmczJiL0drK0VXZ3pCcVR3OVFDdFJ5T1A4Z2JqT0RhQ0FQ?=
 =?utf-8?B?NC83Q3F6bnY0ZVJNZ0s4cDJPekRCSmw1azR5bEZZM0FWdXBCUm5HbGNBNXhR?=
 =?utf-8?B?bU4vMndvbUo2N01LM3FNUjIxNjh0Q09NVnpiK01OMWF3TzRPcVB5ZFRpVGJE?=
 =?utf-8?B?VlZvRndUWFVoVjRhL0lXQWRJcXEzVllqbGpIQjAzcHQ4dWl0YUZhempsY05V?=
 =?utf-8?B?ZnZ5WGtHU2QxVmc5TkJIeGRXU2NNWjBvWERhWkVNKzdlQ0RucHVNL1IxeG9w?=
 =?utf-8?B?SG1vZVF0TFlpUDlJTVExMzIvV3pqZGhnTER2Q09XelBua1lJMjUwTVIxTWZp?=
 =?utf-8?B?MzAyMGpSMmFLT2xmaHJZVVNmMllSR2tVT09vRE1haTFYeDNQVTMweGhsNWhZ?=
 =?utf-8?B?UCtmMDE2cW5aT01KUlh1WG9YZjVjdmovRGRwVEtDSHdaQURCR1ByUjl5d0ZC?=
 =?utf-8?B?RWRpRUtWRGtYREJaQSswY2JQSjliZVROTWIyM3BwbklpK243aVZGdz09?=
X-Exchange-RoutingPolicyChecked: nvVzk3+Ndkzl4j2x4ABN1YJC0hNha1B3VQSnhNszooTIpEiXefaRrL++5b7M7F0vcop7bfnE06zkEOg1jVkVR9NN094r2gDcVIk22HCZJuSxrTWntnxmkkdPFLrOikMz1e3oxHJeITb76Ctd2qNGI6AJWZVBsJBnLgw1VXapqlIq1f1+4lormHarrkBArM6qH+t3oQCre7sKqY2If2DYHvlIPhwCfPBkuG3sFarCXuC8uZXUPxUgm/XuUjuIIzRIgyZorqpXPYYgKuLjOCWDvNyW/rb3H4t1Qxslaw4trx8r2TJA5M1CaVk73YzEMHpVpO7PXDuNvJJvFWNJRMQPHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 198c6b82-9e16-4043-237b-08dedc8ab69a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 00:49:06.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+5QHI+Ye6uBgvlkDJ11MVf3WJm1RtWxhdsX9Z8qN6UWJlfQaKZ/8Ad/yV2iRDNmgkwY7324u26rg7mAPZT+HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8295
X-OriginatorOrg: intel.com

On 5/25/2026 7:35 PM, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> The TDX Physical Address Metadata Table (PAMT) holds data about the
> physical memory used by TDX, and must be allocated by the kernel during
> TDX module initialization.
> 
> The exact size of the required PAMT memory is determined by the TDX module
> and may vary between TDX module versions. Currently it is approximately
> 0.4% of the system memory. This is a significant commitment, especially if
> it is not known upfront whether the machine will run any TDX guests.
> 
> Each memory region that the TDX module might use needs three separate PAMT
> allocations. One for each supported page size (1GB, 2MB, 4KB). The
> TDX module supports a new feature designed to reduce PAMT overhead called
> Dynamic PAMT. At a high level, Dynamic PAMT still has the 1GB and 2MB
> levels allocated on TDX module initialization, but the 4KB level is
> allocated dynamically during runtime.

The last statement is slightly confusing to me. Is it trying to say that
the "dynamic" part is only applicable to 4KB allocations?


> 
> However, in the details, Dynamic PAMT still needs some smaller per 4KB
> page scoped data (currently it is 1 bit per page). The TDX module exposes
> the number of bits as a separate piece of metadata than the 4KB static
> allocation for regular PAMT. Although the size is enumerated differently,
> it is handed to the TDX module in the same way the 4KB page size PAMT
> allocation is for regular, non-dynamic PAMT.
> 
> Begin to implement Dynamic PAMT in the kernel by reading the bits-per-page
> needed for Dynamic PAMT. Calculate the size needed for the bitmap,
> and use it instead of the 4KB size determined for normal PAMT, in the case
> of Dynamic PAMT.
> 
> Unlike the existing metadata reading code, this code is not generated by a
> script. 


It might be useful to say that this file was auto-generated in the past
but going forward it is going to be manually updated.

> So adjust the comment to be more generic. Also, start to adopt a
> more normal kernel code style without the tenary statements and if

s/a more/
s/tenary/ternary


> conditionals assignments that the auto generated code has.
> 
> Assisted-by: Sashiko:claude-opus-4-6
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

The review tags goes after the SOBs.

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---

> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 503f9a3f46d61..82dc27aecf297 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -149,6 +149,11 @@ static __always_inline u64 sc_retry(sc_func_t func, u64 fn,
>  const char *tdx_dump_mce_info(struct mce *m);
>  const struct tdx_sys_info *tdx_get_sysinfo(void);
>  
> +static inline bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
> +{
> +	return false; /* To be enabled when kernel is ready */

I would avoid the tail comment even if it is temporary.

> +}
> +
>  int tdx_guest_keyid_alloc(void);
>  u32 tdx_get_nr_guest_keyids(void);
>  void tdx_guest_keyid_free(unsigned int keyid);



> @@ -33,6 +33,18 @@ static __init int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinf
>  	return ret;
>  }
>  
> +static __init int get_tdx_sys_info_tdmr_dpamt(struct tdx_sys_info_tdmr *sysinfo_tdmr)
> +{
> +	int ret;
> +	u64 val;
> +
> +	ret = read_sys_metadata_field(0x9100000100000013, &val);

Should this be a #define now that the file is being manually updated? Or
is the plan to do it all together? A #define would make it easier to
read this patch.

> +	if (!ret)
> +		sysinfo_tdmr->pamt_page_bitmap_entry_bits = val;
> +
> +	return ret;
> +}
> +
>  static __init int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
>  {
>  	int ret = 0;
> @@ -116,5 +128,12 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>  	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
>  	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
>  
> +	/*
> +	 * Don't treat a module that doesn't support Dynamic PAMT
> +	 * as a failure. Only read the metadata optionally.
> +	 */
> +	if (!ret && tdx_supports_dynamic_pamt(sysinfo))
> +		ret = get_tdx_sys_info_tdmr_dpamt(&sysinfo->tdmr);

There is a need for the comment because it combines two checks:

1) Did any of the previous stages fail?
2) Does the TDX module support Dynamic PAMT?

Should these be separated for readability and to follow the typical
kernel style?

	if (ret)
		return ret;

	if (tdx_supports_dynamic_pamt(sysinfo))
		ret = get_tdx_sys_info_tdmr_dpamt(&sysinfo->tdmr);

	return ret;

I think you can avoid the comment altogether in that case.

> +
>  	return ret;
>  }

