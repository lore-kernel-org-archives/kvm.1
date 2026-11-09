Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794263675;
	b=3RLeu0wwe+zUDhuoIfPtVqv3BC3/yfoeka3RXf2WRE6Ydd16RipWJKvpXde2ktkO3/D6
	 Z7CbKV+MPKOI9tw1USQBt9XAQfEGUClZD5GwCGUM6XQnsM3//mAXs6/9v8E57g+g8ySBc
	 UPWINjgGIBkAVYYXRLA0IRdJGTC77+p6Df/erv/ge7U0xf2LIZs9oQuofM2Ds6eXmJrOd
	 lmlfOOEOOX9fgmtUWSdLbjX06u9dnYC+1ExWVtHoioaSk32MRxr+/GyCnlaN9I8DPICaX
	 Qprj7qnflo4cQFfPoFCuRpRZmcGNRlYtKwzc95mC7m2fq/A7K0Q9fmPngO98HJXt6qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263675;
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
	bh=hwNcLWSHZ50C4iuibKKSl3hKG3Zj7tvqc6nWbt9hVIU=;
	b=tWjnRj6ZebeI4ylVYnxs5n4Jf2Lw63MpBwQQMzLB8q/jPTGjVM8ZI/oM1SCTjlwhUrKk
	 EFo2wPSh2n/0ucJEWMDwsNCp/fXfOCkB2vuLhwiMEDVTDUThaCuHkdlmvZ55ziru2sz6k
	 0d4/sJzzitJ8v/uOiQpt2+BQDdKs6HpDJCQbxg7sOlla345B1AhW0e99GCULjNjlc5K1R
	 Pg5SE3MxLX+IJzFuUIqq9dZWMRgKVB9niXOX0OuMwavO9i4kk9LVSrm4NEr5lm3Zw93kr
	 at8EaTPNJCDzFYhZ1xy7EShl1tsVy4un0OmGTctqUWKWqGKiaIW4BWrDQrlBD2JLI6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MaNWuHqx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF0606A331;
	Mon,  9 Nov 2026 22:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2DF0606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MaNWuHqx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794263674; x=1825799674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hwNcLWSHZ50C4iuibKKSl3hKG3Zj7tvqc6nWbt9hVIU=;
  b=MaNWuHqx3DcH47+oywpR7y8Z8iTLi7/O627ZkXGS0r6bryZov4Fx2Yrj
   BrAMDlS9n2dmc1X4RtokTMMUo05OC5uOk2RsVm3njm2Zr8h0vM25avODF
   nvb3sqG7IQNHug8XjVuLgAEq4pjGYOt8q6sLM1quwQfEP47/jslz9g2ES
   F+6P7nrva+1u/UQYrQnXU77Kthn6TQ/E9V6DY3RZMMfhrm2uALffk5J4U
   0D7SXHIjEV/P0N0zIp7nEGQI0wQf9DyC9QWH69X6MbK2e4B2KY9HoXv32
   UJNoRLCJcSwb7YAwgQ2T1CgMlpbvVReCA4NNP1rt2u+Dko9aHUTggqkec
   g==;
