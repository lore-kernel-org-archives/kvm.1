Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1434AB01
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565896; cv=fail; b=OvDxHcNwXqwvXkpabkT96Ct+puIU3FjhYkPX1elshDfWPGo2SkLc/GDTtQEV7/SSYVLzMCB5Vp1mjVUWQc1Qf7VNoZXO1/gWPmG3UOGIhdUTRB3W5zq6gKojc69HUHFAl3bU/66+yrKrv5x/rcTqYS9v21uavpZmA1rceCROFAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565896; c=relaxed/simple;
	bh=WnQdFQwusREpb1hnY8MoQMH3ZEq0JARhfJlHJeF2pFE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=enQdv7TvB2v56Zbw1CcRroiXdVvDNgg3YCr0Ysfpgjpz/XiNQj2qmT4vO59LSCdG+JB9dR8CiaJ8mAKBeTBKUtHp5QehpsvNFEN4XNhdW+Tt1Y0crY//yOPsQ9J3HR2hP/s3HRB7NRTvm0OsfZm4jl3wC0rqR2S/dsm+U2OkyMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TASkYV0Q; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TASkYV0Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790565895; x=1822101895;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WnQdFQwusREpb1hnY8MoQMH3ZEq0JARhfJlHJeF2pFE=;
  b=TASkYV0QxK2yi6waWDTbNygwr8RKV2D60Z6W4D3wZyxuWrx84Ydk4H83
   piV4AunbzWfNuiS5ejhkYSNecSEem9JIrYZqk/R6+BNwHXavj/WLD2aZR
   FojETlmxSJoI4uGJCpZxvHVCIuhW63g8ddzqzMU/JgPj93gvVOoC1FafO
   jqaDTfFYEI9a4S6TNd4n98Kr2FbjE7LHwRoF/VqcVD0t1CjwsCAJLAAW8
   QlYqu7q1PccUF835rATGDFR6lDKqwoxH1F7yUlvG/+d2d5uPknfpZTT2Q
   W2suKW7K3z4SXbnn3AqK0WvVzwTk6VG3zjWEiSHh/Ks8dqApwHm+6U67l
   w==;
