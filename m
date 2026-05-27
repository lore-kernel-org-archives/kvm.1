Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F542324B23
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846139; cv=fail; b=jZ63ZWKPSd2J2TlfcpEdpUgwm4vqLTAyxO8L1Me7TlUux8EUxh4IsHAg5QosnZNh5z/Kihq0pqkRT1EVfWnb6WKhHcmjDzuuSAYOQSZA4lbEiv75KFWtGTGYGTPTy8NtXp07V75dhBGUD1M/6o0zE9qKt5RFjzjzagas5DpgbKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846139; c=relaxed/simple;
	bh=7hfPZABM5vryU7gd0fVMLKSC6qag3aigZHJMpoxfHE0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i+GrdlKbmWTvac0I8GK8mRp1ocnRz2Sux+UHaZIR/tqJI3/BpFEawyEFTRpjvzvwjvcMhXnNzs8FzAjID8GNABE9sCGOslfxDEpkCbEEnvOKjyvYw6M/Cuq300Lcsk9D/Ag3qEwddoG6+1vNSVd9nqNdxpT9EJ+HtKhqnn3bCuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9BrO8au; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9BrO8au"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779846137; x=1811382137;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7hfPZABM5vryU7gd0fVMLKSC6qag3aigZHJMpoxfHE0=;
  b=O9BrO8auhPrcJbKMi6bkv665XqmXKTQZtd00nRqimmVO5ZRPmy4fqKvy
   slpcKalW6JVBgN3liQ4UiZCVNfTTA0ELemMkoFTlNLarOCGNypxHRkhPF
   bqKV/dAmTlYqekz07gajMuOYiN/7sg2sjlcnnu9NeIwtBQjLyL+Yg0qO3
   BB2s5/Yhziji6p3GFR+d8chPdQ560oUH4RiJqmBAqvzmqjddUbhK/Qk95
   BwC3UVk6843YEM06c+0hS0TiBf4eMVttbLN/K4yXkfZt34eOxHd1YjWKf
   918K13gAdC6bS3FsIdDETaV3tTuZc7Wcxg8zXc97VWQEcqp8JRlJzTshQ
   Q==;
X-CSE-ConnectionGUID: FiBmJYwqQAydEC5Yh2Kk9g==
X-CSE-MsgGUID: kFbKVXiwS5OiR+1qCyc5kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80519488"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80519488"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 18:42:16 -0700
X-CSE-ConnectionGUID: pBiy/j0MRAOUa9bNG745wQ==
X-CSE-MsgGUID: EVjubrcIQAKg7EvZeRwmZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="246349353"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 18:42:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 18:42:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 18:42:14 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 18:42:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzztNS6Yg8XBt/GC16bYkYdtCAq5beDEZdVyJiPkAkpYoDoKL4y1YnKrCFy1EWcmWye2AMSUottge0q48fdIYdx3rz3w5OLaVqTkLihvXM8eRXjFEzcedWZvJ706IiCGgISjKzBV1eoB8jmy+mda4WZK0/4rJf8OPYjKW1HfBqO67AXRP9TXQFl9pE+UgeZ3EPcSIiB24r0nLq6KMd1voFUwRC7/QIEfanIv2sVkyIn8aGi/3QIgbMbdVa3pH1lcWBrbFrJbl0lQ4gfT5HJdBNCu00GP9GAjuh2S1FGp5C+EMXwLBYw5T1gHAmlqKdxKTk+ecvdHL++8JBJrPdjp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=266aic9RkHs9bjByFE4rchp3Co1eHePy/9aQFIZEz40=;
 b=aXuwt6hygfrrfpuKIY1wdw8CFpbKowrl0PBy41/CxgR9szK03qSl1ka1rALmXBrelzn2oVEv62XUyBAZ2VXkc9p67G8ccdB97VEKx95Jwc1W3fBfFD2lA2tJvTYVmF6rL21aK5wi9WcBSHk4lw+gDWc1ATxYhoohJNrlIqne3FsXu2YsKLlQf6lavCnTRWHsZjTbwp9kCgA6100g+tPxJi8flZNoSsfUNziRqxhaZ21Y6k/rlHbSwyY34ptcpQtmaxDbezvixtiLsFdXR/rtCI2VdT9RvZacqDHeuG21caTeJQichHgokvr0elWg11yxWDanTXW5IT9Ps3KFGgqLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CH3PR11MB8749.namprd11.prod.outlook.com (2603:10b6:610:1c9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.11; Wed, 27 May 2026 01:42:12 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 01:42:12 +0000
Message-ID: <d08b2f6f-b2f1-4cd3-a1fe-588261e3ee10@intel.com>
Date: Wed, 27 May 2026 09:42:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 2/4] nVMX: Validate
 DEBUGCTLMSR_BUS_LOCK_DETECT states during VMX transitions
