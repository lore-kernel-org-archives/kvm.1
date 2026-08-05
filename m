Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F242BE8B;
	Wed,  5 Aug 2026 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949861; cv=fail; b=qZ+1uWUoICw+dfd6yD1GRc2z0/KAjCN3oG0BW9n8+cwXF0SiThvWyjDHUHEeUJX/XtvXvZDY3S33Sp/z5lVdAGYS8JiWafNht7nwd39w1hmQvdiAS5Vf0n8+x+LwxJt7CPq86j2kPVIQb07B4kdmv65hJbdUgnMgEkllOCF7ZQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949861; c=relaxed/simple;
	bh=YrOCRekX0SqB0CqHCNn0KKWtvNTNrdnJzlKQYcwIbI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m4huEF7AIn9s9uz8feoNPIZHTQsSaHk9tfNBhxLlpEAOz7vzDTo9299weQUtVFjoL7b+ydwT7ah5JtttTqWTZHB9NnZFV1G5wYXQxXZH8Y+keXK4K5e28UKyYv4C5LTOWNtuf0PKdgMWgwFkTMA4ejtSUOwgVii+Y07cnHVqry4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIY3qoSe; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIY3qoSe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785949860; x=1817485860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YrOCRekX0SqB0CqHCNn0KKWtvNTNrdnJzlKQYcwIbI0=;
  b=oIY3qoSer5yoNG8BdyTHQrfhIlj456rZysNVfHGLHfKRNBCcPj0dPMDt
   ltZ5yClRZhpy3S4s43zcPyEvQZutNJ9c9weNN2CH3VhSjzZuTYbZSLttA
   Ijyiy+7NQQjSEQWZV/yJXGe+pntT2g5EwHriflKunrR2H3cK81ASek3xs
   WVrcvskcUIJxYgnNUpFaTULrv/6rfIOXuIDBTRlqMHRSlPc5ZIUNPgOrg
   0kFc+uqGGrvZ1ieKWVRU7Gja3GphnEyQIJ19jGtxOu8XvuHPfcDgIhQQy
   fjyNu8NmUJXofF5i9BRRHSyvdnf8ApfyeCdkLnSJPXyN2VpiT/rjqr5xh
   g==;
X-CSE-ConnectionGUID: StSEW2LCQ7SwzX9X8qd0Sw==
X-CSE-MsgGUID: Rgx2EaX5SnylRyKXyhuE2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90206064"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="90206064"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 10:10:59 -0700
X-CSE-ConnectionGUID: WiI93QA2RM67gSgGho811Q==
X-CSE-MsgGUID: Wr0+nbKWQsy3C5nWN+W1Pg==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 10:10:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 10:10:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 10:10:58 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.30)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 10:10:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCrbx1qtkeqmXznJ9RjzQAjNZSnjIYqjPonqufSBfnS1hytP8p65otpZyyI4iNhFNHr7SU30XrqZWgELFwErAPEDDs42RK5JQERJCC5ShU4sMajgpec9cv7BAUjHNik7yBgvMGTTeQ34PLZo2WpPlzWo5YFEpJACcv1o3pZ2pa3qbFyTaho2hXNjR28oTLA/hdPlZ48FYsjM8Lp9OpOI+iZXZDuSwwHYOwe/C6men3mjDHwUsC/KBQT2B6LDXLtJ6KLc/e356vMtW9UpZVDnIy5BGoyIoQkp2CaAoGLoyLhNL+nQuDmH2UhPCgMOHCXFP6MU+bM6h5PdDVGuwr2Ibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrOCRekX0SqB0CqHCNn0KKWtvNTNrdnJzlKQYcwIbI0=;
 b=kvO/H8PL3pDcqxFDlUPsSke2itNkBsilcvwVuo2QDgbE2doYg70WyxoDDJkl8X7QWKCFoFOs6FFLc5txWK9dZqgBzf5O7tDG3m0iVKhQIOT1UqGotJRUgwm/tLjsoYK+QnXe3DupFBmujvlvokUpTIWBag/MXc+5mYptY0cR//dvEzfrGnKlXV7CEy/58akxbJEJmgdGK68U7R2WwrGCTY2ohbMClFfW8Wy9aKg30Wl7i+P0VPtNN+OPtdvzYkQbFRbYpMkjF/egzIMZWRASLG44END4yLblvQXa2/i+9ejhOiMliyOkK2J/+NtxcAQRsqzAoQsoPdtRaTsEWKRYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB7442.namprd11.prod.outlook.com (2603:10b6:8:14d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 17:10:54 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 17:10:54 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
