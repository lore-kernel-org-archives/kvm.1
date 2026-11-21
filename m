Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795293729;
	b=WpvCl2q97Rv4iQ0e8RZWiM/9NCg6DHAQzG3tOv36gzYC6nb0kTtK3pMQJFFGJAm5TKsx
	 +8qGoxMpMM3LHKteN3I/4C46DN3pe88y5mjiCRiM4eZ1F7dBeqZ+tahO+LSpHN8mWJu55
	 buuoTO95uJuFFKVgcrgpgaz+reOtIFNi9V1tA16JVkgOPkwluq/kKKDRJXB2Z+lfhjQBS
	 9moq9BJxUcDbwBWTDdBr1jW/YFLZSpUTY7JZGc3SPBROyNH+9gPuPuEhX8R5seHPuoUPA
	 Fx4XugoGtAvmS6dI1+NuD35goj4i5J5pMSQw5Wch8aWHNMfflz44Ja0DSoZlbGFD/Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293729;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:Content-Language:To:CC:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=A+FgYq966IZUxnlKC5eU9nImC4SGuU+m8Dkg1m+otkI=;
	b=yxS6aDXcIb+WyfWUpiUecEU1st2UEtnCqmWsOZNJL3aNhyzUG9FAsBiyavOpTdF0Ku9M
	 rkK0Q8oxFKbkwQYX0beux/oUGo3Pe/Je29RHORdfS6pwDkgcCHEw4hDcLGt25ghmkK5+V
	 uoJPPt/kt5VcJYwE5N5j62HzNDZGz11W1MWtz3Q4niL2jRKQNHS6SbUcMAm9/E5Tx+Ivk
	 xBXQ/tvBWC0VebnACm0zp9xzbURdvpdvRdx5Fm3jVQ/dY1HzLhA9z9GXMq1lbqVvZTfXH
	 4yamll2p8FhCTgHge6i0hnj15om18W51nkAVGiLsVGQKmK7y7nSd06j3dBS4aAXhhFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mSzoYWA1;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=aF23P6jc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8975B606A337;
	Sat, 21 Nov 2026 20:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8975B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mSzoYWA1;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=aF23P6jc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795293729; x=1826829729;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6OU6RbaW/hcVUtlUee5KDnam8WurAzZC1azunX+fekc=;
  b=mSzoYWA1LH54UHd5VV2gl2grhiwc/JlppfdpAaBwJozIO2tgxi+k5K9n
   HE3O+of8mR7CMGQos/1rP4ysO+r30QyVRE/4+D2TOEyHhCx9Dk/3kwl/r
   OEhiuB9uXCDIuTrCmlLwyYBftEgfT2fwhVyYfSKaQOFgXO0J15k+/1FI6
   Xn7TdBF/VBvLdkE+W5WOuVwnj6WzPSuPrGeHR2a7lIinzvytnmjoJg45s
   pZJkqkafjbuR3OMDXjW82h1kkd7kydKvPqlgqxSExBlFjLus0fw9SHtoi
   zJ1iaG1SECDkuJ9NQXUdi01PGO2ll61Ub2/vrdiLGo0yqIOE9oAHIswRG
   A==;
X-CSE-ConnectionGUID: pK23QciVSA+Z3xhiotxhJw==
X-CSE-MsgGUID: dOLMji/KSwSDIYie0iQ/Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11973"; a="4150585"
X-IronPort-AV: E=Sophos;i="6.27,225,1787036400"; 
   d="scan'208";a="4150585"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2026 12:42:08 -0800
