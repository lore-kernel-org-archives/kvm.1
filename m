Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2051552FD;
	Tue, 23 Jun 2026 04:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782189038; cv=fail; b=UgaxVuekIqvstSqb6qNuGPpcoqQ2AZe2HUui9xO0F5jnU8j0jH3Lbe1TztTCwVhLsQQVTkoZ5aexotAbBT3oc9W1TkBIF3nVjvfNuhFj3EYOmlfiomhnKjyu/2UxW5e40zvDj3l4HMsmPlft7BQ3xYAyn/QnAnmeIqsmwiOetC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782189038; c=relaxed/simple;
	bh=+6b5qmf8SUbhk3NCUJ2TZ5sVBaKLWQTOEwlH/+1m3Xk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MhDtMWWyWDzCop3UbN58MWBp04BvZBhW/Yw1Bd90Nq/Kne/CNhokxRSRRlm05VEqRsAkdivTkYUxMC6Pq1gMyZdoy66bJdYvn0A027rli9BWvkw4qOAS13ekVfJKl3e728BJhi21Vn6h87q2L214IU0vrAL++HijZL10c1iOCfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0wdryQY; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0wdryQY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782189037; x=1813725037;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+6b5qmf8SUbhk3NCUJ2TZ5sVBaKLWQTOEwlH/+1m3Xk=;
  b=D0wdryQYFsrrHP/4NefLz/fT7kbw93qTYya/h7ZwKIE/9O5X12b3mjyZ
   NdyEoEexPTUmg16VsPk0YIQw0qX10XMxtp+82FDpsYJ5fevtHvV4L2yEX
   MW4hV9A+nTSejgAySQNDJh3//jZJC6fn14F7MamjegeLbM1mdAm7C+xyr
   Bvq1UUKOoyd/gPT2bHLWvgaCnmUb+uywUgltlCqDN174QyoKflb47Gmsw
   39k0M+17eTddvVZHWuhe7IkXETzJY+mY5/uy0nMCs270qmS5+E7DDTkUR
   luuIbVmjw+O3vBiJ4MZZCk+sOODP2kO2+M7ffOD1/mAqj87cD36wLpTPo
   A==;
