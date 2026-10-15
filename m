Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD044C678;
	Thu, 15 Oct 2026 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078449; cv=fail; b=GFh7x15KpIQt0POSoWjph8eebN7TNzPTjTDN0g3B/3cKAEV4Cw2qaGftRitNZu0UAkqgFniWgUZM6k+q2/HFYWQKYI2HHqaWa+QX+lhKf01ChIFdiUpZrcK2njT+t3FlEewbIIdQE8X76qsgvk93ZfNB9OweIomODhbbk8E7i9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078449; c=relaxed/simple;
	bh=UHHyTZzHm+gItEcSXJ2uhhmpb/eC1f3lwEWtbGSARV8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CzbVGY8kQjOqxd7oG4R0VxHk5L9lwAFUF+03LVtkk/69t0FVKnO0q9KelnXdKZ7YrwccLzicCLdHcXG3W3XtFvSssDnzv5KQ/nk9SACExonItrffpIGGg8yl2aa/7mnz5DTgsHAY8PIjmpeRY8YcTW7bLGQ4mW3cUpzukZBOFDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRJS7eJk; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRJS7eJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792078433; x=1823614433;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UHHyTZzHm+gItEcSXJ2uhhmpb/eC1f3lwEWtbGSARV8=;
  b=mRJS7eJkxyiBpyHWiGMGNxljOkQA33w1sf+nYuJa7UiN9ov60q92Bj+l
   18kIwWGw3UmwzNJdk9B+O4Fv6yenVsjeC3f58d/Rcczf5sI0WwfY4r8r7
   sft3IKYp5ik7rdTCTqT+dzmLH8W/SMAW/dt86Baz8S1tL/PhuZIjFJKl7
   kmQM96hqD9FfWQrTYTF74NWu371B70CdgCtwi/2l44uM49F3845AMrN3b
   UaIgtVsXyJlLCKGwkoEQN+6MQjmqtnieC4Ip7Q5jIMT7tdk98URqha965
   cmo5zHYWZXFis+t0zGaofDaIiWfaiPaOTKSFmW5SrNnsMOU9QSkvCdL09
   A==;
X-CSE-ConnectionGUID: GXg/Uz02RLmMLgBIsAw5DQ==
X-CSE-MsgGUID: SyxWA1T8SkuWKJ1oxQHJrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="885362"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="885362"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:33:52 -0700
X-CSE-ConnectionGUID: GPucJd4+TTicQUURC6EpQg==
X-CSE-MsgGUID: BBM4yu40SHGzRMCtT0H+Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1777061"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:33:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:33:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 08:33:50 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:33:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZT1TRk9tPRiYba3Ejj9z1x2dIc/qSQYQx4P7BvZOcz2j83VSOo+HRATNXpiF53PkA7ppCK4f+zgnoX5K1dMSDLYFwNIDsOKAqAmMxqE9h3lGHdb3Qrq8uqMi9j7f1V8N6fcijSG2ot8kpRYkS7cD5Y2PM/rhpjYetPCkjQuctC2WaijbeXazweG2ZXznfIpTdu6hmPtSWy9TWuAsLmJvS6HV0PS7FyJGPI/Zr7FHYbzpLVOjTNeIV6eM/ZzFn5kPO2fRN+Ab/DaNqm27IuBhIatD1M0ksRndiOUZ9iZXhAfseeXql/lg/axoiDXwxRsAIRK6Ilbuu0WdGnfI8fdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eObjWzOaxElQ0v9ZwAcBPBqq+KtRCEeIh8KgmjotvHY=;
 b=BEwHdmZx3WFnwadjIpqucktfCsKTvk/hmst+P4zARSMxwfGpq9FoPimqxpCN7pMdvInhIR7KJUYSxcd/QojZ3rDRrwqK3O9Ct71EmEKTGPq95N2oxoPblvY4O1QHoLQBQ5ADXMAX4YfzY4WWJqCnk/WV44gnU/cyqtLKasa7Zza6F3wrsamSyZthr988x6ILMUWcxUerzPr4et9OiJqF97axyzCNxUokH+SlC1yWVYMOCHK+v69oGI+L90Pn6yHD481AHAkpzh68NygggrgKQfVXSd9B7xJEbRWag1wm1txtSAXV9kql2XLJzHoobIkK0k8m92+y5dvRh9XZaiAOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 15:33:45 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 15:33:45 +0000
