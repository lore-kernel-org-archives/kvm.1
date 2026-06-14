Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778D9224B05;
	Sun, 14 Jun 2026 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781437826; cv=fail; b=cN/hmBEk18G0nDojVs0uxlQ7NQV9uJMVyOeYqn/bQgx3TgoyM5mAcsoS/OXc9y8a1BNhTs8AxlyfmcPporKqJsMlEbNMqDOtFS2/CHlLDT/3Wp7rpGi9be8IWCdk/49+o+x54Y8Y2n5tblX7gRPgE4BNcDjtKF6IkUqVgDpZMMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781437826; c=relaxed/simple;
	bh=thr038S5Rwvf+lirWfdx/63Ot9GevJRc1oOUXLwCBSM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tvNTNWtdFTGpD9Vzi9tjMR5Cgvq8/7Bi+9pWqGP7DsYywvjOYRYrbY1CgYjwRWz5JksbqlNqSttyEy7KedFjukgTLPb4Jhp2R4H9xpTNm/JO1UASPU3q/qA2PyjFpslzjmvT7YMdQSEC2F6yIphdEt4s2vvDXWZUxps0WK1pqbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vk1bhuoT; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vk1bhuoT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781437825; x=1812973825;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=thr038S5Rwvf+lirWfdx/63Ot9GevJRc1oOUXLwCBSM=;
  b=Vk1bhuoTOWJ3XX0sOx7Tlp8MNBr09nK0j2vd0NImU15Rd6/hGSRUlUFG
   8MOxxzPUuzuG0ZmWX3AV5uoTYgvTm+sq6unq2ebivWDkhVER4Aw00LAS1
   B/E6w0tpQoQ/iaIOuD44dQGJqT7zFMB7ggCMRHXF6ywG+iQ5jl4/Ft+bX
   f7+Oai4RcHk25yjUrhNL5vI/Zv+phQgZVtp0vI64LGvBkyI4Q+CC+DX5i
   9GRY1w5K9ZskesQFgCagHAbcmVG6x3y19feVuAfPLeteTlxLtPlKoF7g9
   4uz42eh4abQaygvduEAU0s6d9aRR0iaRnCy/IijX5OuJ5//Sz68Cf+aCL
   Q==;
X-CSE-ConnectionGUID: KIvTw7OLTHi2iZlZdnfV1g==
X-CSE-MsgGUID: FEaX93RGQ0ynB6NEXlvQzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="85834955"
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="85834955"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 04:50:24 -0700
X-CSE-ConnectionGUID: BLAaCppeSgC8bXlYg1U4rQ==
X-CSE-MsgGUID: nD1aYQOARWqcDYOyEt6R1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="252167736"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 04:50:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 04:50:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 04:50:23 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 04:50:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjzZS0YSBLwhGB1cL9YqkS/z5ZvTF0Xjc0Vg4mx8BrWhDFf7gG4S3+cnQHIs3NdnzYeuVGxMOGn2OSjjLKlHpKSMLHJInH5W7SIMXNKyNphdqvQKV0BC6JONOhtlGHaWY//H3qJ63weaFzUlgiCE5X4uzmJ/eby8g3s5HMw4QIvPhQuQjX3zHy4TBMdczgBa/CBKPvKR7KRpkTF/L8cu4QO6NaSGLs4kzm3su8Oqt/PUysCSinyLOzYH4m1UIozWnMhV5j/8cHcdw0S7eLSAtj0Ujsd/2EGAT+q1L00Xub2wKbqfAQ5oOKCivVmWV99XU3yXbYL6mVGVARpyhrBSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmxNCFcyGVHYhJJPiy0FW7aBl3nHhFmjkfLJtCsI+sM=;
 b=tRo6tfMoE12n6++0lMXY2bmgVJJw0kdfC0Lt2voXUstgEyEL/gdbq4QSXp8rSFt5YRt4bELfVJJjbnYfxaZ9ySAbG2wE7WjZcHLe3Zjp/xgCwF4kgh4Sm1QhkO55jIVPRpUgFBTwXAI4MnJ8/tsoZcZpdmkuHYesUzkcu8lP2v3KSFOqwnBH0jBj3PuQCiYV4QSL5P5BeAkmmIIIGOd0Hncp/3IOEnaa4bfQ+RnZkPV8EmnBIw8XTjh1vC7rhniFcT6lVTpeqkPKcmtTrNWyk8AJ1N0gJPVdnoF6RzbANjmoImQS9JBfkxo9J427EXxbb127XOuuCpNL8R0VIR7gYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.17; Sun, 14 Jun
 2026 11:50:21 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 11:50:20 +0000
