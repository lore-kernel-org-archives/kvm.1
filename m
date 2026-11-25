Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795628922;
	b=iw3EVPcGRcWuUkDrqnmjb9+YIaMgCDoah8wHSqR38W9Mlmgf8mbIRvVUPtQWks3IXG4V
	 9hBLxEILyTvFF2SudMY6WFEo0HnDh+HshqVBAe/kmjiA14qPvj26Z/XXsmpWPmhvhLzCr
	 FVDiso/mBVs1EOotvCnMXxEQOpVtI2lm9dHO2S/K0LlZBpp8+XbzM4kXnNT73o3jWfiSn
	 EqV+KBwrR2MjRAZlo/A1ZqEtNqwLi8h+2yS1EeuC4fOujR4bIga71cCNllxVKh4HsUCjB
	 N6HqQ5Wln5F5CNE0oS7jE9zXnpCceoCblo6ffReuJa01tdMRR9D33UdaIaSC4XcTNdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628922;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=X3SkEKFLRU0Kjcqw1BMzbBuv1AyjSNeTW+h+XpA2HaU=;
	b=3Yjao9+w2MPlIbm81oKCJkagHvlciWZY4RlcauOELt6JKd4J/GJjJKN/PAp+FOLFPsyl
	 zHIKLOlOSat6nX+RmrVnfI3fn6GvaHw1jEzsb5k2oZn2fg1NDYv4I/hFNANxgKn1Oa9CY
	 8hADojBLdIY0pIx9STNmm6ChiGkYO091+q8BHTzoZsXeOeQE3AWDFHJm/C2rg0/Gj3uqh
	 66xa2TDaMJVmV2Prid6mK5t3KyEeZvZu6mkgQURxPesS4SnfsgWo4tblSMLwEltiU/CZC
	 qq7H0XqPy1UmhxNov7KV0lWJOUmlbzZrkTUD+566tDDlT6991IVePqo+ozeRQo2/mYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ft4s9DgR;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=iQEPvjCR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556A606A323;
	Wed, 25 Nov 2026 17:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3556A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ft4s9DgR;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=iQEPvjCR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795628922; x=1827164922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X3SkEKFLRU0Kjcqw1BMzbBuv1AyjSNeTW+h+XpA2HaU=;
  b=ft4s9DgRL97+Nw1JsEFPgLIN3hmjg5iRlHzA2vE9J8x7Kj4cnoYLcPJd
   xpDA4CaorcZR6YqOzAEGbPmByx1mAnOXJ9E8hj7uTIGwQnMIa9UlpANj4
   pinFrXBgWqr7oK3MA/6ykCjp6UWEj6olc0cHH+JfdYoyUjxW4X4E2kk+S
   TZNMf20OIxbeVq2gFUFZeKN3sek1F74fjW2m/pWoVOKlhGoakU0NOWLAr
   oPNFYwRR6T+rGWbGGF29PEAkFdgpJyYCyyZGg5sx738sJU0oTlFXUwow2
   IB8iWw63sp61UR6We9Dzgzx3CNIMOzkKNreQ9uYFYXgJcuzH4ZLivH2oC
   A==;
X-CSE-ConnectionGUID: A5X2a4NWSCiPTHldvqf99Q==
X-CSE-MsgGUID: aMU56pEYQHW7SLKcdNs2MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4410733"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4410733"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:48:42 -0800
X-CSE-ConnectionGUID: z4kbwi6RTpK8W73GRg7ZQg==
X-CSE-MsgGUID: eAI+qCJlS1KykSjIfmpWFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12048330"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:48:42 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 09:48:41 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 09:48:41 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 09:48:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYcBipt83MPOC/NyGtibMfbFZqoPMH8bjioxknSeJa+aqr1fMpc/VDUXu7ZEcj9Pe0OSnS8X73oFWEa58RiKms2Lbddt+eKYQD0rhLDmnj+RXha8E/FRsBv/NnTmiMz99KSZqkK2fcq1T/4k0+NlmPSLEP94YkzAOOKUgoueiXa2+puPFoomKHp9qjx4uQg4jO3hjvWmHNF2UkljEWuKN2HblFLPtFot1HzG/4W+ptRgihI1cXnJWtV81aR1oZOedf3/Wg/n+qCgzBGCcKs2Pg2I/VNq+a/FwdPxigANZ4tSYhzxABMyF1TSIOR9vSvMD+CYmo0Pvb7cyldccpdJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3SkEKFLRU0Kjcqw1BMzbBuv1AyjSNeTW+h+XpA2HaU=;
 b=s5GbHFVrsUPd5IuOZ6KVthb/c12s60K5GrhUWSdBJrnWcQ8gwSric04Prpb1/1I1eOsYPFeG8gfrr5kwO9Ztwuj+1jXKDnc6SR5aRLElpDnuvyOFDFYPFaCpxj/alnbBf7FCUoFXVNfjVAZADNFDENNU9yhY+rnYZQHH7xYGLIXB0xMCRhFOhG3lqXYAap+tEQm/SqGXWUKPt5dfegxEWYJ9bSB0zFLbFUS9x8pxx2D2k5mAeOujT+1yULjgaGCAz4vTQuYjP0b/JDa2Z5dwYgTTmW29nSNn2kebjdna0l2y2eATn2AzSGyI3wlqhGI6KLkrrfOl1Z6eEDewGuN1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3SkEKFLRU0Kjcqw1BMzbBuv1AyjSNeTW+h+XpA2HaU=;
 b=iQEPvjCRkL85UdQX8g3lRlpLrb/Yt5diE5DNgaNi26hU3wNh2hDDl2q0xuLlAJbPvpINlnHyR0N7riuFDdkaupZ0GGMER+xX8JhwghcLCNWhoNEJPhf1vTvNi+paCtH7P4idPc7VrnLf8He04ImJ0Mco0l1vdaKXPFxAO9M6scI=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by DS0PR11MB8134.namprd11.prod.outlook.com
 (2603:10b6:8:15a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:48:36 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 17:48:36 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Peng, Chao
 P" <chao.p.peng@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Tian, Kevin"
	<kevin.tian@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 3/7] coco/tdx-host: Exchange SPDM messages through DOE
