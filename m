Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792684622;
	b=kbuQcEnqwM+bFBcwXT0rhMEGP+GbEHL4320dipQ2lMVvc8+G2+feYbSXtIsyllHaPV6l
	 TiZU8v8l5zekiPMPEgAnBnu2VdO5kuzgx8wfV4iiRVhXRKwewKzohBRY+2SYp4jphNcau
	 Y6RZ4RE0Tq49bVEz52vRlhvwsvGTcWGODubihQgzWvMYaSMeJUGWFhamR8qvDXfXOYucl
	 jIF5xVeh155CRCe+4RU5ssaRKeCQOoRNmM1+eorGo30hF1KuzCC4KHw0dh5hfZbrz5A46
	 zZjWQwkciFFpd7HpPe3iWC1/+Wu5j+/2rIIaWBFbeYi+O3AWTLxQ1L7tBhj34p/6bew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684622;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	bh=NrcVEaMWXgezEmWhEiNyOX7rUYb2KcfZOqiVvU67Tso=;
	b=oSnC3eU3oqkolt6HgCI9FA+NavJwQzSj2sh5/ZZ28GXxF932d1YzeEXxjzPSUNT/TB66
	 dQDl1xPDjiP1ishccGIriek8vCClgZFkVp7swMPe/0nmD+sznjbZurnu6FkC3bz80Oe46
	 fIeRN4RLQgWdX9f5tTIegUna8Uxz1/jTftmb0dRtVDUigXoyQ3sWvWA1yu27saz6++8sm
	 R9aMpGC1qdDoK8m9cffEyCoZGpQIvj7ifwCkjznG2Knhxppv/1rKU60rrFNUwIT/bt0hc
	 1k9FF6qmrPiEnj9qrxb7Jvrvw3pANlI6puBPDjL0So6zKqTRV5JHbvMJ8gVwZR9uTog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eRM2r9YI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946B606A31A;
	Thu, 22 Oct 2026 15:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7946B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eRM2r9YI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792684622; x=1824220622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NrcVEaMWXgezEmWhEiNyOX7rUYb2KcfZOqiVvU67Tso=;
  b=eRM2r9YII8vPtEaq3TfrhnYH+QapD/uo5lLSX8Z3fnDD4jvOYRrCOAU9
   yDRcd/62Y0u+gddVVx7/+XUKLZ6/u+ZkStmGg9rtavdYkCA1usZmkxbdl
   IuhBTz6dKVh3U6rqLdms0L9rsB0Bjx2Ml3TkoIawskRG1pIcjSH3rof0F
   g10qfeEIUqu7gW18cYigEP0yloLTV7DqW8Yljhxs3c85W9fssVSlkS8Zq
   Nr1FOprn3nJC0oRCwWLe06QOpruOmDZOIqLzybuaodhQXwIumdNxgjbYD
   Oy2xk7ldcZ3pXF01uJGZnyFQQ8+Rc1ea8JJ9oaoDhUv5Dtl9f9v342PjE
   w==;
