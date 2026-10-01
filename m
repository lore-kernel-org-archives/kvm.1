Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FBC51DE03;
	Thu,  1 Oct 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866566; cv=fail; b=VEgyUDnWyfuzHfa6j6IcmDN3ySXUWhOqx8+5zPq21HCSW+corAHqxHtB66dZWBcTg/BgxoatUxb2EqjQOUAhTV9RpxUBz+vnPzgp3Hd6Et/TxX59awNCdHP1niUWqRhJh71GiZaJhE4Z4jtxCEPWf0M1yFWOfT9SlhjhFsCKtJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866566; c=relaxed/simple;
	bh=5OzBb6mWw9b47iZpkfPSJCU2qmPaS5+5KSCMff4ukUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o9E0xWlLXEAhIBG17FhRH0cSwa1DAz1O6gpllY1lGS5kIrqQUfPBmJtpIfjy0+KVxhJWF28Jd+Vl6q23kKsFx9c/l7cqxyt5cReWro0F1fvAH30F0N5bTVUebLaXCQ2v/A7i98y80KoFEkxZ4HiZIYrJc2Qgna4rMh+PiTQi0j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyPwyOjk; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyPwyOjk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790866563; x=1822402563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5OzBb6mWw9b47iZpkfPSJCU2qmPaS5+5KSCMff4ukUY=;
  b=OyPwyOjk17Y0CJbh/tLSe2m58JFssCxMnOIK1/6b/laupvrmOfrTEsF0
   TJNiwU0Zxjc7qFUm5q4mtjFvWuP/jg7gOoSY1zDQZ1Hhe9VL1VkwIPnVk
   dXEOADya+6InAX8ir9yvywJOqrhItKanDpGexv+80nBHkqcAle3bZwQ0Z
   Rqcdulg7x5LWcmu/G2gg+zMHKegfwACfQh06wHT3wstRFuTXEHllc+D/O
   3p6kL5TLyOvB+4NBARrQOQwEyv9yxpJvd4akHDtV6R1tRv+gE/GCBj+Bh
   Rpt5QNoEK9Nayp6Iq6mvmmIUm89s0I6d7XR5YKZtrhSKvr6nAUvUMCa53
   Q==;
