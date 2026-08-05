Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F5D38F93B;
	Wed,  5 Aug 2026 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933979; cv=fail; b=rA2kIq/SIEwaMT2HHsyxqEsgtMjFJYUGuCvIR7XNu1qYaA/H9pCf+gfeWBC9FDXqttN/ydoTXyu0gZyng6g55K20wltWhPPY+PP6Iy+/Y6fl25yQNvBRNTcQVxCrrY2PNfcn83k+fpWQPHzCkM6ko5oSm5TeEYVb9oPaUoFKxjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933979; c=relaxed/simple;
	bh=SapD7a9A6Q1Tg0XuDbL87fe5Lf3zdiHXLpbu8IGrqJE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IrGbMPj/4GJ65AHDvePjpgJki7VjYV+L0Ofq1o6Oi3T8sUH8YyZk6HXjEOByCEH0cupoA9PyMLzZMau/02rCs5cK59SSYOukIZL4S559rlW03OVVIcT7inGZ/7OOJANAcSqP+HjmJZZYLpp2ygCmnUXlPSBniLprFWf99VufgMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkXpvIeK; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkXpvIeK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785933978; x=1817469978;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SapD7a9A6Q1Tg0XuDbL87fe5Lf3zdiHXLpbu8IGrqJE=;
  b=HkXpvIeKu1N4I6/wtw+Td3+Pls+vBEqC3Clj1GMx/DG2KTPeEVzA1bKO
   DTnbyFl5Pah6aqNyjmf0RTlfnIpnAPtj+I2sxEx2lvMRlwSCQAA/kg/rF
   pblHi0ccatCwvtEXjD7x6JDK0C7uSvVal2SpgKhh4PMVkuRZc6X7GXeqW
   tCHGa7lLxyPogjbhQKmH2pnIx3xA2BW4EfW8xdokt0TcsO0DAZvNhZQX7
   6Pdr/1V6+7jnf5jiAxhV0J2K14QW89d+gfUKFyvAUFPv814PM2v7smmCY
   Qhvtr/rHgByjhwwVtLUGMkqigawdLmIoys4PbP9y3cZzI1gkVyaBVS5u3
   w==;
X-CSE-ConnectionGUID: EmFZbO0dTNigt6V5X1mFwA==
X-CSE-MsgGUID: e6Sk5yyFR6O7MN72z+/sJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85482169"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="85482169"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:46:18 -0700
X-CSE-ConnectionGUID: SGLQHNt5S7+e/hO1aBbPMA==
X-CSE-MsgGUID: x+k6gRs2QfCVZbqEYRqStA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261253568"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:46:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 05:46:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 05:46:17 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 05:46:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/1E0MeGietMxv+/MZe4MexEPRtzIN9yb/bp5Mlyt8QGGLk+gghP3wt8UfKK8+Ps5o7dTbeQZAeXxMRu8CoKJFPld41v2qYKcDJqtQoEoo/j8LiLAZ26SLRjRSIE+DHe9AEnOY336iKET+1PC+n6KzYPP6vYHshepam68HPdHGAaJklY+yH28J9Hy7Qn2L3A2Jw6YMhWqDzbueJ73thB7BQ/E3Lmd/Ez78zF4e4HO1E8jrEYnL6DdqAt2EOXCEKlw4YLZutxFBtia1qJRmb1N/6xDPFG3kTPhGbLaC+LokXwJ6PNKL7CR4h/o7buvfSzuytJffISDu6Y+sGiVACnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLOwStJXshORxAFPVgDYXow9PQmR4wUwpvg+zIXrbPY=;
 b=ikUtXowIUHm3asp09iUpMtMyvejOPnOLox58hhFm5tlPl2N1HbhnN0plmC6Mo68gUdQNzZi3Vtv2ZdJod4KUBFNzJ60JiDDR25dgmmOpFub3OT0YnnkIX+C+oOwTV0Yk7rans9ctIGPs/4SKEkl2Yeyag2/IlNoMfsTwDFME4wy0jazYBTRYyyUP0NWr7Vl1/VfLoYRnVVG+yBdBeg87ljsWws5Q+cgP2LKGYp83zb0aBMqAw7mqWLlncH5KAIsQarU5qsoXDy2PzDsZ7AdyObcRzzDpnbMRKweLlTXzXBDQfEWc1Fs8mkO9FTenmt2TwNM41TWzoQ3Dw7dtt7I3DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4450.namprd11.prod.outlook.com (2603:10b6:a03:1be::20)
 by DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 12:46:04 +0000
