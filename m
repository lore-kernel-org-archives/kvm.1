Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9443BD237;
	Mon, 13 Apr 2026 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079497; cv=fail; b=STR51MvfrGnUUQbaSvML54lvKcACU2ujd6ZuDujVskws6fl7wXI/h2ZKd4VlENHZekG527RKBrRF+Qs4uxxrRDqfWZM5bIwiSkjyE3jIVaSW796YBSR/1bpN0UMqor0jJ1UbV1e1G4lM36EUugzgHECfOQjbPtraZiHU8lK3nfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079497; c=relaxed/simple;
	bh=kppYOYIUgrM5K3FMheexgf/KOHp6k6NHGXjarDw+C78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pzqSs0mRXSe8/gxlsP48U/RUQpqidHcmr1k1XZExX8o7MctVN4cK6BjxX4cE5dB1cLCeEWRDthcVcY7Eu7WXJ93MBdmX3zlMr4P81FHI4VOklJD3XgS+k/PUm+QdWyTKnfNdaQ8mnsDDcOTNkE2Vx+11rSYKzouafdTm6k3F1eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YCEaCF1O; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCEaCF1O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776079496; x=1807615496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kppYOYIUgrM5K3FMheexgf/KOHp6k6NHGXjarDw+C78=;
  b=YCEaCF1OZ+inSrytTub83eJ0Lstc6AkpVKPwzLRrThAPJqBk5vFLleug
   CwvUsxzYAELBdzhirqNi8Yz1KDxuPGw1+iZY7eKsbizA1+9Hdl/0P3Igl
   zZS6BJ76sY8oprwQqe92zEku/rPzN0WZEG+H0/gIEx2OseQ3uq7pauWib
   tZRNH5csU2vj34Oysfwj4ajbX08GA8MLMXe1znUVfRl5H0614veTpqHko
   O09IHcLsXOYJs0x5yHxdsq5G4sy4hm4x0+UXsikZGzSb5dxkrhNMITcgo
   w43HDTPNgfZBoaDusrPr8i/91kxF3UImvV4Tn200TbP40Dbyro4AUw4e/
   A==;
X-CSE-ConnectionGUID: mk5wLLavRFePWs9CBIOjbg==
X-CSE-MsgGUID: nJEaxn+3SEqLlZLrjuRWfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="94402912"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="94402912"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:24:56 -0700
X-CSE-ConnectionGUID: YOafnAIISxaLJGjElhWp1g==
X-CSE-MsgGUID: vpgQRehGT6mbSifWdUztjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="233793797"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:24:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 04:24:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 04:24:54 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 04:24:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4Iqt30a4t5hNzGyU9VeC6Y5uB9wOnDlI51UoY68Evt93JQ4pXFkL0bXnpOtjnDsAGOHiURYkD4DqSX8+i+f1nWw3KqsYxzYeGLy4NsWKJUpjQQSbP1Qb/zryFyYEe8ljFYWmJAZawscSFKJXz7HIzgb32BGHsKTQ3+Y3QdLZstAVoeN4J+hReLCQa1yS/GGaYY7r3Y+I5qT65l5RagBGwCJj+xhHAFojUjy++4CSx9dLjcYAd0+DyTgTTLm0pnMsdMkRto/DEYdsacF+UkWx0ZZwUnJWETWEodAmAC+zkKD8VsKpGSqyR0hTKmZHrDLeqAnIKuaCbLoBab5viMAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kppYOYIUgrM5K3FMheexgf/KOHp6k6NHGXjarDw+C78=;
 b=fCceaWsQ08NdL684GQ0NX2sCd76nzSvfKarjLCduKdbQzKO8dBkq4J544YlBK5HIYmI3bdtmwSn9s6Afh6Bi8jv/c73934wKG0Ghd4KmaZ/NqetS+97Ej/nU+4NCCLYCDKdYGWB0E+Qq2wWTAkkoa4wOpIF3wKzgmky2+3jHZerApjjdpgCdcTxHBdKIS3NjtdpIGDd/hEeCVwe5QkqzSAOlmyLtr12cxRfiqkUcfB66EY2+jTk88st2kh0opn1jc7yGB3gLzPu9P1l9mP8PmatXI0KuBroU5IFSA13ybSgPKXTb0zQgKZM/fI8v65HK4QRwE2N59EFXpw0R5p2/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB2647.namprd11.prod.outlook.com (2603:10b6:a02:be::12)
 by SA0PR11MB4671.namprd11.prod.outlook.com (2603:10b6:806:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 11:24:52 +0000
Received: from BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::32d7:4779:29d3:a1ee]) by BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::32d7:4779:29d3:a1ee%4]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 11:24:52 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bae, Chang Seok" <chang.seok.bae@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
Thread-Topic: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
Thread-Index: AQHcyHKA2qiN335YikKlMB8aHxcOdbXc32MA
Date: Mon, 13 Apr 2026 11:24:52 +0000
Message-ID: <4b7b648627a50b82c6a3943595c6a480f0f9ab9c.camel@intel.com>
References: <20260409224236.2021562-1-seanjc@google.com>
	 <20260409224236.2021562-6-seanjc@google.com>
