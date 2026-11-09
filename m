Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794262417;
	b=ULUTnLnATga/IUSNfiCaCPQ19UoQkCwHw+qnFor3M3wRmxSNGpggxFrJCcKrHAbN80Nx
	 hvwXAh2uZEbKnnUD7vZkYwNCBTycF9UOtzgfInn4uQSxkLpzZo0rA/DSaEGU7ARkUy1xP
	 BWZnoek+4R9PR88ZnpQRygZeL43z+SxK44mIq6x+2OALKn1GdwDYLq376ceZhJJjm3pxt
	 dFje/GxnTOSITortYASQvAZsqakVhTfD8SEiSrsjSPqnlwsP6OokQG2iSLpj0Tm0wyfAP
	 RDjZxKK6vQpNT1prlcUprQptZfwAReP78wei3Yn+DPIXXiQGRZyqnQUw5lpKeOY5tJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262417;
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
	bh=1qdMl2w75rh1sQ04BKUmmT+HRMovXbDI+QeNboh+8Tk=;
	b=SKU4wDf40EggPHiY94xXW7iq5sEa7Wq1iYjE7z8AVQbUifd4bm/+RteeTr/FSiDi5X3e
	 DBKZ54MEeKYVdnh1NieU2Dj0CBrOoxEqCkQyYAoPfvInWABT1F/RG56xKOaDUR3omwsZ2
	 RxCwhj+MFRcqeXiUxxlzOk/j4JMaHnGL0YewDjqtOtHsIACeig47aC70YjYJ/TVpbtj6k
	 PnvRJwwRaFLkdN9paV6XUc40gyK5+txr0MWW7B2+KPI2oEt6IMebiHkmBPfxI0oqOYqmp
	 p/jXYvSok1MUuHAyiP44TTRHW957rpik6jnvEEGHq+aItx2ygtE1nSYTWK7ynyy5BPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IqBS7TSc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37C606A321;
	Mon,  9 Nov 2026 22:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E37C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IqBS7TSc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794262416; x=1825798416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1qdMl2w75rh1sQ04BKUmmT+HRMovXbDI+QeNboh+8Tk=;
  b=IqBS7TScZvZ6aZy0pKtJFNFkUn9zxugDcKNi2gTrpp5F41pVehwfjjrb
   FQqVxzyDzWpaaTUpN4XU/DjBLknCf5TcUdiMgax8bonbq6XlyzhZnFy+m
   EiTU6yBJmXrRGlCH0sSS9ESrzxXZFj/LqXRqpnPzl2WKT6Y/tud6L906H
   vvsljBobGg5HVJUVml9t9ReMtFupmJdejMf/04rpNh23KNL+00xLcQYu3
   Nw3YOwOCASuxjkVeT2N4RzUYdph0Ars436tZh4xb278UHw8QnRXmmBSt3
   iQfzuRc3p0X7sCbozrfeMtPAPwDgaxm6SXnXM/xC/3qbjY+JVoLBMIbp1
   A==;
