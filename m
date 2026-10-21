Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792603950;
	b=vqBKAQLdQtwv86tl9lrEc1omFBaSj5tNjtAIfwHSdR6JTPuJkWczjXAGkRPLto2k/Xrp
	 TXU5oQZXqNUka9VA772a1ahYEap152c+M1FZGQ3d2fOjAfvqQ9hl/Fj6seJDdqbbX9NUT
	 eRNhsD+WVZ6bCbblRuBd/cdnQ1Bg5ZCc0t1d55cdsMlQyyq2dv1I8kE9Jhr8aF9mVVUjM
	 lM6Ma3GPjHvISlczggEhLQTq0IkT1EUAQtY73bO8ggWllnmDd3cxDg//rYFUsVr3pqVk3
	 6QFh1fFjq0g4yiKy69nl/v5CtRlc1sD+FJLQjuF71d/qgiUYGilubjoyn4nwVkSTvxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603950;
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
	bh=eDOwILqvSeu/Xile2Ox7V5hy+IB7FsI3UtFpQhxrkSA=;
	b=qOs+Uezhe1oIWVD43DEE+1YDJlt0LggQbLA4DSIaLG0Durtl3UJd9iK920oTpAA0Ul4+
	 X3HqBCByyejzC4YdShZeHRWU2MhiNy1T5KCEX9R6iSFO8dpkEwul/EMHKx8IlXL7jFt1Q
	 pBhRScqk7WXkUZaWyQnXjOOh0R2qxEhflTWwQjydexRyB1/p7GpN7eGOYUOgRiE2kW4vm
	 0KiVVsdQCIxAyGKcydOml9suZyiDi3vnUu+HBdY+fVjA0fg0W8AdQelCYH/JwutzPyO5W
	 rtorkVosk9RS3Ztvp27/LCNcusdKWWqyD8krnrfQ6DWDSFYZxuNxXPn8undmiEonopw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nmztanGf;
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD3606A31F;
	Wed, 21 Oct 2026 17:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEBD3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nmztanGf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792603949; x=1824139949;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dhs0U9HvLpSQy2/VZkoTjZ02Pn4fVWifffsNlT7pcM0=;
  b=nmztanGfNioRkUpuy2kya52APnrJoNCwJ+6UXgOLioSJeoDRCzWxhCxO
   L9DmJf8s/HwFNdkGFYTPg/BleMLg/JCjbWkHHqmdGTTiU9vf8SWDB6wWQ
   m/mye3I+ht1DSCktrRa9wQcwVOb+yVHqwCEm1qPE7T8RuXUBGa+h2TUjH
   rmE2QhP2eVkwPgMb4mCciYAo8tYF3928DzhdhVZcq8uV1o/89800Ekwq2
   9vyeGMi8bC7qG0gyZJMeGa7ej/zDhim9LRbIBSfkXCMnwn4u/cA3TN+1e
   Sy0+04zdNeUM6yvE4S090b8BL237gTyg7uaTrKW9Fic/6y1P1XC8Vo+nb
   w==;
