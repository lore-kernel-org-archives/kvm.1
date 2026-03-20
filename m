Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977A53B95E0;
	Fri, 20 Mar 2026 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027899; cv=fail; b=boyM39EOdI1qwycBG/CF8H2xbd7SH1T5yfzr1laBfuoGLw/VymW7JqoQijs+knmjSEH+xLqLKhaRW2CFRYxQCVZZJJxD48+2LwbngA16YomcehFwl1AEZerS6SAXenNcA/hHHgr25jYTFRFB0/mezRa18FViOga92patDeUbvL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027899; c=relaxed/simple;
	bh=UkfrZxpBluNg22kx6D8y60JIy8DDDbpNNj5WJVM0wDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OGd32Y2baKNT9DKzMfEwBha5fQdTdMdWL6/K5ajY3IsNLObJGuDRlS13mTZ7qX0cxarUYjTC8W27UGd8/W7hNbrgiXIH/vqfmVdaqk6imuE5eumxmhMg/r4P6vXo21x8q4HZx9RU0CGBXo2JcmJFbCh2WHmjIhZf5Dt6ebEU0M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=By6PGBSL; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="By6PGBSL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774027899; x=1805563899;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UkfrZxpBluNg22kx6D8y60JIy8DDDbpNNj5WJVM0wDM=;
  b=By6PGBSLoqaZ2XFvzK1RCi+1Pu7QVIYN42lR0WXD4/QhwGalKeIpLnlJ
   boUi2K+F99Um2GSgUG5ymPtbg0LB8hykj5LqtJ4x4PsWic51jvBDpsdMr
   WJL1u7PZdw9Y171Olra40AIDRlPH3LNUDXlVhJGr9zpZM9LpvL4YAz6Ge
   APXT14TnayT+gZ8/nTsEBWMDfNjoz0CYADTXK7LJRYK2240LF5yBg/Whl
   +EEZnhyBZTLoL6NOti4Uul/bm8+UtcciGyWUPMYLiYTo/pUn65sGJSlhL
   ZNE6xV9b/cvi+fOEcUvyugPmJe3IsxOFGR7vje9SUrhbvsf+2DpXA5s5h
   g==;
X-CSE-ConnectionGUID: XneEDsiNSk+rggEjjsRpMw==
X-CSE-MsgGUID: uU4rjFVVTpK22f2Ayl6ThQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86481714"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86481714"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 10:31:37 -0700
X-CSE-ConnectionGUID: h3nyI1A0Tqy5Y9XMRr5uaQ==
X-CSE-MsgGUID: zZgr9PcKQgmsAwkoDYaO5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="225251563"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 10:31:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 10:31:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 10:31:23 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 10:31:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joeCPh8Aaqq46ocDXn1ycGt9n9kEvYqzniYqoiRhoU0VKQ/AVzbBUEzWrWrOkld/pArPFxYbvBqwcPvaKtU1291m1DrBZH7Eceiml3Y37GWKcIqJxYkBOYkLwQ7UhQAafghu7s8W5+TE8Z7YXseLvQ2xHUdsJTo6C3yODTSm9l2n49TxtgMeRGkYYGS7r623V5y4VmhF7xF+8Xjozv44mHBqyIKRxw0pM+XZZiG2YrgHahh6QJYHQuGglWJ57i2tCd1jddN371SHDHZuaH2oIQyeqWxsoS4Zvtq0uyn89JbYDX3zBFZ4kLNxePEAWXRZCKqre8JKl1wJijSPUEVasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkfrZxpBluNg22kx6D8y60JIy8DDDbpNNj5WJVM0wDM=;
 b=GPovknZsjfhIrJJ+0grSgvALIMN1Tz0MGFJCebzG7HX+ihWdtnAdX8ISUzYjNMk8VRx7lDlQpj2Z4TLD+z5zIOxW3NLw5lmfOwOSwutss7oHxi3lyyPPpTueftcye4XmXQWU+K9u+z4v8pP5vYgntzFm9qBjQ3hB83urN+uUCzXWzQ/KXx9uj2oD+sjBKVatQUo2FYXvefKLY2ZqhylbnvuOA6hL4AniNyi3zKti4m6WfUyIzXydOlwyTNiGTIQus3f3t8iFkZD8p4etnoxNLxvnVPC5rZmOqnUQ9TrN5i6pHk3fpo99nM4uCamD47vs/QBD+uG502mLo+1PtzHVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ5PPFC35D45AFD.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::853) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Fri, 20 Mar
 2026 17:31:19 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 17:31:18 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "Annapurve, Vishal"
	<vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Thread-Topic: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Thread-Index: AQHct0DWySj+AXH+Kk26T1K2yM7v+LW1qsAAgAAWiYCAABAogIAAS3WAgAFHTACAAEwDgA==
