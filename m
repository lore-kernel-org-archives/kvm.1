Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BD2AEE4;
	Thu, 30 Jul 2026 00:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785371293; cv=fail; b=eHkkmbFImoijAso4EHZZVJmZjEAzPEaX3mimUiLkptBoP+zecnKF+aB0XnF0VHbF4szFMZlcVxUV1QoKe7x1GGZ6vvx/SxzBvZrIK1QaX7+OG1Ivhlpv70Xv02tDtgw9p+PfTySxyTuOJ/w+H+ETk4FuRgW+23w1lbj4NOwvJWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785371293; c=relaxed/simple;
	bh=ST8V52I3zyLloK7gXaUnsviJvPxvveWHLlExgcf0Gjk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aZhKYGozx5XrtD+WrhHikDlXZHms30d4XWryBkH5N82MjZK9Oko4xkzu0Lq6T4DHCSnibs6EKt6GbJWDdS8vZxxS+IxsRv1ybVk+gpx4oyRa0Qfa1seTAQsxu5/Ao5HTj5y5ntYGeH5TUgD3XdF9kCtYJvuAxjU3OvjShney9v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWA+aABG; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWA+aABG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785371292; x=1816907292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ST8V52I3zyLloK7gXaUnsviJvPxvveWHLlExgcf0Gjk=;
  b=SWA+aABGjWPVvRrIrZDRAsBYMBVSEIVPfcLLp99pDIq8k3+1fGrAa12d
   wB3jNqyl2Aw82eJ91OyWZhhB1Pg0YhEVUanIQfvQuZKKokQHHsxO+E+Ad
   Px/pIBv0bqvbr6azN3fZPyLeKmZKrrqHMjOgxMB9VJHyliFL4MoOith/C
   Lu4EQhH8PHtF+4IaibzvFa+SsQmJQ/Tn0E1iz7UtxVgZWxYXipGNhkwmQ
   TNvFAaJBOqEzSEuc/DPODO4IYVUHUYcZ+uy33EjcameKcdXY057UB1DzH
   b8ztgZIY5Lyo2N30YpOZ5QWs3BKekqaKhf5ZbGbCxbc+DtZ5DkyDqrlnS
   g==;
