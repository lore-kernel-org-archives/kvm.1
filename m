Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795041857;
	b=MBgh/HaHwvtAC6EP8lnDfPdRZuK5x6fg8Y1oiVLUM/eyR2PVVT5cCNaTSUVOU28DnSCe
	 4vaEVYU8jHO4qBe5hi/VSg4GN7/AfIIi+E5giqoDon5RaIDh6rvOB/icFhUXEUTChHi2y
	 Mcgu8HMuiEE8CzjYroTGWBf4z97X73MI4iPKmpcc85SpKP4LZtlIJj9WNjnqAwcHmotuT
	 a1zgqbQc8sXgPA2EOWzJa55q9FLTNe0uZ3iaUJzj2Yhj8e/+0SX9sryvLFZTLd+lI0MSV
	 BAEiRQWd7TsYz/Ch28Do/TGsplYNIwWaw+DqJEDqrZQz326Ptz4k+grfV4yq/AcG47A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041857;
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
	bh=XSRZqArB79cixWQVDRWNXSFJAcvLTWoEh31Ow3o9iXg=;
	b=OrX8btAofIC7IaooZR7CB6pxuqO8js6Aa3wA+w9NkWf3Sj2sRrnP5wEuZKWOaJIUOcXU
	 6igRfx0Djqvq7umP7iio9lOpzFwR6bID9toPXOAy9k+BiPhQu+F6eV2C4ZPUKPcaUfqVO
	 6Zlc0IHsuEu7EdMGCot2wDiatL4a+xtPb/BwZlMF/4YcfGUS0bGU1TwjP9j/U2GqPI9zV
	 ti5i1NnkGGcirhz1h0btJ4JUY6Hgyna4BaIDYpXMVR43q9K8cAHrGcrltD5g0vEn6d9dV
	 rqhPrLoL2ma4MeCf3j5O5R5qjFE8dpuMowrOx6khqcEVzbOR2g0qxhg81S5EsWaiyTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aegpCDmJ;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=kd7tphlr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3430606A330;
	Wed, 18 Nov 2026 22:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3430606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aegpCDmJ;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=kd7tphlr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795041855; x=1826577855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XSRZqArB79cixWQVDRWNXSFJAcvLTWoEh31Ow3o9iXg=;
  b=aegpCDmJgFEKY43Z5THQO+swfEhi2+QTUeo5hOK9jTOEENMvGgyyZBaO
   rD+HRZ9fQrYUqJVgurai0uk6E4I9uJY6/k3l/TI/fQASzMj3yfV+VFZJq
   o2DES+to9lCAGn8vSa+B5wXQ+WoTCuQzDR/kIOsPng66lcZXM9sSaTgEk
   NyehLvtKeKWEbdkS3AsUKQkal20ZQjYSL5tnvzaqQ1nS5Rp2GXctqejyW
   UaK7zgUqD1TJ/MdcvsPGp1Y8lTelm+qOPM/xaYwM/ObMk/bpW3xg1bkyw
   pn/+nnXFVxyEwDJXJbcQ496zQP/625XU274NIZB1OFHNNvblTWuqFtu9x
   g==;
