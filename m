Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965535DA45;
	Thu, 12 Mar 2026 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324806; cv=fail; b=S0j0nX/63UcbTB1xqVSZUqGu65RBPy8kG0j9tyU1xwzKQDRXa4WJN4QORTlkejrMwDkfdpljkcDmX+GvKNNqr9Qbr9fjvvYNPIcvGBrahq5sWTmvwQ+wVv7A3S9HlNLWwbrmGHqho7DeZH5AurJVnnZccZfX6P+LlfaSJLLcLmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324806; c=relaxed/simple;
	bh=N467MEub037Gj7Ny9QQiF/Y4VSjvdXgXMAtAio27gUc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z1Z0r4ZpVACM8Xv2HI3z7yPl97b079qjyLLad2aFaqAgLDqNvFoYwI87UWvdVnV7R4Vkn5E/k2xM169zCPTXinGMZhtA5O+mOwvc380lBYBaH5O3pRACeQBitr9pONxe3j4zRsbhpqQ+N8c1H5pSaXoNKzdXVfx4D5wwRa+1D+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5QUj6nr; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5QUj6nr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773324802; x=1804860802;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N467MEub037Gj7Ny9QQiF/Y4VSjvdXgXMAtAio27gUc=;
  b=I5QUj6nryciQf2KrMGwEXQDN3CNNtrluZ5yyTsOvE4cqebPUxcyeY7By
   HUEvhU/KVoxnsVlgUMA/u6Nnier8JQt+L009STrcINncRGUizVSbs5l7Q
   e4vJOLZimgTDA6FsK6rVwq7KfYebY0CAsnK0XUyYoMpybeiuao9EwbBly
   Grba1vAJSOpn/f5nCtKxPsUgA3uthg3TZTfXq2QtqkWPSe9BlV8KtJFJM
   NiHd1VhasKcBxDQNeUJLtdBPta8/Xo2jopAWwvZmd/c56cC6L+7rtAUds
   zYnOovnwmKYvpfSyzPBLIQAZ+usABLf8SllwLpFK0FRpC0vkJMlKmXHsl
   A==;
X-CSE-ConnectionGUID: gNsp6IbbSUm3GLGn0z5eDw==
X-CSE-MsgGUID: 8s9WrswfSpGQ8Pzl9/5HRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74309308"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74309308"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:13:21 -0700
X-CSE-ConnectionGUID: hFtndQiiRdqPxRZ+RZ1eBQ==
X-CSE-MsgGUID: K5/8TBhGSSiXQaKxMt1vqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="243861344"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:13:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 07:13:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 07:13:19 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 07:13:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prqcFx9wyNfqwfZ3sMMv9JHqLOTW2DgxDr7G2t9O9U3/nGDSdM85LuZnS5klag20ibQP1xL8ptZFsB+6peyOHGe+8pxMyt8Oy/71p3IqZAyUcLdVAdhNHypoA+sTHhOWIyndTwMYYyC+qaxmdwXLjsMMdWx/1c/BZEFDI+NonkfXFMv7rpgANtU2Q4xabU1qgUZzrsqYZXKE/Qlk0NIueQdUgrp3hoUDyRpfmPkXmm2kw1IhfsyduF8FspVMk6z9ZHBG4PLWMPsP2qvZdDZv/kzxZpBE+f+pNSsE0Penbw9bPiwgaG/aeqflubJqEPQ9GytFzEDQrUklyIVKfoBW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lP/oAuDOLADBVyud4ckERCCiCnggsD6vXb9NPJmdttc=;
 b=o68rQupKC9N7ZcDOnDWo1xw8aWciB9+zgieChhSMdEBYti9lPVAQsff6f+xaQfXncfuYFxn+/ol8xC3J6vQLeswDTiQoYzIPFj43XB7cKoz+zeyNNhG7VaUeC81g/hBbGmAynNdwgJm88FceeIc7QkB5udfxNj1qrIdGMlMVa0sCoTzCgwXU/OJaFwlvgw3WaQmqElpTAJ9gyFRs1AzwXxAJi5cDzCxzL+PXjS5CBoyeocb17aZQp6tVikDFUdIEWWTxWFfYhAZUu6ehT1aM2gvuUbRRqlA3RxYRytQmcof6ShW2XhxOXQBYxNryCfnP49f7aJmI7GXetWBRzczlYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by LV2PR11MB6000.namprd11.prod.outlook.com (2603:10b6:408:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 14:13:15 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 14:13:15 +0000
Date: Thu, 12 Mar 2026 22:13:00 +0800
From: Chao Gao <chao.gao@intel.com>
To: Yan Zhao <yan.y.zhao@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <reinette.chatre@intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <dan.j.williams@intel.com>,
	<yilun.xu@linux.intel.com>, <sagis@google.com>, <vannapurve@google.com>,
	<paulmck@kernel.org>, <nik.borisov@suse.com>, <zhenzhong.duan@intel.com>,
	<seanjc@google.com>, <rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<dave.hansen@linux.intel.com>, <vishal.l.verma@intel.com>,
	<binbin.wu@linux.intel.com>, <tony.lindgren@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 09/24] x86/virt/seamldr: Check update limit before TDX
 Module updates
