Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794000532;
	b=t6iJ7oouBudCtqLbEq8tHEZck3E9uYvEQPB5gvUC004K2739zy/vRWUAWV8jCpPee7IK
	 +SWbuP+hAZaKqAzoocFTpwJgRtIZYKRNWM8c4j3FTgGv8YZL03FOnMLE8KKia+bUC70e6
	 N52QsylDpLvDNgfQSPjHKLeQUs3yo4Yg74N8sAHF+Dxa0RKo0pt+WKb6p9vSvET2uUhr0
	 bhsKKpMc5R07La0Qtch9xlXFKXvc8QR8MARSxcwC9732ffZ0RK43Ma2hBwK6vFtSFp17B
	 UXpjaJ/f32cD1iBrvzvfbSS9i/cec6972Xwade/FXvt2OF5Ze3Y9EgHkrG3NKSgeQ3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000532;
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
	bh=XnbziwQpwOpllZpJHtq9oqnRQdtsboY2ChfTiVA7EeY=;
	b=1hSYso19qhPfqIowQ+TYw+DNO1o/lAzykV02ogEs7Huj86oQiwcqmaXFG4QOQ8HHqWKB
	 o4vWkqyD9e6RHV+5oCFK9cAxj/QQ2LurXN6o/0RZ8op9/Sbzp7Toq5TeA8kKsCyP8rIEo
	 r7vCsYCDt44cqvNN/ND2or/YNWX3J4XBMykxCWgfl5uWRgmco1ZkYE3CQ0+CCs4PzeUqR
	 vKMFX2BrKxHmp2ckopWwHfBiSgE7WT0vME1+FXmNMLMEziDR6yO5iwU76Y7b1P8ePpnnB
	 sg8xqCqGKjT/PYnTcyxg2vVY1CWdEwtXO+hYlBwP4FpPwRuYkAr427sYshYniNkxq2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m7pJp0oh;
	arc=fail smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F2606A326;
	Fri,  6 Nov 2026 21:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 325F2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m7pJp0oh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794000531; x=1825536531;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f8vPKmN2hsig2KiDZryZA6KiySiw/9qrES3teabPPM8=;
  b=m7pJp0ohppRwehDNoxgugClAkgRvxQsQvoOZJv+OLiSGCwaWHecf84rd
   8ujVlkbi8ywqNcf/fo9mmKE4T89jDp82aaCmM01K2INsoMBVpLDq0i53X
   cbdsJ3kC9BbwOQtabXn4czR2LOIfU9+CWJehDNnyLA1zphica+77f2Gxx
   fYONishjfMhOHl/BHdfeu3zsqDzVME6RZsekVLdocUzHItPSlrlCH+7Vm
   OJp61HpaAjfm212RBSeOURX5hGJ2sL1hkRotVv46Nbuiouc8iCuBYfwP7
   X0To85+thX6tQw4d3bc1rMfuYqxQH3YXiDUr7AE/tjUN2DmIRorUBnzZ+
   Q==;
