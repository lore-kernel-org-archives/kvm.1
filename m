Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793901019;
	b=hpf4V3Bm9uA0DWhrLc+IxpDSHOjjhZJApIUDWs8mWdNbcETG8dO9FuN1ypxcQo+4DZSq
	 /r/dMemgYn6/Iwz+I2KbTxTrosMhu5ZbqmFEKmPbDG330mQnMSVk5h0lReDMI8sQLmwrz
	 SL5lSAHWB0BYB+R5DGMvDSW611KtoZxTGTpapzv7xoJRBzR3GMP72ez08skQM/XnOWJEg
	 SA72Otaq8fmeQiF47BJ/VCAw8p8Gbp+nstu8CC9giW96/cm7ZYLAnHNzZZG7vgIvht6Iv
	 bLJTSFWb0jtedNIjzqXoNPVSA2dkZYdy5NGaG61R+Kp7i+r368jFnWpa70Cbk2KZcOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901019;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=H/WhSnMspej+rA2ceTatxogVWelX1bRrpIzT+tPsn74=;
	b=BuzM60L/b8UFNUzUelRQrsMw4DSu7I0TusW5G1sAsHmaFRbhmvhwn/nxda+EMuvy4Gz8
	 gIcEVR5b/RJrijtq7q/BZV7bv6BVAyGdheVUfNVkqmMBMsjN2LRdIJcygtAh3zIxD9JRl
	 ZAc1glubuv0wbz361rv+QcFDxxW1UCU4PRHENqg4hxgWefKoC15uHA2NvaBUk0f7G8hp9
	 5/m7Pmmx5troQAotAHBWKWeBGl6bZ3u/+0+KqyCLQSwYqd3ghtLe1XVVVCDNjX4rj0Spj
	 GoN44OonfyXJqYL7o6CNPm/Y3milw7Az/jLfA8spV4YXbp7DrpnygefGneodR8Z+zyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bSBULRTc;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B76606A31B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 17:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7B76606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bSBULRTc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793901018; x=1825437018;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=p9we/sU4P0AGs4c6A8RBCKAj/uCGW2mRYhjK6D3IUqE=;
  b=bSBULRTcOdeuMKU9rCDvfr2oQrFWYudinf52VVnQwNGPLW+av54NZriQ
   pU2rP8M0QPJ6S5odGr12xSEI0CnvPHkxBP1+qrxB9/ujZL5sAHsqSZzxd
   wxCCL8XsbSdkSKq0vMukt8YGXfnpbmuBptlu6WkIzhhQr0J5i52DtHgSS
   ha4fVzHEKBwpTZwEJybs4jskDCcrlvCAU3S8sTBQv1J8JNstnNKw3dbbn
   yxP3H9D3xBqvIf2fECIDlJj1UNgmHyD89Vpg65cd077Qf2GzO8525J7eR
   JKpVrDxzaPDxghJnsDN8rEktqY+5HScK3F2YaFpu+D4K4jO5kRcVUgcle
   Q==;
