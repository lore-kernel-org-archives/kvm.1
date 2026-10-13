Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697E5349C5;
	Tue, 13 Oct 2026 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921080; cv=fail; b=DNn9Pi+2UTNDPJvlCKOZZcxrb+NYVdsDnZMp4y4veofw1vPeohAfT8uQnxzk+k9Bb7UYlG5Sx2JvZquIKtIJLGuaglU8qSNjiSEywcLr1kg2y1LSPoqPm+sQx8OfMjrwzH1Shh/rnxV+Jb/kK/0DEwt6BIyHnP2CUEbMiUPEGJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921080; c=relaxed/simple;
	bh=vfS0i6D1XrRXeGyf0QEHTMw8XG49TZCYobjqEMsHgf0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r1noi9hr7pDf/kGiJD7yUcfgJkZ4LEwx9WE6a8jcdsC/do+ZIm+jbzJYeeT21HaWDI+yXr/d33BOUhXUw0us2hpxgKmBGa6M8PAGgaUxsd2KX6LCBwjOIB7Gt3/Ybi8A7QUuL+gOEMj6zO3cZg2e+QuM1m8lffnzq98Qs0nDjXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=geXqzkXj; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="geXqzkXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791921079; x=1823457079;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vfS0i6D1XrRXeGyf0QEHTMw8XG49TZCYobjqEMsHgf0=;
  b=geXqzkXj8iaqjwTnPO3SAidHfsOar6I/BKHeW4fxd972eXGjLcahZMPS
   zQ9ydV/hpiwiEDOQo667dGYp9rbZM4GLNaNXUwHvanqOns2Vrm4ngtUaU
   s3X5P/VjWdexId9yBRAopTiy/V7Dp8p0DGDZYIOtWOEyMug6exkkG2ixQ
   ao1oKQuT/F8K50IrNwKsvn1ZhefZhkdrYWFwHSSgHaGZeh21zQcl1r3O2
   0ZzQFly2F/VatHNKmc4cRn0+n31hj92rclhrfGa2maj8+vnrBo9lA8zm3
   XTuXTHR/QK7sVLgr6kbnXz0gekfQnbUsWl96KvuDPUvS7EKUHBcV2GBOU
   Q==;
