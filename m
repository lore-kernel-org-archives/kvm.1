Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF0D2D23A6;
	Wed, 23 Sep 2026 00:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790124443; cv=fail; b=R7jw7GwKMkOuEGPTWFq2mNM2QRrB4yNka1J8b3GolCHCntuEh4Ths4SpTSuYp0vgYJUMkgye/lSHYaRGcOp0zau5eVdujg5iafXeBACYrBmvNo+Z+D2Kp+p77obRhQfpaORFzePXIwK2QoIkrCilnYCfuPu60u/0MwdxeXL0mUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790124443; c=relaxed/simple;
	bh=7sItGaeXNX0EN1V0UAtZSQnjY5fhQUzCBsjQAla2uxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dIrbJcIap24s6vKyc7gkyEmvsjGa86Xo7TmsePSLm8H+W3smBu0YS0TByIgjSOZo+rABAWPyMHv5wFDi9eL5r+n2QMIZk0IigZcbBS8jtJh7Err1tP0sKZhUKWOk8BYBOLE9o/rEb7tkA97hKLF/bbe704u/mx380ccUnjQfjNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkzWaLcd; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkzWaLcd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790124442; x=1821660442;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7sItGaeXNX0EN1V0UAtZSQnjY5fhQUzCBsjQAla2uxs=;
  b=nkzWaLcdJ+jkB2twOXFMDuEL7jdIMvkhzqzNwHuLS9su1YIt9CdkNik/
   LInYM7Xh/bRgeybhwDv7k0CquMzaxlCvjSH+6XrY5U47dg4tU+twlp1G2
   pgNM2rmOy4ONZfLna/03kaRLIePpEI2Ma7MezlUU0UVe7ak8TANBOuv4E
   ZGUXExaVetKqzKqdSouVVLsexEV3Y8AYEKX3a0ZXYHvQjatehh7EJ2FJy
   gNIq0dKcb8POTZo1+UhvRL4YcF6I+qAwo+blDm/W3edbDJTlJGyq4bYWS
   IH1kbmLm71hfijN+4rRkl9dyhTC5Xl5Kf9uLbf2+Tal0tq5t5G1FeYxAp
   Q==;
