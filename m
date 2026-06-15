Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1DD305666;
	Mon, 15 Jun 2026 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547296; cv=fail; b=MUfQ6+Wnwt01wSZYgu2jM3Bhqib9CKrEfyBRnRW/VMEcmiLmY0zOWH/I7bXpEPCep9alzepD5xBV84VqJRym+B2hoR5+qgbXFh/tX0MZy2NLbrVGCGoO7MrNmyn8P3h0asqY2J2RSl3sWdaxCBD9AW3OKA9NimGkyr+Jlbdc+X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547296; c=relaxed/simple;
	bh=XX0vxOpL4HytCpcaAse1Fsv3hcvFs5LPN+CGX27s9Xo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GI/79xy+qJd0lOcvdL/x81ST6rRZoJ4mxHmYyDmeB/ApbwaO5aa02pLehO1THudVfHaVjx2ppT9pTZtlczqmzqucKF8KrkVEwSUCZ277YHhTIASLHrHTogth+hSfZv1Wha9ioYcA8Nf9wG9uY2LGy85/o8gD9FC/Yy4WfC0z1vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcvFQGi/; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcvFQGi/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781547295; x=1813083295;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XX0vxOpL4HytCpcaAse1Fsv3hcvFs5LPN+CGX27s9Xo=;
  b=WcvFQGi/AH7MbbVZzxX7UOu2rh2tDCaowd+uwQr4qiq4AJmXideaJcTy
   jt7KKuvUg8fIu9itOw2XqQS8/xOblccHx7vzfjBkYmVQ0JMFqpkkHS5xq
   LWd85W6xNuXIZoVdLJyh8PPlXo51ndckT7V2XA8aK8soVyDCVL0d4oDyD
   gt1GPRb1Hn6BWaWWoIMgbmPB9DKDR8+GeIKj7x2KZx7dpah6wgTkoB7BU
   zQ8sSec9DyW2XLMlbVYO298cgpKxbc4vA1cW6hFgqj8C08M2hbMRjO8f9
   Ze7oBHAY1iye/bDL0JHsI9rJxXk7x+l9AFYBuYlE+By9HjDaYB8klSoTY
   Q==;
X-CSE-ConnectionGUID: zGqO7qyzRSOa0OVfWKkJag==
X-CSE-MsgGUID: dg0KfMC9SgSzcBwmrsxpAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="84861472"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="84861472"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 11:14:54 -0700
X-CSE-ConnectionGUID: wIh8VGPWSzW83a/2lHNFTA==
X-CSE-MsgGUID: uouuL4cHQAOzNTqOt6oomw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="277732357"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 11:14:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 11:14:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 11:14:54 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.45)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 11:14:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQCIv/Suqlfi01zhm7+nEET0T/DWddOV6M83oHqesyC4qEDAhvKGtY2jpcU7lQQMkzqQdHmZsQTprkEFonIMcwaG9vkPXmw/CdMqLYcSngzMnttbm8WMQrpDLnYPDI3taof8K/c5pXVX66xwKc5uoMzZMrd+60xGkJwJDTKpAOeNVn9gNeIiUJ/A8Z70Ygk+dBipu1kvSyQNQ6S6q80X2caDImz71MdEECLHFRqwOuH8v8DBWGMKd82D7HqGu5kcPVxCI+Y2GBtBFcydxsPQt8SXiJLRSW2+h1BjxjBTnXj8HAHjoDyGS9iswxnVjR64abvmSboUv0VicACbqUCkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1UfOHIBRaqawsMBHYeR5MFumh/stz2Y+1iveCx5/lU=;
 b=KUzqOT2a5/zGTr/PWjn6ZwU7BzT6yrpRrMTSd7MiiRJAQVEhulnevErTKxwEMeLWpV+DQIsM/ygVkjSNoTjdqt6Qlda6vFtYZj69d6/cJCdgt1dl72aQNOfpTdZTiCdx+3KEoQxXy7JCYf+FgHBP+H2hqvbOy15+v6EJKDXtFt+CBzY4w5CeG+EIks1ovQJbSwZ95ir3t/aUaSWq0sYxRYlLU2v1H0B51wlBxZRwhki/e+o6mf6oXeGQxCPkST3fo2T2qeUBq9K4pPwyMS6ZHcg9Iuu861sQSZxRQVAnoqBJuaMTXT6ekXExUGTY1NfoD6ZBdhuKbkAv1Ujly5hNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 18:14:51 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 18:14:51 +0000
Date: Mon, 15 Jun 2026 11:14:42 -0700
From: Peter Fang <peter.fang@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH 13/15] KVM: TDX: Support event-notify interrupts only
 with userspace quoting
