Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793943229;
	b=gvq9NFS3xPyXgh5/dXq/d78ggKV7zaVPtdqFFW5UtS5ZLzTnngrZAJ50Q6UMabudym0I
	 YnhLW+vzBmng9RKP9jLmwM6QbiTi1NTWsF8IjsSTjXSu0REW/to93J2PAuMXa3QW6cT5K
	 LS9cZFN+m3XYVM+W6Rrm6uMejtz6+AHZ9A/2ESnnsjIFcRCww4gE/svkYIwtP8bILoaST
	 24tRhdAmOPGtaRuIPT72eL3qo1I/RGQhl9PsYOKGSE23hklCmc8EGSbjx/ay/gNg1+PyC
	 z03Nd+d3sDja+TlU9+uzVrok8M0MBU36E8Al0uHku4YPMbWEZ3neMfFH6ThDo4+I/8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943229;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:From:Subject:To:
	 CC:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=S76u3AL+e1+93DuTR+N8SitKUr7N+CAHuGzzoWgQ828=;
	b=Sa4jkvyqR0ph/bkxGVWQzbfaQYL9Z0/k/Ww/FP1K6w1jzp20M2Niq9w4KVtRnJvZH0ZB
	 ZJu5k+LZVtB1naenB6pDKpsvaKbfMlJG6S2dCIH1b/yY0mmVbHIpf2OcFMpn+xU8hx6gz
	 YaLq63STfVKaH0hMEuLH772AOTRKOrqETiwYGb0X5cUgiRI8qbRYrtvdUKBye5ywVw/xi
	 pxrLkt0xtb9hR+vBoM4cBcCueXhvRHDj6lBhL7gCRdNCFh+VED4c9Pc2yY08hNMWmXgUt
	 PKVTFgUoviST4nE69+hUU2ZNUb2gwNoF/ofj5lONGNEZuqo7ubt64FJYhRlYLCM9rOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EFUYgJTh;
	arc=fail smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2057606A326;
	Fri,  6 Nov 2026 05:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2057606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EFUYgJTh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793943228; x=1825479228;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pX+fXqNd60CRa5E/8ZA4HLTJa0IUWcdNZsIrYLnmb/o=;
  b=EFUYgJThPl/5oHhSstPilWItcmFSFqaLJKmdVQlrmHWKf2Bt7yHxYMFq
   Ae9j3T+q8pPmhSkwOue6VvMF+rpBVTDdwGkZ2TQQFuYX/VncWw7XYOjlk
   P/MLawKpAbzhZBy43KwTMX5RlgrscqUzyxBQeu2VQotQuxd3wW4G88u9U
   1JNPfuzDCHHg+dko6AgYk990GhNEmFFcZFV+vixRFGDOJykvGy1OB9RNY
   Ep7hW00rGD6x3J6g1b6l90EP4fikxBSo4NLjcxR5ado90/m+ulAwBqQab
   cgI8h6pYx7nB28edjFejtQW/yZ2NxbZIooNarjAJl7tXp28FPKNfYcIF+
   Q==;
