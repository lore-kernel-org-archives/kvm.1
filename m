Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792725023;
	b=swZUvI43d2itQ7hhozFRovrQ1TDcaNHvcs0rVLPnBiflNTNu0xnDN9l0j0fJ/WjktXvE
	 z7Ryw6fvtGCcG0t8fuVUSLwpGXT8OGGCaDDTyKrGKGzwXOu6kt9bQTCGvkuHKK+ddMPfp
	 6gpo0cyk2kysWUMZtfLfnHZLI75UfccqUItuU4H88XHbaAu8yG3yiC97dI4BajwfyECb7
	 VpewFWyBabNlj+NJ2VrxpvJkL0M6EH0p8j2nuvtROqSM056nB4U1s/M+cJynGlE5zHmuQ
	 XNTgcCqch4M4bA06EL1VH0/fjsdW5zfFn4lf0eoXlQrhLBPmB4/9GK9mGPgEwQ0jBKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792725023;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:CC:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=seh6mvAWXI0upAluiBAnaVnoRDabDrQIOtkqwfim3fE=;
	b=v5bW9W94tB70WPTt8OCo2nS+aaOYjjL9EgFotJigQy4i/vo/OvqzomxPre5UEiF70ju4
	 DsfdWXCbvEMOn9Fe+JuXhopyvBwyoAGekiP43jM4en05HS38SKvOoi/nKmEpAjRShuAS9
	 bavKZECd+wFNVlHPO3VbBF6zRajCypzjbMontzjVw0jiXtMIZ5imlyyeetFf/64YwODGz
	 ubOoxNHFU4JCReDP7yoYFT9eM3TQj6crEehAvuvAFMDxw6LdWxOug+eWOFmESJ5P7Z/8D
	 UCiGJ6YOWT85SF7fXZiB5hTS54SvGwelSHAJzyIOUZZiPF4uXBvRpsm55R3KmSvL+gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VhF+CTzI;
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF83606A319;
	Fri, 23 Oct 2026 03:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BF83606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VhF+CTzI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792725021; x=1824261021;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+FY05AITJNRp9uzI3vz9uHP1AE96MAPTdem9oDlh5Xo=;
  b=VhF+CTzIrLxUggdtE9KuKgeHez9ZzeOnoLl38SvxLZKUkrPNfqbqS2B6
   nf1qIa1TZeaUWviEqr8phAY3+ptDdLPdOFZbuKZHKgwW/7TK5N1ZG68Bg
   AsLh2eEAiOLu/IT8l6kav0NkH/ZNX7xLi2Ag3aROlTYr4Ehx06zekc5Gg
   9WcNtrSKYK3VHTyx6ik3e7rT7mvWW2J8tZK4UJvwc8ZZxKjHy+6JFH9PL
   Jl5evuP/cpJhODhxXBJK1Xm9gjwZ5vszW40V07i+EPRFPMKQQGmKJ7teW
   1aZS26ytUNa12ZHz0IEeV9vtQ426SK2M3hKmfBjZRGKhkpA9kE4yPUt0a
   A==;
