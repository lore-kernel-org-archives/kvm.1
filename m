Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793663899;
	b=x3C3AOH3gwOkB29OBafoHZjYZGYTrCwFmcrJYM9o8e4gDMNRemtIxK5xJ1Q1O93/W1iI
	 D1145EPkwUCMN6VwFl7U13uTDPxj8xxtnpPzsf3d6QnPLLWyrAwE8mSh34VOKYWHQGvd9
	 rPEWUO/W6DdG63aJUMSKNtw+W6wIY1LBbjk1Gk3OvVA2UAX5asF687m5zM362jWjn8kGO
	 FJXfz91mJO+fo7xNAU21IuO9kmF0xIZikQLYSO0sx6QgoejVdJgWqKwQUgzNVA1j3RGOq
	 THbx4navRz3XLC+0TQxk02/61jZEwyUqIeTx3UfToh71i9AJ7v+WL/CeLYidpBGbspw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663899;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=EBD9qorh1FLCapGsPcVSsAAnzIY1YGhlcdUuLL1OuBs=;
	b=XhNvLD7F3AmApEYLFKXzRyensApeMT7rkdnTjAHDtFhqpJYUFlI7AO6W5penXtJWTq/6
	 51/t/5DnrCEY9t669RNfcaWs2tsKRuOmVYFtb+CWdFVdwamI7mk7Pi1x/zZGoLnhWiUCE
	 +9zPnqynGi87GE+elC9cqBRc2saH+9fpUWFYkqvWvPxqfa1m/5BW75bU0ekefIEPaQAwR
	 LeO8yedJSDmxw4mkJ3NtUNvu87e3EnRjBQhWFac1z4CQuHEhijw51I0g5hjD+9yZOMt11
	 VP0kfi2+mwbjQNJoHnezh2oxF6ybJb3kdkgb14EKpI4ox9FCKRcTcNMbJ2bwRDE3z9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EEiItRRN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C001606A324;
	Mon,  2 Nov 2026 23:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C001606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EEiItRRN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793663898; x=1825199898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EBD9qorh1FLCapGsPcVSsAAnzIY1YGhlcdUuLL1OuBs=;
  b=EEiItRRNnixk8Y2YlTy5hssgtGbBs11iDOvd9aBs0ieuAsLg8WFWLiw1
   gccPagWiWqWVxGLc6Mthrvgvp5JEMGDv7gTiWb3wZspzPWHGV/uUW19kx
   T70le15bD6ABmjmGexgNVBbWZXvy4i1Q35vFVGNvETlPaOWyelE0WNa5B
   Jxu9XRC8KdDpUQoXZ2fzIvUkRHLcJEDxnb90MP7f7a6aiVC1cljti+tId
   1sFsEteON+iHhO+33vI+lpC7mjePrHs5UY1rgWIdzJiOcdtOQOB80YMhy
   rKy7/o5IAI66I0EZkkP5xXgRc821kP5qEVGa5CdorZjx8fXR3JElc5tpw
   Q==;
