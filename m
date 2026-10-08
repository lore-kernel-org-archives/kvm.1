Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED2025771;
	Thu,  8 Oct 2026 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421540; cv=fail; b=q3Oziq4Oe0hlZw8hKucYqUEyjGZOk1srnYBppPvzBpJfNEq+SnFsXK5VyT6lajg2egFo/xCCP/R1uCW++BIOA54WxuINcZG6m4M3NHAZ7HwNNSLQ0dIQUbnrY5qGp6yhnL2/oyrGPfjVuz6OEkYx06E9llf2/7tyo/AZeWY0Q/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421540; c=relaxed/simple;
	bh=AZCjixYB40Co14FopblJ91ZSWW1SzmsFFF7+4eN0SDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gCS5PdMy0375sqylhodvlDrKb6mFcNLDcvt2qHYLYABTmLJe3nzS6w7xlJ2GwzXotEBagJw3EByJbq4d/QrCatXs8jDelfBm1DBLYZYKCy8r8P6C50oiVP6D2iiHrvute9YAPy+JOr62gchiVRXpG2tiO6hqawweuutfzQdKrmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRXn7yxk; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRXn7yxk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791421539; x=1822957539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AZCjixYB40Co14FopblJ91ZSWW1SzmsFFF7+4eN0SDs=;
  b=mRXn7yxk6YJAeJ0Qs0sYhal9dINBDgRKocJzCcxsvmihWXgTK0l5lqSI
   acgsjHWEpS/sTjC06wbKqpiaGTNwAOI0VS7IWgQHCNltatk+nMqI1DspY
   SweqmKBD/aN/XUIn0339wfiNd+FdQFYo5iM3oRp0hKBDUQIuiX3n9NvBU
   urO6QGo1xUQoHwhJ5Z7MXuMfLOizo9/hCF09rY8qnQe+jaFOEjRa5fDEW
   CpLsw/LveysklSDJYwcWH888dxPKbY5o/cMvYVPLIN/vBVZpDmf/LTTGv
   qxjFtQLC84DrDbdBvePDzuZTDBu88YkTpg+hoUKmfZvgVPp84RIBQ15ao
   g==;
X-CSE-ConnectionGUID: OOBcOJBHQxGRROyEPeBC8A==
X-CSE-MsgGUID: bVJViYeERxu9X+M4N/H6oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="76439"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="76439"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 18:05:39 -0700
X-CSE-ConnectionGUID: us75LvUxQyCeYWbFvOtlGQ==
X-CSE-MsgGUID: 6J5V8rsSSueyFPk7J3057A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="276699257"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 18:05:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 18:05:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 18:05:38 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 18:05:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhPuWT3tPMqYkD2Ny56zVAnJ3tYl8meDCDUrgOYlJdy92Hzo39Gjug8DN4pT5Kz4ji5clRmpuwKEVNgsJohcuweCwhZGFSGSxDytaZDZrgRskJ1FH3RzCMZVj2pxszv0EUlVPsoZZrTbl/jwRJaZhfI/TN2UdNeLMKlTyTno/2sYPM9oABXWJWqKoxgI5YS0RhoXDSg2PIJ7tCO7eWTG133LHiOGydSVuttl0IU8rLSaeB+Dcsi46YvLd/dHvyCouUroitjkD0W2c8F+W3OlOjnGv+5T73dA4RupZgtN6sulJCfLgjOKISikPP6C0C1sGjM1GeGs5cJyE+Dj1unvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZCjixYB40Co14FopblJ91ZSWW1SzmsFFF7+4eN0SDs=;
 b=MDQtRpkxkItpG45d/tqd6YuK2vihd/Jov2N36I8eY/xo+gANnSQswPSmsW3t//rTRcpabfpuWh/KI+l1LQQ6I3rk+8yDBc2uY1U75e3rNqPHPGRivOfTV6npS6+8irQxNA+gXE+3FmqqjYNIVHeRXD9jiCFKCeERqF+TTR3xPEtxGvqV2U31d1F3B0UHsDBU57WrAI6Az0v9KTpKZilA+mELO9VPbyQ69cOzrb8vS4eh2RAN7PXArmYkNu7dAALXHKgflAmn0bx8O6N9fbW4qgZFbCelsjFCJh0zOu/L9X+F2VGqHnYoaqSHOUZIchu7ourCeZnuvkU5exzBh8G3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS6PR11MB850296.namprd11.prod.outlook.com (2603:10b6:8:49b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 01:05:32 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 8 Oct 2026
 01:05:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>, "Zhao, Yan
 Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 11/17] KVM: TDX: Honor the guest's accept level
 contained in an EPT violation
