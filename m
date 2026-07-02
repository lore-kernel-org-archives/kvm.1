Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B714ADDB4;
	Thu,  2 Jul 2026 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985751; cv=fail; b=bQQa22xNc7Sx4DttAWweqhPhWpusvgy9P1QbNFgMLNBbK9CuJSP7flgK0u0rGfCfd/duYjX1VSVWzfqNYLtneeM1kUQY2B/deXSzkfW5hLxMlhZkhy0A15OPNYl79wUDlq52yoQrOmXItqy02pOdbktlZfBRPc7E5VekBb53Xuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985751; c=relaxed/simple;
	bh=IG8Sd9QOI5AxLWVida77wtTzSPOz2WhRrPaUD//Dneg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rfW9lMB+B5IRt/9+sDdKDGqygx60wWeVeFgXWRo5KJVSx7yoMAbIPXom9XHrKdPbJMzDpSA6lfQrx3+zaC5nvatoxrgwaEYndVN3mn59BIhppbbJ3yGLl25+P6k6GCAqYd3D/+1gjisNL5X10swQhXrerrSdrOLnURw4hg9+s5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoPJcUS3; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoPJcUS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782985750; x=1814521750;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IG8Sd9QOI5AxLWVida77wtTzSPOz2WhRrPaUD//Dneg=;
  b=IoPJcUS3zjhNUPWsMn+iZilaZCJnmxdNeFQ0E54Qzd9ajvSbRaNuOrKJ
   Kul1DbcRgrFTXUX5pQPxAm8VkrnCSuVXpzF2zPrJRqj9Z1Im1ntNw36aE
   OJ/Wx2vRGwwzwj/37D1RBd5JY460eyt8jcC8WKWIvOwyB81OGnCPQtb8V
   Tn62JOC2xY7PCCJmLLyp/5kVzu26OLpSxRyr94GvzeU0VDo/0uxFjDAoH
   Hr5UXBIkqDwT6+ukZrwGiOzMpHcPVk5ctE9+3fEQXHqHT5p9m4OkegpC2
   7UWQZNrIMkAdF41CbB2Z2dhN+gLsX3HMrnf/SdNyxiLXV6ff8/gK8HU+B
   Q==;
X-CSE-ConnectionGUID: sBxpSnikQ+W5hK/7ydwdng==
X-CSE-MsgGUID: v2tAvZtoR0m4lsEwk0pj9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="101277537"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="101277537"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:49:10 -0700
X-CSE-ConnectionGUID: Yvm/IonZS0mnttljNrOklQ==
X-CSE-MsgGUID: aZEMi0K2QEOdVvt1wDflig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="252373672"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:49:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 02:49:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 02:49:08 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 02:49:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OU5IarcJ60xkUbNYkcI1qlYLCwc7m3IJGUvs/VPBl/htBwl/MG/ysvETfWTAgKUNQ2pJEVVZIwj8mJqhoKFlgVwQ3BPt34T5Cz2VfLal76DMVMlrhR4Fpm2iAi3+CaXgO23x55gZJMeo2+dHwxVdS+YdXu0MPFqG2VqqFAmPNd4WNv3BFUpRYGCso77jG97wSZVNtJAaHI7FWWhac68nlEhhwTSiEyaXCt89yIkqica40//tD5GNeozjlH0K9sjrJXmjYAWH8Q9S3dhqvkT/Oq1JbpcD89D2pckAriDE35eTjbYys7KaIsOF0NK26l72KTtEU3SNRsMBwg/NadXS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q10O6sH9GQUNSPEBBhO05aKqYIlAF1wSR+qg8ZgMALU=;
 b=E3JeXFwykcL+nXRcKl70Q3+HUQuPCCuXrvf03qZUIjRisvAfQkkQVFqPmloR8kdAMTnq5svHngjYGNVpZu1Zlz4px+ThICypJArxvNv7VJiZhFHFDAyD90g5fs2y/QtM3Uln9jxt1roXyqVhPEN9zA5Sdh652Pb8vPG9l2CaMDbhH0rrVITeBNoTktQQt/B6xAfs3zQ3EvVuCSYZy5bs5NujaQpaeKvQ7eG2o5ki9m+zXUbcRaUAstW46MWixxNgk/SuiL8/E5Gu6+mpRfyo6enBikyDym7SQdtWV/yzFti5z4GQS3MuvXo/ZVVUlx8WeW2IikrUEuHzH31Q+lamZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SJ0PR11MB4925.namprd11.prod.outlook.com (2603:10b6:a03:2df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 09:48:58 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 09:48:58 +0000
Date: Thu, 2 Jul 2026 02:48:54 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "djbw@kernel.org" <djbw@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 06/15] x86/virt/tdx: Initialize Quoting extension
 during bringup