Received: from BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068]) by BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068%6]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 12:46:04 +0000
Date: Wed, 5 Aug 2026 20:45:56 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<dave.hansen@linux.intel.com>
Subject: Re: [PATCH v1 2/8] x86/virt/tdx: Name the TDX module global metadata
 field IDs
Message-ID: <anMwhEOsYQmHC4Ut@intel.com>
References: <20260804112941.19894-1-chao.gao@intel.com>
 <20260804112941.19894-3-chao.gao@intel.com>
 <7ecd59df-1bae-487d-a7e4-bf7bc0c45615@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7ecd59df-1bae-487d-a7e4-bf7bc0c45615@intel.com>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To BY5PR11MB4450.namprd11.prod.outlook.com
 (2603:10b6:a03:1be::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4450:EE_|DM4PR11MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 35109137-4a1a-4290-da5f-08def2ef82dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|4143699003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zsMWYtRUAgh7dAtK2UyLQYXJ04zyX15krxhzbTHbbPrJAeUMgR6expm9nOxvfDKCOmnQicbdDp7MXoiy+Sd5+JYwJI4Hxpnx0RsIFYQcTgP42R6UboXUgrCwIfKnlgtl6Cy4k2F6ZAWwBJ3uWzW2AlasR4rbyCh0c3GCwWlx2w0ty4+2V5WeWb//joHXhI94DadbJgUeDlelrYNNDY3EC1il1JZFT31Y+laSXVaiJsQRllsyOx0s3nUfamvkeJP7TsmXWgnZpXGGJF8NridClJEaZmI7T+dZaO3dF9YZQxQYNvejIB6gghEqOpX/4E+d62qjF9pPFAzSkkY5MqS22qHQLVpR2bE9UbhZdx98l2IeYnegEdhZ4v223w9R11ouclyHUkddTZYEJLWPsf9KWB8L37mPVrtm3YtPw8uXCcbuz7eyRlF86NmM1tLbBL2ZIGKRXWFTzWsFhyzxYc8TxTblscufLf8bBsuhWcGb9pc/tvid9fiuLzqlLPBvECepV6prnMlN0mpdjt8PgUG70OI2rFJCCaeB+KCLDJXTf5esqd8FndQwtXdaVryS0rmuIVAkbcAoutwryDt9hvMFYXaEhAAToVZL9EQ7/ziADV6hT/XuQBL8fltJOYdlBGxXY2Yw2lcjcQbkzg8GWX5ct83Gme1kBXTMR7UlfgPtMjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dxbT6GkgirdXD8VNNN+UAoEOmjDidqmgzyMBSDF4E6wljmorFmq5+VIaHWD5?=
 =?us-ascii?Q?CZ0ZwO9BMRtzKC/Me7kqBlbvdzxt0pX8FOAFzycvnywuvDcnhaPwucwkCU2A?=
 =?us-ascii?Q?8zHBmJMpAuGTiSdEV6/M5CWXHbKFu+X3BjN9RVLo4lQdxnE7JLz0UjFGmZKi?=
 =?us-ascii?Q?HDFIOVq0m4AMKjqbMR1+L7bYGSGK5GdUDPCnajAR3phRP23NA/D7om4+tDL2?=
 =?us-ascii?Q?r3jhc6FrIjNBe3uB1coIGcNu9FIt2BH5vVI3E7HWCBoVgZjSChD/Ti/ZAJTy?=
 =?us-ascii?Q?xoZwOeyFBahh93f1Vc2CybmsW0sMD8MGUrY9Pd+D6OiNQKue2U8dW+aTHs0K?=
 =?us-ascii?Q?ISMAO2LjPEneUbWpvSnQWzjF/0hrdp3gze6OZDs2Vjfkv5OYHKAAc1aBjO/A?=
 =?us-ascii?Q?FyWI42doxENdrjMyRhSypZRt8JK3fklIwD3QsCcIZq45FZ6sxbxkmvigfc28?=
 =?us-ascii?Q?TzoVH3SIzsWSADRhQhl443xKcg6LImN7GqhVbpeLOYVyw63TkNl3ZIm0DRLl?=
 =?us-ascii?Q?fC803c9viOGVzF6tWhZZtKCnI0vmhZeSme3IG//UbkKMhj8HBSHWnKpVxWFL?=
 =?us-ascii?Q?flG6yHqj20Qn54yTWgyW1QPBAEFgLyZj/XsQjOKJgYrT4QPp3ZuVFiJClX6x?=
 =?us-ascii?Q?crbl0Vzp5hdxKumuDdjYIrL6P70rTYzH1ehgRE324gm1uy5rXYxMhALv7JEc?=
 =?us-ascii?Q?QyuTt0pwJBwz2vGubtzaFQqzuGYlxj4fJxRKTHt9LiJTuHhxoyOHprr0YFPM?=
 =?us-ascii?Q?VeJ1XEDMg5DKSNMfcEwunUIldLLCEe5opJrdMc1GhiMGx3aFXjb23WGJh4BZ?=
 =?us-ascii?Q?GRw3sNETROzBj1dNeJyw0vGyaa0/ytwUVTWvYDBVMLZBFFpmxISAj/V93jHL?=
 =?us-ascii?Q?oWbiScBlNdptD/0u2w9ofWy1EbxgeSM1vILB1HSVNeXMK10iCkbCTqgnP3pm?=
 =?us-ascii?Q?B/kwE4B2mjDLTJVkSC1Sm5xYjoPnQKEWycEELOKfabr/3kQjuoXkmmiA7i9u?=
 =?us-ascii?Q?8EJjypd5Tnact9YQ8is3u6/Cox6UnFD8NWeIk/gsoYWYpzFnNlIbSF6qX4cD?=
 =?us-ascii?Q?6bGebmpzCeS+8tIQZL7QbQ0K25P6qu1hTRm+AJFh/P17o2YrdbAWgKBFm7Ri?=
 =?us-ascii?Q?WEmjO7C+M1nucJPBvM8Mdhi9S5/Gdx+6tBjfndirQ+R1EPXhVZC4VrpMyxMQ?=
 =?us-ascii?Q?FBKpPPpzR+uEkbAa/ZA1DYxlsS742EdVS0c8JXmylsG+RYDtnES558o3YvjV?=
 =?us-ascii?Q?6m+F1cE1oqGVUXh9zUJZY9NsBhe3midrArXvvg93nICT3lu1LhcdCtkKRTYb?=
 =?us-ascii?Q?+bJGvHqbvM32kZNeUDCyHLOgGh/L5uST779meuaVZ9s6EAbfqrXGnYw1Ox0l?=
 =?us-ascii?Q?AnmKDYsB6Hk42tSDAOOz2EuSr0NXSugrIRpJ2+aEPcy3zGEknbjuiIwogahO?=
 =?us-ascii?Q?v2woQsny0uG7dM6/RKqogo3QVlR1Uoi5HlMY9DG/cIWIiysFAQ9pazSXu9xb?=
 =?us-ascii?Q?cU5ooEGbWDIEEsod5eNHKXuDK9kSDRYYuGFmJ1Qecc7LXew3+Hj3G7HPsfP3?=
 =?us-ascii?Q?qV2KdinHVm6Obt+RCbRoJ94YwtORatwg8nbB0ytmWeqrgFZ8Ez3X2pL6I6dG?=
 =?us-ascii?Q?inS5mQ/zjiJJg+fgzG6yidoKc1vo/6B6+CgAk6mI4sHI3lXmVoNOxViTMp7T?=
 =?us-ascii?Q?M3cezQDM2iBVxE+sdLLM4Hv/dZWsorDtF8wjCRMBTgssPpahJPxUOI33VPCK?=
 =?us-ascii?Q?cImJPvQ8uQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: ia3o3Ghqc9gbrLgXbpXpf19TMigsx/JAZ8BnO97pbdyGZ9MXMyJDNL0QMLzsy7yzUOB0B5aX6jwsQ47oZUe9W4qYGPM0T7R5pTv60EKw0Cbm8TCmgGecoWq2Q0A6ci48pVVYA3YukChqx+xzMHp4qlrCA658zwdZwWJidcdaDYDH1sH+w5akylzj2Ja69/Omo8c2nS2dWULiYaLb67pO4ppCDbi6Wd7CZUnElnQJY+cawghAGkwnGkIChZ+3TrW9kNL56FjLOaDrRFYEf/YTtUBspXapfdey34VvKL9pFII9GJv+jYoIU6zhHDjlgNwHgflbUej2azM20IIiMbhpjg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 35109137-4a1a-4290-da5f-08def2ef82dd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 12:46:04.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7G4APH3B2KjxOVVRFgIh2SCmfnD4AQmUygJn93e6IYQ0T/uNxsOPxEL4sl2QYuT24FPQYFuOLgk4JRpWGbAitw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6117
X-OriginatorOrg: intel.com

On Tue, Aug 04, 2026 at 04:52:26PM -0700, Dave Hansen wrote:
>On 8/4/26 04:29, Chao Gao wrote:
>> From: Dave Hansen <dave@sr71.net>
>> 
>> tdx_global_metadata.c currently identifies each field by a bare 64-bit hex
>> literal, extracted from the JSON file by an out-of-tree script:
>> 
>> 	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000008, &val)))
>> 		sysinfo_tdmr->max_tdmrs = val;
>> 
>> That is unreviewable on its own. Verifying any one line requires the
>> reviewer to cross-reference the JSON file.
>
>I'm looking at "global_metadata.pdf" from this[1]. I see a line with
>"MAX_TDMRS" and "0x9100000100000008". That matches the lines above. That
>seems *FAR* from unreviewable. There's also no JSON in sight.
>
>What am I missing?
>
>Listen, I don't like how this turned out. I'm asking for it to be
>changed. But let's not justify it with things that just aren't true.

