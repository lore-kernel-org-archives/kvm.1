Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793666261;
	b=qQhn8+zdXUj1fURVh6QSANps74xw7mhLK8zxZxYBv5fFutG23KIx6kOhDIyA3w/iYRGh
	 6qxXx7YOx63VE3FTTrxEiOGqOKR8caS1m6l0l7m7UxbLgyVk2VMhutOPFtO/kNhMeN4Pd
	 ZiAqqajYaDVFnS6tdfdhfCyZJohxHpWtb5VT5igf30jwUO5EmnKCYx6l1kxdBjZAO27jB
	 hginzFdVPgxU9ic2B3O59q9yjTSFPiofM6szliScGoBhwLQwp8skJqAoXEhJ3R5Dlk70g
	 puvPGahTWJtGMuoYCx2h9n273lKR0VJ3HrHRitRVJLDM5+GPPWiyar6TFkd+kFRxsXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666261;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=5bWZWDGmETMirUtKgkIR+ZW3ouGGc6VMr6DTrR8WN6Y=;
	b=Z2VUjZhftA4y7b5helZffefFr4szc21J+duQ/S51omTnNFT2/2tmllnzFqUae3mtjE3P
	 k7NQphOy2xbGH4I3KGRAHYF3XgDkb2U+hH0xC0a59lNcTIYLEkESP7qrSTnG0huaF7QLY
	 j8l1WkmuMqZXd7kfn1/Q7RtRQDJU0+vlDabCoMlrgBd2gatbVQ7wtgvkQwlchTWR2SV8e
	 5UhdRZgc3fdO23917Tcar18PdnhS9Me7sM2XjO8tjHrVhVcI76PEMmFnKl7usk9zg21E/
	 xkVeTKB3CmZ0vmbRYlhUn/YwAM1YJauAn+zM2FeIJK2xfsr1WjAY+KabouEfnQrN7Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="KkK/x26H";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76419606A326;
	Tue,  3 Nov 2026 00:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76419606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KkK/x26H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793666259; x=1825202259;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5bWZWDGmETMirUtKgkIR+ZW3ouGGc6VMr6DTrR8WN6Y=;
  b=KkK/x26HRyMS17lznD7KrJMh1n9eJVlyIa9tCYWLqpeuPd/t+Xv4iYbk
   daxQI8JBFTwSmDoLhb5s4NPbMxBhJLOy2zPL2IYH05Q0yY+d+vWta7GIC
   87YNI8lZ5HHVjNmfu3HwGF0ATzR6QCkMfx48Do1R06GVxh+ZxpGFeRU39
   OH6UpIXCyA9V9P6Mo49V4Kani20dkRBY9h5NYbq2SXQc0gxWNUm0QeONN
   1Yh8A0fRbGu+qHVIcDsKFsqF1lBuI+1rNCnvYqnxGVaEDFMbWrk4NDNM7
   sHXSk6vmoWZBqODWk3Zke537JrG7NMLg02pxQhgEo2zsvAkrk5/VL0waO
   g==;
