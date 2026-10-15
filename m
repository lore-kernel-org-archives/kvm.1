Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255654CF74;
	Thu, 15 Oct 2026 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080477; cv=fail; b=EsgkWDpT8PN+ZxNpCkXkb15ulCmkj9T4el4QoIG68LY+XiHSI7ejrfrQhwuHldDwCd5XWqmUOburOw7DAL1CC2ij/CPPlUYnNQ9Np8Zbi4jcQqi8g1gHY4+OhCu5D8WuWiTjpeVuVtjlHS8/CGuFu3xW39f22nSIqcHgcgJujA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080477; c=relaxed/simple;
	bh=24V8WgDPjxJIdIThuazGC0nc6TwVtciSCmj/1DhSBok=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pln962zTyY9oHjEsZyKVy2P4G9HTMXt7+DKXrdP27Fc3twSqLLPVIQo5N6JdqNYJoNjnfsjaXbiKGQQC6wdOb0YlNIDXdYGUylvhQcDuGY5CAk9MfdmzSPOOA3nqZULxsHkRcFNOJ71EqvdD0LgMDFaiQ520Gx92gmOrjQVNZU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5zYtAbB; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5zYtAbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792080466; x=1823616466;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=24V8WgDPjxJIdIThuazGC0nc6TwVtciSCmj/1DhSBok=;
  b=i5zYtAbBqZ5TQASF1duwBXt5Pi4N+5upgzsXIbxbjExW+b/eoP+KcT4D
   Y1in3WbRQ9lSzgT20ASSrGBoy3Jg8dahOO5fQp+k2dHeX8+IGvWes60Xv
   DiQCAeZeNNwxTGWnAlHnFCqUrjEsLDCwNVijJHOIoj2S2aSBTQ2X/N6w8
   ZJoxfybg5ZZEvdFl96Jfj42yvwM84lYPtorCKwxCGf+ZblbBBwvfgn2P5
   Z0sA6zwHzKtrjGh+8JqKMRw74BxMGFPkMAqPBCOHD9TpruyI0Fs5f6oj7
   mJRD0uLPAnB0wF22BPmfkip40xXN1J89ZhmIhpwcKCZllY+xxwFf9jh49
   g==;