Subject: Re: [PATCH v1 2/8] x86/virt/tdx: Name the TDX module global metadata
 field IDs
Thread-Topic: [PATCH v1 2/8] x86/virt/tdx: Name the TDX module global metadata
 field IDs
Thread-Index: AQHdJATGPBt3Cb29qUqLKCyuqDa0P7aPs6QA
Date: Wed, 5 Aug 2026 17:10:54 +0000
Message-ID: <ba3a0c1b54770a069788adf0d9cca74bc15fe036.camel@intel.com>
References: <20260804112941.19894-1-chao.gao@intel.com>
	 <20260804112941.19894-3-chao.gao@intel.com>
In-Reply-To: <20260804112941.19894-3-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB7442:EE_
x-ms-office365-filtering-correlation-id: 04fcefa5-2f98-4503-d2ae-08def3148263
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: qu6QRK7Y0M21UfZ2d7xm7XgmEcVRBBEpJiQog9Ifof5xTs5DYeG+bZ3DgdooDS6r9qcx383wGkCxecmafizuiZTrR/sqoQa5GM+9j8xVWk3udfIKBR1/meGnRZF/DL+jUUy95LwyRqz/Vx65Aj31ob81oId1Ep7lXZQFIXECqo0snOHqT9Af42N6i7n/VxW4vgTMLyPoEhE4EF6lbJzbBp3qGt0WOa7cGYoMP6VL1hxrVUJkaNftAlLqA4W0PXFRFk3ftVJtLo4WEBhzwVCs5vqibBwRziky3rsy1tRquH1dWwa2QEiTFH8Dwq0r1Br4W9YHpoGckbGODC3kzabAl8h0m3vGhwV+2w31aTXvSKtSH18eKXwyab+WeQt2SwjnmSUO9xNDhEHc61tKMWnMlmqnOSu+s5VrIkftDZaVD9C0A6CdKz3RL9JJ3Yy4UQxz2jzfmujO7R0tUQhQ/lhlCgWpesMdsJ8ktyIssL8WcUx2iykPDdQIf87qD1U7Uon6u04ENxCD0d+UqEF/yimGxWaiaNfHbM584WpfV1qZAMOHr7NiKRmaKY7JMRgUlE8HZ6IUhvG9OMZf8x0y2P/HI+R46A/8j47ON9ILJ7od87HGdWR7GsOVEw2Gs2CJkYhptdN6ShHQHcbDXB7oFn4DdouoS9NPWQYnK2naasCuul8nTK1A6vA+os3Pus3HAjRjXKN+qhMCAlsGlpLJGg8bxU6hTNg4j1Eyo2giMGMeC7U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDVDYmNJNXdubmNkQmJ5NmFwZWlVUEFMazl3Skc2WEp0Qmtna2ZtTnNoTXJ4?=
 =?utf-8?B?bEFtbkUwYmV0eGI4SnEyaUxxSVZaOUxWSU9rYzVoZjBkK2lWYmFONXZMQSsv?=
 =?utf-8?B?YnppNzN5Skp3WFlaQjlod0dLdVBBbUhWVy9JUmREVS9MWm91ek9sT3dJQURr?=
 =?utf-8?B?V1dnUXE5ekVzZUFLK25LNUVVZ0R1UWx2dW85OHZzVVo4NExWTENaRUxJUGRE?=
 =?utf-8?B?T0FGWTZiejY5MWcwNmo4TVpTZTA2Y1NkSmhaQmJEemdHbGN1NER5OVJOakgx?=
 =?utf-8?B?OFN4OTFOZ05nT1F6Wk1Na0ROKzZQaExidVkxQlYzN1RIU0sxM1pRcHowVHpP?=
 =?utf-8?B?ZGk5RzFybWo5eE5hdUFEWjRDY3ppeU9oQzBuSVlyWHJsNkRuUVN1ck1VQ09W?=
 =?utf-8?B?M0FjeStBNUNPOG1qaHQzU1FyT09KYjZQalAwRVRUZXJwb01aMW9lbE1acFZu?=
 =?utf-8?B?ZmV6OStzWmk5T1BVbGhnOHJQRzBPMktRWXpyTEpxMFZpRTV3dXI3MVA4OENN?=
 =?utf-8?B?MWhSU0hDQVIrSWl3VHlnVS8xK3NGM0FwMm54ZytSZXdGRUVzbTE3d01WMHZ4?=
 =?utf-8?B?ZlU0eXNpakpIZC9WNHk1UjZLWjZLV1JycWlHMlQvdXhZSFFYMzdUZ3RNQ2RR?=
 =?utf-8?B?cFM1Vjk3UUlwdFZUVW9xMjVjY3BnMTFwQWxrVk5jczVHWDU0NlJFOUozNDlH?=
 =?utf-8?B?UVN5NkhRMTJNbklWYXlzczc0T1JISFRsdTFNOTlNalRBYTRvOVZhUDNuVFNF?=
 =?utf-8?B?aFFUZlhQeXYrcXppdCt0RUs4aUxrRXBGeFk1OVRKRHlSZ1B3WWV0QU9WQThK?=
 =?utf-8?B?VjRJTGtTcGZ3TmlUbTBHU1RZeUkvY0QraldLRHhIQlZUSkNpNVVNUC9raWVW?=
 =?utf-8?B?bllxY1VmQlhTY1NlZEEzYlRSbDVDaGhUZ1M3bUd0UmVOV0NLM0tVcGZXNDQ3?=
 =?utf-8?B?c3pjOFNMdTFySTNiSXljYkRBTlZ4Q1JxeTFOSkxheVhGUjBhZjZKbktqaVZx?=
 =?utf-8?B?YnJZVytWNUZ4MEZRZGNHanZ5eFMyOG5kVlNjOHRBSG5ZZ05TUkwwZzBKOG1x?=
 =?utf-8?B?NzJJKzBTenM1M29XMmpVR0UweWxCSHVqa05VRmFubDIxNVYzYVV6QmpqTlJF?=
 =?utf-8?B?eU00L2MvMUhraHpxd0VvT2lnU0ZGT0p5ZHVaaU9jMWlwb2p5OWdnSm5BQTNv?=
 =?utf-8?B?a3ZMcHNjTHlrL2UwNGh4eGRhNnlIOEJabmp0b1BRTzE4MExBbElHVk5PZ1ZH?=
 =?utf-8?B?ZXphamhnSWpPdHc5VWNBOGhxOUptMDN4c1VsWmRYd01ndndqT055NlpuTE1q?=
 =?utf-8?B?Qm5qUHE2NnZucTFDNmpna3QyUnBLT0pkY1prZER0OXc3S3hJUDVCNFBuTUlF?=
 =?utf-8?B?dkx1akJ3VTNjdDlqNUNUM3Z3NEMxdHZDZnRBM3N6YURzYkI3b3hFTGd1N3p4?=
 =?utf-8?B?aERGMElQZWQ0a2lId2JOaUUxc0lsYUJvYWJxWnRkNUo2L3FRSVI5YkM4NDRh?=
 =?utf-8?B?Y2ZlRnd1QWMwTEtwc0sxbzBJeGdTMzJ6L2hSM0Ywdng3blh1V25TbHVBSUJi?=
 =?utf-8?B?eExORExCdStlcStQUjcxWVJKVlZsSXFXbEJ2UFBlTUlvRE45ZlRkbmEvQnNi?=
 =?utf-8?B?OGd3YUJHTjRMWjI5L2s2d29OS2dQVVRuZ05WcXFjK2VRNHpRdHlVeFZUakdh?=
 =?utf-8?B?d2FYZGFxTnB0UC9XMy9SK2xNNVBMR1NxWE12T0tlakhVQ0NVdlEzLzRFVlpZ?=
 =?utf-8?B?UjRsSVo1ekxQWmFtdGpRNUFsYUIzK0lqUFl1d2xRTXBna2pOQW5XVFUyZHZ6?=
 =?utf-8?B?M245K056aWovRk9JRkNhTCtRVHJZTVZlYU53Rk5NQzZYdlcvWlVtbXRsdUwr?=
 =?utf-8?B?cjhoZ3MwOElLMnk4cnl0MTF0YWFDaWg3eGdRS05BVllrWm5HbnBvQWhNMG9U?=
 =?utf-8?B?bWZ0dWlaUEdBa0xwNGQyMm1hOElqZjNYVjFNM1d2bitnb291S080M1hzNFJ2?=
 =?utf-8?B?VlZmK1Bidy9wMEQycnYxMnl3MHVHMWJDSjU4VXRmdnVOMUJUbWczQy8rMVVo?=
 =?utf-8?B?UUN0dlNMWEVXVkU1Zm5Qd3M2ZFBHRTNSaFB1SU84eVJvbUhialRoOUJUUTIy?=
 =?utf-8?B?UktmSGpsYXpkSnAyRzZFN2ZERFNlNWg2a09MdlJPeGxwQ1ZINVVPcUFiejdu?=
 =?utf-8?B?YTFzemQ1TFNYRE5CYXA4ejRUc1hVaTlUcWErNjJNOHYycGdlOVhleCsvZ1Zi?=
 =?utf-8?B?anFNeWt6YmpFdjF0bllGWnVLVDFRQ2w5aXFjU2hnWUpZY2tJenFyNGh2N1RS?=
 =?utf-8?B?Tm1MQVhVdjhkbEVCUEh5bzA3OXhEUkszbSsrcG53OGlZOExxWHk2ZkphZ2Zk?=
 =?utf-8?Q?V3YZPMQQez/N0WAs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F369965E1DF7B49B6B9E890B10ABD05@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YGUfFAlQL97aHD1sQXR/jkjQ/NSPxWzovdgwRQjwf67dRvUQqTao6+4HF5TGE8AfGVVOUpkOnTmPfopVvbuvmR+emqAPqgG0w/ZKEC6w0o14ufQLrJJmIUg9zNCkOCy8cVjSrYQ5lvESTImazuwblXmKg9CZce0Zww3reGZeAGvTDcakLp4yCeYYid9+rOb+Rw8qO4HxxVjBqYugXsfsYJJvf9K2slGi8jHwx+Xo1Qr08CFis0jSkMVNI9Jm5JccBR5NoNvEERCboW5g0uv0/Ni/3DDh+om8oa7CC/Mo456ZHD5YK1mHiYEsnN7vGm79X6nKB5RVlK4p2dLlKNcOfQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fcefa5-2f98-4503-d2ae-08def3148263
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 17:10:54.4661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9o8rQSP/5Xvgkpz3rotBClOquuPag6IMssI07JIHV9TS9/U433vSjcmfdwXFBqkwkdcWhqMXf86DU4CdkBd6nJ/+p3bnvATe03mo3fC2Gqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7442
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTA0IGF0IDA0OjI5IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gKy8q
DQo+ICsgKiBHbG9iYWwgU2NvcGUgTWV0YWRhdGEgZmllbGQgSURzLg0KPiArICoNCj4gKyAqIFNl
ZSAiR2xvYmFsLVNjb3BlIChURFggTW9kdWxlKSBNZXRhZGF0YSIgaW4gdGhlIEludGVsIFREWCBN
b2R1bGUgQUJJDQo+ICsgKiBzcGVjLg0KPiArICoNCj4gKyAqIEEgZmllbGQgSUQgaXMgYSA2NC1i
aXQgdmFsdWUgdGhhdCBlbmNvZGVzIHRoZSBtZXRhZGF0YSAiQ2xhc3MiDQo+ICsgKiAod2hpY2gg
TGludXggbWlycm9ycyBpbiAnc3RydWN0IHRkeF9zeXNfaW5mbycgc3ViLXN0cnVjdHVyZXMpLA0K
PiArICogdGhlIGVsZW1lbnQgc2l6ZSwgYW5kIGEgcGVyLWNsYXNzIGZpZWxkIGluZGV4LiBFYWNo
IElEIGJlbG93DQo+ICsgKiBpcyBwYWlyZWQgd2l0aCB0aGUgQyBtZW1iZXIgdGhhdCBob2xkcyBp
dHMgdmFsdWUuDQo+ICsgKi8NCg0KSSB3b25kZXIgYWJvdXQgaGF2aW5nIGEgbWFjcm8gdG8gY29u
c3RydWN0IHRoZXNlLiBTZWUgIlRhYmxlIDMuNTU6IE1EX0ZJRUxEX0lEDQooTWV0YWRhdGEgRmll
bGQgSWRlbnRpZmllciAvIFNlcXVlbmNlIEhlYWRlcikgRGVmaW5pdGlvbiIgaW4gdGhlIFREWCBB
Qkkgc3BlYw0KZm9yIHRoZSBtZWFuaW5nIG9mIHRoZSBiaXRzIHNldCBpbiB0aGVzZSBkZWZpbmVz
Lg0KDQpCdXQgSSdkIGFsc28gdGhpbmsgaXQgd291bGQgbmljZSB0byBoYXZlIGFuIGVhc3kgd2F5
IHRvIGNyb3NzIHJlZmVyZW5jZSB0aGUNCmZpZWxkcyBiZXR3ZWVuIGtlcm5lbCBhbmQgVERYIGRv
Y3MuIFdlIGNvdWxkIHByb2JhYmx5IGNvbnNpZGVyIGFkanVzdG1lbnRzIHRvDQp0aGUgZG9jcyBh
cyBwYXJ0IG9mIHRoZSBzb2x1dGlvbiBmb3IgdGhhdC4gT2YgaWYgdGhlIG1hY3JvIG1ha2VzIHRo
YXQgY3Jvc3MNCnJlZmVyZW5jZSBoYXJkZXIsIHRoZW4gbm90IGRvIGl0Lg0K
