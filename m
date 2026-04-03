Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09C73D5677;
	Fri,  3 Apr 2026 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245309; cv=fail; b=IO2L6yOq+YE5oqHssNQoIC09vkIsHQnIOplaDx7TKr1h0L9TF8SP4TmCD5IvwKZ4gEMUv58HQ9KviBrO9OzgZKRIog3/NLyOld7R58jTQpwknk72bJELPXUWS8/7P0Bxah9VJTeOJnE5fQohiKElAc4MpC27xYf7pCEq7IgjBdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245309; c=relaxed/simple;
	bh=EupcvtGF397spitmXTItj5R4Xf/u0sBjEIHjh9NFR4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YMn0aZrAkQtE6FAiEhlzus+0CAPyEBPXcMQTnmKk7VuBqMY3q+VOBHqH65X2O7NtBL24jGhaU/ZYlBA9HveE+Ka0+f0oQNx/UlUuYfHg6d9b4bWRmDAVsUxEY5QAi3hgWDq9xGQ93M9DmZO0JYFJ4Dg+6M+sI0tuKu5unhI5j/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2EqIvax; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2EqIvax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775245307; x=1806781307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EupcvtGF397spitmXTItj5R4Xf/u0sBjEIHjh9NFR4U=;
  b=M2EqIvaxyVSeDMj1zpPK+/jRWbSjcuAoa8Dxb+LS9zxONSGgWopPQ2Rz
   VxK6ZAnER7iXSVIGQ4ETy64k2ewMF/+iuM4WMlt0/sMQnS976VmWWTkr/
   jQAc9p7l3BWpHij+SRuUCqNwZ9DtvloerkRyjLJW1k/djfhs5lND06cUs
   vW2J2gUmeG80BH02w3HFombSMnxxc3rdLvO3lywiEJCpdpGu9T+lS7lz4
   yDD3e1JC0v45iCfAanBtQBCEUOQiIflezVIOtiZu2ZIlczc4ilFt63OYS
   PgXQOHvgvTli4Wgw/QsC9LWW4/nlcd6co0h4sJYpDq0xdgIEi6HBPXlwF
   Q==;