X-CSE-ConnectionGUID: oFtWWX3rRyupYZ7a/DlYKg==
X-CSE-MsgGUID: h1Bk3v8ASKagppzWvjANbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,225,1787036400"; 
   d="scan'208";a="11041327"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2026 12:42:08 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sat, 21 Nov 2026 12:42:06 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sat, 21 Nov 2026 12:42:06 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.18)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sat, 21 Nov 2026 12:42:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxTziurAuE/VApj/gAtW5Dms64taGrRIXC5wgCtb85qVLSsIaQz0ItFSUEqUW136tdnrjp9h6RhtlfeQ2OM/w0NDIuOJuN1wKWeiinDd9ivZ4bfYa9o5tx297ajuxNe/ZjWAuipjGBNqMbzhEwaylsR9B43Tzt25js4As1UuG6eP+f1kwjGV6jvCgUM8ZmjVfWLTYxFavxLChQMIdu0IgePXgjvP30WArE6nt/viKkUIU5LMy4KfcsUtA/QrnP2jS6RZyxprXPO1/tbNIFo8K2vwYxXDzdGZl2o9syYs++MCpJdQsvQ/QVYwUxqMAeZ1s2f5xUJXBMZRGjCH2SCwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+FgYq966IZUxnlKC5eU9nImC4SGuU+m8Dkg1m+otkI=;
 b=r8xXWfJ6+kVy3memtxrl+BtTUMCxo9AcVotl3rSKAYz4cjy9faN43QrIRmq4ydWcerTbKvuswoq0snIGUsTt1tnqIrSVMQxt8Bt3Yv3kVIP8Ip2jF/RuwoJ6eRIj5WBh7Jp7qPsZx1KUbs0eD9w2+UK999lq2BII702B6+xV4nZM4RSIgPkYSrtE9RL1NsGvaD4KuRpLLdNMH5znV7orDCtK63XMIWa6l4+c3t2G/Ci0U3sGU5LUo08+j9Zylrs42JduxXlarnhblhRsS2XaSy+Ve458bB2JXLlofagQM2/L3+MjT5cyMr7bIcHdlE/J8srs1FaOnaTwCiSeJAZQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+FgYq966IZUxnlKC5eU9nImC4SGuU+m8Dkg1m+otkI=;
 b=aF23P6jcUY7E+JQLLIGOA15x4yDQ3S8lwpeBo98nGowqwa5HMBM3B3+RirbP8wO7Eh1Chi/sNjEEW6VQsuFaSOmLnuyt4XeKeWDKQpN/IJOamGh7+2DwXobvxhV7DC9A6Iw5pfNAJ4soa3TEaH7uXFV9d3TguTxze5aF0nIV/cY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by LV8PR11MB8605.namprd11.prod.outlook.com (2603:10b6:408:1e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 20:41:58 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 20:41:58 +0000
Message-ID: <82dc24e3-f574-4696-99cb-87c0c04eab93@intel.com>
Date: Sat, 21 Nov 2026 12:41:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/28] x86/fred: Export this_cpu_fred_rsp() for KVM
 usage
