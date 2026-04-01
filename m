Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325351E9919;
	Wed,  1 Apr 2026 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087985; cv=fail; b=qJQkblQtwufM/tzs/hVg1jCBrfXjNXgfedxAP+YxcUmh1u4sWeH8JLtQEsyj7J/BvsFXg9q70BFCi3TqBTiyeEeGXTlV7e3BP0B2LWWoDj1aXRX4Ej3mpoqXWUNO4ydFYtN56ttmgBsN2QUNeaNwETSntUD7XbW0H1+af6Yiurc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087985; c=relaxed/simple;
	bh=rAUkNIVnVq+O+xPMcp3rMEO4Hc9+o3FugXr8ysE/u/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YbdcmrQd0IMGdD+LPhTIpzx3FwbkhAZmZoP5+e7ohHiesnxVup24HaxQLC+9zjtav1nd3ZfLj2Xk92myaUaAfp8y/dgW6LDRxEYMVs6/rsoJEqv8u7TugTFySoqOg23du/l0XFMEzr3JPbHiKWY0Jc4tw0ar92wksSXFxSryDiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l94WEMbt; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l94WEMbt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775087984; x=1806623984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rAUkNIVnVq+O+xPMcp3rMEO4Hc9+o3FugXr8ysE/u/g=;
  b=l94WEMbtEgaEDNTGLe/rYAfLTD1Q8o9EvowyZWTS5yDu0j1u/mXfz9u0
   2F4IthAFrzuf7FEljwBw0p8ajjnwumNiH+zs5rIg6DxJthwnEq4OEww5S
   n1UwI3MfzfXxf5mMQTdlG8YtABPJgNUAmUFyRHnk4hVGS2Q5CETmmHzT7
   CfhRsfgDNHP8S9ETqR7DDEvSKgnajogNxLb434MnqcdcYoml3L8Mio1Xz
   Zb5Uwh/7BAaItjPoSjIFrmsidAt2/WRSn0IAA+okuyeXWLIGm4qic/Ozh
   yNmgY44Bz3owCTUeDC5uivGMWAPsdpDmx8MWvT2NMFNJ+lF0Fnw3bUSTc
   w==;
X-CSE-ConnectionGUID: jM1r2ZTyS4yy3Ikfoi+VnQ==
X-CSE-MsgGUID: 71ZC+VMrQN2zKeUpVzta6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75858687"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75858687"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 16:59:43 -0700
X-CSE-ConnectionGUID: rHoYX7mCRViVIMNV2htd+A==
X-CSE-MsgGUID: EMPg4WEATm2gbdVyZJNWaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="231761085"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 16:59:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 16:59:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 16:59:43 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 16:59:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUBOlrzB6FLzkE1Vn0U2t7UtZkBBtIm8i5xso+GUzwCOdTZs05PtXOLEu7SiVbDP8DeWKMxotNakCxLSHJG16ZRbNTHNHHEee1Nl8HK0CpY7IEAjlFudU4Ytc1bz/IhfQmY6QALT4ZOPpwyPzM/6Jm8Ybsjcg39eFGbzaRnSZm3lMKaxB+1nKYq5XcXWfKv/9fiW92+/Kb2SjfGF0FXnBJuAjlwmpGrxSLEPNOXU5rwHUqpLYatSv5NZZyVIBJwqbjhfJ0mQMG3CBRy2tX7L8nNtkJl8r7hRjaHX6bnkVSw8y8VCGSCekAN2vuH/zAk2PFPQlrNsOywXrntS4dJAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAUkNIVnVq+O+xPMcp3rMEO4Hc9+o3FugXr8ysE/u/g=;
 b=XdqgPfz5EWNqUW/pjpHOMEorL3eIKPJ0EFOuamTbHmVTXXhoulEn6Irr322XMO2kSmBIPhLxOz95uYRMAX5904ekqeYBrbh3FJpcql5tcXsElYQJlmxZ2SXJ0MqkK734vQzERKCroRZ5aTmOTsU5S8f4UQFRne3BijELqUm1cuQ5qUQNzZVR7mgoneqQqje4Oj6xo8tg/xyNUvMIzJ4oW192Un7GUQz5vsftSTc1ZKmyJe3/Trfz9tvAHv/bRu1kVnwiOgk9dRpcAUPyj1cm2tjJBeecESAl+udFZu2e9pv434/gyNXz9NwSqOU/sucHVpr9veEkOd5dTemxgcxbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ5PPF7DCFBC32A.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::839) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 23:59:40 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 23:59:38 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 09/17] KVM: TDX: Add helper to handle mapping leaf SPTE
 into S-EPT
