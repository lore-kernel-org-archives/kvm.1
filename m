Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E333164BA;
	Fri,  9 Oct 2026 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535288; cv=fail; b=h8UlwBLYyVLja8gy+XLxWTmyWTepjF2fXWtci3TlVxKGqr1QCiCEHkajiNAV4+MITvwhNwSie4x8ydURzGz30oHGw9XENZ6iZtT9IKccHhw219EOOYC15Er9R5HWiEysQr0HOk/vUONRXP7QVwtbOA1AxLPNSezJGLggoVt9iC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535288; c=relaxed/simple;
	bh=nja8UWkS+HUxuDWMl7ySOnMS1XMO4ss/3RQMYAy5ci0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=td6Bu4n9Cm/vWlMBpyd0PLgIXFjqospQsAok1KyVQ5vKFKT685c7vkVCVUyxoUZXb9PPvoOWG/eak1bZjgjwZXv2Y9tURgcMCJHbaQ4BgftTeigUyiLHZQ9dPNnMENofZEa1aMqCWVmnAZnhI5iQGue5ahl5iScY5RJQRBOKld0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JuLswnxx; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JuLswnxx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791535287; x=1823071287;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=nja8UWkS+HUxuDWMl7ySOnMS1XMO4ss/3RQMYAy5ci0=;
  b=JuLswnxxjmoaxUpKCxqiF+gBOMIKgWwC/RbtKRcJCcOwmKuA/QFd4bOC
   bILtmRIcwoe4lgKXNGmRSMj1BNDIfVz8NMKAbYy1YMNzOz559UuRKhGNI
   vQyPARNuY7GGbx7ydmaw7zok05NrGNwF4AITk02841EzM5wE7LIN7r+sl
   v9HPu524VX4nqcQDsEhFroT62nEnvU/y3490kbCw0o3ideHmbekfgBVgV
   oTWaYYuLy7+n6A6r7ow+6j5t7f/wlN8ix0Q/oxYjv7+vTFkkpe8nCLVu7
   8Raa86LPKdOyutH5ZDdxWqWfB0m6j8CO1yiX9I2xiwOL1TEDxgrzgXF8e
   w==;
