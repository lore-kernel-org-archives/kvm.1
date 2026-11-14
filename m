Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794631683;
	b=k0EiD/2McP7PfnKRSyQROKca9O8E/ABZZTKPmnR3/EkWn2nbOvgQpclANIzcB8Rrg4ls
	 Xne0dcUe1Ie1vaokWNmP+IB/Y9qebUe/ZkuhAxn8F2yeaKyEa0OlapactPmfa/tCn382a
	 ZU03n+drtugMcViIXFxIlRelaQewE5dwXNFK/8pK8ua4CBxpbn4gA6kk1f2IEwyStUMqU
	 Ua+D48brl06S3sFUL/GeT16iUsegfTxy505goRI7Evyrsv2HnzBV5myYd4On7ptjSaI8B
	 lDtRdz9RaWxE2XS/5sU2V6vJpZf+H4ObGBeeQ/2pCfMzixiqmPgOt0t9/mRV1Me5eyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794631683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=B8fxqrvhHZTTTWs47E4Q6fA/0LXL6B0HEu4oICUPWP8=;
	b=vQ3cct0XZ/2AlSveKyB78d+YljTEDiZRWXQUDxhS4Ek4uQTQTygb45UHwbSlN3W0Cujt
	 wzv9BIUMpptuJphXGUqyKxS8d7bN/HDjcFYZr046MO7H5ocd5Cd50YPp6hWpy0XiasjQD
	 Q22AA2ZSkCAlR2h/rDUq+mfcFy1tUWEYGsw3pSKaXAKAVQlK47pR8zgurKOzxdoupZlox
	 +zJWoXRq5tAyvEn+/u6DN7M5L4pGWAXtyM6mMTqdoVd34MTFuXDjrHPXZkIrRpfmJty/E
	 6VO2mvYOz8PENLy/3PsalE/TXL3TR6cye5JjMcA2gpjnI/m6fqCXr2bb+mUmiTNsjhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tensorlake.ai;
	spf=pass smtp.mailfrom=tensorlake.ai;
	dkim=pass header.d=tensorlake.ai header.i=@tensorlake.ai header.a=rsa-sha256 header.s=google header.b=gK2ka8MT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC5606A323
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 04:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28BC5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tensorlake.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tensorlake.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tensorlake.ai header.i=@tensorlake.ai header.a=rsa-sha256 header.s=google header.b=gK2ka8MT
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so2998584a12.3
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 20:48:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794631680; cv=none;
        d=google.com; s=arc-20260327;
        b=pt7SQCYE1rpx44f4oviKekuOlwoh/dLqoCRiGMztjjMMA459rMrwdLkUWDHbKAkKM0
         TzBGT4fXpI6xpH6BnCxoJTaWS90VhGhjc18mSBZWCpvJbCyAvasEiuWecCLfuGlyNOG1
         N5Fku++mU8sfgIyOTOKClRT6EV9PxMMlkghWkFV+2JiFqVKGqDpTg2aE1F0oumqX468N
         7TzNZQCfNwI/k9xEeAzNQlnBlRjkUoBV/Zn7I7kDhxrqA5SYL+cvqQJMuK2IwCNFMD7k
         xTc9UigGt63zDjYXHlmegeehMNnYCCESyf655rhVlxPbc8npp9UTqZ0y8v2eirZBjtkJ
         /F0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=B8fxqrvhHZTTTWs47E4Q6fA/0LXL6B0HEu4oICUPWP8=;
        fh=SkYeDQHuSnkUsj0t+mHHuwFo/r0J494Vr5wO1orZ1B8=;
        b=FUhMdSEeyPj5/zy1ATfAafuaU75W2JNOzmVSG3VWNckW92Fb7Wddnkjt+ilJeyfeLT
         aPZDOYkGsWJPIKsz2TfGlFeIWq1ViXvOEXfvEw+6zDgW1VC9KTmFAmSN3V0MZwpVsKfu
         mvkGb1HWgTDaW99dxTsr7qDUj3Xa8T/w6RvZ6VcjfcYVLPbevQKV84Aql0s7x6uJ76nX
         4qKq05XrXjPT2BrvN864tBUsH6v2Prf+YqK3ZmpHg7AdWNRuciQJg36Ff6ZtoF+/5Qzi
         W5rUQF4DoqQwazLUFxpaQ56cO9Pp30P0GPWSKm6bUCc+CyVs5ix3w25Ho69bHU0mskQO
         qQUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tensorlake.ai; s=google; t=1794631680; x=1795236480; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B8fxqrvhHZTTTWs47E4Q6fA/0LXL6B0HEu4oICUPWP8=;
        b=gK2ka8MT/y8pJhzLQcze3qbMiiGm5p1wAfo9O4pZz914YvSg1qQPdXBxAOzX/mHMzb
         B2c4Q/9FylsvfwgxEerlFjbpurSm8xIJWS5fxV44X9va+x+nN/+mF2TElwRHFhjhP5Iv
         uNrn+A+QUsmB/BnwkalBsc2IIvOmK6CR+ycDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794631680; x=1795236480;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B8fxqrvhHZTTTWs47E4Q6fA/0LXL6B0HEu4oICUPWP8=;
        b=1ChY5t3y5sbtMdOi4kGLu53a58p9HoAWSlpajTTwmACLbVOpumX/eJ852WPJdTUNnX
         DBOi6qzxUnz2hTnIlD5dw379mbhLztSkzfvP5ud3vZlTrdZKo+fk9eneNqxgp2AHcqAj
         dlM5aPdhnSTfsH1xqX9BbZ4RLP8QtfkoK/tbXaug61UnV9S1tJ6diOoUBUKPZgaIy4V2
         VMlQEoogkg8ctCr+ayAwgwUW49qcmylXJrS1g45brVXE9VuOfHpqC3o13jho8shYl22a
         r2uBfwj1kmNPPgr0+fS7l8VRomoPk8SY72Y4FZ7hh/bdhDAXPszB+gpUPPmTrso1veNq
         OxpA==
