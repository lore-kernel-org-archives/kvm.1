Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729104D1784;
	Mon, 28 Sep 2026 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622894; cv=fail; b=earYxP7yXNWMv4/b0zyRfaEvdNKKqVt9Wl0xwQP2Oz4qIB41DqYi7b+FXAhEAae5cQvMpye45CluTf2dksaV1aKRAuT6RR5Z5yQ+afZOfQUAVpk7nYq87OKbSQlQuwblSYTrnMq06DU+GLR+wfZU/X2tT3cuyUlhReoE/NPzaUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622894; c=relaxed/simple;
	bh=2DwNwH4FjdF0sEjq97+JHEeLuSVvcTIaefi/8mwgDdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OPBCcwPUpa+FZsgdeeMKkRPcxphYW2Iq9KHFejOyu4SJQOasKDHtbVgu0K0tOCtSViIfDEDz6cN9OvS1UUfmGdqCp0rf9zMo6IdEMPTcGicbq4FLTFIRSuSXAkR0qZRGJkXklmoa1l86xAoFdxcrWlY0HSk5shgNKQveHNNQ0kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKkjtpW5; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKkjtpW5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790622893; x=1822158893;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2DwNwH4FjdF0sEjq97+JHEeLuSVvcTIaefi/8mwgDdM=;
  b=KKkjtpW5uWgwW7NnswSXHZYCf0JdU7ren7jPOvVMioUYUiTH7gUGzUSi
   AJCnfq7Vec34prC3dwdp0jnt7GS8rsWhdLwM6IJxvFzbhnsh3JVwc6HXc
   t+V2WpMOZORAw7QwTQA9Nly9YQufVsUTSLs8a1LEV6v3+94viIj3tCq/z
   oes2kiF5dYt04XqdBVg/5Pkrv7pox54oP/S6ZqsDTCnL2pgcm68n5L2zB
   ujYaA3d8eJKquixU8GZLrx0RO3TylUCYltLGUsGH3YGtbvCxGUPslVesO
   kLQXPmZUFcQtRBhYrbWcgHjb6Nm+10RA89lnKhUzHV39q4a38J96C8CvN
   g==;
X-CSE-ConnectionGUID: C6YMtKg1TY6STWwZyON/tA==
X-CSE-MsgGUID: WssriIFNTjafGB5IqKZiGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90549948"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90549948"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 12:14:52 -0700
X-CSE-ConnectionGUID: WngraPkxSJSw00uyDQGWZQ==
X-CSE-MsgGUID: lQNUO5CYSVKd05B6PjWgcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="274246512"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 12:14:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 12:14:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 12:14:51 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.31)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 12:14:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uh0ToN8wE+aJQgZBaXzYciazEU0wLGsShDpkDXB79vqhWtCSnVOBC0VE5BvNFnP0cVDEnFeAxfyaSvqL/3eeylkEFyt8SVZW86EZ2nJFyirvkXBi9/kxE5DDbQPYZeucJpaZW0+nuAH34V/RJe3M39o2NkTxKu21FJq/NUIipQYXMec6863XdruKMkzM3oHmy4EINyilZkIOLwQnnF7pfysjetiCzK1Rl5Li4FoeZit1s7KZEUBBmIv9cXoN5z4Eev2/5vQPmzVTFT4u7UMJJwv8za8DFs7JBMvPj4e+asoCLo90wY9OFrSY/qOVS/wCT9jBC5KBGhISuc14pqf5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DwNwH4FjdF0sEjq97+JHEeLuSVvcTIaefi/8mwgDdM=;
 b=qVEyn15AgI/Gs+g16SBI424sDxeuVDq9FQsTdJPvFKsdShD3xTRk+r1YprUr4lBzE14HR42m/QymYLFV7QcMFZRcun4Z1ZACcLzq7gNOh/bEj6h8fMkhkzwGE2bFJysPEgrnmhPSPUqhfOChA/iFvVt61QuHW7W/dwDCsJL/8fh//cF/AmLyAFOrBHWFm4PukcaXf3jNklsN8o34sO0J37rofXfwxrgZvA2+UZ82WI25F7UtK11aGvo2X+JQO0jbJL3+hSCrzpZ1zxpgMLzwmboozihX8kv8jFn7NGtD/J4WVWlpw9+EBJYwh1LNWdYxShS0bLRbkPet04s0a5CpNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ0PR11MB7156.namprd11.prod.outlook.com (2603:10b6:a03:48d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 19:14:47 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 19:14:46 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Fang, Peter" <peter.fang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v5 2/6] virt: tdx-guest: Give the Quote buffer an explicit
 type