To: Xiaoyao Li <xiaoyao.li@intel.com>, <kvm@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>
References: <20260526031704.109102-1-chenyi.qiang@intel.com>
 <20260526031704.109102-3-chenyi.qiang@intel.com>
 <a479bef3-f24a-458d-ab90-3216712e1fcb@intel.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <a479bef3-f24a-458d-ab90-3216712e1fcb@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|CH3PR11MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 90edce11-99ed-469f-bc0b-08debb912c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: PyFbPkxCMmcmZga1mwWmceWnA04+MJo7o+zxbPvJdPQtda6teumnAPCX4tKygff1r+3LwlcEHOv9n0wJiojt7jF/ptiN4WUzD24/n9NEe/3/ET2NMWqKTfuD5tII5mRPovWxi4f8XVQnIZMaMTylvfMKJ4rzkdw8xhGCStxAyUKdbbgv/Ct24qqzqaFqPf8/cUUfRc1PEtdg2xvag98p27uGuD7h3IQMtImMPA7gTfeXYyW9rky83QHhtq9gzeKYuHzW0p4J4lKqyb48/M5F/1/KJVGEDFPOCSuv3rzyH/+SOU0GOeqAghwRUmy9qvumGNGX5Ka8SLMgU4ISjqDRWkaVpMAE2FZIlzg+aJF7TioxsmgpP0pNO4Is/5wyXh6JfHAZpQihjcmdglVGDMQ5AiCaUVQrPJ0njfYIrvDd9mo0NKPVQD2c/DBVCwmmSDdPhSAcWyGpN6nBAnjYvus7TqN56fpT1KaIwTlvacTpLzgHqC7KHHUV63YZcU/+0hlMoeElsxSs/zkp/OFHKfnDWPiOp4NhlIIQOGl7ndEHb0zITO4Muy0DHF9YRboLoGqDv0LRsBsd1KVJZ8ZjsL0NzwHQEeuAGF1bd+71BgpBTrP9BfDOsmz0pQwF933KKkRX2nYfJzkyBQL43k81G0hEwOQDyB/1J+jmI2CGsK0SAsrjsgQTibbffcRFcU2E5hj8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTdmdmsxL2hmeTgyaWhEb2wvVitEaVZnZFJmbUJ2Z2tPcDFTS2thbkdTbGgy?=
 =?utf-8?B?b2QzeEJxV1NQUjVScFlROFNMeWE5ZzEzVkF2aWpTRUxtYWlFTU9xaG1CRWZo?=
 =?utf-8?B?aTZ6UzlKUGphOFVYUTdtRHFzNUxiSjExTDhRd3BNUGJtenY4VzZWN2JvbHJt?=
 =?utf-8?B?TmRZZmt2ZEhLYWcvbisyQ3NuQmFkVmxtZFUxTUlMUnhZSHVCNWtpdHlUQVRU?=
 =?utf-8?B?ZE1RNHZwTXBWcVdiQWdNTDRqbWVuTHFtZEw2Njc4VHREQTQ3Z0ZiUXdYMVZr?=
 =?utf-8?B?Ti9FOGdyS0h5NEYxQm14TlFWRDNWSVFQVUlmcEd6d3RackdVbnNialFCeVJH?=
 =?utf-8?B?K3BEUWRvVEY2MTRWWWxtcXl3NHRpSWplN2hVUnBob25YdTJwd2poSDhOd1BE?=
 =?utf-8?B?alFvYTBZVVdab3NHejFqWHpLRTN6T2dtWS85dFM1VVl5RVlWT3ExZWVMeWow?=
 =?utf-8?B?a2dlN1hudCsrNElVVUliVTJuOW5GRlRvUlUyMHVaQmwzK3VuWnFFZXhLM3pi?=
 =?utf-8?B?M2RQUXA5VUF1SzBIeVZIeEJkSHlLcDFyU2xYOTl4dHpxQlh6ZkE5elp6U3lJ?=
 =?utf-8?B?RjlQaVQ1V1ozSjgyV203RDVHUEIrQ2tsMWFpeWRiRFhVUTVjWElteEVOTWIz?=
 =?utf-8?B?UEhzNGNDQk1ZaGExL0Y1TS8xeUUzWkttalIrdGl5SFdDaDNyQkoySlZWL1lj?=
 =?utf-8?B?T0JTQTFxVnVHVHNQbGVEWGtTUkdxWnpNaEt3UEhueDBXZENFbG0vVkdMWjVT?=
 =?utf-8?B?ZmloYm9mRWUrODI0SnhhMEdPdXRKa2FKM1lQL1hSR09uNkNxUS9ZNkRhL1Nz?=
 =?utf-8?B?T1JyT0piejdHZGRNMVpkZEMzWnlXdmYvdmhrOWNJYWJ6aW9qUDN4U0lNR0s4?=
 =?utf-8?B?d1RpTWM0Tmd4Z0dpRGFqRStxazIwNmZGeUY0WVhZQm1XM0ZaN1ZzNlVrcnVn?=
 =?utf-8?B?MU5Ba1FWOUFFQW4rYkx2RmxmS0diRVFxZE40aG41STFNRU8yYTdiZER3Sjln?=
 =?utf-8?B?WjhJNHMxQis5YWxveGZZb1Znd0pzcG5TTk1IZzdWZWlxTkZnbzUvM0xUaDhs?=
 =?utf-8?B?NlIwSmZ2ejFNaG1RZGVmbFRublM0ZDUzNm9zTzhvT2NoaTVYcUFpeFhkVHUx?=
 =?utf-8?B?VXdnQlRMc3kwVUZhNndac25mbFhlZGgyVW1TMXdPUWcxU3lhalU5YmZHdWk0?=
 =?utf-8?B?VmJWTXRsKzRjdjN1UjNSckh3Z3BMYUFpemxFc2EwcGZVUjlhL2J4dzJ0ZUtX?=
 =?utf-8?B?R21EbldxM2U5MUVTb21BVTYxQ00wcHlMaDY2d3Q3ZmxSemMwN3JlR29MTmNQ?=
 =?utf-8?B?N05PZjdpM1RHcGJLNXVSclhzeGJCWG5GbGxCQVk0TTlMQWVTZlJGOFkzYlVW?=
 =?utf-8?B?U1pSYm9ValhrS1FCbFRESWdqYkVtQXMrMjhzbDBFMU9FU1hKWm9SbnoxMHBD?=
 =?utf-8?B?S0ozM25KV1NIOHQxbjdMTDhWWldnVHJjVFUyb2FoTHBTR0tsZDBBM1JDbFlI?=
 =?utf-8?B?Q2YvTUtuTnZpcVJ2WWlZRk1FdnNLYzB1U1JSRHRTYVVwdnhuTCtwU3Rmb3pP?=
 =?utf-8?B?RjNuenNGbEVHeDkzWUJUa0M5WnJZcG9CeXk1ZVEzRTNRbXJSSnNQeGtER3pS?=
 =?utf-8?B?TEtUQ0RYY3FlY3dPQ3AvM2tsazVmcGhFdGduS1NGd2RFQStNaFFBQVhHRXoz?=
 =?utf-8?B?OVdJcjNCTElybTBKK1V3dWNsdzVCYmYzZ3NDbE5kUHE0Q3FWcjhXRk1wMVI4?=
 =?utf-8?B?amJvRUl0M2VlN2NXaGw4Mld2cDNNdGhNT1MwS3ZnekRYK3d6QVFuNXM3Szdh?=
 =?utf-8?B?THVDc2hoWThXNVFCLzM4TGwyT0ovaU44eGgwWTlVTEEveWlYN1VvMVlHdkw5?=
 =?utf-8?B?NjlLc3ZrNXJ5WHNxK1Nmd29UblFXSkVQRUFPQTlIaFdHZzlJRzREdndheHVq?=
 =?utf-8?B?cjB3Q3ppNWw3RW5QQzFZdE0zZ0taRE16VklGWjV4V1ZmejZKWUxoNzZlbGg3?=
 =?utf-8?B?b1FUYUpzc3l1SDBhT2d4NWNGKzR4cEk1ano3TTdPYTYwNGs4dmJBMWMxQ3Nj?=
 =?utf-8?B?aHprUGZoNDJlbmlUTkl1S2RDY0UyZ1A0Q2gwWmRZUXFlQUlzaVVJYXNHN3JF?=
 =?utf-8?B?MkdxU2YrTHhnRDJsSytZbzV1RCtjUU42VVJ3VnZrc1BTZzZTREx3a3lVTUhL?=
 =?utf-8?B?cEtVSXgwZEIvQnR6MzRmcHFLakNQTnNZVGFuVmxiREViMS9zbHVnQWQxcmhN?=
 =?utf-8?B?OUpxWjY3dDdEM013NEk5dnlNNFZKSHljc296T2xHZUY0dHk0NUlTcWM4b1dU?=
 =?utf-8?B?TnZEdU5uVmFBNjE0aldRNnZaSzN3d0tNMk50MEJjZzE1MllQcmdidz09?=
