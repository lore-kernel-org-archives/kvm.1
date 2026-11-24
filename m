Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795524252;
	b=5PZqE19EGx9rQFLmqN9yUL8ysjkD0FSlmbisN4U6uh5tqwhQEByLMfWki9gABCun3vfO
	 jmt1Xk0UxV6tSQT7WhacasEIl3vijzNt9IksqgFkMjb/5wH89rW5CxgD89qSiQORx4HUI
	 iEacBNTNFGgQ1avmhtaxniJIip7Ro2inHIF+kmI0eiwSPkxZZAVGymVHDZmWKwg3eQBin
	 3IPnW1IZ9iYiGVOUQDO5WNcCsx30RbmyeIZtiG33p6srBKAtxppBTsxDB1nbDPHRvhn6C
	 /0uZlZRf8mYmjol1nn0jul+Ay3wecskBTDtIQrRR0OH8Hont89/hcUZq4XPYl52+g/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 Received:From:In-Reply-To:References:X-Google-Nh-Sender:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=joFVseC72ykbXYRWpF6WHfekhD15ACD1AqHR3+slNwM=;
	b=xbRUZ8bOA+7e8T+WBI5aKryAfOkhN/Zdw48klJQ3SVzANELIxixRFq5WJveD5E1AnWKl
	 nCSzWKZy/lJhGmUw3wNDaMW0CIxfCKbY1bPMKcqmlRyGGOEcZMFWrDrBumeRcyELcbGIp
	 4qIhkM83saPk2TFy3jqdM9Dugiqqe1q0xjVrWn1S/NrYrOHup/ZvCZihb0bPLUQ6Xvo+J
	 Vm9ZYgNiODnZ4SJkt44T5bDJPWYBvvMMSGZyQkcN7mkeUV86XlAHOdxk802FdElbslVo9
	 Dp9TAzRYM3vpcnDZapYI2VSoFeL9AE+5QmxF3/MK8x3F6xtxcXChMxtfGdt6W7FVrfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tgb6EaoP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8C8606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 12:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E8C8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tgb6EaoP
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso836896eec.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 04:44:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795524251; cv=none;
        d=google.com; s=arc-20260327;
        b=OVvUK+5EnhMbSsVxn6LEvF3CY1D7ZyVKvEvKcbrLaD+3TmbSU6PFqUBwPyjVQwys7J
         AAB1XFhSMu9HJ98IG4f8DmCTu4NgDjqU+/80cpjT7taK3UZsuo6RDeQzzMNPgcE9VPj6
         UvUc7h+N4LbZ7vGxzKjwn0Q21lENPMI34ADRO0/ETvNEMK0NY9jo+yeA4ChD49EAoTXL
         3zsfiHVCEY+VyBCMpiw+aXq4b6Y6ON0W6m5MrjzNSFm9hAXLt4bJf6yqmiSSwnnuY/dD
         uhoMaFmIOJ5Gwon6P6ZNGWA0ofr3Nc7gn/tmUQFZz9s6HoLsi0+8nzdAjZBmK82cmkh3
         JVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=joFVseC72ykbXYRWpF6WHfekhD15ACD1AqHR3+slNwM=;
        fh=xr4zSsvpNcBHZtAcpHMwe3tjsbNCqWYmdaehL9Q44Qc=;
        b=A6aMLn7Pel/PogGD+OLGO+VlWO4yXRTLy/9oBVYANYL1GiLOZ6AScQFcsuCKfj0opr
         qXmqjPYY4Q8hGZAIjQkQX3AvZtbdXgeuvg5e6PLlzgjH6V/YNLgRpzK95KtaPpitgPY0
         g42PClyy9fRmNBoSlUUnWa1eylzUQg6PfvIYXyLxpRHK1rUSnRMkY/YBk2M3+6j+JNbe
         rnRDVDYItXLASrg44g5jNrOAcbF9SJam1wkF/napqeksysYsRkUZMh6+PhovG1hj/mHO
         vzHtKxzkZQiOKQOmE+3eEUuMl582+y+aUGKALH0YX1sgT2gJXemBiEwVmMDZrw69Q9k2
         jZcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795524251; x=1796129051; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=joFVseC72ykbXYRWpF6WHfekhD15ACD1AqHR3+slNwM=;
        b=tgb6EaoPCF218p43z71w5VkbW2EtqVhxzBjTtYemXxm3p1G+uGVWKiZRyTcexCheEG
         PwSlyuLtZ1Y0JeoQnxxnJs3m7Zha00kqguV+iayVtAeBg0i6gx/vKYqg4Kae9GUQu5bO
         s2GshFwdcg9lzY9GZaFTyGGsNE+imeGaKhiEAUsnwH9geyGsPp0dKS5gVF2u4jOoINmR
         FeNffdLhYdXLC7/52UERco/GU1xmJ3wn5ZmZAMM3ZPAFsh5lseJr+vESs2tOwp7PMTRw
         WBgRvBPVyOIs+LeyHz9Tz9sxMhx4Hf458yMX+VAPyyZ7BDRnFpi+a8L0wMRT3NdPD9qq
         pAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795524251; x=1796129051;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=joFVseC72ykbXYRWpF6WHfekhD15ACD1AqHR3+slNwM=;
        b=OdV4ZfoaqvALQjb+ehuebvZqhCC7k1sYSZfOWH5Ji2rTyCJjKCrfKoIeR/Zm08jgN8
         25Js9LgGLI6g0CJv4/Nwbyq99JWBNlCt/Vsujsc4XRID3GlsBz95ZKYkpgmcKNLHmWMg
         xRKarKGX3Z4+egFL6HuEIvaNxC6P6OQDCB6n0tmI+Okb0sRo2OBhDKDcOeg4PvWpxs/I
         qJN2DoWiZ8wvInUVPA9ZRpOrdq4bqh8SLX3FNGRo07rrVSXYFZ0IWyrflgdFVBFxZzt1
         vAZRKfVm6DrQ7eMbVt63ANM5n4pPA6au/nxyZdVYo3tt1gJ72qkKCCV2SvSwZF1/eQX5
         XFxA==
