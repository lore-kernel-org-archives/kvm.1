Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045E37DEBB;
	Mon, 31 Aug 2026 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214275; cv=fail; b=pzO4CbY+j8cDl8mmFmmJVYcTa0dLoImmlVNaWYjzSnlFiPAW63OgFKpqtyxLiHX1qZfR084Fzabiq/nIIoGAnFfEJsCSzDBFgzqRJ6GD7FSUeLITYob3BhWdDnK9ZDCH0hbyL4tBBA/AqbeYv1PJsymfC+iVeFk7NjTfp/NsCUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214275; c=relaxed/simple;
	bh=Y4OJ8nemcyFTEAOOxOShtosqGc4F1FD+YCrRmoFhvQ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uOMPGAss0oATnmqF9JZU+G4SgDBdIF5AjETL/CuoiHCczWL0pFj/4ETC82Lp8JQBxZ+o1kG/vGeyQMhhJ58QHSOVUiZbXyPeWUiN0MfiqJH1k0ZWj4leN4RkgfMkHmpjCUTrbSyJX48PEaZTL79IBS4bCK4mJCAFxDpFm/7FYBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNLUi3hn; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNLUi3hn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788214272; x=1819750272;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y4OJ8nemcyFTEAOOxOShtosqGc4F1FD+YCrRmoFhvQ0=;
  b=fNLUi3hn+m7QoCXUUdtFOE1pdBATu3+FjYPi83PG/iYO2P7BvhKQdWTy
   XYDc3w7A2ZuAF6VPLq04du7JjJ2rKHISR8neHWQMyKMtaQLzHHqECY2mo
   fG7JOSNlHcryXslU9WvvHMIqu1qDkteQEMr2NT479MynBaH68DJ6C9Jfb
   gPidfY/Qg+xEmdP3unIpWtCn6Jl4hdTU1ea53IGMCXjza3DIzGPj/265r
   XRgYaIbXgykc/vSyYyd+P1dAfKZPJ/9nI1cFHDHD5DVZNfOQyw+1kKvAA
   2rtWrvx8hVWhljuicjs3SbUqwOYX85axmAOjlorRCkpWtjb4dRth+EP3z
   A==;
X-CSE-ConnectionGUID: /ntSq7StT1WQxSLv02eLlA==
X-CSE-MsgGUID: dWMPmzFvRXervFVh/6Q9TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="114169153"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="114169153"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 15:11:11 -0700
X-CSE-ConnectionGUID: GP9mVcqISIaM/K3pvG1b5w==
X-CSE-MsgGUID: oHz+0AvqR4umQprTo1NBZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="307133929"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 15:11:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 15:11:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 15:11:10 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.32) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 15:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AABGhqDr8WfYJHPvRq95Gz/58bas9idy3v8RpYl3TRDMvEgaORMyAaN6wgsJ0HByJhMTHn1NLQ3adwb5W+djrxy8icE9Gh6nkbIDMQuopVtjazJB2D2tTX5vW52K93vYxPdCdhoeZ7Y/UdV3uGTnbem7Fngm8IueFbvhwW9nLF6Zf6/U6216srbl3fFV3OtP0r8n3yRGQ2WtZSWewpVCagXG6qLVVvBcMDEqBALTgjHhCFTRtvDQ6G/c+bCfFnYEqIv+t6uFRDX3ksUKtxo/9Mmxs+RSDC6mBKBI2tab8PeiahV9o6tSCHI4s6E+ukbY87T7crqyjFoiRBgzAJkAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhInLjuOSVd6ToknclSzB+5Ld8hVOkmJNlq2yIod/5E=;
 b=Phc9ZeRudbMrV+oGYMjZR4g495QPa4SHoJ2GtjT8dnUEUR8+YhG0/S74qKFT+EdAS1DWoZeawUwkR3Ry/46NLoqDz2rSYJiGH53IGXeVpKBVObYF5zMqWCtIsxna5WuA+R4WioluxHKjoBnZQ85OzR3Ma5BLYmg5T2TiCH+b5RuBe8n3vBRHbHd2Ybtre9UPAutGQLADtKAeQq3H0vXVgyjcPj5HeVYCPfwM2hX7Pzm+RUPJ2RZqwhBqDbjq0a3BZmjapNOliLYxxj/VX6J0z1LLVsuEhd+/ahWjqooWIQpuARpD1dSaYlh4ni4Yq7GkT4ogCtivmasJne08afaFkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by BL1PR11MB5319.namprd11.prod.outlook.com
 (2603:10b6:208:31b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 22:11:07 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 22:11:07 +0000
Date: Mon, 31 Aug 2026 15:10:42 -0700
From: Peter Fang <peter.fang@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Xiaoyao Li <xiaoyao.li@intel.com>, Lisa Wang <wyihan@google.com>, "Andrew
 Jones" <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, "Isaku
 Yamahata" <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, "Sagi
 Shahar" <sagis@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton
	<oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v14 21/22] KVM: selftests: Add ucall support for TDX
