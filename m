Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D7740DFAD;
	Thu,  2 Apr 2026 00:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775088287; cv=fail; b=LndOFvmg4AVsfJdZwdCtU6eCfzeM7yBkBi9MqmjhtTRuLlSqe6r12xMJXLhJ3Sv5hvjR28/HXhZCMPxS6e4E0W+yhbwEgegHsYt57on5zgs7O9zEoFnNYMNyL67vaaKDfXkSqo2XNivl2iO3zhuvEIgTkTR2/zbfM4aVLRAne3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775088287; c=relaxed/simple;
	bh=s1+9e+j/DIwYlQLWLEF/xdIuRUeA0NQo/rdRFozYA5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CKiYconx8NWzz7LYNkkhD//G0dOf3fHH3fVQaeRrBnbYeTW2ofIPIiIOKXzCHlhaguM2rqg3h2Wa6gYp1TZyuDWGmW86ewgejdTU5LaeeOd7mieifRWglZZrUDdvYCyVQvrkWX8gV6bAXmxcHMWorP6Vxha50ovZSMY3dqtDqzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pdf4fy5E; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pdf4fy5E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775088287; x=1806624287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s1+9e+j/DIwYlQLWLEF/xdIuRUeA0NQo/rdRFozYA5o=;
  b=Pdf4fy5EepLv45hCSznPTda1VTRHVbwBKUOUBOGhD0wtStS8dskaGAuY
   2F7mMpdq6lwjBM54eXdGGNt5auD+hFdPXKuW+NvSRdf/zffWtJhc3Rzi5
   i6HiEp44ITuHj+46iojI5nIipOx3HNpnGwpm8lN7ATk8Yrd+HghgwqRVD
   0Xw64zqx/J/GCtMgUtWRe1J5vD340z2wTxzT81+IJmxF14kqIi6m1zZ7l
   NpcdyiQC+Eyhp0eKrDH+mOBxfQ2ErRQ4QNTnLInn0kMTODufh3OQAg0cP
   ecv5axgSROQR3XVHSbwHZ7zVpP69YO9ERPxvONrq50o61ssk1VAytDuHl
   g==;
X-CSE-ConnectionGUID: +K38muw1Q0iFLKC6TYZl6g==
X-CSE-MsgGUID: MHMnvLbyTguQLFA7n2XVvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="79750219"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="79750219"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 17:04:47 -0700
X-CSE-ConnectionGUID: KZS4u0FMR5uT9W1SHloIDg==
X-CSE-MsgGUID: nMYJnZwxTXaBym3MGjCAGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="231234794"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 17:04:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 17:04:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 17:04:45 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 17:04:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgUgAsICAFxSloCrMZVFievLPkn6K4R/SdpM7qC/qlc6AX7Q5TYlZIkn2KN9q9KcV+MN6B6YyHDGFs43Bswex6N+nVWWnRj2Ai/wlRhi5sG4Ph2/2LeTCXhq4Eb8v0aZjYqj47W4if0UkNy0Iw//sWeATdVcPn441G4qba6fQRRUv5kLX+vykRPcBMzVXuPhIQsaFGk2QukAfSdmlArfBuYO8Ts06pY+M/BaqlDDXj8Z/WQGhdt2Vs/EEPT35F7s0xMf/vYkW2I3JwUtLvNhfzovgl710BQXdH8mnqEucaqNA9zqOjvapQW7vSt3QANi+BM7sizJmT64zZbZ6Txitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1+9e+j/DIwYlQLWLEF/xdIuRUeA0NQo/rdRFozYA5o=;
 b=kVtlRlAEojb6R4MOXubZ5sukay9ccrFuxdhBZHLAp6MtA7FWoVLdPfYssr/gNpAhUlMVJqRqEuJN6xYx5elAGvu6ZZWedqMEDJW5hC436luzcPtc4BEhdWR//BxJDFBgwLaVVAfPezLHUjYcWUI3HB71x/YkVqgJbjh4VSpGT1t/X10AyhCbpNDveSU7ND7kbxyW3gqA0JdS+Y/d/twaHV0O2jDyEEVV7gbunvtMRibb1njJGUrA4vtQKR8wLi980UqT5dL/ZquPhlorP+P5EI7Nel1ojcf8Egw/8hEp/4iPXRPC+MT5RB98kUsWj+wfNMEKH7MU5SPy9h5H2GNmAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ5PPF7DCFBC32A.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::839) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 00:04:42 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.015; Thu, 2 Apr 2026
 00:04:42 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 13/17] KVM: TDX: Hoist tdx_sept_remove_private_spte()
 above set_private_spte()