X-CSE-ConnectionGUID: Hs4IgurjRTeYJ0jed6cW/A==
X-CSE-MsgGUID: R6qYWORvRzKTIaLOZ6ogvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="754534"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="754534"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 12:51:18 -0700
X-CSE-ConnectionGUID: uzRIceYVRa6oMdQTFVeJcQ==
X-CSE-MsgGUID: Tr6/XxMMSSSLA2sC+JbLfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1585015"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 12:51:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 12:51:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 12:51:17 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 12:51:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5h8USlYt37V6DoHyPz1Soo3ZfvbXyOpugo7REECwbhkpQCeFJMtEeUM/oB9q+P01jZGBrzpxFMkeeoqrDfe3uu3X6mBhI0NCgohROPfQdLiNkrrIsXinOxAC5rJwruUOqHVU05nAjSwXI+322ZFkOmwsOU3CSz5FAp8dknIuSKB8EBsN0Wg4E4Am60/EVZeky3EeRFkuFO9hvBX1hV6T09r7M2wJGBtOMq2XtlMNt7jbLtQa1d/3SzCmQMzzr6K7xe9HBxfxij2y1vVtFx575h/iPZzRZD9CNPRqzBvd5DwaFdJF9jN8lIxOIzpqR4xwZqvdLe8jtl2+QDzWw52Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXrJctX9KgP+iw9ZwyhC6ZVnZeu/Dqn3o6ql8oxnfEE=;
 b=KpbEMnsuC963zBLBk/S/MgFGxhNVsdOHbISCqkhoPdBbfUZaRRsN9W5hTMMnGd54YBx93F97ZjGg+X2Amn7NhTGivCjiykpPFeqcNGoFA8KwSk3rFaVpVCmIk4FrlRmEpSDuCol0PE5l54S+82/qTujSKyQg/1CYcqTQ3t38wLEY2LqunubWbLgkMCdRkTDkaCY2NIv6mYWS4Tes+ftUvqUgXJykuqC4/scHonCC5L6OAzAGbqyQ28KXVWd6e1qmIO/EhU4LzvJ+F5ESdWMFEEmbrdqkEaSi1ZMIabfgne9MDley53E2ere3i9Rv/gsU8r6PVcCOqJNXPtNLcttLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB7857.namprd11.prod.outlook.com (2603:10b6:8:da::17) by
 AT6PR11MB044526.namprd11.prod.outlook.com (2603:10b6:170:110::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 19:51:15 +0000
Received: from DS7PR11MB7857.namprd11.prod.outlook.com
 ([fe80::3552:897d:29f7:e0e5]) by DS7PR11MB7857.namprd11.prod.outlook.com
 ([fe80::3552:897d:29f7:e0e5%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 19:51:15 +0000
Message-ID: <c5c1fec0-8cd7-47dc-9a22-d90c80b2429a@intel.com>
Date: Tue, 13 Oct 2026 12:51:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/x86: Add a test for LASS enforcement
Content-Language: en-US
To: "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Shuah
 Khan" <shuah@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Chang S . Bae" <chang.seok.bae@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20261009020025.4175228-1-sohil.mehta@intel.com>
 <b6cee0b8-c5cf-4136-928f-96cb0a58eaa3@zytor.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <b6cee0b8-c5cf-4136-928f-96cb0a58eaa3@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To DS7PR11MB7857.namprd11.prod.outlook.com
 (2603:10b6:8:da::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB7857:EE_|AT6PR11MB044526:EE_
X-MS-Office365-Filtering-Correlation-Id: b72d7e3b-b9fd-4f85-fb0f-08df29635704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|260925022911599003|260925021911599003|260925021311599003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Hz/1ID5ktqhnhDZRDE5TWXpof7zoNJAOCPe3tZCP9tywW3wnqBfLB4O6TEGxdzwyaS0A31qSyXV0dhy9D+x57JAxE3sRY8AHdSclK86uNFbOziZr5uYRtdEpbrLZuIv/ykl7wRWx7CAzGxO6AYIss5WoidTXBkmdb9CGkT4cW9sy08ceQ4hsHJN6M6PhgZl+Qqbvh+I9UAMwKkAPnwPP7yFuuONXSHGVsKs70Sgq18fJ6HVtRq5ATJf8PKaFHr9AN87RNjU2WaT7/zDIAlDvmW3b4r7gbk6eqDSjewUOdSh6KVIUDOcGQDTJ3nCnCwq1dyDhV6HsliZOie4pZXh8ynpcYZ+RE51WkcireaiMEAVjOxPSMwiLgQZegkq6nOwXsWE8LIApzbedHy8sRdUyNh+1kWkrJ8bawDLtqrNj3F60cn32bFFWDPFOjvKZlH5Ya2jg43DrrcrgD3naLio4rShNEuqOINg3M0+GRNjv9yZ697M7IYGr1Fo4m/Bb+HrRLVnJSF1OfbAyLY7MdkKRWs8jiRdbFeHaHHHTFE89B+PZrnEk8jlbk9NPEXgnHwwHMZZvL4l1yi0zpEe55ODTH6MkCRPKNOrUB37rxoM+cGL9A7G2VgHn23SncJhYXiL0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB7857.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHd5MVh0eGpoZ1NGVjdPdE5qbzN6Y1FZYjZvVmdWUytBZzdZSVR4M1kyWmRq?=
 =?utf-8?B?d2R2Q29kWk1aZjZ5eUprRmFmS3orZm1nY0UvREdhSVI2a25WMWRhNDh6YVJJ?=
 =?utf-8?B?bXNZZHZ0ZWJnUTEyRDZtTGVWakR6V0V6cDZtQktUcmUreGwybHJrZFYzTjFQ?=
 =?utf-8?B?Z1BaTDc5YzBUb3FmejdLeWV1OU4zeU16SnhKR0pXdnZ4NTFBMHZCbngvcW9i?=
 =?utf-8?B?ME1RUkhOOFJmT3ZWSFdEL1FRTDRrdHlrL1pOMmxNRVM1YUJKUWU3cHplcXBI?=
 =?utf-8?B?bU5Tc3RET0w2RzAxdU50UUhtTGU4VkU3ZGpxNEZMYUx1anJ3Wi9La1IxVEZU?=
 =?utf-8?B?S2s0UG5HT1JrNGloWGMxYWNhMFdOQ2Y3Q3pvWm16TGJuYXJmR3grb3NyQ1lK?=
 =?utf-8?B?eU9JV1lua1BYUFJ0ZnFaNDJ1OTRveitkYjlnYzJOVTRTOFlOYnpoRlhyU1RI?=
 =?utf-8?B?ZDhuNlNvTDVtSngrcldMWmhzdUNWSnd5L29nUWZ4dmgvUW50M2IzZklQSGd6?=
 =?utf-8?B?TmM0dmpsM1dPd1BuV3Q2clhMUmZ2cnRibXdxYkZtR1czVXpxSkRCS1FEMjg4?=
 =?utf-8?B?ZXFwSjIwYnJJUzJPWENIQVc2akE4ZldMNVRGdUs4elJGUEFYTDZEekg3YjZr?=
 =?utf-8?B?OWVVMEcwWkRGeld5SW80bCsxMFNRZzBqTUYyN2VpVnZTdDdISUxVOG1ucTRO?=
 =?utf-8?B?YlJiT3lEZ2NoWTlmU2ljOXFWRy9QYUxuOCszZUc5SGpHNEpDeUFvNHMxTUJm?=
 =?utf-8?B?dDMxT2xxc0pQWmxETDZ2YjE5TU1qZEErQmd1TFdHQllnWSt6cTNGOGN5dGJN?=
 =?utf-8?B?d2ZVT0tvcjNNcXZ4MzB3ckV3VEczcThkaTRnTkNZVWNXUmlsd0VWb2xTYTBK?=
 =?utf-8?B?cWV0cUw4T3FBL2hJR0MwYWlVSml5alhsMWV2VTY1bDQxRmc5TnBwNDdpRVJl?=
 =?utf-8?B?VFdYUG02dGlkZW1vcWRrWkVsVDl4cmNhUjVWeUs4UG04alBxL3pSeEdTb2Iz?=
 =?utf-8?B?WUtOaFozRlNZaXBMU29KaW1pWDRqT0pETjh2Znk1OC9GZk55eU9XK3htNDJE?=
 =?utf-8?B?Y2d3UGZ4SlA3Wit3YVlhQjRtSyt1K2tPTVpkd284QklHY0FoUXFRNklGc01H?=
 =?utf-8?B?NGpNRGpUWksvN2hVZHMzZ2FPdTVZdUcwc2lKdEZOckZDK05jT2lWeTJqQys0?=
 =?utf-8?B?RjduYndRUm05bGRTRU5UV1BDYkNjdTJnNWFQMklKckRzVEh5OThVTVNmMHdK?=
 =?utf-8?B?NkVjVDJsdjNLSTVDUzNVWjhLbFlKQnNRcWpFcnJhZEE5NnNwVytrMkJCbGhI?=
 =?utf-8?B?T1ViYlI5RGhIVUNHK2hlOUpSTkxvME9yak56dEVLUFQwMlB2Yit3OVY4SzhI?=
 =?utf-8?B?WmZ1b085K0xLVnFkQ1BnYXRMRkFtN2Y4YW5YRGtYcGFCSW1NVkNCeDFqRjkz?=
 =?utf-8?B?Y3hNaTM4QnpDalVKRmFZeGlZVXpnSytOYVFCVmtTMEdrSUhOTmhPY3FGNE1w?=
 =?utf-8?B?a2lLYVdRVUM1YmtZMnZNZXZYV0F1elhxVDRib283alJhL0I0R2lxaUhtbFZV?=
 =?utf-8?B?VW0xdFo0c2gvUnQyaVVBYWVwQzJOWkwvMGNqRXdNVHNERnIvNHNORkhvRkN3?=
 =?utf-8?B?VmlqSnU5MlJjTEk4YnFpdXRNNHhGTktrQnVDaCtGeDRpdFhLSGpLa0d5V1kv?=
 =?utf-8?B?cHMxV2JqU3AxN1dodWY2YTdGMVBEN2htRTgveVcwcndVZFZkMXBYUzE5UjYy?=
 =?utf-8?B?WFBmczduc0ZHcXFrWU1NZXFaeHRwRVNrZTRUM2JEYS9zM0VqOEZITm5hTFFk?=
 =?utf-8?B?WEFNeG5BTUFxb05KSUR3WEZGdVFJVDJlUnhlQkZocDgvdzJZMXRYV2ZjMlZ6?=
 =?utf-8?B?TGRCZVNnY0NLRHJhS0JGTk44ZjhyRGdqMzQwM3UyR2xiSXUvOE0zR2xaQnVl?=
 =?utf-8?B?WnVlREVKNUxVUC9ycjdwQ0JqSFozb2RDMmpDay9uOEROT09NSEhwdlloQjVo?=
 =?utf-8?B?Nm9qdUVOenhKSzV3bFlWblBKNGc3V0daY1ZIY0x2UDFFMDBzM1IyM0FBNGtM?=
 =?utf-8?B?TEpHOTJzd1RtNlR6bEcyaUpmeTZuWW5BK3pOMFB2RjFkTndYRFhlRlpNdFFk?=
 =?utf-8?B?enpaNVpZTWdOVWk4c3l5bHViOWl5Yy9RYnlBYUxHckxaVkJGMTdrK1IwT3o5?=
 =?utf-8?B?SmRxQ0wyb1NsV0Rkdk85STJOL3NjeW5PVGFoTFJ6Z3dBNzd6M2o5U1FmNlEz?=
 =?utf-8?B?amx2ck95MGJ0N0NHZmFsZDR0NnYvRllxM1RMVm83dDFFb2RNTWdVZFEvUE1Q?=
 =?utf-8?B?OUtna096THNRTnJ4UHlPbk5ldnFldDU2MFFyMVdHeHRhNjFDaFFVUT09?=
X-Exchange-RoutingPolicyChecked: w1QlkV6WIXm9h+NC+7zatS/nYc8xxvTAVKx2loOhh7PeEOo6E2XlrD7aKvC7mIvx9znb6YlMxklvPLKJm/ti4Eb/v0JPG2uthZVDoPEoaTauueT2K1NqfuhmBHvGn2tBVRJ12AiFdHVQ9s/NYWMuXI/U92A+/ejnmdpwOLXWbLcLGEGb82RTVlPfdd9EC65RFaV/uLIcfnH/M91tp9amTOEUjELECCSAywA8QPHkLwTinhe+r5heX23ameQQogFb5MvCJO36dqFcGWaJOBciCpVzhR+ZJOMSosJOS8qoQW0zw0aCtulthzNc+9a5CBjQ8CJic4UxPGFd5xdCUsgfgw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b72d7e3b-b9fd-4f85-fb0f-08df29635704
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB7857.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 19:51:15.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fta5v+lu8Jkaka6IvLUrPTFkLByv6hksdWjX2YNrQCVxs21e0c1UyrFT45AeCsenxg5mhHR1c28AC3djdRDqug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR11MB044526
X-OriginatorOrg: intel.com

On 10/13/2026 11:54 AM, H. Peter Anvin wrote:
> On 2026-10-08 19:00, Sohil Mehta wrote:
>>
>> Note, the CPUID bit does not reflect whether the kernel enabled LASS;
>> only the cpuinfo flag does. But parsing cpuinfo is cumbersome, and the
>> kernel enables LASS whenever the CPU supports it unless the command line
>> opts out (vsyscall=emulate or clearcpuid=lass). To keep it simple, rely
>> on the CPUID bit and accept a failure in these unusual cases.
>>
> Cumbersome, really?
> 

I had it in v1 of this patch. It seemed excessive to do specifically for
LASS:
https://lore.kernel.org/lkml/20260806011536.4172258-8-sohil.mehta@intel.com/

As LASS is always enabled by the kernel except for the really odd cases
the trade-off seems practical to me.

> Here is a set of parsing functions -- tested, even! -- that you can make
> available as library routines. Integrating them into the selftests build
> framework has been left as an exercise for the reader ;-)
> 

I agree, adding them as generic selftest helpers may be useful. But,
/proc/cpuinfo has been unreliable in general. It is currently buggy for
some features with Kconfig options. See:

https://lore.kernel.org/lkml/f6f113b46199d996c4f81fc89858c2f484256418.1774623092.git.m.wieczorretman@pm.me/

Also, (I think) we have been generally discouraging folks to add more
bits there. So, I don't know if creating these library routines is
useful right now. IIUC, Boris said that the CPUID rework would make some
of cpuinfo stuff moot.

https://lore.kernel.org/lkml/20260331140216.GDacvT6IPW1gf003z-@fat_crate.local/

Thoughts?

