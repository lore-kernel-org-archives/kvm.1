Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF213425886
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402526; cv=none; b=quxCdNQ5EjVY8TpPNpGiVkHOIZriNYXU2Jc2Qt+QlwttPtpexNPonbQU2gyRTfdj3tE52uHr+pN5BAIq/oAp1RM9uhErw5vqZTAP2nzMGdRujqxhzJ6TchLX9TlfoRhjaQnWfnT6RKRVSpyYfkS9O9P7zUuFJ4K624LSI8SXcgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402526; c=relaxed/simple;
	bh=AnYa9DsB3pC5ovwAQxf38sSPtNt8qCo49QzZbAmqaJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LQTRQkKLw6193Strofeln5penoo2cWCRnR9LenVGYdsx0U3tbQcue4P5PzgaD6DX6Q8A78SLA9uKaZIEgxDD37N8DPGoYvX/boKrApvxx5qmq+vbDcUMsQOuxZUsY4Ziz4mNijYpHWIgT521iuSumoXEO7QiKkqLinnTfR61stg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYqa5uQo; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYqa5uQo"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84fa3b14ed2so134225b3a.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402522; x=1787007322; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lVlimL3Aj8kSsMDGDfvignTmc+0OEOZcp7iMQk31IH8=;
        b=oYqa5uQoDsY/Zs77sINbsZ+SUmOQ3OvFoQQ6u363qFkdmJHGep3VM84qIwUpOB+qCk
         VuxylniXkthXJT+U5SXZKNh9swTea9m/+Njf3QNvWax9bGHkngwT6sWabhthhbqfexXa
         q+7+bcpqKW0qIsA6+hf4F9GHKjHTOO6tnt2lLKERbM9zx0wGo2ufyEjDclyTzu7FJ/bJ
         r2+MB1kFpzAXab5Wl5RDotlGZDpJf0aphRIdHjZdKAzZh8nbkjg9vD8miPsjzEt55lje
         PotrATiVin8iAWKjpq+/7MzfSwOHfcDZUwuJgnBn7sqfnf84WRDv8BeaAkxAxE8qJIRG
         rmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402522; x=1787007322;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lVlimL3Aj8kSsMDGDfvignTmc+0OEOZcp7iMQk31IH8=;
        b=Ex0aHBFKYTpeyJMQQjOF3/f4mRgssXGAvdLurqP57cEqZBkHsRr/fpLAeW77yDTbia
         KKL8YdcAzt/DO6wpYfmwbjjnW1pH7HPA0XcyYO2FiujNxhfhzNK1VJhquwyrZWcN7Ffw
         I5sjCmxpsGtPPQ8JrzoyYmZFzsYrmb94PIa1Wv6BYaognD6MOAfbV9+mDTwGP+hecOvi
         P130r4jFA1QxbB0L4UclvYVtD5H+v7OF8tiCPXpjd/FJyb6QxZpDa+7DGTf7KoMrsQpg
         /Z3IYvNdxHqXe/eT0AuD0QCdpARq1Pv3Hh/zJ+d2COUZnxpnK7G5Ha5aGK2fN59FK6F/
         RfhQ==
X-Gm-Message-State: AOJu0YyFfu7PCLDArdsSJqk9wYQKW7H78pSEy7wnqXvEQSYcyMHVFpOn
	eNOeidinocdl1GKb2Ak47CRCuiDIzBUYFiZuXVQ97Fc4arG00lsj2QcPjhXPFy3gTp56cIudiWL
	KlGJ8+g==
X-Received: from pfuu5.prod.google.com ([2002:a05:6a00:6f85:b0:848:4e44:7f19])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e19:b0:845:4928:8655
 with SMTP id d2e1a72fcca58-84f2e0edaddmr45671680b3a.39.1786402521754; Mon, 10
 Aug 2026 15:55:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:53 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-16-seanjc@google.com>
Subject: [PATCH v9 15/21] KVM: x86: Make master clock logic in guest PV clock
 updates 64-bit only
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Wrap kvm_guest_time_update()'s entire use_master_clock block in #ifdef
CONFIG_X86_64 and provide a hardcoded-to-false variable for the 32-bit
path, as use_master_clock is never true on 32-bit (host_tsc_clocksource is
only set under CONFIG_X86_64)

Keep the local "ka" variable outside of the 64-bit-only code as it's also
used for Xen code, but tag it as potentially unused since it's not used on
32-bit kernels without Xen emulation.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a8dde1d898fb..d3630b2bfd3b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1796,22 +1796,21 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 
 int kvm_guest_time_update(struct kvm_vcpu *v)
 {
+	struct kvm_arch *ka __maybe_unused = &v->kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock = {};
 	u64 tgt_tsc_hz;
-	unsigned seq;
 	struct kvm_vcpu_arch *vcpu = &v->arch;
-	struct kvm_arch *ka = &v->kvm->arch;
 	s64 kernel_ns;
 	u64 tsc_timestamp, host_tsc;
+
+	/*
+	 * If the host uses TSC clock, then passthrough TSC as stable
+	 * to the guest.
+	 */
+#ifdef CONFIG_X86_64
 	bool use_master_clock;
+	unsigned int seq;
 
-	kernel_ns = 0;
-	host_tsc = 0;
-
-	/*
-	 * If the host uses TSC clock, then passthrough TSC as stable
-	 * to the guest.
-	 */
 	do {
 		seq = read_seqcount_begin(&ka->pvclock_sc);
 		use_master_clock = ka->use_master_clock;
@@ -1820,7 +1819,9 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 			kernel_ns = ka->master_kernel_ns;
 		}
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
-
+#else
+	const bool use_master_clock = false;
+#endif
 	/*
 	 * Ensure reading the TSC+frequency pair is done on the same CPU.  When
 	 * NOT using the master clock, the TSC frequency may vary between CPUs.
-- 
2.55.0.679.g6767b8d81c-goog