X-CSE-ConnectionGUID: lYvTCtLNTPCsdu3LirFTdw==
X-CSE-MsgGUID: 8JqzUscCRNKZ+/NVurPCPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101827761"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="101827761"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:24:54 -0700
X-CSE-ConnectionGUID: LzYmfTW5QCCoJwjJ63CeIg==
X-CSE-MsgGUID: sY+UmSi9Q2K1+uGotuXgow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="302872529"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:24:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 20:24:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 27 Sep 2026 20:24:53 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 20:24:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzwPsGXYMPN9sHshDxdO2KnaFjBQeIdSWmzVsloHBpAOo4Wa+7/JGxyNFiUnpzCD+05sV9AaMT9Dw880lMwTLrvJoJUBxYm0wJhJXcbJ9aN6BtbeQuD/ejJWv0mLadK0aj5gGhGiNFbzs32tR0ry7ncZx3qKMhzBtLC87XhxMdR80jnexRDv4XB9Fmhdevc7nG7tQr24YznI71mvGBPjOo1h0TKGak6u/dKbnVzDidYPAyz+Fg9PU2v+1eHcfsUXIpaW6eaPZNcHQVrhEi2cxRiSw1l6MgyOrbe6XxlfRXPLcFob9qhPwaKuLSomCiYZRF6FqmUejnS0KM6t9AdU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YD/qpMFM+4XQw/rqYYqZMTcqWozuolm2OuU4FIWRCfk=;
 b=MdZtoHz1XGtk8vzCwXMACbd9tApjf0Bjb4v6Nj9fHcEDn+DPzOflZN1WujPvt1PIkUk+emhQe52fEjegskYvD7G0ir8Qx0n38F2Empv/ekrJga51fYgWgrTY1eZKQw10TlUkLkuaQ35R0oHSRNskRTk3lP43GJpvAVS9szaKdeXrPYmWN1zbu6jD3ptzfwwgTSBc5MTiJJcRJ9Jm3Hm4dfvE+PO0kRhyzaG/EgrK2XfbrCK9psN6tkgwGcNZkJaAbGbB1Jp+hGWY8sihw5DwMv2FNWacZAURbml+cblpZCzjrgXqsTzefWfAw8vNkjTFTJJAyAVNvxjhN9Gp6r+0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 DS0PPFE96DC1E67.namprd11.prod.outlook.com (2603:10b6:f:fc02::50e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 03:24:50 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:24:50 +0000
Message-ID: <e7049a20-b9f6-4841-92ea-2e2a3abb4c4b@intel.com>
Date: Sun, 27 Sep 2026 20:24:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
To: "Serge Hallyn (AMD)" <sergeh@kernel.org>, Tony Lindgren
	<tony.lindgren@linux.intel.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Peter Xu <peterx@redhat.com>, Artem Bityutskiy
	<artem.bityutskiy@linux.intel.com>, Fabiano Rosas <farosas@suse.de>, "Jon
 Grimm" <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup Patel
	<anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	=?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Vishal Annapurve
	<vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, "Kai
 Huang" <kai.huang@intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Peter Fang <peter.fang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	"Xu Yilun" <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <arabZS5cIkPgw6ef@shallyn-amd>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <arabZS5cIkPgw6ef@shallyn-amd>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:303:2b::34) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|DS0PPFE96DC1E67:EE_
X-MS-Office365-Filtering-Correlation-Id: 3372df88-9cf8-4643-5103-08df1d100de3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|4143699003|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9kH8qJz+R6mA7eBoe6ynlWRvPm7YEuLvTiYcvFz6isa3aCou7PYkjLVoYM+831CW3y0gXo6fuhJzA1x/TZYgoiNQt4BbU1Je+QDvWpXeVTFmNM31pYrGiiL7lV1V/rrVtmm5MULaqnqOlHpm34wRx+mjRj2Z5HcEbX+EY+GDDi7mFYPPOrzxO4187/ff/1Zs55/dygyVvBhW2UT+75ttdYuRyzr3r6hVRxttbl2uBkF46xFpkCKlqMWXJVI8DJyFPCI0vzqAhg+Z2dUINAb0ye2oowJMajY5adLuXQgvq2kdfldftvCyLQJiVjymi51qIKBKB8gUDnjYGWd3O/yazeCP+v7HFTa6XX27xA3X0VnoeO3LEQIGAhCtItkbGJaJBRnjRxSpo4334Qut1Qenvziz4EZ6avFGUWHJGOAjAvkEFaYm21nhYUhRDvYkOJDRtrBZElxIzD3mDeEox3abbhntBhIGPHZclqOUVJ3M0v/Fm2ErF6vPo3CsPJeH16Ibx0pDuyzrwy1Z1bsSUsarLrObIGaNu6iaBAbvKU8RLqjPgrMjDYd3CcrFHQcxUJnuDUZ64086DL3yRXCbCqyzv6l5aebERuZsT3OtO96esvRx6eYMiRTbce3OFemvkMwYAaAZtRZnvenTyXHYv+jK3s8YhZr+66MD5G4iQGZ+ltY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW1HMlJtOStLT1FBQWpwOUhBY0dvWWRYcTNWMElmRTY0YUdON1hibjBNcWs5?=
 =?utf-8?B?R3dNd3ZIbTI1TzdpVnF6YnZScFFUVDYzUUoreVkyQXdFQUlHY0NMV0NFdlRy?=
 =?utf-8?B?c2l3bnZDZEhBREhLS0xjdzZqTzFmWDJmclJJNE41YVVGK0hQajNQSzd5SmZz?=
 =?utf-8?B?VHlHTU5UenFzQ3Q4SHk5Q3g5OFpSU2F5eGw5cXhCdFUwM25IU01OazRRc0dT?=
 =?utf-8?B?QUpueUZYSlF0SzlBaDR2NHFLTlRHU0M4YlpXNmNnMjVUWXVWSFpScm1mRGJ6?=
 =?utf-8?B?cnRQV3FTMDhGRThHVm9EQWJ0T3BEajgzZXhzQzRjYUE2ODhNckh6MkwvZmtn?=
 =?utf-8?B?WnY3MDJ0bXF3TlNXZUllNEtsam9mYzhNa1crVFhIWUIyb3krblFHY0dYSVNi?=
 =?utf-8?B?UDlhWmYvY1dkSE9yTlFUVVlESTZub0dsM3ZHL2hob0ZSY3BYMThRUUJQY25k?=
 =?utf-8?B?cWpvYWhRd2JxWW1UdHE0cHNhekJEeGgwa3V1ckNmVHNLVUdVbmQ4QndHM1BY?=
 =?utf-8?B?TkZzZ0FzUXJXQWZnaDNNVDZkQkRoMXMrQjZkdWkxY01GNDdTWDdPZHpNRG1n?=
 =?utf-8?B?YWQrbjg5YXNkNFdhNE5PNTZtYWY0RmZNRXNIVnFJaVp0SS9pVWdod3ZWaUYx?=
 =?utf-8?B?S0JUYnRMLzE5V1ZkZDZjSWdtUXdTOGorT3dqaFRhZlgzb1Y3cWdEb05CU1BL?=
 =?utf-8?B?ZU1BaTY4VWF4YlNuSXBxakl1TGh0SDc3bndZTFNneDhUd0R3U0xXbmxWRE9G?=
 =?utf-8?B?bGxnVTJzRUl3RFIxRjlIaTQ3WloyZ2UrcnBRd0ZIZzBlVkRlWEs2WDZVcVZu?=
 =?utf-8?B?NUQ3SE8wdXE1QVptTFhqWlZFZ2YvUVpOYXN4bWN2MUFVY21jYkJyNXNodlU0?=
 =?utf-8?B?NklDaVJpU0VIYyswNk0vV2dscXF2b25wOXJtZVFsK1ZycVBBRmRMdi93WUhj?=
 =?utf-8?B?ZVhHc2xKRThML2ZWOHpxSTVnMW5oWXpVdTR2aGJ3VE1FdXAxZWxyWWFSK3Z4?=
 =?utf-8?B?azkrMENSZnNCWmlTZnEzSzMrYUM3RTZDT3U3MkpjMjVwZTg4bzFJK2RFWjJ2?=
 =?utf-8?B?TW1leVV1NTBJbFI4eThaeXRwemlPcExWbFgrTldDQWQ4V0R0ZTJZRnN5L0h4?=
 =?utf-8?B?eFdMK1JIVUVtbEgzdlI1aGhXUHhnejREQzNXcy8wVVI1K0tCZzQraDd4SnZm?=
 =?utf-8?B?Ym1nbzc0bUwwVVJIMlRUWGRVa0VZaTNxa2FpWGNpekNVVzdVemJpRkd6ZC8y?=
 =?utf-8?B?dWJCaC9oM2lXQnNGV1dsUnE5c3NnekhHZHR5dEtLd0FyZm9EQzhWWUFJbXJD?=
 =?utf-8?B?RklzVlphMEFDRDhRVGhXTW8xSnZHKzE5UEkrNjFUOHRBMWtmLzlQTjNtc1Jz?=
 =?utf-8?B?aEpkeGlXM0tMa0FIVms4dmRVeWZBL3E5Q3FzNjliOEp5QVlIeEZsaDV0ZXJF?=
 =?utf-8?B?M09CQjAvR2VXMnJCYTdIOW1GUFJST0FnMm9hSkJYMFFBTEVYU3NvNGVCaktX?=
 =?utf-8?B?cnVOZ2Eva3NQK0pCeEZvQ0hCMjNsM1ByakRXNXRidHpNTTJnVjBpaml2cU9O?=
 =?utf-8?B?b0hTYkdZanpYTGtUSm8yd2laV3JkOG9Xazd5THYrdlIrd2JsMFFUaDFvejNL?=
 =?utf-8?B?SGxoSGNiQmNFaVR4aGRDdFVONkdaWmh0LzlaQ0pzTXhudGpnRmsxNkw3VG5h?=
 =?utf-8?B?bGxqbDd0cmlqbXZ5SmZpMkowaXNZKzNPUXJYYjFtL1E2RW03RGdXRDNXNWox?=
 =?utf-8?B?bnJ1YnBaSjVyMmpJS2dVSjdabVE5R2J4VkhudEcvSDZXdFpNekg1eVltMFFi?=
 =?utf-8?B?eVFpa2E3ektDNFF5MENuVTJKc1FEdTM0QjBQUTBVcllsTG54dnpwTmlYWXMz?=
 =?utf-8?B?VU1KM1hGS2JYOE9vckpNZ0g1ZHBERjhpNWxmN0xEWEpqcU1ZWWZXd1lrRUV0?=
 =?utf-8?B?SHk2Ky9wMHFOb0RrLzRMM2Jxbmp3Q09BOW1PT2crME1rZEx4TTNvdXAwN2Jy?=
 =?utf-8?B?MkpXQ21lUVY5TGNJQTQ0L1RHaDl5T3Y0RDR0dEt0ckpJdE9MVGMybzlNNjJm?=
 =?utf-8?B?S1RYN1h0MEtXVERjbnBKQlQrSkU2eDJLTCsyZmgzcmZxSUhmRk8vUk5FRTBz?=
 =?utf-8?B?bDhkTFZOMFl3R01KZjdpcFhxV0lubHVxQ0pVaVdGYmd1WmpxazRwVWswN0N4?=
 =?utf-8?B?ZXJDaGNtNllub1FIbzRtWVllb0tSamRmNG9ldUw1cE51Z2pQaDRxZXZaTVB0?=
 =?utf-8?B?M1lIbmxFQjMxT2xlekYvUWVoOWZzQmxMTm5WRWEyVGNqc0JwTHRSa05FMjgw?=
 =?utf-8?B?bnZqWFUyN0VHSENLemg3QWM4VExnV3JOUEsxZS9kTVlvUWVGc045UT09?=
X-Exchange-RoutingPolicyChecked: kBdXDxufm0aCUIaSqGjRlhuilE3oX672OR9ZG5OSBfMLCjDjBXwvndykIfU7SGKT3zE8b8vF3kz/6gfytDMtty9dW956Snp2UR7x/asLfjUg6AgwXQi5pfw1Kn5MdeIMr+yFo3uwKgpLJINwU6uRJFoIowgyg+Ygiy0UBY+hsqDSz183g0+dD8XtuxVEnjU6VI0Myv4KLq5hj8p/8n7b3RxvoDV2XrfLJ/ZgAErBU7Bss5Ny+I0tPNods/pDxAndn6gMiWPq2H2y3x+K8m+tk9az//3eRp2UzJKxEFmn8aMG8VFc8BSny2MygImH1TFtmxzKWyBxiif7GE65RuS8yw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3372df88-9cf8-4643-5103-08df1d100de3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 03:24:50.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vj0GQB7PTdnL4SFliGhrAVNmJ57t/3Lwsoefeiim6PwFJsFz5z5iWQzIyVCgIEya/bCkf4o1uGmmnPKDPknsCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PPFE96DC1E67
X-OriginatorOrg: intel.com

On 9/25/26 9:03 AM, Serge Hallyn (AMD) wrote:
> On Mon, Aug 31, 2026 at 10:13:00AM +0300, Tony Lindgren wrote:
> ...
> 
> is there any pubically available qemu git branch or patchset to show
> how you currently are driving this?
> 
Hi Serge,

Nothing public yet. Our QEMU code is throwaway scaffolding for exercising the
ioctls. We're working on something more suitable to post as an RFC.

