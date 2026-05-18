Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94373451D9;
	Mon, 18 May 2026 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147855; cv=fail; b=EKrf87ENt7zvO3i4RrBWBwTOI4zhCErM9Ks8x2mONnwbDI1qKPYymjEB7cD4VfsBGO0NCuy10OkWpHu70lZm3W9td1a+d4E7+qqQuAjqevQUgKxP24U3beZ1sk6QJ5Ha77bJtOlA4OmeLGzsAbcxrlfMCtXCY62N0JnHu9qspC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147855; c=relaxed/simple;
	bh=Q95ODAJfO2AcL55iXk1yALL1fAXeIfzvkAuPem2N0ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k1Y5HTo60dlZNuK7F/lwg0XkE+6zuPAppw9mB2JmLJ7GFHWbC2oaaqmUYr/EF8Gf1lT0SLo+g7b64G07p4hG7KsGPpZxlZUZOpIFHImtyP/gc7zTjQayCfjvKdLbOY1gxC0WrTezXYtkheaxfyWVZzg8qhBbkUGZYoIIgBYgM0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSrY3n1Z; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSrY3n1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779147854; x=1810683854;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q95ODAJfO2AcL55iXk1yALL1fAXeIfzvkAuPem2N0ws=;
  b=DSrY3n1Zr7hnBhvfADicY8M9zR6FW244RbZXO3VyC2Cuf5AbMhlZGRjz
   /y6HUxpX8Slzhtxko+iPHf0CIgEgAF/gcGc71KAFqzPSe6ppH5HtiR7jB
   JQQ0EB+F+KTnJlb7euFH9fGTs8OlmTOQiCPQ3nfmWYthEG5Zux182wymt
   mX6LN9BdScEm6xwwJYPm/EKcUXbxTQnFQybB+6ll6KKFv1l5s/hv9/Emo
   R9pyClFcrNaL+Zo872JR8IvfnQdUp6OF4exnn/J5yBg7XgUJNAusDcbDX
   mCspruRWLkM17cP28wLwgeFEonX44Di7eCPKvsPoXETdOOSf0E6mZ4G9S
   Q==;
X-CSE-ConnectionGUID: gzJy1qa/SX+QS6mrG2v9bQ==
X-CSE-MsgGUID: /dvXuO/fSWuCdY5q4maQrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79157409"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="79157409"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 16:44:13 -0700
X-CSE-ConnectionGUID: e1tgvQL/TcqU9nXrhz3toQ==
X-CSE-MsgGUID: iUnitEmUQ5m5aKxmXvH69w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="243891028"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 16:44:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 16:44:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 16:44:12 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 16:44:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj5fEjNm7gNtgLBFa/+JQ3cK/bNfF4rmp84KXimIn8QkfVBZVdD0SFIGfKqvCZa7BkaQU4uRELAni/YSa2cj1sNu/C6LDdxYEpXdvg0wojRENQjzhS9u8vhTAeILX/acxDeufzMVwi7rUfac+FrJvMY2vYuvstQ94RM8oOPFvPhc36P3ewcKXWPIVxtNkqWsvQOHtGvE1hVpzx2UvMgWw5XSBYDpjKk/brL0rFppYOuIKraR/TZFnI02a0WamKmCdCj9JT/YN6WbIsz5G6ME1qtwIkqiyALE5E9y2sEoHnccu6oa0kevgXieeRwXPGZL91DRdsAxfsGrvxoqqAnvdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q95ODAJfO2AcL55iXk1yALL1fAXeIfzvkAuPem2N0ws=;
 b=UtGG8u5T41IRd63d8fxAutsGiRYhOImOyaOszsi7VOqgmMn46TvfVCz4uwru5jUYkS7ocO9G4tTiRe2FoIpDL0IV+Ip/CcS7amqlj7euiGqRmu36FGyAc8O36Z/acBTgMfjfQu7FGSrb18styG6mvODdQMxmox7UsqSvcfxs8hDa8taIDIZrhOVvecl0ktjBGkResuU3ujaYzeUVg9eI6MXv0ahaxUz/+Q2lB3W0qCItRlDjvvJvgb3Sv6F7exVLJkC3H8bTd1gQYfsht34yuPabAd/QqQuMFtxtCSNEZh/40BVYekElCUezjmzOxD8anhjzfhnmOW79aKGs42X9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CY8PR11MB7798.namprd11.prod.outlook.com (2603:10b6:930:77::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Mon, 18 May 2026 23:44:09 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 23:44:09 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"paul@xen.org" <paul@xen.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/15] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
