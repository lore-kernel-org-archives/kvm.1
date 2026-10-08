Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425FF2E64D;
	Thu,  8 Oct 2026 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791419158; cv=fail; b=VtcWUjtEguOym5fyOjwS7iXDQ90KwXtRIitn0G2EOXotmO9kjg+pCpjvxvzx+LhESoWbG2YGWl+lpU5SKwRQQKpxlQWUmdBasZ9oz6hrvGaLfb0s6Fi+R1aJlrwbTyH9MUHy2+26KseeX06qNeEE0c6DX0XX/L3AL+u15BqDr84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791419158; c=relaxed/simple;
	bh=FrCZcPluLG2x8j1SbLRRFKhPSAsXjS73PDl/GiDHibA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pywyGdvWQGAnrf85A5FRd0p+vsEkyzl6fx6NEww8DmjNhLTsXWy7H35LM9/Cr2CZgjOLJH+zFN39gI0sV2LlCd/8jDE9eMpS9b9qj53IAUbQnGEtZNFqgImxBt1ZQh9CQegJFSAwf4zhQuDe23cRDeO+Opvu6U/1I/HOaJaL38g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQHs3r1H; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQHs3r1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791419157; x=1822955157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FrCZcPluLG2x8j1SbLRRFKhPSAsXjS73PDl/GiDHibA=;
  b=OQHs3r1HYJdgxcnVrtnj+UCg2xrJaxl+sUs0aqHKuU/8QweXUvdZAaV+
   ngaUXiRu00jpyPLCHS9dfly+kOyIhqTM+BrGQqcsFd2to/tGZ+mBL3b8v
   83Sh7j9+tskG6OgZUdR97dVx4JC87U66y5/vwa2gXcZu/a8e5Tq7A4Gho
   T78q36b2JzMShTax12Z9LXnHrEnD4r/xUan8iI2NKyE/Ix1/n3oZr9/1X
   10Fm4dRdxyrLIpRU80vE1sZAqzSY6MO2EKhob6i8DbPeIdqpQb63NBA+l
   MzDNiVJWnGDxYfWAVDTYbVJfcd1kaQEFvIMux9o9vwJtTWbQv4UGI0w8T
   A==;
X-CSE-ConnectionGUID: 5X9ovgrBSR+YUZMuJEVC1w==
X-CSE-MsgGUID: CvAo3S/uQTSO86FpcNL9Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="76163"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="76163"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 17:25:56 -0700
X-CSE-ConnectionGUID: /BuZNni4S8qyhxQ46YgN6Q==
X-CSE-MsgGUID: b+4uF/hkQrmdmVfnagCtXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="280798655"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 17:25:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 17:25:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 17:25:50 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 17:25:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nt52kS8xjTIAwbghiXWY2SnmWrTJkEJN1Qi6fo72KUT9En2t7mQCbsuF6kiA/vQSAKuxAdzaT6zVN8dOR/jy9sYNsNuqgMWvEAdEOsTHzDgoj+LFsPC5OVHkGHgXbkDb59aiobfGsgXNBAo/ZQl98NEC70zRbO9sUh8XfCrEhkhrjzTSPrVv84rzhdDwSuAkJjh831mz3Fk2fz+Aa/GQIZ4zFxmnjFY27x3cvgrQd85Mimp64kr/M4LUepq+b/4GppZjXRN329p6CflSsa47HcxS1BsMen2jSLTfZE7Gp8vpgCL67J6xd/q4jFje/mKrg5vv5o3r9gWzEw7VkaH+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrCZcPluLG2x8j1SbLRRFKhPSAsXjS73PDl/GiDHibA=;
 b=QLTKQwJMWTFFHc6dvQ8rCqg+FBIgyyPkXuqPhhUZLhSvxV44KqkmPXzoq3W2V45wi22JxYKsG804IpNBjleqAQGNLjFn7iE9WbxWrnJVJxgx2KVPQFRnHia1BSNQ22aWzl4GViFXMy22rlvOmqfvLM9EjRA9MQoBykl8IhKVkpT2pXZBgAPk+FbpdufKh+T6AL1+qDhHXlFUzvM/3aUtsVRtOjLNFQMZaqLhbPYQBggl12s7lQKyZs33ybLWr/qIuBNt+WEgI0TLD9Jv/Tx+pwshMOi9fzADHYagu0mPOWKFALy8u9wAMvqWIVStovT13c53Vhytd4DR4eng/X/WDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Thu, 8 Oct
 2026 00:25:45 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 8 Oct 2026
 00:25:45 +0000
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
Subject: Re: [PATCH v4 10/17] KVM: x86/mmu: Add a TDP MMU API to split huge
 pages for mirror roots
