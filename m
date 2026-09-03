Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4539478B
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788475449; cv=fail; b=VCgNSLw1W9fIBlxZqnBicYYNPQivnGB1DbCGHj2O2bqjUqATpOdJN0/xYIHML4HGsB4JVUJwmYTxVAxoKEmzHGFL+V3y3QC2iXncLMTAOhCaaTg9lS/BxrIUVu1emE+KsuAfXI77w/zzOKv40q2oe2uJ0na5EpIiX5P1B4vVEwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788475449; c=relaxed/simple;
	bh=Dn1wFpJZvkfkBnlTCKXySZFK4rKX9HCru9EZb1OTYDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dyzv/bkLJuQzy56rILOzBJGArQH6fns3oM/mrEFHNNLz1j88uHnyjHqrxTLzi6QLtDgbC+hu58pEpZ0NsKg3wLRbljEzjWXUUD65mRoeuXsG8mtk/CzV9e9yPtTsLXH9o3bsBRxzctKn+LkUMp1KxUr9/qPkrk3argLXjqXJOLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7p2hzDq; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7p2hzDq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788475446; x=1820011446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Dn1wFpJZvkfkBnlTCKXySZFK4rKX9HCru9EZb1OTYDI=;
  b=j7p2hzDqHcvg2jFXzHm4LALWwk68tUiQMfZNpo57N8Vsa9CPQAuICX9H
   0/ge5YzBThAYc5/NZUdIrxEF3lZ97ipozGrbZHqFjv/hSmP4yvx5RF5Om
   hm86F2VmZALX7xjxnGzFXa7O2cvCtSRuy75EoaZuB92b2U1yc11Ra7TE0
   7j0wznp3rtexCFZvhoRfLskkyFwq5UAxqtUf2YBr4b6MLg4NZbQwAwK4L
   JNIW9+l7eMgQ2dTS94EeuqgQrDtRnkXpEQUgxkAy7vjna56RBa0aN2R/v
   BJalIcmzCuXqHOQDNprSABlGvYbDyvXk2xUwYBaG//Jx+nxmBq1xbZIb/
   Q==;
