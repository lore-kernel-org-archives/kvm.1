Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792603195;
	b=aPTZWCx+f7R31DX9aOlVVZ0qatoVg28fraa64q9oVTSEjAhekLaiG+1QiNyJhQO3cxpp
	 HFsTl8k87t0YW13HA+/cOofZENdzqW/MhlQKCUw+qFhqtcp+vqc0d9Qvhsd/UkNMu5xPk
	 PCZ/YSxC1M3ec1I5TWrXlB51tqnsq+iQD/HNnX+f040fGXrHDazvL+WY3o1YsdbKbzEGe
	 B21fLAsagr0scCcu5BlN5r/NMYg53MDz8qE4LyZbf3VyOfqdzwQxDoQokcA3wOw5zf8gQ
	 jsMIMGN5Y+o+rK1j05k8wBstMEVCxKuHO2Q48Wz1KzoaAg5BCGXay42c4Y6pxv2lFgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603195;
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
	bh=NeekdMXjWbgIgUxRHNH3czQv1/Ipbh5wf7bqc2cU7gY=;
	b=w1iXnWMjy4LoLrQuevOgSEN5AL7LgrCJz3VzI8MhkEb7kA3H5tZNxudtW5KiJSJjhRuO
	 tgvcQ8i5mj1gn2yZivFrWquHRcFwqOvjLg2+qapsc6B55dUGZ9Lj5zIWAuNBZ+uZ9B3i+
	 5zhPyha3z58E6Dze3nVy0HIIxRKeQGH/z4ZxjKSWxizqBGCRHhTlFTPGH+u1JAJRKLJo0
	 4dem7fEThwYm+KLHorBUJ9x/RgpfFKjfLKTYCd79Z5wA1OTesuKfzVlOwU4+Ota2tEhH1
	 h+kwigOmEcgptWJbI/EwtioNcsMRm78iBY3fbLJrhy13AI8wwF3stHuvWp3/4N0ceRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="D85G/Qfr";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6980606A319;
	Wed, 21 Oct 2026 17:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6980606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D85G/Qfr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792603194; x=1824139194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NeekdMXjWbgIgUxRHNH3czQv1/Ipbh5wf7bqc2cU7gY=;
  b=D85G/Qfrar/HLjMHgmqbVmbiCYlrMFwFTBX4Md5oNrzEHyIDpPDfjkgf
   8SoCSg9gz3obCekDrQRinJIX4+mkQVFYhxcARj7B/dsSHPJ+U/UAAN46H
   4PoLSO73pl8cbdYSDtgVNKgZg4gYdIqfAfSyI7ndt4Xufm/JluuKl3DMi
   0wLww1t1N5UJ5wcLWYo4SDp7vEVNZVcit0BOsbFqBvK39wJIywY4UEa0P
   FwBj/gylkfkw+ODNbOnnn5brsr7ZFLhbjStEZAHoOKqK1pi3nZSAhUPzl
   fEUde40/0OKgGf2Wd7FtTbZnskiLnycosUUHVc8rsxehmAw5zKWKzYS16
   g==;
