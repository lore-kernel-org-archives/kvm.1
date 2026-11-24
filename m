Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795557728;
	b=3O5JCP5sSLC1FbCPSFoIBzMDQGjcaV4782IHlyOfNHYvpTrmNNX5a7UFrzPf+vuMMJFe
	 kNAl+NH/8BXYmwrVcOkMdaQLqVxZauMez5RhyNmsQBM8RXmK636uvwRz/xe+GmGjIyt8Q
	 FV4jS9zG6MJKvlfSqURQnlvQ7CBqIiAJr13HSkumnb7Ybyhzpm26bTZOJ9nviIrISDsNV
	 RwrJDBTrQVuaSEpcvrLZ7xAgenly0JBhyOq+8A6AEteqq3o4cKJ5SAAqlv22MonGzMQkf
	 eOjFAvvEF2FxnEwZh+oVuloYJYdoc+zcYF0ggoWmbyKUOAo1GPD16vFb/dure3Pp3Xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557728;
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
	bh=evF/ptnx2SZFO9JbJ/39PVvGbfjWPA0y2H9QJkOs3yc=;
	b=RgNLhXpMWl7MqE3I1nYf0bR2BQ4X7R9CS4zVw4knRzA8/6oN1C7Rm3mPyo9HMCVvcEL/
	 jubPR4AOV+WHtk+7rJ59ykiRK/nGe9k/RvR555JN3m7LdF/4xif/2BDOdWva8Eyt80IF7
	 Cm6SGZwxjpDayNtDRUysTrJ+TJCP+HYJzD7p/aEllEkdPjgq4qjjGgu5a7IJJfUBDbzlK
	 Fhiyk+ILxAPCOq2UUMNdq/g2NTsKEcvfWsW4BumDmpQF8lODeyvu/ap23yMfJWLF4Sq8z
	 0mNM4fEzsV4g19pSHwAOdQChcvcgYOChVFJHcA0IBieiIB3pS0KsNO6+vZoA2r+D0WQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UWr+puvZ;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=eedWx7VS;
	arc=fail smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C26606A323;
	Tue, 24 Nov 2026 22:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9C26606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UWr+puvZ;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=eedWx7VS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557727; x=1827093727;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=evF/ptnx2SZFO9JbJ/39PVvGbfjWPA0y2H9QJkOs3yc=;
  b=UWr+puvZG6nfG3UfHdWBw0LbR1xI8Ql4ecuaIO0/TIOzTlWNYFUvglom
   cXDy6c+5WO8FtkmgRlabnFfjBgXjObdsRwG+3LCp3v2QIexgfPK37pii7
   fapwolhNLYzqWDb8a6wAkrMSBG1jRMe4zCdKbUvkr7db7FuIcfVlHhgGQ
   jFve/R5QAkXUV712xN1y13SNH1+fciyHKY/tyaiRbnaoCVLkMNjMFxULb
   51IApP3H7rWR6VhkY3jADMwq6N5CHB9XSgvdc31yl4JSFIQ53em63uKB9
   nHEPztFExunvkyJBvL289OZXA4PKLQs7tqHfSf73CD8p2NSRvFkQvg1Xv
   g==;
