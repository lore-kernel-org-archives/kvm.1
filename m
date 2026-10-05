Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83C37D133;
	Mon,  5 Oct 2026 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239537; cv=fail; b=CJmrtOqlfcmkgRbpa5l0MWzdMwexoYFZa4z8qbCjWhsvO2sTOCqO43DqKmc8OV/R+lI71gctkjU2/WHrqHsoiqFjJ1jCwgQH88RUryguQpE7JPiytZ02wlGo+tQkc1mTwg+Knx50awwgTQgzf+q4sWSolcnnV5KmMtf6qnLAJUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239537; c=relaxed/simple;
	bh=v0jxBdB7jwTSNMYbsN6PDXS7MRX/PoYT/1+UzCQ46B8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pIeCeNyLZcebyqiMvbh4tTU3jbq5Omd4EPpqie0PtUN+ctiO5IT/dBFqsBr2MCsKXixnK8yUL0zLijJtwpC/lxqZUJ5p1lX61oEwXa6BgWYXLAsDWWXLQSLzF4wPROfMe+ajs4AcQpVNYtm2neIPw7ntZRxbTVp6RFzeewOoriU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VyTVb0TY; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VyTVb0TY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791239536; x=1822775536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v0jxBdB7jwTSNMYbsN6PDXS7MRX/PoYT/1+UzCQ46B8=;
  b=VyTVb0TYIDsslwEd9oEX+YgPS/FslaKQe0wSIoqn8uwxp8k3gSZgPJy6
   3QBkHSs+pum/hzoPJ09T9gRe9MwIbGn4p0aOLc7GoqsAxxEhwspFiwdgb
   HDI324mKG45wWUA6FgLZvx22HdN8MGUHDD82Js+kdGjmxdKw7LYUMCiXr
   xGb0rLU/7R3O8MjBetybIOJrv2amnc5YA5wSeddwYdhB/VbySz6nhFt/u
   sUCUBikLUUC3774oj8yk5e0lwfzG9KoK1DPa+urXbnOGhWBqRiuVG5pZb
   0BUlq2eQ6BwkOjnu5tn3ld84PqDgvKVtKT8iBpNMrEsz+uFQqGFQao4hS
   w==;
