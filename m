Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6133C73E0;
	Thu, 12 Mar 2026 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341292; cv=fail; b=tzSWLtDe3H624VNcgPWXtiSxV+qt+JhsVzCmn2uo2lzJ/CjX2HaDpX8NOJnEUUNzXhziruvFBdDVvn1e+TojRytHBNfpAyENcVz1CP11y+Hlu+WN7jvhAPmC3LFLbozixLDCvRkgj3Yq+2IN5Ms68nVyzW6x8fI3pKzKLm5dCuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341292; c=relaxed/simple;
	bh=ScXbz28wD3I2chyZY3Hyl6N8goGNrAhfSy3/T8a9EpU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OiTj3fx+nLqGBPUGpBQ2GHPweeThJcBAoApvTwTTsKoFg+3xoT+Kv8bBUaJGFwKoDsHbBQOXgZhIRk55jYSh/Ms79ub1r0GPOZivQole/nkBu2vC1dF2gTRZlmvXQLhco88nebw2u8T60mBrbhHOnAoBFIW0YG5tZmiZTV7aoi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djWGYsIE; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djWGYsIE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773341289; x=1804877289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ScXbz28wD3I2chyZY3Hyl6N8goGNrAhfSy3/T8a9EpU=;
  b=djWGYsIEUtyWC+ValWQ5wmTZgbr7j6EeZV0ZqV8rAuvw2f+xTmjG3f4Y
   oGIqKv9Hc4p/xC+kfKtvbI0OWVkm9uI4sQeZhBO4LyGpZ6KYf+90KHPJL
   B9WE4uX0IOd4SiPhPQMfSMvZGvO+vKWxKhth9hY3XPuXTNSYRJc/sEMdh
   2PUXOLMepFsvr21+1WMfkR42lrzXrYmBeiXPU6GMTdI47aTTLk5vN91ku
   slygQ2LO5RhrvGECKzqPL61Zwzdb93XhO04n0XVtmPi5/niQVImUFAPyl
   3dC7kKnfgGAXwPglPIjd7Kj11n6RodYLXMz++lSM7+7eEYNn8j83nPtd3
   g==;
