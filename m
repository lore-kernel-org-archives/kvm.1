Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83185502767;
	Fri,  9 Oct 2026 22:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583893; cv=fail; b=MApzBCaRD2IGmlXft28fv26+OP7fcNJrzEujInyYlXKKT/iLi0ng9fSx1tEi8X0DTusF5M+mqI+vn0l2gbuR5ztRXECcZElF5dKAQYUnUgeyLasLtseKQ6lDIVWuljLUDyovs2ZnpAyZTa6kxdBqQdQxePyqZzlkUoUMXM0RxWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583893; c=relaxed/simple;
	bh=dW9BNrFPf34PM2hYD2ZNSYfL+iwaomVZvbtzVlX0rTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RmGBcirXA08aga0vMquAAdA+GpaFPDzfnIIR0mbUflMrRQxnL/RmnMSeGYvos7bqC+MnwbRnsE2gug3cUpgaRjrqlZL+JnuGbfCp/j/3dz+diOIkEYtZo4WbUXloNkYJPGH7NPtJCtzgVaH+znN2fnBCq9+qlrMnBj8cdiRzypM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvXUNdEb; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvXUNdEb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791583880; x=1823119880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dW9BNrFPf34PM2hYD2ZNSYfL+iwaomVZvbtzVlX0rTQ=;
  b=CvXUNdEbHTNob7mNUbSUjx3/epUsEeM8ag+XHivw2o9uquUXvZaGidqD
   Y86VuHzIGTLGh7snqJ5Pxuu5bgeXLbvNMZS3PlPJF5Ce9ciiJJrBDn43A
   hnyzGoCnB/0046bdkIXumqr9JfBOSHqV6mizkYNk5q3jDGYkCI+mQFFVU
   8BCnDIIQLNHkJVxNsfTfZUAeJhciJNA1cN17jBOH/Osq67kNkKsxnPe7i
   QRdcWCqmy6l+azhxPFQRwLSp7y3xg9C5Lie3KD+Ic/JdxK7+jdrYMb4Kg
   BNgNNuZkRV7NfdnocGD4QqPFsNjqg4GV15XZyzdIMQ+qQsGLIfeKfniw3
   g==;
