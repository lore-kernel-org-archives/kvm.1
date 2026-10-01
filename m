Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10013367B86;
	Thu,  1 Oct 2026 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814618; cv=fail; b=OAlQ6VswJCAWlEBPMPuEx0pQeXJwyQZtCs7ipVo0uW93FugLVOiaNxVgcbhDcSTXF6W4RJestYOcAaZ/DABYLNRz+MH+VtOXGDyWozTYWN6QKjepxpvaFomFlf1iF2oe61HdAkMbOHzrsmDcwQ/TqW4ovGU0cpfutVRs7XJFvRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814618; c=relaxed/simple;
	bh=45Zrj0HsDlJZt9KQ4rQYr0EeI6XjnHI7kzVuM1wT7Jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X9MtqASjnw9HcAXqLjS9Cr5iX6IMBS0928YX+FX/h+x5sqYkt3nqWSwbHBnQ2bY9F3VCypt/9Xdusuw73Z4DXAghsSLRK0YXUBL7MBoJ5ZqWGizgmL7gZc31r64kPCOUdq8+ZLJ3qphigWz6T4fsIM5FjxuP/cexBYJCWSL2GOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLK+JZeU; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLK+JZeU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790814614; x=1822350614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=45Zrj0HsDlJZt9KQ4rQYr0EeI6XjnHI7kzVuM1wT7Jc=;
  b=iLK+JZeUGFP5sM9kkYMbky/zUSxvu8/MIgDuT3gqZ6/EnHT3LmEeo6Qe
   Y+FMyzsb+K9Dt55rBl5Obom+2XvVBumx8WDZutuPVrS3V89cv9pdadA2L
   2lz2Rh87pYhMvXQ91ztRK4DOb7ua8gQOdEg1fPH5IxbSLTEqLcBt0ZEJ7
   KodysmnDyqMoI1WWYIS3gM5dIS0zl74Btvbm8E+cwl41EcSQ31Q6N92ue
   fwDLEP+ZkdBbV3iAzhesuFYyzgDpsfwbKzm0mSIKYL2G72HckTEZ5+oBt
   kqUmHjBn4+moReW5ilDbj/A8PnoQ6CcYXWiOJdQOs8goxkxqL1tfbVPdb
   Q==;
X-CSE-ConnectionGUID: aZlOhRtTTXOilDj5AfqPqw==
X-CSE-MsgGUID: zJSKgE12QY2DgI63J0mlqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94445153"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94445153"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:30:12 -0700
X-CSE-ConnectionGUID: 00mTUsK2RL6bShJrhmr1gA==
X-CSE-MsgGUID: d5Zqr4GDTkK6OTwTQI2bRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="313787502"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:30:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 17:30:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 17:30:08 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.21) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 17:30:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INAkN/X5cjHYxXa/tspjd9esr/CjLJBYirQ4hwFdv4CynajmYqEhliFb1EAmdzdxMXsqjukWw4I5+po9Zdfmu4bhHEBCtn7gu7n+XB5TyJw4Ebv1ydurJGGuAEDmksHsAKUGHRYHbg5uNvoPA3nsmoGMn0E+1dKA68jkk8xqerXsGxMCxuMIVXA8/afwOWDoawgmtJhVbkZfySMcEB4G2pz0gQQwCwTHAqNLK4r5HUpD9mOIBeYI0+7h6CaO0y1MRnw3F2yZgkQZkmjCCLGCF9mZlHmTadFeDvwNAiHvMwoIz9qZv5GQ7yG2p//eoDbMgG69gCijvQjOHMBqpY2T2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45Zrj0HsDlJZt9KQ4rQYr0EeI6XjnHI7kzVuM1wT7Jc=;
 b=lHbXEkAlS2q72Bt/cA27NvhYdRYgFK4mJZZFX572DKp8g6GHt2mCDIeSU0hAA9tDYcx4nBY6L753DQ5T/cmq1ayjKCZD1dQ+upuEuhWEW6zKulmioYT7To2L46CyWfawZARPgQNXHwD/wr5OMKhk9aCsHZQ1sAKWsRXW00w6KHnGMdPCYJQNhtZv0wMQ6BfrBJjI0NcrTLn+oZSnRz4zWmMGX/hGwt2F7oVct8X+ISrec5pel7I8a3f4rZ6LSV1c4GJ1AgAJgkNsEaEknvnO0A2Nf8aSUL3bmwz35svhKLzd/ZnD76FLFA6HUhsUOuPYT8/PKn0+gC/urvVouYdaOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 00:30:05 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 00:30:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 09/10] x86/virt/tdx: Use early returns in
 get_tdx_sys_info()