X-CSE-ConnectionGUID: 2GmvNHclReirw/SELj010g==
X-CSE-MsgGUID: PudkI6UNQWa1oxiZkEmwbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="214963"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="214963"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 01:41:26 -0700
X-CSE-ConnectionGUID: OMspFKGoTCaZfAy5xeRDlw==
X-CSE-MsgGUID: KcoFR+wbR4S3NLlWda0iGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="713617"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 01:41:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 01:41:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 01:41:25 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 01:41:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjQhbwYiO8gWqdm5hJZxWMtFB6bcHbflFy1qde23TzHxMQnBnHyFbeKjc3P4Wh0fmeTYb8hEkVX3wZ25bc01O018+gUmO93EaU0+2QKGsf5S2y+FUHOnrUFbaOlXsu+sIvVFVIdBz5ifO/eiPqmfIfCx3D/K98S5ky+xlk3Z+lBW/0pJSmYGP+cMjwAq3j+psrt9yLqvmJQ+/zExqk5LUoxk0LV1KRVqkOENmaoQXm4E+xMcXCPHoMju0Uw6S1WXWFB/m1aY4yJTzEVJNLpm3kefqbolffCyBHxAaNy8Qwv22ocbaEIY8t4ipCWFCwmu7uARiFlR98R1wcIZUpK7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMvL/PmfNq9WgcuetwRLwwNANFFkW2UZbF52jNEF/kE=;
 b=LVoHsSoEnvJIayBFXbbOkohELNRgA0x1xaHvoa7SCOFr94ryaa1iIZJjZHl3PU2s8e4ry/3XgcaAKoEi8j0K9sEue54xONX/hYB2A3pa5SlCJEyX7Fv+9ZnIGTy4eCX4Zf/fpEFc0sguFTi0zqWX3vQAxlfoGSUXAezy39QjRa387dY1nuJuJ7bwLPnJGAWbR25epfDPWLHa6oSrga2rNuluLGyzRDma+mhizUYTNpIQwCGWbanncyhic7PUJXdSdFDReorGlnfTBLXoYDRjWo18XckYGwmG+djAVqCB+KD02AltCRfmwOPFBuE6fxyPFYhQgBU08BfqKrvS2CxwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by LV2PR11MB121525.namprd11.prod.outlook.com (2603:10b6:408:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 08:40:51 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 08:40:51 +0000
Date: Fri, 9 Oct 2026 16:39:59 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Message-ID: <asioX9gKIZBe0NF6@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928091035.15599-1-yan.y.zhao@intel.com>
 <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0053.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::8)
 To BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|LV2PR11MB121525:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d5f2f5-0eb4-434c-c03a-08df25e10614
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|4143699003|56012099006|11063799006|5023799004|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: B+bD8HmjN3KbRzg+QYNO7d5zicYaqonN/apTJwei3PJCMG+EAOYoDESGJnFlMvRZKUnj9128nhISvGcTvC6Bz0wpA/CBVMnySyTCw+Kl3v1jsqupCHC9tFxePFjqiixkDnbToyH6YHuKbK2LVXz/QNdYGNkalDYN2G383naCTpOcfYJVg9Q2m/84zlCF93CMqCEX+73tM0mn7xH6GcgVKifC46ibAePunanbC3DHxrXV5asBbdIGar2W1CHE1pPH9fNMrZdprjsVFcqlJLRw7Sso3TfNLl1Kr0rwiLIIsIJ+NHuUMG995cSJsLBbxA7NnVJLqoLZNaA5CEem6CAkawTIVza5fvLK+GQfe0fktTCYzK8RcxUUpANdGBhLsYSDnaT8VYsw1C6L6ZC31G3aVJgmimUs0ZOAAA7zWF3zrzszboyPdlm7uJFeSzg4bzqi46CS8D17x6ZaGTz1GELVUwx1llzhI1LTUnVYzfDFEyXv9F3tj2EzopyfUYNGcvzJ/Z9j0ev3P50Abgo+eShbpoIBhSfagBX4SX6Vh/B1WSKurnzEQ9MgPVVyK/LLgfoRmwVWAHp+uCNO5Q88iUQwWQTKPDMKAYRwv3514znvgJc9O4/Rr6dxp+uEIHrOzvd1li62me/aorkVOs4Rpaho7s+yEfEFw9SxdDLzgPUGn3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(4143699003)(56012099006)(11063799006)(5023799004)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xcc8UYIskJaPIUU2NN5O4AcxoIunK7x6nbuesGmJ0O6q0ULpLJqphMt7yTCe?=
 =?us-ascii?Q?yXBvmW32tOvuJgqyedZdW99r0U/G7cULTPDymAvahOOtk8Eh/cJe7giSAC3O?=
 =?us-ascii?Q?ujhkryYkBsO11Bx8ODQqnlJ5ysDVH3zXcDWT/844+1WaQMB2LaxZ5c8ZhhSs?=
 =?us-ascii?Q?LLpYHeJZXHLg1ebOg65i5CA3tKc1pOhA4tI0R5coc0rTHjBfalpdVLJ5IotP?=
 =?us-ascii?Q?3zKkYnJ0DXpN9tuF+0mZlBqPr+DWNTUriif6WsO20e02IgJmx9vJViQ/QZ9S?=
 =?us-ascii?Q?QhTACxeR3ynXAudyT+kpTtwkyzfx+onLuGBscCJPIkw7N7LpBclvgqjWeCEn?=
 =?us-ascii?Q?1Z+EXyRna/MhQWjfHjm0h9oaiWpTamcb326Y8SFY9KCCndQ2eVepxI36sbKJ?=
 =?us-ascii?Q?5uTJaCRLnjZBlnBwBqKrhmWHOcarKV9toMAL6ZfCLvlVLkdI3c1gw4fB+Iju?=
 =?us-ascii?Q?gCDOe8uoyemjEgHJjWnLSoPR2K/jAanPokNjTc6srPTkhWBtemNct/obsZ9E?=
 =?us-ascii?Q?KCx5t976V6/L+wpVoKTblgTzkQ6nQ1AJJp0jkj/B22t/Q99/u9KuUf48ZYKu?=
 =?us-ascii?Q?rpzC2qMgfrk1/A2nMLkoaEy8hDt/SQJ52vfCFt0mz5JWYlD+9qO5cF/6eE2N?=
 =?us-ascii?Q?8bSoFR0hMuw5e8Mab7P3PC1RgXJ5MZzn+rWx8AzVdHlmyqHFyDTH9ZW2hpIu?=
 =?us-ascii?Q?0EAhbCrxO1quC29sffTszlgrLbeRjLpErjF66Wb4FboLi40JE5aN+mS0WlOS?=
 =?us-ascii?Q?zH1VO8Fc0hUfybjP58xTip3TQHfnO59SPU20w8FEMXj3Cd7Nufy9EG2+ucUq?=
 =?us-ascii?Q?7SZTRtNZr9/RH29bQ43NGE13g9TQd3GjsSP8zTf7ZrW0gty6SnVBiGKsEk2D?=
 =?us-ascii?Q?ezTJAOYsDiiM9qUWNnDC2qlXF13a6XBBvZwnlkv+VOYWdK7gEhsaPqPTW3E2?=
 =?us-ascii?Q?rSgm2FMq6iM+X3FP0Rrtw8b69Bv3+fDYqw2Ko+L2nJb4Kk0U8HQkFFMlUNnW?=
 =?us-ascii?Q?/v19MpyHAWnEwfXblxjMGWUL7NVxr2PMmjyxxf+oFYjbfrKIxst6y+zbs79o?=
 =?us-ascii?Q?UMDKu0tRgsMw0nJCr6xqz8gML9YtZCC3P9Hbwy5wE0shFlDwgbX+1V+rxKAI?=
 =?us-ascii?Q?cCwH1EO04U+v9xvq0LavFIGatGJxgox//PAJbZZ+Nd5xM1FOdSfjLRHSpMnX?=
 =?us-ascii?Q?TekvG1kkCuzi/B9vYvnqJ9YrbO83uutO/O1d1Pk/MouCZZ7wBTd5TYIJAbF5?=
 =?us-ascii?Q?dLegYs6imeDuw8noIX3SF418V5ZCL/NzJNpNdrOZeOri+yGsYyjRmJ5tIDgf?=
 =?us-ascii?Q?jlykOn+uG4iKVwfkrgN8OrrWJThHlev5mIAV3uAjrJ+0rgmKLoshmilf3Pjg?=
 =?us-ascii?Q?GrrsUqpq7/v6g9Ba3tkjH0RfY549186T8CXb3I8tIRfQ4SZNzD99Ai+DYXef?=
 =?us-ascii?Q?vIkIvFHU1GY7RkQtiDw6b1/UKZmZ/AukPUfRm7+Ts3o/o1d9yiKjOTSr5RSR?=
 =?us-ascii?Q?OohQVf7th4jNi/gB1qQxsy0ynaB0NZ8oHFsiFK9I+q6qhGxgM8eBrFLHyZ99?=
 =?us-ascii?Q?m1pqLqEzOVQyay3bTjTa4NuPOC5k38HuVlAhdTH1W6zwi3sc8Y3jRM5x7uhg?=
 =?us-ascii?Q?tnbPS65uFjRMxa1iL/Z9gf689pZmsp5nx3vjKyh0HXW+7QnIWFJ5NUzWeSig?=
 =?us-ascii?Q?+m9gmjyT8cI6+poVd0W2YoRC2Qn9pTcetDVjflYMbGFuaHr17K7w8v+NjNBB?=
 =?us-ascii?Q?kENq+1kClA=3D=3D?=
