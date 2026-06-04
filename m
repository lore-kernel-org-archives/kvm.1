Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5B472798;
	Thu,  4 Jun 2026 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576740; cv=fail; b=N51tXUaZJ+Cu+HUWFqv5bcop6n6Wj0jeMV7kUSiRcQPylidaAuIiPmK2wSNEcf3HgbIJwCF16wHYmLuD9+eckHLKYteMtzZK7/PreJUbAWSXLrl4h9jU7KmUNwmqdlIXg0HI6WFIFQkToJsVgqY+JzXagI2EtLEea5c976zOhRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576740; c=relaxed/simple;
	bh=dcGtVWbS4yLGM0oT0eoCITa9HrTUPxSKmxujPoJiKNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RcNwsF76Cxjv4Ia/Gp/aP2d6iGDgxFpWrySai+0L8dRrNq9V5oHfq5gBv4wzgjquFYaomT1B9xqGP17SdAzf2251rEBX3W6qBg/t2nc7ENC0cNg2F3xZQVZlMLOi3NLoGtw3yPAMJzH9sjOGIG8h7CSTgsSL8AThBQ1QsgmYKBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpvSPsw1; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpvSPsw1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780576737; x=1812112737;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dcGtVWbS4yLGM0oT0eoCITa9HrTUPxSKmxujPoJiKNE=;
  b=NpvSPsw1j9rGuoBmr+/pW6qEPMEVl0e8dNKHUGX6W5I8SXlA+Ro1JYgJ
   +Sj7vY2Mg6XLTblVI6CYNnavg9/Cm8/x8pi4jpkqw7FxJSH2j27hUPEqW
   Ha2NkfqwVg13CoZC/wBQ4JbcanKWgG6HSK8hSTJKkwCk6BQLtgsIiNqCB
   6YyvmOxMc0/WO86vgJke9nmcYRVw1RxNqr3Qy2tUwwJrJnTGgApRxAl0y
   G9mLjEmio4fbeE/VgSlIEiWkmtKYH0UoskXqUqrgd0a8omEejAICaZNLM
   AHH3MEVyyLgIVD17WitSMr3x6ZR+Cxubra/d0QA0nOCvcJfAg9cN/XI93
   w==;
X-CSE-ConnectionGUID: fin0ajqhTjWMQDvWirUNZA==
X-CSE-MsgGUID: VWVnnArWRCa+/lzupyZwBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81435052"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81435052"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 05:38:56 -0700
X-CSE-ConnectionGUID: qGe2FdgESDu950q0Q6ryZg==
X-CSE-MsgGUID: NEDzBa46TQSCs6u2q57mgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="244613022"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 05:38:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 05:38:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 05:38:55 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 05:38:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQrwUPkHwomrB/6V/iDCuuljoZdMGeJJiwjgLhG21BkU0Hfib/Y7qU8e8x3aXGfrow0xbYzZmh9/Ebevl0h7WPqIAb/oBDCi2rVsJBH4G/Xq9yJRpNNS+WDHwnBZGy903Gy/tJbpRdDmJP2eIHAXOES6++Kkg7COsN3pm7+1c/vhCKbSiq2Ba48UN20HJKptlO4OaOygKhtolBO8laNWevGPVSf+tTpyajJZq7JF8GlTyQMdLNFmWHej+anJtIcOHaKETZHI+I6acMZW69bGaK/BfKWCglMP+oPjCVHzAdtE8BlgKTJ4npWJFo46he6WLDTz7yHH59PYtUCVI4Bm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcGtVWbS4yLGM0oT0eoCITa9HrTUPxSKmxujPoJiKNE=;
 b=E9deR2uB/139b7ouxsF59h7/CVGFyyegGj31uB28GgV/qWWtMajmytXODg8SHtaGbsoiYCRoyfVFBpHa2/2snG4YXyOoZgkDhCifusz1YZmK+LwJBHLwhRhWyrXf1DAdKhIV45GmLZFq4iaBmMOei9PnUwJnpOuZKk96AkPShckNOEgv6EtdL5ISLD2PT10qr1XfRJdMId5swTq4JvY4hPHWbvqZlAc7KCKT34FlTS01EmIwhzLgWmvglqGbMYNCVxtbZT+Io7hDs2jm8QPpeGpSz1riNaUTDcLwrtgfhLDz5pPZbqD6nuK121F9lKZbtLoJdos+rz7KKd/ddJXs1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA1PR11MB5780.namprd11.prod.outlook.com (2603:10b6:806:233::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Thu, 4 Jun 2026 12:38:51 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 12:38:50 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 27/40] KVM: x86: Move register helper declarations from
 kvm_host.h => regs.h
