Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD828C2BF;
	Wed,  1 Jul 2026 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890836; cv=fail; b=rTbilxBUM014FtPshkuN7WLyboCVl1naflWbCD7fHVgnRVNwgqqzZBuAFQuVtCTh2jjMd8FYSUSoQVjGay6d8dtdPvVbUlsTah+cbnOpdLw1kFSCioIzW9h/iAaZSmF+sjDQSZPuvoe9qXmeyHsy+KMdOR7mn7PvTDfFTNjg8Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890836; c=relaxed/simple;
	bh=R3y71ljgnOapwYtnlk5cZC6OFia8r73kSl7UDHRcUac=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CW77be8vOSJ9h6H80Dk4zzN2GwDsn/cfhAPevpnt58k3HkKI0vDnTH+fRe3Vho9gTpBLuHD7LJOqT13SiVOtEiaJKqH9/OupQ5aqATMRWByEin0OhBovHpPErkWO5LpwUtLIRYHuD7ii3Y4Hd0MZEX5HN4bY1E50mWe89TP7+fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kq9w4W4r; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kq9w4W4r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782890835; x=1814426835;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=R3y71ljgnOapwYtnlk5cZC6OFia8r73kSl7UDHRcUac=;
  b=Kq9w4W4rdO7Bpz8LlFI0pUykt1TRRyT6uOenxGHOW6qebLA4EDWmBnjg
   7ZXjHWTSl99OX+B4l5Hv9rUtaAf7TYB/dTI5IboAHkDRCADaq6czYvsSa
   bIVxHoAygprEkxnljlWEN6S1+LjvbSu3h3c6KNLnZiuxnQxhgl+YP6nSY
   Kpz0Faxb2LUagi036m5PeVNkLNsHsjUG3InTXOaZBxnl3GCfTxlmFo04L
   YGrkbGqKnV7XiOMxhUx/nTFdM6ebP1agretdL71BVopVJ6iSMxoXgXLWI
   SCTYKtL59jRX+2rxEVzvizRrghk0V+yvoUZLZRPzlRmBCXladeIMCYnya
   w==;