X-CSE-ConnectionGUID: TE66sjOCSmiMpT3FOcd1IA==
X-CSE-MsgGUID: lCMoDcKgRKyzwH1W2h89gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1383685"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1383685"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 20:10:20 -0700
X-CSE-ConnectionGUID: 9rIuU9cXTHevcRHkShYwCg==
X-CSE-MsgGUID: NrZ8AID2SMOhhs44Mq/y4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="5346495"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 20:10:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 20:10:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 20:10:19 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 20:10:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMyd05y/6Z3+UilJK851O6HuSiCvhiKBINNX/NW696TQA7kZAFVuqGe2vrSDDw2dykFvMK0LOU6cheu73ErVg5xedmBznuyQRZIGaBMbv6AiovsfU0lYZtTxtiY2gQBhup2WrYlZlPTuoIfFNCUCSXMQjNMNs9YIbTySFIgM7gWnnLnKooXS+UTX+SpFkmssOZ1V1hvb6joCWXIEESMbgsvPZk1fAiOeUNdAdsmmaswPK2+Iau7GNcKoI6df/kPyi+D9RSBkRjeN/okLeq3ETCp/YyGAPsZ8YPsxTICVY/SS3I7Ul3DQ3FnuYON+HK88rCBLiq6gkkVX5q8PQ/5OIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seh6mvAWXI0upAluiBAnaVnoRDabDrQIOtkqwfim3fE=;
 b=p1wAIMsCN7Vtj4XhJDqI6+vcAGpQgGaii7ya7Wj5M5hw6eopve00u1q2dHZGANS6XwmH0vmyHwjIEtp1EqALUAQYIJfB5LBf3zsNQHZLsR0HvtJnvUp+gxHmKntRmNXt/fcpvuQ9jDNBS46QVLfEFGxTK+cs+yaHyOOGVHkLrV84plaj/LGg/jQMpZ4I0prbxU0HJc/vTmeJ8S9IDXeXRMzrH0AILVUAflL3IO5t2hJpLRGOPWOfzucUhAwISoXRp7ChbEBKVyIhvhgtyeD+0lj4ItZ5gTkn1/f4DkN91hKS/bahawy/F2wimFzXv8r3jtMJCbcvz2RsIU3JeeAtcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by DSWPR11MB9558.namprd11.prod.outlook.com (2603:10b6:8:36c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 03:10:16 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 03:10:16 +0000
Message-ID: <a0f99d8b-b67d-42f3-b76b-90187a0bea5d@intel.com>
Date: Thu, 22 Oct 2026 20:10:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/28] KVM: VMX: Initialize VM entry/exit FRED
 controls in vmcs_config
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Nikunj
 A Dadhania" <nikunj@amd.com>, Shivansh Dhiman <shivansh.dhiman@amd.com>,
	"David Woodhouse" <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Zhao
 Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>, David Matlack
	<dmatlack@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-3-sohil.mehta@intel.com>
 <acc168cc-e021-43dc-8846-ed1b2d69facb@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <acc168cc-e021-43dc-8846-ed1b2d69facb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To CY8PR11MB7846.namprd11.prod.outlook.com
 (2603:10b6:930:79::14)
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|DSWPR11MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ed0b95-4dd7-4dae-1b75-08df30b3299f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|261009223027099003|261022105027099003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Qr/BRDirrH69S/G7LOGhzb1PtOWgAKvL2E6KO4AcbT/kNKSefk59W8GCmVyJ5z8tzNURujPu8gLq8aBFTFS/HXILDCcBmblxYU0YUDIBwV+SoosiA5ADemc0o+GcxLnwucaVt7GA/08F+ZoElGn/bQNtzHUCm2/NrtZ8JZMkYU2cdOlW0S2ZbgguyKFlT7//YJ6J5XN/StT457O+ixUd7L7Z3elhSlm17R5KRYMcaX7ykd4c4AVi8akIY2yAahjFnjHBiZRmYVNXGixRXFFZ37+J3wQ6NUAa+XTWeQyh5XfO+mSjYl84gL1fpcxIvHFFx+py8s6m7tdhEM2aSL8M/9PGG7CGxHRiHAl1qD2SLE1c44Yq0mj2EQqITKVWZvRgjJo6sH1VNnhcteG5vEnG3qy2+8b/JmAIkNjzOnw/QdLQ8MD+8zzlOe97yoFHnPcoTuwhRyejs7VXPMebw5lqJabG3qSGM3nP/77QZCcnM0vnXbYEBhIXZpr8GPF4n2zAAcb3oG4hIi9WXGP6p/dCeE7gj7t+QVREBMLFE0kdJM9eA9BCs7q4ohupa6rYZkQXsW9JiRe2smxkEcTS2SKlFAfiEah7rw5kjiW0bev5qX0THnBiautUbgG+TaEQzNebNbPOZEywf+NgOvYeO1roQ4lQEFc8GlDS3TYHB0epewU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(261022105027099003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW96TjBUTW9sZ2tlRmdEcnlwd0Y1MC8wUjlSNllNc0F6Q1VicGh0SHhhSnZr?=
 =?utf-8?B?UDJKTm8yRnk5cm1UQndJZjRYeVNUVHZEdmVnMy9sZnBNbkNEK3NaaEZsMUlV?=
 =?utf-8?B?Ym1OU1R0VElyMVpGOXlHY25ySHRlcnJpQXNvZkFwdmlBLzJNMnRieHhHUkd0?=
 =?utf-8?B?RFR6bTBndjh5Ly81WXdoUnJoaFkvOGVxcGluZVR2dXF4QWgxYUZBcDB1d0xH?=
 =?utf-8?B?dXZTSGwwSE43NERvSU5VNXRKRjd3dmpjcCt0UW5helZsZGUxTlUzNjBGTGht?=
 =?utf-8?B?bDF3Z0locExlN2ljQmFoczRjR3dKVThnbm9lRzM3WEF5ZVNoMHdHNDVoQVhs?=
 =?utf-8?B?cnBhM3pmR2p1eEZBakpibE4wNStTUkZYOWlzWGpOZGh2Ui90T3hrY01xd292?=
 =?utf-8?B?TEh0UDV6UUVRcTdnbXNUMnQ3Qm5wQUx4bGd6TWRzRTM0UTZHajhLYUNZd08z?=
 =?utf-8?B?MFNpU2ZBTHdWR2Evb1JYUUx3akR3OEZRYlNlV2U0dnNzMzZhMWpybktCVCtv?=
 =?utf-8?B?TFYvM1Z1cVFNZzlwS0xjUUxGQWp4M0FEcUx5Qi92aWwvNkpFZ0VKNVRvTmRy?=
 =?utf-8?B?NitwbUN6RnRVd3hCUVhMS3RWbGd5WHBZd0lHTHVUK29yMGRXUnFwNklLNSsw?=
 =?utf-8?B?cHRCRTAvRS9ZWEhkeERmcEFQdFZvWXVSd2poZGFsZmtzaWIrWkU4ZU9mVWJS?=
 =?utf-8?B?R0VFNUlxTVJZL0pXMXlIRGI5ZWlpdldDNUd1b3MyZVJRQVhMRnNaSlhjWmJm?=
 =?utf-8?B?SGxWdU5RNmk3c3FLNlJvRWNuL1JjakphOWlUNVZoaTF4WkNDZzVjMEk0RFQw?=
 =?utf-8?B?aVI5MnJkMFpsbVR4c3crNTJ6d1hvUG9iL3BEWDN0T1VwSGp0Z2tveUplazdn?=
 =?utf-8?B?VHFTQkJhUytGcjN4eFN1S3pQdWVGVG1sTWV6Smc5RllzZGVhbU9pekNZUHhD?=
 =?utf-8?B?ZEdmVm55L1ZxNHFGTk1hMXpVdlhqM0I4ZW1mK2RFVHVxZjFwQXNGa3FEVjlo?=
 =?utf-8?B?Nmk3WWtMMmFwaVZRbklsWHptUjlEdG9IZXZmSWtMR3BIbjVTZ0dUZXpBODVh?=
 =?utf-8?B?MWhaNWl1bTY4b2Jnd2NSaHpydGExTkQ5aEhwOU5zUUdpVlJGWlNCNjZ3K09Y?=
 =?utf-8?B?U0NHNHlvcFM3N3QrT0F3YkxYSHVHYTFqSEtFZjRIYlU5cHdZK2JEWG1abHR3?=
 =?utf-8?B?K0YwM1Zmcnl4V1dyQjR0alZiNHNDTGtPS1g4SzVXNkVGelcyR04wVjlOQ1FP?=
 =?utf-8?B?YVJJeGwvVVdIdnQ3ZnZ6SGJOTFhncE9EMzRWeDF3VFlyTlpBRTkwSUdVSXF0?=
 =?utf-8?B?NHQrMmNxUnJ0UHZ2cWtqeGNkMDVvaGxrd0pOUENUUTNPWVQ0allVS0JIL09D?=
 =?utf-8?B?SzYzZTBBOUFWL3g5KzQrWFY0RGZ2cVpFc0k0K043NnloMitZbld1NFZhWHYx?=
 =?utf-8?B?UEtFZ2dPMjVWMWMwVWVvd1dTc05HYnN5QTlQcFgvY1FwREU1RUtocjRUK01k?=
 =?utf-8?B?eTRKbiswbC82MllGL1hXQ2VJVElYZTcxRDlvWW5MRHFPSUtTMzUwN1dTYVNz?=
 =?utf-8?B?N2lQYkNNaHNWN2thcC9iVXh1dm02SG95L3hmSjFhN1d3dnF2aUl0ZFdZY1VY?=
 =?utf-8?B?NTNxSy8wZm13MUZQaTdENjQ2Sk9rTHFyVklOUXl5Yy9yMFYvdDFtQ2NScHZv?=
 =?utf-8?B?MVAvenR1eGpBb05mU0N6b2VKYnlucUpYNkdqUStXRjR0MFU5NlBZTkpMTzl0?=
 =?utf-8?B?NDBYRGlkcnQyZ2NTdjQ3MWRMbWxjSkt5SU9JeHhiRzZuYUw3aFhzM3dRRjRk?=
 =?utf-8?B?Q0VMU1hwaXhJTTNCcExlMHI4c1JVODk5ckpqdVhVMlB1RjI2ZTFsSzYrTHdX?=
 =?utf-8?B?TWpreHdpSUpwd2NJbHh6eWpVU3k3R2VDNXNPcG5hUGNKQmhrdTBhQnNNRkJZ?=
 =?utf-8?B?cy9XUm9NRlBrRkpFd0h6aUo3TnJNY05JNXJUTS9qMlh4QUNMaVM5T2FuV2xt?=
 =?utf-8?B?NGZMNnF2NnRvUUl5UVNzbHhkRTE1Wm43OE5INXFQNUsvL3RZbWpwamNQV2sz?=
 =?utf-8?B?WlFzRjJ6a0wycHlDSmpocXRFalpJb3BoZTQydUFLSFJEQjk4bjA1QTk2b2Ri?=
 =?utf-8?B?RUxPMkxEWE5STjN0TTBOK3ZUQW5udjcrcGFCbmdrWWwwUG1HdXZsdmVna3ha?=
 =?utf-8?B?SElUai9MbEhpeHkxdE5XbHEvbVpOcHErMlpsd29qcnFUZ3ZFbCtDanhPcFkz?=
 =?utf-8?B?NlREWXJ5Mk5DZ2FxOEJQMC9rSksvYmlPdmpiTW91d2hpZDZ3bjRtamhKajI3?=
 =?utf-8?B?bFlqK1BhZUZ4ZndnMkk0NXphaDkvOVYwa0VCSEp4Tk9mTGxnTjQ1Zz09?=
