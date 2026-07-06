Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5067A41C307;
	Mon,  6 Jul 2026 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356890; cv=fail; b=j65PsLxPXHeFfYFTGkaxghc3mWUtgeQN0MAEdlwl0Hl0qjgk/5njjXS2E1HqJ4MQ+2ZnerZLEMkZrG+yHPuix8Osobvq5F2iq+4/Tb/dH2QaqpWsWE5O/rDYcfGuwWxQgrMryyOfBoOOBtMiCTcBwON/yBcS2z2jTn+oJjxWEK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356890; c=relaxed/simple;
	bh=3ZtT08pNtBbw69HVrQv9B/JHeP5sxgZvQcDFWaW1+dc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p3KUrIqKOfIRpVTSZNiF3vr7J88qgjrmZaffjcEPlcsxE+S4McrK05htEoua3sfxWh7cxpQqxOuOHsuz8l3tEfpj1Ei7575uCUSl+cyFjtrKeg9HLj/55Hy9UmKYxHXWOzZCXtNk+KTznCPs+9GYtSERp41YTSIJjDC4w+vbz38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kttewENd; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kttewENd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783356889; x=1814892889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3ZtT08pNtBbw69HVrQv9B/JHeP5sxgZvQcDFWaW1+dc=;
  b=kttewENd3RzsigIOMylMqKfydZ+c+3vTQ+f3887/6c5PssQ2Jn8DkyAX
   RDaQcns4rZn3/aam0+twpttGNRgEa5x8RNr4TTRs7zHiy/wnbtFSrUALp
   bCK8hFBqW7jRRAkN2L2+1A7PD51Xx+oqYnIQ5laQFoelAZzX+GeLbtO+3
   pvW0g8Bb2+tHRFBXikAOkdsdNrurJmQxStM2RLEANO2APdIvO+zBLzPw2
   yAvngbkufZm1W+zXR7JdwTPavGOTPuwBg1zMwyEsFDow6JWdLm1EcpZmU
   M2ov92pnRnnNJ33/Gq+PnfEpXtfAcCa1ZogQqy5jToVu6Z/8z7DaI2+aG
   Q==;
