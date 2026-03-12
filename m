Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747ED3F6606
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331968; cv=fail; b=mb75JNLg+q0n5Rq0TjZwx1Y1YvXhSwY/qs5hkITo4jVZXhygbiWQBRA4UwX+iTqsHWfsEp0fffD0RPFFrEh94XEZ2GiGp+MBnh6ZMvbDGVRxK8Bhkj8czFZVBecDZUYDfFjPl/6U86GcjWe2IXe2z4K66ZPTCzLihR66D/kzhXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331968; c=relaxed/simple;
	bh=6AcWxafCqpae0ywDPOkeRBQTjK2b9eM7618qyeuZkQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n2hlDleqAIt3REuXmzDIfhz6hBsrHzp4EXYpY1gfApIgKJAre3andcQZRSC2Kzut0IEG1d6h0rq+4lTGpSnuy9N+1yhki79UFeHhWkiGN3tu3va7ZyNHLZXKgJ6Ggk1ThWPy64VnvmId3cqi9v2eoXX23vJKnEqoH8uqNfiKpHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=plXABOFO; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Udgy2YA0; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="plXABOFO";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Udgy2YA0"
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C9Hug0978522;
	Thu, 12 Mar 2026 09:12:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=6AcWxafCqpae0ywDPOkeRBQTjK2b9eM7618qyeuZk
	QI=; b=plXABOFOsItcGufunF9Ivp+h9cXvihQf/ODrxNNZI5FBhr1R78++9eI7X
	T7oZ27Hun17tKj+6NAq4C8EpLBPJyaxtsy98ZOmF2tRXKcuUANiCJ1mtUlLd4/3e
	Jw9ZfmFPnfn4hWmOX2/9Cw/F5h7UTEqNFgj0l/fu7dkWgem5H1AFhq2kMAYMtHmy
	3ivE1J4FW0/ApqBJkVAiHFydg8whEyaSgDuWstgQnX1G70LACqO1NQIiDIAQCHOy
	4ZQKiccnTma0uO3IvIPiIme6pUF13qBTdWrCZho0qXj36XhcJrBzDBOt9i9dGYAM
	TR5XlMDpcp9ewDw1vFtD0qQT1fTag==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023072.outbound.protection.outlook.com [40.93.201.72])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4cuh69j88k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 09:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lacacJJ2tftuyBxlqwCTQqY0j5JqnvhbBKqIiSU9YSY8LbZOoq0R7voWEMkcHL5lWooJIKo1oB2D/AepJXlan0nETjgO2rdW9eozbPjPAQ5FphbbQ1qkclC4RoxKQjXywPZkfynL3Mmh95p5zcbxyBxR3WaLNCkKtTjmIS+4g8qG8qewlwfpvVK+n6aMgTS4wyOnU0J7U+Uj4Xltiy/Mx0AX1DWI66QzZY4iI0BfLz5ReIuywPWh6XbnHEx9bpFcB7MvgK0XOlFU7yLK9h8g555n1tFcQesK9fi0LuJG5H9W6KsQam54fIPTJzta4owKetnqB6PJ5u9g/IEUAJAS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AcWxafCqpae0ywDPOkeRBQTjK2b9eM7618qyeuZkQI=;
 b=O8mQWlwHaADHd8ere7HIPrxSGT8PQkB5+YTxi13inLL4LIbYL73EjySLzHGkZSB0QC1pL7C6mhzvnMJcwgoFODGbTDcJkXUQc30igtl/gKeIN+jhJoKDXkqp4A3LEy6fAZxY/vPTxMiva2LwZhv4M/uhPs+PouCxdbdqM2MeZ4REjxO59Q+gQj+cQP4zTaZZMAQboBDcRZdZfNZFWonbQCfjc1yBygT+FLb6RgS15UcCTcrKLZeYqSInBX0CBUUTNvbbmKD6tYSMqpKXW0g6A2nr21ml4XvZd3F6Fwe3rLxT9973DKn/3L/iic9CuR5/gJVbsESwfgLedrFPz9k/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AcWxafCqpae0ywDPOkeRBQTjK2b9eM7618qyeuZkQI=;
 b=Udgy2YA01QdwhAwwTaewh3N+ig04hgif2ZfkY6ylfNe6JWtPBWB1u2vRgkYl5p+zWOmcf+fuLFXF6hqjHPJrPP7/R1ro6v6bcam+IEIaZcu3BXn/6fHXtvFQC6x98pO3vnxhvaUknar/xN+RfoLUhxbQyLbtmc1ropeLppN/KyUekz8Ziv/9QnMBiSr7z2dnPC6POYbMoDBHCjI6o9UIwKYT6d71f/qEp3G1NvRgD/iXyXc3LUsnhahagrc2NQdomLXyL9IKuzW9oCh1mld6Lv/HnnJkDYK9JPjovIvRImJww9RJoKnJAI1Km/eiAqbJs3FeqbbrFrpCKdUATartoQ==
