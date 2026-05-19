Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C9023392D;
	Tue, 19 May 2026 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193008; cv=fail; b=rhywLcoLstwPquzEoukesj0KX7gkqGWkrFyHDBSHE0YaAfN8tV0xj8OiQiQuIs/RwlzbI6cImFw0XDQqOqpTLZB/JZNjCSy40wn5P/74eQCHzeHqTneWIHnRjV6aFhr8CjmVhO+eQHluNFFv56htEPt4dsk4ZKfyo9pJO+bOmDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193008; c=relaxed/simple;
	bh=FlVriLx3OFnLQu52SXKvQJ6uCt7D46SIYxCU7H9QbSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RbdHDkSaLqHvVYSRKCTduRWnjQvAtMgCYi8ZWe0HlggyaoQbqvexWyPK4GITgw3le2OdxjR9f1W0ptaoCw39VluXiPCJh/DohINN2xR/1b/tmXDGPgy36MWlgaHelkogyGY/w53errj/GWwGi3sx/2ICaykiemeQrTrhommuK8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhrMcca2; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhrMcca2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779193007; x=1810729007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FlVriLx3OFnLQu52SXKvQJ6uCt7D46SIYxCU7H9QbSw=;
  b=fhrMcca2ifKnet9neU69Bx1NA46crjSIh3+BdcJOZx00w11TkakFn+NP
   quPR5eVxyVtLl03X8fJ3Ijf8MUz0YVOH6PjTX83if0slIsTkHDuLHsDrj
   uEqvwXctqq+uDkKFxbllZ/PZyruNuECL2eMu+N7an25kTN/+Q9s6Aw+Fy
   nggIsfyBJNPuOHtAnGNDki0GOpQoyO2XtfR5rCwk0Q5bj3jr1ctt3FbZJ
   h1SANo+do3TARSWNBy0AxNmrxRB8dveDOil57BfqtoLY/eU0aaZ4XbiRe
   wQgJIfyuRhF+5LX1mHLjVUiDF1rlFLFfe+R7/wAHnkrZ7bjswL1BKwDEP
   w==;
X-CSE-ConnectionGUID: qOvjfXegS7aKLdPSRhjrwQ==
X-CSE-MsgGUID: hoT3gMihS0OC8wGDDPKMDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="83926152"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="83926152"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 05:16:46 -0700
X-CSE-ConnectionGUID: qbIJhVvcTt2VZPdF54CnAQ==
X-CSE-MsgGUID: o/QuKuGBTu2XJ4zY4TD/xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="243745718"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 05:16:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 05:16:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 05:16:45 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 05:16:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCBdMoUQfvyYNIrJZAo6CmlVsR6ZWLdVnSJRMNKkCYpz9Od6vJymUlwcB0o8hrmH5aejbwJUM0yy4C6/rnYSnFPMw+hBLzStdLmxjv8v6XmK1AIt3eTzxV9sMJjJ4E9QHyAfvvwoobPvt8HTssM47vP4zOdolXME0Qo1np4rex3hyTLhhDOUq9Hh9tVQ36kmulgaKwtKjthjijtXnTv74Mr7Gvlf6lg2t/oq2DYuqsAEe/0BHqGHwiUNk/exbEYuXi3U2RSe5KW4bTcbwyT1T2ljqvGnycH0XZDB5asgt1R7fS0oNwsyRjQTseCC5ApGVNNZz94djfJ+nf2RTq1SPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlVriLx3OFnLQu52SXKvQJ6uCt7D46SIYxCU7H9QbSw=;
 b=XMn0KmekrVoz54rJLOuE3cOn2zTfltzVNSd96eAHpVqEEIDSFXXfDpr2YhfvZMf2sMKirGmbWG51Mv5IOq012W1uXkcp7MHufdzbXy4xUYkazsaOtW0w/XfMdofO7WefCxilv/sri8uw9rIhU0QkWszoYc1jeyGHxFYJ2+9ds1HCU3NdV6QTUB9OrKXUd3U4owJl7OgmjyWAI8hljBGX55uVHpN0s7XKxp43QR/OagV5AIDsSBuwWanHcWbuS4KT2kUcxDPnKKjrSmxCr7yVuwKGQnpYkVhHjYz6KcADuhDVbeyXCSNYc9NQExVO4Oo2ralzCOO6oYah52cz7DE9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 LV8PR11MB8558.namprd11.prod.outlook.com (2603:10b6:408:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Tue, 19 May
 2026 12:16:40 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 12:16:39 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH v2 15/15] KVM: x86: Move the bulk of register specific
 code from x86.c to regs.c