Message-ID: <20260831221042.GI33657@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-21-15ad654a50db@google.com>
 <6f89fc78-0344-4a7e-bbd8-ac201b8f845a@intel.com>
 <20260828020612.GF33657@pedri>
 <b4cffa34-864d-4fd0-9fc7-a7d4514075b2@intel.com>
 <20260828042044.GG33657@pedri>
 <apGYxwdCSuC-X732@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <apGYxwdCSuC-X732@google.com>
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|BL1PR11MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: 95cc5077-9a23-4d10-3a3c-08df07acc183
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LoBsQGJhebOOOQkJ3/vYGUKftOs1I1fGkjYagRMgdrbgIjcpg6QoebVwm6dlhLVvFpWyoKvcUbpxhnRCBguY6g2IoB3ZdyAjv9q1hjbqpIr8jWGjzRbMhD9d3wxqs3ZQHJ418S8LOKTP68SIsTMpDJzM0WLPhyL6FypULXpbssLQZbR5P2nG9pnwmmdbOpNAL2ihlQz75GF+uFRXn5SVGvxGFoXjBqV1c1JwvcyauSWjTk+YLEZvvbv1gauScQYxSCCpoj6C1V+HvZXAlSeEHBmtZhplLRg2AHElfw/qVDKJnvOGF16rzbotZTjF+r9WxrDkG3kGU1rhizt/fuOncZalXi1raSVD6Z/I77sdjPYB+Ns+idyGbq4jEXF8xli7mtLHw1vyv1WEEyIwjBOCcy0B7bKmqz3m4XUQqmKXGykKn8/kM51AUPiIxOde1Hm9Z7LcI5U7t+o8701bK/hABAnRyEzglezni0XQAKxRYhn7CjZWBJ6U4Mgou+4pszRyvHNTHldpBe4gDBl9EVvzMPvj6rA+ixgrV0sWgQdd499Mqv6WohMHp/Ch9Z6k32j188gREeQtp4SaC4y3TM4fzb94AxSRRNfxEMKLDoQ6zrr+UjLz1i6COO4gBe0HfC+uQcnQdcYAaL3npg68NB8tIlEBIQoNVn9RtkkLmQolu0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c/IbiWxqJfQX9U1y1+eXJrTXumFzUKPV1mOIlDgE43OGnCmXDE9EWBoKPxzS?=
 =?us-ascii?Q?kbtPeRf9dZ9Wp+7oMBZ4LNHLonRfpH5Gn5FQsridG7cr1zLphUE7a48OtkMn?=
 =?us-ascii?Q?irKtR24xUiQ/5tnBFAu2FND6I7jNQpNcPDfmaWZgFBp2Mm4t7wpzE7wy6fWc?=
 =?us-ascii?Q?E02J3Bpxd8SBVkmC8MdP0lXx19e2OdOA3giS6BGuJDQMv8KJCDEj22+7WCFI?=
 =?us-ascii?Q?f8f35Yl56BlmiW7AnIs4zbuClFZyP0lXvdIrKU1AokLEw5+LqjVDsLFtgKx7?=
 =?us-ascii?Q?FqEQYnJCWTZmtcujE1rukFStNPl9s0ogLmaGx9fcqx6NAjDlpvVGam/c9bgr?=
 =?us-ascii?Q?YKWJ6f9FtCpuIfcYzzDB9zX3cBuuOyIW2FxEMgo5dlXxmldpMzrf0LXlbeRl?=
 =?us-ascii?Q?BY/BLyL44BoEQ6eZmEgQoJIqas2Nl8HbpFSJ0GrccETrdJ3idGffY1LGk2Cx?=
 =?us-ascii?Q?BSNUDeUgnAA8TYU8WpnWlPUAajjOFmrnkKob+x9mq9+KtckIW71UyQcDAKOx?=
 =?us-ascii?Q?P+SAyXZgDbysGARVotRMwQxF66++EXXW6lepf+6naGk4plStT76EGMsxiWsx?=
 =?us-ascii?Q?Zc6CU6q7xqYd/uBMER1pFB3n7Sqe9jmqEi2yk462T1ZMAury0uzxOw4Wcs0z?=
 =?us-ascii?Q?zlYS2XFEAylGgJ4SoWaGIb2Ha5/92Aiu3yYtLOZlHSj/G7vPf/vMfLl0jlMs?=
 =?us-ascii?Q?VEIc4JimWyofq863Gg+fq97ek3MY6X+ObahU9/gCsnP36ubNTmLiIQMItXLD?=
 =?us-ascii?Q?rD+LDGiPfcWpxtuJ2PcJnb5Zz31tHbX9md0ANphalTkQGxLrWtvd2UzOm/Lx?=
 =?us-ascii?Q?lm7FsSeXzK3+Yz752/vJgKX9hLUBZQDuApIH2c6bXHTEfMjRRs3tpK4bQOld?=
 =?us-ascii?Q?m1RgLGiK1LVlb93Me+gzwatfDfpXTbcst7rI/cW0Oz/s0g54Gp2JHhLUPjFb?=
 =?us-ascii?Q?VssrqmH6+FHxzkvvl/FwApVOvD4urKewUyAlrSMaT7bVPZUGrFxWWdBbUg5m?=
 =?us-ascii?Q?gcec4KegdGAal/6x2BHSEEOuT9ZVpsZuEFBjwjSgO94Awkx2pO8Y/kvh8F+l?=
 =?us-ascii?Q?9vgP8I1A0XJ738rt3aX+Ec646ZfCAAkPD5vll4W2GmnzpLZKIcAcXzuJVV54?=
 =?us-ascii?Q?8HAfpF42uv/gse9wrdnmXH+bbdJSEpfMhwaORfNwy53Fi1Flq4MpNdBqVmUW?=
 =?us-ascii?Q?ZqqpFQb7lLEHcCD/1Xi+zZ30C5cipDJm49DpAxl/K/cjthSLAwD/Up3wnlPA?=
 =?us-ascii?Q?Cx7u2P+121LtnqV1nAJIQvMOCat5LUETInfBC1OdANjv1nKl2THkrFPhtWc2?=
 =?us-ascii?Q?HpfdFTwjwJkpx6rgz0r4zCdNoo45j4OuROh2k6vzDztfNOvopMKPMb1W+ZKa?=
 =?us-ascii?Q?mcwH6B4v18thwLWx+i19qdgcRVwh+K+FN36ebK5xIGyTVPYkwcoORC3rFhza?=
 =?us-ascii?Q?aVcD5SG74uCGwZ2MQWuwA6IOqaW1kWP42h7s2jDfUB+KhrzpuGG/G4aP3C26?=
 =?us-ascii?Q?WSbfpxW7NOcUCu2Kc2xmWL5mbi0CYmSpfG3pa4MegfoaSxY1OrHsDfTd61ZC?=
 =?us-ascii?Q?uZilRRyptXHzSVL1ZhLf5MvUGqcisv8WB4rwpIryG1YO1B9syEDhngoWOxYU?=
 =?us-ascii?Q?/86WGCirrEqGmbCnF035Hwr3DoMfHh3Wz7cBXgJSyvlc4esHg/qITGOsjwQJ?=
 =?us-ascii?Q?lAKoSFSHfUPp8rlK7UX4guVmL9SgkHozCkfbZqvo/oFp/xMFwlTWMP5WLAj8?=
 =?us-ascii?Q?Z3uyttD+kw=3D=3D?=
