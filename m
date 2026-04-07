Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB04C6C;
	Tue,  7 Apr 2026 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525037; cv=fail; b=VSu/6YoeCEn+fYzDF/KQBVXkUfgPSvFkOMWEG4qaceU3urfgwfjzkyQLlP/+BpPf6N1NIbsFxehRgk6BOeVA1Fsm0h1EYpd4ZJ8GUX2v8aPuEbNoLJBQb6SdHgu8Jicb5/1v5wdBd8rS0MGkNY+kglBsyG+P6qZ/NBIH7Nppzn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525037; c=relaxed/simple;
	bh=QHYxkgyLij8jbJE7d4P+akjrPbkcyNlQyeP7Xqz5n04=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OtKKTUwwdNLL0OS039eVo1KnL2IICc2rWviRFpNKJs1FH2mqey/RIj71Pow4FdJ5Ko3wHWbIBZOWXT+VYOIuZyqCM1bHZXD/sOnrYPyCRflvxGISRM9GAp89LL1YoNecF1tDWEiqI4Z8mRWfT0jGloM9IGwtNesoU5xMyXW0f1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnlXFs/N; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnlXFs/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775525035; x=1807061035;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=QHYxkgyLij8jbJE7d4P+akjrPbkcyNlQyeP7Xqz5n04=;
  b=JnlXFs/Ny1DO6nt/oPoUeNvSWa4mABJbI7qd9heUM5lz+XtAVz7hIBqa
   DZBVq2fB0wr+oEcwOHLu5SYhBEee9YFrAs6piw86qRY/ExcAJ8ZwqNaRZ
   L4LYID76GJUXtQnGxq6Oa1gNhftxCO1FeQYFUDQPNwFA1sIv3uZtQFswh
   WB8C2yuCylMtRUOpX8X4LmjHA1kgwOV3PB/OEWosTkWdCFFZyeq4liVFA
   mZG2V87dHt4Wk+Cgasf3LUp2///1nkX70LQ8pAipT/rVBFCIbjPioVB1i
   +0YldyIv7M3tyiRzxSMAQ59V6J/h5raOl4vSJUOiWzao8q8MC8h63qfsF
   A==;
