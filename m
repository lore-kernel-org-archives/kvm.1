Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792448386;
	b=ZDCm0UcBABuw6k1V9O8mIalvHSYgnoHRY1E7RfTf5OuoCC/DKVKDI5edWyj2mcNrVZuP
	 NlVd8FhY2M1ZJ/u3vicRGcXJF6XopZiUXmwu5NA91qGAegrNKs/KkHxqaYyyYQbLzhbnX
	 GmpXZ0F5Om2Ag1VzEO1WSdaEiLlj9IpfOKKSons4iiGf121f4Vj3Knyh7B6OSdI3Cg4ds
	 7kbhvVS09tsMEiPTUSZH+SYjD3f+9ZM+ItcEFNiMBdbKYVX1c8liV0AWdIAMQkTRFPQkp
	 hf2sbUtuTAjT6TzEHXWoiO47WyBW3FqRs+0ztvwPX6ciTZu9PmHD7eICfrjBsAofJjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448386;
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
	bh=siNMGnpp6fWEyBYNCemuCMtZx9uDKXBkGAQiGwYtDW8=;
	b=35mhlJEK+pHJ7ZZO61NHykkR8vyIS6hYZrMJiOhjvCTFw+AFlQE2wHVdlqua+FkeSK3v
	 /3q99GpYfuNm6gcCBsPl3i/BMDNUn7FevXqcMXaNZVCOx02hPFbN8ZAXLDPgccBKZlGCW
	 wcqKpTTWJzbDTgnkJIZKOxpEfubm/bEqRtXTY1Vn546R6Eh8FVZ6QaTrGjp6oT+CE3qS1
	 ZnomvfIsz3OebI9m76Y9wrRvuaMgwrHZSKL2Ug+KRw88pU1+phQ7ZUd002dqzDFMejAGm
	 fpNnI1Tl7Qx9kJ6EDzwrU8NSma0WBIAfY7DFUoqpYPRoXJ1JaRUlNSmElJ8KauDIzpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MSZprOLB;
	arc=fail smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8D6606A319;
	Mon, 19 Oct 2026 22:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A8D6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MSZprOLB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792448386; x=1823984386;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mAkbqKgR7Gq5/a/icrnBIhbxXqQgnVtrvuYQ6nJsNus=;
  b=MSZprOLBOKCx9kt3/U/4K6CuccwGC9P4Er9fIGbRC/sROy2jLH8wTctj
   7YCmGGBYK2SjlSFd+C0q+YhSsobJn5jy4nNHXiTmadI/+SS8Fy3jQG+8c
   EezV5+uHVbOR3abBOiGDNu2FT5uRpVajwhO5jPGABuX6uS/Cht5LK+OTd
   coG79iYcfvY99uc4z3ipAVy9rH9ENS4wfwSBPbDZEfLVCKqF3TD2K0vn7
   quojRv2VFB0/hPI93hpJKtOhRDyLm3JIMbq5je5B3jOMacFNx4frfBOs6
   r68WXN2hHFl+8FKc85OsiITmxOXky4b1s+P5tO+EwpZeFP+unZqazLUDX
   w==;
X-CSE-ConnectionGUID: jHP0ZgKOTwidiqnj3ivwtQ==
X-CSE-MsgGUID: xzM7KO6gQG2NMNuGD4KuJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1042566"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1042566"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 15:19:42 -0700
X-CSE-ConnectionGUID: ECVggeiGRUWL1oSOByMrxA==
X-CSE-MsgGUID: oNnloBfzQWu/a9a6goIfNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3024387"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 15:19:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 15:19:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 15:19:41 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 15:19:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZiz9WtdvF7RqBgkyduMgiWycgLqPXweaSnkmfCMuaN7s/LyWmY5NCNTaWYlmB4TeXroeeQrqMd3PkZWCzlT/b19onD9CnxUBNGqHhlnVE/qq6S+71sGhfn9d6qO271nlIod9eiJ+N+7jVK4iLZMqVS1fcwezPhh6vAfTxYEat/9wcpkhuRAftUXUuf7oeaFLnVCvN27oa8EerLU0RzjLwp9fK5Ky+4+gUO6lyR4WBE5D+zoy6SGQ88HnMlEDtLWSfp6oRYo9Hh4zFhcYw/Biwkz6pgK0busgNQK70tADbXFPhJ296bNkTRtwpKFdi7+fGqJFFiX8nD8DyCaI8MfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siNMGnpp6fWEyBYNCemuCMtZx9uDKXBkGAQiGwYtDW8=;
 b=ajfggcQI2QJPd89sAsaaA1Y9tInrhdBVOmAVuWldT/qTZm90YdcjvYGQ3o52D+tU63u/GFL3poFM5tWK7WfQ9QtZvDD4dhL1155/TVyY3MyJYWKNFbGa3OvfdrfIJsmbiuv0XvTpgi7qveYJKYMFCTk09sPc1tSKOWKEBq8aRj0p5e4HKismj+OL9Acncpw5axzcWzThFRM4Osadur+GnYt52Q4xNkNTPlNp1v2xz1xkb4sk0IEI7qjGZAHqBmOBdbe9GI6WmVb9wLAR81U6FiCzEarIfGtHQFfEc6qOTK6kSAtjxtyBHzFqAQZt/HiZLEAsisaUDgWbVyljttMxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 22:19:35 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 22:19:29 +0000
