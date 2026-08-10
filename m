Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1BD17B505
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351489; cv=fail; b=G4XgL6EZmMt2VT6M0azB8kdXhaT+RED78rZ5+tJJ9xo12RmMFDX06yUAv5cJwO/AkrCKcKufXGAXzisk5m5Bg6w9jebY+tCK1cepqZ5HsvncRdAo4H1lSkxk6q+PMEcfgrgNod7dLdzn0TsjEDJg8WuiHqHylXktZMRE2k4yyV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351489; c=relaxed/simple;
	bh=DShhK0hmMcz0sBJGMcLG0vi+z0wXzlh8ppHarW1I+qM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1v0HycR+WQqW0zoNR28Tyi9IEUL/ForMTIfAUNO7zPJCtHEea4Ev8W8SNBPQAge93mosNBf6nqeVf/IGDQmFJbXNUQOuP8PznKAjbv7m3sy+vE8HjUoN+aSQTL6qVxmxM9qT+U+FXJwSvJtWPtupsCbjh2COT0k3Ogv7ADFmyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S79Ve3JK; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S79Ve3JK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786351487; x=1817887487;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DShhK0hmMcz0sBJGMcLG0vi+z0wXzlh8ppHarW1I+qM=;
  b=S79Ve3JKvzEFA1TEwkP1pjVZwunQxoY5UaChJO4M2NbA7nA/cSN4eL6i
   3I98FxB1HokjZUaNU/9oqaS3EzG7q6i1KIF+806UpZ/GAagEH+kywKgMj
   UKVmB2dW3auhfFIQakwYUejWKnT31T6C2A2oYrs9h8dh2LR+DUrdy74va
   LGnQROaWGWHiv67y1jAzVj6z4YM8QUBKDUPy5fexAZdxC9Fod0OXeTQld
   yrov7/8oqe1i0CR/rbbQDlnnN4q/HJaSUcXd4ZtQ4SMBSki25AZB1p5iH
   RZzDb1F+6/GBJFPF9qyzGvdJ3SUwpnRRJHESxChG0kSNkFMsxOIfRd9gC
   w==;
X-CSE-ConnectionGUID: +yIPRoMzRN6aCBHcp6q2KQ==
X-CSE-MsgGUID: 2JRD02T/R/mC1cqoyFJ0NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="90674266"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="90674266"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:44:46 -0700
X-CSE-ConnectionGUID: L3SMupwgSdCnK6GuPe79uw==
X-CSE-MsgGUID: ioQ9h54nTTK1VyY+fgCT/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="262464107"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:44:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 01:44:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 01:44:45 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 01:44:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFhiQLtd5Jre8VIHgk8MJR6wTSkeMurNf2uJmbODNI65mvRZV0OBWWMRnNk3RaYERFGeqBTalqwEuqBE5fH8H88Aiv+iyVI/WDqM4pIFust6imxIjkrpuMeLeMhMOFOfca1foS15RrYx2eQ9jgbKF6vx+OoeQPhy0IoR02VccZc86zyXfwlFrINVMnep5mFwHGrVuSTNAj31QEEkkOoEIZ+JQA1MQbwsoIJLz4EKx6TYgETsSvLdMNLIMLvT/itOh6V5FHO7nyqbujUeE0x9PB0bEijLrLrAxhBGHjYqz/DWH7KLs3UO3XYxK2phA0bor+gU6N9JvbGuFjf+V1p0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DShhK0hmMcz0sBJGMcLG0vi+z0wXzlh8ppHarW1I+qM=;
 b=Rt+nloWxXOOCw6PaSBdgwV721tDZjdzCIXFDjD+yxXM/18zXtE9o3R3LRge/LGWthosDNvI004Ng/H8DHHUthxTRy61vn0W3FtEP3af6X/7aqH/fg46c3NZVeXaFzmil+1gSG7/nMWbsAPx8/L7kzMSnRGnx/DA24IoizkdbgUvZkNbohjIXu28Gbv0tpLlQ6IwvrsytbEZbQyRPXAvcKzS1zVxhPdsxmFeKP9yF9Z3mZSKeaS23KJ5kMyiU8MmSnm3rsPwK4v+c/N4tPB/aJ7e7MoWWu7dwVkobYvRv+L/hS6eG+hLV94dLkwwELYFCW3wZb/6P/4CEYhDi78O8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18)
 by PH8PR11MB9829.namprd11.prod.outlook.com (2603:10b6:510:3c3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:44:38 +0000
Received: from CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c]) by CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:44:37 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "hao_zhang_kdev@163.com" <hao_zhang_kdev@163.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH 1/2] KVM: x86: ioapic: Set remote_irr only after
 successful delivery
