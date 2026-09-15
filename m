Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592347DFBF;
	Tue, 15 Sep 2026 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510202; cv=fail; b=npELy6iIpDkjgXO3OLkyZusdshKPkyfaJ457/Kwhu2ButWC9EgVOhMkNMgdR2zwQQTm44y1LglOBl0+GMh+00g0BGjgwCkb2vlb5kFeBhcfX3dKZWycJqSA/BM9Zm4zu5VP+VzltpVXx2K6N6FLfteoEJtfM/VZAeEHNM6Qd1Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510202; c=relaxed/simple;
	bh=jNNZ+WeSPPDBnL/Llrawol+LPm4qosITbBLCInjizX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RZSfaXnIYAhWI9K+wjljYQZa/DdY+ND9w9UslWQynD01/bZthU/FONPuIFAJytxaRMOq4PYAdgMGZiNyDwWPtiZ5oAbXJYxlhNz92kJBgZ6zSyren10UPtJnxFfRqPopDu78Us3NGNulMDzrB6NIJRfU2KUL16ddxOfBq5nlKsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Es12To/P; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Es12To/P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789510200; x=1821046200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jNNZ+WeSPPDBnL/Llrawol+LPm4qosITbBLCInjizX0=;
  b=Es12To/Pogvf70hnzyOmF2fKR2RM3VVxK8wqrhYocNy6OVV1M7IUTLgs
   wXnY9XocJHR+lIBUlCkmqSMemroZ8/5M+XH7Xt4u8I893tI8V07/UupFl
   /Ydbmzd6sPoa+nuvQAKJOaj1M2/EywH9cY4ecYlUOQytPbHcbIaTG/tsp
   K7UdMJMOT+m0Tznhzc0307f2zD4vnB37yDjHEi0U1ipYiO+HmCbX3yEtp
   Un17wlETPl1XZ0VzixEs8oBVRaSnJ9DJI0pAmhUI/U/vEFKHS/TgXg9fu
   V5hXDXJrqCZEdMGrrrHX7okkj6O2Luisy7+qz78JaHGQNpHYL7gWrcV9t
   A==;
X-CSE-ConnectionGUID: +5aRJvomSXq+D8ctzHeyRA==
X-CSE-MsgGUID: fWN1rKm9QGexYZ68dvX/vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77446222"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77446222"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 15:09:59 -0700
X-CSE-ConnectionGUID: 0OD8N8rIQ++9Enl9P0bn4w==
X-CSE-MsgGUID: g/IibWzFQa6LkE4TDlGEvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277265322"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 15:09:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 15:09:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 15:09:59 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 15:09:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hG9nc6PHV1Iw2N4vljvUtlL+6Li/mFihaKhGPMydBkRQYZQb58/Xf/kW2nq+hpBNF4q9ZBt14Gb2Q1V/lMZB3j3WcCDMyxd0zsSUf8boGu9oxHXdrqXmV998EBZszn/PSWpId87hAgEwnHrswUFKe2hyo9Ml03qsQUZediRJrLOSg2VhAzUXZs9XFWrUHT+TXXu5UGkAg0lzi+pGqToPB9QTx1Ud0UIDH675xyHBtlGMGRXbPc4QwudkgvYrz8IbGYpvxnl1+wgQYYWph7EiA6Jv4cP8Il9qpHoZUlCsb2hVyHgmVEg6kw7KitXBFSJLmCrWmj8FIe/zLZ0fv4kflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNNZ+WeSPPDBnL/Llrawol+LPm4qosITbBLCInjizX0=;
 b=Hn44/adErplpuSNWjUW7j+57aRcZGqsnz5PQkEKZCCLaiOdxV1YSNYubSZJS9uwb6qYpMXxDoOwYv8IvY4Dh+0R6eXLE4PDAgupGG7BApPJaq22hdqe95TJ6wRPpD7X28V4PMKlWXJy0A8MFrrBVB/zCKsJMeVZuj5+HqnrEfHJFT40/pHU+qoMe68KMMIwG5APV3wVGrVDxkgOzkmRvosfCsgeuJSynNXzsQYRhbulmUN5XMf2reBdlm/apJVIya33/aNNIS5lCxL8+vM6/7UWJ97Rg4xP0nzHOWgJyNU/p39iMVwYZ6AI93a+9QKMc/u6Ow16+yPCIcy66GtoWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by BN9PR11MB5307.namprd11.prod.outlook.com (2603:10b6:408:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 22:09:55 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 22:09:55 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v2 0/5] Enable TDX module extensions
