Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CAA3064AE;
	Fri, 19 Jun 2026 04:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781844688; cv=fail; b=GFqygyNN3rwMCkt120CHRqIOh0zPNXI6Ar2VkhMPeFhGnPPG3GhpF5ImQ8T8nOzCBMqMo2uFdTboXcnaJXI3B7KnU7u5gEUO9710n1vs5hKYmmEdAvxqqDyt5F0GCnKisLY0PoS3r4PAMuzEthId2jyTI2rNzD6+7VIxaF1OY5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781844688; c=relaxed/simple;
	bh=bKgw1v1Kdrdu17o1DMLGImIVTMh1a9YaHSymyzGR9TQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CdlTOWPtmLLyL8b4yJIV47yG9pjN+vgMhDqXFY3cTxoGbFjQUnIHvutpI+sKo2hbysO7bQReKmWL/udKQz87+rODYGgSlGiZUtHtygzEc2GqCoM1Z751psREmHqlIHQ3pc42VhdSZFQpqT9Zx/cGj6HVNz5cHZCuTzbl1X+6WzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kt8NWDoa; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kt8NWDoa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781844687; x=1813380687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bKgw1v1Kdrdu17o1DMLGImIVTMh1a9YaHSymyzGR9TQ=;
  b=Kt8NWDoaSmrxUNDCistc6pV7UTsGH1REng+KiB4e5jDPP5B4/ONacz2Q
   PCSYNXkYpvGzMVPpwsrvQQ7MER6YFf7vUYk7lwKxfQf2s4IntrDa7N9zd
   EYiP8uMHbQXTEs/6XSuHfvYuSrhrOphmpTo+6K2EPx7OGyqFMWnJQN05d
   ER4pGn1+qN/0sA/WPNlldq70zx55vVsgIK2GZBBt3/l5oI1gx41V/NeYw
   iNdtnqg1gXmPtRW9W4DRuv/oWU16LPqls0t1T3ue8utZpOvD3pKBudDtj
   J5W+qo6HAMXwt7zp0u8rGHq8iIYcm+3BWjMl+hnXXMN2wMIkHG8T02sY3
   A==;
