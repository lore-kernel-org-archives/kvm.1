Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC123624D3;
	Fri,  5 Jun 2026 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651978; cv=fail; b=mwFpyHHdUmMz/KUtMez8OyOPg7ycdDq9fO/GPwr1915+R1OY350c090BrhA3MCuzjMResPgJGPJW6FaZd2Gx50Isr203mt7R2sIKNSlujO/5crJVY0YkKB9dWXH73yJlaj98PfkmCizusrzJxGg/Ff734ftLvhUJDfI6yGtm/W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651978; c=relaxed/simple;
	bh=KVlSptqIUtNG1PY/ZPhw5rV3ZMifdQsyHF4NbT42sCQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qieCayIs59QCHbld1M4dF7Ut8Lciw9hjnTxj8zuLFfdCJFn0wQTiIzhL2jPvynPtKAYOfHY+gf9y0B6kTOZ3IBXlShzCAMdqq4Y/Y2mjRmn9neM/dMRhOnbLn64ZWmH9VjWhyyuiDOagElWM0YJEnJBaDR5CLvMy9pBt0rgQT4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THVgdsTx; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THVgdsTx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780651977; x=1812187977;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=KVlSptqIUtNG1PY/ZPhw5rV3ZMifdQsyHF4NbT42sCQ=;
  b=THVgdsTxpFACBLCmxtiHU2NuF6W+iyyIB/AGohqMmPHQfCoVIQ3fG3vG
   86w7YtC1usyZPRmByzHqRsgEb9NUqEqNO+06JfaKe9sE6YGoQ6oz0aJkP
   a5o1az3aC/09JvOcyoD2qvS27RhB6W61GHvCFNS+3mpfLLhJMxa5Bnpxa
   URWrZ9wnBVSLA4JOJZZs1dHVJ+N0KNCIT1E5+TohAnEcU60UhxmHmsZzM
   jqBoz0506MOGdUUPrX6+WvW/i++ZUWS82J7Gg4QsrP8z4Zqm61xq8jgMa
   n50zbWgh36Tij29g0o5FJGaP1pwS9RRhSq3CSiSF2Vm9I9seZVbPh8PAN
   A==;