X-Gm-Message-State: APuU4Z+0Cx/v+8+aKilTyuPp7bEBtby/tKMSaffFSW1iok/OJoSADudl
	ynWwjgDgXjTWxv5EmVyuj2OwwzEn8pYH1+2cco5XkBBB4g92ukxghm690Uw6O2tJD/MG96z40AX
	W3RMSpExby60zuPPAhfdiB6Lxxdx8es34kOnywNXdQWmt5XcaY9Cq
X-Gm-Gg: AYBFou3TAHjl1ilbACb/kvzUMUQZMULiGKKCBfVyaYEaIrst+wSU0g+XNWrJCUbeoVi
	xPmkMdFFJ+a7IXjDsk3LFTcvkeBr6LYXqbAIaTZQJlpzRKN3FwgeiwMKleAb8+ylA0USBMLWypo
	MFBdPHvnvZqI96DFPvQLQEEghprXdi2qo2Dr+e5exzrP6T2SEBQqv3usnoRcBMmoEUmnpjvkxB+
	SZaIWutbydKzKjrrU+/5GvIOV/NLXWy0Mhfyu72aCsn7YgaJy/GjJRP8CW3LrtiEfU3XV/Mn9L0
	Lgo0OSz7B1Vt0mEVqc8ZXycdD/CbMoHKgAfgoW6nWihatAeoVZVkhpta1ifqcCpidNbDrxgbYET
	uloOUC3lKisDUAmX9f1cIbF0SCimOzieIAgPmz8AJKpcb7VcgokTxW0nF/pe2hd71gfm4
X-Received: by 2002:a05:6402:849:b0:6b7:c9d4:6b96 with SMTP id
 4fb4d7f45d1cf-6b7c9d47044mr2792871a12.8.1794631679895; Fri, 13 Nov 2026
 20:47:59 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 13 Nov 2026 23:47:59 -0500
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Diptanu Choudhury <diptanu@tensorlake.ai>
Date: Fri, 13 Nov 2026 23:47:59 -0500
X-Gm-Features: AclHuK9N2LFtUt1N9zHcALZHFO1LzaKSdDQKaJLz8ACqBg04P9rtZO4DPf4Nwro
Message-ID: <CAFD16ODkmQBbtCgR5iKB_xwXyCMhg=JE2dgXVULNsQMvHMYx+w@mail.gmail.com>
Subject: [PATCH] KVM: x86: Rebuild nested TDP shadows from L1's memory after
 INVEPT and nSVM TLB flushes
To: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

KVM keeps shadow copies of L1's nested EPT (nVMX) and NPT (nSVM) tables,
which it keeps in sync by write-protecting the guest pages it shadows:
vCPU writes to those pages fault, and emulated writes notify the shadow
MMU via kvm_page_track_write().  Writes from host userspace into guest
memory reach none of that: a VMM completing a virtio request, or any
vhost-user backend, writes through the memslot's userspace mapping
without ever touching write tracking.  A device write that lands on a
page L1 uses as a page table therefore leaves KVM's shadow of that page
stale.

Architecturally, INVEPT and SVM's VMCB TLB_CONTROL flushes require the
logical processor to stop using cached guest-physical translations, so
after L1 invalidates, L2 must see the updated tables, the same way it
would on hardware, where the CPU resumes walking the tables from
memory.  KVM does not provide that: handle_invept() only drops root
references, and kvm_mmu_find_shadow_page() then finds the old,
still-valid shadow pages in the page hash and reuses them, stale entry
included; nSVM ignores L1's tlb_ctl entirely.  A stale translation
therefore outlives the architectural invalidation, and an L2 can keep
using a mapping that its own hypervisor explicitly invalidated.
Android emulators and nested KVM, which update and restore their
guest's EPT/NPT tables with device writes, are the exposed workloads.

We hit this in production: a red-team probe had L1 update one entry of
an L1-built EPT table for its L2 through a virtio-blk read whose
destination buffer was the table page.  The vCPU-store control was
always correct; the device-write case served the stale page to L2
after single-context and global INVEPT, 69 times out of 83 runs on a
6.18.63 host.

Fix it with a nested TDP generation tracked per vCPU, because both
invalidations are per-logical-processor.  INVEPT (single-context and
global) and the TLB_CONTROL flush advance the executing vCPU's
generation and drop its nested root references;
kvm_mmu_find_shadow_page() no longer serves a vCPU a guest_mode page
whose generation predates the vCPU's, so the affected tables are
rebuilt from L1's memory on the next nested faults; and a nested root
whose last reference is dropped is zapped, so an invalidated shadow
subtree is reclaimed through the standard invalid-root lifecycle
instead of lingering in the page hash.  Other vCPUs keep their cached
translations, as they do on hardware, until they invalidate themselves.

A note on the design, since the obvious alternatives look simpler but
do not survive a nested-boot soak:

- Making the pages obsolete through a VM-wide generation and
  is_obsolete_sp() also marks the roots other vCPUs still have loaded,
  which forces freeing every vCPU's roots (is_page_fault_stale()
  retries otherwise), i.e. a remote root-free IPI per INVEPT; our soak
  hit KVM_INTERNAL_ERROR_DELIVERY_EV event-vectoring failures under
  those IPI storms.