Message-ID: <20260702094854.GA2169894@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-7-yilun.xu@linux.intel.com>
 <6a2c9d8b8bfe9_9b85510018@djbw-dev.notmuch>
 <20260614075026.GE3200182@pedri>
 <d862b418cdbc9b55c453038184b7a438f34e4da8.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d862b418cdbc9b55c453038184b7a438f34e4da8.camel@intel.com>
X-ClientProxiedBy: SJ0PR05CA0141.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::26) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SJ0PR11MB4925:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df6cddc-7f13-459a-9746-08ded81f236d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3xE+Sb9XwwndszdnV38hkrpj4BucqJVOhVbOeqLZ0ztgD2OaNo0+8TBPVqk+s8yFEjoKe4/7MQ4S+EBJ5zrxQeiDiOScQFWCQAMTuSstr18PsTuECgbyVLxA1ik9wlFWx3P8+sZIHooYK/0S7pudXLa/0POer4AtLZ19om1I4eRyOCA2LU3xDlsGO21FbmrZopjtdr5GgQrJ3ZE/xQvLc8LwhJQ6ODS+7LqOyuezNgsVoeB4zgjMpJ6CjtSjBoWS7hSNQjq5OtvBZ/o5dMdWEKhLFVG6lJQPtIC/9SpMIUj44XbJL+WV1rFAQJXEFmfbji6XAnzaN/4cFUYAY7JO8t13ZJBnBwSTbu4xu++C/cgaXfbdxBvnImzcV9SlyJ9byltzJ+wSWvKBWSFqi9qLPId5MVUwBqsWwMeCK5mE9aimdRNsNx0KP8xGh2+vyMk3XZ9xwO4raZE7g+bBweskKf9EgI7zFMr97AUZ+8gzIjxM8HmeKylrQzOEMFk2CCWqRg/ql3klqka/1Brpymj8lg/LhvyShkpqcYcFxT5T0bF+rfoMU6HMPvEd+339utpuY1CYp6kw/NEAUSBR+2Vor1hl0la8rzrAVQ04i0+n6Mke31U1oDQLrzvFY1C0o99MzBIPLjxK8JUAnXzSkEYe8Nl/13PiDklIz3wsYq2LNYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDUwZE1uTVBtNE5MdnZUU1RLcE5lQ3krZUVKRk9ZUkxvVVdkUnR1ZHBVWUZX?=
 =?utf-8?B?cVFxaFRONjFNbCtGaEVMTXFIL2VrN2FjVE9wZG5neXk0QnoyWVlIeTQ2OFNt?=
 =?utf-8?B?UEh5N2JQTGFVQnBUb2hDMEJvUFZMbERwZFRWVHBWRGdmMlAvNzlwRWpEMk40?=
 =?utf-8?B?MVdBTnJWQ0IrNTRQTTBKVEZaU0poMzN1Zm9jSTVEWnA4TEpmd3ZwVnpiVmVR?=
 =?utf-8?B?ckpzaXU0WmI3Zys5cWJDbmNmcHpUNU1SMVUrZ2JLT0loYU11b0R4UzJGR3dL?=
 =?utf-8?B?cHVScUNCVk1WNEMzcmdWME9FM2NIbUxTVEZWcjAybXMyL0F4aUUxZFFDb3Jq?=
 =?utf-8?B?bHlQK291OG5TY08vWXNuU2pBSTIrY1UwUHNhZWFUcEQ5K05qa1Q3RXFVV2k2?=
 =?utf-8?B?WXZsUk5sSVFnUE11c0lMSWlZUmZVSW8vSlRkYU9GQ0hka29FQTlkMWorR2t6?=
 =?utf-8?B?SERRTkdEU0hRRzVrelV5T1Z6TWd0OTB2bUMxUXdKVVBXYmpJVkZKNjAvSnJ3?=
 =?utf-8?B?QWhIUmhJVTdnZEcwNkpsM3lQZGJjMC9sQzF3R25pNjRRNkZ6R3RSUHRnR0I2?=
 =?utf-8?B?cnR6L1lCcUd2ay9obU5JQWZ4SURkRkVQTnZBbVdLU2owVmZKUkVqbWc1Qy85?=
 =?utf-8?B?Z00raHlySTNJZ2x1Vk9uWkRPdjV0RVR2ZGZrbnV4TE84dVV6Smo3YnZGQTYx?=
 =?utf-8?B?K1RSWE54Rk9BcUdldHpnK3ZyUFo2a0VQekhHd1UxMzQxdXZJbXJLdkxPTW9w?=
 =?utf-8?B?TkhYeHBJNUNvcUFCWFJ5UWs5SllGSjVKNzRzcDRFMWU1angwS09FcDJLSzFm?=
 =?utf-8?B?eU41dVhiVDd2S1lINlppcU5kaWJHZzhJSFZlUnhXWU91d0piZHQzWlJ5WG9V?=
 =?utf-8?B?YTM1N2o2Z3VVVkRXY2swMEczNTVObHJQTWpzNGlqQWQ5OXdtamZwQVJLSml4?=
 =?utf-8?B?VTFyODNDbXRSSGxaSWRlVzFVNitROGYxYUFxZnByOWVGUk8rMkNIVlZ3K3Jh?=
 =?utf-8?B?Wk9zeHJnTGRZcUtyRnUwY0VaZVFsVnFKRlhZNVpURVVCR1gzYllLS1ZOVkR4?=
 =?utf-8?B?Tk1ZSXpRSlpuUTNRM1pYek1Pa0p6NG5CUXVOcTNUWkhhc2h4THE5V0ZwMjND?=
 =?utf-8?B?Vks2OVYzekhMY29GeStwbmQzUXRFQlR1WEt6WUJRUXQ3clB1Y0cvd0RRN3M1?=
 =?utf-8?B?aXhqNjk2QWtrdmM4YmJQWUw5UEluY0hIQlN1S1RaUWV0TytGTGV1ckNSald2?=
 =?utf-8?B?clRrMGFmZUkzMW5tU1diSUR3VGZETzBtQTQ1ZSsvVFBhMkFOTWF1TGU3Wll3?=
 =?utf-8?B?NHNxdEppc2Rqa3pOTTFRMTdpejgxc09naGdRL0g1K3NZakhwaGFaZHQ3b0px?=
 =?utf-8?B?UmVWR0o1QnFmbkhmcFhCV0dOcnZRWXcxV3hxVkc4Q3RLUG80SnczOC80UmFQ?=
 =?utf-8?B?RDhjL29vck1oR0k4QThMTmJJbldEUmFOZnJRYnQ4QzQxS0Y0L0VNZ1FmU2h1?=
 =?utf-8?B?QlZuUk5VSHRHNnFOZWtaYmh2YWFnTk81d3M3SmRHUkVJc04wRVZxVFhXbHVL?=
 =?utf-8?B?dHBPU3BFdGZvTC9LNXhqa0hGTEYybktBbzA2R3lzV1UrcnJISWZnZ2h6QUhk?=
 =?utf-8?B?YXB0ajYzS01pQzdYRzQ5TTJnZm1pRDd2VzBpUDE5Tys4N3B6dFgyWDhuWVhS?=
 =?utf-8?B?YkNoU0Mzd0dUMTVlYklrU25Pci9Rb2NTY1FMdmh2bzV0RXBVOU9MVDdlTitp?=
 =?utf-8?B?VzF4TThSRmNpK2hXRVpYNmRNWWZtM1JqcWxxODlXSlV5SHl0Y0o1MWUwbEUr?=
 =?utf-8?B?MWs4aTVldS9odVpXVGZYRlQ2Z2o1ZVlDSEl5cHFCNlVDa2VJVGMwT3pJd0Jp?=
 =?utf-8?B?V2hHWWc2clpUd0lUeU1TeXluY0NWTE5vYlg2MGVJdkJuVEprQ3ZJUnVGTytm?=
 =?utf-8?B?aWxPbnZCTFFEVWkwOGhmSVU0c3o1ZjNPQUhMd1pHR1o3UHAwTTBpL05HUnRC?=
 =?utf-8?B?ZnBYS2ZRUXJHUFJhU1BKek1xNS84aVcrR1FGTXYzNGpGOUhPbTgvME1WMDM5?=
 =?utf-8?B?ZkRSckI1UjZvV3Ivem1XMnllWmNZc3AvSXYvemRobFRkTHk1aGt0c1RmSlNz?=
 =?utf-8?B?L01helNGRFcxdzlxbmx4OFlZVTZ4b0N2aDR1aENHc3ZDUnJXQXNQekdTRUcy?=
 =?utf-8?B?ekhxbWY4WDhXUnBsTlBFSlpYaHhxQ3dnOEFvT1M3dWNQeFQzNnB6T3l3L01P?=
 =?utf-8?B?cVp6bmxmaXNOZTU1OGhQNE9lV294cFJhMmtWTzZjdlo3Rmp1ekFLRGQrRzhz?=
 =?utf-8?B?a0tQNzVKMlJsSkVEdzBzaG16RVhtRUdYb3BRSnQyNi9uZkhVVnMyQT09?=
