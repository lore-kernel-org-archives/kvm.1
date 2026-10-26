Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793053362;
	b=hX1aM271Dcf+ptaSGJDpvl8AbTJYNRX9yfMAFPeAXZHDk/S0o/lsjKkPnwqZDN1S4vXd
	 5paY/29DyJsopdywZRgqrMlQLlP9izr1GyETCoAQSghwjnNLrldObinYzyxHfeLnQYq3l
	 FUvRxihxXc1C5NuzL7WoUQDsXigkTlJAgXEUFa95sKphocNjxaUsZyDQluTg41eUmq3hv
	 3g69Nvh/UxHci5I+wSTq6D2UoheHJF70sH/pdd6/EKluuFiqUd/HN1rbIy5LC4NkZUbX2
	 wuzY6f400NzvFq2BhTvSIBIm9HNh24FT5s11GfGAyWMR4hUeMf6PmmgCEGZ+IMBmeww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053362;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:From:To:CC:References:In-Reply-To:Content-Type:
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
	bh=rehZe7U/wyedc5jTgaX4C9eagA7Zjupg9C1Vi8AXi48=;
	b=DbyFAE/fFoQvalHBQ8UY8QCvyTZ37BRj2j4uwQ5pbJzUzRiATOyd14xr7gRgpHc7Dsrp
	 kIiRACu/TYxvrwasDSaROJIJS1jGP7a6I9DqMr5ecE8+4MBOTu2to98lApH1kEUvVo6Wz
	 3iwRUYjbJRWkq4bbzN5vRX9IMvySINOIaiwL0DA40GzKE+LdVjhOuDWmAqh1UEB1Iptdp
	 ht3MP5LVtPYHmZD+Ld2lZinxh3KP/o6B26RwL7F0rPYxwTPXXZoEmJbczKR5xqrhJWOSn
	 kvVDas4yLbG9q+89bfvuPaTdC/XTcr16lPFfJ7CZcsjlp9ukj0NBqE9vcYefKm8vWQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YT5wgasZ;
	arc=fail smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2369606A320;
	Mon, 26 Oct 2026 22:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2369606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YT5wgasZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793053361; x=1824589361;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jIgBvgHNcqgJwnico9tDeJ1VcxvhmrzEUj4cl5gbuMU=;
  b=YT5wgasZaxV1tsV/QzlRSfxK/g11FU/vqby8DeEXnsjz6amfQPVasiD/
   xTMQRwvvkaXWbS94o6jYvLtAQcKMNwp+JhO+rsXqAcYiz5FLF+hLA4GvQ
   sDvTUeqghadjrxlpFYn/RneFH35ikES5O3u7RBK8FJFwnvuAvYlApkRE2
   Et2QrJI1RFXN5w4kawzkMKflvvzsGMYmmZhsZvTyQ+Aad4nvw7sStcJWd
   wfbIl7z4+Pgm53SvqX+RgnJeNpO3Kf8ba1hr2bf2FSu0PhCk8wQT0ssPj
   DRS4Z8zqOCuVAyO1+7vL0IrXE1QwmRNzdbqylqXJMEFy/ZFfDjLVgoRX5
   A==;
