Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D642FF507;
	Fri, 26 Jun 2026 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782432854; cv=fail; b=cRTW//4hhpGgFp+xI+j8S90f0bCF99puKX9Cn/llTDs6IOgcNKDyXjyAzQUMaDqNOW/Omd2kpP7Ya7DkBfxlEyCAd0s1Qa8u7+QscFPNEBKf8BAfNTCxy8a+u5SIo5pCb8PkEYoLEQf2b2GnBpiXWYF+AvWbqaEGDLio2jfiq+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782432854; c=relaxed/simple;
	bh=NaziZOJ3VrXnUdXP2ZT6ghTK+PveIIz9QGfx6JNngxY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I5+3jX+52tVgla3CgUBN0bJMATnPE08xCUyTL1eW/TOaTbRY24xs7K2+PtpOmlEsoFI2xAVjRKYyXMe2PN61jknwDkj36PBTasv63ZmzvUsLbxk7+Q8rrhqsZ7h2x8uxFM4MFXMszhCXuDQFXRj/TJtzFg9z9eLvsNInQ9OP4PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALLeIf3I; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALLeIf3I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782432852; x=1813968852;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NaziZOJ3VrXnUdXP2ZT6ghTK+PveIIz9QGfx6JNngxY=;
  b=ALLeIf3IIHd4Ol+spkT2MHbzxJNkDZSLc8ISslQTb130kroM+Hp/lRI7
   PO6/e4Q05RdTPzr0NMNXDgM3uKfjU3K7N6gtRBgc4/TQyHTa56LrG1puS
   lv0OfcJ6GLrDiTvzoAAJKft0fe8/mMhZpxmxBo1l/0Jhgdj75PZQ2s9xm
   3aiW3GehPEhSex9tdVOaTRx8HtMfK9HnoQ5GLswox8eZvFLpDDSE4np/y
   3KOOn8ZmZC6avkhtjms1MNlVTNwrf/e0A0LQjF0g5UUm8OXYZ6lpUWqet
   gGE63GXscAYlzELiZj45MUi2RYVTbFS7AsXwnTXV+sRzGRcKsRtMeGR8A
   Q==;
X-CSE-ConnectionGUID: FZVcWuZjTWiudymlO3/G8g==
X-CSE-MsgGUID: cDGKQFloQVi7WE1PuQsjDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83288965"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="83288965"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:14:11 -0700
X-CSE-ConnectionGUID: IHyT8rJuSGu5S6RZJdaayA==
X-CSE-MsgGUID: bcc6eDU6Toqb99TCFHpaUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="274383605"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:14:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:14:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 17:14:11 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrnH7H1bF2NxGfXpik80+OsLz4SER5dROnaz9ytW1Tmk5qE+P06RlYS96lg75vv/OPEn3jDgYqDf2vLbOgMLJVgkLnevUWhbcS8pg7uihTdUilZcpzc4B4HGRzFAzexOtKm6OjktP/s8YkrSImD8P+Zbb5aq5rTc93NwKJeKxYuLbOEA8t+BjtFJMQ1zZHkIhfECrKG7B/juUIWYjbi7vI0Pnm92yb3Lfjv6fir7Kgbb5Gi0BKQ8F4prV/4BghE0EPeJbryQan7sWztLhBRHG9MCzKWpnLMef/JFW0WZSFvhiUi2jdtr6KPT69pJyI1bbzmI1/5SKuyLww9aDs1Vng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaziZOJ3VrXnUdXP2ZT6ghTK+PveIIz9QGfx6JNngxY=;
 b=jOY9fDcGx14adHwWEC+PqPDDAfc/EquALK3XYlVwkwUyphtsOt6AF8P5bKdxmk/w7ZT0SzUhlVGZTXBEus0la9MpQs9MlkidiVu3ReIzktrXFVMcSCUx5VTnry42oxXSsZGGK3rcgt5gYeT9dGAgk661mL9sig5Tp61BVPQW+p9Aq3w+FQz1GrWxH94N9pgczuXz3jEjHazBi8yeq2p9BOACPJ9ksTaUhbz6QLbxDfEameLeRgBpjLk10Y4dDgBabWT28/x/Jqn0zniCPtDKIKFtkqzFOsCbJdbMj9R0PlP17aVH+pYAD2M2BSBrRA94nY9+Af8j0QUh3/nDr15sJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.17; Fri, 26 Jun 2026 00:14:04 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 00:14:04 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH 2/9] KVM: x86/mmu: Annotate tdp_enabled as being
 read-mostly