X-Exchange-RoutingPolicyChecked: XFtyfT73NyU2jwjeKQnV5JO9ky9sr5PfkouG4mZs+mJMbl5A3BFlB5i7QaD2sPUCwcytPUruFf3ngcJ7imx1gFcNcG9uZjSVqcotkXLjmcSVeVJ6SYem6rHZACmqG/obqBGyqjmfmFmV9QRqZfrf1n2P8wsLWMzWj8PZGpzkRj7yHyFBp6mecoxG61z1TfaRcpBHrVotCrGduAeh0xMtQLfnS/fCmZy1fONSyrBzlzvgRWlvKjHQcJJTfanYeXMRdLGebgaQnCEZ/93GFoPBg7QeNNN+c41OOpAiNoEtIfqvvYJwyngDcHQTryFaMxoFrikkcBGvBfpq4zvgbbXSyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d5f2f5-0eb4-434c-c03a-08df25e10614
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 08:40:51.1756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmbjInIJw1/OofNU83YtX5paUI6n6460V1813uZ0dIWDpnhabmVkyXN287Br4+gv45riSP/EKLR2lmnwAcP96A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB121525
X-OriginatorOrg: intel.com

On Thu, Oct 08, 2026 at 06:48:00AM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 17:10 +0800, Yan Zhao wrote:
> > KVM needs to allocate enough DPAMT page pairs in the pamt_cache for
> > consumption by both page table pages and guest pages. Since the DPAMT page
> > pair for the S-EPT root page is already allocated during TD initialization,
> > there is no need to allocate the DPAMT page pair for the S-EPT root page.
> > Therefore, previously the DPAMT page pairs required equals
> > "min_nr_spts - 1 + 1".
> > 
> > When splitting S-EPT, min_nr_spts does not include the root SPT. So, limit
> > the -1 calculation to when min_nr_spts equals root_level, though this will
> > cause one pair over-allocation in the normal page fault path because
> > PT64_ROOT_MAX_LEVEL is always passed even when launching a 4-level TD.
> > 
> > Additionally, KVM may need to retry tdh_mem_page_demote() a second time,
> > causing the DPAMT page pair for the guest private pages to be drawn from
> > the pamt_cache twice in the worst case. Therefore, add an extra +1 to cover
> > this worst-case scenario.
> > 
> > The slight over-allocation is acceptable since KVM already pre-allocates
> > more pages than needed (e.g., when mapping huge pages) in case of the
> > worst-case scenario.
> 
> This is assumes way too much about the callers and way too convoluted. The
> existing code already did but, now this is just too far. We need another
> solution.
> 
> Questions below on what that might be.
Thanks for the review!


