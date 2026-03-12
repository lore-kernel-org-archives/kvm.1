Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F25B1E1DE5;
	Thu, 12 Mar 2026 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280834; cv=fail; b=QNL1tNe8yS1bXryB8XS1FRVNBSC0wupIApWkI26NhAKuYT2QylkECnDrHmA10A28J3XI8ZrCmaXnqC7DoiIp71CfLJwdwq5LMv18L7wK2qBlskyaR9lhrQWbaCBOy1T+c/4Te57n9HL+RClyvHgK9QYNSSisaNWg6vTqAyseInQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280834; c=relaxed/simple;
	bh=MGs98YLh9MHeJCjJcIcJG2alYIBmdcF/43vanOQDna0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KjKAvi3oJ3RtrAHKsv/+1iTcEVP0nK8rh93kCcR8EiZ+Tos3SshByvjGS69d5caMmPaHuuhzxUPONfqnaqi+MBBcDxhCtS9zBsdItT0L1tFP6lqJZuRRXaJ1y6CKDORf7xxw7LP2E/Rmd5U4xTmMVKvPcocai6z8lLHJcOfpq+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qih8oPhO; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qih8oPhO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773280832; x=1804816832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MGs98YLh9MHeJCjJcIcJG2alYIBmdcF/43vanOQDna0=;
  b=Qih8oPhO5JnMeix5bvHy1sJma2Iq8RwCQ4sDBwwh57a4eqWV0m8Gg5HZ
   6MOJCtU/OQnVjYcuA8CKXEwW1G67vILVnC3GNQGd8K31WRfu584M1gp/H
   0dYoDPYUwrmh+VJ34qXBg+xvUsqVyr3/jcjTfWuxZiHydZdSTrE2Xfoey
   HZQSTox3QcQ/3HaWvTq/8Myh8hAFJ4izZyq27xg4qX3wOI+ASqiPx/VWB
   u8urejDR98xCgQB94TQzvNkeJYNaF+hqBpsqWd0xNm3dwBhXTOJoPBHKt
   MS0GlrfrvCT9vb+hr6wGNvxNXciluccybz/NMvh8/VOZZ5pXlhd/p8sQg
   w==;
X-CSE-ConnectionGUID: u+bszaTmTQWh0Gc+1naeGQ==
X-CSE-MsgGUID: 6fL2iZ6zRzeTfCiOTE6pPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="99829782"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="99829782"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:00:32 -0700
X-CSE-ConnectionGUID: SX4/lXQyToyTslumT6N/Zw==
X-CSE-MsgGUID: jGrSBODYR3OpXL/INXSG8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="216838247"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:00:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:00:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 19:00:30 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOBqfeqaOMtMBMKSdnnGFabtUW8Uo95JSya3pUrS6euPnOH703b0/GjbtnhAYWtLqFr9NUW7uV04URgory/0X6hOjU8APWi6RefVkhiYc3/+AhiOVxE4mSSb9EgcdFQ3SCbUMB3UBoi14zMzaR/4tL0sn9JYsIzfsEMEPSZJln0u6L9b98PTTeeEoBYaOkGRa9bRZv71Hw6C8YXp0zsqoshuiUq2+aEqvAOn8MjzioxFOTJAdyOzsgx/R4TPbUVxqiuOp2rT/FHpgAxLfjeVzfK2KD+lmIEl/b/BiEqkFZetpmafc8Yr47xfK/sTvPtE1ymDHY7oGFqJd4bIYZlAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGs98YLh9MHeJCjJcIcJG2alYIBmdcF/43vanOQDna0=;
 b=UyhR+Rsl2iU5Vp7hH0JdkQ+GMDdfSPZAz4eODo6YHIpSxj/lE58fqNNiHEeOLdL9GWEND55iLHldxdpALBeITLlCnQMUaI8tP5xo+Wtognk0PJp31UULu/vJyLGeICUIJu3CyMa4Qo9dBcyDPf9iR5Cj0ZMON44VMSEFYPeiFfSjRW8QpVDVGvP3Sngsswx5hkyu2DzuTf68HENBCc4Md03bBd0y2CXv2aSH2XgPgux7aDYF3j845UFtHFYICodMXPmOpSdHoTjAg9Bn/zWPastPX5Z/xIVZtZLFOFoukI9SgFNn3E2r62Os0Yh+fSFdvSGk8+jPx+3t1D0BHZ5xXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY5PR11MB6138.namprd11.prod.outlook.com (2603:10b6:930:2a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 02:00:20 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9678.017; Thu, 12 Mar 2026
 02:00:20 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "Huang, Kai" <kai.huang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>, "Weiny,
 Ira" <ira.weiny@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kas@kernel.org" <kas@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "sagis@google.com" <sagis@google.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 11/24] x86/virt/seamldr: Introduce skeleton for TDX
 Module updates
