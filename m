Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6991C84D0;
	Thu, 27 Aug 2026 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787798225; cv=fail; b=t6w0PUC9j8aZC9LMSXvtEpz9MfcGQir56wgkho4ISL+ma1QI0RhNsV1jUcRS6evI3fVv+O2e3/pj2ggdD1EIcxYR0Alrq7RtovPIn7KmPMtOc53kEZWrH/S852g52DzOK9y67G42rtqq8NCV5E0fDUu52s5+2StmcHbpHwBZuso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787798225; c=relaxed/simple;
	bh=tuoicmQT0v8enNIL47k40qkvEIPSBVO6R7elrFfPdSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1T2p/NM9xtQptLJ9lvgG8tsXDYml0GHjXmqlTmf4XibIDTDetZ4407Qy7JFCfcCeMjI6gCzJZmEsAZyTHW2txIjwAYhOP4V4xQonEgsx3fxn3fM6NlliL8APOpa6QSkL5ASt3VJdnFjX0rDGPX+sx1s4Edivleea6TdaqQ+iR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXcah+WF; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXcah+WF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787798224; x=1819334224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tuoicmQT0v8enNIL47k40qkvEIPSBVO6R7elrFfPdSg=;
  b=mXcah+WF3W3FCf+F3U7kIJwSVCdkuLp1IxAvNNSzpKcfCagNilil8l+B
   hTFTfggqM/662AFdZTmXFpZVeIM2aML9Jcs+WOM0aSzH7fKys7oElj7RE
   lqxcZUt0x+jok057vm7OcAj+2qv8vLqz8vQjC0ajc+mlhnL7nYJVFR09W
   3HkZ88yqdXkAyKDwGYXOCuXcW7qdzSS/rKaVn/hSQ3M+M29AigN+YZ6xh
   JIVBC75lDVkGvRoh/tV06lBSlJJ4g/DGkmop6LWqoi3YNtq1KHliqCP/7
   BYTtw9sTHNMHtiWsbeo3v4CUxGwGKAUUwQjc1JIzdjuF+VHmx161M3doz
   A==;