X-CSE-ConnectionGUID: A823wfbVRPqN2GJQoNpQkQ==
X-CSE-MsgGUID: JNVoCMnQTCOGdSwSb77WFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81545288"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81545288"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 02:32:56 -0700
X-CSE-ConnectionGUID: oPKFSplVQ0a1PPwVbaEUYA==
X-CSE-MsgGUID: +ogpHF1HQMSN9w9Hi3Mq2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="275037817"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 02:32:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 02:32:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 02:32:55 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 02:32:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPs6lh9T/p7ylfF1Y6H4UQc5swVZAs4Cf2t2qQAuwinoi3qVd4IFHOIvTliz6STvgQOQWp4xzVMa6eZStau72MfXszkkzD0EvmdRBHKFpCo7X6/4SDykLFHdl0efUnHAS3nzWfsikkaebq81QmW5nTMLUv0FcBWC3Md1cJ64RTzGkRNBSjOVBQz4Kmrw8s5TdugdRHeJbLb8O5ht+Z8eO6jZnzklMOBUgmh/koXHsTtIOGSeJ9abV75cRgguZ3kboEf6+KyLqnnANg+1/bqzMSBEetJ4vQdHuO9YFvV0OzYNEW31GrzDu+uZaDQwDNHsCJ+AHpuwbfbwj3iva8DiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSoqkNdkOnRl68wP9lNU3/ifeDa+SJiYZzSnwqfn3qY=;
 b=hn08RQRDkmttT0427oYq1Itkn0EJwNGLfr9Svxsnhpu6kc8JDSPpvp22uCMV/Rguwde4JE9YxzzXjXVAJT7x9Bbi1ZAbtj9A/pkShdptv3VokPDUTiM7eiGC100+Br0dg+I4yKu7VuWGz/z6eFT4ofQ8C4jzmnLJToNfxkTz/zu4yR0+ags0N798CGUhy2ryPB+oJhrvcXiYxN7H/yebtBPvqXnCom9fcg+KntZ4jck/wrgmCU1izNhkaq4aekZrh5q3l44RRjNOfbydd1W3Pm/qBCi2FnGGHbDehIUnIIbO9hq8fEdvSaKVujLVqB42lIhuC6znpn4IOPk1+YZi2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SA0PR11MB4592.namprd11.prod.outlook.com (2603:10b6:806:98::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Fri, 5 Jun 2026
 09:32:51 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0071.014; Fri, 5 Jun 2026
 09:32:50 +0000
Date: Fri, 5 Jun 2026 16:52:36 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <vannapurve@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
Message-ID: <aiKOVKr6u2hbpic9@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <aRsIstNXu0Bl0oID@yzhao56-desk.sh.intel.com>
 <CAEvNRgH6YGzp4OHF7hMQEtVodAe1pVg1F9UZWwLiu19-KNgJVQ@mail.gmail.com>
 <aiATMXdOtg1T8o4D@yzhao56-desk.sh.intel.com>
 <CAEvNRgE8YG3L-SVJJmwkU8R37S-FoQrW_tdsEWhwZO+AJ0OUAQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEvNRgE8YG3L-SVJJmwkU8R37S-FoQrW_tdsEWhwZO+AJ0OUAQ@mail.gmail.com>
X-ClientProxiedBy: KU1PR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:802:18::19) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SA0PR11MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2fb42d-2b4b-4b28-c445-08dec2e56986
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|6133799003|18002099003|22082099003|11063799006|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: JejlasMPrvwL0Z5kOdiF4kEHi/rUY7ya9OLdIwJUuR3+rfs5VTzVvH9dwj5RduoSGJO7a3m02G+895+ypezcln2QzYurSA5SyBYr1p1owc/uqknBKTCnDqKFXfpH/QAY9JfKFdOZmRrjXG1pexI+G4OCk5NkLsXthj0K27E7Ln1ZI09t7zf+TRVv6+2vBs9YU/3IsN/7/+zVCFy41vFf3ciey8kO13qez4WJDXK6vs+NXfeowzuTMydosij/oAvIr6vDWpXU4A8kju33nzcgrnGKVhFjIYauTjvw+coJ6zIhF/DMK5gLAftXi8SyTGaj7NpJASNJGAvk9YYjeg5A9Axh9wrRKuuOs1d5+Qf2Xx1asero/gF2dfhLUuJNJPGI/3LddzXqNux9MwIHYS/dgPlSz7vbu1EXOybxroth996KYWX3/SnzXZaf1zID1e0owXg4jmNeEKTJmUn3hRZQGHOYnzyQlF3e2xX+WaB8wK9U6uhGsS4hhG+7Xo/+J9hbrf+bKwj3tU0eeBq9tFLhmGQTPTDgCYrraKge4rFZJG14wix8On1vQo/SuaFfbJRxbUAIvfM7Ia9qQ4IvuTiHo1MbTFZ3SQTU1imc2lDF1XMv0spIeL80sW59eBlZyJwW6kh4+Rud9CDPYfleBRjg8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oiwKT7ScsLEse9erbfhDc0FMI3m9Hu0fowYpfodGlRubJW9AHzf0Q4Z7M9AF?=
 =?us-ascii?Q?vA3TTTX2Q7Jar84swwKWJ+nhRL9HBKdIlWvNDzstWtrzVLrH1KRgvkp9FihX?=
 =?us-ascii?Q?9BBSbRCTRPvG5JQhZLYecgK1A51tYoMT22ILPLvI4MQ4LqtqXL/jIK+/W2R3?=
 =?us-ascii?Q?vrfu4anbaymZRWplJjEQlmjxbFiFy7sQHyS1isgG8wYTgbvqW5/z/YnJtl/Z?=
 =?us-ascii?Q?7+ojJ7BHntSajltJaDFIMLs6ScfnrRhXzkLUMFQukGaWZWRd2/miclGvuuMt?=
 =?us-ascii?Q?ZgfPVhRNSKBh1w/jJtvz9Cw54QFZdb1QyNTQZEzmdq9vTssvxxZ/DMEdGjyh?=
 =?us-ascii?Q?gflpWtlUrWI0sbxiHwGmEoIsGgJN4CgVueGCiRweW8JKpzCTsGZHCqHAaj85?=
 =?us-ascii?Q?KvRHPIgciCk4We4+FGfl1EBfPFdbRZw89BYxD3uWFnbH/fGL47L7iFqpWLrC?=
 =?us-ascii?Q?DJ5OpMRVMmwPCERFT7Q7dHEuLCSKZ8RpW8sW3IBZClSKIRwaG/CpM+FlsZFI?=
 =?us-ascii?Q?njgSJK5/a7M6d68OHppdfCtMU8naZ0eZ9FeODdM0S3BAJuHX4gJ6NwgfnBGZ?=
 =?us-ascii?Q?BTzbhh8g4r1rCB3DsS7a9y8vXXM+/3RVHNQG0BLbHfF+Fn6W4uKF+cFzpOQ8?=
 =?us-ascii?Q?yS3zhrCLDjskAnE+X4SR2wuR1FX1IsKsh4b3GooYdeRUkkxvFtuPxq3nAFo7?=
 =?us-ascii?Q?nZ2GThUYHYten2YgZn4c0a1Imvu5sX/U7kWXMoThAicP/jvQOm/c2vj80T6b?=
 =?us-ascii?Q?A/iwAi5iAJz0rZoFfaZCrwt+Vn7FDc3ZilTFPATK9PCqbOMPSoq1E8KIkB0R?=
 =?us-ascii?Q?Mj43bPACC3CFaLRVeuVdoo4X6BtN6wCxlTuaS2ZxP5GfacmK4Zn1uOyfQu4b?=
 =?us-ascii?Q?+JdXp79hMnFRsmWrxPdJFMjnenIymGZgg/Rpyl2xx7mrB17lf3hAb5syggVo?=
 =?us-ascii?Q?yjg8bp9sASbhXed1h94pReDxPT6RnLPNOqdq3kygDfz8ltp1FBLP4bDQKO9e?=
 =?us-ascii?Q?Bp1NYGS8LJHCN0r40aN0azaQ4T4YJBHmAxgKTLeC3pGVtXsPAOuoYZpnn2xd?=
 =?us-ascii?Q?3sR6X7ER6HKyQabqQnIgLSvrD1VgufXhZtrjaqRgssvwGnQqh3uOUkpNGk7u?=
 =?us-ascii?Q?yXFgYE2Vbh8vBtu1jU7M3pIrGOy2rlvMqDZek/EN74sb3JCVpxmx8uXEJGFA?=
 =?us-ascii?Q?kvxkjv20vGMs+WhG0Fhy7xRhdhhG6ScieB7EoOCosjGPfJKnQm7sYFzy1bpv?=
 =?us-ascii?Q?oxgdb3AtagYi/9ft/8P4TTTgFq+2pBn5MyqnovLwrUbBU11oAn5bqzXHddme?=
 =?us-ascii?Q?5kMo7JsuljHnMIwsh39qP8YuyEekn+K/C5qHVmOO+OjFLFZIorWZf7fj3Jom?=
 =?us-ascii?Q?zdQjM6I4SOP6TqFGQUhxH+JZU5Z0g2N3opdAJf/v4pY4I9lHpYec/oVyLWpr?=
 =?us-ascii?Q?eFXRtRDlv+T4btj4X6LxGGJAy6KQ8htbrntnsqrHhi7KhgVwwZu7P/rtu6qE?=
 =?us-ascii?Q?sQqP6FxpzRhsXacRBcsq9NSlLpAXUZajRyyK72/ySEYduoir3W14yQwzg/2E?=
 =?us-ascii?Q?RO1iTeTgax7Uue3ej1M5xHNkruBnt0djPUFV+6v/t9tCkU3yuiaAKPzbqrdY?=
 =?us-ascii?Q?tHJ9J4IlJ5znQsGLjCXEHi09O6wEhh+lG0Yh5vFNWBebM7mvUm4PuEU0Ml1L?=
 =?us-ascii?Q?aND1PLvD35u+dRdARXoYV9Aw5qjOYL1JBO59s91P8doGeVRzqcNwLZO4hA6/?=
 =?us-ascii?Q?cJWyEQf8KA=3D=3D?=