X-CSE-ConnectionGUID: XA+5hb0NQ76N0G2Pr7qOug==
X-CSE-MsgGUID: hrarHekUR3mS3ObB49NkuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78338028"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="78338028"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 11:48:09 -0700
X-CSE-ConnectionGUID: yh5a7IzWQh6v8ERQKQJDzA==
X-CSE-MsgGUID: zDSmOaTOQfeapSlnoBUUHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="258829039"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 11:48:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 11:48:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 11:48:07 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 11:48:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0SpGlmFoRqdF5HxOWm3Wy3jyJUNuBXzpBJsekjf07V0di8tfy/R/LR2z1ivniJIv0F+My0p59IZ9+2fg8LvyKGGzZCDqEq7Nzx4KDqvKZvyG1eq1MJjABiZbgF/Mi1xlL9Uko/LRgVNRMwct/CtKfwjijM58Zng6AQMT4ZtR2EldHe0OPlf+Btqh0Tn9uD669gYGQ4N7s8EvaRB6vbw4VylO+zdBV6JUuDsenmKIUlU33tM1tsyNuWJv+pn4l38ktKLLcBsjUyWW2s5JxevhbO/Pf9FuG8hGDq1f8+olrQ2ZH04sJImlBC1C8yColFEMF/YHpiqGfuPVZ8T3iuPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScXbz28wD3I2chyZY3Hyl6N8goGNrAhfSy3/T8a9EpU=;
 b=IGhjcfurEtUat3MoJ5hq2Fa6JZrpJZh7iTpXfMFLYbK5a82ka9viOlGKB7z7RO6N2nhTwhQcZLck/g0CfG3hf8NgrT3MzgHnqxgxDMbhZVNMsRUUZPpt4O5K8BYZw6LAfYtOejEUPcpUfHvKTqp8oQTrQWOv4HUMcfzOkNv6oDwmAc1DejtN77KRPyXkiUIrASHPEHdfPj7HAjSTKUIQHdTnn/GP1bn4Ayl1silCb/1WhvDFBzleSvOaM/Lef0TrBZbl7rb82wsD2YZc9Lqy8Ouzwf+FIPm70cu746LNYonyOU4rouBSUS5G9wwFRdyLnmevFVCgPUaTBRqqT5RbSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS7PR11MB7737.namprd11.prod.outlook.com (2603:10b6:8:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 18:48:02 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9678.017; Thu, 12 Mar 2026
 18:48:02 +0000
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
Subject: Re: [PATCH v4 19/24] x86/virt/tdx: Update tdx_sysinfo and check
 features post-update
Thread-Topic: [PATCH v4 19/24] x86/virt/tdx: Update tdx_sysinfo and check
 features post-update
Thread-Index: AQHcnCz/vCFIeBRYtUiOrAmuifNkfrWraSUA
Date: Thu, 12 Mar 2026 18:48:01 +0000
Message-ID: <0193104d49c4bd1e4e6ac3153f3aae16fb881c14.camel@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
	 <20260212143606.534586-20-chao.gao@intel.com>
In-Reply-To: <20260212143606.534586-20-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS7PR11MB7737:EE_
x-ms-office365-filtering-correlation-id: a546809a-f359-4c61-9466-08de8067e37b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: RqEcTRB29+tlMyycv4nXVk8KB1MkNyWelJbUuDJDnMX99XxsUJeIekf58z9YCMkiuasQkdAmnjgVSX8EEcTIggG8DClbU5BLBlwF7gYUCmKG5yGBObQv1WAbVCqV2B1LuRgWzwaz3zdqgV35j7cAWoNh2bIEPyWO639uDxFBsefaVNHuKkLlvnfrYNdk7K9pp+Uxd+xCkHV2+I1z2FGVPTR7Tg5uatPbFKPP80GqqopaKgy9WNZFOezvMnCpWGEX8ADUnuvGHr+FQGFmy2ZZ8KQ4HScYF4xjKfN5AD0fba7mYNc7rb7VA2BXAFrm25DcRWEFVOfjdm/Mdo36G6BLJZ3ZbmT8p59VSrwXzOSn2V3MjKzbxk/sDkMs2a2Sx6w9pKB9zyOX2Z0Z7WWU8XcuOfR+iugGlorqivVchB1KOthZwSyVx8EaskFphzCsM9hkYeKrjlspCuyLsjtK0sQUTNMFfGX+HXS4XNH11MvsQpRcaa+BURbWxNVfIZ59POolp2gYRi88Y7sbWhlq/gtvClG9wZ9SaFYIdkkrVza7idmKh0sWOqBF/J5v+TY/2IAn+GOPaMORUASx4IyI9ramrA5i5prWTMSeTYkmYrxK3p7d9q9nzQQ1Vh+QsUgyeaVqll05S48qsJZo4+r7KnFrlDdoURI+dNHY5Dm93ZaFOik8mk3kICdojaugmHFUjfcaYDDTakuNgR2EPVDVxdNECAzM2/yfTQrv0aFk4wmw9DdNPfjAgvt8UpyMosViAFxOusIuQVsq1cZ/ObfcbekWYltkrC16XiWHLIOf/UNLTew=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0NKQjliZGVqRVVOeVBKYzdBQTFGa1oweEFWNHNjMmNXa0MzWkhIWmFQeld5?=
 =?utf-8?B?WW0vS0JTTjl6QURHbklFOUtYMlhJa0xpaE96djNMTkp0eUZVejlDK2VpSzE0?=
 =?utf-8?B?azg1WlBhWHFvT0VCcldmZ1hEcm8xdndxLzdIT1BMVVo2N0hEczY5eSsySkRI?=
 =?utf-8?B?TTJXWktURmd0cGhUdHFzc1ZFaXpnYi84MThnQkgwS09IVG1BM2pwL1NaNjBp?=
 =?utf-8?B?clVwUnVyWkVGRW5td01wRGE3eVhBRmN6MzcwTUV3YnhVMksxUE9HVFB3UWNV?=
 =?utf-8?B?MkppaDFKTVZ0eEpvc0pBcUwwN1BoeUNqWGEwNktHbXdsMno1VkZPV0ZoYmYr?=
 =?utf-8?B?ejVZQ2w5eElJMFlWaHJpejNZM1Z4aHNGTjl6Z1NRY204WmFGTnlUWG5jR2dt?=
 =?utf-8?B?ZG45V3hJcXB0UXBwZU1NSlgyaFhsWFhqSlcyS0VNcHlGME5OdlNzbGs2K2pQ?=
 =?utf-8?B?OHk5QzlWbFZnMnBKOU16eWFiUFg2WDM2MjRGOHF6M1IrZmh6Nkc1K0dMWEU4?=
 =?utf-8?B?TGNYZXZJS3k1d3JGN3BQVzlSdlh5UlFYQkpNN2QxckFBTlBLWTlaVFNPYWtQ?=
 =?utf-8?B?ZzRjR2d3bEYvMW9JK09XTWdzeHo0S1duZFVBRVhNakUyQWtMaXBPcWtBdW5q?=
 =?utf-8?B?ZnZ5MVExdjNnekZ3VGx3SW92WEdsYjNjK0huMXJtVGw3YmpRSzJqaEFkbkRp?=
 =?utf-8?B?V29veU5uOXJpYnY4U2FPdTQxSlNwZUxaRlYwdEJqNmxPSmRDOW9Qc21DMHc3?=
 =?utf-8?B?UlhQM0JKdllVZGN1ZHIxVE1TTURCd2hJMDZkcHlXdUUwVTNCM2Q1NGN3WE94?=
 =?utf-8?B?cUF6b0ZiRlBrYXlHLzV3di9lSGNwUlQzTW82NnNuelpnUEJ5MWk4SFg3eHE2?=
 =?utf-8?B?Y0NadWc2SmVMRm9LNDg1SWJ0RkN2OEpvTFpwcDJrY0llZUZ0K0pBdkNZRUxR?=
 =?utf-8?B?c1NtdXFGaFk2bzVpZy9ibHUzRGFGUVNKQUEyTDFyZkxOckppTWxjcWRCU2RE?=
 =?utf-8?B?UTg3V0I1WVBabnllemJoaWU1T083eDVwcTc4M1dRZzgzZ3ZNdmI3SjVuclBp?=
 =?utf-8?B?MXJHNnNVY2hrRUVKLzhKdm95b3ZKVzJUZ0FVWVk0R0lsd2hDWFNoQm5UZmJJ?=
 =?utf-8?B?ZHArYW5uWUhnWUJVSmd5UnREU3J3U2dMRU40bDVGWWMyUjBkcmNyS2d4WWR4?=
 =?utf-8?B?cWtuTng3M05tellWWGE1K2ozeHhVaTRldjk0a2UraG1PeENBNG1Zajl2eEN1?=
 =?utf-8?B?OHFnbEZoaFJMb2FUQ1VqRDhWQ1ArUEZ0TUxWb3lrV0Z3aC9ONitSY1dqdDll?=
 =?utf-8?B?cHpQbWU3U00vMWFVRUNSVWkvRlV1UE15K2ZvendGTC9tbEt1K3VpR0xRNG5r?=
 =?utf-8?B?YU9RTGEvZjBhaFNPa3dhQklZMk9QQ08vaVZ0MWpqWXdkWnRaMXRnYXVsWkhy?=
 =?utf-8?B?UkxOd3hqUUNhaUNJMXZpbDNuNGdWT2drQ1NhMGdjYll2aWdFTWNSaWdwY3A2?=
 =?utf-8?B?UHZoNGVwOTR1bEpIM3lnMmdlNENlSjlxRERmVk1QTXZ6UU9XSWZwNEZXMXFX?=
 =?utf-8?B?dXZHUzF2bGxCZlUzeEZBcndQZzAxMVZqbTdMOFdVeEJFOWJHbStrSktPUGg1?=
 =?utf-8?B?Z01sdlVhcmJWZG1GZjkyNjMrY1NVT1JBMHNEUWNYV01TUUJ4R040bU9jMkFR?=
 =?utf-8?B?WlF5K25DWjZzOXVob2c1aHFka0hPVXdiaG9pSTUyZ3JaSzZibGlqSGpxTisz?=
 =?utf-8?B?aUxFRy9yUXJvUVRZY2NjaDZJdjh4dG10SUxvQkRhdGQ5enFrZGxCc21GUDA1?=
 =?utf-8?B?ek0xVEsxV3Jkc2kzSktoaTJ5R0s5WGs3bU1CaWFyb1l4cmg4dTJ0U0RaTGNL?=
 =?utf-8?B?U0pmN3FMZC9kbXZwckh0RmduRlBPUGJrbXRzUHBnZmZHTHdlQXJkWTRSN2Mr?=
 =?utf-8?B?bTM4ZTk0QndYQ29OcDRaT0tZdlkxQVVNY2dUeGl5WUtzbENPTzFLN1JnTStP?=
 =?utf-8?B?YjkxTDFKWU96WHk1UkNtQ3JDMTNGNVVBdzZGcjJIcmptWjYwUmc0anRGcVU2?=
 =?utf-8?B?VlBnTXRxQTBYa2swSy9sR0ZHc2dPRFQvT2N1NG10ME0ycE44SkhvOExRTHpx?=
 =?utf-8?B?dzJLcVJCQk5PNXVMUWNWVndGa0EwT1E1MXJsR0kvSTdPMktjck5tb2N1Wk9q?=
 =?utf-8?B?S2F3SzE1bnF1TUtCdGRhVEtIb1UrazZSZkFUWXJIV0FoMEdQTVpVZmc2VEtR?=
 =?utf-8?B?T1k2d21NczdTOTliY01VdG8xTndnVUZuRWpXR2pZZUp5SjRJZjlzMVIwRnhJ?=
 =?utf-8?B?YUVucjUrcERXTElQZE11bElYY3BJT1RZbkJsK01Lcm93d3JZVTE0OUwzQ2l0?=
 =?utf-8?Q?VlC9PFTPVU7jQnvo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A28EBFC32D953649BD2F8BA21D04E641@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FQPgQhZaN+yCwt9lPwqEMfEP/TU5PkWZ2jiUqrFuZKUahEcB+3+lwoE5hfvn2bQ63G/ZGTlTw714HA4G5pSkFQen1rXj+pPvt4Qj+LxYU6VjGlYy8xPTGrtx2I4FXHNiSj5IClGO5WQCD2cAmftAhIe+VXT7hsbXlYJgPSm4wTOOAxoAJ4WP2FiEVXkSkr9/pr832DERl9KBBAsATiJjPsfRKse97WB8CbwwgPg0o9ufh84pjG0+KB6wQXNmDoaYfSgLEi+GyOvKyBMFoxAuz4XT6az/W5mAVAlvrKZE7InN3ZAR+znwj//+T+mzFkuodnVTBoX2bW3lX3EnyYUIpQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a546809a-f359-4c61-9466-08de8067e37b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 18:48:01.9497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +S+VFiWO4VVOcSuqFet36Pc+iVU2xdA5slx1EW0vuemQM9rqeSoZoBhDf7/H9JcybHP0R2u9j8af/rV5ZHEB2wlzR2RcGouh3yL1abyAPfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7737
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTAyLTEyIGF0IDA2OjM1IC0wODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiB0
ZHhfc3lzaW5mbyBjb250YWlucyBhbGwgbWV0YWRhdGEgb2YgdGhlIGFjdGl2ZSBURFggbW9kdWxl
LCBpbmNsdWRpbmcNCj4gPiB2ZXJzaW9ucywgc3VwcG9ydGVkIGZlYXR1cmVzLCBhbmQgVERNUi9U
RENTL1REVlBTIGluZm9ybWF0aW9uLiBUaGVzZQ0KPiA+IHZhbHVlcyBtYXkgY2hhbmdlIG92ZXIg
dXBkYXRlcy4gQmxpbmRseSByZWZyZXNoaW5nIHRoZSBlbnRpcmUgdGR4X3N5c2luZm8NCj4gPiBj
b3VsZCBkaXNydXB0IHJ1bm5pbmcgc29mdHdhcmUsIGFzIGl0IG1heSBzdWJ0bHkgcmVseSBvbiB0
aGUgcHJldmlvdXMgc3RhdGUNCj4gPiB1bmxlc3MgcHJvdmVuIG90aGVyd2lzZS4NCj4gPiANCj4g
PiBBZG9wdCBhIGNvbnNlcnZhdGl2ZSBhcHByb2FjaCwgbGlrZSBtaWNyb2NvZGUgdXBkYXRlcywg
Ynkgb25seSByZWZyZXNoaW5nDQo+ID4gdmVyc2lvbiBpbmZvcm1hdGlvbiB0aGF0IGRvZXMgbm90
IGFmZmVjdCBmdW5jdGlvbmFsaXR5LCB3aGlsZSBpZ25vcmluZw0KPiA+IGFsbCBvdGhlciBjaGFu
Z2VzLiBUaGlzIGlzIGFjY2VwdGFibGUgYXMgbmV3IG1vZHVsZXMgYXJlIHJlcXVpcmVkIHRvDQo+
ID4gbWFpbnRhaW4gYmFja3dhcmQgY29tcGF0aWJpbGl0eS4NCj4gPiANCj4gPiBBbnkgdXBkYXRl
cyB0byBtZXRhZGF0YSBiZXlvbmQgdmVyc2lvbnMgc2hvdWxkIGJlIGp1c3RpZmllZCBhbmQgcmV2
aWV3ZWQgb24NCj4gPiBhIGNhc2UtYnktY2FzZSBiYXNpcy4NCj4gPiANCj4gPiBOb3RlIHRoYXQg
cHJlYWxsb2NhdGluZyBhIHRkeF9zeXNfaW5mbyBidWZmZXIgYmVmb3JlIHVwZGF0ZXMgaXMgdG8g
YXZvaWQNCj4gPiBoYXZpbmcgdG8gaGFuZGxlIC1FTk9NRU0gd2hlbiB1cGRhdGluZyB0ZHhfc3lz
aW5mbyBhZnRlciBhIHN1Y2Nlc3NmdWwNCj4gPiB1cGRhdGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogQ2hhbyBHYW8gPGNoYW8uZ2FvQGludGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogWHUg
WWlsdW4gPHlpbHVuLnh1QGxpbnV4LmludGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogVG9ueSBM
aW5kZ3JlbiA8dG9ueS5saW5kZ3JlbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gdjM6
DQo+ID4gIC0gdXNlICdvbGQnIGluc3RlYWQgb2YgJ2N1cicgYXMgdGhlIGxvY2FsIHZhcmlhYmxl
IHRvIHJlcHJlc2VudCB0aGUNCj4gPiAgICBzeXNpbmZvIG9mIHRoZSBwcmV2aW91cyBtb2R1bGUg
W0JpbmJpbl0NCj4gPiAgLSBjb21iaW5lIGlmKHJldCkgYW5kIFdBUk5fT05DRSgxLCAuLi4pIHRv
IFdBUk5fT05DRShyZXQsIC4uLikgW0JpbmJpbl0NCj4gPiAgLSBJbXByb3ZlIHRoZSBwcmludCBs
b2cgbWVzc2FnZXMgYWZ0ZXIgZGV0ZWN0aW5nIG5ldyBmZWF0dXJlcyBmcm9tIHVwZGF0ZXMuDQo+
ID4gICAgW0JpbmJpbl0NCj4gPiANCj4gPiB2MjoNCj4gPiAgLSBkb24ndCBhZGQgYSBzZXBhcmF0
ZSBmdW5jdGlvbiBmb3IgdmVyc2lvbiBhbmQgZmVhdHVyZSBjaGVja3MuIERvIHRoZW0NCj4gPiAg
ICBkaXJlY3RseSBpbiB0ZHhfbW9kdWxlX3Bvc3RfdXBkYXRlKCkNCj4gPiAgLSBhZGQgYSBjb21t
ZW50IGFib3V0IHByZWFsbG9jYXRpbmcgYSB0ZHhfc3lzX2luZm8gYnVmZmVyIGluDQo+ID4gICAg
c2VhbWxkcl9pbnN0YWxsX21vZHVsZSgpLg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni92aXJ0L3Zt
eC90ZHgvc2VhbWxkci5jIHwgMTEgKysrKysrKystDQo+ID4gIGFyY2gveDg2L3ZpcnQvdm14L3Rk
eC90ZHguYyAgICAgfCA0MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
YXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5oICAgICB8ICAzICsrKw0KPiA+ICAzIGZpbGVzIGNo
YW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1sZHIuYyBiL2FyY2gveDg2L3ZpcnQvdm14
L3RkeC9zZWFtbGRyLmMNCj4gPiBpbmRleCAwY2E4MDIyMzQ2OTUuLjNmMzdjYzZjNjhmZiAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWxkci5jDQo+ID4gKysrIGIv
YXJjaC94ODYvdmlydC92bXgvdGR4L3NlYW1sZHIuYw0KPiA+IEBAIC0zMTUsNiArMzE1LDE1IEBA
IGludCBzZWFtbGRyX2luc3RhbGxfbW9kdWxlKGNvbnN0IHU4ICpkYXRhLCB1MzIgc2l6ZSkNCj4g
PiAgCWlmIChXQVJOX09OX09OQ0UoIWlzX3ZtYWxsb2NfYWRkcihkYXRhKSkpDQo+ID4gIAkJcmV0
dXJuIC1FSU5WQUw7DQo+ID4gIA0KPiA+ICsJLyoNCj4gPiArCSAqIFByZWFsbG9jYXRpbmcgYSB0
ZHhfc3lzX2luZm8gYnVmZmVyIGJlZm9yZSB1cGRhdGVzIGlzIHRvIGF2b2lkIGhhdmluZyB0bw0K
PiA+ICsJICogaGFuZGxlIC1FTk9NRU0gd2hlbiB1cGRhdGluZyB0ZHhfc3lzaW5mbyBhZnRlciBh
IHN1Y2Nlc3NmdWwgdXBkYXRlLg0KPiA+ICsJICovDQo+ID4gKwlzdHJ1Y3QgdGR4X3N5c19pbmZv
ICpzeXNpbmZvIF9fZnJlZShrZnJlZSkgPSBremFsbG9jKHNpemVvZigqc3lzaW5mbyksDQo+ID4g
KwkJCQkJCQkgICAgIEdGUF9LRVJORUwpOw0KPiA+ICsJaWYgKCFzeXNpbmZvKQ0KPiA+ICsJCXJl
dHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiAgCXN0cnVjdCBzZWFtbGRyX3BhcmFtcyAqcGFyYW1z
IF9fZnJlZShmcmVlX3NlYW1sZHJfcGFyYW1zKSA9DQo+ID4gIAkJCQkJCWluaXRfc2VhbWxkcl9w
YXJhbXMoZGF0YSwgc2l6ZSk7DQo+ID4gIAlpZiAoSVNfRVJSKHBhcmFtcykpDQo+ID4gQEAgLTMz
Miw2ICszNDEsNiBAQCBpbnQgc2VhbWxkcl9pbnN0YWxsX21vZHVsZShjb25zdCB1OCAqZGF0YSwg
dTMyIHNpemUpDQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gIA0KPiA+
IC0JcmV0dXJuIDA7DQo+ID4gKwlyZXR1cm4gdGR4X21vZHVsZV9wb3N0X3VwZGF0ZShzeXNpbmZv
KTsNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MX0ZPUl9NT0RVTEVTKHNlYW1sZHJfaW5zdGFs
bF9tb2R1bGUsICJ0ZHgtaG9zdCIpOw0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3Zt
eC90ZHgvdGR4LmMgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gPiBpbmRleCBhOGFk
YjJjOTdlMmYuLjNmNWVkYmMzM2E0ZiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni92aXJ0L3Zt
eC90ZHgvdGR4LmMNCj4gPiArKysgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gPiBA
QCAtMTIxOCw2ICsxMjE4LDQ5IEBAIGludCB0ZHhfbW9kdWxlX3J1bl91cGRhdGUodm9pZCkNCj4g
PiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICsvKg0KPiA+ICsgKiBVcGRhdGUgdGR4
X3N5c2luZm8gYW5kIGNoZWNrIGlmIGFueSBURFggbW9kdWxlIGZlYXR1cmVzIGNoYW5nZWQgYWZ0
ZXINCj4gPiArICogdXBkYXRlcw0KPiA+ICsgKi8NCj4gPiAraW50IHRkeF9tb2R1bGVfcG9zdF91
cGRhdGUoc3RydWN0IHRkeF9zeXNfaW5mbyAqaW5mbykNCj4gPiArew0KPiA+ICsJc3RydWN0IHRk
eF9zeXNfaW5mb192ZXJzaW9uICpvbGQsICpuZXc7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4g
PiArCS8qIFNob3VsZG4ndCBmYWlsIGFzIHRoZSB1cGRhdGUgaGFzIHN1Y2NlZWRlZCAqLw0KPiA+
ICsJcmV0ID0gZ2V0X3RkeF9zeXNfaW5mbyhpbmZvKTsNCj4gPiArCWlmIChXQVJOX09OQ0UocmV0
LCAidmVyc2lvbiByZXRyaWV2YWwgZmFpbGVkIGFmdGVyIHVwZGF0ZSwgcmVwbGFjZSBURFggTW9k
dWxlXG4iKSkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCW9sZCA9ICZ0ZHhfc3lz
aW5mby52ZXJzaW9uOw0KPiA+ICsJbmV3ID0gJmluZm8tPnZlcnNpb247DQo+ID4gKwlwcl9pbmZv
KCJ2ZXJzaW9uICV1LiV1LiUwMnUgLT4gJXUuJXUuJTAydVxuIiwgb2xkLT5tYWpvcl92ZXJzaW9u
LA0KPiA+ICsJCQkJCQkgICAgICBvbGQtPm1pbm9yX3ZlcnNpb24sDQo+ID4gKwkJCQkJCSAgICAg
IG9sZC0+dXBkYXRlX3ZlcnNpb24sDQo+ID4gKwkJCQkJCSAgICAgIG5ldy0+bWFqb3JfdmVyc2lv
biwNCj4gPiArCQkJCQkJICAgICAgbmV3LT5taW5vcl92ZXJzaW9uLA0KPiA+ICsJCQkJCQkgICAg
ICBuZXctPnVwZGF0ZV92ZXJzaW9uKTsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogQmxpbmRs
eSByZWZyZXNoaW5nIHRoZSBlbnRpcmUgdGR4X3N5c2luZm8gY291bGQgZGlzcnVwdCBydW5uaW5n
DQo+ID4gKwkgKiBzb2Z0d2FyZSwgYXMgaXQgbWF5IHN1YnRseSByZWx5IG9uIHRoZSBwcmV2aW91
cyBzdGF0ZSB1bmxlc3MNCj4gPiArCSAqIHByb3ZlbiBvdGhlcndpc2UuDQo+ID4gKwkgKg0KPiA+
ICsJICogT25seSByZWZyZXNoIHZlcnNpb24gaW5mb3JtYXRpb24gKGluY2x1ZGluZyBoYW5kb2Zm
IHZlcnNpb24pDQo+ID4gKwkgKiB0aGF0IGRvZXMgbm90IGFmZmVjdCBmdW5jdGlvbmFsaXR5LCBh
bmQgaWdub3JlIGFsbCBvdGhlcg0KPiA+ICsJICogY2hhbmdlcy4NCj4gPiArCSAqLw0KPiA+ICsJ
dGR4X3N5c2luZm8udmVyc2lvbgk9IGluZm8tPnZlcnNpb247DQo+ID4gKwl0ZHhfc3lzaW5mby5o
YW5kb2ZmCT0gaW5mby0+aGFuZG9mZjsNCj4gPiArDQo+ID4gKwlpZiAoIW1lbWNtcCgmdGR4X3N5
c2luZm8sIGluZm8sIHNpemVvZigqaW5mbykpKQ0KPiA+ICsJCXJldHVybiAwOw0KDQpBaGgsIGxh
dGUgZGF5IHJldmlld2luZyB0aGlzIHllc3RlcmRheSwgSSByZWFkIHRoaXMgYXMgbWVtY3B5KCku
IFRoaXMgc2VlbXMgbGlrZQ0KYSBnb29kIGFwcHJvYWNoLiBJJ2Qgb25seSB3b25kZXIgaWYgdGhp
cyBzaG91bGQgZWl0aGVyIGJlIGEgc3Ryb25nZXIgd2FybmluZywgb3INCndlIGNhbiBza2lwIGNo
ZWNraW5nIHRoZSBURFggbW9kdWxlIGlzIGJlaGF2aW5nLiBXZSByZWx5IG9uIGEgbG90IGFscmVh
ZHkuIEJ1dA0KZmVlbCBmcmVlIHRvIGRpc3JlZ2FyZCBpdC4NCg0KUmV2aWV3ZWQtYnk6IFJpY2sg
RWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg0KPiA+ICsNCj4gPiArCXBy
X2luZm8oIlREWCBtb2R1bGUgZmVhdHVyZXMgaGF2ZSBjaGFuZ2VkIGFmdGVyIHVwZGF0ZXMsIGJ1
dCBtaWdodCBub3QgdGFrZSBlZmZlY3QuXG4iKTsNCj4gPiArCXByX2luZm8oIlBsZWFzZSBjb25z
aWRlciB1cGRhdGluZyB5b3VyIEJJT1MgdG8gaW5zdGFsbCB0aGUgVERYIE1vZHVsZS5cbiIpOw0K
PiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBib29sIGlzX3BhbXRf
cGFnZSh1bnNpZ25lZCBsb25nIHBoeXMpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCB0ZG1yX2luZm9f
bGlzdCAqdGRtcl9saXN0ID0gJnRkeF90ZG1yX2xpc3Q7DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L3ZpcnQvdm14L3RkeC90ZHguaCBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguaA0KPiA+
IGluZGV4IDA4ODdkZWJmZDEzOS4uZDE4MDdhNDc2ZDNiIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gv
eDg2L3ZpcnQvdm14L3RkeC90ZHguaA0KPiA+ICsrKyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90
ZHguaA0KPiA+IEBAIC00LDYgKzQsOCBAQA0KPiA+ICANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2Jp
dHMuaD4NCj4gPiAgDQo+ID4gKyNpbmNsdWRlIDxhc20vdGR4X2dsb2JhbF9tZXRhZGF0YS5oPg0K
PiA+ICsNCj4gPiAgLyoNCj4gPiAgICogVGhpcyBmaWxlIGNvbnRhaW5zIGJvdGggbWFjcm9zIGFu
ZCBkYXRhIHN0cnVjdHVyZXMgZGVmaW5lZCBieSB0aGUgVERYDQo+ID4gICAqIGFyY2hpdGVjdHVy
ZSBhbmQgTGludXggZGVmaW5lZCBzb2Z0d2FyZSBkYXRhIHN0cnVjdHVyZXMgYW5kIGZ1bmN0aW9u
cy4NCj4gPiBAQCAtMTIyLDUgKzEyNCw2IEBAIHN0cnVjdCB0ZG1yX2luZm9fbGlzdCB7DQo+ID4g
IA0KPiA+ICBpbnQgdGR4X21vZHVsZV9zaHV0ZG93bih2b2lkKTsNCj4gPiAgaW50IHRkeF9tb2R1
bGVfcnVuX3VwZGF0ZSh2b2lkKTsNCj4gPiAraW50IHRkeF9tb2R1bGVfcG9zdF91cGRhdGUoc3Ry
dWN0IHRkeF9zeXNfaW5mbyAqaW5mbyk7DQo+ID4gIA0KPiA+ICAjZW5kaWYNCg0K