X-CSE-ConnectionGUID: dbCyCYgOQyWHwoco7b77Aw==
X-CSE-MsgGUID: hWWUewfxQx6aX8vnQmBzaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1349455"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1349455"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:32:28 -0700
X-CSE-ConnectionGUID: WFxER6v2SEC1jBXxqLIezQ==
X-CSE-MsgGUID: bfuDoVx6Q0mJ/viynkzZhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3463700"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:32:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 10:32:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 10:32:27 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 10:32:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjhiPePgwaHQF9EuXIhvIebXO5j/+JbSqrsyZTd4oSDpMajeSYL9OpikuSBXwV/zLLbWH4oqMNTsdYTY6b05/xBDBndVlI1PIEIHbwCIjbpl8Jy3LlUjXd/Z5sBmnxACLp2QOiJpJ4H/iyOfsKK4VfmSZ87r3bxk/LDRM6tbHUfSWWibpc2RYHBxefj8lBolhnwb4iOUT3zSzl8wgAAxSAH1Ae7i+2RdP4QLsXKa+IbZgqNHz/EhX7SBNzN4tp2Nz1HWfEH2SrF2o9VZxo/2eyg/4YEeNgC1EjpBGO+cctRZnlDx+LG0Uvz51DpXzTGv3JIL3usQMFROFoWjig0v1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDOwILqvSeu/Xile2Ox7V5hy+IB7FsI3UtFpQhxrkSA=;
 b=ZFGQR25SIriXbpgKx6HTawoPDOQMFiAzAi7/i68OI0vlJrm+5UYeyi0IKAmwkYGqgB6DEpPfc9GJ6YxvmqsyI4gi5/EIvCeqKOc7ogyi8Wu1k6aY9KL2YYL6myFY4Rb+NvbRh/fd+dSYAneLNApDfAuW+W77GfUZorKAugtz+HnEdk+CLg3t/LOsWG2rDYhOn73UrUVudEFQE1QLTV1YsB4H0Si6aMVB2goTBgmuwQbVJ3DtNmcVrNnL6SucJOOFX8mjv5C1TGRoVwZAbnwPeTMA0fYkdp44aHEGh697KL6DJtGz4pvuOTstuhnxIrq4cmrEDUygCpKu3E/f4VtKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by CY8PR11MB7361.namprd11.prod.outlook.com (2603:10b6:930:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 21 Oct
 2026 17:32:18 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 17:32:18 +0000
Message-ID: <cfeba010-4fde-4d5a-bb9b-d476cffd6ac0@intel.com>
Date: Wed, 21 Oct 2026 10:32:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/18] fs/resctrl: Control visibility of global per-CPU
 kernel mode group files
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
 <28d7e4484c93d899ed86ddafa13faccce0dedca9.1790867441.git.babu.moger@amd.com>
 <c600a240-ed11-4e31-b3c3-779f01175f28@intel.com>
 <e1753b90-f22e-4708-8c2e-0e1d2e0f46dc@amd.com>
 <91e0e000-7e37-4e49-95cd-76062097fb79@intel.com>
 <345e3647-5bdf-4cd4-828d-bd28e0b66cac@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <345e3647-5bdf-4cd4-828d-bd28e0b66cac@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0326.namprd03.prod.outlook.com
 (2603:10b6:303:dd::31) To SJ2PR11MB8370.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|CY8PR11MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab852b6-6d62-40d7-3989-08df2f994123
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|22082099003|18002099003|261021121427099003|261021123027099003|4143699003|11063799006|5023799004|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: P5wJ2ihrpBVrCxaqgKNY9WotMbo6DBc51p8jya1uTKLfRVMowGhbpQc6TetDEM1dBmVegQzUhCyU1ebMVEWNeXIYBEQNCCS++h3tOPC1SnRVvcGLZE+gF1ppqtWWfhg/YfcEMAoKNWYR+l7WVjr+7a54azfx4zqjzA7dAjFmHkMAJiDs8XPHoGgWHF8hgL/L7XQ0fqrS1E4ewZ779stX68etCd0PG/FPzqSuuKxPyCC7TeGmNpBOnEBSPkENY6nSCKRwwjKSDrj/Nkb0TlJ7r4HwiNuHhrsU7LjG+qygV0dD0BKm+LBdIkd+2dKdyfPcxFG2UvLi+vukJRFd/FDkj4zNzPdyt5Cm0PMYg3DevK2BnxZ/0QTuEjL5s89jtNaxJxAqZLBoaPdaUJGGVL089eRp7Sy0q3EpLXAHkx6nMIPX712Icd6VwZdl5g32n9qTyLnXEBxO1D6dUNHssiQv0RvxOOzBDUogtIbnHD0SYrHNn7AFQuEK6KVpQw9ZxWLxQGr8nOvMqcGkprESJmOvQiXdfk0cuM8Ijo5eNYvdx28OfMW+L3bA6MzLvSoFmz9//aCwqwNTF9uGY5gmwNsC/SId9Lp6lOKeckIDWUM8MWQLYoPDUGFcop3ypUTy5tCJyFN14zgAGFpoXCpAc+5fdZengGOyv0hCCrGAI+9TXYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(261021121427099003)(261021123027099003)(4143699003)(11063799006)(5023799004)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVNhWHk5QkVhOC9sR09oNTBVODBCVWl3c1NodUpTNi9NcmRsdjhhbEg1Rmlz?=
 =?utf-8?B?UlE0b3Jtb2ROOGlEdjQ0K3NtUmFFOUtsWWRlODNXcGVHbTcyZmpkS2ZkUmxW?=
 =?utf-8?B?NEJEcUJUWERnTHVXeU52WXlYWFVqLzVlTGlFTFlrWlVkbkZIeWZlT0svaHY1?=
 =?utf-8?B?emp3aHNTT1M3WGE2d3hIUnRQK3A3UHErTkxTcHE1di9iVmtqMG1nMklSckUv?=
 =?utf-8?B?clhZUitTREt4RXh4RFhaNHlJTlNpSWtlcVAwRGFkelN3VTJNTEozV3cwVGto?=
 =?utf-8?B?S2hwMzFYUERSekxyMnMyYkpWa3NwVWZGRWxTcFlPbW1DVkFYYWJoV2oxempU?=
 =?utf-8?B?VGx6M2NFZW5PRHp1a2k1SUl0MUg4KzNzY2dqS2NmUk5lTkNZbHhBb1hGSWcy?=
 =?utf-8?B?dm1qalBXOFBUcnRvRWhsTThUL3N5WnBab0tvYlU5SmJFZEMwdFpVRk5yTlpy?=
 =?utf-8?B?MzRyWXl6am84dEtReGNKcUxsZkx4ditib2FKYTdSTUFCUjczZDdqYzVONnZu?=
 =?utf-8?B?eDRuVXhzcnhzRldKQlFYMmN0Yytpc2pRdUNkMkhZVE1BMVd0VUV1ekhmbENp?=
 =?utf-8?B?R0JvUEZJMzR5MTUycVBoeXNweFZ1WlMralZNc1ozOVVETlJzaVM2OFhuWEMz?=
 =?utf-8?B?STNMQ0VsYWhOSFNyRHVidTFWTTNEdWxRU2w3bE1weXB5TzF6TklxK1RkajV2?=
 =?utf-8?B?L0x4SVJTWmpKWmgvSk9xK2pvQ2FqaUJZQ2lPRmlHNS9kWVhJUXhIVCtMaFhq?=
 =?utf-8?B?R09ob2tWM25XUk94VzJhR3dINEwzOEswdnZyL3NVMm91YWtEWDNLeHFsblo2?=
 =?utf-8?B?VXo3VWt3QkdWb2tKcnMxM1FyUUhTNDI2Vm1FSWtKcGp6RURBSjA4RExRVTk1?=
 =?utf-8?B?S0lyNUtodi80L1hQdWVDSHdGaURpL0U1dTJTTFoxNG5rU3ppemsreW5VSExB?=
 =?utf-8?B?c3VOQ3hpUFR1d0xXdFp4WHd4bllvc05NL21LWjhlSk5NaGtaZ0dYSmxFVlJU?=
 =?utf-8?B?bmk4WWtXMW1zZEZnMG9ZUHdQQzZ5WkltdHN5elNNRjlGRTF4MXFrbExPeXFu?=
 =?utf-8?B?MEJHb21EamRxS08zemw4QVIyTzhCVXErejhlMExHN3d0TklkZGRIWlZPTFJY?=
 =?utf-8?B?UnZGMzNldnE1cmtCc0xCTjJhMlBJTXNKSTNIS3NFTUMvdWJMd2tUVWxNemlL?=
 =?utf-8?B?WXV6QW44ZFdXMk5GeVBUY1Nob1lQM0ZRaHhwYjU3V3dlVFNyc3BBK3BiNXRs?=
 =?utf-8?B?dHM1UFZqNlNaakIybG9OcVcwSVZOZU1YTWFhWnA3NEsyalNjN0tEQ1Fxb0ZB?=
 =?utf-8?B?V3ZPbVJVeFNDd2hxeWtkZUhsT1pOTFVtVmIyVUkvWHEzVE5IZnNPNmhpWXor?=
 =?utf-8?B?TWxxNi9pTjhnb05KYkxaSXZjUTE2eUFNUmllNGlicEJEMFVReVZTcVlKUnNJ?=
 =?utf-8?B?dFcwTkVzWGFVUUJRMXJhbTdjcmlEN00wUHZORFhMZGlmY04zdzNOOVRaN201?=
 =?utf-8?B?bVVORjJXVXgwMU9XR2FRdEZITSs4ejlBWW1HeStiOFFIWGovK3hhSzZ3blc0?=
 =?utf-8?B?bTVuKzdscmZGbE5CbGdFV1JvVWdycmdIeFNEaHRqTmdDamtyZVoyeEZVYUE0?=
 =?utf-8?B?Zy94eUg1N29ScXM3cjY4Vm9jcUJCc2Z0NUc1dlgrWFNqWHpXL3Z5NVdTeXI1?=
 =?utf-8?B?Ti9UMXp3THBoaHN5c3lORkJwQUZuamhTWGFyNmNEYi9Uc1BscVRoc1N0TE1H?=
 =?utf-8?B?OExkdnJsQTZpYnErTk5CRGdZSFk1NVBXRVl1WkN6OE53S3ozQm9nUVo0UVNS?=
 =?utf-8?B?MlkxWFNIOWdvTVRKbFRjdkRTUzQzVFZMTzMxUnA3L1NOWUhadTB6VEpRNEs1?=
 =?utf-8?B?TENZOEFJKzMweCthNWI0TDl5RDc0K3NUcFo1b0c3ODlEeFM3UUtBcWJWUUJs?=
 =?utf-8?B?TWRMTkY4L09aMEFxajJpbzM5UEdBRnpDWHRJWkhWSnpxYlFGOXlKSTZiR3Ru?=
 =?utf-8?B?aG85OVRKbW5UblZMMFRsRkVaNnBNSkoxN0dDdG1YSytHelJhd21GbjBnVmlw?=
 =?utf-8?B?QmhpVVJuekN5d3JaSTRqMjFCMWRsUjdvY1R1T0o5b2cvRWlDYnhPSVpFdG50?=
 =?utf-8?B?c2dXdXBhaWhWMm1YL3Nuem1mcDZoN0NGRGpOb0ZDRzNmTXg3OWJYdmRqOTJi?=
 =?utf-8?B?RjdaZ3dyakNjZDVCcTNQNmtiaWdKdW4wZkNRUmo0NVM1alByVGRkbEJGeWoz?=
 =?utf-8?B?N0FXcERxN0hCK2NJdWxnemJiSHFhbzRCZzFiQVFyY0Nsd1Y0UUowRWI5eCsr?=
 =?utf-8?B?QS9ncjRJWm9CUHo2VUxWMmVpYzVYeUlvL1pRK0ZKaUo5MjBjVEtNZEQrVGo1?=
 =?utf-8?Q?YWftM/oocgILwMZ4=3D?=
