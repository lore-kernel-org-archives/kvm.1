Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4286D191;
	Wed,  1 Apr 2026 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775002432; cv=fail; b=B9qkFkTmLIkaivTO6hVCijvOvbIlGc1d6OXpZgY9AzRMITNNLgbYBYVRRstgCDKPj4Az7ftMP5ww7RLJG58vy/xel+v8N4iV6Pu+xDXlw8En1zZP6rTNVRqM6nl6tBKgy9CzwIC8eDSMFjg2BHVEOAf3Pdocn7eBpK1eW+g1XO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775002432; c=relaxed/simple;
	bh=L3dDAUFQnDa/KXvSrkvPCWCwQHbtM8U/kTmHYfx+eaw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jw7uKBbwU7B9eecs9CJSW/N6jLne0rxpGKnfW7WJr0VsKnluK9hUODz8C04i0Se2pUQzzUoZ3h79/VjjvSDG8MXus+A/z5GS2pGyO92EdAKapI/lh+6l1IFjMWx7xQykS66YnhxAmhdVLw9D7jgob3uKeK1SWFziEySRQyKyXlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ck0IwBjz; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ck0IwBjz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775002430; x=1806538430;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L3dDAUFQnDa/KXvSrkvPCWCwQHbtM8U/kTmHYfx+eaw=;
  b=Ck0IwBjzu58X0Km6evPuw9uRfZl5pwsd/AgMWBhoBDJig8TZmI1G2EuM
   Chw3MY6T9ICZp8JSk58Ugf5wpmM+wH4nAL/5sCeWpqoKfp1NAd9d1ER3b
   14kceW7yWqwurddpkCGimtcwmMhg+ke9Z3emT85Nb0fA3HLadnI0zejB9
   kHD2Hn5gH56uytIkzZ5yEQPpK1qxZLZu0emERN0xdwh4KuGx4fmi2NSQs
   U/Ue7Z1tHu1SjlA0stJzGFMz2Yoe2eZLAuqawhO6eggd3HlGU2FWtUOdH
   0FCQgo42r85b22ELxu+mL6VTVFG1U8KMxIvtC0u1JpAbeFTEShzXdO3Ax
   w==;
X-CSE-ConnectionGUID: n1a2Q21GTp+ER2tL5mC0FQ==
X-CSE-MsgGUID: Dx6U1I79Q2+EAuY75W+O8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75917920"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75917920"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 17:13:50 -0700
X-CSE-ConnectionGUID: x1hBkVQ8RxO59yVe+CqGwg==
X-CSE-MsgGUID: AOx8BuXYRNaebI/SLSOJ2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="223210938"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 17:13:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 17:13:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 17:13:49 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 17:13:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqghUBLWv99UZ9SYXbKI4NECvkmreUZXwn/Ty41kSvq1MYdawyomXodakO5rV/pMBIwXqe9NI8ORU6924D1D1qoe5ce8E1ag0xd/aNHQhr+dBt4406uzlvMzc/7pRfuqpLCz46kbdvOoGaUDPGjhDU2HKIf98c7WBtloGDsLDFS9uGayru51pdkeQaxNr4ffHB1C0yKfSQXZBQJ3rBid4QNgLJwuUmndsY4PwBD4RLFriToudg8JPGhVw1hUdM1AJa1UFbs+GQlVtvMSCbay5q0U+hMmayR32U1XdIml7ZqSbBPlSjW2gHP4D4BigDr94Ve9KHKJ0KaeGa8v+zZ2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM9nXQT6fNRxvcXLlVt1SxOl68Dbe2UZ8ZTEsMIg0aI=;
 b=Pm/Ao6JaJ1a/F/uOcEHvjLERSxA4y2/Tt4PyaWX0WrpU/+hx8e+2H1LG8moaqzf1j//ik621a567sRVChjGfZMXiFh2sRLhqcVBagPv+U2ZP9YrbTFxMGtkyEGZ1bbKNoW2gy/HfMKflpEop5n/+oKY6CU4P5ZnTlf8r2IZ2iGzhpojZtQtnnFmKejtmn+B5+GZU4IIEv+Q0Cidyd/5lSLUwTcty7+1hYyou1sRPPl5wH/3b61ybGOcooegCOcEuTMGRBqeIDxr3f68IutRQ2yMvvqS/dZZmcL3LwvSF0JYfDgkW29pVvTDtmv0aNw9nhHKe2RASAAFYh/fc2rsbxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 00:13:45 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 00:13:45 +0000
Date: Tue, 31 Mar 2026 17:13:38 -0700
From: "Fang, Peter" <peter.fang@intel.com>
To: Yosry Ahmed <yosry@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Nicholas
 Piggin" <npiggin@gmail.com>, <kvm@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "KarimAllah
 Ahmed" <karahmed@amazon.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
