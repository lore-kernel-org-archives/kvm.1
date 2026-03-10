Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CFB3D4110
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163666; cv=fail; b=Rx7/nj55vvJB0M7Aw3UQxa92fqaLgEoRXvyM83JVbInJVK4KnzmW6yAHbxUGP/8alokYarR6BTjf68k74Ca0EnqqbnJyE8FPQVjDV8iCZBJ2cAGE6f+y+zWO/zzy0m0B1Id8Vvih63bVgSBAzVH2X+TovztCFVI+az+T9K1jZAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163666; c=relaxed/simple;
	bh=KsdYdi6nYsgNEnr1mzGO6zPj5SA8Ls8GjQQ0CbzCyYA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rrTR+g4zxZcx5+oOH5fs1Byt43lo2GQpQn0/azZWSeq3311QH2TfBiG0WSkqtXG/fkHRyfk7QJf5UledorJREA8ryHXEUCsMT+7ow1q2kgKRGffVcd9c7GSvJHvyyE8XCC1NnioKH5/QqmVk/LuXDbD8Kb3OabzkBBUmcCkyCDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cveme7ly; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cveme7ly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773163662; x=1804699662;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KsdYdi6nYsgNEnr1mzGO6zPj5SA8Ls8GjQQ0CbzCyYA=;
  b=Cveme7lyOM78Ydt8TGUh+uuuyW31TLlYiJUJMmMXtmtVL54fpXoQHsDM
   DhIB9eEKZoKV5LvW6CfXsadTfZOwCNMLf3y/OHXNpu7KlhUjg+G8hEBrU
   Da/1xDu3Kigpx7rFOrlKWeZzceaPKhNKJHQYyviAL2I3frX0OndZRDe46
   IFptlCPwpYg/obyfs35YUdCNnKp723aqKzRkMd349orjO1CulvmDvxTpe
   9GH2YFP5FsqRxpyU3LvGx2xzrD6eiZwI68T6Mh5UCio4C5wwmkJ+vztnC
   8JXIacbI4CypM8unVQLOnt+ox60p7zJxER+ylKbsJ8sXKL8OuFNeBKpTc
   Q==;
