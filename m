Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794948871;
	b=ocArLyUKkYY2ntLcM2wcf7uSwdhoZUi+0cwFg8g/nhNb4JMWVa6GelnhOz/47LBEkJm9
	 Sar7bK7ZV1IGpxbhfLPvhe7S91X08KsV0GSXS1zVnyuuJEVvC2EDzkUknJANHqobhihCO
	 MiB7/8MtigI2RtzpO1XKdLZK88Siviq7bt9qM6OIw22UCYMaQdkfY1FkFkR1EfJxCHNXS
	 JFAGexYHKfBDukp5hVVb21g0BH2JSZAaGtTljqpFpH+sKdJnCU+8PrXs4um1Xz6EBxYdS
	 zEBDWbSRyOH7CuHCAZVmGUz84xEvhL1IRZaa6rxCR1qiH++4guYlie23P1c9jarNQ7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794948871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=jQWYmjlxMo6/xEEDxDasX03frXsDyPZi9DBQiy9773M=;
	b=oRMcq5W2YqxWzrBvCRg6RQ3B38tXpdHfwVtZbtxgyRdDwBLUg7yUEcpf0Fqhu+qJFij3
	 +3yDMBJDR+bVTCkamcoL9pGahVeoSlQKuAltAr2ToeyWkxKI+0WiU7K302ax2WzSyNFI0
	 nCBgjcLFgjlObbtuXrClceq5OF8uCGs5d1KSZWo6ZzXCI7Ev2fGExVhtPRkJKg7QHZVFE
	 TuBHuTL+aIUMZrQAcseZElwzduv5mTscOml2o9Kih81LMe0ze2I6eERWd9xsfx/TDmSbV
	 rKL5n/c1zwebjLz5bKG/i352TRh6r6iisptSqJ7SWwfOeZqrVb+cYSxd2KFDO25R8Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mtl+Njnk;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C3606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 20:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B4C3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mtl+Njnk
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so182991a91.2
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 12:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794948870; x=1795553670; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jQWYmjlxMo6/xEEDxDasX03frXsDyPZi9DBQiy9773M=;
        b=Mtl+NjnkvTCaz4aRAZ0EwJEvYxx4/iEGPXx8ZmE0C1SrK0rP90cC3gHITqJD7Pjda+
         sLHkrM3XB8hLtCf20UTAw/j3PF9moAx4MsARzYAAHKl1g5U7tG45B0ZLTtVfZ6jp3Mom
         2UDxPh4x3EBNy2dZHFoccDPMpIkqr5aettqqIqEE4aNnK7Zz7Fcugp8bl7phUuArEyE5
         soEJ+qyMZ9Fagkhkv7wfrKG3BxXZ92f/1C2b07qkvKI6wQs2nlH3rtgNSYTh2DGEgt2s
         NeK3yXCQQz68/lGI+XsmXbD6hb3Ip07bPpEee3t6oyoI9kl8eOlKQCZLePoDbbnmSdLk
         wmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794948870; x=1795553670;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jQWYmjlxMo6/xEEDxDasX03frXsDyPZi9DBQiy9773M=;
        b=TuzJT1G7KM0SKPcrwEJBevYuVnBDazI83Gx1VwFe8o2XVFhdLzE/Cx/oO0HJblqA0x
         uzdkeDMs77EE9XWRN+6WJJMOk4HOxAZ74SsGaL4O62O3cEEbcmOR4XAcP73i65ydrcTK
         K04RzMGSmvSiV51EYubrKU+33DPZkvCc7OM96gOJaH3TBJVRczGb+n8i4/6gVozIxl+c
         AkD60Rh08JJQnmLa0yE08D+tVTPzrFo1I6Zm/8DGVcopcog0ty5e/53EhpfoMnD880Gj
         JELlpAreyF3yKoujfftWONpnP91k7LW9wLOyumEcSPAXybLF11MxRqH8idTlj4rxggR0
         tvIQ==
X-Forwarded-Encrypted: i=1; AL+hErEkUTvjilhZMJ1VxSfaxtg9K6TMlzSYJcw10yocCbK+TiRNeH08Y9NkLnqqISPKqTcCl6o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9axmNGVzeL6eWQL/XPQfPQwlNZcz5ZbpkKci+AeIrfXwYCQzYZ
	d8X/hQjD5iqUGCfuYr0rwabRuXjfKcVGHFHKTVnQ6wfhtdZBZGfnnnjm/HOgIuxWUhXAL5WJadx
	Ge1hyZw==
