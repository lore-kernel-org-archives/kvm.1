Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCF73CAE76;
	Tue, 14 Apr 2026 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160255; cv=fail; b=rsMPacvfylMQ3z03uoqYnU4wEdg03J4CAF85VdixkX2w5xvB03uy0KFd4rdiArTORWjfkA1le1rZzXmxAaIQV608+EFMF0IBLO1MaZyQ2/7KaW5seCba3Z91YOjAhUdQ8AHc5mZ2AZqaWwP1Ug7CJeWTT/fEpNobWnql32uO+pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160255; c=relaxed/simple;
	bh=KOXKGc3ayHItwYQ/FfWqt9+kdI0cVMiVONFhgX2pjQ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BbJYV8/jvdpmnnCTu5Vqi+/A4MBZlmfOMAeOp8sUDckR2sphtJIbtIReG0hW0uIf4qxr3fHqKoTUrgdf3DDXwR3XiZbd8UxWXTmcNhaOhna+2KlxC++HL1UazyiW6bMTos4EXU2W6nTUXIRmlI5TT6m/wr/3nlK8aMjbGRp1yM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bc3RDZ+7; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bc3RDZ+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776160253; x=1807696253;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KOXKGc3ayHItwYQ/FfWqt9+kdI0cVMiVONFhgX2pjQ0=;
  b=bc3RDZ+7U9kAlQ0xN5XRygqTir8YK1uVYTfGlB2B9XOmjxZ2Mzdb2oQU
   aCdzvrLYdDk1mtrfWLZxW5OHe87hw0bSZfR+tYj+0V1ZfcfRVZyQEPbMJ
   CvKUfz3YoIBnr4P6r9KGup7UckMZ0JjlXasvSjbhBTnYM58e3xDpGegI2
   CW5iseTOuL4vbbdeluGHP9pqu8nSGPA1E5MiaS7yV5euB9Unu2keMPSyV
   H+iRmyDcd8Fu0xqbNokW4+n8jFP2g0U302bRx6qlJIs4fDPR7Z1sCUdLV
   M5LIpHFMJGye3k0M646veaT1/QAUk17EVcDedIZnWQ5VdWRqq9jAJiFMS
   A==;
X-CSE-ConnectionGUID: i9fius8jT6SxxAHUryIGwg==
X-CSE-MsgGUID: kwmt/xOARtKGCnJ7R7xdgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="77293356"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77293356"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:50:53 -0700
X-CSE-ConnectionGUID: 3mB2x/6OSxiBCv939zwItg==
X-CSE-MsgGUID: 2JIzpkNhTh25DKJvBRVZUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234979792"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:50:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 02:50:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 02:50:51 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 02:50:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmUKYdsvl2nSqSYajEcJ2sV+1kfntC4CYY16twg7Lh61Pn0vDagpFD8Nckk7IGQEd9eJ0SpRbx+tS4bC9Eu+e1Lwx8sV/SBUOqZhHK0hB0ZKn55QC58fV/9minX/UNtevn8YTbCXQ/8B4pUWMu3nq59BntTAKNsP01qV8+REk4Dj6TsJlYNBIniG6RvR5eIuZeNkXRiYKDQIVeLMeRNruMjhNsxcKci0/T85N3zf2BKZASNGRc6KEpYs2trw8rag4ercZngx6DvMEatVSieCyOBc1JxwhBF8OB7bR2vZVER12h+Q+QN4PUx9TGALhUK9ze2kJRJNNHS+DNAG6eQfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwHGaEeTZ6CdV4Q045g48UQThz5fK3t4qBgvLOB6Zhg=;
 b=WEJwvsNewlbKX77/CBPvgwO0gzRO+okjKRY/SBMY+fEAGDAqefjDCT30WZ4yQ09fqij1uYdr2mq85EAspvNHQ3NnNWene0N7CsG+POh1so1j/mTXp5yfrhglk2NHP+2xoDSAyydmhZl+aZhcF2UXW1dTSOmYTembDOdVKYJiDLeZGHAP4IRe5PXrZSkx7QHRbTy84CzxE+yxkNr+TKFzb2MM1yUzEF58mVq3bmjgTh5q+4T1WnQKdWkXewKeEY0+Eiaus1zdhYcxk93dWMl/coiRErObX/XwfoVdO2RUiIPBUQP2eD5BCh4g+qUdv7BD+XXH9XNgkhZnIPVf7aUEKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH0PR11MB5781.namprd11.prod.outlook.com (2603:10b6:510:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 09:50:47 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 09:50:46 +0000
Date: Tue, 14 Apr 2026 17:50:34 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 07/22] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
Message-ID: <ad4N6giqSJcnZ/o6@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-8-chao.gao@intel.com>
 <91f8645bff41f5b28bf964b215429b8c7ad53715.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91f8645bff41f5b28bf964b215429b8c7ad53715.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0039.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::10) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH0PR11MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: b623da96-5f6c-4b9d-b63f-08de9a0b4d61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|18096099003|56012099003;