Received: from DS0PR02MB9321.namprd02.prod.outlook.com (2603:10b6:8:143::21)
 by MW4PR02MB7364.namprd02.prod.outlook.com (2603:10b6:303:64::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:12:23 +0000
Received: from DS0PR02MB9321.namprd02.prod.outlook.com
 ([fe80::16f2:466f:95b5:188f]) by DS0PR02MB9321.namprd02.prod.outlook.com
 ([fe80::16f2:466f:95b5:188f%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 16:12:23 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: David Woodhouse <dwmw2@infradead.org>,
        "seanjc@google.com"
	<seanjc@google.com>,
        "Stamatis, Ilias" <ilstam@amazon.com>, Paul Durrant
	<paul@xen.org>,
        "graf@amazon.de" <graf@amazon.de>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
        John Levon
	<john.levon@nutanix.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [PATCH] KVM: optionally post write on ioeventfd write
Thread-Topic: [PATCH] KVM: optionally post write on ioeventfd write
Thread-Index: AQHcrWi1XtWCtr4qFUWEUj3nkP4ecLWrB5UAgAAQKRA=
Date: Thu, 12 Mar 2026 16:12:23 +0000
Message-ID:
 <DS0PR02MB93214EEAB50391C84CB7B9C48B44A@DS0PR02MB9321.namprd02.prod.outlook.com>
References: <20260306125651.2485-1-thanos.makatos@nutanix.com>
 <43e9c370c07092e6e1342f70d272166a1f3caedb.camel@infradead.org>
In-Reply-To: <43e9c370c07092e6e1342f70d272166a1f3caedb.camel@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR02MB9321:EE_|MW4PR02MB7364:EE_
x-ms-office365-filtering-correlation-id: 96c9df41-50da-434f-c75d-08de80522543
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 fv2iviUaRlOlKD8xzTwk95cuSts019fAmylwwBy2wg8cyWn6WJXJ+5B+Rql6b10DejAv7HCE6fSwAOpJmMG3QQVuTeTieGPUJqJglThRPbp4IWxVGVB+fU9hRmSjNXDtCkrgOV06KI956UaERhMlfAiM599DmEzc18kWRwnHo6w9JeMPo+A/hTD/bEJyK6PoQW6WxtbBL79W/LZcJjSkf3hxRr8hG79Pn3fhO7q/xTkfoyZwsuQhmXgJvjoKSLuMSvXxsU0ZPTWwnybxByHO5EhDy0ivb3HFb+6J6Pt/rmd4I99SSV6pv6B3xcIcS7Hh+zhXE6EJvosPT0GsnzS+S17J4mHvVUmIjp+T/Puj9jzLZJnn/8B8XMAv3/mjW53t2s2vUPmCA/1v8T72EV6h+FhUMV2ph7hEYh0IVxmQMRkBvAb7uy3fMG/l/XfKllTgZ0QfF1OLQVVgSE6fzE9xZWynqhgcGajNG6iRWpthocIp2IkpQwGgw/C23uUccqvA/ueiOxY23CKC/B5nQnjibi5KAEO45559vXl7j9OpYM8+txDvvIVCRRHSRn530k7l5tzBeUuUpgAG8LAxLMhLkHdTCyb5XDDypFL1ILXKn59im9ygmqUs63iRex8xCm48kcE6RFxtIG78la3vc2lp5HgG8Y0ddEuplpjrxajCGL+eiIc9qc4bs6c66Dpo5NUOelKXTt+ErksCyAWPc03x4O/UC6YziR6lybG2IidUIzzUH1efGcw9pgajKfEdC8t9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR02MB9321.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlRQdVRYTFZzTEpOWm12UmwxdTBxazNsSDN0UU5NdGFDeVFsU2hSUXJVSDBx?=
 =?utf-8?B?T1pxYmRESzBTbG55WmQ0YVRVMDZ2TG9sOUJmZTNNUzFCTitRM095RERLWnJW?=
 =?utf-8?B?d2MvWEJ2MGlrcXpCaC96Z204Mk14eVFlVjFyNWw4YzVqMzJNS0xrY2JNeWc1?=
 =?utf-8?B?YTE4WmlyQ0ZRS0xRTFZiMzV5YmI1SE1NSDV1am83VE14bEZqYXBnVmNTWDkw?=
 =?utf-8?B?b2hSRHFXK2NPR2NNRkVTWk5sOW11bVdEcnoxczJqVU9DN09DU3FzWEVSUzhJ?=
 =?utf-8?B?R2l1MEdGaEcyUWh2SVlTVzFxWkc0RXJEVVFJcWwvWU9Sd3lWMVo5WXE1dXYr?=
 =?utf-8?B?YVB3cmhCYWs4Tkp1dStyR3oyWnNPMUNqMm5CZ1NHZ2lycVpMeU95RUFoQVhX?=
 =?utf-8?B?VlJPdmY1Rm5KZzJIblpYVzlFbkg3TkkwVU0raEJrZDIvbHMyNmVMWVZLbFlG?=
 =?utf-8?B?bUJGV3diSTQwbFRPQkZuV0JQWWNqUzdKRFNSb1dzRDY0cFVNOWNUZU1SNzBN?=
 =?utf-8?B?ay9vUjU1Mit3V0lab05kOEVvTHhaK1dIVTBoc3hSaEZZOC8yV2RlV2cvVzFY?=
 =?utf-8?B?UU5LNDREMHNEcGl2dVpWODhkQzl4RGFXSmM5bUQrdDVYVU9NMTlwQ0NINEhS?=
 =?utf-8?B?OUp0djRDQWZXd1dGU1AxVkVxYmFpZGlHMGEyQzNkL3NRaU9jQnF5MkVJUnpG?=
 =?utf-8?B?cWhFYlg4Z1RxRDljMXdUQ1JHblhXUVdWaGwvQjBYTzlidFd4R0Rzd0RNMG82?=
 =?utf-8?B?NHVUTnY0K0RTVm1pOXNoanhJdWhXOVc3S1JxMnNPUEsvRTE2VEhjWHp1cXVT?=
 =?utf-8?B?Nlh3MkswQ3lydHVZOGJVRmhWRUVrZlFpRUYxYlZkb3BoNG0zRU1oSHJiR0l4?=
 =?utf-8?B?VGhjRDZZaXhFK0lKNnZINkJKVEkvMkxDcXZEM2NjWmQ4WWZPYmdnUS9sRVhS?=
 =?utf-8?B?OUxwbUNFMWR4Nk80MmRKN1dJbGpxNlREM2MwZk1ubVlLRUI5aml0SFJUbW1U?=
 =?utf-8?B?RzkzL1hiV3VOY0h0WVRoOXc5NWNQaVpGZFJtRUpFVTNkOWpNaHZiUGVYRUZo?=
 =?utf-8?B?aDRScVc1YTNZV0hJNW51Yk4vempjeU9mYlVkeFNQL0k5bnN5T3BOV1o2VVkr?=
 =?utf-8?B?OFdoNmRIWVhmQ1hCZDNhT3c3YTJRUzZVUE1raStaK0piSFJLY09aRlRsWDRp?=
 =?utf-8?B?Mm5nc3hRRTFmZVp4RzNBbFlIWlVTRGJjUFlWMjZGLzBIQkJidnZFZkVtNis4?=
 =?utf-8?B?Ti9hTHJIRVQ3aXFPckV1aU9ieXk0cDRRVUF2TDJPa2JKeCs5ZjdYSVdUbWN4?=
 =?utf-8?B?RVBySEQ0djZDTUo4ZGttOEZFamsyZisxSkZCb0x2eE1mcUJ0RzBPTFBOQm04?=
 =?utf-8?B?NGlieDExc2x1ekZGbFpmNGFZOHlBNW1jQnNxblYrZ3pEdUhPV20xTHh3TSt4?=
 =?utf-8?B?STdlOUxCT21haUtDOVJQWkJCZWJWbXhOK3Fqenp2QmIxMkllQ05QTndsejla?=
 =?utf-8?B?bmVmdnh0Z1VaaitzZXJkWldDWEhjd3h4L044TDRYVW90TlgwSnkycWdFVjVF?=
 =?utf-8?B?NjZFbXE0bUoxVVhvTmJzTXB6Qm5rQnIyOGo3OGtnR3ovUkh4dXB3TGx5ZU1B?=
 =?utf-8?B?SEtDSUdYMjJhZ0lKUzh0QlVQMTgrQ2V5Sm5CdmpRNFJXU2pjb05VWnQva0hr?=
 =?utf-8?B?ZzlMMjRGMXJNTGwySXRBZFlYdnZVQ045akhMaW4vT0l3elJ0TmFWWkExaDVl?=
 =?utf-8?B?VXBXKzJJU1VLS1VFcGVTSmwwdmVBMm9zL0dXSTZ0MG55OTMycURmdHBjZDRK?=
 =?utf-8?B?OWp6ZDFrZzl3QlQ5dnJCenJJN1ltVG1MWEYzN2hEZ3RCZ1lIRzdpWmxoMjN5?=
 =?utf-8?B?cEw5VkgwZUFrV2xtUmVsNFIzd2tUeG9GREw1UjZKSXZYbmhwcHVTVjFLMFZM?=
 =?utf-8?B?RE03dDhrNWExVUtHcGFac0dxMktjTFNlZ3RtV0NNOTMzekFpUEVHQXhTV0lU?=
 =?utf-8?B?dkRacWdWQ3JucStHVzdNN1VSTTE4bUhxRjRZRXJwN3Z2THU1YmVYL2krL2Iw?=
 =?utf-8?B?UWhCNit2aVFrUW9PQzEwblAxOUE4ZGU1ek13KzJubllnS1huYTBMM3V0MDZE?=
 =?utf-8?B?S3FucVVhNUppZ3llM0dORXU2NTlXV05IT1lCczc4bEttNXcvT2M3UlVsQ3B3?=
 =?utf-8?B?MVoxVjBEWHZpd1hjTE9GR0ovRmhIM3MwRitNdkxHNUFlc3hvdEdHNHdGdkMw?=
 =?utf-8?B?Y1gwdWdPZkhscmRNY3IzYzc3ZDdOSEZtWWNKWUQyMWRraUdoMXV5RW5oSVhG?=
 =?utf-8?B?L3VSMnp0ZEV6eHJYNGVkdXBINDR5NURIems1V2wyK2MwVG5pQWYzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	DHiYFEptDGGqsaqtpk1BDfSrtZnR2n/KflsoHU+3leufjZPNhmh9rLLRGyKkB9UQ+ElhpkvKlGYijQLOGGVsfOZKspBDTyj6xJbVq3PPEYQT4ULHe5v1lbRGQ9kRp7a0m6JVKn6QLVK1q8T+npRoYJNV9cwVQUSkEHuqP+Pz+AYJ1+TqnuHoZ4NE1nHeUBRvMd0JGPUQJsLCNEME5OMdOqfDy+f14/t9LlKvGGjqMhcR9CpN45c+bJwYMYuZJQETAPPDaAfSoL0SWbXuzac4P8rXezHoC2HX5Nj50nN9Mj6XQmuUub1U5rrvidAv+7bQTNrE8L7yHtg6IXhJYgISRQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB9321.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c9df41-50da-434f-c75d-08de80522543
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 16:12:23.3930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvfuevYn57GjWmfkoFHqReca88d6RpmRrtWLoWKBxpkmX3eSiAsarofuuXL3oyE0Jtg4rY0L8ZcgSHOX3GB3AmqZSw4YCGepCx+yk/UHN7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7364
X-Authority-Analysis: v=2.4 cv=PfbyRyhd c=1 sm=1 tr=0 ts=69b2e5ea cx=c_pps
 a=a9BdPFFbNpLpmASqG3lITg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=64Cc0HZtAAAA:8 a=1XWaLZrsAAAA:8
 a=vggBfdFIAAAA:8 a=mLnsDVdbAAAA:8 a=20KFwNOVAAAA:8 a=0-GYFruou69s9O4IY-gA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=xnp1pY6zelCj5OLna2To:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDEzMCBTYWx0ZWRfX5FV9xGSk5D21
 /Vy0dmXPUMzcStS1NTp3VE6fHkIpS8UavaGLfXzpJhOvnCd8iFfDBO3MEbQ8TQShqOkQHs0zAj2
 FhL5kin9q0GiumGGEuhsBxPY3aVIk8ehGw3F/dkvj3QPwZtZLuPyH+jFe+H3+taqVdFG6KdCudT
 2SvmkAdgNaKL7S3HDWL0WnHjT1yHRqxF+q0zrDrJVYuzTvGnwI2Gh5AeQX9O+H14lkGD3d63BgZ
 1yG4YeyHai1m1Ei1DPJHIVXK1/22a+cS5wPbP/DCQEAJpNfnP2cY8+1u5gzgxu6Y9l6D3g6MbGN
 ylT3rp90B2dGZT/dgsx4WNg1tiTJfRKMME0vvMoWwRYBfBmYlFTyF6wTY0NG86uqZyCnY7I6F4O
 h4ZecSgC+9JK45OlLFWJUJuxhBtSqM3Ot2jZV96hTvh9NbzMIZwah2l+9KaD/ZAvoh0DuqTLLa8
 S49qfSv0bTtXTpjsZQQ==
X-Proofpoint-ORIG-GUID: N3eqslsG9P6lqLAVmXqrdIzNqJfO1YYW
X-Proofpoint-GUID: N3eqslsG9P6lqLAVmXqrdIzNqJfO1YYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgV29vZGhvdXNl
IDxkd213MkBpbmZyYWRlYWQub3JnPg0KPiBTZW50OiAxMiBNYXJjaCAyMDI2IDE1OjAyDQo+IFRv
OiBUaGFub3MgTWFrYXRvcyA8dGhhbm9zLm1ha2F0b3NAbnV0YW5peC5jb20+OyBzZWFuamNAZ29v
Z2xlLmNvbTsNCj4gU3RhbWF0aXMsIElsaWFzIDxpbHN0YW1AYW1hem9uLmNvbT47IFBhdWwgRHVy
cmFudCA8cGF1bEB4ZW4ub3JnPjsNCj4gZ3JhZkBhbWF6b24uZGUNCj4gQ2M6IHBib256aW5pQHJl
ZGhhdC5jb207IEpvaG4gTGV2b24gPGpvaG4ubGV2b25AbnV0YW5peC5jb20+Ow0KPiBrdm1Admdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEtWTTogb3B0aW9uYWxseSBwb3N0
IHdyaXRlIG9uIGlvZXZlbnRmZCB3cml0ZQ0KPiANCj4gT24gRnJpLCAyMDI2LTAzLTA2IGF0IDEy
OjU2ICswMDAwLCBUaGFub3MgTWFrYXRvcyB3cm90ZToNCj4gPiBBZGQgYSBuZXcgZmxhZywgS1ZN
X0lPRVZFTlRGRF9GTEFHX1BPU1RfV1JJVEUsIHdoZW4gYXNzaWduaW5nIGFuDQo+ID4gaW9ldmVu
dGZkIHRoYXQgcmVzdWx0cyBpbiB0aGUgdmFsdWUgd3JpdHRlbiBieSB0aGUgZ3Vlc3QgdG8gYmUg
Y29waWVkDQo+ID4gdG8gdXNlci1zdXBwbGllZCBtZW1vcnkgaW5zdGVhZCBvZiBiZWluZyBkaXNj
YXJkZWQuDQo+ID4NCj4gPiBUaGUgZ29hbCBvZiB0aGlzIG5ldyBtZWNoYW5pc20gaXMgdG8gc3Bl
ZWQgdXAgZG9vcmJlbGwgd3JpdGVzIG9uIE5WTWUNCj4gPiBjb250cm9sbGVycyBlbXVsYXRlZCBv
dXRzaWRlIG9mIHRoZSBWTU0uIEN1cnJlbnRseSwgYSBkb29yYmVsbCB3cml0ZSB0bw0KPiA+IGFu
IE5WTWUgU1EgdGFpbCBkb29yYmVsbCByZXF1aXJlcyByZXR1cm5pbmcgZnJvbSBpb2N0bChLVk1f
UlVOKSBhbmQgdGhlDQo+ID4gVk1NIGNvbW11bmljYXRpbmcgdGhlIGV2ZW50LCBhbG9uZyB3aXRo
IHRoZSBkb29yYmVsbCB2YWx1ZSwgdG8gdGhlIE5WTWUNCj4gPiBjb250cm9sbGVyIGVtdWxhdGlv
biB0YXNrLsKgIFdpdGggUE9TVF9XUklURSwgdGhlIE5WTWUgZW11bGF0aW9uIHRhc2sgaXMNCj4g
PiBkaXJlY3RseSBub3RpZmllZCBvZiB0aGUgZG9vcmJlbGwgd3JpdGUgYW5kIGNhbiBmaW5kIHRo
ZSBkb29yYmVsbCB2YWx1ZQ0KPiA+IGluIGEga25vd24gbG9jYXRpb24sIHdpdGhvdXQgaW52b2x2
aW5nIFZNTS4NCj4gPg0KPiA+IEFkZCB0ZXN0cyBmb3IgdGhpcyBuZXcgZnVuY3Rpb25hbGl0eS4N
Cj4gPg0KPiA+IExMTSAoY2xhdWRlLTQuNi1vcHVzLWhpZ2gpIHdhcyB1c2VkIG1haW5seSBmb3Ig
dGhlIHRlc3RzIGFuZCB0byBhDQo+ID4gbGVzc2VyIGV4dGVudCBmb3IgcHJlLXJldmlld2luZyB0
aGlzIHBhdGNoLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGhhbm9zIE1ha2F0b3MgPHRoYW5v
cy5tYWthdG9zQG51dGFuaXguY29tPg0KPiANCj4gSW50ZXJlc3RpbmcuIElsaWFzIHBvc3RlZCBh
IGNvYWxlc2NlZCBNTUlPIHBhdGNoIHNlcmllc8K5IGEgY291cGxlIG9mDQo+IHllYXJzIGFnbyB3
aGljaCBhZGRyZXNzZWQgc2ltaWxhciByZXF1aXJlbWVudHMuIElJUkMgaGlzIHByaW1hcnkgZm9j
dXMNCj4gYmFjayB0aGVuIHdhcyBlbXVsYXRpbmcgYW4gSW50ZWwgaTgyNTU5IE5JQywgYW5kIGhl
IGlkZW50aWZpZWQgTlZNZQ0KPiBkb29yYmVsbHMgYXMgYW5vdGhlciBwb3RlbnRpYWwgdXNlIGNh
c2UuDQo+IA0KPiBNb3JlIHJlY2VudGx5LCBJIHRoaW5rIEFsZXggaXMgbG9va2luZyBhdCB3YXlz
IHRvIGVuYWJsZSBkb29yYmVsbHMNCj4gZGlyZWN0bHkgYmV0d2VlbiBndWVzdHMgd2l0aCBhcyBs
aXR0bGUgaW50ZXJhY3Rpb24gZnJvbSB0aGUgTDANCj4gaHlwZXJ2aXNvciBhcyBwb3NzaWJsZS4N
Cg0KSW50ZXJlc3RpbmcsIGFyZSB0aGVyZSBhbnkgcGF0Y2hlcyAvIHBvaW50ZXJzIHRvIHRoaXMg
d29yaz8NCg0KPiANCj4gSSdkIGxvdmUgdG8gc2VlIGlmIHRoaXMgS1ZNX0lPRVZFTlRGRF9GTEFH
X1BPU1RfV1JJVEUgd29ya3MgZm9yIHRoZQ0KPiBpODI1NTkgZW11bGF0aW9uIHVzZSBjYXNlLiBJ
IHRoaW5rIGJhY2stdG8tYmFjayB3cml0ZXMgYXJlIGRpc2NhcmRlZA0KPiB3aXRoIHRoaXMgbW9k
ZWwsIHdoaWxlIElsaWFzJ3MgcGF0Y2hlcyB3b3VsZCBjb252ZXkgZWFjaCBvbmU/DQoNClllcywg
dGhleSdyZSBkaXNjYXJkZWQsIG9ubHkgdGhlIGxhc3Qgd3JpdGUgaXMgdmlzaWJsZSwgYW5kIHRo
aXMgaXMgYnkgZGVzaWduIHRvIGZpdCB0aGUgTlZNZSBkb29yYmVsbCB1c2UgY2FzZS4NCg0KaW9y
ZWdpb25mZCwgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzg4Y2E3OWQyZTM3OGRjYmZiMzk4
OGI1NjJhZDJjMTZjNGY5MjlhYzcuY2FtZWxAZ21haWwuY29tLCB3YXMgYSBzaW1pbGFyIHByb3Bv
c2FsIGZvciBmb3J3YXJkaW5nIE1NSU8gd3JpdGVzIHdpdGhvdXQgZGlzY2FyZGluZyBiYWNrLXRv
LWJhY2sgd3JpdGVzLg0KDQo+IA0KPiANCj4gwrkgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjQwODIwMTMzMzMzLjE3MjQxOTEtMS0NCj4gaWxzdGFtQGFtYXpvbi5jb20vDQo=
