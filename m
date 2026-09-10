Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F83B1EEF
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066729; cv=pass; b=qUZG9EqKwIn+wrjRmtQOp7lVkkk1jkOJyyxvouuoCaKXOLztJxtkzbPeb1bngqTlRRuqutofiIXRTZAG3+gcAWz3THMYQvzhgEm9PtGeTdbnb7rLBNDUgFupAh7ixuOEeVSA6QBykLczLP0BBNemt1o+OjYMm/FcWlv0HljuqXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066729; c=relaxed/simple;
	bh=4uJOjuShBwWLtphZjerKycWL4xXTU123kfZIyQdrPiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpusgBNsKYMPBk25+g45cvs+fFEhKVZB5Kb/mDHuACOPFsOg+Ajv443KZax+LqK18Iuk8TtSh8ySP5CMq3FAsh/jC4CKj1zTxjkH28b5QrA/KO0cCScOGx2b/9J4kbB9z/+Hx9k03bqfhib5r/qVdRm3AZX3lVKgBUizwRbThcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqWzbty0; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqWzbty0"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a9b4e73feaso209815a12.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 11:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789066725; cv=none;
        d=google.com; s=arc-20260327;
        b=mOkcXEmrMQC7v2RvIxrNRdoYVHCKSmW/xZcNuZ97yyEjks91rmh3dcdWRPXdImDkBI
         fk3h1E64iSefivDb34BP/IgGUWnb5pQNfVUkWP2elK/Pvk6WrimPSlVQkk+O6KWljRTm
         NPFAVearQkKY0tzsfySCJAWoc8MIx4MBGw9v2klF0W+kxIlG3Y2vZ5IUEFIpljxOoqVu
         RxqdZzr5tYFIxx2Co2gGyy/Sx9YDwQJbmYKy8wLD6VsA61+xrHm0V4c5BwGTNurFOQ7Q
         wNCsKnJen0mx9C8h11Bl3uyDDT6uEPGP5nczhBER8Z1LWjHSs8Rm6ztgpnmcSB85UOxS
         5xKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HQqZIquyuP45TVqeu7OsKl4uUPqmuzFoyabpJxAg8u0=;
        fh=KSEqC30WiUCbnrSR+VK+/YATpFykfk9+JOuWMnL8C0Q=;
        b=m6bkfgaA3GBrZSGzi+KMRI20iiMS5kJUpDdRfyA2LF1r1g9Y8UFL+/A8eiwrdZopy/
         3enqciYK7/i5z7yEzMIaa1f/PvY00QM3pM5P4f19rZP/0sbpBvh6re5kJzVnAguq9TNI
         tedoWxzH147xDJTMbf+Fggo5lay/hc1Mpub8kHf0oYPnU0xNzMPoHD/8r/Bt3J3d5b5W
         mSJrcgaFgBe7ya2rlUXGjbMbWSbdcDIFjQdBaTYg5nUUIMAW7HsvWjQocp+59yaCwi53
         L1zC2jMc5k9gKCSvWoc3TpxaFqlXC8r1AYy3CytTq6bc8PGNgLegbbDwK30q1Bj/bOxJ
         kqQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789066725; x=1789671525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HQqZIquyuP45TVqeu7OsKl4uUPqmuzFoyabpJxAg8u0=;
        b=nqWzbty0NBOCbeCJPrayjVXZj0R6FKVavkd4Kc1oQ2BJ6zrFfbkXH8sZcwblkL0paG
         44FHjgKoAXRb3GSJG1N/jga6AkAd96CXSwJtnAhu0q61uGIXURIfv6L23ldmlfmwvIl3
         2xnpgoa87VyFrFmWUPBqA2gEyzj434CoKLoi+r8p8vJNfXpg6zEd7Vv2q9/OSuHQBbiP
         DwR7xwQ3pqJQogfVtQt9gZwJwpd2ygb4RBSD/OJFHyXby9CyM8xRVnxoGksaXfpSnskU
         C1Ary5McC80HyvMxe53/l8girwDx3wFKYH3KMoQ0QIbU8Hv4cJRmwbEWybMFGEkrBihT
         zQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066725; x=1789671525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HQqZIquyuP45TVqeu7OsKl4uUPqmuzFoyabpJxAg8u0=;
        b=qdfKZhpVq/1BuX1+EqY9XamxqDEakGcZVjvMggE3A86nrX2/yQxOV03wnVsco1MIo1
         qscadl/tTj6d6gBcDJQOeCOHtpuRtUTp7DZUZMCezQ7fnAT9+Prz5dIVk+so29oIDs/9
         c7PMAbK1P16PSJC/0Btlyr/BdedH7bGFx3M+5GldCt2XvstV3qKJoeMscfUyHxpQqwco
         9K7g+7OsGd/yn796W64Snkz6M1qe2nsjcGNrTWZL6mbL11Qu61pecndzr+F7wodhLZGj
         8Wt/epkDHpnHN6jcU5OWilwNn0Zv8XaqX1JVO09lzavAgGE2QewtYVjpGFG/veWA9a5k
         bw2A==
