Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961CD4C81;
	Sat, 11 Apr 2026 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775872882; cv=fail; b=AWraGPC7JdRxhhyZqj8EyfDUu18Wn9yZxHWnATWMMehliu5IjbN3ELCQFQh4qExhV6wHshw6lvvW/wk8gOUV8NCdrZFG1ykQigRiHhmEBO8685jzzvKwt+odtr1lSgrelMwRL4rkq2dgmIvukxQ+BfemyY6HPX9+vo76hoRAPVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775872882; c=relaxed/simple;
	bh=buBqnybXCwGsMJn2WdoAnk/yq828MFW/xmjC9GguEsA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tr3G+ujymCektP+xyE5uR+IJ4ZyNM1jsRQmLiEA82nHNvtHGRR4ucejfFMXXMAKPEG96a/4JKfwtrLRIqVlftMl3LLMwMJx3VhIEytXDnV0JE1WJwdjuoa2VAil02NwxnEp1obkPwQenozn3M/MiwIOAwZwEwdYqBGXB7jJjEu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHMypMd3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHMypMd3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775872880; x=1807408880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=buBqnybXCwGsMJn2WdoAnk/yq828MFW/xmjC9GguEsA=;
  b=EHMypMd334HimOriK8Vf5Gf8z06VRSVqi8UdNZtHRiZFcg9Z/BqKDv+8
   WZEPKIIs9ldSYr/DysfHgg9Z/vLULdF6uLzaFQQQNenifHMsutdmpY/ry
   uOw+SLe6WrO+UlL9CJvs+cdi3P1/yh0k8xxUNDHhSKwUrQ916OQqNm9Hq
   vdodgSrqGoLmT4XOQsYQyjaFfUhCvSvqMupMZ1vpWjU/BNmUdwGzq7GZr
   0haE+jBfXI8TSPXx3cpls4xz6FZavNOTtGv3+aD2oQ5AMPKde65yaOo9i
   7MEf2+x/tYOQQnEK3QvzZTfrMwGV2cvTqvTvMfPWd0MnWIrSiht+tUMLA
   g==;
