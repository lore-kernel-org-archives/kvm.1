Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC424346E59;
	Thu, 24 Sep 2026 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241075; cv=fail; b=OLmvLgZOlTqaO+qP6voGoO4gSqb17MrOlt97im5G4cgC7z67ulOYNbekOqoQ+BxcBMQW4qn3Oi05VLydbHDqVfSbf0a2HBEnGKpE5iajoCHD+RF6k+Q4M+lsfOI1/zKmO8mgQNWrxG2nWf9rwF5m1w7r9guLnnT+vi9QYrHxU08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241075; c=relaxed/simple;
	bh=mneDzh+1L2+ubvXYRU18TeQIyBsu0bTTB3myayIVc5E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FKBkkEqSd/Zj6+xVUrzMDEZjENE6TlGdeNS+MqMQhjGicAGotzWebMIK+yu47zpGc/YWv24/jYyU5PT0iq3SFwPQ36goldMJkcwzufE2Q5kCkh4IN1Q+VeLMtqWpcVsDR0FVrs0mEULj6gr0Oii0bXJvCXYR1LAmD780Tgq4b5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4PAOmc8; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4PAOmc8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790241073; x=1821777073;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mneDzh+1L2+ubvXYRU18TeQIyBsu0bTTB3myayIVc5E=;
  b=E4PAOmc8e2l4k3NN7MVjRe7sETmMcnfU5JN/r5mdjP5K5S3Sab6okMde
   Ij4JXCYMTHan3V2gB6n0AUykkqlnHBSgjToNZ7S46TVTXazUir3OVgCbi
   bwN2sHqBOHUVNYCXw3sUmb31lRbkasFI4dE+LCAe3dMd9dzmtPqMU05E9
   AJScyHFmfPIeVTKBdvs2ZVxvLavB0mjjzUKqNvaBoaS8TShf+axauwgCK
   Fyfrs4JIUSnqo/UJJmmXEVuSt2xkL8xmPvulQWAjLo/W6lmN9rmQTm/W8
   49tft5eFUHGpS7snKRHoowLjgaU2mYOvFDKlX3FKw4Y0AZjQ2FF/ZzTd9
   A==;
