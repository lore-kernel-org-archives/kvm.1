Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31DD262FD0;
	Tue, 30 Jun 2026 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862393; cv=fail; b=Vbc0jVo1TVp8SHf6FP10cXWSaATVd6sZI1yin/l061NWhVBNO/BERbiX6wAsnfx8AiBpHGpp1pG4zxGgwadOv0Bj4F2B12WHldbuLgh0X1m++JQ9xLzmoXkfsrhzywzf87MTIzssVe9y9wrcSOELtgLBBFyZkgcvIYSYbZ1yLiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862393; c=relaxed/simple;
	bh=V6j9AnCtToB/IF/vUC1SoEMdBvPGTKTG//CUm9iPVx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fkwxwZRiQw7nKneTFK/gKItNB20wHeZhdvg2ERnx7vaei9kwk5P1VtFaTSexQqjKHcm/XPHNEgrjCGMEEYYjm9dxQX6czVTo3D2xv25D43vvHP42URkK5R392EDGfAUv3u3SZWj14RVO4o4LWBndaeefRgBZQyr/X+/xV6+b4EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GefMqo7K; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GefMqo7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782862391; x=1814398391;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V6j9AnCtToB/IF/vUC1SoEMdBvPGTKTG//CUm9iPVx0=;
  b=GefMqo7KjZOQ1EHMhISkgi0oAZH0ZbbJxr1FCzFZZydPJSrWOWwZt3mp
   Eh6jw/GNMq2xxAMPxSX50q37yBavKe3HHvvB+Y/+pjpTkHHOQX0SLPvLL
   TBV5EcaHZGJge0FroWvRZ+ghzQp4GoyrP1jzMyg2oSmRbN/7y82IvW4Ri
   YELS7Jq/tOzf7kBnURjMM/Zmyl80hEQHgiQSqxOsn2w4of4BRCG9W4J0i
   cg5zl5sLj6+OevMN+p/4zaj6tZRIkENdy1NLXoolDFmzoQNWsk7NbU83i
   o0xh6lfcsjpfTdjwT0yFGJb8rT1amHPdNl248wPDMG0a87bTWmRlb+cpX
   w==;
X-CSE-ConnectionGUID: DuL2MJyfS3OUBlF3HTf8YQ==
X-CSE-MsgGUID: tZD8LA+XRQ26k2/8Afv68w==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="82701988"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="82701988"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 16:33:11 -0700
X-CSE-ConnectionGUID: yyT9YfvFSHiy2G0rpua3Kw==
X-CSE-MsgGUID: oRQ5jg0DRLSTWwXAcZCY/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="254327088"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 16:33:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 16:33:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 16:33:08 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 16:33:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPqTGlXsILKri293KK/xOQJWrx0HXhYmKej5H4tcGI8MXlIyx2uiSK/bpDHjlHj7VJh2LgNukq09vuaHLQ75whc0zRbK9Odg3yif4qkF9qH1OHH6qsYBqmlpGvVma3Zi/TDqq3Km4qEa+1xCavLryt+N00HWJBhKOxTkbzjIkjYnQx7EdazltljF6MFMBUr2ApZn18yn6RuYZqXgCfucyuFBZpP6rI0NoSNWcK6lhh9s7ZKVAtLZ0QhVDa/S6uda7pAHY4fOlf23GD4jeLwqi16zQgQ1lQvSDN/zgIJJ0V7AcP4jvYzOD3NbEPHS6cWFXGtGZZd9YRtlCal9wFh9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6j9AnCtToB/IF/vUC1SoEMdBvPGTKTG//CUm9iPVx0=;
 b=GuDvHClRy6/mja32aVSHfWkd20OSxUKUeLhlxrTk3QeNcd+zE4u0SyRdNm7NsP2T7vMgkVF7nGMX1pbbp/cJvst1RVICv0O5XR0GqOWFoiVhQuX22m7aKbCZbz7qkTmQAhH+yrXDc6Ti201BMrBHl1yjKUt5Dl9HCGZKpcdmRBQrb+AKX3sPdai1flWZPl29T4ckDa+6i4SBBRfKw/GCg3HppYXT+lfUeJRHHm0w7BA+3d+B4kqyukpkT3qcKile4Zezt0E+yNulIgvS4po62TL+SW9wQaPS3xXlwn8VBAygU7K221FUjB9n5NeRhitb89sAaXzBsRUxvyl3375dAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 23:33:05 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 23:33:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "Fang, Peter"
	<peter.fang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Thread-Topic: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Thread-Index: AQHc/v4hZvKBjyrt6EaJpy4HaHV03LZPm3EAgAXDgoCAAPWbAIABfw0A