Date: Sun, 14 Jun 2026 04:50:16 -0700
From: Peter Fang <peter.fang@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH 10/15] x86/tdx: Move and rename Quote request
 structure
Message-ID: <20260614115016.GA3417767@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-11-yilun.xu@linux.intel.com>
 <5f9474ed-bacb-44d5-a0fc-5a29a1e79b60@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5f9474ed-bacb-44d5-a0fc-5a29a1e79b60@intel.com>
X-ClientProxiedBy: SJ0PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::13) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|PH0PR11MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbf76b3-92ad-478e-c207-08deca0b1c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: bYqtZfeSEwn0Nw2MJJSzttSP0OA45fXtv38YXIuYKaWkE4JE5B7V+XMsx5MmKk7QR/Yq7XaWjiSSVpi/rFQcZOnt6zPqyyXvF189MVlrFxWUBvTAcUahbyjoobNzGjaaHSkf0ae9gp8hCea/pREa6qf+oT1uo1ho2/uQ7D68nW1zVvaWGsewX/BtkoPhbvxk4GZOThfr7HKerZKinYJP4xqk9fuK6y0067S48Ohqktk355R+SOMGDC1icWGm4cgTyLnb4vdO0COKdFAX7/4m3WsebFvsyQ7vdd7t+tw9JzfMfj+dTsXx8obQv+GWRipdUtoSeDryBM77L2UO2kfiDwHz6IUy5/0T2asiAfRZVERduDnOPSrJtEGz7U2RpS3NsTWSKYQTrbRTSyk88HkLvQkT5ycVp9kdLSz5L+uWH6teGyyGdhpTgfFm5QXqB8ZHrfBRMnkgrdHsyGu1Ty+RsabDtdnNgUSsMhtNtCCXQOMCh/Jk/9lOHld5jBJiqg46qSF8kOy1WOtOfanOufk0Xd+E4dMnPIQNbF/6MFwVp0ZUaqsSUZM12yycXzrs40Ds9CshzN/P7nBBahjEG5xhaqtXrG52Xo8KX8brnvgTZQwl/PbwuqwubQDLBIow0D5lhIMuE/e7uDRxYuLI0LX0zlo5jSUOrgulOq8u07AhKqt9c0dmlgs3eNOr10r8ZG0N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ohXCWjlNiv3kvmvyvQSuSXxOdHuCvHa9Guml6UWXKpXnbuiKK+GuXwxiQn8y?=
 =?us-ascii?Q?1yBCib3O75aplkYjUei/Oxa1QzSKcM5wVMMLbecW7OW3w5d6H777qd4jINrs?=
 =?us-ascii?Q?MaOWkS5wI89GzL2HjeR+UrCDi7RB16iIfo3xQvXpugCsyy56gve7a70tmrB/?=
 =?us-ascii?Q?lddWbZCq1u0Hpi6lpO8cWrIDuAbmDuddne8alCicudiHNBJF+7DKqx3aQ0BG?=
 =?us-ascii?Q?mNURMTZ/CPlJn5jEfnIGBy/1YmQOJA+cay+LlhMaE40v1kwQlocx/iv43Qyr?=
 =?us-ascii?Q?+0tuSvjMceyF62G+ZjmeCHw7NGkaEOVxncDPWN5U7Z2gZT0xbWX5gdsdRwSk?=
 =?us-ascii?Q?aZ5ESwVH4qXblCw6vgw9REeB2T+aq9598ou+StD6k9p/EfYui3xt4E8FDHwK?=
 =?us-ascii?Q?jC/4rQB4KcQR0Nr5wz/HCWzGYg5RX5XtYYJbfZEJZ30/WTogWaavq22BAxLQ?=
 =?us-ascii?Q?rUAKa0ohf8301PPvPjijnMhJ9ZK1gUNEBCQ3LLZ2dQVa/Ci378ojYlxwolNo?=
 =?us-ascii?Q?SIUQvsWS/WY+im9qONAjZXBaZ5GH5+OVVtIN89mO21WYhmIv//NsM+paGA50?=
 =?us-ascii?Q?oNRGrNsTkb3pGjj9b0saI5RBjEWD6vYdE2R/tdK+VjaQ0p+B7l+Y/bzgOhO6?=
 =?us-ascii?Q?wdnJ6WLLZCb4+I6t8Eahr5PaZD4U7TH5xS9L7ICuuWGgzr9RCpjK1t00J5+P?=
 =?us-ascii?Q?XJvtQmvjnh9oMTwr4HIz4ogcIyL6JD0/ntZMZldtShTuVti+acOy3D/o3MC8?=
 =?us-ascii?Q?u2SdAdZErAjHRdbTVsst5vwG8bURcqz1pIbfwQPlzt8NThKyzy2Qh2Gs2zZg?=
 =?us-ascii?Q?90lswd99zzbxF8D8dgC6R94oA1h9IX6vfWnx5QbOdoEeGbvoYdR8YmfUGm2W?=
 =?us-ascii?Q?IoCCckStFr4aeEPUpB1cXDW1L+eIX7q/OK9dY4xzi9qs60Elqn/PNlQYMIYo?=
 =?us-ascii?Q?3h0RW0R5qqf1DZdDeWqgXFUcpvp6yZ9JgQg82fY5D4Q6KoIXFhXbj9njfq9d?=
 =?us-ascii?Q?mFYOFwXjPWzm3r4ycwEusAakwbUmNGnBih62kCh+aS0vbhY3OUhA8kwyQzhE?=
 =?us-ascii?Q?+qh2slArbiKiqRNf4bkFd7Mi83kmD9cvM9S+InDdm3oNTdnKpe3g2WjDQ77m?=
 =?us-ascii?Q?B/0tuaHphXJ+kVIwv/6rPA/wZr8wrDiX4cLjzG5JU+uRBmeQ0AgboPYffCGi?=
 =?us-ascii?Q?G408JhHZcOlRMcthCx7C9/qCJAtUF8b9HqjFyaq+6H+NZU6JW/UXSjaXhiZW?=
 =?us-ascii?Q?/IQl30X05PSF8T7vKdhQsPf9TQUePw11Uhl5fYL6lStsnhHzIV7DQA1TK/Pc?=
 =?us-ascii?Q?C1rVDEm6qw6Fr2Wo8vTog+GBrHwSUOQGBuA62/cX/2S58Y6dytiJTZyUIVX6?=
 =?us-ascii?Q?sXzaf7ku/PZu8EfiRQH9inO1LvmdCAOhJT55w9yPhffjtWHESGSQybx24Qo8?=
 =?us-ascii?Q?MvAGFTu9WJzxc5AQfBO1jkVyO/LysMV3kGnI5m6tjSybODhtgkMimBu74BSz?=
 =?us-ascii?Q?uEMi1WkAiRYOEJqSwKSPnoXo/9iInEdAZFrz+CfZNsEYNBEigjqtQ1sH7de1?=
 =?us-ascii?Q?UIjfn5wixl00Lt6r/0LSa8zDCGOczAoSCXj9wqhZ0NZnD+Hj4l7WQqL25EC0?=
 =?us-ascii?Q?P9PjfzrdzNpxqA/Q89mZP1Q6aF21f45BX47hYqZYSz2tF6lakiuEmpBjM6JT?=
 =?us-ascii?Q?18jZiFK/jbk/B2GXLJiQ94k+fcKYnlkopofym/2f17Pn4zxV7pohmibZNMcw?=
 =?us-ascii?Q?zkWOEkPnBw=3D=3D?=
