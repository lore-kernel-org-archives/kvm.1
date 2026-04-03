Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796BB37BE78;
	Fri,  3 Apr 2026 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775212661; cv=fail; b=SAZp8mvJk2E5+oejYtpzyTnj8+W85GoIoMncCf8zHCJi2sYw/aUIwuleSasE8V6l6SCS8FlfyvdWWJyduVsCCPdhHtmQjUrrt2XpzDpBIdXIezuz1PseEH58C7ubvPuP2D7vc1vLuVREtQiRdU4xXyxfsQVnKFr9JaGepIwRFE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775212661; c=relaxed/simple;
	bh=Elu+A/Qr8gpDKJ+H6kCHO9yGXFnIgThFE4m/YneQMnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PKq7Rl4E7n0PBvxx5N1iEIAmr+troz6Rn+Ex9GQIvoc4Wk2SdGtwRiBi48BIUiAvUTUrNO/FEEYlw8p8Eh37hlAM226QP5Xp3FWM5Er+CwcLJxIKwSnxVlesXBWiJWENE8XvtFscIPMA4xGHKuKJ5PmigAw6AGSg59K+XiE2u4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFpp3B+z; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFpp3B+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775212660; x=1806748660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Elu+A/Qr8gpDKJ+H6kCHO9yGXFnIgThFE4m/YneQMnM=;
  b=dFpp3B+zb3XUYr0LoH4EQmWKwG+DtW0zTOe4pJfkedHX+vxa5A9C8I9u
   7H82bZeDQaxAxS8w6Hk5+DHYehP97c/pZRExy2x0elz1rzkg7p6/O7qZy
   w8fZXkbO3nIO/uTe3oTjdq/lPoqLpP2XVNO2t2qSlkjQyfHgdMmspPvsE
   8nu4sSze7mn77lGehz0ntXlfgAAWVypWfU9r18UJpb/EWexpSHMiuUELu
   +E8CzGpibmG9e0py4JJaN2UUfDyevCJVQNNVuOzD1XN3ZuQRnHPIsgshE
   zPi5tS/dXdmUOwfPPjqS0vHOGBUnL8nGbSL/dxHJTdwUjYB37ZsAn++R/
   g==;
X-CSE-ConnectionGUID: ZQFP6lnjSQmc41kODLhyzA==
X-CSE-MsgGUID: 9Jh8Pu9FTVmVd97eSdpyHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="86575942"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="86575942"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 03:37:39 -0700
X-CSE-ConnectionGUID: KELfGAsSQ8u9TjiC3xyO8A==
X-CSE-MsgGUID: DBIJHxHeT7qYWtWdKp/y5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="228851345"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 03:37:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 03:37:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 03:37:37 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 03:37:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eznwkKogVBcviQKztE+k/GwgvURfr6n+HnbsxenoXwPnn4EvMFtE9ReGzbLCMVmkOtSaUwYHqJXsItk011g/j7nTrPkp/hZDej9EI6BAwCqScVda8AgAj6mUpTB0w9/Kff54FLTGy50gkZ7OwIkOZi4Ki7UddeV8rguxD7Jh2QrQBIQvXog/LsDDTf/rOT52s8T51zyDzTyBPPkFwfrWp5jx7R2OlvlhLDhYaeaZb2LFMz6ogVNf7F+xzOPnGRi7+svmTGMeI/GoIqHtaa1k8L7jDwekXpf7dXzMUGhkTZ6PwNCegNDAnnuNCZ/s8IRLQZw3E4PTIU8ubjzq/136Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Elu+A/Qr8gpDKJ+H6kCHO9yGXFnIgThFE4m/YneQMnM=;
 b=T0p5iNLTT6/c9TBXQH3UNEM9tMZYuPUUM0UdY1JTMZWzlaT1rgotV1XhuyOaEhafB6reqNPEf9ok+ZUo7K8IKjqwEy/yo5bhvYdalWLyJZ6aeytOQLo5kasSy1yn44Fmu48NAP+VCKhDORudxeD5IItckbCrN51eDv2QE2W+Sm5Y2tyyEHbTviY5/acTa/fnloBFFwui7MzvUtnbSREGSiqmb1F9f879U9Jh+Tde++fq1fcAkSYBL7xBOaH8iQ3iJ+Kj8NJyGsXHuKLMJMyPV1SAxcvMsIb5OC03ltuy7vFEoAJeMGFnSeuL6sJa30DXc9nfqe1zgh4IFzSK9Z6cyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB9495.namprd11.prod.outlook.com (2603:10b6:208:59f::17)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 10:37:34 +0000
