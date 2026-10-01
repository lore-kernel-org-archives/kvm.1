Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3A6370AC7;
	Thu,  1 Oct 2026 00:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814739; cv=fail; b=DelQRvr0O3gkobM/RjzwXOT3gPO9o6PDJtGeyxL9iXChkvF9A1lNXdpROYWv0ziWKrNdtsh915r4rcyq8X2W0VMw6Z5IrUgtOsORAASs6oS3W+jaz3TzJNNwDB7MD8O4cjgrdbx50P026rrHeMFrDZK3O6GLQdRT8qHIynlhFpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814739; c=relaxed/simple;
	bh=0n4bcaUdcBJ0Sw5YvVrjJrcKbEEQohb6weOl1aucRTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qmH35kIQN5BVts97qlSY/9q9mgWWikoodlF0kFWHZmB/+87tqvebx6eUFm5Q8+WxVcRuLiz21Ccsa2ScTUb+3Nm+xQYjuP8uvhI0oYNHoghbOcGPvs/SrPDLoYUdJ0egMHlE3W82TsEWnlZT6PlglMSz7T4WbWXP535AJ79Ca2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xjb7UQIB; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xjb7UQIB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790814733; x=1822350733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0n4bcaUdcBJ0Sw5YvVrjJrcKbEEQohb6weOl1aucRTw=;
  b=Xjb7UQIB4WJNkTOB7IRgdr8CGopgvw8cu9WxKFA2gWpk0ICUhJlyVKGk
   25Xwoe7v8idGetpxh5oXVPvuzJ1u5cIhR7sfX8j39Jg/AtOa6hnksxQzn
   /LA3YwlSfR0DIfOX/9629qttArifCJE1AmmrYvTPbOvxW7L30FkAQ/yD7
   nblIbCWJDUaRynNIrNj/oCANhDY7+GR9NdIvjN5Yn43T7oUzMBzsp1IuM
   x470LwasJCtfCKEFyNoK5IYpfesvveiTEwhNjli3TPAkz/xtKsxgdFtHc
   wK9/x1mjG1GVd21JEaE87lNuXF2jDAYJU8lHHliO0Cgspp9Ghi8+OIxZN
   g==;
X-CSE-ConnectionGUID: Y3XqNMrMQpmmUwtwxvqbug==
X-CSE-MsgGUID: KYQFiC8aRjKo5HiogQGkYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94279705"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94279705"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:32:09 -0700
X-CSE-ConnectionGUID: HutrB+5dR1WzUoMf9iukrA==
X-CSE-MsgGUID: TM9MoJzkR6On9t8oqiqfAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="279142710"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:32:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 17:32:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 17:32:09 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 17:32:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFOMU39iTVwH6EHcVBuGg70R9lsdGXjuH7ERDSRryamriMM68zVEWzM8LvapSJSnKWQhUqlfYRfxRLptZ9ORBbcQk0WDsi65b/jgExiZgKU4Eohb1jJaTU+M2uINkryGax5fJUfXq3bNYVUpXIktheNf9xwoa7wmSB1OovuF6B6iHWdAbgC9Hab7oe7AUODFE7aOIfCSTSv9+lZIeNNuWN1RnsyEMhk2tH5wv3iS8FMZ4samGjVGeqYByHlLxl/WsslStpEL8Y4KQGHtf3Ry++aImBKRdRjh2JzMlYq3LUwki7C+wjQHcukCxT3vPTIO3+oGHSgAVlcLGvOrDoSpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0n4bcaUdcBJ0Sw5YvVrjJrcKbEEQohb6weOl1aucRTw=;
 b=rTQjViur5Sj+kRJITrkWdRL0TQZTtEiuRsp+/hFO4Vlj95D/4So2y2wU906W/drwZ91T3KwL3kArNRIPk8X6dVu8GM4lbAcIMprVGAY3x8wnSvhPnmU7f5D5YhJksfVxgbE0JkrPdWtWJOPljDR6xiBjGMrySQ3zEte7mxK4me5dJvwiRXeOfTLPQg7H3I6lbYPokcavQZyM93G4WnVAzNDYpTWIekpJDTSrm297VqvcMjGWWejOHREkZ4+7OvCgifXrq5iTutn1kUp7sjyYesDAdjrQ/yFhmKslYJM8ajxAWJxByDG1URTMadL7kG3iUEi46WUwnemL+Jj5EfCicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 00:31:22 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 00:31:22 +0000
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
Subject: Re: [PATCH v3 05/10] x86/virt/tdx: Convert the td_ctrl metadata
 reader
