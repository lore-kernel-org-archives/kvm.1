Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCED4A9D61;
	Wed, 16 Sep 2026 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551898; cv=fail; b=WXG6YJgK+NpaAb/9fjYEDEQ00jz5lZ9hM2dptELRvzGRvLbOQLv5UVpY+dBlMS4BMGiHdwkdnZk39mBP7Ri423ucXTduSesUQZYn7hxPgIJJmBeh49sT1smkHL5uBKNQqFHvxEuvcR2yIs5uKKMDGywyka/Cs5Tgf/Y1ZLVApcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551898; c=relaxed/simple;
	bh=HQpY2tJSFT3DWakJErVPWs3I9Kn+JDeaHql1HtQMGyI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GJQAf9tISPmFvh/BuAI4u59woro3Kr9rWgQXeNybgELPeRvrMLuNmQA0ryAb6op2oKs/lBwJit823CE0zNTAxLfEdPftx7pMJEEWo/Z72iidtk0e2cBBAp1VcfS41rFdiTXJCbOcb5XVJ0YictkVNbdYuKR/2eiHvyq/ZUeNlVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoMONJYd; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoMONJYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789551892; x=1821087892;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HQpY2tJSFT3DWakJErVPWs3I9Kn+JDeaHql1HtQMGyI=;
  b=IoMONJYdv/DM2gbvq5GQqtoRCb4b27uPvhnDVeKBM/40aN3uAEjPxs42
   ar6/sZwUJFqD6DLKh08tU44aMqIwtjgJl3HB2oLb2KOct1tq/SrhxsdeU
   Dpcaxz1o3Ok/tf6rn/dhLDn0F5dj7c/pgTkiHxoemDtQzLjDxGKZq5Cqf
   e5M0rvozxPPTuDwTxkf8qh05ifS9PGHOJsUIHyxw5xoO0LpgFbu0PTC08
   9/D5InBl6TkX7ojSqRgpIAHca6If4cBCMeq6IZcqQZzSt4FjuWEGE94Ue
   0Wm54jXBzlkyoaOPuryXdG5Z0vNKPHA/agQaD70xsWEeo2K4NuC6D6ynA
   w==;
