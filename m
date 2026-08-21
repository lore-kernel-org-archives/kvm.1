Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9901A41A55C;
	Fri, 21 Aug 2026 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787356534; cv=fail; b=XTopj69WuuSZHBE0WR7zsZ4WdopNAXokmN43Nx1Un5Wdbkuoha7eaiE3qYCRNHZhJV9FRFAYppo9rbcW8cYGveDPfSlnRbFo2dniSRgA1eLC8qP+Zo1Zia/XCHliB4nP96abofLzF7WyeFvKr5OE/gtTkvH3pK5qkbGLi/FJ1B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787356534; c=relaxed/simple;
	bh=/MJ2hWwp5dRpfWhIMYMSaCs58Gt8SO5KsqwkArT8lDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kRTgG7eFP72jU76UJ0nMbSlt3lQHeq4/AqR6AazdFFwQo1p6RLk8H+49pB2fG8npFB1BbA2C1uRTUssXQFyNH/pfKuZjTsffvJ1luXcRXObLc8rYx2TsiU+SWqtU3p5B6E5uKRjP6rJHOEdyyna/+QMotoStjHZUvPnF0lek54A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCRGrX39; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCRGrX39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787356532; x=1818892532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/MJ2hWwp5dRpfWhIMYMSaCs58Gt8SO5KsqwkArT8lDU=;
  b=BCRGrX39dq7axKIJFqT4GHzwP+Js2cU8/Uz4SbBvwT4Mkn0eKZZKRMNS
   NCDeirRKs4OvdfgSFUqHsXp6W0+AsHgtJqRPdpclCD0ms0ClR1n/Qs6B8
   oDKlDk90tIX1GPIQDUlEIB+Vj+ucIIhYo5RRBUxCKrYMLeUNavL8me/wL
   aJm7g/U/wekwd3Kh4kWqMTWPJ2wGy/d2orWvZeh1eow1IHIWji2IN2VeS
   mllZdumEIJmNxQs/BwUv3ItHgPSk6nCc/3On1FbxV/I0vWoc4/12buMrb
   JVb7IlYkoO1s1CuJAjYQC6DloveiPXe6tqS6Kp5X60r9brRQWkv25v3bV
   A==;
