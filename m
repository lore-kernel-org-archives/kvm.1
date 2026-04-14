Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E9313E07;
	Tue, 14 Apr 2026 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776205320; cv=fail; b=t4Opx+mXnlLyszu/eXB7gebKWHFeXml9oCrEa/siM3wangXSv5rMrT6D8asntIYiyB8zyddpsVn7Ctg2nzkGNDnfW9s0TnJA59peZEgU6ut4JDAdMoellgMgyhtn3I1vinoRji90k+bVhrVMTErOHGVzJMISkzCzcxEXoKSP6Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776205320; c=relaxed/simple;
	bh=K6MXsIoEkYTTw+kN/ktjHNBupbphlATVm0cVeD0CcxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bS+hMDv1AqnBUeDskBdPbkJyeIpgDUwg1Mq33W3BqOw+mxiQ6UsVPpRceWq2IbQJUMV6M0XoBPm8+98ue0OqdB3sukCXhuO+/2CGHiS7bfbmSEJDx2Waz3KxMqxr+Q1yelajLAUm8X4krDn+y6LSnnPZn80zC8GjUCeIBaW4wgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuIl0QVt; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuIl0QVt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776205319; x=1807741319;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K6MXsIoEkYTTw+kN/ktjHNBupbphlATVm0cVeD0CcxA=;
  b=QuIl0QVtE/eqVLPz/fyGdvqd8pHqy9GlTN7yP145tWWSaq+HKatY7H56
   EamXDBaFT9PfIwh7TCc7kee6SOBzc1F9xC5O/QgWWYSrjfQmYtX1mjFTV
   fzrvOexrHyQzhbJrhbRtxALtV+EHkNa1HX5Ttx1K0onrgSQuF/eV2qm+L
   he70fOA0jujtqxa+Kw7b7rC6bN9PZTu/R97FiR+c24S5z2lbcGqw0mNCT
   s7RavIBCFDBmUDkm2XS4AFQaWbrvrJXk5V7s0pbTYJxI2l/Sie3agHyVf
   5Or6GmOjOeKnpZonydzo96leUU7esAWuF53k5mMmM7q282QTpxziFFTJY
   A==;
X-CSE-ConnectionGUID: zQAtobX4RgWb49ILIoCw/g==
X-CSE-MsgGUID: XzlEFTakRV+U1RvlIAoH4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77287586"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77287586"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 15:21:59 -0700
X-CSE-ConnectionGUID: Nr9T6gmYTvGgmtgrWCFiaA==
X-CSE-MsgGUID: EZDylMXOSNyGYWkgh/HJxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229360125"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 15:21:58 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 15:21:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 15:21:58 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 15:21:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahYNPLF3D8CMqcRV3VxOT1zn4EAyrUzgNXxJzMVbHU505oz+vvUhSn9hYFVzwd3YssWxDAH/nMr8qqXZM+7N6vLX5m0Cer/7PlwAiuQvLzjfT7GZM79EYSSWleFVy2s/JImfZUJbRjYnoAG2DF+BZR3NvAWLXmm1VbWlXoEkI22C+bbknlP0X/pbPS1gIVxwOU8ymuPVShy8Ot+uxJ4GyJnozStthRv3Q91C6JuuWWEsk78gXkPaOgGxDXNg4M1W639qgbkMD+GglvMAW47v0pMvhRTGdKwz5gkxdGMBVlO+dt2OVzqdgEUuoMeAL1acAScBxuKmGSTmeNYZfKN2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6MXsIoEkYTTw+kN/ktjHNBupbphlATVm0cVeD0CcxA=;
 b=kuEVaUqGgZUIgqZ9L6RlqerUYiMBvT+WjRCEvcGgOLq+amW6SfZ4x62WKy5n2LTbM8iDsWpVLjHo8MB+TluyiRJNwOxL+tkSeZfoF047wAQWkJxysZI44IZRN0/OjvZSzMjN7BsWloWaLOkd52V0//EeQPQb/I7ZwhWy7uvOGcQYw6K0iHQxNgNe27D0AaeqApi7a3Xo9UkXUTBb39kH5Si8Kdb5jfyQJe2psHVJFay4M/Qx2dMxx1zjkzjNg4Uaf6+FIxosysVo5o2CLsivT7r8/9j6T6hv8f0h/gBb31889nhr+/6ZGCQe9wweEfNZA84taQ3vtxpXN0YdBwzqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 MW4PR11MB7102.namprd11.prod.outlook.com (2603:10b6:303:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 22:21:53 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 22:21:53 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Bae, Chang Seok"
	<chang.seok.bae@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kas@kernel.org" <kas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
