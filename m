Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BDF319847;
	Thu, 14 May 2026 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724721; cv=fail; b=Dzq8/X5rxYNEa3JfqZ6lzpNaxYc2CnAWs/1qx0+SD51hVBU/Sm1TJ95499+XtxV2VwriUyjyQYydU4d1ikjanmSld9olzRdw3IvCgu3aDU2JPfu4bnnUYexN7GohzB0Q3V7Yd2zlUwSV3oyUS2IH2vuEDPPnE6UTOfILgcBQjh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724721; c=relaxed/simple;
	bh=bu2pTc5iJ1Ylq2Dt0K0ZxQg4FQg7dzBmrL3XubpFFDo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nw1bHHmov1R0+AhRusxBr50vytwzI/l8rHkXAiMXCqLLaIAVDJn9ZkDv6gXT2jo8tzQKXLCml61hSsCUE0i/J1sAq1Nqp5JjLTaq8w296E1mqF4Uv3ON/Dh0deLREyFlJEUsd2ERWo0KGPkT+mcA9c6RzdjkY6+UiYEI+KEA+H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpuB4mmE; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpuB4mmE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778724720; x=1810260720;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bu2pTc5iJ1Ylq2Dt0K0ZxQg4FQg7dzBmrL3XubpFFDo=;
  b=FpuB4mmE3iNBRsDpCQkoFClQc55WZn2dDeihgkVaPKa6cxcZtuxQv/LW
   w5yC0Sid433UjcOjGgHSNt1u0x5Td9LlAN/rrPaAtzMD48G8F+xxX0F4F
   MJ24r2sTdOrx5tr5dmEf4d2hTSKGmAM+BiIjTx4kdQHCB2NcSZ9zfFxaq
   JpA2WyksOkLY9uTHQxwvsijYF/ZyXcw3q/7WXW0+S6OqXXhB83PILTl4G
   C7b+leLSlEAzo7ffTNVv66wKkrpwlrTycWjVcTsnagmxmHShXZDPeEInR
   DJk6QmcCA2ac86rChRFF2ij6mYbh/0B7ci0sQS51Wpgelb5ZNAmcajfh7
   Q==;
