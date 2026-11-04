Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793753137;
	b=kzEma2x4+NQDs9hgp2+RRKpkNL7OFIbMrrOyXeaCqFENfZnqFx8tQADaRN+HJmbCa1Jw
	 mOFdqj/12Xb0u049UenQut0HJ6ocoxoRBg+H9GxuMT/3igdGVW5vJRqvPqqlzYPbVA0Du
	 slpG/vTewiwggwPbQZEym10dcFXwqP42MKIeZ65FwozhSPKkOP9HjRVBpJHlrTnj6hQ2f
	 p5aCTo4OiKC3BV8afRNlCdCb85c07SH/1hep95T33/x7wlkQ8St174ofJC7oizunW8elH
	 Py0/ezugfcGYR0rPz8SRaNDHe8bpAZGQZemvyJgQ5GegsUcc/RMQFqJ4GTe24ADoH5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753137;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:From:Subject:To:
	 CC:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=Ykhx8G1EVJmwAUb+w/xHU8M90jBEHgo0mnvR7CIkDao=;
	b=vlx6xu/9JJBS4hodm/XjhYEUh6xwz4SU/fyHYhPlbsAHOE7Qp3IauMcPqgOYHh9bSTOk
	 sAS4Y5UJalzueV6CeeHnuLJ6LvfyHAiRX/9En6Ii1+0D938YBIi9UAQhUGmEZU03NK6Qc
	 mHtPuDg8Sc2PQLz7loGqhTtUh3xIksCIKezYrHNhG/QRO4Rg37OP+A+xfZpp3jj94zUKU
	 /s3AOG8FcGw/bd6+B1EBOtHjgnOvqo7xxccwiyAVj+waRkTe3OGe/Q+pBuxHowi1RetS/
	 d/bT8fNe4bQI+Nj6GcX0Dkrg3gLs/WmEuA9hIDh7oS0zffuRoX1f9KGXJjGRdJXjohA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lEpHhwP7;
	arc=fail smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C17606A31B;
	Wed,  4 Nov 2026 00:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79C17606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lEpHhwP7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793753135; x=1825289135;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/RcXGPXmkXUbeg3Va72ij99wdsDt/D5bwRUXbTWzbns=;
  b=lEpHhwP7oU9dgNYnVuThjmtYHgqEZ2xM82E3U2k4HTMexfWgvwHbjebD
   MiLXYWohpfnKf4NCM39jefK/krdwz4laQZN6JLdxs/m76DQhu1+jupnqZ
   +8RY+NAqA+XVdT/1QtLdMT/yVpRWtlX4Evf8nOe12eBiJ6dWZU2fv3Z3d
   AEVdKLqwBHz10PYzW4SGr+Z+A4kbXHnTylfXdBJGCxpmM5gNt48TJ/+sq
   KmDmd9gUbm0B9UOOhtKzOfGFwFZSRU0M0mvc0Mg2gIACOaYWRNVvz9zfU
   r9EXnuMHZJRCnP683Ihl8XHlpn5AtOPmtheQ5pgQTSFVuGTLwaHdAXTwI
   w==;