- Eagerly zapping roots that other vCPUs still reference runs the
  shared root through the prepare_zap zapped-root lifecycle twice and
  corrupts the active page list.
- Marking a shared root invalid without delisting breaks the
  role.invalid implies delisted assumption and double-lists the page.

The shipped revision touches no shadow-page lifecycle state outside
the stock paths: no role.invalid writes, no delisting, no remote
requests.  The at-drop zap uses the stock invalid-root list_move
branch, and the per-vCPU generation only gates page-hash lookups.
Over-invalidation is possible per lookup: a vCPU that INVEPTs one EPTP
will also rebuild rather than reuse pages of another EPTP it holds;
pages are keyed by (gfn, role) and shared across EPTPs, so per-EPTP
precision is not worth the complexity.  Rebuilding is the demand-paged
work INVEPT buys on hardware.

Testing: new selftests for both architectures.  vmx_invept_test and
svm_nested_tlb_ctl_test build an L1 EPT/NPT table for L2, let L2 read
a marker page, rewrite one entry of that table (the leaf PTE, or the
upper entry pointing at the leaf table) either from the vCPU (the
control) or from host userspace through the memslot mapping (the
virtio completion case), then execute INVEPT / request a TLB_CONTROL
flush and require L2 to observe the new mapping.  Without the fix, the
host-write case keeps serving the stale marker after the invalidation
on both Intel (i7i.metal-24xl, Xeon 8559C) and AMD (r8a.metal-24xl,
EPYC 9R45).  vmx_invept_test also proves containment: after the host
frees the page behind a stale entry, L2 faults through the new entry
and never sees a byte of the reclaimed page.

Soak: a nested KVM boot loop (L1 = Debian trixie on a 6.18 host
kernel, 8 vCPU/8G; L2 = 4 vCPU/2G, 20 boots per run) crashed or
wedged the host for each of the rejected designs above; with this
revision, three runs per architecture completed 60/60 boots cleanly on
both Intel and AMD, with L2 boot time at parity with the unpatched
host kernel (median 1068ms before and after on Intel).  A synthetic
INVEPT-saturated loop (20 runs of the selftest) pays +7.9% wall time.

The patch is against 6.18.63 (our shipping kernel) with no other
KVM-local changes in the touched files; happy to rebase it wherever it
fits the queue.

Reported-by: Datadog Security Labs red team
Link: https://github.com/tensorlakeai/compute-engine-internal/issues/3291
Signed-off-by: Diptanu Choudhury <diptanu@tensorlake.ai>

KVM keeps shadow copies of L1's nested EPT (nVMX) and NPT (nSVM) tables,
which it keeps in sync by write-protecting the guest pages it shadows:
vCPU writes to those pages fault, and emulated writes notify the shadow
MMU via kvm_page_track_write().  Writes from host userspace into guest
memory reach none of that: a VMM completing a virtio request, or any
vhost-user backend, writes through the memslot's userspace mapping
without ever touching write tracking.  A device write that lands on a
page L1 uses as a page table therefore leaves KVM's shadow of that page
stale.

Architecturally, INVEPT and SVM's VMCB TLB_CONTROL flushes require the
logical processor to stop using cached guest-physical translations, so
after L1 invalidates, L2 must see the updated tables, the same way it
would on hardware, where the CPU resumes walking the tables from
memory.  KVM does not provide that: handle_invept() only drops root
references, and kvm_mmu_find_shadow_page() then finds the old,
still-valid shadow pages in the page hash and reuses them, stale entry
included; nSVM ignores L1's tlb_ctl entirely (its own TODO notes the
gap).  A stale translation therefore outlives the architectural
invalidation, and an L2 can keep using a mapping that its own
hypervisor explicitly invalidated.  Android emulators and nested KVM,
which update and restore their guest's EPT/NPT tables with device
writes, are the exposed workloads.

Track a nested TDP generation per vCPU.  INVEPT and the TLB_CONTROL
flush advance the vCPU's generation, and kvm_mmu_find_shadow_page()
no longer serves a guest_mode page whose generation predates the
vCPU's, so the next nested faults rebuild the affected tables from
L1's memory instead of reusing the cached ones.  Generations are
per-vCPU because both invalidations are per-logical-processor: the
other vCPUs keep their cached translations, as they do on hardware,
until they invalidate themselves.  A nested root whose last reference
is dropped is zapped, so an invalidated shadow subtree is reclaimed
instead of lingering in the page hash until the next memslot
generation change.

Add KVM selftests for both architectures.  vmx_invept_test and
svm_nested_tlb_ctl_test build an L1 EPT/NPT table for L2, let L2 read a
marker page, rewrite one entry of that table (the leaf PTE, or the
upper entry pointing at the leaf table) either from the vCPU (the
control) or from host userspace through the memslot mapping (the
virtio completion case), then execute INVEPT / request a TLB_CONTROL
flush and require L2 to observe the new mapping.  Without the fix, the
host-write case keeps serving the stale marker after the invalidation.
vmx_invept_test also proves containment: after the host frees (munmap)
the page behind a stale entry, L2's next access faults through the new
entry and never sees a byte of the reclaimed page, so the effect cannot
reach memory outside the sandbox even before the fix.

Reported-by: Datadog Security Labs red team
Link: https://github.com/tensorlakeai/compute-engine-internal/issues/3291
Signed-off-by: Diptanu Choudhury <diptanu@tensorlake.ai>

