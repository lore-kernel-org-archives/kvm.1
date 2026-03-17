Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054434889A;
	Tue, 17 Mar 2026 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767277; cv=fail; b=Jf0ByzX9PFWP2y3ABUAzbKOI0pXVMuLIsawICUQk44t46xMvxRKGBH0S4cQ/qPC9j9W8QXQv7E9xnm4mF1/4YSrYrfPUq9XPeVoapzkjTeQ00TozMM6BESgcyvxVtkdnJ5Woq8WRv3obsLqoaonaTIo8r6+uVy86D6ApRuDYt4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767277; c=relaxed/simple;
	bh=0pNoLML8U2WJOY/sXv5s6Tz6qZDcjpx4bhwVB5qzUik=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dF3KR9MzxhzbLIB7iqLQ+XoDuYW+DRAU/aXZEGPQj00b9DgYte63o3vX9b7bvBN44Ni7QGR+3Lxd3P/ndQ04Kh4wvb55JeNbZzxjnnxH6kXQc80PKNwibN7Kue/L3L/MTKhPib82x9TIFEeSV6mznNvc0atnQTj6rM4YG/+MO/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETjMZ2pq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETjMZ2pq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773767271; x=1805303271;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0pNoLML8U2WJOY/sXv5s6Tz6qZDcjpx4bhwVB5qzUik=;
  b=ETjMZ2pqoXlZvt9W9d93HlXNmwuwYyFdk2M9QmicpAiZNj+CmFvIvbAp
   zMJHPvSef3pOr4nobxRAz6lX4Mzv2xGSbnrAuXnKHzD7svBGTwkiVfSIF
   9sGDaD/Spec1hiis0lkSaw5pMO3trc4vy8YSnmBdPsyAI2wQoKvRTU8Q/
   dqkYTnJJy1FSVyJ1t8tgxk0wXWvFyRQAN227DNIYb3dhJumyMBe9+9Ldn
   1W+cICCVAY4/WRbsLMrwmOfJm3wB+s8q0ghV3M70ZhwnHyRR2WriRNHPs
   wPbTxH7b0MDy+i6uRtXI6/I2cTbexN+rqRFx/aj4tuqffXu8zxbe+YFEV
   w==;