X-CSE-ConnectionGUID: YdnF5GOsSm+ngPTleQDJHg==
X-CSE-MsgGUID: NgOLUtbNTU2+R2/L3YQIzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="91791367"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="91791367"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 10:27:39 -0700
X-CSE-ConnectionGUID: LbyjHtbBSaKLSXQtVh6q2Q==
X-CSE-MsgGUID: Yke1gzA6TAGFLbkuW+ZLaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="220371452"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 10:27:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 10:27:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 10:27:36 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 10:27:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6O4LJ5qAwG77UhlxGMwYfSORo10wf3hu3sg6cWwXFath04RQrWnH3z0pCszWfcQQl2a8yHC9KdPdQ89Mn/vcfCyz9cBOWHcEQD8eAuy5VcUVa9VIMMAqlkdiQxpk7yIkRsFzit/Pe46Diy6YMiLqQEw38FU25OOEIvudMwV+98Snr9LnuiTl+vTRo0GAfAuwwsGvwVcQ1B0apvPdd9HwZ6OE84Y1NStEJoe+SITgjlt+sGxii4KXDdBcp80UWJBfxQ6jfGlpAK1YN3UYBERnpFM5e9JeihdWDRgk3PJ3IxaR5z9vGdx+vxBsezFCHPZaNilciuNikPU1v8oY1nKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3gZYnSBxiccdktnJqq7qNBi7LBgxjSUuFinbLZ+iN8=;
 b=cfTRp+FKS0HaDE3/7wNQRufmP09DZ7T4GBmmpJCYu7pK5VVStEnQjmXsXuDJ8t+SWB20y83RED3zHq0+zdMYMVL7mEZDHc8kMbyZvMYWgNFM8NgVriZ2MECpi+G93PVn/07MJWkl5LL6SbgeqQAh2CJJUXHQD+6JZ1tgoy6BnXxsOLMAw+kqC+xccyVBZZK2zp7dohAPrjD98HjRlddmC4q6oz0h7YPXtggSgrI9PR/SGZR7JLwfDKTlbs0mTerwOa/ME8z2iXYhr987sd/2jHvRQN782UrpDbRxMzrMaIeS0aplFDVedoydcfAba/VIDAn1q6u3m9toh7ThY6M3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6407.namprd11.prod.outlook.com (2603:10b6:8:b4::11) by
 CH3PR11MB8548.namprd11.prod.outlook.com (2603:10b6:610:1ba::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Tue, 10 Mar 2026 17:27:34 +0000
Received: from DM4PR11MB6407.namprd11.prod.outlook.com
 ([fe80::26bd:1704:645f:7fd4]) by DM4PR11MB6407.namprd11.prod.outlook.com
 ([fe80::26bd:1704:645f:7fd4%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 17:27:34 +0000
Date: Tue, 10 Mar 2026 17:27:26 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Alex Williamson <alex@shazbot.org>
CC: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>,
	<jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <kvm@vger.kernel.org>, <qat-linux@intel.com>
Subject: Re: [PATCH] vfio/qat: extend Kconfig dependencies for 420xx and 6xxx
 devices
Message-ID: <abBUfvkca4XU02FH@gcabiddu-mobl.ger.corp.intel.com>
References: <20260213091403.72338-1-suman.kumar.chakraborty@intel.com>
 <20260309170247.2bd96b78@shazbot.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260309170247.2bd96b78@shazbot.org>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DB9PR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::25) To DM4PR11MB6407.namprd11.prod.outlook.com
 (2603:10b6:8:b4::11)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6407:EE_|CH3PR11MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 686bc193-a94f-4972-00af-08de7eca50cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: rpGqcMbSChtqPYLEDoDN/GCvdNNBDhjORmoBxHek3SENT1yYAwe0cTok2b/Z0nOOsfXs7eqU3drjFcNETkPTi8Oh2T0Lr42WrxwbDjf9bwPEpo5FzbDEBv7Yc/onIKFwgVJnrLOoNiChlIfIDIHaxRk50lm21mD+/BE+Ua9SqF7zC5uULbxiEtGbFiZJT4eH3d4EW3flJOtjPEgdT2K0I/huwaxuSkqpV835KC2ssEX0ZtUO0LuGgBzD06IBLSOlRgW41mESW8K66QhVlEc51Qo5JcQBuos7+YAefFgb/jzohMzTxXs/iLtup69ngVoixPfzz/iV8lc7fC///tyJcceRbHbMjel2oIL39aLi55TnGkLQ+4FCK4tVl6htaQn6rF653G3t4v5bg1p3JFJ4f1l+FOGIGDZZ37uEFZvYX0wgNNsgGWa3it8LQ6ujovDM07AorsnqFZMbSSasTbgKKaVgbBBmE54N8CJs+a8luDspuBxptA4kKgymaH1bZvFwG6CmnaDJyOoL8usj0IQiKtrnPNtJUO96goZx7MLrPuU1BBHSK2X0gAsDIU43/I7+bSbR/6I22quiQa++xeERT5dP2YTFATVkQ/L1RwUo0h32QcNSEnqSkWj65P7eN0sZacxNqRdFDwQGX1d/2Q6ODQ2STL/F1hAk/H4F6lD3IrWE5sG9TMIjz70i36KXHQmitwZFSC3cNUSEAj4BGHTLfIt28XiisCuPMNjcc4zQUEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6407.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9FGv+2xsLOwIunlbRKN0y17jCSrYzs9qDDFmYl/5Xyha84iOnMfhnm5uq5aL?=
 =?us-ascii?Q?0OJBa0muVeuMy2+bY6ooFVwSUfoDTYzc49IaY0jwRahc5lmI5LGYP18mv/3T?=
 =?us-ascii?Q?CCLjRZhICdNlRujOsFk+Y6Q1i13+oU7ILgLve0qkROxpxT344Eszz3WYiyfB?=
 =?us-ascii?Q?AmFvxfM6ij016cS+DtNeafRwJk4oMbWnfXgsE4PyyXajAKmdyIkkDXfeqPK8?=
 =?us-ascii?Q?JIjpWVSJjZxj+00htA3k0/ELgIOnLV7AwnJ8uiXdCiDMLg/Qzu59+FfuqY0S?=
 =?us-ascii?Q?TsoDlp1e9elO71sGIyJw/h0gN+X0hiVGBYOvohy4viVJUmFZB+TmBDt9gp6r?=
 =?us-ascii?Q?zhB5qfaEajeeulwo1oKV+CP4COkCSz7mjrry9M1RBHIgOPxBTOJ8d0TLMAM9?=
 =?us-ascii?Q?G6BHeIr6GRwkpNUPr35yAv6zGkybAFyK02n7y6h9eXWb4yrH9nWRes4HZL8G?=
 =?us-ascii?Q?uaIRmH32N/wTgo38pRiGPY2tjrSKOSfQTkJdAOnWbR23GbhoG7FyTPGWX/85?=
 =?us-ascii?Q?WozKiHC9pzorA8vX6usLloqE7OXxvLHA0Hhe3mrRGfhumc2a+py9sDE7qfJX?=
 =?us-ascii?Q?jRs9EJFaWD+OaI6v1P/eauHN2JIU7EfrJrqYaWd0wte2fovpSL0DC50bngO7?=
 =?us-ascii?Q?FosAOXW4JvLlwVQ7QQlQ1QZX7i1SflU7pDgI6gWbjs252eBxInsLG2hXCHGM?=
 =?us-ascii?Q?qnNgNa3mUeHUjaeTDVuf0vZJ0AgTuEDVaWPueylb1KBpgd9ggvyELvGhwmWp?=
 =?us-ascii?Q?D2UOAFFMl/utGT3px5TIkDL/mv1+StaHad44/qP0cHbakNzQ3y4ZyXlnRr/G?=
 =?us-ascii?Q?2DqsTEH/CK+azdXhtCGXJbb+/xqAy+CpHEQleC6s3ELakCp0IpHF04VqEQXA?=
 =?us-ascii?Q?sOT0quGtTSMPo36KE5fm2MgqJNX/Iol+0vFtRLzr4yE5IJ7lsird1E5IcLY2?=
 =?us-ascii?Q?hJZ9Zajqmv3GA8i82X9++dJrB8VNkfQkDAj38xX9PJgRE7CGL0iAdtdb0H2e?=
 =?us-ascii?Q?xnbWqlNO58F0w5A5BPv4RnMenrBbVNecggt3WHeUYCFe9KM1KdoCDtzTK2/4?=
 =?us-ascii?Q?Mna8EEaTnqGBJ6M9XQBq5JE7BwK8KrtqgAV6HO5hO7+p/jXnq3PkUrrRlfSC?=
 =?us-ascii?Q?Ha5G2wnav0p1nozxYjJcKjl3+unQb0p6eSTm6eSkzsbySRJi2eSXmhr3sXDN?=
 =?us-ascii?Q?TnV2nckaEZAHhPIczXKHq3jNjsFaCsCw1uBx7vvUns3o9UJwCp3m20svOz3D?=
 =?us-ascii?Q?cyg8OTkpthHyohmgId9aPcT5uFpnhJbsq0uIMBl01V3EG6oCiTtOiVKyit6D?=
 =?us-ascii?Q?X042Fp7GfX/IAP+ZQNC9tRAQ0cG70gEs6IIDKphGvPVuw/grPq43tcIqy9b7?=
 =?us-ascii?Q?8WTugNGsFa1GmwakW/e7/b22aaMxXYgI8yEgdKr+iMiHgsbOhp3Nr3R0UtCM?=
 =?us-ascii?Q?q+s/0N4FPRsEO2mNWR2XH79fKaEaZybHYHET+yGWyQ8MNDEVUBMbBHVEkp94?=
 =?us-ascii?Q?q7siWobUsLLZ3Tzj7vD+qILB9fWxi84Gy+wfsj9HcYF6cz087+/X8bdYw0JB?=
 =?us-ascii?Q?gkECjMpHZFNwE5ywL7/ERAVVlSR6NYdRv9x8oQJqoZHpCOnToqjj6PPi0L1k?=
 =?us-ascii?Q?hS1RX+1ZqEIMFPfsAyN9sdYKQqNBzDXQZ/vk6ti3TtnJQwUsxRMaOHSgczzz?=
 =?us-ascii?Q?+jNSCU3OouGGMz9bhMstpnLBuj++6sw0U9tn7hUM+qVfCjGk5HMFW22p3UGW?=
 =?us-ascii?Q?pjGn3h/8Es4ietR+v0VtQl3F4nF8/FE=3D?=
X-Exchange-RoutingPolicyChecked: uNvMJRnVcJWiFZ69nIO6/ArGYM6Fml+boxf1vD4z5zl9XLvJ8gB189u88g0gjI4i1H6rqLKiycKigLeInROH+2thkykfo5FVUSW9gNuQqDoZMX07UkqPjW5/8p3g+C3/e8eIqMYVZrwWYK2fjCaPEZrRWbYYWxFAqKEEJ2lwT0PGAWgVJzyrS+8nFyYP4tIdciBRcejaBWCclwc2QZ5nKl+T9spnN6nG0wTj72iD5ch/i53q10pBhdAomz4QaAfHYrj2SZCMW9urLFm81y0Dgsq/X6pteZR12FPOQSEbTnMowbYBPrtMZBFXuqGwdBkttqHhTArNrMOYbEHvZbKPdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 686bc193-a94f-4972-00af-08de7eca50cc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6407.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 17:27:33.9564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APRFEt1dJJ+YS0yinHrC1FoNFvX4H8aXp7ZNIxElNMnDLYyUTiLOBr6PhAU+MGT8+35D3C5uTTFRpSUD188RBC8t7fkyCLgc2ztH+noii9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8548
X-OriginatorOrg: intel.com

On Mon, Mar 09, 2026 at 05:02:47PM -0600, Alex Williamson wrote:
> On Fri, 13 Feb 2026 09:14:03 +0000
> Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com> wrote:
> 
> > From: Vijay Sundar Selvamani <vijay.sundar.selvamani@intel.com>
> > 
> > Currently, the QAT VFIO PCI driver can only be configured when the 4xxx
> > QAT driver (CRYPTO_DEV_QAT_4XXX) is enabled. This is too restrictive as
> > the VFIO driver also supports VFs from the 420xx and 6xxx device
> > families, which share a compatible migration interface.
> > 
> > Extends the Kconfig dependencies to allow configuration when any of the
> > supported QAT device families (4xxx, 420xx, or 6xxx) are enabled.
> 
> 420xx seems to be device ID 0x4947:
> 
> drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
> #define PCI_DEVICE_ID_INTEL_QAT_420XXIOV 0x4947
> 
> We don't currently have that in the ID table for the vfio qat driver:
> 
> static const struct pci_device_id qat_vf_vfio_pci_table[] = {
>         /* Intel QAT GEN4 4xxx VF device */
>         { PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4941) },
>         { PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4943) },
>         { PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4945) },
>         /* Intel QAT GEN6 6xxx VF device */
>         { PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4949) },
>         {}
> };
> 
> Are we missing support for this device and is this Kconfig change
> therefore a little overeager?
The PF-side live migration support for the 420xx VF (0x4947) was added
in [1], however the qat_vf_vfio_pci_table in the qat_vfio_pci driver wasn't
updated to include that device. I'm going to send a patch to add that.

Do you prefer both changes (Kconfig and table) on the same patch?

[1] https://lore.kernel.org/all/20251120163023.29288-1-giovanni.cabiddu@intel.com/

Thanks,

-- 
Giovanni
