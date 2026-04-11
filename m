Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085982C11E4;
	Sat, 11 Apr 2026 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775867195; cv=fail; b=CjDdvybR1qIPnomqSivbFbijnY7rHygLaXA3g6VjAflPqfW/Mr9Bk9JvX+FV5dQmQjd0OpHfXrI+5H4qtAQlcJVvEv/FgXNcfgb0GhO7xuncnFIEAu70+rKEWAbl8HoK5RllC4RE1T1aKmKTXyIAURSSJF03adoi/DE9goXj5UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775867195; c=relaxed/simple;
	bh=qj19bLqfSrzivaj8m/wWtWefG1W4WJmfZOkLmg87RmA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FXLstrcjY3IM9e0sq2dikRiC58QDlKiqB1/zcL43ztlg7+za2gMqLsr4aW/Om3sg2VuZGthutEO/WjSiYoWDFmbio6OLr2dX2AtvU8Kl6imDmMELJSJFnV6YOcZgG+iO8cqI4LEwpVo6ejpV826Zwl0L4sbDkiHIAXRZ1jdOMl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuvPJiR0; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuvPJiR0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775867194; x=1807403194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qj19bLqfSrzivaj8m/wWtWefG1W4WJmfZOkLmg87RmA=;
  b=QuvPJiR0N11XPxciHQlWtQ/lDOf66UjwORd53T41/rXgaYkZXhPEfk+T
   nqhSClELL5n6JFefpa7AN++uBr4LlFZLOFr5JoYJwyhbphYA0HRXntc7W
   f/aTlHcgtZbORFNMp4YJa+t76ixEsZfy3HnMYx1/Vpkfran3s0g8CPkIt
   GSkHtcW8Ys4qyd+U7YcjiiLck9iRNuivdt7Rp35rnouywDTaev/clGymF
   /5EZ/N5hVh1OsizAGiCFVY3cRA36sYn54YJXsExrDqrLzF3uJqccYnApD
   BM9iqzh8ie/qFi2YBWON7yAfFO1pnGsr8oGDMlpk+/hzOWuhWMRS6l3hm
   A==;
X-CSE-ConnectionGUID: mevJ0rE7RoOaXjMLlfNB4A==
X-CSE-MsgGUID: HZjzo6qIRPizRLo7kuv/bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="87520974"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="87520974"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 17:26:33 -0700
X-CSE-ConnectionGUID: ACa7lXjPSQ+s1hnSemTHEw==
X-CSE-MsgGUID: I1PHDTPHRQmGkiLmKJrJOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="233309602"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 17:26:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 17:26:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 17:26:32 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 17:26:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOwyqCjuO9+VTUlODSf5AEUBiVDshv7kPJO21+8NIDUCgBVyOEGor4Pi4WsJ4T1F8BSs3evVct9MxJmVMMpUy+HpT4iE8nG7dyvbIfSImkRJZ+6pYRD3iuORUdVWXDBSlTl+ZYPAvQx2DWaEEH5ig84Uv8fz1y4pt2UMZ4uwexlpy5CAUCY+J4RNwL8m2KSvyJg0bHu3eL7A0y2zbTxv+JnV/zMXyybMbf1Z8RD7VaZ8V3TNFAxlaKykWoLxGrauoaonG+2sfw6ptl2eoJv/osbliLXqx1VF5wtCk3pokqejovM6bzJ+qyNeo8TJYsP7LfxCvObQrjAvE7ed5a6zzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj19bLqfSrzivaj8m/wWtWefG1W4WJmfZOkLmg87RmA=;
 b=IQsxk92jE3YLRXdnQMuCOVUGSEK6hBIe+EQLiC/sVCeJU/RcaKZ9STaLUGyQZfBzKmfGxFk5MkKe41k17oakln4Ni278m9fgYyZrxZI8g0GpEIDvJzGdSRkLCC2vcHidVlBAUul7k6loXQo32JvNLwo5K3V5Pnp2A4HYynA78pW2cYy04Lck+PKoWDwIQhBK4Us0gQn47OxjcM0xZMpCC041I7vVNBaTkS57kAiD9IWd3PN6LIY8JIloUhj+cpezB0y6TjxuvASKEDJbKDeQIju00N/J94dlp8lGQr/d0xcJOE8XpO7jvtmlh8oiJcHvuc3YmqI95a/NrvsLM2Q0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS3PR11MB9646.namprd11.prod.outlook.com (2603:10b6:8:38f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.35; Sat, 11 Apr
 2026 00:26:24 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.014; Sat, 11 Apr 2026
 00:26:23 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 07/22] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