X-Forwarded-Encrypted: i=1; AKwUvBxkqqFdqJOyyMUHJtuLgVm4kffGLKc/xWOVDGmaRzqZjjNGHp3zy3vuaFA8OJnC++WNlus=@vger.kernel.org
X-Gm-Message-State: AFuF++lj07s8p7W2WIRgQBGJFd2UVKSlI/dX8VX3RnGRKu4fRk3a2Z+v
	biLlBSH57xoj8IE2/CjBrrqMTkd7VoCsuvXxyYrV0r+Zo5+vC+wjU/RK56K0JWW3QKjRnkHJpRA
	NEnmWnr4irhpkds49WSowLUI9GogIviXHfYI88gWT
X-Gm-Gg: AYBFou2CQtgrGuOGN05rjR0g64IBYYnjHyB7PgTLPie+thgT2tTAoSEbhXdO/tKJycg
	lsaoblbQTAGuqcZzh47RVt95AJi3QrOq/qdkEDYv7ATVSXhgh29PUPfto61RbYzisKlxstbP1Fn
	VOdTFdz6n9an/UCupY0559JXES8w3fi5jEinBglOegIKQXrIC3k/tJaiphsM0RtS2UA3yGjuwqH
	uECZW4HwoK115MTkktEDc37Rxe7wKfXYY9WjflUIkg5bVDoHUFsxbQ02v5vfTqzMan0kDf6Qx1u
	/XBM/3ybWM+oFJJ3sGhsMjx5ZK1juEycnIW4hz+RqhJRDy1ye/gwc8SHtKIXJ9d7/inrzRUohAP
	8cKepDd0SQ2sKEB40UT1B/kceOYUWl0mwy5OhuhAo2mc4q91XJciVfrNVTtY/HHnBq89+bfWofm
	eRwfqw0XDIqUwi67Ug68Vmu2E=
X-Received: by 2002:a17:907:1b18:b0:c26:1691:b368 with SMTP id
 a640c23a62f3a-c261691b9e2mr1568936666b.33.1789066724035; Thu, 10 Sep 2026
 11:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com> <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
 <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com> <aqGsukcRG6khmxpt@google.com>
In-Reply-To: <aqGsukcRG6khmxpt@google.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 10 Sep 2026 11:58:07 -0700
X-Gm-Features: AcwNN1WLwJW3KNE6RfNY_nN3EYlV3ulbOc4d2X94HLA4GgWJWiLcf20fkOLPcKI
Message-ID: <CADrL8HWRjzzs7YmNkGDYQWDnygw=OcdgqCWCOfdt9af0-XwvVw@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:00=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Sep 08, 2026, Jim Mattson wrote:
> > On Tue, Sep 8, 2026 at 10:35=E2=80=AFAM James Houghton <jthoughton@goog=
le.com> wrote:
> > >
> > > On Tue, Sep 8, 2026 at 6:54=E2=80=AFAM Jim Mattson <jmattson@google.c=
om> wrote:
> > > >
> > > > When a vCPU is destroyed while L2 is active, KVM synthesizes a nest=
ed
> > > > VM-Exit, which flushes the cached shadow VMCS12 back to guest memor=
y:
> > > >
> > > >   vmx_vcpu_free()
> > > >   |-> nested_vmx_free_vcpu()
> > > >       |-> vmx_leave_nested()
> > > >           |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
> > > >               |-> nested_flush_cached_shadow_vmcs12()
> > > >                   |-> kvm_write_guest_cached()
> > > >                       |-> __copy_to_user(ghc->hva, ...)
> > > >
> > > > During process exit, do_exit() calls exit_mm() before closing file
> > > > descriptors, so vCPU destruction runs with current->mm =3D=3D NULL =
on a
> > > > borrowed lazy TLB active_mm. If the borrowed address space has a wr=
itable
> > > > mapping at ghc->hva, __copy_to_user() corrupts an unrelated task's =
memory.
> > > >
> > > > Skip the flush when KVM synthesizes a VM-exit with vm_exit_reason =
=3D=3D -1
> > > > (e.g. during vCPU teardown or SMM entry). In these paths, KVM force=
s the
> > > > vCPU out of guest mode internally--no architectural VM-exit is deli=
vered
> > > > to L1.
> > > >
> > > > Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and=
 flush to memory on VMExit")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Jim Mattson <jmattson@google.com>
