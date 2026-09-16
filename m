Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDCC4DA9B0
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584611; cv=fail; b=uZK9PxaK7sKmMEmRJvReP8kR0TPDJTcQ+seDtK3EJ9Oj+hQvyyXTsRucG1sGaa/M5o7g3Dh+uhXh9U6cNkh1V82EOWkXPW0cFfHo3pNlveHLbUmwZ8tTItor1fgjCFzo6dH3DGjsemVKVD13EKvBQQtumzyYN3zIe6NHuVXSdAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584611; c=relaxed/simple;
	bh=2bb42aXHm/h+MMgw7SeOOa8ZoTuJ+cK6WRfQbjWarfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XD3FgQffmtFzIYgyFio9u8yO91KFiIT78jEHUSx2BXblUHRKxKoN64Va8R5U0YCUnuwS113xWp2+4mbsV0nI5J3ArQwJ5vH0uNRhL2vbr5Q2IM3nzutAh//iQQWZ3aWYq9mxyZxtoNHoHbKngEqRizJdTJzKkMU2w8WlWmqcTVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XA0YPvfR; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XA0YPvfR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789584597; x=1821120597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2bb42aXHm/h+MMgw7SeOOa8ZoTuJ+cK6WRfQbjWarfI=;
  b=XA0YPvfR0+R3ruXmkfOxzhEJOlKrx0+BmxwcY0ToZ8iF49R1fPmHIMHe
   MOCsYCqmO1auup6o8U+BTtJ62HuwlcKeVRIoqGP2d/FEECcjAOPRFo5f7
   nO/Cl5yljsewG2KiKM1PP2NhiyJSgb37TkyYXBj7edHOHbinoEc4/1OnK
   iGNUiOfSZ3eJUr3PAwITD16hdwjQXQMMLfkG0vM2hMZcaLF6Yjv6J+aaK
   k8SlW8ma7XfDAw0rALcErc3cwGaq+phnuaQuU8kRdywXcQ2vPR0uyECj9
   m68NDYEIq9Txdj9qwNQ966I34c2lA5mmJRktXvVEVcO88qrtJY8FnnEJH
   w==;
X-CSE-ConnectionGUID: 9hNQN+Y+RuiGzVjtI4rgXg==
X-CSE-MsgGUID: cn5Qvo8jS9OxE7FeeqvuDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101486207"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101486207"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 11:49:55 -0700
X-CSE-ConnectionGUID: 1C8J8iCOSwCY7uKY1DgvEg==
X-CSE-MsgGUID: jJbgt0HVSSiUOD1uYbNzcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273949245"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 11:49:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:49:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 11:49:53 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.32)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:49:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkDUNyymOAKYfdi/qyE1LRnN2SikREbPPFJovsftyCFteRyNyGOgr6e7qft6H7fXKQBSIhI5XvbeG/c424i69al6RuNg2j6eXn3ZGVHsVx3nxZejNT/JCgc3cyCecRv2r+/cIjy0q6z1DpsGqottibxrCD6bxyK2nUTf3ILPOGjvIQtdAbvxQKrHWWKrg8ekJ+SPX5oBua7CUnfamQkmdNsr8Cc5BPj5jeOOzjnQ1e1N8YF8+EpivUBGEMEIyaeqWH0a3DFhIB9v7XsFD5/Ry5qNji639Yl9twtFdGJidpFZY0IZOC+KqWZyTl7ds7iegIabpQY55NRQLsdChhFvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bb42aXHm/h+MMgw7SeOOa8ZoTuJ+cK6WRfQbjWarfI=;
 b=E+1/aLo+P37IZ0NQ/pKVnnc4gx1R/LyI+aS8MiU53KiJ81orHXg8CHMzJjzS1or+YgDqY7/BfGcFEo3z1XURh/dB5fpNo7zy74UuZ23fvbmCqA5hjwjCpAJ7eNaC+3dSwK7f021qE+76ZrFdUU3vFfhgpoAXFy8lgUpjZgG4dceFu+zdM9bDdM8WvPDdlv/WF03OBgd2LLzM/rpgJeaPRcKYV1TUvqZnzgzxxhFUf7Psh2L/g4lfatfqeXYlTQvYtJKSZjhVfoEgHnL70fYrITbMLEva4cDIiEP25ntObJmut71NKHbw0UMqGOca/4GfqMYHFOo1hLZkVxBxBsMrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 18:49:50 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 18:49:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>, "Annapurve,
 Vishal" <vannapurve@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Fang, Peter" <peter.fang@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: TDG quote analysis
