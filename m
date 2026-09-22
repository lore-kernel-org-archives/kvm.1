Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E4F56E05E
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096877; cv=fail; b=T+5yFpJXi1MTc8+GkAmemU7vX036bzV9nm7M5ZgMjYIUiBvKe8V8FBM3tT67QCLPLU7XXcI3wRUYcRjB6kVMPMKHeQLekm+MowkedSMoFnoravS7PkiSoYd1motHy7fOnMuIkA5OzDSBWOH/ecfo8u0YHkZKtbu5CM4p3EdL1gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096877; c=relaxed/simple;
	bh=GVhaz9EQl14DQbachYwSzXX1+uVlawP8J5nW0nt3jRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nAiFdwwUm7pyPZ4VH0Og04qvtZ1msJifGCWH744glyaGHOnRyMcvVDeSVf2pksiMYs8aRxw6C/pdzyrkwaqtdDKrd+YatlywD+is8z7VCgftoXqpqhh1li8BLYSbv3IveqoCaQPh7QUWop7pkufdxytOyQ2PG5gUCK0MF6sYdIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aaOLmqDQ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aaOLmqDQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790096875; x=1821632875;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GVhaz9EQl14DQbachYwSzXX1+uVlawP8J5nW0nt3jRs=;
  b=aaOLmqDQ7HY96UdTImS7+9wMMBlBLzzj2KqRk9S3+s2oFmmRCnH+r0kh
   BlIuo3FFyLkYQKB4oZMwnB0mIMHjzktJ1j/FfaiRIol/ceDX/RpVKe7mg
   jaO7jw7qcVFqHu1rbMVAgBwBe7Yt5z8icDBRqxsDKTWWASGCN2I6GboSx
   Lmpz6mNWlprakXlSaT8yPfXUVUZLcAYrfpfTyoVsqx4uY9cfL9qvPX0gT
   f7UjJ+yFH2i7SddEcAkuWvmn9vxGhfk66gUu/lr/W2l+S9CYbrM7Exelv
   JWPDG9ZHrG4YBKMHj0+5XxsUVRYJI+isehh5ypM7DiY/BFy75P6zYfJ8u
   w==;
X-CSE-ConnectionGUID: NgSgu7S8TryEohdrBv8LFg==
X-CSE-MsgGUID: LeK4HVpYTw+114pQ0vSHuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101311144"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="101311144"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 10:07:53 -0700
X-CSE-ConnectionGUID: xT91cIkFQ1yQmn6EXQvZIQ==
X-CSE-MsgGUID: pI7rQRg0SNyV3BJ0y7iYLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="273413710"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 10:07:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 10:07:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 10:07:52 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 10:07:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Su480rzWUp8eJ0Lpl2z324C8G7Q/fCZiKWCiMd+F+YAZNcbVldhij/NA+ADQ8jAtypwhC3euhrOlU6EDQR2NF0Mr9lB4F6/iX3bmkZKjMAcCDEt+3fdXL/V/RZGIod/iFUBzOQgEN3XgkEhSaDZjFxujijkzpP3xng5IDBl8soJrN+6KQhcQDpf/ymD4xrZvKvN8NFpxcBjRs/q3Lp5suiEJ7w+3pr0cQRY0qubo/AXtIpvlLX0HNZHjxbaws/vlYg2DdhgfXhwoG3xjRUnMFWKr62PrjE3p5HxFRlM4FxStId2/PvoyL3jEjxSxB6wXaBPVHI8X5a90MwFowQexhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVhaz9EQl14DQbachYwSzXX1+uVlawP8J5nW0nt3jRs=;
 b=nQx/kUAO8usEbEsmv+4LSjetJoA6XfPCqPU/jUJvN9egM0r80bVvUdXMjs+D/dB9usbTUZvhqQf3DJ+sAOX9l1MOgY15rG7BtkvmfiVPXJufUP6doElu89pH5XNJ+xazA1J0xMeLx3tE/IggXCoQRnaAdVU5BjMmktbXqg04Fu72JbqAAgt3aBfy1f6LDyqlYbV+Tc01hBJlJktnhukGKOlnuyW6UQ/rmMo+XI0Y467Fgonhx+TZf6chxiTLcSfgIFtOdajCxN2FZ6Ii6S0P6+fdZL8uAEdtuPu3TOUdX2ISpFtDzz5hgtxk6YV8Nw9cDJWXAUS3M3A7CGeesv76LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 17:07:47 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 17:07:46 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "Wu, Binbin" <binbin.wu@intel.com>, "Fang,
 Peter" <peter.fang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: TDG quote analysis
