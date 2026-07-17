Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5EC191F98;
	Fri, 17 Jul 2026 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784323278; cv=fail; b=bBFWf2BAzVeJWDXFA3IACfKmj8rGwbVNVtri0VAOJHHXn91n8g2RAM2QkanjipzeC3hKD3mvEedIHyYE0nkHbDpZJnfDI3AlBiwK6ArxcVZ6Ay/+zXYx1CiZ4CU90asE8B6TJ8/Il+LMhd7ezww1ANVBBskJbsmpJTST0yhu/ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784323278; c=relaxed/simple;
	bh=pZylJTMXgWIanJgr1zZe0zh0AIGleT0ewzGZFA485Kk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HWegxdGYaIFMpRpcXaX2h9KCilBj8+t5ojwsmZVNTkkicHVQSPLbWwBE6cGEzHpt4lwRT0vc0y8VeXi6BG42x9mdKzD6n24iC/3eTac5iucE/o4x4LUirYx3BA4H8jdP/fr4su60A/ylE27SQvMaIZvoXBb8WxYNSjNAPEhIYzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foE3756k; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foE3756k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784323275; x=1815859275;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pZylJTMXgWIanJgr1zZe0zh0AIGleT0ewzGZFA485Kk=;
  b=foE3756kJRToImjYrXRMuAJTiNj0W2aUWVfGJAp+Fww6li88DiTLRHHE
   aHOlI6bv0zAPH7o/ItuLOCo5kXDgc1bB+qtiSvCNtctUH/XW5964+zKa3
   FadTIe9Av8aE6KfKzcDK6Z+fj0L/lL1qJpCOS6EKeZc0/KcxKskQnbjAm
   urdqQIjt0F0PbaIaZjJ6HkML/4N6reQCY9lgnda6mz+qfw9k/WNXSXaNz
   mXhMxSXgwy0GmfVhJy3LoE96lSh9VJUplv9Ew/ixw21A8f5PXZAkvwmnO
   oHb31R0+PEjppAR3gERbyUgWXlQ/cOomlHR2GIL/yRkuarIqAe2fR0axR
   Q==;
X-CSE-ConnectionGUID: auwGBjTDTeqPO4Zq8TPa6Q==
X-CSE-MsgGUID: PH3NvnrKT+aAXRvPGALYJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85024506"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="85024506"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:21:14 -0700
X-CSE-ConnectionGUID: ej2eKRqZSvmtAnVaopOP7w==
X-CSE-MsgGUID: V2HN4mXeTtqT2jdNgQwgZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="295082323"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:21:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 14:21:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 14:21:13 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 14:21:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0jaDljvjoAjEmEvVAF50XLYKMbXrZuLWHKUo5kW8/4xcVVTzEwIRZIDKC3kShSSlCFTZ4Ui0I/uka/VdGONFizeoSgDRNrzRdhZERI5OdYPN7DJzLbFdZcViX/tTajy9WfagLX9iB9MzFebV90qLCzezt6gvBv2s3szlkTgHWT0yPigIbNNcW1ftPpjbnTzyt1Ny+WSxRYNro398UxHougPjNERv71WAtSNAxLlVmAZbfJTvbwlFrpQmeJM63kfDBZjj8/888JCRR4wAW5oAQagHc9MBSd2HHZrujLwBS5o+6XhoJjencQZk9qiSJhjuaRDd4tT1VM4/9FwlVQKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZylJTMXgWIanJgr1zZe0zh0AIGleT0ewzGZFA485Kk=;
 b=V5V/5TuvMqx6JIzKMIsH3v8LUBAQwY+BF+AhpVp1ugaO8cyGJTKAqQHiwnevVN2NVrukicl2dUOtk8PTXFYRcWnE4NcM7683REtpLfI3xOXFglwhw9yPMOuMGoctzUZ0N2J0ZbGRQUIFgP6ZPrLeIDqmAAYeW5GXdxXlFJtSYLstNxG9BJrtci9xMlbUW5v+KCJqUjboCLxzVbKYKpYMhlwIjdv1Pgrw7ThcH0EfV8jh/xOSEmiXDyhW4YJdUAWDnmvtWo28ce3+Eq6IRXxhPuqvfEPluJ7puFDF+bz3SdRB79utePJ/KflNvHFQXXpOItzOu9jTwcRbAFQaYJTaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 21:21:11 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 21:21:11 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "dmaluka@chromium.org" <dmaluka@chromium.org>
