Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4ED30B53A;
	Thu, 26 Mar 2026 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557613; cv=fail; b=r2FjJHNAPIm+o663IqlF7ZmE4bHge3nlKK6O876VzGTIY/dlo7LQ0qw/x5Ed3+N9poYhBC1XDFvmEF6uHX+m8yBhDr6GIJTEmCZnDo/5wPffXlWpHl0Qo07455xQbw/bsmm9V3iHL7VAwVNP/8ZJRvt+fIGdWHL7CP+2FIkq4k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557613; c=relaxed/simple;
	bh=+MeSexLiBfnjI/w9Zth7pCNhFAu+59dzyYj5o71L29g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j21gwRczelKUcViMADBNg5BNm521L+XMiC6dWoBlayYNWaGLEZ6ZS4cHnvEvYi3w1dzbSx/wDmKyJftMo5OZ5Ab6cwQ1G3fG0M6l+2WlHsISMLThXhGBUYGMKA1qfhZFIUeG/+aM6MZnI5c829rFYaM3i7Uidly15Sb+1mQutWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X10uYzy9; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X10uYzy9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774557612; x=1806093612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+MeSexLiBfnjI/w9Zth7pCNhFAu+59dzyYj5o71L29g=;
  b=X10uYzy97P9LbqBIuZnDTYSaRoyDGJM4Ef6ayLwLKDI+ySs61/2TZiEJ
   4hPJRl7pMqW4iYxqSAfJe3EdL0CDr2CZTxpujpVrlJfo4zoaMf5AIbMpD
   H0Dy/5JNxsSYZ3qw40u9w9WZ25kQFMnhdk/jJ+l4VgWzNdr0J16a1zULI
   zB2ls0UH9ZXvwX8cVvrhI1zbmZcNFi9kGUCacLSN82b1T7YXzygZjDXYr
   vnAKyEKsZnZcMDOPgtJdblXAZBkCfx/Ixzld6fEsiwAazAhPHJppOrb1J
   9wJezGTl79qwLGH9ltxYqVPJn2308APd5kDedi9HHj1rHjF1+H1huPicM
   A==;
