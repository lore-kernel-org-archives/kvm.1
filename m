Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19937188B;
	Wed,  3 Jun 2026 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487520; cv=fail; b=LqjnoHWdZO4ZSX6AtzwGm6IyDSgn3D6W9Xl0w5FT9c7xDFCOg2PAikzTgsmeJZPh/kK/eXbawvmCM1h15Q4cI1MssVGtFFqcZx3JdhBrozVNc0M8iF0D8oTozMnt5BMLNL+jpWXgqpTO0mgRT8TD0BJLjbt30IKLK2me7rdkqVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487520; c=relaxed/simple;
	bh=mM8j7KJnd05LUMzhuL6bnmIH+GrEybmZeS3FLXtir5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WI4Y84jkhzFYpeXM2cn7krJqnzoBNpFaSb5CPaB46ktnPTP3ouZaZmKTKGN2Bh+8+E/Fiq3RlucffzT9lW0S4iglDbFjIahgndqSOsp6nS5eOkG456wxmbdkHrlQdogo7Q9KWLUFH89KWY1bTd5Rs8hNB/bChqBVSiu6IbA2ivA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBskxnfq; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBskxnfq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780487518; x=1812023518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mM8j7KJnd05LUMzhuL6bnmIH+GrEybmZeS3FLXtir5A=;
  b=aBskxnfqzwEvmhHYevSgUHrZv7mJQ/U7fyMuwWcpDWenMP4p8CuJX89J
   g0iShqzYQ3fXzQVvlc95v6Ea6kBrwgOijbqSeWcV/czeumkLLNql4wmHc
   sj3Z9lJlj/SRRW/K4MZT0ZtTZzLrFeOXzzTj4djhjQzTS6O+p880lwAUV
   l5qU78+sn1g0Yk9E/zeocGPTtRCWbuQUhPvd4LTIbS5ITP3aXgZ98tuLo
   jdutAeP6v/aTiD/iXVLddNlZ49/J5JOBrWkPIRmCPhqsYFvazBxybCGd2
   KGl7AaqoyBVmvKpHa55joN+TGblFRc7ZNICjLmBcFbQjF5GdLmsoYe7wN
   A==;
X-CSE-ConnectionGUID: 9dXfp6IWQ+OOxesgGthZJg==
X-CSE-MsgGUID: SKx+K1EbQPmBUW03O92xxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81325119"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81325119"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:51:58 -0700
X-CSE-ConnectionGUID: H0mBAhhiQCmgjKwv23AlOA==
X-CSE-MsgGUID: o2U+TnQCRIebIU1i/2cWQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="237853016"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:51:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:51:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 04:51:57 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:51:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxePoNTcSgqpztkKiHwuqdDrMeAB+wE2T5J4194MD3hHSA6OO9FZv0R1+sSlTeNygvcoKQgjfWKhtCrGdOGsBmlttZY9oR5ePrNcDfy4Q8NjCihL/hFL79Y8FJ36vZ9cJ+VMJmQVJNNnuoscWHh+P71HQrHisMMZWR3mC6+1MwSnFwrX6rZCY/UsuXaeFpjUtNirsy6/qHN6pUDqDMdpBotdJm3O5IiN3sFYhh1n3zPmYm8K/XAsm9paS7NLytT5v/lCdJTHzHKu78zdJ8kT7wiVONATtKeH1xY4v7EBnVkdjSczURwjrV5Im9/sEQoETUj8zLjvj9z7isY7iJMDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM8j7KJnd05LUMzhuL6bnmIH+GrEybmZeS3FLXtir5A=;
 b=Q4hCs/BFD7qgPiVUvfR4Z95kmyt/0RFYmzTKUJiID0FVpLPN3exAe9rShwx2vEF/egpJlISBEFVPTE3xDKhtOIqGr+eCcxtuq9bB/nZe7/os8/iqp9n0/cJnfCmi2c1lk35JJx3+h3Ba2hkRuod5OaMzNTFAZoqEAQ411n1WARJGrH2BIIiM/lE8ytXPgX8Ed6OP2La+vRuqtKQ+udXLnraEzczZPr8cas2w8yl1wStiJSl+JG6T4sif2M6hqoGo0z9A7cWLUl7nR/TQ3rHZDVr+y5z+GSJaUB/ADxQNj+9Qxp55t2T/7AP8bOO7SVNohb+GHaPJuQFhJSLIxmMD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 11:51:49 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:51:49 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 18/40] KVM: x86: Move kvm_caps and kvm_host_values to
 asm/kvm_host.h