In-Reply-To: <20260409224236.2021562-6-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2647:EE_|SA0PR11MB4671:EE_
x-ms-office365-filtering-correlation-id: 9fcbbf85-bf85-4146-4cb9-08de994f4813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: OApOzEoC5BJqyIfVeQL1y/5FdRNIcJ7THG3bxvPGK/pHZ4iFLKIPB+lRb+pvzJSQros5Ktg/FCQVgn6JsTxuKlT755GOkIahWXVoU5GEsqssaLRy5yIzlg7dULgCHDHM3LMqkYLKVi3g4KkeGIsCmAIgS8Dj3bGDAMFpJi90WEjMS81zJu4xvrdse4jD/mIQO8M0O/g9232CPxgLLvtWqkmjFWS9qBTQipqR3sVR0j2w6PRRJpkh0ioRLd8BKPQ71rwS8EVage+0RqzGPOfEjdfo/RPj3qh6skEWdPP8c+B/vEt5ZcPf5y7oOPmqGcRT3wCDRI9DHgJPbe70XJJtHyoL/1dZ6wvk5cdS9UG059UFCxaWmIoVFbs4Mgi92QqqKrSgZbKrx/Ys35xYCy6ooksVProqcRkKjeNQWiyzcswV6fGzy33dlypwQ9cQx19U1wDRWXWhFTrHJxBLzalgTCf3zRtGcMMYs6wCuJm7gYaUgvlUiYFvow1MnHx6n07J4Fo394E8/WzeVLTt/M3NVkzcJhBfUcMy7kUeYda+7ADkGlVjt620ukUTQqWLJCQSLfBJyyFSgt0LlFcqBme446podgQJFF/UtkwQQ669B25wzw5PH8G4NI0ISu4NjYo7SY8dG2QPhAOpu5avKgJwD8Sp8Nu3RG/RBKhr5R7nKnzFZGbu3H13nefiKFv/S1M6zRgrszHJZFmcDb9GKL7iS6ttp+NzXJKxYXJ8WnQRkFfTi/bCoO/pqFT6GhWlhEmuNaVs42Du7yBFYP3+vIxWp07pl7y84kpdoyzuYGdY/p4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2647.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm9BRUl0Z01yK2xVMUFOOUZlMGtEd3p4TlhyWTRUQmVkNzhITHpZdXA1bkFU?=
 =?utf-8?B?M2F5cGVZSkFUWE5MRzZjS0JieWZWOVgxei8yOWw2elc1b3JwamFvb3FwS2dU?=
 =?utf-8?B?OE9RY3FnUjBtZmRLdmpOUlBjd3dTUzI5SnlPR0d6OGdJZ0dSMUJJUUpnUGdp?=
 =?utf-8?B?Mk92aWZ3WHQxY0o1c3YwT09TdTJzdHE1RzJDMHFJNzhsdEF1aDJQOWdWeEtG?=
 =?utf-8?B?MFZ6dUsrTFVvQXZaUkJOV2FuUEErYmN1aElPSlVRcGZESEJKY1d4MkQxS0VC?=
 =?utf-8?B?b3B6cm9MdXQ2eHExcTVsTmJFaHJ0bUNGWC9MQnVEejh5Y1cxbWVOQnAwamZh?=
 =?utf-8?B?MEFzcDdhRXQzdDAyQUllVG9xOHBsVTdXeEY2aCtpMlFDMXF2SnZaUXVEa2h5?=
 =?utf-8?B?Qk9hUkRYN1NFZ3ZYTkN1Z0RoV1NlRzh1aDF5MjhHaXVuaGYxUW9rUEhQR3pr?=
 =?utf-8?B?dGNKeU0xWFN3cEF3QVR1em5hZFRLQy9ySE9xOFo3TStVU0swUTBhMW5QM0hX?=
 =?utf-8?B?b0QvYkV3TFU3WEFvZ0xsc0xkTkRHZm1LeE1KWC8wL0RKOS9pWHBhSGpMclJT?=
 =?utf-8?B?MUgvV2lJbnhpTlNYekZDaDdPdEhsOGRFb0VKNkNSb2dPajA3MnhIRWNzNWl6?=
 =?utf-8?B?VTBxbVhscVVlc2oydldoSjZ0TG9GV2xhd1J4cGhVNGdjMTdjWXhaUzBkT3lI?=
 =?utf-8?B?am9CVUFDZXFiOUNJeS9IeXF2TUh3dERJaFFvR2dzaU5ZN3JteXBMNS9LU2JP?=
 =?utf-8?B?SkJSYzUvOUlHN2Y0cm1vaUtyc25NMkpLNW5xOWEzR1RLTEhWcVhQdC9TaG9k?=
 =?utf-8?B?d0lYVlpTYmJqYWJwdlk2cmIzYVNKeWNBbWpQQzBtdmNwWFdia1BmelJCWlA2?=
 =?utf-8?B?ZFBLL2gzdzU0cnp3d29oS1JKbXNnbTJLbGsza1Z1bzh4TDRVTjRwV2FyRWdI?=
 =?utf-8?B?VVBuM2tXL2tlZVhVQVJrWFN1Wkt1Qkw5N2xxanRwSnpTcExMbjQ3Q3kvUVJH?=
 =?utf-8?B?TXdUN3drYU03ZS9MYVBjQkY1YUh3TjVkNExNMFVTdlZGY0NaNnROY1ZVL2tT?=
 =?utf-8?B?YkxlUlhVMGNUNXdFamhnMVVSU1UyUzZEWXlpZFBRUVkxWjNHT1lhTlg0YU9O?=
 =?utf-8?B?QUhEKzZ4VHJQSVVSTGJLUWRXYXJxbkNnNDI2b1dFQ3AvOGU3cUI1aWVOdXBU?=
 =?utf-8?B?ZmFlNE1qazAvck9RYjVMU3UvTnhLTzRpTis4N3VpbmUxLzFSbVNUaGJlb1Zj?=
 =?utf-8?B?QnRDcmhsUnBTWnJEUEJ5U0lTd0FuOGVSVlVLN1hTY3lUbVlod29Gc2pscWR5?=
 =?utf-8?B?ZGxWS0MrMzFxdnJFOVBCRmZ4YUx1L1A1WVhDb1FCVDJQZDQ3M3M2U003TGRs?=
 =?utf-8?B?QzhMVWhhK3c0WGt5RVRtN05QZ3poNE5EbHhJRDB6WWcwUDRtbkhRS1lqNWE5?=
 =?utf-8?B?UEpnOWtkUjFmNUsyN1lJYTk4Ukh3b3ZqeG91MTliSGJUM0docnhGZGU4VXNy?=
 =?utf-8?B?MzcwTVZZWkRPNXBoSkZ4N2JTazgzazcwbGN1aG9YVDRTZnZqeUtnNWdFMWNh?=
 =?utf-8?B?ZE9tMi9ydEpyNWMrMjBTUWtzY3ZrSUVKbmk2Y05jZ2Nmd1ptbjZvcDNraTRV?=
 =?utf-8?B?Ym1WbmxzOHNxbU1HbnBWOG5IVGxsZis3RmtrSlN2Z0FqUEJvYkdSWmZsVVFk?=
 =?utf-8?B?VGxzWHlBQVFDYmtvMW1jY05rQzNGNnMxWUNpK0swVU9GZnBFbzR5RFhNQTlh?=
 =?utf-8?B?NDIrTi8rekdYM1hvTmxNRVZTaHY4S2dISjRPZGxPNW5hZkxQSTc0Mk1OaGJ5?=
 =?utf-8?B?ek5lWnZ2RUFiV1dQODlEcVZGaENGUWxSZkJ3YWx1ck9wTHJHK2VMajlJdkpv?=
 =?utf-8?B?cC9aYk8yMTVNWXBJTXJwRFhiK3k4TjFBdmdvMVh1NkFPcUFXeVNBemFSM2xR?=
 =?utf-8?B?U2JYOTFNSVd1bjI5cit3TkVFYUZHSUVtQ2EyYXBxKzJPUDNFUktWTndpYlh4?=
 =?utf-8?B?MEdPakppcFJqenFZN2NqNDMvV2RoVnk0emhvSWR4NGp2Tms1MlBjRVhBWkFs?=
 =?utf-8?B?ODU0VTBMTm5nNDZZSTZpQkFacG9HUFgrd0dsV0lHSC9zbmFFRitHOTZCMlJP?=
 =?utf-8?B?WmhrbWNyNG5qZHhGSUorQjFQd25IdjBTazhJNUVrdVJBN05mNVZQejc2KzVa?=
 =?utf-8?B?ZGVSeXFpUU5OUGJ1TXAwVDdZeUdhVmlXM2dNT2RIeFFOaHY0NkoyNG5pTkJE?=
 =?utf-8?B?MGRBaG5pYW8rdVVLVDFBY2RqVEFuVVVEMDI0SEUwMzU4aEIxV0dldkZYdkUr?=
 =?utf-8?B?S3c4V25oYWR4N2hIa2FYKzc0RW9sYzM3WFFCdzlUeXNoNXhLQjB3dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B760C94BD539D44A9E656D5501F24B51@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mBQNdRyzST3wZaTfugOMYLAIOC3zeZUc56PzRUUa+XAC6U2xlnmQ1XL7YVPlLH3uiDEVzt/2VUN8GOcHT5b2GW8UOwmJMT3RIcBpkUhTQITZMkPrtn5hBDOBzi5OC5BG5mmuU3UL6coFK3ScdmbkInQ1Iu2HFfs1vwAkEZLe/D9JLLaXztITDnqtI9KRqug2tmhTRK+JnSvDlT+TUFVDzDP8JYefgqiuSswVxH8O5ozg2tO0XeGen+QeRD4csKXM5W1wPqVM4exFVEc8lRSNwxSjfpo0k60XZ/U/QKcX8+cj2TrE8KoCRlxBXUWaMZ91EWUNYrMv8LFJ9/IAgG/G/Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2647.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcbbf85-bf85-4146-4cb9-08de994f4813
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 11:24:52.3768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+JxjKc9oACCA2w7zoLJv69rh/sNb8czDcPSnRKOAG6tGcqhBf6M/5DFOvU7DYD5igQmK5lIwLhg2SVVPSIjgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTA5IGF0IDE1OjQyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBDb252ZXJ0IHJlZ3Nfe2F2YWlsLGRpcnR5fSBhbmQgYWxsIHJlbGF0ZWQgbWFza3Mg
dG8gInVuc2lnbmVkIGxvbmciIHZhbHVlcw0KPiBhcyBhbiBpbnRlcm1lZGlhdGUgc3RlcCB0b3dh
cmRzIGRlY2xhcmluZyB0aGUgZmllbGRzIGFzIGFjdHVhbCBiaXRtYXBzLCBhbmQNCj4gYXMgYSBz
dGVwIHRvd2FyZCBzdXBwb3J0IEFQWCwgd2hpY2ggd2lsbCBwdXNoIHRoZSB0b3RhbCBudW1iZXIg
b2YgcmVnaXN0ZXJzDQoNCk5pdDogYSBzdGVwIHRvd2FyZCBzdXBwb3J0aW5nIEFQWC4NCg==