X-Received: from pjpb6.prod.google.com ([2002:a17:90a:9906:b0:3b3:9d13:d781])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b8b:b0:3ab:a3ee:33ad
 with SMTP id 98e67ed59e1d1-3b3d074da04mr556296a91.22.1794948869798; Tue, 17
 Nov 2026 12:54:29 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 17 Nov 2026 12:54:28 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117205428.3717-1-seanjc@google.com>
Subject: [PATCH] KVM: Send reschedule IPIs instead of SMP function calls for
 non-waiting requests
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Satish Kharat <satishkh@cisco.com>
Content-Type: text/plain; charset="UTF-8"

When kicking multiple vCPUs for a non-waiting request, send a reschedule
IPI to each vCPU instead of batching IPIs via a single SMP function call so
that KVM can make non-waiting requests with IRQs disabled.  I.e. handle
multi-vCPU kicks the same way KVM handles single-vCPU kicks, for the exact
same reason.

Avoiding SMP function calls for non-waiting requests fixes a potential
deadlock if KVM VMX triggers KVM_REQ_UNBLOCK to all vCPUs when starting
device assignmennt:

  WARNING: kernel/smp.c:943 at smp_call_function_many_cond
    kvm_make_all_cpus_request [kvm]
    kvm_arch_irq_bypass_add_producer [kvm]
    __connect [irqbypass]
    irq_bypass_register_producer [irqbypass]
    vfio_msi_set_vector_signal [vfio_pci_core]

Send reschedule IPIs immediately to avoid having to re-walk the set of CPUs,
even though it makes the code slightly convoluted.  It's also generally
advantageous to kick vCPUs as soon as possible, e.g. so that the target
vCPU(s) can react to pending events/actions, but that's purely nice-to-have
as there are very few paths in KVM that kick multiple vCPUs for non-waiting
requests.

Fixes: 77e1b8332d1d ("KVM: x86: Decouple device assignment from IRQ bypass")
Cc: stable@vger.kernel.org
Reported-by: Satish Kharat <satishkh@cisco.com>
Closes: https://lore.kernel.org/all/20261116-b4-kvm-irq-bypass-irqs-20261116-v1-1-6cc721a062fd@cisco.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..0b733746884c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -218,7 +218,10 @@ static inline bool kvm_kick_many_cpus(struct cpumask *cpus, bool wait)
 	if (cpumask_empty(cpus))
 		return false;
 
-	smp_call_function_many(cpus, ack_kick, NULL, wait);
+	/* See kvm_vcpu_kick() and kvm_make_vcpu_request() for details. */
+	if (wait)
+		smp_call_function_many(cpus, ack_kick, NULL, wait);
+
 	return true;
 }
 
@@ -241,12 +244,20 @@ static void kvm_make_vcpu_request(struct kvm_vcpu *vcpu, unsigned int req,
 	 * satisfied if the vCPU migrates. Entering READING_SHADOW_PAGE_TABLES
 	 * after this point is also OK, as the requirement is only that KVM wait
 	 * for vCPUs that were reading SPTEs _before_ any changes were
-	 * finalized. See kvm_vcpu_kick() for more details on handling requests.
+	 * finalized.
+	 *
+	 * See kvm_vcpu_kick() for more details on handling requests, including
+	 * the use of a reschedule IPI for non-waiting requests.  If waiting is
+	 * required, batch the SMP function call until after all to-be-kicked
+	 * CPUs are gathered, to avoid waiting multiple times.
 	 */
 	if (kvm_request_needs_ipi(vcpu, req)) {
 		cpu = READ_ONCE(vcpu->cpu);
-		if (cpu != -1 && cpu != current_cpu)
+		if (cpu != -1 && cpu != current_cpu) {
+			if (!(req & KVM_REQUEST_WAIT))
+				smp_send_reschedule(cpu);
 			__cpumask_set_cpu(cpu, tmp);
+		}
 	}
 }
 

base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
-- 
2.56.1.703.gf848ed807c-goog

