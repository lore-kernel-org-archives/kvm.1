Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07F23A381D;
	Wed, 25 Mar 2026 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432247; cv=fail; b=Mh9a9Z78QBNClEQS5DuVuZ+HOyUjA3TsJHsz0f6IiuO2EpKbfUHHwQu2kvCYS0WG740gaqQ9neh4dZqkoL36Ik613NjIF/xTEhJXuEgnXKMODjRSE41XEPIbI8zzMukv9ES7k1TuYDpfdQ14KoZN7/0XxGxSreUToIiCFDKDuYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432247; c=relaxed/simple;
	bh=7b80F/3uMYzQLzEfVs9Z99/QP/Orxlrp0uZ0L0yjtf8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=INdjsbEhbRi1mVp5GsfQCw9CN8wOIjJTF4MXRYea/uj2zSloja9IbQ3xLGQzJS98aBbHzjCOgKBbz6vgj+GQMbXCIKOHVyrN+Pw8nFuf6tGdHW4cXJd7ZKcDCjvxKaD2qWZOcKS0VFufFoBmE8Bh1BqFsXW1kdtU/ppISD985CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OT3U87m5; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OT3U87m5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774432245; x=1805968245;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=7b80F/3uMYzQLzEfVs9Z99/QP/Orxlrp0uZ0L0yjtf8=;
  b=OT3U87m584pQBFIYB/4wPwDhv+pI85ZdhIfcLskSWAE7MGXoC0fM7zQX
   KAZfhdDiMcBLyk9mG9SGV4HMGBujJR78veyB4uH13M90fbHI4Yy2WnN/3
   AWEz2H5LsRwVQF6jkUk7FwA+Ytlk92queyM9gIgvnbdMVyHWGPK5/ZOjI
   idkY/Rm5Q9p/62sdiSPw6OfusjJSsQfsW7jm+6Z4aX/wvSYoeUVLtN7we
   oJgaAShIZcYHr8qB6iREFSPBPPUYSCMH3z1l+Pqm1WJ1FsR0N+RsWEXAB
   NhT70NU719zZkrWjAOXCO70ImSSH9clRbuYRycXQxR5h0oW9Y66OUROiE
   g==;
