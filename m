Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECDB3B0AE1;
	Wed,  1 Apr 2026 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034852; cv=fail; b=P5Ivy1tD2E2UpV3tRifrKCvbUqUWpywKnAZOCU7oe8YnDVU80pfPkGCmE7MdH0E+eG5YNctkBcmWfO+xnqQXMK6jqI0z3ONwseW5ED8bVeEgtBNzmPbdLfuZtZkfFedzJ+vn7VVp93D1SOMk4WhY/06R6rRv1rSMLNmOYP75gdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034852; c=relaxed/simple;
	bh=KhStIht+yVrifXQqNzYRbUiu7XFeiiDWl86n8V3bPq4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a5fRWiJ9ueLuT04Yr3w0qlS6XVW3WeG3fyP8+OR9wv4tfF0rVRQ/W96JGFF8nll7eUVTiT83ftsxWXNmYNCtZh1o8bV2UWzw8yfUOUGyJ0rIu9kfvG7fplLZ1u5XdxvKKERr58ZKirJ86CC4125uxxY8p4j7pqRBFk7yJsjUwOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faUA0qqG; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faUA0qqG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775034850; x=1806570850;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=KhStIht+yVrifXQqNzYRbUiu7XFeiiDWl86n8V3bPq4=;
  b=faUA0qqGKIy2Yxf4EdqTFXECin4Ttk1Ik5t2/vCcOJKblsXEpAUTdpkR
   xlvz/xersIb3Rcz3S0UDhSJMTZ870/WxkLy6RPAQ/wii5O0cvNWSrc011
   Tp6+TzU1FTvcWZj13kY2Hb96p3BwarKLbWry4iIvzql2xbfwTuqFa+Ttc
   vmcRU4bCPxjbN7pFsQOaGP0JoKjSR1s8sy/2awbBzJ5QHGqUtNaEAf/9R
   sPmFPFpXYQj2uczLb4qU8pntpMCTMgKpQ1WZ6ECNKZlh39hLu5QX2BMEY
   hKPOFbn4zP8trr18Z63IxhDG7ckFk/30tglz17MWwEifzxwG5EWwavfD2
   w==;
