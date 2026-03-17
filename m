Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0507F345751;
	Tue, 17 Mar 2026 23:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773790178; cv=fail; b=WNe8ePjstftw5dVINQT1Dd0XOTfbeIw2nqnB2OX80X08Z8Abn4SJO/RxCzGrvSVulxnlk7MkjUelGrWrWoWmNDyNnpvpi8BtOH2Eakg6IbgCKmLyvc6+wnlaPDsPS77DtSmQNv/JXgm1JoPOndRQ/cjFHL5SsO1Q/gUz0yrX9jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773790178; c=relaxed/simple;
	bh=4FxvC2ADX/s8z84g4193Yay5wjELLgCFkZfCIYm57z8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R18+0xbySYpa//WSSwh1wSW3XwspcNmOaep6zEjPsPGcWMdgqh6KAlkWiYbginzfxeKrd4P9qvuVlmRQFWeqE1nSVIR2rJfq5C/BGoGSzAlP4+MJvX84nRQBsVudkiB/Ui3ndmt2jAbVY4d3IzRfZgU+RUCcqRbbpVMCVXDrkng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfsLHIiU; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfsLHIiU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773790175; x=1805326175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4FxvC2ADX/s8z84g4193Yay5wjELLgCFkZfCIYm57z8=;
  b=OfsLHIiUSDjwExA3bSv1XK6xuu7ylHAswXS/KNgB1RuWN+edjOrH+Eia
   R5KAhCHVg2NP5MHdc7xFeBXXtL4bOpiw86IWYfWP/a6+4RJ2qw4eU1H/u
   rpH/69eG/60o8a9Ru/JTJQcSRF+yYI5lstgVA1GmNRuTMy8p+vMSlUB4t
   KyuYFCIHZOdt8h0RpPlkraBCDcjS83Js/j/dSFP3gVoI3O8xztOqVANke
   3lovfuUA9cYb2U/kL+mabNjGCtDLwahXzLsV94wzdb3PWyDUgkEcvgAn/
   UWMNkdK6hcb4pPEFB9R+4j5uDR0gYU9oxI2zCxLr6a7y+1OKxduabCkB1
   Q==;
