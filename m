Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352193101BC;
	Tue,  9 Jun 2026 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996296; cv=fail; b=AHtbim+KC6MsqztkkVEdNqN98SeLYOLykC7lVdg/1MxgPAcXV1Ia6rwoTyjr55ldePHJouRe5fiLb0XcaWYhEu5MM+BbyMlJsoVKR0xrnl9HBZvnPkkhSBmOYxYE+CAF8QsVkiH260/MUCvne3g0sODymGH4X3WelbZcrBIEnD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996296; c=relaxed/simple;
	bh=bZ/BgbLPZOZeUhiWnGc1/qv7zlPvfntYZ4SQW1hZ9t0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mSvnY8mzpD8iND9qZ9gdaZ1cnmwTI2qzFKb72xO1+hGgPli9ZzUwUMbphyVJakurlftwvUvLineurGUV6Rj0lthmRSUnKEjRbEpu7LsKx3l7jMrR+sMgKEk6CsjpK4CPRm6ZII0VfTgp5Q4r5S3+maRvhGoqfMiSszyZC9vhZic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/gVFVL+; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/gVFVL+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780996294; x=1812532294;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=bZ/BgbLPZOZeUhiWnGc1/qv7zlPvfntYZ4SQW1hZ9t0=;
  b=C/gVFVL+/alKqPv5Tt5rgWArwga42QRFAPZqQ7y8sKHz3IxZ7+ocWCoF
   izQjgIbu6FkTuLAwGfTua2TiQ2Za+ioK+oySjaHF5b45p8NtP7//nR/jt
   0FTKsisKkqG0I6mKVOXz3bgycAxq6r3SDrBHhL4z4XiPuwkWd/TOZPvMq
   tEcOl0R6UOF/K/CX1W88jNHEySbnljm5Y64jGMhjikLVyM70XeiDOxay9
   q8/cgVmoEqjJJLjrdfOTo3f2YAJKDwXeSRudUiVuAX8XSWsXtokHlKXI5
   o/34vk2c3D5s8YsCqV6pQCcaBwAAdYirkUDr9wUtptKFY4lJz3sNiCvsg
   g==;
