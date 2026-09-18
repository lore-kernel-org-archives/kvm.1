Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDE4175A64
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 04:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789706007; cv=fail; b=udCcZwMSHBcaBoKvsHokw7F9EZ2cyMiLPgRM7osjKNWw76ctNExGBSWfWkOCx6tz+CL7ym0L5PNzTbvXcEw53/0YOY9fO3WN59d4pS04S9RczgwlfC2m/eEa1Tf7VvRnx9/kcf59BhIlC60g5Qnl/ZYV7O2v6soPX/mTy+AyVzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789706007; c=relaxed/simple;
	bh=JyhDizdOpgDVxx/8XmdUE8fsAHZbP+2ova4YRs6XjKg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q+FjIwCaJt904p1ZuvDYrxe7CIjEuqvFDBMg1pquEqPIBZdUdHIBN3Rf/+ReGcVPvAnkRMgMVQk9uIFNJ805vTTXNC9TLpG1CpsKH8tARue/EZdjsgZ0Bqyv6qvDx76RZzLsFUKGTaWh8Y4n3pO/GmxX+we2Lgnh1hOzpNA3QPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eP2udHtR; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eP2udHtR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789706006; x=1821242006;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JyhDizdOpgDVxx/8XmdUE8fsAHZbP+2ova4YRs6XjKg=;
  b=eP2udHtRt/jiFW/GFTsnN8e9I+g/cFFsgZ/9bNN+Lvs1b6T+saLKZk8a
   P9FvSnBATwBHgLIJXRrncVcld+Xu/uydY59IhvbbGJe6DQ07Nx+ULgGiw
   +xepcoPi5BOffYcxVgdy9aFH+tlsJiCgwMLWIDOGo2k8isc+XyjQ91K4H
   HzynkP1UBktjVyHlia5fydf5wl4F9M8cszinMGLHgSqz0EVP9LMMoXsY+
   BkrveGXYBzvh8IJrWXckWBvbvrkghp2rriGmiSvvOsFyewiDZ5bhjboSU
   XK8kkZV22wr21tqwOkp3CU3rDryWsS9istFHGWimCm/5qXzBsWhdH3yMw
   g==;
X-CSE-ConnectionGUID: VhuJ0cN4Q5aaRC31aPRU9Q==
X-CSE-MsgGUID: ck4/vEuWQHaEcSRWNFqDTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100848812"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100848812"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 21:33:26 -0700
X-CSE-ConnectionGUID: i9qzwFF+TB+rekyq4RjJKg==
X-CSE-MsgGUID: VRGreJ4cShiitkaem8Khvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="279427335"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 21:33:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 21:33:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 21:33:25 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 21:33:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hONgtqkORf8MbcdlEFBN/aQUwaavv64CfCipyp1Dtk97r6qo9nxPzqzzENFepE79TG91O8laYO3s8vYDB63Sc17yub7x9Os2NmgNA4+CZ8ZUaOi71IUXr8yuU0xG/tHtehLZd207R9BSW+jjVwlTgpKX2117xaeOSekHOvGqMwPRtUW9seqg97NBglD5o5vweUVXlwO9xl0AvsPo0v7uOfS2VCDqJ3bYIdehPCrkSiiJorHvFnQsjn+Wu0+GdkXcScsf6IBIvUf8ElCNszKHMYMHmvP1QWXj/T1+QyWH9i3lM3XFkPYmy/MiFePcpo/EQobrReFyu+BLYSdtqrvRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/SzxV7CJ/qehiFeBN3Lc1mWcXvjKkC2sUM4AKV0tUs=;
 b=yRNjdNss6SdX7WtK7pqwnrBf0lGNP3DLTgceLQJ/TFCrKoe0eA4xeTdUFzEXtGhPU/uF0PtmvqzI2WZcmCqQY7XTw6N12Na8/QfkyL2riUOihBsyWRXf/y14c9ktKQ0PXYBf7nVoYPb+ifdNRVc+TbTZiJ+nVlAEM9uKWwPOk0R/CKhfT2IgsKC/3bcUdel5JP6HM4ra2LpW7OQB04EJ2tEgIArVEavb93noPxg6Wnx1xIWxMJQ1mIc0zOPQmPhAS5JHdmjxEWXKiKbKiQT4Nv8gH8nOYslUjYIvad+og5xwSDK08F7nAwHhQrcRDHudTrxeG+qvytFPzOQpI00RCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.13; Fri, 18 Sep 2026 04:33:21 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 04:33:21 +0000
