Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00952857F0;
	Wed, 19 Aug 2026 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150153; cv=fail; b=MVLawP3tBKomFFAamDkKIt8YfiPD11jvy7x0xOPxO8Z80JjdX39RzGBV5IQqMPdSuL0h8za+4Tfg0url/QYtFTETCtOsTMGvvHlyW9LgDrYKAEHDnLdQoVjXeGvpyObC4fURvT1cEk8c70FIwDKYYR0osohk9R+IQ04h2CeMbU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150153; c=relaxed/simple;
	bh=fclvH+eguiIOckIujTjYM6ewvMUgSq00GbtESoUgL/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JbI2aXjxGM4N6sbz0JD59OyMYLQmFRopuQBXxpURlXAOA2MWn1/v6jcczUQJnlM3xj6aks44u9BopjMwni/ORyZi1VpJ8rBstoLFmeX3DuSxPa1id0A0yjxNDuco23iWBHO7xqEhByEmUKDrWGBOw//4BaXocoKsoBtHNPDxccs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+ja3kIR; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+ja3kIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787150152; x=1818686152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fclvH+eguiIOckIujTjYM6ewvMUgSq00GbtESoUgL/I=;
  b=f+ja3kIRGsamcp9Q7+lNiN9FeF7DkKYMtKGmB8hjy/0K3A2QkWtxPflu
   rJfWVkvKAMWASHtX7q8RO1ai6VEjShJxSSvoNnlQvKzQ/uuqAlt7+k1Ho
   962j0ADjaNpnX1LrTylzO1flhFSu3ia+2UXh2SiowPRRxbnLenbPpHVFt
   PmXiDoxlzWjRG6Cxo3X1aZeKrX0qClE656k8AQWLQVPn0ETkKUSqRmTGi
   nefDdtagreOQk8m8JvFOSjN8FVdNVmNt5ByLhzeMSiPqJqm6mZ6ZzWNbB
   1qYw31KzXTpnYeRuko6huPlKQtRQx6gRDTaex0SVSKmzJ1xVEeUXfvNYB
   w==;