X-Gm-Message-State: APuU4Z8jkFYVEe1c4z8AsRPCnM/s94scif04M8qrklF8uAYoB/shWvH7
	T0P4zN9vP1T2v769Ru8zL3jndyVNbJFaB5jVingaToftEZqaBUcmWnJPwM3zUK8nql9IU8Q1/xc
	QhoD3I89ZayFLVIDaH7rSn3trQNIPmfM=
X-Gm-Gg: AZFdTZdKxwWWL7XHdGDoDbzYkJsu8qovIm5b/MNVbw2NoSgebmka1m2L8viWEv3TUlP
	AWq24jqnZrE3DuzEPBnSdoq81SYIdKLB18GwM6gJk0pEnTFJ7g8c3UJo0UQuaXYT7H5FJdElX1y
	uSEGfx3PaWPrmSDHJbqhmehB9eNWngnkp8ARtSXGPngpVZ/8DCfSr8pDgRxh3oAbhrHoCUbpwzC
	SLMHOY2QVoMVC2HNDC0vIa+HNNpIUaDNyiC+Gt9bw3/WOT6hpZtngIHlMhwrOZYfdprcCOqyi6X
	gbSehbJOkzBGCTMaZYsr7m/gchhE4KYv20oV5wDts2RKj6AYQx9WM05E+iGLIGp3c1ndsQBVvQy
	UWxY9k7O1OfK9aDUFtRFbosciAgS5y0gdPFav
