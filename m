Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792532870;
	b=qKQI1Na+YuJLH1HEp+1MrEp76n8IA9BnaV27xiNAdW3xC2A9cFt1jP7UPwgyQ1E48E05
	 /5J4yUklHUCMEZPhUBQk30hpeNUcR6jRZ+mTnE+ECtnlPGVGNsfwThGy9QIP4H7WIu6r4
	 ue/y9Ncf0+O9TYc9TwBx171L3JkgaDPxdtAUXRfYBIgahoMrWr+JXZFzkZmiAwh1t4/Go
	 FZQsYESPdXR/YGanWzEGJhhRRpn0lN750eMoEGiebtHyGV0LxMYayvC2LuUrDT0WHeOWu
	 p5of+sczuqiA1qSMJXvzaT5vlmQZ86xnmJRRDM31me4YBaltjKzX+iA4o5h3K/GH+mA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532870;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=7gVQJuU4OhK7Prf9Ks9bvdgELbpJskae+zTrVYKXvxs=;
	b=V7yXAjudtVdBv3ITAKXNE6sfDNwCOMnN4SswzWK+gDZ+s0lktSZ3YG6j+PnQg/09srLw
	 z7xmEJ7i3uZO03KBDlv8ifJbOY4yZ3NBqp876kvdwxSLcUcYMVPC9u38dCXRK9ekQMNp+
	 gHsP/bj3y33RhpeJ6fnWCM9ZB9/S9E6RiDeJv2los5mr5UD23Fz206yHOdMk/NgJjbwpV
	 USkp3M1+x0TMExls6cdA5xFLmQ3qlMTk+AqQTqfj3rRk6szfRrZ0WmRawvZ+etuYf6spt
	 mMfaMc6yKLk50GrcDlgbDCIH2Z4EQZMwQnwou9xLN1asVoVmJSkZFyOqYquS62gHwZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SHHp767e;
	arc=fail smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7800B606A324;
	Tue, 20 Oct 2026 21:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7800B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SHHp767e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792532868; x=1824068868;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OC/UJ9KxmUGCYf6AR561ugpmoXFvQsU6SNNbar84uLY=;
  b=SHHp767eZPI49v6fziv3lPo2uSLkN1uV4bIheUWH3Oh0CwBHNANVu+aO
   CLYJbhvql6Qfnwh0YsqWAwj+shf3vxnKbLnqSdNHP2Zy++ffgXxWCltOr
   +Laf0lYGjtjZiYtOYr1NkgFJT7Rty70NYSz8SqpKsUQqgrv8eTEsz6y7G
   asrqEVvrkYKpTyX5u1D1NPw1/lbM8cyIqwHh11U3nZJPl9qTmkkQw3t90
   FXUI5D+0Ftf2Mp1g3PBG6I6w9DursuH563VKLRuQ9s9W39jfktYBvof3y
   H5eHu01WDnnNGL2AQpV3vvVRkQgKyerCI2a77vWMqsNAnU0qJALEzCyvm
   Q==;
