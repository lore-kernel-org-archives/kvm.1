Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A92374A0A
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 03:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123014; cv=fail; b=qkIq6HzrkZCZf0bHJlulbtYT2pMJk1y2FtLEQSi0g7jGL1BIROfMwcGORPL46R9DYJ4Psjb4SOxySbISh5rX+tM8uEX776hNsoHTdh+nYOTuQGJnJdZh3sgXqOansgi9hFzwSmRQ0mPqr/5lpHe0/9K+IfhqFrDxQqmwaMfY0xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123014; c=relaxed/simple;
	bh=X3/2ub4a9w+sYBc1uYaRRLp1I3dLLmmgCgcxkNTFDHQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aGcZ6RhaI0XLM67WKtrIr+LORVqBE77yMVyndASHVoioTEGM/Cz5sKpr3+lz3JvXCSe/nxWRT0/uhwEuiFeUIjvZqKZRrboS2yQgGSIkWu+8LjhDLMdY7vQyQCh8khmNNQPpguxYs9o7sNWIJeyuN5rxRbPYgaFKjT/yXZ2u5ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdyntR+m; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdyntR+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792123011; x=1823659011;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X3/2ub4a9w+sYBc1uYaRRLp1I3dLLmmgCgcxkNTFDHQ=;
  b=LdyntR+maBVPbkpoB/zJAa4zJCH7NblHavaaEeeflr6RNMoqiKcdEq1a
   ZwuD/cm5KUtQ3b1L4i50/t4TTro/HIyL98gVVcekx50lL9K8taI8aUikK
   klOHZPB8Hu1VDZG/YOQvAcT5o4im8uIjeTTHf10E1La4hQ45sffE2eN+R
   mf2HKmxMCGIls2R76uOb4j7flvCzUt2cqWGHLKgXYsRCRCjkSEmUJgspR
   /TysLiO+ZS8USEg9ytRaxk72WNrE40gmcn4OWxnq63m/j9H3/v65E1MQ2
   gU5/aVixHzCcDL95QJWyg5Ap5CA3nv7iMGTqN56JOpqVNxuMGwNXtOtOG
   A==;