X-Received: by 2002:a05:693c:42da:b0:386:95e7:8497 with SMTP id
 5a478bee46e88-38695e790e1mr11359692eec.28.1795524250539; Tue, 24 Nov 2026
 04:44:10 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 24 Nov 2026 06:44:09 -0600
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 24 Nov 2026 06:43:46 -0600
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Tue, 24 Nov 2026 07:43:42 -0500
From: gdool88@gmail.com
In-Reply-To: <20261124032748.1221979-1-gdool88@gmail.com>
References: <20261124032748.1221979-1-gdool88@gmail.com>
X-Google-Nh-Sender: AW_J_UqD7PilzehkqcEtsHCaEZTQ-LW-gWordbPibv_f69Rp0pj2gaQWOhvZrdlKxvI6Q3OS3BgKw0YPQVx-Lq3VLi7l_hdMspTZ4C6qEDwQRR3JLDtAKI89dDUVXPwBytBm4isKkRFfRMLQnrWaR9dOTgz3iCcG2mu4i7kvaUZF3V9JfkB6lcU95K232arRJKy9u7mwGiP6GY6ng50zduCWrACX28meh2iMPsjzHLqo-YSd6MdviPg_sYT_24AgNghkFB8uaNiH
Date: Tue, 24 Nov 2026 06:44:09 -0600
X-Gm-Features: Aa3M54okwDIzVUvAin0eRtSi3WQ0E0y6ioKmpmRwReilV-zctUEGyrhFcv4-Hvo
Message-ID: <nh-35637c39-8c36-4115-9819-467ec8a93ad1@google.com>
Subject: [PATCH v3] KVM: x86: Reject SMM on VMs with private memory
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Younho Choi <gdool88@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Younho Choi <gdool88@gmail.com>

A VM created with private memory (KVM_X86_SW_PROTECTED_VM, SEV-SNP, TDX)
reports one memslot address space, as kvm_arch_nr_memslot_as_ids() returns
1 when kvm_arch_has_private_mem() is true.  SMM still selects address
space 1 via kvm_arch_vcpu_memslots_id(), despite the existing comment
that SMM is unsupported for guests with private memory.

Address space 1 starts at generation 1 and is never swapped for a
private-memory VM.  Address space 0 advances by
kvm_arch_nr_memslot_as_ids() (i.e. 1) per swap, so after a single
memslot operation both address spaces have generation 1.  The per-vCPU
last_used_slot cache in kvm_vcpu_gfn_to_memslot() checks only the
generation number, so an address-space-0 slot can be reused for an
in-SMM address-space-1 lookup.  After the slot is deleted and freed, the
stale cache can cause a host-kernel use-after-free of struct
kvm_memory_slot.  This was reproduced on KVM_X86_SW_PROTECTED_VM by a
process with access to /dev/kvm.  The same aliasing can leave SMM-root
SPTEs that mmu_notifier invalidation does not zap, because it walks only
address space 0.

Enforce the documented assumption that SMM is unsupported for VMs with
private memory.  Make the VMX and SVM has_emulated_msr() hooks report
MSR_IA32_SMBASE unsupported for those VMs; TDX already reports it
unsupported.  This disables VM-scoped KVM_CAP_X86_SMM reporting and
makes kvm_inject_smi() reject KVM_SMI and APIC-delivered SMIs.  Reject
in-SMM state, pending SMIs, and smm_inside_nmi via KVM_SET_VCPU_EVENTS,
matching the !CONFIG_KVM_SMM validation.  Host-initiated SMBASE MSR
access is unchanged.

ChatGPT Codex assisted with analysis, patch drafting, and test design.

