Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66551274FD0
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776718683; cv=fail; b=hcGiefrS5uteSGSUUJRCQfYJFhhQlEFrbslI23nGOgXjkWPgI6vLcYbhesgBjn9+oijt0qkxhVnQRwtt/rwG8GdbbKVJqKNfxFK3Qopa3soD6ussswPuIUaV+MCee5U8OSoOqBEuoBPI2VK2f3YEQMiCUxCcjSE4e4bGU5YYovs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776718683; c=relaxed/simple;
	bh=RNwFYuwCnN5OXZJyBiEYeNSdUztFkSwNRjb+Hmhi0Ag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g6YZoPhi6nbD9rbgU0ubI/tIx1HQanmFeQWivf74HdSyQMi2tI8MeaZYDLvtXCbi+cLX7wyd+ZUig0FLLxsR3TQNWuEnhsKGKmVf9tk4Nv6eeJ9nG5NNgo+JO5ffYsnGixg2xpWHhOwJbqm3cUQ0q5H/ECff9if0BPYC5iPVZ5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyQtO8oM; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyQtO8oM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776718682; x=1808254682;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RNwFYuwCnN5OXZJyBiEYeNSdUztFkSwNRjb+Hmhi0Ag=;
  b=CyQtO8oMYgKl9OrzEFr884W2qLvfGDvxUjOv2fZMZOxL0Thmgk7fiDSA
   8oZbRuNGCBA/9AGidXI4RAA7fXfjXGtLQQbf0N6yl8CYwF6qWQthmxFIF
   GtJriAu/Gt8tLknxrfCFjH6FWBvlAtKi9d+Y2KpPGxUHYOffOsnd9wuum
   OtoR5XBTXsDiyypgEmrNNQMblAwULAzdGzwQ2E9Y08hPfbRLBwWwkMwNj
   kA5/HwjPI2vM2iO4QE1W6dznQBU/yqq3wGrctr44Ww4V3SS4jTj7SFwGe
   BD4nn1M+SPTyIAxTUvhxbS66AMpHWVWMqCdeN12MVauA2CERQtthraJBS
   g==;
X-CSE-ConnectionGUID: ztVOp/+SRaul8aoy7S/jlg==
X-CSE-MsgGUID: +cooTH9JQam6GPONYp9PQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77556827"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77556827"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 13:58:02 -0700
X-CSE-ConnectionGUID: SkrGqHFRQvKZmxYHPGPJ2Q==
X-CSE-MsgGUID: kNrJvUt0QUmpizg2mxeYXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="231742410"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 13:58:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 13:58:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 13:58:01 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.34) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 13:57:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bv+d/2gF5vHFjOlxCFWmXXKCHhMUCa9Q1tkW87/LbwNc23r+QYwrqAIwn5Jim/a4p1EaNXp14Hg3/df9eo3aM6hxPXkvsEMcQNHHf1eSVwiRmu8npgq54so4L2hpupjuNGmZGnuDpJb+dgAfunsiWvRoc9UmqKR7D0013nAxlWamNzqqaYmRGuQX1XRfBFR407uNSrJJI01xnHWrQT+q8h30QTZQkyk1sEm743CwuvAt0PcXHwqwBSF1y7XCyU1Yw+0/IYOmG7lT/dJHkIOJGSZK+WDK6TI4JRVAVPGseZRiXpbH65kHGpCNOWjj1lPLHOWdBOTjHizEMOymsHlw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNwFYuwCnN5OXZJyBiEYeNSdUztFkSwNRjb+Hmhi0Ag=;
 b=cwd2gzxfrE+VFMAjsQkeI1VaQYNcl7DDznTC6rN27Oxh8wKI217zoGANQIWs1GxqLfQfXdsomdzBBHusM3eMCuN1e2evRDJSAFeC9At4YQZNEYA+dNOwKBHQRHVtBu9EKKz0q2qFEU4swAa5mr700JDtsuu/pVsPAsdmsp/MIscV+phO7ZKx8SB406XcdiBA65QSLhjXzm7ODfg1HFAySeSbIwMse+Q0s0A7tsTyvStBg1ypiNWQPYXHplD7DkwZZJ6mqIqeBxr3t9NrJcF1BMaEzNvLwNZtPBSywM5jxVekb+MBgbq1bKmZrwZRwwQ6LCdK8pu9+0Y1ozk2f+RYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by LV8PR11MB8771.namprd11.prod.outlook.com (2603:10b6:408:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 20:57:55 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af%5]) with mapi id 15.20.9846.011; Mon, 20 Apr 2026
 20:57:55 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "tglx@kernel.org"
	<tglx@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
