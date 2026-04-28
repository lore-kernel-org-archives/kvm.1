Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D23D6CD8
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374637; cv=fail; b=BcsGD/J0zOgdBKvtX/++ozyvh+ULlQSPs58cyFKQ/9Q3lswgTMrnpxetMIZ9OLV2clWYpxo2ZfEGxAU0PL5zS44RnGjfRKtWpMwmlKgujTjC6aEGVwbGnlklCQtnr2zyLzwjgJPVjjehPYGTmxnV7h0tYzo7/fwcUXCKz/9zXKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374637; c=relaxed/simple;
	bh=pPXkxZlrnXyq1XRimwXYW5PYybRAYxNk5bQ7l5+lWcg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=POY/AAez3Ya4I4RWccXKxdKQrnu+feCmIW56ZA+22JQuvI7EDGP4n4QF3u5nRjpWhuHbnQhtkHZ9BPEit5+FkZIC9VBHWScFj0LLMchylzHC3y49gkFj/rA5Hu/sUI5etzVyHexUlAk+i7ckFLf22COw4gTE+UmNpzm9sE1zdxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWkcj4Hp; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWkcj4Hp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777374637; x=1808910637;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pPXkxZlrnXyq1XRimwXYW5PYybRAYxNk5bQ7l5+lWcg=;
  b=PWkcj4Hp3d8DoMnkvLeE/vsV+GF/MF30pXgjv9vLIVUnqi0sQ/J+2f0A
   Ps5qanBOsOdtaX75276dY1BWvaqV9G4H76ATkyPTZdsXcNC5vYJ0C6/Pu
   hDD+Al4CZN09X2I1/se1gBCSJmo3Ewz1LFvjk3yozAYWvlrmAkr9IvE2n
   GIJkFtyo1pribrZy602TBS0yP/k03qODQkHICvVSvKL49LXuVmOw+BFw7
   T4plLPpQNafDGCGshOvhAzL5SxUeETiLQUBglciBIvQcWOLY44gGBgJBo
   oYZVl2cqZKsIsmPsby4nfw4hodofCrnBG0MulSISuPKliIn8Xj454B/P/
   A==;
