Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E56A31AF1B;
	Thu, 28 May 2026 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003035; cv=fail; b=OLccdFlTTqD7joY5taRTT2jE5yBN+sZcIHOBAc0wCX+mt9wbO7ei597BGQEb6iw/9/QztMOK+S2ruv3lBnyxx7ZtJM/mkw45m/+8faUcFG5jwkEkpDO1+Pjth/oRY5BOqrep15K5DcI8Kc11yQN7HIPl5nvu1rJasuwGCHxRk+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003035; c=relaxed/simple;
	bh=SVnFWVlVHRQa1TE1QrOqk6NNqFsT+xEI/Ic2ozymwps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DR20a+SMxFQbBmb4Kw5xEaIim391u4hR3xeTSOuDqHNHzlJA5O7JXJQKlzZje64xTKinwqagmMBnBdGMSgeLdUmMEWm3Lig/vHufJm4Row0hb5rguJgaTGeOFySI+xxsHyQHWATAAYjajqWprD4V5vHYm6amz7wk/gmQrMlEdRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCEAkIPl; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCEAkIPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780003034; x=1811539034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SVnFWVlVHRQa1TE1QrOqk6NNqFsT+xEI/Ic2ozymwps=;
  b=fCEAkIPlmt49jUzYJMaTVGRyTdkr6RahTqZ22H2U8Jyvi1lAdoLtUeue
   q4ly6x4MseiIs7tMzG0ksEPgzWL8iBFqeY4pIFb0AycM41N1L23+SC4k6
   G48uAtzZsSS681GWZJtFJpfQkGG0tAVklwWQ8J4eEAAeKU/JxCGjIbqJm
   xpLimB+9xHEpcfPHb7RG/pGY0o8IEKg5zzK4qYQFDVvU61gbW/8nFO2BM
   xVD41xbCasXCAagG5RAiY7WqFO1Aaho6dQDYH396yQE864Ex+fSiZJ3o2
   PboclG6L0LKDZf9jOChZyLsFOpOmnMoa8A7JjvtXKv3ISESmzBohdETGN
   Q==;
