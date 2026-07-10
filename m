Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD2F31E82F;
	Fri, 10 Jul 2026 02:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651671; cv=fail; b=oitK8C3hB9ODS7r2jf9J+e6d8+aLC52tGEmYHa4YsOr/FG4tQUWfe3by1j0KSx9ocR1n7MvjL6xtGhz9M986qnFW4upErqVfCxNQ3YoCGZP9G5FPYX41kLhBnc8Eo6VPP9x7eHR0O5h72isuyjpH7VAgIwrkvcx6/vzwNmZKtgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651671; c=relaxed/simple;
	bh=lqLOSuywNLeWRCCToc3IjNvbPADrJVV+ilAYTnNPIJ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rAl054XLfxjyUkhmz5MFjkhCbd0gpNf3stJjTCIkmDgssAOmLtWppfDBBRSkhDeNNWuFAJ9xdQY9Za+sGwLktqBHrCMY57HIM3Ne14kwtTGulD0CxfAJ7Px0pns1LnI9rFuS0qXMoxBTvbAOad2yu+rXomzLF5xJZ/yKOfqw4Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLt4Q2lX; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLt4Q2lX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783651670; x=1815187670;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=lqLOSuywNLeWRCCToc3IjNvbPADrJVV+ilAYTnNPIJ4=;
  b=nLt4Q2lXxwDNaCleexIURxV5BSLgNa70NJx2vZW6Tg4dUdSRFwGxO1VP
   HHI5PCoY/iVsuW9yVismRFQgyW6BniB46gpi7pHSkJ0DTGz2EHXzdBez4
   5A6HR6Y6CE2TRHLzhuCpksyXyZAvbhttXfIWIUC636rUtxmQLglyZWZ5L
   dTyjAz2RTn8mGoWm5OvRvdgaFdCSxqfwZv0big1bby0a1mOKl1rW7YZ2l
   S9W0XwRfTofAQ4nJZb9oHRwiG9dcfFE8+fuwRqFoLFsg712agn0jVauP3
   jFlV3qLkmhIQCD6NahSXa/c7iQyV98EmIbZQQuS8vKhoehhF/eUkQYfYh
   A==;
X-CSE-ConnectionGUID: EcFjvybAT2W89oYdi7PY3w==
X-CSE-MsgGUID: b6fi5N4OTY+iAR8s4hjzzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84462616"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84462616"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 19:47:49 -0700
X-CSE-ConnectionGUID: TFj92sDHT4q61kcHP4OcKA==
X-CSE-MsgGUID: G4QP+c+GQqaMC4aIV+AhHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259668176"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 19:47:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 19:47:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 19:47:48 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 19:47:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efD/mM7iY6M20Xz8zbfQAXLI+heovia2VMvLRPQYMnbAel3nmsT7KaGEZG9J4LCtYgoXWGDigmVa5xlICRLRCiL18QPDaix7NrkjzY1Q9fSreEAgptWFqcsRSAVfnFz+RmmX0R+EnKREu3spIQ2elWuF6kIvr/nHqLzfJ6sOrl7vmocXCMYuX/REhBekiZk45sUXkc7B/hDt+ItKkhhpskEE8Sv36rrTIIkhNURZW217ADIIAUuuOqVATOiLyE9ofxzqKVlXgOk88qW/DKqk1e7yQxA7s+1HT9HH4A8KFYiAFqwAeavNHU7oCnn7AsoVBVxWEK/4zPbCZcWho1argQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soxg8dD2TqGvlinIHWX7ykp92HVLBVBJ4qi1V7iSQRA=;
 b=xQxmbVSVDHcW7GZDX8LvyeytSv4ytVmQuqhHjxN8fOxWJszQRntFfjnbC38Ih2RX4qC76qFJ0qh2rKugt9L2b3aka8q6su0T4MvV8rR26xjHqJ5HxutI5lw63WdW4IoJeQb2utAWmcmpD5mH3Kej7BHYrgWZIH5ItvyII4EhcoKq3+xAqoVk4jZXMke5znEu2JEANxnTsLAk7VhAvRKUsSUtEwrCyAxQ2eeLHdjBygccUVp9NCA2D6LJa0mybtoed537q7voDcV9svaieGqJlrgfHjBYAO0FzKo7Df5SyS7qC+zK6kXwJqthcRO411Kb5L9cSh+NFYJuLZYmchsUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 02:47:43 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 02:47:43 +0000
Date: Fri, 10 Jul 2026 10:47:36 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 08/11] x86/tdx: Add APIs to support Dynamic PAMT ops
 from KVM's fault path
