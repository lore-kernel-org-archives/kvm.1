Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9103B71CF
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447670; cv=fail; b=mlW3AcDCejEMZ7+/aykUM+lb9TkFCj8a963N136nlX6G1+IouCchH0CvcWa/3LquASPcrhBunqlj1QFUldN9sEW75GMgjC40pfpqnmM8Ke2PkeyoFyvUGTowaklKQePdVJihf5w6MX9JbYjJmEBp4AHN+U44ffVQwBub46lmoZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447670; c=relaxed/simple;
	bh=OQG5+Ztateiz0LW93P0FA4nWNF1ezuys8qOJviySzHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FxspzBU8R+WZ3mjvsXhFYVPRyPMIWdQmNgNmoJMapN50DjK4NUk5dFNcfH19r+cV9Fg9aBc98ZrxyQ7soZTq8U1/qGze1B5In+IzHKp7kvAwJrUvx6KNcbhKa5wpp9IkrgkS49zYHhGMmCrwICROmTeIv90cK0w/o/mbP4M1TwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCzjshVy; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCzjshVy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786447668; x=1817983668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OQG5+Ztateiz0LW93P0FA4nWNF1ezuys8qOJviySzHE=;
  b=oCzjshVyI1KsxT+5XWABgmkOHyw6RmhdzHJU1+iXojNlLAGPLPC1fBPl
   v4hCLxq+ZdJ+oPywF0dnFZS3HJk/stbN/2RfEswJyZ3ECUaaBT3lFU+dY
   7kGiqr6O5JQmLge54fTvpxSibqN1JVbO7a1sla8MChNpUla6VjioUJBJ0
   UQDy8i7YhOjqnROH2SF5ftSCCWHi1F9xY/YkP38zFihJuHf4h7FwQBSuz
   A8CnJWazJ1+s9hXgxDcUyLV8NIIP+KtsSO7wT3huDRRme1AqSXDos5u/j
   qD1MOGiFPT8fT9yUlk1V9bZxvCUwdB58BOgjwZM0dUUjgU3UaX4L0m+uY
   Q==;
X-CSE-ConnectionGUID: j3d7gV5+TUeL4LdD4OBeTA==
X-CSE-MsgGUID: eN0Q2QEjSC27qjH10dm7Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="87046997"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="87046997"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 04:27:47 -0700
X-CSE-ConnectionGUID: sdDqYnDIR7Sp/irFmw5Ajw==
X-CSE-MsgGUID: F8J1rm2lTnO3sRRQWAqD+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="260000187"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 04:27:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 04:27:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 04:27:46 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 04:27:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfKvRJrte4jZV4pwnLZttP78ewJ0PZpya+ubVyxB+fDTRgU5IqVmS/RMW2SEWMAmSpQa1gQvLH86IAMHIWBN9YVwalLcLKtye0F+IaBeHa+QQDbs7zVgNLMdoqsg589cCyRHpyokrTBWlbG0Pipi/J5LFV1J0Go8VwxK/pRDwuIMcRk7Z3+luObum5xv6OeIFgtvcnmYRi0oQqMdrcF5bKdkUm2j/xss0bDNSG/KGgDhsFrJznHf5FqI6mjoriSDP9o6b26b76it6gYs6w7vJJFm17XfU7nKtkwfzoH9uGS+3yRnivclgmJqznVhEB/iaxmVomPELl9AG+jRs+9tOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQG5+Ztateiz0LW93P0FA4nWNF1ezuys8qOJviySzHE=;
 b=bKJ6cut3YhcsKz52oixUTc0Uy93dRPknxJE9XkvtxGexooalh/pDbzroca997tl3pJwzQIinuM33uvlSSczG/1TlJx0KPHUi75mBmFZTx6vf+CSVUY00hsk8TJbGjKnMvWFWdhrhpApLDsEp/MxhWJswjuwiaXommT53+caruP6Yxx3L9jbO3pwZ8VIwgrQasIahLCAykoKll0b5kC2TgIY8A9phw/Ce8UIwf7Q+y7ptwbNFDbaM8Rlfi4OZtacfAWgnYa0yZg/KP8ot8HH1cbmE3PjZAWIHvGyqXnEcgLGVjZOufWuOTck51Iw7DQf079iyFMymZNYBE/2zDkGgSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18)
 by DSVPR11MB9914.namprd11.prod.outlook.com (2603:10b6:8:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 11:27:38 +0000
Received: from CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c]) by CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 11:27:38 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "hao_zhang_kdev@163.com"
	<hao_zhang_kdev@163.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH v4 3/4] KVM: x86: ioapic: Preserve irr_delivered for
 duplicate edge interrupts