X-CSE-ConnectionGUID: uVnD44CFRRiU43MBPeV0IA==
X-CSE-MsgGUID: hkJosUqeTsW20P9UUGhTYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2405828"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2405828"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 15:58:15 -0800
X-CSE-ConnectionGUID: m6IdLnDvTeafXf7rEsging==
X-CSE-MsgGUID: t6if5K5CRkObegh1OBsFeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6262997"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 15:58:15 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 15:58:14 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 15:58:14 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 15:58:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jee9Bj277JjnI/Md3DiLCB9pVXtQlqEdX+ka9/+llyx7g++/ijKtL38JngzKMaq+WjHY+qYGQlp0W/Gaq41BPnaZt6VZfaNckXYJznuptUyJUYNUF3LPaOdRrV8MvCNHxShUd/p+9cGwyVCrsSiheqJwMqxk3770Lw+eYLAJ2/rgDIuyy8yiTIu5CE0+P5aaVhMsc5wKPJGkc1vfhN6YjbwA3QUHDqNl8UHUCTipkkFbJy5lUXYFiX+AHjOP5m4nwBpAa446cZnc9LYJltFBMdregdPJOYZJlGCwf2y1RPsM3kpdGkCDC9egZ9dDR99TqQgmH99qmpOWYpY+H/xtrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBD9qorh1FLCapGsPcVSsAAnzIY1YGhlcdUuLL1OuBs=;
 b=L9RAYxWn085DlMD6ZCOICaKMvkSlonasBp51KjWNCT2ZiFmDIYXEgauFqqNBDuOa4KA5D55Ufdr7kf9DIRuv9YF1PRwsRcCcfZ7cATJnPTJPKBsMKpIbLI9/QzUgHScX++lUVON7DF+SI0V3bY20TXrmGohUrsdQTVAeXueWNfugO+5X2JIQmHT8kp18cHOYqhr83AcZ+EHTlfMNzw8SD8U6RlJ323248IbZEUdsN55RVolcFvB/tOTvSoaK7nLTfbMGgMP38z/bF64EIjgzw6THUkKQpNIFIks/3fZdGQ98a1bDkEmmYJsvsOG7t3DgguR7EeUjD1U4GEFv2/bZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by LV3PR11MB8483.namprd11.prod.outlook.com
 (2603:10b6:408:1b0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 23:58:06 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 23:58:06 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v1 1/3] x86/virt/seamldr: Allocate 'struct
 seamldr_params' after image validation
Thread-Topic: [RFC PATCH v1 1/3] x86/virt/seamldr: Allocate 'struct
 seamldr_params' after image validation
Thread-Index: AQHdaEwsfP/W+e/vM0GR/C30kquYp7cbe2iA
Date: Mon, 2 Nov 2026 23:58:06 +0000
Message-ID: <5397736259f9743da43ad41b2e2a995e6372f1f7.camel@intel.com>
References: <20261030085304.3886520-1-chao.gao@intel.com>
	 <20261030085304.3886520-2-chao.gao@intel.com>