X-Microsoft-Antispam-Message-Info: mmBHNHsRrHcC9Gc84LalR/zM5j8p/3RIxdh/hz6c/X3M8ne2D9AsH9PNXiBPnXLk1x4galAILIq5McZnw3gQsFr95WvEkLLGQkTSWgx7n8Ho++/IsNrrqfHFFXvzSu45Q1jog+FstIJDLTeqotnucg2wGRQ3t+Tb4LubLozWjgH/oGAHU4AsA/cLGOYsfxHMAfO439ag7Sm66ZDpfv5XzCZBF/0NEPVtkqiCmJvQS6p2OMmfqUjFjMT0iYS53v44uO2QWdIvlHffZH+E7uxbJYHj6jwcQYVfkyxbIOmDf2yKZGXBwIyjCEVeVTXwM0DEtESAm5hknu7GQ4YO9jLekybzLCRHm0xhsieLcESftazk7z8uhxb0nzUSswIL+JloUvVsHRI9FsFXoetRKnKcAy2eQwh1X+6wO9Zkr70Yzf4EIp8owWQgENk+TRZLLSApaMcRA9hCJwFzyxLstOABxOnvs9fObhd4jnY6ZTY6FRyhuYDJWLlq6IgshDpbP+2Tk9C7XfGEvAvWYYheOojQ9lHHA7YCys0p3dZYKIeSVWB/zLtyebKNxyAA5c010D3oYjIy6z5Ub2B9nspUkA+9IaV98h/san2wo0KUgu2aIGkj53wFu7WYv+x/PgP+qmwdIRngLzzivuhDvLBcGXvwKmZ6xTuMAXpgQAt9KYeFCkVsLk4lirh91xTUOvHmFoK4ke/6ETv/KB/IJAqlY+Vogl9s+5wTDspQDuwzOaNXYZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(18096099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QNtewSYpLppPMrT+Vb2HvznL50+qjcuCQJi83+szWBlJOOmZdBYJdXFjPz?=
 =?iso-8859-1?Q?fgZHfMvNOJI34+sEMeF/2clxUL/DJZQOcA6YL8PS6CJd2nBb++uCwKbiEY?=
 =?iso-8859-1?Q?ODUPgaaSsceU+X63hYrir2DAYMNuEkjhCq8+dT+6LWpcv5pWIUOIwCBXZ5?=
 =?iso-8859-1?Q?lGeG78UEKnHz5asTtJa1mCy7y3z9uJpploo5H3s0ax/lIRhUabZUZqNtet?=
 =?iso-8859-1?Q?1H0qAfzntp1Bk+G+t+wyOu/GVx8I74znQZqzfp/1T6ey1bgAbzyCZAPoyM?=
 =?iso-8859-1?Q?l/KvtSxQkAlcVA1PsGHNau5Z7HpTdwXvHOOAYaXK2sDTAoyq/EV8giO3v7?=
 =?iso-8859-1?Q?hBEq2ijspiEOSKaIRAbzYhFb7hwDwKxphmwojAwC8wRRAXsfVggNhDt/re?=
 =?iso-8859-1?Q?F1gzOCVRK+Bjaa9dJsf14gxBaer8SvOraiJllnGKdPW3QNUK5SwVHXWjU6?=
 =?iso-8859-1?Q?fspplXdxYND95I9Kl11K9AkvnI7I1n0/q9Ag5xvvoUwxT3CI68vlyuWH65?=
 =?iso-8859-1?Q?eOhHmjm7k/mluog/uMYbtfxXS0Nkz90H6Wpg0MJlhc6A7ZYrriUi1ZB0h8?=
 =?iso-8859-1?Q?Dt5aAb60Y1GVsQ9esqhn/YyrELcQSJWNUen33JSTW05IJ+VHaJhAVnO1ps?=
 =?iso-8859-1?Q?N08+JoPoA2+7LsL2XWyAdXEe/Yng0Ct2CYw3yrhqX5DdUBDPmaWbIkgUym?=
 =?iso-8859-1?Q?iB1dK61SNF6XVP3A9chXvnUCQaf72JZsse81+gaseFPNDWApFFvPX7C7pU?=
 =?iso-8859-1?Q?1U763v+TJRry7HroXM+ULZPCerMsOEK8HMV0M/DrDJz4XSkH/X8K8tcHo5?=
 =?iso-8859-1?Q?PpxgEoDN3/0FszS19mkTLhJsegHX8LjZXWFYHOiAhVEgH+akUQud6lTwN9?=
 =?iso-8859-1?Q?F6PRqW+PN30doWYrtI4R4jvaGSMNsnHysArOBXMZ8UGCGDXUO8LQHemCYq?=
 =?iso-8859-1?Q?81+A3LAAAz0ElIiuO8BeocYCggOvBppgpsiAHxDWAZyTRWxE9kgDq7ZFIF?=
 =?iso-8859-1?Q?FP2pbeNGq5rC6O0NGL0e9uU2tz05QdiOazmx1wlLUhsQUTyxBDAsQZVn2G?=
 =?iso-8859-1?Q?rOfetrGB0zSU9X/78ys/duvqo+QHxmHubeeZ3bbTGh8/fKxNbbnI8Ghkcd?=
 =?iso-8859-1?Q?3CM/XUxTEV5s1L1eYa6+FkKgp29yDm3wiLYGx1425r8soVBCz8g5xHTByy?=
 =?iso-8859-1?Q?PeTxKe0oFEeeMtRiUtl1N/ygPbfeDRTgKASyk+9WoLYMZMHW41Po2IzSbJ?=
 =?iso-8859-1?Q?1Du12vMhbU3He4ktIUP2h2JBAJuooldNDUW6AJMHOC4i8m81RB6OG4CgYw?=
 =?iso-8859-1?Q?mbinviVOAlMF9GjizLrJ9BGRKDCZnqJgFgW+cbHhKHQ/4+dsGiWaAs3TAF?=
 =?iso-8859-1?Q?GLGiYBf93LUQfvFVA+wNYUs6LH+pNzlL6RbO16y6andakyfy89/RUIY9tF?=
 =?iso-8859-1?Q?werm1t02oAtm6rX1216aEHb1nbiUr0wPnvPyllFSR4NHu9A/1XVqQSPqar?=
 =?iso-8859-1?Q?lxPc1kzh4YG6DWZPnp8rmBMXuPoURR59xVjV8L7EvXyligdkP2o2clbjTR?=
 =?iso-8859-1?Q?TWzLF3oqD7Cn6VVXf2OCLsH/oh5yTSHyt+US5IUQ04AxhbO6X4thBqjbs+?=
 =?iso-8859-1?Q?NIuqeI0Vjv+FiRaE4AcgyzohDU75dsPJ+eueiim/ksVANwPQquujgFmnZt?=
 =?iso-8859-1?Q?YjNlD3k5Si9kbxPN8xTsE2glBuLaIdfjxa6g4TKOqP3AUh4jVfue0GpnSb?=
 =?iso-8859-1?Q?ylg4Os0//hPhniBAWEep6Ux4Zu4rhbsw8vW4rf9629Lb8cutNYRY4yI9/O?=
 =?iso-8859-1?Q?LF3NXp02vA=3D=3D?=
X-Exchange-RoutingPolicyChecked: Qe6VAzcsIrehx568Ju3zd95OnxBlfyBaEP6FvseM/tCuG3cMIlObOiFqnmJeWu3HYOGKLs+Kn70r+lWhfjNqD753G5u8RrURU5IUOVqLkb/oX5m8d+yVj2VTInm3j7GPXSIi7Ctf/OOO/O4TMPmmyOfJJ7z06lgIikVu6FEBA0L/T9Q07McOCWrVOvYn/bAW4nCJHjJyefrKTUW02V9/X/KA/rpUiROTv9k5nVMMv2FhV+GCZZg5NPKYMrrQhz7NE/2SjBoeW622aEp/ms7fvJ0fwAAcuipEKUU+8Gzzo4zg/pmbZyJhyVjUZd+HJI5FAoc6wiiBylSkYsL/uBfcnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b623da96-5f6c-4b9d-b63f-08de9a0b4d61
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 09:50:46.8729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /707e04XSYeqStao26PdKm53c3oKlBn9pTN8Cblv1peinpVrmDwCWfxCO318415gMY5MnbCdAJ4WMUy28Ckaew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5781
X-OriginatorOrg: intel.com

On Sat, Apr 11, 2026 at 08:26:23AM +0800, Edgecombe, Rick P wrote:
>On Tue, 2026-03-31 at 05:41 -0700, Chao Gao wrote:
>> +static enum fw_upload_err tdx_fw_write(struct fw_upload *fwl, const u8 *data,
>> +				       u32 offset, u32 size, u32 *written)
>> +{
>> +	int ret;
>> +
>> +	/*
>> +	 * tdx_fw_write() always processes all data on the first call with
>> +	 * offset == 0. Since it never returns partial success (it either
>> +	 * succeeds completely or fails), there is no subsequent call with
>> +	 * non-zero offsets.
>> +	 */
>> +	WARN_ON_ONCE(offset);
>> +	ret = seamldr_install_module(data, size);
>> +	switch (ret) {
>> +	case 0:
>> +		*written = size;
>> +		return FW_UPLOAD_ERR_NONE;
>> +	case -EBUSY:
>> +		return FW_UPLOAD_ERR_BUSY;
>> +	case -EIO:
>> +		return FW_UPLOAD_ERR_HW_ERROR;
>> +	case -ENOMEM:
>> +		return FW_UPLOAD_ERR_RW_ERROR;
>> +	default:
>> +		return FW_UPLOAD_ERR_FW_INVALID;
>
>It's hard to review whether these error codes match because the function doesn't
>return them yet. Why isn't this patch just done later in the series after
>everything is in place?

Good point.

The series is ordered top-down (user interface first, implementation details
later). I could either move this patch later, or add each error mapping in the
patch that introduces the corresponding return value. I'd prefer the latter to
keep the top-down ordering. Would that work for you?
