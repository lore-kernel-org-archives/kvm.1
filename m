Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC16E47CC67;
	Thu, 30 Apr 2026 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574297; cv=fail; b=q6NkIap/dZiH0hSHUg5zfgvfgXRHV6pXH+5CckZP3i9xiEt7OSQ01kJtLB6Fg3NJiUF/iKY7QDAc4vkvsAoTi6ieY8heckJavR/B5ftdpRPfVT5xgsjyvsJOJM4hmN6ktV5HJzmkV/PlzR/qjyxINO1unND97+XjasaV5Vtdih4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574297; c=relaxed/simple;
	bh=7sUU4szCElohs9PEiRE2hRn61F2A3Qr6lu7KnuIhGws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LPsyMauYSlfhIhpba1L90a9ImDpWhsBTqmHH+fxJS5yschntqDIN2MUWQ0wngeucyQO2mfEsVp8vVa5+9NhHSna0SMuBI7CwGRBFx+KDU5QzjjbiI83rWTvpWxAuZ/VwwLiqYel4snj5/c0ZAaldkwXObciSCG8Sh592xwCezqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dx8hSbbW; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dx8hSbbW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777574296; x=1809110296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7sUU4szCElohs9PEiRE2hRn61F2A3Qr6lu7KnuIhGws=;
  b=Dx8hSbbWU7cbfeikC6tkqYTLJHzJzw1N/CVjlrphVpkO68IvMWW9Oq7/
   u/b+HaLeJGgRQSxD25JSZ2uWAe5AaU+kT7G4t5R+ypM51RhYCXkWur/Mv
   YVvlingYsEGKP9Lh3veVgBUcr/JRkvqU0xq9/9h//QfUO1SNF/tHq0rJQ
   k0ZQUnX3tbQDPwI2iWPIja434UWRdB6TIVC4bA05FBGySDssxRVvsBtaE
   hREj8LfZARjqxfwzmj/LEbcLh9fvIea1iyUpyHueaoqsXCg5z/f1CqQ2z
   hCHqd4hf9Uea7wZulIhmiUN4Vc03XKydi//h7wstoIr6P2bSCj98E+4Hd
   w==;
X-CSE-ConnectionGUID: 23TaiiwFSpaeJSEkaXLwBA==
X-CSE-MsgGUID: 8vQhGlqdT62Ih1kPk2wTbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="101205320"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="101205320"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 11:38:15 -0700
X-CSE-ConnectionGUID: Aepx5iQISjOW1qzQmqkAjQ==
X-CSE-MsgGUID: XFmMXbFvT4qgyG6nwd/Tiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="265042620"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 11:38:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 11:38:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 11:38:14 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 11:38:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJ0QEF7EDdU4z14bQbDTSmq9Dq6OBCKLBqEg/CUpNTYkbK9F/BlHA43AZZ4s0gIxp0yj+2g1gZK/a8jlmx9E3hmXJJaRn28SDLmwolRplJyXyUlLUfmH0q6H6P1ElyaJ7mtb6yG0QR7eipBkkUN8mxqGdLdedSy0DglW1z0nsbRMDncMbdFJr9JLWaAQPt9j3AzNG0xbjlxYFrvlbfjan71bcMtkRSqjL3TL4BYeggy0zwtG2MNJ/g2L/KJk1aXgTvmOwC0r9KM9zTa8i81EaW47XkQVx5aXx1UR9alCjpcmkhgoUaKR6+n1PioWZ5c4ZsoURcfVId/IyZ6q8GFQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sUU4szCElohs9PEiRE2hRn61F2A3Qr6lu7KnuIhGws=;
 b=IsrEefu3DpAelrb0LR4dSWZcmQFMFC95SFStkvsYy/LQXMkP1OX7KA+PUf/PNsOpUHemY1n+LiAQlMt9THoCvoFrmCqvJFR0+26qyw50ZgR+v/quxo5kWb+LWQDqxLqoC+jv78Z5SrNAXgbs9Ivt+qdU//tCCxaYM8jA7vVaFTlHq4MNFwz80KyVS73FsjGh2WhnJTvtnPwxhrzEsQq4EfKY5oNNSua794GOTFgDwc4ROraVpL1MHRrnlRK23y5WonHaWPEnC61WQaAX1d6w1Y0kGQLocqxFwa5u6oHNKYqdEkOvcox1MtP/IqQBLappoDoklwMwaGdSVn9l586/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 18:38:08 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 18:38:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Tng, Ackerley" <ackerleytng@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "Shahar, Sagi" <sagis@google.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Huang, Kai" <kai.huang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Annapurve, Vishal" <vannapurve@google.com>
