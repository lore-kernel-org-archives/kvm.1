Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8B287259;
	Tue, 31 Mar 2026 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953064; cv=fail; b=trhl9oTnh8Z0ew/qqt2HE1+o7lRXwO4x4gpR+N5SCXzBJAhaEt9sl+0OnFFu416dkscw0LQ6pm+PNvhfnrn0qcumgrSL0CerDqvtpAjwDqJMgFyIhv2AOJMSz7ijL6oN5VDXCz1iEv/vNjfOJcR6vcagAaTE6qxeG4Cre7VzgVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953064; c=relaxed/simple;
	bh=0Aob1gmKiwUX+wlBIfftY6tFAmu/EwZeToO/gCR8kGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nf9Rcle5HIXzbVn7AxHVimM3hjoJ3e9KOGQ4JMkT5vTIKFLz/TSSejeucozsTp6jul+dopj1q8CmZaKhUz1pwuDvxzlHdzt679eNjWKeGIgdzlK0gJuFvFe8sE9hUGizFv5Mi3E4XJkaOiAXfF+Nqke8x3GORv0VJP1BqG0kqhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCK0cjCH; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCK0cjCH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774953063; x=1806489063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0Aob1gmKiwUX+wlBIfftY6tFAmu/EwZeToO/gCR8kGA=;
  b=nCK0cjCHBF39G9WLJodByAK0Ysy9YnRO2Cv9uZFCAm4T9sHcxvn4NbjH
   Skl8ALyArOR4tuOph/j0mr+p2OcbunK/Un5vUEqDsthBn0pnEU+GiXakG
   721zv4Qa2YM3Fug+tMZ+cMP3KihGVCSskpnoJDn4p4zMApW0rCA7+g7iu
   YUngFGUl7/Q/9k09lu1AgstWcoEqzignPAA9I5cf12WUKWHsvcoHAx1hW
   jCgDPSVmtk1kjwX9ZieOQit/rfxghx/HdFU5q11kDRoG+oyxlxcmSIUSt
   7TjYRylT5omr0ixMNsgWy4RIr2zi/dVthURMHZF6fnvK1DZxCN6aawYRf
   Q==;
X-CSE-ConnectionGUID: PcOa/FMlTEa0IhIF3hd55Q==
X-CSE-MsgGUID: sYSNQD3sQE+ca1bz3beGpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76152964"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76152964"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:31:03 -0700
X-CSE-ConnectionGUID: KGmWYjujSJKm8SSdGnnhHQ==
X-CSE-MsgGUID: AZ1A14JGSfeunDs4xeSlNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221463159"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:31:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:31:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 03:31:02 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:31:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuXaT16E3JvgWlwVsFEA2CFG5S4KoopXaxCA44RfrQXlWgdVmlrjYOg8EXndX8q/BEU4EEp48rJP8lP6NXHhUvJL3B/bHRB5DSEItChVr6HWHxaEVOU22ELMpB4ADbvLbd3bu5aOCox0mSuXrY13E8x+q2qIvNaTHXROSH/nRe2xF2XC3BbIErdnRTZZKaptW0ALK+zUBxwyL8aBAIJdhMMLDgWfFc3+hT6pVS2jj3+PIbB26RzMeNlRpURV80wTVcFObX3k1dKtnuY+qAGrr44dXOxv/IaP2szMHOhSDJ3WoCFER3glDpqFyv0ynLYVa2vMTae3fsQJji+RpTsBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Aob1gmKiwUX+wlBIfftY6tFAmu/EwZeToO/gCR8kGA=;
 b=QRSj3BWHzqHgcT+pzJsbnbWDmVLmedKh0OWmuL+MSXzvpq7eAgWRYHRRi6DCX/+iAzOkOyj2FQLLkWrSXAvb/56JzxdIFshBaQoadaqFgGvMNUGjvRHq29xbZ5P70O3/cHJKKtBol2FkJpwPeW5csxemq6OoHobCpNlg56qAFAkl9WIA/HnyverHoZe13jWsiVDKKmSKrjZODU4jdIiDo28QIwYQwk9rKoDHA7N1lIJWgeiFl5K3WcSiIOd8DlME7SxlNkuw/o2/5niedOm9j7lneCD7YsmFfV4c1G0cg+tH7fVxzbubfpSd5bBM2ouZeiKcKRSDXaxVhA9kHU77nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH3PPF76AA2D882.namprd11.prod.outlook.com (2603:10b6:518:1::d30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 31 Mar
 2026 10:30:59 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Tue, 31 Mar 2026
 10:30:59 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 10/17] KVM: TDX: Move set_external_spte_present() assert
 into TDX code