Thread-Topic: CPU Lockups in KVM with deferred hrtimer rearming
Thread-Index: AQHczeKk+wS46Li00UqCaHMewgV8CLXoEP2AgABj9AA=
Date: Mon, 20 Apr 2026 20:57:55 +0000
Message-ID: <bb07d5ee721f5fd4e3a168fdebad1b450eb6bee7.camel@intel.com>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
	 <87mryxekxy.ffs@tglx>
In-Reply-To: <87mryxekxy.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|LV8PR11MB8771:EE_
x-ms-office365-filtering-correlation-id: 9e26df99-faaa-4070-0efb-08de9f1f7ee7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: IAeloT7hJpTeLD12uMas3w+g4R1bakzSBDfxEvCnebiLg/PHTzXdYuN5WzJ8IGU8gHKgpP2ET7ID4JN369HH3SVrcLNcxDBJTcTEMR3JGQdw6wgz8PfM/DkqAShZKGwt1ci6I9w+X/gJWx5Rd5JfKEmvES1I8DQfAaHkllvTb4NqHVcKhb3DKnfGXWxTeF6ccZLXugnpbVIBd5v2mLWhZScHaTckzyD6yvZT94Wjp5xOygDU9sVs4TJdnqHQA3JtiPjWCVKSk1D7L56c15m29VFn7gPNA2HjsknCEQfKvGymfa+jBgDSiuDIp0LkDsvcsVLHRhlZtZAZwe/e09I6LJ6HuB43xgLPZsviP4Au/UxBTAmBK0kqMaa0iAqQJE0cOa+BiOa48yydYR2YlGX5iO5hQwvCOigWhx8CTvqX63OKn67jG67aDbKE/xaRd2c4DaF59tXjUSaXmgCfIsRoJVbUOFIsc/551E9ARQ0CEZBgYQTBs2zMCN/ptgggZo1KWKrbQzxLM2GG7BHtzco5zlaB8oAgWpItVSzIWnU8kPfsSEbSP87HoYx1vONXVJTAzO2S5OEkGtCa2l8HUI2OKHg2A9mOqlLuRZPgHYgLh9dhC73gY2i/cmS5jT3glbk5J9ZL5hPOQJwYRlVk25dcJHsxZDpy40QfFhk7Pm35yy5DJ0iTmVcOPfE1wTXXzraPMqGb/e5g62Bvw236EKlNzs+EKMdZ9viUVRydJxFXm+k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVpsaHRTYVdON0tLbGJjNW9KeDhFdlJoNUpUbXJ1alJZMXhDQlBiNjNPOVV2?=
 =?utf-8?B?dVYxK09uZmlOSi9TdjhtU0M3aDR2WUJsYjZSN3NzZGd1SHVUbzNKaEs3RTd4?=
 =?utf-8?B?dUJSczhDOVFzK3ovZGhTU3c0UWZqSERqWHFrVnNyaENGc1BPT3R5L0xSUHBa?=
 =?utf-8?B?ekNJMW1FNFpWbjhVcG9QRmRhTXNPcTJmcXVzeHcrYnFEWTU3ZmtNemMyQkhr?=
 =?utf-8?B?dHFNQ0V2dTRKU1dHTGtkdnNERGRaOVhjbGsxZnBXWHVadTlHZjQxOXcxM2ZH?=
 =?utf-8?B?eVNaa2gyelRxMUNBbGRlRzNYRXZDaStsdm1RZmprOW5RRHVCZlpJMFp0Z1JH?=
 =?utf-8?B?NEZvcjRURHd2UlUyVHRyL2cvWmpTeFh1bm9GOEVDWHlrNXJpWFNFamxqdDJI?=
 =?utf-8?B?c1hDdzk4N0RrdDEvT0pkb24rMU9KTzIzWFhZdXk1T1RJc2xtWS96YytrRjg3?=
 =?utf-8?B?cmlXeWl2RnVWaDlPTHhWYTMxWWJyRitHT3dOMmxsM2ZKS29Ma2xsMU05bi83?=
 =?utf-8?B?QXVSSmEzdTNZNFNnaCtXNnpZWUYwRTFvSWtTWm52dkQrWEFJaTQrUmpBUWo2?=
 =?utf-8?B?a01GS21LVWZhbTdHM2lQYlVjNVFmdDhra1RhQlE4dDQ2c2RLZjNxcXBmSWdl?=
 =?utf-8?B?UzQzcTdCbTFxWk1WQ2tHQ3cwS1ZickxFSTNkdVhmcUxRelk2eHdTQWF1WFNk?=
 =?utf-8?B?bjRmMllOVUdHUEJBTldCcHVUdWJkbWdoeWNtSXVrRk1kSHdtcFYycFcyM1Vr?=
 =?utf-8?B?eTdUN2ozL1hLQnpBRE5wVkJJei9Bazhlcll5c2EwN2YydkFJSnl0YTBoc2hh?=
 =?utf-8?B?MnVBdXpsaHVpM29vYjFwWTlRZlZEcUpCd29lSUViWkRxSUdHUEl0ekkzMVZq?=
 =?utf-8?B?RXBGSE85b3Y5d3BvZzhjNlQvNk1VNlRzWERNMG5COHNmTXdVc1RneWI1eG1Y?=
 =?utf-8?B?bnc4OUZUK0xndVkrblJNYXJCODZFc0xMd0k0R2dBSFlpVk5ZWmRScHhPOFZS?=
 =?utf-8?B?UjBuOHBNOCtlZ2lTVWc0NVJGSW9TU2NQVExFNTYzSU1LcEhMR25iZ1dOalp2?=
 =?utf-8?B?eW01THV5V2hLMi9jT0x3OHA5TzZZRXA0SmF5MHBIYnlGN2xqalJwVjNQUDFo?=
 =?utf-8?B?aDlkS25DL2t1dnlkSnRlOFFsSnNtZUhKaExuZnkyNkp2b0hXZlFyVCs1RkRk?=
 =?utf-8?B?VSsxOW93cW5ROHhIcXlmVnRiMDMySXRMYklrOW1kaDJ4NmdmNW5rVm9ib3FP?=
 =?utf-8?B?Y1dCMjB1ZHJYM2tsS25GeHh5RWJJMDRzbENDVUxaK2wvcU1tamFRL2E1QWZT?=
 =?utf-8?B?SUdXM2hLcnQ2UVQ2L2IyMVJ6WFl3N0xUUEJFOGYvTVhWWVJkNmxwd3BOZGZC?=
 =?utf-8?B?QUhoMW40b3VlWlRBY1pUMVUrbXpURW1YMENBcm1VK0pGbitjZHdJZmswU2lC?=
 =?utf-8?B?dmxxWUxtcHpXWnIwOUE0VVBRdWZKeFVJdGFHbHBsTVBEYVVHSWNveVB6ODMr?=
 =?utf-8?B?V3lTbnI4V0YrVHJvSGdkcWRSTTF4eHhXSTJud3ZmYjB1N3MvWkJPYXhyamI4?=
 =?utf-8?B?MFZWeHYvOHFsTjRhb29zNWIrYTVGMDF0elgwMG4yR0dOTStJTmdYbkxtbFFv?=
 =?utf-8?B?TllHL2ZJZTNzU21JRjR1YW9QOHo1SkV0UTBxU1VDOWJMNGd1M0ZTNWdSTWtm?=
 =?utf-8?B?WDJlamcxNjBJcnp6ZTBNMDZUbnByRkVnakdjYUZqSS9FbnNrSThwTENaTGYz?=
 =?utf-8?B?dzh5RVB5N1F0Z1IyWkJOTG9TZFhYU1cremszS2QwNXNnRVVmbUVkZktZQ01B?=
 =?utf-8?B?Q1grVnVvc01qaVFOdDVBNWxQTWtONWZqdmVsc0VTRlU2TFJoR3k1aVNhVlF2?=
 =?utf-8?B?SW9zQU96ZzJ5ZnlaWVU0TnpiZWRBS0UxOEtzUkphM29DaWE0RExwOCtTUTV2?=
 =?utf-8?B?bVZTVEtFdzdFMXBYdTNRWVlzS2ZhUHBUN2hpTGlVK0N4RnpTVnVWRzRRaXUx?=
 =?utf-8?B?U0VHUkZMb2tDRnd6Y3U2STFHTGNwdzFycHNvU3Irc0JYZXpCNVo2YVp2RmRZ?=
 =?utf-8?B?OXBrWWtWamo5alhnSlk5SDVoY04zN2FmNytCeG5IMU5TQVJxZFFVS3UwVEtq?=
 =?utf-8?B?VDdOQUN5UEVaa0NyTGtSSTk5aFFEdHc2OHhIOVlLUWVseXlVaWxSUWphaWdW?=
 =?utf-8?B?YllvdU0zS3V1Witza1lyV3FkMHBWS1Y1UnhjTEVsWjc0ZVZFbnVUbG95Kytk?=
 =?utf-8?B?LzFXaXVob1N5VnVZNmMzQmF1RDFkTlRPcW9KNmlWWVpIS01MVitSeDBpMHg2?=
 =?utf-8?B?ZmRGeDN4dUFqcUNXckpIWUdPOUNGZ3VYZjZnNUVITEZiQUpVc2tFd1RkRTJp?=
 =?utf-8?Q?ilab530NHW5lNSas=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8E5C4382C79AB4FB399064703B5663A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TqZJXkLWrDWle9d9d9FjcsxLT0LG6xBwsG+lDKZtj2eSw4Gn0wge31XNyshnInSAVzZbNxsbe2RBAW9J1Ap/lFS4FxYuvM00pzGUQ/lZFnmKEHFZUZrNgDjkCWJ7wdLeP3ABieAliZDL5r3I3shvPInRrshRuFlIki8nFc421cexv47340mlENZ9DMpySwxm6CvKo7t77V5jCHDsRVfXqTR+XR+A8gbt57dB/JVo4A2yP/6B4kypI8qC7ET24lVXsrHHzngY2TAspWWaTHhvJiuOvL8DUm14N3seFtFNCDnuWNLREFx/pOSu//DBRI0Rif5UpMsVlpmB123ZpPhzBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e26df99-faaa-4070-0efb-08de9f1f7ee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 20:57:55.4650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Pgk5Q+gIMJsnaEDTmnS1UM8ddetbprFnWCt6AevF7OU0AYD/VaUuIBC5Pvk8NAmQ+IZkdv0/qZ3+G7o8JizsJQLUqW4/XJxeFI3C1xB6J4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8771
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA0LTIwIGF0IDE3OjAwICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IA0KPiBUaGlzIGNvZGUgc2hvdWxkIG5ldmVyIGJlIHJlYWNoZWQgd2l0aCBhIHJlYXJtIHBl
bmRpbmcuIFNvbWV0aGluZyBlbHNlDQo+IHdlbnQgd3JvbmcgZWFybGllci4gU28gd2hpbGUgdGhl
IHBhdGNoICJ3b3JrcyIgaXQgcGFwZXJzIG92ZXIgdGhlDQo+IHVuZGVybHlpbmcgcHJvYmxlbS4N
Cj4gDQo+IENhbiB5b3UgcGxlYXNlIGRvIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiDCoMKgwqAgMSkg
QXBwbHkgdGhlIHBhdGNoIGJlbG93DQo+IA0KPiDCoMKgwqAgMikgRW5hYmxlIGZ1bmN0aW9uIHRy
YWNpbmcgYW5kIHRoZSBocnRpbWVyKiB0cmFjZSBldmVudHMNCj4gDQo+IMKgwqDCoCAzKSBFbmFi
bGUgdHJhY2luZyBpZiBpdCBoYXMgYmVlbiBkaXNhYmxlZCBhbHJlYWR5DQo+IA0KPiDCoMKgwqDC
oMKgwqAgZWNobyAxID4vc3lzL2tlcm5lbC90cmFjaW5nL3RyYWNpbmdfb24NCj4gDQo+IMKgwqDC
oCA0KSBSdW4gdGhlIHRlc3RzIGFuZCB3YWl0IGZvciAvc3lzL2tlcm5lbC90cmFjaW5nL3RyYWNp
bmdfb24gdG8NCj4gwqDCoMKgwqDCoMKgIGJlY29tZSAwLCB3aGljaCBtZWFucyB0aGUgcHJvYmxl
bSB0cmlnZ2VyZWQuDQo+IA0KPiDCoMKgwqAgNSkgUmV0cmlldmUgdGhlIHRyYWNlIGZyb20gL3N5
cy9rZXJuZWwvdHJhY2luZy90cmFjZSBhbmQgcHJvdmlkZSBpdA0KPiDCoMKgwqDCoMKgwqAgc29t
ZXdoZXJlIHRvIGRvd25sb2FkIGZyb20gb3Igc2VuZCBpdCB0byBtZSBjb21wcmVzc2VkIG9mZmxp
c3QuDQoNCkhpIFRob21hcywNCg0KSSd2ZSB1cGxvYWRlZCB0aGUgdHJhY2UgaGVyZSAofjc1TUIg
Y29tcHJlc3NlZCk6DQpodHRwczovL2RyaXZlLnByb3Rvbi5tZS91cmxzL0I5UFk2MVhRMEMjMDdY
d1RWaEU0NmVCDQoNCkFzIGZvcjoNCg0KMWY1ZmZjNjcyMTY1ICgiRml4IG1pc21lcmdlIG9mIHRo
ZSBhcm02NCAvIHRpbWVyLWNvcmUgaW50ZXJydXB0IGhhbmRsaW5nIGNoYW5nZXMiKQ0KDQpJIGFs
cmVhZHkgaGFkIHRoYXQgY29tbWl0IGluIHRoZSBicmFuY2ggdGhhdCB3YXMgdGVzdGVkIGFuZCBp
dCBkaWRuJ3QNCmZpeCBpdC4NCg0K
