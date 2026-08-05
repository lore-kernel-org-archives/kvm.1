Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE86F3C3F7C;
	Wed,  5 Aug 2026 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950410; cv=fail; b=EmaTShmfwVO95H1ULqWfOqDfuDfrBg70AGczVlMXw7hnuaHO/hbG777GyAWYRL/36S7Fcsfw+C/jpJU6W6VqZVQAhOSMkC2ep0Fk4kwupqCz0aWP/y1nHAccTFLx5e0atNw6lBmJQWwRRINaAuvXnsQ3OUDEXJIAjcKf/gE5k74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950410; c=relaxed/simple;
	bh=NSWc+fiXhKLs3AnJxjLFeZvGAsPlQIOwaSSi7RVAsu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KuK/rCXlEpuqolM0ipAxYejESODb+5+tKHDXL3V9TqskQ9wkAe61gMs0VFs8auqo9aYkUhbo2frBDqOH/9uvPZOl13YnGtKNk9RSQtC091Y8FYdBcKGtEcD4/ZxrGNmTmcnjzou8fsb2cl9KaBo2VLk7ybk6GtkcFOumJlrF/h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAG54qp7; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAG54qp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785950409; x=1817486409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NSWc+fiXhKLs3AnJxjLFeZvGAsPlQIOwaSSi7RVAsu4=;
  b=OAG54qp7F7dO/ttvUbr7/h9EOSGwXKU3RHqEZTL1jDwEmpId5rtPPFOf
   exeDd3RfwnMk/8YnuVnrveBAKvKrY752nuS0UfPZmFoShwnwKSzkF6Klt
   UHOH/CgVViL7M8hBedz2llsVb+h+C7D4C6CIqsGnvlbKoTh1vx6JZ/nFQ
   F2RhvsMfGO1KdxPj0UJLEVWpvYssjpqGSLei8dATnsc3vEL0hjDa3aA3Q
   2AI9n51k6Sgfl/B4s0nPfRCmwMrFNcOXtS0HMwUp4JD+hckojSIVJJgVd
   FQfDC+gj54SNoc/dqCHnLlrKVkEHJER1m0rVIXVlNDzlDKpuyJwHKnJiS
   A==;
