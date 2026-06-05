Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8895C3E4C81;
	Fri,  5 Jun 2026 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650796; cv=fail; b=sJ8YiVvtlUsIbfjqFpd5i1Hgroezcybz3kLcVskmQa42tlxJRvoBp/k3myJymKkhXbWNyc3PunVeQ1KVY9Rw9DB4nZMy/2rSb26sWoVLob3KXibw3TrxtkNNK/K2CV9jYo6qG4bZ1+Y2eeT6H+gl5rT/JnsK9+urkK1KzN8+R6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650796; c=relaxed/simple;
	bh=twKQwWfA+0dRs7w8qQgR89cb72hLNqrdaE7eJx3xvcE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JkVKK8Gu3Dl8+364HFWlV/MX1RLpzEuJb1ue8CgF6N8jYXeovwsPQUbxpoMZ8hCdsK1pZo0rjhWVCw/70zHyMdVv8eRDQSugUpPcyrJc4ajkLtKo51t2yHoR/nque+oUvhiFMXlSEuZ1IokAb+2QpSP01yiEDHJm4NrDTiVL5UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gU+VhCjW; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gU+VhCjW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780650794; x=1812186794;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=twKQwWfA+0dRs7w8qQgR89cb72hLNqrdaE7eJx3xvcE=;
  b=gU+VhCjWklFIM90GAbSxrs3V1T710rdjX/lj6bhVwaMWLb/ATZ1FvF2j
   Smc02XuC7LVvPz2hiPidlad8BR1jgNUGimBl/lIE0Px61Pmlu+XoosyT6
   hyWJr+2WZUumgzCWAwo9m+kzeSZa94GUpnu7XcqK2/hmFOdylmzkG6upY
   eIEFHfA++6gcFzQM7njiBGnj8m0UuLZRXVQ9AXd1e8RVKm9jwu8kIh+q8
   weHTRVdb/0t60ufuBYdtcqs9rGyBDOau6aMLNVVWjeXBjzI5+ZN+vokBI
   zCTjDs2+GWsh4HhpevyiMmL5R8+Rx+WK2IAoCOJZwdauJjNYENVCBCx0P
   w==;