X-CSE-ConnectionGUID: 7X//dRgaRk6ImC9yMV3aog==
X-CSE-MsgGUID: 5GtVkRJfQEO0pbywDuGQqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75105854"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75105854"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 02:14:09 -0700
X-CSE-ConnectionGUID: tnTQpW1yTJ6q38k3bdzq4w==
X-CSE-MsgGUID: Ly1rwSCGQ9KTLUGby4J1HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="230679628"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 02:14:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 02:14:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 02:14:07 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.50)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 02:14:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Su5uEn9h4RVGgS5ssxYMxtOilenu7DcZw+31Pb2eqpFXiw7aRtx6pEOWSNU928SAggioEd/Jtk5AuvsnAmvJ2bIqzTr9qmQcaegkOFlyL7v2UW/BSwL6+Umssd3UnYHXK5vn7T4aTGzQAJHqLWJCer0l94HuEKXkRPp4e84XgurSPZHIZsNQXM+F98PPtCk3RTeAmr4GifD9DFyUjRmotF4y8svhDi522EPMjyNY+MEraGHl+3D6ObpMi1aIiBDcnV/YBFiF3dooDnz9QjLhAuV0wKmSjZnzsq/76EeEYt3X8fYEvpLOxGmdMAfM1usmtKVseDW0FFR0GAlCs+lmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HWsOmpw5HeRpKJdFPb2Gv2InYpSfit1Zp+Rhji9AJU=;
 b=Ne1lxJdh3NCWbEgi19uTGTgNZ9Uv3cDRHWqijtmeCsLEDgtnJH87QXogqEy3pTyvags+6rQg21kMmh9nrZWwf9/Vx8XOtXwV5xww2q0m3p2VwUrnru7E+6ItZLEYxGMOOpIj/9Nhk4w3JeI8/qm0SiU562TQDmApySEYTpR4bb9oVYuh0C+iaCd6SycHiTiSlNPexjrf5nnwvmueQCGje7HIQXpQLDwSBZMdPDwcfBo0BetfUkxTrGxwy9Q9wuZE64OFtAs3tD4HmCDH2Bx+4pToxACjLuxALPBn5oFpX4t2AjY39S68MfdK1OFGAS/tvOS4nHDcbQaIsiTuc1ZPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DS4PPF07B018B9F.namprd11.prod.outlook.com (2603:10b6:f:fc02::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Wed, 1 Apr
 2026 09:13:53 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 09:13:53 +0000
Date: Wed, 1 Apr 2026 16:34:20 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kai.huang@intel.com>,
	<kvm@vger.kernel.org>, <kas@kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <dave.hansen@intel.com>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Message-ID: <aczYjEVkva3zOpwz@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DS4PPF07B018B9F:EE_
X-MS-Office365-Filtering-Correlation-Id: efd1cbb8-3fa0-46cd-0040-08de8fcefee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kxbO5KEU5O42qYf+XsFoekjpnBeNxamg55QjwLlbTuQdotwQzTbjZV0IpNobzP1iE0sCQbp27brvVPX+d6W8cAS80Sy8jFh6O9uRiQsL6zwHX2re3k3zZtbF/XQCefPH49nVYW2Y9mNJbXtGTWbElBqHPikJZ6m/jrFP3NTKLzIWh8Tp/jX209E1PBWdFSgwglY38rLqs1WFnMjKql+PvHH+w87c1I5/Z1T4CFh5/hk188bBo00YxRKMy5oFUmLfoqdNuT1cmGa2lZ73Z/x3giOag9i82px4UNZ548EcJ/Ogha4nUpF0GqoDJjVba54JqnicU75DR3U9FVjRKc4+Zsttel9Q51ubIGaR0bftRUofPSSAJgsWPq9+uZOBF9PEQHUkXvqsM/JOdKmAh1tVc28uFW1ZCDFF46F3slhIL+BcX2bz+9pdw3gYdjzzy4RPfAxeGwlI/KWVYCwkJddlP1E8wgyxUZl5ISpI3EdpCbHzh0NuQgk6SWPEAJCWtalqXQ8gjBIRfeozbVXIsMDcV7AXiNslCyCgt43UWR/DIoaPyA56Lli8kLwKFMBmBnbWEYrBIrXn0cY1UTbRQn0+nje+bu5kWXTdOS5Pp6Z2gsrJoQiYmTqkNX5i3bEuZK9sv5y+1iTZrEj7dXSSAXl5olIkiGUV/1xD/pRx1cqmzU/daRaY2mQLcqNGABy/pzdW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ki0kO6x95VMVXvgJJsXtQHcodVpHTbBPSvDXicu/dvPd9CHDrSrfCh2Hf2fT?=
 =?us-ascii?Q?Q3H+QSzxUE3QfgRZoDXIziLpXDP7doQpIbe3AbsyJYnml/ymsHeJEsOMtm+k?=
 =?us-ascii?Q?Zd5MwfOf35ULSg1FAKvbw2dUQGDhBnwnHLCs4iN3siJORUFLst6aR/KyKixS?=
 =?us-ascii?Q?69Jn4HYqqPKrUyMbThW8dchThkTJo34CC6Zk7/Uv3pN64+jy9To1Xu6MrG7Z?=
 =?us-ascii?Q?fQ2B8wGk9WGkSR4bt0fbGTYOEdyRVPQV+BmT1uBJS8n/51zW/gqOEv55aKTG?=
 =?us-ascii?Q?SY26jYKX05FLyLJDEjeYip/jKJfFYY7OOfKmFPt5gjWdlfEDkYCSoDOt9NuG?=
 =?us-ascii?Q?thEZOdJsnZbg9H+2oyDkXgbN/sHrwM/BIpGo04HE0VGoaEFGCkwz9gNqdmU8?=
 =?us-ascii?Q?jiRb3/amE0GCD2DdskDywSc6ERv4baJx7DpE//h78sRVBGRXc2fGarfp8Z11?=
 =?us-ascii?Q?52xKIpBCl5SrT1dID2q4Bu8L9in/O291y7214x98uKdgifJmhkMlS2KA6Y6C?=
 =?us-ascii?Q?sf/or/amzeWmM3vJRqr1//DxBVDEQBC1CFuFLCyvfsjXlJD3Kts1yCGZa0SG?=
 =?us-ascii?Q?r9pMqOLUpus4j3o3RMn9aWIN9+40k5LV0Tnlyjp6x3YeQA0NBKa8P3k/6HQj?=
 =?us-ascii?Q?kVnfl0FvpLWVW6UpKXPm80bRipWzN3OEqX/6hTBhn6xr0Uxz9T5chhWBGpEz?=
 =?us-ascii?Q?6TZNxy7beIkB1JbFsPMZarFspqVsvz+go0cIKMvTFdXbgYDSxQeTnLl5G5Bs?=
 =?us-ascii?Q?TXiPWBkZw+mq1blVnAp2VBe227Di4Ldivd1Uy10ilaDORWXIaZnlzc7whqe2?=
 =?us-ascii?Q?F15aTcG7GjehpmdwWQqT+Am26bV/vr2oMrOH4I4LfA7d8c0SCTdAzz/Punz+?=
 =?us-ascii?Q?1XKaAgSK+zRv/VL1NbsF3HoSgIwWHJrvc5D9PqMV9ItKKG4t9gAtcvnCgRi+?=
 =?us-ascii?Q?IKbUwwIwbFzIuhlFFPRNY2KICYMDRO9je5N2+zZOL3KBu23C1zssDw9Xv50K?=
 =?us-ascii?Q?RCTgZ7GXlZpJ5HQ4HNUbEAUDKCsKB5/UzbHjX3iCoYiKO6A15g+47P2xJAt2?=
 =?us-ascii?Q?fR8Lz/6Kd/2sqf/SlbDKKoF+p0BUxh7bjZ1vraom+5fYwBHeY+ezZqiafW3v?=
 =?us-ascii?Q?J4gHn3jnzbgdc42MFxwlTl9Hpv+78t9JPje6zZc64EYqH1Dks1zBhdwf2eue?=
 =?us-ascii?Q?L938Hj2TMVrBNFuOJI6Fxg2+EutuGLh11GOPzdWWo/eZhZVL0bbNInNbhPNi?=
 =?us-ascii?Q?YvdKgGj2O0M+61vepH97u4rSYfMP97uZM26hAGP4fnLyN5hHSIXcQ9TUVDB6?=
 =?us-ascii?Q?6e1JjYrNZ2YG/a3C83bLva5pRgsvv+M4E7m/WSVAzaOews7hIFPt8JcBqlga?=
 =?us-ascii?Q?S+vnCvUghH4NzdKzhhUOmxCaeWRZvvYHCq9w1bM5C23NIKFFDavPijZjzmSK?=
 =?us-ascii?Q?Pzs4wKgs33A9gxCIXR+wUuHsbiQy0/6JuIvHnGIz4Mrle9WoX/Drkni40PGM?=
 =?us-ascii?Q?gXzIA6jg6uQhXikKoQ4ypq+b4bMSJy5XChs1+JAUrYgW2KzzLeLR5d/dCxyr?=
 =?us-ascii?Q?a9rGJDp2hGxFRj353PTLFkuwC+P22D43322ptCXYQG2vmoToX5MJWGiCunWG?=
 =?us-ascii?Q?bfnuM07wLumLSJAjn/Qu0B7WK/gQKZ+KeYJR565nsbYk9hKIEUa9ee0nmI2N?=
 =?us-ascii?Q?a0ytyrSDn/7hUHWrmtIcFXnHpV+dnj1Pd2Vaj/3C9ZLZzKxjcolR0NUwmDmR?=
 =?us-ascii?Q?EPIYlzUh6w=3D=3D?=
X-Exchange-RoutingPolicyChecked: jjuAfa30FfkAbKl2gbSlOBU0DfRn4X2Pi0J88n7iyRseTRzzaaJDCLJuoL/GnyN+/R5tQ3n0ow68uBkZtpE5JuWny5rIs740Ae0D8D5Bdmh24arCoJYlRSGmpckz/6KoKr0kaQHfihCc/2jBsLSFaDo+fr+LjT4kaCdfo1ZOL5Gt9qArkGr8DBlYRxvspHr6Tn9nU+TWEgriCBsDezAXu3fo3oQfve5XBuFLI+StyFVZpkk8NRNAWr7o8eXdEBXuSa19bRZy0pF445dyMXkTxmiuY/F+OrUZKBQbHse5O1m/RXGXOuIjeLGKBxYK84o9Jws3Yse/OaWt9lbW9xOB6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: efd1cbb8-3fa0-46cd-0040-08de8fcefee7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:13:53.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVtI2UpZrfIZiqZ5dpojxgatjuX9qk4ai/t0j7lgbV980HER6KUdr6bZvcXeUpXFmGK7ESkl8JipbbfMFBMJtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF07B018B9F
X-OriginatorOrg: intel.com

Below are responses to issues reported by sashiko. [1]

[1] https://sashiko.dev/#/patchset/20260327201421.2824383-1-rick.p.edgecombe%40intel.com

> @@ -627,21 +615,41 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
>  			       "a temporary frozen SPTE.\n"
>  			       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
>  			       as_id, gfn, old_spte, new_spte, level);
> -		return;
> +		return 0;
>  	}
>  
> -	if (is_leaf != was_leaf)
> -		kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
> -
>  	/*
>  	 * Recursively handle child PTs if the change removed a subtree from
>  	 * the paging structure.  Note the WARN on the PFN changing without the
>  	 * SPTE being converted to a hugepage (leaf) or being zapped.  Shadow
>  	 * pages are kernel allocations and should never be migrated.
> +	 *
> +	 * When modifying leaf entries in mirrored page tables, propagate all
> +	 * changes to the external SPTE.
>  	 */
>  	if (was_present && !was_leaf &&
> -	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
> +	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
>  		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
> +	} else if (is_mirror_sp(sp) && is_present) {
> +		r = set_external_spte_present(kvm, gfn, old_spte, new_spte, level);
> +		if (r)
> +			return r;
> +	}
Issue #1:
"If a present non-leaf SPTE is replaced with a present leaf SPTE, such as
 during a hugepage collapse, the first branch executes and calls
 handle_removed_pt(). Because of the mutually exclusive "else if",
 set_external_spte_present() is bypassed for the new leaf SPTE. Could this
 leave the external S-EPT out of sync, with the parent entry pointing to a
 freed child page table?
