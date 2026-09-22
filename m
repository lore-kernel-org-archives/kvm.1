Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1BA388E69;
	Tue, 22 Sep 2026 03:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048880; cv=fail; b=eGyGOoB/YVZYeq+Gk6teboIcXoVn4qDrqnl/Z57IHKpq4uPGyXKGtlFrSHet9N4jNhICMTh0ZKqUwrKFGVxT6pUPpRBYQqHp23QF052bpkfn95twCorDasLWSIupKvKWASauZDUaoQQk79Y6p6NJKGKD2hjQ69hHCag8Ni92Rdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048880; c=relaxed/simple;
	bh=VLMvjKnehfNvGFQjDWCiruVpQbvDAM5KxJWBgKDRX6o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cXeSE6zRvVzFwgpK19BYhfvHCpkVBnUqud13/X2LFkghWDNK9X6s3eLhlB1SHqgvglg3apIZZ6vRLib/j217VPeZDLR5Gb1zNuDX2UEHsFJm4rB2TcaEF6mhQFHwsg2LCexp2xwiZk+f4IwPsp2KCsPKsIXTeBejf17Ji8WCxw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DORK2/xb; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DORK2/xb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790048878; x=1821584878;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=VLMvjKnehfNvGFQjDWCiruVpQbvDAM5KxJWBgKDRX6o=;
  b=DORK2/xbC7sMCZfCAXVMz+qXKc7a81WHx5m9b58dlrXwI7ilvg5NxyW5
   bk2lmsjYy0iZ4Hm67R9fvgqynnyZydTY6wqcgk080x9MTrfrAtPImbg9B
   PtsZlWstepL1ORYWetg98oAlg3KJDStyDXXbIMmH/X7AFBPJRIBctUCvN
   ORph2p34/QL6JveGvT5CXdsGAGJeI9xWyRiEoUygXTATBra3x+Mh1xLTP
   m6QTqVKLmwXZWmTRBerM8CzaTPJwHGyvyMpmPioEb+bn0Hxkgyi8JMGad
   kMQnsL381lBvXDrjc3+SPUv0r+5Ys4n/yzdlxDeRcy8qitGQjxziUpnq5
   g==;