X-CSE-ConnectionGUID: /NCkn7CKSnq7/Cz6tDoTtg==
X-CSE-MsgGUID: r1MQhJKITsKgvtf14hOFdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1239443"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1239443"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 14:47:47 -0700
X-CSE-ConnectionGUID: eNdzEhPTRvCztEIZJo6VaA==
X-CSE-MsgGUID: rhC+Cvr2Tk+a4bSuj58O7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3380971"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 14:47:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 14:47:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 14:47:46 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 14:47:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oikdZGKtDx/AMgyCbQ2c3mF715d0i3qS+Rzo+tW0af7EOSyScQCg4OyO6C4zGW7k+sinHVfLzVEL2qevHqqEJIy/+3q3AF8FsNzhsx7qoNTGl5Ahd4E79eSdslirVek9D4ZPGu1q8KJ7voif43FrFWx2Ho2yqMRYxr518mseYQeIf5FJW6lMCK5iP9CAVVB2yTHVyOxlvlcWwarvA1ub+W7AEErhTlN/kalQADSZ7KgKYmzHAG/2KG0Cwzu2upjuEYQUk/tyM1ZHRiWKEgrZ6DyrzBv/LW/eIKyY7HZcKJx95Duuia9NEVCZGcBCM0AjjAIw2d/y9bxxbMlwxnJYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gVQJuU4OhK7Prf9Ks9bvdgELbpJskae+zTrVYKXvxs=;
 b=yP3OOvBFG0LAkpsHMgPTx0h9sXnsVUcJhjKPBylSaifvKKUAB0svWbfkakz97Z21K67wszVgn1ol96+/2nmzl3luyQcfU/4ZCtrNeBFXG44lz2FVqncMAuAeBVevsSlFsWhPZENTY9F/dDgtOppqh5TJJOFpHWCM7Rw7weMkN65OvK+LpVYNldyBgZCRmc2Kgs3n5UyjXYc5hVSDax01b/12QM7aQQ6WIEeHMrvCdPtmTlm3CNDimnBdZxLRokGx77OjGn7GIbBNgbVbYcKHyhwgioEFaAguotWOVaI6AxK3QbWvuxiByUPQiRm4n7WN392aCOe+EMO+WfrM7tCpvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by CY5PR11MB6234.namprd11.prod.outlook.com (2603:10b6:930:25::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Tue, 20 Oct
 2026 21:47:41 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 21:47:41 +0000
Message-ID: <7f14a2b1-2d95-4606-9242-eba62afeb856@intel.com>
Date: Tue, 20 Oct 2026 14:47:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/18] x86/resctrl: Add PLZA configuration definitions
 and data structures
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
 <608876cedf5eece3f8b9297bcf21663a86a6380d.1790867441.git.babu.moger@amd.com>
 <bf4bd727-eac2-48ba-ad85-539a818524d6@intel.com>
 <c557ea83-11aa-4747-b305-93d554d3fbc4@amd.com>
 <dde507b4-6592-4450-80c6-41af64c1796b@intel.com>
 <ae45849d-8260-4a34-a860-51a309dafa29@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ae45849d-8260-4a34-a860-51a309dafa29@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:303:8e::27) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|CY5PR11MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b7401a-1302-4361-1441-08df2ef3c3c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: IFPX7f3YV04DoF55J9/KFRRWZZcxerPnWhkvZTNmPVavV0ORP5Cdm+gvl/GsHVs/Wy8eg8DGg4krQ36SV5y9E1rjQvZq0zdxUKXkDCOq8CbSAT4oMxfNvWI5NNlx+NYqY1ZFTmAfluXqS9QX8kVr5Lg92sWywduJYBE1wzC9Uy1UQLw49fPMu3KiA0KQELk46RIx7xntHFJ8rWydGjJKpOagqWztkjJUkThcLiMaLfDLOk/A0qY14pvn0eux7um07I/wCYIDqCnM99fn0e//Xt45YIkEhwEEGRANUCnWHEKsMb7cOuIkQSO+351T2STPPn5JHkIqg2t6OfnCSwNIb1bd4QfY1Pwa565YtXT6pUTgmH7gNcS3NsN4K3/TTbz3OMgartSY4uspw1fxnUeZh8mBhvwbnttziGVRPbQaAMdZ4td06LEqcACpzgkwVtggfOWlbr/wVOeIKHtlmsOq9uY4JQ4bcrZD+Bl1IO/MhNdTxQD2SY/g8Lc3ztDxpwycJVm85J7TqzOwqRb2JiSLn2yqvCn8ojY/ZxHis9nuLzSBwuKv/95bt8ooZBuRdOx0Ljcr+/+V9HuVCNy88v3Lsc08XkNCTeMFuuAam+bb447g0svivQTDiXlaw/Q7f73B/ABC6WJcPV37VVzza/OkkhIqUjITHZwiOGM3oLleC+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFllZUwxbVd5Y1JVTzlDWEZPOGtOWFQxS2YvdjRYRzF6Z2Fma2xrc2NWR0ZJ?=
 =?utf-8?B?WWNBMmsrREpOSEVoZ1BHWXZ5Tnl1bnNkTHNFNnBleXlBWU9YM2I3UnpWWjlV?=
 =?utf-8?B?RGV2M0ZROEFmVWtHbWRpWEpPT0NQVExMejd6eHJIOGNETWgxcThEczk3ZnZv?=
 =?utf-8?B?ci9uanpjSFkxTVBDV2s4TjR6M2RxaGhLSHJJVVNVZjR4Z0lSUWxwUDI2M1o3?=
 =?utf-8?B?UXh3RGlUd1NwRVRqWDI1ZjRuMWdsc2pzNlM0L2NVZzVJRGxVWWRWT25LcXZ0?=
 =?utf-8?B?Qko3dGJucyt2VnNIVkZYMllVNHhmdWg5SmlZbFNRdytTdVM2Z2w5cDJzeVlj?=
 =?utf-8?B?SVEvdmpzQmdNV1JIbWJOaDc4dTFBWVVuL2lQMlNNS1lEZ0RDZ05Yc2t3VktQ?=
 =?utf-8?B?MXJORlZFeS90NlRDUUcwTGFxblZOQTBzeTV2TTYvcSs1empBK3BZNlV3VWhs?=
 =?utf-8?B?dzlPTTdzNE9kOU1xRk50bnRETFlOUDhRa1VyWWlQcmRETXpOWTlNNVZ4bVBh?=
 =?utf-8?B?TFlNdmkzaHdpVnM5TkRBM3JyRGVydENVMXVDUkUrMzBReDZJOW9sR1JFV3dS?=
 =?utf-8?B?L3hVdjg3VlRFV3dpMDBJcWpYSEthbjdJNkE5ckdBVXFsbkRnRjhUcUJoN3BV?=
 =?utf-8?B?ay81LzNGakxRSzRGMUpHKzBTdmJvd2FobkxUZVhDVjZKZk1yWU9MSTJaTGNi?=
 =?utf-8?B?N25CU2lqWEVLZk9kVnpndE4rL2w5T2FrVzR6cG5paDVoTzZ2Y0VaMzkvdjV4?=
 =?utf-8?B?Rk0zTFpBTXRxMjhKanFPQ0NPeVdCTlc0S29hd2RWSXZBTVRkRDUzN2tsUndz?=
 =?utf-8?B?elg0L2REc1JVaTVVUE9DOFVSVFJYSEdCcHNWS2lvYSttc3RBL2tFalhSK3Nn?=
 =?utf-8?B?a0JCdktNcGpvSmVVemVGM0hYZFVHcXdHeHN3OEhrcG5xQUZvSFNXSU53MkMr?=
 =?utf-8?B?QmUxQzE5RWRzbWZydndvanFsTUpmSEV4Z0V3WnFBL240TmdWclpNYzE3b1N4?=
 =?utf-8?B?WEQ0Vy9DU25JamljUFBJRUhGNFdPSnBMeVBLZFRaMGRUMHlWdXBMWmx0Z0RS?=
 =?utf-8?B?L2g1MDB5Z0FaSXBiYWNmZXVvOStMSDN5TDh6RUlWbEFaUVZKVzA2Szc2RU1x?=
 =?utf-8?B?YkJHOFBJMEgvVWR3c21XOStXSnhQa0JDNTFNY2hsODlIZnNqeXNXQjZaTDlm?=
 =?utf-8?B?QmtiM3NZeUczYk12TnFER21ZNHFrY3AxM05qb0dMbnNqUU9VM1Z4YkVWYUtF?=
 =?utf-8?B?L21QR3RoZlh3NmV4R00xNVliMjlkdEY2UU9zS0ZVVjJVdnJyYmtXUjEvaHA3?=
 =?utf-8?B?Y2txUlJ1LzljdUl5aXZiMzVZMFFweGxjWE9hejE2VnJuUlVUbHl5ZTFGaWY2?=
 =?utf-8?B?U0VGbmROVWptQWVtUnFKenBvak9VOVFPbk9oSjA4Mjd2K2xwdFVwM1M4aWtU?=
 =?utf-8?B?YUVIVUV4SkZQRGNXZHpmdDM5VVgxSjZWOGhYTUZwZEFVZWhTcmhTODVwZFhz?=
 =?utf-8?B?a1NxM0pOYk1uQ0xiRDZmL2NzUHBWVm9BZFNsTElKY1QwQU1YZC9CMUQyTEhl?=
 =?utf-8?B?Umx5YUh3OWpnOFhCbVdlOG41Z01jK0Z4YWd6dGIzUWRlUXBObGs3b3hsaGUz?=
 =?utf-8?B?M0RxVGZiaXlmblpQcWxDVnA1WEdJeDc2M2V5S2RVT1lWZ0M1WlJxL3pJS3pK?=
 =?utf-8?B?TXFLWVozQlRTd0RFL2pJWVBqamw5Qy9Mb0xjREJ2SUlMTjhTOWEvRTNDQjhz?=
 =?utf-8?B?WEtYQkM5dGRadzNWcTVySytBcCtIMEVJT2NmMzQ4WUxLNlJMREVBNVkwbnor?=
 =?utf-8?B?QmdYT0R1cit0YVRNMEZvUTV2MTVyN043ZHp3NlYxZis3NVFtQ1BrMWVGd2pl?=
 =?utf-8?B?U2luckpiS2ZRL3FhWGVoMHo4YlFwaWlNZjFWbTFCbjZmbXphaHpCVjc5Q1hZ?=
 =?utf-8?B?d3VLbHphc3NvU282K1dHbjlUbksvcmUzd0d1amZYMG5UZVVndWMwOUtPK3d5?=
 =?utf-8?B?NXA3Q3poUjArSjg5blNRNStSNzZkb2ZUb1Z5YVY2YkRuOWpwTWpXbVkxTDBY?=
 =?utf-8?B?dXhLdGFPZkI0bmoyaG5hSXUzZnRacVU0UWVMRmlsNlFIZTA5MlE3bEIvbkE3?=
 =?utf-8?B?UHl0eEVaeTRPOXNTM2x4U2hadDF5QWExVVY0bWdEMUR2TTVjQWxqemw3eng4?=
 =?utf-8?B?SFdIYTd3d0VHckJQdHlwUzdPTTZ1WlQzekFBWkxVYzIrUzlJQVNyL0I3RDdB?=
 =?utf-8?B?UDFSQWsxMFFmWVNHaFlUVXhhUytZbnFXTGwyaC8vazlDSzhKU1hLSkVRUUp5?=
 =?utf-8?B?ZmgrREJoRnIzdkZFNEg5SFBNZ3lvYzdVaTh0YW1sQ2RaMDBIMjNhS0phLzdp?=
 =?utf-8?Q?tiHM+9kESbKne8RQ=3D?=
