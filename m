Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463D2C326D;
	Wed, 23 Sep 2026 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790122587; cv=fail; b=dBXXITycpTN8CA5WA+U3/fydP50IBTvu4UK5jmuFm77dTsnv5eGgzPaHnqpUOZ19YpnnGA/PuMdbaZ655zgOffjI3wy3FzL1NUukOM9U7ObnGW/tQER3tgpkdFmAiCZkjID6iqpI0pvnnLrZRBP8XMCPF/XgyG2rrAmfoq/J3js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790122587; c=relaxed/simple;
	bh=kjOFicN4EQOorTmYMZI2ScP6U1LGCtqoQi7Jg2KYmwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ohWXZOrYLhZVHu8kPDXFdZaBBGFrUJt5t94hMbhIsV+pnhNfCO2jCiFGlh1ha92n7WnrnZXSUAkNED6oFuSOzB6nJAeXZP7unfqzRhlOFAc5F/h6VWuiOhR7oWLjrjAr+/4RC8BTo/dAuhFYjxViEDy7w9ZgPmXkK2wGVgZzwYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIeaRy6a; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIeaRy6a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790122585; x=1821658585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kjOFicN4EQOorTmYMZI2ScP6U1LGCtqoQi7Jg2KYmwA=;
  b=aIeaRy6azK659ydbQzGLagLFrbhdOtH53+RfHiU4IpRTwQaX6R5uEpNq
   6F8F6+BeB9qwHl0zr6UO0fn/7W1PfzerKQsG4IDshqEubDW8OffGf3P96
   5RVjz9e7aJspyCyYHf6zffjRK+fOTtkwKqyncwbC+eFa54bdpJMUnYn+8
   ANYh5t3usJ/aWpyIfp/i2scXCLYKljchF5BrhruUo9t6sOiVwhK7UJUrl
   dDV6VlfR4awtYokx7tKFeQnCAUGe4XkzwjvBKu3jYJekkga39jlE2sTra
   EpEpEb1xVHNP0wfLzSTXl1B1SBr4+CgbszzdjePZfUXqDSRk0PX95afif
   A==;
X-CSE-ConnectionGUID: UbUQiN+iSSGMNO0YM4sltA==
X-CSE-MsgGUID: Lo6v/CPRQAiDzE3kL9S97w==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90644527"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90644527"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:16:25 -0700
X-CSE-ConnectionGUID: mQ2L3kWnSh6LvtJgl6bmDg==
X-CSE-MsgGUID: DDLD9JRWRBuWTDXs/GslOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4418667"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:16:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:16:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 17:16:24 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:16:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbZ5rUP64weDTmdZB6f4v8tduISoqv2HgQJ5UDY0ZcugH0qJoCiU512YEJqq5RUFFbeGXIoHk4KTnS4qu0hnr+XT94XpklUuXVAyrdrpBfmH0ZsA70XmLDmZPU4kYpvA35i242RjoQBjSYNNIKnDwO8mCXkbVcKi2MRsIKw62O9QIiJwmgzBqIrAL7OgFhso5u26ZJz6YP+jgu7kOJLWPoQw2SG44V3Yu2HBcd9279nxXjodi7duY8V9d/7173g6pCeqWhYj0+OrJpAT2UBHp8qWi/lAlfw1gdGoFPLXtbKk+J5ExHXsd614HqAZ3fqZYs2t2jpRo70SZRpgi+o+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjOFicN4EQOorTmYMZI2ScP6U1LGCtqoQi7Jg2KYmwA=;
 b=MoamqbAW2zGhGyAonqA5gjMkaiJTxPsU6ftjljup++q+Vk9C2w8PF3Jc97QwmoT4bUzWLRdUIPru2cr1IOgWRWtaIDS+k0kI02ECuuaqWhsHaVk5XF8Fxp1A/+eSkVSmTXkFO3NyQmDsDJkr9SMC5YB+OJbnh4yxYfswrdW3LTsfPiDgTxzdOltIlWt+zw3tWT8neOgO18b2xRGKjmlXqUoQTXwosJr9O6A3iKL7wTR4kt6TKfkpiT+tU9XV5LC04XWMjbX8YFisrDHbk1QKjVJGMqykv5alp5TxIrB8cPmPzJJb1pKdlkyHmw01Ka2BNbhW/qW3Ew/m5FOT4xnoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DSVPR11MB9577.namprd11.prod.outlook.com (2603:10b6:8:388::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 00:16:19 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 00:16:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v4 3/4] KVM: TDX: Filter configurable CPUID bits
