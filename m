Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5B26E173;
	Tue, 14 Apr 2026 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186268; cv=fail; b=c1zpV52qIeOy78vLtH2t4roFtTzMsLoPD6FwmvDyLRnDCptVfqlARV29nOa9m48Wx+0KqdyVG7MIYH3fOjjd0JEsGEHkFB0m2vhkDZv1LFJ9clfocV8Pmnos5ea3qaPHafD7pftthWeFUZP84X8YdmpJpHGIIBB/1bpTTBHxFWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186268; c=relaxed/simple;
	bh=oU2uZ8ddLVgdYmu5t1M8VxC6AJxPk5gIfbjS4l4jWuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YugaNx8l2r8XPz6WF5CeMphPllkdbwOWNlMeJc4GasJBnADoSb/c5TLfRCYXp8S7Vbom4WQ6Tjn/icWb7LIcRV0sh9E2axoC140Qbz9xtdYRqoh36mapg1T4G7912sqU+ZU9js13H/rhYyHmMeqG40S7FWlWIpaGPpg0zekIjE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWKUjuFv; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWKUjuFv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776186267; x=1807722267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oU2uZ8ddLVgdYmu5t1M8VxC6AJxPk5gIfbjS4l4jWuc=;
  b=nWKUjuFv1Hy2kR7+vpW538ckdMgjJNtaIeB0otTVozJPBSAsOh4xqepk
   MRXuPCcs0OwQF1G6IPntOgog3RrgVRFWuSZcIx/f5St72+ScEXNRqiuvt
   ulFWfSEeny9EtxymwEvnmCmS9Upyb16bVm9dPHH0bYArqY4mffFW2iDjB
   TyPJKP0BE5oRFOmYTQN5njCuef1y2AOrw8KkrgA+Dnvx3WJZ9wSLu8iWZ
   a5Cw3/chC78AOLtb/sVpJuwntnxgsLyBCozSlLIdFPUd4gomjPj9P+qK3
   tkIsXC+dS7z7K4pZsC4Qzt9NAD/eQKxf7yGMQTMbFUXQFPysPi1kuT4TZ
   Q==;