X-CSE-ConnectionGUID: P6g/xUJITlWRiZ7MMJ5Xhg==
X-CSE-MsgGUID: oxyIRCIuRh2FQQpgihxKPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87586106"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87586106"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 07:35:51 -0700
X-CSE-ConnectionGUID: ZD9acfYQQvWhFzcao4OrXA==
X-CSE-MsgGUID: ejEemj3IRRiyzFmwg5vYFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="289079422"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 07:35:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 07:35:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 07:35:50 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 07:35:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgiu5SopIFn8EF0Pft5CV6KLqTeTdcPBvsGOBv9uv6119aWUJOV8r33Yo755YaTOgwOSS7zfUNCEMHcJKH4UA4qAcmeOOlO//LgQdmFzsfuSDng6JU8Cj4Q9iLeUOdU3ul++WVAIT2DgT0c3JBBvMinGGLLTsaMPIxgp83qT9VuFxJtbq1XzcMhyHyuCCCj4iu5pZf33EdDZs7SF98yUQIC/G1sVZ2rRjX5WXV1GKob8IffZtJWiGxmr/9xH7ZVQiKEldfq2eadSiEJamIQKEgouvmw9HUBwDNWKlhSYfmlcLRbY0ZfS9o5oGXjYj3BVvkjpzUy6AOYG25On2Z/gQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fclvH+eguiIOckIujTjYM6ewvMUgSq00GbtESoUgL/I=;
 b=C/9UMyFGwmLHg8SfzkaxcRjUlBBSxXnV3ZbwMDuLEvxJwO1SeSw1Zl2ydBcyJ3gXDOfMwjPHS4Yv37cOkLQ8wusKSkPiZ5otOA15YuYeJPT1ovS5TixFAZGUj9wbnUdHVdIsmtnN2zihJl+GOFodEZVbhvGvG67m/9Qxqvg/mPmLBS5HWlEIdvX0OUkm6Nqe+mKS0Qo+7atIx3+fXHZHUKDQ7tRGfOQZWZjLVitdnE3+qyiq+yDrk/Y57YugXqWk6tTtmj+969dyeR2T6qlR88tbswP85U2uBPwBR2KfTXddT1W1XNSrBiWhq4vvva1DEu+PtroyGnhQH1G6GNtVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB6980.namprd11.prod.outlook.com (2603:10b6:510:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 14:35:45 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 19 Aug 2026
 14:35:44 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead of
 guessing it from CPUID
Thread-Topic: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead
 of guessing it from CPUID
Thread-Index: AQHdLD6aIiIDquy/9EahH8lhDbokubakkrIAgAAAwICAAOUSgA==
Date: Wed, 19 Aug 2026 14:35:44 +0000
Message-ID: <bd8f77eb6605f771fafbcef55a47211ecbb70e19.camel@intel.com>
References: <20260814224509.2342760-1-seanjc@google.com>
	 <3a622cdb03b553cc9f8ce55b6df3c0091b3b06b9.camel@intel.com>
	 <aoT_6cnARCAYTrYG@google.com>
In-Reply-To: <aoT_6cnARCAYTrYG@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB6980:EE_
x-ms-office365-filtering-correlation-id: 5a62dfae-c9e3-4d5b-a3c3-08defdff272c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: EdQFnCE784HD4aAbTXM9jgU71mPMhh6Nc1mGnfNy4En0TQSpTufBAVQ9gUU3MOwgvN58vSgEu336oo6zDDEVHsj0LZ899h5+ht7pVCevEoM9Cu5TMLlwFuVNdo+v8oh+b5xUqdi8HQyg9KOZhUcSr/Isoon/cAGhFaPNQzJnCp2X6qJ9DrzMgoKXkB1vBD/5Wyy2HYrsvYYghhN7g99GrbjmHbKt5VEOXLAxyj4rC2E9Qd12bS/KcXcF+tkfDMWrcyD3aRQXuQYq3HkOcse1PoIJB44SntKs7QXwZMAVnLUUTavfWlYfCA/GUW5aKNLy+4B53Hj6i3+4NsBL7t9OwC6NpO1BuVlOS96OLceAk5GBRUV7Xa3EixPR7Y/NGiqKp4vmcTwgyREv2CMlT5uzkP7qg/SmL3xqQQj7H4018XEs7G57kZ3My8MsDrl+RG3vKFRjezYr5LCbY5o9s6bKU7cbZobQ4AzTMbTSJJcGe+YOaj2F0sRTDWfFVFZ2JDuvPAA5/4sstlHGmksfhYLbiuDwAxO2Zdnp2ilfEGi0Ag61OU4KZf8IuMuHkP8dPhSpWmV6tgTD3lxdbCkALKBBm7wFhWMZBiycejQpf/WxjdeZnEGazpRNGv0Kx4QwlZ6fOb0zlYii2TujMDRoUnrFsgowA6wvJJbpXoSi2Tp3f9vA4rjCwJWpo1e4kDvE42AyI+OumwAuTl0s02RYRhyzieYKi7hp309l5KfHFoeIB4c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVQ3aDQvWTRtT1I3bDFnK3lwWWFZNUdzWkl5OVNJaTRyUytPVUxTWW1sd2lQ?=
 =?utf-8?B?WXV4eDVGT3BqclFUVjVBcFQwMHhGL0JGRmxXUW44NjlzOVhZS2xNMmZSU05R?=
 =?utf-8?B?eWVvYk1ZTTNVR2RnTUhQR04rYTRCcGRaYUc4WGFJaEl2cE1IWFQyRVpkcDlp?=
 =?utf-8?B?SlNqc0lTcmxXdjVxT0ZvcGxkdWNLajBiV1FEUGVqSmFwTVVOc0RkL2M1aFFH?=
 =?utf-8?B?ZkNBN2VxMXkzTHhteGFkTnFYeW5PNXZjMWxYRU1DZzNqVERocC9sbVNuTWZQ?=
 =?utf-8?B?Tng2bGlCZjhVVlpqVFRzNGFmenNEeXQwN1hobkQvdmFYeWJ0K3BWUXJhUEdr?=
 =?utf-8?B?WnlwL1R6ak5zbmkwWHdnbTkvdS8yMlpERklIWVBOV2RDdjUzM1AzYndnTGpH?=
 =?utf-8?B?aXphd0F6aXdRd0w3WkxCTTNoSFUwWldRT29FUWFCQmJWSXJhcWIxQUZaQXF6?=
 =?utf-8?B?dnkvUWVTNXlOSlV5bm1kbitMV2VkcUN5blJPdjVMN2pPOFVhL1dpMmJZdlBC?=
 =?utf-8?B?NVhVcUw2SmJyRDZrRU5JTlBCZlFRYUtxRWtBTkpnS1dNZWJRWWtLbVJVaW14?=
 =?utf-8?B?Z2FXV2NRSjBZUGVRU1VMdVhiUWNjdlBrU2toQ21UMi9XZm54dGFreDdFa202?=
 =?utf-8?B?SlVVemtVWmxadlBDcEw0ckVsaUV2S2N3MlU3dWRsWEFtOC9DRkNxV0FrUGxy?=
 =?utf-8?B?Tm9VR095aCtOUUlRZXBlQnA3UFhjeVpXdzd0ZDZUVEp1QjgrWHEyR1ZIYmx0?=
 =?utf-8?B?Y3gySU9OWU90QjZaN0UydkU1MVpxTUpuV0pxeWZXSXBRY0dpVjlETWMxV3BW?=
 =?utf-8?B?SjVqY0xDY28wQWE1dEZkWXBsSHljZ0Q2eVNPSUphQUhFUk9iM1ZlMHNkOHFY?=
 =?utf-8?B?RytuWXgrVzVadWYyOERKeDJVRFdFNjVWb3lXRFdpR0JRdXpxQzRXek1iU0ds?=
 =?utf-8?B?ZWRxLyt0bHV0V28rMlViMmFrUWlIRVBWZkRmNHh2OUxaZmd5ZXNTaEpnNUJv?=
 =?utf-8?B?NUttREh3SlNMZEpPTXZta2pXOXA2R3V2TTBuNm14NmRHUVdicGd0UmliMzVZ?=
 =?utf-8?B?M1FFbDNMV3krbHYxdVQvMG9oUWFuSk95UlREUkVoZFB5cGJicVViKzUzQ0tW?=
 =?utf-8?B?LzI1bk1kZTJIdFFNb2ZGSmhHR2xxNjdWZmxQMmg4VXlweTNZQnRUUWEvcUpi?=
 =?utf-8?B?TG1ZbmRXdytNVG1yTTBmdktYQTFMMGFzbDFVcWRscjhKZ3ZIN2c1eTM0ZVZj?=
 =?utf-8?B?VUpzRURGWEJnQm5BNEJmanBLaS9pNU9mTFBMMUtRR09mK3JjaVh5QjBGSVIw?=
 =?utf-8?B?VTBsOWhEV1JldFBDK3Q0eWNZb2hUNytyUFRNRFdVSlA0WEtGUDIyYk1tbTNm?=
 =?utf-8?B?NDNLTXBHbjFDUmU4TEo1N09IMUR6anVvMk5jcHRXcEQvbDFIdjNKZ1BIZkxZ?=
 =?utf-8?B?RkZoNENULzlmVythZWx3SzRDb2J3N0lRb0dEcHRPMDVBY2NNcTRFUVpFVkxM?=
 =?utf-8?B?Mnd4cXE1UVFvWUFzSU5HekVacU5Cd0ZWZ1M1MW9JNkFpN000T29SK24vdWtS?=
 =?utf-8?B?RVpOT3B6SjBuZ1BCRW1hQTFzam82eW9zNDZRN2pWYitrMGtFNWhxTjJZUjRu?=
 =?utf-8?B?ODhkcDJEYlpEaERNSWYybkRocDgxcFFzM0xUQ0dzbXJHWFhSWWFNR0VlZzI3?=
 =?utf-8?B?NUtZNk9QZ3pZWE02eUdEK1FjK0xJbk4xUk1ySkdzMGlRNDc3WXd1SnB4RnNT?=
 =?utf-8?B?M3N1dDB6ZVhxaXpkTjBtWFdCbHIvOXpPeTM3VkY0ZklrVHhhb0NtcEhkOEZY?=
 =?utf-8?B?aFdtOXE1MHlBazkzZHFvTGcreUF6K25PN3V4T1FOeDAwdWdNbHVPOWJCVlZs?=
 =?utf-8?B?V2Y5M1pkL2w3K0NZNXhnb0F0WXRpdjErbDF4cWFWUTNocDFSamk1VzgwaVVI?=
 =?utf-8?B?WThRYnZkNThmUEVhRUkxUzY1RVBMdVVDUVN5MjJvdysvN0xyamFEREFITkdC?=
 =?utf-8?B?YW02d1VhajdKa2ZrZW0xN1lKUzZPMmIwbk5lUExhME1EVERNVFhaNTg1Rmlr?=
 =?utf-8?B?Q1JSUHdQN3hhVTBqOThOZlNyaC9UREw4aGdJNExjMjJSVGMvR3R2OHFwalUx?=
 =?utf-8?B?aVZkWWNxR1RUam5mYnVHU1JxWkdCaklrWG8yQjkzZUFGdDk0NDJGeDU0Mi9Y?=
 =?utf-8?B?RHJsM3h5L2JTcTN3eWxkMWpqOG91c2RHaWp1OWFVTjYrS3cyOWNnT3JzOFh5?=
 =?utf-8?B?VUNQbUpFM3hhSEcvVVlQWmVQSWp4d3BVOUtPZzdpdFZrUzJZVUVKVVFyUHk4?=
 =?utf-8?B?NGR5b2hQL2pkQjZVeEtydlVpTGxhMlZuMGNEcjJBVE5tUHlIQ3M5MGx4SmFK?=
 =?utf-8?Q?HQ3m7vnx8Vb+NHtc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBAE8D14061B034B890C64AE0BB7BFD7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pDINpTp/2p7VYNPFkc2OgjeLXYj0sM38ZpJwEMOOeyzCJJJ8BFIj0OrAHknd5EXgX9sNrLQsW4svHVg+xm9RP0unsFKLt/dkot0tNt4FRaP/HEUP/7lUktu6c1MZZl+VUwhqE5DJQM4Njs68O/Gb/4GRjaMZ6xyoumMmuHfL9zijT0Elhyd2iuCNTR+mdcxp6J8doVX6AnV0ScTLTmPg8Xh7BVK6VPNxaZTNmxyt1JcRux18P3ZSMKAAX0voiLVe4mKxXTJ2nEnNIUhhHwzkVIvf++15+IQe0alb0VJnF0DC8rksAbJYYJrsCkADZ0aTuQ/IJoHe/EaCDX5ylqzl/g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a62dfae-c9e3-4d5b-a3c3-08defdff272c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 14:35:44.8345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f0E3sCk+bXZkbd/aFS6sqou0fytGfwzwepRDdF9acRDegYX3sI/7ItJm7hiH53mmFnnryQeMFFU9ZY+M9Td8igs/wif3pfzEP4hTiQSKvko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6980
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTE4IGF0IDE3OjU5IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IFdhaXQsIG5vLCB0aGlzIGtub3dsZWRnZSBlbWJlZHMgaW4ga3ZtX21tdV9zZXRf
bWlycm9yX3Jvb3RfbGV2ZWwoKSBhbnl3YXkuDQo+ID4gU28gSSdkIHRoaW5rIHRvIGp1c3QgaGF2
ZSB0aGUgYmVsb3cuIA0KPiANCj4gSSBzdGFydGVkIHdpdGggdGhhdCwgYnV0IEkgZGlkbid0IGxp
a2UgYmxlZWRpbmcgdGhhdCBsZXZlbCBvZiBkZXRhaWwgaW50byB0aGUNCj4gTU1VLsKgIE9yIHJh
dGhlciwgSSBkaWRuJ3QgbGlrZSBiYWtpbmcgaW4gdGhlIGFzc3VtcHRpb24gdGhhdCB0aGVyZSBp
cyBleGFjdGx5DQo+IG9uZSAiZGlyZWN0IGJpdHMiLCB0aGF0IHRoZSBvbmUgYml0IGlzIGEgcGl2
b3QgYmV0d2VlbiBub3JtYWwgYW5kIG1pcnJvciByb290LA0KPiBhbmQgdGhhdCB0aGUgcGl2b3Qg
Yml0IGlzIHRoZSBtb3N0IHNpZ25pZmljYW50IGJpdCBvZiB0aGUgZWZmZWN0aXZlIEdQQSBzcGFj
ZS4NCj4gDQo+IE9uIHRoZSBvdGhlciBoYW5kLCB0aGUgTU1VIGFscmVhZHkga25vd3MgYWJvdXQg
bWlycm9yIHJvb3RzLCBhbmQgbmVlZHMgdG8ga25vdw0KPiB0aGF0IG1pcnJvciByb290cyBjYW4g
aGF2ZSBwcmVkZXRlcm1pbmVkIGxldmVscywgc28gZXhwbGljaXRseSBzdG9yaW5nIHRoYXQNCj4g
bGV2ZWwgZG9lc24ndCBhZGQgbmV3IGFzc3VtcHRpb25zLg0KDQpZZWEuDQoNCkFuZCB3aXRoIHRo
ZSBsb2cgYXMgaXMsIHRoZSBleGFjdCByZWFzb25pbmcgdG8gYWRkIGEgbWlycm9yX3Jvb3RfbGV2
ZWwgaXMgbm90DQpjbGVhci4gVG8gbWUgYXQgbGVhc3QuIFNvIGlmIHdlIHdhbnQgdG8ga2VlcCBp
dCwgc29tZSBleHRyYSBqdXN0aWZpY2F0aW9uIHdvdWxkDQpoZWxwLiBCdXQgZm9yIGEgYnVnIGZp
eCwgSSdkIHRoaW5rIHRvIGtlZXAgaXQgc2ltcGxlIGFuZCB0aGVuIGRvDQptaXJyb3Jfcm9vdF9s
ZXZlbCBhcyBhIHNlcGFyYXRlIGNoYW5nZS4NCg0KPiANCj4gPiBJZiBjb21wYXJpbmcgZ2ZuX2Rp
cmVjdF9iaXRzIHRvIGdmbl9kaXJlY3RfYml0cyBkb2Vzbid0IG1ha2Ugc2Vuc2UsIHRoZW4NCj4g
PiBsZXQncyBqdXN0IGRyb3AgdGhlIEtWTV9CVUdfT04oKS4NCj4gDQo+IFdoeT/CoCBEZWZlbnNl
IGluIGRlcHRoIGlzIG9mdGVuIHVzZWZ1bC4NCg0KSXQncyBmYWlyLiBBbmQgZXNwZWNpYWxseSBU
RFggY29kZSBpcyB0dWNrZWQgYXdheSBlbm91Z2ggYXdheSB0aGF0IGxlYW5pbmcNCnRvd2FyZHMg
bW9yZSBjaGVja3MgaXMgcHJvYmFibHkgZ29vZC4NCg==
