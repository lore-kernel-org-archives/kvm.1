Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03193EFFCE;
	Wed, 27 May 2026 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902270; cv=fail; b=HZtkVAHsAPnl4JCmcWHXNynieVuVnqb9ZDa2GB+jBK3vXQMKcw3LBx5oy44sFVMjZddSzVioy1sfvhwtmEHaAYs00sf5mWX0vv/NfVOKa5z+CrLejDIQgqYoL1Zkm5KPf89dGcahYTXpnfttIrZX7qBNCIld2hxCStvhCeBUJvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902270; c=relaxed/simple;
	bh=MgL/HgdAYFRhRupowwmTU7d1uJo8VWIro+8ik9LJ1Yo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rzq/Fhp1CgP1fmIPZWqepO1Ym0Cm50Xiw2VMJ7Caya3Cpg2x4WzD+wNOGvvcTnqPYXMWyDPJ6Y0v5wA9T2jdxbUW56vdfNMAMiAC4DgrzIhrRpgEdCi304jsglx9SLGOohklU7TZIvJsnZdVYC5oyRTjMeXuD3xont9zWeeViNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UO7G/9wR; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UO7G/9wR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779902269; x=1811438269;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MgL/HgdAYFRhRupowwmTU7d1uJo8VWIro+8ik9LJ1Yo=;
  b=UO7G/9wRjMvH2smmHxncQ5pdZsjtFeN2Wuqp68ZDFl80dYeIuf3bElSp
   MLev9FhvdeZcDhVpNDDt5M79lLmvRy2h5qC7IX9X0Ms8uXLFjZBHR3Rsi
   9MP6Ubfg/rUbMeHKAohaBOLuGF7boT0knglnQYUE9lMAsD7iZJpitcR7g
   5cG18XCrDXffK331jXK5ANVkfgiC5B7rbjkNbrMYzFRo6PL+iu5aCjAct
   Kp2F4TYrNtEwcJMhImXer4VQqX0Yj06DgvUyZsWVWJJoLiWTqcfAkna9K
   MfJ/qnOiMkdBU8BhRHargleniiDeiYMtV81vRsF677KM8p/GyzyBSm/m8
   A==;
X-CSE-ConnectionGUID: 5ljbvNuQRF6SNN68q6vSJQ==
X-CSE-MsgGUID: AlQLb48FSA+k0K9kgvQbgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="91429195"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="91429195"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 10:17:48 -0700
X-CSE-ConnectionGUID: qkipW8MiQ8+33hfcrySbiA==
X-CSE-MsgGUID: T/2R0yKLTOyfCvPZEJ4Ptw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="244124966"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 10:17:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 10:17:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 10:17:47 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 10:17:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+t2s9U5awH6E+wZG/GqECnjxlXr+JFf1zMnFGo/JbVTy2fj1JDLUZ4jGjvFHxY+ilYpSQzF71203urUgpj8s/QvlBJd50eF1QcrHy+nVgQ39/kWRF8LcFhrJS1DGB49VC9y2wJoTfDe6viuuem0iwGtG/OzzjsAX3yLdwJWPOWI3AaD2bDHjMLsxt8ugXQSv4OSdAlmTCyULc7mZnqVFVK1M6trjVKkI49QV1yW+ThzmqroLeBpZPNdMcDTC4ZKAJmTFnz+2MZ7xJsJb160yrWE85bCljNRUng/tr7KIhpmw9zVoi7KwMxP3APBWGV/T8Lqml/R4p5YI4dChptKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qH5kYw6nejVM2Iz3QVMOd7FBe7mPHi1Rm4yrCBK0ztY=;
 b=bLwjfRu6zYSz09wxCJ8mTH//Hg/4/1JQDm3g6fy+8EXsrAliG715hHZncV7gN7ZhFgLW/dF6xAWxVAWQMNs+PnriIXdzqi3DX97GcuNB8TVJPbADkakMc17Uyr+83DEFhHJGkwefQ8I0zKFrG3+VkUmgmUj/UN3Z5zixNTCQjDPKKSrbXHYjPkbFy3SP3tDToZv2ze8dIFVN1QzwGpHk3851Hx22ySoAWhpFZs0CqHbE5dJ/UuzqASn3O1hM9N7DKWLxFkYMBjTwI5p+4g+GLTjF9Ws/sFRtJpUup8jXVxhBpZJe/ENxHcHJf0XsHaR7+E7+wNCQ97pDfrQ26pa/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Wed, 27 May
 2026 17:17:39 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 17:17:39 +0000
