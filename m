Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B05331619C
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760570; cv=none; b=AtTGSeM7b8dFodju7r50rrLN42uz2h6cX+8plXSTaVZ86wZiOo67iOyJcctlUOwl9858Y9PMSYJl+ofYKT6pyLT+wZopnbO12nneC4Wk2wXMSpsXd3hlSxcE2ZHD3iEnlfxRpkP4uPdIv4id/dHhM+oi9avC32d/3RYUNIMxCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760570; c=relaxed/simple;
	bh=/Nkm53Of+08xjKvrZsWp24h6hO0JPSHjeNHvSTLAq2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VVEuNl0JQXnCQQwksc/8xMdmsvSsgVnA+MYCoMiz7UCgD0QLUWCDyP/DhcSFz+rFHzVhkq3xjrbK+YDm+sx+wcSjcDOIj1Uo994pjXHoYfTt2qdQWGAai+ZM+uFxoRYZc6OGIZ1MFvkvlOHfiOizTtyJOHL8ADHFGqNMDhHV4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNaP0EA0; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNaP0EA0"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1c2f1acebso1528061a12.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787760568; x=1788365368; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=syqeQtFYsroplvcMq6SvXnjwYNUT8RzEumiv9GKgBTU=;
        b=XNaP0EA0NqVTojv0BZT4L2iavxfJE4opixq3clJ+Vqt+oY7CUe2DswF35q65bKM7KH
         9MJvZ2wrUMnhC+ZVGJtkBACoWdIh6d5CBPIPQlwe2iCBAKLJGpkanG4/orwmpcX/lUl9
         dYdstJ40CGfpj7RSueotuo5enw4OpX21raVg2yxcu17AIW6bfbzuOsCa83AfQEcAFvND
         dQ61zi4SdMjXCc19/ISWu1gbH7zMTAt0zIO8zaljsmpecUBS3Wb4fhHBJn8oSVXfpeLR
         WgtiBY2oLCuIcMqzUrEyQY+LecFsZUXZnLH6OnxtT3lx3raxiExxUcRkpmWVINjTitUv
         AD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787760568; x=1788365368;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=syqeQtFYsroplvcMq6SvXnjwYNUT8RzEumiv9GKgBTU=;
        b=iHezYyRCqnUhM96yvQnR2XUWq7PdB3XvjujQE5stNppKOtfO2C7JWYSHr/Hepg22to
         qlCB3jY3Ub1DcAHnHEVjG1i/60Otm/Mu+s+1OuVXZcjF46VbtHQxOUIUc4MR2XNWZ2F7
         HfUgJY13T5DsrH48n6mnbIoZAs++WNwHHFXqGwfMHNAePxt4/Nb+BzdopXmcmc6IqPmn
         DDnfgV+kejFfRm0A1Of4Ikc0gAPdjrYsS6/SuB6FItECUZlZo//g0INJ60usl3clY8oZ
         kmfZsqidD2x7gwEMxdJNTZlIFl47Mptzb1dts+XzQZ+XK4YizY8AWC3NJ9Rbs0uh1Mm5
         LgfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqinzbn6842qEet0GadaijNF8dajBl/iu+KDuWcvxyIdE6nDoXLuVP7jt0bQfG92d5t8XI=@vger.kernel.org
X-Gm-Message-State: AFuF++lY/inCNHiLTNQzMU5qardreH/UCHwHczSY/7+rtKqAyofPePEo
	3SRAKGebAbGiRZSNiwUgTSqNtYOAFO/ewuxJFzLZeDTrMHaNmjzMh9MJ/foBFV0QJXYmLswTuuu
	bN/YCMQ==
