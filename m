Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9F13AB28F
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079266; cv=pass; b=LILX4JFHN00u1qhHjaual+TigE3flVJPlOwm1pYCuBO22uA8gAQi4JyQORkCHkQajdnAP7f4+9c5zVeRwUoisUFIaUMaRvcejphAGQoe3kuz0GzvPaudktlcTUIa3JQ10MOe5NBliADctKMVsdRKBa07Fl83YMNngszdY3xM0BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079266; c=relaxed/simple;
	bh=covX0zrTlfEh/HoyYAmb/Z60z4M4xBOGGMsvWyl4WgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYbi8LaKZQGHzcbXWufhGNLoNkVeSfVSRSP/F9grBNkRtiq0PaZfsl9KNOxuvtbPbZJeDYNdwlIHtA7CnxZVAavHgqMMVhLhaHcPwlfMTVKvUFT231CR+JFuOW1DHVUvmtLn/IrLo7JY0T2dNIArce1RyDL1fXsjOdK5ryyEULY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWeM5EM7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVN7TClX; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWeM5EM7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVN7TClX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776079264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1xMOgmtqO6nUC1Gu6A54Lx7eO2np+6KAGJZ7/QCnPBU=;
	b=SWeM5EM7eP7NXgP7o7ECZc3wp2hT/jEKDhgrvSMfVZnByZUTwK+j7bjXnRcjjqVsKTlwXq
	u6OzXUIpWL52cpo02nh8zSpFJeWLvYtmy7bi9T3GATOe0kT9O7nLnqzupJgiHmIjZMc4nD
	aqFsjvUYhZqVvD2XOmi1RbiCqcScYJY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-8piq5RevOsySj4Fb48oL8w-1; Mon, 13 Apr 2026 07:21:03 -0400
X-MC-Unique: 8piq5RevOsySj4Fb48oL8w-1
X-Mimecast-MFC-AGG-ID: 8piq5RevOsySj4Fb48oL8w_1776079262
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d8deb75fso17483125e9.3
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 04:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776079261; cv=none;
        d=google.com; s=arc-20240605;
        b=bCA12nZ7eTccPpOYH1pVLZNCgSPhRKkcSig4qTEkkJ3L9iN1jwoCBW/VgSifewmfuQ
         QBpR7kTvHxX0cxQFpmbX+RARiS2W8rFQ07KhuqCbFhBgiagYlJE0Gf6A6ogPHL43ZcSR
         vDIQ+rCb5mJETEH7a93k2Th0Xmh5ClLMvppntJihSo6Xyl1vT299Dsflh3R4RSt2wxq7
         YLQfSZRjM6Uq4aRUCggyr3MoN/4jesMtT9lkGSei0evhc2sOQ3jHpnJu8XsiEjnJ0Se+
         W2jD1ucRbYtDN/CBn+5lMbXekwJ7RPkHkm4sDrbpy+t9Wm/MApLJTIhhnUHmxlPOecwv
         CX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1xMOgmtqO6nUC1Gu6A54Lx7eO2np+6KAGJZ7/QCnPBU=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=JM0BhLE6Zgq0jQ/TNonmLSUzWMC3QV2aRlB/+QEZIYbaz2eQ6u7b8ZxTtGee0tQMvc
         JR+IaazD/W7EptK4XlzDDwgHmwvkoQ8VG5coHpVTHel0fXIdSMwOKkOQ+4NyNej/s5QX
         xqUJODHFEcvsXDDWjoBWVHu8cBhNYX7W8YFxbWuaxqdl5KxeY5e1d+T34TcuscyaLyRk
         LEfFFIYigm5GYILKRbQetawhNP/6p6ZKSI5z42+jQgjxkVg3Si+I9o884Y6f0+sO0S8n
         0S74h6Mu7E32vQbc2hj0LWS6pGZtgFNr7AbKs8BOp8uq4AFqenKdzkSGKn2UkLwYdAZd
         Iydw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776079261; x=1776684061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xMOgmtqO6nUC1Gu6A54Lx7eO2np+6KAGJZ7/QCnPBU=;
        b=fVN7TClXkm/KsNYgXR1wBvkE8r0UOiPLHZq23YVDhvPXsSEn+ASuiajypygNMJnkfW
         lV/G+h1j0cqrp2ufQ6UnVF2knAbB/tLrcIWUaW+6f4UOpfd31qjDtmutE2g1NhSbMD7W
         NBukt5l5fi8RASbsqp4A8Q/8QMC4TB+oGMCexrJcSp7X+poexq1u9TjbTNp8NpRrL/Ue
         NNuSVtA5R8EPnPItZBNOsI/n+dybiFLIK/nNesKvcsYPX4Awe6vW2hSCZ1/G9uQMQgEN
         OhSzGHJGKOGbBdiQowalZCjsRZVSDTc/gQZvSTW4NR7ZctyPw3B6dqzVKz5BsSxWtP5p
         pIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776079261; x=1776684061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xMOgmtqO6nUC1Gu6A54Lx7eO2np+6KAGJZ7/QCnPBU=;
        b=exvxZyzFC2txouHQsW/3HH5icOLHv5UBgsYSfR7emkEnv8UH1Kh+JaJEizfLlONLRj
         Hv80TFRSBDlR8mhIsZoI5aoHCxaIu6N1/EBMlnJZjapBf5jUSpzfCqEODFaQ2Im8PdrW
         JOKid2pMUOAmT4wNXVqxgNSaD9rDw8+oDvItzQpzBRiOaTEJCcyEZXw8Oi4urL/CGVeL
         uBsbPA34FmFJTfwAu8Q8M6x9gI44oD6pgJ9u+pHI72lxoUiBblDvVEQsS2OwRyIVMBoO
         eweObFN7SB0nwBasza1x8S8j1a3nkIgcMQdNNOTplAoPXqDFW6ZH5Ht9UjC+5FElOj4N
         YrAg==