X-CSE-ConnectionGUID: s9l9cU/LQkuLHYPVVjFYMw==
X-CSE-MsgGUID: TCruX8s4R+Kduwfn90mNLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100589751"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100589751"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 02:44:44 -0700
X-CSE-ConnectionGUID: +m55rDBPRvGwMJVXF/25pQ==
X-CSE-MsgGUID: 827//w4NRg+nhpkLPQL94g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273258035"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 02:44:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 02:44:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 02:44:43 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 02:44:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwMEhKRcecNMNTfXtb2iVsLPA/p9snvqk47K3zOgKFeNZP36W3haN4J/Bv7/AM4qL6xh4eQQc8UV8qwmzPFkuOIconjh7D0iCmnkId3uaSJQKcdXW1iCM/ANvWuYvD0w4AQp79xbjjhRWXXonUUj0z4RSNKkKRG6v7FeFt/oSxXFPfLWbm1CeUGJoGM2dl+QF+1EK37TXuxxNBimy/X0zNqcHJBWsqn6/PJZWijD4CTghoXeQeRV98O2p0qSGamT6/EOh+SbYYL9FRPHcmbsHYFiCETraWOA8jZehDdbu7IqpvKW+I7yxq6BDF8XwQUUYKEk8SYBgSWRUspnN5nk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1hDARhgUCHFOs971R13YNeNO8lLJTdGKUc1bE+IJAk=;
 b=CyOTy08lAnkXDznVbQbT5KeawmcQPio4LKvNdXS02mfJxo+Qzyh2Jf63y8tHb8de9DJLVdw0cg4SI97enj7TKyyjymhnHJa8xWhrSzf+ZI8mgSHhQ2ng8FvLVXXOC5G/CQWt5m72TVSHcrbOWlZmLakO5JtwCRgZTdldFOp9gYRXC3tprICOBpVhXga2AqFBn8zAmxkuSz7V0mPbRaSvJKdqeuoVXIS2fQVLuq/QC8w5Zw5JDraaWsPkUcCmei7sn7WD9viYIWE47MJX/MSjwzD1eVjjcBX5arofDpOdLxbdPLTM4M4jWU1PCK/2mOo23agXYd+Uo4h8teO/sDrtjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH8PR11MB6681.namprd11.prod.outlook.com
 (2603:10b6:510:1c4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 09:44:35 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 09:44:35 +0000
Date: Wed, 16 Sep 2026 02:44:33 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Li, Xiaoyao" <Xiaoyao.Li@intel.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the
 Quote buffer size
Message-ID: <aqplAYSXnO60T-a_@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-4-peter.fang@intel.com>
 <af483218-5c87-4ce1-b4a3-06132dcc3c49@linux.intel.com>
 <apit+fXmapCA2qlc@intel.com>
 <e6121cf3-83eb-4cc8-919e-2557fbcab3c9@intel.com>
 <apoerDLC_fpSupY5@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <apoerDLC_fpSupY5@intel.com>
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|PH8PR11MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5f0550-e494-41cd-18ea-08df13d71e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0uWMyjJ8U73uyZUYRnhpaeu6JPUCcPPahizwUW4D9yU8WZR73MoB3JtU5FWt1EYdIr5GAUOddaSI0q7l3ITkQ93+zxXsDQU1FUkHHEswu1C2mEBeMUito7tI13OWZfPx/gBKtzwgw6AgV/jT597d+NjAhfA5Fg7WKenmDF2VVRJK3LFn4Xy+8S1CIVBSmQNb2E2Cc3+/jzZkKKn9ctHENskuxzjsOeBOSrkFK+RVEX8FPN92LEH0m15XHYwUfHw8QDxBXA9jeu/jcmXC+uOj6uEL7T73bX9HL8uqVEBZMcrCHs4TxByRLxDpVKxxzPQuhWAYnww3HYy7lQsLNSS/l1Gk14TcYj7OFFmq0eDVtT4DIpcK82tI1HJMZHquGk8nNdtPpH5y+6QSFRTZRHqoK4tzwDUe5L3yAqmnSFVfm4wGRhCUOcDxmUTVCwnLS5kpKSJ/zTYTtHuLTQ1w9tbtPf8Otqy4un6boPynkYCmkfaECGEO82Czl24R9y0miPEgkHi7QjbXZRNMYAjIRaIx0HYwLnr51p/IYfPVlqpMkTRBGFYh/Vxqbo7ArIDFX1bPLkKAcqp7yH089iTZpEodUdQBBHRJR9JbpJ+JCPaK5MPTYU4yxHgOdsfVhfy6YIdjY2m3YMBJHuy4AlDTC7am3oGuJIO+61tTOOuPV8PHdD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/lhQmpnszYlCl8fS1iEE+ZSkHgahGtQ/zgyrZT+HtpF0XgcjTf9fBwvJ6w9L?=
 =?us-ascii?Q?9zBZWJ7Cn20SpDhg1yLhEG2xlVnK0nURN1bZiBVyALQpmfDlRds8lQbbiMQW?=
 =?us-ascii?Q?Jv8Wfjsq4qjWWNa1wU1082fEQ8EOciXoe162rV2Tan0aryq9w5sxpyoz2pLX?=
 =?us-ascii?Q?vGQVx63Y6rH5cUspxAqJzFEIEo+KHuGrNh9bKOb6nel6Lh2FCbQP5PjvpOS4?=
 =?us-ascii?Q?F4DqarHfNR4xbfXVcj4BJwVtYU+p4SIfFBrxfDxxMM21+nehjzBRU2KbmzY2?=
 =?us-ascii?Q?0PH48htAqcXjXHazU/sA0UwolTGVv6J9hpeoBUZ6+KlcWTHuiV2KesGgRD3l?=
 =?us-ascii?Q?T5A2N8eWb1lOEkO2nH18ArYsUThlPdTIVRx+UJkBofFr8ehl+nJ4yUDqXdu+?=
 =?us-ascii?Q?0yh7YGrohBXbaOkbScxFxRxgTAQfJSQ6TwcL0h/792qZrYWD4ZlbfLXemKcC?=
 =?us-ascii?Q?w4OFYxAdAUPe+GcWNfIeRQ8xU1mzqqMUJDRxbjVwHNp2OArWg8QDhqCkwdO6?=
 =?us-ascii?Q?R1pcu1ocaiYz0szXz5vLancsYkJNESM+kdz82cwN3/2PTpEd2XdJAtsCRwSE?=
 =?us-ascii?Q?Bup4LamOqgaa0gG9d3aFhhaDh1pCnCrjRdNySSbHWPVU/weRoKZ3ShLja8wH?=
 =?us-ascii?Q?p8cQtH6y6/wRQxg3qrjZC/gdEBe/e50e1NNqTs/hzPP2K/JebrDGpkoQ3fiw?=
 =?us-ascii?Q?K/rcmArA75ISFh8wX+BgOlV5Xbnj5Rv2a2Uq2IpsMGXS+daglUiQcqFtQiH0?=
 =?us-ascii?Q?Uenu5yjImBBD3MbdEvXtPlNmokdpDaxf7Fp+0IsuJNI0Xbbx7hU3dzC5HyO6?=
 =?us-ascii?Q?rPtjpIS9jn9U6UTUiEpRJQG4dZjTaJoT8yDeo9k9UVSjwTVl9SQhr0m45ONf?=
 =?us-ascii?Q?NxgH2rLZRQDLtFUsUBCzCPHTJLWhQIGCzE1QqqxXDVBWFe0WwBMx2BMDxUcm?=
 =?us-ascii?Q?vZyOY1qRu/xPIQqvvAW1rjjYivEmWVDmNHWZJnZhJop1Uq2m7dqvpCJzvE/Y?=
 =?us-ascii?Q?N0iAuoDIwYXwejVTRbOwgpDBV43Y4hxvqDwlAgLVnZ3Bxh2s3fzChjC7+jU7?=
 =?us-ascii?Q?5CuUAG4vpDHlLuB4fZPmx6IsInW7+jLsO+SHlf6xIxKT/RslSkrHgnjwdzhJ?=
 =?us-ascii?Q?SmcqA024zJY/8MDzJJQoD2fn0PkaOmZPCBC9Iik2/AcZEjvJboOJvqg6Wq8z?=
 =?us-ascii?Q?CSAUzcyrU1Mup28OSxvNGs1iTuy5SZpq7OjtpwubojLdcpuEYQJUsD6sG6LV?=
 =?us-ascii?Q?fmK4AR+I86H9srYiyuOAaEavYjt+SWfiKIdXSjRSIr7B8lZs9D/5kqOQuS1r?=
 =?us-ascii?Q?BELNyhBZ9dl+9Zsj273HSFB0PFz1/BM5QS5Bh6DwwfiebekX0e+YbbZl5koc?=
 =?us-ascii?Q?3ggnkZ5i9jkiLICRg3tQKhq2lrRc6EN0urFdU45qp0i0MpZfgUB2VWr4HGKR?=
 =?us-ascii?Q?m32pBYrAjTKPetl3fAm/w0TlNQU24NDahIBe9I3Q/jqxJ+IpfeglTLynfm1G?=
 =?us-ascii?Q?8yclu5rsN44Q610nnEC5Gcg86uJBsdoaG5aqOzTT5n4rpQ0WFztPnzVzuGRq?=
 =?us-ascii?Q?N8eT7gN9eLSFwtU7uqYLjPrtrZSnri5Vs8UByF7PRN0UTHG07REXhB2E/ky6?=
 =?us-ascii?Q?KdYd8ajLr063ZuafiYJ9Cor9pBb5X5lhnpIYDhJpD5ic5zNdVrjiFrdERjdo?=
 =?us-ascii?Q?/2iDq1nGwAjvyboxDQeiCBJrzsewqlV7Z3HjJARZVNMEPzmzhUA5B21sMZCn?=
 =?us-ascii?Q?2i3cQC7s3w=3D=3D?=
X-Exchange-RoutingPolicyChecked: dzP3MDJTpozH/agQjk72wWXeUraVirNgPtb7gaqyU6W7P15FgGMtsvPuUDd7Ftt7kb7FCcsUDF/M2FRS3rAGteb5kMlDYAWLOwnFisQawlP2PJ0RnZdBUdM755zYtYDBZ6sI61BOT/NL2SVvpD20FPPO6bSu7RTWDb0Zv3TN5jn5mLmOIxKq6bxg6t7Im2/DgIKfH8iKBqPLCJ7EVGXi74GNBNdM72GRTeU3mSoLLPkDdaqwFTgJC4LyXAcjPwb2hmzgDEGbi2Bkm3dSOGgGi1FbpYVZbu+sn5UDrOIeJYKfh9+LbjFY5N8xMNC4RGHs0Dj6zJiXIizvjsr1oYNmqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5f0550-e494-41cd-18ea-08df13d71e48
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 09:44:35.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7rOiPfmZGoNZd0RRlr+y2GdKOMYZInQriZz5dXGK2l6awuag3crcPKrnUApbImzLgWd7EkTcdmgFAfDD0L5VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6681
X-OriginatorOrg: intel.com

On Thu, Sep 03, 2026 at 06:28:12PM -0700, Peter Fang wrote:
> On Thu, Sep 03, 2026 at 01:59:25PM +0800, Xiaoyao Li wrote:
> > On 9/3/2026 7:15 AM, Peter Fang wrote:
> > > You are also dropping PAGE_ALIGN() in alloc and free calls. You can
> > > mention it in commit log.
> > 
> > I think it's better to keep the PAGE_ALIGN() when assign quote_data_len,
> > although GET_QUOTE_BUF_SIZE is aligned already. This makes it super clear
> > we want to page size align the buffer.
> > 
> > And in next patch, we can make it
> > 
> >   quote_data_len = PAGE_ALIGN(get_quote_buf_size());
> 
> Hmm... Looking at this again actually makes me think it could be
> reworked a bit. There's a discrepancy in alloc_quote_buf() if for
> whatever reason @len is not page aligned. alloc_pages_exact() rounds it
> up internally but set_memory_decrypted() rounds it *down*, so we'd end
> up with a useless page at the end...
> 
> What if alloc_quote_buf() took a @npages instead? Then the expectations
> would be pretty clear:

I took your suggestion in v4 [1]. The @npages approach was more work
than expected and made the series bigger. This is simpler.

[1] https://lore.kernel.org/all/20260915092632.2822169-5-peter.fang@intel.com/

> 
> 