X-CSE-ConnectionGUID: +gjNiSL5Q+adTq1r4YWC6Q==
X-CSE-MsgGUID: MZjOBkfzQZ20RRghHwRCWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="92314596"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="92314596"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 02:11:33 -0700
X-CSE-ConnectionGUID: a9X5UwunRRCxEcR0XYY+fQ==
X-CSE-MsgGUID: 5lce9XvEQ0W0Mao5Vk11mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="283891671"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 02:11:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 02:11:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 02:11:32 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 02:11:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED3IEL6p5QTs0kIT6eFqtG9jh8dJz8hzfFybCK7QkiuT6PKJ0OE1LRPdqalzjSnsKVc2CoLUBKkTe9J0225mW5Fe+zV0iElJ07L9MChLOOug9QZ4vtW+qmpJDxvKq0t/O64LQ9LNW1a5ombCUwMmB++PujrSMh/ADDfSdC7zQeUnvx9gQDbOtznwNHtPbwpcP8RRlzz3prhbx7IW590EOqPP7WABZbmfoXzkg12e0gK4nbrmy03mvw6+7MzsWZi5B3zRGppW0qTFF3ZilGUYdPIMDSWnZsVhTSSxvwFTZkt9hlUrik7Tz0LXofmc2MG+fupOQCrY2we5YBzlCwbzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6p8XSy7FcvriYinctZhAgUaeQyAtl226CpYdbIDMmUs=;
 b=r0EQm8+HVAoG6Gz3YLFcbZLu0wQnT81nPGLsLhYV5478y/0n0ajtYlR1/MZvj5f0kAQXB7yNrOvoGvnIi3qBgm/kgGS3+hUwX3pE0aaSzIkMiQAldVrtK3lUceZMniheMzd6ohKAleLV93DNs+jk5uiRTWpPEOW9m1H1uigqDq0zkduweT7xq4QGERYYJWN/zUv0pgOySs9p0rlxin2k8bLhyjcBCgsEJe/o+Yak+8ae5bsAUi6JQGKGKyq39X/kMPY551go6vtaDyepjKHVnuK/cq/EWH6W/wcFCTXg6Vhcvh5kf5qqq8pryzehhQ5Eo/W92f/ACb2jq87+Ij3xPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MW6PR11MB8390.namprd11.prod.outlook.com (2603:10b6:303:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 09:11:29 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0071.014; Tue, 9 Jun 2026
 09:11:28 +0000
Date: Tue, 9 Jun 2026 16:31:12 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vishal Annapurve <vannapurve@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
Message-ID: <aifPUFncRYYpURL1@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20251113232229.1698886-1-seanjc@google.com>
 <aRsIstNXu0Bl0oID@yzhao56-desk.sh.intel.com>
 <aiDCkz9V2aS5Qcuf@google.com>
 <aiKJt5j6vIqfh7S9@yzhao56-desk.sh.intel.com>
 <aidvQyD6BqbE2_A5@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aidvQyD6BqbE2_A5@google.com>
X-ClientProxiedBy: KUZPR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:34::15) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MW6PR11MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba4dc40-c6cd-4144-6648-08dec6071712
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|6133799003|4143699003|11063799006|5023799004|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: wb5JjrUPTvzQdSZXMSExlBBEwyPzwdVL/UV8iY7nLuITS/u1kGxyb/2zCN682j5O+C36FEMu0WGxRemYgnZO3j63sEhlVU60SPsGGlSYIjjnx4G/j8+0nCcBKQQokiFk0K30HG+3fdQ0lLWkbBJTHIFxEdl/PY6bGIAxebKEiz9yVT95gKAZLtw8vgZQRZ7lwNwukR5KOvuYCtj9c1Xir0v1o0yCmvaBIDJkuLLswfNMUUBKOPo1b3SDKYiAKckc+aTE5459PF039gFSGn04M+IS8lOvOIrXEzXzuo9Fvog3f+EKBL+xTgFDa/G80g7d7QC6D9YpK0KLqmGFk4HpLSbjZ/EjuM7lerFner7i5vhK1yKt7Uwo3z53Y62eJ6Wrha0gyLLVyBGbYhAK7BEgxkFBqluFLIdmGCdcvixBKNRDQ65z1MgDXn6LmqQDWZk9q2KmAc+0YE6s9S4zrDdHgkrUGI50ppk/5IRplERLWkfuWMPhYdecGA4uPCVO+7JEF8YD+GgOSyNsC0KfOujM2c/V2CEq/cZnLdMDP+Vz3pw9NEDe0JwQAw55i3nBGs7snYXOLaDpB+GjlH1NBTW5WmvFFR1t7ky47Xa9uYpjZFxs701bVP5beOjNTA7SOaVAhgP3M4FPs+Ad6aup4puhU5SXlznBtW8NEnm33PWgcX5MfNaLoMUf5yDub1qHWK0T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(6133799003)(4143699003)(11063799006)(5023799004)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?numx3Qx8E+unDDBIHV3ZNopgeiMqByjY3HPPNguHjqinMtn9vN8kIt7X1MbS?=
 =?us-ascii?Q?Tzo81ysyqS1Byx24TClFc89cD0qiguYZfA7vKYRSCEEfsHYaE2XJuuZqM6rU?=
 =?us-ascii?Q?gNTd67DFRQFJxHz/572eOhlxHWcIkbLxv1nIUOsgD8iAsI68rmkgjCnohlmP?=
 =?us-ascii?Q?r6SOGeFD0CNoPdJAPlpijpsIiVIIJ/aB79Q/1P5x2Pi4ZM1cJVcV2no8/4Si?=
 =?us-ascii?Q?03dSTA9CIM/Faka7Lz66Le1aY+au/bE5FKFUjmTtwTKl836Mj4C+Po01H77W?=
 =?us-ascii?Q?i8MlRcWwtbJqnM2U3mC2WUSqrxlz+eVkF+NnaqBTeHzwEL8TH45WaFoycLnG?=
 =?us-ascii?Q?lY7VnhBzP7jtsMt9ZRBLC/awVcewzuUdbh3rZinaiPakNJ47dLyyObUtbDPp?=
 =?us-ascii?Q?XHCKI5GJjXY5jfgyq5sXzD+6Kz5ZUd5lTvbFvIVYpMhJl+H/Dj0C5TshOqL/?=
 =?us-ascii?Q?xFtRgP1NAnjtTxcma56qTmxNrl7SYwY6UKgW5jQPgD8U6WyrBEceEByRhmps?=
 =?us-ascii?Q?WvrEgGPtk4kt1b3Co3ZzS1Xp1M9YhXcmNIzdR5LAYQF9RCmFSgOuE+a8OhPZ?=
 =?us-ascii?Q?+jZZSn3VV4/Qa6fiwvFQH/yHmWGZKZmlW70lXVn3DxB4EkuqoaSEE3/wf8q7?=
 =?us-ascii?Q?BwKa//C9KDNAEac6z7wpuHnBORr0/rnFhwVhMG3Yl5jbtQot2+dp+UWOkY2t?=
 =?us-ascii?Q?X9fAJD1um+utAwt17YpP3oITMq78koAvQHuFKEWgZ4xOHa4JV2hQLUA7vueD?=
 =?us-ascii?Q?wU8aCWAnGPs0m2IL3ySizBeYQSYfpL+lzkdOUsGoqS+J42+jiRRX+d0xK9Ku?=
 =?us-ascii?Q?MdU/6V68HQAhqPDxAwYDaMjxRhnk6Jgu3H4t8nu4mXeRDxsXSIBuJRSdgSb0?=
 =?us-ascii?Q?v/uViB/KXXMzYPb35lBTZ3+euLHx7ufj/+je1ABKx53llxNtL5p72nceEYXj?=
 =?us-ascii?Q?weEXUsBsiP17FdIYuIFSuF9vt2ORT3pT0FYHM9u8KdyyXBQLmnKwtG1nlI6E?=
 =?us-ascii?Q?r4LYjAQ8YF6ecWuVdIg+JYtaqLBwTH5mvRu/ZOGxSBgEh9hpIHDIplNIN36i?=
 =?us-ascii?Q?0xB+LENiDV8lzs9gdJC71JBaxjBRu+eO85ghqnr7fuY0zJPziCrnGt4H5mI8?=
 =?us-ascii?Q?WhZwVdUJj4S61znGX9JkHLQdiZ2vvE2vjA4ECvSqdXksLarearUqzE6F5wy4?=
 =?us-ascii?Q?tgS5oceHCwbSjHxsUOWvji0vl1XRJ7kJvUXIh2NoEYW1Ny3gZi/oEUQrCm1r?=
 =?us-ascii?Q?7m2gBgz6GZAeDEucBFtCOBBnUXktIqjVT+Jxokk60gejxUKPe9nJVp2+THZW?=
 =?us-ascii?Q?FnkChDzb7DTcjrNEbhBJMFOy5ywkFm8Gj3MS/Pw4svN/OEQcI+xHvxkpW8gF?=
 =?us-ascii?Q?m5qAzBC/pS9cN6wyV2qcPHgOTDXW3OL7d5tI7c2FJZhA/jYMLRodWAhjCGSs?=
 =?us-ascii?Q?znVcJXQW0XsVZLyFfKT9f2Pt5Rdcnb/aQ7MpbJQTBYC1GGb+5opR6RaJTY73?=
 =?us-ascii?Q?uKMfoLH19YagaLqex5ac42W36n4eY/6PTvV+CWFSqSeIhz2gFE8DvSKYGTkw?=
 =?us-ascii?Q?vi4m0SvVs8+73ylTxhZfQZjFzUP0m3qSxlB3JZz9IFO3yLoBlySzQYFGSpjk?=
 =?us-ascii?Q?oVx3MTgZJ/H3vT8uN0J83oO0IpsvLLa7RNOTq6sTDIQDl+APJ4ylcPl4ORSo?=
 =?us-ascii?Q?2Aq6zcZpPuTO1k4a8wZN8Owe95CN1QSB4qLpSEbI/gFrtIyNWPAsnDeV8ays?=
 =?us-ascii?Q?8O+ZxAQawA=3D=3D?=