X-CSE-ConnectionGUID: G7+OYPk4RyyRuiCXhO5glA==
X-CSE-MsgGUID: u3+V6q/8RYeJzpjUog7Zww==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2639337"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2639337"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 21:33:48 -0800
X-CSE-ConnectionGUID: gSj72mepRdaRS4cCe1d8Cw==
X-CSE-MsgGUID: E4sPLzpnT6qhrDXTpXtqnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7753206"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 21:33:48 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:33:47 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 21:33:47 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:33:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuKJLu7hrh2mFh9OV7cO8YHUCjrzJDG5S5M82MledXs2rhtoS2kyshvUYDFrbrDXyzHL6UUNZO2vRmvXpeYD98yF68QiW/pGnKkuksamWl3n8kBFETfuwMkMoOLr6NM205IbVgA8hiXfm0weJhqaQuqWUtP6yZ2An/TNZhRTiSSD7u8LnwnEMml7qFCldDIVih68JXuEw559veS1UJ6COaUh5SENMvylihDbr7sRyIO1AggeVO4NllWM+K73CELKk4YU+bLdlXbYy4B9mTdYNddgebSZKT9pooM6x3ZB2Ih1pLUrbq7DqDsjA7fH0s6NyFouMGKq8i1PzjUZgap/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S76u3AL+e1+93DuTR+N8SitKUr7N+CAHuGzzoWgQ828=;
 b=KLMtiWsDLKyZMcblXUxj8ptIGxeeHQvPq88B5GhCr62jU84iGjvM4WKhG34b7UUofsg0zQVHydJcWCOqbCOyz0vm4JfHluOxuPAdLHjCfg9rGqJkqLJ/pFxJetMdK74xRiK8BHbLofqTUt77R51Kka2caZ8DF3H5WydzAOxsTq2mCFAsg96poNnJxzyXgTyCxYX18+eLVAs3lRHwTaxqBojCqK552mJb76R2RlAwWCX83stNoIrZJ8XPGcfJZWqZcI4fECn0NPBGTcCrPZ2kmvTAVyVkMTG8KK8jqRt6EAWbNmU/kl7we9ZP8SfFobvMP/v1Ff+Sgri4kk+cJJCrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH7PR11MB6521.namprd11.prod.outlook.com (2603:10b6:510:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:33:32 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 05:33:32 +0000
Message-ID: <24be20bc-4089-4cf9-899b-8da1b2ee2825@intel.com>
Date: Thu, 5 Nov 2026 21:33:29 -0800
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v8 03/20] KVM: x86: Support APX state for XSAVE ABI
To: Jim Mattson <jmattson@google.com>, "Chang S. Bae"
	<chang.seok.bae@intel.com>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <zhao1.liu@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-4-chang.seok.bae@intel.com>
 <CALMp9eT1Wza=7s53Pu7ODcBRkYSbpv4A_y58xJNEhQeaJ6r1Rg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALMp9eT1Wza=7s53Pu7ODcBRkYSbpv4A_y58xJNEhQeaJ6r1Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:332::27) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH7PR11MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 004ff5f0-6c99-4f02-a118-08df3bc77eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|261026140227099003|11063799006|4143699003|261009223027099003|56012099006|261021121427099003|261028144727099003|261022105027099003|261026121527099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: PSDWt1GxMssrwBvPB1/XE7paGNE2AnbRX0eG0vdiBHLwISkZ66hUjVbHFeofH7Ykp4ONtdorpbnx9lFIVjUevGqiVWMN16UNjkeyU8/Yon7dJzuhxJVcX5aHybqlLB4cwxxvQ6gnvxKS4AX7H1qE/V7Vo6PXXkiXw587e343yz8L09FNQEPVw17e4Olau9pjcyxrnpXOLi68q4ksxk7DYjFSNsGnRwtfytCLHwIzRJILxjzpFlMThn+TnbP9iR7AxmZa9cDnOuoi1SQ0gkaojJuKe0h86oJ2F+w+VyIiWwZg9UTAsf+Y/ppH62+maPbt0moSFgRjo68ynwp6K5D2HRCAYkTyaCAUSTv81WWpMMEfLVziTpxUhiMN/3jT4Ci8MJ6JnP8P0awMwSjrpxqek93/7mRe/7rdx5MXp0dTZIfLZMJ/qaTKjjD9eeE9SOf9/SeLEKFPXD7bbnYWPkmVMwg7cVpzK1OG8/7TwzId6lrA6vNRcDRYhA0uV4PLDYmAk6pSbjdhRY7Xcy77kLS+9J6zWpAxGGfEhIVM1+CvKNUBnQMR5DH4qB+MBvAz19Y7+uTPG5nSD0uP+iJksHik3ssUzYDignbhx+IDBDKcIHoYxdwrHjXcDEQ7L5P+xYfWh1v/0rgK3prD/XVMEsnm+ZrX3vB9iRj3zRjwoK3BhAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(261026140227099003)(11063799006)(4143699003)(261009223027099003)(56012099006)(261021121427099003)(261028144727099003)(261022105027099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjZZemRWeTVJY3lTcVMxbUFPVmJDeFFOanJwd25JUFFFeU03NHY1SmRwRTJ4?=
 =?utf-8?B?RUNSdFNnSG5TVlNNRXhZb0JQMWZqOWZuQk1Za2lhZzNuVkFVMEZseGVkTnFR?=
 =?utf-8?B?WGRZbEtodkQ1WXVJV2ZERis4Q09RM2RaVWdISkJXZzlKczhyQ3Z0NjhTVHRt?=
 =?utf-8?B?RjFIYUI3bmhKMm91aWxFc3p2RXB2a3dNU25DcUtLZEl2blZqc2xteXdwT1dh?=
 =?utf-8?B?RllxYXY5YUM3TnJKYmp0WmtOdUdDeC8wSEIwdTZNd2lHb2t1VEVvWklsenlR?=
 =?utf-8?B?N3ZueUwxNEU3YlpBZ3ZTT0tualdQUFFIa3VNVElpQmhIVXBVTlFqelU2R2ZJ?=
 =?utf-8?B?NktKbDlRanVjQXUrOTN3akJZZStwci9vMUdLS0JXZzlFTW0wTGlQUUwzVWZl?=
 =?utf-8?B?NXM1ZFdrUEtJYTE3VWZEeTJCWEYvMUJacGh1VE43SVZHWVBCTGRHUmJYNk5n?=
 =?utf-8?B?QW9RaEF2YkVPb0VHWW1hU2VTMDMzZ21tckpjY2I5YmRwRWV3V2hBYVVOcmVJ?=
 =?utf-8?B?dFlRTFR3ejhHWHFaYmhNdHk3VnVBckh5QXIzbzNhMi9DZmVPZjZ6RTd6akNi?=
 =?utf-8?B?SEcvTno5V1lUd0t6Nzk2eHZpZ0V1QmtOTEMzWStDVktUb2RUa2tnYUpzTnhy?=
 =?utf-8?B?WHJuWnBlTVdZeTNycVc1dTMrV0JPWXNOdStIZ1BiSzJVdS8zYkk0N1JYL1Yr?=
 =?utf-8?B?eXB2WEsxNXc4eUx2UmRUR2VVUHhGMm4wUzQrYWFTUDUzRGVsSkx5ZGRvYm1Y?=
 =?utf-8?B?VGc4T3ozMDkwM0Fhb1paWkNEeXZpcVZZQjJoTGhadDNnZWhoT1J4WUlPdzhV?=
 =?utf-8?B?dDlrUU44UkNheWFIejVJemVhdHUrY0N0bXZnQ3lLTGM2N3ZVMHBuMkZFSG9O?=
 =?utf-8?B?UVNCczlpU0dDNUpJNVkzVlM1YmVmTms2S3M5b1lyNGM4STNOYmw0ejRZMXFx?=
 =?utf-8?B?NnFmeENMaGJORFRtWVV4UldYTi9TckNaanZ3UWp0L2pXd2hURnFadGVKcktz?=
 =?utf-8?B?ZHVmTVFhK0lwMzN5NjB0ZDBVcTZNbkVTMUJia1FVa2JZUTRFL0VGQUcvN2Nt?=
 =?utf-8?B?T01nUG01dzlGQzd3TVZnb3I0MmVITEZSVmsvTnY0ektYZFRJcnJGb3d6ZkZS?=
 =?utf-8?B?SFVEV3Q1YTEwZXJxenBxNlZUdEZjMXZMVnZHcEYxOGxCVmVZMDlxb0hhb1Z0?=
 =?utf-8?B?Q21Nb0x2VG94Zkk3M1ZadE92V2U1SW9JRVBLV0RtSUNySDV5bDkwZzF5S1pt?=
 =?utf-8?B?Y0ZtenVOTEJlQ1ByVVRoeGJ1SUI4NGg5ZXhMalkvdEtkQThSaTdKaVhJMDBF?=
 =?utf-8?B?ZGtOWU1mR1NoMHExNlo3TGQ4SjVKQnpBWjZHbGJZQlp4WCsxR3RYQ1lobThE?=
 =?utf-8?B?aGNzbS8wVXlCa1FFOHYvZnVkSUJKaW1EN0xndEVrRmt4STNDaVpYY2tYeU1I?=
 =?utf-8?B?RnhEVjN1a1Nrb2dmNm43V3dOemtzcXp1SEZBallsNnFRdHFHd3RBbmZQVklN?=
 =?utf-8?B?V0RHVk0rTVJVRFhiOUlEa3RIMzBaOEZCWFJRdkR3OW1ZUzNrOG5QdlBQUkp6?=
 =?utf-8?B?QVZGRXkwZ3ZqK01TWThqd2t5WEdRaXBQN0VxclZMcE4zaHgwcitFWTJDMllB?=
 =?utf-8?B?VHRKamJvVDVrZ3hwbDBFL1c3Y3U1ajBnL1ZFUXhJaERZdkFpeHc0ZWMzd2NJ?=
 =?utf-8?B?Q1dyVTRSMTRHdnpWNlQrcGJNVVJyaWZxeEcyNEphS3FiQnZWRHZxYi9LckxI?=
 =?utf-8?B?aVNCZVduUlBnUXROVlA2WUc5SktmdTdYb3VUY2VuWHpEaC9nbmdoa2JUTTlH?=
 =?utf-8?B?Q0FnK1hrMUVRc3RlY1ZjRWNqVFR5OE8xYWxQeDBqQXVnb25iUlV0ZERRRmMz?=
 =?utf-8?B?Q2o2emRldnowWHJTQVdiZTk3clpOa00wM0plc2ZIZDJUVGdFVWhUVUpSaWgy?=
 =?utf-8?B?OXJOOTFEY3pNcTdqaHhJT3M2MktUbUg3cGxnRW9PdllXUGtURWhjUVlDUFhF?=
 =?utf-8?B?YUY5YzBSN0tsNlEwZWROWmQwSDVPVDJiMUV4N2x3RGJSZktmODRvQW9XeDB4?=
 =?utf-8?B?dE9YTENTa2FRaHd6SlBlVTNlN1E1OW53T3dTdkEyNVdXWTRnS1ByUHBZOE1j?=
 =?utf-8?B?cGV0Rkt4bkgwaDFLb2FLU0tjWEZZRUJ0RnpydlZBdVJRK2ZEbm5kNlNEOUR4?=
 =?utf-8?B?WTRiMEZ1M2N6UXptV1pvQzh0aXc0KzNITHI1Q1FSKzBVb3U0STJGdzNzTUI4?=
 =?utf-8?B?REdVOHh5QS9NVXNkL0c1OEoxNlNudW9URk1lQ0pTVkFJb2ZSOFRFSUErZlZH?=
 =?utf-8?B?ajhNa3VCby9BTHhoQUMwelQzNi9SVlNMaGFPUWtqdFlXYnVOTk80Zz09?=
X-Exchange-RoutingPolicyChecked: uVVIrKLFpJ2zsmqP16u0C5ejbEGSTEDJKfK87T2BM4T9D+2m0iYPBkA58MCAkoLPStPeE8ZhJsrXyjMw6ufbM6SpMSu+yiCa2JCZQdbq4CEXuqFAQbe7GrSq4D4Ci8S/B3IMm7Skvny9aYwbp+YpDtAtjEowVBlWM0oBGlEsK8z3OiyCKFEy9maBafY/c7TQee8e7I8/M58q5TAJspoXeQDRU71sHQMIG8yNiGWT2G0fYftJLybNqDgD4N06MkP/GesOVK5Y2zbwg8g/F10PJ3qjwwcr3X1nn6oDpgT32OGRAN/XSeNH2Qw0eiL74w0d1T+RSI6ab4wgOM48v9HzmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 004ff5f0-6c99-4f02-a118-08df3bc77eb9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:33:32.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSq9QHpvN9IJNzugBKNYCsUfKJtBTlaOUB3ULk7YKWpsnr9jBlviVnKQH6l77xMAPZiIVA2Mf5O5BcxCm7SuN1/NmyXDDHhgMqcdiIfkfcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6521
X-OriginatorOrg: intel.com

On 11/5/26 16:13, Jim Mattson wrote:
> On Wed, Sep 30, 2026 at 4:02 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>>
> 
>> +static int kvm_copy_uabi_to_vcpu_regs(struct kvm_vcpu *vcpu, void *buf, u64 supported_xcr0)
>> +{
>> +       union fpregs_state *xstate = (union fpregs_state *)buf;
>> +
>> +       if (!(xstate->xsave.header.xfeatures & XFEATURE_MASK_APX))
>> +               return 0;
>> +
>> +       if (!(supported_xcr0 & XFEATURE_MASK_APX))
>> +               return -EINVAL;
> 
> Sashiko is right that this early return leaves stale values in R16-R31 when
> XSTATE_BV[19] is 0.
> 
> In your reply to Sashiko, you wrote:
> 
>    This matches the existing XSAVE uABI semantics. XSTATE_BV specifies
>    which state components are being updated. If userspace wants to zero
>    the APX state, it must include the APX bit in XSTATE_BV; omitting the
>    bit means "leave this component unchanged", just like the generic
>    XSAVE copy path.
> 
> That is not how XRSTOR or KVM_SET_XSAVE works. In the XSAVE architecture,
> XSTATE_BV[i] = 0 indicates that state component i is in its initial
> configuration (typically zeros), not that it should be left unchanged. In
> copy_uabi_to_xstate(), clearing bit i in xsave->header.xfeatures 

But copy_uabi_to_xstate() does not overwrite XSTATE_BV. Instead,

	/*
	 * Add back in the features that came in from userspace:
	 */
	xsave->header.xfeatures |= hdr.xfeatures;

This means that even if userspace clears a bit, the bit in the kernel 
XSAVE buffer remains set if it was already set. Consequently, clearing 
XSTATE_BV[i] in the userspace buffer does not necessarily reset the 
state component.

I'd follow up separately with update the wording, if needed, to match 
with this behavior.

>> @@ -3189,6 +3240,16 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
>>           */
>>          xstate->xsave.header.xfeatures &= ~vcpu->arch.guest_fpu.fpstate->xfd;
>>
>> +       /*
>> +        * This and the following copy functions copy APX state into each
>> +        * storage. The VCPU cache is the single source of truth but avoiding
>> +        * this redundant copy tends to introduce special-case handling. Since
>> +        * this lies in a slow path, keep the implementation simple.
>> +        */
>> +       err = kvm_copy_uabi_to_vcpu_regs(vcpu, guest_xsave->region, kvm_caps.supported_xcr0);
>> +       if (err)
>> +               return err;
>> +
>>          return fpu_copy_uabi_to_guest_fpstate(&vcpu->arch.guest_fpu,
>>                                                guest_xsave->region,
>>                                                kvm_caps.supported_xcr0,
> 
> If fpu_copy_uabi_to_guest_fpstate() fails, vcpu->arch.regs[R16..R31] will
> have already been clobbered.
> 
> Moreover, if you call kvm_copy_uabi_to_vcpu_regs() *after*
> fpu_copy_uabi_to_guest_fpstate() succeeds, you don't need to check
> supported_xcr0 in kvm_copy_uabi_to_vcpu_regs(), since
> fpu_copy_uabi_to_guest_fpstate() rejects any xfeatures bits not in
> kvm_caps.supported_xcr0.

I think this is a good point. Since it was decided to let APX state go 
through the fpstate anyway, it looks rather simplifying if switching the 
order.

Thanks,
Chang