In-Reply-To: <20261030085304.3886520-2-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|LV3PR11MB8483:EE_
x-ms-office365-filtering-correlation-id: b1231d41-d793-475e-e42a-08df393d23a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|18002099003|261102123227099003|22082099003|56012099006|38070700021|11063799006|4143699003|261022115727099003|261026121527099003|261022105027099003|261022075727099003|261026140227099003|261009223027099003|261028144727099003|261021121427099003|261021123027099003;
x-microsoft-antispam-message-info: 1dW2Jrg/zH6D22Tnhw665qD8PcqrNmMo7aqoRClFrZ/xw/Fige3MLS4zsdehr0unwHK7t8robzq/QvjtwVVa1DS3qV8kkDeaEYV+dHoxtyvqN45yz+Ty5BY4RZJo8y7deJBotUaWaSQX3YeK1Ux2d7AosXO5fltTQ9Z/n7G8F53l/IQdxIO6j7T/XCYzLn+RRKFO+tTEoirOpioOUYNO+9cwHTHxmHsK57ITMFUMqgcPahD1QdpRjITkG6TQ5fuRU3fYGHbPsayFqQRid8yTQvJ6DW6lt3tXtfJP1ueHSLKRabowSPsi98FUU5x1dZln9YATwLqnInlTn/HkfYCxLidJcvF+uK+1FMhurfyhsKLvf9bS3qpP2xDeZTRaRsvtcDr8hAHQDOAIk4muzzDFtnTl5DYxWdtaFOTLDPQfvVTG+twq3BuWIHFIFUj5nEfFWYwaKNY/QZRI/HBAyKxz5cXFssYYBqVwVhKpa6cc7yPjEHh+2kI32QHGt6zc2BDyBUO+7UM0C+4Q83lsVOxj1IB3SGfn859SQ7QiRSnQptVZtd3CpA5TGApdWaYQdIiUhU5b2huK81o36Hh6/6ejZdBgf7xmj3Ou5oMTFoVK29X4QDmPQJBhP/AChcQY4zL7dAWVZn36hK4cF7ctG2cwlMvux88YUtKE0AbcpJ7Yew5NuZeirCE+y6T+XmHbCQLS9AcLeQJP+mKQtemvaqZSUmEFV3WzBHhQO1reiIkK0/o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(261102123227099003)(22082099003)(56012099006)(38070700021)(11063799006)(4143699003)(261022115727099003)(261026121527099003)(261022105027099003)(261022075727099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODZpMlNhUXRmMEo1RFBkcTZsc1o0Z3lWVC8wRnRkclJsMm91VVprbXN0dys5?=
 =?utf-8?B?bkF0SnBJeVc1NkI2dXhhMmowZ2RNN0Z6dXVWenB6RW12cGF6YkdWQ2F5Nzhs?=
 =?utf-8?B?ZnF0VlBEYTNoMXpQc0FlRWRnOE9sZnowakdLSDJUNDZmSkhrQURLTzRqNGh0?=
 =?utf-8?B?enZHSmxTejhGUDFZT3hocWZGNE4vZ0duUitwMkZ5WWJxeXN3MEFoejEvUFRT?=
 =?utf-8?B?N0krSDZEeHB5L0oxcXFGUkxYbjZhRXVUaG1nRGpMWGRCTHFXcHoxcjdNTVJo?=
 =?utf-8?B?QkFSZFQ0SnJsSUtjZC94RWVxNzZQbWV6ZE5lWDlZY0ptSjFDZW9QeTRjd0lP?=
 =?utf-8?B?cG53dlZ1Zkwzc1RsMldqL3VGUWdhSDJoV3lnYmJ0amtuMEd0ZmxwNGJMZDRG?=
 =?utf-8?B?NXhwUnlySm9tSklYMkNnNStIczQ1VktzK21vMFFFM2o5OHZ0RUlhNEhOZSt5?=
 =?utf-8?B?UkFvSWxuRzhoMlF1R0R0ajdiYVV3MnlYbktOcUd5S21naUNCRzZyeHJ4eURH?=
 =?utf-8?B?bVdXQmNyWHd2TXZWVUVMUjJMS0F1b1Z0bkpGV1UveTdTZXkzZm5OZ0thV0cv?=
 =?utf-8?B?MjZXYVJ2UVZmN1paeW1OYVpRdGowTzU4K2FBRE10cEFQTkhhYkltNTdGcm03?=
 =?utf-8?B?VHBISWZ3UXAvKzIrUUc3TFhHWTNTVXh1VW56YUMzbXptM2ZSR214bWQ2RHMr?=
 =?utf-8?B?WjUxWkdRTjhQbUpWS2RiUU5CRVcxOTJXeWdFT05Mc0hWZ1I2MEdUZm14Uk5n?=
 =?utf-8?B?eFJsNzNTVlNEUUkza1V5VlZTT2M1SlpmME5UU3RJSy9XWWg4eE1wNURYc3lW?=
 =?utf-8?B?dllOem1ha25aY01KVGlvcURBTnl3dUQ2TkphWE5vMUQ3aWZDcDhwV2g1NGIy?=
 =?utf-8?B?dVFmV1BnTzZFK1RTZVhCZ0JtWEJub0pyTFVpY2I3VVd5TTZXYnpFWG8wSFBr?=
 =?utf-8?B?dWlHcHJsS21haFZycVY5aWUxUUpwNGxuZDQxRFRCZXE5aVlQc21GTEwzb3Iv?=
 =?utf-8?B?T1lwNngrSTRCUzhmRWRQcUlEWVhxQytTN2RyNTIzQXNWVmkrS3JnV3FhUVZa?=
 =?utf-8?B?dWhjakdvRWx4QW5aM3BCZ01ueitFZjJIT1ZyakpLN0tzbGlRUXJiQTF5UFNk?=
 =?utf-8?B?a2tSZlFreDAzYUFNSStFcVMwSm1mNFBYVWdmZFNxeDNUMnFhai9JaW9MdWdO?=
 =?utf-8?B?aERBUnhrUVRaMG5yQVdtbkMzbDlTUVhnUDNIdmU2TlBJMEVqVWI2eEg0MTd5?=
 =?utf-8?B?MnU5bEtpZWd5OUpZSnJtME1RYndkRWJXLzFjTVVZYURFVnZRcjdQL0Q4TG5Q?=
 =?utf-8?B?UDQxTk0wYnJJbzdFVXFLb0I1OGVGdkgvdlUzMWtqV1FtS3VFdy9wMng4aVlU?=
 =?utf-8?B?cmFPUW9vWHVYNnhpdDJieGtjcklIRTk1SG5INjhycVRDMzliYyt0S2pkVWEz?=
 =?utf-8?B?WktRZWFMR05IUVphL0RicWxMNkdtV2lwcjdYbFEwWW1MVkFndTlJRDdxa2gr?=
 =?utf-8?B?YVFGcEtJM1BBOFpUMVRZWnlVcWFsa0xPS1RhWTR4NjZDQTFtRmpiQ0dJZFM5?=
 =?utf-8?B?Z1FRMnNmOW43d2ZPZm9Pb1J3VWthV2Zhc1d0RVM1WFdHbjJNRCtmZjZsbHl2?=
 =?utf-8?B?TVlYSVRrbXBEUFpMOE9vV2F5VjFZSGJiNklxRmtKYzg3MTR6T2JvZGJGRTNx?=
 =?utf-8?B?RGxUcm1tTWdCOWd3UnNueHVMZ3c3VjYwTU5sWXdOSVNvcGdUN1JYUXZROEFj?=
 =?utf-8?B?MldpU1UvdTA4L1NEMHhhdC9RdXZwWUlOYjJZdE5VMkQxSS9WSnpEZ2J4dGZ3?=
 =?utf-8?B?WVA5NlhQK2hRd09UdUt1YStNZnBnYzhBSzk4SmltMXkyS2t3VXhlUEpnMi9t?=
 =?utf-8?B?Qmw5dkZsUUVIYVZPOUgzTERlSkxDWVRGanNCRlYvVE9FNE5rdWFxN3ZBOThW?=
 =?utf-8?B?WUJhSyt2LzZ1K3VEOS8yT3RrLzA5SWl6RHJ3NFBXOWVYd21RTk9RaS9VYThk?=
 =?utf-8?B?TnlPUC9ia0FSTktxQi8rbWFNWG9xWlBIUFpHQ0Z1K0FGY0NkMFFPNVRDdnpH?=
 =?utf-8?B?bmVjaW9DMjVzdXlpRFVZT1gxSWV2RkkyYXo3RSt0SUpuVjlLSy9kRWd4VHlQ?=
 =?utf-8?B?WmMwVTc3ekxDK2hSM1ZiVlRPa1JkbFB2WjJqcWltVGJOMG1qcC9LQWhpKzlK?=
 =?utf-8?B?ZnhtNGZCUWJSMnExSHJ3MS9VK0J6Y1dvM1pEVVVzaG02NHloUVhWT2FrWGFZ?=
 =?utf-8?B?aEt4ZWxwZnFONE5ablh4ajR1S1Q3ZUdkL3NvQ2JocGVhNmhNTW5ER2dYVWkr?=
 =?utf-8?B?NFV2c3Fpbk41WjFCNUxXY3J6Y1B3eTJiRHdYWXV0TTBSZm9NLzFoQTBURjlk?=
 =?utf-8?Q?e/aqQOXkdFiWcK8E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CC29D9600508346B436285394A58445@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r+SPYFW+xjFPdtFKVukzl8L39YeuYjv682f8IvnB3zf4JKn/mGHUMjfao5rx5+HYPeRf4jy5ciLoE1TIMlGj5AfsAr+ve360SsUxNkivoCWMJfpU/Y0tUiALwrakHKOQmE5AQ5p/FVP5HhMudD1UbVmIMFGj5K5XuLEsKDhS0N826VIu+X+UrYkDpMBjK5VEN1GWf0lvjMuTSXu0mG6e0LZQ5AhvvMdd+CAfCARgvjxC9xIoDurnfncy+Br5uzAwHSU/iZGHywACElBRL8m6CIUMtEp+jbfLgTzsIDx+615vOJQkRLAx/tjwzygFXbwPsQ/JCw2g7zDyk1AtmmKiVg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1231d41-d793-475e-e42a-08df393d23a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 23:58:06.3593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgqTkjyyxsmwFyjSB0zgz84e0JpftYuX5aqKo4kUY92cJ/Pw9WQFP23R20GKZROgiO68oo4z5v4NgfZn7DM2zK3sDOn97VaMsaBhQeBykKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8483
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTEwLTMwIGF0IDAxOjUyIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gJ3N0
cnVjdCBzZWFtbGRyX3BhcmFtcycgaXMgdGhlIGluLW1lbW9yeSBBQkkgdGhlIGtlcm5lbCBwYXNz
ZXMgdG8gUC1TRUFNTERSDQo+IHRvIHVwZGF0ZSB0aGUgVERYIG1vZHVsZS4gSXQgaGFzIGEgZml4
ZWQgc2l6ZSBhbmQgaXMgYWxsb2NhdGVkIGJlZm9yZSB0aGUNCj4gdXBkYXRlIGltYWdlIGlzIHZh
bGlkYXRlZC4NCj4gDQo+IFRvIHN1cHBvcnQgbGFyZ2VyIFREWCBtb2R1bGVzLCB0aGUgQUJJIHdh
cyBleHRlbmRlZCB0byBsZXQNCj4gJ3N0cnVjdCBzZWFtbGRyX3BhcmFtcycgbGluayB0byBleHRy
YSBwYWdlcy4gVGhlIG51bWJlciBvZiBleHRyYSBwYWdlcw0KPiBkZXBlbmRzIG9uIHRoZSBtb2R1
bGUgcGFnZSBjb3VudCwgd2hpY2ggY2FuIGJlIHRydXN0ZWQgb25seSBhZnRlciB0aGUgaW1hZ2UN
Cj4gaGVhZGVyIGlzIHZhbGlkYXRlZC4NCj4gDQo+IE1vdmUgdGhlIGFsbG9jYXRpb24gYWZ0ZXIg
dGhlIGltYWdlIHZhbGlkYXRpb24gaW4gaW5pdF9zZWFtbGRyX3BhcmFtcygpLA0KPiBzbyBhIGxh
dGVyIGNoYW5nZSBjYW4gYWxsb2NhdGUgJ3N0cnVjdCBzZWFtbGRyX3BhcmFtcycgYW5kIHRoZSBl
eHRyYQ0KPiBwYWdlcyBhcyBvbmUgYnVmZmVyLiBSZW5hbWUgdGhlIGZ1bmN0aW9uIHRvIGJ1aWxk
X3NlYW1sZHJfcGFyYW1zKCkgc2luY2UNCj4gaXQgbm93IGFsbG9jYXRlcyBhbmQgcmV0dXJucyBh
IGJ1ZmZlciByYXRoZXIgdGhhbiBmaWxsaW5nIGluIG9uZSB0aGUNCj4gY2FsbGVyIHByb3ZpZGVz
Lg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQoNClNvIHdlIHdhbnQgdG8g
aGF2ZSB0aGUgYWxsb2NhdGlvbiBoYXBwZW4gYWZ0ZXIgaGVhZGVyLT5tb2R1bGVfbnJfcGFnZXMg
aXMNCnZlcmlmaWVkIHNvIHdlIGRvbid0IGFsbG9jYXRlIHNvbWUgcmlkaWN1bG91cyBzaXplLiBB
bmQgdGhlIHZlcmlmaWNhdGlvbg0KY3VycmVudGx5IGhhcHBlbnMgYWxsIGluIG9uZSBwbGFjZS4g
U28gbW92ZSB0aGUgYWxsb2NhdGlvbi4NCg0KRGlkIHlvdSBsb29rIGF0IGp1c3QgbW92aW5nIHRo
ZSBvbmUgaGVhZGVyIGZpZWxkIGNoZWNrIGVhcmxpZXI/IFdvbmRlcmluZyBpZiBpdA0KcmVxdWly
ZXMgbGVzcyBjaHVybi4NCg0KSG1tLCBhbHNvLCB0aGlzIGlzIGFuIGFkbWluIG9ubHkgdGhpbmcg
cmlnaHQ/IFdoYXQgZ29lcyB3cm9uZyBpZiB0aGUgYWRtaW4gdXNlcg0KcGFzc2VzIGEgaHVnZSB2
YWx1ZT8NCg0KSW4gYW55IGNhc2UsIEkgdGhpbmsgdGhlIGxvZyBjb3VsZCBiZSBzaW1wbGVyIGFu
ZCBtb3JlIHBsYWluIHdoaWxlIHN0aWxsDQpleHBsYWluaW5nIHdoYXQgaXMgaGFwcGVuaW5nIGJl
dHRlci4NCg0KPiANCj4gQUkgd2FzIHVzZWQgdG8gcmV2aWV3IHRoZSBjb2RlIGFuZCB3b3Jrc2hv
cCB0aGUgbG9ncy4gSXQgc3VnZ2VzdGVkIHJlbmFtaW5nDQo+IGluaXRfc2VhbWxkcl9wYXJhbXMo
KSBhbmQgdXBkYXRpbmcgdGhlIGNvbW1lbnRzIGFib3ZlIGl0IGFuZCBhdCBpdHMgY2FsbA0KPiBz
aXRlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBHYW8gPGNoYW8uZ2FvQGludGVsLmNvbT4N
Cj4gLS0tDQo+IMKgYXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1sZHIuYyB8IDQwICsrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRp
b25zKCspLCAyMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0
L3ZteC90ZHgvc2VhbWxkci5jIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1sZHIuYw0KPiBp
bmRleCBiMTEzN2NhNjE1MGQuLjM1MTNmZDI4NTM2YSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYv
dmlydC92bXgvdGR4L3NlYW1sZHIuYw0KPiArKysgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2Vh
bWxkci5jDQo+IEBAIC0xNTcsMTMgKzE1NywxNCBAQCBzdGF0aWMgdm9pZCBwb3B1bGF0ZV9zZWFt
bGRyX3BhcmFtcyhzdHJ1Y3QNCj4gc2VhbWxkcl9wYXJhbXMgKnBhcmFtcywNCj4gwqANCj4gwqAv
Kg0KPiDCoCAqIEBpbWFnZSBwb2ludHMgdG8gYSB2bWFsbG9jKCknZCAnc3RydWN0IHRkeF9pbWFn
ZScuIFRyYW5zZm9ybQ0KPiAtICogaXQgaW50byBAcGFyYW1zIHdoaWNoIGlzIHRoZSBQLVNFQU1M
RFIgQUJJIGZvcm1hdC4NCj4gKyAqIGl0IGludG8gYSBuZXdseSBhbGxvY2F0ZWQgJ3N0cnVjdCBz
ZWFtbGRyX3BhcmFtcycsIHdoaWNoIGlzDQo+ICsgKiB0aGUgUC1TRUFNTERSIEFCSSBmb3JtYXQu
DQo+IMKgICovDQo+IC1zdGF0aWMgaW50IGluaXRfc2VhbWxkcl9wYXJhbXMoc3RydWN0IHNlYW1s
ZHJfcGFyYW1zICpwYXJhbXMsDQo+IC0JCQnCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IHRkeF9p
bWFnZSAqaW1hZ2UsDQo+IC0JCQnCoMKgwqDCoMKgwqAgdTMyIGltYWdlX2xlbikNCj4gK3N0YXRp
YyBzdHJ1Y3Qgc2VhbWxkcl9wYXJhbXMgKmJ1aWxkX3NlYW1sZHJfcGFyYW1zKGNvbnN0IHN0cnVj
dCB0ZHhfaW1hZ2UNCj4gKmltYWdlLA0KPiArCQkJCQkJwqDCoCB1MzIgaW1hZ2VfbGVuKQ0KPiDC
oHsNCj4gwqAJY29uc3Qgc3RydWN0IHRkeF9pbWFnZV9oZWFkZXIgKmhlYWRlcgk9ICZpbWFnZS0+
aGVhZGVyOw0KPiArCXN0cnVjdCBzZWFtbGRyX3BhcmFtcyAqcGFyYW1zOw0KPiDCoA0KPiDCoAl1
MzIgc2lnc3RydWN0X2xlbgk9IGhlYWRlci0+c2lnc3RydWN0X25yX3BhZ2VzICogUEFHRV9TSVpF
Ow0KPiDCoAl1MzIgbW9kdWxlX2xlbgkJPSBoZWFkZXItPm1vZHVsZV9ucl9wYWdlc8KgwqDCoCAq
IFBBR0VfU0laRTsNCj4gQEAgLTE3OCwyNSArMTc5LDI5IEBAIHN0YXRpYyBpbnQgaW5pdF9zZWFt
bGRyX3BhcmFtcyhzdHJ1Y3Qgc2VhbWxkcl9wYXJhbXMNCj4gKnBhcmFtcywNCj4gwqANCj4gwqAJ
LyogQ2hlY2sgdGhlIGNhbGN1bGF0ZWQgcGF5bG9hZCBzaXplIGFnYWluc3QgdGhlIGltYWdlIHNp
emUuICovDQo+IMKgCWlmIChURFhfSU1BR0VfSEVBREVSX1NJWkUgKyBzaWdzdHJ1Y3RfbGVuICsg
bW9kdWxlX2xlbiAhPSBpbWFnZV9sZW4pDQo+IC0JCXJldHVybiAtRUlOVkFMOw0KPiArCQlyZXR1
cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4gwqANCj4gwqAJLyogUmVqZWN0IHVuc3VwcG9ydGVkIHRk
eF9pbWFnZSBBQkkgdmVyc2lvbnMuICovDQo+IMKgCWlmIChoZWFkZXItPnZlcnNpb24gIT0gVERY
X0lNQUdFX1ZFUlNJT05fMikNCj4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJCXJldHVybiBFUlJf
UFRSKC1FSU5WQUwpOw0KPiDCoA0KPiDCoAlpZiAoaGVhZGVyLT5zaWdzdHJ1Y3RfbnJfcGFnZXMg
PiBTRUFNTERSX01BWF9OUl9TSUdfUEFHRVMgfHwNCj4gwqAJwqDCoMKgIGhlYWRlci0+bW9kdWxl
X25yX3BhZ2VzwqDCoMKgID4gU0VBTUxEUl9NQVhfTlJfTU9EVUxFX1BBR0VTKQ0KPiAtCQlyZXR1
cm4gLUVJTlZBTDsNCj4gKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+IMKgDQo+IMKgCWlm
IChtZW1jbXAoaGVhZGVyLT5zaWduYXR1cmUsICJURFgtQkxPQiIsIHNpemVvZihoZWFkZXItPnNp
Z25hdHVyZSkpKQ0KPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwkJcmV0dXJuIEVSUl9QVFIoLUVJ
TlZBTCk7DQo+IMKgDQo+IMKgCWlmIChtZW1jaHJfaW52KGhlYWRlci0+cmVzZXJ2ZWQsIDAsIHNp
emVvZihoZWFkZXItPnJlc2VydmVkKSkpDQo+IC0JCXJldHVybiAtRUlOVkFMOw0KPiArCQlyZXR1
cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4gKw0KPiArCXBhcmFtcyA9IGt6YWxsb2Nfb2JqKCpwYXJh
bXMpOw0KPiArCWlmICghcGFyYW1zKQ0KPiArCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4g
wqANCj4gwqAJcG9wdWxhdGVfc2VhbWxkcl9wYXJhbXMocGFyYW1zLCBzaWdzdHJ1Y3Rfc3RhcnQs
IGhlYWRlci0NCj4gPnNpZ3N0cnVjdF9ucl9wYWdlcywNCj4gwqAJCQkJCW1vZHVsZV9zdGFydCzC
oMKgwqAgaGVhZGVyLQ0KPiA+bW9kdWxlX25yX3BhZ2VzKTsNCj4gLQlyZXR1cm4gMDsNCj4gKwly
ZXR1cm4gcGFyYW1zOw0KPiDCoH0NCj4gwqANCj4gwqAvKg0KPiBAQCAtMzIxLDcgKzMyNiw3IEBA
IGludCBzZWFtbGRyX2luc3RhbGxfbW9kdWxlKGNvbnN0IHU4ICpkYXRhLCB1MzIgZGF0YV9sZW4p
DQo+IMKgCWludCByZXQ7DQo+IMKgDQo+IMKgCS8qDQo+IC0JICogaW5pdF9zZWFtbGRyX3BhcmFt
cygpIHJlYWRzIHRoZSBoZWFkZXIgZWFybHkuDQo+ICsJICogYnVpbGRfc2VhbWxkcl9wYXJhbXMo
KSByZWFkcyB0aGUgaGVhZGVyIGVhcmx5Lg0KPiDCoAkgKiBFbnN1cmUgdGhlcmUgaXMgZW5vdWdo
IGRhdGEgdG8gZG8gYXQgbGVhc3QgdGhhdC4NCj4gwqAJICovDQo+IMKgCWlmIChkYXRhX2xlbiA8
IFREWF9JTUFHRV9IRUFERVJfU0laRSkNCj4gQEAgLTMyOSwxNCArMzM0LDEwIEBAIGludCBzZWFt
bGRyX2luc3RhbGxfbW9kdWxlKGNvbnN0IHU4ICpkYXRhLCB1MzIgZGF0YV9sZW4pDQo+IMKgDQo+
IMKgCWltYWdlID0gKGNvbnN0IHN0cnVjdCB0ZHhfaW1hZ2UgKilkYXRhOw0KPiDCoA0KPiAtCXBh
cmFtcyA9IGt6YWxsb2Nfb2JqKCpwYXJhbXMpOw0KPiAtCWlmICghcGFyYW1zKQ0KPiAtCQlyZXR1
cm4gLUVOT01FTTsNCj4gLQ0KPiAtCS8qIFBvcHVsYXRlICdwYXJhbXMnIGZyb20gJ2ltYWdlJy4g
Ki8NCj4gLQlyZXQgPSBpbml0X3NlYW1sZHJfcGFyYW1zKHBhcmFtcywgaW1hZ2UsIGRhdGFfbGVu
KTsNCj4gLQlpZiAocmV0KQ0KPiAtCQlnb3RvIG91dDsNCj4gKwkvKiBCdWlsZCAncGFyYW1zJyBm
cm9tICdpbWFnZScuICovDQo+ICsJcGFyYW1zID0gYnVpbGRfc2VhbWxkcl9wYXJhbXMoaW1hZ2Us
IGRhdGFfbGVuKTsNCj4gKwlpZiAoSVNfRVJSKHBhcmFtcykpDQo+ICsJCXJldHVybiBQVFJfRVJS
KHBhcmFtcyk7DQo+IMKgDQo+IMKgCS8qIEVuc3VyZSBhIHN0YWJsZSBzZXQgb2Ygb25saW5lIENQ
VXMgZm9yIHRoZSB1cGRhdGUgcHJvY2Vzcy4gKi8NCj4gwqAJY3B1c19yZWFkX2xvY2soKTsNCj4g
QEAgLTM0NSw3ICszNDYsNiBAQCBpbnQgc2VhbWxkcl9pbnN0YWxsX21vZHVsZShjb25zdCB1OCAq
ZGF0YSwgdTMyIGRhdGFfbGVuKQ0KPiDCoAkJCQnCoMKgwqDCoMKgIGNwdV9vbmxpbmVfbWFzayk7
DQo+IMKgCWNwdXNfcmVhZF91bmxvY2soKTsNCj4gwqANCj4gLW91dDoNCj4gwqAJa2ZyZWUocGFy
YW1zKTsNCj4gwqAJcmV0dXJuIHJldDsNCj4gwqB9DQoNCg==
