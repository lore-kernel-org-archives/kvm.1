Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD311BBBE5
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219999; cv=fail; b=Y2QB2jgB9DhqWeD4xQZ/3LflXfbmONjKiygKtXDJvKC3mB5GQbfz2wNcS1Yu7z8X3SJoScdRNL2Xw2ygv/9Y9Nur1AJBhRbf/2xUnR1NlQO1iB5PaTniwI7gfiNdmjv0wPIzVgDo54+u+tU/nJpNlUeOW5cAHyaiUimSgHFUWyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219999; c=relaxed/simple;
	bh=jK5AS3ACNnDf5nEygwgUpaeg8b48buh9yNmkxeNZtjM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYOjj7FwSgd0thQlaXpY66Eh+452xz3EdmqFbowTd7ZAEfVqPs7fVFDEsRMN2I4YcjY9uF3PqSD3Ird9z7oMwhqQ1tp5GyQ+IIgaL7gl8/iYuD3mUSrK21gIGZKdy7kCb+J7IYi6/XodfApQ3aMDYQLhzivJpI5ICLIcXI4Jz7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s1frVgGZ; arc=fail smtp.client-ip=52.101.52.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s1frVgGZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2xGJxpBq5QRhDgXpT/vAhTLGXdQu66mcflo7VsvAnbzlGtfmpHtGgfc3zoevzi90xnBpbIFkQ2ghuadLP4pAlF59Yi/P3CK0bW4lRhAGpBWrVqOwuvbTmaOjybP0ubg7CslIU9xI49DN53t/mjNXFpYnni4BAUWbzxd+t19Lf2Xp1I9NzxQjqedYwoWbVAvx9j5t1PdN8/pKjrC/OZTqagzovh+PPK8w1O+46G44jJWq0KS31bRQH28XmYKuzlGGMxDQGmNpga9AYl89NvjufKlP6c6ieRCVbhE3NVC6ZRDehziFWSz6FT9ZKj+8ore8NCs3MRUv8YwGpwpheC4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcgxxu1TSUOWJyjKRo4a69adSeHdN6rguT8NfK6xidQ=;
 b=AU9A+MiuqNwwblhg90eGBNqgZZpcKIPWqC6BUO6KjEKYOF0Ce53jkxzAQQCaVlg6E1IlNNHQ8slqeqjTumilG1UpxqT1h4aEBQlQG+N1eyFg3uVzG8+qRxdsTNjofQXUby03u7obznXuTr3imD2CMlRYxwotu6nLsr+TY/u9ri2shTo4HQjKR8NDieLRXqeF5KlgttUmzrvPBNXzN/qn8BS+eYSnenI1WiZJ8ANBZBI0iiISLIKw6VO88mdeFhp0CZ5LOoMEBIrYEQ6z/MkD2+wr7036wajZVQS82g+6byICYMAPbN50klJnfGUNQg/XmJcJjjO9LFoogR3YyAqzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcgxxu1TSUOWJyjKRo4a69adSeHdN6rguT8NfK6xidQ=;
 b=s1frVgGZ7f7G4m4T8AINMV7Y8Y5nuVm7qA3q9UYXKUcvMO7pD2zRb8WXUtFpyL4B1HkyWc6ULAq0UIB+WmmAognA8Gj/WFNTM4PcpVYZJAyufrmnF7iyD8k4VD9W2P3Uxxw4j3f/25lw0eCYQD62jeE6W5C0gInq0piayKS4dN4=
