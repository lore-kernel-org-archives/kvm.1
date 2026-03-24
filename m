Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2536BCC4;
	Tue, 24 Mar 2026 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774347110; cv=fail; b=nPqxNDOK+35kMlJ/NFvV21lcDGZn6F5Jd8Oy3aRLfSN7gFSMcI/DegMsdCrG4WT1vlYxaOBY2CekXYC+9n3yGATyJw8d9F5sB5mip3ZxAEvQR6ujUegEWorqve9NdcKMsPYm2e0/0IWoO7K06XamL4+3ed3/lQpMRQbaVEU0YRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774347110; c=relaxed/simple;
	bh=cmpgeaUylXSHmsJZyEJWuHqqi5qHMiLtCEhviOMK3VQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OX7c4ctJQUNbupCq7ztjQ7j9f1noWgWIGNOuubE93tqCUCo5S+5kY1xysWVtwvsMD2ljj0WlPjmqJ0ncxxmL/qiW9GhqttK7fv3GcvNr0Y39Hcs+rqHjdsBnB71FNfz2sDGOFDyIlT/3hUhifVLjt/3mwe6Ng2QFzrJ0tUQHhKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMPATJ1V; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMPATJ1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774347109; x=1805883109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cmpgeaUylXSHmsJZyEJWuHqqi5qHMiLtCEhviOMK3VQ=;
  b=OMPATJ1VE6ZCgTM9zrXcM+GD5cuW6H2j1MwzFf6PEtO3pzPo91IuuR1W
   C6nuQQhHNrspBHJSKlzB7GI+sEogT3IA++cFZ4hb2+4tqp/TPJ2F7gDYE
   gaCKKC+5b+t0FWQHAl8SojMwedw6vo5SKGDJGkC56BD/wg5ALMBMOCUpo
   XYnyjSr7HPgolkPf2bas2cm8M3lrAwcyT8KYMVk73wLlPTbftspl0eiUH
   6dy1tqNu8bUYCq7QubBj16iME6HCwRZ5caD+zOpA4DT9+VOdcIcmqU2Fb
   8APimmgD06LuwPkMpRcU7/McOdJk1nkI8sWUfPOusIOcZzldxWvRuixJV
   g==;
