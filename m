Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F03AC0F3;
	Wed,  3 Jun 2026 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486409; cv=fail; b=LhlHl/NZDoe0aNtQkNBxG+V4C8djSA+qVEiUMAGn0y97whHuUTHNoyxYt309tVQggzxwLBsOtdbioq6XnmZO7+7Wytj+jvgvf1mOEptKFYrO3AsUEw6H0Gn/w636aPuHCBXOAvD+5nu/O/w6+kj0k+rXgryHh4ENcyZ3u5Y62cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486409; c=relaxed/simple;
	bh=IU14l36+c9s8KWvzCYmXWx2xQ4a4WD3oQuF+c08KRL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mmTKkwY5YW5HyLoiM2MSYn36xrD+xwhH58kC9Hd22m1jz05nYmJpix4e3Cw8lcd580ia/9UPlWmVxi8MTweu3hPnn2ez9K+EnghIyw7AyskUCKp4ZZdjf1q+hWPZa8gE5vwyznW3l0sPcWb//AYCKLBNZE65Z2UB250XAMwD5K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Az4+IBLD; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Az4+IBLD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780486407; x=1812022407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IU14l36+c9s8KWvzCYmXWx2xQ4a4WD3oQuF+c08KRL0=;
  b=Az4+IBLDjnrCl8UExWsrEJLVuRehXcuJH3u2RV6+cAJCgVaXrgpT0lNP
   q59ooSIxKS0oy0QNviS0BxTLp+HR7YMQiKheyR0dWtwTrMW+vx+W0Gg6e
   cnqZIyzdt4427aKPxuw4LZV8sJGNOKBs023FJP7X475GhpvZ5G+64k7U3
   uA2kA57eatzLRiJPPkOJ61A3vYUJsZh3MYfNlEqrF2t6oyz/DtWj8/IBl
   Owiq7wkDQRLVhz5vyhip654tbXN+azjXfnYoICUDKQTmH8Zr/Y+dLRMiQ
   4t2XJOnbzqArHG3bDqVSNNtRYs4usdaSSnfgrYiF/mKEKKKyvCzljdJg+
   Q==;
X-CSE-ConnectionGUID: ytMfMRd3QPGJSMpGRrznug==
X-CSE-MsgGUID: A3OUU14pSnOY1/3OU5gEpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91604732"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="91604732"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:33:26 -0700
X-CSE-ConnectionGUID: Gd6KGsajR8CSAl8z9aNq9A==
X-CSE-MsgGUID: 8nonGQD9TNu/2H91IViIaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="274443602"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:33:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:33:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 04:33:25 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:33:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHn+P3/EUgfbwbWw9Rw9HDzg5/ew2xAiCPXhmZmEYPpXgpE3Y4XBGt634kFC4uZHSdMBUPYNQIz6foksIoeLwWGrvrbtQTtcQ+atu5aCKsFwDOqtiIuojcZD4NitqC2dd/v4RxhWvl4Kl2g58UmKa0sPELNvJAMx1wmRt1cVuWZdjz6Wpyg9NX240CkxIV2FOV4KhPdrpsnECWlb19WJ/2qNNyImuC487PUIfjc7s5nDtuEHvHuhJDQyVkZBKwTDiSDPZ1DUqMFSvk10Gqb8mMO+GK6Zqac/4uAz6SF3ywW0VpAKsg4UHTH+WT9DsqSvzpWmfHVwpWi8eoMt51u6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU14l36+c9s8KWvzCYmXWx2xQ4a4WD3oQuF+c08KRL0=;
 b=xKjI9i1jnVjdmH2xvIQPtH1AqxsODzyukX7FXMcdg8yT6sZ9cT9JK/bJ3Ial+7pd64e9pFEuFV0UYXZ+5vTcAvoQrRDvkRvfOVeQO2PbTZs9/qPbbz/Z/bocgu5oeFcUwwAAfq4qti7aqnZEBY/u6YNXYDGNZt+btgNwNmRh4dcCHvCqAF/jRa60Vs4rD/o6wIEGzjNBadblOQpDrXvIpatzlRzDxHPHQywLS1j34NTS31N01RcG21G4e7bGpcmtEmAVHe+HINKLdooZsk1UuCWklnF1eIJtBlMe2HKTJHCql386dJ+q6Df9mPiLVEwQW97eaytLiwCnhOhBS/HQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DM4PR11MB8202.namprd11.prod.outlook.com (2603:10b6:8:18b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Wed, 3 Jun 2026 11:33:23 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:33:23 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 15/40] KVM: x86: Move the bulk of register specific
 code from x86.c to regs.c