Thread-Topic: [PATCH v3 05/10] x86/virt/tdx: Convert the td_ctrl metadata
 reader
Thread-Index: AQHdUJ5Qo4rXAX7cVEqtEYZAa0DBDbbn1x8A
Date: Thu, 1 Oct 2026 00:31:22 +0000
Message-ID: <9783ae921fc93fcf4d08171a0812fd3545917e09.camel@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
	 <20260930053901.22528-6-chao.gao@intel.com>
In-Reply-To: <20260930053901.22528-6-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB6736:EE_
x-ms-office365-filtering-correlation-id: a8287fe9-0554-489c-61af-08df1f5351ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: vP2b7peZlO4RDMMHvqoUh8lt9/tMqmL3ILBs7ur0HOJrzAb7Df4UlmFodRCJeoA2UsgWzH61mhwm2nmSIwDEWsnDJXWcGAf6OstTnq0mF/Ir8J3STPCvusXwUDNHAMHEWZloTwwpI2s8YA2Os0CQVxOUL4kEjP0ZPoaicG201yk2H/MAJtMpVCinNtiJ4/lzhkgAcXahUoTTI2q5RZ1YlbqVZDge/MPPIF1NJRErR7mA1kmb5JLuc1AxkoPhbiAmpJoj3KFQ6cbtclAT6kf7VzGXSMyeFUw5ZQ6Va5ZEy0z23AR75hr+LGsH3lkg7dQ4fljStbcH3mMVKFjoQTXQW7DW+IguEotY+SiqUU2vYV28ysKCGeTJ8IWMk/6VvxL0Fu5NKiWcROSlLd68mqtzPX1K6TyJRm8h09yb+pFMIZTHAB1FSLcRfelpCbg+lwtZ7Y/PlPkIAg79NgfeQOjpFmzRO37LmHyXwgstHFs2FlacSKK9jTPPju5Q9MTls2mSC8srxSvAr1wxgqMqa/WfgDXFpedtlUXvoq1epUsfLjE3wYNbqQA+XDZHhqb4SYInSK5CSVNOcdcO1/N0tOMtR/oNsJzY+gYvmoNOsA6HOfDEXTQvbpoiL/fBaIeVnUi5NJwc/0TQZBLdjeR77X3guEbrWHpsPOmomwyfeChW1LycS/QoZJPp9Fibe5HVtYfsfMwpTiUw/imF18NsoLWvvGkUZmCJrPEkTW0logo+C6g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nkw0Z0FNL055dWM2dnczNFU3UFcrT1lVUFJQOWRPY3NvTHhEeXZVRE5VVDNU?=
 =?utf-8?B?dnlRVTUzRzhnMHNuc2gvVmxwd3Y3SXJ2N3lxNXlGbmlWUWI3SzMwWmZzbUZZ?=
 =?utf-8?B?RHM0bUdrUkFwdnpibVZ6TllwMmtFS0N4TzFtb3ZUZlRYQW8reHNKbWZ5NGNO?=
 =?utf-8?B?Z0ZUYmJQYnZqYlhxQzRZMHhKVm5jMm5JWjlTbHdjeFd6RndSRHRxT3NJM1Ft?=
 =?utf-8?B?cG1lWGoxYm5qMVFTYjVvOU1xVDREZDN1K0YzSlFwdTRJYkU5VGNvTlp4RCtj?=
 =?utf-8?B?NjNGa1FjQXZGNEM0TERpbDZyVHJWZXh3U3dydlpiTXVJc1ZNQWVLT3RaZlZL?=
 =?utf-8?B?a1BBL090QzU2QmtndjMwOU95RmcyL0dPdm5CSVVDcTJsU1FiR0Eva3RRSHFI?=
 =?utf-8?B?ZDV2Tk1qbjlrNk1pS0VManRQUjlyNytxOWRiRm5TdFYrREpoYVZ2WCtXOW5Y?=
 =?utf-8?B?cUhCcVlGb0dLbFFuTFA3bDZBdTV0aTMrYnE0MDBFNmtZMWQ4VlJrWXg4MWNj?=
 =?utf-8?B?T1JwR1NGa2E1dDVqTTdWUkh0NUZFOThkUWdnSHE1MFk5YU5rZGVvakZyM2tk?=
 =?utf-8?B?ZFY2M3NndktSeEgzY0NsbXBLRmlKR2dVVUczclBtRXNua3dCYys1SWJvaENT?=
 =?utf-8?B?bHdIREdHWndCUXdCUlZTa0FUb05OeFdkS3RrUEtETFlEVUJVYmlXWGkyZjN3?=
 =?utf-8?B?R1hua3pNa1lHekNHcGJnZTlGVmk0KzFWN3Q1SWhhTDFmSnlEa0ovTTZHazVa?=
 =?utf-8?B?QURzM1krelFkY2p4Q2Y0b1AxQUF2ZmdUTmNBcVpJSnVHeDRQTUZTcXVKRkpW?=
 =?utf-8?B?aTZ1U09oY0JMUmNDWVNjdHVaL3p2cmI0dkltL29DTHFqNDBsSU5mdVBZcEE4?=
 =?utf-8?B?YTI4ekpWNElVRW1XbEROVXI2V3hVV0VYSzJJZ2VWMjhoNEQrOGVVU0kvQ2dx?=
 =?utf-8?B?RkMrMUR6Njd2SndMS0FmY1VuSGljdmFGWHF2OE4ydkdTNVZGN0hLY0tXRXgz?=
 =?utf-8?B?dVdzK0h4WlFxdWtCZlZRNmZieHI0TmlDQ3VNVlR4Zk9VZXZGQ0hCNERjYUFQ?=
 =?utf-8?B?V2MwNTF4eGp1WDlxRnhnamQ5SDV1SjNsTkNEN0J5K2hlLytpeEJWQXRVczM2?=
 =?utf-8?B?VSsrZkpnbEkwL1dMekNxNHBkMlVVSHZ3bEJYSW8wTzBha2k4WUhLQklNNE15?=
 =?utf-8?B?b3FsWTRoU2kxUGJVazZOSnhOTTJTOW4rWkp6RzJzVXFpR0Y5VHBoR011aXZP?=
 =?utf-8?B?aG56ZjBtRktaUVhCZ2VKcmNDVnYrVlVkdVpyWnZCYVRqMjNFTEJwY1J3clkr?=
 =?utf-8?B?RG1ONUJpTExxMHRIUlpRM0RTdjlydnJUcHl3ZkQ4aVZkblRxVjNmRC9COExC?=
 =?utf-8?B?QllVeFRkL2JFM3BzZXl1VTFmQy9rb0JtbFhBRFJ3d3p2dXNPNkgzM0lnNTds?=
 =?utf-8?B?KzBaaWFJbXljdk93aWdJRExNNGY5S29mN2JMTUVsSUUyUmY3YnZTR2d6bXRx?=
 =?utf-8?B?aCtOUnp6L3hqVkpoNEhaVCtrTzNRN0Y0cGk5U3o1QW85aGtoR1J1RUpWTkc5?=
 =?utf-8?B?OUU2bEtyV2lpaGo2YXRDWEg2UWd4M0JyOHFMNndWU2FjWVc2UTlsbVRaclFH?=
 =?utf-8?B?cmY4eXd1RHRWOUEybkFQYllHU09kdUlSbWMzMWlTTkRwOVlZOWU2dWQzeGRr?=
 =?utf-8?B?djdhMFJZbHRCN0dPSGMwWDk0ZWYxZE9nekJIVmdMSUhTTnp3bi9IKzdxTzdD?=
 =?utf-8?B?Y291OFd6QWJrK3NoUUhpVEhKc1dNUDBnUXlrRHJBTklmS0lReFlNejBkVE9M?=
 =?utf-8?B?YjRzeWcycFB2bTRDTjdPV21pcUJQSjdLTkYzV1oycWtIRzl6S0RSUC9vR1lX?=
 =?utf-8?B?K2hIVTkvVlJuWHVNNDZuUmR0Sm41TTNOU2hibWVqakdQQ0xLTEpFczlZZjlk?=
 =?utf-8?B?ZXNQQWNiKzhTKzlWUlZya0dpeUtjdU5EWS9SdFpIOURyai9kbFlTeG1KVDBT?=
 =?utf-8?B?RGpHZklkRHlha2c0R1FzS0xLNzN6WldyR1lySUZZUDlwblM4ekJIOW9aSGVw?=
 =?utf-8?B?Y1RHSWxobUVHY1ZuenBWY012L292cUg4K1ErMGt2ZjZxam9nNTU5OTBUSHhr?=
 =?utf-8?B?eUhwUFlCYnNOdGQyM283bEhBZzh3c1R6VWErak5lUlhUZlRGbjR1RURPanJL?=
 =?utf-8?B?OFNWNDVIaXFsRE9UL0JzODZPNVFCeWxFM2JUNDlxM3FQS3ZDSUErdWVtSzJr?=
 =?utf-8?B?TmlyZ211RlZRNUFhTXgxNEg4aTY1M0l3VXdiNlpIRVF5N1orWlZFVkdmc3Ey?=
 =?utf-8?B?bVZaci8zWHFmQzVSTmZCaWdSUmRHTE1UTGlFMGYzZDlIWUwvZTF5bENYbktE?=
 =?utf-8?Q?0GbWAnyzIYOEEOvU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <704E812303548B40BEA5F9C13746C6EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PryZjfHa8HldJxFD/CoJSNZD4uBTOzKlPEXfBtDlc1huqC0TogrMKyhdzZl2lAV6pMd4hnpjL9wOdTFTUZje3U7IDnP8s1RQXqjIUhU/SwXflPQJGvphyL+7mPB1HgYpWnqD8FhZnP6nj7tqtaauVg+KlXIYKqCNKtQTnhFPc4REATMz67Zj5g0wWtgmCAISJj3DCdbCwNIDFxB/b1CGPF8zM/HY7MJ2sZlZM8zGbYYOeZQnVswsNPuqIFWck4QDQUSLBV3pkLSdy5J0RQ6nO2DFVaAKzddN3sVloMhbahKI+VX9lHk5tqGRzvClLVrVJeyIicd12wStfBWDTQXyWw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8287fe9-0554-489c-61af-08df1f5351ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 00:31:22.1731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BmwJhPu4o3NaFjHzVUkgNbfeUAKfFSXDUdpJe28jXYkY+EeDzG9Hg4ny/YtlZTZtenzxQ/VA/yI3nYCaFfX86w4mqlsb+jg8l1dljS3V2v8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDIyOjM4IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gQ29u