Thread-Topic: [PATCH v3 18/40] KVM: x86: Move kvm_caps and kvm_host_values to
 asm/kvm_host.h
Thread-Index: AQHc77m/UJueFTngkkqdBbrSfn4L4rYsv0KA
Date: Wed, 3 Jun 2026 11:51:49 +0000
Message-ID: <6e622e815b431f54dc2a3e9dae37a44e02cea605.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-19-seanjc@google.com>
In-Reply-To: <20260529222223.870923-19-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH0PR11MB5902:EE_
x-ms-office365-filtering-correlation-id: f8d0015a-9096-489a-ad86-08dec1667ef6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|4143699003|11063799006|18002099003|56012099006|22082099003;
x-microsoft-antispam-message-info: PEKWEA8OSBPUvH9fvyN5M7iyBnCN9wI+eXD06Uc+dRp5mmwW2eOsS/IVt3BruDi1mvODF77euqTJBgkbp5cdPfhbWZJ611hBoGBJV7lb/Z2GgZJWnPJHd6INlb3vg7ewAqV8MTcI1zbx1DeGLPai6QVgnaMJBPGJqP4pSjkqI3Z2g1Jf77XCfi4loUw2rkc9P6s0uh+eOSBjT2J94XxLZeVa+/EHxP853VfcqgqzGIkNt6BXo/7opddFqTPeqnNu9RlumJYlXEVp5UKMMv8neiso6ZHgfEecmNQc3lBRkzKGakt11e8FecOJZ5hvV3qwr8kTMI4+sZSfH5zgcWQoBiddXKzqKXQNedyJ7lRttya6dIzh5azsUJ1rSSQkMg8qXjd8g4UtfPkVH2zAx70ABnH7QeUAQB5HJhNQN63lcVU45ckP2bLkBkOQwvaH91EHavBpE7wD0BotRqkMoL+9gRr8Sha8KCRaKXz4MLQVSeKkSsV7i2lLd3we4G9ToBrIGcWBI+py/9W37Dm1GLyErdzzY7x+r2pFJFJ/XfNL5IORuPaUY++3x3DpZM+1c51UVUpu8ASFh5Pw53tOkLH5bPVZ9JeokTbrYMhAb3GRzDwD9Aul4KWE+0xLieHLs8K/XXjXRUcDFhyqA8jGvry5u2kQnBCHOy2o9bWvo3CMsEV/BgdR9HkDLrKuDU4MNYZAPXVnklZqk9RbpH3lm3SSiQI19up8nJIvN5cI5xTe697y7U2vPuujM/3qu7ndi/Fx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(4143699003)(11063799006)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUdlK0JONTYydmNuR0kvM3gzakFHZ01DR2ZoMlpwaUwwQmxkK1AvbjFSZXZB?=
 =?utf-8?B?RVlUSmxoQTBFNUEyNmdpajRCSnNYQ2g1NU5EdktuWjNuajFtMGNKUEFEaTRF?=
 =?utf-8?B?ZVRHbUZlamJmUnhZVTA1WXB1ZjU0U0cwK1c4YkRCY1JTU1Z1RlJ1QnZ5UzVk?=
 =?utf-8?B?V2JSMDNGc2w0N2l6WDc1SVFZRHhvVUViUEVhRVhrSzByWXVOcTR4WThneXE2?=
 =?utf-8?B?bGZjays5dEl3MzU3eDY5NndZREw0VHl4ZFlhNTAvRmtHb0NOb01NQzMzcGZR?=
 =?utf-8?B?YndyeDJLUlJxSXVFYkxmZlo3RS91OWhlUDhkTVR1dWlYQ1M5eGc1K0tOZDlz?=
 =?utf-8?B?ZzZyNVQrVnRHeWdsUWh0TEJyZmkwTEEzSTlTM3hZMFlqOTJnRjdBM0JwRUQ0?=
 =?utf-8?B?alRkSU5SNGZQTVVoUGNpTXhBNzZITkZVc0t4RzhvZDdnQ01wZjdQcjBUM3pp?=
 =?utf-8?B?RzRSdy9qcDk1cWFwRlprd2tyRkgweXZYODRMMDlCekVwdG5yZlhYUEh3NGxr?=
 =?utf-8?B?NnNxaTMrSm5JcmNqTG14QzByWE9IdXVlRnVrWmtSamgxUFpPdHZWNkl0MElS?=
 =?utf-8?B?VE1CczFBN09TdkFPSXRlVno0Skk2M2ZCcmVLaGs2VElkNmlXZ09yc25uRzIy?=
 =?utf-8?B?ZEEvNzVxdnQzTy95Unc4aDdKakQwMEhYTkJYNnhHTGJidGV1SlJ3ai9Bak51?=
 =?utf-8?B?RUZzZGRYbFdNV3NCLzVFSVVyeXdsVmVKb0dobXlpVHc1ZUhwUXZndDcvWExv?=
 =?utf-8?B?TkpYUllrbHVFNVVjdzRzYXlTamM4N2FVSy9uTzB2cnNPb0tqa3NNZ3g3L1VB?=
 =?utf-8?B?R2tBTnkrNmgybjlKS21QOE0zSFd6ajlWdVlNME9ROEp5MTllM3l0dzBDWEwr?=
 =?utf-8?B?RFlMWjZkeGJCVnlQeU1nZ2RTdkxJYURPdmYzSkR3ZWc4UysxRENFejVRSG1Y?=
 =?utf-8?B?NUpzNHVFT2ZGNDBNTFNkRHluY3pyZmVISjRBRlJMeVVXNWx0elU5YzBXL3Jz?=
 =?utf-8?B?ZjV1bWF3ZWxHZVRCc2FpZDE2c3JXbDU3a21qU3hHS3FIWGYydkhJeXovK1Av?=
 =?utf-8?B?QVlYOXNjUzh0QlB6RFFsdlpEZGlRUVVOc1o0YURRTFdZOGtGNGdVcG80QjlL?=
 =?utf-8?B?WEdYN2ZaMmZRSU9lbGJWRGY1bVRZbWtPaThQMU8vRjVVbEhBL0M5K0s2SXBy?=
 =?utf-8?B?cGpzOWUwMlVCUkV1WDdjRXJyVTQzU3VPY1VuVjJrNWc3UW5MeWhuUXBTS1A4?=
 =?utf-8?B?cmd2YmNTNmVETnpnaGR0WE1mbk5lOHR1ZkMwbWNmYjRTMmd3M2Fra3Z3QlJo?=
 =?utf-8?B?WHd3TFJoVUk3TjBRM3JZdE5RbWpUT1ZxaG5rM1JhZzRtU2hJZFRDQ3hnZkxG?=
 =?utf-8?B?WDBWU0w5SXFlUHZVTFJ6citad0JUemF4V0IzR2grZWZ4Wjh6VVJ0ZHMxTk84?=
 =?utf-8?B?bHhqNGh1TXg4TTdEbGRJUkdhL0QyNmJuZ1lpanhwa1JjeG04WW9IMDZCRy9a?=
 =?utf-8?B?aGNna2tWcmt5WlRkTWdOaldIckt3UzNIN2xlUVphdGZJbUx5Y0ZEcDQ3SW1T?=
 =?utf-8?B?UzNTSC84OU43MHN1NkZGQ29oTW14aXhzREQ0MXJHMThTMmRRdzExSkxQVG1q?=
 =?utf-8?B?RzBKR05vVDB1VU4vQjVod1pCbys0SXFMSkx0WUxhSTVNNnFhU1luL1BmczBC?=
 =?utf-8?B?SHJGTTFkY1kzbk1HbUNSbG01bHRvVC9yRkNXUWdpNlY1Y3lhckhiZ1hueEFz?=
 =?utf-8?B?THdjb0ZETjA5REhKSGJXb2psWTAyY2VzSmw1OTVCeXZZVUVKNk0rWW9pQ05q?=
 =?utf-8?B?K0ZVLzV1WXlaMzhpVkViUVlqa2hidnY2VHA4VHp2UnJqa1Jsc0Q2Ym04Qkdn?=
 =?utf-8?B?OG42ZFpCclQ2T1c4bnJyd0JzKzlQZmk4TFhlTkwwM2JpZjRXRzduNnJhRXE3?=
 =?utf-8?B?eVZjckVNWDlQeHN6ZmRMZklFMkQ1cDlXczMrWDQ0YS8rNVZ5QWZ1ZmdhY0lL?=
 =?utf-8?B?QlhNcFk5cjYybCtoZm9DUHF0QU93V21UVzVOeE1DbE93REQ0SlRQdDFzUG5D?=
 =?utf-8?B?clpERk5qOWRkUU5acDM4aFBBSDlJSEFBT3F1aU9CRGdncEEvZTYwNWMrUnNH?=
 =?utf-8?B?c3hLSmNrWjFnREYvbk5mV01WNlVNVGZKQktyNlBEOUorS09abzdvL2RzaDdv?=
 =?utf-8?B?c0paTkFGUW0rdG1sbTJKeXlGWGFWbU1wWWJTZjJ0dVFBMmd1MjV6bFlmTmVN?=
 =?utf-8?B?bzYxQTU2MUN4THI1cThiVExsckpjdE1WODU4SkdPZERyeE1QV0ZrZ2Jjb053?=
 =?utf-8?B?MTJTTVJZeVZDZUlxNTlCMWorUDFjZ1k3M252bkFySDhBTkJMd2JaUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9483AC7F3DBC1848A71EBF895125799F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DXcUQPCI6Q37d2tWVR2k/9BhOIXoylt0AiCfKdtrEpweDqt7RI53+lGvG41836bEwSM4RHvvrRwemrpr5wB6Yv8SEQu1clbcYLmumHvdLySVM+cBPMkrKlaDbBvgaD9mc4XBJugT3MAsR5zoT2hL0v45MMYKm935FmFfg4pwdzmw/hC0zYBcCCDlDvj3s4SEJuSTdBrpSnWLajiyKfw9Pma871T4NlOhl775IKfnY7yS4HMAIBsBjLearusdYsF4GiiZO3eG6DxHn5rXTs+RC9WWh+cm7ZPk8Iju5Z0hH/XBQQsR06ijHL+nlnbFXBzlizsFbjVtsjDSDJ3AaVDDSA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d0015a-9096-489a-ad86-08dec1667ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 11:51:49.4036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLJ8hsA0KjX8Pxmer0pUUQQIwdX1hfOyp7iCCzUBz4yoiqOuEX0McLWmnLCD6KMaCDQw5WpGO2bAxZupncMvMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5902
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBSZWxvY2F0ZSB0aGUga3ZtX2NhcHMgYW5kIGt2bV9ob3N0X3ZhbHVlcyBzdHJ1Y3Qg
ZGVmaW5pdGlvbnMgYW5kIHRoZWlyDQo+IGFzc29jaWF0ZWQgZ2xvYmFsIHZhcmlhYmxlIGRlY2xh
cmF0aW9ucyB0byBhc20va3ZtX2hvc3QuaCB0byBhbGxvdyBmb3IgYQ0KPiB2YXJpZXR5IG9mIGNs
ZWFudXBzIGluIHg4Ni5oIGFuZCBtbXUuaCwgYW5kIHRvIGVzdGFibGlzaCBhIChob3BlZnVsbHkp
DQo+IG1haW50YWluYWJsZSBydWxlIHRoYXQgYXNtL2t2bV9ob3N0LmgncyByb2xlIGlzIHRvIGRl
ZmluZSBjb21tb24NCj4gc3RydWN0dXJlcyAoYW5kIGRlY2xhcmUgYW55IGFzc29jaWF0ZWQgZ2xv
YmFscyksIGFuZCBhbnl0aGluZyBuZWVkZWQgYnkNCj4gYXJjaC1uZXV0cmFsIEtWTS4NCj4gDQo+
IFdoaWxlIGl0IHdvdWxkIGJlIGxvdmVseSB0byB0cmltIGt2bV9ob3N0LmggZG93biB0byB0aGUg
cG9pbnQgd2hlcmUgaXQNCj4gKm9ubHkqIGhvbGRzIHRoaW5ncyBuZWVkZWQgYnkgYXJjaC1uZXV0
cmFsIGFuZC9vciBub24tS1ZNIGNvZGUsIG11bHRpcGxlDQo+IGF0dGVtcHRzIHRvIGRvIGp1c3Qg
dGhhdCBoYXZlIGZhaWxlZCBtaXNlcmFibHkuICBUcnlpbmcgdG8gImhpZGUiIGNvZGUNCj4gZnJv
bSBhcmNoLW5ldXRyYWwgS1ZNIGlzIHRvbyByZXN0cmljdGl2ZSAoYW5kIHVsdGltYXRlbHkgcG9p
bnRsZXNzKSwgYW5kDQo+IEtWTSB4ODYgaXRzZWxmIGFsc28gbmVlZHMgYSBwbGFjZSB0byBkZWZp
bmUgY29tbW9uIHN0cnVjdHVyZXMgYW5kIHRoZWlyDQo+IGdsb2JhbHMsIGUuZy4gdG8gYXZvaWQg
aW5jb25zaXN0ZW50IGhlYWRlciBpbmNsdWRlIGNoYWlucyBhbmQvb3IgbWlzcGxhY2VkDQo+IGhl
bHBlcnMuDQo+IA0KPiBFLmcuIGFzIHBvaW50ZWQgb3V0IGJ5IEthaSwgaXQncyB3ZWlyZCB0aGF0
IHg4Ni5oLCB3aGljaCBpcyBhIGtpdGNoZW4gc2luaw0KPiBvZiBzb3J0cywgaW5jbHVkZXMgcmVn
cy5oLCBidXQgbm90IG1tdS5oLiAgTGl0ZXJhbGx5IHRoZSBvbmx5IHJlYXNvbiB0aGF0DQo+IHg4
Ni5oIGRvZXNuJ3QgaW5jbHVkZSBtbXUuaCBpcyB0aGF0IG1tdS5oIHJlZmVyZW5jZXMgc3RydWN0
IGt2bV9ob3N0LCB3aGljaA0KCQkJCQkJCSAgICAgIF4NCk5pdDogaXQncyAnc3RydWN0IGt2bV9o
b3N0X3ZhbHVlcycgYnV0IG5vdCAnc3RydWN0IGt2bV9ob3N0Jy4NCg0KPiBpcyBjdXJyZW50bHkg
ZGVmaW5lZCBpbiB4ODYuaC4gIEFzIGEgcmVzdWx0IG9mIG9kZCBpbmNsdWRlIG9yZGVyaW5nLCB0
aGUNCj4gdmVyeSBjbGVhcmx5IE1NVS1zcGVjaWZpYyBoZWxwZXIgbW11X2lzX25lc3RlZCgpIGxp
dmVzIGluIHg4Ni5oLCBub3QgbW11LmgNCj4gDQo+ICJGaXgiIHRoZSBrdm1faG9zdCBkZXBlbmRl
bmN5IHNvIHRoYXQgeDg2LmggY2FuIGJlIHRoZSAiY2VudHJhbCIgaW5jbHVkZQ0KPiBldmVyeW9u
ZSBleHBlY3RzIGl0IHRvIGJlLCBhbmQgc2V0IEtWTSB4ODYgb24gdGhlIHBhdGggdG8gaGF2aW5n
IHNvbWV3aGF0DQo+IHNlbnNpYmxlICJydWxlcyIgZm9yIHdoYXQgZ29lcyB3aGVyZToNCj4gDQo+
ICAgLSBhc20va3ZtX2hvc3QuaCBob2xkcyAiY29tbW9uIiBzdHJ1Y3R1cmUgZGVmaW5pdGlvbnMg
YW5kIGFzc29jaWF0ZWQga2V5DQo+ICAgICBnbG9iYWwgIHZhcmlhYmxlcywgYW5kIHRoaW5ncyB0
aGF0IGFyZSByZWZlcmVuY2VkIGJ5IGFyY2gtbmV1dHJhbCBLVk0uDQoJICAgIF4NCk5pdDogZG91
YmxlIHdoaXRlc3BhY2UuDQoNCj4gICAtIDx0aGluZz4ue2MsaH0gaG9sZHMgcmVsZXZhbnQgZGVj
bGFyYXRpb25zIGFuZCBkZWZpbml0aW9ucy4NCj4gICAtIHg4Ni57YyxofSBpcyB0aGUga2l0Y2hl
biBzaW5rIGZvciBldmVyeXRoaW5nIGVsc2UuDQo+IA0KPiBDYzogS2FpIEh1YW5nIDxrYWkuaHVh
bmdAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFu
amNAZ29vZ2xlLmNvbT4NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0Bp
bnRlbC5jb20+DQo=
