Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3F3E023D;
	Tue, 24 Mar 2026 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345780; cv=fail; b=YGJIi3TRs7VeVaDAkZRrpPrlWVqt0dIzEYLSxoe14oqNM3nKvDnUsgxmE4c68+t3WbONNeio5JAJWsHZO0XxjoW+Vtbvb1mn442gr8gHTE3RH/8Sj9RTROSTldRqJxlEBYeTAAcjBi8OV8KoKKHDCEeKRwEfLRzrGDowEfI2EAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345780; c=relaxed/simple;
	bh=7mbD5an8mD+L7cGNPmN6G8dQTuob1xqOBDJvJTlkNWo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=clhyfmJgQPa1bOMFRxg5mzXraTbwCK+SrgBXqbmTeX/e4f3PygdqpNrcN9usVZ9npdCFPoNvy6ERLwj267120Zxm7TeayXf7GlfV7Y2vAbI6/D0uBUesLPpjhzL0OLw3s5WAmdFhntlcNefcMMi0cAog/IEBLp7xSoO3mp1XyKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDv/eR2j; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDv/eR2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774345778; x=1805881778;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7mbD5an8mD+L7cGNPmN6G8dQTuob1xqOBDJvJTlkNWo=;
  b=JDv/eR2jN8wDA3rmCZhx0Mw9u+STxG8seNNWjaAsWm3ik1SsMLi2quHQ
   0SWMMPWKomqD6xv3S5mBlNcWnog3lhb60aCrX3G3t146yTHIIGNzscUCV
   iywztZsgLQ1ShnLY9zEP3NKu1gb6TTM9a2BET06Azj/G4LmQNGnuXpqcP
   A7bWnpSexcUgMxAmzflFTcXiVCBTSgtnXN9OqpKipQynqvF6XUg6yWugU
   OOJessOdEChKYAHmbanyLAIxCQ/GkMbLLfpxbcm8ioq9jB16Ora+7n1JB
   +v5eRi+gCAXAnmE+BSY9Y7kZHKQAb3IGpie6t000TqWvKif/6pRu2EqMt
   g==;
