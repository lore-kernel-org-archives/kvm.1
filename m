Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284CC334C39;
	Mon, 12 Oct 2026 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821687; cv=fail; b=mXnV9MrWXCzbJgFE1yQ+ec5BBMybyN/iXVpplpD2ZIlbAwqTnlvkRvSlSsf4CZwXHokKwr15dqjvMAFs6eziVZ1QiQypc66ys2IZZNOCMIvGoosT51WXmFxuUI05WMUcsVLcwbhzB+eHjV4pliGgFikzz1B/9ge0AeIbgny8Oco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821687; c=relaxed/simple;
	bh=uYkysrKUvriggOGbS7/I141neIEidXRB/S11mpRcQhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BXEOiBdGTSlKrtFWVllYbntoa697CeT1yTr/Cni8o9CvE7Z0nd28SWNXfx/iY/IEensJceXjzy39nvX+/M3AcP5ZPWznnuwu79pYL2ozzmsP6gBuS4/8Ci/QDHRnu72FuqCjzDvWwksNiK4M8f3/S/HhorDieImKXnIejVQ48kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqNtE9Sq; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqNtE9Sq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791821687; x=1823357687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uYkysrKUvriggOGbS7/I141neIEidXRB/S11mpRcQhk=;
  b=iqNtE9Sq0v87O94BBieFuSrc4Btdpt1a/Wwqke1mhHTp7yw9I9tGGxeU
   0e08t2hHHy7UvnBwac21jiRSxsK4PurDQAmj2LT4n0I2sr0xVeMULbizT
   kpT0Ei9LVx1kWjiaHpZrOqwI22/4A9Qx2ZXZUKi5NbivtltplKFBlkTCc
   /9mQb96cKwif/oinFgH5lMSpWnGI2UUVgy9y1ZXEikzQCSB0TaqlrBhAw
   A2ynUuCa2l1n+uVqRc3xx7CXWr84buc9ji3QH+BpdA4dx4HYruGNQLZ2V
   f/dk0NUv5STVOvHAoawUngYXiUTo873VNhAbZCMYXFRF77TkDIJutER1e
   Q==;
X-CSE-ConnectionGUID: V/B320zCQnWy06Puq1JdLw==
X-CSE-MsgGUID: uDCWWqRvTHOcIysx1UK8uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="415915"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="415915"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:14:46 -0700
X-CSE-ConnectionGUID: zJ73yguzTD2xzp/okqPqqw==
X-CSE-MsgGUID: T4241k1WTNiNwM5xi0tSvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1252952"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:14:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 09:14:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 09:14:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 09:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xm2e23WpkctSA1SLNtDfO84No3zYlYqDBi+MOYC/uB/BZdHBNkUDRfWkqb7HG265jY/SCINXjkpv/4AZdGoeWManFZhjbm8mRzhTVOk6yNJB9ZlQnU9tq8Sna7Jhv2a2Hu5ECFYrJtjzP+1lc8KUJJiaAffbPWy6bpayHQfWU9yukeochzLv/ok5X1w8knUrHzFbiQ2kSgKGZue4tM77YD1ax/KqU/jrcFDqvHyRyICRFye5feInC2Qxzs8l8L9RHA3KfMQtnfNr0buQuKOE/xrQu0FIhCgDVf2N6PWvErYdhmKm5ATQeLrKjqpwGNJ/7AQ5lqSw12Z/jAsEtGyfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYkysrKUvriggOGbS7/I141neIEidXRB/S11mpRcQhk=;
 b=P0KbfMrfHDEv+ke8YUJauuxwdQ3fNrUpkdaTgjedpXAjTMhETfc63wKWqiqxaELXkvcHIIA3BDa3VhuFrMOklCD53bcmOO+wQMMouxrCkhGtsOQJKFvSKMEMaAw7MLtuwjbU8F/weewSKL1813xTmgSI8KwjtDqM7ivqFGBlWGAySfdC0DsaUrKk2Tkp4sW8oQP5qVZNDoDOGD/ze6beVZ+zDRW7Uksxx0YI2sFQvYASJZ4M13NLL5jkH0E4gV9ykrxYdD2dLLxrlMO700vlQXo1OlblOPsqtrole0pSTPTJrd+JtLCKTh133+umqSe1wfq8Mw7ihi62EjwclGNrOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by BN9PR11MB5291.namprd11.prod.outlook.com (2603:10b6:408:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 12 Oct
 2026 16:14:39 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 16:14:39 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 11/17] KVM: TDX: Honor the guest's accept level
 contained in an EPT violation
