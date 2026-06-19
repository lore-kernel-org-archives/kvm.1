Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2E92E3FE;
	Fri, 19 Jun 2026 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854438; cv=fail; b=l8TSLo1UCUw2R9Mo7IkAYRs0t3+TqFA1nj4BiB1HC5R0Fp8sfu1Y1/de/wE/grfoyk3RDHCMejQMtN6XweoYsTAnGxrfyB/kErBDnz2I8Xa6e4DcfSRfXD6EbgwG5nnDZVE97b+UkOnfUZzsaFDMnf0ig1mDIA4EUJd0fBGYBUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854438; c=relaxed/simple;
	bh=U20IpPHZpzb68xnS+kX2wwldifrVkqC9U5rjIm7o6a0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NSIqwWccllGnsPEQP/ojqjG40A0jrqm4dsX/Au61Up3gCpBwqC9Goj4RjDVHrrPfLrCIivVfTicnUsSJcXikeJx2+y39YBAuVZnGWSde0i4u0x1X5PEHiImhMzpK/QNobZ3BYc5B48bGOhOHqrzedptoFiO+2nQbQg/fHkF1HIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBVF4usv; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBVF4usv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781854437; x=1813390437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U20IpPHZpzb68xnS+kX2wwldifrVkqC9U5rjIm7o6a0=;
  b=OBVF4usvIdctdwT/VdT28KRMNSHWKK3/Y+X4QglNiZ/hMXXVbW8VLLc3
   +dPB3fn18eWvv8enFOglIkxhJu8iqFpn6tpuU+APX2i6mQkAbtTuDyiYe
   kb/PPgDMWNolB2fiD4tD3V3HcfiBzh8xMqV1iv2z8XWaGO/LFhPdXYvQa
   ZxR1a7/6ZrzeDbHLoib3jHjk/zk8Vz7kZZqh2GSiQ6xfh/PLjtPLBqPdI
   xXdmCEDScy3xaHGVMvvPjX4345bp4Abokzs7ITznLmdsApUfZjKTnI+1N
   cdFMQdOYrXHH+zGs8ZGy002eVr0LwDbnCi9DPZY/KxfoLk+13b5Cb2kZE
   g==;