X-Gm-Message-State: AOJu0Ywfi4dXGRcfHnMpB8qmWYqSzW8wsojZqu2HbwKgHZAN7oEVtUul
	G1xCKgES8suGxNBMZSRg4fhMWnDrCLvWecm2XcMc6hykImyidNRelnCzEQwm2D3fIsVs5qSGT4Z
	VGzkcwUx8Ij2fJ1NPh+c5M7s1IxAaD2GgiS07q9+Rqqw+9FCS3frJe8A8U+WNewsWwV/p64ppHX
	RX/QbRDICUKSvn+B/LRpKQSuMat713NLy/6hrN
X-Gm-Gg: AeBDietONvfZyeQ8fw1qRxTyM5xzl7/200E7gTUCgPpJ4Y2BH3nZR9lQ1S9W4jLVBbb
	5l0CoZ96r4+7l3oFKYK0YRs/zdHtagEwrOz8VSryJL7V5JB+i0+A7uYeeWOL1uaMLprjTJaIrHS
	JK8MhxpPIX8G1aUaic70CfwrCZzJ7yuL7M1bPhpTyH+DBLY32MMm8H1uNJpsNLpZBJYZbkQqjGw
	x08u5Ttj4RSF6ZB448hspERm8t+SJd1dsP6xZEHujfhuPj0kX8lW/GYlVaxnbzba7oXiUIlZMv6
	iQAz
X-Received: by 2002:a05:600c:c0da:b0:488:b043:5efd with SMTP id 5b1f17b1804b1-488d682628dmr157167935e9.13.1776079260847;
        Mon, 13 Apr 2026 04:21:00 -0700 (PDT)
X-Received: by 2002:a05:600c:c0da:b0:488:b043:5efd with SMTP id
 5b1f17b1804b1-488d682628dmr157167525e9.13.1776079260311; Mon, 13 Apr 2026
 04:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com> <20260410235832.2312342-9-seanjc@google.com>