Message-ID: <cdfa241c-2d8e-4aab-8491-1de4a54e8a59@intel.com>
Date: Wed, 27 May 2026 10:17:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <kas@kernel.org>, <djbw@kernel.org>, <rick.p.edgecombe@intel.com>,
	<x86@kernel.org>, <peter.fang@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
 <b25e03ad-0bf4-482f-86ec-eebc6ac03d95@intel.com>
 <ahaZPjf+A7ms0Ba9@yilunxu-OptiPlex-7050>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <ahaZPjf+A7ms0Ba9@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ec1264-5fb0-46b8-7c69-08debc13dad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AReS8DcKB+6ZYEnT5AffRWczh6EzJuQWlwB8Bcrgk1/IbosvYEB8UErdzQLPA6pPwAas+c32biwpRADrrM0FmJayXrTmK2R+/XiBRw//vX1S/oKhi8iXLDBHbLW1VClxBbbxF7mMz+FMXsV1X1N7tkx/Q1eQ6D//2u2wdh1WuwnBhgFsDlFmrRQu5rtQyH77IM1yT1ZlYXdA0ktc2EB+WczJGWc8zrXjT3Vp302qd2gRS/OsD0XEACs2Xw8e0mXwvFmBGUW95DDwY+nNrohv7fjsy3lI5l3XuftI8r+2zwN2XcN/jcXubbnQRA7ZWQ/vv54zOVR1pudcSIVpFhzmgXG2pFYw0jOvTUjYeFXQP8t4ojKnOcwqzeo/mKCy+3GPUB1/XeNSTlqyejWQQUQuMWqe7lHuNlL9kbGwfEzUxdHFmDPhUk6dcrOs97XF38o12WzBkuyo1kdj046BHvZiqKIsQ1fNKFTs1zTRZ0+6OOnrNplebjYhCTtd1tbI4/ZW/g8h81lAAv1EKnJJ9AuWMt4O51sHHVyHEWwGlMYspj023yHNvbBxHXX7IB+sS3FW4jv5KR9b3WKwv9V7sL8IrR0Pi8tV6QlSpEbeT398w/L0WoV1cF8Ou5IyP/XJK+GJhcpLont5UjskP+847monD139LT4+5fCM3SXG7QDJkOBfJGE4WWlGyA7QpMoR4KL/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFFQcTZ0QUN4cmk2ak5oMW4wSHRHRnhPZTNwNE9tbUlPTmZKZGdPSkY4MG1l?=
 =?utf-8?B?RW5ZNnBwNWpCQmdUNk15NFhxMG1GRHUyQ1pFdkIyNG15dUthRWg1aXIxYzVY?=
 =?utf-8?B?MC9pY0xUc2hBN1k1cU5vUm45cDlaUHBrUVFnTi9wcUhOM1cwQ1ovTFJiREZB?=
 =?utf-8?B?eE9ZMmJOMWVIN3BWak5ncFF6YlB1WnN3ZndkeTRzcGUzcVM1Rmwralhib1Br?=
 =?utf-8?B?M1BHRFAwWWdoMGFxc3FBYXRBZFNaVGs3b0pMMmtWeUxFOXYrWDRZWnp6OWc1?=
 =?utf-8?B?czVoaHdaanYwUk81OU9WNnkwQTY3MWRnZ2Rkb1EvUFJHWU5DSks2TjZOQnox?=
 =?utf-8?B?N0ZWMFdLb3dLbUNOM1RLazVzZnNIRW1PeGJ0RE1VbU83eGJSRit2cmtDRS9l?=
 =?utf-8?B?M1hmUjVweHg3SUMzM3lJRUpYVWpOZ2VZUUM3b1M2MGpvT2RjelMvckxjRUlT?=
 =?utf-8?B?aWo1RmQwam8xOEE1SWVadzBLVHFQNi9mVEtrd1lRam5TVVlMeldSNnAwNjBD?=
 =?utf-8?B?Z1FHRDZrMmN6eXhPWG8zNkkyR3crQ2huRXRwZjlGYVIzaENCZDhoUHg3RVVz?=
 =?utf-8?B?VTBvWlNPZzZYWEEyUDRtdkhKQnRaVjhQZzByN3ZXVlJjR05tSEtOOGJIWmcr?=
 =?utf-8?B?QTBOQU1LUU9aSk1zSFBrYlBvQllieXFkYlNwZE4xc041SVREeFU5ckhxNFc4?=
 =?utf-8?B?dTh0SCsvbGowcHNGZ0V2SmpvSVZwY1ROK3A2QUhQWC8zY3l1OFF3dGJHNkE2?=
 =?utf-8?B?N2tRcnJpdFNxUGc0V0JmYVpoRXlxL3FOODAxTkxCdUk3NXlRcmlhdXh3VVpY?=
 =?utf-8?B?T2lFQVQzd1hxbzM2RTIxVTZhQ3lCbVNIRmZld2kyM1V5VWRjRURjakJmWFEw?=
 =?utf-8?B?VTBUM0RkRGpaOStkcnN6UGp1dHlQRUNFajJPNU1TMHBrdUdreE1QUlp4K0Iw?=
 =?utf-8?B?TlRpNUZxVjZFL0RQalcwMjdTRlNZdWZTbU85WVlVQlZiVHAxdmRaOGJ6Q1Jl?=
 =?utf-8?B?eWc0N2dPZWtnRHM3ZWQwQ2lZb3p2QTdIc1NrS2VkQVdUYVdUUWlCcmhNTzdJ?=
 =?utf-8?B?SHVIVVV3azA1RGtjajVYMnVTWWIrQVcyRUttWXJnL0s2N3pxcmtaTmVpNlpB?=
 =?utf-8?B?aGczbEtHanJpc1NDckdNb0w4K2hyS3VpM1U4UjBPck5mV3Nib0pTd3Q1YUdm?=
 =?utf-8?B?UHNyQm1EQ3o2ZWdRaFIxM1d4Zm5NS3p2a004S3NnUnRWR2srWitIMzdOV1c4?=
 =?utf-8?B?V3Y0Qm15aU1BMVl4UkpLUW5FTERCaUozV0ZLRkppdlc2YXRZYXVEWmJ2K0tz?=
 =?utf-8?B?eHU2TEhtdU5RQ2J5SHA2bXB3RXoxTlRONG15akRJYloxUHpycTJXNXZHOFRT?=
 =?utf-8?B?K2V6VmUyYXJUY1JkM0RLMG11bS9OemJ5ZlFBc2dDL0h2bitYMDg1QmJmOEV6?=
 =?utf-8?B?VzM4M1pBdzVrYi94ZjJNZzZjbHR2V0tBNDZLbHRLSyt4VnVXT01jQTlFbkdy?=
 =?utf-8?B?QlhoVG9Gb1lXMEdPUEllbjRTV3lVc3VXamNESXg0a2c3dVY0d0VIWjV0OXpX?=
 =?utf-8?B?WndkY0IyVEZHQU15Si9leCtRN0hNL09lQlVWMldRdzliVGYzYVo3anlubExR?=
 =?utf-8?B?N3JZcGl0d1YyR0V1c3paSk92ZFJVMWRnUkx1NUNzZGIzQk13Skp3TlFZeUFh?=
 =?utf-8?B?NUVLTDM1emJCb1UyQmFQVDVKMzdEVFpvcVQ2QjhPYUtMU3lmN044WFh1MWts?=
 =?utf-8?B?d0tZRGtrdXNFcnV2S29XQlhLaC9NaVJpL3FTdEZ3ZE90ZkJwd3lJb2xQSGJq?=
 =?utf-8?B?V3draUM3R011Y0NXb2xiOGhzUUFZR2EyRXZXaGJqQmwwU0x1UXRZODZSeDJa?=
 =?utf-8?B?M2hjYk4reDUzRUkxdEIvUUpJMXpWWFBYMUk5TDU5cmltaGtDdjEwdFQ1TllQ?=
 =?utf-8?B?a3lhZ0pvQ0hHeDIveUovTkk5T3k4Y1ZMMEhQVk9QbFBnRmhNWS9jcS85cG5R?=
 =?utf-8?B?N2lUKytOS25lYmhNMkhQUjhuL1VPMjhab1dxK0x2YmdHZ0lEYVhwKzR1ZnJW?=
 =?utf-8?B?ekpmNG9xYW5DbldmN25FQllReG5RTnQ3VFBrR1JBbG03eUc5ZWpIKzNrQkc3?=
 =?utf-8?B?dHNDRTNwalFmb2RhYzU1M0dpZ0k2akhiUWxaMmNJQUM5Nyt2NENyUmNzRGlL?=
 =?utf-8?B?aUZRU2dQZEkxVS9XYVhRcGpuRHBtMlp4NU5iY1Q0clZTLzFhL0dQR0FtQXlw?=
 =?utf-8?B?cDduazQ5VVBPYnFqQm1Ick8ySGE5V2xPS2V6Rk5pWDdGanowUGRYNGc3YWNz?=
 =?utf-8?B?UktSam52UDRkZlFoT0dweDIrcUlIL2tlNWZaY1c4bmNEMVlGS1R1QT09?=