X-Exchange-RoutingPolicyChecked: kW564UW/HOO128LKN+Of5kKwx4iEi7INQxenal3QwYgIO/v/vKGh2vM13OKwFViZozzJT0jaanWeOobT6KRB6JOfSpnwEkY2x4syd/ac1F6SLPICg7NiJASvGTN56sWHw46djpu+rocJ/aiZ0iGPwfM5VvGXIZr8o+j8617v+70PVlk0yNDhBRzGqYjGBNQe5dwzqbbXPEt/SSCsSjEIwAOWhyHy/DhEfyX11dSnDlbG6iTHAKt88oJ6NphOPWYs/9Uu9jscipn/s03i78Uh1iEYSs5UTpAw+MLf9GyL0LMfBcV1YxQT9DZ7Zjtxg1B/kWBZ4fyEZbrC6/j4zrALHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab852b6-6d62-40d7-3989-08df2f994123
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 17:32:18.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0GfnsTcegGxKVyh0xbDCjS2ymnrbWqDaBkx1qFPp5t9GNBNuewYTXepIYvfhjIvh7oa/9ylTf1aZs4a64cz9f20k4IXhUUH7nQFx3WCaI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7361
X-OriginatorOrg: intel.com

Hi Babu,

On 10/21/26 9:59 AM, Babu Moger wrote:
> On 10/19/26 17:00, Reinette Chatre wrote:
>> On 10/19/26 9:31 AM, Babu Moger wrote:
>>> On 10/15/26 10:46, Reinette Chatre wrote:
>>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>>> The kmode_cpus and kmode_cpus_list files are specific to the
>>>>> RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode. These files are created in a
>>>>> hidden state when an rdtgroup is created.
>>>>>
>>>>> Introduce resctrl_kmode_global_files_show() to manage the visibility of
>>>>> these files based on whether the global per-CPU kernel mode is enabled or
>>>>> disabled.

...

>>> per-CPU kernel mode. Hide the files when the group is no longer
>>> associated with the mode.
>> Could the patches be organized so that this becomes a symmetrical change
>> that highlights when files become visible and when they become invisible to support
>> the description within this changelog?
> 
> I didn't quite understand this comment. Could you please elaborate?
> 
The subject claims that this patch "Control visibility of global per-CPU kernel mode
group files". The changelog builds on this by stating that the visibility depends on
"whether the global per-CPU kernel mode is enabled[sic] or disabled[sic]."

The patch delivers only one half of what the subject and changelog describes since it
only contains the change that hides the files when the mode is deactivated, the patch does
not contain the symmetrical change that shows the files when the mode is activated.
Having the "show" and "hide" paths in the same patch would make the change symmetrical and
easier to follow.

Reinette