X-CSE-ConnectionGUID: 6+W3HFaXSPSvGbRnDQE/dg==
X-CSE-MsgGUID: O052/pTZT5qtwxxPzU/dpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="793703"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="793703"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 20:56:50 -0700
X-CSE-ConnectionGUID: WRsZzpdPQf2mNfNcXW5xDA==
X-CSE-MsgGUID: JSeHBqJTRg6BCmh5URpFpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2173057"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 20:56:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 20:56:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 20:56:49 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 20:56:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4IL0P8eaGN+EYFSPsK/yBCvWSYT6oJEwXiTYY4vLc6VzlrBBskYxyyIsTpXgw0cEY5bESBGdRzW2LnQdPkzmBHVOJMxl08Byd9/Xi2HYTCfsADikXzBhu/qNn0HEype6wWkGWHAMaeTo/8hDui6yyEp+j3tbWaCCr8kEmzJM3izn1GRg62bmnroa26jXg2iY3NrL2DQeaiqFjxmVFa7tmLD8+pkmDmk5pmh2exiM6TOY8fq7OADZaa0IKvY89Fk+AtycWCbzAASg8vyX3YfiVftpGxpC8MxkPgNtN2iz1OaspiMZ0vS6Q6zc3gKJYzkHuNyjIeSIz1O4T3EjGidew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgLOK7wg5iI3XGimxw673ryHZIxaqH5FFumvAmmA/Jk=;
 b=sztv/I5q8TrqB5frB5XDaag4DrqrcdaMprEGKHmtj1KOcE33dbggTeDZWprzeeIH5PYxbeVX4w7juJesIqCjj3JVXVyyti5JmRb75iD/sf1D7T3USc+DHY5bJLcj9uZgBIZhNVcI1yrrzDoWIkrkQLNzgp4SbuvAU/ENw4yWMhhM1MSaf5KXbkyv3VT4N9VmTZxFv3FP2wIBvqyuqfILPVCmaTfS5YHXsGi9F/Wse1/IlPoWFl1WXsvIWkTHxTqkbDOkOe0cELWYj7Ygpr17P7ElInwGi2EOjrlkfMAvo+zj/zh4Mq+WKJTq4qECKkkb2WLxrQqcBdu0zJuzUetubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 LV1PR11MB8852.namprd11.prod.outlook.com (2603:10b6:408:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 03:56:45 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 03:56:45 +0000
Message-ID: <48a48d12-4db9-4cb4-996b-8a862aad67ec@intel.com>
Date: Thu, 15 Oct 2026 20:56:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
To: Tony Lindgren <tony.lindgren@linux.intel.com>, Artem Bityutskiy
	<dedekind1@gmail.com>
CC: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Sean
 Christopherson" <seanjc@google.com>, Fabiano Rosas <farosas@suse.de>, "Jon
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
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <asiFmhftFi-Yq_z4@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <asiFmhftFi-Yq_z4@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:303:8d::19) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|LV1PR11MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8a6f6f-9792-410a-2791-08df2b397ea7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: GIcfJ8YkN1KTJRm4OFfBNPNo7arAwYW3lX4bfYA0tEijHIxZokQIRoFC/OcK9cYBNLVjYAraeSFnCnXwwGXDpRFL3IEf8DeqU/p5dvV46Jvqa+GAM4XD9k4ZuXknF9T1WAtwoqXEnOM6DJHvwwPcMby6TyLPCZ/oRbuwsojDNDH0tiHKC+8B5P7V7X4ZS9KSVTQCWfmUrHa69skaDt9JAmI+s70uRyfR6byeD6/R3v2zFz6CW2xiX3gxduLxo0palWo3Mp4mp+tAjgnDjW+JxCCrsOxsqzKDpp16oZbaMVSYnev8oblL7xVfnzgQpdJ1oQXlL/jyWBiRK5278SIc2zuWaifHpjcLpbPjvXIppaFHbImb8FnKbnp1kI7nmKIpleMotOsCxLqxLKtOaAS0l8tsep/4vRlR9QJUpvPeDE+pbmwZhqKGU8Ud5Cpt1/M4MAU/0BQzUnLcrppOQuOR/Ut6CtIw90hQ1zySk8DTsNMdofaw7C1Tsb8Zxs0mB4ULqzrIKbUpCqZosLgZPBsQ2HkPE0wKda4lNZ70PCZksSPqhupTVlI7uaOYb867ngTmXXmiimqirpn10bikGNmsJdOuzJSCeKPre1XN/eQycI7OD59bkkt76MBybAgQbpkSQoUpWyrnY6AMRwV94TdkTpHkxk0aNpmMDnUa062n1AU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkppdjExdmJEZVdEeWVwc2lHZkpWVERsamx5NTY0Y1hYMW5YbE1hSStaVk1G?=
 =?utf-8?B?czlSdEdpRy96Zmo4dWxPd0JQNERIV2tqcTlvRjBtWkhybTJCZ1hoZ2pCOEFB?=
 =?utf-8?B?bW1UTkJVV1V3K0VmbEk5cXFseXM5RGtlS0FaREVSdWlrQVJqSTRRVjJCK2Vz?=
 =?utf-8?B?Smh4TXEwaERaTmRFaktYNWdQcnJjSmhmL1A3MndORkxSZHdQbjJQU1E2WHhI?=
 =?utf-8?B?OEFNZVUvdnF0c1RXNmwwbklTWlhhTXp6aElrMUVEQVdmRm1qbkpUamZYMHpz?=
 =?utf-8?B?dE44ekJZK1pMWTYvdFFhQzBjeE1mc0ljZE5ldHl0OWc4eHRtMVMwWUxaWTdp?=
 =?utf-8?B?b2JRbmRRWnJHb0RvemlTQ2U2TmZYYUZtUFNnVXBaTmRuM2o2dFdYZ0puK1pC?=
 =?utf-8?B?RnB3VUNNbWwrWkFnbXN5MnpDWVNzUVZiNmxFOW8xUnVLbnBIRkhuSFhIcmpW?=
 =?utf-8?B?a3hXelRQdUdhU1RHU05PSWdZa0YrSk56bEJvMkxJQmpiSjZrMzEyaUxHU09Z?=
 =?utf-8?B?UnlFK3BPTjBpdzJXQXpqMHlQbnpqTm1wcHJKTyt1Vit3ZEl1U2g3MG9rYXFu?=
 =?utf-8?B?L0MybUQ2VnQ3NkRkSklyM2FaanRWakV3Y0E4MG5oeWRGejF1TzJLTmsvWEpV?=
 =?utf-8?B?a3FWZ3Q0UThQVVlTVndCcVl3bFBBKzJsUGg1a3lDZy9MV0JBK0J5eGk2aGNV?=
 =?utf-8?B?MkxzTmlEZi9CNkRrbDRkK3lJaUR4T2RtTVlmL2lTYmZkNU1vQWtGaXJYaUVN?=
 =?utf-8?B?cHV5ODhlNnN6UzlCUDFFZG9oZjVhajUwN2gyVk9xYlRBMU9UN1VEK21pQ2M0?=
 =?utf-8?B?Vncyc3A4OGRKeStjSVhzTEk5M1Bsbk5YdlVWQjRRRWpOY09kZk1Gbkx2d1hK?=
 =?utf-8?B?VkNTVnN0b0xDUS9nbkZaSWd4UU5qMC8reXloYkl3WGxVazZZSTVmcWczUlZ5?=
 =?utf-8?B?UWlZZndqbTlpYk5hbDE5S25kYmpNTURzNkQrZVFldnQ5bzNpQWQxM1lzYkZT?=
 =?utf-8?B?aHYzZHJ2cmRpbEpQbDhRdmlBTG84S1NNOHNSU3d6SWQ3M3AzTkRZdXdZNllr?=
 =?utf-8?B?VGU0SWE1YlUzVUtPRTRBMWlDYjlpSHNkNkt4aHIyVWV2enFGTUkyR0s2MXJz?=
 =?utf-8?B?NElENEVPangwVWlzTlZwbG12UzhRN1BtRGgxLzdXaEdWTlFib1lhY29UZjdR?=
 =?utf-8?B?eGpNbWRHa1pmK1dwa2MrZTU0L0F1cFJvVFl3bFVWcFppRUkyU0RzdG9QdEw4?=
 =?utf-8?B?N3NpVlRSQ2R5YVRqbkZ3dkhJU296RTBnYnhnZ3dGQktHL0pteHFyZ1NFV3Nm?=
 =?utf-8?B?Yll5QkhtNXoxUWVPMlQxb2VUUmZ6MDQ2L2N6cFkxT0MxWXJRRXhiclZpSHY5?=
 =?utf-8?B?aDc4N0RWZzVpNzFEOGNYdlhMc0xsS0UrdEpGeURhS0dWWUVQcytaV0ZMM1cr?=
 =?utf-8?B?c2dKYS84SXZGcldHTW5yS3JxWVlyY3A1a1BBRE9LSUh0Yk1McVdDM3V2TCs1?=
 =?utf-8?B?ZlZhMzB3cHdYNDVpN1V1NWlJbXVvUnlKcTJRQzUzRWZKL2k2M0VQd3Jnbk9I?=
 =?utf-8?B?Z2FFVXNwWE9VeVhETG9oakl3aHBETFE4MUpSNXJVRkZ3OVdLYkx4Z1VqQVZm?=
 =?utf-8?B?eTdudTQybEM5QWVUYkYrZ2RheUdIdkxweVJiNU9JWmU5dlFhMzFuMmtFZk9T?=
 =?utf-8?B?WEZIS1AramJ3UFc2TWVPWis4OStqMW5BOEpaTTNaVjhaUzNxUE5mSlJoakJr?=
 =?utf-8?B?ZjludHU5Z0ZFZGJIUmR6ODNJcW5PcHYwcUlGYmo0TExwVHdUMllHQlNpd3Y5?=
 =?utf-8?B?a0czWlRmWWtjd2E0TEs1Znp5L09JNlJCaUtudmNEMkVrdVpudjdHQ0x5RFhw?=
 =?utf-8?B?OXYrVlNzQ2kxSFNGVlVOTGkrUlV4a2hqcUZ1NXdhcW8zbTdoQUVzTjFBNThr?=
 =?utf-8?B?WGJzYnM5Qk5WQ0tuMkx0Ry9JKysya1N2MzI1Ti9LeTI3T29wS2JEL3lLcTB1?=
 =?utf-8?B?UGJSN0JoTG9ObnRobzd3V1pFWnpaazdFZnNySlJyVTYyZFBpaWV2ZllIcHY3?=
 =?utf-8?B?bDJ4R1RKWUlsT2lRUWIwbU0yeDJnOWJuazhsejB1UVE0M2dueElXSEJUalZK?=
 =?utf-8?B?L3luV3pwb09keGNoekxMS2pBbTRCV2JYR1ZJRTFOaHZBV3U1eWpHVTBIMC9v?=
 =?utf-8?B?Zjc2ejc2c0Q5N3pTQTZ1TU5jYis4ZUJzK204K0tWZ2lCLzQ1d05FM0xQTFdL?=
 =?utf-8?B?R0JXeWhuRGxtVWhWVFQrdFAvYUlYYXBqaGNxekhhZmR4TEgwSzQ2MmJqdFVR?=
 =?utf-8?B?elBDM0gwaitNT0RPOXBJVEU0Q2VIZW42K2pXN0xpSkdzekR4OVpPZz09?=