X-CSE-ConnectionGUID: Cbu+nloGRVK1nbW1e0kTIQ==
X-CSE-MsgGUID: 04R4vUNMSXq9IRc5U7R3+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82809152"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82809152"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 21:30:36 -0700
X-CSE-ConnectionGUID: YbZQ9aP5TCqA1u08ELF1tA==
X-CSE-MsgGUID: DT6u7dlKQtKLv2V8AOSI/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245274640"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 21:30:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 21:30:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 21:30:35 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 21:30:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1dxy0p/qG1z9+S1xfAb1Cn1cSuVfgJEEpWc3ergRpaAlESU2983uyPp31fut5SpDPfJPGv6J2rDtbV7OIBuak+xi6ilLoRGM4nQsYaljT9cO2LlgYqYsE3v0mR1sr7K/xdeLgQbIiAwNjGW90anoBCwiXFX0BHQ2i8HilAfkS4OxbWK9Phebeccuy2HPPvYWucva0npxlwxyl/+6ioSeukax/NQKP8yYUdrU5o8NvONJN6WYCIYHA7ONoEXrd5q9G4gtXMSNStQrmQrn12KzWt69C5mYGH+/zW9V1BYkrmUasdH3TNFJEbofmxkna+7lG2fzsqs8C2Y6hIYBAA13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kYEkv+V0aUE9Ku8+PtOiAg0omUjixU32TtgH7VlIcQ=;
 b=HGmEgs1RCjg9zlX64P1bmlbMb10zfl7CCbRiYqi4bfKDvGFSNneUDZC/Xo7DhIvJSG5rtpI0ipMwj98Dm7l4M009QaOdGj4c7vLSmUI4o2+hbsn+h2A6aAbd+TllJxxkLk81+fu59a6lKkv6HEFYcU2zfPvjEsDaVgzX4pSXg7NvNXmvWa6HNWR+UCcvzoVp7nzU9suVA/DPKe/1RGvx5D2RCRQW43UEQXbv9WiyUG1zAydW4CacKIv+pZkieKInj2Wify6OBe+uZYcNTQGnUk50z3bJWjwkhWsPJ4k44gNrWcLVl686JiQ0WnbgQkZTTT+Jy8vkksGAgWSAPa+fDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by DS7PR11MB6062.namprd11.prod.outlook.com (2603:10b6:8:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 04:30:27 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 04:30:27 +0000
Date: Mon, 22 Jun 2026 21:30:22 -0700
From: Peter Fang <peter.fang@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/tdx: Add helper to query maximum TD Quote size
Message-ID: <20260623043022.GA923079@pedri>
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-2-peter.fang@intel.com>
 <aiv8mrJDgs_e8eLq@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aiv8mrJDgs_e8eLq@thinkstation>
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|DS7PR11MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 943adf80-e929-4f8a-6237-08ded0e026d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|18002099003|20052099010|22082099003|3023799007|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: QA67eXUkkrJkVQ/VpphYVnIfR3ouBwWyMd/S63R2Cy7lu68TOqULAcpALVIILKeCBmsUEDxiWBdVYkhbOCDH6GUY9ubaBUj8Fb+TMexsOjSVHqJ6kh5yzGJrR92vtk/cDMqz1Ivm772aUXujJDrmop764TVsD0l9PuxlGLfvRUlC7fZsMGVS98nAt2y1/MYltSIss90rusfL2i32wQgfyXklI3GmFze2B/S97vFR6O7/qcMPFSpRva504abza0C/gdAlcCeoHd8eDa5KhHO2F9qqh1PCtePQr2i8YVv9/Rjpp271mp2cw/mbJJ2EKlli4bcUHQew+3iVUnYXqmBJyH87vZgCQYtVuJODXiZP4+vVIjNmnEquGDQjpbYTj9dbW2S5KrBV9B8Yxem3tGi9UoOZT4r16TD8tOmXm+hc22I85pznO3a6q3Z3H/W+p6F3CxzPmmGMECNMfpet7Ae4H07powYa3jso0Q9Yrjqwr4YOpeX2wdUGNicGZUEXS15PlFfL8nDLeLfYRPrkuqVMqmbiLUj6gp8zlfuj4F9M4bvxBlB/vR4z+xgkvjfKsMUGUV88DfCFwjXyk5VruxlxTd9iRid90NGF2LrPFT/WPXeXYbAkXarUjSVzbd8ml03Mq0OeEAUK3EN6N2U67LJrxoheSQks9VQGEGyxUBTNHzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(18002099003)(20052099010)(22082099003)(3023799007)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4TOTG7NngLy/Y7P9r5AAysIDVVZN0A1h9WlkM/ljTM4Nl/pLFMlgiTqoxNt9?=
 =?us-ascii?Q?1cdFgdoNuEmk5RpzW7GsWHO1omdQ1OiBBybS+p1kpRR77zO//rQuBr5Gou3O?=
 =?us-ascii?Q?/8hRDAPJmay7Qk09us5iqDuM1YzOg7hnalSo3/CEBqtCkp7/NlW6gXjbdd/x?=
 =?us-ascii?Q?MqgZ5IZfNcv205f+XaH2YL66+27fifrC0/65b2jNZwTMRmHE21y+i0zMNsFr?=
 =?us-ascii?Q?Kze92Mre2wJrT1IhDNiiR4luQvFUYCAoXPZvyGf69lXtLLGHiCK2AUrGcJEU?=
 =?us-ascii?Q?UZNQG/l97e7+wM9s066qgIx1CaXsmBnl+y0Qp2e6PfylNR0OR2AzrSgC9sjn?=
 =?us-ascii?Q?kuvxt6vlN/dmsSL7NxFvaC3PiqkS6kCxWeR9mtT71AGRGjmtHA8QiAUBOteC?=
 =?us-ascii?Q?e6q+5su6+r5PcLU5WhroL6SnJycpoVeSAyyUaz787kYBnPMYfhIZQGqyca+Q?=
 =?us-ascii?Q?jCv6Yb1XzoSmNihEueIc7jU/HCeDNC/psVzkYGB6+DE7XyzbIWnZUel1pmkJ?=
 =?us-ascii?Q?wTnjefW5xp9hwtEYLrZomcWvFGIxCFkPpGoBY0hP7qamvjxHqd0L4DU3XziG?=
 =?us-ascii?Q?aaIymZqEah8yvEzuwfFp7aa+TIonkutNaHNGsWkhyb7MmMgvswg1u8POnu0U?=
 =?us-ascii?Q?dyc2YIKO0Uc/8ipvIQUhjteLsrHFViDDw79Ofajn9Hs6W37XX4etGppZ5uIS?=
 =?us-ascii?Q?G2WSQDMYyKMaZFg14u+s3WoaETrHO3zwd3WCJwJKymhi+QOlhtKQzzo7G4qz?=
 =?us-ascii?Q?pI9EVPMpgAm5Np9gK98tSQ1tEw3gft5J/qjd/kAGnAmzY/iGZbzg64aDpZt0?=
 =?us-ascii?Q?0Jpulu5cxpIdjnJgExb8WsUwuoPOH7Ku1gT9517n4nkZP4r8rvQ3R5NczGrk?=
 =?us-ascii?Q?75VVGzF5n60SkHdyTA6ovgtKv/53jIoOaKKAIIXTK2mqDmphfljwXu0V64JG?=
 =?us-ascii?Q?Vs05nO5QaC6/dcLeCOVzqmJ3/Wgmpl7BOhzmqHfAZ/BJDW60WqDLTjnC+FAQ?=
 =?us-ascii?Q?eI53OgbURRdYRoW2Z0dixHVnjNDkBD1id0PPF8qtjJhCDIXRAN3xN6B1Z5ZA?=
 =?us-ascii?Q?RkO7vTgg6UCDRFeQpxm5ItE/4fjBYzdqvx6wbKRVPOexkUaDhWqunJqIaCsi?=
 =?us-ascii?Q?SZll0XJzSJxXp5mj+1ErCUN5dwoca0L4ECCY9FHmq6RgXUN5kjYfK45qNjS3?=
 =?us-ascii?Q?hCs/e61a7WAHzK/Z4FE8spctlB1FBcZueEDF1cGXczDq/JmC8+c6SB1h0WfP?=
 =?us-ascii?Q?nh8QUug4A9IM2AigynaTRFUFE6CX8RQN6cYz/VHEUff8rn5eFA9tAtVVp2Ep?=
 =?us-ascii?Q?5tHmk5P10KKVzdlomGOVc9nOgSu8dE9FgK9VBmw9x+VSrE8K64FgJfe9rVk/?=
 =?us-ascii?Q?JPIOq0aQBe3t4paGbAyLzzxBJP3T7+nSRPSNLN/NtkMBT9OlWjLZOvqEQtud?=
 =?us-ascii?Q?OP5JqQECQWqM+2TvD755bhLq66szAs3sjt1MYTdW40Enn3BG63Rg2RDUPxwN?=
 =?us-ascii?Q?RcTirfhWcqn1VdfE+3V7OlKVSkdbOxpyxqe363oaVQIYP+LvF8QV5+ZSsHUL?=
 =?us-ascii?Q?qX8m/tA/uCkA+gBrp0qlVOh9Zt6Luh6jPWCDJ6ATDeG5P/kU8WvYMdk0Vpkg?=
 =?us-ascii?Q?DFOZjjnKkRq/T8N0p1WkH7eThEQGkiLDG0kfePqxKrNIY+H5P95WdkTydqhx?=
 =?us-ascii?Q?ZYgbOayZKSNkH/+9ChffBPYFkKMkpRrei8i+GAXYSWDFDkmN1IrdJuuMJ9t3?=
 =?us-ascii?Q?FhdaK6H3ag=3D=3D?=
X-Exchange-RoutingPolicyChecked: FBMGRq3zxDuqxRujplMrXmnLxqeQBm9zEAcdfI4cV8Xa1kro4u07uTf70AghKhiDPKXIQXY4Uq3iCGMNUfIW8HbcQPfHUwgRpa8cfEeymUzcn0ysMvp+suE77wfi8OKijeEwRo5LvAJKrn/z1UUTn4+BQgQJjDI07vvzW9ehSq74OHtV03zRJNX1xJDg4MfX8ronIxHP2RCA2hIZxRLLeRnOy9pVwQ8HsDw6BssWRGa7a03n7q7cY0h928wfHXfU+YNQFBImwlMUCjm6AStTzCoDPtCtB4prbtRGk3Tp/qbzbXnzbWNYyt816KSH3o7eg/09xeXd5dHEbt4PZPzTjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 943adf80-e929-4f8a-6237-08ded0e026d6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 04:30:27.7823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4RyOTrk8teUBedZ3bgaWEJ1hQ8PjapzpM6HkLShmIfhb+V3xD1OisYqsjp4iShTh9GYxsdx9s1SUSts9HfV1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6062
X-OriginatorOrg: intel.com

On Fri, Jun 12, 2026 at 01:36:16PM +0100, Kiryl Shutsemau wrote:
> > 
> > Assisted-by: Claude:claude-opus-4-7
> > Assisted-by: GitHub Copilot:gpt-5.4
> 
> These supposes to be on the same line, no?
> 
> Documentation/process/coding-assistants.rst:  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]

I see... I actually used two different agents, so looks like they should
be on separate lines instead?

One example that I found:
91e901c65b4d ("um: drivers: call kernel_strrchr() explicitly in
cow_user.c")

  [ ... ]
  Assisted-by: Claude:claude-opus-4-6
  Assisted-by: Codex:gpt-5-4

> 
> > Signed-off-by: Peter Fang <peter.fang@intel.com>
> 
> One nit below, otherwise:
> 
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Thanks for the review Kiryl!

> 
> > +u32 tdx_get_max_quote_size(void)
> > +{
> > +	u64 val, ret;
> > +
> > +	ret = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, &val);
> > +
> > +	return ret ? 0 : (u32)val;
> 
> Cast is redundant.
> 

I'll fix that, thanks.

> > +}
> > +EXPORT_SYMBOL_GPL(tdx_get_max_quote_size);
> > +
> >  static void __noreturn tdx_panic(const char *msg)
> >  {
> >  	struct tdx_module_args args = {
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
