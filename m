Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D263793B4;
	Fri, 15 May 2026 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825590; cv=fail; b=CX2TEWssk99GUXyUatzDgHEqX7xk6u0vRguHd85I4fWgxfJwoISu86LSB4x+s3KED6JADU/78j+usZyQMKQLosBhRlSED60RYnXgD0sE4Ne/63NjH0t/gbPj/KszBb8DRzmdsQoccLgxoJDIAc2FXf7XbcD3lxJTobxsBYvYnPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825590; c=relaxed/simple;
	bh=4k2AKLznM17GsGMGXSW7pMq4kkQCi4A5qYsav17tlko=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DG18esIcecvzixxOSG0hrn+p4en3D90jq7awNWxe+U3pSf/FsIZfhAScKvLP1FvIzxy3JaX8Xsve3BO8DN2RKaC95AXBLXXI6f1RNeVHTUFlQheewP5jeHo3xgwBOUvPH45blcpNyEjRdZW/EYNBbJiJV8nBbN+sLFJhws8psc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjCX8+mP; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjCX8+mP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778825589; x=1810361589;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4k2AKLznM17GsGMGXSW7pMq4kkQCi4A5qYsav17tlko=;
  b=kjCX8+mPbBmVnLg3QxVz9batFcyvQ/YxMzQtIv71hUuv6u02mxIeIg7a
   QTSVlgro/VTldPdWGRfktJIikb2VMw/ecUhlDOVjMqQ7vquy9BxTPN9p7
   AwjruZr39vQVoJjCdfukLS+j/j574ozIb98M8KjO1rGtRefbTBXIfvIBr
   uYiRsIcgucJbuTu5UhThpfg0fL2L+06SvuiHAEfMPKDGy2lAZ5h8yp4Xw
   1SyzCM5GY+aiTpTgey9L+mf73CdAL7sYGeTbMRmGsREZgIi6pQsrp4liv
   HW1VSdVMNlHINXXaGK3klX3nnpxs3J7/zg7qPOdCGJDCBN1L2DOepz5MU
   Q==;
X-CSE-ConnectionGUID: BeBurn6TS9+mAbb+efrtTQ==
X-CSE-MsgGUID: G7biHx5OSqeJ8v1AmQ/sjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79807767"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79807767"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:13:08 -0700
X-CSE-ConnectionGUID: xqZJ1rxdR7+uPDppONdTjg==
X-CSE-MsgGUID: YKdHPHsITYWP8u2Wo3wHog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="262129957"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:13:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 23:13:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 23:13:07 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 23:13:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1t5wflGpd5FKf9OWyCMKr/jcUw6VQdK1uwo12fDWpRbT5qUX3txqgey6UMQ1b0DhrCfdJJU92YA+djO4x4npMLCBcj4Y7WdNLOmF7hB55/Ugrayx4PeXt2TCnfwx6RdHkv+nVTwyeG0xpkUbs/SBRnfpulL3Of6LroT1es/efgsTYCVNNvq7ugTog2hpVJS4zd0cAEA70AaKFhYyb3uHfgmwTC+OmbfEhIR6PxEbry/c6/v1LJAeCX2ccxtcWPWfqSl6xgKXD+qsyEojJfGizTQdsqO9J1XZv7Fp2LitESky2q58AEOaW+IDghzyx49ze+QmdD43OxqlYZSM97Wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FG54UdSMlKhOF30lmtGia1b3emhcp1evLMrs5ss5ZEA=;
 b=cygOtM5DLnvtR6Puf6RAxdeq48OiQJpdCQNB4n1dmaBUE5WtlkhHmEeo70lvty6AdBOLKNLcde7CA1/LgImFnGPgSTqiPyxCGV2ESCSJ9KXKE+xslnSJNzG8JSR+JEyRezE03zYsRkbnnjrwA7yHE584E9r47N8H86EI/w4YuUgXI4HWr3w6cQbEa2VkjchoSrli+C36zHBle0egnkST/W1UKOItehFnKKfGz06dWdw9xNMh/fXBYqYS9qVUMM4ffdD1avGkYYeiYVXT2jIn33pbAGYx/TM2rpmLaZN6o6xb0QlPTBWxZ+Nhwkh1M/RooztrF2K2M2JyLzS7ldAs7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by CH3PR11MB7323.namprd11.prod.outlook.com (2603:10b6:610:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.13; Fri, 15 May
 2026 06:12:54 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 06:12:54 +0000
Date: Fri, 15 May 2026 14:12:39 +0800
From: Chao Gao <chao.gao@intel.com>
To: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <binbin.wu@linux.intel.com>, <dave.hansen@linux.intel.com>,
	<djbw@kernel.org>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v9 20/23] x86/virt/tdx: Reject updates during
 compatibility-sensitive operations
