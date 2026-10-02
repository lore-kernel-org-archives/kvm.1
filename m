Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D5E403EB3;
	Fri,  2 Oct 2026 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969469; cv=fail; b=IuMtMcNTQuQFsYXbvcIfsZJ+axqgibTPAFQ3of+enYYl0ruN4mDKuMPPIKV8VNEcLm1WO61LMvCe4QdrWPBFlUV21bnbhQEAZLTVKc/2MxWN9SZrVtgdHEDZZmJWeCgHU6aSVMhQYPZEgAzvrnPSpvNatc5neeq8hdVmvM49nK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969469; c=relaxed/simple;
	bh=rBSg+3Vu2bjitDpSFTbmxWvQfdBRopSH2OCzEwMIhgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r9uImluZ36boo5B7ifpVP69xQoCP6CslhTAhldMZaU9a7vMSo7AReiUAve/7CZT9/q3eICLT7xsse2zCBnUyLoud2urXoJbEp2MKWw5xFeStko6BVLt1AWsg6iTc0ATQHAFyv6iMLb3TTBT1wFhXNinSV7ia5tZ3IJ54pQZQyHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaQJWlqq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaQJWlqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790969467; x=1822505467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rBSg+3Vu2bjitDpSFTbmxWvQfdBRopSH2OCzEwMIhgY=;
  b=SaQJWlqq8uoUIesaQ5TSYs+a4bEKA5eThb6L0wuGTTCDtNB+J5pJxPWa
   dveNQC6oOrWwypxGXhNtzaOXy4zhsDrFRcJs68wZjnRWDlbhc8STIKZhP
   lC5MeAmiEmbvsQ7jBy5d/A9TQswBvyCvYGXNyMHVsmUgni6SJscVpnmtC
   4+sPtO9APA2o2fgqzETnCSqHCge9SuG/MXzzzq5xAuVOmb+9ZrwMfUeis
   Y+O9q310latwdKI1K3jWKN2LnIXhjgMr0tgOw7uVVYvdB0P7EJxtF8lux
   g261QoZ81g06aWHwfak7wQQrsT4b1zs86iB4dsSWYq0t1DsnA6/i/Xt/G
   A==;
