Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF3612B94;
	Wed, 16 Sep 2026 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517185; cv=fail; b=SeZT5bLt7sm+Wm5XkHaUkYW02sxj7be7ODzCsExEm7aL9pgUplnhedB+PqlNCPvI6C0+CnILEW8fWV4ch7aDilAzq5MQU/76eTPbWcjTEeQRM/9y3OISDsh5Fu5e0R8tQyOfOnsW5n7HG1zGh5Ju9QDaL5wHIs2XwhR/gFTLYWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517185; c=relaxed/simple;
	bh=yEhp3kKtjQHd5+qZiuG5Ui15IY+p3WDhAzuspIKrWxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cPh+qjZ1xVdA9vdXaldXpXKoQwUJU++rMLqQhPtNeSHjE+/dqCoR1j9rN2Vk/2amJlD4w5t4tG84o7k10Wzg27ClH/9ySXngkxNoxdiDvw4CeURN+2rh8mkXFhjDtzCkh28v0NWXVRQ4Wiwk4EjEXIIG0Ucj54ZUhSROIeCXSqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVLZPYdt; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVLZPYdt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789517184; x=1821053184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yEhp3kKtjQHd5+qZiuG5Ui15IY+p3WDhAzuspIKrWxE=;
  b=jVLZPYdt7nJseoP0bl8OhIao/q1Y6FKOg4t5GN3Gs36KfTAwVGw1jBaX
   39ZUlGPANd0Nh4HopE55zuQkxnXgnWafCdp5XO43dXz6B0XZIoJnl0hwF
   c+jtHvSaZ7QK7Z2A68tV/AuJ30wV49NDf0Q1xMDuouZepLxFXwFbDsdUF
   H0gPvG6RnVEEJM5C9gz2UmMYlg5c3DwXFwTwc+IV02Z/IWBZ2Bbu/j/n9
   SoluIEU1blqHKqZqaH1prFEyamy0yvsdnQaA5AEKBehPgdjeyDi3Owcfd
   JoQHi/fRMwCf44cFGxjgziMRUyL9y0LccUm2DxGwp70v6DtQtIni0tLKH
   A==;
