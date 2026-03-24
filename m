Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AE63E1CF7;
	Tue, 24 Mar 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349135; cv=fail; b=fKQh4KZV6p/IepkHvVAiQDAj6hQWu4J5llV4gWyAyE0ZHeW7HnMjsYVekbxNOXwDwqA7QyM2Hb8k1MXLB1Qi+dXiVph5vQZSv4L5kT3WCiMb3ng3BS5lsvecwZAROtCZ5LGedPBtkUSnkT0V6x1gM1HLoIXyE9SVQyqHMT/ulKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349135; c=relaxed/simple;
	bh=DvF1VbvMWm8OH0ukPAh6oRVCoGOJDhMGnxRgJgHPl4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jmJeYrTmkvjzZxkOeOjtxFjLPJ2MAQVCR1ahktzRKI59aOg1e9swNEZFoOYMrP4zVSaObY4QH9VvDQU8Id2JF0TQelnmdAcjhNx8tLoJ4fQrOxIxQ5h65oroB/AlT5eZAWFWIEUgLONqjpr27vgBr7ZtxEkQs471skIpPPgyWq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlmPRRwb; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlmPRRwb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774349134; x=1805885134;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DvF1VbvMWm8OH0ukPAh6oRVCoGOJDhMGnxRgJgHPl4s=;
  b=jlmPRRwb+sevJTNeXA5S37RNQNDL9rGx3sqg+rkERVyFrG+INuDCelvC
   u5yJbwiFIhSISX5OTDQxBSMl97FZndHHBjTjHg0vqT8zfxekTtdSZ+9EX
   beIrVtF0g+lzY1hkhZ4fw1Y6n1hKq2q+LDsFgMF8+UQuM0wuYnnpbj/Ov
   gFWSwlkITMIm6A2U/NxhrxkmzRGVJhzkxrmQ4Jba1Ihh/mt6cUDUsHGvX
   dj3yIQ0y0M5gxyBUjFktIAuxSaDE87TKzhagp0u6MADdYSPVEksqiHTHb
   oFutARvMtlE1ltQmK7W0C9+TR4hBNJpgW3mVSRP3hNvIL9S3lWUciqymJ
   g==;
X-CSE-ConnectionGUID: yEvR197wQoC7atKEAKedsQ==
X-CSE-MsgGUID: 0zOBxNnMRhCGda0N7GRdrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="97979389"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="97979389"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 03:45:33 -0700
X-CSE-ConnectionGUID: tKlCvBQiTNW1oTcK28y/eg==
X-CSE-MsgGUID: UGKr3IW2QVSKdLiiLhxG9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="262241869"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 03:45:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 03:45:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 03:45:32 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 03:45:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXxpN3oN0Z7izC3wSrvUqrTJDrphBLumCTUiJ81GJvurOu8WWTRAiXzvxHfUkoK7vInVLE/oCj1g2xfZ8ku/jVbRYFSuVDihY4UjD1XF/eLOdWD31r5XPfai1ftxa/GD5ZB/6r2T8AZigbyXCgyHSqM2hC02phm7t2tqAYeZa8epzjDP9SfrcUlzpVI/EwnwOpM0k/PTyNy1HGTAzxSKp2Ee6QyuTCdK3jukJ5xhyDHFL/6qPcjs7CwAwa4UFakaUaeOdJYGLBK7bZt+A9xjqKmwfH+AuDjzvTDHUjWi7RwXfV7wEOlljOClPoVTj1bdt7VVZcr5nyVqUVM8uMGEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvF1VbvMWm8OH0ukPAh6oRVCoGOJDhMGnxRgJgHPl4s=;
 b=NqixMPDl206+a0uq1eivz3qcg2dinvS7CpQfKMQovaYeNi3S5kDx2ApEsp2PXZgrUR+Rip85Xq6CAv06Q21tQuYy9GjrQS1+XQc/sCrnlDdrMKigdf+6wPYs65c25v9F90lNFl9JtZLwoqMFiQrah/4gZ/LFq3r2GSBo2Jrt6P/AOW9qUC4jzVBuyLai3hPCxte4WDpGVga7GOeaXyT7BCMQQgrY5xsoj0OZayG04bidMkZCh9r8W1RgsGi7knmBeRHs5RhqQBjZ04I1EmwCSR2N4KDkS/7GhioEATuiY1ms3qT6ADoKYt2zHY/thmykk9Veb0cYXVRS8XTxrxRM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 10:45:30 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 10:45:30 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "amit.shah@amd.com" <amit.shah@amd.com>, "Kohler, Jon" <jon@nutanix.com>,
	"seanjc@google.com" <seanjc@google.com>, "mtosatti@redhat.com"
	<mtosatti@redhat.com>, "nikunj@amd.com" <nikunj@amd.com>
