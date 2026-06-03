Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B3230567B;
	Wed,  3 Jun 2026 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487775; cv=fail; b=NoVp51W443E9dsrJLyM/oosHGvr0ugVCpl+3G89xJeWVxIuV0jDFaL20sL0V/eUiKTxyxt709yy+it1VOypsd9uf17QfefGNfIc7uHwQ7SIsTL8LTgG6eRUGKZKIMrSjwFLM7KnUdxwehFb7SXZrIGn3SEuL2MwF5Uv0+tDu4WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487775; c=relaxed/simple;
	bh=/7BE5iG2YZv2CAUIyEi4VUC4z8t+b9QQ/p2sPLCTiwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Af0tvy7q2CiLkpMs9vRpyupDOrXpUNtuuxMfnEFkfcBNPh6jyysbEda34fOSXZY2tTJQ4xVMjjVVtpeM2oUplI4DuKZRcepqBzq5y5F2qt8V0EJtrY0tYM9VSmZ/9tKgFj/Y/MLqp1JZOqr1B4eCh3r3PDtunFnFYAXFLvz6Uoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAbMU8ti; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAbMU8ti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780487774; x=1812023774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/7BE5iG2YZv2CAUIyEi4VUC4z8t+b9QQ/p2sPLCTiwc=;
  b=VAbMU8ti36HfrdQRAyyYhuIYOkvxyhelhg5bizf3pXb/72TG6mA9orES
   FuUqnointEODqXx83gNyppU0uIP/3J+OFdrPSBr2rYWOYgoV1VWN/eOnl
   /76+o63ehMQkMsy3TDZNfvJWKqrn7AheX2y1HGsChSXO2Izw4oPTkgQzE
   k6GiC0sXwth/eJ+reDwqan5sBhxEYDr5JTw7Jqxlc/PQ7RaUN7rrtDPBR
   JlTibVwhDHqJ3ZPbn4vyHceuCa293RkZ4Le7cR8XAR0iRfoMv0cOXNizz
   6dFOEJZOtLOzJiKALefBF2P8CNyIRYXSCA1UczWtuZrhqiBDTSJcBOBSq
   g==;
X-CSE-ConnectionGUID: y8+1snOJQtWJIsaXA9MqQg==
X-CSE-MsgGUID: +F60PXK4To2BQxSf+fM3qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="106743951"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="106743951"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:56:13 -0700
X-CSE-ConnectionGUID: ZNJw7HXGQPqBzfNNM4HUUQ==
X-CSE-MsgGUID: PZwojzxrQhm72vfbVC92+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="282322136"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:56:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:56:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 04:56:12 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:56:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaGau/yDje8QsgwbUQv8AP9rIf+HsVmHndqDZux8cGQCZn6irod62YTwATXU7FItci2mq38/OcKcjLzmLntAMHiWexo8nxfdpLmj5b8av7sWkFtHP73V8vhRGKbqQOcjEki87O8dplSsKl1DXqtnZ6u10Zxx2qpGnEPNSe07f/DoVCDhM1hAk+e9ecm0nTn5wA+A4z4TYvRBibx9gdXLXbMx5YhRYojLjESRAx01boclF4kD1/snLU03GVinMLkzYo14ORGss346uD5gN5aEFzqOZ9nFyXug+3LOWO/VycoYZuzRRkoxG/HdXnpsfBTYITPT9CEbA95zKqiPl3+TCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7BE5iG2YZv2CAUIyEi4VUC4z8t+b9QQ/p2sPLCTiwc=;
 b=XzTfNxfNJZqzXFfqAuHqAVYNzQ7K4VtkxDOC9AtCAusDjh4pv5cbhKNhuQ8Wd+MKTjI8KZHkTUS5LOBmEhSmeufKqBuXxq8o8/3ykInxdH0A0IdlmjAHkyCIqQusFXVq9TDlwomwBsqBe+TV7L6K5r9gjaJG5UUyWhj5iiRrZfMSapiL5ZeWos0QfE742zQEPjQtBD/Sk8SAJAA7JWyk5gz1c6a5XsyO5AB1ANSSDIkMJp4dry8lGY62MmffooYU6xPlfCJUAUz2So+xlcT/EcZQ3Fexv1C16OZWFXiYBEUZNMtVYaqNfLGMvvlcHhSoEqqoZhAhfzAYuIK117RWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 IA4PR11MB8941.namprd11.prod.outlook.com (2603:10b6:208:55d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 3 Jun 2026
 11:56:05 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:56:05 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 20/40] KVM: x86: Move tdp_enabled from kvm_host.h to
 mmu.h
