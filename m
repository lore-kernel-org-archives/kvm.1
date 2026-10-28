Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214191;
	b=p9eObuTXq8gczR3uBoJ3rK6gqqEwMTNEOUDs+6xVQ5g3HNOvKiWheVWqosvzEb2p+fr0
	 7EpDbGxjlp0g2BzU7mWGUKKs45sGhjCXz1CjooJ+DmwJzIQGI5M1eRexwFYnE51i3Q4Ry
	 6U2TDyD6CVxayCI7VgtPPNRdRfKIY1bssDDyIED2KMZtH0Jl2kKcq9g9k+VwQ7q4ixE9n
	 LGjyGB5zrmmqNrArS0fVaKVb57K/CGyxucyXesevL0akMcQiLizYw2+NZ2VPoNkOlm/Vp
	 6SatK4lE/eHq6Y4a/jw9a2wtlAol5j0rykG3BYlP9ZlGoilj91zHaXQU0itplnuL2JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=jCCEmu80ia44kI2vyDb6i59VDXRIs93I0WproZ1Xw/A=;
	b=adgNvjuYZuIhxZZGsoKIoroRkdAq5QpdQb+w4Ysn+RiF31USWCS1a27ss/yy9UWoq2T5
	 VsvVmPb5dv3tZUt0D1CwHzIcgV+3RjeQG96jq5/Bh9G9+4/tvmhactq6pd1zlst5Z3AJV
	 9LBK3mf0pfueOHxRnqC/oN7AeWJ6G6E8b3Avtgac4j8P50Lshq8Sigp7nezC9/3iH87U3
	 kA5TZYQPZO5j9ERUXcw1WwMk0v51wB8TYzujf5hPelehGR/ptQ+kYkdUHcPW9lq9LOYOP
	 pAAvoT+sfd4oRCNNlmFNOeiFK/oZ4rJMUgA78uif2zoHbhWAj2thg2WXlEYo4swcQqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VKCoKKaW;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4C560A5BE9
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 19:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D4C560A5BE9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VKCoKKaW
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad840053c7so1179142a91.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793214191; x=1793818991; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jCCEmu80ia44kI2vyDb6i59VDXRIs93I0WproZ1Xw/A=;
        b=VKCoKKaWzE2ZwVdJNmZ2sHfiG+KYy5lqQ6i0TsdahSfguB8+ESncbH3xe7BAm5PMEr
         Q2jNZybsr8T/OPE4rcgH6TJFsrEHx25QQodbvFRK9rmyThmhDrBShJEtAZPC5lf7Dw6Z
         n0j2lj1MdfRpm2YvS/mAQC7pHLFF02JaJLFKDf/j/2o6AD5FxpQ2Mykl2OvaoWH/q5SO
         11SmykgHIBFTO4Wqjb/oz7PvUtp0kSs/YxJVlLruwf+/gTk9MyKnG/GmkJvBgumlE//6
         +vR0EfuEnrgATAOhzav2N012MxlYmtHXZiPybtbyC9U5lzJn9XmnQ3/lZZ+pED1y9sIm
         /ArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214191; x=1793818991;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jCCEmu80ia44kI2vyDb6i59VDXRIs93I0WproZ1Xw/A=;
        b=hVYWa41W0gDYvWiERKNBeJoChGI/Sly9y94m6bnZzqoxj6X/BcAmtr7L9coGrLKVjG
         U7QEaXJI/QgvsrXU9A6LRnd9/YbUn9/08+ZdyF7dzzAZYDNRr8O/PdxbHb1IdBY1cOSt
         Z8gCe2Ty84o+oPqsOBlhs21C75ouK+5aKo0IrlVbN6O5/oRuMi2ysohU/yVkRgx+jqQn
         0MmJ0p+WtCELc3fLfAuyAo7Qf7lwChfJlvjAUeiz1yD9eiLMGxz1vM573CfFx7TgTa+0
         KVR2I+2hpuxIlWF7cXgc44j9IJWv6g5tp6fsW3d2NgKxAytAKUo7rAlanzY17pxzP1l/
         H8hg==
