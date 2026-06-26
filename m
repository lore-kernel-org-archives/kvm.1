Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0500D219E8;
	Fri, 26 Jun 2026 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782435475; cv=fail; b=JQNXujVLlyiv2Fim/WF1WIV8dUJh634rpqOD968n2lpBRmEuYOBAbxmJ0oXa8uDmkk4k6MGazpPzSSmdX8R4EZYdDGtkgPNJBcI6pasfpqUd/2pWitPjadwMrUXah8j2G0dZiVRe6ann1WJ77LnScT3bPpYWLU4OdDK6TswfNFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782435475; c=relaxed/simple;
	bh=YOGoNL9gpOKzsSJNnwBhrpWHSaSoSy97bp1Lf5EFs54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m/0dyUpY7UO2GmU0MGFXOKoiZ36qt4wGeEoLE18n/A4ad2o96sgHP4449ipAekJ7+sqJuw1CEtwrJkduqetM4UZAbcP4pwnmftVCPFTbjvtlmkFS+VEEt+NPTBWVHQ95E6lgkcdI1N+cc3uRZxKfXwprCLhnTKiPSOMKVfxbXpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8DJLesW; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8DJLesW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782435474; x=1813971474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YOGoNL9gpOKzsSJNnwBhrpWHSaSoSy97bp1Lf5EFs54=;
  b=W8DJLesWZGps04Cj5g9Qm7bZm2qAlsHvuhss4J5FdFgNtIOUQtie2Hew
   eu6ro3bV0j25C7jHw2f1fMIePUFs1fwM3yuhs7Js6TVTev6dEbWi2FVCg
   /MJoYquHSwhItwbl5cmKk/lWQbHPwKW5NugcqxI1adhbESe42kSNCMOuo
   ErVwRkdugEnGq9lfHnySm2DKdntmG5QzIPijBiFwe4uWUmRLzDAkYSIkn
   1B/j46Cquu3CNUJwiOVjbvWNInzgARUqN2C96ipB5FT0aZhqVgOUCUTUw
   vgTaIS1sfRkjurepCqXQRznFWrP5NtitOZaFegbX55AcdtjC6lprtslJ0
   w==;
X-CSE-ConnectionGUID: wBhkr9RcQu+Uod88AMvD3Q==
X-CSE-MsgGUID: y1Yl05uMQFKfmfXKFg4FUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="70751622"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="70751622"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:57:54 -0700
X-CSE-ConnectionGUID: g+4+ag8/RomaNhkjn+tvrA==
X-CSE-MsgGUID: 9jdbARZhQjGoPQLLsrHg1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="251852946"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:57:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:57:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 17:57:52 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:57:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTS5LrIJdxJwPKEJbFW8UVBGeFEb2BKN089FIXsMOXUfWEO0gVpHWDNBN1B+fLHe3fBwlp539L66FM8lLliwxvHPQ7TOB/gdIfJ3Di2yKeHidoIrnk0rdyYKWwhTDHnDfnC8DaJGhkE4AowleiWfLw24LtQYBBV/AXC4hnq/fqb2pZiV/O6qRIXWcQcPtHj/diveW0bj3Rx2Nt6ycRHRcVdP4HTJnNTr5osIK4zxzg0t2rh1CDg+ROr7t9M1wZ97fU4lvmheBNZ76+CSyrzPb5pgSfz4H85qt2CIvoIlcgGuYT7sZnnSMRirMsnSowU02wSnadSTJM81q53b7h2IeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOGoNL9gpOKzsSJNnwBhrpWHSaSoSy97bp1Lf5EFs54=;
 b=Ff9y91GTurQ9sNx9OOlWMcSd6sy6dtbD8Q49BhI2bV3Lgn5Cp11bYKjSLD+RIpR/ef9JF6H5t4BF2AI0Gf2JTJtzDXDOWsrGwRz68vsDq+PY2hCk1xrsNh2rUQe8zW0nXF1K4A1D14UJ5iEBIimcw1YKbKGHklOST7C8le+HcWnOwm2RG3p3V6AWe4JgS8vb9cOf8Y53yaek9YJwFZk9vOMqSlr1LHN/jf7A3UAxGGYlpGWO+9kaJkAgOHDo6JIU76s1/1NKGtaJuzCa/waAwEe5bDETlnieRS7u6ZYL/yJgiEPDdNM4HC6P1fIwxdOx28tYMLlRFusJGZkrNMNkyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DM6PR11MB4660.namprd11.prod.outlook.com (2603:10b6:5:2ad::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.17; Fri, 26 Jun 2026 00:57:45 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 00:57:45 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH 9/9] KVM: x86: Move "struct kvm_vcpu_hv" and all children
 from kvm_host.h => hyperv.h