Message-ID: <20260615181442.GA3519635@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-14-yilun.xu@linux.intel.com>
 <7090f4af-3a6d-40fd-82ab-0ba6272534dd@intel.com>
 <20260614125750.GB3425618@pedri>
 <2ae7d9a9-11da-40dd-a11d-b9e1bf111e1b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2ae7d9a9-11da-40dd-a11d-b9e1bf111e1b@intel.com>
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|PH7PR11MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a361dab-20d5-437f-3ac1-08decb09fe1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|3023799007|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 88ltD+M8oezyEc81ISRoVJrQdtMdX0VOfQz2dh110IhpnLqOL4xn8cOo4nyZ+wCRsbpXRX8o3JHo+o5yes9bfwuxVIAzlu8AgdpNfmVljSQPAhNKvlGjYzv+9Duvvb2Cnfd4mb2ZSRJyWj76GlZ5RwzjLMo1vyNxub1e7vFU6ctQT+l1dwigRSzoZew/fQEnFrcsSUK1NEb3s0WSWhiLJTBlQTOPOgXBlWqAXx7aSFPdKkVZJO8uDdhdHoxu66CmWEvzEvf8csBtOgL5bNo3ecWpPTRj3sVQDwWwDV3YLUhT0uzzby6Rr2azY/iEIdhqqRRnuZz/kLhRTxSO8tmnzok4CAiMcaHPKV69QmniRAcpPTZmAQjNgLebJGc4zLA/1Q1JeQ7RXaIq27Ysg1y9p6NreodpdwuXGGEhHb0UbmNUMG4Zcrk5Too7u3DyiHo5pZRprdI9iLsraky/txcPGQQsM4LeLmo4n20z50uvel3Ilxvf5RicBfkgAxzJF5SBFqM3WE0B7KDq8yjlDkXtf/iopJ4gBxKH/EITHR9hB0pIRTF5Svnwf9E41DFZquH4ihwJJ8xP+0QFJNhRCtoj/r8nsO4Rp+ZiVK2fH6by3Yg396AKgb5TkpPOj9El++o7mmFZr1XsjEM1W9Nf8BTTVtCt3E0DyE9xtmu4waT+Xyx2tKS+P3dNvwxkVvD5cwAz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(3023799007)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3WB6LdKvypw0aBtm2CMifqMVuUYIbpXG3KQS4zsKFTDA3TO90sEXldVWFCQr?=
 =?us-ascii?Q?tfLiP0957ZVFDb9yyRVo3R868iBfREzDASVgcCdiS5AsIj01uh0bOYEProhd?=
 =?us-ascii?Q?SFIREXCb4+x3qQr3oRXu9iDQH8sC49+Uj+i7fgsWllw0eoa2+5fx8OxtoDP4?=
 =?us-ascii?Q?XFiSqQeJ3VQZUx7EWnQG+iYOlfFK1j+TBatrtpujxC4GH7GidNuRffL4CVkI?=
 =?us-ascii?Q?f6RD+VLzBTZUyyVhHRXuGiJ2wOGWg2kqPew/zI1Kkm2oU0EJNJG8vuBhwR+/?=
 =?us-ascii?Q?J1XF0CvmARggd4d4CoEVgUpSx69PUSpRUzSn5W+71SdICw3vw8PJ339FwKB0?=
 =?us-ascii?Q?wGtjXurjIQ4RhP1rysAWyYosMWKNe3Jc5482xsebOXAbk5woZCp1N+9HPxiJ?=
 =?us-ascii?Q?XwT8jS+jX6NhypTDS88b0gi+VzKGxTO/4R6d1OVndpJOOSKD9dY9D9I/MmsM?=
 =?us-ascii?Q?AozpValICdWKSaF1S7Ai9nsrlF/46jIfgkdZ1jGxApD4scbrv6arSHKBRfLG?=
 =?us-ascii?Q?WsQIPyjk3hSwAEF/t5i1nUyUx7rMKnjFwnYCa4pmZteX3nrNfCo4/KsfCZ7G?=
 =?us-ascii?Q?5mLcXCpXqyUyDc/p9UdhqAaD962t4HMPT/qqsUI7WeTWbpBS4nI6BdoqpDoj?=
 =?us-ascii?Q?NJVmQbkksu51BVnvhSiMbiKQAeM+4iNKrQMpM4h/55lXvxhxRC3JuseCUG9w?=
 =?us-ascii?Q?cU4LJbhFs4b6niB05DNuEd16RsDbVf1I6Eqt0h62zvP6rQdzD0NITJjr27mZ?=
 =?us-ascii?Q?8ix05RANNK061HknZJgqRSFMoXJhIfWOcxGY5uiYp/bkMtaZYD78lI+2SuVm?=
 =?us-ascii?Q?+3myYt1lo8HQbqspZvcqIA8QTBqhM770RIwLaGzy11nSYyDwgT+mipqJWmW5?=
 =?us-ascii?Q?AL23NXKmpBqPqHr+q6MoRaYFvpRSS932ngIJI2BGDd9oI6+gisOY+/ZmXjpq?=
 =?us-ascii?Q?7r8/tygHn6uuqmWPolt0Ydvz0WZPqdhOkaIt5TCYCV8L2VL2UgSlWg87/KTz?=
 =?us-ascii?Q?sh7E7ZJlgk41jDK95Pr0Jkkb/Uah8fEqGOplyoQpFOlIFJELFv5SCzK/sc6H?=
 =?us-ascii?Q?ZL1SfLz1KAlOKv0nNkHkH46n+KRRke1uONxwIO0t6uqyZaS0i/GP3mUP0Ujr?=
 =?us-ascii?Q?WxFnUStWyCMfNpHGmHRacDXFBt8rX0Zf3ivYKLUEaLfxAvCQuiC+DcCnHLNH?=
 =?us-ascii?Q?Umdvbc7ORYRN+D2+cD4fFpcf62lcgA7nlFPw+iAf7j8WNqZKbG6tJmUr0MEV?=
 =?us-ascii?Q?TTmgnHeiJR+fMoSGk0G6OBUL0kGhU9YNS4CEHkGXR6vIuIJNAb0ux1QusURK?=
 =?us-ascii?Q?B34ChO8aesBhWTSPhANzC+xzOWqANN/aE8iwWL/3oFrkrMMexzZ+oYWot8QK?=
 =?us-ascii?Q?rOA009nT5GCCzdMvQNiVX/RkdQJVb6qWLG6yGYYje2KVQ8/fUeAkDcdrxg2i?=
 =?us-ascii?Q?AJ6qZbxa2aRdVRLNsc45UL6YuoYj+Iiq15jfHHBUtp3BZMszw+zJWteAjCla?=
 =?us-ascii?Q?TpqU/nDvSRhQWgs7NKiCB+MgWNfUjICSPaxysSnnuaM6AZ2+i6mRMVTDp1KS?=
 =?us-ascii?Q?LkuanltCWq9uA+iHJBMHbPGbsscgywUVuxdMkX35Dbz7nw+Tm0699Fv7YXnS?=
 =?us-ascii?Q?xOP2kwSBustpJu2g0rpg3RK2QhbSHpSN184OQOmSnbc1/7kUUa+8VdXtNePI?=
 =?us-ascii?Q?RtX6RhxSMxyvUOKaqUlbcYZQTZqgjD/+6/YC8vgT+of5/hCox0I41fQVOSQK?=
 =?us-ascii?Q?C5WvcGc07A=3D=3D?=