Thread-Topic: [PATCH 2/9] KVM: x86/mmu: Annotate tdp_enabled as being
 read-mostly
Thread-Index: AQHdBO6vofIPUxSPsUqAmJU3UtAUw7ZP94IA
Date: Fri, 26 Jun 2026 00:14:04 +0000
Message-ID: <88f1121fae98a0c83aff5b67eaa4b026fdee1116.camel@intel.com>
References: <20260625220450.3354415-1-seanjc@google.com>
	 <20260625220450.3354415-3-seanjc@google.com>
In-Reply-To: <20260625220450.3354415-3-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA0PR11MB4752:EE_
x-ms-office365-filtering-correlation-id: ca71db20-cfc6-449c-b8c7-08ded317d4f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: 8k9kU0SQh/bvLvV2YEqe+j6yyzI8zKQb+mAWl4ZfGPcmNL4Hw5yfBkvHpkBRDFgeFSNxrrbn6bUsp14EWebilL7CamxniXZL2nEVsjHWQ6wrRrWH0l8bWrV1RmdRFQE0fDgWtL1Q9dSKdj9m5W22z0eFr15nM4XVmUkYlKpHBZNPG2pFfVi8Jt4JHGfczhls7/POzeaoh8WXOY1WbKhx7D9xFIYo0BOsE3iJx27+mfK2vMeoK4JaegFmZ9taTDFGE5Xb0txhu3NeJmW86H/tYndkLVhHFJZU5A+FplwudSUzTbWIqlD6G7zDMaCUYf6meDcP2JEebi1Z+yf7sEbGu3vJ04Zsn7Cx+/3fi/lbnjBW5TaqgK/9+0BZWhj/h0VDzuLVJ9SkGgSDTsdyFgGrm/waVb2o8toYZlQDsRL7Hcx8LV/FIc84TT90+5pLnV2deIcjPAjDhUrNl5bCUbkp/T/EAp+7wO3QvHKI1omz5yCRmIirRHy5df4kuSeqNFzMPVtytBF9nGFCq80EaNcRVQwJNa8gdGp/DZMYq9bsXMZrarM3AiCUVwyfsRAHLxbR2A3fGvE6OPRhEZiToalfBDrBhKD1eecFZVcL1r1Ua4UIuT5oVor6BDVhC+WaH/9/QA6+B5UOlcxBysQJy7i+P228sddCe3Prev1cVdlX8WDqaDU4DG48JQCT1QPMApyaiy6CDqgPJ7aMqMHFqY3A08kTbzkruRu/SmFTJmTybxA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1VNcFZySitWVmkvY3Y3aVg3eTB6bTQ0VFMwdWVDZ2ZRWUVVaWNGcnhJUCs5?=
 =?utf-8?B?Qm1obUFUSUVCb2ZBY3lQSmhUL0plSjVhbEloUGRNOWNydUZocS9UV3gxQkkv?=
 =?utf-8?B?REZUZGZEM3ErRUZJVXhKWU9WbVpmSklRekQ3bC9IZzlPMExya0pPSk56d1dD?=
 =?utf-8?B?RDZDL0x1N3RBREwwSkhlSVM5NFEwVTNZSmNzd0RhR2toeUkwcWVQM2Rkejhh?=
 =?utf-8?B?SEoxeVpKcUtNNUM0VzlVNmQwcFVVdzk5Zk55OUROOThOR0JuMm95aGprMFcz?=
 =?utf-8?B?YjZudGZlSVZ5V1RqRVdwRFJSQ0xIeGtaYVM0YWR2cVIxNGI4THVDMXEzWEd0?=
 =?utf-8?B?dzZrOFhhNGNNazlpcld6TnA4bWhYU21jaDZrSldxVUdIcHhGbEJWK3dLT1Y4?=
 =?utf-8?B?SzVUWmNWeXBCZ2l0L2NyNzR6SXpzU0F5YURJdUFUOFNtRitFYlZKZ3ZUZ0t6?=
 =?utf-8?B?ZCt3L3d6SDdoODRSOXVEdDBQa1ZQZ3JiTVR0RTdsMWY4cEVVelNWVmtiK3FY?=
 =?utf-8?B?Szg2VVZOczA4SVpVWXF5SitCcFZFUlBIdlZ4aEpwNG5VUS9hb0x6dWY1Q3pF?=
 =?utf-8?B?YmtpY1hoQ2V1d245aFBqZGc3dFJ2Y1ZyQUpaRWlmTlo2MGxMQnpKODNzZFcy?=
 =?utf-8?B?YXA5MHAxWEM1YS9ZU3pIb0MrczZDWUtxU0ZBVm5wNDRVbWdiQld3SUU2dkJC?=
 =?utf-8?B?bGczTUZ3bjFlT1JsOHZOK3NEZkFjRjJUdStYbTVHdXcvSkxRMnVsOThpM3pS?=
 =?utf-8?B?QjlaZEJMQXE4b2dSTkpBbk1LRVdhY3NRS0dBZUM3TjdJNitRQVhyYXorQ1k1?=
 =?utf-8?B?U1p3T2ZIVlNFUTdnSmtLNWtxQXp4aFBJaklkRnZ2RUR5d1R5L0JYbUp6RVNi?=
 =?utf-8?B?dW1YcHc1dU1jTVlLbmN1MndRdngvY1VoRmJtYTVINFNXZHNCeWdKSVY0N09m?=
 =?utf-8?B?bnk3eldoN3dNcUdaWVB5VlhESWp3ajRVeGJBZGg4djRKVHZtMjhRRE02Qi92?=
 =?utf-8?B?ZmxvVEZsUVNKWmJ3Q0hhUnJ1azBCOW4vM1VEb2wrM0tOM2U4SXpldGpYbEh2?=
 =?utf-8?B?cGF2cFVnTGxEM0J4N1hHdlpRZ1hUbmk1MnB5ZjhJSHVVWERYOTZPdGhLVDhh?=
 =?utf-8?B?eU52dzFrOVhxY1Z0VUlYTUs5aUdBYlRsOGZxY2dFYUpJdnk0Rk1TL3k2UXNG?=
 =?utf-8?B?NExCMkkwN1JFc1gxdUNPdWNDeFo2L0ZFVVUzNGhMb3hoZ09LaHorUzRXbDFJ?=
 =?utf-8?B?YURuY3ZWTnVSTUF0R1pNc2E1QUFJQTZBYXFsRTFaVlo4MkoyRzc4U0dkWXly?=
 =?utf-8?B?N3grSWxZMUxUSGNMOWZOMk43ZGx5VmlqTDh3OS9qd0xqTm5GVFp5QjAxMkFM?=
 =?utf-8?B?UlFNY01PNUpGWHU5ejdySFlXNDFzSkEvMXNZTWNjcE1RQk1ibUVmM1liS2l1?=
 =?utf-8?B?d0JnUDJiYXYwSGF2aG01VFV1SFA0VTFjaWdZcmExRkFtdnlNc2RiODdNN08x?=
 =?utf-8?B?T1c3cUFobVU4d3BSclVNalBqWC85dWRqd012eDkxaEl5UDUxekZJd1Rmejky?=
 =?utf-8?B?RjIrMTVzZGl1VXVPZmgzL1phN21ENXhEN1ZqSXdCWC8xd0d6dUF3UlRLSkRa?=
 =?utf-8?B?MlA2bmRmekRGOU5yMXgyT3NoZTdzeE4yZ3ZYYWlvMHQwclZhaGNGSmpITzhT?=
 =?utf-8?B?RjhFdjVkMm96QmtWMmgyY0xHMEk0Rk5JQzMvU3Vrem1TRFBwdjJIYU91bTZ6?=
 =?utf-8?B?ZG5rWTFmQStOL0cvaG1IYnNZUWF5RFZRdXBPZTJGZTRqUnRvTGI2UkJYQzAx?=
 =?utf-8?B?dmRkblMvWE10bUV2WVBiSUpWY1VuYllRR2s1RDVmczdaNmhOSzd6RFRDdzlC?=
 =?utf-8?B?WXFrSGZiZDlnb2ZUeGl5TnJmbm5ibFdqZG5NcEx5UmxJOGtva3E4NWRLdHVB?=
 =?utf-8?B?dDRCUmIyVkNGY0RTV09JbDJjTDM2RWRCeWR0Kzl2MGRxQlZLbGpCNGhFdC9O?=
 =?utf-8?B?OEdSbE5mcHlQOXdCdVhMOFkyeGtIRFEydVZzVVBQZU84NGczeDF4SlZKM2g5?=
 =?utf-8?B?YkVQT3Q2YWUxZ2tTSmRldFFxNm0rd3IvdXY5WXJEbUUvN1NZVXhWK0EyUlZj?=
 =?utf-8?B?VU5hZlJpN1NKV0VVdW05SHMyWUFzN0xtY21RUjlUUlJkWWFxUWhyaWErMVVD?=
 =?utf-8?B?RmZKQVpEWTRjZ3NvLzZ1MHlzS3pqRnU5ZC85eGdhSWpBMTFPRGFBc3dWNFpM?=
 =?utf-8?B?a2lKSEpwdlM2YWsrS0pRczdGai9PV1dWK0lBaUxFOEV4ZmdkQXIrQWo3RVVq?=
 =?utf-8?B?UGJ6Mnl6UlYxbnlqTTErREJlODcxd1pSeGcxS2ZVQkdHL0dONTRnQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E45C3C82D27FB419EE110D954FC9AEF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kVDnWszraPSNHnlYGkHV5P7e9JUH1hKonONmGSoy0YvI52G967X7NQ0Wt+ji+g/yTevUeacbum3W/vW5cr6NdDeeJQbFZ/xzN5gfDwokyWG3/Qd0j1bYpx5wxYowSJ/1X3DVFhrnvw3QQXdVNHGEfI0eEcAIEzaQa0bTRn/5xENwVMe7UVC2eiEk9tFFm2BPzj4KT0Q5Nh1j02C88nY2NKUUr7ii9E6pNpt1XKEIv4bt8tA5qWmXCwDtlEUP4vydyMq4fdfMGcfZJ2veT1ROv4v7dPLSUGPdAWeAGHioG/iFJGPtrmNyl96e27lP2UvYVjle38AHCNhKqqrCgoBzoA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca71db20-cfc6-449c-b8c7-08ded317d4f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 00:14:04.3116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpq20Fx4QyOK0WHThhxEGvypu+dsner9goxplzfCcpXbn4gpfeZeqgfm2BGX2NmwMCIC7dNI0ThNAzvrQLiVDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4752
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTI1IGF0IDE1OjA0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBUYWcgdGRwX2VuYWJsZWQgd2l0aCBfX3JlYWRfbW9zdGx5IGFzIHRoZSB2YXJpYWJs
ZSBpcyBvbmx5IGV2ZXIgd3JpdHRlbg0KPiBkdXJpbmcgdmVuZG9yIG1vZHVsZSBsb2FkLCBzYW1l
IGFzIGFsbCB0aGUgb3RoZXIgZ2xvYmFsIE1NVSB2YXJpYWJsZXMgdGhhdA0KPiBhcmUgaGFuZGxl
ZCBieSBrdm1fY29uZmlndXJlX21tdSgpLg0KPiANCj4gT3Bwb3J0dW5pc3RpY2FsbHkgYW5ub3Rh
dGUgdGhlIHRkcF9tbXVfZW5hYmxlZCBhbmQgZWFnZXJfcGFnZV9zcGxpdA0KPiBkZWNsYXJhdGlv
bnMgd2l0aCBfX3JlYWRfbW9zdGx5LCB0byBtYXRjaCB0aGVpciBkZWZpbml0aW9ucy4gIFRoZSBj
b21waWxlcg0KPiB3aWxsIHdhcm4gaWYgdGhlcmUgYXJlIGNvbmZsaWN0aW5nIGFubm90YXRpb25z
LCBpLmUuIHRoZXJlJ3MgbWluaW1hbCByaXNrDQo+IG9mIHRoZSBkZWNsYXJhdGlvbiBhbm5vdGF0
aW9uIGJlY29taW5nIHN0YWxlLg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xl
LmNvbT4NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+
DQo=
