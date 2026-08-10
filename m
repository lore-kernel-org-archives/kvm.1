Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D116A42C4FB;
	Mon, 10 Aug 2026 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386755; cv=fail; b=nFIsw63LgaGrMBDAAWYJpYbn9R0pqkwdgrRaBRrDCPe2MOK4wbFZA6Ug/KEm+Q1FanUEBPHzCq5XSLyQiaJ4ZLOqtrT+2MfyvISFbIANr2oLdHUnuybtr6E+71sl9DKTYXIp/mqjOgedEis1CEhM8zvGPbTEUw1A+VE9PlRq4yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386755; c=relaxed/simple;
	bh=Narup+StCV15DCWm7WEi5hkiFNqfk3/P5uavIVcaIms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s+HrdQTIvtKsYSQjGs/dEP2yJuiTW5XxFIg4tUv2FQYxGiHZoP/c5/pZYHh8X21wGDDjuhpkl0oTp9/WleWhruuHnMLF4Knhj5SHRmSSTuI/wCVIcOEg+LA1aRtoJf4GZXwdPk+Iw0tVlYmRACDl1EoZoz6lpJipFj/O/63iAVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUmEHhMx; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUmEHhMx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786386754; x=1817922754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Narup+StCV15DCWm7WEi5hkiFNqfk3/P5uavIVcaIms=;
  b=gUmEHhMxlz26Q5/4ZB1fmc8kl8QZSYLNTcCn2Pkn8qKNQVo+XNlkOi5m
   iSh35bg7auP5NJt0Ujr6JUyIkG1wypapEGY5ybpc24xxNaxlkBKRc2xAO
   jr2AFn87w8+Ld3JEnD1+0pYZrsurtHfCtmMuXPLcdGxTr3DuJHvweDLGw
   qV4uJAr6I+yncgLbgmAzKnxZkMCtFAKWHnvfpXST8nmpYYaUbDlFq+EuH
   sRtCvhhQ/X9SIkNxs2o713Brt1nge+kDgqFbgDE7m++qMBYNJ9+OWqxF2
   tbOPuaO1yO7mML2BVPVyjOEIcWSd8DRQUmCKt8CBXDajzmkjAwYL6DiFP
   A==;
X-CSE-ConnectionGUID: sTMBz1F6QiGYBEik3750IA==
X-CSE-MsgGUID: ZNzLZFStSCOjNVFMRlyWgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86670793"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="86670793"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:32:34 -0700
X-CSE-ConnectionGUID: /BX4S1ohQbCnALaalhC3zw==
X-CSE-MsgGUID: edRjeSjaS5+YMtzbrW1akw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:32:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 11:32:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 11:32:32 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 11:32:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlLvXXrWDnu/YBuFM5fn76OZ2zPyXdJbunCLwmn3XzCZs/d2ultvGOiEfn/OzVUzuSf3xv5CdKjel0miRoRa7DSTxPSYMChi9XDX+Uz07zl8DDFdj9KiuytbQdVsAhld6KMoy+xKFLdnzvFbt0fuB/2lutXBiWMtcIpvt67POglFqYkDRfLDOKhzfv38iw/u3fk1BmbXPnCvvGJUn/IHaPzK7nZtYHlpEneG71Dg8MW6CnMnPArOP3ZcBe62CmuO52naylTHuwb4oHuaEuUU6yTxGlV/mmkSySySMqNmCBYOkRycG53rdNDOYOERMbVL+AJYBNQlUnl162XgnoC/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Narup+StCV15DCWm7WEi5hkiFNqfk3/P5uavIVcaIms=;
 b=hQslHaCCBSTNlL902nyHQ+r0qB6B0KvYFIABhIPZrlOsvcR9IgdDkWvTs62YdGS9iKsjMlkmgUATYbSxZEqrj+0xsg/S73mCn3+DKxxkgVDWj8Q8BUuwBZ7uwbfC2dGu48kM16tTt2ayBgNK/YkrXiVWnGfeLvSORvQlNEVLSUCMYVtbT/2H2yW/1gCyZeoDE0KGBzkiG6aAhWSnZgs79s3/bieIHqFWm01QwTTQKV2xiW8mSCBW12dzRqfWYyi76/rDpQAjkIT3NPlvkaKpi3M7piR7nQxgDudupVX6PgyNLMctqv8R18aQ3hSH6fOPpi0LhgwpWt2D6XfyySPQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB6759.namprd11.prod.outlook.com (2603:10b6:806:25e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 18:32:29 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 18:32:29 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v1 3/8] x86/virt/tdx: Add a table-driven TDX global
 metadata reader
