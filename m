Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A103A544E;
	Thu,  9 Apr 2026 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722930; cv=fail; b=sKit/gZa8+a+biV/FSWltOQIvP8lVR4nKa3j2JEeC9T/pQ9arXIvjdA3cxQoM0NQIkTS+NGgZDqD/HeBfeRA5r/D3Z1nrVnKPiCVh9sV+fPgP5AJkfgOPVmBrJDd8LpZooFwvRzxDlMEB0uipEWtG8lpzwEOgpLxEQHshU7JUKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722930; c=relaxed/simple;
	bh=0tdoRMv2G3/jGKF+c7h0fMcSvEMGnwNikBfP9PoCX38=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fFC1IakSeHgVc6mLmzpEQuuWESSHvlcTWP8bEXAwLbrIbo2n8dBeXtO2RbgqHxgd1na8K/YvZ502JcElrDObn6PxKrwv0LN4TSbe7kRWoXRau1TAmMElnZrwXnGQn6c2Y9JZNcfq2G1sJ8BM8BNbqb/PvOUCEONClYZtd7uYusI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYXxpiRK; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYXxpiRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775722929; x=1807258929;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=0tdoRMv2G3/jGKF+c7h0fMcSvEMGnwNikBfP9PoCX38=;
  b=UYXxpiRKESvOlWMsfEdODKDrYgQ0JNP1G2OWuYtQ3eacktkKO25lUoNh
   VBDPDxgmQ1YJaZYhY0jzkTzKjsiFaNRh59DNKchanN/xYiiM959K27sQa
   qte3EhtKJU9dfThKG2VeYpIG0SAaID9gRjL+hWozXJdcz/6c5NkU2WDMu
   MXPk6llTyaaVCzJ8Ea9Wo8YM+0OrMq1A1lcicoa/NitRDQrAxa5QuhXHF
   XVZgWYG7mhjHh/S6vpeXn5j/myVUgOPWO+qXAQmmyU1d1JJh5cUE+Sn7j
   w28uh97N8Djo9b8LkkrQAF8CZh0DFIP7ROE4VW0dELmO4t7Glwey7qvgX
   A==;