X-Exchange-RoutingPolicyChecked: eiKKuqqqOIjgQr8Vw+wvMGJE/DgHWt0atfblX+WIdOa9nQCJTnqa4pvokFgvPb9bvvzKwWIzoLMfi8ui6xrOglZczapCMkQs+cA4pWTfZD+ZMJ4rEvBSC31eZ34E2+Lz1B7SCbZA8FkjpSwAdPUXqOXlTgNg/1hrdsHUL/NArKeMjUFxR1RSHuYsEuRzcGIbVqsU8y7I/iu3f4w+VPq4E28bsevWIdfSVBipsB/HlIWA0EMI/btg6UrmJUI3MzXx9n++Hd5uc5xiP+R6Hrc6OvTb0mI96+Q2rOW5NvZv+fmvEpG5KOaU53BV5Lo5EaJn8aDo2lRtUCYtaJ/xZZUoqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b7401a-1302-4361-1441-08df2ef3c3c6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 21:47:41.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxgrAkQdzwWAYYtANxPcXzcVqkWvrj98Mi74F9rbwtWRoIE2k4+g8iP/ha8WWLGmBg3oRehWcQhd/96DRkPff4Xomjrokq+T0SmXboIf8IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6234
X-OriginatorOrg: intel.com

Hi Babu,

