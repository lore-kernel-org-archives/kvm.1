Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792718725;
	b=kOSg3k0CpQiOgq+Y0pS3rEin+cx7XOUsSzCZxbac5Nxwv5C+9PA1+gbLc1kqR3D3G6RT
	 aBu4Bc1G+PJjUmEnHYmLRN7vXQsw53tCCt5j8W4gMupTEjlzb8TXMF/20vNTn+EcWf/+X
	 blM5ESUdta2Alragq282CH1neK4lv1d/VqvcAdVCXZewRBapqlUSbSfXGcNfYRFJgZCxb
	 R0OGQmOsWvbbA1KpCjNkfs6TCNnZlkhaiLDzxnspAlWNd7N2sq8WLxeW3ktXs8lQKuW81
	 tpk7DhXKBRSCmYMTZ2gkFUvZTtN1UxzZAvvUdZtAplsLANPtaqm6rkfNa4SeGDqqTUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792718725;
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
	bh=wS/Pa4QuV3WGy2u//KsecjSVLH0PW3HlvfHVAlC+WWM=;
	b=qsKJUlJVboIKnA36veS1r3/qLJyXAtVbZSV7OPYwyWxVi50tOubRlW38v6Xn+0F5PXIP
	 H/RtVFCGfdU+f2Tq9+EyfG3jtoGGZiIXEVS1cxPSmpOpUACeOvFjv5knUewWT2qoYX7pn
	 vhuBnizuvOlE2RSaAB67mi7+NGrICWamWC+zqF0KBlQN6ISFQF4on4PvB3bbSbjjHCbpL
	 3vv5pVog0EGknYyU0lpjewTc73eX67a3fqpLev02Knc7JbJvKLkmhO6WKUiMMdqOKMUn4
	 ud0ux7OI/tsNab32elkYeYMKlmDQOYpGXnsKNGiQKqw3tP9JXqnpQ6MEHkuSfCS4fGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OV0Cs3ew;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C12606A31B;
	Fri, 23 Oct 2026 01:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34C12606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OV0Cs3ew
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792718725; x=1824254725;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wS/Pa4QuV3WGy2u//KsecjSVLH0PW3HlvfHVAlC+WWM=;
  b=OV0Cs3ewvJsPaWw/cwueG313ExON7QhXVLRBxXAxcy3G3Zqmdck31b5b
   SI/AKXbFr57uxILHAO/VM/3vYYFBFDyohlAgqmhDb0wHfu31Vdg5ZYKVx
   l95r97haFrOLwjrDDd3JUDVDuHq2x8iv39WolF8+8iFiFJnUEAzIiWlGw
   0TKe9uowRNxzjA4wPyklkLPFcWd+EV/EZWBgDsIqTJ0mC2KsC7kKg9yJy
   Jrg+c2p0LBWokv4UcAfXK8BQGbN4W7q7Z4pt45PogZjWZjqdTGVrcRidC
   vQ39XMsxAUo9Nh5qUsykbY3o/0jfhngOhkSNMql3d0rytoh2yOdtqhvIS
   w==;