X-CSE-ConnectionGUID: URsxizlwQOSiEB2abs+qyg==
X-CSE-MsgGUID: 6oEDLwZqQGWMucacYf0blQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2849132"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2849132"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:28:50 -0800
X-CSE-ConnectionGUID: El49b9eiTJmKUXg1ALY8Qw==
X-CSE-MsgGUID: YHzKdYCrR9ahljcogNp1HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9227838"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:28:50 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 13:28:49 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 13:28:49 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 13:28:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSmQt/AX8wZZ+KvlVNjCeInbeSlAVfDlxL/vAA9F1v6stF6KjeIUcNVzIazhoFvjU3RDN3feAsalVqROZ6bh/2scnjPJbOWp/OFCdXUklLZ74SzjJbjYuHsSj52ergUdOp9/8OTKiimQX9zfymmcoyDLjfp0eH2J3yVBxyb56wP7iI6oThEyK1RPZdvSi9Ln8O5iQF+FzpDfs3pMAUSSXW8kekBvzULV/B6nVFqTCX+hbzVUY1b21iecS4pwSI1a7+4pImYsHe2AWKM6hZstGnpWKKp+cx6HQuMHRXQBSaE0+SXUJygtosjJm52Ojt944TwZzALTB9KTcgljnMmtag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnbziwQpwOpllZpJHtq9oqnRQdtsboY2ChfTiVA7EeY=;
 b=NtKNirhTYFEiaIdP+qG2z+0RYMpg0x5CNDPRx86+5GqKu5oTa38oRVYz6W8SV+WfVV6HlypWtOXUk7Ljh4YnMfMVmJXm08sm8kTci67nnA6pEwmsveIVtjyobozfS7csYjPTcFLZIsxSzDtW+gbe4taOTbLZpNEgBO2fIffnv+mvsWs3Q9KXutXLNFdXZ++w7u65SKu1k+E/RFVwwpU8M9gaffUb/F8QEvZqUqo9O19tSVb61mxMZJw0jAd9SsNrmLvb1N1g8iYFpXkIZZTHptGSjyKL291a4J0lZHsvWPCmzAxSI8Iw+GgYjBE2gQhofUp0iRbcM75RKFPVmtMRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by BL1PR11MB5304.namprd11.prod.outlook.com (2603:10b6:208:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 21:28:40 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 21:28:38 +0000
Message-ID: <84f3c302-f10b-45c7-a248-49060b4e6203@intel.com>
Date: Fri, 6 Nov 2026 13:28:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 14/28] KVM: VMX: Virtualize FRED event_data
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
 <20260911213659.2025974-15-sohil.mehta@intel.com>
 <2afe6fcd-eadc-4f9d-bbe4-0e6449479603@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <2afe6fcd-eadc-4f9d-bbe4-0e6449479603@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::24) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|BL1PR11MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: da7552b0-61b4-49d9-02d5-08df3c4cec0c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|261026140227099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: TZFL2Z6Ra3mQsiJdDn+rzprlF8HrIYGP0no9gz3ZFuRnodqZqDgNpeFbiSahqILbqVogZJ4g79v3ZwOlhsSDv/sjTmRc0uGnxrDUvLeKWBPShn5xKfuXRl62Q7th0oIw9LTUNmNmqMoDJQNDbN+ghYV5ITvMzVX1rvcXJ2fCIw2205FLPNA5fLoFsReDh7X/dHve5wEbwYNKe3hKwv4DjHZvbpVjSvjaWxn7muqyrZFipo0llFvRED1EIrAzEvqblL5PrU7EmPhY/9SIQSyUuW6+vtqrhGEf6KyikyT/z9WhJxXZkWWoG5XnTKCUbcwMmJMnQgSvG2p+9wvuyEZYPR5PA3ITCNE27rfCiTmGqFzbR2Mecz4pVVhHtwsU8548g1WV9V797JBQIsOebmDYrrsQdU8WQKwK5PU7cq8Wtv6ZeNdYH9XQFmc8YgH3WKuzW8TRFlhPCyEDSWxPGzf9ME81h9PamsyMsUA65zs4IurDyA0fIUzzIzAKdJw3KPT0HwNzGkn50IPBlc1oTkAzQ2uW3Tpfn7kg1UU/ZTuVRFfgjlhPG7xpa+2RmbSsu/CqEDyRX6mwAecV+/PBNjk7j9QV+Edsugkh5fqwzvH4VgzE5CBcjoI2yKq4AZAjgg5kD+6XabNyt9551bHLHebCdcCkHk5+s6m2kO45eESnsFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3lBb3V3eVBJcGJqdFZJQWpOdkhVL0hKaFBpUVllQ21na1lySmE3a2VFS004?=
 =?utf-8?B?QzYyWk94SGEyQlR1M0VlbHh6UVV1ZytCMS9Da0pqOWpJV084S3dFM09Ea1VZ?=
 =?utf-8?B?UnE4YWYvZHZ5YjFFUVd0SStZZUNkaFNCdzl3eXZtbnJWNkI2dWVKWWZ0QmZW?=
 =?utf-8?B?bHR6MFdzelYxekNxeHFzQzdnWExGN096bVRXdExTOGJKS2VPTkZnOTZlekt0?=
 =?utf-8?B?U3FKb1hrY3BaTjJvNjhJUUZsR01nWEdiMDI1MDhDQktRcTcwaWRzMWFqd1Ix?=
 =?utf-8?B?S3pSOFUva3RuS3FER3VtQVljVkhadGJVWmhDRlQvZ083MUw5RllWUllBLzFt?=
 =?utf-8?B?RFVpTitZR21HamJXY2xSTldQS056L0V1LzhpR1RuSTRESlVoQkJxQmpwTTQ3?=
 =?utf-8?B?YXNablVXSEpKZlNHWUdaalZSeW0wbjRLNVhQQUE5bGpWZ3ZEbUlTdFRmVC82?=
 =?utf-8?B?NXBtNUd4cjZqOTVDcWcraVlLdUFpVTNNK1Z2L3RFb2swc2xtbC80WmhGSjdy?=
 =?utf-8?B?anFUWk1zaUludnBBL2ExL0VDTS9lQ010azc2R3FscTJqcVVEbC8rLytyUXdX?=
 =?utf-8?B?OEdvSmtWRFJWOXhwTGUxNE9LRXNaTnEwM3VEMnFhQUJlY3pyMGJqTTZVdSs4?=
 =?utf-8?B?RU1ldUVOR0hhNnViaWlQbWVWYWMwT05QNnBuVnF0VEErNkhRYnB6NUhYbXgz?=
 =?utf-8?B?QXRmRzE5eFdEMDU4TERZM0c1UGErK1NyVkJXTUFLNzZTYzNGRVh6V0dZRVpO?=
 =?utf-8?B?UnpRbTcydDIxcmxoVUxjRDRWeGg0eDNLMTRYT3dhaDhwKzFWaFhyL0RtZzBH?=
 =?utf-8?B?aFk0eUlJQjVxQlI3VkNNVitnODEwWEg3ejdOMEZNVnBpV1ZUbmpIRmVIdk5R?=
 =?utf-8?B?YU1MRzdIQW9Gcm9keVVudzA5ajFpaFBNQnIxRFJUMTEvZ2krcURqMzl2SFpT?=
 =?utf-8?B?dFBjYWZGZFhTN0NWZ3pNLzNnWmVkL0t2ektoSTh1K2tCSVNWZmU4WkowbW1J?=
 =?utf-8?B?RGVCQldzWVRPbkpaT1M0SlRkUHNGU0ltTVZleHpzZGVyNFp6MVF0cC85UkpR?=
 =?utf-8?B?MXhUR0kxSDFoZjhzaEZnczNYZ1hIQzNEaEJiT1dHckpTQ0oybDV2YlRRWEJM?=
 =?utf-8?B?SjRPQm5vR3pUcVdRMTZRS3gxQlBpM2oyZUppQTlPekRoY1NvTGdHelRaYVl5?=
 =?utf-8?B?VkZMcDRnUENrVi9MUmdocVlZOUR3aklDSzVnN0dncmJQRFVSeG8zYm5sZSs5?=
 =?utf-8?B?a1NtUHdBUHlDMEVVRnpHRTRZN2t2UWlDWnBSTHp0UnNLMDgrWFdIQjNPcnUy?=
 =?utf-8?B?SFkyQmF3RU53V2hPQ0NlVWFGSExLL1NMMHdrZ0dvYXNpRXJkVVN0M3JBOHFk?=
 =?utf-8?B?V0VvMDZCWmZRMDI0V2RGL3RxZzBVblU2VzA4NWlxMzY5dllZeXQ3T011Q21u?=
 =?utf-8?B?cGFlejF4MXlKNWgvQ3dCYUljRFRyam03M3dMNCtVb2xZZnAwRlBXSXJ2UVlB?=
 =?utf-8?B?R0ZQdDFleUtYTFh2UWxvWE9oRWYxMU1YK2htSnlTekd5YkZmdXhBakhTTDdw?=
 =?utf-8?B?cmVNNFhZTzU1aVZIQVJ6eGl6NnpYS2pjMVlsM0F5U0plbHJYQ2swYU9JWVFt?=
 =?utf-8?B?eVJvOVpCT1FEcDUyU0JiWWpsNUluK1ZadlU4dGdSSkF3emZNTFhnMTJWajVm?=
 =?utf-8?B?T1dUVVdFcFhyQzJNUlVBQnhCb1dYWkNXbUlEMzM5d1FXZWZmRUFJUnZPV3U3?=
 =?utf-8?B?UFpsTVRzM3NMVENhelkvcXJ5b1Y1Skd5SVR2aDRuaFp6TEcvYktzSGJUWWhS?=
 =?utf-8?B?Sk5nR0swMmJvdUltM09jWVVKSUVQTjRiOUpmcDJ5czVZYWZORktYbENWRU5U?=
 =?utf-8?B?RlFpc2wrN1VVeENTRjFFNUZGVjd6WWdrOEN2bmhnQkpGQ2xDaWF6SXp3cmtm?=
 =?utf-8?B?WkQzdjUvdWRlYUd3N0I0dTdrMHNmdmRPVFM3KzlHbDREaG5vd2s3cHllcmdu?=
 =?utf-8?B?ZGk1bzA3KzA2dzVjbGZiVFFCaXdiK3ZlMFZSZU5YRlpGTGZSSytOVk91VERN?=
 =?utf-8?B?YnlGeHAxbzY3d2dMYVgyT0I0T0RlajlrZUY3SFdlWGh1dHRVWXZ2b0NIVHRV?=
 =?utf-8?B?ODUxcUY0VCt4elRDcVREZFhaMEhvNGZscHBoODBjcUVObmlNaFF0SldTR2pL?=
 =?utf-8?B?UDJMNmpJcFVwQ01zZzZ6QlNOMEdVUmp5TEFpdHRPTGVQRzJrbXdHNXRHSE9y?=
 =?utf-8?B?TTY2ajYzTjdRcnZpclpOemhDWmhVY2RZbHY0bHhEeFViVFpHaUJRZjdnYnlO?=
 =?utf-8?B?SjVSYU51Vkh1QSsrSnd3di9FK1pXVXU2YWxSZlBTL09JaVRFSVk1UT09?=
