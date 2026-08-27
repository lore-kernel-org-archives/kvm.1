Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8D28852E;
	Thu, 27 Aug 2026 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787799205; cv=fail; b=KG8CRvIkquEcN0e2XMAGij5OYC3c0KiCyRPJhfd/Ivyo1TxYs6xnUfORU+jcGM0bS37prMoOqCdKbLf2FZWGSXwbRKz64OECixp5MdzFcMvjbejNviHpAd4VEUPqfUefYmlreW86ZotDFozlCMuDHo0ixrP290nv5jB7zYH8RNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787799205; c=relaxed/simple;
	bh=Gq0pAm1/gbANkwEBWwjSv+9mSoGqFJrmb3mX9yHgzks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QY6ahMPQu6LMIewsOfuJMIVuFJF54eMjvIbccEYlikCpNZ9AuZGqCcetmqFxosSOwr01qLFxspmAl4EjXCxD0Gh/Pxrnn4k9msGQmLezMEGjmvEDtuoNoV3E3CHLTMmMNmG6aLaGA1aqOPtA6dFYnjZlcw6QcfJ2qMisDWnqJJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aftTcS/F; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aftTcS/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787799203; x=1819335203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gq0pAm1/gbANkwEBWwjSv+9mSoGqFJrmb3mX9yHgzks=;
  b=aftTcS/FaCdAPWneMoCiDI3hMWYxQs6RAacsAJ2crOVej1DTdzD5zY+l
   OPG6FRDU3dKqCK9b+6mCHSOdM0zC1LDtix6bIuIevn1y7z5dzTuEM8ynv
   HyQpzuJP8par/Ny/jUxk1Co9kZUTlm8avyZkexc1M4GmoHhFLvvPUwbGL
   wBoyqY4W/NAKCMratNEPQrSqngPRfL8816Uk6+4puecfLkDSBKeZTtghm
   GJ+Wq3JR3jFzHBG5fCtQz3Nmbyg7e4I1xUWVJl/p3/JyIiRs+LWU7m9AE
   NpQx91aUi8yBX0yxdTH9kJB2FfEBXbBcvPMuOmT230Z9YbjV4YHYqOPk+
   g==;
X-CSE-ConnectionGUID: BzmHtQeNTJCFw6qg6sq8Ag==
X-CSE-MsgGUID: vcUoEmC+SWqYUTRMITb3wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="113827144"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="113827144"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 19:53:23 -0700
X-CSE-ConnectionGUID: budhwYu0QpSH4V9Myl5nZw==
X-CSE-MsgGUID: SFaUmi4QQ16P+eIgJls8iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="267156638"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 19:53:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 19:53:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 19:53:22 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 19:53:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLnFNmUiwhufpEiqm4X9VkDe7iT3EL/YXy6BJeShz8HAd3qesAFTY4iuCUcpsNp8ZpyZNs3wlYbcWZr8W9yu+5yAnPY+wkEpw7FJsuH7R4+ogfSrJAUj4pIW4t02NzeQFr24xBWSrKVSVoRj9DxkKbjcMt4z51C9nWn7LlW5XCeqXM4kRAKTUdb+P42oDMy5CEQhJJIsUmdizi/lbf2YfMTbL2vxNbpVnKMDGRihdQX9eVPbplQttF9/WxbW72X5KG+lMfKsSJaVcNY8tfNab+67/NltBe2dxrYk2BGpim3rxJXYt9ncT4eEyKDtKtMKhQ+5N8zdf/UjVVgHJVG3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq0pAm1/gbANkwEBWwjSv+9mSoGqFJrmb3mX9yHgzks=;
 b=uOJfIPN+071YnyXYKqdJzOhK2PNugQ6Tx828zvSJc6wg3L3SFHPn1XNclcTH/q+EhySPTu7xX+4HVfXyNMLuv4QicFT/vcWmLP62vXFmLMsvRtiHpDCXkKiZJE+Yg0ZIA7Af6quxZlGBLLOe5ZmBBQcQp6vgGNsn6FRCbriaHdnWrQdPBpSkaMKlsUkb/iD4H+1/BuYwiii5v5f434B2SaqqoWFa3vNEuIvfR0fhd+Yn07p/Ahl7B2nSOohQ+ZV2S+IRADbhXAaVG1vwS6JNbyAbRnMUnw417obdW1mFnFitWGgPnu3Z1/EtpbQR/FBgTASsqhzdpZif/AEP40g6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5302.namprd11.prod.outlook.com (2603:10b6:208:312::7)
 by PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 02:53:13 +0000