X-CSE-ConnectionGUID: 9WWlzowoT1+nCkpRhJnWPw==
X-CSE-MsgGUID: Tm46VmH2Rgql2FERXpV4Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="75833490"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="75833490"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 19:37:03 -0700
X-CSE-ConnectionGUID: hny7oyTWRgK7XG1QWjN9Vg==
X-CSE-MsgGUID: A1OzRbsHQEua347JwYCtqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="264480338"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 19:37:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 19:37:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 19:37:03 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.19)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 19:37:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pccsj9DxoElNrLG4cHNV5uOAi/1KWY1wp0Wx6IY9aEsyANp1QusY4DwzBZznVawylsSvf6SLqWfGt3BAm2tamXGYboqir1nzoRFgytyfBXLK+K1fKDMXqoO4gq/fXL0qVtzdnvA1MYme4ssheJ3T9Ya4IPDEbR/8XjfW1pPAClGCqhY6Kgjw7uGhbGlfqpzXJg+/RcTUyOwiKcCkm9bKq/iyi7ED1a2sDNqM5j8gZPdY2tCdxsPKNh31/1fEdO980qAWGqdOv8Wn+7En2zsMrpg5nIMyYCefQ0wI+urSBzIsSzLE+9KJlHrQ5eXWxUgR4D/PAsmCPu8bmdxzhK9LeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuoicmQT0v8enNIL47k40qkvEIPSBVO6R7elrFfPdSg=;
 b=BggUcd0tWWTZA6o5vZ3IalRWKt8pnPlurrWuEe2HzWq3w5bEyaeGCBiHA/7/CKmNRNUyT+9eSH7fuJk7mQY51bPFluZd+17Qa3XgS2jZx8RpkRe+oa4JgVa1KngsVJSr6avdgARs7Zz/4xK/B1nyJztz0VFSf/pdE2l86qxGM5+pb7X100lvIe3et6gPyA7f/PNiGPEdJCKqR1NagpDWkoJkF+kmYhUtZ8NRi7LyvHt7wrZFf4C7BcZ3P+0dSRbUQ4aqwNMMhFPA9dAJ0ox78nn+i88JS/A1hp+2ISzaSFdRLeHMqrhDtQQM9Rx23Yw/7tCFVtZr47FFaHa9fPwf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5302.namprd11.prod.outlook.com (2603:10b6:208:312::7)
 by PH7PR11MB6553.namprd11.prod.outlook.com (2603:10b6:510:1a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 02:36:55 +0000
Received: from BL1PR11MB5302.namprd11.prod.outlook.com
 ([fe80::f19c:833c:9f41:f3de]) by BL1PR11MB5302.namprd11.prod.outlook.com
 ([fe80::f19c:833c:9f41:f3de%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 02:36:55 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v2 5/8] KVM: VMX: Rename EPT violation handler prefix from
 "vmx" to "vt"
Thread-Topic: [PATCH v2 5/8] KVM: VMX: Rename EPT violation handler prefix
 from "vmx" to "vt"
Thread-Index: AQHdNX43l3xG7WJJIUuncB7ru8taQbaxLtkA
Date: Thu, 27 Aug 2026 02:36:55 +0000
Message-ID: <9a6f58cc3327610f37400ac1078ebe335bd9926f.camel@intel.com>
References: <20260826171246.777729-1-seanjc@google.com>
	 <20260826171246.777729-6-seanjc@google.com>
In-Reply-To: <20260826171246.777729-6-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5302:EE_|PH7PR11MB6553:EE_
x-ms-office365-filtering-correlation-id: f5359033-ad67-4a65-b5ef-08df03e40f21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|56012099006|10067099003|18002099003|22082099003|4143699003|11063799006;
x-microsoft-antispam-message-info: OEBjJyHiBpjJYUTYvpa8HOCQJsj5I2o0vLoaP9U4stUnQJiOHTufPS55oI+ShNVx+NPa/VgMeml9kLOEZW3bmkogcWHaflc6PkzWbUisHqa5JBo1L3Dibmqwi9wnownSC2VUkYqyWkJ4+1Ms3leGnkG/DbCNG4mtmP3WwyouZRyxTEulGbt8m1BRFJnmmQSLMekb0gdj0URvC0aClat56w8oGRC3q9DNMwW6RuoWkOpbn6CyyH4pHn1P5sNDpvQEiNNTjObrw+Uz7Fa+PauW1m/CAd/o5n5EXIgGK10hrWppbweU72y+kPg6zZJQtkRAPdrn5mY2ZR1JIKNMb7Q0c/8HgWIl/qbM7A/Qqi5fcRPGJNIDE5af0rC5JiSYw7A0lR16g/0yP/np+jU0O+vtuXO0Iddoge+XlKDCQR+Ko5kPm2tbXG4gq5i4gWte01QOIPsbGhTEyLzitFARl6TG5OEJGk9iD1kaPBw4D+4BUMonojOULOnjYBoCBig76cEo0PIeJxySkpjZY6rGHWHsuAFMfp0TOURxUNr70qQXa6nNFCz4J/PUgqDkt/04KsRJoDwgYCCQByOd2nTcv1SQKWW6QjK2wpmUuWpnGJlv4YAwthA/xgQlZ7ITeE/dR2BN2P+jRVM1lDKCUtfraYX068//SRV5ZiAcZmGm3Ox/sJoMn9RjHSQz4Uryub52rvEEEekt5hSdSRHSiTQ632VUmo+I4jvyC4Iru4+8Mk5UHKY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5302.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzYydXBNeTdhSVJSK2dHcWhXZlV6TVRXZCtTMUFTZFRaN3ZFVkJwM0VQQ2xz?=
 =?utf-8?B?SXBmY0RtWUpTRkZLbVJLd0Rnbm9HelB1aExiT2NPblZRQmRNUGZhTGVIS3Iw?=
 =?utf-8?B?bmIzT3dpV2w5b3p5bExWQzVqVHdJd2Y5UTBpUkhaY1QwWnZnck43eXpEV2x0?=
 =?utf-8?B?d2RSKzJLUWxTVlRzc3g1Vm9NUHUwMzJONnZqYXlpa203ZVJ3bldybTBEVW1y?=
 =?utf-8?B?dGd1SmdKbmc5WGg3RlVmR1RnYUNMbXdGbW02Z0NJOEpZNWNjbXBMQnVDamNV?=
 =?utf-8?B?QS9mZ1RhOEY0a2NSWm9zdXVQaEJESm5EeTY1bm5FUWwxRDl0MGVRbnZ4WWNR?=
 =?utf-8?B?WjBTSGtDS3FKT1JuVVUyR2hSR2x6SGE2d2MxRnRJRTdXbnNGb29uMVFFQjZV?=
 =?utf-8?B?TE9mYmxCdXp0M1JJTERoN0JTSHdnSkE5ODNaWlNrUmpxTVpwQmpQb2dDQ0NO?=
 =?utf-8?B?ZHhIbHBXR0JPSHZya3RYbUdmbTdPbEVuckFMRmdwQ2dOdUJienVYMUo3d21q?=
 =?utf-8?B?Wk10Y24rdFd4RkxUbjVtNGlpMXNDbkEwN2kwVTQrazQ0UE8zRTEzWWU0RXRH?=
 =?utf-8?B?bDhUSmF1ZU1Lc255OFg5MmNFU3gwdHZxZ3dVM2hKNFlHSHdFZDJCakV5UTl1?=
 =?utf-8?B?cWE5QjlPcXBGTk1XWVF1V0ZWYTgwVTdhSS9QZDBlTk94dnZ6VFhDeFd0dlpK?=
 =?utf-8?B?dzdOcEk1bVV5Yy8rczlMOE9WS0NjT0xTYjNZK3lvcW1YKzhsS1gxS1VGNkFK?=
 =?utf-8?B?TldFM2tOeUMrbmhCckJQb25VRDhJaGtNeW1jSFRqUUFpamtGUlVDMWVWbGpx?=
 =?utf-8?B?MGZtTnN0YmpxNzB6dmNQU1M2bzZGVG5OSm95MkxaWnRJKzdLZCt2anNFbW1H?=
 =?utf-8?B?Y2hoRittOWFUYTQ4TitOTjR5akpCaWljMzRSbS8xMmoyU0RUZFFyRTRTa3BO?=
 =?utf-8?B?eFM4TGM4cGkvakd4VmxRbVdhR0NnZXlIZExyR01Jc1VBRU5odHJJYUk1d0Y0?=
 =?utf-8?B?Rzg5M0JqSk5PL3ovVi9xVFlqOUVhVTFmTmUwakhIVnZvQTliUzJyU0EyOHd6?=
 =?utf-8?B?eDJtWWhVcWJDbndZRk1yQi9KT1dJOHF0TTJRL2dIQnliaFF3VXdueFUyaFBh?=
 =?utf-8?B?aldDdU1XRmczSkVZVHowcEV0VzhwUE9jdmMxNXdyUVVWZGQyb2cvTkx0MGtF?=
 =?utf-8?B?ajFVajZpdWJpSTFieDhodmJFNFg4ZVljWm5Ca0pIVHJYK0JZN041WWhacjU1?=
 =?utf-8?B?MzVMaUlLbFJUa1FOS0lzSlhJZEY3NFNybUowNU11bWFiZVhzSWZNaXh0Tmsv?=
 =?utf-8?B?Z2hTQW4rUXhaV2lCQWxHNW56QUppNmpsWW45ZjVsS0FyTjBSMjBRMkdWU1JQ?=
 =?utf-8?B?c2FsOWhtRzUzZXh1OU5Id1AxZ2NOaEc3Ymc4WmRmOXRvUHlYckw1b1g2WXc3?=
 =?utf-8?B?Qmk5T3ZGN2tSa0E3Y1lBbXFFWFVyYXJDYnNOLzhLektONmRjRzFjYngxS1JD?=
 =?utf-8?B?T1FaWUxoTmxVUUdUdWtsbHpRTzFUT3pFNS9JcDErNHpZbFVuSG9nYjN6VnE1?=
 =?utf-8?B?bVBmR2ttc1V4bXdFSG14bXZkU3ZZTGxvSm0wZkJub3dwR3R1WDFvZUhkQlJ6?=
 =?utf-8?B?Rk8wemNvSTRvRklQMm1CNEJGSDJWaDJ5ck1ucEV3Tm5UcVVpTU5BV2U3OTRQ?=
 =?utf-8?B?WCtMZS94VXNFSDFqNVpkZVplbDhVVG80SFRqcGhHMzh2R0hsRUJDNTBSai82?=
 =?utf-8?B?aXZxTktTOFFDMWVmZzJ3dmt1SW00cE85R2pRelhiQW41TGdaQktuY25nRmho?=
 =?utf-8?B?Tnh5TVptZ0dnY0RLNXNnV2xQSzZ4N3lHYzZ5OHV3T3dlN0NxQ0pwWUdLZ3Rt?=
 =?utf-8?B?NCtLeGs5OXhUNFMvaWhTOWdJTWZwRFRQTXZWWHFOUkE0VERQRkh0R05JUkFO?=
 =?utf-8?B?eFU0MkJLYUlEUEhFcTJLa2tOQ09hNEdJZWt3WXAvdHlIQ3R3a0pwVXZNbGd0?=
 =?utf-8?B?NXJKZzFLd3Mydy9iQ1dFeW0yQk1ESmp2ZlFsTmxNc0pncnBqb01KZ0xLQVpz?=
 =?utf-8?B?Tks2UXcvL1Z3T0lESmtKUW1VUGtVeWdTSW93dVRWWmZ0cUczbmZ3cmk2aW5k?=
 =?utf-8?B?eWt4TURzcnFuWkVFWjVSNjdMTmJNb2F2R0RaNlhVSVdDaXcyQ1VOMWdybGR3?=
 =?utf-8?B?eGtpbVBNR0R3WENNTkZrUFBleHRaZThENlJSRStnNkxwNlU1UVZ1NHYraG9N?=
 =?utf-8?B?ek94dWhUYXc0VElUazJ0M2ZmQW1KbVRWZW5TVXJVR0c5M2tEMnY3MEVOVm53?=
 =?utf-8?B?Q2FMU255Q1YrV2RnQmZyUEF0ME50NFNDVFhPOXAvbXZOMndUUUQ1QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BFD44CD0DFDB447820CD1A9031C5D2C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mdrvt/3i+iMg3ik3sAiOQ3Lnd9bdmTJ44JxXTmFKFgBqixKXiH415AwcCN/Ywuf30+JbF2WqaZJxQ33xSvIiLlhBgFw0Euh3mBDNwKBQ1fcDWhc/JKTvaNKt5LatvqLEpp4QvRWBcClAECjpwjr0vUndnbVxDI1LsBH8KI1FBfF9XUQVc6g5p7M7CPvmmrboWC/s9nbRPbGE/jZzGfcFelitiVOQLG51ObzaADIgHub0zJG0pMk7Z/7zcUoiZTXCqPPivo+KQV5w5MIRga0CgXBTL/O8u9GbKB874rnsOoRNKCDfGfDkw3QUQDd23xmYIQrJdFPh0MtL5WpLnStpNw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5302.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5359033-ad67-4a65-b5ef-08df03e40f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 02:36:55.0669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZzpPDh7P2xcE7e6E+BVB572chVAapyplQdyL/c+jjH5mGp0J5R7ez7s1UcQBabGbATT1VbkW4vjdhyOJUHiISA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6553
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTI2IGF0IDEwOjEyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBSZW5hbWUgX192bXhfaGFuZGxlX2VwdF92aW9sYXRpb24oKSB0byBfX3Z0X2hhbmRs
ZV9lcHRfdmlvbGF0aW9uIHRvIGNhcHR1cmUNCj4gdGhhdCBpdCBpcyBzaGFyZWQgYmV0d2VlbiBW
TVggYW5kIFREWC4NCg0KTml0OiBfX3Z0X2hhbmRsZV9lcHRfdmlvbGF0aW9uIC0+IF9fdnRfaGFu
ZGxlX2VwdF92aW9sYXRpb24oKSA/DQo=