X-CSE-ConnectionGUID: ZqjsHGdfQfGPmvSORijheA==
X-CSE-MsgGUID: h1ED2OJjR1+beDEWHLt7tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="79481580"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="79481580"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 19:01:20 -0700
X-CSE-ConnectionGUID: 2n9B9UEWSh2gaEIQwM7kpQ==
X-CSE-MsgGUID: fJpV6BYUQQC54aXQY7zS+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="226536337"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 19:01:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 19:01:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 19:01:19 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 19:01:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA1f0ZSeTAl2bVpwXWkQf46BZBxs8HvyJbcpBtQcEuv95k5ruu0wbacvKjd3Z6hAWC3kjw2l34VVg6N63t2v4d8Eia7nWArNcPwq1gV96kdWDf3rc8tQaD+Qxqsd2fTCRZqoDyUbjr6a8/kdguhsHhUw7chVrXV84b7t06obDcGrqLJe1jt2ZSq5RPgEaCH51nQg2G/5gXFtlEfcYsdFLcgBaZWVZPPau9REzPRDT4aI8h43hf/He5Yfz5SrgyFGFzC3AYboPbAXxd7ilibTXv/XfJdK70BrAZMUpwxd0v2quDCwUMKumTTiO7phVGrB7y3YcWKlFPQDMzitryrFBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buBqnybXCwGsMJn2WdoAnk/yq828MFW/xmjC9GguEsA=;
 b=eyykIKO6OqdtyYn4rNIqB70E7jz4XG3oe/0i4DszVXbqza2YfhIOAA4qAlOdNZ63iTtSrcwivyUqCu1kglPuBRdBfoIuV1f8hDumR0mhJws8qDh8n5J+SeqyPrbSj7Kq5Kpfc4PN67UMOVRXd0r0VdUfNE3tvfobHf5WtdTfjDcGNYwLihfcJQj59eqlBAldRZm0gtzIHprywZiJyrmtWjiUEZfhFUhCKQYu76y3DojEQuO4zPcTVxJBCGwSrlNeUo5a+f0re7Ktw2bzGfFLDLikzkQ9G2wWRIuFAzPVONhyKHRTrwpp06KMPN5yoIT+XBgjwF04swLmzGj3Vo8ZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB8717.namprd11.prod.outlook.com (2603:10b6:8:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sat, 11 Apr
 2026 02:01:07 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.014; Sat, 11 Apr 2026
 02:01:07 +0000
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
Subject: Re: [PATCH v7 13/22] x86/virt/seamldr: Install a new TDX module
Thread-Topic: [PATCH v7 13/22] x86/virt/seamldr: Install a new TDX module
Thread-Index: AQHcwQwDQ7ZxyuO8zU6gEwli2EidE7XZLAUA
Date: Sat, 11 Apr 2026 02:01:07 +0000
Message-ID: <2eec98d012b85113b4e6876d07eb6513618e2404.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-14-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-14-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB8717:EE_
x-ms-office365-filtering-correlation-id: 11ef641d-1807-4cdb-4424-08de976e3208
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: JLJDvzGXGsgSVGqoPVPf7Z579/HSvm8xoffR9wpg5p0ClV+M8Q+nw9ojRCo+s8D6wQb1oNObktmWkYd/fimeUtJPj3A4LoHbTjHmPnKE3/vlyo+WXP1NvX/2Zcu6O0sSkxgPAaVnsAGN6ZBHCmcROHQUWYNkOFSgt8tEcVcHXaGCD86fbzsi8f93eINONABZg+A+BpV46X0XWmfbdi67qzHtWfUDGrF5xuEGgR9NahUZGrPBy1uB3qglD4gStL3Zmw0G+1rStPe0X3iJrh0yMALQuUc+i9281HfNHasRsZlHIoDd23gfjUCiORuKzFJ8yULzNKkFRfxOKZj4hIYZ9GI3+/W/fLvWOpbjS+/XeeRC5j1aViKzEjFYB4WFxnKsUj+Jq05iNFDeKImMp74RJEEh3UKawWSGUUDOgCBbWE7uEw43viTeYmfPQtxOL3+V7kQpd0OOSvyJhNgJJyaUGShzKjD/c+oGT/RxaUTMF6qN3AssymsS6ypP1csuKcsrtq36HPiMGUGc+44+3LtXWaZKUCLAb8N3mJ4ZnLnJZ0knE02SBStQt9Oofw9ooyCy3R/oitTJuMVhzs/w/eRaq0fDAhfYrdycewDjhVZnSShzB9LNFkGRvH4S/t+l9Q2OYWLN9GYoMEWKHLCiK8ZyqcsOfBJSfblaBoTE9Sd5ZHNCxagjnci60Yq0qMdCGVMhuJdulDNrTvpb9CHETgnOu2yfNyhpvAdsiHC86x2u4u6TdMTk+vdAo3eU0jimoQhaFMERaz6vI2qTFj7GF0+VOz307xmoe8oHfkPIFuipzJs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aENPem9tMlBIdVVVOXpRcXpta0lWZ2RLRitxZkdZNDRkUjNwNk1kRFNsSTla?=
 =?utf-8?B?UEEwSlZkVW0zaDQwelp0LzJuOTFLMU1jbkMrQzVPUjhmR0g4MHI0a05NaVls?=
 =?utf-8?B?ei9UQkxVUGh3ZEluU0JEL28yeVk1aWh0RFN2YVU3bjhubEhIeTg5Z2tBMFNT?=
 =?utf-8?B?S0lKNVBxS1RFc1VLV1pjZ0RRdFdVeXhzUmh6UEZRZFNRbWZyb0VBdzRYU29C?=
 =?utf-8?B?RFBGdXB0MGNWVldLcjBpQ20xOUhHUWwxZlZKbGFySEF6RnNodUxZWG45OVcw?=
 =?utf-8?B?VlFKN1JPSTA0ZnhhWWhkUWdYOHlmcnpIV1NjRUN4MWZIcnc3ODRIanVIS2Ir?=
 =?utf-8?B?R1FCd2U5OXk5OWF3ZkFsSmFJMFIxaUZHNW5VbzVNSU95emtkLzRMM2taT0pC?=
 =?utf-8?B?VEhOSzBoZTRYRTNyQzdRVnhuREVJRSs2UFBsOFJQRHNVMkZnM1Mzallpb2Yy?=
 =?utf-8?B?QWcrMi9lK0x2WjNRcWZkUWpTMk82UktqdzdBNktuaTFXeHo2YWh0dU1PSHo1?=
 =?utf-8?B?WkYxcXVVUDcwZGhPRjVRSDZ1Z2U2QTMvNnhRY3ZuS1ZBeHVFem00MEFJTnJ0?=
 =?utf-8?B?ZHNmcnpieGc5TEd3QUtzSEZjS09PUWlMdm5MdmdFOXFzaTg5VVBpdjY0ek5C?=
 =?utf-8?B?TmRzYUsvdWlTK25vK0tIZUdnZmJjamVabkxvOFdrNUZ4NVkvOTlPQk9vY3BG?=
 =?utf-8?B?VjNyY3lBYTltM2ZzeUpTMTNCdVZJZ0pzSWZ6TnM3ZmJYZ25uZjZlSDVVZmxZ?=
 =?utf-8?B?NHNTTVBmTzhsZXNSbTBLSDRQWktvd1J0TmNJcmtoMDA5NEdUclJBbjEwN2ov?=
 =?utf-8?B?cFFpR1hTNHh2ekp3aUwyQktQVzIvdDY5SlFkdmtUUUdvQVIxQVF3Nzg4bnlY?=
 =?utf-8?B?OEZpVHNocFVOR0dWU0JCT1lOMHdWbDFHSklnOTR0TUVFaE14aUtOdURoVUpU?=
 =?utf-8?B?emhmLzVjaXN3Z3IvRVh4UzhwcUhJV0RKbHVNMDA1NFVxN1g0Rm91QTZIbHRo?=
 =?utf-8?B?RkJYMnZNM1Z5TjJCY1BzNURxakM3NjE2djJhelJQSi9zWnEvZFhpR2FkQjB5?=
 =?utf-8?B?NWM5T2ZJUGxqOFFJSTZyU1JDd0VncFdUeVE0OWh2N1U1Y20zUVNhTVZOaUJ0?=
 =?utf-8?B?ZDV6ODRwc2RSWHZyTWVMbkYzRThVanQxbFdUREZkaXN3SHg5TXNGeGNqOE5P?=
 =?utf-8?B?cVZMcjNJdlJGMUhFWXN6cXhRZmVKTDZXbEVHU0lVY0kwdUFHdzJFeHZ0Nlpi?=
 =?utf-8?B?Unh5c0ZYams5QWZsSS9XVVRUNS9GWjg5dW1haWNIQ2VJRDB4bTFJakNNeHdi?=
 =?utf-8?B?RGRHVFB0d2tyYXExanB0L3NZYk52QWcrTmE2NWcvcDdNb0hnUlNPUFNZZVo2?=
 =?utf-8?B?L00wMHhUU3ZFMHBYbXR1VDNNSzhpUGg4elkxMzhTNzBOOHZKN0Z6RWJvT2hu?=
 =?utf-8?B?OWtDcFhibTMzQmRIRytHQkZWdGVnRlhnSU9YMGFhY24xSW9JaHVBZDhNRGdI?=
 =?utf-8?B?WTVSS1dnWDBZM3NudTZSUVlSQTJHU0o2RStINWlaRmJ4Zkx3WERRVnYySk9l?=
 =?utf-8?B?eHJZbnNzek5CakJZVnJMb2dtTFFlOFVWYUdRZUVvV056NTVMNGdaMGtlZXZm?=
 =?utf-8?B?VElQZEw1S0VOYmZGQjJQVmhpS0w5MDJLZTdTRTlWaFNnR2tXOUZGVkgyQUVT?=
 =?utf-8?B?OGJKNW8vQlIvZjQ4MklpLzlyMmI2UG1RTEFQaWVNUzFRRzMzbkluRGFCclla?=
 =?utf-8?B?RjdaNXdaOWVsdkdZanVTSjBLSGpDcGpKdldJMEExQ2hERjcvemlSOFZpSVNv?=
 =?utf-8?B?bEdsVkdYdytiWHJxK3YzSEZVMkt0djNZMTNLeGp6bXZ2ak5HR29GMUd3eVpv?=
 =?utf-8?B?QWNKVnc1NUh6T2c3aVd0K2dURHU4akU5ZkJ1cGdJRWRDQ01KRXFQWW0vYUly?=
 =?utf-8?B?Q20vdTVJaDhWdTJsTURhWXlPK2FmS0t4TExXMkEwUnRkN04zZnF0cGh0RUg2?=
 =?utf-8?B?SDk3QXpQcG5oaVlqd1pBemZrVjcvTnJaSkNnVTFQbDN5TWJBVGVDc0hvRXZW?=
 =?utf-8?B?UElTVmtjaG4ydGtWbXJtNyt1TVBHbmsvYUZGS0syWWxmN1hTTlhBK3QwMUE0?=
 =?utf-8?B?bVNIMDJIU3ZLZkFWSXBLalphVW5RSkxCYTRpcGNTRXJlZzJVSlNCMDVycDdk?=
 =?utf-8?B?akZYY1dxSmRKQmw3UUdyT00raFhQd2NmT1lBSHNocW9YbGhoRFVqcXhoUUVr?=
 =?utf-8?B?eERxYitGcVlrUEttc21NL1JMNW96aWlUUGt6WnJvb0c2M2RxNG94dUdzSTZE?=
 =?utf-8?B?QWhPck5WaGViTFdhYk52QUZPdlFXSUVmbW43YVNMTExEOHh5QlRsa1hseEN1?=
 =?utf-8?Q?fEj+P8VKF8HXOhtA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03DE60DDCC34AA40BCE3D2503D868526@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qVyVR4wg5FEm5qFhb/PM0qV2bINp4vXku1uqT3Jk3zIhQgJ2XJwXKrB7No7EVLEGCNIuYrYsR6NKgFEyNbag4PBJCzk/+u9A4b4tj/JndaSiigxQ+fGFX8/FOezuEjCKxHHiXT4tTDo4mo+QJP+zLQVHMEYr/qD/hGuoUo/eqUayw8nXw7xyL3SOfTdjPMR7xACxes8stfnilAmNa4ks152D32hIlnISqUJrJ8HFYJGmZHedD1GZ0+wT3CEzhD7O9OKOqf3yvEzGQN54RrJIa774XLt7Ak5cqHdI5U9rXttOaai2PDnsTVd/sg6ldE4o7UyqYLrEyJLb2rWy90PIYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ef641d-1807-4cdb-4424-08de976e3208
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 02:01:07.4219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBV0VV9cXgB6zC033bUycNVjHGtggKjEqsGNZbe42rS9fws0nJj4LoF8iWRq46QkuY1MaFOwz5d+e+l+/9LWecU1ZNJNcQKxnXmNXoudypg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8717
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gRm9s
bG93aW5nIHRoZSBzaHV0ZG93biBvZiB0aGUgZXhpc3RpbmcgVERYIG1vZHVsZSwgdGhlIHVwZGF0
ZSBwcm9jZXNzDQo+IGNvbnRpbnVlcyB3aXRoIGluc3RhbGxpbmcgdGhlIG5ldyBtb2R1bGUuIFAt
U0VBTUxEUiBwcm92aWRlcyB0aGUNCj4gU0VBTUxEUi5JTlNUQUxMIFNFQU1DQUxMIHRvIHBlcmZv
cm0gdGhpcyBpbnN0YWxsYXRpb24sIHdoaWNoIG11c3QgYmUNCj4gZXhlY3V0ZWQgb24gYWxsIENQ
VXMuDQo+IA0KPiBJbXBsZW1lbnQgU0VBTUxEUi5JTlNUQUxMIGFuZCBleGVjdXRlIGl0IG9uIGV2
ZXJ5IENQVS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoYW8gR2FvIDxjaGFvLmdhb0BpbnRlbC5j
b20+DQo+IFJldmlld2VkLWJ5OiBUb255IExpbmRncmVuIDx0b255LmxpbmRncmVuQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IFh1IFlpbHVuIDx5aWx1bi54dUBsaW51eC5pbnRlbC5jb20+DQo+IFJl
dmlld2VkLWJ5OiBLaXJ5bCBTaHV0c2VtYXUgKE1ldGEpIDxrYXNAa2VybmVsLm9yZz4NCg0KSXQg
c2VlbXMgYSBwcmV0dHkgc3RyYWlnaHQgZm9yd2FyZCBvbmUuIE15IG9ubHkgcXVlc3Rpb24gd291
bGQgYmUgaWYgdGhlIGxvZw0KbmVlZHMgYSBiaXQgbW9yZSBpbmZvLiBOb3Qgc3VyZSB3aGF0IHRv
IHB1dCB0aG91Z2guLi4NCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRn
ZWNvbWJlQGludGVsLmNvbT4NCg0KPiAtLS0NCj4gdjY6DQo+ICAtIHdyYXAgc2VhbWxkcl9jYWxs
KFBfU0VBTUxEUl9JTlNUQUxMLi4pIGluIGEgaGVscGVyIFtLaXJ5bF0NCj4gdjU6DQo+ICAtIGRy
b3AgInNlcmlhbGx5IiBmcm9tIHRoZSBjaGFuZ2Vsb2cgYXMgaXQgZG9lc24ndCBtYXR0ZXIgdG8N
Cj4gICAgdGhpcyBwYXRjaA0KPiAtLS0NCj4gIGFyY2gveDg2L3ZpcnQvdm14L3RkeC9zZWFtbGRy
LmMgfCAxMiArKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1sZHIuYyBiL2Fy
Y2gveDg2L3ZpcnQvdm14L3RkeC9zZWFtbGRyLmMNCj4gaW5kZXggYThiZmEzMGVlNTVmLi4zZTQ2
ZjNiZmFhOGIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC9zZWFtbGRyLmMN
Cj4gKysrIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1sZHIuYw0KPiBAQCAtMTksNiArMTks
NyBAQA0KPiAgDQo+ICAvKiBQLVNFQU1MRFIgU0VBTUNBTEwgbGVhZiBmdW5jdGlvbiAqLw0KPiAg
I2RlZmluZSBQX1NFQU1MRFJfSU5GTwkJCTB4ODAwMDAwMDAwMDAwMDAwMA0KPiArI2RlZmluZSBQ
X1NFQU1MRFJfSU5TVEFMTAkJMHg4MDAwMDAwMDAwMDAwMDAxDQo+ICANCj4gICNkZWZpbmUgU0VB
TUxEUl9NQVhfTlJfTU9EVUxFXzRLQl9QQUdFUwk0OTYNCj4gICNkZWZpbmUgU0VBTUxEUl9NQVhf
TlJfU0lHXzRLQl9QQUdFUwk0DQo+IEBAIC03Myw2ICs3NCwxMyBAQCBpbnQgc2VhbWxkcl9nZXRf
aW5mbyhzdHJ1Y3Qgc2VhbWxkcl9pbmZvICpzZWFtbGRyX2luZm8pDQo+ICB9DQo+ICBFWFBPUlRf
U1lNQk9MX0ZPUl9NT0RVTEVTKHNlYW1sZHJfZ2V0X2luZm8sICJ0ZHgtaG9zdCIpOw0KPiAgDQo+
ICtzdGF0aWMgaW50IHNlYW1sZHJfaW5zdGFsbChjb25zdCBzdHJ1Y3Qgc2VhbWxkcl9wYXJhbXMg
KnBhcmFtcykNCj4gK3sNCj4gKwlzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzIGFyZ3MgPSB7IC5yY3gg
PSBfX3BhKHBhcmFtcykgfTsNCg0KSW4gYW4gZWFybGllciBwYXRjaCB5b3UgaGF2ZSBhIHdyYXBw
ZXIgYXM6DQpzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzIGFyZ3MgPSA9IHt9Ow0KYXJncy5yeHggPSBm
b287DQoNCldoeSB0aGUgc3R5bGUgZGlmZmVyZW5jZT8gSXQgd291bGQgYmUgZ29vZCB0byBzdGFu
ZGFyZGl6ZSwgYnV0IHRoZSBleGlzdGluZyBjb2RlDQppc24ndCBzdGFuZGFyZGl6ZWQuIFdoYXQg
ZG8geW91IHRoaW5rIGFib3V0IGdvaW5nIHdpdGggdGhpcyBzdHlsZSB0aHJvdWdoIHRoZQ0Kc2Vy
aWVzIGZvciB0aGUgb25lIGFyZyBvbmVzPw0KDQo+ICsNCj4gKwlyZXR1cm4gc2VhbWxkcl9jYWxs
KFBfU0VBTUxEUl9JTlNUQUxMLCAmYXJncyk7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIGZy
ZWVfc2VhbWxkcl9wYXJhbXMoc3RydWN0IHNlYW1sZHJfcGFyYW1zICpwYXJhbXMpDQo+ICB7DQo+
ICAJZnJlZV9wYWdlKCh1bnNpZ25lZCBsb25nKXBhcmFtcyk7DQo+IEBAIC0yMDksNiArMjE3LDcg
QEAgc3RhdGljIHN0cnVjdCBzZWFtbGRyX3BhcmFtcyAqaW5pdF9zZWFtbGRyX3BhcmFtcyhjb25z
dCB1OCAqZGF0YSwgdTMyIHNpemUpDQo+ICBlbnVtIG1vZHVsZV91cGRhdGVfc3RhdGUgew0KPiAg
CU1PRFVMRV9VUERBVEVfU1RBUlQsDQo+ICAJTU9EVUxFX1VQREFURV9TSFVURE9XTiwNCj4gKwlN
T0RVTEVfVVBEQVRFX0NQVV9JTlNUQUxMLA0KPiAgCU1PRFVMRV9VUERBVEVfRE9ORSwNCj4gIH07
DQo+ICANCj4gQEAgLTI2Niw2ICsyNzUsOSBAQCBzdGF0aWMgaW50IGRvX3NlYW1sZHJfaW5zdGFs
bF9tb2R1bGUodm9pZCAqc2VhbWxkcl9wYXJhbXMpDQo+ICAJCQkJaWYgKHByaW1hcnkpDQo+ICAJ
CQkJCXJldCA9IHRkeF9tb2R1bGVfc2h1dGRvd24oKTsNCj4gIAkJCQlicmVhazsNCj4gKwkJCWNh
c2UgTU9EVUxFX1VQREFURV9DUFVfSU5TVEFMTDoNCj4gKwkJCQlyZXQgPSBzZWFtbGRyX2luc3Rh
bGwoc2VhbWxkcl9wYXJhbXMpOw0KPiArCQkJCWJyZWFrOw0KPiAgCQkJZGVmYXVsdDoNCj4gIAkJ
CQlicmVhazsNCj4gIAkJCX0NCg0K