> > >
> > > Hi Jim,
> > >
> > > This patch looks good for a stable backport, but I feel this kind of
> > > bug could easily happen again with the current API.
> > >
> > > One simple thing that would have prevented this would be to:
> > > 1. Change kvm_write_guest_cached() (and related) to take the vcpu
> > > instead of the kvm, and
> > > 2. Check that vcpu->mm =3D=3D current->mm before doing the uaccess.
>
> The mm pointer is store in "kvm", not in "kvm_vcpu", i.e. this sort of ha=
rdening
> shouldn't require modifying the callsites.

Yeahhh, I noticed this a few minutes after I sent that email, heh. :(

> > > This wouldn't be as suitable for a backport, but I think it's better
> > > for preventing similar classes of bugs. I'm sure you (and
> > > Paolo/Sean/others) will have better ideas. What do you think?
> >
> > There seems to be some awareness of this issue within KVM, so that may
> > not be necessary. Also, as Sashiko points out, we have issues with
> > reads as well as writes. I don't know how many choke points we'd have
> > to test.
> >
> > AFAICT (with AI assistance), all of the current problems are rooted in
> > the following call to nested_vmx_vmexit():
> >
> > void vmx_leave_nested(struct kvm_vcpu *vcpu)
> > {
> >         if (is_guest_mode(vcpu)) {
> >                 vcpu->arch.nested_run_pending =3D 0;
> >                 nested_vmx_vmexit(vcpu, -1, 0, 0);
> >         }
> >         free_nested(vcpu);
> > }
> >
> > On the SVM side, there is no comparable faux VM-exit. Instead of
> > calling nested_svm_vmexit(), the teardown of SVM nested state is an
> > open-coded sequence. Maybe something like that would work better for
> > VMX?
>
> Yes, vmx_leave_nested()'s use of nested_vmx_vmexit() is an endless source=
 of pain
> and needs to be rewritten.
>
> However, the bigger flaw is that the memslots are still valid when the VM=
 is
> being destroyed.  The hardening James suggested above really should be ha=
rdening,
> not the primary mechanism for ensuring correctness.
>
> Manually freeing each memslot one-by-one isn't a great option, because th=
e latency
> introduced by each synchronize_srcu_expedited() call would be rather absu=
rd.  But
> once KVM unregisters its mmu_notifier, i.e. once kvm_mmu_notifier_release=
() and
> thus kvm_flush_shadow_all() runs, all indirect references to memslots nee=
d to be
> gone.  And by "indirect references" I mean code in KVM that relies on a m=
emslot
> existing and being reachable, e.g. x86's rmaps and shadow page accounting=
.
>
> KVM is infuriatingly close to enforcing that already, as only kvm_arch_de=
stroy_vm()
> and kvm_destroy_devices() run between unregistering the mmu_notifier and =
freeing
> all memslot metadata.
>
>         mmu_notifier_unregister(&kvm->mmu_notifier, kvm->mm);
>         /*
>          * At this point, pending calls to invalidate_range_start()
>          * have completed but no more MMU notifiers will run, so
>          * mn_active_invalidate_count may remain unbalanced.
>          * No threads can be waiting in kvm_swap_active_memslots() as the
>          * last reference on KVM has been dropped, but freeing
>          * memslots would deadlock without this manual intervention.
>          *
>          * If the count isn't unbalanced, i.e. KVM did NOT unregister its=
 MMU
>          * notifier between a start() and end(), then there shouldn't be =
any
>          * in-progress invalidations.
>          */
>         WARN_ON(rcuwait_active(&kvm->mn_memslots_update_rcuwait));
>         if (kvm->mn_active_invalidate_count)
>                 kvm->mn_active_invalidate_count =3D 0;
>         else
>                 WARN_ON(kvm->mmu_invalidate_in_progress);
>         kvm_arch_destroy_vm(kvm);
>         kvm_destroy_devices(kvm);
>         for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>                 kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
>                 kvm_free_memslots(kvm, &kvm->__memslots[i][1]);  <=3D=3D=
=3D KVM will be very sad after this
>
>         }
>
> Destroying memslots before kvm_destroy_devices() is a-ok, all implementat=
ions do
> nothing more than kvm_io_bus_unregister_dev() (a nop at this point in the=
 VM's
> lifecycle, as buses are already destroyed), and free of memory.
>
> Unfortunately, kvm_arch_destroy_vm() is practically infeasible to audit. =
 But, we