X-Exchange-RoutingPolicyChecked: Al6U6LQaf4OK6UpDCWdOtylro8yp9sT5925atU1iaCt2uJL7yMFKZjobBGheFRTT11cWV3ASTSvaghpnQiNhvA1PKOMHk2zUh5YX1h2RFKq7pExR/KjJnbqnxt8/y7xPpjjI/cRIMft4Ph0iNafoCaBo6Vb7B2U8eQQ2ymL+xgjVG/2WvzD4JtNMf0+KaEsvEF2oT4IlZeVgeFjfNIk/UXK5HRwgLO05zISDnYBuChNXiWTavKO6mJZfW2UyBPRXq+E6BMsTrVudisT+SLFRkAO3o2n7anux0gCK1U2DyfaUKIDpmJ7LXlYVnJjPxOMKWhHRzmNiRkQmAlxcpiSGsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df6cddc-7f13-459a-9746-08ded81f236d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 09:48:58.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrWaQf5b26XNm9ssbT1G3PF6LpNO55VjLuMyy3DL5J5Njhzg4mHXnJz2944QsiT1rbvHCwKQyqWR/Cwomnh5iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4925
X-OriginatorOrg: intel.com

On Mon, Jun 29, 2026 at 11:11:27AM -0700, Edgecombe, Rick P wrote:
> On Sun, 2026-06-14 at 00:50 -0700, Peter Fang wrote:
> > > Is this micro-optimization worth it? What are the classes of quote-init
> > > failures vs just make the policy be anything in the module must init.
> > 
> > Since there is a fallback option to do the Quoting in userspace, I think
> > it is probably not worth shooting down TDX entirely over quote-init
> > failures.
> > 
> > The quote-init failures can come from:
> > 
> >   1. Quoting init SEAMCALL failures, which look pretty opaque to the
> >      kernel and there's not much it can do about it.
> >   2. Quoting buffer allocation failures, which *are* understood by the
> >      kernel, and it could maybe try something else. Right now, we just
> >      treat it the same as 1.
> > 
> > This is helpful because I think the question of "what if the Quoting
> > extension fails" has come up enough times that it warrants some
> > explanation in the patch log. Thanks.
> 
> I thought we were going to do:
> - If quoting is not supported, don't try to init quoting, and don't fail init
> over it.
> - If quoting is supported, but fails to init. Just fail TDX initialization for
> simplicity.
> 
> This is what we are doing for the other features.

Hm this is simpler. The "fallback" scenario is probably a stretch right
now. I'll make this change. Thanks.