On 10/20/26 11:02 AM, Babu Moger wrote:
> On 10/19/26 11:16, Reinette Chatre wrote:
>> On 10/15/26 4:07 PM, Babu Moger wrote:
>>> On 10/15/26 09:22, Reinette Chatre wrote:
>>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>>> Privilege Level Zero Association (PLZA) enables the kernel to switch to
>>>>> a different CLOSID and/or RMID than those used in user mode when entering
>>>>> kernel mode. CLOSID and RMID selection are independent and can be
>>>>> configured separately.
>>>>
>>>> That CLOSID and RMID are independent on x86 is clear to me. That they can be
>>>> configured separately is not clear to me in this context. What does this
>>>> "separate configuration" refer to? Looking at the later patches kernel
>>>> mode allocation and monitoring associations are always configured together
>>>> and written to same MSR at the same time?
>>>
>>>
>>> Good point. Its confusing.  What I meant is that allocation (CLOSID)
>>> and monitoring (RMID) associations are independent PLZA features and
>>> can be enabled independently in hardware. For example, a platform
>>> may enable kernel mode CLOSID association without enabling kernel
>>> mode RMID association, or vice versa.
>>>
>>> Yes. The kernel interface configures both together because they are carried in the same IA32_PQR_ASSOC MSR update.
>>>
>>> How about?
>>>
>>> Privilege Level Zero Association (PLZA) enables the kernel to use a
>>> different CLOSID and/or RMID in kernel mode than in user mode.
>>> Allocation (CLOSID) and monitoring (RMID) associations are
>>> independent PLZA features and may be enabled independently by
>>> hardware.
>>
>> Which CLOSID (MSR_IA32_PQR_PLZA_ASSOC.closid) and/or RMID (MSR_IA32_PQR_PLZA_ASSOC.rmid)
>> is used in kernel mode is different from whether the CLOSID (MSR_IA32_PQR_PLZA_ASSOC.closid_en)
>> and/or RMID (MSR_IA32_PQR_PLZA_ASSOC.rmid_en) is used in kernel mode.
>>
>> This series uses the high level "allocation and monitoring association" term
>> interchangeably for both of these meanings and doing so causes confusion.
>>
>> Please pick specific terms to refer to the CLOSID/RMID assigned to kernel mode vs
>> whether the CLOSID/RMID assignment is enabled and use it throughout the series.
>>
> 
> Another attempt to capture all the details:
> 
> "Privilege Level Zero Association (PLZA) enables the kernel to use a
> different CLOSID and/or RMID than those used in user mode when
> executing in kernel mode. CLOSID and RMID selection can be
> configured independently.