X-CSE-ConnectionGUID: NHtq5xRkTAKjablO37FDwg==
X-CSE-MsgGUID: BQ7W0MPcTgaXr56kDjQNug==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="87818078"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="87818078"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:54:48 -0700
X-CSE-ConnectionGUID: ARfNnTdORRmvGFjvaVvfqQ==
X-CSE-MsgGUID: bTR2JCMfQdmYfhd9UlqnfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="291925760"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:54:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 09:54:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 09:54:46 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 09:54:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s50YYGhsuR5lcoIrOGTxD6/vVGuKll7sDV7c8/AJwdM0vhyOIBOIzJykMNnMNmwslPOQ7zIkAatJKDgl1goYYdlViRTef+MV6TIR5ieYDqJq3cpkk86+D+X7tWC/oOQdt3CwxgEQlgiVImAKfIOkwUJHicOe+XqoLLN30ta/aVXBn5vOc5HuBUsU+qIOnxTJfH4/Yc1fEAvexH3V5aJfIbFSowTFW3G5sn+VuLywAvudG0X9yx9hrjuZo7YO0gJQ4J54ELKcwBXrKN6TgH4BOCl7tLGW97LYVeEepgcv+8bJVHKZe/u4BklLeRn6TxWVkH1rALou3oOPntLvA+YBjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZtT08pNtBbw69HVrQv9B/JHeP5sxgZvQcDFWaW1+dc=;
 b=W1LOoiOM0gUmhMR+wseuGC+qe3u3mW2oWd8pYFFSfEhaqjFc0HWhMdlhnemeqe7434ErMOwkae+V75mc4IfqxPifTstWYy0b4U9AbMFoUABa+R96yJ2XSLUS/v4ZFV0wktj+O6qtCWd9aegyxL425EP1N+EZLYfEgxDtMRAHZFENSuDNqwkwLUycLiBKtkGykA4wTx5u0ZSmWkP6ybx+y6D0Hob5Bw7BdFEPSjjqmMLdMNOtqt2XvV4bNeG9fORSOrxjpxj1IKnD4e2WFzQWyXzusSUTid3fxIwvnWOhvJo2XYDP2HNEsApPYoY0rWVSLWw9K4+on/OIxsWeztdQ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA2PR11MB5067.namprd11.prod.outlook.com (2603:10b6:806:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 16:54:38 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 16:54:37 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "jirislaby@kernel.org" <jirislaby@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86/tdx: Do not print error message on non-present
 feature
Thread-Topic: [PATCH] KVM: x86/tdx: Do not print error message on non-present
 feature
Thread-Index: AQHdCdvPyDDHE2h7Gk6fRpd59pvnxrZgvIeA
Date: Mon, 6 Jul 2026 16:54:37 +0000
Message-ID: <f35e07de78a2e189f585f9cac4ec292331d84bdc.camel@intel.com>
References: <20260702043204.81741-1-jirislaby@kernel.org>
In-Reply-To: <20260702043204.81741-1-jirislaby@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA2PR11MB5067:EE_
x-ms-office365-filtering-correlation-id: 7d7fe10e-d2e5-4026-7fec-08dedb7f4381
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|38070700021|6133799003|56012099006|11063799006;
x-microsoft-antispam-message-info: tw8aC/eVaM37615qk+I8otiQH0VezqLLCH8O4wzg7OIHfaunzlu8wAr/WXJ4e8gTOFrYK53HYg9HUiNhQrVMyfvHIsqSn3SrodvMGb1+NHr16w1j7u6BlEDGOz7BpXHHCEkXeQ03RnX5oVNqqCkVqTyqV7Beqz1/oj6L5aqqlpB0RD+QxHcp8y5BvtMthTdvbb3mMCEGMYWtQDvGo33ZLfDBD47y8/6H+YBAQrc8f2cUgWE7L+kuNErKpndW6FJjsXSBsV475rFgg9NRoosADzM7C/tPVMCLNe67sofo9WWK714wad6DscQaXIQ7eafpk2wXu45R21T/Cb2VCskcRA12iNYfC+2c+sGgl/Sq+DlkQktc073LHSjfem/9cxAl/fWM7bUK8tDU1EeowfkM2QcHqxZygLJWEn8xtobR6tgGG6x4QuDG9mAhcsgPDK6TeKyLBmsq54SWBd+LM7caDlIhx0I49iY3LOXgrsS0rkEouAUn/wW4PfdunTuEJN76533zSBAKkQSl1PJbUZNYF4nXQCKVhXIQj9RtY5YA7eY0JZ/X0Uj6AxnwlliKJZsPN/uI4b77E/bNBIjfrLrp0d4ZWRUkP641MIzTuxWHQnTF57YhzegleUm8PTypuyXs70ORQGZ5MVp43ek5y45HI4ytyF31xt4krJkp9a0SRNKiC93M4Xca1g4qjWu3Kqt6JZHtbNNZycmg5PnkPkcWDdgzzHJyY4uIFfTgzUdcTic=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(38070700021)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGEzS2VhdllOY0pqQXZ1VS9EK1FHY2wwZ1dKN1BvSElRS2lDYXZURzI0Zk9C?=
 =?utf-8?B?dFVoanhQOWEyeVUvQXVHampYWXpzRmJJZGcrR3J6UU5abXcweFdqZSsxSmk0?=
 =?utf-8?B?RGQ2TjlidDQ4ODA0V253ZWpBd0R1R2JQVXdlZ1ZSYVM2cGNvVVBTQTdQeGVp?=
 =?utf-8?B?WGV5R1VvN0VqbHF2MkwyeWdvNzhpVkpIbldoM215bVUwSjdPSnAwNXE2SDg2?=
 =?utf-8?B?RHE3ZVZFU1haeWFOUEN2OURFZjBGVENIeGc3OUUyeEFpUzUzbldNK3FucEF5?=
 =?utf-8?B?UVFySkh4UnBXYWVpZUxpN1lBY1ZuRUxEYlVUNE9GUTRUREliOEM1YTNkN2p2?=
 =?utf-8?B?Nkl2emhScmNtM3ZaT1JibkJkWmVWa3A2U0JoKzJPdzdaclVBdU42amJhcjJt?=
 =?utf-8?B?L3lOdEI0anBlblRJZ3U5VzNlZ092bXFJbHd3KzhiUUpBa3RBRUhXaFEzRnND?=
 =?utf-8?B?NExhU05UcnM5S2kreEQyUFB6ZjhVNDNwSjhLcSt5akRMbStBUG5BNGlvZDlJ?=
 =?utf-8?B?Mm5SOXhlajRSd0lVdk5SMmx4Y0hpSi9hZGtad2srakF5YzRpa2QxMDN0dEo1?=
 =?utf-8?B?ZEp0eFFuQlZYWk5OWVA2Z0I3WStOSjZEaFp0N1dBaytpcmtnOUZaejRDUFR4?=
 =?utf-8?B?cmoyQkszOHN3S3JFNnRERDhqOWtKbHM0SExUWUQySUh4Wkp4OVFjSGRyMm41?=
 =?utf-8?B?ZTFlMnFZZ0d5QVpsWnlFL1FmVExlRXYvT3hEVGFjaDlBSHM0cm12RThBdlpu?=
 =?utf-8?B?UEtNR1lGVXp4WWY1eURCeXlPbDB1QUF5WTYvU09JVkt0ZUN2RFJ4ZVRqa0dz?=
 =?utf-8?B?OXhqbWgrSlErQjQ4ZXliRXA2NmY0aDN5eVZCTW5sOE5OTW1MS1VMdkEwdFpW?=
 =?utf-8?B?Ni8wa3d2dzFOb3JXdXhQNkJPQVRCMUpVTnBuZnZQSHovRWpGdFUra2M4c1dT?=
 =?utf-8?B?MnJKejFxbCtZa09oMmEzWTFBbkx2TVJGV2NKTlozcTNldVNFNlE4NUZNSUc4?=
 =?utf-8?B?REs5b2E3aEt2b3ByQ3hXR2RRMmRMMWYrcGxhZXk3ZnZCMjZwOFBNak5RVzRG?=
 =?utf-8?B?OTc4cy9LTzRtQjdnUkE2TDQ5eDIrYzBVYlk5Z1BvS1VNTTF4U3piS1BtWmpi?=
 =?utf-8?B?d1djM2liSXNXVlY1MncrK1ZodnEzZUhsdWNtZ1hDZHBYZ1Bmb3VWM2lhcmFY?=
 =?utf-8?B?MGFnenBSTFFwMEgwVm5WTmlQUHRQNXRjdFBOSmFKZlB3THQ4N0VkQ05KWkpv?=
 =?utf-8?B?SjMzRG4raTU4Znk3QmlpUmo1d1BtSjR6N05hQ2lpRTFYSnd1YkJ3Y1V6bVJw?=
 =?utf-8?B?Z0ZFK1o4SG9SRXVlek5hUUN1OVNHY2Z5MStMK3N0bjdSZkhvbVF6clhIT3dt?=
 =?utf-8?B?ZHRaUjkrNzBqT2hha2ZGM1JTMDkvQmRhNGphV1JZUVNqaXpNVU93QWpxc2lV?=
 =?utf-8?B?c0lJRXl6cEUvd05JUEQ1WDRKL1kvUHA0cnBvbUFNenZYdUJDazFlbEpwWlBr?=
 =?utf-8?B?eVNVamtTZVpFNUZzaW1scFVWVFNyZWNIcDE3cGFHR3d0dXdKTFNjVmd0N0Qx?=
 =?utf-8?B?MGs4ODU2aHh0UHJBQ1FnMnJ1eU1CcmhsaXYvK2NmL0RWcmxWSWZmZWF0M1g5?=
 =?utf-8?B?UjBKQ0k2eExXbWVaYWNpVy95MWRtS3FPMnBDVG1HZForQVJMVkMvdVdNMXNR?=
 =?utf-8?B?UFVheXB1Sjc5UEcxZjl4RG9zNDFURkJzVHo0b3lzckhTRGNwdnVYd1VxQ3k1?=
 =?utf-8?B?NUxrWXRZRlZuSm1qRmhHRUlqVmxRRWlYZEJUSjErbWJoN1ZXcXJTOTZETmU2?=
 =?utf-8?B?c01FclJmMEozTDk4cnpEZ1d4VkZ6TlhrSmlqTzFMckpWMTluaXNBS1hISitn?=
 =?utf-8?B?TjZNY292aVJGMHZaTGhUNUJ6MzJJeFVNNnhaZTVaZ2FCZlNLNWNYVFZtVERH?=
 =?utf-8?B?YjN5ZGJpYVRwd3BtQ0lJV0JIVTRGZUY3ays4bmJ1MWxEd2gwRkQ5SjBPTmZy?=
 =?utf-8?B?NERaekxlSTB5MVhwRTRQOWNhUGJaK0lheHo3S0lQeW1FZ0VQSWJ4WENXcTVm?=
 =?utf-8?B?SFFZT0NBSmJ0WCttaXBtMERQUTYyTC8rL2xDWkZDOEJxeEV4eFhMaFhaVTdy?=
 =?utf-8?B?TXVSOXJ3U2FvbDVrQmpIVUVkWWZ6Yk1wbWtBZzFyKzhLU3pNbWROR296OTJl?=
 =?utf-8?B?d1VjdEQyTXg1YkJLeFZWQitycDdhZ21jenFpRFZZYWR4VHhGOUhrUVI0UFU1?=
 =?utf-8?B?aTE4cWV6UzFnU01vUGxVQ1dYT3RsNEdDNWJwMFV3b3ZiSDhncXNFTXkxZDBK?=
 =?utf-8?B?K3pnZ1VPTG5GMkhtMXU0cFJTMGpoZTBsQUw4Vis2dEZnQlNCUWZIdFJwMFBL?=
 =?utf-8?Q?buPloV0EQxBonJNw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0D890B5C7A0C14D89F015DDF90890DD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jixsO2r3J1UqiabgCuVu8hQIYLY/bVZH+J51T1KJ6kXrK5OsQ7MAYfMymbahQDcHS7/+AyOAnX3uIrhbU7oexLwYKY5uEcXSihAdd4VtHyllAwBoud2Dg1HcIQiyuu+Q8tNWjFo0O7n7CwsGJo+m9/MXvwI+VpmaWYtxRiv2Kq1EqlrWFZPYq1U6r4IlRCzc/gCVHctshpquMFzxQocIMTqQhiWHotlhqOBTN8O0jS76bPcl4bDqZe3J//5+2lx07/DurkN+sQPc6Ohmzr/BZVpZzMB59U2GUvDRFmTcAVWMs6LsMrNigtTBU7anQnMz8mA39ez+Z+GC2awAEx4F7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7fe10e-d2e5-4026-7fec-08dedb7f4381
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 16:54:37.2810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IG7TJlIemBFyqFgRLhrJttiWeKADXdA83rlu9IC7kyvARioxMjF2hQrBN2UVYO6Dq2bDSOyk3bv6cDFKMBlI5l+aHvzcf8Zud5ig+xjByeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5067
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA3LTAyIGF0IDA2OjMyICswMjAwLCBKaXJpIFNsYWJ5IChTVVNFKSB3cm90
ZToNCj4gQmVmb3JlIGNvbW1pdCAxNjVlNzczNTM4MzEgYmVsb3csIHRoZSBrZXJuZWwgZGlkIG5v
dCBwcmludCBhbnl0aGluZyB3aGVuDQo+IFg4Nl9GRUFUVVJFX1REWF9IT1NUX1BMQVRGT1JNIHdh
cyBub3QgcHJlc2VudCBpbiBhIGNwdS4NCg0KVGhpcyBpc24ndCBxdWl0ZSBjb3JyZWN0LiBJdCB3
b3VsZCBwcmludCBzb21ldGhpbmcgaWYgS1ZNIHRyaWVkIHRvIGVuYWJsZSBpdCwNCndoaWNoIGlz
IGNvbnRyb2xsZWQgYnkgYSBtb2R1bGUgcGFyYW0uDQoNCj4gDQo+IEFmdGVyIHRoZSBjb21taXQs
IHRoaXMgaXMgZW1pdHRlZCB0byB0aGUgbG9nLCB3aXRoIHRoZSBlcnJvciBsZXZlbDoNCj4gdmly
dC90ZHg6IFREWCBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBob3N0IHBsYXRmb3JtDQo+IA0KPiBUaGlz
IGlzIGRpc3R1cmJpbmcgYXMgaXQgaXMgbm90IGFuIGVycm9yIHJ1bm5pbmcgQ1BVcyB3aXRob3V0
IHRoZQ0KPiBmZWF0dXJlLg0KDQpBZ3JlZS4gSWYgdGhlIGtlcm5lbCBpcyBub3cgdHJ5aW5nIHRv
IGVuYWJsaW5nIFREWCBhdXRvbWF0aWNhbGx5LCBpdCBpcyBub3QNCmVycm9yIHByaW50IHdvcnRo
eSBpZiBpdCBmYWlscyBiZWNhdXNlIFREWCBpcyBub3Qgc3VwcG9ydGVkLg0KDQpCdXQgYWZ0ZXIg
dGhlIGJlbG93IGNoYW5nZSwgc29tZXRoaW5nIGlzIHN0aWxsIHByaW50ZWQgaWYgdGhlIGtlcm5l
bCBwYXJhbSBpcw0KdXNlZC4gQ2FuIHdlIGJlIGEgbGl0dGxlIG1vcmUgc3BlY2lmaWM/DQoNCj4g
DQo+IERyb3AgdGhlIGVycm9yIG1lc3NhZ2UgY29tcGxldGVseSB0byByZXZlcnQgdG8gdGhlIHN0
YXRlIGJlZm9yZQ0KPiAxNjVlNzczNTM4MzEuDQoNCidzdGF0ZScgaXMgYSBsaXR0bGUgYW1iaWd1
b3VzIGhlcmUuIFNvdW5kcyBsaWtlIGEgZnVsbCByZXZlcnQuDQoNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEppcmkgU2xhYnkgKFNVU0UpIDxqaXJpc2xhYnlAa2VybmVsLm9yZz4NCj4gRml4ZXM6IDE2
NWU3NzM1MzgzMSAoIktWTTogeDg2L3RkeDogRG8gVk1YT04gYW5kIFREWC1Nb2R1bGUgaW5pdGlh
bGl6YXRpb24gZHVyaW5nIHN1YnN5cyBpbml0IikNCj4gQ2M6IERhbiBXaWxsaWFtcyA8ZGFuLmou
d2lsbGlhbXNAaW50ZWwuY29tPg0KPiBDYzogQ2hhbyBHYW8gPGNoYW8uZ2FvQGludGVsLmNvbT4N
Cj4gQ2M6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBT
ZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gDQo+IC0tDQo+IA0KPiBD
YzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGtlcm5lbC5vcmc+DQo+IENjOiBJbmdvIE1vbG5hciA8
bWluZ29AcmVkaGF0LmNvbT4NCj4gQ2M6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0K
PiBDYzogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IHg4
NkBrZXJuZWwub3JnDQo+IENjOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPiBD
YzogS2lyeWwgU2h1dHNlbWF1IDxrYXNAa2VybmVsLm9yZz4NCj4gQ2M6IFJpY2sgRWRnZWNvbWJl
IDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWNvY29AbGlzdHMubGludXguZGV2DQo+IENjOiBrdm1Admdl
ci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAgYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jIHwgNCAr
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jIGIvYXJjaC94ODYv
dmlydC92bXgvdGR4L3RkeC5jDQo+IGluZGV4IDQyZGY4ZWE0NjRjNC4uYmRmYzNiZjEyYTljIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gKysrIGIvYXJjaC94
ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+IEBAIC0xMjI4LDEwICsxMjI4LDggQEAgc3RhdGljIF9f
aW5pdCBpbnQgdGR4X2VuYWJsZSh2b2lkKQ0KPiAgCWVudW0gY3B1aHBfc3RhdGUgc3RhdGU7DQo+
ICAJaW50IHJldDsNCj4gIA0KPiAtCWlmICghY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVS
RV9URFhfSE9TVF9QTEFURk9STSkpIHsNCj4gLQkJcHJfZXJyKCJURFggbm90IHN1cHBvcnRlZCBi
eSB0aGUgaG9zdCBwbGF0Zm9ybVxuIik7DQo+ICsJaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4
Nl9GRUFUVVJFX1REWF9IT1NUX1BMQVRGT1JNKSkNCj4gIAkJcmV0dXJuIC1FTk9ERVY7DQo+IC0J
fQ0KDQpTZWVtcyBsaWtlIGEgcmVhc29uYWJsZSBjaGFuZ2UgdG8gbWUsIGJ1dCB0aGUgbG9nIGlz
IGEgYml0IG1pc2xlYWRpbmcuDQoNCj4gIA0KPiAgCWlmICghY3B1X2ZlYXR1cmVfZW5hYmxlZChY
ODZfRkVBVFVSRV9YU0FWRSkpIHsNCj4gIAkJcHJfZXJyKCJYU0FWRSBpcyByZXF1aXJlZCBmb3Ig
VERYXG4iKTsNCg0K