X-CSE-ConnectionGUID: 8t8+bL1mSeCFuIOUwOVK1w==
X-CSE-MsgGUID: t/7EzsUcTcSYryZJpxUrwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="86196308"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="86196308"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 16:29:34 -0700
X-CSE-ConnectionGUID: UXCXZtY6R6uMTcif3Gn8Dw==
X-CSE-MsgGUID: NeZtadWqTd6A+ve+l+tVuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="227383578"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 16:29:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 16:29:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 16:29:33 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 16:29:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCzLCBztb5Kt2T5ovGkd1jBjD7HbgOL6YxQiwADLMxYp9He4DEgdIhwbCBW4+Gv2smS79TBc9dVb6U6l7SYkWIU6O/Ef5IaXesLxRbOlIYE0jV68r9J5+kna/hT6ynaepCW+KE9p7xuCbM5aAoE3/OVfHl2ZXHhYQlc6j0l1hqcMtWqxaeTkC+dk6nG/6I3hoVUa3I8ks0NtOQT8EVcapEz74KEG+Ff3VndzsN+4Xz60Kvay/kR8gviRztXQahdOoS4USHUn+O+cXWtJW1QBRK4HrTyeRwlhpCS8AfjmZ2Sx+mFfRZ7UaXGr3MI3m/IyhsWYRkaifzDYVKCmQVLuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FxvC2ADX/s8z84g4193Yay5wjELLgCFkZfCIYm57z8=;
 b=LQSCwqyzzw7KNhhwFEIP/XyNct9y2ywEdEyoWiXXvMPFJ8vpOElAoHnmprBhkzhr7iS5HacsJnM82WSZUf0JuPG3raY7lujR81EpIZdi54LbFZMVN8Sgmxp7hhaJYBJ0+lDl/CXgLlD0TCNxDauI6sS/7XD3s+r8XcCyr/Hkql0OH4oDrAAtMvbR3LbRRB1AB5Ueum60Bbc7KHe7HWKX9PyJQawXRm7KHwBJuupV93E4yfOIipaOtzF7LYeCLbxJ/YBwzTalMeuoIQvTWL03CqKNE/aEpWNGYGmaHsDbClewYvM5+qQDqZFR9oxWr9bXx0G/EqQI05cuXMgO49Em/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CH3PR11MB8185.namprd11.prod.outlook.com (2603:10b6:610:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 23:29:28 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 23:29:28 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>
CC: "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "stollmc@amazon.com" <stollmc@amazon.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2] KVM: x86: Use gfn_to_pfn_cache for record_steal_time
Thread-Topic: [PATCH v2] KVM: x86: Use gfn_to_pfn_cache for record_steal_time
Thread-Index: AQHcsU1HyUBTvoy+gEilD/AOh29t+rWrmwUAgAfOKIA=
Date: Tue, 17 Mar 2026 23:29:28 +0000
Message-ID: <a7509dd49c1cf3a1f1bae19f08bd35b45c314653.camel@intel.com>
References: <c73bc1f22fbdbd88efb21cb80eccdd98d2ea531a.camel@infradead.org>
	 <abNXqMq3wx9Yq94h@google.com>
In-Reply-To: <abNXqMq3wx9Yq94h@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CH3PR11MB8185:EE_
x-ms-office365-filtering-correlation-id: 92c90c8e-b37d-49d4-40db-08de847d0897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: qqECYMQGgXX1oTweWKhiU4rKVjQWP4kVwwai408FXSDaWOkSNFDEIYDr5D/aV+qcqp67vvmOo97pdcmiC1LrPA1JeOokZjs4dQtjjUVFCbLK/cBsRUiik0pLyINR0QhM/1m0EH/lhOClYhZouKFa//7GnFoVesgVMhcOEoTQdCaKru5yRfDES5g02jO9msvx7uBNumxpu7JrVOCxGkShKZsj69SDWxmCncp70IeNXdWXDHXQ56js35wUMgJWh1CZkxr/jCp87SWjVof6e2Yk2KYenCoS6kebXZ4YFA1XmjPPemjhZ2Q3kYEs2mobEl0wW2sFeeRwcmO7lN5xvDb5Qdt8InId4wKynJ3Bl4sXIxo0MD5Mz/l05GOYUNg1LByzAGzQWTYsXeOCNVjZYfTs5T/k71H5HGioS6jGI9EYuuLW8SDQXGg3jEc9Y9p9rDT1R5BrcY+BWvobLY/siAuYuj6DMFi3Hvb6O1cpKWzZSeBYlxHG18qR9nR7JRyVC7wtcZfJXcT0D3v5H+rsyzBQ1sjIbgo+o0ZXG0npMgcsgkhLEd4kdtobEec9chIAxcsy3Y0qjKqwf2lKo/myNpccughg7czLaa+c5j0zlvb+cURAYD/F1W9va44/GfiETw0KFDv6j1jwMCeKQbrcaxJ3BCkC5OIaOmMKc62qDFl0Tiztw5hCV7rCaLNXjaOMBN1BtRRHrBOODC169WK5vkGALSF4dCPTMSq0FgeqOjWKxmW2kVh47Lf2Cd8jSgPtXMLQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnFEbFhNY2l4UHMzVjhJWUtxRWtmY0NuNXk5aVZZd0hXZE0vVnJPenNmK1Ba?=
 =?utf-8?B?ZXUzK2E4dUJBejE3ZnZLVjhFQ1FQSzIwVTQrbFVJSzdrbEgwLzdkbzdaV1U3?=
 =?utf-8?B?aFhXRURud3VKMnBEY3ViR3htWHl1eCtRSm9qczh1VzR5K2IyVm1ORE9yYlRx?=
 =?utf-8?B?NVZsa1VWeTZOdXJaTXhGQmxsQm5CNitUUDQvaXEzaklYVU5nbmFDY1dFM2VQ?=
 =?utf-8?B?ZldGL3E1bm00bzM3THRscVJveStuTUhFSDd2WDJDRUg1bkJYUnRseWFyN2x6?=
 =?utf-8?B?a3RtVDNWNE9mSm16VlpxKyt3cWcxOXBUVUFOWS9Nd01zVVNNNTZVTVpOeXl3?=
 =?utf-8?B?TTFXOWhyTkdyangrOE00eDBiQmFOK1JMUG5lVnZhOG9rMUV4L2g3OXI3US9H?=
 =?utf-8?B?R3lpN0lkRUVHSnNxYXJKaHNOTmc1eWtYS2kzQ3N0VFdDSFMzT0tyOERFYVkx?=
 =?utf-8?B?bllON2VWNmIwazZubzlTclhYcFBoeG5UdHFvbHplY0VBWmZqdGx3aG0rNmZJ?=
 =?utf-8?B?VWUzdEQ5WUFyNFFaZDBDUXhIWGVIQ3RESTFLMVVwbnArS0k2bmhoS0FoRGNS?=
 =?utf-8?B?Um95TE9OMEhyNzVrQWJnbG9sUzkrWHFWQ1pZQnN0YnBlblIzbWh4Q3ZQYWpw?=
 =?utf-8?B?SWxxdEdGSGlyeTQ3ZXhCekJLZjJKU3EybTRlS3JDUHFLbWhEVC9zWE1kZ2VN?=
 =?utf-8?B?Q3lYTnVzRDBhcHovSTlRUnVQa1hsWEdHRVBUSlJaMXFmbGl3bm44K1p5dVRO?=
 =?utf-8?B?U2FZVEljK2s3d2lORlBabE5wVUs3WnV4Y01wWWFXQmFycTZEcEUvM1V1NE1T?=
 =?utf-8?B?dlpWQ2JNU1dRcU41MVNKUUphS0hUZHBTN253cTJlYktKNWpEMGs1MWVqdGEr?=
 =?utf-8?B?ejhQRjY5ellCdVFNM0ppVWJpRUVna0RWSkw1dGVQd1pJRm1oMUdTV3NwU3NM?=
 =?utf-8?B?UFdkM2dDb1g0SHl5aTBISzF1VEt2VXZ0NHdBU1dYYWlDQVFhZ2h5aU4zcVNU?=
 =?utf-8?B?bFI0RjdnQVowTlk1d0o1NGMvZWROblNhOHEvaWRMMk5Nc0FzY3ovMGxFeHJr?=
 =?utf-8?B?V0VVdEt3TmNQYmVUYi9lU3hSSWNWZEIvVFZLWE80VGxqMnplZ3ltWXRJZkJ5?=
 =?utf-8?B?QkRBRjloMFRoY0s0dngxMzZqRXlid09NT3RjMGhGN2IwVlp0WmpOeFQ5NlZl?=
 =?utf-8?B?dTFVNHhsUElibkwyNUxtZ1F1UFdOc25WMTFWVW10ZFVnMFdqQk14a0thR3BS?=
 =?utf-8?B?UTI3TjJrRWN6d2JJZVBDbFZTVnNDZFdXZGZmKzBlOHgyRUR0ME8xb0twdjJs?=
 =?utf-8?B?dWgxblVYZ1k0RmRqN1BJNnhDVkVKU3VNbFFST1FhRWNHeE84MEVKUWhvL1VF?=
 =?utf-8?B?Q3FJMHNLdjlSZ3NyaThmL2NjYTRGRzh0eXJiWnNoNVMyS2JQVEcvSjJsaWEy?=
 =?utf-8?B?SnNqaWIxdXJlQ3pWdFNFcUhLVUFXanpRM2FFSDd2WUNreDVHMUJWUHh0WW1J?=
 =?utf-8?B?ajF3UG9pOHUzeFRvOVMrN0RzZU4xcmJiZ0pPT2pqSmw5TWhSVkFKMWlwVkdw?=
 =?utf-8?B?THdSMXMwRW9vVkVCYUdRa3BIOGtGS1AyUy80MXJ4WWdYenRDdTM2Q1RxemNE?=
 =?utf-8?B?dGJyVDdyNVlJRGpCcG1YdThFUnE2Z0tBVnNqZ3IzMFJVclJGbzVNdnlPTUNv?=
 =?utf-8?B?ajRzcjZ5RHVGemg5enc0WVRreEl2NVdTcEZjUFBVQ3Ara3I2S2FJQWs0YXRX?=
 =?utf-8?B?ZEpRc09jb2lrNk85RCtkTjBPKzhWV1V0QXhkcVY2ZzV4bTdwYnRpM0pkK2tz?=
 =?utf-8?B?ZGNnNlJwTnZ3U3pucTBFZllUY1AyVGkxZ2JLS0FIRmRqRWJMWEdvbWloOWZq?=
 =?utf-8?B?NmF0YUtZekhjNnpIWEsrQzJ6TTl2Qkl4Rjc4aDJOaXZOM3lZK1hYOGZFOHFQ?=
 =?utf-8?B?TzNmdUgvakhSbUNvSWl4aElMZjRRNW1qcHdENDkwVW9raGFqK09SZ0pRMC9k?=
 =?utf-8?B?a1Z4Q2dTQnNhY2E2Slp2a2I3R1BSQkFZMTJlS2hlcVpWdHN4d0dGVjFEWjZw?=
 =?utf-8?B?ODBnZVNGNWoyaDZVZ1FiUjZacEpRdHJNZE5hWERXNTMyN3luRWEvbHJXVGhO?=
 =?utf-8?B?ajlnZU9PYWZlOFVublhOalAwSS9MSUtYaDBzTHYwWGQrZUdCNEE2dG5hK0R2?=
 =?utf-8?B?aEo0TXlvSGdjbXIvUXlySjlJUXFRN2tibkZ5UU96UHo5OTJLbjhqRktwU2o4?=
 =?utf-8?B?Tk93RzNQU3M5S3JreWpWM21LL2pQS2NqT3I5OTdpQXZ4SHZ1SlB4cXJodm5m?=
 =?utf-8?B?M0psM2d1bk5VTFdPcE8xWW5tU3pGSkIxbldwU05FSTMrU2FLd1c4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E80114486706F429426368DA0A87850@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bRuwQRk795pl6KjevS1M4c78HzqgC56P4AUsc8gDk3DKdmHhXSOPAwkegvroRJadpwc1mTYCj+tF8Jx3MpRUTdh8+7FzrwLvD5eXgYLloCcNqBMuqLPVWO9ih5EAcvFzgROKKw1/2yojuphcoeF/nOU51bKjmoGmInGlTFQTq0raNmUfg10QnofuDowRqHmzN7eSijv/7KMQVFa1ku6dOtmGqWwnCCvJYbQaIhFoL+VKWyH1sKPHWYew7Ew770w+vMNuG72qZhzgo/z9AoHv4/PoANVhCc20XGRTSIs78f8ARmXGrUAnbIEUmU+WFN4iNZWfFxOwC0Zf3fP933K//g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c90c8e-b37d-49d4-40db-08de847d0897
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 23:29:28.2526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ukY7SEXqI9ychUdHWDHOREV09p/1ictGydlbGWfYuw+LL0iVBxCnkQk5n85JYFci2gVyc5yZQoPbpsTpJcLhOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8185
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDE3OjE3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiAgSSd2ZSBiZWVuIGNvbnRlbnQNCj4gdG8gaWdub3JlIHRoZSBrdm1feGVuX3NldF9l
dnRjaG5fZmFzdCgpIHdhcm5pbmdbKl0gYmVjYXVzZSBJIGNhbid0IGltYWdpbmUgYW55b25lDQo+
IGlzIGNyYXp5IGVub3VnaCB0byBlbXVsYXRlIFhlbiB3aXRoIGFuIFJUIGtlcm5lbA0KDQpbLi4u
XQ0KDQo+IFsqXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvNjczZjRiYmMuMDUwYTAyMjAu
M2M5ZDYxLjAxNzQuR0FFQGdvb2dsZS5jb20NCg0KQ29tcGxldGVseSBub3QgcmVsYXRlZCB0byB0
aGlzIHBhdGNoOg0KDQpPbmUgc2lkZSBlZmZvcnQgb2YgdGhpcyBsb2NrZGVwIHdhcm5pbmcgaXMg
aXQgc3VwcHJlc3NlcyBhbGwgZnVydGhlciBsb2NrZGVwDQp3YXJuaW5ncy4gIFdlIGhhdmUgbWV0
IGluIG91ciBURFggQ0kgdGVzdGluZyB0aGF0IGEgdXNlZnVsIGxvY2tkZXAgd2FybmluZw0Kd2Fz
IHN1cHByZXNzZWQgYmVjYXVzZSBvZiB0aGlzIG9uZS4gIFdlIGhhdmUgc2luY2UgdGhlbiBkaXNh
YmxlZA0KQ09ORklHX0tWTV9YRU4gaW4gb3VyIENJLiA6LSkNCg==