Received: from IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::7e17:f6fb:7cf6:aa44]) by IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::7e17:f6fb:7cf6:aa44%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 10:37:33 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "prsampat@amd.com" <prsampat@amd.com>
CC: "bp@alien8.de" <bp@alien8.de>, "marcandre.lureau@redhat.com"
	<marcandre.lureau@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Qiang, Chenyi"
	<chenyi.qiang@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: RE: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Topic: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Index: AQHcu6KLKDJ99GHWikalNKz+1MbbEbW+PPOAgADQbQCAAHLugIABpDmAgAAlqQCABe0qgIADLEIAgAEXMRCAAJQOAIABIMAw
Date: Fri, 3 Apr 2026 10:37:33 +0000
Message-ID: <IA1PR11MB94952B22F6EB648ED7C1AE3CE75EA@IA1PR11MB9495.namprd11.prod.outlook.com>
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
In-Reply-To: <9b1290bbc1283a2f35bdcd177d27ae7aea89151c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB9495:EE_|MW3PR11MB4620:EE_
x-ms-office365-filtering-correlation-id: 568cf6b7-128e-4029-44e4-08de916d0404
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 6WDVxqkyTWHp2lUVwxWbLYgA73T71wKiOzLlLFWOFQwg5VSglqbEKaOe+akX9nxLbum5QfPhoe4hjKeFY6Q/fummgHdORQJJZ6hXIB7E92V6ee0lgqqkYMks8iTd/eFxqSOjFo5L4Fgq3LzhSbDlB1siqfQEz/dzZl5yVdV/WEGEh21pJz2fk+8D3WJldvA9ng7+KEsmQjrRxqPAy7twnCi4f7xitpl9eMohGzVI1CdufbHfj8ri4h7OgFwptD9pfMt5yeQekOn863DgboOedCYYRptcFx5YPZY+9gCLG0SY6+5zmk05/sGPaP8sicG3cxaW0t2yJdkxIs0ssi9+pdgVU/IxxlBG4HvciXoMio1t9292SjeiYscDQGq/r91+R8smtpq7PNWdV5BSbOnMtKRiBVpFFqF512eSra2iTErVIfkJq8lc3UeFA7qOlABMBDl6UyzSngaSy8XpG7ZlJTTQ04On9GpyG9OgLOA0YFlB6/Fdu9nnCLJl2QDpgqSaUBr3qm622j1lvlnime5iomd+WkSlO3+LaUdPs10oHyQxOllSOXh0Lwd9Byt6bKGK3pktIkaO40zdGmI1yGG+jtik+iO/5Hokl3vXDDj9cs0soWusJEa5QXVYgaP4bTXHCJ8INTozrN9lywJBHUx1lFLLS9VeZ0crqnU9BLHhoEdqZWQZDLWzjMtt4FdaezWjljEIYfQne75vThCEcPws9upt0kBG17oM1YHNd417OWVVfFPJ6hI5BhugM9Qf9HHruT1bSHUwrp3/2vcec9hK6jMJCXPC0t2pgbjL1q+mTA4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB9495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFhybDU5NEdDQ0xwTkFPbTVjQ0dXMGlPZkxGTUg3dUhhV3czckk5VHEwekpl?=
 =?utf-8?B?Qm9MVElOOGM5dUJsTStBVHdPWlJRWG9kNENwc2hpbkhWZUZUZlc1UEF0OHVT?=
 =?utf-8?B?c0JxdEUxRklLcTR2ZlRWSE4wYnVJRWYzWGFsMmVuY3Z4V20wL0pNWU9kSUJV?=
 =?utf-8?B?R01DUzZHd3M0WDl4TUptMFBwelVRaUo1M3dCWlRHc1UyNi84WldDbnlpRk01?=
 =?utf-8?B?U2pzeUVHcXhNbXcxQjN6bjJQbWlHVDdIOVhIQjR0Q0h5WFBpdjMvbHY2MUNK?=
 =?utf-8?B?RXZTY2pEZHJjRzNqY1hpN20wMlhrZnU5STFxUktZdU5XczNTMlNlUE0zT0lX?=
 =?utf-8?B?T0dzcVJDVkQ1ZjlRS012REljN0t2TWsyNE9BZXNGRFhaczduYkRNK25vd25L?=
 =?utf-8?B?a0pBNVIxNWNaVm9QOWgrdEMwRURlM2FDOXphdnMxYlluZDZNQ3E2bjU2N0I0?=
 =?utf-8?B?RVVnSkN4RElBZzM5NmM5TkNheUZZdjllOFlYbS96S2RRUWVKZXk2NkVJa2t1?=
 =?utf-8?B?K0JQUmREOEdiZkE3eGpERS91Q1dYUlpqU1c4Njh3aG1rZFAwZTNYNVRLd3JH?=
 =?utf-8?B?K2dlOXdYQjBTKzBkdjZaMmwzNDZiNE9zblFsTVp2ZUt4MlV6c1dPWVJERlk1?=
 =?utf-8?B?OUdDMDVGNVdMVk5TN1ZZWGtOSVRPMFR6c2JURUVJWkxFcEVqeXFCQ2J6NXFu?=
 =?utf-8?B?Q0YycXBZbGpZRFRHTGx2TmtTcUpUOVEyTnR4dFBTY3NBbnZ0NzRCUEpKN0pl?=
 =?utf-8?B?OTF5ei9jSDdJMGtrMXVKRlc1V2U2ckYwWkoyUVFlV0ljdjI5SEZNWFZtWkR6?=
 =?utf-8?B?U2Jtc01HTTIzVWVxQStrZFhqeGd2Q0NDL1NuRm1RSVpWQ0VuWGh2Tk8wZTlP?=
 =?utf-8?B?a1Zsc2I2K00vaWxVNzkwWEF2QldFbWVuaHkxSndMUHJhbVJ1WFRHWlJwRnNK?=
 =?utf-8?B?b3B6MVUvLythTE9QY1NBUFNRaUJZL0NnM2xxMTF6Q3M5TWJyQzJKbzdzdVNJ?=
 =?utf-8?B?SlRXZ296a0U0eXBHRDZGREd1SWE4UlkwYnpWU3pwZHE2bjFYZ2hjRFFseStI?=
 =?utf-8?B?T1ZqbGRwTDVzZ21NamVWdFNNaGpyOHlYZEI1TE85NFNMaGM2NUFNOWtIVU1x?=
 =?utf-8?B?WU42azZwaEc2c0JUcUsxc1o5UmN3M2ZERnprdzJwN0ZRQ25pOTREWEh5QmNz?=
 =?utf-8?B?ZWJvcExGOVMyUUYvMStVcnMvMGNobDhGQ3BvUjdyVGFOTHh2RmlWSm9rc3hC?=
 =?utf-8?B?RUdQdWwrUFdjeU9oWjhaK0l2SFUyUjZiWndEaElzK0Z2WkFJc05sVFRCV1ky?=
 =?utf-8?B?MTNKTmhSd1ZZNVphL0t6SW9yL3BRbVE5SExXWFFaWUlERXc0bWpqMzdRVkFv?=
 =?utf-8?B?SUdPZTVmVFlUMUNFYTRwUFBDODZzQi9FcEJ5WUExd3ZWSjkzWG5QR2VpUlJh?=
 =?utf-8?B?MUlWODFGRkY2bzhobFN6RnJlQVFWcHhUNHFrM1hMU3doQy9uVXE2ZFFyUFJh?=
 =?utf-8?B?MG9Ic2NyV0RtNUxWNDJuR0o2c1BuVjRDS2grRW5CSmo5enlUN2NNUTFuNmth?=
 =?utf-8?B?VXM0dW5XQUxQaFBsblRqUlBxK2NVOUdDTlI5aDk4c0JxZm1xSEFVQjBCUHJ0?=
 =?utf-8?B?UFJER2o2djNKbEV0OFB0bStvalVDeU9kUUduSkMyT0N6UkFZeEpxaVpvT3Rs?=
 =?utf-8?B?TzRGL1NmaDV1VTFDQUdHZmh6RGFvR0tvTEt3Y3VaLzVFQTIwZlJOc3RTbjZw?=
 =?utf-8?B?b0Q2Yk9IeUw3NVpjQTVnY0tVRXRKaTZpSGJESHVJNkRoK080cm5rNTZrSDVm?=
 =?utf-8?B?eEVoenArakttV2V2WkV0L1JIUlVKVU11WmpSWFJvNjhDN3BHYzQyTDZhaW5K?=
 =?utf-8?B?T1ZyZG5yVlUyMVlzQzVuK2lqWnplcGpHSk1Na1k1WTlEMDVQRDVUa0d3dW9w?=
 =?utf-8?B?SmI1Tk82OEZCUHhNeDVrN2x4bEd3bzFxMnNNd3dhTzJIWVF3TzdkcThXNE45?=
 =?utf-8?B?N0xjME5ScFFVVU5yN3NnUmpiRDFsdmxtSlJDSXJVa1lCV3JJRi9mZmNFUkw3?=
 =?utf-8?B?NU1GOUdxSjR1OFBxQjlUYUNLMmlpaVg2NTRIcXgvMnVCSWhWejVkMG1FOXFV?=
 =?utf-8?B?M3J4VlVRVFhRaEdjSkZDLzBoL0t1YVc3RVhnQjVWejlXaW0vNVJ3alZSREov?=
 =?utf-8?B?cms5QjVDOWhoODdSWks3VjcrUnJNQmFRQXVsQ3FkNXY4SmRpZ0Nwd2tTWVMw?=
 =?utf-8?B?TGltNkptTnppOGs5NE5odUFNL0ZxUk8yWFBrdVRTSUxDM1V0ellPeml1YkJs?=
 =?utf-8?B?RGcvYWFkMHN6RGdxcmJKb0dIN04xUkE0Sjh4S01pYjFvNmJYVUNtZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vm1Bkw+1qUh3Q/AloZj7RnTB2x//IMa8zPr/d5myfkCPJlLX3ioeisy7JLHrqnEJASpu40WrJ+HRl+tZz3fVMmMrFHqtV10tk+iDBOY92cNeKYhT+FWgsNkJlkY+LowbYnWi3BePf5FKSS2rnahyT34lABeSZ62TbJK7EC5fxzTOv3cII8mSdnxjXlbq5CMZyqdwJmPcz1KvKykhPNWckipl/6M0Nlp7U9l+DMugvL+6SCLdGVUwxBFmnh6lbbJ483oJSRA+RjHDIySL/xOFQLXUxEM/w5NAlhFXk6HKMLwGAc5uW/8Xvhkh/vmM33XMjh2BYq8q4O4O8rLwcrYovg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB9495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568cf6b7-128e-4029-44e4-08de916d0404
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 10:37:33.7652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYDNSyEWDFwxPQJay5pwXhKCI60nZKigNGdYdfgxOVTI5fHueb6c4WVhIl1gYk2UjY9tLZdkse/HoX2+IJOC+BzQQRx6R/iEOKwKzWReJxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com

