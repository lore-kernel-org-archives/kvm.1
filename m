Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DBF3D904C;
	Tue, 30 Jun 2026 04:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792739; cv=fail; b=qRSmTHocX5ImKKSr5G1/E1UHRQlQp4iZI41cpiOqanPdqxT7p+fL8tvFvahh0TrSGuyQFz9t6AwJjkZLbsm+3WmCN2eREeEt1TCLVRU7o3pimIAjpxvey+SSigXWGVfWAUA1Be47tC47w8HkYSFEeJhZqxcd3t3JdxSYXQCEgc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792739; c=relaxed/simple;
	bh=saiTF95g8NJqJ+bPf1WWzaJHCQ8YUSzgDbiUxlpATVo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hOb3ZTjfveGTvhkIfzFnIzCMG3fBWnAM9TwsW+LuHQCrudGnW3rWVX6O7NcLOAnGa3P0F1A/gGLw4XvQ7XANt/wlJKPXMk2aBoMGrgEzdA4hRrBLHgE2orJhqmttp8bQwx+keCY0J7P5mPZ7an95vh9wiybPcGgUhlbBxndBwBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqJDptkC; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqJDptkC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782792737; x=1814328737;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=saiTF95g8NJqJ+bPf1WWzaJHCQ8YUSzgDbiUxlpATVo=;
  b=OqJDptkCD4ZGZNybX5Bjw1QMypxEl+NTb3HPGKAuoC/INw8cvFr2tQ+M
   43Qc5vMk+Ngs8mmiThfI4tAXDF7Q2e5eRD3mf4UxI0/1zhQCdJUFWRuis
   CHlxF+lxfTsiwqjggJI1B3bu65WXGGl4+KNxWgncwzq0xf9FMJLJTKycM
   Xc0x3ux9SU0Wzdb8Xu03lxBW2C/Wf5UaHhseNE+LrcvFS+OxVOiz4Q7mW
   5XobmPckVWAt0fkUkR3DuZ8H0RHVmQvSi5QwpDtdIz1F9AGkGybVP95LD
   BtVU44PXEpiNL/q3+7Zh3TVs/B6DtIkijXgDEQcijQmFU7c5pX8iputyD
   A==;
