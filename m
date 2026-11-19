Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795053326;
	b=Yec/nuLYEhvR741EK05N/HHMlw5txG2m7LwSnC/G0uFHWuQy1qiewNuNotvPYk34CFpC
	 o6Taia6UZPaVq7oj3Jlzb0xmIKICqWCQ4GwCXBuhCdSdCYzpXe7dOZOgkf27eY3+1vMS2
	 qDKXFwf8TiblvHnwGI968G2Zl+DqN7JbPIeEZzeVUYRRLI1ENkcioKns7loXMWJVQx1jt
	 8iIA0dhGJNG8ssK/PbPzPuR4wdU25KL29RvOKcHb9iC6b2zdnrsQmi7sT7iGjw9QviBTQ
	 W1x1TNZZxiVcDOqirm6YhliFHdn/f00zD3d267V6ETh2yA0l7lMARgB+5sbA6cdZVEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053326;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 From:Subject:To:CC:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=IFwKtbI6PF0/G35U0HiSPEC57Aa2+iJd9CoOLrI46M8=;
	b=NNyylTWzru/o3gi4J7zDbiwRIHyTR5gSFf81iwUL5fCIqZNyHJNfiIYN6YuMcXSKC4v+
	 OuTUxseFfXaXcPnayIAlTjTIG6/0apghvRtluLJJcmq8PMtafJNCAXk6hsPReIgfIaM0H
	 hEn7hI+62OG9OQEhqyVqn/hP7G0+AmyOdoy0mtVkeYgAaHu8xTGIbc1yyhr4EgAIz8kyx
	 tnqnY4nRTQfMLYRTWZc9j3HLLfCE9imdbncGSVME0nXvRYxtuN+dIRJXKUQU1tgu3tCcI
	 bMNnv731FqzYuvOzfZzc8qLngku+ip9Hec+fVemzKLipO9684KdcmBpWawdFRff4YpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OFSIZ3Js;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Pf8Fy51m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798D606A332;
	Thu, 19 Nov 2026 01:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E798D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OFSIZ3Js;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Pf8Fy51m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795053325; x=1826589325;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TAzz87H7+VEIqWqItySHBR1U+5ygiw50Y+IqhDMPTCY=;
  b=OFSIZ3Js9X8MN/kLxeGB20MXO3magITN3zroRVlnUKH+rn7KMEwmTKuD
   3uAkXJ4gg32I0nGsOHvcDaJdAgLL29lKk7jdUTX6DjZDsUwVQs1LFYLBV
   yRSH1zjBTNI9apwGXJ1NgieS1TW+tyhRA9DRweOs4q5U7PswTkShN00oG
   Uz+M8Nk83cuz1iMfadD+xJO3Yl7BfTB5lugsyJJy78sCaIOL0CCm2tlkj
   YPcg42ydXzr4yOUtxcTZXCMR8JhAWXqcpS89T/heEmgAPcfH/u1YfXlAM
   ee9nW1sFrQq4kUUt1MDYF4jHxJZXDPnhoUbaBEk7ULaZlgL2KEWFxTx/D
   g==;
