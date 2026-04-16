Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5571397;
	Thu, 16 Apr 2026 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776303636; cv=fail; b=bmhzFv7eVQ09U2JRYo4GNEfZNjBK/RGKlr4UVEC2rPjxvOHu5tcvyujD8wLN/XkhWzY7XRA5vLhIgbrGYa7IDPs3dnNxZa09FqIQofifh+RzjAA8Ili40XYmwdh/p0Ay9qHnNgjbYTGtL1Zer5VjTlgHpliwrpOHos/RBkUP6JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776303636; c=relaxed/simple;
	bh=66SjNsoJFNHtC+09glPELc0bp8qGLjmDOuOVj8SKsSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vl87mA2wesYhKTvzmhYj1QbZ8qWymWPSMTf7IjQ2cb2dg2yI72GhqUfmfFDQQTMDODuYa3LD9nA21n+ua8cgGcJ7WEdPtPBrlW/JpKxcZGp9/JUXzR34e/FyXSrFrCmlCkY8oHBwtOtiO7ZZbAZLFT9jOWe+xmdJQ4y0x35HZ/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H03ztfv3; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H03ztfv3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776303635; x=1807839635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=66SjNsoJFNHtC+09glPELc0bp8qGLjmDOuOVj8SKsSI=;
  b=H03ztfv3UsDHAqj0JZQnxSXtns+w0vWa1W63x4qdZ/kAqa4YH/SlEre6
   +SEwkic6kCV9UWNx/5mVq02UOCCukx4M7lzAoJwkMpfkhT65hx3AH5Y/E
   rm53+rpU52OPa3Wmb9LbSS6ooIDgQz+DnGeiTm9G2gf5y9UD8npVFA4vZ
   G+BVWFyluCjcRxA+fm5Kk4e9RE9WuMBMJtczH0Qy/QGloA16bcs2szvpB
   EqaNDCQ3vh3nAbR0HbE40XLFNopHIJHtL5idW45d6RbyJ5l99s7ph97MI
   a1NUK3pECpHjnyzHAfHXIztCVfkZWrPF6q/ukeDXZ/gmxXSXuH8HT2HoU
   A==;
X-CSE-ConnectionGUID: V1FoiD33Q1mcJvSidytxqA==
X-CSE-MsgGUID: aivrHEWCSqqgKQAAXuf+uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77200289"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77200289"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 18:40:34 -0700
X-CSE-ConnectionGUID: b8/98RhWSOeFA3f8QnhN0Q==
X-CSE-MsgGUID: eBuQ3AIdQWiYzpF4C5Dp0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="235532829"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 18:40:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 18:40:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 18:40:33 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 18:40:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8POvfBkKSl3UAezp/IQi6xWs33Ch2Qh+z2aozTfndI7lXUamsYXKmLf6u9aCagmurmIDQHUipc3xZvvr1oTQJnr2sW7b4ohmFUDcwbCK8ogf1iDfiXytLGc8do5oA7ZwrzdoKJ4nj58V4YqjoCZ8kOTIJfHaHuMMkbb1z0pZtOnn3fYbZSa+Ew2JAMyCFtuUmvI9pGWrX8c9IeRn5MlNrw/NJdTETpdj6P1KY5QGoRit4AdGgx4+v53RvI+ZsZYecY5hbSap35yz20YGN5mvJSVpAQKvhlCtUm2SOD8SRtnzw1r8UB9k3rlujZd+dftQ3Zcc1gSAibyVSSqeF18PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66SjNsoJFNHtC+09glPELc0bp8qGLjmDOuOVj8SKsSI=;
 b=Sw01nQv+xw9v4GUepTfyG2i2V0QM4GjWJdabN9GuVHX686tU/+T1p0ngsSbSYljFIRcrks6DAAesAcGCXG6ux7LyKHM3PAGCCLziLiLF8c5HJE06cGwqOHj9I3/dU7kltYh1cFyNKKZWlkOWhCuJov+0HdgDj8oDQDKzertHwkPhFlh+7UkMBylqYJ4U9lHtx55Wli8xxqNfKtpVMCuPz5P2tz2xiQr5yPxRbxiLPHl2JR8To56Es7tlLMhV/Q9O3aqLKMS+7aVphkanALrgwN94QQErqNU7k0L1bR2uLQ5ZvM43eAeX6UDJZ8I7fU0QcqbXYxM69VJZ1cDhOhwEvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA3PR11MB7656.namprd11.prod.outlook.com (2603:10b6:806:320::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Thu, 16 Apr 2026 01:40:29 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:40:25 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "paul@xen.org" <paul@xen.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH 04/11] KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode
