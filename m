Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA8416CE6;
	Tue,  9 Jun 2026 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781010426; cv=fail; b=gqEb91xrfQDvP8tCtB8wyk2Y2nyOhv7ICFDcwJFXy88E8MSn+WnHES23WqV7Wlf6FukyLcl2YU+G/8OqUF+L/Q8vjW/RAV2gfHLHzVSQEFOy8g3wXiYha5NOM/b/9GKqjILPmnPX0juSUMRVQzMrjWPm7xj6E7I9kRt7QxQ2VGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781010426; c=relaxed/simple;
	bh=G8FnVfbo6x42Go3Nn61ZoWOvEKOVVrm8d2WgMnGfhdE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VPqoSBAQJ2RhiqVFBViNHKZrKq+NK47KqiQyLTljKJwv1iQtD01caQOlsQKzYYdZ3k1f5tUikSB24RzcMe6JmDT6oGEMlcak9Nu3sDO4F25YflDZP6CHcN1tse9yWtHVznSVUfCvkLcYg9FxnEX/jq4Bp1/7Hg5M30MQ9CPu6YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CN/QGEm1; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CN/QGEm1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781010423; x=1812546423;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G8FnVfbo6x42Go3Nn61ZoWOvEKOVVrm8d2WgMnGfhdE=;
  b=CN/QGEm18jRECp3YyzOvh0X5dUpqRhuiJN9Kbg+BkqbEua0qi63YpCUd
   78/ZaGQ/TVA4ASDa3v7t74mYvHPMC3xIGJHAGiCDFfLgrZ2vnv8Qd0RDy
   bquY7iQe8lkmGMyLfqCMgSacsBXD5ugnPEicmQwZ2c99NvNtyYhWyh7oP
   dhEFn84Ghl4sBp7SArPBgRLcu/07r9F9TkiLnloAisvSrZWxC39riTPtj
   8NtAah0UHof1F3y7qimwSzekYB1Ma2typFQGep1rLmZefnc+RSrDOndHT
   lAT+uV0heiyeZZroQHtxiS7uRvYXjB7O6EKXpamV8lSBND2aJezYYjmI5
   Q==;