Thread-Topic: [PATCH 09/17] KVM: TDX: Add helper to handle mapping leaf SPTE
 into S-EPT
Thread-Index: AQHcviZWsF83Z7zh5E6uhUsnGYyWSLXGpLgAgARGLIA=
Date: Wed, 1 Apr 2026 23:59:38 +0000
Message-ID: <b352ad09ee082b9d676febd0c28520ecd8f4e8cc.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-10-rick.p.edgecombe@intel.com>
	 <acobjplac2phLTKO@yzhao56-desk.sh.intel.com>
In-Reply-To: <acobjplac2phLTKO@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ5PPF7DCFBC32A:EE_
x-ms-office365-filtering-correlation-id: 2a78c9ff-f6db-44d2-4b8d-08de904abbf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: SH4UR8DHHN6btXcZcfaMGM5iDGoQtdbzXVq5rzPZ8/xC4JzveD9Kflq3dZ5r/zTYnk5EWRMg5pjRPQncumKLSRH/6p659xoyALYYg2sO2WquqBB6PWB2QbKSvYhXBSDZWTvCCGv9pqy3UNNcYZntNotNGXlvJFtk0oHWzAx+t+sdgHgO277AuLKs+lrHZizbqT9FLfVxPyUqGgWWcJgARw/ps3zS64lr51XAYfh9vnalKclGs6+jsmDvMpZea1AhtOtHEs1r2xfGfGGYgE4nuI3Owaen3nnkGquMUHxP0ut+bbbe/JFuGpudEn3PAGDgcHekKqyMJfs1mbeaR/adfkxoWPtKSm4vrZQRdTa5wj9XgwmPjgsbwwxM+uZZaaA5N1XWXAgP5k37cKpIZI3Zco+HREc77WO9cZPZ7nIFLp1/iHn4FsWNcT4zay9wa+tbwng9LSsKyTfGZLF36t6QvEWVqug5OqnXi6sZDpKOLICn4cEM33P4mGWCs+gwsyws52jF/+BtskKn5IQgluRtkgkgzdiFL4eGbQnxU8C2+EK/tFiNSbw0I3sm/I2gZK3MQ8/YPgd3t1SSk7hdgvr9nLZmvmlHt4EbvGNDbVsJ7yMs6GTceHVk0JaEEd3ZYLEBH1m4GJluTRMIRs5d7vde5f7iIqOS5az9S4fAQnqTUUgkqVue3XD/BVNTe3NBzQdHMdL4aDx+280ctpMtiifV1P31RcJ7G4AZsAHktkJQ8T9iKLSByqm+hMJaxvlWbQ26YhHCkTYeKko1V4fwtTpZFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXVvbzdQNHEzTE9CWS9EakR3ME5FbjFVbEw1TXFwMlkvSnErUWd4K0lmbU1j?=
 =?utf-8?B?SG85ZUhGeThJYUh1LzA5dVNaa1NTVnFWWkdnTXJtTXA5M29ZQTdGY2dhMVVK?=
 =?utf-8?B?VS94ZzF5T3I5VUZzekxsSE44QjVOa3JaaDZHT3ozeEZxRGF0YzFLT04ydEVY?=
 =?utf-8?B?Y05yMFNsZTVuTm5XUkROQlFsRU9CYm1Ic0t1QW1WRXh3U1J2U3FJdXBkZkow?=
 =?utf-8?B?YnVUbnBoaW42SDlxbUJTaG44NEdLVnhKZ1dHaHQzN3IvRnVycmkxSXZ4dzVl?=
 =?utf-8?B?cFdoaFRJdzljY2krVWpHNE15NFJpRXA4TXd2bzBhbUY2WmljdlVEbnJqUUV3?=
 =?utf-8?B?SG1WUDBpS3NNcHgwRDlyVWZoRnorWXV4c05URmhCc1BpSWxRd09vZ1Z5UitD?=
 =?utf-8?B?cUNzM3pqSlRteXIxZ3dlcVlpOVhHN0hadSthT0xRTHVjRlgydHB2K3VLcEQ1?=
 =?utf-8?B?RkhhUExHbFcyRDNwVm4wZmN1V3pRUm1SVGcwbUt1N0NDRjY1M3BqSmFSWHAx?=
 =?utf-8?B?QjVSMjhZSFlFR3pEOTVCdzhJV0cvUUI1dWpzZzhESlJQWkIwNTJtazJ2MGpt?=
 =?utf-8?B?K2duQ1NwNmJiNmcwa1poRWNiTXpzTDRJRGtuREdXS1MzYzVJZnpsR256by9F?=
 =?utf-8?B?QVJhYk96alhGa285UVhJWllwaEJPenZnTnBOaExKb0tGdDN5SU96ZUFPNHdt?=
 =?utf-8?B?dXZ6Uy9yTHFiT3RVdFlDSkllQjMzdnQ3N2p3R2hTMG41R0gyUjIybmFudXZi?=
 =?utf-8?B?cG1mMjA4UjVOdzMwdUFNTmxOL2VJQ0ppQzB2RXpuMnB5T1doQjVXNGY0Y3JQ?=
 =?utf-8?B?Y0FMc2pLcUxDZ2NlenZjaDQ0M3MxcHVGTGhlbkRheVFKR21Yem5SeWYxSkNF?=
 =?utf-8?B?bVhrWkhXY2NoM0EyMnpsNGlBMzltalFaNk1LbFhyOURobE9VSGpGN25Xb3V6?=
 =?utf-8?B?MC9FUkZza1krdzJSTWZGK0Z6ci9sUE9HYW1lNjZwYkJQejdERi9VNnh0UCs2?=
 =?utf-8?B?K3BYWHRUd3FDS2FBSm1pQlh3ZFZJN254azljcVdNQ1hTekVpdlNIR09TKzBT?=
 =?utf-8?B?NWJYTU5qbDJ5bW44NEFGS2VRY09ZU2YyMXhSdS84QnJtYnVjdkZUcDZoNE5z?=
 =?utf-8?B?WDRJRndnL3p6eHlyZEUyQTJpa0pWSHoycVNqYmNuVDZUZ2NwTDNxOHRBUnUz?=
 =?utf-8?B?RnhKVUhiNEZiSXNXamQrendxMEZDQUFVQmEwRmN5VTNaT2k2SktmTHUxOVVW?=
 =?utf-8?B?ZHE3YzhneWl0SHFnSW4wczA0em1WNklIdGlWRW5VQVQvZVBVOHN4VzU5YU9G?=
 =?utf-8?B?MjNhSU42V3d1YS9ka3BMRzZaRWlSNUJ0NExSaW5RcDVBeWp0dEVZWjNEdTVl?=
 =?utf-8?B?NnNjSk1MeFUrNzAzbFpaSDN5SzlnT205WEFydWQ2TldxajMzWUg2b0ozWVd5?=
 =?utf-8?B?R1doYVpKdHd6eUNSWWtQRmJWaUNMclBEaUlOZ2JDa2FjbWtqeDd6SXAwWjdk?=
 =?utf-8?B?OFhoVUNDWlMvT3pSMSt0bm1KOGpTcVpBalhqRjhBS3ZzYnVoRllLQlllSEpW?=
 =?utf-8?B?aTBnRXpwcnNCSndaL2FjQnZIYStyTkFCOG9Ka29uSFQ5bkE2cnJyQVpTL1c4?=
 =?utf-8?B?MUhkTjVuZ04yMzkrUGx3UmJJUzRnY1Zzd1hqellpWkx6S3B1MXhrNi83ellD?=
 =?utf-8?B?SlFoZkhKSUwrVGZmdWZJUHg1T05pRUJpcVFjWGRPTjVQbWRsNEl6ZS8zcDdK?=
 =?utf-8?B?R1h3VnNIZzZyMnVWc09OaXpQaGphSU0zOFo2akNFNmIyY01Sb2hJMFkrUFpr?=
 =?utf-8?B?V0VWeEJuRG1Qc2xhUUVreUpxSy9GTEo0TGFNdUxwM1NyQXdvQitVWU9wRER5?=
 =?utf-8?B?OC9sWmdpc21UYm9vVVlkSWlidG9ZZTFqWGJqM2hIc1ZFRmk5N0E2QWpVS1VW?=
 =?utf-8?B?MFg2WmVrY3VwY01uM1dMMFZnSDVCcmw2aHB4dnErZWc5TElFMW52bmF6eW9S?=
 =?utf-8?B?MnBiYUI4VXV6aXkvejc3K3pkN1hETHh3eXFVRlhWYzhnSDdEL3dFUStRODgz?=
 =?utf-8?B?S1VCUlVTTjY1K0loUmFrMnY2R2k3US9ZRjBzK05aRWVwTEVCSkV5M2t4dDZ1?=
 =?utf-8?B?YzBDMmZrYitnNXZrTjB6T01haFU4ZVNQTlBrKzNEbGhKMWpYbndmYjdlVmpL?=
 =?utf-8?B?bGFYd2xaeHptbHBVVmUrL2VQbnljQ1ZVMGphWGhaQVYrRjFvZTIzbXpVd21R?=
 =?utf-8?B?YW9OM2FJU3NyYUt1NXZPWjFWemMzWmhFY2ZOQ1RLVVg0cmowQnUxbXZTVlR6?=
 =?utf-8?B?RnFtQi9YTElWWDZlVENtalVXWXZKRnFBMG9Td0dpL3FuamdPbkpjS3krWFV1?=
 =?utf-8?Q?scQt0LOZvnYOg9mg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EA40127F6BADC47B72012E006B0F605@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UyCxomBTPNfikmRK2DpVFXzH9HYAc3tgAtR7gIYt2vS++4OiKkLIrxTl4GbT1tx7Pvi93HimuqlGoKS2QlqgiUUQCagy413frTa3eMRLfFxMPBNoLjtI+/EJ66EU9rIrdBjvmf7qqhVyVHjk8rDj2cP6RDpw+j1AgCUKVSfTPmhKTjZwqVzypavu/gPAEtgzp4TeUhJSFqTxCV+NDByZEfHYyc1xschgyb0qOLuj1z3OwuQOcS6LoiWAmYqhpud5teuHLZ7ybEyFoQLo1cSHCMX9Tr7rfHt5W+3eraZ9Zbq82bPx6PETT/G4S3TCZ9+14sgHE4ZRII8HwHU3j0Cf4A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a78c9ff-f6db-44d2-4b8d-08de904abbf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 23:59:38.8270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nzBh5q66m0lfTNWJVTWDqsfmmg0iuDyVfXSEX2N7zRsuw2hERpz4niuX3b+6AjaRXV6N0TOl1Aosb3HlRP3BOMiw7c164IslCmqWJBmDo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7DCFBC32A
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE0OjQzICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiDC
oCANCj4gPiArc3RhdGljIGludCB0ZHhfc2VwdF9zZXRfcHJpdmF0ZV9zcHRlKHN0cnVjdCBrdm0g
Kmt2bSwgZ2ZuX3QgZ2ZuLA0KPiA+ICsJCQkJwqDCoMKgwqAgZW51bSBwZ19sZXZlbCBsZXZlbCwg
dTY0IG1pcnJvcl9zcHRlKQ0KPiA+ICt7DQo+ID4gwqAgDQo+ID4gKwlpZiAoS1ZNX0JVR19PTigh
aXNfc2hhZG93X3ByZXNlbnRfcHRlKG1pcnJvcl9zcHRlKSwga3ZtKSkNCj4gPiArCQlyZXR1cm4g
LUVJTzsNCj4gPiArDQo+ID4gKwlpZiAoIWlzX2xhc3Rfc3B0ZShtaXJyb3Jfc3B0ZSwgbGV2ZWwp
KQ0KPiA+ICsJCXJldHVybiB0ZHhfc2VwdF9saW5rX3ByaXZhdGVfc3B0KGt2bSwgZ2ZuLCBsZXZl
bCwNCj4gPiBtaXJyb3Jfc3B0ZSk7DQo+IEZvciBzeW1tZXRyeSwgd2hhdCBhYm91dCByZW5hbWlu
ZyB0ZHhfc2VwdF9saW5rX3ByaXZhdGVfc3B0KCkgdG8NCj4gdGR4X3NlcHRfbWFwX25vbmxlYWZf
c3B0ZSgpPw0KDQpZZWEsIGl0IGZpdHMgYmV0dGVyLg0K