Message-ID: <acxjMsx/UixNa2R/@pedri>
References: <20260325092001.613025-1-peter.fang@intel.com>
 <acsvbxIdtlQzUw4q@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <acsvbxIdtlQzUw4q@google.com>
X-ClientProxiedBy: BY5PR17CA0051.namprd17.prod.outlook.com
 (2603:10b6:a03:167::28) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|PH0PR11MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f5f5a5-6486-47d2-08d3-08de8f8389b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: y4eE/oYSILb4vN/Nq385hZgmxuLwHgchrC976sa7WWiq3Beqngp1eVKw5dwbdRW9ZOjJpjgigrupIFsCsC6oFFtoHbBehBPCiK472pONzuvzxBFYiH8WTE2nowlf6PInZzgejzGzhacVOITKCbtC2Y8bv72t39EQClKciTb1mkIQOpooZ6/ozlWLgcYe1XFQvKePnLzsBCNKlUj2SqOYvZAHu+Oy0f2OoxWpEtt+E+q9aaxo6OpPO/NUNZ5utMhMY4/VK1K5r8EXLXjD6xoSNeHJVTn2/Y8swhePbpRdIyfGS3onl/JE3DtIA0fcQh5tzrBpFykTM6KrNIi8CY/+qKgqrN/QYKzqvN0Q40E6sSzYGAOU3gjETGc9HFgTrAjhouIqUJ+p0pcxQbyWwaOR0HgopR2/aJGfSws3QzweFP8TJfYrG9m0LU9vvqNstSuB1xNtxF6ZQ/Di5z/up4G16tWrHRefQPcI4dcXE+By9MZ5yXvUhOeLj1hFz337J6T++iwPJa8iv7+iapUIEhBgppLUjaSzVaekoEkGxq8ZdTGpHjepzZ/NrecD6tdhu2+1+EACZ31aKrN80cK0ejJg/izKiRkulb189R+63qmFhoWrl4MDsO6TFG6ciIFvG6mYlT6RqTkHUwRViJbayZc0eIHCiGXZAsgmuiGafAgd2Sb4leQa09XDIX895Ihen6Az3djaE6YI9yY+eIz8OiDCDTUtx1qdxDdBvnTJcnmW8Hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JHrW4PSsX7qLdr+wwm1IbQLeRY+FmzPOC5HPMPIF10n+zJyYWC/ftoYL2RgV?=
 =?us-ascii?Q?qUT4YA38wL74LJDPEzVtP+h+3rVLdwJOkBL6DhrKn02GBCV6FsygolKGY8ag?=
 =?us-ascii?Q?DRqI4Ea4iFVpaPFqUyKZ3dZah/ck8+9fUkr+Vk3Q8CKTlq4RkFjsw9M224XV?=
 =?us-ascii?Q?fX5Z+cnt/iIoWGHruwBAst/Wvby1213zpuaFaAwX68wKgGwFBaSX0XEZSypz?=
 =?us-ascii?Q?RsZAd3ZjcILrRiRPb8hfl7xSAaOjdO3Lsy0jqNMHC5toA0cIDAI8AYBHxymh?=
 =?us-ascii?Q?SS2e55BDzPLrFL28bAsaDciDTg/BDnDkSdEq9HijVwOokTfs2qcxSWGz8xrm?=
 =?us-ascii?Q?BEZ6f99qxdE0fUZHGuRGK2kxso8p1z67VMxwCv07/+ttsNYlJMAQdQ8EXXtt?=
 =?us-ascii?Q?5gupLNZlrhURZhicdXa8bI4ZEaEG+YeLTa6rqkHxNz2cr9BzEcjiaXJ8GkkX?=
 =?us-ascii?Q?ZL/02NVzGBJo1F+/MdlQvu7R5FHLU0+usvKD5H2EYdmyx+ZJw2vo59nI+d+e?=
 =?us-ascii?Q?Tp9ZitnnZKAtrlnVS7fL78Mo88ghogu7fHtLPoe2kPm7GzCvik7OL/dXQ4n8?=
 =?us-ascii?Q?rZwsV6B4nQr/wNrAN1Oenco+PvvIkjY5uOt0X+xr+vL51NdmvMK4FQs+jzrS?=
 =?us-ascii?Q?9gHVxRzNiT0A2ROMCuSkU39ZTWeVJ1gIjCHf0gD2YRIK84hEVefadJPYBIC/?=
 =?us-ascii?Q?9AQH3lx7eXKqwRgoH7oUcaX7BiNhzrMWtdrTjdnYRQRnpwxJhq7qnFN+PBiD?=
 =?us-ascii?Q?YqYO51wMZG42EuL0exSOy5oOCaX0ntXyuq63T//lMMXRDQPvaFKk48qfH2my?=
 =?us-ascii?Q?0jCpkNKIoU5fHe259eIeH6Z/pWWn4UrhQEemXnKrRLJGoD1YBVL1Ajv2AJ4C?=
 =?us-ascii?Q?qvdkgoEjfjkMAqpiNMPXF6j4hb01D6c+CsIQ4PZFXfrgvGyXQ6tnCKmFb64o?=
 =?us-ascii?Q?7RoV1pDe4ZZPFFjynpYv/HK2COR6Xvsn2/X0DoGSKSrOqGH00LDCHDASUYrf?=
 =?us-ascii?Q?vVDssNmbV3KkoQo4u7kd7M48veXVeXB910e0Q7lJxDYi/pQxSxJCB4CjfIlq?=
 =?us-ascii?Q?WZ3E57kxcJOT2uNHgura1mftkzW/J3RF32ZleFuX7JGMaq6+gAK/1JwYGsZV?=
 =?us-ascii?Q?M8MKQPAS21S951wzy4mUHR5cdQuWOMm+VGkGaODKtNzld1yAvsJrvU/o9ztk?=
 =?us-ascii?Q?PStS50mBS0NJX9yjUkkogelO0o2aFY6YzXxoMnyi23qhAskeEImHfWOb9ach?=
 =?us-ascii?Q?6NXd295gErcQ5FUITXK9sgEEebOWIHkr+K1iePV8iyIuhRw1qH0jDW/kf+mA?=
 =?us-ascii?Q?7pWami0CnjtrXkcUApDMi2ZHQ5BUEO86Dc37DD3zZeHlgrshcIfLU8oZFSVp?=
 =?us-ascii?Q?sCMXzXT4bnZYwHRl//7PZuD+ACCz5Z180VN2D+fj54WSDLjmgCzzu6pWFmHq?=
 =?us-ascii?Q?AVOhfsXdCCwRTz3Mbao2dWFklBGtImjXsiFxbALVJZh8tZyCrmKG1lrIlrhM?=
 =?us-ascii?Q?XBh2US6hhFrbFjJDACNliilNS8ovr48GYFOtBd5mF35jnzN/D5jtTdQZCjF2?=
 =?us-ascii?Q?/knNfnfL/mjbLLfp095CjXukfbVcsYn1/bx8iPUZWVJl03JnqJQ1S+zLnh5/?=
 =?us-ascii?Q?Huky13v0x8jZChjuSxdDHlsXIcMaClpnCaNApInkkZh9ucPzRzX1z0O3OoHx?=
 =?us-ascii?Q?hU0HXRt2WbE3ZpDChE76vAgohaXhijplPmO6b3stR+Sg9yMjRg9QryzOM8OY?=
 =?us-ascii?Q?ZDh+5KgTDA=3D=3D?=