Sure. The only reason is to follow kernel convention for ABI constants
(for example, SEAMCALL leaf functions in the same header) and make the
use sites a bit more readable.

>
>> The hex literals in tdx_global_metadata.c are left alone because that file
>> will be replaced by a table-driven reader in the following patches.
>
>This part of the changelog is good.
>
>> No functional change intended.
>
>This is a bit much. :)

Ok. Will remove it.

>
>> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
>> index bdfd0e1e337a..5f567cb6c07a 100644
>> --- a/arch/x86/virt/vmx/tdx/tdx.h
>> +++ b/arch/x86/virt/vmx/tdx/tdx.h
>> @@ -58,6 +58,57 @@
>>   */
>>  #define TDX_VERSION_SHIFT		16
>>  
>> +/*
>> + * Global Scope Metadata field IDs.
>> + *
>> + * See "Global-Scope (TDX Module) Metadata" in the Intel TDX Module ABI
>> + * spec.
>> + *
>> + * A field ID is a 64-bit value that encodes the metadata "Class"
>> + * (which Linux mirrors in 'struct tdx_sys_info' sub-structures),
>> + * the element size, and a per-class field index. Each ID below
>> + * is paired with the C member that holds its value.
>> + */
>
>This is a bit verbose for my taste.

I will reduce this to:

/*
 * Global Scope Metadata field IDs.
 *
 * See "Global-Scope (TDX Module) Metadata" in the Intel TDX Module ABI
 * spec.
 */


>> +/*
>> + * Base IDs for the configurable-CPUID arrays.  The field ID of leaf
>> + * index @i is BASE + i; for the values array, sub-entry @j of index
>> + * @i is BASE + i*2 + j.
>> + */
>> +#define MD_FIELD_ID_CPUID_CONFIG_LEAVES		0x9900000300000400ULL
>> +#define MD_FIELD_ID_CPUID_CONFIG_VALUES		0x9900000300000500ULL
>
>This is complete jibberish without more context.
>

I will drop this comment and instead explain the indexing around the loop
that reads the configurable CPUID leaves and values.