X-CSE-ConnectionGUID: phkmYYOHTG2KSJrIyWznFg==
X-CSE-MsgGUID: dUEJwLFVRX2Kxh72qlj+nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81775632"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81775632"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 06:07:02 -0700
X-CSE-ConnectionGUID: 3OlXI7s2TC+/xH2RJ4omNg==
X-CSE-MsgGUID: TbkO8+WbRI2a87Sv2rDE1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245956586"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 06:07:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 06:07:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 06:07:01 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 06:07:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhTpgefM65QOmTsg4e+4XuOLvWgRwEExALsH5lx0+WQkU00IMv+N/7V3EpYEWh38EeBSzXMpca44AOFMssWOzkSWsX5R+7UgWOeCjFTLrWnxRrVTMQvKNNabZND3KWZdzjiGSfqDkkbZ6FXKz90MWO1jZ1h0sI9ZfeiRj/d1fsB/yoPLua0Bxen+Fi9RD83qI9cnNR9Fn5baROhMBXb8vz8K4Kn/SpfZfiIYggnoPWJoPdCsEpYKfrRpbQ6ssJF8k1qK/KA2ecJoLyX6XkChGWXx7Gnnk4yCp8c6oBPHxUd6tHD/UgdOB+KwGR1IuKi2mnqvJMBBvwUB/C/gpuyeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6sjoQWZoZ10Ee0+Aly8ISg5NBESz7DbQQAoAnNjcl0=;
 b=uUz5NuyJE7mIKyFg+bTagCJttyuMrvGtHIUaZB4454IPKJE2rrp5ofSmYgN5pWoXoRKF1aY21xpWvalyPlSot1hrV1TRslrDj/MCzd696Xu8JxusEEyOGIvotZR06KJjaZhpkn9qVbH9hik6mpIBW9C2VxVNL1A6iu5GRMYlrjtWghOQIFlm2yTFehBeM38oUbapuR4fesSTnUpg/QAln5GkJv13ovXAwiLIhffQYnxIohf2GdW3Ng1GU/k/0dIsCT2RKbrN8hqfHAgDVKbtTix0QQooT/NL5jqLXih+b6Y2w4ABzZydq4JSoCPuQDtFU8uz92eORVSmdKvFtm8udw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA3PR11MB7609.namprd11.prod.outlook.com (2603:10b6:806:319::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Tue, 9 Jun
 2026 13:06:56 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 13:06:56 +0000
Message-ID: <1783e7bd-3759-41f7-93e3-2f9e21264bd4@intel.com>
Date: Tue, 9 Jun 2026 16:06:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <sohil.mehta@intel.com>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260522034128.3144354-2-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0016.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::24) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA3PR11MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: c321667a-667f-4414-3363-08dec627fb7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099006|11063799006|6133799003|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Zkh9iQWBSvMJHGk9PA7PG9iClV777QEc99OBGj1yegT5B2y5E0wGGOsktYii7uBwjsTaeBAskFuxRBrofsO2/a3b1H+ue7NAo9ruR+T/yZ3/IuqCEqCg5NcaImMQdZR6V1x9vAixGb3ODmbsyqfivov2A5Zt7lm/xlGLG91kcPfohe/IMpwWk/Tg4K1rrhqc1Ly/Y1So6H41N3C4n6f3FFP6eZlwWlJHz1BVPPUvbArs6EgjOVgJjnex7RtIX/XujThi4oHmbDZ6HlnvbnktdyI3H22PVtLvlZvRT1LQLOoLZe5WXrP3vqUS6kU40NEtfO4sVhGUvZLZNVKJRB182eoWbyCJbYNebVLT8K4ZA2bxH44bXyj1Xwkns7OhKfrLvrnCOECXTyN3J3UAIlDwzZtSGfg6f8YyrLcIhqqZNWaIcJtMSAmIhYYxVdLvAZjfYtrjtJZY/YcAHz2Dr09REh4KKtpUR2SMJrKJj5pMRyBB8ClQS2aQbULE+94xlorxvmqgxAmyefdaRCd43G5ucLy5ciCLxsBOSI1pTtngoKIypRYyQTjdOeq3xuycVhmlLDoyP1wwXfvmKsJnd7j9Ev3JMFGxL2ZSeQ7xuS2+9iaRBJSZ4aGHWvGt1NIQcmb6QNa+16xSreCfZ17KFOY+W2n77hM0p4UtipINSPGVDKODpSyPfax7hexba0Y0bNSC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(11063799006)(6133799003)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXpqb2hVaTZBOGl0VExodzJFekU1ZXlpRm5Pc1VxSndEMW9SdGtYTG1GNXJK?=
 =?utf-8?B?d0trM1QzalJLYmNidVNSN0ZKZksrSFlBWmJTWjZaaEh3UjZyZUpGRDJqSG9B?=
 =?utf-8?B?ZWJFMldSc1J3b1RCM05CRzZzYVA3ejJ6NTlRanFYSzJNcGd2MzN6eWd5cHN5?=
 =?utf-8?B?Z1VCTGVOM05QZGV6QzUzYzFRemdxaEFJenBJeHZrc0llZHhrakVKekJPc2NI?=
 =?utf-8?B?YkZ3cHJWU2psK05Oc0ZRdjRscGJDRUVZVjB6MkNoaExXVE45Z0ZaMDAzb3Q5?=
 =?utf-8?B?STd4akVCRGFuckI5N2RZR25lSEVqRDI4RkhSRTgyUVgxOHplZkgwSG9YcDhH?=
 =?utf-8?B?OUQwMjBGcWdFTDZZUzhnNzVINzVBZXdGdE9kcERDSkYwVS9WSVplNnpmMVZz?=
 =?utf-8?B?THZXZkVXWC9QSHMzMFRhM095WlNwSG1TOWppQzF5S3U4dnpoV0UvMHJNbG9H?=
 =?utf-8?B?eVFvcUhWU2RLOGdKNWVQVDhxUU9vTkZYdXB6RWs4N1pwSUd2R1R6TzV4T09T?=
 =?utf-8?B?M3F6dlhMaUs4UUJuV3JMU2k5SEhsVHBmMnJLWVdPdGhjbWR2VkQrQlFSL2Zo?=
 =?utf-8?B?R0kzdWcrYzhENlBHejIvdnlMbFN1blIxTFRwa0xWY01KOWhYSWptMERhS25v?=
 =?utf-8?B?WG5penp4YlgrcktnSkhkaXQ3Zmw5ZDJSTXJqc1pzSk5XTldPbXVKcGtlYVpw?=
 =?utf-8?B?dWg5MGwwV2U3Tm9ZbWVFWWhCek93cGN6NUFaZjhaSGV4cEEwV1dJb0VacmlU?=
 =?utf-8?B?L0R6dmNacUdvZ05EL0VwTXNBQjhZbHV6UzFBaUhCUDRYWDBrR3JUN0lZUVZp?=
 =?utf-8?B?VUxvNnZvT1ozQUw0TE9IL1RFTEx5WGo4TXd6WVBuaW1scEZtQjIwNFhaL01V?=
 =?utf-8?B?NU52NlF1eHFlVEFiMlgvcERmeG9yNXZNN2hkcFNGWVB4SSsveHYyajFFaTRT?=
 =?utf-8?B?VERVOWRKRlVjRllQditLK2dlVGZSem93dHVzQUVUZnRpd0pDQmswL0haNXNh?=
 =?utf-8?B?ZklHaHkxaWFReFdQNWsxa2xWT0NqWmNmcU4xSU1DMmR6WkE3UG5pMVdvc0tj?=
 =?utf-8?B?ZWxITGNQWFpXT3BpamNhUytGM29GUTNBVnVta1VIL0tQNkdQZGZkOXJrZkVs?=
 =?utf-8?B?MG9TTk1wMUtFWjg3aGVqekRwNDl5bGZtU3FMUkhYMHVSN01KWkZmRUtqRVRJ?=
 =?utf-8?B?SXRCa1VMblN6b1FBTit0ZXlacDVYVDZXa3JWb2EveDdrZXY0eTB6clNYS1BE?=
 =?utf-8?B?LzVNai9ETW0rTnhBNGQ4YzZld2lHbWhqMndzTE9ERjNlWnptcjhscllKZThH?=
 =?utf-8?B?U25aUzl4YjRaVElhZlRyZE5xV3lvMVpZTkhBUng2dDZPVlVhK1I2ak52b2RB?=
 =?utf-8?B?UllyRzQ4YjFNRUNvSDl1TDVYblcvNk9iZVJRaDNPMGRKRmk0UHFOK2tzQXJm?=
 =?utf-8?B?R25RajIrZUx4NzFibUxGL2w4SHFNdTRRWm16SnNBbE1rWE5EYUNiK3IvMU5t?=
 =?utf-8?B?RG90elBzdHB1dTc3cWdtSlREcU5VTUdUazVEL3ByTVRMZ0hINDdmSGR2RUVa?=
 =?utf-8?B?MXNQRThHbEVBeVF3M3hKR2I0VXBCTDhjc1BIazRmazBHN0VxREhpOEM0Mk5C?=
 =?utf-8?B?c2xkRTNndml3Vk5nSzJCUGV3aVI2Z0Q4dElQaER5aFgrQUk1TEFJditZK0I1?=
 =?utf-8?B?aUJsdTRmZlE5VkUwYjlNOFVzV2pFdU9vbk4zbUJFeEZ6VmRYOE5oMk1BTm1m?=
 =?utf-8?B?OVM1dy9OWlNiWFoyNXFsN1BmZW5jSmdrU2pwM1AyOUVFVkpqazZFeGNEQW03?=
 =?utf-8?B?aFhGN2prOThSc09Uc2dEd0lYZ2VmTXI3eTdaV1hsVUo0d0l4c0NSbTZDUllp?=
 =?utf-8?B?UU9PNk1jWGo2TXZ3dDR6WklscndKcnFvVnZVRG9GS3M3U1I4VkxzaUJjRXJw?=
 =?utf-8?B?WmhZNkgyclAySDIvdkgzVHFMOGhJM3grSldjZ2lYU01IMXNmK2dpbDEvVjdP?=
 =?utf-8?B?Y2Zzekd1d3NOazdLYXh4VGlSM3B0cTJEbWttNmt5STlVeVFqbnZBZHRNamd6?=
 =?utf-8?B?ZWNVQlM3M09ldjFDSXlha1VBZkphSDZqVS9RU0EwN04rcVN5T3BJejhmUTM3?=
 =?utf-8?B?bHYwV1BMcXVkL1NsWjcwYU1JM1RjcCtmYzZNVkFxY1AyYmhlY2pjVmdEK1NQ?=
 =?utf-8?B?N0V1ZERyOTlvUEoxSnRFd2pkSFVnaTBodkNTWXJSbU10cmQ0ZzEwM0Q5c1Zq?=
 =?utf-8?B?VG9xeVozUXRNbWFZQjB1OTNrdG4zWlJKcWVQSGREMjJhRS82ZzBlMHgyN2w5?=
 =?utf-8?B?TGxsZFU5MDZzb05uRTNTeS9seVNrN25MUWd5MHgrYW9RNDd6L21zQzl4Nmly?=
 =?utf-8?Q?eqwcJpgAeHi7lWLU=3D?=