X-CSE-ConnectionGUID: HP7ctBy5TGyadCc5Tql8aw==
X-CSE-MsgGUID: 54O0m14mQaCGFZWF307lvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76625506"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76625506"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 01:22:09 -0700
X-CSE-ConnectionGUID: 37Im8EwJQNWH8s51YiitFQ==
X-CSE-MsgGUID: f4HtXc8jSMCRC5TVNsHT8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="233599816"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 01:22:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 01:22:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 01:22:07 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 01:22:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoHzW95C36LPw1rHwW/YrJGgzqtX7JTdHlXNdGn3Upq00xHtkNeo+bh2NNBaRRJOPYSz/8ILFbjQ5C8meDnLDBxm63eWatdGF68+BWwUBO6KS9dOunqME7Pka7Zwr71J6Mifw6B8icxWStRsPDVbDKrQ+EKelceRg4g3FzuKHK7vEYiQvNA6EONMtKOLcUK0kKSFASeY6NhZ1ct+aYtjVci8XGLlXGdMOZts1YRFvaoZR146udDEzq7GNj+PYIx2RxwOkdzIUjZ8mP69owOfnPwcWdANLmsYw4A1IGgEqTXTI4sPvlZiUd7BU+BrROaXFTtqv1emqk2NphXOL/pE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2NKOL3FzwX1nAGDNfAExtmvjl3dR3Zm9Nvq3+/3cxM=;
 b=fKR8AH3oiAckG7n3ZT6+Gx1Xv4NyNGIfCCam2H12N5CHoEw4z+Me8AQUqt2MtBHyl2gpHkcaS/hKlgARmFalWgXHZLaNJKpNQXZbODsElYjKOYHAUelHZ8VCMiEd/1CdQQ8i2a22XdVineSiYUkaku0BvR5GDw7BxLWlkP/Sq9QG7+CgRZIQMt+2iEIzO3fgBT1Km3wuYpjeEWhZg1cDdY4YcfmbZyzPuZLpdF0dxF3wtmn3/iqf3snXQQAmLdQPM6c12cf1p+Q77UtMRecbNJo1oy1HCu9HIK62ZudFDMFSJoKS5GUeHu19OTtiVzeTXXhr6TminTV14H2Ym17FoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by IA1PR11MB7317.namprd11.prod.outlook.com (2603:10b6:208:427::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 08:22:04 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 08:22:04 +0000
Date: Thu, 9 Apr 2026 15:42:22 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <dave.hansen@linux.intel.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kai.huang@intel.com>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@linux.intel.com>,
	<vannapurve@google.com>, <ackerleytng@google.com>, <sagis@google.com>,
	<binbin.wu@linux.intel.com>, <xiaoyao.li@intel.com>,
	<isaku.yamahata@intel.com>
Subject: Re: [PATCH 2/2] x86/virt/tdx: Use PFN directly for unmapping guest
 private memory
Message-ID: <addYXjM21kJ0FkZS@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005808.9013-1-yan.y.zhao@intel.com>
 <abvTJq0Ks22WnLSA@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abvTJq0Ks22WnLSA@thinkstation>
X-ClientProxiedBy: SG2PR01CA0189.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::15) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|IA1PR11MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9ecf56-44ee-4a1e-d3fd-08de961114c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gAUMFU3P0jIoNSpk0wgH7p8bS1CyTUw/VI7i6SZGm6vQ2mI9pLcSI06SGkX+LVAijSjwLQdybHibTtujvHe4FG3A+W57HgLo5HmLhs7n+I8QbtI0U8Q1NrCCfFouDY66u0TOzsVxtz7/vyFEqFG35meCRnzVWn5kqjruLyPAONIAhUnJFIr+iPSndnYUmViUtgcZCkS/pp4Q+ftNbm6F0s8zjA90gJX5/73dMI6ORZTNfwOaLBhLI1RvNb7gGxtMg58Cp2TToRE51QP/kf8BncK659IZPT40Q7XDtGBxwkPyr+qhiYCgQ80IYZt2u6rwPsXxUydnOdrjG4mmsUoHaYAtcXx3DDc5zDLFoQWQVj8my53l2VsJ2JOfNKd4ViRXno637xk/lFTzHsFZTvQE8L8OYt1lCqwrxc1CDOOd8RddFQOjjhTUj+C8ezmsMIL2ZwfXdBNZ8DWYqz2MWbbMJkwO2t1/ftC0jyRjoKgcW1pluNsT7nie7koE4wilIw7yZh7qHxQfyqi109Ro4FIHCKOqpRSSyPKvzenQ012YcMIDFYh19OJr+KPGZvdaxb7is34VWJ01pNypxtrIysG9WygXT++U70bgEPxfedw8Y+mr916Ia0NSpfhc7yf7A7YsnLrh0GFko3na35HW02zhKz9Ul7YdKzhawN2VGOmtjeiI2HjTPtPQCj+jj1R8BJv3F5f9PUZNboHjUCdcyFzCoD73DwVdGs7jcEujeoafZTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8UfEM+Cz3z9YfgjG7VPdIrpwoBCIvIJZQ3gvzi1ThyKjJoDA3PnyMwPdoD0p?=
 =?us-ascii?Q?xBNR0xMBMS2AvLylLqubCQsqRdARO7xSl8z0oEBXhfEAJP2cYldcf+Cgov9Q?=
 =?us-ascii?Q?QitDByBPgKjOUs6BSV1ZapsurfQu50pBcvP1t1scK9apaaMABg8y6dSqzmUp?=
 =?us-ascii?Q?PFPfDBc48+ondRf/eY5L/nXOnaOzvCAyDCng6hoYBpGdjxTw78HdVQta45uD?=
 =?us-ascii?Q?XUUNdFsKd5jHz3WtGzNgI5/CIXuXcHzy6c5iKI3cd+7J1je4NkOJ2Q49Ctou?=
 =?us-ascii?Q?XDrXxkqGO1ZyBPpG+EH4fgj9h5zA1v23HL0F+EwNT+0wr1e9z8S8HZe31+PN?=
 =?us-ascii?Q?d2mPzFbzPfLQG/XclkjjwDpVKfk9mXXPWk/lxW0+ALqfRk9KGRAMbswkfTfc?=
 =?us-ascii?Q?NiDrx2pHpCOz7Ps0P8wmVRzFNWtXUkEHbikRErDuEb5ZDXKnljo1V0XIoLsZ?=
 =?us-ascii?Q?qOjvijgfFEp8IJiW5XHjOi2i+kc4dQpF4nBDMpwE9s4ZqALHBKfpkMoyaJLu?=
 =?us-ascii?Q?BP/yWvN+UFE3h4/xG3BqYWIAIMUk//vpPSXwXgYYFLPqtIzl2qLHMnP9zgSc?=
 =?us-ascii?Q?Hd7QeW4hCm0w1nCGlSwEkJv+x3e9fCjJIr8mBH476Oqet9br3TKL33OlDJO7?=
 =?us-ascii?Q?bVUq8zVrUkHD5lSkZnRZhUWeqVGelo+vTBqTFvjd7uFP7MUZoHHOjEMzQ4B8?=
 =?us-ascii?Q?CPZFMlOoqWdnu0LUdj4kBluN0ujycsT0hO3QYsz3clZwSK0bH8YU4Jb4JKmb?=
 =?us-ascii?Q?gAkWsLlSCkyk7YsPiXlrnZagHy/JZ9qKnUSY7DFRUVCa6Ld6hca6R1mtGa2p?=
 =?us-ascii?Q?WK2/8QNlh2RPJ2h8PUiF3ZFIA+qBqXW/oq33MUAC40EKCD6ZoB1hDyQWwTLi?=
 =?us-ascii?Q?0KwxYWE6GAlOfQIYpg/x28OSc/98W1Uotagnk9LDXptrNjbdOG4wPiKdfoNT?=
 =?us-ascii?Q?a4gFaVruT9rS/xYBekDsBKJNA+GsSaFB2JdtwwI1jnvhaU8FbBsee36KfHNF?=
 =?us-ascii?Q?ERb8CSbp4I26schjohBT6PHGwyyNesc3pX7r1wBMm7H+MGnKUdrE0Zj0pSbq?=
 =?us-ascii?Q?hV4qBCYv3aJPj9Hnuyq2v/OjAVJ7Hsxvm/upc2Vkx0j4E8pKCwLhVGd2yRFv?=
 =?us-ascii?Q?g9y7kB14DuVpLZTDvjtYyBhVr2jGbn/rF/ZfXUKtPCK2ybjZXRbMl1jhObDm?=
 =?us-ascii?Q?kxwWWMiwk59RjGHBFQpbWcYqJj5XnPmCag8ozN+xS+co0sA+3AyjVtycdRwz?=
 =?us-ascii?Q?V8Qg6fYIouueqf8wPLF7zjT/gvX0bkMbBpsTEYG2W1GEdJGmyEm6XTEe3tQ7?=
 =?us-ascii?Q?PjZJ6Ncq4TGvQFIy0C+SfFt9Vw1acb3KAV+RqFiXnWrFWPiEX6Etdcc+memC?=
 =?us-ascii?Q?9LTDZMIuoSFR4GJ8ZYC9M25h/lVZjg7BugbunhSqo72IDVxz40KfUW622rNa?=
 =?us-ascii?Q?HqKur5XEuAL0oxmCFMcIGHsrqmGimrQ24LQkeVbxOflR8UaSU+1SZmzadx48?=
 =?us-ascii?Q?wpIz7baHTg/xA3zz81/PnMhzLptbn5budhY42kGphEViL00gDyowdF4KkrJT?=
 =?us-ascii?Q?8AEkMjydzOaWcCUFiMYFOixHVNuRw0UAWCHPAuFUWu94BsHSxE53wO3reJVN?=
 =?us-ascii?Q?R+W1LTkk7a1S0iasmXlrEMGn0hHYy6H/a8Mr+yHDmlXB6aaA4kmJtNBg7MrT?=
 =?us-ascii?Q?srb1iGxRimoB3zFhh0sER7IM8KMlNAxyRyTfTsNQ7jfTd46vJTKhNaYutIQw?=
 =?us-ascii?Q?NLIZrXqDjg=3D=3D?=
