Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91F1A6826;
	Sat, 11 Apr 2026 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871380; cv=fail; b=CENo/dYZ4/VelUVXS8yUvtnOWO/S1AUB2YZfl480/HQsnDVE5YwZ+PI+gL2d0pfCdRnn4mwJLVvezAMZIrOlXqbUrwaJd8QRhKprqoipSK/qVi5BSM4eK00X0tIDkRbVOS5W1apDQAalokCxBHxjzFA6ioEMMbcF7a4++BatA2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871380; c=relaxed/simple;
	bh=M8HNbi0RR2iBMncgNu2bqIi53wXeRWGzx6hK5ocYH5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PAbRmw3w/NTzMfIbwU5tiDVI0WyO+v6EDCaIYyG2Vb8owoCsJ7X4jpjxbvGlAMmheSsjWMVHhQ0ZcCt5Xm8DhqXofk0aBnKA7gnjz3noBN8FjpR8rMuVyIVrADAJukCm9gt7SeBa9fBJsZS3Q2i5vyg/J1f6eH6XAOuieTOqzk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6gCEsJv; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6gCEsJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775871379; x=1807407379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M8HNbi0RR2iBMncgNu2bqIi53wXeRWGzx6hK5ocYH5o=;
  b=F6gCEsJv5n+NfxN4wAUv1ak668iiuGl+rkKIPBoITAzqv4kYV+C+IWE8
   8IS3a+waSJewYMBLOxQUddzis6DO0xDL/QeTKYYoEpfPIGJMhUNDGXB+m
   ou4WwuSi8oOHcTpuODPTySOKqgv3BhHRWQS9xiDKTfIVvtyK0xs/O828D
   QY1cD2OelTGeHU+T8NCpIJGtIogkg7JnY8FsceBcAV5n7xmx+oBPbBDUy
   pQcR9vG8g2roDkfe/yJwQBI39QB8ROwMSW5PJgJs4DHl2bVanBn3PxKRB
   vl02/3gENG5pmPiQk3fIewBxI0HfEp63Vp+H9DuJtJovyAkh0BdTl1y5k
   A==;
X-CSE-ConnectionGUID: 9yLoCyo2QiazrMM76lCfwA==
X-CSE-MsgGUID: qIDVTtguSRKzNZsgYpyt0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="80485027"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="80485027"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 18:36:19 -0700
X-CSE-ConnectionGUID: 8r86iAAoSamnfgi4zEC4nQ==
X-CSE-MsgGUID: S84JQXnZTNWPKCgPWUs67g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="224521508"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 18:36:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 18:36:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 18:36:18 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 18:36:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9vJgWwaNgWysHq5BO031bsQVG0MqYbtnxAUNlJdph0WksD8iOSKK4XAj3zsP6VAHAtw6n4sk5eSXNrRo/Y0He+25Ckpk+0JwJYGYK3bqLL9jvU8t7Bc4bp4jmE0bhfwByvQStfpi1jD+s91OSQ9pXFbGp6zT9n6rumhweidSvihQ7HOCY/jKgwgoGMqpxD3/TlqbEbL5T40vEkltQmE7UAsJ8LlXAT5JVJSBtbXBlLkewCyQt07QUZxZqVvVTDldhd43UMzVWcwxhBUlR3UNZWhM/N4o0xjI0IsGPjuWx27hqvWAOiadIdOOaVh7nmdZKtjSRrjXtQJaUvv4kJq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8HNbi0RR2iBMncgNu2bqIi53wXeRWGzx6hK5ocYH5o=;
 b=UUiVFFO2ZEDKbSNfD8FeDD3J77Cax2c9j8QuF8lYlHUdLhwYM5x7T5MuUDk0NohzMFPfGbHda7JLnWz1UZI2cs9zO0cBQklvd8syRGAUaBfS8DHSeRdKcaRNYuFo+RFkXj+Vx7iwpFMwXEokxI3RH+ICZwZDSj4aCCG3czkV+U2FBpoWVmXWYftzTotbo4uyV5ced6SbsTrQqfH7Fa1QtDTFGZrO3ghEUrYtWNLLbU+sdyAvHadh8iT6uRiLq89YfKGi4/Y5EkOgallDOTHUB7oBZu9TGORoS+Dwd24z+3wYKVWK1tBHOCQMeTWuX/MPVSYvTqzVK/wA7INuOv4syQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB6786.namprd11.prod.outlook.com (2603:10b6:303:20b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Sat, 11 Apr
 2026 01:36:08 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.014; Sat, 11 Apr 2026
 01:36:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 11/22] x86/virt/seamldr: Shut down the current TDX
 module
