Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80473A75B6;
	Wed, 23 Sep 2026 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139162; cv=fail; b=AUmEHgC67n++KiomzYvlNqOsvtyzNewpj/8BCSScoSxefnjWR1U+8nXAnA7V0YtmEj4WSSD7G/gt7TA5S/uV2XT6vQ9fhGFQWSc9xuuxmlN17/hHPIY4DEOfCxdobRbcbKcKvmalZNH+00LWgvEX5/0O06V0nNFeHb0Tyoh7EvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139162; c=relaxed/simple;
	bh=c/z2DzoZXPenK4HlVhCycC4wyLxp0g1NKYLNpGS1arY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j6u0XYAcQVE2iii/kDe3Br43XCu+9CRQrpAeJFtZbkFaOVyK1gAd7/Puw9FOBdFszqOnosG+oAm5svYtsYWwgAEzey/xLfbdzCbppbIniMPnU0YIOvJUAKiRfgz/8TViwRPuguIYOBWB+V3gkP2SbP67XqGqWf/Pkfyw49kILys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICfaoMSP; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICfaoMSP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790139160; x=1821675160;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=c/z2DzoZXPenK4HlVhCycC4wyLxp0g1NKYLNpGS1arY=;
  b=ICfaoMSPLIGyX02n1+Gis31MeHvXXtk1kYLxWN6EbDal/wYmXukdwr81
   ZE+tZsyZRGut9v52YA09rvUmPyznVZDYcevx3AysOi3velw726ZJ1WYuw
   xwIk70BNFJ3vrVRJ1iby07apXrs9Hh/OnUzdZLSHa81wGVSfmyDTqfJvC
   L0SGY3/7ua9eU4WzrTpmRwt598fh2KAPbaK7IWAHMLh7dK8v1BvgugSRt
   9zJDbX2jvvx65L6bkhrKq+AI7gdG0DqtsQ1mdgz7L/L019npzBURMmddl
   wyLV9RgXR+19GBkbZUhFoTpbOSaCsJtIAFoyuhA7QlieSTiRTnftxZ2OH
   w==;
X-CSE-ConnectionGUID: i9OEaZxITcmLoGfrvSPPyw==
X-CSE-MsgGUID: KHHmuQrCQT23AvV1TlP7lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90818186"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90818186"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 21:52:39 -0700
X-CSE-ConnectionGUID: Z/i4LpFkTSKNF9HAvsgjYw==
X-CSE-MsgGUID: j0rMxEjvQK2a/94u3zT73A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="269960233"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 21:52:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 21:52:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 21:52:38 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 21:52:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duXsbhlScaRRpM0PAgaQ3PH/w7xclpN4vupq6OYuDCGiRRrv0EpYqrAQgkxdYESfgQhE9X/winHtGYNcao3zhonWL9b5D73FadykN67+Fx6TDT8dkH2OclXFocWta3Ug1IBsZAGCFZIYdc2QvuEIcTHlo9lrmcevM33Onv6Lz873fjkxKnrcOYiZN+JJSJEm9+5YECKB/kqyzqLs6S/p6yTKhzZTtcmwWRRT56fJxRSOAmY/aP0eh5SrOmI1q5ALJaNYmQ6itP6a8vVY4ffuU5f78XPjtgYy/Yni5C53/NHGlQIhm+HgMEsMCYEv7ZtQ3ojEcVek8Xrm7wH0Y0bV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/oNine42H7W4LGmxZOhOlGtXhkgPgeyZ40ywY8ThN0=;
 b=hLchX2uoXEGXbf9Om07/tC+2mSt7Ga5gNtnL4iFmar7StNLE+yX2R7GRmfSH6v8aCuvYZOzNSgpXyz6EkHgdqfFyU9XzVroeybM4kc6XLT+aSDMYCH+4CCr8g1+iS7khFezbiYhg/mAo531YGzfGdC30REirsrhBOkIscYunnQqtE3j/l+AoI9X/SSTvBHvM8SEtF2z6SAHCoqUzQlICBWx4MjzFlOZUEGOh2l30I8yIuV96caQtda5NEoDvMxErEQt0rW+XFpSIOM7z0KNUB1D9XItYw97eoEKjT1f0c5eZ0l6heRJGqnZ1JoYoju0VXd7KuDCN5lRTb0cJKuKc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by IA0PR11MB7742.namprd11.prod.outlook.com (2603:10b6:208:403::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 04:52:31 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 04:52:30 +0000
Date: Wed, 23 Sep 2026 12:51:55 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Stefan Teodorescu
	<fane@google.com>, Dennis Tighe <dtighe@google.com>, Sashiko Bot
	<sashiko-bot@kernel.org>, Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH v5 6/6] KVM: guest_memfd: Drop superfluous WRITE_ONCE()
 when binding a memslot