Thread-Topic: [PATCH v5 2/6] virt: tdx-guest: Give the Quote buffer an
 explicit type
Thread-Index: AQHdTzGpCv9+4/S/pU+QZe9LAbA757bkXNaA
Date: Mon, 28 Sep 2026 19:14:46 +0000
Message-ID: <dbd03fb43ee90f017993121c53eb6c3c4afa0569.camel@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
	 <20260928100913.2265687-3-peter.fang@intel.com>
In-Reply-To: <20260928100913.2265687-3-peter.fang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ0PR11MB7156:EE_
x-ms-office365-filtering-correlation-id: 060553fc-0f94-4b6f-198e-08df1d94c28d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: 2y3JBkp5/tCwCyGEkAr2BlBjis8BM2Gwf3hsjmh/YC9OMT6+iYr3YJSQStXw8/9JaE44b7Fn77I4erUbPj/1Yu/zeCHJQmxQeT4GunU+c+BKs5PvDVA+Tg4VA8Ph3CjZlxCtSQlHfOgIVt+WPOdUutO6OdAbKQCO/0AzJgfgGVRkpDTi+Yjjr//GbJzuC+sl+1WjJyceDOtQD/PdRLU70WIg5tCQ1RI4uorvR9cv0hkFLV4hsDf+h3IQQHQqPH0YfCr2PfWXB0UDNdRJW/zHBX3RPW2ZJMvKCsl9iVtL3IO5+o44k8Q5zfsi4mD2nvzvXQWxT3TmRz/o1jdE3bVD+egBjxH+m1numcsXjp4JCrX/kGAtuIx0B4XSKLC1p5uOCHgVgTGyBUFQ03smxoGSG1yxcshHvUXRODh5jWJ4nB46shOPdDYlDBry2X0bso+84dW2cLo+hqbQU+ni8OmxTUdy2MdjsCOPHgl2ohdNO22CUyI9mE1nahtPAboVJPlwEbAaiN+E5olIZc/Kk+3R4YMTw4A/zwRIERRxtl3/ZaeuhJJIe7Od3wy+XzcGVEI3qQxS+2MH5q1PwrC2X0e9nmpE9KN9A2IR6FBTkqw032gZ7YdBIUePhx7/gxGN31eE+7D2RElBM7O5PdwtTQwovBfM7C7x9N4upMu5gfPZH3KlpglO7dZOAKcgoueBTEL+VSl3la0VbqNgWikN+WrOHCKI1M6QaXNW2SOqWBc2E/s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTFkbWsyZDNpVm1ld1RPbGZRVWsySjJYR0F3ZlN6bUZRSHpGOThJWUVVY1lH?=
 =?utf-8?B?STU0MW1KaFBDYnlMNG5aL1NxUHFpV0tOUVdPRXA5S3RjWlMyMFFqTUppZGNP?=
 =?utf-8?B?TDJ0R1lteWdYKzRackhzYXJ4TklBWDF0QVZsWE85MTdYVkxZTEl3WldMOVp5?=
 =?utf-8?B?ZE4yUlZJNStXTjQxMDFaUkRyWWNxSmJZeTExUFFNc1R3RFg1cGJPTkFMZE1o?=
 =?utf-8?B?WHFWNXlmN1FSYWJBaXR4NVI1d0htdjBLTVpaNnFnak5HQy9NMnRETmxCNE1y?=
 =?utf-8?B?OXBzQ1ppcTh3YXIzODJEYy9oWXhIWE5GWDJOeWxSSkRQMnVkZXlyMUJHVjVM?=
 =?utf-8?B?TlNmRDRJWTdyN2ZHQUk0RGNISjdtVGNyamhtTHM4L1JRRWhCNjU5ZGxzRldX?=
 =?utf-8?B?UmtHclNNbFE4dW84SWFUMVYwNkUyRS96U2w1dE5ELy9MczJEUHdMK1EyWmxs?=
 =?utf-8?B?MkdPWmgrUHd1ZHh6cnFPRHgrT1hmY1R0U1RDTVVUVVJvcm45NE9vK3czdkRP?=
 =?utf-8?B?bi9nT1ZGTXpmZXJyUGVNSzhSZEx1UkMyRTQ2K3h5YmtaM2xQSm1BcmlDT0Vl?=
 =?utf-8?B?L2x5SVdpR01UbSsxWEgvaWFHK2h3KzBISUNkT1V2SXlMVU9KRDRFWmVJa3Bv?=
 =?utf-8?B?by8wMmNPNnhvZFN1Q09sSmtCNzliRmJEdDgwYnJrVGVwMUEzNnNJVUJmU1B1?=
 =?utf-8?B?MDRhSjM5RGVKai95TDdzdEM2dGppazlWSFRsbE5UWXlLbWE0Yi8wOFBhS2Zk?=
 =?utf-8?B?ZVMraFA0NjdIWTFXTFJrRVhrNzVHZFdRWlJrZ1Y3TmRORTdjVVN1MEFuVVZX?=
 =?utf-8?B?NUNFWWNhbkV0b0RNOUNweWowSDIvaWcrTEpvT1FVUGVPTGh3akMwYWNxM1FJ?=
 =?utf-8?B?eU1OS2Znc3JWZ0FMZFpnTHlMZXdOOTlsS0o0N2tnTWZWZXc0WW44dkFSWkN0?=
 =?utf-8?B?bzRYT2Z2Y2JPYlhjVGpLbEMwYlgyRTQzZkZGVlQyK3Nxa2plYzd2ZXRQWmpx?=
 =?utf-8?B?QlN4KzVEc050SmZqQ3o1cWE1U3c5NTJPaGJHNXJhNHkvb1F4SXFVWWVSd01y?=
 =?utf-8?B?bXNyZ1FNZFlZaHBKSFNSdW55T0Zpdjh3YWJBQXh2K1lsQjBsamM0cDNQeHY3?=
 =?utf-8?B?L0lZOXQvNUNiMmp4RGFjUzA2S1dpa1JWKzVZQzZ0VHpaNW5NWDN2SHU1UjVa?=
 =?utf-8?B?TFg1dS80ZGk4TGVmT3JVQnZLSUk4S1Y2V05OL1dBYnpPbk5wN3gyZXArUWVF?=
 =?utf-8?B?M3ZhQzhxbE5XaWc3Yi9MaEZPVHZ6bDRyNXlVVmtxZnpiM2FkMklkNFI0MVBx?=
 =?utf-8?B?VEt1d0FXbnZBN2IvZlJuVXo3dU9MZCsrK2lQUzdoS285UE4zU0krYUU0SGwr?=
 =?utf-8?B?TU5JRnRxYVRzalZaZ0U3cXZNZnBHbjhjVTdBeE1pR09EdjIyUVNCaVZQS0hK?=
 =?utf-8?B?dlZkMkhUb1Z6RllsVnlxdUlNRnZ6R1ZNRUI5eXR0YmE3UFNsUWkvNWVvWUd5?=
 =?utf-8?B?SnZuWGttVkNrOGVkbjQ5U2UxOWFDejlWenI1UEdTMEhlSzJTcEVYczczUUdK?=
 =?utf-8?B?a0xCR2Q2K0puRXQvaUtHeHRvVy9reFVBVG1kdm9EY05ZYmxRQmhyNTZDM3hq?=
 =?utf-8?B?N0U3dFJSYTEzUk9IdGtKbDZhY1NtKzV3aEN5Z092d2htSmJKUmtXbnN0UFdi?=
 =?utf-8?B?eHZvS2ZQTnlNSWZ5dlNpMTRsRk1iZnk3a29MWVJQVk00ZmZGU214blY1VWp1?=
 =?utf-8?B?U0ZBbitNN3hpbkxiMmhlYTUvV0ttNlo4WVJ0eURHRHZJaTlCazVwaWx5MmNB?=
 =?utf-8?B?bFlQb3NndlV2QXJzRU4xWnl0SmVvUlh3ck84UW9KeXRQK0RTcUlqblMxYldp?=
 =?utf-8?B?cGl6czdGWFNxbktyRGxPQzBxRFd0ejVmWnBZRjEyWFJJb3dYdkYwZWhDclhi?=
 =?utf-8?B?UWc3L2VpeCtudmo2V1lTRHNSdE5ORlBFU2lwc0pYMm1oM2FDU0twc2hYMzVV?=
 =?utf-8?B?eEN3ZnlXMld0QlFJbExyRmc2UEtrQnJJYllJK0MwMFZXWGFURFkrNkFWdndM?=
 =?utf-8?B?a3NhZm9kWmN2eXJ0VGVyL2I3MjI5SnhJZzA5MmQxeDlXcURhTjY1WUkrVGVk?=
 =?utf-8?B?d3hyWUdVWS9WSUo0L1lSaVJSN1UxSFY4N2ovaVU1QnFIUXNBRXFTNjdUOVZh?=
 =?utf-8?B?OWh6bVZXU0EzSWhwMmgydnh4N1RCRUhDcHRCYnhjdnEralZlNmx4aUdXMW9u?=
 =?utf-8?B?dG94RGZDY3B5L0wwVHJ5aE5SWFJDbnhxWjRlbUg3REN1SjhmRjRma3FMRUpB?=
 =?utf-8?B?Ui83RmE4ZkpjM3NBRkQwUTZpZ0Q2OFQ2NWQvTFBkVVg4QjMwOXdjVVBzSHB6?=
 =?utf-8?Q?8woLKr2Ri1TAOdsg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA4346F4A035604283ECA65AD96646CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v+RJOFiGl2fiP2Xj4dlsqrzkbLReRjwb89RFUHHaiBk3v4rFJHBRoYl+Oc3D+FAtaXgC9tP6A28izBDIOWEk82EHa7N/d+J7YLfkkWq6U+/I2HVWZkzI5ZzfY7hHO2Vc1KNwQnVl/XwBEy3s+LdovplRHbPSZuRBdFL0uuFmN2IiUjMWiNNOROfyqmWTHwb4zr5Ls7BEzuAeBA8p7kKXJKUz43rBZSOO0siPnjrQj+4UA3SLglCxoosQ7+6VYNF6hPuofDhaPJAe0AqjEG45NW52quBaZKAfL8aPztVei2uaqm++WVKS4K2afpHWz4AXm+Ddv8K0BJNwD/Z9CNuTwA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060553fc-0f94-4b6f-198e-08df1d94c28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 19:14:46.5843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vR/4hICuXUiPcjN1v7338jYm1kKN2UnU3Plmxt9ZTH7boIPkGAlI7dWfETOxFeScoGhPvL9diCrJAYQL3Pw29FClZOoGNuBgRv9eBkdgFts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7156
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDAzOjA4IC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiBU
aGUgUXVvdGUgYnVmZmVyIGlzIGFsd2F5cyBhICJzdHJ1Y3QgdGR4X3F1b3RlX2J1ZiIsIGJ1dCBp
dHMgZ2xvYmFsDQo+IHBvaW50ZXIgaXMgYSAidm9pZCAqIi4gQSBmdW5jdGlvbiB3b3VsZCBoYXZl
IHRvIGNvbnZlcnQgaXQgYmFjayB0byBtYWtlDQo+IHNlbnNlIG9mIGl0Lg0KPiANCj4gRGVjbGFy
ZSB0aGUgZ2xvYmFsIHdpdGggaXRzIGFjdHVhbCB0eXBlLCBhbmQgZ2l2ZSBpdCBhIGJldHRlciBu
YW1lLg0KPiANCj4gVGhpcyBjcmVhdGVzIHZhcmlhYmxlIHNoYWRvd2luZyBpbiB3YWl0X2Zvcl9x
dW90ZV9jb21wbGV0aW9uKCksIHNvDQo+IHJlbmFtZSBpdHMgcGFyYW1ldGVyIGZvciBjbGFyaXR5
Lg0KPiANCj4gQUkgd2FzIHVzZWQgdW5kZXIgc3VwZXJ2aXNpb24gdG8gY29sbGVjdC9hcHBseSBm
ZWVkYmFjaywgcmV2aWV3IGNvZGUgYW5kDQo+IHdvcmtzaG9wIGxvZ3MuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBQZXRlciBGYW5nIDxwZXRlci5mYW5nQGludGVsLmNvbT4NCj4gLS0tDQoNClJldmll
d2VkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo=
