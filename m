Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F03C2761;
	Mon, 13 Apr 2026 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079893; cv=fail; b=ZEbnSJadvR2uVVPldIBGGgCFrXhqdy+Qmbo3cVIzJFI/t36yMuSXjreFSr4qD3jfF6kmP+/wi667sE9slZ2hSD/GyUmdOBT2mmcded6/XsSo39GoJi0mxA7/1AwNH84NQvP3dkS6+oj9J//rzAcPGdXgB7n25jd1SCh6rBJOvys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079893; c=relaxed/simple;
	bh=xPkkeTK8De+p9lM6IQpkB99IbTdnCVLTpRGQwCR+kHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DD1ElKF/9GiMHk9PPCNDh7DjZ0bEbjC8SyQd3EnMO6aqO3Y0jdEOsIDf2i4NQ9x6owfg5lboS12xIpKKNv38FZcC3+qgg1DeYNeti1CdNq+0TYzXZfRD+KUVZmfLtc3MpjkENo1dLhE8D4BRfwK+YDJ33uEjchhE+HZKMZUN3Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GC06fBMU; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GC06fBMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776079891; x=1807615891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xPkkeTK8De+p9lM6IQpkB99IbTdnCVLTpRGQwCR+kHE=;
  b=GC06fBMULHFBEs7cntXj2zFGHDsaFon7Q33TVlmi48YYd7Mu3xn88x5i
   QbT+UhKQmQXia4o0qsgK4ERcHHVRFl2sfB7DEj1UNaS3H12FfA/gIFPz5
   wxTXLGCh6NZrO+FPBVZnsCMMv1aygxmoyC0+y5eG78zyMRPKZVezR/ufw
   p5jhfACAyr6IVrcULHBihBknj9dSyVpIKObvg85iuC0lmWQs0sNYS/47t
   pxc+vUnm9KVsxo18EmKzwhWtMXBVOqQz8JD0iUozNT8InfjYtN95rUfwq
   4soHXHt6sj07PXQE6CwyDu3bsaRlFFkweSGyrK0UxONxP7v44JKVShbP8
   g==;
X-CSE-ConnectionGUID: RVB+wuEUTW++fKIKt01PFA==
X-CSE-MsgGUID: 0+jf5TaOSMylGKkh669A3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="94585344"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="94585344"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:31:31 -0700
X-CSE-ConnectionGUID: ZD3y4D0eQbuX15UlZ+dJyQ==
X-CSE-MsgGUID: edVXUS8zTESIg7pWszhYGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="223276441"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:31:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 04:31:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 04:31:30 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 04:31:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9fj9J77Sl+OwqmJoDCILhlavMtSLIq4LE+NjfkvtNXc4bOC6EmSexxIIhbbzuXuEJSJYPwb1psymjcrQZ+69GfPQdAw1dAlB2eKVG4Ok7t5mMOIKjdn9JGe1dixAvoZYQDNurhhh/myROjv/apVbMlW57J0SJPo4lBFD+1ALy7FJOGHVAk4C/yiE9a7hzKf67muXMnQTNSXfivP7iublS89YIAzsXlCsw7asvvKv5o9G/Wma2VawhX8fKfsBOmC2e92PZh462a3J6JciR4hPH/k0BpNTD06odPA3Mwh5Lh+qYnB2fGQkTpW6job7IH8ccrJEt5ox/stWVCaiE/Syg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPkkeTK8De+p9lM6IQpkB99IbTdnCVLTpRGQwCR+kHE=;
 b=Is09GJiIWjrIVQItc5Pregw14cq2/3DlawuEo40sE0bjHqH2aQogvwfTZMpUfjZwlh3Tvyzq0lIY2t/NR6z0ghqMG0I8c8H2EsKpk0UkuJs+svXCpENIQyvdaKAzEeXhjIpsAUe8DjO39y1IWKSWB2Mrc+ou0p09+sVvHagm894PEl1MjLnF4qCyBUJANBAg3NsVUtefSA6XruB8yT4QlgLXOjkXKrBGG3V2Glp3Ynm/r432tqJy+62y967lpqICbpRlhOgRQ5QHsGUPgMGmUv2PCBCTMZHzHyFUWhTgZuanhUCuRigjqvnMhJ0GaMYS83HTfoZ1Rbc5OF/cDzQjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Mon, 13 Apr 2026 11:31:26 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 11:31:26 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bae, Chang Seok" <chang.seok.bae@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 0/6] KVM: x86: Reg cleanups / prep work for APX
