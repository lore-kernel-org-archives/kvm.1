Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A92373C1D;
	Thu, 12 Mar 2026 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773284272; cv=fail; b=aEJOEIGysXH9XViVpkUuW0Mx17Do2VNgspYqM5Q0owXYHLv8LTSpIGPB56CqIqVLHu2l/v5LlaJVAb9WW7pLAzr45wxr4ZCFe8Dr6c6wNYmgKi0xvqphAnOGk2cZKvhewaU2vA3ENP6BgQ9OYuF7mBKZZsxSDuxAb6Zg3XOvtyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773284272; c=relaxed/simple;
	bh=PHBCbGRTKyOkmIJW/CvB3ZPvymcC16cL7dv0s4zcvwQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ejq3FzuSfqjIFcpXLLtbDhV/l9d+hlmVr9yYpykw2RGNSui0KCG1T+pXFgoMkRVec1s7tjo1yISTbiRUAl76c8S8jAfzXf9R/Mq8fUOWME0MIxWlvW9GvTibSkL8dtZRWfbq0YDvvuBCltT7dYB4ENeYaCtttfJz+JKmg4V6txo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIHPbE88; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIHPbE88"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773284270; x=1804820270;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PHBCbGRTKyOkmIJW/CvB3ZPvymcC16cL7dv0s4zcvwQ=;
  b=EIHPbE88aVPuJtHdrygF5MdEv7m31DcyX8ZoRoT+sPeydIS9uUyLt++1
   8GcRvXcnJ9iSSsoYuMxupQMHg/PMwV1yW39Glgyqbh5vZLQ6TcGk1PXjw
   41fASdGivSGLHmmIVGyg3nU90dOJ7FwUw4gVxt2xXLyqrMOGcj98G/8U8
   1rJ/uMTlwztOwt8JLpOOBOeujCDkDqEsH6IzQGFteUMiO3+tY4MSCp4v3
   Vkt9pAJWsLEpW7Jx+HIQqJSC36KzTFo7S9/wd0hV2OiuFhmwWyUlYk3cC
   S9fBop7V4B6LwSVKELfdaAu8EOzS/msN0qO7x0Qd90UVgo2UWYt0uN6Lo
   Q==;
X-CSE-ConnectionGUID: UScJo6JmQiatGQot5JZvfA==
X-CSE-MsgGUID: TKG5vSnVRP66Hef1XwsHgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74261050"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74261050"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:57:50 -0700
X-CSE-ConnectionGUID: OCJnh2ahQ1O4UFpNyBdOkQ==
X-CSE-MsgGUID: Dlwq3T+QS42VacUDQcJMSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="246136909"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:57:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:57:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 19:57:48 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:57:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmMJawMnzZCsDd/rhCMwEF0Maac+2rV2bZbE2Mek+ZArhJrUwceHbkCcbk9SazHhXETNe1i/YOUNUMvUGwEm8tKAvQPAC2RAtCgsq5dwc5knnpRVHRx0EKY8sTsHJ6U2ZfYeZW5lUxcdf3cJmgz2+bjhZ0D1k8EtZBJGzpUk51ZA/0kDFqf421sCSYXvFrGyjw+LPUvZlEl+O/FZpSyziqUJXrKpbWqIb7AWCJ3HROtrOEFTMW+eAQH3GwrdR5a6P9GkDzunJ32gX79qZDP1pNNJQBBnOm5vDnslK8ckathxbkI18UTUaHvNuLnd9zbXWKZvz6/Kkvnjls45jTGC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUajLNsqn8/4LEAOYvnt1becbG8eM9Sx6+QNzhleMVw=;
 b=JMwWyp/gexnyN9ySWQg5g538JXgSP45WYmkE64oo8yIUZAQsUQYKrfb9B0NGNBIpW001MLlTjXSxshOpQhxdWbYEG6Db1dofEKL+KR6fIT/FMsMrACwPRXb/fvdB5mKd84t1vf7EFiTFjqFL6gsP9W4f1keWA5DY+MhdeABI3tVIkT6/gLsA6td4jCYza/pw+QWt67i5SOu1AWmEMX3Fw38JX+AAqrpznCxaW/cH8fOOS/KJnz2InYt3phG5j5r/CIqEnH48dfvfFNJ0Lf1UrAyb52J0VroHCFygBwY+l4MiC3eU22uGZ4LXL2i2tdhH0LCOHZ6tYQ99Tfw42iUdUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA1PR11MB6147.namprd11.prod.outlook.com (2603:10b6:208:3ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 02:57:39 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 02:57:39 +0000
Date: Thu, 12 Mar 2026 10:57:24 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Huang,
 Kai" <kai.huang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>, "Weiny,
 Ira" <ira.weiny@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kas@kernel.org" <kas@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "sagis@google.com" <sagis@google.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 13/24] x86/virt/seamldr: Shut down the current TDX
 module