X-CSE-ConnectionGUID: E5INBNLaRLy6t/Lz5esLCA==
X-CSE-MsgGUID: 84Mkrd91Ske8koTCM/t3Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76193198"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76193198"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 12:41:47 -0700
X-CSE-ConnectionGUID: 4XjS+TRnRuyhIpDALWPdYw==
X-CSE-MsgGUID: 7E9kvNzjSEGB26xwCNr5sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="232261759"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 12:41:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 12:41:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 12:41:46 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 12:41:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BS1JjFs3JuOBOx4QcX6mAOKR8zFqQuLh94q7+dbno9T0q+KcBBi71iue1zpmWIAh6H3YFRSqKAmM5zHUfMlC6tVVa4AlPB52A0XkukoTI2+qEBaSjYRS9OZjc0i+Mfb/etTf98oHHpW9Fe59uEgNa85RW9HMGaPiA1CiV5W/x4/rQw5qplFG2D4MVWylZC0ck6aFWKMCayGV5IFuzNJjMBixDPLImtCYKbuYljxWwbJfWGBiP1WNIdO9y3Rs/pg6amEdroX75RxwxbGKe/7DlCI7R2UfbKHQl9LzsL82fKbMe610EOAE0ZvxDEDrjtFRcFbtlNypUx0ZLQiaZiwk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EupcvtGF397spitmXTItj5R4Xf/u0sBjEIHjh9NFR4U=;
 b=HbdUeua7xOqzucLfiIpQ3shFvER58rz6tcPTIJOylezKZyxNtsjVORodVy0kXXNbQMZO9Ne8CNIRumRopdFovC+2KHu4FY2t+dZv6qRsCG/9BHb7/sVFjfKZn0bxllspg/CwWuuG56yvUrh2TMU4r9KIInXYXKlDrowO8t5EulHA4W/LWnypErj4kRMgx6f3IkvOnzHmdtLsFDGclENb5e06D3gIcOAzwE9JclNuYilz3di+etlWhKXtiZS5ttIKnDhMsM6kxsrc2agsh2wWWh0OlPQbBvdHabePh1kqs+XvNAIjsFX+aU+fNxyKmLJywcAdIKNzXpitOvH7L17yFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB7593.namprd11.prod.outlook.com (2603:10b6:510:27f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 19:41:38 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 19:41:38 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "prsampat@amd.com" <prsampat@amd.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "marcandre.lureau@redhat.com"
	<marcandre.lureau@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "Qiang,
 Chenyi" <chenyi.qiang@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Topic: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Index: AQHcu6ISxXKhFiWKBUuIm+vE1xtYKrW+PPMAgADQbgCAAHNtgIABo7qAgAAlqQCABe0qgIADLMUAgAEXRwCAAJP5gIABJR6AgACYAoA=
Date: Fri, 3 Apr 2026 19:41:38 +0000
Message-ID: <f4639348586233245343005708372230f2d4a2cc.camel@intel.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
	 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
	 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
	 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
	 <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
	 <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
	 <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
	 <cab5371d-e0f4-42b7-bae9-2c7f981b26b2@amd.com>
	 <49e8b24d836c1883e83ad72d1ab279f9e3eb7455.camel@intel.com>
	 <IA1PR11MB949557E04741169BA209A69EE751A@IA1PR11MB9495.namprd11.prod.outlook.com>
	 <9b1290bbc1283a2f35bdcd177d27ae7aea89151c.camel@intel.com>
	 <IA1PR11MB94952B22F6EB648ED7C1AE3CE75EA@IA1PR11MB9495.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB94952B22F6EB648ED7C1AE3CE75EA@IA1PR11MB9495.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB7593:EE_
x-ms-office365-filtering-correlation-id: 091df2ec-6421-4ae4-2d03-08de91b905e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: ygCNf4zXQT+fgnE6Qdq7f1+7xV5YEBhLXceIBNJCx3yhyKYKkt0lA0/jpDBC/hR0baHIbbvCG2/aUvvnKE/4MpcPqkWgN+0MVeUslIeNeP9h9q4j7TfbWvlYNX4/Cu1QzRsm5ZTblzXs9EzpVp7lYy6CP72CDNfBCYelj27JB2olpu6rf+ctwCccdNawGAo5D6FcJvJMlNak5nivyRDxjC2TfSiqrlzLqDN4tmM3ht6Ml4oiWGRIKu4mLdjXlhDL/9MTJjRTYw6u2yMCq/y64V2npBybp1gBfXqrUDYU1fJUleY+6N2fvubKydYRdwlwj3Br7qRCawfiRO8MyL0oLX94bk0ge5VQdR+Fv5sALfhGolhIW3nn1n5IGOxgQbSJgLd9E8hhZ4/3E2N7fkN6bDkQdDv83rELwCHzPwhud/8IdHOVFQyECMo+9lxIMg4+C+/xJDTphfrcl7cK40l3zeMjPxMyzDjW7FnOtVNVJuhGgzFCAhpkthkx80OC3q0eNF+m3PbJ6V0HbHNhu82HwC1fBCZJPZWtSS7d5BpkxbwUf1FWNWM1fMEzfRdKcrolncBNgRqrCViBjodAcr3syH5om7ZNCgkZ7qHV+Q7zEh04C5b3x6tPpSjonw2JwCdGQy6P8j5SVPxLy3OFEbOFBuZrj5PHZ0xKYGJX453HeTF1WOfRKjfzzPGwiCoU+06W3d8c+Zr95KeIGXyt0/mscIR2zLcZKH81TbMC/FOBVki7/ZuqNvy3AAbpEybrNKKU1r3BTOTvbR5s/kZaW9b5RmkWKzbqt1zLWCW97i4mBzs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clh6UG1WRzFHT3hqeDJkOXJtWmx3S1VIMHFSZktIeEdMMlpFWkNSR0pZUzM1?=
 =?utf-8?B?MGJaSmNKSkJ0ZDgrRk1wMEFObE9YMTVjUWVQdDMzcUZka0F3OGFmTFhqZHUw?=
 =?utf-8?B?cE5nWksvblFpUHdYK1BoT3ZCakZxZGNOWTN1WDhKZGFTYW1mUTlZQXd0cnpv?=
 =?utf-8?B?NVVvQXNUU0pCdFZxcWd1aTd0S2E3bXo2ajNlMk80QW45RE40OFhMTUNKMGw4?=
 =?utf-8?B?U2VYWTZHNmRBdUNoNkJFLzR5NWpXcy9QYTRSUENWS1RNUk5uV0hQd3NsUjhI?=
 =?utf-8?B?c3BQclhuT1ZobTkyL2NTQUgvTHNRc3ZuaGNLbUYybTFMZ3N3YVFrWVZCY0Qz?=
 =?utf-8?B?VU5JWC9QQ3pKcHowNkRkMFkxNklvV2JWanRMeThBb0V5SEswZi8zTk5oc0k1?=
 =?utf-8?B?ZDJrS0RvM0RObk1nKzh0d0VKMWFvbTRDaENYcVdGOUFjcGZvcEk4ZnhPVG5h?=
 =?utf-8?B?dC9UVG4rcGRreVloVUxYZlhWbmdYZ2EwMzJnMjRhRFFwRFpIa2I4U0gvT2o0?=
 =?utf-8?B?ODVUcFd2QnFkSmFKL3FlK1BLTXh0UWNlV2M0em9obzIvMS81djlGVzBZTzQ1?=
 =?utf-8?B?V0MzYllQRXhLUVRLNzNyWnVLakJHeEJUZkNBaHpyc3JkbjEzcTZLUXAvUnlS?=
 =?utf-8?B?RFFSd3kwUWQ3cDVPY2RYN2J4VTM3dSt0TTREQUFLNjdJME4xTWtnZWtTOWFa?=
 =?utf-8?B?VHIzOERORjhZVUpwMFI5eVlTaTRNclUxUGJvejhIUDhseW9jN1d2dzB1TzI2?=
 =?utf-8?B?UVBLMWl3V1VZYWNIemp4RUxRRUk5QUQrYkQ2QkxpcEFLMFpZQlJCRUo2MW52?=
 =?utf-8?B?eDE2SFRua25CdGJFVi80TmtlTjlqcUF2eFVmQmJKbUl6cW00Qng2dkorOEw4?=
 =?utf-8?B?M2p6N2lHWHRBSUJHVWhhZWlXMS9tcGRQc21PaXU0TE1oUThNNmhwcWtXNzU2?=
 =?utf-8?B?QmcxQlV5VndlL1YvMThTUzBNdTRmb29oNUdZQWQ5dk1pM2crc0RSY1Vsb2FF?=
 =?utf-8?B?RTlFcUxudVN2NG82cmF6ZnkwWlFFdjhXcjhucm9oQTk3R3hPd2ZhWThGSVdW?=
 =?utf-8?B?NEUvUzcyYzFHa1J5N2FzeDg2R1MzK0orejhXSEFHdUpFcGdtZHk3dmRIKzQr?=
 =?utf-8?B?cmphRnhNMExkNDFvSXBmSlBqMnRwRlVSY01WVG4vSzVINjFESXk4YW5PbUVI?=
 =?utf-8?B?a2RnRUswOVFRSUZmb3dDRWcxYm1BNkhDUlNYUEF0em9KczJkZVVGOEk2YVMw?=
 =?utf-8?B?NDRYdGNYUjErWlBUNnVaMHRvVldJdEhZRHlqYVNyenQ3Ry9pNXRENlZVMDVE?=
 =?utf-8?B?WUZIZHdRRDlRdjBwYzh0dzgwZkVhaWdBNGVFMDcxcXRXcFUrWmlYVmU0SUl4?=
 =?utf-8?B?NXFjWG9FdS94d0UxY1JHTldGdlF4OXFpNHM5WlVrOExQMVFWZEx0Q3h3OTBR?=
 =?utf-8?B?a0Uzdm5lNkVyK25aUVN6cDNWTmlleTlTVTE3eU1OMHN3NEoxN201aVZadCs2?=
 =?utf-8?B?NDB6ZkhMSy9ZNEVMcm5hR011VjJEWFNBaW5Lb0orSURnSThZanUwSy95R3BL?=
 =?utf-8?B?NStHNGJOQzNXUmh6V0J0c0UrbXlZSllvNm1iM2RzOWc0VzVVWFRYTU56UW9J?=
 =?utf-8?B?S28yVTlwWWZzNkdxSDM1WlJmTmx0NlQxekVpR3dwMzMzakJlUzB2WFBVNEti?=
 =?utf-8?B?eG1Fa2Iza0JBRXowZGx5SkFWMitFcTBQeWlobjBJRWxBLzYyaUNlYW9lSlNm?=
 =?utf-8?B?N3NqSXN4NHZmOTgyckt2a21iTDNsNEZzVy92NXhBWEZiVS9iRlByME9zRnhB?=
 =?utf-8?B?bDNBd3JHQUN1UGlRZ0lnNEN2Mm5LK1psREJrV0lON1dWUXk3cEQ2MFJXYU40?=
 =?utf-8?B?QjFWN29nc3FLbUkyMWxyL25UR3B5bUJ5dGVGNXFuWFplMU5uSUFORklTclBq?=
 =?utf-8?B?aUk5Yzk0Z3pqdm1keXdhWERLWUN3MnFFMXFsVXlDODJaQzNEcEhGQzk3ZEJl?=
 =?utf-8?B?YUFvTXZHRHpNMWYraGNkZDVHczV4cWtlUE1HU243REpKSmhSUmN5WllVQzRX?=
 =?utf-8?B?blFaNEpHcyttRVB6QUVhb2xBR0EydEZBUU5ibnFpcFEvUjQ3VjhXR1JKS1NI?=
 =?utf-8?B?cDdjTzVzaGcwSStOaldIdjR4RGRMU0hDWE1NU2JTVUR2N1JmTlZxNWRVdzMx?=
 =?utf-8?B?c2tWaTVMcXYwdzNyS0lNZ3BnZUZ2VTZ2UmR0OTM0dDYxdWttN2RaNFNXUzNq?=
 =?utf-8?B?YjNUeVVYWlpaRGpRbVRkOWpwYS81RHh2QkJ1SWZ2VVVCU3c3R0V1YWZsOXdV?=
 =?utf-8?B?alJDM011QTE1Y0ppS0pFSVRrQVQ2TmtqeCsxclJWZjAxTU51QVhGTS96VVcz?=
 =?utf-8?Q?ytOegLfkqbqq7Cr8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BF10436A5C0FC49A51E7867EA79B9AE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W6bPzjhElDFpyTPcpJjDBZc2JY4iH3wqxcFW5hFMjFreaXs2aj6oXS/OltMfdyTLbvFFOGTruIiYXmkkyBCy8DJCZ7YZKGoawHSEFB4mJA0SgqcLplynOgi65cwnM071UjgTqOKZ52hny2FEDDObSNgCtJDKVz5kdJRO2LJi4d7zBkl1Ci7iy8yBVSx2dDfkOzygk61iObMboEC43JWQPU7+8LhJdm57voWrMQK2ICDFx46h78EkckuiaB+rhE6KJFmHP/p2YH53RxQULUvjcYMQE312+ZGOUbrzW2HLdNMMkAl1H4e6MgvKH21dJg7qHiIuUV6cAAAlkQQPD76viA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091df2ec-6421-4ae4-2d03-08de91b905e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 19:41:38.6775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OaZPPM1KIU0Hy3imZv86b3Q75QorUgmPA9+pV7wefeMe6XwwunRk/VvlQBzVcL7riBwQkKr/q2Of9TKIKq/q4aLYqVWmHQjM3V7oRm7Pex8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7593
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA0LTAzIGF0IDEwOjM3ICswMDAwLCBSZXNoZXRvdmEsIEVsZW5hIHdyb3Rl
Og0KPiA+ID4gPiBTbyB0aGUgcGFydCBhYm91dCB3aGV0aGVyIGEgdHJpZ2dlcmVkIGFjY2VwdCBz
dWNjZWVkcyBvciByZXR1cm5zIGFuDQo+ID4gPiA+IGFscmVhZHkgYWNjZXB0ZWQgZXJyb3IgaXMg
YWxyZWFkeSB1bmRlciB0aGUgY29udHJvbCBvZiB0aGUgaG9zdC4gPiA+DQo+ID4gPiA+IEkuZS4s
IGlmIHdlIGRvbid0IGhhdmUgdGhlIHplcm9pbmcgYmVoYXZpb3IsIHRoZSBob3N0IGNhbiBhbHJl
YWR5ID4gPg0KPiA+ID4gPiBjYXVzZSB0aGUgcGFnZSB0byBnZXQgemVyb2VkLiBTbyBJIGRvbid0
IHRoaW5rIGFueXRoaW5nIGlzID4gPg0KPiA+ID4gPiByZWdyZXNzZWQuIEJvdGggY29tZSBkb3du
IHRvIGhvdyBjYXJlZnVsIHRoZSBndWVzdCBpcyBhYm91dCB3aGF0IGl0ID4gPg0KPiA+ID4gPiBh
Y2NlcHRzLg0KPiA+IA0KPiA+IFllcywgYW5kIG15IHBvaW50IGlzIHRoYXQgd2Ugc2hvdWxkIG5v
dCBhbGxvdyBndWVzdCB0byBmcmVlbHkgZG91YmxlDQo+ID4gYWNjZXB0aW5nIGV2ZXIuIA0KPiA+
IEZvciBhbnkgdXNlIGNhc2UgdGhhdCByZXF1aXJlcyByZWxlYXNpbmcgbWVtb3J5IGFuZCBhY2Nl
cHRpbmcgaXQgPiBiYWNrLCBpdA0KPiA+IHNob3VsZCBiZSBleHBsaWNpdCBhY3Rpb24gYnkgdGhl
IGd1ZXN0IHRvIHRyYWNrIHRoYXQgbWVtb3J5ID4gaGFzIGJlZW4NCj4gPiAicmVsZWFzZWQiICh1
bmRlciBjb3JyZWN0IGFuZCBzYWZlIGNvbmRpdGlvbnMpIGFuZCB0aGVuIGl0ID4gaXMgb2sgdG8g
YWNjZXB0DQo+ID4gaXQgYmFjayAoZXZlbiBpZiBpdCBkb2VzbnQgbWVhbiBwaHlzaWNhbGx5IGFj
Y2VwdGluZyA+IGl0KSBhbmQgaW4gdGhpcyBjYXNlDQo+ID4gaXQgaXMgb2sgKGFuZCBldmVuIHN0
cm9uZ2x5IGRlc2lyZWQpIHRvIHplcm8gdGhlID4gcGFnZSB0byBzaW11bGF0ZSB0aGUNCj4gPiBu
b3JtYWwgYWNjZXB0IGJlaGF2aW91ci7CoA0KDQpIbW0sIGl0IGRvZXNuJ3Qgc2VlbSBsaWtlIHlv
dSBlbmdhZ2VkIHdpdGggbXkgcG9pbnQuIE9yIGF0IGxlYXN0IEknbSBub3QNCmZvbGxvd2luZyB3
aGF0IGlzIGV4cG9zZWQ/DQoNClNvIEknbSBnb2luZyB0byBhc3N1bWUgeW91IGFncmVlIHRoYXQg
dGhpcyBwcm9jZWR1cmUgd291bGQgbm90IG9wZW4gdXAgYW55DQpzcGVjaWZpYyBuZXcgY2FwYWJp
bGl0aWVzIGZvciB0aGUgaG9zdCB0aGF0IGRvbid0IGV4aXN0IHRvZGF5LiBBbmQgaW5zdGVhZCB5
b3UNCmFyZSBqdXN0IHNheWluZyB0aGF0IHRoZSBndWVzdCBzaG91bGQgaGF2ZSBpbmZyYXN0cnVj
dHVyZSB0byBub3QgZG91YmxlIGFjY2VwdA0KbWVtb3J5IGluIHRoZSBmaXJzdCBwbGFjZS4NCg0K
QnV0IHRoZSBwcm9ibGVtIGhlcmUgaXMgbm90IHRoYXQgdGhlIGd1ZXN0IGxvc2luZyB0cmFjayBv
ZiB0aGUgYWNjZXB0IHN0YXRlDQphY3R1YWxseS4gSXQgaXMgdGhhdCB0aGUgZ3Vlc3QgcmVsaWVz
IG9uIHRoZSBob3N0IHRvIGFjdHVhbGx5IHphcCB0aGUgUy1FUFQNCmJlZm9yZSByZS1wbHVnZ2lu
ZyBtZW1vcnkgYXQgdGhlIHNhbWUgcGh5c2ljYWwgYWRkcmVzcyBzcGFjZS4gU28gdGhlIGd1ZXN0
IGlzDQp0cmFja2luZyB0aGF0IHRoZSBtZW1vcnkgaXMgcmVsZWFzZWQgY29ycmVjdGx5LiBCZXR0
ZXIgdHJhY2tpbmcgd2lsbCBub3QgaGVscC4NCkl0IHJlbGllcyBvbiBob3N0IGJlaGF2aW9yIHRv
IG5vdCBoaXQgYSBkb3VibGUgYWNjZXB0Lg0KDQpURFggY29ubmVjdCB3aWxsIHVzZSB0aGlzICJ1
bmFjY2VwdCIgc2VhbWNhbGwsIHNvIEkgYXNrZWQgWmhlbnpob25nIChDY2VkKSBob3cNCm11Y2gg
b2Ygd2hhdCB3ZSBuZWVkIGZvciB0aGF0IHNvbHV0aW9uIHdpbGwganVzdCBnZXQgYWRkZWQgZm9y
IFREWCBjb25uZWN0DQphbnl3YXkuIEl0IHNlZW1zIGxpa2Ugd2Ugc2hvdWxkIG1ha2Ugc3VyZSB0
aGUgc2FtZSBzb2x1dGlvbiB3aWxsIHdvcmsgZm9yIGJvdGgNClNOUCBhbmQgVERYIGFuZCBrZWVw
IHRoZSBvcHRpb25zIG9wZW4gYXQgdGhpcyBzdGFnZS4NCg==