X-Exchange-RoutingPolicyChecked: eHVt7YUOCG3Yr30Y0Gt9Pk/d7kFd6BZpY6Z6+MIqpQypFBcgQ6MPfdoHDIeIJn13uHhQWhaVdCIN67hM4xzrpaFGPcLHZTf2gsy0noFB+YTCNWiEEBlCOTB65bMP4O5pFyrPS0hiu/Gik2N6DBu8BpWc6IIuXhtcPV1S4Y6X7MYjC59xifrp15F3MYINIFZYF/DAlruQq8tlio6lgNzfRF8zoGA3+iplXxptixb92Tq46o4w6t2HfbhEPZH8Rll0wpEXtGAH+49+klX2epItBb0cKKPfQMSYA7SR5vnoYgTfvIGqnZmzN3rkP3i/WiNVTc7PwAxMx9hxrUYpzyIDDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cc5077-9a23-4d10-3a3c-08df07acc183
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 22:11:07.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmgLIqwWca68j00q/q6+InjqTXIdCm2COR1+zRPYIo3jE3STnOJQ5WslRJiRNqG1JVZNEk4/ptYCnPXk+cX0kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5319
X-OriginatorOrg: intel.com

On Fri, Aug 28, 2026 at 07:18:47AM -0700, Sean Christopherson wrote:
> On Thu, Aug 27, 2026, Peter Fang wrote:
> > On Fri, Aug 28, 2026 at 10:31:14AM +0800, Xiaoyao Li wrote:
> > > > 
> > > > Hmm... This makes me wonder if vm->arch.s_bit below could be replaced
> > > > with the same architectural approach. GPAW is available through
> > > > TDG.VP.INFO or the initial RBX value. This does require a bit more
> > > > plumbing though.
> > > 
> > > I'm afraid not. Because below is host code, and vm->arch.s_bit is not used
> > > in guest code.
> > > 
> > > Or are suggesting something like dropping the
> > > 
> > > 	if (is_tdx_vm(vm)) {
> > > 		ucall_mmio_gpa = UCALL_MMIO_GPA | vm->arch.s_bit;
> > > 		sync_global_to_guest(vm, ucall_mmio_gpa);
> > > 	}
> > > 
> > > entirely and use below hardcoded value instead in guest code?
> > > 
> > > 	UCALL_MMIO_GPA | 1 << (GPAW - 1)
> > 
> > Yeah this is what I meant. Just drop sync_global_to_guest() entirely and
> > do things like a normal TDX guest would.
> 
> Blech.  Every time I come back to this series we're still discussing ucall crud,
> and "doing thing like a normal TDX guest".  Selftests aren't normal guests.
> 
> I know I suggested using the HPET base, but I only did so very begrudgingly as I
> couldn't come up with a better alternative to emulated MMIO, and the end result
> is quite gross.  Not only does the code ignore @mmio_gpa but still obviously use
> emulated MMIO, it requires synchronizing data to the guest because KVM disallows
> "private" MMIO.
> 
>   void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
>   {
>          vm_type = vm->type;
>          sync_global_to_guest(vm, vm_type);
> 
>          if (is_tdx_vm(vm)) {
>                  ucall_mmio_gpa = UCALL_MMIO_GPA | vm->arch.s_bit;
>                  sync_global_to_guest(vm, ucall_mmio_gpa);
>          }
>    }
> 
> Retrieving GPA via TDG.VP.INFO isn't any better, it's still an absurd amount of
> "work" for something that should be trivial.
> 
> Can't we just abuse TDVMCALL_REPORT_FATAL_ERROR?  AFAICT, there's no restriction
> on the data payload, and there's enough space to all but guarantee we'll never get
> a false positive.

Ohh interesting idea to use TDVMCALL_REPORT_FATAL_ERROR to pass through
data. Yeah this looks good to me.

> 
