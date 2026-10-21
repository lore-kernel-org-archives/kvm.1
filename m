Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792544391;
	b=VPo5VUIQyQxsu7tWsjn+PF/HTLnD0J7d8M8uYWp9oGBtlDoybfg648I4l4OiHT/P/mHf
	 jQVugIRe12Ji7yQP5tVCazjx2jAoTrhADPWO5KPSVQFcYcAlM0X4Q8plBaMqfhX43++Av
	 H/w6YnCbjl1NdcG9leU1gdS4RCCQ7aUh9Lrx8P8/73mcNIqaGpZd4R66oAMXETedLJul9
	 lSlif2GmC7hwPKERCH4PAsPSstszBv2D9cxQN7nIAzKaJ/hO2yOVxceXZP2ugs7zfrONI
	 qLNBImEbqVCfD7SLSNPD2qdyQa8NbqJ107ZQWMiu9sSSZDHD8K3SMvNAI1I5UqqOmxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544391;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=n+5LZuLrnKNQXFOV1nJ2FVXrHRgsbat2KFKBSmlgmUs=;
	b=sajRNYZ58FcTtajPd01yDlPDHQma8/kyXUoTqa93YDDkuUVXcgFrIIDlVBzJpvsebXE2
	 W/db0FdIvSfr1sdfcY8sQV91gGHkFG5RZAPzDmYO49/m6/idhj2yAP5ROXOd2igdeKS1Z
	 bcVkw8O6UAZoj6wRYLbannK8SKlqxCo8zd9EY79vXWSpuSvVgNJ1o8Py2T6KYAkqHeCii
	 eLN4S/IN7ak1GM9WGV5aIe2mDG+hdUsKMsMb0SsVN/6TGM3KhwsF5RT++Fbu5OxObJnMr
	 GDL4TNMfW/gDiTub61rY69oOo3BYA7ucy4aPpUxCL0uqWW8Ubvzmm4SnicN63yvtacA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RnVqrJ7l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA85606A319;
	Wed, 21 Oct 2026 00:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EA85606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RnVqrJ7l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792544391; x=1824080391;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n+5LZuLrnKNQXFOV1nJ2FVXrHRgsbat2KFKBSmlgmUs=;
  b=RnVqrJ7lgK1XQd5EIPOEa6lmi+XYCx+GVdgGsR/0tnlpbNREouK/lgGy
   b6SNrcyopSFLacBJjFYSsjKLd+svXd+lK4BcuBVDyO224r1Lf/TxCLn8h
   3mzr/Nr2hkM31UV9VrnX+VUixKzZas5WGMD6cBbGugBRC56h7LVvZJWg1
   WIsTVSnmH71Ws9TQuai9uHS2Bff1UHc2LNQCNfCsE4ki/OC/ms0UOwcTE
   /P7FXZGFjRo8yC1CB7yqPBI2ffuUpQamSVkBLpuicVObn521v+4k1kxay
   N6DacrBBG4oqZ9c2OWEvYx+VglxXEJDC7593Pcs7RhZ7DD9T+y8T+J3Re
   Q==;