X-CSE-ConnectionGUID: vm9anFafQK+CF8hbOjiFtg==
X-CSE-MsgGUID: P++geynDSimXhFTcxFh4Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="101070319"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="101070319"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 12:31:05 -0700
X-CSE-ConnectionGUID: M7sy+ejlSpaJ2ktRCK512Q==
X-CSE-MsgGUID: frGNx+crTv62ScGkzuCZwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="314317014"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 12:31:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 12:31:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 12:31:05 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 12:31:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFfXnLhd8M3DGAHwvhoLfmiaf5w7d29CJViskrhxZ5xiNOlbrzSrXppwrth3yIkCTrLSX9MGKCTMw0WIsTsZb9IhohMJMSWOPEwnA80tJDkvQsJuvCZbbqQSpOzkZU1iYjncUDO3ILzvWP9qobbGQYGB229lyEW8DzLmKByHclFJDAaxixT2H1gxcWPCi+hDUUDskEA+EBnGfmfbEjyWhe1/NLP1fLXIlRpYp2XQeumpyDJzXIdoJ/cZsdm9uwZPpHeBHaquaMiFEjppQEIY53zyn8mk/ElfqNApBQN6fVbtGNsvUqwnivNFAjFXHMctEG81ix/eVkBJsAlP5XGlsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBSg+3Vu2bjitDpSFTbmxWvQfdBRopSH2OCzEwMIhgY=;
 b=Qg6o9fr/sob62wiTmwvu3HY3SuipF9nVTAwwJwPKw01x4ufzUnsGR19CJWmOgLr8s3GVatmhNoqH0u2mMGk93suF3Rj08LG7aHuouwl0W62BqKMmqv0PCN3TF85CZO3gbg8rIFcPK9HjProlCOyeaJBQ5zdbMHgLUSH9xXRMKCIRLLWYijvgOFz4ZufCVFIML3Awyy2NQ6EiyrGa4OIYeBQb03VlKjUXfWl/OU5hsocG1NfZ7jwFI78qOb7UhYRO6VQchCGCGX5CQ1KEnBt9v1RpnrfAyD0kbS/YSovEjfOrM/fqyNiEZD+ipsu/gHsY8oU5xduqFTTgnC4yCQZblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22)
 by DSVPR11MB9914.namprd11.prod.outlook.com (2603:10b6:8:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 2 Oct
 2026 19:31:01 +0000
Received: from SA2PR11MB5162.namprd11.prod.outlook.com
 ([fe80::70e1:28f7:f440:ff0c]) by SA2PR11MB5162.namprd11.prod.outlook.com
 ([fe80::70e1:28f7:f440:ff0c%6]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 19:31:00 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "kas@kernel.org" <kas@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] x86/early_printk: Add earlyprintk=tdx to drive the
 UART with TDVMCALLs
Thread-Topic: [PATCH v3 2/2] x86/early_printk: Add earlyprintk=tdx to drive
 the UART with TDVMCALLs
Thread-Index: AQHdSs/e+z4u5gEWqEeOrpmHmdHPmLbfLPyAgAV5w4CABcDRAIAAS+qA
Date: Fri, 2 Oct 2026 19:31:00 +0000
Message-ID: <dfe6e3aa7bd37679d2d5e559b9af8e254d88044f.camel@intel.com>
References: <20260922-b4-tdx_earlyprintk_tdcalls-v3-0-6ebaa599df10@intel.com>
	 <20260922-b4-tdx_earlyprintk_tdcalls-v3-2-6ebaa599df10@intel.com>
	 <arZbBqArD9NqWPry@thinkstation>
	 <c41ffc542bd677b71bcecbe4e2c2e2a3b605ffcf.camel@intel.com>
	 <ar_GLgzxdWUdXn0Z@thinkstation>
In-Reply-To: <ar_GLgzxdWUdXn0Z@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-2.fc44) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB5162:EE_|DSVPR11MB9914:EE_
x-ms-office365-filtering-correlation-id: ea163c60-fe8e-47bc-0fb0-08df20bbb0e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|4143699003|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 9MYYTD/TtvVUi9/V0AN4Imvrjvj9/wyBx3J6dmJpMQeRF8Co3M5D5DKU2rBKorHbtcyZ8JoDslYmHY9DTOs/HuMhcPbqdeMXaMQ7rdqnYmZTAp6Lu4rmIRfclf8I0mc8etnfL6eUyvRwzK/3+T19IYfqVSOeoMVXnKaTGFYnsKMmpBx21MurazutIAd/oIVXz9qGl9FMz/RVEix+Eywu0+sYwTAYpE4kduCberpHC3fiddcV9trIbLVHUygA/SXlaoL5xAolBNM50SAx9B8RPgFmfIo8m9E9XiHnCaTkbC8Luht5yyJpkLhJXHn43HQfhvsk5j/IFyVweT1Mtjg5+0+G8R9WQ79M77puhn94vEmIXCdKLrWwOjsVwfDgY6WMXXhKnxNyy/Kz6y0x66WVnT3chOaSuKYNSgVVc5nFhB7Mgt17XpMdpfe+IQTq7EKftJDBnPpHa8IgcyYC7r/BpqMwoTWcgYBc9i0KqF3sONj4PtyvLOgNWQ0/kN4BHeCDMTvYiKDau+leIJuDR3BBOC9Ji7jJArxZqUw56LzTZgFqRcYploasyKT2BPvg1Fa2r4PCm4d5BlUjD5yqHiYULSYan4LsB+WI2J2tDPLu0ch9bQmwinGOtutv8zn65c0xi4tIUeHF2349fk2jG00oXruZ7PSNZhC//Uj/A8LUdjljW1NqpLgxETFoDn/Y/GsUAkDbtHjCBQVcC1c8ZTycbx/Ruh+zWQiHDsrlxNxzBtM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5162.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(4143699003)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGdGNFlkb01oOU92VlFFZkNwVTF1SDNkS1NkSkd0T3g0cnNFdm9xeG9tYzRy?=
 =?utf-8?B?RzhrdVJ3clBKYjdkanVMNUUweFdzWlB5QlE3ZjYvMk9QSzBDa3JiMFYveVMv?=
 =?utf-8?B?M1czMlU2d0dLMnNBdnFhMS9pOWVvRHBadTgrT1VXSERDdSs1ZzBldzdtd2FD?=
 =?utf-8?B?M2l1eXhCWHIrUTZEN3hhcENnRHo1anBiSWc2RHFBRFdwNitUK05GanVtVEQx?=
 =?utf-8?B?RU5OWEJUTGxzQlpVNlFqQTBTK3ZnVXg0M0dWNWU0ZDV2UzhMeDdvZFNLZHRk?=
 =?utf-8?B?NHA3QzRhVWxoKytscmpjbHBVTVpFR2pyNzN3cksrcStqSU5rYStDNVRyWGJL?=
 =?utf-8?B?NEhkRTIray9oenArN2V2czRTMDE2bGhoakt4Ky9VandCNGJJZW9FSkl2UGVU?=
 =?utf-8?B?UG5SM1JzNVordHFwV0ZOcE1YNTVrMmVDZEpYbkx3ZXpYb2ttTk10NWlBQXpn?=
 =?utf-8?B?L1RwR3FFNHFzZ0s4UXc5akFyU2tLaUVHcmdPM2tnMmNLVEIxRFJoZzlzcXRS?=
 =?utf-8?B?T1UydVB0ZmZQcjBjN0ZsenlNcElJVllvWm95Wm84MXZpc29obGhNTDFDd2RX?=
 =?utf-8?B?cXZtaXlEaWhUelQzNk9hNGlPQllkQmx5WW80a1I4b2RmY2dTNHRoZkQ0TTlH?=
 =?utf-8?B?OWkrSXVSQ0t0WVAwajJ3VUE3NHV0QTNUUkN5ZmpITTJIY0x2WnJrb242SWZB?=
 =?utf-8?B?eDBaWk9JWXlPVi9HRnA3QjhpeW1lR3BYcWxLVVNtQUc4MnVkN0xXOVluNzJ1?=
 =?utf-8?B?dm1iTzJyWW9zU05CZnBmMVRUTkdndGc1bmlsajNVZVhiNm1wbFYrT0ZhdGhY?=
 =?utf-8?B?NmdWR2U2eU5Fanc3bjA5VWhObjI3bnQxVHJmeWlGSjRZSGIvNFZNTXBvUWZj?=
 =?utf-8?B?WFpsK0RrK3JLSm9PRytMZEE0RUl3YWIrK1JKdEc0ZmhXTEF1aCttOGc1QlBS?=
 =?utf-8?B?N0JmdTNxSmJoaHpRZHB0Kzd4a2FpdU9vU3V0UnBKK0I0d05oRktueVZxK3Vw?=
 =?utf-8?B?QjJUSkNRWXlXMmk4NUpneUVUM2xoSXJNOWIxTTNjeWN6Y3ZUL2RVVDVjWjBL?=
 =?utf-8?B?RjRaSk1TSE9kV1ppNU1MTkZ3Q3NoNlZWbGF0UzZDQ1cvYjBHeVZpdlRBSHhu?=
 =?utf-8?B?VGo0SGZYMHlMaWl4Z0E5c2xCbWVFTjRsVmprUGJnYllrWEYzMncwdU93OWVI?=
 =?utf-8?B?MUk2aTNUV0tRYkwwZ0lYakR0akFoM2dzREdMUTBab3AwVTFwcGtMTmhSYlBt?=
 =?utf-8?B?a0EzeU5rQ3pUTEdwQ1dJdW00VmhzWnhzQWNMd0x2cWp3a283bGdhekdOSGxz?=
 =?utf-8?B?aXlDT2hvQWxYZkdpNWh3RE9oUk50MkgvSWZMWFVzdWVwNVBaanhmdHZZTy9R?=
 =?utf-8?B?eDhiUEJ3LzBWKzNGZFd5bWFjMmZWWHY4bzFSUTdabXJJMFA0ek1mNDVPUlNP?=
 =?utf-8?B?b0hjbmRtWlg0Rmp3T2hkenkyTElYMlllTHpYaEowVHh2YjNLbGFGK2dxb0hm?=
 =?utf-8?B?UXJWMHA4eDc2eW5qTFEwRFQ1elJFb2NoMHU4WnV3MG9STXZ1aTNTeXA3TWp0?=
 =?utf-8?B?cGMyUGlhaU5MNjNoTld5aGNQZ2UwTENvSitKUUFqczBSaE9BUHgwaFNtWExO?=
 =?utf-8?B?SWVoQjJiZHAxR1ZDdUFXeGF4SWZsQkFrQzJidXI2cU52d00ySi9hMDNZbkhy?=
 =?utf-8?B?VFVkeFZmUVYxbmtrQnpjUXY1WHFzUmhJRHZhSFBDSFFRa3U2WnlKa3EzaFpD?=
 =?utf-8?B?TWkxZy9CQWM5Z1MyU3RDME5Gc3lzQUhQalNKNWIyWHVGZ0pNU1Y1T2U0VlFt?=
 =?utf-8?B?N3hsQW5RNzkrczdKd0Y1V1lNb0RaakM0OVpkUThJYXBvTzFjZ1VxaXFvcFJD?=
 =?utf-8?B?dFZ2dzJYTHd3WTl4Y0tvWUV6MHB6bWllRW16UDBFVVN0L1hOajVCQThHUlF0?=
 =?utf-8?B?T3VXaC9yYllTTEFhUnhhQS90bFFmMEFyZXpCalNBcVQxS2o3UDZYbi9icWpv?=
 =?utf-8?B?REt0M0ZmUm9wWDU2b2xuTmlFcytrbTFGVVM0OXM2ZXhHVmZZemF3NWtXM0JW?=
 =?utf-8?B?NkRweXppalBOZGIydnNCempSMnJxNFhGMCtUaVBFNXRxVGFGTzRuWSs5cVpq?=
 =?utf-8?B?R0tZTHNjbXVLTkUvb1ZPbmU3MlhmcnZhdU5YM3BUSUJZK1hZMUQ1RDBzOUJ6?=
 =?utf-8?B?TFgyRlAyckV1KzJGK3V6SXJDSGdyeGx5ZHM0SzhoWmhEb3BmTENPcHdSZmNt?=
 =?utf-8?B?WnpubVJDYUIvcW12SHI1di8vNVpveVgyQ0JiR2V3YnE1NnkwMHZ1cXlsSWFR?=
 =?utf-8?B?ajlxU1A4V1BIMHFrU0gxQ29UU1BNZ29WRUxydjNURllEcDNpdUc0elNmaDVi?=
 =?utf-8?Q?0I/J1qRg0jV2yGmI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D49C3880366CA241B153034C9B085933@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aiiFDiAjZRolxeEyMSpBFmjEgi8K8PxFrml5Wz7jXd3hBkQBlhRxoZETJM9YBbuxXE8j1ZWWbRU9UD7i4TWy03Ghm867hpcASBnNp3ZjdWJ1eEY58XLjE7j2Uk63Bm19dpWVNdBCMfT75VpI/8UGgdrFSpvg86ooDhwQB+Zjhja8BW0Hk+EoVTn91LL0AOW9INdx+bLXXji0zciXID6h5TZEZ2D1e4nh1eoUeotOiTUHPriqi/LhvhYdk+HPOUFeHlRZYKk8QtePWH+AYVSVLuC74c1LlS/l5WlBe0JsVAqZst3ReKGzCMnp8A4nAsDhHjjwpO/prUs7Cx2KvJlWJw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5162.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea163c60-fe8e-47bc-0fb0-08df20bbb0e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 19:31:00.8563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EUM6WUIjlib0NpH08lM9IAZX3ZVw6eX167hBY5Pf3AWe13T36g60Q+UITgxx+a0zwvNeaiJkd4El+kIpxK42tNdnY/+hEtHd7e9oAnTq3oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9914
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTEwLTAyIGF0IDE1OjU5ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+IA0KPiANCj4gQU5OT1RBVEVfTk9FTkRCUl9TWU0oKSBpcyBhIHRvcC1sZXZlbCBhc20oKSB0
aGF0IHJlZmVyZW5jZXMgdGhlIHN5bWJvbC4NCj4gT25jZSB0aGUgY29tcGlsZXIgZHJvcHMgdGhl
IHdyYXBwZXIsIHRoZSBhbm5vdGF0aW9uIHBvaW50cyBhdCBhbg0KPiB1bmRlZmluZWQgc3ltYm9s
IGFuZCBvYmp0b29sIGZsYWdzIGl0Lg0KPiANCj4gX191c2VkIG1ha2VzIGl0IGdvIGF3YXkgYnkg
a2VlcGluZyB0aGUgZGVhZCB3cmFwcGVycyBpbiBldmVyeSBub24tVERYDQo+IGtlcm5lbCwgd2hp
Y2ggaXMgdGhlIG9wcG9zaXRlIG9mIHdoYXQgZHJvcHBpbmcgdGhlICNpZmRlZnMgd2FzIGZvci4N
Cj4gDQo+IERyb3AgdGhlIHdyYXBwZXJzIGluc3RlYWQuDQo+IA0KPiBMZXQgdGR4LmMgcHJvdmlk
ZSB0aGUgYWNjZXNzb3JzIHdpdGggdGhlIHNlcmlhbF9pbi9zZXJpYWxfb3V0IHNpZ25hdHVyZSwN
Cj4gX19ub2VuZGJyIGFuZCBhbm5vdGF0ZWQgdGhlcmUsIGFuZCBkZWNsYXJlIHRoZW0gb3V0c2lk
ZSB0aGUgI2lmZGVmLiBObw0KPiBzdHVicyBhcmUgbmVlZGVkOiB0aGUgb25seSByZWZlcmVuY2Ug
aXMgdW5kZXIgY3B1X2ZlYXR1cmVfZW5hYmxlZCgpLA0KPiB3aGljaCBmb2xkcyB0byB6ZXJvIHdp
dGhvdXQgQ09ORklHX0lOVEVMX1REWF9HVUVTVC4NCj4gDQo+IEJ1aWxkcyB3aXRoIFREWCBvbiBh
bmQgb2ZmLg0KDQpIaSBLaXJ5bCwNCg0KVGhhbmtzIC0gdGhhdCBtYWtlcyBzZW5zZSBhbmQgdGhl
IHBhdGNoIGxvb2tzIGdvb2QuIEkgdGhpbmsgdGhlDQpwcm90b3R5cGUgZGVjbGFyYXRpb25zIGlu
IGFzbS90ZHguaCAoc2VlIGJlbG93KSBhbHNvIG5lZWQgX19ub2VuZGJyDQphbm5vdGF0aW9ucz8N
Cg0KDQo8c25pcD4NCg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4Lmgg
Yi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHguaA0KPiBpbmRleCAzMjVkZDdjNTkyOWYuLjBiYmFi
Y2YwNzkxZSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4LmgNCj4gKysr
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4LmgNCj4gQEAgLTgzLDkgKzgzLDYgQEAgaW50IHRk
eF9tY2FsbF9leHRlbmRfcnRtcih1OCBpbmRleCwgdTggKmRhdGEpOw0KPiDCoA0KPiDCoHU2NCB0
ZHhfaGNhbGxfZ2V0X3F1b3RlKHU4ICpidWYsIHNpemVfdCBzaXplKTsNCj4gwqANCj4gLXU4IHRk
eF9pbmIodTE2IHBvcnQpOw0KPiAtdm9pZCB0ZHhfb3V0Yih1OCB2YWx1ZSwgdTE2IHBvcnQpOw0K
PiAtDQo+IMKgdm9pZCBfX2luaXQgdGR4X2R1bXBfYXR0cmlidXRlcyh1NjQgdGRfYXR0cik7DQo+
IMKgdm9pZCBfX2luaXQgdGR4X2R1bXBfdGRfY3Rscyh1NjQgdGRfY3Rscyk7DQo+IMKgDQo+IEBA
IC05OCw2ICs5NSwxMCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgdGR4X2Vhcmx5X2hhbmRsZV92ZShz
dHJ1Y3QgcHRfcmVncyAqcmVncykgeyByZXR1cm4gZmFsc2U7IH0NCj4gwqANCj4gwqAjZW5kaWYg
LyogQ09ORklHX0lOVEVMX1REWF9HVUVTVCAqLw0KPiDCoA0KPiArLyogT25seSByZWZlcmVuY2Vk
IHdoZW4gWDg2X0ZFQVRVUkVfVERYX0dVRVNUIGlzIGVuYWJsZWQsIG5vIHN0dWJzIG5lZWRlZCAq
Lw0KPiArdW5zaWduZWQgaW50IHRkeF9zZXJpYWxfaW4odW5zaWduZWQgbG9uZyBhZGRyLCBpbnQg
b2Zmc2V0KTsNCj4gK3ZvaWQgdGR4X3NlcmlhbF9vdXQodW5zaWduZWQgbG9uZyBhZGRyLCBpbnQg
b2Zmc2V0LCBpbnQgdmFsdWUpOw0KPiArDQo+IA0KDQouLiBTaG91bGQgdGhlc2UgYWxzbyBiZToN
Cg0KK19fbm9lbmRiciB1bnNpZ25lZCBpbnQgdGR4X3NlcmlhbF9pbih1bnNpZ25lZCBsb25nIGFk
ZHIsIGludCBvZmZzZXQpOw0KK19fbm9lbmRiciB2b2lkIHRkeF9zZXJpYWxfb3V0KHVuc2lnbmVk
IGxvbmcgYWRkciwgaW50IG9mZnNldCwgaW50IHZhbHVlKTsNCg==