Backport note: Tensorlake-authored fix, not yet merged upstream.  Line
numbers are relative to Linux 6.18.63 with patches 0001..0012 of this
tree applied.  When the fix is accepted upstream, replace the two lines
above with the upstream commit id and a Link: line.
---
 arch/x86/include/asm/kvm_host.h                    |   8 +
 arch/x86/kvm/mmu/mmu.c                             |  33 +-
 arch/x86/kvm/mmu/mmu_internal.h                    |   7 +
 arch/x86/kvm/svm/nested.c                          |  27 +-
 arch/x86/kvm/vmx/nested.c                          |  21 +-
 tools/testing/selftests/kvm/Makefile.kvm           |   2 +
 .../selftests/kvm/x86/svm_nested_tlb_ctl_test.c    | 227 +++++++++++++++++++++
 .../selftests/kvm/x86/vmx_invept_test.c            | 216 +++++++++++++++++++++
 8 files changed, 535 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 319aeac..82ec068 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -471,6 +471,14 @@ struct kvm_mmu {
 	union kvm_cpu_role cpu_role;
 	union kvm_mmu_page_role root_role;

+	/*
+	 * Nested TDP (nVMX/nSVM) cache generation for the vCPU: bumped when
+	 * L1 invalidates its cached guest-physical translations (INVEPT, VMCB
+	 * TLB_CONTROL flush).  Shadow pages stamped with an older generation
+	 * are not reused for this vCPU, see kvm_mmu_find_shadow_page().
+	 */
+	u64 nested_tdp_epoch;
+
 	/*
 	* The pkru_mask indicates if protection key checks are needed.  It
 	* consists of 16 domains indexed by page fault error code bits [4:1],
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 835b0c2..a9ac2af 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2279,6 +2279,23 @@ static struct kvm_mmu_page
*kvm_mmu_find_shadow_page(struct kvm *kvm,
 			continue;
 		}

+		/*
+		 * A nested TDP (nVMX/nSVM) shadow page caches L1's
+		 * guest-physical translations for the logical processor of
+		 * the vCPU it was built for.  INVEPT and the VMCB
+		 * TLB_CONTROL flush are per-logical-processor
+		 * invalidations: once the vCPU has executed one, reusing its
+		 * older pages would keep translations alive that L1
+		 * invalidated, and those pages can be stale in ways that
+		 * shadowing a vCPU write would have caught, because host
+		 * userspace and device writes to the L1 page tables bypass
+		 * guest write tracking.  Rebuild from L1's memory instead.
+		 */
+		if (sp->role.guest_mode &&
+		    (!vcpu ||
+		     sp->nested_tdp_epoch != vcpu->arch.guest_mmu.nested_tdp_epoch))
+			continue;
+
 		/*
 		 * Note!  Unlike fully direct MMUs, direct SPs in indirect MMUs
 		 * can have an arbitrary number of parents, e.g if the guest is
@@ -2399,6 +2416,8 @@ static struct kvm_mmu_page
*__kvm_mmu_get_shadow_page(struct kvm *kvm,
 	if (!sp) {
 		created = true;
 		sp = kvm_mmu_alloc_shadow_page(kvm, caches, gfn, sp_list, role);
+		sp->nested_tdp_epoch = role.guest_mode && vcpu
+			? vcpu->arch.guest_mmu.nested_tdp_epoch : 0;
 	}

 	trace_kvm_mmu_get_page(sp, created);
@@ -3819,7 +3838,19 @@ static void mmu_free_root_page(struct kvm *kvm,
hpa_t *root_hpa,
 		kvm_tdp_mmu_put_root(kvm, sp);
 	} else {
 		lockdep_assert_held_write(&kvm->mmu_lock);
-		if (!--sp->root_count && sp->role.invalid)
+		/*
+		 * Nested TDP (nVMX/nSVM) roots cache L1's guest-physical
+		 * translations for this vCPU.  Once the last reference is
+		 * dropped the pages must not linger in the page hash, as
+		 * they may be stale (host userspace and device writes to
+		 * the L1 page tables bypass guest write tracking) and stale
+		 * reuse after INVEPT or a TLB_CONTROL flush resurrects
+		 * translations that L1 invalidated.  Zap the root so its
+		 * shadow pages are reclaimed and the next nested entry
+		 * rebuilds from L1's memory.
+		 */
+		if (!--sp->root_count &&
+		    (sp->role.invalid || sp->role.guest_mode))
 			kvm_mmu_prepare_zap_page(kvm, sp, invalid_list);
 	}

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index ed5c01d..5c29c9c 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -82,6 +82,13 @@ struct kvm_mmu_page {
 	union kvm_mmu_page_role role;
 	gfn_t gfn;

+	/*
+	 * Nested TDP (nVMX/nSVM) cache generation of the vCPU this page was
+	 * built for; see struct kvm_mmu.nested_tdp_epoch.  Only meaningful
+	 * when role.guest_mode, all other pages stamp 0.
+	 */
+	u64 nested_tdp_epoch;
+
 	u64 *spt;

 	/*
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 064a2bb..691679a 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -578,12 +578,8 @@ static void
nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
 	 *
 	 *  - Flush TLBs for both L1 and L2 remote TLB flush
 	 *  - Honor L1's request to flush an ASID on nested VMRUN
-	 *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
 	 *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
 	 *  - Flush L1's ASID on KVM_REQ_TLB_FLUSH_GUEST
-	 *
-	 * [*] Unlike nested EPT, SVM's ASID management can invalidate nested
-	 *     NPT guest-physical mappings on VMRUN.
 	 */
 	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
@@ -812,6 +808,29 @@ static void nested_vmcb02_prepare_control(struct
vcpu_svm *svm)
 	/* Also overwritten later if necessary.  */
 	vmcb02->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;

+	/*
+	 * A TLB_CONTROL flush requested by L1 is performed at VMRUN and
+	 * architecturally invalidates the flushed ASIDs' cached nested NPT
+	 * (guest-physical) translations, including on this logical
+	 * processor.  Userspace and device writes to L1's NPT tables bypass
+	 * guest write tracking, so the cached shadow pages can be stale.
+	 * Advance the vCPU's nested TDP generation so its older shadow
+	 * pages are no longer reused (kvm_mmu_find_shadow_page), and drop
+	 * the nested root references so that L2's shadow page tables are
+	 * rebuilt from L1's memory on this VMRUN.
+	 */
+	if (svm->nested.ctl.tlb_ctl == TLB_CONTROL_FLUSH_ALL_ASID ||
+	    (nested_npt_enabled(svm) &&
+	     (svm->nested.ctl.tlb_ctl == TLB_CONTROL_FLUSH_ASID ||
+	      svm->nested.ctl.tlb_ctl == TLB_CONTROL_FLUSH_ASID_LOCAL))) {
+		write_lock(&vcpu->kvm->mmu_lock);
+		vcpu->arch.guest_mmu.nested_tdp_epoch++;
+		write_unlock(&vcpu->kvm->mmu_lock);
+
+		kvm_mmu_free_roots(vcpu->kvm, &vcpu->arch.guest_mmu,
+				   KVM_MMU_ROOTS_ALL);
+	}
+
 	/* nested_cr3.  */
 	if (nested_npt_enabled(svm))
 		nested_svm_init_mmu_context(vcpu);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ffca5fe..ac12546 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6164,8 +6164,27 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 		break;
 	}

