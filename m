Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9911E7C2E;
	Tue, 25 Aug 2026 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678173; cv=fail; b=iedg96Bk0hcQ8jwXntE2UIfqXWlBO/i9AruGSqGPDtmGHJu57qnP4J1RdrWC7R55bQ4vAFMo15jfijSoO/Uwg3TrV2i8BuM0t/gfeffwEBerOhKiniLxqU1P7NCegAnKKmzq4VMduXUHZe5h04Be1hB8LH3oBuLtEE3arKaeYTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678173; c=relaxed/simple;
	bh=h8hOGlcvnfIMYz+JwlPDIs9CFkRqA9Eb+Vj61h9Aysc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lswnalOMjYaiDlZ/o1zUn5KfuJr6HlqthD03OyoMSIWIwteKa4Apfz13yEoRbjAz/MuO2aFGMAW9Y0zt1VupATaWZt83rXa9A9+fJkErHvbWAnGmRrOIdCK6yfZM3gESzH4hjmLPmymTcbw9xn8PIcXN4Z1gpKfRDIHk8UEbr8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvgd3DjU; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvgd3DjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787678171; x=1819214171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h8hOGlcvnfIMYz+JwlPDIs9CFkRqA9Eb+Vj61h9Aysc=;
  b=fvgd3DjUaMuhNQ3fht3z3YWFxF8xAV6Wgtcqg1c3+e641sXeop5V3Qpg
   38nBMTr4A7myegtWp9uvzFNjQtTSt8vJ49vZDW/rwkSC7ZCFNaHVltICk
   ymgcz80ZDY7Kqkbt2EP4Yle/bivxaXRI3P1G/Dzk+1fDL6+9WkCwrE5IC
   U2toCabnUon4Qz+myWd8GgXnoHDu740jV880fLZSf8h10FYHVlWlB8STj
   amGaszC03KQUqxMJRqsxELrIO9PBagRFMJzi4f9h9asv0z9CkMeuXHkh+
   95+ZsDIdUJ46YLWiVHNXkfHjQ/gixhfr/BZI1P6N8IJjh2GM4cGELeXqo
   g==;
X-CSE-ConnectionGUID: 1zvdFtDySnaLgiMMCx858w==
X-CSE-MsgGUID: 4j5c7nJhTZCDln0Hc/QBbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99499253"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="99499253"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 10:16:10 -0700
X-CSE-ConnectionGUID: Zr6hDLLMSB+IxDunkeDe9A==
X-CSE-MsgGUID: AJpbPPo/S+2M0tebv3e3Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="266037722"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 10:16:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 10:16:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 10:16:09 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 10:16:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSfds9ednwLHPli5AhnABJ25orjR8uU/K2lgAB7yDnekublR1tWPr5LfDPT6jrHTwFcZNEqxSpQzwYRIx0SlwEqNE7d+VhI43C4BHqjVzvZgyf5cZahSkUkPUQMRvSqhG52Qedk8MVJ+CFc6SwGVXXNRqQ1UfF1XvbYAipG58RK724Up+Q6Iuln8s6H2ZoTJGW3IQjS90WLtN535DbxiOAKE9OmjvHQT233xvMNaF+3oHubMV74m2ZdT/Svd/qJ0HjHrw3kwy/GPnJF3wboV1SEthadruIRGSQGhkubDKaWV+GM2dYaXT/fxupYv2bIon9CKli0mstJb+HkomS8ugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8hOGlcvnfIMYz+JwlPDIs9CFkRqA9Eb+Vj61h9Aysc=;
 b=TJMm47DQ1JqdW8GmbVWWD02eRmuIZFSYmSiqNnpl+f3+3QZN5VW5uk/bGWxAdQpoaIY8i2Mll18q2kngXd0ZqQpozHT7W3u5HzrKQIGEqJYriVeVWRqskOJ7HQHXBM4s6fFKEedrtMnN8/Sr/axUk7zdAIiNIZRbKEYzDzknT6Xstk5iYvBXKuLHfbycslhgdB3m5vvBCm1uX7WLYnbVvac2o2V3KiFupcYIESBiZ2j9f+8Z/xHIg069npT0GXPjttkPMgNjO3X0OQ0frN32xFgZvYPrac+mZcuCer9BK0mmsZlWYUyFvmM+CX0L+Y8J0A2zcEZOdhoS6f4okCJhaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DM3PPFFCD58DF03.namprd11.prod.outlook.com (2603:10b6:f:fc00::f63) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Tue, 25 Aug
 2026 17:16:00 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 17:15:59 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "sagis@google.com" <sagis@google.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@kernel.org" <tglx@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/virt/tdx: Warn on !4K level in tdh_mem_page_aug()