X-CSE-ConnectionGUID: E5Ybly/CRXCTRthxz6RPng==
X-CSE-MsgGUID: GChovJP7TxSAWImsCPFPSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101585476"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101585476"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 02:11:12 -0700
X-CSE-ConnectionGUID: cOr94dGtSk6kxbcOxlc7WA==
X-CSE-MsgGUID: 4OZJE+YyRHiOwG18+7y7gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="271801062"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 02:11:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 02:11:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 02:11:11 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 02:11:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSaNgptikdYuYwF9vUBVizju3N5N/MqAJQf6YsDQzUV/ozodLGCVlxCVL5iQDK3YHb7TfvHTEF4MtU4275Se/GpM9zL1wN/czELM/xU3kr1Hv3/ecjfSZNhZ+A9kLRtO4uHzQRZ5EWSSjcHUtoCBKsmT+F9l1gWMg2j87A4Rc3dSfCV8zb31zFcsFCWxAFRcRGBdh0KtCqxedMN3QPQzUAykDHDlWhtgob8SicqE6tRgjGwOxqtyXQMY0yGT5xrtzwhTSaG4dpE9maUAAzrjC5SMVqq6SRYyatHTu1qQSo/cRPYpej+nIKueamzE6bbrgqoRgQJRsFbg5VS3mV9uzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuA+Y7NTssbp+IvXcKVLdOWFPAnka3ePh0hlRXfVGNw=;
 b=amRaySkGSc/mWgq82oesgeTh+BK9lvDC23/fStdWgB3WCF65blQ45ZcvmmPTyBlNdb9pS/gmIu99G7XNGq4aSZ1sWTE05f8iCgSWOFw1e3sRnctctdg84gmL4NBQXxIPnZ6aWQUFcwTkIWLm7LWH0iXWhXT7IYoX97pyCtuDRIBpS1iuVD/f5Y/SBeOCKZfDl0azegyk09rgNnsKa6G7uhAzZHnpN9U8bp+MvetC9eNFeYL3owhrBO8E079NT/UcbhyM6f5Dkxi/pULNkzXzmRdP5vYZZK86Mf80DDMhcSPO0y/1f0w9uPRbQ3/qGtlThVaiQM9jPHJAW4w9JcsH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by PH8PR11MB9723.namprd11.prod.outlook.com (2603:10b6:510:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 24 Sep
 2026 09:11:03 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 09:11:02 +0000
Date: Thu, 24 Sep 2026 17:10:53 +0800
From: Chao Gao <chao.gao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <pbonzini@redhat.com>, <dave.hansen@intel.com>, <seanjc@google.com>,
	<x86@kernel.org>, <kas@kernel.org>, <adrian.hunter@intel.com>,
	<yan.y.zhao@intel.com>, <binbin.wu@intel.com>, <xiaoyao.li@intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
Message-ID: <arTpHVhVsVnNOK-T@intel.com>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
 <20260922205215.870563-3-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260922205215.870563-3-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: TYCP286CA0329.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::13) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|PH8PR11MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: c97cb417-dcf0-4102-1dee-08df1a1bc19a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|4143699003|10067099003|10063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nu9W7Z5tAD47eFZg7o+4kW+P/GoNNAVYscE309DO17Q5A6kTx9/U7RlOkndTbYInCwRxbIwft37ReFoW6Z43yQ5oeIfHNInFzoL2CtFiUL4c21fJajlN18vVTsMSbDUD0BIJDSKK0musmLkjnE+ZZ4BmcIIctYxQFTG/Gvgzs3qpnPQu845FEX2i0RwvQuvni2bcg7IVHkSwsuYUy12tx1nLcKfVNSmDat99ZjHImLWDM4R+IPXPTxz5Q7NVWfVJVosi557MSw5nJdKVQRYb01QGOFAoHzgSsN3gGE0nEd++2IiO0zyHIJmX3wp9HX/6ugG/jIW8F47G8y/w2DaQxYjKus9eoUKDd4C9zbDG8cleezFjLUhDTYWwXGKh+XEN9GQhpmyuiRhW7Md+ugQEFq+vun/qQGuucrlfYEvztWQ2TW4JV26PfeS6QkzH5452wWeYEs91V2J4fHIYthzlEHjTGAmTpsmyzlwHZhXirjgwa5fk0xeGZdSlTgKuyxSG67uz2uhkDi+OTho7p4DiMer+eqa8KBCGp5327DjR5uahHSGlszVnaqhSANKzCp/kVW8zYob4TijcakEisiWRFj7IJPTNlQM5EXRg8SlgVOz0yc2A5a5+MucywOgPiIs5mBJ5hqAck8OEZ/7VjmPirpVcevt+WXXOXjPocGLJX4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(10063799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4zvnywgnQD3pmMBsIHbOj3lalzDEFjOJ2LwLNKt9SQkz4kL2Xl8DWOKVTRjp?=
 =?us-ascii?Q?MYJnkUOIHPGgAsSYAom7mzXvv3rT+tdG0U/4ROhfK3XUQMFxTXlEy1PJ+u4s?=
 =?us-ascii?Q?24oNUP5qOVT2r9pV8a4Ej+a8VzvUgC3xCaeQRfSXJiA7Wpn2q8Y+zzLPIK65?=
 =?us-ascii?Q?z/0lEonkzfBBLIbxVUB2WGeuBDHVh3T5tJeIiEjhk6mM7E4kWQ3NJgpi7Lm9?=
 =?us-ascii?Q?Ru363wA/G7ff4PC7YRYWsuxtRWy9BBDgHlHyq/XzpYfNTVmwSOdH/kfwm36J?=
 =?us-ascii?Q?gJJ/cyHee6rhKtqKFAfQPw1sEV2GwMb6IONmKsH+64exsQ1MsiOFXGrD9rhh?=
 =?us-ascii?Q?ILKvL6nEvW2S73mPYFpSb+DyC1xybkxXq1yYEOITN/lLNgcNeaMVN/XYwGH6?=
 =?us-ascii?Q?PctDoqYWFo+unJnLfZ4Z9EzCaEc2ODJnnp2GdKVO/U8WI5/lwXnNXe9Ml4x9?=
 =?us-ascii?Q?QyuxJ+TY9yCKkeLqDTgy+QvTh22P2Ip4NMp1AssCdvqC3SOiVq4SVvngBp7I?=
 =?us-ascii?Q?8MdAbUrEmCHfZWZdardax5JEGzxl9izaqzuvM7mX2kt7IbAdzS3Wh+VfpGuh?=
 =?us-ascii?Q?xHj0RgMWBY2NM2W604HvXdCRarKDXkRRo17+RVuG7AlvoPASx3uapOjR8XAA?=
 =?us-ascii?Q?Dj8EBY1+1RDGGOpZ7gmRIkjnPqdSwTCpzq+7cU7yT9dUIN/+On7qjiJVzhGi?=
 =?us-ascii?Q?uq4MGaBjoM8nh+t+crRXMAd1K+2cLErzCVgmXhJi88pJWkBVFDou9g6/l0GW?=
 =?us-ascii?Q?+3iCgTwARcmt7zzFlw4b+nuikxAmzZiAC/WSh24YZq9jhKoGoh3WMNk0J1FE?=
 =?us-ascii?Q?+a4WnB6UdHyCWYQ0jx36qOm+Z/YphTeGuUL/peTKRzucsfcamXU+Ahq97NmU?=
 =?us-ascii?Q?rjikZexwuDHqMMxH82zaCLDX48H3QfqLfdfv9sQQWcprjIutf6pLEwr/1TQy?=
 =?us-ascii?Q?PtCN7FFpzNos7nDZyAbUEq1YnhR1lHQtMUZkg6TppY3DOQHSjUMJftn/B2Us?=
 =?us-ascii?Q?df447CfdgVN+7VWVbW66aNorYdyWve6WT7ZxfBObWB4HiSY10F1yl4nYfGXs?=
 =?us-ascii?Q?GolgFlmt/DYiUk6+sD7J9tCD7xRPPaSBPi7vvvhHERj7JI6CQBSpfYRyq8Ss?=
 =?us-ascii?Q?s5NExpmbDjcTGtt5/EDM4bIyZyYfVrg4sABJY0ndfqXv4/eAl7D91tMiyKch?=
 =?us-ascii?Q?b96296n/+x8SlK0qVBysG+8Oa4c70IAOCeBtf/FRxgjBNHIwold4MsUYON/J?=
 =?us-ascii?Q?/BGrOzSLGLx2JQh/z61f+MLW5YK1IP2ujgysU9tVIeb5krY56Hp6wMaBc/bH?=
 =?us-ascii?Q?lRMDKee0Y1ls4Z5st1RA1b6oBcmFDJhGHIWfx0XUg+60PsJse0wUqGOAZVLW?=
 =?us-ascii?Q?vZW0x9ahGDOfvP7J4+akAPRSm8eaAMtlInX+hXFXkzE3qV3m0Hx0oWbhiNyt?=
 =?us-ascii?Q?ts/JhsevIeiiCfs6MSlUF/nedR37x/JZvBI80aqIp0LESnXKS4PX9BpLOwIW?=
 =?us-ascii?Q?Kag54bXPcCa6CCL9C1XkZDfyq36wQevRzdPt+hix4rbHuOApaAnNf+jvllSg?=
 =?us-ascii?Q?VzANw2/aJ2XntPhGHZmmg6vrODz5LqWw0VRwzb6RJiR/93h6cN50SS7JiunB?=
 =?us-ascii?Q?P+bikULJB67vBN8vYxGdRRGh73qdJjHK6uqaGKFwZGB1mBPMxfx9HrwMAjjK?=
 =?us-ascii?Q?Ac0eIpNCAqdc6+6dqeccMRIN+6hgy4ky9jdanT6MuPP8Fem4D/+uLehA5TCW?=
 =?us-ascii?Q?iA19YNcCww=3D=3D?=
X-Exchange-RoutingPolicyChecked: aYldMycqSXrWnzsDDajkQ4CrZ9HuA5W/fvVt7Avx1DK6kS4XK0tpdfpC3c+X/WbhFgPHwIpySg8npUEsZkilUSVFmoRixFImEg5huGT/WCQjp2em5+Qxe1Cpwwp97CkdQDyLORNG3J63L90xY0gtqBL8GNHPDSOhsCP/H1+DQRGx9yHVnBWcP/c1DPrU/L0oji5aRg6UqH29wcDiV//0IrIGy+HaZKIbt2CT9/pd0shp0mMqqUd8NXi6OIHJhC1z5T45vilj06odQKvvzvsyTAhSivFDLzJAfrgQmJqS5SsUzH8mupV2k2k/uFU/rUGfYJoTwOwo6j8/RMON3w4xPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c97cb417-dcf0-4102-1dee-08df1a1bc19a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:11:02.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SeRUR7pH/NBvyB+U7Mc6qXWh8kdU3b9oAdBwVBVCBSJsVSuKAa1QDvHjYUTzimqZh9ULX4eCPCYSQhBCmj+Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9723
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 01:52:15PM -0700, Rick Edgecombe wrote:
>In the early days of TDX it was expected that pages being reclaimed from 
>the TDX module would need any cacheline from their private KeyID alias 
>flushed. The TDX docs describe doing this in a couple cases, for example 
>reclaiming the TDR memory:
>  Flush MODIFIED cache lines: this is required to avoid corruption due to
>  cache line aliasing. Note that all cache lines for all other TD pages
>  must have been flushed before the TDR page was reclaimed.
>
>For a similar reasons as why the CLFLUSH_BEFORE_ALLOC features0 bit was
>never actually set in any TDX module, this flush of the private KeyID
>cachelines turned out to not be needed by the final TDX solution.

The reason isn't clear to me. Is it that the hardware doesn't have the
aliasing problem, or that the TDX module does the flush internally?

I'm asking because the answer should also tell us whether the kernel still
needs to set cache_state_incoherent on every SEAMCALL. Not asking to clean
that up in this series, though.