Message-ID: <6b9b241f-b459-41e2-a65a-2ae0b478b2c2@intel.com>
Date: Thu, 15 Oct 2026 08:33:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/18] fs/resctrl: Add CPU hotplug support for kernel
 mode associations
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <553a9ab0695fcb7a0c1e68737582663d6fb3c080.1790867441.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <553a9ab0695fcb7a0c1e68737582663d6fb3c080.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:303:dd::16) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|MW4PR11MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7c52e4-b164-44fd-f268-08df2ad1b373
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|6133799003|10067099003|22082099003|18002099003|11063799006|5023799004|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 4CrallO/2/ueP7NGTsUpcObqdwtPAubKkeq2VrXQQN6g6H69BjSoULCYDfY6VAWxB+kGfaCNbSAtswFjXlapPLOcYifszbXMulIqkK3HJ6C190Tp8qBE+LTuMai8hMy8KiOka3RxSUOiQfklKkXoSLS7jpVeDDCqo4WblzXLqJDMgnf0YFzKC8VBHIeYmJdWjS4P5y7+ZeHm6gr45pLxn9TQvDnRUIg/Bo9oejnLduHGeF9V9EjIhWS8qx5GJ7OJwGpRdvCmhywSIiK0q+zQxSuPOnH6Qcc72wzHHCEfCADGo5nwb81xQ9rvS2Hi/wepETznKjhs47gyGcqfQFYPBFx7UZu4uUzyhYBcYJ9AjQdHyrinLueO+PApilTB9H0UbGS688+T4flgUnQQNxXcW03cYwVUE0oWGB+ZdokRBYp/N0iN+SuhksDs85X/fZhHg7ZQTEfedmOsouu69QRdei27uqYoUAw7uzaqLO8irPXIx7jFuMdLp3Qlzqk5yby8Iwhh6mx51/z0PmoS2D53wf7+hCUPaiZKam5U0fJsO8DdJyAQT7tfY95Xjb2BpYBramQy/OBD17zeV0l4Jf2C7etL+gdjhM9rJ45GjPjoZGp+XM6P3ugz6l8HC4vhr4lIx/t1EsWSG6CRKuf8rzxUon9h67oasJZDw1R63hsHT9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(5023799004)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NURQVmJvQUVVckd0alVHbjRmUGNFNUJEZklSWk5wYlFXdTM0YXMwcUljbWlK?=
 =?utf-8?B?cjlzdU41QllxMDJZOHJPOUUrcTFwb0o5dDhOL24rOWFyeklnWmZUWGpiREFO?=
 =?utf-8?B?Z2ZsMkhsbTYwRkJGKzBXOFJ2OTJ3T0NCUXJUUWIrMVZ2emt5SU5FaXVFRnhi?=
 =?utf-8?B?QnRXWnVTVUF1amdkZ1FRcUx0UzZwT21OQ25hMGwzS0NUNWo4WXB4NEozTFdW?=
 =?utf-8?B?VkNxRll0NDFLR3pmRldOSkczYVhTYVVJY0N5WHF6NGhxQjVkY1ZZWHl3TlUz?=
 =?utf-8?B?WHMrN1J5RTkzVDhLVmNGRG1YbEhyZnNiU3hSamhJZmZ1akxBejBXemFtR0px?=
 =?utf-8?B?bytZNlArOFpTRDJJQnp3MmVYTXR1OVFUM0VEcFBJSkw4V2Vaa3FvR3dwUnNG?=
 =?utf-8?B?MTZTWkRHbjVlSmFiamtGYkVKeVNPN3ZpWmlRbkhubWx6TlBybEE3R0xtcnl2?=
 =?utf-8?B?SU15VzlQOFhvZ0JrYnFjcTVqTEx4aXBwZ1E1cG1HWU9LQVJsdEdPNmFXM3Zy?=
 =?utf-8?B?NUUrdGZkcDVQN1hmWGY3L3JUWEE1c2c0OHA3dmVUSFJZUmhlYm1sd3FodERX?=
 =?utf-8?B?eFhxMXVXS1drNEJoaUx3djlSb1Rmd1R3dDJycXZSTFNLblN3OHErTFlZcW8v?=
 =?utf-8?B?ZWhGd2o0ZWtSWHcxK0MwU1RzSXJKVnN1U0Ixbnp3SVVDNndXb3I4UWtsTHdp?=
 =?utf-8?B?bEEvTnAwZ1NmV2dOaVVZRU1JeW8rcDZqc1Fzc00zL1Q0Sk4wS0d3MjdadGRp?=
 =?utf-8?B?R2NyQlVCWHRBZStaL1V5Z1duTmlxNjRqanFhRnR6NzZJYlpYUzR6N1kwakRi?=
 =?utf-8?B?em9Da29SQlFHR1NSdkZ6T05MVXpzbEF5M1J3U0Y5R3k3eExLQjdkdzIwbnJj?=
 =?utf-8?B?cHVZam1wNDZiSFpzVVMzcmZHcmppM0ttQ3VJSnRCaEppZHBySzVZRkFVV3k2?=
 =?utf-8?B?Uk1ab2Q3TVhtaGc2UGZNbGpSUG5EN1E0ZEdYSVFTSlhEcWMzb0lhMlJwdlZG?=
 =?utf-8?B?TWgzNjM3NTZxaktsK3p2dlZjbmV5eEp6OENhS0hPZm5CQmJCOWk0Ly9BZUJr?=
 =?utf-8?B?V3FOc253Ujd1dkk2MnhPNFZyWTFXM2EyUG5KZTdOayt5aml6S3hwOUtVOFpT?=
 =?utf-8?B?RUkvNjZQVzVkMXA1Y2RFNC82QkdjTGUzamlGRlJOTlR1RStybVp3TEF2OEE0?=
 =?utf-8?B?RllNM25wMGlWdWVuSy9YRGcvbjQ5Y3UvbXJ1bGJoeHZMdlBydno0SC8xY0Z6?=
 =?utf-8?B?dVBjWE55b2lwUWFWWTVoa0hSYnB2ck9laitLaittZ0ZGdkswdFhCN3o5YW4w?=
 =?utf-8?B?T0NldHJYTWk2b1dLVDVTZEs4TUdnRi9NN1hZTUFFZUxQWUFyZzdJZE5qdXk2?=
 =?utf-8?B?MHNQVlM4ZEFrVmZFaVNOM1FOdm9QcmlJWDNlcWJXSXdZaU8xa2Q2bUo2a09I?=
 =?utf-8?B?ck93cE5Xa0R4ZGc0K3IycVBic1ArTzdBRCtyUS9iNzdBdTUzQ3FxTC8wd05U?=
 =?utf-8?B?dmd2bGF0ZmFvTzBBZ3NCS1Z5VHdzWDJLYmVjUGdMSDlxdm1WZGhIUEQyUUZ3?=
 =?utf-8?B?amwzTDQycUlCZnFKT21qUUZnbzBjMkhQZDJud2hKdEpQOXhKMVZFYzJxRDls?=
 =?utf-8?B?cndTRkRPcnRFMDRGais1aHNseHA5T3djbVBkU1BpSVFaSTZ1NDNzRytwUFpL?=
 =?utf-8?B?RCt6V3NzVzk2U252QitVL0d6N0tXNzJmWmZNblhrS1FuQnFKcVN6VVRGamUz?=
 =?utf-8?B?OWFDNVptQjdZMEhqU3JzSS85MFFXQVVKTU5jRjRLL0pYa3IyaThQOXpYUTRu?=
 =?utf-8?B?Y09ydWswT1VDQjdISDA0QlVncVIzaHJRb1RoSGtHUWdGMERseE5DWjM4UVkr?=
 =?utf-8?B?YUJQL0x0S2pFSG9tWFJ0bndaNWZ2Umo3UWNldWMyV0F3UG1ocTMrZnh3Rjhh?=
 =?utf-8?B?dHFHS3JpZjg5TUZRdGNxbEJzSnU1a2xpVGFyUnFrN2lucHVuN3FYaVN2TmVM?=
 =?utf-8?B?czVpRlZGZkROaGh3YW85Y3NBNGtKRUVKcXF3cW5MMmVXY1dvckszTWYweHFi?=
 =?utf-8?B?YUFiZFJCYVZWbVplQTU1MklKT1RDZlBTbGpKcmdheGRHTWVYNGQwYllLL3Zn?=
 =?utf-8?B?SWNyUU1RRFFEa0lGSXNmZVJJMTVsOEdBWjBzbFdvdWgyU1pENUpvOGduaXA0?=
 =?utf-8?B?MXVWOGFCdXYwd3VQVUw5ckRNd2RmYVpFMFZXYXc1ZDVUS3BFWmJTb1NGcEZw?=
 =?utf-8?B?R2ROYVA5NTBNWTRDOUZLMlh1Q2RzQTloRmovWjU4dWV4MEJ1OThBbyt3R3Fp?=
 =?utf-8?B?c2VIZWh5MzU3djhIUVRyc0hxODdwRlh0ZFZRd3dKOGU1VGU3OHFUR0VPM2p6?=
 =?utf-8?Q?yC25TegDJr+WSRM4=3D?=