X-CSE-ConnectionGUID: Y2v1KcblR5yW54uARdpg7A==
X-CSE-MsgGUID: N7wHNne/Qk6kUCZPD1ROXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1635537"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1635537"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:22:40 -0700
X-CSE-ConnectionGUID: sibI9IAmTWeBrQvIlVhFQA==
X-CSE-MsgGUID: sv/IJHL8RZSZJvEm2E7aZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4732418"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:22:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:22:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 15:22:39 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:22:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9CItEjeTA+aKU/WXtFMPqJ+RIgCM/3SS2YglqiYE9b5infJPjUi9T55XjXAWxl+jlL5BwTq3fPP4ohLXT2syXKxl9RAFKYnoCwFYlJ1dWC4oU2WwybmPFTJ7kqcNK0pcAORt1JLRlRtvkWkdzJ/fe6X7NoqJUvRu+oU0PLk45GXL3//+KynlF3vnZmzpYYnb/NTugAil6VUB2JOwNiUj9VCTIU3NMnOklbuMDF0/e58SHQci9EW7fywl1ILIW5YSa8MGndmR0MXf8xSA5pfXEu/05yLMq622jb6kERUnEZ0BPjRXWeqqrop7XpZVq6mKjJlrkxbB49pA+uQfcEK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rehZe7U/wyedc5jTgaX4C9eagA7Zjupg9C1Vi8AXi48=;
 b=kQ1OevFkrRam+gRMDGMSnGP1KY4F7kOuKGGcDsmo8dB2WdLe4xiVQR46fzzmUd5+DzhhSz+dAOnN7CK2WVG9qyDOrkS/fP0Ll6CdMtBUycqYD66TRDYSRdIOXpLtdIg8FhPxIbubiGOUZNWKHEZGU4SOJe1mKShE8YIbmBWFRkmnn4aRcGq6vG0yDDGDimLLE0ehvNCJzoL2pmay3j4Q+81nzrrfEbsj6yWr5dIJkKpg8qeXJig5DhFJz3NSaN0b/DHH4TtKQOeLcldgyS9viYZvWmd5gdBqFdFFfNV+tzu9suq0q6aIdrw8VTBSoImT10bkqlfTsp5WROhi4QzJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by IA1PR11MB6145.namprd11.prod.outlook.com (2603:10b6:208:3ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Mon, 26 Oct
 2026 22:22:36 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 22:22:35 +0000
Message-ID: <dd5fa920-2ac6-41c9-a86a-11d5ad929b34@intel.com>
Date: Mon, 26 Oct 2026 15:22:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/28] KVM: Enable FRED support with KVM VMX
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
To: Sean Christopherson <seanjc@google.com>, "H. Peter Anvin" <hpa@zytor.com>
CC: Xin Li <xin@zytor.com>, <kvm@vger.kernel.org>, <x86@kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed
	<yosry@kernel.org>, David Matlack <dmatlack@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <E7D55C5F-91DF-45AC-BCC8-BD2759CEE0C4@zytor.com>
 <9467c7b6-d797-4462-bee1-1406bb8469cd@zytor.com>
 <at96Aex_dl8-yUk6@google.com>
 <20d0feae-9aa0-43cf-8357-fcdf617a5a97@intel.com>