X-CSE-ConnectionGUID: PRGr60kCQZ+7UTZtYZhVAg==
X-CSE-MsgGUID: S6bVJL4nSoeLxGnRjFPUPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2385302"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2385302"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 16:45:34 -0800
X-CSE-ConnectionGUID: gB8usrTKQga3Hi89aZ+gMg==
X-CSE-MsgGUID: ea00RwfuS7+Sdnr45qIRVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6397012"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 16:45:34 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 16:45:34 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 16:45:34 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 16:45:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3zbPPJSwQztGC9spfrl80VpvdQ6/5fAUQbJmzinSUqNdEPHXjKw9F1H7Kko7ugEXJs05hOVK9ETxaGglQ4thKUBCbfEzha6iHO2qsi2ptsSIM6PFPvo/gncCSgNk6OcLKwmaIGvIp0AiYo8fR766xPiKtBAibtNCWT4lYBWvI4wORm/0xqHvYZfypcHSTXWa9XQYeZWrC3CnMiSH7LoP9TYOi4fC2QdoE4IjgneASDTNtEOCMJnMaHnMIpsA0Nm+GlrbZLazP1lsC/OxA2gQbBizbtV3C63mJyzrg6wU2cB9Lrk9tqTMMm3ebRtPx7Ub/JlqhKllwKW+fQCt9JW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ykhx8G1EVJmwAUb+w/xHU8M90jBEHgo0mnvR7CIkDao=;
 b=uaoI5uH6dz7N0X9GB4ifEkMxR5Z8MNQBS7jLAkc/LWrV474pOEvt71VcCTVnDlUG7r1/R9nRn8L9Lb8knUXXCTqfkHenzC5uQy4cJUWgeG64n0phNmybLEewYPvaRIUjoud4A75sXmuPKWbiLXiv+5UhugS2NavQLDcfLjZzzaj/Z6PIm1thrriFSj5IVXExs01p3+1769u2tllONWIRW7iwfuJl/Yj1U0N/P2eM/wXlbwivsoJ72Qmfs9MIcpyerWtzMXwuE1ab+L6DVTFVzanfiv9YsZLa8npPhGSDzSYKasblLa/mgh7+ohDmv/i+YHXaE0eMLtJ6qCVclctIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DS7PR11MB7692.namprd11.prod.outlook.com (2603:10b6:8:ef::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.12; Wed, 4 Nov 2026 00:45:25 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 00:45:25 +0000
Message-ID: <3c63be88-a0b4-4e59-a671-ca089f0b3cb8@intel.com>
Date: Tue, 3 Nov 2026 16:45:23 -0800
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v8 00/20] KVM: x86: Enable APX for guests
To: <pbonzini@redhat.com>, <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhao1.liu@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <a288d79b-5cba-4c9a-940f-984a0b7412ea@intel.com>
Content-Language: en-US
In-Reply-To: <a288d79b-5cba-4c9a-940f-984a0b7412ea@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0200.namprd05.prod.outlook.com
 (2603:10b6:a03:330::25) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DS7PR11MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: b84dfee3-2452-47a4-a4b0-08df3a0cea3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261026140227099003|4143699003|56012099006|11063799006|261028144727099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zNQ2jA5De22aCb+oVo/GBWTRmT+C0/SfHcmZwquLtGmDKr2UP9F09x8GT+WGEgzZpq2MRcRhwEQ8SZtjDEj7zKCmIeT1OTMGqUKqGPVGC+QpFzJU4jfdebybUJ1i6cA/+1WhDXWlJ0C3OEJSqd041ncjnx5Vv+hzcMStUrCwwIt34S3aA2DMQH1CEJc6FqEwUWHDCAQTSXkkuKRVuzDqBeXeu7KKAPzi+JCJ1Mz+O1fBziI/C0hZ4ZoClKPdapxJBVpKdOc9kD01oikdfRE+LI08FVYT50bVQ75xD5PBZ1LiAW97HqgqHMfP9MLV5KnqFJn2HJUk2pxcBlcK2kJQXglJ7IFMHWKa+klVdWVy1eIn/02BpP3LMaB0acq+nuZuQRHCKn0MVj18JyTAKMahsXjaGDkNRVhpQqu5Bpr05H0zg8iRxDmVSYcKiApbcvhkUaW5tUOIr7biEj1bcXmsR/R7bwHPVBa2O1Sujk+flUMWM9NC3khvxXRHRG6qPMhc0UzN4TYjD6cZB39FbH5VeXqUcGM1z4zIBz6c5ViPiZQXq9DAk/3dtFxAeyLQA7McdOhJpGhKUweBSKndBzycn+hfGHGQcKjay/e/98AT4oDPeM77NGZcj/AwgID12AOzxoiPzChrC39RuAaFOfEmHEgL9pAcHhQHflbdca3aF3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261026140227099003)(4143699003)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akhNdFArUDkrcjA5SFF2RDRIRTlFMlBVMkJYWXlYcGtvbmF3Zlh1TG1IcU5X?=
 =?utf-8?B?SGM5REJTVHBRTmd1TWZRTnM2L2VUY0NxRWI3U2w4alduZGtDWFlqa2xxSFlN?=
 =?utf-8?B?SStJVDhGTmhNSUFBOUY4QXBSdlJjc3BiZjAxMVg2ZExpZG43TzVyQldWZUJo?=
 =?utf-8?B?OVZIQ0xrajNSVCtlY3ZNOGxGTThUMUhVMHRLT3phSWpxdXhkeUZLekUyY0ti?=
 =?utf-8?B?OWMwM3RMdkkyOHZEQnVJZHJtTUJtZGZLUzJRQWdYVmVOY3FLMnpGMjhaKzZI?=
 =?utf-8?B?Vk5oTXhsZnJQMTB0ODQwMXE0YlNCVnNhSkFCdHBPVms0MFJmNGlyMUpPbklC?=
 =?utf-8?B?OGVYcmg0bUpnK0tteVR6dS84QWdYbnN6elN0VDB1UWdJYlFiTmNpZWt5TW96?=
 =?utf-8?B?MDg4Nm0vMjVyZmpFZktOU2tTK0Z6cXhYdVltbWZMQ1VER25XSjREZlV1Ymxp?=
 =?utf-8?B?QmJPOTc4dzgvSFVMY1kwdTJ6VGMzRnBsMkR5NVlaY0s0YXJLcmRhdExuUlNT?=
 =?utf-8?B?VC9UUmZOa1JHU09CazFQZXZpQm1qWEEraGd6d0ZNVHVnZFRHODFSczlRWUpT?=
 =?utf-8?B?b2pFeVVIalRoYWd4cGMySmE0cFBEYnMwRzkzMkdWblFGODZOTGRkRW5sT1R0?=
 =?utf-8?B?YlRwQWljMURNb2hPQmdHVksyOWxBdCtOSzN6cjVnUXo5dklaVWtiYU40Ynp6?=
 =?utf-8?B?VGVXcWIvdVY1NnVUUEFpYTlRRDR4SnE2U2dGamVDRXorR2xXRjl5Nll4WGFX?=
 =?utf-8?B?TnI3MFJOUnhSdWZUYUE5ZENmNWNxZElrb0tiVG9vZW1udUp3bmJqV29ITlN4?=
 =?utf-8?B?SUdXdkF6MWZ3V1ZXekdFd3B3RGIwVzU5SFQ4dHBxRlUrbmhOcmREZ0E2NDVC?=
 =?utf-8?B?T3hOZWQ0RTFkdnQ5UVUvVWdNMCt4M1dpbjhpTTJhdHBIRTYxVlNVd0NGeW12?=
 =?utf-8?B?VmtHelUwb3BBVUFaYnJqT2Q3OHZ4aVRaWE9GL3Y4WGd6MW1RVUZBYWRiNVZh?=
 =?utf-8?B?YTFOa0IzRmtQS1RNdVZqWjVEdGNqRm5UTGFHdzc3ZnNzeVFwOEd2TlBTQy9G?=
 =?utf-8?B?eDZ4UmxTVnd1c0E5OHlVMElOUGp3d2VxMXNkUmRPaDh0Ykg1K2ttckg3MzQx?=
 =?utf-8?B?TjZETGh1UEtLTzJNM09pNms0QStORndVUElnOWh1dnZET1J6MDZ4MmZiTGFD?=
 =?utf-8?B?SU5MdERZd1YyVy82RE5zZE9Fa2lQOUJNbG9scUE1UnNaazA5MmxKT2NmUjBp?=
 =?utf-8?B?OXJzN3dyUi9yREhtVDU2b0hwNWIrMm4vM0xUWFNHb2tqeDJiV0V1dWlFMTY4?=
 =?utf-8?B?eUUwRjNwR0FUSzVxcmtkQVd6dDNSQkJCN1hkQjI0Y1A4Y2lEYUtnemgyblB6?=
 =?utf-8?B?RUZZK2t4YTgxbXFTZU0zYzJwL1UrWHA2L3daVlpmVnhYUnI5Q2JURitIT0JL?=
 =?utf-8?B?a0ZQWnZhV1JWNUR3dFVNSGVKb210Vml1aHNQOGZvV3J6S2RKSm9CTjRYZkVY?=
 =?utf-8?B?a3pLQ2IrSFgvbEFNbmZVaENQVngrdW56RkdQN3pCMTBra01pQTQ0dUR0d3pV?=
 =?utf-8?B?MGNhb2lZUUhDYzhIYjRPMmVwS0t1SHBjc1BnTjlpekNpZGVYdGdiWEh0K1ZP?=
 =?utf-8?B?ZUpiaGkvaEg3eU40RjBkRUVqNnAvNUJLdkx5S01RZm5JSGc1M3JNQnZQT0lS?=
 =?utf-8?B?RnM3aEljMDJxRWZTVE9vWUZOYXpESWpEQVVGNFlNZUJPTTFKR3Y1Yjk0YnZk?=
 =?utf-8?B?WWUzTXNGN1FTbFpRdjVJUktMNVVibFZLdVhoMFF0clp3Vy9Qa3BXZzBKQ1hz?=
 =?utf-8?B?UFYySVVTRXh3WmNZSFAwb1VQWUNzUW1meDk4OUcrNHk3RnZPVGtTSmRGZGgz?=
 =?utf-8?B?dnVuRzhRblJFWU9WUlJhd1lHeFRERlZGTlkxWDZKMWRRYng3VUlseThDR2NS?=
 =?utf-8?B?a1ZCVWlxYStyS0tuUkZPakZncU9BK3FmRnZ1TTRwR1QwaHZCS1liWk13VFQ1?=
 =?utf-8?B?MU9CbkxnRmE4WVM1ZnBDdE5yQitnQzdaTVJUcVlIN1FDYkU0UjBnZEFUTDd1?=
 =?utf-8?B?Qi9kekVLZTNjTCtDVjBCNXEzY3dLSjd3YXgyQnZLSjArYVZHQmZ2blZKNEJ0?=
 =?utf-8?B?MHBzMUhnOE1BNG9VZzlOdnpzbkl4VTgwUzlUK0p6UHdlUVBUWjVLZUFmTWVR?=
 =?utf-8?B?ZTNwY1BpVDJERUQ0aUtLeDVPblRiTi9EeHZLSGpQQXIxQWl5eWJGVGhYV1Iz?=
 =?utf-8?B?MTJ2TGxFTEgwQkpWS3lWRmUxVEdRdkVLaHJPT2VtS0xabk9qZTl6Q2Rwbm5s?=
 =?utf-8?B?ZG0wZHBQNU5RR1B4SC9jUVVKOXNZMUdHK3M5SlQzZzZBKzhUVFdOQT09?=
