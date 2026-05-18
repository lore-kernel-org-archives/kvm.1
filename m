Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389124DFF9
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137742; cv=fail; b=l+fJI83HZe+goY/wHIFM2D9k1sdcmd5+c1ir1KiMdKekDU3G0dIlXbRTT3LMJvyUYlHrKlmwj72StAkE5oo91TBKZtWCQy/QY0QtJVeDHttfg19m8HDyJZ4xAKnpuUVn5WcBXnMNnuLa8sEXi5uYisVcDKQwpYSd3Sk/MENBxeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137742; c=relaxed/simple;
	bh=RLcCOGT8u7VHCs0eaB2I/rQLGItKv6/JKeRay4lCsdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HQ9kRbmxIb5KS9hsPVhmstc8iBWkjt07Z+I36kBjqM5PWiVmO+4MzaDZCfQUZV7XhhHmvNHtrxHqJ5R8tPLZuktds9NqBtAtucXYB03VYLK3Bm2nCMaMS2dd9H/Wo5xFGnM6C9KZkJ0cjfisfzSRie28mJf9AsN1NOhRs513N+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4yrUFXR; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4yrUFXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779137741; x=1810673741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RLcCOGT8u7VHCs0eaB2I/rQLGItKv6/JKeRay4lCsdE=;
  b=N4yrUFXRPkymxfLV7kMFcppFG3IHmuOHATtjplRCiTeaBZc1rW2dBqUt
   QHvEwlfYHO3ZXWePAsPenBjJ4EmntwIagGKjlUnxDJoHRf3VgO5UYXLbA
   Hw9DARxmyqduDoKWZXxiReGmRNfvtgyhktQ8kI9KhogiT1FghSA2VMPUg
   S3iO+C2WfW1IPMd4It2C3SDaiKkYF8e92a02KjiaiXRFWWGfpGD3eUkHN
   SxGgLIjG5m1JWqAogHO4/yp8g18lT/BvP89uKf6hjXrWNIbNgiEddCT6m
   jXlqvBFydQaEpLnmqyxIUDEwV2wfme/L1D8MlRjIcFMAlq7I5/yaq/NWJ
   Q==;