Thread-Topic: [PATCH v4 3/4] KVM: x86: ioapic: Preserve irr_delivered for
 duplicate edge interrupts
Thread-Index: AQHdKWWDVHGaU+F7EkKoYyiUl8McvbaYtgWA
Date: Tue, 11 Aug 2026 11:27:38 +0000
Message-ID: <14bd0c1bbc7e133e5e7bc453bed3c0774f39f5a6.camel@intel.com>
References: <anrSJmPCKNe6jaUc@192.168.1.215>
In-Reply-To: <anrSJmPCKNe6jaUc@192.168.1.215>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5300:EE_|DSVPR11MB9914:EE_
x-ms-office365-filtering-correlation-id: 18a9d7e4-ff72-48db-4766-08def79b8ca6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|38070700021|6133799003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: ZL6vxWJhMi1XZSofNj5z+2kOaqgUKspC13C8cLjrCXbbkcz3i9qR0TuwWljsC4sSky2gvBVyEMex2WHULux0sc7K4jlJ0z4EMEoIzS4X1FyLJxbGOtPdYQpwurfJBgCMwV88LnhTcgfKazsG7Umu9IXEsKficgmn6pw4fHuroeuoWkBJNyN1d8/qiwAWtYRj0anLdnJVz2x8Y4TT927MENxgqtn80mlVgO/jxZuQNgYz1XpCXAjiUu+QnF5JaVsswfS2KHEMVjdfCOSufjWS3AJbDB1PyItOPgPK9VX+XJkccDX+RLxjH6nS0IjcGbyIJB37NgUOHh5thmpy6SBplHQCD6J9/YCKyMZnsBA9p0xF6crQz61a1nG17pTRMwBKtkoR6MPRFmW61rozx7NH4ZmxYpeW2vSRn1nzOZIs64UxEzjCeoickKiijZsMtFJU0B/AC2L0DnEUBhwdcZQku1Ujgqq6RTWqWDsBKvDovaSrRTmBaLr9LS5ombsoOzYaVWSHm8XuyQod2bTrf/iaeWlYUQcpUFRPXWaQXFg9rFTXa0WiYrwtraTQ8Q/avdTe+GrXHzWWUbG5SWkqUIw79iYWaBjq9UJ/5G1z11akFZJZ10I+RNZEqjlKVbgJ8Tk6LZKPhtWJrOWnsN8tDVKvyeYz9f2ibkMzhHHNixXATtT+wqQDIJKibSFz1k3i9yhtIuYu6tzDjFX2v9S9s/pqD7DU1nglKY+0wz9ZN9WQOJc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5300.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(38070700021)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzBreFQwRk9HdGVVeVhtM2Vpd0t5M0h4Q2F2RCs2TVJ2T3ZpR2pNang3T2ht?=
 =?utf-8?B?QmpsZFBJWHVUZ3pybHRuZndqby93OFpnTG1hbW5kVGU0dWYrWVdkajRIMzR3?=
 =?utf-8?B?eHROd0p1aVJvUVdodEp1MDNXNWlIL3hqNEpyalVqUXhocU1kVEJTTUxhdTho?=
 =?utf-8?B?YmtJTVZjS3k4eGlHS0ZMT2FEVkhEUnBUblJsaFREMlcyUExtbm01MXE1USs5?=
 =?utf-8?B?ancxdUdFd2xlMG96Y1FFNmhUdmJYeWhHR0psSGprSTBUL3MwbDduZ1NIMFpO?=
 =?utf-8?B?OG5ZaTh2Y2pPY2VyNlpqQzlHQUhKUGlLUkM1bVNQa3RMVHdzMjQxbkV5M3ls?=
 =?utf-8?B?RXhGSW54STZ0eTNiVTZIQXdSTVJPbkNXalJYNDIrUjNLK1VFVkNSMnhPb1lu?=
 =?utf-8?B?MFFhbXNaQThZU0pIZERzUk12WkdwYUd2STZ0aFpNamkrY3BBWTczSlJra1d1?=
 =?utf-8?B?a3VTN040Mkx5MTE3a0VrK3F6UzNDTkxnRmlyRVUwczBHZzRXVElKTGZoYnp5?=
 =?utf-8?B?cEY3WEtGc0ZGN3hLSTJLcU8wSFhyZHI4RkpRdzBBTW4rb1JsWHhWOWZNR0Zw?=
 =?utf-8?B?TnlDVEUrT1EzOE5saFNiNmpOSWhycEhZVVlzeFRoaFcxZ3UrZGx5MjNsbUZ4?=
 =?utf-8?B?UEo5ZWhJcTRmNDNDQ0NUcDhPeS9YS0c0VlJnSllDYm96TFRlbDZROUtNK05J?=
 =?utf-8?B?NWxoZWRzWEZxRXNtdWc5aUhFUmd4NzlFNTB0MmsxdzZzK0Zza2N5TFgzN2ZG?=
 =?utf-8?B?V2xrVWVqSnYxc2lOSFVIWldJbmtmUU9HdFZtQjhBMnZ2eFU5TU1rWm1DNHdK?=
 =?utf-8?B?ZWtORWpRTlU5Y1NITXlTcDRtamZ4OGxONE5kMm5UTUdTTmVvNk1ISVlOVFBV?=
 =?utf-8?B?c2NpNFJabDE0NEVSSmZaWXdRYXRZVUdKTFZkVkpNMkFYcTdOc29yNlNLTHBw?=
 =?utf-8?B?MXBmQkttak1jcHFid3htQmcvL29iL0hvV2F2YVBoaW1CSkVmajl3WjR1R0py?=
 =?utf-8?B?Y3VEbzhTa0pJSnhxS0xVekgwcDI1eTMyblJtYlF0QklZb09iNUdUZWtianp2?=
 =?utf-8?B?Y1o5L3VMT3plaTZJSEF5d3hoNDV3LzdYWWR6RlExNW5ldjNPMVRoeWQ1ODJN?=
 =?utf-8?B?ZzNSWHJ3QWdQN1dFYllvTUdDd1B6RVFFc2hqNmtvMUg5YWxMTTBOZ3pIcTh2?=
 =?utf-8?B?Wm9pd0ZrRExXcytKSU5XZXhrVndWRE5SN0dvYzAyaG9nUW5OZWFOOStrTllP?=
 =?utf-8?B?ck5KdDJFTWw2cTA2c2ZnVHgrMmcyL1dwaEFjc2VpZjJtdFlNSEZibVlHbFQ1?=
 =?utf-8?B?cWVOWThjK1N6V24xclpDVHJpMTA1ZHk5ak9Mc0pFZmZTcmpoWGdidXdXRVBy?=
 =?utf-8?B?MUZZeDF5MTAyRUZNVmtKOVdTbEZVSFJ6SnFzdmQzRmFqU2NjZmQ4WC9nSG9m?=
 =?utf-8?B?dmdPbHV3Y1d5QXNDcUlac1UxckpyV01jV0pNMWNvTmhnNmRoMEhUMVdBZXNI?=
 =?utf-8?B?WWhJeHdpSllxMUlwS3ZEeUptZWQrc0phUHNmWFIvZUpILzFiL2d1OU0xTkht?=
 =?utf-8?B?UVFEdnFoY1B0eGo4M1Fka2tlZHMyVDVJMmRhWnRxbS9COVp2Y2s0Nlg2ZUV1?=
 =?utf-8?B?eDRZOUc4aG0rWTllZjJLSjc0THBqZU9ucTdWWjQyeHhsVWU5b2djRUQ3UWw3?=
 =?utf-8?B?Y1VGSjlOanVncEVOL1JRUkZCa2R3aGZwdWJLVk1BaFh0blB2Q1QrUThydEZr?=
 =?utf-8?B?R2tGQzZmMWFXZ1Mvd2x4RUxnQWpkODQ2Q0dsbXV5WHBLMjhJbzRVVTRVOU5C?=
 =?utf-8?B?WmE2SUNUNmhuVXZKQ1ljOUVMUER0WUZSb1BiTDVId0pxbEhaWkdhWDZnTExE?=
 =?utf-8?B?RThZNXNYQTE1UzFhN3NSU3Ryb2R2LzBLbGt2cEZFS1ZTczlWY2JIdW1wTnpN?=
 =?utf-8?B?L1NsRTNYSTFlcjE1V3dMSmlVUk5oaGVTRmNRam9ESU1GRGhlaVV6MnZQbnFp?=
 =?utf-8?B?dllzdmRIZmU3TDVZWnFvOG1YWEhOT1JCSWUwdzZHZHBWNVFuMUtnS0ZYNWlC?=
 =?utf-8?B?UUViY0loWnl4QjNBSzE0THVETkZqZ0N5dmZ3dHN6akI0NldQZUI3MXZtbzJm?=
 =?utf-8?B?MEk3bzZ5Mmozc3kzelRCZFlQRDlsK1dPM3NRMi8yZWMxL0lJZncwQUlXb0dG?=
 =?utf-8?B?UXJqVEwvS0hvZHZXNHFDNFF3K1pxNmk5cU5uS05qMFpaMGMyQUlUQ3BLTWxz?=
 =?utf-8?B?TFhQRmRyZG9PSFFYQXNqbi9yaG9IWUxzWk9xSm9PYU9sNlRYK1BFaGpDS29u?=
 =?utf-8?B?ZTUrWUVkc2tyWG82YXZTSnBjQjJpckpVYUllR1ErMkZaWVVXbWlaQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B427E4A72BC45F49A8EF704BB0C197BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J6mwe0JKzYRTj7bvZdrCl1UHRtxDrWPGRa3uS/Roe6bRxZotU8rt+uutTEB6yFRMiaRruLkhaFxwxmQ7PI3kI78cUXyGM9GlFNHJ8ingk0Mc4qeAOl22NCarQu1SkkdszEeblYfWKAVNY11odJQsKPdtlgfyNBfotA2ypnn84qJhr2SKl0hRAt27ygChtNHwX9P7UCPVfYFkQ0/f5T6k5f8gHLT6y8921hhpyWpaJ3PMRo5vJO8GSW670QG4+vDJtD5wUwkMOE+JDGbQ/FESJRzn56TZVPWxIU59E0/tNxP5fLvIC6HnTukpfrI4MeeQm7Vm8b14PQoRIKjZVOQmAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5300.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a9d7e4-ff72-48db-4766-08def79b8ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 11:27:38.4384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPgUciNuyAH7Gj3SH6OJUamHocFUxJ0SOWpaPZPFSOoeS2eSYGm+vnHKnQtEvxms1X5/QcAkhsYrFfGeyOkndw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9914
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTExIGF0IDE1OjQxICswODAwLCBIYW8gWmhhbmcgd3JvdGU6DQo+IEZy
b206IEhhbyBaaGFuZyA8emhhbmdoYW8xQGt5bGlub3MuY24+DQo+IA0KPiBGb3IgZWRnZS10cmln
Z2VyZWQgaW50ZXJydXB0cywgaW9hcGljX3NldF9pcnEoKSBjbGVhcnMgaXJyX2RlbGl2ZXJlZA0K
PiBiZWZvcmUgY2hlY2tpbmcgd2hldGhlciB0aGUgbmV3IGVkZ2UgaXMgYSBkdXBsaWNhdGUuICBB
IGR1cGxpY2F0ZSBlZGdlDQo+IGlzIHRoZW4gY29hbGVzY2VkIHdpdGhvdXQgYmVpbmcgc2Vydmlj
ZWQsIGxlYXZpbmcgdGhlIGludGVycnVwdCB2aXNpYmxlDQo+IGluIEtWTV9HRVRfSVJRQ0hJUCBz
dGF0ZSBldmVuIHRob3VnaCB0aGUgb3JpZ2luYWwgaW50ZXJydXB0IHdhcyBhbHJlYWR5DQo+IGRl
bGl2ZXJlZC4NCj4gDQo+IE1vdmUgdGhlIHN0YXRlIHVwZGF0ZSBhZnRlciB0aGUgZHVwbGljYXRl
LWVkZ2UgY2hlY2sgc28gZHVwbGljYXRlIGVkZ2VzDQo+IGRvIG5vdCBtYWtlIGEgZGVsaXZlcmVk
IGludGVycnVwdCBhcHBlYXIgcGVuZGluZyBkdXJpbmcgVk0gbWlncmF0aW9uLg0KDQppb2FwaWNf
c2V0X2lycSgpIHJldHVybnMgMCBmb3IgY29hbGVzY2VkIGVkZ2UgdHJpZ2dlcmVkIElSUSwgbWVh
bmluZyBpdCBpcw0KY29uc2lkZXJlZCBub3QgZGVsaXZlcmVkLiAgSSBkb24ndCBzZWUgYSBwcm9i
bGVtIGlmIGl0IGlzIG1hcmtlZCBhcyBwZW5kaW5nIGluDQppb2FwaWMtPmlyciBkdXJpbmcgS1ZN
X0dFVF9JUlFDSElQIGZvciBtaWdyYXRpb24/ICBJdCBzZWVtcyB0aGUgcmVzdWx0IGlzIHRoZQ0K
Y29hbGVzY2VkIElSUSB3aWxsIGdldCByZS1pbmplY3RlZCwgYnV0IHdoYXQncyB3cm9uZyBvZiB0
aGlzPw0KDQpCdXQgSSBhbSBub3Qgc3VyZSBvbiB0aGlzLCBzbyB3aWxsIGxlYXZlIHRvIG1haW50
YWluZXJzLg0KDQo+IA0KPiBBZGQgYSBzZWxmdGVzdCB0byB2ZXJpZnkgdGhhdCBhIGR1cGxpY2F0
ZSBlZGdlIGludGVycnVwdCBkb2VzIG5vdCBtYWtlDQo+IGFuIGFscmVhZHktZGVsaXZlcmVkIGlu
dGVycnVwdCB2aXNpYmxlIGluIHRoZSBzYXZlZCBJUlIgc3RhdGUuDQoNCklNTyBpdCdzIGJldHRl
ciB0byBzcGxpdCBrc2VsZnRlc3QgY2hhbmdlcyB0byBhIHNlcGFyYXRlIHBhdGNoIG91dCBvZiBL
Vk0NCmNoYW5nZXMuDQoNCj4gDQo+IEZpeGVzOiA1YmRhNmVlZDJlMzYgKCJLVk06IGlvYXBpYzog
UmVjb3JkIGVkZ2UtdHJpZ2dlcmVkIGludGVycnVwdHMgZGVsaXZlcnkgc3RhdHVzIikNCg0KV2hl
biB0aGlzIGNvbW1pdCB3YXMgbWVyZ2VkLCBBRkFJQ1QgdGhlIHRoZW4gaW9hcGljX3NldF9pcnEo
KSBkaWRuJ3Qgc3VwcG9ydA0KY29hbGVzY2VkIGVkZ2UgdHJpZ2dlcmVkIElSUSBhdCBhbGwsIHNv
IHRlY2huaWNhbGx5IHRoaXMgb25lIHNob3VsZG4ndCBiZSB0aGUNCm9uZSB0byBibGFtZS4NCg==