Message-ID: <99404dbc-49b4-4c91-8d80-6526109cc301@intel.com>
Date: Mon, 19 Oct 2026 15:19:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/28] KVM: Enable FRED support with KVM VMX
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
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
 <542f22f2-9140-4bf3-bf37-e79a4b99d3ce@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <542f22f2-9140-4bf3-bf37-e79a4b99d3ce@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|PH7PR11MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 0778733f-be78-4bf4-d176-08df2e2f0b2a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|56012099006|22082099003|18002099003|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: TGD1FL0TL+/jv/bELL0WbEq/OLSVnWewHYMUQg+lYu4Zvyy24BYxJf6tjNK7UzyJoM6+i7DvLB6jEvZC0s4rdeX7llxn77OgPO6Gutct+XLHAx5QlxQM188Le5BlVf0rl7I+lxcxxKM51us5+2Gnc83fa+NCk61I2BKux1kVIbPB28JzTmRb5YJWeZp8CDZ2yf5CzImK3iM3j+oRagnDO6GyItTI25XZqNZSgC4zdWc2Ykg/3XYAL1z2hjitoFckKdj2fJMDz6z/+0XztOYSEdtJWPSTiMlJriJ48KVh88BRHLEgA1Y03BsbRv1Oik5p+uhuw5Yc7btJExid7CMsNpApvD0ps6cRuPGlOjkeN/VJQRiKygEEv07fP1h61+3rQz2eqcgiGChCdhaLwpGOVqFmkteCEmZWbvuqiLyTt4eO8wqr99SGL2aNSSnzQQ2uYLEgQlIhS8lAWCUx70YjTFU3bIktfLaRCkarQ9lu255mZfk40Y/w6M2CN4rsKFW/cdmcXs7c8WAyYET270k/GXPfThvT/8Wt/btBJFFDuCiTqT5WeBvGaj8ePr0V0B3ig6zQjjExiM2y+dMAt/gNxcWmaWZsU725hbhu/oOGlUsyMV8WLqeicNsuiwf+QWMZwQ3IP9Nl4KmnMZTC3WjUwqjQgr1aJs+PwMbWwG4CH9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVBSdWRaVG16djhKbWVqRDVrMHMvNTE5c3lPa0tSYkYrcUNoblh0b2Q5VDZz?=
 =?utf-8?B?dkpEc3d1R21WUUw2MFMyVEJkTXk1Y2VtTko1VFdyOEdRMVdxZnpzSUhMZ3pU?=
 =?utf-8?B?di9udXhDZ0NpV3dtZFJEWDZmcnpYdnRJRyt3aU1LNVdSY05vb2JuQWk1OVND?=
 =?utf-8?B?bHE5WEtwbTFvYVVqNjBCR0h3TU9zMUN6bjAxWWZENFZqbVl3clZOTWc0Slkz?=
 =?utf-8?B?akpoZ09CU0VMaE8vcGl4eGRxM0lnL00wVDU5VDhEUFFqTGdQcTV6LytTdm90?=
 =?utf-8?B?azFTajVGQ0xPbDhtT0czUGFjYVBlL0VXV0VFenBzWFR3NE9iTHZFQmZCQVR4?=
 =?utf-8?B?dFRPSHZMS2dDZUQyUGFTUzBkMEVHSjBwV0h6d21MRnRtbTZkcURQREl2T2Vq?=
 =?utf-8?B?VkgzVW5QbmFGNDBoeFV5bmEzekVsQ0ZpT0J3Vm5XMFB1Z3Vac2NXbUwvdkNZ?=
 =?utf-8?B?Yk9sN25iU0s2SDkveDFaT2hLVEhjakM1UXplOUJXVTBPTkVZa05TeXkzSG9o?=
 =?utf-8?B?bk9pem5xVXpFa3lEWEduNEJaVE55MDBHZ0NSUFNyOHJzY3F3VEdMb0JudGZV?=
 =?utf-8?B?L0k3djRjcDV4bEs3MEtxZEg0eUdTWFFBZUxFRzNXTVBDM2h1WG1ueGN3cUxN?=
 =?utf-8?B?SjEwTzMvbjRsNTFoa0txZ3ZLN1dYSlhqanQ5ZDVEc3NvQThYQ2NONVQ2U3Zm?=
 =?utf-8?B?TFM3N05EQnRyV2lEQURVNDc5T1cva09kdGlma2dwYmdXUW5pejJkZ1RIdTJO?=
 =?utf-8?B?RXM5Q3lxWjVsMnlLcjFYMVBFNWJCd05odGE3dFI3YlphUE9CVzJKTnl5SXMv?=
 =?utf-8?B?MFN5S0Vsa0VHZWVLMDYzY3NidjdOMEJLb2RYMkoxMXdBeWVBaFFaUG1kNTVw?=
 =?utf-8?B?WGdFU2RBTGVCcXQvbkN4MFVjOEIwYzJxMjJuR0ZwQ0E1SkpXZkptNDdpZXov?=
 =?utf-8?B?cXhBSHo2S2xYbkRqVnlLejBsbVFXQk9zVnVLMkxQSVpKVEdCdnk5dnIwUDQr?=
 =?utf-8?B?d0JSN01PampqbDRncGtKWDFHMXprU0l3Y2w1RHZhV3FLOXV3RE1kdVdGWExP?=
 =?utf-8?B?dkNyWGJ1bXcraE5BS250ckMwdVR5NnBxdlV3U3dISkxLTnQ1a09xdS9rZ08w?=
 =?utf-8?B?S2JLS0draGROK2hTUXVpTzdZTzZLMStObVZwVkNnWTJuUHlSM0hCbnl4dUZt?=
 =?utf-8?B?Sm1jQjc2S0FBQ0YraUs2d01odVRyUHY0dmRyeUdWRjZydTQvUFkydEhIZzhq?=
 =?utf-8?B?VlhBYlMvdHZramU3bFphZlhXZENCSjZlRFJtWHdsaVZuaEtFVEptY3Nsb1lT?=
 =?utf-8?B?dno3NDZSNy9TeE1XdGlmWnV2TUNXWFJuV3RtN2N0VjBJaDJQSDl2dlRML3li?=
 =?utf-8?B?MkZmQnBWV2pOeFRaNVd0bktiS3VYN3dnUkM4RFFjL1RKNUk2ODdJcmJMK2Vn?=
 =?utf-8?B?K1VWejlNYTJJZ2RtNkFEdGltN1hWSkoxTWRQSk1CSnFoY01DZ1FIQmZ3V1Zq?=
 =?utf-8?B?a0oxaFl6c0RKc0V3T2gvUHFZTGV2Y1kvYXZyY3NsM3hWNUxId3k5V2pJby9o?=
 =?utf-8?B?OEtKWllLUWRyOWdFZWJkd2t5SjRnTEI3enNqeDJnVTJhYm41RlV3czQ0SWRD?=
 =?utf-8?B?YWFueG5heU1ucHQxcTNyd2JjMXladFZqT1puZkRoUUgyNE9HeDhjazVCSzBs?=
 =?utf-8?B?eU83ZElCUXN2MWp2V29mSVFhUFBXUGxmU0JBbnEveXVyUFFyTnNXZmxFdVh5?=
 =?utf-8?B?dk9hazdacjk2dExocjRZVnd2V0pYdkxnRTl5TjQwQ1NmY2d4N1VjVllaMDBF?=
 =?utf-8?B?alE3QzZHQ0ZRaGhQVzhpU0syVHY1Y3A0WFFaN1JYa0tMak9xMWRlU2g2N0da?=
 =?utf-8?B?WmVYRjE3Y29SYXFVbGdvV1FEbU1tQXdoVW0xRXNGc3VLdXpFM0NjSzg4Vnpu?=
 =?utf-8?B?UnowNXd5RDJsT2cyeWxGOGNZbFFRcTRwU01XQW1RalV6b1A1VXU0MDJ5NW9q?=
 =?utf-8?B?a09LRGdSRUxNSHFvdC84cVhUbFo2NXcvS0tmZXRFdDI5Ylp0ZWZMMjczeUJC?=
 =?utf-8?B?RWw5UlY1N05sN290WUdxZnpTWnRHOHBXRTVyRHJReXd1VzN6RHZTb3JBSkYv?=
 =?utf-8?B?TUlEbTF2RnlUVlMyWGdvYWVGM0t4YjMrMUhUREtvaWlZV0JpQnRkSVZmZStz?=
 =?utf-8?B?V2ZwblEvblZKYWYwUnVxNVJDZlQ5OWxqZ3RuU1ZJNGVIb2xFN2xWWjg2YVhL?=
 =?utf-8?B?OVlsTXFKcXpyMUQ2eHBmNXladHhsalo3RnlPZXdRVVBqNk1ETEZ5MysxUld6?=
 =?utf-8?B?QlVjMTF1MDVMdUU5YVhsUVV5ZE5oTmVzTnVwTXBtWitkZTF5K3pTZz09?=