X-Exchange-RoutingPolicyChecked: SxrtGRz3+OevIXMc1XAK+kUEwMqZc8uRrcMrExIGJm7Lpt6bNqML9JNc50kzXcmqYBxwD+lgI5Y04bD8aHmohSjgkBgvwhX4FAD+lIkIggK41OkgLZTZvpPioRFz8aOn75h179u6jJyfBOhnSbJ/E+0vT4CV/UCFUqlHNepif+Ee2xM9DqNzt5C6syrJwMSeU8OVF7mN8Gdgo61QFyCMAjJrRriGfL6WcCMEppL3snYnbputxQwEdrWxbDPTPNnbtcyr4vdqY4+yDeEijbb1lW9vGOaXy45AACdguxUClV8BDxpNrY4sjOcLRh2ZLLAbYj1PGEcNHFMcDLc2eTcuHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ec1264-5fb0-46b8-7c69-08debc13dad8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:17:39.6584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8U2ZtcXXwO8Bc3HceTdCCsph0YnwJptASZVwOdvdDNL4YNqUr6+28LHbMzMWQO50UynOPpGexZ1aujw1Vy4qCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com

On 5/27/2026 12:11 AM, Xu Yilun wrote:

>>> +struct tdx_sys_info_ext {
>>> +	u16 memory_pool_required_pages;
>>> +	u8 ext_required;
>>
>> The name ext_required seems like a boolean. It is also used like a
>> boolean later.
>> 	if (!tdx_sysinfo.ext.ext_required)
>> 		return 0;
>>
>> But, IIUC, is it actually a mask that lists any feature that needs
> 
> No it is just a bool about Extentions needs to be initialized or not.
> 
How does the kernel know which features need Extensions? Is there any
hardware enumeration or the kernel just keeps a static list?
