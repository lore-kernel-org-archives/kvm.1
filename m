Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA9436922D;
	Wed,  1 Apr 2026 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057852; cv=fail; b=SOpmpwTJtl6vd/58OYp9Xiyl2Ry+myAWw7yqsykxN5CRBUnBpJYsQv2DpUyLa2ldSuUbu6/FYIykJkupbTxEgfIwP60b1xbEotlAThJyfMeOU+Tw6AOP2Ou+RzwWb9Z9DaK0KDy1TZLiwnnGmySOUTMT7UPCj+zU8/hDcbhjY8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057852; c=relaxed/simple;
	bh=7a/sdvMHvn2yhZ9SPar1/1/kE8fQeKBmerUmZOag+Ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q4rHtRpbaZOlGRuDkXpyNXWI7VYZPpuB8kGYqaMkB8JGnxE+zA23ZoEPaUiVnrmZxY5mcCzFtxetkjZy/8BL458ByN3RHrqtUq6jNq7xCdJUoGv/g+2odJpKxANfBPw8bU5UHQxcuBtJveLSrpdbh+FbQAK2zCvUMn603MzfugI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhRZ37uD; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhRZ37uD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775057852; x=1806593852;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7a/sdvMHvn2yhZ9SPar1/1/kE8fQeKBmerUmZOag+Ws=;
  b=FhRZ37uDuhwEzbBya8wRZ8GZBCgVvM49YnJCMKHYnY+YLDl8Tc4tx88c
   VAvzWxt9qniQTGkkUfH0u04Yg+TgszcN8G+g+pMoTQwZ4ShFzrDNO84Ko
   303UP7tgl6dtR9K6pdUAfGZJjMwjcU4AqD53Pl0Pc9O00exWemipqaJ3w
   qSqorR11eA347PdGEdkHqaUvWLyCbhRCluIRRsImpXNqqOMPUeWfNnj+5
   mZhnZQhGJde8rdOj2o4qE3N1QQw82puApX7POQ6JYceIw0erOaueVzz5S
   96YlCUxIkODi4ug0i9668558Gwc60wmWGv4YRQu7pjj5RBCme7uoughJk
   w==;