X-CSE-ConnectionGUID: idTEIjLhRVS2KoUBSgAPyw==
X-CSE-MsgGUID: NojqLnXFTl2JkJaPGI1rhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4422567"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4422567"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 14:02:07 -0800
X-CSE-ConnectionGUID: Q3o1ftuLQ9aaw9mMEiYRJg==
X-CSE-MsgGUID: byttsgoTTw+jPYK8k2b7LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11535865"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 14:02:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 14:02:05 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 14:02:05 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 14:02:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yg2ThfKTLqS22jaM8ve9vKPVVXI6v3u66Cy2yQocev3NXKsT6qJi1SHm2tw/Ph/OqU3z4oWCvX5VZefBIhb5OSJ0nUwRx1gydBouOiTTw7FPsmW0uJHrpiIRPkYTuAdL2ZhzXBMEmTHDuT9vfPZLgHCw5jEo6CUi6XZBnodnN4z06zXtQgachyUhczAoqytNuhydCOTB8n8g+Q8VL42rOezRPOBTE08Bn4mVbz50hfppRXxD5HQH+0zQxJiBlkNYS+yKkJYizwtqj1SgcmRp7+DGBhmNmG2GeMXkTXA0LavhxDnEFWCaGFGfPQO3Fs8pGKI6Kf4jnt3C1SM6+TwvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evF/ptnx2SZFO9JbJ/39PVvGbfjWPA0y2H9QJkOs3yc=;
 b=qGNsNEDbkTpSmf0q0qDkOi70cDE1Sez1LHV80XtWvCQOY6/4KTzrIVSLpa1gnqdAwh+eGLo7MRNIcgse6dS76qI2cLPFeJ+MFtQbQvXV5SHX/OCmiCwJ2Qo7qA/xHE2WpDalS7iMojmDiACHzkik3pxQDG5/5npAlutTUmohtvClUuw4sX5yEMCRoC/I/zU0Xlm/U75bylly0xskumqf6MU/iFyRiXebKn068ek259rjYLjuhHRF2EFbcjdAR6jTs03vxCb33leYgdiBswkYAMzqF4AGOoqd6OUtWmgnEAm/bl5UEoeOJBOI7+MGTJiUnEj8dW8eTeRN4LOpEJA1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evF/ptnx2SZFO9JbJ/39PVvGbfjWPA0y2H9QJkOs3yc=;
 b=eedWx7VSe9GFwkvAl/lNi24m3gTADnZkBXdcZSHX/sH1JytdE2PLgvQVabbeZsD6XbMiN+fud6m+EU4gd146gyvHJo4Z4aKR6Zigsx32fA0ih1iL6G2MlYjhWP/ZsyhcxbxggW68S3pGhwnCHsRuhBjE1ZoDktQV8hMa6hHjnuY=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by DM4PR11MB7184.namprd11.prod.outlook.com
 (2603:10b6:8:110::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 22:02:02 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 22:02:02 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Tian, Kevin"
	<kevin.tian@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 3/7] coco/tdx-host: Exchange SPDM messages through DOE
Thread-Topic: [RFC PATCH 3/7] coco/tdx-host: Exchange SPDM messages through
 DOE
Thread-Index: AQHddbsG4n2S6MqLX0m4Tb4pbEPdr7c8YqCAgADH/ICAAKjLgA==
Date: Tue, 24 Nov 2026 22:02:02 +0000
Message-ID: <00efbba7a1b2c6e61cc36bf709718da978eec85c.camel@intel.com>
References: <20261116111037.3478844-1-chao.gao@intel.com>
	 <20261116111037.3478844-4-chao.gao@intel.com>
	 <4f832b3a73bfd4d9b74e5e68a08f0de5659e1b6a.camel@intel.com>
	 <awV7wYVv4D_Egns8@intel.com>