Thread-Topic: [PATCH v2 15/15] KVM: x86: Move the bulk of register specific
 code from x86.c to regs.c
Thread-Index: AQHc4+xAhMVQIxjW5UeBHPSlwKOJO7YVStWA
Date: Tue, 19 May 2026 12:16:39 +0000
Message-ID: <074e209fe4c78a735868099f13d76b9dde2c88e3.camel@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
	 <20260514215355.1648463-16-seanjc@google.com>
In-Reply-To: <20260514215355.1648463-16-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|LV8PR11MB8558:EE_
x-ms-office365-filtering-correlation-id: 54d4260c-0e2c-4073-03a8-08deb5a07b21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|11063799006|22082099003|4143699003|56012099003|18002099003;
x-microsoft-antispam-message-info: UlcE0jdkoWM6ABKGzgmjyjOJrC/MI3c5fi2Yj+AQlyDWTGkN4XoTCY+wckq6lRETmn84Nmx/sw/M67a6H0Xk7aM83LN5Uf9nIBM0poZ52MFs7ANXWXcxsZKrDEEc7OvRMjf1S38Kfp/Pe0oli5OA3bGGxkdKnr7dmvpgrPHzl8V9sZwQ0ADMoaYfnCyv8Y+qummz2gUF7S5atvSCnXGjCUVkPU+ucCR2h8VWfOFw+i7rbFNqD4/ZMxEgbGVYwoFjAulglCLqfIlKFlBE9BuQ9JI0Qb1w4PEFX6r1hBWCxvEyN8VlQY8iqfUxBqFwDN/ANH2d5aA/nUCWWXnWIOt5oJvS8pnvoRFwelVS/xcpzrm6O4xkBlXjjNsPotAlDebhHNF3+LgLBeE88uY8MmBmiFjf++3mdi1D456j4jQORYnTau5PTFQU0mfsW4IyoQADC8Rksz58bNSBipRctLdWXqc9vreSn8kpT5YtnbuPghoE42dUM26ytChcOgz9XVZ02XHDRxiBDSP7hKRrPv3DB2qQn930OHo6cIV9HJOJj3WQ6oUnQ+x0rAUehYLIFfS+HItoNBV33pm+OqnlMsT4kc4Y6coiE47XyGv4nHIyE+fnDP4rjKM/Cg3UrLfJZBPce3Jtbsf4dPyyNsXWoR9+xnRxf05BJ4+RFLGvjdN1cXywNzqsoq05/TEG9UQ2HvRm7s3u2Phk1468aeC/F2zs985V5cLzSx2ENWpTm/VyXURONXLdWLvK+Ro8LVOnLiIE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(11063799006)(22082099003)(4143699003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aS9td2s2cTFvTkZqMFUrUUxGbDR6WGpISDBtelpNRkNZRUd4alM1YjF3R2lh?=
 =?utf-8?B?SmVXWlM4SlRRazZGNUtCQkxoT1YvYUNDYmhCbStseXBRdXRMbnpSNWxXVmd1?=
 =?utf-8?B?eDZMQnhRb01ZR0NJNVFiQzRPWjc2cmVmblBIb0ZPYnJ3RzNYbkV6SjFWMThs?=
 =?utf-8?B?YlR5ZjNydmVoVXo0cHEyd2lvQUM3cFZ5MXRRZ1VWWlB0K1BTc3JPL2lmU3Zk?=
 =?utf-8?B?YisybldpK3dDZy9kam93ZVBIUnpQa01SNTJIRmNDaWdxV0s5UUNKUis2VUla?=
 =?utf-8?B?ZUdKbUh0TTd2ZkZqczBWQklMVWYvVTFqRGtFUE04cUJZRWdjL1ZzMlZOVjdR?=
 =?utf-8?B?ZG1qVW9lNWdnQVdWdU4zMHgrVGl0ZzBYYW9ac09IOERoWk5LL1dwaE4wWmdi?=
 =?utf-8?B?Y2RLdE9hQ0ZienlZaEtxc3pwd044c2hhSlRnM1FOaFNiMVZhbmtmQWpUSHlZ?=
 =?utf-8?B?d0krOVMyZlJ1aEdhMEdnR1lLWlNHSVAzNHVwK1NEeGdaOWNXQ3gxT0V1VWFR?=
 =?utf-8?B?S2hBa2FnM2xaT3RXdXYwaEQyUmtxcm8zelBmdFRSSW9qV2gxQTV6c2JKRW1u?=
 =?utf-8?B?NFk1OW9ibnZ2d2JIdTlzbWwyMW1BZncrbG5SWkdJQlByMFBOMHU3ZGxhVG5F?=
 =?utf-8?B?ckdxeGp5cWwyVDY1d1AvOFgzdWVRUm1uWWZnY1Q2L29nNzkzZEhKMDA5aW5v?=
 =?utf-8?B?dkdWMUpWa3g5NkRFM3BGZllqaExRcVV0WWhYdUJtcUIrQnd3ZWh4dFVienRa?=
 =?utf-8?B?RDM3WmZYc3ZkOUN4V2RVUWtTY0tqaDVXTzZ2UFdBOUQxM0R5c0lqaHJ3eWxq?=
 =?utf-8?B?MFlsVDZUMFZVMjdSR3RpZGhXVm1QYU96TzhkUUZaZTRsS2tTV1ZoTGxBeWpV?=
 =?utf-8?B?TVhGeUZnbnRPaVVJUXVnKzlieVZMT2lwb3ZYeG9vdFUyTGNSa1JSZHNLYVJH?=
 =?utf-8?B?SjRoNFl3SzlKTTBNUDFBbmxUVldtcE1MRTE3T3Q5bnFkc0tlY3hCTWtwZFhX?=
 =?utf-8?B?YkxSTVQ0Ty81WmNTMjJEOHJ6M3F3aW5ldDB2aEJGdWVQa0phRTJPYlVTckV6?=
 =?utf-8?B?UjVmVFVPYUE5MGY4VkRjNmozZUp5K09qdzh4K0pETCt6cjFIR0VDaDdyMk5u?=
 =?utf-8?B?WnEyK1JmeHhlclBMM3BFdGY0LzM3ZDhzbjh0TitrUC9laW80RW9sT2M1VGw2?=
 =?utf-8?B?TzN3NHNYSzl4TmM5Z3BKYk1QaXY5ampNQVA2TUJmWGVvT0tGOGdaTUVvRlhC?=
 =?utf-8?B?Y1JsMGdZeHBEV216WlZmcEdnaW1Bc2FWRWpqUVRucVdzblM0TjNQOFpOOGZm?=
 =?utf-8?B?NDdjQWV5cnpncVlKSlRxVEgxQ281cXByWGxGWXplUmllY1NUZ0E4WHJBUzV2?=
 =?utf-8?B?QlQzVEJNWGxzallpeFdVck1UWTBKRm10UWowUFArT0tWYStjVlFOYWZrQmxt?=
 =?utf-8?B?ampWL1dnKzRBbUNvbHV6THBtdUsrU3NrK2RmaExwdkVkMmVBa0VraWZKRWFL?=
 =?utf-8?B?UUM4Rk1Sbk9pUzU2VnFpd082c2VRVEN2RHJZU3dzbE1FNWZNb0VLbGZNQUhW?=
 =?utf-8?B?NldETkp4cEVxY0tvc21Wdk41NVNSQjc3SkZHVDRMUFMzV21HaU9kOXlEMkVF?=
 =?utf-8?B?NG02czFvbWszaHlOYkk0NzdsVE9sM3hOL2luSjhJOWU2ZUU0dDhMdDNiSFBk?=
 =?utf-8?B?cXFEQTJaSi9TQmt3MExhVERkdWpnK09SY3FrNlFzdDBDdjhNdDdMalBVUFZV?=
 =?utf-8?B?eDRVSmIwbFczN045TFhJTGpSSStpVkc2QytiK3g2eEdHZUZFdFJRN3Vsd0Zo?=
 =?utf-8?B?WVN5SXZNTFlMU2lySzBJTHVOOUZHYkQ2V3BSOTBzY0ZDa1lqUTE0WkFTM1JM?=
 =?utf-8?B?OWJjZ01YcGdENzBtYXZ5Nlp5MGFYNkZwaksrS2M5S3V0S1NaMjhYSjFiSTk5?=
 =?utf-8?B?ZXduNHppZ2ppbTQrUEs3azdiaXZETWU1clhHTXZXSEJQQkRYZDh4UE5TdGts?=
 =?utf-8?B?amZ2b2h4QlFJdnEwSElxd3g4ZkU4R1FoNWJoejNza0x5MSs4ZURZWGtZTlpH?=
 =?utf-8?B?bFc0SEJRU0ppalFaZ3BBQ2dTTS9mcS8vQTdwRWREOTNNcWFXREk4QkZURE5N?=
 =?utf-8?B?aGNGYkFxSUZGV1pXOWZDUUlPVXpoU09nZlRpa24wU1FwUERXcDRua2pvcVJY?=
 =?utf-8?B?aU5OLzk3WWZOeElDUkRkd2hXVFNCd1VCejhndFNtYXQxeUJjWTZVeS95TnVX?=
 =?utf-8?B?SnRuNGNjYVVGNUl0Z0V2a3hGN2g5emcyYVNuQ1NtTElFZlh3Umd5VTFVdkdF?=
 =?utf-8?B?d3hGSTRHL3N1WXpGSEdvYXRLcXhiNzI0VEV6OVkyWS9sOFZLTEN5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2606C4F6AD394940AC740F8EDAB959BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SCu9GGt+PmkwRy8lYlfcqJiodDmF5a6QSxfujzxu8zh1u/Jvwrfxre6+7cx+oiziUJH70X3FWRrSyCZ+WEYronmFgEGwb7NiOqygqmv7nvYnyI9tYzc70k94xiXRjK2Te2192uVcHcMRXT8Ux11wMM6UMuQ85Z1xbO6wld4mFc3As1uHjufq/xKf7KJ/Z0elZn0Vd7BcfSQHOgxgfJ/9rk7kUrGCDVdel+Awi3Lyb5W+Ng0MRPOzG4cBcCppGy8oRAZ2W26lM219W8TOSJ++ckjJS4MctmlQo1h+DWzBZi6j9nW6PP2OOW9jB4JgJYyhJsIhwbH9jQu80AM9eiIo4g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d4260c-0e2c-4073-03a8-08deb5a07b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 12:16:39.8131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b69kvGKKDmO+EgiU71xcCqab2SiL+j1NK/AdJVB256EzQG1IZG97/ztTMV78NAgcBVUTkKxDlFwbCuUj5bIdKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8558
X-OriginatorOrg: intel.com

DQo+ICt2b2lkIGt2bV9ydW5fZ2V0X3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KPiArew0K
PiArCUJVSUxEX0JVR19PTihzaXplb2Yoc3RydWN0IGt2bV9zeW5jX3JlZ3MpID4gU1lOQ19SRUdT
X1NJWkVfQllURVMpOw0KPiArDQo+ICsJaWYgKHZjcHUtPnJ1bi0+a3ZtX3ZhbGlkX3JlZ3MgJiBL
Vk1fU1lOQ19YODZfUkVHUykNCj4gKwkJX19nZXRfcmVncyh2Y3B1LCAmdmNwdS0+cnVuLT5zLnJl
Z3MucmVncyk7DQo+ICsNCj4gKwlpZiAodmNwdS0+cnVuLT5rdm1fdmFsaWRfcmVncyAmIEtWTV9T
WU5DX1g4Nl9TUkVHUykNCj4gKwkJX19nZXRfc3JlZ3ModmNwdSwgJnZjcHUtPnJ1bi0+cy5yZWdz
LnNyZWdzKTsNCj4gK30NCj4gKw0KPiAraW50IGt2bV9ydW5fc2V0X3JlZ3Moc3RydWN0IGt2bV92
Y3B1ICp2Y3B1KQ0KPiArew0KPiArCWlmICh2Y3B1LT5ydW4tPmt2bV9kaXJ0eV9yZWdzICYgS1ZN
X1NZTkNfWDg2X1JFR1MpIHsNCj4gKwkJX19zZXRfcmVncyh2Y3B1LCAmdmNwdS0+cnVuLT5zLnJl
Z3MucmVncyk7DQo+ICsJCXZjcHUtPnJ1bi0+a3ZtX2RpcnR5X3JlZ3MgJj0gfktWTV9TWU5DX1g4
Nl9SRUdTOw0KPiArCX0NCj4gKw0KPiArCWlmICh2Y3B1LT5ydW4tPmt2bV9kaXJ0eV9yZWdzICYg
S1ZNX1NZTkNfWDg2X1NSRUdTKSB7DQo+ICsJCXN0cnVjdCBrdm1fc3JlZ3Mgc3JlZ3MgPSB2Y3B1
LT5ydW4tPnMucmVncy5zcmVnczsNCj4gKw0KPiArCQlpZiAoX19zZXRfc3JlZ3ModmNwdSwgJnNy
ZWdzKSkNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJCXZjcHUtPnJ1bi0+a3ZtX2Rp
cnR5X3JlZ3MgJj0gfktWTV9TWU5DX1g4Nl9TUkVHUzsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4g
MDsNCj4gK30NCj4gDQoNClsuLi5dDQoNCj4gQEAgLTEyNjk5LDExICsxMTkwNCw3IEBAIHN0YXRp
YyB2b2lkIHN0b3JlX3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KPiAgew0KPiAgCUJVSUxE
X0JVR19PTihzaXplb2Yoc3RydWN0IGt2bV9zeW5jX3JlZ3MpID4gU1lOQ19SRUdTX1NJWkVfQllU
RVMpOw0KPiAgDQo+IC0JaWYgKHZjcHUtPnJ1bi0+a3ZtX3ZhbGlkX3JlZ3MgJiBLVk1fU1lOQ19Y
ODZfUkVHUykNCj4gLQkJX19nZXRfcmVncyh2Y3B1LCAmdmNwdS0+cnVuLT5zLnJlZ3MucmVncyk7
DQo+IC0NCj4gLQlpZiAodmNwdS0+cnVuLT5rdm1fdmFsaWRfcmVncyAmIEtWTV9TWU5DX1g4Nl9T
UkVHUykNCj4gLQkJX19nZXRfc3JlZ3ModmNwdSwgJnZjcHUtPnJ1bi0+cy5yZWdzLnNyZWdzKTsN
Cj4gKwlrdm1fcnVuX2dldF9yZWdzKHZjcHUpOw0KPiAgDQo+ICAJaWYgKHZjcHUtPnJ1bi0+a3Zt
X3ZhbGlkX3JlZ3MgJiBLVk1fU1lOQ19YODZfRVZFTlRTKQ0KPiAgCQlrdm1fdmNwdV9pb2N0bF94
ODZfZ2V0X3ZjcHVfZXZlbnRzKA0KPiBAQCAtMTI3MTIsMTkgKzExOTEzLDggQEAgc3RhdGljIHZv
aWQgc3RvcmVfcmVncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+ICANCj4gIHN0YXRpYyBpbnQg
c3luY19yZWdzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gIHsNCj4gLQlpZiAodmNwdS0+cnVu
LT5rdm1fZGlydHlfcmVncyAmIEtWTV9TWU5DX1g4Nl9SRUdTKSB7DQo+IC0JCV9fc2V0X3JlZ3Mo
dmNwdSwgJnZjcHUtPnJ1bi0+cy5yZWdzLnJlZ3MpOw0KPiAtCQl2Y3B1LT5ydW4tPmt2bV9kaXJ0
eV9yZWdzICY9IH5LVk1fU1lOQ19YODZfUkVHUzsNCj4gLQl9DQo+IC0NCj4gLQlpZiAodmNwdS0+
cnVuLT5rdm1fZGlydHlfcmVncyAmIEtWTV9TWU5DX1g4Nl9TUkVHUykgew0KPiAtCQlzdHJ1Y3Qg
a3ZtX3NyZWdzIHNyZWdzID0gdmNwdS0+cnVuLT5zLnJlZ3Muc3JlZ3M7DQo+IC0NCj4gLQkJaWYg
KF9fc2V0X3NyZWdzKHZjcHUsICZzcmVncykpDQo+IC0JCQlyZXR1cm4gLUVJTlZBTDsNCj4gLQ0K
PiAtCQl2Y3B1LT5ydW4tPmt2bV9kaXJ0eV9yZWdzICY9IH5LVk1fU1lOQ19YODZfU1JFR1M7DQo+
IC0JfQ0KPiArCWlmIChrdm1fcnVuX3NldF9yZWdzKHZjcHUpKQ0KPiArCQlyZXR1cm4gLUVJTlZB
TDsNCg0KTml0Og0KDQpEbyB5b3UgdGhpbmsgJ2t2bV9ydW5fc3luY19yZWdzKCknIGlzIGJldHRl
ciB0aGFuICdrdm1fcnVuX3NldF9yZWdzKCknPw0KDQpCZWNhdXNlIEkgdGhpbmsgInN5bmMiIHJl
ZmxlY3RzIGJldHRlciB0aGF0IHZjcHUtPnJ1bi0+a3ZtX2RpcnR5X3JlZ3MgaXMgY2xlYXJlZA0K
YWZ0ZXIgdGhlICJzZXQiIG9wZXJhdGlvbi4NCg0KPiAgDQo+ICAJaWYgKHZjcHUtPnJ1bi0+a3Zt
X2RpcnR5X3JlZ3MgJiBLVk1fU1lOQ19YODZfRVZFTlRTKSB7DQo+ICAJCXN0cnVjdCBrdm1fdmNw
dV9ldmVudHMgZXZlbnRzID0gdmNwdS0+cnVuLT5zLnJlZ3MuZXZlbnRzOw0KDQpBbHNvLCBJIHdv
bmRlciB3aGV0aGVyIGl0J3MgYmV0dGVyIHRvIGFkZCBhIGhlbHBlciBmb3IgZXZlbnRzIHNvIHN5
bmNfcmVncygpIGFuZA0Kc3RvcmVfcmVncygpIGNhbiBiZSBzaW1wbGlmaWVkIHRvOg0KDQpzdGF0
aWMgaW50IHN5bmNfcmVncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQp7DQoJaWYgKGt2bV9ydW5f
c3luY19yZWdzKHZjcHUpKQ0KCQlyZXR1cm4gLUVJTlZBTDsNCglyZXR1cm4ga3ZtX3J1bl9zeW5j
X2V2ZW50cyh2Y3B1KTsNCn0NCg0Kc3RhdGljIHZvaWQgc3RvcmVfcmVncyhzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUpDQp7DQoJa3ZtX3J1bl9nZXRfcmVncyh2Y3B1KTsNCglrdm1fcnVuX2dldF9ldmVu
dHModmNwdSk7DQp9DQoNCkFuZCBtYXliZSAna3ZtX3J1bl9nZXRfcmVncygpJyBjb3VsZCBiZSAn
a3ZtX3J1bl9zdG9yZV9yZWdzKCknIHRvbyAsIHNvIHRoYXQgdGhlDQpzdG9yZV9yZWdzKCkgY291
bGQgYmU6DQoNCnN0YXRpYyB2b2lkIHN0b3JlX3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0K
ew0KCWt2bV9ydW5fc3RvcmVfcmVncyh2Y3B1KTsNCglrdm1fcnVuX3N0b3JlX2V2ZW50cyh2Y3B1
KTsNCn0NCg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3g4Ni5oIGIvYXJjaC94ODYva3Zt
L3g4Ni5oDQo+IGluZGV4IDE4NTA2MmEyNjkyNC4uZmQ1NWNkMDMxYjFjIDEwMDY0NA0KPiAtLS0g
YS9hcmNoL3g4Ni9rdm0veDg2LmgNCj4gKysrIGIvYXJjaC94ODYva3ZtL3g4Ni5oDQo+IEBAIC00
MTQsNiArNDE0LDcgQEAgaW50IGhhbmRsZV91ZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOw0KPiAg
DQo+ICB2b2lkIGt2bV9kZWxpdmVyX2V4Y2VwdGlvbl9wYXlsb2FkKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwNCj4gIAkJCQkgICBzdHJ1Y3Qga3ZtX3F1ZXVlZF9leGNlcHRpb24gKmV4KTsNCj4gK3Zv
aWQga3ZtX2hhbmRsZV9leGNlcHRpb25fcGF5bG9hZF9xdWlyayhzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUpOw0KPiAgDQo+ICBpbnQga3ZtX210cnJfc2V0X21zcihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUs
IHUzMiBtc3IsIHU2NCBkYXRhKTsNCj4gIGludCBrdm1fbXRycl9nZXRfbXNyKHN0cnVjdCBrdm1f
dmNwdSAqdmNwdSwgdTMyIG1zciwgdTY0ICpwZGF0YSk7DQo+IEBAIC02MDQsNiArNjA1LDcgQEAg
c3RhdGljIGlubGluZSB2b2lkIGt2bV9tYWNoaW5lX2NoZWNrKHZvaWQpDQo+ICBpbnQga3ZtX3Nw
ZWNfY3RybF90ZXN0X3ZhbHVlKHU2NCB2YWx1ZSk7DQo+ICBpbnQga3ZtX2hhbmRsZV9tZW1vcnlf
ZmFpbHVyZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGludCByLA0KPiAgCQkJICAgICAgc3RydWN0
IHg4Nl9leGNlcHRpb24gKmUpOw0KPiArdm9pZCBrdm1faW52YWxpZGF0ZV9wY2lkKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwgdW5zaWduZWQgbG9uZyBwY2lkKTsNCj4gDQoNCklmIEkgcmVhZCBjb3Jy
ZWN0LCB0aGlzIGlzIGJlY2F1c2UgInJlZ3MuYyIgY2FsbHMga3ZtX2ludmFsaWRhdGVfcGNpZCgp
IGJ1dCB5b3UNCndhbnQgdG8ga2VlcCBpdCBpbiB4ODYuYy4gIEJ1dCBpdCBzZWVtcyB0aGUgIng4
Ni5oIiBpc24ndCBpbmNsdWRlZCBieSAicmVncy5jIg0KZGlyZWN0bHkgYnV0IHZpYSBvdGhlciBo
ZWFkZXJzICgibW11LmgiIGRvZXMgaW5jbHVkZSAieDg2LmgiKS4NCg0KU2hvdWxkIHRoZSAicmVn
cy5jIiBpbmNsdWRlICJ4ODYuaCIgZGlyZWN0bHk/DQoNCkJ0dywgSSBhbSBhIGJpdCBjb25mdXNl
ZCB0aGUgcmVsYXRpb25zaGlwIGJldHdlZW4gIng4Ni5oIiBhbmQgb3RoZXIgaGVhZGVycyBsaWtl
DQoibW11LmgiIGFuZCB0aGUgbmV3ICJyZWdzLmgiLiAgVGhhdCBpcywgaGVhZGVycyBsaWtlICJt
bXUuaCIgaW5jbHVkZSAieDg2LmgiLA0KYnV0IGhlYWRlcnMgbGlrZSAicmVncy5oIiBkbyBub3Qg
KGluc3RlYWQsICJ4ODYuaCIgaW5jbHVkZXMgdGhlbSkuDQo=