CC: "aashish@aashishsharma.net" <aashish@aashishsharma.net>, "Gao, Chao"
	<chao.gao@intel.com>, "guang.zeng@intel.com" <guang.zeng@intel.com>,
	"jaszczyk@chromium.org" <jaszczyk@chromium.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"vineeth@bitbyteword.org" <vineeth@bitbyteword.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Dong,
 Chuanxiao" <chuanxiao.dong@intel.com>
Subject: Re: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU
 creation
Thread-Topic: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU
 creation
Thread-Index: AQHdFT1oryK9eXkZBUyCu3X3875SjrZxrcGAgAA4CYCAAFQYAA==
Date: Fri, 17 Jul 2026 21:21:11 +0000
Message-ID: <af8fc5537970157b693a9bcdf134e14b29b1f1ff.camel@intel.com>
References: <20260716160801.3155582-1-dmaluka@chromium.org>
	 <792366b7d918faca3f40bccab56bab965e7e34f5.camel@intel.com>
	 <alpWONLi8h2T5WhZ@google.com>
In-Reply-To: <alpWONLi8h2T5WhZ@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|SJ2PR11MB8587:EE_
x-ms-office365-filtering-correlation-id: d3ca2170-d002-4366-e434-08dee4495331
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|18002099003|22082099003|4143699003|11063799006|38070700021|10067099003;
x-microsoft-antispam-message-info: 40L0hymub++R4N3IYTkg13HayGPJMim3lXdppSvbjVM5khC3Jo2DEzOayZ5pjHj7GeMcuOzDlBUoTDyAHtiZp+tmE7j+lR1eoQrWcDBpXl+kkZyJCPJPDvr4EAX6i2jcMGviuMLc/IoOVTuvzTErVvJTlVsaZ09NHC2AxxUDUSca/BKUn8/B9ULLMuHEEmkB9fqnlq/CRlzuSLRFlkv5ccciJjbffVNmI+G8tF24rPjW+6m1HNmPTCR1/zQb787lRDG9EoKfhpWTG6hdDmPGGORTuSZaWbd3DMgnB9Oy08EyKjfa5um7vrS8VM5hPi747Qftw/pscL2ewMhimH8xIDJGUMW8Pb7GrLDM8qEEXvmSxCD5vgFz6IwVzsPLswDDkw4NzTG45Jc+JeI9IINGcL8HgV/PpY6UbyD1E45DQuZjkKCz0qPCaHUHbIL67uIjnf/C5v6kAcYM1Rnc7uDMOWps8Rft5WLbNw3j08LeMEKEIz4tC0elcwXzMsnkGISOHUObQhqYa9YxaT9snx0Qz5VDWPq+meYOfdDlXbOTMocK3RWC+Lj/p/ZOh8gn6ZV6gt8a19WwbhZFks3x9e+E5yFLCYY2vP+8YrlQsfg0wD1iHydg8Ifj3xnqvrSLQwvTrMECcU9HWwpSLw2PO8YX+Pn4reTlxa29j0lKZjKnSjMf0Y4302O2RoWWRXLGwl7oP9MZK59PvqIS77g4OJv87ZduEK2wKhefeYdxJA3CMK0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDJ6eUZZdTBibEdRekJqMWNRZE1lTEo4UEwvL3RIOXBDVHB0Mnh0MmRZNjlw?=
 =?utf-8?B?bEZWSStNVVJWVkdHSnE2U0IxSVNoSTZzLzY0SXREQWRKTmRic3E2SUNhbHdL?=
 =?utf-8?B?S2Q3T2FnenVkc1dwSlozRm1EeXFaankrUGdYN1J2T3hiY0IzUnhFc0JmTU9v?=
 =?utf-8?B?UTVkZ2kxQ0JZemdVaER3WVBCL3FqZDJ0N3lQM052eURSTkNoOXdZdVRNbDlC?=
 =?utf-8?B?b0djVkE5WVgrN1BlNk9wa255d0tiYVJFMkxsd3d5UCtBL01OR216MXRaUktE?=
 =?utf-8?B?MEtiL0YrOWRyekl3YldMN3JOWHA0N3Y4TzM5UGlDWFN0ckF4cENhbWR1eEl0?=
 =?utf-8?B?VE0yTE05bjcwMk9MWGNmcmFFTG1kbDhzSDMxei8zQjIzSjdBdE5HWkNHQnRs?=
 =?utf-8?B?dWl5dFpaZm5wV1U4bDB1Yk5nMklEQm91VS8zbUk4QlpJZjVjeG9ZbFFtT3JZ?=
 =?utf-8?B?ZC8yZ1d1Tm5QOE0rcGl1VDZDUFhqWWJkVVZ4U1ZuUE1nYjZNeXltYWxoV0cr?=
 =?utf-8?B?THB3bjV3aG5jaDVLM0VXc1FEMmJZU050VzBwMFVUYXBCMVpDVklxMUhMZnEr?=
 =?utf-8?B?ZHF2MWpJU2pzOEczVmpvZnl6R21adnE5WVk3c2JrWmd5Y09oWlIxK25PUE03?=
 =?utf-8?B?cmxZSUQ3aTlSdHhWbGo2OTlGYTI1aVptbmVpVGJObWMrRWN3VDFMT2lwYnhJ?=
 =?utf-8?B?ODRITXlkSjlkSXpuMlF3eWovREZjRGFuZk1JaWxNTU1kR0c4UFdpb1RUREV5?=
 =?utf-8?B?VzFFaHpMODU1Sm5YeHZGcUhobTlxRmdiS0U5Y1pZb0tDbjJvSWZaV0xKOHpV?=
 =?utf-8?B?Y0ErSTJ2TFdkSEVvWW5qWkxmd2xjOXdlOXJ6L0RUSDd1REZKU1VRVmw0ZlJo?=
 =?utf-8?B?azQzR0VpVERKd1drd1lnbWwxSkpDbEhPeGpwZnJwMFdxaFA3ellpb3FONjdS?=
 =?utf-8?B?UHlrU0x1dXhHb2srVTN6SGVRU3Z4UTh3TllJZFNGaVZqblE0K2lQUFZoOFhp?=
 =?utf-8?B?dVZjcFk2VXhtY2h1eGNaWCtBUEx5WnJ5QUREcXpDWWlCdTJEVkYxS2tRYUZo?=
 =?utf-8?B?VEQzVkZoamVGTjRwWUpHR0Naa3ZyTUtRaVM2YlZQTzRlbkJQQzJiK2ZWWkw5?=
 =?utf-8?B?UEJJREdMRnhSZWVETjhmQzIra3FWejllVFRKRUVCZGJudWVZTGY3K0w5SzhF?=
 =?utf-8?B?aWViNVgzd3BhNWZoeGN4cnRBcEdQN0Myc0NVRmpyYTR5YjFRQWZRemNXczVR?=
 =?utf-8?B?R0tBbTcrd2NNSVBGeUxZdzBPNHE5Z2dTWVBETXZuVzBUL0NHUW04K3NwanlN?=
 =?utf-8?B?T2J3WmNpTnpValFRUVJNVVFxNStUN0xUeTI5ZE9yWDc5MjFIRUd2YkR3RDdI?=
 =?utf-8?B?NE4wTVBIbndjUjdJTjVYWGFkUjREZXR0elBLVjJUbnBaRVFZeVl3dFpMVW1w?=
 =?utf-8?B?bkhNWXozT2thTGV5K0M0dUNQNnBlaDVVVksvUTN2cGh6K1p5VVZ2RzhlYy9j?=
 =?utf-8?B?REc2OTVpMHFheHhlb2RYeTBPdkFhQXhGb0NFMlVzUVJxcEFKdERXdGJnZ3JC?=
 =?utf-8?B?WXlyYlJSb29iQlExTjFFcWNJbnQ2Y1NkVU9BOTMrVmdMOUU5YzVzUFNQYjd4?=
 =?utf-8?B?djlGMkw0YWQ2aVNKMkxRNC83UE5tWkorNGFwU1NoWHdsWTQ5U2VYK3dYUkpI?=
 =?utf-8?B?YU9QaHprMEgvVENicGJ1aUhrZU9Cc1dXMWNTN3BCMUJreUFnb01qaFZYSUpN?=
 =?utf-8?B?SDRVUDdOVlNZYjlaZWk3ODhkcGJsbFk4TjlGT2kwTlFMUzI2OHQ0VXE5OEwv?=
 =?utf-8?B?R0M5MmtTU2U5STVjRjF1UkFnc1dTc29Kc0plZXlhSHlhWDdITEczUTBGK0JC?=
 =?utf-8?B?UkhMRGdTcjZsdlp5QS9YRm5tSkorUFRUS1Y1Y28wREpwMWNlZElXTFRnbWQ2?=
 =?utf-8?B?bk9ITGwwNEpTWUszVmZENm5XVVUva25hK1B4Um1hcGdkNHpoazBVY2FsRXkz?=
 =?utf-8?B?VzB0Um5lbzA5Y01UM0Eya3FhNjkxaVZ0N3J5QkhndmNCTmZsbUtxTXBFUnpJ?=
 =?utf-8?B?dVAyRW9vZ2trVmNPQ25ZVWlLTkJrNjVxQloxQzU5VUVwbjBvU2JaLzY3MUNu?=
 =?utf-8?B?cG5LUUt6ekt1ME5BTXJCckQ3bU5udHVTaUt2cFdDZ3hrNCtwV0Q4czlEbytY?=
 =?utf-8?B?SzlCWmJORlpLcXREZWUwUm9YOXRmcHUrZU5ZMHp3VmFRSjVQNTYzNDNubDZE?=
 =?utf-8?B?djIvTkpKYVJnZkZ4MUo1UmtybzJ2TUhmTk1vRGV2b2tnN0hTVnVXTlkwSkFn?=
 =?utf-8?B?ZEZ4YStBeVhmSmZZb1h5WmxqMGVVb0dyTmx2dTU5OXM1STdwTVN2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEC16293277E6A4D96C98D6690DABB2B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U7XS5Ep1FqWN6EA/SyPXx/8EGiMouwX28EJbgdqzpYrGo7nWKiGVRxZROCoLhx2vqh5IMiy42jDi2O3yJmsdZodizc918/r9Nw5wPSAsDDIs0a+ZUowlyYQOuulS2QS5IGmVj6dezLUXkEPfAN78TfLmPf+6USiJ3D08L18NIpkkzNdvkWjiFMIjxN2DWutLmBZFGwfBV6Q10jrFfJMy5lfkDPoiw2rF2g7SNn7f/Nb/I8VM1yI2A3yYOnp/REZbK7lWF6TCUQJHrsVVv7QGWo0hueDZmrqmduIiNvd5hRhOgwqpikaIhvJ5UIw03Ddjh6LmIMcnLpu/JxKNO4KvDg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ca2170-d002-4366-e434-08dee4495331
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 21:21:11.2453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: REi0tKn33gn8bg6OmldEBWAbmoq9G2Vs089GYqamW+cxZ3oQvip8hXUJJmKvKSvi4gZqoB52F4Cm0PLYAJjy7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8587
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA3LTE3IGF0IDE4OjIwICswMjAwLCBEbXl0cm8gTWFsdWthIHdyb3RlOg0K
PiBPbiBGcmksIEp1bCAxNywgMjAyNiBhdCAxMjo1OTozOFBNICswMDAwLCBIdWFuZywgS2FpIHdy
b3RlOg0KPiA+ID4gDQo+ID4gPiBBbiBlYXN5IGZpeCB3b3VsZCBiZSB0byBjbGVhciB0aGUgcGlk
X3RhYmxlIGVudHJ5IGluIHZteF92Y3B1X2ZyZWUoKS4NCj4gPiA+IEhvd2V2ZXIgdGhhdCB3b3Vs
ZCBiZSBzdGlsbCBwcm9ibGVtYXRpYywgZm9yIHRoZSBmb2xsb3dpbmcgcmVhc29uOg0KPiA+ID4g
dXNlcnNwYWNlIG1heSB0cnkgdG8gY3JlYXRlIGEgdkNQVSB3aXRoIHRoZSBzYW1lIHZjcHVfaWQg
YXMgYW4gZXhpc3RpbmcNCj4gPiA+IG9uZTsgdm14X3ZjcHVfY3JlYXRlKCkgd2lsbCBzdWNjZWVk
LCBhbmQgb25seSBhZnRlciB0aGF0DQo+ID4gPiBrdm1fdm1faW9jdGxfY3JlYXRlX3ZjcHUoKSB3
aWxsIGNoZWNrIGZvciB0aGUgZHVwbGljYXRlIHZjcHVfaWQgYW5kDQo+ID4gPiBmYWlsIHdpdGgg
LUVFWElTVCBhbmQgdGhlbiBmcmVlIHRoZSB2Q1BVIGluIHRoZSBmYWlsdXJlIHBhdGguIFNvIGlu
IHRoaXMNCj4gPiA+IGZhaWx1cmUgcGF0aCwgdm14X3ZjcHVfZnJlZSgpIHdvdWxkIGNsZWFyIHRo
ZSBwaWRfdGFibGUgZW50cnkgZm9yIHRoYXQNCj4gPiA+IGFscmVhZHkgZXhpc3RpbmcgZ29vZCB2
Q1BVLCBpLmUuIGVmZmVjdGl2ZWx5IGRpc2FibGUgSVBJdiBmb3IgdGhhdCB2Q1BVLg0KPiA+IA0K
PiA+IElNSE8gdGhpcyBzZWVtcyBhIGJpdCBmcmFnaWxlPyAgSWYgc29tZXRoaW5nIHNpbWlsYXIg
dG8gcGlkX3RhYmxlIGNvbWluZyB1cCBpbg0KPiA+IHRoZSBmdXR1cmUsIHdlIGNvdWxkIGVuZCB1
cCB3aXRoIGEgc2ltaWxhciBwcm9ibGVtLg0KPiA+IA0KPiA+IFRoZSAiZHVwbGljYXRlZCB2Y3B1
X2lkIGNoZWNrIiBzZWVtcyB0aGUgb25lcyB0aGF0IHNob3VsZCBoYXBwZW4gYXMgZWFybHkgYXMN
Cj4gPiBwb3NzaWJsZS4gIElzIGl0IGJldHRlciB0byBtb3ZlIHRoZSAiZHVwbGljYXRlZCB2Y3B1
X2lkIGNoZWNrIiBlYXJsaWVyIGJlZm9yZQ0KPiA+IHZteF92Y3B1X2NyZWF0ZSgpLCBlLmcuLCBl
dmVuIGJlZm9yZSB0aGUga3ZtX2FyY2hfdmNwdV9wcmVjcmVhdGUoKT8gIEluIHRoaXMNCj4gPiBj
YXNlIHdlIGNhbiBkbyB0aGUgcGlkX3RhYmxlIGNsZWFudXAgaW4gdm14X3ZjcHVfZnJlZSgpIEkg
dGhpbmsuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5IGl0IGlzIG5vdCB0aGF0IHNpbXBsZS4gQXMgSSB1
bmRlcnN0YW5kLCB0aGUgcmVhc29uIHdoeSB0aGUNCj4gImR1cGxpY2F0ZWQgdmNwdV9pZCBjaGVj
ayIgaXMgZG9uZSBsYXRlciBpcyB0aGF0IGl0IG5lZWRzIHRvIGJlIGRvbmUNCj4gYXRvbWljYWxs
eSB0b2dldGhlciB3aXRoIGluc2VydGluZyB0aGUgdkNQVSBpbnRvIGt2bS0+dmNwdV9hcnJheSBh
ZnRlcg0KPiBpdCwgaS5lLiBib3RoIHRoZSBjaGVjayBhbmQgdGhlIGluc2VydGlvbiBuZWVkIHRv
IGJlIGRvbmUgd2l0aCBrdm0tPmxvY2sNCj4gaGVsZCAocmF0aGVyIHRoYW4gcmVsZWFzaW5nIGt2
bS0+bG9jayBhbmQgdGFraW5nIGl0IGFnYWluIGJldHdlZW4gdGhlDQo+IHR3byBvcGVyYXRpb25z
KS4NCj4gDQo+IElPVywgaWYgd2UganVzdCBtb3ZlIHRoZSAiZHVwbGljYXRlZCB2Y3B1X2lkIGNo
ZWNrIiBlYXJsaWVyIChiZWZvcmUgdGhlDQo+IGZpcnN0IHVubG9jayBvZiBrdm0tPmxvY2spLCB3
ZSBoYXZlIGEgcmFjZToNCj4gDQo+IDEuIHZDUFUgQSBpcyBiZWluZyBjcmVhdGVkIGJ1dCBub3Qg
aW5zdGFsbGVkIGluIGt2bS0+dmNwdV9hcnJheSB5ZXQuDQo+IDIuIHZDUFUgQiB3aXRoIHRoZSBz
YW1lIHZjcHVfaWQgaXMgYmVpbmcgY3JlYXRlZC4gSXQgcGFzc2VzIHRoZQ0KPiAgICBkdXBsaWNh
dGVkIHZjcHVfaWQgY2hlY2ssIHNpbmNlIHRoZSBjaGVjayBkb2Vzbid0IGZpbmQgdkNQVSBBIGlu
DQo+ICAgIGt2bS0+dmNwdV9hcnJheS4NCj4gMy4gdkNQVSBBIGlzIGluc3RhbGxlZCBpbiBrdm0t
PnZjcHVfYXJyYXksIHZDUFUgY3JlYXRpb24gc3VjY2VlZHMuDQo+IDQuIHZDUFUgQiB3aXRoIHRo
ZSBzYW1lIHZjcHVfaWQgaXMgaW5zdGFsbGVkIGluIGt2bS0+dmNwdV9hcnJheSwgdkNQVQ0KPiAg
ICBjcmVhdGlvbiBzdWNjZWVkcy4NCj4gDQo+IEFuZCB3ZSBjYW5ub3QganVzdCBtb3ZlIHRoZSBr
dm0tPnZjcHVfYXJyYXkgaW5zZXJ0aW9uIGVhcmxpZXIgKGJlZm9yZQ0KPiB0aGUgZmlyc3QgdW5s
b2NrIG9mIGt2bS0+bG9jayksIGF0IGxlYXN0IGJlY2F1c2UgdGhlIHZDUFUgaXMgbm90IGV2ZW4N
Cj4gYWxsb2NhdGVkIGF0IHRoYXQgcG9pbnQuDQoNCkhtbSByaWdodCwgYW5kIEFGQUNJVCB2Q1BV
IEEgbmVlZHMgdG8gYWN0dWFsbHkgYnVtcCB1cCB0aGUga3ZtLT5vbmxpbmVfdmNwdXMgaW4NCm9y
ZGVyIGZvciB0aGUgdkNQVSBCIHRvIGRldGVjdCB0aGUgdkNQVSBvZiBzYW1lIHZjcHVfaWQgaGFz
IGJlZW4gY3JlYXRlZCBiZWNhdXNlDQprdm1fZ2V0X3ZjcHVfYnlfaWQoKSB3aWxsIG9ubHkgc2Nh
biBvbmxpbmUgdkNQVXMuDQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0IQ0KDQo+IA0KPiBJIGd1
ZXNzIHdlIGNvdWxkIHRyYWNrIHRoZSB1c2VkIHZjcHVfaWRzIHNlcGFyYXRlbHkgaW4gYW5vdGhl
ciB4YXJyYXkNCj4gKG9yIGEgYml0bWFwKSB3aGljaCBjb3VsZCBiZSBjaGVja2VkIGFuZCB1cGRh
dGVkIGJ5IHRoZSBlYXJseQ0KPiAiZHVwbGljYXRlZCB2Y3B1X2lkIGNoZWNrIiBiZWZvcmUgdGhl
IGZpcnN0IHVubG9jayBvZiBrdm0tPmxvY2suIEJ1dCBkbw0KPiB3ZSB3YW50IHRvIHBheSB0aGUg
bWVtb3J5IHByaWNlIGZvciB0aGF0Pw0KDQpJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBkbyB0aGF0
LCBhbmQgeW91ciBhcHByb2FjaCBpcyBtdWNoIHNhZmVyOg0KDQpSZXZpZXdlZC1ieTogS2FpIEh1
YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K
