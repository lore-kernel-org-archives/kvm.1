Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793142980;
	b=CFQ6pJblkN0s2AcpxF1iaGNL7DEejJD9AE89087udyDc7NQGVNHCXNsXUcCP9Twh8wBr
	 6cLjfvukMUUUty2iGvKQE8JnFz6bLsP9jfF9IMXFuhRnZ/zLhOBpBRUzxCg68v6iZWqnI
	 Tc7Vz1QgUco5XQsDvwHkdjA7SRqqhZyRx4dfv35NUI9gHsl4EUYBSIRqFev8yH7o36kJI
	 kd50S9MJbw+O5M/F0TXSXuPoayIGG47CO7AMzgLwV3q+kgfac7D+nl1Kk5ivS3fjA44yF
	 gIincxaUdjjtMvA0AjZiyyxtFqdzbxNPKQ6urtCJosaq3tN5lMhNFD2z8HgkSK6p/bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142980;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:CC:References:From:In-Reply-To:Content-Type:
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
	bh=IM4JYP/eLEWRPR7tEh3lLmFvIrJ1kOhSdkJ2pG2HVoE=;
	b=VkTpazWVTw/VegebsUOS4U1DmKUXIW0VRMPDvwBGYelBEm1feyq9Dt5zpw3mlNBuWFT+
	 +U+l/b3y6AoM50QSJ+p4r6yvrx7jSWxjZI4KxddtuouKJvtSyUSdtIMbMXuTZ5Tvma0u+
	 8daKMD4TbCzPi7/xc0mFZ5NmskQc+eDtDy5glydG1hzwaJaVSojpbI5MM5ZXahqS/JV6D
	 n9H5T+x992sxsEaYTLVe+fkFzUEFoVhYVcM8Ed9ujAmXqqT6Xp9oslbK4YZITbC+Kyrt1
	 C4KRpN5SWs2R7u4EUSHrnAG8unvNRZYwIk9M9m4MyInCsOBCPCqXp3kEcfwYGQVVcOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E7dOKdFM;
	arc=fail smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B6B60A2606
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 23:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61B6B60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E7dOKdFM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793142979; x=1824678979;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/2HeNr/eST6af/vM3wHZgceEkqyTkpNxQP1jI6GenPQ=;
  b=E7dOKdFMPU6IOOv/YKJC8upglx0APlaPPr/6TDdybQgO7OIQWtw3/Bx9
   vL8vbu7ZD+ODY7Ms6YWuZ1ePnrP7RALVhJVg+3puszCifwWIn5tQgAyuy
   jkhkhyeiPsWp+9dpmuTBR0lHMLS+mDCvsvd0Qzq1izxZEHzyoh3Aa1nxb
   JSJ1aFdzqCKqB9Cbzl6LYs0ut1TOFA4XUdPqtpCW4aNisa7GkC1jBsJ99
   1bsC+Gzhqw/xEqTNXzZwDQIG7FaZ70+NJCXWxouoJbwumsRFQgWI96mmZ
   QaIpgk4/PjVcH7iGEl1cCm+wPajLvR9ulxl26Y8Si8Ex7XESU+Ml5/aUr
   g==;
X-CSE-ConnectionGUID: ycNCLA7WRrWpG5XKVlfFsQ==
X-CSE-MsgGUID: 6TZsIrKCQ+6E5Q7n+zIpDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1758525"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1758525"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 16:16:17 -0700
X-CSE-ConnectionGUID: /PfIdsLRRgGQQPsG97u0dg==
X-CSE-MsgGUID: 54XIKXA8Q/2op2DPtDccog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4684397"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 16:16:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 16:16:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 16:16:16 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 16:16:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjAbq49AkyAgkG+kdd+msjlOc+R1EnXVlWv0kXw399Nhv/m2Wr2fiW7o9XxlnjMbij4ltyZTmCQB2r3YiwJH4XbSoze7UQ18jnO4ENw3Sb5A1kE8LTwyS9XuFA9jXhp7a/rbASzEwMh88qH9rm8ZZR3Ow6rdT27kZHCml8fpMqbie/g0rKorpWPaTvhV48y4FPHwTgxakHridfnvACnpnL2L/D9E3MnZGDLYj2NOmx55LVCH5IR9KwKAohlrvoM/164Ax+NZkl4JmPiF6sulOjGZZ/PzCG86P2Xp4f5xqUBVHu8Ch/9OSvlQ1D6VgyYacZoIWheBS41DvJPLAEqK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IM4JYP/eLEWRPR7tEh3lLmFvIrJ1kOhSdkJ2pG2HVoE=;
 b=Nx2R40F80D8nDCfZxFaBfyrRjYZKh2wXMjwJeO24W6Seuz/ikckj9p3F7K4wZRtvWuCte50YQvD+R9xQCUzF9Ym+3hoDPD2u6TzMah3P0g2fKzD2wQ7OwfM9JfYTMIj24xz36Vp0uzjLHv/2JUlIvxf8x2l5tJsgDjsni6UkmLftP2BdfgxDjB883lF3M0G1NfihGBQ8fHxS9TSLJoEvMdsuMJvWg5yvakbavDEL8fmkzrpKCesbyTfRRWzS0HRUskZtLF7DKyM4iGMTQnyZLYVbo2fSgxi0a0pRGk4YF4g3Ersj1FgdL6rmICprT2mSZ5cHMz24TW55h2QjVWcKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:16:14 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 23:16:14 +0000
