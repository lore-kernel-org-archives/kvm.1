Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666383750AC;
	Mon, 24 Aug 2026 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593429; cv=fail; b=PDw9CkGYQoVilRdQCrjFG6GFAsbaencWzfZhytvH6J8RPx/Y1hhLfVjpCOSVKqqcMBs50QI3hR0S4EBnQKjI4UAe9MCOK+lF5IV8u03gtLtvPbsCurG7Th7l6c4M+gdw2Xx3up+aK11RVVT3EsGScCMavB4h6ECK+u67l/EbTsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593429; c=relaxed/simple;
	bh=Ah11/euwiUQnb9DDVhAGNsEfSyS82Ws3o6qYjWOHFBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LMdI2evnP+n9IleOFwzzmp6W0OMtadHybNqDRw2JLK+GLLEaxrZuAooXklephJT99HvnDq+pXcEakMPGr0UTsxt7oB+NbE8DCGXiPdxXGsYvHff1ZQj4daTgBf/mihS8SusBxwZeHsyPHs0TTDXF5rogIlELMb1UuqSYl9YXj3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZjOgtMQ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZjOgtMQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787593417; x=1819129417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ah11/euwiUQnb9DDVhAGNsEfSyS82Ws3o6qYjWOHFBw=;
  b=AZjOgtMQqwFnUXJ+XnoHJ1onmUI90SDbmAlfWO+3p/3MrZSib96nMl5u
   /8zEj5ZamkjW369xkrVmNIvTtDadQotSpIeXzXvr46lhrQWrWX9mjmuWc
   z16LgjOaVovZbD9H8PUSDbtt3CS6eTFQhtkIcd3+gLk0Vb4QuTKHeHXZ3
   eftCaDh1Bpg7I12UtOKGn8cC1+a95Pm/FFaBzIs2DGKX61H/vrLwhb85F
   cK5YEHCkHlV8/+QBOcT/W8eDYd6UBgavP1pZPhVQiZLXLZ82f+F0jOyIu
   VYkvVKZMeoJOMul3YfL45l9T6cG5mgnZ1hd4p850LdhLy71bNooTRA2+J
   A==;
X-CSE-ConnectionGUID: Ht6xQQIJRRqOTWaE+TVf/Q==
X-CSE-MsgGUID: QNtVUA4MQluhM0tD2Zk+TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="105430053"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="105430053"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 10:43:31 -0700
X-CSE-ConnectionGUID: kegW8FV9TaeDaB+mcUuWNw==
X-CSE-MsgGUID: 201fs958QIG34TUI1wQVfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="290583638"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 10:43:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 10:43:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 10:43:30 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 10:43:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEb6traVoVme8FcduyKUo6Y7hwvtzdoZMSaMV+ILuc8CXTCy0Sqt3DyH9TkyGodTMAsAQ4NVR2jJIYkIYbFdnCcyw5wGo5BqZGaoRtgI8W/4Xwfzt0Eoc5GniFljMI+A6K5b99dOXEy2wOR06yRf3djbdUWXQp6nkWkakC+unTCBsxpsslvmJ8SLHZVZonQCz0HfXG8kvHglTRa9/D3PebMRTXzTHsu7HLPaJfzb7Lmqij2fD1UbO8GbCsAE5EryYkO0EmvwmzJ1anryy+IZkr1+Zj7OS1VicLRqf1rICXWSRhn87KxBB05EPft3H2MX2Jrc08k1IjBvdzxktqlgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah11/euwiUQnb9DDVhAGNsEfSyS82Ws3o6qYjWOHFBw=;
 b=m4nzBCwm+IHfyVl6R3AfpseKzU85X+LXg73MFB2RGRViveDT189LzjbjFDScuObcI1nlVv+3GcRV/b4X+Aona1//Auaod4Oc50ZuY0noXWUkUuV1+OyQi5ilkifXY+LlIcuQysjYRks83mC01pXT6niAZiAjcwVmOXyqVUiW0cIEAWEMyO7h84+3JmqjY058bLQ3BHBUB3Vu0bt2ozE/Y7LW4FFiuqN7rXEUhLiv0tI2G9+jNaEZ2UwhaRiRvS5viu78xP90FtLb1+O2xEVfxjUX4IoDzzWbqMNOKxS7hrs7efAwSt84Ec8kSqH0E2CHfKO/xxALZKJOcIZKQY3Lvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS6PR11MB065147.namprd11.prod.outlook.com (2603:10b6:8:52a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:43:28 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:43:28 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>, "Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Thread-Topic: [PATCH 5/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Thread-Index: AQHdMR1VKsXmvQZJwk6q+Ulq286OyrapLs+AgARHHwCAAAjkgA==