Thread-Topic: [PATCH v1 3/8] x86/virt/tdx: Add a table-driven TDX global
 metadata reader
Thread-Index: AQHdJATIbfmORPI/QESK194kuaOqBraPvg8AgAchAQCAAMcIAA==
Date: Mon, 10 Aug 2026 18:32:29 +0000
Message-ID: <3f6edef7874cd7a1fbc5d4e22048000f56acca06.camel@intel.com>
References: <20260804112941.19894-1-chao.gao@intel.com>
	 <20260804112941.19894-4-chao.gao@intel.com>
	 <5e0cfa980d9fe53545362acb81e44e8a653301f7.camel@intel.com>
	 <anlzEJrnulnUtMaG@intel.com>
In-Reply-To: <anlzEJrnulnUtMaG@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB6759:EE_
x-ms-office365-filtering-correlation-id: afc8ac51-137a-4700-52a2-08def70dbc36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: gdtT9WlztLykiILMdm5VZEgxgvumUee/8VCP9xNn0FdZ9USNVy1kYLlinXkx0LqA5YJm+JOxuzlodYpjqmc7534b7PR5UqnApZJ+LMK6Rk5vuOvYPJc+nzUH8pzAfkZNQg0mDdAtQnersF0UCsHZZ3dLO5FNrl57gSw5i1bLJe7AvbMFIseSWSJY5N5aBhALYA2rYB9NfxWuCrjjQ1dymY2Gr1xsSG/9h0Gg/JpPSBNpfZMfqZHCe8QH6kuviFQR3RK4oAQKlBTGjZK4yTdlX7gbhRXnmGuy+bXn5c+PG1wxVosOGTR6pQ+LhcQwPdOHztKS6Sb57CQz4Kyaa3xKYLYZqxjUF5QHKxvBg2ntEHq5a+Q6roCPJ+OV1BQjTFrRZ5W6dUuiZqz6wng4RCgeY46SuBUJnyXsLgdBbSUWTe7RVB47oslXsC6FTtgUboihO3WMUoW72OxFW4gZzaU9s/J2nPpQqw3HFDTtkjCuwAjCM1SgnOtrVh9bOmMDlZdbLGEvZ6l6pEZReQZCJkYlkG4d1P57czwQRGpapeuad3ajpm/QOPprDAWyXhTKm+iTb22zm82eieGGvmZOM4kgv4O8pPE0Lfs6+cxAFeuyulhXKIp+wfzkE26nvHO9iu2az2iWWCBVFEEE8fOS4CEZFlZXqE5bXybGAwJJMNUfMvF2d4xnYG/9McF5F+qrdgzwYYTo0Xp7OiUKBQA7llouJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUthYnI1Uzk3WFVVaWVRaFlzSlJIQzZWQ1N1VmNvM2hvK2JVaXI5VFhUUEIz?=
 =?utf-8?B?VVhYdlA1VCt3bUJiWFRoTjBjYzBURDAycFNDOXJaN3ZaemxmRXNpR3M0SE8z?=
 =?utf-8?B?eUtDY0RQSy81U0I3MzZKQ2JHZFdrTWZPK2k3QVRjSzNZNC9MNTlwRkxPWU5B?=
 =?utf-8?B?Zm9EaDY1RkVJSTNqZnZ1U2JCcVNZQkhIWmdkYmZnYWZqV1pZMG9yTTNrYitS?=
 =?utf-8?B?OFVGbG5HenoyZnNrcmhyTFN1Q2J4VFVMS3k2by9KcEUvYWtpVXRQMVZyemJQ?=
 =?utf-8?B?dXU0UjdSTlJuMEl2MFk4bkhvbmVJVDJLc1ZLRUx3MFZjaFBJb3VQb3ZYYXdn?=
 =?utf-8?B?eHJicEtYRmVBclFoZmdvQUd2S1ZhSE42bHpsbWUvd2l5OEFvMUNDT3VTRHZz?=
 =?utf-8?B?Z1VKNk93eDV2NnZMZStKbmtvd3R5WWF4UWxFK0R0U3I5N1NiVlF5ZlNDVnlw?=
 =?utf-8?B?NmVpeDBTK2lxb1NxTDlTa2pTeDY2Ky9hZEhvTC9mRmtHZUdsTUlPV1o1RHlC?=
 =?utf-8?B?V0c3RlB0a3h3MWlnUW5DdDNZc3RFSUdKZlpyVFJWSkYvQStpcmNCNTlxTEQ1?=
 =?utf-8?B?d0x4cDZibk5kc2hFbFNTS2RJNnpvVUR2Vjh6UXkwcllzeHdHc3NjL29XN0NY?=
 =?utf-8?B?WVk1dUdCNnA5WEhXUEg5MGFxR1hEdzF0TGpPcHRmamNPR2NySWtNQTlodTBh?=
 =?utf-8?B?QnB4eDRHTWxYR1BrUFM5Q0NZT0lZaTVBNThnK1ZSMEY3NTR2c2FTOS9CVDhH?=
 =?utf-8?B?QUo5SmpDeTI4VTBxeVJJbXMyZ0s1aWF1S2xjTDZUSHMxSTNGdGdNbi91dVpH?=
 =?utf-8?B?YTRPZlh0VmlNOFFKdTd6Y2YvOU85dnZEUnY1K0pHTGliSDRBZDVYTVpEYXQ2?=
 =?utf-8?B?S0FPRzZmOURSUkpiMnhrbVVnS1ZUU1pwa3hJNkRmQnVSa0pHQ28yV1lkeWM2?=
 =?utf-8?B?S2R6cGR3WXZLK2pFUEQ2VEtkRHJLREhzMy9uMTBCRFBJSTdYWEVqdHdkbkVK?=
 =?utf-8?B?NXg1UTVidng0UWI1dGxDTjdMc1VpVk5TUjhsM2lzcVpicFRWcGs2T2FmMWVh?=
 =?utf-8?B?UUJiaG9WM1ViOU1jR2ZGc3J1TVFyWFoxdlloTHFEOU5iV1pJYWlTS0VVczE2?=
 =?utf-8?B?SnhVZTc1M09ZTElxMGYwakdyTVZYK05uTkpmS1U4SWNzaUx1K0VBSUEraWw0?=
 =?utf-8?B?NE1hWUp2cENrRXZCeEJFSTI3MGl2RUxlVWFTbHl4TE1YUEFKYWM4L2lRZ2J6?=
 =?utf-8?B?cDVGdUNlSkdVNFNZZmRXSlNYZld5MndtNG5qVkRuWEEvS1ZNL1RuYjdON01a?=
 =?utf-8?B?Yytqd1BiNGJjMmZOUU1KdzMrTTlldWhNQUg2YmVPZVgrZjRsVHJXVkk3a3RW?=
 =?utf-8?B?WGNqNlh3dkovMHF3L080ZGdGTCtyRW5yQmhobnFzQytVWGdVNTgwRndmTEQ4?=
 =?utf-8?B?eERkN0NPZjR3djFNNURmL2NidXRwcDhlaXVTdTBuVUF0L3RhWDZpS281cFBk?=
 =?utf-8?B?MEpFRkdvMXViYzBOb05QTTVZS1k3ZFpNQkVwZENBTWZOYjZXeWdoQitLUm5O?=
 =?utf-8?B?eGFCc3VjRXQ1RmUwVGVkb0I0ZnN2SWJCQ1pXdThtdlV6T3YwTjZpaTVtQmZE?=
 =?utf-8?B?UFdaODBrZDJuZVFJdnR2c1JsZVZmQlNJT3piMVBhenVCRDdiMkUwTk1QK29q?=
 =?utf-8?B?NHRmZ1BMOVJaVXIwbHBuUFdKQ1B0OGpFcmFFdGswWU1BbTgxOFpQWmtnMWky?=
 =?utf-8?B?K0tacmR3bkVMeTJsR2NDOUVjNVc4a2RIek83MUxCaHBRRmlhTDJheDN3S0Zv?=
 =?utf-8?B?UkFndWZ1bGFNalNrWG1pMEhyOFgzVzJ5RG9KRmdZTTc1VEZRaGRIZzQyLzE1?=
 =?utf-8?B?cG9WYk9WbitKUXBKcVRWZ1Q5MThnNDcxN3hFeFJLSElNaTRWQ3lPank4RHBO?=
 =?utf-8?B?Wm5BaGVLV3V1ZkhRREpJK0pvVmUrWlYxempMWWxZUW9keVhLdEZOQzc2SDFG?=
 =?utf-8?B?TjB4YkpRVkJCWk01RmhpODUydkNzMGZyRWExd0NwM3VFcFFLRkFKVzFhMDFD?=
 =?utf-8?B?S1hXRjZyKzJkU0V3d2R1UHltT3l0RStSRStZM0FJMVJFQnZnSDM3R0ZmYWhw?=
 =?utf-8?B?aHV4Q1ZLNlgzQ29oaThSTW5iazZiOG9rNDV6M0RLKzF3bHNIdmtuMzZIYnJ4?=
 =?utf-8?B?eDB4ekRIMkNibkFYb1g5YjV1aEhnK2NZOCtwN2ZaMWUxamQ1OGhhdTNoRmti?=
 =?utf-8?B?a0x4WTBPS013cnVFS0VTV3BGMnBtY0tmWVUvQmV2eTlzbWFRNWhYUWNzQW04?=
 =?utf-8?B?RWFmSEVTK09wUkZ0UHNaTldLMytRcnR6Y25qNURLVWwzTDQwbW9pT1QvbWFj?=
 =?utf-8?Q?PY2mnbUHZpTCFZzU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C0887CAEA9F4446AB5B8AD621D45065@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: keBv6Cqn6EjY5LTw3tjhIzoqd2c5912aD62yuvTqdTquwbtRPx/I08qwTL+L01HfYid5+OlilUdylXK0eQIoKmYA/onP4LcKV6dEtpaayw2xR0pQlA8J1buHSAh+grw4I8mEWKOYXHheoshNy4o+NZfWBxD6jpMalV/GEk6f/NfnvI5oOj6U1d8Bp4f/htrBwhanRS/kUdmXe3wQFOqTAlyQByKfATbqVO/DClfzhJkdVSBwUvaYGiHrJ7Y12eCYHNwWr5pfI3Kg2zfw3bfylopOcbcNC51TRolQ2tMObh+H/FAQFrfNikkYa86umV8rT2oH2aCHAX2YQzwMTGoVUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc8ac51-137a-4700-52a2-08def70dbc36
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 18:32:29.7286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vl5WCB21GoFfhcwGcZsgWypQ0Vyt4yYPB3rIkz/aU2+sYtYhXsSMRdiWoYqXs2hhbDIedXdaSYjeIzaUcksOkvcTiiO94Me0myQmn92neSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6759
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA4LTEwIGF0IDE0OjQzICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiBX
ZSBhcmUgc3VwcG9zZWQgdG8gYmUgYWJsZSB0byBleHRyYWN0IHRoZSBzaXplIGZyb20gdGhlIGZp
ZWxkIGlkIHRvby4gV2UNCj4gPiBjb3VsZA0KPiA+IGxlYXZlIHRoZSBiaXRzIG91dCBvZiB0aGUg
ZmllbGQgaWQgYW5kIGhhdmUgaXQgY29uc3RydWN0ZWQgb24gdGhlIGZseSwgb3Igd2UNCj4gPiBj
b3VsZCBkbyBhIHN0YXRpYyBhc3NlcnQgYmFzZWQgb24gdGhlIHNpemUgbWF0Y2hpbmcgYmV0d2Vl
biBmaWVsZCBpZCBzaXplDQo+ID4gYW5kDQo+ID4gc3RydWN0IHNpemUuIEl0IGRlcGVuZHMgb24g
aG93IHdlIHdhbnQgdG8gaGF2ZSB0aGUgZmllbGQgaWRzIGRlZmluZXMgSQ0KPiA+IGd1ZXNzLg0K
PiANCj4gUGF0Y2ggOCBkb2VzIGV4YWN0bHkgdGhhdCAtLSBpdCBwdWxscyB0aGUgZWxlbWVudCBz
aXplIGZyb20gYml0cyAzMzozMg0KPiBvZiB0aGUgZmllbGQgSUQgYW5kIHN0YXRpYy1hc3NlcnRz
IGl0IGFnYWluc3Qgc2l6ZW9mIHRoZSBkZXN0aW5hdGlvbg0KPiBDIG1lbWJlci4NCg0KRG9oISBZ
ZWEgbG9va3MgZ29vZC4gU28gdGhlbiBpZiB3ZSBrZWVwaW5nIHRoZSBmdWxsIGZpZWxkIGNvZGUg
aW4gdGhlIGRlZmluZSBpdA0KaXMgZWFzaWVyIHRvIGNyb3NzIHJlZmVyZW5jZSAobWFrZXMgc2Vu
c2UpLCBpdCBzZWVtcyBjb25zaXN0ZW50Lg0K