Thread-Topic: TDG quote analysis
Thread-Index: AQHdRXUGnV1D6jtpckytZt9IbBOCMLbRf7KAgAANsICAAAqMAIAAM3uAgAAIGQCAAA/ugIAAEEIAgADUxICAAEy5gIAAHYGAgAAafICAACp6AIAAK0aAgACxHQCAAFN8AIAAN/OAgATQzgCAAAQOgIAABL6AgAAC3ICAAAS0gIAAamdggACz0IA=
Date: Tue, 22 Sep 2026 17:07:46 +0000
Message-ID: <ede520b24753e086dcfe73f11bb93cca7b6e5ad7.camel@intel.com>
References: <aqxGN2Zc8sOl2RKx@google.com>
	 <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
	 <aqyAED5ZK48eEZtq@google.com>
	 <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
	 <aq048KmPN5WPQ4sQ@google.com>
	 <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
	 <aq2t5wJGLtsltMza@google.com>
	 <de659c43-4121-483b-acbd-e1c4f89e4e80@intel.com>
	 <arG7delLjerkKbYQ@google.com>
	 <2df88806-4583-4bf8-b699-43eb6217399b@intel.com>
	 <arHB1SACk4Z9kJq3@google.com>
	 <07297a47-9dc8-4e46-bb5f-fb228ba6447f@intel.com>
	 <DS4PPFA84FA90FC58F88D79B0EF19B34596E7832@DS4PPFA84FA90FC.namprd11.prod.outlook.com>