X-CSE-ConnectionGUID: JFiqcdAiQNOZz0ZFRwB+0A==
X-CSE-MsgGUID: khdM3uJrTmeNSzwDLrs4MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1242112"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1242112"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 17:59:50 -0700
X-CSE-ConnectionGUID: awUJevg5Q3mysT7Jxgmq7w==
X-CSE-MsgGUID: xb4dwOPlR1aceZwmdjlB7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3376441"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 17:59:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 17:59:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 17:59:49 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 17:59:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjkQA7rJD3m9j3aC0DiFNJsZ70wRJk8Q9dYtxs9ZIQSiIcwBwlrPoeJtAjOmGXIzxUxCZHktLjRLwDQ6qBUJY9TkF/rlNF2HUXD+vcecRIVK3dIyM/xe2mYMVfU2F3+YfF/Tk5UwoJRE/HKaFfhsUvlnGuBc8sAV++GPwmjw323Xn/qm8l0GzmUnd5uzBTTYc0WVwN3FuXSWWowsfN9qp/qK/7sz+m1DUNyFAzcx3vd8UGRw8TVKmIlD/b+YcJUvTzQzuaNCZykCWteahn8uNjYiEkyffkOUgQkIsGWo3pZCJkrbHCNJNjiGHTzveXgNhEUy680PW/gRg0gBA+fpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+5LZuLrnKNQXFOV1nJ2FVXrHRgsbat2KFKBSmlgmUs=;
 b=I+INDSls62F3n8zib/yX0kHVLwitJsqiwf3c+uGZccQgeAVVkoM3SWNSeLHvf+GZhZWlJhwHbFmZSM20dSFOso+Q36fOrstgDELEPLju+0UbcALBft9KVPLqdaUeoNBmFbp5Qp0u9Q2x8Hji5LfZ8Zs9vnofAcFLUb5x38rITbYN/Bq0hFMsKj7Z/JO06W/DFKQrO5NIew66U3yUoimpLWiMp253EiamiOuZdvkd0y4GN1Lx6Z1Fx4xztLeXK9bO7uml/XJR2pmoBr94kXNwala/YxPdgdwF8Lu7syE/Cs/qe9Ztxzl9rBO0lwtLRKbRVi1KxxbkEh+ELdWlwa9GOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by DS0PR11MB8069.namprd11.prod.outlook.com
 (2603:10b6:8:12c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 00:59:46 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 00:59:45 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>
Subject: Re: [PATCH v5 0/5] KVM: TDX: Validate directly configurable CPUID
 bits
Thread-Topic: [PATCH v5 0/5] KVM: TDX: Validate directly configurable CPUID
 bits
Thread-Index: AQHdXU4/hFWRpivxXEue90yR3mPGgbcHNFCA
Date: Wed, 21 Oct 2026 00:59:45 +0000
Message-ID: <886ebc528b24761f86dc07e1fa0a902f1f781d51.camel@intel.com>
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
In-Reply-To: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|DS0PR11MB8069:EE_
x-ms-office365-filtering-correlation-id: 1068c1b8-5fc0-4c33-ff40-08df2f0e994b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: NI+Pxyz5BIg8DrX4t8gT8psI+VLMkAQiPjPG3wIGDpA6tklterZAia+QInMBKmIv1R8RQ6i/OizuS89/fS38qk1Rjpl9us7Q9Q7QsBhfkO4nq+UyC/iWk3ELks7AgMnZITXtEYzXAf7YyvrfvyrFauIE9iSydWQtdR9bLzFFcyEJ12rUxYoDk71h7w2f9WaLb3I6NVQ9skJ6iVEbcggskiMBrNeGmp7IdCLyFbxHWt85xc7zrrKRJ7YBBlHgGxqgtAnnV3CcZ5pLFJBjxJ3simyjbxcOO1dm/seYzhDabE1XAOrZ4R8zV7w6eLb8ENQZ1E+2ZtbglnZQ8i9UBjKmqLkp6uxy9WV0zMGz2a7IotHiSK7FOk1EfO/il4xuILsQGJeDxjzXm0oQo3wz8fT6OeOmkYvjAovcuJs7Xrag9/x2vN2P8BE+yMAE2fOdtimCZX+tXIkI4WMFvCITaCdhctibPV2t8JQlen8etflwuQq0G5/A/WGYIKXkjSF1/oP/5dqqO5IKDc61X9I1YrMKJaoJqU+JKiy419fJ/PrajLIor9n0FlFk+pG2tVx35uhmUYL/GqbCiFkXaRP2tNdAjKCS618Z6k2I4t5VNOETDmtSRE6HpCcURSJE73tgEk8qXN5dontK7W7tCGUDEj4f0e3nl/2ajNp6PvspsXRjuqz2MDRcSunkc8923uB2jQPjW+2ay9nf+8CTLzGUQmi+X60zv/0KpdKae9CgiSi+McY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1huL0NpQ3c4NkN3aHB1anlQTHppSVB6Szh1b0IxUE8wZENyUkpZMzNtK1lM?=
 =?utf-8?B?Tlk1YURWSW95a2l4VTVGTkFITEkrQkZ2enB4U0FhN21Cd3RieEhIeE9EcWFD?=
 =?utf-8?B?SUdJS1ZZcVlRVnQ5MktYeSs5K201UXVDdkwzUWRQOWV5ZktPaFhyWjhhOGhi?=
 =?utf-8?B?clo1SVY2QzVmdndNNjdFd0ExM21tMElrdTJRdk8yTTh1Y3NDSGFPT3ROa2tS?=
 =?utf-8?B?U0hVbGpuL04wZTZaRW9zc0ZacE9DRCtWaUFOVTRJa2ptVEpuTm05RjVEMTVW?=
 =?utf-8?B?QVpEZVl1MWJxOGZtQTVYL1hUWGhnOFA4K00zWm9YODE4MXY3cVpicmZhemEx?=
 =?utf-8?B?TE9jaUhyRlZQNzM3bEYwaFRETSthcDR4ZCtYRWlwV0lLRmZQMlFNaEV5SGtO?=
 =?utf-8?B?cXdwdkJ5Vm1QSFhLZ0s0ZThGVVpuR1FtekxQVUQ1VklsTUFBaUtnc2NiNVVh?=
 =?utf-8?B?Z0h3WkJncFJTSEtFVmtMSld5dzZmSW53UGNDVVcyR0lWMFY2b0FLUlVQamIy?=
 =?utf-8?B?WDFYS1JYQm15bWMzMk51MVk5UEM5UEFNNFpZZEI1TGJmWlZOcEZoRDVwRyto?=
 =?utf-8?B?aUtodnRKTnFMVjhJMk9PZG53RVlpcS95ZkJMTTJtM3dtWUFpWHJmSC8xWTFy?=
 =?utf-8?B?RWxBMkR1NHNSUnVEUmtvTUwzdzJSNEg3Y2VEOHZBZUk2RTRUakVBZWF3THdP?=
 =?utf-8?B?QWlnZ0czVHpFTGl3dmY2T09ONFNBcEpWVWdZR2hMNnU5OWZNVmtDVnRuT2Zt?=
 =?utf-8?B?bFg0VXcvTmdERGlObkRaNE1UMUsveURyK1I3akJiY2NmTzVscnBhNkRWQ1Zv?=
 =?utf-8?B?SVBtaWtFODdNY2phWjhhMUI2V3pmWXVLdEw3RjNTVHdpa1p0UnhvKy9DNWtE?=
 =?utf-8?B?V21Gd0VaQTJCaTdJSjJyZDdVc00zdGdFMzRFd3Z4R0VWTDI5Mk02OHVySHVU?=
 =?utf-8?B?UTNPY0hlRUNyU3hOeGFXYVQrZmRRMFcwMit6WnlhUjZ1Zm1MS0s1Q0JoWGMr?=
 =?utf-8?B?WVdMTi8yYzUwc0wyWkdJL1RqZ25KVXp0RVYrY2ZNSUNpS3k3YWZtY204bDBz?=
 =?utf-8?B?S0EyVVRpQXIzRXZ6TEZ3VDVsckNWQkMwZWduYlByVHdQeklXYXF3T2FYWG5o?=
 =?utf-8?B?SC93d1V4UTZTWmhieDZYc0ZaRGo4TnZaQldyVWV4RVNUOEFrQjllTVlOMk4z?=
 =?utf-8?B?WC9TK0FhakxleUs0OEw3aUlveTM1a0JnaFNVTE9FU1pETzdsM2ZKNzJkMERQ?=
 =?utf-8?B?MFVXVEN1RzIxQUd3eWdTbzE2MGlibG5ZejV5VTlrbmF4TFdUVEVZZnVkN2xK?=
 =?utf-8?B?VEJzMGwxcFdYQ3laUjM0U1ZJaGdBQU1nY1ZxM1ZqejZhTUx2QnRYc0g2TS9T?=
 =?utf-8?B?Zm8xRVdoaFl2YmZxcHdrZkphZXBrQmg4dlUya1JES0s3RzNMUFUyT3BYdHhx?=
 =?utf-8?B?L3dkMkY5SVlOYUxBeWIzZzIwZjlGRGFFdklQWVRrSytncDdaMjNacTN1STd1?=
 =?utf-8?B?b0p3TCtuQ1VvZzlqaUtBOHoxeC9OT3BvWEQvREFpMW1MeSt5Ry9CTWZaNmVE?=
 =?utf-8?B?NU9Td2ZZdkp0WjJCSzRTVjY0OUc3T1plN1BWSU45SG03bmowT2wycTZiUTFO?=
 =?utf-8?B?bU54eHJEOXNqZ3ZqNTRYSUZSTlhIMDBiZndLN3Vjc1dPSzlZL3ZxemZzenBY?=
 =?utf-8?B?SW02Z2t1aWhzQnZ1cU1FaFBpbkl4RDF1UU9VemFudVZIWDd2blNaVithMWky?=
 =?utf-8?B?T0M4dXkyK1g1S2x5eUIvQWo3TW9QSXlLSitscHpCcnRiNjVyR1RELy91TVla?=
 =?utf-8?B?Q2M5SHZLTTdSM2MrYWJmZXdOTmRqdDc2OEg5ZmM2Ny80NytTb3liTi9hZ3Ra?=
 =?utf-8?B?Zk52OCsxODluOEdRTDBSUFo0TElkelJ6a2o1YU9yMTBpV2FiczMxUHhvSmkv?=
 =?utf-8?B?TGQ5a2N4YlFycVdoNFYxTzJ5dEJ1SkIvZGlJeXUwQTlnSFRKQVRETENTYXFM?=
 =?utf-8?B?bEdRRzVuNTMxNmxWSjA4NVovWHRkMm4rcHZzbVozdThsS3ZVVmxMWkVPRkRB?=
 =?utf-8?B?eW9EOW04L3BnVkZyVmFMTGxnamx5eWZPbmZ6aU1ZV0VyOTc3c0NqQWdEc2FD?=
 =?utf-8?B?QzVQeld2S2F5dkNwZzVxSmZKT0F6OWlQTVRWL0JBL0hyMllMd2ttVTh6QU54?=
 =?utf-8?B?QjFFUWcwRnlkWlJwNzVPUHBxR21JQnllQW9hYXF6aEVQTWFRUE1GNXplZ2dW?=
 =?utf-8?B?b3liTi8rV1dMQWx6RkRkWCtjWG4rQ2tlZDl5eFhSSHNhV1RHSzU2ZU5pK3Yw?=
 =?utf-8?B?OVZUbjgrN29DTDhQVm9jMDR4aXBjV2hBN2drZHJ6alNDSXBDU0FMT1FVYnRv?=
 =?utf-8?Q?s4rI54Frgzo29gRM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17C8E8021CC1F942A9689DAA4B717325@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N50i3cR1ac63s+yrDR9m4uhR5awBYB5steyHfVDH7tJzmIjRwVzdRIdx87fBs83IBkfmy+hN/mbFMLmSbfUJqm9qlVGAO0vUmx+tWCvyGFtmkG19uhGVV6vPB91qlwdYddePWu2T7xf04aw0WsSOqKi+VmdKRS1KNulumcLGqScXYG3JOo/+0EZfLHzfbYzuFVHxyPPaRpX4e6Tjg7E5PCFKDmeNI1GKDXAlmCJFigdMXii2LzTu1PwQQbnGWO24jIwlT2nmp0xOd69jWLCYmYzjeneeERfA+uztnrQquZvmp/B7CEiyPCe5+WFsznqdESS2arFYR+V/A9elxbpUrQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1068c1b8-5fc0-4c33-ff40-08df2f0e994b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 00:59:45.7405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbZP3674SdkxKq8fKrJpS0Sph2KubbOu4gxoVTdU8MRPHXkJ86S9gMU/gj79fB4bsZCX0170QnWCghEE25tL7YIl8oImiAh/xZKY/DRScaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8069
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTEwLTE2IGF0IDE3OjE0ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+IEZv
ciB0aGlzIHZlcnNpb24sIEknbSBob3BpbmcgdG8gY29udGludWUgdG8gY29sbGVjdCBzb21lIFJC
cyBhbmQgQWNrcy4NCj4gVGhlIGtleSBkaXNjdXNzaW9ucyBmcm9tIHYzL3Y0IFsxXSBhcmUgc3Vt
bWFyaXplZCBiZWxvdy7CoCBOb3RlLCBGUkVEIEtWTQ0KPiBzdXBwb3J0IGlzIGluIHByb2dyZXNz
IHVwc3RyZWFtIFsyXSwgYW5kIG5vIFREWCBtb2R1bGUgd2l0aCBGUkVEIHN1cHBvcnQNCj4gZXhp
c3RzIHlldCwgc28gdGhlcmUgaXMgbm8gaW1tZWRpYXRlIGlzc3VlLsKgIEJ1dCBpdCB3b3VsZCBi
ZSBuaWNlIHRvIGdldA0KPiB0aGlzIHNlcmllcyBtZXJnZWQgc29vbmVyIHJhdGhlciB0aGFuIGxh
dGVyLg0KDQpCZXNpZGVzIHRoZSBsb2cgbml0IGluIHBhdGNoZXMgNCAoYW5kIHNhbWUgZm9yIDUp
LCB0aGlzIGxvb2tzIGdyZWF0IHRvIG1lLiBXaXRoDQp0aGF0IGZpeGVzLCBmb3IgdGhlIHNlcmll
czoNCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVs
LmNvbT4NCg0KSXQgd2lsbCBiZSBncmVhdCB0byBnZXQgdGhpcyBmaW5hbGx5IGZpeGVkLiBBZnRl
ciBhbGwgaGlzIHJldmlldyBlYXJsaWVyIGl0DQp3b3VsZCBiZSBnb29kIHRvIGdldCBYaWFveWFv
J3MgUkIgdG9vLiBBbmQgdGhlbiBsZXQncyBzZWUgaWYgd2UgY2FuIGdldCBTZWFuIHRvDQphcHBs
eSB0aGlzLg0K