X-Exchange-RoutingPolicyChecked: IhJGDfQpnIji9WSubcvCcKD8zzjI0/dD73bXPF7cjJ5dna/wtctJA2DSgiuLQSV8J3J7k+Z1LvnTlzZZqi4u9fNWQeUxyqD1RLmvM5/etWXhIHwA0RRG1z4TkSH/bZa38abN+xpn+uD/4PnANzExiTXnAU2lOOgVJeIDhQJhcHyEEZK6levt/JTGJtk4Lf1x/JT+TkjxvpiR5B2Wddgqg6xfKE8rgGxCNgTO34JLhONRROBnjGzD7VdTamtkSLGjjJR1Iwm074ty2wCxH58k5/c5JTgjPUVZmgtf/98quyP8XzWEHs5ZCGaHBedhmYyPrsM/MkqelA4pP9AAnEz/0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f5f5a5-6486-47d2-08d3-08de8f8389b8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 00:13:45.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GxeZObPlW/DpFtR+fyAFf7o60/jaLyfQXb83sVz395JNCSfNHTuTOGueRCehgoNZ/iOxjxztXKUBHQISOClZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7588
X-OriginatorOrg: intel.com

On Tue, Mar 31, 2026 at 02:22:47AM +0000, Yosry Ahmed wrote:
> 
> Most callers are converting a GPA to a GFN, I wonder if we should make
> the function take in a GPA instead? But then we'll need to the GPA not
> being aligned to a page boundary (either do gpa_to_gfn() in
> __kvm_vcpu_map() or fail if it's not aligned).

Thanks for the feedback!

Mapping guest memory into the host feels more like a GFN-based operation
to me. struct kvm_host_map is also designed around GFNs/PFNs so I think
using gfn_t in the function prototypes seems more natural. The caller
can handle the offset-in-page cases without creating a lot of complexity
in the APIs. But I'm happy to rework this if there's a desire to make
them more GPA-friendly.

> 
> Not sure if that's a net improvement, mostly thinking out loud here.
