Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793937972;
	b=0/lV5T0h0RBVI2IBK0vY0dq1aRzQVwuK3ydqQ+GY06X5CVt59W2nw+Sr2lbxs0IsDo2o
	 276lGaILC7bPcJZydRahqPbVga5G3GdX3sZqwCAWw/fTtEe11eu7w3pqxVoZVivQjgJ5c
	 +T09BcscGjrf9CV6QKG4eVlQJmvym2KNCgWH5KCToAcgXxoYnXvbJ5rZkCm3bDiW96/9U
	 phxkpYLDvU4JV+hlDGUvZ0ptgHJG9m3xZrhF3XlTlWXjjoVTCmp0qYdYdNljiQ0m7H+24
	 lhyGABPb2rvc2LLfHnrMfh2TfrXl+YjFK9hab7tOGqZDNzAOPF0sQyXGmYX5dbj9ehw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937972;
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
	bh=H2UHDGQI3QFiENKEUoqGc4PhReuEo1I8O5u6JAOmvCU=;
	b=A7oQkVozkYlFGEwXdZbukjBRTKFeeurQcVK6I1qZeABzsuSoTxjSBjEwckW+Onf8Esq6
	 PMb2TWBZa4BrTIZSpor7+Jyj8nOwc2VhOKlFonXOfM+alPufz8yzN/Fizy8dQA2rocdSe
	 G9Pytp2OiqqWd2ujeNs1PN+qmtkXczpAZEHivQUFzRQXNlif9p2GhxmCFTqFMFH4KVbax
	 MNhuqtRD87ByLPFGXHebzDuohne1ibEkRxVSkwXbnE1j3xeVmtZ7ghOiTO8TSDohZpWw9
	 OoNldwVEeKyJxcmiJm6XaZ8eYnHvgKzQs6RDj9qfvjpp0wuSYrVYMaEm775oAh6So0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MMaKs+PN;
	arc=fail smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5649C606A326;
	Fri,  6 Nov 2026 04:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5649C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MMaKs+PN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793937971; x=1825473971;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DOF7Eqo87wlhSBl2rY1r3rdofOV/HzScdSg9Lz5xpy0=;
  b=MMaKs+PN921ivZwGCrTJTaLHmj31wcOHnCaJrsMppTzjCzFOcRErVrN6
   zH0/31RZHJtRYeDy6hRdNQHOZe7o+ED9M5qgpRheANW7vxqCC+sh/qRTO
   XlmwvdK4kBVPhy/vc9YvRvydiK3+1qW5sOfqBySo1UsYSqKZba5VP+Hpn
   yn/+liomnBjvebtVu0mTFyYz1mKwJaQIEFLNN8Z8MoCWj+X4+Qma6y4G9
   tFMapGC6Kdk3oHt6O/NnfHBEQgzzNFLSU2kp31V9Bcn8l47o8Mwy+hKT7
   P2R20GCO4nJSrpHgnzvd5fhjH8CvinJ0ruK5KQrDMyzaEd3Ft2lUKnVMA
   g==;