Message-ID: <abIrlKJ9o7Qcq6XG@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-14-chao.gao@intel.com>
 <c8b83471fbc98666c5980bf9d4073e956bc895da.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c8b83471fbc98666c5980bf9d4073e956bc895da.camel@intel.com>
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA1PR11MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cb4693-ca98-42cf-b027-08de7fe31f31
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: UIBLDzrp15+nxLiyMQ9Lkpjh5JWFRjNzoDkOYPysTpL32bxPEj/ZQa/tuj3uDbtixhjxJ1cCwUW43St9L86/4OewVr2B4pkHbVuXngQ3MNmt1AD87ILv3ot6VT2QTo+mPFLgdp3U2mu/RqWhCwEHpLYwf5uSnNEuV1W2i9wNtsXyd++GKB3JM4R7jwr2p4uZ41Zz40QYMu2e8aYrD5oMglDt40851koY3AC6UYrkGAdn3Fp0EaIAesne52nkKXvT8MmtQ7eac1wfLNqGTmVS7TvKNpmCk1Zz0HwiyNo4BvLkX0OcZYqQaQlzid7LAoAo9eadFnO3vUnY8gYPiEblp5FGoTugc+2Jh//fpHeRHZUC7Lr98ND9iQ2Tqv0q8AlX77aydm6XfIpHOepsA0s3QNfXx/kZtyt4D4tzta24bmYxs9MloLVm4EofT2HCwqUETbJhcgHgzQUmwH/onFAr/YADjjuLcPuPQGIqD1aW+y9gxdbd5C8/8OZ+cuRJfSQIjUSV3+N8D8cXKkcfclR9WAob4lWPBLXGM64UEyuIbv2kMLASZLT6OQj9n6MberojKSY59uGFJBHzSpdleB9HNjxDvnTdI6u2Y2CI4nO0H0w7IXAVbKEpzJB7jbliUaKkH2BwyPTH7H700pFXLqyD8RutPvvsojrhZ+nUUu0ah0Qvn3le55XL2osxmGeSRL/0flOly6AMgMTcxOIAp/lgy+j1ORZtFWfdCUDZF47DvR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bU1UcF4zQqrQrsO/XIcw9zmizaZKm2OMb+QrZKWBVn++1MoyrocxsEYV5Vfj?=
 =?us-ascii?Q?mGw6Ow/zJ1voM5CDpPZlEYy/n7L9BrBtD0d6+KhahzLscF86D6q0EjPCpt9i?=
 =?us-ascii?Q?olTDzgKcrb1SEEPV7zvWYj0ciIO4mesWsDuQQVd1zzedaSfBQozNFETv4dvh?=
 =?us-ascii?Q?0NrdH4JPEFZ8c/p6sAPd/pjSI2aLDiVoxuUO9EECLdrNmNUASu3kqsGBEo37?=
 =?us-ascii?Q?Ai9pGtcoGkWxcO17tCc0p7+wiBIkT+dFZku5en7ljZh8bCTvnT481n2mhN/w?=
 =?us-ascii?Q?1prRQTcp5WwJcxMOtxeOX5BAi8Fmi7nZNIs0diNcHYECarVnsVwYuTY7oSCN?=
 =?us-ascii?Q?NRQ3XZW+bF4rC8AnRMSeXwdhvTlHnBF/SB9UNjt05ybCBTqwClAVNCKaqYQe?=
 =?us-ascii?Q?UfeQYes4xKCGuwnRjxhuj4k92q3YNJVd97SRCGtKg7OIsfe1YfAhkke4P/So?=
 =?us-ascii?Q?DU8+QAyBqPd3ghV8cF8BJsDUyfd1JIl5tBfEMUTSlix1aOyVWkrtQbD4HapS?=
 =?us-ascii?Q?/i6tdEqwvJls2AmHILGvDVDesM78WYTZBYhlmtKQjwGLlmsxvGesa6rf9mvX?=
 =?us-ascii?Q?2/gNyofKnYcUSLqufw0n+2ZxmfHlbr2835adqVvyt7sicYgZRWgKIF4KlO0h?=
 =?us-ascii?Q?cgW39zgUdKyn/6+Ude88kxlJ1NJe+jP1jcYHKuhppfVWGJuq86qlnmNAb0C1?=
 =?us-ascii?Q?N4vpYYR0ohZKBaoxHzbU2YOYG+YeXHaZinCpQ9104h29q0oAzESy0bqties3?=
 =?us-ascii?Q?DxI5r1TulO5fODChtfAZRhCrSKbZlaznN/ODiUReq/6dI5AKNn7zpzV9mmmn?=
 =?us-ascii?Q?pCDSYyS1PgTOHQiN4oayGNm/w+zyiWQIdN4hC5JyUFLxhpWHHhM8nUqiGdJ5?=
 =?us-ascii?Q?EBpiLMQi2T5LXwpYlHYPU80AH8D5Kyq3y+gl9KbqncZEXdJyCW87fHoA/Y+A?=
 =?us-ascii?Q?S26Sw9kFyKrWKfgd0H95kNwaC24VS/FAhetM+g3NyfU3N/kQQ8czvUyMZyQ5?=
 =?us-ascii?Q?lI+aI6R7PUASNTFqpAzO5DoPb8uvnUWJ2gY61JbV6JiAs53tDdzgFGMn5quG?=
 =?us-ascii?Q?j3kKrpGKnXrnRTBwwOG2gdlIzUVkbwjWj3nUhpWfCCR/tAk1jD6/iTqXqFnz?=
 =?us-ascii?Q?RJprl0UnPYxco73KWUPUP8vN4GYQCLfpsMrK4P+5RG60Zwu8eKygdOxCsyzP?=
 =?us-ascii?Q?Ow5lqvIP7PSk5heZ/Nh7lOkhNoBM53RZqeMoUZ1Rz5R3U+XCIWZzmAoVw0HQ?=
 =?us-ascii?Q?nSu6EjxLZ8nq6zyuSN90jxvBym2fUcJiMrlUTrcNRvfLoP5m4DW2xyR11Hiy?=
 =?us-ascii?Q?U/WEUWvbd581mGvwm/Qln2YeQvnw3S+xKI+TlFk7wM3zI6mU8kvNprFVDKPA?=
 =?us-ascii?Q?ijPTJ2kSESbNRjfYcQFbv6IfUGHfc1FE7yvb0WhvChzwN6OzNPGA5RV+VVEQ?=
 =?us-ascii?Q?wN/C/9KuE7RVf3VzYDtFkXWXQ8LOwWJuDvhGaj6GNiw8qviwYZb6nB+zF0t5?=
 =?us-ascii?Q?+OEZY9c411JV74lLKc2VCtQzaLEBKj8tWakd3WKK5xjUFOgQFq/uN7lh8tjz?=
 =?us-ascii?Q?bW5qckJAnRyDMUQfk9jrgCGe/36b0iLA70oJS4s8qREiZxs9ewjr5T5ZharE?=
 =?us-ascii?Q?Uv2+wvtjCe3yicfxq2qL8NanHSNnbJQBiTsqyXFSgjEugQx76BK+4NdEcBig?=
 =?us-ascii?Q?UNnNdtZLxPd31nPUjShtFVRkUYBSTiw9NG6gXMEWNiXzB88qtZUobINz6/HV?=
 =?us-ascii?Q?72vG1D40Aw=3D=3D?=