X-Exchange-RoutingPolicyChecked: zJ/WPkQ0JmwkLgC5K4tG+6hhfXOSnBb9rOj21/LIW+9RZhUgTP7Qqn984CLixi/pdRG4WkWiavVtWALZd11Z5SKtutNrhZMoCnPcIA3G+1qPdPg/tYUT34rrEVy0W4W9HrJjtZH++WtUBye1ZL1d+lxo6dTCsxd4jLJvRTWejUrynTUQM5Sp102Qem13tGqQ0OjbAO9893tvW4RvzPrgsiD09gYDxmN9/0TVyPbtWOEA6cINz4Hzs5FdaGh27zD5EAm3iZJltEAKQ6aKYy97zAICA3Pu8vc2AM+bzBhdZlDazNkwGWQj/4BlaWyHjrzescnqtzPO1HrL0wIQvt8T2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7c52e4-b164-44fd-f268-08df2ad1b373
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:33:45.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gN34QKVFf3tavhR3duAmuFOBcDqeKEfxtZmO5UToKPc1sFnOV3Ds8otp8+AgpvBq/YBCU3g82PD5joXpPrcRiLFZGHVqz/3NvszCtwXdBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6738
X-OriginatorOrg: intel.com

Hi Babu,

On 10/1/26 8:10 AM, Babu Moger wrote:
> Kernel mode allocation and monitoring associations are maintained on a