X-CSE-ConnectionGUID: uZtDLxrzTo28m8wuALSJmw==
X-CSE-MsgGUID: yZ5e679jRjWyNfZzHTxdwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="98085538"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="98085538"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 02:50:43 -0700
X-CSE-ConnectionGUID: /F7UlrO3TrSyiCLMjOOhPA==
X-CSE-MsgGUID: EB7DQIUFSsOD3Bpstw2i3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="248153087"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 02:50:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 02:50:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 02:50:41 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 02:50:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiFMOY2d0JTrGgkZfMMyBjPEZ+N6b/JoxrH/g1q/+GRsGTdox9sTdNMpCR89BFuPxUuowtLmvY1BkvQK+LbgE47A4ZXzrRENAMuuKedq/hZyPtP8xlXRHz455uJZ7tP11yq/+2YLnB3lDLL7NiQtYqW7Urop5imBeHz8x5M9lwgebTOfolfpHNEy1i4vz68jlLcnwCML0VxoHhjGDkERvj6XCJYPbVYzkNVXc9ktNI7DjdCEptCnXl+KCvpZE4Z8tZaGFhbWDWQS/2eXEyO6p6l81xGGy6ljN/34DBQjn2D4lxlmeApVzJvDuQHhN4KMUKmlq5KOX6K19izYSPDQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34BYoYoswtUSVdNRjCwQr+cMRvuLKgtn2KHpcflO1vU=;
 b=RaxzUAMCUw0NXCxOC0gmZZB4fUmY1ihQ5Sl1kUiWIcDWUJgS3voZpAEpzQwMQkG1vW/APsxs3iqve0YWV6YRYJzHdPif6G+xF6EmwD0I93rCWTTcnQ/gZFH7Jck7QFAyvXI1BhI2rK3tc1LMKriJHKBRK7xpMMqTr0u82PjoY9gbxMhBs+S0taI+QoOnc5GgX9jS+PjURKpCr+TdNrVdCWD5icqfG36ScEZpfY5iLKGn3HAI9FFV3rHuDdFTxZemyYQLHU3DuykdJBmzkwbJnILYaQnc3GXFdps131DHBR+GRlzyahlKn/0ocfJhDRO7nOArO7ozX0u/Gyde4avG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18)
 by MN6PR11MB8146.namprd11.prod.outlook.com (2603:10b6:208:470::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 09:50:33 +0000
Received: from DS0PR11MB7457.namprd11.prod.outlook.com
 ([fe80::4ea:83b3:a90:5436]) by DS0PR11MB7457.namprd11.prod.outlook.com
 ([fe80::4ea:83b3:a90:5436%3]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 09:50:32 +0000
Date: Wed, 25 Mar 2026 17:10:56 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <dave.hansen@linux.intel.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, <kas@kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kai.huang@intel.com>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@linux.intel.com>,
	<vannapurve@google.com>, <ackerleytng@google.com>, <sagis@google.com>,
	<binbin.wu@linux.intel.com>, <xiaoyao.li@intel.com>,
	<isaku.yamahata@intel.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Message-ID: <acOmoOP2fFUyOByC@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005703.8983-1-yan.y.zhao@intel.com>
 <a14531ab-f069-41f9-8c5c-9fe6f28a9454@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a14531ab-f069-41f9-8c5c-9fe6f28a9454@intel.com>
X-ClientProxiedBy: KU1PR03CA0023.apcprd03.prod.outlook.com
 (2603:1096:802:18::35) To DS0PR11MB7457.namprd11.prod.outlook.com
 (2603:10b6:8:140::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7457:EE_|MN6PR11MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: b7371672-6afe-44b7-72b0-08de8a53f469
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: DO/ZTz8m8KkmFfMk2nQLk7KY5gO7hVVk1udRMzFdg8vZIm5vxlV7ZgrwuMZDYZvUg+jm2FShR1UbJxjrgnnLPaagtRc+QFKzd7HW0qRMSet0H6chDHhoppVErg63qk3WzN8RpE8ElN8rB+nnIOZO+1TYE2qFRuFu51qnvzEGOur3s6D++xldTCD1KK6kaEgrx2UEksi7z4XDLHrWParbGox0dCD+f+gihRRxF5Jsr5ULj1gb2Z/J5+50V0/LhWRTgR6NKuwoJ0C2Y4CgZsZHsgZWteoleuZCPgUQpFLmPZxXS/scvMUxwwLvTxTLIRmzOmcOO+eLErioaB48gzKVpetrENMcH/PTGILKe4yvSBXKRbqp4QI9hUpjrqdjM7EB08WvT0myNm2a0qhGoIrfWWkOP73/uEGztHTpcB28d1YcY+CPj5upy4r3Mk1KYlm1kOV7MBajguGf5ncM35nLo6KfygUPbWCHYb8zAFgiv1Ow6VCbrLRlxL2HxdVjDCw/YxURKYE7OeLnVGTokP7LdITMuUQvjmiDIbaTVE2IB/w/rVl/lpZhnwiTMKUki9mqRAFVEmPu7ahaSMHKWa1T0N6y+TsZUdzT+ziusXeAl6o+m5yIBsAy/SHyx2ZkGebK/d0EUq4Lr4qBYQxlD9VCxFitNIckBJh9IzphTyx4fexxUnnnswREUrqhxR55yvwo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7457.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BD6h5YfF6Jqp+1IWebF6cMWibtWzH1au8ISTC4XYxHcHLLYaOvSeA1ODxDPe?=
 =?us-ascii?Q?EZasG1n/JadQ/hokH3UHg3RBLJZerzFA8beWHfHBLeLwm0maAsEAfB3uEF47?=
 =?us-ascii?Q?vrZID/WQ6WuZBQzUMqLvl2A5Ttqw4OgQqj6vAJw2SBfedl112GomZvc60Dk3?=
 =?us-ascii?Q?Mcaums/m7+8EWUY4+spxDHDJIphw5gz56b2uT2WXZ6VIDca0HjEVp1e1JArV?=
 =?us-ascii?Q?GJk9EP32ovID1NyjyLd0Kte+Weuc49hEEeAgZ9kF6mWGI0B/+drEXZjkiOsr?=
 =?us-ascii?Q?UdHU29S3YkGvSU+LGuem+6rjJ/Q/3ydeJtcbXIRscqnqh1STANyGYIdU67Oq?=
 =?us-ascii?Q?cRE5i4tZRExgc8+xlDJv1a0jXBSy+dY9NPXgRk5W7PNn8nyIupj8GzMLz4HN?=
 =?us-ascii?Q?Z1ks4KjkqtzMvasNUsb+p63XlIHQKdCsqMexs260J4FrGugt/U/mFCR/zpH9?=
 =?us-ascii?Q?i4kBdr2dobC1+iigKGxRuNC/mu6oyhRO3wpukeWwUgoPL+SrjD9BPX57mRWX?=
 =?us-ascii?Q?DWYkcaPSmMhjG5B09xWu2b/Qn+iopeZqthwLgy0QGzma1Y3zeoyvkCJQkgxH?=
 =?us-ascii?Q?hybRiHMRmKJ1VwxTKJeAHtw8ALe5aEkycx0aOpRS5KS7fhOmNUp75Hwc4Gb+?=
 =?us-ascii?Q?WQw1fG0s81DbMQ5Fv0JulS9Exhgqq038im8ZW3mgYJ8jM+thgDDIo8JAGtIK?=
 =?us-ascii?Q?cuYW+lG5g5NYASyMPHEPsLayIwJUDPNaW2CteJgXW3JrNZGEL2X/D6niT9D6?=
 =?us-ascii?Q?oGpeEjgz8Pkah8Dfxn9b1acIcGIl+yFfdXILQWdMYHkGat8tTJG1unGDXEjr?=
 =?us-ascii?Q?InA3rQqqqRoqyNCNsXgujwJJXea89DXx4es/ZK5REcJwwfVzqCHQjaz/V5Hb?=
 =?us-ascii?Q?akXnbhZkWEYwZqtSpvQ3V03Evk/9dgFQNr6d+MCS/+/jsNt8TFLjk6uic1ul?=
 =?us-ascii?Q?lmOmSHM/Bq7Fy3+VfYDsfy+eLI07ZsFxTbnwQRvDMhX8e9E9dA5yXX2ea+os?=
 =?us-ascii?Q?gOC0nbP5Q59Z5nquXKeojddDXq4Gqq5A/n4/tRptdSoZgSGtwCuM+RuqTyZN?=
 =?us-ascii?Q?UQ5n0mXi06L4Myrsf051Zr6KauxTT2ldNStYxcLM6df1yWJdvRji3TbuP6qe?=
 =?us-ascii?Q?fNdrjWdJP4d0BtqmLzNWGOrQeNaflLv5Ou2SAQW41NGIfGXYyE7ShJYW8Irq?=
 =?us-ascii?Q?F1i6++lUFhdrdYBe9IRrwfo+fayOdotm9T+PMRglLx9X61HmPv/B3l7Yb3Mp?=
 =?us-ascii?Q?zBfDgNr2Ww+mT77Q3gAq73oqtBQcxOq5BnXdsr4CBmOf6HZxOf5A2bJbETps?=
 =?us-ascii?Q?YQjH8hWOA+r0buApD9L5xmgfuvj2wSqtwgAPLNPoSYMqCXh3gXk6ibbS5Kc/?=
 =?us-ascii?Q?DqXPJkDxF4dgz+UTqbADEfULEA2GbNKdrP4BFAFA871oYNL1bMqPO+3+M/kr?=
 =?us-ascii?Q?EX3XacXzWes+7ZRmB1ncXmmiDcwaozFNlAyGAdROhhu6MD8jy0MTv3UGky/z?=
 =?us-ascii?Q?4gjKdt3Ydcz7p04A002YMNsXaUoYZLFvEWxy2zLa5bsN0/kCLzVR5v3wrMst?=
 =?us-ascii?Q?VGdxtB13Sklpx1JtwP/dNVVorys91pPhSkd8/LVqFyDDl1guzgMG1q31C6QX?=
 =?us-ascii?Q?uuVZ4NAWY1SidyDdUf7lveH7GfifPfqUZXubLtw2FpUa47Pcwnl6DnQfor0s?=
 =?us-ascii?Q?YXKxe2k9Ie692Fw4+KxkQB+ZvxldpImHeedoB9KY6f7UFoHiRPgs4jbxTySb?=
 =?us-ascii?Q?C9sGHMP9tw=3D=3D?=
X-Exchange-RoutingPolicyChecked: whG2yXsp/XJe6PddvRDaew3/5Fb/Jl27hjyngVl+HUSgAbE/vKhqtUNBiXOR+c8iVxiKJ/RpDSKw8pdcHKQOVnE5z0LJdthzXcNFlUOZfSF+6Z+k4Nty8yCfSIqOl19vlcYwICFZrOS+h6J2Okw28QwGLvmqbr222PhKlV+IrviyYV886RA/uAL6KLt7qGy4YTBRnapvRRVFq2GUcTGYwc0Ij1sc0I1F+L30j/RdZ8kD9V/1u+B1PTu9z6JJSHsSSIdft147qONA9RRd6x4tjgSmMmlhAdLRhuej2DVQa6rIX4ByovYAjpbT4+JC/0a/3WTSahqyH9Q2pmfGlbczJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b7371672-6afe-44b7-72b0-08de8a53f469
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7457.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:50:32.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVV37dsp6ZNXUAwtL3Cfb6AbnKIlf1t8+sFHttu+UXN1lZiGQM4xca3/s47VM5gzyJ3Yha6KDkzQInEehg81VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8146
X-OriginatorOrg: intel.com

On Thu, Mar 19, 2026 at 11:05:09AM -0700, Dave Hansen wrote:
> On 3/18/26 17:57, Yan Zhao wrote:
> > Remove the completely unnecessary assumption that memory mapped into a TDX
> > guest is backed by refcounted struct page memory. From KVM's point of view,
> > TDH_MEM_PAGE_ADD and TDH_MEM_PAGE_AUG are glorified writes to PTEs, so they
> > have no business placing requirements on how KVM and guest_memfd manage
> > memory.
> 
> I think this goes a bit too far.
> 
> It's one thing to say that it's more convenient for KVM to stick with
> pfns because it's what KVM uses now. Or, that the goals of using 'struct
> page' can be accomplished other ways. It's quite another to say what
> other bits of the codebase have "business" doing.
I explained the background in the cover letter, thinking we could add the link
to the final patches when they are merged.

I can expand the patch logs by providing background explanation as well.

> Sean, can we tone this down a _bit_ to help guide folks in the future?
Sorry for being lazy and not expanding the patch logs from Sean's original
patch tagged "DO NOT MERGE".

> > Rip out the misguided struct page assumptions/constraints and instead have
> 
> Could we maybe tone down the editorializing a bit, please? Folks can
> have honest disagreements about this stuff while not being "misguided".
You are right. I need to make it clear.

> > the two SEAMCALL wrapper APIs take PFN directly. This ensures that for
> > future huge page support in S-EPT, the kernel doesn't pick up even worse
> > assumptions like "a hugepage must be contained in a single folio".
> 
> I don't really understand what this is saying.
> 
> Is the concern that KVM might want to set up page tables for memory that
> differ from how it was allocated? I'm a bit worried that this assumes
> something about folios that doesn't always hold.
> 
> I think the hugetlbfs gigantic support uses folios in at least a few
> spots today.
Below is the background of this problem. I'll try to include a short summary in
the next version's patch logs.

In TDX huge page v3, I added logic that assumes PFNs are contained in a single
folio in both TDX's map/unmap paths [1][2]:
	if (start_idx + npages > folio_nr_pages(folio))
		return TDX_OPERAND_INVALID;
This not only assumes the PFNs have corresponding struct page, but also assumes
they must be contained in a single folio, since with only base_page + npages,
it's not easy to get the ith page's pointer without first ensuring the pages are
contained in a single folio.

This should work since current KVM/guest_memfd only allocates memory with
struct page and maps them into S-EPT at a level lower than or equal to the
backend folio size. That is, a single S-EPT mapping cannot span multiple backend
folios.

However, Ackerley's 1G hugetlb-based gmem splits the backend folio [3] ahead of
splitting/unmapping them from S-EPT [4], due to implementation limitations
mentioned at [5]. It makes the warning in [1] hit upon invoking TDX's unmap
callback.

Moreover, Google's future gmem may manage PFNs independently in the future, so
TDX's private memory may have no corresponding struct page, and KVM would map
them via VM_PFNMAP, similar to mapping pass-through MMIOs or other PFNs without
struct page or with non-refcounted struct page in normal VMs. Given that KVM has
suffered a lot from handling VM_PFNMAP memory for non-refcounted struct page [6]
in normal VMs, and TDX mapping/unmapping callbacks have no semantic reason to
dictate where and how KVM/guest_memfd should allocate and map memory, Sean
suggested dropping the unnecessary assumption that memory to be mapped/unmapped
to/from S-EPT must be contained in a single folio (though he didn't object
reasonable sanity checks on if the PFNs are TDX convertible).


[1] https://lore.kernel.org/kvm/20260106101929.24937-1-yan.y.zhao@intel.com
[2] https://lore.kernel.org/kvm/20260106101826.24870-1-yan.y.zhao@intel.com
[3] https://github.com/googleprodkernel/linux-cc/blob/wip-gmem-conversions-hugetlb-restructuring-12-08-25/virt/kvm/guest_memfd.c#L909
[4] https://github.com/googleprodkernel/linux-cc/blob/wip-gmem-conversions-hugetlb-restructuring-12-08-25/virt/kvm/guest_memfd.c#L918
[5] https://lore.kernel.org/kvm/diqzqzrzdfvh.fsf@google.com/
[6] https://lore.kernel.org/all/20241010182427.1434605-1-seanjc@google.com