X-CSE-ConnectionGUID: 6GoqJ10ySCytMP+H5Ovi/w==
X-CSE-MsgGUID: 7mwfY0pUQ1C6FVA028X2sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3776129"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3776129"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 17:55:24 -0800
X-CSE-ConnectionGUID: tMm59WxyS5+jrFJv0D8KdA==
X-CSE-MsgGUID: 39nss3mrS+Szb7Kkep65bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10569133"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 17:55:24 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 17:55:22 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 17:55:22 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.16)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 17:55:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cm1STSPOvxrUumDrNTFYyCaQB64bq8S40IDY16eKbOfvwMznwzuIiMsZ8K8iJyAbEJ3kdFa2gOnhjnS3LRvrFqqdghVkTaxXNiEonmcbAgt0dIsGhH4w/c+4bZE+9yET8Ymf8p7LdAmLR8MRwrr2i2Gf7o5QPftSTtxrSzSdHTisfWDk1uVMNRFVUX2njh4FLxqzlHLiag23wojp9wLEEfJtGVsaxfZHNDZnTpW/nqZJazIg5nk9brDHpHTOWb0EkadaHGMAjGNkCdAPwRhAeG1EVHU/L9t8POBy6Rkrn1P1nGCkhjPxvqiZFQ4yVGMGpnBWWzDuQLqk+PtcHbaffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFwKtbI6PF0/G35U0HiSPEC57Aa2+iJd9CoOLrI46M8=;
 b=l0gy/dcsVNCrS45gqSsv1hAa8SAbgMA7Je/T3qtOqhuH7vUMibjw4bTwCF++u6B7KA4Q5LcUHVGds2Whl8fBxv+0KjRWssDf0B6ooe1nzZXTFth3yUZQbw7zFDk8OGAw1OFJRr4WTKYSC8rAEwK5HwU42L0LVE0YSSetzezWIRkA2XFm/pKpWXWp9iU+J2PUFNfQHcxmLxaKVhBhDYPcrQhGHXBDaGHFhjgM8l8vyua4VA8EzRlW2v4tQWK6AfTmcyUiB2Z7ta+XUTOuE94O4H2ZK1Sasv/cJggOB/Z3FZpMmDTGJglC4UByLBV5jY1pcccsPRYYc56UWZiry6VREg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFwKtbI6PF0/G35U0HiSPEC57Aa2+iJd9CoOLrI46M8=;
 b=Pf8Fy51mY7pLGXuY8Fk64MCNXPwf/Bs6QGT95nDEYJkqntkW9L0I952FxML98RyKSxJZYxCoelxrjI7jdE1A041mmKS4LgZIqRha+xn0A4J/T9HHdlIVZxLZcXeFeXyQKGnMBJ5p3/uf6midg5hPYQB61b0a4YVlVBYtn5khY6Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB819107.namprd11.prod.outlook.com
 (2603:10b6:806:518::11) by DS3PR11MB020596.namprd11.prod.outlook.com
 (2603:10b6:8:43a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 01:55:15 +0000
Received: from SA3PR11MB819107.namprd11.prod.outlook.com
 ([fe80::e8cf:3b9e:d98:ee2]) by SA3PR11MB819107.namprd11.prod.outlook.com
 ([fe80::e8cf:3b9e:d98:ee2%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 01:55:15 +0000
Message-ID: <b47462b9-ebd9-4a1e-8791-ee9c861d0bd3@intel.com>
Date: Wed, 18 Nov 2026 17:55:13 -0800
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v9 04/20] KVM: x86: Support APX state for XSAVE ABI
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <zhao1.liu@intel.com>
References: <20261117180310.921701-1-chang.seok.bae@intel.com>
 <20261117180310.921701-5-chang.seok.bae@intel.com>
 <CALMp9eQABxnk2EV64xXXeH+V03LWrnK8qWOcWcDeX3tiY_N3zQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALMp9eQABxnk2EV64xXXeH+V03LWrnK8qWOcWcDeX3tiY_N3zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To SA3PR11MB819107.namprd11.prod.outlook.com
 (2603:10b6:806:518::11)
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
X-MS-TrafficTypeDiagnostic: SA3PR11MB819107:EE_|DS3PR11MB020596:EE_
X-MS-Office365-Filtering-Correlation-Id: fac0ea6c-048f-4611-54c0-08df45e02797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|261009223027099003|18002099003|261021135927099003|11063799006|4143699003|261026135527099003|56012099006|261026121527099003|261102123227099003|261028144727099003|261022115727099003|261021133027099003|261026140227099003|261021121427099003|261022105027099003|261026130827099003|261021130227099003|261022113327099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: i1kEzfpblUjkiPrEKvHioScCuLIa/FSte2EYt0TNLEiH7E9aLs7LX9HwTfV6yF118NrzfSjsYfIQlwyLhrZT/ks9WvODBgrfIR79/+A72msM+nc4g2DzK34vQJV1kHHpSV3XAbF2jxwc+tRiPkDYLRYYGaIVqDw40dN1eQw0FjR9JU0umeChonwLw+vLvZfgxVACHN2scKPjtn6R81hObtefHssm1ziMZeAkKfPWSh9TzG5lttS5nfYs//GJsOcXhAyz33Uh5RuX37D67qwS3v9blbqtagan6iHkPJ1KE94jTzRQtbTWk7HGsILWNOuHn4j9M7wz771xXV1RxE5DC2ErLPqGV0CR+siC4clsTIeoBRUu88nHcxfGLUXYUbUtaj404wZjG1rsPI9T0oaNki09lD8OvO5D7F0V5X8qQQyDfz+2W2PWiFjfw6Ni8Se3lPLatlPk5Yxw45+VCXOxxIpR+UP0b8v5soPgiBKj/smf9Q857Vo6idVCzgy8S9mYxU+MD8EHj9wxbOwRz5ybq+xr0YZvZDMLokD7P+mpRV77HuuXmoNWMxM2k2yjZq8xx2yBrQm4no/3oKag8pZeaPGFAC6qttQZHVBhOLu5WGZk4wcb1Y1U3+IYkZX4dUhK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB819107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(261009223027099003)(18002099003)(261021135927099003)(11063799006)(4143699003)(261026135527099003)(56012099006)(261026121527099003)(261102123227099003)(261028144727099003)(261022115727099003)(261021133027099003)(261026140227099003)(261021121427099003)(261022105027099003)(261026130827099003)(261021130227099003)(261022113327099003)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlNoazUrZXlCZmJLeldsSjZ1LzgrdGRLclFGaU0rWEg4OXc0ZDRmbkZzSGFT?=
 =?utf-8?B?V0E4d014N3B2V1JNN3JVQ3FHcVA4NXljL2F4a3pqTW8rZ3pLbHRiSkpGSzYr?=
 =?utf-8?B?OTloUStGNDhWdmtHVzFJL1hkQVZhQ3ljRUJrcVR3bHRGdFI4MEFqMWJ1aXJq?=
 =?utf-8?B?RDRPd0Fsb1hYY2lMQmhFcU9FOWVDVHQ4b05QaHBxL1VsSVBZeVEwNWdyNDMy?=
 =?utf-8?B?bWtrL01mdVJmdHY0dTFwYkZHc1JoT3FWQUo5YzJHQXVVbWZPNjR2ZGl6Q2dC?=
 =?utf-8?B?cFNWVzR3K1RteFlhTlgyTTZhbzJKVnR0ZkhJamtoZW5OWHJDb1RHZzloMFNs?=
 =?utf-8?B?VVlKRlVub1J3b2pwR3Nyb1NrWVQ2T3IwMkptYmZCRUkzWVRpaXBpUFpuMVVR?=
 =?utf-8?B?QnlWbWxsd3BBOEdEaGJHZTFIeVNwVTJoVGQ2NjRWbmFta0o1NTJTZjhaV3Rq?=
 =?utf-8?B?b3gxdThOTDF5VkNIMDA3M0JtNGtUanNJOG1FRXlDR3hPVnlGNkVoSkVJeGlm?=
 =?utf-8?B?aVZDR1J5U202ellicHN0UmFLLzVwYm1jWUp1b1JLQjR3aG1MMFNPN1MrYlRu?=
 =?utf-8?B?NHpWb0tpSWtBNkFWYVdIQ05xUjJFaHcxaW52aTVPSjkweWp4eGpMd0hxcFlN?=
 =?utf-8?B?ZkVZZWdWN3l2YjhlbWZJMVQxQkNPbjhQOVRtWnBsMG9Ya0VUUmE5MzNpTnF2?=
 =?utf-8?B?K2taekE5clpWa1llbkUrOFNvdEhJWWZyU2pMTS9TeC9nMHR2UUxIdDBPcENn?=
 =?utf-8?B?ZUd4Z0VEUDdvOVBIUFBzK0VUeVhHMjBFdUhLelMvY0hRZ2pWM0Y2UEZpNk51?=
 =?utf-8?B?QncyUTZJcVVUWWN6RWJUT1ZNUHRVVGJYckh0WUsrOVV3Y3NWVkczKzVZTmhx?=
 =?utf-8?B?bk9jUXllZzZQTjNEOXU2c3BmSHFoNjBWeXZjdGdWZVg0ajd4V2xYSXJyaThl?=
 =?utf-8?B?bXJJRUlTME4vM3RzREdVTSs2a1VwZ2Y5bHdNcFErRkp4cWVrT1JYaHlvMGNJ?=
 =?utf-8?B?ODFWRUZTTkNDbHNLYWNoVXpod1BjSFBob0VJcmJOTnZnV2NJRmRBajJZbmk5?=
 =?utf-8?B?NUlzb1Q4WDJpWXdhMFp0R1N0UXh3OGo3dW1nM01RQWxYWjdzajZmYjVtaHBS?=
 =?utf-8?B?aXpEeEJOQlJXdUxwWXVlS1IzMkZXVWV2MFNDSFFjRDU4c3pPU0tZYkR2Y3oy?=
 =?utf-8?B?dEdnempYS1hGcUl2RXc2NDd1d0xmTi9KakQ2M1ljWjdobVBCRldJOXhPMUtu?=
 =?utf-8?B?QUppaCtUcjU5ZnZ3Nm1na1hoOG4xcWQ1RGxCRng1ZlU5TGhSTmVzck01ZHU0?=
 =?utf-8?B?bnBvMUtjVkFpa0pjdklXQlhqZlg1anVWc0dCNXdzZmlyU1FPTTVFck9GRlVG?=
 =?utf-8?B?anlXSjU2a3UzRjZVc3FRQS9kWUZkMzJUZHVjRDZJbXRLQzNXSXRMWkxXaGJj?=
 =?utf-8?B?NjFvNTQxT3FCWXhMWlp1WStJdWhUK2xYMlRiVWtvWHRVbGJTK2lJYWpNQXpE?=
 =?utf-8?B?VXFsV3k4T1N1ckVncW9PRzFNUERpZlNQdEJTQjRKd3V5UW9ROUQ2R04raXZE?=
 =?utf-8?B?UjlZMTNVdnkxOERaRmdXdE1ZSERWTGpDNFplWmRJUmJJMUdDdFdkWklJM2hS?=
 =?utf-8?B?US9ZbU9TNjFPbmprTS8wQlBEN01NTnB4bzhaclowVlkzQi8yN1RsTmQ2QjBy?=
 =?utf-8?B?OHRkZEUrU0k3cVZsOE5QUDJvM0V6NE0yQXpBaXNMbzNRUmR6TEpiM0dFNnc1?=
 =?utf-8?B?STFITnRIYWpQUzBMbmFhNVYzUFRaTHpJN2dHTCtock5vSWpPOUtVcWo2cERZ?=
 =?utf-8?B?YmFFMWtXQWR0TlA5OHhoNjFIaGdqSlhnK21mbGlkOCtGSVdWR0ZPNDg4bTFR?=
 =?utf-8?B?VUE0Vno4Um9SRU5VdmFoc2lqQkx0L2pWZ2VCNnBkTUo0VXZIVVBPaWloNWFO?=
 =?utf-8?B?azNVM0NZY0hwMmpBQmlqRWZxV3d0UC8vVThLc3NDa3lscEZsUmg2ckg1Z2tK?=
 =?utf-8?B?bmNQVDVtYW5IS2xYNmNrUUdwS1pqUkZPMkZYaE1ESE5Xazc1RFFoTHUwVHV3?=
 =?utf-8?B?R2NLeWNWdG9Id003V1hXdmZRZldvSUwwR2kzRXh4SzFDQ0svQTF4UmhlMG9o?=
 =?utf-8?B?K2JzalUrVnRnTG9rT1ZCOXFWM3BXRWw0MlNiWVh6Uis5ZGdXeEJJYVRUZjM5?=
 =?utf-8?B?dkNDa2tYSXVZTytlUEdxZzRiNU1lY2xVTk5FcE50T3RUN0lxMXIyeHhrZkZL?=
 =?utf-8?B?SjlTLzE5QlhTQkdrVDlQOXNHRDRkL0Y0SzRGMVZjS3FLN25OMjJCS1NEcGdj?=
 =?utf-8?B?RFV2NXpxbkZlWldDTVE1cTFCTDhZVFN0TVNpSDRiSFJzZVVsTndKdz09?=
X-Exchange-RoutingPolicyChecked: pMgqjb/o8iWxVJoGk8ENzKjED0yW+pASR2hbBuhe0t2xoUO3RD+EfJVUzHub1K8z1BWvAwuKu8+5zibZpFzvUU5IPS3SSCr1I6e1AW/sAbVMIj5vmZ5U6eKHLRP7HFtgaT8PQOxFCrSDVpNCnh/MWzQ+/IUKjoE/nKNvOO5xEiHHuC1vf2I2w28uAUT3NGv0EUWVh3lh+C+FjDZ2TFxnIw7Tif49jNoDnkhP3RCAVrrJGJJSZRCNlotKUrKU+5AeW6buWZqEcTup22yw4RDF+19Y9e7myboHqAS2KmTkklfB1XpwD4pXtq2+DfCh100UTs00f++oV0DOPweipKaAvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: fac0ea6c-048f-4611-54c0-08df45e02797
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB819107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 01:55:15.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFlz496587+uzh4qgZabCunRSVTZg6oB0zfxxass0VnJm/nOpUgARGYvcKsZkktLKk7Ox4h3fW+Pf0cYXQjG1XPAk35FIUqwFPvDB7P56BM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB020596
X-OriginatorOrg: intel.com

On 11/18/2026 2:39 PM, Jim Mattson wrote:
> 
>> +#ifdef CONFIG_KVM_APX
>> +static void kvm_copy_vcpu_regs_to_uabi(struct kvm_vcpu *vcpu, void *buf, u64 supported_xcr0)
>> +{
>> +       union fpregs_state *xstate = (union fpregs_state *)buf;
>> +
>> +       BUILD_BUG_ON(NR_VCPU_GENERAL_PURPOSE_REGS <= VCPU_REGS_R31);
>> +
>> +       if (!(supported_xcr0 & XFEATURE_MASK_APX))
>> +               return;
> 
> Now that this is called only after fpu_copy_uabi_to_guest_fpstate()
> succeeds, this condition cannot be true. fpu_copy_uabi_to_guest_fpstate()
> has already rejected any XSTATE_BV bits that aren't in
> kvm_caps.supported_xcr0. (That was the second half of my comment on v8.)

I assume you meant kvm_copy_uabi_to_vcpu_regs() since that's the 
function after kvm_copy_uabi_to_vcpu_regs().

Then, the check can be skipped when XSTATE_BV[APX] is set, as 
fpu_copy_uabi_to_guest_fpstate() has already validated the XCR0 support. 
But when XSTATE_BV[APX] is clear, still need to check supported_xcr0 
before zeroing the VCPU cache of EGPRs.

While the sanity check is redundant, the rational for the removal has to 
be documented, So,

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 84d9a71e14e3..c559ae29b916 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3169,6 +3169,10 @@ static void kvm_copy_vcpu_regs_to_uabi(struct 
kvm_vcpu *vcpu, void *buf, u64 sup
         xstate->xsave.header.xfeatures |= XFEATURE_MASK_APX;
  }

+/*
+ * Must call this after successful fpu_copy_uabi_to_guest_fpstate(),
+ * which means APX is XCR0-supported if XSTATE_BV[APX] is set.
+ */
  static int kvm_copy_uabi_to_vcpu_regs(struct kvm_vcpu *vcpu, void 
*buf, u64 supported_xcr0)
  {
         union fpregs_state *xstate = (union fpregs_state *)buf;
@@ -3182,9 +3186,6 @@ static int kvm_copy_uabi_to_vcpu_regs(struct 
kvm_vcpu *vcpu, void *buf, u64 supp
                 return 0;
         }

-       if (!(supported_xcr0 & XFEATURE_MASK_APX))
-               return -EINVAL;
-
         memcpy(&vcpu->arch.regs[VCPU_REGS_R16],
                buf + xstate_offset(XFEATURE_APX),
                xstate_size(XFEATURE_APX));

I think I ended up leaving the checker here rather than adding the code 
comment, but I'm fine with removing the redundant check.

> With vcpu->arch.regs[] being the single source of truth, how hard would it
> be to keep the APX state out of guest_fpu altogether? It seems like that
> would be cleaner.

So, the the guest fpstate has to stay in sync with the VCPU cache.

On VM entry/exit, the guest XSTATE remains in the physical registers. 
When returning to userspace, or preempted, it is saved to the guest 
fpstate storage. This part is already handled, so straightforward.

But the complication is with emulator and VMX exit handling, where those 
registers need to be updated through accessors, similar to how {X|Y}MM 
registers are handled in fpu.h. It thus requires bringing back the ugly 
switch statement [*] that previously was dropped out, or adding 
something similar that is unlikely to be any simpler.

[*] 
https://lore.kernel.org/kvm/20260112235408.168200-3-chang.seok.bae@intel.com/

Thanks,
Chang