X-CSE-ConnectionGUID: HCb3A0HHR8a2FOV3YHb7yA==
X-CSE-MsgGUID: vgLJ6ymGQeW9/V0yJIed3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85124310"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="85124310"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:07:04 -0700
X-CSE-ConnectionGUID: KTDk6nBDTF+a+kysOK++zg==
X-CSE-MsgGUID: 7CxjvLd8QA26TXN2B5/1Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226474119"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:07:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 10:07:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 10:07:03 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 10:07:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flTCJ7EglGoWBxwOJg+ycxgapklJ8uDrUEhRuoADGx3aAc1BOLhQ7XZtFa3bMA3w9mxSOJPmYMtwb22IexhcscregwWUFXknpPCJEArtZ/1aLsp27X0HGsBdkDLPOocIXewxO6aw06FxngwiAu6WAZ4rHhFfPUc7zm0qu5gNLOYlaeY1n+hDf8JdYXOMW7KSthI2xeN8uK/EB9JhCxfMmqph5gaiF6GHQkPlykEwniZ0sclzPYNNdN5fGVwCJrvOVZGr4k9nxphi6uSrVXkSvjjp8DPjF1ornBOFvUYJY12006Gl9bKU+FXIxFgz6TSBKcFonM2l5S5MjFiUV7qH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7gjOmH/GZKzhjZSUDM09yTKe54PnZcIfw1juz2Xe4Y=;
 b=hBH7uLuKnSG+d2cwHnsjX6IiaduqkQYXgYrYqgpeqGNk8BZPRVNeM8PS7aIU093e/UqmBseStbJc5orql16rkZKAaDT+8M6A0K++uNkvI7g2sjdy2ts5YpWN/lCrcMbfddnNdRWebZTzMZPrOMs3sZbmgFdo9kN8x4TPiY0l6ECbn1Ov+T9x4D6aP6v09M2EjZvvvPpy6923nI4UZJiX0VulHCT1t7xDTRcLz4Y58+OkIcq5GuuEYdEX4kbVRTKB4lecjA+c++6Zocrb+RjIzx0pBBfjP7d92y0+tMlFIcnf+vv7G8f4ORN/W9iD9Fhw/lqgld5GgkrRNVbEfSc/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH7PR11MB6931.namprd11.prod.outlook.com (2603:10b6:510:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 17:07:00 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 17:06:59 +0000
Message-ID: <4b4c0e17-9860-417c-a6bd-99344f206ef4@intel.com>
Date: Tue, 17 Mar 2026 10:06:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
To: "Nikunj A. Dadhania" <nikunj@amd.com>, Sohil Mehta
	<sohil.mehta@intel.com>, Dave Hansen <dave.hansen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<xin@zytor.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<x86@kernel.org>, <jon.grimm@amd.com>
References: <20260226092349.803491-1-nikunj@amd.com>
 <20260226092349.803491-2-nikunj@amd.com>
 <20260309134640.GOaa7PQJli_C9QATGB@fat_crate.local>
 <cde957ba-3579-4063-9d17-3630e79ea388@intel.com>
 <20260309161516.GAaa7yFMulhdzNQ-pt@fat_crate.local>
 <70644e1d-dd0e-4f0f-81c0-fd095e46e50b@intel.com>
 <7ca205d6-b01b-4ed3-959d-db31a6496d79@amd.com>
 <505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
 <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
 <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
 <cb492a37-3517-4738-b435-73311402e820@intel.com>
 <ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
 <13f67190-b51c-4719-a409-13d813549d7c@intel.com>
 <1439b4f4-ff0c-4b6a-ac86-5c0da2d26cf5@amd.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <1439b4f4-ff0c-4b6a-ac86-5c0da2d26cf5@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::21) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH7PR11MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: d089b561-68ae-4897-9524-08de84479a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UFpe6vZPzj7aGeTDF0tGCdOe8iVZHjx6n+J8g3Q44/UIe1tk1mU4OGFWpAh5NV3916ucNKnwKgOnjZxhbbz61fxSqJBi8nwoB9wXx5NiJu8uNil0bcws9EJmsUNDf4erPthLAJTIdhcm3S92096srS5Nx7nYuxLmq+jB5AwZc4JSKebSYhCkdbJrC765qScNY7oTHX4zisARKnjTTXBMWuTw5h52laYX6HW0HQhw6s68/NVQCx0NcHQpbMhQWiYCXMzfAwgJw/ixmXRY20QBekw6Bd/dSeMU69rzgqfLSU/orX1YiB9AXVIfmyHV4TTSuLoTvsdqy4C5w7ISrnqUJFDyU/BiyV7+I9Rz2VpK3rRQKBN0U8htij5PvXjZ9mLJJeCx7NZtqKKtAj8BjMM1Dnr4P0wOIdILcIncoWgk4FDy6L71GjOBtShhkvPaGpVbGfHOO+1BmYLNCGWXMwrq5xPA7KL1cNDdHQbviZwsOi1bFLIUYVwKz4eleDJ0Ofew47POV8mCd4VmJvIkzfTyYdLEh42Phud6OkdUcEyu1w07UvjAedUVJI1wpaTJfnXoB36vU9LHGNOftA51dKvnOrsclnWMS4rZ+CINyKpUXZECK+hESiJDJp1mmdcqiPBhdtm7MQ94T4oZ0crbglc/F40yCoBihtv5NnNQvc/FJF9AlqoDRri4YaAnXIzYrNe9yuV1hQ2n/AsxRxf1AWubsQsw18QsLW/RR6dN7Gyq7gU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmJic1ZJRURmTGhudDZ2c3c4RlZlczExOE1DdHFza2NhM1NlVFFmMDFBVjdk?=
 =?utf-8?B?anNTeDM2Mkt2bWFYVGl2SFp1RVZxRGNYN0czVm1zOUJwcHNMRmFiOExKNE5i?=
 =?utf-8?B?YlVZUTVBbkErMXhWenhQNlljL25XSWtra2tyWWIyWWYveHBDUVJoYnQ4b1lk?=
 =?utf-8?B?TnJ6S2J3UG1WR2x4dVNERzhWMVFnMmQxOGxUMGQ1bFNxUjh6aUNGMVd6dW1y?=
 =?utf-8?B?MXRsQ2RNWjFhSFNuVDhoaCtxajJnWmhxRjBiNW5WWExZOEVxdEdXa2I2L0tr?=
 =?utf-8?B?Y1Ara2hrR0F2b3lJVGIzcE9GUEp0YjFDUTJWSmJ1VXc1TzlzRFNTZ0lNNEda?=
 =?utf-8?B?UGtnN1JNVCtSTjN5dVo1UVpyU1p3RkpVQlQwa0l5MUF1R2VtNzdtTHJKMlZi?=
 =?utf-8?B?VzdBL2N6M2dSVGI3VDFpaVQ2R213TTB3VDdBRUtBd1BJV0phOHcwNkxjcksy?=
 =?utf-8?B?NjhueWNhOUlQem9yeUM4VEJsWjVYeFU2RjJCRTFwYUN3OXZ2ZDI0K3hYSEFF?=
 =?utf-8?B?WUJxbmNVU1QxRXVFdnpEb1JwMkJOZDZYSDJ4SGZIMkNOcFhiRkJTVytvZVVM?=
 =?utf-8?B?OG9odEhYMy82dUIydS8vZ1lRRUVIMHJCMU9JVjI2bkJySHJ0T0NXQ2FKQU83?=
 =?utf-8?B?OVpURTBEZXNNZW9aMHJkTnRyVWkrRktpRTdLbE91bUExNDUxOGU5Sm1ka1BG?=
 =?utf-8?B?MTExdStwK0FRUm1vSWg2dDQrZFhtZE0yQkQwaE9TempOaGRObjNxNlh4TldW?=
 =?utf-8?B?ZHJ0YllLVkQ2MkhwUUlxVW15azB0d21vVkVINzl5S2JqSm96Vk0yOTdFb2dv?=
 =?utf-8?B?TkZSc1ZHQlpIdzFnU3lpVmJMV3FsT3FGNUpNUXVwKzUwT2Frdml4dWJVZys5?=
 =?utf-8?B?emM3azJrWkp1OGJ3dnVzTDBYQjZMdER6NnI4b0dxdlc1UFVMMW9RU24vWkR2?=
 =?utf-8?B?TDZmRXVQR2VGZWpGdllUSml4MmRuWWkyNldyS1R3NExkclB2aWZCV2lqM01m?=
 =?utf-8?B?R0RvRS9yWkhZSkswRUUvYjBzSzM4UytvelRnMmlhcTNieDNpTEp5dnU4RzVZ?=
 =?utf-8?B?aW9nZFZ3ZTczTFFWM3g2bGRUOWtFN2U3WERVOG1yQ3lIbG85N0xaMXZzRFdL?=
 =?utf-8?B?K0I1MGJEVERjcjJ2dlRvK0pFL25IV0phUVNXYjBZczV1UkdOdVd4UG1DMDZi?=
 =?utf-8?B?djBVZjFDcDRBNnB0UlNmQjhldEFnQTBaZDFPZmw3ZHQ3Z3lzN2xLTm5MU1hm?=
 =?utf-8?B?TkR3c1Q1Q3pxVzRLcjZGR0NTUWFDWjg3cWJjZWRyWFM5cGFXTzJaTmt3YmpM?=
 =?utf-8?B?Tm5Oc3NrelVSMjFMWkFsMHVwS0NkTG5ORFg5VGhNdEFZek9pRFRZV2NHQ1hZ?=
 =?utf-8?B?b1I3MnM5NGMzVzU1cDZObVkxMzJhVm9JSUUxYmZLcUVJSWFCNDRKT25xWmN0?=
 =?utf-8?B?dUZ4bk4zRkZhWUFDTW4vUGVocEpLd2dYbUFGeUJSV1dyekR1WGYydm1zZEwr?=
 =?utf-8?B?VS9lRURMRVhOTFJsdGdtZmxNV3pWZEdRNjRydlhzQkxTQTJ2VlFkcE45UE9y?=
 =?utf-8?B?WHYreHpCcGFwVThYcHJxQ0gyTTJCNVloeGxXYlJJaFh4Z3FVWllyMXpHRkt2?=
 =?utf-8?B?Z1U5dE5od3NKSWpXTGxTRmtJcnNDMUgzNDdsNExSa3hROWhWUkp2RlJ3elpl?=
 =?utf-8?B?cmlidVVkaUsrQUhieUdPa1A5bllsVEdZZnNRT3BWbldEaGxJdlZva3h2Q1Jj?=
 =?utf-8?B?VVBjUjYzM3Y3QTdNVnJmdDV5ZFFKZkdoOHlialh5THBtajVCREgraTdJV3k0?=
 =?utf-8?B?ajNHVGhhUXRubWZWMVc1MUU4dU5OMVBXQ3g3amlCWFRrSkIrMnZCSDhOcWFG?=
 =?utf-8?B?akYxZFpSY3pOVkVia2lzd2xWSlVFOXMvMFF4VDZqNXFmeUpPcHllZG5IS3Fl?=
 =?utf-8?B?dDhWVkxlOFA4MEJHYlNnYXZIUzBEVzNPT05zR3kwc2Z2NFlKNEtXSTMreDZD?=
 =?utf-8?B?b0ZLZ0Y5T0FDSmNNUzliazBYVk5aK1k4bEgvRmowSTc4dnpzOVQ4NHBDYXRa?=
 =?utf-8?B?N2ZEMWU5dm1tTHg1bmg2VmVjZURRSG5KUnNWdUtwK2lGeGJlczZkMktZTUFU?=
 =?utf-8?B?bCtHQWNNZ1FTNVFuejVReVJwWDRZRDZzOEdmNGNBcVlXTXB0Vit3Qk53cWJj?=
 =?utf-8?B?aDhPVEtlUlhXZndoVEtXQkQ4T3Z5WVBQTmk0MEpUTXhpZnF1UHZSdlA0UGNT?=
 =?utf-8?B?NEpURzdwbE5FaUx4cDhwSThqWldRVUFBZE9tWFJ5bDBYYUp4ZUlsRmVHVTNU?=
 =?utf-8?B?cTAxK2NaQkF2WW8zNnByMU1kMWlQTnBQaW9LMStkZFI2TTFVWjRNeW1Qclhv?=
 =?utf-8?Q?C6IbMIXJgmOjbdqI=3D?=