Thread-Topic: [PATCH 13/17] KVM: TDX: Hoist tdx_sept_remove_private_spte()
 above set_private_spte()
Thread-Index: AQHcviZZeIIsxBLuJkCsFFXosoGEnrXIeeOAgAJya4A=
Date: Thu, 2 Apr 2026 00:04:42 +0000
Message-ID: <4993e1366d01f2d78011b6880a6420a9ea4991cd.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-14-rick.p.edgecombe@intel.com>
	 <80fab8bdb1ed559850623e55efe6de8b836e9cfa.camel@intel.com>
In-Reply-To: <80fab8bdb1ed559850623e55efe6de8b836e9cfa.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ5PPF7DCFBC32A:EE_
x-ms-office365-filtering-correlation-id: 7388c369-8bb6-4091-d3f6-08de904b710d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Dqu40+tmx9SH27aGeqxSyVyX9kTPJyVThPWuVhWbE1k8ZrYWeHpz5JUQDT3ZZ79o823xpoSW54qKrqrfbzPjfl59XgKryN6dM3IGg/eS7ulJXt1m3PKbZ4b8Q0xSRu05jFMNAN/+Ucl/NfdwqlNj5VgtgfrjUZdIGjnq7fS49CFsIuW0jBIsZQW8gmXz1SilDQxN8qA0WW5oCeAbrXCi+MmQyFI4bWe59Fh7KzCzSUx6mqtu4RxdgyneMKvVnjjH2biGwt3BbOjwetunhWjuzfDXvYrunmjrJLYn8PlRU+MvQQrwtZnQvNUrXDT0Vt1CR0NLuiqhV0d6OXd8FRsLvnyV0iLNn7HTWNk9IOVTkeuc+pVHAkKEa6VKcwxjfWUBY/ch7lalZKh7y4VAMd8wy+qZp46piaMXWa0G/DQrX26YG3DIW9SjVBoBr24sL6MGqVYNcMhOSJug0y2q1cIOmGOrkmrifo479cUchSohN6wU963wJlxm0oG2RPFGumZW01edo8zkKrN0T39/XHakuA52s3WGf2z1Dvj8HytX2Egy8Wnje9TkpAuvoNLnmNtP8YOsw6H7TLACo9kxNZFnmv5z9YMUEGlhIRR/iUXeDisIF62q4EMghzvdN3vb96iKmW+mk3ENWo3ITmA5ifJQbUEy/nsAl4748ua0WNShV8176L5pNCZ0W7BK3POcy8MmNQvtv8tMpFPOvjHDEuyckBfvfWmYpn4EFZd0g3VgsBcK3YVvHpfba7HOgu9+UrUoXOl/zD9EumjBuaMNIik/qvJLOQsTkh2o+razWE8QyN0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0Ztd0hPT2ZkU1N1RXh4U0pHMVFZWDFUdThkcDZIQTFneDNQTnVEYVUyUmxw?=
 =?utf-8?B?ZjVmWE1xeVhTSmd3OFM2NkhJN2hjR3RzYkNVbnE4eTJNcjUzbFRDVHVMSVFN?=
 =?utf-8?B?dFU3eWVScjhjWWF6WDRLY0xORFJqOU15TjZickpNYXQrcC9LM3hPanFrR0tV?=
 =?utf-8?B?RDJTZUMyaDR2Tkk3bmhqSFRDRTk1VzVUL3lXRHlSSXhHZlNhZVo0TGFBay94?=
 =?utf-8?B?U1pJK1JlZmFnVUovS3dPaXlFQlMvenpMcDRYd2d5aXBEZUFjQ2lBZGpEUVdP?=
 =?utf-8?B?ZjVpQ2M5akVhVkJCK2V6UmFNRW9WRUtKVGZRS09adWZCVmwrOHZuSUFkZ2xh?=
 =?utf-8?B?c1N0ZWRNcGFib1EwTW1yc1hHeFV1QkJEU0tRRG41YzdKaXBMN1A1UFk3anIw?=
 =?utf-8?B?Z0V4MU1wakpuSzlmNUpSOEpNdEQvTkg2UWlKaEhyOEpqZDFBU1FWbkxOVjM0?=
 =?utf-8?B?Q1dZN1Nxa3IzZjI4SnpCOHBaRWxzWVJUUDlGUjlWUVczTFBMeXozc2FMRDRn?=
 =?utf-8?B?ODc1SXNCZStSVHZUWEUxb21LZndYdmpjWld4M1dKZUFWZEVpN0NtWk03V0w5?=
 =?utf-8?B?R3hLNVdzSEE3bVYwTVhwNUJhZEROSUxjSldUeWpyUzE3WFZJbHZaa21mYWZZ?=
 =?utf-8?B?UlJiZnMwZnpwNERjQkVYT0MwOUpXTkttWjFVM04zRTZBUDJuT2FOSkFQQjZ6?=
 =?utf-8?B?VXVWQ01CYXY0bk1JN1gxUWovUXFEQ01lY3BNWEVzbEtNcU5BVFhBYkFQQWN6?=
 =?utf-8?B?L1Y5WGV2QVlTV2p1dVA0eFFxbGgvYnR2VmNIZTF2d0pzeWlZYlJKMDkxa1JH?=
 =?utf-8?B?TUUyRDRsNUxZbmNaNFZjTTY0engvMWRvRmRPU2V0ZnAvK3ZUbzNEZWNxT0hv?=
 =?utf-8?B?SkdRSlJ6c0xUcjJ3Y1M4dXFZa3JkUEVHVnp0VjREK3RzWTZkZ09kb0hHZHAy?=
 =?utf-8?B?VWxFQ0w2K0pzS1ZiL21TcHRHK1JsTG1JWUVOLzJkOW1DaDBNV0dZWTI4SUJU?=
 =?utf-8?B?ZjE3RUNsWkg3WHFuRzBxMU83eEJIQk9aMzgvaWFBSitSM1luN0VkM3B3MkdS?=
 =?utf-8?B?UU1zRG9Za2l3T0p4dkk2NHk1d2NFa0N2R0hPa1FLWldoNVlLUUlTQ0h6dXdO?=
 =?utf-8?B?MytCMHFTanZ2aXc2MmZWMmFYWlJlbmpWOG15cXlNS2dPd3A3Vi9iTFl5Smw4?=
 =?utf-8?B?cGg2MWZTWHo2MDdvcVZKOFV0WFV0ZU5pMS9Xc0dVT004aEU2V1F2VVA3RjUz?=
 =?utf-8?B?a3JSN20vMVdWVG9GMjVkbGcrU2kxMmJFbnhSZWRLSW1XcGNFcHBvb1MwTkFP?=
 =?utf-8?B?SXNWbmgxTW5SbzNObWdVU1hEaDNsYlFGdlhnaU9vdWRvbmh0RXVITHJPQjYv?=
 =?utf-8?B?UHhVdHZUZjNIOHk4L2V5VE9HeWFrZ2JlZWg1UVVzSm5jNmlYUFhCVTNxMytt?=
 =?utf-8?B?cVQyb2dtWHN1MXZINmpySmZoMnJycFpJTnpGSWd2UU53NTdIZzdLc2Z6L2Zz?=
 =?utf-8?B?RWFOSEFLNEprMUtOR2ZlaDU2U3pMODE3TFkxQjFHc1p3OHQ0RnpNb0Q1SFhL?=
 =?utf-8?B?MGJjVlhUY3dveVJLcEQ5TUQxeENsOEdqbUNoaHg1MDUvd0EyWWd1R2JzWkgv?=
 =?utf-8?B?bmpQVk5IVis1R08xTTk1NHBqbDVhT1hWRXZuWjFCVVYxdFlJVkpHU0p5Ry91?=
 =?utf-8?B?MFJ5RHZ6RWNjUUF6TEhxazVwTE4rb1dHR3JQNDh5Y1pkVVR3MVRTek5DQ25J?=
 =?utf-8?B?YXdkUlZWR2dIYktLUUxKcHEyR1Y5eDN1NEwxOTE5dU9hUnpMSGozM1lFNUdq?=
 =?utf-8?B?S2RNbEU5SVdwMzgyYjNKVXFodHlFQm0wWGlMTysyaTdmQ2I4VU5MMEVWMTBC?=
 =?utf-8?B?cEtlNXFLZVRNM0pHY2cvWWlBSG5yR2pXTzRJRU5XVlp0a2dxOTV2NVA2aGN1?=
 =?utf-8?B?V1Fid291SkZEU1Nobk9DdU4waEs2ci90NDhzMEtRY1B6V3hPc0hOK0w0NGlU?=
 =?utf-8?B?OGtLa0xpT08welp1ejdRektrNXViWTFFQUlzMTRMZC9GcW1sR2VPVEJ1d0gv?=
 =?utf-8?B?TnozNnNUbUorNVl4M1FtWUlXb2xhVGtIUW40bmtUSTRaL1NGWjZvWHBXb1hv?=
 =?utf-8?B?OG1LYitLMUROak9QeHcwR2FZY0VRU3Y1TFdsM2RlTVJXTVl2MXBVYXJxbFVC?=
 =?utf-8?B?ZUZCU3pNM2llK09aZTJmK1FWVW90NGIrY2kvTlhEemt3c2tYaU04K3RWcDN6?=
 =?utf-8?B?VWhqV09VNyt2VUx0Y0ViblVDQjJvaHIzVWxXank5MDBlZjg4YXpVY2hua01G?=
 =?utf-8?B?S0tWNkNFSzBXejlObnZOTkRZb0dvb1N3eXJXQk9iSU5zNk5FRjZKYm5Jenh6?=
 =?utf-8?Q?44s6zyJ534lBfTTI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09812BBBCD201F42AD057A69A1F5A2C6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KjI7TyJRyHgly5L6L9ljDiJCovTlQiT/vWXKkNfjR9NQp7TFdOaXgAgcKLj945xuxJvEO8V9sfdBZ0kJ125vi8BcjNwSrS/qaDDAicTFioNhEvbyitQBCk95Tlh72z6HhLVBExd/kr4gJ0GWxvkNp54EjIt19iP1GJUMWj7wyoDzzgikgg+UEvGIC6IpjGKy13SVrqWbkyW9MGd3HWW2Pb8ZihTbrpoISl71WOhaZmv531fKP1GvZg2DOfRxR7byNU45uELityZQ99vAXYUWUkhz7mZLTYEE3qxjx441J6NSFHoxU0Wvmoy9YaY/UtesmPGtU8qZkyQb5sNfiOQDzw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7388c369-8bb6-4091-d3f6-08de904b710d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 00:04:42.5679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OVQ0fLE3CGkxr7/PTy2S2nLgygLEIz2dgjiwajXNezXoSOjvTesedkbafwAz7K++EfgYSJjv3genm6yyKP/X25d14Ls0vEEtG+cqs7C4WdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7DCFBC32A
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDEwOjQyICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBGcmksIDIwMjYtMDMtMjcgYXQgMTM6MTQgLTA3MDAsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0K
PiA+IEZyb206IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiA+IA0K
PiA+IE1vdmUgdGR4X3NlcHRfcmVtb3ZlX3ByaXZhdGVfc3B0ZSgpIChhbmQgaXRzIHRkeF90cmFj
aygpIGhlbHBlcikgYWJvdmUNCj4gPiB0ZHhfc2VwdF9zZXRfcHJpdmF0ZV9zcHRlKCkgaW4gYW50
aWNpcGF0aW9uIG9mIHJvdXRpbmcgYWxsIG5vbi1hdG9taWMNCj4gPiBTLUVQVCB3cml0ZXMgKHdp
dGggdGhlIGV4Y2VwdGlvbiBvZiByZWNsYWltaW5nIG5vbi1sZWFmIHBhZ2VzKSB0aHJvdWdoDQo+
ID4gdGhlICJzZXQiIEFQSS4NCj4gDQo+IFRoZSBkaWZmIHJlYWRzIG1vcmUgbGlrZSBtb3Zpbmcg
dGR4X3NlcHRfc2V0X3ByaXZhdGVfc3B0ZSgpIGRvd24sIHRob3VnaC4NCg0KWWVhIEkgbm90aWNl
ZCB0aGF0IHRvby4gV2UgY2FuIG1ha2UgaXQgbW9yZSBnZW5lcmljLCBsaWtlICJhcnJhbmdlIHN1
Y2ggdGhhdC4uLiINCg==