Thread-Topic: [PATCH v4 11/17] KVM: TDX: Honor the guest's accept level
 contained in an EPT violation
Thread-Index: AQHdTyluQiKEcSUnPEebL5+yF0G7rrby4+eA
Date: Thu, 8 Oct 2026 01:05:32 +0000
Message-ID: <68f139713ee0adcca0d7a3d30e48a9c6cbc1f4d4.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091116.15647-1-yan.y.zhao@intel.com>
In-Reply-To: <20260928091116.15647-1-yan.y.zhao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS6PR11MB850296:EE_
x-ms-office365-filtering-correlation-id: b56e4f6e-d34c-48e8-db8e-08df24d84093
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: RllRmVSnobWOYCo+Y9ubsDKa+LH+0QhUaEX3YTo3f8bM9MK/7UJyDl74ZbdpJf4eK2DtJ2cam4Ql8QW0tIm1WoNCDvvdlaJrpFMwuwgzrDNGVzmgpi3wccQsw9A4qS5IKtTwPBR6vt/ou7XWyZ14ciLNYvu8rGJrgr15dDDIn6fzLd73YhLixMG61IsJ1lzHfbI8fWl34CgjFk/y/4Qa1Q7owRg14oEyMxW8l/1tpZogVgmHg0q2Yxilk2Ngv51iAcnUnt4Id/mZFrSe5rYWFuJa5dR9+0PH0/sjimZMgoDPGRfHVU0hHPPvb55rhj/VIENYkwvz924IhrbcRYn36qXo3s2GU8rfBIH6x5eGlEABouZ/8qV2LNh1hY1aPSv/4Ddkxptvb21XFnOwwgvSfrfm4RG0MiaosHl7Llf5SmQ0Jjt5QmashbNBCzqwzFre8Z15Y0xxNn51oIYC7Hd2ZZWFjCSsiu/CqjTgeBqn1gjIdLFvpeNticaaM6gflcCGPfpZ0icTjVm7EbR67xMtz03/Feo8wi2FrzjbgHR4lK0/m/+lCmDsvtq/NXzPitQkSZA6AI9TdJlpF9pJV0xwYAq/q3FrTzCswECmC1A3mMJ1ODSbafABUfGjyWa9PYOaaGgPVaewwMe/Eqmg8W6G9oQBXPDf/FTlWV6g0KD/jjU4ilRUxjvZnDjU3JO5lAhsCgVntsjtxZm4tTFxXTs/RE5C3YhOeiH6l+s8nZ4OxpI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzdQd1R6SmZHVDE4NWhSMTIxdGZlQ3A1QXhkakRGdllsbUdVUWRHYXlFOFNZ?=
 =?utf-8?B?RlZ3UzRtLzJnNnpYTzluSnFFUFhEa2hxTVdhc00xZzk5RHVGVkQvak5CaUpv?=
 =?utf-8?B?M1ByZHhvUFFsamkzK3d4bVp2c2pFMUZmSWNGaGpabmVINmRmWDM1REVBTEZy?=
 =?utf-8?B?djQ5bGhLZ05hdWIwdWNlT1I3K0pDOWhsMnc5V3RSWXZMcUtrTkwxRWIreGhD?=
 =?utf-8?B?TTNEZEI2RlV3WFMycHZQYUNXNE5vZWZTaEU3c3QyRmwxRUllU3F0SFdmUjln?=
 =?utf-8?B?OWNLTmxOSE1xeW1rLzAzelM2K0NmS0xZNFgxNmVxRzcyNVhUMVhoRjZkY3lO?=
 =?utf-8?B?YkV2MmJpSHA5V3kybzVMZjFJa0dHbjdwbEhrcndmMFBidElUL1gwekVqWXhP?=
 =?utf-8?B?cmZTTDdrMWRmUHlZd2pmcFRsODM4N3pnQWRzV0srOE9JT2lYVGd4NWdRQjRY?=
 =?utf-8?B?Y05BekJWbXZ2c0ZJTFF6MkVYdlVtbTVjTk05QmNvblNYZTAzNjNRbWVGUnRQ?=
 =?utf-8?B?TXk4U0hTbHhwNTBxTzArTms2a3dFTjVrMVY3ZStDVGdyZ2hwd3BZaEduYzJZ?=
 =?utf-8?B?K2ZNcjJsMitRdkhnMFplMEsyWDJSWkkwdUhEbjNjdEprZkNiSnh6a0JQL1c2?=
 =?utf-8?B?YkRmMWJEQnRCVzZKVzN2QkJmekl0STRwVklKTm53U1h2QlJWWEFhdWdHNCth?=
 =?utf-8?B?eklOL2R4U0dycXk4SlR3ZGlCZjBoSFRpQnVFUEtPSXJHSlBXUDNFUTE4RGwr?=
 =?utf-8?B?UEx3MTJTNFBpemgyQTV1Wlg1clB5WS81alc0cGkyTUVXUTd1eE5mVis0cTNG?=
 =?utf-8?B?QzNHMy9RNk8zak52RGZPall2aFIwR3ZmRGRLbnNINStmNmVod0JiYStGK3E1?=
 =?utf-8?B?QnBOS2I1UkRwYXI4eVNpZnZkaEJlUHFxL1pydzBXdldLL2NzSk9hRWtwcEZ1?=
 =?utf-8?B?b1E5VHFIVUlaZWMxa1F6TUV0SSsrYkU5Y3JjQkJ2K2pIU0FPdXNQZkdMUkJF?=
 =?utf-8?B?K3dTcGt4Z2k1QWwvQkF3R1ZjSnB5TExqVjJ3U1pGMlU2YUJvRzZCVU50YlBB?=
 =?utf-8?B?bDJmdHFrTFNmWldBNndmNm5CaGd6M0JTK0hpc2NOMlFUOEt3eDlTb2RjeEYz?=
 =?utf-8?B?OWRGUHRBbDVXdVRQTXJnNEtaTUNYRldJSUxOdjlveXRING5raXo5MXZmRXNF?=
 =?utf-8?B?MVBqb05OcDYvaGQ1NHFQRHlNRkd3SmJZV2RWUDdGOGZGKzczV1o0ZURCUW9P?=
 =?utf-8?B?R0hWeDhnVEJtendwR3Y0Ulo4WnVLR0dkaitsdC8xNHllRU1EeitDRTM0Y1Qy?=
 =?utf-8?B?RTFUQW9uN3htRk54bFk4dUNFTFRjcng0Sy8velNFMHlLWlpFdnA0VkNCNHVa?=
 =?utf-8?B?UFMzdGszckxScENQVGkwM2tHYlZYcFNFVTF2SXRtQjJnY1JOK0hBb3NXOG9W?=
 =?utf-8?B?czZvZHNKRm5aQ1VyempjQWFHMWRySVc5UGdxZE9MS3MyRWljN1d5OVlHb0l1?=
 =?utf-8?B?V3cwK1gzOUdTcmNJbG9hbUtZOFBQTHIwWTRkYUFCZnd6bGtIYXZQdkFyem1a?=
 =?utf-8?B?UUQ3cm8vcTdhbFcwSWJ0dzQyaXIwdS84WFFtUHJ5QWk5a0tzK25CVlJKT2xR?=
 =?utf-8?B?bzc5ZlM0c3hiVFNsbGNabXJkcGJveHZqVHk1QVdMZWpDQVlJVzhWQXlFbmNL?=
 =?utf-8?B?S0xYTXNZditzdldJalRSaGlDNkEyNjFGVGFDNWhiamdqT1N6WkZuNDhxcFcx?=
 =?utf-8?B?YUc0V0VpdUtHL2RJODFJZEl6M1Rnc0NuNCtITndIdGJaZzVqNzgyQmNxbkJF?=
 =?utf-8?B?MEhUbVdEZWYzZENvSnVBalUwNERCV01KSFdoWFd4c3lJcnM2NEtUUHBydTAx?=
 =?utf-8?B?R1I0SUt2OTNYcFpVbWx3cktMSmpJWit4NERLU3I4S1VSVVdURjNWNUtObHJp?=
 =?utf-8?B?Z3hHUEJJUHUrRS9qYllsRFhndVpSS0k1TndyTCtOMWlSYnE2eVZuYTdmOEVp?=
 =?utf-8?B?MmNtbFNvdkYvUjltUzdMQzU3TzVvVnZFWTAzSStpL25TNGJJak95QXlqRE5p?=
 =?utf-8?B?cTBwRHNUZi9aVi9sMUNpc3d6NUVDWFVlMjBGeGhTMWpKaGVTYlUxYmJIb1hy?=
 =?utf-8?B?OSt4anFydXpGSmtSZWl6TWFCSnBqd01nZzdpUVEyOEc3c1pncFR2aE9lKytK?=
 =?utf-8?B?Ni9oUGNIT1M0TUFRMk5YaHhaN0I1Ny9SenNPMVNBNGxIaU9QMXBEUTZxNDhm?=
 =?utf-8?B?blJjZjNVYzN4NGhBM2o3U1JMalJ6WVpWeGdTT25RR1JnRUhaTmpsSFd5WTFn?=
 =?utf-8?B?UVRDVHF3LzMrZEFsTmZrZE54aFkwOHJIWFM1YTRuMmpmQTZiNnBPVGVxdXM4?=
 =?utf-8?Q?wkMqP+PqIbm0Xa6c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0298409DAAD9F4CA2589F15EF9B40C4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Bl1S+oLc8ixIbgGJ9OzMhYPn7sXpSCvZ6od4bI0LsR0Of3JIeYekCo/PI1OAfRZ4aHb2AGnrf6PWiJf7ajThv5/QM5KhPjtCH6Z4/xh4rjWtYjGECjihLAd53yssJkDpDppnfkUZQnchXCw9V+aruG/buLtOLKD+zFJ++u5q7Z8IKI+yPFfbDUKnGymUU1d2ZT65+/JXO/CqhJ3a/1QD4ZxnEwNSf7Eq/c/ic0Vw+p8z8VktUQ0uwG4BUOkKxgiGvP/inJEwYebq0K9IzwS6H84GIrUXcez2PjaXiBvuGyaA/zugtAyZoNrIpT+QUiUBQ1iNtGvRekSspgFUGKQIcw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56e4f6e-d34c-48e8-db8e-08df24d84093
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 01:05:32.4371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7/aA590woIDwTzoJGOcBisKv8iQOEqjJ+u7iZZeEbgGPtU5g3YOj8heIYJNgUmjPEJQ/3IU7/gtARISA3mI9KcbHF81zUZco2UNjwfpzVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB850296
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjExICswODAwLCBZYW4gWmhhbyB3cm90ZToNCg0KPiAr
DQo+ICsJLyoNCj4gKwkgKiBObyBUTEIgZmx1c2ggaXMgcmVxdWlyZWQsIGFzIHRoZSAiQkxPQ0sg
KyBUUkFDSyArIGtpY2sgb2ZmIHZDUFVzIg0KPiArCSAqIHNlcXVlbmNlIHJlcXVpcmVkIGJ5IHRo
ZSBURFgtTW9kdWxlIGluY2x1ZGVzIGEgVExCIGZsdXNoLg0KPiArCSAqLw0KDQpJIHRoaW5rIHRo
ZSBUTEIgZmx1c2ggaXMgYWN0dWFsbHkgbW9yZSBvYnZpb3VzIHRoYW4gdGhlIGxldmVsICsgMS8y
IGJpdHMgYmVsb3cuDQpJdCBpcyB3b3JyaWVkIGFib3V0IGluaGliaXRpbmcgMUdCIG1hcHBpbmdz
LCB3aHk/DQoNCj4gKwlodWdlcGFnZV9zZXRfZ3Vlc3RfaW5oaWJpdChzbG90LCBnZm4sIGxldmVs
ICsgMSk7DQo+ICsJaWYgKGxldmVsID09IFBHX0xFVkVMXzRLKQ0KPiArCQlodWdlcGFnZV9zZXRf
Z3Vlc3RfaW5oaWJpdChzbG90LCBnZm4sIGxldmVsICsgMik7DQo+ICsNCj4gKwlyZXR1cm4gMDsN
Cj4gK30NCj4gKw0KDQo=