X-CSE-ConnectionGUID: p1T3Xad1TE2EntUSKhL0GQ==
X-CSE-MsgGUID: 7PvnrZwESPehaUbF+yJIvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="86616610"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="86616610"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 00:33:56 -0700
X-CSE-ConnectionGUID: DypeeDk+SPSsAHGpfMXpeQ==
X-CSE-MsgGUID: HMffNwOkSx2oik1EkNdnbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="246225241"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 00:33:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 00:33:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 19 Jun 2026 00:33:55 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 00:33:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bp87rTLIhzyxr48u+RSjXbc+HFFMnqmWybycFQvAU5bVzPFLoWtIvlvSuxwY3quVqv/PfqGkvCbkit0aDwUtm1lYSytvF7S2DpG9FUXigYiUaPnEoEmkN0TjxVZ0RVoyhJsqZE+0JhM8/rxQT27UyTwgPuKFTEk5TWIG3sT+oi5Mr9ZQp7NQaJsRIDXcJwDgDrsBimpJkKRbrqaSoLk96UnnOhEIRFySd5pHoiQ1OF9br6NlWJGGzy3PrXoMptlruLU3t3wVwR07DieYGpX4LXr7P+PQCXGPsq2jTUsnoN/pvC27JEHR6jrsuKuXTMom4vWcpxXGJDaF0p1S4L6R6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U20IpPHZpzb68xnS+kX2wwldifrVkqC9U5rjIm7o6a0=;
 b=HcxZSYNIksZwfAipyoqzyH6eE0I+LovwBHJAoXffiUgH3tv6vTd8vwspZnFovNDPWCq5nguiyn5o7gkVy0lwqOz7M+aUasnWiTMPYTS2NAww3k+pHHF62gMGgffyDYUNjTX3BIUMnXoNr5aiOtsxFryMWPCwpPmaYIt7jOyXHnlsZkiQ8Kp7gcN2BIcnaKP1z4F5r3mBCRmDUd2T7ppBGzDTGB00mRBuzxaABSOktrGXRnTLs+Ys4+l/O46ol0kGG2VCJ5uIyTZNdzxhsU+AtWRrqkn0QbMvG+iWGs0Dlxbsfgb8UBnw2PHA9zGCL6ZeXQiEEb8tXMjU0bacUDm1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 MN0PR11MB6160.namprd11.prod.outlook.com (2603:10b6:208:3c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Fri, 19 Jun
 2026 07:33:52 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 07:33:52 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: WARN and fail kvm_set_irq() if a PIC or I/O
 APIC vector is invalid
Thread-Topic: [PATCH] KVM: x86: WARN and fail kvm_set_irq() if a PIC or I/O
 APIC vector is invalid
Thread-Index: AQHc/1O5DS9c7shqdUyqngcxn+JxF7ZFfUkA
Date: Fri, 19 Jun 2026 07:33:52 +0000
Message-ID: <b635ef8f645f2fb59cc5ccf1b34f63ca86732570.camel@intel.com>
References: <20260618185213.2019937-1-seanjc@google.com>
In-Reply-To: <20260618185213.2019937-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|MN0PR11MB6160:EE_
x-ms-office365-filtering-correlation-id: b49dbf20-e838-4312-a4e2-08decdd51cc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: CeG23YTSQpw8pQk4xrsclCDo01p3tFVj54PV3T1ZCBABjwBhPjytKz11odnZDW42w9lPp54AKShY1qtATlhUf2JmUvtne56U1KBQmKPskx2+dg0OndrWuJPl/4BDvLpC/gqEfYhU6IXdAzCdpik29ECPvdnpSdYzz/7Zf9/XBOiaC3z8OUR6WGWA78BmyFOzSrtSMMiTmuVcjmk0kfZ6G+rAXmJ2/h4X9ShPNyD0/SgTYvo8vlqcHtdtRyFSug1QdIKi4s+g+otUtehwee6UL0icmjrCZIaJuoZL+l6RHRZ4CEUDw9tDpSBCSPGLrGzvHliZwdQpv9l0ElSu6fZ+V8M+x1Dkza2zKmbGxM+pv+2vziwRkUj5YYsSVCFXa9PKo11T7MttXyZuaTshRE7Zk1bJcD+tueDq1Urqu1abvqTYrshBBQYcfaIAtdtftp+0CPLhA2BnqThsGAY3su7j9AOQbrPwZXh9F/CaOlu7W3DU3h17kMibNdqEay168NchRI6FpUlK0Y5F+v5q3zN7IRXUm0M10/qJEEzg1BjLTqpSWsSqieDJgVZP2JNJn3Zc8BMZPQbneMZTLbCtRbSZR69wT3APnil4Ij56Mka82hdlzeUUOTv2POJOYm7/DmOLLNSzGV4eu6MM7b3O7CL6lFa8RixeaQ4ELkUIBPqs526CoZdBLSqWm35PTMLbliKvG7IfUjsWAD+s/d7sUulgY9g+MoaCYZKVl1ppILjbYZo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmkzcUV3NGZlWERWUHA4WDF5citsa0ZKeWJtOE9FL25pemRhcWFCZXA3allV?=
 =?utf-8?B?dnBXQmdVMTVHcmtyaVh0bGNWazV3U1NrdEJwdzA1MEFkZjI3ODQ0bm15NEUw?=
 =?utf-8?B?dEt1b1pwM3JXd252eVMwYWlmNEdMM1NqbCtUd1JYZzN1empkWkYxNm5Sb2x6?=
 =?utf-8?B?dUh5enR5cVVuYm1NZ3ljekVRTHE1K3ZXNW5vOUJKQnlhL0pGY2tuKyt6R2J0?=
 =?utf-8?B?ZHRrVFA2dFpTRWRhSGlQNTdITkloMm9JTjBiT09IMmlWbDh4VURPNWVJUmZt?=
 =?utf-8?B?Sk9iVkZiN0RUdHBueHpuS3JrMEpzOUxMK2VJVmJBQm40QTdhZXdvRnhuekpv?=
 =?utf-8?B?WCtJNllNaEI2N1Z4ZzVtTEZBUzhzc0FuNHR3c2FIRUNWUGs3OXVOTGVYU2ln?=
 =?utf-8?B?WEYzWUd3b1dOR01MVmp6T0FGRldyQWR0c2U1ci9IcmRBaDI2bXA1WWlyU2hK?=
 =?utf-8?B?S3dsR3pGK1BKWGVXVHZvcHpkSTNHZG1tdXlKVUV6QjdEQllNYnZjRTU1bTNC?=
 =?utf-8?B?ZnhEOWVDaXB6cDVsWDZGQmMyNkdXUTlLZ3paL1BlZUJaYTVTc0hLc0ZCTGpl?=
 =?utf-8?B?WGZ5c2dhUVlCWkp6T24vb1dPNTBRa0dNSWdrK3lqVzF5MnZQSjMvVE9yNG4v?=
 =?utf-8?B?eDhaUnFUM1kyME0yck92dU0wQy9YNEJoaFdBNXcvR3JLa0UvbTQ4b0lBbUVZ?=
 =?utf-8?B?YS9LMEFtZGllWEplYVJDTUZxOUQ0eGxyRDZDdk9zbVByTHBCWWhYaDFNcXRT?=
 =?utf-8?B?UHgzeEcvQmZJMFVtTUh0RWFiS1VhSGFGMGJ0TUJwdEVmaVZxQkc2VTY4YWRa?=
 =?utf-8?B?MHIrTmpjMCtJOUh3anhEUHJqc1NXWDd0aE9zMWhFWGVvNksyWkZoSlFWUE9a?=
 =?utf-8?B?b01JQ2RtU0pGeW9hYWNndUNDTTZjQWlIU3FtR0ZmdjJnUU1wWFFhMksvcDNC?=
 =?utf-8?B?dUg3dnE4bURBT1V2SVo4SkhlZzdEV2o5STFHSVVwMDhkbEUvRVdJOFVUWDUv?=
 =?utf-8?B?SS9SenBiLytRbUppYnBvb2dPakl6T2QwVm8vVU4wZ3lMSjIzQUtyclhUT2pQ?=
 =?utf-8?B?Mzg4TFAzeGd3RkJyOGFLeEFOWTFQL0phUnlyNzJBeVpVSjlDR0Qwa0dhajhF?=
 =?utf-8?B?ODRlTzJGSDdLOGxRczYzem04SnZXU3NmV0o3RGRCODBiUHFOQUJtZjViK29i?=
 =?utf-8?B?cHhHR3pHcGl6Njg3TTFWS1Fmc2kwd0tJTk9ZM1hNVzE2TU95d1VUY2RleTVK?=
 =?utf-8?B?SndVVWV0ZHl0d1ZIL3NKaElyTmxOSTRDQjZxL0dscnAvaS90NU5JbkpDL3Bm?=
 =?utf-8?B?eHRSQy9yN3NkYXQwVTZRTUh1d2c2UjZKd05LR2lSZDhaSlVQM2huT21ENXh1?=
 =?utf-8?B?dW90ZHFMSHF0Y3liNmFVNEtXRllHam5FMGdLb0NDUXh5eldRc1lZQ01kQ3Ar?=
 =?utf-8?B?OS9uWFFXUXp5d1BKbWxlWjVia2dyYjZGUVBFZkdFZnVKMGpxcGV4V0VaMG1I?=
 =?utf-8?B?MVJibTIvQXFNQUpraHpYOThGSWNWOU91ajNmVTlqaGNjRWh0cjIyZ3J6UEVR?=
 =?utf-8?B?a2QxTGxKUExtbXlzUUEveVgwZnEwYnRjQThISXdNV0YvdWZOQVlyaFFqQlpS?=
 =?utf-8?B?c2NuMC9odXNNWm9FNUNBb1VwSXNsdFdxaXMvbWh5elNhR1hwaEY0bmZpMGFP?=
 =?utf-8?B?TThzMmpPT3ozb2xQeThyL3paNVAwTGhvbi91OWRmQnhVZzZQZUtla2xEZlNF?=
 =?utf-8?B?MDZmbksvWXdKRStqczNsZTdnZGh3TzY4aTRtRDFjdU8zbm5laVUyYTUwOEQv?=
 =?utf-8?B?OXZyWjJ3amYyS1oxYzZzeHdPaEdWM3cyUjBkM2IyVWdUclhQTVgxSCtQRHND?=
 =?utf-8?B?UldJdE1waW1hY0o2OHNVNEhvOVRtS3BvL2ZBSU1TY1pZekh0SnR1aU81MjR4?=
 =?utf-8?B?OWdhMFlUSnFacGVHa0FQYWg4VElrck1aNzk4RFp3bWtDdGlqVlNXTTdhOHpm?=
 =?utf-8?B?TTFPSWJZNHN4b1BvZUl0WGpWS0tYZDJ1ZitYa25VMW5lanNGTitYZHRZZk9z?=
 =?utf-8?B?ZFZ5blJUUGlIdDBkbFhsMkt1WW9JQlpCMG1FQ2VpWEsyd0E5MGxVRVlrcFdD?=
 =?utf-8?B?RFVmb2lqbjJVNHYzcXkwUnp2eDhZZG5oYVNGM3BaV0JiWXVTNGovYkF2OFd4?=
 =?utf-8?B?RzN0Q0ZXcFBadThHWk12RVR1eDJvRDJuS1FOeUYxOUhHZE5SZUFMMDBtUWdD?=
 =?utf-8?B?YmVQajFsNHI1NmhaU1dlWlk1VGdQYUREMkgyN1RHaXI5WFNaaGoxOVNGYmZu?=
 =?utf-8?B?MzRKdWsyMk9OdUFDVnhwc2JoRDFOM0hIRDZ2VzZBR3JzMjMzNGE5Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE5488B1CE85FA4CB31A1193DBD7E85E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: myJIr+rzMAP/vvqf18Z8k8kgKM+fN0x/ip3cA5SoUqKtsQ1khrZxzwp6i1q6tlhAiP+qjDTbL2BwvOxNkhKJgD6fKJ20x26j9KrQenLB1eJnM67NE95kWJjIP8tJVWhuPqFbZ5AwUXe2SrtbfmfwPXo0tQs0M7hVkLQ9/Bw/cmE0i7Eb4XzOfy+/JfHaTCAgXU7MfZh59kRWnuD4kH+B0L3H+L3KGN5R9Cc4p2mDgU3gcvUgrzG7izViKnwI9vBn7j2zp3YxGTpP3WIqmNBuNCrCEDIBH3NRf93tQrpe63tGdvfndT/zY/52lLrCBv1YWHt7ncOEkMahqQiPx73Quw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49dbf20-e838-4312-a4e2-08decdd51cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 07:33:52.7312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ubNTFHUaMVc9Am2hD1YihYyUWHzHVj+vzU5k3E3tj7/9W5aZW2XuPXC3bS4yjiOdjMFkKBq37YCDH6aOxVjOCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6160
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTE4IGF0IDExOjUyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBXQVJOIGFuZCByZXR1cm4gYW4gZXJyb3IgdXAgdGhlIHN0YWNrIGlmIHRoZSBQSUMg
b3IgSS9PIEFQSUMgZW5jb3VudGVycyBhbg0KPiBpbnZhbGlkIHZlY3RvciB3aGVuIGluamVjdGlu
ZyBhbiBJUlEsIGFzIHRoZXJlIGlzIG5vIGRhbmdlciB0byB0aGUgaG9zdCBhbmQNCj4gdGh1cyBu
byBqdXN0aWZpY2F0aW9uIGZvciBwb3RlbnRpYWxseSBwYW5pY2tpbmcgdGhlIGtlcm5lbC4gIERv
bid0IGJ1ZyB0aGUNCj4gVk0gZWl0aGVyLCBhcyB0aGUgcmlzayBvZiBjb3JydXB0aW5nIHRoZSBn
dWVzdCBpcyBtaW51c2N1bGUsIGFuZCB0aGUgZ3Vlc3QNCj4gbWlnaHQgZXZlbiBiZSBjb21wbGV0
ZWx5IHRvbGVyYW50IG9mIGEgbG9zdCBpbnRlcnJ1cHQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBT
ZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gDQoNClJldmlld2VkLWJ5
OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