Thread-Topic: [PATCH v2 0/5] Enable TDX module extensions
Thread-Index: AQHdRPzHp2fMpws3+Eau0hO9q5dnNrbQM+SA
Date: Tue, 15 Sep 2026 22:09:54 +0000
Message-ID: <20df772d83f42efdc0ec69a5a3ffb15e91910b85.camel@intel.com>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
In-Reply-To: <20260915102658.713079-1-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|BN9PR11MB5307:EE_
x-ms-office365-filtering-correlation-id: a077683a-ca52-4ce7-563f-08df137612a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: RjYhCjX2ObLE8FLGn7xtTC1UV862dvWvey6PCEtG6aTd45h17grhiBjTY6XahhWCLVKCv3Rt5WjkZOuza0ljD7f19xiy73G4eLiQpnVDGV01DVX/UFHzy0DcWQXCs92beCxBecwhE0z8gC4+y4e4VJ0jETMTdR0PlKsYljQBO+jv0yxhGWkS0srEiUuh/wQY8WmdA2SA+KhO9Wa58rstUvynWgOVCW0ABZp1KJDRinnuceKT4uGuCUCIIT71bl9gsM8vryWjcPWXl3onkMdl+oRt2zjOEr19KLMpbaeE/64805rNvKpIEeMdbaaPuCU/wGubFE4yMdkRpUGtOtvrz79R3OtbvUv+5EPdi5RkSJhqPiLfKsBeXGGSK+5A4rcTLF2c7Y0n4W1O2WNNrWTNEwckLCC3y3NZ1h9abQC2Yj0LdVf9ATjEB+PnkVyslRUTcMgdIFuE3IKrIcG6DzucEI2AR44OJeIwjiJYRynJvmn4Z5Rnsi3sfp6PyrzgDttetyjZX0Y0bFcyNubqqZKmrWmZw3mRMw89mboai27Qxqve93HDyaqT8/VPmLQE8MoJ/gYtdJ+VuFIalymxjdNA1y0Rz7nKmACyFjzyzjvsulmbKL57nIlxaMUUbsPzqzVWsqH9O4UgQQH18JvxQU6XjHpRx7y2ZXCY5rDs6A5hJTg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmNIZ1B6dVlLdXZqZStOZ2thWkFSenlJYm1KSTBuS25xL2E1TmVkUVhaQUNk?=
 =?utf-8?B?cm81TlFmZUVyazU1K3hWTnM1ZnV4Y3REZWRuRVNHUDdkS2l1R2h2VVVWQXFQ?=
 =?utf-8?B?b2Z3WHh0b1hVSWgvLzRnbldyS3I0Y3cwbmRBTkZZRXoyandmanltVVpOd2Zx?=
 =?utf-8?B?RzVlYWJ4WmhnaDlDbEQ4S1lDWk1hdklFeklza1U4U05qaUhWeXJJVm1nbXRE?=
 =?utf-8?B?cXA0cThZaXNyUFN4bC9SbkRPWm4vT1BCNms4Mnp5QXFPSjBYSXVUaVVRMWI0?=
 =?utf-8?B?VmphSWxudXNUNlBHNVliOThSMkxGWVVGL2l6QTNySnVxWFdZTjNKa0Z2R2M5?=
 =?utf-8?B?akJkTmFDM3hkckxZRXVRdDdQaXhiODhKVWVacUdNK2FTLzlSa21tMmxLSmZh?=
 =?utf-8?B?QnpkNmRPSnk4a05sanZoaGtYUTcxV1NpSDhicSs0SWpOYmlCN2pmdW1veW1Q?=
 =?utf-8?B?TElQOExaRmxnWGZwUlgySFE4TEZrUFJvVjc2SkkxVUdxcHEweFpSRGVmNE5t?=
 =?utf-8?B?d1lXdzU4NWkxUE9CU3BaT3FONExLd0ZYTjlHMTBHQmFXcGgvbGIrUEs0di81?=
 =?utf-8?B?K1Fmb2tTaE1tZ3JJZlBlTUg2SzU0cW9BQ21ud1hXTUJUd3Y4bXFWZUt2Tkhs?=
 =?utf-8?B?WkhPbUN4dWZSRlgydHlBN041eFJUSHBmd1drZGV0b3pIc2RzdkhEZUJpay9M?=
 =?utf-8?B?U2FKNWE2VEthSUxOdXVidGpOVGxnL1dqaGl5VHVYcWxjRjFzSnFyNTBOdjJT?=
 =?utf-8?B?YlRUQ0tXOEJkd0tqOXlicWhXR0VqeVc4NWpaOHo3UVRJYU5COGZSQXVmQ1pH?=
 =?utf-8?B?eklxZEVlK2JLQnVDelJSYVluWVBudzlESXU2RWFsSHYrRllFd1dCNS9qdE1n?=
 =?utf-8?B?dlRFQnRvNUY0Q3drZmtNVXpiTzdiNDJ1VzdLZWp5anl0eVh4S3YrVzkvS1h4?=
 =?utf-8?B?VkdpLzJzWnREMUhGTUxVb2F3WFQ3QW1sY2xNQW90YmpzaWVRMWNERUZHeHBE?=
 =?utf-8?B?Y3BrUHd3ZVYzbkMyRVoxb3pFcmVYb2FPZ3FsdjdlNjUyRWQxT2M2b2p4aWx5?=
 =?utf-8?B?K1U2U3N2dmFjeWd6bFg1Y2h1M3lEM0xrckExWUlMaytoSmJLcUJrSkNFbnZL?=
 =?utf-8?B?eVhVNXZIN0oxSDd2SmlzOVp1Wi9SRkhER0RWOWFRWjVDNjBMQUJ0ZlNkczIy?=
 =?utf-8?B?QkNZTmVkckVVb2Z2QVFQRWM0dG5VTlVwNEdBMStCWXA0TWdrSWVvdzFkVmdO?=
 =?utf-8?B?RHowYWQrQk5tTDhjWjFkdGR0bkNFSVA2VU5SK1BKQjhmRUtYV1Rhdi9jUG9I?=
 =?utf-8?B?ak9zdEs4ZHAyUm9ZNkNFb0hQU2dOd1pxbEVsdVhjYVRqaWF6Q2V1VUhyR2tW?=
 =?utf-8?B?YnUxd1Z6MCtqS1hmVm80T1JRVjJtTngyQ3dqbFVBQXJ6YkNLZ1J0NjE4dGll?=
 =?utf-8?B?dnZGSEd5OVI3djNiK003M0VqUGFQTjBHeHRaYk1BbUVDRU9adUxBc1MzdjFr?=
 =?utf-8?B?eE1ST1V3RHliMDUxVTJRWHhMUC9OMEUxMklOejVoT0lVZmRHSjl6cVhEYXo0?=
 =?utf-8?B?MmlyS1A1bHlybUlod2d3c2MyaDJHQXhBcDdXNzNmUEpRdGhFeGY0bDFJOXpm?=
 =?utf-8?B?elAwUHRWaVFkbEN1WlRyR2ROY0lJRCtuWkprMWhVMkl2WllIVHFNMGtReHFz?=
 =?utf-8?B?L3d1UDl0L2VqRnV6R29wdmVYV2dkc0w1eENqY0s2KzN0M1VCVVljZE1mSzd6?=
 =?utf-8?B?azJHVWM5emd4U3ZZSTVGTDE4N0cydnJ2WENKL3poS2RQNXBHcnVhZXdNTE9o?=
 =?utf-8?B?WVk0ajJhYzU1L1BtNWxyWCtFUWZmSkNLcktGdWlubnZzelNpU2t5bU5iMFlT?=
 =?utf-8?B?cjM5ajlxZkQ5Y2ZDVmkySm9LVENFSWZLT3Z0bHJTaDZLRFFhM3BUK2c5ZUF3?=
 =?utf-8?B?dGNLVWhoaS9CbVdkY0JHeVZuY2VKWWxyeEowZDNmMzA2Q2FTR2xic1o3Qkh1?=
 =?utf-8?B?NEZPSWQvM2FnTWxtTkg2ZndnMmFjS2ZSTjArZmdDTDlqZnNHeHB4dmd6YXFu?=
 =?utf-8?B?ckpOeDhwVWhZOTM5ZWlZUVdKWHFtQ2pWVVgrUnVFNFEvZVVMNTVsdmc0TGpU?=
 =?utf-8?B?M2dsUGZCcUpwUVNtWjExb1ErMDdtcWV4a056NUlrRzhZWllTOTVwTytCUDRm?=
 =?utf-8?B?bGx3Yjh6aHhXOC8wbGpIRE5XUEdkRVduSTkzUkloSHZFNHUxNXJTUnVrWUFt?=
 =?utf-8?B?Q0hjL29jZzh2bVdWaXhodkZ3c2FVUEhxTXdRUS8yWDl4VVpmNnZGQzhoMnli?=
 =?utf-8?B?Znc0ZU9vNUpQMndlREd2VjNvSXgxaHhQWHp5WTBhVnlxMkU0NkJJbVJXZGFp?=
 =?utf-8?Q?5vc+ZJaOnHnRs2kI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F70EA96F442164E9D5F127EBCFAF3A5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: odWPJU0hNk5iWSHt5zkYzb5Hfikw30Bsd7GrfK2Lyntst5aFNK8+YbRsotG8YLJbpaalcvK8o0jqft1Aa0pImmSS8IryhgsRrmjPZ9giSZLz3SBeX5AgaqA0U5u1NVTPG0yT582imOKMsD9mOo3EBPumo9OIWYRMuWnIoVHNNA8ZZAAcTlkWn77+IThdIMzvSiGklE+rJrhA2DbuM+KNrdPyukdWZazuuG3vd8FnDWKMJp9GOqrr6LaZshwnYaF/pYrl9u4o4m+yHK4hh9KFNvCi1MUC9t5/WZXS0HK+1/BYbGd/C98UF5GusACqhXcPNN5cLe5JacsHks/b6qN0bA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a077683a-ca52-4ce7-563f-08df137612a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 22:09:54.8351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRajXOMJPnfqZp+3x32+jCfk04jUSvdNpMnaAvv1ihE6gQ+y7iPB3Xf6y+IeTJgoNIe0/Xh5MHdVWAC7/fcRS64C2Z2DpsSjOX0h0tZ/0v4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5307
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDE4OjI2ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gVGhp
cyBpcyBiYXNlZCBvbiB2Ny4zLXJjMS4gWW91IGNhbiBmaW5kIHRoZSBmdWxsIGJyYW5jaCBzdGFj
ayBhdCBbMl0uDQo+IFRoZSBESUNFIHBhcnQgaXMgaW4gdGhlIGZ1bGwgYnJhbmNoIGFzIGFuIGV4
YW1wbGUgZm9yIGV4dGVuc2lvbnMuIEJ1dCBpdA0KPiBkb2VzIG5vdCBpbmNsdWRlIHRoZSBvdGhl
ciBESUNFIGZlZWRiYWNrcy4NCj4gDQo+IFRoZSBmdWxsIGJyYW5jaCBjb250YWluczoNCj4gDQo+
IMKgIERlcGVuZGVuY3k6wqAgUGF0Y2ggMTrCoMKgIFNFQU1DQUxMIHZlcnNpb24gcGF0Y2ggWzNd
IHdoaWNoIGlzIFdJUCBvbg0KPiAJCQnCoCBjb21tdW5pdHkgcmV2aWV3Lg0KPiDCoCBUaGlzIHNl
cmllczogUGF0Y2ggMn43OiBUaGlzIHNlcmllcywgaW5jbHVkaW5nIHRoaXMgY292ZXItbGV0dGVy
Lg0KPiDCoCBVc2UgY2FzZTrCoMKgwqAgUGF0Y2ggOH5OOiBUaGUgb2xkIERJQ0UgcGFydCBhcyBh
biBleGFtcGxlLg0KDQpBIGRvd25zaWRlIHRvIHRoZXNlIHN0YWNrcyBpcyB0aGF0IHdlIGRvbid0
IGdldCBTYXNoaWtvIHJldmlldy4gSSB3b25kZXIgaWYgaXQNCndvdWxkIHBpY2sgdGhpcyB1cDoN
Cmh0dHBzOi8vYjQuZG9jcy5rZXJuZWwub3JnL2VuL2xhdGVzdC9jb250cmlidXRvci9wcmVwLmh0
bWwjdXNpbmctdGhlLW1lc3NhZ2UtaWQNCg==