Thread-Topic: [PATCH 1/2] KVM: x86: ioapic: Set remote_irr only after
 successful delivery
Thread-Index: AQHdJakSUYrHBSQYpU6sHMxio8YF87aSNOaAgARR64CAAHbMAA==
Date: Mon, 10 Aug 2026 08:44:37 +0000
Message-ID: <3aca41dbbd845d4194c1372a4d6d8cf277100f7d.camel@intel.com>
References: <anSOdijwS6LBbfYJ@192.168.1.215>
	 <51b48f462c1a3005f5f45895af9ea5b9f213b41e.camel@intel.com>
	 <ankry_2y4dqWPTz3@192.168.1.215>
In-Reply-To: <ankry_2y4dqWPTz3@192.168.1.215>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5300:EE_|PH8PR11MB9829:EE_
x-ms-office365-filtering-correlation-id: bcb5abbc-4bc3-4434-8150-08def6bb9c88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|56012099006|11063799006|38070700021|6133799003|10067099003|4143699003;
x-microsoft-antispam-message-info: QKyayL2rkElpUg2k/Nt9CncYTYouLZfPQo9wWOyKgnhiVXCbqVAuPJXQwCIul9+3HZ8Egx6wHTJgKkJo8O6tfQQ+JNA042wEQKXsCzse/swmIL/TD4gpbQHM44JKHfuuhaxOtyTeb7R8Xt+BOWqoR7DaWqNH3W5HFsqMuueDxoLbBd5dKJXYcOEz59hf+q0cRNL3kY/3COW8owvsnjE4pt+7l+YWb3JyHkXMKDxFObREM1t8UZQeUhJ7gTHYQWI82Q528e+ySkadTy+jFtlvK/OWmDU3vWDfEvVWF8PZZb7QE9WBJ5kCxgKJBIvoToknMBKc3cv7Opw2Ej4kDnqaMvxIjauQIOkECnjVmVaQw8jlOhsqKGV7D6g+zVpCsyHb+9NxpntYGsD+K3VckyeYDFLub68Dk1Q2qv/GxA8RjexUHlgi6Y+hMvookOpZAAxl2jEmRdMMqn8oHobGZZuI++cI/hNGnA4w/UuLvcE8kTWGZBoqZBMlRV8zn9a1D2xS5CCo+dmPwX8ZeF9faA7o1B8v0VzRHw5tY0yKf2Qv0W0cHX0aNkTjL8jb2+isB36z9+5o+7s/OJ3s7o9HPNxclZPldHsbEM1Oe7+IMpAJ2oy6UZ3dh9spCPajpHOXFkk9boM/P1xsG7H/HxrPDqhEEKjU7RI6aBv8gLQ5/lyKkRXn8BQSFaW7daAeeb6oZbIihldxxG6wRGa1iiIPWHfPWAXmee5DrMiLzzPCk+61sLQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5300.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(6133799003)(10067099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWNIMnJ3ZDJTeG1aWnd1WGVrREVISXZ5RnJvNHRvdXdJZ00wVTNnODZMLzd6?=
 =?utf-8?B?Z3o5Rk1meTZYek1ES21aOEFzbExmUGZKSlhTdU5vRXJlcW1XUm1JTjRySGJq?=
 =?utf-8?B?VDZuRmlTZUl4NVA5NVAzakpTK2QycjRZTTBpdU9EVWNIRE04ei9QYytINGZP?=
 =?utf-8?B?WG16OTBIb0hDS1hiRXBFKzRlSHFTT1gyVk12UmxLejhPU1JBZlZ3YmZLWGt0?=
 =?utf-8?B?VTVLbjl4bU1LSUlxdy9kNmxrVlhNRVcxSGM0dXRKR29wMTNZemlEcDJnWk9L?=
 =?utf-8?B?U21adzlLMWd4WjZjcEViM3JFT2Flc1BobTBRRHB6VE9RWjdySWlkNDM0eEM0?=
 =?utf-8?B?V2tQZ0lpTnMxRXpLdkpDSXVaYVpleXcyc1NZcmxKOFJMZElKd1puNnpzd1RK?=
 =?utf-8?B?OWlLMGRqbW4wZzZ6TWdSSUNTM0hITitzVlJLQTRDT09QRWRBTTArTmJKVkdO?=
 =?utf-8?B?UkJNWWhNbGxxWFE0dDgwZ1JzZUZHSjVSbHpMYVAwYlp5YVBOakg0MlJhRlVK?=
 =?utf-8?B?UDFwU0xRMUl4Z1QwMGF4L3V2UWV2aGF5cUdYQTV4b2hXNWtDcFV3TlVlTExM?=
 =?utf-8?B?RGpadFpqRkEwRkRIelhMRzMrQmhYVEl2WmUwYVI4NTFHV0hvemE3MGVxRkti?=
 =?utf-8?B?M1ExSWJZRzB6blZ6K2ZXdmcwc25aM0swL2xNNG8zM2p2MXlNVGFrNnhxVmd0?=
 =?utf-8?B?UkF0QkgrOUpuYmZTRTdFTmVNdXhPby80MlgvNzE3dnJNbmZkNklPWkZCOG4x?=
 =?utf-8?B?Y2ZDQlJBSkhHZXptdVpYQVVUdzRkL0ZCbWw2OGVOYittZUJNZDVrUnRYcHpP?=
 =?utf-8?B?ODVjREl3VEIybWhhN2h3R3g4WmwvWCs4R2tJQklZS1ZtOVF2a1F3QmdTWS81?=
 =?utf-8?B?alJIZnJSQXZNaERtR1VMTEFVVVFWL2wvMithTjZ0Ui9nS0ZrdFFJeCtRUThN?=
 =?utf-8?B?TXd5Z2gwdkd3SUxPYS9ZWGk2Vys2VEVIQlVyUitZNk5JT3lsd01SOXQzVDZt?=
 =?utf-8?B?UTN1dmFBblZCbWpQOVRabERkKzVuVVBoWllkeDVGeUk3S0psd1hpYmxxNVYy?=
 =?utf-8?B?NGNQa3BJeUFna3VPMkJSUkV6OGYvSm1pdVp0azF5bnBVZGJVdjY3RUlTR08w?=
 =?utf-8?B?THJiZFgrc01nc25zS1RLWXhSWFZ5Q3kxNStZWmlGVjdDdkFjUmVENXZ4OCtS?=
 =?utf-8?B?ek1mNC8waWtZUlk0NFA2c0ZqckFiYk1mT0Q3eDlMRUpaNWpIb2poV2JLNmxV?=
 =?utf-8?B?cGQxZXRoMjRDOExKTTdnYW9kQllBUFJSblFXKzUvMG1BUjFUaUg2dDlvMEdp?=
 =?utf-8?B?MEFDVWJUOUR3V3FFM3diUXp0bG1IeG5WVmY3ZjlKaGx0Y3h6ZGVIY3RzK2hX?=
 =?utf-8?B?T0ZjZDJSb1dhQ3R0YmU0aWxCbTY3blZKbVl1Y0tjOHN6NWtibVRkVWw1NlY0?=
 =?utf-8?B?N0w4VHo2Mkl6ZmJ6dEk0bDh1Ri8xODN3SWgzQVVDa0xsOG0vd3JDWktRVnpE?=
 =?utf-8?B?QlUxOVBFVUczOXRVUVd0TEhXUkl0M29qT1oyMUppUGV1Wkd4cU1zSi91TWcr?=
 =?utf-8?B?MThHdFBvcm8yT1I2NnFCWWk2YUJvZTdOOW1tcE5MUFJqMGVYVGZQTUs4VXhQ?=
 =?utf-8?B?N2Y5UFV0MkFTeCs5ZHdrdlNCNWtJYUp0S2tMelZYWFgySkpFcGNTRCtjeWhB?=
 =?utf-8?B?RFJvMGUyZ2pHZnoxTkpsZit5SXZ1Szh0Rk5ETW42bUxSaFphMTFaSU5NVWJj?=
 =?utf-8?B?blFrKzJvcUYvU2NsV0tKRVNpMmJsd0VtazdvUVpKbm9JU2lSOCtRUUVjampa?=
 =?utf-8?B?WUlkZjBzbWc1WGRuMGhreklPYTJaMERKTlJQdzF3RW1mNUFXVnhDQit0Ym5o?=
 =?utf-8?B?bW0rZVBBMXVrdngwQk1YWmRCK2UwZEFyWVJEejRhbXhwNjBLazBqVU9Ud0hu?=
 =?utf-8?B?cXY4ckltN2hrSGtZc2JSbFN2VmczTTRtdDdyZWlsVm1PSWJ3R0V3SmtuUmNO?=
 =?utf-8?B?RlFRZEh1SVZUZHpVSm9QRzV6OWJ6WUEwN0ZDYVI3QWZucjdHSjM0MWFDNEZz?=
 =?utf-8?B?UHJGZzVKaHFibDM1Nno0bFdScUNsOGJuRExUOTZWS1A3SEtQcUNuRWNSSnFP?=
 =?utf-8?B?V2lQbDZzSVVnbjMwS2lkZktZbG5WeU80TC9BTVBzbXRsREhhZkhCMVdJS3hQ?=
 =?utf-8?B?T1Jzc0FnSytEVTV2L0FRSHMxWmlXNUpTY05sYmpOMUFBUitoUzY5Y0FPbHkx?=
 =?utf-8?B?TnBjK0N6K3E2aXpRUVlSTTkxN3BDaXp6NmhMaHBveDhkRHhZbnpIcFNmaSt3?=
 =?utf-8?B?NTdnV0hDQThQZVFzcE9vQjIxNm1Xb3lRUWdnSldxY0kyQlpxRmJ0UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C524647E30AA5B478B3D1CFAE6AC537D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PHJdXuwzCpQpEDJmDQ2gcgX+wH2sFNHOQBAUnxF4baw3GgKl+35HmqfCGFkLTVURGy1OJsgaE6JiVBa8ss1u2StTIoEeeTmKs6cJuJNBhoxd8FGPYO2gv2em3/gFdhqTnEbLpo6T1++DFh9p5ULarS6kPZ/XSJdT9gMG5xw6VlFfqHthZC778AJKvpUoU7qdWu7B6gsi7quDu4L9cmLGeOV9VUKH/x0vZU4vLYtLZ70hFD2IVPsbYCXxaWLoIhOjnBWKeWVBY3SUKH+j52ih5ZC4XNcJ7dVnJuw8cddyktqoDmtA0pCdxlRJw8HR5ruegn/kSVEeIXXTTB4J6NUMVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5300.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb5abbc-4bc3-4434-8150-08def6bb9c88
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 08:44:37.8510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSTLgb/mOiJvbqKIvlKGP9GCX5BJ04a5jwSUA9Na8CB0a7IWRYfCLlfkqHLJIcdKM7d5lp6DDmR9qrtkOn4WXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9829
X-OriginatorOrg: intel.com

PiANCj4gPiBCdHcsIGN1cnJlbnRseSB0aGUgSVJRIGlzIHNldCB0byBpcnJfZGVsaXZlcmVkIGZv
ciBsZXZlbC10cmlnZ2VyZWQgSVJRDQo+ID4gcmVnYXJkbGVzcyBvZiB0aGUgcmV0dXJuIHZhbHVl
IG9mIGt2bV9pcnFfZGVsaXZlcnlfdG9fYXBpYygpOg0KPiA+IA0KPiA+ICAgICAgICAgaWYgKGly
cWUudHJpZ19tb2RlID09IElPQVBJQ19FREdFX1RSSUcpICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICANCj4gPiAgICAgICAgICAgICAgICAgaW9hcGljLT5pcnJfZGVsaXZlcmVkIHw9IDEg
PDwgaXJxOyAgICAgICAgICAgDQoNCg0KWy4uLl0NCg0KPiBUaGFua3MsIHllcywgSSB0aGluayB5
b3UncmUgcmlnaHQuIGlycl9kZWxpdmVyZWQgaGFzIHRoZSBzYW1lIHByb2JsZW0gZm9yDQo+IGVk
Z2UtdHJpZ2dlcmVkIGludGVycnVwdHM6IGl0IGlzIHVzZWQgdG8gaGlkZSBkZWxpdmVyZWQgZWRn
ZSBJUlFzIGZyb20NCj4gS1ZNX0dFVF9JUlFDSElQLCBidXQgY3VycmVudGx5IGl0IGlzIHNldCBi
ZWZvcmUga25vd2luZyB3aGV0aGVyIGRlbGl2ZXJ5DQo+IGFjdHVhbGx5IHN1Y2NlZWRlZC4gSWYg
ZGVsaXZlcnkgZmFpbHMsIEtWTV9HRVRfSVJRQ0hJUCBjYW4gaW5jb3JyZWN0bHkNCj4gZHJvcCB0
aGUgcGVuZGluZyBJUlIgYml0Lg0KDQpTb3JyeSBhcyBJIHJlcGxpZWQgaW4gdjIsIEkgbWlzcmVh
ZCB0aGUgY29kZSB0aGF0IEkgdGhvdWdodCBpcnJfZGVsaXZlcmVkIGlzIGZvcg0KbGV2ZWwtdHJp
Z2dlcmVkIElSUSB0b28uICBGb3IgZWRnZSB0cmlnZ2VyZWQgSSB0aGluayB0aGUgaGFyZHdhcmUg
YmVoYXZpb3VyIGlzDQpvbmNlIGl0IGlzIHRyaWdnZXJlZCB0aGUgSVJRIGlzIGNvbnNpZGVyZWQg
ZGVsaXZlcmVkLCBzaW5jZSBpdCdzIGp1c3QgYW4gImVkZ2UiLg0KDQo+IA0KPiBJJ2xsIHNlbmQg
YSB2MiB0aGF0IGdhdGVzIGJvdGggcmVtb3RlX2lyciBhbmQgaXJyX2RlbGl2ZXJlZCBvbiByZXQg
PiAwLCBhbmQNCj4gZXh0ZW5kIHRoZSBzZWxmdGVzdCB0byBjb3ZlciB0aGUgZWRnZS10cmlnZ2Vy
ZWQgaXJyX2RlbGl2ZXJlZCBjYXNlIHRvby4NCg0KSSB3aXNoIEkgc2F3IHRoaXMgcmVwbHkgZWFy
bGllci4gIEFnYWluIHNvcnJ5IGZvciB0aGUgbm9pc2UuDQo=
