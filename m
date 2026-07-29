Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E00488761;
	Wed, 29 Jul 2026 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332063; cv=fail; b=TLv8ARhEwg/ZqPI9E7jJOfreh0FOKhBboiFWwwYyuzAvpVS1vzLf912TWLkkZVoeveKX6MvxiSeEMY1oD5nDiM95GEJT0zZtXONCoiDcn9TdBq8lUpDHyCkKZP37afSUxjrA47vEy2UpS3r2rSOZljzcmj7qhXei8yKkwpDRZlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332063; c=relaxed/simple;
	bh=+Uu0fROrEKonq2B9/qUKZ5p2fbNKeiCYtNFp0MSmWqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l/3OPC+tSsolb+0/mSpSp+PfkMteG0u/mJr6m/oqmP44Pbb+rpGqUFYMjPkV0GSNShHwkHky0WFslChIbSx5EQ2+BLejrqTlhBwwJUxfrPrOkZnc+vLkxJqF0ixlJ+Avfye0pbo/W1Rui3Fon/Y2JAtYThiQW4gAwKZPwcrrH4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UN3TRrBe; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UN3TRrBe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785332055; x=1816868055;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+Uu0fROrEKonq2B9/qUKZ5p2fbNKeiCYtNFp0MSmWqg=;
  b=UN3TRrBe5PAxquCunqSnSthVYWC0ifaxQ5UL93kWWaAl+MYVCU7Q7WL3
   VIQ+WAwu+Dwz4NXXas8fYtInEoggHA+Zp6EY56nLz4NDJGUptdqRu0x9R
   sWMu9R4jspIPIfxuqeO/UqgL+D7kKjaqlOPFFtf3Vl6lnfdt+YFr824kt
   taTQxOreptDnExXJ32NIXK4ivjxDGvZXMEQmUhn9FY/7LqbxXyT/LthDL
   x47b8ylho0rA5698m3Yik8C1/9wl+ZYDN/j4PP0iPulnBJbkfGzyNVG0K
   uTe0t2tLWyrs2sUuUCjuZf223mr6JetSLQlYlVUTKFQhmj2uqwr9ZNKZa
   A==;
X-CSE-ConnectionGUID: WnMCHy7vSpiyYABQfOWi+Q==
X-CSE-MsgGUID: 4i1rs6KKTYaPDcKM1Um+4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="108731785"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="108731785"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 06:34:11 -0700
X-CSE-ConnectionGUID: GxlXCJnoRHe5yXVabK77Cw==
X-CSE-MsgGUID: JdO6GVm9QuGSRWUVfnHRKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="256678076"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 06:34:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 06:34:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 06:34:11 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 06:34:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eh2A7EJbtk/jVYfaYN3m8lQgDIIVKBX60CM2OLoks9HXHxqB11JNQKPgIDsrZNXIGCdyf0WJmO5u65gHm45OWyqXNxDYWqRuSmNi8blfK3Ayjun4RF2mDwVVmMT88lbDFbhBR9Ywc8H4xwJvmWkZm0h05NGW0LRf3LSN6m8YO4EEuYTGTL8t7Lq0mF0jLfkAeDk8nD296iafm/aCgChfubndc8YzUG0VGVgKf2+egfugR8w2akujBDriIREMorFThjn489TZmHd4+NPkG+c5yO/47mPM4PE3guKn/SaamAEA5l/SADspt6KXFrpbPG9v0fc9S9MOFRj/PwRCZlh+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Uu0fROrEKonq2B9/qUKZ5p2fbNKeiCYtNFp0MSmWqg=;
 b=MulpmPzv/Sogjn0Nmrii5TGJ8nR7bJP0UQLinppK6LuePeKeR0AQg0A+OHG+8yX2kPKM6D69nSMmWU7Cx6eyz05sseloI+Wf1qSWVsg+NuuYREgp27R+CugDSOH9piazP2zwV7ICQHl8cAJJUGbf8Zcjrlm1Re/ZzKTp2N8QVhq8+bIEgIGQU2NDTXZZvduSLXHHgrJ4I7XNApxs7vpyil9E4BnIsPjuQxdkAfghy39wdp74byAuHIecmqzDxMGd9Ic8XlTqmhvm1lJmUCDryjKaSZQcNzj14mURSftPZJEWnWXF/xN4FP/9dCnbdSsof9eeo7GMV9Bfy940jp5G+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SN7PR11MB6995.namprd11.prod.outlook.com (2603:10b6:806:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 13:34:03 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 13:34:03 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "jirislaby@kernel.org" <jirislaby@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"kas@kernel.org" <kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "hpa@zytor.com"
	<hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2] KVM: x86/tdx: Do not print error message on
 non-present feature