"
Response:
This is the page merging scenario. The mirror root does not allow huge pages yet,
So, maybe nothing is required for now.
After the basic TDX huge page series, page merging is also disabled [4].
See more in the responses to issues #2 and #3.

Issue #2:
"Additionally, if an SPTE is atomically zapped, is_present evaluates to false.
 Because tdp_mmu_set_spte_atomic() lacks a fallback remove_external_spte()
 call like the non-atomic tdp_mmu_set_spte() has, does this mean the external
 S-EPT mapping remains fully present while KVM marks it as non-present?
"

Response:
Up to this patch, this seems to be a valid concern. But atomic zap on the mirror
root isn't allowed yet (though warning on such case is dropped in patch 5 [2]).
Centralizing atomic zap to __handle_changed_spte() will be done in patch 15 [3].
Maybe move patch 5 to after patch 15?

[2] https://lore.kernel.org/kvm/20260327201421.2824383-6-rick.p.edgecombe@intel.com/
[3] https://lore.kernel.org/kvm/20260327201421.2824383-16-rick.p.edgecombe@intel.com/
[4] https://lore.kernel.org/all/20260106102024.25023-1-yan.y.zhao@intel.com/

Thinking more about centralizing TDX hooks, could we be more aggressive? i.e.,
let TDX just have a single hook set_external_spte() for propagation of changes
from mirror page table to S-EPT?
(below change is on code base with TDX huge page support).

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 13910d9af03a..d9404aeae5f3 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -95,7 +95,6 @@ KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
 KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
 KVM_X86_OP(load_mmu_pgd)
 KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