DQo+IE9uIFRodSwgMjAyNi0wNC0wMiBhdCAwODoxOCArMDAwMCwgUmVzaGV0b3ZhLCBFbGVuYSB3
cm90ZToNCj4gPiA+IE9oLCBJIHdhcyBqdXN0IHdvbmRlcmluZyBpZiB3ZSBjb3VsZCBqdXN0IHpl
cm8gdGhlIHBhZ2Ugb24gYWNjZXB0DQo+ID4gPiBmYWlsdXJlIGZvciB0aGUgY2FzZSBvZiBhbHJl
YWR5IGFjY2VwdGVkLiBIYW5kbGUgdGhlIGlzc3VlDQo+ID4gPiBpbnRlcm5hbGx5DQo+ID4gPiBh
bmQgYWN0dWFsbHkgZ28gYmFjayB0byBzb21ldGhpbmcgbGlrZSBwYXRjaCAxLiBXaWxsIGl0IHdv
cmsgZm9yDQo+ID4gPiBTTlA/DQo+ID4NCj4gPiBJIGRvbid0IGtub3cgYWJvdXQgU05QLCBidXQg
aWYgeW91IGFyZSBwcm9wb3NpbmcgdG8gemVybyB0aGUgcGFnZSBvbg0KPiA+IGRvdWJsZSBhY2Nl
cHRhbmNlLCB0aGlzIGlzIG5vdCBncmVhdCBmcm9tIHNlY3VyaXR5IHBvdi4NCj4gDQo+IEFjY2Vw
dCBkb2VzIHplcm8gdGhlIG1lbW9yeSBhbHJlYWR5LiBTbyB0aGUgZ3Vlc3Qgc2lkZSBvcGVyYXRp
b24gaXMNCj4gZG9pbmcgYW4gb3BlcmF0aW9uIHRoYXQgc2F5cyAibWFrZSB0aGlzIG1lbW9yeSB1
c2FibGUgaW4gYW4ga25vd24gc3RhdGUNCj4gb2YgemVyb3MiLiBBbmQgdGhlIG9wZXJhdGlvbiBj
b21wbGllcy4gV2hhdCBpcyB0aGUgZGlmZmVyZW5jZT8NCg0KVGhlIGRpZmZlcmVuY2UgaXMgdGhh
dCB5b3UgZG8gaXQgaW4gYSByZS1hY2NlcHQgY2FzZS4gDQoNCj4gDQo+ID4gIEl0IGNyZWF0ZXMg
YQ0KPiA+IHByZWRpY3RhYmxlIGJlaGF2aW91ciBwcmltaXRpdmUgZm9yIHRoZSBob3N0IHRvIHpl
cm8gYW55IGRhdGEgaW5zaWRlDQo+ID4gdGhlIGNvbmZpZGVudGlhbCBndWVzdCBhbmQgaXQgY2Fu
IGJlIG1pc3VzZWQgKHRoaW5rIG9mIHplcm9pbmcgb3V0IGENCj4gPiBwYWdlIGNvbnRhaW5pbmcg
YSBjcnlwdG9ncmFwaGljIGtleSkuDQo+IA0KPiBJZiB0aGUgaG9zdCBjYW4gdHJpZ2dlciBhbiBh
Y2NlcHQgc29tZWhvdyBpbiB0aGUgZ3Vlc3QgKHZpYSBzb21ldGhpbmcNCj4gbGlrZSB0aGlzIG9y
IG90aGVyIGlzc3VlKSwgdGhlbiB0aGUgaG9zdCBjYW4gYWxzbyByZW1vdmUsIHRoZW4gQVVHIHRo
ZQ0KPiBwYWdlIGZyb20gdGhlIFMtRVBULiBUaGlzIHdpbGwgcmVzdWx0IGluIGEgbm9ybWFsIGFj
Y2VwdCB3aGljaCBhbHNvDQo+IHplcm9zIHRoZSBwYWdlLg0KDQpZZXMsIHRoYXQncyB3aHkgdGhl
IGd1ZXN0IGN1cnJlbnRseSBkb2VzIG5vdCBhbGxvdyBhY2NlcHRpbmcgYSBwYWdlIHRoYXQNCmhh
cyBhbHJlYWR5IGJlZW4gYWNjZXB0ZWQuICANCj4gDQo+IFNvIHRoZSBwYXJ0IGFib3V0IHdoZXRo
ZXIgYSB0cmlnZ2VyZWQgYWNjZXB0IHN1Y2NlZWRzIG9yIHJldHVybnMgYW4NCj4gYWxyZWFkeSBh
Y2NlcHRlZCBlcnJvciBpcyBhbHJlYWR5IHVuZGVyIHRoZSBjb250cm9sIG9mIHRoZSBob3N0LiBJ
LmUuLA0KPiBpZiB3ZSBkb24ndCBoYXZlIHRoZSB6ZXJvaW5nIGJlaGF2aW9yLCB0aGUgaG9zdCBj
YW4gYWxyZWFkeSBjYXVzZSB0aGUNCj4gcGFnZSB0byBnZXQgemVyb2VkLiBTbyBJIGRvbid0IHRo
aW5rIGFueXRoaW5nIGlzIHJlZ3Jlc3NlZC4gQm90aCBjb21lDQo+IGRvd24gdG8gaG93IGNhcmVm
dWwgdGhlIGd1ZXN0IGlzIGFib3V0IHdoYXQgaXQgYWNjZXB0cy4NCg0KWWVzLCBhbmQgbXkgcG9p
bnQgaXMgdGhhdCB3ZSBzaG91bGQgbm90IGFsbG93IGd1ZXN0IHRvIGZyZWVseSBkb3VibGUNCmFj
Y2VwdGluZyBldmVyLiANCkZvciBhbnkgdXNlIGNhc2UgdGhhdCByZXF1aXJlcyByZWxlYXNpbmcg
bWVtb3J5IGFuZCBhY2NlcHRpbmcgaXQgYmFjaywNCml0IHNob3VsZCBiZSBleHBsaWNpdCBhY3Rp
b24gYnkgdGhlIGd1ZXN0IHRvIHRyYWNrIHRoYXQgbWVtb3J5IGhhcyBiZWVuDQoicmVsZWFzZWQi
ICh1bmRlciBjb3JyZWN0IGFuZCBzYWZlIGNvbmRpdGlvbnMpIGFuZCB0aGVuIGl0IGlzIG9rIHRv
IGFjY2VwdA0KaXQgYmFjayAoZXZlbiBpZiBpdCBkb2VzbnQgbWVhbiBwaHlzaWNhbGx5IGFjY2Vw
dGluZyBpdCkgYW5kIGluIHRoaXMgY2FzZSBpdA0KaXMgb2sgKGFuZCBldmVuIHN0cm9uZ2x5IGRl
c2lyZWQpIHRvIHplcm8gdGhlIHBhZ2UgdG8gc2ltdWxhdGUgdGhlIG5vcm1hbA0KYWNjZXB0IGJl
aGF2aW91ci4gIA0K