X-Exchange-RoutingPolicyChecked: dhQBLB4PJtgdxg/mbxPxJGfNQ3pxUzLIcVPXUeW5zaF3goOV00Cy0hPRlB5/RebimskM0Qv6gXYQp/9xqbWjUpJMagCoJ9+663IpILGNyvOtqMW3n5GehHVc47KaFhq3CT1ktyuvE/lGEahfkXByNCFE6JDTrIVN4AMcJ/A3kS2QUE8bC4t2h5OeSwzJKd4VZ31KVGJ0Flbx3UuMwSWmmozlyij4wpcpolW9SYbU9PH9IzagBlgWfs2SeIqmY12P0FvgGOJ54Lk5CHeVagnN7yej6VXBG3EzskbUJoq/sY1qCZG2ko/Oou6y9fwbwjQLU3mpiC7NSlM4OxwjzuZCpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2fb42d-2b4b-4b28-c445-08dec2e56986
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:32:50.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cCnV1WpQK5TzCFROa3WoZqLG0IKlxnFnJuv6JHZFgZVo+H69K+xQZkWuF2zhVacUOYVOLKKhrxkveQsiRSyyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4592
X-OriginatorOrg: intel.com

On Wed, Jun 03, 2026 at 08:11:26AM -0700, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> > On Tue, Jun 02, 2026 at 05:40:00PM -0700, Ackerley Tng wrote:
> >> Yan Zhao <yan.y.zhao@intel.com> writes:
> >>
> >> Coming here from https://lore.kernel.org/all/ahn6qysOGfa74A2E@google.com/.
> >>
> >> > On Thu, Nov 13, 2025 at 03:22:29PM -0800, Sean Christopherson wrote:
> >> >> Add more context and information to the comment in kvm_gmem_release() that
> >> >> explains why there's no synchronization on RCU _or_ kvm->srcu.  Point (b)
> >> >> from commit 67b43038ce14 ("KVM: guest_memfd: Remove RCU-protected attribute
> >> >> from slot->gmem.file")
> >> >>
> >> >>       b) kvm->srcu ensures that kvm_gmem_unbind() and freeing of a memslot
> >> >>          occur after the memslot is no longer visible to kvm_gmem_get_pfn().
> >> >>
> >> >> is especially difficult to fully grok, particularly in light of commit
> >> >> ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when
> >> >> gmem is dying"), which addressed a race between unbind() and release().
> >> > As mentioned in commit ae431059e75d ("KVM: guest_memfd: Remove bindings on
> >> > memslot deletion when gmem is dying"), unbind() and release() are mutually
> >> > exclusive, i.e., both protected by slots_lock, mentioning "race" here is
> >> > confusing. So, that commit addressed the mishandling in unbind() after
> >> > kvm_gmem_get_file() returning NULL?
> >> >
> >>
> >> I agree that the use of the word "race" here is odd since both unbind
> >> and release() are mutually exclusive and protected by slots_lock.
> >>
> >> Looking at ae431059e75d again, there are really 3 changes:
> >>
> >> 1. Refactoring out __kvm_gmem_unbind(), which is mostly about setting
> >>    bindings in the xarray to NULL and setting slot->gmem.file to NULL,
> >> 2. Checking that if slot->gmem.file is NULL, skip unbinding
> >> 3. Checking that if kvm_gmem_get_file() returns NULL, just unbind
> >>    without taking filemap_invalidate_lock().
> >>
> >> (2.) is explained in the comment
> >>
> >> 	/*
> >> 	 * Nothing to do if the underlying file was _already_ closed, as
> >> 	 * kvm_gmem_release() invalidates and nullifies all bindings.
> >> 	 */
> >>
> >> The real fix is in (3.), I think? Could you explain how
> >> kvm_gmem_get_file() works? Why would the file be dying with the
> >> slots_lock making the unbind and release mutually exclusive?
> > Below is my understanding:
> >
> 
> Thanks for explaining!
> 
> > kvm_gmem_unbind() is invoked under slots_lock.
> > kvm_gmem_release() holds slots_lock before it accesses any slot and sets
> > slot->gmem.file to NULL.
> >
> > When kvm_gmem_get_file() returns NULL, it could be
> > 1) kvm_gmem_release() is to be invoked soon.
> > 2) kvm_gmem_release() is being invoked, before holding slots_lock.
> > 3) kvm_gmem_release() is being invoked, holding slots_lock.
> > 4) kvm_gmem_release() is being invoked, after releasing slots_lock.
> > 5) kvm_gmem_release() has been invoked and completed.
> >
> > So, when kvm_gmem_unbind() finds slot->gmem.file != NULL while
> > kvm_gmem_get_file() returns NULL, it could only be 1) or 2). And at
> 
> To clarify, 3, 4, 5 are not possible because kvm_gmem_unbind() is called
> with slots_lock held, right?
Yes.

> > that point,
> > the remaining user of the slot->gmem.file should only be kvm_gmem_release().
> >
> > For both 1) and 2), kvm_gmem_unbind() and kvm_gmem_release() can't operate on
> > f->bindings simultaneously. kvm_gmem_unbind() needs to remove the slot from
> > slot->gmem.file's binding. Otherwise, after kvm_gmem_unbind() returns, the slot
> > will be deleted and kvm_gmem_release() will later hold slots_lock and cause
> > use-after-free.
> 
> Thanks, this makes sense. The purpose of using kvm_gmem_get_file() is
> that if the file is _being_ closed, as stated in the comment in
> kvm_gmem_unbind(), kvm_gmem_get_file() would find the refcount to be 0
> and return NULL. (The missing part for me was that _being_ closed leads
> to kvm_gmem_get_file() finding a 0 refcount.)
> 
> 
> Annotating all of these:
LGTM.