X-Exchange-RoutingPolicyChecked: GFPLOD505cMUchDZp56TaSQBZn0q0/2FOvYVe1mASVgdzwfeW8AoApj/kN7YzKv+b+gJliwXeIHi2JwtXhD5+JDY3KsE3gV0VAuk3S2ktSJw490BO7X9d9QR3hf0D64B3sxZ3BcOmmrq1XzyELceBX686h3r1h57CSw5u0vA1h5cxUE9L2kECMZ5EVj2EbgT0409UTYpeFf99rKGLyUxIfxNIuQXSCjeb2oRi/663ovNQSiSyjy/nwr8SWBlm81zHH1JoFM4CFy1z3hB8cowUFr7IS6HQiB349m0wHmgmbbEX533YWbZFn9ILLxD3xkNk+t0wvzlN6ElVQUvHOgg1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0778733f-be78-4bf4-d176-08df2e2f0b2a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 22:19:29.6661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqkfoInJnBw3iNjM5T27HmTEJTGUD+ylhk4hrSMfawZXDNEQDRPgTiOUEspRk1qtpVwLZHVg4mHommfGcL6YXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
X-OriginatorOrg: intel.com

On 10/19/2026 1:46 PM, Dave Hansen wrote:
> On 9/11/26 14:36, Sohil Mehta wrote:
>> This series enables Intel flexible return and event delivery (FRED) with
>> KVM VMX to allow guests to utilize FRED.
> 
> Hey Sohil,
> 
> So, one data point: I've been using these for the past few days on a
> piece of FRED-capable hardware to do kernel shadow stack development. At
> least for my purposes, they're working great.
> 

Glad to hear that :)

> Other than sashiko, it looks like there hasn't been much activity on
> v10. What are your plans for this? 

I have been focussed on getting the LASS KVM series ready for merge.
That is ready for Sean to look at.

Now, I am planning to focus on FRED KVM for the next few weeks. I'll go
through the Sashiko comments this week and respond to them.


> Are you going to rebase and repost after the merge window closes?
> 

Yes, assuming that the Sashiko issues are minor, I'm hoping to time it
with the KVM next branch around the -rc2 timeframe.


> Is there anything else you know of holding this up?

I've listed a few opens in the cover letter but most of them are not
gating. There is *a* solution included for each open (except for the
INT1 event type issue reported by David). However, depending on the KVM
preference the code might need to be tweaked.

Overall, I think the patches need some human reviews. They have been
cache cold for a while, so I thought reviewers might need some time to
refresh.

With Plumbers done and folks in PRC back from holidays, hopefully we can
build some momentum and get this series merge ready :)