X-CSE-ConnectionGUID: 3MNJUoVJToS7J8IHPoTg6Q==
X-CSE-MsgGUID: YQdqP1hDQgSgk/79dpnqGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="89875902"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="89875902"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 17:28:11 -0700
X-CSE-ConnectionGUID: ZFuNU7vzTXOJ3D+IAj//rw==
X-CSE-MsgGUID: IKRxwAovRg2g4PBGcYPnHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="258369411"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 17:28:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 17:28:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 17:28:10 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 17:28:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PC+k5hmnZpuFaXF2MUXXDmGGVubOEtJmlLY91votGlaa0DyllpGSQ2FnKF81d0Lvy/5xltI2IiFE9vHxq6TBE30Z0cWg5lVflMdlx3XPGggQfdBhhasYLrrJb/2i7uO6FUz2eXpkz4wUSplQ1pUO1cVZG8kKeVG/ZmNIjp0vvvPkAeR0GMGvByy4zDXWsFWxxnZncwUnDGogmXy/KH8rA2coHS26WYsLJVLDRwa1vk5Kb/eeot4G5hONxdTVqxPKOHWVzMr1sqpoEe6Ga4GX7UL+qMvjpaRvrwLd6vCpXUeMyNDY8stGZL2catQYPE91/7qOXGKDCRRt5K9x69NrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ST8V52I3zyLloK7gXaUnsviJvPxvveWHLlExgcf0Gjk=;
 b=d/oe6GBWxT7u+VlH4+S8dxO/lguuMMQEgruY15ie4/7og3UniObUIzV3pQC1Nr2JBAl39tvxHBmE1PAkwHfXWgHn1rYnzIOIG4NujMG3KMMkq22lS33GszgXGUdI2ZbX82o1EW+j5qw2+fuZevmC+zRRGj/Dgz7QgdzXd/fElo15ZawnYWI9bmxv5CtP6Nf3OskW55Ntotz4kX/TMClgEQEq1fiTv5A9lj2yK/j8mRuy+YYWWqapFeELL01Oe7hDG9korwlrIs5T+vNfK+6xcmmbMgjyjTYCyIZDYd8HKMJkO0LpbeStCFwXR5ustQiMSWaV8dDXVNtRYV0BjHyQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 CH3PR11MB089109.namprd11.prod.outlook.com (2603:10b6:610:361::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 00:28:08 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 00:28:08 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "dmaluka@chromium.org" <dmaluka@chromium.org>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "aashish@aashishsharma.net"
	<aashish@aashishsharma.net>, "jaszczyk@chromium.org" <jaszczyk@chromium.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"vineeth@bitbyteword.org" <vineeth@bitbyteword.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"naveen@kernel.org" <naveen@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Dong,
 Chuanxiao" <chuanxiao.dong@intel.com>
Subject: Re: [PATCH v2 2/2] KVM: VMX: Fix stale PID-pointer table entry left
 after vCPU free
Thread-Topic: [PATCH v2 2/2] KVM: VMX: Fix stale PID-pointer table entry left
 after vCPU free
Thread-Index: AQHdH3yjk4futQ05BE+UmU2nNZGKR7aFNZmA
Date: Thu, 30 Jul 2026 00:28:08 +0000
Message-ID: <8a663f6e9078a1f6087f9fc03c0528a42c969671.camel@intel.com>
References: <20260729170621.308809-1-dmaluka@chromium.org>
	 <20260729170621.308809-3-dmaluka@chromium.org>
In-Reply-To: <20260729170621.308809-3-dmaluka@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|CH3PR11MB089109:EE_
x-ms-office365-filtering-correlation-id: a33c3537-cd70-4e44-a8b4-08deedd16e25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|38070700021|56012099006|10067099003|18002099003|22082099003|11063799006|4143699003;
x-microsoft-antispam-message-info: r/nAy73cNoSu1xtvAU/BaQ5VCyn3jti4gjor9Qi3KN2AqUH8DzblNKN8WT9J2FwQwAeEOaWoMhV1m8gW3LeMs92+nQz38xZZx0kBlbiAcwQ09UEKQILs+/9M27hCtH8++9E2BLalqQX70YuoKUfnd0HBIVc6L1Jo3Oac4FctMykVyGf4hEmRoNfjZ37oYne77iLHzbwWeodyliRq84bjp0aymqc49F7IeYtNKqXqpAgekr1K+8Cy/ohXN+kVm2+DGcYkXZ8s+P72h81Ljv/epOUkP1cOWbOX+zo4i2cZT3hkz+z4ePs/tFVqfSX00j3vpjUS9k2LqyNV71QchuzK0s0Y7S905rs6u6fgVmYuOtbKPaL37c2owxOEcJdjcdtoXTPylvlCWM0oCtaJRYM6D2OHGBx+Lq+7/hC5iZMT3zQlqM+E1fIenK6smGpR+9jfmg2lEYd3qf+x1qlRBv3ea8APHpwh/4nzNl30Gi4q4V0j6zUxWqhwCpkTgfWhOQ3Nia8tuKBaKdLCtYzjwxuZ7Z1GUw1Xn7aUGE2MqGADQcfcMCWdOrACQhphXRa4B3LTpSeHvnsbCBHUT/het9+THNvte2sNAw8131fTcfhH5sVyexMMa68bHDGrclhi/8azW2JGLWfz6cTKwhSACDDvdDLwRPEfBrNaGP8ch1JzrZQsG02NYHCGPev8SgiYsm90LFtR36b5vo0DUO5LpTi+kWRKpDaBstCBxD5/37dum6E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(38070700021)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWZiaXo1dGRNNmNIelpndlBLdmpOUE5uL0hRSTY5dlNkVDZQcklDeHBrOFlR?=
 =?utf-8?B?TVFnLzJjOUZJZ2JBRXBXWHpCa2grZFhSZmIvSVZYN25mcm5JblpFM1NkaGF0?=
 =?utf-8?B?ZU5hTUM4NnN4Vk9TNWdEejYzRVdjNGVQQ3BVUHU0cGtMMjZUbVNyMm5RTWtU?=
 =?utf-8?B?cG5VM3YvWm9KNWw2Vzc1N2xJK016T2hWcXhIWEtFRVBsNjdXUmIwd1dBcnhL?=
 =?utf-8?B?bFRPTGk5amNyWTk4SHF3S1R1UUpSL0N0QjJQR3ovVzQxUTZvWjB4M3NMOGtL?=
 =?utf-8?B?NXJFQVB6Tm9PVFhlQ2lVRk9iK0pNR3JtZnl6WllSREFUaXV1N2JSK3pUclk4?=
 =?utf-8?B?NVhLREZtTk1TNHMzazBsRVhDcXgvRENkWHN5K2FMbWo2RFBEMmJJN3diMzJU?=
 =?utf-8?B?T2E1dklPNVBnbjF2K3lRZ3VFNkVRUkpuVmJjUjdJNWN0Z0VOczVMbjg4L2lS?=
 =?utf-8?B?YkVQRCtLekNiUG1SbTZhN2EreTFNbjRJRnJSY2xZYjMvY0ZOOFlhUnI5UDAv?=
 =?utf-8?B?LzdoMWszbTBVWVluU0I2Zm1GdUkvb2lHU0M2Wm1rcVJ0U1k3Q01lWUhrRWkv?=
 =?utf-8?B?TVc2ek4xTEZpRmlYQ2drRFZoSXZnSm5xcUNNUHZrWTJBWFFuWXh6aDRHaEs1?=
 =?utf-8?B?M2dXa2Y2MTczbXdyT0dhSnNOQ3ZoK2hzZkZrektjZjN4bTBWSTdUN1dHR1h1?=
 =?utf-8?B?WDJ5dXA1TXFpelUySEhpOEhyaWgweVlDOEREOGUwZWpmcGZlY29hM1E1SC9i?=
 =?utf-8?B?T3dIbndCWm80SCtwZEluRWxqL3huYWJCS1ZnaXZ3MEVQVUVzUmR2WGp1UnZJ?=
 =?utf-8?B?UHd4bnpXL1V1S0FJSUdWY2xWQXlPdXZVRnNzTlRwRkNiemdWL0U2bi9pUk5v?=
 =?utf-8?B?VkJQMTFMMjA3dWhyMktHUDM1enJmWHprNjV2RVIyYUxYVmZySEJINkVFdEN3?=
 =?utf-8?B?M2pCK3Z4Y0dDeFNoZk9hVERFQ052UXpaSmdZUm1jb2hGS2JPanVxTkhyT0lM?=
 =?utf-8?B?eDcyRlFBVWxCNUx5a1lMNWdpNFRlbFFRWk9haFdORXFXUVZpWEFpWXorN3dU?=
 =?utf-8?B?VE9ZbDlNaE4zdTA5UmYzTHBZOG5VRFpsbVViUWQ3N0JlbEZrMTR5VTZtMDBS?=
 =?utf-8?B?TU5XWnN2QVhMRUljQjNsZWc1eUJVWHVjVUxUOVRvUWI3bzVXQVRxU1R3Qno1?=
 =?utf-8?B?b1M2SDZUYWIwcVpLWXlTZTg3Yk14cnZUZ2doM1lGTTJ1eUJabDg5V3FRTVBG?=
 =?utf-8?B?Z1UzbGtyN2lUdDZOcWtzSWQwQitZZis2Sm5ndG5ZQVRzY3BSYzBQRmMydW5o?=
 =?utf-8?B?MzliSlcxZHg2RktKLzNheXNydW44RXdHQ1BEY0l0VVV5VDdmWGE2K1Z1VnU3?=
 =?utf-8?B?T3Q5N0VwTkJWV0hRMjNGbkd2cDVNdlJ4ZkI5UG1mQkZrY1k5RTdReUZSMTV1?=
 =?utf-8?B?NUdzakZkNjdvTXBoeCsxdE4vN1JLcmYvbThFeVRtVTEyL2tKYVR2L2FyZ2xT?=
 =?utf-8?B?bkxDSFRNWDhmeDhPUHQ3ZkJpUWVoeUdlT1U0NjFGL09JbUVvZnNZaG96NlRr?=
 =?utf-8?B?bE1GUUdkQVp4b0R4V0NEUUZlYVFxY0lKYnlWOTd4cWorVXJYRFN2a2UwZll0?=
 =?utf-8?B?UVFJRGhKeDFNZmVoc2prMjVsY0FoT1lRWFk5S0tSNm9KVllZRlgwZVU4allr?=
 =?utf-8?B?cGJpWENvano5RE0wMGZRRnAzUHNNcmVDbmtxdXo1ajVGL1A4QUVUMVFnQXBS?=
 =?utf-8?B?NUxiS0M0NFREYUxFalIrZ05wUk5hQmpyTEppVnpCMlZUTkFJWTBGUUlKTWo4?=
 =?utf-8?B?OFVZSDRvT1dJZ2hnaDkzYWE2YWExUzNpMElGVDA1TFoxYU5GZ2UweUhUY28r?=
 =?utf-8?B?UGtBRGw2TWFtYnhPb1dpWnYrS3VXWUFOMDV2SkdxZGZ2OUIxZUdVcEJFQmth?=
 =?utf-8?B?YXhrOWYwOUdRT1VXWjVRRDRiWHhmYnFYOURrTVdOVlBYZEVuOEZIK08vbytX?=
 =?utf-8?B?Qm1jVExuUlFnOVBjc0txTzVhK1lnQ0x2NnZ6SzRuRVBOUXRmOFVpdFdITXlx?=
 =?utf-8?B?aklEZkY1eG5lc0h6RVpZMVczWHNaUHFMeENpZ1pGRTV2TUZ5QzlDeDhYSlZG?=
 =?utf-8?B?d0NraEdNMUtZVmt6SllabDJSQ3JyM01DUUxNZjZkdjQvVEtNbC9GNExXaU03?=
 =?utf-8?B?RFV5NE5uak1NMEt3dkZqWXN3c2djRnJrSklBdENUVndGQ0t3cDhxWUdRakl2?=
 =?utf-8?B?N3NtUm4waVcwMkxISGRmWWczUURTaTY2Vld5NWZYa2NTWk1iMXpNMG5jOE91?=
 =?utf-8?B?MkRGODRYYVpuVGxQWFBnTlh3SDB4TklrR0lRcDM2dG5rbUhOTkltdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05D836B90B722144BB1CCC25961BA417@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fOJSfAena1mGDmAnLqmznzkQ0MDhn6f8opjXUkeJIgC9V3h0oDxh+Jy0bqw26KO0+WBqoTpHF2Cp+Zf8AYk/GvQ9SZRjE1YHpqpusg9yWbHFtan+LgS4FRW13n0j8x12cdPHvNXDhbLsz1ZRe7yaEqnR56AjkLVrZBP/Y/uK/S/bCJGx6Hh8QkWDsbiFe6EqO92K6pjy1qWOPcf6vm7tnrHb3L03aJ0ZF7LI0GwhtE9jmBNUcOd+x/4HOxcx8pkyPK1eh3jM32saamYUOykqymz6O40yVSZASQSmCfmiTO/mjto3WKDBoWfi2ttOc2MqLscwmxGOldxRsw7r6lj41Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33c3537-cd70-4e44-a8b4-08deedd16e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 00:28:08.4553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zq5pnxd0KlcTkS3T/fywJcB13RbW+jkR2/5A7FpE+lbV9ujlfiPV98ZRHv8SQ3Kxs0ZZrZIaTuRFimixZgtLoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB089109
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTI5IGF0IDE3OjA2ICswMDAwLCBEbXl0cm8gTWFsdWthIHdyb3RlOg0K
PiB2Q1BVIGNyZWF0aW9uIGluIGt2bV92bV9pb2N0bF9jcmVhdGVfdmNwdSgpIG1heSBmYWlsIGFm
dGVyDQo+IGt2bV9hcmNoX3ZjcHVfY3JlYXRlKCkgLT4gdm14X3ZjcHVfY3JlYXRlKCkgYWxyZWFk
eSBzdWNjZWVkZWQuIEluIHN1Y2gNCj4gY2FzZSBrdm1fdm1faW9jdGxfY3JlYXRlX3ZjcHUoKSBk
ZXN0cm95cyB0aGUgbmV3bHkgY3JlYXRlZCB2Q1BVIGluIHRoZQ0KPiBmYWlsdXJlIHBhdGguIEhv
d2V2ZXIsIHRoYXQgbGVhdmVzIGEgc2lkZSBlZmZlY3Q6IHRoZSBJUEl2IHBpZF90YWJsZQ0KPiBl
bnRyeSByZW1haW5zIGNvbmZpZ3VyZWQgd2l0aCB0aGlzIHZDUFUncyBwaV9kZXNjIGFkZHJlc3Mu
IEFzIGEgcmVzdWx0LA0KPiB3aGVuIGFub3RoZXIgdkNQVSBzZW5kcyBhbiBJUEkgdG8gdGhlIEFQ
SUMgSUQgb2YgdGhpcyBmYWlsZWQtdG8tY3JlYXRlDQo+IHZDUFUsIGl0IHdpbGwgY2F1c2UgSFcg
dG8gd3JpdGUgdG8gdGhpcyAoZnJlZWQhKSBwaV9kZXNjIG1lbW9yeS4gWypdDQo+IA0KPiBGaXgg
dGhpcyBieSBjbGVhcmluZyB0aGUgcGlkX3RhYmxlIGVudHJ5IHdoZW4gZGVzdHJveWluZyB0aGUg
dkNQVS4NCj4gDQo+IE5vdGUgdGhhdCB0aGUgc2FtZSBpc3N1ZSBleGlzdHMgZm9yIFNWTSBBVklD
IGFzIHdlbGwgWzFdLCB0byBiZSBmaXhlZC4NCj4gDQo+IFsqXSBBbHRob3VnaCwgc2luY2UgdGhp
cyBtZW1vcnkgaXMgZnJlZWQgaW50byB0aGUga3ZtX3ZjcHVfY2FjaGUga21lbQ0KPiAgICAgY2Fj
aGUgd2hpY2ggaXMgb25seSB1c2VkIGZvciBhbGxvY2F0aW5nIGt2bV92Y3B1cywgX21heWJlXyB0
aGlzDQo+ICAgICBtZW1vcnkgd2lsbCBvbmx5IGJlIHJldXNlZCBmb3IgcGlfZGVzYyBvZiBhbm90
aGVyIHZDUFUsIG5vdCBmb3INCj4gICAgIGFueXRoaW5nIGVsc2UuIFNvIF9tYXliZV8gdGhpcyB3
aWxsIG9ubHkgcmVzdWx0IGluIGRlbGl2ZXJpbmcgdGhlDQo+ICAgICBJUEkgdG8gYSB3cm9uZyB2
Q1BVIChwb3NzaWJseSBvZiBhbm90aGVyIFZNKSBpbiB0aGUgd29yc3QgY2FzZSwgbm90DQo+ICAg
ICBpbiBhIHJhbmRvbSBjb3JydXB0aW9uIG9mIGtlcm5lbCBtZW1vcnkuDQo+IA0KPiBbMV0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtL2FsNHJOcXBCWXk4RkdLUHdAYmxybmF2ZWVyYW8xLw0K
PiANCj4gU2lnbmVkLW9mZi1ieTogRG15dHJvIE1hbHVrYSA8ZG1hbHVrYUBjaHJvbWl1bS5vcmc+
DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
