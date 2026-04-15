Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9612237F742;
	Wed, 15 Apr 2026 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289743; cv=fail; b=EmPOayJ2nSkqyMCVcYSSzxkb2Hpvu9/vFkE1JSSJhrg8w3j1dw0/QFglcCMmtjNVaCogkxAa4HCLv7JYg9eTd4lc8v1tvPxSzgNMPkG6iFZJN85iwzY9vU8zYg2JLeLyCW9XQhK/4WlZWqSwCvk8nou/llFsb8Abi1P1idd40cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289743; c=relaxed/simple;
	bh=3KWUOztJRw2bU4tgCJwJYX/SWz9ZD8UHdocBJiQycPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gG36LRrr+v/Q9zYfDdbzDE5lSSk6RNgdBoMJU9lGA6TfB554sj7PxrLPfUMGxXIaV3euAM98loq8u5r4t7a0GXMaDqifJ97nXg8LwuOrmI0SvyYPd61zLjmMAfck9/L/nlx5uPVy2H8ufCzFEdc54NIBqgEwyaWwCuF/20oYL3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NL8kABm4; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NL8kABm4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776289741; x=1807825741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3KWUOztJRw2bU4tgCJwJYX/SWz9ZD8UHdocBJiQycPw=;
  b=NL8kABm4l8nfXsN4duaHCEMpOrVOI3dYSpqJObxAtpMU5dc2gQ6WY1OI
   f+idM83Bu5knuoV9we3+eD59ZXoiUh/nXNq2pE19TBr9ZjAMdqDRtg8BB
   N5tN35bvfHoxw3KjqpkhJi7raJWtOK5QcNNROo20Guu1sZLqWP28pCzmL
   gC/OPvoO0zKH1mv63YyiiGr9uRSHU8YL7KeIDhLqPnmb79TrAGubFjV7o
   WIOOv94deU6SmIOCfK56sFdFXlaq7Who2NuRgzfFWSDS1n3XAx9UlNe3E
   rX7j4tEfUBybszpls9jfX/XnAonBl8BgnHYcDId1nogkcrQasp7E8pweG
   w==;
