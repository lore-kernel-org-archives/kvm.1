Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C31415F2D;
	Thu,  6 Aug 2026 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053081; cv=fail; b=lbV+SvTj86uwv2kE+EDDJcmxdT0babejD1Q41q8CWikD8sBaJzouUbshgggPN/ya0vnnmYbXkKjtKRqWgptb54ZhG1beML+6gX2bpQPFBjlQhj2vOrDsu+nzeLrHuAM7ba43IayYGEfbPiLvjYXkuofYRp9VO/DntXNXXmGI6BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053081; c=relaxed/simple;
	bh=p0VATs/aMdSeUC4l5slhJa+14V0jFNE6P6DyXj9cBk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NTATsXfOG5sxe/2m4IA2PvKJ5CWQw9kcvWg19ZQViQqXHKk9xRnPhecZ+2ZLMpi6VD9IgJQMsfTiru7o1npcPx45FB7v359KZJLIMdTkcfHzPcvI91E5iW6+KbJavLUbhw3ZQGdfxAq4+b66toPH/8D93ygl7oYM6k/zd6ALtnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIJnWAOz; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIJnWAOz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786053080; x=1817589080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p0VATs/aMdSeUC4l5slhJa+14V0jFNE6P6DyXj9cBk0=;
  b=kIJnWAOzIlejEAEfm+8WpDgLTYh9E6PXEpQyr42kP+4CMtx0MQXLFKfO
   GUjgCDXPtCOq9r7yxruR4nqXKi43OhaOioue1FWJAj02N/o3jadCtxLyf
   67AJGLFsMdzKjEItcptc46lT9i3e610+Y19wecHyJ+dpsz03M5NvmhPgZ
   r4GlK5tqKvOgKb9XPC5cZ0qBPKsZ8zrE0TFN4Bl0gN66T2fni4f9+7wWu
   jRXaCmoouDkujOX+MgAQzYj+17iUuNLNCJaKQSZIJHPbWq4Q/aBnFpqqD
   8aI6ImJFEhdjbdWybneKLyw3LKYIYdt9yDBGLelJQj/mIEw5wNHO64WSa
   w==;
X-CSE-ConnectionGUID: cmI4Cf1uS0+JQdx77tBloQ==
X-CSE-MsgGUID: Xj6yKb9QRDChWARVj9wGTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97012868"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="97012868"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:51:20 -0700
X-CSE-ConnectionGUID: 1M6vrKGtSP6ahq0vR2E0UQ==
X-CSE-MsgGUID: YV5Kz86aR/e+5A6HzSWJyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="292112367"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:51:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 14:51:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 14:51:18 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 14:51:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkjF/FPs9899GV68jtlcWLd7JrXQLcem9TKxLHAg4bXvOi+eZ4QipGyVXI1Mhr1XzQ8r2I/QpyDwFNRKkhLxZkkAreNbp5a0YuulAxybbZ5dRVSXaWKtTo2/kHuyUvjvASPiKeN/48qYB3ASj/77gqhKsvaNySl1o9QtODU444bTMssSD3Ans0CdXxr0kKx1Nk16ydUyH6L3RRiO4izaVaDYO9dxbsaa3nQQ8k33/hm7LgvW+j/92Hyn4tx9Tf6Qd4w6Ehr/M/r/SCfJYB0tsDHpXs5h+iYWmlEGwKRspTFPlLtDrc6DumdKb3+ezuxaL49+YFGrOUZVACpi8SdBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0VATs/aMdSeUC4l5slhJa+14V0jFNE6P6DyXj9cBk0=;
 b=KdWFuK7TYB3R6SrXKrqE8nI5Js6NM9pP8kkKU0VLHWoPWx7wNok9TiUVPjBCkB7hcD426auEQxRGGRXoDJKHLw4vrdtEJzCqBQVC1MajCqMIeOyMyim+BqqoOS6kgtQYHYPUeCl8/Ot0zFWhmhSoYOy4wb30z3bfHo3S17/GPDC+xRRRN5PcXoJ2fns0o74kGnm/MDnyr2/EwQVVapbNOn13tjOnbr0WAeJw1Dvwl5jfgHIe/+miNtsOTkikU8ZGCdwj3xJNkGPAXZ46rGesNxiDwZ+rDAzlfoF7HoxWoz7FNMqGdk3SIoWhNIhzYvD+fXUMhek1xB4TgATl+hB7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 CH3PR11MB7203.namprd11.prod.outlook.com (2603:10b6:610:148::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 21:51:16 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 21:51:15 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] KVM: x86: Track kvm_vcpu_arch.pending_ioapic_eoi as a
 u8 to drop dead BUG_ON()