X-Exchange-RoutingPolicyChecked: HiONafELRfMhyX89FGrU2kYojNItgtqckitGm7lSL/TkvfjWOS+Y0fie6pSV4wR2H565AIBOcEw+VCnEgSAEt5+BVa93xdGenEOBbYRmisz/tsvao+wfJl8a7lzHubKpJmIO4PjShAU2hc1qRbLZ+q5IwFcpa/Nrl0ph5TffqKbhypnvOP1kRSnXEdCzgTiNopP/pdlLhHrPsO74sKk4xoSnfEIG2c3J8vMTGm6lGS6uVvmdYAciRrUr5Z+XY0iVAITe3KHind6kwrcOUOI3XplYhRH8qU16+cuc4Tc7LGuKeBOuo7ShBzTBAq9tl+1EAmu0LuHEgGAHpHND+4ywjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba4dc40-c6cd-4144-6648-08dec6071712
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 09:11:28.8947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1VGsmJoMkRnCNPb7wTUFWLBH4RlwStfINMYGfSx21xjiyeGC/c+L1svIuXjtMNHEyk36W95SwTCQuoRRhh0eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8390
X-OriginatorOrg: intel.com

On Mon, Jun 08, 2026 at 06:41:23PM -0700, Sean Christopherson wrote:
> On Fri, Jun 05, 2026, Yan Zhao wrote:
> > On Wed, Jun 03, 2026 at 05:10:59PM -0700, Sean Christopherson wrote:
> > > > > +	/*
> > > > > +	 * Note!  synchronize_srcu() is _not_ needed after nullifying memslot
> > > > > +	 * bindings as slot->gmem.file cannot be set back to a non-null value
> > > > > +	 * without the memslot first being deleted.  I.e. this relies on the
> > > > > +	 * synchronize_srcu_expedited() in kvm_swap_active_memslots() to ensure
> > > > > +	 * kvm_gmem_get_pfn() (which runs with kvm->srcu held for read) can't
> > > > > +	 * grab a reference to slot->gmem.file even if the struct file object
> > > > > +	 * is reallocated.
> > > > Do you mean that as kvm_gmem_get_pfn() can't find a stale slot, it can't grab
> > > > reference to stale slot->gmem.file, even if slot->gmem.file has been set to a
> > > > different value, i.e., after invoking unbind(), bind() ?
> > > 
> > > I was specifically trying to say this:
> > > 
> > >  1. slot->gmem.file == old  ==
> > >     synchronize_srcu()       |===> window #1 for readers
> > >  2. slot->gmem.file == NULL ==
> > >     synchronize_srcu()       |===> window #2 for readers
> > >  3. slot->gmem.file == new  ==
> > > 
> > > kvm_gmem_get_pfn() can run in two "windows".  In the window #1, it can see @old
> > > or NULL.  In window #2, it can see NULL or @new.  The synchronization ensures
> > > it can't grab a reference to @old once window #2 has been opened.
> > Thanks for the clarification.
> > 
> > > > But I'm not sure why to put the kvm_gmem_get_pfn() relying on
> > > > synchronize_srcu_expedited() in kvm_swap_active_memslots() in the comment of
> > > > release().  Without the guard of kvm_gmem_get_file(), kvm_gmem_get_pfn() may
> > > > need to provide some RCU read-critial section too for release() to wait by
> > > > synchronize_srcu()?
> > > 
> > > No, what I'm saying is that without synchronize_srcu() to create distinct
> > > window #1 and window #2 above, KVM would need this:
> > > 
> > > diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
> > > index a1cb72e66288..e66e431bdb98 100644
> > > --- virt/kvm/guest_memfd.c
> > > +++ virt/kvm/guest_memfd.c
> > > @@ -347,6 +347,8 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
> > >         xa_for_each(&f->bindings, index, slot)
> > >                 WRITE_ONCE(slot->gmem.file, NULL);
> > >  
> > > +       synchronize_srcu();
> > > +
> > >         /*
> > >          * All in-flight operations are gone and new bindings can be created.
> > >          * Zap all SPTEs pointed at by this file.  Do not free the backing
> > > 
> > > Otherwise there is no guarantee in-flight readers can't reach the old
> > > slot->gmem.file.
> > Hmm, however, if the reader (kvm_gmem_get_pfn()) has grabbed a reference to @old,
> > kvm_gmem_release() can't come; if kvm_gmem_release() comes, kvm_gmem_get_pfn()
> > should not have been able to successfully invoke get_file_active() on @old.
> > After kvm_gmem_release() returns, any subsequent calls to get_file_active() on
> > @old should fail and return NULL.
> > 
> > So, even if the reader can see @old, we're still fine without synchronize_srcu(),
> > as get_file_active() and SLAB_TYPESAFE_BY_RCU should have provide the safety.
> > 
> > Am I missing something? 
> 
> In kvm_gmem_get_pfn(), because slots_lock isn't held, this could happen if
> kvm_set_memory_region() didn't synchronize_srcu().
>  
>   CPU0                                    CPU1
>   kvm_gmem_get_pfn()                     
>     f = X (from slot->gmem.file)
> 
>                                           kvm_gmem_release())
>                                             slot->gmem.file = NULL
> 
>
>                                           kvm_set_memory_region()
>                                             slot deleted
>
>                                           kvm_set_memory_region()
>                                             slot created
>                                             slot->gmem.file = f (alloc the same object)
> 
>   get_file_active()
>     file = f
>     file_reloaded = f
>   <KVM does weird things with an old memslot+file> 
> 
> Obviously KVM would be wildly broken for other reasons, but just saying
> get_file_active() takes care of everything is misleading because it only handles
> reallocation of the object, it doesn't guarantee a reference to the correct file
> was obtained.
Ok. Thanks for the explanation. I get your point now.

My previous confusion came from the fact that if kvm_set_memory_region() does
not wait for all users of the slot being deleted to exit the SRCU read critical
section before committing the slot deletion, KVM would be wildly broken
regardless of whether gmem is released.

> E.g. AFAICT, users of get_mm_exe_file() don't care if they race with
> replace_mm_exe_file(), they only care that they have a reference to a live file.
> 
> KVM on the other hand cares that kvm_gmem_get_pfn() gets the exact file that is
> associated with its memslot point.
If slot->gmem.file can be set back to a non-null value without the memslot first
being deleted, synchronize_srcu() in release() isn't required, right?

  CPU0                                    CPU1
  kvm_gmem_get_pfn()                     
    f = X (from slot->gmem.file)

                                          kvm_gmem_release())
                                            slot->gmem.file = NULL

                                           kvm_set_memory_region()
                                             slot->gmem.file = f (alloc the same object)
 
   get_file_active()
     file = f
     file_reloaded = f

   <KVM proceeds here should be fine with slot + new file> 