Thread-Topic: [PATCH 9/9] KVM: x86: Move "struct kvm_vcpu_hv" and all children
 from kvm_host.h => hyperv.h
Thread-Index: AQHdBO61/5gZzWkBlUOaU/3o7zaj57ZQA7mA
Date: Fri, 26 Jun 2026 00:57:45 +0000
Message-ID: <630430881edd0eee028b7ebff633322a4161bfef.camel@intel.com>
References: <20260625220450.3354415-1-seanjc@google.com>
	 <20260625220450.3354415-10-seanjc@google.com>
In-Reply-To: <20260625220450.3354415-10-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DM6PR11MB4660:EE_
x-ms-office365-filtering-correlation-id: dbbdd3d5-84c7-42af-989f-08ded31def4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: Ggw1FjKqQhNrmhHTb1aZoEqJiaPwrM5VJAF2wdBGjaGjeSY2SnHGp3L7oB9j6GFfOKbFOLvo1syv9VXzgeTjSzCA0do+IZcUBL92SQoLq/j/NEfC+TdHAl3vQgRtoUVN7at78pefKEoadvqalTJ+c1wGbuGy5GFjzax5xpFOfeP8z1SjMb2VEpNoBqGdD44N2ICC7hjgPg21yOnHIg81SvKI0xHuMjScKv/DueHQ/96Xi12kedmMoxqnuodmzs9sysDl3dNl3jte7puELQQc5RG4tVMmiRVENWy2oJsRElhXFVOihsxf/hWF6B2FaJCW6Vs3JV7UNjWaobjvxzp8SW7gFH8TwSMO0QtLyflzo6qMcc8ek90lCydmCwT/RgmVBl+fmDVlH/6Q0IqrMu9H/0vDLG+OLz12sadofJ4Wd8F3b2iCTzfQpZythz2g16a7JmK+0VYK6zvWFHk96++WnG9gnmKlorAjQyW3pw1dISPKBeKAkx+uzr0Ub0/NfPqCcg2gqNwOEDhvurrfh2torIxY/dYMvAMieCY0nNhK3tv0pF4eiw6PF0aXCHAN7yx4OVuT1tCgpveR43P7Qg7cDVYurZuVGhwrWcXNmqjJKixoaCmTI1O4+5htAZqu+Z1YK+53H/o+onbRpDr9+VFzlIXN0eLvltAtWKGMJtzq4NxSQI/4HARw2ybIsUsKmQdeguLdZA4iIlFnKaGFz5A68rby1g6AuYypzYlDXxzA4ks=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0U4S2NpK2JiTmliUEM4eUlVWERGRmt5QXhCbk9PMDE0dytjNGc0RE1ZR2lR?=
 =?utf-8?B?NjE0ZEgralV0UGNUeWs4bi9VbWx6ZlZEemFFbDBhSURPRHZ5WmV1K0NkcDNG?=
 =?utf-8?B?MlZKVHA2K1FiNWtSczdEMXFscnJTV1V5N2ZOeDNnMnNxWXVVdjAweWhjVDYx?=
 =?utf-8?B?UVZqd1ZpY1V0YVI5bnByaUNNWW5qTFdPeHRnTlhpYjhDNFpJaldmd1RJcGZF?=
 =?utf-8?B?aTFURllQN0x6ODhwc0JwSEdMNGJYYzNVbGlYU1Z0aEVCMVNMKzl4aFFxZWow?=
 =?utf-8?B?WkFkclFiRmtXMkU1c0VIWUdVNTAxNzVIRnJtQ2FWZzJuL2hxWnU1V0dNYUtF?=
 =?utf-8?B?Q1hxR2x3MlZVVWdGakJvTGZHN3NVZElNSmFEOGRkajNLWW5iRWo4OGc0K1J2?=
 =?utf-8?B?ZmZpRDY5WWtkQ3FUaGZVUEhHcEEvK2RPR1gwbEhEcmJQQnRlY09sQ1JRdnNZ?=
 =?utf-8?B?c3BVeGF1OUh1Y3duVkJxYzZubTkzdDRyRVlQcld0amd3ZWp6b0V1MjNtTzVK?=
 =?utf-8?B?VDAvUmtRZHZPMCtiT2h5Q1dYaG91S1RIQ0tLVzFkVTJZM3dPVU96ZWoxMzRz?=
 =?utf-8?B?RWZJc0dPS0hiaUxETjh2dG95WVFxNndtak1nVzVTVll5Smp5d2RNeXE1cEJs?=
 =?utf-8?B?REtaMU10NmNSaFV0dnQvREVxcm45MzN6emhUTXEyOTYxT01wOVpkYWxmTUt5?=
 =?utf-8?B?Y243a1VBTDZWaDd4M1kyZkwxWmtWTzVKbWt4ZGppUy85U3ZlWEU0RUFLZHh6?=
 =?utf-8?B?QlhGSDZSOG11eGRVMi9MR2l2cGwrNWY1dUpYcTJmKzVkQzhlemtxVjNLaHBh?=
 =?utf-8?B?MTFlUWVOanhVYy9PTEE5Y1pRa0lLYVA0dk14NnVWY3k4V0FOWmlGNDFWdk5J?=
 =?utf-8?B?b09EZWZYQUM4Ym1mYWk3Z0sxZ1hCbElJM0J2OHBHN296UERQVmRPUnBiVDB4?=
 =?utf-8?B?YWFOQWY3L0VXUXBlQy90emNmNU5tQ0Zra2lQWHFRNTVkZS9JWlJ1aDNuZ2Fx?=
 =?utf-8?B?Rmo3a3B6aE1Xbi95NVZCTGhUZlBQd1pqcm43b0F1WVU4b2w1ZkFmek5qUG1l?=
 =?utf-8?B?TUloT0UzVEhkM0F4cCs3cUFCaGZaKzlkbFBVdFYybFVOV3g1WUlYNUVCZTNx?=
 =?utf-8?B?L0xURHRUUXdSUE5YWWsxcnRxVkxQb0hnQUNJa3RPTkZlNmtRdUFlS1JvV3p4?=
 =?utf-8?B?VlV4RU9acGtWRW13T3dwdlNpK29VZnYva1hkekh4ZjZDUjMwRFJvMkxZdG10?=
 =?utf-8?B?SFhrZTBZT2JKTmFWSzk1d3ZFTDcvVkkzVmlDWkxCOEpzVXN3OEdOdTVHRkxq?=
 =?utf-8?B?MFV3NFFTRVNzdDF6d2w5NXZJVEo3bU94dlBOV1BwSzMrcWQ4VkxzeVhMUy9x?=
 =?utf-8?B?U2k1Q0xKSE5HaVV1SFdwNnB3OWpvSzhROWdId3IvVXp4UStYOTl3Ym5kL3hJ?=
 =?utf-8?B?ZjFXRnYyVjNRR25BeTlERThXQ0NDYm4xWUNKb2lGMWNZcWEvK2tnZEtyY2VU?=
 =?utf-8?B?OTNBUU53ekpyZlFMclAvTlRXUWk2dGg1YmsyWDM0a215ZTVRYWtpbnpUZjN6?=
 =?utf-8?B?bnhCQzlrM3A0TlU2TXNkSGVDMTF3MHBjclJLY010dVRhL1oxc2FXWG1uaGUz?=
 =?utf-8?B?R0hCSDFPRk1BUFFFdXdKWGxpeS94d0RFakdxTXplNkhWMisvOWR5WjZtUmt0?=
 =?utf-8?B?OVpGNEExMmtiZHpjbDk0UkwzRy9hM3BjNngwWmVXRHJxRWRBdjB5cnIzWU9C?=
 =?utf-8?B?dGFqTUt1dzhWYVdvamNhdWpHOTcwcjV1RHJBbi9GTFdGNjNybnlkZzI1UUdU?=
 =?utf-8?B?SlBjWTN6VVBqbVpEYml3MGF5YmpIcWk1bDR6b0QyMjV3am9Xbkw2UUNPYWxG?=
 =?utf-8?B?QkI4cEViNTFQQXZaRGVxc1hWcE1BSXZQRmxMZGJLMFBjZlNEU0J2VkxiM2dq?=
 =?utf-8?B?Y21LS0NMZ29DbXlCZ0xyRjRLeFBZK2lLNVZHaHM5Q0xhMXZERnVTRDVNaDlh?=
 =?utf-8?B?dVgwanZrbHdZSVFqbzRZUXg5M1ZTS005SDdaYzJYTjJsZVJIeFVUa2lnYkdw?=
 =?utf-8?B?bzUrTHoxb09QNncvSFVIbkozWU1zcmozcnRMK1kwYldEU2RkVW5ia0xYcFdj?=
 =?utf-8?B?SHJQUmp2L3A4WElCcnZNSjAwWVlXMnZyb29pN3lJUnJuek9JOVVCbHZkNEJz?=
 =?utf-8?B?NTNwOXVCbEZ5ak1NRXRtaWlQcVpsVWJQS1ZXc21mYUlMcUFsRmg1Q1FjSUZ6?=
 =?utf-8?B?ekh6eHh5bGptNzYvaEJXMXYvN2pwMkdQMGVDTVVZb05aemIwdXRLbTZNclRh?=
 =?utf-8?B?MHJyQ0NTRjcvdG1tV2JjbVBQaEVKN25JSG54dWNpM0l1YytBenBBQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D47406719EC4B247AAEEFD81844B60E9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZdZ+iVinb/c+BEDwHCpVsAl9W7sRvGQV/d30pnCJqNXaaszmXy3YsTXAo1+n9DXhZRGQDrkQb2P92ZC5CHwqyaS4cwNyhwDPKQb1rC2Gayb/maakvZ6ZEtpsQj/ozYgpR9jzwxK5F8bmblLu+567MP1AF4e3bOsg4QrlOj5Bwt6VU196vc1J7+IOgZSRxmgiwz7Yj/NQAkNP6oi8faoSDIwhce7B9Lg6X42SEgj95Yg2oj3ZwtK/1Hy3YsasClLicGjYSO+g2fj8TjemDNTfAIwQRKp5aVBwRVb3sODUPB9B1QFE+9xERJFjnFKomDrPy3uwHHmG5ZrKkWH8Gkb9kQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbdd3d5-84c7-42af-989f-08ded31def4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 00:57:45.5318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKglUAh0pvUFPaSGum9e5i0s4GhVsAvuCaMOT0eGNcqAi9KdpC6AHatuwqnKqmBr5wRUXs6TEg5SRQ8qAmJvNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4660
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTI1IGF0IDE1OjA0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlICJzdHJ1Y3Qga3ZtX3ZjcHVfaHYiIGFuZCBhbGwgb2YgaXRzIGNoaWxkIHN0
cnVjdHVyZXMgdG8gaHlwZXJ2LmgsDQo+IGd1YXJkZWQgYnkgQ09ORklHX0tWTV9IWVBFUlY9eSwg
YXMgInN0cnVjdCBrdm1fdmNwdV9hcmNoIiBob2xkcyBhIHBvaW50ZXINCj4gdG8gdGhlIHN0cnVj
dHVyZSwgaS5lLiBvbmx5IG5lZWRzIHRoZSBzdHJ1Y3R1cmUgdG8gYmUgZGVjbGFyZWQsIG5vdCBm
dWxseQ0KPiBkZWZpbmVkLg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNv
bT4NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQoN
CkZXSVcsIGJ1aWxkIHRlc3RlZCBib3RoIEtWTV9IWVBFUlY9eSBhbmQgS1ZNX0hZUEVSVj1uIHdv
cmtlZCBmaW5lLiANCg==