Message-ID: <aga5VzEc/H+ys6mw@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-21-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260513151045.1420990-21-chao.gao@intel.com>
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|CH3PR11MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 986e5593-d7ca-4dd6-8119-08deb2490050
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|4143699003|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: hviKevqGT2X30KlWa3PDiVNakl5oOFdUgACie0ZcQz1Wvg7tkURcl/cZhTdxWG7h3b10jdwa5uDWjOCxeXmnUi7UvKjE7t0wOYTvD1nla7pO5SyTdXKC5Mc8CQ/AOdqZhuJhRnffh+Sz5LMrlYVpl9hcAyYhXrjfqksbYf9h6gJ3UXbOkK3GlmrX8Lg/xCitYe4OpJ7w6LaX6C3gzJgR3R5mjKFFFbvKF3GACyMdvtQmWZsDJw7GTmEoT2sdMmie1bxkgzZpql9rvBYp9RjxZYcz6fRc4d/NQl1LiYTEgFXx9wvdzKngSnVCZ12EbNzRb30vTojeUM96wrE5XsPX4ov+MBrHg2IYBI3P9llEpBjdBKsYs5eKRHXJJITuyV4SMn4hCiEOtYCmiaWNZz6niv9NOlJ2cy79U2BAizBbUBCCZOZe+gwTa5UFInEWZ6RlwdUGOcRe72z61yjrzVit/7C8stLBvyNKbFrGf2JvQ8hjtoQfWuVto0X72BAkyG8Y/8IEF6xtEXBZ51y1xjXuReQSSekBOnQmmRQhFa5whWexUB59ZLd3YCaCAvPzFLtvGHVk1yTlS3mUDIg86x5KJZGVOb30fAqry/T67/ikzq+gY9Toq5rV+eYMIXyHmaTufBmnvUN7uE6vQbfuTKLv759SiBXGbwUUN2URa4vl0PfdRhI1ukmJ4aE7cHtsuiT7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(4143699003)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p32WUoU34eQ5eA+A0gMRfyQOFEpMyx7n6UJ6x9QHAGYJEJhmgGKQYcHU7ojn?=
 =?us-ascii?Q?Y1VMkLrjDP3cUUeliGFaHrgFYznqREz3LIA+Skkrl42l9c9Kl9iRSXhKhHff?=
 =?us-ascii?Q?erKEQxs5mA4D69xbTEXHQiPFFPBbyqUayuXSFG9DkZtbOP9pcYipMG5znK8p?=
 =?us-ascii?Q?xwM1d+eDnKD1iMT/OP3omsOEEpb6b+DXIHK7qx/z/c7AyzS/XMHa4QqoNi4E?=
 =?us-ascii?Q?5FGzShrk/71R2yd1MKe94JyJA/JxQiZ6a7jeApN5XJikjF2452zIESNedOH/?=
 =?us-ascii?Q?zw19mHdGBmMCOo9MtukXG/gTq0ZvWC7nUNaRaE6W96seriakwLDDbZrFOfQt?=
 =?us-ascii?Q?kLmBh5Ycy+I5JLXCjnLuSUae97jIfmR8cemV7nuAy904YMHRaUIMgGTEitaS?=
 =?us-ascii?Q?Y2MeZiPYMkuLTErtduYPWBVLlMFPX8PrmflISMyrI2KLqPytwIflwU8FajE5?=
 =?us-ascii?Q?W1cFiiChFwy3V6zEgeekdtkwM0qduFjgE1qDW1guIebQ6rcLOJeLRP7aQv1A?=
 =?us-ascii?Q?r7RxlIgQ1PE0SLQ3Vhm76TmqLi+wx5/megQ4rFsB/M/SySv+aZUAa+cgUZYb?=
 =?us-ascii?Q?15yBKGNmGwB487VG2M/DcZ8hhgM6GNA0mEHUMzJJibs3+e6bR6yGsB8vl7dt?=
 =?us-ascii?Q?RBTW1cNBFYRtJFiKMinRqflg4NqB8jSu605jO4KpVidNftEo2xUWjofvdog1?=
 =?us-ascii?Q?Eyie/BPp0aPWtz7YatbWqsV5beSpRC/piuMMc5KSgOe8ESjdzqCJPvG1JCX1?=
 =?us-ascii?Q?FipdQJN7rx8aHIxxxy9c1H43kgCQ/2MiXnJ3iWLSFNh4QQVwbPuG6iEi5NR2?=
 =?us-ascii?Q?9mo35qjgv5NzHBeJr8al5XPMxrsDlsV8JZRMxjyJZP6djiGUqhv+8v2NRirJ?=
 =?us-ascii?Q?V5bkN0+HkoPm8HX4GXooDRlRDO4MYEB5YTQPSBfHqMjyCS8W2ukCKeK6IMc7?=
 =?us-ascii?Q?leND8lhrFEjwcK2iYdt8hdAvwLgSlRZO1ZnUuS1ztAakRVk7ukj0sixyUN9Q?=
 =?us-ascii?Q?9Q1IqlzGlN4i6Dq0JwlcXVUfnVI5jY9PyCxIcNBg+bmACNPh31W/gJG5ZX/3?=
 =?us-ascii?Q?d0aex3Px/YMvJk+7rnMNfNha8Vo8Ee45HT6B2G58AiVrDFptGG0yquZb2Wk7?=
 =?us-ascii?Q?XL4GKKEBqutDLkj0fUhHxE8y94CfkuErnleGHZtzMPvQAfYCRSdtjg04BzQL?=
 =?us-ascii?Q?IJWcV58kFWmSQlDgBeXWzasBon0vKsZdnOsoef6mXatzWTQz2Od6ZKaJKf7s?=
 =?us-ascii?Q?GuXpUcyrUsEtgkLeaYvxXgfR2/LBkssAmfW4RMQkgnnaWcvqrpxMR+NXrqIi?=
 =?us-ascii?Q?8PJ5dbCn9JFNyg1IppTrTGzIPqiv1juwU5oQOCgwmIXAffWqSplE2Qhrh+m7?=
 =?us-ascii?Q?UevdiJCbUhiOTm4tD7SrDZf2M6pQUKSKrsgZOIPrNvsSjvDfD0zycjssYYU5?=
 =?us-ascii?Q?fLzPGtiJi5LtnL/1GWGORaBUcy9hcEOSO6IYlrOsQNj8+1dl5IKhCncPmRPE?=
 =?us-ascii?Q?pI+ounhtlphp+wIhTIQzoKDsawXDt0fEClKN/82rCjEl7XAt289WbMKR23wE?=
 =?us-ascii?Q?YIp7ZWpXIyOVV01J/e7LxsMYoYyiRa/1x1f6NVQkn4b0+fMDmdrz/4CpwqK1?=
 =?us-ascii?Q?T5cf2jTpnRvuRYUVVeijbqCdxYt5DFraIQQiSHiS0UcSWlqTjt32MZpilXfx?=
 =?us-ascii?Q?Ppdaq8YoujR/BLKhSUhp4oskeS3qEquVt0/5pAlAsyElQDD9BexCMnfNQC3J?=
 =?us-ascii?Q?cYqgD/b/iA=3D=3D?=