Thread-Topic: [PATCH v4 11/24] x86/virt/seamldr: Introduce skeleton for TDX
 Module updates
Thread-Index: AQHcnCz8dleGg3tjsk+bFkddavHcSbWqT5iA
Date: Thu, 12 Mar 2026 02:00:20 +0000
Message-ID: <daa8080e1195f586af331dcf31ee5239c4ecbd15.camel@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
	 <20260212143606.534586-12-chao.gao@intel.com>
In-Reply-To: <20260212143606.534586-12-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY5PR11MB6138:EE_
x-ms-office365-filtering-correlation-id: e6fb8948-f51d-4333-4d2e-08de7fdb1db3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: p2nuGjfpKrDAbPHZ2OzDj38MKCtfMF7Gn7rPC0OoGMv826EMvwMP4UxmVCErkuni50tgS+cjRVMwE+Y0tkl3OYVQrvwKRzMoc+prZMo/vBxtBTeJDujB1Ymg2ej0mbcSrqmS8IHefpcvaCV6mXE33RMfNaexpcign6xb7kjJDQrWolC2vQt3IviOlkPt2MInhX8jpHLtSW1crNCyMN1zE3/Dpwybo4v9BjQiC4UkivSG5xzcA9779SIOy9lBkm75O6TUbirSJcp3dD5vbSXF7kQvPjKZw+1pVzIsPZA+ebKa9KLEn+14/xgHL9thAT+G/oVSiTfbiJxcU2Ar/MJODSyht9gC9Icu5cMUYYOg+qwH91+BIREA1jCQaPm/+Z20CIuAzM5zlpSvNhGUy/Y2dRUXxWDQwWCK24ThevUeOSx9gDfCTGYpRRHyEwwR7FeEEAetgc5U+lLlfoX1Xo44zQpwAQiEwkX7DgWTbBwUiT9hftTdeIkoEuXaRDTCtoO5x5j0sxoECftjGF6LsMFwMb2TLg5PAenVX/50aEHebT7E3LDB2/YXSPzEJAlz/yWBm1cVOddedT+1d6VOhYnMHMMOXrkJnAZUJWG/lVA9YI+Bt3DphUonD0W23CQ7RZjLtguJsdcsw5iTwzGFNcVDXzCCLM+09WkyM9zdBlWBzXroUfPQ5BCEqK/llV6IHVsuFbE51AM+NiKK44/+82938aYKYTX/rMJQnn1b/OlInRxSYuupq9JI2ayDJfaWxk+7K5TILz89rm07kXMo1/j3abaeu6hAh4ljNuWZvYL3sfA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnhteVIrTXlKOEhzYXlxVk9KeXVKV2Joc05sZGgzaE5hUmU5djlMMFNIK01x?=
 =?utf-8?B?dENTcDNNWG90citsRjRaUU9OcFV2TXpCUFRFMktTS1RzWDlyRGsrckppRFVy?=
 =?utf-8?B?ajdGcGhITEEvdzNPWUFXd1JKRm11TnpzMExwK0ZLdGFZN3ZpYWN6ZFZjQ0ps?=
 =?utf-8?B?OUFQNGROMEpCNE5IdWl6ZVd6cktUMC96WVpkUlZqNTByeXB2UkFydjZITk9h?=
 =?utf-8?B?Y09XNlJYSkl6NENJOGtBR0xwNVU4YnE1OEc2VmtJeEIxVnpMTzNhdk5sVGY3?=
 =?utf-8?B?NVI0Um9va3U2anpYSHdlMFg1YW0zcDhLdG52V2J2V0lhbGkrbmg5dGQ3bGhU?=
 =?utf-8?B?VTRnd21KTnM3cCtqZ2R2ZHkrSFptUHQxNlRqTVFpWHNsaWY3YWhQZzViUGQv?=
 =?utf-8?B?RTdralV4bnBodWx1SVpvZGRXT3hwYlpTK0lWN1RuVWRUTEUrVmJSZHBkR3hz?=
 =?utf-8?B?a2FXTGtvZ1dIRk1valBLTE9QQy9ReHBxc3R5WkwzSlZZOVU0NDhnYkRpSUM1?=
 =?utf-8?B?b0FZTkg3blRtWlRHY25aTldFNXF2NlNlS0NyZzRpS2VLQmZudjJyZEczTmVP?=
 =?utf-8?B?Y3cxSUpVSGZES3RzUFBHVysrc0xjcVU1OUNGWlpiZVVFd0V3U2UwYTdHV1Bm?=
 =?utf-8?B?aVhhSTh3bDJPTzVmb29hNVZJMisrdTRMOStSTGJDRlhqejFXSEpQWjU1Q0ta?=
 =?utf-8?B?Z3k0SVFWcnNiVzFmYWZ6WnM3NC9vSHdBa3NwTTZrc2wwOTdrVUVxOXA4WldF?=
 =?utf-8?B?alVTa2VtQ3pqcXdid2NFekFnZHZIMU9HMnQ3QUc0dHZIeGxYbFpiTklTUWtn?=
 =?utf-8?B?eG41MjJGTHJyWUNZY0lZMEY5Q2kyZy9jd2NISDJGa3ltLy8yeXc2YTVsNTVC?=
 =?utf-8?B?U2lvNThsaDJVRUtnV1ZkMEVDTEdGMzFKb3F6MThidUwwK01sK243M0R6ZTBS?=
 =?utf-8?B?SExWZWRnaTVpNHNaa1RaRGtEUldDVHREUk5hN0FIMk55L3cxU0t6bTFjNWl5?=
 =?utf-8?B?bDhDMWlBNEprMVcyZUFobkZrZC9uSkpSdmhwOVFNUzZyQXBMVWhFVEhxQWo4?=
 =?utf-8?B?K3Jna1NCNVg5dkdyNUk1bkVLWmM0T25XWWhBdno0WGFZYzljRnZQajJJd3V0?=
 =?utf-8?B?SnJLTTdpdzZKczJGZ21xMHJDZjJaNHBIckNxdGtEcm1BcjB3RjJYR2dOcHBi?=
 =?utf-8?B?V0t1dmR1L0VGdUowRlRubzErU3NMVDFaQnRzZ3dNTHlseEQwcDc2bERiR3U0?=
 =?utf-8?B?V1dZMmpCSXhzMk5RK09JbU9wK2FvZHFFZTZHZlpjVHlQRWZKNGhRbjBRWnJr?=
 =?utf-8?B?cHF0c2JUclhDeVBkRGhvODdFdjBmUWI4Tit5Nllkc2RaZVYwNHUvajZYYTk5?=
 =?utf-8?B?R3E0UytHYzJMckRzbk5IQzJGYWE0Mm5DN3Rwc0dDa2l3QzJXOFNBWDdubE5O?=
 =?utf-8?B?MFJzbFgxMnQ1ZS9WREYxOFVHVmdOcnE1UWdES21oblhVQUtTVGRmSkUrUVZF?=
 =?utf-8?B?NHBlZnFWa1hTS3VIT1grMU5kdTJzdlZkMGdTMWh1UUU2Q1lrUUx6ejZ4NW1K?=
 =?utf-8?B?Tk8rZ0lOdUQ5YWsycWR5dy82RUVUcTg0RUFYUVplQzUvUHVoUGwyMmhmY1lZ?=
 =?utf-8?B?bStmSjRhSjN6MkRLeGZNUjM1ZnRubENlZlpVWnlHeWI4alZDZE5uTEJSeDVx?=
 =?utf-8?B?ZWVvSXl6SVg5OEc0TW1GdlU1dk05R29jeXFVUUtWQldGK1I4aGVwM3VoQzE1?=
 =?utf-8?B?N0FpRFp1ZkQ2cSt6WUZDMzNJY3M5ZGtvWjBWMERBWmlHaitVN0xmdWIwTVZk?=
 =?utf-8?B?aTNPNE16cGZOdUhET0R4UC9JRW0yTXQ1UlFCTlpZNmo5NmdhT2g3YmkwcVpY?=
 =?utf-8?B?SmErOVIzdkZ0c0Q2Z21obFVCUC8zVTA1bFlVQy9vRzFjSGlGanRHNGxQSS9L?=
 =?utf-8?B?dFlYcksrTEhxRVdGUVk4aEx3SzRuUFQyQlJickxCVVROK1JBSHZuM0c2VFJO?=
 =?utf-8?B?d21QdlA4SWltVW5QTkFHbXVGVmFyNkZiekRFMk0vVXo5TTllcS9hUlAvQkJp?=
 =?utf-8?B?NThha0lUOStHNk84dkJqaWJHN24zWWs1MzdIeXZtUEI1WHRENDErYUNETWxM?=
 =?utf-8?B?OERLUVkrRlVia3NFN1paVE5aTXRsVzNxc0Q3YVN6NWJFWUV2NVZWZG9MNDNm?=
 =?utf-8?B?OTN5Zk00Wkl4bkxidEh6bGxsWXJLNWJqK05lQzJ4cDBJbVRoZHZ1V1BWcldS?=
 =?utf-8?B?K3RMaVNJNmtEUTlTNjF3Z2xwWVUyME43RWRQUGoxOWNpYVAzMVdCbURiWWtG?=
 =?utf-8?B?TkY5WnhJL3NjeHRNa3F4SGVINEc4SmZxWE9DZHd5dHloNzAzd3JnbSs1dUNJ?=
 =?utf-8?Q?Ox5ecob+WK3YBRbk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4799211465A979428D21A75F41D120D8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XYq12F69bRfuB/vS4MsLfFwD+2oXWILLI5insNCaTyhNi//qp7xrwicXb/oWkCYNNDWbvGeqh5BuyF1GO2i7wxajCIVYDIrPi62gCmIhq4Kh7MKdq7ymihGr5Jp5/FSeeXNNgzdXxRlqyKZ/kvh0s+NLEn3ir3YNUZnMvYKM60AJ5LDCS+udWA1Q0JxOp+sRK/mEDsRMFDySxRid85Mh9W08/wuCVHfiXJBBPhmRN3t5yJmYEe3GP1SdjMg/PnOVyiYu0ucENLvvB58x0l21hGau2lGnlFQ/uhQ4LKSc76srbeM0L02QjKK8d5EGcVvHEXyC8eT0BD6gn6LtsjSd7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fb8948-f51d-4333-4d2e-08de7fdb1db3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 02:00:20.5614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pfsKBi9DlnRvxSzW0GFRw4oAU6XARnPhZxTF92kbpte4Tg9vU2ZfWEQxX2rkd9QbyJ4lwHK8F0Xp9lnjXvSfO62FOCYxJQ6QJKiASrNT6sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6138
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTAyLTEyIGF0IDA2OjM1IC0wODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVERY
IE1vZHVsZSB1cGRhdGVzIHJlcXVpcmUgY2FyZWZ1bCBzeW5jaHJvbml6YXRpb24gd2l0aCBvdGhl
ciBURFgNCj4gb3BlcmF0aW9ucyBvbiB0aGUgaG9zdC4gRHVyaW5nIHVwZGF0ZXMsIG9ubHkgdXBk
YXRlLXJlbGF0ZWQgU0VBTUNBTExzIGFyZQ0KPiBwZXJtaXR0ZWQ7IGFsbCBvdGhlciBTRUFNQ0FM
THMgbXVzdCBiZSBibG9ja2VkLg0KPiANCj4gSG93ZXZlciwgU0VBTUNBTExzIGNhbiBiZSBpbnZv
a2VkIGZyb20gZGlmZmVyZW50IGNvbnRleHRzIChub3JtYWwgYW5kIElSUQ0KPiBjb250ZXh0KSBh
bmQgcnVuIGluIHBhcmFsbGVsIGFjcm9zcyBDUFVzLiBBbmQsIGFsbCBURCB2Q1BVcyBtdXN0IHJl
bWFpbg0KPiBvdXQgb2YgZ3Vlc3QgbW9kZSBkdXJpbmcgdXBkYXRlcy4NCj4gDQoNCkFib3ZlIGl0
IHNheXMgb25seSB1cGRhdGUtcmVsYXRlZCBTRUFNQ0FMTHMgYXJlIHBlcm1pdHRlZC4gRG9lcyB0
aGF0IG5vdCBhbHJlYWR5DQpleGNsdWRlIFNFQU1DQUxMcyB0aGF0IG1pZ2h0IGFsbG93IGVudGVy
aW5nIHRoZSBURD8NCg0KPiAgTm8gc2luZ2xlIGxvY2sgcHJpbWl0aXZlIGNhbiBzYXRpc2Z5DQo+
IGFsbCB0aGVzZSBzeW5jaHJvbml6YXRpb24gcmVxdWlyZW1lbnRzLCBzbyBzdG9wX21hY2hpbmUo
KSBpcyB1c2VkIGFzIHRoZQ0KPiBvbmx5IHdlbGwtdW5kZXJzdG9vZCBtZWNoYW5pc20gdGhhdCBj
YW4gbWVldCB0aGVtIGFsbC4NCj4gDQo+IFRoZSBURFggTW9kdWxlIHVwZGF0ZSBwcm9jZXNzIGNv
bnNpc3RzIG9mIHNldmVyYWwgc3RlcHMgYXMgZGVzY3JpYmVkIGluDQo+IEludGVswq4gVHJ1c3Qg
RG9tYWluIEV4dGVuc2lvbnMgKEludGVswq4gVERYKSBNb2R1bGUgQmFzZSBBcmNoaXRlY3R1cmUN
Cj4gU3BlY2lmaWNhdGlvbiwgUmV2aXNpb24gMzQ4NTQ5LTAwNywgQ2hhcHRlciA0LjUgIlRELVBy
ZXNlcnZpbmcgVERYIE1vZHVsZQ0KPiBVcGRhdGUiDQo+IA0KPiAgIC0gc2h1dCBkb3duIHRoZSBv
bGQgbW9kdWxlDQo+ICAgLSBpbnN0YWxsIHRoZSBuZXcgbW9kdWxlDQo+ICAgLSBnbG9iYWwgYW5k
IHBlci1DUFUgaW5pdGlhbGl6YXRpb24NCj4gICAtIHJlc3RvcmUgc3RhdGUgaW5mb3JtYXRpb24N
Cj4gDQo+IFNvbWUgc3RlcHMgbXVzdCBleGVjdXRlIG9uIGEgc2luZ2xlIENQVSwgb3RoZXJzIG11
c3QgcnVuIHNlcmlhbGx5IGFjcm9zcw0KPiBhbGwgQ1BVcywgYW5kIHNvbWUgY2FuIHJ1biBjb25j
dXJyZW50bHkgb24gYWxsIENQVXMuIFRoZXJlIGFyZSBhbHNvDQo+IG9yZGVyaW5nIHJlcXVpcmVt
ZW50cyBiZXR3ZWVuIHN0ZXBzLCBzbyBhbGwgQ1BVcyBtdXN0IHdvcmsgaW4gYSBzdGVwLWxvY2tl
ZA0KPiBtYW5uZXIuDQoNCkRvZXMgdGhlIGZhY3QgdGhhdCB0aGV5IGNhbiBydW4gb24gb3RoZXIg
Q1BVcyBhZGQgYW55IHN5bmNocm9uaXphdGlvbg0KcmVxdWlyZW1lbnRzPyBJZiBub3QgSSdkIGxl
YXZlIGl0IG9mZi4NCg0KPiANCj4gSW4gc3VtbWFyeSwgVERYIE1vZHVsZSB1cGRhdGVzIGNyZWF0
ZSB0d28gcmVxdWlyZW1lbnRzOg0KDQpUaGUgc3RvcF9tYWNoaW5lKCkgcGFydCBzZWVtcyBtb3Jl
IGxpa2UgYSBzb2x1dGlvbiB0aGVuIGEgcmVxdWlyZW1lbnQuDQoNCj4gDQo+IDEuIFRoZSBlbnRp
cmUgdXBkYXRlIHByb2Nlc3MgbXVzdCB1c2Ugc3RvcF9tYWNoaW5lKCkgdG8gc3luY2hyb25pemUg
d2l0aA0KPiAgICBvdGhlciBURFggd29ya2xvYWRzDQo+IDIuIFVwZGF0ZSBzdGVwcyBtdXN0IGJl
IHBlcmZvcm1lZCBpbiBhIHN0ZXAtbG9ja2VkIG1hbm5lcg0KPiANCj4gVG8gcHJlcGFyZSBmb3Ig
aW1wbGVtZW50aW5nIGNvbmNyZXRlIFREWCBNb2R1bGUgdXBkYXRlIHN0ZXBzLCBlc3RhYmxpc2gN
Cj4gdGhlIGZyYW1ld29yayBieSBtaW1pY2tpbmcgbXVsdGlfY3B1X3N0b3AoKSwgd2hpY2ggaXMg
YSBnb29kIGV4YW1wbGUgb2YNCj4gcGVyZm9ybWluZyBhIG11bHRpLXN0ZXAgdGFzayBpbiBzdGVw
LWxvY2tlZCBtYW5uZXIuDQo+IA0KDQpPZmZsaW5lIENoYW8gcG9pbnRlZCB0aGF0IFBhdWwgc3Vn
Z2VzdGVkIHRoaXMgYWZ0ZXIgY29uc2lkZXJpbmcgcmVmYWN0b3Jpbmcgb3V0DQp0aGUgY29tbW9u
IGNvZGUuIEkgdGhpbmsgaXQgbWlnaHQgc3RpbGwgYmUgd29ydGggbWVudGlvbmluZyB3aHkgeW91
IGNhbid0IHVzZQ0KbXVsdGlfY3B1X3N0b3AoKSBkaXJlY3RseS4gSSBndWVzcyB0aGVyZSBhcmUg
c29tZSBkaWZmZXJlbmNlcy4gd2hhdCBhcmUgdGhleS4NCg0KPiAgU3BlY2lmaWNhbGx5LCB1c2Ug
YQ0KPiBnbG9iYWwgc3RhdGUgbWFjaGluZSB0byBjb250cm9sIGVhY2ggQ1BVJ3Mgd29yayBhbmQg
cmVxdWlyZSBhbGwgQ1BVcyB0bw0KPiBhY2tub3dsZWRnZSBjb21wbGV0aW9uIGJlZm9yZSBwcm9j
ZWVkaW5nIHRvIHRoZSBuZXh0IHN0ZXAuDQoNCk1heWJlIGFkZCBhIGJpdCBtb3JlIGFib3V0IHRo
ZSByZWFzb25pbmcgZm9yIHJlcXVpcmluZyB0aGUgb3RoZXIgc3RlcHMgdG8gYWNrLg0KVGllIGl0
IGJhY2sgdG8gdGhlIGxvY2tzdGVwIHBhcnQuDQoNCj4gDQo+IFBvdGVudGlhbCBhbHRlcm5hdGl2
ZSB0byBzdG9wX21hY2hpbmUoKQ0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4gQW4gYWx0ZXJuYXRpdmUgYXBwcm9hY2ggaXMgdG8gbG9jayBhbGwgS1ZNIGVudHJ5
IHBvaW50cyBhbmQga2ljayBhbGwNCj4gdkNQVXMuIEhlcmUsIEtWTSBlbnRyeSBwb2ludHMgcmVm
ZXIgdG8gS1ZNIFZNL3ZDUFUgaW9jdGwgZW50cnkgcG9pbnRzLA0KPiBpbXBsZW1lbnRlZCBpbiBL
Vk0gY29tbW9uIGNvZGUgKHZpcnQva3ZtKS4gQWRkaW5nIGEgbG9ja2luZyBtZWNoYW5pc20NCj4g
dGhlcmUgd291bGQgYWZmZWN0IGFsbCBhcmNoaXRlY3R1cmVzIEtWTSBzdXBwb3J0cy4gQW5kIHRv
IGxvY2sgb25seSBURFgNCj4gdkNQVXMsIG5ldyBsb2dpYyB3b3VsZCBiZSBuZWVkZWQgdG8gaWRl
bnRpZnkgVERYIHZDUFVzLCB3aGljaCB0aGUgS1ZNDQo+IGNvbW1vbiBjb2RlIGN1cnJlbnRseSBs
YWNrcy4gVGhpcyB3b3VsZCBhZGQgc2lnbmlmaWNhbnQgY29tcGxleGl0eSBhbmQNCj4gbWFpbnRl
bmFuY2Ugb3ZlcmhlYWQgdG8gS1ZNIGZvciB0aGlzIFREWC1zcGVjaWZpYyB1c2UgY2FzZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IENoYW8gR2FvIDxjaGFvLmdhb0BpbnRlbC5jb20+DQo+IFJldmll
d2VkLWJ5OiBYdSBZaWx1biA8eWlsdW4ueHVAbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1i
eTogVG9ueSBMaW5kZ3JlbiA8dG9ueS5saW5kZ3JlbkBsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0K
PiB2MjoNCj4gIC0gcmVmaW5lIHRoZSBjaGFuZ2xvZyB0byBmb2xsb3cgY29udGV4dC1wcm9ibGVt
LXNvbHV0aW9uIHN0cnVjdHVyZQ0KPiAgLSBtb3ZlIGFsdGVybmF0aXZlIGRpc2N1c3Npb25zIGF0
IHRoZSBlbmQgb2YgdGhlIGNoYW5nZWxvZw0KPiAgLSBhZGQgYSBjb21tZW50IGFib3V0IHN0YXRl
IG1hY2hpbmUgdHJhbnNpdGlvbg0KPiAgLSBNb3ZlIHJjdV9tb21lbnRhcnlfZXFzKCkgY2FsbCB0
byB0aGUgZWxzZSBicmFuY2guDQo+IC0tLQ0KPiAgYXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1s
ZHIuYyB8IDcwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDY5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWxkci5jIGIvYXJjaC94ODYvdmlydC92bXgvdGR4
L3NlYW1sZHIuYw0KPiBpbmRleCA3MThjYjgzOTYwNTcuLjIxZDU3MmQ3NTc2OSAxMDA2NDQNCj4g
LS0tIGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1sZHIuYw0KPiArKysgYi9hcmNoL3g4Ni92
aXJ0L3ZteC90ZHgvc2VhbWxkci5jDQo+IEBAIC0xMCw4ICsxMCwxMCBAQA0KPiAgI2luY2x1ZGUg
PGxpbnV4L2NwdWhwbG9jay5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2NwdW1hc2suaD4NCj4gICNp
bmNsdWRlIDxsaW51eC9tbS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L25taS5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L3NsYWIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPg0KPiArI2lu
Y2x1ZGUgPGxpbnV4L3N0b3BfbWFjaGluZS5oPg0KPiAgDQo+ICAjaW5jbHVkZSA8YXNtL3NlYW1s
ZHIuaD4NCj4gIA0KPiBAQCAtMTg2LDYgKzE4OCw2OCBAQCBzdGF0aWMgc3RydWN0IHNlYW1sZHJf
cGFyYW1zICppbml0X3NlYW1sZHJfcGFyYW1zKGNvbnN0IHU4ICpkYXRhLCB1MzIgc2l6ZSkNCj4g
IAlyZXR1cm4gYWxsb2Nfc2VhbWxkcl9wYXJhbXMobW9kdWxlLCBtb2R1bGVfc2l6ZSwgc2lnLCBz
aWdfc2l6ZSk7DQo+ICB9DQo+ICANCj4gKy8qDQo+ICsgKiBEdXJpbmcgYSBURFggTW9kdWxlIHVw
ZGF0ZSwgYWxsIENQVXMgc3RhcnQgZnJvbSBURFBfU1RBUlQgYW5kIHByb2dyZXNzDQo+ICsgKiB0
byBURFBfRE9ORS4gRWFjaCBzdGF0ZSBpcyBhc3NvY2lhdGVkIHdpdGggY2VydGFpbiB3b3JrLiBG
b3Igc29tZQ0KPiArICogc3RhdGVzLCBqdXN0IG9uZSBDUFUgbmVlZHMgdG8gcGVyZm9ybSB0aGUg
d29yaywgd2hpbGUgb3RoZXIgQ1BVcyBqdXN0DQo+ICsgKiB3YWl0IGR1cmluZyB0aG9zZSBzdGF0
ZXMuDQo+ICsgKi8NCj4gK2VudW0gdGRwX3N0YXRlIHsNCj4gKwlURFBfU1RBUlQsDQo+ICsJVERQ
X0RPTkUsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgc3RydWN0IHsNCj4gKwllbnVtIHRkcF9zdGF0
ZSBzdGF0ZTsNCj4gKwlhdG9taWNfdCB0aHJlYWRfYWNrOw0KPiArfSB0ZHBfZGF0YTsNCj4gKw0K
PiArc3RhdGljIHZvaWQgc2V0X3RhcmdldF9zdGF0ZShlbnVtIHRkcF9zdGF0ZSBzdGF0ZSkNCj4g
K3sNCj4gKwkvKiBSZXNldCBhY2sgY291bnRlci4gKi8NCj4gKwlhdG9taWNfc2V0KCZ0ZHBfZGF0
YS50aHJlYWRfYWNrLCBudW1fb25saW5lX2NwdXMoKSk7DQo+ICsJLyogRW5zdXJlIHRocmVhZF9h
Y2sgaXMgdXBkYXRlZCBiZWZvcmUgdGhlIG5ldyBzdGF0ZSAqLw0KPiArCXNtcF93bWIoKTsNCj4g
KwlXUklURV9PTkNFKHRkcF9kYXRhLnN0YXRlLCBzdGF0ZSk7DQo+ICt9DQo+ICsNCj4gKy8qIExh
c3Qgb25lIHRvIGFjayBhIHN0YXRlIG1vdmVzIHRvIHRoZSBuZXh0IHN0YXRlLiAqLw0KPiArc3Rh
dGljIHZvaWQgYWNrX3N0YXRlKHZvaWQpDQo+ICt7DQo+ICsJaWYgKGF0b21pY19kZWNfYW5kX3Rl
c3QoJnRkcF9kYXRhLnRocmVhZF9hY2spKQ0KPiArCQlzZXRfdGFyZ2V0X3N0YXRlKHRkcF9kYXRh
LnN0YXRlICsgMSk7DQo+ICt9DQo+ICsNCj4gKy8qDQo+ICsgKiBTZWUgbXVsdGlfY3B1X3N0b3Ao
KSBmcm9tIHdoZXJlIHRoaXMgbXVsdGktY3B1IHN0YXRlLW1hY2hpbmUgd2FzDQo+ICsgKiBhZG9w
dGVkLCBhbmQgdGhlIHJhdGlvbmFsZSBmb3IgdG91Y2hfbm1pX3dhdGNoZG9nKCkNCj4gKyAqLw0K
PiArc3RhdGljIGludCBkb19zZWFtbGRyX2luc3RhbGxfbW9kdWxlKHZvaWQgKnBhcmFtcykNCj4g
K3sNCj4gKwllbnVtIHRkcF9zdGF0ZSBuZXdzdGF0ZSwgY3Vyc3RhdGUgPSBURFBfU1RBUlQ7DQo+
ICsJaW50IHJldCA9IDA7DQo+ICsNCj4gKwlkbyB7DQo+ICsJCS8qIENoaWxsIG91dCBhbmQgcmUt
cmVhZCB0ZHBfZGF0YSAqLw0KPiArCQljcHVfcmVsYXgoKTsNCj4gKwkJbmV3c3RhdGUgPSBSRUFE
X09OQ0UodGRwX2RhdGEuc3RhdGUpOw0KPiArDQo+ICsJCWlmIChuZXdzdGF0ZSAhPSBjdXJzdGF0
ZSkgew0KPiArCQkJY3Vyc3RhdGUgPSBuZXdzdGF0ZTsNCj4gKwkJCXN3aXRjaCAoY3Vyc3RhdGUp
IHsNCg0KTWF5YmUgYSBsaXR0bGUgY29tbWVudCBoZXJlIGxpa2UgInRvZG8gYWRkIHRoZSBzdGVw
cyIuDQoNCj4gKwkJCWRlZmF1bHQ6DQo+ICsJCQkJYnJlYWs7DQo+ICsJCQl9DQo+ICsJCQlhY2tf
c3RhdGUoKTsNCj4gKwkJfSBlbHNlIHsNCj4gKwkJCXRvdWNoX25taV93YXRjaGRvZygpOw0KPiAr
CQkJcmN1X21vbWVudGFyeV9lcXMoKTsNCj4gKwkJfQ0KPiArCX0gd2hpbGUgKGN1cnN0YXRlICE9
IFREUF9ET05FKTsNCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gIERFRklORV9G
UkVFKGZyZWVfc2VhbWxkcl9wYXJhbXMsIHN0cnVjdCBzZWFtbGRyX3BhcmFtcyAqLA0KPiAgCSAg
ICBpZiAoIUlTX0VSUl9PUl9OVUxMKF9UKSkgZnJlZV9zZWFtbGRyX3BhcmFtcyhfVCkpDQo+ICAN
Cj4gQEAgLTIyMyw3ICsyODcsMTEgQEAgaW50IHNlYW1sZHJfaW5zdGFsbF9tb2R1bGUoY29uc3Qg
dTggKmRhdGEsIHUzMiBzaXplKQ0KPiAgCQlyZXR1cm4gLUVCVVNZOw0KPiAgCX0NCj4gIA0KPiAt
CS8qIFRPRE86IFVwZGF0ZSBURFggTW9kdWxlIGhlcmUgKi8NCj4gKwlzZXRfdGFyZ2V0X3N0YXRl
KFREUF9TVEFSVCArIDEpOw0KPiArCXJldCA9IHN0b3BfbWFjaGluZV9jcHVzbG9ja2VkKGRvX3Nl
YW1sZHJfaW5zdGFsbF9tb2R1bGUsIHBhcmFtcywgY3B1X29ubGluZV9tYXNrKTsNCj4gKwlpZiAo
cmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICBFWFBP
UlRfU1lNQk9MX0ZPUl9NT0RVTEVTKHNlYW1sZHJfaW5zdGFsbF9tb2R1bGUsICJ0ZHgtaG9zdCIp
Ow0KDQo=