In-Reply-To: <20d0feae-9aa0-43cf-8357-fcdf617a5a97@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 0ca6e8f9-b342-4a59-0fbd-08df33afa306
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|261026140227099003|4143699003|11063799006|56012099006|261022105027099003|10067099003|261021121427099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8/xW2AOUWNWL/AsCPf9qgGITdVXsTwxLs3uDNFoNZQ2pveuZ/hmfkd28wE+JeOkqRuzo7FA48Ha+C36+KRaixce737OJVCKrx1dmB+VnnbvYpMuDK2Uc+7VIuWI4m1DPdvoQW1PIpDMQYwPsxZxybzKoUBJYuzCOuOkabdbDZZNw8TXQLgdJD2/keaexC2HLMKuU4XxKMIAbOnRC58V97ebKG/44CmWvdqLCtz3PiTwZ0goQRRqdrlP8QCaLG4ckdbkG5T0DU1i/CVWKHAAR4nSPGA9o9wpvu4etCcsCdByM2uU1F09Nqx41EwmjRSwGa2v6Jx23v742IZ0IoxT2lbwTNTGf3dMQTHRBblyn2dYn2ptMu7tCaENV2ixO/MuJB6bdY1HvoqN1r7y6aJvicW+/e9ewrdbYVuKOBvIXXYuclD/9KZNEacQbbZCg54Vks/ahwxGLB8Hb4qAYJheuD8BCwV6DAxwPgPcZ2JomckZwja6/lDNF5y8o9MxJk8Ugyf33FN8ZKqt1Y4a6GCBWtElcGlWQUBBLuKcfXiMjB+84nG0BID0NF/zHfPi0tBl+tLBlmha5owg40Ru7kvAbPhbES4MwgdieOtC9sL5s2xuRkNFEnXZ804oB9tphBOWNWeRcgHuZx3inQ9SPJRKN0rHVQYVkP4MAGioyojnFOEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(261026140227099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(10067099003)(261021121427099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czVpMS9KZmRkcG55VTd6Z2tDWnpuNldMcHJJdG1ldTRjdkYvTjVKV0w0cE5D?=
 =?utf-8?B?eVdCRkxVblowSGZNN1BwcEFxUktCQ0dKenpwNWpZSXBpNlZkVzZhdzVBV01B?=
 =?utf-8?B?bWNlRnBPNFBkaTN3Zzhpank2bDcvMVRRZnV5cStyTGpPTlY2R3BzelpmdzdY?=
 =?utf-8?B?cldMY0R2a0N1NzdITW5TU0NmWEpGblJWdDZEWmhHTUZxMXlWYzlwTkdOcEVh?=
 =?utf-8?B?NVhjMzI2eEZCaE1kbDNaRENiSGE5Rm5BZVE0M1d3cUJmRGRqbWRYcFRQbHFZ?=
 =?utf-8?B?RzN4d1hYelRpd2JaVlNtVTFCMHNNYVBaQW9KT1pKcFVlUU1lZ0NPdFZxYjY0?=
 =?utf-8?B?WlNmenVtdGhWUTZ4YUxpUktpTE55Z1FRb2tZNzl0cE1IM1R0ZnpBdVNFeXZG?=
 =?utf-8?B?YnlCclc0WjdMajdEbEkzYWlBQ05BOVMxd0lSQ2QvbCtGbkNDTDVscm1iVHdo?=
 =?utf-8?B?SnVvaTJNdm1WY01YOHlXMXFtQzZWZG9OVzFmK1J3Z2tFRmlzWlhwc3p3a0Z4?=
 =?utf-8?B?QlBneXFMbERFdEk4K1hRK2xxS1ZSTTREaHRjcUlkblRrWFFhTlRMaFFBN2tv?=
 =?utf-8?B?YjJ0ckE0aHBZN29YaGpydDVWOW5YMnI2KzZ5OWtWcWxnT1dDeG51MHRyak9j?=
 =?utf-8?B?bzhuQkp1NC9IR0xpcCtsay9Ubms1Mk5hS3prVUZUL08zZGhjak9WNFU2UlVw?=
 =?utf-8?B?L3VLbnJJak44Y2dWK2RTRWhrUmh5aTBIcjl1Um5aYUozSWF6ZjRxWFZzb2pH?=
 =?utf-8?B?bThqeERBTzZwc0w1N1FSMFRKcVN1WU1TanFrQzNJZjhVSElETkVJRnFuZGMr?=
 =?utf-8?B?SEJEK3hhaTVmZVVBdS9EaGxlZ0N0N0pDWUF0Z0ZOSEV0LzkzaTBORHZzUU02?=
 =?utf-8?B?eG9tWnM2QTlpelVZWEZzZVJLMnpadEsrdG9Hd0hqcWF4NFpYQzQ3L2p4QmVZ?=
 =?utf-8?B?b3lFYjZ6bFdUSTZoMmZoc0x3N3ExZnlFU1RaNlRNQXBRNnRSQzRMM1RDY25W?=
 =?utf-8?B?Ly81bUN2b2htcjRja3lPVGpUOUxlQzBRTlJObURJYmJzek9GY3Q4M3FTOVRB?=
 =?utf-8?B?bkNsUmsyWHQvMHFLYnVEbGhOTGpUTFA2UTN0OWFjUjZFdFoyREppSWVWbGRo?=
 =?utf-8?B?VVRNQzBrcHpZUHN6MFh2VlUrYm1aMUVYQmtWa3pjRVc4ZGQ4RHhlK29rWU5u?=
 =?utf-8?B?WCtWQmt1WmxmWW9oVXozeFVoRGQ0a1pTSitJVnBRN3ExSWJFSTQ2bVRWNTIy?=
 =?utf-8?B?UEhPN3BxUGRmdEo2c0Nkc3hQOUlTT1ptM29QNkVqbXJkYi84OFd4ZXBQdmtW?=
 =?utf-8?B?blV3QkYxeGk4ZG1rQ1RodVduUWF2VWhkemRDcVlESFpLMXBlWnN3U3VrNnQv?=
 =?utf-8?B?dnhxYTc3UU9HVDVuMkpYbnpabk5XNTNiVm15UXYzRXkxZzB3Y0VvMkhuRk5j?=
 =?utf-8?B?TlRTWXZJTjJmS2FaRXEvVVlzNTRHQlRUdDZtSWZuYmNMZGd4RmVnQkxSQ0tl?=
 =?utf-8?B?eGJ3eGFyVTFYV0lxZjcrMmhxMlRsbGV6UHFtUzBhQlR6Z3BFNUgwekFCZnVE?=
 =?utf-8?B?aFdSRllNR3ExcnV6N0VpdjlCTTlMRHJleTlhUTVIVEwwanpjYVZoRnpkcW54?=
 =?utf-8?B?Tnp2MHpaVWlXY2oxdS9xYW5RWXlWTVovVVBBTnVEWUZxNUQwZjFjUlAydlY3?=
 =?utf-8?B?b21QdURHUDU5b1lKMDE3OWJBaUxwcWxMU2xqNklCbEVVbEUzVnBuL1o5cmpv?=
 =?utf-8?B?RjF3TTdlMWI1T3A1WlF3aVJ6ZXpWV2o0WGdZek1JVWQydE5GeHZTbG9vYjR0?=
 =?utf-8?B?Q0NFYzNNZDA3UnA2T0hkcnZOUlU1Zk1WbFdmOWtUbHVNVCtSTzZRa1hSTGZt?=
 =?utf-8?B?ZFVvSElrNVFDYjdKbTlnRXJIQmVtckc0NFVvVzNVcVJlS091SXUwdjh2Uk1w?=
 =?utf-8?B?dUNQWEJweDd4NGF3RUZXbkx3bjZKaVA1UlJwNFZPd28rSElCb1NpQUtnL3ky?=
 =?utf-8?B?UEFuZlpwM0J5bDlTOHVJRSt5LzJYRmJFd2tmb0JJZytSWE8ySG9lb0ZDOHgy?=
 =?utf-8?B?dDRIL3ZKR3NCZHhrMWhwQzBrNTd2WEFkbmxoN1pNQ0locm4yQTc3YnArNHp3?=
 =?utf-8?B?c1QvQjhuczg3c2ZtUVVyUW1aV3FqNldUMk5jL2NlNlJpYjJoMzdNdDVhYml0?=
 =?utf-8?B?NHMwMXh1MVVYcUhwbEV2SE1CMmdydXZQSUJWMzR0andWbTY5bzZQcC94dTJF?=
 =?utf-8?B?VjlOVEJ5RldCOFgwV2U0TDEzZ3BjUnJhM3BEdk1aQzJTT0R1RmdRajhHUGhv?=
 =?utf-8?B?MU9zZXpsNE5YYk1FclpmNmd0ZFJNRUhlQUwxMXhhM1cwcklHQy9mZz09?=
X-Exchange-RoutingPolicyChecked: qfMrdJllo9zx7VoBOAb1LdHmuzQlgKsb/F1bk9PTY8hQi37qLsCIGtd4HhiSRLwe0qVdPIR4090XwKc2gL89FGoNvVlJNOlcpND4u8DAJ/xOOUO+L/0mDx/VGSKshVlxm+YZLnjkaxF0QpwekPJYSBoOi88sdCIT3MFjttqRBifGLynC6w8R1nsyMsVHJwL02qEA7KpoKUuNXTxAPt03Lb6rVxTNnklGFS+rScuYWGvTqlnkzVDjvsr7FqHX/5OUS/9wg9xMMYUGTiwrMBXVbIJFD2EvjxL8XjYgjXXQ8j0CY5htSHGvhU448npubOWSwybXPNZLDHxOGVJqNpDaDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca6e8f9-b342-4a59-0fbd-08df33afa306
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 22:22:35.8667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fpY8/ZqYiG3PDJNV429xZ+wOHDHeR+5ajg9TfKnzLyN9GuYVIhw8QnAbTrV3xZ8p7y3HArTiAD+8LqyBumF9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6145
X-OriginatorOrg: intel.com

On 10/26/2026 10:22 AM, Sohil Mehta wrote:
> On 10/26/2026 9:04 AM, Sean Christopherson wrote:
> 
>> And we'd want to keep the optimizations to elide writes when vCPUs are using the
>> same value(s).  So, compile tested only...
>>
> 
> Will test this out on real hardware with the MSR_STAR change below.
> 
With MSR_STAR not restored (original patch), the kernel boots fine, but
a guest's STAR stays loaded and it triggers a ERETS #GP as expected when
CS/SS has a mismatch.

With MSR_STAR dropped from kvm_is_msr_used_in_host(), it works as
expected. x86 KVM selftests pass and the systems runs without issues.

A few AI generated scripts and tests confirmed that STAR is restored
each time and LSTAR/SYSCALL_MASK is left at the guest's values when FRED
is enabled. Also, SYSCALL in each guest still lands on its own LSTAR
when two VMs alternate on one pCPU.


Tested-by: Sohil Mehta <sohil.mehta@intel.com>