X-CSE-ConnectionGUID: bSXwt9zbStulZTD/z3Ae8A==
X-CSE-MsgGUID: 6+zdpQLcT+G113V0Y8Afhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79694068"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79694068"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 19:11:59 -0700
X-CSE-ConnectionGUID: LoYuztyyRTCYKgXzC9hDAg==
X-CSE-MsgGUID: mSrQZ9h9TyWiqqX4ht1AWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="242585048"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 19:11:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 19:11:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 13 May 2026 19:11:52 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 19:11:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNh3i6kTJxeYAW6VMMivvmVyOJp5c7ctXJEuDLQCEgy5ic9emli8asYIBL9faM43rUgnCdJT4qyGp1Hsw0eoa/rEY1uI0oYjHA9eKxioBHyii1T6di0CIdbEjiQG7XpnfHX2ZBeYKF5iR+6NNahwAgY1DukQvgPLmPK9+TwguPo3YehbIOLvYg5hX/B3dN3NZqOl4S2ewaNanqHb4Mq+64ML9+z6xD49/FPCqrBjig4dtHZlEvD50dlhXlfi0kAdpfo23JRPOfvkAIxdYbjPAVk1Jq6gR3nDfgArIwGmYHcnx8O9BaHvQb/9pIz+xuYwNohDc4+Wil6HZU4g24Qpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu2pTc5iJ1Ylq2Dt0K0ZxQg4FQg7dzBmrL3XubpFFDo=;
 b=JV40tREbQd0iFRtmLnHwpl0fOrokDBZggqxiGcPFljfID14txE3retjb6M65f00/yNs66uprsC5N9xCh+kaZ1mIc8+ayDdkKuJCsgT3vFls36h1WqdJI3l41FkLDYaP0w3g7qC4wTpiGdisiQEFhebxoLUi+a7cL0e49Ij/GJ8x5XOT91Jw9AQ7TgxgQr1MmMd3sG8ClgWYMjDP8JUWMRxSMHDrQ7j0iV9ql7spUDeB4wsJDWaTqyQ/k3ElAxhCF1BSgkV8MsOYl/5jPUxpaG/ipTyvHQFlcpz3B4ghRAysv/ruG+06Jlp4KwzjmOycnXk88FLdLp30hQhHc5lgQdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by SA0PR11MB4605.namprd11.prod.outlook.com (2603:10b6:806:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 02:11:44 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 02:11:43 +0000
Date: Thu, 14 May 2026 10:11:34 +0800
From: Chao Gao <chao.gao@intel.com>
To: David Riley <d.riley@proxmox.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <jon@nutanix.com>
Subject: Re: [PATCH v6 00/28] KVM: combined patchset for MBEC/GMET support
Message-ID: <agUvVorKYNmGx3XT@intel.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
 <85548beb-1486-40f9-beb4-632c78e3360b@proxmox.com>
 <251c6f2c-6a6b-4a7b-b0d6-330611bb12c6@redhat.com>
 <8ebbfb3d-69a0-42d0-83cd-78e163e3acdf@proxmox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8ebbfb3d-69a0-42d0-83cd-78e163e3acdf@proxmox.com>
X-ClientProxiedBy: TPYP295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::19) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|SA0PR11MB4605:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7025b9-9e73-4fe5-e890-08deb15e2437
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: awnZoxXZ6Cjwypst/69oSZzKQPeYWh4oIR/GYhZB1YUeqUeJ4ZY9u+fMa7OJojCPiZeSuOaLmXN4rwn6sIq1YHQTa3/aSMUaVcxRyr3OG6aOANJGYVvHcoqt/WRxzcJY+1GPsmRXDUEEtGj7n7FCtKZvH13Gg3C88Z/VA7xsMgUe82er1jpfzJahppcRoIunFHuw9TRVix4ImVB/vh+ux1jmoYUNDxaHSHVsrkaCaKFHz/Q1aiulqq8CxarCNxXfle+r7ZAkVhXuJo+95G3IeNH3b5XN85KsbwSlUBz/7H/rJtuqPaWDatt2S4aF3U9rjxtzGwf1DlmgvJ16S54/bYyFgSnA2XVd8KK3IfDTRs2doeVrtSe1vl9Lt4yQJQGBOOzECuEpbl9gxeuaJ60mpLrUd5ZUNwUZJVCNG2M/4aQY8DO87HDF5jLM19uAHpuMztSCXFq8+T8Lfp7HjJjyxeyLRmh8v1PJ+moSvQAvTKYrferhS4UJg7p0STxg1YDCeazQdq+YkQsXd7bU6t5boyatTbabxgbe0befqm2WzV4rPce9qBtGxw/MRjsAVbPPXI/GSFPZN3hgCYifGNIYyFhimbeQR6YtFMoYgfmYhKdU2JjL2um2CJK+58gOMB+aRszAFuCOGyG0s4f5lTsH1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HSPAwudBEjzVl/b2ZK0ZL/9NpxhYGq0OVC6Iu8WL9qoDa+DopfCeDXednpd2?=
 =?us-ascii?Q?4EGmKmpmxOoQn0IeAGPtOJ+LaRAyF2qR9TQm3Sl5LsaRbXDmUjupxlBqZnvw?=
 =?us-ascii?Q?u61LYVIGmOVBHCYvIGYMcHR4FX1L61BydMSwsQx2aRQmHXTMn14Jf0bnCsCf?=
 =?us-ascii?Q?GGY/tQQRgqTPxH/oZdraQSMAdt+UgtBDOdXrzo4POBGQaXOxGRX/HBR8Yl/Q?=
 =?us-ascii?Q?TQJHEtRWOyCmNKjN8HsXLh8T4y51DkKUdECj3NDIzneYckHUIhEjwgPFTdKF?=
 =?us-ascii?Q?EfRgq45n7q9I8rkbqaoVN51Y6/2q9QMbprblZyU3GpC5w+RbVZ8VmkH5ITZP?=
 =?us-ascii?Q?exeaa1ooH71EWGVZB9gnIfX16pZYs8AtwPJBNurCsjOOmycdBmwHsVVyX7Li?=
 =?us-ascii?Q?Vy4XBcTt1G6NQxj/eh2k5LnJtUAqUVX0EokKSTKuu8h88AM/s5WaglJXqlx5?=
 =?us-ascii?Q?RE/2k4reVD3PI+uS7wArtqAnXy1HoilR/sMoPfQUY3tuF+FvBil7NaF6jw8s?=
 =?us-ascii?Q?mhV61uGJiYFfVqE1YZrd5c5eoFSLJKKtN7Iluds1J4WWI8ku6jMjn52lwrGM?=
 =?us-ascii?Q?d4GxNAZB5rI/Ilx8QB783SBthP/uEAwcLKhIju0ykBicoMIUZY+2ZySXxDz3?=
 =?us-ascii?Q?DCHjI9SbyCU6kqRRBWloTA3Kc0VrnxfP3QlqIHGTArJY7stLN/2wy7de0Wrp?=
 =?us-ascii?Q?r1/RO5qmq1x/+Lt925f28pmnLof+pfMxKdzFE1TzX1muI8ySDjrT944lrRYr?=
 =?us-ascii?Q?RDHO5g/6BHedUod62lxBpkTaUCBHM0CYd/h3ewvU5lCNgYUGL9eAxxX7NebQ?=
 =?us-ascii?Q?B8qrBrDIdnwFKZ+cV2d+Prlsn6oHJQUGf+EryYTMomOMCmjzppeqXzL0ODY9?=
 =?us-ascii?Q?M/GSChaQQnYl1mVr1goy1WvK8Q7a/9OLrGL9lH64Gshwi+NYeWrdcvsYfp8M?=
 =?us-ascii?Q?tZuwp+irMcn8zbOdMvNNtoYJPpTUR1Re7Mr2mAbZaCtGzcMVHViefdiDJkoH?=
 =?us-ascii?Q?G6zLZNpTmzImj2xFDAjBdb4OPh4+5/8yYSGQQvl0+VaAOqDSSCV3ZMXaPoz/?=
 =?us-ascii?Q?T0HlUwwwZIgyDRTZjntxKzSKUrtXZ9VKhOkVNNEJ/HdXNrp8JByoEG6kOTh6?=
 =?us-ascii?Q?Jug0ibqHLfHXh2nmAaYIo4rHgp1gEiqoKT+5xJms5+LCJgYQ9+KOS4XnXgAR?=
 =?us-ascii?Q?XEpIZHaKhM0MqramsDnV49cqS8EhnQBgOMiklGdvl/ZzDQDRvqoj21o8zNrZ?=
 =?us-ascii?Q?IQ8RpWFsMepG+sONtFQt3Z6bpJjsrOA6mFG2oEmj3R+ml7y690TPCV9Ovg6T?=
 =?us-ascii?Q?/kZp/W3qyctw90vZogv7tt9jNY9jSpAVMOy8KfWSycIQY9WbYuJJnl9PEAus?=
 =?us-ascii?Q?S7Es0w06kqesk4SNjxQ1DQyD+SxuIAaoZFNYZQW1r/aJovhsC/ml9CZK9lvA?=
 =?us-ascii?Q?svHCEK4XiKABT0GLQlw+dDndNH/OI98O+JZsO0yjzDUFi8xEXtShhv7PPnVa?=
 =?us-ascii?Q?GAFKhay+Jc1frBREB2Ajoi9fHRLyLY/ucvkgMfHD+nDxFsR7cEp06aIWcg/C?=
 =?us-ascii?Q?/1nRK6e0m26dUB3edT0EgZ1UFzXbIvnxkHcgnwHKnWii/PgcjLYEqyFn0HN2?=
 =?us-ascii?Q?fH47Eu/RXbReumxcMuhnSM1H9eli836ydwtBmbb09ljW9xPA1ZXEE/tnEFrN?=
 =?us-ascii?Q?XeaOzLlBQ5mYbUTML3nu7gi2LZ14mE9CT1iXBKBl/cDfGZ+t2xW7yHn9e7rd?=
 =?us-ascii?Q?KK5ZaUvbtA=3D=3D?=