Date: Tue, 30 Jun 2026 23:33:05 +0000
Message-ID: <23a9173f6e278ca7dfedce3374626c6ea3e1b47a.camel@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
	 <20260618081355.3253581-17-yilun.xu@linux.intel.com>
	 <aj1tFuwZWdPGfUoG@google.com> <20260629100301.GA1743876@pedri>
	 <akMQ3J6fK3DUBsPH@google.com>
In-Reply-To: <akMQ3J6fK3DUBsPH@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|SJ0PR11MB4976:EE_
x-ms-office365-filtering-correlation-id: 9c77d814-c022-46a9-5cee-08ded6ffef8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 95T+aaXLZ92bbjboK6Hvvz2OBMiupIIRNvPbFGE74J4chKePETqd0eC65rbcYJRkqffIvnXCtNhkgWkOErVMUcqs7NPOGVlY0TtgUiVxChHmEFNN+BqYD6vr6wPkgV0Dxt8x8K/7vO9ynuPfNpUZXEcsSG+BDEM7vAZ6zdgNQqg+SiPsh7FCCukWLmSiB0BRxYXFntC2c1NkNWLMQCXGPf6DM8bSJqxRE0mb2N35eyEjY5DEJ7W1vVifb9/lvu361LedStS5uRabVSAoTn7D6v9ZAl9wzJlcRVddbUAhAUsr2CNFYEkn1heKx/1VLVTS3lyhs/HxphQq/H2fHWe1JSGc+4lRACew97D7xxr4tHZ+FCBJV12nRWE9rm5DvX6P/9QaHFUb8uhlWL7vzEwqwCUcDOYtPt+n3s/UbZBUwZrwyGhCXwKW3hdf4ywmShp0Mw2WKnvxe7204dSXfQhfpsaftpJt70nU++z55fonTSHKw+hGdsRTkXMi/zC5P9RnnjFEthqOg//gwiIyh2EuIK9IN5QOLouIAQfYdyiwZF6/HDqpBk2Dfq863r3nXcpONxH3t13vbpnk3fTjz0iXgkmmDHBCmNkL3bLefK5WetiwiPUH/HVjV7ENDQc3WTKBkP5dd0luOAHPILs0BQ+cJZUk/ForH+AKN7UfX6DUqF7wvzviDS9neY9dBVyXM+XsLuep0ARKDp44GN44odUEtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1IwZ0lqL2lMckY4aTRxUE1sYnBOUTZnVkJOOGgvR0VBVzBnMVk3aktXVVVx?=
 =?utf-8?B?eElzZVM0U3ZuNTZscDhQTFFFZCtIeVZDV2ZRQVNuYThuTGNLcGo4Vi9XR2xt?=
 =?utf-8?B?UFJ4VFAyK3pJZklCTG1wdnFxN2dTNUhPc0RFR0JoWnVlSzVndE9GZXlrWE9D?=
 =?utf-8?B?cHk0bG5xR1hzT08zcUJkQ0t0elV0MHFOVExMSkFjL05nZVpJV0RaZk1xWnZ3?=
 =?utf-8?B?TDM5N0pFbXQ3Wk5ZS2Zqa3huRldBOXlKNlhRMURZRzlxNVpxdHYzTFFFMkkv?=
 =?utf-8?B?L3JDZFUxSGdXSUhKWWZLVVZsUnFDc21DMWFKSTVCdkIyQWxjZktMT3ZLMkla?=
 =?utf-8?B?R3QwbjN3Uit1OW1QRFEzVHEvbHdZUWQ3cTYxbG4rR1dGYXBaQlk5WDJqZWRv?=
 =?utf-8?B?V2VSWWMvUXVzaDZ3R0FlYXoxMWVVeTIrckxpTUZHQlc5Q2ZqbnVnSGRNSmd4?=
 =?utf-8?B?c1ZoM3lOZmN1WGhLc1I1cGdVMW8yNzJPb0hucFN2Ni9JbWl2cFBiVm5ST0pS?=
 =?utf-8?B?NWFxV25UL0xoR2phbTRwR2IrOVlYbkZpUVo3NmpEQmhDc0JQL0xJbFJqT0hL?=
 =?utf-8?B?aGFTV3l5dGk0biswZWp2aTk4WDdKeHNLOUZmUjhqejk2NGFiQ3FDTnBnS3Q4?=
 =?utf-8?B?c2p6VkNsUDFJa3J0ZVAvU2NwKzhyczZ3ZlVWdGdteENxS1hOSnhRSk8wbG5y?=
 =?utf-8?B?QjQrdWQ4b0F1VisyMVBnOWx1Sk1JUm5RZnJvZTVLbnBZNVhJekl4Ylo4cTU5?=
 =?utf-8?B?MjJ4aVdvV3R4U0RsdmhaK2xvTC8rYVVrTSs5clB4VCsxZDBLV3J5czJHc2NH?=
 =?utf-8?B?bEhkazE1aHFpWHlFU0dQOGowelVmMWRQVHZyUk5YYTVZRlVFUEY2TnlVbm0x?=
 =?utf-8?B?M2FMS3NwNThvM3paMDJwZWN1VHo4V0JzNU5zL3EvY1dNbkltSlhLclgvSkti?=
 =?utf-8?B?WUhLOHlVc3Y0Y21JQU90c3BqYVB1d1hBMC9FcUxvZGtDeE9pT0JKNlhpeVdF?=
 =?utf-8?B?c2tDYVVGYTRTZ2k1MENjejJ6QlhLZEJ5QzFsaGVIa0xrUWNud25KUTI2RDNX?=
 =?utf-8?B?NURlT2Q4Wm85cGdOcXVoKzl5eHIrRkF2dEdaeE5tb1dyS0w1bmpjSzZFdnVj?=
 =?utf-8?B?Yk42ZzAxMlVSU1pJTDNMMGJjNG9iUGFwdTdPMlZGUTQ3MDlXS2ZiQ1NKUDBp?=
 =?utf-8?B?NUFsQWxxVUZINCtMODI4U3dWekVPdldWOFRpWTRhZ1RrbVp1aGxuVnl4Q2tw?=
 =?utf-8?B?VU9CUHR5ZGFWWW5ZL2hVc3NiSldhQ3o1VXNTNlBsM3E1Q3p4ODVmRGFtanZo?=
 =?utf-8?B?WlBDcDBoMGw4VEwwa08zMGRsMXdMeFhwWHQwNmYxbm9YQjJTbWxUTzd5THo2?=
 =?utf-8?B?Vjg5Ky9mb0I2QkhNNk5PVDBoamJmMTZiWTU0cGRveXFnMHAzYitKSlZqZEdV?=
 =?utf-8?B?OG9XUEZuWkt1M0ZmWVZHbEE0VEpxdG5oMFN4S1d5NHRteDRxYTJBY3pWa1Az?=
 =?utf-8?B?TlhaNnZCdFp6VFZXYlM1OFJVdnVqUUJMUFNJL2dQdFJvcTNZaUhldE1jajNV?=
 =?utf-8?B?YjFzRHJqNW1nU2pUa016cjlTN3dCaTRQcHhna0JkMmsrS3hmeW4vZHlvN1ZS?=
 =?utf-8?B?SHk1MzZKMldaZ01yUklIWnFpbFR0eVFZMDRGejRaZk9JbXNQK2lZUVJWRzlQ?=
 =?utf-8?B?WmZMUUg0dmZXak1BWW1CbGN0bExMWlJFRVJ4UjFpQ1VoZHczTndmV2FySUgy?=
 =?utf-8?B?My9jMFZ6SEQwTHd6TjhVSEdlNGdROG93ZzhWR2VOT2hMREliMkc4dSs4ckY1?=
 =?utf-8?B?R3VLU1l4T01PaUV4cnYrY283NnowSkpvWExJZk9zbjk0aTczUzEvNUFXVVEz?=
 =?utf-8?B?MWNuYmprMWtyNFBsbXo5bVR2NGk3dk8yY3JlTEhORk13cE81aUJyeGQzdDhZ?=
 =?utf-8?B?ZmE3ZmF0VHA4c1pzVFQ1bWl6TGl2WU5iVnl6eFN1Z2owdk4xcDdDQjRCQnI1?=
 =?utf-8?B?VFFBQXFSN3VjU2hHdmNEb2JCUmZKbXM5ZGJ2RGVwY0IwT2RXeFQwNm9DemFR?=
 =?utf-8?B?U1VFVG1Fc2VKVWtHVU0zR3hBdElrbVo2SlRYcW1mbmVOY0FYcW5pZzIvQU5k?=
 =?utf-8?B?QmFiNjFpeGJHV2NTQncvRW1rQTVGS05VbUZrR1ZjNmI2ajBYd3BMalFYa3Bh?=
 =?utf-8?B?L1JUdWo5VVRhcEwvMFdkT2FzTzUxVFVIK0p5U2hDKzJ4QzN0d3d2anoyQm5V?=
 =?utf-8?B?QnB3My95R201aFVnYy9YUjJnSm1jV3hreHhtWWhlUzBwUXduMWpHUlZyeDJh?=
 =?utf-8?B?M0RTanZJUFdIMXAwc2U0dktWeUxrRklYWDNwVG1DblJYcVZHUjdhcUJQMkU0?=
 =?utf-8?Q?Nb8lUWxbKAB1QToU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8942A299EE10304499C1E36296DEC072@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FWYCtymMbBzDDL23c42vfO9L47vN4aGiRxs4euJOzT5R/9+OCqs9JCIjPdZFhm4rU20JwtPeqlb8oCdl9t935kqZFrgTu5joUtRzlE4i28HTx7kXr1xUS6ggiY3GLTB6AxuGCRZtAHaGIVFXczUKBfTfJA+ePUG6fwV2l8CrPZWq2vPppV78azVzK0EzWlFQIpwn89qvmejmFBAcvWt4QDcQFbp3Mf8CTbV1kWDRqtUI8HTOoPOGMbDaiAbnLvhoX7Am9w3lxJhf/nTdaeMxE4eGnBOE8XM/iOrM+mSgndeLJnf52hqfXn2cUt5UPdYGq6DPb3W1XIf2on/pHLYFxA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c77d814-c022-46a9-5cee-08ded6ffef8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 23:33:05.6694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h1Dt+QwiHOJNH5GoO3UYSMO4G7kvY/mpi/e6bQPoPi3ZrRTwZxnrVWM4G8NzhmHTkUhOsmBDBV1HmYhP7puL3aAn8Wtd92IR+mc05qLaR5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA2LTI5IGF0IDE3OjQyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBBbnN3ZXJpbmcgbXkgb3duIHF1ZXN0aW9uICh0aG91Z2ggcHJvYmFibHkgcG9vcmx5