Fixes: 89ea60c2c7b5 ("KVM: x86: Add support for "protected VMs" that
can utilize private memory")
Cc: stable@vger.kernel.org
Signed-off-by: Younho Choi <gdool88@gmail.com>
---
Changes in v3:
- Resend with an in-body From header to preserve author attribution;
  no code changes from v2.

Changes in v2:
- Reject pending SMIs and smm_inside_nmi in KVM_SET_VCPU_EVENTS, as
  pointed out by Sashiko.
- Correct the description of VM-scoped SMM capability and SMBASE support.

Testing:
- On a KVM_X86_SW_PROTECTED_VM, v1 accepted pending=1 and entered SMM on
  KVM_RUN.  Deleting its memslot then triggered a KASAN slab UAF.  v2
  rejects the ioctl with -EINVAL and stays outside SMM after KVM_RUN.
- Nine ioctl regression cases pass on v2, including KVM_SMI rejection,
  VM-scoped capability reporting, and normal-VM ioctl behavior.
- A private-VM KVM ioctl lifecycle test passes clean event-state
  save/restore, latched INIT, and host SMBASE MSR roundtrips.  An invalid
  pending-SMI restore returns -EINVAL without changing NMI state, and
  the restored vCPU runs guest code.  Full VMM migration was not tested.
- Separate CONFIG_KVM_AMD_SEV=y and CONFIG_KVM_INTEL_TDX=y builds compile
  the affected SVM, SEV, VMX, TDX, and common x86 objects.
- Source audit confirms tdx_vm_init() sets has_private_mem before vCPU
  creation, so the common ioctl guard also applies to TDX.  SVM/SNP and
  TDX hardware were not available for runtime tests.
- A standalone reproducer is available to maintainers on request.

 arch/x86/kvm/svm/svm.c | 8 ++++++++
 arch/x86/kvm/vmx/vmx.c | 8 ++++++++
 arch/x86/kvm/x86.c     | 11 +++++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e30ee8062..0b8cd1502 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4841,6 +4841,14 @@ static bool svm_has_emulated_msr(struct kvm
*kvm, u32 index)
 		if (!IS_ENABLED(CONFIG_KVM_SMM))
 			return false;

+		/*
+		 * SMM uses a second (SMRAM) address space, which a VM with
+		 * private memory does not have; SMM is unsupported for such
+		 * VMs (see kvm_arch_nr_memslot_as_ids()).
+		 */
+		if (kvm && kvm_arch_has_private_mem(kvm))
+			return false;
+
 #ifdef CONFIG_KVM_AMD_SEV
 		/*
 		 * KVM can't access register state to emulate SMM for SEV-ES
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 82eb891f6..b6d5b33c1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7098,6 +7098,14 @@ bool vmx_has_emulated_msr(struct kvm *kvm, u32 index)
 	case MSR_IA32_SMBASE:
 		if (!IS_ENABLED(CONFIG_KVM_SMM))
 			return false;
+		/*
+		 * SMM uses a second (SMRAM) address space.  A VM with private
+		 * memory exposes only one address space (see
+		 * kvm_arch_nr_memslot_as_ids()), so SMM is not supported for
+		 * such VMs; advertising it leads to memslot aliasing.
+		 */
+		if (kvm && kvm_arch_has_private_mem(kvm))
+			return false;
 		/*
 		 * We cannot do SMM unless we can run the guest in big
 		 * real mode.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 26e7beaff..4faafc407 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3050,6 +3050,17 @@ static int
kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 			      | KVM_VCPUEVENT_VALID_TRIPLE_FAULT))
 		return -EINVAL;

+	/*
+	 * SMM is unsupported for VMs with private memory, which expose a single
+	 * memslot address space; entering SMM would select address space 1 and
+	 * alias it with address space 0 (see kvm_arch_nr_memslot_as_ids()).
+	 */
+	if ((events->flags & KVM_VCPUEVENT_VALID_SMM) &&
+	    kvm_arch_has_private_mem(vcpu->kvm) &&
+	    (events->smi.smm || events->smi.pending ||
+	     events->smi.smm_inside_nmi))
+		return -EINVAL;
+
 	if (events->flags & KVM_VCPUEVENT_VALID_PAYLOAD) {
 		if (!vcpu->kvm->arch.exception_payload_enabled)
 			return -EINVAL;
-- 
2.43.0