X-CSE-ConnectionGUID: UBlVk/SST9i0Du4UJcPgwQ==
X-CSE-MsgGUID: C8nxOofrTJajja4COlnr6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83645923"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="83645923"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 00:27:13 -0700
X-CSE-ConnectionGUID: OOnEsiH5Qm68CSNDy3uFNg==
X-CSE-MsgGUID: zl+ZTxuTSz6dRPLdCZxkzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="251434759"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 00:27:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 00:27:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 00:27:13 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.42)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 00:27:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFCwP6dvbwmy6TNY8ExKL3A7rt48+ozYJdHSk/8xbU/Sb8COGTUCaIc96G4vjk3MNsyKnU49aoiL9O9qMlraHTwFsGTMjmEaV8Ndd4LQxUASwuxVd4yOQKYZPCIRzkfRajnEiHq6hvi7+qvMlSvFEtL7mzWqL+Fv5EQZ+TNSi1ZcbvVgbPsK3erPt1me/44KaYtH+KIWT4fhCYKtUTF7rG1G37MhUQed1JS4FHrXTX6ukV2dxWLGPvvM7RB5enwS6WEuvcgIuLd6mux3efu6baDQCdJB5d7v9MVkEoenckkGC0jaSAw4Y5wp39Y2IMjb1q8RfvYwOsEJAY1g912qOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8Bc2LWXtPfVN3rl/s73qVmGT78tksUUdgk+Ksdg+ek=;
 b=WtP5TaxJ8SJPpyBICT6GJW22Fg1F9kSfLFl4RqpjRGfWw75MQBG4n2nO3EiMciZxiAvDWjmWAoF1L2FHVWykMBXkj8bH8dkK1sAUdYgIG6EgmgCEKF4+jHCUSff/YQhXAmvCYY9Kr+hlb6w6LwLYovuqPZLx0s297uSxlqdjJ+4Pv02F8vJIZitw6AUnmvMY8TT06CwflYLerhTvfs8eUjG36Gu8rgvnVEQmXH/dbvSREBv2U/iV+bcUZUmFhcQOTZVDI5g3tGyVFsT+6D/Y13SL7N4uhBrjSzvWfKIYKahmhyKJp/7GL1MIRTtQYXpis87Y0dl9G50tBwt7Iq1DRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by PH8PR11MB7094.namprd11.prod.outlook.com (2603:10b6:510:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:27:09 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 07:27:09 +0000
Date: Wed, 1 Jul 2026 15:27:06 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Sashiko Bot
	<sashiko-bot@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>, Ackerley Tng
	<ackerleytng@google.com>
Subject: Re: [PATCH v2 2/2] KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL
 INIT_MEM_REGION source
Message-ID: <akTBSsrg2N7chtZV@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260630213711.479692-1-seanjc@google.com>
 <20260630213711.479692-3-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630213711.479692-3-seanjc@google.com>
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|PH8PR11MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbdb0cd-4d3b-4186-b9e7-08ded742291d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: bo6dMXWLU8on5pscqM/r7efqYFWR8jtJAx2zT8JQsfZZGMjIsTznnNBB0IrGgW/BCnMMUwgrpO79eMDLGKTeun3l5pyCdBdM4rEGZwawzPuyLY+4fPq/aD3cVlntxEpGsVneUITclkDaTpRU8d2HX3ve4m/8B7QwDed1FT6vYQKawP403ervB3YFbt8Ac3DkZC+bU/NEJq5ke36UAXvX4nDu0AvukSB5xkKlwppymZkT+HMMVwNLTj8Ey0eMEn/xI1MIPIM7gj963kdJzq/9rTJT+WRgNPvQkKYRhLMWO3wSDWyJB2gebdAi4e3bj6zIFi8KmrosD3knkYhtU4nBLm1bzEHMjAz4A8mTuilwW/rVtOJdFcDZjnNAgXRa9jaOTuXmkmTapDgVpNva2S2w/lgX60elEpAY5lo08ho9NK1gcRzS0xKNBc/9Xgv8P0t6ywUuxMjvcfGLRRduhNyXCPDOpFuYBonL3mxfB4CtrAeze4JxJxBquy/Vve3cEAR2+JSkWlLNTa84MnhSTvgrq6jErsE/yWQANno/Ven4BZ8937CeJhthaWlO5150fWlVjqiepZt7et3c9A0IUCj2J/zbXUUR2LxJDw1APg2lPQIEN2SU6e+Gz3LKF4q2bf4w6oq3zT9WbGMxOiHUF/HIA6ehCSWIRakLpQI/SsS1saM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+eMqebEuPylAy8rUll9AQuTVonYwGRBOBlUAXP7RS+ZPgRegfL4wEL4+jhBB?=
 =?us-ascii?Q?xcduufZXcnjOi7/w1USVu8B3kwrZFxQSwP4HTy0c30Lz3/qIH2Twhq+XcIad?=
 =?us-ascii?Q?VUc5ZFcPpaVk6YqT/bhIQ2Tsb/fyzi5iIl/1739Y0qFms/lmCSU5AO7fvo3k?=
 =?us-ascii?Q?ufT9LC8yUmHxfk4yPmJA2KN82iu/O528dGPQQhXp8/82yDDg/ELfF3ebY9Qd?=
 =?us-ascii?Q?+BRQBEWZvZVEe03MvSir2+pK9AJc0fl9kIEU/wOl4NESNelaedHYLbuT3RCP?=
 =?us-ascii?Q?XEWpMjKzRGzGO5IhOqu6qGOLfFWPefjPVwzaWovOECJqTjY3b1vV7HHtJt6S?=
 =?us-ascii?Q?nYC7TII/4n+vJd8kNYFZFXJB4OmV0ofyHiuDEDgSdvYzak3ACCiv5q7acnmR?=
 =?us-ascii?Q?UwtXYS+vp5o25rK/Za6s1mmGAATCI+3TdvXAfxgQThDy6Xv4fvEIRBfqe3y2?=
 =?us-ascii?Q?dCxHSKaHMvHbDh1hw2ykhMcDUZFZym0EIpsu/o0sG9FUcLmD+Zg9u+gJn5cQ?=
 =?us-ascii?Q?yIGJw6ZIZOCmctQErho1CfV3kixe/D/MHwBEg3ly6i7/yDSiYmGMIHjZYi6c?=
 =?us-ascii?Q?aI7G1777Cfn+24GZYI3INv6yD/DAl9KD+l+nQvG6MtfRrdfLu0K8XY/fzoHg?=
 =?us-ascii?Q?Dl6ea4xof5Wg6wBu9a1cLt921C5bq3k9NEEq3v7sDX9TBjYNRJi2tI0WxWSz?=
 =?us-ascii?Q?M9a3DDHWCG3xA+C6YgcGhzn8bH6mZTyv3hGhijYoVDX9B2VlyNKxQNWL89bV?=
 =?us-ascii?Q?YK5ptuTvnN7uf/sTbFjl4Hipgwl3zEXreu+lhzRohm/G3qWXf7Z4TMb0rXxl?=
 =?us-ascii?Q?QZQ8aEGav0Hx9OiEtC16ph+oFBXtepMi6wkD/w+9ba3Q0VPWGFMHqfvMB+kY?=
 =?us-ascii?Q?lhH1F767itS6i/yePz1i5yu4T28BJglnORYzaXg2d+8858PrJ1SQ7d7B7Eqt?=
 =?us-ascii?Q?KCRwbgdm65AlfgmD/2T384dGffM9STayICUvIcIUwOCo7DasdmJQzNAgDfqz?=
 =?us-ascii?Q?C4aHGwtrm5pr2Mr4MLBTEGoJLTfpLQInHiyIhJXu4OsgyonG6Iw7Fo75LyCQ?=
 =?us-ascii?Q?1nVm+E3FUJ1p3GylMclr9nWtA5AYAxx27BSJy8L4svuNv0mf5pozIOrwrETm?=
 =?us-ascii?Q?XGHnD01ldqKi3gUv/D/oz0QN/Q+dmxIi8q4LQKlxyIldjzK7z9z61MCPnd1o?=
 =?us-ascii?Q?W/DuamxQjXqjXDMJPfXkdIkg73E17pfa1Bb4RpdGhKVEu548ONo5ZE3KGawm?=
 =?us-ascii?Q?00osoyEd7ElsGtD1vumITnrGajvstbd8M3Mkk9sVc6xxY7VU1Fxlgh83KMXI?=
 =?us-ascii?Q?Xxagtm+bPa9UcS0nYeIQWj6tHbuyLjE16zgE0yYeMFHx/o6O8s5HRoRs2NuB?=
 =?us-ascii?Q?KJ26CW0HLtLhaFK3YzjBjFIUq6aVpJJT157kNfn+QG0dG4tOoTXtPIlv09T5?=
 =?us-ascii?Q?m0WQnrLEoNABu3GhRSxV5TU0tcVZ+ZHN6+gqoWdLpSnKqSyLQZOI1C8oeawv?=
 =?us-ascii?Q?9E7Yn6lXsy9IGAne9vZ3g/Q2dUkx3GpgY8fNDImrnqGpREuMgj3Oi73fVGQa?=
 =?us-ascii?Q?7HEmuSDtHkneXd3AwxnY1a8NdQRJlFNfLLnreawbWA9Ein8duax5l4dIWVn+?=
 =?us-ascii?Q?YCGoSM5NzGbNiDxuW3Wfuw6Si47jIroM6WG4kCl9LHczNnRoHwocXBBvHwEk?=
 =?us-ascii?Q?gr9ayJ3muQlAfWqn24rhjMO4D9SAHPZeklpg7hV8YUVsNQfIT990BHd6zXyW?=
 =?us-ascii?Q?F4AtMLrRlg=3D=3D?=
X-Exchange-RoutingPolicyChecked: oxoih8WNSVADjq/5Lg1YuRC5nKyg7nbRQkGdpOPkaKtnZoXlbsTd0dDEuwp7QnP3b53voAIyw9SLsJg5J2WRBhjfenWoZuB6tiaU7d3EIL5zBHlAbPQxZ31zYok0fYdAEk6VtbykKFZhnY+R0VXc/+XNFE/1XPx17FVlJat81Ajl0FFQU/dkh0RkK0dbAmUvQDW8AgHngZ9JSEnkwfr/tImq8vRaJ2iNA3bIAi3ga6MfSCU/Z3uxXUhZNjxU2PfUapQzQD/GeIXo1Vqkjv1ujP+IoPTIJu94tAi9kByeoTteGUUZJTtlfeRTnWVqLTofO5fe7defEqZedem/wtxyYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbdb0cd-4d3b-4186-b9e7-08ded742291d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:27:09.3909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pK1lQYwOYh1+ZRnaKqznso+NieKR+UEi8KJZSQCo0kbj3JcLQA+Uk6rNwU1X/9GaraLu50dsCyeTz13NI9czJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7094
X-OriginatorOrg: intel.com

On Tue, Jun 30, 2026 at 02:37:11PM -0700, Sean Christopherson wrote:
> Return EINVAL instead of EOPNOTSUPP if userspace attempts to pass a NULL
> pointer for the source page of INIT_MEM_REGION, so that KVM's ABI is
> consistent between TDX and SNP (for LAUNCH_UPDATE).  EOPNOTSUPP was chosen
> to be a forward-looking error code for when guest_memfd supports in-place
> conversion, but even when in-place conversion comes along, it's an awkward
> error code as KVM is deliberately choosing to disallow virtual address '0',
> which is technically a legal userspace address.  I.e. it's not so much a
> lack of support as it is that KVM reserves address '0' to simplify KVM's
> internal implementation.
> 
> Opportunistically move the check so that it's co-located with the other
> checks on the userspace address, and so that it's more obvious that a NULL
> source address is explicitly disallowed.
> 
> Fixes: 2a62345b3052 ("KVM: guest_memfd: GUP source pages prior to populating guest memory")
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Tested-by: Yan Zhao <yan.y.zhao@intel.com>

> ---
>  arch/x86/kvm/vmx/tdx.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index ffe9d0db58c5..b0ec054732b9 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -3198,9 +3198,6 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>  	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
>  		return -EIO;
>  
> -	if (!src_page)
> -		return -EOPNOTSUPP;
> -
>  	kvm_tdx->page_add_src = src_page;
>  	ret = kvm_tdp_mmu_map_private_pfn(arg->vcpu, gfn, pfn);
>  	kvm_tdx->page_add_src = NULL;
> @@ -3247,8 +3244,8 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
>  	if (copy_from_user(&region, u64_to_user_ptr(cmd->data), sizeof(region)))
>  		return -EFAULT;
>  
> -	if (!PAGE_ALIGNED(region.source_addr) || !PAGE_ALIGNED(region.gpa) ||
> -	    !region.nr_pages ||
> +	if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||
> +	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages ||
>  	    region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa ||
>  	    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
>  	    !vt_is_tdx_private_gpa(kvm, region.gpa + (region.nr_pages << PAGE_SHIFT) - 1))
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