X-CSE-ConnectionGUID: uFtLCxeWQ96QYOedUEIqkA==
X-CSE-MsgGUID: rGJPz+7nT5aRXkElslnQpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="868532"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="868532"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 09:07:32 -0700
X-CSE-ConnectionGUID: j0DNPFMBTMaVDCCxa1JifA==
X-CSE-MsgGUID: q/MkDfSQSOOSRVinWPU8wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2196739"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 09:07:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 09:07:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 09:07:28 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 09:07:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fF0R1te7a/6dwIwDI/AnmJZAle1FyeMmN+nQHgEPj3U55gNIkrn4DuZF1kOzw+Cn6rV5x45zibWBar7C5cMS7UjyK2ZvDRB4OeLaZjx7xOxyGxZHHMuy6Y3jI4FV1i60Eesj8DOKZQ+kVeNYAA6Hid4Gtx+EsDERcSJp20ooZrDHjE4sdXlECt/1dnJ8zsA2NuZSsuMhEQu5DFqeHZlvVfYvYuwRy1tqOdN7eRjugIMrrb4fk7WeatbAFGPLhYY5uX7IM7MKil2O8Hm7IUbHUFCd0fLy4ybVMEdSw4LuZbbOI0qOf8XjzKUUw3pOZ3PWlyiAvKcIvHmDuGtDUfD1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZICDSqRulH/BLnA8NdCxMuBNBDrRU2GHgJkoDCyZ3A0=;
 b=ar09rUAvMvUms9TAb0PTNMKb8ohYb9TsccEPBE8ITGydJ4dltglMTa5UC2Tn/DZCCExo6GxfOmPGWxEueeNWpCUsan8YGCP3FWtbEm+wCAXI4uImDyTnP0KfK/U4721yD3AxPfonuPGqswcQ8yaegy+iNqN+JQAm7182S09vuvOMJ+83oA8zJe/sL7Rozg/AwVIiy0DmrQ3mTjCVnHmnuLM5pqN/3lzv7NxcplrYpaEfYhEDlwOZ10xfwnGbksd5+Ok6bXIt/PAuylTszSRQMPIwEOogNv7nEhh52P+8sAK7NZI02lzZf/ryV7cC3fmALM/Uu6F9SNRCXmy7ZQESCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by CH3PR11MB8416.namprd11.prod.outlook.com (2603:10b6:610:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 16:07:16 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 16:07:16 +0000
Message-ID: <ad3808a2-14b6-409e-a268-4572e8814f55@intel.com>
Date: Thu, 15 Oct 2026 09:07:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/18] fs/resctrl: Add interface to modify kernel mode
 via info/kernel_mode
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <e22be68142d869873532f21e42f049414e1cff99.1790867441.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e22be68142d869873532f21e42f049414e1cff99.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:303:dc::24) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|CH3PR11MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f4610c-aca1-4c74-8f81-08df2ad66181
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|56012099006|5023799004|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: zj4bqht4pMVJe5yCeZW7i1h6AjSBEadmIsCmmFeccL3IubDCqTdhQM/N7Oc8Yp2yLotcjlK9TpQKUy4FOp4lTDVctLIkKPKnpyA5Mf8nlRUqialU7qyQWtuB0mrW3P3pl50m9DBUcnoGcF6JEwtpymamDihsNUlYyI3HlqIB+o6bAxfGypoPWN1bFCM1HGCIWjrjbqPJTzVtqzwDHa3U1mT/WWFA1efPb8QV088BtcYFrd1xDdl/xVDuaOFEYYh43YtOI4thtISq/u6qM/8dAEaN1GnefB/ro36Z4plBEt/P3gdvbuk74TKgouK6f9XAxcPG73RUDz7BGNQBRPaLCUfNIFnMwpGgYBnsch1TzW9NaCcf4EiR2AkybKli/tNJzlZ2qyg/Q2dcPEwT1TwpjQcAZC4KnabxwCvcjyf3RG7QJCQb3u4jmSYB1PLq9ZVPAIVK8Irdh8+BuKe6T63cSOoJMvluX1jgYO42Z8i/lOEc2D4ne8mLOyMSPqizpuVijb41MajZw0jdSg+XtKA7DX4rA9K8KfvpzpbXSu5FKEMu4OpGcJt6FyGlNpAWyXphKvY1GO9jT9dAnSyrmLnGBglj1HQdAjM6GLfZj9AY/tgfI9lZAesMaVXNVgetfwseNKCtPpr28ghv2H46lk6I9zSE4ta+IIIc0flmFEWkQeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJHcjJzZzFCSXRzeVhDVjhvcGdDVnN4b3lOaklUZFBNY01rTUYyZzlySTB2?=
 =?utf-8?B?dkFCN2xHVktTY0U3WGk5bGI0cUowaHN0QjZadFcvcmdQNGdrbEpFQnF3QmJK?=
 =?utf-8?B?U0doL3lDZmQ0WUZteEtFcXVyTjl0T3Z0RG5XOHc1V0orNkYzMy9DVG05WHFo?=
 =?utf-8?B?K1VSK0tpaUovc0dlK2lnMkIvbGRYcm9xL09JWGR0a2o4YlJ6TFZlc0ZJVS9u?=
 =?utf-8?B?eHFCc1IxVnJWWkJiei9idS9obWExM1IrMFE2Q2VVMnFXNU9PVzd6RldEQ3FY?=
 =?utf-8?B?a3pUanF5dTlmekF5U0dOZ3FJUGdGSUpKRDdEM0wyZkdPdUJCNDRja1Z5dFRr?=
 =?utf-8?B?dHhuSGk1Q2d2R2VPdzdybEhxaTloendoRnJmaFhYZGhXZGJvb21JR2xMVHdU?=
 =?utf-8?B?N0VZY1NNQWRkalRIU21BZ1BvL2d0ZWMwZHB4Z0ZBQ3gwbHdyMzdJNy9zMjBB?=
 =?utf-8?B?U3ltSlAreW5kbUZHTXhuRlV6SmFUeU1zWkhwZ0gwL2x4L0xKcE9TNWkzRWpx?=
 =?utf-8?B?eDVRbkUxTFpBSkdRZUthaVFCK21rQnJwS1lQUW9PZnAzNXlYRklHNllyWGRJ?=
 =?utf-8?B?a2M5TGpYU01HSmNDa3o5akViUXpSb3B2Q2hJQmRCWS9tU3NuU0kwOUJGY3J5?=
 =?utf-8?B?Unh4RDlSWUR4VVhJbFhoNE5ONFpKMjlpVERMLzY4T2hlVlQ5SHhOKzJWOTZt?=
 =?utf-8?B?dTNnN2NEcTVRc0xoWnhnMzRsNVdMcU5YMlZGTG1mb01kOVhlRHBsRm51NVZF?=
 =?utf-8?B?SEk3Z0ppeGFvTFhQcXNneXE1REhpTzBTSmtMb05OZXNHMFk3QlpucHY3cGJt?=
 =?utf-8?B?R2VYWTVrZ0VVRSs3N2pKYnNxSHdPaC9FM0hrMkIrb29hZjczMkRlVWd3UDlu?=
 =?utf-8?B?Zys4SlBVY2V1ZVozSGxrMXRVT3kwUEgvekxTckhhcHZKMHNuNGRyZERINVNo?=
 =?utf-8?B?eSt5eUJ3eUM4azVSN3BhYktiOTJmdzl0V01aMlVML005QktYTUpqbHA5TU4y?=
 =?utf-8?B?eUFqenlKSDc2bjVXQmRQK3pTV2FZak5ERndRcEowQlBvWVQ0dlRrdnRlWStm?=
 =?utf-8?B?NnRoc0swbUZMVlBVS253QkFMTTdBSlVLR2IxRnk0ejZnZHdFUm9pVENRNWdK?=
 =?utf-8?B?ZXk5RFp5dHhweERMV0FaSHQ4cUVkcU9FTzMrSCtlK0RYbUplbEl5V1F4Z1ZN?=
 =?utf-8?B?RUp3NU9ZWnNrQjhvSEltUXRMMGZsZTQ3VmV5TzVVNXFCakRYbDRQeFhDNTIr?=
 =?utf-8?B?TzdEVlN3SHQ5YzFtVkh4VW1zRlhzdmx6ZmtnVlZBY0JrTlQ2RTF6ZHM3L1lL?=
 =?utf-8?B?Q0I3eEYwYU00UWlMMmdIVVpRdVA4ZVNOdUREM1d4UGVWYXlkOWQxd3FKRS95?=
 =?utf-8?B?ZTNuWmFnSUhHTnRzUmxXWW1vUUtEbE1GS0NmVW04R090Qk9JdzFCRXdMVFhi?=
 =?utf-8?B?ZktxdVRoUEVvZXBwVHlIWHFhT1V5T2VsQkMwcm1GcWxqRW5KTmRIRTVyQkVH?=
 =?utf-8?B?S1BobXEzaXRwYjBLeWs4MXM0SkpFR0hSSHZ6QWFiM1luTUNDVVQ3YW93S2h0?=
 =?utf-8?B?UkFJUnNZaWxuV3Q4bXdvaktZdTF2anQ1b1FNQ1J1VVZUdDQ4cWpmMkZWempE?=
 =?utf-8?B?eDhDQzhIYWwxTEk0QzVJRm5Mc1lPaHIxS1FjT1U0WEZadVhCdlFKZ2Qwbi9x?=
 =?utf-8?B?MmtqdjM2MFMyd3dwa1kvcklGZTg0aThWZmFEajVvclJ1Nkt0amFLb0I3Yk1H?=
 =?utf-8?B?a1owamRKYk1BN1lLdStaZndXenZoTmYxRkRoYWlSbGQrZ0NRa1BlOGErNTJU?=
 =?utf-8?B?dTJpWENieEhVSllMRHZDQ1lyekcxNktNcTVZNnlDSW5GVzZNZEhiT3VTdlZ0?=
 =?utf-8?B?ZW9vY0YvMW5PZXI0RjA5RDNoUEtwZXRsM21OUDRNa2lnc2RJaXRZblk3S093?=
 =?utf-8?B?WFR5Z1VkOHptZVdnVUZ3MHBKTW5yRTFTNUJGU2JZMkxYU0RVYVpHN0dkUExY?=
 =?utf-8?B?Wml2L2hld2NkZnpvZUtkUlBHRmFoakJTVFI4S2NDZjhGdUVFTC9KWDAwSDl1?=
 =?utf-8?B?Y0liaFpxN0VmTmtVNW9xZzI0ZmhHTHRNZDdvcmlWYUFuSTEyMjE2VzAxSlNi?=
 =?utf-8?B?ajlpcUVTZCtFYzhWSkRoeWFvcWNhdzgxNk9xOVpabGErNytYMGt5ZVFQei9p?=
 =?utf-8?B?WTdFQ1J4RlVsTGtIc29UTzFsVDIra2dVOUg1SEsyb0pQRXNLTit2Vmd3TXI5?=
 =?utf-8?B?b0NWQVZxbUllaDMvSUFkakw1WEU3Q05iVStqcE9yd0pnWTQ3Sm9OdWsyVDRF?=
 =?utf-8?B?TXFsSXhrZmM2NGtIcTlFVmZwN2p4R3RsMWd2d2FxN0R5QXdDVFBZR0xvbVd6?=
 =?utf-8?Q?X1tsVTmPGdWwx6C0=3D?=