Message-ID: <alBdSGIOfEyEX6rN@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-9-rick.p.edgecombe@intel.com>
 <ak9LDmWBIp52wv4X@yzhao56-desk.sh.intel.com>
 <6f19e79b49e6f6e32c34a87302a9ab475ad0f51c.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6f19e79b49e6f6e32c34a87302a9ab475ad0f51c.camel@intel.com>
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DM6PR11MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: f969ae08-26ef-4e64-9120-08dede2d9dbc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gTxATjoAB95+4RIEMAS38xyh+U+2RboQnrAlMlb5G2c/RN3BOi/n084gGvZOd2EsY7ANJuN7gbJsMwExJXtdN8H3NiCBv0is2y3A8BCPklXmn6WmljSg5KHvaKj5bMzWZ0YJq9NnsCgNEAwbkoSkq6qi6peekxBPiXT5G2KY9bTGZQTdh9A178wQIoQttBbtBkkDhV3fs5YgVy+dGCgwGo0L83DQXpA9SFUn87mJi4WGCbL7yMQEdy6ZrD78rnLe77FItw8lUoxiEW+V72IYXDVE7L6zLXNiJ4XUWAhic4kRKTiKajoqKnz78H7w1ka/yxLrTjR6KBFcb6wcv9lOHPCaVniG+8BADAV/4+YCwvUFpHM1rS/LaU5eat4jACjMQnFxYV1DXiPxB7B0f1964kwAm1a/pr6rKh8EczGIm18vqcQzEqxcidlz1VbnNUToruMt5cydVL6+QNFfxMZ/ZiYsIBPizmu1KNP0Xc24F7pYCtYfotLnWQ+sd/E+h+JLPgf9jLNoUzDdKLbv9XzDZcK5/4o18sBjSRihWD7bscx7AocPZ1X8vtbBNJaw7LKIkW6SyTnpFEzAvgycOIDkiQWueGhYQCuLeV4I9eR7yaEYkEJEz+2kNcX++Khm/Yzl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KFNdS8HywvG4W+UQvKIr9Umu4PR0cBFBASOP/GJoG0gmYkQCRLyGy9VuX9e1?=
 =?us-ascii?Q?kbf6MnEDxlkJTDILNkNf901Cf7XF/5aEM96tEE9NqxFKVyW4MNMRKFNlbVWP?=
 =?us-ascii?Q?SWcsZgeyYOdRHgCuRwbrJYM5+lrA5dGhbJaNrGFnC06ZUXxxZO9MomQpnDWh?=
 =?us-ascii?Q?wh4gxe8cicRnA7s8fMGgIbSDiYj3DtARX1O++UizgAg5toP8BQmsBsm2etTH?=
 =?us-ascii?Q?Me9xycr6xy76MhEWjGl1uK5Ib9vznbs/PiT/+vQb3F27GwhrYy1/G0lEuu5J?=
 =?us-ascii?Q?3XjnNbLIQwepXvT3obb7rZo0UCUm1KOC7ldDHC6m3WJlCMKuRxUrPomKKbZs?=
 =?us-ascii?Q?gqTkWJ+80SZll1etvXalIcXnRtk9goBMIOtvenaAauuuqCnd4tfEneNBbz1p?=
 =?us-ascii?Q?wZBL0GjSJGNZmy1+HpbHlECUW0xMgOXarYpFKMLK1coOuBxdPurhKzp6bczg?=
 =?us-ascii?Q?OU3QCbM0hK5iJhZm4lrvNDJL5Z3F6Vigcx8uDZ0SAFvYTIw+ItNBsQH5Vgpk?=
 =?us-ascii?Q?TjgufmQinRyxaKc6uwYVKSLc52Zw0DcjSiiZh/Z/gI6l4NiwAJJnxn1ImoFj?=
 =?us-ascii?Q?IGSeDWXncZz/vNZNH3LI1G0pCTAjwZY/VPOr+27kDTr0sFquYlr+rKP+mcbr?=
 =?us-ascii?Q?34bj6pAUtZWbsCC213SMFCdFc4WL6JZmFx4EgfU/VW+Be+1t7Qg5Lx5hI27t?=
 =?us-ascii?Q?dIOFsaQhMIa2ebI/G7IBgZYLzrjFKeOSF8ASkl2ANCz5IeIBI61o1oJnlgaC?=
 =?us-ascii?Q?GwSDa5kTzKpDso6wBHk/KuDc4Qci0PXj3JndvSPOGoLToEtsafLsMZplbw9r?=
 =?us-ascii?Q?sySMpbJFS7/Ek8DSsKlBUIJz2o5xpDIvYhMMlzUFZFla348Ux+11tcxNxfDc?=
 =?us-ascii?Q?KvdhMR89Vkv6dc26wlv1mtmQ1Z7FtHSrZLcnFBk5Y54315NJ0YUwp0zJP97O?=
 =?us-ascii?Q?diGR//eW6v7BEW1K+neI2RQNiXhYCknLWE8Rmfo3oOOf9GM4sTkBZ+vskE17?=
 =?us-ascii?Q?bOdQgoajv1zMr00f23x5n4uADLlZWo86NkcHVAZhkDPM9fNjx3+Rope71mI/?=
 =?us-ascii?Q?2xRJBMXPx+5Mtd36gI47+IA/Bgh2z846TAb1+9BY/IO9jiEH+N6DE/bg4YAP?=
 =?us-ascii?Q?AAoIF/J8xVxL/XsKgRnoRmPIjYGlDJVCrFiblrJ7It3Xwik1w+m4phjsvAjB?=
 =?us-ascii?Q?WquGoxv6b3736Z+PUIH4P/iRGensHy13bUOJv/CKS6oXxyMK0EzDh1/XpICh?=
 =?us-ascii?Q?oRbmf97jlAkjS2tJHpDuq+kpbOMA93YytWoBu5FIYELrWEEU08sqzvF5cLEJ?=
 =?us-ascii?Q?CH1JyaSnm2UEE9wBzl76JcHCuJj9mT9QknB6nj4NKOtMKh2S3DdBRCodKIz5?=
 =?us-ascii?Q?xpM0jibJJVLy9zsFLfWvBn3u3c90WzhomoFrSOBmnAQpWH1gACSqP0e4wkRI?=
 =?us-ascii?Q?NiLvyZKk4SDbDC9VwgcxD6BuoW9Z3D8YY2vk+hdja7iCvym4SqNOZK/o6/1k?=
 =?us-ascii?Q?/60evmpprm8o/7bbqbrw9Vld1Lyhqe9bPTDKy+7Aq9HUeNRVL0/on8PrMb9+?=
 =?us-ascii?Q?9L0/PwkOHcYNgI1TJWtyLTREDBIeCijmBka2XQ+31UQUuUf+0DUhPbGieGqA?=
 =?us-ascii?Q?/JqB+jAFrkUNZlwShTsI3d/jdRgbb6dnIqoTNVkMzT2/DgC+PlcTNMQ+zaPo?=
 =?us-ascii?Q?3oMYh8Fl6gBOP/E4OjW32FsWf53JNiCAT5gjYn90aqlpzEmNWBbor65riwLx?=
 =?us-ascii?Q?h1YTp6zyQA=3D=3D?=
