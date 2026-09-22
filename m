Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031553955DB;
	Tue, 22 Sep 2026 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088544; cv=fail; b=t5Imav2UR0oT+Hj71D51e0m+n1xiqd+X3US3V+BO/7ZaD9i52nGBwFr4OtAay25gWBfT9TDWrZY0EFPKNqfUBpHDNyQXd6+aUFj3/iL9No6ACCthrGmcRe361z7byYso5IW23kYo/VRx1TgbaEdkcz2FCq9IVUjSdJhooiERvKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088544; c=relaxed/simple;
	bh=bDurHpf+w3uUVKmUXbJZsV+DIMq/AALn2YlWxjaLm9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dE6ogAavjJxSnTtX1wZvaGU0S/wGM3ttwl/rJgOZ6u6GtwQ+LhZ/eepNYHxBLDJ8l24SOJGTi0vkoFZ1idSDhUPkZcdnAA3vLSRQ6X22jC+VxWY6nxv0fJjCW7rLQnhRxSglAU4f1+LBpKUq4u8dBF6KjBu7iq+K67+pUGVVCD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftZanY7+; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftZanY7+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790088543; x=1821624543;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bDurHpf+w3uUVKmUXbJZsV+DIMq/AALn2YlWxjaLm9I=;
  b=ftZanY7+BeDB3Yy+jDb9G7LcmFNki1IJsqEQ1m5HDZmPpBQiS23nJepb
   knA0Nml9qcR+nH8pTg6P0ApqzaF4cjcqClspWYQ14wi5SzjoOhCVtAng9
   rRy4RgWMTElQD1ALOH3RVBm5tKvTpzpEVrvQX73s7ULzAd8vFgwBt7k+Y
   YgzFFWgw6Pd1mIGwnChZ3H0JTs0bwit93jZCenIHlTOfexIBkMN/u/7Oc
   6K5Ns045FbYsnj6SeLGFg7/dUAyT0VCFMuKvLRZW8oz5mpPPT3rnZ5p+3
   BPmyo5uHRoHm626y2Koq3cTcTKq8mI8LfTiaywodKd2DbIAHJS5oixqwE
   g==;
X-CSE-ConnectionGUID: HdPx8U/1SASDGBRMDcyJdg==
X-CSE-MsgGUID: wYGJzuyGRSCKCLElHHHWxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="94526979"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="94526979"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 07:49:02 -0700
X-CSE-ConnectionGUID: JlF5twluQ2isQOUtV32xXg==
X-CSE-MsgGUID: Gzb1aWE4Sn6NmueYluiOgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="281233925"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 07:49:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 07:49:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 07:49:01 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 07:49:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMLjY+0K1kd9P5I8RZ7tqsYvgdsLve2XR1xKVkxZLXFiBKOa34eoTrPXM17M6E3sbKGw38LdOeg4yMVOomj9Lu3esztfe5R1NaMXe5YygAf5Kt0PQF1tq3B1HbXzs3CfHlgC8URIOZ66Y6M1rRK1NdHK0hCffl7VrwzKnDg+s44bmFNTtkm77p4GBlqsEos61qOBKWlRkJP3IoLQHkk56M1AmChrKmsEJuZT+d/fLhY4UBXIQhonCT6SA4umvTeVOW8z9hdBhVa3cFMMYZqwRW0edT/KSJhCVnTcYQfVeYXlt4YT+tpqT2CLZRLTs5iI1tAfx9OfRPGIiGLQAU56lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDurHpf+w3uUVKmUXbJZsV+DIMq/AALn2YlWxjaLm9I=;
 b=ThIHDZ1Jcz3opHfiZN6Dd95zwSbV3oSnYxykQlVCyWlGitaqT5KPemagoomY6cRH6LG0DjsC7ATQlizNqCKaxxu+la2IJBhsfuKonx+8K/Yh9rBg8JZAiigJjLwzR8FakUgDTIsPAhXxYsaxTtfJ1xcIks2v291rr3IKUt2vF4QPZp2qe92eA41Z/wTQkAYwsLrsyKk1dJk/uhok6KVajck6prydb+8llOAvRc2+Iu9yOM7qEfVqL4t1Qx81i8fh9qXRFfeKEkcRFEsRKjkNHWGDjhFaVCfmfgIsnluksyRBrW1VkyVrnE/Pc1emsbREiTTneAXbzcIW5hdv6xZegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB9849.namprd11.prod.outlook.com (2603:10b6:806:4d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 14:48:58 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 14:48:58 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xu, Yilun"
	<yilun.xu@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 2/5] x86/virt/tdx: Configure add-on features on TDX
 module init