-	if (roots_to_free)
+	if (roots_to_free) {
+		/*
+		 * INVEPT architecturally invalidates the logical processor's
+		 * cached guest-physical translations for the affected
+		 * EPTP(s): the processor resumes walking the tables from
+		 * memory.  Freeing the root references is not enough for
+		 * that: the shadow pages stay in the page hash and are
+		 * reused as-is by the next nested entry, and they can be
+		 * stale because userspace and device writes to L1's EPT
+		 * tables bypass guest write tracking.  Advance the vCPU's
+		 * nested TDP generation so its older shadow pages are no
+		 * longer reused (kvm_mmu_find_shadow_page), and drop the
+		 * root references so the tables are rebuilt from L1's
+		 * memory on the next nested entry.
+		 */
+		write_lock(&vcpu->kvm->mmu_lock);
+		mmu->nested_tdp_epoch++;
+		write_unlock(&vcpu->kvm->mmu_lock);
+
 		kvm_mmu_free_roots(vcpu->kvm, mmu, roots_to_free);
+	}

 	return nested_vmx_succeed(vcpu);
 }
diff --git a/tools/testing/selftests/kvm/Makefile.kvm
b/tools/testing/selftests/kvm/Makefile.kvm
index 1715efe..71fdbc4 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -105,6 +105,7 @@ TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
+TEST_GEN_PROGS_x86 += x86/svm_nested_tlb_ctl_test
 TEST_GEN_PROGS_x86 += x86/tsc_scaling_sync
 TEST_GEN_PROGS_x86 += x86/sync_regs_test
 TEST_GEN_PROGS_x86 += x86/ucna_injection_test
@@ -112,6 +113,7 @@ TEST_GEN_PROGS_x86 += x86/userspace_io_test
 TEST_GEN_PROGS_x86 += x86/userspace_msr_exit_test
 TEST_GEN_PROGS_x86 += x86/vmx_apic_access_test
 TEST_GEN_PROGS_x86 += x86/vmx_close_while_nested_test