Date: Fri, 20 Mar 2026 17:31:18 +0000
Message-ID: <d614658f2d1f3213b0d8ed404c51b3c4bfbe5d7d.camel@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
	 <20260319005703.8983-1-yan.y.zhao@intel.com>
	 <abvR2A19S4ZtpAli@thinkstation>
	 <abvlOcnY4assk8DW@yzhao56-desk.sh.intel.com>
	 <abvxiuJfK2eM_1UX@thinkstation>
	 <e3acc801e4e939a0a4794ba777e72f26b27af0d2.camel@intel.com>
	 <ab1EcZ3G_Nc-929X@thinkstation>
In-Reply-To: <ab1EcZ3G_Nc-929X@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ5PPFC35D45AFD:EE_
x-ms-office365-filtering-correlation-id: c7382129-581c-4e27-7f33-08de86a67f21
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 8Fz4WzWRMXGuADa2RdbqBzKPOSshjQxNdqeOMnLjN+ADuFRhQYh8GrtNU7FJrOcU+gggBObITuHFYIGZO7+yDG9/bMpmQHayELKZCji52KqzvS6fWcBQ2lM+v37tZ2rUfG9bkQOM4f853BrtWN+WFt8TCtLcQNATDppaEjol53xcyIiA0DoWFf199TZkmDBgVFJEGKuh1Fhc690DUhChZjFatGKWXBHEGR9l3fcNj2pVVLDVl6kYdG9aFsxEbUQylu957TnmzLczZAXUdqjh+Z16wrEcbt8lEeE2FhMoyhoxwg0IA+CDdIYRJn4dZrDyqDNAMleeQM3x4smrKgGaU/dO101L6ApoxMoYXMppmkZWUoOreiZbH8lcbJ1ocD/B7+Ldgxtzi6uUH71kHD4UAwPfQPMa5xnWICjbELnZpR7RFHdgVfPdgFBXLJOCeig/CWt2AXFn2aHi7yT0a73m08TUHlfw5NTjaI45TcBBqEi+FYcwlqHa0k5ozwvI9+EIwfL9Xmz9Q13bjUOv1VDyvuw6OTXtWKVqkxIgK/Uz6m5YSSPSO16WgjZZMveHCYiC7PJhX6/tcPOBhroScm1KE9fKbMvIAVi/xvdldwcLUZ1AA6ypEEPKgARoDvGNZgWlh3/WoIKvuhXg7LJZIiZmh9KUnIo9GhGujHO+RYae/0VzrIQWOPh3Lf75RgMq0LkmOs+6ASdMl7nIIfef5gQyFgYcTDJR+4M7iD3D29xTcLll3anbADV2UJxJWjIyRpus+Ssth/HQwZfUEf/OU8R2vFtAOZvWC6PRYkZkqGc+iLM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K25UL2lrcUdwbUJaSlN6M3grQjd3VFQ0MFM5clcwYlZvM3RCbFNacUVDdHh0?=
 =?utf-8?B?K2dVbXZJajZnS2J0RVNqMEVIcTJvWEhsdnEvekR0OVFEUitPbmVONDMvTkxx?=
 =?utf-8?B?ZkRHcmlSQTlEaGdUbzNmV1VOMEU3S0NMb3VBK2RzdmNtdm8wOXNoOGYxVkRt?=
 =?utf-8?B?U2gwRExWUkY2U2JHNmtjbVBmWk1MSUF0VmlqdE9kWmNWR3h0bnJ1TndrQzZr?=
 =?utf-8?B?dG1FM0sxUmp4dnE5R2R2cFg0M29tNWwzbFdpSGRwUXdDeER2Q3ltQ1BFRGlJ?=
 =?utf-8?B?cjczd1gwSE1SUHJJVXJqV2YvemFhcXozRUkzbVhtUzB0NURWZHJMYU9ubEg3?=
 =?utf-8?B?ejJieWl1d3JHT0FhOXJTYXU2Ym9nbzhhS3VvcVlTVUVBRzc2NVB5VHYzTDVn?=
 =?utf-8?B?TEpjNXZlSHdoYWVMaDVxVEVKRDN6NWpaNU5mOVNnOEY4VlJJL0w1Sm1rdi9m?=
 =?utf-8?B?Sm9JcGd4T1VFZFY1QzVzNy9CclRsU29hVmZtR2c5dzNSLzhjeU1Ec21GSDZ0?=
 =?utf-8?B?elQ2TVZUMVRsS2pRUWIrMXF3L0p3bzZ2a2hwM3QzcEljdHR5NmlibnZNRXBG?=
 =?utf-8?B?bVVkcmlvVVdRd0ZUTzlrbGFIeVpqcVA5UEk1UkMvNTNjSmR0NTl5dVhpOUhv?=
 =?utf-8?B?aFVUajE3Q1d2blBqTmtxZzFHYU1sWUI1NHQ1c090ZGg3cjhtM0ZZS1IvNUsv?=
 =?utf-8?B?MXAyUWVxbnFFN1lOd1JkK3diWXhGRkwwMS94ZFU5Q0pNWEYyOHJYVzQ1NDRT?=
 =?utf-8?B?bGM0cndSZENwYUVqSSswT0hCbmVyc28wV2F5c0hnNVNVU0pjcDZybVU0UnF1?=
 =?utf-8?B?UVN5VUxFQllDSkI5bVo3STMvYmIwTlFWRGo4cENtME5vR1JMWGw2N05uRnRj?=
 =?utf-8?B?SXUrR1lSdWExS3dtYUpkKzFIUmE3T2l1U01HQVpqMS9oS1R1WjB2T00reGs1?=
 =?utf-8?B?UG9CcDJ0V2V1T3MwV1V2YnlCbXpyQzJZRy94ZS9wVTBESlFZT2Y2QngrSE1r?=
 =?utf-8?B?Q09hbWpFTlJEN0pzRFp2UVVMRDFQK1Zhalh6NS9sY0Q4Y3R6UnZpWWRrQWRz?=
 =?utf-8?B?MW5Gd01BbFY0WHZkclo3N2FRQnJpQkVWM01MTXdNV3FiYjVMWlFYNFlRaG5h?=
 =?utf-8?B?R1Y3OUZJNDFqaGZrS2hUQkQ1YnBqYVBLNmhqWUtHSGt4ZXFFd1BrcjFuYVFY?=
 =?utf-8?B?WXFqaWlZV3NiTmV6bzhiZmdpTEVWTTZaVXNwclloMmN2dkk0alBDcVZudU9s?=
 =?utf-8?B?MmZDdm1iOW5Eb05PbWNXMjlrSzZ0RkhITUQyd0tSbUdtbjdRY0JFMzR3S1p5?=
 =?utf-8?B?M2ltRSsyVFdtVGlSMlZQb1RVZXJndnpiSFBWNnBNNGkzejFRbnBLYjZxTTgw?=
 =?utf-8?B?Zkl3bUVXdmNNY1JXRHJzM2h2YzNvcjQ2Ykl2K1FjU2lvZ25JaWVwZnUwSXll?=
 =?utf-8?B?QUE0WXZmTlZhV1hHdW5UUWQxeHNQbTF6eEFiVXB5Ym9nNkZDNm5LbW9qc3pz?=
 =?utf-8?B?Z09oOUg0aVJYcnJnUjlGM1V4VFlpdVdRdE4veklWbzRSUDhYTmkzRFpaV085?=
 =?utf-8?B?SC9qb3E3TWw5a0lvNnpWd0lHZG0vcHZjVWpyWnVMT011cnNjelE3QTJsWEho?=
 =?utf-8?B?YlM2UHZ2RTcxMW9KTUE0Wk9PS3RXMDkvcmdIOTRzUExIM0ZNRGdkdXVtRWN0?=
 =?utf-8?B?R3dDazVZbnR4YnNZOUpSRTBVT3dCa242ekp1YmFGVXdoOGVKL3NJbzdSUmNF?=
 =?utf-8?B?aGVlcks4cFYveW5SVkVMdGVTNVVYVm5MWUF2NlR6bkVmcUZFaW5DcnRnc2NV?=
 =?utf-8?B?bEduZVJmQkREdEszR1ZkSFNZcXhEMlhKOGkxeEdvbFdxSDBlcXBtVUtqSm9h?=
 =?utf-8?B?V2lPWENGMzNxNHp6N1daUExTVzVGR1RQbG0vSjBoMUNqU0tNVmJ4a3ovU2Rv?=
 =?utf-8?B?ODhXK2JtWmlnNzFtcXY1cUl1Uy9XSUtaaStZQ2pwb2lRYllUUkkrcWF0V0dN?=
 =?utf-8?B?RHpjT01aZmJwRnBsR05NZzEzU2Jkb2lZRlk0MnNKamJidStySXJPR2Z5bkNH?=
 =?utf-8?B?UnVucGdoZjdlemhQVSsvQlhrenB0Ynk3NGlvMEhRUlNqUXlqajhVZVpYTmRM?=
 =?utf-8?B?Wk4rSjF5OEdaelh3TWRrT1lPRnJRNFJwQm0xanEzd3lKbTAxWUZoNy84RDBW?=
 =?utf-8?B?MDVaWnBZSWcwVmdZYk11RktwelJzWUt0bTQxMTJ4bUxraEFhWFBRdlE0bG5P?=
 =?utf-8?B?K1h2SnRwTlJ1ZWN3MnRaVU1Bc1Q5SWROWXZvNDVPQXVpK1ZXUVNPNmtFN3kv?=
 =?utf-8?B?RXM3d3NHV2xxcGJUR1pBUkV6WWU1NnFxTEVUUmwxb3Y1c0krd01iVllndFp1?=
 =?utf-8?Q?AZiLEi5qxEelv+6k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAF4139160E4774EBE6F99B61BF2CFB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F4ugDrbBUJiksG01TiGLm2e5kCcFlkm8C6EM2tOwdMJq1nrVmxd/LWd33BJxXIfIQzPKhdDGVr41bx6/jPwGczQpXSfMRNVrESvsG9j4/HD6LZUku0xsxC7HymHzE8LU4Y58TbOQMwSMvQqeeuDAAxiHLx59hRRy9N/hox9IgiWKSwf5AWuytdtS4AK8hZt656cmUhG9GspfOHbx4EAXByPmKMyHv2i/l+dXVKS/sDpIOj/ZGCMPJknnxxD02jGMN4dtaSfJluqm815/UwKIbrd2d7QWk1bfaBB7a42t+5HfmHsA0MK8zdwByt8cPK34g98eAhzgoBfKnk3Y72JuJg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7382129-581c-4e27-7f33-08de86a67f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 17:31:18.8528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JM1X8dE+zVFYWou09OF+8wZtna0XcTq1KY+ZfXLGFuL/JqJHKw7j5Zj5j/rZ9YSUuUM5kmfmqbZ9nF7wOKkUhidYvvQ4UA+D9HfO27cU+I8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC35D45AFD
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTAzLTIwIGF0IDEyOjU5ICswMDAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+ID4gSSBmZWVsIGxpa2Ugd2UgYXJndWVkIGFib3V0IHRoaXMgYmVmb3JlLiBCdXQgaXQgd291
bGQgYmUgbW9yZSBjb3JyZWN0IHRvDQo+ID4ganVzdCBkcm9wIGxldmVsIGFuZCBtYWtlIGl0IDRr
IG9ubHkgdW50aWwgaHVnZSBwYWdlcz8gT3RoZXJ3aXNlIHdlIGFyZQ0KPiA+IHR3ZWFraW5nIGRl
YWQgYmVoYXZpb3IuDQo+IA0KPiBJIGd1ZXNzLiBCdXQgeW91IGFkZCBvbmUgbW9yZSB0aGluZyBv
biB0aGUgbGlzdCB0byByZW1lbWJlciB3aGVuIGFkZGluZw0KPiBodWdlIHBhZ2Ugc3VwcG9ydC4g
VGhpcyBraW5kIG9mIHN0dWZmIGlzIGVhc3kgdG8gbWlzcy4NCg0KSSBndWVzcyBJJ20gZmluZSBl
aXRoZXIgd2F5LiBJJ20gbm90IHN1cmUgRGF2ZSB3aWxsIGxpa2UgYWRkaW5nIGRlYWQgYnJhbmNo
ZXMNCnRob3VnaC4gSSBzdXBwb3NlIGh1Z2UgcGFnZXMgaXMgY2xvc2UgZW5vdWdoIHRoYXQgd2Ug
YXJlIGxvb2tpbmcgdG8gbWVyZ2UgcHJlcA0Kd29yayBhbnl3YXkuDQo=