X-CSE-ConnectionGUID: f4FF75eyQma4hom40yeyaQ==
X-CSE-MsgGUID: cMoW03yKTaa6Awkpp1RZag==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2892773"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2892773"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:34:33 -0800
X-CSE-ConnectionGUID: SwYxKsNJSwaA3gvATdE+cA==
X-CSE-MsgGUID: Vme2jAWFSXi7pSwhGnzBcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7853487"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:34:34 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 14:34:32 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 14:34:32 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 14:34:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0q7LQNvozxEyA8xeuwamiB0dXIQf7s2mCueGugvcG4L16ppgtnjptF7JPXdvRgIfx/qwo3WvL/lQpjO09AFaCY06fO3BN8y9L1lLTCT4FOS8SMtEyOcFIOXPTyNz8JGmlvoeg/dHiJwxJoW3NjLVyWeV97oERpMsRYFxqgKZ7XjIEbKSWIMuo9H/3j5la/T93eQ+ZLMQ42SfCrxCESTabw0oKBboiQG6JPHZl7j0YXLMmPSBFTF/oIQCxzyeHOYS+A6NQem9T+NlpFVLUiZvn7HzVZKg/NWn1+n+TVdd3pW9yitGCqDk3VxAU6brmf6iKCrvNNixfFPTYZ4FfeKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwNcLWSHZ50C4iuibKKSl3hKG3Zj7tvqc6nWbt9hVIU=;
 b=X+3/6+mGwjY/VjfY04rjhRDEii0FO8toaadK2iIiNqrWklnoq1V+DsnrRzAWFqRr1YAmszqTb4Fnca6wIPbzfJsFwH98h0eOmi5i8MtW217fHFFnDbT7TV+iDXNuwGwaajMU8ucqM8SHztgD0DzmY3p9itT/QOk31G8uCLs4I+EtBHcqdDrBsOuKvohHSwoRGTsxJjHBbiIVWQjTgxJxuIRRFg3dcRnNUWZ/YmLWAKHwke0PDHH9+uxvq97RPPBPTBBwh0lFjHygWXuKqlEpsG+ZhGnqcW9c3Vs6DWbE7We4PzbjOcWkmFP9eEtZV/KtL6todfrjsK7uZ6TILUe6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by PH8PR11MB7071.namprd11.prod.outlook.com
 (2603:10b6:510:215::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 22:34:29 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 22:34:29 +0000
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
Subject: Re: [RFC PATCH v2 1/2] x86/virt/seamldr: Support large TDX module
 binaries
Thread-Topic: [RFC PATCH v2 1/2] x86/virt/seamldr: Support large TDX module
 binaries
Thread-Index: AQHdbfHNlDatokfPVkKAzKl0Pik8NrcmWROA
Date: Mon, 9 Nov 2026 22:34:29 +0000
Message-ID: <0ee3d9592e4e73bd0e5bedafc836033fdfc9f120.camel@intel.com>
References: <20261106132159.1551365-1-chao.gao@intel.com>
	 <20261106132159.1551365-2-chao.gao@intel.com>
In-Reply-To: <20261106132159.1551365-2-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|PH8PR11MB7071:EE_
x-ms-office365-filtering-correlation-id: 534fda72-8098-418a-d2a1-08df3eb19e48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|22082099003|38070700021|11063799006|4143699003|56012099006|261026121527099003|261009223027099003|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261022075727099003|261022115727099003|261026140227099003|261022105027099003|10067099003;
x-microsoft-antispam-message-info: sDSE4e1lskfzLaMwkhnht3ZDjj/W7av443MBmdVlA88L4RZGzKvd7JzqFsr0QdZwod1B6UgXOVeKR9Ix9cpnifi81sHpaUF2uHBxBGWMpn5LD+/qmvhxw4uXvFLzqxvuNNtOUf5/7fn3FUhUsyQ9JneJfSfjYBuj57gAwW9KpM7mqDfO/DnF9bYgnhm1RRgVfQe/roF8cntEASuRo33/pYg5nCVRncXgXFjLZMzXWx2lu89/4LoEWRdeDIkXrw4UyMd7hYIPyWyNM39iHFeYCKmDAT4A2+YP06qUWNG4m2YBWeGgfu43CYV+y8n9tLpJIPRAOj5sHiBQJ2uNXhWsKN9J8baqWbfS8qIXss0DMwKei0fEW7NvvTTlai2Pmi90IOgHUma5kMzsMyhgeZj3Kz6/tKk0Ppkl1lNXdkeXadTTuVT4aPSnEDgM5DP0SyPQy1crnDOaNpr6T8BTapt9v5DFD2zZdAydxJA9dzLv5lSkDkzNAaQe7wxwzbG7hh1SYKbW/iJWAKmrWwGdrNDCUyGxdfsKnjU56Y3QUw0LHcWlWNruNETBb1ob6ComZf67aUyiPyoIKFt6LHIUgtjWAJhPej39lzvYN6PG4Dv+mohHPnELMVAL5GgPefSFoHU+2J3O6e0kOoJkTuZX7Gpz2ol7gG8vbVErlIX2AV3DWtxNHD000mZjKboqDYnICMk1pKqDtlLkoRvKFE7are67yvIQCfZJnIGsFJ8zapee1aY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(56012099006)(261026121527099003)(261009223027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022115727099003)(261026140227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alAwQjNGMUtlZHNhMExVRUtqWXVvcHRJc2p0RzdteHQ2RUZJQWhqcXNnRmo1?=
 =?utf-8?B?R05kTkxQZzQvcFAvcHkyUjVqUlVFU0kwQ2FjSmpUaFhUWmpOOTZxMVhqL3p1?=
 =?utf-8?B?L0FWeFdFYXJIakc1RXp0cGZLSU9GelZZQ2dxQUhoYVRYd2EvTEE4bW1jNC8z?=
 =?utf-8?B?MUdBMGV4QWxjbVJDTVg1UXVoUEI0a1AzK3FZd3RjWDVNb3VhWDgvYVpDOVlZ?=
 =?utf-8?B?bnVIckdlaDNFdHBDV0EwRm4rb25OUXIyRTIrY0c4anRjNEFpZG1iOHF5eDJ2?=
 =?utf-8?B?L3RJZDFyR0V2NUlvV1NjU3VZR3BjdEgyTWhYVzlCL0tnKzIzbzBNY0ZSa1F0?=
 =?utf-8?B?cWwvYVE2eGpkRVd2b0RzVFFXdk5jckhJYVlLTHJNUXQ4MWRQeFpMRTkyeGhs?=
 =?utf-8?B?dk5sdnYvU1hWRVhPZ2dQMlpWWnc1UEpVci96K291RHdPWkc5bHErSnI0c0hZ?=
 =?utf-8?B?a2pZSG0rTUlZSmRuUm1lRVM0L0hBV2tzaFVZYU1xZGJEVDhEZ3gwd2QzQVpL?=
 =?utf-8?B?dFNBSDE4c2hDNnIzQzdMaEFFQ2VEMEtWd1J3cDc1dzF6MGlMS1ZxaFRwTGF1?=
 =?utf-8?B?cStVbmFIeGUzN0lsVnFoTmsyVHBwcFV6enc3NHdqYUxxb2xEQmFnZGhmdlhx?=
 =?utf-8?B?dzl2ZnNkdGZzbEhiMmxIRlJMNXhGa21SSyt2OUFLeEQ0eWFCb1lBUklKbFJB?=
 =?utf-8?B?TG05YjF2bHUrdG1XTmk5THg0RzhzOXVFdkNWa2dLZmpldHBqdStCeGg3ZW94?=
 =?utf-8?B?VXB1b1pZc0hLeHQzZWs0WEVPYzFDV21JSTg1U2piUlJGL1lDNndVQlhqOWcv?=
 =?utf-8?B?T2lMZlFrYVMxQlc0Z0tmTU1ueU8rVUpsdTZNMzlNVmZtSkdMamt4Sy9sQlhD?=
 =?utf-8?B?TnYxRzd0Qk5HbkJnZ2F4bnNjeFNwS29ySDQrdlJ3VE5XR0hsUXJwSEhLN2py?=
 =?utf-8?B?bGc1aHpSbW1FenQwS1dlRGw3U0ZaeVlsUk9jMzEyVjEzTEV5VitSQ1JFOGll?=
 =?utf-8?B?eG5HVTNnSGJxVHVITURVbHJ6L1F5L2c1RWwvRHIrQ043WnRNSGM1Q0JiWWxl?=
 =?utf-8?B?WGhoTFFXSUErazRRZnd3bjJjTVBNUnNaWjNRVkJiRkF4eEQrM2ErNEorWVBx?=
 =?utf-8?B?ZEpLVHpBWEt4ckxmc0FkaFRKeC9QS2o0ZThEWUJVQkJ0UzBPNVRQNzN4a0VU?=
 =?utf-8?B?Ky9aODJpWjhrM3lOVnNYdWV3TTNGQ2VDRUpFYzlkeDJSeVlaaHYyN1F4Mjhu?=
 =?utf-8?B?WHhMTDhORTFmR1RPZDJQRDhwRERDL0xpZUJ6TzJsUmlzV01nRTd2SkJMdnNC?=
 =?utf-8?B?dGFwNXBuMjF0L2tZZWlwcG04MzJHOVdOb3diQUlLbitpWmV0NzQ2cko5UUln?=
 =?utf-8?B?THJmRFRJS2FVZDFNTWFlamVKelVCVWwxcWQrd09QSnhXdmFmVXN2ZmV5T1VI?=
 =?utf-8?B?RU1uT1Fud25aRnJsSDd2ODV2L2FXTFVNNVY2WGdiTnEyN3Jqc294Q3VqYXRW?=
 =?utf-8?B?RkpzSUpUVzMzYVJ6ckVJbytWSDViVTdOMVpwblVxNXdBOUdmWWczK3ZtejlG?=
 =?utf-8?B?bi9Ha29xQjhwWjNEeEJBVGRnZjBWdTBmQnlsQUxUd2JXOWg2Y2J2c2NFVkIz?=
 =?utf-8?B?a0VJYlhRNWJyZk5yMDBFbko0QVlDUllzUzczeXNZaUpuNUIzOXlTNGdjU0Jr?=
 =?utf-8?B?RnZJaWdIdGg0REdkdUh6TERTQ0NBc3U2cStVNGhyNGh0dFZqbGZFaDdnUWl4?=
 =?utf-8?B?ZGFlcmorYXpsZXJOYUkwOHpwLzRWYlhGSjJxRU9LbnlsdkYwTWRtODlLUnpL?=
 =?utf-8?B?Wjh6ODJEYThNYWJRUnhBdmhPSGdDbGl3eUxJS0ZPSGFaQUlVc24rNFdmWXFC?=
 =?utf-8?B?TXArVjd5RDlDSUR2TllOK3R1Mmo1SC9MeVpxL0N3WW9lRGM5dThkeGE2dWla?=
 =?utf-8?B?UHBxU2htOGdscStqeG8xbDJ4NFVSSy9Hcm42ZW9yeHBkTm9yeXA3Nm9IajlH?=
 =?utf-8?B?OFp4dUx2MzQ4TWllTXUzdS85RGxjeHRZY1hjZ0pHcVRlT3Qvb0tLa00xNFZW?=
 =?utf-8?B?YUFtMWgxMnpjdVRLOUZLZnBPVDhHQ2dVSTVJbUdUd3NwWUh4UWhZTy9lZjRw?=
 =?utf-8?B?YWRybi8wY2J2UkpBQVZ6OENxcTBqRUtLcDEyTS96LzBWdnA2NlJVbTZtYnJE?=
 =?utf-8?B?bHFUSVQ2SEFMMVhGN3RRbFJ1Z3BsMEowdzFtLzIxM0wxNGxsUVVhK2FCb2xv?=
 =?utf-8?B?RGYvNDZhMXNCWEhhWDYzaFZXYWZtbit4QXhrdDV6bW5KdFF6VFRGcFVIOHRZ?=
 =?utf-8?B?VVF6RU1UNk1RbUlIR0ZUcEpEZFltcTQ2L1NZS29Pc0g2MVpUZEN5S2hxMFdl?=
 =?utf-8?Q?s9T7z03EYks7/9X8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B601B004F5500449A2AE2805871570F@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: Li9/6cWAd49kAgQ4nrLnDTkA9K1Lfszs8JC+w/izpwtuTK30pojOQjaRy+sCX94MyEPc98YpeAL90r6lTUYZKVhzOQxNdz3DThYUToIhW78Qd6y4x3ir5EwXWSonmDVwYcMyeYWfCUGP43zQbjoA1h2bhyijQrf2CEJ39wOMh0biqVEjCJXKmJWKMeb3SGOaXhpVt4hmicc3LEFGerxEDagJxCHu0Sxxy/Glzwyf9zz+vSAVRu4es4ITkaRM8/+WAo3sNUaRBp7gPiaIgsIRP21wlUYWeykJWAlKknWJAALpNcQLk1SRl704D6TygmrsMK7arZZIie/g0UVhfWKRIg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534fda72-8098-418a-d2a1-08df3eb19e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 22:34:29.5313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5uZm89+OpjOR+/0VFyZsteNNgB/+dsGNftkChhhPnzf+UEy4Uyhmq/L6H2eY17BiM533RJVjmMhoa4RGoH0pVzRqfw0z+cjUi0Kz8goQuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7071
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTExLTA2IGF0IDA1OjIxIC0wODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVGhl
IG1vZHVsZSBiaW5hcnkgaXMgaGFuZGVkIHRvIFAtU0VBTUxEUiBhcyBhIGxpc3Qgb2YgcGFnZSBw
aHlzaWNhbA0KPiBhZGRyZXNzZXMgaW4gJ3N0cnVjdCBzZWFtbGRyX3BhcmFtcycuIFRoZSBsaXN0
IGhhcyA0OTYgZW50cmllcywgd2hpY2gNCj4gY2FwcyBhIG1vZHVsZSBhdCA0OTYgcGFnZXMuDQoN
Cm5pdC4gY2hhbmdlIGl0IHRvICIuLi5jYXBzIGEgbW9kdWxlIGF0IHRoZSBzYW1lIG51bWJlciBv
ZiBwYWdlcyIuDQoNCj4gDQo+IFREWCBtb2R1bGVzIGFyZSBnYWluaW5nIGZlYXR1cmVzIGFuZCBh
cmUgYWJvdXQgdG8gb3V0Z3JvdyB0aGF0IGxpbWl0Lg0KPiANCj4gVGhlIFAtU0VBTUxEUiBBQkkg
d2FzIGV4dGVuZGVkIHRvIGNoYWluIHRoZSBsaXN0IGFjcm9zcyA0S0IgcGFnZXMuIEZvcg0KPiBh
IG1vZHVsZSBvdmVyIDQ5NSBwYWdlcywgdGhlIGxhc3Qgb2YgdGhlIDQ5NiBlbnRyaWVzIHBvaW50
cyB0byBhbm90aGVyDQo+IHBhZ2Ugb2YgZW50cmllcyBpbnN0ZWFkIG9mIHRvIGEgbW9kdWxlIHBh
Z2UuIFRoZSBsYXN0IGVudHJ5IG9mIHRoYXQNCj4gcGFnZSBjYW4gcG9pbnQgdG8geWV0IGFub3Ro
ZXIgcGFnZSwgYW5kIHNvIG9uLCB1bnRpbCBldmVyeSBtb2R1bGUgcGFnZQ0KPiBpcyBsaXN0ZWQu
DQo+IA0KPiBHcm93IG1vZHVsZV9wYWdlc19wYV9saXN0W10gc28gdGhhdCAnc3RydWN0IHNlYW1s
ZHJfcGFyYW1zJyBzcGFucw0KPiBtdWx0aXBsZSBwYWdlcyAoMTYgZm9yIG5vdyksIGFuZCB1c2Ug
dGhlIGV4dHJhIHBhZ2VzIGFzIHRoZSBjaGFpbmVkDQo+IHBhZ2VzLiBUaGUgbGFzdCBlbnRyeSBv
ZiBlYWNoIHBhZ2UgdGhlbiBwb2ludHMgdG8gdGhlIGVudHJ5IHJpZ2h0IGFmdGVyDQo+IGl0LCB3
aGljaCBzdGFydHMgdGhlIG5leHQgcGFnZS4gVGhlc2UgbGluayBlbnRyaWVzIGRvIG5vdCBob2xk
IG1vZHVsZQ0KPiBwYWdlcywgc28gbGVhdmUgdGhlbSBvdXQgb2YgdGhlIG1heGltdW0gbW9kdWxl
IHBhZ2UgY291bnQuDQo+IA0KPiBUaGUgMTYtcGFnZSBzaXplIGlzIHNvbWV3aGF0IGFyYml0cmFy
eS4gSXQgZml0cyBtb2R1bGVzIG9mIHVwIHRvIGFib3V0DQo+IDMyTUIsIGZhciBhYm92ZSB0aGUg
cm91Z2hseSAyTUIgb2YgY3VycmVudCBtb2R1bGVzLiBJdCB3YXN0ZXMgNjBLQiBmb3INCj4gdG9k
YXkncyBtb2R1bGVzLCB3aGljaCBpcyBmaW5lIGJlY2F1c2UgdGhlIG1lbW9yeSBpcyBmcmVlZCBy
aWdodCBhZnRlcg0KPiB0aGUgdXBkYXRlLiBTaXppbmcgbW9kdWxlX3BhZ2VzX3BhX2xpc3RbXSBw
ZXIgbW9kdWxlIHdvdWxkIG1lYW4gZWl0aGVyDQo+IG1vdmluZyB0aGUgYWxsb2NhdGlvbiBhZnRl
ciB0aGUgaW1hZ2UgaGVhZGVyIGlzIHZhbGlkYXRlZCwgb3IgYWxsb2NhdGluZw0KPiBmcm9tIGFu
IHVudmFsaWRhdGVkIHBhZ2UgY291bnQuIEVpdGhlciB3YXkgaXQgaXMgbW9yZSBjb2RlIGNodXJu
Lg0KPiANCj4gRG8gbm90IHF1ZXJ5IFAtU0VBTUxEUiBmb3IgY2hhaW5pbmcgc3VwcG9ydC4gVXNl
cnNwYWNlIHNlbGVjdHMgdGhlIHVwZGF0ZQ0KPiBpbWFnZSBhbmQgaXMgcmVzcG9uc2libGUgZm9y
IGVuc3VyaW5nIHRoZSBtb2R1bGUgaXMgY29tcGF0aWJsZSB3aXRoDQo+IFAtU0VBTUxEUi4NCj4g
DQo+IFRoYW5rcyB0byBZaWx1biBmb3IgdGhlIGlkZWEgb2YgYWxsb2NhdGluZyB0aGUgY2hhaW4g
cGFnZXMgdG9nZXRoZXINCj4gd2l0aCAnc3RydWN0IHNlYW1sZHJfcGFyYW1zJy4NCg0KSSdtIG5v
dCBzdXJlIHdoYXQgdGhpcyBtZWFucy4NCg0KPiANCj4gQUkgd2FzIHVzZWQgdW5kZXIgc3VwZXJ2
aXNpb24gdG8gcmV2aWV3IGNvZGUgYW5kIHdvcmtzaG9wIGxvZ3MuDQoNClNhbWUgY29tbWVudCBh
cyBvbiB0aGUgbmV4dCBwYXRjaC4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBHYW8gPGNo
YW8uZ2FvQGludGVsLmNvbT4NCj4gLS0tDQo+IHYyOg0KPiAgLSBNYWtlICdzdHJ1Y3Qgc2VhbWxk
cl9wYXJhbXMnIGEgZml4ZWQgMTYgcGFnZXMgaW5zdGVhZCBvZiBzaXppbmcgaXQNCj4gICAgdG8g
ZWFjaCBtb2R1bGUsIGNhcHBpbmcgbW9kdWxlcyBhdCBhYm91dCAzMk1CLiBbUmlja10NCj4gIC0g
RHJvcCB0aGUgcGF0Y2ggdGhhdCBtb3ZlZCB0aGUgYWxsb2NhdGlvbiBhZnRlciBpbWFnZSB2YWxp
ZGF0aW9uLiBbUmlja10NCj4gLS0tDQo+ICBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWxkci5j
IHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L3ZpcnQvdm14L3RkeC9zZWFtbGRyLmMgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2Vh
bWxkci5jDQo+IGluZGV4IGIxMTM3Y2E2MTUwZC4uMDg3YmRmMTBhOWE3IDEwMDY0NA0KPiAtLS0g
YS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWxkci5jDQo+ICsrKyBiL2FyY2gveDg2L3ZpcnQv
dm14L3RkeC9zZWFtbGRyLmMNCj4gQEAgLTI0LDcgKzI0LDE4IEBADQo+ICAjZGVmaW5lIFBfU0VB
TUxEUl9JTkZPCQkJMHg4MDAwMDAwMDAwMDAwMDAwDQo+ICAjZGVmaW5lIFBfU0VBTUxEUl9JTlNU
QUxMCQkweDgwMDAwMDAwMDAwMDAwMDENCj4gIA0KPiAtI2RlZmluZSBTRUFNTERSX01BWF9OUl9N
T0RVTEVfUEFHRVMJNDk2DQo+ICsvKg0KPiArICogbW9kdWxlX3BhZ2VzX3BhX2xpc3RbXSBzcGFu
cyBtdWx0aXBsZSBwYWdlcy4gVGhlIGxhc3QgZW50cnkgb2YgZWFjaA0KPiArICogcGFnZSBwb2lu
dHMgdG8gdGhlIG5leHQgcGFnZSBhbmQgZG9lcyBub3QgaG9sZCBhIG1vZHVsZSBwYWdlLCBzbyB0
aGUNCj4gKyAqIG1heGltdW0gbnVtYmVyIG9mIG1vZHVsZSBwYWdlcyBpcyB0aGUgYXJyYXkgc2l6
ZSBtaW51cyBvbmUgZW50cnkgcGVyDQo+ICsgKiBwYWdlLg0KPiArICoNCj4gKyAqIFNFQU1MRFJf
UEFSQU1TX05SX1BBR0VTIGlzIHNvbWV3aGF0IGFyYml0cmFyeS4gSXQgYWxsb3dzIG1vZHVsZXMg
b2YNCj4gKyAqIHVwIHRvIGFib3V0IDMyTUIuIEluY3JlYXNlIGl0IGlmIG1vZHVsZXMgb3V0Z3Jv
dyB0aGF0Lg0KPiArICovDQo+ICsjZGVmaW5lIFNFQU1MRFJfUEFSQU1TX05SX1BBR0VTCQkxNg0K
PiArI2RlZmluZSBTRUFNTERSX05SX01PRFVMRV9QQV9FTlRSSUVTCSg0OTYgKyA1MTIgKiAoU0VB
TUxEUl9QQVJBTVNfTlJfUEFHRVMgLSAxKSkNCg0KSSB0aGluayB5b3Ugc2hvdWxkIGRlc2NyaWJl
IHRoZSBtYXRoIGEgbGl0dGxlIGJpdCBoZXJlLiA0OTYgaXMgdGhlIHNwYWNlIGluIHRoZQ0Kb3Jp
Z2luYWwgZm9ybWF0LCBidXQgdGhlIGxhc3Qgb25lIGlzIG5vdyBhIHBhIHBvaW50ZXIsIHJpZ2h0
PyBTbyBjYW4ndCBiZSB1c2VkDQphcyBhIHBhZ2Ugb2YgbW9kdWxlIGRhdGEuIEFuZCB0aGVuIGVh
Y2ggc3VjY2Vzc2l2ZSBwYWdlIGlzIDUxMSBlbnRyaWVzIGFuZCB0aGVuDQphIHBhIHBvaW50ZXI/
IFNvIGlzIHRoZSBtYXRoIGFjdHVhbGx5IHJpZ2h0Pw0KDQo+ICsjZGVmaW5lIFNFQU1MRFJfTUFY
X05SX01PRFVMRV9QQUdFUwkoU0VBTUxEUl9OUl9NT0RVTEVfUEFfRU5UUklFUyAtIFNFQU1MRFJf
UEFSQU1TX05SX1BBR0VTKQ0KPiAgI2RlZmluZSBTRUFNTERSX01BWF9OUl9TSUdfUEFHRVMJMQ0K
PiAgDQo+ICAvKg0KPiBAQCAtNDgsMTAgKzU5LDEwIEBAIHN0cnVjdCBzZWFtbGRyX3BhcmFtcyB7
DQo+ICAJdTY0CXNpZ3N0cnVjdF9wYWdlc19wYV9saXN0W1NFQU1MRFJfTUFYX05SX1NJR19QQUdF
U107DQo+ICAJdTgJcmVzZXJ2ZWRbMTA0XTsNCj4gIAl1NjQJbW9kdWxlX25yX3BhZ2VzOw0KPiAt
CXU2NAltb2R1bGVfcGFnZXNfcGFfbGlzdFtTRUFNTERSX01BWF9OUl9NT0RVTEVfUEFHRVNdOw0K
PiArCXU2NAltb2R1bGVfcGFnZXNfcGFfbGlzdFtTRUFNTERSX05SX01PRFVMRV9QQV9FTlRSSUVT
XTsNCj4gIH0gX19wYWNrZWQ7DQo+ICANCj4gLXN0YXRpY19hc3NlcnQoc2l6ZW9mKHN0cnVjdCBz
ZWFtbGRyX3BhcmFtcykgPT0gNDA5Nik7DQo+ICtzdGF0aWNfYXNzZXJ0KHNpemVvZihzdHJ1Y3Qg
c2VhbWxkcl9wYXJhbXMpID09IFNFQU1MRFJfUEFSQU1TX05SX1BBR0VTICogUEFHRV9TSVpFKTsN
Cj4gIA0KPiAgLyoNCj4gICAqIFNlcmlhbGl6ZSBQLVNFQU1MRFIgY2FsbHMgc2luY2UgdGhlIGhh
cmR3YXJlIG9ubHkgYWxsb3dzIGEgc2luZ2xlIENQVSB0bw0KPiBAQCAtMTI5LDE3ICsxNDAsMjQg
QEAgc3RydWN0IHRkeF9pbWFnZSB7DQo+ICAvKg0KPiAgICogR2l2ZW4gYSB2bWFsbG9jKCkgYWxs
b2NhdGlvbiwgd3JpdGUgYWxsIG9mIHRoZSBiYWNraW5nIHBoeXNpY2FsDQo+ICAgKiBhZGRyZXNz
ZXMgdG8gcGFfbGlzdFtdLiBDYWxsZXIgZ3VhcmFudGVlcyB0aGF0IHRoZSBhcnJheSBpcyBiaWcN
Cj4gLSAqIGVub3VnaC4NCj4gKyAqIGVub3VnaC4gSWYgcGFfbGlzdFtdIHNwYW5zIG11bHRpcGxl
IHBhZ2VzLCBwb2ludCB0aGUgbGFzdCBlbnRyeQ0KPiArICogb2YgZWFjaCBwYWdlIHRvIHRoZSBu
ZXh0IHBhZ2UuDQo+ICAgKi8NCj4gIHN0YXRpYyB2b2lkIHBvcHVsYXRlX3BhX2xpc3QodTY0ICpw
YV9saXN0LCBjb25zdCB1OCAqdm1hbGxvY19hZGRyLCB1MzIgdm1hbGxvY19sZW5fcGFnZXMpDQo+
ICB7DQo+IC0JaW50IGk7DQo+ICsJaW50IGksIGo7DQo+ICANCj4gLQlmb3IgKGkgPSAwOyBpIDwg
dm1hbGxvY19sZW5fcGFnZXM7IGkrKykgew0KPiArCWZvciAoaSA9IDAsIGogPSAwOyBpIDwgdm1h
bGxvY19sZW5fcGFnZXM7IGkrKykgew0KPiAgCQl1bnNpZ25lZCBsb25nIG9mZnNldCA9IGkgKiBQ
QUdFX1NJWkU7DQo+ICAJCXVuc2lnbmVkIGxvbmcgcGZuID0gdm1hbGxvY190b19wZm4oJnZtYWxs
b2NfYWRkcltvZmZzZXRdKTsNCj4gIA0KPiAtCQlwYV9saXN0W2ldID0gcGZuIDw8IFBBR0VfU0hJ
RlQ7DQoNCkhvdyBhYm91dCBhIGxpdHRsZToNCi8qIElmIHRoZSBjdXJyZW50IGVudHJ5IGlzIHRo
ZSBsYXN0IGluIHRoZSBwYWdlLiAqLw0KDQo+ICsJCWlmIChQQUdFX0FMSUdORUQoJnBhX2xpc3Rb
aiArIDFdKSkgew0KPiArCQkJcGFfbGlzdFtqXSA9IF9fcGEoJnBhX2xpc3RbaiArIDFdKTsNCj4g
KwkJCWorKzsNCj4gKwkJfQ0KPiArDQo+ICsJCXBhX2xpc3Rbal0gPSBwZm4gPDwgUEFHRV9TSElG
VDsNCj4gKwkJaisrOw0KPiAgCX0NCj4gIH0NCj4gIA0KDQo=