X-Exchange-RoutingPolicyChecked: XnrMnWqJqh8WPjSLD2JPwZfOiRrScb02cNA6N7FzMErv3kvkOCra+LhjpGq7HqctzcjV8u7NIP8IlVMzTH73QeP91JOq+QigKtTquuAp5Cr6EHlaBJAsas0yAAnFuIqyhmCyWw+pjlmrKi86m9jvfroleN2ULOJ6kgGcB3pti5oRQsPMFbNRS6B/nc3PrTWls82Xah1a6WndfHos6zo0A7nb9m0X5vL2j93O62cnLiwllHvYtFjAxEUGKS7f7u4n7KgXrp6Z5+F/8/6/UEN41gbEQyrCE3tHPcxfe5HwTGF5H3tPk5w+AV38wW78G0pFstQ1OFkpwZjIaDCO9EXb/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ed0b95-4dd7-4dae-1b75-08df30b3299f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 03:10:16.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yb5+SceV9X/w0fkVGX/hw0585KEF6SXhHnxCxl6HKo3yWQD03L5NZBk/NQyzrLKPc0hItJGEac0n2eWeZ9+baw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9558
X-OriginatorOrg: intel.com

On 10/22/2026 2:48 AM, Binbin Wu wrote:
> On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> [...]
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index b4aec4218b7d..062631e2dd37 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -2778,6 +2778,8 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>>  		u32 entry_control;
>>  		u64 exit_control;
>>  	} const vmcs_entry_exit2_pairs[] = {
>> +		{ VM_ENTRY_LOAD_IA32_FRED,
>> +			SECONDARY_VM_EXIT_SAVE_IA32_FRED | SECONDARY_VM_EXIT_LOAD_IA32_FRED },
> 
> I think it can be break into two lines for much better readability:
> 
> 	} const vmcs_entry_exit2_pairs[] = {
> 		{ VM_ENTRY_LOAD_IA32_FRED,	SECONDARY_VM_EXIT_SAVE_IA32_FRED },
> 		{ VM_ENTRY_LOAD_IA32_FRED,	SECONDARY_VM_EXIT_LOAD_IA32_FRED },
> 	};
> 
> Oh, it also fixes the issue reported by the sashiko.