X-Forwarded-Encrypted: i=1; AKwUvBwutADwRfdaXqBpRa+rfJ0p6Cf4FaXK+R9LkI3oSjf82iTTwf+LwFmczOlgoZjJV/MSj+8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLb0W3rQuQKVLvR1EOD+vU9JBNhGv7mzPhJxr3iQzIZi7oZ77kL
	6UA/b+KoBkn5NS2WQfM023hKCkAn+CBeIgIDi2ZwyOwXuKtI+hAKtN7wW9Kro1K10QZwBy1koM6
	pSnj33Q==
X-Received: from pghv3.prod.google.com ([2002:a63:f203:0:b0:cd6:b233:e4aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b06:b0:3ab:b64:5893
 with SMTP id 98e67ed59e1d1-3ae581bc654mr2418362a91.53.1793214190430; Wed, 28
 Oct 2026 12:03:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 12:02:59 -0700
In-Reply-To: <20261028190259.1819571-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028190259.1819571-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028190259.1819571-8-seanjc@google.com>
Subject: [PATCH 7/7] KVM: Drop kvm_vcpu_should_kick() and use kvm_request_needs_ipi()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop kvm_vcpu_should_kick() in favor of kvm_request_needs_ipi() to fix a
bug where KVM will fail to wait for a vCPU to exit guest mode if the vCPU
was already marked as EXITING_GUEST_MODE by a concurrent non-waiting kick.
Because kvm_vcpu_should_kick() (was kvm_arch_vcpu_should_kick()) only waits
(and sends an IPI to do so) if the target vCPU is fully IN_GUEST_MODE, the
sending task will proceed even though it hasn't actually guaranteed the
vCPU as fully exited the guest.

The flaw is most problematic for SNP VMSA invalidation with in-place gmem
conversion, as KVM invokes kvm_gmem_invalidate_start() => rmp_make_shared()
(via kvm_gmem_make_shared() in quick succession when in-place conversion is
enabled.  I.e. if the target has been marked as EXITING_GUEST_MODE but has
not yet received the other kicker's IPI, then updating the RMP will fail as
the VMSA is still in-use and subsequent accesses to the page will encounter
unexpected RMP #PFs.

Note, the bug exists and affects VMSA invalidation even without in-place
conversion, but is significantly more difficult to hit as PUNCH_HOLE and
.release() have to wade through a lot more code and several locks to get
from invalidation to kvm_gmem_free_folio().

Note #2, currently only x86 uses kvm_make_request_and_kick(), i.e. this is
a glorified nop for all other architectures as the KVM_REQUEST_WAIT path is
never taken.

Fixes: 309d28576f0a ("KVM: SVM: Fix SNP AP destroy race with VMRUN")
Fixes: d1a3c2162334 ("KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped")
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f1792256576b..f99a714698e3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -191,7 +191,6 @@ void vcpu_put(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(vcpu_put);
 
-/* TODO: merge with kvm_vcpu_should_kick */
 static bool kvm_request_needs_ipi(struct kvm_vcpu *vcpu, unsigned req)
 {
 	int mode = kvm_vcpu_exiting_guest_mode(vcpu);
@@ -209,11 +208,6 @@ static bool kvm_request_needs_ipi(struct kvm_vcpu *vcpu, unsigned req)
 	return mode == IN_GUEST_MODE;
 }
 
-static int kvm_vcpu_should_kick(struct kvm_vcpu *vcpu)
-{
-	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
-}
-
 static void ack_kick(void *_completed)
 {
 }
@@ -3935,7 +3929,7 @@ void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, int req, bool force)
 
 	/*
 	 * Note, the vCPU could get migrated to a different pCPU at any point
-	 * after kvm_vcpu_should_kick(), which could result in sending an
+	 * after kvm_request_needs_ipi(), which could result in sending an
 	 * IPI to the previous pCPU.  But, that's ok because the purpose of the
 	 * IPI is to force the vCPU to leave IN_GUEST_MODE, and migrating the
 	 * vCPU also requires it to leave IN_GUEST_MODE
@@ -3944,7 +3938,7 @@ void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, int req, bool force)
 	 * check also modifies vcpu->mode and KVM PPC needs to avoid that side
 	 * effect for unknown historical reasons.
 	 */
-	if (force || kvm_vcpu_should_kick(vcpu)) {
+	if (force || kvm_request_needs_ipi(vcpu, req)) {
 		cpu = READ_ONCE(vcpu->cpu);
 		if (cpu != me && (unsigned int)cpu < nr_cpu_ids && cpu_online(cpu)) {
 			/*
-- 
2.56.0.313.g2479322e68-goog