Date: Mon, 24 Aug 2026 17:43:28 +0000
Message-ID: <6ffb491ea0252acd60982330be1e7ca1e8dcb23a.camel@intel.com>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
	 <20260821032920.256225-6-yilun.xu@linux.intel.com>
	 <f48b83feb2ee1d3c88b5a1627cf35b4b282d3f90.camel@intel.com>
	 <aox8DgpnSnhZRfCv@yilunxu-OptiPlex-7050>
In-Reply-To: <aox8DgpnSnhZRfCv@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS6PR11MB065147:EE_
x-ms-office365-filtering-correlation-id: 8d7c465e-04e4-4a1c-3af4-08df020734a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: 26Ed8nG4poZ1BxE30gbwdr8ybZMdwNpIPeRNZgnEEOn5Rn3g3nFEaknRB3nGBZoveZuY2+m8pwWkvU4w+AP4Bk+5mlE9msV/dKDvlzKO0LsH8j8SEmCrq/Ai8YCWBn4cGWYz6pHhtqmd27lFShZ6OtXARS0B9KFClopK3EG0P3Bgbi35qr6OtldZuYyfQEHWTRxJbfDXM8WbrZhU3yMxHnKroMlC7dWpU8owcN4bJoaQsvayDzPpalEbyz/LXZzJzdcInQteiCnL/BhQGkbIGucB5N6J/LHknxskTdfD3HspfFENWWsizXW0UWpdXgaUkL5ksgoQVBP7Y3dTTn2coMmWZE+LsT0/a6h5rdpHcD1LqCE4rhBEdqfMsUFNp4Hjo97WIlx5rvZeStry0Nhb1Tn/EJODsCdOLehlgGuaJ9BWDWl2XUWe/M+nxhjBOMt7YED2cxWGgNtz7CL1rvlge34XymO6Xy+DuDlPeZbhiuTlvEemLpj2bCt4lIJj16zC2qUd/N69qJn0YACJXCFvEXd4pq95wnYCEltD6srYolmEDoWA1IWfgc7kD8rlYNqMnCkAlmRkRhJj15L0NncnlTxa4BdphVM+GVbBuvwNcetOZrSaPe31SbuPT8HEtNxHoiUFDzkpmjFOi5aehoKL9RROBFw5zf09wJGns4hxRK/ZuszQo/dWaRjFlfY4D5If4FT3tOYypWyH178ZJT0+cKSirSW9bej32ydiRrqMNeg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkNqTHlnUXdiRjFSejFZaWZ0ZmVvQnAwSThwaXVTR3NTdnpHRWJITzNBUmRF?=
 =?utf-8?B?QjJKZDlZVWdXNTAwUlJIclBqTnJUdEtwakQzRGp0RmRMTXFGZ3V2Y1NNN1Fj?=
 =?utf-8?B?S3pZLytZS3A5ZXVlRk5LMk93SFVablFqalQwdVVoMEo3b2VhOTFiVCthS3lS?=
 =?utf-8?B?Mkd2VWlmOWJzMGlvNWlWQVM0US9KWmNPUG94VTdXRXBkbWtjZzlOREU4L1g2?=
 =?utf-8?B?Um9JTzg2TFFESWR0V0xmcW14TTBFWU9wNVVPb0E5blJFU3M2dUhJeHhtRDJI?=
 =?utf-8?B?Q21YeStiL0VxTHFZaGJ3WEk1ZjMzRHNZUVhJOUVGd2xYNm4vSGVQL2ZsK0s3?=
 =?utf-8?B?L2xXa1dwMWtVTGxLVUZFUGV2aUdCNUcwc1l4OTB0cCtYaVhwWTcxcmNQUE5V?=
 =?utf-8?B?c2Z0M1QzM2hSR2VEVXJ2Z09nb2p1a29RM1BPOUFQM3dHdWhSRXp0QWVYK0Rk?=
 =?utf-8?B?Nnd4UXZsdUN1dnFvWEpHa1FwNFRRSHQ2RTJ5b3BkSkprNmNQaHp0WGFJUElJ?=
 =?utf-8?B?dmwxOHBKdjZiZE1yWng1aVYveHVpR09aY0pjalRUNkJFc3RlaUxQVFVON0FM?=
 =?utf-8?B?MC9iQ0RzTmk3VFlIR3JBS0x1ZS9yeEpzRklqTy9Mb1Y4d1JSUUJ5M2dKUGkv?=
 =?utf-8?B?ODlKaWxvZ09OaFBxRVF1T3lZY1ZGeHRLOWJCSG1jUSs4eUpRTVVyMUZzdUVG?=
 =?utf-8?B?c3Rmbzg4MGd1SXIvU0lWVUp3SmxoOGEzcDhBbDQ1RXF2b0RnMC9BQzd2L3Ru?=
 =?utf-8?B?UldGN0xpMFhXN1E4UXNuSnI0SGVTMVBmOERMVFBhOE0wOWVFTmxrZWw4N2V0?=
 =?utf-8?B?ZXQyem5mUUUxOXMvM2lpc3NlZzdjakUrOUZCYklVRjk1elYwRVB6WWRaMDhT?=
 =?utf-8?B?eitwaEJqc0greFJnNWJsSy8vN2NpVDhlcklWTEZwYVo3cmFCekJjaExoT2E4?=
 =?utf-8?B?MEpWa2FYUFZ0WWFSREk3dmRqTk9qb2o1VlRnRFY4NzFjUHkwVUlSUHV1SlRB?=
 =?utf-8?B?bGNEbWpUbWxWdmxxdnQzTnFHQUNvS1NLUlNJT0kxL0djMmlqOVZldXNvdzVs?=
 =?utf-8?B?WERoa1d5eGNJK051cE0vd2hTZUNNWU4xL25YQ09paklpTVZiWTN0Zjd4V1dj?=
 =?utf-8?B?STBkN3BvdHNBWXJIOXZyQTlZWFIvZnNVbkgzRnBodW45YlYzd2RlamFkbTlT?=
 =?utf-8?B?Zjh2SjBKem9Mak1rbngyeE11Z1A4RTg2NXBya28yVmZ0UWdsc0drMDNwaENS?=
 =?utf-8?B?SzJDVEpZNHFPbGJSeXd1VDRhdm1XNWRiMmNkZUNrdlY1dTVIOGQyZEUvNmNa?=
 =?utf-8?B?N3kvYUhOVmdGREN3NTRJR3crbGp4SDV2U1JadGdHWk1raTJHbXJTN2N4YWMr?=
 =?utf-8?B?UkxUS2YvRjNyMXVSY3FYemFNMkRkdWdJMlh6MGNBQVlJY0lBeWt2VzJBZ2g4?=
 =?utf-8?B?Z0xQSUxROVBsZTVaU0lRZnRoUUdlMjJzRThBc3F6T2xsbnNzbEhyN1hONHlh?=
 =?utf-8?B?eWNJK3JnT3RNQ09KS0NPeFg2MzlkZkJUYjI3eVAvTnRQWC94TTZzNlJvbm9F?=
 =?utf-8?B?c2x4VEgrVjQ0YWYxd0JGazRuVUdGT29LamhteXVVV2ZCcTB1QUNHeUhoTnNP?=
 =?utf-8?B?Wi9FdTR6K05qL2hlWHNzVm9EM1k0Vm1PZm9LcWpiVlkyWkRocXdFdmUvOEli?=
 =?utf-8?B?anJ5U0pqRENDV3Fnb2FkeURLdHNEM3RjeXdidzlWSU1MV1dVVVdqT2I1cG5G?=
 =?utf-8?B?WFRwZUJEcnRGZytNYmd6bENsbVRZVVoweEc4Tmw4SmVZK29zeGNZQUZnWitF?=
 =?utf-8?B?VXhUTFlzYkt5bjVlU2MxMUJ3SlAzYzNFTnA5ZFZsNnFxRlBhTWdJTTBFQ21m?=
 =?utf-8?B?MXp0eC9Wb2RRMG1uWTlnKzhWYVdzWExzNXJhY2w4ZG9FelpsV2tsSndUTzg4?=
 =?utf-8?B?amJrejMzQlltejJOSlM3RERyMnBkaWdNMFBOd0IxWm1tYUp2ZXdLamxmZitJ?=
 =?utf-8?B?WkpTVjU2cXd4eHM5eWVLVm5FZEdLQnR2RkFiSXNEZEJlSkRaSWtsdlJqdmtS?=
 =?utf-8?B?K3VyMVc2SUxKa2JZWVVEbzR2aHhqN1MxdzB5ekdHK3JuL2FoellIek5lajNL?=
 =?utf-8?B?TG1sdnl2aU9BWW9CQWNsT0ZFb3NUTjJDa2FOM01rQzF1Q0hDTjZDakFVTXB4?=
 =?utf-8?B?eHVGbXdmNFU1MGxyeVQvVWFPZlhnbmtBbmRpMlFyQmxFR052em5NWnBzd211?=
 =?utf-8?B?eFpNWFlHa1pydzd0dnRkQ1ZFSlRMZklTMkFBdlp3dkllZnBhMXVYM0xmTm1H?=
 =?utf-8?B?eVlWR0VIL05XRGVGRUpGRXNPbVRTTG1WcStrTjh5c0lTZ2RLdTVUc1NuUHVC?=
 =?utf-8?Q?B7DSNcjxR4UoTuQE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <949D7EB767FCE04CB9311F2D2DA17455@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DXrAVel2SbzHd0fISZ50R5NDiM5kIH2MI5Q2Y99H9QKvmS1qKJiAh4X40TbUtm0MV67aFuyiWc/lJsoAZW0CqhQTlAr1F9zYl66bJWE/gD0G+cm2UggfSBrGb6ORneqsdz5qpQgFZw29GYYsvg+Z/EwbH0P5ta1hI+RcvR/JwePzBusDA28oxeO8nVZgHKoR67hdGXr/UWGkVflqDLxzlyS9L5N16PZcK1/oxCOEUZZSyAdl/DAbPOSBkdp9pJ7nwfb1f4sBti1SrbwjHuiQ/gR8v1wJ/u3nbFtTmKWxl0SAAd7ITTEuf7AM3zq+eWde5dcBP8+HoDu1XHqxPRqn8Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7c465e-04e4-4a1c-3af4-08df020734a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 17:43:28.0860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5n4zc53ogda2JBIQft/rDNRG/amQiYvyMhuxhjR4SRonIlvEDbArhz5TXoRaUHMwE89AKqwbw5nRna7KqmE44a9QkrnAPy4ofcRgoVqA5JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB065147
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTI1IGF0IDAxOjE0ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gPiBX
aGF0IGV4YWN0bHkgZG9lcyBUREguRVhULklOSVQgYWN0dWFsbHkgZG8sDQo+IA0KPiBUaGUgU1BF
QyBqdXN0IHNhaWQgaXQgImluaXRpYWxpemVzIFREWCBtb2R1bGUgZXh0ZW5zaW9uIi4gTXkNCj4g
dW5kZXJzdGFuZGluZyBpcyB0aGF0IGl0IGJ1aWxkcyB0aGUgU0VBTUNBTEwgZXhlY3V0aW9uIGNv
bnRleHQgYnkNCj4gc2V0dGluZyB1cCBpdHMgaW50ZXJuYWwgZGF0YSBvbiB0aGUgbWVtb3J5IGFk
ZGVkIGJ5IFRESC5FWFQuTUVNLkFERA0KPiANCj4gPiBhbmQgd2h5IGNhbid0IHdoYXRldmVyIHRo
YXQgaXMNCj4gPiBoYXBwZW4gZHVyaW5nIFRESC5FWFQuTUVNLkFERD8NCj4gDQo+IERvIHlvdSBt
ZWFuIHdoeSBjYW4ndCB0aGUgZXh0ZW5zaW9ucyBpbml0aWFsaXphdGlvbiBoYXBwZW4gb24gbGFz
dA0KPiBUREguRVhULk1FTS5BREQ/DQoNCk5vdCBzcGVjaWZpY2FsbHkuIEp1c3Qgd29uZGVyaW5n
IHdoYXQgaXQgaXMgZG9pbmcuIExpa2UgaXMgaXQgdGhlIGJpZyBvcGVyYXRpb24NCnRvIHByZXAg
dGhlIG1lbW9yeSwgYW5kIEFERCBqdXN0IGhhbmRzIHBhZ2VzIHdoaWNoIHNpdCBvbiBhIGxpc3Qg
d2FpdGluZyB0aGUNCnJlYWwgd29yaz8gT3IgbW9yZSBsaWtlIGEgIndlIHRoaW5rIHdlIGFyZSBn
b29kIHRvIGdvIiBub3RpZmljYXRpb24gZnJvbSB0aGUNClZNTT8NCg0KPiAgSSBjYW4gdGhpbmsg
b2Ygc29tZSBjYXNlIHRoYXQgVERILkVYVC5NRU0uQUREIGlzIG5vdA0KPiBuZWVkZWQgYnV0IHRo
ZSBleHRlbnNpb25zIGluaXRpYWxpemF0aW9uIGlzIG5lZWRlZC4gRm9yIGV4YW1wbGU6IGFmdGVy
DQo+IGFuIGNvbXBhdGlibGUgVERYIG1vZHVsZSB1cGRhdGUuDQo+IA0KPiBJIG1heSBhc2sgdGhl
IFREWCBtb2R1bGUgdGVhbSB0byBnZXQgYSBiZXR0ZXIgdW5kZXJzdGFuZGluZy4NCg0KVGhhdCB0
aGlzIGlzIGFsc28gY2FsbGVkIGR1cmluZyBhbiB1cGRhdGUganVzdCByYWlzZXMgZnVydGhlciBx
dWVzdGlvbnMgdG8gbWUuDQpJZiBpcyBkb2luZyBpbml0aW5nIG9mIHRoZSBtZW1vcnksIHRoZW4g
d2hhdCBoYXBwZW5zIGR1cmluZyBhbiB1cGRhdGU/IEknZA0KZXhwZWN0IG1lbW9yeSB3b3VsZCBu
ZWVkIHRvIGJlIHBlcnNpc3RlZCBhY3Jvc3MgYW4gdXBkYXRlLCBub3QgaW5pdGlhbGl6ZWQuIE9y
DQppdCBpcyBkb2luZyBzb21ldGhpbmcgZGlmZmVyZW50IHdoZW4gY2FsbGVkIGFmdGVyIGEgVERI
LlNZUy5VUERBVEU/IERvZXMgaXQNCmNvbnN1bWUgdGhlIGhhbmRvZmYgZGF0YT8NCg==
