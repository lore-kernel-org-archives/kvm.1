Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F235F60F;
	Wed, 29 Jul 2026 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360077; cv=fail; b=Em285YpySfnvsw/yUYOtsOOgurZ+h+e4gBsUoQMHk1gosBxkuE3bM3uhimINuh0X8mdbyYOGg/tyzdoqi8HxaA1VxtbFrq1juS+4UBE2WZ3DbYj8mJhEQUQWjXchLEi2I7Nt9Uoo60tJwCnoVSry7uphIQ+BoyZ5mwdiWfTvDjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360077; c=relaxed/simple;
	bh=ryxTNOuVu1S5tRzc7vxgfcbJwxgtyAhEXYFea3zsA3A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Niq7Gn6wLPrMCNzU9EoAqziNAI0mnEAJtoQn80GLDONvl5nE3tYkg7q+a1dDsOO1OucEFSEEoRQOpxjkolwN1/ZhK+mPkVTFahx5IbD2phnfRpzVvv6T9gPjN8LeFdRkUPMz4FZtiknRaWSAeyhz23Aht1/bgisaBE99f/a5w5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkH1Prim; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkH1Prim"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785360076; x=1816896076;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ryxTNOuVu1S5tRzc7vxgfcbJwxgtyAhEXYFea3zsA3A=;
  b=kkH1Primjy5L6iq6i55dMLeY9Ig70vyANqDzfcvVkB/6PCpPDNGRcfhh
   zoKdvPs0Fshi1yflAvqSX2iE54clzC3SEHcaen2ny6gVSkQJ6x5omMsaG
   6MaNB6Ojs8QFjNHoT9o5Egu5gWSjtbSF5ZbMh5KMYkj8QFiuNPbevToHR
   T3uwzg9f2wjZLkzynBqeH562FHlV0C+oo+PM4L7/QQgRio92QWYdIXAIv
   P/ovOzQfgA3WYb7yb5K8p3Kdr4yQlooAp1iL/IfJxnC2kVmJ3dGXNTvJt
   6FpvoStlEm6MiuREn+DaMT/ule7LekRa548qyIuE2i4NraY6Pz5/JGWls
   Q==;