Thread-Topic: [PATCH v3 27/40] KVM: x86: Move register helper declarations
 from kvm_host.h => regs.h
Thread-Index: AQHc77nFz9OSzQhARk+GUtLgVBUAeLYuXroA
Date: Thu, 4 Jun 2026 12:38:50 +0000
Message-ID: <0372a31369575b2c782dba7e6dd09f7e3863c9ab.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-28-seanjc@google.com>
In-Reply-To: <20260529222223.870923-28-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA1PR11MB5780:EE_
x-ms-office365-filtering-correlation-id: 21f3b1b1-37b4-43b9-aa68-08dec2363b22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: DeUKHVUQ9e9m/ap5wfGZzGw21bKGOAqE91fXkiqhrIr2TD8Mrik1hY+G31tdE/MfO8T9bcK8kEvxO+tPa+Cldku8uJET0khCC5Pe4h4ou53c+8FeJ/yiF7uaeGewPpwN81lAlDztnwa+mziAOeh2OmL1e69SrOaG5aOV5isJRrLzHe4eVRkJFQjizxEsa82jkIrSCbF4aDoMDGYTaB8Eyuoy5rboLAZr2C6LmzaS+BxLocjytbnH38Vs5DizIzsrUbb6Jui5TW8Vpb0SIEu/vkehdmJzPwigu4V8kA34RxR6EyrEYZY5qz4Xt3xa4ii1yyb/uyWEmXUSyGZ7BWfEt/a9Va0mo7dfXEuik2Zk1Kcq8UZtNyhnMQtxsKszfxXb0M57t/O6tPODTt49JPEIfdSn9P4AdcXkgx0gDRr/qy9t2GiDsoLINUwj6kvzki7jPmWp/ycVPFxW5Izheks0T07QFwzBKxWbVWRWelbEWOKeebFVZYyoj+v2COKZ/oaU4T4eKrqBm3u6Zuu52ye6uzl7+6oUFjLsDjI4SibFMN9mi2CWWh+oQW/fLhNDp5iitf4kQySmoAybsrcPmumFu6QWFRcNOPnfk32qeSpEnMlPv+CW68wZ7viGepvHa3gCILfXHeTNEit+pfl0FyrlU0YyhJObdw6zkygkCKLvEHmFzkPxvvy9erg7x8ea6UtyAmWJTl/Ffmk1j5bSSwpHgdFZux8//URbyyB7oytzQzahg0vtNOSXeWt8VDofN1q7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlVtOEoxeWY5MmV5SERyNFFsY2R6ZU5PZk5iczc2ZWl4dUdhb0g5aE5rcjZ5?=
 =?utf-8?B?Q2VnSFBqZWdGVEhwMmJJZVpoN2I3WC95YVpFTFdra3grc0ZUbWVkTUUwSlFL?=
 =?utf-8?B?dGdwSEhnZ1daVFJKb1dickhnTkNia1hoci9yKy9wQVh0RmhYRW15ZlBZNm85?=
 =?utf-8?B?ak1UQlpvdmZnNEx3Z3BEZFlJcWwrV2RobmdVZmVYanR4STUycU0xTW9sQWdz?=
 =?utf-8?B?azFpUVlUTkZ2MUZPc2NFUmhxZ0RFZjlxMzVQL0luVmNmNVh3SnJzR25wckZW?=
 =?utf-8?B?dlJ2dmdXWFFBK0VNODhrMUV2VEtGNDJSN1Z2SzFId1o3c2hOL1ZhaytZNnpn?=
 =?utf-8?B?dy9LcHZGelRqNHJNbmZ3RzRtSEwwbzRFVldDTnpMcGpnOHBCdS8zYWk3dFg2?=
 =?utf-8?B?VGV6QVJGZEZhRXhwTkxabGloQ0J6ZlRKUDMyWWxra3lMZTlHdDhwb3crK0pZ?=
 =?utf-8?B?TE1qREtta3FhVHR2N0JIT3FDQ3N4OUtGRzJVWE5HK0Y3ei8vMlo1dm1nZitG?=
 =?utf-8?B?NXVrQ3o3SnNaVEVXdS82YnpMWW1saldEa3dkUHJ2UjNRMW1jcXJWeXF5djJW?=
 =?utf-8?B?TnBpVUZkc29TWEdHeUd3OXF3OGVHeVcxeDQxSXVTWTRSa21sOUU0ZENZSlI1?=
 =?utf-8?B?b1hFNzZKQmV4SHRtRnV0SEpXUE5UanZpSWl2L1k5SmQ5dlgrQ0tFK25iUkZP?=
 =?utf-8?B?K1I0b3IwUVFsRUlmQnIvMnBDZnpUdDY2eTZlQy9VVkNQUFEvQndWQ0VCdHg4?=
 =?utf-8?B?b293eDJXRytkL2FPdGRlSER2K2g0dzdaazBheFRHK1cwdWpKWUtTbkhrakRn?=
 =?utf-8?B?NFFoM0tQQmM5WDhhY01Id3pKdVJnQkl5ZVBtT1NJbXZncEJ6elpxVW5wRWNu?=
 =?utf-8?B?OFcvdU1EejhlQnh6VElPZUlUangxRWJJRW9VdzZaZmVSVi9ZV3R2akhxL25j?=
 =?utf-8?B?Sy9haXVZZUlzc3ZGYW1PbE1oNnZVUTR0L2N4VmFqRkdRS3duZXh4VEpJbWhk?=
 =?utf-8?B?QlYzTE9CV3ptdWRvL3FqWlQzQXZYUkM3RFMxUFQ3YTV2QW82Uk9IQU5ZNGkx?=
 =?utf-8?B?djlhalpZUEVqUDQzTWE5YXF0T1EzOXpRK0c5WFZLOVJnL1B3T3J2VjRIdWh4?=
 =?utf-8?B?Zk1LeXpEc0NpeFl5MFJpWnhNM2ZNSGZBbTBBbDVqMlljZVh4ZFZvdjA3Q3ND?=
 =?utf-8?B?RjNjRERsY3hqVGJkZ2c4a09oRmFSVDU2UjZBNFJYQVhQU1hScWVHZHd2QlZF?=
 =?utf-8?B?RTdxNmlCSnozQjRZRkV4Nm9VN04rYUNDOXdrRWRFd1NSVFFhdlROVmVQZnFI?=
 =?utf-8?B?ckR6aTdyRWcwNEZ2YTVqaGhLOUtWMURVUUNudnNSd0hEODVDTHJLeGkrSlQv?=
 =?utf-8?B?SWRFc1h6bHhrT05jeFdUQmlXUE1VOFlycTdBRDUySFZIRkZQL1ZCK3FBdDRV?=
 =?utf-8?B?WTIyNmZCcHc5Z3MvM3BGVmtVWVVDRWRwSjF6b1pieFJBY25NY2ViQVM5dVFE?=
 =?utf-8?B?VWJ5THIxb0ZKZWdMeVJyQ3VPdGxyenRKSS96ckNQR2pqYk4wNTEwQjc0dXBs?=
 =?utf-8?B?SkRYTUFINVdmQWVtSTY2V3ZRTWVhMDZLcGtKcTYzWFlybVkrbFlXUG5OSGND?=
 =?utf-8?B?YUY4VVFKL2hCdVRzUjNUZE83bENyb01qNU4wSC9ERWVUNU9qMjFMellCSlk0?=
 =?utf-8?B?eFdKRmZBQm5uTzc2VU1YYU9RWkhVeEUvQjF0SjlFZk1xaHZjdjBxYnU1aGY1?=
 =?utf-8?B?eTU4cmQ4cFJnUzF2bmdKaVlKMllsU1hpeVFkOEM1dHNnaUlGRUgrYmp6K3J4?=
 =?utf-8?B?cUoyaHdFRHpnWkR0ZnBDam82NFVGU1hWNk5KREsxRHd4NWZ2b0lSN2VqWElC?=
 =?utf-8?B?Q29GL1FhRHQxcGlzUXBnTHZWSEVWUTJ0Nlg5Wm84SUpNeVoxcnJ4SUdtb0dN?=
 =?utf-8?B?VU1yRG43TC92MjFPQklpUFlnajh2emZiQkFrWjFBMmprajR2alZnZk1uY2Na?=
 =?utf-8?B?allKWENZa2pMd0VCRjZBRWpicjhCNUVNTzdleG53Y0Z3b0dpK3lhRDZRekVt?=
 =?utf-8?B?eU9SQldzTlRBVWFhbUdITGtBS0t1aUtMdEM0Vm5LWitCTnpZRzRXeTU4OVhr?=
 =?utf-8?B?cVFKS05qQjA5cjRTdHdCUWlVamxJZUFDQXZ6Q28xNDBhSmN2VnBWN3hvaTZ5?=
 =?utf-8?B?eTV1Ukl0RW1CUWJCNWhCUzJjR2o0MVYvSzhBbzA2K2F5VEh4Y0JsbXlsZ2I4?=
 =?utf-8?B?R2JxOVdobXEyaVg2ajhnTWlvM1FsRFpwUFdKazdTUEJJNEs2UU16bkk0ak5L?=
 =?utf-8?B?c3lENzk2clVpekNZMFBBU3ZFM1dKZ2FXbzdZUzFoTjNFQVc0VCtWZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76126BFA1C0DA346A97679EA6347528A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Gd+ogYE1rDhueWJ5IZHUyum54S4iH5Go8zOnPpBotNnnem5BlameXKzIB+GDHvu8rSE7G2PkJBnC2efTvOLm2WJt6/Sgvk2qOcisMOELjC+TwHlb5EVXEiJFRKYRivsUpncOzPxcG/Yc1KwoMiRGWEFOcbN+5QtW7AVaYdqxUd5ncsWYvRONoFA+adhVvQyNdM+itAFWN1BgSsw6zM8kABFZqeTUjUlKuqKLrzYYrjssnxGHO7aLscbLd/0NuBSwwMqoTasCoWYRf6T2CqS8mLMlgRJsmioC+8XfEez4uLqjzWLpFJCWTWp5DbKfsC0WgycRZpD/5vS+1Zm49PvXAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f3b1b1-37b4-43b9-aa68-08dec2363b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 12:38:50.8899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RhiIL51fmqhLoYVpQGArj0l29qPvGmq9tHMbaatqZGxHDvCIZkEVpYYzuorZm+g/GRSrlYv11i3bK8QvbeA+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5780
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBSZWxvY2F0ZSBkZWNsYXJhdGlvbnMgb2YgQ29udHJvbC9EZWJ1ZyBSZWdpc3Rlciwg
RUZMQUdTIGFuZCBSSVAgaGVscGVycw0KPiBmcm9tIHg4NidzIGt2bV9ob3N0LmggdG8gcmVncy5o
LCB0byBjb250aW51ZSB0cmltbWluZyBkb3duIGt2bV9ob3N0LmguDQo+IA0KPiBObyBmdW5jdGlv
bmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3Bo
ZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWku
aHVhbmdAaW50ZWwuY29tPg0KDQoNCj4gIHZvaWQgX19rdm1fc2V0X3JmbGFncyhzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsIHVuc2lnbmVkIGxvbmcgcmZsYWdzKTsNCj4gK3ZvaWQga3ZtX3NldF9yZmxh
Z3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1bnNpZ25lZCBsb25nIHJmbGFncyk7DQo+IA0KDQo6
LSkNCg0KU2VlbXMgYSBjYW5kaWRhdGUgb2YgbWFraW5nIGt2bV9zZXRfcmZsYWdzKCkgYSAnc3Rh
dGljIGlubGluZScgPw0K