In-Reply-To: <awV7wYVv4D_Egns8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|DM4PR11MB7184:EE_
x-ms-office365-filtering-correlation-id: bf368f49-7e75-43a8-9598-08df4a7691b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|261022075727099003|38070700021|10067099003|261026121527099003;
x-microsoft-antispam-message-info: qC6tFXaQ27wDvoDID706uJ5pXmu0Y/dmPLsX49xDr1Xm0ss+wSc3EbeomV2NoMPxep/KGECUu3aV/HrGYt/Gh6CrHRDFGGPE2c6Bqi5kPCm04NxYlEMZzF/Qg6cSziv40E+pmm9LSmrzWRAc4qRCUVuE1073E7xdxJbze6ggGfVzd6CAANrmLUCQGD6oOUvdEnrPxT0Hc4RaNN80/i3hsgkdnnlFTvlcNbBXoraFpkNCohJJ+A+9/7LNbnIbqPaLRmin9fBj5I6vnimxIPAoLeWZJL3qk+X5nYul7QG48WmyGXJHxcMYodCvx2OJ+AwV/Xj2rT4WlCpZdbSS642WHrhCcr163bVIZMD/2Ju5DX5jjenqyYa17bWLuIBNMuA3JFjH3GSc2JLG09jYHP0GnRSFm5FDp+l00tP4+HBIRyrf5eSX8Kg5C4q2DDxjaqczgDwKa5VxLlRvZlLGzYgr9j/KsnEMTwCD0BAF8WEuGE3urQscYVwU8U+E1vy/Ejk6MixJaGSgX4M833ePwi2w8Pe67kiM5N5Tiioy/E+YvmFcuNrEm4YV+kT1yKn9jJxy6a2vrIqRMfdGR6CXhqgOsBGY7QF+ND/rRzS8+tsExI9SPPqkcy2Dd8djVU/wCIJF5HWAITVMQ9vLHAJQpaqq64mZgPXFz8A1uTEhSWOO4ShKUkwzDUgQa7+PQBjqOF1OYVdDGY1Eyncz6fAGAW4R0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261022075727099003)(38070700021)(10067099003)(261026121527099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alg0MGpIYTA1TDFpUXYzMm9QUitBdTFlNDhqUWxtR3NFNHorWnJPL1d0WEds?=
 =?utf-8?B?d2FKOXZzQmN6a2FSUzE1dFQ4QnhNbVlldURQb2hybW5HZUpDZFBuUXNFdm9Z?=
 =?utf-8?B?Y011UzJMOTU3Z0RFUXF5NlVFVi9TV005T0FhYWEvWDFvQzdMMyt2VW5NbHZa?=
 =?utf-8?B?eXZXM3kydjlhYkwzb2NJMDNQa2tnQ1VlR3dUVEY1STQydFVVdjI4cmhmc2tI?=
 =?utf-8?B?YVlUUkU4djlhZXczRW9uZG92TTU3b1JqZFBTZmF3b2Fyemd3dVh0Yng2cmEr?=
 =?utf-8?B?aTE0dlRZbi82OHBiNEo0ZUZ3c1h0WGFQVDFUNUZVaXQ3T3dEMk1yWUROMmla?=
 =?utf-8?B?VG9DTGVYMEtXVVhFd1lsYlg0Tm9WWHR1UlV1Nkh0QXlJY1JaVXFnUm5VOHFa?=
 =?utf-8?B?SjI3TGdHZ0lPZWxKZzIweWlWR3JaL0JKNVpJWTI4NEQvbzNIRHFKK2p2SHB3?=
 =?utf-8?B?Z2htNFkwejF6YmhHUEoxMjlYZ09OZFZ2YUc1TGFuMUZveXhXZ3ZGb3hEajc2?=
 =?utf-8?B?WnlBRDlLb3EyMDAxakpQTzE5cUQ1YWpaSW9zOTliYjljZEU5NDNsRWoveUtW?=
 =?utf-8?B?Uk1xMkhZdk5mOVRKbWgwOWhsYWptWjhQcjFKalBBeng1UE9pbnRvS2lVRHhk?=
 =?utf-8?B?bFk5MVB5MGVoQ0VhU1I1R0pIRGluNDVDVDYvM3YwUmZCWm1xSHI0SmphZmlk?=
 =?utf-8?B?a25NZTFrTmxqWElORWtPbmRMckJlTHJhb2lkT3lxQWFlcEcxSm4yZ3plVnVs?=
 =?utf-8?B?VXByM3dxelpYbVhQM3FRMjhlZDVsbmhTSEEreFR5QnBXMlQ1VXhGTjlCeHdo?=
 =?utf-8?B?OGdndGpSRnNEVDRXNnJ0emp3d01rNHNsSWxEVGY4T0FOR0d6M1ExSWVvd2F6?=
 =?utf-8?B?V3Y1QWR0TW8yTmFGSW5aM1dUNXVWUndpU3Jra2IvN3RpZ005di82S1JBREZI?=
 =?utf-8?B?MVpLWnNKRDRsek9iTjdyeVVueXM4V2o0RXBZeVQ0T3VxNlR6ODB4WWw1dFpC?=
 =?utf-8?B?MjhLYVJqNW9uMEJ3R3hEbU1UMTlweWR5bGFwMkwrbmQwaTV2d0R0NWxzT0Uz?=
 =?utf-8?B?RXphVC9tK2szL21NalhUaEZKNGRtbldpeXRBQXpZL1U2WU1UWHVOTHBkWDhU?=
 =?utf-8?B?T1hQY3BEWDVPemNTVUhOUytRYzNmNVcxNGlFVVpOUGd2eW1IZlViUXJmMWFy?=
 =?utf-8?B?eTluTDhmbXE2WFprdXRMVTBObzBxK3cwNGRtMVVDcTNIMldlSGQ0R05QcmhT?=
 =?utf-8?B?M1dKampvVzIrTWkwQXBpcWxHUXNoZXZiVnZLWHoxOVFLYlJVZmM0N0puWnhJ?=
 =?utf-8?B?bXp2ZE9EZHlRN2NyNy9lNHhXUm81UU8wQmR4Y2pZMjdZamwvOXJTOEowaFpB?=
 =?utf-8?B?ajc0TWdjaEhpaHA4M1pTZlNJQk55elFUbWs1MDFoRmJVRzFvVUxNcGwzS09R?=
 =?utf-8?B?eCtoUkV5R0JkblprZjZFdUNtaU12MVFaQnBpZEY4NndvTlA3RFd3akJYV25B?=
 =?utf-8?B?V2lRakJsOU0yUG1pTVpPa2tlSnUycVNHRjB2QzVlSyt0RVBGZTVjT1BwMjdB?=
 =?utf-8?B?RGZHNXk5VU1HREZKcnJVZ1NwS04ycElCM1dJakdiSnVJR0xGTGJsZStIeEFV?=
 =?utf-8?B?MHhFRFQ0RHBNT1c0ZHNOZXZuSE03S0tNSXc2ZWpzUDZ1OFk5YjBRVVdVUlhS?=
 =?utf-8?B?M0VHaWhVSTNjSXFOSTM1Y2Q4SGZTc3YvZk9yWVB2MlA3MnBBSG9sdjJYSnZX?=
 =?utf-8?B?Y3FnTHRHaGIvR0RFS29QQVBhZzdmSGZreWMxVC9jL3JzZWMwSlNDcnpTcURs?=
 =?utf-8?B?TmNoRzZpUHZETGJIUDZhSVJmOHl2cXU2L0pITXRNSGIxZWxnZ21KOWkvbEtW?=
 =?utf-8?B?dUtXcFZLb0VLSzJFVXRaWmtNZC9FNTFoWG5RN3NqWVpVWEE4R3czSzZRWWFC?=
 =?utf-8?B?VnQ1YnRQdkdXSFVoVmxPc3ZNbEpBcklzNDdnTXQ1VFh0ZGU5cTNMcDdzM1p6?=
 =?utf-8?B?TGgwRnQrb3d4QXMxY1hUR2hhRldLZjU5c1psUG9sTEFTcEIrdWhzSVFYbVJZ?=
 =?utf-8?B?dVdHRjJQcCs5ODMyMnB0OXZmV2h2Zyt6UEVJYk9Zc1YxRGVzSlBvMTc4eWFG?=
 =?utf-8?B?dmZjN05EVU4rOE83Wm91VEl4Y0JCam1Kb1hwSlVnc3BWdVZ0bVExZVBFRG5o?=
 =?utf-8?B?K0RPV0p0bXR4SEdIYWUzQlgwbzdVWjg4Umg0bTczY1pYZjcwT0UwRUtnRnAw?=
 =?utf-8?B?cWRwbzRJOVk2MFFaNnpXUEt1d3NVSTcwRWxyakZ4dXlyZmlabGh6bWx4ekZ4?=
 =?utf-8?B?WjY1ZmlQb09mckQvSDlZTXJ1UUtNK3dpWlgzNmhyTVU0bFBjVFQ2Q2dWc0Y2?=
 =?utf-8?Q?bfks1uY8x6iQlpcI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D96CCCCC140ED4192289132F2508221@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: IDvvUBM+P4Gz8VmvccaJpZE7KCIXFj+BWAy6E89Zer5p2TrpCiwVC3xhCbBKOMO+SC73SSXpsAyE+GYGAIwJzjJGbbbQ2P8LZ+Eb3Rz3I/clIqxagNLuR6OPAFMAdxad9Sng5q/lrKE2VGoi5XtrwRFWIiZWzQvt648bZetyGb72vfClT+n1wKqYpZATwWGaS+EpMZmhFn8VrfYLxmpKe1322xOVOzn76Ru4pcGnX9gW/UGpZgxGBZAOoFx64aIO6E+d/ZuwPff4/IpLMC3UTdH3flhfHQr/C/hEbSRCqmP4DlnhDhZ48hTfD2YySRO4fhTv2Rt57XmaDbX8tUrkLQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf368f49-7e75-43a8-9598-08df4a7691b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 22:02:02.1176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fHf1GsldUmNHZwPXGdTJdepAEJrHxf4z2ve4dwZRENWnegU2h8eCTwaqMwXUOp1qNJYO7V9+Iv1Gp88pzq3487KkWgsQovEClKHpYpeMVlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7184
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTExLTI0IGF0IDE5OjU3ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiBZ
b3UgbWVudGlvbmVkIERPRSByZWJ1aWxkcyB0aGUgaGVhZGVyLiBJdCBsb29rcyBsaWtlIGl0IGRv
ZXNuJ3QgaGF2ZSBzdHJ1Y3RzDQo+ID4gbGlrZSB0aGVzZSBiZWNhdXNlIGl0IHVzZXMgRklFTERf
UFJFUCB3aXRoIG1hc2tzLiBTbyB0aGVuIHdlIGp1c3QgaGF2ZQ0KPiA+IGR1cGxpY2F0ZQ0KPiA+
IGRlZmluaXRpb25zIG9mIHRoZSBmb3JtYXQuIFVnaC4NCj4gDQo+IFllcy4gVGhlIGVhcmxpZXIg
dmVyc2lvbiBbMV0gdXNlZCB0aGUgbWFza3MsIGFuZCBJIGZvdW5kIGFsbCB0aGUNCj4gbGUzMl90
b19jcHUoKSBhbmQgRklFTERfUFJFUCgpIGhhcmQgdG8gcmVhZC4gSSB3b3VsZCBwcmVmZXIgdG8g
a2VlcA0KPiB0aGUgc3RydWN0cyBhcyBsb25nIGFzIHRoaXMgY29kZSBzdGF5cyBpbiB0aGUgVERY
LVRTTSBkcml2ZXIuDQo+IA0KPiA+IFllYSwgdGhpcyBpcyBqdXN0IHJlYWxseSB1bmZvcnR1bmF0
ZSBsaWtlIHlvdSBwb2ludGVkIGluIHRoZSBjb3ZlcmxldHRlci4gV2UNCj4gPiB1bndyYXAgdGhl
IGhlYWRlciB1c2luZyBhbGwgb2YgdGhpcyBndW5rIHRvIHBhc3MgaXQgdGhyb3VnaCBhbmQgdGhl
biByZWJ1aWxkDQo+ID4gdGhlDQo+ID4gaGVhZGVyIG9uIHRoZSBvdGhlciBzaWRlLg0KPiANCj4g
SSBhbSBub3cgbGVhbmluZyB0b3dhcmRzIG1vdmluZyB0aGlzIGNvZGUgaW50byBQQ0kvRE9FLCBl
dmVuIHRob3VnaA0KPiBURFggd291bGQgYmUgaXRzIG9ubHkgdXNlci4gU3RyaXBwaW5nIGFuZCBy
ZWJ1aWxkaW5nIHRoZSBoZWFkZXIgaXMgRE9FDQo+IGZvcm1hdCBoYW5kbGluZywgYW5kIHRoZSBQ
Q0kvRE9FIGNvcmUgYWxyZWFkeSBoYXMgdGhlIGRlZmluaXRpb25zIGFuZA0KPiB0aGUgY29kZSBm
b3IgaXQuIEEgVFNNIGRyaXZlciBzaG91bGQgbm90IG5lZWQgYSBzZWNvbmQgY29weSwgbm8gbWF0
dGVyDQo+IGhvdyBtYW55IHVzZXJzIHRoZXJlIGFyZS4gVGhhdCB3b3VsZCBhbHNvIHJlbW92ZSB0
aGUgZHVwbGljYXRlDQo+IGRlZmluaXRpb25zIGFib3ZlLg0KDQpDYW4geW91IGVsYWJvcmF0ZSBv
biB5b3VyIHByb3Bvc2FsPyBXaGF0IGV4YWN0bHkgbW92ZXMgdG8gRE9FIGFuZCBob3cgZG9lcyBp
dA0KaW50ZXJvcCB3aXRoIHRoZSBvdGhlciBET0UgY2FsbGVycz8NCg==