Message-ID: <abLJ7NsAn20kJWJc@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-10-chao.gao@intel.com>
 <abImiYEAOH29tq/H@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abImiYEAOH29tq/H@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: KL1P15301CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::24) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|LV2PR11MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 813f2f80-9732-426c-518a-08de8041809a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: bAPia9SHNwobrhiZ4/YO+ys6uI0poSsfhychkUY2PzTIuOWA4xKbB1OkWZNNK4wVbCqpSH2NHNAIFLM/pw2VXXRNbzGpH3+BrnJitDsZ3dEqSqmyuBUH2jcLsWxFcy8z1Kduo1QVWa8WNfNLKlsC9pDImBc/JGzrdZ6R9RjrvYv+NZbyNvOJUGPByW1lJsRYj503mYzezqn87Vy9nc1gvp4+mhBvVxJPZbVCcayiEMAJ6xwfoIF7uoXoslMO8HKfD86K5jDusWKqcHPSkldNaZ2IdmFb+E7Vk9Xs93cNIYbHWrN39Yj5/AqiGPAo1Sb2wRFz1SrSZW01sCfGG/UaO12o7iwUuDp2/kCRKVPUDRYZyfc44qADvXIVFHeFI3btZ2ImdqEWKhSx5qVgVgpRM3Tb0AVRJqGGxioy/I/rt2KdyFikDlyZ2/RpjjpCPDC7gmXF9wrsvZ469TdEWuznxxRPp6ZRjU1ylINvNI0dynIgUW1aH0qoUEFIxwA4KwSaNnjvJGbJda4ientKrieMqCZkTgE6rECbVQWzEMnA6Cgz1JkQoLK1ws6XFaiBqVco5RFDTqYA7j2xmbd9E1q5SeD3m/XnlNR2RaxQ5wlbG83VWincVtpqCTzB4GcB963gF6nieKczrU73gwSAzHpsSwCk3nth8GfDscJJ2sjFEuUJDiORwp0LwbQFzJoKTbgMx85ibRkf71ZN1YBWFgbwf3d9Uc8TPILqt91KTCTGiwI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FBRLg+GB1HRt5fVc+mbAfe48O1vJ9fytQjnSnIYUulh/FKR1Jt5Dq2/el3xX?=
 =?us-ascii?Q?2uKA5fnSARCB2BgXnV2f6F/uoUXEmi0xmf4WBiOyzXgxswZW5UE5oR9UDqkb?=
 =?us-ascii?Q?MXfZLZrBFulXuCOc7HPTSBN+XCo4e2tEXmg8sGArlSPY91K2YOEIajbOVCUA?=
 =?us-ascii?Q?+slbxjctyW9kxXwXHAx5iZPoZ66W40H7EGeNH0ScNxzS5Vlt241mBzK5sLWp?=
 =?us-ascii?Q?Y3nqwf0b9To+Qgh0H+iAOaVf+S7UtaUvffA+DvI6OUjPlK+4ZZs+ZFDtm0dw?=
 =?us-ascii?Q?RdkZXUYIG0VYjbOIoZ/MauS2t2/Fkjb9uwErVSVb1ou43Ak3jOXk6O5ii2rR?=
 =?us-ascii?Q?X9l8Ed2HgqipauvMFoxhptxAgVBW0DNq1J/l7SaZD48HB7NZ34Ep3XAtPozr?=
 =?us-ascii?Q?sXshWdfzl5wT7VO2G4haf9tx7yPJ8tVf947ymMbGFdv/Th80ROtJLEF+HJ4u?=
 =?us-ascii?Q?h2bnEcsPBXPS/Xb8KjFjmGRpV0vrPmyVWDT0aAaj2OW/DN0zc6sSL4HJQpTr?=
 =?us-ascii?Q?Mm/QogAlDNA3vf2/ig9V3KXQJDN5OEMYCshfh625UBQOYpx9UQjitZ61zf5l?=
 =?us-ascii?Q?KY8njyV2mwED0wChqpX4zPf25o6d49XNxKyucTdvFcKvpHmEoOkKZJSIH9mU?=
 =?us-ascii?Q?xmnGNgc0kedc3L8ZqAMRbf0k5V6LUhEtrwIysuvXLH6ZgBZYPbvWnjpf1A9g?=
 =?us-ascii?Q?KYvA5lH4k6HAUGo65oBSqAVXvDrt79nKivaKbipLZF/1TmEOR0eBPzKLCX68?=
 =?us-ascii?Q?qP2X1BybolAQfPiulEwAb/ku+yRMB7an2t5aGz87QlBfS7POGZoVDqJli9na?=
 =?us-ascii?Q?4AQgd70e8SqaudxQeYQoqhgGKSwTLUuSQ5HPrHg80/NDoyirl2Ud/vTO7VJr?=
 =?us-ascii?Q?0SxplL8HWgOF1vE5HvORIpvuSdM9VI/qtpPU0OQGDYfr5vRgl1c7nOrO6TfV?=
 =?us-ascii?Q?C0uu266QAlpPfCMDiDjB76Ul16i9Bi88/5SMl9Nzzt+Tll83G+HkrfgCaaU0?=
 =?us-ascii?Q?IWLhFBVnlpQz6osrLwsMFkkW5BBoFDfcfWw2GgMM4s6VXCWFX4hPH5uSoBfQ?=
 =?us-ascii?Q?dyYfIB81C1e3znt7ZMhpO/rRFeWXnsV2QOlUtqzs3Jx5vyONV3JXJ8RWX4y6?=
 =?us-ascii?Q?lNkJDPG8ognSpwdIE1LueXUEjsVwwdjbRWTz5RAMPcXRqJLAZx96dlkr1YeR?=
 =?us-ascii?Q?AMYHRgR+Iaoe0YDYa1P+mA7cAqrMmHvQ3KBdzn2y9na6pg64E6Aq8DI6U7Yj?=
 =?us-ascii?Q?vRr3179pKt6fB4KndPubnWHJ9lxwjpoXLXba4h51+3YumeVp0tA21Qng5ohO?=
 =?us-ascii?Q?ICx8gGhYtACywwB1BVQTdPbR9dIvmLPN+MxGf2mtW13ff0fgiyGWduKlqkDC?=
 =?us-ascii?Q?7cHX4QQFT0JPcxWb8yhq9XNYx6ruhScQ+0B+a3MsnT3UIgA+y6X+6gxcXE2y?=
 =?us-ascii?Q?dqyg0FqCwqvHt3u3VCLdOmnjBArpRwuaMxmM7tvXwrBPGjrOULthwK+m7zMt?=
 =?us-ascii?Q?ACvjS3AGtrW32dWTUbXbDCsBZemo1w0gD1RXahQxBga5RMqc7+8FIDmIkV0P?=
 =?us-ascii?Q?zm8ILh6GWc+RA2CV0eXYzHdNMaBcaF1ojiZnP8fdHKmB1SyKMq6Ymhl78QLZ?=
 =?us-ascii?Q?3WUzIgqXXnAyb9N5BF1OOWRprO5HGihzA+F0bR+n0nUXALNxB0equ0NlnAXG?=
 =?us-ascii?Q?kEX90GTeS5nPqA0LO+cYam1ZXDrj3jSQUoiHUUQ8owl5sfKnR2bSHCksSogZ?=
 =?us-ascii?Q?+IsMhiPvvQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: PW92CGyGyPtOjTMHPDPtji7VPldIgwJfhh3o+ZbUHXatJ71QHm1a10flyNEv03rH/Orzg+zv6Ci7pw4Pbj4Tcr0TAd1/4/7Rd0Eb9bwvAn02EsDRJNRvHQv4obvDSxYrf32I8Q9nLe0Dq374LwMoVy8FvGj/wFTdnY5G1HAL4PapWxhxiwupVgOgFmS4PEdJYpwRIKgCkfWHsIMroTAZLeWtQZGV7twcwGJ0slHDjdGJXCKCn3KLU10M4jpA3UIWaKd9YsNJfLHVKeOsa8T8dtIbf9R6B4zmlO5PZlAEku7jU2DyN1QkfEwF43KiE/a4RV+94P8pJ4pXFQgjuCyk9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 813f2f80-9732-426c-518a-08de8041809a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:13:15.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GccVtEn+69TlxtX/vnBCnmfGPvhJqYcf0RTOjkDcy+dKOck4lcqgLq3SKSkTg5b9VS6kqef/Ta8I064Ua1Y11Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6000