Thread-Topic: [PATCH v4 10/17] KVM: x86/mmu: Add a TDP MMU API to split huge
 pages for mirror roots
Thread-Index: AQHdTylmg0eFgJJKrEi0zNmlv1QnwLby2MoA
Date: Thu, 8 Oct 2026 00:25:45 +0000
Message-ID: <a3746289e89036cbb0d1c5f09b808cc862cfee12.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091103.15631-1-yan.y.zhao@intel.com>
In-Reply-To: <20260928091103.15631-1-yan.y.zhao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH0PR11MB4792:EE_
x-ms-office365-filtering-correlation-id: de1847d5-989c-4e6b-9c41-08df24d2b1e2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|38070700021|11063799006|56012099006|4143699003|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: ZgHiD7/XEL97s8TwXn8czGnDsnX0OY54tV3Q1MGkvAYo7fNflMAKI2DId1qiha5MvnLhtzu5YTb29h42t2YPcqZOnjci5IGrmr7xwwJpMh/bBemGEP6WIeBdJZAZnN4qoTWBIhDnCR5TqjNlX+eN+a3eMI0K0KtthC21JQ2NWlMFkBqdfz3DW8tfRg5GB1NT3y0NiW0to9dcdX6RgfrgBIcrC/tQlFCi/ACmf/rq5rda3pzqf9ozWzprOluo1ihtPR67qbruqh6WpidgyjECqUe7HAe7LAj7GIbzVlbh6HiKm3wazYHKTiisN0eaCfozIN7HhDk3U5rFuaWjPGtENVSwG49QqGo7B7DmrvnFoprbrSin5xLTHMsefdF/c7qfD/UnZRZ50zSqRA72VwtOH8EMjkJqzLjwQWjgzQVdMx8w/D3RtFXRcPhpmqdA3gC1axXV3NftC8a90XbDzlPPi5Z32YTTm5dYYEXsJf/Aigikpn/nFjkwbFES1/8+2YBmJOVvJgkbhRdxTYLoC/XaUfIs47OCREsI+2W4Lefxdj/w9FHfletXlJAYfEZAikMnv3mU08Pnl9y5nb9o3BUKQnlpDzJfpwWJryM8MMEM0oD3jMgHcy8lwslAvNp/HzDImrLcrImrWbnoXej+nh62VeKTDD67DYNgdX4WV0/kMmcREuXIbm6IdjKRYRD1KeC5G4IJ+G3mSySVJzZiRqcmOZ6RwxRwrkkFSHFm5U8uP4E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(38070700021)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGVCUXdic2Jzd25Td3pzaEwvSlpGOG1xZXhWWjNmbUg3N2NXbVpkQkd1SXp4?=
 =?utf-8?B?Z09uSHFVTUtZUkxMRGZMVGhIQURDNWZiNEtacEs0TVBzUTV4eVdLbFNYaHNP?=
 =?utf-8?B?aEd3RzVYNzlkZ2ZhWVp4RHRBTHlGd2llem9RMC9palRrdDljZ2IvTStKU1FO?=
 =?utf-8?B?Q0hKVWwrWE5BTE1oZnZsRXJsUUp0L01nZDJsVDFXejgrRi8xWVdYYU55dFFa?=
 =?utf-8?B?T0RRaDgyd0RPWlZXOG9jZlJ3ajlnN1VIak1DZXBOS2R2Z1pKZ1pWRldhMnAr?=
 =?utf-8?B?OW01eVU2NVFNZFd6bXBqVE1rNVJKdzVlOENxYTFiMTRaNUtSNjF6NEg4ZElK?=
 =?utf-8?B?RnlBUUxYa0tQWlRTNis2ZmJxMmw5T1BxUnF0VWtXSHNEelVYRVVGZm93OHh4?=
 =?utf-8?B?TzVtMHdqV2wyN0VzZ1gzYUJockRKb2dBeWx2ZGxodEpKNGduREdFSDBiT1E2?=
 =?utf-8?B?eW51azNnZGpuZFFMZGFrUnd0bVZkVTRaWFVsVTRiRnNTVFlYQkF4T2lUdE8w?=
 =?utf-8?B?dXkzK1d1WmxvKzRjSTA0dHJqUC9ORllIY0pHRHRBN0tHQjY3NFhKMUpteXJ2?=
 =?utf-8?B?UVljazU4K25IMzlWZ2xJcTlCVndhYmhPMWVqU0lLUmJiZHZMdlArZ3JNWDlR?=
 =?utf-8?B?LzQ1TE5TOXR1UWorYzRmTVM1cTBnTWxINHVXUFk2d1lkYkFpZEJ5akJYL0Z4?=
 =?utf-8?B?OS9kZjhnMnZ3c2hxWktFaUZGak5SOHczVEl6L0tISEJXSlRoSWQxY2tKVnBj?=
 =?utf-8?B?TWRKSDJ6R1JtYkE0dzh0YzVhY2tiRG9sSjFXN3gzanN6RlUwV0hSYnk1MEt4?=
 =?utf-8?B?V3hHOE1JNmVwbUcwRDViUDRpVWZDdFd0K3VhVnZ4T2VmeXNwcXc4MVlpSm9C?=
 =?utf-8?B?b3d0dU5aaTJoL0xHc0JleFVuS3dNSDBtVng4ejN1d1RUN0xSZG1PU1E4ZHVW?=
 =?utf-8?B?RHkyMmlnYmttN09FZ1FIemczRmdwanRpL1hvY21jT3lrUjZQK0tRS2tOclZw?=
 =?utf-8?B?SFdaT1BxZ05KRFZwS1VYVXpsbHA2dy9GMFpuNzZPTnFzWTJ1OURUZWJXclI2?=
 =?utf-8?B?SjhZTXBqMHJPYlhBb1VINEl3RUZkbWhNVE1KK3dLQ2lmbWhJOVpqSzg2d2Vx?=
 =?utf-8?B?Q1pwSUxzK2FHZjhPeTVacnluWlBLUUZqUzFGaDRSMFIwMjZJMTJSTWQ1OUdw?=
 =?utf-8?B?VExGTzlhbWVodHZyWmZiQjNmZVp4dUtFSGt5QmhuTmxrbDY0K2F3RzdOc1d5?=
 =?utf-8?B?djdYV1pHeEJVMzgvNFR4Mk9SRFlVSHd3SHFIY2J0RWRpUVhIYXFiZFl6cnph?=
 =?utf-8?B?UmtyNU9YZzl3aTQyWHlqcVNwdmREcXpGWndjTjZQSUtRKzMwRmVXMEM2RUZx?=
 =?utf-8?B?QXNDeGsrTWM2ZFkwcEk5T1lRRzBsK1c4Z2doSFIweCtIcmVXM3FsVTIrUkxn?=
 =?utf-8?B?RHE0blpFbm5wRCswM1pGMkszL0Z5Vm5EcmIyNUpIeURvbFdzR2pXODltTjhw?=
 =?utf-8?B?TUZsWEExOWFKR05wMUpXenFHNDdqUDJLSUtPOTVWV05zSXc5OFJoLzhGaG40?=
 =?utf-8?B?Q21uaXUyVU5TR25TTjgycWRISHFwRjRtSUgwRTFOYzhUbjZLSmU2WUNxbkJS?=
 =?utf-8?B?UjdqaFJEeE13azJ3d3l2RDFSUDBVTUhDMjRXdWgybDc2dm1XUXcxZTJMdEIy?=
 =?utf-8?B?SkxLcWNGemx1YjRIdFpuYUQvM0EwbmNNOG9HL2ZxamI0TEYwZHA2THpycVRa?=
 =?utf-8?B?cWVDdXhEM2FiTzk3UUplQnZ1VlRpNXZ4MnBoRnlva3E5aloxREpkN0w0VkZK?=
 =?utf-8?B?RUlyL1VzNHlza1FRaVY0ZW1pNnRUWk5Cb1JOZHZSdnNWQk5yeEdmZnVhQnZV?=
 =?utf-8?B?aXlocHJIYW1CbEsrNmsvRmZvOWJvdTZHUVlBQ2lHQmwwNnluakZtRWc1eCtO?=
 =?utf-8?B?RFZpekRFWkFNRHQ2SG04MUNJemI4MHFlRDQwTE1PRElWMEh4STdTaXJMbGJM?=
 =?utf-8?B?dkJhQklZcXQwY3NqTHp1M3JQY0o4THpkekt2S3FBWlVINWV0eEpjTTIwczlt?=
 =?utf-8?B?RG9FVWFqM3NqemxVdE1CZ1ZSaTJ4MzZ1UzI4cktQWCtERFVMMmZNVkIyNUEr?=
 =?utf-8?B?TUMyYS8rVXV6UEJjQlpaTFA3SXh6Zm9OTWpjWitWcTZ4MlJ6Ri9JUlRpUUMw?=
 =?utf-8?B?Z2VWU1Z3b2IrZW1Jd2I3bGVoQ0RoeUdHc3lPTXRWK0pmemZUb0dPUWJCb0Nw?=
 =?utf-8?B?NStlZ01BNjZGWEZvLytKRXl1WWZBQXY3VlBmNXU3UzFNMTZRRDJyd2Z5ZnBa?=
 =?utf-8?B?Q2JrK2JvZHJzeUxJenh1M0JPMUVpK3VZTkU4Y1J4SlNKRFZjRWtJcFRRWkNx?=
 =?utf-8?Q?D8RDNH6PK6g8SDu8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C248B3909DA350469F9E52FC4016CF15@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B/Oo70kahFu+mKBmpdHq5BOmtBnL3myUwO2QwlxL5LlyemwIBYPqu64EX2CjH3MBlIIK9G3QCIuQUwiIcVaaUbgvnmgBe8HHqpqlklaJk+DKhN0csUPmAoYUlyw7bo+m934+kXDrK3Inc1+bvIRBY9sCyW2JTprKuqWwaNkAJZ99Fpvo5BpnZmCCT5amUh+ffyRfYBpMx8UCM0FsNRN34q/Whe+FYcrofGn5Xzf3rTz2YB/WtbgYq5N3y1iP359iETnRK/eroyXF/qyJkQh9Zb28vE4YbCMV/1MYZ5zirz8e+WOmz7QQojOOqrzTL0WAI568FJ0gAaDHq08IqgNX+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1847d5-989c-4e6b-9c41-08df24d2b1e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 00:25:45.5846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAPWLm91sKJbvbIFCUqfWr5F/WfirG396pA9EBB09LScmWCtTIZnv6zAdERjUPAbjTdztQa4P6Gb4460EpynylPzZ2p0WaUmjCP/iLyJD1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4792
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjExICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gRnJv
bTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0KPiBBZGQgYW4g
ZXhwb3J0ZWQgQVBJIHRvIHNwbGl0IGh1Z2UgcGFnZXMgaW4gbWlycm9yIHJvb3RzIGZvciBhIGdp
dmVuIGdmbg0KPiByYW5nZS7CoCBURFggd2lsbCB1c2UgdGhlIEFQSSB0byBzcGxpdCBodWdlIHBh
Z2VzIGluIHByZXBhcmF0aW9uIGZvcg0KPiBwYXJ0aWFsbHkgemFwcGluZyBhIHByaXZhdGUgaHVn
ZSBwYWdlLCBlLmcuLCBmb3IgY29udmVydGluZyBhIGh1Z2UgcGFnZQ0KPiBmcm9tIHByaXZhdGUg
dG8gc2hhcmVkLCBvciBmb3Igc3BsaXR0aW5nIGEgaHVnZSBwYWdlIHRvIG1hdGNoIHRoZSBndWVz
dCdzDQo+IEFDQ0VQVCBsZXZlbC4NCj4gDQo+IEZvciBhbGwgaW50ZW50cyBhbmQgcHVycG9zZXMs
IG5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2Vh
biBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFlh
biBaaGFvIDx5YW4ueS56aGFvQGludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNv
bWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg==
