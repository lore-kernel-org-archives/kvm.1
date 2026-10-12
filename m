Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621C48035F;
	Mon, 12 Oct 2026 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791844965; cv=fail; b=Lp7OK1+R9os9pWE1bc9IezFd3RZXzXAFTi6CnCzLqwuAoLrVkfFmkBVmb11eo7sgPCRajdbc8zqJgzm1b2ihDe/QoWWchB2tcl6b6PSeLFX5zI9QCoy5LV9aHCAOB8P3R9wb1hJFgv1oC5rzHWSQcOZIJIx4xxvPK+Eu2CmGJXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791844965; c=relaxed/simple;
	bh=dd2Syzro0YpgR90vpB27DkbHeCBzmMOIhIjWpnjOYM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YYGVTQr2UFrPRQixCgftDg05LAgHMt7MxEf29oOMo/pIVSbhUJz1gDB8nvsHAZx6LKF4cXZ4ZjlmVIcn+oH9qxTvkc+cZ8moq1MLDtjBHN01NYHRdTy1sjVSt1NthyudvTvstbxIX+mYUKeOV9FxlfGtXyzvDQKO1apgDLD6jO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjZ+dVu9; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjZ+dVu9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791844965; x=1823380965;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dd2Syzro0YpgR90vpB27DkbHeCBzmMOIhIjWpnjOYM8=;
  b=BjZ+dVu92VI/teAVh34hbdO5UvsCWOJ4ttrZunvZO0lWsBwXHaqgq9B1
   VHQ1K+o29OvxBa8qY5aHVIX05SEOuHjoWgxmR3EDfhZCmxnLFgN8ztACv
   p2Qrlqgfct7ss9zzu/EuZtbuMLPdYpqz031nwgYFQ/31gOIPPBU63z/IM
   CQ0vXTRJ88LJzqCUGXKZK0OyL8RPbcENiiDly153riIDHGBZeru1os1/r
   U22UKKoNW9+S5cw+Uc9GlF9JeuR4uAqJ2GDQhWxE/mIJ81q0Rf9NME00W
   TXjgwCd9spJ1cWBIW1Zps8kje1XfUSYH/d0W9cmr7hdvUa0fBrAUUPnIJ
   g==;