Thread-Topic: [PATCH] x86/virt/tdx: Warn on !4K level in tdh_mem_page_aug()
Thread-Index: AQHdND1FpRR2p2rutEOa7iAk6ZY7/ravAlCA
Date: Tue, 25 Aug 2026 17:15:59 +0000
Message-ID: <1f12e12f1d5e7baed6630fd15cea5420c40ada68.camel@intel.com>
References: <20260825025533.25663-1-yan.y.zhao@intel.com>
In-Reply-To: <20260825025533.25663-1-yan.y.zhao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DM3PPFFCD58DF03:EE_
x-ms-office365-filtering-correlation-id: 56ad2167-496b-4b09-3d27-08df02cc88ac
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|38070700021|56012099006|10067099003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: fpQ2afbpHthUG/c5u9ptaazGWU8uz6ckRJwjuTD3qV7TFuticzdKVSjhkBQf65w1L34Z4HHeHe1RooInn+4O89BXh5os3toIUvybiVKwm3OFr2OE/NjKpNN+2ObihYtVxiYYgR7TWViO6REJ+ZcBCoMGobMkeQz9BOgkvTqlZ7xIYdk0QTh6M8CuJimm3x4N3NKKCmdXAnAa60NBbP82nru9H+LMS54GmMEptsB2NtGUD1vRdT9F+mMv6X5AxF8HjVPLpUNrDqyzhmSjWdRBHkz4TLPLx6T90R7nWmv76kjG1C9IjVP1FZQMG3MnUQv4dKCG+U+cyShrrMcl5akCtbYPhsgoDO8mJyjFZBYNe/jpzT14LYZug6kwYlEBQ7rx5epyl7cTX5PK60SnI8QxAlQbUM8ku51EInzZTwDbjiG86ibLQa0youWJk6NPQdNyCnBYceLtsjnaC9KF8hNnKhsi9ZK3eYDLk8AI8d20uyyn8Sz6gqyCQitfrpNMgKRX5X9UwXG7U2XeS/ZXkDfl/DjFvoKHJC0Zo2ueE6hS1kPpUMPheFQ5ZP7DFurH4uADJqRhl73/qi5jiOTDMp1fZJGlmWVrU2YX1hmfqY1addwqG7fRmxLZtHg6gSUPvDXbOm0p1zxdrnBKMxJhVvEs7UPQTnNWooCkhvSBDRh7AZkxzkO1+sJnAOgMo4+kwV+jwkqnDnrnsKNbCS6Lpirfe+JUNj4dxvJBy8jH5Kn44j4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(38070700021)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWpGS2dBMkFJbEpvSHZjZzlpbjVZbElYSlVDVkFmSkNzdFFGUzg1YkhCa3h6?=
 =?utf-8?B?WFhWVU14eU9KREN2Ynl6ZnVjOEs2ZXYrUFNzNDhpMkg3V1lmRjgvdEJuUEEy?=
 =?utf-8?B?OTg1RnFLNjJ5cnFoWlRrTDR1SXdBMVlNN2hPRCtBbzFuY2F0OUhsLzRrdlVV?=
 =?utf-8?B?TDlQV2xzSm8rWTUzMEkzMUEwanpuY2NTUDZIUUhwRXlBb3ZXTm9XejBHU1J2?=
 =?utf-8?B?K2xDaUJHR2Z5cTR4SW1JTUJONklLeVJwRGhCUTV3RnM1KzdaRlRlanFmditW?=
 =?utf-8?B?TDA4QlVSb0NzWFZVSTh4b01lQlkraEdoY3VtS2pKeC9SbUVKRExpRzUrdlpa?=
 =?utf-8?B?c3Y1MElCT0FwYmgwdVlQVFk4aXpadldGVXI0cE1SYWZVZFJxRG1VRFJqVGtj?=
 =?utf-8?B?ZUEzZHhrL1AxcVZYdkJUQWZydmlEQzEycGdjaEE3cjI5anlOSzVUcURCNXMx?=
 =?utf-8?B?eFpaSzV5cVV3Yk02Qi83NU9KYVFqSVUwZEhreGZqcy9mZ3huSVFHbW1oVVFw?=
 =?utf-8?B?ZW5VWjVyR2xZM0x5d1l5VXhjZHBLVnlCbmUzSDBEV2plU0xUeEZybmd0cW42?=
 =?utf-8?B?SnBTTDdDVE5wdlRiY045MEdTeERsNi8xMmpheGg4MGNsY0FvdC9rZGxPSStE?=
 =?utf-8?B?WHlkVkVpOE9wK2NLeGZMUUNFVXdnMTdCRGVqMkFRZlZqaE1uenJ4MWtMaTFC?=
 =?utf-8?B?c2V3c1VIejR1aXlHTEJmZXBSM0hOTTR6N3JTR1NpTGFFd3JIZjkrV0d0S3Er?=
 =?utf-8?B?citJS2ZXRDBUVXQzTjB5eC9wcEY0a3NOalpJWmN3dDYzVnQ3V0F5R2NXL0Iy?=
 =?utf-8?B?T0tnMVJUd2JMQWE2M3RDYndrNDBoaDllclNYM3RyeEYwSjIrcDlpS1ZNdStO?=
 =?utf-8?B?TGlBdEJMTXE0MlVKbUJ2dUxsYUM0bjlxbFNqSWtpMnk2Rkg0SkZuWDU4c0d1?=
 =?utf-8?B?eE5uaWJUeHJaeTJkcitycTNSSU5uQSs3d0ZtU3hqblE3YVVXbWNGcUpEQ1Fs?=
 =?utf-8?B?SWJOaEpQWmxIMTZQVVNlNVhPaVBHSXRWSUF2Tkp1ZTZ4S0N0ZDBjMFVjOFA1?=
 =?utf-8?B?eFhNL3FGQ2t5YXJrMnFZejFSL29DcXZEcmZiWHpQUyt1cStxTGRyS0FzK2tY?=
 =?utf-8?B?UkUwYzUxR3o5U0NsS3d3R0pmTm9QTlpNaHRFbC9kSjB2c0lHd0tXTWtMcmpH?=
 =?utf-8?B?a3hNaFd0TDZucjQrVWtCKy9ScnovSHFWcFl6a04yY3JDREZFY3lhUkNZeTlU?=
 =?utf-8?B?NU1SZ3JYYXl2UXhXSkgxckRmS0krUDh5ckZacjkyL3QrT2RzNzc3RVZCUmRH?=
 =?utf-8?B?czExSllHZlUwWjhFMVcveFFFZU1PSjByTHB3YzMrZDV4Z0tOSDlzT2hDT2xQ?=
 =?utf-8?B?aUM2eVZFKzFmUU5naWhxbjkvYXpBZERZeUJhdHdxVGw2Qjhnc21FcXZ1R2R3?=
 =?utf-8?B?SmdOZkFGMDlZTnkxOC90OWFUdlZkNmVFZ0pPLzJWdHN0TjVQVjlDTEQybGp6?=
 =?utf-8?B?NzQ2RTdrNmp3Q08wOUJoU2dSVU5sWVUxc0xKaEtuamZlQXlkWDM4Y3JTc0dQ?=
 =?utf-8?B?K2NiZlRZUmxaUERQd1Y4U1EvK2JIdytXOGhTbjJzdzdLWEVJS1BPbnErUy9h?=
 =?utf-8?B?RVpjT0tCcklVUUg4dXphSjhDWVZscmE0anY0aGJ3YnZPblUvUTF1MXZmSUhO?=
 =?utf-8?B?VTgyeXZTNHB4YU5Xa3RvTWVWQzdtRDAzY3QyMW8vVVhWVDdkRWM3Mk1yaHYz?=
 =?utf-8?B?T1d3YTJmWFdYT0tZdE4zL3hsYTljajhOUmJBcXZ2SnFUejNoQ2JRUjNTVGpX?=
 =?utf-8?B?bDMxUHZrbkRZcFJFenk0dTdocWNTdW1yRWZRTGxDdEk0VUszbU1Galp2TW1M?=
 =?utf-8?B?MHRjdzRhMWUxb0Y2eVU4ZFhiUXpmWFpINEJiS2VXTzduS0ZqVVNWZlJTS2tJ?=
 =?utf-8?B?b1dpTzRZdFE4ZWlheHlqVXZMZi84dTExc05ucGpmSUwyT004RlM4Z1B4VGM3?=
 =?utf-8?B?OTNFWWFZZXM4K0UzSEVBQk9leFZaYnZNVVlad3VmVjNhTlVxUUptMXhWQWJB?=
 =?utf-8?B?YmlxTjFhMkloZGI4RlBjdFRHNFRiRWorVTIzR2JuekJKRmNVeXh3RmhiSkxz?=
 =?utf-8?B?eS9ramt2SWdmZW04cElRRjgyRjA4M3Z3Y3VNZ05ORHBzWWZUSGtLWjRZelBX?=
 =?utf-8?B?VStIZWZLcjVDTEdqMTR6ekRUbWZIbEZ1WFkwUVI2ZFpzTitXSXpESnpyTUlp?=
 =?utf-8?B?cWljRGFjMlhSdnN1SFhTZ3NHL25ZeXh5ZGxhSEdqSVIvcWxESlpKLzJYV3dR?=
 =?utf-8?B?U0JPaTRzM05jbTRBRWRxWmMyUDVISnFBMHNVZTRseFo1eHRrSVdwRUFvOHkr?=
 =?utf-8?Q?tju+HpJ5yW5aNazg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F473B53EE2CC394DA666852E8122BFF3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iG5zr8JiwxKjGgSQE5SWKsFJEGWe5tFel4tBru47nY+yJGjSN6rWvvIYQLseMytHilY3tsYXafj3Oi3TotfA3lELkkubUOXmqA0zBIUVDj8WhDDI4eeHj6l6omkLh4zC970xxUIm083T9E9D0lr6JvgQfRoJpRdE7X6TbL5raojO8u0hpliKRNSTm1jypK5iGErfxqG8YsTrtxhVicLlG4WYO7p91LQDNB7+FwjSRwwOgTAK+Mv39Qk/S1jAgNIVjDjbMiGPpgJvbEMJ6hiSocL42nKmkh16GklQcKg1mLfqvIr8u39yGgLh+ARHzvE3SIPsQ+TbSaB+Ug0igN5OhQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ad2167-496b-4b09-3d27-08df02cc88ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 17:15:59.9104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hiAT0SXaGzp+eOfRT2Vi78/g4SBIyetY7WgmPhZ58nHizISkKPCMQakPBYH0ViRVuIQUGRAATW7Y7SEaozHuDJTZfGWub9/i7JOl4iG4N7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFFCD58DF03
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTI1IGF0IDEwOjU1ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gRG8g
bm90IGRyb3AgdGhlICJsZXZlbCIgcGFyYW1ldGVyIGluc3RlYWQsIGFzIGl0IHdpbGwgYmUgbmVl
ZGVkIG9uY2UgaHVnZQ0KPiBwYWdlIHN1cHBvcnQgaXMgYWRkZWQuDQoNClREWCBhbmQgY29jbyBo
YXMgc28gbWFueSBwbGFucyBmb3IgdGhlIGZ1dHVyZS4gQW4gYWJub3JtYWwgYW1vdW50IG9mIGNv
bmN1cnJlbnQNCnRoaW5raW5nLiBJIHRoaW5rIGV2ZXJ5b25lIGFncmVlcyB3ZSBuZWVkIHRvIHdy
YW5nbGUgaXQgYnkgZG9pbmcgdGhpbmdzDQppdGVyYXRpdmVseSwgYW5kIGNoZWF0aW5nIHdoZW4g
aXQgY29tZXMgdG8gdUFCSS4NCg0KU2luY2Ugd2UgaGF2ZSBURFggaHVnZSBwYWdlcyBjb21pbmcg
c28gc29vbiwgaXQgc2VlbXMgb2sgdG8gbGVhdmUgaXQuIEJ1dCBJIGp1c3QNCndhbnRlZCB0byBz
YXkgaGF2aW5nIHRoZSBsZXZlbCBhcmcgaGVyZSBvcmlnaW5hbGx5IHdhcyB3cm9uZy4gU28gdGhp
cyBzaG91bGQgbm90DQpiZSBwcmVjZWRlbnQgZm9yIHByZS1lbmFibGluZyBvZiB0aGluZ3MgeWVh
cnMgaW4gdGhlIGZ1dHVyZS4NCg==