X-Exchange-RoutingPolicyChecked: nUhRD3x3tb8atoeXstukt3SiXp5X8ZgMtgSRRWddDZplHG4NlMPP6+ZuVwRQVjCi5YnbCjZWthhp9iarbomE5M4hm3/48OR1UuZ/fvwNldrRciu3ETTegzw29IMXFzEx6KV3DiOOrI7K1zH89h5CLaX7eJfuOON9LH64NWOVVo1QAXZUVcZKaMOu41wjVYzDIC97eR2dQMraY88Gf468LmsQO9QOk+4XsFZJfBbYVqCHH+pIdxNiyNukLKvHECoc60G7anolW9F1mopnfiAfcbF4O5Aul6fNdoPktUOfarqP3qnrTCvD5rmrHKUZV41XzikeHf1rGzCoHPH4nSJRwA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c321667a-667f-4414-3363-08dec627fb7e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 13:06:56.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwCXDnNfmdSUeX1QPtNC4aa9Yxp2bVMDn1dk4JzoAwHOxUPz2vfcSF9zpXgr/GzkC+T9YKgEKEyoGS4T2ylYFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7609
X-OriginatorOrg: intel.com

On 22/05/2026 06:41, Xu Yilun wrote:
> Add reading of the global metadata for TDX Module Extensions.

