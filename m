Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088E3BAD92;
	Wed,  7 Oct 2026 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387972; cv=fail; b=rgzhdT0o8BVA2t0l9mPYr3stj5MaUjcQpg8Zbo89z65KUnIM3PHD4k4PQkjZ6ALWPGujjP98AQEje0w+AYhkQVqSJN/vgzPQ4oRH8M2qRZ5kwwunDYX/u8C+4tvzRJyEqEB6ZQl5JJ5RqHwtXAuIJpjV1rNaslxHgRLMcncNxMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387972; c=relaxed/simple;
	bh=etSzdju7aHtHYLnRaqY2YoDb4eN76GjUnVsy4khApQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fgRZ7SL91jZcKiuCBxWBUvMOXyLvcJWrh5loQbbKrmV2CCcNcoMPLI2DS/NwF/NYynboVzwEMS+m4ew9AAog5yUchjGW0T3p3l/VmFbo+ELkwtnvplkoHGLCBCd/wrMl6TiGSZjYUqK2wbmKDpAAE0xv2O9IW49UDJ1XGwUomQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dyBrSQhg; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dyBrSQhg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791387970; x=1822923970;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=etSzdju7aHtHYLnRaqY2YoDb4eN76GjUnVsy4khApQ0=;
  b=dyBrSQhg0QF+GX27n4+ZTlQDUPiVNvZc0mRd0DtANkSBNHP+O0rbEp6H
   U4SWsWDqThN3MVhdOmZGfZv8Q1AzdQJxy/1H69Ws9z3y2acZwaEeoFdS+
   3WgAgy8Spe82fXNKFliy0z2vP7yYcXJKYF5L9Vxisimksvsdh/IJ4BdJa
   ka8v9FKoPqsHxhkPEsMS7fTPW1yhphKmTuxvr09eN/f6cI80jI0CHk8iI
   m3ffU6/nndWVdeU3iIL6gZk1LYq/u4lqKQ1WRhtcDm1ZIIFRXc8JDCOpQ
   ucgxpcQFBgzktXU4yuNxrLEGFr7kpSZ5r2+Fy8E9okrKOPHb2yl4kZ/S7
   w==;
X-CSE-ConnectionGUID: rBGv80aPSv21/skQiBkisg==
X-CSE-MsgGUID: SX948SpETUmLbmUOwRhqgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="49251"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="49251"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 08:46:09 -0700
X-CSE-ConnectionGUID: XGlRZfECQWeKv+Y1zdOvWg==
X-CSE-MsgGUID: xIhpZ7lbSdW+/JyCzf9hKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="1578300"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 08:46:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 08:46:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 08:46:05 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 08:46:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGGVQuBTXMaTFgCR+7fkGwy2IWA5iBekT1ThTG8xyFuvOJfeAuCUCjSAZ1ukydfOH6mQadD8MgYisrtvAi00hU0wLAJ2o+s+82eGYFq8UnqLDw1OM18cllClm/ylh8L4PUk/goTeso0NnZIPQP9W2YwFyvYv1fqcoK607j+LryShX4h8//mbg8COwBa+5Ymb1pJCfrT2nyan1mbSrKeQS46mNq/oRhBQKlF1/LOBEg5yxVHgtldpaEIVK2bHo4eEUX6jb5DnMp33pyvAg7nxaZmtXgj8GUtJOp0L5OFNduxfarPlFeerpvGIs+/gCnWGgCILSJnG2wISL2VFKg6W0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etSzdju7aHtHYLnRaqY2YoDb4eN76GjUnVsy4khApQ0=;
 b=sheJxRpiTbEC/icI7arWE2Do6/nbcHOn73ztO7DbnuOLA14QS2Z4FHbx47z6Qk2hoKkioIA5u/2NqFx3IQjAxKZRbo+7k1L10xH7jn4SulMGkOQ+RJU90dqnwuN3f/EDV5zBLpWmRfcZXtZJPtn1NK5XALDoCz5QZD92N26c2xF8/dbrmOTXMHIYkUFmgh/b77i9iV1e4urnY0X89GERFXLSej/CIW4hM/ZzHpZAvftaBbq7j62cNJy3n7ERrpWB4NvJ5GiLVBjKbdWuYDH2r9h9f9E/s3ZyVLMy2WYGkE6ddOJXYy0WeMdLt11LVdDSh6PxBXaKpyaGZ1IJefjELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 7 Oct
 2026 15:45:48 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 7 Oct 2026
 15:45:48 +0000
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
Subject: Re: [PATCH v4 06/17] KVM: x86/mmu: Allocate DPAMT pages for
 vCPU-induced page split
Thread-Topic: [PATCH v4 06/17] KVM: x86/mmu: Allocate DPAMT pages for
 vCPU-induced page split