X-CSE-ConnectionGUID: OG5jt/M8TfWLJG9hiLLq2w==
X-CSE-MsgGUID: vegIrjLKQ0mQPDiX4s1zPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="288534"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="288534"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:11:18 -0700
X-CSE-ConnectionGUID: /eLbcu3cTCe8Y65BBeMl8A==
X-CSE-MsgGUID: OcGvxDKqQKOq5nhyiwZCBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2213749"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:11:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 15:11:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 15:11:18 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 15:11:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6s3mUdXWDBX2VOruy0ejiCqj8yUh2BhgBs8lizeMUYMjGtw4uNV6sPwbciSBrvyAdvzbssdA78MboltNYUIu5b4tZGdiyIGfkT4r+SepCTcVklY1vDteLYz4Omy8nzP07FxC9wa7eitSfxBhAA+0js2mwrxV+8BJG69nJCrl9hRfBmxd3oU3/0UEDs03bFPsnbCcZmFcRxmY2U6LU8/EOoujstE7YVn38IbaIvQBg5qu+NkCb7AyKf3DrGWcwUBjmEI88Z7Zka4a7Jh/5ozRWlmS7JQCHTURcFOm1Vk/qAqDB6Nxs0un0opomv+NOo2/h9ft3tlQEEOBH7hNT2Q5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dW9BNrFPf34PM2hYD2ZNSYfL+iwaomVZvbtzVlX0rTQ=;
 b=D+yK1R+NO1qeth+Z/du8OxofPFv6rIIW2O5R22ptUzYIG4bprxapJGAzV03PPngU+dF9z0zPYnQHfFDF46g6k1g+3I+C2eYytgco830oz9TxoJBwrhwPtT20Ad/KLT48sGxXaaKnwxk8ZqOTEFKMnpt64OHGQo7uoOG9H5j3EPAtfnwKw076NJRYrzKpk3jiWs13sFRYHtak/jUiBRACv1T29hqQg1Q3HV7rIAbk3Kw+MmjgDTdgp/9bnfSBeRhqpItg3YN5fBzqokKOMXreMaSOo5FzY5DfgW9naquHq2Avm/2eLbZyEkpXR0jXG0GQpzGLhfC2VOpNWRVxrzomMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA3PR11MB629882.namprd11.prod.outlook.com (2603:10b6:806:58b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Fri, 9 Oct
 2026 22:11:15 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 22:11:15 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
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
Thread-Index: AQHdTylT2fDCHY1RikeRNXt5wj90e7byvXkAgAI3vYCAAOKpAA==
Date: Fri, 9 Oct 2026 22:11:15 +0000
Message-ID: <eb07ed0a79db904ced29539b3831a780dd94c799.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091035.15599-1-yan.y.zhao@intel.com>
	 <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
	 <asioX9gKIZBe0NF6@yzhao56-desk.sh.intel.com>
In-Reply-To: <asioX9gKIZBe0NF6@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA3PR11MB629882:EE_
x-ms-office365-filtering-correlation-id: b5cae0b6-1051-459f-cd0e-08df26523c6c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|366016|11063799006|5023799004|10067099003|4143699003|56012099006|38070700021|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: IQalwY0Dq2K6kGFwRZ2ymYDBATnq4MdnLW4U/nYA1rdKNAaaN+qw8CYzoYmFWoxl3BD4391mCn0t70UZVTNgOxxCMGgB/+EWE7qAz/hpXdf1+12SmFAZToU/f5nPbj6LWUOAGrdLtqRAGmP7zSelFsFO4OPbbrdI6L0buHOZDKpNzojdSTWRPWkdgL3i9McIm3hdm1nYDG82iE8CLW0NjCCGfxTaiqrKoFVrwqK0asOS15U3XC3QGiWTMNijeqRg5XcaP5gvG01Kdg197CuXS1yI0N5tg4bUclNGzAd/7kFhOWpRvSS2WoJv3SNcwjMZ9r4jWEBcxvN7wJd9GuWUor93csSCdRaO3Bax8dlC9IuTPV8YKayPnO7LmXBdqcFJJoKfeC3oP3afBigXCwoUHrux4ZV2qWi1/oI55HpXaDo2ZMLQYn2Br+3TZIjex8+3htGx7ZROHSMIUwjBQBJR1sdzy6ksuJVPIDLmn9zCyTiyKNHMIKjIaDidrovQTEiIEkMLAG15t1SkExKflVGtkeorNbw326n2XoLYAO2+gziW8i2/x7uc78fcEdOvwHDN4sDFXZbDx0vPsdKr6sVq9YNmKESam5ta74GaIRANEi7sPlBy3Sp5mU96b+km0wkxh3TuerIQ/Qy12HuvzanJS6BR4MX+hNGfby4tmyQxsBC5pRIzn7nl/i8qiO8iOFN7gOODpeJ36Qf4T1kZ4jpPvqU9WmUZ9NU7m4iJ9acaEVs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(366016)(11063799006)(5023799004)(10067099003)(4143699003)(56012099006)(38070700021)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXBXSExrc1Q2cll0b2NCeEN6WTZuYkQxaFJobktCY1g4bkRleU95WnNpRlBa?=
 =?utf-8?B?VGdCNWhpK1lKRW5Sd2VwK3hhTnRsaXRab1d6R29jRzV2SktEL1ZueUNzd0Zj?=
 =?utf-8?B?dmxXaURHZUFkSmFEKzRoVnJmU2FQa3BBNjZXbVdaTVRObHRsZ3dwZWxwUEQ4?=
 =?utf-8?B?QTk4QnZWamY4ZGc4VDNpak9JQmNPMlpzY1RYWjFnNUpYTTZDb1JudFRDSUsz?=
 =?utf-8?B?VTRHa00za0l3Ri9ua2hZelFrZmFFWFMwMzdtQzlJaDdoWEFpb3BNWWZpNWgx?=
 =?utf-8?B?Z2JIcVlMalVDRTdFVEllV1BuU1lLVVFGMUhnaFBhSVFDYWl0ano1Vjg1SEhX?=
 =?utf-8?B?a0hnem5nWlJ3SUIxRTduaUl0WGN3WFBGOG5SK3dURHRvWktna1cvQ2xzREpI?=
 =?utf-8?B?Q2R5c3JkK1VKdzFYNWEyTGdxL3RGeWtmTWRiY1lzNkc1UFF0RXZHSDNuK1JI?=
 =?utf-8?B?RTdXeDZkYnMybW55UjlYNU5mYnZrZTU0Qy8vNlo2OWxBTUJ0aDhoRzdLcXN3?=
 =?utf-8?B?V0lIL0oydkdLMXFWNTlKYUJhZXQ4cTZ1ZkpSMUpsYURlb0M4b3RNRUdBQy9h?=
 =?utf-8?B?UkxtWFJScHpKWGtvcnJyU3g2bmNJQ0lyMFRVcExBOWRXOXlpaFV1UzdoQWhL?=
 =?utf-8?B?ZnVWNW4xT0ZaY041RDJLc2QyQjc5eU5uV0F4THk3MDBKbUh1R3pQVWxHSFNi?=
 =?utf-8?B?enFTTGtxblVlaEgvS0J5aEVCMnhqOEx4K0p4VGF0V2VWSWtJVWVPSFFMWmNU?=
 =?utf-8?B?WVBtS1pJTTJ0a2puODQ4WG94OGxISTZ2ZVA2SlhwaHRIbi8wOEk3aUc3WUpG?=
 =?utf-8?B?cVovc2NBMVg2L01pT0g3NUpJTkpLam5LbFJCTVlBa0R0WFJJL0RxelI1MXh0?=
 =?utf-8?B?cGlCUjM0NnQwYXBJZmVWakdEUjMyKzB1TU5aU2RrWE9QVzExZHZYSm1HSlZU?=
 =?utf-8?B?R0xmdDF0aU8wZCtTOGZRYmNDbllyM2ZORmwyQzk5UkNsR2NOUEF4UXAzMzR4?=
 =?utf-8?B?ZzNva3k4cCtLdWh5U0JyVFpJa2MxZVRCS05YVDh4dXJCcW1Da1daMUNjLzFK?=
 =?utf-8?B?REtsVWhwUTdJZ2VzMnFFdWI3TWVaR3Y4YXRhOTg2ejRLMjlYYTlpbTJpTGdV?=
 =?utf-8?B?QXk0Y0lhWW85dThXYnp5VDhiQ0cweDV2YWpBRXZJMXhFdTZyK3NtY2JSRjdK?=
 =?utf-8?B?Zm4rU3NqdTZvaUp6T3llZlFtR0VWd3pHZzdPc2lYcG5RQXVCeVlQOXFveWIr?=
 =?utf-8?B?MGhSMHF0aXdYQUdVTlp0Tmx2RksyTTVOUGYxN2daQXhveDFVNEFSeVY4OU5x?=
 =?utf-8?B?SUVaY1JxbWVZYzdPdFJrMVhkeFdrNDIzNXpWamdiazNRTHJMQkZZcjhadFRu?=
 =?utf-8?B?eW83YmpyL2Faenc4RW5JMjZHU09mckFJaS9BNXJBM0RZdllLRnJYSU5pTGVG?=
 =?utf-8?B?WVRHczZKV0xHd1ZNTG9Nekg0Ly9EbkxwUEFJU2dVeC9EZVFqb09wS3MyNHVw?=
 =?utf-8?B?QTlSamRqWEdIWGZGTTdTWkFRcytyWFBJN0dxb0RmSGdGWC9zMTJsd2k4bnd6?=
 =?utf-8?B?Wm8yOGZBbzlLUDIwelpiYnlkZUc2ZTBSaW1jUG9UU3Ywd3dKazNodm9QWGZL?=
 =?utf-8?B?aWlqR3JYdEZlZkV4K1NZRHRIb0VXK2JKeGZPYnBRamc0dVg4aG1FL0ZRbUY5?=
 =?utf-8?B?bTQ3Q2VpMlo1bDViK291ZG1GWVAwQk9nR1V4K2NxVFBPVVJJK3dKc0h4ZWd0?=
 =?utf-8?B?MWlMSnRSVDV6RWUwakp1ZkEwb2o2SWgzSzA5UjFIbXI4dGw4ZUVxSTRjalJt?=
 =?utf-8?B?NGd1eWVpNU1aUE8rYkpVbS9vTUY3L0l3VnBQcWxsRytWclJSdmk1TEIzeWo1?=
 =?utf-8?B?QjNxZ0VhdHgwbTBpWWRiMzUwYk9EcTJyNi9SZlFkQSs0bFB2dEc1K2xVZkln?=
 =?utf-8?B?YVRHOWtpNzVRTUdteUxlTjJZTzhMaEE4T1NxQWQrVFFlMmFLQ21HYytTT1RY?=
 =?utf-8?B?RzBlOXlvMHJ4ellPVmZ2ZHhiVUhhMnM4MU1kTjErRWd2SFFQQkxRZWJHSmM1?=
 =?utf-8?B?WVRlMkFjdy91UUxPM0VpQUZsZFJ1UVNxSmE0eDFCakVzYWxlRFNEWTlrc29n?=
 =?utf-8?B?a0trUG9YazZpZXowcThvNEdILzZuRDJLa2pQYUdaOG9LVW1LNG10d1MyWUxP?=
 =?utf-8?B?bVdXWjlmTGVjK3J4T0tIRnN5MlRmMG5Jc1k1d1hLdXN4Y3pqSEhENDFmNVBP?=
 =?utf-8?B?UWZQb0RlcTVXK1orc3ZzbE0weHhBa2FuUlhNR2ptbWhQTUxuSElSUC84TktU?=
 =?utf-8?B?ZmpKOXNwb0s2OVV2cC9HV0dRLytvYTFMZmxvMXpvQk12MlJobnNmMnRzWEhx?=
 =?utf-8?Q?pFrIA8NNetZcg8Vo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE5DCA28F0B22E46A37D6553B3E02C65@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n82hHWK/usomoQkN+YKfCNliXsSJ58bkxwJljY4Xo8lWcutGjfesX8G5xJEetD+BKAC4wn72DIiY1LmF1WhlE+1O9WWbCRgFXd9LZP9MhuJq0//+mGFWPw1VIYmYUAsLoOo/RkDJeM8sWW78JPznnEw9Eco4oflOCAyNIhscp2WqUL4jyn655tJdMZENVLE+0NFfuVsWhzS0BXNRiu7FoJUzDtFruPvnDPZC9UBKsvqye0Rvt5+SAUOKszitgX5ru9Nbi6Yt278Y/SYtZa9/Xjamge67cPiGoTHiH3xewVR4H3rQLt34bRoBHff9r7IiG6nK/ZTDiG3TZE8AEeX2VA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cae0b6-1051-459f-cd0e-08df26523c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 22:11:15.2213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oSuVEczYjKNJwSKAMzzAnhznD6gXohuvuW/mpVqlESPubjkTuxaENUm0TlFbrBJ0HjrnrT5O4ofKj0M7YGZZ5IgJQ+bqKtxRRDj6j04KeTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB629882
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTEwLTA5IGF0IDE2OjM5ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
VGh1LCBPY3QgMDgsIDIwMjYgYXQgMDY6NDg6MDBBTSArMDgwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjEwICswODAwLCBZYW4gWmhhbyB3
cm90ZToNCj4gPiA+IEtWTSBuZWVkcyB0byBhbGxvY2F0ZSBlbm91Z2ggRFBBTVQgcGFnZSBwYWly
cyBpbiB0aGUgcGFtdF9jYWNoZSBmb3INCj4gPiA+IGNvbnN1bXB0aW9uIGJ5IGJvdGggcGFnZSB0
YWJsZSBwYWdlcyBhbmQgZ3Vlc3QgcGFnZXMuIFNpbmNlIHRoZSBEUEFNVCBwYWdlDQo+ID4gPiBw
YWlyIGZvciB0aGUgUy1FUFQgcm9vdCBwYWdlIGlzIGFscmVhZHkgYWxsb2NhdGVkIGR1cmluZyBU
RCBpbml0aWFsaXphdGlvbiwNCj4gPiA+IHRoZXJlIGlzIG5vIG5lZWQgdG8gYWxsb2NhdGUgdGhl
IERQQU1UIHBhZ2UgcGFpciBmb3IgdGhlIFMtRVBUIHJvb3QgcGFnZS4NCj4gPiA+IFRoZXJlZm9y
ZSwgcHJldmlvdXNseSB0aGUgRFBBTVQgcGFnZSBwYWlycyByZXF1aXJlZCBlcXVhbHMNCj4gPiA+
ICJtaW5fbnJfc3B0cyAtIDEgKyAxIi4NCj4gPiA+IA0KPiA+ID4gV2hlbiBzcGxpdHRpbmcgUy1F
UFQsIG1pbl9ucl9zcHRzIGRvZXMgbm90IGluY2x1ZGUgdGhlIHJvb3QgU1BULiBTbywgbGltaXQN
Cj4gPiA+IHRoZSAtMSBjYWxjdWxhdGlvbiB0byB3aGVuIG1pbl9ucl9zcHRzIGVxdWFscyByb290
X2xldmVsLCB0aG91Z2ggdGhpcyB3aWxsDQo+ID4gPiBjYXVzZSBvbmUgcGFpciBvdmVyLWFsbG9j
YXRpb24gaW4gdGhlIG5vcm1hbCBwYWdlIGZhdWx0IHBhdGggYmVjYXVzZQ0KPiA+ID4gUFQ2NF9S
T09UX01BWF9MRVZFTCBpcyBhbHdheXMgcGFzc2VkIGV2ZW4gd2hlbiBsYXVuY2hpbmcgYSA0LWxl
dmVsIFRELg0KPiA+ID4gDQo+ID4gPiBBZGRpdGlvbmFsbHksIEtWTSBtYXkgbmVlZCB0byByZXRy
eSB0ZGhfbWVtX3BhZ2VfZGVtb3RlKCkgYSBzZWNvbmQgdGltZSwNCj4gPiA+IGNhdXNpbmcgdGhl
IERQQU1UIHBhZ2UgcGFpciBmb3IgdGhlIGd1ZXN0IHByaXZhdGUgcGFnZXMgdG8gYmUgZHJhd24g
ZnJvbQ0KPiA+ID4gdGhlIHBhbXRfY2FjaGUgdHdpY2UgaW4gdGhlIHdvcnN0IGNhc2UuIFRoZXJl
Zm9yZSwgYWRkIGFuIGV4dHJhICsxIHRvIGNvdmVyDQo+ID4gPiB0aGlzIHdvcnN0LWNhc2Ugc2Nl
bmFyaW8uDQo+ID4gPiANCj4gPiA+IFRoZSBzbGlnaHQgb3Zlci1hbGxvY2F0aW9uIGlzIGFjY2Vw
dGFibGUgc2luY2UgS1ZNIGFscmVhZHkgcHJlLWFsbG9jYXRlcw0KPiA+ID4gbW9yZSBwYWdlcyB0
aGFuIG5lZWRlZCAoZS5nLiwgd2hlbiBtYXBwaW5nIGh1Z2UgcGFnZXMpIGluIGNhc2Ugb2YgdGhl
DQo+ID4gPiB3b3JzdC1jYXNlIHNjZW5hcmlvLg0KPiA+IA0KPiA+IFRoaXMgaXMgYXNzdW1lcyB3
YXkgdG9vIG11Y2ggYWJvdXQgdGhlIGNhbGxlcnMgYW5kIHdheSB0b28gY29udm9sdXRlZC4gVGhl
DQo+ID4gZXhpc3RpbmcgY29kZSBhbHJlYWR5IGRpZCBidXQsIG5vdyB0aGlzIGlzIGp1c3QgdG9v
IGZhci4gV2UgbmVlZCBhbm90aGVyDQo+ID4gc29sdXRpb24uDQo+ID4gDQo+ID4gUXVlc3Rpb25z
IGJlbG93IG9uIHdoYXQgdGhhdCBtaWdodCBiZS4NCj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0K
PiANCj4gDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFlhbiBaaGFvIDx5YW4ueS56aGFv
QGludGVsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGFyY2gveDg2L2t2bS92bXgvdGR4LmMgfCAy
NiArKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYva3ZtL3ZteC90ZHguYyBiL2FyY2gveDg2L2t2bS92bXgvdGR4LmMNCj4gPiA+IGlu
ZGV4IDMxODZjNDgwOGNhZS4uMzk3YTMwOGI4MzRjIDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJjaC94
ODYva3ZtL3ZteC90ZHguYw0KPiA+ID4gKysrIGIvYXJjaC94ODYva3ZtL3ZteC90ZHguYw0KPiA+
ID4gQEAgLTE2MzAsMTYgKzE2MzAsMzQgQEAgdm9pZCB0ZHhfbG9hZF9tbXVfcGdkKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwgaHBhX3Qgcm9vdF9ocGEsIGludCBwZ2RfbGV2ZWwpDQo+ID4gPiAgDQo+
ID4gPiAgc3RhdGljIGludCB0ZHhfdG9wdXBfZXh0ZXJuYWxfcGFtdF9jYWNoZShzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsIGludCBtaW5fbnJfc3B0cykNCj4gPiA+ICB7DQo+ID4gPiArCWludCBkcGFt
dF9wYWlyczsNCj4gPiA+ICsNCj4gPiA+ICAJaWYgKFdBUk5fT05fT05DRSghdmNwdSkpDQo+ID4g
PiAgCQlyZXR1cm4gLUVJTzsNCj4gPiA+ICANCj4gPiA+ICsJLyogRXhjbHVkZSB0aGUgcm9vdCBT
UFQsIGFzIGl0cyBEUEFNVCBwYWdlIHBhaXIgaXMgYWxyZWFkeSBpbnN0YWxsZWQgKi8NCj4gPiA+
ICsJaWYgKG1pbl9ucl9zcHRzID09IHZjcHUtPmt2bS0+YXJjaC5taXJyb3Jfcm9vdF9sZXZlbCkN
Cj4gPiA+ICsJCW1pbl9ucl9zcHRzIC09IDE7DQo+ID4gDQo+ID4gT3ZlciBhbGxvY2F0aW5nIGEg
Yml0IGlzIG5vdCB0aGUgZW5kIG9mIHRoZSB3b3JsZC4uLg0KPiBCZWZvcmUgdGhpcyBwYXRjaCwg
ZHBhbXRfcGFpcnMgPSBtaW5fbnJfc3B0cyAtIDEgKyAxLg0KPiBIb3dldmVyLCB3aGVuIG1pbl9u
cl9zcHRzIGlzIDEsIHRoZSBjb3JyZWN0IGRwYW10X3BhaXJzIHNob3VsZCBiZSAyIGluc3RlYWQg
b2YgMQ0KPiAoaW4gdGhlIGNhc2Ugd2hlbiBERU1PVEUgZG9lcyBub3QgZmFpbCkuDQo+IGkuZS4s
IHdpdGhvdXQgdGhpcyBjaGFuZ2UsIHdlIHdvdWxkIGFsbG9jYXRlIDEgbGVzcyBwYWdlLCB3aGlj
aCBpcyBhIGJ1Zy4NCg0KSSB3YXNuJ3Qgc3VnZ2VzdGluZyB0byBub3QgY2hhbmdlIHRoZSBmdW5j
dGlvbi4gSSB3YXMgc3VnZ2VzdGluZyB0byBjb25zaWRlciBhDQpzb2x1dGlvbiB0aGF0IGFzc3Vt
ZXMgbGVzcyBhYm91dCB0aGUgY2FsbGVycywgYXQgdGhlIGNvc3Qgb2Ygb3ZlciBhbGxvY2F0aW5n
Lg0KDQo+IA0KPiA+ID4gKw0KPiA+ID4gKwkvKg0KPiA+ID4gKwkgKiBFYWNoIFMtRVBUIHBhZ2Ug
dGFibGUgcGFnZSArIDRLQiBndWVzdCBwcml2YXRlIHBhZ2UgbmVlZHMgYSBwYWlyIG9mDQo+ID4g
PiArCSAqIERQQU1UIHBhZ2VzLg0KPiA+ID4gKwkgKi8NCj4gPiA+ICsJZHBhbXRfcGFpcnMgPSBt
aW5fbnJfc3B0cyArIDE7DQo+ID4gPiArDQo+ID4gPiAgCS8qDQo+ID4gPiAtCSAqIE1pbnVzIG9u
ZSBwYWdlIHRvIGV4Y2x1ZGUgdGhlIHJvb3QgU1BULCBidXQgcGx1cyBvbmUgcGFnZSBmb3IgYQ0K
PiA+ID4gLQkgKiBwb3NzaWJsZSA0S0IgcHJpdmF0ZSBtYXBwaW5nLg0KPiA+ID4gKwkgKiBBZnRl
ciBlYWNoIHRvcHVwLCBLVk0gbWF5IGludm9rZSBERU1PVEUgYXQgbW9zdCB0d2ljZS4NCj4gPiA+
IA0KPiA+IA0KPiA+IFdoeSB0d2ljZT8gWW91IG1lYW4gdGhlIEJVU1kgcmV0cnkgYXR0ZW1wdCwg
cmlnaHQ/IElmIHlvdSBkbywgY291bGRuJ3Qgd2UgZml4DQo+ID4gdGhpcyBwcm9ibGVtIHdpdGhp
biB0ZGhfbWVtX3BhZ2VfZGVtb3RlKCk/DQo+IEluIHRkaF9tZW1fcGFnZV9kZW1vdGUoKSwgZHBh
bXRfcGFnZXMgYXJlIGFsbG9jYXRlZCBmcm9tIHBhbXRfY2FjaGUgYmVmb3JlDQo+IGludm9raW5n
IHRoZSBTRUFNQ0FMTCwgYW5kIGZyZWVkIGFmdGVyIHRoZSBTRUFNQ0FMTCBmYWlscy4NCj4gU28s
IGlmIEtWTSByZXRyaWVzIG9uIHRoZSBCVVNZIGVycm9yIGZvciBhdCBtb3N0IHR3aWNlLCBhbiBl
eHRyYSBwYWlyIG9mDQo+IGRwYW10X3BhZ2VzIGFyZSBhbGxvY2F0ZWQgZnJvbSB0aGUgcGFtdF9j
YWNoZS4NCj4gDQo+IElmIHdlIHdhbnQgdG8gZml4IHRoaXMgcHJvYmxlbSB3aXRoaW4gdGRoX21l
bV9wYWdlX2RlbW90ZSgpLCBvbmUgcG9zc2libGUNCj4gc29sdXRpb24gaXMgdG8gcmUtaW5zZXJ0
IHRoZSBkcGFtdF9wYWdlcyBiYWNrIHRvIHRoZSBwYW10X2NhY2hlIGxpc3QuDQoNClllYSB0aGF0
IGlzIHdoYXQgSSB3YXMgc3VnZ2VzdGluZy4NCg0KPiANCj4gZS5nLiwgYWRkIHRoZSBmb2xsb3dp
bmcgZGlmZiB0byBwYXRjaCAyLg0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14
L3RkeC90ZHguYyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiBpbmRleCA5NjQ3Mzlj
NTY4N2IuLmU5NDU4ODVkNTg5OCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvdmlydC92bXgvdGR4
L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiBAQCAtODcsNiAr
ODcsNyBAQCBzdGF0aWMgREVGSU5FX1JBV19TUElOTE9DSyhzeXNpbml0X2xvY2spOw0KPiANCj4g
IHN0YXRpYyBpbnQgYWxsb2NfcGFtdF9hcnJheShzdHJ1Y3QgcGFnZSAqKnBhbXRfcGFnZXMsIHN0
cnVjdCB0ZHhfcGFtdF9jYWNoZSAqY2FjaGUpOw0KPiAgc3RhdGljIHZvaWQgZnJlZV9wYW10X2Fy
cmF5KHN0cnVjdCBwYWdlICoqcGFtdF9wYWdlcyk7DQo+ICtzdGF0aWMgdm9pZCByZWluc2VydF9w
YW10X2FycmF5KHN0cnVjdCB0ZHhfcGFtdF9jYWNoZSAqY2FjaGUsIHN0cnVjdCBwYWdlICoqcGFt
dF9wYWdlcyk7DQo+IA0KPiAgLyoNCj4gICAqIERvIHRoZSBtb2R1bGUgZ2xvYmFsIGluaXRpYWxp
emF0aW9uIG9uY2UgYW5kIHJldHVybiBpdHMgcmVzdWx0Lg0KPiBAQCAtMTkwNCw3ICsxOTA1LDcg
QEAgdTY0IHRkaF9tZW1fcGFnZV9kZW1vdGUoc3RydWN0IHRkeF90ZCAqdGQsIHU2NCBncGEsIGVu
dW0gcGdfbGV2ZWwgbGV2ZWwsIGt2bV9wZm4NCj4gDQo+ICBvdXRfZnJlZToNCj4gICAgICAgICBz
cGluX3VubG9jaygmZHBhbXRfbG9jayk7DQo+IC0gICAgICAgZnJlZV9wYW10X2FycmF5KGRwYW10
X3BhZ2VzKTsNCj4gKyAgICAgICByZWluc2VydF9wYW10X2FycmF5KHBhbXRfY2FjaGUsIGRwYW10
X3BhZ2VzKTsNCj4gICAgICAgICByZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTF9G
T1JfS1ZNKHRkaF9tZW1fcGFnZV9kZW1vdGUpOw0KPiBAQCAtMjE0Niw2ICsyMTQ3LDI0IEBAIHN0
YXRpYyB2b2lkIGZyZWVfcGFtdF9hcnJheShzdHJ1Y3QgcGFnZSAqKnBhbXRfcGFnZXMpDQo+ICAg
ICAgICAgfQ0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lkIHJlaW5zZXJ0X3BhbXRfYXJyYXkoc3Ry
dWN0IHRkeF9wYW10X2NhY2hlICpjYWNoZSwgc3RydWN0IHBhZ2UgKipwYW10X3BhZ2VzKQ0KPiAr
ew0KPiArICAgICAgIGludCBpOw0KPiArDQo+ICsgICAgICAgaWYgKCFjYWNoZSkNCj4gKyAgICAg
ICAgICAgICAgIHJldHVybjsNCj4gKw0KPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBURFhfRFBB
TVRfRU5UUllfUEFHRV9DTlQ7IGkrKykgew0KPiArICAgICAgICAgICAgICAgLyoNCj4gKyAgICAg
ICAgICAgICAgICAqIFJlc2V0IHBhZ2VzIHVuY29uZGl0aW9uYWxseSB0byBjb3ZlciBjYXNlcw0K
PiArICAgICAgICAgICAgICAgICogd2hlcmUgdGhleSB3ZXJlIHBhc3NlZCB0byB0aGUgVERYIG1v
ZHVsZS4NCj4gKyAgICAgICAgICAgICAgICAqLw0KPiArICAgICAgICAgICAgICAgdGR4X3F1aXJr
X3Jlc2V0X3BhZGRyKHBhZ2VfdG9fcGh5cyhwYW10X3BhZ2VzW2ldKSwgUEFHRV9TSVpFKTsNCj4g
Kw0KPiArICAgICAgICAgICAgICAgbGlzdF9hZGQoJnBhbXRfcGFnZXNbaV0tPmxydSwgJmNhY2hl
LT5wYWdlX2xpc3QpOw0KPiArICAgICAgICAgICAgICAgY2FjaGUtPmNudCsrOw0KPiArICAgICAg
IH0NCj4gK30NCj4gIC8qIEhlbHBlciBmb3IgYnVpbGRpbmcgRFBBTVQgc2VhbWNhbGwoKSBhcmd1
bWVudHMuICovDQo+ICBzdGF0aWMgdTY0IHBhbXRfMm1iX2FyZyhrdm1fcGZuX3QgcGZuKQ0KPiAg
ew0KPiANCj4gUmVpbnNlcnRpb24gc2hvdWxkIGJlIGxvY2tsZXNzbHkgc2FmZSBzaW5jZSB0aGUg
cGFtdF9jYWNoZSBpcyBlaXRoZXIgcGVyLXZDUFUgb3INCj4gcHJvdGVjdGVkIGJ5IHRoZSBjYWxs
ZXIgd2hlbiBpdCdzIHBlci1WTS4NCj4gDQo+ID4gPiAgVGhlIGZpcnN0DQo+ID4gPiArCSAqIERF
TU9URSBpbnZvY2F0aW9uIGRyYXdzIHR3byBwYWlycyBvZiBwYWdlcyBmcm9tIHRoZSBjYWNoZTog
b25lIGZvcg0KPiA+ID4gKwkgKiB0aGUgUy1FUFQgcGFnZSB0YWJsZSBwYWdlIGFuZCBvbmUgZm9y
IHRoZSBndWVzdCBwcml2YXRlIG1lbW9yeS4NCj4gPiA+ICsJICogU2luY2UgdGhlc2UgcGFnZXMg
YXJlIG5vdCByZXR1cm5lZCB0byB0aGUgY2FjaGUsIHRoZSBzZWNvbmQgREVNT1RFDQo+ID4gPiAr
CSAqIGludm9jYXRpb24gc3RpbGwgbmVlZHMgdG8gY29uc3VtZSBvbmUgYWRkaXRpb25hbCBwYWly
IGZvciB0aGUgZ3Vlc3QNCj4gPiA+ICsJICogcHJpdmF0ZSBtZW1vcnkgKHRoZSBwYWlyIGZvciB0
aGUgUy1FUFQgcGFnZSB0YWJsZSBwYWdlIGlzIHJldXNlZCBmb3INCj4gPiA+ICsJICogdGhlIDJu
ZCBpbnZvY2F0aW9uKS4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiBBbm90aGVy
IGlkZWEsIGNoYW5nZSB0aGUgb3AgdG8gYmU6DQo+ID4gaW50IHRvcHVwX2V4dGVybmFsX2NhY2hl
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgYm9vbCByb290LCBib29sIHByaXZhdGVfcGFnZSwNCj4g
PiBpbnQgbWluX25yX3NwdHMpOw0KPiA+IA0KPiA+IE5vcm1hbCB0b3B1cCBjYW4gc2V0Og0KPiA+
IHJvb3Q9dHJ1ZQ0KPiA+IHByaXZhdGVfcGFnZT10cnVlDQo+ID4gbWluX25yX3NwdHMgPSBQVDY0
X1JPT1RfTUFYX0xFVkVMIC0gMQ0KPiA+IA0KPiA+IFRoZW4gd2UgY2FuIGNhbGN1bGF0ZSBleGFj
dGx5IHdoYXQgd2UgbmVlZC4gQW5kIGV2ZW4gYmV0dGVyLCB0aGUgZXhpc3RpbmcgY29kZQ0KPiA+
IHdvbid0IG5lZSBhIGNvbW1lbnQgdG8gZXhwbGFpbiB0aGUgd2VpcmRuZXNzLg0KPiBUaGUgZXhp
c3RpbmcgY29kZSBsb29rcyBsaWtlIHRoaXM6DQo+IHN0YXRpYyBpbnQgdGR4X3RvcHVwX2V4dGVy
bmFsX3BhbXRfY2FjaGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBpbnQgbWluX25yX3NwdHMpDQo+
IHsNCj4gICAgICAgICAvKg0KPiAgICAgICAgICAqIE1pbnVzIG9uZSBwYWdlIHRvIGV4Y2x1ZGUg
dGhlIHJvb3QgU1BULCBidXQgcGx1cyBvbmUgcGFnZSBmb3IgYQ0KPiAgICAgICAgICAqIHBvc3Np
YmxlIDRLQiBwcml2YXRlIG1hcHBpbmcuDQo+ICAgICAgICAgICovDQo+ICAgICAgICAgbWluX25y
X3NwdHMgKz0gLTEgKyAxOw0KPiANCj4gICAgICAgICByZXR1cm4gdGR4X3RvcHVwX3BhbXRfY2Fj
aGUoJnRvX3RkeCh2Y3B1KS0+cGFtdF9jYWNoZSwgbWluX25yX3NwdHMpOw0KPiB9DQo+IA0KPiBJ
ZiB3ZSBhZ3JlZSBvbiB0aGUgcmVpbnNlcnRpbmcgc29sdXRpb24gZm9yIERFTU9URSwgdGhlbg0K
PiB0ZHhfdG9wdXBfZXh0ZXJuYWxfcGFtdF9jYWNoZSgpIGNvdWxkIGxvb2sgbGlrZSB0aGlzOg0K
PiANCj4gc3RhdGljIGludCB0ZHhfdG9wdXBfZXh0ZXJuYWxfcGFtdF9jYWNoZShzdHJ1Y3Qga3Zt
ICprdm0sIHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbnQgbWluX25yX3NwdHMpDQo+IHsNCj4gICAgICAgICBzdHJ1Y3Qg
dGR4X3BhbXRfY2FjaGUgKnBhbXRfY2FjaGU7DQo+ICAgICAgICAgaW50IGRwYW10X3BhaXJzOw0K
PiANCj4gICAgICAgICBwYW10X2NhY2hlID0gdGR4X2dldF9wYW10X2NhY2hlKGt2bSwgdmNwdSk7
DQo+ICAgICAgICAgaWYgKCFwYW10X2NhY2hlKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU87DQo+IA0KPiAgICAgICAgIC8qIEV4Y2x1ZGUgdGhlIHJvb3QgU1BULCBhcyBpdHMgRFBBTVQg
cGFnZSBwYWlyIGlzIGFscmVhZHkgaW5zdGFsbGVkICovDQo+ICAgICAgICAgaWYgKG1pbl9ucl9z
cHRzID09IGt2bS0+YXJjaC5taXJyb3Jfcm9vdF9sZXZlbCkNCj4gICAgICAgICAgICAgICAgIG1p
bl9ucl9zcHRzIC09IDE7DQoNClRoaXMgaXMgYXNzdW1pbmcgdG9vIG11Y2ggYWJvdXQgdGhlIGNh
bGxlci4NCg0KPiANCj4gICAgICAgICAvKg0KPiAgICAgICAgICAqIEVhY2ggUy1FUFQgcGFnZSB0
YWJsZSBwYWdlICsgNEtCIGd1ZXN0IHByaXZhdGUgcGFnZSBuZWVkcyBhIHBhaXIgb2YNCj4gICAg
ICAgICAgKiBEUEFNVCBwYWdlcy4NCj4gICAgICAgICAgKi8NCj4gICAgICAgICBkcGFtdF9wYWly
cyA9IG1pbl9ucl9zcHRzICsgMTsNCj4gDQo+ICAgICAgICAgcmV0dXJuIHRkeF90b3B1cF9wYW10
X2NhY2hlKHBhbXRfY2FjaGUsIGRwYW10X3BhaXJzKTsNCj4gfQ0KPiANCj4gSU1ITywgaXQncyBj
bGVhcmVyIHRoYW4gaGF2aW5nIHRoZSBjYWxsZXIgaW5kaWNhdGUgd2hldGhlciBpdCdzIHJvb3Qg
b3Igbm90Lg0KPiANCj4gPiA+ICBJbmNyZWFzZSB0aGUgdG9wdXAgY291bnQgdG8gYWNjb3VudCBm
b3IgdGhpcw0KPiA+ID4gKwkgKiB3b3JzdC1jYXNlIHNjZW5hcmlvLg0KPiA+ID4gIAkgKi8NCj4g
PiA+IC0JbWluX25yX3NwdHMgKz0gLTEgKyAxOw0KPiA+ID4gKwlkcGFtdF9wYWlycyArPSAxOw0K
PiA+ID4gIA0KPiA+ID4gLQlyZXR1cm4gdGR4X3RvcHVwX3BhbXRfY2FjaGUoJnRvX3RkeCh2Y3B1
KS0+cGFtdF9jYWNoZSwgbWluX25yX3NwdHMpOw0KPiA+ID4gKwlyZXR1cm4gdGR4X3RvcHVwX3Bh
bXRfY2FjaGUoJnRvX3RkeCh2Y3B1KS0+cGFtdF9jYWNoZSwgZHBhbXRfcGFpcnMpOw0KPiA+ID4g
IH0NCj4gPiA+ICANCj4gPiA+ICBzdGF0aWMgaW50IHRkeF9tZW1fcGFnZV9hZGQoc3RydWN0IGt2
bSAqa3ZtLCBnZm5fdCBnZm4sIGVudW0gcGdfbGV2ZWwgbGV2ZWwsDQo+ID4gDQoNCg==