X-CSE-ConnectionGUID: 6Nx/XwBFRtSEdCRSbX7+SA==
X-CSE-MsgGUID: tjvkivl1S2mLf1fLE905Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3867026"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3867026"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 14:44:11 -0800
X-CSE-ConnectionGUID: 9zEmDLjNRyuBOx6/d/OOsA==
X-CSE-MsgGUID: D4zD8DRvT3WmoiKoxDktqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10597715"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 14:44:10 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 14:44:09 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 14:44:09 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 14:44:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQftC+toOBJ5DqdAQBCOh0hSix+M65ooWlut3Dc5nsDLaeUDYn2Z/L569++a1dzN13Pc0fInCUoXruERnluF9xVyrWYraR+eUsuekUrWrZwh+YX0Kkv4tcWMsOWaOAjU5qhicY3SkLtw+0IJk3HPRI60yClyXz227A3FOxabGcuPoJThWBm0ov7/Y512nT+Qbz+0IWAlB6XRN3htrihGvyYina4d+oWs2ZAW+zjcJmsTccPPROhhCG+2CVCnFaOlNiFQFfHUR4vnjxuiSHiIX0cjLxrrUQstlfBlApGds8TU/pSig6yCqnD2T58AYpwQUb36K1uT8TekrPJ5PrayOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSRZqArB79cixWQVDRWNXSFJAcvLTWoEh31Ow3o9iXg=;
 b=Cz1IpGMiM3CGCDZ8k5syAIr7pPLqOp3Cfk28BKaQv6s0ljuMCmxG6W3uHUhyKMKu17mrwxyUT20tvmwXv+CncB4aiz1vcZ2iRsZ0ZNvmatNQay1T0J0XNH9esoD1ozGpF29EdDq4/8GrGcpOJn46sRhS+n7tQLVRLJ5tfk4OTxvlkyRuZbMWnDZUAvt3nqJzKf6akdbWfQiPSwEkVtKW4lf6AYq6Hgsq47d4Qr6yKDMi4Sn0h61buKM1tHN1a6eI9bNwS3aItFE1w2qalo+DPvGCicb2ZDMQGTkh33FGfCK45m4YIujD6iW+enN4IPpN/Vxa9kKcpyVuXEpy2eL0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSRZqArB79cixWQVDRWNXSFJAcvLTWoEh31Ow3o9iXg=;
 b=kd7tphlrdUied+i4bA+d3Qg7ymN91eDoL5eI5Fh7krGSP2h6ouuxQL6iOBoWvTLhJ2jW6mslQws2jfk1KmL09MraSzXORxDL1oRcPAPxdKYLUS78cbgWJogaCtAcgv+xugcztOZVVQA5NRo3p/lqUBQPHNJxhEys1A3J84pmgfI=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by DM4PR11MB5261.namprd11.prod.outlook.com
 (2603:10b6:5:388::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 22:44:06 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 22:44:06 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Xu,
 Yilun" <yilun.xu@intel.com>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>
Subject: Re: [PATCH v5 5/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Thread-Topic: [PATCH v5 5/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Thread-Index: AQHdcZDFlkGnPYHfV0O1Ggg/AEnNWbc0eYuA
Date: Wed, 18 Nov 2026 22:44:06 +0000
Message-ID: <e658fad644d8f79afa77f48368f0dcd375554bad.camel@intel.com>
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
	 <20261111-tdx-module-ext-v5-5-c74f764abc3d@linux.intel.com>
In-Reply-To: <20261111-tdx-module-ext-v5-5-c74f764abc3d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|DM4PR11MB5261:EE_
x-ms-office365-filtering-correlation-id: 8ed8d616-39a7-4399-87ca-08df45c573e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|22082099003|261009223027099003|18002099003|11063799006|4143699003|56012099006|261026121527099003|261102123227099003|261102124527099003|261028144727099003|261022115727099003|261026140227099003|261021121427099003|261022105027099003|261021135927099003|38070700021|261021123027099003|261022075727099003|10067099003;
x-microsoft-antispam-message-info: 44dXvAOBj11nPj0WMfbs2c/W2rM3H4/tMInsaRXKj3IHGzDnOx4ScrwG0UWwAXno3NtF3ObMQOkIr+tpmgMX8GqZ1wdCeHCwRlLBHugeMUoWKmoxy1THhbENkl0gkN310TTeOJKbf4eFzHJD4c5cUCaNKLbeJTV34awAq1UiAtX8kzZ9HnU7J+AK5rqdWtq9TZfJUtrr1xGj1TPqW0ZWccGU/AVCuIwtfPHvI5y4BeU91KiSmwO2zxo3Ikk2anBmEHL9xJiv7kz6lTlRvyCHdpoO3RfF2/YbgXs5DPKvKxawKm0EsRB8zyaChJ5eYKL0vA2EmCwxJrJJGr4cD/yR7ySLt/mDeSuDzpMR1YSEjtQSt14dN9cKASGrL8gzK6HFbTym9GvBZH/o8epfnMYiPn7DVVTj3fzUmlmhKOtZzTetGRiVZFMENSJqDBylGaxMHJwCNKJ/yiMxOS0rAHQKXboE/+XA7Smg2fUNvacAuqfSrsX/lrclg9bUZLoOnLcV/506z/pyFZ70c8e1w7sXBuezsV8hkS8J00iIKjxh8bbqeW2KBojCIgxD98BYe3Y4vD7ERSGW2PFTstrjTJdyPpGtfIfnAvGpvBGeDYtsxHrP5QFv5Fw23hc+iewDRr6zi378W4oGx+DnGWST/rJRq13l4AMRanheK069+xLIN3eLZMUH0kk/K/21weTRh/YJyT8/GucRrXoq3EwmFEOmBaS0k+o7dJKEo3CwddDxq8M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(22082099003)(261009223027099003)(18002099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261102123227099003)(261102124527099003)(261028144727099003)(261022115727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021135927099003)(38070700021)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2dIQStZZFdyNStESkdKcGNZYkpuZGYzbEFsUjJteVE1MWlxV05jdmhWMGF6?=
 =?utf-8?B?bGFrWkl5Z1J4K09UZlRzSm5jNTk1RVBiWkNaQmo3Q1Rxb1RGWXN1SVA5VFRD?=
 =?utf-8?B?REl3Q3ZoTmlpcjNCSStIU2lQYnFXMk9mVGNsQkdlc0FkUWZ6TUVJUkxLMHJB?=
 =?utf-8?B?NGZENWR5TTlKNUhCWGJ2TTRQbEtESVhLYXJ2TjhWSGErRSs4dkZjUXZCQlpK?=
 =?utf-8?B?ZkZEWS94TjAzYTF0ZFdzREVjNHpBNTd6WG0yWktJZWdvcW9NMHJvNFVlOUlP?=
 =?utf-8?B?MnBLVkdUUnRsZGN4VXUxLzZFL21aL3oyMzdsL0pQRVVEVnIrd1MzTkhrYnkx?=
 =?utf-8?B?bWdqanZvVVRUdEZDTWlNdEZLc3VtSElBWEs1elU4cGEySW43REFpVFBLRWdq?=
 =?utf-8?B?d1prRFVVTnRtaVZIZ1IzZjI4clI1SFFWWmJ6OXVxcGUvM2xjYk5DTldtMFBC?=
 =?utf-8?B?M3Z5TGRtNDZ4Mk5mRGcyNnpGTEVoWTY1SlNZYkl6UnBoQ0c4QXhQTUtVR1Fj?=
 =?utf-8?B?RmtNRHpSMVRvb1E0N1ByNHJlMUJTNm0rNDFRK0UrUXEyUUI2ZlRTN2ttVUlm?=
 =?utf-8?B?aWNRQ0FITE00VXp2NFdsbmJGTS81UElxNXNLOXg4alJzdlUzTDRNVTZHd0dC?=
 =?utf-8?B?Vm9OQStpN3dyeHFLUzM4Mi9QcU9RTUVzRi9Ca3JJNUdHbnRRdnBCSVN3SWJ1?=
 =?utf-8?B?NHE0bnlLa1RRQjROb2ZPdFQwMld6Z0U1d1VWTEpSYWhKWko3Q2pWZlFQNzB3?=
 =?utf-8?B?dkdBbEF6ZEhzOXZRcmVsdi9qR3JLMGM3a3NEUHErd1lpRGUxQWNPVDN3VkxZ?=
 =?utf-8?B?NENUY0R2Z2FTMjY0c1hUcXMrZ3lPWjhWQklGTm9rVE5YNFBjVFZRVjdLMFlH?=
 =?utf-8?B?VWxKZHNpME5MeGI4amVCYmhoWmJrVFRrM3NsZ21xSlJuZVdmeXJ6TTU1V2dZ?=
 =?utf-8?B?U1grZzBxQUduR0E5bTBZY0RsZHJOY2wwZFQrSk1rMlo1MjFsVHFJSW1lK20r?=
 =?utf-8?B?U2hwdUhnOUVuU29KSUEvcjBiUEN6cnhsZXlZVUNaNHdkNkNuSkdmQTNFd2Nu?=
 =?utf-8?B?RENsejE0VEhOZFhzN1pOaTJwSGYwZ2l1Y0NqOEVCMUhwODRGM3ViT3BHRlRn?=
 =?utf-8?B?ZzhMc1dwdlgrcjF0Q2V3WDBaTGt0cVlsTk9tN3ZIZjIrTHphbGZoVlk4OXpR?=
 =?utf-8?B?WHVJYzM1aisxdDJoTERwMlBCMFUvM3dScWNDUTl5R1QrZVZ6MjNHYUJ2WkNr?=
 =?utf-8?B?QXF6SjJTQ3lEczVzWWJaWEFVZCs1U2ZJTWxjMGlOTXM5ckxxcUc0Y05DRllM?=
 =?utf-8?B?a2FTaFhNcDZXOUhUYzhpZEtaVERKcGtVS1J2Vm54bXdQNEtCdEJrYXNGTmRB?=
 =?utf-8?B?TURFQ29seG1qdHh4M2pVTVhLZTFIRlljOHhxa0V2WXgrT2psSkVIelNteE9h?=
 =?utf-8?B?Y1htZEJGbUlvRVdoRThFVzNYQkp4TEl1dEYwVktDQTMycmJENDNaWVoxQzRa?=
 =?utf-8?B?QW91U1lTQkFkRnphZEVybU5sMHZwNTdCYXRIaUNzSHpZU1RJaUR5bG5TeERT?=
 =?utf-8?B?cjNjVGlMOHFRM2lsRERFT0puRmpKaUtWVXNGR09nSTIxa3A4QWRNazNrSm5M?=
 =?utf-8?B?T055ZGFlYkNYbWF2UnFESm9CdC9ITzlGUkwrVWFCeklobk9jOWRVYWRqd0tV?=
 =?utf-8?B?SnExQ21lcko4UmVWaXBvTUNxU29MVVFyZ2NJODZOcFJML2RKM2ZPeXBsUFEr?=
 =?utf-8?B?MXlaUnMva3haT3hxZkJHM0F6ajVmQ2pLQ3VNcjFEaHFMVGxCVWVRYzVxQWZJ?=
 =?utf-8?B?STgvZ3R2U25EeWlJZ0IzTVM4bjNEU2NIL0NLTElRUkQvdW1ia2cvbnlDT1dj?=
 =?utf-8?B?bzF1YjM5dzBYRHY5aVJLUkRENC9aZyt4SHhic2x3K2taL0V1RXMwaUs5OVBr?=
 =?utf-8?B?dVZjOXZpSlg3MEdkWXFEc1dKUTk4V0ZEN1VHZldIREVyMThVenMxd2MyUkIy?=
 =?utf-8?B?ZWN5VTZIc0VIbWx3NGtJa05VVHl3a0hnTkJQanNjRVJTZnA1U0w1NXgvL3RE?=
 =?utf-8?B?cUIwTy9SdWNJbzlNQjV4MXdZTTByejVPTU5CaUJRQ1RLSkJVRlZMTWE0SWZ1?=
 =?utf-8?B?QmtUSG82R3NucXZtMmVTNmJ3SzVxT0NPckNxMUgzTzVzWjhSQWJWNnpBWGFN?=
 =?utf-8?B?NjVPaW54NDFrVUZjQVJTZnRsa3BIMVNKUXd1V1h2NDFOUmw4RGg1UlFoSEZB?=
 =?utf-8?B?cWlrREtmd3pBTEJJeW5OTURSTHpKMWt1WnBObktaSHZPWDVSZ29LVzJWRlYx?=
 =?utf-8?B?SWpEUFErcVpLd1pleCsraVM3MFR3UkNZQ0c5eDVlZFVyYmhOeEZQVk5zZnRH?=
 =?utf-8?Q?72iS9d5un/RFuHig=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D939E5B3E947D445B81EA8A0B58CDAAF@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: 0TdRsFoVJERp3FRvEJ6qLTO+PB8PdQ2JtcCDcOUiMVJ0BOUSzUwoYRBn1M94YiYSddPFrNRIYn69wcW5SDwJY5ZBZYXtG4kwFhjwCKpTS1t+LrV8MYo8p39C4Z+WMeS64j0QEfgcOxBKt+2wbClf/3M1JLeCSGeSIU1KvhRUyxWyx4L0jrbVRyI4maunLBCDoTpz+C+5xhDi0veWo6+I1D38KqNV10wh9TSDt/WOnjIQMPQkVMB277O5XydKt47FGrg38NhM0gTsLHgKrBPQ9OrYy6LHfAbEP23Kd3myqt28lRsowLBnekK1Wd3juiZYgl8B2V1rGMaTNNZt126vJg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed8d616-39a7-4399-87ca-08df45c573e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 22:44:06.3794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+doLNpyf4QKVTsdL+iGsEUqOFZvXVnJzC+dAakPCs4TY7Rf5yKMC8EzOMV+pgUnwVXTZwSYyZXEO1as4DMYbf3oMDw5dWXbQVYEDAbPJ9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5261
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTExLTExIGF0IDExOjQ4ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gQ29u
dGludWUgZmxlc2hpbmcgb3V0IHRoZSBleHRlbnNpb24gaW5pdGlhbGl6YXRpb24gcHJvY2Vzcy4g
QXQgdGhpcw0KPiBwb2ludCB0aGUga2VybmVsIGhhcyBwcm92aWRlZCBhbGwgbWVtb3J5IGFuZCB0
aGUgVERYIG1vZHVsZSBpcyByZWFkeSB0bw0KPiBpbml0aWFsaXplIHRoZSBleHRlbnNpb25zIG9u
IHRoZSBtZW1vcnkuDQo+IA0KPiBJbml0aWFsaXplIFREWCBtb2R1bGUgZXh0ZW5zaW9ucyB2aWEg
VERILkVYVC5JTklULiBUaGlzIHByb2Nlc3MgdGFrZXMgb24NCj4gdGhlIG9yZGVyIG9mIDEwMCdz
IG9mIG1pbGxpc2Vjb25kcywgZHVyaW5nIHdoaWNoIHRoZSBURFggbW9kdWxlIGxvYWRzDQo+IGl0
cyBpbnRlcm5hbCBleHRlbnNpb24gaW1hZ2UgaW50byB0aGlzIG1lbW9yeSBhbmQgYnVpbGRzIHRo
ZSBleGVjdXRpb24NCj4gZW52aXJvbm1lbnQuIE9uY2UgaW5pdGlhbGl6ZWQsIHRob3NlIGFkZC1v
biBmZWF0dXJlcyBjYW4gdXNlIHRoZWlyDQo+IFNFQU1DQUxMIGxlYWZzIG5vcm1hbGx5Lg0KPiAN
Cj4gTm90ZSB0aGF0IFRESC5FWFQuSU5JVCBidWlsZHMgYWxsIGNvbmZpZ3VyZWQgZXh0ZW5zaW9u
cy4gVGhlIFNFQU1DQUxMDQo+IGxlYWYgZmFpbHMgaWYgYW55IGV4dGVuc2lvbiBmYWlscyB0byBp
bml0aWFsaXplLiBUaGUga2VybmVsIGRvZXMgc2ltcGxlDQo+IGVycm9yIGhhbmRsaW5nIC0ganVz
dCBmYWlscyB0aGUgd2hvbGUgVERYIGluaXRpYWxpemF0aW9uIG9uIGFueSBlcnJvci4NCj4gVGhp
cyBpcyBPSyBjYXVzZSBhbGwgZXh0ZW5zaW9ucyBhcmUgY29uc2lkZXJlZCBuZWNlc3NhcnkgZm9y
IHNlY3VyaXR5Lg0KICAgICAgICAgICAgIF5iZWNhdXNlPyAiY2F1c2UiIGluIHRoZSB1c2UgaXMg
bW9yZSBvZiBhIGNvbGxvcXVpYWxpc20uIEFzIGEgd29yZA0KImNhdXNlIiBpcyBsaWtlICJUaGUg
Y2F1c2Ugb2YgQSBpcyBCIi4gQnV0IHNvbWV0aW1lcyBpbmZvcm1hbGx5ICJiZWNhdXNlIiBpcw0K
c2FpZCBsaWtlICInY2F1c2UiIHdoZXJlIHRoZSAiYmUiIGlzIHNvcnQgb2Ygc2xvcHBpbHkgZHJv
cHBlZC4gU28gdGhpcyByZWFkcw0KbGlrZSB0aGF0Lg0KDQo+IElmIGEgbmljZS10by1oYXZlIGV4
dGVuc2lvbiBhcHBlYXJzIGluIHRoZSBmdXR1cmUsIHRoaXMgY2FuIGJlDQo+IHJldmlzaXRlZC4g
QSBwb3RlbnRpYWwgc29sdXRpb24gaXMgdG8gaGF2ZSBhIG5ldyBtZXRhZGF0YSBmaWVsZA0KPiBp
bmRpY2F0aW5nIHdoaWNoIGV4dGVuc2lvbnMgZ2V0IGVuYWJsZWQvZmFpbGVkLCB0aGVuIHRoZSBr
ZXJuZWwgZGVjaWRlcw0KPiB3aGV0aGVyIHRvIGNvbnRpbnVlIG9yIGFib3J0Lg0KPiANCj4gVGhl
IG9yaWdpbmFsIGNoYW5nZWxvZyB3YXMgd3JpdHRlbiBieSBoYW5kLiBBSSB3YXMgdXNlZCB0byBo
ZWxwIGNvcnJlY3QNCj4gZ3JhbW1hdGljYWwgZXJyb3JzIGFuZCBwb2xpc2ggaW5kaXZpZHVhbCBz
ZW50ZW5jZXMgZm9yIGJldHRlcg0KPiByZWFkYWJpbGl0eS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFh1IFlpbHVuIDx5aWx1bi54dUBsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBYaWFv
eWFvIExpIDx4aWFveWFvLmxpQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFRvbnkgTGluZGdy
ZW4gPHRvbnkubGluZGdyZW5AbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogQWRyaWFu
IEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBLaXJ5bCBT
aHV0c2VtYXUgKE1ldGEpIDxrYXNAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IFJpY2sgRWRn
ZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gLS0tDQo+IHY1Og0KPiDCoC0g
QSBuZXcgcGFyYWdyYXBoIHRvIGRlc2NyaWJlIHRoZSBlcnJvciBoYW5kbGluZy4NCj4gwqAtIFJl
ZmFjdG9yIHRoZSBleGlzdGluZyBjaGFuZ2Vsb2cuDQo+IMKgLSBCZXR0ZXIgY2xhcmlmeSB0aGUg
QUkgdXNhZ2UuDQo+IA0KPiB2NDoNCj4gwqAtIFNwZWNpZnkgd2hhdCBUREguRVhULklOSVQgaXMg
ZG9pbmcgaW4gdGhlIGNoYW5nZWxvZyAoUmljaykNCj4gwqAtIENvbGxlY3QgUmV2aWV3ZWQtYnkg
dGFncw0KPiANCj4gdjE6DQo+IMKgLSBGaXggcmV0dXJuIHZhbHVlIGZvciBTRUFNQ0FMTCB3cmFw
cGVycyAoQ2hhbykNCj4gwqAtIFByaW50IFNFQU1DQUxMIGVycm9yIGNvZGUgZm9yIFNFQU1DQUxM
IHdyYXBwZXJzIChYaWFveWFvKQ0KPiDCoC0gQ2hhbmdlbG9nICYgY29kZSBjb21tZW50cw0KPiAt
LS0NCj4gwqBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmggfMKgIDEgKw0KPiDCoGFyY2gveDg2
L3ZpcnQvdm14L3RkeC90ZHguYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gwqAy
IGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmggYi9hcmNoL3g4Ni92aXJ0L3Zt
eC90ZHgvdGR4LmgNCj4gaW5kZXggMmFkYzVkMzFkMjU4Li5jYWMwYTVhYmJmZjEgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguaA0KPiArKysgYi9hcmNoL3g4Ni92aXJ0
L3ZteC90ZHgvdGR4LmgNCj4gQEAgLTUwLDYgKzUwLDcgQEANCj4gwqAjZGVmaW5lIFRESF9TWVNf
VVBEQVRFCQkJNTMNCj4gwqAjZGVmaW5lIFRESF9QSFlNRU1fUEFNVF9BREQJCTU4DQo+IMKgI2Rl
ZmluZSBUREhfUEhZTUVNX1BBTVRfUkVNT1ZFCQk1OQ0KPiArI2RlZmluZSBUREhfRVhUX0lOSVQJ
CQk2MA0KPiDCoCNkZWZpbmUgVERIX0VYVF9NRU1fQURECQkJNjENCj4gwqAjZGVmaW5lIFRESF9T
WVNfRElTQUJMRQkJCTY5DQo+IMKgDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90
ZHgvdGR4LmMgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gaW5kZXggMzQ0MGYxODc4
OTc4Li4zYTFiYTRlNzNjZmUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90
ZHguYw0KPiArKysgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gQEAgLTEzNDMsMTIg
KzEzNDMsMzUgQEAgc3RhdGljIF9faW5pdCBpbnQgdGR4X2V4dF9tZW1fc2V0dXAodm9pZCkNCj4g
wqAJcmV0dXJuIHJldDsNCj4gwqB9DQo+IMKgDQo+ICtzdGF0aWMgX19pbml0IGludCB0ZHhfZXh0
X2luaXQodm9pZCkNCj4gK3sNCj4gKwlzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzIGFyZ3MgPSB7fTsN
Cj4gKwl1NjQgcmV0Ow0KPiArDQo+ICsJZG8gew0KPiArCQlyZXQgPSBzZWFtY2FsbChUREhfRVhU
X0lOSVQsICZhcmdzKTsNCj4gKwl9IHdoaWxlIChyZXQgPT0gVERYX0lOVEVSUlVQVEVEX1JFU1VN
QUJMRSk7DQo+ICsNCj4gKwlpZiAocmV0ICE9IFREWF9TVUNDRVNTKSB7DQo+ICsJCXByX2Vycigi
VERILkVYVC5JTklUIGZhaWxlZDogMHglMDE2bGx4XG4iLCByZXQpOw0KPiArCQlyZXR1cm4gLUVJ
TzsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiDCoHN0YXRpYyBfX2lu
aXQgaW50IGluaXRfdGR4X21vZHVsZV9leHRlbnNpb25zKHZvaWQpDQo+IMKgew0KPiArCWludCBy
ZXQ7DQo+ICsNCj4gwqAJaWYgKCEodGR4X3N5c2luZm8uZmVhdHVyZXMudGR4X2ZlYXR1cmVzMCAm
IFREWF9GRUFUVVJFUzBfRVhUKSkNCj4gwqAJCXJldHVybiAwOw0KPiDCoA0KPiAtCXJldHVybiB0
ZHhfZXh0X21lbV9zZXR1cCgpOw0KPiArCXJldCA9IHRkeF9leHRfbWVtX3NldHVwKCk7DQo+ICsJ
aWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCXJldHVybiB0ZHhfZXh0X2luaXQo
KTsNCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGljIF9faW5pdCBpbnQgaW5pdF90ZHhfbW9kdWxlKHZv
aWQpDQo+IA0KDQo=