X-CSE-ConnectionGUID: H0lKksbqRO+G0v21LJ4VlA==
X-CSE-MsgGUID: NI5IBR05Rf2z6I69qKVh5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="90586754"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="90586754"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 13:55:40 -0700
X-CSE-ConnectionGUID: tz8bP4ezTc+eYoWi+hV5gQ==
X-CSE-MsgGUID: 6xNxMkBaSTCJ72roY7nZXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="233168154"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 13:55:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 13:55:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 13:55:39 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 13:55:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1nGK7WQ3A64x6vzTojebWwiozBL/bVMFXXe98VXqhlu23FK0i+HyaKCR2dsV/1ongEYFoqlO7/bros6TCfvOZYcrKlRsRiIvE6J7iEmtWLXxlCwur9pUpQ+b9qy5f61WiwF2u3wAsfPUHd9lviPNVVIRpaCBBxGt9agLPAUTc7ng2rvyp5QkWXxktE6B9v3HMim/SwTiSm1HYbds1aFx0Cn9dCu82PH/LePBkqHi6izAYc3DzHYCDO8x3m1/prIpjBZ/4qUb6qlwWFO7cUWzc7Tr4UGRpbImoLhFMb23w+r6qzdbB0H7pN3kc6iGGSh9jh+R378wlR0gxMWLktiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLcCOGT8u7VHCs0eaB2I/rQLGItKv6/JKeRay4lCsdE=;
 b=nCuMtjVU5DFH6X528s9qNjEib4utVi5B1Tf+Oph/cA0jIp/bOACMfXWVkkgH/Cz9rqw9BArfEZ7aKMcL+qfh4PwkflpyUss1KE9UYGnMTJoS+Y4fe5vidcNyUYrKG5wdsNXDAxiz9P3RblCvs3gpij+BkaR7/5xohSz/1DhFAST7H323JrznmYNN4RaHFAwteyzemUP5NsPMEGgWRZQRoWGohn0D3T7EwkvDjOxm0RNECx9197bcC07WcjYB0jgOzeu0snbyH+84SUy/ABWkagLX3YOZcIMd5kEgLyrmkk5uVH642881waM6geKj/inAJTONQnOGdnWydNQwGPQP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB6493.namprd11.prod.outlook.com (2603:10b6:8:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 20:55:34 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 20:55:34 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Gao,
 Chao" <chao.gao@intel.com>, "Huang, Kai" <kai.huang@intel.com>
Subject: Re: [RFC PATCH 00/27] KVM: x86: Add a paranoid mode for CPUID
 verification
Thread-Topic: [RFC PATCH 00/27] KVM: x86: Add a paranoid mode for CPUID
 verification
Thread-Index: AQHczjxZm3NIUz3Mfka520SfE1BvJ7YO55KAgAS0S4CAAG0YAIAAa+iA
Date: Mon, 18 May 2026 20:55:34 +0000
Message-ID: <64ee4f0cbb158eeb21ce5581346359cb338d3ae5.camel@intel.com>
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
	 <50ccbe42-4b74-4c2a-b530-a367f7285de6@intel.com>
	 <bf569f46-8690-4f82-a2a0-d196970880de@linux.intel.com>
	 <agsiQGikhZA0CGTY@google.com>
In-Reply-To: <agsiQGikhZA0CGTY@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB6493:EE_
x-ms-office365-filtering-correlation-id: 6157aa01-ea7e-43be-6096-08deb51fce2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|38070700021|11063799003|4143699003;
x-microsoft-antispam-message-info: 0/I997cl25nvAabVuBcjvJB+bllA7kU1gGjKbeOOXZTfhlxk0rIvtJ6y+aHPbBJ4aUPorqEbdLNBiNkdbpHYkrCqdhGXlOGTknqaZQ6snLbbwpiA3VHg0gAiNmEtbYQrYX5uRbpUFux57+ExISb4K4rbYWUdbCc5vrT30JZUZxojSt2eegDR3TjtFMWBeSQcAIt8UtrLucmlJ5iHxzo6Y4xcbfqkq1QzEKip46BuHKuBcxiIhbr/obMtxMl8XWnHr4Jggli4Y7dI/W+ZNQIBHSl0GGwmP/cDA+spyvZ5MwEak+HAv1+mcT6eu/ZhkGUUUmYg7OQv72GhG3dFXgyix0tiN6zSswZMRJ7d/MUKW5Xe5JY6uIUC8Qg4Y6LxD+YSBjoOLFSZMSEZQ+PwQM77U4XEPTnxHX1oLd7aSTMPsuzNssRCCjR1JQqrkmzRPqbxjQXEVOEY6LxDdRoU6uRHvTHWKghYod5LwXOPQJKeWfKhmKtACb4NWqOh6PqCpDhnNLOzqZNGIFgtSAy+PjstvK6hRlyko10Fif19rMxtZoiGxjrLbb7myCyfyABX/Cf+2PFP6NcQVLvA/8MQN8b/9sm7R2YGz+BCmrnMnKBEjp2ru4o4Dcr9EdKlBy9s5FQ7UQ9eB1TR45eVftq5j92aDr3js3q3Is6Fb5Hm8iZs4Ggaoad9RWAi/UKTFJnwefNcAZ7lpvgTgMwd4z8svneVxCNB9aMRhaBIummua1I/XCNv8Cpc1pxINZipxh2WlZcy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(11063799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVVJMWpXNUlOSHcrLzVRaW9ZVllvSjlTeW9qZzJibU5sUzFmQUdqZ1Jvd000?=
 =?utf-8?B?Q1IwdmdNdlB5emMyRG9wK3pUZDd2dS9oQUNQR1UvWXViR0pzVytueWpTNGIv?=
 =?utf-8?B?bFJGWXc4ZWJoWm0vK2JMUFkzUWQ1L25McmNIOFJJV1dmbjB4ME9XaWNiNGxQ?=
 =?utf-8?B?eERScFlhQ2l6VkxJRWJaTnJQZTBqMVdyZ0p0V2RYUXloTlNoTzNSZ0NrWXhi?=
 =?utf-8?B?S3RMUVg1TmNhTjRyZWdYNEpxdXRkYlloWlYwL2xvb09DTkJraExhcjhIQTRJ?=
 =?utf-8?B?dXNvMzlNR1pZeUNXQlhGOERlVlRVZk10MndWSGsvcW1GM01XaExCV3orZi9K?=
 =?utf-8?B?MzEwakluWElHOXR6M1c1a1BMdTJVQTE2ZU1tTitPS2RVRkJMSWNFUUkzcENz?=
 =?utf-8?B?UEtHSm1mYlNmVlhJUldJRTI2bXNTSGNKbkN5VnFuM1I5ZllYZWJUd1NoRHZR?=
 =?utf-8?B?RG9PSlhCTGdXczNZYk1uWXphSXFOVlQ1UnBYM2V3VnRPVGJFMkRzVmJCT0Q5?=
 =?utf-8?B?QmxPa3JQdHBJT21SZ0RpQTB5OHM3S1FiR1JQL2w1eHAvZEFwMklqM2VONGZi?=
 =?utf-8?B?dDJaSGZpbXV3YW82YUJ4clcvRnhQOU1nKzBoMmZiV0Z0ODFwOHV0eDg0d2RJ?=
 =?utf-8?B?T0cvT1hwVi8ya2ZmMmpSQ3ZUaTIxQktKbGNMTWtTZVFkQ0lOWHgzSUVYWnZ5?=
 =?utf-8?B?cDRpbTBIMG9QMWIvWXBYcmtUYzZBdTdnRGhyT2ltOVdlVFQ5L2ZRUzQzMWJX?=
 =?utf-8?B?bVpVOGUzWFNrc09FRUhkR0kya3UyRDRZWS8xZ1pzUHhoOEVFRk9LRm9QUlZx?=
 =?utf-8?B?aE1qeW1HOVg5UmdQdjVtODlsY2VrMVVXMVM0UzJBUzQ4MlM1b1B5eVNyWHZh?=
 =?utf-8?B?cHdlL1FDQktISS9PRWl3ZCt5RVhQU3daWG5yV3JTZHZlcnlLazljR2lReVdB?=
 =?utf-8?B?Y0czZDNqSTc3UTdwSE9hS3R2M1R2VVFYWmV0dC8yWHdpMTc1dndhZ0hPQk14?=
 =?utf-8?B?aWNMclF3U1kyQVl6M2F2Tk8zUmRLZi83bmdTZGs4K1RiSXJSYnBiTjJlQjlj?=
 =?utf-8?B?MXI2ejNlS1JaWEw3QkJ4bXY1bngyUFdNaTlvMWRqZy9vdkIwSzJSSkN2aEcr?=
 =?utf-8?B?cnZBZmhZWHNENVlLdkxHOXVoRnBUZkxVZnZrVXBxRWFLaGRZZi9JREdyMExF?=
 =?utf-8?B?TWMwWkJna0ozb21TSlNkank0bW5RbWFqYkQ2aTU3QzdwMzJhUVRIejJFdElW?=
 =?utf-8?B?QWVjZWdLbzJBbWRyV0tMMWR0M29BenhxWGY5RlZlaWt0VEc5N0RTOFZWc1ZF?=
 =?utf-8?B?cVI2K3pOYVlra0xsNXl3dzBURldKM3lnb3ZLc29PYzFXVWpEaEp2RHhLaDZs?=
 =?utf-8?B?VDUzOUZ2c292U2RFeVRjbTVLS3dQODNJVFc3SDdCeXh2YnkwNkJENWdSUHdC?=
 =?utf-8?B?NEJUa1F0bEpZNVlKaS9oU2VhS24xWDRvNndzRU9IaXA2V21lYU1TdkNSWG5z?=
 =?utf-8?B?OEdHSXRiWkVQc1I4SzJMYWVJbUM1MEFDL3MxbHBiR1dobkI3clFlU2FmWDVu?=
 =?utf-8?B?QjFlR3JMUWpBVklDZzRWZUE2aGdPa3oyN3VkUWxMeWhUZ1V6MFBzL05jS1R5?=
 =?utf-8?B?b1pmYXlYMFFYNldBbEx1Qlk1cGJwVk4zN0oyRlN2UWJzYW5DVkM1R3lWQm9z?=
 =?utf-8?B?d0VFZGJHZzU0a2VDNzdWWjBGTll5Sk5vbU84UzlIRDMvNWFqYjVaWExleEpX?=
 =?utf-8?B?ZlhPODlrdllaRFpRMFpISkNhZE15S3gvbWJxWGVBYmpzU3haTzhHbVozcFZl?=
 =?utf-8?B?MWdFOFV4ZkJ4aVdjVGRvdXpIK053clF0a0VlZnNjb2ZOZnpoNXNueG12eitO?=
 =?utf-8?B?WmxyY2NwZnllbnVKZUhLbE5LdHZDcGZpeklmb1hEdUpTQTVTdVErdmIrRUpE?=
 =?utf-8?B?K3lacFhvY0g4UGtyQTE3NDhyVHNvZm1jamQxbjdoUjQ2TVBXRWdMMjVLWDVH?=
 =?utf-8?B?SjlvUWVkdzFENkhYbWVuc1MxOUNmS2xUcFhhUXNRQzdrWnRmUDJPUmMyQy84?=
 =?utf-8?B?SE82WW45UjlSQzJJMWVESCtqUjZpYzBNSFRnNi9Ibno0YzNZa2g1QlVLQzZI?=
 =?utf-8?B?OWQ2c1U2d2ZHUUhPU0djWkxrampZK1pxdTlPYXY0dUFMcHlzUzZHZ3krR3hQ?=
 =?utf-8?B?bGJqazhpK084VVcvSTZiU20xdVFiZjZ5dzlBaXlBS3JJbVZQcVVnWUxicjBi?=
 =?utf-8?B?T3lmSnM2ZWlGRlRzK2ZDUiswOVB0ZStSQ2M4Wis3OXNNRjN0SGZIUWtqa0JV?=
 =?utf-8?B?V2lzNXNSUGYvaVlHTDRQRjg0R0QzN1JuWWdJd0tCL3RIeU85MGUvdCs1aE1H?=
 =?utf-8?Q?l4oQquBT9/VLR2Rg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F01D9A8B1AC18C46A1C0C062CD61D5D0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KLm5Gciy/oSh72BNCBmVyJEbezImsU19wic9EWfQtdTMqr0JEViEXIdI+S3oZ8a2WWMAIsfckYhU64ADnoG/uBQ90LwzKR/wu0GC+GOiGhB8TJMAmdHfwzSO2+ZWnkjWiFLSVIbEncSGW2grZrekqMnzID692lqA4vCnqLwNhYBRSqRkORuKecqwuevkShgSjig/1dICABr+Tll/ULTtgQVrhMwWkYwBjxs7zoLeQgjk0wpajXDSELM5FzGdtmmAn0yWwFemw0BSATTL7L2iKM7lzOJgk3gN4lPEPZAWWIkpOnK+oCIpOeEGBFkJuK5EuIAwsHxnsi3Yw29VkI2Ssg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6157aa01-ea7e-43be-6096-08deb51fce2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 20:55:34.0636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2kXV6gBpD2CsQExOatBA0HUALsXyvvK6/gJvTsCa0t37mc9RsCMtALFFXMPTBC24CUQ/lRkHc+vp61QwxkrCXNNCKcZuSR5TWdOEUKJ0blw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6493
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA1LTE4IGF0IDA3OjI5IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3JlIG9yIGxlc3MgdGhlIHNhbWUgYmVuZWZpdHMgUUVNVSdzIGRlZmF1bHQgYmVo
YXZpb3IgcHJvdmlkZXMuwqAgV2hldGhlciBvciBub3QNCj4gdGhlIHZhbHVlIGFkZGVkLCByZWxh
dGl2ZSB0byB3aGF0IHVzZXJzcGFjZSBjYW4vZG9lcyBkbywgaXMgd29ydGggdGhlIGNvbXBsZXhp
dHk/DQo+IER1bm5vLsKgIEkgaGF2ZW4ndCBsb29rZWQgdGhyb3VnaCB0aGUgc2VyaWVzLCBidXQg
dGhpczoNCj4gDQo+IMKgIDE1IGZpbGVzIGNoYW5nZWQsIDEyOTggaW5zZXJ0aW9ucygrKSwgNTI1
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGVmaW5pdGVseSBnaXZlcyBtZSBwYXVzZS4NCg0KQmluYmlu
LCBob3cgbXVjaCBvZiB0aGlzIGlzIENQVUlEIGJpdCBkYXRhIGFuZCBob3cgbXVjaCBvZiBpdCBp
cyBhY3R1YWwgbG9naWMNCmNvZGUgdG8gZG8gdGhlIHBhcmFub2lkIG1vZGU/DQo=
