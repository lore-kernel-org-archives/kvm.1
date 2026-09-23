Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC1414414;
	Wed, 23 Sep 2026 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203654; cv=fail; b=gKIUEdIxJMdVHn8GPnGeXFN1N9oiPCm6RTuS0eWncY5zo0LoasVjAa4Kvxxz46IICJHX5WrKTOpjf2IYKHgTaO1I0roPdQ0j/RgfGq2rqa4QipjHBz+2yhQ/2JKeEpOhJ6iDLXZ6wvJhHbAmoelEjnNo63XEeoAAHeqqnNjLn+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203654; c=relaxed/simple;
	bh=aFTJku1wISi1z31GCW1Li431DbJlT6juoZCvBIvHHRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pv9aCQ3FzPvNGVln6Yqj+tT70D4L3C0Ry0zKkqKgh1USN8swEDYz7ZHxK07smGAh3WFzMRfcwtuDMZI9D3+cN3tFQjaet6BHnReFDlzNrMgcMhI7HlYMvBY6E5X1GtTTGFaOplXxpdI4VDDDfeBmcnSuKBJFzKPuzUZzVOgGvLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbjriCwk; arc=fail smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbjriCwk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790203652; x=1821739652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aFTJku1wISi1z31GCW1Li431DbJlT6juoZCvBIvHHRk=;
  b=kbjriCwkPJK+FmaY5UCUCL4IaWKQMEKhTPjshPMdQ6e9DCEGiTWcLEOD
   xDuQ+FLyiavoYYfcXzDMV80Czf6OZRTWl/D1dvKusYY5JxeQVUxBtoFBr
   fhAv6yZZipKb2SrlJMyCGsb45CCxjf8X/5rXJEgQwPISilBPxTLTqf0WT
   JZT3GfCgPhZhI8E8bmqNS/92N0XDSx1zgNLfolKG8DRlqP5u66FBTF41t
   YaLQ6qKRmDxVmF8QaOyU9tOM41PkR5jWdkf8Wy1EGXfNZdna8gRs42D5u
   WRUhchYhrRv9dS18sFJLoMH3uKxaWtRrZPvB0L89MtZeKlX0Lt/NTIgcI
   w==;
X-CSE-ConnectionGUID: GshwMqDESf65pU9gvQSD3w==
X-CSE-MsgGUID: cMYHlRoaTT+l85n66VGrcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="1452363"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="1452363"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 15:47:31 -0700
X-CSE-ConnectionGUID: D+rw+VWaTlObD3Za+EXwog==
X-CSE-MsgGUID: 0y3sRoI4TX2UCk3A/eKIBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="273007435"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 15:47:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 15:47:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 15:47:30 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 15:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UckK/VP57njnBKZjKXy9vcFZ+Hsr1Tz47bK3hw26OULmJmY7WQ1/NBErp/+VHnRvwL8ALfs8S3cZDku1dzU1oS5dSdbQVoKsaBXg1oxGitCq4m/0+KrRVpBiEMmscCHjY4gK5ztaQE45PL7WgLP2xsUFCNnxoRS9ZP1vq1FrlpbpgKIL7ry8sxsx8szFDaB0TpdB8Sz7k/ro3OVDdYXhIDExvQn07EqlNj8FwSUMKZ/hA6H/HgLrZ0PwlRpBgUGuziSW7rUjHoide5/LKGt5UE8qxGIbDnUckGs1ERTBSvLGsXd6Uj1WfgV/QdWTPJ6K4iAvau8n4kytYyKJfMCIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFTJku1wISi1z31GCW1Li431DbJlT6juoZCvBIvHHRk=;
 b=CzGuVSxN4bh6LTg2MXdJsD+H1QZaVtuXtEmTTZtA3O2SkoFno4BYzCoZ+mVcBhESsxJd8OwMX0k1c4bdPopnrw7ErRUoybtWWDnrEXdiLE2FG521xWWyj/G3aJkD2jRIdyHTALTdQDThOoQw/qierOYGztj/146BQqN3Fqal5jY8AQ14blJ7XYmic5abkeVfYPqR6AvqZnG8s5ZZ+3HAOLSi9/5aWxKREcE1y2N3izw1I50qD29LhLwjl8T+Iv2rgeYlSi2GICN1XbrC5f6zARCQcWUHhAlH6hDDFuNyUn2NAOl3bn2Zi5Ih5l2OgtRYgh9vgwhcn404V715742eBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 22:47:20 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 22:47:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v2 10/10] x86/virt/tdx: Verify structure member sizes
 against metadata field IDs
