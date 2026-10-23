Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792721174;
	b=lX60oGW6dCjTmUpcxt97I0Oa03xrao0oz9xfSHLmSrIEA5dNTAHWrNpMiW+vvkfhFKds
	 eoTsWp3OlQ24gEim4EY0rZQUfkt0eVWZ9f+rIiShRlcwfcWk4HDw512bbEyb/tOeAoOil
	 BeNV+WuflsOpjWQ6Jul+cbZHKQb1aoQlzBSKg8ubgk7398aSBEJpz4Z/lhyaj2olj4BF4
	 H8skqL5IgSoOTOMTI5Jd36QBtROMLzGt7Eos+qpjlikRUJQ/jOI2TU6IJtHr2scVvsv5c
	 77KJJwCqPnOEYy6a+2EVgnb8ZdOr+Z/ayoG7qu0SHVr6tjgOOGIHxVSDEURqKIygdUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792721174;
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
	bh=5VJadMfMmgQZN+NLNBBAorX74h+jJm4WmuNSdZuOtKY=;
	b=19KHB0GVjNXcC7X7lcgQ4avzyHdcEwQ5pn5PMBQSYT2hlQG6orukyqmIzuXQPuYJl0mY
	 ZgX+eoC6r+dVUlFS/sNwH+/DelBALwDGKXunmlHDx5CAsrVnwbmhz02niYx6QvifJMFRt
	 0Fgbbb7kdjhIu1AR4WGMsET3hbVo4H/zX7k+Mc/jq3jCrjqpBMiegXT3cV4XVATPVx7Oo
	 MRSa4inTMwZFyL+HYLJi9wJBEqAk2YOYu132mLgrdnKwnOJKUtxZc4LeCeJ6E5zl27VPV
	 Y5fYTpc2w2RG594TosHzTYjQ44j2UU1Zd9JSTlyG1ExfSANOdNzi+L9XYAdOQnp/OCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f+Wba7HD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49C3606A319;
	Fri, 23 Oct 2026 02:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B49C3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f+Wba7HD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792721173; x=1824257173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5VJadMfMmgQZN+NLNBBAorX74h+jJm4WmuNSdZuOtKY=;
  b=f+Wba7HDkIi8/e0kXdvVO5i54JBTTzFaSC4O8aYeZOQVtlZCMltjtRgt
   0Rce1VQCGoAo2dL30jMrUnH2jmuYoxle0kzYJpY8e0Uls1Im8sR4v7SWe
   7V2WtqzoYgIp+0HbncAIh8d09l684R07orUlJh2/CrXE8zxLfoHw1D9UY
   PNCF9jQxs/ORBuCfQybierO89oaq+U/F8qL5P7RL+oGj2wivyZjzfZL5p
   lmtHem0OaZxcXJfZ38AJVHNEEQQQO++EPtbYtw6/8J5Ehy7oFKXirZai5
   8Zu5rKVvIDwe0QNBNwWeV+okTeK8SO5LX1OfbsoD0ywQ7vBa76QBms8oq
   Q==;