X-Exchange-RoutingPolicyChecked: SABMExan+g5HeCxCLprfLeHTm+1mklUzV4/J/7B2SLeqnfYDgPd8iq/AEgWB8qhzbFBn9s51dKWxdyeM3IF1R6KTzu7bCCy5RdA2q9PNKQg8fuLMKpPLo0o9wQGyvU5rvnJv84mK8CJlnVSSFiPlZmDkOf7hs360c896TfxGKdVuVU+Z3uPdz4NcPIXjy9kB5STKUMlyyjPYJQ378HUWxFVsRWsnwOrz+QPbxhfTTsWgRYge7iPznC92GNYfENYqNsoGGWbO16TDwjyZ++6ZOhGtCcYD4wixofeM+hzEF3sK5bL+f6d7JTifkTGQ9RM3ieOLLFji7tcvQ8CM+DdEPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8a6f6f-9792-410a-2791-08df2b397ea7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 03:56:45.0288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1mnbwL+GQYUOoLIZxGqDKE6dzg78dB1L30lY82BnCGCwxFBddpsCWhxck1eZnvBvKjurjM6gK5B2aRGE7YLcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8852
X-OriginatorOrg: intel.com

On 10/8/26 11:11 PM, Tony Lindgren wrote:
> On Fri, Sep 18, 2026 at 03:46:32PM +0300, Artem Bityutskiy wrote:
>> In general, I feel like if buffer size is not enough, the uAPI could fill it
>> with as much data as fits, and communicate back about what GPAs were
>> exported. The caller could export the rest separately.
> 
> For the "communicate back about what GPAs were exported" part, how about
> we add a u8 status array for the GPAs with the following generic values:
> 
> PENDING 0
> DONE    1
> RETRY   2
> SKIPPED 3
> FAILED  4
> 
> Memory transfer functions can report how many GPAs got transferred
> (DONE and SKIPPED). A failed transfer can return an error and could
> also set the FAILED state for the GPA entry where it makes sense.
> 
> The status could be also stuffed into the unused bits of the address
> if that's preferred.

How might this information be used by userspace? Thus far, we haven't
had a need for it AFAIU. From the userspace vantage point, the call
either succeeds or fails.