Agreed, splitting it improves readability. However, I am not sure if it
reliably fixes the issue. Splitting the entry makes the partial case
detectable, but with error_on_inconsistent_vmcs_config=0 could it still
leave vmcs_config inconsistent?

For example, if the first row passes but the second row fails, it clears
VM_ENTRY_LOAD_IA32_FRED but leaves SECONDARY_VM_EXIT_SAVE_IA32_FRED set.
Only leaving EXIT_SAVE set is probably harmless but if the order were
reversed:

{ VM_ENTRY_LOAD_IA32_FRED,	SECONDARY_VM_EXIT_LOAD_IA32_FRED },
{ VM_ENTRY_LOAD_IA32_FRED,	SECONDARY_VM_EXIT_SAVE_IA32_FRED },

then, leaving EXIT_LOAD uncleared would cause issues, right?

It probably doesn't matter much because
error_on_inconsistent_vmcs_config is set by default. But, I feel relying
on the ordering makes it a little fragile.

The other option is to leave this patch as-is and add a check to the
existing one in vmx_check_entry_exit_pairs() which covers both exit
controls for FRED.

if (!(entry_controls & n_ctrl) == !(exit_controls & x_ctrl) &&
    !(entry_controls & n_ctrl) == ((exit_controls & x_ctrl) != x_ctrl))
		continue;

I couldn't find any precedent for this. I don't have a strong preference
here. Is it worth making future-proof?