Thread-Topic: [PATCH v7 11/22] x86/virt/seamldr: Shut down the current TDX
 module
Thread-Index: AQHcwQwBQdKo1xDEBkCS+uvoFa2Ab7XZJN+AgAAALAA=
Date: Sat, 11 Apr 2026 01:36:08 +0000
Message-ID: <ccc48b39a2d0d5e6b9ffc5f003e074fef335d81a.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-12-chao.gao@intel.com>
	 <a50bb8a4d8c2bdcb0795eca4551567fb5a577215.camel@intel.com>
In-Reply-To: <a50bb8a4d8c2bdcb0795eca4551567fb5a577215.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB6786:EE_
x-ms-office365-filtering-correlation-id: c6c41d21-6b54-45d3-bade-08de976ab4ab
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: p5UJcb4Agv0Jz+KJF0gvJazc+U3Z3Q9Hr26J2gIHZ2s049PrR4qXUP5nsET2GiUmUMzOrVZQkuIcrRpQcHmVNpSxI0/gPLRjqq7tU2Ju99wXEoVMsS/3VooroYs/t18gG12ETiJNkdGWB668aicbo6aE2YSP7LxXaZhHWo7Tbi2ZeqFLxeCkQFoW9OLz6MAlBm8OFFV352pHFSTBa2El+jzNOXa3Fsr5oY0rlDZsNGgqSFKyKCQaXZGkZ6w9KFDm66Qh9bPn9MJevHtEaxIM5CvuypFRvpndmV+i1youCSeFaUzNyUY7J8dcL/gHDbZ1wUeJUgjl7rtsYuRvC+0iDQEIxC+8mc/lKteks3aN3JGWiorWJiSsW05/LU1bfVHKkyUYkzD6ARamtLy4KPVBts9kll4K2Yn9WE+pA5y3fnkgS+ouQPrrryHhe6HZvSSKNHKOiApz49mv8o54jsBRlRhqfRMEmFubbDpCFdr2WwM9IIpIQOx5leb0zjuIg5TwE5fGPX99P+VlYLZi+/ANx1+AnMPgXW8UP4g50luGmm3jT3De4Xvw4Rt3SRf4h9siHS70ZUQKR3fEc4HuyzYCxUEia79HAd8IsVRuHLHS1/gaN5BlhYFLjbF6w7AtwFSaFqng4Z8/Lbgut9m7/i6cYnpKqnSX6mnU6DxaZadpEhph3DkLTfk6qBHhaDH9Wh9Lxf84JsS0kkEhET9vSnJoZ/5DF4KilGF63HnATfGLGa3s4n2Erhc5dRZg0QuZAgJeFrmILtlHxjhKv1r8i62+v8KMVFV/3gCj8XtDMho6d/Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDd1NSsya3NyeFFiUXFadHlTTTdqOXcrN2VkMUZLcXN3Qi9PQVB3Qk1xZGxE?=
 =?utf-8?B?VDdVZUwzQnBIMW9yNzhCSWJBQXI2czYybExhVzh1bEtQUk1CRGZZRzFFckh4?=
 =?utf-8?B?VXhwVUVqNThvTE01N3czOGtoc1p5N05SdFJnQzJXMVBOblAzbTZkRTd1NHNY?=
 =?utf-8?B?SHJReVJVY1pyVGFuTGVBTlNVUXE3TnR1NlA5RUhRZ2VVbHZNdXV4WW41ZkpJ?=
 =?utf-8?B?a1FxdXU3QTBISk40ZjFCaHdxMkRWR2MrM2dUUHdLQVJBNVdVMnc2dWc3N0p5?=
 =?utf-8?B?UThCbm05UkNnNzVKY0ZrQTVPYlFoc2tjTlU3a3ZLMExuS3Exazg3ckhmRlNW?=
 =?utf-8?B?TFVsRGhoUjRaQUhQZ3Vib3A2cWJSTHVSem90a2oxZjVVdlIvYzR1dnN0NEpE?=
 =?utf-8?B?TnArb1UvUTZRd1NoUGdDbFFxTWJad1kvTllUY01XY09zR0xCNkN2WjhSSjha?=
 =?utf-8?B?K3IzRVJmOFRXaG1xem5qMmE2K1FPOStIYkI1eWFmSElRTlA0eGNhUHhrQWwx?=
 =?utf-8?B?WWtVVEFZS0xZZkJYOHcvMzhCOEg1Nnp0T1BBdEo0c04rOWJ5L0R2dFBYc21i?=
 =?utf-8?B?MENGRnpOakdoMnlIWmI4U3QzMi9JTjBGZ3RoNWZlMlNubVIzbkppQ29vcldS?=
 =?utf-8?B?QnpKNWNRVzNjOVJFdWxtZmlpbVJlRnZSa00vYUMxUTI5MVFDOG1nN1V6bUlG?=
 =?utf-8?B?OUdNOTNKb3BwMVptbml0eitPN3Jxc09Tb2V3ZFUwT21DRlZIYnh3NDVVN0xC?=
 =?utf-8?B?dDZ6Q2VsVEVOTUVVbzNOaXliNFhNaGV3RCtYSFlvNFhvVWsrclBmWkx1cnZF?=
 =?utf-8?B?cXQ2NW11bitaelVzSWxPeHlrV1ljcTRWRlorcVpTRWlyS1VCQ2ZpdGRTUmhk?=
 =?utf-8?B?aFJIY1ptOU9zMENXY0FTZmpTTi9OSHpxR1dWaW1YRlFSVkpFSGo3bFMzWHBv?=
 =?utf-8?B?VnZCRjQxVjB1VG1Wd1dBbjE1bWxPOE5BQjloR2trMDhWWi9hYXdiSWt0N0Vn?=
 =?utf-8?B?aVRXSDN5TDFCQU5wMFNpNmhVRFh5c2tnTXpXZWxzbUJhNlNYNnI0dS9nYWFr?=
 =?utf-8?B?QzlsbGowdURkZkgyVU1vS01uSVJYMGhhVHAxWnFrWVRNN08wQTN4SGxsbHhj?=
 =?utf-8?B?Z1hUU2hXS2xnVy9xdStyZUJad0lpOXBzNktxSGJGTmpPOE55T3BCcWxwTFcw?=
 =?utf-8?B?YlRkSi94dXRVaFV2L2ZQWml2eFlQZTNpWVpoV2RxQVhKbkprTFdvZlMwRmRy?=
 =?utf-8?B?VlBMMHBYRHZWYTNuMm9sSmVoUk5wMStITHRjaWVXcm54NURDT2JwYzN6WHdt?=
 =?utf-8?B?SmkzUklvRDVIRG9BZDN5Q3N2djhEVFFxUGc0Q0FtbitzVU1nNlcwQ1lFRlF0?=
 =?utf-8?B?THV1WmpwdXY0b21nYVN4OGExakpqcy8wZ29tVi9ydU03ak5LR2FCTUV5cDdX?=
 =?utf-8?B?bU0vZmdBNFNXUEpuYkMzUEhaZ3FYbDdkd0N4aHNUdUZyMmdYelJ4Q2RiRjRx?=
 =?utf-8?B?Yk9aNjV4NHlQZUpEMTk4ZXpZamlpWnlOem05ZmdvRklVMzA0OU43bnlObFpx?=
 =?utf-8?B?dzBleEovaGdldVlMZ0pEcStLNkM0Y1JuckJnZDJDSkFHMGVrbExiWFJEeVBY?=
 =?utf-8?B?TktaRnBJb3o0ZXg3N25UY2ZVVVJlV2E3Um9OU0UycUFTcFVjMjNTVm1UR3ZJ?=
 =?utf-8?B?cGJUdFRmanhBVUI1S1JhejNZZ2I4QnhmcmIvbk1kLyt1NXpXbXlRWFJTSy9u?=
 =?utf-8?B?NVlPSHJBQWhLckJEYWdIS2FSeFd6UTZhaC9nNXFnY0JqRzljTVQrVG5JUUZK?=
 =?utf-8?B?dnBjRllXLzhUa29FT0JvUmo0YkFqMHRGZUw1anltN0dTL2paakI3Q3l0N1dH?=
 =?utf-8?B?d1c4clhJRnhQRVp1K0ZZaVBaUVNYV05pQnZaOVNkTXdZRUZWSWs5b0xmMXVk?=
 =?utf-8?B?N2p4Z1ZjWklQMGp4SFBtODVQUU11eWs3S24wdGJrSWV4dW9NTWR6eUhOczEv?=
 =?utf-8?B?dk1qcjJISDNwYWpjeHFWbG9tbXFFNkFjZUxia3JSak1JamhPV1ovQmRtL0dK?=
 =?utf-8?B?T09OMWhqaFBmSW5ISGVSV0I0QzUyVjFaUXhZZTYzb2hUcmNnUE1CR0tUQU5o?=
 =?utf-8?B?cVV2RFFwa3ZTMDJueFpSMmtySDk5WlF2MTExV0h6M2duUHIwU2JFVy9ZUkc4?=
 =?utf-8?B?UXgrdDBtcFh5L2FTb2cwZE1Rdi8wSFY1ZHJ2NXJYd3JUdmxOVlJhOTk5eXg1?=
 =?utf-8?B?Z0Q2anBYVFFOT1VNQXpwck1BVm8wZjZ4c0htRFNnbENEeXhlTWRQR1dHVG1B?=
 =?utf-8?B?RlVFMmR5VTVPSkpCY29mZXpQMFk2clQ5c1dJcGFVSGRIYzF0SmU0ZDl6TzJE?=
 =?utf-8?Q?I0AMJxPkrxQBFc28=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B837F54A2E06C947AB4A09681026B21D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BJUVEIQGWzN+N/J0zvRORWETGQSXcqkLoHjT8F29Jrunq2SFDYP58qqg22zMaYI2dpfZ5gNt4jkC5mYXdWoKzt5H2ZxWT9sU2qEm5TbEWUVWwwfjlT+smhpHvVKT1zJbn47r4+K7vrQkNq/nXA3Fdc/wuutZFzgsx1UbLBdD8kc5yP+cDk3NyERxgp+oKsaRk3cmKq/G+vjkaqqY4glIb8C7l3nDJjRT2V9v3QmJkjP9mOgVBiIbJRt53/ADSU2XBGHZ0Tu5BgBXH+h7HkHH19/k169C10H6YXiUB+uyWIECTQLH9NfczqOnP4jRMWTnE+tQvIBYLXuO6Tom5f51YA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c41d21-6b54-45d3-bade-08de976ab4ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 01:36:08.6136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJMQyUQB+ULPNTOIowR9TkEUQmddowvPtqM2mtRR13kSU2kj7JPOdLgqMraHzJ9Dl6yPE1IQewynQrg2rQAg3u9SPj2nWEKpl4oYelCCkVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6786
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA0LTEwIGF0IDE4OjM1IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gVGhpcyBvbmUgY291bGQgcHJvYmFibHkgYmUgbWFkZSBsZXNzIHZlcmJvc2UgdG9vLg0KDQpE
b2ghIFlvdSBhbHJlYWR5IHNhaWQgdGhpcy4NCg==
