Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794990599;
	b=t98vPdyH9pZNT+DUMYwNi2LI4ITxKu/0jEYn9m7WkQFeC3uThMq/+8S7F+aa72dIHiwW
	 bETEqX5gWCjDuHFWOB8zSjLcic5mEdhMHkIWZjrENcU4b+LZ8y+8SzHch+MCfa4xdP+MC
	 +NUbSKnjq6nxN/4jYVQ1rXI5hPzIUZcKp+8OQTuJlnrqZ2heM1JLVqRemXl2fSpjsqXZM
	 oG0leGve/8NuX19c9+ZAs8bj72sZjOJjR3p22kYCfrZNHaVPR1huzVlSTtddK6C3cM63D
	 okg7N3gOOw+mlWRpTjO3FThwA4Kjx3LwpL1n7IOkiT0sYUqeevOx6S2UjV6aNcUSqNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990599;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
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
	bh=2h79RXejAQFMLD+vY9wyGUCxlxuS7jin1aNaTDHIQvw=;
	b=B74PI6N2IHf5qY0kn31ParP5r3+F5aktVy6PFDwZAH4UHGP1+MilvhR500lsC1maYy6S
	 8PjL0o0aeZtJN9gMn7WnkykiQZ2W8HDqMGZeJVuuHXcOhCjfFeVMEezsqFRAUg+T9p7Hv
	 jZrJ3dYERfCUq+hDc/u9Q0Yf/slc58+uCVjG6uEo7vUoAnCjfZyy+RDABz12vq6F9aQM3
	 bVv0yl8KDdYGptLfhZbGedcW84oPlJ7TKfsqBQtwA0s4RxQ+hbV3unArWO6uKqxsf4hGn
	 NcM5JhBheS4/vyzVLapb6V6Ifu4MuyGQhWG1F55NzOtCHUNcwVM/vJbcDLfspNYNjcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fHncoor1;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=PkQTd2c1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6E2606A32F;
	Wed, 18 Nov 2026 08:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A6E2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fHncoor1;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=PkQTd2c1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794990598; x=1826526598;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/L85MWk9CQU+g8tQ5IrnqXEpUO7c0C4Kg8mFhWHaHl8=;
  b=fHncoor1iTMdSK9bRqW3h3mbn/ynOAZe1x1X3qKXYatiSwmzUWcsLDKm
   e4Zfqs2olJqYXwtUv2rOL16kjFWYMgntDB2upADOpiv0ce2tJKno3JeUi
   3imEoYAwQja1i3WPT+QptWtl2+ru6voaDGf32OB1KIE9ZgonPS7CoN1I/
   es6YBJQETP7ycRDY/rJY0VU0iUisMBQ9uVK84b1nN0QiyP3F1UVnlcEiQ
   N8SdiHWS1YDyxpwiYIUmpalow4lQjgXc87iWgd11UkKi4bISc+ATefTpg
   KRRfPjPpq6yQPnE4RjSh/3YI3wz4SGYQDMiujHSTIbpOYAQl8+VD4zI4y
   w==;