In-Reply-To: <DS4PPFA84FA90FC58F88D79B0EF19B34596E7832@DS4PPFA84FA90FC.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ2PR11MB7573:EE_
x-ms-office365-filtering-correlation-id: c73d6ee1-dde0-445c-4e4e-08df18cc0634
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|3023799007|6133799003|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: +48Nwfr6mq96zMbZdU4exe91mjJ3y77VATpoqwSIEOxjqbOFiAB/VtNTocOTH2nfGHspMEphGn+WU3YjQ9YCm1SFcSGrAY3N/cNPy1lGrnuGdXTU7W63Kl2kSrXhdxJ7Cb3I1O0uDj1ZuT/650Z8GfoszeW3H1QM7pz7oRCJAJ3OOQa9OiLfqXUqhO+BOl00o6wyFIa1WndsLnLceMQdgZJQohDWP/9XDZlyI6r3ChBxx9xLQILb4xP6bIyrwmszh4uiK+z2CCJCfCdLQBATQSSeTjY2segtuv+8ELZy7BA0m/2GxTuRgX4bgeemNu8vOPG8pfQ4OL1KuBfEIj+AH6i1A7yLEcykj+9gPJPzIUap12e11pf9Dp7RPRgGHMsHCDHJ+o1mHt3AeseOMMHsGuQG+0m8uzzkgHoyRmMdfhg1q/KrhGBev0aqpkfMVvDmScbJfj+iVMT9sypsLkB3v2nmvDWTlR5c/DOVSRqHO9s1nPIOVRKC6nsNvzPx4K/B0oygp3Zysaf1z+v3VBS5Ksl/X9ycVE9Ck2zg16ChUzV7d46IzVRi0Hqs2tYGQ+gSmREHHrxE4+l8c1fq2/srB50QrlSNnO6oQCqUxPjpygI2kyMwdCvMjxFt/S66sIQGJaihX3PEhhNKrgCAwvVP6gox+6CbuoDk2Aa5CIUTb1FaWfSEi725R4mJGdOjOCKSuym4HMjikPC30JUTXMf7FxgkEOJ4Xl+wvjSKmn4CtdI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Znk0a2F0ZGtHSlJWVEVLUHZkNEJuYVdYKzlwejlPVmN1UVY2Vk5GdFgrWWpw?=
 =?utf-8?B?VTB2QUxMbmczb3FLZ0tvMnFnN1RXZjhtclRpdldYYXVIc2lVbXNrRkNmbkp1?=
 =?utf-8?B?WVNVL2c2WHlVa3NETk43eDR1WXRmQWE5SStjSE5mV3dpK0QyK01lS0pSTHAw?=
 =?utf-8?B?Qk1lTktoNzQyUVNQb1FMNUkwUC9iRFgyRy9RWEo1LzVIN1hkVEN2TnJwYVFU?=
 =?utf-8?B?NThVNEJWZUVDWk14c05PV0c0c0h4MERESDhNVENHeGdLdkp0TTVrY2Q1ZkpZ?=
 =?utf-8?B?NjRJTHE1K2tOek9Ha0tQdGtWRHFjS09ackVySzlMaHZHVE1kejdwSzFXV2lF?=
 =?utf-8?B?QVR0bFR4dFJ4Z2RGT0dMSVVuSVdYdGtEbHlyV1Y3OHloazZFaEdVMWU4MEpj?=
 =?utf-8?B?ZXZqUlBMWVpIQU5UL09LWXNhalIvTzYwakRpOEhvZGM1UlNWREhVQWhZayt0?=
 =?utf-8?B?aEVUbUR0RVlRSkVrRUVJVklCUWhVQkJpNEEraTBLSDh0c0RoVTdUa05hMzh5?=
 =?utf-8?B?RlhvanFBNTdheVQwK2RQdWJhSjFQVjlodGlEaTVPOVYxR0lJL2FZcTF2VTJS?=
 =?utf-8?B?RGxyQkVNV3ZzdlpUTnk1K1hYcVJlQjhZQzlzZFpkL2xWMVJQdUhKK3gxdUQ4?=
 =?utf-8?B?a2pudHQ2ZGl5MGRjbFJvbnZkcGxmNThWWnVPdHRFK2Zock81WFg3WVVLbXZu?=
 =?utf-8?B?N2U0Mko0eU04Zm45RDNDUVFsd0xEUjBsOThiaDBOZVpET0xBSTd6YUNrNjdY?=
 =?utf-8?B?aEgzQ0NIQXhuMDIySjRPM1NBWWVZWWI4cjZwYk1JYzRsYndkZm1RSTdMd09I?=
 =?utf-8?B?bWZGMEp2ZUg4TjFhb3FRdGk3UUJPWmhVYkxWeXBFU3huaDViTlFnQk9VcE9Q?=
 =?utf-8?B?RExHTzZHMnAvMXBucC9PeGtDM2IySmVieFR4eVRTVHNPZ2tTU2JZZXhHaDlx?=
 =?utf-8?B?emJOSnJOaDAra0I4N0wwZG1qMFFSNVFmWFk3eHd5ekVBZEZpMGNkWEF2MTFi?=
 =?utf-8?B?M0h6djBtNm9tMWF3bEdJZXhVTFQ2dmJ3MHhtMkcrRGJqVXM4U1IyL3d0L0RD?=
 =?utf-8?B?U2VubTcxVjlRWDU2b2N0Wk00MVBHS3hpbFY2Rzh4WHpDSkordmhSYzc5ZnM3?=
 =?utf-8?B?NjdBU1ViQm9zSnptTEtjSURraHJBVmwyZFpUNkhZeVlQQUltVHRlVHM5ZWVh?=
 =?utf-8?B?LzdiT2EyWE5WcGd0M1BLUFRKRWxPZTc3QVo3cjNlQlErV3NlcU5UVSs2RUt2?=
 =?utf-8?B?b1VqZkozamhxK3FsZ0JlMWxaL3hiZlNheitUSFBYQWR4a0JNcGw2NCtwTGxW?=
 =?utf-8?B?MkVJSlkwTmY0WjFvWkc2anRBZCtIekZjdm1YUndRNzRheXdqMmp5L3pMVHlF?=
 =?utf-8?B?dlVOYmRpc3NITGVycm1vblY4cEJubTJUVXI2c0U1RnI0b29QTjd3UHRTd2d4?=
 =?utf-8?B?cEJ2QkJaL3NsZG1BbXhzOTVWcWt0YWcyVC9LTkZyTGxvMDE0VlJ0eUQ2MGVD?=
 =?utf-8?B?TFZaMG8yODFkMzNVWkxCT1JwL2x6V21TblRLMWg2ZUV4R2xRYTJKNW0vazJZ?=
 =?utf-8?B?bSt2eWdGS1Y2aHFwTGhIeHlVUE5LekwraGdhSGU1WTJnbVh0eUVCY0Zwd2U5?=
 =?utf-8?B?a2Vic1NtdXlPYmIvdDcyUmZyVVFHc3VkbVJybEVDamo1NWVoUGQ0QVhQczdM?=
 =?utf-8?B?T056SkNHdSsydVg3N2VWZWM1QmFtMVNCU1JmSTJ6UG1nMi8zdTNnUlkzaEVC?=
 =?utf-8?B?ZzNNampuV25jOUNsVzhjZ0FZbHZQNzQ5MW5zLzJjamZsRkh4YXllK2U0dVgv?=
 =?utf-8?B?QTdKd1BRKzhrSW5jTUFneFhONFlLTDg1dVlyb2ZJNlR6MXBnKzMrUmN1d3Zj?=
 =?utf-8?B?K01BM0ROSVJMamNZTHJyeVVtQ1p4NUZidkRNOFJucEdyTlJ1Tm5aUEM3b1Zy?=
 =?utf-8?B?R1crMHE1bEtZQnc1dmQwWURzbDJ6NHNob3FlRjF5TXR1Z01rcjV0N3liZmhE?=
 =?utf-8?B?em9KN0pITzYydWpTS2JsS2hNRUwydGlxUkNmaExRajZld0dHcEFmaEY1V1M1?=
 =?utf-8?B?YUZoZ0NwSXN2WWxicXNKRlp3VDN3bFVPcXVjSEQvaEFZblVaNlllQXVZbzZt?=
 =?utf-8?B?WVVNeGoyVTlDU0NsYWFkQ3J6K2I4dzgzOU1sZGdLMld6ZWhLZmxZRTVReElK?=
 =?utf-8?B?empqKzNmT1NFVGwyb05sVGkvVTBmM0MvUzU2bkloZlhFVWxMcldlNlNGRlpZ?=
 =?utf-8?B?V2JTdkRwbVRDenEwWm9yazFkQ0xabks4QzhWQU04M29pNzE4M3dqNW5pY3pD?=
 =?utf-8?B?UU5ta2FXUzIrVmN0K29DUkdFWHRUMjVndDJvaEtUSW5mTkExT1VaOTJrNGda?=
 =?utf-8?Q?YpbGPUhL2EUKBi6Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <102151F39366BC49A8E1CCDF7A0FE6AC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mkrVcv+352Sgrz0r+6okkx+fdDmo8bcXQ7aJY87V8z505Hdf12AlODAno90hrh6TNb6RtC/OeDJqVFj1olLuiSCEti+XhceNzsXycJzCW5v0/43i1PqIZlT5iOP8tBIgWVgMB2UrSeQRpWXNDMHfu5EUXAmaHBSq6dojwBtc4iwggjJXuuGfhkgFZmKa5oLb7dKsBWqye49LkkLFqVkM0bFv3rf88pur9ishPKt96a1ubndTGhKd+89mOd8mzDLmnMbMOTZVAwfvjW158GEdnNg9UyaXhTU92bVMUs0Qp5ZHfAYqpMNIjoHKr78jZi/4RUfDnc7QoVajUBEzZWRnxQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73d6ee1-dde0-445c-4e4e-08df18cc0634
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 17:07:46.6177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QXMPja/fHgs4zziG3V67maiTpCamhDsHjU05ODTn8AmyqgzfggqWI6m5zFMhafJX3cHEfNGZvH1ek5+g5nUhna4xqhZhqW2rMgutiVwsg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7573
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTIyIGF0IDA2OjQ4ICswMDAwLCBSZXNoZXRvdmEsIEVsZW5hIHdyb3Rl
Og0KPiBIb3BlIHRoaXMgY2xhcmlmaWVzIGhvdyB0byBjYWxjdWxhdGUgbWVtb3J5IGltcGFjdC4g
DQoNClNlYW4gaXMgc3VnZ2VzdGluZyB0byBoYXZlIHNvbWUgc2F2ZSBzdGF0ZSBhcmVhIHBlci1U
RCBzdWNoIHRoYXQgZWFjaCBURCBjYW4gZ2V0DQphIHF1b3RlIHdpdGhvdXQgaW50ZXJmZXJpbmcg
d2l0aCB0aGUgb3RoZXIuIEkgdGhpbmsgdGhpcyBpcyBzYXlpbmcgaW5zaWRlIFREWA0KbW9kdWxl
IHlvdSBuZWVkIGEgInZDUFUiIGFuZCBhICJzZXNzaW9uIiwgYXQgd2hpY2ggcG9pbnQgeW91IGNh
biBleGVjdXRlDQppbmRlcGVuZGVudGx5IGZyb20gdGhlIG90aGVyIHF1b3Rlcy4gVG9nZXRoZXIg
dGhhdCB3b3VsZCB0YWtlOg0KDQoyICsgMiArIDYgPSA4IHBhZ2VzID0gNDBLQj8NCg0KKEJUVyBu
b3QgZm9sbG93aW5nIHRoZSAiKiAyICsgMiIgYml0LCBob3cgZG9lcyB0aGF0IHNxdWFyZSB3aXRo
ICJRdW90aW5nIFNlcnZpY2UNCmlzIGx1Y2tpbHkgdGhlIG9uZSB0aGF0IG5lZWRzIHZlcnkgbGl0
dGxlLCBidXQgaXQgZG9lcyBjb25zdW1lIGEgc2luZ2xlIDRLQg0KcGFnZSI/KQ0KDQpBbmQgdGhl
biB0aGUgcXVvdGluZyBURCBpdHNlbGYgY291bGQgYmUsIEknZCBndWVzcyBhdCBsZWFzdCBpbiB0
aGUgTUIgcmFuZ2U/DQoNClNvIHRoZSB0d28gb3B0aW9uczoNCk9uZSBvcGVyYXRpb24gYXQgYSB0
aW1lIHBlci1zeXN0ZW06IEEgZmV3IE1CcyArIDQwS0IgKyBjb250ZW50aW9uIGhhbmRsaW5nDQpP
bmUgb3BlcmF0aW9uIGF0IGEgdGltZSBwZXItVEQ6IEEgZmV3IE1CcyArIDQwS0IgKiBOVU1fVERz
DQoNCk91dHNpZGUgb2YgdGhlIFMzTSBiYXNlZCBhdHRlc3RhdGlvbiB0eXBlIHNjaGVtZXMsIHRo
ZSBwZXItVEQgc29sdXRpb24gc2VlbXMNCnNpbXBsZXIgdG8gbWUuIE5vIG9uZSBuZWVkcyB0byB0
aGluayBhYm91dCBjb250ZW50aW9uLiAoZXhjZXB0IGZvciBpbnRlci1ndWVzdA0KY29udGVudGlv
bikgQW5kIGl0IGVsaW1pbmF0ZXMgZXZlciBuZWVkaW5nIHRvIGNvbmZpZ3VyZSBjb250ZW50aW9u
IGhhbmRsaW5nDQpwYXJhbWV0ZXJzIGZyb20gdGhlIGhvc3QuDQoNClRoZW4gd2UgbGVhdmUgY29u
dGVudGlvbiBoYW5kbGluZyBmb3IgYW5vdGhlciBkYXk/IEluIGEgd2F5LCB0aGUgc2F2ZSBzdGF0
ZSBwZXItDQpURCBzb2x1dGlvbiBpcyBpbiB0aGUgc3Bpcml0IG9mIHB1bnRpbmcsIGJlY2F1c2Ug
aXQgbWFrZXMgdGhlIHdob2xlIHRoaW5nDQpzaW1wbGVyIHRvZGF5IGFuZCB3aWxsIHJlcXVpcmUg
bW9yZSB3b3JrIGZvciBhbiBTM00gZWFjaC1lYWNoIHF1b3RlIHRoaW5nLg0KDQpCdXQgdGhhdCAi
c2ltcGxlciIgaXMgb25seSBhYm91dCBjb250ZW50aW9uLiBXZSBzdGlsbCBoYXZlIHNvbWUgb3Bl
bnMgb24gd2hhdA0KVERHIGV4dGVuc2lvbiBjYWxscyBuZWVkIHRvIGhhbmRsZS4gRGF2ZSwgc29t
ZXRoaW5nIGVsc2Ugd2Ugd2VyZSBkaXNjdXNzaW5nIHVwDQp0aGUgdGhyZWFkIGlzIHdoZXRoZXIg
YSBUREcgcXVvdGUgY2FsbCBuZWVkcyB0byBoYXZlIHNvbWUNCklOVEVSUlVCVElCTEVfUkVTVU1B
QkxFIGJlaGF2aW9yIGZyb20gdGhlIGd1ZXN0LiBTbyB0aGF0IHRoZSBndWVzdCBjYW4gdGFrZSBh
DQpicmVhayBmcm9tIHRoZSBsb25nIHJ1bm5pbmcgZ3Vlc3QgY2FsbCBpbiBvcmRlciB0byBoYW5k
bGUgKmd1ZXN0KiBpbnRlcnJ1cHRzLiBEbw0Kd2UgaGF2ZSB0aGUgc2FtZSBjb25jZXJuIHRoZXJl
IHRoYXQgd2UgZG8gaW4gdGhlIGhvc3Q/DQoNCg==