Thread-Topic: [PATCH 04/11] KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode
Thread-Index: AQHcyHyrzjYXYTlHnEikxTOUo3JIB7Xc7m2AgAPA1oCAACASAIAAD2MAgAAUSoA=
Date: Thu, 16 Apr 2026 01:40:25 +0000
Message-ID: <cd8960cd3ec963bc60edd551e25d6f15a86a9e0b.camel@intel.com>
References: <20260409235622.2052730-1-seanjc@google.com>
	 <20260409235622.2052730-5-seanjc@google.com>
	 <dea50f27311d88dcb09ea98261ca280853396a42.camel@intel.com>
	 <aeAFMwBTUCdeq1JS@google.com>
	 <9f4a3dfa2d3fa2a81161652d81585b779a182866.camel@intel.com>
	 <aeAtAm0yezpj9EP1@google.com>
In-Reply-To: <aeAtAm0yezpj9EP1@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA3PR11MB7656:EE_
x-ms-office365-filtering-correlation-id: 850ef80f-8fad-4bb6-4085-08de9b592208
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 84o4+W9DwNKUhltijVjzRDaP/kqNGGfO2+ZxVuESWe6rlrMmnkWEUj81tnWYnk9BBA02uNTrsI3ztRtF/FH+DJH2aqdF0zeojpa6QqnScyjpBAF6lJMYO+XcHQYsl7Fk7c9Ymk2Pp2NQQ+lNJp+tt4gtE38wl9fD1igie8iecjY54wlKBeC7jLKQCiW4F2MXtRnjNpuUX4Iukwty8zGXJ+DdjkhcnNmxLOGWDozKSH+PVMJHwFH5/CXWOTTj0bV/ypaxcsEETmm1hEib1nIVKx0W5fu9e1nM7DREBtNkXMmyqSQO8x19jbgFxWjXAD5I9FLzkB7R8NOkIwVoM32SmU/orkVsYV70Z9bxActIeU9VHJ56pmLHeW84xABSx6IUl3KURcDUKXzML+Pzylx6r4Diwi8hJwJKjEG69dVoFmZTJrZgK8u8OiBy/q3vQIfBKME7Ps2oANFfBE3312PEyRJXpTyIiP7EltWsgFtsS01fVJLzJuZG00WfYp5Mo+IdbAmKVTz3/NCeS+m1VQx8zwBo3Bi4qpZtr7gUV4RECR/3sJbxY+pIYV7YnktoDGwiakaEUWcsA1oWOgVvtU6XxML3y6ss2vGad0nsynT80p3Chr09vTsDe3IsT4IqaxApLAz5k5WebZUgT66+YcFWv35FdhwjOwdPlwF0uvWtU5eszujAr0BOXmQab10eZwmJEnNAUNMztLw1Qn2FCDN2G1nrJeN+m5uKExvMBsOMz5/YKVpwOEOc8FhuUJAMkz69JsqZuTReSFW5T4O4ADtKWWfiLH7rCtoDrb+tddrNmOc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3BIbllqK0NvN0hMSkpkWk5WMzk1MU8wUFZFbUJDQXRENGNOL2w0UnVYNHht?=
 =?utf-8?B?dUxKV3daOG5iUWdveVZFTEY3eEZTLzdablE1RG83NlBWcjFScjBnc045RUdt?=
 =?utf-8?B?WWthK3Vza3R5LzE1Z3hBTmNhT2cyNkJaZVJqU1Z0bGdlWHNwN1hzdCt0OG5l?=
 =?utf-8?B?ODhWQlBPVnBqZ2JUMHdzNWxlZkc3U1c1VmJxcE5Rc1Y1RGtLazVnanoxSzNQ?=
 =?utf-8?B?d2hvTm5TbHBCTTh0VGpINVBEZjNsTUxWUjZXelRNVGlsdTlXbHEzNFpqdVFN?=
 =?utf-8?B?VnllRGNoVFJVNkkxRy9RS1oxZUwva2x6U2xjTDRjRHJ2U0w2bkgwTHRRM1Ju?=
 =?utf-8?B?aXl5K2hjVVI0TEtreEU0S2F5WW9jNXFoUUZOMlBlNWxWd1dJTTlRNUk4M1dY?=
 =?utf-8?B?bUE0U1J6Q2NBbEtTNFFvTkpyV3dBL2NRSUUxYWZVdC9BM2UxYWgxUVlVMHZx?=
 =?utf-8?B?UTlTYStmd1Z5SXhNZW00aTh4U2EvejR1TTF6dG9JT3NsSUlMaHNQbmNPYUJR?=
 =?utf-8?B?MjU4UlJMNktRampvVVlpRHNlcmxReHZ3eWhCdWRneTlPVEkvRU5HeHNvbW5O?=
 =?utf-8?B?c1Noc2xtanR5RFRZZWNlb0MwdDZ0SFdTSmUvMlRxOVdqY2tnRUpYL2MzRk40?=
 =?utf-8?B?UGtDQ2RweEJkek41V2wraWFRdkpUdmVuTnFSL1NscC8yenJXTXNUOVdkb05j?=
 =?utf-8?B?dVVLYUtOSjQ3REp5cHFFWlZmY1kySGpPZUc1QUF0NFRwazhqUUIxdDNJNEVy?=
 =?utf-8?B?elJpaG9UdnQydjJNWGs4ZFpLZ2NsVm1JWVZrb0ZoTzJUN2hEZlVrclM2WHhw?=
 =?utf-8?B?cVQydlBLbkwwZ0pZOXQ2ZmlHM3I3ZjZZREdzVXlJZ2Z5a0IrQkttSEZ6ODBm?=
 =?utf-8?B?L3JTdXQ4NFBuWFpBcVlwUS9lM1ZBZ3dsL05UQmJGakI1MXpyRzZsNGhZN3Fx?=
 =?utf-8?B?VnFhU0l5L2ZtMXZjcVJmdElXMnZ0UFc2eXlxK3pmbFAzZ3NrT1lmRlJ4cnlm?=
 =?utf-8?B?bTdJbVlyUUlsQ3BxNno5ZUNlTnF6T3FRVnZDWTQ2TGp2MTlIQ0psaWRERUNj?=
 =?utf-8?B?MzFtNWR6dVkvYjdBeW1VaW02eXZkSkdnV2FjNUpYQ1p5cWp1dmMzenhBOFZ6?=
 =?utf-8?B?bkRwRUoxMit6ZUIwZllXYS8ra2YrYnhQMjlOYStZdUVhY3NKdnhybklUQU91?=
 =?utf-8?B?OXNIVzFhTzNaeEJKcndqWmJjeWZkNHpzVE9CR3p0VGlPNzZvbUw5aDB6cXkv?=
 =?utf-8?B?akJwS21hRTh3Q0kwcWJWQ2czZmJDa25WUkZ5SGpKY21NR0VJd3NMY0doWXBi?=
 =?utf-8?B?YUJ5RGprNEgvVmNVMXZUb01kWnVmeDZwMEg4YjhpQzVEZnQ4UndHOWtWeExw?=
 =?utf-8?B?T3NBNzJpUmFIVjk0c2lwN0tWUUk0YmZyZEhxUTZaSmRBVEdMeFNCcHU5eTlH?=
 =?utf-8?B?aEJ5cTZmOVZ5MGY0NWphc3JoeHdYeUhUZ0E1MlZ3c01XVEtraEZPaFllQ05z?=
 =?utf-8?B?R1dQSGYzK3o1NUlWY1NUMXozRmdNTERieFY0RVE4d2NyeGxTeW4ya21SZUtB?=
 =?utf-8?B?RDM5ZmF2RWNVbzBNdmJOaTR3bGdDQlJsaGV0Z1pTa3FHQWNzcXdOYWtDK0xR?=
 =?utf-8?B?YUVjQWZQT2ozZDQ0UHFBUHo2VjlWR3B2bWJjam5xZmxPNWFNUS9hdEorcmFv?=
 =?utf-8?B?R3BnbjVmTkdnVUlGL2xoNkFLM2RTVldVNDFpeVNoTHdZY3pibDQxZ2l5QWFP?=
 =?utf-8?B?ZTVMOGFqOHlLaDErMlA0ZTY3UmxrTlAxSkptZ0FWa0xjOE1xTmxISjlMNE9Y?=
 =?utf-8?B?V2ZtdEhuc3c4S0JDOEZFekFOT2FZREdJSlB3U3hmVG1zZ3BXcWZHNnRXYkpU?=
 =?utf-8?B?WG9NUldoNWxaeWZvZUNjTEJ6SFFwRDZjMTByVjNRY00xTzVoRHFsbHJuYVdG?=
 =?utf-8?B?WlhmTEdvK3RCUmxhMlppZ3JBanNtWGQvNGI0NzBCQTN3NlpydXBJZUc5amEv?=
 =?utf-8?B?NGZnNmVXY1JyNFRjVWcrQndWV0h6c0NWTWE2YlZ6d3RJR1BuNEpZMzVDT2ha?=
 =?utf-8?B?TyswTFdSQ1JzZVIyWDZCenQxUUhNSU9hcUNvbzNSbzRWN2VsdW5JVXlQaDM5?=
 =?utf-8?B?Q3ZyQTRvWURFK3MxSEIrZ0Q2YWlSU2srMkQ2cVZxZmFMWjZCMUV6cVFrdXIy?=
 =?utf-8?B?Q2xwVkV1VFhnQWdySENERi9NeERQSWNBd2MwaWttR3FhcTArdjVoRGwzc2ZW?=
 =?utf-8?B?eVpqTlEyR0x2aThXRkZCcnJVazdObnBDS0F1dFd2WENBdHN5N0ROZFVkaGRl?=
 =?utf-8?B?bjZDYTRyREhyVTk5TTRrRGQ4R2dYTFFPcHZ2Rm45RlhiVXl2TWZadz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BCF35A4D6941E4E9DC1C2ECCE5890ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qggbLRank6aBApHP4iURcANpYLff/+OLYUsFpHWHWmuZk2mL2LpDjIAlQPBMp4AEQyMYXdAYVl6OArHlGuW7WtXcdF/XxJkZzrZBW91CafssCyQwDtmXmafY/952LbLhnhgw8fvlBLrhQ81yQ7mG2dzrBJw7r/1ylpQ4V35Zxght8gZUmH5qsaDX9wuA8EumfD+pL7qhVNAQNbUDAyEwaiQsH8v7drbSI17idBQ3HjjqT+KaMIakkMOhw8/7UAYXVwXGYpplRp3WCL3PsCDIRe8zMnguD5kDjn/ioglPvyNYWe/y0BEkz4AB5N4S3w+CwQjLQjpDeSuwtz4rOpjqZw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850ef80f-8fad-4bb6-4085-08de9b592208
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:40:25.8045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EW2nmiyAO+pKuOGRSD4qzPHFHAnUU+3xCA6geqCYmk8J7mOulRlV108nN7yUzu0bWB+Gat3Wy2a6a6USQS6S1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7656
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTE1IGF0IDE3OjI3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBXZWQsIEFwciAxNSwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIFdl
ZCwgMjAyNi0wNC0xNSBhdCAxNDozNyAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToN
Cj4gPiA+IE9uIE1vbiwgQXByIDEzLCAyMDI2LCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gPiBCdXQg
SUlSQywgdGhhdCdzICJqdXN0IiB0aGUgYXJjaGl0ZWN0dXJhbCBiZWhhdmlvci4gIEhhcmR3YXJl
IGltcGxlbWVudGF0aW9ucyBtYXkNCj4gPiA+IGNob29zZSB0byBwcmVzZXJ2ZSB2YWx1ZXMuDQo+
ID4gDQo+ID4gVGhhdCBzZWVtcyB0byBiZSBhIHZpb2xhdGlvbiB0byBhICJiYXNpYyIgYXJjaGl0
ZWN0dXJlIDotKQ0KPiANCj4gTm90IHJlYWxseS4gIFRoZSBTRE0gc2F5cyB0aGV5IGFyZW4ndCBn
dWFyYW50ZWVkIHRvIGJlIF9wcmVzZXJ2ZWRfLiAgSXQgZG9lc24ndA0KPiBzYXkgdGhhdCB0aGV5
IHdpbGwgYmUgemVyb2VkLiAgQW5kIHNvIGxpdGVyYWxseSBhbnkgdmFsdWUgaW4gYml0cyA2Mzoz
MiBpcw0KPiBhcmNoaXRlY3R1cmFsbHkgbGVnYWwuDQoNCkFoIE9LLg0KDQo+IA0KPiA+ID4gPiBJ
ZiB2Q1BVIGlzIGluIDMyLWJpdCBtb2RlIHRoZW4gaXQgc2hvdWxkIG5vdCBiZSBhYmxlIHRvIGFj
Y2VzcyA2NC1iaXQgR1BSPw0KPiA+ID4gDQo+ID4gPiBZZXMgYW5kIG5vLiAgTW9zdGx5IG5vLiAg
QXJjaGl0ZWN0dXJhbGx5LCB0aGV5J3JlIGFsbCBvZmYgbGltaXRzLiAgQnV0LCBhZ2Fpbg0KPiA+
ID4gZ29pbmcgZnJvbSBtZW1vcnkgdGhhdCdzIH4xNSB5ZWFycyBvbGQgYXQgdGhpcyBwb2ludCwg
SUlSQyB0aGUgYmVoYXZpb3IgaXMgdGhhdA0KPiA+ID4gd3JpdGVzIGluIDMyLWJpdCBtb2RlcyB6
ZXJvIGJpdHMgNjM6MzIsIHNhbWUgYXMgMzItYml0IHdyaXRlcyBpbiA2NC1iaXQgbW9kZS4NCj4g
PiA+IA0KPiA+ID4gVGFrZSBhbGwgb2YgbXkgbWVtb3J5IHdpdGggYSBodWdlIGdyYWluIG9mIHNh
bHQsIGl0J3MgdmVyeSBwb3NzaWJsZSBJJ20NCj4gPiA+IG1pcy1yZW1lbWJlcmluZyBoYWxsd2F5
IGRpc2N1c3Npb25zIGZyb20gYSBsb25nIHRpbWUgYWdvLg0KPiA+IA0KPiA+IEkgdGVuZCB0byB0
aGluayBpdCdzIGJleW9uZCB0aGUgcG9pbnQgd2UgbmVlZCB0byB3b3JyeSBhYm91dC4gIEl0IHNo
b3VsZG4ndA0KPiA+IGhhcHBlbiBldmVuIHRoZSBndWVzdCBpcyBidWdneSBvciBtYWxpY2lvdXMg
QUZBSUNULCB1bmxlc3MgS1ZNIHNvbWVob3cNCj4gPiBtZXNzZXMgdGhpbmdzIHVwIGl0c2VsZiwg
aW4gd2hpY2ggY2FzZSBhIFdBUk4oKSBpcyBtb3JlIHJlYXNvbmFibGUgSQ0KPiA+IHN1cHBvc2Uu
DQo+IA0KPiBLVk0gbmVlZHMgdG8gd29ycnkgYWJvdXQgaXQgZnJvbSB0aGUgcGVyc3BlY3RpdmUg
b2Ygbm90IGNvbnN1bWluZyBnYXJiYWdlLiAgQXMNCj4gYWJvdmUsIEtWTSBjYW5ub3QgYXNzdW1l
IGJpdHMgNjM6MzIgYXJlIHplcm8sIGFuZCBzbyBuZWVkcyB0byBiZSBjYXJlZnVsIHRvIG9ubHkN
Cj4gY29uc3VtZSBiaXRzIDMxOjAuDQo+IA0KPiA+IFRoaXMgYWxzbyBtYWRlIG1lIGxvb2sgaW50
byB3aGV0aGVyIGhvdyBWTUVOVEVSIGhhbmRsZXMgR1BScyB3aGVuIHZDUFUgaXMNCj4gPiBub3Qg
aW4gNjQtYml0IG1vZGUuICBJIHNlZSBub3RoaW5nIGRlc2NyaWJlZCBpbiB0aGUgU0RNIGV4Y2Vw
dCBWTUVOVFJZDQo+ID4gY2hlY2tzICJndWVzdCdzIiBSSVAgYW5kIFJGTEFHUy4gIE1heWJlIEtW
TSBzaG91bGQgZXhwbGljaXRseSBjbGVhciBoaWdoDQo+ID4gYml0cyBvZiBHUFJzIHdoZW4gZ29p
bmcgYmFjayB0byBjb21wYXRpYmxlIG1vZGUgZnJvbSA2NC1iaXQgbW9kZSwgb3IgbWF5YmUNCj4g
PiBoYXJkd2FyZSBkb2VzIGl0Pw0KPiANCj4gRGVmaW5pdGVseSBub3QuICBWTS1FeGl0ID0+IFZN
LUVudGVyIG11c3QgYmUgdHJhbnNwYXJlbnQgdG8gdGhlIGd1ZXN0LiAgRS5nLiBpZg0KPiBhIGhv
c3QgSVJRIGFycml2ZXMsIHJlZ2lzdGVyIHN0YXRlIHNob3VsZG4ndCBtYWdpY2FsbHkgY2hhbmdl
IGZyb20gdGhlIGd1ZXN0J3MNCj4gcGVyc3BlY3RpdmUuIMKgDQo+IA0KDQpZZWFoIEkgbWVhbiBL
Vk0gbmVlZHMgdG8gZW51bWVyYXRlIHRoZSBiZWhhdmlvdXIuDQoNCj4gSWYgaGFyZHdhcmUgY2xv
YmJlcnMgc3RhdGUsIHNvIGJlIGl0LiAgQnV0IEkgZG9uJ3Qgd2FudCBLVk0gdG8NCj4gYWN0aXZl
bHkgY2xvYmJlciByZWdpc3RlcnMgaW4gdGhpcyBjYXNlLg0KDQpPSy4gwqANCg0KQXMgeW91IHNh
aWQgIm5vdCBwcmVzZXJ2ZWQiIGRvZXNuJ3QgYXJjaGl0ZWN0dXJhbGx5IG1lYW4gInplcm9lZCI6
DQoNCkFja2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