X-Exchange-RoutingPolicyChecked: wJ8auCkkujzLfvpOgMzaNPei9hurzFXxesCawd/zlM0H//pDac4zNm2iSyTaHqNkvJ/EQGapXTspbQBcL/Lbsp58AHJKyPh0rAmEJiDQ0Kkk3CZtuqjfgnZt3tNOh/HDTX2tggosrBmUNpuhF4w7ydqNxrvLy5+gkewvwTIReN0CUaHUWN6s48/o6F0qzLECybkG90SnPwAPggVUGJr6Udy1xCD783N22K2z4QGDgO9PajJHbn0CcjK4O3x3JpDZ3a6QGFe7DEmIZHoUNTT2NMtVoKp4/uC4fRNdBEw6ZkAopLuXqrTJ+KmfBYFJYBbQdb6ZfYsIs9hd1M/7TbU/aQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7025b9-9e73-4fe5-e890-08deb15e2437
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 02:11:43.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgdA7esXwp/MFJIqUH5XMWA2HAeZm0DB5E5uKHMgqYjd5Gku5QrmMa6gUKDSWhuRUbdW7mfG4R63jhN62qRMqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4605
X-OriginatorOrg: intel.com

On Mon, May 11, 2026 at 01:07:33PM +0200, David Riley wrote:
>is that enough?
>
>dmesg | grep -A 50 "soft lockup - CPU#11"

Do you also have a hard lockup trace?

I want to make sure the host lockup is not the issue discussed here:

https://lore.kernel.org/kvm/70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com/