X-OriginatorOrg: intel.com

On Thu, Mar 12, 2026 at 10:35:53AM +0800, Yan Zhao wrote:
>On Thu, Feb 12, 2026 at 06:35:12AM -0800, Chao Gao wrote:
>> TDX maintains a log about each TDX Module which has been loaded. This
>> log has a finite size which limits the number of TDX Module updates
>> which can be performed.
>> 
>> After each successful update, the remaining updates reduces by one. Once
>> it reaches zero, further updates will fail until next reboot.
>> 
>> Before updating the TDX Module, verify that the update limit has not been
>> exceeded. Otherwise, P-SEAMLDR will detect this violation after the old TDX
>> Module is gone and all TDs will be killed.
>> 
>> Note that userspace should perform this check before updates. Perform this
>> check in kernel as well to make the update process more robust.
>> 
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
>> ---
>>  arch/x86/virt/vmx/tdx/seamldr.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
>> index 694243f1f220..733b13215691 100644
>> --- a/arch/x86/virt/vmx/tdx/seamldr.c
>> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
>> @@ -52,6 +52,16 @@ EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
>>   */
>>  int seamldr_install_module(const u8 *data, u32 size)
>>  {
>> +	struct seamldr_info info;
>> +	int ret;
>> +
>> +	ret = seamldr_get_info(&info);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!info.num_remaining_updates)
>> +		return -ENOSPC;
>seamldr_install_module() is invoked by tdx_fw_write().
>Why don't we put the check of info.num_remaining_updates in tdx_fw_prepare()?

Putting sanity checks in a preparatory step makes sense. Will do.