X-Exchange-RoutingPolicyChecked: CdFeB14E9xrwQ6u3c7Wsl0Lat24LhL2EQgYA13Gh8UDsZq/fcD1sMKuaBU8EUDfLrp/4kmxaKr9onZpAEpYSywbKyg/x55UB915EKHKZJGgmzT+82ox+WsjX6gO4HWM7sc8CeCAKkIU3nO4k/TP4zZ5tCe5MVi2H5bq82GXwIx4+DTVOiRhQx0eqrSzcPGy1Ma4FBT6BMV6yJxW04o+zWoxqo58AiFjkDcnqqvG8A9Kzs5VUAZ7l12oomLSm/fZQm3O6i8FOflaY3Y2h8E99bSkk8gY8kxHXkOGjNqYjethE5AqaM0byX3ZUGreJwixwNkOeO3tT0GYtRC83cbYxig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90edce11-99ed-469f-bc0b-08debb912c07
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 01:42:12.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiqksjNZtVWsUsHv4YcidO/bPyMf0qwxgCPbcqPUz324s9CuDNUM1/ClzSp7tV11vz3e38/CxO62hvCPS3kv/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8749
X-OriginatorOrg: intel.com



On 5/26/2026 8:32 PM, Xiaoyao Li wrote:
> On 5/26/2026 11:16 AM, Chenyi Qiang wrote:
>> Add tests to verify that DEBUGCTLMSR_BUS_LOCK_DETECT state is correctly
>> handled during VMX transitions.
>>
>> Wrap the VM-entry/VM-exit DEBUGCTL transition flow into a shared helper so
>> follow-up DEBUGCTL feature tests can reuse the same checks.
>>
>> The following behaviors are verified in the helper:
>>
>> 1. Guest states are loaded from VMCS iff "Load debug controls" VM-Entry control is set.
>> 2. Guest states are saved to VMCS iff "Save debug controls" VM-Exit control is set.
>> 3. DEBUGCTL MSR is cleared after VM exits.
>>
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> 
> Though some nits below, the functionality looks good to me.
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
>> ---
>>   lib/x86/msr.h     |  1 +
>>   x86/unittests.cfg |  8 ++++
>>   x86/vmx_tests.c   | 96 +++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 105 insertions(+)
>>
>> diff --git a/lib/x86/msr.h b/lib/x86/msr.h
>> index 7397809c..da75740d 100644
>> --- a/lib/x86/msr.h
>> +++ b/lib/x86/msr.h
>> @@ -103,6 +103,7 @@
>>   /* DEBUGCTLMSR bits (others vary by model): */
>>   #define DEBUGCTLMSR_LBR            (1UL <<  0) /* last branch recording */
>>   #define DEBUGCTLMSR_BTF            (1UL <<  1) /* single-step on branches */
>> +#define DEBUGCTLMSR_BUS_LOCK_DETECT    (1UL <<  2)
>>   #define DEBUGCTLMSR_TR            (1UL <<  6)
>>   #define DEBUGCTLMSR_BTS            (1UL <<  7)
>>   #define DEBUGCTLMSR_BTINT        (1UL <<  8)
>> diff --git a/x86/unittests.cfg b/x86/unittests.cfg
>> index 48835eba..c8426770 100644
>> --- a/x86/unittests.cfg
>> +++ b/x86/unittests.cfg
>> @@ -471,6 +471,14 @@ arch = x86_64
>>   groups = vmx
>>   timeout = 240
>>   +[vmx_bus_lock_detect_test]
>> +file = vmx.flat
>> +test_args = "vmx_bus_lock_detect_test"
>> +qemu_params = -cpu max,+vmx
>> +arch = x86_64
>> +groups = vmx
>> +timeout = 240
>> +
>>   [debug]
>>   file = debug.flat
>>   arch = x86_64
>> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
>> index 91f417c6..a3e52d3b 100644
>> --- a/x86/vmx_tests.c
>> +++ b/x86/vmx_tests.c
>> @@ -11737,6 +11737,100 @@ static void vmx_cet_test(void)
>>       test_set_guest_finished();
>>   }
>>   +static struct vmx_debugctl_test_data {
>> +    u64 mask;
>> +    u64 guest_debugctl;
>> +} vmx_debugctl_test_data;
>> +
>> +static void vmx_debugctl_test_guest(void)
>> +{
>> +    vmx_debugctl_test_data.guest_debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
>> +    vmcall();
>> +
>> +    wrmsr(MSR_IA32_DEBUGCTLMSR, vmx_debugctl_test_data.mask);
>> +    vmcall();
>> +
>> +    vmx_debugctl_test_data.guest_debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
>> +    vmcall();
>> +
>> +    wrmsr(MSR_IA32_DEBUGCTLMSR, vmx_debugctl_test_data.mask);
>> +    vmcall();
>> +}
>> +
>> +static void vmx_debugctl_transition_test(const char *label, u64 mask)
>> +{
>> +    u64 debugctl;
>> +
>> +    vmx_debugctl_test_data.mask = mask;
>> +
>> +    msr_bmp_init();
>> +    wrmsr(MSR_IA32_DEBUGCTLMSR, mask);
>> +    vmcs_write(GUEST_DEBUGCTL, 0x0);
>> +
>> +    /* Validate when save/load debug controls are set */
>> +    vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
>> +    vmcs_set_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
>> +
>> +    test_set_guest(vmx_debugctl_test_guest);
>> +
>> +    enter_guest();
>> +    skip_exit_vmcall();
>> +    /* Validate VM-entry loads the guest DEBUGCTL value from GUEST_DEBUGCTL. */
>> +    report(vmx_debugctl_test_data.guest_debugctl == 0x0,
>> +           "%s: Load debug controls", label);
>> +
>> +    enter_guest();
>> +    skip_exit_vmcall();
>> +    debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
>> +    /* Validate VM-exit clears host DEBUGCTL and saves guest DEBUGCTL into the VMCS. */
>> +    report(debugctl == 0x0 && vmcs_read(GUEST_DEBUGCTL) == mask,
>> +           "%s: Save debug controls", label);
>> +
>> +    if (ctrl_enter_rev.set & ENT_LOAD_DBGCTLS ||
>> +        ctrl_exit_rev.set & EXI_SAVE_DBGCTLS) {
>> +        printf("\tDebug controls are always loaded/saved\n");
>> +        test_set_guest_finished();
>> +        return;
>> +    }
>> +
>> +    wrmsr(MSR_IA32_DEBUGCTLMSR, mask);
>> +    vmcs_write(GUEST_DEBUGCTL, 0x0);
>> +    /* Validate when save/load debug controls are clear */
>> +    vmcs_clear_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
>> +    vmcs_clear_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
>> +
>> +    enter_guest();
>> +    skip_exit_vmcall();
>> +    /* Validate guest observes the host's DEBUGCTL value. */
>> +    report(vmx_debugctl_test_data.guest_debugctl == mask,
>> +           "%s: Guest=host debug controls", label);
>> +
>> +    wrmsr(MSR_IA32_DEBUGCTLMSR, 0x0);
>> +    vmcs_write(GUEST_DEBUGCTL, 0x0);
>> +
>> +    enter_guest();
>> +    skip_exit_vmcall();
>> +    debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
>> +    /* Validate VM-exit clears host DEBUGCTL and does not save guest DEBUGCTL into the VMCS. */
>> +    report(debugctl == 0x0 && vmcs_read(GUEST_DEBUGCTL) == 0x0,
>> +           "%s: Don't save debug controls", label);
>> +
>> +    enter_guest();
>> +}
>> +
>> +static void vmx_bus_lock_detect_test(void)
> 
> the name reads ambiguous to me.
> 
> how about debug_controls_debugctrlmsr_bus_lock_detect_test? hmm, seems too lengthy

I'm also hesitant about what kind of function name to use and whether it needs to be
specific to the debug controls.

Sean's suggestion was to "add dedicated tests (for BUS_LOCK_DETECT and LBR), and get
any coverage for KVM's handling of DEBUGCTL reads and writes as a side effect."

That makes me think the case should focus on the feature, with DEBUGCTL handling as
a subcase for that feature. Perhaps I'm overthinking this a bit.

> 
>> +{
>> +
> 
> unnecessary new line.

Fixed, thanks!