KSwgSUlVQyB0aGUgYW5zd2VyIGlzIHRoYXQNCj4gRElDRS1iYXNlZCBxdW90aW5nIGlzIGRvbmUg
dGhyb3VnaCB0aGUgVERYIE1vZHVsZSwgd2hlcmVhcyBleGlzdGluZyBxdW90aW5nIGlzDQo+IGRv
bmUgdGhyb3VnaCBhbiBTR1ggZW5jbGF2ZSBhbmQgc28gd2FzIHJvdXRlZCB0aHJvdWdoIHVzZXJz
cGFjZS4NCj4gDQo+IElmIHRoYXQncyBhbGwgdGhlcmUgaXMgdG9vIHRoaXMsIHRoZW4gd2h5IGlz
IEtWTSBpbnZvbHZlZD/CoCBJLmUuIHdoeSBkb2Vzbid0IHRoZQ0KPiBURFggTW9kdWxlIHByb3Zp
ZGUgdGhlIHF1b3RlIGRpcmVjdGx5IHRvIHRoZSBndWVzdD8NCg0KVGhhdCBpcyBhIGdvb2QgcXVl
c3Rpb24uIFRoZSBhbnN3ZXIgaXMgcGFydGx5IGhpc3RvcmljYWwgcmVhc29ucywgYnV0IEkgdGhp
bmsNCnRoZSBwcm9zL2NvbnMgZG9u4oCZdCByZWFsbHkgbW92ZSB0aGUgbmVlZGxlIHRvbyBtdWNo
Lg0KDQpUaGUgbWFpbiBiZW5lZml0IG9mIGRvaW5nIGl0IHdpdGggdGhlIGhvc3QgaW4gdGhlIGxv
b3AgaXMgdGhhdCB0aGUgZ3Vlc3Qgc2lkZQ0KVERWTUNBTEwgcXVvdGluZyBpbnRlcmZhY2UgY2Fu
IHN0YXkgdGhlIHNhbWUuIFRoZXJlIGlzIGFsc28gYSB3cmlua2xlIGluIHRoYXQNCnRoZXJlIGlz
IGEgbGltaXRlZCBIVyByZXNvdXJjZSBpbnZvbHZlZCBpbiB0aGUgcXVvdGluZywgc28gd2Ugd2Fu
dCB0byBkbyB0aGVzZQ0Kb3BlcmF0aW9ucyBvbmUgYXQgYSB0aW1lLiBIYXZpbmcgYSBtdXRleCBv
biB0aGUgaG9zdCBpcyB0aGUgS0lTUyB3YXkgb2YNCmFjY29tcGxpc2hpbmcgc29tZSBsZXZlbCBv
ZiBmYWlybmVzcyBmb3IgRE9TIHByZXZlbnRpb24uDQoNCldlIHNob3VsZCd2ZSBleHBsYWluZWQg
dGhpcyBtb3JlLCBidXQgVEJIIHRoaXMgc29sdXRpb24gaXMgKndheSogc2ltcGxlciB0aGFuDQp0
aGUgaW5pdGlhbCBvbmUgdGhhdCBuZXZlciBzYXcgdGhlIGxpZ2h0IG9mIGRheS4gU28gdGhpcyBl
eHRyYSBob3N0IHdvcmsgc2VlbWVkDQpxdWl0ZSBzbWFsbCBjb21wYXJlZCB0byB3aGF0IHdlIGhh
dmUgYmVlbiBzdGFyaW5nIGF0IGFuZCB3ZSBraW5kYSBvdmVybG9va2VkIGl0Lg0KDQpUaGUgb3Ro
ZXIgcmVsZXZhbnQgdGlkYml0IGlzIHRoYXQgdGhlIFREWCBtb2R1bGUgZm9sa3MgaGF2ZSBzb21l
IHByb2JsZW1zIHRvDQpzb2x2ZSBiZWZvcmUgdGhleSBjYW4gc3VwcG9ydCBUREcgY2FsbHMgdG8g
VERYIG1vZHVsZSBleHRlbnNpb25zLiBJIHRoaW5rIHdlIGNhbg0KZ2V0IHRoZW0gdG8gdGhvdWdo
LiBUaGUgcXVlc3Rpb24gaXMgcHJvYmFibHkgcmVhbGx5OiBkbyB3ZSB3YW50IHRoZSBndWVzdA0K
dHJ5aW5nL3NlbGVjdGluZyBtdWx0aXBsZSBpbnRlcmZhY2VzLCBvciB0aGUgaG9zdC4NCg==