X-Exchange-RoutingPolicyChecked: LwEnU6XKPVv1naZX30U9lvkUsS2QIxG78oLQBAeX5GUtCd+J7YP8Wvp93/DSy0jcOViDSUMMl6nRddXSKFwgm2bjMPUiJp4+Oz3DGbTUGDMmb9cVfbiNWgPd/YDdjNbDW9eACm2ucH1RhwpD/+WVFtAN9zofHKhR2SDhqt6lq8AUo0HGMAeQ6XcQIu0Bbc/PVvPBMBzfX/5WV4zwJU+Iwy/GD2ttQw+6UID2RWY/AQ/jmUleOjBER4hQiMvnVG14Om2ttXe0/OXiUzM3ZoNDYczrdj/KFNbBl8ce+yqfexBnrKW0eqAPuf2DFdkQzTSFI4CA9MfNX8g0hgQISe1Cfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f969ae08-26ef-4e64-9120-08dede2d9dbc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 02:47:43.5605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0876ueNlq05Pt1OJkm8na4FC7c9HKp8jikkbjTEr4Oi4YbSrz3mpboVDdUDd89f8hpc471w8EbG2PRzVlsE+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com

On Fri, Jul 10, 2026 at 09:34:48AM +0800, Edgecombe, Rick P wrote:
> On Thu, 2026-07-09 at 15:17 +0800, Yan Zhao wrote:
> > On Mon, May 25, 2026 at 07:35:12PM -0700, Rick Edgecombe wrote:
> > > When handling an EPT violation, KVM holds a spinlock while manipulating
> > > the EPT. Before entering the spinlock it doesn't know how many EPT page
> > > tables will need to be installed or whether a huge page will be used. For
> > > this reason it allocates a worst case number of page tables that it might
> > > need as part of servicing the EPT violation.
> > > 
> > > Under Dynamic PAMT these pre-allocated pages will potentially need to have
> > > Dynamic PAMT backing pages installed for them. KVM already has helpers to
> > > manage topping up page caches before taking the MMU lock, but they cannot be
> > > passed from KVM to arch/x86 code.
> > > 
> > > The problem of how and when to install the DPAMT backing pages for the
> > > pages given to the TDX module during the fault path has had a lot of
> > > design attempts.
> > >  - Extracting KVM's MMU caches requires too much inlined code added to
> > >    headers.
> > >  - A few varieties of installing Dynamic PAMT backing when allocating the
> > >    S-EPT page tables. [0][1]
> > IIUC, [0][1] here refer to design attempts that had various problems, right?
> > However, [1] looks exactly like the one being adopted in v6?
> > 
> > Did you paste a wrong link? Should [1] instead be
> > https://lore.kernel.org/kvm/20260129011517.3545883-21-seanjc@google.com or
> > https://lore.kernel.org/kvm/aYYCOiMvWfSJR1AL@google.com ?
> 
> Oh yea... I think it should be:
> Kai's original idea: https://lore.kernel.org/kvm/aXENNKjAKTM9UJNH@google.com/
> Sean's fixup of it:
> https://lore.kernel.org/kvm/20260129011517.3545883-20-seanjc@google.com/
> The problem with Sean's:
> https://lore.kernel.org/kvm/aYW5CbUvZrLogsWF@yzhao56-desk.sh.intel.com/
> 
> TBH I'm a little on the fence about how useful the links will be in general. If
> someone tries to rip it out, it would be good breadcrumbs I guess
No problem. I am fine with either keeping or removing those links :)