Subject: Re: [PATCH v2 2/4] x86/tdx: Use PFN directly for unmapping guest
 private memory
Thread-Topic: [PATCH v2 2/4] x86/tdx: Use PFN directly for unmapping guest
 private memory
Thread-Index: AQHc2Ek3sBeUEIOYkkqhcItNU83uk7X36pMAgAAF04A=
Date: Thu, 30 Apr 2026 18:38:08 +0000
Message-ID: <231efd4e9267d3dbb8c63e57b3a43567c965e24a.camel@intel.com>
References: <20260430014852.24183-1-yan.y.zhao@intel.com>
	 <20260430014948.24226-1-yan.y.zhao@intel.com>
	 <CAEvNRgGsMaioFvTWaLhnDiLbdx3tunZpo3Qzxdm1xeb4ef0J9Q@mail.gmail.com>
In-Reply-To: <CAEvNRgGsMaioFvTWaLhnDiLbdx3tunZpo3Qzxdm1xeb4ef0J9Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB8050:EE_
x-ms-office365-filtering-correlation-id: 967bbd5c-6888-4962-b2f5-08dea6e79fd0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: MtSurvcRm1XAy7S5/lr0lu/0lNPiLMUAbatEZLk5u6Pvm1//jBoyp9HN9z7+0pyN9uTMy3JNrI4feLcUERlx//hxRxv+P5oH9HoyWWkrcyg5FZ828XzA97NSCsqplfqSF46nLEtw/i75BIHghK5WyHLYNnCV7nsMbpG4g5Xo+Kn+jPNVE40yxQpZKtZUdJXIBzc7JmeCtNoW1bpWuNwoa1W3GOqgVfPmDeI5OGXWylFoMMV39K1A67+DofFTXziwEvRBvf0DyRS4nJKm71pyhE58hSOXQF/jdx+2L7/V75QaiXuvAdGMyJkXufLis/OD2bKD5FmRMFlOpGT5NgnocC5QR0qMjOnO7//vLQedUKafbGQRFHVxoyGOo+1i0w5iwE1gtO7l/tykJnIW6QUHZFJcttOvrwpT4SNKEQwXL3NW+mCYNSL/lTRHKWUSPvdtXFPHO6AeMyEl7F5OGhndoEWjb95Udf9GvhPKhDCHVxB/26pJIjx/uHPg3T+mW0jNGUczzbRfJ2ufUQzAIM582td5PSv8Ie2ZTIf3zwYLMMAX9TFcsHDjFaoaRazfwzk+GFHh968mnJkCA7n386TwvSsB3wefMUAPGIz2Y8QMHD09zge5k3EzeNQcrIot42wv/RaznIvRBlbRCF4cRZctwGGLmd9PHKm09Sccb8EoRQldIrxxXzitfCQVLDzQ9SQ3ujI5/QfbmWwskZ1WfhcaWusxJFB4qaEAkIIFEcGvOdqDy91IynZk+xvSdE8Ude37
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWp3MC9TRTdXUXBXd3F2YXB0SjBHOWtFS2R4Sjd2MlRWQXY0aDZsaXZ0Mytv?=
 =?utf-8?B?VGh6MzgrR29PUmN5bU53RUF0T0xBdk5aV1dPVjN4RTI4Z3BnUUNFQUdETmRl?=
 =?utf-8?B?cUtMclVGVVVuNUM4SEFOZWp4a1V6VjN6OHZuZytzRlEybjgyeGJsMVRiRCt6?=
 =?utf-8?B?aW9BeHBRSzlKU2lscDlsUldxem5mK1pwUzkrVFpkKzdHQ0dCaHVDVkdGS09l?=
 =?utf-8?B?Y2JCU1BhaTJHZ09xNjFyMUw5UkpxczZSZlAzdEs0WGs2V1huSkhjRXVuKzJl?=
 =?utf-8?B?ODgralhycHFYNjdCSEtteDA0ZlJtZGJUbUZNUHhVaVVSeUVjM0pWTHVCdGts?=
 =?utf-8?B?RHdkV2diNGg0cFllbXJ6T2FHcU9QQ3FDTWp4RUhFQjJhbnVuRy8zajFIQUpJ?=
 =?utf-8?B?WUNEemY0VzNIejk3dFpJYm1heEJMYkp3Z1MwMXZVOHJHdXBPb25OQnhoZFZu?=
 =?utf-8?B?Tmg5UHFUWFJrazdqb1k1aHI5cHhIM3d0STJuNXVRclNWc3g4ZHMvQjRnWnRD?=
 =?utf-8?B?S2tpWnVVdi9UclFra1p2MGRuUERhUnNtbWNjNkU4eHBGWDVDMHIzVjgvYmJz?=
 =?utf-8?B?d28vT0ZjY0RRMHJIRU5BRndVTkRTd1V1bkJQTHdNTDR0M0ZPNWpFOXM2d3Bp?=
 =?utf-8?B?ZmhwR0NueG8vQ1VmTS9xc0VqN1IrdExLVllmZFFzTHBsck5mdXFFejZLODNH?=
 =?utf-8?B?aXJ2VEV2SmhveXE0QVZ4R2FqeXRMcWQ4cVFYeXRvdHVaZ2pIdi85R3ZON0Ny?=
 =?utf-8?B?SnVwa1BhNllGM095UzlFNiswcStoMzJtZGtkaUhjQldjN1RuTGdWMkpnWFpq?=
 =?utf-8?B?RE04TU1ZeDhMS3M2V1I1M1RjMUtIU3BKR293QXR4cGhVU2JlZVVsMlpaU3o4?=
 =?utf-8?B?N0hOK1MvdVlLZ29uTWptN3pEVVhjTmxkSlphOG13ak5SOUttYnhVTGxvTHdq?=
 =?utf-8?B?QzBISzBXQTlBSjQ0NndZMFRnNG5YSVVUMVB5ajVQa3ZzTWFLVEpyRDM3Z0p3?=
 =?utf-8?B?VFBmSlVTdTAwODQrYW1zbmlYa05mVVlKQUN1T0pnbDErc0plMkZnQXQ2YWVy?=
 =?utf-8?B?Umw5bHRTZjFwNGoveEtHcGdYcm9SQlpuMWtQdWFaTkY3S0dnQWxZTXh6bEpB?=
 =?utf-8?B?RVp0S0FpbnB5bWdKL0lzRElaREk2dHZmVDY2RFArWURJWkd6QnNhTDBERk9v?=
 =?utf-8?B?dGRuSllkVjdUNEo4aStUNVNnMU50ZmE4M1FMdDh5NVAyTGJvY0JuSmFQQW5m?=
 =?utf-8?B?NkxubzBYT0xGM0lyZCtYQ3BBUmFWa00vY0VMeEsyN1l5VWVtVzVtbmFvbXhQ?=
 =?utf-8?B?dUJLTFZGMzhWL1RENXpPQzJOa1l2V2JZUWFuQW9lZHlKZ2xMK2IyekxVeDFy?=
 =?utf-8?B?YW4reTZxd1NJVlRlaWdZZWZodzdYcjE3dWZhdVJVSjc1ZU8yZCtsaXlJM0Uz?=
 =?utf-8?B?QjQ4bTIycml0NkpGT2N4YkFxZHJoM3ZkWjhzSHA1UTNMdWgyQitYS3NzV0Qy?=
 =?utf-8?B?Ymc3N3VaemVCanY1ZElEd2VyQmZ5aHk4OGNVMGtoSWYxUWF4NUxnTkN3d25J?=
 =?utf-8?B?bU85YmxWQ3JyanA1UldkS1JHN1k2eHprTHZuZ1FZZElCOGlueHhjWmJaN1pl?=
 =?utf-8?B?L1U5a0NHTWNyNVRmb1llK3NOMHlxdm5IcGliMkt2S2VicnpCaXJtTHFWWUI3?=
 =?utf-8?B?QlhZNk9YaGpSRUpsRXplMm5sUXhPM1JWZHJvSUZXZ1pYTHhaRStJOEplWStF?=
 =?utf-8?B?RnpCTjFjeWc4YUVuUGZ4THF2QktBY05vRU5LKzNiWks0bG5HaTZSMzc4WlVn?=
 =?utf-8?B?cHpKTmpWVUJUWWE0WktsSDJsS0YwZE9XcWZreUZ6Y0dmc2Mxa1VIZVhLbVIz?=
 =?utf-8?B?cnBqdEw4SXdzbUNBdUlSdGxESC9BamZiR0dmbGFONCtVaVNma1NtSTdTakhh?=
 =?utf-8?B?QU9YbFM5REhkdTg0bGMrZyt0ZUtDZWp1S0U4Z1g2cUZ5aStKOGpGZ3N3NHdB?=
 =?utf-8?B?M1VJYWpLM0R1QmdpR2p1UW5haFJBRjVpRllTb3JTWmM0eUc3S09iV3JZUCt2?=
 =?utf-8?B?N21aTUNaUzhEaWtjNitWMk5vV0xvc1FOTktLVUVzTURjVlMzQS9Gb2NGaStQ?=
 =?utf-8?B?ZmpGVUNXbmVHSncxd1VhS29xZ1ROWHhWWExjY3hkQTJURE9mVUtOTXVaUVgv?=
 =?utf-8?B?RDVwVDlmN2N5N2k2SE11cmNQRUp2dE5oQzRJSHQ0ZXBvUXlNYjE2aTBjSlFZ?=
 =?utf-8?B?YnlDYzZRblVySUdpT1Z6YTA5ekp2VTQ0ZlVnekxNRUFqeDNEQXo4SzdlYmpZ?=
 =?utf-8?B?ZkZLOHJHdXdUYmJFOGFUN3VtRWJCSXNqdGlQa1hGQ25rVTRYQXl4bCtlUXN0?=
 =?utf-8?Q?rr50J3FS0uzFEJug=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C274D8FB6019A4789DAA6F7C0D74F54@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HcrIWA5vHDTyhR8f/hwkwRmuPBtzQyWvgbHelSJuB4qsDJBIGvUsr/WmXBr719KeAHfgNX/+WrSNXflNbnpks9RzCVcmcxXNqJHmJMt2+lqTrGP0NvH5YmCLc1CiF461dBwcMxFckwTO4FszL8xeSzB5I5+HsJE7ETQiA6aI+Y5erWWRukZxDyYIsYv3O/8+ct7DKEVGKNJeoQqRCr68SSOVNRxiRWn3V8vDmXMKjU432csuMCTeutCimZFkwAWxOShngKzy9PDl/pm4x69BEobNGSKLVsSHrYWC7+IP1bvsnDOub0DY2q7HCIgv1KEDcKf4AILR71bhedjSxJY7zQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967bbd5c-6888-4962-b2f5-08dea6e79fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 18:38:08.1866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /UUOz3Mv1losgjmMB5tj5Yki0OJ1trF2Xw/dZbwBMVvd9WJpG4eBXaXThiCrX+S/PijwOq7bC8oJsw4FpyUb+cGbkn7VyWK16IPg7dpV8kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8050
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTMwIGF0IDExOjE3IC0wNzAwLCBBY2tlcmxleSBUbmcgd3JvdGU6DQo+
IFlhbiBaaGFvIDx5YW4ueS56aGFvQGludGVsLmNvbT4gd3JpdGVzOg0KPiANCj4gPiANCj4gPiBb
Li4uc25pcC4uLl0NCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92bXgvdGR4
L3RkeC5jIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ID4gaW5kZXggYjI0YjgxY2Vh
NWVhLi5lNWEzN2VhMmQ0YTAgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvdmlydC92bXgvdGR4
L3RkeC5jDQo+ID4gKysrIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ID4gQEAgLTcx
MCw3ICs3MTAsNyBAQCBzdGF0aWMgX19pbml0IGludCB0ZG1yc19zZXRfdXBfcGFtdF9hbGwoc3Ry
dWN0IHRkbXJfaW5mb19saXN0ICp0ZG1yX2xpc3QsDQo+ID4gwqDCoCAqIHRvIG5vcm1hbCBrZXJu
ZWwgbWVtb3J5LiBTeXN0ZW1zIHdpdGggdGhlIFg4Nl9CVUdfVERYX1BXX01DRSBlcnJhdHVtIG5l
ZWQgdG8NCj4gPiDCoMKgICogZG8gdGhlIGNvbnZlcnNpb24gZXhwbGljaXRseSB2aWEgTU9WRElS
NjRCLg0KPiA+IMKgwqAgKi8NCj4gPiAtc3RhdGljIHZvaWQgdGR4X3F1aXJrX3Jlc2V0X3BhZGRy
KHVuc2lnbmVkIGxvbmcgYmFzZSwgdW5zaWduZWQgbG9uZyBzaXplKQ0KPiA+ICt2b2lkIHRkeF9x
dWlya19yZXNldF9wYWRkcih1bnNpZ25lZCBsb25nIGJhc2UsIHVuc2lnbmVkIGxvbmcgc2l6ZSkN
Cj4gDQo+IENvdWxkIHRoaXMgYmUgdXBkYXRlZCB0byB1c2UgcGh5c19hZGRyX3QgYmFzZSBhbmQg
c2l6ZV90IHNpemUgaW5zdGVhZCBvZg0KPiBnZW5lcmljIHVuc2lnbmVkIGxvbmc/DQoNCkEgdHlw
ZSBpcyBhIHJlYWxseSBnb29kIGlkZWEuIEl0IGNvdWxkIGxvb2sgbGlrZSBhIHZpcnR1YWwgYWRk
cmVzcywgZGVzcGl0ZSB0aGUNCnBhZGRyIGluIHRoZSBuYW1lLg0KDQpJIGFkZGVkIGl0IHRvIHRo
ZSBjbGVhbnVwIGxpc3QuIEJ1dCBJIHdvdWxkIHByZWZlciB0byBrZWVwIHRoaXMgc2VyaWVzIGZv
Y3VzZWQNCm9uIHJlc29sdmluZyB0aGUgY3JpdGljYWwgY29udHJvdmVyc3kgYXJvdW5kIHRoZSBz
dHJ1Y3QgcGFnZS9wZm4gdHlwZSwgcmF0aGVyDQp0aGFuIGFkZGluZyBpbiBtb3JlIHRoaW5ncyB0
byBkZWJhdGUuIElmIHlvdSBkb24ndCBtaW5kLg0KDQo+IA0KPiA+IMKgIHsNCj4gPiDCoMKgCWNv
bnN0IHZvaWQgKnplcm9fcGFnZSA9IChjb25zdCB2b2lkICopcGFnZV9hZGRyZXNzKFpFUk9fUEFH
RSgwKSk7DQo+ID4gwqDCoAl1bnNpZ25lZCBsb25nIHBoeXMsIGVuZDsNCj4gPiBAQCAtNzI5LDYg
KzcyOSw3IEBAIHN0YXRpYyB2b2lkIHRkeF9xdWlya19yZXNldF9wYWRkcih1bnNpZ25lZCBsb25n
IGJhc2UsIHVuc2lnbmVkIGxvbmcgc2l6ZSkNCj4gPiDCoMKgCSAqLw0KPiA+IMKgwqAJbWIoKTsN
Cj4gPiDCoCB9DQo+ID4gK0VYUE9SVF9TWU1CT0xfRk9SX0tWTSh0ZHhfcXVpcmtfcmVzZXRfcGFk
ZHIpOw0KPiA+IA0KPiA+IMKgIHZvaWQgdGR4X3F1aXJrX3Jlc2V0X3BhZ2Uoc3RydWN0IHBhZ2Ug
KnBhZ2UpDQo+ID4gwqAgew0KPiA+IEBAIC0xOTIwLDE3ICsxOTIxLDE3IEBAIHU2NCB0ZGhfcGh5
bWVtX3BhZ2Vfd2JpbnZkX3RkcihzdHJ1Y3QgdGR4X3RkICp0ZCkNCj4gPiDCoCB7DQo+ID4gwqDC
oAlzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzIGFyZ3MgPSB7fTsNCj4gPiANCj4gPiAtCWFyZ3MucmN4
ID0gbWtfa2V5ZWRfcGFkZHIodGR4X2dsb2JhbF9rZXlpZCwgdGQtPnRkcl9wYWdlKTsNCj4gPiAr
CWFyZ3MucmN4ID0gbWtfa2V5ZWRfcGFkZHIodGR4X2dsb2JhbF9rZXlpZCwgcGFnZV90b19wZm4o
dGQtPnRkcl9wYWdlKSk7DQo+IA0KPiBTaG91bGQgbWtfa2V5ZWRfcGFkZHIoKSBiZSB1cGRhdGVk
IHRvIGhhdmUgYSByZXR1cm4gdHlwZSBvZiBwaHlzX2FkZHJfdD8NCj4gSSBndWVzcyBpbiB0aGlz
IGNhc2Ugc2luY2UgbWtfa2V5ZWRfcGFkZHIoKSBpcyBwcmV0dHkgbXVjaCBhbiBpbnRlcm5hbA0K
PiBmdW5jdGlvbiwgcmV0dXJuaW5nIHU2NCBhbHNvIG1ha2VzIHNlbnNlIHRvIGluZGljYXRlIHRo
YXQgaXQgc2hvdWxkIG9ubHkNCj4gYmUgdXNlZCB0byBzZXQgNjQgYml0IHJlZ2lzdGVycy4NCg0K
WWVhLCB0aGlzIGlzIHVzZWQgdG8gY29uc3RydWN0IHU2NCBpbnB1dHMgZm9yIHNlYW1jYWxsIGFy
Z3MuIFNvIEkgdGhpbmsgaXQNCnNob3VsZCBrZWVwIHJldHVybmluZyB1NjRzLiBNYXliZSBpbnN0
ZWFkIGl0IHdvdWxkIGJlIGJldHRlciB0byBoYXZlIGEgZnVuY3Rpb24NCm5hbWUgcGF0dGVybiB0
aGF0IGRlbm90ZXMgdGhhdCBwdXJwb3NlLiBXZSBoYXZlIHNvbWUgbW9yZSBoZWxwZXJzIGxpa2Ug
dGhpcw0KY29taW5nLg0KDQpCdXQgc2ltaWxhcmx5LCBJJ2QgbGlrZSB0byBub3QgZ3JvdyBhIHNu
b3diYWxsaW5nIGNsZWFudXAgc2VyaWVzIGZvciB0aGlzIG9uZS4NCg==
