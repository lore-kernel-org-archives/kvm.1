Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9C4E77EF;
	Wed, 23 Sep 2026 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187595; cv=fail; b=ZWaFrELIgEf782uPYHgPEMUeMywfxds3y1/dmpG9tMx91nW2gOdgAVWs+VKF6gOIfclqyxTyKn35NFz2cXDYFI2r+j+N5NcjM6BxWW+uCL0XD7+c3kv+nZMuzS+uDH2Kndifqxk/BUqK9zA+XfvxuZHjOYiu43MKxKxtWBSzSto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187595; c=relaxed/simple;
	bh=fxZZCsBFKlIkK0NM5LDBFHW8OD3K6Ui1ukVg+0glemg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SQFOV9KL1zRznZ544fGPSRFegz+ti4Rhsyki3hqBz0Kex7adlM8ip46SZpsJgyUvQ+erkCXaCStF20Ouc2VvBSf+hZORoiXVmpNFPD/d1NjYAwOx/gmJh3VuEP42OCACVLGBo5S5vizBOxCT/joDRItTD/CdlKQ1gt8NQcA7ysw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amKRdQ5C; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amKRdQ5C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790187593; x=1821723593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fxZZCsBFKlIkK0NM5LDBFHW8OD3K6Ui1ukVg+0glemg=;
  b=amKRdQ5CdrvYT2LoMHsV302405w9VJDg8Gh6bixBJ1O/JwjGkXsehx3A
   BuRh4yYv5OC1j0H6YlQac9/Af6M/7D2QkUB8iqvt3xK5lQXLAqkSPorIq
   dmlALEbX5BPOceXOcObnH6dEan1txK7TOenyR3LGs0yhoMKfZzcBfPW/n
   KKTWOv13IrfZXhJCVC7L34t8Z4r8wnT4Z2vhgWqk6XD8pOaApPv0w9OPo
   /DBnLnmNLu/stKFEQlw3fNv+wBSRGTa6rBGwOy3n7ibwMK9KVu9HNT3J6
   ANS2rKEIyI+JPHt0nI7QYP3q/45ijIafV5daXtmZNa2z5q8gDLwva2zSM
   Q==;
X-CSE-ConnectionGUID: HdvB2QYjQHqy1ofZI5UrXw==
X-CSE-MsgGUID: +sdV4iHnSJCGxrEz3qJuWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90783722"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="90783722"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 11:19:52 -0700
X-CSE-ConnectionGUID: JtxjTcxhRpy1V62dag8Wgw==
X-CSE-MsgGUID: 0g1GERoXRJymFWwqagkTtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="272910816"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 11:19:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 11:19:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 11:19:51 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 11:19:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyzRkaHeM8nXf2+hdmcGYRoNqy7CpzRp9ABNd6M88xQ0yj7Wonf6MQ1OcANwUYvoHzbPh2W9WWdVYBiOxGNJK/ljuqRekN1+fj/OOO3w3ZLm+y+WtOmjPFmcsGgEAh32JvRBUYqfT0Nlt66WX+jUUchLHgwHj/9r6MW9PQLhipyARznygCUjTos80jI6ppvhOT7LhEKvvrOlgL3MPLUKcyMhIQ5MCHnu3+ZbjKQqcfDusTXklcTbdvPKrH3DwuIcIUDcRJJ75OoC9C3huiYZTnM1+/g0MIssTDv+P2TfKXnAojwjFuCPrcw06Hk8Ktvydn3V1d9De7OzNMw1vthkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxZZCsBFKlIkK0NM5LDBFHW8OD3K6Ui1ukVg+0glemg=;
 b=XSY4YsDbdlB99qXZBOFTjNIRZo45/Sn32l8qc9VAqgxVdhdhzHBM/J6EpiU1vSLSUZQXv0AHtM6r5OKJ2dJsNQh0nsHjjCIzu145W9pCohIOq5m/btZ217oQ64wbqFf+F88jegahecVUu9jrnSHXw586kVvviVwurcllPsMnEjxveWrlS9P3p9fVkWKpUzFKTdIdfjdd+w5lVosipNgrqePMnyf/W9fWOJniQDd3rFbHcGvWA9IELnquT9eTKZf09OGixyymIjR7//GxgYNM0vwE9v18bqWEGfu3+1w8+LqKL4PShuk8ewmMq9nWcfLyqFiq/DeQMOclhvuTknDPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ0PR11MB6672.namprd11.prod.outlook.com (2603:10b6:a03:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Wed, 23 Sep
 2026 18:18:06 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:18:06 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "Wu, Binbin" <binbin.wu@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