For tip, isn't the expectation to explain the context first.  The
very first patch, might be a good place to explain a bit about
TDX Module Extensions in general.

> 
> TDX Module Extensions is an add-on feature enumerated by TDX_FEATURES0.
> But for the Module's integrity, Linux requires that all features that a
> Module advertises must have a complete, valid set of metadata, and the
> validation must succeed at core TDX initialization time.
> 
> Check TDX_FEATURES0 before reading these metadata. If a feature is
> advertised, a failure in reading associated metadata causes the entire
> TDX initialization to fail, otherwise skip.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  arch/x86/include/asm/tdx_global_metadata.h  |  6 ++++++
>  arch/x86/virt/vmx/tdx/tdx.h                 |  1 +
>  arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 16 ++++++++++++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
> index 40689c8dc67e..533afe50a3f1 100644
> --- a/arch/x86/include/asm/tdx_global_metadata.h
> +++ b/arch/x86/include/asm/tdx_global_metadata.h
> @@ -40,12 +40,18 @@ struct tdx_sys_info_td_conf {
>  	u64 cpuid_config_values[128][2];
>  };
>  
> +struct tdx_sys_info_ext {
> +	u16 memory_pool_required_pages;
> +	u8 ext_required;
> +};
> +
>  struct tdx_sys_info {
>  	struct tdx_sys_info_version version;
>  	struct tdx_sys_info_features features;
>  	struct tdx_sys_info_tdmr tdmr;
>  	struct tdx_sys_info_td_ctrl td_ctrl;
>  	struct tdx_sys_info_td_conf td_conf;
> +	struct tdx_sys_info_ext ext;
>  };
>  
>  #endif
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index e2cf2dd48755..a5eec8e3cc71 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -87,6 +87,7 @@ struct tdmr_info {
>  
>  /* Bit definitions of TDX_FEATURES0 metadata field */
>  #define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
> +#define TDX_FEATURES0_EXT		BIT_ULL(39)
>  
>  /*
>   * Do not put any hardware-defined TDX structure representations below
> diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> index c7db393a9cfb..3d3b56ef3d2f 100644
> --- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> +++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> @@ -100,6 +100,19 @@ static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_
>  	return ret;
>  }
>  
> +static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
> +{
> +	int ret = 0;
> +	u64 val;
> +
> +	if (!ret && !(ret = read_sys_metadata_field(0x3100000100000000, &val)))
> +		sysinfo_ext->memory_pool_required_pages = val;
> +	if (!ret && !(ret = read_sys_metadata_field(0x3100000000000001, &val)))
> +		sysinfo_ext->ext_required = val;
> +
> +	return ret;
> +}
> +
>  static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>  {
>  	int ret = 0;
> @@ -116,5 +129,8 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>  	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
>  	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
>  
> +	if (sysinfo->features.tdx_features0 & TDX_FEATURES0_EXT)
> +		ret = ret ?: get_tdx_sys_info_ext(&sysinfo->ext);
> +
>  	return ret;
>  }