Message-ID: <arNa66B3tmJc7Kbd@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260922001332.1121266-1-seanjc@google.com>
 <20260922001332.1121266-7-seanjc@google.com>
 <arJsKA8MkSdpQxNm@yzhao56-desk.sh.intel.com>
 <arKG2UnTWySdOAkc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <arKG2UnTWySdOAkc@google.com>
X-ClientProxiedBy: SI3PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:295::6) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|IA0PR11MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 22662c2a-e741-4ad1-ad8a-08df192e794a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|5023799004|10067099003|6133799003|11063799006|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 96pICMDjS56D5OEsSKDdzSNJqFsAMv5no0Dv70ouFebvJPX/Y3W+gELKJnmslSCfW5zIpx4YyQ9KHaI8SM0pIJMmbutGMGXhGBgVkdSOhJgBWQsrNJLV4oEtkALTO/Dm9JNpy/HBj8GqeAwUAkRyrKCuCelBSc/6W0+a+cYj+DME7lnTqTApJsEnc7PRIvVxk6an9QtpzYbAcS4Vqpfnd0WlmLhSyLTaNR4XesQj3wtLsXgIl04c19j1Gnd2mJblfojrghjLKZ4+2E3rtYr38Tsxj+mrPP+a+gH4m3H6QdpWuac9595/euu6yOTn0zA5P7vkKW5aFq8WaTSpm4Tn0oydYTAwuN6Ow7tmBliZcQaM/xcJppepTVw7bafNeUaurLzZCgsJaXl2VNDzfZVKMXKFKnqC9gZLYEPNyd/Xk8IohqT6xZEUc1eZ55K/qtBGdcU7dCYJMYE44U7cAdJfXj3QGcTRo6Ktglt8eUeJPQrV2JeNIfAidwkZYRvyAaMbmxAQjW9KD9d5NrFIVz79S4xdiDVjWPDjAjSOl/eEeIs0N4onAHZF4sVodOp9MlMWVNs6XmpuMVEWKITtapZ59OGVakdVhZhJ7dmF7W4kqliIrW47tDQPDaKx4Lp3FuzvJJTpAMeDAZL95ls3M4Rjho1JyhpyEfS0JqfHBZHHJIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(5023799004)(10067099003)(6133799003)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?abg30f0sP90BumfZ/0LQG7q84ObXTX3aHp0vp3L79OXZp2y5Rd1XY07uIVPB?=
 =?us-ascii?Q?pMJW3yxxqiANpxdLeTZ/KLam/dRia4hBy3JxnVAc9N7LZGUf6/Rwwu5gzSFX?=
 =?us-ascii?Q?YsEVw2inkuKOLozMX85tjTFGVkeHYbC/EgMQzgMXS7stO+u2V6UPmo/gGoMa?=
 =?us-ascii?Q?6w5Jx64Swh0iDRra3yJz5Y8ltpPuHTeplu/5VSdvPtAknutqGShVTcL/++z3?=
 =?us-ascii?Q?8yiK2L7mx1y/FxYZn36R0ZXvCSDmrZZrdWjhgzr1T+/EChWRR9SKWkRsDbAR?=
 =?us-ascii?Q?WME8ZB3Ola+6pns717sjnxTWD1vJTr5hVPI5hCk1Ng2gVVDK+R+iKwFUMJrQ?=
 =?us-ascii?Q?MHe8J6AJgRsx8Xj3yBIve1NHteTiLwq5dfgiwH9uvpfk3P+6BxsIp9/vydnD?=
 =?us-ascii?Q?Z8UFBR9jKTw2x2H6K5Q+S2EVqJx3XDPTkeuWiFbappbBXnZzaeEkhHCeD50+?=
 =?us-ascii?Q?kTQUWnjdn0Skw/u7kt/ji8TZKu3+4uOUXR4mYpdYzvak3EoQdNVlwmrfaa/r?=
 =?us-ascii?Q?Y0LHgDvFcHT0ieIRqEhrdWR/a3shFjemRQUXbJbz0/Nn6Aw6alWTXY2mYkzt?=
 =?us-ascii?Q?lcLnlkOkuy3BGjSk3AfnAjSdoWNafYNxGFxKR6JH3rfZfSy6FGOGDR//Qc13?=
 =?us-ascii?Q?XqSHDZy8T+XOOjkwjK7B1bzJPksfznA8TYEmua1UsD5SmalMt+W+UVnRl2Rl?=
 =?us-ascii?Q?GGxuXk7EgR6TnRFM/b8b7ll7IirkcG2g+7YBszy1gCSwnbg+snmM3vrFDOLH?=
 =?us-ascii?Q?9O92acu9D01/Hc2kRUQpoK+0fQVWtT+GdZiFOfScsVXvFuIlGOmfY+AiQcOk?=
 =?us-ascii?Q?bHqIpLGM2cL6DB94WbItLy00AATqtWkb44yc14xBxvq2AQ9oUnTaywnHEgLz?=
 =?us-ascii?Q?bEL2DkQwAk9pGcxaPluAb4//rMjwAip+6bn9WWuxKJNVcnogLel1EN5J88+L?=
 =?us-ascii?Q?A1wRoRfB9lO9aQg8y0vab7cjPhc6kFMHlnGYe8401Pkr5HkBQjJRYR0b3ehx?=
 =?us-ascii?Q?zozJ6/7LXYGho1Y0Ptcg3kSXsXz3xq72wJigswxINXPuY5u7sUZKrfte6EfJ?=
 =?us-ascii?Q?zUToh6vFoITtitKl437VwoiuS29+l+vSo7QRPsZP64nJnNwJ/S6MWFtmqCUe?=
 =?us-ascii?Q?Kb95W+QF21zgPcKIp8Twlg3lEibZZ/AEX1xnetSYWpC2wa3nYZYhb6EZjeyh?=
 =?us-ascii?Q?jipDrFXjsltv5WkHHuMftLgsUjNzcsjl6b58hu+vybe6aj57wpg2l+k7RpzN?=
 =?us-ascii?Q?apyJjdLG/KA8iHiG0Mfzvh/0CMXBY77i8238pibBylXQ3pGOQHsVTkxkq/wS?=
 =?us-ascii?Q?d90AXd4Op0S/bN07yKMc9nw9p/evzxdOp5neqDVYaKdRNHR4g79Yhf5QiqI3?=
 =?us-ascii?Q?OK1t3mAmpzmtJFB9ZyaDAHCEZDQ4FHzaYe9lL3QAK2eVxbg4KCHjfowZ0QuI?=
 =?us-ascii?Q?KVn405M7Php69m1bZh4Z9T3dS2C9w9VfT40Dg9RaPauftl6HzzFYhlyuSig3?=
 =?us-ascii?Q?GKlP7mmhIqB8cKeNoY7yDlpBsBjsAWBluN7Nn/UaJFZlcKcdmh6DWnXziwC7?=
 =?us-ascii?Q?C1g680YUi5nJhXCqbrNCj2nKQ/QiqNPvFb+a+U1VhkKnAcKXZocy5CgnecDO?=
 =?us-ascii?Q?WKV2HoF0Zm0X1eM+nuTWi3jhKMPTfJo/rX4/G/rN5zLN4BgbBg/Lqwu4pHk7?=
 =?us-ascii?Q?MW2TDRV0QxOC0zsLG1IU++wbGHGITSZc3RcXZYJ5m24OPEz6VDphWeVS2fkW?=
 =?us-ascii?Q?/VYbnu49nA=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZE7nMDTg3gBH9QXmEQa4U51QklcS+cWt1uBen66MLE+FWVQeQnEkQUsNCwz8zEyjwR+a2nh7km1soI9wWSYlZlFnhHw6KipAsXdM8FAZ8kEDtkYT2qI9QUKWdeRiKvNynBUw5pmA/q2wN7BjqnOVM6nIv/3dGk201WHefFf5SuL4mjsShiy8eoqO9VkFhqLa6kbO3wRDKQgGMPy4je33VAKnpQEsEuo/Oty1/qgYwGoFgQmzulNW4aYZYWD4C83h8JtoW82fNTJLd/KQ3o2N7eEdQODqcqEU/8MlWgMYIOh4MqVAvs6r58Nidwb9vI5KKvbLS8Abm8Yfhuws1bnqEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 22662c2a-e741-4ad1-ad8a-08df192e794a
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 04:52:30.5438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lx9OCVtVGjRArh9le9NHShWwXaRMpB8h8esdjfnBSFX2wwtqM6G9SUecyIMH/CtaPjhsEuXElz7FReTZHGCJzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7742
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 06:47:05AM -0700, Sean Christopherson wrote:
> On Tue, Sep 22, 2026, Yan Zhao wrote:
> > On Mon, Sep 21, 2026 at 05:13:32PM -0700, Sean Christopherson wrote:
> > > Drop the superfluous WRITE_ONCE() when setting a memslot's guest_memfd file
> > > during initial binding, as the memslot *must* be inactive and unreachable.
> > > The superfluous WRITE_ONCE() was added by commit 67b43038ce14 ("KVM:
> > > guest_memfd: Remove RCU-protected attribute from slot->gmem.file") to
> > > maintain rough "parity" with the existing rcu_assign_pointer(), not
> > > realizing that the only reason rcu_assign_pointer() was used was to make
> > > sparse and other checkers happy.
> > > 
> > > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > > Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> > > Reviewed-by: Ackerley Tng <ackerleytng@google.com>
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  virt/kvm/guest_memfd.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > > index 80932f4ec4a3..826d26036926 100644
> > > --- a/virt/kvm/guest_memfd.c
> > > +++ b/virt/kvm/guest_memfd.c
> > > @@ -677,7 +677,7 @@ int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot
> > >  	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
> > >  	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
> > >  	 */
> > > -	WRITE_ONCE(slot->gmem.file, file);
> > > +	slot->gmem.file = file;
> > >  	slot->gmem.pgoff = offset >> PAGE_SHIFT;
> > >  	if (kvm_gmem_supports_mmap(inode))
> > >  		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
> > > 
> > Thanks for the fix.
> > Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
> > 
> > BTW: some questions regarding read/write to slot->gmem.file:
> > 
> > The WRITE_ONCE() in kvm_gmem_unbind() and kvm_gmem_release() are also invoked
> > when the memslot is inactive and unreachable -- are they also superfluous?
> 
> The WRITE_ONCE() in release() is necessary, because the file could be freed/released
> while it is still attached to a memslot.
Ah, release() can occur on an active memslot, so WRITE_ONCE() is needed to 
ensure the READ_ONCE() in get_file_active() works correctly.

> I _think_ the one in unbind() is now superfluous after 0ee2c883b62d ("KVM:
> guest_memfd: take the invalidate lock when unbinding a dying file"), but that one
> needs more analysis.
Hmm, the line "CLASS(gmem_get_file, file)(slot)" in kvm_gmem_get_pfn() is not
protected by the invalidate lock.
It should be superfluous even before commit 0ee2c883b62d, since "the caller is
responsible for ensuring the slot is unreachable before unbinding" ?

> > Do we need the READ_ONCE() in __kvm_gmem_get_pfn(), considering that other slot
> > fields (e.g., slot->gmem.pgoff) are read without READ_ONCE()?
> 
> Yes, it's needed, because of the aforementioned release().  The other slot fields
> are only ever modified when the slot is inactive, i.e. unreachable.  That's why
> I think the unbind() WRITE_ONCE() is unnecessary; KVM should only unbind when the
> slot is inactive.
Maybe the READ_ONCE() in __kvm_gmem_get_pfn() is not necessary?
When __kvm_gmem_get_pfn() is invoked, a file refcount must have been taken, so a
concurent release() is not possible.

