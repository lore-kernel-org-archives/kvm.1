Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE4318EC4
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953330; cv=none; b=S40fnnW5TiDlGoxELRQRjJE2wON+kBaJsM0CtFJ1gq+sCe06hsGt9xeRhut3iwRIZ3+mJaCREdMrrtO41nJ8Tx4Qzr2SSzuNsRjo/gpZZSYTKMUJHeOEjowDPZqVI7wjEOPjkxn4taAE6EfvjFKEYDcRcgwirPh6eCx8nPgGzxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953330; c=relaxed/simple;
	bh=W23KsFZgezFTtYQBr9LdeXf5DVk60F3J9q7lUAtiI2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f8FOig9zYnl9gzyZIDXSmE1/xE3ulytmlBMi36GQIddAeO5f2QsnmeBPf6QZrK0IScRbJ/4MRtgrNxzCcn9pzW407W2NbBPPtq2jAaE9UXJqQLstMxy+/Cm+CBH/Ol5oIK5ijphsa85V8bhqzRn8zTbfcwWXLiQzIZq0ObIZ6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQfv95zg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQfv95zg"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c6e24ee93a6so4179587a12.0
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 07:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776953327; x=1777558127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=m96tcF9WNVEiTSDqCqgM9HMzPi4cngpQ5Un27mQpg6U=;
        b=WQfv95zgcWkqk7wr7KMYvhzZRrQHIf278BbJkknMcbgH0sv6W6NdUExBLaFJHuWIpa
         HHd/cKnp/2e74gOcKayCJ4aSXbms0giw+x1iNWJSAUJFJ2PeyZRy8aWn+c0Ojv8t3IaX
         7wYDE/NF0AX9vtVgVWhmvyEEVyMkMLPLz0YPJkkGgXllQzdcKFMFwK4oLOKzDDinAiDw
         FUU4+f3rI+GPh+aEK/1TfmodG3leUwfU8e79S2zyBD0vPVQaVGY2r5dUBP4+R7Isw1bU
         NiyVFap3khRdoQHwZpHEEgNKK2Jtf2dNbPQo+T9FuymXlsf4FzSX8q0OzXPAzpnlKR4Y
         B0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953327; x=1777558127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m96tcF9WNVEiTSDqCqgM9HMzPi4cngpQ5Un27mQpg6U=;
        b=TOransEPYGY3KnyG4sR7gz9QlbzpMAPkH1087SuFESXl/y8xpXwSXgALsPI21hYh2O
         JyJkgxcUy2aqszht0zwDi+pHBRAIVNS/eyZUaDzP/+AFV13B3SLSuDVen8qDxFblnyDM
         KUBaoHrxG/cJxxdwpg8bboaLGugX62cKb26eXPDxVBlTQxMldID8gWIJjmeUWgbHunXl
         K8Gbk8ePGBcaaWcLvRTAizswzMstGg0D2ytjFymT04fzaISSQ+r1SKDS0fESB+0/hy0K
         YO2UuInTkhkq7D9DA/au2yohykamvwOnoH2B0/LjfuTZMNa2csQsT3JQRrpxtt/XIjuu
         8VJA==
X-Gm-Message-State: AOJu0YwY8Bemw9gEYK/t2SX3RjdxNNejZdR6xAMDx5tJHEjs09c/wSIF
	Xk7Mbm9hENm/xy9EGApG2wgxxvJwyzC2FJHM/5TpwttbL6omlMVsznBynG2leGrgeGdIx8CUQSm
	4FqQF/A==
X-Received: from pfbay34.prod.google.com ([2002:a05:6a00:3022:b0:82f:a959:4a7f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e082:b0:3a2:c7e1:ff93
 with SMTP id adf61e73a8af0-3a2c7e20480mr15488136637.8.1776953327192; Thu, 23
 Apr 2026 07:08:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Apr 2026 07:08:33 -0700
In-Reply-To: <20260423140833.439512-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423140833.439512-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423140833.439512-6-seanjc@google.com>
Subject: [PATCH 5/5] KVM: x86/hyperv: Use {READ,WRITE}_ONCE for cross-task
 synic->active accesses
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When activating Hyper-V's Synthetic Interrupt Controller (SynIC), mark it
active with WRITE_ONCE() and query it using READ_ONCE() in synic_get(),
the only known cross-task reader, to document that the flag is accessed
without holding the vCPU's mutex.

Note, there are no data dependencies on the SynIC being marked active,
e.g. the vector read by synic_set_irq() is set (usually in response to
guest activity) long after the SynIC is initially activated, and a false
negative on the SynIC being active would be benign (ignoring that such a
race is likely to be problematic for the guest irrespective of what KVM
does).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index a79ccea05a65..cf35ec93cffb 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -219,7 +219,7 @@ static struct kvm_vcpu_hv_synic *synic_get(struct kvm *kvm, u32 vpidx)
 		return NULL;
 
 	synic = &hv_vcpu->synic;
-	return (synic->active) ? synic : NULL;
+	return READ_ONCE(synic->active) ? synic : NULL;
 }
 
 static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
@@ -1013,7 +1013,7 @@ int kvm_hv_activate_synic(struct kvm_vcpu *vcpu, bool dont_zero_synic_pages)
 
 	synic = to_hv_synic(vcpu);
 
-	synic->active = true;
+	WRITE_ONCE(synic->active, true);
 	synic->dont_zero_synic_pages = dont_zero_synic_pages;
 	synic->control = HV_SYNIC_CONTROL_ENABLE;
 	return 0;
-- 
2.54.0.545.g6539524ca2-goog