X-Exchange-RoutingPolicyChecked: HCOcby9lE2BAjXeL0bQUtGLC4XW28h706nXHSLXdYb/cqgt77qTqEytZe5HgWifKp+1V/N1jdEkKtHX3jcZ41yXdFIFyASVDIC/l6FnqFTQEq8zEjwTHSv9zR1QSuaOD3E9jXUMPjZbDN3R2blyXbWspA7ntTO1G2HGJfKgngVf02NV9oyFE+sCoRbSp14FUq/AxL6zYhCOY+D8BwOhMwk64K3P5bwFaFMl/oPNCLX/WGpsxrGFTwgriae7Qh2wSVUg6q+4lRLqhG4jTtKXqYhwMoVMWuVSpnzoevoswI7oGiVuCM6VatqefBztXBzRugKgTQEsI/v+YYHdnkSZGaw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b84dfee3-2452-47a4-a4b0-08df3a0cea3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 00:45:25.6370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrh+wSPTBTjslFoV3yqmpMa1abMer4vt36HYeIH2XPa7Qny8YvCLOeJCTV26A5s260f8SIwJyWcVq1drjqHiiobwwKbNRTFx6wBoPgX9LCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7692
X-OriginatorOrg: intel.com

On 10/1/2026 1:29 PM, Chang S. Bae wrote:
> On 9/30/2026 2:07 PM, Chang S. Bae wrote:
>>
>> I expect Sashiko to reply to a bunch of patches. I previously found some
>> false positives, so I will comment on them again in this posting.
> Okay, I've provided my comments there.

Just for the record, for anyone interested in this series:

   Paolo at the last PUCK meeting also mentioned that he had reviewed
   those comments and that we could move forward. So the next step is
   Sean's review and his take, as things like this need to go through the
   x86 KVM tree.

There are some minor conflicts in the VMX code on -rc1. While Sashiko is
a very useful tool, the comment here has been largely repeating since 
V5, so I would avoid another posting right now just not to repeat them 
again.

In the meantime, here is my rebase on top of 7.4-rc1:
   git://github.com/intel/apx.git apx-kvm_v8-for-7.4-rc1

Thanks,
Chang