X-CSE-ConnectionGUID: Cv/Dp7mXQVG46WuDeUQz4g==
X-CSE-MsgGUID: F23FFXBVTU+XgYKqB71z2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2876768"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2876768"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:13:35 -0800
X-CSE-ConnectionGUID: sejckMWuSOKi2sFpnQYyLQ==
X-CSE-MsgGUID: Pvpj6I6CQpyDEFEEpEkmJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9761687"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:13:35 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 14:13:34 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 14:13:34 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 14:13:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1QG18CtEKt1zK5S15Cl3HfaOeTgogz191A5IFf/wgTsuneR01uxKhNBirQEIUJCXX0a+Y6bc89FvKIy25G2o/1lUML35mEs1BbMFN7LgEe6WLiavcY+VG5VizhrIWXohlK2oJIqbjtqfnmYKj0xWljtWkT6At3N2pO2q5pkQprRQ/WO2UbFy2Nq45jJOSCuthYYQj+UY70hqQPFgxKYwKU5vBhcjgqu74aBi//LALl/vTc4ILRsqwmK6H4aNKtQWGVHAL/JIRZrB64F9kzPtbG4MaklrHCwdviX3gy5NVF1oKqa96dkZx8EEskv46Ih9wNEG/I4wnIcXgkUWcMi8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qdMl2w75rh1sQ04BKUmmT+HRMovXbDI+QeNboh+8Tk=;
 b=LLBpQoP9KHR46428QVzsmVvkPG82NmJw51Y+PSQ+No5wXfzSpXeVp8WntCcye6g+WgSwmwwQL2Rj3lpx0wnEORmWg6Icbp72Qoo7OANc1bBe6fBVvzwGQG8OkEOBF6amBKHkEpE0PMZtrca3jlVjGkfD36w7CmcCW950icbtQeM36MRk8jtbcXqcRFRd8dwwUOeutdCkxgfVqweTK9YS6aawZbsjAKnPzcSLqUKZrr6HezmKd5w+Q9NKhQ2h/V8tdiYlG0FBWK4RPL7+GQAlAljxfO3jrNcuagZPZUt6l0Th/95hhXH/LaI8g5XDzc9xk6CTJD473NGNjg1uhWawuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by IA0PR11MB7188.namprd11.prod.outlook.com
 (2603:10b6:208:440::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 22:12:32 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 22:12:32 +0000
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
Subject: Re: [RFC PATCH v2 2/2] x86/virt/seamldr: Support multiple sigstruct
 pages
Thread-Topic: [RFC PATCH v2 2/2] x86/virt/seamldr: Support multiple sigstruct
 pages
Thread-Index: AQHdbfHM6M794mXWT0WMTIizY5g0ubcmUvEA
Date: Mon, 9 Nov 2026 22:12:32 +0000
Message-ID: <91506ebc258a9db8b2aa47310a03b60e3c653314.camel@intel.com>
References: <20261106132159.1551365-1-chao.gao@intel.com>
	 <20261106132159.1551365-3-chao.gao@intel.com>
In-Reply-To: <20261106132159.1551365-3-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|IA0PR11MB7188:EE_
x-ms-office365-filtering-correlation-id: fa0d2d8d-e618-4992-1da0-08df3eae8d40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|22082099003|18002099003|10067099003|38070700021|261021123027099003|11063799006|4143699003|261026121527099003|261102123227099003|261028144727099003|261022115727099003|261022105027099003|261022075727099003|261021121427099003|261026140227099003|261009223027099003|56012099006;
x-microsoft-antispam-message-info: W+LFpJnr/Kr3rGZjhTWgVBDhXKovg2eOHf9ZIG118JAOe/fVCQ065HMOBIbTdpZ16kKdK3hlFWzazwz3Q3amuHa/VccxbbfuOssq+YCUypBXWpdS8Olr0KG/fwDe2hfLtMLmxjA0jd6UagHCGv4NG3/LvH5DXh4eVUXVo93cfNrN6XmW/Xaz7TXVNewSl8rbCVfYee8yu4UArEGOKEk+Sf2z3wW8DE0wJgdHf8tBYeQbDL+s56AV7nLRI7RZoCMrqOEQRwwRR5NXXccDoQ6posG4a/bqKgBOdsFr9QjeWGSSyWyeW0wkTVtmAm+Rmw5ARxlZJI0wCRPK/kjjgQgimxacf69b3/gJ4sRVRPWBr8u09CDkju+s+wPgM1oT0Py8GK6ont/Iydvc1Ch33xMI8mG+tly4GB2ioxNPamqEbpsmmcy32XhvADoV+8csgczrDo8FZLmMZIdCvsuCI0w+3PFMHhwfZ+l1n+VVx+lDdVgCllDsl6ly5ZcBLBF3TuZjEWHIqRv50mImLiTitXgRv/E6HADb5U48/5zAK+TacPJ+bVScOH/FcY5CEs5vi40YmxB+HyVyeUaPKH6+AYcwJZsl+qDDYwQWjzUIF/7RW1B/ZHoZ71G4F+dWwOdBdkkK2VAnsj5mz37tbwwIhvsJXa1ybS7D305uI/EbnXHiWqH+fG7027pw1ISh8cmibCt2WRR9u0FlkSsjvjV7pVPdsfLI6OR6sAWYs2tXET/06x8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(38070700021)(261021123027099003)(11063799006)(4143699003)(261026121527099003)(261102123227099003)(261028144727099003)(261022115727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFNKRkt6MElMaGNoRk9CYk9PYWd4c2pyNjFyRnpmb3BNaFM3TUwwbmJCOVpK?=
 =?utf-8?B?bEFmbHBmYStyUEFjUmhUNXhrelJiYVFtekpmNGVTMHhXMzhOR1UrY0xTTnFt?=
 =?utf-8?B?Z05malhObXEvRzNGUjd1eDNqRDVpMkEwZXpkc0w0OTdTR2dQcjZhSTh1K01I?=
 =?utf-8?B?Um9zMnlMdy9PZTVlaHhaT0x2UjJjSUFYcHVBRkpVTXNjZENmQlVMdGN5YkNR?=
 =?utf-8?B?UFBaaHBrQWtFWHJPMFUrZDVZVlFVeksramNoOEJXOHlLVkdNWGlaTE5XR0hL?=
 =?utf-8?B?dTRmalpaZU41OGYxSnU1bVJjYkZjeUI3dnduMXZwaU9mNjdOY0lvRFVvcm9n?=
 =?utf-8?B?aFR5RkNQaC9PWFhLSzRIWGs5RlhBMmp1VVc4M3FZczVjUnRjODNja2tDSEdR?=
 =?utf-8?B?ZlZpdmJtQXJzZ3JzQVZKVzJCcC9KaHF2OHZBN2h5R2ZPU2Joc1U1WjU3RXdL?=
 =?utf-8?B?MDhzV3lrZXRVaDhMN2VRbmZEVTh4bThUMUtjVGE0cjVWN0hPWU9LazFEMEE3?=
 =?utf-8?B?bEFDTnlpaTFYdkFyWHdidksySWE1aTZ4a29USjN1d2cya2VMcHVCaGY1M3p3?=
 =?utf-8?B?VDRTbUg2aUxlQ2RXQUtRZ3pORzlLNENmYWhkWTJqYVpJK3REcEFlb1NvZlA1?=
 =?utf-8?B?Wk5OeURKc0lld0hGczBlWlN1L0greE4wL3FNT1ZldU9USGorV3VNclRaSFhY?=
 =?utf-8?B?ekMyanBrUTJsWlRBd0F3bkZLSFR0QUxSb2daTk9nakgvOGdxOHFTa3lhQ29K?=
 =?utf-8?B?QUJRb3BIV1AvU3F0aC9EY0NpNDVtTk1XV2FhNE14cndpWThnWklWZlMyUXFH?=
 =?utf-8?B?WkFiRHJuOXlHRGdobzdlQ3RITHRmeG5iZC9lUE0wa0pFQXllMTBtS2J5YjFC?=
 =?utf-8?B?Vm96QmRqSjVuY04vR0hVZ25ONHFIektWWXJyU1dmd3VJaW1PM05oOG9qS3oy?=
 =?utf-8?B?REtCcVhvSG9qY1pVRXNPd3NPdEt3ZzBzUkRQcUtobGNJSUYrT2ZhSUo3OUxr?=
 =?utf-8?B?RkppenAwWnoxZWR6Z0k0NW9NL1ZMTFRJYmx5Y0tCQ1h5WExabFY0UDZqc0tp?=
 =?utf-8?B?cTVjbzFaeFMzNm1ZMXFWMGFNem5uU3hmOHRLb3hvbnd5OStwYndLMnpKTjhO?=
 =?utf-8?B?YWFHTDQ1Z1ZLMmtBcy9kUXUrODFLT1hCN05pRENMQXY5bG9zeE5BL0h0SW1w?=
 =?utf-8?B?bTFIcVFNWmVMditkTWI0MDJjLzNkbWhiSWNSWUxycmZSMTZIbTUwTERqSUkx?=
 =?utf-8?B?N2pnOWUzSk1tRzVkNkFGLzlWQmpuK1dpMUVzeUlRVUUxMUpuMEZkRHVwSFZ0?=
 =?utf-8?B?dC94NEhvSGpYdVkyOU5vdlEzdjZsTFo5VVlPK2FYL3laQXcwMUV3OFNqZFBE?=
 =?utf-8?B?VXJ0aFNjUjl4cWhtR1N0VDY4RkNqUUtZaUc1Mm9mM3VvS1JPeUJpa0gyNHM1?=
 =?utf-8?B?NGt2dDJ5VjUyZ0FUSG0rZE4yR3lnc3B3cTBSWHhacHJEazA3TDBDd1RCWElL?=
 =?utf-8?B?U0VqcHFIZ3ZBUUgvc1FrN1JyYkNSUGIxYXhXU240U2hZYWZnQnZnVmJQc0xx?=
 =?utf-8?B?S3d1VXJQQjJDWEdSajNDQlVVUVY4TUZKKytxOGNnaldOcE16ZGkvUkVDOVI2?=
 =?utf-8?B?VWRjTTNXK3Z1eVAxK3RHYkhFUEhTd3ZjZit6c1BYUjNVOG50Qk5ZV0VjN2hq?=
 =?utf-8?B?bTczTnIrc05VYVBidWMwdHE4dGc0cFVLRCtJVk5SZzRDTTNqSVlwTGh6Snkv?=
 =?utf-8?B?TUxvMVJEczZ5MEFsWitXbWprTTZqNXBab3UxZkpOcVp1NStlTm5uWi9BdDhr?=
 =?utf-8?B?VXNYci9TWGQ0SkdzV3k4b0R5NTFPV25rQXBIbFNCWGFxcXNtN0pKNHJ1aDFm?=
 =?utf-8?B?a3FIZ0daVDh2UCs0M0dseGNTck5rTDloM3FiaWo5V1d2enpML0dnNmdXUmg2?=
 =?utf-8?B?Z2FneEJ4SjU2c2xsQm1hc2FCTk9NOWJob3hpQWE4eHc5MEk3UllnSGhUQXVX?=
 =?utf-8?B?NkhoYVkzemh2NXdaRFJvVElLa0NWZGpnTjQ3ZHd4WXF3ZWx4MmJCWWFOWVA5?=
 =?utf-8?B?T2pkakxQdWhHc1lCYzNob21YM1NyYS9FaTR2eVZ0eCtxRHRmYXRRMGRlRFZx?=
 =?utf-8?B?M1lkUm85ZzQvZGN3T20zMnV3U201RkFqeGFzSGhlUlg2QmdxeGNBSDdETlc1?=
 =?utf-8?B?OXJQNDVwMlU4d0Z4VzBFdVpTUmIxdE5rVzl5NDdUU3Z1MUlJY1dSZng5WXND?=
 =?utf-8?B?cUdaNjdFZ0ViVitmVnhmSFNud1FWeW9sZ1A5eXJoZGlFbTRUaVFNdUtXeC9u?=
 =?utf-8?B?cHcyQktDRzUxcGloQkVWakNnVWZlaW1oejBWa2JiejV1aFdwV2o4VmVFOEVo?=
 =?utf-8?Q?wgAFg62E8ypupa/g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2677420F3F11B440B7AA1088E4A92AA1@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: S0QDbIS8iZqGzbNQ8H6GYD2tclIgm4zkUnpv+olmlRgUSzztgqLKLguGBI+hiQQGc14ii2QS8+fLOxQmmuVDEmX+4AGMi8pQAAPsK98Simy9LfZmL5N8Z4gMxeeekxv0nwpeJrsVKpgPWZmVHCW3jsSkGOZCmO94F0RTiPd7HxmUCdMxD1GDxsgqZznsbmsGdFq/6mkUs4gCWT0uZcbZCpsP+Ms7zLAlwWU3EAlQAguYmLwQKXpo/bPpm9x3TGj0RAOfk++J28zfCY6D4jQ+Z0Gkreckv7S0rDSmSGmu/CKEw3uSsKBc18sTnZB6A5w7sLWU29VlqMAJKKuFVNkLUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0d2d8d-e618-4992-1da0-08df3eae8d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 22:12:32.4760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnSYogaZJ2prrFuGrDtPr+dA2a0ZEnwcKRFROfCPUUp5WRm3HnPwketxGE8hS75h3ga6wXBKB3kAH7OAVJNErM/fVlQ1oneg+eZI7SfolI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7188
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTExLTA2IGF0IDA1OjIxIC0wODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gRWFj
aCBURFggbW9kdWxlIHVwZGF0ZSBpbWFnZSBjYXJyaWVzIGEgc2lnc3RydWN0LCB3aGljaCBpcyBw
YXNzZWQgYWxvbmcNCj4gd2l0aCB0aGUgbW9kdWxlIGJpbmFyeSB0byBQLVNFQU1MRFIuICdzdHJ1
Y3Qgc2VhbWxkcl9wYXJhbXMnIGhhcyBhIHNpbmdsZQ0KPiBwaHlzaWNhbCBhZGRyZXNzIHNsb3Qg
Zm9yIGl0LCBzbyBhIHNpZ3N0cnVjdCBjYW4gYmUgYXQgbW9zdCBvbmUgNEtCIHBhZ2UuDQoNCiJp
dCIgY291bGQgcmVmZXIgdG8gdGhlIG1vZHVsZSBiaW5hcnkgb3IgdGhlIHNpZ3N0cnVjdCwgdW50
aWwgeW91IHBpZWNlIGl0DQp0b2dldGhlciBhdCB0aGUgZW5kLiBBbHNvIHN0cnVjdCBzZWFtbGRy
X3BhcmFtcyBjb3VsZCBiZSBpbnRyb2R1Y2VkLiBUbyBhbnN3ZXI6DQpJcyBpdCB0aGUgVERYIG1v
ZHVsZSBBQkk/IE9yIHRoZSBrZXJuZWxzIGludGVybmFsIHN0cnVjdD8NCg0KPiANCj4gVERYIG1v
ZHVsZXMgYXJlIG1vdmluZyB0byBhIHBvc3QtcXVhbnR1bSBzaWduYXR1cmUgYWxnb3JpdGhtLiBJ
dHMNCj4gc2lnbmF0dXJlcyBhcmUgZmFyIGxhcmdlciB0aGFuIHRoZSBvbmVzIGluIHVzZSB0b2Rh
eSwgc28gdGhlIHNpZ3N0cnVjdA0KPiBubyBsb25nZXIgZml0cyBpbiA0S0IuDQo+IA0KPiBUaGUg
UC1TRUFNTERSIEFCSSB3YXMgZXh0ZW5kZWQgZm9yIHRoaXMuIEl0IG5vdyBoYXMgZm91ciBzaWdz
dHJ1Y3QNCj4gYWRkcmVzcyBzbG90cyBpbnN0ZWFkIG9mIG9uZSwgZm9yIHNpZ3N0cnVjdHMgb2Yg
dXAgdG8gMTZLQi4gQSBuZXcNCj4gJ3ZlcnNpb24nIHZhbHVlIG9mIDEgdGVsbHMgUC1TRUFNTERS
IHRoYXQgdGhpcyBsYXlvdXQgaXMgaW4gdXNlLg0KPiANCj4gRXh0ZW5kICdzdHJ1Y3Qgc2VhbWxk
cl9wYXJhbXMnIHRvIG1hdGNoIHRoZSBuZXcgQUJJLiBUaGUgc2lnc3RydWN0DQo+IGFkZHJlc3Mg
bGlzdCBpcyBhbHJlYWR5IHBvcHVsYXRlZCBpbiBhIGxvb3Agb3ZlciBhbGwgc2lnc3RydWN0IHBh
Z2VzLCBzbw0KPiByYWlzaW5nIFNFQU1MRFJfTUFYX05SX1NJR19QQUdFUyBpcyBlbm91Z2ggdG8g
ZmlsbCB0aGUgbmV3IHNsb3RzDQoNCk1pc3NpbmcgcGVyaW9kLiBBbHNvLCB0aGUgZXhpc3Rpbmcg
bG9vcCBpcyBhIGJpdCBzdHJhbmdlLiBJIHdvbmRlciBpZiBpdCBuZWVkcw0KdG8gYmUgZXhwbGFp
bmVkLCBidXQgdGhlIGV4cGxhbmF0aW9uIGlzIHByb2JhYmx5IHRoYXQgaXQgd2FzIG5vdCBhZGFw
dGVkDQpwcm9wZXJseSBhZnRlciB0aGlzIGNoYW5nZSB3YXMgcmVtb3ZlZCBmcm9tIHRoZSBvcmln
aW5hbCBzZXJpZXMuDQoNCj4gDQo+IFNldCAndmVyc2lvbicgdG8gMSBvbmx5IHdoZW4gdGhlIHNp
Z3N0cnVjdCBzcGFucyBtb3JlIHRoYW4gb25lIHBhZ2UuIE9sZA0KPiBQLVNFQU1MRFJzIHJlamVj
dCB2ZXJzaW9uIDEsIHNvIHRoaXMga2VlcHMgdXBkYXRlcyB3aXRoIGEgc2luZ2xlLXBhZ2UNCj4g
c2lnc3RydWN0IHdvcmtpbmcgb24gdGhlbS4NCj4gDQo+IERvIG5vdCBxdWVyeSBQLVNFQU1MRFIg
Zm9yIHZlcnNpb24gMSBzdXBwb3J0LiBVc2Vyc3BhY2Ugc2VsZWN0cyB0aGUNCj4gdXBkYXRlIGlt
YWdlIGFuZCBpcyByZXNwb25zaWJsZSBmb3IgZW5zdXJpbmcgdGhlIG1vZHVsZSBpcyBjb21wYXRp
YmxlDQo+IHdpdGggUC1TRUFNTERSLg0KPiANCj4gQUkgd2FzIHVzZWQgdW5kZXIgc3VwZXJ2aXNp
b24gdG8gcmV2aWV3IGNvZGUgYW5kIHdvcmtzaG9wIGxvZ3MNCg0KTWlzc2luZyBwZXJpb2QuIEJ1
dCB0aGlzIHBocmFzZSBpcyBzdGFydGluZyB0byBiZWNvbWUga2luZCBvZiBib2lsZXIgcGxhdGUg
aW4NCmFsbCBvZiB0aGVzZSBwYXRjaGVzLiBJIHdvbmRlciBpZiBpdCdzIHN0aWxsIG5lZWRlZC4g
QUkgcmV2aWV3IGlzIG5vdyB0aGUNCmV4Y2VwdGlvbi4gTWF5YmUgbW92ZSBpdCBiZWxvdyB0aGUg
Ii0tLSIgZm9yIHRoaXMgdGltZT8gRGF2ZSBjYW4gbW92ZSBpdCB1cA0KZWFzaWx5IGlmIGhlIHRo
aW5rcyBpdCBoZWxwcy4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBHYW8gPGNoYW8uZ2Fv
QGludGVsLmNvbT4NCj4gLS0tDQoNCk90aGVyd2lzZSBsZ3RtLg0KDQo+IHYyOg0KPiAgLSBkcm9w
IG1hY3JvcyBmb3IgdmVyc2lvbnMgdG8ga2VlcCB0aGUgZGlmZiBtaW5pbWFsDQo+ICAtIGV4cGxh
aW4gd2h5IHRoZSBzaWdzdHJ1Y3QgZmlsbGluZyBjb2RlIG5lZWRzIG5vIGNoYW5nZQ0KPiAtLS0N
Cj4gIGFyY2gveDg2L3ZpcnQvdm14L3RkeC9zZWFtbGRyLmMgfCAxMSArKysrKysrKystLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWxkci5jIGIvYXJjaC94ODYvdmly
dC92bXgvdGR4L3NlYW1sZHIuYw0KPiBpbmRleCAwODdiZGYxMGE5YTcuLjljZWY2ZmZmMmE2YyAx
MDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1sZHIuYw0KPiArKysgYi9h
cmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWxkci5jDQo+IEBAIC0zNiw3ICszNiw3IEBADQo+ICAj
ZGVmaW5lIFNFQU1MRFJfUEFSQU1TX05SX1BBR0VTCQkxNg0KPiAgI2RlZmluZSBTRUFNTERSX05S
X01PRFVMRV9QQV9FTlRSSUVTCSg0OTYgKyA1MTIgKiAoU0VBTUxEUl9QQVJBTVNfTlJfUEFHRVMg
LSAxKSkNCj4gICNkZWZpbmUgU0VBTUxEUl9NQVhfTlJfTU9EVUxFX1BBR0VTCShTRUFNTERSX05S
X01PRFVMRV9QQV9FTlRSSUVTIC0gU0VBTUxEUl9QQVJBTVNfTlJfUEFHRVMpDQo+IC0jZGVmaW5l
IFNFQU1MRFJfTUFYX05SX1NJR19QQUdFUwkxDQo+ICsjZGVmaW5lIFNFQU1MRFJfTUFYX05SX1NJ
R19QQUdFUwk0DQo+ICANCj4gIC8qDQo+ICAgKiBUaGUgc2VhbWxkcl9wYXJhbXMgInNjZW5hcmlv
IiBmaWVsZCBzcGVjaWZpZXMgdGhlIG9wZXJhdGlvbiBtb2RlOg0KPiBAQCAtNTcsNyArNTcsNyBA
QCBzdHJ1Y3Qgc2VhbWxkcl9wYXJhbXMgew0KPiAgCXUzMgl2ZXJzaW9uOw0KPiAgCXUzMglzY2Vu
YXJpbzsNCj4gIAl1NjQJc2lnc3RydWN0X3BhZ2VzX3BhX2xpc3RbU0VBTUxEUl9NQVhfTlJfU0lH
X1BBR0VTXTsNCj4gLQl1OAlyZXNlcnZlZFsxMDRdOw0KPiArCXU4CXJlc2VydmVkWzgwXTsNCj4g
IAl1NjQJbW9kdWxlX25yX3BhZ2VzOw0KPiAgCXU2NAltb2R1bGVfcGFnZXNfcGFfbGlzdFtTRUFN
TERSX05SX01PRFVMRV9QQV9FTlRSSUVTXTsNCj4gIH0gX19wYWNrZWQ7DQo+IEBAIC0xNjYsNiAr
MTY2LDEzIEBAIHN0YXRpYyB2b2lkIHBvcHVsYXRlX3NlYW1sZHJfcGFyYW1zKHN0cnVjdCBzZWFt
bGRyX3BhcmFtcyAqcGFyYW1zLA0KPiAgCQkJCSAgICBjb25zdCB1OCAqbW9kLCB1MzIgbW9kX25y
X3BhZ2VzKQ0KPiAgew0KPiAgCXBhcmFtcy0+dmVyc2lvbgkJPSAwOw0KPiArCS8qDQo+ICsJICog
VXNlIHZlcnNpb24gMSBvbmx5IGZvciBtdWx0aS1wYWdlIHNpZ3N0cnVjdHMsIHRvIHN0YXkNCj4g
KwkgKiBjb21wYXRpYmxlIHdpdGggb2xkIFAtU0VBTUxEUnMgdGhhdCBsYWNrIHZlcnNpb24gMSBz
dXBwb3J0Lg0KPiArCSAqLw0KPiArCWlmIChzaWdfbnJfcGFnZXMgPiAxKQ0KPiArCQlwYXJhbXMt
PnZlcnNpb24JPSAxOw0KPiArDQo+ICAJcGFyYW1zLT5zY2VuYXJpbwk9IFNFQU1MRFJfU0NFTkFS
SU9fVVBEQVRFOw0KPiAgCXBhcmFtcy0+bW9kdWxlX25yX3BhZ2VzCT0gbW9kX25yX3BhZ2VzOw0K
PiAgDQoNCg==