X-CSE-ConnectionGUID: Ahrw8vvDR4ORxuw+QORRNg==
X-CSE-MsgGUID: Qx4LOv1dTLqdb3QRIcdZSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88532338"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88532338"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:04:26 -0700
X-CSE-ConnectionGUID: StEqJjI8Q1aTpfLa4P5q+g==
X-CSE-MsgGUID: /3XzM8+oQviELCRmjvSPrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235108051"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:04:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:04:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 10:04:25 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.65)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:04:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buPmiZjcnI1LItQSMWMwtYh05QCIjnTdLBBaRnQfaX7gIUr2+dMroE9KZKEMFu3rrEcS6ysPntQWH8zxCYQowUMAnjtwmnvFUS5MQsYes3HnbHe91lHG8JZmcxJNmzFkm3o5/NMmsa/FClRVvEEHgCOD7p5xoYRMRGlTVvOF1QzsTWdt5hVwa78hwRkNppO7tmpVqhlaSqT64eqDOh5v9r9bq5P+6SqeUo/BVccdo58z7h3Pyx54XfwQtXkWham0TerwCkMA/TfL+YdusnRRPGBOiQUns31YUu/rncsx+wc0okYlMHEq0hE2a74vxUnSYUIP32U+Ad45TGhnItXbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oU2uZ8ddLVgdYmu5t1M8VxC6AJxPk5gIfbjS4l4jWuc=;
 b=nuYGeZxteyWhM6jXdot6TNFqucOqRTYLTYcc0jMNzkEooQnKZPk57UnoMOiq+84gXm96sEJeoNb3dhvIrkABvHuoAg6KEsb7pLIyjhjvc0x7A3AwZuquRX6ISRnumhKFvKnNPAGWag/Xi6tCb5tfhDM88p29XwRXwvEbsjXFJNPjnuC6Rj+F8narAbpggDbZnwKNtNhIaDm0PoCCbUcFIVc4m1QEleaJUIAxDTgtFXHBtoXfUFJvKVJSEJlNLhHhiSGbvbFo1hWq0V7fgDdKJ4NpHBANWGOmJF5Et+5AKl475C69hZiEC3bF/Y+yx5+CDx7ST5u+bDGnIbDfGluKwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB8049.namprd11.prod.outlook.com (2603:10b6:8:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Tue, 14 Apr
 2026 17:04:17 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 17:04:17 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "sagis@google.com" <sagis@google.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [PATCH v7 07/22] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
Thread-Topic: [PATCH v7 07/22] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
Thread-Index: AQHcwQv760r5QFBQl0WPBB7rsa+7hLXZEY6AgAVUoACAAHktAA==
Date: Tue, 14 Apr 2026 17:04:17 +0000
Message-ID: <12b12eb3d9701879069b76e0e6d14d70e30543d4.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-8-chao.gao@intel.com>
	 <91f8645bff41f5b28bf964b215429b8c7ad53715.camel@intel.com>
	 <ad4N6giqSJcnZ/o6@intel.com>
In-Reply-To: <ad4N6giqSJcnZ/o6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB8049:EE_
x-ms-office365-filtering-correlation-id: 38ca8746-b0c1-4d4b-3155-08de9a47dcd6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|22082099003|18002099003|56012099003|18096099003;
x-microsoft-antispam-message-info: uKJgaTQLO9ealjH65ojO5ljdmH18ooz3uqkE0cuYMY9xvKJnMN3LkWa8ZS/gxD2lwCHnNldOA10oVABkcS2WuHC/EC40YM6FaHtccSis9Ge6GJuvKKFAAnClamyMC/9M/L812HLISC6wfy1OVJ3SKlWQ2IKZiekDHVhK+FtDbFi8P2EGsf/+tM+0jDJ1cFKE7fehOdoQ2BkfHdTNEABsvJHBL9X5fO+97MrZCQoS15UUpMAYx5l/FyN1l+ygw52R0kAHkqJjDoFiHtNbTvkoFnn/DIjV7xZckkF1fT1g4GQuC7L44bGwObxOxvwMGNDaWo0CohLvnSOvWyCRj4a3Y/0XZdX+31ozV0d4wz4dsdVICHg0JkrfjFshbXuLOu2+0mdmz9ViE8MwWyqRg1nh3v0xIXM8Y1EsaRxP/+ZJWCNB7EVSve5PmuQVGG+hRWCTXd3MC6xj7voKBbSupXSk3/NBf+PELu+DpQxTIJhbMnziXmME/8D3GFzPHzK/KdSYljFb8oKE0xPzE4rXB4m97KgMa3lTblsJj/oFm0vY802SIi79VvN+7DWp8Lg/9yWUBUw4+dG8vuC0EhA6ASoG9uj7TYBQjnkfk60ZTM63xn0PJSdth0e4lc2x76qNdH0MjTjo6Fvw73ksWfOGptqjhUCBgjTg4jidLrQ1CWWckFbYGD2s0JH0DhIWGf3yLRfstZUMR0ze6gQFQHkD18nwIiBrpwjTEyoHgNRTfOJHV7P6/sLldFfp11+vgQN4u/LEQmTscbylY6KsblJVcL8015Dq233SujhHMVCXjBlo2wo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003)(18096099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU5YWHE1Y29GeTJQZFQxT2QzWWVZRExUa1MyYklOOHhlL0VMZDJLYW9xaXZH?=
 =?utf-8?B?WjN3Q1lNYisrZXRLWVp2M1RiUUtjKzd2RGZYSXRWT0hiei9vd2dsek1pNkZp?=
 =?utf-8?B?dllqUHFYWkpWV0tpL2txTGRsa2VCekt1cnptUUVOMEs1Wnd2U1VDdUF6emV6?=
 =?utf-8?B?dTVWVkIyNml3NlNGZ2ZYT1YvVjFFcVNic2pVYnFRNUhueXFOTUVKbkpBb0dZ?=
 =?utf-8?B?Z3dlM2Ewc3l1dlZwYjN4WVVWZy9BOEFOR0Q5R0xCRlpDZE9XWWw1aXI5ZDl3?=
 =?utf-8?B?U3lzUFlqT2VaNnV2MkVMTXJ1QkFXMmo0SU55MUVpaUZNb1dMckFOVlU0ZW5x?=
 =?utf-8?B?U2dBTzBWenlCOUtnRXJaSmNaR2ZHZ0dQOGFjSXZCUXZTc2o0eXZNNHF5MHVm?=
 =?utf-8?B?NU9Bd0pJRk5DcTJHeHR4Uko4NVExUkVBd2NEL2VlWk5GalREdHVWY25PTk4x?=
 =?utf-8?B?dEVSektYYmxRT0dGQVIyTzdSRmpqOTlBY012SUx1dlJLbnZpeERzcXo5ZlBP?=
 =?utf-8?B?c2c0eWM0N1VvN0NER3lrK3lnZkxIa1JoeXF5elhUcHdRUWJGNk1xclV6YUM3?=
 =?utf-8?B?bm10ZGpCSG5pd2IzUnB2ZzBBTzJGQnZYTGlqcFNkK3JXTFFNSFBvQmpVWFQx?=
 =?utf-8?B?OXhPUTY3ZzR2OTZiVHRrRDBPMHUwbDdrWDVzcTZiOUhLSFFwYnBuWGhFenRa?=
 =?utf-8?B?eWlmekpoRzA3bEdmS29DRm1nSTJOUUxhQkhOckFEVytKYVNaMTVWSUk0Q0dE?=
 =?utf-8?B?YzBubXgzelFJazdMeVFjQmJLakFaUFpMWmpxenRFRkQ1N2owRVBiU21IRVVt?=
 =?utf-8?B?WXd0THpLV2t2ZEZEOEZaZWVONjhOdGJxNDRlMEhWWWx6YnNxV0xieGtBakE2?=
 =?utf-8?B?Z3hDQmN2OUtJcnRyQ2NqOTFqREdzWld6UTM4a053V1k1TXZWdnM1WkE5dTAr?=
 =?utf-8?B?ZUFTMGNXbnkvU3UrWEVOTHZUNzRDMXhucGlPbGpiS04vQUo2dXR3S3RoY2VC?=
 =?utf-8?B?RjIrZFVwRnMrdGFOSXEzZFpwQ3NFZERRRUx5ZzlhMTdxYzFZQXpsc3RJWjQy?=
 =?utf-8?B?ZHpENjFFaWo3YkdqbjdaWHg2NXpLand4TytMMHgreUExaWRKcHRoZ0pjU1dJ?=
 =?utf-8?B?a3RVcks3eldEUGZKMzdUdEI4NEVZRzFENE9HNldiT0VSOStOUnd5MTNiZUUw?=
 =?utf-8?B?RUE1MTdmWm5tZFc3UCtYYXRmOW5TZmNHSHV2ZUFMMi9GVW0xUGptY0h1U1Bj?=
 =?utf-8?B?Q1R1TnFheHp4QlJzMTRWUXdPV3V4ZHF1Nit2ZmdxMWFNNkNRNlRBN29YRzdE?=
 =?utf-8?B?dFBvMTFTMlNhUm9wTEF5T3M4azhOaW1xR1BLQlZ3aUdyZEowU3N1aUVhK2cr?=
 =?utf-8?B?MTVVOUM4YmdUNk1CUU14YXhva0NsZk9icENrZGs5WkIzaTdHdUQycG1LQnov?=
 =?utf-8?B?R3lDK29nbUgra04wRGZzS0g1elVKVXdwejlWMUNlT2NvMnhWUFM2QXV3cklw?=
 =?utf-8?B?R1RUZXBQTmxuZ3NoNVk2akNyd0tCMHpxdHRyWHkyNVNsRm00eFNOQUFnQThv?=
 =?utf-8?B?amRNVmorNmJjOHo3NVFHeGVLK0FTOHhvUGlUV2FKODZNVTdESXpXVzVMalhv?=
 =?utf-8?B?bUxjcDdMT1ltenRrZExPYUpndWRHRUZaN25wUEZ4TGVGem81T25CWUpMNlps?=
 =?utf-8?B?QmdSaDhSTy9yT054S2VVb2lFVUF2bHI0WnBDU3dXOWJJM00xeFRoQjUwZ2M0?=
 =?utf-8?B?aDc1WW9EM0kvVWlRenRxNFpyRXlpcUlsQ2JvdkxaOVFpc1NYOW1SNXdBQU1m?=
 =?utf-8?B?UFJFYTAxNU5NY3JpUkhqaFR5bUhRdjJ6a3ppRFBkeXpJOEIxRkVaanRhYzNX?=
 =?utf-8?B?Z2NjdnMrMS8yNmw3Z0tyNHZXQmhSTUtMRTAzaU4zZ3pLdWYwZzhVZFozREJU?=
 =?utf-8?B?R3IwZlJ0QkJxaVhqQksvbHgyZTZWRlREdjREdEJhdmNBSndiSGNwb2FnUlhE?=
 =?utf-8?B?S0czaXYzRldpZGNNSjNRa3pqOE1DN1VVRnBhWUo1eDllQmovMzJtQWFTdVNm?=
 =?utf-8?B?djFBSEdJWHgrTnY1VG5lM0l5SkkvTjZTcTEyblY0MXBpd0twQ0xpQmNBOFBZ?=
 =?utf-8?B?S3E1RkY1aUZqMVB4RlpJOVpPalJHR05lbXVFbDhCVmIrU1BqNlh5T0h2MEY4?=
 =?utf-8?B?NHlSWHhIQ2t1WVBrdEZMR0tqMTRia3B4RGxDL3ZsWTZoR0poOVpWbVFWSXV0?=
 =?utf-8?B?T0hOb3IyZm9sWXZITU5ObDhHN2x5NUV0Slp6NlRmWmU5akpnMHJ0RFRyWUhu?=
 =?utf-8?B?eDR6NS8wSXNPbzFNaFBqejhrNGhteFBzLzVpSlo3RWFKSUJkWUhKQWRiNHhs?=
 =?utf-8?Q?YM5e64Guv2jJm37M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF7961DAE4040748995AAEF2BF6EA5ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CGLDoxseTSIk9oqzncTilo9EgyAEFmFyXvPkMsSZknKXerJycoAJ4sTM//tunMY6Vh1osFu9DumXRZU7qrVNF0ufhxCWQbfoMnvDMzpDWCqFviW23xZaGa+qsvXDNrzbYm+hzWBNn/Lpr316qf4ZQKRDqY4VZzUNR2VqwpHJopZoMcgGXW8G6I/77/e9Q/X7cAhAfDLHvgHoRUuwhB90Iz8NtJYU7097etEIH1OH+ekxFuN0z+sVjniSGeVbW8OC+vZ1tFli4vpgZH23xeRBWkeaukCOA6MBpbQsMoRRxRJ+XQtLR0H2TI3nl1AUH2CDOLbS565t2zS2ZkYScdzXeQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ca8746-b0c1-4d4b-3155-08de9a47dcd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 17:04:17.1024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6sHSk7kZ84pl1nBiTfS2HzBTyZ+nOUEjd8FHwXb1n9EUOSqdSnuqXUIj6arJ4sCS4//t3MqOiCbRYObCHB9UvlviLMm1mP9VKLusGnssBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8049
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTE0IGF0IDE3OjUwICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiBJ
dCdzIGhhcmQgdG8gcmV2aWV3IHdoZXRoZXIgdGhlc2UgZXJyb3IgY29kZXMgbWF0Y2ggYmVjYXVz
ZSB0aGUgZnVuY3Rpb24NCj4gPiBkb2Vzbid0DQo+ID4gcmV0dXJuIHRoZW0geWV0LiBXaHkgaXNu
J3QgdGhpcyBwYXRjaCBqdXN0IGRvbmUgbGF0ZXIgaW4gdGhlIHNlcmllcyBhZnRlcg0KPiA+IGV2
ZXJ5dGhpbmcgaXMgaW4gcGxhY2U/DQo+IA0KPiBHb29kIHBvaW50Lg0KPiANCj4gVGhlIHNlcmll
cyBpcyBvcmRlcmVkIHRvcC1kb3duICh1c2VyIGludGVyZmFjZSBmaXJzdCwgaW1wbGVtZW50YXRp
b24gZGV0YWlscw0KPiBsYXRlcikuIEkgY291bGQgZWl0aGVyIG1vdmUgdGhpcyBwYXRjaCBsYXRl
ciwgb3IgYWRkIGVhY2ggZXJyb3IgbWFwcGluZyBpbiB0aGUNCj4gcGF0Y2ggdGhhdCBpbnRyb2R1
Y2VzIHRoZSBjb3JyZXNwb25kaW5nIHJldHVybiB2YWx1ZS4gSSdkIHByZWZlciB0aGUgbGF0dGVy
IHRvDQo+IGtlZXAgdGhlIHRvcC1kb3duIG9yZGVyaW5nLiBXb3VsZCB0aGF0IHdvcmsgZm9yIHlv
dT8NCg0KRWl0aGVyIHdheSBzb3VuZHMgb2sgdG8gbWUuDQo=
