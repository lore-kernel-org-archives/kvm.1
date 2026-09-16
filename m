Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CFC1A5B8A;
	Wed, 16 Sep 2026 00:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519019; cv=fail; b=EJg/HnULgXe264YMKJUI2a8XdI1xgcoPXDQN+1pKmZPOqquENO2LfpTZMaKbxBmBKS7++KSxn64a9K7YCkYU1Ww2akeUEglMmK+gge7a23EDekV16NSyaTtNTyRK/KWjrPYrdZuyAiWdLVW/VO0UBIwrqIAqvJwcOT/sBV9C+aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519019; c=relaxed/simple;
	bh=rsEuL8PgT+OXnr43O900lqCdUOlATg3+s+nfN3/AQNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eOsgEGRiGTE3Zd8hVTJo9GcE1zo+W93tiyop6Ta+3GjR6VOT5SLz6AZH5baSVtSP0pMD5cWuZyQGg7pGG8cFHgfzkfMULPMUKPfAFhMeQoLx1LpUF+9gppmcHIWktUmhiltZi6myKNAk86XgkLkW5LuIjdHwyidkC0psZNAbqi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOuObWDm; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOuObWDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789519017; x=1821055017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rsEuL8PgT+OXnr43O900lqCdUOlATg3+s+nfN3/AQNw=;
  b=EOuObWDmk0eKwwgI/wABEhYT6iCkCptLzcj1zeX9x/vQ5QHWByzIUd0V
   zOTBPXaEQjKlaeXed7HM27t/F2CWeptC8b0iRa6nyCNUvQmvFLJ9g7CY+
   +ZOjXKa/IOHPVdkB0KUNUWVGUZPi2Km/Mhs300Dw92POkpCu/lBqj5D3W
   ujsJXoqTrPxQEz9x/15+RDqjq6hPF/btLB+xI3fZYwcHpcpM7kn2nqEDf
   lqRM68f3uwy7AVyeVJIJO5FGadeeaZwNWEjaw0DXo4B+OQAmiSZKC/txl
   4uzUUX/RhkGjKc/p+R/DZAICN8gvDPFQXDUIuQH1a/nr0S+39ZbWgw3rO
   w==;