Thread-Topic: [PATCH v4 3/4] KVM: TDX: Filter configurable CPUID bits
Thread-Index: AQHdRnUzPgAzWhphJ02QA2Q5FI7th7bbVJaA
Date: Wed, 23 Sep 2026 00:16:18 +0000
Message-ID: <d6bf5183b74b6c6f595001ee753405ea94a6042d.camel@intel.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
	 <20260917072548.2314491-4-binbin.wu@linux.intel.com>
In-Reply-To: <20260917072548.2314491-4-binbin.wu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DSVPR11MB9577:EE_
x-ms-office365-filtering-correlation-id: db43a5f4-ae35-4ba3-8db1-08df1907e400
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|38070700021|4143699003|56012099006|11063799006|5023799004|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: BwRj7R93T2cOG7xSM0zI8OEc3UlHr0SWMPOCGYhtPvR/YJQBcu41eQg12xe1U0E3FUXrGy3AUUok9e8YwNcCNE5nVCUXAZec9J/zYsdohWx0QSdmvrnveDzPntOGJCIREiSc48PM6HYnDAfAndkrmu2picCECjv3MQBDwHKXXNnBAsvc2fdBLqQwMgIpMQb0mzv8IRKDZCTV+rsDTIaOiUXWUGW09aW4TEvlyIKoELwZoZ9UWa+YSsrocU4BLPzJRBTZiF13KF9tJnMNTx2So/Cb9+8mjs2wi6zSykDUCWsD3GYMzLzmB7TL+d6zacRg6t6kg/+NyW1qj+/Sa9g3kd2sZcvcHVcHb8/BuQjg6ZY9qCOjdk6OhP2N5vUE1GsbTmpOn8Jz4HGxbsUEQmzelRLHvmg2MsJahpVvrHHQ9FB9exUj55ICD+rKjFkvnOt3xNC8egy3xzHpfvp7uvhnqqUQldSTNKtrf4y7XDtKVAXuMUT6/WkDOrmqgbVvOCt8M6MzTckIZPhyBaUH0O1XaHizYBwDG6LFzV4cgkITRn/N6Xr0ed0elM/VW5EcG46Ps92t+I6NmmC3XpBGe87gNgGrYCky5PZU+7zvX33LUwHWQrO2PlRdfdEKYk579oDMLW1Kb0maTpw1mJQqPiaI9R6Gw/Y9/EpnWkt0ZUKoPBeXsH3oS/fF93Hm1lVIHXRJLTiF6XonIZGKdPd1OvM0Ir5dcKYdlu2IFJ5QkI6tuH0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDluMW5LWFc4bWNQZ1l3VHIyYisraFcrbnRnODJQN2ljclBnYi95VWdGN3Uz?=
 =?utf-8?B?WDhlaG01NCt1RGhYVDJ1OUpjU0cxbVdpaGltaU5wWnF3TC9hY0s3VlRTRkpM?=
 =?utf-8?B?VkxXM1cwOE5CVkthdG5scGxQeTJNK2lhTTh3TUJmdkZwcWVrMXpKY3Y3bUU3?=
 =?utf-8?B?NVFYQjdTbkxjNE5UZlJVTmUzSzhYcmxENTFTWHhkWDNvc2ZTaW5QYkMwM3pQ?=
 =?utf-8?B?UDZyZkNhU1pacndGT1hZaEpkckZ4bVVtYzR0ZlgzU3JIRisxOFRIOXU0SWp3?=
 =?utf-8?B?Y3IvT0toMzc2eG1VdElLZTJHSHhvVGEzSDhWZGh0Z3pHNXpQQUtINGNmTm8z?=
 =?utf-8?B?aUs0UFNzbjRRU0tXaytPQTNOanV0ckZsRERxS1laZWZVZ0g0L2xlak03WVlM?=
 =?utf-8?B?a0MwYS9CREhBaEVQcHBxUEhHSGROSkdJMlpDaEVlcVRhUFBtOHExVG9selRI?=
 =?utf-8?B?NjNRQjNoM2lNM01SRi9rOEtad2RjREc1ZzZ3NG1OZWdTbUs3L3pWZkJEUkh4?=
 =?utf-8?B?eCtlb3RQNExBbUNvTWQvUitFcXBGV2RXekgzeXRiOWtzQWRFOTd1VFdWd2lq?=
 =?utf-8?B?R0gxNEFJREQ2YlNNaVdETGdOREJXbVR2Y0dWQW1LU0JrYlJmSERpUllqSHRu?=
 =?utf-8?B?S0JnSE1XNEhqejlxVW5SZzFPb2hpbERPbHl2anBINFI3SHBlcm1vZ1Z6eEI5?=
 =?utf-8?B?V0pTT0JnVkc4dDJKbWZQK3dmb3k3TUpiMjNVVXRLaUl2cVdiaTE0TEhmU3Zj?=
 =?utf-8?B?ak1BU0tRWU44UWpZbDdrV1JFY2JsS0FBaWszbFJ3QVY3OXlrTndVbzRjMndX?=
 =?utf-8?B?cGd4dXdpS0J4ZU4vUDhDZlVaaUl0V1B4UXQ0Q0dzeDFqdWhybG85UkVySVFM?=
 =?utf-8?B?Ynd3M1crdEd6dTZ2aS80R1YySllaeDVwL1dSaEZ6M25PTTB5Y2wwbjNYN1Ez?=
 =?utf-8?B?Q2g3cnVYUUdyelc4ZkVBNm1sMU1XZy9aMlJkVUF3a1dpbHg1TUFSZHBpak1J?=
 =?utf-8?B?TWNhcDRXZ0FKOWRncXUyWTZmdG1EV1A3dzhqNGNkN3BDZ3kvWkovNUtucUtu?=
 =?utf-8?B?OXRYbzNrRHgzNmszNTJPMHB4UkRjUGUvWmNVb05HTDZTUTViWUdjK3EvNTVa?=
 =?utf-8?B?V3pkRS80Y2ZaZDJmeUR0Ymo0NlBnWU1pczFoSkxnTG5TdCtrSDFxVHNPWjJC?=
 =?utf-8?B?UkU0Y1dnVUVKZlBUR0lWOUZST0w3bjFHVjZLOHpnblFVQlBmb0U0eENDZ1Ny?=
 =?utf-8?B?cFBwSDRGaUpZQU9HMjJhWlEzZGEvcVFQR3ZLa3NZSmhzdnVUektIcGlrdGZo?=
 =?utf-8?B?cWxWQmpBbVZUdHFseW5NTGxuQ1RKbURENVcyYm5MWE1pd3BoMnM0RnEzQzBE?=
 =?utf-8?B?S28rZDE4K0twREZuMVJ0bkFhc0RDRzdHUnBBVWs5OHIva1VRcml4alNyazlS?=
 =?utf-8?B?dG1NVUwrUHJESHBCbHVmUFl5Z3lCS3ZwMGlFZlJjTHZGTEd4a2tlRXRRMHdS?=
 =?utf-8?B?ZVhNdUU5bnAwaUcyaW5IM0dhVUZHaGZYWXgzb1RBQlU4SU91NDY3L1NLOW1w?=
 =?utf-8?B?MUt6Yi9MQTdVa0F1R281T2MzY3JCQTIzQkJWL3lEblNRdm41Z2ZadmU3Tm9h?=
 =?utf-8?B?ZUVHQTBYT2RUb2w1ZG5OVjhlbzlqN2FpeXdTbHN6Q0hEcVpaL0Z0WDAra1dP?=
 =?utf-8?B?NFZ4Tmc4MWU3MDU4K096RTgrTlA4UnZ5Nk5WQzNXOVVhckRuUW81S1pRNXRv?=
 =?utf-8?B?NytlTkxXNjJGU3Mrc1FLODhSMlBZc2NPUDI3dDRJalZhdkdSVXdIbFY0M2Jw?=
 =?utf-8?B?OU90T0krdlpIaTJhQk5KV3EvS1Z6SnFwbTBaT0ZPaUtLcGVQZkJ5SkE5ZHJ3?=
 =?utf-8?B?c2lqMjBKY3p6ajNveUpuRldUTnJHOUtLNEVjZjdXOUZjVHIwM0U3dUNKUUJp?=
 =?utf-8?B?ck8ybks2MmJzcFVOazk0bklwWkJ1WDE5TmVoQ0dIMnQrYjB6Ym9GN3Q3MkJo?=
 =?utf-8?B?aVQ1dkhPTGJzZjY4NWMwOVdOZFNDQzVRcnZzeXN4Q0poSndoYnN5OVNzZG55?=
 =?utf-8?B?NEhrbzduakxMVXgzYmx4R0Ird2JheFgrTDliS2JkY3ZPZ3V5dzRnN25tY3VX?=
 =?utf-8?B?YkplNnRWTE1xREdXWGVHRS9VekU1c1hpYmdjVUhMS3NYRFI0RE9wUkhVL3lu?=
 =?utf-8?B?TzFWUXV1VUUxVXU3MU0rclE3TmN6U1NnQi9TR1hGWFhzb1FydjNycytFSVRi?=
 =?utf-8?B?ZmNJdzhtdXFQY3IxbTRSRWVQdDRkT1o4ZGxUNVBITnJHaWVhZlFoRkMzdkFi?=
 =?utf-8?B?M1JtZmR6OUl4a1kwTGxkZXI5R3pvQnY2RzVNUkNtOGlkMWJYVnBGVEdoeFBP?=
 =?utf-8?Q?+HVttifxBl05foRE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D05F5158B8C564D88A7DC941B2B6A3C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: w2+krUxX1/v988hG29+hXC+8WNN0fRuLxrpbJZiFG6W5OLDHW5cdsgZ8IB3/JKJNxrt6BwxAiY9JirAMsfn5Wyc/nXU+nLhsDa1DuQ+NUhoKAnvxbAArQbISuBIntQzM60qNztwOb9mfGCftHoGxCcID5A2PgfyU6Qm9nvBKhJy1azTd3088iduUpzrePbbEzppAIjx7o7+0SbfWU1KtjQkzAJJ5G5pRd9ZDOSAG4C9qmTPowoZOk1xboawOKjixnZ2oNNwn/i5CXAih/RBYHDQ4BlabFq9JL5nUx4u1DBVEJx3Vh+g2mMfop3PJ6uOKvt0qFXeFOxWckRxZcDGXcA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db43a5f4-ae35-4ba3-8db1-08df1907e400
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 00:16:18.5467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JncFXwAG66pA0//mOMDEjyQqYSwTKJUo+VfiHbF+Ovo8vikWIGP5dfhBLxHUBZzpOeJoY1fiFM9KCOB8WvlFxmKRzgufE+qnKdxqGfrglNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9577
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTE3IGF0IDE1OjI1ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+IEZp
bHRlciB0aGUgZGlyZWN0bHkgY29uZmlndXJhYmxlIENQVUlEIGJpdHMgcmVwb3J0ZWQgdGhyb3Vn
aA0KPiBLVk1fVERYX0NBUEFCSUxJVElFUyBhZ2FpbnN0IEtWTSdzIFREWCBhbGxvd2xpc3QsIGFu
ZCBkcm9wIHRoZSBoYXJkY29kZWQNCj4gZGVueWxpc3QgYmFzZWQgZmlsdGVyaW5nLg0KPiANCj4g
VGhlIFREWCBtb2R1bGUgcmVwb3J0cyBkaXJlY3RseSBjb25maWd1cmFibGUgQ1BVSUQgYml0cyB0
aGF0IGl0IHN1cHBvcnRzDQo+IGZvciBhIFRELCBidXQgS1ZNIG11c3Qgbm90IGV4cG9zZSBiaXRz
IHRoYXQgaXQgZG9lc24ndCBzdXBwb3J0LCBhcyBibGluZGx5DQo+IGV4cG9zaW5nIGEgaG9zdCBz
dGF0ZSBjbG9iYmVyaW5nIGZlYXR1cmUgY2FuIGxlYWQgdG8gaG9zdCBzdGF0ZSBjb3JydXB0aW9u
Lg0KPiBUaGUgZXhpc3RpbmcgZGVueWxpc3QsIHdoaWNoIGNsZWFycyBvbmx5IFRTWCBhbmQgV0FJ
VFBLRywgaXMgbm90IGZhaWwtc2FmZS4NCj4gDQo+IEFkZCB0ZHhfZ2V0X2NwdWlkX2NmZ19tYXNr
KCkgdG8gZ2V0IHRoZSBtYXNrIG9mIGRpcmVjdGx5IGNvbmZpZ3VyYWJsZSBiaXRzDQo+IGFsbG93
ZWQgYnkgS1ZNIGZvciBhIGdpdmVuIENQVUlEIHJlZ2lzdGVyLCBjb3ZlcmluZyBib3RoIGZlYXR1
cmUgYml0cywNCj4gd2hpY2ggY29tZSBmcm9tIHRkeF9jcHVfY2ZnX2NhcHNbXSwgYW5kIG5vbi1m
ZWF0dXJlIGJpdHMsIHdoaWNoIGFyZQ0KPiBlbnVtZXJhdGVkIGF0IHJ1bnRpbWUuICBBcHBseSB0
aGUgbWFzayB0byBldmVyeSBDUFVJRCBlbnRyeSByZXBvcnRlZA0KPiB0aHJvdWdoIEtWTV9URFhf
Q0FQQUJJTElUSUVTLg0KPiANCj4gV2l0aCB0aGUgYWxsb3dsaXN0IGluIHBsYWNlLCBuZXdseSBp
bnRyb2R1Y2VkIFREWCBkaXJlY3RseSBjb25maWd1cmFibGUNCj4gQ1BVSUQgYml0cyBzdGF5IGhp
ZGRlbiBmcm9tIHVzZXJzcGFjZSB1bnRpbCBLVk0gZXhwbGljaXRseSBvcHRzIGluLg0KPiANCj4g
Tm90ZSwgZmlsdGVyaW5nIEtWTV9URFhfQ0FQQUJJTElUSUVTIGludGVudGlvbmFsbHkgc3RvcHMg
YWR2ZXJ0aXNpbmcgdGhlDQo+IGRpcmVjdGx5IGNvbmZpZ3VyYWJsZSBiaXRzIHRoYXQgYXJlbid0
IGluIHRoZSBhbGxvd2xpc3QsIGFzIHRoZQ0KPiBjb3JyZXNwb25kaW5nIGZlYXR1cmVzIGFyZSB1
bnN1cHBvcnRlZCBvciBjYW5ub3QgYmUgcHJvcGVybHkgdmlydHVhbGl6ZWQuDQoNCkkgdGhpbmsg
d2UgbmVlZCB0byBtb3JlIGxvdWRseSBjYWxsIG91dCB0aGF0IHRoaXMgaXMgYW4gQUJJIGNoYW5n
ZSBhbmQgd2UgZXhwZWN0DQppdCBub3QgdG8gaW1wYWN0IG90aGVyIFZNTXMgYmVjYXVzZS4uLg0K
DQo+IA0KPiBVcGRhdGUgdGhlIGRvY3VtZW50YXRpb24gdG8gcmVmbGVjdCB0aGUgQUJJIGNoYW5n
ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpbmJpbiBXdSA8YmluYmluLnd1QGxpbnV4LmludGVs
LmNvbT4NCj4gLS0tDQo+IHY0Og0KPiAtIFJlbmFtZSBmdW5jdGlvbnMuIChUb255KQ0KPiAgIHRk
eF9jZmdfbm9uX2ZlYXR1cmVfbWFzaygpICAgICAgIC0+IHRkeF9nZXRfY3B1aWRfY2ZnX25vbl9m
ZWF0dXJlX21hc2soKQ0KPiAgIHRkeF9jZmdfZmVhdHVyZV9tYXNrKCkgICAgICAgICAgIC0+IHRk
eF9nZXRfY3B1aWRfY2ZnX2ZlYXR1cmVfbWFzaygpDQo+ICAgdGR4X2dldF9hbGxvd2VkX2NmZ19j
cHVpZF9tYXNrKCkgLT4gdGR4X2dldF9jcHVpZF9jZmdfbWFzaygpDQo+IC0gVXBkYXRlIGRvY3Vt
ZW50YXRpb24uIChYaWFveWFvLCBSaWNrKQ0KPiANCj4gdjM6DQo+IC0gSGFuZGxlIG5vbi1mZWF0
dXJlIGxlYWZzIGF0IHJ1bnRpbWUuIChTZWFuKQ0KPiAtIEFkZCBDUFVJRC4weDI0LjAuRUJYWzc6
MF0gaW50byBhbGxvd2xpc3QuIFRoZXJlIGlzIGEgbWlzbWF0Y2ggb2YgdGhlDQo+ICAgZGVzY3Jp
cHRpb24gYWJvdXQgQ1BVSUQuMHgyNC4wLkVCWFs3OjBdLCB3aGljaCBpcyBsaXN0ZWQgYXMNCj4g
ICAiWEZBTSAmIENQVUlEX0VuYWJsZWQgJiBOYXRpdmUiIGJ1dCBzaG91bGQgYmUgIlhGQU0gJiBD
UFVJRF9FbmFibGVkICYNCj4gICBDb25maWd1cmVkICYgTmF0aXZlIi4NCj4gLS0tDQo+ICBEb2N1
bWVudGF0aW9uL3ZpcnQva3ZtL3g4Ni9pbnRlbC10ZHgucnN0IHwgIDggKysNCj4gIGFyY2gveDg2
L2t2bS92bXgvdGR4LmMgICAgICAgICAgICAgICAgICAgfCA5NSArKysrKysrKysrKysrKysrKyst
LS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS94ODYvaW50ZWwt
dGR4LnJzdCBiL0RvY3VtZW50YXRpb24vdmlydC9rdm0veDg2L2ludGVsLXRkeC5yc3QNCj4gaW5k
ZXggNmEyMjJlOWQwOTU0MS4uNmJlZWI4OWQ3ZjA1NyAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRh
dGlvbi92aXJ0L2t2bS94ODYvaW50ZWwtdGR4LnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3Zp
cnQva3ZtL3g4Ni9pbnRlbC10ZHgucnN0DQo+IEBAIC02OSw2ICs2OSwxNCBAQCBSZXR1cm4gdGhl
IFREWCBjYXBhYmlsaXRpZXMgdGhhdCBjdXJyZW50IEtWTSBzdXBwb3J0cyB3aXRoIHRoZSBzcGVj
aWZpYyBURFgNCj4gIG1vZHVsZSBsb2FkZWQgaW4gdGhlIHN5c3RlbS4gIEl0IHJlcG9ydHMgd2hh
dCBmZWF0dXJlcy9jYXBhYmlsaXRpZXMgYXJlIGFsbG93ZWQNCj4gIHRvIGJlIGNvbmZpZ3VyZWQg
dG8gdGhlIFREWCBndWVzdC4NCj4gIA0KPiArTm90ZSwgYSBDUFVJRCBmZWF0dXJlIGJpdCB0aGF0
IHRoZSBURFggbW9kdWxlIHJlcG9ydHMgYXMgZGlyZWN0bHkgY29uZmlndXJhYmxlDQo+ICtpcyBu
b3QgbmVjZXNzYXJpbHkgcmVwb3J0ZWQgYXMgY29uZmlndXJhYmxlIGJ5IEtWTS4gIEtWTSBvbWl0
cyBmZWF0dXJlcyBpdA0KPiArZG9lc24ndCBzdXBwb3J0LiAgR2VuZXJhbGx5IHNwZWFraW5nLCBL
Vk0gcmVwb3J0cyBhIGZlYXR1cmUgYXMgY29uZmlndXJhYmxlDQo+ICtvbmx5IGlmIEtWTSBzdXBw
b3J0cyB0aGUgZmVhdHVyZSBmb3IgYm90aCBURFggYW5kIG5vbi1URFggVk1zLCB0aG91Z2ggdGhl
cmUgYXJlDQo+ICthIGhhbmRmdWwgb2YgZXhjZXB0aW9ucyB3aGVyZSBLVk0gYWxsb3dzIGEgZmVh
dHVyZSBmb3IgVERYIGd1ZXN0cyB0aGF0IGl0IG5ldmVyDQo+ICthZHZlcnRpc2VzIGZvciBub24t
VERYIFZNcy4gIFVzZXJzcGFjZSBtdXN0IHJlbHkgb24gS1ZNX1REWF9DQVBBQklMSVRJRVMgdG8N
Cj4gK2RldGVybWluZSB3aGF0IGNhbiBiZSBwYXNzZWQgaW4gY3B1aWQgdG8gS1ZNX1REWF9JTklU
X1ZNLg0KPiArDQo+ICAtIGlkOiBLVk1fVERYX0NBUEFCSUxJVElFUw0KPiAgLSBmbGFnczogbXVz
dCBiZSAwDQo+ICAtIGRhdGE6IHBvaW50ZXIgdG8gc3RydWN0IGt2bV90ZHhfY2FwYWJpbGl0aWVz
DQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3RkeC5jIGIvYXJjaC94ODYva3ZtL3Zt
eC90ZHguYw0KPiBpbmRleCBiMzRhZmM1MmI3MTRlLi5hZDdkNzBiMzZmZmU1IDEwMDY0NA0KPiAt
LS0gYS9hcmNoL3g4Ni9rdm0vdm14L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2L2t2bS92bXgvdGR4
LmMNCj4gQEAgLTI5NCwzNiArMjk0LDc5IEBAIHN0YXRpYyBib29sIGhhc190c3goY29uc3Qgc3Ry
dWN0IGt2bV9jcHVpZF9lbnRyeTIgKmVudHJ5KQ0KPiAgCSAgICAgICAoZW50cnktPmVieCAmIFRE
WF9GRUFUVVJFX1RTWCk7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyB2b2lkIGNsZWFyX3RzeChzdHJ1
Y3Qga3ZtX2NwdWlkX2VudHJ5MiAqZW50cnkpDQo+IC17DQo+IC0JZW50cnktPmVieCAmPSB+VERY
X0ZFQVRVUkVfVFNYOw0KPiAtfQ0KPiAtDQo+ICBzdGF0aWMgYm9vbCBoYXNfd2FpdHBrZyhjb25z
dCBzdHJ1Y3Qga3ZtX2NwdWlkX2VudHJ5MiAqZW50cnkpDQo+ICB7DQo+ICAJcmV0dXJuIGVudHJ5
LT5mdW5jdGlvbiA9PSA3ICYmIGVudHJ5LT5pbmRleCA9PSAwICYmDQo+ICAJICAgICAgIChlbnRy
eS0+ZWN4ICYgX19mZWF0dXJlX2JpdChYODZfRkVBVFVSRV9XQUlUUEtHKSk7DQo+ICB9DQo+ICAN
Cj4gLXN0YXRpYyB2b2lkIGNsZWFyX3dhaXRwa2coc3RydWN0IGt2bV9jcHVpZF9lbnRyeTIgKmVu
dHJ5KQ0KPiAtew0KPiAtCWVudHJ5LT5lY3ggJj0gfl9fZmVhdHVyZV9iaXQoWDg2X0ZFQVRVUkVf
V0FJVFBLRyk7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyB2b2lkIHRkeF9jbGVhcl91bnN1cHBvcnRl
ZF9jcHVpZChzdHJ1Y3Qga3ZtX2NwdWlkX2VudHJ5MiAqZW50cnkpDQo+IC17DQo+IC0JaWYgKGhh
c190c3goZW50cnkpKQ0KPiAtCQljbGVhcl90c3goZW50cnkpOw0KPiAtDQo+IC0JaWYgKGhhc193
YWl0cGtnKGVudHJ5KSkNCj4gLQkJY2xlYXJfd2FpdHBrZyhlbnRyeSk7DQo+IC19DQo+IC0NCj4g
IHN0YXRpYyBib29sIHRkeF91bnN1cHBvcnRlZF9jcHVpZChjb25zdCBzdHJ1Y3Qga3ZtX2NwdWlk
X2VudHJ5MiAqZW50cnkpDQo+ICB7DQo+ICAJcmV0dXJuIGhhc190c3goZW50cnkpIHx8IGhhc193
YWl0cGtnKGVudHJ5KTsNCj4gIH0NCj4gIA0KPiArI2RlZmluZSBURFhfQ1BVSURfQUxMX0FMTE9X
RURfTUFTSwlHRU5NQVNLX1UzMigzMSwgMCkNCj4gKw0KPiArc3RhdGljIHUzMiB0ZHhfZ2V0X2Nw
dWlkX2NmZ19ub25fZmVhdHVyZV9tYXNrKHUzMiBmdW5jdGlvbiwgdTMyIGluZGV4LCBpbnQgcmVn
KQ0KPiArew0KPiArCS8qDQo+ICsJICogRm9yIGEgbGVhZi9zdWJsZWFmL3JlZ2lzdGVyIHRoYXQg
d2lsbCBuZXZlciBiZSByZXB1cnBvc2VkIHRvIGhvbGQNCj4gKwkgKiBmZWF0dXJlIGJpdHMsIGl0
J3Mgc2FmZSB0byByZXR1cm4gVERYX0NQVUlEX0FMTF9BTExPV0VEX01BU0ssIGkuZS4NCj4gKwkg
KiBsZWF2ZSB0aGUgVERYIG1vZHVsZSdzIENQVUlEIGNvbmZpZyBtYXNrIGludGFjdC4NCj4gKwkg
Ki8NCj4gKwlzd2l0Y2ggKGZ1bmN0aW9uKSB7DQo+ICsJY2FzZSAxOg0KPiArCQlpZiAocmVnID09
IENQVUlEX0VBWCB8fCByZWcgPT0gQ1BVSURfRUJYKQ0KPiArCQkJcmV0dXJuIFREWF9DUFVJRF9B
TExfQUxMT1dFRF9NQVNLOw0KPiArCQlyZXR1cm4gMDsNCj4gKwljYXNlIDQ6DQo+ICsJY2FzZSAw
eDE4Og0KPiArCWNhc2UgMHgxZjoNCj4gKwkJcmV0dXJuIFREWF9DUFVJRF9BTExfQUxMT1dFRF9N
QVNLOw0KPiArCWNhc2UgMHgyNDoNCj4gKwkJaWYgKGluZGV4ID09IDAgJiYgcmVnID09IENQVUlE
X0VCWCkNCj4gKwkJCXJldHVybiBHRU5NQVNLX1UzMig3LCAwKTsNCj4gKwkJcmV0dXJuIDA7DQo+
ICsJY2FzZSAweDgwMDAwMDA4Og0KPiArCQlpZiAocmVnID09IENQVUlEX0VBWCkNCj4gKwkJCXJl
dHVybiBURFhfQ1BVSURfQUxMX0FMTE9XRURfTUFTSzsNCg0KVGhlcmUgYXJlIHJlc2VydmVkIGJp
dHMgaW4gc29tZSBvZiB0aGVzZS4gQXJlIHRoZXNlICJubyBmZWF0dXJlIGJpdCIgYXNzdW1wdGlv
bnMNCmNoZWNrZWQgc29tZWhvdz8NCg0KDQoNCg==