Message-ID: <0fdaaf2d-2113-48e9-81d7-4afa6bd522ba@intel.com>
Date: Tue, 27 Oct 2026 16:16:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/28] x86/cea: Use array indexing to simplify
 exception stack access
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-6-sohil.mehta@intel.com>
 <20260911215759.6C04F1F000FF@smtp.kernel.org>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260911215759.6C04F1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To CY8PR11MB7846.namprd11.prod.outlook.com
 (2603:10b6:930:79::14)
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|CY5PR11MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: c483894a-ccdd-4e3e-f3d8-08df34804bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|5023799004|4143699003|11063799006|56012099006|261009223027099003|261022075727099003|261021121427099003|261026121527099003|22082099003|6133799003|18002099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: Ot+Zy7Pim7yXfbn6n1wzCciEacUDQMXrNHWaE/SZzgfqKXuBiSlWSt4e+s9P+ZQXK3JQUhks+hgYrKZBRSLnIH95omDgncC3JH/tVOnuMW/Ul0sxAp7JdrJ0tqB5sTLULXFd41AmhdtqGTSyVeARbiuX4T/nG0CWQILIOLW4IWh+yxS0/xWFnRAhPBgrto3mTyGDjWYH5YF0nQ/D3glAGWsPxmexLE4zyKeW83fTXy02udhmZRxI1obTRihURaReFcEBISYSls32YmawoNnNdK070zVtlH4tgnZ4K6yPNK3zkysgIRgKt3aCCVyR2Xevpz3pidKmfdhkr642xSr5lyU57Fm+dtvoR1MBztGd7bEzVzWt52rW1RGqstHDonZwJ/Q2j9BCXE7h68jWDLxWawiFD0wV+IFUWB1hSbp+LFX6s4uVK2bGodeyBNyRmKW5aPZBGIYsUtsOO5QDmzG8Uz+vzwqGIqJsIRb5/3+Ejc1wGnfLOadLExndT61YjuzimTitRW1sF9pHmGxZmqf/djToqdH0BXXz2mjhtZ2wntuF3zcx/RxYc7gIZFZ1I2VgA4ABifBUXA+U3rIp8Vd5ivjzhK3q7V+gf5AMMVMjaRM4cCaB/7+OzDr23b520XLi1+YF6Ufz7WTFOqn4K5psHacDrjeTJHWuUJk3wvLjzlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(5023799004)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261021121427099003)(261026121527099003)(22082099003)(6133799003)(18002099003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW1QejFYNmRiV2Vpa3VZMDc3V0h5TGsySitMMDNGVks2dStnMXpEb3pxYlA4?=
 =?utf-8?B?RnZtRlB2Z3l6dzBhaEdFT2Z4TWtESk5yWDJmUTArM0MxTkxNRTQrYW53SWdX?=
 =?utf-8?B?MXZZYWRlL0cyWndoYjVyK2lwOFVUbmF5MzI2SC84cU1vYU9Pa1UzTWlnaTlv?=
 =?utf-8?B?dkpmZ3BhcExrcVZBUjQ1bHVtdENHNnNUQWl3TGQ4aWZIckRFeVdnYmYrT0NC?=
 =?utf-8?B?QjhCSGwvNnMvTE9hVnIvOU4xdU5OVkVvU3d6YUJ5T25rcTA1OFZoOHRyaWxC?=
 =?utf-8?B?RTNiVmsvU2JPYXNSZlNqQjNic1dRa0VmTTI4TWtoVytJMU5NS1VGUk9jUEpz?=
 =?utf-8?B?V0ZFTjRkNTNuSTA5aGNNSzJtRE9VeVpYcXN5QmphZks0ZUZhNFFVcDhUbUJF?=
 =?utf-8?B?Y2JDdHhqYW9tbGRQaGo2aFpMVldLaC9sNE5iMHA1dzh1Y3BmQ0dnL0tyRzlS?=
 =?utf-8?B?OVd3b1g3NUx6WkxpdjdNMnpnK1BXRk1FZG15T1RqWFZqM2FIc3E2UHp1TWdo?=
 =?utf-8?B?ZkJNMXFhalVGeW1Ld0Q5cFBkYmJlb2hLNWFVVEJIeXVlVzBidys2UmNRaDh1?=
 =?utf-8?B?bWh3WVpiUXhLZThabml3RzRqTGVFd0pobjZQNEt5cklndXdyYm1JTHJqMGk4?=
 =?utf-8?B?UjhWUnhpblJNTWpOdmJheEx6VUN0SmZvOWg1VWhIV2dyQXRRZzdTMUVKZWp0?=
 =?utf-8?B?SjYwd3FXZEZYMStKTDdhaW1KVzZxTXpMaHE0TlZUUUU1YU9XclJMdThqT215?=
 =?utf-8?B?Ty92Q1lWUmZza3J6YjYwREJpRXE1eVR4TURNYzBBVlVTeVNxZFRjRDYrOXg0?=
 =?utf-8?B?Y0REQnV5NU56ZzNXREpVL3N5b1RhdmFCU0JLZGF1Ti9UYXpJWEE1S2tON0h2?=
 =?utf-8?B?R09wZWtPWmFHSWJPWDNYTTRHWmsxR2ZKRzlZUU5tSllZdjI5ajF4SFcrbUda?=
 =?utf-8?B?NVZyZ2ZpUU10OU1IN0h5SmM2MUg0Z2lqU3RNeTJOdmFxOTBTQTJYRldMcGlB?=
 =?utf-8?B?VnhrMkFrdlJBa2xsQUtjYjA5encrR0xMYXRHemszWGlwSG1LY05US0U5RUJU?=
 =?utf-8?B?NVlwMGZYbHA1QnNDQk1FVi9YMnNoaE92YVpKUkN0Z3VDTk5xV20zSGx2MHRs?=
 =?utf-8?B?VmtuQTc4VlVTOUt6SUl5YjVMakYwQVQwZVhMRGQ0UWVFMXNJSGMybktpa3lm?=
 =?utf-8?B?QU16OVgreDQxdjNJbXJsQVlSQS9pbjZQOWJiSjNlTnhDUXBqa29vU1I1aGl3?=
 =?utf-8?B?T1NyeitRa2JKZWJ6TStQdEsrUzgvYVQyeEFpc0I3aHJCK0tvb3BaSFlIc2hJ?=
 =?utf-8?B?cGxsbnlWWUI5YXRWWGxJVWNGUTdJbHFnZEJEbk1ZbER4RE5pTG8wMFA0M2lI?=
 =?utf-8?B?Umg3MUNJalI0cGRBcGo0c0R5YkhkRjQ1bDJ5RVJ6ckZSK0dSRS9rWHBER1FG?=
 =?utf-8?B?dXdHT0pmMjFMaHhDQTduUi80VDJHOEdtaDAxN2pNcVRNTXhEcXE3MnpJRTlC?=
 =?utf-8?B?NmVvcURwSlVsSWJIdElqZzl3Q2NsNUxJWkR4SXFEUTAzVDhlL1hUaWFadm9x?=
 =?utf-8?B?TGcraUVwbWd2NXRQeVJrWWZUTXJlK1BuNy96QXBQRlFMU1lqN0E4VndYaVBz?=
 =?utf-8?B?VzNJNzMyN1pZNVdzNVR1RExNVWlqWTlxa1Q5OHg0clNaZVBUSmpKckNpekZl?=
 =?utf-8?B?akl4ZUhSTGErTDRxdzl2b0NSRXJUa2hxK3FTSEJ1ZXFmVU1BZEFrRXYwbXk0?=
 =?utf-8?B?eWFrSEcvTUFJMDVUaUFtWHg5TlFNYlRyNDI0QnZ1bmxYUndhYitlb3BCekJP?=
 =?utf-8?B?ZGVtelpPTTAvSklKeFN5cUYyTHJISDkvQTQ4TFJwVjVFaG9HbkFiVldrVnNT?=
 =?utf-8?B?UVRpalR1T2oyRU5BRUZkeEl0MTFWS0dGc1BTMDUrT21VMzZLU3IvdUVtWklw?=
 =?utf-8?B?Z3o1WTlxd0VkWUdSbTROeXFWeWNLUi85TlFGUWJ1RUljbjhqR1hhN3NpZE1k?=
 =?utf-8?B?UElPQWJLeUY5VlRKcnBtM2RMeGdFUXhORzlpM0J1YnhKU3JHTnFsNXI0cTZW?=
 =?utf-8?B?ZitEbWhtTWllSEhhakR3d2tWMlhRaElqVktLNyt0dTQ5TjdCb3pIYmVhY1ZN?=
 =?utf-8?B?MUpVWkFoSDlPQWN6MitOMGU3NXBBQUhWYlVKQXpNeDE0UjBCT1NSV1M5TlhU?=
 =?utf-8?B?YlJmUlJHcmQvTWpxWkR5c1NJZ01kNnkvZlB1WTlHYVRtbXpRYS9lQ1dlanRn?=
 =?utf-8?B?Rmd2WDlJNVhyYnlTUFJzQUxOdnFZeHdON2pESEROT3RiYk1HdlNWMnYyQWVR?=
 =?utf-8?B?WXZDOCtGKzBIU0VKVFhyNUk4amFuTE1iRkwrOUV6VHgrZXAyNG1VUT09?=
X-Exchange-RoutingPolicyChecked: fHSrXgs4cdWpP7FraZxHcJ46AMde7dwTQdPgL3r6tulkZ+8Bbcqjbq7WB703EeyooW01KFrA2CK69truuxYIE3dMxWBwAAbwaz29j7pwx89WIIpk5RECpyzzWQoU1KdN1dFFC+N+chD6GfYEg+P1m4m1FpflbfsJYVqmed7gkjjWOoU4accJPKs8Gx40WsQqT1kxwSy4bGfocaLffnXdM4s+D8nWSjG0PxaOD59JioUFGJ6pEEGOGPjItY/7lQ6bZm0e8icycNMeVYVCMTjQRPtklhCFGiVFuxpQmR9qVU9j1UFRMRrYAx8eNGSihrs/TSNuxZjWM7i7Fdpxd19q5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: c483894a-ccdd-4e3e-f3d8-08df34804bba
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:16:14.2122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAH1iiRdN8WPybPAp1Rlc+PqFTQFSQ7TYbuAxbFzOJ82SJi2zbm6n52oGO/TZglZyw5nsbL2IGsOBTLjAsRDow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com

On 9/11/2026 2:57 PM, sashiko-bot@kernel.org wrote:

>> +/*
>> + * Typically invoked by entry code, so must be noinstr.
>> + */
>> +noinstr unsigned long __this_cpu_ist_bottom_va(enum exception_stack_ordering stack)
>> +{
>> +	struct cea_exception_stacks *s;
>> +
>> +	BUILD_BUG_ON(ESTACK_DF != 0);
>> +	BUG_ON(stack >= N_EXCEPTION_STACKS);
> 
> [Severity: Medium]
> Does moving these helpers from macros in the header to out-of-line functions
> introduce an unintended performance regression?
> 
> Because the functions are defined out-of-line in a different translation unit,
> the compiler cannot statically evaluate the BUG_ON(stack >= N_EXCEPTION_STACKS)
> bounds checks nor inline the pointer math.
> 
> This incurs a penalty of multiple function calls and dynamic checks in
> performance-sensitive #VC exception entry paths. For example, hot paths like
> is_vc2_stack() in arch/x86/coco/sev/vc-handle.c repeatedly call these functions,
> which are evaluated on every #VC exception:
> 
> arch/x86/coco/sev/vc-handle.c:is_vc2_stack() {
>     ...
>     return (sp >= __this_cpu_ist_bottom_va(ESTACK_VC2) &&
>             sp < __this_cpu_ist_top_va(ESTACK_VC2));
> }
> 
> Could this regression in a noinstr entry path be avoided by defining these
> helpers as static __always_inline in the header instead?
> 

The performance regression concern seems overblown to me. The #VC
handling has other heavy-handed things such as GHCB and VMGEXIT. The
extra cycles for __this_cpu_ist_bottom_va() and __this_cpu_ist_top_va()
shouldn't have any meaningful impact.

I am thinking of avoiding the __always_inline directive unless someone
has a strong reason/preference.

>> +
>> +	s = __this_cpu_read(cea_exception_stacks);
>> +
>> +	return (unsigned long)&s->event_stacks[stack].stack;
>> +}
> 