X-Exchange-RoutingPolicyChecked: aGLX83k73tfkuoDQ48XOrJFiAFcc2h0S7l3rONK4UOF4dZSgZoWuGuTLF5DpdyAlLrq4KIl1CtpBL926ug8nDBQ8XrQ/HYzZ8edP18WP0JJKmVrKSPxhunLpWKPC1IRJmGliXUrj5UGNv9aXvQqAKq9uHZHEyNtDMcWmsc1sO2YMcDI1tJQOR5bxD2h8CTqAMbNj4kD6UngpyexZYHP9BDRhUgjVoY7rFCyF8vxlM6hxhksJ2CujmPZd1Bbf4rObXXr0wwrDNK/zOor/09mZ3iNls4IDi9lkHMEA5kc2Re2YF3XeGCRz66fNgZHJuVbY+BXzE9q8DZPIitp0F5eiUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 986e5593-d7ca-4dd6-8119-08deb2490050
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:12:54.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGVCTmE2NIiEq1lA9rdxEaUINJo7JzCalg37QHgrlGULvaaFk/xMznNMWB62OHw7Ayq1TWkoQ/kWJtLdF+uf6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7323
X-OriginatorOrg: intel.com

> /* Bit definitions of TDX_FEATURES0 metadata field */
> #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
>+#define TDX_FEATURES0_UPDATE_COMPAT	BIT_ULL(47)

Sashiko pointed out that this definition is currently unused.

We do not pre-check this TDX_FEATURES0 bit. So, I will drop this definition
in the next revision.