Thread-Topic: [PATCH v3 15/40] KVM: x86: Move the bulk of register specific
 code from x86.c to regs.c
Thread-Index: AQHc77nAWDBCkmxjHk272eO0ZFaqi7YsuhoA
Date: Wed, 3 Jun 2026 11:33:22 +0000
Message-ID: <4acef6fa0f0964260bc50ff6ac9dc16995d3491c.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-16-seanjc@google.com>
In-Reply-To: <20260529222223.870923-16-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DM4PR11MB8202:EE_
x-ms-office365-filtering-correlation-id: c1ac2832-fa36-486c-78aa-08dec163eb93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099006|4143699003|11063799006|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: VyaJ8TnIqvHOlMR6u/k/nlu50mlmB7T4NW0XKRdNIG2BBOrpmEku7N+p3YSrsrtpCrtwNZgwVqY1Gorie9IwbSKTS5ZAla1lzM+zkxbAgzvv+7yf/EwzG3fz0XWHdT8BpTn3uCmgMYC60c1UiD5pQ9bGXyCTQcn4sBtoqLEv49qdkwc6ad0sdiraNu/rXoJ3TT0Aug9p0uZPwEvwQq4/xpjKAYS5A79fe5hdB/O8bVsqC3xw1UE3jrxgAT2khVDgrak45qkAsvees7pVmRIAvlNqfCdzE+9q4Z7XVcKxzN3DeauH0vqJFotliwr5DBBezhaqHx3M3Oo7UM+PVctpSBmRU7k4/A9m2i2JqcXhozCF+qHrDUFjf0pYy7QSI2PYcL5g46kVBOWu+RU2SRKI5cqnuKfn5F8DVXXsDMNrzJhtGg4eWXIqy8Tm+XuxuVFXGMSGF0KxoIEkRA/6V9WojgtQZeiSbauWyA9YwUkZANF1nLU1jM5CPjxN5UfEWeOWZqu+/3lAmT91kVc1tQ8GQpJeG77kn0Bj+Emjvw98RcPa+gf0g/Ko38MBRAMkcYeHTspsAgMtYfFaagCH+Qn0y7PWQkjyVYfVtIGNOdHEaCdy1T94TYYy4VIOTMnnloRZyJyQxIQ3ePzMMyYeCMSeo34uSDFOLB5CoPQ9f91QFE+RUBjnh5oZOuR6Hewf2ux6W4FZUWywcwBRfE8P1jku29SCvUqA89n7p5JE1BjUf7fpi1gJSKFvMT00z0HkSBP5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099006)(4143699003)(11063799006)(22082099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amYxT1dOWG84MXZoL284TzljbmZXeTFvR3lzTE9lZWFMUTVNeGF1cWx3OFVL?=
 =?utf-8?B?SU1qYm9za0xpWnp0UmdPMWZ6ck1rNVYveC8xa1FONFI5bE1jRnZHRVB1dU9l?=
 =?utf-8?B?OEVLQ2RMcjdFcUxuSmZYWStIV3RPaHRIcDFIQlpVTDNNcUNiYzk1clRUS2dJ?=
 =?utf-8?B?UThaeEYyNThEc0pqMlc5NUxXWlVRaDlCeEdjaEdXdnNGRVdhL2JkNkdsa2Yw?=
 =?utf-8?B?R25NZE9jMjhlZjArMHN0N0xVS1J0b0I3OUh3ajE4djdIWEptd3JwSnlxNXky?=
 =?utf-8?B?RldkOHhUQWdCd0xrS1JKYnR1aUozaGtFNEd1VVBtQ0xUVVpkbGp6RWRMN2ta?=
 =?utf-8?B?ZEdFQnNQRGk1cGVmZ29hTUFMRWdvTEZoUGVBbUd6RVJEblJncGVxS0YwWHFL?=
 =?utf-8?B?ZnVNUDdUVW1tZmc3bGRMS05aTjNMdHd4cjVYVWZjdGM2NmcycTBBYllrUGNn?=
 =?utf-8?B?UTRuWWJsOURhY001M0VIMi8wdkltMHptUDVsd1gxTWdjeFRHZ1Z2RW81L0Vk?=
 =?utf-8?B?aVJNR09iaUR0ZDE5cWd2RlFYeFMvL3FkWGV4azNreWh0MUpnTTRnbmUyVG1Z?=
 =?utf-8?B?OEhPRGtFaHpyZEhEd3ZteVBXYk15K0JKbzdWdjhGaTE2Unc4VFduNVh4ZitO?=
 =?utf-8?B?eExMWHBJb1pJVGRUek41MEI5cjY5RmFrZ29GUlBnOWZJbm5rb2YzZ0srVzFW?=
 =?utf-8?B?d0c1enNJbWs1NTZTZk5XMVRDTjQwVG9wSjlYMnFiVkk4V00xeUJaaXUwZE1C?=
 =?utf-8?B?N3hpa21IczhsbkVXYjVwdzZDL1ZMc0R1K2s0T3QzcUcyU25CaE00ejNwL1o1?=
 =?utf-8?B?cGZmeDlqSlZ3MmNpMWVlOWVWRXFsanpKQnA2dW1GaWhlMUhyaTJ2dS9KUVlr?=
 =?utf-8?B?Mm9pV1E1bFRFOVBJNmt1b0lhTWFDbFA2dXE0S1VXaEl0SDllckZmVnFzZ3hU?=
 =?utf-8?B?Ykw3VWNkT0l6YS9kckJTNXhwTjViVUZLLzgyclgwNGpzb05vM0IreXlyamE2?=
 =?utf-8?B?RXlyc0dWQzBSQWxWc0xGaUZ2Y3FCM1NWVzVvditES2cya3EvdEdOZERoam9o?=
 =?utf-8?B?VzRRWXJrd1hEWkxjeVBTelU4VWttY2FaUHhwOEtGdFlXamJRR0wvdlFMOVRn?=
 =?utf-8?B?WTBoNHJPdTkxbHVPNGthZ0Z3WWtFTFlOdmwycUkzZmhvMU02K0NjWFUwV2pN?=
 =?utf-8?B?VTNudW9vU0RFY3JTWTdUQjRDSnNGdGppRVQzSG1nekdEY1dJdHQweEhId0hE?=
 =?utf-8?B?UjNJUmoyb05UN3V5OVhZM2kwWXNGK1FiTDVJRFdLOVk1WTFOcldxK0dQc2la?=
 =?utf-8?B?S0RqOW8yTktJNGZLMTZyODJpaTBYQkJWdW1iS0tEYThyTUFGNEEvNXBZMW45?=
 =?utf-8?B?TlVJaE5KSTh5cXI5SUpkN29EWUUzbVNKK0U3Y0pZTE56d2kyRDZvYlgySnJK?=
 =?utf-8?B?TEFLSURsNmlyRmt5RlJvQ3dyY3FiQmxKazNodHVPZXUxMDI4Ry9Rejg1MklS?=
 =?utf-8?B?aTFiWVFaRWRiK2tnZzVZTm1EcDRQNUJ5bTFVRUR2YkRMaHgxMVNvUm9LN055?=
 =?utf-8?B?WHZ1QmZMUTlpK2RhakMvbVQxRXZLaldYQ3NGUCs4UVc2Z1BPYTl3WHAyeUNT?=
 =?utf-8?B?eXNUZng0eXlZcksrMUpnZTMxUVF3Z2ZtOXY3MzV6K0pNeUtpN2Z6U3JLUVVv?=
 =?utf-8?B?ckdkT0hKeU42Z2orMnMxYUNEUW1WQTgrWE5yZ2Q2TEtYTVBxenp2aW5MSG04?=
 =?utf-8?B?Tk1wanVCUTNKUUQ3b1BGdnR5NjVVNzlxSTdkSi80dGsvajVlWFVsT2ZoNith?=
 =?utf-8?B?Z1ZucEJha2JQNVBsdVRxdUFQc0MrRVdTZnU4S3lUa1I1M1dod1VDTXdaYU1W?=
 =?utf-8?B?M25wN0hLRHhWR1pFTytCd240aW5nTXZvU2x1TGxuNmduVHdIaml2aHlFdlBm?=
 =?utf-8?B?MWIwaUJXdnQvaDJzZW5xOHNISEFMb09lenRwRkF5MFRHeGx6NUxXdDk2VGhZ?=
 =?utf-8?B?SHZlbnYvRGZrODA4TmRFZjJIeFdyUHQxU2tnVDJkMDZUMUJtTWNyVEN5T3pt?=
 =?utf-8?B?c1FGeE53a0VWbmlncGozdzY2UHJaNEI2bW42U1ZnbnExYUNMTm5LRHBnNUFI?=
 =?utf-8?B?UE0xenZtbjVjQXdQUFdFZkNxTWdsVTZTWSs3ZHJ1eDdzM0dVYXZOcS9Ta2ph?=
 =?utf-8?B?VlpTRlU3Q0kvK1pQVkh5bFZ6ZnJHYUV5aGE0MHEyRE0zSEgvZGRJWUJKaTJO?=
 =?utf-8?B?MWY2QytxTHVIcjVudERVNjhaYjdKQkJORm1yT20xeGJSYXFZZ0FWbXJHYXFF?=
 =?utf-8?B?bnZTSnZYZ2NmSkpUbkFRaWZDcmZiMmhaU3JRZDYxdStJbDk1LysyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4ADD2E4A4E39849BCAA68848A814726@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lBwAIDoWwnjk06F2kuHI6R2KLkfRXhIXwvbuz5bFK0ZEmouvOeYrDeRBH0iPq9RhiduNbc51YySr37Wv1Wd3hS6mBZlu7MKcJWUXA4sgxQaQCTgTtUKRWNCfVxIdQRTcgA7deac80RNbHFg44USNTGn86YQE7/QxSptR/dkW9OVr1nCH+iUQV4PZV8h+Mzz4tK49Vejn6KK/z6YoQbEUfRmFE6HQwQ9HmPID5LgMbollPr0Vi7U8TxPvOOe9zyR6qpmwwmpRr0NVpv0Nrx9vV7Iu8Jrh9wQkd6YRCxKQ/OGnYF/6ksSynBb805iV3Cg9JNLivo7xhcTK+aLAL2g/Fg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ac2832-fa36-486c-78aa-08dec163eb93
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 11:33:23.0187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFbxTj37kYrNkF+dqu4aP1C9jF2oJAY74zLvcjLYavpYq6r43pnDwk+oTVH1l99ihd5HCWER0xAhhPA2rGHhGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8202
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIxIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBJbnRyb2R1Y2UgcmVncy5jLCBhbmQgbW92ZSB0aGUgdmFzdCBtYWpvcml0eSBvZiBy
ZWdpc3RlciBzcGVjaWZpYyBjb2RlIG91dA0KPiBvZiB4ODYuYyBhbmQgaW50byByZWdzLmMuICBE
ZWxpYmVyYXRlbHkgbGVhdmUgYmVoaW5kIE1TUiBjb2RlIChleGNlcHQgZm9yDQo+IEVGRVIsIHdo
aWNoIGNhbiBoYXJkbHkgYmUgY2FsbGVkIGFuIE1TUiksIGFzIEtWTSdzIE1TUiBzdXBwb3J0IGlz
IGNvbXBsZXgNCj4gZW5vdWdoIHRvIHdhcnJhbnQgaXRzIG93biBjb21waWxhdGlvbiB1bml0LCBh
bmQgZG9lc24ndCBoYXZlIG11Y2ggaW4gY29tbW9uDQo+IHdpdGggdGhlIG90aGVyIHJlZ2lzdGVy
IGNvZGUuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiANCg0K
UmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg0KDQo+IEBAIC0x
MjY5MSwxMSArMTE4ODIsNyBAQCBzdGF0aWMgdm9pZCBzdG9yZV9yZWdzKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSkNCj4gIHsNCj4gIAlCVUlMRF9CVUdfT04oc2l6ZW9mKHN0cnVjdCBrdm1fc3luY19y
ZWdzKSA+IFNZTkNfUkVHU19TSVpFX0JZVEVTKTsNCg0KVGhpcyBCVUlMRF9CVUdfT04oKSBjYW4g
YmUgcmVtb3ZlZCB0b28gc2luY2UgdGhlIG5ldyBrdm1fcnVuX3N5bmNfcmVnc190b191c2VyKCkN
CmFscmVhZHkgaGFzIGl0Lg0K