X-Exchange-RoutingPolicyChecked: gIeMCkO/xzrQFBVXoilO6yqAYX0FH6V9Bc/MRg/5fqZpQzx2F440Gej/c7ZJdoXEICT4gp3dtzAn5g8DBKPkvGUrT+b+4D6S9Iw0WYDLUN0HH1K+F81+KNASltvyKMbebaJVJa4FwcvFzHAc1/TIdT8glq004nXUgWt7dGTWw03wLhqXGBEy5N6EFn2WOuFnVhTkTcfM5U6MuS1CBDvimy+5nSxDKNgSCgWWjPEIsf/MYdEvsbeii8iN1Of6woSatMm4FNh7xvZ1lsBLhLbxh2DxpRLPwLdOMC6JovncD+/P6mHTDhpM6q34XptZmdsvWmXaxrUYuRzS0K96eORCaw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cb4693-ca98-42cf-b027-08de7fe31f31
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 02:57:39.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENDf6phFn70DnGiGNDktpbOoeG4J8xjhaN7nvDQC6VCY3Cm/cFP5jK+rZ3QRCrdR71JwjLoOsSXB+ixR7n9icw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6147
X-OriginatorOrg: intel.com

>> +static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff)
>> +{
>> +	int ret = 0;
>> +	u64 val;
>> +
>> +	if (!tdx_supports_runtime_update(&tdx_sysinfo))
>> +		return 0;
>
>DPAMT has a similar need to conditionally fetch metadata. The thing that is ugly
>about this is it refers to the global copy while populating the tdx_sys_info
>passed as a pointer. That is how DPAMT worked previously. I was going to change
>it to something like this for DPAMT:

Looks good. I will follow this approach.

<snip>

>Wait, looking at the later patches, in the post update caller it will refer to
>the old sysinfo instead of the new one? It assumes a new module will not lose
>runtime update ability?

Yes, no features should be removed during an update to avoid compatibility
issues. TDX module releases must guarantee this, and users should verify
compatibility before an update. If users load incompatible modules, that's
user error: the kernel doesn't prevent users from shooting themselves in
the foot.