First sentence already contains "and/or" so I think the last sentence can just
be dropped.

> 
> The kernel mode CLOSID and RMID are specified by
> MSR_IA32_PQR_PLZA_ASSOC.closid and MSR_IA32_PQR_PLZA_ASSOC.rmid,
> respectively. plza_en activates the PLZA operation, while closid_en
> and rmid_en independently control whether the corresponding kernel
> mode CLOSID or RMID is used.

Please aim to provide higher level description than what can be seen
from the patch.

> 
> Make the register and its field layout available so kernel mode
> allocation (CLOSID) and monitoring (RMID) selection can be
> configured independently."

Apologies but I really do not understand why the "independently"
distinction is needed since these values are always programmed together.

Here is an attempt, but it is written without knowing which terms you have
picked to stick with:

  x86/resctrl: Add PLZA MSR definition and field layout

  Privilege Level Zero Association (PLZA) enables a CPU to use a different
  CLOSID and/or RMID when executing in kernel mode than those used in user
  mode.

  PLZA is programmed per CPU through MSR_IA32_PQR_PLZA_ASSOC, which contains
  the kernel mode CLOSID and RMID, an enable bit for each, and a bit that
  enables PLZA on the CPU. All fields except the PLZA enable bit must be
  programmed identically on every CPU in a domain.

  Make the register and its field layout available in preparation for resctrl
  support of kernel mode allocation and monitoring.

Reinette