X-CSE-ConnectionGUID: 8iM0fVv6Sn+CjfBzQXW9Hw==
X-CSE-MsgGUID: /gZCH57+S2SsLo4G1oSNzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="84480638"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="84480638"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 14:17:13 -0700
X-CSE-ConnectionGUID: oROq65KESNyIjQ7vAhftDw==
X-CSE-MsgGUID: 5xH3dzL1RhiOhoBad1djew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="246672890"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 14:17:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 14:17:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 14:17:12 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 14:17:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCZT9XdEg1b24HzpqhdBv1Eq8pgSieEQm6T0sehLeEfCZ7HKfVlDEiWf6pz7yDfKd41ZxXs5cVADPMYW0g+yPilcoze3sh4pCwi+AuxwQB1oxAhAemfb+zGosIYqI/+a36+imnx7RgiqBz6OBguMTk/RH/JU63QJ4WsqFi4amLHVBaO9wyuhRjFASfvr7FphS16iAzcdTCy8o4FrXamggJUIpvsv+4vz2S/gsWWFKd8zgyT3yKGdA8Q8I3k+BO0nIUyX6n/5pSkNfgJiX118xZ5Qrh/7E61quEKQdCroVqTq2/R5/990XfRb5gdoTeoMqXOHAZ4UBvHiWhfKCjsCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVnFWVlVHRQa1TE1QrOqk6NNqFsT+xEI/Ic2ozymwps=;
 b=dxQsChJq/t5mDzeJgC4EyXK1pjFpcScSKREVMP4w44HZ4ri/seDAqMydhcz6p5GzHdGsCfoxvKeg4wuDRkk65hvLr3ZgZ0YoLqr+1m06eOIgNspqP5HWOoZ8zHEJz4m+yjVe24ONtqng/HVhCLoqXFWX28ly33J1Piw/Ns3uPyyOqnwxl6Zs9Nwq/XLKZTsDd+W7Zfiea+f9MGlu2I6/K5sDquyrBa4Jgpvim0VDbjE7wYxEyO2wLk8zIV17p4hDQ59p0i5uwvS/qQSELjBgPs000aCt9Cebxu361kbDJqEWqLfD7mQFVpxqADGikitNlOLeM4ch/KcAkw5GKuZ4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY8PR11MB7105.namprd11.prod.outlook.com (2603:10b6:930:53::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 21:17:04 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 21:17:04 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "djbw@kernel.org" <djbw@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Fang, Peter"
	<peter.fang@intel.com>
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
Thread-Topic: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
Thread-Index: AQHc6aA9T+sLFts0xU6ca4lQ9VIhqbYeU3YAgAO2NgCAANc7AIABGoCA
Date: Thu, 28 May 2026 21:17:04 +0000
Message-ID: <5b2df6c780a0245cfc2ab4beb84883aba384e9f3.camel@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
	 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
	 <956fa1e6-2920-4b2e-8037-d4b9d812ae53@intel.com>
	 <ahcDvwEES7vqLLvg@thinkstation> <ahfD1KMYnTrXJziq@yilunxu-OptiPlex-7050>
In-Reply-To: <ahfD1KMYnTrXJziq@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY8PR11MB7105:EE_
x-ms-office365-filtering-correlation-id: 48d4933e-b67e-45ba-cda4-08debcfe776e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 1ugadRp/qJSsc2R4F6JVB/7KAXuLKgB1vDGG3pkLA0XM+ZdEU9P7UOsqDoCX+Vgl8Ubns37/u75qkVC3QStxsP58UrLdiO8PhFMpwFm6Jmwbz+yfd4yiW4JdB69Xvhhp1H50hHnQoBE9WVW6gBDFc2eD2M5A39ffTRn0/4B5v1QvDFpH7DnNo0aSA/9V3dATBOh/qJOv0WI9pO+/CI7vTT476cGj+cpd28g76prZXTeBXbosPEshxzPqH7LCtTJh218PyVgUABB159Xu3ympvDJ4/Nl7QP899sgiaitD0iHqehh9k2fU/ssTvOXJIwYReQeGDKE02JLQL5dXXeR3g1q+D7eFfm7xDWBYpNLfOkpWOMLFLSTh4eFw/Kmhuj3lgnj3Hn6EQnsvqxL+60lLSz4wh9goE5/O9bdoHK9NUPm8353UmYCgCiKrSgCZZAICB43mJijFMlnkMweFR3Zs0LlB7xKsWZc8Pitum+90WCNgyQBSEcHLVmZmU4cNa3etECowNfrtrsK3F+Ke03l2Gn4h4L9lqGs+9gZOicgsk4M0KXZmZNpxfdxbHwKKT2maTwlBQS7IrgjAuksufvSESIqZEBLv1nnyGSgzJiZDMnt7XO2Ot1NEDj1a0BBRRKT9WufRYuPAbl3kEeN3r4FZTwjLeWsYhR118wnEI76t3/bu+bucVvhU5Xd2jCAnUDwHGfMkqL23U3E8fDRSFIKhkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amZCaTQzY0ZqSmYyV3R0OUVWRlAzVk4vVzVLQktpbXJsL1RwVm9tYzBqN1Vn?=
 =?utf-8?B?Vjh3NnZvZDdpckFvRlhYRVovRUFLSmZBVHFmNWhId1VqbXQ3cGVzdG5JeEVP?=
 =?utf-8?B?Wm90emY0OUMvQ0tUeEEwSVRVL0w4N2VQQTdiL2hSczBBVmFnZ2p5dHdIMjN1?=
 =?utf-8?B?K0g2dW43RjJsSWtNK0pjVkFkUkJscWZEenNVZEhzeWpMWTJ5dVhpT3U1VTNH?=
 =?utf-8?B?aDMwOU5OQ3JPMG8ySnlxVkZndHcyeHc4ZXpoY1VpLzdvZUVNNEdpd2xUam9i?=
 =?utf-8?B?dXE5dVJLNnhkS0hDQ205YUM2bzkwT1lqYTZNOGpnL1dFeDlIL3dzMERzMEhB?=
 =?utf-8?B?N3AyNzZZSU1wZThmQy9SRzh1L0dIbUxKTDkxUzF4cEZpTnJXTHVCQVE0My8x?=
 =?utf-8?B?RWgwWDlDOXhHQXJFUGhETE53NndBS1ZRV05RNVMvb3k4RG5TUWw2cDljTzY0?=
 =?utf-8?B?MDNPV2dDMmdLQTUrU1lJdExpWlJIWHcySHROQVZUY3cxU3EySXlYUlR5Tzg4?=
 =?utf-8?B?YkRMMjZoaVVQc0xyRFRJbVBnbnNTKzdqSFUvT3cyZnlzOEZtak9zMlJCY2Nh?=
 =?utf-8?B?NWdYaE41ZWhrRVhZZEQvZi9hRkZQQkhjeXIrdTgrdDBDQTJGa2JZQWx0aDlU?=
 =?utf-8?B?RVE0dWhRc3lzbTRGaUtLejF5blo3ZUlBdnlrSkcrN2V2QXIrcjlYT2IwQ25P?=
 =?utf-8?B?VldlMU0zTWc1a0dycjNRR3h6ZFpaeUJRNWRvQ2U5N051blRYenBTSHJLdERy?=
 =?utf-8?B?VEZheWQrTnJTRDBXL1BEY3NiUWt2djdiTzY0YlQ4NWhjbklULzJxSCtCQ3Ra?=
 =?utf-8?B?OWZaZXdLT2VGd2R6eExWdGVhdGlEWXBYZU5qL0RVc3YvU0hhQWM4am5leW53?=
 =?utf-8?B?VmdkTzhETkFmVU0vbkIzYlJVMmZ6MnNsUGcyaEUwVzNKVzdWQ2FPQlQ3VFE3?=
 =?utf-8?B?NHVId29TTm5la2FIeW5ITDZJMi96OWdoWTAwc1lFVXk3OGI0YmtjK1VyNUxp?=
 =?utf-8?B?RFoycWxzZWU2OGpPbVoxZENOQlVJT2NHbXl6TUJDUFhOUDl3aG5CdkgrY1Y5?=
 =?utf-8?B?ZDRUZjRQQXEwODN6WTVWWmdBRHpDVjJxbmZyVlZLZnZ4R1BFTEdhTGUyK1pa?=
 =?utf-8?B?WlF5NUxLTDh4dDVYY3hBMDdNSmdkSllVS0JMVFdyWnp1RTNSY0dieU1iZHox?=
 =?utf-8?B?Y09CbExVWGQ2cS9kem9nN2o2YXNrNElYM0IrOTB2cVNlRmdsTTNmYjgxT0ZG?=
 =?utf-8?B?TjFZRWRQa2k2WWZxWldlSUl1NkJBSWxKdmNyeGh2eE16aW5pN2FXT1A4emJX?=
 =?utf-8?B?T2hoYkhqbE1EQlhPcklEWDFLWXNjcitWNitGT2xRcEdzeUFtakZNUytwYVNR?=
 =?utf-8?B?QXdONXJMdUQvWWN5akZjU1ZoYThWM2pYa1NJNXBpZmg4ekk2NzJ2ZHRiTGxB?=
 =?utf-8?B?VzcrcnhFYzJhY2dlK29qV1J6M1cyM3pHS3F1akUveXdybW1FZEpvTFpjT3Fw?=
 =?utf-8?B?aXNqUVkwN0FPRERhWnZ1VWUvVUMza0FjZFFKUGp4dEx5TnI1bm9WcE5GTDNI?=
 =?utf-8?B?L3VuUExsVzZNemNLL3dwby9ucmpSMHJpWS9TMVZ4cVc5TSszT2tIZTh0Wm9M?=
 =?utf-8?B?Ui9PZjZ5Ly83dCt3NHZiTUdONndFa1hNM0FITkFqUENKU0N2aytaZy9SVERi?=
 =?utf-8?B?QXN0T3prRjlHRFdtd015OHZSL1VQYnRVZ2YxUUlPa1FGdkp2Qk1QWkp6eHFq?=
 =?utf-8?B?VkpNM2IyOGxaVmk3OWlkVjRZY3R5THEyMXUyREJYSlR6NGlPQXlsMSt3ZXdm?=
 =?utf-8?B?bmJiellxMnNIMlpJL0o4emdiTi8yL2dTcmZoWForUW1mL1JsTzc3NW5HMzlo?=
 =?utf-8?B?NjFlL0NCckp3eFdBektaZzVLelBBZEZ2b2pjKzlvYmVJYWk1RXowdFlheHZI?=
 =?utf-8?B?Y213aEpPeTZYREIxQ3dheUNVSjIvNWlUUGtIVlZHTEllaEpaZW11aW1VeTFt?=
 =?utf-8?B?bndURHlFSEoycXZnVDNwVHlWQjdRY3JNRzFaWFpnblNVWTg2MVYvV2IzaDhS?=
 =?utf-8?B?N05FNU9ieU5OUENOVi94OUtDZWNIbEJXZlBhaU9oZURpdlF4NStWU2l6cHNR?=
 =?utf-8?B?MmNCYmVJaFU1NHJ2V2M1V2dxaktockVXeGlLREpaRERXaGw4bVFhbU5tOU1o?=
 =?utf-8?B?TE81OWpWbWJ0V0FhaEsvbUQ5Umgza2M5UGFQNy9wL0h3M3VXMUw0ZzVrNGtZ?=
 =?utf-8?B?YlVrbmsxc2F3WnFTaE9SRGk5cVJ0OURmWWVTV2pCRUs2cjlYUHRKZGFOWE4y?=
 =?utf-8?B?bEJpN2dRTWM0ZkhvNWV5VGNUcmpxYzlia1YwMkdTU2srRndkZkgzdzFLQm1X?=
 =?utf-8?Q?+szc0oGBsOqk+cRI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0352AD2FD64B7D4091F6A1B7B1F0F3F1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n/IGfRvXzlmBVYDOkPr+6zMBoKTAfYom+nsg9ajTuzS0aUiHwDH2Re3vUeOd1YEc7nxMuJ8Sw63c/VoTF1X5BNre0cShTiuhNbZf18/50uPPQ7Cq7xi3xxiFLkN+fQ0ZpOOx5mp2/QW2NWJgpLyewNYGjkbcsslUwKAHa9vUg6+fTs5PAC+ES89+M6GxScaq5h3rxTBvqIH8fY7zXgw1AOmT8Pk3VtxjzC/fMLjEPAR9J9Mec6t+Tcpcj8AOW0QBniT6TXCKE6eivH3/pC3UmWVYq0HjJhXkzRqdDH5GDaF2E7p0X3RDqXg7p1liwn8cnbw4wK9u4mgFJZGQDMvnBA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d4933e-b67e-45ba-cda4-08debcfe776e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 21:17:04.4210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppOYs7baAN7a/RtvO0qr9aZbezJ5UeYAfM3kyz59Y2KJSHowKp+fLXwU1ebe9ycYGJPRZEZWlfwogungLa3ZtPdtYAPloMpOQsaWEFyLP7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7105
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDEyOjI1ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gPiA+
IA0KPiA+ID4gSWYgSSByZWFkIHRoZSBURFggbW9kdWxlIGJhc2Ugc3BlYyBjb3JyZWN0bHksIHRo
ZSBhbW91bnQgb2YgbWVtb3J5IGZvcg0KPiA+ID4gZXh0ZW5zaW9ucyBhbmQgRVhUX1JFUVVJUkVE
IGZpZWxkIGRlcGVuZHMgb24gdGhlIGVuYWJsZWQgZmVhdHVyZXMsIHdoaWNoDQo+ID4gPiBpcw0K
PiA+ID4gZGV0ZXJtaW5lZCBieSBUREguU1lTLkNPTkZJRy9UREguU1lTLlVQREFURSA/DQo+IA0K
PiBZZXMuDQo+IA0KPiA+IA0KPiA+IFRoaXMgaXMgbXkgcmVhZCB0b28uIExvb2tzIGxpa2Ugd2Ug
bmVlZCBhIHNlcGFyYXRlIHN0ZXAgYWZ0ZXINCj4gPiBjb25maWdfdGR4X21vZHVsZSgpIHRvIHJl
YWRvdXQgY29uZmlnLWRlcGVuZGF0YW50IG1ldGFkYXRhLg0KPiANCj4gDQo+IFRoZSB0aW1pbmcg
Zm9yIHdoZW4gbWV0YWRhdGEgYmVjb21lcyB2YWxpZCBpcyBub3cgdmFyaWFibGUsIGUuZy4sIHRo
ZQ0KPiBURFggUVVPVElORyBtZXRhZGF0YSBpcyBvbmx5IHZhbGlkIGFmdGVyIFRESC5RVU9URS5J
TklUIFsxXS4NCj4gDQo+IEJhc2VkIG9uIHJlY2VudCBkaXNjdXNzaW9uLCBJIHRoaW5rIHdlIHNo
b3VsZCBpbnRyb2R1Y2UgcnVudGltZSBtZXRhZGF0YQ0KPiByZWFkaW5nIGludGVyZmFjZXMgZm9y
IHNwZWNpZmljIG1ldGFkYXRhIHNldHMgYXMgbmVlZGVkLCByYXRoZXIgdGhhbg0KPiBhbm90aGVy
IGNhdGNoLWFsbCBzdGVwIHJpZ2h0IGFmdGVyIGNvbmZpZ190ZHhfbW9kdWxlKCkuIFNlZSBbMl0g
Zm9yIHRoZQ0KPiBwcm9wb3NlZCBhcHByb2FjaCBmb3IgRXh0ZW5zaW9ucyBtZXRhZGF0YS4NCj4g
DQo+IFsxXToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNTIyMDM0MTI4LjMx
NDQzNTQtNy15aWx1bi54dUBsaW51eC5pbnRlbC5jb20vDQo+IFsyXTogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsL2FoWEFMNDFabUlESG1nZnVAeWlsdW54dS1PcHRpUGxleC03MDUwLw0KDQpZ
ZWEgSXQgaXMgZ29pbmcgdG8gZ2V0IGNvbmZ1c2luZyBhcyB0byB3aGljaCBtZXRhZGF0YSBpcyBw
b3B1bGF0ZWQgYXQgd2hpY2gNCnN0ZXAuIEFuZMKgaWYgYW55dGhpbmcgdXBkYXRlcyBpdC4NCg0K
SSdtIG5vdCBzdXJlIHdlIG5lZWQgdG8gaGF2ZSBhbGwgdGhlIG1ldGFkYXRhIHN0b3JlZCBwZXJt
YW5lbnRseS4gU29tZSBvZiB0aGUNCm1ldGFkYXRhIGlzIG5lZWRlZCBmb3IgS1ZNIGFuZCBzb21l
ZGF5IFRTTS4gQnV0IGEgbG90IG9mIGl0IGlzIG9uZXRpbWUgaW50ZXJuYWwNCnVzZS4gVGhlcmUg
aXMgc29tZSBoYW5kaW5lc3MgaW4gcmVmZXJyaW5nIHRvIGEgZ2xvYmFsIHZhciwgYnV0IGFsc28g
dGhvc2UNCnJlZmVyZW5jZSBhZGQgY29uZnVzaW9uIGFzIHRvIHdoZW4gaXQgZ290IHBvcHVsYXRl
ZC4NCg0KV2Ugb25seSB1c2UgZXh0X3JlcXVpcmVkLCBtYXhfcXVvdGVfc2l6ZSBhbmQgbWVtb3J5
X3Bvb2xfcmVxdWlyZWRfcGFnZXMgZWFjaA0Kb25jZS4gU28gd2h5IG5vdCBqdXN0IHJlYWQgdGhl
bSB0byB0aGUgc3RhY2sgYW5kIGxlYXZlIHRoZW0gb3V0IG9mIHN0cnVjdA0KdGR4X3N5c19pbmZv
PyBNYWtpbmcgaXQgc28gdGhlcmUgaXMgbm90IGNvbmZ1c2lvbiBvZiB3aGVuIGl0IHdhcyByZWFk
LiBBbmQgYWxzbw0Kc2F2aW5nIGEgZ2xvYmFsIHZhciB0aGF0IGlzIG5ldmVyIHVzZWQgYWdhaW4g
aXMgYSBiaXQgd3JvbmcuDQoNCkhvdyBhYm91dCBmb3Igc3RydWN0IHRkeF9zeXNfaW5mb19leHQg
cmVhZCBpdCB0byB0aGUgc3RhY2sgaW4gaW5pdF90ZHhfZXh0KCkgYW5kDQpwYXNzIGl0IGludG8g
aW5pdF90ZHhfZXh0X2ZlYXR1cmVzKCkuIEZvciBtYXhfcXVvdGVfc2l6ZSByZWFkIGl0IHdoZXJl
IGl0IGlzDQphbHJlYWR5IHJlYWQsIGJ1dCBub3QgaW50byB0aGUgZ2xvYmFsIHN0cnVjdC4NCg0K
RG8geW91IHNlZSBhIHByb2JsZW0/DQo=