X-CSE-ConnectionGUID: u1KXjiEWTryvy4j0iXIMBA==
X-CSE-MsgGUID: ick4i4anTMyDR33aeaC4DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75816080"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75816080"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 08:37:31 -0700
X-CSE-ConnectionGUID: WW3qGblIRvKLEKfkNeycMA==
X-CSE-MsgGUID: pYBLxUGNTUChNFNz6JCWHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="226698696"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 08:37:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 08:37:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 08:37:29 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 08:37:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsS5HUr/9VWOroHDs/5SiUlMoxh2OC4Ez4GDp+CA8DMLFC57jd2L+Nh1ioxSjI8dgYAPx3c5I1h3pWXQy3zcYFF4TtMCUPdcxln4ndPShSqUEF9lDyV2EGWLACPFpkBbjIOsZCAetcfAoGew9N41+T6eCRXcp+2oKJDSwiihR4YJTLtk9iccuJUMRCXPDheMUDUyksIj67OPYKf2IWTF6k2c8XL9ZpAl9cLNMJhFII2Q/FHszZQIV1yj7NKzHBmqCJx7aZia3C6RsygF1Zdtl3csWzIWOtO0qHuiL+F/Vbv1pN0sBTESqnZflPqtbBuDv9bNsTKL3JwisiRJCIjQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a/sdvMHvn2yhZ9SPar1/1/kE8fQeKBmerUmZOag+Ws=;
 b=fXv0qA/EcWDNkEvh10dnHZ3MpyjJwoqAEt108C+AQTpwAKSa0X5OJVYAg8d6QeHfqtgnehkDZziXAxD5lQLiWWErOF5NshVxtf4a9hkoe3NujGvR79MrLJt0iZZgxQmoPWaFlZ6wL7ijns8dZ5RkkYCUJMcuumZ85c16nTkuqk7nhgsKngoMu7I7Ina952bQcqJI/p/2W9T5FT6nucpVeCC5HIv0wthYcj0SP0dmV/sBmkNof29vShBYdme9yUqwB+3OXsMa+aAbvzw7qPGtOZCvR/7CeYxVN7F/wACJiULDqj3jeoZmjHOaeQ5WS5haYtLEbtRkormXYXKY9ki7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB9605.namprd11.prod.outlook.com (2603:10b6:510:3a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 15:37:26 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 15:37:26 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "prsampat@amd.com"
	<prsampat@amd.com>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"Qiang, Chenyi" <chenyi.qiang@intel.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Topic: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Index: AQHcu6ISxXKhFiWKBUuIm+vE1xtYKrW+PPMAgADQbgCAAHNtgIABo7qAgAAlqQCABe0qgIADLMUA
Date: Wed, 1 Apr 2026 15:37:26 +0000
Message-ID: <49e8b24d836c1883e83ad72d1ab279f9e3eb7455.camel@intel.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
	 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
	 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
	 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
	 <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
	 <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
	 <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
	 <cab5371d-e0f4-42b7-bae9-2c7f981b26b2@amd.com>
In-Reply-To: <cab5371d-e0f4-42b7-bae9-2c7f981b26b2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB9605:EE_
x-ms-office365-filtering-correlation-id: 6d679b0d-94d6-4833-55d3-08de90049372
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: IeSm3JeSP8ZuGAi+1XmDSt7W4Bvdc9sXIlFPq+Jbw5PLmkIxoTWvovkPuBZF62v61vEJcvZg8v22o3eAD/kvry+B3jL8JQMB5+1eehYHvjGJPdh+xEuZIUFZ2tV07UMgZLOooZtPMZwFlVUK6rJuGsQOvjtqnlfhzJB6Xku4vNZvJnbqWK8wqwyJUPDFNpNdoygaNNP7tEWh8umZxeXde17UWvMpWgZXZAPKC5k5NPW3wu8ScPmjk1E4RDxdNeONuw6C/P0vEYbF08ixqWiDj2ChFEL2WEFrBAVOgUfUIIIwgwQUUV3OdggMSfRt0a15H6cD3o0bKOsyT3SYlyhTqUDPeTrmGS+nlOb+iVBLB7UH2izFfrO2+zkWhz5aWMBXMS1nrdPI+FUcj88H+MecrVOAXpVwuv/w/5UBc6EiiJEqSrfycwLzji2nHd80uTaTvuOsobl4Fiv9PXPMknoX0T1ffhxHx1nseGqi4JWMV+7IcFLL8Ra/L9Pha8tUdaxgk0Z4QXjWuSJcp442cYLo57tuYyrFJh8MIOJDISvkqAsaKTV8szIXKDqOKhuXqVwW33s/5kZWzK6glXY1ojOS6260Qm9LXsdfQDiOvf6LCcx84q2Ol1edKuQmoE4AfLNx3RFnfCkZYVNswzgTYgs9s5r83BJlcfEwgwXp/Rdm3pp+r5E+mh2GUUtEnTrg2f43eiwVl9tNJfN1Tt+NJnUTCd/fsxDZFs50CBRdJP+ejm0Cais7lBn3vKx3jToo6hldFTEfic3jz+Tcg4MpHe/ijt6G54M6cKwOySDY+GS4Jrc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(38070700021)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWhaVmdKdGkzMEN2LzJtTHMwSC9SbjVrVXJTc2hSd0ZxcVltaGNLQk1ibWxr?=
 =?utf-8?B?SWE2b1pJTzdsQVVoSHZqYkRRNVRZeEtqbG1qQnFIM0VERmNHc2VUSHEyei84?=
 =?utf-8?B?VGk2eWNxUUdKL3RHL2ExcWVHQWxEVTlCVVpOTVBoNzdOcTY5UDM5bW9yY2I3?=
 =?utf-8?B?MzZoQTdjZmJMbnlXV0h1Z0hhcDNGNzg2NkR5WnE5MG10c291aGpGb014cFRG?=
 =?utf-8?B?bDl0b2VDQW51Zmg0QzRKT0FBcWQvMTJtQy9IVGFFUHpyNFo5NU5wTzVlK24x?=
 =?utf-8?B?ck9FbVFpWUEveFFOQkt1NGdTWktINlJuc3lRckZKSFR2eGlSWjk3d2pxcHMv?=
 =?utf-8?B?ZENHUUZVMnhJRmM5QzREejN5NWN1RS9uRGRyUkVZREFmUVRoS1RCRkR1bW9Z?=
 =?utf-8?B?bHZMTjNjWitDQXRtNnBmVUxEVVpEYVFZdHJhaTRNT0NEQ2d5emZ5UXNXWk9C?=
 =?utf-8?B?dHpPMGJWelkra3ZXQ3NpKzNJMW9ORlV6UXk1bndkRVdnbkRnNGFiWHhwWjZ1?=
 =?utf-8?B?Z05SSUdDZ01TUTV6MytsemRWQUtwS0NyZjM4L1ZCZFNBTlljRWQvR3RuUTF6?=
 =?utf-8?B?a2dUMTdwMlQxTkwvSGw1cHdwN0lYQlhXN0YxQU9QSFRYY1dEczR5djI4V2hU?=
 =?utf-8?B?STlRYkdOdmUrcVRJUS9PTmR5ZlgvTWkyYjdqRWhxa3VJa21uOGFKTnFGRlRU?=
 =?utf-8?B?cmtFU2VPajRMRFpGR1p4WW5WWDlybmJIM1pucDBGRGE5VkVZa2h4TFMvUll3?=
 =?utf-8?B?dmxGVERreFZMdGhCQTZKbnBDNjFualRLRGRwY0RNbDB5bHl2SmFqMUNuRVJL?=
 =?utf-8?B?cW1uUXZBbktNTVhYNEJlUUgyYy9XelhtRmRSeW9WaEJHVVhCOUlhRjJVSzNX?=
 =?utf-8?B?SEFETnNPakYwdC9oMnY1cjh0UklUQVBrcmhJZUVmOWFLWS9XOURkYWRLZGds?=
 =?utf-8?B?WUxEL0xYZjF6aTVXaCtKcEdrblplQ0IrSWZUaUI3cWtpT1ZiWjdUb2ltUDJE?=
 =?utf-8?B?bldyNzZPVWJMblRPVVNNNWhraUdxVXJqd3lOeVNYdkVUaVlUa0JnUHMwNFYr?=
 =?utf-8?B?ZlJGS1BiaUZjWTdxVkoxa1Ryamx6VHc2MHoyRHV5NFJ0NFJVTml3TklrTE9Q?=
 =?utf-8?B?M2g0aDRPcnkzeHdWUEJXbGVXS1NOc3djc29kR3NtbkJaeWZ6bUJKVUFNM01R?=
 =?utf-8?B?WkhjK002NGQ2eTBzSlo5RFVTYUVTTXl1cUtEeUF5ZHR3Y0xCejBmZjRMY0Z1?=
 =?utf-8?B?N1ljODQzSS9yNXdqK2daSHdmS1VycXJGeEV0aS8ycHgvU1d1RXV3VnB3cHNN?=
 =?utf-8?B?UFBUb25VVXFUM0FWSDU5MXdvRlVUTjBnaWZCUVdRZ0htbW1VU3pFRlJxR0ta?=
 =?utf-8?B?Y25ZZU1nbmFVOVEzQUE1cFRqcGpXSTIrOWxmVC9KbUVQTVJYM2ZXVE00UmI3?=
 =?utf-8?B?eWRRYW5RU0lJL09VZjZXcjhsRHlISlc3K0xKN1dGSUZwM2hhWStwaUc2cjhq?=
 =?utf-8?B?SlVTR1NYbGhQUTRycVNHenc1ZFZMY21jQ0NiNjRRbUVQbTBwbnNqQU0vQUN4?=
 =?utf-8?B?clVnanVJZUxON1JrL0M3bjF1MTV4RTh4MDA1ZlBxSUlOVEhxeHZNZ1VramJz?=
 =?utf-8?B?blNNMGdmVGc1UlprUzdZNGRKUTZvVEx6TnRJcXJIRGRCckFheDlzMkUwYThF?=
 =?utf-8?B?MDhQRzZDZlhjUkd1VTBMdDZreDJMWFJmQWxiS3Jwcm9Uc3A3czlMbmNiU254?=
 =?utf-8?B?aGdZL0JuSmNka2txa25ZZkxicGJKelVHU3NiNTMrcE1QR1lyT3hRU2EvQjU1?=
 =?utf-8?B?RlBMeCtGYVhtOHdmYjJueTFhZ2dZcVN1UHJNT2p4UENiSXc0c1hLcDF0WmJQ?=
 =?utf-8?B?Yk5lTFFMaGpQKzhiTDNDcGpoZ0RYNjRuaWg3MU16WGtLMURlMTVjYk91VHF1?=
 =?utf-8?B?cHpDekpUMjladjRzY0pJNTc1NWVQNHdTUzFuZGJhREhlb1dNajFVZmVGQldP?=
 =?utf-8?B?R3BWc3Y0K1h1aWlVaCtqYXV5aXZwTGFSODNhaE92aXdLUzRjSFdjUStkekRo?=
 =?utf-8?B?ZDNwSjZpVGNnUTlDclRZamVSYSsrbno0WUpNb2ZkSFNvamNPaEQxTkxyVG02?=
 =?utf-8?B?ZjZVd202Q3BLbjNCV3huVlpsbG5EbDRabFIzck9NR3dmN3kyQkMxb2JiYzVa?=
 =?utf-8?B?azhOZVdaOVVZbG9ZT2IrOE5mRUx3YlVjZDF5QkJCTnd4WXZ1dzBCT2JzQ1Zm?=
 =?utf-8?B?cTIwdkUxVWJZdDd3dWlWMnZURGNuczBnQTluRjdBNlBzaTBXY0VNdUpRSWxB?=
 =?utf-8?B?ajEwajVtTWY2UUZjUnMxekVybmN0RVJZRkFOWE5RbWN0L3h2NDZuOGp2U1F1?=
 =?utf-8?Q?kEGLDrm8Osk1P7Vk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <552F7CA01003C44493787082F516A6D8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DR3hKItz3sqTufUX/+jXfrO9dM0y0uBej2kJ3e7bY0nYhPvaEvXvTn2x/FNFFCuZgjEx8N37vU1c9RFPZb++8YcZzcsQIau9WEQ5S4UkdDzZ2T+QZSmEoWl15ET1iBaW8nxfRwys8R7oo8C5KvB5CGQLXD/He5JQ6LUkjktUpF8KcxyY+QBPwD3LGJoJmkJHb1mPEML/zdwcL4WwubF1JWbYXMaKNPn/c2TpODgROyT98+GZwWI24TY/p54VK/qhAU+6SUJkisO8r/6we4HSxttM5PKdqhiCc4QJMMI9Z3smtzqooo31P5IpfSjDEj+Gi87NIGA6gqql7AY+ej5EnQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d679b0d-94d6-4833-55d3-08de90049372
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 15:37:26.0910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1yf181Sg1vz2eL74Q6Tmd3xADAPSlFNIcCjbdDojQL+8URlK/2uGra/4LnSJiuWETE5J2FeS6xuSaNsl/3OKBT6ik/YZBapYworsFMD5Lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9605
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDExOjEwIC0wNDAwLCBQcmF0aWsgUi4gU2FtcGF0IHdyb3Rl
Og0KPiBTTlAgbGlrZWx5IGhhcyBhbiBhbmFsb2dvdXMgaXNzdWUgdG9vLg0KPiBGYWlsaW5nIHRv
IHN3aXRjaCBzdGF0ZXMgb24gcmVtb3ZlIHdpbGwgY2F1c2UgdGhhdCBSTVAgZW50cnkgdG8NCj4g
cmVtYWluIHZhbGlkYXRlZC4gQSBtYWxpY2lvdXMgaHlwZXJ2aXNvciBjb3VsZCB0aGVuIHJlbWFw
IHRoaXMgR1BBIHRvDQo+IGFub3RoZXIgSFBBIHdoaWNoIHdvdWxkIHB1dCB0aGlzIGluIHRoZSBH
dWVzdC1JbnZhbGlkIHN0YXRlLiBPbiByZS0NCj4gaG90cGx1ZyBpZiB3ZSBpZ25vcmUgZXJyb3Jz
IHN1Z2dlc3RlZCBieSBQYXRjaCAxIChpbiBvdXIgY2FzZSB0aGF0J2QNCj4gYmUgUFZBTElEQVRF
X0ZBSUxfTk9VUERBVEUgZXJyb3IgbGlrZWx5KSwgd2UgY291bGQgaGF2ZSB0d28gUk1QDQo+IGVu
dHJpZXMgZm9yIHRoZSBzYW1lIEdQQSBhbmQgYm90aCBiZWluZyB2YWxpZGF0ZWQuIFRoaXMgaXMg
ZGFuZ2Vyb3VzDQo+IGJlY2F1c2UgaHlwZXJ2aXNvciBjb3VsZCBzd2FwIHRoZXNlIGF0IHdpbGwu
DQoNCk9oLCBJIHdhcyBqdXN0IHdvbmRlcmluZyBpZiB3ZSBjb3VsZCBqdXN0IHplcm8gdGhlIHBh
Z2Ugb24gYWNjZXB0DQpmYWlsdXJlIGZvciB0aGUgY2FzZSBvZiBhbHJlYWR5IGFjY2VwdGVkLiBI
YW5kbGUgdGhlIGlzc3VlIGludGVybmFsbHkNCmFuZCBhY3R1YWxseSBnbyBiYWNrIHRvIHNvbWV0
aGluZyBsaWtlIHBhdGNoIDEuIFdpbGwgaXQgd29yayBmb3IgU05QPw0KDQo+IA0KPiBXb3VsZCBp
dCBub3QgYmUgYmV0dGVyIHRvIGhhdmUgdGhpcyBpbmZvcm1hdGlvbiBpbiB0aGUgdW5hY2NlcHRl
ZA0KPiBiaXRtYXAgd2hpY2ggd2UgY291bGQgZXhwbGljaXRseSBxdWVyeSB0byBhY2NlcHQvdW5h
Y2NlcHQ/DQoNCkl0IG1ha2VzIG1lIHRoaW5rIGFib3V0IHNoYXJlZCBtZW1vcnkgdG9vLiBTaG91
bGQgdGhlIHVucGx1ZyBldmVudCBhbHNvDQpzaWduYWwgdGhlIGhvc3QgdG8gcmVzZXQgdGhlIG1l
bW9yeSB0byBwcml2YXRlPyBJZiB0aGUgVk1NIGlzIGFjdHVhbGx5DQpub3QgYWRqdXN0aW5nIHRo
ZSBndWVzdCBtYXBwaW5nIGZvciBhIHVucGx1Zy9yZS1wbHVnIHRoZW4gdGhlIG1lbW9yeQ0Kd291
bGQgY29tZSBiYWNrIGFzIHNoYXJlZC4NCg0KQnV0IGl0IHJlYWxseSBzdGFydHMgdG8gZmVlbCBs
aWtlIHdvcmsgdGhlIGhvc3Qgc2hvdWxkIGJlIGRvaW5nLg0KDQo+IA0KPiBGb3IgQUNQSSBoYXJk
d2FyZS1zdHlsZSBob3RwbHVnIEkgd2FzIHdvcmtpbmcgd2l0aCB0aGUgVUVGSSBzaWRlIG9uIGEN
Cj4gUE9DIHRvIHJlZmxlY3QgU1JBVCBob3RwbHVnIHdpbmRvd3MgaW4gVUVGSV9VTkFDQ0VQVEVE
X01FTU9SWSB1c2luZw0KPiBFRklfTUVNT1JZX0hPVF9QTFVHR0FCTEUgYXR0cmlidXRlIGFuZCB3
b3JraW5nIHRvIG1vZGlmeSB0aGF0IHNwZWMuDQo+IEnigJltIGxlc3Mgc3VyZSB3aGF0IHRoaXMg
ZGVzY3JpcHRpb24gZm9yIHZpcnRpby1tZW0gd291bGQgbG9vayBsaWtlDQo+IGFuZCBpZiBpdCdk
IGJlIHBvc3NpYmxlIHRvIGRvIHRoaXMgZWFybHktYm9vdC4NCg0KDQo=