Thread-Topic: [PATCH v2] KVM: x86/tdx: Do not print error message on
 non-present feature
Thread-Index: AQHdHzij/aUjL2+4/0aOO0moSK3FlraEgE+A
Date: Wed, 29 Jul 2026 13:34:03 +0000
Message-ID: <dd7ddd6485b9501eaeb83b27441d0c187a6fd267.camel@intel.com>
References: <20260729085908.21368-1-jirislaby@kernel.org>
In-Reply-To: <20260729085908.21368-1-jirislaby@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SN7PR11MB6995:EE_
x-ms-office365-filtering-correlation-id: 5fa72ecb-cbc6-4733-33c3-08deed760e43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|6133799003|56012099006|11063799006|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: 3LN5co9nOqNnQdJaQAhmoQ5/L8AI9HVOhHe2FgQGYxcogS6cuTFXNOLSiLuxDq/uFDPMrVNZFSY6U2JSWRfZTCItDoTB5FYiUhS3nTnWlioQqThqP/zRFu6GRVsyHclD3wTVZPyp2ugQGLjuVy/ITMfZuRfmHK3HbBpWEQ5Uq8IbBDMyq36uDPqV8dqjZnBT4cEFC6FuJ5zAcsef2wlQX0n3DdZLZwRbpZyjjc6IK+QYZzt7K7jYeU7YLpjqowzUpNNg6c2KVmpAsARWYDY/D3FqjhNAWT+6HPNNB7Hj4Nbmweml9RXGZOK6J82US4FfzXHhYkD6BSSdtyztruJ0JM3MW7kuiVZC2w1jAogN62kQBdX+t2Q7Ixu4pe4nTn6ntLmc7hrGghnEkORyk4KJ6a2InplV5bV1/moCwJYntY4XN4BmZFEz2r1p97c1i8hljWz+xIibuFvndADmer1gP5IepQUtgQoKrJQPiZl3onGHLz1efEjEHgUIQzkyfw3+h2jqdqPr2UnargfThw/vqQ+sicPv7ZQfWo3OizXUNiCRV/exQ995Nj256UPx5d2Cb71Oqhqwu/P9/zGbM0ghbmcWztXEEWiR3qdppaeHPAoJZkcFnvRGX6rxQ3v1xWV6pv0Lso0GXLZDey9Al0JcJO6XK/6gt5291S8wh2JA9JTDZq2W4j1UsGmbxjt1wzfUKLKngkUAw6Syvz/MoImcISUKHd6XoBf/foR4T68hxTE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1BSQTNCMW8vUVJURXVMdFF3OEdoY3I5c3NKbU0wUUUrbE1wL1lvWm9YMXN2?=
 =?utf-8?B?bCtidFZzUGlTUFNKUEtpandjV1E1VnhNdU51YTZtREladjlJTnp3SnpObURW?=
 =?utf-8?B?UllRK2FzL3JvdGdRdGp5NHZ1WFUzeTJlN2hKbGsyZnBrMXhFS256djFPVkhN?=
 =?utf-8?B?d1FyZC80bW40NWk2c0FNMkRHN0hHUG9nNThZd1lNZEoyOG5PbFU0cmVBWUlH?=
 =?utf-8?B?VTEzVTIzS1VXTVFYTHYxcnNDakNqWUVFNHhDWlFYN1dNQ1Jsdi9uK00zSGpy?=
 =?utf-8?B?QXVGZ2ZnbkFVbGdSa0c4RzFqam9pL3BZWGJzU0dxaUhKempkd0dDNUdjM3I0?=
 =?utf-8?B?NmJtV05qRmRJME1Cb2ZZZm9EeisvYzJsZlY3N2tSQzBleTRUTDNPSnBoM1JE?=
 =?utf-8?B?c04zVmFQZy9EMUNleWlKMmpHR1pkNkN6d3E3L1FtN0p6OTdIUnEyUWlUbFZV?=
 =?utf-8?B?WFE1czlrbE1GQi9TTTQ0NGErU1dmUkZWQ0NnYVRXQkFkd2ZYOFlVekNyeUlY?=
 =?utf-8?B?em01Mm9SRHJUVmc4SmNpMUs5cjNZVjBhRVQ2QWo1UzZvRlVyUDhNOS9kRWU3?=
 =?utf-8?B?cFE0WUVlcFJ2OEZ2SmZDWm0raFVrWGZFUHBLcVJhNzlyWVNmVkJ5NG1VQmVw?=
 =?utf-8?B?N1JLSGc4cmt4cVZNYVY3UXpoTHhrYzVRL0tZSEhKRnVIZ01PcENzQVpHaWJi?=
 =?utf-8?B?ZlYyaDVWcndyQTBWZ0R5ZSsxcDE5U3lxcjIyaVdraEdNQXUwdEVwRTV1YWpq?=
 =?utf-8?B?ejFpVHgxemRwSlV4dzhBWFhqMW44bFp2MzJtb0N2ZlNoaE0xa0d1dk5ZVzNn?=
 =?utf-8?B?aVBHS0xqaWtzMzUwQUpQbUtLUC92WU9nY0lSQmZEYUg4MDJjZWZsb09QSDdJ?=
 =?utf-8?B?VHhSVHhRQVpOWXd6SXRuR2JFM1djeWdOYnhiSG1JYlVLK25KR0p6NVZBazZQ?=
 =?utf-8?B?Y055OWZtZkp0aVBJZm5vRlVsVWNxQ2NiR0dPRnp4L00rV0syNUxEbkJXbFRK?=
 =?utf-8?B?YVlnTnptQ0VmbWhjQmM3QTVwV1VWbTdjS1ZTc2JMSjdrbnY4YkNHdTNwMG15?=
 =?utf-8?B?TzZMOTlmaVRRQkJEWVVIR1JTVTFUN2lPM0NrRGNVTk5RYVlFNmhEUjYrL0FX?=
 =?utf-8?B?RkVtSmlMbjVsT2ZjcUpmaytuUExlalFab01nL0pUUUt3cXZQK21VT09Maytw?=
 =?utf-8?B?OEFlandNc053OTViM0x5WEdMZEFIamZhVFprUkYza2tDM3JRalNiRmFSc3J1?=
 =?utf-8?B?QVRXNnAxSUhDYzJEVkIzT3hwbjVQMFlqRDZkTk0zWXRDaS9GK2RSWU5RYU9q?=
 =?utf-8?B?d0RGOHFLR2RGSXV2QzB1SytWcXNGRCt0SGxET2o3QzdCeGxvUzhEZ2VGc0o4?=
 =?utf-8?B?Ty9mMTRnRmZtMTR0MTZYVnJFWVNqcThWUHpyUzR1M2N2WVpVZEt0OXlHOWpB?=
 =?utf-8?B?a1l1Z3k0STd5Z2hISk5MVnp2WFRPcnZLekVtbVQ2Z1dyUWovRUZhV1lrQUVK?=
 =?utf-8?B?TGhsOVI3MitjaWk2OTRqQm5Nc0xSSEVmWGJxOGFoUDlyVHNCK1RSaEhVdTdY?=
 =?utf-8?B?ZHo5VDQ4Lzd3N3ROSlI2YnB6Z3RzY0FtYUtlZ1Q3VmxvY051RW5ESXZhU3Jn?=
 =?utf-8?B?cjllVHBiVk1VR0s3eEI1WlczZ1BsS0gydEVqQTVJRlplMmNKbnZ4SFk0SjlI?=
 =?utf-8?B?aFhjL1Q4Rm56VGdKeERqK3owQXJ0cUY0Rk4rTHBSWUprRzRsODZNdDZ5WmZz?=
 =?utf-8?B?eXRtVWplY2ZKYVAyWVFlL3lUWkpNUFZtWnRmQURhV3Z0V2lXY1VmZTA2VmZi?=
 =?utf-8?B?QVkweWlqaEwwa2llMlordGd4QStrUXRGVlFpeEtsL3lCZC9kSUducUI4T3da?=
 =?utf-8?B?cXlwNFZpZ1ZrOHFObWhxc0p3MDA2eU15SGc4Ym0rM0RNNmFJQXhZcVUxem15?=
 =?utf-8?B?Y1hJSmhDeWNsTWttK0s5WXpNclJvZzB0Q2N3K1FYelJ6N1ZwNE0wM1pzQ0tq?=
 =?utf-8?B?QzgyblpMVVhsUmk0djJSVmU4SGJPUDFUbEtFK0pvaHJSUE96WUw4cmZLZ2w0?=
 =?utf-8?B?enNqLzh1M3h0eWIyVzgrZnpiS2tIYjV2ZEV4YnBmSWpkSzdDcE1qOFhCdjNQ?=
 =?utf-8?B?VDlTamtYd1R1MVE4b09OL2twQldYL1NaSmUyM1crK1IvSXVkR2ptN0UrK1BR?=
 =?utf-8?B?cTRxOXV4cVVWL21vb0pzbG1sK3dGbi9RZytPS3drS2dpN3l2WU1wTUtJTTBl?=
 =?utf-8?B?TWxLdGRDYXNJa2wrc0lsN3ZvM0NJdWg5NXY5RFhIV2o4R2JnZEk1alZzbHls?=
 =?utf-8?B?QmMycEZBZDVic0ErVXpqb3NHdFZocENSYmxKNno5eEZIZlhSWjVjK21tcGx2?=
 =?utf-8?Q?mOKiysKclyyIIafo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94DE628C43A16241B7C82C08E0BC638D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HsOFdO5TfhYchqaFqMx3ouS9xUhWXjyD95BKIN2/wwvw6awkiZd4Dard5hgrnT6eebz4ai4RhkO9sWx4SdB6POsbh8Eze2OHMz05hllkExyL/FCm4H6ahK9gd5Tcy1bxi+Q0hiVqnNBoqEb81RSLV1Crk8WGyp0PAOp3Rms4Vi9KfPjITv9QV2irQ7bPsMl0YTUvC+nXVaUL6FLSmYKeCy0EpxsQ/WHWzpUDf8uhOr3DUWB2O+VjhjQN1DXGpW1M7i7L+iKI5dp7O8udD/hwtv9WeQYLAOfmkalLG36+WhOof68ltU466OhiWBY84lHOOUhM/yRl5P8BEyFoyivmvA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa72ecb-cbc6-4733-33c3-08deed760e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 13:34:03.3879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gHe45NOXi+hYwlcV9WQmp1P7lJEzwv54QYa5nrCsAhGvLM+VMWJCSJRfZ+2qABmRqBlAFnJr6mkBoc4GGA+FLkcX4Jqx9lp3D+/Z8Dnc+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6995
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTI5IGF0IDEwOjU5ICswMjAwLCBKaXJpIFNsYWJ5IChTVVNFKSB3cm90
ZToNCj4gQmVmb3JlIGNvbW1pdCAxNjVlNzczNTM4MzEgYmVsb3csIHRoZSBrZXJuZWwgZGlkIG5v
dCBwcmludCBhbnl0aGluZw0KPiBkdXJpbmcgYm9vdCBpZiBYODZfRkVBVFVSRV9URFhfSE9TVF9Q
TEFURk9STSB3YXMgbm90IHByZXNlbnQsIHVubGVzcyBURFgNCj4gZW5hYmxlbWVudCB3YXMgZXhw
bGljaXRseSByZXF1ZXN0ZWQgdmlhIGEgbW9kdWxlIHBhcmFtZXRlci4NCj4gDQo+IEFmdGVyIHRo
ZSBjb21taXQsIHdoZW4gYXR0ZW1wdGluZyB0byBsb2FkIFREWCBhdXRvbWF0aWNhbGx5LCB0aGlz
IGlzDQo+IGVtaXR0ZWQgdG8gdGhlIGxvZzoNCj4gwqAgdmlydC90ZHg6IFREWCBub3Qgc3VwcG9y
dGVkIGJ5IHRoZSBob3N0IHBsYXRmb3JtDQo+IA0KPiBJdCBpcyBlbWl0dGVkIHdpdGggdGhlICJl
cnJvciIgbGV2ZWwsIGhlbmNlIGl0IGlzIGRpc3R1cmJpbmcuIEl0IGlzIG5vdA0KPiBhbiBlcnJv
ciB0byBydW4gQ1BVcyB3aXRob3V0IHRoZSBmZWF0dXJlLg0KPiANCj4gRHJvcCB0aGlzIHNpbGVu
dC1ib290LWJyZWFraW5nIGVycm9yIG1lc3NhZ2UgZm9yIHRoZSBhdXRvbWF0aWMNCj4gaW5pdGlh
bGl6YXRpb24gcGF0aC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppcmkgU2xhYnkgKFNVU0UpIDxq
aXJpc2xhYnlAa2VybmVsLm9yZz4NCj4gRml4ZXM6IDE2NWU3NzM1MzgzMSAoIktWTTogeDg2L3Rk
eDogRG8gVk1YT04gYW5kIFREWC1Nb2R1bGUgaW5pdGlhbGl6YXRpb24NCj4gZHVyaW5nIHN1YnN5
cyBpbml0IikNCj4gUmV2aWV3ZWQtYnk6IEtpcnlsIFNodXRzZW1hdSAoTWV0YSkgPGthc0BrZXJu
ZWwub3JnPg0KPiBDYzogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+
IENjOiBDaGFvIEdhbyA8Y2hhby5nYW9AaW50ZWwuY29tPg0KPiBDYzogRGF2ZSBIYW5zZW4gPGRh
dmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNl
YW5qY0Bnb29nbGUuY29tPg0KPiANCj4gLS0tDQoNClRoYW5rcyBmb3IgdGhlIGxvZyBjaGFuZ2Vz
Lg0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwu
Y29tPg0K