X-CSE-ConnectionGUID: o+Ahjjk2SNSFjNYGTLWlgA==
X-CSE-MsgGUID: 2/M57SLdRWOGi+v+o8+plw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3688702"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3688702"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:29:57 -0800
X-CSE-ConnectionGUID: 5zWb9b/ES3uu0TTUFDbZYw==
X-CSE-MsgGUID: J2h+NqVJS9SaZewAu5thVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10165076"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:29:56 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 00:29:56 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 00:29:56 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 00:29:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRQ1LrGpoV0mnTt2Gkinf7O8nAzIYUaR+5blh8aXZfWb2cTV/OTXz5APdFo3XfBqTjUATyUNt4/5Mdyfe68dHHwJ/sUHRtivdtvVFteeGkdlbwS7vHtDtU3eojdMfp3FMu9oCySYe756+HkCd8IYVzDb5UqkNQTbAQIJXyy4jXBDxuNuNkvF77xqWy9belhmc9Kux9dVLMGfpVd2mjAaskEhOrJrDSaOo6SBFkR3c+8tHU/EiEpGr4sHAbCH3+BzQoZcfjwjLRku7uYmayHjoo0Xg0rWvDDqbrOriEMTTKxeZ78YIZptsm5WKsulbD0g6jJGL1CzKIekculZEC+8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h79RXejAQFMLD+vY9wyGUCxlxuS7jin1aNaTDHIQvw=;
 b=JzzIMiW8MJGbbj0hMMqT7n4faSaTCavum+gR/gXxcHzxBn1617Fw6FCdk2VQFHKh1Lk5XiywyYckN+3fVtQ2eedPsLPQWKz2SKk0tBDSX5nEgFIXb7qakDKG1+jOhU5igaoFOV5pTYFtR8wrq36KsiurNh4U0mo/kaBIBjpn6mTx5Hlw8sCvv0D86odIxXpXioaGv9WscbzMzCd9kNzqXcJTZLY3FAd/FPkxCNGhar9SeAjU4srh7oa+Cap89nzBmn/k0oRoG4Re2L7FEbDlKnhbd41EPPnxgr13NYKU3dGHClLi5v0EvGEBXpBEgVYCtR/NS7BCMjWvlypaj7CUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h79RXejAQFMLD+vY9wyGUCxlxuS7jin1aNaTDHIQvw=;
 b=PkQTd2c1xYK/nhfq3eC+6ULzs6WYxdgPmK39tiXJ4Y8srEWVTcVqY48iOm8KmMAoBjY3nlc0t3bPS3bQeGaLkDij5PlxZhPA4cXJ4h7K9Xsds6PV5ZGsUQnengIVMaY7vbJzbjBdkmrNchWJGfRoaEtWHCFf8KJhqqVSK6Ihl4k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by IA1PR11MB6145.namprd11.prod.outlook.com (2603:10b6:208:3ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 08:29:51 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0615.009; Wed, 18 Nov 2026
 08:29:51 +0000
Message-ID: <0be86685-32b6-4a9a-b1a5-615a1703ef48@intel.com>
Date: Wed, 18 Nov 2026 00:29:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 19/28] KVM: x86: Advertise support for FRED
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
 <20260911213659.2025974-20-sohil.mehta@intel.com>
 <14447223-008f-49e1-824b-9f6e8a4aa0c1@linux.intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <14447223-008f-49e1-824b-9f6e8a4aa0c1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|IA1PR11MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 886ffe68-f033-4bec-4701-08df454e1cef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|22082099003|18002099003|4143699003|11063799006|261022105027099003|56012099006|261102123227099003|261022075727099003|10067099003|261026140227099003|261021121427099003|261026121527099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: a7UCbfUuiMEnWPVwonWSaERebvpW5iYZdAEHgpQB5Oay138NO/Src+wEDBw2EI6VARyVHFSDd3Abxs5qZn3tpSHvsavrXE6LzPT8qtSC/5OFRSSKqT+9TXz5yw/HrRKfMBogxXYmXArwCbhn7fZFo8RIpjNsYINAINBqKh96UkemN0W+COcBbdoVBTxatbo8PCg9SBrue6NSBomQUyQdr3INKcpgo6xFll+QoG8XRHTf2Cr2IDI2LJcSTfwunQAWPTzSTr5BrfhSkTk5GfwOmTwgSLoXClsxQYs11DLs8+B08MufXIcOAOrphSSKXHF96/QTUjQnojBWaapiQMW9kIIXyAXmFELzBwvtaFv475vuUKsWz3ed1RA1rzjdYNnHT4HI9JkllHKA0ORgltl6Gg6RQEsPi0mwaPcgZU9MOuoijE7mmSo4kS1vtsI+5Yf7paUb0U3NSUlmYNgPxXexDT9LqHIJW7zgQTNMWAT6gsSkiV5GWz+xUVpKC0vgOyAeBXUPedIfvTzT5AL10v0EP77tqUPGMgm0iVEVBngQ62QpLphGFadhCToz9E270BSdwSOhr8XSMVyHMpMXt1bKpiuuyMiJiAlQDMkroKpjHw1BRBjZhaUoRiQNVtFD2NQy8Ey953d42QCIenXXAIN/Uvqe4oSFAWLojNqO8zENu/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(261022105027099003)(56012099006)(261102123227099003)(261022075727099003)(10067099003)(261026140227099003)(261021121427099003)(261026121527099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmNFLzVWcndycjVQN1g5M1hvL05RQWRudnpaMTROVFJiVDd2a1ZlS3hpa0Fz?=
 =?utf-8?B?aEZrbzFQWnVGdXJTcU1Za1loUWxudHpEL1ZFdzlGdmRjSUFpOG96cmhnb0Nx?=
 =?utf-8?B?ZXZhcUVDcTVidjNBWUo4WjRHZEZZREZlWWpnZjA2alJYV1ZtWnBzeVVMNFpM?=
 =?utf-8?B?ZGFqUHdIWVkyc0hnYUcxaXNTQ09xSHF2a3pXUTFzTFAzR3RKYTAvc0FJUG5Y?=
 =?utf-8?B?OHBaQ1YwcDRqWWpDc1JrM2RaUzhvallzUHRDS2Q2MDY5TEtoUTI3cVNMNHEy?=
 =?utf-8?B?b1JPR2JZQ282RDE3Q2xtVFM4dmFPUWxVTytWb2hjai9mNWRUTmZuY2ZqZUph?=
 =?utf-8?B?STRINGlGVUxmbFlNZ1ZiWEt5dlBWWDAzWUdvVnRFaXp2bE0xUFZQSXYvZzZu?=
 =?utf-8?B?UjduOHJOWkFyVzZkWDk3UlE0ZTZjYUhSS2tLY0Z5UFlOdllvYTlFRjVyc3Rj?=
 =?utf-8?B?dGg5Q3pSVjMzcTg4alk2WnViTUE1bjczd1VBcU1rSVRCeU45enhlek84VGdu?=
 =?utf-8?B?ZUVYQm50RFN5c0pac09SVFlqdHFUV0RHWTBreWtpQkhPbFRod2M2ZWg4L012?=
 =?utf-8?B?OUhxalJSaStva0xZWVZnWUhsQldyMHhka0kySVp1bUhHT2wwQmhrK3ViRWsz?=
 =?utf-8?B?aHFEcnpxTHVWNHpqNVhmZEtPWlRvV1VsUE5xQ2VQZzBlN2FIRzBMNnBSOWpa?=
 =?utf-8?B?SU9wRHNYUGVkRHRua1d1YnFIeWRDSUt6NTAvbXo4TzhlNmszOVkwTmxwNXZ6?=
 =?utf-8?B?MkZ2c09DVVE0TjhtUndGU3VHTUVJZGl2eWFZZU9xcVcyNGJERndLUGY4cXJC?=
 =?utf-8?B?dUM5K1IreGVKRXk1aTNpRER0U0w5aFF3YTIwcUVVcEYzQ3FlK2dYRmFvdmtI?=
 =?utf-8?B?QjhZaUpXaFI5Y1BuZ0R2dVF6aDNSRmpWM1FSU0x4Zk9ZZExMZ253WXlJVDFs?=
 =?utf-8?B?SWtGMDNhV3VCZDFKSjJUdGpORjZDVGcwVEtiWmFKZnhnRnNJa2ppcXBNNWd0?=
 =?utf-8?B?Nld6dkZtclB1YldZWGMyRzFGWURxNjRKT0JPWTBTTlZKVG9ySkU0VXFjL3kw?=
 =?utf-8?B?a1p4Q3R5dEozQ3J0bWpJdXh6eWd4anMzeTEwYmRrSnNDS0M5bS9CSXJNcDlQ?=
 =?utf-8?B?VGtsSWVVemdLMUJJbFpKOUJKNGU1YVFtVjNKWUd0NVZNWGY2dVl2czBYc3Vy?=
 =?utf-8?B?ano1elVaM1Nkc1BxcFlJQ2RtQXBhTUtscHp2Y2wrMWxnNnZGVktxOWtOSUtX?=
 =?utf-8?B?VzIzcDZzMURsQXZqUlcwYmI3b3dVLzJwMy94NUtVYUw5WDYza3BQMkIwOUVJ?=
 =?utf-8?B?QVhNblZkZnBPQ1V4RHl4NDVDVS93TjV5QkNsbXBhNEFkVFZQYVRKbzNGQVNs?=
 =?utf-8?B?YStzd1RwTXdOUDBheWwveWx4ZE9mQ2pBbXdja1lTV3hXZ2JkNFZ3MjBrbWpQ?=
 =?utf-8?B?RXE0M3d6YU0yclJMeThmMlBibmtCVW9QNDVTZURWRU5QOVhpd29uMWhsbmwv?=
 =?utf-8?B?WDlRcHN4TXpnMEZkUGtlY0RuYmduUFNma1lDNzA4dFJjOFFhK0gvSll6UGJ5?=
 =?utf-8?B?OGhLUUQxdVp4YXFsK1VoK1FqamZLQVhvdWtWbHZlZ3JMUXh3V1VkdElYM2J2?=
 =?utf-8?B?TGRnK2hQT1FEWFdBRkpNdnhTRWQ3aWtUQ1F3TmJHYkpNYkZNR21rS2dYNUF1?=
 =?utf-8?B?cXA3M0FxMEZIZHcwRUh1YW53ZkcwRlVDMjhLSEdMc0RtMDl3eDVxeE11Nmlu?=
 =?utf-8?B?ZTR5ZHVNL2RtaHY2VCtKRkFpbzM5dE9XYkhEQXg1VGUxSE5RbjltUnY0amdG?=
 =?utf-8?B?OVBMM1dUckNveVZBOFBSMFhIWEFxMkM1RFlaNlZSWnBkcVdEQTNGdkc4Y2xr?=
 =?utf-8?B?MzczNUtSMVBWKzNlT2p2YlRVbFF2RXNYSUdxOXg5TEZ5dzdjZHFSSzZXU1U3?=
 =?utf-8?B?bDR1SGJGQ2ozR1pOajdXREJSMHRDQVlOU1hBNEZHRXJNd1ZUSkFXZ3BkSU45?=
 =?utf-8?B?cmRUQ3pTSEdueFVBY0ZHdEo5RGx1NDBBa0xMMi9FdmJpSmRjSUFZVVN6RWU3?=
 =?utf-8?B?c250VGRleElqQlNFVS9UQ21pY1pxcTdZbWlEMzhnc2tGUzU0bFY0VWtCV3dr?=
 =?utf-8?B?TVcvei9iS3ZRSER5VFk5NEJwQ1BUeFZxSGxDUFlFbGt5YloyV29MUWZKRlp0?=
 =?utf-8?B?bW8zZmN4K0dwcU40N2ZyeGVjSSt5eGp3bW9iZDd5KzZyUWJSQVVPdi9vb2tv?=
 =?utf-8?B?cHkwcVd3b21XeDRLK2RJT1BxbkxydDJiN0lZRDNCZmJhV1gyVjdnUnkvazVi?=
 =?utf-8?B?cXh5SHFxS0RUaERJZnFaNkRoN0EyZUppRUpyQXJZMWRDdkFoSHV0UT09?=
X-Exchange-RoutingPolicyChecked: 5T7DVnBMh2rJQkxKPnDhIpRmIz/DZ/nFHhlIHXaDhY2ETJyTVl2Q3ioyIPVBuaEW87NNqf8MrtUn+8Fmtki3330V97McmDY3o4yi6cra5jMCLB4YymtSianyKSSPMWHK3Ys/l7HOd13P8Yt7e7MLa7d2A/bbjdo+TnCVC26qhddtDoxzuZp8GmYkvi7h9l40lDSKtb4a88CVODp9aUIut08zY9FxP5u1/sU6gpgO/QKDSrEc5kuqDptAYec2Xkgo3osz+FcUkqGVJjsLodtdfz6aIErCauSGl9gKbqYqieMO+B+eJQ+9klLjG07SNf6l3TctyP9Ng/BgLtrnLAXL2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 886ffe68-f033-4bec-4701-08df454e1cef
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 08:29:50.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEwTJtH0eg3oqWw/QwzjI/7V7XtQ4yqDqqVDGfrTasmObnBc+Movd8s90FwiAz21z3QaiVloJ5eqJh0CDoz6mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6145
X-OriginatorOrg: intel.com

On 11/1/2026 11:32 PM, Binbin Wu wrote:
> On 9/12/2026 5:36 AM, Sohil Mehta wrote:
>> From: "Xin Li (Intel)" <xin@zytor.com>
>>
>> Advertise support for FRED to userspace after changes required to enable
>> FRED in a KVM guest are in place.
>>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>> Reviewed-by: Chao Gao <chao.gao@intel.com>
> 
> The code change itself looks good to me.
> But this patch should be moved after patch 25.
> 
> X86_CR4_FRED is added to nested.msrs.cr4_fixed1 in patch 25, before that
> if the L1 guest enables FRED, it will break the nested case when do VMXON,
> which checks nested_host_cr4_valid() and it will fail during the bisect
> window before patch 25.
> 

Good catch. Instead of moving this patch after the nested VMX support, I
am wondering if we could reorganize the patches slightly differently so
that the nested support can be split up from the L1 guest support.

The series is getting a bit bulky. I am trying to split this series into
smaller parts to make it easier to review. Planning to reply to Chang
email soon where he also suggested this.