X-CSE-ConnectionGUID: bJxaEIvcSriIwq+N94WfyA==
X-CSE-MsgGUID: OGFlpBLYTIqtgNUtRixKzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="116139410"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="116139410"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 20:47:57 -0700
X-CSE-ConnectionGUID: RHuBcHXkTuW+qeN1+fy70A==
X-CSE-MsgGUID: yjfx7W7eSU+yurP/3kppQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="269474501"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 20:47:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 20:47:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 20:47:56 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 20:47:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FflxAIydNLo1jR1QPdVgOcU7bUY/JPd/RPdX3lSSMe6l3//5QM21TiMG7ppKIk0k42JjaM2+s3rzxQBDlGnoRuS3M5hv12UQrxhpsGIleLe48gQgHMfblKsl9I44Rpa4kcVf/S48qMKqhe9AwlVLJtijt+F3BMjMWN/11iGs/dxSMUvudyJX3d+8Rgx9K0LXieq9NIXiN2t7xVlx6+ZVHA0IR3T6BsTsYAqJMc3mQ7okIsHlwE+CRAxlC34alStn5ysFxEvASvOswIiBpf0lXiQVNmWpCE647Au3EZRzpJDs5zNTzJayXZhesZRYRrsOHNBN7iBFS5PkWoepFtZsvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6TeuNNjew+YrzprIGpz+hlfoertxDugSKZcrLK1oyg=;
 b=vsYP+qBijSmrISnb80UboFs3BtpK5ZvG9yRCUx3TSrdRo121/fke09bksl7nfsLGNzN3WnQVdW2VK9j59smDuXQyrn0SLQpIUbo/SZaP9nENyWj/N8bwCNcXujhxudU6jAKuwRpahWCmXjIDbU/IjfKE7RA1EURdO+X8kMLS/ag1h0YVkyy5KXoXJU26fG1hidcrpfdPv0F4VwO/10VlLaJYpb1alypONwTYBznowJvMQlC2ngtpl4K0KK9EcRTDoTJwOjLaCYuaS7jNOMM/3K1GFZH3x8Ylkr+I25DpeLclWWxK+2kgNxWjaCqCaC7btTyMPdNteVy0Y8FyQc+PDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by DS7PR11MB8782.namprd11.prod.outlook.com (2603:10b6:8:253::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 03:47:45 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 03:47:45 +0000
Date: Tue, 22 Sep 2026 11:47:10 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vishal Annapurve
	<vannapurve@google.com>
Subject: Re: [PATCH v2] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
Message-ID: <arH6Poitg29eapcM@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260826165647.769231-1-seanjc@google.com>
 <aq/XwK71uNfLvUux@yzhao56-desk.sh.intel.com>
 <arEzv8b2IMHYcHsZ@google.com>
 <arE0mEJaW44HA39e@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <arE0mEJaW44HA39e@google.com>
X-ClientProxiedBy: TYWPR01CA0036.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::23) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|DS7PR11MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f558aef-648b-4d6a-ef8d-08df185c436b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: BRAPqupvO1e+XaF03Lyw7JpH4rEIEmsANo0ZFex+DjDuVNoVLeKK04DOOss594BMvoH+UDX78TLhlfbhBJrHyhOcI/zb1A6IXyuA8tW2wQT35TuJIY5bnuGyuHMHXG01dmKWWEacF8uZDmKcmvSyOJu6TbyFsk/PZTuLGVwSf0WtxpVjHt/qND0F5G+AyFZrKdp0jZe9O7iARVigqBFvCUHwWRVfWLG8mMjEhm637RBrt5QoGIGrLKoJICnr527KsSt1at8we9LfqXuMlHDrcgJEqV/TH19T572ZGnXH2de6S+Z3o5pRMkNI+/EOV8qYGky12HH5ghTpB4EBYDIXWBJbq4gpztFxJIVLeJQdrgkp38JBVczH/TyoFx51UbOP7WayWvD0ISKR1hi7cAu1XFMuYm62jJt/QPsDwEIa0kY2hjyqYVw9EFXXeNqvW8WFe112N+n/ObH/cPNU/dvjWi3phMdWxpTaKwbLEcQGoHaYnYY2P9NPLqaWXTXEvqfzA3S8DaGMuCNpgwcbn/AGLSmhnyf+4g9X0G0hSmpBc2XNom4x8bvTNbSX/cgUcMcBdeYK8Ob/opXrSBSgztiXrhAcQVCduN4kk6V8ZCKbCNGh812gjs5fpsV4L4bOm0Iu1QBbEvK5swyoKa+M2VTt1TRKwnMek0NuvJWzenxDsAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0RYCLDMAsykPjmU2p+B+65tiNC7RAN8aJptyR+RJYdPiFyIqVBw5STklkvrl?=
 =?us-ascii?Q?grc/4jnT6GNbE7j3yPeDrGaPSRDo3Yfo3zht+ZjeI9XOcyXn0U+EwwmxHRwZ?=
 =?us-ascii?Q?ZHTRMUfTLLzn71OkQsozGNxLdzumX4gc3CQqil4Z/G+VRIssjwKLVnNNnu1R?=
 =?us-ascii?Q?7DHszrVDIOShuio1pORft0JUeS0lrVxtdlIcTcBDCZI2mNStx2gWhSa3BNVb?=
 =?us-ascii?Q?W0YmFW4f6HS1J4yaGxAMYlsBVfxuRxHIZ19DRVsAGLTKJQKO1Dwj6dqrPE+c?=
 =?us-ascii?Q?kjuilgCoiZ3QsV7YcrHGecbE999F8EQTefbDcKM7nXHS4iewsWGKB0xUp1pe?=
 =?us-ascii?Q?GahexuIaoZF1dUsx6nQgTswpxlLtvYlCc0w9XMf1ndNVEL16D7dxfC/PJXHZ?=
 =?us-ascii?Q?U2t5JvwYtklrLuqqdmCzs9p0ZRs8F5ssooWKbPEXAdIqGPs6pvBbhqZNmbBu?=
 =?us-ascii?Q?dIbIIaDRVavouiC9g6/HPtiShnc+50XN1ZXtZyxDK8MV3CKXw10sTAGWM+HC?=
 =?us-ascii?Q?as5ot8cE86KekPiw8CK6HOpDPd0jSPspIN5+SgY2GwTU7CMOjqs6fksxvxG3?=
 =?us-ascii?Q?TUm7Jo+MPAmSze0oq8lZ48cKvGFTuXjq4OSAGhtQPmP+URLlP8W0ntIwcrVu?=
 =?us-ascii?Q?IG7+PRc800hvcVY5v71XL9asvrEfVKVrgXTzi6rmUjsdU76wimxHnGpP7p4O?=
 =?us-ascii?Q?w9jujU8YPksydSJN73Js9fWK58KEVgNo8rv87JnoG5S3V2NUdH6XPtAbH6il?=
 =?us-ascii?Q?TifiHMAtNYa5Dbq/azFEIKprg5HuAqhYnhLKdnOiDB0It87snA+v0FaaseqE?=
 =?us-ascii?Q?utahnLAl9ehUkmyfL5oODx67M+y+xMo2QJ8UWuyNUxiu/ePGgdeh0U5MH2ei?=
 =?us-ascii?Q?OsPzcd/WVfapQt3cBmTTuTzHMjq8w7jjLGJ8tUFxVPsjPrMCT+rzoJkNwSy6?=
 =?us-ascii?Q?ZSEE7q/89KwlYU9eeYJn5frbOK7fIWq7mcWzcY7OK0hK62+fsZvA0uJQCgYr?=
 =?us-ascii?Q?nm6y7Mi6wEOE5csPCxieQVpeMIMQAqxtpIVtfiyPP12/QGeG0RnQExZC7uS5?=
 =?us-ascii?Q?LUCcc4YBFNTvmlmY22Jhb2mckmGLr7AZ3A/elQToOympSM6iwsxZta6l3JWt?=
 =?us-ascii?Q?6JaGK2jCNpyuOOsM2WVJlAgKj8HQZ6/tmxjMRT9Nz5ejSosC4uay8Nf9bwEg?=
 =?us-ascii?Q?TWHOxxhifb4uAW+dZZFHcGjdmLXK5ZeHu6XaE2XFiI67Y2u6WfSHr+xSVK0p?=
 =?us-ascii?Q?kzqTg1b4NG4RukxnCsCzl/I95zco9Ge8NnHvgCxWh3MAYMjLk1Gg4ACdaLZe?=
 =?us-ascii?Q?pgHJSJHdBGhPCqLTRBLbc5oZ5B81FHb0DpEr6rP705szJ/PLalhQ6VZOZoCg?=
 =?us-ascii?Q?VAV9nxEDFR5vzOiPF9nCAcwp/Lpuh97MTvDr99AQwhSLv/fSjUP30COLXULG?=
 =?us-ascii?Q?daLBhfhmTPnWrXoS+po5bp3zc/QzLFInvRQ7Rtl3li+UTNHg+yleb5KOdn7R?=
 =?us-ascii?Q?dNCMNTOYyJWSJGGXcPtVc8/0OQGN5X0ACIXfKk6qmJGkPlN9CtIN8SqXdPg7?=
 =?us-ascii?Q?LdhUB6qspdmyNc8sjRCS2m4mcKTJe5z1suyhdyCsyaD4koRtyfkK37LFd5qP?=
 =?us-ascii?Q?aouZrn7EnAWSqd7Uo52B/0nkHp6TPMF+VdbZ3lWPFuIZeGPhU7UpmKHc331f?=
 =?us-ascii?Q?bjjamdk0n3cG897ujzT+Npieb24tgB9nUFE0YGIe2CkMU0H7ri49J5mBnAy0?=
 =?us-ascii?Q?oRDT2WivTg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 3rL7p/8NADhH2eBYSMK6nFcnPtUsUF/9HP6mDRAzp37I145M+wH8yMvR+6o8Uc3cMV0HQFy1vGEH4u94XVv4kxcuqeG4UW0BvHHwQhJXhceP4RrHEq9coyZ/j0dlW29icUJKyYASuIb2mTWHm+iPBuQx1L1m7h5tmD+rc3EnfE0OzPprISeBJp3yn/Y5Cxs0Ia+0HPk/qmsRCQXGbkvZBgMKAF5Z35utga05OEWFBOWFyQKoVZrF6nsrvLWwAu50Qe158g0jqj+0Ex93bbsRe5i1RHX2u09J6XS+CjdW0QyjpFJs+TX4WVx86LuALmpdRFSZCKRWKmOjnqkRThvjTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f558aef-648b-4d6a-ef8d-08df185c436b
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 03:47:45.7961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bL00IVDo75m64qiuDo4ZkWv0aJ0NhVNuLGb0cgY78jyPNwHC4xPlooKFiUev5DAESkP/hEkZki/u4h+DAA6t7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8782
X-OriginatorOrg: intel.com