X-CSE-ConnectionGUID: H7o1AtX6SPCe6imFjDf2UA==
X-CSE-MsgGUID: jGcueIn1QUeWms/7DPXeWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="447518"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="447518"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 15:42:44 -0700
X-CSE-ConnectionGUID: FF27rxYITcuqyarm1UXNZg==
X-CSE-MsgGUID: EAOGkS4SSgqguD+Ybya+Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1103139"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 15:42:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 15:42:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 15:42:42 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 15:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWtU4EHHAkkGWj/T/iiqCJUZ0N1MYFPBp/z9O+H+pS/xUydKnDpZSkFYf4ykz9i+xRbbIOAMfT9MwL7Ivc+RRWhx6+bHbHVXjsGOdssi3i6txwdUgQx1jTyaGj9N5sqfGTlgkqUqf1MrSG9cXQAmExJ4iT/ntBEHOW8GEJRBn5G9erlPqgK4SN7C+nt0rsoKVqp8ClCBEa4i4Cg9xViE+tiW5bqHUo6uKggr42Fxae616RdCGZLNSxZ5bgoa9nyQJq9BXxJAEPJLlFqq33rZLYvkGnML0FSENTKuthopU3qygGhPJdM1b19SUjXW3m/28TZIbMsimLcT7DSZo8G6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd2Syzro0YpgR90vpB27DkbHeCBzmMOIhIjWpnjOYM8=;
 b=mvjhR4i2glgpw7UxVwvXtDPpcPFEC5M67wj8BpRHw8n6x2vci/2H9xUa72+1mlOAqkJfTtz/IcCx28HqkwlhIOHcL3OgN8dBwIXney9Omx4WReKR34OTi0ePj70v6+H7Ih7ohgs9RXlBHcagZqGEac4U8+ovpMs2MsWBpWtWFn3e4AQ9CCYoqbh0jW/o6YOI7EZVjWL3EiRMlcKLTrP3ItSYuSs/LFXEd/+WLwGa74/rQMC+RAZLYPqPEb6tzXFsCILxw4ASdyZtCKQF1MB2zOBXMNmTC/XgguB395bdyewhf1FDoXKwAhrLwK8UM8QfTc1I4inzeUEqep/6Bf/hPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MW4PR11MB5891.namprd11.prod.outlook.com (2603:10b6:303:169::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 22:42:38 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 22:42:38 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Gao,
 Chao" <chao.gao@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Thread-Topic: [PATCH v3 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Thread-Index: AQHdVPFrwePQkhjz40qYtvqh1oXdVLb1loYAgACMGgCABGlygA==
Date: Mon, 12 Oct 2026 22:42:38 +0000
Message-ID: <74d848763aba416b45f43e11edff9930d1b6e268.camel@intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
	 <20261006-tdx-module-ext-v3-3-db52cb05b918@linux.intel.com>
	 <e6207c3e0443be4ee120ad4ce2b10359f7769964.camel@intel.com>
	 <asmu6nwPYKPnZ3jC@yilunxu-OptiPlex-7050>
In-Reply-To: <asmu6nwPYKPnZ3jC@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MW4PR11MB5891:EE_
x-ms-office365-filtering-correlation-id: 96ea0202-b7fe-465d-14cb-08df28b21e18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|22082099003|18002099003|10067099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: UuOLkCdVLOfgSkh8c+5ualoBzTQxO4zkS/wleaePeyVNOqQgT54+0K/lXXFGJVRjfv5L4e8MzxBvjvJa3XtzAVX2So17xSwDlynLQp8klwygv7uEHG1suMZn/H0iWQAShy1QJz/44o0H+Lu7fK1gGlrYnSVjqHFEw/SCnfVSVWivboBFuFeN+88jqZbrxj1L79XrhWNDK0NfXI4+cBHSJ+Aa1U8GNu3tZTYIZoZ491AuGccIwinQLrL3suU3Tk7we14RFxuRbPbaPSHvrt32eTsBrXGltFcBbpfFH8Uer4qtbZpK5NpZXDm0AZH9X21h8wBfyIwyYkzRvpy8SLGqd94PFZhW1NlYfszmqB8gSqvMJCroOm4OPGASsPjGqvmXYur7OCzhCjnhfzLqhYjgor3M0G5C43TkCXHnRKOQuJbjBE9nT0nFKYy5Kp72Ueo6b7lsuAQSrJIJ1QqAc2TkHBF8f4w+NNa5ItVVpxbh+jhFRTLJhcuACNWriduw0YaYG1I1Q55UZwGYOfIdfYrgOJlPonIFwZaZYKDaw5fxjhX2L2Uz4mOy9fCRO0hDKTBqsAUmUs4+4hnMekrrjwT08YN/5DeAScmCbjJm7MQQatYARxdg6lgmIINgTgmsOD9Zjyt6b31+Wg/zZjgz/tZW188PnWxjKw362vX2VFwpbollahx7U/fPRroLxsaaICucJNpjTrzzixzUwGPxEruXmcwO1q7Q0sj5j/w9pckj7Ss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUNMZ09RdUhCRk5vTElpYWdodXlSMjF1VkhQby9wRjRBZUFEYXl0VVMyd1Z2?=
 =?utf-8?B?YkQ3anl1bTl6S05sMEoxZGRVcmYwTlVFdWhYdFVnblROeGpxTDNWU3orbmtZ?=
 =?utf-8?B?Rko5N2ptSTI1eGFXVFl3M2RiQ0YzcXQvcnRHajdrNjByS3JLcldUWUR0d3JC?=
 =?utf-8?B?YzVtTG80L1dYNVJXL2k1T1ViWEJWZzlrRnJNdnJCZG9RcHd4dkdIcGVvb2NL?=
 =?utf-8?B?a2NubVU3WHZGZ05JcmNZRDJiSlpKdlJGaS9IVVFmcUs5SkJqUS9kanBEVEkz?=
 =?utf-8?B?ME5iTGNkTHBhUERYUDU2OUVoWE0xTWRJekt5czJBeXIwT2xOMURaSk9wN2JG?=
 =?utf-8?B?a0l1cElQYndxVnpiMHhnZ3JKZmdFK0JQVDMreVp1ZHFERnZLWGN2RGE1OEVX?=
 =?utf-8?B?U0RTdVJWc3FSdmphTHhvS2ZjOHRlNzJGdENmbEIvMW1NVUhLeE1kTUhuWFFX?=
 =?utf-8?B?MEZrWmVKNjNFaHl3UW5oZzJ4RVd3OTJockhJRXNHbzNUOVlCMmdacDR3Rm9K?=
 =?utf-8?B?KzBDY2NRaXRUOWQ4UThZNTAxbVYvejdnVzRkcldyQWlUQkFqMnBDMzhRRjUr?=
 =?utf-8?B?QUhsSGQ5VW1xcnRpZGxsQlhxaFlZNjEwcmJVbG9QbEdCTlJ4cHVhclhTUjBr?=
 =?utf-8?B?bnl5RnhBK25CYXhMTDk4VmwyYzNva3RaSWF6YzZUeG54eGF6UldQVTA2MjlX?=
 =?utf-8?B?akJUeDJXemkwK2xjbkp4SnhCamxONllQZ3kvOEpXOUlHQXl3K2tMaGtIUDNO?=
 =?utf-8?B?OXNqdldYQTh4eWVKenNnRXB1N2ZUMENWcTRVYUl6aXFDN3FhNnNNOVVhaTVT?=
 =?utf-8?B?Q20vOUZMUFM2SWRqR2FMd0xmc2hJcGEzZ3hybXFRZGtCZmZNdCtJRGhCWlpz?=
 =?utf-8?B?ejdCQlk0MVhUYkU5RTI0RmVlVW9tRU5RemZiOWs1SmN4SGpZVHVxalA3MXFt?=
 =?utf-8?B?N3ZDeG91UkZmd25EaU8vOWZ6U050MGNWd1lsQTVVNHFzS094R2lkeldOZDVE?=
 =?utf-8?B?OFJZOE9XZGpvTkxYT2x0bDQ0Q3k4UEo0dldDNW0rOUx1OTE0V0tWUnV5NDZK?=
 =?utf-8?B?bExPWTF0M3crNC9LQ2lTRU12aWxrZmQxVW1Ea0tKYmFGT2RyQjc3aTB2aWJt?=
 =?utf-8?B?U3hZSTZLMUFwWFA0Um00RmFDRjhJOHJycndpeGQ0Tk5GdkpTYjFwcmpoV1dr?=
 =?utf-8?B?NUppMFVsd2RCRmZSZCtwUDYydjVjY0JYcFkzU29zMkxFRzg0cU5wWlRoKzhJ?=
 =?utf-8?B?NEJ1YlFoTlFudndMK0RDcHhCRUpOQjN1b2x0bXpTaEYweW5zMm1taTMrMmt3?=
 =?utf-8?B?RHpyV21EZDhpalRrSUNtek1DOXVwUTIrMkZwNitySVBPZVNoS0cyRXZmWldu?=
 =?utf-8?B?Y1krb3g1V3NDdVRVNDRIRmcwL3dIK2tJeDdIdW5zZ0VaRkFVUzdPdWZOMVUv?=
 =?utf-8?B?Zlp6RE5xcEc0VDZnOC9yVFh5MCttYzB1dXM4VFNwMHVXZHdncEVQVWI4MzB2?=
 =?utf-8?B?eTdGaXU5Wk5XSWY4bUpQeDJGNnFqRGZZNGdzclNmUlhuZ20xaXk2V1liM2pG?=
 =?utf-8?B?dkF1Ky9uLys0cG5zVldacSt1Njk3eTRUWHZoQXJhNGZLenpiTVF2WkcvOFNz?=
 =?utf-8?B?dG00dVF4YnB0VkNVeGFJM3NFaU1ETmFrQ3J2SldCSmYzMWFCMEtnMVlnNUp1?=
 =?utf-8?B?Z1ZDMFU5bTJmVkpzbmFOZFJkbnBVSG1KejBlVXFvcHJZTVFHSTN4c3lRY3dG?=
 =?utf-8?B?TmJtV2U3b2o2eEt5elZvN0RhUHFTaWx5OHpqUCsxTS94MEJqd1I2UHVNZHk0?=
 =?utf-8?B?VHRITWRGN2hRMkwyOWxiTC9ZMTZxaDNZczI0QTlCL1R2RWluMU4vVTFTRjRY?=
 =?utf-8?B?eVFxVkFaaG9hc2FERmpKZ3VGVDQvNGEvQjRZdFFScmhnbGdqWHJ2ZXlvTzQ3?=
 =?utf-8?B?ck0wU1d1V2FaUlR5OFJRSUtHenlBa29aekRDUFYrU3BPWTJEKy9xSEJYQ002?=
 =?utf-8?B?bUNUbnhZaFpEQjVZUTBBay9KcjErWDJBVFhPS3hqb2p3bXpadU5NajcyWlA5?=
 =?utf-8?B?cFlkRG50RmplSjRBMk4rSE5HMEhGQUJSc0pqNERwR3BPRjBFQ0pGZnpPTERt?=
 =?utf-8?B?MzE0c1lNbFhPc2VNSjhIdmd5TWhGS2VxUnk4WmxzZ2pqZVVzdytGKzFuQjRL?=
 =?utf-8?B?OTJzdzh4bVQxSTJ5T1AyWWpCdnlSTEE0eXV1SXBnU0ZXUndvSkVpSEVIeTZm?=
 =?utf-8?B?aFZLYWxaRFhjdFAvd05OMzZuWjBmVFQyQlBxQk1LU1ByaVJybzlWQUtIY1p4?=
 =?utf-8?B?bGtIZXZDQnpBT0FUZ2piNDBIZ3h4Q3AxUmVlYk8yeG5sRW9OZ2xLQkxZWXp1?=
 =?utf-8?Q?Tp/QOiyulFYSYoR4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E53F8A037BFC304389C81BE0E0B3ED11@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UWwkpKdMwsDBpXkfZCACdvfOrmi0LKF4wntlWj2deFS28CwzOvhkRXyHymRj56z+kOJJ8tSqkyvlnmK2rgZA2Eniproagn8P3WBiXkvtxaSNj1CQsD+Hfgl4JLr2d/okYY0jw/cOxmt8DY1M14D2c8bUKWC0SiklLJYHHO8hqA+hNL35MZcD2urgdoC0NXzGN8c0b3G0Yztt55IoHz2KPW9MbH4OCaxIMRIqFfzAwK1TwRkXnt8w5pleWsR+sH+KitgfVGEDy8lpxSclqgSRsJHnCJhGtFarJMBFIwg9zt+Hj3+VrY21KZdjtMbSq1wHRaqdpIz2CE5MvURW0R8/YQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ea0202-b7fe-465d-14cb-08df28b21e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 22:42:38.3838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K645xmA8PZm73etIH/vwTIkFP/jVgfHnstjHSImpxeC7zmiHcw9MT2t40VjCh3pmhMeM0jOnOCXwksumd0Luy1MVsLH/KktP52HSSBYSjfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5891
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTEwLTEwIGF0IDExOjIwICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gSSBw
cmVmZXIgdGhlIDJuZCBvbmUuIEkgYWxzbyB3YW50IHRvIHJlbmFtZSB0aGUgc3lzaW5mb19leHQg
dG8gZXh0LCB0bw0KPiBtYWtlIHRoZSBmaWVsZCBzaG9ydCBlbm91Z2ggZm9yIGRpcmVjdCB1c2Fn
ZSBldmVyeXdoZXJlLg0KPiANCj4gwqAgc3RydWN0IHRkeF9zeXNfaW5mbyBleHQgZXh0Ow0KPiAN
Cj4gwqAgcmV0ID0gZ2V0X3RkeF9zeXNfaW5mb19leHQoJmV4dCk7DQo+IMKgIGlmIChyZXQpDQo+
IAlyZXR1cm4gcmV0Ow0KPiANCj4gwqAgaWYgKCFleHQucmVxdWlyZWRfcGFnZXMpDQo+IAlyZXR1
cm4gMDsNCj4gDQo+IMKgIC4uLg0KDQpPayB0byBtZS4NCg==