Received: from SA1P222CA0168.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::14)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 23:19:50 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::64) by SA1P222CA0168.outlook.office365.com
 (2603:10b6:806:3c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 23:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 23:19:49 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 18:19:49 -0500
Date: Thu, 11 Jun 2026 18:15:09 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Hyunwoo Kim <imv4bel@gmail.com>, <pbonzini@redhat.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: SEV: Don't return a still-assigned gmem page to the
 host
Message-ID: <sbub77galgn2zcecmeiznzi7nvgykby5lyqbebimfpd3wmsxgc@gxfth3taum3p>
References: <aimMWzAf5b3luM0b@v4bel>
 <wxamg6zqn2qmsci2fwfepbqou5vtgydqmonr67mu7b73nkakbe@zedss5vzeci3>
 <aiqNPBQzoU9f8RwI@v4bel>
 <aiqueNUndQsbMNud@google.com>
 <airAthcKDZeDfzXS@v4bel>
 <airS1G23atiuWdTl@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <airS1G23atiuWdTl@google.com>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 28990bf5-3d06-4147-95f3-08dec80fef73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|376014|6133799003|5023799004|22082099003|4143699003|11063799006|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	nK0WVZi9+eLyo7n6AeDwWge4mQa9p7L3Khnbs8jke6a3XyXYi8LvY+6WDWremBQiaxiKZwOwxGK88xPeEyo3le2f1NgFbheJukJP7DTFNkMIdMtVdLZ2mFbmB/PJAv6D+FTapS+AI1YD/44PjJUUmb8phK63VhfkKkSBb/gF5Odxafm2mF1xmSe5C2XWFN5QkhlSxYd+yfAXbmZf6NzujGav+BN6GD6kvN6PnsnM36mML22QiJ4k7ozXSg1AqDDBcEVOc8hzjPWktfpG9j2pf4bi0Dk/6ycikuKK7KgLB//+rM86o5aFk4mHtwz1lX2SQp463C8vgxyIOWGU0SK7YPpiRHAXK15twDlbFuWJTICT+96nVDuxNL84JiP/zj5sbd49hSyA9aHnDrBmtqWoDo3iDY7mTf0SzD3yL+WouN4yWVYvoR1xDnBHNtiBABvLUVZEjlnKa7MV78M0WJ/RAs/7KKMDCp8sDfczNhFfXZYPC0HvvtH7c+UNX4MuwarNHTBNLzvLSQvl9fteTrWyJ04WvJzv6at0MOXwl3u8UBCAgKDSfPyTb00my9X1LBZngGraZIcz0HTPcYX8W4nttH5cm78UtwbsHTifXFETyIV2fzzyNWIi3y5P7nNW2JDVr0/gLQb3MxANyc6U4fLaSmOE7Z9S38Qy4JtEP2qR8Kv0eaGFO1s+mq3qvonMcWJNpl5rHNAursQ8FXNy9sh3MLwfHe8yWIT/M9C7nBFy0mo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(376014)(6133799003)(5023799004)(22082099003)(4143699003)(11063799006)(56012099006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zq7Rl7GCJjgpodsJyASvC3bqEY55SiwYvFie+B7hvyk3ho1jPJuO8l0ZCuOuvJZM9uLr8roUKsnwJohCOlNXX1FsRttHL0eyXUVevAtq/MrkaNNZ+rcq7oaOY8rXimrRh94h0UArIs/7iAMFhA/SMXDe4olEoEtUsPSL7gRD8NwuanF5C5LmwleO3Q9Uxrbv/i7uNWCSkZ7sOUGJ/QW7P/SItWHUvwjSO3b8pPLx4ku09e9FhO8fyE3MVt8H4m55ErzjAAhL/0szduOenza0Pz7aLHU3icxoNXfcF5dIpeM0du6ylgy9yoTXTWtxGdjjYXGcnH9o0s5Zlu3rn+NqsU+WJkPP0IBFnouYfz5/WhDLm9fXGLtlozYr22J0tc1g9Rl06269MFtR8sOijP5A+/RQnAqUoB9mnyNrpW0lP+3uBha/dwIxixvts87HYMH3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 23:19:49.9889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28990bf5-3d06-4147-95f3-08dec80fef73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7

On Thu, Jun 11, 2026 at 08:23:00AM -0700, Sean Christopherson wrote:
> On Thu, Jun 11, 2026, Hyunwoo Kim wrote:
> > On Thu, Jun 11, 2026 at 05:47:52AM -0700, Sean Christopherson wrote:
> > > On Thu, Jun 11, 2026, Hyunwoo Kim wrote:
> > > > On Wed, Jun 10, 2026 at 05:16:57PM -0500, Michael Roth wrote:
> > > > > On Thu, Jun 11, 2026 at 01:10:03AM +0900, Hyunwoo Kim wrote:
> > > > > > ---
> > > > > >  arch/x86/kvm/svm/sev.c | 6 +++++-
> > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > > > > index 6c6a6d663e29..8fee6ec529f9 100644
> > > > > > --- a/arch/x86/kvm/svm/sev.c
> > > > > > +++ b/arch/x86/kvm/svm/sev.c
> > > > > > @@ -5178,8 +5178,12 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> > > > > > 
> > > > > >                 rc = rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K);
> > > > > >                 if (WARN_ONCE(rc, "SEV: Failed to update RMP entry for PFN 0x%llx error %d\n",
> > > > > > -                             pfn, rc))
> > > > > > +                             pfn, rc)) {
> > > > > > +                       /* Still assigned to the guest; pin and leak rather than freeing. */
> > > > > > +                       folio_get(page_folio(pfn_to_page(pfn)));
> > > > > > +                       snp_leak_pages(pfn, use_2m_update ? PTRS_PER_PMD : 1);
> > > > > >                         goto next_pfn;
> > > > > > +               }
> > > > > 
> > > > > This roughly aligns with what would happen if snp_page_reclaim() fails
> > > > > in sev_gmem_post_populate(), while the guest is being initialized via
> > > > > KVM_SEV_SNP_LAUNCH_UPDATE ioctl, which calls into kvm_gmem_populate().
> > > > > 
> > > > > However, in kvm_gmem_populate(), we still free the page. Maybe, to
> > > > > address both cases, we should just add a parameter to snp_leak_pages()
> > > > > to tell it to take an extra ref and use that in both of these paths.
> > > > > 
> > > > > Or we can just do the direct folio_get() in both cases, the above
> > > > > formalizes the handling convention a little better though IMO.
> > > > 
> > > > If I understand correctly, an extra ref alone still seems to leave the
> > > > LRU corruption that sashiko flagged:
> > > > 
> > > > https://lore.kernel.org/all/20260610162623.061BA1F00898@smtp.kernel.org/
> > > > 
> > > > A gmem folio is on the unevictable LRU, and taking a ref keeps the folio
> > > > on the LRU. page->buddy_list, which snp_leak_pages() uses, shares the
> > > > same union as folio->lru, so leaking the page overwrites the folio's LRU
> > > > pointers. Both paths deal with a gmem folio, so the same applies.
> > > > 
> > > > To handle this properly, the folio would need to be taken off the LRU
> > > > before leaking, with something like folio_isolate_lru(), but that is
> > > > mm-internal and does not look usable from KVM. How should we proceed?
> > > > Please let me know if I am missing something.
> > > 
> > > I'm inclined to do nothing.  rmp_make_shared() should only fail in this case if
> > > there's a fatal bug somewhere, no?  Either that or do BUG_ON(), because at some
> > > point these types of errors are simply unrecoverable.
> > 
> > A guest can make a gmem page a VMSA via AP creation,
> 
> Ugh, the bane of my existence.  Can we kill off that feature yet?  I'm only half
> joking.  Not even half.
> 
> > and if that gfn is then hole-punched, a page that is still assigned to the
> > guest is returned to the host in sev_gmem_invalidate(), which looked like it
> > could lead to a host RMP PF, so I sent the patch.
> 
> Yeah, I suspect you're right.  But leaking the page doesn't fix the underlying
> problem, which is that it's possible to free a page that's being used as a VMSA.
> 
> We can't simply pin the page, because IIUC ->free_folio() is called when the page
> is removed from the filemap, not when the folio/page is free back to the allocator.