X-Exchange-RoutingPolicyChecked: q1UG9GtYunVJjOgiN8E7n8pDrryAv68eeCr9uOMv9BeQNhm/7a34T2ZsmLom9G/TFa2K7iIJxlEdB0MR9ffBTN5NTrErCS3t/e327XAeD/cBFUqOSCWQ7zVHTZS+yoYZbh4RzEmoZmm7MFuSaPUgb18o2oP/qe3N+R6stSrNdWhyE9ufftXO+y9L2S4oDzbnkteUU3USfP0J26NHutkoRRUs6R6TRnlZAk156te1atTPad1Dv1wl27egPQjsrjvBFAAbXonaWDbFW5RijMSu6F6dcOFnJSzw8W1Ipr8tLKAJDtsC6GVMsGGeH5Iyve5xJ1uGjSY7KCkfgDDs2P8+Zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9ecf56-44ee-4a1e-d3fd-08de961114c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 08:22:04.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZWDUCCafKZEGiYiktjVwWYZh1kkRqwni6SnsgUD5l7R1Nxn3taPwwoc/jq5VwvATYjBrDHDvMkatIJYvgLh5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7317
X-OriginatorOrg: intel.com

On Thu, Mar 19, 2026 at 10:48:08AM +0000, Kiryl Shutsemau wrote:
> On Thu, Mar 19, 2026 at 08:58:08AM +0800, Yan Zhao wrote:
> > @@ -1817,11 +1817,11 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
> >  	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_REMOVE, entry, level_state, kvm))
> >  		return;
> >  
> > -	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, page);
> > +	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, pfn);
> >  	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
> >  		return;
> >  
> > -	tdx_quirk_reset_page(page);
> > +	tdx_quirk_reset_page(pfn);
> >  }
> >  
> >  void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
> 
> The same problem. @level is ignored.
There's a "KVM_BUG_ON(level != PG_LEVEL_4K, kvm)" in
tdx_sept_remove_private_spte() before invoking
tdh_phymem_page_wbinvd_hkid() and tdx_quirk_reset_page().

So it should be fine.