-KVM_X86_OP_OPTIONAL(reclaim_external_spt)
 KVM_X86_OP_OPTIONAL_RET0(topup_external_cache)
 KVM_X86_OP(has_wbinvd_exit)
 KVM_X86_OP(get_l2_tsc_offset)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 76f119a6412b..b722cce0b994 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1857,11 +1857,6 @@ struct kvm_x86_ops {
 	int (*set_external_spte)(struct kvm *kvm, gfn_t gfn, u64 old_spte,
 				 u64 new_spte, enum pg_level level);
 
-	/* Update external page tables for page table about to be freed. */
-	void (*reclaim_external_spt)(struct kvm *kvm, gfn_t gfn,
-				     struct kvm_mmu_page *sp);
-
-
 	int (*topup_external_cache)(struct kvm *kvm, struct kvm_vcpu *vcpu, int min_nr_spts);
 
 	bool (*has_wbinvd_exit)(void);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 2f6bfc875de1..9b4fa5b31f23 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -461,9 +461,6 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 		handle_changed_spte(kvm, sp, gfn, old_spte, FROZEN_SPTE, level, shared);
 	}
 
-	if (is_mirror_sp(sp))
-		kvm_x86_call(reclaim_external_spt)(kvm, base_gfn, sp);
-
 	call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
 }
 