X-CSE-ConnectionGUID: ruLmuvI+TVyOKsDSi/G8mQ==
X-CSE-MsgGUID: gTFND+Q7TPmTg7h9yUNI4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75700089"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75700089"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 13:40:12 -0700
X-CSE-ConnectionGUID: HzH+YOWKRvWal/dxhF5j+Q==
X-CSE-MsgGUID: HykYFn0tQMa3G9qgtiSn+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="225047627"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 13:40:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 13:40:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 13:40:10 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 13:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dc8cUhl0beMmNlGf/zx+HRMBNaOLSb8Uwlxs953a7cpmbl05S0RwHnk20Vk+4jCM+V2d8FVlsBng+vVuPjcLgdy+37JMF/Q9QxnXBwcZtBUOZuti9rH2XzvMLUT35f6jS4R4Zt18Y/299RDkpZ2Cz9X0gPbdGq6KG2fdraiRdhA1oK95oSOyBcg+xaBIeLTkE7pfVB1viCP9ArAx2/xiIP1y2Dvor2kXL12s82U2p5XPVWaOtSjeBSF1FaYUBD9dlO9dm127UKw/fjGiRqcktKh55BiLZBqoMvib/dAvgpXxQEbqz3FGhRME38EM88jXlVIG3SgL1xcgPqWibm6ejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MeSexLiBfnjI/w9Zth7pCNhFAu+59dzyYj5o71L29g=;
 b=Xxqtlgu97nkUh9jCg8kjwfPpUl76R5ZdXXhswTm2Z7GaEXu+p38UJo101/WHLqas9ixoy9W52k+5sgQFSwAPRSo43EtDPK8OsuvLG1WlsqePForrcL5RH4jM9gsWYuxH+4JR+jQUtafJA/tRr33EilJAio97cLcVXtw+FRdhe23ppF8WnJtQ3feSnpN/DsXZcRcI0qLj6FCyhX6dkCV7iHuyA4USliopdHU4kQERwWJd+eVZnzR9xoGCFSoYasHM2RmegoveSlQWONKcvJE6MlJ+nByRW3wwsdVlHvu430DzsBa6uDTB8hMTX2jmnu67iqmfwjWF365dq76P55lwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB6406.namprd11.prod.outlook.com (2603:10b6:8:8b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 20:40:07 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 20:40:07 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "marcandre.lureau@redhat.com"
	<marcandre.lureau@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "Qiang, Chenyi" <chenyi.qiang@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Topic: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Index: AQHcu6ISxXKhFiWKBUuIm+vE1xtYKrW+PPMAgADQbgCAAHNtgIABo7qAgAAlqQA=
Date: Thu, 26 Mar 2026 20:40:06 +0000
Message-ID: <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
	 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
	 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
	 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
	 <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
	 <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
In-Reply-To: <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB6406:EE_
x-ms-office365-filtering-correlation-id: 3c88ccae-0614-4f8b-9320-08de8b77ddb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: yv4NLHMgNjDenL3rockrPKTnKm3bibbPTmHKhznmB01/2jHqXe0cZDXEKTjCgjikuTmHkXbP0LdXHhOKVb0snF3KS8X5YDko+mYMDoAbOZRhR5YTwF4uxwXk2TQO/qJgrvR1M/W6JQCosVXfFaVhGYyPW14KybN6DwpQBijIham2auqgTB12yzPJxymjuDd0ozHN7UORbcneUday5XusobKjOfA24tnyLHT23IUi30JV9CovpMWVSPWN49HfxQZa4WOZ1cORaP1GgTu3nv7nzY4JNVkz3DfLZ8VlTlSMLoPkwthaBCogERnEdTtip8gq3q/+epN+cT+SZmawC35pOGN+dDsE/8xdVVxCcxg/qhukrX0ypfwCMPu1Z0A+tcxIVX6hqI6P9BDcSeW9Tdfxv3HTxIZBemNWX1EhCgCQOn6/TAL0Rd3ZGnTIrIitwLEnYMbTxiHrmaGLfRfLuBjhp0OWlzI51OXhvXbyUFN2IomrHv01RN7Ib/eEMFaDm/kjPzan4M/pzDutmKoTB9fn7dFe9SlsYKp2W836TpmLo5CzG90XclzjIcgpYe38ccQ7TB4lKUQtzGgRPZ/EdnVzrw2MntSvXLm/WDY6BmA/E7d6aDV/sDnI8F4OJ3kYMPJBAkhr6k2d+12jdw4vxA3YYiaKli4n/MAm0VGuG3TBZb+Ko0rzi8Myjc0WB1za281ADaNY/KNePneE182Ex0lE67W31QvCZ2vcV3ql9aY7KT3nluo+v8PQJlLhVMPeDdAiKK0PTfWr4OBquZQKrdn5aqXgqyQjYL1FCMB5WYjFmxQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU9wV0k5OGNVOEhtQVpvN0lqaHZJVFEyOS9yenZqbUZ3dmhLRTEzQkZlZUtk?=
 =?utf-8?B?VHdET2hnTVBTU0VmQ3ZsZUZOTHVDMEYxd2xRVE5vbWtGK0J3OFZNQ2ZqdWV2?=
 =?utf-8?B?c0Nqc2dZQ2dXdE1NNTZoTlVrUDN6Si83UXoyYmI5dWhMZWV6NjYyaktOR1Fm?=
 =?utf-8?B?WFpMTk5hbitsa1RzRUwyelhRRHpSVEdKK21vQjZwaGFGTC8rNGF2N0VzTU10?=
 =?utf-8?B?aU1qdmdCakFBWEJNQk82T2hwSzRXRzAxdklQVE84NU4xMWtaTjROWWpaWFJD?=
 =?utf-8?B?ZzNDOERrU0Y5QWhEWXdOSXF0REV1bXlKajR4RTFuM3NiY2wxTm53ZlVJRFZB?=
 =?utf-8?B?QjNRL1ZFVmUreEgxaVJsTEZTMVZQVkdSaURKWXVobGJEZWZFem9Iait3NHhF?=
 =?utf-8?B?cE0yeE1PSE9mNnJCVldVM1JTd2F1citIblFOcTZTUG1TZE9rQy9HR1htS1Y0?=
 =?utf-8?B?L3FONFhwU1dpT2JWRXp1Unp6ZDVscTlVVWRMQ3M0TUZ3c0RSYVBySGs5VG45?=
 =?utf-8?B?NGlpRnl3VzNOK0M1NHBtQUE3eE1FbVlkRU9DMGtZN0Qwd2dyZFhNVDU0L0d5?=
 =?utf-8?B?MTFtbnovY2ZOV1VmVkxyV1NNbDBDamZlMEJkN1Ryb2JneGV4RE1KUXh5aHhF?=
 =?utf-8?B?a2VlQjZxYUJoM3o3VDZJOUgzUGpodUZQcDV6QmNJS2VZay9ZOWZQRmh1MlRG?=
 =?utf-8?B?bEpzRitHTGV2K2V1QnBqd2dFMGhuM3FSV3RCeXZrTkhWVXdrRFA5cnFwdkxj?=
 =?utf-8?B?N1Fwb0YwampkbzFEUm0zN3pMSWxCMThmV3dMeVJxY0kxWGo4Z2tIYnNCS3Fa?=
 =?utf-8?B?ZXNHdzNmb2dIYytBeTRuRTQvYUFYK21FUVlOV3NnNzU5MUdpcmhCV1NkUjR1?=
 =?utf-8?B?azllVVJ2MUcvdDBDU2x6TUxIVW9hR1p6REdaTEFObWJ4SWtwRXZqL2FlblBi?=
 =?utf-8?B?N1EwTUM3T2FIRmpZd2gvNkZtS3U5bDArb3NCWEdrZnhhQTg2YnppZXVHekQw?=
 =?utf-8?B?bWpkbXVtbmQ2Rzhqanl0bnQrS0NWV01UdUZoVEJTQVpGR05nNlJuMjZCRlR6?=
 =?utf-8?B?K0hnalpPS1RxdlJDTVJWbEdranRja2xaa3VZblhqYWczTWxHMmhtV1VLemYy?=
 =?utf-8?B?NUJ3Vk9RU0tmK3ZXcVBjZVBWNnBKTTZyczU1R2dKQ2Y0NUZyamQ4cDFFZ3A0?=
 =?utf-8?B?ak5LUlV3TS9qMW5TZER0S2ZpTjdpSjFvNDlSL3NxeSt5VU4xSVIyNGRTS3Yr?=
 =?utf-8?B?Yzh4NTkwaUJJdXNENEhoU0RITElHbjl3MGN5ZDhQRFVVaG5xWXNJSnh0T1F0?=
 =?utf-8?B?eXNGSzEydlR5SE1PQ09yR2I0S3o4TzZyc1ZMcUNjYi9PdzdLSzdwSFYyRFYr?=
 =?utf-8?B?QVl0TTlSMHJycTVQVUh4S2NPa3F4L2lkdm13ZHZvWGNRcFNUNFNJeFlwS3pk?=
 =?utf-8?B?ZlRvdHdLL1hVdEhEc1lOZzdYVWtxWU5EaVJtajcyR2dESHViNjZVUmNySUZL?=
 =?utf-8?B?NVJSclBaeHNRTTRac2hEWExSRHVLdisyVmI4Mk5zd1RKZFA3blA2VE9FTmo0?=
 =?utf-8?B?SlhLb3pSdlluMEVMZTBWdlhoR2dXcmZOZ0hNOHVMOE0rS2t3ZzlLRWJING82?=
 =?utf-8?B?VlVOdXBPd1hDYWVSUE1zQUFKQTdyM3lGZUV6ekJCZUMwOEN3RUZSUm9HK08v?=
 =?utf-8?B?bFgwdE16Slp0YmdZQ2RvTjZ5VGY1cTBrUjFvMjB5RWNkdTdQa2dia2d3dGJJ?=
 =?utf-8?B?L3lHd2dpOHV6VGMzRVh1S2pWMHZ6eGh2SThyRnpBWU1kTVc0d3RRM3dMeFhB?=
 =?utf-8?B?OERQUmVWd1hzRVp0MkRORk9jQis3ckJ4eTlvK2hkTFFLVkRqV2FudWdNQ0pZ?=
 =?utf-8?B?aCtjcnhIREZDMHFGbUw2MDg2dUZHaHRzUm9pbEd5aXQ5Qkg3TVFZeExidk9L?=
 =?utf-8?B?NHpFWlRHWlk2YVhZeHlZTkJORWs3dm9HQVhuaXdFL2NGNm8yZFZFc2h3SVdr?=
 =?utf-8?B?MVVtaU5hYVVQNGwvdzFhbmZvUkIzem0rYWVrVzNhVEFnTlpOV1RhVXB3ams5?=
 =?utf-8?B?MUtBOERCWDQ2czRoWWZQSGticVNrSEZhRHRXcHRxYm83U2VmdGk2NXg2RUwy?=
 =?utf-8?B?UWhyRHpydGl2YXk2RTQ1enhWRDNPTk1KY3dLK0wwdEVHcWlTLzg5d3Y4MmhS?=
 =?utf-8?B?bEpId3l1QVI3VW5kcEZnSW9PWW1xVlZ0UG1vU3lxZ1dPN3RTQ0tTcnFTMTFQ?=
 =?utf-8?B?RW5XZ0gxTXJ1ZmVsWjdkUW5uSjkwUFZ4Q3B1N0x3c3luNEc1OWNBSVhmbXU5?=
 =?utf-8?B?b1dJRTdHWHJqOVJjc0htZVFRNWtFc2pKbmEzc2FVRjZWcjNxQmw1MFVlWGxj?=
 =?utf-8?Q?kD3N7KUALMFZObQs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <190232C931563F46BA5D899C1B1C73D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jbA/c0wLd6c1ZbixvkLX/LkhnjLa65u+9/1JmVmE7TkM6ZerYLNhYZc/BISAj2p0W0hec4MkXTZbCkNy/btP2mcUe7XAkyTAOAetWyMVuso/3S8jUoHp92A7xbPGkcp/tRgTUCsYc38sIlSV99dzWXI42nF84leSNnes338CXzwr1d4FFfJxGZR/hu+VPvv7xZbcz6UMrUT4ScxZun60RGPylCMFLVlZ/iau97Z6RodbXcGC40/RUX9IBbOEw0p27noVJxWPNq+htUnCU7+0KjjCLO373p8UaqSJOirvfvQjzMHfmeXTEpAOIYmLvyQtGHc+OAZnzLAUz5Enigsoog==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c88ccae-0614-4f8b-9320-08de8b77ddb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 20:40:06.9746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XpSaj0/zGqz5lRovOj8KKM+c2I9Bz6D8zVIxEX0PY58Pzjj4wawVin9PepztkW1cJqdZEqNe9jHqjW2xdcxLrPvncx3l15TYomIxEuV51Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6406
X-OriginatorOrg: intel.com

SGkgUGFvbG8hDQoNCk9uIFRodSwgMjAyNi0wMy0yNiBhdCAxOToyNSArMDEwMCwgUGFvbG8gQm9u
emluaSB3cm90ZToNCj4gPiBBbm90aGVyIG9wdGlvbiBjb3VsZCBiZSB0byBwZXJmb3JtIGEgVERH
Lk1FTS5QQUdFLlJFTEVBU0UgVERDQUxMIGZyb20NCj4gPiB0aGUgZ3Vlc3Qgd2hlbiBpdCB1bnBs
dWdzIHRoZSBtZW1vcnksIHRvIHB1dCBpdCBpbiBhbiB1bmFjY2VwdGVkIHN0YXRlLg0KPiA+IFRo
aXMgd291bGQgYmUgbW9yZSByb2J1c3QgdG8gYnVnZ3kgVk1NIGJlaGF2aW9yLiBCdXQgd29ya2lu
ZyBhcm91bmQNCj4gPiBidWdneSBWTSBiZWhhdmlvciB3b3VsZCBuZWVkIGEgaGlnaCBiYXIuDQo+
IA0KPiBXb3VsZG4ndCBpdCBhY3R1YWxseSBiZSBhIHZlcnkgbG93IGJhcj8gSnVzdCBmcm9tIHRo
ZXNlIHR3byBwYXJhZ3JhcGhzDQo+IG9mIHlvdXJzLCBpdCdzIGNsZWFyIHRoYXQgdGhlIGxpbmUg
YmV0d2VlbiBidWdneSBhbmQgbWFsaWNpb3VzIGlzDQo+IGZpbmUsIGluIGZhY3QgSSB0aGluayB1
c2Vyc3BhY2Ugc2hvdWxkIG5vdCBjYXJlIGF0IGFsbCBhYm91dCByZW1vdmluZw0KPiB0aGUgbWVt
b3J5LiBPbmx5IHRoZSBndWVzdCBjYXJlcyBhYm91dCBhY2NlcHRhbmNlIHN0YXRlLg0KPiANCj4g
RG9pbmcgYSBSRUxFQVNFIFREQ0FMTCBzZWVtcyBtb3JlIHJvYnVzdCBhbmQgbm90IGhhcmQuDQoN
CkkgbWVhbiBJIGd1ZXNzIHRoZSBjb250cmFjdCBpcyBhIGJpdCBmdXp6eS4gVGhlIHJlYXNvbiB3
aHkgSSB3YXMgdGhpbmtpbmcgaXQgd2FzDQphIGhvc3QgdXNlcnNwYWNlIGJ1ZyBpcyBiZWNhdXNl
IHRoZSBjb252ZW50aW9uYWwgYmFyZSBtZXRhbCBiZWhhdmlvciBvZg0KdW5wbHVnZ2luZyBtZW1v
cnkgc2hvdWxkIGJlIHRoYXQgaXQgaXMgbm8gbG9uZ2VyIGFjY2Vzc2libGUsIHJpZ2h0PyBJZiB0
aGUgZ3Vlc3QNCmNvdWxkIHN0aWxsIHVzZSB0aGUgdW5wbHVnZ2VkIG1lbW9yeSwgaXQgY291bGQg
YmUgc3VycHJpc2luZyBmb3IgdXNlcnNwYWNlIGFuZA0KdGhlIGd1ZXN0LiBBbHNvLCBpZGVhbGx5
IEknZCB0aGluayB0aGUgYmVoYXZpb3Igd291bGRuJ3QgY292ZXIgdXAgZ3Vlc3QgYnVncw0Kd2hl
cmUgaXQgdHJpZWQgdG8ga2VlcCB1c2luZyB0aGUgbWVtb3J5LiBTbyBmb3JnZXR0aW5nIGFib3V0
IFREWCwgaXNuJ3QgaXQNCmJldHRlciBiZWhhdmlvciBpbiBnZW5lcmFsIGZvciB1bnBsdWdnaW5n
IG1lbW9yeSwgdG8gYWN0dWFsbHkgcHVsbCBpdCBmcm9tIHRoZQ0KZ3Vlc3Q/IERpZCBJIGxvb2sg
YXQgdGhhdCB3cm9uZz8NCg0KQXMgZm9yIHRoZSBiYXIgdG8gY2hhbmdlIHRoZSBndWVzdCwgSSB3
YXMgZmlyc3QgaW1hZ2luaW5nIGl0IHdvdWxkIGJlIHRoZSBzaXplDQpvZiB0aGUgYWNjZXB0IG1l
bW9yeSBwbHVtYmluZy4gV2hpY2ggd2FzIG5vdCBhIHNtYWxsIGVmZm9ydCBhbmQgaGFzIGhhZCBh
IHN0ZWFkeQ0Kc3RyZWFtIG9mIGJ1Z3MgdG8gc3F1YXNoIHdoZXJlIHRoZSBhY2NlcHQgd2FzIG1p
c3NlZC4NCg0KQnV0IEkgZGlkbid0IGFjdHVhbGx5IFBPQyBhbnl0aGluZyB0byBjaGVjayB0aGUg
c2NvcGUgc28gbWF5YmUgdGhhdCB3YXMgYSBiaXQNCmhhc3R5LiBTaG91bGQgd2UgZG8gYSBQT0M/
wqBCdXQgY29uc2lkZXJpbmcgdGhlIHNjb3BlLCBJIHdvbmRlciBpZiBTTlAgaGFzIHRoZQ0Kc2Ft
ZSBwcm9ibGVtLg0K