Thread-Topic: [RFC PATCH 3/7] coco/tdx-host: Exchange SPDM messages through
 DOE
Thread-Index: AQHddbsG4n2S6MqLX0m4Tb4pbEPdr7c8YqCAgADH/ICAAKjLgIAA7ZMAgABd9AA=
Date: Wed, 25 Nov 2026 17:48:36 +0000
Message-ID: <d4783f8c5df1823aabb4b0a1510f52cd1a731892.camel@intel.com>
References: <20261116111037.3478844-1-chao.gao@intel.com>
	 <20261116111037.3478844-4-chao.gao@intel.com>
	 <4f832b3a73bfd4d9b74e5e68a08f0de5659e1b6a.camel@intel.com>
	 <awV7wYVv4D_Egns8@intel.com>
	 <00efbba7a1b2c6e61cc36bf709718da978eec85c.camel@intel.com>
	 <awbQpM4QlKTVQ0f8@intel.com>
In-Reply-To: <awbQpM4QlKTVQ0f8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|DS0PR11MB8134:EE_
x-ms-office365-filtering-correlation-id: 58769a21-bd34-4f0e-3040-08df4b1c54fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|4143699003|56012099006|11063799006|261022105027099003|261026140227099003|261028144727099003|261026121527099003|38070700021|10067099003;
x-microsoft-antispam-message-info: hnXVRqy2KE4omheikJVYPAwKsyc7bqg9G71v4ynVYceA0VGFPXtjKVYA+Qbo4B4Noy4GilEsZS8jiFjtiLJ8afljjwKu7hJTb/rul/bOrui4mrcRJPIIF3RznE/5m5Q/qTYGH2oSTCC/CIO73UGhvr6jC7qln0l7jyiXn1YaEQDnnNOlpy1Cu5DKVHSXFTt5R/aP1mW1puwp6Sjrq8pNvWX/9ei/qC/HJFjZGjYhg6aZ0wec7Hr/n8JTut4TNqMDIZTtFC/6AYc3NvxSh2Ljd7tkz+AWUQOEEU6TeC6Qggk5czfG745Ld+nQ16c/r4DrfliZngDiufONH7Wt0djX+FCLnJJM8E/Ob0cZM1N17d3QXYNXC6oN6tJUvdDcYupz8GJwIWiaKkG0iQ3vGFB6fDBmnWPRO6+a7BSnXfLd8t7L6WRA5/nApeLDMD1fp4L4CQglpsOAhabvwYqjr2jeInXcn4DKCR6J4ZUKLCYRuovQubh2mYXw+tWzrBVr52WCNiD7TeukYId2Y5aVT2JnxJi+HKobqZPes+Sz2ESLN4tLTo8sJtz/CKdQEAOHrvQM6TbIgqwVTRk/bb872vle+pl98uPolwfhLzjmZbmFEWOxJu0Scmj2v8Y80iMLegs3e9NA/1PoccjwXFFzZCveMdRcVpAMi8n2blGHBwFnUvSgF1JTHjKkyRUp1deubbPMupm3CZbdaCVsYytpkBHp7uRodyJ8sE7wMxRee1yD7G0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yy9xWEVEaThIcDZSK0g4UktMS3NGY052N0RWRXVGaUFOWWdSaGpncFRVazE4?=
 =?utf-8?B?OGdvK1JJSUJyWFBQWVZNRWpMTXdqRWdXZkpDbVN5NDBrejc0RmZ2YUVlb3U2?=
 =?utf-8?B?cFBvS1poZytEVUpaSlRCTS9FcnA5cmVpdDl5c2lveSs4WFJGOHdFdWlQWXNn?=
 =?utf-8?B?NzJsSWN6UUxzejJJaW1OWWRYTDE4SWhKbW9LWTArN2FxRStaaVNSckJ4cURM?=
 =?utf-8?B?NEh0VHdlT25RaVpyWXc4dFpRYktDbVNrMkNoTzYwWGpoeEdnai9Vb1BhWGhl?=
 =?utf-8?B?c1kwbmk4STVSeDlodWxoTXVWOSt5MzF4WmVsKzhqSlZ2emV6QkJOQXFzdjZV?=
 =?utf-8?B?VEtEQzZRem5Fc0J0bzM2aXVjSVlJcUVQY1NwWHlqKzA3U2ZNOVlpYVdlOVJK?=
 =?utf-8?B?YTlvKzN6NjE2Q25VL1V1WGZGY0ZsMDE2REdWeC81eXdRTmxQYjdLVGdmU1Np?=
 =?utf-8?B?cUNYMythQkRmaTV3Rm9UNUhVZGZMbzRycnZ4eDcvd0V4cVZYVW9DMmROV3Yz?=
 =?utf-8?B?SEFZQ25EZldlSTJKWU5DU0d3R1FUK3pEZFJSV3VCOXEwVlhVUGxkUGRaN2gx?=
 =?utf-8?B?T3hKNytHQnRGNXIzWndNcFZJSk5EN2szNXg5RGtwQWYvc001cmc2enJhbFJh?=
 =?utf-8?B?R1pqZkd6VW1GQVROZ0ZacTB3UGFmcEpDcEZMclJpdjlCOTY0QkRDME12YVVR?=
 =?utf-8?B?MkI4YTc0UHlmaUlKVzlTWDdIM1dsczVxaXY5ZzZjSWNUZFJsTXlNTEJFSlhQ?=
 =?utf-8?B?VjZOTkcxUVFFWkZUVlA5cjhxVExYVkRqUGJWQmhOL2VXOUdrZkc5TnNWUGEr?=
 =?utf-8?B?N0VBcXRCbVIxUzVIV2Rab29QczNtOHRXNWdRYzhrVTJQMlRsK3BLZTdWRFFp?=
 =?utf-8?B?elREeFpTUHYvZDQ0TjBvellDV3BGZXhPOGUxaTBmOW01TXVqUDd1MDJNQ1hl?=
 =?utf-8?B?ek5UYVlwc1l0TmFXY2tROEdmM0FwanpibWR5a3JXZ05Vb3prbDZQZDdZeCtC?=
 =?utf-8?B?di9lb3RQaHM3bGpETXRFZnhFRm0yay9zYlFqQVdjMzJaVUpVSTRaN0FOMlls?=
 =?utf-8?B?MnlMTGRKNnBqT3FEWXlaN2lyQ1FZQ2Z4MFRIdSs4VDcvRGNhcjNpTEFKRkJB?=
 =?utf-8?B?NkVjaEdURU9QdGFRR0tzTzBjY1llK051ZS93UjE1OE1XSnF6WWV1RkJwWG5s?=
 =?utf-8?B?VEgrRS9sS1BvSGhNYTBXQTZGNmFqS3NybGtDUDhhQUJ0SVpOZXpBUFNHN3E4?=
 =?utf-8?B?dmI2TGhJdDV4WGptTkxrUUk1YThoMEZkd0FnU2xpa3AwVUJEU2JsRms1Zm1B?=
 =?utf-8?B?R3o2bHRCUXZhMTh2UlFNTmxhNDdJTGx1a0kzMFdVU3VtTnpEejR2c3ZIRTBB?=
 =?utf-8?B?M1BzNE1vdVVVU08rOVE0NjVPMXB2SVVUYkEzUnhwcmhLK1ZucW1GS1BYUHU3?=
 =?utf-8?B?amJZcUdRSDBYYVpzRWFqdjFxMFpnNTBVanpXaXIxdkg0K2hYRDFscHFzUVBE?=
 =?utf-8?B?dUg1T2M4Y2lBRnJ0Z3hwbFBSNUQ5UE4wQ3Y5Sy9WWGFyVklkTWJMTVFweks0?=
 =?utf-8?B?aXZwSGtGeXY4M2M2OXFRbTRRQUJlbVRTcm10dnZIU3RTN0RxQ1c4cXU3Ny8z?=
 =?utf-8?B?U2tsNDJqSWIzMTNSNjEzeVJySnI5TXlrT1A2OGVyUy8relRLQ1RucjRhcUNv?=
 =?utf-8?B?eTh6aVhpVjRuZGZYK3BVVU1TdzgzMEFrYStqQ04yZ3RoWlBmOEgzejBHMXV1?=
 =?utf-8?B?a3RUYUNRZnBHUVp4Vm5wSXNJcmM0ZmZkUyt5RGhyY1hNVzNYbEZ2c3M0RkU2?=
 =?utf-8?B?WlFVamR0aVNKTkh4NWNwVlIwUndLa3BHSHp5TG9vVStPdmN4VW5jRG12dVVx?=
 =?utf-8?B?bTkrcVJlUCs3WlpRMlFCaU1zV05RZW02bWE1Yng1ZGY3ci9kOVBqeHNxUUdB?=
 =?utf-8?B?TEN4Q2xiMFdZcGhRdGNvVlVFQ3BkbHZmR050YzRoNkZLU2NCV3RXYzJsUVZO?=
 =?utf-8?B?WDBTYmxkYzJZWGJoN25jYUxQTm5zdUZjQW9scTNCTElRakVGYTRManVCUTV1?=
 =?utf-8?B?SEdUeE5TN1ZvNStPMm5ZZ3dUMEVBL2VHbHVyZ0dLMXBRUDNSSmNiSmtHMzQ1?=
 =?utf-8?B?aERteWZBb0c2eFdFSmFTYUMzcTViakFta09qMUg2TXIycTJ6dS9NSnpGOG5G?=
 =?utf-8?B?ejZoa1hBNjlUVEE4NHNaWnBGUTdhd0hPZFYydGMvYUduYklpTzNkL1hDSFM5?=
 =?utf-8?B?dm9SclZIODlJVUk5ZGIveW94ajZUVndQRUZsREQxSzhaSVFUZ0ExNzdnTXVy?=
 =?utf-8?B?am9jK3dEa3lJNFYwTFpLVEFCL2F6U3hSbTEzVWIwdldsYkJIWjdsNitmUkhy?=
 =?utf-8?Q?vHirKRX8kFPADOSg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DF2C88C108D0246A053400CEEB5E260@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: E9p3Sd7dDGTbIzDC8TUvqN2YW0TQGwi6XPtTgVi8o1Q2jOJjTmVAUWeK/fHfrgDFmXdhWdpc1eqAFdgLfMo2eLCs8G78A2jZoLtdgaW47beYojMbrq7b7bY2R0EFJHqkdzUkcz3fMrg5lzXipmmlolA9etIOm3HZjek+ERADfCMb/kuyqKgJrxxRnN7Ns1NbcQxXISjQ7+bn2jphkNK9iLKu34qpNk19tp5zeI5g+JjSR5egodTQ4fQm6fYKg4iyYJlesXtmNmvTwjot8b2RslUQsYUipZnc0pmxD4JqVz203N9N2+01SjLKcr25xICuwqqpQw60gLWOUkFGCFzrMg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58769a21-bd34-4f0e-3040-08df4b1c54fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 17:48:36.6374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSqmu0NmGnK6wI3AZu7Oaaq2ZZfW+V0kaxqrOOobfAi118opIJ2+C0nJSNQ4bZTEbrnadWK5PQQ3xiU1nhz9qMq8EC8H8zgEUo2iilO+hk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8134
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTExLTI1IGF0IDIwOjEyICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gc3Rh
dGljIGludCB0ZHhfc3BkbV9tc2dfZXhjaGFuZ2Uoc3RydWN0IHRkeF90c21fbGluayAqdGxpbmsp
DQo+IHsNCj4gCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdGxpbmstPnBjaS5iYXNlX3RzbS5wZGV2
Ow0KPiAJaW50IHJldDsNCj4gDQo+IAlyZXQgPSBwY2lfZG9lX3Jhdyh0bGluay0+cGNpLmRvZV9t
YiwNCj4gCQkJwqAgcGFnZV9hZGRyZXNzKHRsaW5rLT5vdXRfbXNnKSwgUEFHRV9TSVpFLA0KPiAJ
CQnCoCBwYWdlX2FkZHJlc3ModGxpbmstPmluX21zZyksIFBBR0VfU0laRSk7DQo+IAlpZiAocmV0
IDwgMCkgew0KPiAJCXBjaV9lcnIocGRldiwgInNwZG0gbXNnIGV4Y2hhbmdlIGZhaWwgJWRcbiIs
IHJldCk7DQo+IAkJcmV0dXJuIHJldDsNCj4gCX0NCj4gDQo+IAlyZXR1cm4gMDsNCj4gfQ0KDQpJ
ZiB0aGUgRE9FIHBlb3BsZSBhcmUgb2sgd2l0aCB0aGlzLCBpdCBkb2VzIHNlZW0gbXVjaCBiZXR0
ZXIgdG8gbWUgb24gb3VyIHNpZGUuDQo=