Thread-Topic: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
Thread-Index: AQHcyHKA2qiN335YikKlMB8aHxcOdbXc4G2AgAA5kgCAAIi5gIABGMcAgABtyQA=
Date: Tue, 14 Apr 2026 22:21:53 +0000
Message-ID: <8be78b378fd34a7c0cf9f4730f46161729d53130.camel@intel.com>
References: <20260409224236.2021562-1-seanjc@google.com>
	 <20260409224236.2021562-6-seanjc@google.com>
	 <e6e82905e6b9b1637ccb640097e67d21793f5895.camel@intel.com>
	 <ad0DrDUsUKTMfrDW@google.com>
	 <d6f05e5fa781ccb465d27a4fb1c7c1ac1e9e95ff.camel@intel.com>
	 <ad5h5hO7_QmJlOVk@google.com>
In-Reply-To: <ad5h5hO7_QmJlOVk@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|MW4PR11MB7102:EE_
x-ms-office365-filtering-correlation-id: 0c7186c3-c62e-40e7-a72c-08de9a743b2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: H3OaD2QvbLH7HYCcfLwnBPgKa3T4qDLcR4mXDOsAQERMKEUQyTJUdA6frMZg0J2fNmJkwXpRk8xs+Bat7NHA+fWCP6OKSFVQ+ReD7HsyesP8x5mMpJ5coF99PUPFby/m+4oUQ7WGZTBgaa31URNNb+CBGCm1i1NFoAGjgoCshqEPlv9KMHMLREFmF8dkStg2UwwJ+ersdfof48nmv1D9l/oLDKKPjIzeoQpj06ahrZQPxTGkJtI8DYREaxlD8uGviVVbB26geQxyayI0NJSXVKDJAlQ6g+wu+XTKq7DOq+BJlYgDkiUPDhuIJAJMkR1bLS5xzTPF3YlNnrBgOLBkFPi5D31oKPjZaeR5KpMRDpI/6TkwvuyhLWOhLhxEJWGs8mLsQCS4HMgH+TD1g+reTw24rVOfKPDvoUppb6fkh7o6l43AKyI9g9IHdslMQVA33ptiQZiXlyC+svChRU/srt/XbRhhUIgJL3LvJf4EdMQgmq7076ZtQ88LgqsDtnXKBf+H+8tkA9RzbkASpWsOhW+Izzh725oPmPnWtjiL9LqthPWU+0V8IoTppGiyaK87e4sbC/IAhbWIR/+/8FsMwixH+8ukBMmRJITql6XGBEuukOyF99VY05D/59FIp5nPXcpaP0w/1eiBvheTu+F2ha3DHu6L7C5IGfv7AuVnmHaJ8UYWU3+i94m0EXHu6thSk4tnPpWdqk+uOTgG/0QmG6fTpkR1OeE+GO0HHUHHWmRQb1nxZa6r0xtrhU1DX9r8lgib9suF+ECGZ1h6LlCBD99Qrb9QjZ0ZV/ps0F+wTUA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1ltUUx6cGsvaFVLRzR0dkZBbXpFQXhrYlM3WkozNjN0aG9wQnduWFpTWHFk?=
 =?utf-8?B?bEQzWGFRQy9iZm9CZXVkbmxkNDRRMmhHRG1pUUttMzhQdFZiLy9VdUhzanlq?=
 =?utf-8?B?c3FuM1AyamMwTW4zR2F0NGt1dXcwc0tpaFBvZEJUcjJkSVZoTDNFWENSM1FH?=
 =?utf-8?B?UXVUMDA5SUFtbDdPNzBPVU04NHExSTZyQ1dzYU5nOFFFMWRuMm91K2xRTGM3?=
 =?utf-8?B?ancwZm92cmNUVGszNitSc0Z0OWdKYUlRemVhbkxycVB4aG1NaU03bjZ2L3N5?=
 =?utf-8?B?NkNrV2tkVFgxZXJLYkxpSExHcXpSYUVyRkVpTUVZdHFnVlJMZm8xemZqU2R5?=
 =?utf-8?B?QjdYQVVKSFh1TnEweXJ4ckhCelpJZmgvdmZzd1VaUnNJRkJsQjFnYnNVWHo2?=
 =?utf-8?B?RytEeFJ6YUZWemNmVnFnZHROVzd5bXpIdzAwYVAzVHhScTRJTkErQjhTL3VW?=
 =?utf-8?B?U0RFOUZabktybExuRW1DcFo5SnkzemFpTGtEc21ZK29rYkVSU1diWDRjOFYw?=
 =?utf-8?B?QjVudUExUFVzYUo3SnliZEJjM3ZrbmxqQnNNdUJVdkdOY0FsSHN4ODJYOCtD?=
 =?utf-8?B?TzJyNnhLMyt2b09WRm5PQnArVmJIa1U3T3EvSlVmbldrcDRQTG51bnpUQVQy?=
 =?utf-8?B?bm1KTFh3Nnc4WDAvdUF3aTQ4MEd3RTZDWmwvTmJIRmd2NDkvOU14azFXZnox?=
 =?utf-8?B?Y2JrR0YxNjJhK3kwOW0vbjhyckwwNHhySEgwTWh0RStwY3MyeWc4dG15dEZ4?=
 =?utf-8?B?L1VPR2c1aTE5M25BVUMzS0s1aDZQM0VvbnViZ0N4dVV1a2VaakZSblltMkpj?=
 =?utf-8?B?YVFzZEIvaFNqNkZSa2lHM010emphcWp3dWp3dFZlUE95M1p1QTZpZkVoY1cv?=
 =?utf-8?B?Wmc1ZmVCTG5HRlNoMXJITThyZnl1MVU1QlNyNnZ5dmRJK0N5aUs0aTZUckFx?=
 =?utf-8?B?eStRUW1ONURnQ0svL29RTkpWSTh6TnBwNllXRlVubkRxcmtDTldzNXlqTGs4?=
 =?utf-8?B?b0tMcHhOOEx5K0FjdFJIa0Q4MDdsNzJxU3Aramg0LzZ4RlVKcEdJUTh1cWV1?=
 =?utf-8?B?anR1OFNHWmsxOGxPUjlQQzNlWEZLR3A1L09tQ2lMTXkzWmNUMWlCOXBjd1pD?=
 =?utf-8?B?OHBrNFk0VG5aMnVZaFlIM0JJandUVUNMdGlXRy9EM3RQYWJjMlhEbHE2Wnli?=
 =?utf-8?B?MksvZ0dNU1Q4aEpOa0EvSWlBMGVzeEJqZ2Z5WnV5QWdURm1BTk5PUElBVmZt?=
 =?utf-8?B?RHc3TE1nSXozT3B4ZExvSHlBZXZzSWlFdlMxbEJFelYza3cwUmNmaEg3aGxi?=
 =?utf-8?B?cEM1UUpXQm5nWFNOZi9ZUzZUK0pvazBiWnBEeGtLRGY1VTRrL0JyYmVucW9v?=
 =?utf-8?B?akQ5djltK0FnMmxvL2MvS2xFeGVkd2hVb25iUU9xNVdYRHo4bnBOeUJVbnhO?=
 =?utf-8?B?c3lrQW1ZVmMybG9GWkk3WlVxODUvVTRtOGhZbWhaWWRrbU8rUnhTdENpbTlN?=
 =?utf-8?B?dnBtdmw5S0g3ZTNsQ0VDSEc4QXJwT29HVUtySnd4eUtuZDRYTGk5T2VGcTRM?=
 =?utf-8?B?WkxiQlRDLzJpUFJUOUpXbC82bTZERDdzTEJoVkJnR05YMFJtVFlybTQrVzNN?=
 =?utf-8?B?SmVxVkd3MWYzNStsVmNhQWh3M2JDWmFjVVRxNWZBWGJpTkI0T0VVZGVibWNP?=
 =?utf-8?B?dkFuQlhTNi9hcGxXNlVPbVl3SU1TY0hPWUZDdnBpT1E1NjdBQk5zYWhXdWJH?=
 =?utf-8?B?eFQ0YllzSkdNV0s4czNWWnoyeXNNcEFlcDJJdWp6ekhuays5L2Yvb1E0cldj?=
 =?utf-8?B?U3l2TUMwaEQ3azVUOTNsRFhSRFdlQ2QwUk1LSVNYRzRLdW9uckFXK1BqNFBp?=
 =?utf-8?B?VXNzalNRTkx3UlE3cFlxVzhnRkhIZzRpVTIxRXM3MTNUa1U5Y2gyTUV5UUk2?=
 =?utf-8?B?bHpPeitic2ZwUlgwRVM5WG1idXhydWF2eFhiNzRZMjE0bkdzOStrdjFCTVZT?=
 =?utf-8?B?QmFWazNNOG4zanVMYy9UeDlScnRLRDJxTGQ4S2xQdS90REtTYW9BSFFYMExu?=
 =?utf-8?B?N2VsaGRaUzZXNzE1dE0zaTZOYTNmTUtIZG9FVHJnVnhOSTJ0RExSOG9ITEMw?=
 =?utf-8?B?YVU3b2ZrUXVBRjRranVhT0JhS0dxR1F3SjhqcUJtSUpZU1J4RUFjKzhUVVlZ?=
 =?utf-8?B?aElFUnlMaG5DMkh2S1dTdUY1MVRnSEVPNWxRNVprczJ0MC9INGhEazlGMHY1?=
 =?utf-8?B?cGYzNzVSODVPa3hBODFoSlcxSTJ3d2VGNUJvM0tXZXByUFltUHlodXZLT2pK?=
 =?utf-8?B?bllXeHM5RjNCbllIS1JjRDE4aXZXTnMxOXpScjBsVDhQSXJ3NkRYUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80AF767A15D9D345AA73B1A1760D48A1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KIENqa4rxlLXjcCxF3ozGw6COdpAW+Sqz3djAMYODoRvpEVf8RHAVdB6PEC0c+x4w7U0mvrAc/9AYeTEsdxIPUm0xeBjS+7+6A43ZPdAvsf2U4sTWYxwZMsN6cOXZDR1dC3QUISTO47r3r8PWzi9wqRfPZMWTSzZHRmw88LRxDL6sFyGLmct6J6vnuUnugJMH08G7EXcWWBKu6rCAEnPYv5xyagstHo0+E80QrWa7B/WrT+ang97m6lFkN/2wnLxbnspxjr5xy27tVgOXeuuG8DehTl5pDvmrxRvhsQol3W6IOeQ5sArYxtolnhxy6LA1ra4LJ+/21kYaSvPvXpn7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7186c3-c62e-40e7-a72c-08de9a743b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 22:21:53.2356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YohL6ksUOHs3+16sGUPF1T52d5moeYuCYAONy+uwNFMbzf3O0Ckv3rUTfUyTq8Hl37voExSKfynX988yg0fCbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7102
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTE0IGF0IDA4OjQ4IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBNb24sIEFwciAxMywgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIE1v
biwgMjAyNi0wNC0xMyBhdCAwNzo1NCAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToN
Cj4gPiA+IE1vcmUgaW1wb3J0YW50bHksIGJlY2F1c2UgdGhlIFREWC1Nb2R1bGUgKnJlcXVpcmVz
KiBSQ1ggKHRoZSBHUFIgdGhhdCBob2xkcyB0aGUNCj4gPiA+IG1hc2sgb2YgcmVnaXN0ZXJzIHRv
IGV4cG9zZSB0byB0aGUgVk1NKSB0byBiZSBoaWRkZW4gb24gVERWTUNBTEwsIEtWTSAqY2FuJ3Qq
DQo+ID4gPiBkbyBhbnkga2luZCBvZiBtZWFuaW5nZnVsICJhdmFpbGFibGUiIHRyYWNraW5nLiDC
oA0KPiA+ID4gDQo+ID4gDQo+ID4gSG1tIEkgdGhpbmsgUkNYIGNvbnZleXMgdGhlIHNoYXJlZCBH
UFJzIGFuZCBWTU0gY2FuIHJlYWQuICBQZXIgIlRhYmxlIDUuMzIzOg0KPiA+IFRESC5WUC5FTlRF
UiBPdXRwdXQgT3BlcmFuZHMgRm9ybWF0ICM1IERlZmluaXRpb246IE9uIFREQ0FMTChUREcuVlAu
Vk1DQUxMKQ0KPiA+IEZvbGxvd2luZyBhIFREIEVudHJ5IjoNCj4gPiANCj4gPiAgIFJDWCAgIC4u
Lg0KPiA+IAlCaXQocykgTmFtZSAgICAgICAgIERlc2NyaXB0aW9uDQo+ID4gDQo+ID4gCTMxOjAg
ICBQQVJBTVNfTUFTSyAgVmFsdWUgYXMgcGFzc2VkIGludG8gVERDQUxMKFRERy5WUC5WTUNBTEwp
IGJ5DQo+ID4gCQkJICAgIHRoZSBndWVzdCBURDogaW5kaWNhdGVzIHdoaWNoIHBhcnQgb2YgdGhl
IGd1ZXN0DQo+ID4gCQkJICAgIFREIEdQUiBhbmQgWE1NIHN0YXRlIGlzIHBhc3NlZCBhcy1pcyB0
byB0aGUNCj4gPiBWTU3CoA0KPiA+IAkJCSAgICBhbmQgYmFjay4gRm9yIGRldGFpbHMsIHNlZSB0
aGUgZGVzY3JpcHRpb24gb2YNCj4gPiAJCQkgICAgVERHLlZQLlZNQ0FMTCBpbiA1LjUuMjYuDQo+
IA0KPiBUaGUgcHJvYmxlbSBpcyB0aGF0IGJpdCAxIGluIFJDWCBpcyByZXF1aXJlZCB0byBiZSAn
MCcuICBJLmUuIHRoZSBndWVzdCAqY2FuJ3QqDQo+IGV4cG9zZSBSQ1ggdG8gdGhlIFZNTS4gIEZy
b20gdGhlIHNwZWM6DQo+IA0KPiAgIDE1OjAgICAgR1BSIE1hc2sgQ29udHJvbHMgdGhlIHRyYW5z
ZmVyIG9mIEdQUiB2YWx1ZXM6DQo+ICAgQml0IDA6ICBSQVggKG11c3QgYmUgMCkNCj4gICBCaXQg
MTogIFJDWCAobXVzdCBiZSAwKQ0KPiANCj4gQW5kIHRoZSBjb2RlOg0KPiANCj4gICBhcGlfZXJy
b3JfdHlwZSB0ZGdfdnBfdm1jYWxsKHVpbnQ2NF90IGNvbnRyb2xsZXJfdmFsdWUpDQo+ICAgew0K
PiAgICAgYXBpX2Vycm9yX3R5cGUgcmV0dmFsID0gVERYX09QRVJBTkRfSU5WQUxJRDsNCj4gICAg
IHRkeF9tb2R1bGVfbG9jYWxfdCogdGR4X2xvY2FsX2RhdGFfcHRyID0gZ2V0X2xvY2FsX2RhdGEo
KTsNCj4gDQo+ICAgICB0ZHZtY2FsbF9jb250cm9sX3QgY29udHJvbCA9IHsgLnJhdyA9IGNvbnRy
b2xsZXJfdmFsdWUgfTsNCj4gDQo+ICAgICAvLyBCaXRzIDAsIDEgYW5kIDQgYW5kIDYzOjMyIG9m
IFJDWCBtdXN0IGJlIDANCj4gICAgIGlmICgoKGNvbnRyb2wuZ3ByX3NlbGVjdCAmICh1aW50MTZf
dCkoQklUKDApIHwgQklUKDEpIHwgQklUKDQpKSkgIT0gMCkgfHwgIDw9PT09IHNhZG5lc3MNCj4g
ICAgICAgICAgKGNvbnRyb2wucmVzZXJ2ZWQgIT0gMCkpDQo+ICAgICB7DQo+ICAgICAgICAgcmV0
dmFsID0gYXBpX2Vycm9yX3dpdGhfb3BlcmFuZF9pZChURFhfT1BFUkFORF9JTlZBTElELCBPUEVS
QU5EX0lEX1JDWCk7DQo+ICAgICAgICAgVERYX0VSUk9SKCJVbnN1cHBvcnRlZCBiaXRzIGluIEdQ
Ul9TRUxFQ1QgZmllbGQgPSAweCV4XG4iLCBjb250cm9sLmdwcl9zZWxlY3QpDQo+ICAgICAgICAg
Z290byBFWElUX0ZBSUxVUkU7DQo+ICAgICB9DQo+IA0KPiBPaCwgZGFnbmFiYml0LiAgVGhlIHNw
ZWMgYWxzbyBzYXlzOg0KPiANCj4gICBUaGUgdmFsdWUgb2YgUkNYIGl0c2VsZiBpcyBhbHdheXMg
cGFzc2VkIHRvIHRoZSBob3N0IFZNTS4NCj4gDQo+IGFuZCB0aGVuIGluIGNvZGU6DQo+IA0KPiAg
ICAgdGRfZXhpdF9xdWFsLmdwcl9zZWxlY3QgPSBjb250cm9sLmdwcl9zZWxlY3Q7DQo+ICAgICB0
ZF9leGl0X3F1YWwueG1tX3NlbGVjdCA9IGNvbnRyb2wueG1tX3NlbGVjdDsNCj4gDQo+ICAgICB0
ZHhfbG9jYWxfZGF0YV9wdHItPnZtbV9yZWdzLnJjeCA9IHRkX2V4aXRfcXVhbC5yYXc7DQo+IA0K
PiAgICAgLy8gUkFYIGlzIG5vdCBjb3BpZWQsIFJDWCBmaWxsZWQgYWJvdmUsIHN0YXJ0IGZyb20g
UkRYDQo+IA0KPiBJIGRvbid0IGdldCB3aHkgVERYIHJlcXVpcmVzIGJpdCAxIHRvIGJlIDAsIGJ1
dCB3aGF0ZXZlci4NCg0KUmlnaHQuICBJdCdzIGEgYml0IGNvbmZ1c2luZyB1bmZvcnR1bmF0ZWx5
LiAgTWF5YmUgYmVjYXVzZSB0aGV5IHRoaW5rIFJDWA0KaGFzIGEgc3BlY2lhbCBwdXJwb3NlIGFu
ZCBkb24ndCB3YW50IHRvIG1peCBpdCB3aXRoIG90aGVyIHJlZ2lzdGVycy4NCg0KPiANCj4gU28g
SSB3YXMgd3JvbmcsIEtWTSBjYW4gKGFuZCBzaG91bGQhKSB2YWxpZGF0ZSB0aGUgcmVnaXN0ZXJz
IGNvbWluZyBmcm9tIHRoZQ0KPiBndWVzdC4gIElmIHdlIHdhbnQgdG8gaGFyZGVuIFREWCwgdGhh
dCdzIHRoZSBvYnZpb3VzIGZpcnN0IHN0ZXAuDQoNCkFuZCBieSAiaGFyZGVuIFREWCIgeW91IG1l
YW4gdG8gdmFsaWRhdGUgdGhlIG5lY2Vzc2FyeSBHUFJzIGFyZSBpbmRlZWQNCm1hcmtlZCBhcyBz
aGFyZWQgaW4gUkNYIGZvciBlYWNoIEdIQ0ktZGVmaW5lZCBURFZNQ0FMTCwgYnV0IG90aGVyd2lz
ZSByZXR1cm4NCmVycm9yIHRvIFREIGltbWVkaWF0ZWx5IChiYXNpY2FsbHkgbGlrZSB3aGF0IHNl
dl9lc192YWxpZGF0ZV92bWdleGl0KCkgZG9lcw0KSUlVQyk/DQo=
