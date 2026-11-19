Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795132631;
	b=MoG4cSJ3nJBcpvBO5vA5HUm+gLWz+X5zJjgkSbGDABpBG6uQUMpi5h/dBWSoNLtTl0w7
	 UsLI7IaYrExby9Ej3mh0oNqd8wMWxvB6ApieN8bWVeq9+pNbwvOaMyQbL7mnR3XACzM9C
	 lNSgS6UstFKrmO9ajCj552tckMBlNUz14c7Uq8gn2qQbSla4MHR5vQ9NPrKwawjLT7Wz/
	 M+PUrAnEhutTjG/idcA9PYOtlLvLonB9UlzTYCCHQejr5hxCDVDn2gVWuU6ellAov7PfM
	 IIG6/vGf1zT8IDMFLrS46PsP5UWYnpP/Opq02z4gNcITkSfVtlwSpty5t4ool0ks/4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=DOIhet3GoHewZKf/csVuWshRyoxnprBxnpbZqi4hxo0=;
	b=w7ydbqkiYoWanTLoFDSsL0Uiw9jq/AmlQditFnIknBDXyKCywCXm5HFwjk11PaXO5rIa
	 IcPmbuCFTU0h3TaMlBM8f3xI4T720rTI1kialqoPa2agxVf+vnjjKP3u17eQ2VJ7PCIcu
	 oJmSMsvJHgAUrWm4/mEsTHzh9mO589usb2hpiX1ZVNBTSZ6vnJ7+Ti39pqIQVK3pW+uPn
	 az7sKyXPWXsUkhHxR9RPxkVsPWhO8FJGDxmTqUrpfq+XWs88Ce+W7/aAsMbSsXw1RDPsD
	 skgIEtaKDuT6HhwxICRgA5d1jcA9Yr28fqlCcYJtC/xgMyi0RZkH2Rq3a8XWfB2SDGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lv74E3yV;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06267606A333
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 23:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06267606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lv74E3yV
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b41f4ca1bfso174806a91.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 15:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795132630; x=1795737430; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DOIhet3GoHewZKf/csVuWshRyoxnprBxnpbZqi4hxo0=;
        b=lv74E3yVO+cmRTO43z2UG1V/f5wE7DBWtQAp8e5RXekGRteErOse/cP8HUpo95PmeU
         Pbskw69s+pMJp+TADeX+w+zIb7VXeXfJP5AHpQqIx0A/N6atknz5+aK0xQ2sT2Pxv4Ty
         Jalywdoi89IU+P2dzSxfWCMa4g5f41Z8tq+aVHyRsDJC5rObnbidDG4iAvkdtmdpcI+U
         FxNgINa5jWCkz/+fhVRgY3R68EtxKq8ByzsK9fPQKPhd6EzmQadK9izEbSQIUDgXCy4g
         15ewa/g5p466x+k4OkCULzq94f4xL7vNXZL7CaTzBz8yr/ID0JTEvkR4J1UDMuFNkfWD
         YCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795132630; x=1795737430;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DOIhet3GoHewZKf/csVuWshRyoxnprBxnpbZqi4hxo0=;
        b=k8yRlcoecDvuG8mxEjuJ4MIV/lyNcLqECxP2JlHIIR55tyjaed3FZx00PqthXdB1QN
         5yurQDD8UNs28WPO5mZevl0VmuYncenk/HdJEmHS1Qj5L6VDErH5AUdRLtIvKwccnlkc
         BUQ7YNsJUrormP0dFclqnjHq1jVLJFObeXaFsNKsGh8PgQJitd5+T+2P8p2peouwhW3n
         /byiJtQTLCczeyw7MTUJCkvbYMwa3rm6forPJzs4DUAKD+NXNZzCOssoFdAWzEgPmWuZ
         7Bt0s3tBWQFQoUXf0u0GHkne2pyXV3H1yfS0v5G0ayPpYAMg93bonLCK30RSLQy5w/KI
         0TNQ==
X-Forwarded-Encrypted: i=1; AL+hErFU+omlFXsZ2IUEh8u9PusAhYATanGSXAF68+ySGc40yvqy0yYY4xJLSPU/wFQoOkgsx4U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HAuS6jrNVlfDmBWpzGtbUP1cLiMfjiIRLS6mgORuHYORwu5lR
	bWDRvSpkKPAMMVO9TqAlr00/2+rgU1Af8P0bxjPDQj7IJyss3xaJYW6Ni8xzP30fhUTWSfBU80P
	ZyGsdGw==