Thread-Topic: [PATCH v3 09/10] x86/virt/tdx: Use early returns in
 get_tdx_sys_info()
Thread-Index: AQHdUJ5RmbLuJeujdEWJmRpwiagKdbbn1sQA
Date: Thu, 1 Oct 2026 00:30:05 +0000
Message-ID: <e23181da9391a4e07437da8ef5a88420f2a3279a.camel@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
	 <20260930053901.22528-10-chao.gao@intel.com>
In-Reply-To: <20260930053901.22528-10-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB6736:EE_
x-ms-office365-filtering-correlation-id: b251f2ee-c3e4-46ac-201b-08df1f5323d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: tz4pXuCT7FKR6s0JU/MwRy8HjUkk3TGNT9MTzc2kg6ZkVTVFutluedNlz+6noHVwS3wv8XHGNg263T/eDtR603uSNDsPGAOHHNAmfkPibDM5hSES3Cf5cOJf77Sa7byMw70hl3fPVl/bx7Hv39xMPInzHOuQgiiwiAsYYBibJa4EvyhQSSTtCxS23esgwAObIMoTWGNgOHhEy3Zn3o6BZLOKNbFr1cmoFua9QevBw5crreLBC8WxQqYAvKmuw9yCgI2KG98KE2ilmTgTL9NpLSK2imOrojC/Ib9BFRTdSQbTUqpAgsX8QSY7z8e2p4WIpzBp/NrQj7NWeUu9xPTsW83+rGPh1MgLY2NI5HM4C6hD0biI3Tc3HExMgj8DYwkfH6362TAL8esdRpSlPbkmQXrJYJCsTLkSxMaWHY2KTdPYlGnH3Pm90d87JFLIdizCNQuH26tt6BXJFBrX2X4w3zJqNiQOIGJ672dWTxRvYCoIfrSsvoJHU0hjLgUfy+NFNbu2npbJBG/ZtqwzI1YaOXubT/L3q+6UlZnEk8jtq+CDwlZT08IfrpgJdlXa8lvKXE/U2OhFrL220iHB1NXF0uZ34/UpIiTDSt0n1CpqV5138+3oVUqMzv0IcZhvjXH/igfEjgST+0M/JfZ2oUWQHLVEMwxotySRP+2Kz+cnN8cKaKGb7bKWB1YRkO++iskYKVbi/Qbj2vC4jl9w3/13f/kH/NHh+6tWy+Lo5viatnM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmdXK3crQkduVS9BbFl6T3ZqcnpLTE1KYnExNzZSckxYUGtONmI0MTdld3dM?=
 =?utf-8?B?TFRBVWZ2UFJHaHVXMlBxcDhQRFlJVFhvNkV2WmFEcTZGaXR5cUZrcFZBTGdG?=
 =?utf-8?B?czEzbEpvaDNLMkVlL3R0Qi9HZ2E3MU1lUzgrNHRFQjVvWlNuRFRzSjNnbk16?=
 =?utf-8?B?ci92UlhPVkIrYmcyZEpORGw0TTFNRWxNUkNLZ0xlRzFETCtGUzF1RExpZlRx?=
 =?utf-8?B?b0FJcmtHTWxhU3Excnd4WFFPVzN4cEo1aXlYbTJPaGl4QjNqeUFPbGVZWWZ1?=
 =?utf-8?B?ZEE2WEpSa04xMkhZOURrek1ndzdZZUtoSGRkbkxBakpqbjRnSE9HYVV4aFYv?=
 =?utf-8?B?RnRBNFR6M25FbS8xNDZIRWtvOGJGRmhDNUZIYjZCc0RESHlKOUpCUHpVNkZV?=
 =?utf-8?B?c2wwUXJJM21OemxFWmdIWEZyVDhFM3FET2NNQm51b0plVE9ZRCtQamF1dnV6?=
 =?utf-8?B?K1M1QUtLbDZmZGVkQjhGOE11UGJML1R4ZThtdTNGT3AzeFp4T2lVdmU3amRW?=
 =?utf-8?B?ZlVkaVk1KzlBVXcvUWViUk9kY1JGNCs5MTYwUzdqTUdsaUxBZ3pmN2FUNmsv?=
 =?utf-8?B?T3ZEcHNScHgxTlFySGpVaGlGTkFsc3JrL1ZmQ2NBVnJvT1Rhb2FLemdhNVBs?=
 =?utf-8?B?ZlFTa3dKY3VpbzJPaXpFeVI5WXZCYUlMTVd6a2JtSU9XdU5NQXJMVG9haGxM?=
 =?utf-8?B?cjNEVU0wNENOSkFKeGYvelVqVjBRTW8zODJGeDV0cDdpUUlxWWcrelNrNzlv?=
 =?utf-8?B?ZllKVjVTdmdLUzhUbkhaM3ZvZFgvalVRVXE1QzQ5WW1iQ1lmOTFKZU1PQ0Ix?=
 =?utf-8?B?SGtndE95WWQ3NGI0ZXZuSXNxcDZZVTdMWXpwTHBrYnk5b1krSTVYa2t6Vm43?=
 =?utf-8?B?ckI1UGtzYzBKUXNub3c0MU82MzF4RjhFZytpZzhrK0VpV1dmQ1JTa2FyS0Nv?=
 =?utf-8?B?R2RGQjR6aTk1YlFoMmVDZXJ5WStyWEk0T1ZMRVV5UEE2VFJoL1FIRWRFa1Ix?=
 =?utf-8?B?Y3VMekhwQWNldTBPOUlESVRLUStMMGdzTVV4L1cyR2t3RWlCbDh1bWQ3V215?=
 =?utf-8?B?QUVTOWdXRFJaRm5qbWRvUVVJcklyOEIyTmxnelgvUU4xenh6SWRQOWttTDlR?=
 =?utf-8?B?UjFEU1R5UFk5RTBhUVBvWVU3UzhDc2p0OHBkU2lub3kvc2w1TVpTdldPeksx?=
 =?utf-8?B?MXdsRTQ5amlubVdHZ0VCWGptQVI2bGlhTWlHV0llaWYrVHNJSFlZNkRUL3cr?=
 =?utf-8?B?SWI1QmE2YXlzUjFLN0REQWt4L2RsMnM0WG9laHFXRkJrU3laK0w5UHo2blVw?=
 =?utf-8?B?UXVaQVZOSWFuWWlRamwwL3RyelNiWnlITnBHalVTT09nN1dyR1h4YXBuWlRJ?=
 =?utf-8?B?WktFU2dNRUY5VCs3UEE4L2lBaktyY1dJREV4UUFnNWpndUxHN0I5RExyNFpK?=
 =?utf-8?B?WkJyb1FnS1pSVDZGYVhSemhNcFNhOFZpNkNOY21UeDRONGZRb0pLM3MveDg3?=
 =?utf-8?B?YzRpRGZDRE8zbmZDSUt3VTdTandlOWlSTEJWbmpqbnRjd1MvLzh1TklHQ1Nr?=
 =?utf-8?B?NmJRekkySXlnZlV3dUpuODBVbGF1bFVYRkpiSW9jS1U4bStjRG5Gd1hLRWxY?=
 =?utf-8?B?N0pBOVNnWUoxTmVsczFMdkR4blkyblpQMVJhNWdHRFBDN25LNzJTREt3VlI4?=
 =?utf-8?B?WExjZStWWTVuOVI5eGVSKzIraVJpSWc1bm1JaUxNWU8rbEc4ZkN2Vzc1d3lF?=
 =?utf-8?B?L2l1ZFZua3hmWVZZZVZ6ZFBmUVA3aGY3S0poaC80RjAzOVJsTms0S3FOQVgy?=
 =?utf-8?B?NWtPU2hZZ0c1Mmx0TXV4ZmdEZFlHQllQWEREZkVhaGFnK3p3cmFTSXhQMDZL?=
 =?utf-8?B?bHNKUGN2ZE9QZGRjdWd2bjhicnBqV3ZsMnEwQ0xJbkN4TjVuYXYvMDh6Umdu?=
 =?utf-8?B?YzErQ0FmUDNEUlJ1OFVTQmljTk5Db0R0dVVab2o2bmxmSUdGUjRFbTBNdlVV?=
 =?utf-8?B?T3QyRWFTVHdDWXpwNXlpc2ErSDN4V1lrNkg5bFJKZ2FFZTd1emRVU3hSU2Nk?=
 =?utf-8?B?MlUrNUdsdzl3K2xQbHgyZThOWmFwZVBnWDBTNHoyeXNZcUxZeVFjQmFmNk5r?=
 =?utf-8?B?VXl2SjAyd2ZhUEtCQjFqUHpBRjFzM3UwWU1ZL3c4ZEIzRHlzOThudDdMQ1Jk?=
 =?utf-8?B?WGRqNUZ4cHp6bFVXalM2NFVVT3M1VVJwQWc0OFo4elBtVHg4NGgyU3QyKzl2?=
 =?utf-8?B?TkFDOW51K3dVRzhwTGQxdEVSZzFHZ0lvemFIbGJrQ2NaTEZKbGR6UFJ3STFa?=
 =?utf-8?B?QjlXUTFVTlpWaWhKemJjS2d0bXg2dGwvZjZzVVg3RmdBTWllNitQMUpldjQ5?=
 =?utf-8?Q?U4mGzQToVeOZuSrI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A21FF81391E4A644AEDE949676916855@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LUs+ZnqdH1ZG6XRS3N5YGCYutzrLWA0CR8hRyHJPixV4FZsrX9PhnM9OPznExMTK+PFr6hFhBxv5KVpXfNt5DtA0lo/cfXL+v4pREkr5sB/+myxoEdUXQrql6i9XyDcf/jWUwL4RG10N2PPS1Uu4leJr/CoXZ27oqYZlCLu6cM7WHqHCUkwNMrytBA520VLTk1ynelB2XI6fgcXAKhEBslwUW7PVqZXBBXAmzQrz/S1L8DjKvXzXpeV63e6DJa1/gVyy+gM+YwYVpdQT3SrSbhfahCR10pELXILrE/HoRFjv80A0Z/0wM9QzS0PgHJsBEzBUx6ikfBfZ0oFwzWn21A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b251f2ee-c3e4-46ac-201b-08df1f5323d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 00:30:05.3099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbOrgBsmk7L/he1dw5KTh9mmYmEOdSpDRkz+7j/7zTOMYwGWtI/o9hDUT0ExkPWy62FplqET9Ltfc9aRcVJzOp89J0CeSinhO9d2mujYmUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDIyOjM4IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gZ2V0