X-Exchange-RoutingPolicyChecked: gEI/ofX+f3wzcCh1fkHxmIX7MwksqJ/ApjF6T+ma/SsI+TAIMflA8A7yTVHhmZIczk3UwmBdNpX2ZO5i8GgPho8ydrOibFEJnNPwdCeINvOiCizx4moDzLRPrnPEPNYhIL8oVuf+LR4mBKqzhEhHpJYT+Vd0pwYMWTogjigvpqy5tpJw7xoEDXQv+TmW2T28xle1ogfScbSBgcHqjWlFFrCg7DhNzN9zywSsan3RaxgOIDnh/jyWtnT0j1w2mpalExcn1VEM8lz3Ld3xmkmOi2GXu1XFd3pDkHEQlTS0GUNi22k2HVbp4T+dV00MTNvZBiTvL/ow5mFK+yjb2L8rOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d089b561-68ae-4897-9524-08de84479a22
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 17:06:59.8860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFKbeqtoytPd57yypNdP6ovwjq6ssoxMlsaHMgLAcrJKF0pxDloIVzMWeGC0/Ip/XZQgxxzWkzHfNBUzyHxyXXY3bw0n2RZ9qqSz7wwtths=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6931
X-OriginatorOrg: intel.com

On 3/13/2026 1:35 AM, Nikunj A. Dadhania wrote:
>   
> +	/*
> +	 * CPUs that support FSGSBASE may use RDGSBASE/WRGSBASE in
> +	 * paranoid_entry(). Enable the feature before any exceptions
> +	 * occur.
> +	 */

To ensure this not bite back again, maybe better to document the detail 
on the way the entry code was shaped out here (or somewhere else):

   To APs, the exception entry code was already patched when available,
   which means those instructions will execute unconditionally there. So,
   APs must set CR4.FSGSBASE as early as possible.

> +	if (cpu_feature_enabled(X86_FEATURE_FSGSBASE)) {
> +		cr4_set_bits(X86_CR4_FSGSBASE);
> +		elf_hwcap2 |= HWCAP2_FSGSBASE;
> +	}
> +