X-CSE-ConnectionGUID: zJQnxgnFS6qNkLTJCIAnQQ==
X-CSE-MsgGUID: 8SIgi+zzTDS5OUhtK7wNRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86828963"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86828963"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 03:11:48 -0700
X-CSE-ConnectionGUID: yP3UkuWUREGCgqub0BtwuA==
X-CSE-MsgGUID: hkktKTAERPyJIQn/+pxfFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228370127"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 03:11:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 03:11:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 03:11:47 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 03:11:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9Xu1QdLkdcGwJOQMA0yDshLVIzOLFeGZA1jihzbekLFZ/KsPQKkNwvfNgbQAetb6XivAFGvnWwjB9zEhOPR9+c5OIj6zn8QU+WHO4TIw9Ad8K6ed4aCGQVwtowgIypmHtb9cQVzVJYtvTuEw1Mv++FBHaPlanL3wR/bGW8vZUd8/ZKKRpJwvTLnW2tqok98IW7Qooz9zPLF4f4eO2mvtshqKOX7TI37kqkIDAGfOzgOdLTI4tWlr5QJmTEru9TtVlUJAwF6bmFo2a3nKjg7DBBYmmrmGd7obVeDaFXzv0P+9dYsPMRChdYbuZ9w1On4eikk6jSbMF7rQ7EUD2iU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmpgeaUylXSHmsJZyEJWuHqqi5qHMiLtCEhviOMK3VQ=;
 b=KXdiGN408Nec9z0xTWZfdyYMlIBD+edG/zjeEBvrz8gVjA1nLLHQqkhiqXSpvhhpXCjxwE6yULmQuy7T20t3ycn6+pp6FMb6GDgeTLGYrdSwD+q0Ixm7SH9b6BB2w5Uz1PtFFsJ3cBYmpz3nDsyyo6mV8SQz/W2ZeBmkx881Dl7oSHTYcmgjjyGhkSzAZB5p4KAn6MSJYIfTC0U4VfaEi3ysuzsHZSxqLBD28ozAuPHUls8VxTH3DO3V2CnA4YTO5BlwNCgh8nQb9klrbTqUoE+DP5fZ0447jJku6E5MjfO7SK7Nme+oQXVEkoP0Q6pYEYIYQKyoQ48oq/NUGZKQJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH8PR11MB7094.namprd11.prod.outlook.com (2603:10b6:510:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 10:11:44 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 10:11:44 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"18341265598@163.com" <18341265598@163.com>
CC: "hanht2@chinatelecom.cn" <hanht2@chinatelecom.cn>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "weixq1@chinatelecom.cn"
	<weixq1@chinatelecom.cn>, "zhangzg12@chinatelecom.cn"
	<zhangzg12@chinatelecom.cn>
Subject: Re: [PATCH] vmx/nested: Set the SGX feature flag only when hardware
 supported.
Thread-Topic: [PATCH] vmx/nested: Set the SGX feature flag only when hardware
 supported.
Thread-Index: AQHcuz6j0NEGTKXnYUS0AWJdG9RzpLW9drkA
Date: Tue, 24 Mar 2026 10:11:43 +0000
Message-ID: <95c13b532d2958977d176e965efc433f1f4793c4.camel@intel.com>
References: <1774322860-25106-1-git-send-email-18341265598@163.com>
In-Reply-To: <1774322860-25106-1-git-send-email-18341265598@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH8PR11MB7094:EE_
x-ms-office365-filtering-correlation-id: 9ff95e4a-8898-46b2-8cc3-08de898dc02a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: xkFygsTfx7GD3PO/dDb9RwoPFH7NxVY1gT+Tg1JP3V7kBeMYIxZKBH++44+NM/rqDcUvx12ceOz1TwxDB57sftQ8Yv6L+8os8Fsp3Y0vJTe2uKaPO7t79SjSwssvN6v3uHYls4Ij25/Y9GwaW4H+Fbb/YrtOsPkp2x7ZmQ6fmNWE/KAD39NmiyeT0An6f7ZdAFFn2o5ourEN+Ct1uUWZSwq/cTDqUR25sYsFE8o1AY5aRcL6ZwOT7q4ILmvOKbDbNiMAM8hc/Sf0Ht88m/q14tMmsyhiHkHbHzTTo6wQ3TMWwzIQQ0xiOjAbKKyaMurLxBJ6+9FZrN+KodEiDNNhOAgwzG2yTGqBKv/7CHxYw/q/qDd2OhYsmOWz4PgRYKjSFxrWVoGFxzNCFCmp9Od9tuP4O45HSSRvGUkRRazvr5fyGYpSJDeyLdclx1bIz6Fi/2+X8RMyvLwDtlvUEBrrUTCmRphyht+2Bz0/czej3wyonNR1W86ULMPqIIUC8ko+J07xOLFOEy4l/oU1AJKYUUvkymDpmt/DjhBpnSkY0CgA59fD4I9NuFeqpMTqAy7JqJx3T7n5jQaaQD8AzX3zVpTvRjGlE9ishsjw6+fy1IMTLh+UDZby325iWB5IX6+jl+jwVEXDXfr/slKcIRIpUZJM2UYE4442FGGyfGL+Q8ulq3HqJyTByUFh+d7e2P39oyd0gExOeSo7EW4nN+dt5rJ46OvoZjkDMMNFPcFh6IIKCD4JJ5vZKPMG1w/MKkkv4ejSE13EhOG1l7ZrQCS5A3y6RIhenClO12mQgiQWn8Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2l4eHRDcTl3dGVGT3lVaUcxNkVCM2ZJVy9jN1hYajdxU0piNHA2dzFBWWFs?=
 =?utf-8?B?cStDT21JWnVXYUtrdDY2VjMrRHUwdmRPbCtZbGhyUFIyMzNRWVA2aWFIblRX?=
 =?utf-8?B?RkxEcGZUQWlEQ01LMytUd0duV1k0RkdGZ0JqcVNTTHoyTDQxZ1VKcTlCS2FL?=
 =?utf-8?B?SE9Obm1WYStMNjhPUnMyWGRHNndpSEoxdGp1cnV2WTVEYjl6RTZtN0s4M0lO?=
 =?utf-8?B?TnFsaVdERGdtKy94dkVvNGFPMlFtcjRYSGFuRzh1Wm1xeFZvQnBhOWNZQXBB?=
 =?utf-8?B?VEV4YVUyV2VDMGhBaTQ2SkdJQnZXNUtPNFRnU1FmenlDeTFBZjV4NHFGMjgw?=
 =?utf-8?B?L1BvdWc3cWI2VUVyRHE1U0l2dFJTempXSEd5VUtGanM1bllFTnViNXJYZldz?=
 =?utf-8?B?MUMzSlVSckwxT2R4Z0NsUm5DZXZjNERjV3hCOEJqTFAxZGhtMVhxNnhjdFE0?=
 =?utf-8?B?TU4yWUVyQzBTOUwxVSsvZ2I3VUd5cXBKdm1TYlhsM09mNmVmOUZSMFoxK2tp?=
 =?utf-8?B?ellCYlBwZnlMbWY0U0UxQmRWTFBHbjBNUjg2YXpTc2tCMDBLSTRkdFhqN0Ju?=
 =?utf-8?B?M0FOVlMzTEtzenRIK1J3eE1BcElMMGNKRjFweCt0NTRzOGs0UGhXMnEwS0NV?=
 =?utf-8?B?RXpPWDNiT3BNdXBuN2p2aW1XZTROY1ZqdFM4WHFpR2xadS9JclY1UldyMnJr?=
 =?utf-8?B?UzJNSHdJZzNjb2h3ZWxzK3krcisyVXhnZ0pmc2gxU0ozS3Y2QmJRV2RPRURq?=
 =?utf-8?B?U1UyOVhSd1lzeHVPVFBhN1FGWm9sWmF5cFM4OUtVV29EcjlHa3czRVc1N2RH?=
 =?utf-8?B?dS81TVdxUk50eWcza3BuNlI4YWttOXcrWE0rMEt3c1pldFVKY2FOaFQ1TDRP?=
 =?utf-8?B?d0pQQ1hDekdhRURGd1pwTUQ4eXJpcDI5S1ZSU3RpOHRDdmxHQ2E2TXcvYllQ?=
 =?utf-8?B?V2FJRG03YnFPUWt4eUJKdHFFZFRGclI3dzVWQ3RYKzJPZlhDSkk5TWVBcGV5?=
 =?utf-8?B?MlZ4aEJJRjRyMVZjbkt5WFpXYjFGMFBiOXNTaDhnWWlqa3F1VVNMNmdtdjBi?=
 =?utf-8?B?bUJCSm9tTVIwTG5qUEZseVM2cUpBbjJMLzA5V0JYSnowcWlESEhyYjBGUWtE?=
 =?utf-8?B?Ym9nMUprdTdJdFFMQldTak9BT1hNOU15Wk9mMElaUDdRbHJzYnVYNGZlNVRI?=
 =?utf-8?B?ZldtaWw3c3cyb2R4eC9RTGNpV3pVK3ZVZnQxL3JncHpDZVVBQUVaOXFJS2JO?=
 =?utf-8?B?bEJWMHJiMHZPeDJRWklzWVlQZlcvdDdENzJkcVo2bjFMb1BoUk4zWnYrQkly?=
 =?utf-8?B?MkZlVU5Zb3lLWTIvemNrS2d0Mzl1bnpKQ1NjKysvWEJFTXdiYXdoUlEydk1y?=
 =?utf-8?B?Y3BUV2p3b1BLZ0dBTU1FM0ZPazAxUWZBcytjaCszM016TkhPN2hLbWdlZUFF?=
 =?utf-8?B?UkVkOVdIR2lVVlBMbHovak1GRytPS05peVlvSnQvV0xUWTFMUG1idkFvY2lX?=
 =?utf-8?B?UHVuQjNuOE43YTJzdDI5NnJLKzFTTW1URmZ0VGVaM1g5ZnkwekJJd2RjcStO?=
 =?utf-8?B?elBjcmFjZTE5VVJheGpQazdDWDdzNUNrWkJNNXNYOTdOYXhRS0pFY3hROXBY?=
 =?utf-8?B?SjZWd0wyMVUxdi9UdUpIM2hTNFN3cVFWS3dzN2RmVTRKdTVDeHJNdTBHcXBZ?=
 =?utf-8?B?cVo2c3lEM0NFQ3F6WWYrelVZVU15UWFZSFVOdWp2WVlCTis2bC82RzJ3MTlo?=
 =?utf-8?B?MlJ2UmNPSlhlOE9QZWxlMzVpWXJQUnpNN1Vtcy82YkV1UGVzOFZrTjJ4VDlr?=
 =?utf-8?B?dkZCMlVZamNnSnhLVHB4ZTN6L3M1WDhGbEhSajhLbmd5Unh1MXJaTDgxQ1B4?=
 =?utf-8?B?bjJkMHpjNEVSWWRFQUZQZzJsK1FmeTJMSGxQNjZ5Y2ZyRExRQlpIRitNeGF3?=
 =?utf-8?B?UFFWL21BMnFPTTM4djhTUVN2ZkhOMmN3cTBHeWFEelNETTc4bkxYS2Naakpo?=
 =?utf-8?B?cjIzbFZLRGVVcG1mb1FmazNNMFhXUHA0b1FUVEFlQ3Q5cEEvb0JmVGMraGVQ?=
 =?utf-8?B?NnY2VlltR3g5SjNjZ3BpZzNyM0d2d2pvV05FZm1hcEJTaVY5WDE4c25yOWh2?=
 =?utf-8?B?dWFnNUptaTJNYVJheHBzcktGWEJUOFh6R2xLT0RtU1BQQ2lBOTQ3NTduOWRM?=
 =?utf-8?B?WkpweUc5TlZGSGFNSTZUWG8zdm5sSURXV21QSXc4MS9YVzlXaTZhN243Zzhv?=
 =?utf-8?B?VG1KbnZyekVHalpUV0lJbE1iMXZGWWtiRElPUjFhU2pIc2haL2YwaU82cldi?=
 =?utf-8?B?UVdIYno5Q1BDeUJHN0xMQ0M5aStOR05TNHBMclhFMk5hMFhvN0J6Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9BCBF9DD39187428BE22FCAEC972D15@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RtZLScl2wcQtJAFuXa4yKIWz1dKsHSpjqofgnMIT/cVZzWTNAoLWKF4om1GczdCafI0YF01FW23lrV4cp+jniFy8+4Pbf9tBbcENARsQEUlMTNX9ga/umJQ0DtOSFqYJx1j1KpeF2nMwLULj18yJJZnEdEeJ88fkfkVjupr/oSs9NxArakMO1+BKkTejYUgRmzA9aujhsDjVwNBSKlqSOr6FmqRiAPy2wc4jT0nVItB3R6y5JP0IQGzERxUYdUAjeB1hFAVnBXg+UxhIGu4OdoiCBjpIpsCTOgHKe2e5HbUlnns3tV+STyyOH9gTTPVFyUQ7/AtL2u8sBVGbQARC8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff95e4a-8898-46b2-8cc3-08de898dc02a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 10:11:44.0265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rsmYVt3fBccrBNxPCdlGOw7XAPJVCKcVV7acBf0Ovalk16n/LWN9tlaEGuUYC5MmEZliixvka8e8tP69u07C9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7094
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTI0IGF0IDExOjI3ICswODAwLCAxODM0MTI2NTU5OEAxNjMuY29tIHdy
b3RlOg0KPiBGcm9tOiAiemhhb2dlLnpoYW5nIiA8emhhbmd6ZzEyQGNoaW5hdGVsZWNvbS5jbj4N
Cj4gDQo+IElmIHRoZSBoYXJkd2FyZSBkb2VzIG5vdCBzdXBwb3J0IHRoZSBTR1ggZmVhdHVyZSBh
bmQgd2Ugc2V0IHRoZQ0KPiBjb3JyZXNwb25kaW5nIGZsYWcsIHdoZW4gdGhlIEwxIGh5cGVydmlz
b3IgZW5hYmxlcyB0aGUgY29ycmVzcG9uZGluZw0KPiBmZWF0dXJlIGluIFZNQ1MxMiwgdGhlIFZN
IGVudHJ5IHdpbGwgZmFpbC4NCj4gDQo+IFJlcG9ydGVkLWJ5OiB3ZWkgeGlhb3Fpb25nIDx3ZWl4
cTFAY2hpbmF0ZWxlY29tLmNuPg0KPiBTaWduZWQtb2ZmLWJ5OiB6aGFvZ2UuemhhbmcgPHpoYW5n
emcxMkBjaGluYXRlbGVjb20uY24+DQo+IFJldmlld2VkLWJ5OiBIdWFpdG9uZyBIYW4gPGhhbmh0
MkBjaGluYXRlbGVjb20uY24+DQo+IC0tLQ0KPiAgYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYyB8
ICAyICstDQo+ICBhcmNoL3g4Ni9rdm0vdm14L3ZteC5jICAgIHwgMTEgLS0tLS0tLS0tLS0NCj4g
IGFyY2gveDg2L2t2bS92bXgvdm14LmggICAgfCAxMSArKysrKysrKysrKw0KPiAgMyBmaWxlcyBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rdm0vdm14L25lc3RlZC5jIGIvYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQu
Yw0KPiBpbmRleCA5MzdhZWI0Li4zOTZhYzA3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0v
dm14L25lc3RlZC5jDQo+ICsrKyBiL2FyY2gveDg2L2t2bS92bXgvbmVzdGVkLmMNCj4gQEAgLTcy
NzgsNyArNzI3OCw3IEBAIHN0YXRpYyB2b2lkIG5lc3RlZF92bXhfc2V0dXBfc2Vjb25kYXJ5X2N0
bHModTMyIGVwdF9jYXBzLA0KPiAgCQltc3JzLT5zZWNvbmRhcnlfY3Rsc19oaWdoIHw9DQo+ICAJ
CQlTRUNPTkRBUllfRVhFQ19WSVJUVUFMSVpFX0FQSUNfQUNDRVNTRVM7DQo+ICANCj4gLQlpZiAo
ZW5hYmxlX3NneCkNCj4gKwlpZiAoZW5hYmxlX3NneCAmJiBjcHVfaGFzX3NneCgpKQ0KPiAgCQlt
c3JzLT5zZWNvbmRhcnlfY3Rsc19oaWdoIHw9IFNFQ09OREFSWV9FWEVDX0VOQ0xTX0VYSVRJTkc7
DQo+ICB9DQoNCkFyZSB5b3Ugc2VlaW5nIHRoZSBjYXNlIHdoZXJlIGVuYWJsZV9zZ3ggaXMgdHJ1
ZSBidXQgY3B1X2hhc19zZ3goKSByZXBvcnRzDQpmYWxzZT8NCg0KSXQncyBxdWl0ZSBzdHJhbmdl
IGJlY2F1c2UgZHVyaW5nIEtWTSBsb2FkLCBpZiBjcHVfaGFzX3NneCgpIGlzIGZhbHNlLA0KZW5h
YmxlX3NneCBpcyBndWFyYW50ZWVkIHRvIGJlIGZhbHNlLg0KDQpUaGUgb25seSBjYXNlIHRoYXQg
SSBjYW4gdGhpbmsgb2YgaXMgYWZ0ZXIgS1ZNIGxvYWRzIHNvbWVob3cgbWFjaGluZSBjaGVjaw0K
aGFwcGVucywgd2hpY2ggInNvZnQgZGlzYWJsZXMiIFNHWCAoQ1BVSUQgcmVwb3J0cyBTR1gxIGFz
IDApLg0KDQpJcyB0aGlzIHRoZSBjYXNlIHlvdSBhcmUgbWVldGluZz8NCg0KDQpbLi4uXQ0KDQo+
ICsvKg0KPiArICogVGhlcmUgaXMgbm8gWDg2X0ZFQVRVUkUgZm9yIFNHWCB5ZXQsIGJ1dCBhbnl3
YXkgd2UgbmVlZCB0byBxdWVyeSBDUFVJRA0KDQpCdHcsIHRoZSAiVGhlcmUgaXMgbm8gWDg2X0ZF
QVRVUkUgZm9yIFNHWCB5ZXQiIHBhcnQgaXMgb2J2aW91c2x5IG9ic29sZXRlDQpub3cuDQo=