Subject: Re: [PATCH 10/22] KVM: x86/mmu: split XS/XU bits for MBEC
Thread-Topic: [PATCH 10/22] KVM: x86/mmu: split XS/XU bits for MBEC
Thread-Index: AQHcuMdQpQeIubAK1EyaerhA+hcZ2bW9hRGA
Date: Tue, 24 Mar 2026 10:45:30 +0000
Message-ID: <dd1fd2a2d5cb83d92d4064b44958e8315a86b68d.camel@intel.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
	 <20260321000931.1947084-11-pbonzini@redhat.com>
In-Reply-To: <20260321000931.1947084-11-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SN7PR11MB7137:EE_
x-ms-office365-filtering-correlation-id: d91decf2-8ae0-48f1-14f1-08de899277d1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: qXcOfIT2H4Z9rQRrAb2lDaO6b8rzSNLi9NSzAPZtydKm0p5/PjyrKp0bSzi9hjLeihuBt1d7vUbGtZysVPX8VtKDRjbD4Mxe4iTwXXIkn+o0wR1SM/mDawMDznSqouT7c7cltSVlvkWHBQLJDJD5MZw5rMe6HlLFr3Q5QpI5i/TFs1wISC0xms+4xgHJ0K7yX1IFp/KXBWTVSeqlFPpaXdJWTFbOd+IjeJ6rs8qhp2pTnoc8kdJ9kjEEssuTRll9o7ikdedvQ9PyTdA1ZKB1MKYu02Fsg9ek++0celwD3KHo/zP56JR+dnQqY16p8G1/tp6EK/nBkP0QVG3ef+MkgOq/dNJez3FBf38bHj6ggI9uOcPO0GuujsRTwVAMSOibvFiOaUE1R3oFaFHd0ywYjuY7j1oxmv692KniFQxDXB7Ki/8QzlIZd8ip4PRfmt+H9M8slg6EbWo9M8cOuz4zLYD+zjBY1BW9S3fVsJB89qdN8Asv+LT/WAANvetIsC0ic0dA8TZsvQtjWkvj7PioC3ICm6otfI2hXEw4p3dQoriyrvqC5FcE/h2RM7goFhHn2SwOF0Fm9UuQf/iV2vI5L9qy/RfYzjBX3dZotK6zxyx0+x0RzTVq+iJ8TLxmZiL87DlhBshdoGAysBvzqHSOvfTzpT6ksdGm8J0EwmOqyFFH7NMJI6A5cUc7Zw/Cs58HP5kPSOlvUOMKIGBC0e0dNh3ztrgcZHjB30M0fcBFIGfd6S7RYg8zfx1QLCv0EmELxn9rTbzMZpcl9MPo2IiQJV+BokCMYBFar3SPx6jVEkc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3Z4RGlVVWgvY2xMK1k4TzErRWZyNm5Xc1VNZkYzb054L2xGV1Q1UE9MdEtj?=
 =?utf-8?B?TFpkdnlBRVRiRHhRWVorNnF3TUduMkx0UExBeU5LazIvVjNvNkYyT1dZU3BY?=
 =?utf-8?B?Z0hpcHNTSnM3b2ZteUpGcHNrUW9OMjlaUXNkZnREdExoWmsrMUw3UjB3YnlJ?=
 =?utf-8?B?VWozR1BEWmpKQTFHNVpySEM0V1ZFWWNYOWFIaTdLaCtaN25DaHVlZGZWQzFN?=
 =?utf-8?B?Mm0rUUI2S09tMERRUFJUR0VNNFhqK1BSdzcyZy8zNEpsWENhdDZRWTZVUnJ3?=
 =?utf-8?B?MTU2TTZTcDdzVUxuQklMWHV3c2pVUEVnRkp2WFJTb2NJNXFwU3htd3draHFi?=
 =?utf-8?B?MjVaZHdtQ1lTQ0FFK2EyZU5FUHg5Nkp1TC8rN2xUNVkwb0pqejhqVzhRQmoz?=
 =?utf-8?B?c1cySUMyekZjaHEzUFdNLzQzb2l2Q29IcDR0b2diMXpkSkpnUklXZGdrODg1?=
 =?utf-8?B?Y0syLytpOUo5TnN3QzN5MGgvME44L3VuSFhOckRhQXV6VFh2U3FBVG4rZ1dx?=
 =?utf-8?B?S2FHWWxXTDNvL1ViSThtY3pqOU02NUtieEY3UjNUNXFmZ0UwRWo3d0plMGIz?=
 =?utf-8?B?M2xOR1E4SXlqWWJzVXMxbzBiZ3lFSUhKK2hJRWlINFIrNWVZUG5XYmhDMXZB?=
 =?utf-8?B?Rk9EN1N0K05PVVErRy9zdElXbHZUNnJDR2NtVkh0amdYVm4rNHBvNkMxMTRH?=
 =?utf-8?B?aFZBTzlNVklvWFRiSk5BN0w4YnA4NjlVbXhGVEpQR0ttU2pNajd2TWJvNWFE?=
 =?utf-8?B?RUdQQ2IxMlU1ZzlkSjNSeWpUaG5rYjVoSXZuZk15cXYvM2szOFhHSGhHbjNk?=
 =?utf-8?B?ZmZNWlJLQUdrbU1IbmE5ditnOUc2ZmtZRVYwdFFTbXFhaFNCYlJpRFFzSDZZ?=
 =?utf-8?B?ZWt5VkR6NUdmVy85cTc1MEZzaFY2OXdTaGx4a2YvT3VSK2o0blFoWklyVnB2?=
 =?utf-8?B?VWV2anZZaXh4MXJxMGl6cG9Ra1kwRXZmSGQvU3VFQ0J4NEQxV2o1ODJCQ202?=
 =?utf-8?B?NDE3MFJhMjFjeGs3cHh3aW9MdkM2VkpoSnIxWTNKL09FaHpXMk5aSzJQY1Bi?=
 =?utf-8?B?RWVFUnM1akhsemtIS0Fyd1dGclZwNDN6eE5iZFlrOGdhRDMxaksvNk90RVQ4?=
 =?utf-8?B?dWVpaGR3cXVMUVBncDBPSzZ3eDIrL1I2c0lPQ2NuS05RYTU2R2grcU4rd3VZ?=
 =?utf-8?B?dDh1NmR5emtSTVFwb3ArOHhxZTZuR3c0cDJ2QU5mSW00UStLVWNEOWJSU0NW?=
 =?utf-8?B?elg5Qkp2ZnlIWi9hanYrUlYxeE84WEh0UEcvL1BXS3Fkc0RQdnlOZitHOGxL?=
 =?utf-8?B?MDZaN3BXa1E3N0xFdlB4M1I5RG9nZC9xZjEvY0MydEV3NCt6ZFVYQno4Uk0y?=
 =?utf-8?B?eXJjSEZCUy9keFBxSGU3QXVaYk9NSHFvaDE2VW4xRXhsZThpUUROMVAyTHdH?=
 =?utf-8?B?TTlOYXdKNUdCOHhtV1RadWVwMnY4YU9kNW9KVFdiUVFWMEwyQWNvUk9lSHFX?=
 =?utf-8?B?Y1M0ckVsY2tFb2tOSDR5MkYvQ28vUTRBbEM1K1EyeGRnNzVQZ2xzWnVqL2hE?=
 =?utf-8?B?dUFZSEY3UTFNY05CNkhlMExwZlpQNjJNMlZVT1FZaUcyZUlOS1BKTEFxK2Fl?=
 =?utf-8?B?N2RjYmZVajY2VVRTdWhQK1JUcXAvYWhmU0duODl4T0JEWW40b29ickF3aWxG?=
 =?utf-8?B?Q0VRSmg3MWtvL21PaitoMHlRTTMwV0c2NFJFSzBJdllaZFcyWnMzaDBIN25E?=
 =?utf-8?B?LzdaZUJ1dnFUUzFCU2ZmcGdocitvUEp1MTc5WndjU29EZllaTnVFR2YwZnc5?=
 =?utf-8?B?SWpqUVNKK1l3V1Q2UXdwa2hGQ01OcmxqYzBqQVZqNGoxMk4zWXh4UzFnOFlx?=
 =?utf-8?B?TGtwM2tJTkM5bjR6M1pmR2VXa293ak9ENTlwTTJ2S21SZzNYenJKZ29lMnhB?=
 =?utf-8?B?RXNKVnprOUtESWVKeS9MYTFCajVIOUt6dWVZUEdkMWdNT2QxRVNzbSsvRlhY?=
 =?utf-8?B?Qi9UNXZZU3ZCUVVWMGh0VThNYnZ5OXhYSjRNYkgwZUZ6Z3JHTDQ5V1ozeW9a?=
 =?utf-8?B?ZU1vTzM3VCtzTFNJVjRXMSttL1hWUHhnY2J1K2l4ZDlIN3JPWVN5blhWaGRa?=
 =?utf-8?B?aUlGUU1yNjJoT3hJc3R6b1NnL1VQOFdQb3BEcTloRk1LdUhyYlVIOUZITVdE?=
 =?utf-8?B?eUVLN201eVFPYXJRVVpubWFrcjlNbFhVUCszOHVsRGxIWUZNQkIrczVCWjVK?=
 =?utf-8?B?RGxmSnFxVTFZNG5ReHl4U3BHMERmdnpCeWE0SzN5bWtZeTVEejcrbHpGUnlP?=
 =?utf-8?B?LzdoaVpDbm0zM3BtWWZOa1Q4Rk1YTGhGRDBLWHYrR3cwMTJlTXpOQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D42F617CE3182641AB57C33302E1BD4A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dB62ZhWwuEq0t/cd5LgRzJPLF4D8O2snBQxoq72GhEMhLBxWRWVN2K5ot1L44GBvcnbCHPete8mq18OaDWWt4S2/tLvwz1BbNq/QAtLzjZ5buVCelBjXBCWJGRmxwPvfFeCtPgUIPawWxqhmZMlIz4h1cK/Yi51I7yXHPWUePaRT1jzfccF9eQWGyToCxKzgpxMqS1XS7ntraH4WR7a3ZOPJeluY9hUQKBsKMyWBEQY110xm70hPsp5oxC4HTam1ZWLNHbZCE2eR0VT4/K3/FM0zfXBjEhgZPh3DHsqHT9qp/RuS7q6wcrm4cFYrXlMxVkIhF1QDN/zPoH95KYpxnA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91decf2-8ae0-48f1-14f1-08de899277d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 10:45:30.1434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: az/MjYlnBuCDUh73Neqd1lEi8nMyBIAcKXPF/Em8MkbhOqnnie1wK7RpbEUsgCP85MSqAvvKp0vtsJVsFWkq9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTAzLTIxIGF0IDAxOjA5ICswMTAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBXaGVuIEVQVCBpcyBpbiB1c2UsIHJlcGxhY2UgQUNDX1VTRVJfTUFTSyB3aXRoIEFDQ19VU0VS