Thread-Index: AQHdTylEUwxIhfdjnkuIpWUZwgMmJbbyR4EA
Date: Wed, 7 Oct 2026 15:45:48 +0000
Message-ID: <76157e3dcff065d444d83a9c5e7a924967fecc87.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091005.15567-1-yan.y.zhao@intel.com>
In-Reply-To: <20260928091005.15567-1-yan.y.zhao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB7309:EE_
x-ms-office365-filtering-correlation-id: dad145fa-741d-42a2-2595-08df248a0f1e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|4143699003|6133799003|5023799004|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: cUT0HeY86pAqxT1zs9XzqY8O6GU5D/0vzVdyhkMexZ3s3LR/wGl6RktuBPz4XH978FWmOcAaVu3OFZVz5q47RDSzYOFQVFpkWYpHRefqfRo7TP8WP1nAk5wOEoheK+SM0I8Ve9eqS8IVm6DY3RhjseXdyOHoqF9wLeWzlmHQm8TGzOSziBj36H1TKILxBbjTqOgJF8tV0Uu6rkm9xoIEqGnVrBCxdJ4zZ+qwh93Dm0e2XtAQCAm2Dsk+fqqdQdn26NLmnS9XEewTn+wLuBcvTTmH1lqDy4hmAk21lUVDwAKfLREyVc+SfwhfwsIhFtYSLFjewK49z97Q3h0LWwj8GJLUNKVwW1cCvmytgKC8eFzcfBe+DDoqcOdbJ5rqtg0zxNs0iS65rIcsXGUHSz6qCCWA7f0pFjI7r353lUl/IVdSaY/6m0iml2uWb94ujCMpp8/gOrXfcLgsOOKjfCxCAyzy+V0Oy++2jCoTVx3AS9CviB39iz2bENtAzv5Yi+zKRwlNpUkFyqY6X0bsxLZ+A5/H4vecSCgcieMqsjPTxIxeAy6rG5Njw0EEd9gOyXyvCtJHVt/C4lUKtVVE3i+fKkceWNlx7CFB+A5nIxRSkA2a3EQLOkcyKcPBIWt692GFPzimXxQ/7As/br0V5ecKgFRQi0n8OGN0B50H+z+1Iwo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(6133799003)(5023799004)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk9FNThoUTVlaFEwNHp6eTI2YUU3bmJ6NGNIWnZlcDIwdjNNaGtDcEs3SnlS?=
 =?utf-8?B?ZXFqVXA2TmV0RWhTV2tEdG9yZ3J1RW4yT1FFR2JsVWtvMG5zcHJXeEFzZXdo?=
 =?utf-8?B?Y2cxTkRHUlFxSmo4YjZLTlBKdExyWkFNeXYzd2pPZnRjYVpLdUpqVURxQmFD?=
 =?utf-8?B?ZXNjSHY0RGpFUXo4SXJRZEIwL2JqUzJkRmFQMHJjejF6R09hK2RodS8vS0Zk?=
 =?utf-8?B?eFo3NytHQktOaHdFSGo0RUdkZFFCM2hOazZoTU9JYzRQcFBMYU1Vb3NUNWZi?=
 =?utf-8?B?bmozZFJPVlRPR3JPc2JWbG56dW1QWklmWTVBUzJqMFFDWEdkWGovV0IwYk5K?=
 =?utf-8?B?RTQ4S1N1alBJUytJanVWTGdPZStRZWV4UEU1MUlOVlc1T2w3NllLNjVSdUFT?=
 =?utf-8?B?SDRRQk0xMnNZVGNhU0RQQWlQc05LUUp1ejg5MSt3N3JuNmV1ZGs5MzRMMllH?=
 =?utf-8?B?NFY5MmY1L3hhVm5kNlBDMHBlV1N0WjNnRFpqaSt0clloY1ZuVjNmWmljTzNN?=
 =?utf-8?B?THBQSEFoUlFhWldkQnhvRm9KNDZpMGRkS3dHZjhnM09odU9yT2FPWStQTnFo?=
 =?utf-8?B?MzZUblRHTGpUdFMyTzZOY25mbWo5eGkwNlZjZkR5ZHFUM3NxVjFMTUhwMXRS?=
 =?utf-8?B?QzFsdVIxRS9yRUJRUy9OQlo2OG5GN014ZXQ1OGxndElMRWU3UVJUOC85RGhG?=
 =?utf-8?B?c3JvMEZhbnUvKzlaYzd4MW9kNE5mSllqaVJkWHhXUG5UeUVxcFBhRWxDTHpn?=
 =?utf-8?B?Wi8vQ3Qwc0puR1UvYVl5OXI1NUwxQk51Nm9LOHFoM3dja1FaRUYxN0IzTSsx?=
 =?utf-8?B?K3JZd3dHNS9iSklLMWVZaDJSWUFrTStkMmIvNHpVbzlnbkxDK2ZFSjQ4dkli?=
 =?utf-8?B?NUlUNDF4bmMyM2dSeHhRN285R3l0Mmo2WDVVQVpYV1NIZnBLeGsvVzZmTGNS?=
 =?utf-8?B?cnZUekxnUjlrR3FINlg0TzBqaXFpMGI3L3VXTzVmeURLTDVzaXBzcFlEUFcy?=
 =?utf-8?B?UHVPV2tGNlE5V2FQTlgvOXpEMGwvMnR0emlJcSthQjZZVmRNbzlIcFpSZWEw?=
 =?utf-8?B?YXB0eU1yb0FrdDNmQUZTTWdMSW5VbzArNWFFaFFxWnA3OUMrLzRyZUpxd1Nl?=
 =?utf-8?B?RXpxYnNaajU2MTBRcHN6YlR1ODRJMStuVkhjTHZsZm81Y0xwbC9adUZJNmk1?=
 =?utf-8?B?WGhQaER2UjNYSzBHRWdoOEVCald6M01HVmxyZlhjQ09ENXJrRUw2Q0g2cTBs?=
 =?utf-8?B?VWtLMnhtYzlBOEs2SkhIeXF4THhZSmRpVWRvbHJMRGxWdTFLZWo0eVQ1b0NY?=
 =?utf-8?B?WGlPY0F2UzdNNzFoa2lWc2NHR0Q0YlhpOFpCVi9wbHNOb3UxTHhFM1JCQ1JU?=
 =?utf-8?B?UDVwS3drb0NzOHRFMlh2cFc0WWZZdnplYnVJMURUQm1Id2JJNWl6VURLcWM1?=
 =?utf-8?B?MjFIZUNTT1pzV1g2MGlSQyt2U1F6bkE3d1IrZWpHbkFaQVJQWStlbGdGNFV3?=
 =?utf-8?B?OHAxbUxUQnN6aHVERWluVkw3c1YzNnp0RTZ6UzBUTE1LRTNxM3h2c0k3SGNp?=
 =?utf-8?B?Q3k2ZUxXbmltT3lCaHRLUkRrek5ONEtJcWhEODFFYkxwMEF5ZnAwTUVjMG8v?=
 =?utf-8?B?M29xTzdma0czdUd1VEUwQjFrWVR3K3FBZEZUejFONE9WdjYvQm8vcGx5TkdP?=
 =?utf-8?B?azM1N2hRRHBkV2dpaTlLalp4bGx4a1VKQVRIakJFMnJEQVV3TXYxUjkvWDZE?=
 =?utf-8?B?Ly9Nb3htMk1kdzFiZmFJOUxCUW1RZDZ6Wjd6aU10Ukd0SEEvM2pvUUNHcnQ2?=
 =?utf-8?B?NE0rVFlVTzJjV1E1R0E5TWRadjF1SXoyQzNKUEpqSVBqUUpXS3gvSVhXdFJ2?=
 =?utf-8?B?Sm1DUnNlaWFNTnlHYzVha2Q4dXdtZDJTU3FtNDc4WFpOTW5WS0VlaUV4dVZz?=
 =?utf-8?B?WXVoQnFDRjUyY3RpNlAyd3dkVGZoQjIxYnlWTTJnL0pBTEQyR1c5d2VxZ0VV?=
 =?utf-8?B?QXFidHhvcVBVc20wWVVnNWxPNUd0QmU3dnJiMU1LaGJDV1RPOTlzZXA3Nkw5?=
 =?utf-8?B?TnNBK1FrY2tJWXkxZ2NkK1hpRGVlMG8raVRXbFpFRys2bHI4UG9mSVJJR1J3?=
 =?utf-8?B?NEtMWjVnNnNJa01qUHFRQ2JnVUp0cUNtRXU5blJSRDdQRzlNTGNZMUF2b2ZV?=
 =?utf-8?B?OFFCSXZZVWZtbEJuUERGZm4zQmlaa1hiUEF4cG5uYkl2WGpGWXJmazBpYmhO?=
 =?utf-8?B?ZGhJMGV6TldmVVUrOVVWc1VmTzlJWTNCeGZ1eTA2dVFILzVHT1NrZnlva1pQ?=
 =?utf-8?B?Z2lQMTNmVjVNWWpoMEVEVTRBWHcwTUNaOEdQalVlbjFwM0NXQmo3TitlUk5W?=
 =?utf-8?Q?cdswu/R5+ZpOGGfk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <079A1B8BD9D1DE44A98AE37D06007C03@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5QJxBNPRIP8Kt4YdlDXlySCkJi9SwRkE6IjaOSaW026Zi4Y9BVbzK+CicLtCCZD9kckEEDW2ds5XrvxfsSgSgah3U4FztClcjYSsKjHudlurCFhmDiPqk3C3w8SfMdnzMTggXPSXejp66xJClm7Vr+iHLI+a/Q45gnss+tE8YiLjgF+Mr3JVSvOEc01umUkgGcjUpEeu6a2pg5gz2P6vXp7R0L4xOYpQb5I+QmRXZszYLGjnWcM0o5DdjyC6g1gzCCgngUuCbSVpwEcSkXrCL8gNRzD4QKRx3tQvB0Cn1u1kEKuzhSMpcZ1zULNMleXkKE2f9NVXpg36dpMgXUBu6g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad145fa-741d-42a2-2595-08df248a0f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 15:45:48.7052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDSW/Q1MzFh97CQhJXFGmkJK7+TSA0o9nFS1bISSS51U0dk72pLqMzdS8K4L/R+MVydXJJXiRcUUSweu0eH9IEJD9GOgA7moEAdeU0EGjpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7309
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjEwICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gRnJv
bTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0KPiBFeHRlbmQg
dGhlIFREUCBNTVUgdG8gYWxsb2NhdGUgRHluYW1pYyBQQU1UIGJhY2tpbmcgcGFnZXMgKERQQU1U
IHBhZ2VzKSBmb3INCj4gdkNQVS1pbmR1Y2VkIGh1Z2UgcGFnZSBzcGxpdHMgaW4gbWlycm9yIHJv
b3RzIHdoZW4gRFBBTVQgaXMgZW5hYmxlZC4NCj4gDQo+IExldmVyYWdlIHRoZSAudG9wdXBfZXh0
ZXJuYWxfY2FjaGUoKSBpbnRlcmZhY2UgdG8gdG9wdXAgdGhlIERQQU1UIGNhY2hlDQo+IHdoZW4g
YWxsb2NhdGluZyBhIG5ldyBjaGlsZCBwYWdlIHRhYmxlIGZvciBzcGxpdHRpbmcuIFRoZSBEUEFN
VCBjYWNoZSBpcw0KPiBjdXJyZW50bHkgYSBwZXItdkNQVSB0aHJlYWQtbG9jYWwgbGlzdC4gV2hl
biBhIHZDUFUtaW5kdWNlZCBwYWdlIHNwbGl0DQo+IG9jY3VycywgRFBBTVQgcGFnZXMgY2FuIGJl
IGRyYXduIGxvY2tsZXNzbHkgZnJvbSB0aGUgbGlzdC4NCj4gDQo+IFBhc3MgbWluX25yX3NwdHMg
YXMgMSB0byAudG9wdXBfZXh0ZXJuYWxfY2FjaGUoKSwgaW5kaWNhdGluZyB0aGVyZSdzIG9uZQ0K
PiBuZXcgUy1FUFQgcGFnZSB0YWJsZSBwYWdlLiBTbywgdGR4X3RvcHVwX2V4dGVybmFsX3BhbXRf
Y2FjaGUoKSB3aWxsDQo+IGFsbG9jYXRlIERQQU1UIHBhZ2UgcGFpcnMgZm9yIGJvdGggdGhlIG5l
d2x5IGFkZGVkIFMtRVBUIHBhZ2UgdGFibGUgcGFnZQ0KPiBhbmQgdGhlIGRlbW90ZWQgZ3Vlc3Qg
cHJpdmF0ZSBwYWdlLg0KPiANCj4gdGRwX21tdV9hbGxvY19zcF9mb3Jfc3BsaXQoKSBpcyBjdXJy
ZW50bHkgbm90IHJlYWNoYWJsZSBmcm9tIGEgbm9uLXZDUFUNCj4gY29udGV4dCBmb3IgbWlycm9y
IHJvb3RzLCBzaW5jZSBkaXJ0eSBwYWdlIHRyYWNraW5nIGlzIG5vdCB5ZXQgYWxsb3dlZCBvbg0K
PiBtaXJyb3Igcm9vdHMuIFNvLCBzaW1wbHkgYWRkIGEgV0FSTiBpZiB0ZHhfdG9wdXBfZXh0ZXJu
YWxfcGFtdF9jYWNoZSgpIGlzDQo+IGludm9rZWQgdW5kZXIgYSBub24tdkNQVSBjb250ZXh0Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IFlhbiBaaGFvIDx5YW4ueS56aGFvQGludGVsLmNvbT4NCj4g
LS0tDQo+IHY0OiBuZXcgcGF0Y2guDQoNCk5ldz8gSXQgaXMgZXNzZW50aWFsbHkgdGhpcyB3aXRo
IGEgbmV3IGxvZywgcmlnaHQ/DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vMjAyNjAxMjkw
MTE1MTcuMzU0NTg4My0zOS1zZWFuamNAZ29vZ2xlLmNvbS8jdA0KDQpSZXZpZXdlZC1ieTogUmlj
ayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KDQoNCg0K