X-CSE-ConnectionGUID: GAy3IsAHRgWx2k1BCRiygA==
X-CSE-MsgGUID: XRd1HMxaTf2vltDvTcXp0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89097321"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="89097321"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 15:44:06 -0700
X-CSE-ConnectionGUID: 69SG6sUaTxCPa2+iQKeq+A==
X-CSE-MsgGUID: 7lsklokaRaO0iu53okZjmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="269849601"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 15:44:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 15:44:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 15:44:05 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 15:44:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbgTE/CVhC4+sejEy5uRqYB65/SLA1fZa1/86n31nZ7X3LqyvsUOfbAStG2qED0QthIp97Hcb8qq3L8hessNaf4yPcgY9OX2w/rW6PMoEXFb159sYQLFGoSYuWCb/rDiOOXM5Q38EXCIhqyyA0m3aJ3c2nzvs7ofZNdWljkDwHQPid6HWWjA6PBz1f2sjo2jyhX+NA3ZsaLzQlN/3UqkmUTR+wwMRZ8M3g5IzvgSox5NLO+v7xNa+yrlJh8IXQXde7s9PecaU+f6hx5rL1DwcPXX6TUktiVZVNT9UmcCDShYSx1vpiCP7J9gytaZmheX2G38YTty55jrrircbmJTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn1wFpJZvkfkBnlTCKXySZFK4rKX9HCru9EZb1OTYDI=;
 b=JKATHt0dsysOIEf2qTVpUbbZ/n9rljFjmEcbCsJZ+Bg224uMgLuh1uVlPzLwGM+r685u12jfcGHM96y4FkNzEhHRzQ6jgyQ/25hEkD3B1S04BEZFgPEnv8U486GoxWdLAtdenDct33qAWoKQwAkOg8VVlethqigLCHpDhCpPjtx/8HVDabzrEPhkPy5mYS0AAwVaEbHrpLuOo3A+lRjqYstJghwvZxKJJy/D+PO4VDi++fCqQvqeJpWupBG4i6Bf3VZ1wgc/GYc3xKuU/HlJFYc8zsaiVXlYbLLbhONE/K01/D7MujbMUkOdPSn/5ZXpU/6OpkhwSd0v6dykMBmeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA3PR11MB8117.namprd11.prod.outlook.com (2603:10b6:806:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 22:44:01 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 22:44:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v10 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Topic: [PATCH v10 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Index: AQHdO0a+fgMgkfTbu0W+emeJrdMYR7a8HTsAgAFXowA=
Date: Thu, 3 Sep 2026 22:44:01 +0000
Message-ID: <1bb966e4bccc2b0f0064073cd8dc1b98c42b2afe.camel@intel.com>
References: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
	 <20260903015113.93343-9-rick.p.edgecombe@intel.com>
	 <20260903021405.0DA101F000E9@smtp.kernel.org>
In-Reply-To: <20260903021405.0DA101F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA3PR11MB8117:EE_
x-ms-office365-filtering-correlation-id: 0710f716-d58e-4ae3-da5b-08df0a0cd9ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|18002099003|22082099003|11063799006|56012099006|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: 9GZpFeZzuypbvWWvJkIBWNiO1OInCcfiBrQmDR6K7qX6FArQ8vjnhnIuvMj3asdZAML/0Xy18foB2Xhw0R4I1HQlJrr+TM4Hn+zBZ5dMEYwXMJmGFdf8BJ3r/HrEnarqbITh74/qAR4ouJ/nwKIytsntwdLAdB4KhEYzJYGPS56vl0BAcQtoLEgOn7C/u6ldRux/9dLy4IHTNyM1tSgFVrFHDWPLcearv8PvUKZKo9arMfbr2KWdrO7fGRue0i8MBS7b2WmrbK7E/inYn9OlC/tC8zs9k/H8NZ7FWq7wc7uxVwb/xmkEBfMznmfafCnbECOhHzodUnRMYRI6DjDBYJ0MUjgys3Yox47GPKDzZ/JZOq9m/PUalwIsI+Q/OF6+UOQ37y/+xTBnWFRjoUTfuiaQuecnBFrcd1rmbPHo+AHCs328/VeiUS5+Yw7sy6uF6eueG2nq2ryCOVxtBvg3hse5sgZrB7T8ifEbMGoftWsXO6QmLz+oCI1jxC96r4Uj3VfJF2SPe4Ivk756dXTXzFrimuFD/i0Y5NqpMwR0t8D1n4BNsiptgiAeuDFkow9ho5osMKnIfIZupeVOC4kxNHAieDBXkkvS4J3mx64rc+70gkrpP0G5CKz5wMG988Et3EXklmsl+ojaMuVf3rgebmowJceQ0m9lgh6E3XY2ul+yX6Ggj+5MKM/K59FJvKY9GVnpgqSxKnEGY0tf36d3AjUHampIR/voe7qjOZugYX0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzUrTi9iTDRWUUQ2REpQTHVtbVNXaGVvclErU3NCa3BzUXYzWXhVK1VxL2pT?=
 =?utf-8?B?d1lOWVpKbWxuWnM1VWZEQ3VEOFgyQmxTdEFGaGNkbG8xRUV6Q0FsSzgvWkw2?=
 =?utf-8?B?RWFBMmkwbnQxYjRNQTFPRWZmeWdiS1U2SmJ1M3hxNmRhdlRIWW9MeHZxWTVL?=
 =?utf-8?B?T0FNTGtERi9neWRZNThTRTh6d1N0L0hwUXY3OUszZUI1dkVreUN1N09ETGNP?=
 =?utf-8?B?U0p5NTYvSEtTbU9ZRnpNMjl6UTlFR1ZZNktwaG1NOEtwZlV5andSazk4SFl2?=
 =?utf-8?B?NHFwdUU0ZnJTeGVQdTMwOVBNTURVTmZob3NHZFI4TEpabEVPQ2VlM3pHbTNo?=
 =?utf-8?B?WlRqdjlHMU9HQzVBNm80VWhBdEFBQUVEOWcvUWVDc0VGb0VhUHRsTGxzVDZB?=
 =?utf-8?B?UlVyWU4wZGhScXV0Undpejl5YytzeWhucnBBNzkyL0JEQ1NEamY1ZmdFbjlB?=
 =?utf-8?B?WHozWFdvNmozRVJ2Q1laTHVQSmN6bHZWa3Rac2VHNkhZK0NPRFl0ZmRaeWJj?=
 =?utf-8?B?TjNiVUFzV3BTRU5UTE1qeEVwTTdKUEpMK2NVSllveVpzaG9NNmIzOUNKa09W?=
 =?utf-8?B?dWRZN0ZMRHVaZkp1WG1uT2xHTXJ2L2QyQ1FjbG0vY3BGaTU1eE1XZ0pIYXlI?=
 =?utf-8?B?MDlqQklLL0lZU0xwUE93WDZSc2NWZFg2eWFnMmRqQ0srWmp4eVpPT05mdmg1?=
 =?utf-8?B?bzdZMnJabmcyV1JOY2hMWkVsbTJqV2xsZ0FsMTgwZ0E4UlVCWVExVU5lbTBE?=
 =?utf-8?B?K3ZXb2hQR29NL3FKSEFUMVRzVlMwVlpVKzEwMWFwZ0F5bXZ3c2xFUkt5bXBB?=
 =?utf-8?B?MmV4VVdWSVVNS1pkakxFc1J3RWJ6WG02MTBXcUUzdXRJdjN3NVVoamt6QVJB?=
 =?utf-8?B?WUtDQXVuNWpyMHJxY25vcGRqb256ZGZhODFpYXJoSWJZSXRmbTFhUGVtU1FG?=
 =?utf-8?B?aVNVWTUwcjE0R2JpREl0V0F4MzJkQnZKc0EwMmE1RW5BMkw1QmFFZ3RvU1gv?=
 =?utf-8?B?RzY3THZWcmI0NzhaKzJmZFdHQmRGdEZSdEpjbE9UUW5QYzh0QTJrNXYxcmxE?=
 =?utf-8?B?VU5mM280VUppNjlmb0FLMi91S2xpYWhjOG5zclRrcVF3UnVDWjNrd3Jxb21N?=
 =?utf-8?B?dnFVa1FTbWhJbDZCUER1YVBXNkdaS1ZrSUYxTUtobW82dXZmYXoyeEp4MHkw?=
 =?utf-8?B?WlRWNThvRUp6QzZFdjBvT09QSDVpcHkxUU5qZUcwZTFLbjNjK0crcGtMRjZl?=
 =?utf-8?B?MVRkRFV6RWJZNmNIcWVQcFp4bldvSFNDby93UlRYNExoWitMY0tqTng2cW5E?=
 =?utf-8?B?eCszK0xaNk5lU1RjWHg0K1hGZ002VXVTRElub1hZTTd5cUlXNkg1QXRFcWxj?=
 =?utf-8?B?bEZQNkhCYkdSbWplc1FzeTFVd2k2RnFsK28wYzdMaVJDbUtVL0JaTjNoK3Fi?=
 =?utf-8?B?b290K2NrWEpFanZuMXBZQWRUR1NxZ25ING1xdXRmVFVEUkV3cWhVY0dDbG1K?=
 =?utf-8?B?djJ5ZXBzcnlqUThBUXd6djJ3SUFDS092eTdwaEs0T2k4dFdzdENqeElhNDl3?=
 =?utf-8?B?TktNYmM0bkVKV2p0VGJzMTJvdzRmOGN6ZW1yVVpLSnl2alJRKzRRUVUvNW9y?=
 =?utf-8?B?WWtLWVJScmpaT0JLbEV5TWF1M25Vdm40clQ2eTMvSUwvbDh1NzdxT3N0TWxl?=
 =?utf-8?B?OTFCYmszcFh4RjRuUXpQUE04NUJ0UVZ0ZjkvQ2J2amJQTlo1TGtCa3JRcVAx?=
 =?utf-8?B?OUxCYXVJS1pDRmhvNmlTUUU2Titpd1QzVnlaVzJXRWw0OWxWSlIxcGJlQ2RU?=
 =?utf-8?B?Z2dBb3BpNGlUdUhVUGFiTEZneTZSdTM2K1VvZExPajdRUW1qdDNhczIwK3Rv?=
 =?utf-8?B?dVhzeCtod2JYVnBoem5yOHpxZGdZSUdSU05va2dTTUtWSmd4RmI3ckVVV2Er?=
 =?utf-8?B?b3dIMWZ2ZEkvL1dSQXZwMEh5b3QxVzFFZXAvTVdyQ3AyUU5oaSs2R2pVQ0xy?=
 =?utf-8?B?d1hQVnV0VHlORFpOVkIrNk5HQXFKWGt3WUFrcFh2Vk5KdjdsbURRbWNwcGts?=
 =?utf-8?B?Z3VkMG9Zc2JiLzNpeFBqckkzcW9Pd3liUmg4c3JLYlBIMUJhVlAveG1lbDZo?=
 =?utf-8?B?RnVQRUdUNnh1WTdCRVR4TE52aXI4RW1jdGFOcjByNW5VclNidFNLbGVoRXh3?=
 =?utf-8?B?K21sNzRSaWZmbitjZllTR0pIdUd2KzM1TzFVaUN3S0x0Qk1wd2dOa0U2ZEl0?=
 =?utf-8?B?dXJJb0VmVGhBL0xVejNDZmN2TitoczZxT2Jhci9WeEJrTEVKOGlXSjhKd3hF?=
 =?utf-8?B?cEIyRHJieHhrTmo4UHJidHZQaThpZE9yaXlVRzlQLzAvWXQwa2VUVEFqd1JX?=
 =?utf-8?Q?3+/A1E486ShKZxlQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD3A501C09E550418EA2DEDEBAADE311@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W3ElmNqXGouOV2fBSk4fyl8mKB06Ww3t/cLxhDRIygEAL2HeZadIACvk21edVIBQOlhQxVXG2IQnJlR2rFQ+cokmQnNMCjtgFGPEGwR5JCnWkc4oGC5USkvzCp4Iivhmdv8im7hUMPjzns/R3WcG/yN/vlTYL4vImT6iHolFTb+BoqZm8ZZeFBKjNQ+BRbvmEYS+N1JOxYaKWzDA3ov7U5+L9AwtWasVFEeA2JheototAy19rrJt57BLVeiPcKwAbmb3LES1ZsRu9uxdFRl+nuZPFCGZS3hZw+yIxn/Vl8fVNPYFUF5y5KlJIlnoiU/Dj8HTKzX02wzIxKA9sUttOg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0710f716-d58e-4ae3-da5b-08df0a0cd9ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 22:44:01.7771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vU427UOCkRv51LCq/7xfQjRtJ2uXJZohHnfTiqkMcpmNSvrZO6RbAY0OY+F+2U7D4HU9zvZFgzyQ5xHNILLkBZpHIyqMp5RvuzEAxYxP9v4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8117
X-OriginatorOrg: intel.com

U2FtZSBpc3N1ZXMgYXMgYWx3YXlzIHJlcG9ydGVkLg0KT24gVGh1LCAyMDI2LTA5LTAzIGF0IDAy
OjE0ICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3JnIHdyb3RlOg0KPiBUaGFuayB5b3UgZm9y
IHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAyIHBvdGVudGlhbCBp
c3N1ZShzKSB0byBjb25zaWRlcjoNCj4gDQo+IE5ldyBpc3N1ZXM6DQo+IC0gW0hpZ2hdIFRoZSBy
ZXRyeSBsb29wIGluIGt2bV90ZHBfbW11X21hcF9wcml2YXRlX3BmbigpIGZhaWxzIHRvIHRvcCB1
cCBtZW1vcnkgY2FjaGVzLCBjYXVzaW5nIFBBTVQgY2FjaGUgZXhoYXVzdGlvbiBhbmQgYSBmYXRh
bCBLVk1fQlVHX09OIHdoZW4gUy1FUFQgbWFwcGluZyBlbmNvdW50ZXJzIGNvbnRlbnRpb24uDQoN
Ck5vdCBhIHJlYWwgZnVuY3Rpb25hbCBpc3N1ZSwgYnV0IFNlYW4gaXMgcHVzaGluZyBhIGNsZWFu
dXAgZm9yIGl0Lg0KDQo+IA0KPiBQcmUtZXhpc3RpbmcgaXNzdWVzOg0KPiAtIFtIaWdoXSBjcHVz
X3JlYWRfbG9jaygpIGlzIGFjcXVpcmVkIHdoaWxlIGt2bS0+bG9jayBpcyBhbHJlYWR5IGhlbGQg
ZHVyaW5nIEtWTV9URFhfSU5JVF9WTSBpbml0aWFsaXphdGlvbiBhbmQgdGVhcmRvd24sIHZpb2xh
dGluZyBsb2NrIGhpZXJhcmNoeS4NCj4gLS0NCg0KRGlzY3Vzc2VkIGhlcmU6DQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9rdm0vYWs1TDJjc0lUeWkxdEdwMEBnb29nbGUuY29tLw0K