X-CSE-ConnectionGUID: vaMylSxxTfyiZZaeSb29kQ==
X-CSE-MsgGUID: xKhnxY3jS827yZLI5qqJaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91488077"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="91488077"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 07:55:59 -0700
X-CSE-ConnectionGUID: ENrPLG47Tru4q79UHjAEtQ==
X-CSE-MsgGUID: WPRn/tnqSS+tZgTSXxyKOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="284075788"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 07:55:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 07:55:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 07:55:58 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 07:55:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrZsu9pDCrr0GxkX/8oPoOVPMNvjX06mwxEY5QRu2T7y3i+qIwC9XtlgkLKIKraRz8o5Ylxy47dKZcBG1k4sbUhgg4GQJscraJRAzT2Avkm4DO+hdQqEGxY5Z28B8Oc+lIrH6Ats4a4lQSRd5hqKNvEgGFGb+cgm2bx6P6312Ip278rj81ZGe6INUwFwe9HXz0rZfFh3zvWuayahRQQ6bz/mLe2XD+8MiiquT0dridx238Lk+xkvn969nGZhPlUHW6Aa9350i7oPWgmoCAU7kF0tlHF3PXVQkJK1M/fba1v1YvthizFsKzGSO2IKbiDIJO52xPtgoin87+taDn8zGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OzBb6mWw9b47iZpkfPSJCU2qmPaS5+5KSCMff4ukUY=;
 b=vPhNmr+a3gTw4UMndgt9JlxXN504YpdwYi/gh11k8Agw2v1xFZ8xKjAffuvtR8WiGaFJYlR5EDFuyNm36mr5reR9oPmdUa8ZdaaI/1N4Wt9aP+necDod1sTj6dtL98TZjQeRom4feZx8DIJEUqUJzrgycavy871uhxhrVCIjcANGUrY/w2/MBo0c1smEGWf0sj6Yxu2lulFBuLFUcWIBo7Qh1HWyX2WEVwjj3gF4jcxbrjmtMNj5IOwoGN8i6Shh4P3SQq56Cx8A5VASvKPQEXipBRvZuTK6ZGZLS00nHLhwWQwnv7Hh4mEO010LHLg5yNxMJZYk9A7h2bEd4xMicg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CH3PR11MB916300.namprd11.prod.outlook.com (2603:10b6:610:366::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 14:55:55 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 14:55:55 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Gao,
 Chao" <chao.gao@intel.com>, "Fang, Peter" <peter.fang@intel.com>, "Maloor,
 Kishen" <kishen.maloor@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 4/5] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Thread-Topic: [PATCH v2 4/5] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Thread-Index: AQHdRPzUAgI3EnvfLEqqhXkejDFLQrbQJb0AgBiNBICAAC0ugA==
Date: Thu, 1 Oct 2026 14:55:55 +0000
Message-ID: <149b113ed0665816eabc17a37349a9f18a7290f3.camel@intel.com>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
	 <20260915102658.713079-5-yilun.xu@linux.intel.com>
	 <c373197ce8a8a7238696ce94bcd3dd7ba8be092e.camel@intel.com>
	 <ar5M-jQA-rejFjdw@thinkstation>
In-Reply-To: <ar5M-jQA-rejFjdw@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CH3PR11MB916300:EE_
x-ms-office365-filtering-correlation-id: 2ecba814-d08a-486d-a82c-08df1fcc1867
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|22082099003|18002099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: ma/iXBY/FKPuIyX/TazBTjwy1JzSe0a/6OOjKR7DssctvSfUirNpIfU3NaadysNLTrV19W4pyp9v7dbCNSOtqzNrKMZ9Puv81lztTVyN7JbTYLb+FiUGfUaZ3XQ14FlJBdu19wurPclzOqhfJ7sRY4GWMc6V0IYLxAOjWYO1wJAB6H6SotGCNVSRf83jyGR2vlSMfs0rkoP+YEJbspCJGUGMvzJmk/veKZ9RpWoRUGv3R9+W52GxQm4GHfG+rVtX3iB9+8sgwl7gzly7nLUUKPQveFdDFchJc0BfjZtdSS9YpSDu2Rse4b4qaNgQwzLjDoF4iqXGP/sWfDlO/hr8qNru1yQr88NAgC1GCewjXak/yS9Do7Zn2vmbFXU84VF47cSEagwRzy378EQGUjf8ODlpabSou9vw9MVNhtRwi4KQY8aUGRdqqa2Ekw6Cp+UeMfzP4cpO0ZHDE7cVnDsixWHM/OgmxRi1IMoXAfW/31bkMd1igbVkT7KvyPekbMajDDbcCavNNhPVhKsGdJlYCOoCk37i6RZ0wT6WiJsd4qCs4eBvhqNBM2/hboYElJMaT8HU/sdKreUi4zp8imfGbQ7CBaxn9faBA6A95vWsgZhHLntrKCNGl+aG3t3BewsX2v10hp2v13ebvBZkmCQAr6QwjtDyjHQF83EWHIWEyM9PGs7KSXQBzugBShVKFQPLfRcl7xtIMaW5gJr0c2QEeQ2ZOA8QaUH7Ydjws4VsV10=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(22082099003)(18002099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFlxRitlTFNEbDdueG4yODkvanF4UlA3a1dUdkJVYmRMdWVlNTRzYldlY3Vs?=
 =?utf-8?B?YlQxVlF6V2g5Y2R2dTBKMU03SURwSXF0b0hWamJ4ZUR0dnZqZkNXTUVBRWh3?=
 =?utf-8?B?dktRK09BY2FCY2hUMUc3eWYyTTFBK2hodGZiMHY5cjNCNkFTOXR3YmJ4emxV?=
 =?utf-8?B?L041ZHpTK1E1R2dqMlJOcmQvYUhESnM0MEZVYTZ3WmRYaE54UmpVUC9sOUVM?=
 =?utf-8?B?NzZBNnVkZUs4SjJjK3MxTlZrek9KK2F3NktDM1MzWjBiUzhrZ3FLZFZUcStZ?=
 =?utf-8?B?YUkrY05OLzNOVFRDQmZ1SnIyTUZ0VndMTkk2VlIrNzh1WFVMY0Q4Y3B4Nkt1?=
 =?utf-8?B?eGYzaHNJM0hFQXp3bmx5WmhoMEZOZWNMOGcyTWtWQkhURjlVa2JKNVVxSTB6?=
 =?utf-8?B?VkozUEpHTjBTTWJqLzRDWDdXSTJOUC9NQThETjN2ZTVMcjZISUtJbjBNMlRp?=
 =?utf-8?B?b3g2Vk14Y2JUaFdGMmVSMXptZVN6WG0wV0tpT1A5SlJobHVrSk9BWkFyV1VO?=
 =?utf-8?B?NzhnRG40dHp3OW45UmNVNlVIbmhuQSt6SXNEOHRmUng4V1c5Z1I0NnlSYjUy?=
 =?utf-8?B?eDRGbjhDMjNxV0hlZzhFT3h6bWVybHI3VExsVWdxODF6ZEZzdkJ2NUhFMW44?=
 =?utf-8?B?MW04RWZlTXplaHpWVk5KNVQ5UDZtTnQ3RHpmajJWY2dNdURzZ2Y3WTBhWCsz?=
 =?utf-8?B?R2RHUDVyS0tkUEhSckc3WU9QU0toNnlhaWFaeVhYK1l1U2k1TzFDM2RnNDA5?=
 =?utf-8?B?bGJabGUvZkh3a09wZ2hIN1pkSFFmTnVDS09YckdmQkxhSFR0VTYzR0J5cmxv?=
 =?utf-8?B?M3VxeDd5UXpzVFBvN2YyKzJNRjZSbWpnaEVrcjB2RWw4L3JiNTJkOG9YeGtR?=
 =?utf-8?B?VTBxVU9hOVozU2VhTEVtdE5VdUxsd3ZFZVp1U2tOcUhLVWtPU1FZdStONkxS?=
 =?utf-8?B?YS9mWGNnajFza0JsaFRSZ2JkSTRJODhTYkRpdG5mV01reEFjSTBoNEl6WWI5?=
 =?utf-8?B?RkhkaUlXVE5BdUREZEc4eEtmaG94QmplSTMrM1pETWF3d0pjQlZKRlVQM3pW?=
 =?utf-8?B?di9FQ2UzdmdHbFhGV2VrWW1laWtMOXVKeXpRb05mTmVzRGV3UCswOW5RekFo?=
 =?utf-8?B?ZzdKcEt2dzVTNVFDL2RwOTl5ekRER2JUVEVGQ0RXTGtEM0Z0eDV3NitSeURO?=
 =?utf-8?B?NFJieS9YbzdBNnYzSkdrRmxrcm5Ob1k1WGNlakZXZmZOaG5uWU8vNDR1c0Fk?=
 =?utf-8?B?dTlSQ204SXZrbUMxM011cjA2cUJISlBOMkhJM0c2VFVkSCt0WWEvYzJyMDVM?=
 =?utf-8?B?dWtKV1hZdmM2cXJtUWFXRFVKT0oycHJqeHZnTE5Pc2VSUzVNTkxCUmVwT1dQ?=
 =?utf-8?B?YWI4ejRrQVNoU3pMVHdEd2FwNmF5RXJCUnVBSkZFaVcraDE5MTZ1b1pvRW9X?=
 =?utf-8?B?WTAyQkVBVzhqQTNaeHVmTUltVkcxKyt4UHRvS0R3aXVodVZUUjBHSDNlWEZl?=
 =?utf-8?B?Qys5Tlh2VUZucWhKNUtPRjNjTW1mYU9FWkF5Qm9LNXFMVGMrQ0tPQTNFeVZT?=
 =?utf-8?B?anBrSWRDbFZ1azNTUHR1S0JQdW5Pd3ZtOUIyNytzakpWZjlhMGhQOWVIdUk5?=
 =?utf-8?B?YWVJSUFkcXVmd3JxR3ZkL2JQS3NHbkhZTFc5c0EwWDlPT05FU0RuaGwyRm03?=
 =?utf-8?B?VlhEWFpNZzFJUkVSNjRLV0UrejdnQ2lUd1U5M0Fna1JtUlNZNnk0d1NTNzFi?=
 =?utf-8?B?YTJTeHVQSURWRVpuQm52L0JaODF4TkxSdjFFeUd4WmlmdHRacGRmUHFlK3l6?=
 =?utf-8?B?ZTFWRHNPbHBiUGhvdVRqdWc4ellTYXVvdTROYmZSSWQrSXJyZVJwaUswNWkx?=
 =?utf-8?B?Qk9XMVM4OUNlTDY4YlBoenk5UFc5UkJ5NlRjT2NOL2t2YlBYYy9xenVjdURu?=
 =?utf-8?B?VC9yNVVRdWY2MlpUd2cyTlFhc0RZdTF6WjkzRHNVaXpKdWJzVGtKcGtWci9m?=
 =?utf-8?B?RlJIZERsU2VFdS93ZS82SmRZamU3N05SLytLVEc4RXN4Yy9pM1VmZWJGcjUr?=
 =?utf-8?B?VG5sTHBTd3FabjJKakkvU0lPanlOSTZlamRHN0VOelR4ZnZiZEpQdU5tUTlE?=
 =?utf-8?B?K0JPcWNxaHAwMk1VbURCenY0NGxjK0MzQmxJdnJFalN2UVF1MHNjMDMzYlhi?=
 =?utf-8?B?SmdGbnQzMVFUcisvQXNpaXB6SVF0TUw0djU2NEkyaDE1K0VVZ1A2L1V6MkVy?=
 =?utf-8?B?M3cyYU1RL1p0eEFDTHNTdTdTT1VBSElaREwrSTRXL2NQNnJPR0tKcTVSeUk5?=
 =?utf-8?B?SVdmZVRuZm5kVER3NHhSZm5DYVBvRENmQ2xyYzBGU3ViQlkwQk5YVDRIMXYv?=
 =?utf-8?Q?vNqSMR2a6YKx4pRM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A995BF3E882D96458897C216AC92B185@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gp+8O6aodNsW3GgepJDu7PJoDmIKpGQaKGPP+os03y1ZGMjikMsH1ApGIVlMkjfvGk9B348e5MUmrx5m0u2iYB/dNY1T9SGuW/2GdWVcKSuIQXHe9VMBt1Yn/BoYJ8ini68GPRSgOr/qrkiPuVbcA1x/7MalA2+IubVXxgz9iddQQJx3k36LCdA1nKjMnNSYreL6ahQWlkdcnEkiSrj3HkEM5YZ4YgzftQMC2J+rioNdvwdV4A8oxJS4Zdtu/4JIqA1pqW+K/hF71ofjaOY01zzogc2Jzhyco9KD0HxVyHPeXfOM5AUGsixqZqcJFwLqxJ73vD0NigYWf7P0ii1pmA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecba814-d08a-486d-a82c-08df1fcc1867
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 14:55:55.1304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0XXniZ0uaNJVEMYVr6XARHiC1bYJD2xqJp9JG4bph/dZ70/kzewWOsCF2Bi6EMSMpnEIrMiAjrLz9hmL80GYRgkQC84+wx4Og44oe9mNsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB916300
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTEwLTAxIGF0IDEzOjE0ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+IE5vdCBuZWNlc3NhcmlseS4gU2VlIENPTkZJR19TSFVGRkxFX1BBR0VfQUxMT0NBVE9SLCB3
aGljaCBkZWZhdWx0IFkuDQo+IA0KPiBCdXQgZXZlbiB3aXRoIHNodWZmbGluZywgcGFnZSBhbGxv
Y2F0b3Igc2hvdWxkbid0IGNsYWltIG5ldyBub24tbW92YWJsZQ0KPiBwYWdlIGJsb2NrIGp1c3Qg
dG8ga2VlcCBzaHVmZmxpbmcgc2F0aXNmaWVkLg0KPiANCj4gSXQgaXMgYmV0dGVyIHRvIGNoZWNr
IHdoYXQgaGFwcGVucyBpbiBwcmFjdGljZS4NCg0KRmFpciBlbm91Z2gsIHRoYW5rcyENCg==
