Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792721400;
	b=5gMI2Jj53ctPsjPvR0CMczp+hDfIVYgUntZr7d9FLNZ5C9toR16zL1KlzGlHCwQl2EPV
	 tATpbU2zBUwPAwnyf1KCWNxeJLTV73k72xvQ9LTI0FDtm0yDKpa2ShKx5EAqI/HhUJrJp
	 VG68wLpgHHRUgduavVWmcVa7swJl1Gh+J9XIlC7vXt2U+G3HMhDGHFYVcaZdYJ1wMF1x3
	 +pEjzPkoopWeaobR4rbnPZzwk0qwm6OIMeHOSXAK1yYSKuSRaVEfdXl9siOLttzHpW1ib
	 bV3yQQ1DPnV99W4wF4vUCmpk09RCBUnQV7FYKHF78ToOGr1a74RXKwc8sPInTcYr1/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792721400;
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
	bh=7zNlwiH1N/9qDYL1EzcQR2rRs94gGBl5nWSn08VFg3k=;
	b=1VJzjqBYJpc0bJRB8rFM2Vy8UsRm18UaSipB2r0WnNruw94KRpdtjdRcFdxZIB6wNehv
	 KfULykptDftx2/QyXtnFco3PEkVbd8nToRbm13tw/b9R+x+YEUxPN+jff5PHT42c6zalb
	 qQ26zoPeL5v314m5UTraMbNxfgNr3Il8K9TaGr0mgfg5t7bkEQXJ6XNrVdDDlsYyiX7mi
	 kVTQcmGknTNOSScExbpq0BLTY6OJNNW5lzCCiAxRfTSq5gPZjFKTWTui9LehB3POP44cl
	 1zxzDnJhxfEkmMyj3rviIf6hZtJrZw6BuE7WGXXKgenfOdYGOJg+ViHf1NVm1zNt4/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ESJNASYd;
	arc=fail smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E92606A319;
	Fri, 23 Oct 2026 02:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7E92606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ESJNASYd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792721399; x=1824257399;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gq5Ji+FkS5apj7QREEaqwbe9yn5OkzKnrmVRrxquEMU=;
  b=ESJNASYdPkIIKvkcP8XuRjOF4h9UKueGpi7+zTuBEwJ5brEqH1IEad6V
   20y7kRsoPvobGEos59tYDbFfS1ZlD0G2Ribcu7L0MbF2v7binFRUYLSf1
   D1aXMRgSu2qN3EBuH7fzOSr3CxOmy3fJGW6PMXOePwNJKTqfphBHMysnx
   WHRA/VjQue24E43Ew1UbVKksWpwhanLQXL+ie2+F/NNIL/2JsJABA+K9a
   7l6EIS0LBqTQMp54K//MjMUX797deqVmv2ynlQ+TbMqOPAQvG+cd4CYjW
   qFVICy3P6AMu3o0Xh8d/i4sTLwDS9dqBvplK3wkOBnpQh0wjRO4VMrEQL
   g==;