X-CSE-ConnectionGUID: Pd6jdORyRo+tWUSeroEJkw==
X-CSE-MsgGUID: BXc6DiD+SZqlnUVN5J0u3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="91798882"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="91798882"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 02:13:14 -0700
X-CSE-ConnectionGUID: QjoxD2NdQuqd2HP7CbNseg==
X-CSE-MsgGUID: TuWPHLjPThCxFe3EfmKwtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="241812752"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 02:13:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 02:13:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 02:13:13 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 02:13:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6oXyDjUWPu0eaD6cwTvCdgbNJvwgqzYtb89ioWOXjwFHcJZnI6MVKY0l0Mbtl8eShqEv5+wykMVp6VTJmP0YhqM5VR0r+hpD1erWzVIVaTEDOEuYXfVafOXUHDOwKHR5JnS6a4cXBcC+RzrlU9Z/T6lcOR9Br8vwuCyj59vPD48oazfejikCqZ/SqFuSeg6Yx1w3bmlltDi6/yyL/ekQzb4sFdfBGahSI3PLqKv9hf+RGALQo9aAIyyMRAUwyiQMZyDNUCBUZaFxj7OuKr5XqO7yQcMM+rwQpth7SgnXyCbRHVZs0r1OFC4J0ts3whFhkEaRvLK+C04HQva7t/GwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hS14DKLmogsKu8aK8W0Hr8rikOEtu6sCRYDhsSFHkCA=;
 b=nexMkIqX8/5xnyjo0ACVOdY1BclhAYao9UOV+ko+c50TbY/UdN5HlQ8mWJvgF3jiadxsTC1l71qizKBZ9QMVxompmDILu22WlFCIAeIcucHnxxFq+FhEDzyRooFma8Ylv4mLwUHnCExWNWqG4BDs7aoGK+w8FXfKk5rrmWC6BhO6nzAQII76owpcm7tEFiaUz7vaXV79KC48bnqURwJbaApVn298806L/qsZd53niMAy2wX3advoeAKYalU7xsuUrAwHtgPCJUYdNRm5npiN5j7oMywHcOhhrVY7isY2Fiym7q7s7+hVP8xUWu6xlUAtbf9MaGQqBjm8XF8BibseIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MN0PR11MB6110.namprd11.prod.outlook.com (2603:10b6:208:3ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 09:13:10 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0071.014; Fri, 5 Jun 2026
 09:13:09 +0000
Date: Fri, 5 Jun 2026 16:32:55 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vishal Annapurve <vannapurve@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
Message-ID: <aiKJt5j6vIqfh7S9@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20251113232229.1698886-1-seanjc@google.com>
 <aRsIstNXu0Bl0oID@yzhao56-desk.sh.intel.com>
 <aiDCkz9V2aS5Qcuf@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aiDCkz9V2aS5Qcuf@google.com>
X-ClientProxiedBy: SI3PR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:4:297::13) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MN0PR11MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 132d3e38-3c4e-4702-2ce8-08dec2e2a988
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|6133799003|4143699003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: LR2hy+J5b03Krn7aoGWungJAVsvfJ+ZWw8BsqWjOLDS7Q8TtocGeGXFp80QsFuKIXUuRfSp8eNF/Gtt7Hq3drPl1SbNkjfnec4pyOShGqS+Wu1xqtOX3soxZ4DjvR90i0i+AKyTNTeLfPIZgpQiNEWesGfHYwDQYdyNltiFhQvbmHjx1I0qe7TLKRFeKls/bOxnk1ry6GEzw8PTIO10EOZuLw7Y7zfRkV89jzTD/VaGW+ivJq8DcREnedNT+d80Xl33gnX8BEOkG2hessAX1e2Brl65HPJh+AjkcWpEmeZ7NuVIkXFNH4UyH/dD8Dk7bnAgJyNf/hyesAnjw3eIoDZtnQ8Js1Mc5zWFbtGML/bGKniWXP5FFeGRhRo+6tt5njyGtHLHAcrjcf7zmSiqkdQHUmWXWIMHrurxCppvOliO6/9+U7Gw98STkHuyRbVI6r6m2nIDYRZeoMoO+YM1s9LC+dX1deujSLbX1Nmr2KJXHrmAHwwQ2hEJ4hq7Fansmt7KL2FJMMuCp3H8abuT+9+ddGUqO+55dhBRqlQUvPC9e0kvOrXQNCe4Clf2KKJO+PFu2+7EV8NcmcrbHBh9cmC6cPUu2xv3bxknRJI8BYtb82cNyVRjEgkbSWwM250QL5r9p4KpJaOvymPH4krnSbPOiCl//6LZ7FIzat2ZyCb1KEnXaFMcLMLXqnd3zqldW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x8w00H5fx1dFvadENfdQ8H0Sek4+rQGKUvxL9szQfRl41OIrk913C88XhWRX?=
 =?us-ascii?Q?gAcD20Ks4TlRgwrFcZgzG6o9DD5Ks+Ezyonwfqc/N7WFsa8mXACcBBYhW6Wn?=
 =?us-ascii?Q?rnOAXp8ko5+BmsJpSJP/7YkSli4i3XZRYcB+xythCpYORNAAQ4yec0DSVlBI?=
 =?us-ascii?Q?jpJmmg4nCCjWS4G2fbVTbKgrU+mLAIpoyQ5g7IbNeQ09lyLFnFr7Ub5H+9t/?=
 =?us-ascii?Q?srSSxclzprTl7CxMwxgUtWUKyymqA4FnIQX+jOSYn1mdvb+PHRvpk5C1CWWx?=
 =?us-ascii?Q?IWy+A8JcWOrSfGdiR1ORfl0VtRHolk2AKHx6QXLUorxV+2n6OouJS2MWngAs?=
 =?us-ascii?Q?HQaROBaDDx6jubGeUTjqwFZsYPCTejuGeOS89KsMLRliNQNV+WxbxHyWM3G+?=
 =?us-ascii?Q?RsciBzuv3UbPDYwUp7ISawI1aKfssbJuOHezMsE9O3d2YOKyco4EvOab3u2M?=
 =?us-ascii?Q?yj2mj3+ZT/i5QWkZdfwK9VJqXYvBgJh8rW0OIyhFCTmzSIB6UHEy+vsP2it/?=
 =?us-ascii?Q?RYJT3b2MfP4uf0Yr2D+M3/UMOW2Jk6t+zSCLb7yVX3bACb8pBy9Ql1qZcrAJ?=
 =?us-ascii?Q?WCoDD6NvHPxmPjIdFm3Ow3wXSAJt0QEeK/zyjDlLQQ+gMhNlq4cbR34IEKs0?=
 =?us-ascii?Q?ufp2ZN2DSzD5bCmpJ3SrGm0GSmusfwZf17DpNQYXV1euZ+FmEcrjAdOm13Ab?=
 =?us-ascii?Q?k3Z4pwK9UPSP1TRR5rquuz/E0SYy5LWm56XIH4mlOKYXsHV6PailXCgY2J+M?=
 =?us-ascii?Q?wIamsMnh5e1oTwKUbJV2JvxVQoLbSc8as+QGeLQPdSYab3btEMjJzMjC/sp+?=
 =?us-ascii?Q?f+CJOzr+R15InlzvM9ZYUfGiikigQEkyf6k45vGg2UXFb031Ab8B2sBogOi+?=
 =?us-ascii?Q?9SGwetds8nMrLWgnEYZoVO/HPkYNYHDgjiGh2nP6Ev9aG5qmqrOcBEwK1rTJ?=
 =?us-ascii?Q?6eJ34tMwHC5xbzP5H1+UJyGdry+cChU57eGZXfaxxaz82ZtdSkBfV9JWjEZI?=
 =?us-ascii?Q?dZzvv8jlowFHriwitoXl3BVpaBiQ6y5ozHlLIIMizm8ehJiILfHDaf3+sCvg?=
 =?us-ascii?Q?Cf/HA5ys9SsE6NnnaXOkUxzQg2Jt35Q7KBHKfqwdmyPclA1ja0wi5lE+smR8?=
 =?us-ascii?Q?7A43r1hzUkuYSFlLO8EnqnBjbu2VFhCeSu9ymfh1UmUUa7nvv9MaOgIeQLp6?=
 =?us-ascii?Q?Ia8hIMrucnMe5VY7kUHhcTyMKxgfroXmjT6vH5sqcUEMsO/jjzrgqM7FpmPY?=
 =?us-ascii?Q?/XwhgBEgxgLCRhD2VEzsFhnsGgcgeQEVVqYt1TYw66QBJV8LbCH3tk+I+FjS?=
 =?us-ascii?Q?4RrvgwO59Dpbk7db5LyQin4JUPYTLDGqQ7I1q65UWaAoQNEJOYve0XaLhOR1?=
 =?us-ascii?Q?RdijORNO/5yq+UJc02ZVJEoHeRq/Itz5svawvp4uMZW2a1Yil7WycBCGt/jX?=
 =?us-ascii?Q?6+ReLVhOPKJ2rdUGres5t1Obu0E8TeSaD/2iqEOgIArwWn2od4bQWNP+JM8b?=
 =?us-ascii?Q?PpmMhhBoa4MSxaOXddzXEuqZhQ8TtRFAIfLQJq7R+iT+gGEe+wpH04m4YxwW?=
 =?us-ascii?Q?EjLWXwa7y8/LuU0MSX93JHyM7ju5pVykqzAKnGG2rlYa/tJ+tfwOHeSzPreX?=
 =?us-ascii?Q?FdbHfMCE73ZJpfjO5Niy2yDZRpyTRQDAxJeg565mivbUq0VGh2gDMN11lqLy?=
 =?us-ascii?Q?JooqJ+b8YWi0cPqneLLRWlKDPVxnq0cRw6Z4DFAxf/RvZPZet6WjIWf8hRCO?=
 =?us-ascii?Q?Utug78fizQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: bQc6YoqsvEnuzSEi6S5g5DokQFCq9vEKfVvEZmUJ57FzjqtXN5WEVB6qlf1UycdlsqFY4aCAz0dJD1cyHVDxWW2vyxKcfm8+smLim7VBG0RG7mg0q/t8JJr6XKwVK7xztATrjt9ATv6WQL2AguzhEhkspwU0kS0+CXz8nrf8WzIMCfCYHbZ08ByKHSwxYmSp6miytpsd9H/bAJSSvPcswVLpUV76xME/1FVOha6FVWf/NAbTPtGbzAhsudhLZErwDv1mI1sx0e7pDaFbkXqFlZmDDt3SG786nvST2HQ4gDmAs/imKUzQ181q0Gvfc8+bWxUKBa5AryJUtpr1FzGlTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 132d3e38-3c4e-4702-2ce8-08dec2e2a988
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:13:09.7952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBgkGCCrfKEqZnYrhtQni8JuIhnt1Cb+qPz8f9vcwipvpXhaPwNg5kHYtJlgYo5jqu8H6Rq7WZ7KyEzFNDYc2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6110
X-OriginatorOrg: intel.com