X-Exchange-RoutingPolicyChecked: NdYahzt8yrYAXQOmECGgJItqzE1TzupjtAzM9AM3EE1zz2zquwwYIqOE59HxJfDYBTagHy+6KeEUp1eb1VI6mDrc6jc6VHuobR3MZxG/zqxa+XCbQXHoNCZF935TUbmiOmrGL23LxPXmh3nh6DuQZ8kAks2UAXBQprEAnhB8fHgAKboV3C4x8G9A86zOCepgFfRruY9AyCzQ3sXpv2/2W9cetZO29MxVFxiubFfxie1NO2k88h2d6K3A3PiBCkBvy0ic8vKhgJPtkz6o95a2KLml/O+zNKh9k4RVbydPfkamEoAd8SfAQaclh5vDMUTa/7IXrurrPmg+O8XuiPYmYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a361dab-20d5-437f-3ac1-08decb09fe1a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 18:14:51.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjT/3xIFF3yve3t8jfxrw/v7jyoSnldP3aJk13uH7GAa4LJMzx3c1no38Z0oXUsJnjRTAke+3QmUy7J9C6n+8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7499
X-OriginatorOrg: intel.com

On Mon, Jun 15, 2026 at 07:39:01AM +0300, Adrian Hunter wrote:
> >>> @@ -7335,6 +7335,9 @@ inputs and outputs of the TDVMCALL.  Currently the following values of
> >>>     queued successfully, the TDX guest can poll the status field in the
> >>>     shared-memory area to check whether the Quote generation is completed or
> >>>     not. When completed, the generated Quote is returned via the same buffer.
> >>> +   If the host kernel generates Quotes through the TDX Quoting service provided
> >>> +   by the TDX module, KVM processes the GetQuote request and it will not appear
> >>> +   in userspace.
> >>
> >> There is an Attestation section in Documentation/virt/kvm/x86/intel-tdx.rst
> >> that could be updated too.
> > 
> > Can you please point me to it? I couldn't find that section in that
> > file.
> 
> Sorry, got he file name wrong: Documentation/arch/x86/tdx.rst

Thanks a lot for the pointers! It definitely needs to be updated.

> 