If free_folio() triggers, it would call into the
kvm_gmem_invalidate()/rmp_make_shared() path and clear VMSA bit, which I
think would cause a subsequent vcpu_run() to error cleanly. So that part
maybe isn't the issue, so much as the stale VMSA reference we have once
the hole-punched finished at folio actually gets freed to allocator..

But KVM would never be accessing it directly while it's allocated for a
vCPU (it would be garbage on the host-side anyway), and I think the CPU
should only be able to write to it as part of VMRUN/exit, but those
should immediately fail since it's not a VMSA page any more at that
point.

It's sort of a precarious state, but I think we might hold up okay
there.. so I'm not sure we actually need the changes below, unless I'm
missing something.

..but on the VM cleanup side, we'd end up doing a double-free in that
case, so we would need still need the elevated reference to handle that.

Does that address the hole-punching scenario at least?

Thanks,

Mike

> 
> I.e. we can't do this.
> 
> diff --git arch/x86/kvm/svm/sev.c arch/x86/kvm/svm/sev.c
> index 74fb15551e83..ea70c7ade152 100644
> --- arch/x86/kvm/svm/sev.c
> +++ arch/x86/kvm/svm/sev.c
> @@ -3510,6 +3510,9 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
>  
>         svm = to_svm(vcpu);
>  
> +       if (svm->sev_es.snp_has_guest_vmsa)
> +               kvm_release_page_clean(phys_to_page(svm->vmcb->control.vmsa_pa));
> +
>         /*
>          * If it's an SNP guest, then the VMSA was marked in the RMP table as
>          * a guest-owned page. Transition the page to hypervisor state before
> @@ -4027,6 +4030,13 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
>         if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
>                 return;
>  
> +       /*
> +        * Drop the reference to the previous VMSA page (acquired above) if the
> +        * guest is changing its VMSA.
> +        */
> +       if (svm->sev_es.snp_has_guest_vmsa)
> +               kvm_release_page_clean(phys_to_page(svm->vmcb->control.vmsa_pa));
> +
>         /*
>          * From this point forward, the VMSA will always be a guest-mapped page
>          * rather than the initial one allocated by KVM in svm->sev_es.vmsa. In
> @@ -4043,13 +4053,6 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
>  
>         /* Mark the vCPU as runnable */
>         kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
> -
> -       /*
> -        * gmem pages aren't currently migratable, but if this ever changes
> -        * then care should be taken to ensure svm->sev_es.vmsa is pinned
> -        * through some other means.
> -        */
> -       kvm_release_page_clean(page);
>  }
>  
>  static int sev_snp_ap_creation(struct vcpu_svm *svm)
> 
> The right way to handle this is to treat the VMSA "mapping" like an MMU mapping.
> I.e. this is fundamentally the same mess we have to solve in order to not pin
> pages that are mapped into L2 via vmcs01/vmcb02 for nVMX/nSVM.
> 
> Something like this, sans the actually handling of the request.  The simple way
> to handle the request would be to invalidate control.vmsa_pa if snp_has_guest_vmsa
> is true, and then redo the mapping part of sev_snp_init_protected_guest_state().
> 
> We could put the kvm_x86_call(gmem_invalidate_range)(kvm, range) call in
> kvm_unmap_gfn_range() to avoid the extra arch hook, but I would prefer to have an
> explicit connection between the invalidate() phase and the free() phase.
> 
> Have I mentioned how much I hate AP creation?
> 
> ---
>  arch/x86/include/asm/kvm-x86-ops.h |  3 ++-
>  arch/x86/include/asm/kvm_host.h    |  3 ++-
>  arch/x86/kvm/svm/sev.c             | 11 ++++++++++-
>  arch/x86/kvm/svm/svm.c             |  5 ++++-
>  arch/x86/kvm/svm/svm.h             | 13 ++-----------
>  arch/x86/kvm/x86.c                 |  9 +++++++--
>  include/linux/kvm_host.h           |  3 ++-
>  virt/kvm/guest_memfd.c             | 17 +++++------------
>  8 files changed, 34 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 83dc5086138b..ea308250ef47 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -147,7 +147,8 @@ KVM_X86_OP_OPTIONAL(get_untagged_addr)
>  KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
>  KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
>  KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
> -KVM_X86_OP_OPTIONAL(gmem_invalidate)
> +KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
> +KVM_X86_OP_OPTIONAL(gmem_free_folio)
>  #endif
>  
>  #undef KVM_X86_OP
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 3886b536c8a5..0a5aec1701bd 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2009,7 +2009,8 @@ struct kvm_x86_ops {
>  	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
>  	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
>  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> -	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
> +	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
> +	void (*gmem_free_folio)(struct folio *folio);
>  	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>  };
>  
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 74fb15551e83..411480a90e36 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5115,9 +5115,18 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
>  
>  	return 0;
>  }
> +void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	if (!sev_snp_guest(kvm))
> +		return;
> +
> +	kvm_make_all_cpus_request(kvm, KVM_REQ_VMSA_PAGE_RELOAD);
> +}
>  
> -void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> +void sev_gmem_free_folio(struct folio *folio)
>  {
> +	kvm_pfn_t start = page_to_pfn(folio_page(folio, 0));
> +	kvm_pfn_t end = start + (1ul << folio_order(folio));
>  	kvm_pfn_t pfn;
>  
>  	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 526e0fdcd16b..907be66d6f2a 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5460,9 +5460,12 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
>  	.vcpu_get_apicv_inhibit_reasons = avic_vcpu_get_apicv_inhibit_reasons,
>  	.alloc_apic_backing_page = svm_alloc_apic_backing_page,
>  
> +#ifdef CONFIG_KVM_AMD_SEV
>  	.gmem_prepare = sev_gmem_prepare,
> -	.gmem_invalidate = sev_gmem_invalidate,
> +	.gmem_invalidate_range = sev_gmem_invalidate_range,
> +	.gmem_free_folio = sev_gmem_free_folio,
>  	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
> +#endif
>  };
>  
>  /*
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 716be21fba33..5129ab1a84d7 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -1008,7 +1008,8 @@ int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
>  extern unsigned int max_sev_asid;
>  void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
>  int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> -void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
> +void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
> +void sev_gmem_free_folio(struct folio *folio);
>  int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>  struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
>  void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa);
> @@ -1034,16 +1035,6 @@ static inline int sev_cpu_init(struct svm_cpu_data *sd) { return 0; }
>  static inline int sev_dev_get_attr(u32 group, u64 attr, u64 *val) { return -ENXIO; }
>  #define max_sev_asid 0
>  static inline void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code) {}
> -static inline int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
> -{
> -	return 0;
> -}
> -static inline void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end) {}
> -static inline int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private)
> -{
> -	return 0;
> -}
> -
>  static inline struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
>  {
>  	return NULL;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index cf122b8c3210..a734ddf59cf9 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -14134,9 +14134,14 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
>  #endif
>  
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> +void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
> -	kvm_x86_call(gmem_invalidate)(start, end);
> +	kvm_x86_call(gmem_invalidate_range)(kvm, range);
> +}
> +
> +void kvm_arch_gmem_free_folio(struct folio *folio)
> +{
> +	kvm_x86_call(gmem_free_folio)(folio);
>  }
>  #endif
>  #endif
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 27498e990dff..7de9b07870b7 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2602,7 +2602,8 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
>  #endif
>  
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
> +void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
> +void kvm_arch_gmem_free_folio(struct folio *folio);
>  #endif
>  
>  #ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 86690683b2fe..8ec5041934db 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -185,6 +185,10 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
>  		}
>  
>  		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
> +
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +		kvm_arch_gmem_invalidate_range(kvm, &gfn_range);
> +#endif
>  	}
>  
>  	if (flush)
> @@ -523,23 +527,12 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>  	return MF_DELAYED;
>  }
>  
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -static void kvm_gmem_free_folio(struct folio *folio)
> -{
> -	struct page *page = folio_page(folio, 0);
> -	kvm_pfn_t pfn = page_to_pfn(page);
> -	int order = folio_order(folio);
> -
> -	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
> -}
> -#endif
> -
>  static const struct address_space_operations kvm_gmem_aops = {
>  	.dirty_folio = noop_dirty_folio,
>  	.migrate_folio	= kvm_gmem_migrate_folio,
>  	.error_remove_folio = kvm_gmem_error_folio,
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -	.free_folio = kvm_gmem_free_folio,
> +	.free_folio = kvm_arch_gmem_free_folio,
>  #endif
>  };
>  
> 
> base-commit: de3a35be92d2391ece4bf3143ef2887192625fd0
> -- 
> 
> > Other sites such as snp_page_reclaim() leak the page on this failure rather
> > than freeing it.
> > 
> > If you think this isn't a real problem, leaving it as is seems fine to me.
> > I don't see a good place to put a BUG_ON.