X-CSE-ConnectionGUID: hhP/tj5eSnivIAP+3vmEKw==
X-CSE-MsgGUID: HAM2cQy8RlWOOAdqeFb6Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="75446832"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="75446832"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 16:55:31 -0700
X-CSE-ConnectionGUID: giqvNXBgTd6FH0aki4ruIw==
X-CSE-MsgGUID: XbqtsqtxSf25Lbg0mlHyEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="290006217"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 16:55:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 16:55:24 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 16:55:24 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 16:55:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4UCtiw1fM2qU2CrQYXiVZ6OVlO8hDWWbWuf1KgXguFYwQLBBRR6hArq2gtrtq3HhGb0T96C6vw0MDk/1uZAPoqarDiZvQs58mk9dQfVzpyv3CRUPSJapdQWE/2K9h2LoRK8UhZYKp3yX0UiwUFiJy7hign9NiO7snx77UYPcyc99PJE20DX/Vc36R0C0p81oXRJMQi4+JK1WBEVf2jirl88YLnsQ2WF3/66ZK/5bdktNahqNsa9M6Ot8UBFxpb6fTOE+rIpp0MldzMD0SvnxPBfcjCNXpbtibUCs5KnNOp7o0T4Y86ozhD7nucjOw3cdMYjTT1UbETsNXvT9g+K1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MJ2hWwp5dRpfWhIMYMSaCs58Gt8SO5KsqwkArT8lDU=;
 b=YAfB/QXRYpcX7q2msqUIH4QAug5kboK7Hms23+4Jj5Zohl15WuJQwlZ3Ief2hK0uDCoK/o3KXaF7r2MXbikB+7X382ehwiIDbVpL3+HJt94rUXIE6a0viNtpAS9mvJXEqRPMgc9aPznN92vQKlRKZV0iyh1Ffs38Z3hAtpQ/08TmfcYnLTr4S5zRnASYoAiYa3fanAVTFHVojVsQVqG2meEUmQLlRoDh3kJqHDdkg8PQQKAVR4gXwuVxMT125EA8J/f86K3VpoTj6qt8+8fOg7wExOiHXSGP9YUEzI766IjvYWY/QKDCdijvZD9SDyL5sNhbfpET96oghQQVCWqthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 23:55:22 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 23:55:21 +0000
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
	"Fang, Peter" <peter.fang@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH 5/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Thread-Topic: [PATCH 5/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Thread-Index: AQHdMR1VKsXmvQZJwk6q+Ulq286OyrapLs+A
Date: Fri, 21 Aug 2026 23:55:21 +0000
Message-ID: <f48b83feb2ee1d3c88b5a1627cf35b4b282d3f90.camel@intel.com>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
	 <20260821032920.256225-6-yilun.xu@linux.intel.com>
In-Reply-To: <20260821032920.256225-6-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA2PR11MB4873:EE_
x-ms-office365-filtering-correlation-id: 180bbe0a-d758-48db-00ee-08deffdfa96c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|10067099003|6133799003|22082099003|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: JCuyjWrJA12QcRuuf3t3HkUBksaLZHEybxPkrQ3kEFvEqXpa2AP03nGPyDql2C3BuK5h6QkacaD6LXBxDpFh/gTbhaYRk2abxRn3i2YjKD8ooHmH938NCOCoUXiu4waEfpYrI49vNR5vo6FaUD/sKDBB9vuCBxZx5MXbUN86VkQLanLd/3o2WSWOENZhQLKD2SMm9iOC9MXmu8QYiOwyES4BZvzS3L80fflTQe5dgY9pl9X3WgsGpXA+YtH1eB2Uugx0l1l0BEZb7qTwSf7Ie+l3GmZWfQR7Yjh+Pfkfmq6VvP28kb9ro8uai5d7G1+Q/BMkwWou74xJaqRRCGD6YdmDanXuRoVzQuTtE2GCTB8/4YfXPXdKEXJcEwN9FXpzvqv0Q4pkII0OUkrIr5WWYM3Rl1NV/3lkUWxIev4MXomJYkdsfrSxuDjtZ+LrLGHPY9O3d/stJDnvnT19PrVt31JqX9RrHSDwuaF7yIPlne8XBWKq69ieuC9h2mun0bIjkL7W1TA0zm0O+ecc4rQXeQV6FmrLLyzWVwor+cKPM+aKYkvqlaUgEagaM/gLYrzF2ghz6TjEOGqg65XlVHWrXoDE8ArEnaPMq8hUbZ9nDck+WIoEoCsaz/V2MQPtMeEZaVjHE5say4poKSbCP2hnv7X0mvtS6HFgMDt4cao23dKOYtR2FmdCD1iXy1OEi5T3y3YtWrih+TtMimGY59w8cDeEHo3ZSct7sX5pF3l7HVY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVVJQWcvclcvS1dRK3NrMjRaN0ZMMkh6UExVaEJaTTRCS3AyK01Bc1RmOWNo?=
 =?utf-8?B?MFJ1Y3Z0SEdIYmFiazE1NU5BVkxUeWEyeGVBUGE0bEtiSWhGcHZ4bzJDd3cv?=
 =?utf-8?B?Vm4yQWxnOFNNR09TNXFmQlFZYnJYM09tdlBjR1hYOGZQLzV0N0Jnc0RQUU5W?=
 =?utf-8?B?ZXNrbjVlUDBBWmNMTUJ4ZGl6QUVMTUswUnZhK3o3dk1kT0dzMjY0enlnQXY4?=
 =?utf-8?B?K0doa3hNK0o5ZlpwVnF3dXBybVhadkhyM3lKMG1ObEpRY0tqUTVFWkRkakM1?=
 =?utf-8?B?VFdlaXJ1UzMzVSsraFFDQmlDUERyc1IvVVU4L2ZxMHFBamd3MzdmWjg0SHlP?=
 =?utf-8?B?T1RJQ0QwRzZpdWI3dVVEK2Y5M2MvL0dhN3V6eVhDSk9VZEx4aUNtQzRWM3cz?=
 =?utf-8?B?QTRUTEtDUk5XdkpmN1pRd045OHVwYjJYbW1LanllVWJmMC85WUV0cTBoUXZN?=
 =?utf-8?B?Q2ltVVR3d1ZTWUVUVEJ1SHAzbUZIa1BPSVJiRi9xYlVJbS8yRXNWY3lFb2Ru?=
 =?utf-8?B?TjNDTFJpSitwb2o4RDBsU3EydGJreFowYkdJcGl4UGh0WFF6NWUyeTJ2OFZq?=
 =?utf-8?B?MUk4Z3RhbmlWSjhTYXl1M3NJdjBxVFdiaTYyQW9aTmtTUjFVbnFIeFRySk16?=
 =?utf-8?B?S2lVZ2xEazhEYzNHOCtyUWp2aTFaazVyZTFUVzduRUZudnoxL2o2VjdYNjVp?=
 =?utf-8?B?YlZpWUFJdXhjQkJGSFJxSDdKbGVhaVNsSnhObUY0M1pzZjNaUFRUTURxM0Rr?=
 =?utf-8?B?ZGtlWWJwbjRuK0FFSEhoZ0JZV1p1L0NXYldqZW5uMEMrajcrMW9ndUM1dHhw?=
 =?utf-8?B?WXFpWmMyWVNmM29SeE8rbitWcHFvZFdMN3ZSa0Y3NVlKeWZ6LzMreDVXSzNJ?=
 =?utf-8?B?cFBWcnE1WGNyS0NJUkt3bWpPeDVLU29nUmY3Z3BraWJBV2RLcW1GclliNGxR?=
 =?utf-8?B?ZlFRc0xkSS9QZjM4aTc0Y00yMTZVT3Q3akE1L3ZTSDFUWVV0YlNiSUNlVEo0?=
 =?utf-8?B?QW03SGFNSlVtakNyV0tuVDd3SnRiRGQ5bWpNd2tLOXNRTFhxaEZzdFBoQXVP?=
 =?utf-8?B?VmtlVHYwWFRnOEkvcXJlenF2N3g3aExHa2ZuRWJEdnVaQmhkYitvM2MvamJ0?=
 =?utf-8?B?UGJrQ0lwV0lrVnRQOC8xTjllNmhudmZyWU13alZPRll2RjhYL3pGMEE0ZUJm?=
 =?utf-8?B?NzVzWEpkeExKNmExK1BRSlJGYXQ2eDI1clZseTFXYjVwaVhVc1RRb0tMQTFp?=
 =?utf-8?B?WXRMay9udndLcDJsTDJTS2gzejBKdlRlSmNRY2FQVCtva0VnRVQ2ZEs0WDR0?=
 =?utf-8?B?UlcrSXJuWXV0QmMvQ0ZkdXYwQzNCVVNjNlNiMlJGVllLVHEvUUVEWmdtREor?=
 =?utf-8?B?c2l0TzRLU2pobHpqL3RGanRxT3NqYWJvdVprcDBsWXpHMkI0dEx2SzNFcHJE?=
 =?utf-8?B?b0hZUE5QYklFRTFZY1BFY1U4QnR3bDFneUQ3R1lEZVQrUm5XUmplaTBwbllt?=
 =?utf-8?B?emI3SVI5RDhJRFFuT0ZPTlBUeTh6Z0lmUzg0QWNaa1lLWnhaK05UZnpYNTYw?=
 =?utf-8?B?a01HQURlZC9ZdnRQYTJNYXl0dVhkQWlZZTRaNkQ3cGkvZUlGUGpOMHNUMHk2?=
 =?utf-8?B?dlhuZ0JKM3JEWHpiYXlkd1pjZ1hsamt4Y21rRmp2MEdQamVlU3gva1p1TEwx?=
 =?utf-8?B?REtsVUt1S1NrS0grOHVBWjNkRGlOMFZtaFdYYnJOWmxWdmVzVmtiRjFQa0da?=
 =?utf-8?B?TS8rdGxwQ3ZqT1cyMWdKVVAvVFV1ekM0OTNRblEvWkE0M29NZXFQQmpwdWFE?=
 =?utf-8?B?VkdEdS9zMUxMTWcxRkJJa3A2aVE3VW9DczIyUUttYXpjNkgvOHk5RmdNNTVq?=
 =?utf-8?B?a243ZkJvKzR0ZlpSWWVEVC9SNW9NRkZqSTJGM2s3VjVRdFFvT1U2a0tMK0JW?=
 =?utf-8?B?MFQ0RGV2SE5DMzVabU9MZTFCU3VMM2syb011VUsxaWtJM09wQ2drc1lNejZO?=
 =?utf-8?B?QzFvTDhNMHhzUDJyZkdsblExUG5rc1FuaUk2YjBJSkQxUG9qNHR1akdza2R3?=
 =?utf-8?B?YlAxL1ZHT0tpY25zWCsxK3BsU1F6MDY2b0FZekhGd0YvSkk0ZGdsL3UvZ2t4?=
 =?utf-8?B?ZzhOaS9rQTlyTFBMVkJad09RdWZSZHZHSWR4eGZxU0xLNzZzQzJBUyt3eG1w?=
 =?utf-8?B?emZlUDZVM1pxZ2VpSlBuMHhvdlRlYzQyditPUmZob1VOVGZPeVZJbHhRZ3Zs?=
 =?utf-8?B?N0JPYmhMa1VidC84WWtIenVQWnlPY1pMaWp5elVvVTBJUUhPazB2Q0VVVms5?=
 =?utf-8?B?KytocW9EMysxVzlhWDV1dDJNelA5Mlhqby84ZnNic3YwbFkvQnRwV1hxaXU1?=
 =?utf-8?Q?uaNqAJ79pZ2JWpNY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB2F767A1B8E394887203C189F9C2A2C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HH1oM0qdbBizykO9qUXsLFMREI4KdLUdr6lOzN2tVWUsY0X+OdBKLYGTdzlO/iYU8wcbW1hmWyfkfi6RWEECDioJoxVv7qGYZK4a1ycSr8aEqqs3QJsb6jOoN2sWI0IW8cFRG3KQ14VI10hWy76qWGOSnsKiR9HhCMZKHerOUba5vCxvOp0WlcfgeKYc7T/vmQNDFDfr0KvBX4z6+k8HnNhV5ox9l2L88c42MpJd98+O2q7q9ETAfjD7E+pIuAkKrx1/ajTP4NzSL1nkY4fUIMR8XPJz+O8ZLM1GjzL2CYEwykS3/G6LsMcPWVcNhezltj+AXcJ5Fcjdz0iDhZvnHg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180bbe0a-d758-48db-00ee-08deffdfa96c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 23:55:21.8208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /mfZQCyztJs2U60RINAnIj03z/p+X0EO6oAxM9r4WlSUDmeIkXaOY7P3yjzV4ABL2ZEsq9SqakS3ZMqGEexkVeSD8U6piaBsIj2iuf3P3d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTIxIGF0IDExOjI5ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gVERY
IG1vZHVsZSBleHRlbnNpb25zIG5lZWQgbWVtb3J5IGZvciB0aGVpciBvd24gaW50ZXJuYWwgc3Rh
dGUgYW5kIGRhdGENCj4gdG8gc2VydmUgU0VBTUNBTEwgbGVhdmVzLg0KPiANCg0KRm9yICJ0aGVp
ciBvd24iLCBJIHRoaW5rICJvd24iIGlzIHN1cGVyZmx1b3VzLg0KDQo+ICBTZXZlcmFsIGFkZC1v
biBmZWF0dXJlcyBkZXBlbmQgb24gdGhlDQo+IGV4dGVuc2lvbnMgdG8gZXhlY3V0ZSB0aGVpciBT
RUFNQ0FMTCBsZWF2ZXMuDQo+IA0KPiBBZnRlciBwcm92aWRpbmcgYWxsIHJlcXVpcmVkIG1lbW9y
eSB0byB0aGUgVERYIG1vZHVsZSwgaW5pdGlhbGl6ZSBURFgNCj4gbW9kdWxlIGV4dGVuc2lvbnMg
dmlhIFRESC5FWFQuSU5JVA0KPiANCg0KV2hhdCBleGFjdGx5IGRvZXMgVERILkVYVC5JTklUIGFj
dHVhbGx5IGRvLCBhbmQgd2h5IGNhbid0IHdoYXRldmVyIHRoYXQgaXMNCmhhcHBlbiBkdXJpbmcg
VERILkVYVC5NRU0uQUREPyBOb3Qgc2F5aW5nIHdlIG5lZWQgdG8gamFtIGFueXRoaW5nIGluIGF3
a3dhcmRseS4NCkNhbiB3ZSBzYXkgdGhpcyBpcyBhbmFsb2dvdXMgdG8gVERILlNZUy5DT05GSUcg
YnV0IGZvciB0aGUgZXh0ZW5zaW9ucz8gSXQgb25seQ0KZXhpc3RzIGJlY2F1c2UgU1lTLkNPTkZJ
RyBnaXZlcyB0aGUgZmVhdHVyZXMgdG8gZW5hYmxlIGJlZm9yZSB0aGUgbWVtb3J5IGlzDQp0aGVy
ZSB0byBhY3R1YWxseSBkbyBpdC4gU28gaXQgbmVlZHMgYSBzZWNvbmQgY2FsbD8NCg0KDQo+ICwg
dGhlbiB0aG9zZSBhZGQtb24gZmVhdHVyZXMgY2FuIHVzZQ0KPiB0aGVpciBTRUFNQ0FMTCBsZWF2
ZXMgbm9ybWFsbHkuDQoNCk91dCBvZiBjdXJpb3NpdHksIHdoYXQgaGFwcGVucyBpZiB5b3UgZG9u
J3QgY29tcGxldGUgdGhlc2Ugc3RlcHMgYW5kIGNhbGwgb25lIG9mDQp0aGUgZXh0ZW5zaW9uIHNl
YW1jYWxscz8NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWHUgWWlsdW4gPHlpbHVuLnh1QGxpbnV4
LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFhpYW95YW8gTGkgPHhpYW95YW8ubGlAaW50ZWwu
Y29tPg0KPiBSZXZpZXdlZC1ieTogVG9ueSBMaW5kZ3JlbiA8dG9ueS5saW5kZ3JlbkBsaW51eC5p
bnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGlu
dGVsLmNvbT4NCg0KQ29kZSBsb29rcyBnb29kLiBFeGNlcHQgdGhhdCBpdCBsZWF2ZXMgbWUgd29u
ZGVyaW5nIGlmIHRoaXMgY291bGQgaGF2ZSBhbGwgYmVlbg0KYSB3aGlsZSBsb29wIGFyb3VuZCB0
ZGhfc3lzX2NvbmZnKCkgdGhhdCBnaXZlcyBtZW1vcnkgb24gYSBtZW1vcnkgZXJyb3IgY29kZS4N
CkFjdHVhbGx5IGl0IGxvb2tzIGxpa2Ugd2UgaGF2ZSBhIFREWF9FWFRfTUVNT1JZX1BPT0xfUkVR
VUlSRUQgZXJyb3IgY29kZSB0byB1c2UuDQoNCkNvbnNpZGVyIHNvbWV0aGluZyBsaWtlIHRoaXM6
DQoNCmRvIHsNCglyZXQgPSB0ZGhfc3lzX2luaXQoKTsNCglpZiAocmV0ID09IFREWF9FWFRfTUVN
T1JZX1BPT0xfUkVRVUlSRUQpDQoJCXRkaF9leHRfbWVtX2FkZCgpIC8vc2luZ2xlIHBhZ2UNCndo
aWxlIChyZXQgPT0gVERYX0VYVF9NRU1PUllfUE9PTF9SRVFVSVJFRCkNCg0KSWYgdGhhdCBjb3Vs
ZCB0ZWNobmljYWxseSB3b3JrLCBJIGd1ZXNzIHRoZSBiZW5lZml0IG9mIHRoZSBjdXJyZW50IGFw
cHJvYWNoIGlzDQp0aGF0IGl0IGFsbG93cyB0byB1c2UgY29udGlndW91cyBwaHlzaWNhbCBhbGxv
Y2F0aW9ucy4gTm90IHN1cmUgaWYgeW91IHRoaW5rDQp0aGF0IHNpbXBsZXIgc25pcHBldCB3b3Vs
ZCBhY3R1YWxseSBiZSB0aGF0IHNpbXBsZSBpbiB0aGUgcmVhbCB3b3JsZC4gQnV0IGlmIHdlDQph
cmUgYmFzaWNhbGx5IGJ1aWxkaW5nIGFsbCB0aGlzIHRvIGhlbHAgZnJhZ21lbnRhdGlvbiwgd2Ug
c2hvdWxkIHNheSBpdC4NCg0KPiAtLS0NCj4gdjE6DQo+ICAtIEZpeCByZXR1cm4gdmFsdWUgZm9y
IFNFQU1DQUxMIGhlbHBlcnMgKENoYW8pDQo+ICAtIFByaW50IFNFQU1DQUxMIGVycm9yIGNvZGUg
Zm9yIFNFQU1DQUxMIGhlbHBlcnMgKFhpYW95YW8pDQo+ICAtIENoYW5nZWxvZyAmIGNvZGUgY29t
bWVudHMNCj4gLS0tDQo+ICBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmggfCAgMSArDQo+ICBh
cmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgfCAyMyArKysrKysrKysrKysrKysrKysrKysrLQ0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5oIGIvYXJjaC94ODYvdmly
dC92bXgvdGR4L3RkeC5oDQo+IGluZGV4IDUyODg4NDI0ZmU3ZC4uMWY0M2QyZWIyMzQ1IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmgNCj4gKysrIGIvYXJjaC94ODYv
dmlydC92bXgvdGR4L3RkeC5oDQo+IEBAIC00OCw2ICs0OCw3IEBADQo+ICAjZGVmaW5lIFRESF9T
WVNfQ09ORklHCQkJNDUNCj4gICNkZWZpbmUgVERIX1NZU19TSFVURE9XTgkJNTINCj4gICNkZWZp
bmUgVERIX1NZU19VUERBVEUJCQk1Mw0KPiArI2RlZmluZSBUREhfRVhUX0lOSVQJCQk2MA0KPiAg
I2RlZmluZSBUREhfRVhUX01FTV9BREQJCQk2MQ0KPiAgI2RlZmluZSBUREhfU1lTX0RJU0FCTEUJ
CQk2OQ0KPiAgDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgYi9h
cmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gaW5kZXggOGMyZmRhZjBiOGMwLi44NzNiODM5
M2YzMmYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiArKysg
Yi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gQEAgLTEyODksNiArMTI4OSwyMyBAQCBz
dGF0aWMgX19pbml0IGludCB0ZHhfZXh0X21lbV9zZXR1cCh2b2lkKQ0KPiAgCXJldHVybiByZXQ7
DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBfX2luaXQgaW50IHRkeF9leHRfaW5pdCh2b2lkKQ0KPiAr
ew0KPiArCXN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgYXJncyA9IHt9Ow0KPiArCXU2NCByZXQ7DQo+
ICsNCj4gKwlkbyB7DQo+ICsJCXJldCA9IHNlYW1jYWxsKFRESF9FWFRfSU5JVCwgJmFyZ3MpOw0K
DQpXaGF0IGhhcHBlbnMgaWYgbm8gaW5pdCBpcyBuZWVkZWQ/IERvZXMgaXQgcmV0dXJuIHN1Y2Nl
c3Mgb3IgZXJyb3I/IEknbQ0Kd29uZGVyaW5nIGlmIHdlIG5lZWQgdG8gcmVhbGx5IGNoZWNrIGV4
dF9yZXF1aXJlZCBhbmQgY2FuIGp1c3QgY2FsbCBUREhfRVhUX0lOSVQNCnVuY29uZGl0aW9uYWxs
eS4gV2UgbmVlZCB0byBjaGVjayBmb3IgVERYX0ZFQVRVUkVTMF9FWFQgaW4gYW55IGNhc2UuIEJ1
dCBkbyB3ZQ0KbmVlZCBib3RoIGNoZWNrcz8NCg0KPiArCX0gd2hpbGUgKHJldCA9PSBURFhfSU5U
RVJSVVBURURfUkVTVU1BQkxFKTsNCj4gKw0KPiArCWlmIChyZXQgIT0gVERYX1NVQ0NFU1MpIHsN
Cj4gKwkJcHJfZXJyKCJUREguRVhULklOSVQgZmFpbGVkOiAweCUwMTZsbHhcbiIsIHJldCk7DQo+
ICsJCXJldHVybiAtRUlPOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+
ICBzdGF0aWMgX19pbml0IGludCBpbml0X3RkeF9tb2R1bGVfZXh0ZW5zaW9ucyh2b2lkKQ0KPiAg
ew0KPiAgCWludCByZXQ7DQo+IEBAIC0xMzA4LDcgKzEzMjUsMTEgQEAgc3RhdGljIF9faW5pdCBp
bnQgaW5pdF90ZHhfbW9kdWxlX2V4dGVuc2lvbnModm9pZCkNCj4gIAlpZiAoIXRkeF9zeXNpbmZv
LmV4dC5leHRfcmVxdWlyZWQpDQo+ICAJCXJldHVybiAwOw0KPiAgDQo+IC0JcmV0dXJuIHRkeF9l
eHRfbWVtX3NldHVwKCk7DQo+ICsJcmV0ID0gdGR4X2V4dF9tZW1fc2V0dXAoKTsNCj4gKwlpZiAo
cmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJcmV0dXJuIHRkeF9leHRfaW5pdCgpOw0K
PiAgfQ0KPiAgDQo+ICBzdGF0aWMgX19pbml0IGludCBpbml0X3RkeF9tb2R1bGUodm9pZCkNCg0K