> don't need to audit that code, we just need to audit kvm_arch_flush_shado=
w_memslot(),
> because if there are memslot references that are dropped by flush_shadow_=
memslot()
> but not flush_shadow_all(), then KVM is already buggy and vulnerable.
>
> *sigh*
>
> And of course PPC is a disaster and does literally nothing on flush_shado=
w_all().
> Doubly hilarious, the worst offender seems to be kvmhv_release_all_nested=
().  As
> a quick and dirty fix, I think we can simply iterate over memslots and ma=
nually
> flush each one?
>
> Which, amazingly, appears to be safe even though kvmppc_uvmem_drop_pages(=
) takes
> mmap_lock, as exit_mmap()'s call to mmu_notifier_release() is (thanfully)=
 super
> obviously done without hold mmap_lock.
>
>         /* mm's last user has gone, and its about to be pulled down */
>         mmu_notifier_release(mm);
>
>         mmap_read_lock(mm);
>
> diff --git arch/powerpc/include/asm/kvm_host.h arch/powerpc/include/asm/k=
vm_host.h
> index 2d139c807577..1c8d9d7360e9 100644
> --- arch/powerpc/include/asm/kvm_host.h
> +++ arch/powerpc/include/asm/kvm_host.h
> @@ -903,7 +903,6 @@ struct kvm_vcpu_arch {
>  #define __KVM_HAVE_CREATE_DEVICE
>
>  static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {=
}
> -static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
>  static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
>
> diff --git arch/powerpc/kvm/powerpc.c arch/powerpc/kvm/powerpc.c
> index 9194cf492d1c..2b88fb9e9bc4 100644
> --- arch/powerpc/kvm/powerpc.c
> +++ arch/powerpc/kvm/powerpc.c
> @@ -764,6 +764,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>         kvmppc_core_commit_memory_region(kvm, old, new, change);
>  }
>
> +void kvm_arch_flush_shadow_all(struct kvm *kvm)
> +{
> +       struct kvm_memory_slot *memslot;
> +       struct kvm_memslots *slots;
> +       int bkt;
> +
> +       slots =3D kvm_memslots(kvm);
> +       kvm_for_each_memslot(memslot, bkt, slots)
> +               kvmppc_core_flush_memslot(kvm, slot);
> +}
> +
>  void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>                                    struct kvm_memory_slot *slot)
>  {
>
> If the above works for PPC, then KVM can nuke memslots before calling int=
o
> kvm_arch_destroy_vm().  x86's asinine memslot deletion in kvm_arch_destro=
y_vm()
> needs to be addressed, but that code exists purely to do vm_munmap(), and=
 can
> and should be moved to kvm_arch_free_memslot().
>
> All that said, I'm not sure this aggressive fix is the right thing to sen=
d to
> stable@.  For that, James' suggestion of hardening KVM's usage of
> __copy_{to,from}_user() seems like the best blend of being comprehensive =
without
> being overly invasive/risky.

This seems kind of nightmareish to backport; there are a lot of
copy_*_user() callsites that will need updating. Maybe I have a
different idea of the diff you're suggesting.

I wish we could just change the uaccess primitives, like
{,__}access_ok(), to check that `current->mm` is not NULL (and WARN
and return -EFAULT if it is NULL). That diff is also not trivial to
backport; many arch implementations would need updating. I have half a
mind to send an RFC patch to linux-mm@ to see what they think. :)

> So, as an immediate set of changes, what if we do this over ~5 patches, w=
ith patches
> 1 and 2 tagged for stable@?
>
>   1. Add kvm_copy_{to,from}_user{,_inatomic)() and return -EFAULT if curr=
ent->mm
>      is not kvm->mm.

SGTM. This is not mutually exclusive with the generic uaccess changes
I'm suggesting above. If this is actually reasonably backportable,
sure let's backport it.

>   2. Hack-a-fix PPC's kvm_arch_flush_shadow_all().
>   3. Do x86's vm_munmap() in kvm_arch_free_memslot().
>   4. Nuke memslots before calling kvm_arch_destroy_vm().
>   5. Change the current->mm checks in kvm_copy_{to,from}_user{,_inatomic)=
() to
>      WARN_ON_ONCE() on failure.
>
> And then in the near-ish future, take things a step further and do:
>
>   6. Fix the vmx_leave_nested() trainwreck.
>   7. Harden the common kvm_{read,write}_guest family of APIs even further=
 by
>      adding an early WARN_ON_ONCE() on current->mm !=3D kvm->mm, i.e. to =
detect
>      bad KVM behavior as additional defense-in-depth.

This all SGTM, thanks Sean.