@@ -563,9 +560,17 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
 	 * changes to the external SPTE.
 	 */
 	if (was_present && !was_leaf &&
-	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
+	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
 		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
-	} else if (is_mirror_sp(sp)) {
+
+	if (is_mirror_sp(sp)) {
+		/*
+		 * Can also propagate changes to remove external pt. Since this
+		 * occurs after the call_rcu() in handle_removed_pt(), the RCU
+		 * read lock must be held.
+		 */
+		RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
+
 		r = kvm_x86_call(set_external_spte)(kvm, gfn, old_spte,
 						    new_spte, level);
 		if (r)
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 32d0c206ade6..cc03b9c7838c 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1965,9 +1965,13 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
 	return ret;
 }
 
-static void tdx_sept_reclaim_private_spt(struct kvm *kvm, gfn_t gfn,
+static int tdx_sept_reclaim_private_spt(struct kvm *kvm, gfn_t gfn,
 					struct kvm_mmu_page *sp)
 {
+	int ret;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
 	/*
 	 * KVM doesn't (yet) zap page table pages in mirror page table while
 	 * TD is active, though guest pages mapped in mirror page table could be
@@ -1981,8 +1985,10 @@ static void tdx_sept_reclaim_private_spt(struct kvm *kvm, gfn_t gfn,
 	 * the page to prevent the kernel from accessing the encrypted page.
 	 */
 	if (KVM_BUG_ON(is_hkid_assigned(to_kvm_tdx(kvm)), kvm) ||
-	    tdx_reclaim_page(virt_to_page(sp->external_spt)))
+	    tdx_reclaim_page(virt_to_page(sp->external_spt))) {
+		ret = -EIO;
 		goto out;
+	}
 
 	/*
 	 * Immediately free the S-EPT page as the TDX subsystem doesn't support
@@ -1990,8 +1996,10 @@ static void tdx_sept_reclaim_private_spt(struct kvm *kvm, gfn_t gfn,
 	 * TDH.PHYMEM.PAGE.RECLAIM ensures there are no outstanding readers.
 	 */
 	free_page((unsigned long)sp->external_spt);
+	ret = 0;
 out:
 	sp->external_spt = NULL;
+	return ret;
 }
 
 static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
@@ -2045,10 +2053,17 @@ static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
 				     u64 new_spte, enum pg_level level)
 {
-	if (is_shadow_present_pte(old_spte) && is_shadow_present_pte(new_spte))
-		return tdx_sept_split_private_spte(kvm, gfn, old_spte, new_spte, level);
-	else if (is_shadow_present_pte(old_spte))
-		return tdx_sept_remove_private_spte(kvm, gfn, level, old_spte);
+	if (is_shadow_present_pte(old_spte)) {
+		if (is_shadow_present_pte(new_spte)) {
+			if (is_last_spte(old_spte, level) && !is_last_spte(new_spte, level))
+				return tdx_sept_split_private_spte(kvm, gfn, old_spte, new_spte, level);
+		} else {
+			if (is_last_spte(old_spte, level))
+				return tdx_sept_remove_private_spte(kvm, gfn, level, old_spte);
+			else
+				return tdx_sept_reclaim_private_spt(kvm, gfn, spte_to_child_sp(old_spte));
+		}
+	}
 
 	if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
 		return -EIO;
@@ -3915,7 +3930,6 @@ void __init tdx_hardware_setup(void)
 	vt_x86_ops.vm_size = max_t(unsigned int, vt_x86_ops.vm_size, sizeof(struct kvm_tdx));
 
 	vt_x86_ops.set_external_spte = tdx_sept_set_private_spte;
-	vt_x86_ops.reclaim_external_spt = tdx_sept_reclaim_private_spt;
 	vt_x86_ops.gmem_convert = tdx_gmem_convert;
 


> @@ -708,18 +698,49 @@ static inline int __must_check tdp_mmu_set_spte_atomic(struct kvm *kvm,
>  						       struct tdp_iter *iter,
>  						       u64 new_spte)
>  {
> +	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(iter->sptep));
>  	int ret;
>  
>  	lockdep_assert_held_read(&kvm->mmu_lock);
>  
> -	ret = __tdp_mmu_set_spte_atomic(kvm, iter, new_spte);
> +	/* KVM should never freeze SPTEs using higher level APIs. */
> +	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
> +
> +	/*
> +	 * Temporarily freeze the SPTE until the external PTE operation has
> +	 * completed (unless the new SPTE itself will be frozen), e.g. so that
> +	 * concurrent faults don't attempt to install a child PTE in the
> +	 * external page table before the parent PTE has been written, or try
> +	 * to re-install a page table before the old one was removed.
> +	 */
> +	if (is_mirror_sptep(iter->sptep))
> +		ret = __tdp_mmu_set_spte_atomic(kvm, iter, FROZEN_SPTE);
> +	else
> +		ret = __tdp_mmu_set_spte_atomic(kvm, iter, new_spte);
>  	if (ret)
>  		return ret;
>  
> -	handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
> -			    new_spte, iter->level, true);
> +	ret = __handle_changed_spte(kvm, sp, iter->gfn, iter->old_spte,
> +				    new_spte, iter->level, true);
>  
> -	return 0;
> +	/*
> +	 * Unfreeze the mirror SPTE.  If updating the external SPTE failed,
> +	 * restore the old SPTE so that the SPTE isn't frozen in perpetuity,
> +	 * otherwise set the mirror SPTE to the new desired value.
> +	 */
> +	if (is_mirror_sptep(iter->sptep)) {
> +		if (ret)
> +			__kvm_tdp_mmu_write_spte(iter->sptep, iter->old_spte);
> +		else
> +			__kvm_tdp_mmu_write_spte(iter->sptep, new_spte);
Issue 3:
"
 If the mutually exclusive branches in __handle_changed_spte() are updated
 so both can run, there seems to be a risk during rollback. The function
 handle_removed_pt() unlinks the child page table and schedules it for RCU
 destruction. If set_external_spte_present() then fails, the rollback
 code here restores iter->old_spte. Since iter->old_spte points to the child
 page table that was just scheduled for freeing, can this cause a
 use-after-free when the old SPTE is restored?
"

Response:
As in the response to issue 1, changes from non-leaf present to leaf present
in mirror page table are not valid. We need special handling in TDX MMU to
support such scenario in the future. e.g., TDX requires all children entries
must have been all mapped or all unmapped before merging.
Maybe TDX huge page series could skip the handle_removed_pt() for the page
merging case first if more robustness is preferred to guard unexpected page
merging.


Issue 4:
 "
 Furthermore, tdp_mmu_set_spte_atomic() now returns errors from
 __handle_changed_spte(). Previously, it only returned an error (like -EBUSY)
 if the try_cmpxchg64() failed, which natively updated iter->old_spte to the
 new memory value.
 If try_cmpxchg64() succeeds but __handle_changed_spte() fails, iter->old_spte
 is not updated. Callers like clear_dirty_gfn_range() loop on failure assuming
 the old value was refreshed:
 clear_dirty_gfn_range() {
 ...
 retry:
         ...
         if (tdp_mmu_set_spte_atomic(kvm, &iter, iter.old_spte & ~dbit))
                 goto retry;
 ...
 }
 Will this result in an infinite loop, as the caller retries the exact same
 atomic operation with the unchanged iter.old_spte?
"

Response:
Though the only expected error from __handle_changed_spte() is also -EBUSY, the
infinite loop is possible if updating the external page table constantly fails
due to contentions.
However, it's currently benign since callers like clear_dirty_gfn_range() can't
operate on the mirror page table.