X-Exchange-RoutingPolicyChecked: brglCKFz4g6rTXqRsScxpZfJzG32ZcVUeWhX/gHf3m5UEjuO3sc6BO80GfFZ+hvgh4yfohOFfLJJi3Q7EE05iZ9YrcrJjpJuUJYcSAsSjeu5p62DHy+C+9VXPGCbSqx/XNLN9WaxRnBqZ0R9jKXXY8bSNEXTQL6HxGW4lZSIyFf+uSS1amDfJhtP6YJ+dqYnQhK026GXj5rnvtmi8pKyENNT28zYpvY4do4+EwhbOVUbR0Y0bZAdiNEzAVGp8z8As+JDKOGzo1VohByLAzzEcKzVZj/WjhYGns7byHzxi27TI+jK1f4DYLyH5jqu2G+kdgGQ+iQAx7GVIyHddAJjBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f4610c-aca1-4c74-8f81-08df2ad66181
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 16:07:15.8697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oqr4AUS7u9NYZWvaWQF5f3rnYEn3Txav2I7ydMr5v9VT56+m4uRjChuAZXq/aAd4bnwNcpb+pk8am90YlFUFxuHEzcg1HvwhwZepEv4FYFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8416
X-OriginatorOrg: intel.com

Hi Babu,