Thread-Topic: [PATCH v7 07/22] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
Thread-Index: AQHcwQv760r5QFBQl0WPBB7rsa+7hLXZEY6A
Date: Sat, 11 Apr 2026 00:26:23 +0000
Message-ID: <91f8645bff41f5b28bf964b215429b8c7ad53715.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-8-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-8-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS3PR11MB9646:EE_
x-ms-office365-filtering-correlation-id: 7378c781-39de-4f1d-55cb-08de9760f652
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: gQWb7uS3yPcKNJPXUYmyhGIwoOeny35+tS+tEBxJxMXOweR7Zqcdf+qad2Cb7rlDocFS8V1IIpVnoXyBpS+egX7l+NmVGbOrshVMBKbXBMHsHSRvxGu/wiCBWZbz0fGC92tv93VNWlUNXqauu1pkHtMColMoUzQopuo2bYo4x/qihKqBc27CbX1QB4JU2jmCNE+wZzojYPb3I/eEbHxym4kZ7z/li/4+S+W8IKj4WaVe+kdhZarQKpFj50PG6chwTRbKYSBaVqbyIlOsLb9wa0HoYiHNrQYYxZsy07kTqL6+tH2HhtTNzyY4dFebC6uk/dTeMUMJGb6KhotZZC0nTQXY2N/AuXAvFTH5M4J0xmMJzkZl2uARpW7uv9iCBrjGp+18ylC67IZoEQzjHEIwV9+ydZfOFmisXgL/wf9zl4ULXhD+yVCKCh2pvJHu5Znu/dvPkGPs+jl/uI3In1z9f0Mzu9hjuzCRIRZDx8xDrbI+BIN2k/HAD3DfnkQzFanlM/EErkk/u/o/ZIRRDHtf34cYDCuMKqBIhCbV+gFW88+ks2RYycMmOut4B5H/nt6w7hD2C2DY9fwZ1mSxMM4z0dro113oJ7RTIsDkarfvt6KZ8eM34efeHbsWEXc9gUzVrJOUnzzF/E+3gf0OOjUAXAfhfCs8+z119LehYs459dls9JTTeVSUaUyV1GBGX6A+kemQVHYBoPBVOPxp53l+FwsADoDbyutdqkZhB7N8QWuQJbMv0H0E04OZCrlAZXZMKas1sXDiUVfGtB/t8d5zd1fTDJd3sYOff042Tccd5eQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1UvdVN2OGsycS9KQWJIbjhxam1RK0V0RVpkY1gzVGhoL0lsM2hieGlOZ3JB?=
 =?utf-8?B?UVpUZEl0Z29raWxtNlp2WFlRek5MSkpaZHFoT3lhNG9UME5mUklpUFNUZGNW?=
 =?utf-8?B?elM1VlUvU3VVcHBSSVlaS3hGZ01pYWI2OGpIY0EzVTFVMG1RVndIdm1Uc2RP?=
 =?utf-8?B?OTdnNWdoRkloOEVVYkhsRjNvdWg1d2lITWk4ekhsUGYvdjg4NWtsM0NqWnpT?=
 =?utf-8?B?ODBhYkVZYkhMMW5BZUR1NC9hZ1hhNUVtcXJ6NWhXWXhNQ0VWeTV4V1NMTk1J?=
 =?utf-8?B?MS91RnZ5OHc4eG8zMURabmVzWVFWTTNEWHc0WHNsY0FsYTlqbXRtRytKZmtt?=
 =?utf-8?B?RkJCZDNXK3J5STFLK2pvYS9FQTZzYW9ZYTlLY05iallvcUlXTnhQRjlBQ0xU?=
 =?utf-8?B?T2FDdUdjdThiaXZRVGlLYUYraTRUdmpSb0JheGFhdVNoSjZvTlF6TE1TaEhk?=
 =?utf-8?B?bjBJelYwbGZhaDdxbEppSlFkSFlqMnFqclhjbFRjUVovaXhtYmlkYUV6dEpQ?=
 =?utf-8?B?RnJzbmtCTGhXL3ZNVnNqRWtVQzRvNGNBZGJ5Nm1jQlJHTlROV293ejJLdzNN?=
 =?utf-8?B?ZG5Zd29DYWEzQkZjOWNsOVNMQisyMXljZ0cxWEVsOVhzSlRyUWxycXdGcUE4?=
 =?utf-8?B?aFB0SFZkNDNGV0ZOMk5xREdOTGYvS1hnSXFXeVZVM3MxSTloYjNzRExlZy8z?=
 =?utf-8?B?VU9mdkpzV1NnYWJ6cWlTbVZLV2hKSE1Oc01FRlZCN3pSWUVqVHBEVm02UDZE?=
 =?utf-8?B?SHNvRVVrZUdRbUtJL1JEVzYwT1haTFFtRjFsNjQ4MEdnbHpuL1hIb2V2aXpF?=
 =?utf-8?B?NDJqSnM2a0dOMmZTdFZ1bjdEbDBtMUJhVDRIOTd0ODdqWUJ2czJvemFFdmpq?=
 =?utf-8?B?RWZ0NHlDVkp5OGhzM2M3enVSNE5ESEJ1NklmaWFJVjQ1R1d4WlY1OG55MjNa?=
 =?utf-8?B?Ly84YWpTRWIrUlBFcDYzYUxUNFp5MHhNYUFyY29aT3lwTERieDV6RGQ0Q2Vm?=
 =?utf-8?B?a0VTem9ZNHlOUGRvQ0U4ZHdoTk9kSm5uYUc3OE9uRmNnYVJrUXpyenRrbTZC?=
 =?utf-8?B?bXR6MnB2cDBVdTBDUkxkUW90eWRmRmZnanRiZStBd2NIZ1dRbFphUmhRaFBq?=
 =?utf-8?B?VmkzOTZMQ1VoNlZtQ2hGQjZLRWZoLzhQQ1BVOUdxUlF6anZ5dmlqd21CWGVt?=
 =?utf-8?B?NUc4NkJHUm45ek50Q0lVY2NFKzExSFNHNkZ4VTZITEV6emhUTFJ3dk5UbS9n?=
 =?utf-8?B?VW1iVmFlLzIzL0VaYXRqQzMyVlJsRnBWWDlCc2JGUGoxaDgrMyszYnYzNHJn?=
 =?utf-8?B?eVd3MjNpOXduRW0yanpnOVJZajNMS2JjUTRzN3QxSThDcDUwZnNnWG9ZLzFt?=
 =?utf-8?B?UnpYVEdCdTBHcjdUU0NVODE5amVsZTVWUWl5UDFBMlZwN1JiWGVIUG5xYkhk?=
 =?utf-8?B?U21NTGJ1c0UrTS9sNSs5V05rRjc2TkRNWUFScStlRGV4Qlorb3ZybnNiMGFF?=
 =?utf-8?B?enQzbmY3NHhpVnhudTBjUkVzWFJMT1I1ZnVhWUxaTmtDdktSVnRDQTZpUkRL?=
 =?utf-8?B?RjZRam1ydlRXK2RpR1BMb0N2ZVQ3dXFjbjAzbEhLclhKNXFGbGdOZGhOMU4r?=
 =?utf-8?B?VnJ6WEpTTDBXbmRwa1l5SGRoRTRJM0VtTThBRVZRZHlVc3BpUjE1dmJFcTgv?=
 =?utf-8?B?WVg2M3h6bHVmNlZRc1V5UnlUMVEvMW43aGg4dU5oU0JidFlndDAyaUVoOHFh?=
 =?utf-8?B?MWdpV1NKeHZJSmFsZTg5N0lYNFQ0Qm1sQ0lpZXdpUTQ4d2pNb0srUCsxZEdK?=
 =?utf-8?B?bGRNVEwxbFJNR1JjWUNFVDdqSGJJb0c5TU5RSkRRUmlXbXlmMnlUWGNOUFpV?=
 =?utf-8?B?WHBZT1RrcG10K2dYYi9TOXdoSGIwZW03OS9zQjR1QTdXWGNxcm5ra1BrSzdS?=
 =?utf-8?B?eGhwTzFmN2orclFXR05qWitHeUZXZnVpUWs3enJuR3Q5dVN4NXc0b0Y4Yy94?=
 =?utf-8?B?MVBYUVFEYkpzU2JEaXVHbXpaRTBRbW8vUFozVnZRbEw4OEVYSThPaTVUcGRt?=
 =?utf-8?B?RXFodllHVm04akpnM1krZFQzeEg2aGxWUHhjcTF3TVk5UDR1STFQSnF3czFu?=
 =?utf-8?B?NXdOa2d3YldKM3FWb3VMaHNJZHg1cE9FQXcvbU4yS1JoV0tZb3JCVmkvTVZ1?=
 =?utf-8?B?a1MyNDllL2RSazhUaU01TGFMSWVIckNDYmVIMEJySW9MOGVncERhcHVkbzRK?=
 =?utf-8?B?Si9kUDUyb0xXSkFqdlA3SkgrZHVrc1hiR3lxM1ZEdjBpck9INURKY0VOMjF3?=
 =?utf-8?B?K1QzeUkvRnlDUnk2YmVZTVRTeWtvM2F3UVRZMmtmOC8vNzlDdkV3ZWpTcThD?=
 =?utf-8?Q?huRyI82uVHweCGsc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80291518D52F5D4EACC1A06A9144DFB3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dUixI5NNJq6x5w7Lj674eX5cvP2c3lIwdGaYug1kE8bjPGoaYmU/pfNWx8mAp5dK+naZ/1ic9SkBwwCZS9RuSzF3zoGFLm/QqJmo6OCF8JPr17NEUb7SIvBAyLduHQKVsy2F+35LiV3SJ2abKwqsqWmSrClPtVK+BJM6jr6+3TjwR/6ZlZgoZ8/1hQnfTE/a3agpm/FtLymDz5BzzeIelzSTVJ9U6ccqbblkyBWQb+7B/cv6oTtUXjI8r9AS/fIIoXwBNS0iCVHt7+5M4AAxXcFqdfqxXHEn/EBQgoc8cr48Z/MgZJXcJ1CFIZrgygHW11vaZIAfPosADN63w41oRw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7378c781-39de-4f1d-55cb-08de9760f652
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 00:26:23.7972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TGhbhE87JRdR485E2R4T1rqI9hhczSS5YH1OJskwxEuBjsWlGQ1xxNHqsEtVtW/QyBPPWxZ7Zx64vSi6xFuudXlz1DZbCmkcnAi6t1qt4ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9646
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gK3N0
YXRpYyBlbnVtIGZ3X3VwbG9hZF9lcnIgdGR4X2Z3X3dyaXRlKHN0cnVjdCBmd191cGxvYWQgKmZ3
bCwgY29uc3QgdTggKmRhdGEsDQo+ICsJCQkJwqDCoMKgwqDCoMKgIHUzMiBvZmZzZXQsIHUzMiBz
aXplLCB1MzIgKndyaXR0ZW4pDQo+ICt7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCS8qDQo+ICsJ
ICogdGR4X2Z3X3dyaXRlKCkgYWx3YXlzIHByb2Nlc3NlcyBhbGwgZGF0YSBvbiB0aGUgZmlyc3Qg
Y2FsbCB3aXRoDQo+ICsJICogb2Zmc2V0ID09IDAuIFNpbmNlIGl0IG5ldmVyIHJldHVybnMgcGFy
dGlhbCBzdWNjZXNzIChpdCBlaXRoZXINCj4gKwkgKiBzdWNjZWVkcyBjb21wbGV0ZWx5IG9yIGZh
aWxzKSwgdGhlcmUgaXMgbm8gc3Vic2VxdWVudCBjYWxsIHdpdGgNCj4gKwkgKiBub24temVybyBv
ZmZzZXRzLg0KPiArCSAqLw0KPiArCVdBUk5fT05fT05DRShvZmZzZXQpOw0KPiArCXJldCA9IHNl
YW1sZHJfaW5zdGFsbF9tb2R1bGUoZGF0YSwgc2l6ZSk7DQo+ICsJc3dpdGNoIChyZXQpIHsNCj4g
KwljYXNlIDA6DQo+ICsJCSp3cml0dGVuID0gc2l6ZTsNCj4gKwkJcmV0dXJuIEZXX1VQTE9BRF9F
UlJfTk9ORTsNCj4gKwljYXNlIC1FQlVTWToNCj4gKwkJcmV0dXJuIEZXX1VQTE9BRF9FUlJfQlVT
WTsNCj4gKwljYXNlIC1FSU86DQo+ICsJCXJldHVybiBGV19VUExPQURfRVJSX0hXX0VSUk9SOw0K
PiArCWNhc2UgLUVOT01FTToNCj4gKwkJcmV0dXJuIEZXX1VQTE9BRF9FUlJfUldfRVJST1I7DQo+
ICsJZGVmYXVsdDoNCj4gKwkJcmV0dXJuIEZXX1VQTE9BRF9FUlJfRldfSU5WQUxJRDsNCg0KSXQn
cyBoYXJkIHRvIHJldmlldyB3aGV0aGVyIHRoZXNlIGVycm9yIGNvZGVzIG1hdGNoIGJlY2F1c2Ug
dGhlIGZ1bmN0aW9uIGRvZXNuJ3QNCnJldHVybiB0aGVtIHlldC4gV2h5IGlzbid0IHRoaXMgcGF0
Y2gganVzdCBkb25lIGxhdGVyIGluIHRoZSBzZXJpZXMgYWZ0ZXINCmV2ZXJ5dGhpbmcgaXMgaW4g
cGxhY2U/DQoNCj4gKwl9DQo+ICt9DQo+ICsNCg0K