Thread-Topic: [PATCH v2 0/6] KVM: x86: Reg cleanups / prep work for APX
Thread-Index: AQHcyHI/mUmgpJ5RdEKQfJHksHST17Xc4TAA
Date: Mon, 13 Apr 2026 11:31:26 +0000
Message-ID: <3c2f9b78dd21d19934dbd75f6bf3f781c1c47280.camel@intel.com>
References: <20260409224236.2021562-1-seanjc@google.com>
In-Reply-To: <20260409224236.2021562-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CO1PR11MB4771:EE_
x-ms-office365-filtering-correlation-id: f9727450-8355-4461-ee28-08de995032ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: tOYyZLFARk8ny4R0O0ZqqKf3RE7hmzvoNOdLhQkThEgnlTOfaxSqeHIQ1s3EAjUJQ5o7YTKw0z3pew4Rf9dr5xAXZ/JN0FNnou+qeAJTIkrCmB3XAxei2zmIAh7Xc1etNIAp8UlVmzCnH5k9RSWiD+uh14IO0icApyBC4/SZnHGI1kaYtUR39dRGn0a8E+58rdVVaMCAEEeR0dKPvQaR8ipf+6jDZIG4egBSVSNHBTK7ncv9fa/cXCAV45PckQIjO2eE9/P33N5jKr9B7+xqu5EUeXWV7o4SNdDxjOUhlwNVzwzCD3HSHcLdLRtF855XSmCCmTBWeAoyWtE+NelhtD+etZgx+7YjKILeiiU+PsywUov9kcLQq7qiOy3KfnOqwb6BCGNeyPhRj4M0FJ/8g7pxUPxLYGSniUbFbU/0Yg2wyAMntK0zTZ+FGL5r2nuYxFygTj33FOMNDl3VijX2sCJdDDbfxDy8Htx2i37oGz5lnJ+wULNULtnT7Goq7G9jBaxM4g+O6be+hXIJJxkIieEPsakhbKOD+yaIN4NtToAMZ/IcwEpsER7bs7dsJ1iXbpu4p8/b/p8f61TCyzX7IqhsmuJ098TLYqn+hgZ0zRGHRz2RckrQaj3YBuw5t9qyQzVYZe82qff4AQSC1CagaImqDIuzcWE40dzZewT0080DLUA8PUybxU75s7mGUMGi5wStfu7PH0Y/4xySMFfZSUKFZPytzi+nwpdk6rkpjZxaBPcLs0xyKQIt6pOtbq62Somm/2woqwIOtMXKeQ2d4YcOnDA6TtqV+oKHV3CD3Eg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDBCZlNTcm51N1k5QlZrMnNJMk1SemJRMUh6akVmQ0dZR0M2RkQ1em1KL1Ba?=
 =?utf-8?B?VklhZkJpNFJSMWxhVGF3NkJsMy9iUWtscHlKSFBZelVMWjNVMXg2ZjgvMkha?=
 =?utf-8?B?aWlhL0tHYTNjeC8xZEVlT2ZEeDNDZnBYR28xcDI3c3BUQXRwRHltZ0tCWGRB?=
 =?utf-8?B?WW5tZU9LbzRyNko2ZVVKdUg2QlhISmo4ditRYWtGdm9oeVF0S0ZjbVg2UGIw?=
 =?utf-8?B?NUhMOEtFSDBzeVhYbDFaTE0vR0hNQ3RYL3UreklUTGR4OVpoOHRJVnhMcjZu?=
 =?utf-8?B?VjNDaWdDR2NjSXVvaWQ1UThtc09ZckU4Tm9kZ3A1alFDUmh4dmRqWGVWR0cv?=
 =?utf-8?B?cjBxa1YzWFQ4eWc4MmNwc0FhVjRrMS9zMlptaHp0MDNnODUyd3owczBMdThp?=
 =?utf-8?B?VmJuLzVtV3JqdXZHRmZTWnJhTm82bVJTdDNGL0lmQzZTZmhZNFBQN1BuR1JN?=
 =?utf-8?B?YUtJSmpUV0VJOFFtOHRNbUNhaDQrOXowOWJUZHNmUDdEVnR4MUVxNndqS2l3?=
 =?utf-8?B?TkdVajlYdkdjSnlIRkZ3cWhXM3JhOWp5dE82RGNNUzNPb2xiL0ZiOXZ6ZTEx?=
 =?utf-8?B?YU5BZkViMEJXQjhNTUQzYzk4aVZDbmh0VkI2OHhjTlUveWhtNmRPbWd4TFpF?=
 =?utf-8?B?RFcwam80YTFTOGlrYmZUWHVOajBoL3V2czMyeDkxSmRuczZtWEhabUtSRXR1?=
 =?utf-8?B?bndxRXQwc0JmYnk1a0crTndaUWpKN1JQUGRoN0hHYzJkZmtBc1UvKytFV1M0?=
 =?utf-8?B?TzVaQ2FIWWVPRzlORDdOYXpLUi9WUk9FQ1VRRk0xaG1Ld2RLT3Yzd2JRdmdz?=
 =?utf-8?B?ZHI2THN0Vk5tYzFiazNzUnJYSWRmMjdpZXJCVGFnVVNXZW1ra2RHODU5RXMr?=
 =?utf-8?B?Q3NGcXV1Sm40aW55NWVPdUVNL0lOTVVaNTRuUzFVcVh0Y3kwNUcrQ2lOL0Q2?=
 =?utf-8?B?T1c0L094NFBWbWVUZHo2b05JMGllL3FJR29lNlhHeGgzSnAxVXJ2K1padHkr?=
 =?utf-8?B?L215eG5OTEVkUXpETWx3VXBSUW5lT0tMZUM5UFJkYVpEa1lzOXQ2K3dweFRo?=
 =?utf-8?B?MjZibGovVkFiNDFSNml1Z2YyVGtPNXRxclZrd1FhK0R4RXVxK1dEMFk4WTlm?=
 =?utf-8?B?b1o2L0V3eEllQ3N3ZUNyM29lYkZ1NCtYU1VxSFRKQlJtR3krZVJFY3N5Q0px?=
 =?utf-8?B?VVgyNUJ4T3hkRjRDNDhkNHBSb1g2dllNcXpPamc0ZDNBT1hWbTVmbU5PUStj?=
 =?utf-8?B?MTJWMTV6TVNucy9EaXVvK0gweUJ5Uko3b25KV1JmZGxGT2FxLzFuN1ZXS014?=
 =?utf-8?B?c0Y5QTAzaHdyQkEvK3A5dkpaOFlQMDlBZXZaL3FIdmN1aEl6OGc5bm1VSXJL?=
 =?utf-8?B?V3NHUkczSGlwUWZsSG9qdENMaFlWelhJSGhTL0p4aEFvSXN5MEZvdjhZelRq?=
 =?utf-8?B?TU80MlRKS2tRU1l2cDNGclN5bng5Um1jdFBweHhEMXlSdlczUWNTb0tCa3VW?=
 =?utf-8?B?dTkyQ1hPRmt1ZWxWMFlEY1FteGVad0ttZXVSS3grSjFIRDJ1STZ2Z3RvWmxp?=
 =?utf-8?B?SlJkelUrWm44Y1JUSWR0NTQzcytnUGRaTm55Y011aFR3dHZpL1ZHNDZoQk9a?=
 =?utf-8?B?QVhFS2pMTEhoV1l4V0FlYnRvTnA4UnBQOUh6M25SSVlrSGlRc1F1eVFCckNp?=
 =?utf-8?B?YjZIRzBpb0NxY2RWMmU1WThMUmtzY1BvaTMyMXM2OERPN1d6RnM2NFYzajVn?=
 =?utf-8?B?M0wzZlBPSWZmVkRyYjdBSGxiSGlWcS9hZmh6MUdmKzlLdDhCSkMxQlU4MFZT?=
 =?utf-8?B?VWZHenhQaW5FbE1zbE1ralVxNDV0MUtTcjg5UFpSVEVqMUlEYk4xNDJaMnUx?=
 =?utf-8?B?cGZrUUpQOU83R1F3THFKa25FTzE0OURPUko3NWNtNFN4TlcxWjNlRjBxMnE5?=
 =?utf-8?B?K0lEajJKZTdkYXhOK3hnSVpyR1VmakFDK2pkeDdHREFvNHpUK1VUdDRaOGZ2?=
 =?utf-8?B?Z213TGlmUnlsUE1sYkVtSFg5MndpZmRKZ0Nod3R4bCtMbG9ST3ZWRHpPSm5U?=
 =?utf-8?B?M3JpRTJaWi9aY1dSYVVuZkcvd2dINklRMVRzVndTdDBWQVdmZWxDU1RQSGpM?=
 =?utf-8?B?bUx2QXBHaHdtMVdWU1YwdFBGVk02ZkVPWWRQS1BaK1BMYks4ekR1eXFuS0ND?=
 =?utf-8?B?b2UzdTNINndyWFl1bVIzeFNoSWsvOG1XNkE5M1FJQjAxeFc1bThXWnVFekxt?=
 =?utf-8?B?SCtZSWNMOUJFK0x1cFJ2a2xWdGV5MGdzajNrdTFWMjdSeXR5dFNHSElBUmhC?=
 =?utf-8?B?dEVwVlZud1dMczNKV09xa3I4d1JXSWdIMzdrL0VHaHJBQlJONDUwdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60368C442A8E1541851061FE49482DCC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V0OvmC53CxdaV+kLPRTQM8fnOJn7Q+HNFX064JtxCdHjQUD7sceAcH+WZQcRdnCoL0+WhmflECdLnPraOWC/Hu9sDU4BHd9buval+w62FbiZAb3BhXI973UgeAZiT5Kyo3RTL3Ml6XirRUN89OhmiJxyjzXji36PVPO54g5fP+ttR/sXfJ9cHRN+Bk4FeR9Jt1iyDiEtD9KZMleubWuaQTkDmKz1gZrU6mvaAC3/IOAttZVOny8O/zt0ymYHDtC1AUNo9I4F+YK4KeTaLB3/QxKquj9b34489qZHRBJGBStJUN7tVNvIcX8MgkRAbsvV5Fna9GqG/ifRXQOWQVzoqw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9727450-8355-4461-ee28-08de995032ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 11:31:26.1514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Su2zPC8QT4elnwJbxaIeuiQeHaFggacL2pcE3JxhAQo0UKYcDDwfPOUozy0WLtzfIqT1enLPj7CyGWSTgJRVvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4771
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTA5IGF0IDE1OjQyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBDbGVhbiB1cCBLVk0ncyByZWdpc3RlciB0cmFja2luZyBhbmQgc3RvcmFnZSwgcHJp
bWFyaWx5IHRvIHByZXBhcmUgZm9yIGxhbmRpbmcNCj4gQVBYLCB3aGljaCBleHBhbmRzIHRoZSBt
YXhpbXVtIG51bWJlciBvZiBHUFJzIGZyb20gMTYgdG8gMzIuDQo+IA0KDQpUZXN0ZWQgYm9vdGlu
Zy9kZXN0cm95aW5nIGJvdGggbm9ybWFsIFZNWCBndWVzdCBhbmQgVEQgd29ya2VkIGZpbmU6DQoN
ClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQpUZXN0ZWQtYnk6
IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==
