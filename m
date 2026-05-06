Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9FA4C6EE8
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778093273; cv=none; b=uwqUwkPnaed7XaLM+au833NyMQtMhW7AgF61PkujZG9DTLhaZ4ioxIipOg88jBoXsWzEqsPVrWRE1dkPqnikwSyNSTrpR6EXPVZrB2JGhs0eHvNpkKW33nLK8wGGuU+wczHzVRwIqc9cJK57dOAweJ8TPo5oPzK4t6Bq2iRKuQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778093273; c=relaxed/simple;
	bh=GCa+iugb2mMh6NV8w9EhqrOVOeu+ilYlhpmyj/Tx+SE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oK0Y19X9T6XZZgXGTU6jCk75/yZgrh+aocGBUQqHOgeM4pg8iWyjpb0hOpDqXnI/qht3vA2u/B+vnJycgvJsIdCIna2TgxzdkjNZxQNwv0Qf+gOKbnQnAJbNB7iIzCwVBZN6Wn8dDmG00KTY9NiDQufTzFcEqaJfiKFJA8j5bYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cs4ag5SC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cs4ag5SC"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa5ecd760so2816754b3a.0
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778093271; x=1778698071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JtAZTrUGBGqncsY/mnOkaN+14m6QylcpFiuEwRs5eqs=;
        b=Cs4ag5SCj8mmKC943b6mnansaK189E3NRG6z5694OVicJXq+vWQurQtQsaULmF9uLz
         pUUdKY9R3JJ3+iqrVRXeJ3bA2fIkxxyrDVBVJg8GUW2XMZuGCyeG3kAGcvE5HlPNk1V7
         MUcbFfUBHcE3E/yB5VQFp4e3WcF+IQEcTxJS5l9Xg++mTdrAjsPo6bk/Sj/E2aQr52PP
         VP//a8Rp/p5Yw97J1WK75ucCJuoRB4kHgS6Wr+6Mcx29L6XyRfn6V/TrY4dCoAqce7Qb
         wRmIy8EUSHpbJmi1fEnGtJ/AR3wihHrTncprgd3Oq1abAiNHxH3j0T7k0mlNn8aMuhii
         D37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778093271; x=1778698071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtAZTrUGBGqncsY/mnOkaN+14m6QylcpFiuEwRs5eqs=;
        b=ILTaXrlw6PH/CakYw2HnB+0pl3w1zlLIl5f4bbP87r8bSG2ECDsCI7/YLoRE7y/Hmh
         iLb+6HumgcZVbVE7AYwaTVer1lFhcvTQr1SiBZUeSalTKIJCNmYyaWyImLllMQ3iJmPq
         T7gV2PwyRCd+JQkvikvjf99YaQBlRJjsN7tsTq+F9FylNBwh0SmlUUc4kN//xyO9dhOT
         aiE1mZrfXufxMQSskvveVMTcNBAU5UQDoVDL3hfLSpgsry2x7khaXZa99ks7MNdLbijx
         bj+KIbbiGQreBcB+1sMwkxEed6/Vy3mAaAqVbp+dGGrX1InoZussiFy+9rkI18glOcIB
         zYuA==
X-Gm-Message-State: AOJu0YwX99TI66NYe/s0kLC9uuFJ0ikNRrytFsOmrWGCDR1ZNucZQzsu
	2YvA16V8nUlAUUiarOLnIgnZxVlwWOduhbAyxjpgxYWB67uV0jwmJ5cXuOkr3K3YjQmjOlQpXAO
	RYPyGiw==
X-Received: from pfwy14.prod.google.com ([2002:a05:6a00:1c8e:b0:82f:a959:4a7f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6de7:b0:82f:24e:6a48
 with SMTP id d2e1a72fcca58-83a5b6c33e6mr4778122b3a.5.1778093270797; Wed, 06
 May 2026 11:47:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 May 2026 11:47:43 -0700
In-Reply-To: <20260506184746.2719880-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506184746.2719880-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506184746.2719880-3-seanjc@google.com>
Subject: [PATCH v2 2/5] KVM: SVM: Always intercept RDMSR for TMCCT (current
 APIC timer count)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Explicitly intercept RDMSR for TMMCT, a.k.a. the current APIC timer count,
when x2AVIC is enabled, as TMMCT reads aren't accelerated by hardware.
Disabling interception is suboptimal as the RDMSR generates an
AVIC_UNACCELERATED_ACCESS fault #VMEXIT, which forces KVM to decode the
instruction to figure out what the guest was trying to access.

Note, the only reason this isn't a fatal bug is that the AVIC architecture
had the foresight to guard against buggy hypervisors.  E.g. if hardware
simply read from the virtual APIC page, the guest would get garbage.

Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Cc: stable@vger.kernel.org
Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 4f203e503e8e..d693c9ff9f18 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -172,6 +172,9 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 		svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
 					  MSR_TYPE_R, intercept);
 
+	if (!intercept)
+		svm_enable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_R);
+
 	for (i = 0; i < ARRAY_SIZE(x2avic_passthrough_msrs); i++)
 		svm_set_intercept_for_msr(vcpu, x2avic_passthrough_msrs[i],
 					  MSR_TYPE_W, intercept);
-- 
2.54.0.545.g6539524ca2-goog