wrt "Kernel mode", this is specific to only the "global per-CPU kernel mode", no?

> per-CPU basis. Extend the kernel mode infrastructure to integrate with
> CPU hotplug handling, allowing kernel mode state to be managed as CPUs
> enter or leave the online set.
> 
> Introduce resctrl_kmode_global_online_cpu() and
> resctrl_kmode_global_offline_cpu(), and hook them into the existing
> resctrl_online_cpu() and resctrl_offline_cpu() paths.

Above just narrates the diff. Please check all changelogs to match
tip changelog expectations. So far they are light on context/problem/solution
and many miss an answer to "why".

It deserves a mention in the changelog that the active kernel mode is automatically
enabled on a new online CPU followed by why this is done. This is a big design decision
that will be user visible but I missed where this is highlighted and motivated.

Changelog should help reader to understand the patch. In this series the changelogs
provide little help.

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
...

> ---
>  fs/resctrl/rdtgroup.c | 57 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 0e638dc654c1..f5c7790f7970 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -410,6 +410,17 @@ static int rdtgroup_kmode_cpus_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +static void resctrl_configure_kmode_global(const struct cpumask *mask,
> +					   struct rdtgroup *rdtgrp,
> +					   bool enable)
> +{
> +	resctrl_arch_configure_kmode_global(mask, rdtgrp->closid,
> +					    resctrl_kmode.ctrl == KMODE_ASSIGN,
> +					    rdtgrp->mon.rmid,
> +					    resctrl_kmode.mon == KMODE_ASSIGN,
> +					    enable);
> +}
> +
>  /*
>   * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
>   *
> @@ -1114,6 +1125,48 @@ static int resctrl_kernel_mode_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +/*
> + * resctrl_kmode_global_online_cpu() - Program kernel mode association for @cpu
> + * @cpu: CPU that has just been brought online
> + *
> + * When global_enable_per_cpu is active, @cpu joins that association and is

Please consistently use the enum name in comments and code to help grep find
how/where it is used in the code.

> + * programmed on.

What does "is programmed on" mean? CPU is already online.

> + */
> +static void resctrl_kmode_global_online_cpu(unsigned int cpu)
> +{
> +	struct rdtgroup *rdtgrp = resctrl_kmode.rdtgrp;
> +
> +	if (resctrl_kmode.kmode_cur != RESCTRL_GLOBAL_ENABLE_PER_CPU || !rdtgrp)
> +		return;
> +
> +	cpumask_set_cpu(cpu, &rdtgrp->kmode_cpu_mask);
> +
> +	resctrl_configure_kmode_global(cpumask_of(cpu), rdtgrp, true);

Shouldn't CPU be added to mask *after* it has been configured? I understand that
configuration cannot fail but having the order set makes it easier to make changes
later.

> +}
> +
> +/*
> + * resctrl_kmode_global_offline_cpu() - Clear kernel mode association for @cpu
> + * @cpu: CPU being taken offline.
> + *
> + * When global_enable_per_cpu is active and @cpu is in kmode_cpu_mask, the
> + * association is disabled on @cpu and @cpu is removed from that mask. A CPU
> + * outside the mask is left unchanged.
> + */
> +static void resctrl_kmode_global_offline_cpu(unsigned int cpu)
> +{
> +	struct rdtgroup *rdtgrp = resctrl_kmode.rdtgrp;
> +
> +	if (resctrl_kmode.kmode_cur != RESCTRL_GLOBAL_ENABLE_PER_CPU || !rdtgrp)
> +		return;
> +
> +	if (!cpumask_test_cpu(cpu, &rdtgrp->kmode_cpu_mask))
> +		return;
> +
> +	cpumask_clear_cpu(cpu, &rdtgrp->kmode_cpu_mask);
> +
> +	resctrl_configure_kmode_global(cpumask_of(cpu), rdtgrp, false);
> +}
> +
>  void *rdt_kn_parent_priv(struct kernfs_node *kn)
>  {
>  	/*
> @@ -4896,6 +4949,7 @@ void resctrl_online_cpu(unsigned int cpu)
>  	mutex_lock(&rdtgroup_mutex);
>  	/* The CPU is set in default rdtgroup after online. */
>  	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
> +	resctrl_kmode_global_online_cpu(cpu);
>  	mutex_unlock(&rdtgroup_mutex);
>  }
>  
> @@ -4939,6 +4993,9 @@ void resctrl_offline_cpu(unsigned int cpu)
>  		}
>  	}
>  
> +	/* Clear any active kernel mode association on this CPU. */

Above comment can be dropped, it just duplicates the function comment.

> +	resctrl_kmode_global_offline_cpu(cpu);
> +
>  	if (!l3->mon_capable)
>  		goto out_unlock;
>  

Reinette