X-Received: from pjbbs19.prod.google.com ([2002:a17:90a:f213:b0:3b3:ab93:b5d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:442c:b0:3ac:1c76:61c3
 with SMTP id 98e67ed59e1d1-3b41c92cd28mr802837a91.27.1795132630207; Thu, 19
 Nov 2026 15:57:10 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 19 Nov 2026 15:56:55 -0800
In-Reply-To: <20261119235656.70315-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119235656.70315-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119235656.70315-6-seanjc@google.com>
Subject: [PATCH v2 5/6] KVM: Send reschedule IPIs instead of SMP function
 calls for non-waiting requests
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Satish Kharat <satishkh@cisco.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When kicking multiple vCPUs for a non-waiting request, send a reschedule
IPI to each vCPU instead of batching IPIs via a single SMP function call so
that KVM can make non-waiting requests with IRQs disabled.  I.e. handle
multi-vCPU kicks the same way KVM handles single-vCPU kicks, for the exact
same reason (and more).

Avoiding SMP function calls for non-waiting requests fixes a potential
deadlock if KVM VMX triggers KVM_REQ_UNBLOCK to all vCPUs when starting
device assignmennt:

  WARNING: kernel/smp.c:943 at smp_call_function_many_cond
    kvm_make_all_cpus_request [kvm]
    kvm_arch_irq_bypass_add_producer [kvm]
    __connect [irqbypass]
    irq_bypass_register_producer [irqbypass]
    vfio_msi_set_vector_signal [vfio_pci_core]

Deliberately avoid using the per-CPU cpu_kick_mask for non-waiting to fix
an even more urgent bug on arm64, where KVM could fail to wait for a vCPU,
e.g. for a remote TLB flush, if an IRQ triggers a multi-vCPU kick in the
middle of another waiting kick.

  kvm_flush_remote_tlbs()
    kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH)
      cpumask_clear(cpus)
      kvm_make_vcpu_request(vcpu0, ...)
        kvm_vcpu_exiting_guest_mode(vcpu0)
          cmpxchg(&vcpu0->mode, IN_GUEST_MODE, EXITING_GUEST_MODE)
        __cpumask_set_cpu(vcpu0->cpu, cpus)
      <hardirq>
        irqfd_wakeup()
          ...
            kvm_make_all_cpus_request(kvm, KVM_REQ_IRQ_PENDING)
              cpumask_clear(cpus)  <-- wipes vcpu0->cpu from cpu_kick_mask
              kvm_make_vcpu_request(vcpu0, ...)
                kvm_request_needs_ipi(vcpu0, ...)  <-- false (EXITING_GUEST_MODE)
      kvm_kick_many_cpus(cpus, true)  <-- misses vcpu0->cpu

Send reschedule IPIs immediately to avoid having to re-walk the set of CPUs,
and obviously because using the per-CPU mask is unsafe.  As a bonus, it's
generally advantageous to kick vCPUs as soon as possible, e.g. so that the
target vCPU(s) can immediately process pending IRQs.

Fixes: 77e1b8332d1d ("KVM: x86: Decouple device assignment from IRQ bypass")
Cc: stable@vger.kernel.org
Reported-by: Satish Kharat <satishkh@cisco.com>
Closes: https://lore.kernel.org/all/20261116-b4-kvm-irq-bypass-irqs-20261116-v1-1-6cc721a062fd@cisco.com
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-219682@kernel.org
Cc: Oliver Upton <oupton@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 07cc0dd10b71..48fef91b8530 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -226,15 +226,17 @@ static __always_inline struct kvm_cpu_kick kvm_init_cpu_kick(unsigned int req)
 
 	kick.me = get_cpu();
 
-	kick.cpus = this_cpu_cpumask_var_ptr(cpu_kick_mask);
-	cpumask_clear(kick.cpus);
+	if (req & KVM_REQUEST_WAIT) {
+		kick.cpus = this_cpu_cpumask_var_ptr(cpu_kick_mask);
+		cpumask_clear(kick.cpus);
+	}
 
 	return kick;
 }
 
 static bool kvm_finish_cpu_kick(struct kvm_cpu_kick *kick)
 {
-	if (kick->need_kick)
+	if (kick->need_kick && kick->cpus)
 		smp_call_function_many(kick->cpus, ack_kick, NULL,
 				       !!(kick->req & KVM_REQUEST_WAIT));
 
@@ -261,13 +263,22 @@ static void kvm_make_vcpu_request(struct kvm_vcpu *vcpu,
 	 * satisfied if the vCPU migrates. Entering READING_SHADOW_PAGE_TABLES
 	 * after this point is also OK, as the requirement is only that KVM wait
 	 * for vCPUs that were reading SPTEs _before_ any changes were
-	 * finalized. See kvm_vcpu_kick() for more details on handling requests.
+	 * finalized.
+	 *
+	 * See kvm_vcpu_kick() for more details on handling requests, including
+	 * the use of a reschedule IPI for non-waiting requests.  If waiting is
+	 * required (kick->cpus is non-NULL), batch the SMP function call until
+	 * after all to-be-kicked CPUs are gathered, to avoid waiting multiple
+	 * times.
 	 */
 	if (kvm_request_needs_ipi(vcpu, kick->req)) {
 		cpu = READ_ONCE(vcpu->cpu);
 		if (cpu != -1 && cpu != kick->me && cpu_online(cpu)) {
 			kick->need_kick = true;
-			__cpumask_set_cpu(cpu, kick->cpus);
+			if (kick->cpus)
+				__cpumask_set_cpu(cpu, kick->cpus);
+			else
+				smp_send_reschedule(cpu);
 		}
 	}
 }
-- 
2.56.1.708.g77570a6a1d-goog