X-CSE-ConnectionGUID: lPc0OEqzTwKazhjHcMRuwA==
X-CSE-MsgGUID: o81awZiLTkei0zmDqmXv8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2739375"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2739375"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 09:50:17 -0800
X-CSE-ConnectionGUID: unjX3ApcThOPl8tke4zDOQ==
X-CSE-MsgGUID: vDInXoSyQS2By+HofDhyBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7218600"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 09:50:17 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 09:50:17 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 09:50:17 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 09:50:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTpc9yaD4EVIO8+FomMym1AsJcrqJxRSITlhJbnA8M5p8gghIsoClkWI3tgajHO59p1j54cHFqosnya+2jYsVt/69BydBy8F4rV9NxHrcevJdidCS0nE3VFtyGNrMmYwBuzEE0YIUaDLjlYaKJFS6Qb0Z5AhQBtR4SJ/lOnmdKYzH92SBTyQIf4lOUd8oAXG++KSirk+AcVN8MOSeehJLWOLaPmYE67IDD4XAe1UuIUB9e/1QCzCbDhiII7cLBWe/84rUBQh2TAe5W/KC8qiGwhQyRKryr6YUY2JGsgkDPIWX3Igwusxg7IHgsJxAG9QzTOsrzuOVovwbsK/ZH2NDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/WhSnMspej+rA2ceTatxogVWelX1bRrpIzT+tPsn74=;
 b=q5SbFCVlE7eV9+NETjXSUPNx58T+U9dRA/jmRtXCisNXbBXQGk6FWUN0ij9njBBuRGC90zZow5+UTUjLI4zf1H+8rWTOr78EaXiUThpAz6Km+cHTgAkbjjV29B2/1aKSRSqPyuc3JHl+W8D8Ti2PDHeF14/v9qoaLPc/UwPdk83LEmR7tqzDdHSjszxIOg715VILLgcGT3sK+2as0bigN7d2acquqbDReD2gee/BKMqZBY/b01TwVuUMecLFVr/8gfIn6GvLzqj8e4t0S324xUI3bv0IprvHi1SDyA+69xIi9a71bEVzFriPRKZeEBawBYDoRZz9hncZFr/O85uGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8039.namprd11.prod.outlook.com (2603:10b6:510:25f::18)
 by IA3PR11MB9397.namprd11.prod.outlook.com (2603:10b6:208:573::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 17:50:15 +0000
Received: from PH8PR11MB8039.namprd11.prod.outlook.com
 ([fe80::42df:f465:90a8:df92]) by PH8PR11MB8039.namprd11.prod.outlook.com
 ([fe80::42df:f465:90a8:df92%3]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 17:50:14 +0000
Date: Thu, 5 Nov 2026 18:50:11 +0100
From: Piotr =?utf-8?Q?Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>
To: Alex Williamson <alex@shazbot.org>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, <kvm@vger.kernel.org>,
	<intel-xe@lists.freedesktop.org>, =?utf-8?Q?Micha=C5=82?= Winiarski
	<michal.winiarski@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas
	<yishaih@nvidia.com>, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [RFC PATCH 4/4] vfio/xe: Hide BAR ranges by default per device ID
Message-ID: <20261105175011.hufxczxki2l2ulab@intel.com>
References: <20261105153738.1938345-1-piotr.piorkowski@intel.com>
 <20261105153738.1938345-5-piotr.piorkowski@intel.com>
 <20261105085558.75666f25@shazbot.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261105085558.75666f25@shazbot.org>
X-ClientProxiedBy: DUZP191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::11) To PH8PR11MB8039.namprd11.prod.outlook.com
 (2603:10b6:510:25f::18)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8039:EE_|IA3PR11MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fa2b7b-fd7a-4e19-4bb4-08df3b653f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|10067099003|3023799007|4143699003|261022075727099003|56012099006|261028144727099003|5023799004|11063799006|261102123227099003|261022105027099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261009223027099003|261102130727099003;
X-Microsoft-Antispam-Message-Info: L0SUPLYssv47F3rv6IWUs46ZeAiF1TdQW9wI9Jc+kpT9Nrtn6ccpZz0xgfmkVT7yy+RcV+UWmxd3uAT4ia90cmOinjaQC2lLxkqUfYN5r4uQIdxULBik1iRzoQb8OAuG1lvqVmUVWkLaaIi4qBAEWaAKVNbvPfud/7Si0IhSIX7QWc2gHCg2yccyb2xsV0pBFFt5feCfnliz7p8vD7o1fT4CUmdKTyhIS/yXuZCmkkYVbu1MQg+CtpCWkaP9o+ZYvsPdIuN977WxRWO2WiTDKNY72DhMtRk3Bqr3isVUc+S8deQFso50XGLmZ7+gVvY/L+fBFuwG4DJGChK7nPtzJ7qv6eDakjE0z0yXZTc+TUDzfmqa89GDWamvj97Vje2dxs9h63SYj9Lrw59oF937h6lu7Xq6BpnmAZ/8z9FwhR4/o3jhVJ1aa9+3xGw++NVXp362GcYtcvcEjVpl1ADk0cdLGuKMwsGZRHi+5RGScPLE3cedbpVMLpG/lgEUxe6l0vd8As5HUY/NSp87a0DofJgmRJGz+n4ucU3aiPi3o4EUGDtYy7uOO396Jd6Q8mMPCw40/IbYpyAgAUIw8dItdAQPld743oNQPvVff0X4/T7tyGAY7yt98rxBE/Ny/1heDkGc8EjRJP6IfaHqhqnq1XwrG/N6yF80he1zYBJa/xU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(261022075727099003)(56012099006)(261028144727099003)(5023799004)(11063799006)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102130727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejlCVThCZHBicjgybWxDTW8yVmxSek5kZ2MwRlpEMTloWkVTWTU3QWRsZGpy?=
 =?utf-8?B?aUtmMHZVdWluK2lWKzBEQjhYQlRHZXRhNU9GUU5RQjc2NjJwcE8rNWRlVXIy?=
 =?utf-8?B?QXFMcUh0YjBRVllQTFZ1OE9FSW96bnAwZVpXZEczMkFXdElITjZ6eUo0RWht?=
 =?utf-8?B?c0hCekU0VEdVcUlTblU5b05VbTVyNU9XQWRUZHhwd3UyRE1ZNmlBT3I1UUg3?=
 =?utf-8?B?WlBVdDlaMko1SGNzdWJMSDFwcmNQM2ZYYnRhOElQbjdEcENvdzRwanp5TzYr?=
 =?utf-8?B?Y0pBWXE4dzM4M3lVTEF0Mk9GRVhiV3VDTHpZWW00UDdRMkYzOFp4YmwwcG5l?=
 =?utf-8?B?RUNMcFlYeGZEOXhNR0I3c0lzL3Z4VVdCcVp2TlJuVjJGaW5WZ0FPS1JqVzZV?=
 =?utf-8?B?VEh5ejlMNUxOQmFmSDBuRlFkVzlrWFBVcEVBRklJeVUyVVdVQmYxS3YwTXYz?=
 =?utf-8?B?QzlSQ2o3Y3hSMnVwTEpBbU16eEFjMEF5bGh0Q1lGODhUK2RrZy8zekJwcHo1?=
 =?utf-8?B?MDVyUWhCUzRacTlJSkxqMnNyc0JOWVd2OTU0R05rU1E0a00vUVQ5K1prdTFV?=
 =?utf-8?B?RXppWFI3blRUREhFU1QyNHFRRnF4N0Q5TnMxYmQzQzlPZjAvMDl1cUMxTU9M?=
 =?utf-8?B?RXlBS1FacGNmcGZUbjdwUGsxQ0VWT2lqYkRwYXh6elI2UXF2b1B1cC9sWWJt?=
 =?utf-8?B?ODZJSnp0NUt4V0RBOGNSOWhHdjE3Qk1kaURaL2dJekpteVd6U0JwS3Ftc001?=
 =?utf-8?B?WStrb2F1cHJMRVAxbU82YnZkWTF6NUlLeEZGZjNEUWttZ3AzNjhSTDhWTW94?=
 =?utf-8?B?Si9pdm9JQ0EzZVRrUjVnYW9maFdBOHVWRDd1eHptUkNuUFU0QUxMYlRIOEFk?=
 =?utf-8?B?U3pyTWVHbFM5dTBpT096NnAyOTJzTHBJQ1FKazR2TkErM0tKMVMzOGpLUUhE?=
 =?utf-8?B?NitLWmpucVhmTXpQUnF6SHY3K1QrdW9wMllqWWVVNy9GV09RM3NLNXE0Z1Fj?=
 =?utf-8?B?ZjhzbURrWGRmRkdWY3M4Wk50RDliYVN5dGhTVGdyUUZyQXFrS2pTcSsrcHZP?=
 =?utf-8?B?ZDhqcnBiVHdIV21HckNKZzlLZ3BUSkREU2RncVV6Zzg5TDR5M0MreHNXY3Jh?=
 =?utf-8?B?SHR6Z0Vmejg3UHk5RTBTeTdlenZrc1g1UkVXM3pwMXdTSzFwM1lBU0doUlN5?=
 =?utf-8?B?M2FTd2E2a3duMW1aOFNYZmFDUTg0YjAyNEFZaTY1TU9YVFJCeWVvWDVmRHhH?=
 =?utf-8?B?RlJ6OTI2anNlcjJhNzdMMjhab3huU1lDbGRnTWRGV05sYmp2a21USGIxcGpo?=
 =?utf-8?B?aUp4ZTEzU0czOFNqaEx5N1VTbmxsSnVOMlRDK1I2OHZwbEN1YTREZkROVHJE?=
 =?utf-8?B?dDl1MXJOUjVOUngzQnVvWk5FdDBwZGJhQjVBYXF4YnJudzRTbUROTm1zUXJz?=
 =?utf-8?B?cUh1TWNxZ2k0SndnUE5Iak5oTU56cGtscWRpSHROL09aVUFqWmNkYTdCNTQ4?=
 =?utf-8?B?SFdyYXFUSXBnelBTTHVsU1pQUEw4OTJVOWJnZVgrWVc5VEZ5VHVIQ01LOEpK?=
 =?utf-8?B?YllsaVNyWkkrUEY4a1ZCMTVIaWRyTUlVUFhXc01VYlNHeDhjZGt0NDluRlBx?=
 =?utf-8?B?ZmhZTG9nSEZTWDdjS3JWcGxDQ3k0eUZHbWIrS2dYMmdvVCthS25nQ3FlMVJ2?=
 =?utf-8?B?WDd6ZE90bWJpTzZXbXVuVkVDWGZ3SWt6NERmSncxZ1o2amF6K2RVWDZQTTBG?=
 =?utf-8?B?RmJPczZlWkdRUysrT0xJa3NSZiswSHYyVGxqaG82ZFEvMXlaYU5sNnl2cEw2?=
 =?utf-8?B?aUV1cjZvZjdCa1krNHVQMmRrTEtlWmEyUkM4UjNxNHQ5dnduOUJjM2tLOVZa?=
 =?utf-8?B?emZXeDVqRzIrQVA3c0FNZmtoNXFrbWVnalNYVGp1Ylk3NVVYOXNMbUp3ejc1?=
 =?utf-8?B?SVcwU05kWEhsRk13S0t4bHZOU1pZdmFRc0t4S2FhTzJWN09PM2tkMFJja2di?=
 =?utf-8?B?T3hkUm1Fajl5UDBXQjFTalcrLzFXREhiM0pib0t2cVpjVEFMZHFkTDhNVEV2?=
 =?utf-8?B?WTlkVGRIQjFCNmpDbDdqcDJQQldHWGxiVnJqWTRmUmtGNGhwN3NwYVVuUEVU?=
 =?utf-8?B?aE5GNTBFTXY4V3lJRFNuTmFCVXlWZ2VyWVJRUEZFcE5DZk9WQkdHRkw0UHFJ?=
 =?utf-8?B?VVRtUDhleGdRTkhwSHpyd1ZsclJKTEgvRWU2NDFxMkQ1RUEwbmppRzE5dmxn?=
 =?utf-8?B?VTY5RENFejJ4ZkxFd2JtbHhIK2JNSWJlWnp1V3c0MU1lQlFQNzhYT1ZKTDg3?=
 =?utf-8?B?SncyQjBubHVmaDQxck9Wa3Z2TEZRSVhpZUUzT1ZwbCtOSU1yNG5Za2lrT1Fo?=
 =?utf-8?Q?nseL2ehwqpd27BEo=3D?=
X-Exchange-RoutingPolicyChecked: H/ddfkj5kisor1WQvzV7XTXa//U8OrlLEZWitnwVUG/pEyXx6FayUStSg617AUGrQKo4MQ4M35c8VayRKWhknQ2e/UaZHsrzrMHCpJeYBVpYi0ALJSH8gDNSNwXwt8jJsRmrZaJ708QAGDFJNGqfWT1YwhiwKriyiTaSk4b6JpJaMKQdCALa0yDv90Qmz/nWioT+qfQf5cxkMhAibx9H+kVIwXxw5F5LXgGnzxo+WKNj4N4IBy3R4Sg411R337XOqIgBb9BPbiNvOcceEi5UGV4DqA5d4w9fCgC9yBIFkmBc4hEe20KOPy0IOOHL42DRRq5JMt/9wcNbe+35X5vcSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fa2b7b-fd7a-4e19-4bb4-08df3b653f2c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 17:50:14.8656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeCtllhcAv1+Q8FkcfxuUStSEK7UMt2Dt7akGqL7qTCzhw3Ci2tMmWdtFar20KnQIYo78HZJG60BR6SF53coS3CTcIR/eBXcdop17Sd8i/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9397
X-OriginatorOrg: intel.com

Alex Williamson <alex@shazbot.org> wrote on czw [2026-lis-05 08:55:58 -0700]:
> On Thu, 5 Nov 2026 16:37:38 +0100
> "Piórkowski, Piotr" <piotr.piorkowski@intel.com> wrote:
> 
> > From: Piotr Piórkowski <piotr.piorkowski@intel.com>
> > 
> > xe-vfio-pci accesses the BARs only through vfio-pci-core, so opt in to
> > hidden BAR ranges.
> > 
> > Let each entry of the PCI ID table describe the ranges to hide by
> > default. The description is always looked up in the static table, so
> > binding through new_id or driver_override can't skip them.
> > 
> > No device defines any ranges yet.
> 
> We don't merge dead code, so the whole series is to justify the
> configfs mechanism to introduce excluded ranges without publishing them
> to the community?  Hard no.  Thanks,

Thanks for the link, I wasn't aware of that series. I went through
patches 08 to 10 and they cover most of what I did here: the per-BAR
excluded-range list, the sparse mmap capability around the ranges, and
refusing ioeventfds and dma-buf exports over them. So patches 1 and 2
of my series are largely redundant, and the per-path flags
(EXCLUDE_MMAP/READ/WRITE) are more flexible than my all-or-nothing
hiding. 

On the configfs part: fair enough, I'll drop it.

I should also be clearer about the intent of the series, because the
way I posted it was misleading. It wasn't an attempt to merge dead
code, or to sneak in a configfs interface. I'm working on hardware
where part of a memory BAR has to stay with the host while the device
is assigned to a VM, and I wanted early feedback on the mechanism
while the design can still change. The fact that no device declares
any range yet is just a consequence of that timing - the hardware
isn't public, so I had nothing to put in the table.

I'll come back once his series settles, with just the device-specific
part on top of it.

Thanks,
Piotr

> 
> Alex
> 
> > 
> > Cc: Michał Winiarski <michal.winiarski@intel.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Yishai Hadas <yishaih@nvidia.com>
> > Cc: Shameer Kolothum <skolothumtho@nvidia.com>
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
> > ---
> >  drivers/vfio/pci/xe/main.c | 60 ++++++++++++++++++++++++++++----------
> >  1 file changed, 45 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
> > index 7dab3e024aa8a..e63af6123f598 100644
> > --- a/drivers/vfio/pci/xe/main.c
> > +++ b/drivers/vfio/pci/xe/main.c
> > @@ -24,6 +24,16 @@ struct xe_vfio_pci_migration_file {
> >  	u8 disabled:1;
> >  };
> >  
> > +/**
> > + * struct xe_vfio_pci_desc - device specific description
> > + * @hidden_ranges: BAR ranges hidden from the VFIO user by default
> > + * @num_hidden_ranges: number of entries in @hidden_ranges
> > + */
> > +struct xe_vfio_pci_desc {
> > +	const struct vfio_pci_bar_range *hidden_ranges;
> > +	unsigned int num_hidden_ranges;
> > +};
> > +
> >  struct xe_vfio_pci_core_device {
> >  	struct vfio_pci_core_device core_device;
> >  	struct xe_device *xe;
> > @@ -543,8 +553,32 @@ static const struct vfio_device_ops xe_vfio_pci_ops = {
> >  	.detach_ioas = vfio_iommufd_physical_detach_ioas,
> >  };
> >  
> > +#define INTEL_PCI_VFIO_DEVICE(_id, _desc) { \
> > +	PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, (_id)), \
> > +	.driver_data = (kernel_ulong_t)(_desc), \
> > +}
> > +
> > +static const struct pci_device_id xe_vfio_pci_table[] = {
> > +	INTEL_BMG_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
> > +	INTEL_CRI_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
> > +	INTEL_NVLS_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
> > +	INTEL_NVLP_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
> > +	INTEL_PTL_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
> > +	INTEL_WCL_IDS(INTEL_PCI_VFIO_DEVICE, NULL),
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(pci, xe_vfio_pci_table);
> > +
> >  static int xe_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> > +	/*
> > +	 * Dynamic IDs added through new_id are matched before the static ones
> > +	 * and carry no driver data, look the description up in the static
> > +	 * table so that they can't bypass the default hidden ranges.
> > +	 */
> > +	const struct pci_device_id *match = pci_match_id(xe_vfio_pci_table, pdev);
> > +	const struct xe_vfio_pci_desc *desc =
> > +		match ? (const void *)match->driver_data : NULL;
> >  	struct xe_vfio_pci_core_device *xe_vdev;
> >  	int ret;
> >  
> > @@ -554,6 +588,17 @@ static int xe_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
> >  		return PTR_ERR(xe_vdev);
> >  
> >  	dev_set_drvdata(&pdev->dev, xe_vdev);
> > +	xe_vdev->core_device.hidden_ranges_supported = true;
> > +
> > +	if (desc) {
> > +		ret = vfio_pci_core_hide_bar_ranges(&xe_vdev->core_device,
> > +						    desc->hidden_ranges,
> > +						    desc->num_hidden_ranges);
> > +		if (ret) {
> > +			vfio_put_device(&xe_vdev->core_device.vdev);
> > +			return ret;
> > +		}
> > +	}
> >  
> >  	ret = vfio_pci_core_register_device(&xe_vdev->core_device);
> >  	if (ret) {
> > @@ -572,21 +617,6 @@ static void xe_vfio_pci_remove(struct pci_dev *pdev)
> >  	vfio_put_device(&xe_vdev->core_device.vdev);
> >  }
> >  
> > -#define INTEL_PCI_VFIO_DEVICE(_id) { \
> > -	PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, (_id)) \
> > -}
> > -
> > -static const struct pci_device_id xe_vfio_pci_table[] = {
> > -	INTEL_BMG_IDS(INTEL_PCI_VFIO_DEVICE),
> > -	INTEL_CRI_IDS(INTEL_PCI_VFIO_DEVICE),
> > -	INTEL_NVLS_IDS(INTEL_PCI_VFIO_DEVICE),
> > -	INTEL_NVLP_IDS(INTEL_PCI_VFIO_DEVICE),
> > -	INTEL_PTL_IDS(INTEL_PCI_VFIO_DEVICE),
> > -	INTEL_WCL_IDS(INTEL_PCI_VFIO_DEVICE),
> > -	{}
> > -};
> > -MODULE_DEVICE_TABLE(pci, xe_vfio_pci_table);
> > -
> >  static struct pci_driver xe_vfio_pci_driver = {
> >  	.name = "xe-vfio-pci",
> >  	.id_table = xe_vfio_pci_table,
> 

-- 