On Mon, Sep 21, 2026 at 06:43:52AM -0700, Sean Christopherson wrote:
> On Mon, Sep 21, 2026, Sean Christopherson wrote:
> > On Sun, Sep 20, 2026, Yan Zhao wrote:
> > > On Wed, Aug 26, 2026 at 09:56:47AM -0700, Sean Christopherson wrote:
> > > Do we need to update the code comment in __kvm_gmem_unbind() from
> > > 	/*
> > > 	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
> > > 	 * cannot see this memslot.
> > > 	 */
> > > to
> > > 	/*
> > > 	 * synchronize_srcu_expedited() in kvm_swap_active_memslots() ensured
> > > 	 * that kvm_gmem_get_pfn() cannot see this memslot.
> > > 	 */
> > > 
> > > to align with the above comment.
> > 
> > How about this?  Because the "rule" is that kvm_gmem_unbind() can only be called
> > on a memslot that is unreachable, either by synchronizing SRCU after uninstalling
> > the memslot *or* because the memslot was never installed.  Simply stating that
> > synchronize_srcu_expedited() makes everything safe isn't the whole story, as it's
> > specifically synchronzing after removing/deleting/deactivating the slot that
> > makes this safe.
> > 
> > 	/*
> > 	 * Note, the caller is responsible for ensuring the slot is unreachable
> > 	 * before unbinding, e.g. by synchronizing SRCU after deleting the slot.
> > 	 */
> 
> Hmm, though it's probably a good idea to preserve the connection to kvm_gmem_get_pfn():
> 
> 	/*
> 	 * Note, the caller is responsible for ensuring the slot is unreachable
> 	 * before unbinding, e.g. by synchronizing SRCU after deleting the slot,
> 	 * to guarantee kvm_gmem_get_pfn() can't see the slot+file.
> 	 */
LGTM.