On Wed, Jun 03, 2026 at 05:10:59PM -0700, Sean Christopherson wrote:
> On Mon, Nov 17, 2025, Yan Zhao wrote:
> > On Thu, Nov 13, 2025 at 03:22:29PM -0800, Sean Christopherson wrote:
> > > Add more context and information to the comment in kvm_gmem_release() that
> > > explains why there's no synchronization on RCU _or_ kvm->srcu.  Point (b)
> > > from commit 67b43038ce14 ("KVM: guest_memfd: Remove RCU-protected attribute
> > > from slot->gmem.file")
> > > 
> > >       b) kvm->srcu ensures that kvm_gmem_unbind() and freeing of a memslot
> > >          occur after the memslot is no longer visible to kvm_gmem_get_pfn().
> > > 
> > > is especially difficult to fully grok, particularly in light of commit
> > > ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when
> > > gmem is dying"), which addressed a race between unbind() and release().
> > As mentioned in commit ae431059e75d ("KVM: guest_memfd: Remove bindings on
> > memslot deletion when gmem is dying"), unbind() and release() are mutually
> > exclusive, i.e., both protected by slots_lock, mentioning "race" here is
> > confusing. So, that commit addressed the mishandling in unbind() after
> > kvm_gmem_get_file() returning NULL?
> 
> Yes, that's the race.  Just because two chunks of code are mutually exclusive
> doesn't mean there's no race, it just changes the granularity of the race, and/or
> how it manifests.
> 
> I consider it a race because in the failing case, there's simply no way for
> release() and unbind() to run sequentially.  I.e. the only way to encounter the
> bug was to run two operations concurrently, *and* for a specific ordering to
> occur.
Thanks for the explanation!

> > > No functional change intended.
> > > 
> > > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > > Cc: Vishal Annapurve <vannapurve@google.com>
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  virt/kvm/guest_memfd.c | 20 ++++++++++++++------
> > >  1 file changed, 14 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > > index fdaea3422c30..2e09d7ec0cfc 100644
> > > --- a/virt/kvm/guest_memfd.c
> > > +++ b/virt/kvm/guest_memfd.c
> > > @@ -338,17 +338,25 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
> > >  	 * dereferencing the slot for existing bindings needs to be protected
> > >  	 * against memslot updates, specifically so that unbind doesn't race
> > >  	 * and free the memslot (kvm_gmem_get_file() will return NULL).
> > > -	 *
> > > -	 * Since .release is called only when the reference count is zero,
> > > -	 * after which file_ref_get() and get_file_active() fail,
> > > -	 * kvm_gmem_get_pfn() cannot be using the file concurrently.
> > > -	 * file_ref_put() provides a full barrier, and get_file_active() the
> > > -	 * matching acquire barrier.
> > >  	 */
> > 
> > >  	mutex_lock(&kvm->slots_lock);
> > >  
> > >  	filemap_invalidate_lock(inode->i_mapping);
> > > 
> > > +	/*
> > > +	 * Note!  synchronize_srcu() is _not_ needed after nullifying memslot
> > > +	 * bindings as slot->gmem.file cannot be set back to a non-null value
> > > +	 * without the memslot first being deleted.  I.e. this relies on the
> > > +	 * synchronize_srcu_expedited() in kvm_swap_active_memslots() to ensure
> > > +	 * kvm_gmem_get_pfn() (which runs with kvm->srcu held for read) can't
> > > +	 * grab a reference to slot->gmem.file even if the struct file object
> > > +	 * is reallocated.
> > Do you mean that as kvm_gmem_get_pfn() can't find a stale slot, it can't grab
> > reference to stale slot->gmem.file, even if slot->gmem.file has been set to a
> > different value, i.e., after invoking unbind(), bind() ?
> 
> I was specifically trying to say this:
> 
>  1. slot->gmem.file == old  ==
>     synchronize_srcu()       |===> window #1 for readers
>  2. slot->gmem.file == NULL ==
>     synchronize_srcu()       |===> window #2 for readers
>  3. slot->gmem.file == new  ==
> 
> kvm_gmem_get_pfn() can run in two "windows".  In the window #1, it can see @old
> or NULL.  In window #2, it can see NULL or @new.  The synchronization ensures
> it can't grab a reference to @old once window #2 has been opened.
Thanks for the clarification.

> > But I'm not sure why to put the kvm_gmem_get_pfn() relying on
> > synchronize_srcu_expedited() in kvm_swap_active_memslots() in the comment of
> > release().  Without the guard of kvm_gmem_get_file(), kvm_gmem_get_pfn() may
> > need to provide some RCU read-critial section too for release() to wait by
> > synchronize_srcu()?
> 
> No, what I'm saying is that without synchronize_srcu() to create distinct
> window #1 and window #2 above, KVM would need this:
> 
> diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
> index a1cb72e66288..e66e431bdb98 100644
> --- virt/kvm/guest_memfd.c
> +++ virt/kvm/guest_memfd.c
> @@ -347,6 +347,8 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>         xa_for_each(&f->bindings, index, slot)
>                 WRITE_ONCE(slot->gmem.file, NULL);
>  
> +       synchronize_srcu();
> +
>         /*
>          * All in-flight operations are gone and new bindings can be created.
>          * Zap all SPTEs pointed at by this file.  Do not free the backing
> 
> Otherwise there is no guarantee in-flight readers can't reach the old
> slot->gmem.file.
Hmm, however, if the reader (kvm_gmem_get_pfn()) has grabbed a reference to @old,
kvm_gmem_release() can't come; if kvm_gmem_release() comes, kvm_gmem_get_pfn()
should not have been able to successfully invoke get_file_active() on @old.
After kvm_gmem_release() returns, any subsequent calls to get_file_active() on
@old should fail and return NULL.

So, even if the reader can see @old, we're still fine without synchronize_srcu(),
as get_file_active() and SLAB_TYPESAFE_BY_RCU should have provide the safety.

Am I missing something? 