X-CSE-ConnectionGUID: wCdzSBUxThSI+PeNlAcr/Q==
X-CSE-MsgGUID: LRk1XXYFRAW/6CarjjaEbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88976094"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="88976094"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 04:10:36 -0700
X-CSE-ConnectionGUID: FXfOnRfUSIOwROxUh3VRqA==
X-CSE-MsgGUID: QFkxgJoARm62ZN1NxJHP4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="237887721"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 04:10:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 04:10:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 04:10:35 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 04:10:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1jEkb1AuNDMrMA9CJla2PdwbDAm19HAlr4XypXMETAhXyxFj/GlfHc5+fXqqCt4yUf6PPByGq1Vs/fSXDpOTO/L66SMKXcghIorF8rFjfJYFImcdj7uOovPBfs1OFCtUWx2woQl+/0zCi9gtExlqpuwL8SjUC9/MB7sd6ukkWgj4/F7wnRjHZDNSRmNvTawD4aiL6Hd3bBPtAe/bVVPM4Y/ykAiAEy+I5M1Hl1UP+oB7dxk3klOaznr0rtH3mbV6iqbinNc2H36uOYYY7EAZtcxvXyQ0dDMurg8ll47b2Zf/989TJoMhbTkwJKA3nzaYuHNwP8WYKL68GfzVGdWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Lz8xlHULgDKlf4Ou6OE3gO56dSp2iYx5GXRiPT73sg=;
 b=Nd2tUiD08P61xmYaoDhnrCWd+agLcYx0iW5bTfVqsoWHrsBUyrHydXpdnvM53BS54MmPuFJu/XtlfoqXAVmXqCUHVlK9H6l64kHzdjXG50Iw5ruzY21K+w1I8Uy4Q29RBAEjKM3i4C6kj3LGXTqOE7rPJTW1dGn3MWnPb4TXiO+TSdFg1oxl2y9TJ5Ok3Jke1XU+0JNZ1Hfh9qAoBHu+FZsHD4+p5N0SkgDETxROGKJrhWota6WsL1tnWD0PEKmPrY+cO78yyS3bXpYW1nznx7jOBbbVcP67hbdEJuhMswNr5wodcpHhqIPgMSxwTAYuMlU8a2PlCkrgd/8Sgh9rkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SJ2PR11MB7502.namprd11.prod.outlook.com (2603:10b6:a03:4d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 11:10:32 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 11:10:32 +0000
Date: Tue, 28 Apr 2026 19:10:22 +0800
From: Chao Gao <chao.gao@intel.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
CC: <kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, "Jim
 Mattson" <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, "Farrah
 Chen" <farrah.chen@intel.com>
Subject: Re: [PATCH] KVM: VMX: Fall back to IRR scan when PIR is empty
 despite PID.ON being set
Message-ID: <afCVnpeoorjOqeCD@intel.com>
References: <20260428070349.1633238-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260428070349.1633238-1-chenyi.qiang@intel.com>
X-ClientProxiedBy: SG2PR06CA0235.apcprd06.prod.outlook.com
 (2603:1096:4:ac::19) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SJ2PR11MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: b608a26d-b6c6-48db-cfb9-08dea516c38d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: aNBiJmwxmAm18r8VExYyPGJ8jv7KFZIohut1UzCoLA0lbx7ojo2xHDkkib/ZHwBscnh14ErxtHEFPe2X/T6RvYmoOA2K+AhUaF0iqPciMycDwgEnRldqCKyqiR2U/bUhS0mmZ8hlAyIQms5WyED37CVl0vs4e1SqXtqM/1klPmnZmtXpCZ6EER/X33UoFIOIbNoUdc64ZusXqhokvUULaIa5XtT5HQNR+w3+A/yeaJNPPVJm2JYw8KaQBO0/EHl0Td1J/oUWLyGPgBQXDq4QoyhcIe+NHS1Romfb6xsCal/kXFi7ulslk+UWz1piQouenrXuPu0cDFQIfXlUqiS29dV2IQSER/LKX0XYyGUnJacYavmgfPB6HT2A1vq5Gyz6kRVV6ZtTyOM4c9LHEmUu+avG5Jdywb8artoMGH4hbZC8XiXZ+1k+GkN+BJWli7LuJwWKQEvOErA5cIvm2aB5+XFbF8xSBANzWXiJhfXilzwTZJeFBW1jK754QmZn1Os542j4VqXeOqGiBuuUL3q/S9W4zf3wRNK9SRPdMt3jQrQLsLaepI8yzu4WcnFF3jO/1HdWmYAbVU1LjZyuv6bsx1zSa/1s01JgQBT7FmpWnXYKz3Jx8KKq084Fb4KdVFFELsDjWKkt6NlcoZ2lzqMhscBSBqhK+DC7CE7rvVWHVgQaWx/hSIE9ZwwUKD4+DWQRDxd1OjSbdKg/Spe5+jhNpKZXIvIKsj4IhMeM0q8Wyes=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uy2Sx9iIdPBD9o70iOK164T/W+cq5PWBaeR4I0mAz9u3bvybesppROXMn3l0?=
 =?us-ascii?Q?DdLNdJEwey9O3+cpJukPI2rjMK5VZEoHz9E6eEqI8AOt4aN785G6JBs1YV+O?=
 =?us-ascii?Q?cF/KgFzpijFkT08BYalZwF/wX28CtUsvno9Q0tUNB202SG8sEX1WLvph12zC?=
 =?us-ascii?Q?iakabMjzUXMMDfAoM/otk4juOEMTLxPFNIPMHcqRcbzU/190B6RWPOl8MINn?=
 =?us-ascii?Q?hH+OQqFMBvtbzkVkxKqXuMNZw4839ajfZlekyEIcTj/LNM1b9Ob1H6BpaLgR?=
 =?us-ascii?Q?UhtNxweOfNiPMoMZQxlbBw6ZJw9r0rC5KtF4NXSoZclusjcECFA67Ef5Jgcm?=
 =?us-ascii?Q?ic+JU6tafAHZWXnoCYcXyYfv9kEDtok/+JNSOVYuZ0aNnP8lwLiFh+NRCZZR?=
 =?us-ascii?Q?KKlSAoBtbuOHnzPVNY6ewM8csylHEHVdBamLNvpL7TuOQYFA2HawOj4N2HPb?=
 =?us-ascii?Q?Zg0G3y9S/L5vAvUwbF/IfRATtwoHJvRkApUKB9IuEzUarovVCZ4YYRrdZzHd?=
 =?us-ascii?Q?rR7JSJGwkKI3LtbyqOWmQFX2YKOMyg4VQMK9XNWLjORi4mzzoHxL5zO9JTQP?=
 =?us-ascii?Q?CAUUi4IHJIRbriQ+11K/IALlgGIquT2SOox2iZe4Iy50G1GgVmeMorpZkhm1?=
 =?us-ascii?Q?Zc4ECDsW4Cpq+SlvadhrN0EiDLyB/GlAxcDRwXlDPz9bc7B7ySy1BZGpVi2C?=
 =?us-ascii?Q?Yioc7W4JmYVn69c9MxASuLOgPvLvLqsfcUiKRkD2f4UUq9hRQHEOSekazgWd?=
 =?us-ascii?Q?569QPX1xixiYarOrIMJq/IcjuZqjG+/Z2sECKkIvbdo0sIo0d/jcjgvR9zJQ?=
 =?us-ascii?Q?yOta/Z8eledUetRZ3TblNAaI3iww65PAFDkSqb1v87q4W0W9VlOmw4VFt3WC?=
 =?us-ascii?Q?4i2kAV2U+3enLjykBp6z1B/6GHM5ljc+p7UKCcdPmMJlsT+HJ/dTXlIuDGQt?=
 =?us-ascii?Q?gkaDjWKhk5aMuiVuOtgOPtJROB8suUnk5upsExTPayecSjNxEfpg4PB3sKs9?=
 =?us-ascii?Q?kjKqY0KZuvZUpsNblaX03vUrtdfyxQOkI1ZNi87fEF6Wcw+4gcc7j9ucCfLN?=
 =?us-ascii?Q?0Etf15+aM8BpA+X0myd8qOxVU2Qrxd0KConaEMXSC2ZpHdBHTZkJUb6YTzwG?=
 =?us-ascii?Q?nwGB0q1CNFnjuyM6WfqBWvXXuM6v5pNmgRwI68R4hxukGGJegEixL/nNwum3?=
 =?us-ascii?Q?eXkTn21mAYINiu77px5dGwSj773n/TVzLQHX97eQxdNVrwRNc6wJk34w7Yp+?=
 =?us-ascii?Q?mchuwyhB0NaUPsdbOLfGnqBGHkm4zgSyMYppBvZffP1Hr1VZaucjX36fhWzO?=
 =?us-ascii?Q?8D6SA4V96cpdfcaDsabxrKoS41/QGh8c/dKoqGS0tpgnRFnJaB8m62qY5n71?=
 =?us-ascii?Q?E/QLsU+qXoQcjwUOLjB9lOMtxMdQ21+hgRGHnU262n2JL6K2wyQu0uQwxz7A?=
 =?us-ascii?Q?kZDQiutEeghWcCOPX2H3HVXxw2u/57NpyYGPOdsu7Z5ipfugTQLUpYAmJumJ?=
 =?us-ascii?Q?R78nyfzCHT2HybvzDKokLc1k6W8R3pGph1jTOcJi3PPAZoTciZLLSxWdhNgJ?=
 =?us-ascii?Q?r6iHa+SV6jC+na2BMQjE2FEqnusXEvzWmYnuXTunx1U0u3j6X96LJJ2sRw4B?=
 =?us-ascii?Q?ubIs7XA5csUawEt3OXZ6h9VqZAywE8yoWxORXGjkfrn4t6AyezdK1GKZbiFW?=
 =?us-ascii?Q?IJDJvZuWyEGRLBjdQ16dceTz2XkAtD3eHZEMmeKHsIsEtYzsiEzXhMfZDn9y?=
 =?us-ascii?Q?wFFu5/mSTA=3D=3D?=
X-Exchange-RoutingPolicyChecked: Yz88uOGVVeRoLaUcBmaQCQiYcKX0SIRNtJI59pXqNX5lx0LGFixOPon9TxRaH+D2dkmfC3RzJG6gQUW8BJ0N3GBZxeemdoahZM5D2C7QnAbJmepRyQhJDla2Otu8cmM3UAEKP7UHtCl7Dnr5NolmhsY+9gRJiEBmLNHKTDBruvJcMMIDM5g0UlGE4RNTo6hph03OTugO1ipCJZ55yT159/xypJ+Nx2cflhpnS32vniHH8HFpOj6X7fmnkU6n53GgGJgfUIICQK6rG0OV4tWQ7LvCMZsNbfsBOEZ+qTLendyMA67/9LlqIie1esHh4BtBUSckOdomaOm64UK+uwbIpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b608a26d-b6c6-48db-cfb9-08dea516c38d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:10:32.4184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBjCLVsiPGPtxR42+kCvQN0ZJqKx8VA8m31qaWMqCGOIl6zd9JL8102VD9rKQP/Lwj6zREOdzwp3NJu+w3Azwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7502
X-OriginatorOrg: intel.com

On Tue, Apr 28, 2026 at 03:03:26PM +0800, Chenyi Qiang wrote:
>Fall back to kvm_lapic_find_highest_irr() in vmx_sync_pir_to_irr() when
>PID.ON is set but PIR turns out to be empty, to correctly report the
>highest pending interrupt from the existing IRR.
>
>In a nested VM stress test, the following WARNING fires in
>vmx_check_nested_events() when kvm_cpu_has_interrupt() reports a pending
>interrupt but the subsequent kvm_apic_has_interrupt() (which invokes
>vmx_sync_pir_to_irr() again) returns -1:
>
>  WARNING: CPU: 99 PID: 57767 at arch/x86/kvm/vmx/nested.c:4449 vmx_check_nested_events+0x6bf/0x6e0 [kvm_intel]
>  Call Trace:
>   kvm_check_and_inject_events
>   vcpu_enter_guest.constprop.0
>   vcpu_run
>   kvm_arch_vcpu_ioctl_run
>   kvm_vcpu_ioctl
>   __x64_sys_ioctl
>   do_syscall_64
>   entry_SYSCALL_64_after_hwframe
>
>The root cause is a race between vmx_sync_pir_to_irr() on the target vCPU
>and __vmx_deliver_posted_interrupt() on a sender vCPU.  The sender
>performs two individually-atomic operations that are not a single
>transaction:
>
>  1. pi_test_and_set_pir(vector)  -- sets the PIR bit
>  2. pi_test_and_set_on()         -- sets PID.ON
>
>The following interleaving triggers the bug:
>
>  Sender vCPU (IPI):              Target vCPU (1st sync_pir_to_irr):
>  B1: set PIR[vector]
>                                  A1: pi_clear_on()
>                                  A2: pi_harvest_pir() -> sees B1 bit
>                                  A3: xchg() -> consumes bit, PIR=0
>                                      (1st sync returns correct max_irr)
>  B2: set PID.ON = 1
>
>                                  Target vCPU (2nd sync_pir_to_irr):
>                                  C1: pi_test_on() -> TRUE (from B2)
>                                  C2: pi_clear_on() -> ON=0
>                                  C3: pi_harvest_pir() -> PIR empty
>                                  C4: *max_irr = -1, early return
>                                      IRR NOT SCANNED
>
>The interrupt is not lost (it resides in the IRR from the first sync and
>is recovered on the next vcpu_enter_guest() iteration), but the incorrect
>max_irr causes a spurious WARNING and a wasted L2 VM-Enter/VM-Exit cycle.
>
>Fixes: b41f8638b9d3 ("KVM: VMX: Isolate pure loads from atomic XCHG when processing PIR")

Just FYI, I asked Copilot to review commit b41f8638b9d3, and it indeed
identified this subtle functional change:

"
Found 1 regression. In arch/x86/kvm/lapic.c::__kvm_apic_update_irr(), the new if
(!pending) return false; drops the old behavior of recomputing *max_irr from
APIC_IRR on an empty-PIR path. vmx_sync_pir_to_irr() still calls this helper
whenever PID.ON is set and then unconditionally passes max_irr to vmx_set_rvi(),
so when hardware has already drained PIR into vIRR/APIC_IRR, max_irr stays -1 and
KVM clears RVI despite an interrupt still being pending
"