In-Reply-To: <20260410235832.2312342-9-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 13:20:46 +0200
X-Gm-Features: AQROBzC1-XC55MWi3_KS_D1HDZ38RNTWlhwmkzS3QOM6lVDfh4-4RVdfgm_c0j0
Message-ID: <CABgObfbKNBgkjaD+Ws_HF+BwwbdYHG3VppL-P244MBAbYh-uUQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: SVM+SEV changes
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 1:58=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> This is the full set of SVM+SEV changes.  The end goal of the SEV changes=
, after
> fixing a few fatal bugs, is to add a lockdep assertion to ensure that kvm=
->lock
> is held when checking if the VM is an SEV+ guest.  This is at least the s=
econd
> fatal bug we've had due to SEV+ state being unwound on failure, and lack =
of
> formal-ish rules makes it hard to reason about the safety of any related =
code,
> e.g. when reviewing new code.
>
> This has a superficial (I can't even figure out why git treats it as a co=
nflict,
> I think it's both deleting white space or something?) syntactic conflict =
with the
> "vmxon" PULL request; just take this one.

Yes, it's deleting whitespace.  I pulled the full version and will
review it over the week, leaving this PR last just in case.

Paolo

> There's a syntactic conflict with the "nested" PULL request (this is what=
 I
> see when merging the "nested" one first):
>
> @@@ -870,8 -881,8 +886,8 @@@ void svm_enable_lbrv(struct kvm_vcpu *v
>
>   static void __svm_disable_lbrv(struct kvm_vcpu *vcpu)
>   {
> -       KVM_BUG_ON(sev_es_guest(vcpu->kvm), vcpu->kvm);
> +       KVM_BUG_ON(is_sev_es_guest(vcpu), vcpu->kvm);
>  -      to_svm(vcpu)->vmcb->control.virt_ext &=3D ~LBR_CTL_ENABLE_MASK;
>  +      to_svm(vcpu)->vmcb->control.misc_ctl2 &=3D ~SVM_MISC2_ENABLE_V_LB=
R;
>   }
>
> and a semantic conflict with kvm/master due to the CR8 interception fix:
>
> diff --cc arch/x86/kvm/svm/avic.c
> index 2885c5993ebc,7056c4891f93..adf211860949
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@@ -226,9 -237,6 +237,9 @@@ static void avic_deactivate_vmcb(struc
>         vmcb->control.int_ctl &=3D ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK)=
;
>         vmcb->control.avic_physical_id &=3D ~AVIC_PHYSICAL_MAX_INDEX_MASK=
;
>
> -       if (!sev_es_guest(svm->vcpu.kvm))
> ++      if (!is_sev_es_guest(&svm->vcpu))
>  +              svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
>  +
>         /*
>          * If running nested and the guest uses its own MSR bitmap, there
>          * is no need to update L0's msr bitmap
>
>
> The following changes since commit 11439c4635edd669ae435eec308f4ab8a08048=
08:
>
>   Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-svm-7.1
>
> for you to fetch changes up to bc0932cf9b9917e826871db947398aa2b62789b2:
>
>   KVM: SEV: Goto an existing error label if charging misc_cg for an ASID =
fails (2026-04-09 12:00:24 -0700)
>
> ----------------------------------------------------------------
> KVM SVM changes for 7.1
>
>  - Fix and optimize IRQ window inhibit handling for AVIC (the tracking ne=
eds to
>    be per-vCPU, e.g. so that KVM doesn't prematurely re-enable AVIC if mu=
ltiple
>    vCPUs have to-be-injected IRQs).
>
>  - Fix an undefined behavior warning where a crafty userspace can read th=
e
>    "avic" module param before it's fully initialized.
>
>  - Fix a (likely benign) bug in the "OS-visible workarounds" handling, wh=
ere
>    KVM could clobber state when enabling virtualization on multiple CPUs =
in
>    parallel, and clean up and optimize the code.
>
>  - Drop a WARN in KVM_MEMORY_ENCRYPT_REG_REGION where KVM complains about=
 a
>    "too large" size based purely on user input, and clean up and harden t=
he
>    related pinning code.
>
>  - Disallow synchronizing a VMSA of an already-launched/encrypted vCPU, a=
s
>    doing so for an SNP guest will trigger an RMP violation #PF and crash =
the
>    host.
>
>  - Protect all of sev_mem_enc_register_region() with kvm->lock to ensure
>    sev_guest() is stable for the entire of the function.
>
>  - Lock all vCPUs when synchronizing VMSAs for SNP guests to ensure the V=
MSA
>    page isn't actively being used.
>
>  - Overhaul KVM's APIs for detecting SEV+ guests so that VM-scoped querie=
s are
>    required to hold kvm->lock (KVM has had multiple bugs due "is SEV?" ch=
ecks
>    becoming stale), enforced by lockdep.  Add and use vCPU-scoped APIs wh=
en
>    possible/appropriate, as all checks that originate from a vCPU are
>    guaranteed to be stable.
>
>  - Convert a pile of kvm->lock SEV code to guard().
>
> ----------------------------------------------------------------
> Carlos L=C3=B3pez (5):
>       KVM: SEV: use mutex guard in snp_launch_update()
>       KVM: SEV: use mutex guard in sev_mem_enc_ioctl()
>       KVM: SEV: use mutex guard in sev_mem_enc_unregister_region()
>       KVM: SEV: use mutex guard in snp_handle_guest_req()
>       KVM: SVM: Move lock-protected allocation of SEV ASID into a separat=
e helper
>
> Gal Pressman (1):
>       KVM: SVM: Fix UBSAN warning when reading avic parameter
>
> Li RongQing (1):
>       KVM: SVM: Mark module parameters as __ro_after_init for security an=
d performance
>
> Sean Christopherson (30):
>       KVM: SVM: Fix clearing IRQ window inhibit with nested guests
>       KVM: SVM: Fix IRQ window inhibit handling across multiple vCPUs
>       KVM: SVM: Optimize IRQ window inhibit handling
>       KVM: Isolate apicv_update_lock and apicv_nr_irq_window_req in a cac=
heline
>       KVM: SVM: Serialize updates to global OS-Visible Workarounds variab=
les
>       KVM: SVM: Skip OSVW MSR reads if KVM is treating all errata as pres=
ent
>       KVM: SVM: Extract OS-visible workarounds setup to helper function
>       KVM: SVM: Skip OSVW variable updates if current CPU's errata are a =
subset
>       KVM: SVM: Skip OSVW MSR reads if current CPU doesn't support the fe=
ature
>       KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCRYPT_REG_REGION
>       KVM: SEV: Drop useless sanity checks in sev_mem_enc_register_region=
()
>       KVM: SEV: Disallow pinning more pages than exist in the system
>       KVM: SEV: Use PFN_DOWN() to simplify "number of pages" math when pi=
nning memory
>       KVM: SEV: Use kvzalloc_objs() when pinning userpages
>       KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA call in SEV-ES =
migrate test
>       KVM: SEV: Reject attempts to sync VMSA of an already-launched/encry=
pted vCPU
>       KVM: SEV: Protect *all* of sev_mem_enc_register_region() with kvm->=
lock
>       KVM: SEV: Disallow LAUNCH_FINISH if vCPUs are actively being create=
d
>       KVM: SEV: Lock all vCPUs when synchronzing VMSAs for SNP launch fin=
ish
>       KVM: SEV: Lock all vCPUs for the duration of SEV-ES VMSA synchroniz=
ation
>       KVM: SEV: Provide vCPU-scoped accessors for detecting SEV+ guests
>       KVM: SEV: Add quad-underscore version of VM-scoped APIs to detect S=
EV+ guests
>       KVM: SEV: Document the SEV-ES check when querying SMM support as "s=
afe"
>       KVM: SEV: Move standard VM-scoped helpers to detect SEV+ guests to =
sev.c
>       KVM: SEV: Move SEV-specific VM initialization to sev.c
>       KVM: SEV: WARN on unhandled VM type when initializing VM
>       KVM: SEV: Hide "struct kvm_sev_info" behind CONFIG_KVM_AMD_SEV=3Dy
>       KVM: SEV: Document that checking for SEV+ guests when reclaiming me=
mory is "safe"
>       KVM: SEV: Assert that kvm->lock is held when querying SEV+ support
>       KVM: SEV: Goto an existing error label if charging misc_cg for an A=
SID fails
>
>  arch/x86/include/asm/kvm_host.h                    |  29 +-
>  arch/x86/kvm/svm/avic.c                            |  17 +-
>  arch/x86/kvm/svm/sev.c                             | 374 ++++++++++++---=
------
>  arch/x86/kvm/svm/svm.c                             | 270 ++++++++-------
>  arch/x86/kvm/svm/svm.h                             |  37 +-
>  arch/x86/kvm/x86.c                                 |  45 ++-
>  include/linux/kvm_host.h                           |   7 +
>  .../testing/selftests/kvm/x86/sev_migrate_tests.c  |   2 -
>  8 files changed, 487 insertions(+), 294 deletions(-)
>