Thread-Topic: TDG quote analysis
Thread-Index: AQHdRXUGnV1D6jtpckytZt9IbBOCMLbRf7KAgAANsIA=
Date: Wed, 16 Sep 2026 18:49:47 +0000
Message-ID: <736a9315f3cc3d8ef7079b784bfcc7b014386bd8.camel@intel.com>
References: <24a751d16ba0dc37aa7774df5739f39734cf9aca.camel@intel.com>
	 <aqrZUZtSZ-YItclT@google.com>
In-Reply-To: <aqrZUZtSZ-YItclT@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LV8PR11MB8486:EE_
x-ms-office365-filtering-correlation-id: 6ea2c0c4-f0a3-4ba8-acdc-08df14234868
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|56012099006|4143699003|5023799004|11063799006|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: Zoy2vbDAUyaXr2MFI+yypqyTZ5Uw9CgEsCY0Cm+NgSm19gSzDiXfYkCtB64JEKjrghrItJsc8gzhh22EzNIusQOnOw+rjAD0ID9FOWM6phz3/l7CngTyGa14quwLzeln+3X+w6C2T3GOh0Js37esdoIQiP5/uRit9qscN441R36OkGfUv4JQ0yOIul32H6D0Zq8/abg5Y2n7yd565KA6N/ChpRL4slDFSYksXG+I+T5NE1V30q8ISqlfsiO59/fgR/uZH4uyRya8yt4U6OwVunjxyJXgrkpx7ggVABrluzfcbUOylvlZ9GpDaum10d7Eg3ZLeffCG7phCP/8LVom1ZBBXieWnh+0cFip3nlDnQt9hOwz4YFqACK4L6ZbkxTnHHCHvzLR6iZSJ8vnY5WOZYYfPJpxls2g2TIcOD2/fuQsZ0i1QzhvN9v2nLCTD3911QgsQ4g9Y3cZiUKVG4f1vWjhy6d+aDKqObgR7O9e8pTr+yZVO43oWbNaGNbCp6LVxY+0NHC1OejT1O+uhH3YYaIIz1i5kqX6+ZV7uhiiaOHx7A0/h9JEktmpmBxjKt2FCsXufZGbVo3rEn9AVKT2qVvWjziXeTIpJP7aFgybMUL1yPaXWpF7cRYJDKOhl76AkoufbVrLQxee4DacpDxguedV24dj7Hxit0Yx7ipPyEWW96s5bECA2KZJ8IqMxvK1hOVeERJS0WuJwQfKDSOkRASlDCO7V+JdvGMKX+NtHgc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(56012099006)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTNrczd6TGxucFZDdEFGUld3WFNoR21PMHFiNVpOYkk3YjVTS2NXOHRiRVhC?=
 =?utf-8?B?WXN2bGVNbVRpTG9DR1JmY051M1VPdW1yYXozc1RBVzZpUmUvQ3FYZEZNYU1v?=
 =?utf-8?B?N0pod1NEZzhmMnBNUDhydVBQaUoyY21WM3VXaGFXODNWVTYvMjBIWWIrWXh4?=
 =?utf-8?B?UEU3VUNCVzFIQnpaRTM3UWp2UEFaaFhHTmQvZW10QkhrQm1LL3lhNUhsMmY4?=
 =?utf-8?B?VjR4UEsvMTR6TzVZckc3bjRBUnBORHdidW0yZXplRmlsOEpCYnUyekpwVmxS?=
 =?utf-8?B?NWRFQ2RxRHhOK2tQQ2NPQ1BkSU5hR1AyOEcvVmZDWXc5ZXY1YjZ0V1VvMEJ4?=
 =?utf-8?B?T2JRRE5sbUg4NlNMRCttb2NUUXBIVTJEUURtUXZKemYxVkJjR1JuNyttbjRY?=
 =?utf-8?B?ek1QL3FLWXdxdForYU1YOThyNm92cGJiZTZib3EwVG1WbUUwZWZTRG9FNjIy?=
 =?utf-8?B?ZmoybjFRMXk0YlVLQjh0K2R3a3BISXIrdGFGVkVGRm1qRXl6dU5YajJqd1Bm?=
 =?utf-8?B?QkdYbFVHSDhzR25DN2d5QktMMXR6SHI4VDEyYTY3YUpEei8xWk01dlNlOWc1?=
 =?utf-8?B?VkdqdTFWY3FHbVRRUDM1MlRTNEYycmdBSUFzcXZ5SmlvUmRvU0NySElHdnZX?=
 =?utf-8?B?SzlIN0lSODJGZjlQRlVBR25VajA4L0J2S3Q5Mllycit2ZVdpN25EcUk1SDRa?=
 =?utf-8?B?ZmxkUllzSG9vRWZKSEp1UDhPQlhpZ3RlRVNJY1NOcEhheXdkcU1GSE85aHI2?=
 =?utf-8?B?YlhkUDF6QlNBa0FHeTlNT1ZXQ1ZmYmNqWDl5SXphWlFyMXZ2NnFibEptWldW?=
 =?utf-8?B?TUQxbDhQU09relBWaEVyZGdnKzQ2alplOTMvMm1Na3pMRGJTeXpOMDFWNmdN?=
 =?utf-8?B?d3BiYTNrS3JDaFM1d1dXNTU1cmR6ZUQ4Sk81T0JUQUpsRExrSzNiYk5Vbkdj?=
 =?utf-8?B?Z0JKNmQ4TldMTHFVRTI1Tk1vdERKUFgxeU1oby9KQmJqbGlGU2ZQTHp3TDNp?=
 =?utf-8?B?eW9GZ2U2cnlZcTNZamRFUlh2a1RTRFBoZjhLbDVwRjFFT3F6MHlsVTNPZy9P?=
 =?utf-8?B?c2FlT1FUdGc4ODF6RXB4aTBiNlNPRjY2eEYrTEdLTmdObi9KYVpOY2tWZFNV?=
 =?utf-8?B?akMrSTZHc3RFRmsvSHE5dkk2ZDVzVURFUUtzamRwT3o5Zkl6aW14SnU3MDZl?=
 =?utf-8?B?dFdPR25odEhnbklTSVBLTXlIN2xjenpSZ0EvL3RibTNhTFVmNml0cmFzTzQ5?=
 =?utf-8?B?dWV0RTdBSmFSWFdxUGF1UEtXTkdKdWRkU2JaZUt2QjIwSEUraUY2UHBpbk5J?=
 =?utf-8?B?UTJWNnIxYngrY2pXSDNRemdqWXZpWFNUUTBtbk1jalpwNS83Zk9vUVAxeUUz?=
 =?utf-8?B?NFB6d2cyb1ltcXNvelc1bnljcHVnWng4TDhldzFOOVBTK0x4cE1zazBpYSs5?=
 =?utf-8?B?azBzNStTRzFaUE12WjZTSElwVEZDUm5COE9Jem1EaTBiL0o4RzQvK0d1VWtv?=
 =?utf-8?B?cXJCTVVNZ2NWRUoyVmkxVHZvaUtXNGdxait2enJQejBNUEREOGVaQUpEMHpz?=
 =?utf-8?B?TUFCWkYwMVo4NlZ3dmJKazZlUEVVYlpTdmNzRTdhR283TlA0bmQxSHBLNzcr?=
 =?utf-8?B?blFkVXNQZkg2QUU4MFBncmY1SG1kVzZxZjl1VHpOTWdIUXo3aGFVTGtMQ1Jz?=
 =?utf-8?B?RjVNK2Fra2EzbjhKOVRMdGVucWZGMVVxQkZyWUxyZmdORUVBY2hJR2RYQWd1?=
 =?utf-8?B?K0tvSWxNWUo2WGF1YXhNTzBxRkkrMFY2Q2x0QmwyNWJwTnJhZmk5MnZPeU84?=
 =?utf-8?B?aTYvMWVXYUg3VFFCcFNndUFLTTMwNFBvSlNFWEhvVGVqQkdTcmlDTGk2UG5q?=
 =?utf-8?B?dENSaFdySzBkRUdaVHdGOTY0SktjTzF2VHltdzR1eXU2YUdNdURvbUpacFRB?=
 =?utf-8?B?bzVYRU1nQnVkU2s2cEV0Q1BERWZqSXd3dGRZMDRRSVlMMnFpN0I2TDkyMVpY?=
 =?utf-8?B?bXVKem1aVTdhalN0QVVaK1ZYSTBnNndBZGNmcVRtNEc0ckVKL0NmYndKVzZB?=
 =?utf-8?B?Wi83VUtPNGhVdmpDb3ZjZ1NUWDNCRTlLdEhWRzRwOW1zeUFsZXlxRUFXRi9Z?=
 =?utf-8?B?cWs1c2VPR2FvcVV6UVhiQkhiaUlIMmRnOU15YWY0WGZlcWdrVnpUeFIrdnNY?=
 =?utf-8?B?ajFOUms5TmltSytqRWtObER3cFMvUUtVNjYxRmV6bjNlaDkzWHp0U1R0RHpw?=
 =?utf-8?B?bUc2bityQ1JDUlU3ZGRPb1gzZTc0aDdndTNRMm5TSDhFbWk5NGFSRzZpTno4?=
 =?utf-8?B?Z3M5VHBhT3Fib3IwbWxqcnJmRGtkOEVVc1d2Y2lWMUJ1V2w0U0t1K3Z6VGIy?=
 =?utf-8?Q?QxLsICDA62xYeYeo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69402A613DC17A4E8B2A6C537F379839@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xX+oxTIBNVgrFTZvePsJtUUkRo1mkm8qncUxBylXhV0N0ckFaZ8MLPGY5lLZ4Ah+KeGIu7eZoqgRhIdc9xkHCE1yZaHfoLFktDw1MrP3M3xwcf5mM38d/vFNGRviyhEbU30ZzmWgVWS/MY1vIDfBjEZseeMgaC98mRO7kyKTgiptePfWTiaNppcKUc/HXMtut8kSgz8fB0gQJ2E+afZLpkzfuKT2Hd5kYvLYPL1YkPGlfmiib2JocTF+9USV47VCLQtTrnJGQFxm0N8NMvvCM0kzU+x9dxE2AWxuNS6eBIfM21/hPfO2cotIZYFXRavbIZhRwyUt88aOn99PhxFQUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea2c0c4-f0a3-4ba8-acdc-08df14234868
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 18:49:48.0521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mL6E/2QD4ndfQR2HS0E/PBODlX70wCCfV+vGPtxq9vV7aGaqh95gHBxkAQ6phFkA8/vRK+6b/3NDQ6A2bDpOmwkK3Fe9LpF2yOInH+c0E5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTE2IGF0IDExOjAwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBXZWQsIFNlcCAxNiwgMjAyNiwgUmljayBQIEVkZ2Vjb21iZSB3cm90ZToNCj4g
PiBUaGlzIERJQ0UgcXVvdGUgZ2VuZXJhdGlvbiBjYW4gdGFrZSBhIGxvbmcgdGltZS4gRXhhY3Rs
eSBob3cgbG9uZyBpcyBub3QNCj4gPiBrbm93biwgYnV0IGl0IGlzIGV4cGVjdGVkIHRvIHZhcnkg
YW5kIG9mdGVuIGV4Y2VlZCB0aGUgdGltZSBhIFNFQU1DQUxMIGNhbg0KPiA+IGJlIGV4ZWN1dGlu
ZyBpbiB0aGUgVERYIG1vZHVsZSBieSBhIGNvbnNpZGVyYWJsZSBhbW91bnQuDQo+IA0KPiBXaGF0
J3MgdGhlIGJhbGxwYXJrP8KgIEFyZSB3ZSB0YWxraW5nIHRlbnMgb2YgbmFub3NlY29uZHMsIHRl
bnMgb2YNCj4gbWljcm9zZWNvbmRzLCB0ZW5zIG9mIG1pbGxpc2Vjb25kcz8NCg0KSSBhc2tlZCBh
Ym91dCB0aGlzIHRvby4gSSBoYXZlIG5vdCBzZWVuIGFueSBtZWFzdXJlbWVudCB5ZXQgZm9yIHRo
ZSByZWFsDQppbXBsZW1lbnRhdGlvbi4gQUZBSVUgdGhlIFBRQyBzdHVmZiBpcyBub3Qgc2V0dGxl
ZCBlbm91Z2ggYXQgdGhlIGluZHVzdHJ5IGxldmVsDQp0byBiZSBzdXJlIGluIHRoZSBsb25nIHJ1
bi4gSSBoYXZlIGJlZW4gdW5kZXIgdGhlIGltcHJlc3Npb24gb2YgYXQgbGVhc3QgYSBtcyBvcg0K
MiBmb3IgUFFDIHNpZ25hdHVyZSBiYXNlZCBvbiBnZW5lcmFsIFBRQyBzaWduYXR1cmUgYmVuY2ht
YXJrcyBJJ3ZlIHNlZW4uIFRoYXQgaXMNCm9ubHkgbXkgZ3Vlc3MgdGhvdWdoLg0KDQpJZiB5b3Ug
YXJlIHRoaW5raW5nIHRoZSBpbXBsZW1lbnRhdGlvbiBjb3VsZCBwdW50IG9uIGhvdyB0byBoYW5k
bGUgdGhlIGd1ZXN0DQppbnRlcnJ1cHRzIGZvciBub3csIHRoYXQgc2VlbXMgcmVhc29uYWJsZS4g
SSdkIHRoaW5rIGV4aXRpbmcgdG8gaGFuZGxlIHRoZSBob3N0DQppbnRlcnJ1cHRzIGNvdWxkIG5v
dCBiZSBza2lwcGVkIHRob3VnaC4NCg0KPiANCj4gSXMgdGhlIENQVSBzcGlubmluZyB0aGUgZW50
aXJlIHRpbWU/wqAgT3IgaXMgdGhlIHF1b3RlIGRlZ2VuZXJhdGlvbiBJL08tbGlrZT8NCg0KVG9k
YXkgdGhlIENQVSB3aWxsIG1vc3RseSBiZSB3b3JraW5nLiBJbiB0aGUgZnV0dXJlIGl0IGNvdWxk
IGJlIHdhaXRpbmcgZm9yIHRoZQ0Kc2hhcmVkIEhXLiBUaGlzIHdvdWxkIHRha2UgbXVjaCBsb25n
ZXIuDQoNCj4gPiANCj4gwqDCoCANCj4gPiDCoMKgIEEgcmVzdW1hYmxlIFRERyBxdW90ZSBjYWxs
IHdvdWxkIGhhdmUgdG8gc29sdmUgYSBzbGlnaHRseSBkaWZmZXJlbnQNCj4gPiBwcm9ibGVtLiBB
IGJhZCBndWVzdCBjb3VsZCByZWZ1c2UgdG8gcmVzdW1lIHRoZSBUREcgY2FsbCBhbmQgaG9sZCB0
aGUgVERYDQo+ID4gbW9kdWxlIGV4dGVuc2lvbiBzYXZlIHN0YXRlIHNsb3QgaG9zdGFnZS4NCj4g
DQo+IFRoZSB3aG9sZSAid2hhdCBhYm91dCBndWVzdCBpbnRlcnJ1cHRzPyIgdGhpbmcgbWFrZXMg
bWUgdGhpbmsgdGhlIHF1b3RlDQo+IGdlbmVyYXRpb24gaXMgQ1BVLWJvdW5kLCBpLmUuIG5vdCBJ
L08tbGlrZS4NCj4gDQo+IERvZXMgdGhlIFREWCBNb2R1bGUgKm5lZWQqIHRvIHByb3ZpZGUgYSBz
YXZlIHNsb3Q/wqAgV2hhdCB3b3VsZCBwcmV2ZW50IFREWA0KPiBmcm9tIHJlcXVpcmluZyB0aGUg
Z3Vlc3QgdG8gcHJvdmlkZSBzdG9yYWdlIGZvciB3aGF0ZXZlciBpbi1mbGlnaHQgZGF0YSBpcw0K
PiBuZWVkZWQ/IFRoYXQgd2F5IHRoZXJlIGl0IGRvZXNuJ3QgbWF0dGVyIGlmIHRoZSBndWVzdCBu
ZXZlciByZXN1bWVzIHRoZSBjYWxsLA0KPiBpdCBjYW4gb25seSBodXJ0IGl0c2VsZi4NCg0KSSB3
YXMgdGhpbmtpbmcgYWJvdXQgdGhpcyB0b28sIGJ1dCB0aG91Z2h0IGl0IHNvdW5kZWQgYSBiaXQg
bGlrZSB0aGUgTkFLZWQgU05QDQpzZWN1cmUgQVZJQyBwYXR0ZXJuLiBBdCBsZWFzdCB0aGUgVERY
IG1vZHVsZSB3b3VsZCBuZWVkIHRvIGhhbmRsZSBnZXR0aW5nIGFza2VkDQp0byB6YXAgdGhlIGd1
ZXN0IHBhZ2UgdGhhdCB3YXMgZ2l2ZW4gdG8gYmUgYSBzYXZlZCBzdGF0ZSBzbG90Lg0KDQpUaGUg
aG9zdCB3b3VsZCBwcm9iYWJseSBuZWVkIHRvIGJlIGludm9sdmVkIGluIHVubWFwcGluZyB0aGUg
cGFnZSBmcm9tIHRoZSBTLUVQVA0Kd2hpbGUgaW4gdXNlIHRvbywgc2luY2UgaXQgd291bGQgbmVl
ZCBhIFRMQiBmbHVzaCBvbiBlYWNoIHZDUFUuIE90aGVyd2lzZSB0aGUNCmd1ZXN0IGNvdWxkIHNl
ZSB0aGUgaW50ZXJtZWRpYXRlIG1lbW9yeSBvZiB0aGUgb3BlcmF0aW9uLiBPciwgaG1tLCBJIGd1
ZXNzIHRoZQ0KZ3Vlc3QgY291bGQgY29vcmRpbmF0ZSBlbnRlcmluZyB0aGUgVERYIG1vZHVsZSBv
biBlYWNoIHZDUFUgdG8gZ2V0IGEgZmx1c2guIFRoYXQNCndvdWxkIGJlIGEgbmV3IG9uZS4NCg0K
PiANCj4gPiDCoMKgIElmIGEgcXVvdGUgb3BlcmF0aW9uIGlzIGxvbmcgZW5vdWdoLCB0aGUgVERH
IFNFQU1DQUxMIHNob3VsZCBwcm9iYWJseQ0KPiA+IHN1cHBvcnQNCj4gPiDCoMKgIGEgcmVzdW1h
YmxlLWxpa2UgZmxvdyBmcm9tIHRoZSBndWVzdCBzaWRlIHRvbywgd2hlcmUgaXQgYWxzbyBtb25p
dG9ycyBmb3INCj4gPiDCoMKgIHBlbmRpbmcgZ3Vlc3QgaW50ZXJydXB0cyBhbmQgcmV0dXJucyBm
cm9tIHRoZSBUREcgY2FsbCB0byBsZXQgdGhlIGd1ZXN0DQo+ID4gwqDCoCBoYW5kbGUgdGhlbS4N
Cj4gPiANCj4gPiDCoMKgIFRoZW4gdGhlIGhvc3Qgd291bGRuJ3QgbmVlZCBhIHRocmVhZCBhbmQg
YSBjb21wbGV0aW9uIGd1ZXN0IG5vdGlmaWNhdGlvbg0KPiA+IMKgwqAgbWVjaGFuaXNtLiBJdCBi
YXNpY2FsbHkgdHJhbnNmZXJzIHRoYXQgY29tcGxleGl0eSB0byB0aGUgVERYIG1vZHVsZS4NCj4g
DQo+IA0KPiA+IMKgwqAgQnV0IGl0IGFsc28gbWlnaHQgdHJhbnNmZXIgc29tZSBvZiB0aGUgY29u
dHJvbC4gVGhlIFREWCBtb2R1bGUgd291bGQgaGF2ZQ0KPiA+IHRvIGVtYmVkIHNvbWUgcG9saWN5
IG9uIGhvdyB0byBkZWNpZGUgd2hlbiB0byBpbmplY3QgZ3Vlc3QgaW50ZXJydXB0cy4gSWYNCj4g
PiB0aGUgaG9zdCBhbmQgVERYIG1vZHVsZSBoYWQgZGlmZmVyZW50IGxvZ2ljIG9uIHdoZW4gdG8g
YWN0dWFsbHkgcmUtZW50ZXIgdGhlDQo+ID4gVEQsIHRoYXQgY291bGQgYmUgYW5ub3lpbmcuDQo+
IA0KPiBCdXQgdGhlIFREWC1Nb2R1bGUgYWxyZWFkeSBoYXMgc29tZSBwb2xpY3ksIG5vP8KgIElu
IHRoZSBzZW5zZSB0aGF0IGl0IGRlY2lkZXMNCj4gd2hlbiB0byBleGl0IHRvIHRoZSBob3N0IGJl
Y2F1c2UgdGhlcmUncyBhbiBpbnRlcnJ1cHQgcGVuZGluZy4NCg0KWWVzIGZvciBleGl0aW5nIHRv
IHRoZSBob3N0LiBJIHdhcyB0YWxraW5nIGFib3V0IHJlLWVudGVyaW5nIHRoZSBndWVzdCBmb3Ig
YQ0KZ3Vlc3QgcGVuZGluZyBldmVudCBvZiBzb21lIHNvcnQuIExpa2UgaWYgS1ZNIGRlY2lkZXMg
dG8gcmUtZW50ZXIgdG8gaGFuZGxlIHNvbWUNCmV2ZW50LCBidXQgVERYIG1vZHVsZSBkZWNpZGVz
LCBuYWggd2UgYXJlIGdvaW5nIHRvIHdvcmsgb24gdGhlIGluLXByb2dyZXNzIGd1ZXN0DQpjYWxs
IGZvciBhIGJpdCBmaXJzdC4NCg0KPiANCj4gPiA9PSBTdW1tYXJ5ID09DQo+ID4gDQo+ID4gRnJv
bSB3aGF0IHdlIGZvdW5kLCBJIHRoaW5rIGl0IGRvZXNuJ3Qgc2VlbSBvdmVybHkgaW1wb3NzaWJs
ZSBmb3IgdGhlDQo+ID4gbW9kdWxlLiBCdXQgdGhlIGV4YWN0IGNhbmNlbGxhdGlvbiBydWxlcyBh
bmQgdGltZW91dCBsb2dpYyB3b3VsZCBuZWVkIHRvIGJlDQo+ID4gaGFzaGVkIG91dCBhIGJpdCBt
b3JlLsKgVGhlIHNpbXBsZSBtdXRleCBvbiB0aGUgaG9zdCBzaWRlIGRvZXMgc3RpbGwgc2VlbSBh
DQo+ID4gZmFpciBhbW91bnQgc2ltcGxlciB0aGFuIHRoZSBURFggbW9kdWxlJ3MgZmFpcm5lc3Mg
b3B0aW9ucy4NCj4gPiANCj4gPiBIb3cgZG8gd2UgZmVlbCBhYm91dCB0aGUgcm9sZXMgYW5kIHJl
c3BvbnNpYmlsaXR5IHNoaWZ0cz8gQW55IG90aGVyIHByb2JsZW1zDQo+ID4gdG8gc29sdmU/DQo+
IA0KPiBXaGF0IGFib3V0IHRoZSB3aG9sZSAiVEQtc3BlY2lmaWMgZGF0YSBpbiB0aGUgcXVvdGUi
IHRoaW5nP8KgIElmIGdldHRpbmcgYQ0KPiBxdW90ZSAob3IgcmVwb3J0PykgaXMgcHVudGVkIHRv
IHRoZSBob3N0LCBJJ2Qgc3RpbGwgbGlrZSB0byBrZWVwIGl0IG91dCBvZg0KPiBLVk0uDQoNCkkg
Y2hlY2tlZCBhbm90aGVyIG9wdGlvbiBmb3IgdGhpczogV3JpdGUgdGhlIG5vbmNlIHRvIHRoZSBU
RFggbW9kdWxlIHZpYSBzb21lDQpuZXcgVERHIGNhbGwsIHRoZW4ganVzdCBhc2sgZm9yIGEgVEQg
c2NvcGVkIHF1b3RlIHdoaWNoIGZpbGxzIGluIGV2ZXJ5dGhpbmcgZnJvbQ0Kd2hhdCB0aGUgVERY
IG1vZHVsZSBhbHJlYWR5IGtub3dzLiBURCBkZXRhaWxzIGFuZCBub25jZS4gQXBwYXJlbnRseSBp
dCBjb3VsZA0Kd29yay4NCg0KVGhlbiBub3RoaW5nIGdldHMgcGFzc2VkIG91dCBvZiB0aGUgZ3Vl
c3QgZXhjZXB0IGZvciByZXF1ZXN0IGZvciBhIHF1b3RlLiAgV2UnZA0KaGF2ZSB0byBicmVhayBj
b21wYXRpYmlsaXR5IHdpdGggdGhlIFNHWCBiYXNlZCBxdW90ZXMgdGhvdWdoLiBJcyBpdCB3b3J0
aCBpdD8gVnMNCmp1c3QgdXRpbGl6aW5nIHRoZSB1cHN0cmVhbSBLVk0gZnVuY3Rpb25hbGl0eSB1
bmNoYW5nZWQ/DQo=