X-CSE-ConnectionGUID: iqmS4BEMS+W0wN10Szh0+g==
X-CSE-MsgGUID: XdC6Yv6TRryeJzQu5a9w4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75549859"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75549859"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 02:49:37 -0700
X-CSE-ConnectionGUID: Mhdz8yLiSiO66bQhZzl5IA==
X-CSE-MsgGUID: NpI8qBT2TrCCrMUWH1t9rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="254787329"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 02:49:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 02:49:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 02:49:36 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 02:49:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diJN1CY/4ncNwZB6URzyLVxDR2CRzP9/q6fcH0/jtuwpo3ec+PllnYtjApkk344WgzoJ990QlAvI7UIebqu3ZMQdKO+XWZ3YbPQLEF+AIxMTefpm128XRX2VbM1wzF9lrqjLy9WeO5rgvjyvf8YhMSh/dVDDfNBQ3AFIarOPo3RZVI/6N2ng+iQAMEuFP1pXIiFgart1BJEPBmke4yV7fqP2mFTjWXeEnf92bWjGcDgyQZspsM4u+dAOYSkPLdU5IGAnQXrx7c3Pw92rrBeGRg/xZJTMnFDa9DpTF1SVByzVvOqDXLPjhBtU8aLFz/c1MYDZ3FvBHBl/mgacYo0HFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieHfuWjta60P2o+UvgE2c1/q6PZUOspoWFmk3wuWfBk=;
 b=an2hlKu8qnKbqsYDGmQ4h8QrA0oqmEQ3qLOs9r5tYN+ZuRSTXagAlxXKx+t/ek8MzVUoPe1WLTjzCy0lSBafcgOh0l9l1vQaMW79UjVd2Hg82N7yLYVbYsiuqNaf8NqRXRD9TdtCUvUhfK2Wz+swW1r/5M7S7vggSxJXr+vm9H/g1vgsCpyrJFc4iOVDpM89Elow/ZoBiJ21OFrTOenw31Bgq9+IZ8OuwY42mADkPdORDZpV9Uicjl3EIY8A4d7p3x67NN+P7UYeS6TqJjOedRvfWnykOGjewkYyPMCrsxSIV7mIqbDOTdS+T30ixD7dlAIYeA/BQHtpefPLGdRwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH7PR11MB8550.namprd11.prod.outlook.com (2603:10b6:510:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 09:49:32 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 09:49:32 +0000
Date: Tue, 24 Mar 2026 17:49:22 +0800
From: Chao Gao <chao.gao@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Sean
 Christopherson" <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] x86/tdx: Move all TDX error defines into
 <asm/shared/tdx_errno.h>
Message-ID: <acJeIs3fSinqkJFI@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
 <20260323-fuller_tdx_kexec_support-v2-1-87a36409e051@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-1-87a36409e051@intel.com>
X-ClientProxiedBy: TP0P295CA0054.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::18) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH7PR11MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 7141de82-e821-4045-f419-08de898aa682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Mk1FF638NFCSxwHbIHb4/tx7Cw0Lm2+HGaXsgoaCnp3x7Af0ba0b/ox7l0BujHc6hfBkvpmwrU2YdxNzEersepHE+8WN7UK9ZTnBvPVODyunWPaaFJQzWhTblVwxeJciXkiwCZquun7MxO8HTXSC7tOs5f8C1hk0zbwRueLvHmbNAhyu4c95vAhfs00Su0mG5Vnt3tiegdPNYaJXXuiDNeNGWgM5kB2AMbtYEQu282kPz8RImfftOXSV1gCyhQdF5SOrbK6PZhyLQp1q1iMv3HZCY74brImsl4fY4ADtxapBs/8RgRI/0O3hP2zSzDxeDo7QZ5HyIrgxxndoWO0/b1kbKW7eRHCl4R5Ri4JAchW+rklPse8F2g9wF7MbQ6iDNvT+ARvEJUXtZwIVxehHiAREzkCUZIlUYXY2IYOpCGy93HAk8/XqoVqR1lo9IAtwtvKBv50cNs6Y0qVyb1e3paFojuB7eTZ9qzmwXlNsfqGE8AKDQbXkhV4TckJxzn2DM+4PieAkZt36qy3SaGDe2CJbmznmz5JD1T2tRsd4p7O1fICtEMdKHxyt8Lz2/2PIcwyAwcLKCctttcYb8QODjGt4HtP7X+PPrw2/riESTEKu2utYNHHKzBNfcplpDAIErvf6hzytMsLnAeMMdgScXkFJ91KklP+dU3dXfC5sAnUn0Ep+h2EHoZef5saJOZUGMaoPi0YdSNzFK1GYj8SsfABAZSgW0mcubld0TYC95sg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QVd73ptjpda5GkZjZA+Vbq2d/xSrwbe464jtvwHUxVrfayPZAZLVjpyqvkMO?=
 =?us-ascii?Q?qNksTaWk1OWdw27QBI7hm5zOSMIBGCnS7tfjy68TF4dRAPhlzvlXMpYjikUh?=
 =?us-ascii?Q?MH5RkBpOsZbywn7jR/8rLjZ5E9VzU/3XSXINx7idFdpdfjVxsT0Ob/XGjZV6?=
 =?us-ascii?Q?TVBFcpi2Sq3rCzdKQo6L1AxfR5cZstgmLjiLT0gemTGoUCyzLB4wB6NHwcq6?=
 =?us-ascii?Q?Zsce2AS/Jix0EpHJmrelBETaayBr1Q44E4qc4CLuUJeUMhwe+Pht+z13ETgX?=
 =?us-ascii?Q?0cI/CQC+Zu9dXFXUcyyruJCbotT7GzE3i1U4J/Zbb8i18bT3qdOEAhx9hONq?=
 =?us-ascii?Q?9EvQ8tnDawUcLDdagvM4166AWSOWeFNoKHcccKkHAW3viQ8y12Pil6U527fV?=
 =?us-ascii?Q?ZWrB+mWWtTXHpnU+qasgi8CeaLFLzBzuO2QXgFaO/iHgP4zbMm75PDiARxOX?=
 =?us-ascii?Q?E+fJb0u2t0jInypdIrF00ApN6zWO78pNO0z6ObHJXP2Yt39bJfJq4/Fofc16?=
 =?us-ascii?Q?KPiNjbobfnaZ82wgqaN0EoaMU/e4hTmmsC4rXldPVnsl2br+Y2+SY23rSdDa?=
 =?us-ascii?Q?SaCNYcaChmOAxqc5AIeeCKZbxsmEQIPhw73l9QqWxZRN7SUow6rM3bPMJLjQ?=
 =?us-ascii?Q?rYCDtAX0YBXvnmebUwy6K11TN9ITqhGaQPph3D4xkV2GFnaA4QHs/8SxO207?=
 =?us-ascii?Q?IFqPdK2eBr8OqNtbkFKAKKAtkIOlzhhdneI56/MjkMz318MZtTnGeSU/NbsS?=
 =?us-ascii?Q?tV3KU8Mqxv9VgObnk96iUn8fxtsoz+SxQcuHincPcsd2jHYO23U7aK+hMX/2?=
 =?us-ascii?Q?QSeAyHwicZwzVjZZh2XGykpdR8E/Ic93SYjuCHlpga6HGFS+c4O+3b7p6aOh?=
 =?us-ascii?Q?UGK/9QwpeTQzZK4oBy5CpPwP34zA/upGlameXI0MQDnf6PgQoYssOydbfl3P?=
 =?us-ascii?Q?xt1e3srgVKPsdwu9ilnDqqT/IJS5z/pyMyUsjDBuQRDv8rKzsrKXSQeRnHTe?=
 =?us-ascii?Q?pes3zETa2UvcS4OVweKEA8KnTGkmCFFvf0fxOAjyucHADHoGckyoV8Z4BYBA?=
 =?us-ascii?Q?xWeATjWrezC9w3njte+qoM+9++WvfKaHEpgZjUk/mWOOZUd1/eTVMu9iLA+Y?=
 =?us-ascii?Q?UyVBrJGU16qM90mXaLc3E50yn5dyKsEVavvFzF90k2TVNaMpyVh2mOqOw8n6?=
 =?us-ascii?Q?OwZMHh4H5SGfYXSSz3DdlnvFw8pansyyFJgp94iu9Xyy9MJ2gMBxeYoSn2h9?=
 =?us-ascii?Q?KFBP+nYQW/LwDAlE/l94IhMjDH3zeF1gyZiAOIoppP4motnoTAVGcG8fbjca?=
 =?us-ascii?Q?ihCAJWizz8ToBZ9B4QBjoCym5agYY+3JA/k8gp9AZIut7XeMNopiWjLnwdZ/?=
 =?us-ascii?Q?MN/yuK58P7GIFu12uew9+euS2C9qCQo3Z8g4TntC4o9OBaUKm8ilfU6wu3Ew?=
 =?us-ascii?Q?d8wFMXTJmxaH5oyhrs5g72AsFNCq2oFUfwNX7YaVPAlsJdUb/95nuytSCIRj?=
 =?us-ascii?Q?rpMggUcKq50uSq/HSimwiQv5lMIW4tNmsQLrbGfbLR1CYk0pad6HGJQYUd+O?=
 =?us-ascii?Q?mwoR+/Bz4eFxQEeDnmlf2bI5EQFAl8UYxpH2cUkqkTXE3M6RGUHIZ37uDEMs?=
 =?us-ascii?Q?0gJSvHxhikhn9khPSNBkzyI5QnEZHW4XJ4boUmYB7qdfgS3dWxeo4ynG8LG2?=
 =?us-ascii?Q?TkHZiQsUid+zbHO+Zs9Wf4/D196YSQcxlvo8G8+Yzl8PUvXO2OhHeZXY9okU?=
 =?us-ascii?Q?2Kiyo/BUHQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: WzzhayZkWpxpRIJvym+RGYun/OMm/ZPUtcn8bxXemso/pbSSmF6XV1DhsmU40wUwheQB8avUY/KwHKA6A0OT3Vih6LzMIqoTtQtYpP6Wh4yTutzM0DW8/NhTomFJnDx9XIXtRmVtCzJ4/Kei2R9J/ETjzWuUwTGbI09ELCx64Xsp7HafMw0rWnr1rwx4Ne27UnwVpSoEY1kp9Q2AWpwJ/ermU61LSr0oKuE4gBU6S8Ea272xMen+laWA82FvmvJc+HoYqvZJ7A8BqhhN+y53DD+uYSCIazL4Hr53PUcPYfFCkdlhJldElIakhxBSeMCwLbN2/TL+i06Nj8Tg6Un7uQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7141de82-e821-4045-f419-08de898aa682
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:49:32.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dcFYI0AuMG117mO1ZgGlXapHdyZvazaONi6hO0mJOlZLl4w8KBU/XWA2w5ZKh/fKGL7lgMgRBx20NbeU/91yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8550
X-OriginatorOrg: intel.com

On Mon, Mar 23, 2026 at 02:59:04PM -0600, Vishal Verma wrote:
>From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
>Today there are two separate locations where TDX error codes are defined:
>         arch/x86/include/asm/tdx.h
>         arch/x86/kvm/vmx/tdx_errno.h
>
>They have some overlap that is already defined similarly. Reduce the
>duplication and prepare to introduce some helpers for these error codes in
>the central place by unifying them. Join them at:
>        asm/shared/tdx_errno.h
>...and update the headers that contained the duplicated definitions to
>include the new unified header.
>
>"asm/shared" is used for sharing TDX code between the early compressed
>code and the normal kernel code. While the compressed code for the guest
>doesn't use these error code header definitions today, it does make the
>types of calls that return the values they define. So place the defines in
>"shared" location so that it can, but leave such cleanups for future
>changes.
>
>Also, adjust BITUL() -> _BITULL() to address 32 bit build errors after the
>move.
>
>Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>[enhance log]
>Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>