X-CSE-ConnectionGUID: eriuD3GdSY2UNGPG3K9Dtg==
X-CSE-MsgGUID: 4XxuZL1PTN6zBCTzR/Dtjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1447720"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1447720"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 08:57:01 -0700
X-CSE-ConnectionGUID: PJfESZGGTEOThFcVzqT3SQ==
X-CSE-MsgGUID: bZ8kE4sKT0SE8hiEze1Vrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3439178"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 08:57:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 08:57:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 08:57:00 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 08:57:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kn67GCbnV62lZp5jGcNMEi6agF+n8T9sTMe06jU+tiIEvkDUfMkDGFZ8AMVCwaTN9TTHE8Zj1e57eEUUscWXFYf6/cP7MC8Xhdv70MXga+lsuEn+Gz6oeW5vffoOJLovgTKm4gTYSWnyslYpEA9vcpeeNrfUIzXIZY/J4ylFxoOsFhP685WtX33hono1QarwUL6fyI28WAuOqJxxPYL1+S4jpWOFrc+hD13cNPEBjZizTO1n2vjVwIJyy7OAaBadXoLKWfdfeDRCnGDLAoCnYYCTlCyicAOIPB3uFSfWTzSsLfF9Kic6DWQIeHpkq6dIhQm/QTJw/1JzX0MPSr6AQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrcVEaMWXgezEmWhEiNyOX7rUYb2KcfZOqiVvU67Tso=;
 b=DcEed5CGmSA02BNO0BCeuWTCNPGz2yjZmrHb7KcPGR8dpkRlr2pmr2RVA+GRF11rLPpePS2oZ4ho0GvvElqgI2Ah5+lradZ8Dmqps4vADwrZfPdDFV+ZHwIS6uhka+TE3KeS/ApxwDxp0NYp3GO+eSPJmX0ELsXwLJ8Ejky+vSDaApAtp0d1l1xjZ+91UgYCKRkKPgaY8pCa3vRKIIfLH8JaWTL3Lc05IJmWYtywfk+W9k/bVQIjOpY6/13Eh7m0kQUkw1s/jqpe922RNYJHTrN+D0AFAx6FtIsvyZwoSPLqs4SLHnhGZcguA61vdXoi+ydVyqr/NF/nDwnt71ApTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by SA3PR11MB7486.namprd11.prod.outlook.com
 (2603:10b6:806:314::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Thu, 22 Oct
 2026 15:56:47 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 15:56:47 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kai.huang@intel.com" <kai.huang@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "tabba@google.com" <tabba@google.com>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Topic: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Index: AQHdTylT2fDCHY1RikeRNXt5wj90e7byvXkAgAApaACAAhZUAIAA2vcAgAB1o4CAA+N3gIACbDEAgADZdgCAAKsxgIAA0reAgAVHxQCABHwBAIAAldoAgACPGoA=
Date: Thu, 22 Oct 2026 15:56:47 +0000
Message-ID: <55ccf641218c6553b2f43f4394b92c23bd8b5d98.camel@intel.com>
References: <asivFAotV10NIZQL@yzhao56-desk.sh.intel.com>
	 <594befb577b9142dc0c90b7be5bb65888a3a2523.camel@intel.com>
	 <asnJcZsKdDzgaYzc@yzhao56-desk.sh.intel.com>
	 <ae995b5ec798491c3a5511fc44b6308e9664a53b.camel@intel.com>
	 <as8UwKoAaT/1HgNr@yzhao56-desk.sh.intel.com>
	 <71682b712350b5270e4a0f5cddceb1da12341b9d.camel@intel.com>
	 <atBaxwAG84jlOywE@yzhao56-desk.sh.intel.com>
	 <25927de50b85816956e8989f402ff6ccfa8fa0ba.camel@intel.com>
	 <atV5fDnckj+3V0D/@yzhao56-desk.sh.intel.com>
	 <ca53c3bd37218828822a9b990a0900ca2541fd9e.camel@intel.com>
	 <atm6NBNrwYc+Y8yo@yzhao56-desk.sh.intel.com>
In-Reply-To: <atm6NBNrwYc+Y8yo@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|SA3PR11MB7486:EE_
x-ms-office365-filtering-correlation-id: 2b49ff5b-8a5e-403a-e13b-08df30551409
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|38070700021|56012099006|11063799006|4143699003|261009223027099003|22082099003|18002099003|10067099003|261021121427099003;
x-microsoft-antispam-message-info: I+2AEV3azmZAAA6aG6hk2OkQ2YiP0hJIUuxBZ1hymz11WJQLCFeWfR3pK4pd5rQjwRMHlV5qfZG7cCF4trzdl999vbI85bvesnfTm94svWqE8PuvaI1YoCXdRH1aV7+kQ14P3pS99cslM4kYLquA0uIx1/HZ1Q6H3t7u8PqixuFJhOgXa9dmFYsKPht48LfqwmfIiOao+3zObeXri7mlsZNeS2XlH0rteppkhvZVzoAZiv5Y9WX+jLHzei+136RF9Vb7/CJ8Ue0sIDt2oKi70Tzq7vLFcN0BoddL0rxUOEU56YgMF9hgjFC4HVIBMkjydrHwStFsYtYxB56NYvuflH6twI8S5Ue5BBoCd9pgb53cdOgsHVUvU8e9ua2fHSN8bfdsHOOpuhgG8qKcBGDLP7I+aWnpL+80E/btjEAy9eDrajOX7H0vgTlJiEP/pRYTyDPFRPU5uRNxhfTQTKuEOS63M0CSVZfzxzwkkzHkb1O+RN24nwETdw1Y75n41rgBTk6cpMItNHj0A7y0pk0U5IEuC0LKSag+GDkVDFvFcvtN9cy9bsw+lIzjY36amItTzTyMeeGuaCPQK9gUo7m5ZL9FuosiqLsmcXBtc5r7VyyN05TtMliqk2pSzzXdhlAh/UmuwjyKJX+zJ5psVwT6KpKmh7hcsRr9Wfh1oFtWwseKQ2Pxz9vrF4Mx8kIhz8a/ARjeBW4AkJiArr8RpGS1rSI4C6TPtrTaM5cQg4awOvs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(22082099003)(18002099003)(10067099003)(261021121427099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enpUazV6clVhRXg3N0FJcjRiV3hJazcxcWVDWUc2dWdOb3hwOGJ0NVU3Q3d2?=
 =?utf-8?B?NFpIVkZyM2pMQmsxK1d5Ni9CVGc0NDZVNnZQQ2Z6M0o0d3l4UExaRXJGMFJp?=
 =?utf-8?B?cGJIYndTUUtNZThzczhLREtpcHdidzhrb2VVUEJpTkV0UVNEbkdXZ2VSZWl5?=
 =?utf-8?B?eWpZakNpNUIwTmRCUUNmNGdrbTlTT1ZpVVNrRmh6Tk5SREhhVXBlYXFGZGNn?=
 =?utf-8?B?ei9jTHhMZFlsM2EzVDF0T1YzeUNsK1p2L3Y0c1V6Wm9HK3BiZXc2ZHpidml2?=
 =?utf-8?B?ZVdLSGhtNytwSkVyTHRmbEdJZC96SzdGam5ySkZ3TXJmYXptMVNmNHVCTHRK?=
 =?utf-8?B?WVIwT3F2ZGpzQWxoV2x5cFJYU1poYXhyQzA3N0pPRDVkM3ArdHc5RzI2S1FB?=
 =?utf-8?B?YXF1cGJra1hkZE12bjh3V0ZCRlBCSnZ1K0NheUtubGI2dVQwTkMzMjNoL21T?=
 =?utf-8?B?Yk45TEhIMEYzRFQwVkNBWG9IOVZKS3hvbTZ1YlB0WkxIYjlYOHBDTTdzbE95?=
 =?utf-8?B?cDk5dFNxazFtUkV4SHNxYUc2UW1HQWtVRnZoOWhWQkxaR3dJN3RWRkRseGpa?=
 =?utf-8?B?NlhPTlpGN3RoVVoyWjRXMHphaTVnNUtOeS80WU1XbVgxRUNHanhaVTZab0Ex?=
 =?utf-8?B?SlRPWUdWS0YvWWZmTWNwNXVRYm5JT0d5R2JTYTNqZGlxalU1N1JBSE1FdVdM?=
 =?utf-8?B?cnFlLzhqcmxaYU42NTI1RStNdVFNRU92WndGQ2dVdC9sTWRwVFNweVNJNUZ0?=
 =?utf-8?B?SXJ1ZzBXTUlLZ25XazJYS0tpenVpOGFkT1lXcE5nMS9rTzN0OSt2b21wQjha?=
 =?utf-8?B?c3BiSVhJdlJhYUdvbWhnRnZuSVpCZWZ5VzlDOGVpc3BWREJka3o5b1U4M0du?=
 =?utf-8?B?Z3B3azl1QWRxZ2ZUdnl1emJhcyt5UkNXdzdzaUtlSnM0VEozcTJyNHlVVi83?=
 =?utf-8?B?S1Q2RFNwRTdoNE9kUHQvR05jeHJWKzhudUQxRFNMbGh0WVRvQzhCRWRUcDhX?=
 =?utf-8?B?eHVGcnQxV3FnbUV4NDlRSFh4VzZNZmlwZmlZMEV2cGlaNkJHYU1JRWJTREtY?=
 =?utf-8?B?UklrRnlTOVRBQVREZXFONWZlY3pqQ3Vnd1JmREVTamRUVVBGYkdJV1B0TFp1?=
 =?utf-8?B?ZHpYeXpuQXMvOUoyb2hnbVRVWndMYS8xVUVXdzNERHdvNjZFS3BwM2FYQWN1?=
 =?utf-8?B?RE5EdEpqdUhXS09JVFIvM05ROTUxN080am9HMWcxVVRsck90ZTRuc0V6WDAr?=
 =?utf-8?B?Rld2bUVhbFJid3E0cU5kNFFUL3B0cHZHSnVoQkU2NU5PQW05U0RpUHRzNnF0?=
 =?utf-8?B?YllHblBIY3hSMEVUOGhxT0ZCbldoTXg1bHRSaUg2T2d4REdocUM5eTdvNGhI?=
 =?utf-8?B?bjdrQmNqRVYwNThDSExuaHlOUlVyTk8wUUdhOFhjMnIvSlJZeUl5WHhCRTlM?=
 =?utf-8?B?MTZWeVpnRm1oRG9BYUgrOVhKVTU4SE5peDg5VGdoM1BkQ2FaZGhhUUwxQ2o2?=
 =?utf-8?B?YXhKZXdYQVdwTTNnaUNDLy9QOEpmaVBuWkVYYjV3UGtXbXpOUTdkOTFUWDVr?=
 =?utf-8?B?Y1dQUW9uSmZYTUdGc2QxT2NIWVhpVlNDQ1NETDlaeGU2VnQ5bmsvcnZiMjhT?=
 =?utf-8?B?bXhUcW5rYjNOQ0NBOXV6dEgzYWF5eVdjbFlRRFY3T0x1c3RFZC9uSHVqSFlF?=
 =?utf-8?B?aTZ0UitkL0pTUnFuUWVmQjlRcDkyd1hQVFhMS3hYN20xV3h5WTYvbisrRFJZ?=
 =?utf-8?B?cHU0WlUvZHRwUDJmeW1DQ0E5ZFRsWjhmT1RVc2VXYjdnaStNUUE5eENFSE5D?=
 =?utf-8?B?bmlvZElmS3hXS2pSVlUyYXBFTktRbmI5K2tHMTJwNmhPa2JUREtTdVQyMEVw?=
 =?utf-8?B?VFlDMzlzdTY1Tzc2TjVtbmYrMWt3MU84OXZYZElnSFFCM1RVMVhsajJITDZ5?=
 =?utf-8?B?U0FZOXJtMnI1TkZVbXZzVEMybnBCZmhKSm4wUmFUYll0VFV5ckJsVWVwUXhF?=
 =?utf-8?B?YjcvNDZmc3JNVm12WFI1NzdvS3poNXEyYm5xOTdnd0JiOWNRRzloNk1IeFZO?=
 =?utf-8?B?Zjg4ZGlncWVyMWNWKzhLV3k4TXVOcU9hc2xuR1ZCNFlmL3dPeU9ERjRmdmli?=
 =?utf-8?B?eVRSNi9ZQmVzczcxenozaGNpa2RaaTdTdHVPVHVYek0ydFBjRHZrQVVCNllW?=
 =?utf-8?B?VnlDR3VNd0lMUFhYSFovdEZmYTJ4cG1vK3BhNTJ3eG9QQnU1VytHS2NESFBD?=
 =?utf-8?B?KzIzeXlQMm9BNHVUYkVJV0c4TERPR0Z3b2JCMnhzcDV2TmFhUlBMVUhtUnJK?=
 =?utf-8?B?WXk3bEtvL29ySDk4d3prVTFFTGkrWkpVTTdrczRDMy9IYkhQVjFkYlZwdE5s?=
 =?utf-8?Q?41+n4pKw9DCCJRWU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8265149DF200B48A36CCB79770C67C1@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: go8QM+Puv6aZANXmiTcraQFKJYfPTjsB1eC9Yfg59ByhCrhLtAxq48K6ObvGbTcXjdzZsSL9v08Z/S+0Jy+Kb4jkShoTr8nvB7wPGTM7t0B7ulpV74Ar0LYjJepc+bMeK27s5pN01XOjd2FF2C4Q4ZxV0cwm5ehuZKfpG7Hgv/GqZmIrSnpDQCZzv9sMUgZqdn7Tjd9dextu6FF2yIH5VbLARACzhXfanw2CpQeFjWulleFCVzynGqqR3tXUeR4w8mdqJib/W4mAPNLPpXljfsRPeTCHNMzU99XZMLIsioY8CBrwqiUYIVaoQ0q/D4iSM2YQNaZy0abCOWX4QX13MQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b49ff5b-8a5e-403a-e13b-08df30551409
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 15:56:47.6231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoHjMK7cCsA+y2sS0BFD83Im4BbmuXECIdvRh5/MaXizW3AJu14Lvt+rjaODoNX2QZcVeVKNhWtdV7UqoYP+WdTnbowNwklfF0zl43GIBR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7486
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDE1OjI0ICswODAwLCBZYW4gWmhhbyB3cm90ZToKPiBzdGF0
aWMgaW50IHRkeF90b3B1cF9leHRlcm5hbF9wYW10X2NhY2hlKHN0cnVjdCBrdm0gKmt2bSwgc3Ry
dWN0IGt2bV92Y3B1Cj4gKnZjcHUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCB3aXRo
X3Jvb3Rfc3B0LCBpbnQgbWluX25yX3NwdHMpCj4gewo+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB0
ZHhfcGFtdF9jYWNoZSAqcGFtdF9jYWNoZTsKPiDCoMKgwqDCoMKgwqDCoCBpbnQgZHBhbXRfcGFp
cnMgPSBtaW5fbnJfc3B0czsKPiAKPiDCoMKgwqDCoMKgwqDCoCBwYW10X2NhY2hlID0gdGR4X2dl
dF9wYW10X2NhY2hlKGt2bSwgdmNwdSk7Cj4gwqDCoMKgwqDCoMKgwqAgaWYgKCFwYW10X2NhY2hl
KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTzsKPiAKPiDCoMKg
wqDCoMKgwqDCoCAvKiBEUEFNVCBwYWdlIHBhaXIgZm9yIHRoZSByb290IFNQVCBoYXMgYWxyZWFk
eSBiZWVuIGluc3RhbGxlZCAqLwo+IMKgwqDCoMKgwqDCoMKgIGlmICh3aXRoX3Jvb3Rfc3B0KQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkcGFtdF9wYWlycyAtPSAxOwo+IAo+IMKg
wqDCoMKgwqDCoMKgIC8qICsxIHBhaXIgZm9yIDRLQiBndWVzdCBwcml2YXRlIHBhZ2UgKi8KPiDC
oMKgwqDCoMKgwqDCoCBkcGFtdF9wYWlycyArPSAxOwo+IAo+IMKgwqDCoMKgwqDCoMKgIHJldHVy
biB0ZHhfdG9wdXBfcGFtdF9jYWNoZShwYW10X2NhY2hlLCBkcGFtdF9wYWlycyk7Cj4gfQoKWWVz
IHRoaXMgbG9va3MgbXVjaCBjbGVhcmVyIHRoYW4gZXZlbiB0aGUgdXBzdHJlYW0gY29kZS4gRG8g
eW91IGhhdmUgYW55IGJldHRlcgppZGVhcyB0aGFuICI0S0IgZ3Vlc3QgcHJpdmF0ZSBwYWdlIiB0
aG91Z2g/IEJlY2F1c2UgaW4gdGhlIHNwbGl0IGNhc2UgaXQgaXMKYWN0dWFsbHkgZm9yIDUxMiBn
dWVzdCBwcml2YXRlIHBhZ2VzLiBXZSBzaG91bGQgcHV0IGFuIGFydGZ1bCBjb21tZW50IHRvIGV4
cGxhaW4KYm90aCBjYXNlcyB3aGlsZSBub3QgbWFraW5nIGl0IGxvb2sgbGlrZSBzb21ldGhpbmcg
dGhhdCBoYXMgYSBiZXR0ZXIgc29sdXRpb24uCkJlY2F1c2UgSSdtIHRoaW5raW5nIHRoZXJlIGlz
bid0IG9uZS4KCj4gCj4gSW4gdGhlIGZhdWx0IHBhdGgsIG1tdV90b3B1cF9tZW1vcnlfY2FjaGVz
KCkgY2FsbHM6Cj4gciA9IGt2bV94ODZfY2FsbCh0b3B1cF9leHRlcm5hbF9jYWNoZSkodmNwdS0+
a3ZtLCB2Y3B1LCB0cnVlLAo+IFBUNjRfUk9PVF9NQVhfTEVWRUwpOwo+IAo+IEluIHRoZSBzcGxp
dCBwYXRoLCB0ZHBfbW11X2FsbG9jX3NwX2Zvcl9zcGxpdCgpIGNhbGxzOgo+IGt2bV94ODZfY2Fs
bCh0b3B1cF9leHRlcm5hbF9jYWNoZSkoa3ZtLCBrdm1fZ2V0X3J1bm5pbmdfdmNwdSgpLCBmYWxz
ZSwgMSk7Cgo=