X-CSE-ConnectionGUID: VO1MeqCeQq+JDv1itDWCAQ==
X-CSE-MsgGUID: ND/qRMSjQ5+Y02/5BZ3yow==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1361340"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1361340"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 19:09:58 -0700
X-CSE-ConnectionGUID: dWC6gdoaT/WNWYvy0qT5FQ==
X-CSE-MsgGUID: LYlOF7/IQSyzd/t256ao0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3835475"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 19:09:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 19:09:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 19:09:56 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 19:09:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTWj4Kd2mTNPVTbJOZd//O75h5UNPSzjhIcJqS9DmnHZPsBg9ekfoYmskF1m+LtlP5kb+3GuvLH+vLcm0vj8Qiib75t34g3a0G3+L5BW84/GNYLO5s5au6b8fmCRTfGxjbLS6sT+N6ez90/eimMWrzbwrx0qQUYnYph6+xoEVfNyDKevx7gFyfwlyZajVWgKkflsMayC86/bcz5PcdE5jyk1djUoRkTq1kgnKoHFsrBu1NG3W9YzkxcfcILDyMfzFvn/309xnUxauy/I7cE452giJA8TkMqfaPl0QlTz/jtxS5BsZL9abGHBCHToAkSv6Fn3sQRwxic9ARQvBkuTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zNlwiH1N/9qDYL1EzcQR2rRs94gGBl5nWSn08VFg3k=;
 b=ATuttq8XWbgHwG0NnI4hAgFkxNZPvApriYMIEjhLAPCQ6BFRrdMGnqHlncsJcL3K8tTxUio0Abwl/BefIuZPdh34XFX9sdp3DPCaUp2Gn2UfG8ncs+S1ghHfQ1Qgyo5UDzjaAaH8KXxMwoOBJTuAjMIJkUrtFikJaGMT+fhIVxljrAu1WLhFFluFtxOc4tbS73GqWLeUMfVxFfHq1FJR7W4afQ4jLal1DKLLFVtP6yPe3YjvZI+W+Y/TLN5nKCGC7GRxVU8Ttjyx95EElFI5so8hFLkTe1YG/hH0Kq9tcySdaiUTTy87r1WNsA7zJBRDbp6+7DoRL5ZOGg57naEECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by PH7PR11MB7004.namprd11.prod.outlook.com (2603:10b6:510:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Fri, 23 Oct
 2026 02:09:51 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 02:09:50 +0000
Message-ID: <91c1426d-b479-4e24-b1e4-2ce8b27701a5@intel.com>
Date: Thu, 22 Oct 2026 19:09:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/28] KVM: VMX: Enable support for secondary VM exit
 controls
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
 <20260911213659.2025974-2-sohil.mehta@intel.com>
 <1e219be9-e7c8-455c-a3ff-10f80515d4dc@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <1e219be9-e7c8-455c-a3ff-10f80515d4dc@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|PH7PR11MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4dd0b4-8bcf-40d5-5047-08df30aab7fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|56012099006|4143699003|11063799006|10067099003|18002099003|261009223027099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1ZphGhNFNnU9y4UAIk+JAnolozGXi/J/XjzA+m68LO5PU2bHznn3H/q/EhY3bbxt2uiphcunZVIrUmwcVC8/Yq1IvKUd9PBMvpUUxN2S2A/yHFxE8byY3OtD3DXBGYKq7drpGTfEyne8Jc7b5GVVIr+3z9bnbYUO3pLMO1sToVyD7iVeqW0FmLe85L/C05ITJI5dQqvTPIB9lQRGdOZIG5qbedHsqD6/0/01XVZ//y7Z/64PtdzS6+Hi/zXgrcYMN8UVBOVT1vFohKkQqTVv/3MzzMMMpRKuYvU3tL8C3Ntz0kO54I8IXQ7gTsAnRc2D4v/hbhvaq0x7uK1866fINvEeiglRz3thxw/x7ZmU1IgOvlo4Il100TNwwkHpmQduQzpAoqd+XTIbLJc0gyljtboghZuNMds7ngGj3QPMIwJ9y32DuvFkOGpQKWxKkzpYvn+9xNBLwpJl9ji3c0iAQRJUpq0NHZUuKoyda9+h9I47QBhXp8EUcTVrTWxGTyPNo5YT5trX/k5F8U51jgHG9lMqV6J+2/XPrQK+zzIPbeidYLHwl1BKVV9vkzvN6ZP5UkCxck4Wvd65mvLCnh9nOVYUivK9H8irP+GTVQqwI4qMYBtgGf1nT+swpR9L1Kz8nyifpREkwRN8HVIIwow++SYi1p2T+ZEOQo+7vMYOoH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(261009223027099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUVQUE1HSUZ5MUdJSlJsd2ppVUlpOHQyM3FLbUJ2MUkzeDFXVTFLNG9zRmhU?=
 =?utf-8?B?UW05UzA1T0svd2JKQWlHNks3QUd1Q1dLeHhWREF3SGVBUmtLTkwzcWpCRmkx?=
 =?utf-8?B?eWN0WkxQZTJNR0xGYmlFN25VNjZhUTVKVitac2xzVlVzalp1TTZvc2RHcGtj?=
 =?utf-8?B?OVFTbUppTHFzNldsaGk4OGlEQytkeDdOVVhuSXV6dllFWi9UOUVOQXNxY0o0?=
 =?utf-8?B?S0d6eHBVTmZ0WG5vRDMydVgyYjJyUzBrWWt6THNzNXZiZkVMNk5XdjBUbHRn?=
 =?utf-8?B?T2pRdUptRWkxTE42dEVaQ29sTXpRcldUeGdQUVZ6RG41bmRMcmFibmRBTmNT?=
 =?utf-8?B?ZW8rWmpIUkV3ZzNGczhFekxKb004ek9wdjJLT3FxR3VCTk9PNHE0SVh4NkpY?=
 =?utf-8?B?dnhVMFJqU0xuYzVZMnc0TDJJaXIra3oyQXZtanpOUkViK3d3MTNwdU5uSURu?=
 =?utf-8?B?Y2ZTQmN2VXY4TkJ1aElnTnE5U3JQeFl5OHlsUHczcVhTNmpsa0Q0ejJLVjdl?=
 =?utf-8?B?RVB5bURaYzFqZjdYZndlanNwVUxUNnhoRTIyU2E3R3pSallGRkhOSVZVbjVQ?=
 =?utf-8?B?OUJHTS91L0EyNStGOFlXdEFYN1BRZ2pTM3p4aVRWcEZXaENCTUZGVHVnanFD?=
 =?utf-8?B?UDJwZ1V3TGVLa2dBQitwK1pZcE5pQnl1LzZZQW1hT1NUSGorZ2pBU0hKODJn?=
 =?utf-8?B?K1lZN1IxdC9vWVZjVEp6dHJ1WmpWSnY0V3d1cmhYUjQwMlFJcDBMVWF5TG8v?=
 =?utf-8?B?TGIwVi9uZzFtMlgycWJXYVptOFdrbnNYS0NQYVBVaEZHbngyVkZaK2UxNjRa?=
 =?utf-8?B?czU2cU9nRlo2eTdac1R3Zy9RL0N6eXlpOFhNUWJmd1BId0YyRVQ3eFRPdUp0?=
 =?utf-8?B?MVQ5alBSYUh3RWNnQXRqb1R5S2JsblZ3ZmMvaWExQlFVVlIwamx1eFdZWDc1?=
 =?utf-8?B?cnBqS216YWlERVZYdzNUaGJhRDBNMGJSRG5FWWk0YWIyM0lNeXRWc1BTOGdW?=
 =?utf-8?B?V0g1QkJwcGtyU0hTZE1HRFpGQkNZWExHWmFYZXlYeXJwakx0dWtuODR6QkZ6?=
 =?utf-8?B?ZFptMlR5TlBTREhNTkJ3UFZDbnY0cUVUQUcwVzcvR0h5MGxETTk4blBmMDND?=
 =?utf-8?B?YUhJNXFTbDZiS0tQcjV6L295MENSZDdHQkNkQ0pXQjlVZVJ5SldpQndtejA3?=
 =?utf-8?B?bXFoYnI3bllzQVIwK2pLYitrN1JCZEZXamFCSG1JcWk4VnlleUFEQkp0SXZU?=
 =?utf-8?B?UUthV1cySEMyd1pUZjRvSjRYSlBwWnMxTEdRWWVHUmZKdGlhRUdaeW4xeEMr?=
 =?utf-8?B?V2VPVzJtbm4xMm9PVG9RSTRKRGc3UkQ2RXZOMkY0ODNxNldNTmpGWkw4UUEw?=
 =?utf-8?B?TE9RaGJrdHlTU1E2eEF6M3V5OEFKUlFDL0ZLYU4yOUlaWUV6WmcyNmJhTWdP?=
 =?utf-8?B?ZW1OY1RPN2VFNnRYcEFxM1NYYnBVVXJUbmVGMWNqMVFKeUQ0bjRmMm5MUUJ2?=
 =?utf-8?B?UWRsN1ZHKzBqSmhNcGo5dDJSR1lDL1J2andxaTY5VFhNWGdNVzQybDBWZTlS?=
 =?utf-8?B?WWkwamVpV1lKRzhMbkowQ01SK0plOGlzT2xFc1RFWGprdktPbTFDNEY3cFN4?=
 =?utf-8?B?WXVBWE5adzJuQm5QMnFrUEdjVU5ZL09ldExxWEFJM2kxeVNjZmxiamQ3K2dV?=
 =?utf-8?B?ZHl5cE92ZE5QaHZiUkpNS3BYbnByM0gzcnB2ekZmV2tlQWNJV3VHbzM1NHRs?=
 =?utf-8?B?ZUF6RVNqUXBIMC92OUNLeEdYVTluSVovc0tTaU9IUlpndVNwV2xoOHA3d0hu?=
 =?utf-8?B?bzVKb3paOTNub3VqRERReVUwSW9sNGsrUllQcnlWYllqVEZzdThKaHYyeHlU?=
 =?utf-8?B?eGc4VkpRLzU4dDhaVnI5MGtqRnRkU3N5aVpWeXdkbTdMU3ZHWmVWamdqbURP?=
 =?utf-8?B?T0RlbzZpMklRcnNxY3J2c0hsKzBZTzQ2Zkw3WnRTWmNYYVR2anVMTzdYR2xF?=
 =?utf-8?B?RHlLbGtaZ0NLWDR4TnBLOXA0MndzcmZPaFJrNW1ObW5jcHNOU2IydHJQS3p5?=
 =?utf-8?B?ZXdObUE0KytQVUVMSGhrUVdod2Fyd3A1Y1FnR0cyRGtPZkhnZVJFSTlmc2hx?=
 =?utf-8?B?Q2ZkMmFHSXdDTVRCUnlBTUM2cjFVU2xvYUplZHdUK2d4eDNqNzFsNm56RERQ?=
 =?utf-8?B?NGo0UW9HdElkMVo4WXJKZnJDZlE2K0N5aFlRczYwVDNSb0gxNUNZVjJGNHIw?=
 =?utf-8?B?MDA1UmM5OEkwRVJRQzY1dUZoNXhoalFDVTcwMFo4MDViZm1sT09vQjNuUC9m?=
 =?utf-8?B?ZFVqbTgxeThxZHhQUDdvSFcxYngwNS9kTmZRUVRvM0lGNk9SaG5DQT09?=