X-CSE-ConnectionGUID: BVB7VvfQQrC1B/Kc5o1xUw==
X-CSE-MsgGUID: zXNb43ZjQ4GjAFTdez16rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82802826"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="82802826"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 21:51:26 -0700
X-CSE-ConnectionGUID: eN2KpjMTTAKTDgD+z7EqPQ==
X-CSE-MsgGUID: UUzQHcTeRfyYSuD6D8HdYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="286670206"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 21:51:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 21:51:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 18 Jun 2026 21:51:25 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 21:51:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5TCssSWxued2iHejv8INv9Ekbm/LFAUesFAzz5t+PJHGelGMk1ORSWeNkGka+iPteKqdCfMBAt/5JUYsHf6Y0OG84rG4Uu4eJnhf6QqjdBhr2th3Vltvz9purrswYpLNezlBq38PIgPQFYiaGg9GoosB2xNhcUlcCLgfgPvsB107rmmtNuz91ql/wQ4/Pctq11hj4Dm0Tlw3C4lahrglgBq4TwobyEPsah1QsJZrFU0OMUvp1DwdyUbLwdgSEqY/sRBwP5d8XqNHMQJWqXkYkZe5jKzamg3yVlYHYkP8egKa9QoHzsnZ+7Mk04rmK2ELtN0RJsg+UfJERNLwDsxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKgw1v1Kdrdu17o1DMLGImIVTMh1a9YaHSymyzGR9TQ=;
 b=LmqOIGvsENG1lscxV3YDoAJuF3+IBDCdNzAvfTOGgfInhkR4t1/JsUMZIlEElag2nmRlTPKA1LbB9guts7wQb4TZIkZWFYFtDRHTUFB3Guvr5qF5h3sbOjLC9Ve5nAROVPVnkgMuibjvjiHzejCBCS1xDU8DaAD94c6KoySZ00EnyI6cqXHLY/7WSfzNfYeQuD6hc9DiRzCcDwRqXDcsn91N5JYj2eErTZUMGBCb9QRl+17oZJlEmSDbxBvcdr2jsK9J3KLN7yYGDsw46ogDc+lcZhCfh++JzNjfvb+/leuvhxGHshXetvWNMlsk0XhnY03uMP9B9VYiXu3QLiGC5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DM4PR11MB5311.namprd11.prod.outlook.com (2603:10b6:5:392::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Fri, 19 Jun 2026 04:51:23 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 04:51:23 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: Clamp the EOI vector if its OOB instead of
 bugging the kernel
Thread-Topic: [PATCH] KVM: x86: Clamp the EOI vector if its OOB instead of
 bugging the kernel
Thread-Index: AQHc/1QYLGBBYF7ab0m45gRDa3IBLLZFT+IA
Date: Fri, 19 Jun 2026 04:51:22 +0000
Message-ID: <f8d021453f5bb6565fc9c9c2e23e63d8c620e2f4.camel@intel.com>
References: <20260618185515.2021642-1-seanjc@google.com>
In-Reply-To: <20260618185515.2021642-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DM4PR11MB5311:EE_
x-ms-office365-filtering-correlation-id: 5e239793-43d7-4779-84e4-08decdbe6978
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: IHorp+eb0lK+e3QTI+WXCFgsxNvtGO8fY5lF2jL9n7wPzOBCfSq2uBNp1Q+nnasEswt7QR4/8NV4v9H6nrAs5SePDWyA0AYF8xjeyvXjWcIAkqDL5ioYnM/6lXrrBjJlFQddLhteBEoQtFLwKC0zib3DBnjVKFYq9ad6ExuuhPf/M3DLj5zR+zBbZnrq02gjvEz7PRmhXOLkQo6CJrFckO18v0ZhzDsK8YrPTO+9AKRWXXO4vdsgDUwO2N+zzuEkJlHv+kOWgZ2Zij5uDiJQJzbvHHd25xDt/Ytwz731GKEHtqF6QWy+ZB+Iel+O+az08mWe1PNiCFxc8ZDPkPscC8DeUBHZt5ZbCgclT3NnNv1IqZuz9q4/lpPeQkEemXdrZ5Cdddwy6wdFA8RCmDgWKFfzJwjCyRvbb5+jDLR46r6sfdWXumKgqax8Fg9LBpKk1cWccLOyrzFLJ/ZCfYzkiQojThVTxGtcUF2k7Rf9h1ZGEA9wAEr/aF1sp9NH1dIUqAbLdwQNL6ONlR+YyZ9h8w4qKoNW0mkoZBe4Q1cD8l/bIUsGcgmud6NZU4/DlaStqJTVkvJPUKE8KbR4KDUvnSYsVGKf6v5FB0gWK+i3Zkj83+KdflivmFJoTpUA72FiOmQ6Vf/9+ivaKBWpoYawfww4NXeV0cxOCp5FZghs9Yl7yzWgyH27Xn58feIDWKraNxM6yV5i6laK+oy/wYIcEdnW7AQpAizjRZGYoTwZBYc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXRTcU0vdzh0Y2VZODJCSmtGTmtGQjlrc0VXOEFaTFlmOElueUtiU09UaE50?=
 =?utf-8?B?L1ZZemFsdzRVdnVJTjNsVC84dzBRajduRURQRWpoRnJZWlU5UU5WYjUzcmlt?=
 =?utf-8?B?bDA3NCs4UzdCY0NQRXVDWmtvWlRYRzNrbWJJSDRIUEZBamZuaUV4M0UzV25Q?=
 =?utf-8?B?NU5MRnF5OTdHUmZ3WlZxK1NQYkJjcDVaZ3AzRGZTbzcwR0N3NWJ3VExlYjhs?=
 =?utf-8?B?bzJSNmVudDFGNjhBQUJ3Z0VpZy9rNDVPRk5TZEIybzVKOU9GcWwweDFPbzl4?=
 =?utf-8?B?eWdHam0vaTlPd2xmT2JYOSsyZGZrV3dPTHIvOXlOQmVsaFNmZFhWV25hUHVi?=
 =?utf-8?B?RS9GYzBKeE5WY1NlWEorTkRZN1FPekhmUUFzM1c3Z2ZOTFB1bmVpY3A0WmZw?=
 =?utf-8?B?ekp3UEM2N29NeGJSd2w5TkhpTEVKUTVXa3E1V0kzRVY4TnRUTHgwT3RHeEF2?=
 =?utf-8?B?L1hmaUZ0STlvbk5HaFpIS1ZBTnJUbmxGOE9FdTdwazgzTTQzRnpNSjdHVVpZ?=
 =?utf-8?B?OGRKbHJBSzBCSzZxRHpJVEVSQnp0bUxwZ3dOZlY0YTl4ZXV5KzZMTCtDMGZG?=
 =?utf-8?B?eENscE5oV3IwWlg3OWRPYzFkcGl5TDYvNDNDQ1UwcGczY1BLRWxXdXFnSEE5?=
 =?utf-8?B?ODMyTE5Sd0JwZEMxSmprRTNLbllRREtyT2NXeXQvc1hNdHR4cE1Eak5qbzNR?=
 =?utf-8?B?RlptVUlSckxKMDB2THB2cExQR3pJYityaWdZRzJKd0Qvd1Rma0lHSnpwaGMz?=
 =?utf-8?B?ckt2b2xINHVnc2xZZis5NVhINXp2bmw0d1hRU2dnR1RiKzRLREt6M25IOHl1?=
 =?utf-8?B?M3VEYXFndy9Jd2pEN0FQbHR0RG42ODArOFJ5cEpmaGZQejdTWmZDdGJjMzEw?=
 =?utf-8?B?M2dXaXNmYUlEaTZjekk3aFlBQThIY3RLYXdLL0ZvUytQUFhOUS9PSGZOdEFl?=
 =?utf-8?B?QVBmWDd6a3VIeC85MVFuUG1NbmwxcTIydm14SnJLUDNzcE5zL3NrQVJUZVBs?=
 =?utf-8?B?Zm5sSW1qeUFJOTVGYnBqelo4WTlpVFdNeG04U0dWWlZpaWd1QlBsYUJxQ3lo?=
 =?utf-8?B?WXN4Nk1BQ3hPb3UwQkVTbUVzT1hzSHJKQ3lEOEsvYUVEV0pXRHBDdDd1cTlL?=
 =?utf-8?B?WTBWK0lScUpyZmpacW1seFhZbXJZK2g4bFJtUXJ3cWk3aVNxZVlOK2FRSldJ?=
 =?utf-8?B?dGhZUWNMQ29RMThsMmtxY0R5azZvRG5OUk9XLzdvd3VVbkwvemtvUjNpKzNK?=
 =?utf-8?B?anp2cGJFY3FoK3Z2YjZKcENWMnRSY2dHVFg5VkIzMFJrOUFVcWdndllYeTlT?=
 =?utf-8?B?VXF0ZEx1VnNvdTkrRHJRUWJYQS9mRTNycXFWdmdNOU9qeEMwRnhDZW5xWlVj?=
 =?utf-8?B?T3JjNk5QdzF5aWlzdmx1aDE4cEpLU3E2WEZWOTUzbTliWTdCbm1VQ3BMY04z?=
 =?utf-8?B?bkNQVldzU0NCZFJRYzRUZWovR2lGQ3FnWnpIMXdiVUF4dTRQTERQeXl2OEJq?=
 =?utf-8?B?YVlFZ1g5NDRmOWNZOXNXRjcwSUFXRURRZS83SHQxUk8wWVZJazZNR0JyOEVx?=
 =?utf-8?B?U3VVQnB0eUk3QkZNREpUeFUxL0k2NHFtZXE1czRFWWRjbUk2S2ladUE0T24w?=
 =?utf-8?B?VWRqYnpxYUprR1FPK1A5Nno1S0VOTWJ5WmpRUU1YbVZXcmZXeGlhQzNmV040?=
 =?utf-8?B?R2hyT1AxU3J2QzVTcVNTT1RFZ202ZVJYNHpNNDVmQWhkaVZLZFlNM0xUS3lY?=
 =?utf-8?B?OHFXeEJhUldxM2dvbENqMEZHaWZWanBEMUxMZjE3TkxHaEFaM2d4MlFFVlRY?=
 =?utf-8?B?ZWZ6YXJXZWhBVmt2T3Rwa1YzWXZ4a2tJMHJ4VFljNFpkaHQxdkdjZU9uQzhp?=
 =?utf-8?B?YzRPK1hYcG5wMHVuWUlvSTJwK3c2VXRhaG9LaXFnUkNnbFlucVVITW1USFZM?=
 =?utf-8?B?YWdlOVhLTmY1VWxvYzFOUFJDK1VYKzdTSXNzRksxcGw5dFk2M0VDalptcFli?=
 =?utf-8?B?QUJ1T2wxWnN5U25EMU5FZ3JGckN6ZFFaL2E1OXBKMi9lM0UvZGJRbVNtVm8x?=
 =?utf-8?B?NmZwZ3REYmtnb2J6UTlNUzV2VEZlTi80Qjl4WW9wNjNuczN0VG91UDFkNUdF?=
 =?utf-8?B?bDEydnFWWTViRis2NCtLdmZtR0E1QU0yKysxYTBpZUdQRTVaV3dDVHd2SjJX?=
 =?utf-8?B?aEtVV3pPS1B4MHpzUjFodkc5U3d0QVBsczdQM1NiS1lEZWRhbm9KS1Z3TzBN?=
 =?utf-8?B?L0h6YXBGS3FSMUFLWXZLeUphNElmZVFieERkUWtXclJqMzkwQjZGSkt2ZWkz?=
 =?utf-8?B?NjN0Y1lETTc1WmFUc3U4NXRwYjFObUVzZW5pV2ZjUXQ1Y0Eva044dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21BCCE6BD946A94CBC94EE80B3EED7BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HU7W/Lw3CIumwcBcZBG/bpVi1ZmwOxtMMyeEqzh3aV5UHjLwff7Xlon2nCh5kamJE3Dy2DChrGV/mvZRoX21nfrSPo8pTNhCq0r5uR8N4kVDo98w54/THZGTKm7opy6JWF7ZM8zQcrxCUL7DTZG6hO+IuaUfpafpphXuN4HYSPi8eN4c2VD34PLdMkMJNnJ1LjbOGQ4p4gBKGsyVw5/sAssYcbBX6oyvIA1iwC2rLQnUdXLwtM+uG2CO5X63koygmZFPTb+bfmLB0k7Fpp9sciAWp29vPhNL6YgwtOJfK0PHbe4ezw41AZ0yxgOw72hONr89Fy4CrFE5OQ0TLiAS3Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e239793-43d7-4779-84e4-08decdbe6978
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 04:51:22.9994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hwp3ETfJfa5umNcod8OhcsOonEPDdoGE06yv1WWdRvItaXOBwvd3+tmuxKOIXhsBRQuFnY2fLlYeS+/5T6JbkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5311
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTE4IGF0IDExOjU1IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBJZiBLVk0gaGFuZGxlcyBhbiBJL08gQVBJQyBFT0kgZXhpdCByZXF1ZXN0IHdpdGgg
YSBiYWQgdmVjdG9yLCBjbGFtcCB0aGUNCj4gdmVjdG9yIHRvIDI1NSBhbmQgaG9wZSBmb3IgdGhl
IGJlc3QgaW5zdGVhZCBvZiBidWdnaW5nIHRoZSBob3N0LiAgSW4gYWxsDQo+IGxpa2VsaWhvb2Qs
IGEgbWlzc2VkIEVPSSBpcyBzdXJ2aXZhYmxlIGZvciB0aGUgZ3Vlc3QsIGFuZCBpdCdzIG1vc3QN
Cj4gZGVmaW5pdGVseSBub3QgcmVtb3RlbHkgZmF0YWwgdG8gdGhlIGhvc3QsIGkuZS4gcG90ZW50
aWFsbHkgcGFuaWNraW5nIHRoZQ0KPiBob3N0IGlzIGNvbXBsZXRlbHkgdW5qdXN0aWZpZWQuICBB
cmJpdHJhcmlseSB1c2UgMjU1IGZvciB0aGUgZHVtbXkgdmVjdG9yLA0KPiB0aGUgZ29hbCBpcyBw
dXJlbHkgdG8gZW5zdXJlIHRoZSB2ZWN0b3IgaXMgY292ZXJlZCBieSB0aGUgYml0bWFwLg0KDQoy
NTUgaXMgYSB2YWxpZCB2ZWN0b3IuICBIb3cgYWJvdXQgdXNlIGEgQ1BVIHJlc2VydmVkIG9uZSBp
bnN0ZWFkIChlLmcuLCB2ZWN0b3INCjApIGFuZCBob3BlIGZvciB0aGUgYmVzdD8NCg==