X-CSE-ConnectionGUID: nPAD7PgQS1SQlsNoucNcFg==
X-CSE-MsgGUID: /lYk4hCnSe2lE4zTRIocNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86410648"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86410648"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 10:20:06 -0700
X-CSE-ConnectionGUID: Bgg7KU7TQLCOawSIO3B4lA==
X-CSE-MsgGUID: wsG6Sks4Te6eqv1PLJgi0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261932126"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 10:20:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 10:20:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 10:20:04 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.25)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 10:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvnJge+s66FDQ+z/zFtWd+hD/ygpsmdvqJG1jRHfRXHVq4gIzJE4eZutirwr9sWh9kG324EzLWWwm+4wKmp9D5H+/gxOWCVWtzOvW+LEJGD2E5n+SlHA2lQBDGWvVixFB+Hz6xbJbEgzcpsvp+o0nXfAQbQ0KXXt938Ovyhtn5koZOnzun95X2tI4g9dHN1EO1r4QssPTvgmoOOdJmIxF0npeC090cykJx8szxvw3hpAXKtpAZpjkdIKl5sWmbEp/B19LuSH5nJ8KykO7LsI6IAA49YrkwM1RdJkVbXV0TERJ43ONAF1oKZz/IC+dhEh75MZ3ohecyx7RonfbbI1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSWc+fiXhKLs3AnJxjLFeZvGAsPlQIOwaSSi7RVAsu4=;
 b=wBYCvCQSlY6ZuWU1mT9ljYm1sOcqJ0ZlLTM8FpqOrndcTtKhiLOpeJ8q+D1kkIKy0MGYnyiizR7zL2ZtvlUpErbBevvEeIE9A8/kwm6d/1YeK17jxZUlxJfuWV9y+A9Bh5J2MxqDtQYZtP0Ep6IQl+6seJzY1ri6Ok9yOp/Ggx7RSzbMFsPZUsLu1LOdi0WB3J24shAetintjlAnPxHI9c6HACfRBMaHPPkgM8Vae96HEzlKeRoPnwN55evDlhnmPZ6laGC6rfrCbZA6bi/9Gm9EhbbIQPTGLl0TcszV2ZZo+61EBliGFlfpN42c5TL3tfolPrtB0KabA6ZgkDhh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH8PR11MB6754.namprd11.prod.outlook.com (2603:10b6:510:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 17:19:59 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 17:19:59 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "kas@kernel.org" <kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
Subject: Re: [PATCH v1 0/8] TDX: Stop auto-generating the global metadata code
Thread-Topic: [PATCH v1 0/8] TDX: Stop auto-generating the global metadata
 code
Thread-Index: AQHdJATDkUGCCWJG50uNTYhs90fJRLaPti4A
Date: Wed, 5 Aug 2026 17:19:59 +0000
Message-ID: <bcbfffccd8f68c638511fcd12211a3501d744585.camel@intel.com>
References: <20260804112941.19894-1-chao.gao@intel.com>
In-Reply-To: <20260804112941.19894-1-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH8PR11MB6754:EE_
x-ms-office365-filtering-correlation-id: c4a27b22-9e75-49ec-da4d-08def315c73f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|56012099006|11063799006|22082099003|18002099003|10067099003|38070700021;
x-microsoft-antispam-message-info: mQIcqKz8VPo/qt1YP5PkbFvbxZ6aZx2c8EUU73nT14mjb1AVfaN+kP/H9eOp9qHsMFCmImC9ztAXitUj7dcOF0kwa+TkvYxVAoUZ8VrOp6hYaefOjb+3LLofcbZVI8rBdhxDR4wgGTfYjQr+VmpSDW2eIqab0fkQ5hkFAY0N8PsjvPx7NATAnRjTvCqA1NcYFDhteRWr/I+NY3pEIizSB5RA2tid0zDRtOhU0UJNZe273PcIgKz7mM8snYul1oYeVERXj6QbdprAOzjntCjGPofZ2pMwS2oyUZWxBg+BtZvhQhlXrV482eZV0pn1DSyTX0ZimFWVcCYV7RqwIjprIFkq65mk6ux45g/oWDZBS7tB9KxhTg9mjhBuTgs3VQA5hWiuASdz+81TEhV1H6bZVlGP2a9u5ClFzWluWn9nTYEjZESoHUtnqY3SyM0gezYXjmIh1pEPLzXuN/7nWk/iYEOjWXPDs0EdPCIsbJwqcq/k4yAphdtzR8lksdHUMC5cpGNihrqT7pfmMHaR0WviS/iiXnPRyyVdN4Sj9yCiByVtH4NZhoE2RnEnHhy92CxKjmPnk0pF+SXP4QS49InS1J/M5jV8JFYtAgw7U0HW64vZ5WCkK253f1bOKE1y6VQXByXv4gPj/FXaNq/QACdzYk2UXOjuV+7cWPil9BNnNGfm9trWPTeFdF6lURpMsTYR0zz7yk193nvT4VJPAW2wrvjMghaibHF7hLf/pYoQ2rs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGZqK1RnNmhuWldaTHdHNVpQcWQyWllMakJyekczaVJuQ3JkZlBqM0NZYkJq?=
 =?utf-8?B?K3pxbGZTRWVtODBVazRyOGxOYWtLT0hqYW9yWFE1Um9sbDE2K3pHd0NqUW9X?=
 =?utf-8?B?SGdGa0txZ2lCcmlpcmM4Tm56WTFGb2pTSHQrY1VaUURycC81d3I2c3g1TnVU?=
 =?utf-8?B?bUlRV1FWZGtuNWtldlhMVk1rTVQxMkUzQW9ub0NkSHFmK2lyQTd1UEc2VzEz?=
 =?utf-8?B?eUdVd2NqMW1aL2x4NXJzK3NvaU9zVVhOK1VZT3I1NWhSbU5tOHdmVU9tSWRy?=
 =?utf-8?B?blVKclY5TE4vQTY0eTQxazZld3Zub1o0SnJsU1h0NlI3RTdSWkhielJ0Y1ZR?=
 =?utf-8?B?bUpNN21pMW5ERmMxMVpQSzlmWG53YW9aNjBRQ2FrT01hU1cwQk9HQTlPUWZC?=
 =?utf-8?B?K1FYdWpCK1lETXNxZ2pJTGhoYzl5SDZ2Y3p4dVVhdWRveVQ2emNFaEE2VnpO?=
 =?utf-8?B?ZE5FMVhTbGc5c3NXZlg4UnNJR1dhdGIyN3hwOWJTMlc3Vm9SNjVkTlpxaFk1?=
 =?utf-8?B?QjluVDV6ZnQxSk91dDRXRTRKQUNJUFRJdzVNaFRwK2dTSEFRYVd3RHlHSzFm?=
 =?utf-8?B?UTVUS1BUYUlyQlU3b0Y0MXRtNi9UMWEzZkZPYWZzK1JiUCtkSW5ab3RuVVk1?=
 =?utf-8?B?K2JvelpNdDJWYjBIa2cyVnVwOWpSQ2dGbm9XcDI0eTlmT3VHUTJIYWFiSGJX?=
 =?utf-8?B?d0QrRWlIb0VqUXFSSkhNaVJGcFI3aFEzNjdrR28rQVVjQ3MzWnlVc1I2TUF1?=
 =?utf-8?B?MmhOVTR5NG9icUlhVGVaYmxDdXgrdXNQSVRUdk5zZUNjN2NSbTlDTWNVczJl?=
 =?utf-8?B?RE1kMFRKVnZBRHdkTENnY1FTOEtaZE85M3RDVEpwdDB0T0IzcUFjUDNxUVZT?=
 =?utf-8?B?RU9PbVlrUDUzM2pMd2h0TU1adUJiMjNlNEtsR0wzYlBuQkRSU0N1SndvR2dt?=
 =?utf-8?B?RlVoRnVtdWZNMGF6eVhOK1AwL3g4M1ZRN0JVSUR0dFNyZkJxQXZlSzBzeU9a?=
 =?utf-8?B?MlE1anZQWmNIK1ZGRW02WWF3blo3by8zc1JhbU1uWlJscEZzWTZTUlVFUUpX?=
 =?utf-8?B?YmwwWU5IQnMyRDE3SElnR1RDblExU2l0eWZGS1VuSTdVU1AxVWU0LzJ5cWhO?=
 =?utf-8?B?REh4TVZMQ0ZBaVBBN1l6Y21rOC9nWGZVL1FkR29KZEk5NFp5VDJQcTNwVlpI?=
 =?utf-8?B?cXpmNVBkdTg3RTN4cVBmY0hyNmhkZStYQWtRSnFpNFRzdjQ4RWlsOUlhK2Nu?=
 =?utf-8?B?R1g4eHFUdEVsU0hVeHNweWxGMjcwOWw3eUkyMklmMUhpZXZwbnEraXpkSTBq?=
 =?utf-8?B?WEJhb1VON3YyRWlOeTluZDdsSEsvQ25NUXErWEVHeHlMTlJBNTdRbnpHY0k1?=
 =?utf-8?B?UW54czJPUHJCN3FoMWZrVHNocSt1MEhnZGx2SEUzMEV2MlZyaUE4QkR5WnpG?=
 =?utf-8?B?RkZBMkQ5dGdUYUFXNkFBaU5NZG9YRGNPY05IZnh3RWRScThWSEhNZXJEY29u?=
 =?utf-8?B?Yi90cE1GYkk0OHozZlQrUGYyMDF4YklHMjVadzJNVDR0TlYzL3pSZnFzeE9l?=
 =?utf-8?B?aUoxY00wbWZ3R3plOGJJcFZzS1dyWmdsVVB1bGU2K2RXM040eWMyS0FKU1NY?=
 =?utf-8?B?azVNM05DZG1UMEhDNFpwT1ZUT05kSE9FVnl4WUVrMWkzTUlTc0h0TThzTXRS?=
 =?utf-8?B?UVJMNDNCVDVDMHN6NmEzSWxCdENMZ2t6RXZVa05naThESzhTVkQ5d2tiRThj?=
 =?utf-8?B?cldDeitNMXVuWmRoVExLYk1YdTFKLzBibE1qSHlSVUNGWjZYSlZJYjRwbWJt?=
 =?utf-8?B?eHhneVAvbHN6UWJ1dGRCZXk5eklOWmM4T2wzbUtBcWhDV3JzV0tEbHVTYXNG?=
 =?utf-8?B?eThVWHRpVnpvVDZOQk1oRGtFQXlZeUVJc0F6UE1RRkFQVDJ4UEJ3SHB5cE9V?=
 =?utf-8?B?UGNaMDlyZDR6TndEdHZJTzJTbVA4RUVkRCthcEpJdnZRSUFXdEpuM3BkNHlz?=
 =?utf-8?B?Z0NWWmI2MFhBVEUyb3NJVnhkME1lWndWajU0WnFLZ0ZSbkVpL2J0amJ6QTR2?=
 =?utf-8?B?ck5xdjZTRjlYTmRqcWFsR0d5T1pzMXdNVk9Zcjlsb0pmb1NpVHlqYit6eXl0?=
 =?utf-8?B?SE1UaEN2ZnRJSGQ1Mm96ajl6M2xucnpKM0dOaVlhYVdONEYzdUF1cHJIYVlC?=
 =?utf-8?B?ZEtBSFRWYmMwV0V3NmVtdmZxanpSSUM0VDUzTm04YVlyaTFDajByZEZmcjE5?=
 =?utf-8?B?NVlSeGxuVHVrNE9HSHQ5OFRYMjJsODEyMjNvK1NiVEt4NTJwUVFzTW95WjM1?=
 =?utf-8?B?aXNTOVN6L2s4eExoc0tLT1ZkNkVSN0dlUEJwYmg2Q2svL3FNc0RmZ3pNbCtv?=
 =?utf-8?Q?O/4qDTML9FnfzBBg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E222E4B9B55A54BAB42B8B3780D736E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MUp/zemwzxF3E2jew5g+00UnzNi1tzwwwR8MzdkGaFaT44MYBJ3ZDF/kFx0rXacRK07etBlfmI8rJpEmteqZ8dgaTZFRJKrLKyhNI68MmQ/o4Zfs6Qx44vAdmc7FWNS/i7q4u6Qiq4pkd2Ngz5R8ZHtAQLbAINcCYK/z/Uarmyy7+LrPcNQTqwpJzjb7XUwak5JBLBlSD8I8dlNW9FqLg6+NWmh6D/iklX9Ue9Qsv7wRs/ZBWXM1lq1dzc6LUc0ER13BANBcTnguH8hOM8sytgVYdX8m8PTutrNuTdWPrIKVKDKzAnt82eMFPqPbFPYHFJEuWHS3p+5B1/ZNsa90yQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a27b22-9e75-49ec-da4d-08def315c73f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 17:19:59.5863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfAa4+NCtIK8LZKpNNiEPDW/Mry5j1P8HPdl6PHmyn2nYxeaNmzrkq/B0xkGor7C+kDP7pEaj7hBypc2fiOYTe+1vT/f/0x4czfHQGsLlRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6754
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTA0IGF0IDA0OjI5IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVGhl
IFREWCBtb2R1bGUgZXhwb3NlcyBpdHMgY2FwYWJpbGl0aWVzIGFuZCBsaW1pdHMgdGhyb3VnaCAi
R2xvYmFsIFNjb3BlDQo+IE1ldGFkYXRhIiBmaWVsZHMsIGRlZmluZWQgaW4gdGhlIEludGVsIFRE
WCBNb2R1bGUgQUJJIHNwZWMuwqAgVGhlIGtlcm5lbA0KPiBtaXJyb3JzIGEgc21hbGwgc3Vic2V0
IG9mIHRob3NlIGZpZWxkcyBpbiBDIHN0cnVjdHVyZXMgdW5kZXIgc3RydWN0DQo+IHRkeF9zeXNf
aW5mbywgcG9wdWxhdGVkIGJ5IHJlYWRpbmcgZWFjaCBmaWVsZCB2aWEgVERILlNZUy5SRC4NCj4g
DQo+IEJvdGggdGhlIHN0cnVjdHVyZXMgYW5kIHRoZSBjb2RlIHRoYXQgZmlsbHMgdGhlbSBhcmUg
bm9taW5hbGx5IGdlbmVyYXRlZA0KPiBieSBhbiBvdXQtb2YtdHJlZSBzY3JpcHQgZnJvbSBhIEpT
T04gZmlsZSBkZXNjcmliaW5nIHRoZSBtb2R1bGUncw0KPiBtZXRhZGF0YS7CoCBUaGF0IG1hZGUg
aXQgdHJpdmlhbCB0byBhZGQgYSBuZXcgZmllbGQsIGJ1dCBldmVyeXRoaW5nIGVsc2UNCj4gc3Vm
ZmVyZWQgZm9yIGl0Og0KPiANCj4gwqAgLSBUaGUgZ2VuZXJhdGVkIGZpbGVzIGFyZSBlZGl0ZWQg
YnkgaGFuZCBpbiBwcmFjdGljZSwgZm9yIGRpZmZlcmVudA0KPiDCoMKgwqAgcmVhc29ucy7CoCBU
aGUgVk1YT04gcmV3b3JrIGFkZGVkIF9faW5pdCBhbm5vdGF0aW9ucyB0byB0aGUgcmVhZGVycywN
Cj4gwqDCoMKgIGFuZCB0aGUgaGFuZG9mZiBtZXRhZGF0YSBpcyByZWFkIGF0IG1vZHVsZSBzaHV0
ZG93biBpbnRvIGENCj4gwqDCoMKgIGNhbGxlci1sb2NhbCBzdHJ1Y3QgcmF0aGVyIHRoYW4gaW50
byB0ZHhfc3lzX2luZm8uwqAgSW4tZmxpZ2h0IHNlcmllcw0KPiDCoMKgwqAgd2lsbCBhZGQgbW9y
ZTogRFBBTVQgYW5kIFREWCBtb2R1bGUgZXh0ZW5zaW9uIG1ldGFkYXRhIG1heSBvbmx5IGJlDQo+
IMKgwqDCoCByZWFkIHdoZW4gdGhlIGNvcnJlc3BvbmRpbmcgVERYX0ZFQVRVUkVTMCBiaXQgaXMg
c2V0LsKgIFJlZ2VuZXJhdGluZw0KPiDCoMKgwqAgdGhlIGZpbGVzIHdvdWxkIGNsb2JiZXIgYWxs
IG9mIHRoZXNlIGVkaXRzLg0KPiANCj4gwqAgLSBUaGUgZ2VuZXJhdGVkIGNvZGUgaXMgb3BhcXVl
IHRvIGFueW9uZSB3aG8gZG9lc24ndCBoYXZlIHRoZSBzY3JpcHQNCj4gwqDCoMKgIGFuZCB0aGUg
SlNPTiBmaWxlIGhhbmR5LsKgIEVhY2ggZmllbGQgaXMgaWRlbnRpZmllZCBieSBhIGJhcmUgNjQt
Yml0DQo+IMKgwqDCoCBoZXggbGl0ZXJhbCwgc28gdmVyaWZ5aW5nIGFueSBvbmUgbGluZSBtZWFu
cyBjcm9zcy1yZWZlcmVuY2luZyB0aGUNCj4gwqDCoMKgIEpTT04gZmlsZS4NCj4gDQo+IMKgIC0g
VGhlIHNjcmlwdCBzaGlwcyBvdXRzaWRlIHRoZSB0cmVlLCBzbyByZXByb2R1Y2luZyBjaGFuZ2Vz
IHJlcXVpcmVzDQo+IMKgwqDCoCBmZXRjaGluZyBpdCBmcm9tIGEgbWFpbGluZyBsaXN0IGxpbmsu
DQo+IA0KPiDCoCAtIFRoZSBzdHJ1Y3R1cmVzIGFyZSBzaG9ydCBhbmQgc3RhYmxlLCBzbyB0aGUg
c2NyaXB0J3MgdmFsdWUgb3Zlcg0KPiDCoMKgwqAgaGFuZC1tYWludGFpbmVkIGNvZGUgaXMgc21h
bGwuDQo+IA0KPiBTbyBzd2l0Y2ggdG8gYSBoYW5kLW1haW50YWluZWQgaW1wbGVtZW50YXRpb24u
wqAgTmFtZSBlYWNoIGZpZWxkIElEIGFmdGVyDQo+IHRoZSBzcGVjLCB0aGVuIGRlc2NyaWJlIHRo
ZSBmaWVsZC1JRC10by1DLW1lbWJlciBtYXBwaW5nIGFzIGEgdGFibGU6IG9uZQ0KPiByb3cgcGVy
IGZpZWxkLCBwYWlyaW5nIHRoZSBuYW1lZCBzcGVjIGZpZWxkIElEIHdpdGggdGhlIEMgbWVtYmVy
IHRoYXQNCj4gaG9sZHMgaXQuwqAgUmVhZGluZyBpcyB0aGVuIGEgd2FsayBvdmVyIHRoZSB0YWJs
ZS4NCg0KSXQgbWlnaHQgaGVscCB0byBmaWxsIG91dCB0aGlzIHByb2JsZW0gc3RhdGVtZW50IGEg
Yml0IG1vcmUuwqBUaGUgc2NyaXB0IGlzDQphbHJlYWR5IGRlYWQgYmVjYXVzZSBvZiBwcm9ibGVt
cy4gQnV0IGl0IGNhbWUgYWJvdXQgZHVlIHRvIG90aGVyIHByb2JsZW1zLiBBbmQNCndlIHN0aWxs
IGhhdmUgcHJvYmxlbXMgd2l0aG91dCB0aGUgc2NyaXB0Lg0KDQpBbHNvLCB0aGVyZSB3ZXJlIHBy
ZXZpb3VzIGF0dGVtcHRzIGF0IGEgbWFjcm8gYmFzZWQgc29sdXRpb24gdGhhdCBmYWlsZWQgdG8g
bWFrZQ0KaXQgdXBzdHJlYW0uIEl0IHdvdWxkIGJlIGdvb2QgdG8gaGlnaGxpZ2h0IGhvdyBpdCBh
dm9pZHMgdGhvc2UgcHJvYmxlbXMuDQoNCg0K