> > 
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  arch/x86/kvm/vmx/tdx.c | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > index 3186c4808cae..397a308b834c 100644
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -1630,16 +1630,34 @@ void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int pgd_level)
> >  
> >  static int tdx_topup_external_pamt_cache(struct kvm_vcpu *vcpu, int min_nr_spts)
> >  {
> > +	int dpamt_pairs;
> > +
> >  	if (WARN_ON_ONCE(!vcpu))
> >  		return -EIO;
> >  
> > +	/* Exclude the root SPT, as its DPAMT page pair is already installed */
> > +	if (min_nr_spts == vcpu->kvm->arch.mirror_root_level)
> > +		min_nr_spts -= 1;
> 
> Over allocating a bit is not the end of the world...
Before this patch, dpamt_pairs = min_nr_spts - 1 + 1.
However, when min_nr_spts is 1, the correct dpamt_pairs should be 2 instead of 1
(in the case when DEMOTE does not fail).
i.e., without this change, we would allocate 1 less page, which is a bug.

> > +
> > +	/*
> > +	 * Each S-EPT page table page + 4KB guest private page needs a pair of
> > +	 * DPAMT pages.
> > +	 */
> > +	dpamt_pairs = min_nr_spts + 1;
> > +
> >  	/*
> > -	 * Minus one page to exclude the root SPT, but plus one page for a
> > -	 * possible 4KB private mapping.
> > +	 * After each topup, KVM may invoke DEMOTE at most twice.
> > 
> 
> Why twice? You mean the BUSY retry attempt, right? If you do, couldn't we fix
> this problem within tdh_mem_page_demote()?
In tdh_mem_page_demote(), dpamt_pages are allocated from pamt_cache before
invoking the SEAMCALL, and freed after the SEAMCALL fails.
So, if KVM retries on the BUSY error for at most twice, an extra pair of
dpamt_pages are allocated from the pamt_cache.

If we want to fix this problem within tdh_mem_page_demote(), one possible
solution is to re-insert the dpamt_pages back to the pamt_cache list.

e.g., add the following diff to patch 2.

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 964739c5687b..e945885d5898 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -87,6 +87,7 @@ static DEFINE_RAW_SPINLOCK(sysinit_lock);

 static int alloc_pamt_array(struct page **pamt_pages, struct tdx_pamt_cache *cache);
 static void free_pamt_array(struct page **pamt_pages);
+static void reinsert_pamt_array(struct tdx_pamt_cache *cache, struct page **pamt_pages);

 /*
  * Do the module global initialization once and return its result.
@@ -1904,7 +1905,7 @@ u64 tdh_mem_page_demote(struct tdx_td *td, u64 gpa, enum pg_level level, kvm_pfn

 out_free:
        spin_unlock(&dpamt_lock);
-       free_pamt_array(dpamt_pages);
+       reinsert_pamt_array(pamt_cache, dpamt_pages);
        return ret;
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_mem_page_demote);
@@ -2146,6 +2147,24 @@ static void free_pamt_array(struct page **pamt_pages)
        }
 }

+static void reinsert_pamt_array(struct tdx_pamt_cache *cache, struct page **pamt_pages)
+{
+       int i;
+
+       if (!cache)
+               return;
+
+       for (i = 0; i < TDX_DPAMT_ENTRY_PAGE_CNT; i++) {
+               /*
+                * Reset pages unconditionally to cover cases
+                * where they were passed to the TDX module.
+                */
+               tdx_quirk_reset_paddr(page_to_phys(pamt_pages[i]), PAGE_SIZE);
+
+               list_add(&pamt_pages[i]->lru, &cache->page_list);
+               cache->cnt++;
+       }
+}
 /* Helper for building DPAMT seamcall() arguments. */
 static u64 pamt_2mb_arg(kvm_pfn_t pfn)
 {

Reinsertion should be locklessly safe since the pamt_cache is either per-vCPU or
protected by the caller when it's per-VM.

> >  The first
> > +	 * DEMOTE invocation draws two pairs of pages from the cache: one for
> > +	 * the S-EPT page table page and one for the guest private memory.
> > +	 * Since these pages are not returned to the cache, the second DEMOTE
> > +	 * invocation still needs to consume one additional pair for the guest
> > +	 * private memory (the pair for the S-EPT page table page is reused for
> > +	 * the 2nd invocation).
> > 
> > 
> > 
> 
> Another idea, change the op to be:
> int topup_external_cache(struct kvm_vcpu *vcpu, bool root, bool private_page,
> int min_nr_spts);
> 
> Normal topup can set:
> root=true
> private_page=true
> min_nr_spts = PT64_ROOT_MAX_LEVEL - 1
> 
> Then we can calculate exactly what we need. And even better, the existing code
> won't nee a comment to explain the weirdness.
The existing code looks like this:
static int tdx_topup_external_pamt_cache(struct kvm_vcpu *vcpu, int min_nr_spts)
{
        /*
         * Minus one page to exclude the root SPT, but plus one page for a
         * possible 4KB private mapping.
         */
        min_nr_spts += -1 + 1;

        return tdx_topup_pamt_cache(&to_tdx(vcpu)->pamt_cache, min_nr_spts);
}

If we agree on the reinserting solution for DEMOTE, then
tdx_topup_external_pamt_cache() could look like this:

static int tdx_topup_external_pamt_cache(struct kvm *kvm, struct kvm_vcpu *vcpu,
                                         int min_nr_spts)
{
        struct tdx_pamt_cache *pamt_cache;
        int dpamt_pairs;

        pamt_cache = tdx_get_pamt_cache(kvm, vcpu);
        if (!pamt_cache)
                return -EIO;

        /* Exclude the root SPT, as its DPAMT page pair is already installed */
        if (min_nr_spts == kvm->arch.mirror_root_level)
                min_nr_spts -= 1;

        /*
         * Each S-EPT page table page + 4KB guest private page needs a pair of
         * DPAMT pages.
         */
        dpamt_pairs = min_nr_spts + 1;

        return tdx_topup_pamt_cache(pamt_cache, dpamt_pairs);
}

IMHO, it's clearer than having the caller indicate whether it's root or not.

> >  Increase the topup count to account for this
> > +	 * worst-case scenario.
> >  	 */
> > -	min_nr_spts += -1 + 1;
> > +	dpamt_pairs += 1;
> >  
> > -	return tdx_topup_pamt_cache(&to_tdx(vcpu)->pamt_cache, min_nr_spts);
> > +	return tdx_topup_pamt_cache(&to_tdx(vcpu)->pamt_cache, dpamt_pairs);
> >  }
> >  
> >  static int tdx_mem_page_add(struct kvm *kvm, gfn_t gfn, enum pg_level level,
> 