Thread-Topic: [PATCH 10/17] KVM: TDX: Move set_external_spte_present() assert
 into TDX code
Thread-Index: AQHcviZaT9hdoOINrk+cMFGJgJNtlbXIdp0A
Date: Tue, 31 Mar 2026 10:30:59 +0000
Message-ID: <8cd9eb14bde0817c60cd87b8a3baaa670ddcc47d.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-11-rick.p.edgecombe@intel.com>
In-Reply-To: <20260327201421.2824383-11-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH3PPF76AA2D882:EE_
x-ms-office365-filtering-correlation-id: 12ed6553-cf77-4b37-135b-08de8f1099e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Dhmc7M9/ACkQUBZt66z86t+CZS5kLwMNpwAdJ3Nq10UcAmmsnPDguTE7wFerpw0GyMZ/kfTutoUE9YdCh5lu2DlW+LS5G4958f5eJU3FTSXSxXjUEVvRUoj01yVpTHe7CJfb3faCrSdUXzF+bq9SZA/8oz+pWtJBbsqMSMmabuzH8bwJZsy5nQftVxxdaVNa7pW5tkR6ULC6Qr9U/H9FToFokaZRMTLVjN8QTr7Zo+8goNp6D1lQGjTsiujfNvBC9dkxKOeWVZ3/vbZOVzGmqXr50oxFai2yoTq+OEZX9U2+Rt2p0jeb2i5TgHktLEU+6G5TUsMFpUcFM+hO4GVckl75HBo6zYBJZ3762bsFrxr57eucOgoTEf5aDawf0xF3zmYldBJ41fJt5gkcwdP784wjrrYVe/SWSi7WkJeBnc7TFyplhCbPcJCA0+asu13lFa3zeLaBrwkkzlykmaDNq671GVd/e/wakwCPpB7tGWTNJcbVN6MDe7ZEc0b0Q/qrjpPskXspf9Mgj+Fx+ZwogUuF+A8v60JKdtDKlId9JQlYDfNO3u9uGZaA86xphbR7pn4iGVuRKCgRIMKrkrhID7jvZv2DpbK7FqbHos/pDnrdl3eJUZkkzyTfTFqu6ZGvrROXT4PbYLJ5YofbD3GovZRswdtdyl4RSZuSuR5LyXY9P5EsEmBuRGedkAXxiGnaVCxcfvclK/WXxDkBfNx4kIZl4fSi4RjQXvCmtuZDpc8ULM2eTfbzu42GbkijTedYbXaTz+xEwyEPBQWdd/qNV9hljmW3LGtJrc+D4kQDJoQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejJSSm5INTZrbStRSVhJYW00WnNNeGNWNlhycEdVQ04xdXE4dTZiRThaenB3?=
 =?utf-8?B?Y1VubHlsbWhHbmlPRHhUL0tiYUJwZ3d4M2ZRR1k2dnhQUk4xdUxuVDVOaGVz?=
 =?utf-8?B?QTMzSk1TdDVYODU1QzhyaXNra0NMQUp5Y1cyNzRFOUJhSSttYnFhY1R2WEhL?=
 =?utf-8?B?cjlRcTAva2xERnVGdjNtdUNUbEhFaU9TOHpkbHRpWENlS1JxQkNabWRvck14?=
 =?utf-8?B?dXBIVk1USU0zMExRUjY1WS9UeGZMZ3daRDNUWm94WHVWZEhzZk5rNi9sajhl?=
 =?utf-8?B?S3Rjc1U4KzViYzREcm56SXpNenlOcEU3NXphUU4vdVd0TW1VNGc5ekdoWThT?=
 =?utf-8?B?bDgxY3poaHBvK292d1VUWEVIOHJUWFZsaVM1eUZCc3A4TVZqdmhoa2RqSlNB?=
 =?utf-8?B?VWV2OTdxY0tNQjNtc1R4UVpCRW5TUlBsbm01MkNqOUZ5VERaV3ZBZDh6UlJh?=
 =?utf-8?B?N3hVRTlNVC9iR0NFNnU3RWw4RHBHZHRkZGFhNTZhT0VvbDRsMjVvYXQ3YU5H?=
 =?utf-8?B?c1c4cUh2cXZxWnRTc3I0dS9xcFFZcnBxMWVqRjhWNXpReDI4TksvN1lHQWUw?=
 =?utf-8?B?ZjJrYkRnUStqSGJtTytWcXVzQjlyK2VVOTZ5cUFHMXcvVVdjd1FVWVVjd0Vz?=
 =?utf-8?B?U2IwRC9sSkxKcHNwUGhHVG9Ya0ZiU2dPUmhpTzNrRXN6MXBzSnJlSGQ5VUg1?=
 =?utf-8?B?N0N6ZjNWdTBXT3p4eFVLRVVWMG1lTkNPbmJkMlFUYXNFcnB6YUp0VFk0dERr?=
 =?utf-8?B?dVNrckk2bGErWm15K3hrN1pZQnhCaWttUU5YdVdTd25KdnZ6M3BzdE96RDUv?=
 =?utf-8?B?My9nc2I1Z2dpWVcxUXJCc3RjT2o0NHk3d2tIWVdxSjRGdXlTMnRXVmZTdGVr?=
 =?utf-8?B?dkozWTNMZkZ0OGVpdXBSTUNucU1ZajV1VjNUelR0RkM5NkwwQmFpWHEzMUFF?=
 =?utf-8?B?VlA5RUNydFIvWnF6ajdZaGxJQnZhRHRDUVU4NGtJSnlMdlRJazFTQTR6RFFz?=
 =?utf-8?B?b0xsMjdzenpzYmxzUWNyODAySkoraUxuTUZDbjRKMkliKzhkanJNYnFuSGNk?=
 =?utf-8?B?OHhZTHlqZ0txWEhzR1VvSkFtaGxNbFZMQ3RQdWQyNTFyM0hDSTBmYmV6ZHo4?=
 =?utf-8?B?anN3eTRMUE5ldThYRURCY2M4ZStsUmdWZ3F0cGhrNW1hVURneVd1dXBsaGFt?=
 =?utf-8?B?bnc0dE1RcGRDYWlQTlNmSXhLbWcrUHFBU25KcTBTc3FQM0dubmFydEZtS0Nx?=
 =?utf-8?B?ZVNaVTQ1bko1TGdGVkJ1WE9qVmpCNzhYQVliUTFFUzdRQkRjL1lFZUM1Q21B?=
 =?utf-8?B?djE5eHFoRDNaN2Z6Q0JjMlVyVzhQUE5WbUdFSWptNGgvSU0zWGprWlFUenQ4?=
 =?utf-8?B?ZUFaalE2TVhqbzRnaGlzWFJoanI1OUNtQktsUjB5bmpjUmRxTVE3M0E5dm9Y?=
 =?utf-8?B?YjNoWWprOXNsNXdHMkQ2Q3Btb0RwajNlWGxPSjBPSFBaaTFXb2VUM2hIaEJM?=
 =?utf-8?B?NVVCVk5RMlpmSnBLYUtObThNQUJTNnU4MlNZSWs1RUx2NjlzN1g4b29hbDU1?=
 =?utf-8?B?VkRHZ0src2pobENpRyt3NkZqM3BvUE0rQVpuTENnVkY1MFRNVnpxOWlsVXV6?=
 =?utf-8?B?MmlocXFUS2JsS1dlUTNIVlBmZDFtK0dsUkg0WEpxeTJBeW4wbzJvZkVNMjI2?=
 =?utf-8?B?TTVXdElVVHl5T20zZFJzdkFDSXBWekFZTWVnbkVJTHVoYmNEcDE0VFV1bzV2?=
 =?utf-8?B?Z1l3cHRxTVhreEV6b0RkMWV1OFBNVU1OMWcvVnkyM0xRWUtXdmNBeURSR09q?=
 =?utf-8?B?VktuZFQzeFdjWXlxTmpvdVhISW9ZQVdjc0JuaXFnQVhnbFMySnErWTNxbTlM?=
 =?utf-8?B?U2hFY1IvQnlIK0FiVjYxTnN2Q05kZVpOVjFxODFnajN4TmJSdy9uV1dDdFIz?=
 =?utf-8?B?L0VwUXNGS1hCcXNjKzQyeGRkOU16SFdwZWw2K1Q0NXBhTHhZY05wQzROQnhL?=
 =?utf-8?B?anpEMlg1MVB2cFR0U2N0ZXBTSlkzVy9Wa25NZWRKb2tvZnZVMTVzSnFlQ1A0?=
 =?utf-8?B?dzh3UDJEaDlqME1JSWN1WTVoeVhTaUN2NWVnZm9FMUhQNnoyWDAvT0NzYjhQ?=
 =?utf-8?B?b2RSS3RFS29GQWVMVjZDaUNZamw5WEdiTGI0Q2FmWWE3UXVlekdlVjI3c3l0?=
 =?utf-8?B?elo3aDM2L0ZuRUxBbTZVOTRqaURka3dTbDduUDJoSjlGYWErT2FITmhFWklX?=
 =?utf-8?B?TW9KOFh3OXVFTWtiVXJUK0ZLdE81aWFzV1N0ZzYrUUlKcHlUNHhCSWd1TVlD?=
 =?utf-8?B?L0hISiswREFMTXhFU1hEby9qOVhwdlB2Zi9BUlhMOXU3WDg4WHVoUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BEFB276607F2B48B084AF47D26D5D62@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YpFLd+7hueTLFdCB3WbeWTBrpzBDWuCYZxtpHgyGtXExYQQAUF4DQ2CFY9srRRDtHFNJiQOd/FkySCmf0Je4grxosymVnswt8hojjFSg4eN+WAPkvDuDQhAiJfZQ6duINlirTLcTscz/1LPWRFBou0WR6/HLT2h+DulHuYeiRRznCryX+r7QNC7u8ckGDd/QdvrFPz3Ca5XsxQnpbGtQZKvT3onlN/bHAgf4Ic0YO2UoB01sQHCVmsnQDdRMr4yhUlOuzTcq5J9oeY86uendtMnYv6z96LBR56nGupFVS1Np3qgIx1JhbuaxjJMKaOQa013kGiu28G9KmtFYHAs78Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ed6553-cf77-4b37-135b-08de8f1099e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 10:30:59.7022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCFubrQsX+UQlin9yGMnOgzLH4gggwAkxU//AzPMcFVdbVje3Ykx4bn93u+g1CLgnBLpIjR1jgVRyGOvIVqIIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF76AA2D882
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTAzLTI3IGF0IDEzOjE0IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gwqBzdGF0aWMgaW50IHRkeF9zZXB0X3NldF9wcml2YXRlX3NwdGUoc3RydWN0IGt2bSAqa3Zt
LCBnZm5fdCBnZm4sDQo+IMKgCQkJCcKgwqDCoMKgIGVudW0gcGdfbGV2ZWwgbGV2ZWwsIHU2NCBt
aXJyb3Jfc3B0ZSkNCj4gwqB7DQo+IC0NCj4gwqAJaWYgKEtWTV9CVUdfT04oIWlzX3NoYWRvd19w
cmVzZW50X3B0ZShtaXJyb3Jfc3B0ZSksIGt2bSkpDQo+IMKgCQlyZXR1cm4gLUVJTzsNCg0KVGhp
cyBsaW5lIGRlbGV0aW5nIGlzbid0IG5lZWRlZCBpZiBpdCB3YXNuJ3QgaW50cm9kdWNlZCBpbiB0
aGUgcHJldmlvdXMNCnBhdGNoLg0K