Received: from BL1PR11MB5302.namprd11.prod.outlook.com
 ([fe80::f19c:833c:9f41:f3de]) by BL1PR11MB5302.namprd11.prod.outlook.com
 ([fe80::f19c:833c:9f41:f3de%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 02:53:13 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v2 0/8] KVM: VMX: Harden against interpreting TDX vCPU as
 vcpu_vmx
Thread-Topic: [PATCH v2 0/8] KVM: VMX: Harden against interpreting TDX vCPU as
 vcpu_vmx
Thread-Index: AQHdNX4pXtCYWtcsXU29CHNhEe7/ybaxM2cA
Date: Thu, 27 Aug 2026 02:53:13 +0000
Message-ID: <441dbc85e8c90c32f4db989464b77bd613f9553d.camel@intel.com>
References: <20260826171246.777729-1-seanjc@google.com>
In-Reply-To: <20260826171246.777729-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5302:EE_|PH0PR11MB7588:EE_
x-ms-office365-filtering-correlation-id: 37b811d9-1827-413e-64f7-08df03e65632
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: ZCxpY++Y6zB/4VRU527rYpo0Z0RbJDATg9ALBymbAnPYVH7WYsCmU++9F4Z7L9ltAQY6lSvmBHVe9rxJFbfToP8hMB/9AID2he/6CGmX0HI407UV3HEAygwjtCLI5GBvBeVroxqQvLfoCOB2xNnDkAng+bZfBCcxZjCMQ8nom9ttiojgivfhweo75wjkAKhcUifHPDxne0R3zCJaeMjkHxA4ikCj6FsMryVW/Kf99o7uND6PX//lUhPNNDPA9qq1wkjeTA4f0ehv2VYglVKmT4KY9SignyTGDNrS5g0THO0QsrKtYcg2rb+eT0reflSy3cq8J7ZN+/6pdYG/dfTz004c0c8N05Sd43euzgFQKSggq8PDxHg5xEDdlJ29KFsj+Via6Ro9I6VN94OHPOhl7KbeOe7dfuaX7wgIarZJ1cELu2OvfVUDRUJeBWKR7dENMk9+QYN+Qfid0imAJDvDGkiXeLccMCtpQ7oRrQvczvbEGEFp207z5KT9gnSCXIQcyTgu+E9Wy39D1e/mju9Hq+SXX9Njp4BucIpZsVOg8HTMqCqfv8LHti8IK8r5aY+2h5oWMGSrOoPcEWqg/xbyggpvrj+SvN8H86hQc7hn3lK1vJVOO/KVIi+UHxLpxOfJvf3yEr/3N6PenRRud9Bz4OMBdWF5MSXe6/3S45QQzHntteRe3jIjIT3paMKawOH58Mta6N03fRVxrYUwsEpYdOjlpCKgkMr3KT7qgEbK2Is=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5302.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWlMYWhUVXdLa0NOU1hzTlVJblhqTXljYjJaSmRwK1BLaldOVmoxZVBGcW1j?=
 =?utf-8?B?djJtN0doN0s1bXg4dm9zeGFjTnpuckpkYkw3WC9wTGFvbDY0cHB4UnQ0REZv?=
 =?utf-8?B?SDNCcFJ6cTNUMHhodUh1c3lqUVBlU1VSSS9KaC9VS1JwdzB3eS95MWZyaFVy?=
 =?utf-8?B?Tnl3K1ZJSU5kTUxMZUs5MXBpS0tLQThqTFVnSk54K1JmUi9nRWt6UExDSkhn?=
 =?utf-8?B?LzBEemV1YmZLRzlvT3F3RWl4UmRVTzBoWUhWRnVIamlmMjgzcmx1c0I3YnZN?=
 =?utf-8?B?RVR2UWUwVEhxQkhNMHlsQ1o0cDdjZy9qaWpZT2NVWVdyNzI2dzBTVUxWODdK?=
 =?utf-8?B?K1NBQXlxdWs4aTRZVVhwdEN1Z0JDSFhiRXNnOXVHYllGL3VvSU5ETm9IaDVv?=
 =?utf-8?B?bGNoWDY5ZkVkMkRhTUtDVnBVYUxuS2JSWEpCWEh5cnJzTnNwVFplR0taWk54?=
 =?utf-8?B?ZDdhV2ljd2F3d2h0K2dKYlZHaEZNTHlyd0k4cVZkeEVzTVMyd1JBWWZOK05Y?=
 =?utf-8?B?d1Q4a2FFd3o0U3o3YTh6T20vT2ZaYTJUZDIyblFEbnZTaGFaWDJYMWRQVFEr?=
 =?utf-8?B?VUZXcGVUUTRKOFluK1J1VXlnQThXL20rSzNjb1hoZkhaT05zb2JHb2x0OUFP?=
 =?utf-8?B?WmN2dEpta2NUTWw0bnM4Z0RyL1JpS1ZBMUorRmY2WEtLUG12ekhLdVZkaWRO?=
 =?utf-8?B?SmFoN2Z4SWxZWHlwalVnd2Y4SkY2eDMyR1h2emxwUVhpTHA2Tm1NSDJ1TCtP?=
 =?utf-8?B?cGZnYTNON3BHTTNxR1pLZ0VSOGR0Q0FQeHNrVVRFMkd5cm85T2d1dnk3OFdP?=
 =?utf-8?B?bVBhUWRlMHovYVluWi9EbEpyYmtGWTg2L3VGdlBMdDlGaDYvWXdUanVqTkd3?=
 =?utf-8?B?Sk85S093aitmck8wcDJKSDEwcFZtczRMdFQzRkJwUEJ2NmJZa1dtUHNlRTFp?=
 =?utf-8?B?eWJiMmJwM3dOaWpaa3JaSmxPVU45NU5TeFpXSTFrQXZIV2c0Q2pCZUhBeFYv?=
 =?utf-8?B?Mm9DYVNGSWtXWU1KNVN0SGxQSmgvZVpWWHl3cE45UzdLVXRDSUpZSHFYam5r?=
 =?utf-8?B?bHo2bFVzRjVhdXpvbnBRM2dYZUhqaFBKc0FtU1FITzh1SVFZNVhxL0FtS1FR?=
 =?utf-8?B?aVk4ZXdFL0pyM1NjLzNHZ1c1TnNsVmtIL2hTYStHa1J5Tnd6QXZ6UGxkaHJJ?=
 =?utf-8?B?M250cSthVjJBM1pKNTdIRE1qY25EZnVKcGxnNHFtOXZGVk44a01GemRZcnRF?=
 =?utf-8?B?NEYwckNuRGNOSmkyUmFwTS9GTUtTQm81VEk1dk9vL1JJOFBpNlg0VVZ3bzMx?=
 =?utf-8?B?N1EvYWMza3Z0TGRubTkvZTdyajUzZ0dqczRHc2V6aUNEdi9scW9KdnZOTTFI?=
 =?utf-8?B?WGg1bTdYSGRBWlFxOEd3dGxFbElaeXF1YTlUUnN3SXBOcHlmUUpLNW9LR2pR?=
 =?utf-8?B?OGRxRXYzODVSNlZJeWI3NkpVUjZHQ3hHbUY2U3VaWHkxWE9MMTVrUXRVbHVL?=
 =?utf-8?B?RzM0RkNSQWhHQ3RFL3ZWZTMzb2MyY04vdUJoWkRiLzFyYVg3SG9YaWlMM1lC?=
 =?utf-8?B?ZFMvVE1kTWxhMnJFc3hBb3JUNWVKRkF3ZDNIYmRQdlRCd2xQSGhranArekIz?=
 =?utf-8?B?cmFwTXRwc3gzNGZ5c1dvbXROSHFqU0xYcWtrY2VLWWR5aDdJekI1QXJLVm5M?=
 =?utf-8?B?RWZJNmJ5NXdFYmllcTNkYWs5cmZDZEV3RG5hQ3htUlVSZk1RZzFJU21mNWFt?=
 =?utf-8?B?OWpQaTlFUGRob28xS044c1BKV1hGSmUxa3Yyc2Iwb2JnN0JhSkN4U24zaHRW?=
 =?utf-8?B?QU54bEE5cmV5M0MvY2F0Zmp1aXErLzRhb1VySXZ1TlJrREJIMzRlZWgvM28w?=
 =?utf-8?B?SHUrcUxaZWtCU2dNZkNrUEhIc2RvZWpCd09Pekp6YmlZU3NQNFNkbG03RVZz?=
 =?utf-8?B?Q0R2aUFVSmtKenVMcVBRN1UzeFZuYlFEb1R2Q3AyTTJ4NTEvSWI3WFMrT3Mz?=
 =?utf-8?B?cmlUU016akRtdDhiL3k3NGt2UU41bElzbm1JUnV2djJGRk5KR0Z1Sng5ckp3?=
 =?utf-8?B?aDU5UW5tRlEra251Ukt1M0pKYjQ0Q3Y2elNuRU9WNFhiUGp1Y2IxK0RLK0lQ?=
 =?utf-8?B?bXFzWGV2MTVpTW1rZmlWa2R5TWNSYmJBRW1wNzVKNVZzenNVOTl5dFdTb0JL?=
 =?utf-8?B?WXo5cGljRWJ1dEd2dFc2UXBmQ01MRTYvRjgxeTdBQis0bHBLNUFwalVDQ2hr?=
 =?utf-8?B?VDVySDR0Q20rZnlaelpXSnNWWCtJa2JjZXBkbEVtZFlKM1h2cVVsNkRmdlo3?=
 =?utf-8?B?UnFKNGg4SXMrZDR0S1RGZ1RKSUk4NnVRbGxTRjNHQ3ozRmtMdnRrQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC7C185057E6A346A2F8599A885F5293@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jiEjXL8xj0DLF3yXMd2LfpK1XQeQdX9VQ6TQNqL34IRnMgt11HogPHGHW7k/P4mAhRTShH5xaKBF4SxSsHuJTLPZsZiozZYjL3Mp6y70NvF3trhc415TTBWdBStpSUuwqbNAPFCJBuvDnaaQnLCvpMjZV1/al9W4EQzVO8mnMu4TOuqONnJvyu72fsu8rIJ4B/XVdAvtWHkrqJnhuDFXaktc3TtsFUsXlFnleFK9eSyMjZHyljy2xHOyTGNJ5lDvUsvHlCZcm5jxn6SFwpfFhPzzFGqOtiPJPPKfmgBOIQHK3FGz4yFtg3cl6JFbwaa5J5HnCdKBhS24tbC961N9kA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5302.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b811d9-1827-413e-64f7-08df03e65632
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 02:53:13.3078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAaYyxkhMS3tRfKp1+fBWBXdYSoCzYhUoiskPWkvPGnRmPlG8aFBQaaffAhBzuQ28GN6IsQsQX7lCXbYFg6FaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7588
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTI2IGF0IDEwOjEyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIGFuZCByZW5hbWUgImFsbCIgKHJlYWQ6IGV2ZXJ5dGhpbmcgSSBjb3VsZCBm
aW5kKSBjb21tb24gaGVscGVycyBvdXQgb2YNCj4gdm14LmMgYW5kL29yIHJlcGxhY2UgdGhlaXIg
dm14XyBwcmVmaXggd2l0aCB2dF8sIGFuZCB0aGVuIHBvaXNvbiB0b192bXgoKSBmb3INCj4gYWxs
IGNvbW1vbiAuYyBmaWxlcyB0byBoYXJkZW4gS1ZNIGFnYWluc3QgbWlzaW50ZXJwcmV0aW5nIGEg
VERYIHZDUFUgYXMgYSBWTVgNCj4gdkNQVSwgaS5lLiBjb25zdW1pbmcgdG9fdm14KCkgb24gYSBU
RFggdkNQVS7CoCBTcG90dGVkIHdoZW4gd29ya2luZyB0aHJvdWdoDQo+IHRoZSBidXMgbG9jayBz
ZXJpZXMuDQo+IA0KPiBBcyB3aXRoIHYxLCB0aGUgVERYIGNoYW5nZXMgYXJlIGNvbXBpbGUtdGVz
dGVkIG9ubHkuDQoNClNhbml0eSB0ZXN0ZWQgY3JlYXRpbmcvZGVzdHJveWluZy9zaG9ydC1ydW5u
aW5nIGJvdGggVk1YIGFuZCBURFggZ3Vlc3RzIHdvcmtlZA0KZmluZSBvbiBvbmUgR05SIG1hY2hp
bmUuICBGb3IgdGhpcyBzZXJpZXM6DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFu
Z0BpbnRlbC5jb20+DQpUZXN0ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4N
Cg==