X-CSE-ConnectionGUID: v0RS0FqzQamfHysh1TvxKQ==
X-CSE-MsgGUID: Iq/PVG7ETBytcsAoSHpqTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="93277314"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="93277314"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:47:21 -0700
X-CSE-ConnectionGUID: fx+t5EM6QkGGwP3US3upMA==
X-CSE-MsgGUID: FAEcB0CESTCbL95dWUIgXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="272568556"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:47:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:47:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 17:47:20 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:47:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vly381PORoqrGGhiEv2dkvK2KIHn7D4B+2c5QJumQb2rzd7ut0CvqgQB2zDz3Loxp7P8shJFfH12SIwW1UI4ObkYAHGpmbs2nrvzjr5sEPAV5eRmnRUfi3QA9kEMKgrJlF6ZwmruX6gacj42fBcfwvEu7QpsTAQt8MWF5Nc3MuZNGNf/Il4VFClGtDwA8cHuhYfWzajwQlvd4BcgYxBl1z0/fNZhwXjhj6apigC51RDUS9olRJzSGG+hQx+zfeoalKGF//oX9Nz1I2I3Wg4OnpcmH5UYrh7r+ZbHPu317X+z/+S5yQcSKdFauGS40+9uy5efxWgr+XIMo5j5r4bPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sItGaeXNX0EN1V0UAtZSQnjY5fhQUzCBsjQAla2uxs=;
 b=M16gFYWiMZUQeo4nCQsQzb4OdKBa8O8wxFmI+DA/TuxvRUJiiuQDJUCDVxOys/ic8Wu0BHHAGPG5RlSpwb/f9ehCb6K+Hva4JG/qJE85aISRM9xVu8OdWskr5yK8e2Tq6bCq2B+W7o9QduvOgkbXvzHxyPXZB30vsLErKukOXoC0KgcDAR7g2ziDmcMjHomAjUWKYLSXlEX346eY5+PRydWnIkG1pqkRTxPOnB0Yq4X6tcyuWjQFodsm4c/oNq+AGxhUb1RdzvV5wWLMIUC9y0Q1bvGq/4oMEghh1iuGCC/W6ca2XiWmludM0o0supIiy2/+JXgw8VOL/8IhOHBT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB7311.namprd11.prod.outlook.com (2603:10b6:8:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 00:47:13 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 00:47:13 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kas@kernel.org" <kas@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [RFC PATCH v2 00/10] TDX: Stop auto-generating the global
 metadata code
Thread-Topic: [RFC PATCH v2 00/10] TDX: Stop auto-generating the global
 metadata code
Thread-Index: AQHdR3IQ2nw8C1Rg3UiJ54WE1CaRBbbbWz8A
Date: Wed, 23 Sep 2026 00:47:13 +0000
Message-ID: <c320ac55c4e0c0e8e8d3c9c399a63f15d949d109.camel@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
In-Reply-To: <20260918132946.76533-1-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB7311:EE_
x-ms-office365-filtering-correlation-id: 4bbd1bd5-dea5-4233-072d-08df190c352e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|10067099003|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: 8M16MfK9MKL5HxZPpat22uBX4mczTsy1NUokSaftLJteIBx6GkzoSO/cRF6JVhDZJY2pln0AtzITBmXm0WM2GA+8XyFr03DYxKM8jVcEKACDzue91G9J+dN0EPsCaRfDViY1B/qALU2yGQQDDWf4qyioLGpui1DTxAMrlGQG+9hr3uPV/fFmHkFtt5qiULFTzxjRJsPFStNwTMzrqU1TE/LnjIj9WH+2AFcQrUS41niH/PD8qGdnj57ajMc7aCXM0eIaFsG2Uell+MP6Qn8T1i8BJuQwZwCclNQSfjqvjiDmHFy3wQdp8WXvyIZKb5vhNi6VqzuTjIUN68sou3bLxDWqJODum9wljxAdsDgODnJ8MWAV7pyKgR438OtYgnMH4PAF6Jjrk9FjF+3BE9v2g7aG9gJvn129AZz2GS9hbOBTm3VjWYwtmGHjlwTJZa0lCym3yl0v0x4l+yXGNHsY1vAmarETboZeaXOPN8hJCNdInMXWrl9hBZDguw7+FbLnR3e4YHgvN193NMIhAMr41sfZJrgYKTGnSIOuH8pY4qJeh5F1RtMmDfQBbxvGrGyrZzKOhcHKBbhTsnxHCx/YOa2kuUCG9Gf5FjQZtNsvBXV1V45xyBiSwrEEAppXaLBBkR5C4L3apjrqWQcOhrjHlAKL11RNmGspAwDFGuSJjYWRdj2asMNdJipEPrCizyQaDUunccEXbyqdedYgkNZpZnISOzvHvH73U3DEdalboMc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDFUT1MyNzJQck83a2tVZG5SREo0bHNBZENrOVREUUZjWGxkb2RTTkJvVXVI?=
 =?utf-8?B?T0dyOUg0MlZZbmJDSHMxZVJNdWkxVTFBSVNpbW41a0VXbFM3K0RPQUluTW5H?=
 =?utf-8?B?OVlLdFN1ejFGSXo3OG1WcURoV0hyb1VucFVrR3VRK3F4TUJsQUx0S2d1Ri9F?=
 =?utf-8?B?c01RakVXUVhhSi9DRkYwRHArUG52TDYzVWZwL2FzeTFxb3h1aUdqbCtUdWdZ?=
 =?utf-8?B?SEo4R2FGOVFkNzd1RnB0UlNoRXNqdFRpN1duY1FsRFFjOFFPQ0IyVVlQdXA4?=
 =?utf-8?B?a3dWRnRJRFJPZjJLdmVMdnRTeUlodEtVTkdMcUdsSnJVTEVWLy9QRXh6TGEx?=
 =?utf-8?B?TXR4YXhsZTV3ZDhENjdVV0wyenRMblJ4WlZidUVYYXVmTEVBcVlhUUlOZXY5?=
 =?utf-8?B?cEQvVW4zRjc5dUtzNHdFWkVTQ25SR3dtbmFWeWxyeUFRWVRERjhsOHJTSHhh?=
 =?utf-8?B?Z2pFWFFjSUVDcDFLekk1ZFVWaHlKQXBpSjdTSUFkRTlyRFhCUTUxQTlYVElM?=
 =?utf-8?B?d1VsVXM3VUorU3ZLSjVlWDYwR2JENTRyVVc0aWhMU1lZYjBxbVpZMmtMcGZQ?=
 =?utf-8?B?T3o3ajlOT3N4MGVVdVFXKzcxcVpFZW01djdWV2FtZ0ZsRHZqdVBYUEJHTzd5?=
 =?utf-8?B?ckE1WkdNK3hBT1pibDhaVCs3eVl1VDdHVU9aTWt1ei93MUZwUjFMbktmVWw4?=
 =?utf-8?B?VWNzV0hnYkVLUURLb3YyZmhTQkZCaVpWR29YWlpkQVhiWmV0Q3p4VU5zcC9l?=
 =?utf-8?B?Y1NvN28zSGgrSHNyYkFoT2ZIVG93K0FweFBJZnhPeWZUS0ZqWmduSFZsSjlH?=
 =?utf-8?B?SStBK0w2U25UVCt0aCtNVTZHOTUvVERIbmZFVjJ3MjlwSDNpMUlPQXRZNUwy?=
 =?utf-8?B?YjVFd0drRGhRTy91S0tLOGUwOVY5ZjhrT3AyLzE5VXhVbVlZVlJZQVBDY2NZ?=
 =?utf-8?B?blhibnVZdFdIQ0IvbFYxVzA2ZXdVVVpsajNndkxQSENjWEZORlo0aFhwMFly?=
 =?utf-8?B?dTZVcllUYXVrck1LOXh0WGF5NVU1M3lSbnM5Y1FRN1pRRmE5bjhUb0RxSjBQ?=
 =?utf-8?B?NUpzRUY5YlR5R216RkxGV3ZHY0U2M2xPNStyTkFxWEpNSHk5K2I5QU9kSDlh?=
 =?utf-8?B?cGF2SlJIK2Ivb0dmRlphank2dWFNKzJwTVgvekl2cUZHdHNwbXMxVTZCR0Z1?=
 =?utf-8?B?VXg5aXdKN2NLN0QyblJPODNkc01wQ0dIVklCSzc0OGlMSzRyY3lzMXg2ak04?=
 =?utf-8?B?SDg3OVZDaC81NGVvYVh5Z3lWSlQwbk1TRHp2RWJFYjZHTUJnY2VBMHdwTmFP?=
 =?utf-8?B?SUhWTzE3Ti9qd0wxdFY2bW1VdHl1YzROaUNUaTFFK0VEYmxQcDVMYjNwZHZk?=
 =?utf-8?B?QUpNVDllSG1HQXB5WWxKRWM5ZHpwZUpleFl3Q3BJT1dwZWk2ZGwxNjk1V3lm?=
 =?utf-8?B?MlJhQ3dLelA5cld4a3NNdVRVMCs4NXVCUFROczBTMTFvUk02WWk5dHZMUDRR?=
 =?utf-8?B?NFcwTWZZcnhiSWRJVDEyQTRGc3R1aVlsdnZhczhSRlV6YUlaL1huZ0hjZHY2?=
 =?utf-8?B?OGZqUGtkWVNzdGFkd1JyUTNqWE9yMHVNNmtDWkhMdFJYN3JScHhBVXJwSW1G?=
 =?utf-8?B?dVN2d0plc1haVlZmclRMbHMzSlVVaytybnluT0JZR2VoczNGQWswSjhNMGNC?=
 =?utf-8?B?bStJYmQzMi9KZjJhOWU1elBkeDFScWdsR3hud0JjdWxDRnVLdEhSenVBMWlj?=
 =?utf-8?B?K2ptSHVheGNUaEdHelJhZDBaM0taUEUvd1IvMit3T0JJeHZIb2xjcWZFR0lN?=
 =?utf-8?B?L3h1NWI5WDNnMWxVekd0b3dPTS94VkNIVlk4a2ZRMEFkOEdNVmFqL25id21k?=
 =?utf-8?B?UUQwbmhpT09RWjBjeXBSSEVqZW9ocko0ZFFLazB1eURWVTI4VXF4ZWs2TlVj?=
 =?utf-8?B?ODVZYy9nVGRYajRIR0xWV3I4KytETzlwSWhDYlI1OHliQWlBekxORHRPSTR2?=
 =?utf-8?B?emdYeG9yVUptNUZPbkY1dXdSakNnRE1ETEhGSno5L2hVU3RNdXpyTG9iZmlz?=
 =?utf-8?B?VVFWUVdSYzJmUm9IT1NuVzNxWWR4K3c4Yzh3NnJvYUlDazNhcjI2WHdmVkVF?=
 =?utf-8?B?ejY4MFhqQXp0M254d2xhK3dlRHh4Ujd3SXk5K21HMHBzb3UwellZZXpTeE5E?=
 =?utf-8?B?Z3h6YlplR0YrT1JZcEw4YVRFQVpicGtCdjJVdjJ2ZHJub2tmWjVHSFdPZGJT?=
 =?utf-8?B?Q3B4ck9HclVoWGZHVFNzVzZGcjR1Z3ZubEc0dVVVdWxHZ2d3Z0RqOHg3T1dL?=
 =?utf-8?B?cHYreEo1aU9RRGtodmJmRVdsVjZzanlQdXo3OWw5ZTNTcEtyQXduUG5lUHFm?=
 =?utf-8?Q?5wocYsCKLUb4uLvU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30CE6E266E71314F939888B304BB93C5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EOncEpGKm4W0au5EcFchAsoq7hfqOg71UJgGJv8ZQlVZ0U/vOwVbe/Qbyhoqn38+NDJaz2vBIbJ0w/fms7kbjwkrX8Kl+HiPqYxLDC1dWnEfvlxkwOYYKsbW1eZ9OIVIq5Udd0+bMEDdAaBYJoa/ishR++oNvUIlc4wCu8B3TqC6qnFvBoBwFXJGoOggBxjdUjLG4/fkYTK2QgqDLCailIKdWVwMtbLuq4cuXXalMLR7fNXZNam8TD3Hkrctbbi+PE+6j6OAmtnm+uACFZGxobOnVEeb59ibb8s2T03zydJ6otz+CwtMWaWRyt3LsXPxWHvicGG3b6Kn3UG3UDoAHw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbd1bd5-dea5-4233-072d-08df190c352e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 00:47:13.1868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61rYhsv2yLmBzKrZWls3d0dQkSPBZTAnqDV3jd5qEjy6XCFf2Poc1AQ0lk9cvS+oMSzOjvf3CA6TFSiMYFYiquqisyGyXss+aYTfALpT3IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7311
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA5LTE4IGF0IDA2OjI5IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gQ2hh
byBHYW8gKDEwKToNCj4gwqAgeDg2L3ZpcnQvdGR4OiBBZGQgYSBoZWxwZXIgdG8gcmVhZCBhIHRh
YmxlIG9mIG1ldGFkYXRhIGZpZWxkcw0KPiDCoCB4ODYvdmlydC90ZHg6IENvbnZlcnQgdGhlIHZl
cnNpb24gbWV0YWRhdGEgcmVhZGVyDQo+IMKgIHg4Ni92aXJ0L3RkeDogQ29udmVydCB0aGUgZmVh
dHVyZXMgbWV0YWRhdGEgcmVhZGVyDQo+IMKgIHg4Ni92aXJ0L3RkeDogQ29udmVydCB0aGUgdGRt
ciBtZXRhZGF0YSByZWFkZXINCj4gwqAgeDg2L3ZpcnQvdGR4OiBDb252ZXJ0IHRoZSB0ZF9jdHJs
IG1ldGFkYXRhIHJlYWRlcg0KPiDCoCB4ODYvdmlydC90ZHg6IENvbnZlcnQgdGhlIGhhbmRvZmYg
bWV0YWRhdGEgcmVhZGVyDQo+IMKgIHg4Ni92aXJ0L3RkeDogQ29udmVydCB0aGUgdGRfY29uZiBt
ZXRhZGF0YSByZWFkZXINCj4gwqAgeDg2L3ZpcnQvdGR4OiBSZW1vdmUgdGR4X2dsb2JhbF9tZXRh
ZGF0YS5jDQo+IMKgIHg4Ni92aXJ0L3RkeDogVXNlIGVhcmx5IHJldHVybnMgaW4gZ2V0X3RkeF9z
eXNfaW5mbygpDQo+IMKgIHg4Ni92aXJ0L3RkeDogVmVyaWZ5IHN0cnVjdHVyZSBtZW1iZXIgc2l6
ZXMgYWdhaW5zdCBtZXRhZGF0YSBmaWVsZCBJRHMNCj4gDQo+IMKgYXJjaC94ODYvdmlydC92bXgv
dGR4L3RkeC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyMjIgKysrKysrKysr
KysrKysrKysrKy0NCj4gwqBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmjCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNTQgKysrKysNCj4gwqBhcmNoL3g4Ni92aXJ0L3ZteC90
ZHgvdGR4X2dsb2JhbF9tZXRhZGF0YS5jIHwgMTU0IC0tLS0tLS0tLS0tLS0tDQo+IMKgMyBmaWxl
cyBjaGFuZ2VkLCAyNzUgaW5zZXJ0aW9ucygrKSwgMTU1IGRlbGV0aW9ucygtKQ0KPiDCoGRlbGV0
ZSBtb2RlIDEwMDY0NCBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4X2dsb2JhbF9tZXRhZGF0YS5j
DQo+IA0KPiAtLQ0KPiAyLjUyLjANCg0KV2hhdCBpcyB0aGUgYmFzZSBjb21taXQ/DQo=