Thread-Topic: [PATCH v2] KVM: x86: Track kvm_vcpu_arch.pending_ioapic_eoi as a
 u8 to drop dead BUG_ON()
Thread-Index: AQHdJceB9NVxIcCodUWXHWY1Ehz1hLaRj9aA
Date: Thu, 6 Aug 2026 21:51:15 +0000
Message-ID: <4ea487eaf2db2bc39eecffddc447663a9e1637cd.camel@intel.com>
References: <20260806171400.4119301-1-seanjc@google.com>
In-Reply-To: <20260806171400.4119301-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|CH3PR11MB7203:EE_
x-ms-office365-filtering-correlation-id: c2521b58-325c-453d-df29-08def404d702
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: mlyH1FuEeUYA8Kt2rvIXVSSc38SYbGjP8DuWBvGuhx5jvE7b36HefTzkORfvT+RJn8IDVNVZYE8+x806Q5KnyehGKugD8aZ2MNsD9lqcQSsRAmeXG3UUICW+ucMKyFn/mQq5G4Bhe8DyKiAslh9dQn29+M23Zt5VMJukgFFPtUlRx83j+mWKFZrmkp9gy1yjvDeKItv338LGgqyBRswNhhQP+69koiTElw/4ON1Ni2NfZs+hUNrT6GtS2OajXb9tqHQDAm9RXx7r7fz1laej/a+br2NLRJvLAqiCdbM0mNGdayihRNCOO1m43NPK0bhZUCZPTsJKf2fHBHMglFPAr+koepjEgKWjdXnXG12/MFNivM7oLyLxfBmTJYodoPq0xeEzEF8XuHNPHLEXwYV3HL5gzigU3gTy7LI+QnuOtSuU/xMmA8/oZuDBKUM/Ft1m8lihKz/ZFnEq+gbFei4Y+cIyPjXgF3Xrh0DAbKp0+3K7omFNqkijOMKtJyR8ix3SFx+j2lo4DYp9Ub0+b6TS7kU/89TotMlyyNqjuAaxoKtXE1srjOit0mn1RZjUhf34J65xHRUYqD/D86++cPU1MlLrHMMXXrLgeLJi0XBTQZxgQhZgFcvCYDijs33uWzMnZ+JBA215IbJQLsl8p33gIi8g9AiNtB4RdMuDuEd6khj0feYvF0rrkuu+0na5vndQCX+FbTyudBXsjYGNjmh+zma9X5abvnsVq0JgSxu15j8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTczMmlGOGYwWTA3TjJHWjBncFJNMitaakdNSkphUFRBQ1hYZE9pbzVpOVpt?=
 =?utf-8?B?b2NRM2FyTHJ5aWVhVnMrU3didi9ZcVZNNUc5U2prbXEvTzY2UEoyOVZjT2Vj?=
 =?utf-8?B?YVNveWRHVTJpUlFtMTQ2UzBSWHkrT2RQT0N1L0prWDhucVVQT21iU0pJTm9K?=
 =?utf-8?B?Ky91L1FCYVFXWmRkR21wZzY2WWJCNXUrWng3RTJtb2xnVXU2SFh1S0dzMXFI?=
 =?utf-8?B?R3N6YlE5UWhKcjFYbTZqZEloQTBKTUdhZWYxdmc3dHd6MmI1d3daRis3enhp?=
 =?utf-8?B?bVVPMUluOWRBVzJjcEtHWlI4UkxxVE9WcmNmWGo2ZDVab3ptbSs1RnJndFpN?=
 =?utf-8?B?RmFzQm9DTXhVNTEzNFFuUjN4aWs0R1JBcWNDcG5YMDBVSlcvZ3Vkd2cvbEU0?=
 =?utf-8?B?b3dvYlJuWDBOZkZiYmxHbitveTN5bUNRMmU3NDdRR2tJc2l3NkkyWjFqODZ4?=
 =?utf-8?B?OFFwWVJhZTZVd2NYSHVJM3RZNU5GYncycVZ4OFZqYW5ZQmtQZENHZTNISGNt?=
 =?utf-8?B?bUhwVG83NW5TQTVyaG0yeXNuT0hweThtR0JMQUNmOUtLV0ttR3pwRnhTSVVw?=
 =?utf-8?B?Z1psTTF2dzhpMUNGNS9YSS85ZE5qdTJDRGlSYjlCN3hpZFJrZ1lEWDhlbkFw?=
 =?utf-8?B?V2NGem4zNWd4bmtKVkhtODhONDVzSjNSUnppOSt2cWFmeUJQaVhET0xTYWRJ?=
 =?utf-8?B?VTIwTnlGSG5tajVUMlBibGpvQnRpQWpkdkJjaFRUZ0hOR1cvKzlGaVUrbDVS?=
 =?utf-8?B?ZHpybUcrYzJvTHh0andSSDJDdFBpbjM5bld5SmszdmFvR2tnN1IyWFNucFdq?=
 =?utf-8?B?WGVXTXdQbW52ZXZiUHRCL2tEakErTXF3QTZuZ1Bza0EvWlA4Unp3ME9hRU5z?=
 =?utf-8?B?dTFKcTd6OHR0M2tWcDhVNWtYOVNZeWVaNTNtZy8xbGoxRFZNUVdFeTFDQ2Vy?=
 =?utf-8?B?YlF5ZE5IcVZJclc2VXdCYUMvTjliTEVmbjZBaUlwWnNLTHh0TmNCTTJJajhI?=
 =?utf-8?B?M0hMS0oyaVlVK3VhU05GQ2hBeURWT0RXVWlLRmZrelhxL1Vqa2JkN2J6UWNM?=
 =?utf-8?B?emZkdU9vZUtyNkFBRkZpaVpHa29ERTlsaWpFUlErc0htLzJQZkkzUnU5ZXZY?=
 =?utf-8?B?ZUs3YmttaEdMM0hSd1VHVW8za0g5QjlOVkhROERQdGVPaEJvTDBrbU40TFhN?=
 =?utf-8?B?a1d0T21oYXMyWnBXSGtqdGZoWWp6eTN0K2RBeUdqUDlIOUJOTHRBQUtiRGwz?=
 =?utf-8?B?bzRhQk10UnNxTERYd0dCcG80VFdpZmhyQU1DUkFCd1FROFErQkp3ekR3RlJi?=
 =?utf-8?B?U1BvU0FpWkVmQUtmeFIxWWdmcVYrU3lzZXFNWlVoZXBYeGwzeGFoSHJqSmFX?=
 =?utf-8?B?bzNnQUJTbUxmUmxwMWdxcHdXRTljZ0Faci9UN1A2UXNmcGR4NGE1TEg4dEdl?=
 =?utf-8?B?V3RXR1hXM1M0NVlaOWZqR3V1S2hUa3Z4eDdHZjlQelNwMGVyL2NiS3VMU0Jr?=
 =?utf-8?B?bGNmVmxWUG5IbXpQbU9TTlh0MzNOdkFpRnNoYzJQTnNtU0JqYTdrWWJBeU4x?=
 =?utf-8?B?WGdVaFg1UGJ6RVBmUTBQL0dNcnNHYWpZajlZM1BkTFI5RnBCNmtFLzk4RmNB?=
 =?utf-8?B?eHZtcmEycUJRajZJQ2lrNkxJV3QrRzdPU1JJWXhYZGVHMHUrdSt2ckNianNl?=
 =?utf-8?B?YVFtTlRsMnpJZjhTY0Q3MFNaTnZUc3NLQ2Z6cXB3NGJVc2R6dWFDcFE2alBT?=
 =?utf-8?B?dUZ3T00xVThkVHlDem14cDlST2VUYjh5cis3c3lDWkFuOC9ML0FrWUliSHdh?=
 =?utf-8?B?bDlpSmE4U1phZnNvUEZJS1ZrYWFJcFRqaDRSMUYwMEtyOWlPSlJuV3pFLy91?=
 =?utf-8?B?WDY5aDZJdWJoTURwaldWMDU4RWpOQVRHWDhJeVAzN2Q1bFVZekJ3dEw1NFBv?=
 =?utf-8?B?T3I3eGU1Y0tmbkkwa0FjTDhuSzQrNlBpeGZOWkhTTW8xQzRZWXpoSjhseW5V?=
 =?utf-8?B?b2tBSU9FR2lhZXdsbk5oaWhjUnhuS1ViaWNyYm1LTlVZTVF6bzdpMDdQNXhT?=
 =?utf-8?B?REUwT3ovNVozQ1BiaXlnUWNuZlB6NVdkUHdwZ1lDQzIxVDNpYm9tclMrSllF?=
 =?utf-8?B?aDhudEZWWnVtNmVhdnlnckxPS2NGWmhXYVlPanVBckJMWWFXWHE2dDFIdE9X?=
 =?utf-8?B?ODNJekF0bGtEaDdyT0ZwUC82TjdoeWJWWkpzeFlkZG1pV1p4VG1CZnlEakNn?=
 =?utf-8?B?aC9KNE5WT2ovdnRVNFRYNGtZZkZVRExjS01WZDZCNWI0R1Jmb0MxOUNQcWRW?=
 =?utf-8?B?QW80VWtFUXBKQkxzbzYzRUZGSCtySWhxUGxtR3hpVkJETFZaUE1CQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F3B5CEBB1D05C4E924CFF640B4E7CA9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nwEyipzqOCECFG8uLlzoMbXunoCANqh3iNwVKICQwi3qV+Id2ue9ghJVZAOXi15KQegjdJaz6f+c1K/+s+QTjnoiSsid7w+KeLMosxV5JLTf8HuIvNG9p20ThUZ9+LVHOvGziR9cjCX5M7NkuHUjeIG2fmylhW0HaE1yyGzjawF/JMQRQlegTezRxs6SlrY91N2B54+ceve8keraSo7h4iobhOirlluLVSslLvh3ksQwZL1IHeJAtWHb+x+Cf/38CfEULVyubljaKwAm8jnKUfqEl+8WnSivwkfEC2e8k9f7MXbKfX5v9Z6kUWzYbu3aYqZPDn7l4tfscF2zWQxRfw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2521b58-325c-453d-df29-08def404d702
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 21:51:15.6453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0u6eFtNLa/Bv3Phc0SugBP8jx9yeyEZCIkekNBGVksj6x3KTkjTBaIl1918d1HZysRavgckduhsXI+g6bOBb9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7203
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA4LTA2IGF0IDEwOjE0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBUcmFjayB0aGUgdmVjdG9yIGFzc29jaWF0ZWQgd2l0aCBLVk1fRVhJVF9JT0FQSUNf
RU9JIGFzIGEgdTgsIGFzIHRoZSB2ZWN0b3INCj4gaXMgemVyby1pbml0aWFsaXplZCBhbmQgaXMg
b25seSBldmVyIHNldCB0byBhIGxlZ2FsIHZlY3Rvci4gIEkuZS4gdW5saWtlDQo+IG1hbnkgb2Yg
dGhlIG90aGVyIHZlY3RvciB2YXJpYWJsZXMgaW4gS1ZNLCBpdCBjYW4ndCBiZSAtMSAoYW5kIGNh
bid0IGJlDQo+IGdyZWF0ZXIgdGhhbiAyNTUsIHRob3VnaCB0aGF0IHNob3VsZCBob2xkIHRydWUg
Zm9yIGFsbCB2ZWN0b3JzIGluIEtWTSkuDQo+IA0KPiBEcm9wIHRoZSBub3cgZnVsbHkgZGVhZCBC
VUdfT04oKSwgd2hpY2ggYXNpZGUgZnJvbSBiZWluZyBjb21wbGV0ZWx5DQo+IHVubmVjZXNzYXJ5
LCB3YXMgYWxzbyB1c2VsZXNzLCBhcyBpdCB3b3VsZG4ndCBndWFyZCBhZ2FpbnN0IGEgbmVnYXRp
dmUNCj4gdmFsdWUsIGkuZS4gd291bGRuJ3QgZGV0ZWN0IEtWTSdzIG1hZ2ljIC0xIHZhbHVlLg0K
PiANCj4gRm9yIGFsbCBpbnRlbnRzIGFuZCBwdXJwb3Nlcywgbm8gZnVuY3Rpb25hbCBjaGFuZ2Ug
aW50ZW5kZWQuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJl
ZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bn
b29nbGUuY29tPg0KPiANCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVs
LmNvbT4NCg==