Thread-Topic: [RFC PATCH v2 10/10] x86/virt/tdx: Verify structure member sizes
 against metadata field IDs
Thread-Index: AQHdR3ITvlciXn0uPEaqmaPTteFgurbczBQA
Date: Wed, 23 Sep 2026 22:47:19 +0000
Message-ID: <afe70eaadc0906ec17e6b5522881ae09e9f45579.camel@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
	 <20260918132946.76533-11-chao.gao@intel.com>
In-Reply-To: <20260918132946.76533-11-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|LV8PR11MB8608:EE_
x-ms-office365-filtering-correlation-id: 3d68d37a-1c67-48b4-d9cc-08df19c49fda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|38070700021|4143699003|5023799004|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info: vWc3J8h8V8UbMmEJ/hewyPuzlyG0H6MeIAX3s0UkBQpWmhY4DWSljKTP1G2fXRALMilSdko48Cxtj+hIEcLRxBAkCTTeaGF5/RHXiqyqCFlw99hQpLao+mQgr5hUkKiMk/5o8iNpMMEz15UqaRqmvY0mZcEtQ/g5+NN48h6NgN3oEwtNcG0Gs+DWE4HSigYrhpicuZz/6VNz7M9PF1e9Jbd0M3dooS3imfuVdup/AyBcFwCKBJc94UPxKKlvd4TcS+Jbw93RKBkTrP9Uh9KoorzqwDYOwwYbSqZEtVqjz84+1sOPSoow75QOfV1TR2wAGjATB4CIf6rAMOXGUElxzXR3WmPOPhPM6hdM0OUtojQuKzN/pkNCf9YxQWWZIoHF8kfelPv82kZM1TGH0bsTa8bNF9XmMOQqhCmdZEzXdEXR4jyyozRPaLIyCCqXy6iQcTiUsQU0VlXilI+X/ejdCndJEokbc2aQ1NPE7E+ytX6JG2kW1ycb3TAnhrijskJZzpaGbKYuUC9ric6WtTe+I9t/yFvQFzpS6gichniSGFc3rz20T69YBklgTEX1cfvApz80/A/3ZiH1mgFmqqN8p9vj0pZuAjWQ7pLlyI/vsmsM+sS5u/w+ONPvZWZRbFJNN6h6JYVmag726w5r+OT5A4WmLky3SSXKQ+/Pf4SWWsYs+L5g+7xEcYzRIeNXDF20xLg1LY42kYTbOlwnwM90TBBibjnwRP6iIqEEH1mHxBk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(38070700021)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NENzb0NOS1pPUWM3TWZaczczRlB0UWlvS0E5Z2NvTHpTT3U1bnI0MjJhVFVQ?=
 =?utf-8?B?ZG5nenlxaisrVXBPTkZaTjNiTElKTHB2Nlgyc01xY01GUDRmSlZ0S3I0NFVz?=
 =?utf-8?B?UnVGOXJnK3lvRGJka3FoMUZjaVYxd2kzcjU4c2E0MzBUeXhBZmpNRklDUTFF?=
 =?utf-8?B?MGMzSjd2OTdyS29wL0FkYUlrem05bkN1THVJNUIza3dMUmhpOURyY2YzTldm?=
 =?utf-8?B?Y1orYXhQOFpSaDZPaXpwaUJBNkhzb0hzNW1nUy9pUXpqb0FPQ05ZQXdRb1J6?=
 =?utf-8?B?MnpycDhZcGw2aWVBQ3BueW1pUkVxbzBlT3JKc0tPTVdORTVZbHViMUI2SStt?=
 =?utf-8?B?cmxwcDVEeUZONEZKU0ZacFNKNXdzSzYvblAwZy9VQ1dHekM1V25QMWlvUG9R?=
 =?utf-8?B?S1B3N2pzZEswMzdjNGxhS2k4Wi9GTkVIV1hlTnM5ZGxVVjEzNmtYcHl1SmRZ?=
 =?utf-8?B?TEEvdUw4enZpS1gzY1JtU1ZLU1lNR1NJZE90TzQ3ck9rMG5iQURkNjN5VHpi?=
 =?utf-8?B?NXJvUUlkd213K1dnOVhINHMrQWVSa3gwZGxKVjdpYnZ5RUxteFNDSXlHb1oy?=
 =?utf-8?B?VXZIa2tucXVNQUpNSzJaeVhWQXlSeFhZMG1malExbWlSRFhFcnhnYjRpQm1a?=
 =?utf-8?B?R1dpUUw2QnRTN25Wb2VyTlVxWXJ5czBQK2V0Vm9FcFFrYVV3RzFWaDlJNGg0?=
 =?utf-8?B?dStMNTQrN3FIeTR6N0lIZXhwL3ZqaFp0QW90TVEvNHdFbkxBMEVhWFpETXMv?=
 =?utf-8?B?bnFVNWlwY2x4ZW9VaWVkZ1kzVzQwOENwV0tBUWlOdXFqbmxjTTFaN0dhMDlp?=
 =?utf-8?B?Z1FPVnRTM0JBSllNVW00R0dxb200S2hBeWFpcGQzNmR6bklKU0p5SWM2dS80?=
 =?utf-8?B?VE1zd3dMZStvYWNrc1JDbEFRamhIV3NDVGxLa0hiUkxpQTNjL2l5ODRhWStS?=
 =?utf-8?B?ZnRvM0UrdWpBZDRFbzNzTkpHRTRWVEpWUEptSm9OS212bmMyY1p3MzhrbjRp?=
 =?utf-8?B?cmMvUmV1eUlMVmRNOGZKdTNneGE0dXZkdmlQeVYxOWhhc2tRa09GRnZqbkFq?=
 =?utf-8?B?WnlCQktpcXNvUldvNkI1dGZUSUR0YkZsTlc3Z2U0eGhlcVlER25KODlkZUJp?=
 =?utf-8?B?bXpwcVlMaEY4by9MWU5vdUo2bFFtWlQwTVRHb2FzTE44UFJSb2hKMHpJWEI1?=
 =?utf-8?B?Tys4d3lyOVpjbGR0clVZc0gwNjUrZTMrb0xaWEUyVzdEbXVpTTh3VmdlY3Bp?=
 =?utf-8?B?WTA0VFU5Y3Y3Q29IUjlCSmRySmU3KzBjMzB5eW1RMk9WOHdFYlFtU1VBdWcw?=
 =?utf-8?B?c2Vpd1ljdDFucWkxR3M3dFkxMmcycVByaWpYZDFyVGYvN2NqSU9qd1ZqcWJ5?=
 =?utf-8?B?b1RVa3RzL2ViT0FheXJOVldyeDVEQ3FLV2JqTlIrUm9FTldLUWpCQWtod2sw?=
 =?utf-8?B?b1A3ZVMxVFZreGxYNjRwT1ZJZFdIMWt1dmFXQldXSnlTS2dEY1JRUUVtdm4r?=
 =?utf-8?B?cVBVMlg2Q0dHNEU0dHVLT1R4dDZJUk5rVldyMEJQUFFxM0svV1pqd0NVdlZH?=
 =?utf-8?B?Wkl3a0wrUnBubHYvdlFQL1VocEJnTC95enA1NmdDUUxrclBKMUk0cFRXMlI5?=
 =?utf-8?B?Tm00UTA4bjZsU0V3U1dyS0tKWnE1MEdhQ0RzNVk5QXZVeDNpRVZZTGFnZ3N6?=
 =?utf-8?B?d3FvRU90WjZhdVBVQkZrWnpIb1NOelI3RkVMVTJldWNkQUl1MjB3Qm9UaFRV?=
 =?utf-8?B?M1VoWUdBdFZNbXdGNXgybkxLU016d2M3Z1NFam4vbnVxeFl6OER6M1hET0xM?=
 =?utf-8?B?Q1AzblRiY21mTW1DaFBsN2FLNEtad3lFYVBYK25hS0lMTXpMYzUxU1pnU3lF?=
 =?utf-8?B?OU9HTzQwVGh1OHk5UStsendWVHpzNWR3d3IxSkJtUkNFYmM5OHRQZmg0OU41?=
 =?utf-8?B?ZmZtcldpRDkwdmw1THEwd3hTY3h0UVNUN2lwQVg1c3ZoSjhuYjBqMmZkQ3Vq?=
 =?utf-8?B?SG5xUWd2UG1VOFNYRlNaQytEZjF2K3FjREY5ZGlJcXl3TnRDOUJhaXlrSUlY?=
 =?utf-8?B?OUw5bnhFWEVuazkvTEF6UGpoRU9ONlpsODZBS3I0V0lobmxVbTFHL29SY2d0?=
 =?utf-8?B?cDNJTzhxNTA5R2lhMUluZEZMdkZHZGU4eWJVeWV5d1JHbjBldy9YQ0M3RXpM?=
 =?utf-8?B?NnFOSm5xcVJSOEw2UGllSk90aVE4dHhXQjBPaTNncGV2VnRZRGdDN0MxaXYr?=
 =?utf-8?B?VmMybzVwcEQwQ3hDYXRiQXNFZHI5QmVnQWF2YkVGblVxbkpSZ0h3Zll5eWNN?=
 =?utf-8?B?SXE0bkgyK0hQem9LZStaZ2V3RG5WMXdxY1k4WlRQWTY0UXIrNkswbCtkR0V0?=
 =?utf-8?Q?uL2sjPtjmrpvZO3c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCAFC2A7555E3844B554248C29EB2FAC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LHKIOFeuF/eqqM5bhg5YMUMsqTQ6pevc0C2pbX26EhDoWiu1DHhjr9BjddVw8KZIazsMpROwb9OJTVjF/G+nYfeaajIH5VSjy1I35V0szrL6129gINMf4FIxUmSKc2A+j7XzAjSpTFkxld12PzveZHgKQeLUHFeD27X4z1SSCQ5H4nMg1Fg2qZ54aZbL3UqFCrtK2OXlp/1ip9FTxO5PO7mXGPw8bbTg/7Vh3Mj7AmdoffQe11XwcwpnanLyH9KAV7OrmIjGwkUdB1iwIkzAwgtNwXZ+Yheq5XJeBfJjtMBsjn4lORohcMKnYDL0q4tR/tDuyNKFPQCrS/caapFCLw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d68d37a-1c67-48b4-d9cc-08df19c49fda
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 22:47:19.5913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zl4g/KyBTVnpN5J6YVhhhswOKk20GBN0neGr9I8vbKTsYVLg11JYehKVm1GiY1R+fq/xLcXLpvN34G73AwiLR0u276tM+B5Oyzoi+nA3IVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA5LTE4IGF0IDA2OjI5IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gQSBt
ZXRhZGF0YSBmaWVsZCBJRCBlbmNvZGVzIHRoZSBzaXplIG9mIGEgc2luZ2xlIGVsZW1lbnQuIFRE
WF9TWVNJTkZPX01BUCgpDQo+IGluc3RlYWQgZGVyaXZlcyB0aGUgY29weSBzaXplIGZyb20gdGhl
IGRlc3RpbmF0aW9uIG1lbWJlciwgYW5kIG5vdGhpbmcNCj4gdmVyaWZpZXMgdGhhdCB0aGUgdHdv
IHNpemVzIGFncmVlLg0KPiANCj4gQSB3cm9uZ2x5IHR5cGVkIG1lbWJlciBpcyBhIGtlcm5lbCBi
dWc6IGRlY2xhcmluZyBhIHUzMiBmb3IgYW4gOC1ieXRlDQo+IG1ldGFkYXRhIGZpZWxkIHdvdWxk
IHNpbGVudGx5IHN0b3JlIG9ubHkgaXRzIGxvdyA0IGJ5dGVzLg0KPiANCj4gQWRkIG1hY3JvcyB0
byBleHRyYWN0IHRoZSBlbGVtZW50IHNpemUgZW5jb2RlZCBpbiBhIGZpZWxkIElEIGFuZCB2ZXJp
ZnkgaXQNCj4gYWdhaW5zdCB0aGUgZGVzdGluYXRpb24gbWVtYmVyIHNpemUgYXQgYnVpbGQgdGlt
ZS4NCg0KVGhlIHR3byB0aGluZ3Mgd2UgY291bGQgZG8gYXJlIGV4dHJhY3QgdGhlIGZpZWxkIGNv
ZGUgYW5kIGNoZWNrIGl0LCBvciBhZGQgaXQNCmludG8gdGhlIGZpZWxkIGF1dG9tYXRpY2FsbHkg
ZnJvbSB0aGUgc3RydWN0IHNpemUuIEluIHRoZSBsYXRlciBjYXNlIHRoZSBmaWVsZA0KaWQncyB3
b3VsZCBiZSBzcGVjaWZpZWQgd2l0aG91dCB0aGUgc2l6ZSBiaXRzIGFscmVhZHkgZmlsbGVkIGlu
LiBCdXQgc2luY2UgdGhlDQptZXRhZGF0YSBkb2NzIGhhdmUgdGhlIGZpZWxkIGNvZGUgYWxyZWFk
eSBlbWJlZGRlZCB3aGVuIHRoZXkgYXJlIGxpc3RlZCBpbiB0aGUNCmRvY3MsIHRoYXQgaXMgdGhl
IG1vc3QgbmF0dXJhbCBhbmQgZWFzeSB0aGluZyB0byBhZGQgdG8gdGhlIGZpZWxkIGlkIGNvZGUu
IEl0DQptYWtlcyBpdCBlYXN5IHRvIHNlYXJjaCB0aGUgZG9jcyB0b28uIFNvIHRoZSBjaGVja2lu
ZyBkZXNpZ24gZ2l2ZXMgdXMgc29tZSBleHRyYQ0Kc2FmZXR5LCBtYWtlIGl0IGVhc2llciB0byBh
ZGQgdGhlIGNvZGUgYW5kIHNlYXJjaCB0aGUgZG9jcy4NCg0KSSB0aGluayBwcm9iYWJseSB5b3Ug
bmVlZCB0byBleHBsYWluIGEgYml0IG1vcmUgYWJvdXQgd2hhdCBhbmQgd2h5IHRoZSBmaWVsZGlk
DQpzaXplIGJpdHMgZXhpc3QsIGJ1dCBJIGFncmVlIHdpdGggdGhlIGRlc2lnbi4NCg0KPiANCj4g
QlVJTERfQlVHX09OKCkgY2Fubm90IGJlIHVzZWQgaW4gYSBzdHJ1Y3R1cmUgaW5pdGlhbGl6ZXIs
IHNvIHVzZQ0KPiBCVUlMRF9CVUdfT05fWkVSTygpIGFuZCBhZGQgaXRzIHplcm8gcmVzdWx0IHRv
IHRoZSAuc2l6ZSBpbml0aWFsaXplci4gVGhpcw0KPiBwZXJmb3JtcyB0aGUgYnVpbGQtdGltZSBj
aGVjayB3aXRob3V0IGNoYW5naW5nIHRoZSBzdG9yZWQgc2l6ZS4NCg0KTmVhdC4gTWlnaHQgYmUg
Y29udHJvdmVyc2lhbC4gSSBsaWtlIGl0Lg0KDQo+IA0KPiBBSSB3YXMgdXNlZCB1bmRlciBzdXBl
cnZpc2lvbiB0byByZXZpZXcgY29kZSBhbmQgd29ya3Nob3AgbG9ncy4gSXQNCj4gc3VnZ2VzdGVk
IGV4dHJhY3RpbmcgVERYX01EX0ZJRUxEX1NJWkVfQ0hFQ0soKSBpbnN0ZWFkIG9mIG9wZW4gY29k
aW5nIHRoZQ0KPiBjaGVjayBpbiBURFhfU1lTSU5GT19NQVAoKSwgdG8ga2VlcCB0aGUgLnNpemUg
bGluZSBmcm9tIGJlaW5nIHRvbyBsb25nLg0KDQpPaCB5ZWEgdGhhdCBpcyBhbHNvIGEgbG90IG9m
IGJpdCBtYXRoIHRvIGNyYW0gaW4gYSBzdHJ1Y3QgbWVtYmVyIGxpbmUgdG9vLg0KDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBDaGFvIEdhbyA8Y2hhby5nYW9AaW50ZWwuY29tPg0KPiAtLS0NCj4gIGFy
Y2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyB8IDEyICsrKysrKysrKysrLQ0KPiAgYXJjaC94ODYv
dmlydC92bXgvdGR4L3RkeC5oIHwgMTUgKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDI2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMN
Cj4gaW5kZXggOWQ1YTMyOTZkM2MwLi42ZGMzMjg1NjEwMDkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
eDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiArKysgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4
LmMNCj4gQEAgLTQyNCwxMSArNDI0LDIxIEBAIHN0YXRpYyBpbnQgX19yZWFkX3N5c19tZXRhZGF0
YV90YWJsZShjb25zdCBzdHJ1Y3QgZmllbGRfbWFwcGluZyAqbWFwcGluZ3MsDQo+ICAJcmV0dXJu
IDA7DQo+ICB9DQo+ICANCj4gKy8qDQo+ICsgKiBUaGUgc2l6ZSBlbmNvZGVkIGluIHRoZSBmaWVs
ZCBJRCBhbmQgdGhlIHNpemUgb2YgdGhlIGRlc3RpbmF0aW9uIEMNCj4gKyAqIG1lbWJlciBtdXN0
IGFncmVlLg0KPiArICovDQo+ICsjZGVmaW5lIFREWF9NRF9GSUVMRF9TSVpFX0NIRUNLKF9maWVs
ZCwgX3R5cGUsIF9tZW1iZXIpCVwNCj4gKwlCVUlMRF9CVUdfT05fWkVSTyhzaXplb2ZfZmllbGQo
X3R5cGUsIF9tZW1iZXIpICE9CVwNCj4gKwkJCSAgVERYX01EX0ZJRUxEX0VMRV9TSVpFKFREWF9N
RF9GSUVMRF9JRF8jI19maWVsZCkpDQo+ICsNCj4gICNkZWZpbmUgVERYX1NZU0lORk9fTUFQKF9m
aWVsZCwgX3R5cGUsIF9tZW1iZXIpCQkJXA0KPiAgewkJCQkJCQkJXA0KPiAgCS5maWVsZF9pZAk9
IFREWF9NRF9GSUVMRF9JRF8jI19maWVsZCwJCVwNCj4gIAkub2Zmc2V0CQk9IG9mZnNldG9mKF90
eXBlLCBfbWVtYmVyKSwJCVwNCj4gLQkuc2l6ZQkJPSBzaXplb2ZfZmllbGQoX3R5cGUsIF9tZW1i
ZXIpLAkJXA0KPiArCS5zaXplCQk9IHNpemVvZl9maWVsZChfdHlwZSwgX21lbWJlcikgKwlcDQo+
ICsJCQkgIFREWF9NRF9GSUVMRF9TSVpFX0NIRUNLKAkJXA0KPiArCQkJCV9maWVsZCwgX3R5cGUs
IF9tZW1iZXIpLAlcDQo+ICB9DQo+ICANCj4gICNkZWZpbmUgVERYX1NZU0lORk9fTUFQX1ZFUlNJ
T04oX2ZpZWxkX2lkLCBfbWVtYmVyKSBcDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3Zt
eC90ZHgvdGR4LmggYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmgNCj4gaW5kZXggNDA3YWRl
ZDMxMzdhLi4xN2ZkYjY4MjQxMGUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3ZpcnQvdm14L3Rk
eC90ZHguaA0KPiArKysgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmgNCj4gQEAgLTk5LDYg
Kzk5LDIxIEBADQo+ICAvKiBDbGFzcyAiVERYIE1vZHVsZSBIYW5kb2ZmIiAqLw0KPiAgI2RlZmlu
ZSBURFhfTURfRklFTERfSURfTU9EVUxFX0hWCQkJMHg4OTAwMDAwMTAwMDAwMDAwVUxMDQo+ICAN
Cj4gKy8qDQo+ICsgKiBTdWItZmllbGQgZGVmaW5pdGlvbnMgb2YgVERYIGdsb2JhbCBtZXRhZGF0
YSBmaWVsZCBJRHMuDQo+ICsgKg0KPiArICogU2VlICJNZXRhZGF0YSBGaWVsZCBJZGVudGlmaWVy
IiBpbiB0aGUgSW50ZWwgVERYIE1vZHVsZSBBQkkNCj4gKyAqIFNwZWNpZmljYXRpb24uDQo+ICsg
Kg0KPiArICogIC0gQml0IDMzOjMyOiBFTEVNRU5UX1NJWkVfQ09ERSAtLSBsb2cyIG9mIGEgc2lu
Z2xlIG1ldGFkYXRhDQo+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVs
ZW1lbnQncyBzaXplIGluIGJ5dGVzDQo+ICsgKi8NCj4gKyNkZWZpbmUgVERYX01EX0ZJRUxEX0VM
RV9TSVpFX0NPREUoZmllbGRfaWQpCVwNCj4gKwkoKChmaWVsZF9pZCkgJiBHRU5NQVNLX1VMTCgz
MywgMzIpKSA+PiAzMikNCj4gKw0KPiArI2RlZmluZSBURFhfTURfRklFTERfRUxFX1NJWkUoZmll
bGRfaWQpCVwNCj4gKwkoMSA8PCBURFhfTURfRklFTERfRUxFX1NJWkVfQ09ERShmaWVsZF9pZCkp
DQo+ICsNCg0KSSdkIHRoaW5rIHRoZXNlIGNvdWxkIGJlIHNxdWFzaGVkIHRvZ2V0aGVyIHNpbmNl
IG9ubHkgVERYX01EX0ZJRUxEX0VMRV9TSVpFIGdldHMNCnVzZWQgYW55d2hlcmUgZWxzZS4NCg0K
PiAgLyogVERYIHBhZ2UgdHlwZXMgKi8NCj4gICNkZWZpbmUJUFRfTkRBCQkweDANCj4gICNkZWZp
bmUJUFRfUlNWRAkJMHgxDQoNCg==
