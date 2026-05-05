Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42A23BD06;
	Tue,  5 May 2026 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004341; cv=fail; b=pGE/jB31wZNJqy7DQxb46SbaZbAuM3/3XHxAw52LpAsg31gaWf7bNSFP1JdESqxIrSFpzBU4EON+Toxj3CReJdc+0Tu5YQBQBiRcPnZd38IPVuRHnzpAPBZlsMW+6o8molLuh4/rsCGxC15tidv2DWJtoKBw7+yfLPEf9NHekqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004341; c=relaxed/simple;
	bh=i/u3DbTi2wwLeKPa3fTu/kms70VqCOu81SIm3v3/vAA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XuYKtLotZfqRMGaB3T4IxRdBMRI6sV8ZgSu/yCG8PYugQeMxNI4yBQocQ7KRJfSqXVpisaFhEXipYsIwAzLm3HgzOh9RgKm+O9hMvGHfFIWN7YCEZQHcXpOich0NVK1eXHzOWzrFxg3fL72Ggk6cbe6usUTx7QpOWt4psN9UUzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hC+ZjFA8; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hC+ZjFA8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778004340; x=1809540340;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=i/u3DbTi2wwLeKPa3fTu/kms70VqCOu81SIm3v3/vAA=;
  b=hC+ZjFA8494Z9O7isoPa0XLVUzS59D1DxQrMjIhqrofRG28VefOc3oyR
   siQ33p7adyHTqIX2Cr/Iid39fBsXsV6VIpOVYV4Y1g/Kg8i5ugXqx2W8/
   kdg1kplE85jv0ftd4gnJnwEhT5dL4MfNBfYJdYacyXx9jJD2mYF/NtH7c
   umOcfcoaiNr+P+kUI1MsUcGJQnQrwRw0M+7yfT/2SjuIsoZXVydL9dBmH
   sim0qfYaKsEh/hljIJLYk0QmRq0xfdcn+wSo30m0mn/6MaAMXrGRyft7s
   8M+ywE22IyjhGMtEqUAg1plZSPCUWBEfNTsKotl2UUbpD73jJGi2EhBpF
   w==;
X-CSE-ConnectionGUID: nLd7Xi4ZSFW2cdBp0oStSQ==
X-CSE-MsgGUID: v7K/xTOeSpuO/PKQngKNDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="66413184"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="66413184"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 11:05:39 -0700
X-CSE-ConnectionGUID: DOY9VGGzSD+sWICq9IZexQ==
X-CSE-MsgGUID: hVdDxBCiRROe1XxsQBY8Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="231296633"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 11:05:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 11:05:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 11:05:38 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.59)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 11:05:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9D/BLineF5xVapJjw48k2L9hN/eqcghQGq9f0SHSfIDOafh+zA8RZ2YYywmGrPpM15MjhzW6ZMbbaAXSMPAduXxJlS4+ibGO1aZKNyAyzRBEcn6eSCLyWuZwkghiWGda1fz25K5xlvgt3dZwRZiuNzpVHQUT3c5fQa/+I/QUl18dEsEo2gyck/iOR1xkSxZ80kjeJJwOxxQTkpm0oAZecnKFvNpF/THM/ZS3lmMQlcGWerdMxXOHwzO0GR52n5zwykN/lS+afMbCCsLAX5ixmSouAX1Ahzvlg1lDFC8TUYEhx1Un+xEsok0yo6xxTN0WVaxZykoHrJSkmpW0EvYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt02yZTNDA4e+0UV4djGGXL8XKzKcYLI2KRH3E26SqI=;
 b=TOA28SomNMvL+5Vca9YYqA/v7jybJrGrTKL1wu4KViLcvTBZ8rTvasea6l7HWduxmAN4hfHx01DeDPP+7rLIzhHoB4QV1z4ecIstPKqk+XFCgiuiH7esyIf7iiP6S88QILHySmrZZWv5o7NbpznoITRqBIaZg8IYcaqJ0G9NZVoKvpBowHp/41ySPvJrw+3mFpqCKMvQ4kznzBSUpNkXUfh/FsZ1c55WbQ7/S8OLMvL7zynv0TmNKuSp9iV6EbRCuEE2Hd845+kFtSVaaiA9vNzpR0ltgxYhRFiIxV3IfehR11V3BBCR/btLicDQa0f3TMC9GoK+bwUxuYj7hfOsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3282.namprd11.prod.outlook.com (2603:10b6:208:6a::32)
 by DM3PPF74831EF4B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 18:05:35 +0000