X-CSE-ConnectionGUID: EY8NBZtRRAyDaORlsB444A==
X-CSE-MsgGUID: cQwOBiMcQHWlimXtROgwEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2254340"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2254340"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 16:37:37 -0800
X-CSE-ConnectionGUID: DQvnH216QTSbr4D5tU/oTw==
X-CSE-MsgGUID: rmCXApczR/Sgon8XxMHrZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6389051"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 16:37:37 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 16:37:36 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 16:37:36 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 16:37:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/OXzsTw4PtDEOV3yz6z25HzjjnZJBhAJF7s9I7rGv/2idF5hRnNY159fqoYKRtIKmq1XgPpzBydwfblm0J7IX60OwbHo8DzTPMzS3NG8RDME6IaNnPOVC4t1Aach03vC+a767MzPgYOvrwmw7VJqAiRPrM2eI+TqBPb40hJyEHyG5cLRUvpTgVJAp7+nChfZgFF/2hKKnEWDrikyz6Fk4MSXRu58cS66lLD0iUhpc8bktPYSx6qEuOoOtYb11JXJ/saH7rGpEYpP31UDU8HJTl44eNXT+/nPkZKksHTLK0O3W131gwK4QRUc6a4Q34lexQ033fOSw1CvAmyhC0GQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bWZWDGmETMirUtKgkIR+ZW3ouGGc6VMr6DTrR8WN6Y=;
 b=kFDfXhjs0vuaFk3r/LTitzw4WFw86j81MQalObmpdPpYMsIBsvAEWI1s9YHErtbWoD/0o5JFJ1pX0TCgn/64gvg8NVi2UIV5O2Qs/eGyx9jPn1cCXh23torrFo/YO/gJyKbFcSYtbPiCjCksvYwzlJj2piwNnSR0v572F5XUlCSi047lUsLma4aPUlff4/j+auFOnpNT9lGa21wXy3RPiJAS2DHeLLgdm9gtG4C1oFqcZYLjr2wQb+t+C4OqOilZfxQQ5KPeeA3yHIP6e4xfil3N3x1YbjxQZB5H17qJRCipb7JGldEk/uYWq4Odq8hnzC/bKgS7zM6YHgOxngThVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS6PR11MB281697.namprd11.prod.outlook.com (2603:10b6:8:529::12)
 by LVTPR11MB9888.namprd11.prod.outlook.com (2603:10b6:408:3c3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 00:35:32 +0000
Received: from DS6PR11MB281697.namprd11.prod.outlook.com
 ([fe80::e581:a963:8374:69ba]) by DS6PR11MB281697.namprd11.prod.outlook.com
 ([fe80::e581:a963:8374:69ba%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 00:35:31 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v1 2/3] x86/virt/seamldr: Support large TDX module
 binaries
Thread-Topic: [RFC PATCH v1 2/3] x86/virt/seamldr: Support large TDX module
 binaries
Thread-Index: AQHdaEwsYrmr5AG/40OgnVz6HCwBV7cbhdwA
Date: Tue, 3 Nov 2026 00:35:31 +0000
Message-ID: <396de152b28fc1be18bfd61fd0ee7501c188e661.camel@intel.com>
References: <20261030085304.3886520-1-chao.gao@intel.com>
	 <20261030085304.3886520-3-chao.gao@intel.com>
In-Reply-To: <20261030085304.3886520-3-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS6PR11MB281697:EE_|LVTPR11MB9888:EE_
x-ms-office365-filtering-correlation-id: 10b57141-53de-4afd-a860-08df39425e03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|10067099003|22082099003|261102123227099003|18002099003|38070700021|56012099006|11063799006|4143699003|5023799004|261022115727099003|261022075727099003|261026140227099003|261021121427099003|261009223027099003|261022105027099003|261026121527099003|261021123027099003|261028144727099003;
x-microsoft-antispam-message-info: zMSNw5JjDu9iv4G5f/edbNySclrUKKOV4BAA8aE2GdSg4K9pv3S+1E0+GKeQVzq59OcFuWuSibnOhA6GPWQUlXyCrFU6Zh+IqteGrwJvGQbInnkdVhWTQ+Qdchlsj4GPpvUsmNLygW9QHDHyM1PwoZyvSaUcSJ2U32v3egkuLRjbs5yuWjTFn2pZyHMfQVK5+4bGWV1BcyWiW/zqCtNFsBnRWzi4SpHiYLdI3Tn01mDCAHQ0OFtwpNsW/TEU0/+PXDDUUW/KclfkrSOE9Qw2UZ++3JT9boX9jFuFeZhqjKv4rHZetgZ/CL6GrqoyP2fGLyvjZoQJNGcxIMJT2CRWqleXMTGBRB1IHkxhvXFhD3wIWqZQyiOK/qAVaKP0xk1TyD1FZ26bJ4/tXsO0hwgV1SuERegVDEE0utXdSSvieQPHZHy9JhJoSr5Busohj/AffIqR6fdQGIIpx787KaXoJGzHlap+4KNq8HF3ZFmyExXCVDmJErcLg7qVZagNObsEUkiFQqhVIFg86ycdrO1oUW/pgOC5FPmTnPBCis6lHQ6CIDfxCgq2s+ok2u97Ida7jwofP3PDx+0fO2VBrn+yg839+WDCvKJUJCg+lwpnNtGIeWFWnmcH+kpHUqOHp1LH4nQT9UBPV4+jaelk9i2f2X2V458CzrbspKPmFo4Qq5QcLQ2wV5IF9AVVkpVEPyNzciWrGyKHNunBRccFK9sTmqW5g7Zk+w0C3G1KxLbBc28=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS6PR11MB281697.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(5023799004)(261022115727099003)(261022075727099003)(261026140227099003)(261021121427099003)(261009223027099003)(261022105027099003)(261026121527099003)(261021123027099003)(261028144727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0RiSlR0amN5a001YTlhY2RVbDFmNHZLRDV3Qlh4V0RrMnhEZ09KVHl4cGNt?=
 =?utf-8?B?cjh6YXI4T0swRUgvNlE4Z1hsNDJsNHlhb3U0QzFjT0xjVSs3QWVlYmlmVGVj?=
 =?utf-8?B?ZjN0dUp0bkloYzlNWHNJelIrNlFZWXJQVFFQenc2ZHpmM3BUOTJDcnUySDIw?=
 =?utf-8?B?cG5mSFBUU1Z2RkNTRTA2S2kyNHl2TnpzdlMyNEVhcE1Hc2I4YTcwNVJlRXFo?=
 =?utf-8?B?WnU1QjZvRWFmWS92ZTNuM3BXdFV6OC9pdDR6L2ZXTzhOU3BndU0zdmk5T0xI?=
 =?utf-8?B?ZFB1b2dkOWxoYnJpcnMvR3hFak13U0dwbzBWL01jQnpxbU5xV1MwMm5sazhi?=
 =?utf-8?B?LzQ5T2VlRFVWM2VPdUdmRnNPc2JZdE9FSFBOK05pNk5tTlZvZHJ1RTU2OGxE?=
 =?utf-8?B?eFFXMzJJMUgxaVcxYkUzOUdBbDdtWVVqcnRmM3lPYXo3dkhndHFrS1JtVTVz?=
 =?utf-8?B?TzB6bHlBNnYveHpzL0FFeitnd3pXMVZpcUlnM2N1a2NTaUF5ems4NFFGa3Zr?=
 =?utf-8?B?RThiL1FHYldJcS9MVFRCelp3VTVjVWtpWDNrQlBQOExQalEzNU95S2xWcitp?=
 =?utf-8?B?QWhiM2ZISFAyUmlRWnd1NFZzOStSVmR5MmxWcGl5K3kvRTFIWnIzYUkxRmZB?=
 =?utf-8?B?VVdxWnNqdENqSUd1VGEwK1I4MGl2blRrY0dtOStRQWVQV2dqZ1FwVlBrek5Q?=
 =?utf-8?B?YzYydDlvckF3MG5yUUl2QlFETHFiY1AwblVZNUlYWTlUckVGN2ZOUXdZaEZE?=
 =?utf-8?B?WitNZ01tcFlRYVphVHFJQkJPc2cremNMemxPRElOdUdaQUc2dDY2c1gvN2pW?=
 =?utf-8?B?clFGdGdmbnE0ZHh0TFcrdjZXVjhsek90Snp0YzFFeDRoQ250ci9LazFnVFUw?=
 =?utf-8?B?a3N4a054V3RtNXFyZ2gxK2tYaTZPRDAvUlJ5Wkhva3NEdjJoSWIrUHI3TzRZ?=
 =?utf-8?B?bGxnclFQdG1ESFRYei84enh2QjdheWtTeUZURUVBRy9vVVc2UWtMTk5UblVy?=
 =?utf-8?B?SStjbkZVZVNpNmMzazNiYXlBTWdtOUkzWFMxcnh1dkFBNDB3VU14azNFM2ln?=
 =?utf-8?B?dVNVSHZhRzBaVW1JNmhiOG5sV0p6dHFGNTczM3k0ZXQ1YU13Z3ZWMS93UmZt?=
 =?utf-8?B?SXhNb3FIT2hJQ1h1M1BmMmtYV2xtdnhnY0M4dm1NMnAyMFRFN1RKZ1hYYzcv?=
 =?utf-8?B?c1RWR2FkWjQ5YXFBTy9DY2lMR0N5VzNjOWkxZnhIT0hvVHc0MTBKdmdhamZI?=
 =?utf-8?B?dFQza2JjcXk0anRSWDJ4TWZLeVExNG5YckVYVkliZVIxUGs5dmpud0lCWnhG?=
 =?utf-8?B?alY1aC9kNHJoTG5vRE9HdmVtZ0V1OEVMYVJDZi9qZWtab3Q4dWQ4MUVLcU9Q?=
 =?utf-8?B?ZVR6WHc0YmRjdEpOYWpsWjJOSFRTODY4akhQSFBzMUlPaHZDYi9ESkZpTmFL?=
 =?utf-8?B?WFRtUCtUTk1ZS210ME82d3F1VDFLOG0xbFdValBMdmpyWmJHNHhFZHNCWTRj?=
 =?utf-8?B?STJEYkk0QjByUVNXTjNXdi9rUDY3d3c1NzJmbEJjNnB2SlpZd3dnNzJSSjRB?=
 =?utf-8?B?SlM3NXFpY3JIQjZxdjVVUklVZENIVkVCNmY0NEFvV2hFSVprZUhvSDYwL0Z2?=
 =?utf-8?B?UHYyV3NKYy9UaVIxeklaQzF4RUtMZ0lPbklGa1dhUHlmMjlQczFKYkEyMStn?=
 =?utf-8?B?M1FzemZKN21IWUZDRmFEckM5RUpJWHlZQ05XTlBwTHF2N2kwWEFGSlRoaEVP?=
 =?utf-8?B?MkFVS2JrZHpHem5iSm1hMmlxdWM0bHQ5N2hiOEJMWjhyVlZidGtkcXZUZ0Yw?=
 =?utf-8?B?N3A0OVdnSng2bHJzQWgwWlcxZVNVT3dhVi9mT1M3L2dEd2QrMGJMOXYrZmtL?=
 =?utf-8?B?K3dMeFRQTldTNWZoaFQ0ZU44c0Q1bTJjTFU2bmdoVStBWXRMdHdRdmRUN05K?=
 =?utf-8?B?V2NoYldlZWNyK1REVkczamFSTm5VMWgzN3dvWWduTGtqREEyeVlyVytPeUZs?=
 =?utf-8?B?MVB1WE9UZ0NRNHhmTnd0TVVScUlxOWM2a3l0VmlUT0xBd1pZZ3hWc1hyZFRU?=
 =?utf-8?B?Q2JHaUlqdmFEWG1GT0wrc25UdFNrYzR1a3BxbWpMQ2xZNm1TSHRWTTVuUVQ0?=
 =?utf-8?B?cjVkaGh5Nk9Wd1pOTnRlYXljRFlwQS9nUHJqS08vNFY4ZFRScTZOT2NrOWRE?=
 =?utf-8?B?MW5DdGhpTlRhWVBGMms3NVJSdCtoU3laVktaMklXVWM3eGQ2NGsxQWtvWDJI?=
 =?utf-8?B?Nm9UL3J4aVU5YmxhOGQxMDNiMUJUQVNWSnBVa2FZNFRWOWRBTDRjTUtpdjg4?=
 =?utf-8?B?NVdaR1BuVEc4TkZ2bEhIUzg2QU1tbmpaVzBqZGNvNFhhem52RVdLc2JxR1Zw?=
 =?utf-8?Q?LLm5n9niX5pXbtWs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4288282BD8120649A4FEF95CDF50AC8A@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: uZ22JKQ/KCo437a0jiYcGMJM4bqxcupq7Nrpk2SLpvJ95MSkhWqQk+ujnPQ/1XRAKXv2AcV80OeTZor4cOu1l9rtZFAZXiYad/XLSWa+ipsfKY0xqdzJEACrxHTAWiJmngcJJyN8y+VsWtkDlbMkRrwZfciTN+7VmDTe8q+QOSla6LhAZLkHDKVzJUIDX9wDbn8o0J+yFko16jzQCTsPqUA24f4FKosqZVo7vWNwTy/jPzPSb3bomhjyx2bEXiKj2IjL+NupRznz8MpbvVOP8nnFeI3o+2Ul2vMRxG1L+kA/h23y2Fvku/6IQBctqs/pNN3ArFg2PUXYfZYCgbO49A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS6PR11MB281697.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b57141-53de-4afd-a860-08df39425e03
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 00:35:31.7288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kB3nrvUADt8MTQ+CTru3gOtVKI/MlsAkkw/UhqQwEu/jqcoSKdcchZggfa87B8cMkIXrcbVnRwG2H3n2UrD7oEArwGcSCDGMM5Kn3DB7OI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR11MB9888
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTEwLTMwIGF0IDAxOjUyIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVGhl
IG1vZHVsZSBiaW5hcnkgaXMgaGFuZGVkIHRvIFAtU0VBTUxEUiBhcyBhIGxpc3Qgb2YgcGFnZSBw
aHlzaWNhbA0KPiBhZGRyZXNzZXMgaW4gJ3N0cnVjdCBzZWFtbGRyX3BhcmFtcycuIFRoZSBsaXN0
IGhhcyA0OTYgZW50cmllcywgd2hpY2gNCj4gY2FwcyBhIG1vZHVsZSBhdCA0OTYgcGFnZXMuDQo+
IA0KPiBURFggbW9kdWxlcyBhcmUgZ2FpbmluZyBmZWF0dXJlcyBhbmQgYXJlIGFib3V0IHRvIG91
dGdyb3cgdGhhdCBsaW1pdC4NCj4gDQo+IFRoZSBQLVNFQU1MRFIgQUJJIHdhcyBleHRlbmRlZCBm
b3IgdGhpcy4gQW4gdXBjb21pbmcgcmV2aXNpb24gb2YgdGhlDQo+IFNFQU1MRFIgc3BlY2lmaWNh
dGlvbiBhZGRzIHRoZSBmb2xsb3dpbmcgdG8gdGhlIGRlc2NyaXB0aW9uIG9mIHRoZQ0KPiBtb2R1
bGUgcGFnZSBhZGRyZXNzIGxpc3QgaW4gJ3N0cnVjdCBzZWFtbGRyX3BhcmFtcycuDQo+IA0KPiDC
oCBGb3IgVERYIG1vZHVsZSBpbWFnZSB3aXRoIGxhcmdlciB0aGFuIDQ5NSBwYWdlcywgdGhlIGxh
c3QgZW50cnkgd2lsbA0KPiDCoCBwb2ludCB0byBhIG5ldyA0IEtCIHBhZ2UgdGhhdCBjb250YWlu
cyB1cCB0byA1MTEgYWRkaXRpb25hbCBIUEFzLiBFYWNoDQo+IMKgIHBhZ2Ugd2lsbCB1c2UgaXRz
IGxhc3QgSFBBIHRvIHJlZmVyZW5jZSBhbm90aGVyIHBhZ2UgaWYgcmVxdWlyZWQuIFRoaXMNCj4g
wqAgY2hhaW4gY29udGludWVzIHVudGlsIGFsbCBtb2R1bGUgcGFnZXMgYXJlIHJlZmVyZW5jZWQu
DQo+IA0KPiBBbGxvY2F0ZSB0aGUgbmVlZGVkIGNoYWluIHBhZ2VzIHRvZ2V0aGVyIHdpdGggJ3N0
cnVjdCBzZWFtbGRyX3BhcmFtcycsDQo+IGFzIGEgZmxleGlibGUgYXJyYXkgYXQgaXRzIGVuZC4g
TGluayB0aGVtIHVwIGF0IGFsbG9jYXRpb24gdGltZS4gVGhlbg0KPiBmaWxsIGluIHRoZSBtb2R1
bGUgcGFnZSBhZGRyZXNzZXMgYXMgYmVmb3JlLCBidXQgc2tpcCB0aGUgbGluayBlbnRyaWVzLg0K
PiBBIHNpbmdsZSBhbGxvY2F0aW9uIGxlYXZlcyBub3RoaW5nIHRvIHVud2luZCBvbiBmYWlsdXJl
IGFuZCBrZWVwcyB0aGUNCj4gZXhpc3Rpbmcga2ZyZWUoKSBhcyB0aGUgb25seSBjbGVhbnVwLg0K
PiANCj4gRG8gbm90IHF1ZXJ5IFAtU0VBTUxEUiBmb3IgY2hhaW5pbmcgc3VwcG9ydC4gVXNlcnNw
YWNlIHNlbGVjdHMgdGhlIHVwZGF0ZQ0KPiBpbWFnZSBhbmQgaXMgcmVzcG9uc2libGUgZm9yIGVu
c3VyaW5nIHRoZSBtb2R1bGUgaXMgY29tcGF0aWJsZSB3aXRoDQo+IFAtU0VBTUxEUi4NCj4gDQo+
IENoYWluaW5nIHJlbW92ZXMgdGhlIDQ5NiBwYWdlIGNhcCwgYnV0IHRoZSBtb2R1bGUgcGFnZSBj
b3VudCBzdGlsbCBuZWVkcw0KPiBhIGJvdW5kLiBXaXRob3V0IG9uZSwgYSBjcmFmdGVkIGhlYWRl
ciBjYW4gb3ZlcmZsb3cgdGhlIHUzMiBtb2R1bGUgbGVuZ3RoDQo+ICgnbW9kdWxlX25yX3BhZ2Vz
ICogUEFHRV9TSVpFJykgYW5kIHBhc3MgdGhlIGltYWdlIHNpemUgY2hlY2suIEl0IGNhbg0KPiBh
bHNvIG1ha2UgdGhlIGNoYWluIHBhZ2UgYWxsb2NhdGlvbiBleGNlZWQgS01BTExPQ19NQVhfU0la
RSwgd2hpY2ggd2FybnMNCj4gaW4gdGhlIHBhZ2UgYWxsb2NhdG9yLg0KPiANCj4gUmFpc2UgU0VB
TUxEUl9NQVhfTlJfTU9EVUxFX1BBR0VTIHRvIGEgMUdCIHNvZnR3YXJlIGxpbWl0IHRvIHJ1bGUg
b3V0DQo+IGJvdGggcHJvYmxlbXMuIDFHQiBpcyBmYXIgYWJvdmUgdGhlIGZldyBNQiBvZiBjdXJy
ZW50IG1vZHVsZXMuDQo+IA0KPiBUaGUgc2l6ZSBvZiBtb2R1bGVfcGFnZXNfcGFfbGlzdFtdIG5v
IGxvbmdlciByZWZsZWN0cyB0aGUgbWF4aW11bSBtb2R1bGUNCj4gcGFnZSBjb3VudC4gRGVmaW5l
IGEgbmV3IFNFQU1MRFJfTlJfTU9EVUxFX1BBX0VOVFJJRVMgZm9yIGl0Lg0KPiANCj4gVGhhbmtz
IHRvIFlpbHVuIGZvciB0aGUgaWRlYSBvZiBhbGxvY2F0aW5nIHRoZSBjaGFpbiBwYWdlcyB0b2dl
dGhlcg0KPiB3aXRoICdzdHJ1Y3Qgc2VhbWxkcl9wYXJhbXMnLg0KPiANCj4gQUkgd2FzIHVzZWQg
dW5kZXIgc3VwZXJ2aXNpb24gdG8gcmV2aWV3IGNvZGUgYW5kIHdvcmtzaG9wIGxvZ3MuIEl0DQo+
IHNwb3R0ZWQgYm90aCBwcm9ibGVtcyB0aGF0IHRoZSBzb2Z0d2FyZSBsaW1pdCBhZGRyZXNzZXMu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIEdhbyA8Y2hhby5nYW9AaW50ZWwuY29tPg0KPiAt
LS0NCj4gwqBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWxkci5jIHwgOTUgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDkwIGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92bXgv
dGR4L3NlYW1sZHIuYyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC9zZWFtbGRyLmMNCj4gaW5kZXgg
MzUxM2ZkMjg1MzZhLi4wOWM4ZjZlMzBlOWYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3ZpcnQv
dm14L3RkeC9zZWFtbGRyLmMNCj4gKysrIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1sZHIu
Yw0KPiBAQCAtMjQsNyArMjQsMTQgQEANCj4gwqAjZGVmaW5lIFBfU0VBTUxEUl9JTkZPCQkJMHg4
MDAwMDAwMDAwMDAwMDAwDQo+IMKgI2RlZmluZSBQX1NFQU1MRFJfSU5TVEFMTAkJMHg4MDAwMDAw
MDAwMDAwMDAxDQo+IMKgDQo+IC0jZGVmaW5lIFNFQU1MRFJfTUFYX05SX01PRFVMRV9QQUdFUwk0
OTYNCj4gKy8qDQo+ICsgKiBBcmJpdHJhcnkgc29mdHdhcmUgbGltaXQsIGZhciBhYm92ZSB0aGUg
ZmV3IE1CIG9mIGN1cnJlbnQgbW9kdWxlcy4NCj4gKyAqIEl0IGtlZXBzIHRoZSBtb2R1bGUgbGVu
Z3RoIHdpdGhpbiBhIHUzMiwgYW5kICdzdHJ1Y3Qgc2VhbWxkcl9wYXJhbXMnDQo+ICsgKiBwbHVz
IGl0cyBjaGFpbiBwYWdlcyB3aXRoaW4gS01BTExPQ19NQVhfU0laRS4NCj4gKyAqLw0KPiArI2Rl
ZmluZSBTRUFNTERSX01BWF9OUl9NT0RVTEVfUEFHRVMJKFNaXzFHIC8gUEFHRV9TSVpFKQ0KPiAr
DQo+ICsjZGVmaW5lIFNFQU1MRFJfTlJfTU9EVUxFX1BBX0VOVFJJRVMJNDk2DQo+IMKgI2RlZmlu
ZSBTRUFNTERSX01BWF9OUl9TSUdfUEFHRVMJMQ0KPiDCoA0KPiDCoC8qDQo+IEBAIC0zNCw2ICs0
MSwxOSBAQA0KPiDCoCAqLw0KPiDCoCNkZWZpbmUgU0VBTUxEUl9TQ0VOQVJJT19VUERBVEUJCTEN
Cj4gwqANCj4gKyNkZWZpbmUgU0VBTUxEUl9OUl9DSEFJTl9QQV9FTlRSSUVTCShQQUdFX1NJWkUg
LyBzaXplb2YodTY0KSAtIDEpDQo+ICsvKg0KPiArICogQSA0S0IgcGFnZSBob2xkaW5nIHRoZSBw
aHlzaWNhbCBhZGRyZXNzZXMgb2YgdGhlIG1vZHVsZSBwYWdlcyB0aGF0IGRvDQo+ICsgKiBub3Qg
Zml0IGluIG1vZHVsZV9wYWdlc19wYV9saXN0W10uIEBuZXh0X3BhZ2VfcGEgcG9pbnRzIHRvIHRo
ZSBuZXh0DQo+ICsgKiBwYWdlLCBmb3JtaW5nIGEgc2luZ2x5IGxpbmtlZCBsaXN0Lg0KPiArICov
DQo+ICtzdHJ1Y3QgY2hhaW5fcGFnZSB7DQo+ICsJdTY0CXBhW1NFQU1MRFJfTlJfQ0hBSU5fUEFf
RU5UUklFU107DQo+ICsJdTY0CW5leHRfcGFnZV9wYTsNCj4gK30gX19wYWNrZWQ7DQo+ICsNCj4g
K3N0YXRpY19hc3NlcnQoc2l6ZW9mKHN0cnVjdCBjaGFpbl9wYWdlKSA9PSA0MDk2KTsNCj4gKw0K
PiDCoC8qDQo+IMKgICogVGhpcyBpcyB0aGUgIlNFQU1MRFJfUEFSQU1TIiBkYXRhIHN0cnVjdHVy
ZSBkZWZpbmVkIGluIHRoZQ0KPiDCoCAqICJTRUFNIExvYWRlciAoU0VBTUxEUikgSW50ZXJmYWNl
IFNwZWNpZmljYXRpb24iLg0KPiBAQCAtNDgsMTAgKzY4LDEzIEBAIHN0cnVjdCBzZWFtbGRyX3Bh
cmFtcyB7DQo+IMKgCXU2NAlzaWdzdHJ1Y3RfcGFnZXNfcGFfbGlzdFtTRUFNTERSX01BWF9OUl9T
SUdfUEFHRVNdOw0KPiDCoAl1OAlyZXNlcnZlZFsxMDRdOw0KPiDCoAl1NjQJbW9kdWxlX25yX3Bh
Z2VzOw0KPiAtCXU2NAltb2R1bGVfcGFnZXNfcGFfbGlzdFtTRUFNTERSX01BWF9OUl9NT0RVTEVf
UEFHRVNdOw0KPiArCXU2NAltb2R1bGVfcGFnZXNfcGFfbGlzdFtTRUFNTERSX05SX01PRFVMRV9Q
QV9FTlRSSUVTXTsNCj4gKw0KPiArCS8qIEhvbGQgbW9kdWxlIHBhZ2VzIHRoYXQgY2Fubm90IGZp
dCBpbiBtb2R1bGVfcGFnZXNfcGFfbGlzdFtdLiAqLw0KPiArCXN0cnVjdCBjaGFpbl9wYWdlCWNo
YWluX3BhZ2VzW107DQo+IMKgfSBfX3BhY2tlZDsNCj4gwqANCj4gLXN0YXRpY19hc3NlcnQoc2l6
ZW9mKHN0cnVjdCBzZWFtbGRyX3BhcmFtcykgPT0gNDA5Nik7DQo+ICtzdGF0aWNfYXNzZXJ0KG9m
ZnNldG9mKHN0cnVjdCBzZWFtbGRyX3BhcmFtcywgY2hhaW5fcGFnZXMpID09IDQwOTYpOw0KPiDC
oA0KPiDCoC8qDQo+IMKgICogU2VyaWFsaXplIFAtU0VBTUxEUiBjYWxscyBzaW5jZSB0aGUgaGFy
ZHdhcmUgb25seSBhbGxvd3MgYSBzaW5nbGUgQ1BVIHRvDQo+IEBAIC0xNDMsNiArMTY2LDY4IEBA
IHN0YXRpYyB2b2lkIHBvcHVsYXRlX3BhX2xpc3QodTY0ICpwYV9saXN0LCBjb25zdCB1OA0KPiAq
dm1hbGxvY19hZGRyLCB1MzIgdm1hbGxvY19sDQo+IMKgCX0NCj4gwqB9DQo+IMKgDQo+ICsvKg0K
PiArICogTGlrZSBwb3B1bGF0ZV9wYV9saXN0KCksIGJ1dCBza2lwIGVudHJpZXMgcG9pbnRpbmcg
dG8gdGhlIG5leHQgcGFnZS4NCj4gKyAqLw0KPiArc3RhdGljIHZvaWQgcG9wdWxhdGVfbW9kdWxl
X3BhX2xpc3Qoc3RydWN0IHNlYW1sZHJfcGFyYW1zICpwYXJhbXMsDQo+ICsJCQkJwqDCoMKgIGNv
bnN0IHU4ICp2bWFsbG9jX2FkZHIsIHUzMg0KPiB2bWFsbG9jX2xlbl9wYWdlcykNCj4gK3sNCj4g
Kwl1NjQgKnBhX2xpc3QgPSBwYXJhbXMtPm1vZHVsZV9wYWdlc19wYV9saXN0Ow0KPiArCWludCBp
LCBqOw0KPiArDQo+ICsJZm9yIChpID0gMCwgaiA9IDA7IGkgPCB2bWFsbG9jX2xlbl9wYWdlczsg
aSsrLCBqKyspIHsNCj4gKwkJdW5zaWduZWQgbG9uZyBvZmZzZXQgPSBpICogUEFHRV9TSVpFOw0K
PiArCQl1bnNpZ25lZCBsb25nIHBmbiA9IHZtYWxsb2NfdG9fcGZuKCZ2bWFsbG9jX2FkZHJbb2Zm
c2V0XSk7DQo+ICsNCj4gKwkJLyoNCj4gKwkJICogU2tpcCBub24temVybyBlbnRyaWVzLiBUaGV5
IHBvaW50IHRvIHRoZSBuZXh0IHBhZ2UgYW5kDQo+ICsJCSAqIGFyZSBwb3B1bGF0ZWQgZHVyaW5n
IGFsbG9jYXRpb24uDQo+ICsJCSAqLw0KPiArCQlpZiAocGFfbGlzdFtqXSkNCj4gKwkJCWorKzsN
Cg0KV2Uga25vdyB3aGF0IHBvc2l0aW9uIGluIHRoZSBwYWdlIHRoaXMgc2hvdWxkIGJlIHJpZ2h0
PyBDYW4gd2UgZG8gc29tZSBtb2R1bHVzDQphbmQgc2tpcCBpdCB0aGF0IHdheT8gRmVlbHMgbGVz
cyBoYWNreS4NCg0KPiArDQo+ICsJCXBhX2xpc3Rbal0gPSBwZm4gPDwgUEFHRV9TSElGVDsNCj4g
Kwl9DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3Qgc2VhbWxkcl9wYXJhbXMgKmFsbG9jX3Nl
YW1sZHJfcGFyYW1zKHUzMiBucl9tb2R1bGVfcGFnZXMpDQo+ICt7DQo+ICsJc3RydWN0IHNlYW1s
ZHJfcGFyYW1zICpwYXJhbXM7DQo+ICsJdTMyIG5yX2NoYWluX3BhZ2VzOw0KPiArCXUzMiBucl9k
aXJlY3Q7DQo+ICsJdTY0ICpsaW5rOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBOdW1iZXIgb2YgbW9k
dWxlIHBhZ2VzIHRoYXQgZml0IGRpcmVjdGx5IGluDQoNCiJmaXQgZGlyZWN0bHkiIGZlZWxzIGxp
a2UgYWRkaW5nIGphcmdvbiB3aGVyZSB0aGVyZSBkb2Vzbid0IG5lZWQgdG8gYmUuDQoNCj4gKwkg
KiBtb2R1bGVfcGFnZXNfcGFfbGlzdFtdLiBNaW51cyBvbmUgYXMgdGhlIGxhc3QgZW50cnkgaXMN
Cj4gKwkgKiByZXNlcnZlZCB0byBwb2ludCB0byB0aGUgZmlyc3QgY2hhaW4gcGFnZS4NCj4gKwkg
Ki8NCj4gKwlucl9kaXJlY3QgPSBTRUFNTERSX05SX01PRFVMRV9QQV9FTlRSSUVTIC0gMTsNCj4g
Kw0KPiArCS8qIENhbGN1bGF0ZSB0aGUgbnVtYmVyIG9mIGV4dHJhIGNoYWluIHBhZ2VzIG5lZWRl
ZC4gKi8NCj4gKwlucl9jaGFpbl9wYWdlcyA9IDA7DQo+ICsJaWYgKG5yX21vZHVsZV9wYWdlcyA+
IG5yX2RpcmVjdCkgew0KPiArCQl1MzIgbnJfbGVmdCA9IG5yX21vZHVsZV9wYWdlcyAtIG5yX2Rp
cmVjdDsNCj4gKw0KPiArCQlucl9jaGFpbl9wYWdlcyA9IERJVl9ST1VORF9VUChucl9sZWZ0LA0K
PiBTRUFNTERSX05SX0NIQUlOX1BBX0VOVFJJRVMpOw0KDQpMZWZ0IHBhZ2VzLCBtb2R1bGUgcGFn
ZXMsIGRpcmVjdCBwYWdlcyBhbmQgY2hhaW4gcGFnZXMuIEl0J3MgYSBsb3QuLi4NCg0KPiArCX0N
Cj4gKw0KPiArCXBhcmFtcyA9IGt6YWxsb2NfZmxleCgqcGFyYW1zLCBjaGFpbl9wYWdlcywgbnJf
Y2hhaW5fcGFnZXMpOw0KPiArCWlmICghcGFyYW1zKQ0KPiArCQlyZXR1cm4gTlVMTDsNCj4gKw0K
PiArCS8qIExpbmsgYWxsIHRoZSBjaGFpbiBwYWdlcy4gKi8NCj4gKwlsaW5rID0gJnBhcmFtcy0+
bW9kdWxlX3BhZ2VzX3BhX2xpc3RbbnJfZGlyZWN0XTsNCj4gKwlmb3IgKGludCBpID0gMDsgaSA8
IG5yX2NoYWluX3BhZ2VzOyBpKyspIHsNCj4gKwkJc3RydWN0IGNoYWluX3BhZ2UgKnBhZ2UgPSAm
cGFyYW1zLT5jaGFpbl9wYWdlc1tpXTsNCj4gKw0KPiArCQkqbGluayA9IF9fcGEocGFnZSk7DQo+
ICsJCWxpbmsgPSAmcGFnZS0+bmV4dF9wYWdlX3BhOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiBw
YXJhbXM7DQo+ICt9DQoNClRoaXMgYWxsIHNlZW1zIGxpa2UgbW9yZSB0aGFuIHNob3VsZCBiZSBu
ZWVkZWQuDQoNCj4gKw0KPiDCoHN0YXRpYyB2b2lkIHBvcHVsYXRlX3NlYW1sZHJfcGFyYW1zKHN0
cnVjdCBzZWFtbGRyX3BhcmFtcyAqcGFyYW1zLA0KPiDCoAkJCQnCoMKgwqAgY29uc3QgdTggKnNp
ZywgdTMyIHNpZ19ucl9wYWdlcywNCj4gwqAJCQkJwqDCoMKgIGNvbnN0IHU4ICptb2QsIHUzMiBt
b2RfbnJfcGFnZXMpDQo+IEBAIC0xNTIsNyArMjM3LDcgQEAgc3RhdGljIHZvaWQgcG9wdWxhdGVf
c2VhbWxkcl9wYXJhbXMoc3RydWN0IHNlYW1sZHJfcGFyYW1zDQo+ICpwYXJhbXMsDQo+IMKgCXBh
cmFtcy0+bW9kdWxlX25yX3BhZ2VzCT0gbW9kX25yX3BhZ2VzOw0KPiDCoA0KPiDCoAlwb3B1bGF0
ZV9wYV9saXN0KHBhcmFtcy0+c2lnc3RydWN0X3BhZ2VzX3BhX2xpc3QsIHNpZywgc2lnX25yX3Bh
Z2VzKTsNCj4gLQlwb3B1bGF0ZV9wYV9saXN0KHBhcmFtcy0+bW9kdWxlX3BhZ2VzX3BhX2xpc3Qs
CcKgIG1vZCwgbW9kX25yX3BhZ2VzKTsNCj4gKwlwb3B1bGF0ZV9tb2R1bGVfcGFfbGlzdChwYXJh
bXMsIG1vZCwgbW9kX25yX3BhZ2VzKTsNCj4gwqB9DQo+IMKgDQo+IMKgLyoNCj4gQEAgLTE5NSw3
ICsyODAsNyBAQCBzdGF0aWMgc3RydWN0IHNlYW1sZHJfcGFyYW1zICpidWlsZF9zZWFtbGRyX3Bh
cmFtcyhjb25zdA0KPiBzdHJ1Y3QgdGR4X2ltYWdlICppbWFnZQ0KPiDCoAlpZiAobWVtY2hyX2lu
dihoZWFkZXItPnJlc2VydmVkLCAwLCBzaXplb2YoaGVhZGVyLT5yZXNlcnZlZCkpKQ0KPiDCoAkJ
cmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+IMKgDQo+IC0JcGFyYW1zID0ga3phbGxvY19vYmoo
KnBhcmFtcyk7DQo+ICsJcGFyYW1zID0gYWxsb2Nfc2VhbWxkcl9wYXJhbXMoaGVhZGVyLT5tb2R1
bGVfbnJfcGFnZXMpOw0KPiDCoAlpZiAoIXBhcmFtcykNCj4gwqAJCXJldHVybiBFUlJfUFRSKC1F
Tk9NRU0pOw0KPiDCoA0KDQo=