X-Exchange-RoutingPolicyChecked: K+ce3hGUDEqNKxZEezHxHdte6yIQ73j9/etmAutUxBzDG+d1lc78+kRJ87q5LqQpj76akcLc9lPVF1ZAymf1cGrqgQnJn7QlPxDMtpXs4/cTNSIKTy9SAlS62BzfA1wuKn9oc3I2T7oBl7MknisASJtT7zsSI2iC3fMZnH9LgpMgRg9D9cLM0VpJMzI4r+D1KIOi541f4jYO/Kt4gEH7DAMyV6iITumDltMA+F+e30yqq/t/d3CdgxXs9HQM4lyBSWgpHB3RBoEXzvSCRAM9lo2jOxasbCoMtaKy7duJAeS7RrzaaAzW4xnzavDJalXDdlKZvg6xX8pade2RfLsngg==
X-MS-Exchange-CrossTenant-Network-Message-Id: da7552b0-61b4-49d9-02d5-08df3c4cec0c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 21:28:38.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyvOEHwBpqqVc5bqL0NX2Z6ciwsFQlm03W0VohmZW43EqzIB8JmfG6pvEicdP0XEGJngFB2Pz+3yQQAqsrL+kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5304
X-OriginatorOrg: intel.com

On 10/29/2026 3:55 AM, Binbin Wu wrote:
> On 9/12/2026 5:36 AM, Sohil Mehta wrote:
>>  
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 94d684210cf6..e10ac6b280f6 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -431,9 +431,22 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
> 
> kvm_deliver_exception_payload() returns early if !ex->has_payload.
> 
> For example, if a #PF is injected, kvm_deliver_exception_payload() sets
> ex->event_data to cr2.
> Later, if a #DB without payload is queued via KVM_GUESTDBG_INJECT_DB, the
> event_data is not updated.
> It seems the stale #PF event_data will be write to INJECTED_EVENT_DATA and
> delivered to #DB handler in the guest.
> 