+TEST_GEN_PROGS_x86 += x86/vmx_invept_test
 TEST_GEN_PROGS_x86 += x86/vmx_dirty_log_test
 TEST_GEN_PROGS_x86 += x86/vmx_exception_with_invalid_guest_state
 TEST_GEN_PROGS_x86 += x86/vmx_msrs_test
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_tlb_ctl_test.c
b/tools/testing/selftests/kvm/x86/svm_nested_tlb_ctl_test.c
new file mode 100644
index 0000000..82e37f3
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_nested_tlb_ctl_test.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Host writes to L1's nested NPT tables must become visible to L2 after L1
+ * requests a TLB_CONTROL flush at VMRUN.  Userspace writes into guest memory
+ * bypass guest write tracking, so KVM's shadow of L1's NPT tables can be
+ * stale; the VMCB TLB_CONTROL flush architecturally invalidates the incoming
+ * ASID's cached guest-physical translations, so L2 must observe the new
+ * mapping after a flush, even when the table entry was written from host
+ * userspace.  The vCPU-write control proves the test can observe an update;
+ * the flush is what makes the host write visible.
+ */
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+
+#define DATA_GPA 0xc0000000ul
+#define ENTRY_GVA 0xd0000000ul
+#define GPA_MASK 0x000ffffffffff000ul
+#define MARKER_A 0xaaaaaaaaaaaaaaaaul
+#define MARKER_B 0xbbbbbbbbbbbbbbbbul
+
+struct npt_desc {
+	u64 npt_root_gpa;
+};
+
+static volatile u64 observed;
+static u8 tlb_ctl;
+static bool cpu_write;
+static u64 *guest_entry;
+static u64 replacement;
+static uint64_t l2_stack[256];
+
+static void l2_guest_code(void)
+{
+	observed = READ_ONCE(*(u64 *)DATA_GPA);
+	asm volatile("vmmcall");
+	GUEST_FAIL("L2 ran past VMMCALL");
+}
+
+static void l1_guest_code(struct svm_test_data *svm, struct npt_desc *desc)
+{
+	struct vmcb *vmcb = svm->vmcb;
+	uint64_t *l2_stack_top = &l2_stack[ARRAY_SIZE(l2_stack)];
+
+	/* Prepare for L2 execution with NPT. */
+	generic_svm_setup(svm, l2_guest_code, l2_stack_top);
+	vmcb->control.nested_ctl = SVM_NESTED_CTL_NP_ENABLE;
+	vmcb->control.nested_cr3 = desc->npt_root_gpa;
+
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	GUEST_ASSERT_EQ(vmcb->control.exit_info_1, 0);
+	GUEST_ASSERT_EQ(observed, MARKER_A);
+
+	GUEST_SYNC(1);
+	if (cpu_write)
+		WRITE_ONCE(*guest_entry, replacement);
+
+	vmcb->control.tlb_ctl = tlb_ctl;
+	vmcb->save.rip = (u64)l2_guest_code;
+	vmcb->save.rsp = (u64)l2_stack_top;
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	GUEST_ASSERT_EQ(observed, MARKER_B);
+	GUEST_DONE();
+}
+
+static u64 *npt_new_table(struct kvm_vm *vm, u64 *gpa)
+{
+	vm_vaddr_t gva = vm_vaddr_alloc_page(vm);
+	u64 *hva = addr_gva2hva(vm, gva);
+
+	memset(hva, 0, vm->page_size);
+	*gpa = addr_gva2gpa(vm, gva);
+	return hva;
+}
+
+/* Identity-map @gpa in the 4-level NPT rooted at @root_hva. */
+static void npt_map(struct kvm_vm *vm, u64 *root_hva, u64 gpa)
+{
+	u64 *table = root_hva;
+	int level;
+
+	for (level = 4; level > 1; level--) {
+		int idx = (gpa >> (12 + 9 * (level - 1))) & 511;
+		u64 pte = READ_ONCE(table[idx]);
+
+		if (!(pte & 0x1)) {
+			u64 child_gpa;
+
+			npt_new_table(vm, &child_gpa);
+			pte = child_gpa | 0x27;
+			WRITE_ONCE(table[idx], pte);
+		}
+		table = addr_gpa2hva(vm, pte & GPA_MASK);
+	}
+	WRITE_ONCE(table[(gpa >> 12) & 511], (gpa & GPA_MASK) | 0x67);
+}
+
+/* Identity-map every backing page of @memslot in the NPT. */
+static void npt_map_memslot(struct kvm_vm *vm, u64 *root_hva, uint32_t memslot)
+{
+	struct userspace_mem_region *region = memslot2region(vm, memslot);
+	sparsebit_idx_t i, last;
+
+	i = (region->region.guest_phys_addr >> vm->page_shift) - 1;
+	last = i + (region->region.memory_size >> vm->page_shift);
+	for (;;) {
+		i = sparsebit_next_clear(region->unused_phy_pages, i);
+		if (i > last)
+			break;
+
+		npt_map(vm, root_hva, (uint64_t)i << vm->page_shift);
+	}
+}
+
+/*
+ * Return the host virtual address of the NPT entry that translates @gpa at
+ * @target_level (1 = the leaf PTE, 2 = the entry pointing at the leaf table).
+ */
+static u64 *npt_entry(struct kvm_vm *vm, u64 *root_hva, u64 gpa, int
target_level)
+{
+	u64 *table = root_hva;
+	int level;
+
+	for (level = 4; level > target_level; level--)
+		table = addr_gpa2hva(vm,
+				table[(gpa >> (12 + 9 * (level - 1))) & 511] & GPA_MASK);
+	return &table[(gpa >> (12 + 9 * (target_level - 1))) & 511];
+}
+
+static void run_test(bool cpu, u8 flush, int level)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct svm_test_data *svm;
+	struct npt_desc *desc;
+	vm_vaddr_t svm_gva, desc_gva;
+	struct ucall uc;
+	u64 *root_hva, *entry, *alternate;
+	u64 entry_gpa, alternate_gpa;
+
+	printf("%s write, TLB_CONTROL %s, NPT level %d\n", cpu ? "vCPU" : "host",
+	       flush == TLB_CONTROL_FLUSH_ASID ? "flush ASID" : "flush all", level);
+	fflush(stdout);
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	vcpu_alloc_svm(vm, &svm_gva);
+
+	desc_gva = vm_vaddr_alloc_page(vm);
+	desc = addr_gva2hva(vm, desc_gva);
+	root_hva = npt_new_table(vm, &desc->npt_root_gpa);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, DATA_GPA, 1, 2, 0);
+	virt_map(vm, DATA_GPA, DATA_GPA, 2);
+	*(u64 *)addr_gpa2hva(vm, DATA_GPA) = MARKER_A;
+	*(u64 *)addr_gpa2hva(vm, DATA_GPA + vm->page_size) = MARKER_B;
+
+	/*
+	 * Identity-map the guest image so L2 can reach its code, stack, the
+	 * VMCB and the global state, plus the marker pages.
+	 */
+	npt_map_memslot(vm, root_hva, 0);
+	npt_map(vm, root_hva, DATA_GPA);
+	npt_map(vm, root_hva, DATA_GPA + vm->page_size);
+
+	entry = npt_entry(vm, root_hva, DATA_GPA, level);
+	entry_gpa = addr_hva2gpa(vm, entry);
+	virt_map(vm, ENTRY_GVA, entry_gpa & GPA_MASK, 1);
+	guest_entry = (u64 *)(ENTRY_GVA + (entry_gpa & (vm->page_size - 1)));
+
+	if (level == 1) {
+		replacement = (READ_ONCE(*entry) & ~GPA_MASK) |
+			      (DATA_GPA + vm->page_size);
+	} else {
+		alternate = npt_new_table(vm, &alternate_gpa);
+		memcpy(alternate,
+		       addr_gpa2hva(vm, READ_ONCE(*entry) & GPA_MASK),
+		       vm->page_size);
+		alternate[(DATA_GPA >> 12) & 511] =
+			(READ_ONCE(*npt_entry(vm, root_hva, DATA_GPA, 1)) & ~GPA_MASK) |
+			(DATA_GPA + vm->page_size);
+		replacement = (READ_ONCE(*entry) & ~GPA_MASK) | alternate_gpa;
+	}
+
+	cpu_write = cpu;
+	tlb_ctl = flush;
+	sync_global_to_guest(vm, cpu_write);
+	sync_global_to_guest(vm, tlb_ctl);
+	sync_global_to_guest(vm, guest_entry);
+	sync_global_to_guest(vm, replacement);
+	vcpu_args_set(vcpu, 2, svm_gva, desc_gva);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	if (get_ucall(vcpu, &uc) == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+	TEST_ASSERT_EQ(uc.cmd, UCALL_SYNC);
+	TEST_ASSERT_EQ(uc.args[1], 1);
+	if (!cpu)
+		WRITE_ONCE(*entry, replacement);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	if (get_ucall(vcpu, &uc) == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+	TEST_ASSERT_EQ(uc.cmd, UCALL_DONE);
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char **argv)
+{
+	static const u8 flushes[] = {
+		TLB_CONTROL_FLUSH_ASID, TLB_CONTROL_FLUSH_ALL_ASID
+	};
+	bool cpu = argc > 1 && !strcmp(argv[1], "cpu");
+	int level, i;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_NPT));
+
+	for (i = 0; i < ARRAY_SIZE(flushes); i++)
+		for (level = 1; level <= 2; level++)
+			run_test(cpu, flushes[i], level);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86/vmx_invept_test.c
b/tools/testing/selftests/kvm/x86/vmx_invept_test.c
new file mode 100644
index 0000000..ea6be0d
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/vmx_invept_test.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Host writes to EPT must become visible after L1 executes INVEPT. */
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "vmx.h"
+
+#define DATA_GPA 0xc0000000ul
+#define ENTRY_GVA 0xd0000000ul
+#define GPA_MASK 0x000ffffffffff000ul
+#define MARKER_A 0xaaaaaaaaaaaaaaaaul
+#define MARKER_B 0xbbbbbbbbbbbbbbbbul
+
+static volatile u64 observed;
+static u64 invept_type;
+static bool cpu_write;
+static bool skip_invept;
+static u64 *guest_entry;
+static u64 replacement;
+
+static void l2_guest_code(void)
+{
+	observed = READ_ONCE(*(u64 *)DATA_GPA);
+	vmcall();
+	GUEST_FAIL("L2 ran past VMCALL");
+}
+
+static void invalidate_ept(void)
+{
+	struct { u64 eptp, reserved; } operand = { vmreadz(EPT_POINTER), 0 };
+	unsigned char fail;
+
+	asm volatile("invept %2, %1; setna %0"
+		     : "=qm"(fail) : "r"(invept_type), "m"(operand) : "cc", "memory");
+	GUEST_ASSERT(!fail);
+}
+
+static void l1_guest_code(struct vmx_pages *vmx)
+{
+	unsigned long stack[256];
+
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
+	GUEST_ASSERT(load_vmcs(vmx));
+	prepare_vmcs(vmx, l2_guest_code, &stack[ARRAY_SIZE(stack)]);
+	GUEST_ASSERT(!vmlaunch());
+	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+	GUEST_ASSERT_EQ(observed, MARKER_A);
+
+	GUEST_SYNC(1);
+	if (cpu_write)
+		WRITE_ONCE(*guest_entry, replacement);
+	if (!skip_invept)
+		invalidate_ept();
+	vmwrite(GUEST_RIP, (unsigned long)l2_guest_code);
+	GUEST_ASSERT(!vmresume());
+	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+	GUEST_ASSERT_EQ(observed, MARKER_B);
+	GUEST_DONE();
+}
+
+static u64 *ept_entry(struct kvm_vm *vm, struct vmx_pages *vmx,
+		      u64 gpa, int target_level)
+{
+	u64 *table = vmx->eptp_hva;
+	int level;
+
+	for (level = 4; level > target_level; level--)
+		table = addr_gpa2hva(vm, table[(gpa >> (12 + 9 * (level - 1))) &
511] & GPA_MASK);
+	return &table[(gpa >> (12 + 9 * (target_level - 1))) & 511];
+}
+
+/*
+ * A stale shadow mapping must not outlive the host backing of the page it
+ * points at: freeing (or migrating) the host page behind a stale entry must
+ * tear the cached mapping down even while it is still cached, so L2 can
+ * never reach host memory that the host has taken back.  This models L1
+ * ballooning out the page behind a stale entry: L2 must observe the new
+ * entry after the host reclaim, without any INVEPT.
+ */
+static void run_stale_free_test(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct vmx_pages *vmx;
+	vm_vaddr_t vmx_gva;
+	struct ucall uc;
+	u64 *entry, stale_target;
+	u64 entry_gpa;
+
+	printf("host reclaim of the page behind a stale entry\n");
+	fflush(stdout);
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	vmx = vcpu_alloc_vmx(vm, &vmx_gva);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, DATA_GPA, 1, 2, 0);
+	virt_map(vm, DATA_GPA, DATA_GPA, 2);
+	*(u64 *)addr_gpa2hva(vm, DATA_GPA) = MARKER_A;
+	*(u64 *)addr_gpa2hva(vm, DATA_GPA + 4096) = MARKER_B;
+	prepare_eptp(vmx, vm, 0);
+	nested_map(vmx, vm, DATA_GPA, DATA_GPA, 4096);
+	nested_map_memslot(vmx, vm, 0);
+	entry = ept_entry(vm, vmx, DATA_GPA, 1);
+	entry_gpa = addr_hva2gpa(vm, entry);
+	virt_map(vm, ENTRY_GVA, entry_gpa & GPA_MASK, 1);
+	guest_entry = (u64 *)(ENTRY_GVA + (entry_gpa & 4095));
+	stale_target = (*entry & ~GPA_MASK) | (DATA_GPA + 4096);
+	replacement = stale_target;
+	/* Point the L1 entry at page B, but leave L1 unaware: no store, no INVEPT. */
+	cpu_write = false;
+	skip_invept = true;
+	sync_global_to_guest(vm, cpu_write);
+	sync_global_to_guest(vm, skip_invept);
+	sync_global_to_guest(vm, guest_entry);
+	sync_global_to_guest(vm, replacement);
+	vcpu_args_set(vcpu, 1, vmx_gva);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	if (get_ucall(vcpu, &uc) == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+	TEST_ASSERT_EQ(uc.cmd, UCALL_SYNC);
+	TEST_ASSERT_EQ(uc.args[1], 1);
+
+	/* The device write that stales the shadow, then the host reclaim. */
+	WRITE_ONCE(*entry, stale_target);
+	munmap(addr_gpa2hva(vm, DATA_GPA), 4096);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	if (get_ucall(vcpu, &uc) == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+	TEST_ASSERT_EQ(uc.cmd, UCALL_DONE);
+	/*
+	 * The guest's GUEST_ASSERT_EQ(observed, MARKER_B) proves L2 re-read the
+	 * page through the new entry after the host reclaimed page A, with no
+	 * INVEPT: a byte of the reclaimed page can never be served.
+	 */
+	kvm_vm_free(vm);
+}
+
+static void run_test(bool cpu, u64 type, int level)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct vmx_pages *vmx;
+	vm_vaddr_t vmx_gva;
+	struct ucall uc;
+	u64 *entry, *alternate;
+	u64 entry_gpa, alternate_gpa;
+
+	printf("%s write, INVEPT %s, EPT level %d\n", cpu ? "vCPU" : "host",
+	       type == 1 ? "context" : "global", level);
+	fflush(stdout);
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	vmx = vcpu_alloc_vmx(vm, &vmx_gva);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, DATA_GPA, 1, 2, 0);
+	virt_map(vm, DATA_GPA, DATA_GPA, 2);
+	*(u64 *)addr_gpa2hva(vm, DATA_GPA) = MARKER_A;
+	*(u64 *)addr_gpa2hva(vm, DATA_GPA + 4096) = MARKER_B;
+	prepare_eptp(vmx, vm, 0);
+	nested_map(vmx, vm, DATA_GPA, DATA_GPA, 4096);
+	entry = ept_entry(vm, vmx, DATA_GPA, level);
+	entry_gpa = addr_hva2gpa(vm, entry);
+	virt_map(vm, ENTRY_GVA, entry_gpa & GPA_MASK, 1);
+	guest_entry = (u64 *)(ENTRY_GVA + (entry_gpa & 4095));
+	if (level == 1) {
+		replacement = (*entry & ~GPA_MASK) | (DATA_GPA + 4096);
+	} else {
+		alternate_gpa = vm_alloc_page_table(vm);
+		alternate = addr_gpa2hva(vm, alternate_gpa);
+		memcpy(alternate, addr_gpa2hva(vm, *entry & GPA_MASK), 4096);
+		alternate[(DATA_GPA >> 12) & 511] =
+			(*ept_entry(vm, vmx, DATA_GPA, 1) & ~GPA_MASK) | (DATA_GPA + 4096);
+		replacement = (*entry & ~GPA_MASK) | alternate_gpa;
+	}
+	nested_map_memslot(vmx, vm, 0);
+	cpu_write = cpu;
+	skip_invept = false;
+	invept_type = type;
+	sync_global_to_guest(vm, cpu_write);
+	sync_global_to_guest(vm, skip_invept);
+	sync_global_to_guest(vm, invept_type);
+	sync_global_to_guest(vm, guest_entry);
+	sync_global_to_guest(vm, replacement);
+	vcpu_args_set(vcpu, 1, vmx_gva);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	if (get_ucall(vcpu, &uc) == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+	TEST_ASSERT_EQ(uc.cmd, UCALL_SYNC);
+	TEST_ASSERT_EQ(uc.args[1], 1);
+	if (!cpu)
+		WRITE_ONCE(*entry, replacement);
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	if (get_ucall(vcpu, &uc) == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+	TEST_ASSERT_EQ(uc.cmd, UCALL_DONE);
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char **argv)
+{
+	int level;
+	u64 type;
+	bool cpu = argc > 1 && !strcmp(argv[1], "cpu");
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+	TEST_REQUIRE(kvm_cpu_has_ept());
+	for (type = 1; type <= 2; type++)
+		for (level = 1; level <= 2; level++)
+			run_test(cpu, type, level);
+	if (cpu)
+		run_stale_free_test();
+	return 0;
+}