X0VYRUNfTUFTSywNCj4gc28gdGhhdCBzdXBlcnZpc29yIGFuZCB1c2VyLW1vZGUgZXhlY3V0aW9u
IGNhbiBiZSBjb250cm9sbGVkDQo+IGluZGVwZW5kZW50bHkgKEFDQ19VU0VSX01BU0sgd291bGQg
bm90IGFsbG93IGEgc2V0dGluZyBzaW1pbGFyIHRvDQo+IFhVPTAgWFM9MSBXPTEgUj0xKS4NCj4g
DQo+IFJlcGxhY2Ugc2hhZG93X3hfbWFzayB3aXRoIHNoYWRvd194c19tYXNrL3NoYWRvd194dV9t
YXNrLCB0byBhbGxvdw0KPiBzZXR0aW5nIFhTIGFuZCBYVSBiaXRzIHNlcGFyYXRlbHkgaW4gRVBU
IGVudHJpZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUBy
ZWRoYXQuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL3ZteC5oICAgICB8ICAx
ICsNCj4gIGFyY2gveDg2L2t2bS9tbXUvbW11LmMgICAgICAgICB8IDE1ICsrKysrKysrLS0tDQo+
ICBhcmNoL3g4Ni9rdm0vbW11L21tdXRyYWNlLmggICAgfCAgNiArKy0tLQ0KPiAgYXJjaC94ODYv
a3ZtL21tdS9wYWdpbmdfdG1wbC5oIHwgIDQgKysrDQo+ICBhcmNoL3g4Ni9rdm0vbW11L3NwdGUu
YyAgICAgICAgfCA0NyArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ICBhcmNo
L3g4Ni9rdm0vbW11L3NwdGUuaCAgICAgICAgfCAgOCArKystLS0NCj4gIDYgZmlsZXMgY2hhbmdl
ZCwgNTUgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYvaW5jbHVkZS9hc20vdm14LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92bXguaA0K
PiBpbmRleCA0YTA4MDRjYzdjODIuLjAwNDFmOGE3NzQ0NyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94
ODYvaW5jbHVkZS9hc20vdm14LmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdm14LmgN
Cj4gQEAgLTUzOCw2ICs1MzgsNyBAQCBlbnVtIHZtY3NfZmllbGQgew0KPiAgI2RlZmluZSBWTVhf
RVBUX0lQQVRfQklUICAgIAkJCSgxdWxsIDw8IDYpDQo+ICAjZGVmaW5lIFZNWF9FUFRfQUNDRVNT
X0JJVAkJCSgxdWxsIDw8IDgpDQo+ICAjZGVmaW5lIFZNWF9FUFRfRElSVFlfQklUCQkJKDF1bGwg
PDwgOSkNCj4gKyNkZWZpbmUgVk1YX0VQVF9VU0VSX0VYRUNVVEFCTEVfTUFTSwkJKDF1bGwgPDwg
MTApDQo+ICAjZGVmaW5lIFZNWF9FUFRfU1VQUFJFU1NfVkVfQklUCQkJKDF1bGwgPDwgNjMpDQo+
ICAjZGVmaW5lIFZNWF9FUFRfUldYX01BU0sgICAgICAgICAgICAgICAgICAgICAgICAoVk1YX0VQ
VF9SRUFEQUJMRV9NQVNLIHwgICAgICAgXA0KPiAgCQkJCQkJIFZNWF9FUFRfV1JJVEFCTEVfTUFT
SyB8ICAgICAgIFwNCg0KU2hvdWxkIHdlIGluY2x1ZGUgVk1YX0VQVF9VU0VSX0VYRUNVVEFCTEVf
TUFTSyB0byBWTVhfRVBUX1JXWF9NQVNLPw0KDQoNClsuLi5dDQoNCj4gQEAgLTQ5Niw3ICs1MDcs
OCBAQCB2b2lkIGt2bV9tbXVfc2V0X2VwdF9tYXNrcyhib29sIGhhc19hZF9iaXRzKQ0KPiAgCXNo
YWRvd19hY2Nlc3NlZF9tYXNrCT0gVk1YX0VQVF9BQ0NFU1NfQklUOw0KPiAgCXNoYWRvd19kaXJ0
eV9tYXNrCT0gVk1YX0VQVF9ESVJUWV9CSVQ7DQo+ICAJc2hhZG93X254X21hc2sJCT0gMHVsbDsN
Cj4gLQlzaGFkb3dfeF9tYXNrCQk9IFZNWF9FUFRfRVhFQ1VUQUJMRV9NQVNLOw0KPiArCXNoYWRv
d194c19tYXNrCQk9IFZNWF9FUFRfRVhFQ1VUQUJMRV9NQVNLOw0KPiArCXNoYWRvd194dV9tYXNr
CQk9IFZNWF9FUFRfRVhFQ1VUQUJMRV9NQVNLOw0KDQpTaG91bGRuJ3QgJ3NoYWRvd194dV9tYXNr
JyBiZSBWTVhfRVBUX1VTRVJfRVhFQ1VUQUJMRV9NQVNLPw0KDQoNCkJ0dywgd2l0aCBNQkVDIGl0
J3MgYSBiaXQgd2VpcmQgdG8gbWUgdGhhdCB3ZSBjb250aW51ZSB0byBqdXN0IHVzZQ0KMTEwIChS
PTAsVz0xLFg9MSkgdG8gdHJpZ2dlciBFUFQgbWlzY29uZmlnIGZvciBNTUlPIGNhY2hpbmc6DQoN
CiAgICAvKg0KICAgICAqIEVQVCBNaXNjb25maWd1cmF0aW9ucyBhcmUgZ2VuZXJhdGVkIGlmIHRo
ZSB2YWx1ZSBvZiBiaXRzIDI6MCAgICAgICAgDQogICAgICogb2YgYW4gRVBUIHBhZ2luZy1zdHJ1
Y3R1cmUgZW50cnkgaXMgMTEwYiAod3JpdGUvZXhlY3V0ZSkuICAgICAgICAgICANCiAgICAgKi8N
CiAgICBrdm1fbW11X3NldF9tbWlvX3NwdGVfbWFzayhWTVhfRVBUX01JU0NPTkZJR19XWF9WQUxV
RSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWTVhfRVBUX1JXWF9NQVNLIHwgVk1Y
X0VQVF9TVVBQUkVTU19WRV9CSVQsDQoJCQkgICAgICAgMCk7DQoNClBlciBTRE0sIFI9MCBhbmQg
Vz0xIGlzIGFsd2F5cyBndWFyYW50ZWVkIHRvIHRyaWdnZXIgRVBUIG1pc2NvbmZpZyAoc2VlDQrC
oDMwLjMuMy4xIEVQVCBNaXNjb25maWd1cmF0aW9ucykuICBNYXliZSB3ZSBjYW4ganVzdCB1c2Ug
dGhhdCBmb3IgTU1JTw0KY2FjaGluZz8NCg0KV2UgY2FuIHRoZW4gcmVtb3ZlIGJvdGggWCBhbmQg
WFUgYml0IGZyb20gbW1pb19tYXNrIHRvby4NCg==