AFAIU, if the #PF is injected, the next VM exit would call
vm_clear_exception_queue() which would zero out the event_data. Also,
based on commit e907b4e72488 ("KVM: x86: Check for injected exceptions
before queuing a debug exception"), even if the exit interrupted the #PF
delivery it shouldn't be an issue.

But, I agree with you in principle. kvm_multiple_exception() leaves
event_data alone when it queues an exception, so an exception without a
payload would inherit the old event data which makes it a little fragile.

To solidify this, I am thinking that event_data can be zeroed in
kvm_multiple_exception() similar to how is_nested is handled. Later,
kvm_deliver_exception_payload() can fill it from the payload.

>>  		 * breakpoint), it is reserved and must be zero in DR6.
>>  		 */
>>  		vcpu->arch.dr6 &= ~BIT(12);
>> +
>> +		/*
>> +		 * FRED #DB event data matches DR6, but follows the polarity of
>> +		 * VMX's pending debug exceptions, not DR6.
>> +		 */
>> +		ex->event_data = ex->payload & ~BIT(12);
>> +		break;
>> +	case NM_VECTOR:
>> +		ex->event_data = ex->payload;
>>  		break;
>>  	case PF_VECTOR:
>>  		vcpu->arch.cr2 = ex->payload;
>> +		ex->event_data = ex->payload;
>> +		break;
>> +	default:
>> +		ex->event_data = 0;
>>  		break;
>>  	}
>>  
> 