dGludWUgY29udmVydGluZyB0aGUgbWV0YWRhdGEgcmVhZGVycyB0byB0aGUgdGFibGUtZHJpdmVu
IGhlbHBlci4NCj4gDQo+IEFkZCBhIHRhYmxlIHRoYXQgcGFpcnMgZWFjaCBmaWVsZCBJRCB3aXRo
IHRoZSAnc3RydWN0DQo+IHRkeF9zeXNfaW5mb190ZF9jdHJsJyBtZW1iZXIgdGhhdCBob2xkcyBp
dHMgdmFsdWUsIGFuZCByZWFkIGFsbCBmaWVsZHMgYnkNCj4gd2Fsa2luZyB0aGF0IHRhYmxlLg0K
PiANCj4gQW5ub3RhdGUgdGhlIHRhYmxlIGFzIF9faW5pdGNvbnN0IGFzIGl0IGlzIHJlZmVyZW5j
ZWQgb25seSBkdXJpbmcgaW5pdC4NCj4gDQo+IEFJIHdhcyB1c2VkIHVuZGVyIHN1cGVydmlzaW9u
IHRvIHJldmlldyBjb2RlIGFuZCB3b3Jrc2hvcCBsb2dzDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBD
aGFvIEdhbyA8Y2hhby5nYW9AaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29t
YmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0K