X-CSE-ConnectionGUID: ZuvPoeqZRPexqQeLE3WuBg==
X-CSE-MsgGUID: mCTiIDkqTzedx/qj8YoGpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83371053"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="83371053"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 21:12:16 -0700
X-CSE-ConnectionGUID: Elwmu6f9SLa+NaRD7FJgYg==
X-CSE-MsgGUID: Fe2EpHCzRt6YMpyVLdiIVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="249510134"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 21:12:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 21:12:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 21:12:15 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 21:12:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F98qNGzkYbLLZ9W4QEXlWv6WHpI0B/REONd9qQCv6uJfkbVSJ8uwlyxj4F6FSMwrHuf00RRz3O7BgQi+Cd5fNyg39mSvUaCGAKE0AbVAjen6gNB+NcHXHxgdQNKqXH4uz1kEoyor5ZkpfAYC/oeR4WP/fIA5+C4IK/GASY3JPpExUUjMKKPnge0kmPMdgYFRACRCELmVJtZ/nSvniWk7yEiBcitKeEjczeeC9qWdMnDPIx0YDPIrBoHkoIyeR2bC0UYdyVJBMsToQkLjS4uf/919lunv8Z9bqfD68AtQZnEVaps/57EO+uaduc4pPZZYf9MgAJjAeRYLsHvYC7XklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTidE6mIgjOjUlqkOPWyph6cxnquEoua56TfpNUBFZ0=;
 b=hXrMCeeyd0aPUAWyDw00ItMbh+Hn5WTFs80Wy/iIUt1KoX481hYbmbBjSjZwxtBMyUuiYuAFm9p4pnD8ryu1m34I5kUML+0Fm4BuM1DjNwoiSmi5Owd+n1nDojCJa9g4nyUzYpQVmLvdMl5561495Id4hXgfaccSe54lbV9WjY/lJM17bDbjaN00HGSpIWxO8/oaiNuu+eK5D3IROUgsm3gbGR9+HhueQqa5F0CrRsh5gRMrHWaxXn+HSZ/X/1+gDKj/MktMoZAScS/6VPKIKtXZZhetZopNCc3TwB7ERhJFOrgOBMrQwe1ZZ8o3XFmTS0qvDPpqsegE+XujhT7uXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SJ0PR11MB4958.namprd11.prod.outlook.com (2603:10b6:a03:2ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Tue, 30 Jun
 2026 04:12:08 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 04:12:07 +0000
Date: Mon, 29 Jun 2026 21:12:06 -0700
From: Peter Fang <peter.fang@intel.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <x86@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <djbw@kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <dave.hansen@intel.com>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>
Subject: Re: [PATCH v2 08/17] x86/virt/tdx: Prepare Quote buffer during
 extension bringup
Message-ID: <20260630041206.GB1743876@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-9-yilun.xu@linux.intel.com>
 <ajzF3F5N8ix3SCzm@tlindgre-MOBL1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ajzF3F5N8ix3SCzm@tlindgre-MOBL1>
X-ClientProxiedBy: SJ0PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::21) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SJ0PR11MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: a27ac11f-978b-4035-d20f-08ded65dc024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|22082099003|56012099006|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: ru5wNe9O2mRcLoS7T4uMqo7KxdAl42mhypBaA+95xfLmFWmr3VAJY27nWzx5FlJdtzCyVNwNFDt3G77mnyzxrb3ShL+73HGhcgpFoNpKs+nat8jazJA8ziRBKQP1h/WfDzvbHF9ueDblw/KHjAQ4YS8m3frmD7ipa0dxCegcgmqwtcSNPS7OUvC0qNHanwPe8uFACVM30VwEcy6Nc0wJbbZkDsj6L0+is6yawClkPcnvrS8PleSLWb6BjGE9JzXn0Fazvizuqmv3LbFVBhlvOovwNtQN9jRQ2ntweRDPvAfPUs0m0yC1JhESK7fLbBB5aLbFe4I3cTgu8O+SQ1gLggbyfODP2RbmEik8nE3kYcTmfPR0wOp1hqa13i6NDCnEN/9pKHrFjR/OJgQpvAp/VbhcqRHQvwt0qz+1ovqke9zg5/7UTuOtJRILxoL/RhbPgqxmcEtiPARfd3kodZo3qdaxdNhfxI24h2o3BBTAcb+ffhyKRy5EaEftSqGaYaAU8uGA1HmgGYCdtctTdFmRaS6zPsxPD6Pg7z3PwWhUURwi/cxhxv7JIbDwi5ycO+igdgLzDc6O+ABqe8k78DmtQIHtjP27MhcPLqRKoBQE7yQHJkPxzZ9cCl7sYHTWPVWIrmTdZjW09Bfvh9lnS41biFE5ZFi4AssqULnFqbsolbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(22082099003)(56012099006)(11063799006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UpDCj0xX01R8KLTMvJjs8drW64m8giDewF7A962slI/7pBvtkiVVQNEbMF78?=
 =?us-ascii?Q?eMgNn0V3a8MD2MuDJEH1D8MkQbOQ5wChfvpqLYcGMRVtRDwo68b0bODRfk2D?=
 =?us-ascii?Q?pcJ8JEOVsgsE4LZrvoud2R4elU+87nsEk5uNdtptUsefNGSuB9Sjaprse+RM?=
 =?us-ascii?Q?08M/cPaLde0oo6CQqj3YpXm8B0LgOx/Hyll5FFNXmiAY+769ZeGjcPs4mGtr?=
 =?us-ascii?Q?tuxHxjJTYi4HTO5DCHxzYuLfBjbABfDE4YjN0gD6Qp4kXWgNjLVWXbpXHjUE?=
 =?us-ascii?Q?S2nB9XTLRKsy9gUBwSZabGDozUpZ5CMFKuzWsK9VvMr62AImwK2X7m5QiLo8?=
 =?us-ascii?Q?T33/ij8aawewSpDmvoJrMkVcsJ5q+7MMubJerZ9/oUd3aXjq27T6EApyzJqn?=
 =?us-ascii?Q?UKm8Q2fa72C2ZICsLCdxxyKf8QZkdNUGDQz2aPeoPNbLtOWwFc9iersDJfpe?=
 =?us-ascii?Q?2g8OCRMQahwIl7Q8vDPEt+owWRb2kumIfnTwBKZV+f4/XhEsfpHX/Zy40qZE?=
 =?us-ascii?Q?8jsemmNhEdvr4OsWyvB+c6HZ0lM0vdUO3dOzV27NeSiIeHHx8Z6bp2M49QLv?=
 =?us-ascii?Q?iEoDkijVdeWMX/icasgAUW007svebK2XTiNU6pfF0aaCbwx+i5gWHkxU5WEC?=
 =?us-ascii?Q?PKDTB1B4OFN9xMXbiW2AYASPx0eCkQ80mnedQvVwPs8L1tQ7/+crWg/2/bfq?=
 =?us-ascii?Q?5hhcZD6hSYGmeVscGNx8In+vteFpllckhpsGSmGuy9D6o15hE5OXrgE/T54h?=
 =?us-ascii?Q?8R4C9SslcYFI/AEVcTLuBB8z1yqGO4JS1wLPSo5vzsZH3W+Hfdjii3M4btmK?=
 =?us-ascii?Q?dCUM0AasCOHxhqioXiloNf8Hj7FDDKYA3CXrXoaXGdltxp84SrW/6KiRJ+vv?=
 =?us-ascii?Q?n33524Gf7wownC7tlnwpfK/kl7LXbO8fYsfWJEBJgZenvXFtw9220nYfK06A?=
 =?us-ascii?Q?UHyistPHcbvITfGfUVxqNW/DwK695vxmhZ7FpuUjd0yMXcZ7QNb86ESPVwpi?=
 =?us-ascii?Q?jlY99HWk4F/xocRpp1wJxZ4NbMKxtqvFBnBKKb5qQ6q966qAMsttIKCFl7e6?=
 =?us-ascii?Q?IGGJgI92JO+WPYzAUTN3RKhlAbYl1QpdTemP2KyDC7pLHrR5mreEMuiaZsVI?=
 =?us-ascii?Q?qgIH0nlPtV/u7YLSxeDCsoUsGGs6NfLTyeTs75zAtbGjSTEXg+9mraOu0MSx?=
 =?us-ascii?Q?wMlzkRd6lKfeP3GzB4adNZaw7GH4l4GQIrzTszb3sDm46p8o9auUVtLACVN7?=
 =?us-ascii?Q?2s5ab2N3knxVprK0wLIPOVCgiG5EUpl1AABeMngFhnUHxlpFa8G8Dv3PGggP?=
 =?us-ascii?Q?nt9V43TqeqtFS793kX0OduVAdVpSMAl14pvrUS4eeARuik9lKqL30eaLsnlS?=
 =?us-ascii?Q?sUt5hnXfLxW5nwxJUpq0tzfO4q5ZtpC+l/TOhATtCXij82YM2yg+l3980O4Q?=
 =?us-ascii?Q?OJJNIis8Lm2iQGj1jEGOrYJ/wa6TQnRsJaZRtB+HZn8qYkTM6QKlzOgx90Xs?=
 =?us-ascii?Q?7ll5A4BCyOzCc3gCeVS0cx5rskG00JY7QNiu9m8AHKITJrQTBOjHk3Pd3eiu?=
 =?us-ascii?Q?f6emGgmwgzrswAPyTnh3Uu1ihhOkqXpTB/1fGYHhDWF6xeUkRQyIOusrUjHA?=
 =?us-ascii?Q?fzqDg+dP8x+9/bbJ+yYNxg3chYB9PC1fefdlqlcwNtuvmfzHbvs7G4fh4K5h?=
 =?us-ascii?Q?hbHyAHjqQp7Juy0/Fz7bq/SiyzZ1ovOpfJOs/UeTWX6a3jACdqcq06FYsnIF?=
 =?us-ascii?Q?AL1mNkZ5ig=3D=3D?=
X-Exchange-RoutingPolicyChecked: Q0/+gSh+wdvB9Z82Bo0q8Bh3KDijQR1E1D9F/EK0TYZYCsUGeyJzWjwl0O5ghmB2W9EdeFi/ZM+tt04NMLurjWbXmPs1s68Mfi9e0Qat7kCYR/vw5g8M1CUt+W5SaQAofvlcb+iA6qD0BCPv0NPQcVcitxgG0Pey2USr4XNawL7NM/sWnsyJfgagSRPf/wVk+NqTn6kNmN7w99ag/gK2zs3YvFe9OeWJU+EOF13Knxr6HKmFsKkIWrvLq3DF1NAWgWNyqQiS4k1s6OAlKA0tY0b+wp2nT6e0/VJshvvi0rMRZY2HYYSPVyhXe3btfA9y5gaNUWm/ZttkZORsNESPmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a27ac11f-978b-4035-d20f-08ded65dc024
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:12:07.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pblqhezy3wH8/yui845Eq6DP8jl3DhCL7RCWmvOA3eiSWPx7c8dnoOwuVRGEEk0JgabC1txF/96MG3J9rF7T8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4958
X-OriginatorOrg: intel.com

On Thu, Jun 25, 2026 at 09:08:28AM +0300, Tony Lindgren wrote:
> On Thu, Jun 18, 2026 at 04:13:46PM +0800, Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > For simplicity, let all guests share a global buffer. Build the buffer's
> > HPA_LINKED_LIST at Quoting extension bringup. This saves a bunch of
> > va-to-pa conversions at runtime.
> 
> To me it seems the pre-generated parts can be made into a template that
> can be copied to an allocated buffer looking at patch 11/17.

Thanks. I'm planning to switch to dynamic allocation in the next
revision to make this simpler [1]. So the template will be the
HPA_LINKED_LIST node pages plus the next pointers in these nodes.

[1] https://lore.kernel.org/linux-coco/20260626095833.GB1600180@pedri/