X-Received: from pgbfl16.prod.google.com ([2002:a05:6a02:50d0:b0:cc1:c07e:b53c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4308:b0:3b4:8f18:33a
 with SMTP id adf61e73a8af0-3cf75d803f4mr14024475637.1.1787760567470; Wed, 26
 Aug 2026 09:09:27 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:09:26 -0700
In-Reply-To: <c0f9fdc27f3d9a1e63f2d39a40989d66b6facee3.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1783490022.git.naveen@kernel.org> <c0f9fdc27f3d9a1e63f2d39a40989d66b6facee3.1783490022.git.naveen@kernel.org>
Message-ID: <ao8PtliwDo8H49sa@google.com>
Subject: Re: [RFC PATCH v3 16/27] KVM: SVM: Add handler for VMGEXIT Secure
 AVIC NAE event
From: Sean Christopherson <seanjc@google.com>
To: "Naveen N Rao (AMD)" <naveen@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>, 
	Tianyu Lan <tiala@microsoft.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 08, 2026, Naveen N Rao (AMD) wrote:
> From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> 
> [DO NOT MERGE]
> 
> VMGEXIT Secure AVIC NAE event is used by the guest for two purposes
> determined by VMCB->EXITINFO1:
> 1. SVM_VMGEXIT_SAVIC_REGISTER_GPA: Used to inform the hypervisor about
>    the GPA of the page (RBX) being used as the Secure AVIC backing page.
>    RAX indicates APIC ID of the target vCPU (-1 for self)
> 2. SVM_VMGEXIT_SAVIC_UNREGISTER_GPA: Used to inform the hypervisor that
>    the GPA is no longer being used as the backing page for Secure AVIC.
>    The previously registered GPA for the Secure AVIC backing page is
>    returned by the hypervisor to the guest.
> 
> The primary motivation behind these is to ensure that Secure AVIC
> hardware accesses to the guest APIC backing page never generate an #NPF,
> since Secure AVIC hardware cannot recover from such faults. Quoting the
> APM:
>   "It is required that the guest APIC backing page for a vCPU is
>    pinned in system memory between VMRUN and VMEXIT because some AVIC
>    hardware acceleration sequences may not be restartable when secure
>    AVIC is enabled. If an access to the guest's own backing page by
>    AVIC hardware results in a nested page fault, EXITINFO1 bit 63
>    (Not Restartable) is set (this is an Automatic Exit) and the BUSY
>    bit in the VMSA is set."
> 
> A guest vCPU that has the BUSY bit set in the VMSA cannot be restarted
> and the guest will have to be killed.
> 
> One of the main reasons why the SPTE for a Secure AVIC backing page may
> be invalidated is if it is backed by a huge page in the host, and an
> adjacent page changes state forcing the huge page to be split. Currently
> though, KVM uses guest_memfd to back SEV-SNP guest private memory, and
> those only use 4k pages. As such, this _may_ not be an issue today.
> 
> It is possible that KVM may still invalidate an SPTE for other reasons -
> those will need to be addressed.

As I said in PUCK, this is going to be painful to support, both now and in the
future.  We _could_ get it working, but I'm not at all convinced that I want to
commit to supporting Secure AVIC in its current form.

Though on a slightly happier note, I was wrong about KVM_X86_QUIRK_SLOT_ZAP_ALL.
That quirk only applies to KVM_X86_DEFAULT_VM VMs, i.e. wouldn't need to be
manually disabled for SNP.

And if we go with my suggestion[1] to force KVM_MEMSLOT_GMEM_ONLY when binding to
a gmem instance with in-place conversion enabled, then the fix/optimization to
ignore mmu_notifiers for gmem-only memslots will avoids spurious zaps on that
front[2].

However, there are still problems.  E.g. when converting memory, userspace would
need to make sure to never do a redundant/superfluous KVM_SET_MEMORY_ATTRIBUTES2
on a range that contains a Secure AVIC page, because __kvm_gmem_set_attributes()
will tell the MMU to invalidate SHARED mappings for the entire range.  I.e. by
design, guest_memfd will not chunk the invalidations based on the per-page state
of PRIVATE vs. SHARED, because cross-referencing the current attributes would
incur non-trivial complexity.  For TDX, this isn't a problem because the S-EPT
is a separate paging structure, and so kvm_gfn_range_filter_to_root_types() can
simply skip MIRROR roots to avoid over-zapping PRIVATE memory.  SNP doesn't have
such a thing.

Converting a subset of a huge PRIVATE page would also be problematic, although
that one isn't so bad since we already need to call into the TDP MMU to pre-split
S-EPT pages, because those too can't tolerate spurious zappings.

Those are solvable problems, but I'm not exactly chomping at the bit to take on
the complexity to support what IMO is a poorly designed feature.  There's a very
good reason why control pages are referenced by their host PA in both the VMCS
and VMCB.

TDX's S-EPT obviously has similar restrictions, but with S-EPT the downsides are
a direct tradeoff of the benefits.  Tracking ownership in the page tables to avoid
the complexity and performance costs with an out-of-band table obviously requires
preserving those page tables.  For Secure AVIC, AFAICT it's simply a bad design.

Honestly, this feels a lot like Supervisor Shadow Stacks on Intel, where an EPT
Violation in the middle of a shadow stack access would be destructive to guest
state without a very heavy lift in the hypervisor.  And I'm pretty sure the
feedback to Intel was "provide a better implemetnation" (wait for FRED, maybe?).

[1] https://lore.kernel.org/all/ao7vwx3nMqCjCHZU@google.com
[2] https://lore.kernel.org/kvm/20260615155244.183044-1-alexandru.elisei@arm.com