Thread-Topic: [PATCH v3 20/40] KVM: x86: Move tdp_enabled from kvm_host.h to
 mmu.h
Thread-Index: AQHc77nCu5fx71hme0OuLuBwrKGNh7YswHOA
Date: Wed, 3 Jun 2026 11:56:05 +0000
Message-ID: <a6ea633df2a0397716e1c59996a67d946d66c5a4.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-21-seanjc@google.com>
In-Reply-To: <20260529222223.870923-21-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|IA4PR11MB8941:EE_
x-ms-office365-filtering-correlation-id: 61fa861d-be23-4cab-0b5a-08dec16717a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: m5vjbwhY8Ovl5FJBY5zq/gmsZ0AELQbQxmNC2Qq1GIhg8j6OuLDo8z5MhGhYawnlgy9vEAyx868pU5Y+kVXNBHLPSMZ8oZq7QAAWaiDiYx5ik3AVTmgRiZntxsCITiiGRkohhU8hQCyOVTaFACBStkZBe3aUhrlg3eqGCs17wJCaVb5u1/eh1u1hiftYDINCSyFZfvQdqywHNIx4eBDkgdoULKeFTmQRskr4qb00ag9fUW4rjb/bu402dFpMXz3gQiB1L1+CbRRjJXdJGRtajiEBgHkDTxXEmP9s01YpWorF1AyahU5VuOSmxg2GGCQX+S9yUsuuDLBblcdm1Vf7igrxON8iai0qqVePDZ5Ezhu+OAZzr2cUJvImLnazmdvYCV5ExNaYpsYRsn2hlfZDQava6T4dR5wNF7asdECwN2s5iRbfykv2oTtNzGyoJpmoLOTJbDCx112jA7+WV15Ix74H/qr4852/xNFSprkCd5QMtCU0PK1nb/BmrQ6qKAhEgF/DcLnWGhJqQquTItLfY2vZq1jTqbzSTBpqptKmyxZK6dxooq48XrJzSWre1y1w6FfeWg/gjQGIDzLTfpOF1qxu3688fcxE6tfEAOv0a47aoVP20DnyxCZ/+QOkIAcoYDvBvnicY9wziTlbTwAcPRB/xSk/DThcIQ/gWz+krbL6RWXKWVMFhr05Y/uY7dfP/hf/k5xMT9vcId0ycVahozVabATiL+DL58HmiGBvrMt0j5oU8GV0HhaC9Y6pyN1z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RENsUTV6eGsrVGhSODVEODBsM2JLdDJBYjRhekJuYTM3MmMvUU41clZKanpT?=
 =?utf-8?B?TGp1OWhoVy84QnlIOXNRWXNNaEVwTmNZem1iVWV3ajU1bUZ1em84ak9YVW9H?=
 =?utf-8?B?STNJT3VTUmtHemJDaHYvTUhiRVp1Tk9YWE9qZjdFVEpQcnJLRUhnMWdmYUI3?=
 =?utf-8?B?dFBTZ2hEYUcra1NvK0dUQ2RNYVdBMnFyd1hya3ZWektzaUd2bFdvZmdMdlhN?=
 =?utf-8?B?UFVyeDk2TWdmZk42VHlRSEVPSHdJNENWNDF0TUpWUTh5dytvS0pRZEJSRTdl?=
 =?utf-8?B?OW93aFFXREdIWUdQWmt3UzI4WS9FNnVnL2w1aEJ1TVN4UHlRM0UwK0xjS2Fj?=
 =?utf-8?B?ZnF4NmhJM0VLUlpZOUcwbkFsN2N5Z0d4SFRpM015cnRhellaemgwbjBvRFRE?=
 =?utf-8?B?UjJxaHRGSC9vRmNGcjBHcFFPdXNBS2pUc1o5QTRFUjBpS0I1QnFKZHhkbExx?=
 =?utf-8?B?TWpWVFI5RXFRVjlFSE5FT1VFR2h0S25SZGk2cEluMDNzc1B3L2liV2FwSFYw?=
 =?utf-8?B?bmFwUy9NZDFBU3hzMWhsbmpKTHdNbFgrQTg5MGNGbnYvY1M1NW9sWXJlQllw?=
 =?utf-8?B?SUYyU1puTGREd2dLNW5PYWZqWWRmakh0aWdVZHYvOCtCdzhqWmJGMVVGTVRS?=
 =?utf-8?B?L2lVSTY4ZnBPZ21BNGJRdUd5YXhPOUxhcGprY2NGaU0xUXdyeVJVWklCN3VI?=
 =?utf-8?B?VmQwaGFnakljM2VRNEJ6RnQ4eWxRUlR5TWUzY3BQOVFsKzRQdnVJTHFLajk5?=
 =?utf-8?B?NGRYOFBJYldkOWZOU1dhQmV0MUVPdlVVSEF0Z3dIZnhmOGsvSjVrcGV6bGxw?=
 =?utf-8?B?clJNVTlQWlFGK1Nkb0Yrb2x2MHpNMFBnOEVDdEw2QWlkUXVLcm8xTUVqNDAy?=
 =?utf-8?B?bHovVmpnY1N2OXF1ZVJldzhwV3NmOVYwSGxudXAwS3FPWXQ0cjhmZ3hBK1FW?=
 =?utf-8?B?N3JsYk54MldZYzVUL3JGdjhGWkFpWDUxTUtxUmNZUXhOV1BZcXhTb2oyOXhw?=
 =?utf-8?B?cnE2SWdVWFY4eVZRbTg0bEh5WTBUM2ZmOVJ0K3pZSWN4UXhsMjlPNlpwdkFk?=
 =?utf-8?B?REt3WTNQNzFpcjlHcUc2NERRdUJBTVJ3b3RjcEZ4MDJKbVBNZHpBdEc2Z3BN?=
 =?utf-8?B?VUgwcytta1JTU21GbllZOXAxNDNJeTN6cXhNZ21LZkxMK2YwY1NObmlKTlFy?=
 =?utf-8?B?aXFZenRYTkVHYkZ0SEsvUnJJUEVTb29aV1V1OFhocyt3ckJFbTNIMy9YWmM0?=
 =?utf-8?B?bjM0WExReElucHQxY0xZMnVwS043T0FRZ1M2SDZFeWErNTR2eFFUTXIvbGVz?=
 =?utf-8?B?YVV6NTJjODV5dTgxaUtKbWh3N3BUQ1NrNHVzeDk0ZFZjZ0xWK2tBd28yNzFu?=
 =?utf-8?B?UVhDTWp4Nm5iU3lLRnExTkFzWWgwbHhyU281N20veGl2YlJuRG9FN2hQUmNm?=
 =?utf-8?B?cDQ0ODBwRUdpU3RzUzl3QzA4cGpWc2J0OHp2Tk1wVmdrTkZPYlQvTThXWGVT?=
 =?utf-8?B?K1hEMXVqTk9xdTFZOVRIdGFoME12RVhhMWxXVHNyQk5jcU1seG1YQlJBY3R5?=
 =?utf-8?B?VnlvZ2Fvb0FUR1FBWlo3WXYxaWFpNVBJYk14SGRKQTV5RXYxT3E5ajdyODlx?=
 =?utf-8?B?T09xT1lJMVhDazY3dkVVdTQyb0Y0RlV4eVA5T2Y3YU5tdGpNMzFUTXBFckZy?=
 =?utf-8?B?dmhFUDNEN04wSVA5N05PcXlYalZtS3o2V0F0aytFZXVuYUF5dkRwUm1qYjhV?=
 =?utf-8?B?Z2JFMmozSDB0b0c0ejR6MDJ5ZlJtdGlnMkJ0WE1rMzhNWDlaNzdPUXMvcDlo?=
 =?utf-8?B?UzFYY1F1M0lxVmpYamU1dmlJeVFWVFlkWVY2M0l2TXo2MGxTN1pQd1BBZzVF?=
 =?utf-8?B?QTIxMkgyQ3VkVmU0bUN2YURycXVPUGJaNEZMWCtvR3dqTnRWODdBVnFvb1R0?=
 =?utf-8?B?aFBmSjRHaDZQTC9nUWV5RmdaWkJyMHkwY1E2OWNKOTJsWEUrS1hzWXBzNHBH?=
 =?utf-8?B?SUdvYll0NTJ4VFNrQ0kxak54RXlqL24wMk13ckdrYlQweEhDbHFIN21Hbzhs?=
 =?utf-8?B?R2c5YWRQa1NoSGlXODZLTS9nTG5YeEZwVkFOTDFqS25TUTNsWUQ4ZkxhUENR?=
 =?utf-8?B?c3lpWU1ITUxXR0w2SzNrdWhzTmtRdTJaVkZqUUVNWFVWakJJck1CNC9JcVJV?=
 =?utf-8?B?KzRaRlEzVmpZSFBLUm8yNndXVFBUY2lRWS9oamxlOHI1ZGYrMjcxNVRVdld4?=
 =?utf-8?B?TFA5VXFYcGlNM0RvbXJjLzdaeGVtVStORGUyaitOVGxQMzZ1Mno1YU5UOE1L?=
 =?utf-8?B?K1hFS0xqNlRrS0twMWFhR1VPRlJkRG1XNloxY21FUGUyQjJCbDhTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECEB91C099B30343971E5E0B2DB009E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RxRHZXKMhx0C7nNEzLHor4BvZvtcq0f3+iOr0ZLe3yYnAh5Q3OeEYwJ17TfEoIwpAlL45eEzgm/rnrrMrsNwcZ6IDpENR64437gk1k/PoppiombEsGitSEPczwBPRArIH8FpbV4ncvckyWjR6BmI32ccMHzWEa7gt9JU12hfbRplC7TaiiZeRbD5X2GRVJgwtiWibrdZ/Weau8K/Unn+U86gX4uLyhA6LQuDff6ti7fxu9NvFeEFIbwtwT40ZaouHYKN2KSSQ5/4ORe5HQHsXsZ4Fjwe8HYRgxYVIe/N8/8B12h/ZITkKsG9O9nN73TVK5dQKrkeHMXD//XIvmdEsw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fa861d-be23-4cab-0b5a-08dec16717a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 11:56:05.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StkZZCAarw3/DWdD4LIiCChkBBKvUyN1Sik6M/Cdkey7wYlLcDdkX8zRX3/KC55uuWUIrkkOGfNbKPB21uDuPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8941
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBSZWxvY2F0ZWQgdGhlIGRlY2xhcmF0aW9uIG9mIHRkcF9lbmFibGVkIGludG8gbW11
LmgsIGFuZCBvcHBvcnR1bmlzdGljYWxseQ0KPiBob2lzdCB0ZHBfbW11X2VuYWJsZWQgdXAgdG8g
dGhlIHRvcCBzbyB0aGF0IHRoZSB0d28gYXJlIGNvLWxvY2F0ZWQuDQo+IA0KPiBObyBmdW5jdGlv
bmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3Bo
ZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiANCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8
a2FpLmh1YW5nQGludGVsLmNvbT4NCg==