X-CSE-ConnectionGUID: lxAIlOF/RWuIpCe9MSDYCQ==
X-CSE-MsgGUID: GKHN8+ZMRg2Nd6pa6b1DYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1361164"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1361164"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 19:06:13 -0700
X-CSE-ConnectionGUID: bJNbVuLASjKuy0o0JhP2ag==
X-CSE-MsgGUID: VNAGCbo1TSq1VWWCGuCfCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3835191"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 19:06:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 19:06:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 19:06:12 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 19:06:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIzDS9Ulks+/fV82cgx2AuQ7BoCeJh6uS4QNwPvOKBeCjb0/nRNXrir+52IonHQ6UpkQXNEn8T/3gMrDoJex+PKd0NgaOkLBo0r4K3+nufOBgp9XB2Up0YsGoWIJN4wF2gMAKN+RJx5SKR6KDJwU4EOqr0o4WCKOeF5fBAaG1IR2IOrF8odtX3876z7TwqHEp/se39pGFjlmocWdhqWadT4E49b5VPp/QtsBdYysu1Vymb5opPHREAJCU0o5TXdd7ubTWtS5Epd2BoTtDE14mHykZhG37Y/LrITh7eN+Th6bZOcLZN0Izs+2z9jUBSg4se64PsJtAk4X7JV/CUdN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VJadMfMmgQZN+NLNBBAorX74h+jJm4WmuNSdZuOtKY=;
 b=PZNa219U0WOYQop7hUSjBXKaYBuElEnYzcwZJCzJhL8wMyewvdrqXWLJSHNQ8c3FJlZWL+e/9haVJVkLkBb/lVbGGnMgYFY2JFZSnTnO/ct0J4SJlldwRv62On1zU/Zj2CUz+LoJju9uX72KKyWqmz6GPtu070t9oORXx/GFjuqUupmnzwd+fRnoy9MJ7J9Rc+YJpWTWK4aviCT0yCRtwAbfFtVXDm5uWwvLmcnevAPsYGoyl7b+Rbi9t7FcyLxJcjAd45rWktCG+axNNW7LiCjnF9AyChPG9wYrZJTfEV4DZQa1eP43sc+fRNawLo8olxtCxnoaQ1LXYohsQTXCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by SJ2PR11MB8297.namprd11.prod.outlook.com
 (2603:10b6:a03:539::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 02:06:01 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 02:06:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kai.huang@intel.com" <kai.huang@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "tabba@google.com" <tabba@google.com>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Topic: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Index: AQHdTylT2fDCHY1RikeRNXt5wj90e7byvXkAgAApaACAAhZUAIAA2vcAgAB1o4CAA+N3gIACbDEAgADZdgCAAKsxgIAA0reAgAVHxQCABHwBAIAAldoAgACPGoCAAIb6gIAAIHiAgAACBACAAADBAA==
Date: Fri, 23 Oct 2026 02:06:01 +0000
Message-ID: <97ad9dac09d945ab5b76ec8596a76f8fdf2bb6b6.camel@intel.com>
References: <as8UwKoAaT/1HgNr@yzhao56-desk.sh.intel.com>
	 <71682b712350b5270e4a0f5cddceb1da12341b9d.camel@intel.com>
	 <atBaxwAG84jlOywE@yzhao56-desk.sh.intel.com>
	 <25927de50b85816956e8989f402ff6ccfa8fa0ba.camel@intel.com>
	 <atV5fDnckj+3V0D/@yzhao56-desk.sh.intel.com>
	 <ca53c3bd37218828822a9b990a0900ca2541fd9e.camel@intel.com>
	 <atm6NBNrwYc+Y8yo@yzhao56-desk.sh.intel.com>
	 <55ccf641218c6553b2f43f4394b92c23bd8b5d98.camel@intel.com>
	 <atqjeaPTXmCfiQmo@yzhao56-desk.sh.intel.com>
	 <29790651d7a5d8727f956985823c17e3dfbdcc24.camel@intel.com>
	 <atrAZhEINeaieBxN@yzhao56-desk.sh.intel.com>
In-Reply-To: <atrAZhEINeaieBxN@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|SJ2PR11MB8297:EE_
x-ms-office365-filtering-correlation-id: 8e6fc85d-7d6d-46f4-7f3c-08df30aa2faf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|261022105027099003|3023799007|38070700021|11063799006|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info: wtanGaZIXZ1COgrJuRS1+c6ghY5wAH8PigcQ+lCy2vaXz47SSELln9zib42gz1ol/B+rf/cLP9E3NG1VQAlkE++IKkiq/Gy6DMZHSH7NHBCsoReZlAOzdJIQ9o7vP2GHef4ohI/5hkFdltktHcDIDyQXK2E/o8DIorTUChF9bQg9/ucdJWLLwLi3GHb9WRMqdd/toatax1/ipcIqQ7W3sTyTnkmvq6Px43NVl3dFsyEeHSrfLVJ85F8NCv8ZPhFW62FPkZAoQbaviXzR7kcEFbDi1ofysf1D2Vl7VkWpVaKVZ/c9Zf1athQ4WlRz4h/au2215fAv3+E0Or5VUkkFVuXKmsjdPeHAJr2WfpekWYPye61FgRD8NggQOus7xTwmbv0g4lw9o0JAn7a9jEPN+5+EdMS9ERCCYZwPKtp5LhJLakC7LrY1VyvFfvyZjU48v3IkZcg+ZClw7EHiYhCGN6PnZsAbEeLqOv/xt+nOo8m1Ziu/T9PxGZgCSMuehP2zYhtfYKYlEesUZVHjold0OopXwMy0tzqvaxF8fdcJQ0XxOd2Al04WiZYjHvwjC0BcdJeOezP2mEbOSXHFg74zJHf/ETq0z/ZAjyEfQJ5KFOfpj+Tap3/5raTINw/7iQv505d8bZCfe8msJHezAMjTXCDzgSSHsvd8rZXzy0NJpi7WwawZMR5CM8Bz3589NZgpkBrGmz8Bsl+aCqpRDhxA55hTyH9NFV4axzYkHid7XR0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(261022105027099003)(3023799007)(38070700021)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TC93RnR6cG1rUjFmQmxueXQ3SWtTMHRINW0xbGtGSVVIczZsak1Uc1RVVjJt?=
 =?utf-8?B?ZnRmZUNlUWd0emVxdVkrTldtelNuM01tU1N4U1c3RkdJQnFNZGZwcGptR05N?=
 =?utf-8?B?cTRvc05ZckFDZ1VRWm9pMU1DMFdHZGIwYXNLaGQwNUlUVG8zQlY3Zk5aWVd5?=
 =?utf-8?B?UVZubldxaGhubHErdHdKS1k5MjBtSDdmTlNEa2V3c3dBVURtTjNQai81ZVJ4?=
 =?utf-8?B?VHVOam0yTmNONXlQeDRweDJReUNDM3lRbm9vdjNxbnRPME9Pa3lyMktNWDNj?=
 =?utf-8?B?ZldWZS9URGpubVpxdWc1NG8rZGFkUE1wVjRPdFNrd0VKMUllMk9sQkJGWEk5?=
 =?utf-8?B?U0ZqcDRDNkZhU3I2ZzkzcStlWWg1OEJ3VFUwa3NkYm1FbXNvMkFpL2dnT3Yy?=
 =?utf-8?B?a2xJR0dGZ0RwN3dmT0pRd1BiRFQ0TlB3MTlTTkxPWWw4VW1pMTRjQkdzVjJM?=
 =?utf-8?B?eHNtR2dKd1cyUWpKNGxDRUU1OGczcHpyK0owY2haTjNCd2tFb1J0TWc5cnE1?=
 =?utf-8?B?c0pJNDRGTGI3K0RwOU93Z0Q1WE1LSmYzWG91cTlTVlNZRkZMSXM2NXFUMUJN?=
 =?utf-8?B?KzJ4OHhnZHp2aDdTVms0SjJPOEV6RmJRZW5PSlJCSm8vM3hFSjR0a3p1R0pr?=
 =?utf-8?B?VU5SRitOUGpxekRWTitkb0JUUWIxRXNTT1BTbWYwTC9Gb2dablZSa2JxSkVV?=
 =?utf-8?B?aGQ5c28xNEd5WFpMSjlhVEJjSmhsZFZycnYyOGU3NkNrTjFBQzJWVkNnTjNt?=
 =?utf-8?B?N0FqbkhDWlBvRWZBYTZpeHZ0b2RBN28xTTFkV2N6YS9jU1BtK0E2OEhDcGhz?=
 =?utf-8?B?ZUJhM2VjS0c4d3J1V3hTRlJuc1BUUHZFZUtsMHVNMjJOM2tIbCtCdXlQWjVj?=
 =?utf-8?B?V0RmVmlDM1pVUEthUmsxRGxlb3ludEJ4WkNmWjhkZG1HTjZCTzlQcEs4T2N1?=
 =?utf-8?B?aUFVaENBRXhRbnM5V3JKVzJVSnFkVVM0RkhSdkUyTTBzUkFvUXhQOC93cEdS?=
 =?utf-8?B?Y2tpZHlIRnN1Zm8wcWgvTTdGUHNTVDdVQWJwNVpYMWp2Q1FRaUovK2RVT0NL?=
 =?utf-8?B?TzJxZURwNXhqeGl2YzcyNHRHYmJkeDNMSy96b2tsMTU2VDEyRXBFM1p0Rmp6?=
 =?utf-8?B?Y3NzNlNXemxFUGFnTGxzOXhZZVlEWXRpM1BFcFFCK2ZUTFZ2eEJXQVR4UW9G?=
 =?utf-8?B?a3dNbXJUSFlJOHcyMlZUT2RDRHBPbXJBQzlEUWxBVXh6Z1k2eVZ2ZUdiYWVH?=
 =?utf-8?B?elBURUR0VUw4NHN5R2lpU2liNkJGdmpwVEk5Sy8wOXgwdm9QeXY4UXNNN0xk?=
 =?utf-8?B?Z05OeU1lYzllc1RHTTVHaWN1S2FvZnJlaDNZakJlQ1JHOVFuOVF3Y3Z1TkVo?=
 =?utf-8?B?bldJY21nZzZEM0NTaDRLeXJoNVR3cVY0SE9DSU12MDJKNnR0TnVuMnNnRlVO?=
 =?utf-8?B?WGhONnRFVjluazNmcEhOck1vVVY5NXphNThWZXYxVjgxdEY5Z3JGNGxGN3dr?=
 =?utf-8?B?YktCbWIrbzVGT0grL20wNGZkN1ZXbDAvdzcrUExtZkhIcHdDbkhjcWQraUlq?=
 =?utf-8?B?dlhYMG9tZ01WdklHbnVaUFdQU0gvTVVRRm1JbTkxODgyaVRJTElZeWQ2eXhj?=
 =?utf-8?B?cXJzWnMxeGZVNzFYZ3J0bmNMSDFCY1dKRmFJZmNZK3llK1F2WkZSckR2c2xs?=
 =?utf-8?B?MW15aHlPZkwrR1VlOU5kS3RCRXRJc1RKTFlRaWlRVkZyUXEwTlpNWitZazRI?=
 =?utf-8?B?S1dpdE80QWxQS2dqMGNhMTVib25nT2V3WjFOdmZ5ZTlFUFRWL0tYckJaV01o?=
 =?utf-8?B?Y2FoK2lYRmRNWHpDb1RLdFBwRXc3aXgxRWFqbTlyeDdieDAyVys0NnRGVkJC?=
 =?utf-8?B?bjdGbGd3c3paYjF5MXdUTG16MkVYRjlPTnZWNGNMVmkzdmU1WE1zMVZlUnhB?=
 =?utf-8?B?Z3ZmR1RQR2oza2dhVTdtU1RDNE4yNnBPVklnMFVCWmdZNEhYM1ZXcVhzV3Fm?=
 =?utf-8?B?aDFnbVRJWVZkYVg1RVc1WEF1Y0xYdTI0eHBmSWo2SHlOdk5KREV1SDlML3hQ?=
 =?utf-8?B?NDRIenhpeHZiQTQ0azNEN2xySktzNis3Z1M1MU84aURvSGdwV1U1ODlJOTVa?=
 =?utf-8?B?TUFjRk9GZHVxTEdGVFBhcTFtS3k0ZG5VajZRV0tIV3ZKaXpjYkRFM0F3MDhz?=
 =?utf-8?B?TXVzQU55Q2h0WjIvTnR2eHFERm5uOWJVSkhBTUlkWjVSbldMcjV6WEh1YTc5?=
 =?utf-8?B?L3FwWTVMSXJWQTFOVzZ6MHVqdUxWTXc1TDVINkxhSkJlSms3cWtVZWdIT1RQ?=
 =?utf-8?B?YVQ5MmsxelppQTByK3AxVFRKa1o2RUJOSFZhK1VQUEFkbVBReWNuenhTU1lZ?=
 =?utf-8?Q?DEO8mK2nh1DL4mXE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B66B1F5CD8D404F976EBA2BFB953C5F@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: e+yVjt3kgexZpmE5ViGBQO/tLEAqdjIXH/kA0vVu0seJ0mIl4rUGSMDqtNGg88q9F6fU0RirB3sArHcP29nkMdo+RNrGAj/8VWOhzf1rKQQmQFQyGkXmhYnb7O/keQSUmAyk+MjRaj+jFne1GOZwAiJmIVAWgVs3a8Oci9aHWCYVr3dNxyJnhRulsy66DJjbFFRNuA8Eclii1faJpkT9yiThbl7ESyEEODbeATg/J3HHhkE9QkEKo9wNzp+AbVh+FgE4ihufPH47OxXXTecXAcXOAGBuZG22Cwh60GnckdB55fk6rkt/ziEQNLDHElLjssIeHOZjuf6GMIX7DBbKHA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6fc85d-7d6d-46f4-7f3c-08df30aa2faf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 02:06:01.2341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwOStv5x8vXixDDBNRHgrh2D1zufdnjPUfd8A79JxT06/gV4eAwhVuEiV1R0Nx0xQqJNzeCUnK50Jeh4RUuwGO42IpgUmCkL6EKi/InorEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8297
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTEwLTIzIGF0IDEwOjAzICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiBD
YW4gd2UgbWVudGlvbiB3aHkgd2Ugb25seSBuZWVkIG9uZSBmb3IgNTEyIHBhZ2VzLCB3aGF0IGFi
b3V0Pw0KPiANCj4gQnV0ICIyTUIgZ3Vlc3QgcGFnZSIgc2hvdWxkIGFscmVhZHkgaW1wbHkgdGhh
dCB0aGUgcGh5c2ljYWwgcmFuZ2UgaXMgMk1CDQo+IGFsaWduZWQuIEluc3RlYWQgb2YgZXhwYW5k
aW5nIHRoZSBkZXRhaWxzIGluIHRoZSBjb21tZW50LCB3b3VsZCBpdCBiZSBiZXR0ZXINCj4gdG8g
cHV0IHRoZSBleHBsYW5hdGlvbiBpbiB0aGUgcGF0Y2ggY2hhbmdlbG9nPw0KDQpJIHRoaW5rIHRo
ZSBkZXRhaWwgdGhhdCBpcyBtaXNzaW5nIGlzIHRoYXQgRFBBTVQgb25seSBuZWVkcyBvbmUgcGFn
ZSBwYWlyIHBlcg0KMk1CIGFsaWduZWQgcmVnaW9uLiBUaGF0IGluZm8gaXMgZW5jYXBzdWxhdGVk
IGluIGFyY2gveDg2IHNpZGUuIFNvIEkgdGhpbmsgdGhpcw0KY29kZSBuZWVkcyBhIGNvbW1lbnQg
dG8gY292ZXIgdGhhdCBwYXJ0Lg0KDQpUaGF0IHRoZSAyTUIgcGFnZSBpcyAyTUIgYWxpZ25lZCBp
cyBub3QgbmVjZXNzYXJ5LiBDYW4geW91IHByb3Bvc2Ugc29tZXRoaW5nDQplbHNlPw0KDQo+IA0K
PiA+IC8qDQo+ID4gwqAgKiArMSBwYWlyIHRvIGFjY291bnQgZm9yIG1hcHBpbmcgYSBuZXcgNEtC
IGd1ZXN0IHBhZ2Ugb3Igc3BsaXR0aW5nIGENCj4gPiDCoCAqIDJNQiBndWVzdCBwYWdlLiBTaW5j
ZSB0aGUgcmVzdWx0aW5nIHNwbGl0IDJNQiBwYWdlIHdpbGwgYmUgMk1CDQo+ID4gwqAgKiBhbGln
bmVkIGl0IHdpbGwgb25seSBlbmQgdXAgbmVlZGluZyBvbmUgRFBBTVQgcGFnZSBwYWlyIHRvIGNv
dmVyIGFsbA0KPiA+IMKgICogNTEyIDRLQiBwYWdlcy4NCj4gPiDCoCAqLw0KDQoNCg==