Thread-Topic: [PATCH v2 2/5] x86/virt/tdx: Configure add-on features on TDX
 module init
Thread-Index: AQHdRPzQX5taAxNGkkCppHYESMqxcrbQHrAAgAjT8wCAAcZegA==
Date: Tue, 22 Sep 2026 14:48:58 +0000
Message-ID: <9cbc8edd0a2f21e69521a7f2dd9f1a1114f2362d.camel@intel.com>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
	 <20260915102658.713079-3-yilun.xu@linux.intel.com>
	 <2f6ac9afef52386fc491145222ea46e54c24a73f.camel@intel.com>
	 <arEYMCfdvmiqE4aR@yilunxu-OptiPlex-7050>
In-Reply-To: <arEYMCfdvmiqE4aR@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB9849:EE_
x-ms-office365-filtering-correlation-id: 1391ee39-a13e-4ea8-3659-08df18b8a22c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|23010399003|366016|376014|10067099003|56012099006|18002099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: ZUm0zAz8Q4EyvVB2mCWgcNn1icK1IvV6tSarAVoc6ROe4arPkMG0RiGuyhQ8/EOt4V5pvXNBtW8jcXJTIy9LdmTUCz/gUI4PZVUlczB3u7v6YZIFFS39bLjbs54yVbljzEzyFzMneeODwCDQsjkxUYSj6vxiz26LsDbPA4fm7aCH32rU+v8HUd/b+/R1e/iBMU00+H7gKpnl3s3DdqWSHChj7Gj0Cw8zaFNzhoz9UM0rXxnTIoQFjRjpeww4LyebzENTrtcpebguwmNatlg6PZEyTQA745U8v2WPc5cHU/5zWxZaCVXlqvdnTz93kXUHeN1jL9Dt3ruK43q2+ZWieTjqKGzlhVjM7WZDoi2VzEGETuYcMd8L11GOU0hzSrRho8amOu4b7whyiNlzu40Ts113Y3QvunftGf8mjZfAM60p59Vs4+bzQ8UuM9r92aB2lYgdAFnLTrg1FS58j0+9IeWEYfuQM1RPtqSfvLPzc6+DZ9Bkto4Pc9GSylwg+PAOLJk96YULMZyQWS6PCNBeQWtzIUKnUbh4MTYGPV25jrPsMD8PPu87DSt88jDIXzDLbWJXkeDMq13eFamAQ+0bYDMZDLi7KoQgVzjuBm2dR3sh3H6T5QU5bp1q7/l9Bwj5j/4qnR1eX8gF+X2ykKt326+IUm3J53bj9E41OJ6WWge1YBfIaPv4Yk2a6+7WY/LK26jZiTLETpMvYhVlN9VCJDx9Q7cXSYVJxXSs3v2nGCw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFJ3WnpJcDlobGNQKzNubDBTSWcwVCt2OFpkMTNmVE1INDllT1YxY3VReHl1?=
 =?utf-8?B?T0JYR1hYalZWc1Z2eXBhbVRCU1U3Vm9TejRNT3lQZVZyM0NRNGhFblE4Yy9I?=
 =?utf-8?B?MCt3QU0wUE5mMk5JS3EzdHdHOEdpSUVyZ21zYUVzeTRlaWJiR2h4dUc5M3du?=
 =?utf-8?B?MXJVK2lNdW5mQzBJTC9VYm5aWXQwdDE5eXpjb0NpQ0tRdlViU2M1ZWtuZVQr?=
 =?utf-8?B?Y0Z3aGRHWDZzU1lyUFh1WTFZeXVGdTEzbkNNWXJMcGdzcjVkdE84dUJxT0xl?=
 =?utf-8?B?TWpibjgxN3NxZDh0RGdMc0tyeFMxK1pPa1ZpdHd5TThWUktsVmQzZ1NqVUJO?=
 =?utf-8?B?cHZRczNhVjhGeDl4Tmw1UWxac0s0N0hYQnJxWDVYNUU2TzNpbFZJYkhUa0dI?=
 =?utf-8?B?V1NJSTR1SngrSDdPQzBabEFESk1sMVNCQzhmd2k5RkZkSHpNRTFNSEIrcUZp?=
 =?utf-8?B?Zjk5VXZIOS9yUncxOENxZ0lTbTBUTDBaaUpiako5QlpHTUF6YlgwMDBpKy91?=
 =?utf-8?B?ZzhrRm93WmxBWCtCREpLUllJazdyMnIycS8wSWc4ckdkUGZuME5uTjlJMkdy?=
 =?utf-8?B?Q3E0RjZLTkV2S3QxSERqTlpMb1p5bWlrZGtOSG5hdHRyd1Z5WjlKWmhNVEFj?=
 =?utf-8?B?MzNCRWtmQTVkaUlndUR3b1hkWEVvM0RWL1NVV0h1WmluM09Pei9FMWFnd0M0?=
 =?utf-8?B?NGZybkRRWW43VlI0VmdJaFhLZExiOVZpL2IvblpxOVRJS2o0TVlUdXV3VDBP?=
 =?utf-8?B?SlE1VFJRdlpZdjRWWCs5NkRZbE5SaFNscXJGVVJwTVRGWVNNaDFhaUpMNktB?=
 =?utf-8?B?dDRwTElxc3FvejViVkw2c01PenJ6STRnZVl2VGdFNFEwK295VGd5RXc4Y3Jn?=
 =?utf-8?B?NGtlZnpKNUtrcEM4aSs1TktFNHMxbzhFN3JuRU1sWmU4WEtiSkdTa2FXZHVR?=
 =?utf-8?B?aVgwSldOejNTMjBWMVBlTVM1blJxMTRUNzAyUWM4NE5QdXpYckJhcGJJMHZp?=
 =?utf-8?B?M0gwa3JSelFxZnFvb3E3ZTFwM3g5cXpiMUdFV0JJZ2E0UXZCTVBJS3pxckhC?=
 =?utf-8?B?dDdEMnZVNUFhVFZGcm4zZGZMTDdSMjEwamVBRzVJY2FRQ1dsa1pSYUhLMG1r?=
 =?utf-8?B?ZWk5N2h0QlBSZkpFcnhWRTBheHBRUFFvODFDMFB4OWpqVjRzbHFFSGhaZW5G?=
 =?utf-8?B?MlJOdFdXelEzVVVtOVJTN2RmMmxvYWpnYjFSclhwQ0RVUnZhZjhpMEVZSjRh?=
 =?utf-8?B?UENYT0crZ0dXYkxmVUxjL1lvSGprUmtnWURGVkI0TTkvYUxSSWNNUmw2WVZY?=
 =?utf-8?B?cFg3d3dEWnVxbWdMUkVMVmtZNUZRcVV2M083eVZtTnROL1hJSVo5QkYyMlJF?=
 =?utf-8?B?WFNzekVVK2pNZnA0MThGTEJ1MnBndlAzbVdRd1I5TkdWbUJESVVNNThPUVNh?=
 =?utf-8?B?RFU5ZTVuS1AwVlUvTmtyZlNhY1podGVkalFTVHRuTmhGTlBCb0xjQ29NaGpN?=
 =?utf-8?B?L29EU1ZycEkyVElPd2U1eUF6NUY3MlgwcVF0WE90a0pDZ3JjR3FhNDdVVHJo?=
 =?utf-8?B?N0ZWT0UrQWt4eTR5TVRQOGpXWDNVM0pmemtuL1dZdEhLSXExN2t1Nzd2REwy?=
 =?utf-8?B?WmZqMHJ2WkRVYTMwcGc0MnRnaVhvMzYxdi9jWEdIdmwza0xjMXJEWVh5NGo3?=
 =?utf-8?B?QjFOYUR1dzFPMWJYWEZvVnpUMytaSnNSM2N4S2F3QlNEZTArcE1IZmRVajdj?=
 =?utf-8?B?VXBhenI1SnB1YVNqck0xMTFDTTRJNmtUejUwYnE1WHBkdEdDMUVPaEdZT084?=
 =?utf-8?B?dUxVY3lVRGk2VENibHdXNDhqUXdVYk9QMzQyelNmVmNDNUZTcUNOSmd5Z29E?=
 =?utf-8?B?NlFjaGN4UnpYa3pjdHFOb1J4ekJjNERySjF0QmpKbjZIVVQzS2wvVGY5cGR6?=
 =?utf-8?B?V3VDUnlpOS9pamFsa3prZjdOOStwanRqTUFEdWdyZFdSQVh4OXFRWVM2b3NU?=
 =?utf-8?B?ZXJMcmZNa2RsZlpFajRmQjdyK2xuWWg2SHRNK1JOcGZhUmlGUytTMFZtSHJ5?=
 =?utf-8?B?RHk4aFR2Q1AwdmpGUGpoKzJiTk9JZkIyQ2dFZmwwalpNbC9rd1M0V3dLN2lT?=
 =?utf-8?B?azNLbGFveVM2Snpqc3c1Ulk4YUliUHNWMmJFZW42NmxvMGtVMFArZlB2MnJJ?=
 =?utf-8?B?eHdTN1hMdnkrNFR3R3N4d0Q1TU83dGwxMW1MNnFrY1BaVU9DSjhhMkhYdFRI?=
 =?utf-8?B?WEE2dkE5eFNvUHlHOWlLWGpmeTQ1STNiY2FSV0QyZWdOclJKMTA0WWpOTjNJ?=
 =?utf-8?B?aHRsb3FXTEFYRmRMWXVtSzZWTlN3V1FoTWRraEpkcmsxVzhvSEFKSVlVSGdI?=
 =?utf-8?Q?a8iVHdWuTD1ZNAO8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E4297947AD7504E9BB04CF765D5147F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: S7XbUj9Q6Da+4X5T1lfUpJAudXU/dgOlp8AVRZPoKz8d1auKJp60wuinc++U1xYH24VtEeLE5nhhR95iNWydNwsnPGYPHfR+d4/ARfR3k8paHBfMoYkfk5U3N4aj+YCxfVPZSGVmnNXQTASiokS1EhLnupqeys+X1yVk4l1wn7VAG8i8t8YvvOeECgHnc+fXGevoO7d82pkgT5Z8yvRSSurKNyAacjDzVmaAikKkXVhVpACXYlPUTZNHT3PUpl0J3T3/IFE8xmuz8d+KB/rZBWcfhVB5IMrOC3lanEALZqZKfEEXKBiwss6xC4oxF/edpiYwwY1bRqN634zJA/yMdA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1391ee39-a13e-4ea8-3659-08df18b8a22c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 14:48:58.2946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYIRFwrGq+1flFunm9vxcomQEr7d0tvrYMISUMPuvlp+ZDuXzlCF3R7zZ7PZ+OXO0BjzaVfIjyRXw5xfEayNRcgO5vq1/+Iz1gRYf90WWxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9849
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTIxIGF0IDE5OjQyICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gPiBJ
dCBzZWVtcyBpbmNvbnNpc3RlbnQgdGhhdCBnbG9iYWxfa2V5aWQgaXMgcGFzc2VkIGluIGV2ZW4g
dGhvdWdoIGl0IGlzDQo+ID4gYmFzaWNhbGx5IGdsb2JhbCBzdGF0ZSwgd2hpbGUgYWRkb25fZmVh
dHVyZXMwIGlzIHJldHJpZXZlZCBmcm9tIHRoZSBnbG9iYWwNCj4gPiBzdGF0ZS4gUGFzc2luZyB0
aGUgcmVzdWx0IG9mIGdldF90ZHhfYWRkb25fZmVhdHVyZXMwKCkgaW4gZnJvbSB0aGUgY2FsbGVy
DQo+ID4gZG9lc24ndCBtYWtlIGEgdG9uIG9mIHNlbnNlLiBBbmQgd2UgYWxyZWFkeSByZWZlcmVu
Y2UgdGR4X2dsb2JhbF9rZXlpZA0KPiA+IGdsb2JhbGx5IGZyb20gYW5vdGhlciBzZWFtY2FsbCB3
cmFwcGVyLiBTbyBJJ2QgdGhpbmsgZHJvcHBpbmcgdGhlIGFyZyB3aGVuDQo+ID4geW91IGNyZWF0
ZSB0aGUgd3JhcHBlciB3b3VsZCBiZSBiZXN0IGluIHRoZSBlbmQuDQo+ID4gDQo+ID4gVGhlIHNt
YWxsZXN0IGNoYW5nZSB0byBzdGF5IGNvbnNpc3RlbnQgd291bGQgYmUgZ28gYWRkIGFuIGFkZG9u
X2ZlYXR1cmVzMA0KPiA+IGFyZyB0byB0ZHhfc3lzX2NvbmZpZygpLCBidXQgaXQncyBoYXJkIHRv
IGp1c3RpZnkgYXMgZ29vZCBjb2RlLiBJJ2QgbWF5YmUgZ28NCj4gPiB3aXRoIHRoZSBnbG9iYWxf
a2V5aWQgY2hhbmdlIGFuZCBpdCBwcm9iYWJseSBpcyBhIHNlcGFyYXRlIHBhdGNoLCBidXQgd2Ug
YXJlDQo+ID4gYnJ1c2hpbmcgdXAgYWdhaW5zdCBtaXhpbmcgY2xlYW51cCBhbmQgZmVhdHVyZSBl
bmFibGluZy4uLiB0aG91Z2h0cz8NCj4gDQo+IEknbSBub3Qgc3VyZS4gTXkgdGhvdWdodCB3b3Vs
ZCBiZSByZW1vdmluZyAidTY0IGdsb2JhbF9rZXlpZCIgYXJndW1lbnQNCj4gZm9yIHRoZSBuZXcg
YWRkZWQgdGR4X3N5c19jb25maWcoKSwgdG8gbWFrZSB0aGlzIHBhdGNoIHJlYXNvbmFibGUuDQoN
Ck9rLg0KDQo+IA0KPiBBbmQgdGhlIGNsZWFuaW5nIHVwIG9mIGl0cyBjYWxsZXIgLSBjb25maWdf
dGR4X21vZHVsZSgpIC0gY291bGQgYmUgaW4gYQ0KPiBzZXBhcmF0ZSBjbGVhbnVwIHBhdGNoIG91
dCBvZiB0aGlzIHNlcmllcywgbWFrZSBzZW5zZT8NCg0KSG1tLCBJJ20gbm90IHN1cmUgYWJvdXQg
dGhhdC4gSSdkIHRoaW5rIHlvdSB3b3VsZCBuZWVkIG9uZSBwYXRjaCB0byByZW1vdmUNCmdsb2Jh
bF9rZXlpZCBhcmcgYW5kIHVzZSB0aGUgZ2xvYmFsIHJlZmVyZW5jZS4gVGhhdCBzdGFuZHMgb24g
aXRzIG93bi4NCg0KQW5vdGhlciBwYXRjaCB0byBleHRyYWN0IHRoZSBoZWxwZXIuIEJUVywgc2lu
Y2UgdGhlIGdvYWwgb2YgdGhpcyBzZXJpZXMgaXMgdG8NCmdldCBhY2tlZCwgSSdkIHRoaW5rIHRo
ZSBjbGVhbnVwIHBhdGNoZXMgY291bGQgc3RpbGwgZ28gYWhlYWQuDQoNCj4gDQo+IG1ha2UgVz0x
IGRvZXNuJ3QgY29tcGxhaW4sIGJ1dCBtYXliZSBzaGFzaGlrbyB3aWxsLg0KDQoNCg==