Content-Language: en-US
To: <kvm@vger.kernel.org>, <x86@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li
	<xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed
	<yosry@kernel.org>, David Matlack <dmatlack@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-7-sohil.mehta@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260911213659.2025974-7-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0196.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::21) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|LV8PR11MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9ad6ea-4d73-4631-effc-08df480fe318
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261026121527099003|261021121427099003|261102130727099003|261102123227099003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info: r8kOCdq3CDN8ogb8PUxOUHfaMeJNEEmsDK7kcG0c5cQAFjAYH+uGCfgVDmEgw2mcpf4+hm5oDXn4YAwG8v7rx2tlojo2aurBI9Cl9EhwklMfL9ZNVBVrk35MMOjOEoUObbx5Y6BJZZxszaois1wHwPpjd3i2tWI6MpH6H5miiw7sdMXjVWKnYRLM4aNBfLBXvDABGBrU0WatGsHYxXpkVClmW3S88uQck2LaS/Bcc4AfkrvB+X+xqw52qVUj/33tTV91FjHwAjgsjhKK1mvaISEa+cUQVhyWuhrrni8zHvVPl86BzHJlEpvsBlqftz45V40705FmqXb/mJUQ2UNUJoo3JeR2XJMeloIRdwLzeKVyY8KEvHFpoSqEhimxj1iQFP7w1IsAwsME7oZz7NBpxh3sDQsXqHJN6iOP1bxD1FT5c9ae4jJhtu0wNJndov9/6HUxyLSUMFNdoDlkzEfrfIzQl6I7z75M4Cd1J2FUR3CbJHIqESkSOoEV/5LwdM868/KuQSr5/jwY9tLMafoFWtJdKCEFX7kXYezG5zfkqbrduxqRsv+PZ3eOA1rwOIMGOOjnfBhGhoJ8hNKOweLWEFCYoyDFSBK2Xk6EXeV2pp5UY3fjRyydtVBYoAZxal+A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261026121527099003)(261021121427099003)(261102130727099003)(261102123227099003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUhzNllVUVBQdnRvQTJtanJoSVVRMjdhOUFTbVNqWnZSdmJ0K2VPRkQ4cTlI?=
 =?utf-8?B?SDg2NTQ4Q1FQb3lUNm5ydGJwRVpRbkNjMFNRS1VEOFdhR2tDVklVcExwbVNr?=
 =?utf-8?B?TEZzNGgxTzVPMGRqejZDdEozYjV0WHRuVVBZVlZIdEJvcUdxOUFuY0VJUy9m?=
 =?utf-8?B?RnFCUVA0dkxwV3ZRRFNVa0tQS29qZWlPOVpUK0o4T1diemtsTlFYMkpjMkU5?=
 =?utf-8?B?TTB6N0RzN2hYY1hxL1AzYW1UUEVUTFc5cVpTQVY5VVJkVzMyVnFBcDBrU056?=
 =?utf-8?B?K2NRSERUTVVrVytmRGpOTEY1MEhwTnp3bUQrQTBhdjZJa3dSazdUWTdiRytM?=
 =?utf-8?B?ZUI4QVJ5MnFFMDBQajRhVXk5eU5JMjJDbmRkb1V0Sm1yZkkyVStCNGJlWWlU?=
 =?utf-8?B?ckJTd2RkZS9YdlVsSDZSQkErWDNTbEx3QWU5b3dVWVIrNGZxYVI1TVpCYVNM?=
 =?utf-8?B?aWZBN1RtcjNRYUdsditsUnZjYUFnT3NZMGIvTktBTURqYUpndW1PcXhwQzhs?=
 =?utf-8?B?YThSbGVwdFpVaW9MUnFTM1I5aDVYem5JU3Q3WmpXMG5vV0I4dnpzeVo3WUZ1?=
 =?utf-8?B?K29NbExLTGJqWjRzcERGT1dOV2FoK0JKa2FiRmduSThqWVE5R0lVTUFTN3dn?=
 =?utf-8?B?Wlc2WjVSRXJUR29ldXVLZ3EraDVFYS9LWkpUY0ZHS1RGcllaVkwxZGJJY1hz?=
 =?utf-8?B?d1ROb1A3NUpubEp2eVI5eEdQT2NKUmhnY3dwUjNOUTZrODdVcnVzZW0wQUVJ?=
 =?utf-8?B?QnZhSTJockZ0RXRNTHB5WVlGWXVWU0Z4UlJabmlmMEx4UDhsbjlNUTNjY2xi?=
 =?utf-8?B?dEkzZEluU1dCNGZLOUhTdjN6UE43cjFkOGg4Y1pmbytEVjBNN0RMTnZFc1dl?=
 =?utf-8?B?ODVEbEpNZ01mdENWN2ZWV2Vkc0pzaHVkMHBlZGNMSjdJQ0Vhb2NLV2ZMK0VL?=
 =?utf-8?B?NnF1VjVNQ2hZSEJJVWlUNnhKajJqeFRRV21LemlIOUFvUFhHT2ttZWdTWnZC?=
 =?utf-8?B?Qm1rZmxIa1dzM0lQY3BMdWU5bzZTUmFlNHgwYUloVjJJK3ZMSWNZQUhiU3ll?=
 =?utf-8?B?N2I2WXhaeWMxWGFFb1VJZVU1L2k1K3pKVXVMWHVYSG44RkdDalp3b29zdHVY?=
 =?utf-8?B?TGhYbVdhT0dFdVRETE93TGw0eXRPYjFBalNQOW8rNUZ5SjluK09yNWsxUktw?=
 =?utf-8?B?Q1RXSjZybW9EQWhKNmx4RGJmNGlHdVhCck9XZGRJbldYems4MDNRS0crR2Fs?=
 =?utf-8?B?ZTJGVGdVbXVvQjZnS3NOOVlPZkZhUWc1aEZ3aTlJaWxvdVhFdTJVYWVKL3F6?=
 =?utf-8?B?T0tnQkF4OFZ1d1JGY0dyclcrYXdBQjNFdnJlbSsrM2U5Sk93Ym9vNG1wZ2sv?=
 =?utf-8?B?N1N3dUdQMVNJQ1BkQnRKOFduUHVYME5KTnN1djFBWWRCUWFLbDU5TVlwUWlK?=
 =?utf-8?B?Zk9hTk1qempxalNWZG1aa3UzaGFZUk5zbUdmWkx0dnZacWtLdjFXMVJrZldC?=
 =?utf-8?B?UlB3TGNKSk1lVDI5TmczMnNVenJyVUx4Qm5EUkhNMVVrU0JNMXJsd01SMjl1?=
 =?utf-8?B?YW0wakVOVkZzT2xINEJua1FkRTZhVSs4Ukw1S1JUdUlRZVZmU0NWRThNckl2?=
 =?utf-8?B?bTkwczlDRWJjVmM5R055eityRXdtVUw3dnRNZkhsK211Q2RrM1N6NjU3UnBN?=
 =?utf-8?B?R1NKS1dZRGo1MkVMZ1c3RUt2TUQ1QnZQZzgvOWVkOWJMWWJ2bHo1UGxTcWE0?=
 =?utf-8?B?ZE1NNFRwdWNnOVg3VmtGb0JEOS9kUTFjRVlxZVFCdm42OCt1cWlEZUxjUHlP?=
 =?utf-8?B?UFJENks2UmdMUW5rdFJ1UGNUNUdIQWF1M3VlUGw0M1Jtak9YVHZXaGJpWUV5?=
 =?utf-8?B?NUpXWDFpY0xTalRWREdpV01VWGJTOEovR2dpbzQvM1RJQmF1K1hlVVVOeWhW?=
 =?utf-8?B?UkRWQVpZYXZ1ZnVnYnd6TmhVRHQ3SmJmdlBscmlaTzdSM0FWSnZ2TFY3Vkx2?=
 =?utf-8?B?UWoxSUo2VkR1QnZ1YnJYcXp1U1A0U094aUZ3Q1JaaEhYL0M5YVhmT2dOKzAy?=
 =?utf-8?B?a0VYSlE5VXhxejhWQ3gyM1VkQU1KMTh5U3hZakQ3akVaaUpVSG5yK0dzVm5s?=
 =?utf-8?B?bEZUM1U4Y25LVjMwV3BpVlErVlZQdmUvNFlWcWorRDNNS0diMDFCYmRxTzhQ?=
 =?utf-8?B?akdwZlZONWR3QkpFejMxWWtRQi9JRmF4NjdWYXB4ZHZTenl1U2VERm9iR0Fh?=
 =?utf-8?B?a2VvbDM0QXdYWVFlSWtCd1NNakI5WlhrMlJsUDZvWHVnSmh3RktvYlJIcUlS?=
 =?utf-8?B?b1p3RU40S2pHam0xVjlydFQwVjBxL2Q4QTlmOG11WjhUVFBmUG10QT09?=
X-Exchange-RoutingPolicyChecked: XzKr4a8JiXXcmBpK+hzGlrQZRqc7ae/cgKSaRdQBpV9Mw9LcJE4yqYUdBJLjBivqTzNx2I5D2Z41+GtG8XPUucI4aYxIeO85krLDxWO0oWajZWKm0nZ8uiQVcBZjU4Fgj4xRAFwapijd8vnHGyXDq8glWvVKE9N5EWaMO4rRodaAvJw2E98LFdRyHq43zy/GdrppJb4mIJd7x857nIPM+CHySI+HVrO6sTv+FgSjmylgQfEblGfBMHmVvH/1SjQsJYXhKeHjj/vgT2Vmdx4cVD+AKU0oPdPgqRM5oqTAOaLHsTgSt15PcvaXtjCHLueLRK/Il2pRTErUgdGYkvJ9ow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9ad6ea-4d73-4631-effc-08df480fe318
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 20:41:58.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mjosuvp9qEDdhic8QIhEsEtsPPZOJduREok+PAS3mvJDXsIuHYDuV5RAVJg1hiBlSmHdn1uhro9noXWVKQ8Q0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8605
X-OriginatorOrg: intel.com

On 9/11/2026 2:36 PM, Sohil Mehta wrote:
> diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
> index 18a2f811c358..85b851f16bae 100644
> --- a/arch/x86/include/asm/fred.h
> +++ b/arch/x86/include/asm/fred.h
> @@ -35,6 +35,13 @@
>  
>  #ifndef __ASSEMBLER__
>  
> +enum fred_stack_level {
> +	FRED_STACK_LEVEL_0,
> +	FRED_STACK_LEVEL_1,
> +	FRED_STACK_LEVEL_2,
> +	FRED_STACK_LEVEL_3
> +};
> +

...

> +unsigned long this_cpu_fred_rsp(enum fred_stack_level lvl)
> +{
> +	switch (lvl) {
> +	case FRED_STACK_LEVEL_0:
> +		return __this_cpu_read(fred_rsp0);
> +	case FRED_STACK_LEVEL_1:
> +		return __this_cpu_ist_top_va(ESTACK_DB);
> +	case FRED_STACK_LEVEL_2:
> +		return __this_cpu_ist_top_va(ESTACK_NMI);
> +	case FRED_STACK_LEVEL_3:
> +		return __this_cpu_ist_top_va(ESTACK_DF);
> +	default:
> +		BUG();
> +	}
> +}
> +EXPORT_SYMBOL_FOR_KVM(this_cpu_fred_rsp);
> +

I am not sure if the FRED_STACK_LEVEL_* abstraction is really helpful.
It makes the KVM interface a bit convoluted I think. So right now we
need to expose this_cpu_fred_rsp() as well as enum fred_stack_level for
KVM to get the kernel stack information.

Sean suggested in v9 keying based on the MSR itself which makes more
sense. https://lore.kernel.org/lkml/aa7mILKnhX9N4228@google.com/

It avoids exposing the enum and makes it future-proof with supervisor
shadow stacks. KVM will need similar information for
MSR_IA32_FRED_SSP1..3. With the current approach we would have to add
another export for the SSP:

	unsigned long this_cpu_fred_ssp(enum fred_stack_level lvl);


Keying on the MSR index makes this simpler and can be easily expanded to
SSP MSRs. We can name is this_cpu_fred_sp() to prevent Xin's rename
concern in the above thread.

	unsigned long this_cpu_fred_sp(u32 msr);

So, the below would become

  wrmsrq(MSR_IA32_FRED_RSP1, this_cpu_fred_sp(MSR_IA32_FRED_RSP1));

Any concerns?

>  /* Must be called after setup_cpu_entry_areas() */
>  void cpu_init_fred_rsps(void)
>  {
> @@ -84,7 +102,7 @@ void cpu_init_fred_rsps(void)
>  	       FRED_STKLVL(X86_TRAP_DF,  FRED_DF_STACK_LEVEL));
>  
>  	/* The FRED equivalents to IST stacks... */
> -	wrmsrq(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(ESTACK_DB));
> -	wrmsrq(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(ESTACK_NMI));
> -	wrmsrq(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(ESTACK_DF));
> +	wrmsrq(MSR_IA32_FRED_RSP1, this_cpu_fred_rsp(FRED_STACK_LEVEL_1));
> +	wrmsrq(MSR_IA32_FRED_RSP2, this_cpu_fred_rsp(FRED_STACK_LEVEL_2));
> +	wrmsrq(MSR_IA32_FRED_RSP3, this_cpu_fred_rsp(FRED_STACK_LEVEL_3));
>  }