X-CSE-ConnectionGUID: HFsCEmV+Sy68OWGBAeizQQ==
X-CSE-MsgGUID: xfZMFpqQR+CpLdejQ34PzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89917131"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89917131"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:36:57 -0700
X-CSE-ConnectionGUID: RHuAoQgZTPyV3PcRcrbgag==
X-CSE-MsgGUID: GEIjJ1QXTziYGlaaRgiD4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="303061344"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:36:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 17:36:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 17:36:56 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 17:36:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVGeEjFX1LUKwvCsAMvGBAdqCiXoVkgfbuCrpvgAhSQDPQ8p/n1DjeE1TiEmOqkb3oDmuxbBWsCu4zvBMXrHX4668GYuZhXrWV2E01muwDvW/oIKNhoj8izyUlnFV9DwA/Lr2O6blA0aDOvh9TZ/p2fDl3c8Lxle+PS7G/zhTXFZ/qLqS2dcOdxknAimz+EZYgvQ2bCZ1++ciPXKkDh4xU6x98ffXnZgbgvNCZvtQn2Ud16/dPf1x6N1khJZoQN3nw+AC1my6tkFHMAqSFvq+4YJfkBLEZkIuKAT/0k77iJRweUlxDDp8krj1IjPYoWR91NtoUtncWcs7Erh7mADig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsEuL8PgT+OXnr43O900lqCdUOlATg3+s+nfN3/AQNw=;
 b=mY/OWMkfVQXVb6vUqnOJWG9I4LyUg8fxI6DGKwhQJF9yFmhpn6yKP5nqIUFrOg5EhpfFSei6JaYpEbmhZxH41urO8DPIty2Ql5+VUgv02sTwTDzEPYT/+oYEDE9/VTMg1BeKX/CUF4vhQflBCwO6DAi5AWG8twe0YTsjW1nHqCaUy/sG6XJzkj5Bwv8EIfZfJZF0HveKiyb/UvU7VAuFTbvniqNCl+n3RV1ieOwiIYvXL3l0fKS2J8A49eRiDveeJzULtKh/Q8pMNjGB/CvE3AKld269dHe0tJENM6v+hKmDc07QpchM25QvAg/53FwT8kNPPqhJ5OapIXj8xgbNrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA0PR11MB4685.namprd11.prod.outlook.com (2603:10b6:806:9e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 00:36:49 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 00:36:49 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v4 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v4 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdRPRpGgpLmgOIuUaxLUBjd8KBF7bPrRqAgAAiuoCAAHNLAIAAEVaAgAAH8ICAAACcAA==
Date: Wed, 16 Sep 2026 00:36:49 +0000
Message-ID: <b32cd186709b93a02495a1efcb347f8f9533b510.camel@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
	 <aqlRETiO58SWjFLF@google.com>
	 <96c33d465635c1858b943960f09ebd3bf82d31f1.camel@intel.com>
	 <aqnO6spgsfN1UsMU@intel.com>
	 <d071ce6cbb86cffba21ab7b078c3bd0c18fafd84.camel@intel.com>
	 <aqnkHUg3o890LYFM@intel.com>
In-Reply-To: <aqnkHUg3o890LYFM@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA0PR11MB4685:EE_
x-ms-office365-filtering-correlation-id: 6f5642e1-d867-4b1c-a791-08df138a986a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 0ibG2R/6ztkUd/BJVf+Zo+E1SdYVNLF7eSwNfEeZC+5+cBz+TUiNgVEU7a5fA+27DngNJH/b8s5yzwA2yhN4s1XokJXlg8hZSA3Zlvz/xaQ3srXzjew+TuV11V19diRGtCEXWDQHHw168KT6evOyTBFhKZDh0aXn9wHQsGA7JeWweU1cxAI6EwBCI4EkrOVVZDqvLBUYZbR4NV4CiDovf2DQMfML/8ypOk7TLhxZ//W0jjEBL4u0haq5wdJtNGC4k+6OT6OWLwFwzBHnAe+0UXCtHI7TYPTce1ree79dn3dwqeH1DVpFdCLm41ZZOnObQymXCj1c1gkFci40UBzk+CwaG3lAgLgYuZkCBy5G6A6LpDuMEdWcUNR4c84LQ5VTdeoc9yePunnM83YIEesWEbeDOzXySBQyjzSTZMIOkBqdRblWfF00fBLYgyMd9s8Auw1l02BtV6yHJ+G+aSVLV3crfzh0HTMMtL+nizIH0JxOeXA0ABlyAmmytwo8THSaI2SYj5cBwZ6JBHBxUUSmlh1UDRFiaiIYCxKevHB16JrOPAdW09diMN1XLmz1sKiJ3FYo1C+U0iqlFaec5idlUkdt2WDdRn2G3b9MvUixa1VwPmTpUjn0R1VBvrNWjn7PLDc1foClVLRidz08MCmNKNyweG6iIsMXbJ7vH96L4geue6EI0yEcy52t+oazazYNgtNOn4MJE97SNYd+BRqELaUGL+YenhEgGSi136KIxAk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blpYa2M3MEdnSyt1UjlPbHZwSWtBQXIyUUw1V0UwWUlZaHo0ck1sVHlCRDlD?=
 =?utf-8?B?RnYvb21MRzlRcno1YU9kMXBZWmJlRVRIclJkRCtRclZTcmJpb2hhUWtMZzF0?=
 =?utf-8?B?RlQ4ZkxxYndYSzRWSU9hM3E0dUtZQWZpM21RTnp3Q3B0Q2dUeTJzQSs4SmtR?=
 =?utf-8?B?ZWZCakFNWG1QQ2gxaXgrMTdwTG9jZ2EwYlc4NStkY01UZG5kOEk1dnlpRU1W?=
 =?utf-8?B?NU1kamNzL3hHbW9hOEdLcHJpdkEzbE1EUFhDajViSkY4OW95VHNlZ21lMEhI?=
 =?utf-8?B?aDBUcVlocUpKM1hFYWkxOFQ2NjRsWGhNMnUveTNkZ3AzSGQ4d1pvMHF2K1hs?=
 =?utf-8?B?RXpuVDBjTzBpM0g4ZGtBdGVKRWhBTDRNR1pGNHFMTFZQRVFvb0U5VnhBNjhi?=
 =?utf-8?B?dlQ4YVJIOEJXT2tTSzZMRTlNQ2lHQzJkSHNzNU1oVm9BNXZSNXFRSURhekNE?=
 =?utf-8?B?WVhvQ210bWwzL1pjM2VzcjNhTUNpOStTazF6Zk5tTm5HdlhOaC9wY0NyZU1O?=
 =?utf-8?B?TDJROG5rclBDVno3cmtWRkZ1QnR3cjhqZGdZWmNMMG8wQzMwbjMydEJCY0JB?=
 =?utf-8?B?YkNITnVoU3JBbUUvV0M1MGZzbzN5WDh6Zk5jVUVTSmpiRHZlNmNWUHpDeTVK?=
 =?utf-8?B?a0F0R01uWmxNSnZidmpXWUJyL20zc2xMTXVncDZCWkQ0UVkra2h1VkJuT3RL?=
 =?utf-8?B?Q0J2dnVkZUlnbEdFenlpaU5jczZCV0JLMXE3dUd6RWtDNFhnYkJzU0Yzd2dr?=
 =?utf-8?B?ZHZFVWdYbjU4emJpQytwN09jdWE3eTh0a1hBb1ByVTZLMFNZUGswNDFiL240?=
 =?utf-8?B?RWswWUNNNlpDNW1tZE8wVkxnWEp4cjhEamtRUG8zOFYyajlhdnVITXFxNXpT?=
 =?utf-8?B?R3NmV3RHM0pZZU1jUnlaZEVwMEY3dzlEQlBsRnNNdG5US1c3Q21yTTFVS0hp?=
 =?utf-8?B?RGFkL1BIaVhsTXJXOGQzSFEzUGxNdzhwOU12RnNhQzFnR3FVa0o5ejRQNXIy?=
 =?utf-8?B?ZDJ1ZVFSUXNTRzFQZXVUZ2RUR2VDOXZ4RTFHbHQ0RVY2bU50Ry84YmZ0eDRz?=
 =?utf-8?B?bUNZbGN0cXZxNTBvNmpWeVRHbmJER1NGQVV0d01kRWpoSmRoTEVBOWYrR1R4?=
 =?utf-8?B?eTBFbWNkN2xxK01RNkhzNDlGbWkrMTdxS1NuYWllMDNzaUdJUzA1VGRFSEJX?=
 =?utf-8?B?SGI5R2NJUmdDUmpuRGM2TVpDcHVWdVorMjVnTEhDeDFtdzVMUzg5VEo3TkNC?=
 =?utf-8?B?U3ZGRUh2UC83SWh1di9LMmZTVTdySVllM0paeSs0RVFVaG1XRXd1M1NkNzla?=
 =?utf-8?B?UVBKbFpMZVpBbEVtNjV5b2x5L3FyZEZWNzN4c0VadEpzR0Q5Qm4za1kxV0lL?=
 =?utf-8?B?ZVhqOWtRQlNxdlN6VVM3WExFaitGTEZZWEVLMnVwWkNZVTl3U1F0QjhYdGQ3?=
 =?utf-8?B?WDdyUXdwU3J0QlU0a1RiNWtNeUE4K0NEVDlramJHTTRmeW1WcWh5Z1BHRTJi?=
 =?utf-8?B?MUJGRlllcjR3ZkFNM2MzcVhSSG9mazBmazZ4aGxNY2phRkFNWTVnTUdjNVQx?=
 =?utf-8?B?alVJcnZudTJLVU93TG8yUER0b2dWL2h1akVtVEppN1I4cXNvNlhYOHVVUGhh?=
 =?utf-8?B?bHV0WlByc0dYUkp2K3IrMHRKdlNPalpVcWRjYU8wdG43YXI2SDFUZ05pUkpW?=
 =?utf-8?B?QUFuMlpBMTJYN1Q4bUN5WVB0V3pmV1g0eUNjblN5M0xhbGNDc21TWExkWUpG?=
 =?utf-8?B?bzJTaDNKREtPb0gyQ1VTNm83N0FVTytFbVkrM0VtNkpkSlZjSHdBYmI5cHJ4?=
 =?utf-8?B?Nit1QXQ5djJRM1N3RnkwdnVRVGtXaEptY24zemtqRXVWVjI0QW1vUitUUUJo?=
 =?utf-8?B?L1ZmVmgxdmpEVCtrV0M5MUczR3JCeGpkWWFhaVR0WiswYjNZUkorZ0hCNVQ2?=
 =?utf-8?B?cnZkbzc5bGk0akZ0dVFJbTZ3MWJzajVGRFBWUnMzZWk1Z3NEaGV6QmZBVDBL?=
 =?utf-8?B?VEhQQjVtM0NMOFRFZ3RYalpvNlFxc3h2VG13Y1E4SnFQd05VL2VmNkF0clJu?=
 =?utf-8?B?QXRTZHBTZVhnMXl5c1FHNUxDaGIvTDFmaVd4RlhNRTdwQ3hRSzlCaVVYOGZw?=
 =?utf-8?B?UmR5N09KcERBeGk3QW9VQ3J0WVBRa2FVc2pUSW1DV1hWN2VnY1NXQitURm91?=
 =?utf-8?B?U3lOZXpyWVlMTDNuY0k1Nm9JNVRITW8zVU9ER3JKMFIwLy8ra00xa1ZlVk1O?=
 =?utf-8?B?Q2thMTZFazMydGdQait1Q2RTcjZhUndKVXlnY3dGdjErZWhNNkpQNVFWT0xL?=
 =?utf-8?B?S3RDZW1ubXRxTXlYaGRDRWtZeU5YdVMwbW5xSEhkbGdEd1c0L1ViK0YzNTQ0?=
 =?utf-8?Q?gcaoMIYWgT32GZeo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B075DE8F4211F4418D9A8A63488E280A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KzNeuZs9/F5merXG6MYCsKD+OC7TtpFxvyjfcVhuk0+PTZMHj6l7p71Aj2fsSEi3/TMTlqtjbEZ6Cz+P80pF2MJYyaSaVs8daiSSK4tHyQKkzf5hE7/itfJ204bVwmclpFkqbxA6WSJgTknZWx7DnDzJzeSgg3pyj/HxQDt7fUejPE4C1RCIyihfc/Ir2qKPQGGrNRow4mxOd/5sBbjs3cxY2qrQrsXfXwvBjex4HsbOSf5jUUaie38BWyro3CRHkKhS6JWKjXOmgXg8M8dkRfhHDAvcbX3KQJCyzPmFtpk7ju+iTp2MABjV/vAWcGCVPwC28smLjZl+/g+Y9Oi00g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5642e1-d867-4b1c-a791-08df138a986a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 00:36:49.3109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thRmjkER7BuvIwRepA8jw7NhS4nFOquhY1vGY7aRnNe9Xcf4L9xnok/fba9FW68Dp/XmriUbbPEAXf9wWkxc/cSMT+OT+1NFMGnNAHPnzp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4685
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDE3OjM0IC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiA+
IElzIGl0IGFsbCBjb3JyZWN0Pw0KPiANCj4gWWVzLiBJZiBhIG5ldyBURFggbW9kdWxlIGRlY2lk
ZXMgdG8gcmVwb3J0IHRoaXMgZmllbGQgb24gYSBub24tRElDRQ0KPiBwbGF0Zm9ybSwgdGhpcyBj
b2RlIHN0aWxsIHdvcmtzIFsxXS4NCg0KU28gdGhlIHJlYWwgc2NlbmFyaW8gaXMgVERYIG9uIGEg
RElDRSBwbGF0Zm9ybSwgd2hpbGUgdXNpbmcgbGVnYWN5IFNHWCBiYXNlZA0KYXR0ZXN0YXRpb24/
DQoNCj4gIEFuZCBxdW90ZXMgaW4gdGhlIERJQ0Ugd29ybGQgd2lsbA0KPiBjb250aW51ZSB0byBn
ZXQgbGFyZ2VyLiBUaGlzIG1ldGFkYXRhIHJlcG9ydGluZyBpcyB1c2VmdWwgcmVnYXJkbGVzcyBv
Zg0KPiBob3cgRElDRSBpcyBpbXBsZW1lbnRlZCBpbiB0aGUgZW5kLiBJIHdhbnRlZCB0byBiZSB1
cGZyb250IGFib3V0IHdoYXQNCj4gdGhlIHBvdGVudGlhbCBpbXBhY3QgbWF5IGJlIGlmIHRoZSBn
dWVzdCBkaWQgRElDRSBkaWZmZXJlbnRseS4gVGhlIGd1ZXN0DQo+IHdvdWxkIHN0aWxsIG5lZWQg
dGhpcyByZXBvcnRlZCBzaXplIGZyb20gdGhlIFREWCBtb2R1bGUuDQo+IA0KPiBbMV0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcva3ZtL2Fwc3hONGpZZTNHM21lTnpAaW50ZWwuY29tLw0KDQo=