X-CSE-ConnectionGUID: nx8FIAq+TxuiDlHJYofpbw==
X-CSE-MsgGUID: /dtEW8SCSrOfv74d/leYMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="94850999"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="94850999"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 14:49:00 -0700
X-CSE-ConnectionGUID: Ze3DYCuMSJukagC/fGCQAw==
X-CSE-MsgGUID: YU5x2X5dTQC5p38+QxCxgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="230475101"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 14:49:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 14:49:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 14:49:00 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.31) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 14:48:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdgzntYhwOOMCTmmzCgquE63oAoaN+nZEHuNK//i19CVpGlsyPLEIlRr2LpT8EuXXGyHfAM0+D4F5PRfZMLCKQTKlrCzx0ZmJTugDf8ZI6IK2xmKg+OQE8Dyh1KndKrb2TLBzSl6yaIykFXgeXBOjX1L9EEeiNFE2L7E9ftGwW8r9LJtHo1Zh90D7MCX8aD+YDDnh5xL/QF7fAYA5utF0/82wIbH3rwvOMWykIL9i+y35AiKBDQQfFQfScMtuDFKMrBpZBf+n4q8ME3N0jnjglazPz7onwsQMabtsu5LkT2F+3fySE8PSINFZmQYwNpOBsCyxPgXMHENEL6bCOq/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KWUOztJRw2bU4tgCJwJYX/SWz9ZD8UHdocBJiQycPw=;
 b=IcKIAiipU+uLtHcjfz4IFIoe4RWSkZUdvbGpnmcaF/yaafOFQzKXlFfxAPWLdRVsGwnNpg9X+sBtwR/77w5yp7C8luvfqg0jgANsAW/87ANjiWvQUbapxOl5RC1JXybMvfmyrYe8by4QAru59OmVtxotAwx6jRwvZ7XoMDF7/zFCN3NKR9e9FSQQYvsMYQqURec2A0ClcgCA+bDqaWcKH/PoSD3yXUwJ/2l+qKEvt9HmMd0NaLbNn41w9R+z/q0aLfFxFJNIzB6Lhx1hO/vCTKo+cid3QuW61NC0h3h7QiNv+Tp7zwxIiEjF/WhsBDI0pFSSWI3qPLjwzVc60Ug7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB9480.namprd11.prod.outlook.com (2603:10b6:8:28d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 21:48:49 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 21:48:42 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "x86@kernel.org"
	<x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "tglx@kernel.org"
	<tglx@kernel.org>
CC: "Huang, Kai" <kai.huang@intel.com>, "Tng, Ackerley"
	<ackerleytng@google.com>, "Shahar, Sagi" <sagis@google.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
Subject: Re: [RFC PATCH v5 00/45] TDX: Dynamic PAMT + S-EPT Hugepage
Thread-Topic: [RFC PATCH v5 00/45] TDX: Dynamic PAMT + S-EPT Hugepage
Thread-Index: AQHckLzMgOFs0IWDNkC8x8uQeMOUcrXhIcOA
Date: Wed, 15 Apr 2026 21:48:42 +0000
Message-ID: <0f25c1c247c08f19d36ca774608bc8162d2454a4.camel@intel.com>
References: <20260129011517.3545883-1-seanjc@google.com>
In-Reply-To: <20260129011517.3545883-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB9480:EE_
x-ms-office365-filtering-correlation-id: b9f6fdf1-b5f2-4921-efc4-08de9b38c320
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: pD2MxYidZjAacMSSoPc9iDxekwXOiZthWpgNAV8SxuXH390kr11Zqc5AgkeCPug3ASarB60VrGan96vFKTgxUQS1tLEUfFwwindC40us8PLxCPE34/vNm1D7y4nN5j6Wd+JhFaQOqb89yFxf5vzQkQX5YfnuFNL8G73IjRowva+MM3Fj7O8kuOoC0t6/BuXpgtpr3Lh93t22iXGxSW1Mu3q1tWTQu4s9giBMF8p8aclwkH6FLQgefu42tniT9iFGfarUJP+zYNrRnpGpijWHd++AzcGNfDbVz9tIg8lfjeeUB1GTT4PlOWu3trtaJFbG+TnV7MSCfi1Lcy5ZcSLDeMT78shBeo+q1IzybSY2FjOUUu4EZTm/pBKzvY1CVisxuKUfzAUt89IgaAWCPbVLMeAfMZESxTjik/ACK8F8chy/2R4AgDL/qMO8cU9IVq79Qtsk7IUHTuvA+I4HskTFp1pg+4OyZdyOh0I3F6EOprw4Ig+GqVQgsbj4azDyLP89HTSL8tlc0YY5kqajF+9HhEdLhyqbVW0VU5ufYK8gWH1BDcHI8mnLuy31d4yOHmpumFsiKTzSfw3y2wy4k0O6prEHBqmmGtymYD/3CaM+HgdnWLdTbx+H4UtVNwJbF5DKO50OngiUkMK4l5EyTNI1fGgSZRcYnTGw+KdWBiU6UFC5RxcEgMRoBlGaJGu2kKMnec3Iz7jVBdhWYgZ0X9hdPXc3gFaUNpsjwPv7K5+qUugfAHJoAy3dFwExRSDMPRtvx4OnI9XG4Jk106G54W+wtkT8Bht0FRt80u1yzVuSopA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1lVNjJoWWRiN2FIYUlCQzh0U04vdWFPUHR5WHZsWXREZXo1WXIyak5MZnQ2?=
 =?utf-8?B?N2hTd3pzNllEMlRjSXVIZXZkd1Y1ckV5ekZOeWNlWVVINFg1N3pncXR4VDU4?=
 =?utf-8?B?bTdqUThQWFBRZEZ6VzQvdXdPK2ZIWVBySWwzSnJrNEZTcDVoanFvcmFkQTlh?=
 =?utf-8?B?QVlpeW5ibmRLTXkySWFGSUdsdS9vQmZQWnl2QUpWMHF4QkdYSnJWcWdCNzRZ?=
 =?utf-8?B?U0JNQVQxaDBRMy9XdFE3MjhLU3dVd1lCZ3EyN3daSE11Nk5rblBnNE56NVZ3?=
 =?utf-8?B?bHYxRkgwblJnYnpVS3JhTS9HUDJyM2xpRGViaE9TZUxES0NOdngxZ1ZHYUNT?=
 =?utf-8?B?QzhOa3g5aHIxSVBVUlpvYUd2NDZiK0FuTW9PMzliOWt4WEVEMTZibkY5b0Np?=
 =?utf-8?B?SitRKytoOS91Mnk0WjVmdXREcURDaERpalJ6TEJZTFk1UHNYL3FUVk5LU0Y5?=
 =?utf-8?B?Nk1JVkZldnQ3eWpmdEdTek83aDVBV3FzL0hvSE1IL2hSYzdKRFg3QURKTGNQ?=
 =?utf-8?B?LzJySnNSWm9PbE9pdFlNcGRGTVRrMjBBTmZ6dTVsUTV2YVpJSi9hRDlhQzVP?=
 =?utf-8?B?QVRGUkVSMUpJaVVMSjNNa1pPSjc2cVNWTXZyMzRCQmphekowZG4xV2xORzR0?=
 =?utf-8?B?Q0RWdFdvYU9FOWg2cmhDbTA2a2NKenk2bG5XOGdjT1NackJJV05NUlJNc3N5?=
 =?utf-8?B?Y0N0M280cEtwOE11NW9TSWNubDY3RWprQk5pZW0yNlhHdkVHZktidUhtZHdq?=
 =?utf-8?B?KzRXbCtVdXhyaFlpL3NXaU1QMHRFbVpJa1pHYm1SMlY3azVCSDBOODBaWnFK?=
 =?utf-8?B?bjg0LzJiaURzV3Foblh1SFhramNqZGJZVWtNNVU4UnRrWWh0WlJ2c3hJYlJN?=
 =?utf-8?B?aWN4aXdQRG1RZWdscG12azlQemNJcjhmZGo0bElYSytHQm02R2tOcVNuM1pi?=
 =?utf-8?B?KzZpRUYrVldBRDNVTkJqVUFXazZQNHpYMFJ4KzBIcklhby9RN3dFd1FrM0Vj?=
 =?utf-8?B?Q211VENuSU4xaS9yYmVleTJlcUU5Qlo4UHhySUZEMWhHSUkvK3N2cDZ0cUtP?=
 =?utf-8?B?RGhkY1N6M2NRTWwzakJzRVlRdlpWT0VGTW1MMy82d0UyUDRIWTlDNjc3czdS?=
 =?utf-8?B?TUExa1EybnUram5qVjlDajQ3ekJXaVFZcjNsT3JDa3ZZenQzalh2MFRFbjA1?=
 =?utf-8?B?bVh4MVI0d2J4UnBuQ1pjTDlZRnlWdTYvNTBLakg3eWZIQTFPcHhKcFNhU1Y0?=
 =?utf-8?B?ZjVXZFl3Vms2S3dQUGd0SzdsNnlUVDNkSEg5QkpUTXI1UlcySkpZdmlCdzRI?=
 =?utf-8?B?dk8wd1k0c3RVTjVSSHpWeE16NCtoYkZVZVV6NTZlYW95WGVCOFdGVnZ0cVhk?=
 =?utf-8?B?ZTJBV01ocEZwcUc3WnBwQTkwV2pZTC93TnNnM2xkZ1RLZ3cveFRoNmNTNXFl?=
 =?utf-8?B?VFBKdmFXTG43VEpzd2Q2dTFITDRxdmx4RWlWb3JpU09DOXByWG9wVHRrS2NO?=
 =?utf-8?B?UmhiYVNtL1BJZnFPTUxmUHllWlUzb0oxZkpUSVVKajJZbmFTYS95TDE2Wi9r?=
 =?utf-8?B?M0tzNG5rckQvZWlHOTZsaTJNcml1dzFXZlUvZkU1ZG8wQnZWMjV0RGtCOUJu?=
 =?utf-8?B?aFJ3REkrWXp1aHFLLy91Ykl5T1BuK3pNZnhNQVJ5eDN2M3Q5VHpsT2ZPR0k1?=
 =?utf-8?B?QmRPSXR6UW52U3E4dXBLbkJDb3NmTmcyVDFZZ1NKbWF4RS9TU2taNDhNWlp4?=
 =?utf-8?B?VGZWbnRzYjlRdnRSd0s5Q25iN2d3ak94aGE4MFVPYjRpMGpDNktxQ25UTkk2?=
 =?utf-8?B?TUVHVlJwRkxyZ3VXZDBMMDNOQlRrSjQ0SXAwUnFKNWdybGdsTi9JNlRKeTBj?=
 =?utf-8?B?alV5eHlQVjJGUE9OTjNKZ3A5MytCWkxxSGJqTWZSWVBPUHRUOXVnWTFXK0VH?=
 =?utf-8?B?dDZnOG9LVUdUSUlheDRvY2Vhak4vd21uekhUTjI1d2U3UnNrQTVzeHFPT0Rm?=
 =?utf-8?B?SzUrRmZsMmMzSG1CT1VsdGNlbXA0S1ZXZWQxeEtKZFEwTElFT2JydVJHemYy?=
 =?utf-8?B?eExVUVloSjNxUFY1WDdqa0lBREFYU2JQeENYQ2RVRER1R0NmQnY0YWFDa2Fi?=
 =?utf-8?B?bzZnQU0zNmd0bXRsaWVpNW9SaTU3c1B3YXIxUDQ4L1B0V3hJOElGeFRLem1l?=
 =?utf-8?B?OHpWdUpHc0VHbFRGY005eDBENERvSFlUczNQY1lDUkVITTdleEdYckZPVFky?=
 =?utf-8?B?dmFady9aMTJvOTErbWhGUElBdDY2U2lPMFlrWWpEekYvWXFHdElJM2JSbmJu?=
 =?utf-8?B?V3ovZUE3QkduK1ZTblpWTUdhTUVLaFJFUi92TjFheGE0VDgvY2Z2b25MN2dG?=
 =?utf-8?Q?vIDXY2kDy/kDlKUU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C09188CE76879468522C82D1DDC69EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dd3WRBPwD2yfNSCqSue8XOsdj8Ij8GytqU6y3xQ0xvsUc1JIYiUOsnumNLuRU+rNIUAH7PhzPVas1Bq11EhM+j3Z7yeY1A+rJ2PR8/+07cee2iPUg1nbqfytajLBJA/CJeeHW+6lyc1Eyeomx2CUPLXq0cLkv31sUhH1XkBGU7NXFBuSL2HOk18xB0Im5wCLqaH78JlBT4slTveY8dNiNA1iq9b3g+5GnU2mMQfL2xS/F5FkEDNBdOciFifcTOtz5y1Cdc9simr17QThClNS16wY9rVyuxKpS9IS6eakCcDxZv5br/mZSML0FdmS6ePQZSLwJGhUOdnachL9LLngwA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f6fdf1-b5f2-4921-efc4-08de9b38c320
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 21:48:42.6764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJCIoNr9j3fQ1OasFnA6+f3h81WvJBLCJaQsYyfOJ49ypSOITGEwsOweZYcqiRP296QDYoWGI/rAyBmRQITH045S6Qz5jKqdzeOQw/nqNNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9480
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTAxLTI4IGF0IDE3OjE0IC0wODAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBBcyBmb3IgbGFuZGluZyB0aGVzZSBzZXJpZXMsIEkgdGhpbmsgdGhlIGZhc3Rlc3Qg
b3ZlcmFsbCBhcHByb2FjaCB3b3VsZCBiZQ0KPiB0byBsYW5kIHBhdGNoZXMgMS00IGFzYXAgKHRh
bmdlbnRpYWxseSByZWxhdGVkIGNsZWFudXBzIGFuZCBmaXhlcyksIGFncmVlDQo+IG9uIGEgZGVz
aWduIChob3BlZnVsbHkpLCBhbmQgdGhlbiBoYW5kIGNvbnRyb2wgYmFjayB0byBSaWNrIGFuZCBZ
YW4gdG8gcG9saXNoDQo+IHRoZWlyIHJlc3BlY3RpdmUgc2VyaWVzIGZvciBtZXJnZS4NCg0KU2Vh
biwgd2VyZSB5b3Ugc3RpbGwgcGxhbm5pbmcgdG8gZG8gdGhpcz8gSSBzZWUgeW91J3JlLCBJIHRo
aW5rLCBhc2tpbmcgZm9yIERhdmUNCnRvIHB1bGwgcGF0Y2ggMSBoZXJlOg0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcva3ZtL2FjX2JNS0Q3WUdoTXdVQ2ZAZ29vZ2xlLmNvbS8NCg0KQnV0IGFjdHVh
bGx5IGhlIGFja2VkIHRoZSB2ZXJzaW9uIGluIHRoaXMgc2VyaWVzLCBzbyBhbm90aGVyIG9wdGlv
biBpcyB5b3UgY291bGQNCmp1c3QgdGFrZSBwYXRjaGVzIDEtND8NCg0KUGxlYXNlIGxldCBtZSBr
bm93IGlmIHlvdSBhcmUgb2sgd2l0aCB0aGF0IHBsYW4uIFdlIGFyZSBncm93aW5nIHN0YWNrcyBh
aGVhZCBvZg0KRFBBTVQgYW5kIHRoZSBvdGhlciBzcGxpbnRlcmVkIHByZS1yZXEgd29yayBhbmQg
bG9va2luZyB0byByZWR1Y2UgaXQuIEl0IGNvdWxkDQpiZSBuaWNlIGlmIHdlIGNvdWxkIHRha2Ug
YWxsIHRoZSBwcmUtcmVxIHdvcmsgdGhyb3VnaCB0aGUgc2FtZSB0cmVlIGZvciB0aGF0DQpyZWFz
b24sIGFuZCBtb3N0IG9mIGl0IGlzIG9uIHRoZSBLVk0gc2lkZS4gSXMgaXQgcmVhc29uYWJsZT8N
Cg==