X-CSE-ConnectionGUID: J00DJIByQnS/BtBAUX07yw==
X-CSE-MsgGUID: dfz5h/FnR2C0ITLwKF7FpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1365623"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1365623"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 18:25:24 -0700
X-CSE-ConnectionGUID: N35rFGKKQUidUi1PNi3ecQ==
X-CSE-MsgGUID: qZXEZbgpQ6ytiUiL3ZlWog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3505162"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 18:25:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 18:25:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 18:25:22 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.41)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 18:25:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aq+Cli3S2VoENu/Db1cCw7VJKAJtsxyNLYCL+FceYoNrEGNdHrmQh+9AfZc4sV2CgNaz62TDAJT8mWVmWMLqIAxxM2rVBBM4y80nYH9iF6SFPFRUJtoG71oxKV6Ur5eaT8iSkTxrUFYG7lRh4Jp1NiQKwQyTH7gQDdm3lSMr9lMlgl2Wrq8vgu1ZyKsdVkn0kySZH+KzBBnJDtA2Bqv9uCVadsEBua01uGx0wiXiLJZP6uFq5Vdr/sGBsFubv6IXZbX5uT9LfX/ep4+PL1bSgxlbEC0Mamd1sgLWzvF4p2rekcbgT97lI7SEq0rrrE6fk4jayrLIkHFlOcfzebrTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS/Pa4QuV3WGy2u//KsecjSVLH0PW3HlvfHVAlC+WWM=;
 b=myhGWf4nJPwiPMw85JReKbtCzyNGC9MildeKPI9c16oSAOpEqks4rP9C/4aFviOkJeerQD9qwDKqJDyol5QDZrv0veTbAxGCLhch2NTGz6ZdpVzIyNlmDX9EelRlZzDWOPKydsx1vEKViP64UhoDy2FINBWvDCuLHVqZVVMMXRYaKhxbe3qfuzqPHI0UCzGlrK2+OxA8N1FiC+8u0MpRsRCBp+tM4an/2ll8gIO3+UzkIdF87Uc01tAWhC/+ghcBWQrw0TqnQKFvECIYV8X1GMwv3s3Qr3PY+yUOpHn2d9ISxzdhU33K0cW9Ze0IV9j/zR5vYsp7PTI7B4N8oXK8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by LV3PR11MB8741.namprd11.prod.outlook.com
 (2603:10b6:408:21d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 01:25:20 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 01:25:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "x86@kernel.org"
	<x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "tglx@kernel.org"
	<tglx@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "sashiko-bot@kernel.org"
	<sashiko-bot@kernel.org>, "changyuanl@google.com" <changyuanl@google.com>
Subject: Re: [PATCH v2 0/3] x86/cpuid: KVM: TDX CPUID fixes
Thread-Topic: [PATCH v2 0/3] x86/cpuid: KVM: TDX CPUID fixes
Thread-Index: AQHdYmiRF0WilxtwJEaPaKwHY3ykwLcKVemA
Date: Fri, 23 Oct 2026 01:25:19 +0000
Message-ID: <16fe7eac87e2b29fbf353b05916c4a92033f8079.camel@intel.com>
References: <20261022210134.612848-1-seanjc@google.com>
In-Reply-To: <20261022210134.612848-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|LV3PR11MB8741:EE_
x-ms-office365-filtering-correlation-id: d2c65fcc-99bc-4bcb-956b-08df30a48079
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|38070700021|11063799006|10067099003|18002099003|22082099003|261021121427099003|6133799003;
x-microsoft-antispam-message-info: Ekr0HWrJQETBvzAhEG1h75xTyu29fsWp+V+7V65J+iYkzv4UfH5svYPq9w812Z/1XmfIzkR4SxuuHQYnjrmXT6Gs7306LaEfBvXvA+lad+NOYV0ys0zVNd+j8K1Y5FCdNIkcnNe3S4KWELMEdwVcXxf89XNjUetA7Iyx1Pp9F1COdHvvAEvaX+6B/dBTM0BfgM3BJKcRvWdJftEyRIBvCzQGdeo4/CnUlW5Ozt7E2ScRAtiqKQ7+lss3Oppdg4l5Aum4i/Up3sOfjzFxqyyNWyGkXmRRiwKtF8Eoa0Kg+QDf5QCZ8myu+/fj8M6I4ITOPEE0tTi/kHeCmQSSKNRv7NhOvCUFHV+8IVDm1kaKImBFDkgt3cNREbuZ4gStNN4SJVISgUtgxZGlg6EsISvHS+nxrcRAZhaIbohHO/3q/mn6T2FqKZfLIB9Ch0LRV+vKGBRrVZ4vMzu4ztc9nzeSYEXUUz9eihkYrJSsSV+7dDVKkjOwpDv2YKw0bueFKYtTKa8hmhOgjFLovR9m5uWrRI3UvDLIcS7n1pMJ09GO7c3eKs8E9I+Fj4KXvDv0Irbmngs7KmyMHVD3zl0SMNsdkuZWod4pj7Yjj62yY5vqypgrMBo3wEQsGm4RGYlOglP6vCXXQxDxTRPE19Iau+wOpZSFNDUNy3re4qxO+pq65TSqI0PUev5SYqMBiutGOfltAKtHRLPTWRLscOVnI/mEtJQJM1uE1EfSe+mMkKFdSgk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(38070700021)(11063799006)(10067099003)(18002099003)(22082099003)(261021121427099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnQrbmlEU1gxS3FpU3hMRXFMd2FzanIvSzNNNCtVWVpPOHBVUlV0K2RyMWlH?=
 =?utf-8?B?QXo2Qi9iZHFkczcyUzd0OGRhKzJKYmQrWjhnaGlPQ2d6YTk2b2hLZUdTUnBl?=
 =?utf-8?B?NHA5MU5BSWtTa2prMkVBdE1xdWJaMXJ1NVNPLzJsNVM4cEVldWhNRXJjNmdt?=
 =?utf-8?B?MWJwdHNqd1VNa1didzl5cmkrQ0EzMnpxYlEyWTg1b0hybU9SZ0hSZlRsQkhM?=
 =?utf-8?B?QU5mQ2RGdUlndXdISGJpb2k1a3ZoSFpCdHMzTUo4aHJtalZPS2pYZU8zeEdW?=
 =?utf-8?B?TXVjSWVHMGRtV0Jub2x6dGU5bnFXU2xVcFQxS1R3UnVZTGdBbERQdmN5WitD?=
 =?utf-8?B?KzV6N0c3Y0hmaGNZNjZpUWwzOVAvZ3BuYklvUDhtc0sxNHlldCtJMnpDNDdx?=
 =?utf-8?B?aTVFWFY1V3pNamdWdlBHRm1oTWJXMzhDZE4waFpOWHpvMzliWThIN1ZxNXdV?=
 =?utf-8?B?cVI4MjBZaTFnRHFCU0dBa1NzRWpSd0JmaW5weHVGVzZQK3VES3o3Ti9oTnNQ?=
 =?utf-8?B?aTUxK3NZbjZ1MElmN1dUc3FqTXl6WFNUUUlIWnBscnJ6TktMcWJkQ25Yc1k3?=
 =?utf-8?B?aUtHU1paeU1jN254SXhSVUNpbDROQ0FRM3hjSU4yQncyTXZJTzNsQ2dhU0pq?=
 =?utf-8?B?RDdZWGE5TzJpZVkwcDJ1akFJWFp3MGlSM1YzaitEVlI2cm1LOE5DbEthRmk5?=
 =?utf-8?B?dU1EQVRXK2JmTGMxZ3BQNnF2bEtITUp1QW9sdmxZeHRCeHhtNU1RbEJBeWFj?=
 =?utf-8?B?N3ZrK3d5NTJEQjhwK1kvOWYweTQ0YWNxdDNOaVo1WFdmZWs2eHY2VG1MUU9B?=
 =?utf-8?B?dlRBUm1OUFU1RnZFVUY4OTI1a3BQMDNiaERkNXU5MTJZelZ0KzE3RU9idnJU?=
 =?utf-8?B?TzdySHhpYjBZV1p0dElvSmVqcmY0YlpKWklHL1g5T1A3VzNmNXFUQk1UN1Bu?=
 =?utf-8?B?S01qWm5lQnVxOWhIVnZPQzRoRVNFL2Nsb2Rkd0pwYnFHRHR3WGt5TFZjZmZF?=
 =?utf-8?B?ZTRYbDZ1STBSQWJ6a3NJL1ZPVitHdTZnaGdFL0lhRFRYN05lMWE1SHBOWmRJ?=
 =?utf-8?B?b3lGUGJtR3E5dHVBdkh5enRLQkFMWStxMGZxWEVybVJQWG0vcDRmT3FXZDBu?=
 =?utf-8?B?OHlmZUtNMnVoTWhyL2lEL2ZyN2dVb0h1TG95SitXT20yK053YmhoWFRUbmh4?=
 =?utf-8?B?dU5kbHVqdEk5Y3cvbVJPKzhNR3hpaUp0bkp2cVFDaEMrR2dNS2NCcExFZTBj?=
 =?utf-8?B?bXpETzQyZExkejZBYUYzbU5UWmptQW03bm1OK05WeVdYOE1VSnFmdUZHRUdm?=
 =?utf-8?B?UG1tSWJCYmNrZ0d1aFp6N00wZkZwVWhEREF4bExMRW1STWZ2MDkvU2l4dkhS?=
 =?utf-8?B?QU1pcXFPSkFvakpRMGJiMmpOem9DZ1V4KzJCb3pZVVplbTVnd1VUQU00SmEx?=
 =?utf-8?B?YmVsclZKamp0TDlLNG9TdlNYQU5UVFhZRUtGQTBrb2srYm9hd1BRTmhuZTd1?=
 =?utf-8?B?ajd1bWZwMXRHdERTOHVIRmdzZUpwMDhwMVRoclBiNVFiNW0zdW8vdlppV2dI?=
 =?utf-8?B?V3JnRFo1TXpxSmFtNzdIcHJWTE5xU0NkSkRWMW00OTRjSnEvc3VBemZFNXJk?=
 =?utf-8?B?bWlGM3NmNktPaDdKTjE2UGZPdXBqOHlOaCtzdFE5UkptbDBPaS96K2pFMGJI?=
 =?utf-8?B?TTRGeDArM2VIbHl6ZGc3NU1Lbk12TUNwU2dmOHViTkNhWkNvRk1yWkIwemRU?=
 =?utf-8?B?OW90NitDQ3dQZCs5MUc0S3Jud0ZpZlBBQ1FTRnF0NjFCaGJRQ0tidm1GZENP?=
 =?utf-8?B?czBIQk5uaFlZTFRqMmdCVjlJaVZDa3dDTm5vSFd0S1FURmhzUVFZNWFaSlQ3?=
 =?utf-8?B?aHk2QUFSVG9jVmEzOWlsejNSaTBsczdjTXpNb25iOG5UNVZTbS85TUVrSFYr?=
 =?utf-8?B?SENJRC9PWUtmandaTTE2ZHZFVDc5Q3NVOFlLNVBEUHliektXOU1WeThRTndY?=
 =?utf-8?B?dmtFUHorMXZ2cE1ISEhiR2Y5ZXN3L2IySFB3M01vWW5XMzl4bXZqdWtDZG9q?=
 =?utf-8?B?K2QxWHNEbE9XcXh0ZHBEVHE0azFYbzkrUXIyd2I1UEYwUVhlc2cxbHlyUjcz?=
 =?utf-8?B?OWNZT3N6VFB2MDlyMDZORm9RcHpKMFd5TGt1UmpqYVdobXZQdXdjQUJ4VjI4?=
 =?utf-8?B?MTd2dno3MUxUQ01hMDVKY1U3ZTh0eStuNFlUa1VYL0wvdWtHeG8zclRMYTVu?=
 =?utf-8?B?dWc2WCttMzFkZzJFbVBPNDBJN0V2KzBNaDdNWU13MkxYdzdSV1l0dVNNRXg0?=
 =?utf-8?B?Ylp5NlRHcmc1ZkhUeVdGMjQ4c1FYaGhkYjltNUNvdjBKNU1oY0pCNTRHYnhk?=
 =?utf-8?Q?RipCJQEn/OcvOQj8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84799AB1D943E14D8ACA36E80723F4FB@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: 1+pD+tNg8qBgtXR5ZivraFdKw8o7kGstXQk1tbFdh76XYjllt05CwivC5VwmoLUT9jatbw/m2D5SdeUeUAit2p7us5jgrZ8FQm6jhewmWmKtLESATQIv0dYQsaNKgQHOAdahiS20qWP3PcGPfxrgzzXX1BaQzbIWL3XnEgtJmHavQsFRn6lImQTApeSdHt7BNbjVdAtfQq/CIaq40SMYmChrMLfsARCllGs8HiYpzzz7LCLOgJ87KLogTQVW7qcnJ78sCWt2ljFbapRufbYsdAk6MovsNL+iD/WRgAuugL6DTrHT5bdSr4SYMcdG87Lm5on+c+BXbjoebfFIkJxugA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c65fcc-99bc-4bcb-956b-08df30a48079
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 01:25:19.7507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /e1HYLAJquE+Tgu9ovfjl+zOcT7auh4ez3re/hAeai7U94qi3kbUd5OskRgIf7L+P0CZpYvnB4GVlEHNSdFbsmjRDoZWUZRjEsZloGr0QbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8741
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDE0OjAxIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBDaGFuZ3l1YW4gTHl1ICgxKToNCj4gwqAgS1ZNOiBURFg6IFNldCBTSUdOSUZDQU5U
X0lOREVYIGZsYWcgYXMgYXBwcm9wcmlhdGUgd2hlbiBmaWxsaW5nIENQVUlEDQo+IMKgwqDCoCBl
bnRyaWVzDQo+IA0KPiBTZWFuIENocmlzdG9waGVyc29uICgyKToNCj4gwqAgeDg2L2NwdWlkOiBN
YXJrIENQVUlEIGZ1bmN0aW9uIDB4MjMgYXMgYmVpbmcgaW5kZXhlZA0KPiDCoCBLVk06IFREWDog
UmVqZWN0IEtWTV9URFhfSU5JVF9WTSBpZiBpbmRleGVkIENQVUlEIGZ1bmN0aW9ucyBkb24ndA0K
PiDCoMKgwqAgbWF0Y2gNCg0KUmFuIGl0IHRocm91Z2ggb3VyIGF1dG9tYXRlZCB0ZXN0czoNCg0K
VGVzdGVkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo=
