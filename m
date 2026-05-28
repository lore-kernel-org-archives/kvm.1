Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1836363C61;
	Thu, 28 May 2026 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007468; cv=fail; b=C/MRuFHs5cm6vykpV2ZEmo2o+M41CsyBkMVoHgvuYbdOzHmcghz7KjIcFtXGDO+DoQufSoTHg83CkOB0XJxnytYWD/irOb5hXoecWB/CvZskmwThiSogl2dheDvaU2I7U/3A1musiuatAQulvN1nTxPt0qWNoXyBz6tMKMEBH1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007468; c=relaxed/simple;
	bh=s+S26b0XPDuMhiLp6kiEbc5ZA8aWGlMs5ovNLChVAyk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kR6VEnXNoD2OUOAjOLKh8rvuptylARo8a1SxmRYgSkRxg7CyZro+OHKt45tjG2qtCtd2GRGGuXVR47oh8HXjf3htsLdI4/N4WGChIfoQwUdE0urw6Am0Y6S5lsblNie5K/8OBhW7Ual8jnH+DH2YQO4J7dNKC+kjvmMXceh/F8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNdqopI/; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNdqopI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780007467; x=1811543467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s+S26b0XPDuMhiLp6kiEbc5ZA8aWGlMs5ovNLChVAyk=;
  b=gNdqopI/r3c5qcNTThYKnz/hXj5T8CwL2fr36BBF66e96ZQvdaiaNDUy
   Y3SamStfEfewVaIcW269ZQ4ajxw9TgF4ajJPRJFM6ufdTJWrDiEivAsTS
   L8QegofrbXKQbVBZu/IK4xPmoayCOmbswX8vNhRdkSITDXdaJ3SQ+Rhkv
   wkymE/KzLw1kRS2UQsE9TtHr3aFCQau5Lr9IAgimsKGr1C+T32g8U5AuJ
   wo12cG32cZ4JyU71uJegawwrQqcgGIOKeNzjeDwfgz86ZOZJcDsU5r1dw
   QRD/quzzWVzIlpIH1CeHJOVFmcQAiFim5+z+XzyHaYqiHMOuvVAHue+/u
   Q==;
X-CSE-ConnectionGUID: chR2GNE3QUOJauAT7lCmZA==
X-CSE-MsgGUID: aFLg8JADRsOUsO9KovgwlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="81043935"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="81043935"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 15:31:06 -0700
X-CSE-ConnectionGUID: PMNJuc15T6C4SvakT7yS5w==
X-CSE-MsgGUID: VYedISFyTiK/2TLjmASgFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="238488542"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 15:30:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 15:30:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 15:30:55 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 15:30:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilsUjKmcGdYBGyejTiZ9zHwR+v9Th5dUhV2LArAgT/yg13fnp+SIWelWmK9L6zugQubAwK+d9zef7oIPE80OoKlUuseIGZUy9tBGpavhG8jOKe7NwUAzgAqRuLKMDAd5y1lSa6JwUGprIKb9fP82oiigDZVYssLv9nw50Op1Zxh7aQr/4Dp3rzAsyAT/Co2VkWgc3R0FiBJq8WN7ftP913++A1025V7BQR3/X9QC02cx4Gyim3vbLkSO7VayAT3z2H34Lr7z4MgLeyWNGUYIIMEh/TZduXE0nWbFjAffjcfRKXwPcrUH1+JrIkoqpedRwtslwm6OsmJ6SEIOL9cmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+S26b0XPDuMhiLp6kiEbc5ZA8aWGlMs5ovNLChVAyk=;
 b=soJNcKLLpb7SBoCRghyFvIQOWgGugRVXcP7ZWmOO0dHxqyXGr9viiQQTOfgqkLx63JO8PwvUMO0C9okJ6S2YczQrSCBbt3Z1ebbqEoNRJ9I2EoyvwFfwSEzaEyuEzBGxKKbDPvXIABl3AYnci3cCfdHTtNj/O3/NTNFTxMvXRVwZ7eGGU/7bwn3FZpn3p4zgM/OY9O1XAVhwLP3tlvqHMVEwc45TP+OrwH4zi8Xhs1ClcEO5AKyHEoBPMLUDlSfE70mlWv+37zWeXdfpsJWAVaCBIbDcYO8755x5UMYQO3WEigavi/HsAz3/cJASiJb8CW5M14I2x7FeSsaZ3ideRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY5PR11MB6163.namprd11.prod.outlook.com (2603:10b6:930:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 22:30:46 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 22:30:45 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"djbw@kernel.org" <djbw@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 09/15] x86/virt/tdx: Add interface to generate a Quote