Received: from BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19]) by BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 18:05:35 +0000
Date: Tue, 5 May 2026 20:04:58 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Xin Li <xin@zytor.com>
CC: David Woodhouse <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>, Andrew Cooper
	<andrew.cooper3@citrix.com>, "Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <chao.gao@intel.com>,
	<hch@infradead.org>, <sohil.mehta@intel.com>
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
Message-ID: <afojoHJSlqqm2Ges@wieczorr-mobl1.localdomain>
References: <20251026201911.505204-1-xin@zytor.com>
 <7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org>
 <DADE0E58-DD8A-4206-BF54-1DA87864117D@zytor.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DADE0E58-DD8A-4206-BF54-1DA87864117D@zytor.com>
X-ClientProxiedBy: DU7P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::24) To BL0PR11MB3282.namprd11.prod.outlook.com
 (2603:10b6:208:6a::32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3282:EE_|DM3PPF74831EF4B:EE_
X-MS-Office365-Filtering-Correlation-Id: a17300e2-e4e3-4c74-06aa-08deaad0e65f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: J4Yj4NivMNrIqtZjD8a5ob4UWxudHxqqwCq9OHXYi5II75pR4DfkxpAKuRKjPMDftkQzLBRbxJzAiPSyR1cNKZgraAKMXMMeOycgikySqFyy3pdbT8AzXsN5a1xU2Flt3ICw4LXCH1ldUjuZgtdZw4CXCPLjJk+z2bDyBYlyvXtgPW1r9iZz1wsZBvhc74Q67pDr0swTOMNoaP+KpgkumXKbU5a9uuRunOrEKGGKC9u1K1OOIGfpvNvys/bijX5AgVOupGKz4w+4RIfveA1vdeBBd3uJVT5AoJw/l0qO5HtNJOy93Oabt9xrJuAjaQI97gnHW48oRKnp2yk2XItcksiZGFd+QDSgD6j10reFRxudVItgGPWwoOuRaHFaSxudOzNtZXXWXxyv+BL8gbZBQM6GIvyFBna28gW5/XSPwahKAeMRvQWonUbkNip40ecYHRQYkztve+dBTAFLE4FX7Iu8l11stw7WTTvrXcPmYUiFE7kHt9dZjrFqLb+y/v/rXHrTlBYhTs+ENZPM7WynruVhBR1UDKDmMlAbuF0O8AoB2mH2KJuPeEHrsKwHKXaaevH9SnMsDH4Qtob+Y4zQoaCPR4rfCkCLpbxHWiLqarOQx/+MGOdHXw/gQrubKE7h4pWVGAgZtPciIkjDTTyt62GTTTO5kyqp7I7+LX1MUjB39o3db2XlKCzAHM2JHVue
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3282.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REd4bnd2czVkaEpGaHUwM1dYZGU0WTlNTkRjdXY0aWt4TklkRUNPaEtENFZi?=
 =?utf-8?B?NXp1elNseU5HNnNnWDNmQ1NrTFBFdW5nL0dMWjg0RU94WVRQVDAveW9DZThD?=
 =?utf-8?B?VEpYSnNwMG1QWTFycGZyQWFGd0JlN3Y1RDFkSDJYNVpRejN5WStyaWZuV2Vk?=
 =?utf-8?B?OHF6OHlUUUhjNTlpaXFYenhPMXlsUUtDeEZkSXRjWTd4SzB4TTg1bWZxMWdn?=
 =?utf-8?B?VXNLdjVUZ0pPWk5RTEhzMjRybFgrSnNuOTgzZW5pNmx4WGVodGF5by9tKytU?=
 =?utf-8?B?Z2xoVDluTHlpdzcwWnBQMmdVWGFRWUVwdllja1hiWHlJdGtzUVZvMEF6WVVU?=
 =?utf-8?B?N0Ryd1BaNnMyZ1FkT1p6ejNXNWlmQzhYOUJWQUJKUjd0d0Z0aFZxOS91Ri9l?=
 =?utf-8?B?TERhdytLYjhMQklHV1ZOei83M0VUWTI0eG5PVkpjMnlGdVozMnJ0aHduNWpZ?=
 =?utf-8?B?UFpXRG4weUVzQUI5Zm9zeklyMnJkNkVKYi83bHpMRVJsRlN5WHJuY295UWE4?=
 =?utf-8?B?SDFzUy80cVB1b0w0NE16L3phZTNlTm05c0hUSG1seGd2bUxScFRIMHRJSjBD?=
 =?utf-8?B?NnBiV2piSHA4SGRaVEVJQ0tJZ3gyRlQxbmxOVDVwNFhwOHJTdnAwNVMrZVFM?=
 =?utf-8?B?NUhTV3BiUWJISlFnRjJtN3A2S0VJK3J3SzRNSkViNlVNeUY2aFBIc1ViRS8r?=
 =?utf-8?B?TDZVaENYaUJxNXpGLzFuRlJGV3U2eC9rK0JNNE1GUWlncDhYREsrbGRueWcw?=
 =?utf-8?B?VDcraFFsc1NraXhOYjVMR0tsTlNNdXB2Q0dSU2phRDcwU1BCVjM0RVdKdFhu?=
 =?utf-8?B?eS9UWHJ0V05ZdDFTMExxL2RTdGpUM0dNbVJwbkZGSzBXNFhUd21kaHNya21Z?=
 =?utf-8?B?M3hqNTlndTZUVWZVeHRzZXhUVmpkV0ZSWXdDb0xZUlEyalNkUG8vY1dhb3dX?=
 =?utf-8?B?bU1KdE1ySXV5eVk2QUk5SHZ6Z0EzNlJwL1hsVmpHdm5QT1Q2eDV2UlRHTkRa?=
 =?utf-8?B?dVVwTDFwODRUZ2hoZDArR0tLSmh1TFlEVGZGZGVBTHRoREVKSS9wQWxZNGNP?=
 =?utf-8?B?UWpnMStMdjU2WE15SmJtTGx0aFpwUEdiMmNTaUlnVTRSWVRZYVBmZHlXN01T?=
 =?utf-8?B?Ly9zQnhMRitxenIvQ2R1R2J6LzNXL0Nnb1l0WU9OVVZWL3FwWjJSbUpVMWty?=
 =?utf-8?B?Mmd0bkNPL2tOSnlMNmJtVUFnZG5kY0JmZGQvLy9PeG5CUS85RS9FanVyOWpY?=
 =?utf-8?B?QkVlVzB3MlhxdVA1Yi85VWtOdEhrUUtkT0kzYXBWTkxRbkRRUXRFeUhnbU82?=
 =?utf-8?B?cHRLenQyUy9PeTBnNCt4NFYreHhwUUdXMXhnY3ppa0FBOFpySkJRbVJacXRl?=
 =?utf-8?B?a0hFdHhtNzBxOHpaS0FudU9NU05SakY0a3ZSWWJtVnI0NXU2K0tOMHBHOGx0?=
 =?utf-8?B?bFJEaEkxTGliZWJJSkd3SXRiZlRJcWttdTR0ZGhhREJEeFE2bVBXQklNLytD?=
 =?utf-8?B?ZXVnZDBTWXpBYWNRZE92TmhpSEZmdGlLZm5lTzQyUURwcnpvMkdPSk50YWlr?=
 =?utf-8?B?TERZOU9Kd3ZDYnFMRUkwQWt1OVJldWovTlZCRVhoZjBjQXpOVnJyUi9hL2xn?=
 =?utf-8?B?clkzalBWd2ZRY0ltc090ZElOeURWMXFQeTdQSHphY21XeGVxaXBNUWc5MjFX?=
 =?utf-8?B?WkovRitYR01PeG5kRWJ0dnBOV0J4WE04NUZjc0pkUEV2bVhyMEpGRzVxVFhY?=
 =?utf-8?B?bGVycXFUbE9KejVpL1YvVUptYUNSS084YWtvNVpFM2FDN1NjQmgxOUtSM2Vr?=
 =?utf-8?B?dDZON1VGcmd4RXVEMW5QYkFWREdUeHUwK0xvVEVneGhYYjJ2WUpDWDdKQ2tx?=
 =?utf-8?B?UTQzWWdxV1hUTjZwS2lmR3JYOUE2TWNxOHRzMloycjRIY3B4MkEvSWVpY1hV?=
 =?utf-8?B?UjYxbVMzUzNuTkFYUHRGVjJ5VVdyMFkrYjhVY1VwZzduejRxRWFuVndJWlJq?=
 =?utf-8?B?Y0g1N01ZYnhBWXltbGQ4L2JGNUdwbFV2R0lyRWxIR3R0YkJUYzFxQ1E0MUw0?=
 =?utf-8?B?dS9IdmRyeTJCOGF6eWJVV1RQNGthS3QvbXh6Y1NoM2ZhYnY1L0F5U09iZkkv?=
 =?utf-8?B?WFFnTjhFV0tIaVZoWk9mUXgra1U3RU9Ja0J0ZnRlWUUvbkh2b0t5VU5WRWxV?=
 =?utf-8?B?Qk9GcFNORjJDNlN1eHZRNnAwTEg1VE5aQ2Jpa0FXelJOSDRNSklKS2NMZ00r?=
 =?utf-8?B?MzZiS00xQmFuaVBsZzBja0hjV2x6QTFmcmV0RGMzbGZvM283b3VzaG51d01h?=
 =?utf-8?B?UmNPdUJVOTVhKzhYbjIyRDNTUG1xS2Jna1hwQkw4NGVjcm96dVZXWVJzd2Z2?=
 =?utf-8?Q?U6UGB4GT3uLKlVaA=3D?=
X-Exchange-RoutingPolicyChecked: ZowMwbQ5/RoE76iho94Iw+zVu61pwpVClzTCutnuqx1K+Y2cDO/5VoqD53dVRnKBXwLAXUxx5YarpmPmY39DHFASuGtbxfzrONChPF55GqYO7TICvTjwAcPMko7ntb/57EF72ZWwBBumt+EQoDs+11iblUIcsbHid9zrEZ6jYBn6bSerAphSNK0MGRxsbSkhVqIwUT2MU8vPH+dhaZX5q7rjjnPzy0JjUtxpxNzyubj4tUv2Ljw0rg7f/tk6NsGjdcrObNN3jX504mgdxDzaHqQKEjN52v42kzUkPg0fh7c5gJUEPFdkf6y2QvNZnBRetANehyWuP73F5sNdG+4bfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a17300e2-e4e3-4c74-06aa-08deaad0e65f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 18:05:35.6340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YGZ9kus3GxjlbhYOADdiZgtsrZ2RtRPYLXQ6boi/3FuTkE6j0ErvWPzrs6VmFkKumpWYgd3e0/0XXfV4PejUupjK8PEsAPPTdk/K6O2Ai8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF74831EF4B
X-OriginatorOrg: intel.com

Hello!


On 2026-04-23 at 15:56:54 -0700, Xin Li wrote:
>> On Apr 23, 2026, at 7:35 AM, David Woodhouse <dwmw2@infradead.org> wrote:
>> Here's one to get you started (untested as I haven't found suitable
>> hardware to test it on).
>
>Same here for me now :(

I ran David's selftest on a PTL laptop and ran into a couple of issues.

>> 
>> From bd465aabebcb124e09a26fe9f4c861354febabe4 Mon Sep 17 00:00:00 2001
>> From: David Woodhouse <dwmw@amazon.co.uk>
>> Date: Thu, 23 Apr 2026 15:20:11 +0100
>> Subject: [PATCH] KVM: selftests: Add FRED event type classification test
>> 
>> +static void __used fred_handler(struct fred_stack_frame *frame)
>> +{
>> + fred_ss_value = frame->ss;
>> + fred_saved_rip = frame->rip;
>> + fred_handler_called = true;
>> +}

fred_handler() has problems getting linked:

	/usr/bin/ld: /home/maciej/linux/tools/testing/selftests/kvm/x86/int1_fred_test.o: in function `fred_entrypoint_kernel':
	int1_fred_test.c:(.text+0x104): undefined reference to `fred_handler'
	collect2: error: ld returned 1 exit status

I guess the .pushsection below makes it a different translation unit? Because
getting rid of the static keyword takes care of the problem for me.

>> +
>> +/*
>> + * FRED entry points. MSR_IA32_FRED_CONFIG points to the page-aligned
>> + * base. Ring 3 events enter at base+0, ring 0 events at base+0x100.
>> + * Since ICEBP executes in ring 0, the CPU enters at fred_entrypoint
>> + * + 256 = fred_entrypoint_kernel.
>> + */
>> +extern void fred_entrypoint(void);
>> +
>> +asm(
>> + ".pushsection .text\n"
>> + ".global fred_entrypoint\n"
>> + ".balign 4096\n"
>> +"fred_entrypoint:\n"
>> + /* Ring 3 entry — unused, no userspace in this test */
>> + "ud2\n"
>> + /* Pad to +256 for ring 0 entry */
>> + ".org fred_entrypoint + 256, 0xcc\n"
>> +"fred_entrypoint_kernel:\n"
>> + "movq %rsp, %rdi\n"
>> + "call fred_handler\n"
>> + ".byte 0xf2, 0x0f, 0x01, 0xca\n" /* ERETS */
>> + ".popsection\n"
>> +);
>> +
...
>> +
>> + /* Test 1: ICEBP (INT1) — should be EVENT_TYPE_PRIV_SWEXC (5) */
>> + fred_handler_called = false;
>> + asm volatile("lea 1f(%%rip), %0\n\t"
>> +     ".byte 0xf1\n\t"
>> +     "1:" : "=r"(expected_rip) :: "memory");
>> + check_fred_event(expected_rip, DB_VECTOR, EVENT_TYPE_PRIV_SWEXC,
>> + "ICEBP");
>> + GUEST_SYNC(0);

The above event type test seems to fail and return 0x3 instead of 0x5:

Random seed: 0x6b8b4567
Testing FRED event types with EPT fault on stack
==== Test Assertion Failure ====
  x86/int1_fred_test.c:120: event_type == expected_type
  pid=16646 tid=16646 errno=4 - Interrupted system call
     1  0x0000000000413349: assert_on_unhandled_exception at processor.c:659
     2  0x0000000000407d36: _vcpu_run at kvm_util.c:1703
     3   (inlined by) vcpu_run at kvm_util.c:1714
     4  0x0000000000403104: main at int1_fred_test.c:207
     5  0x00007ff8d4c2a1c9: ?? ??:0
     6  0x00007ff8d4c2a28a: ?? ??:0
     7  0x0000000000403314: _start at ??:?
  0x3 != 0x5 (event_type != expected_type)

after a little digging I think the issue could be this in arch/x86/kvm/x86.h:

	static inline bool kvm_exception_is_soft(unsigned int nr)
	{
		return (nr == BP_VECTOR) || (nr == OF_VECTOR);
	}

Since ICEBP(INT1) results in a DB_VECTOR it's not take into account and the
check fails. Then in vmx_inject_exception() INTR_TYPE_HARD_EXCEPTION is picked
which is 0x3 when decoded.

I think you'd need to add another check in vmx_inject_exception() to handle that
DB_VECTOR too. Simply changing the event type if the vector is of DB_VECTOR type
fixes that problem but then the selftest fails in other places (assert
fred_handler_called and saved rip vs expected_rip). I didn't yet have the time
to figure out what could be wrong there, maybe you would have more of an idea :)

-- 
Kind regards
Maciej Wieczór-Retman