X-CSE-ConnectionGUID: k3IHSSTsSDKl9rw9+LYbMA==
X-CSE-MsgGUID: KbWEiFWFSuSxvLbXtPfVyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2770079"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2770079"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:06:10 -0800
X-CSE-ConnectionGUID: qQ8/jEbLRuGXJESxTbyrXA==
X-CSE-MsgGUID: xxiX2YODSNGDoyn6KydJuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8943413"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:06:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 20:06:09 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 20:06:09 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 20:06:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rV1ZYFj+FN7y4HZNfSEcmBVyHG00Xf9LSXF0SPZ/EgCorn94cNBbg3N4fa0+pJZST0ku68XQMcGVEyssqOom5dmFrJpnQSjFv5SoJFnUVuc67J5/DyxH50/PHMhKgrOVqjpEnbwdvRFJ8H1hH3UfjVkjkiJgYefwl4XpxiBM4QvHj1HycWpAnu/0+VqHnF+91x93FxanGsQsLreeRo7NG9ysoLuG1mAvdl46Q83QzRpraXzbRfVIAwTxaTq5HmRKgtWkLm+8yDW44aVU0Q5eIyw6dX+T1mNkQ7hq+fMZz8Nk0erV8+qU1f0yT62I0DIQCjuOZM43nU7sS6U/l2t/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2UHDGQI3QFiENKEUoqGc4PhReuEo1I8O5u6JAOmvCU=;
 b=lPQciPeWA805dLusjyjD2+8Ejfgayj+3pH5grqAPdg7MOhKJ3j6h8wien7pobiuwFsOhUV6QdNj1+MnaxsnUmvliOvvsoraQItiixDEMPh8zUAkn5h+F+20NQ/1iFpAjwY2AhFyT7rg6fT6AdwjeOx3TCYNdfuyQisiY0SsgA8MZR2r5R3d93a9KcBK2HpBCjnIhzgTFw14z5UBDxH4pUUz+SgqLED6CoCtrAe87euSpR76vENXLVa9Q/DpTgitvtiQyxNBEgcTqvhdpKLyUMVdO/WQPA9qBapFmRmOdgH8yc6tQwgeeaNaQcU0qHtTYwSUUt5twsQgVfYpem4IBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB7857.namprd11.prod.outlook.com (2603:10b6:8:da::17) by
 DM4PR11MB6382.namprd11.prod.outlook.com (2603:10b6:8:be::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.10; Fri, 6 Nov 2026 04:05:57 +0000
Received: from DS7PR11MB7857.namprd11.prod.outlook.com
 ([fe80::3552:897d:29f7:e0e5]) by DS7PR11MB7857.namprd11.prod.outlook.com
 ([fe80::3552:897d:29f7:e0e5%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 04:05:57 +0000
Message-ID: <207a498f-6bd6-4e9d-a050-eee863d25237@intel.com>
Date: Thu, 5 Nov 2026 20:05:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/28] KVM: x86: Add a helper to detect if FRED is
 enabled for a vCPU
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
	<dmatlack@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-12-sohil.mehta@intel.com>
 <f7f84b44-e2fc-4d8c-b2e5-e5327086d026@linux.intel.com>
 <60f7934b-5271-4207-b071-6240b5d36cc5@intel.com>
 <e4faa073-9cb6-4809-bf00-c4c4f669dbd0@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <e4faa073-9cb6-4809-bf00-c4c4f669dbd0@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::8) To DS7PR11MB7857.namprd11.prod.outlook.com
 (2603:10b6:8:da::17)
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
X-MS-TrafficTypeDiagnostic: DS7PR11MB7857:EE_|DM4PR11MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e32295b-1e52-4546-6500-08df3bbb4284
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|261022075727099003|261026140227099003|11063799006|4143699003|261009223027099003|56012099006|261021121427099003|261028144727099003|261022105027099003|261026121527099003|261102123227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: tPacwIQkZ4y/7nhBXQzIuVCmY8dz9PJ63a2y/4aYFOJXtE1NIHGnOrBVTvaejCxYkIwA09O4Tdzo8vaynX35jvwDREBiePB6s4WHnfwGOmu3agwTNPEAP1/czV+wsculs8lbXZGrrOTZKm6s7OT8GWCcC4qlywtC0BwjDEh47oCaaOBwYXhZ6B7jxtOqmclVp8P3uh7dCDWjs7JIdqE6jY8zTSWJ6XKIsBeRhi4p/hd0xQs20wB6Sg6IvlqR2bZsf9/mFtVgdhTuR1568lPnfpQhNXwBmpN1cCquSux+mT6dGYYvsJNnjE5acM+5v2LPSL4jxpWF+nmgqlgicQY3ShJcksiXrxaeBd7lT3oEj55FWH4yV6Y95nmHuVVWnSn+Djm1vMwK6nE9nT4WkzTtOaguSzETH3cIu2AZV3EceGs1UscR0y5uoC8QNcOc8WKiUc1iFCIH13C2pzh5F1i+le4R9tXCAzEVSs3n+old9KvG+6Q5PLEpn+nAuCSlSOGtq3Wzi87mxGNHXC9+rjaVr0c4xTazE/A7l7f9oKf9IK5rYCaLI8jWCy9b2KBEN7/7HpIPH8eF/UbXHyDQCQwQYGW8SPwFuUjr57zZNsPHjBHJjug8vqDwF1/YdMki3wx+xewCUL4+rS3+OJZAB6H9Zr88ByeDlc538kREo2Ub8rE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB7857.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(261022075727099003)(261026140227099003)(11063799006)(4143699003)(261009223027099003)(56012099006)(261021121427099003)(261028144727099003)(261022105027099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGFSR3dmVS9JYUt1eTF1aGNtVHFOSW9hVEVoMGp0cW9BTy9rUm9kQVkrcXBq?=
 =?utf-8?B?bGJwaFk2MkJlcVhSR2NROWZzaDVUN2dLZDZVcHhjWERVVDZWdCtPWHYzRzhs?=
 =?utf-8?B?ait4UU1mWVNQZWkwZ2Z0cGc5UWhRbjQ4UGN0REY2WEZtM1liN0xVS3owaHM4?=
 =?utf-8?B?dGVaRVVFTG1KQ01rYTJXUVJyQ084QlUvcG95NTJlMXFmK1NZNU9MbjUyMFl4?=
 =?utf-8?B?MGtkbTUwUGwxRjZjYlVDNGpuOGpxTENEMkJjRnlaL2M5Z3BvU3M3OHlDazB4?=
 =?utf-8?B?MDFNMW8yL1EzWGczcWtFZ25OSi91TjB5MHlJL1RVaDZNblMwNFJNaE5sR0Z6?=
 =?utf-8?B?dHJ2S2hlMFBGTWFya3NianI0UkdVU1NuTlV2MURpem4wbFowM0NtSjl0a1ZN?=
 =?utf-8?B?QVhuMmVaaXZXamgvT1FHU0VmbFVrWWpraDhpSDk1TlNTUCtmRXU2SjNud0k4?=
 =?utf-8?B?NC8zZi9GVUYyNVJ4YjluZWJiRWE1STJHZkFRdVAxN0tVT21IcDhUTmcrZms2?=
 =?utf-8?B?U1d1a21xMzl6VUs1N01CbXo3Vno1ejMzSUNyNmxFOFk4S2FjVlllcU9CV3N4?=
 =?utf-8?B?THZCVThTSVYxT1VFQk5hMys1bnpqQWhhSnBOeHlHTm5GSTd6TTRKcnFiKzFh?=
 =?utf-8?B?YlF0eFI5dllFY0xvVkgxQkxsT3M1Q0E3K0gxVENYekN4WE0raWN4a2tLL3E1?=
 =?utf-8?B?dDhSbWJoL2p2VGVBN1dtOVpNQ0FYN1E1WnRlMVNZNlZ6eXRQTEpZTWUzQnp1?=
 =?utf-8?B?YTh6YzRCRGNxc2JxMXVLelFXWDg5NDh4SnFCV2JXVmhMWVp3cHYxUzNyeTR3?=
 =?utf-8?B?K1Bwa3ZpWGY1Z2o5MlZ2RXhCd2ZHRTlUd28xQVhVV3BqaXNsSjk1Z3pMcGJa?=
 =?utf-8?B?UzRFWSswdWpBRlowSUs1aTVSVGRDWEdzSlBaSDV6V0Qvc0lrNUowQ3BsdVhp?=
 =?utf-8?B?ZWkzTWdaellnT3dxaUhHaUk4SEwxVkpGL1pRNHR6SU5meUZSVkhJR3A0Q1RZ?=
 =?utf-8?B?YWo3eTJ2cVFENkpvSGJDZDdIQzE5cVJna1NlNzRMZUtVUDc5NWV5TFVDQk5N?=
 =?utf-8?B?NkN4bVhadERnN0N1ajI2U1Y0VWF0S2FEdTEyNFNnNi9jVjVWWVlSaXR5NlZT?=
 =?utf-8?B?V2hsNFFjSDlhUHJPQ1JPMGl0cmNDYzFDeHA0eEhKTE9qM0lKaSs2QkwrZDBy?=
 =?utf-8?B?OCs2L1B5MDluSzZGUVMvdnBLNTB3dHlReUI1TzdsRm1Bb2JNNmNPQnkrcTRu?=
 =?utf-8?B?eTBmcWtraDNpZmtjKzNFdmlCd2VYSkYwWnNldEFVQ3Y4aDVjRERRaUcyK00x?=
 =?utf-8?B?ZVJXOFJtanhWQVFBVUF6cGVYSmc2bkRWYkRDS0F4dUFYQmt2NW01YUo3clNu?=
 =?utf-8?B?YmR2NlZGc2tBVHlMTjY3cFFnMnlNZnhkblNENUNwVVBkR3Zoa1hsdnA0bVhM?=
 =?utf-8?B?dU9FTmwrNk8vZnUxc29VTlIrbGVXM0t2MDZJNVlHR01nSE9wamdsZXdNZDNX?=
 =?utf-8?B?dEo5MjZMNXdqU3Z5anJwdXhyQVQ3K2VhZVM5aHVDSlMwdWFOanRZNkpHcUtL?=
 =?utf-8?B?UlhOZTVqS2EwdFF5OEgrVmxlV1N3d2h3Z1NCbkNJRFVVVWJPQ0NVZkRVRUtY?=
 =?utf-8?B?OXpKVFlOVEtrOG0zSFQ0TW01UmhIdWM5Tm0zSFlJci9UVVhialhSMjA2VHpE?=
 =?utf-8?B?ZE5vKzhUQ1REaEJ3c0JtTG96MWhvU2UwdjlDeDNjSGY5RHVYZ3JMd0Y5d1pz?=
 =?utf-8?B?YzNCVnZURGpzcElvT2RLTkw1eUZGSnFqUHVmenQ0UVJqNGxlWmJmTkFLK0Nm?=
 =?utf-8?B?dTUyS3pJYTlZM1NzeG5NdXBreVdyL0FwenBLcU9JazRMSUhyTUQvSmY2Z3FL?=
 =?utf-8?B?TU16NDczT0lwU1Zqc1FUMWZxSGl3bm9xVFluU1pHYmduaXYybTBMWTIyVHBr?=
 =?utf-8?B?UEJBZzRNY3ppc1dRUU5na1I5ZitHS2wrRjhLUC9Xa3FxMzk3WHB5VFJETGR5?=
 =?utf-8?B?emRnancxZ0oxOUo3L3RqRTVlY1NqckNWMXJhcm1nalorUUdzd0hxT0R0cGtr?=
 =?utf-8?B?TzhZMHhhV2ZWdDVpT2ZKeDVUTy9vMmMvekJZZVk1dHR0enlNWTBRa3Fobm1U?=
 =?utf-8?B?NnNUdFZYMGhkZlJMZ0YyQ3QyRlhpa1l3ZVlEQzQ2K1NEbHJVQzk4cG5uZmhS?=
 =?utf-8?B?U2pVYkR6WjFFSzh4Q0tJemlBZHhQM0VxZmx0UHQ1Skoyd0J5cVJCYXBlYTc2?=
 =?utf-8?B?cW9FQjNJSEw1amVxdXEzT05rWFpmaUFlZkFpS0hVSG9nekE0dHpyOTQ2bkFQ?=
 =?utf-8?B?RzBOa3J4K2JGWnBXZ0hSdFBxY0pZRUxVSDNBWHdzb2R2YmlqR3FSZz09?=
X-Exchange-RoutingPolicyChecked: sPBRdqi0/NOqXbrYXA3MpyBc3PALwn2sZsLRftEH2V+05NtR4Wzxqjq6Q6tu4o4LddmSLYbuYu1V7ThtWLeVPFj0afoD17JPnBwG8hRGraFsNFdd8ygw3PArxyLEW7Lfb02lnejCu3m03bj4in5KuQok7X2u9wsisJwoK4Qu9pjUmbcvSuBPVyhC85MqJszkH86d+H23U9NA109nwRxcxp0tBM0mdFP49U+a0K3rfY7v2FpICrbVmjH0blSvUpUnj1EqmbRoHNFo26zz/TlqsOZ+/DczXBzRndRtSJQ9Lrdo7+koSwUAkamhAZweEVJ9bQ/lTZ8tO9wZQLVMddYg6g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e32295b-1e52-4546-6500-08df3bbb4284
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB7857.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:05:57.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHX/8QXbZ247jQWiTcjFf4tq5iYPeBOab9jwk900Ug935nsQbNXYSwFQXZjSMJZKJ6bNq2MMRen+S3EsSxpZaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6382
X-OriginatorOrg: intel.com

On 11/4/2026 9:16 PM, Binbin Wu wrote:
>> Is the suggestion to add an explicit check in kvm_set_cr0() that
>> mirrors the PCIDE one? But there isn't a fault specified by the spec for
>> this case.
> 
> Had a second thought. As you mentioned below, if em_{jmp,call,ret}_far() is
> triggered and CS.L is cleared on ring 0, even KVM doesn't check FRED status on
> far transitions, the next VM entry would fail.  So I think it's not needed
> to mirror the PCIDE for FRED in kvm_set_cr0().
> 

Yes, agreed. I'll avoid the check in kvm_set_cr0().

>>
>> Sean also requested negative tests for things like leaving 64-bit mode
>> with FRED=1. But, I am not sure how to test this.
> 
> Maybe it can use KVM_FEP to force the instruction emulation in kvm sefltest
> when force_emulation_prefix for KVM.
> 

Okay. I'll add a FEP test that validates the emulator's far jmp/call/ret
behavior.

>>
>> AI tells me such a mode change can happen with emulated far transfer
>> through an MMIO far pointer. "em_jmp_far(), em_call_far(), em_ret_far()
>> and __load_segment_descriptor() have no FRED checks, so none of them
>> raise the #GP that FRED spec 8.2 requires."
>>
>> Chao had brought up enhancing emulator code and making it FRED aware
>> [1]. I am wondering if we should revisit it?
> 
> Without the check the next VM-entry fails the guest-state check according to
> FRED spec 11.5.2.3 ("If the DPL value in the SS attributes field is 0, the L
> bit in the CS attributes field (bit 13) must be 1") VS. With the check, raise
> #GP instead.
> 
> Not sure about the maintainers' preference. But a check on FRED in
> __load_segment_descriptor() looks simple though.
> 

I am inclined to add the check as well. So, I'll include it unless
someone says otherwise (or it gets complicated during implementation).