Thread-Topic: [PATCH v4 11/17] KVM: TDX: Honor the guest's accept level
 contained in an EPT violation
Thread-Index: AQHdTyluQiKEcSUnPEebL5+yF0G7rrby4+eAgAIgOoCAANCbAIAAgVaAgAPVLYA=
Date: Mon, 12 Oct 2026 16:14:39 +0000
Message-ID: <f08437832e1addf15f533c858941ff20db15a9c7.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091116.15647-1-yan.y.zhao@intel.com>
	 <68f139713ee0adcca0d7a3d30e48a9c6cbc1f4d4.camel@intel.com>
	 <asi04xo+LJWmkkTt@yzhao56-desk.sh.intel.com>
	 <83419a720277e370a2bb96f283272d8ad0adc3f9.camel@intel.com>
	 <asnQX6O+tPwK+7wl@yzhao56-desk.sh.intel.com>
In-Reply-To: <asnQX6O+tPwK+7wl@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|BN9PR11MB5291:EE_
x-ms-office365-filtering-correlation-id: 130c9980-f6d9-4f75-314b-08df287beace
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|38070700021|56012099006|261009223027099003|4143699003|11063799006|18002099003|6133799003|22082099003|10067099003;
x-microsoft-antispam-message-info: +lBNeN7tSqG/077nQZPZZtIPStbN6VdUG7xJ3803wRmc8SG5He+JiDL05t+MCF1+S4iGzj946KyYL/mjdXCTlQa+aoqJrQiNT4BUkIsbSnyPdiPVhG2Hx6U9z71SJJmSMZLT8jYP7kwSd2P3ncZINWAxk992PJlrOqCEPexFONwwKWrIwQMKuB+l7ZADhRr6JmEzH8tc0QRYgZgAp1c2w5G4eqqUHYhL+JMRZxb+Jb8A4G979S81ejO+bHGrme46BYV/lwrG3X05idBOVfnCd6+aT13X/rabtc0fVwLCUxSovFaDIeJbJSfYRvcl/G+S6k4JpLISR6ib2e+vPL0lwdXvcTQ1PdOkTGtjoyjoVPT/RMTzPULjpoJanrbWz8oauu4Pyk4YVC90Ei7bBrd7XBiKMosU+ZUSRgdZWn5pil5UlnUonD2e29eWbSJzuRG3X6w9Za7fRYIAiGkUWYI+Djz9Abva4G6kEqSMafClOAXImOTAqZH9vjBA17bX+H6tj/78QKMm3Rlaq/F1DVtcPNv0YgLWuQjmvL94tc1wIpn8o1TSvqqgI7IFfGcuZBgoi+CAUbo8rjy+KY8Dzzw5gOu4CwEhhvBV5e0EubcjWs5qyfliDcdYchMCLt4+BCBMOIAUuQu4eZqeGgTPL6vE8pqPvVz79vK8VWYsY1/do5M9l7wfEBv19Va6McnF9rBPUkknEFvK+OtFxb+Ojcxm1xPtT9160SvY6F0SJqIfJNs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(38070700021)(56012099006)(261009223027099003)(4143699003)(11063799006)(18002099003)(6133799003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTJzR3FpQkFxVDU2ekdsUHpIQ2o4RXBtTldhNEFxQ0RVc1dBdlRDNHdJb3Nv?=
 =?utf-8?B?djNGWXA0a2VQZnJMR3ZlOGwzSU1paWtEWVYwdHdkVFdTYk9sTEZBWXhyNk5Z?=
 =?utf-8?B?U0pJakttS2wvams0ODIxQTBHZSt4YnJUNU44Y2Q5ZXIvbHBrUnBqZ1hEeFYy?=
 =?utf-8?B?WWE4ODZmYkNOK1VaVHcrb0k1U2lVaDYvN0V0NUwycmRZS3VpOTU5bGt4Ukhw?=
 =?utf-8?B?dnZDWVBMS3dHN2dyRDVUUy9pTTQ4QmtaUmVSNTFIOG12WFN5UDdCYzBkSFo1?=
 =?utf-8?B?ZEY5RlVoVkhDdlJuNklyMUR4MTVqVjQyNTlhQlhGRGxJdmpoRWFOZThuZUZr?=
 =?utf-8?B?RUdWOEhoSi95bmtaKzZjV2JqVTBqUXcybmYzUnltY3REN2tLNE5LRW4vdjVP?=
 =?utf-8?B?NW9kb3FIQzBxY1phaUZMbE9GdGYycC9YRFhVejU1RW12RWt4VlQwYUk5dGNt?=
 =?utf-8?B?TzVIdVN6a21BWGFOK3N1WGlCRGVGMlR4MmZndTFUZjBlYjhTbjFRTWtxQksz?=
 =?utf-8?B?WitXL3FnbEFOT1lDQUVJaVZUT3h5bDlERk03Q2VQOGdNa011MnloYWpBTFhV?=
 =?utf-8?B?NnA1L1A5blY2Ny9kdFg3eFp4NUFZcUpmbHMwUEc5OVlKMG5IdkUycGFLYmpX?=
 =?utf-8?B?OFQ0UDEwMERoaU5nekFFeWpuQUdGNEtvV3hLY1k0bENtYXoxQTR1cSszQ2JM?=
 =?utf-8?B?dG1QaFFSMUhGYWhuUHIxQVhxNXBjblpDTzdzMDdXY1BDWFU5aGs3bkF2VG9H?=
 =?utf-8?B?RFBra2VHcGlMeG44WkJDVmNzbEs1Q1ZsRXlUcFJ6M0RiQjROWlM4SEpSejFK?=
 =?utf-8?B?bGxSVVB0NjFZTnIrUjBkaXJHbC9hTk96L3crUlUyaXlwMFM4ZTZjamF2NnRj?=
 =?utf-8?B?VGpjNnRUcmRFOGhZb3hITHlEYWNvZUtGc3B6UFVZUmhUK2ZvN0NVZndxT0ht?=
 =?utf-8?B?ZmVjVkJwUVBPZUJWVU5ESlJycndlYzU4SU01dWkzM3ExY0RFSE16cm1UZjR1?=
 =?utf-8?B?VjdWenN0L1Byd3ZCSFZTbmRsWDhWTW93dlZDNUdlUlN1c09kM1FNRFBGSGMw?=
 =?utf-8?B?OElYNlpFWFhXa1J3UysydUY1aHBUdnYyb0hwaVF6MlMyREdxV3F5Z0pYeW1F?=
 =?utf-8?B?YXhoNGFuODJPUllicGhET3hnNGhTN0tTQXdaY1Y4UlNRQklKRERrT2xkQ1ZC?=
 =?utf-8?B?MFRzZ0FpUUUyTy9EM2FKa2lxWTJES0FPd2dVMVBReVlGRFlVby9CV0ZlSHd6?=
 =?utf-8?B?N3YxbHJDTTBYdHpCTWVNdVZYa0lTL3dwR3pOWFB5cTRaTUZydXRkYzdOcmMx?=
 =?utf-8?B?K2lNcmxEY2RIajMrWE5EdVJoZjczZ1pwRDBiOHRubU82M3lLb3F1OG00a0Zm?=
 =?utf-8?B?QllPaWd2R3BCbHBnUnlvaHFnbFBHYXFuU2szaEd4MTlGbFRxcjhiYWdYYjBE?=
 =?utf-8?B?T0hYQmhIYXpMdEJJQzhIRHFPaFo0dkg2c2tqekd3anh5TC9yQU9wenVNQ2NP?=
 =?utf-8?B?YTdlWkZLa2RjSGZNNnZJaWdNSkdvMlpkQWJPUUN2ZmdqUjhwaVhGaWRnSDcx?=
 =?utf-8?B?NmNqOVZpSENTSS9aS25pZHJJUzRDeEttNXp0bUgwdWxYbmNLQWhkc1dnZ3hv?=
 =?utf-8?B?QnB4Ry9mRElrYzUvNUF4aGpXVVF4ZTlaR3RLUUI4SXZVa1pJcDdTbTV1RW51?=
 =?utf-8?B?L3RxL1NRRHdnakROWkw2ZUFiNmtiNCtoRVdHZnZTa3dIKzk1QW1JcHNzL282?=
 =?utf-8?B?RUdlTGRiUDNKVHJuejFSZlExOWhTekVkUVFiNEs1NTFpUnhUbFBOdkZjVDNj?=
 =?utf-8?B?R25oeDdlTExOVVcxMnYyazJZeC9JdHpPOG9RVzRTVDhCb0l4OHdzZ0NTVVRF?=
 =?utf-8?B?OXFRdk5GZ2JLL0xXOU5rTnRaNDdqMC9XaXdyMGVERGZZeWp5WTB4U2V3b2tn?=
 =?utf-8?B?c2h0STlJSDhJbmhlc0RCdlN2S1dNWjBWZUtXOWRPOUFUZDVsYm5qWEUwNGNI?=
 =?utf-8?B?ek4xN0g5eUI2NHhKSEgrV1BPQ1RsNHFzbG5EbjZiZ0lodXo5SnVQa1krTUtx?=
 =?utf-8?B?L1ZmcnBDS1gvMjI5ZGU1MmN0Nmxabyt0aEhvTkFGUVpDa1BvRW9zU256MTdm?=
 =?utf-8?B?STNINXBiNmVJbTEwRWo3Nm9xd0VCT1RnaC92WklmSUw0cmlzY1E4dTkrdjky?=
 =?utf-8?B?b3NxYWh4cTFBdkc4MVZLN3ZNL2toek51VFA1K1FPbi9ZdHBpdkhHRnJTYm5m?=
 =?utf-8?B?Rm9VYWhXdXVOd0tza0pPb3E2Y1JjUEwxR1d4a0J6ekEyTVpDdjZwdGFTTzc2?=
 =?utf-8?B?RHdpQXdmS2RKaFp1ZklJcjhPNjMrSlY1ems5UnFkMVhmcExEYzc2YUc1TEw2?=
 =?utf-8?Q?Bjd8mqP8KAvs6Xko=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61FAEAB7EAC20D4EB4F37CB6F445BD2B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: an0GbLiuMJk3SmbU5kN48Of9YIWHd3ddtAXTemW9nXLdCHQ5B4Y7F3KtKDjk7bsmbxWgMrpAKbCys7Rk0SHHGu3QmbXP7GwK1g9O6EXYuyD+qe+qRKjJe0jW4RPLPhbCgPU/5YdXmB6oCloomzfoymsIfh7jcBi9EaiE937SIm/8IdMuucroiEv793ouI8HiUWFm1XdEV9sf9w1O6DDY1ldtmXjSlO9x65qAyU8ivpUEllMxvFhCGNmTZOAP4PEamyO3qgMWopNvwsrLPQcJSR66+4UeV230FEAKeRTkaezkf3OZhkYHEs6xl2tUug1oCWn5cgiU7bDGGnpuKo84aw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130c9980-f6d9-4f75-314b-08df287beace
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 16:14:39.5073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4rpfNzV7J0vDpSHOs7/zzS/gKsQI4LmVuREBAWNxsnrIcRXlQfyC7Kh30/utXusdenzAkiWp52AVsGUTNj40BLpAY628WE3hb29ssO6togY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5291
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTEwLTEwIGF0IDEzOjQyICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
U2F0LCBPY3QgMTAsIDIwMjYgYXQgMDY6MDA6MDFBTSArMDgwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gRnJpLCAyMDI2LTEwLTA5IGF0IDE3OjMzICswODAwLCBZYW4gWmhhbyB3
cm90ZToNCj4gPiA+IE9uIFRodSwgT2N0IDA4LCAyMDI2IGF0IDA5OjA1OjMyQU0gKzA4MDAsIEVk
Z2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiA+ID4gPiBPbiBNb24sIDIwMjYtMDktMjggYXQgMTc6
MTEgKzA4MDAsIFlhbiBaaGFvIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBAQCAtMjE4Myw3ICsyMTcy
LDEzIEBAIHN0YXRpYyBpbnQNCj4gPiA+IHRkeF9oYW5kbGVfZ3Vlc3RfYWNjZXB0X2VwdF92aW9s
YXRpb24oc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBnZm5fdCBnZg0KPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiA+ID4gDQo+ID4gPiDCoMKgwqDCoMKgwqDC
oCBsZXZlbCA9IHRkeF9nZXRfZXB0X3Zpb2xhdGlvbl9sZXZlbCh2Y3B1KTsNCj4gPiA+IC3CoMKg
wqDCoMKgwqAgaWYgKGxldmVsID4gUEdfTEVWRUxfMk0pDQo+ID4gPiArwqDCoMKgwqDCoMKgIEtW
TV9CVUdfT04obGV2ZWwgIT0gUEdfTEVWRUxfMk0gJiYgbGV2ZWwgIT0gUEdfTEVWRUxfNEssIGt2
bSk7DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKgIC8qDQo+ID4gPiArwqDCoMKgwqDCoMKg
wqAgKiBObyBuZWVkIHRvIGluaGliaXQgMUdCIG1hcHBpbmdzIHNpbmNlIHRoZXkgYXJlIHVuc3Vw
cG9ydGVkIHdpdGgNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCAqIHRoZSBpbml0aWFsIGh1Z2UgcGFn
ZSBpbXBsZW1lbnRhdGlvbi4NCj4gPiANCj4gPiBUaGlzIGFsc28gaW1wbGllcyAxR0IgaXMgY29t
aW5nLi4uDQo+IFdoYXQgYWJvdXQgc2ltcGx5IGNvbW1lbnRpbmcgYXMNCj4gIk5vIG5lZWQgdG8g
aW5oaWJpdCAxR0IgbWFwcGluZ3Mgc2luY2UgdGhleSBhcmUgdW5zdXBwb3J0ZWQuIiA/DQoNClNl
ZW1zIHJlYXNvbmFibGUuDQoNCj4gDQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgKi8NCj4gPiA+ICvC
oMKgwqDCoMKgwqAgaWYgKGxldmVsID09IFBHX0xFVkVMXzJNKQ0KPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiA+ID4gDQo+ID4gPiDCoMKgwqDCoMKgwqDC
oCBpZiAoaHVnZXBhZ2VfdGVzdF9ndWVzdF9pbmhpYml0KHNsb3QsIGdmbiwgbGV2ZWwgKyAxKSkN
Cj4gPiA+IEBAIC0yMjAzLDggKzIxOTgsNiBAQCBzdGF0aWMgaW50DQo+ID4gPiB0ZHhfaGFuZGxl
X2d1ZXN0X2FjY2VwdF9lcHRfdmlvbGF0aW9uKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ2ZuX3Qg
Z2YNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgKiBzZXF1ZW5jZSByZXF1aXJlZCBieSB0aGUgVERY
LU1vZHVsZSBpbmNsdWRlcyBhIFRMQiBmbHVzaC4NCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgKi8N
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgIGh1Z2VwYWdlX3NldF9ndWVzdF9pbmhpYml0KHNsb3QsIGdm
biwgbGV2ZWwgKyAxKTsNCj4gPiA+IC3CoMKgwqDCoMKgwqAgaWYgKGxldmVsID09IFBHX0xFVkVM
XzRLKQ0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaHVnZXBhZ2Vfc2V0X2d1
ZXN0X2luaGliaXQoc2xvdCwgZ2ZuLCBsZXZlbCArIDIpOw0KPiA+ID4gDQo+ID4gPiDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gMDsNCj4gPiA+IMKgfQ0KPiA+ID4gDQo+ID4gDQo+ID4gVGhlcmUgYXJl
IGEgbG90IG9mIHBvc3NpYmxlIHRoaW5ncyB0aGF0IGFyZSBub3QgaGFuZGxlZCBpZiBhIDFHQiBt
YXBwaW5nDQo+ID4gc25lYWtzDQo+ID4gdGhyb3VnaC4NCj4gPiANCj4gPiBXaHkgbm90IEtWTV9C
VUdfT04oKSBpZiBzb21ldGhpbmcgdHJpZXMgdG8gbWFwIDFHQiBpbiB0aGUgYXBwcm9wcmlhdGUN
Cj4gPiB0ZHhfc2VwdF9zZXRfcHJpdmF0ZV9zcHRlKCkgc3ViIGZ1bmN0aW9ucy4gdGR4X3NlcHRf
c3BsaXRfbGVhZl9zcHRlKCkgc2hvdWxkDQo+ID4gYmUNCj4gPiBjb3ZlcmVkIGFscmVhZHksIGJ1
dCBub3QgdGR4X3NlcHRfbWFwX2xlYWZfc3B0ZSgpIGxvb2tzIGxpa2UuDQo+IEhtbSwgdGhlcmUn
cyBhbiBpbXBsaWNpdCBLVk1fQlVHX09OKCkgaW5zaWRlIHRkeF9zZXB0X21hcF9sZWFmX3NwdGUo
KSBhYm91dA0KPiB0aGUNCj4gbWFwcGluZyBsZXZlbDogYm90aCB0ZHhfbWVtX3BhZ2VfYXVnKCkg
YW5kIHRkeF9tZW1fcGFnZV9hZGQoKSByZXR1cm4gZXJyb3IgaWYNCj4gdGhlIG1hcHBpbmcgbGV2
ZWwgaXMgMUdCLg0KDQpPaCByaWdodC4gU28gaXQncyBjb3ZlcmVkLiBJIGd1ZXNzIHRoZSBvbmx5
IHRoaW5nIG1pc3NpbmcgaXMgZXhwbGljaXQgS1ZNX0JVR19PTg0KZm9yIGRvY3VtZW50YXRpb24u
IEknbSBvayBsZWF2aW5nIGl0IG91dCB0aG91Z2guDQo=