Message-ID: <ab3c9e32-ab34-49bf-937a-4d3d736fb4dc@intel.com>
Date: Thu, 17 Sep 2026 21:33:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
To: Tony Lindgren <tony.lindgren@linux.intel.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
CC: Peter Xu <peterx@redhat.com>, Artem Bityutskiy
	<artem.bityutskiy@linux.intel.com>, Fabiano Rosas <farosas@suse.de>, "Jon
 Grimm" <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup Patel
	<anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	=?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Vishal Annapurve
	<vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, "Kai
 Huang" <kai.huang@intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Peter Fang <peter.fang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	"Xu Yilun" <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20260831071304.762939-3-tony.lindgren@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:303:b9::12) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|MW3PR11MB4748:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e52ed78-3d64-455a-fffb-08df153df85f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|18002099003|3023799007|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: QBK2bE5MVN2p00ZJwhIDvwM4PoRUGf2UjsdTJjyKzxHmgHDJKfu23sJj4NlCMG3gvql3NEyCOz/6MgsMME1ZsOGBEE1fLc4LReVxKLaB5uihdwsgAdQdlL1MAj/BLqVG07hLvd9qAnIMarixaK+VrgsQOkdGSMy27qkbICnFBjxpJOGfk34I9qg0Dly415cDOqfZFPKPOKrnTmgQUGziUCCqYgJZT7CfQJ266OwPVl3bPMhjiFgg0ge0041VjG8rY+G1hpiecQ4kQEhYosiTpJPzwF+I3s9Z1M52eBqG6MIsojl/VeFZqPcoikMhE/3Uv/FAXypP2opmci+El3wQQElaZ/ePCu6NN2lFxEX+QftFcZxFB6Wiv6F/3f3ovmcxer4VeEtiP1X6gsx4f55fPDQcAK4BGd5ZzjOMTeQ4YD+u0Lhd3mC0LGEGkC/lyd9A5sBoSXKk9y/6mHLUYdnOWjn/OPawAt3KpNFkTSrrCJglewpSVUh3hfmNxFbR8g5IrOFLm84BgSzX6hlezypNpcwT5DEPPyMCm1IkBHjGy0NP8Aut+18x+flRR40wHk/cnPy2yfmH4XJcNSgVXnSnrZitnqWTs8EmqKVyMJj46UH7ybUlMUxB1MU7WzHMh9yHWOtc/j5EeoAf9tznoU6uw8ajppqwGr0+iYz5OxBe1E8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(3023799007)(11063799006)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1hYcTVuVEEreDJHRmt4Mjd1Zkx1THViWkdiOU4ydFZIczJVUi9VdS9kV2dw?=
 =?utf-8?B?dDBGbklFS1Q1ZkdZM3haMGZPM0RkMmJJcEd3THlCZmdCWXA2TUVpMHNCcGdu?=
 =?utf-8?B?NllLZ1hma1ZYVi9RV3lsenhScDBNSkRQNkV1S0lwSndaN3pJNjlWcHpRMG56?=
 =?utf-8?B?a2NyY1FPcTFpanV3eHpCeklnaXQwQ0YvbWNBby9VQlJTWHRhcUduRFZvV3VC?=
 =?utf-8?B?QUlZZzBjdFFHbU5ORHhjcVRuRjB4YS92ZVlEMG44QkJKbXRDWHFqQXdoZFJG?=
 =?utf-8?B?RS9uT1hCU0Y0a00vbFhYT0NacEFiUXNWWVo1L3RTNXNOamdORUJiYnNUcGlk?=
 =?utf-8?B?QVdTYi9tbGppNFlWUWRDL1lybUZndDRsNzduQlpJckVjWkZWQk9HaENpakZ0?=
 =?utf-8?B?aEJBNU92dTQ4NjMxN3FUQ3daQmJsaUN0Y3FRNFBydEhwajA2cXdpMlM4bDJN?=
 =?utf-8?B?dVRBQXdvTWlMT2RXY2grSjBJbWpPendTL2Z1SE5YZXNzY2JLYUJ6ZmRLK2pi?=
 =?utf-8?B?VEI0WnZhS0diNmk2d0hndG1xUm5xSzQ0b2FuUnlVNVNSTTJ3VUR6N1htRzdh?=
 =?utf-8?B?aG1EaDhZcDFNK2J3NkFLTDNTSGdSV0pwNGI0K2dCTitWeHZzaDdJY29uL1pL?=
 =?utf-8?B?TlF5eUtYallHRXpERjRQNW1zYlhWTGM0VkhYRFdvMHlpNzQ0ZXlKdGdBK2JE?=
 =?utf-8?B?emg5VUpqYlBwTHh5MzhxUXFNWnJLRkU1TTBmcmZHb3ZGK0JYNXhTaVRVY3R2?=
 =?utf-8?B?TGdOUXpIdCsyVjhEYWVDVGlWaXV5YkV1V3FGUWpaMXZuWkZVSEdLb0RQeGdK?=
 =?utf-8?B?dWN0VXh5bVJZeTJjelVhcHAzRm9hMzlhRUhZOFg0bHpLU2cwMGh2b1JpMFR3?=
 =?utf-8?B?ZFZnUlV5dndGYlFQN3E1YVVhZ1FNcUl6bUFWUVc5TWNRQ1hxcCtabitCMVVm?=
 =?utf-8?B?cEVYbHdRSDZ2MHBZZzVKTkpoMmZYVHF2WHlaMlV1L3o2WElIbXNHU01QN0xD?=
 =?utf-8?B?RW1uWmdBSS92MlZQMXl5aFg2eXVpM011MXpaaTZRdE1FYXRxeGtTUGlWZXFy?=
 =?utf-8?B?WlkwRnNkQXpFaUdmUEFnRno3QU4rUjUxVmdyZUVBUk5iVWV2TEp2K3ZKUlhR?=
 =?utf-8?B?UEpVcjZZNkFHQXd3Q3czYktIaUZMVW10cDRLN2xiQzZ2enlGYkxuU0dpWVV4?=
 =?utf-8?B?U0VIV05UdE40S2NtVmxNdnUzMTQ3ajZmWTVhakVUOW5ORFhOZGdBRWYzWVFB?=
 =?utf-8?B?SHkwODZFNzJ1SWwvQ1RzanpjWWVtOTZkUGFONmJiOWUwOEp3RDdUV0dLKyt3?=
 =?utf-8?B?ZXdVQWlpUzI2RmNQcFB2L1pwR1I1ODR4NmVZQ3ZrVFRGRG9heXpOYjhQTmpj?=
 =?utf-8?B?TDMvaFhpQkVwQi9RS0IrZUFjNjBlVHhEdGpUQWJaNVNQaUVvK0pWVldHeXZN?=
 =?utf-8?B?TkFFZzZraStwcmR2QWZoYkVxdzFxcHp6WlNUakNHQ3MwWHB4ZVVGNDRwa2Zz?=
 =?utf-8?B?TEtLaUJPYS94cFQ5V05zMnpUSEVKNkN3aTJVN3dWRDI2c0dLdkVvbkxSb3Ex?=
 =?utf-8?B?UmhvYXBDVUc0NnBGNVJUMDdWMzJMN3VBcjlSQzV1ODFBc1VmVGdUdWlmSm1t?=
 =?utf-8?B?bElMZFVnK0FGdjRlR1JOWmRwTUlYeWhrQVMrWkVsUWlCLy9HV0hlcGZXN2NU?=
 =?utf-8?B?VVJxcTh0Mk9QTUo3cnlqdzNQc3NKOU91VDJNTE0xR3NXbFQzcmczTXpEQmU0?=
 =?utf-8?B?N1J0dVNzbTNLYmN5TkdRSnhKUCtzQkxPcmNlM1g1Rzg0V0dRQVEzdWN0NzNn?=
 =?utf-8?B?TVlGbFpTTE5TbnVEdWVnZVBieThOYmhJNjNZNk5lKzBWTDJEVkUzTVpsd0pB?=
 =?utf-8?B?Zkp2SGx3Snp6SmQ5S1dLL0I4RDd2ZHlDalpmYVhTbm1oOEFlMmVRVk16SWQ2?=
 =?utf-8?B?b1o1amVHK2I1elRUdjlUZkpkM0dDWGVzZTZxbFNLc0V4TzV4VG5ETDE1MVdQ?=
 =?utf-8?B?NE5xeVBOZnJVWU53cmpDRFZyN3FYeEdwRjJaK2laRktwa1dmdktqNnVpbHAr?=
 =?utf-8?B?cUhqU3RYdmlrM1E3eDVVUmEzZVp5WitIbFBSdXJzQmptQVR0UHR3Rnhvb0Zr?=
 =?utf-8?B?L1Uvcy91bk9Yd01JbnBiYzBUbnVrVE1OWGJhaGpvWG55Wk1iell0UVRLZXpu?=
 =?utf-8?B?UGZKWkYraEtqSlBpZVZEdGRzYXBZbU1XSUxHMnZLeCtHdnIzSGljUjNkdnpK?=
 =?utf-8?B?eXZod1BhRHZTKzZ0Z3VaZzJldWdRQ1VyWmFMRnJTRlVpVmxpZ1AxYjVpek4z?=
 =?utf-8?B?RU9SWFpoZGU4ZVpWcUR3eEhFZGJGNlg2OTg3d2lYOXF3Nm9tNFF4UT09?=