X-CSE-ConnectionGUID: NOOu6VB6RuWE+h/E9aMjNQ==
X-CSE-MsgGUID: +r3bjitYQdmIbxPpYw0Z2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90876386"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="90876386"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 15:32:15 -0700
X-CSE-ConnectionGUID: qNV2S0jATmK1LMT+HllqPg==
X-CSE-MsgGUID: 5E3GJlWqQCShJ8TPGVNarw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="281722208"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 15:32:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 15:32:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 15:32:14 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 15:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oac/1mnjhSwN1A4eJcrgj235mFfaFNe+yzPs2Ir+KAw/9/4MbOP/VnThscSkh5vAwSiiCT19p8QqCEYn+npQS9Nra8W00cqcxJ2bSmCsxJNmIOALOOht2ER5OH1lesG3c4L7KrA0Ycy9B/XR5LeyRHqs0egDWgjtOfmhbgXsi6uM/FwxuImtTrZyMR2c2pVmYBJbkb3ZUXHY4Zt5Y2Wi9afF5FYv2ghYQhWA9xw0jzWRz5oWqCCqWnL1ZOeqxvuum1pwQkBbeMBWM0JaZcE186QCsdMO4pZ1nXuk8qOe9ERUky1T8JCoAyYEgo5fVKKfsRMgPvHjCmSPMJt2XP+5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0jxBdB7jwTSNMYbsN6PDXS7MRX/PoYT/1+UzCQ46B8=;
 b=iIce8X+McK45X5auLboNrH1Ae8rV0dmT95sl4+4T/H6L37O8TfNbFjhGVLt8/EPuk3h9vVqUvOzFmBtFIyXNIgWgEb/OwmEfHffE6g8Lo6fD4xJjEuFHbTxjX6cGKojx+4FsCnx0l6hb2JVx2kuUuXaW5RttiYJVGRhcPZvAUAa0mgNejLDiji5no5izrgu135o1SGK2+rpoqYHS/5e7OyXgvo3p+acM/JQcR15Mu7hQ5mhvI7dsukQKsWvuuCjIL/BpbcnTv5tYkEsA20TGhMAoCXCOt0T/cAaS2OBcDBcHZ87y77ROsvW2XQ2oi+ZEuoCoLEfP+xc5aQS5Mla4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by BL1PR11MB5237.namprd11.prod.outlook.com (2603:10b6:208:310::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 22:32:12 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Mon, 5 Oct 2026
 22:32:12 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "syzbot+db7bd0f41c2a7e82d4ba@syzkaller.appspotmail.com"
	<syzbot+db7bd0f41c2a7e82d4ba@syzkaller.appspotmail.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [kvm?] WARNING in kvm_vcpu_pre_fault_memory
Thread-Topic: [syzbot] [kvm?] WARNING in kvm_vcpu_pre_fault_memory
Thread-Index: AQHdVRLnqtPqeYT4gUSIxJON7CYlV7buT8qAgAE4yYA=
Date: Mon, 5 Oct 2026 22:32:12 +0000
Message-ID: <50f4d848237a97fce1251901603d765678ccb58d.camel@intel.com>
References: <6ac316c7.01314a6c.556a8.000d.GAE@google.com>
	 <asMfCUiPnW-GGu5J@google.com>
In-Reply-To: <asMfCUiPnW-GGu5J@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|BL1PR11MB5237:EE_
x-ms-office365-filtering-correlation-id: 4b110901-a9cd-4b9f-b7ac-08df2330801a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|4143699003|10067099003|56012099006|5023799004|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: YDS1e7dX00mhB0HZYRGRKa7ECvTpRM84HM+ix7qJSkWD2M5E4EZ0deArFds/7APRTs8J239dS7bK/hpRIMt92YZ+wmGv+9ptyHQ9dp09YHVP8GfZh4o2F32SNU3dwvp9F19U11QIOeTCJykdfht2czlwnwrlFAqakSOnjVqWykvaG6/f5IFy8sxQNBDOFR9ah/LZlkKdbwNYt8xlpQOyFsivJ6YxvwpFSHSIe5N7wTi9dUIv9aJ0kwH6PjE3RMsszKy2xWbjm7u/7vm1MrOS8L9Wkt6DdENKz7aYID+k0uXQD4iYPpPG3L0oy+Sj7+HyQwGswutjeztZ9lcydN1zGCHsXLMqdn6Ubh9gwfLFBJJmsUH052DwI+qIcegAZTiWalLuXkAJEah/KLUVep1Yhzut5EVjTWgxOSFvkNeSw75Kak3UVcWdHZItsYXMz1vI+bZmnG9rtq8jS+QAXcg6vE1W+nJH1JQ5iZj6UOIINY4kUf9U43/m5dUz95jmuwj2G6GHwgZdjfw/qig4Uy/qRo7JUQNge7TxxJRLf84pGZ+OwqFdy/hYayrJPIvrLYkGW5GRFbZz034ZQMgtzbLa3fXbveh+EchvXqoXE5tpe84Aj5/AtsXPVHlHD6jKLDRHVwic1NiO0vc9TUt/qQHrXxuEa/9y425Ch3tMMpHMfwg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(4143699003)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHpMVDdsWmRXcTdaNjA0NkhUd0VyVUQ1dlJ4T29QL3NHNnBUTWFhTDlUZGlK?=
 =?utf-8?B?dXBpdTg2QW8xY3cxZjQ5NG1LYzh6ZmJVTlJsUlZQYlpmeUlYQUt5NEJmVFJX?=
 =?utf-8?B?K3MyRWN6V0tjVlVxU041eTl0bEducFc0NTFSRmFyRmdLcjMyMmoyeGRtL2Rj?=
 =?utf-8?B?NWd4OElCRmh5cGQwVFY0Vm8wZW5idFZHS2ovS3c4MmNKbm5od3c0bVdMTDdH?=
 =?utf-8?B?SDNib1dKMU9mTHBJTk9DV3NRWCtkU2ZBelAwd2greEFJUlBNMnljU0V2d05O?=
 =?utf-8?B?Qi9WaWNDTThOMGNvQm53NHBKckZuZkdObkFYN2FtRVQvTXphcm5rSlQ3Ynk3?=
 =?utf-8?B?YlNobi8zVEFaanlUS2ZyV0QxaWNIbjdkWjBlV3pRbW80RmUwMER2aFVtN2ta?=
 =?utf-8?B?ZWZFT1NVeC9meCtDVDhVNExrc1daSlhiWWlyYUE2WkZXa2ZWeXcvaFR4Mk5J?=
 =?utf-8?B?YXd1UXFtbE5hVmNSazVLQjNibG1TTlNiQmJTZDFjeWVKOXdYTzRHMnFTMUtn?=
 =?utf-8?B?ZUU3cCtuRGM4RTFuTjdzRlY1Z3Yvc0V4RThrbTZRNzUvTXN6TVlCUzZTY2FS?=
 =?utf-8?B?TjFadXY5NnNDUHRDeEttVUxYQ0w0Z2g0WTR5VDNROTEwWHVoajNZZzFYRXRo?=
 =?utf-8?B?OHk5QlB3T2FqSGwxVDFldUtjYnBUSnVEd0dFTmdNd3VwRlpmdFk3L0RmK3VQ?=
 =?utf-8?B?RG1NbjJvZVhyUXczRVRYaURWQ0pLa1dBa2hzQ3laTHVrR1FjMll2aUNBd3gv?=
 =?utf-8?B?R3VNTTFyUjNZOHp4bW5rcXNxejVaRnNEK25pQ0FmT2VoNS80NnVBcTZTV3Yr?=
 =?utf-8?B?NWdNaU81MytXZ240dEtKbDVBanIySU1SN1hzdGVCSDdSWjI4aEhzalh4SUpB?=
 =?utf-8?B?cFE0Q3IvUVJZazZOUGJ3cnlQOUVFLzh5bmJscXJtZFltMnMrSEZ2cXN5WFNq?=
 =?utf-8?B?T0REYXBUQ3FSVC9SZzQ1cmpOUmw3S1NHdHZLUWJzTVFNWkVkUENaN3NzMmwy?=
 =?utf-8?B?ZVNPWkMxUWtLQksrL1dWV2xHdzlQbnI4b2dkNHZOamdYdEttV1M2c1VsZjRE?=
 =?utf-8?B?OFk2SWp2amRrOEVzTkdNb2ZYVjNxYkhHR3NBL1NSOEswREVOOVNVYXJ6OW90?=
 =?utf-8?B?ZlZPdVVOTk1TR3VDWS9udkpCNE41YTVlUzV3WWRQemt6UkVrZ1FvNytTNmIw?=
 =?utf-8?B?R2Z6UlBWa0pOQWs0OXByNGNwNnJNTkU1eHRTT0VkVTExWm5LYk5JekpFdzlP?=
 =?utf-8?B?N3lvZnlRdGt0SWZaaFpOcVFUQWs5dWpqbmdNY2xZY1pVZ2h2TFJ5K2hiMTRC?=
 =?utf-8?B?UTQrc2NvNjVPbmlZcFFaKzlJZmlTbHJFNDJkN0pUbXRydCtpeUpsajFNRG4r?=
 =?utf-8?B?Y0NueWJ1ZUtObk5HS0x0MGtYazkvcXRWRFk5TTlUT3ZlTE1BRVhBZzY3bHRH?=
 =?utf-8?B?Y0JMbXlJRmlWc1luNUZ3ZnF6L3BWVEJHek9KVWw4RVZ1SmMvWk1zSkg1VGFX?=
 =?utf-8?B?b1ZlSHZjRkZObUNtWlJLU1BVM3orNFRFSCtreSt1cGtYR2c3anVyYTdUVFFk?=
 =?utf-8?B?amUzdmdnNDZ1V005S1NtSDFiQjh6RUluVFZHS1hMK1FUais3bTM3OXJDM3Fw?=
 =?utf-8?B?UHQwMmI2WHdhZ21UaXJiMDdjQkhRUVF5QTZLTzlMR0NXdm1xTDhOTTloc3VN?=
 =?utf-8?B?RkhzTGhrZlVCbFBiNkh6aWM4Y0UzOG04QTExNDZlY3UxR0ozRHBaQ1A1TXQy?=
 =?utf-8?B?MndZNUpVZ2NuMXZPbnFXdUtEZFBTTzlXckNZaVExYVgxbFlKZWZIbXlTY0Y5?=
 =?utf-8?B?K2J3Yy9QQkdqVngxZHZBRlBHY2dKaXNqQXQweEhBblk2aVpZZHdFbjJGOFdG?=
 =?utf-8?B?UlBYWXpwSUNSWmF0dUtKQ1NEcjk4SHFqUkF3dUUyNW9xVitBa0I4SFg0OGRW?=
 =?utf-8?B?TU5pOEVTTG9zUzNJcGg3OFRqckd5WVdzVzA0VWNYM1dGcGxoWkREY2ltR0l0?=
 =?utf-8?B?MFYvR0ZzbjZSNGdBa0F5ZUtaS0R3eTBXWElUdHN2YnR2VDBBbDEvS3Vic3F5?=
 =?utf-8?B?NTJ1Zng4N2NZcUw3b2hPTlJXVkQxN1ROMHRZa1NnU0lDbWpUcU5oL2tVeVMx?=
 =?utf-8?B?enJaMU5RV1JlMFJnOGdNRkNRSFRYaFp6eGNraXVJVEpNRVFybXdPTDdZeXQ2?=
 =?utf-8?B?UURrQVpUOHJwUHhpT3FpOTVHQ1lONm5tT3EwS2pkL21reGVIRnZYTXl4UHBM?=
 =?utf-8?B?cGJuWGpVVWZuVmU3QnFVWTBBOFhUM3lyT3pnY0pHQ0JuZytlYkN0NjlubzM2?=
 =?utf-8?B?Ti9TeGlveXhHV200OCtjV2l3azZLMFlWeG9KUGg2anNmaXIzN2tyTFBnV2Nq?=
 =?utf-8?Q?ODRQEM3/LSIKjXGQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B40CC3B84D5FE643A1578F1E1CFF1DA9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0VlxCsjp4Tfapl2wCoFun6XeXEGznovSvHH388e/OnEnbYiLp+EP4BGwj4UEqtLCYpZfIe9i8BWqtb/I5OIyoAOzZmwGc0IK1qLXFDYSnkOTmlvzI3anxvpTRZ8jyZ5Bnc98oH2wLEe+F9/e65ll3lRSSIpucqc8kf/QamJKGpVO6TOkjtVPhZLAZFqVXpoxA4J92LRBwKhjcOXWegi6L6RdN6rYIgbaiBDQ0phGpCO2I1lxofOnswcb6uhBVX4sUXsfAHFXkimHQncx7/mJFwQD02wNU1MzhF0lQyZ9qjQfsXlQYIreY/OwKcA6hFcTyYdRLr8bnM5m82Df9HSaZg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b110901-a9cd-4b9f-b7ac-08df2330801a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 22:32:12.4022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsM9hQNwID7VZGQYVKPA1I7lpEV1yg68U8DbYWnzDZEKgptv3ddB1LnI27ofymAZEAmi9iVRYL2/hODj+8oprS/9XCxrZ3V3VNJLiJjVptU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5237
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI2LTEwLTA0IGF0IDIwOjUyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBJIGhhdmVuJ3QgdHJpZWQgdGhlIHJlcHJvZHVjZXIgeWV0LCBidXQgYmFzZWQgb24g
Y29kZSBpbnNwZWN0aW9uIEknbSBwcmV0dHkgc3VyZQ0KPiB0aGUga3ZtX3ZtX2RlYWQoKSBjYWxs
IGluIGVudGVyX3NtbSgpIGlzIGNvbGxpZGluZyB3aXRoIGNvbW1pdCA5NTg4MTBhMDk0MTJkDQo+
ICgiS1ZNOiB4ODYvbW11OiBCYWlsIG91dCBrdm1fdGRwX21hcF9wYWdlKCkgd2hlbiBWTSBkZWFk
IiksIGVzcGVjaWFseSBzaW5jZSB0aGVyZQ0KPiBpcyBTTU0gc2V0dXAgaW4gdGhlIHJlcHJvZHVj
ZXIuDQo+IA0KPiBJJ20gdGhpbmsgd2UgY2FuIGFuZCBzaG91bGQganVzdCBkcm9wIEVJTyBmcm9t
IHRoZSBXQVJOLsKgIEl0IHNob3dlZCB1cCBpbiB2NSBvZg0KPiB0aGUgb3JpZ2luYWwgc2VyaWVz
IHdpdGhvdXQgYW55IHJlYWwgZXhwbGFuYXRpb24uwqAgdjUgZGlkIGFkZCAtRUlPIGFzIGEgZG9j
dW1lbnRlZA0KPiBlcnJvciBjb2RlWzFdOg0KPiDCoCANCj4gwqAgdjQtPnY1Og0KPiDCoMKgwqAg
LSBhZGQgRUlPIGFzIHBvc3NpYmxlIGVycm9yDQo+IA0KPiBpbiByZXNwb25zZSB0byBYaWFveWFv
J3MgcmV2aWV3WzJdOg0KPiANCj4gwqAgPiArCWNhc2UgUkVUX1BGX0NPTlRJTlVFOg0KPiDCoCA+
ICsJY2FzZSBSRVRfUEZfSU5WQUxJRDoNCj4gwqAgPiArCWRlZmF1bHQ6DQo+IMKgID4gKwkJV0FS
Tl9PTl9PTkNFKHIpOw0KPiDCoCA+ICsJCXJldHVybiAtRUlPOw0KPiDCoCANCj4gwqAgTmVlZCB0
byB1cGRhdGUgcGF0Y2ggMSBmb3IgLUVJTw0KPiDCoCANCj4gwqAgPiArCX0NCj4gDQo+IA0KPiBi
dXQgQUZBSUNUIHRoYXQgd2FzIGp1c3QgdGFsa2luZyBhYm91dCB0aGUgZG9jdW1lbnRhdGlvbi4N
Cj4gDQoNClllYSBJIHRoaW5rIGhlIHdhcyBqdXN0IHNheWluZyB0byB1cGRhdGUgdGhlIGRvY3Mu
IFRoZSBFSU8gaW4gdGhlIHN3aXRjaA0Kc3RhdGVtZW50IGluIGt2bV90ZHBfcGFnZV9wcmVmYXVs
dCgpIHNlZW1zIHRvIHN0cmV0Y2ggYmFjayB0byB0aGUgb3JpZ2luYWwNCnZlcnNpb25zIG9mIHRo
aXMuDQoNCj4gwqAgQW5kIGF0IHRoZSB0aW1lLCBLVk0NCj4geDg2IGFscmVhZHkgV0FSTmVkIHdo
ZW4gcmV0dXJuaW5nIC1FSU8sIHNvIEkndmUgbm8gaWRlYSBjb21tb24gS1ZNIGFsc28gV0FSTmVk
DQo+IG9uIHNlZWluZyAtRUlPLg0KDQpJIGFsc28gY291bGRuJ3QgZmluZCBhIHJlYXNvbiBmb3Ig
dGhlIGFkZGl0aW9uIG9mIHRoZSBjb21tb24gS1ZNIEVJTyB3YXJuIGluIHY1Lg0KUmVtb3Zpbmcg
aXQgZG9lcyBsb29rIGxpa2UgYW4gYXBwcm9wcmlhdGUgZml4Lg0KDQo+IA0KPiBbMV0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwNzEwMTc0MDMxLjMxMjA1NS0xLXBib256aW5pQHJl
ZGhhdC5jb20NCj4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9kNWE2ZTEyNS1iZmY0
LTRkODItYWU2NS1iOTlkOWNiMTBlOTBAaW50ZWwuY29tDQoNCg==