nit: subject states this adds new interfaces but that is not true?

On 10/1/26 8:10 AM, Babu Moger wrote:
> ---
>  Documentation/filesystems/resctrl.rst |  28 +++
>  fs/resctrl/rdtgroup.c                 | 274 +++++++++++++++++++++++++-
>  2 files changed, 301 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 73ccbb9594f5..bf9d34d6a335 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -575,6 +575,34 @@ conveyed in the error returns from file operations. E.g.
>  	  [inherit_user]
>  	  global_enable_per_cpu:ctrl=assign;mon=assign;group=//
>  
> +	Writes use the same line format as read, without square brackets and
> +	with a trailing newline.
> +
> +	inherit_user is written without any parameters.
> +
> +	For global_enable_per_cpu, the parameters are optional. An omitted
> +	ctrl=, mon=, or group= keeps the value currently shown. Parameters

"keeps the value currently shown" -> "keeps the default values" 
Text as suggested, or similar, will connect this text with the earlier
"When the mode is not active, the parameters are the defaults ..."
Although, please check earlier comment about the "parameters are the defaults"
text.

> +	may appear in any order. Empty values are rejected.

More on this later but I do not think it is possible for parameters to
appear in any order ...

> +
> +	Selecting a new mode, parameter, or group replaces the active
> +	association. A new global_enable_per_cpu association sets that
> +	group's kmode_cpus to every online CPU. Errors are reported in
> +	"info/last_cmd_status".
> +	Example::
> +
> +	  # mkdir ctrl1
> +	  # echo "global_enable_per_cpu:ctrl=assign;mon=assign;group=ctrl1//" \
> +	         > info/kernel_mode
> +
> +	  # cat info/kernel_mode
> +	  inherit_user
> +	  [global_enable_per_cpu:ctrl=assign;mon=assign;group=ctrl1//]
> +
> +	  # echo "inherit_user" > info/kernel_mode
> +	  # cat info/kernel_mode
> +	  [inherit_user]
> +	  global_enable_per_cpu:ctrl=assign;mon=assign;group=//
> +
>  Resource alloc and monitor groups
>  =================================
>  
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index dcf9f26540d6..73749e5a4ad0 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1216,6 +1216,277 @@ static void rdtgroup_kmode_global_detach(struct rdtgroup *rdtgrp)
>  	resctrl_kmode.mon = KMODE_ASSIGN;
>  }
>  
> +/* Program @rdtgrp on every online CPU and show its kmode_cpus files. */
> +static void rdtgroup_kmode_global_activate(struct rdtgroup *rdtgrp)
> +{
> +	cpumask_copy(&rdtgrp->kmode_cpu_mask, cpu_online_mask);
> +	resctrl_configure_kmode_global(&rdtgrp->kmode_cpu_mask, rdtgrp, true);
> +	resctrl_kmode_global_files_show(rdtgrp->kn, true);
> +}
> +
> +/**
> + * rdtgroup_by_kmode_path() - Resolve a "<ctrl>/<mon>/" path to an rdtgroup

It is a contradiction to have description read "Resolve a "<ctrl>/<mon>/" path"
and then the control and monitor group names are provided as separate parameters

The function name also includes "path" but there is nothing about a path in
the implementation, the caller parses the path, no?

> + * @ctrl_name:	CTRL_MON group name, or "" for the default control group.
> + * @mon_name:	MON group name, or "" to select the control group itself.
> + *
> + * Matches the path syntax displayed by resctrl_kernel_mode_show():
> + *   "//"            - the default CTRL_MON group
> + *   "<ctrl>//"      - CTRL_MON group @ctrl_name
> + *   "/<mon>/"       - MON group @mon_name under the default control group
> + *   "<ctrl>/<mon>/" - MON group @mon_name under control group @ctrl_name
> + *
> + * Return: Pointer to the matching rdtgroup, or NULL if no such group exists.
> + */
> +static struct rdtgroup *rdtgroup_by_kmode_path(const char *ctrl_name,
> +					       const char *mon_name)
> +{
> +	struct rdtgroup *rdtg, *parent = &rdtgroup_default;
> +
> +	if (*ctrl_name) {
> +		parent = NULL;
> +		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> +			if (rdtg->type != RDTCTRL_GROUP)
> +				continue;

All entries of rdt_all_groups are of type RDTCTRL_GROUP, no?

> +			if (!strcmp(rdt_kn_name(rdtg->kn), ctrl_name)) {
> +				parent = rdtg;
> +				break;
> +			}
> +		}
> +	}
> +	if (!parent)
> +		return NULL;
> +
> +	if (!*mon_name)
> +		return parent;
> +
> +	list_for_each_entry(rdtg, &parent->mon.crdtgrp_list, mon.crdtgrp_list)
> +		if (!strcmp(rdt_kn_name(rdtg->kn), mon_name))
> +			return rdtg;
> +	return NULL;
> +}
> +
> +static int resctrl_kmode_parse_state(char *val, enum kmode_state *state)
> +{
> +	if (!strcmp(val, "assign")) {
> +		*state = KMODE_ASSIGN;
> +		return 0;
> +	}
> +	if (!strcmp(val, "inherit")) {
> +		*state = KMODE_INHERIT;
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int resctrl_kmode_parse_group(char *group, struct rdtgroup **rdtgrp)
> +{
> +	struct rdtgroup *grp;
> +	char *mon, *slash;
> +
> +	slash = strchr(group, '/');
> +	if (!slash) {
> +		rdt_last_cmd_puts("Group must be <CTRL_MON>/<MON>/\n");
> +		return -EINVAL;
> +	}
> +	*slash = '\0';
> +	mon = strim(slash + 1);
> +

The reason why we picked the <CTRL_MON>/<MON>/ syntax is because "/" is the
one character that is not allowed by kernfs to be in a directory name,
additionally resctrl rejects \n in group names.

This parsing should thus take care with stripping spaces and just parsing
in general to support all the different resource group names that users
may be able to create (it may even contain ";"). Because of this it seems that
it should be required for the resource group to be the last parameter provided
by user space since it will be terminated by \n that cannot be in a resource
group name?

> +	slash = strchr(mon, '/');
> +	if (!slash || slash[1] != '\0') {
> +		rdt_last_cmd_puts("Group must be <CTRL_MON>/<MON>/\n");
> +		return -EINVAL;
> +	}
> +	*slash = '\0';
> +

The user should not be required to provide a monitor group when 
"mon=inherit" or if system does not support monitoring.

> +	grp = rdtgroup_by_kmode_path(group, mon);
> +	if (!grp) {
> +		rdt_last_cmd_puts("Group not found\n");
> +		return -EINVAL;
> +	}
> +	*rdtgrp = grp;
> +	return 0;
> +}
> +
> +static int resctrl_kmode_parse_parameters(char *params, enum kmode_state *ctrl,
> +					  enum kmode_state *mon,
> +					  struct rdtgroup **rdtgrp)
> +{
> +	char *key, *tok;
> +
> +	while ((tok = strsep(&params, ";"))) {
> +		tok = strim(tok);
> +		if (!*tok)

Please use the same string parsing patterns as the rest of resctrl. Specifically,
please use the familiar (to resctrl) comparison against '\0' as in "if (tok[0] == '\0')"
instead of pointer dereference like above (and below).

> +			continue;
> +
> +		key = strsep(&tok, "=");
> +		if (!tok) {
> +			rdt_last_cmd_puts("Empty kernel mode parameters\n");

Not sure how accurate messages should be but this is just duplicate error message
of when there are no kernel mode parameters when the issue is actually that "="
is missing.

> +			return -EINVAL;
> +		}
> +		key = strim(key);
> +		tok = strim(tok);
> +		if (!*key || !*tok) {
> +			rdt_last_cmd_puts("Empty kernel mode parameters\n");
> +			return -EINVAL;
> +		}
> +
> +		if (!strcmp(key, "ctrl")) {

Should this not fail on a system that is not capable of allocation?

> +			if (resctrl_kmode_parse_state(tok, ctrl)) {
> +				rdt_last_cmd_puts("Invalid ctrl= parameter\n");
> +				return -EINVAL;
> +			}
> +		} else if (!strcmp(key, "mon")) {

Similarly this should fail on system that does not support monitoring?

> +			if (resctrl_kmode_parse_state(tok, mon)) {
> +				rdt_last_cmd_puts("Invalid mon= parameter\n");
> +				return -EINVAL;
> +			}
> +		} else if (!strcmp(key, "group")) {
> +			if (resctrl_kmode_parse_group(tok, rdtgrp))
> +				return -EINVAL;
> +		} else {
> +			rdt_last_cmd_puts("Unknown kernel mode parameter\n");

nit: "Unknown" -> "Unsupported"

> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int resctrl_kmode_global_validate(struct rdtgroup *rdtgrp,
> +					 enum kmode_state ctrl,
> +					 enum kmode_state mon)
> +{
> +	if (ctrl == KMODE_ASSIGN && !resctrl_arch_alloc_capable()) {
> +		rdt_last_cmd_puts("ctrl=assign is not supported\n");
> +		return -EINVAL;
> +	}
> +	if (mon == KMODE_ASSIGN && !resctrl_arch_mon_capable()) {
> +		rdt_last_cmd_puts("mon=assign is not supported\n");
> +		return -EINVAL;
> +	}

Does this mean that user can provide "ctrl=inherit" on system that does
not support allocation and "mon=inherit" on system that does not support
monitoring? That does not look right.


> +	if (mon == KMODE_INHERIT && rdtgrp->type == RDTMON_GROUP) {
> +		rdt_last_cmd_puts("A monitor group requires mon=assign to use its RMID\n");
> +		return -EINVAL;
> +	}
> +	if (rdtgrp->mode != RDT_MODE_SHAREABLE) {
> +		rdt_last_cmd_puts("The group is not in shareable mode\n");
> +		return -EINVAL;
> +	}
> +	if (rdtgrp->type == RDTMON_GROUP &&
> +	    rdtgrp->mon.parent->mode != RDT_MODE_SHAREABLE) {
> +		rdt_last_cmd_puts("The parent group is not in shareable mode\n");
> +		return -EINVAL;
> +	}

I think it will be useful to organize the "kernel_mode" resctrl.rst portion
for writing to "kernel_mode" similar to the portion for reading to clearly associate
the above rules with the "global_enable_per_cpu" mode.

> +
> +	return 0;
> +}
> +
> +static void resctrl_kmode_switch(enum resctrl_kernel_mode mode,
> +				 struct rdtgroup *rdtgrp,
> +				 enum kmode_state ctrl, enum kmode_state mon)
> +{
> +	if (resctrl_kmode.rdtgrp)

Please do not use resctrl_kmode.rdtgrp as synonym for and interchangeably with 
resctrl_kmode.kmode_cur == RESCTRL_GLOBAL_ENABLE_PER_CPU. Please check
other places too, like in resctrl_kernel_mode_write()

> +		rdtgroup_kmode_global_deactivate(resctrl_kmode.rdtgrp);
> +
> +	resctrl_kmode.kmode_cur = mode;

Now looking at how things come together, what do you think of renaming
"kmode_cur" to "active"? "kmode" in "kmode_cur" is redundant and "active"
looks to be a good match with existing documentation ("... with the
active mode enclosed in square brackets") and code like
rdtgroup_kmode_global_activate() and "active" used as local variable in
resctrl_kernel_mode_show().

Similar to this, could resctrl_kmode.kmode_sup be renamed to resctrl_kmode.supported?


> +	if (mode != RESCTRL_GLOBAL_ENABLE_PER_CPU) {

If this is needed please make the test explicit to the "inherit" mode.

> +		resctrl_kmode.rdtgrp = NULL;
> +		resctrl_kmode.ctrl = KMODE_ASSIGN;
> +		resctrl_kmode.mon = KMODE_ASSIGN;

Something does not look right here ... function parameters provide values that are not used.
If any reset is needed, should it not be done as part of rdtgroup_kmode_global_deactivate()
especially since it appears that the contract with architecture is for disable of
global kernel mode to mean that inherit mode has to be enabled?

> +		return;
> +	}
> +
> +	resctrl_kmode.ctrl = ctrl;
> +	resctrl_kmode.mon = mon;
> +	resctrl_kmode.rdtgrp = rdtgrp;
> +	rdtgroup_kmode_global_activate(rdtgrp);
> +}
> +
> +/**
> + * resctrl_kernel_mode_write() - Set the active kernel mode
> + * @of:		kernfs open file
> + * @buf:	write buffer

Could this be more specific about what the buffer represents? For example,
	Kernel mode line written by user space

> + * @nbytes:	length of @buf
> + * @off:	unused
> + *
> + * Return: @nbytes on success, negative errno on error.
> + */
> +static ssize_t resctrl_kernel_mode_write(struct kernfs_open_file *of,
> +					 char *buf, size_t nbytes, loff_t off)
> +{
> +	struct rdtgroup *rdtgrp = &rdtgroup_default;
> +	enum resctrl_kernel_mode mode;
> +	enum kmode_state ctrl, mon;
> +	char *params;
> +	int ret = 0;
> +
> +	if (!info_kn_lock(of->kn))
> +		return -ENOENT;
> +
> +	rdt_last_cmd_clear();
> +
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n') {
> +		rdt_last_cmd_puts("kernel_mode: Invalid input\n");
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +	buf[nbytes - 1] = '\0';
> +	buf = strim(buf);
> +
> +	params = strchr(buf, ':');
> +	if (params)
> +		*params++ = '\0';

Why not use strsep() to be consistent with other parsing in resctrl?

> +
> +	for (mode = 0; mode < RESCTRL_NUM_KERNEL_MODES; mode++) {
> +		if (!strcmp(buf, resctrl_kmode_str[mode]))

The whitespace trimming is inconsistent. Whitespace is trimmed from buffer,
but before looking for the ":". Looks like something like 
"global_enable_per_cpu :ctrl=assign" fails with "Unknown kernel mode",
while spaces around ; and = are accepted. 

> +			break;
> +	}
> +	if (mode == RESCTRL_NUM_KERNEL_MODES) {
> +		rdt_last_cmd_puts("Unknown kernel mode\n");
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +	if (!test_bit(mode, resctrl_kmode.kmode_sup)) {
> +		rdt_last_cmd_puts("Kernel mode not available\n");
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	if (mode == RESCTRL_INHERIT_USER) {
> +		if (params) {
> +			rdt_last_cmd_puts("inherit_user has no parameters\n");

nit: Just in case resctrl needs to add parameters later, could this be
"Unsupported parameter" instead?

> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +		if (resctrl_kmode.kmode_cur != mode)
> +			resctrl_kmode_switch(mode, NULL, KMODE_ASSIGN, KMODE_ASSIGN);
> +		goto out_unlock;
> +	}
> +
> +	/* Omitted parameters keep the values shown by reading the file. */

This comment does not seem to match the show() that always prints resctrl_kmode.ctrl.
Should rdtgroup_kmode_global_deactivate() reset relevant resctrl_kmode fields?

> +	ctrl = resctrl_arch_alloc_capable() ? resctrl_kmode.ctrl : KMODE_INHERIT;
> +	mon = resctrl_arch_mon_capable() ? resctrl_kmode.mon : KMODE_INHERIT;
> +	if (resctrl_kmode.rdtgrp)
> +		rdtgrp = resctrl_kmode.rdtgrp;
> +
> +	if (params) {
> +		ret = resctrl_kmode_parse_parameters(params, &ctrl, &mon, &rdtgrp);
> +		if (ret)
> +			goto out_unlock;
> +	}
> +
> +	ret = resctrl_kmode_global_validate(rdtgrp, ctrl, mon);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (resctrl_kmode.kmode_cur != mode || resctrl_kmode.rdtgrp != rdtgrp ||
> +	    resctrl_kmode.ctrl != ctrl || resctrl_kmode.mon != mon)
> +		resctrl_kmode_switch(mode, rdtgrp, ctrl, mon);
> +
> +out_unlock:
> +	info_kn_unlock(of->kn);
> +	return ret ?: nbytes;
> +}
> +
>  void *rdt_kn_parent_priv(struct kernfs_node *kn)
>  {
>  	/*
> @@ -2230,9 +2501,10 @@ static struct rftype res_common_files[] = {
>  	},
>  	{
>  		.name		= "kernel_mode",
> -		.mode		= 0444,
> +		.mode		= 0644,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= resctrl_kernel_mode_show,
> +		.write		= resctrl_kernel_mode_write,
>  		.fflags		= RFTYPE_TOP_INFO,
>  	},
>  	{

Reinette