X-CSE-ConnectionGUID: 7uUs1D2aSUqZLR1ri9v29g==
X-CSE-MsgGUID: CrJS3B62ScGOLziGcz41sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1432924"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1432924"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:19:53 -0700
X-CSE-ConnectionGUID: +1pzv3EWTpeZTIl//1aRtg==
X-CSE-MsgGUID: kS1/WhYZT660jOwn4QhTaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3086651"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:19:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 10:19:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 10:19:51 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 10:19:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6ZaHCy42dA0AUrm73Y5hj3S+V0quOtX0mHjP3U8ylnhixGOasvm/9VAGv0TY7LHwSPf8nZkQfOh2RUuOzPUlM52FbXa3XN5vbxY8WMJePadKj0KteGC5oUGUNA5U7sW3n4IpeHKY/BTn37YH3wyuFfkUtpSVz7vPRs/mN204J0S0Iga3GzbE1YvmohlBbZGLCGkQenJXSshAcAcPwArbXs1QkusnFrduz0hfaE1ko7CYVS9tynFajL8w8ePjRSTIFaUKH1GqT9BZHNZRILOm8u+wuFnD0L8nm/wWMiZVNsSKVHVyrlLAxofWdfHl81eOVvJP76vqNp7xJD0ZkerBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeekdMXjWbgIgUxRHNH3czQv1/Ipbh5wf7bqc2cU7gY=;
 b=RbWJkhhY5TKn4+VJeMy0Ude6XFseLQRY4SHqZSj0KdoNzK42kLxl4zMWY5Z9axLqZO9DiS1L4n8n8vVyWXTjglhIkKNsDK8lQuZJMyIBX97Z4ynHoHhjf4YR3PtTVNI93jDY2SY0sOBDkZuDPUSHMG/9WAtyNdAb1tMKLGys3r+/gsggYJ9oRBcSLjbjVOhGIGRlHdOx84MJV8hpyEItxJuUsQF/KVQTkTtN+Nz9ZXjVE783tCt+KaEhx0tJuhNtWjwX+bVeYXwrnBRzMgy72ML7Mc52g4UUuivxWTjXUA9R9eIUTzOX6L+6Nt+8enPmOKOdZQRfr55vW3eVFS/Bew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by SA1PR11MB5921.namprd11.prod.outlook.com
 (2603:10b6:806:22a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 17:19:49 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 17:19:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "dedekind1@gmail.com"
	<dedekind1@gmail.com>, "Maloor, Kishen" <kishen.maloor@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>
Subject: Re: [PATCH v5 4/5] KVM: TDX: Report only KVM-allowed CPUIDs in
 KVM_TDX_CAPABILITIES
Thread-Topic: [PATCH v5 4/5] KVM: TDX: Report only KVM-allowed CPUIDs in
 KVM_TDX_CAPABILITIES
Thread-Index: AQHdXU5ES2ZpZQtqB0uCCFQIpVd2H7cHLrEAgAAauACAAPy4gA==
Date: Wed, 21 Oct 2026 17:19:48 +0000
Message-ID: <b196cf9f65fe1e52aba7b867b7c2687c40caa337.camel@intel.com>
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
	 <20261016091422.3182216-5-binbin.wu@linux.intel.com>
	 <b69f075f475bb8c09c74cff621ae23f76da50795.camel@intel.com>
	 <2bc913d2-4286-4484-a872-3266326db0a5@linux.intel.com>
In-Reply-To: <2bc913d2-4286-4484-a872-3266326db0a5@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|SA1PR11MB5921:EE_
x-ms-office365-filtering-correlation-id: 522a3e99-6e7f-4806-02a5-08df2f97824c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|4143699003|38070700021|261021121427099003|56012099006|10067099003|11063799006|18002099003|22082099003|6133799003|261021123027099003;
x-microsoft-antispam-message-info: ++XwbBG+JBTaUAZunJOxcPm2c/u2wn7B/PMTZ0Va4Ji50DCJRA9HtgkbEpYVjcWiKqUT4R4Y+qtn+4ZZJslVqwbXbyrZLG2j3YhTvF1ab7H3T3mPwlD4w+fYrQ4WyTbDtL7gZB1W5peT02uX7Vl+BgOQD9wz2LqPEAzEneP357eTiJlAjB3KLtW7PvmE5ImFy6MsAuquU1VK/kL0WsNmErlhBHSkjVJBJKXQOR16/GWKtnP/+Pk9Po23QahhVPPPz3S+ZCRSw2bjFNliNultJgVdoZoD5WJ87ECTisnCjPWkch/92Rquq3VcTgBRj2gcK/YulHiy1L7LtKuB5O3EYSExi6Z2Y50GcTP/DzlrRFw3LrnpRHYi9gwh8rMR43bKiX4lS+cTcNzF8X63LDKlbe5znCoZWVS8K7y03RdIiLBBrwayGRA65qOKcuIXll6mOIYU47lhPkMtcIdaaIK3g5h2bZkTwsHKe2GJy1InEojysxpOCF4DqUNwfY7htHg/gP76bFQ7dgGsUOnFHn8aTvcNMctwQSaJTuOuIInoQSPMF3FMR3OiAkCDiudpCBi0OXFO25IF8r5x6/jS7mClEstA8T31svnS4q9DcwqEcpHTsXaoHt6OYyORLc5qV9IMNf8sZmqEcvLS6pHIbuoZw5bq0g+aeIbzjDEEehqs1aLFmCtdLKXoP/szcdOayeIzPw29baKCqw6T5ji1fX8+TMVafk5632tGiF9RdJBybJA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(4143699003)(38070700021)(261021121427099003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(6133799003)(261021123027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2U4b1pWN2phbVVBRWZUMnhwZjBtTlVYQmVjMGo2SlYyS2FDMS9uUkVibE83?=
 =?utf-8?B?eDJhajg3L081T3ZKd3ZSaUpQK25NZXZBN3RobTlxR1ZxeE1HTld6MElWVHlC?=
 =?utf-8?B?SjBCTTU0c3hMaWlSWWhPT01ZZDRpWmxBQTJtZTQ1cnZyM0NqOWxNakR5WG5E?=
 =?utf-8?B?RGY2VTdhR1owWnlRM25iQlpqR0k1T2p0M2RmZ0ZFM2NFajdHZjZvRXl1SGsv?=
 =?utf-8?B?WVhpSG9zaEY2RWwzVnJHa1ZBK3NKY2FkYXZ5YXJXLzJDMFdCbWE1V0tlTWxR?=
 =?utf-8?B?WXVCSU00eXVUWFZ4amRHWmUzc1EvMHpjRktaMXhXZVZMSUJMN1FFLzdZSGRl?=
 =?utf-8?B?V1JtSHcwWTQyUWFkU1djU0JDVnp0eUp4RlRMK2FOM0RLekNVL3oraTA2VnZa?=
 =?utf-8?B?K0kvOUNpV3pjelNYT0ZyUG9DSEw2bE9RMHJzb2xod3UyTU5BWmpIZ1M3NkRp?=
 =?utf-8?B?WDR4eTRXc29xdkJzY2JSTXJESVM1Q1NvbmN5N0ZQaWtheExZeW92NGZIY2Mw?=
 =?utf-8?B?ZlpXRlVxUFhvRitsL2xxWVpkMSt0Mm9IOGQwOFVWeGtWUVZGYWJrVWh6SjY2?=
 =?utf-8?B?Y2JTc2wvRkxMTDc0Q3ZITkNHdjhhSC9jaHdDUW9YNFBMT3h1QXBwTkdoOGtH?=
 =?utf-8?B?SEtNRkR4bDVCVU9XNWxnY0dCaVRRSUU0ZnZvL2huekdoTHRiN1AvZFpxNGJY?=
 =?utf-8?B?Vll3ZmtPL1Z1UmdNV0hqcXkzaHdNWWZ1QW8ySjdYRFgrMTVCZjR6Z05kd1pt?=
 =?utf-8?B?cGc3SFVNZ0wzK3ltWXFnOWVmUVQ0dlYrNkRYbkFNTHBVSDZ6Z2FlL3JCOFpn?=
 =?utf-8?B?RE9IMHhJdTNsaGcxV0thVnZpWEMvVnZvZzJsc0xta3Mwcm9mZytxZGJBNkIx?=
 =?utf-8?B?RXVnam9VenRqNldLL1I0VllMdEtPdXdVajJ0NTJOSjJibnZPalc1cVNCaGR6?=
 =?utf-8?B?ay9BcUlhZm1ISjA4a2tXeGUxN3ZFbkhacUJnV3ZJZnBKSlNxZXR2a3BCQjJE?=
 =?utf-8?B?N3pSUGJvTi9PK1J2QTIxak9qbm1jclkrR01Od3RUYTFjZ004MnNGdkxnd2p4?=
 =?utf-8?B?enhwRzhvWlRUbitIcTFEN005bzlPNVY3VjgxY3kwZHMydStPMkVOa09YalIw?=
 =?utf-8?B?NCtadUFGcDRzclpLd1lPZjFXb24vR2NJazZZcGYydFZhd3dpV0lneG5wbWt0?=
 =?utf-8?B?eUR4Q1h0VWF2anZmank3dm9LNVpadVBrVzRBME13eElZSzc3c0tHY2lSSHk2?=
 =?utf-8?B?Qzh0clhtRGUrV2F6Z2IxSG1Xbm81MWZOSGJVVE9lYzAyb2l5Z3Z4NG5ORnRP?=
 =?utf-8?B?eWo1NmN5Z2NVdk9SMUVjcHB5NWc4YmJweEZocUhYWkIyaWp1Vkl2Q05GMkIy?=
 =?utf-8?B?WGQydlZuUk52RXJxRUNCWVVZOThNR0kxNmkrZHZha0VreEdPZkZDTHVYTmJy?=
 =?utf-8?B?MG41VVJBTUJmd3YyeExBbHg2RlRXSHpUSzJBbFJKaFpzUTRGNnhzb1p0K3g2?=
 =?utf-8?B?YXpKSHJjMitVRE1ndXFnNUpzWlFOSVNHdDRtM1h3Tlc4NUdPOTk0dHpObTE2?=
 =?utf-8?B?bEloSGlNNWloZFZ6ZjBnNHVDQzlBamdtMXVFbGxIamsyTFJIZnJnMjlZVWFW?=
 =?utf-8?B?UWRITUZVem8zUjY0OVJwODIrKzg4cUVzcHMyMWR5UmFXbEkySmxHV2NYZVhp?=
 =?utf-8?B?a2pxOEt2VFpnM2pvYk96M05KemRGbW50cGZqMURLbjNxNkJvNEpDbndjQ1lZ?=
 =?utf-8?B?KzVzRmNSaXVNdGExWmZTbVFNOFZTU1NsS2ZicVJaSkpLWnJrNHlkL3p5NHR5?=
 =?utf-8?B?SkZxUlVjdDNGZFR4WVBWMWN1bVdpaFN3YTdRS3FyZzNvcEdWOFY4dC9vYjNZ?=
 =?utf-8?B?Mk8rd1lJKzlYdWJmS0J2TExWSVdyS2VlM0FqcCtJSE54ZUYzZVVoNk54Qlcw?=
 =?utf-8?B?TFpLbWtCbzFRbGMrVEtkcEJvVnBzSWdHVUc1dUZNMmZBcmZMV3lOdHByRlpn?=
 =?utf-8?B?bW1PQjVReHhSNTk2WWc0cHFYRTYwdzZmNEdFWjVMMWZiZ0tJcVQ3V2M2Z1RI?=
 =?utf-8?B?VDFuZ2NWTWUybXJwVHUvN0hRL09xVzRuTnp4cUg5dWVvUFVwc25tL2lRVWlP?=
 =?utf-8?B?c1ZlQ1IxUXptS3RNNFoxV3J1OWZZTHZkaXJPNnc2Y0N5MlVRRnFjNUxDYnBU?=
 =?utf-8?B?MDVoMnFpMjZBVVZRcW04SjBVa040MHlSNlpIWURueHAyZXpiQmw4eVprQVNh?=
 =?utf-8?B?UUZFUGJiQmVRNUkzVjByT1lVY1B2VFNLU0s3SUNyN3JwWWdpRkhRTUgwZnZQ?=
 =?utf-8?B?Z1JzbThEUFlKVmthUnJ5cWZWTTlpUVlwSm92ZWdmb1U4bU9GS2dUWit2QUdY?=
 =?utf-8?Q?+u4O2GAxsnt/nRkE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C031B242B04E6843A0EF7E12091B9D6C@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: svpXPG1BbIvIZZ1DAWehKeBTiGlTsPYFGn9yrLPA3IkgNOSw81shQoBd4dzj0k5pQG22RYlDTU700sVZw9SfYrQR36/xrJRyTmppeIaT/1rmJtWC787icOxWPomQ1himXUcqztgbCAecQyfg8oFQDF2i44UYF4y4io8eBosiyf4RCw7HIZbZVixkPQc3zoXkXA4+o9TI87TfgvFzIIbpLHirxy7t/1WKD+RMcSzuNrhyLuC5DdioLr2/eXnZbSa4p8YCdph9gg/S0lQMNw0eujFaE2dRLlOgDcFh6x3JdIl06+DjOKB9fFiWQpGPVhYhDYTQqA92AuQfhXONEDJeGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522a3e99-6e7f-4806-02a5-08df2f97824c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 17:19:48.2121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: su4QQSD80u8stQ7K1dsyPR7n+fsvgpef9mMAUVV/BNsV9/28g446PntBKtMKh3Mw5EGQ4Q2llSivbq8OHYAbM7CreWzdSEspItAU90Fsxug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5921
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTEwLTIxIGF0IDEwOjE1ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+IE9u
IDEwLzIxLzIwMjYgODozOSBBTSwgRWRnZWNvbWJlLCBSaWNrIFAgd3JvdGU6DQo+ID4gT24gRnJp
LCAyMDI2LTEwLTE2IGF0IDE3OjE0ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+ID4gPiBOb3Rl
LCB0aGUgY2hhbmdlIGlzIHVzZXItdmlzaWJsZSwgYXMgc29tZSBiaXRzIHRoYXQgd2VyZSBwcmV2
aW91c2x5DQo+ID4gPiByZXBvcnRlZCBhcyBjb25maWd1cmFibGUgbm8gbG9uZ2VyIGFyZS7CoCBU
aGUgQUJJIGl0c2VsZiBpcyB1bmNoYW5nZWQ6IEtWTQ0KPiA+ID4gYWxyZWFkeSBmaWx0ZXJlZCB1
bnN1cHBvcnRlZCBDUFVJRCBiaXRzIG91dCBvZiBLVk1fVERYX0NBUEFCSUxJVElFUywgYWxiZWl0
DQo+ID4gPiB2aWEgYSBkZW55bGlzdCwgYW5kIHRoZSBzZXQgb2YgY29uZmlndXJhYmxlIGJpdHMg
YWxyZWFkeSB2YXJpZXMgd2l0aCB0aGUNCj4gPiA+IFREWCBtb2R1bGUgYW5kIEtWTSB2ZXJzaW9u
cy4NCj4gPiANCj4gPiBJJ20gbm90IHN1cmUgd2hhdCB0aGlzIGlzIHNheWluZywgdGhlIGNoYW5n
ZSBpcyB1c2VyIHZpc2libGUgYnV0IHRoZXJlIGlzIG5vIEFCSQ0KPiA+IGNoYW5nZT8gQ2FuJ3Qg
YmUgYm90aC4uLiBzbyBJIHRoaW5rIHRoZXJlIGlzIGFuIEFCSSBjaGFuZ2UuDQo+IA0KPiBNeSB1
bmRlcnN0YW5kaW5nIGlzIEtWTV9URFhfQ0FQQUJJTElUSUVTIHJlcG9ydHMgdGhlIGNhcGFiaWxp
dGllcyBzdXBwb3J0ZWQgYnkNCj4gdGhlIFREWCBtb2R1bGUgKmFuZCogS1ZNLCB0aGlzIGlzIG5v
dCBjaGFuZ2VkIGJlZm9yZSBhbmQgYWZ0ZXIgdGhpcyBwYXRjaCBzZXJpZXMuDQo+IEFCSS13aXNl
LCBJIHRoaW5rIHVzZXJzcGFjZSBkb2Vzbid0IGNhcmUgaG93IEtWTSBkbyB0aGUgZmlsdGVyLCBk
ZW55bGlzdC1iYXNlZCBvcg0KPiBhbGxvd2xpc3QtYmFzZWQuIFRoZSBBQkkgcmVxdWlyZXMgdXNl
cnNwYWNlIHRvIGNvbnN1bHQgS1ZNX1REWF9DQVBBQklMSVRJRVMsIGFuZA0KPiB3aGF0IEtWTV9U
RFhfQ0FQQUJJTElUSUVTIHJlcG9ydCBjYW4gYmUgY2hhbmdlZC4gVGhhdCdzIHdoeSBJIGRlc2Ny
aWJlZCB0aGUgQUJJDQo+IGl0c2VsZiBkaWRuJ3QgY2hhbmdlLg0KDQpNeSBtb2RlbCBpcyB0aGF0
IEFCSSBpcyB0aGUgdXNlciB2aXNpYmxlIGJlaGF2aW9yIG9mIHRoZSBrZXJuZWwuIFNvIGlmIHlv
dSBhcmUNCnJ1bm5pbmcgYSBrZXJuZWwgb24gYSBtYWNoaW5lLCBhbmQgdXBncmFkZSB0aGUga2Vy
bmVsLCB0aGVuIHRoZSBiZWhhdmlvciBjaGFuZ2VzDQpmb3IgeW91ciAocG90ZW50aWFsbHkgbWlz
Z3VpZGVkKSB1c2Vyc3BhY2UuIFRoYXQgaXMgc3RpbGwgYW4gQUJJIGNoYW5nZS4NCg0KSSB0aGlu
ayB5b3UgYXJlIHRoaW5raW5nIGFib3V0IGl0IGxpa2UgYSBzcGVjIC0gdGhhdCBpZiB0aGUgbmV3
IGJlaGF2aW9yDQpjb25mb3JtcyB0byB0aGUgc3BlYywgaXQgaXMgbm90IGFuIEFCSSBjaGFuZ2Uu
IEkgdGhpbmsgaXQncyBub3QgcmlnaHQuDQoNCj4gDQo+IEhvdyBhYm91dCBzaW1wbHkgbm90aW5n
IHRoYXQgdGhpcyBpcyBhIHVzZXItdmlzaWJsZSBjaGFuZ2UgYW5kIGRyb3BwaW5nIHRoZSBBQkkN
Cj4gcGFydCB0byBhdm9pZCBhbnkgYW1iaWd1aXR5IGFib3V0IHRoZSBzY29wZSBvZiB0aGUgQUJJ
Pw0KDQpFaCwgaWYgeW91IHdhbnQuIEknbSBvayBhcyBsb25nIGFzIHdlIGRvbid0IGRlY2xhcmUg
dGhlcmUgaXMgbm8gQUJJIGNoYW5nZS4gQW5kDQp0aGVuIHRoZSBwYXRjaCBlbmRzIHVwIGJyZWFr
aW5nIHVzZXJzcGFjZSB3aXRoIGEgbG9nIHNheWluZyBubyBBQkkgY2hhbmdlDQpiZWNhdXNlIG9m
IHRoZSBkb2NzLiBJdCBjb3VsZCBjb21lIG9mZiB3cm9uZy4NCg0KV2UgYXJlIG1ha2luZyBhIHBv
dGVudGlhbGx5IGJyZWFraW5nIGNoYW5nZSBoZXJlIHRoYXQgd2UgdGhpbmsgd29uJ3QgaW1wYWN0
IGFueQ0KdXNlcnMuIEl0J3MgYSBzZW5zaXRpdmUgdGhpbmcuDQo=