X-Exchange-RoutingPolicyChecked: L/JuGKtnKSqrGjY+Cj9e1BHE6E4PNolIbQyoXAufpi6vMhmo3TsRs+37tGEHIe+vlJZojFZ2ZjoLOPqj0i5BxFWYnIH5PoBAhJS/ePZktOJJr7WbqOyBvxP8EP0LCC/nJo7dkZTuK5N8MLN4Ef9KVGV7gwScnVIjonUhLhghCc6trpTJi32uG9gUV28QDlrrbvB8zeo2uOWOWHJI4q4La869VdCP8PD5txy3AWVW3nMpEbMp+FdIbXR251vy/h1vI45uk5t7Hm4cx3SGRRD9RdUn/Mo46tGFBt0gECy6+QcNdnJgU2+b4T2O3qDHTm4GiruI1sWBmtDgAVxk825ZlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbf76b3-92ad-478e-c207-08deca0b1c78
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 11:50:20.8528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEsu7yScEHSUJQuOlwRwEJIraHaGrDJg8NOXLmVszoD8XoMtC2g9P2NMHSicf2sbPtjFIeEQV6IPQdlSakGjew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4965
X-OriginatorOrg: intel.com

On Thu, Jun 11, 2026 at 08:16:37PM +0300, Adrian Hunter wrote:
> > -static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeout)
> > +static int wait_for_quote_completion(struct tdx_quote_req *quote_buf, u32 timeout)
> 
> Seems inconsistent to rename the struct but not the variable names

Good catch, I'll fix that.

> 
> >  {
> >  	int i = 0;
> 
> Please note, the timeout condition in wait_for_quote_completion() is
> broken, in that the final value of i is timeout + 1 not timeout.
> Since you are in the same area, that needs fixing that too.

Thanks for catching that. This needs to be fixed. We can submit a
separate guest-only patch.

> 