X-CSE-ConnectionGUID: le7StAs2RLivr1TIyz1WvA==
X-CSE-MsgGUID: E2SiwlTOTRS1M8uz1k9U4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89935699"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89935699"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:06:23 -0700
X-CSE-ConnectionGUID: 6TKFr5K/TuyfD0rwD6rOAg==
X-CSE-MsgGUID: y7qMsRJVQrSBwnVAJU06cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270539427"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:06:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 17:06:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 17:06:22 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.68)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 17:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlHyr4h40S1jVv+K9CpACwfTOsuvxsMXF0vm5IU7cSdBTrXcvuBONaaJYB1fhiVaQ6yzmr66TGQCUcUvEaPjinN8XZFL5ugON+tdq69tlClLLvTISuwQ0y5+4sC0pUSgdNaLmzIS4RxtXMc1Tdd1s31K6Ef8AD97deQkxsBxaGnhBU5Vz0hFI2TVuHzjHCGSEs3RJm32G5Fa6+SIl7lluujdktAcwDqPn329eJMoaKdcPLGK4ywAP0+RAaaMu34Wc55ZH35EZYVJJ1NqIZkMu3zXhE9dT7lgU3auBKzmwOZi7qPKYBtlGxOSIwY+r4HUQ1OuFz2VhvJfTCz+jh3sag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEhp3kKtjQHd5+qZiuG5Ui15IY+p3WDhAzuspIKrWxE=;
 b=I4xrUU2mBg/MF1C4jlrnr4Z5Eah7SsOelOiNcP+1FIGPCV9A0TFR6uOwoYwRfHArFdOqPpFBGPcmAZ9PEEd++MOlcuyey/kvwhnlqZ6N2cwq9Dnz1GF60CXkiBEHcZErfMXRBuLzWwnLmp/P65848/UMeib5q07FbxIqG2fZCNLcGhcCo3in9TiEAvcLWG6jt0jHc6xcIPQHYzjGIA9EId/wf8eK2y6biimWyaRVzkDDAV1s+jrZrpOx952Xz6HQepHODhQ7ShrpLTVsh0eab7iTGoUp28bHJu9VgEsN7CM/8lP8Ak9A/KryK5bEG3D/LU/dagizjLUi3NF/2lTOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB6053.namprd11.prod.outlook.com (2603:10b6:510:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 00:06:14 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 00:06:14 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v4 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v4 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdRPRpGgpLmgOIuUaxLUBjd8KBF7bPrRqAgAAiuoCAAHNLAIAAEVaA
Date: Wed, 16 Sep 2026 00:06:14 +0000
Message-ID: <d071ce6cbb86cffba21ab7b078c3bd0c18fafd84.camel@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
	 <aqlRETiO58SWjFLF@google.com>
	 <96c33d465635c1858b943960f09ebd3bf82d31f1.camel@intel.com>
	 <aqnO6spgsfN1UsMU@intel.com>
In-Reply-To: <aqnO6spgsfN1UsMU@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB6053:EE_
x-ms-office365-filtering-correlation-id: 8a4eb765-5112-4d76-460a-08df13865297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: cPWB5J8RSwvz97JeX70HpQUp9DZs2aNZlcPThnLg614V4A+hSMCycxxAdpVDoJR3pAhBji9mI2Q+61bVGfZTiYvkBYDg+qqQkJR1+PQm1YYlOyL/KhzmnSOaa4+d5H3NsE/cW8FwaQ0rXakzqmCKhpoy4NWYnurZL4AJFPcXikkkbm9WGOx73iDm39k2a279Ci4nXj6gDDRF1PAbWVmDZMwZZeT5Hk6gJQoj8+sUMBIm7UX1JmLa6RctVU3/h9+W4u7KTO4pNoxRikywu3aByJMa2m+15rIXnJO2bi+cEFJ15+o33tg4A9t1h3uHs8txSqivWBa0Abs+R0/SsV7av2wsaYTLlFRZccuA/G0q2fIYaQALUGiJTg5HY0V+ZMQEqjcxGgJyZzPO6DMYRXf623pHdoaKnS8taY2PdK+yDdlZ1s26SRjnNfN3DiEbftErbT+95ptcR9wp+pX1efTY0aDAqKAPrUwljOvuVXSGx0xJSIv3SIcR0KRgUjwAmoM1I2dudHIewYZWG820RtroS6ZbTATxTP1B+ZxYgBF1IpvQalP5m9GgbVIKLdDcQyD7hstaW44ZTtdZDkx1ibv/SVeTfP+JpS7dc5/oDc+T/M5aFQDJcuUMrYFPyXFk17ru9HguviuQp82rwPTt1/rS7SJUGZO7ybKNywEI+B3chhTqg7zgwlpuS2jST2zg83BYUYMEdUrgpbSTk26LRqamUT6m9bShcFSQ5RhSiv8i9aU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2pjVVlpdzFFZkhTdG5TM1NsaXR0MmE5RUhuUXBxbE5VdGwzdnB4aDdEVjlB?=
 =?utf-8?B?TU5DdHlqd01Gdk44K0IvL0FWYzFzcjFJanI2TXhVOG5YUUROWHlYS2dQSHNr?=
 =?utf-8?B?ejN4Y28vZW8weTkzUEZaOGlIeUhLOVRmbWZET3hHUEQ5MVVWb29mU0hJSTBt?=
 =?utf-8?B?alpvQlFSWHZLcm05NEs3eXltcjVTVmlFN3N5QVVyWlk1ZlhxMzdZUWl5MVdG?=
 =?utf-8?B?cVN2T2taTHNIa3lCTnpOc1ZBWTdBODNVOFJkcVp6L3VWRFpJaG5KSGpZNjhr?=
 =?utf-8?B?NFpzZG4vZ1U1YkZMcXU3WXVheGVqUzhLU3psdFBLNW9pSzJCMGVaS1JMaVFY?=
 =?utf-8?B?a0hKVGlIYmRsZDNMaGsrMUpSS0JxNE1WNDcxazB1d0Q0L0ZyRWtGSm0wTWpz?=
 =?utf-8?B?U1hJeVBZTEIvNURsMmNMZnZMLzRsV3lUOFpSZkNUMDBLbEgwaGhPQUJ0WVAv?=
 =?utf-8?B?N2hWZFVlTHVJeGZ6c1ppTkpkRmsxa3M3eU0vUWVJdTRtVVB0RDJhZ0pZK3FF?=
 =?utf-8?B?enRCOWdOMFdkb1p6OW1Ib3N6aW1lUWUrMXlidm84TlAxc3I5OEdpQWEzRmtM?=
 =?utf-8?B?eDNsUWxkZWQ2MlNUWUloZHVQVVVOMFJ6aW13TGRQaE55dzg4ejE0N1N1Ykpp?=
 =?utf-8?B?NXRnVE1zdXZ6SGhNNjQrZUdOdkF4SzB6bTNmWkl3ZW5mTEN3MHliRTJ1UjIx?=
 =?utf-8?B?dEc1bHNya3YwNUVRZisxSTBKR2ZhV0pTc000bk5ZRU1xUGU2MmFSdXh4OFdt?=
 =?utf-8?B?T0JCZUY5NWF1WXdHeUZPTjVmNjlvWkVLRXNwWjJoeFpYZmN3TGhFelV5NG9s?=
 =?utf-8?B?OUt0V0p2alBQcitRcUN6WW5WcTNlR0o4UTlOSGwwRDd6YWs4bXIrU3E0RXVP?=
 =?utf-8?B?blRidTFRUVNEZ1E1eXF2aUVBV2xFSVVYamttZ2lxcU1jNFJkdHg2dld1Zlkx?=
 =?utf-8?B?Y2hWOExxVGhTZnJZc2UwMEI2b1ZqMzJJVThSdkpWUzVGRkVqVG53ZFhqeVZv?=
 =?utf-8?B?d2txL2x5c0FaNlBlNlhaMVJGcmhqYnBkQmJCQ0hva0hIZzVySDl1aWU2c1Qx?=
 =?utf-8?B?bXZBU0djR3BaQlg1YmNIY0Fidjh0TTd6ZUFUL2hYUjhmaFNtbUtjUzltSDZv?=
 =?utf-8?B?bUtURGcwelZkR2wyV0oyWXB4Z00vOFlRcVROaXllQUg2TzBGM09lcEpMalBP?=
 =?utf-8?B?eHBQbkpYQU05MFU5OW1FeWdJdjc2dnVGbjA0SjRyWVB3VTNYeTgzYWxQcnRT?=
 =?utf-8?B?SGVIMEsycVNoZll6OE9kSWpIYWFOWTJTd2t3ZjNHODhGbEFQcEhZekJydm5D?=
 =?utf-8?B?SSsrY2M1K3NjeVRBTHAxSWdkRXRZQkJvaTl5Q1FXNUY5TDVIZ0U1bEJZZ0Fq?=
 =?utf-8?B?a1ZySWtsdEVSQm1Xc0l5RnRYK1lrbGZvQ3VUM1FCRTFlY0xGazZ5Vi9FR1hI?=
 =?utf-8?B?WlNWQXgzbVZjUkRlYW9uVWhNT0srVGgxc3JzaHFYNXFkNzUzRERWbkJJcHlR?=
 =?utf-8?B?ZnZrdm9MaTRQaEMrdm1QeWRJR0k3dHQ0eGRkaTE3ek53aHBJQ1JHZHhaODRN?=
 =?utf-8?B?SWJybldrOHFVNDJTaHJ0MEdPSG05dEZFSi9Oc3BQcVNQUmt1WG1ya1JRbThp?=
 =?utf-8?B?UW9YL1diUlU5UUx5bkxVcm9KdUl1cndwY24xVm8reERQOEpNM1g0RnhhMkd4?=
 =?utf-8?B?YU9qT1R0UG1LVm5BWUtZUXgrQXdMZHA4eUdMYmFmVUVpQXZnSVkvZVRUd3FK?=
 =?utf-8?B?V3dFbnJnOTJhMVdLc2JQdnBwaGxtVEVCNlZrVDh6UVYrdklUYTd3L1M3aHhp?=
 =?utf-8?B?eUNYUEZySkxwVkJkL3lYU0ZkNW9jaXd0KzRFdW9XU1hXRC9rZytZV2ZRRjMz?=
 =?utf-8?B?cThadUFqZFEvakIzMFhtdU9nYnNHcnhTbXJaZ2pnMGNuL2E5NFBnUU56anZz?=
 =?utf-8?B?c0dUd3M4Wm00cENoYjBYdU9MQW9pc3RwOFdLK0x2b0ljU0VyZm41YXhaSHBY?=
 =?utf-8?B?aDVlc2tXWldyS3JIOElCeERWMVMxaHdaMGUzb2VyS0ZCdVM3eWVkU1Z4N2dE?=
 =?utf-8?B?VVZVMU1PVGVsc1FvVG1pUGxTM0lhc3BlVVZFNzd1VGcwVmdnRGR3Q0NWWU9B?=
 =?utf-8?B?OVNlaWJoeDA0cy9YTEFCNElKS2hlYXF1bE9Mbk5JMzJiRHhhTnhLd1dnd29s?=
 =?utf-8?B?dG14QXFvRFA1YkpjakMvV2JWT3A2QUtVR1ZkdWRYZFhoQ0paNWJNdXZNTi9m?=
 =?utf-8?B?WVR1V0xUR2c2S0VOeTlOUnViYVJwb0tPYmFSbnllVnViakVPWHdXbWJDOTZE?=
 =?utf-8?B?QUdOWFhZczVtS3VzOU5PVlorRy9reVlTSWtEMFprRGUrL3hoZTRxdkRXT3N6?=
 =?utf-8?Q?XQyf7L4z4b4thSnY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <972BCE999C29024D9B2B3A3D1499F240@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Yyp8WF/xSui8BK3e8OpZgTsIe8YdV+u/5TlBiPC8Dg5MAvSf9mScrzGEwAc9ABnhc2qpPpjhmbF9esYr5P/LuDVYVuCzckIq6QEIjLXJwiZsjH6sWH4JaS5Y35AvN8LY6k7W1si+7I3nz62J+HWJDV614GQo+kqDdd/BbwiDveDmuJkzoNXW5iGV2N3i6JSg5v7AYYaCus6Yz1qe8HyAykbydj+mbnnpsUgTkVAWt8gfZyUhkGg1Ahjvg2UxIZLMhS51MUJXLubL2C8jhA4YPxcAR7+2mislHxFpRPWxxDXCGESgwKopMC+WblHxPMw4B2NTgQrbTf53U5Jr4O2uSQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4eb765-5112-4d76-460a-08df13865297
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 00:06:14.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8s/T7sQ/FdnOJz8FfUFomXlw+ID+HA9SILi/+pBp+l4NxG6Q1nKNRtuAv1nAS1ZQ1lOXJkOb3/xnc7mGempuFpRail5267TsHfYNKixZTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6053
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDE2OjA0IC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiBK
dXN0IHRvIGJlIGV4dHJhIGNsZWFyLi4uIFBhdGNoIDQgYWRkZWQgdGhpczoNCj4gDQo+IMKgwqDC
oMKgwqDCoMKgIGlmIChxdW90ZV9zaXplKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLyogVGhlIHJlcG9ydGVkIHNpemUgZG9lcyBub3QgaW5jbHVkZSB0aGUgYnVmZmVyIGhlYWRl
ciAqLw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGVuID0gVERYX1FVT1RFX0JV
Rl9MRU4ocXVvdGVfc2l6ZSk7DQo+IA0KPiBBbmQgaXQgaXMgYWJvdXQgYWRkaW5nIHRoZSBHSENJ
IGhlYWRlciB0byB0aGUgYnVmZmVyIHNpemUuIFNvIGlmIHRoZXJlDQo+IGlzIGEgZGVzaWduIGNo
YW5nZSBhbmQgdGhpcyBoZWFkZXIgaXMgbm8gbG9uZ2VyIG5lZWRlZCwgdGhpcyBsaW5lIGNvdWxk
DQo+IGJlY29tZSByZWR1bmRhbnQuIFRoZSBtYWNybyBtaWdodCBjYXVzZSB0aGUgZHJpdmVyIHRv
IGFsbG9jYXRlIG1vcmUNCj4gbWVtb3J5IHRoYW4gbmVlZGVkICh1cCB0byBvbmUgcGFnZSksIHNv
IHRoaW5ncyBzaG91bGQgc3RpbGwgd29yayBhbmQgd2UNCj4gY291bGQgZml4IHRoaXMgdXAgbGF0
ZXIuDQoNClNvIHRoaXMgc2VyaWVzIHVzZXMgYSBuZXcgYWJpbGl0eSB0byBxdWVyeSB0aGUgbWF4
IHNpemUgb2YgdGhlIHF1b3RlLiBUaGlzIHNpemUNCmFwcGxpZXMgdG8gU0dYIHF1b3RlcyB0b28u
DQoNCkRlcGVuZGluZyBvbiB0aGUgRElDRSBkZXNpZ24sIHRoZSBndWVzdCBxdW90aW5nIGNvZGUg
bWF5IG5lZWQgdG8gY2hhbmdlLiBNYXliZQ0KaGVhdmlseS4gVGhlc2UgY2hhbmdlcyBjb3VsZCB0
b3VjaCBMT0MgaW4gdGhpcyBzZXJpZXMgYXMgd2VsbCBhcyBvdGhlciBURFggZ3Vlc3QNCnF1b3Rp
bmcgY29kZS4gQnV0IHRoZSBjb2RlIGlzIHN0aWxsIGNvcnJlY3QgYW5kIHVzZWZ1bCBiYXNlZCBv
biBub24tRElDRQ0KZXhpc3RpbmcgcXVvdGluZy4NCg0KSXMgaXQgYWxsIGNvcnJlY3Q/DQo=