X-CSE-ConnectionGUID: y1YFOJFmSW+NfRufkL8RIA==
X-CSE-MsgGUID: IOIy9XtDSLyqIlMxab9FHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97490447"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="97490447"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 14:21:16 -0700
X-CSE-ConnectionGUID: PYR057L5R/KGh0yukiC2Vw==
X-CSE-MsgGUID: J+IRqLm5QrehxirbqeR2lg==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 14:21:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 14:21:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 14:21:15 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 14:21:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4SiUFjc7zrot7apj9o2H75w8TPFUc+3H3e7PDkMbTHJAElbn8/oPdr3vr0pTUBfnLIwKETbBYSQNJIDhAbiTRt9q/Wtqe+R0NejXfSa4jWjIB5R5DPForVqrqFRS8ecz3H9x86svyvCUcMmpD4A+cgcxs6GYJeGIC3TYcDbK/eZXJ3aQ0LUrwrzmLRJToE1z2mTBQ7kMmPwG0+vCt81Dgs4pF0MmlxYiWxKik9r4UKDR3LFVe5SXI4uUT6iptKdRt6djU4/MlWTJQIXz8NyKx2jSIsv5pnWdfp92LyViZCnPopg780nx68IS7JeWgpkDRea5xtSdOR6DgyCfGqFcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryxTNOuVu1S5tRzc7vxgfcbJwxgtyAhEXYFea3zsA3A=;
 b=m6cHVVx6uEAt7qVTilr5bTknzX/ooxqvAQljZWcNJLPKVNHNEtc1uZZok8xvRWr4EsE6ASwz9dqgXxAUyRt0kjE7bzQZKbgjTeWYARe85/x7blH3BMo7NYziP2Hq/RpQMZjDNAEBuwvT3hPD9js3YPyS92YG/m6/c6GZQrDaG6Xfyn9WHMl8xinujE44XV2eV4gXF+m9Ad+zHZtnZhqNCUqyjNtgSRfZ37P3cjltyQiKElSshOmjRiswJnYNw+OTOp+xgFMZnztb8sw8jPztHhoa8+vTYjdB+on5HoM+ElBg7Hycf46Ab7i78+ymOpLrhXPe1lGEUQ7GNdZY8O7nwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA1PR11MB6419.namprd11.prod.outlook.com (2603:10b6:208:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 21:21:12 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 21:21:12 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Fang, Peter" <peter.fang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdH1YE/ME7/hSMIEe/+GB5P8Iam7aFAbAA
Date: Wed, 29 Jul 2026 21:21:12 +0000
Message-ID: <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
In-Reply-To: <20260729122939.1340412-1-peter.fang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA1PR11MB6419:EE_
x-ms-office365-filtering-correlation-id: 95da1fba-f5f0-431c-0af4-08deedb75107
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 267ITwLYWdIqbbya+iSthNm9119uqUwK3w3ZzTicT722kLqJSAQQzSblPZzedm2ly/Rs2fV6bdcbdwhzPhTuCFJ8/r6lS3nP4FAG2v3hXXBUMaUFi3SOpOPR2C2iTovJiN/vZJdFgfW2nFGjd3GhfsT9r7QJ//9WUgsT1XOaPu6FItnfAGJVR45CP6EINU1/t7ZEaAWcuU7n70OTIiqaPH7kIAk7jivhYRcVm0whONAwQbWRcyLtdfhGYT9yAIRP98NOVTEgS8EMfwQtlbfdGzt5Mlfl0xiTgblE17did/6Zh6cEne/IBzkxt+eAelAQWH4FKsU3mmFGXaJKnoYn5yu7D0dLCv2cX3D6LohrvLOE2dIu/F4zMzF5GRagXM4i1LCYENTyfUQQGYavOlwoSDIcwVMsK0SBGMCueo/bOEW9sYGEm1GsXeWqOruHCspcUkRrehxlOfD2RT/69BVA3qbi1L3oFU4lVDuvrxx7vxiwXysFPaEMuJtCJ7DxAyrbCf5tRjRIP6IAE/2BYBitg3OComVfn17fqmxmwotx0wPWh2tlDy8HGdra+9NqLQBBAtkZEWpjHNFz6QlCYpTmsbyp6M+GoUzPflOPOpiEuswbKt8PpRpS+GA6PTNMMd/8eo0wbgnRA1zeZxJlY9s9JXUXkYQfc4FWNeobLzaIUWm217QeQK9qU3zXUSBESdiU5fBSxZk72jCDBG6N1tJqAKNBfmV2Yi4VN37mv4a8d7I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3o1MFNNc1N4Ti9jdWxpeWk0cCtWTHMvR0xxelczYko1VnpkWUoySWIyQzVZ?=
 =?utf-8?B?VDhJYTBqTEJXckhYTmlOeXg3eUg4U2dWNi9oUVdCdmlSRDRlQ0k0ZkNaaEhx?=
 =?utf-8?B?enR0ejdta0pCbk9sTEUySjZQSDFJM1VHQ0RHaGlUR1laeWU1dkZ1d3dSWFQ2?=
 =?utf-8?B?OEN1ZXpwT0svU1NhekljRVlxSG9FWWlOZUluRGhSd1NxVnFHeWJwcnR4RDEw?=
 =?utf-8?B?YVplRTFPTHhxUVV6VFJ6SnJzZlFVTDFQWkRtSTNUMHZJZFZHSjg0cmVzOGxC?=
 =?utf-8?B?YlBtSXQyZ1Q0dFVWaC9OY1kzaENTaVFON011ZGppNmlGWjUvQnJKVUwzVWdU?=
 =?utf-8?B?VXBFOEluVkltTVo1SzBvblVKVTJ0Yzg5K0JHcFc0WmpOMWxjK0lrR3BWMUJ5?=
 =?utf-8?B?S28xd3VZNk83cFJLZWdEWVhJRlR3N244SzZibUUzSW81eXJaQzdnRGEzL0ZW?=
 =?utf-8?B?Z3NtL3FjOUY1MzNiYURYdHBQbHhCMFFEZ0c4d0N5SDNtQ051cytqejhSMU1P?=
 =?utf-8?B?RDZzZmwrQmlzWE5tTjhLdU16V21qZmtuTktVakhkTjdEYTJ4SDZ1VzVUSGhq?=
 =?utf-8?B?cHpDNmZiRGRPU3RQbmo4VDVMbnlqVWF5VVNKOFFJV1dTdkdaY2NyQ2FZVkxK?=
 =?utf-8?B?NXloTGdiUXZienRQMFlSZFNUVWRkMmZtZXZyWDZOZG1Ra2o0SmxNcEV0SU9T?=
 =?utf-8?B?Q3Ftd2d4SktLT2lzVHpBY014bTZtbjJkOEZVRmFTL0lvcVhsMmtxWnlPdjNM?=
 =?utf-8?B?Q2NvMjh4ZzFpV25PSXo5Mi9GV1pZRmtNd05ZWEhweUdjckU3RnA4QlVRUGtO?=
 =?utf-8?B?N2ltRnhoK0RQdTZqSFg5eG1nWlc2ZE9TUnVVbmkwTFJrc2tLdnQyV2pWNWll?=
 =?utf-8?B?dXJtT0h2VFIwb2w3SkJYWkdPNWlFZVQxZHhzc1Q2QVpHQXhGS3BGVkZKSGZy?=
 =?utf-8?B?UGZ5M3pSa1hxSW1LSmliNnJMdFo5WVpZY05Rby9lWFhDZ3l3SUFPQTFmN2cv?=
 =?utf-8?B?UTdiZ1BhVmRGMVh6c1VQS2RhREZCdXZJclNHTlIwcEJVaHJXOFpGN2N6NU1T?=
 =?utf-8?B?T2pyUjZLZ1NmNlF2TVNDaFd0dnFzOVdRcWJwRVprb050VzFyeW96NStQUG5v?=
 =?utf-8?B?cGRKUzhuWjlZZUtqTTcvZk9EM21KUFpkd0JtYjRaZmxBZUF2Uyt3emxjanRX?=
 =?utf-8?B?dDQ2KzcxNDFnODM5OGpTRm9QdXFvS3RzckM2bnhHY1l6M0FVQjJMbm9FdXYy?=
 =?utf-8?B?ZUZTVlF3Y1ZKdlFwNkxCN2QrWjhyOW1zcWJhbHVVcnltRjRmdXZhYkpwc1cw?=
 =?utf-8?B?blBGdmd0OG4vVFhDUnN0QWNjU0g4b2RPL1ZDNnB1VW9aYjZHVEY5OXhzM3o5?=
 =?utf-8?B?dUVVRkExU1NpcVJ1ZVFhd3ZqWnZrL3QxTzBsc1FDbmhzVjBHN1g5aGhtbTg3?=
 =?utf-8?B?WTdlTDhNcjk5K2IyTTJ0aEJkWFAzTWZDTTczWTN2azNhdWlqYmZTTmNGbWVq?=
 =?utf-8?B?dDJSUGFGc0dvWU42NTNTcHNTV28zMDN2Nk5zcURwaFN4bXBUTW9KN0xTZFJ4?=
 =?utf-8?B?a29GOEphTEdkTEJsd2hZSmczRFZpYUU5Y2lETndybHAwV1NaNmYyWDRWb3lr?=
 =?utf-8?B?eGE5Sk9INUUvMTRiQnphTmxOc0FCcnRGNmx3dzJVdUdPRDl0YVo1SzltVXpz?=
 =?utf-8?B?Mmo5S0hDWkxpNUdjejZvd3Z3UGdzRUJpODJrN2piWGpXMkwwT1YvUURxbTJu?=
 =?utf-8?B?MjZDM2JONUgxZCtQaGJ3T0xPeHlqbEpEMmFweFZOdEc5SG02dXRJYjkrYUZi?=
 =?utf-8?B?MGhnR1B1SWg4cHczeHd1UG1zeG95NWx4UFBsakFSNGZzSXZBVzlnY1VrRGFt?=
 =?utf-8?B?Q0VRdGhzMWtOWm1BUkNwWHRWRy8rd2lIQnJiQWdhWjU5Zzd2bEY3UmdKWHZ3?=
 =?utf-8?B?em1sY1NxTStQMkJkTmNuUUVlcHltalhGRm9nMXpOWkRYN1JLOWszM3BrUEN3?=
 =?utf-8?B?QzJaU0c4dzc4b2tyNktVYTZHNnA0Vjhacm1RWnQxWGlwRjVWSklhRHZTVUNv?=
 =?utf-8?B?MDR1a1dJdnVxUHFqWGUwaldwcjRFajZTV29wL2VGbjdRMGZIdmsySmdNTkdU?=
 =?utf-8?B?NUErS2FoSHM2Z1RzOURLVVRhWVVSYVhZQ29kT1BCa2loYVo0cWFvdGxORTIv?=
 =?utf-8?B?em5WK0dkQXFzYkNBN2lyb09sK1YxZlZ5eVFKL2IwV290NUJxbm5KeFJOZWJi?=
 =?utf-8?B?ak5EV0IvVEVYSEY2VzRJRURsYi9nbGtXc2l5c0F2TVRsdkozZVhKR0VTSXcz?=
 =?utf-8?B?MUE1NTNwbWhCZHNGY0N2YnNLdnVpa3JLd2lFai9DSXZnOWdpUDJMUDFqOExq?=
 =?utf-8?Q?Iur0rQKedeQoMabo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A2A3FA6A3DA1C438D0CF8A20E8D15FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tQnCmc7ba/NXSwydk0BCzAFAWy8dCL86Tm8ncnBfhk5+VIT1K0EaRzoef2MWxFuJ4oV7KEGu02KdlHFYyXjsIZcqtIM/jTf3KGPJQKkDMHcob+xd6CF6k36h5soRaBMxvrwE5GnEWikuG+r9VYjmHEEhfTLQypFIwyBtgtlnhlWIVJjdwZ7jVT29iWprEDig4BSjA3wFVyeRkqOCGq5hJXMkNKszvEYahZ0FIhSHhqkFy93CA7cy78jLBJpNKDLUm5yFPmjQzqpNBhlEpnl3x7mKzR6eCF4a6yfNBS40/3H1jxf/Ty91szP4lWNkvWKOV5yUE0Dra6vulI4AddmXwQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95da1fba-f5f0-431c-0af4-08deedb75107
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 21:21:12.6764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BqWw+26WZVkv9adQQWfi9wopA503O/lEEhhkR7TAik6Z1BzFizQivpoi7VOkVaE48EOpxQGgwKPixxBGH0/88/lJ4uh8I3VP0XfGv8g5AfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6419
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTI5IGF0IDA1OjI5IC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiBQ
cm9ibGVtDQo+ID09PT09PT0NCj4gDQo+IFRoZSBmaXhlZC1zaXplIFF1b3RlIGJ1ZmZlciBhcHBy
b2FjaCBpcyBub3Qgc3VzdGFpbmFibGUuIEFzDQo+IGNyeXB0b2dyYXBoaWMgYWxnb3JpdGhtcyBl
dm9sdmUsIFREIFF1b3RlIHNpemVzIGFsc28gZ3Jvdy4gQSBwcmV2aW91cw0KPiBjb21taXQgWzJd
IGluY3JlYXNlZCB0aGUgZ3Vlc3QgZHJpdmVyJ3MgZml4ZWQtc2l6ZSBRdW90ZSBidWZmZXIgdG8g
MTI4DQo+IEtCIHRvIGFjY29tbW9kYXRlIERJQ0UgUXVvdGVzLCBidXQgaXQgbWF5IHN0aWxsIGJl
IGluc3VmZmljaWVudCB3aGVuDQo+IHRob3NlIFF1b3RlcyB1c2UgcG9zdC1xdWFudHVtIGNyeXB0
b2dyYXBoeSAoUFFDKS4gUFFDIGNlcnRpZmljYXRlIGNoYWlucw0KPiBhcmUgcm91Z2hseSAxMHgt
MTV4IGxhcmdlciB0aGFuIGNvbnZlbnRpb25hbCBvbmVzLCB3aGljaCBjYW4gaW5jcmVhc2UNCj4g
UXVvdGUgc2l6ZXMgc2lnbmlmaWNhbnRseS4NCg0KRm9yIHRoZSBESUNFIGhvc3QgY2hhbmdlcywg
dGhlIHJlYXNvbiBnaXZlbiBmb3Igd2h5IHRoZSBob3N0IHNpZGUgcXVvdGUNCm9wZXJhdGlvbiBp
cyBURCBzY29wZWQgd2FzIHRvIGF2b2lkIGNoYW5naW5nIHRoZSBndWVzdCBieSBpbmNyZWFzaW5n
IHRoZSByZXBvcnQNCnNpemUuIEJ1dCBhY3R1YWxseSwgYXMgdGhpcyBjb3ZlcmxldHRlciBwb2lu
dHMgb3V0LCB0aGUgZ3Vlc3QgYnVmZmVyIHNpemVzIGRvDQpnZXQgY2hhbmdlZC4gU28gSSB0aGlu
ayB3ZSBzaG91bGQgcGF1c2UgdGhpcyBzZXJpZXMgdW50aWwgd2Ugc29ydCBvdXQgdGhlDQppbmNv
bnNpc3RlbmNpZXMgaW4gdGhlIHJlYXNvbmluZy4gRGVwZW5kaW5nLCB3ZSBtYXkgd2FudCB0byBj
aXJjbGUgYmFjayB3aXRoIEtWTQ0KZm9sa3Mgb24gd2hhdCB0aGUgb3B0aW9ucyBhY3R1YWxseSBh
cmUgZm9yIHRoZSBESUNFIHF1b3RlIG9wZXJhdGlvbi4NCg==