X-Exchange-RoutingPolicyChecked: kb651oz5AjM9B3iBE5iWe11Yjd4wYGMBNEFJXMY1DyW7x3vcaPMLllyIfUPWlymzNX26Yr9SbSVYkoEP8ziXfDsKGQMaVTP/iIj3YJQ8MMI5l7179rrpWtiBniFE5bgZdGoYVzbqaJS8yNUHbC8VBwrbM54ZigO+WUs0NLpFxHFjw0NSnrDTdoK9NgvB5tb8pGygt17uuiUkoD/30XimqEi1ZJnVAo6NjWi1yGoQtyn22ZwcaIr69f2ra1+hJFtptnAZicIo4KPQuLYxe+WMp/9VJLvsgp50SUUisocGn05xUrZPYUHiAWlJNgxmejmxENBQLEtucHQZtcqhzPKQrg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e52ed78-3d64-455a-fffb-08df153df85f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 04:33:21.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boNm/4ooaJsvMPUhgBdNKhBp1728t04Nh4ej4SdSNpWftmH5gGL5OFxGaXv4EvRaQkPJC0zT4y1HE76yKEa9Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4748
X-OriginatorOrg: intel.com

On 8/31/26 12:13 AM, Tony Lindgren wrote:

I was wondering how a vendor would use kvm_transfer_buffer for a command that
passes an input and also returns an output. size can describe the input
length or the space available for output, not both, so the kernel has no way to
know how much it may write.

Two suggestions below. They're orthogonal.

> ...
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 5f6c1ce9673b7..d9291a8a97bb1 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2010,6 +2010,8 @@ struct kvm_x86_ops {
>  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>  	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
>  	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
> +	bool (*cap_live_migration)(struct kvm *kvm);

Should this return an 'int' specifying the maximum buffer size that the vendor impl
requires/uses? Userspace can then learn this once.
> ...
> +
> +struct kvm_transfer_buffer {
> +	__u64 address;
> +	__u32 size;
> +	__u32 reserved;
> +};

Should this struct include a 'capacity' field (u32) that is set on each command?
It would be the number of bytes writable at address.
size would be the input length on entry (0 if the command passes none), and the
number of bytes produced on return (0 if none).