X3RkeF9zeXNfaW5mbygpIHdhcyBnZW5lcmF0ZWQgYnkgYSBzY3JpcHQuIEl0IGNoYWlucyBpdHMg
bWV0YWRhdGEgcmVhZHMNCj4gd2l0aDoNCj4gDQo+IMKgwqDCoMKgwqAgcmV0ID0gcmV0ID86IGdl
dF90ZHhfc3lzX2luZm9fZm9vKC4uLik7DQo+IA0KPiBUaGUgZnVuY3Rpb24gaXMgbWFpbnRhaW5l
ZCBieSBoYW5kIG5vdy4gVXNlIGNvbnZlbnRpb25hbCBlYXJseSByZXR1cm5zDQo+IGluc3RlYWQu
DQo+IA0KPiBQcmludCB0aGUgbW9kdWxlIHZlcnNpb24gb25seSBhZnRlciBpdHMgbWV0YWRhdGEg
aGFzIGJlZW4gcmVhZA0KPiBzdWNjZXNzZnVsbHkuIFRoZSAicmV0ID86IiBjaGFpbiBoYWQgbm8g
ZWFybHkgZXhpdCwgc28gdGhlIHByX2luZm8oKQ0KPiBiZXR3ZWVuIHRoZSByZWFkcyByYW4gZXZl
biB3aGVuIHRoZSB2ZXJzaW9uIHJlYWQgaXRzZWxmIGZhaWxlZCwgcHJpbnRpbmcgYQ0KPiBwYXJ0
aWFsbHkgcmVhZCBvciBhbGwtemVybyB2ZXJzaW9uLiBUaGF0IGlzbid0IGNvbnNpZGVyZWQgYSBi
aWcgcHJvYmxlbSwNCj4gYnV0IGVhcmx5IHJldHVybnMgbWFrZSBpdCBlYXN5IHRvIGF2b2lkLg0K
DQpOaXQ6IFRoZSByZWFzb24gaXQgaXMgZ29vZCB0byBjaGFuZ2UgaXQgaW4gdGhpcyBwYXRjaCBp
cyBiZWNhdXNlIG5vdCBkb2luZyB0aGUNCmVhcmx5IGV4aXQgbG9va3MgdmVyeSBvYnZpb3VzbHkg
d3Jvbmcgbm93LCB3aGVyZSBpdCBkaWRuJ3QgYmVmb3JlLg0KDQo+IA0KPiBBSSB3YXMgdXNlZCB1
bmRlciBzdXBlcnZpc2lvbiB0byByZXZpZXcgY29kZSBhbmQgd29ya3Nob3AgbG9ncy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IENoYW8gR2FvIDxjaGFvLmdhb0BpbnRlbC5jb20+DQo+IC0tLQ0KPiB2
MzoNCj4gwqAtIFByaW50IHRoZSBtb2R1bGUgdmVyc2lvbiBvbmx5IGFmdGVyIHJlYWRpbmcgaXRz
IG1ldGFkYXRhIHN1Y2NlZWRzIFtSaWNrXQ0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUg
PHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0K