Thread-Topic: [RFC PATCH 09/15] x86/virt/tdx: Add interface to generate a
 Quote
Thread-Index: AQHc6aBNUAryAC+RgEWGOFlQ4oSpYbYkD/0A
Date: Thu, 28 May 2026 22:30:45 +0000
Message-ID: <a10ad58ed8092e4e7d81be1995438efd21647fde.camel@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
	 <20260522034128.3144354-10-yilun.xu@linux.intel.com>
In-Reply-To: <20260522034128.3144354-10-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY5PR11MB6163:EE_
x-ms-office365-filtering-correlation-id: 2c8b725e-8b04-4d37-7045-08debd08c293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: OwOxNiI8YeuqickSBrcqhgP+bwNoqRkijmnPgNXGDAXlECekwyNB17NYq02T4n5MP0jmqtcfPLUd96IWnqvM89ETZPG2J4fKLTN03RCm6vd27c+mRopm87Ry99zUzA+MpuO3pnTZ9A9Y+uKRYZVvLFZu+rPyPWaz+yTu5z7oniLNYHYzw+JK7OPCckobKuf1E/WRO3AZAqXpJRPsg0KfBOKXh0AHL6Ba9Q/wzSUD3L9nPPZY6Btp31zrSwwKKUfqIKQ6vEA5hY0tptxf6ePT3oVFhGsVYQbYZRMajIkCF50G6FNZg4bLBJhpceaw1z6q1Jg3PgdKrigxI4qzEkuDVh8Ux7/P0kmpEuW2JdLLBzzHLdlIAo5bvMny9ASZHIpWjv9UIJfd0b1aOYmpWgb9TanEMSCWzPuNgZ7HmeoYhzx4LKj0WCi+UdBbIdWYJTSnil1SFNH2/xAgZqF92s9WWZ3/nARJRifby+GA3O3G9SIez84KCqgVFeX8L9BfwplS6HgFZkTB7dkuDK069XpPzFmqxOimLZ4r7NCa1N8mBEGJ/Ri1QXD8GOzxdZZYQgbQJYuwDy4TvExY2K4Z40nDEBXSpQ/4++LQv2cbV8Zau2PNjo0jP1hNO5WwWceYfL0u2BBvjeA3R7yMRzKdcWavqorX0zqliXNzRdqtry3V0UOunu0aBKbOlTkXBnYUb05m/EZcaVhTnBzeHmit30Yawu3gv+rDY7M58ZZ3UbXE65xsOFjjvxLa7/tWHSCwFbxL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djBpQ0VMRTRCdkltRDhKRVV4Y25iakUxS3IzSDJjLzcvQU9SK3NNS3owL25I?=
 =?utf-8?B?SExKRStERzBCZTF5SFRrdFRKY3BaSndYT1p6aWxlTU5ZWGN0NVFJOHN6cjhI?=
 =?utf-8?B?WHd6UnpmcW5OMkZ5Ykl5RzV2aWw3K3FudUlEaXl3U1h2azZtT0YvcjB6aDdB?=
 =?utf-8?B?aTZxREhoT1YzQ0lLNTdFOVk2TjhBNGRlcDJRMVAxNnVDWG50ckZFL2VOY1ha?=
 =?utf-8?B?WHpCR1JBcFNaZGVSSUt0eExlUTcvN0lLS0J2bFp4S2FJYzNyWWhaK3RXMi9S?=
 =?utf-8?B?U3lPM21QZWgxLzQzT05NWFp2TGU1eVFUUFpvTld6ODZJZWVQSUdZTFFrSjVF?=
 =?utf-8?B?dnlyaTltUFhDaUtZS3p5Y3lDTmhvdXNRdWFsOEQ3RVZzZ2RadURzUHVHaWhW?=
 =?utf-8?B?Q3kwZVM3L3hWdG9JZEtMM2xpQ3FHM1NPSXp3TmJKWlBUNXVCQlBUTjM3ZHBt?=
 =?utf-8?B?anRvSWZEdWx1WW5Bd0tiVWtEdUMrVERUSTNDd2xVMzZNNEJoSUF1MzJlMVhN?=
 =?utf-8?B?QXZ3WjZmU1RqZFpWdGpaTFdOYnllSHJ4TGF1ZWFUZVdBMkVqeExTVlljelhM?=
 =?utf-8?B?NkxranZURWxiR08vdjdIK0NLMTVPZVY5MVF5NTh3L01JMTJ3dWxkTld3eEhq?=
 =?utf-8?B?cmdJVU1XV1BrRnpwWDdQcjZpR2RMTlpCeVphM3g4Znd0djkvUGMyblM5M1dD?=
 =?utf-8?B?a1lPMGtiUEs2RE5GNDBDVk5QeDFpVEgwdXRZSWt1djlEQ1FVem1KMDZIRyt0?=
 =?utf-8?B?UXJQaHVwL0FTTEdZZ2hSNUxaZWl4R0U4OGhoalc1MUFSTnVnZCtSaEdtS05k?=
 =?utf-8?B?RWNNaGJSNldvaXRGTW9naFJwWVVqYkFBNkE3K1BEMFFBZVpLVXMrS1ZITTky?=
 =?utf-8?B?SytwNFBRT0U2a1hzRGVmeU9EUW1KSFRITi9aWWFrY3JicXlYUldxc3MyWjFL?=
 =?utf-8?B?aGppcGozN0tXbklLZlNOU2RjNm9rOEt4MzhTeHFHaDUxa3FuYlFNN0JFbmky?=
 =?utf-8?B?dXI1d1hNWFRBNnlUR1NwR09wbWpMMDZrcnJRdStySWtjeWxabEZMWkdrR0hE?=
 =?utf-8?B?TVFUSS9nY2JkVWFHUHVCVlBYa3FqSG5OZzdPZFMzMWNXYjY3blNUMG1XMjFp?=
 =?utf-8?B?dnBndVJzZlhZWGh0c2lwRnFpOE5NSkFOL0ppaFlid0dtUTArZTRGNHZUU3lD?=
 =?utf-8?B?WHNDd3VMdDF6Z1NkYzdoZE5YcGt5N3cyTzlhbk5BeTBRWXVvKzdPeVQ2cWEy?=
 =?utf-8?B?OURUN3hBSDlpdURtTVNGRTRhdjBrYzl0YWVOOEh4Sk04Qjg3RjFaU0d1Umor?=
 =?utf-8?B?UVBOdDVuSGlKMk9WcE5uaWFEdGlwTll4Zm8xNXJCN0JySzh3TlZxRHhKbGJM?=
 =?utf-8?B?Q2czMmxTNTdhSCtDQ01tU3dpSjFtejNKQVhyRTdOdWFGb3E5SnM1RWVjOTRZ?=
 =?utf-8?B?Sm9nb2h3R0JGTk5BeTZqQ0ZKVUFlRjlRSEs5Y3dLT3czQVdrUkdSS1RLd0xu?=
 =?utf-8?B?M0FDRWRwU2ZyQVl3c0pGN1FocUwvQkp0TjMzWGp1T1RqK0d6eXNQdHRDbElC?=
 =?utf-8?B?V2lnNm5MYm9NVnlSRmRjODI0OGIvcDBwd2xsbUVrVlp6Y0lkZ01jRHBVVWZD?=
 =?utf-8?B?QVdleE90UXBYVUFuQ2s5SmFZUi9EVXJoeVlYVzlkS2RKMy9BRWlZdGUyRWtw?=
 =?utf-8?B?cTI1T0haaTB0aHh0RmNrZGs1S3dIb1pVWG5DdGFWU0MvWkc4TzRtL3FWenA1?=
 =?utf-8?B?UHBlRUNCQWhBZk1vQStPTEhQellVMUxJQVEyUXNNVVR1Rzc0QVFjUElGRFlF?=
 =?utf-8?B?YUNGOEduaHVtQXV4RzVudElJdkNlS3B5b1N0U1psYkVBdHJkQ2JHQXdGa2lQ?=
 =?utf-8?B?OGVWNzdQTis2RkhmdjVnY081NUlYandqamdXYS9mbnZpaldMTm02aW9oOG41?=
 =?utf-8?B?enpvR2hDTFBlY1RsWW9VNVM5aEVFMitTbkNlNFVMQU9LTW5FdU1nL21Xd1Zv?=
 =?utf-8?B?Nm1kYVlUUEZjVkd4YW5pWm5wM3VvNUlkL0ZVWUtOekR0TGRxUnR6VUkyaDBq?=
 =?utf-8?B?U1pwVXZnSVlKZjVHdFVJa0EyYkVQS0lOM25qVTdVSHBTOVZUYjJ1OWdoOW9J?=
 =?utf-8?B?dzkyVlJBRnllYnFWWk9sNVJEVUVtUGZMUSt2MzV1N2JOWmcwZUNmL2M5aXJM?=
 =?utf-8?B?eStETzlRdXFNVmJrRXNVTFlUYkRVbkZOZDU2TE51OGgvZHFpVGx0OVZ0TjE2?=
 =?utf-8?B?aEd3Ukl6VWxsbEt4M0x6YjNRWW5VY2Z4Wkl2TDlQdndIemM1NnZramlmNUtF?=
 =?utf-8?B?SUFHd29tcnVOOWlmSkpITkRiYnVYMStMNENqN2RjZmFqUjF4VXF5b1pkajlV?=
 =?utf-8?Q?hYtp5cMmTcNrXgpk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C7F81020ADF9D488B936F0E9E3F206F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: K5jN5aueoB5lJAkFSuVgLYDb7FK3RyjqPkmDsxSG8duVOKgzJnvHN0W7qwJn7FuyYpJLofERj+AH9nXlBdC/Dg11w15TNKwAbGkBsd4M4UkBp/mmALattlgutdEHNuTT3xeXvlAcZNoeehBpGsSdgk5PF6hRirIHn6HDkYrFKLXhH9NzTbVa+v7YyiyqmLuEzNTGEVOuWq/Ioto+hwEhKwIT86/QPjxfxbu0w/H2e59sR2EuW6tKelvu/VoK48232yfjgcFTb6vxbrP75A6upsSL6Ga0OWK3tS/tZkpou65s5IsQ9qXmF/LHgn822CZMdZ2vI1s8u46xC+crsVnhKQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8b725e-8b04-4d37-7045-08debd08c293
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 22:30:45.4833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0qM1C57ikVqSq8FTf7vfhNmGGTrGhttOqESNh1epdIJNHZINAdwTEIZYrshT4iWhBWbywjbxkAxnPRlsUXZrGnLWvJD3LM231EdT8sg0lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDExOjQxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gK3Zv
aWQgKnRkeF9xdW90ZV9nZW5lcmF0ZShzdHJ1Y3QgdGR4X3RkICp0ZCwgdm9pZCAqaW5fZGF0YSwg
dTMyIGluX2RhdGFfbGVuLA0KPiArCQkJIHUzMiAqcXVvdGVfbGVuKQ0KPiArew0KPiArCXZvaWQg
KnF1b3RlX2R1cCA9IE5VTEw7DQo+ICsJdTY0IHIsIG91dF9sZW47DQo+ICsNCj4gKwlpZiAoIXRk
eF9xdW90ZV9lbmFibGVkKCkpDQo+ICsJCXJldHVybiBOVUxMOw0KPiArDQo+ICsJLyogVERILlFV
T1RFLkdFVCBleHBlY3RzIHRoZSBpbnB1dCBkYXRhIHRvIGZpdCBpbiBhIHBhZ2UgKi8NCj4gKwlp
ZiAoaW5fZGF0YV9sZW4gPiBQQUdFX1NJWkUpDQo+ICsJCXJldHVybiBOVUxMOw0KDQpEbyB3ZSBy
ZWFsbHkgbmVlZCB0aGlzIGNoZWNrPyBXZSBjYW4ndCB0cnVzdCB0aGUgY2FsbGVyIHRvIHBhc3Mg
dGhlIHJpZ2h0IHNpemU/DQoNCj4gKw0KPiArCW11dGV4X2xvY2soJnRkeF9xdW90ZV9sb2NrKTsN
Cj4gKw0KPiArCS8qDQo+ICsJICogVXNlIHRoZSBmaXJzdCBwYWdlIG9mIHRoZSBxdW90ZSBidWZm
ZXIgZm9yIGlucHV0IGRhdGEuIFRoZSBidWZmZXINCj4gKwkgKiBtdXN0IGJlIGF0IGxlYXN0IG9u
ZSBwYWdlIGluIHNpemUuIEBpbl9kYXRhIG1heSBub3QgYmUgcGFnZS1hbGlnbmVkLA0KPiArCSAq
IGJ1dCBUREguUVVPVEUuR0VUIGV4cGVjdHMgcGFnZS1hbGlnbmVkIGFkZHJlc3Nlcy4NCj4gKwkg
Ki8NCj4gKwltZW1jcHkocXVvdGVfZGF0YS5idWYsIGluX2RhdGEsIChzaXplX3QpaW5fZGF0YV9s
ZW4pOw0KPiArDQo+ICsJciA9IHRkeF9xdW90ZV9nZXQodGQsIHF1b3RlX2RhdGEuaHBhX2xpc3Rb
MF0sICh1NjQpaW5fZGF0YV9sZW4sDQo+ICsJCQnCoCBxdW90ZV9kYXRhLmhwYV9saXN0X3BhLCBx
dW90ZV9kYXRhLmJ1Zl9sZW4sICZvdXRfbGVuKTsNCj4gKwlpZiAociB8fCAhb3V0X2xlbiB8fCBv
dXRfbGVuID4gcXVvdGVfZGF0YS5idWZfbGVuKQ0KDQoNCkhvdyBkbyB0aGVzZSB2YXJpb3VzIGVy
cm9yIGNvbmRpdGlvbnMgaGFwcGVuPw0KDQo+ICsJCWdvdG8gb3V0Ow0KPiArDQo+ICsJLyoNCj4g
KwkgKiBUaGUgcXVvdGUgYnVmZmVyIGlzIGEgc2hhcmVkIHJlc291cmNlLCBzbyB1c2UgaXQgb25s
eSBmb3IgdGhlDQo+ICsJICogU0VBTUNBTEwgYW5kIGNvcHkgdGhlIGRhdGEgb3V0IGFzIHNvb24g
YXMgcG9zc2libGUuDQo+ICsJICovDQo+ICsJcXVvdGVfZHVwID0ga3ZtZW1kdXAocXVvdGVfZGF0
YS5idWYsIG91dF9sZW4sIEdGUF9LRVJORUwpOw0KDQpTbyBhdCBpbml0IHRpbWUgd2UgYWxsb2Nh
dGUgYSB2bWFsbG9jIGZvciB0aGUgcXVvdGUgYW5kIHByZS1wb3B1bGF0ZSB0aGUNCmhwYV9saXN0
LiBUaGVuIHdlIHVzZSBpdCBldmVyeSB0aW1lIGFuZCBjb3B5IHRoZSBjb250ZW50cyB0byBhIG5l
dyB2bWFsbG9jLg0KV291bGQgaXQgcmVhbGx5IGJlIHRoYXQgaGFyZCB0byBrZWVwIHRoZSBocGEg
bGlzdCBhbGxvY2F0aW9uIGFyb3VuZCwgZG8gYQ0Kdm1hbGxvYyBoZXJlIGFuZCB1cGRhdGUgdGhl
IHBmbiBsaXN0LiBUaGVuIGRvIGdldCBxdW90ZSBvbiB0aGF0IGFuZCBwYXNzIGJhY2sNCnRoZSB2
bWFsbG9jIHdlIGp1c3QgYWxsb2NhdGVkPyBKdXN0IGZlZWxzIGxpa2UgZ2xvYmFsIHJldXNlIHdh
eSBoYXMgZXh0cmEgcGllY2VzDQppbiBpdC4gQ29tcGFyZWQgdG8gdGhlIHdob2xlIHF1b3Rpbmcg
b3BlcmF0aW9uLCB0aGlzIHZtYWxsb2NfdG9fcGZuKCkgbG9vcCBpcw0KcHJvYmFibHkgbm90IHZl
cnkgZXhwZW5zaXZlLg0KDQo+ICsNCj4gK291dDoNCj4gKwltdXRleF91bmxvY2soJnRkeF9xdW90
ZV9sb2NrKTsNCj4gKw0KPiArCSpxdW90ZV9sZW4gPSAodTMyKW91dF9sZW47DQo+ICsNCj4gKwly
ZXR1cm4gcXVvdGVfZHVwOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9GT1JfS1ZNKHRkeF9xdW90
ZV9nZW5lcmF0ZSk7DQo+ICsNCg0K