Thread-Topic: [PATCH v2 08/15] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
Thread-Index: AQHc4+w4CBDzoNQQUUKvPHLypz96PbYTq8CAgACchACAADBSgA==
Date: Mon, 18 May 2026 23:44:09 +0000
Message-ID: <a0c31f928dd34c7a6483024c69b9c8a7c91177f1.camel@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
	 <20260514215355.1648463-9-seanjc@google.com>
	 <136d277dba2ac681ed7607a436f55e2fd1975ec5.camel@intel.com>
	 <agt7vnVL5rJJUVzo@google.com>
In-Reply-To: <agt7vnVL5rJJUVzo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CY8PR11MB7798:EE_
x-ms-office365-filtering-correlation-id: 2e728593-921d-42c3-dfe3-08deb5375b6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|3023799003|11063799003|4143699003|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: lAulH2XvCa7MRwb50iOp2oqeAzXe7J6gXC5FD1uYmvlTWSi8te1mG0q7Og1pKUr9h/V+HWw74T+0xPh0two7boTASfkC0Qe8DrWP5dEaHKWpn8mFGCngQ76jOr/OgnOo3MerH+IVbT+e7a8Yb5gcH5yBuKCFmYi5AKj5MWmb9rMqzc4LsmQexngnz0k02udRTD7Dq/JPCCdhjEIoyay8KiHVTgkPu5+KvhviTSzSYdHgODiZ2kwoE7SVrz63+thP3Ufh2Lf5KAgQ/mAe53filHLcp+1gQfXhCsuH+QLa1FhlZDjsAlZQLDaB/XDjKAwjRpug1qoTJlV8MFRRuob+zEG/1d6h84tNFGUODXhCM1CQy3R8Sga8K5C7VSVsYorew/sRZmVF+pdTflJBwRZcTjxq+cpCgK0VyWkv5yObFteK/hd1QydhSvmM7kSoaq2qJDsiO+TwFncYFRaglRVmjh9xU2Uq0zL+zpNWlMFSch7EeFeDEbc+225hrPktS14EXtaYFsMJGczD0vcYltc6JIO08BkHhYQAXTBanlhHG0FDf8gbiY1RVnryoYemfmzym636okr9SQ5NyK7Buh3Jrfqsp+lU0HL6AtEn+rakBBbPJ2mKMNix6n4kM6YCcpGy4STSRLOOz5feAD+Yz1sfrzZOnpp8/bnMIdX82Yd0cz2kNQL8g1O/jKF+58JlDHZ053RMkZKaMMQqYjWY3fiHGV1WnI4zz45oAUnfdu5mZxb2tDadNnugblSmS6EqxgcE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(3023799003)(11063799003)(4143699003)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STdON3FDdDJFOVBEN0hKL2pnOGM3ejZ4cVpBUjh5SWlNTFdUbUg5M0FoQTYv?=
 =?utf-8?B?NzlycG1HWmJLZktCTGw0MkJuZ1h2STZXOFB6VW5VbG1mczdLeXozK3NHaXE4?=
 =?utf-8?B?eFZGV256TVV0SG0wRUFYeDhwdzhESUR5SElyKzhnenZGSE9PcTg2WCs5THdm?=
 =?utf-8?B?V0hUb2JiRG5ONUNsQ3k1cUFta1NTcmpwR3g1Q0lmN0Rab3pqdDVyMkFXUEYv?=
 =?utf-8?B?bWZmWXBkV3dHYm0vQmZRc3BRSWFQSUtzS3gvcUwxZkx4akFRZVRCVWZPS1BH?=
 =?utf-8?B?SlFCb1p3dExNZW5UeHcwV2t1bjc4SjR0SVRFTkZQMmp1RHdkclVrODI2M2ZN?=
 =?utf-8?B?UFVRMkNsMENJTDY3enBnN0FldWE4eGh5d0x1WklzNmp2UjRiMmdwMlRIV1ZU?=
 =?utf-8?B?YmpqSmo4SHlILyt5alk2TFF6RTJ0eU9lWmJEd25mTUFZWE05aWQwaDJySHdt?=
 =?utf-8?B?V25POTkrRUZDNjRHQmJVaytJK0dtTlVqbXU0QlUrQWQ2dUdlUk4ycE02ODlk?=
 =?utf-8?B?VzNmbWZHdjVmM3hvRjUyTFhFdDVGSjIvZTJ4dTlBMUhSTytSUHNwdU9pTlJB?=
 =?utf-8?B?ZUZZZ2dHYnU4YWdiMDA3dHljTTlMNExBNWh4NmZtaXhTQWVLQ2pYMmxNY05o?=
 =?utf-8?B?MEU3R0pRdmhvS3VXbEdhNFNjSFFtaWZ5UTdSRHd2THV1SlNLVmpJcFlwcnl3?=
 =?utf-8?B?VkZIRmJLUTZYUWpIcWJGc1VORWRJa045OGdlTjErdzIxczVVKzlrRlNHMEtD?=
 =?utf-8?B?UU9va1d4bHdpOTI4Q0pDWXVXKzcwTndCOStmbCtNdWx3TVBoaUpkR20veU9l?=
 =?utf-8?B?OWRObVpNRWtISVRPTlo1cVNNeHZKNUowWVhYMVlVUXFGaDRER0hWY3FlVkxS?=
 =?utf-8?B?Z3FPSVV6VGpxWHNnRzE1dHBjZ2hDbnRrQW14c1BuaEUxUmN2U1JIelo2OGNQ?=
 =?utf-8?B?cHFWMk1kbEtIcitXNmZvekxrS1R4Y3pXRmc2cXVKZlZidWF6ZFpiYzgrdXVa?=
 =?utf-8?B?RmRVL1NKRTQ5WE9PMWd0dzRqa3ZrL3o4T3UvOE5xU1dUTWFSM1ZURmd5VFBK?=
 =?utf-8?B?eVMrUmFHYjE4aFhCdEh3bGU0cjRvc29tbFJhVEVlUy9mVWk4YlN6Ym9mYnp4?=
 =?utf-8?B?NDhnK2xzMkRmRGxyL0pMSVliRUdRWlMvR0ZLT0c5NzB2TkpXOHBibHlzZHNm?=
 =?utf-8?B?dlNNZkdFWnFmdVZlYTJBMlhHaHRLbFJhemFpWkxibTluRVIzVGpvSEdldEhV?=
 =?utf-8?B?Nm0xNG5DTTl1bXVOOFoyTlhOYTJRVmhWcnRCRUp5MkdPQ3ZJUDJIWWxBcnli?=
 =?utf-8?B?RGxIQjl4Rzk4cUpSRVBBNWJobkdvU3NGWC9RL0E5OEswc1VQTTZWc3o0Ti9H?=
 =?utf-8?B?YkFka2twTm5wbUY1UGprOGxMejRMM2hTVFUzcy9rQURJMW1UN3h5UWZqSFVv?=
 =?utf-8?B?NUtkbDhyWldtMy92MzIxbU9JRnUrTHcvVGtLanRtaUNJb0Z0YlloN3c3TmxK?=
 =?utf-8?B?QTl2VDlwRXF1QTk0WUppZ2MyNTlhUytKWk5uVFk0UHNXQ2JKeVo2SkJpbEU4?=
 =?utf-8?B?c2dDVkNIZTRHUW5nWE5Wd2RYbG5LS1BvRHdvNGQraHhERUg4RUZVSldaK1I4?=
 =?utf-8?B?aVUvc2MydWFVbEdHanJYUDVkRVl6YTRrdWNVRzVHdjBNQ0ZaSUpWZlYrRmY5?=
 =?utf-8?B?ODRoVllKZ1lRWnBuQmRiMHlqYXk0blczQmNmelRsOFFIdmF4enlHUWczOG53?=
 =?utf-8?B?SkxhYlV5QSsrUGpSb3NnR2ZQMzlFa0lBaHJVZ0U5ekdEYTlzS2xRcmtzVVVS?=
 =?utf-8?B?N0tmK1BVTHgrQnV3TXBkKzd2dHdCcTRIU3V2ZE4vYlFreTZ4Kys4dFhCUDJn?=
 =?utf-8?B?SjhzZnh0Rm1tYlZXQlVKQkNYSjZRMHI2QVpqWHhlYVBLK0ZuakRYcHJYdmpM?=
 =?utf-8?B?c2VUbFJjTmhaNGVVQ2FTUFBvSDJnMDJOMTBDMi9vUnpITk04MUZqblpXcGdw?=
 =?utf-8?B?dTNiY0pYd0lYZEROaDhYc29Pb1NzYXJtWHRiemRrMTBpMmpyT0RTY1piZjVP?=
 =?utf-8?B?bllocHRSUit6cWgyVzdYNkxDbTlScUYzMnEyUHltTVM2OGhSSWEyejg3RUxs?=
 =?utf-8?B?RVhaTjhvZG43b0MwcXk1cnJ0cGczbTJUWVRlR1FsdmdPTTNqaEtpMkxDaXlh?=
 =?utf-8?B?VVBPRnNPb2JLRkZCUDdXZEVQUURBQ1Bmd3dId3EwTlRKblplVlZqUkNKaXE0?=
 =?utf-8?B?cXl2VGRMWTJ5dnlSZ1lYV1pKL2REbXVRM0F6ZmhXS01pd2VjV1Ztai95bUdR?=
 =?utf-8?B?bk9SajlLWHVaTVVOUUlQQXduWFhxZm0wUmxEVlBQSG1CUDMzaUFidz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <527C743FCDD9534D93C74F1DEC2F8E26@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DMCekM7kdqb+S0q1kthwhz+ksUnQnH8s4akgPHVclNwHOF6mjabPYz3S6PvZsgvVoIrQF19fjZAFlNGmikVXzi/HA21eALL219RlCEDHooLZobOc+c8vCRAEz0jLcm3oedPZsYRBQwqDrgjUH0OBEneGEXrSjk8BTJERpOtTKjRipcYkv9G8Q+ijQkbO62UgH4BMzD7e2beqjySMiy+CRKY9rjB/cnOAb9QjhpzpjU6G44Jn6qaY8KiT/PrD75950rQ3FtoYo2k4ue/F05uSgV13uAvoH/tS70iw9DwT2PE8rn6CcNU5OGb6rg80/urdx73ahcrRBH96c2boZfPz+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e728593-921d-42c3-dfe3-08deb5375b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 23:44:09.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TItDfs/Kor/EOzdijkKS6cyRBYmS2/dfwF9FwXir2tAMVEOfz5xYfy3iGviXFP6K2uxBKpAchnNRXuZ6w7KyHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7798
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA1LTE4IGF0IDEzOjUxIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBNb24sIE1heSAxOCwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IA0KPiA+
ID4gQEAgLTEwNDEzLDI5ICsxMDQxMywzMCBAQCBzdGF0aWMgaW50IGNvbXBsZXRlX2h5cGVyY2Fs
bF9leGl0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gPiA+IMKgDQo+ID4gPiDCoAlpZiAoIWlz
XzY0X2JpdF9oeXBlcmNhbGwodmNwdSkpDQo+ID4gPiDCoAkJcmV0ID0gKHUzMilyZXQ7DQo+ID4g
PiAtCWt2bV9yYXhfd3JpdGUodmNwdSwgcmV0KTsNCj4gPiA+ICsJa3ZtX3JheF93cml0ZV9yYXco
dmNwdSwgcmV0KTsNCj4gPiA+IMKgCXJldHVybiBrdm1fc2tpcF9lbXVsYXRlZF9pbnN0cnVjdGlv
bih2Y3B1KTsNCj4gPiA+IMKgfQ0KPiA+ID4gDQo+ID4gDQo+ID4gTml0OiAgQUZBSUNUIGlmIHdl
IHVzZSBrdm1fcmF4X3dyaXRlKHZjcHUsIHJldCkgaW5zdGVhZCBvZiB0aGUgInJhdyIgdmVyc2lv
bg0KPiA+IGhlcmUsIHdlIGNhbiB0aGVuIHJlbW92ZSB0aGUNCj4gPiANCj4gPiAJaWYgKCFpc182
NF9iaXRfaHlwZXJjYWxsKHZjcHUpKQ0KPiA+IAkJcmV0ID0gKHUzMilyZXQ7DQo+IA0KPiBObywg
YmVjYXVzZSBzbmVha2lseSwgaXNfNjRfYml0X2h5cGVyY2FsbCgpICE9IGlzXzY0X2JpdF9tb2Rl
KHZjcHUpLiAgQW5kIGJlY2F1c2UNCj4gd2UgYWxzbyBuZWVkIHRvIGF2b2lkIGNhbGxpbmcgaXNf
NjRfYml0X21vZGUoKS4gIElmIHdlIHVzZSBrdm1fcmF4X3dyaXRlKCksIHRoZW4NCj4gdGhlIHVu
cGFja2VkIGNvZGUgd2lsbCBiZToNCj4gDQo+IAlXQVJOX09OX09OQ0UodmNwdS0+YXJjaC5ndWVz
dF9zdGF0ZV9wcm90ZWN0ZWQpOw0KPiANCj4gCWlmIChpc19sb25nX21vZGUodmNwdSkpDQo+IAkJ
a3ZtX3g4Nl9jYWxsKGdldF9jc19kYl9sX2JpdHMpKHZjcHUsICZjc19kYiwgJmNzX2wpOw0KPiAJ
ZWxzZQ0KPiAJCWNzX2wgPSAwOw0KPiANCj4gCWlmIChjc19sKQ0KPiAJCXZjcHUtPmFyY2gucmVn
c1tWQ1BVX1JFR1NfUkFYXSA9IHJldDsNCj4gCWVsc2UJDQo+IAkJdmNwdS0+YXJjaC5yZWdzW1ZD
UFVfUkVHU19SQVhdID0gKHUzMilyZXQ7DQo+IA0KPiB3aGVyZWFzIHRoZSAoY29ycmVjdCkgYmVo
YXZpb3IgaGVyZSBpczoNCj4gDQo+IAlpZiAodmNwdS0+YXJjaC5ndWVzdF9zdGF0ZV9wcm90ZWN0
ZWQpDQo+IAkJY3NfbCA9IDE7DQo+IAllbHNlIGlmIChpc19sb25nX21vZGUodmNwdSkpDQo+IAkJ
a3ZtX3g4Nl9jYWxsKGdldF9jc19kYl9sX2JpdHMpKHZjcHUsICZjc19kYiwgJmNzX2wpOw0KPiAJ
ZWxzZQ0KPiAJCWNzX2wgPSAwOw0KPiANCj4gCWlmIChjc19sKQ0KPiAJCXZjcHUtPmFyY2gucmVn
c1tWQ1BVX1JFR1NfUkFYXSA9IHJldDsNCj4gCWVsc2UJDQo+IAkJdmNwdS0+YXJjaC5yZWdzW1ZD
UFVfUkVHU19SQVhdID0gKHUzMilyZXQ7DQo+IA0KPiBJLmUuIHVzaW5nIHRoZSBub24tcmF3IHZl
cnNpb24gd2lsbCB0cmlnZ2VyIHRoZSBXQVJOX09OX09OQ0UoKSwgYW5kIHdpbGwgaW5jb3JyZWN0
bHkNCj4gdHJ1bmNhdGUgInJldCIgd2hlbmV2ZXIgY3NfbCBpcyBzdGFsZSAod2hpY2ggbWlnaHQg
YmUgYWx3YXlzPykuDQoNCkZXSVcsIEkgc2FuaXR5IHRlc3RlZCB0aGF0IGJvb3RpbmcvZGVzdHJv
eWluZyBib3RoIFREIGFuZCBWTVggZ3Vlc3RzIHdvcmtlZA0KZmluZS4gIEkgaGF2ZSBubyBlbnZp
cm9ubWVudCB0byB0ZXN0IFNWTSBhbmQgWGVuIHJlbGF0ZWQgcGFydHMsIHRob3VnaC4NCg==