X-Exchange-RoutingPolicyChecked: hl2MidBbB9z9umO2HOmjSNCaYrMAlCS/J/cbIwXB49bFnymmLDc/kMF83yV0fmm86kPPWhashAbhBCMCU7m2XBKhJFEwr/AlkQUm3qin+zNN8dYaa6p2U+TJzh81Z5q2pkMZbJ49zqC9URVfBFPejRHqEA53pkPRVJTKSECmnQtZ5w21wCI4jjjRaDKUARPXdNf/xGv4lybvStnLZ3U7IOZm8V2jdnG1360M58hcWnHCG+UgW1pdkexKomJR7ZSkyvHe+w1IOVWrqUMkMmiTbzvd/vzlW/6V/08QOruuL/T2dLHDH33iv0WhWrV9f1MTbB/c/rcL1kqu5USBc0O3Kg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4dd0b4-8bcf-40d5-5047-08df30aab7fd
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 02:09:50.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: On71KCp+M7996+dnyBN++CAr99uh9rToEGsiXYtwzUFdAeek0BahGvi0HbioQOpD9KEzR8bgoiYbcEMylBCLwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7004
X-OriginatorOrg: intel.com

On 10/22/2026 2:27 AM, Binbin Wu wrote:

>>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> 

Thank you for reviewing the patches.

> [...]
> 
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index 504630f0eb40..b4aec4218b7d 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -2751,8 +2751,9 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>>  	u32 _cpu_based_exec_control = 0;
>>  	u32 _cpu_based_2nd_exec_control = 0;
>>  	u64 _cpu_based_3rd_exec_control = 0;
>> -	u32 _vmexit_control = 0;
>>  	u32 _vmentry_control = 0;
>> +	u32 _vmexit_control = 0;
>> +	u64 _vmexit2_control = 0;
> 
> 
> Nit:
> Could be _vmexit_2nd_control to be consistent with _cpu_based_2nd_exec_control
> above, as well as vmexit_2nd_control in struct vmcs_config.
> 

Sure, will update it.