X-CSE-ConnectionGUID: cZu4ZcXsQUWBoGK1dJe5sQ==
X-CSE-MsgGUID: Z3zOoAcSQKWZyzJwYGENxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="79070447"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="79070447"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 18:23:55 -0700
X-CSE-ConnectionGUID: mjvURG+BQfWpSTGKpe7/Zg==
X-CSE-MsgGUID: E3bXDCZgS4+q5ZFsOk4Cdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="251161029"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 18:23:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 18:23:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 6 Apr 2026 18:23:54 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 18:23:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMr77YfTMngEgoaNkFmbJ9PG8Fjl4trXW6CLyrWUVuds/cSRkBycx2bWWNSI8/JE79Jkg8qfOsFhXikaUDMAQnJkX5hwB1G+/OEO/8srHp8DKUW2JZpKRAwxLNVnyuqRzgc/TbQtALSKnvr1E2sQzMvHg0BgJdL+c56I1d5XpCYZ9yCuIc4toDvPMhHB7yDKCumkvYVrQxOXocwT+0UMThx+vK3V8jD5C/Z9Mzo4tZZ4oF/m5I0s7AeRRipWSyeb9RvRW461ELocV9GatZVSaD7dR3WZaQ12Qy5HQlS2s+fFBnODfW4+NMrYnsaEIMFBLMkjUy+m8xJvStm5HzRXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fkrJNx8L4Q40aI/s65mbdfbe8p5GEZI9swIl1E5Zlg=;
 b=nG56tAbGyeo/AqeHCrZGGEWA4StD4FUiEL58aZ5ZVf8eTEpHv36xlClTjCsPjnvwkwPwCWD/fUhsFhOc4xH+rsjX2Sfge6xMYPxM1hEH7Y21gt0gRSCeY3opZ5l1WkpQY3zxT8qREla4CNvvZxNNxP5cmLPpSpYNITDGsTMTGhx2fOc9fcCkT6d8bqSedcvBj7/3Ro4VwPAQDGXPSfD13Esmi1B1rqB2XCvUiqaL1gTc6PGQrCC3Z+PaV5XNBqsCAG2OOjOlNpuZWsS+knQmaRcSPTHU6lRYbEGpUE0IPOo/4kb+e7H5KtsJJ0DujySoyMvdFVhdcJK+A5kEjs3H8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DM3PR11MB8670.namprd11.prod.outlook.com (2603:10b6:0:3d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Tue, 7 Apr 2026 01:23:51 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 01:23:50 +0000
Date: Tue, 7 Apr 2026 08:44:10 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: Xiaoyao Li <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<dave.hansen@linux.intel.com>, <tglx@kernel.org>, <mingo@redhat.com>,
	<bp@alien8.de>, <kas@kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kai.huang@intel.com>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@linux.intel.com>,
	<vannapurve@google.com>, <ackerleytng@google.com>, <sagis@google.com>,
	<binbin.wu@linux.intel.com>, <isaku.yamahata@intel.com>
Subject: Re: [PATCH 2/2] x86/virt/tdx: Use PFN directly for unmapping guest
 private memory
Message-ID: <adRTWttGqVfIHaNf@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005808.9013-1-yan.y.zhao@intel.com>
 <623ac08e-07a7-4823-bd0a-777d8df5c128@intel.com>
 <abubmi7BjMwgnrvC@yzhao56-desk.sh.intel.com>
 <b74acb4b-4658-4113-9fce-9faf972975c4@intel.com>
 <abu6MVdXar3MmTdF@yzhao56-desk.sh.intel.com>
 <5b3110f4-4e46-4573-b68e-54e220ae1c19@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b3110f4-4e46-4573-b68e-54e220ae1c19@redhat.com>
X-ClientProxiedBy: KU2P306CA0012.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::20) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DM3PR11MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1ccc0c-b560-4d28-a880-08de94445311
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: qn6Z3uyVkv6HPzR+V8/hHE4mEZNOrJX7jjXq+52Ac/DuJS2+3HiRj6c8FIDZQ/E0SPKXWzRjs3i2gpw5RXhZFwN8f713myZq0JBddz7zR8mfzng/ZB8bls+SvJQExKX++TYnYUOqjfKlCb9SGKaNsAjlZM+cDBhWqhjLqTb00Jl06TSMFf8j3Cm3TbMuTveEAspE9cPEoh0nIkjR4H4UofGKPgEdfyz5jz9VCS4N9amsD9SgA18vvQ+M83s6N5VURlp5lUwD76kQdk6DJNUGAlfiLz9BikhNS5Ixsygk4eqin2uM8Utz7ViJJiUAf0hnAtR71ulcx2gWr0BhVV9GyFXzejXA48/jGKCIdYqn8pzdfCWrVLw9dEHUgk/l339DQktUglHZxZXsdII8lLvS9BECE5g8ewrtwfoOvFV5lxWCiaowi3mDIAG8e8rkhJc9CzRt6HtLJt184iIepYPj6xecYnitHl6NLtHAPuhoEOa5KYvEnrZm4NpVJt9RZzEYecq6o99IlzimGHytYW6HGiRLu4LIpPNCV8pQVSsKWeygUhYV6OEatl6FnJCz/dldtuyC9KqHdSEA5WVyBz/l6DZqToCXSYEWHKqccYH8xZ5Bm74RQZCi5dHCdx+qasPqOV7UdZVkR/FIsaDSMhzFvZ/ZtZEze7GEO1cLyE0IV0VEa2DUJUOkm+9/ediGTvMQ1Z1KMpeJO/P3XfSbnohTXKhsSglQX0x0TawozFp8Z5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ksbfuvlHsafqq+prshuaAmS4fiteR0xWGUFXdghDBxeeghY3cvWf9NPhbgfo?=
 =?us-ascii?Q?FDbdGVgviE8/jjOIYK13YLLh3UROtEPdf8577FxZpNaaF0w0CBQCWGKdC/oT?=
 =?us-ascii?Q?3DlLS96MQk/ihGjREIEPega6x0jgMzj3615RwnFEDoF8Y2MXsQ45ePnHIK9j?=
 =?us-ascii?Q?kVqZeGxblORJ3ue28apZUOGo1DludLInIHCOHl7Iruj3yj/JGprcDWGrPMsG?=
 =?us-ascii?Q?88H8eILNJxDFOS4dPwnr2Oj0MVN63ssjRrWy7Sf/rXJ7an7r72pifbf3wXbt?=
 =?us-ascii?Q?cl6KLVL9M34lp5VeuZm4JPci3wcvlcbOPIzSmnuGT7StdzQuB7gXXnsD/0hW?=
 =?us-ascii?Q?Adu4WIByFTGe79ADMEF1cx6pgSRn4+362dkCHhwmjDavuzNvr6/hUOLlr/Cj?=
 =?us-ascii?Q?SyFewHiXOdPgAqMvc1/WU5T/Z7EoYno8PEqL5M55pTwgyuZ4BdJj3NXbpIQw?=
 =?us-ascii?Q?GBE/jUbpUjEPc1EoOKpEER+ULm2VZkMmGWXNBCmp0uRO+KCTcE+9Nf/LwN5p?=
 =?us-ascii?Q?ULFO+AOyGDf5kwEQeuLmJfiEz5oXoVgHhvXDyWJ0tLbKR2qwkjD5C0gPUs0k?=
 =?us-ascii?Q?EMZI0xhSSaJ4lyPVlniZu9HaNEgS2h5tWUkn3Ny1ojBnYBe9BrlpKT5VdpiA?=
 =?us-ascii?Q?dm2szkRfWJ3OmyEdDeBJVFlQfpYY6fHH7MuqxoCWVg6BJD6khIgjsgtGMVZR?=
 =?us-ascii?Q?cs1+Fie6NFHbMOuU6PRalAHiSmuls5e8JgGhb3CYRDBdFpEm0EtBAWTOrc4s?=
 =?us-ascii?Q?CSC5RUzaODm3Xe3rq6k7IB3ASDrtAXutsxs6A+8LprUo9kThI23kLwPVFgsr?=
 =?us-ascii?Q?+kRyZmgAEb8pOPN79BrJO+f2kcT2j7uCJF+1fpSlM/MFmnKMuQEL2Z/D+JcJ?=
 =?us-ascii?Q?xdUmOTGsUBzICFtjhEYmzPk0IlGbbFayHztzq0hNDnUGL7bkggvFMxhVJsSR?=
 =?us-ascii?Q?Of9/6rSR4YOTIcBiFQtzeGuWubGSJgsldG4/N25qmR/bL/br9ymewlgmg0/m?=
 =?us-ascii?Q?70pYBKuSP83gK4O2cN/aBzatIm+hXTSkK303i5hUrsTETdfVIUTFoDjn7JHQ?=
 =?us-ascii?Q?2touazNowmKYrM/kGFq4/StTLqKwDbJHT4zGkq9FseIYYNOHJLLvNtV6ts/H?=
 =?us-ascii?Q?fldIoMa1S9PW6ZhMpVVclNNS5bjgWjzZ8oz6DOVIzcU2qgOliZ1xRcNw9Qfr?=
 =?us-ascii?Q?7qnofDIL2lwdeMotU7KyRoQ4F0e/Z0LFrEyUrdxKN259N4j/c7FzOQFt2XxU?=
 =?us-ascii?Q?lE8nbX4B4xBtOCuj9H/UkuG2ZHMX2FlCpbwaJCAbiHEQmBsUD1WjYhwGYx9p?=
 =?us-ascii?Q?dMu6cli4Yfcl2iD1LGglTU99V/IwMpb6jA7QUlUju8aoCZgyIilR8/iBxu3I?=
 =?us-ascii?Q?kxiQQoS0jmuWRE18edZpVJGZXl7kI5yV/i4PtdFXiLvvsB6EUq16wW1RoSBd?=
 =?us-ascii?Q?pqTWPgQB624NvLELvZwt7HzJSvSdIm8OOg80cno+tKq9VBmLWjphRuKCwlwm?=
 =?us-ascii?Q?gn+KeZxPKtSYrwdM83WwsIBGGBtyy2VQURJaHvzfNleLoL6rPwYnf5I+PKo8?=
 =?us-ascii?Q?Z93+WQqDv1n/+TBLan9k70VuYyiezpH+4pzEOpxJOJ8g/2u426QuYp7e+P2b?=
 =?us-ascii?Q?YRP92mJUcpF8Dfjl0nNqQPStiOYUi122cdbsUESsym3ySlSEnuAE6XxNSgCT?=
 =?us-ascii?Q?Wn8mUExe46pckZwE4qr3XkwFAahke1+E8GL9ZU2wSCCv6vNr9NH+4v5IvhzL?=
 =?us-ascii?Q?jjsv4/o5XQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: XjKmGh2y1wmtHwzmOsCOpAWjRHHicT3Awwb+zZdjKgbQ7mfQ50udyPvp1TvfIHvKYNDe/QtpjPGD06ghp3AsVg93sf54wlW2mFowmk9YsZ7s2gDrJ7tuQf8jHw8ldPfYFsEJAY/QRktfZCAe27mCusFwA9keREOo8IK8V8jrxUmEAZdbILlCBDwkz+DxdxpsF57se17m4s+f6S7h5ab3/fmd9fUXtYjjgdxLp95xEeLEoFwyAQw1NeeOM+UKsf84jLqFFrQXuPuwIEPs14T4cZhsN3DrtwOOh1Qcp4n6+7gjNg6bNfdrgKK2qNjrFozlHSLmES5WS51pAqtyH7w8wQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1ccc0c-b560-4d28-a880-08de94445311
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 01:23:50.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gj6t7hu6AwV2iyiXD7JZ3g6fu6ma+Gp6UeQNAOKfZHqUVKpG5M765YaJSbgcSk0rCRuJHzD96bGzykXfQv3UIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8670
X-OriginatorOrg: intel.com

On Sat, Apr 04, 2026 at 08:39:00AM +0200, Paolo Bonzini wrote:
> On 3/19/26 09:56, Yan Zhao wrote:
> > On Thu, Mar 19, 2026 at 04:56:10PM +0800, Xiaoyao Li wrote:
> > > So why not considering option 2?
> > > 
> > >    2. keep tdx_quirk_reset_page() as-is for the cases of
> > >       tdx_reclaim_page() and tdx_reclaim_td_control_pages() that have the
> > >       struct page. But only change tdx_sept_remove_private_spte() to use
> > >       tdx_quirk_reset_paddr() directly.
> > > 
> > > It will need export tdx_quirk_reset_paddr() for KVM. I think it will be OK?
> > I don't think it's necessary. But if we have to export an extra API, IMHO,
> > tdx_quirk_reset_pfn() is better than tdx_quirk_reset_paddr(). Otherwise,
> > why not only expose tdx_quirk_reset_paddr()?
> 
> That works for me, it seems the cleanest.
Hi Paolo,
To avoid misunderstanding: you think only exporting tdx_quirk_reset_paddr() is
the cleanest, right? :)

Thanks
Yan