Thread-Topic: [PATCH 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
Thread-Index: AQHdStRWGuydSOFmwk+y3PD7PUHSErbbv0WAgAC6zIA=
Date: Wed, 23 Sep 2026 18:18:05 +0000
Message-ID: <ba9c2098940c48375a759e7e83f028068fd560ff.camel@intel.com>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
	 <20260922205215.870563-3-rick.p.edgecombe@intel.com>
	 <arN7JeQa1f8V61UJ@yilunxu-OptiPlex-7050>
In-Reply-To: <arN7JeQa1f8V61UJ@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ0PR11MB6672:EE_
x-ms-office365-filtering-correlation-id: 912fe81c-1d03-419f-400e-08df199f03db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 6ZmFAkArPLvdBhtUUAO5c5o3Kxyq3ebRleDkYrKFwcv8ZDse2kajFInWR6WEGFZgOiMRoq0MwZPtsTeDdnc0D5lzQW3h56ZDdsFdqfvLf4RTPCrGtDMMOQhiBuFypFAXhftJFbesaIJVhVHwYEYz5jfWGBy1XBMe92emsnziEJ2OSR2pVDB/ck3tBa/9Xw6f3DES9UFk1jrRkEZe8VT2LeNy3O/yzXa+dXJqOIWVSxx53DPxVKK7cJHrjJssxLnHNrk27xYGsmaxLk7/6f8OfW4ieVFYCWN0xPHV1emeUC46lMR0k6Y9FlCDm881hAuod1EbXDVe5thrJ61BGhPfkH9y92/jB9ZropUBXb3XsId1BHpvQlEcgswKDXtpVC+0HvJAyN0einyU2i8kwbQNxuSJA0U2J8JZ3Z01iGCkelBjO0h+7c97KmVltdGaBqFFQzUkv2QRDDuAibI9vF9Dxg0BBe46MlbIfoADuqLKzLiQRByBX6LIM3dx27L81oTmrSNuByniTVe/c/kpiXUsw5EziKvoVWRm4D6LD57F8GSUJ8lgrDpFzdJJRsK4PjN7qn0R9FvE0pEWXKUMvYT1rQQmgYnrrSdP0liy9v3liliSuNi0d8/i5ToCVCSJEyt9XT7Q+tI7Ttf7zwK/MsrhosaKL6EpRL72bpGVWkBr1l/OLbWslPjuf9T/GpjAUYgla4Vj3EpRDzN94zyCNd/PRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1pnb1lmSkxuSGhqYjdQK1pOQmdlc3c0WG56ellrRXd1ZC95RVhDd0tGQjcz?=
 =?utf-8?B?cmRnRXdrOVlVWDIzLzhWdHErQVY5d09jaUVUeDR5aXFCa3pJZVdtV2c0S3ZE?=
 =?utf-8?B?aVB1U25uQTFDc3BvcEpwSW9YRUhEN0NYeGJ5WkYydnZma3pSQ2lRTzdSTzVx?=
 =?utf-8?B?TG5yR0MzRTA5aVcyY1B1OEE2bE1lYjlZejVuNWJhMS80TllHT1NVUERjV3V1?=
 =?utf-8?B?YWFOUnFGVXRPQXpYTGJmejM0SkVkSkxBNXpKTGRmMGxDU2dkd0FPUWxiVllk?=
 =?utf-8?B?dUFkV3hPaHMwRFVrWXF6ckJkMWdidUZOQlZEaXg3bE5EWi9mT1A1RUt6enIx?=
 =?utf-8?B?VVB0OTVKMzc2bDZqYmFJOWhJM3lPVmh6K2FCWHUyUEFyZm5MTXZpY1czVXBP?=
 =?utf-8?B?UDlTUmlBY1JKLzZuYi8ySDhzNnJzNm4vSlJmVWlFRCtWNzRvWWp1TVJuT3JO?=
 =?utf-8?B?enVLTlFvNXdmaGlnemRlSy92cWxkb21DYms3RUhZdTZJMVkvczVQeGtOSTFR?=
 =?utf-8?B?RzNHU2xiaW5qYlFkQmlYb3VidDYzUFBxNmg0WU9BQUh3NTVXNnhuVXczazVx?=
 =?utf-8?B?K0hmdWovVW5tZGdaSklrcys1SG5CVmFPSjlGQnN4TXBvWTVBdFZBbTZoN1h1?=
 =?utf-8?B?TlVFNWUzWDgwTEtNaTc4WlBIalhEbVRsb0d4VkVIOS9qK2dMRmE0SUZJMmRO?=
 =?utf-8?B?d2FHSkgzeFNobFJHS0RxSEU2YklKUy9TL2kybWVqRGlmWk9ubkxGbHhLT2Fi?=
 =?utf-8?B?elU1WmNzQTZ4Tld4cUlqV0Q1bHgyRmszbXRUdkFOOU1UV25RZlhUTXpzamhr?=
 =?utf-8?B?QnQvaVdrc21YSk9MWEV0OVIwckJvTGdaUjZ4VUhmVWU5UUY1T3dqSWtGTTVI?=
 =?utf-8?B?YlBGVS9SUTdPcFlYc0Mvdm1HREZ0ODkyWThkZW42dlR4YU9mT1VHN2htOHFZ?=
 =?utf-8?B?SXhNYkNBejZiMHpETGpMWUZQUDVpWHZYczBNdGxmK2pTZU5ENEF3MU1DVkZI?=
 =?utf-8?B?RWZGZGVFRjVPaGhxcHB0dGtic2VhOGsrcDBVN29mWVpXSXRCb3p5YWJoKzBU?=
 =?utf-8?B?OTJKSGNoSE5lclYyc3lzbXJFOTR3MVZxalRwdkJKeGR1SzVlZGVhb0dnZmpY?=
 =?utf-8?B?cFFkYm1tQnZLR0VVU2VnRXFIbWFYZm1EZGJtU3ZnWFp4MlVlUmloWkdCMm14?=
 =?utf-8?B?cVZqQU9aeVpoMDRvbnQrM1hMaUVoby9EZTdtbzUvVm95V2IwcFRKWXRwN1I2?=
 =?utf-8?B?eTlEd2VHVmlMRk9zYVV3N0laUXF1UWYvaGtmZVhSd1o0cFZvMDYreUl3dE1V?=
 =?utf-8?B?NTc4ZlBqUE5GNDFpbkhlWXU4c3JHQ0htdDZNYko3Wlp1d2tQM3Y2bG9KbGZr?=
 =?utf-8?B?d045RkxUa3U3MDhRcTc2T1RQT1ZoakY1TFlRVXRTdldMTnE0alVXSTB5ZkxR?=
 =?utf-8?B?bnB3NkIreWZTUXJLa2MvaTU3elduV3ZUQ1N4WExYUG5vUHk4VGZxcHNzZnlj?=
 =?utf-8?B?bEV4U1RmYlZDZVh2VzFUVkZOR0h6dUdhZW84Qml0Rmhuc0xGTE5FUjdsZDd3?=
 =?utf-8?B?Zm01WUxOSy93Qi90emk4V2l2R0N0ZXF1YnM3UFRqTVFGNk54ZXljeTdhSnF5?=
 =?utf-8?B?azZJcnhLOVY2TE94dDVZMU1kRGxaSmZFUXVuS1dkYUVLRVNGME4xQ3Bicllh?=
 =?utf-8?B?bWNlYk9YZ2hQbDdMVS9HdUxmRHJTQjh0S2NDM1IvQjgwR3dqbVFjVzVXUE5S?=
 =?utf-8?B?WWVGOFpBUTlidVJTcW8wVE1MT1BKNkozQVhYR09DaGx1OHN4SWJNZTFoS21p?=
 =?utf-8?B?UWI1by9QYm12RHlENnZPb1Jja3ZwMmxIQlZUaHRFa0lRYk1xZUxNbmdEMTlK?=
 =?utf-8?B?cmlwZEFWT3hGNVA4ak92T1Z3b0I3bGdRTUxQUE5MVWJ3UmhVMWZsSkpVakV1?=
 =?utf-8?B?SWR5VnFwYjFxMDFBYW9CcEZHR3dheHY3bE53UU4yQ211c0FCYWRFMWRkaVNo?=
 =?utf-8?B?VTJMakZQVC83VFRJOFpXTEdTYmR3YTQ5T3F1MittUUpMVmRPNUFlc2JzM1hS?=
 =?utf-8?B?SnVRZXhVVnF6UmxOY2NPRis2T0ttNkM2dTA2V000SW5lelBMa2hJRU1iOVpn?=
 =?utf-8?B?MWtIbXllUE5zWHNUeDEyMDFCWGRuR3BlZHNUZmNRdDlnSEk0TlkwSnluYVJX?=
 =?utf-8?B?OEx2Zmp4V1Q2L1h6dXJJQ0hsYWI1NjhHRUNGS2tlRWR6cTVuYm04ei9SYWxn?=
 =?utf-8?B?cVpqZ1JsbDlZK3pXZlp1ekgzUW9sTEdhcnkrc3dVWGZyQmNQZ01VTnFKSHRs?=
 =?utf-8?B?UDJlbVBCY2tCeU0rTk95akNMcTcrT2ZqMSs5RXE3dTc4ZFF6NVpFbSs3am1P?=
 =?utf-8?Q?hiJhLcMHB65/xelI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38F4BA6FF60C3144B6BA9B120AB45922@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tM651lHFL0Gub6Zb1Pi+2qpJTe3hwVATaM4OEwndOGmfcvyuifEngWq71A/s0SnXoT5PlcIxU2sD1U2o5XH+ui97m8sFEaaVZvY6K07+0J+ZNGTSGl29eh/UU/5wFOBXfukxHVuB5oJm3W4qrdmop9hYF3Wf6OXQ/3Hx3ZhQGQiZapA3t01LEEt2BNOuPytEd94J+ad4+yIG1KLOpXli0JvrkQkI5bsbdBY6kCu4wRahzqe08LDeuoL7c52K4x4tmHbwxyVdHa2YiztZIOLlhhXKcC9FCccWD2lEnxklW86nqbKLogdDL6g+rbZ4WazsMyDK7MUEOFwfv4sR6YDd9Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912fe81c-1d03-419f-400e-08df199f03db
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 18:18:05.7230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkgJ2tCXke5e1HvBadBJBEFsOH8gtCUumZ5mKeIah/+3d7BUiRbUU9OmLsAlbuRwHL58t364qpBu0N2+J0oZMM5eRrOC7MsG7cUxPDfEfdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6672
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDE1OjA5ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gwqBT
aW5jZSBwcml2YXRlIEtleUlEIHZpcnR1YWwgbWFwcGluZ3MgYXJlIHJlc2VydmVkIGZvciBURFgg
dXNlLCB0aGUgVERYDQo+ID4gbW9kdWxlIGhhcyB0byBkbyB0aGUgY2xmbHVzaCBpdHNlbGYuDQo+
IA0KPiBUaGlzIHBhcmFncmFwaCBpcyBhIGxpdHRsZSBjb25mdXNpbmcgdG8gbWUuIEhlcmUgcmVh
ZHMgbGlrZSB0aGUgVERYDQo+IG1vZHVsZSBkb2VzIHRoZSBjbGZsdXNoIGludGVybmFsbHkgYW5k
IHRoZSBob3N0IGRvZXNuJ3QgaGF2ZSB0byBvcHQtaW4uDQo+IA0KPiA+IFRoZSBUREguUEhZTUVN
LlBBR0UuV0JJTlZEIFNFQU1DQUxMDQo+ID4gbGVhZiB3YXMgY3JlYXRlZCBmb3IgdGhpcyBwdXJw
b3NlLg0KPiANCj4gQnV0IHRoZSBTRUFNQ0FMTCBsZWFmIHNob3dzIGhvc3Qgc2hvdWxkIG9wdC1p
bi4NCj4gDQo+IEFoLCB5b3Ugd2FudCB0byBzYXkgaG9zdCBjYW4ndCBkaXJlY3RseSBkbyBjbGZs
dXNoIGJlY2F1c2Ugb2Ygc29tZQ0KPiByZWFzb24sIHNvIHdlIG5lZWQgYSBTRUFNQ0FMTCwgaXMg
aXQ/DQoNClRoZSBob3N0IGNhbid0IG1hcCB0aGluZ3Mgd2l0aCBwcml2YXRlIGtleWlkcy4gU28g
aXQgY2FsbHMgaW50byB0aGUgVERYIG1vZHVsZQ0KdG8gZG8gaXQuIFRoYXQgd2FzIG15IHVuZGVy
c3RhbmRpbmcuIE9uICJhbGxvYyIgeW91IGFyZSB0cmFuc2l0aW9uaW5nIGZyb20gS2V5SUQNCjAg
dG8gc29tZSBwcml2YXRlIGtleSwgc28gZmx1c2ggYXQgdGhlIEtleUlEIDAgZnJvbSB0aGUgaG9z
dC4gT24gcmVjbGFpbiBpdCBnb2VzDQpmcm9tIHNvbWUgcHJpdmF0ZSBLZXlJRCB0byAwLCBzbyB0
aGUgVERYIG1vZHVsZSBuZWVkcyB0byBmbHVzaCBhdCB0aGUgc291cmNlDQphbGlhcy4NCg0KPiAN
Cj4gWy4uLl0NCj4gDQo+ID4gQEAgLTU3OCwxNSArNTc3LDYgQEAgc3RhdGljIHZvaWQgdGR4X3Jl
Y2xhaW1fdGRfY29udHJvbF9wYWdlcyhzdHJ1Y3Qga3ZtDQo+ID4gKmt2bSkNCj4gPiDCoMKgCWlm
IChfX3RkeF9yZWNsYWltX3BhZ2Uoa3ZtX3RkeC0+dGQudGRyX3BhZ2UpKQ0KPiA+IMKgwqAJCXJl
dHVybjsNCj4gPiDCoCANCj4gPiAtCS8qDQo+ID4gLQkgKiBVc2UgYSBTRUFNQ0FMTCB0byBhc2sg
dGhlIFREWCBtb2R1bGUgdG8gZmx1c2ggdGhlIGNhY2hlIGJhc2VkIG9uDQo+ID4gdGhlDQo+ID4g
LQkgKiBLZXlJRC4gVERYIG1vZHVsZSBtYXkgYWNjZXNzIFREUiB3aGlsZSBvcGVyYXRpbmcgb24g
VEQNCj4gPiAoRXNwZWNpYWxseQ0KPiA+IC0JICogd2hlbiBpdCBpcyByZWNsYWltaW5nIFREQ1Mp
Lg0KPiA+IC0JICovDQo+ID4gLQllcnIgPSB0ZGhfcGh5bWVtX3BhZ2Vfd2JpbnZkX3Rkcigma3Zt
X3RkeC0+dGQpOw0KPiA+IC0JaWYgKFREWF9CVUdfT04oZXJyLCBUREhfUEhZTUVNX1BBR0VfV0JJ
TlZELCBrdm0pKQ0KPiA+IC0JCXJldHVybjsNCj4gPiAtDQo+ID4gwqDCoAl0ZHhfcXVpcmtfcmVz
ZXRfcGFkZHIocGFnZV90b19waHlzKGt2bV90ZHgtPnRkLnRkcl9wYWdlKSwNCj4gPiBQQUdFX1NJ
WkUpOw0KPiA+IMKgIA0KPiA+IMKgwqAJX19mcmVlX3BhZ2Uoa3ZtX3RkeC0+dGQudGRyX3BhZ2Up
Ow0KPiANCj4gQWZ0ZXIgcmVtb3ZpbmcgdGhlIHdiaW52ZCwgd2UgZG9uJ3QgbmVlZCBvcGVuIGNv
ZGUgdG8gcmVjbGFpbSB0ZHINCj4gYW55bW9yZSwgaXMgaXQ/IHRkeF9yZWNsYWltX2NvbnRyb2xf
cGFnZShrdm1fdGR4LT50ZC50ZHJfcGFnZSk/DQo+IA0KPiBUaGlzIG1heSBub3QgYmUgcmVsZXZh
bnQgdG8gdGhlIHRvcGljLCBub3Qgc3VyZSBpZiB3ZSBhcmUgZ29vZCB0byBjbGVhbg0KPiB1cCBp
dCBpbiB0aGlzIHNlcmllcy4NCg0KR29vZCBwb2ludC4gSG1tLCBJIHRoaW5rIGl0IGlzIG9rIHRv
IGhhdmUgZm9yIHRoaXMgcGF0Y2guIExldCBtZSB0cnkuDQoNCj4gDQo+IA0KPiBBbm90aGVyIHRo
aW5nLiBUaGVyZSBhcmUgYWxzbyAyIHdiaW52ZF9vbl9hbGxfY3B1cygpIG9uIFBBTVQNCj4gYWRk
aW5nL3JlY2xhaW1pbmcuIFJlbW92ZSB0aGVtPw0KDQpPaGhoLiBCeSB0aGUgY29tbWVudCwgbWF5
YmUgeWVzLiBHb29kIHBvaW50LiBMZXQgbWUgaW52ZXN0aWdhdGUgdGhpcyBvbmUuIEkNCm1pZ2h0
IGxlYXZlIGl0IGZvciBmdXR1cmUgd29yay4NCg0K
