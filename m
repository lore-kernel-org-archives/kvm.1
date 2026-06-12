Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE823D8138
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305599; cv=none; b=VWGjof+DanSsIJyNOR6JkcG93GqpqofHKB8zesVjFpB1BR9qCsD/mR8H5rVK8nTxoV4o3qF8iBiw3JhkliEirbKbEaoSXLtC+VLFsEOgbZmuvB+ZNUOMCbHo4uYVo7Z/hJM6JeOnaUBqVI8TXa0KBvXmnhOgKPNJwyyBKIyE4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305599; c=relaxed/simple;
	bh=m6dVurRgYnxp0sE8HOQaFVvKBubpdu74b/5Ww1K0kT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eS5XnF38W1EwkLybrYHlUnoLT1oChaVa9oNiItzv6k2kzM0nllcXDKuuWfSmLGNZyMi4g+/rcfdMnuYTw4onj3/PXKfce12czDPhIQbGBKN26yg7K3MjnbZnxHX7z+zQZCQ799bj+OLxaXqLCou09au12X32KnVtDkl5R52K6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ly5Th6li; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ly5Th6li"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84245e2bb00so1430648b3a.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305597; x=1781910397; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=c1HJ7r3naWN/gXYFxqoncE94o9SKi21l/ZVbf+vfGC0=;
        b=ly5Th6li2IcArhawrKBMhhEQ8tUaAU2CAY+uvHAUOx2qh8epVyEJfsCpP0nSdE1Fhc
         9CYZB4QYMfRlbLBVsk7Cid1HRdsVBT2vTkWsSQpozWqDHhzZJREZswPAFiuk664/yJgF
         qynOiXyVJqqAPlyq+nneRAuSFef+3rltDJUAAoyShjvaF30e1bRuMxv4csM9JfzrZJYJ
         nNEymy3GopACoBymoxZ83KpA33OwiS3UnJuLKSI/xGmDnc/DeFrutWXX3GkyzH/myF9w
         QP5qPx1TuWW0aabG0y8DOOUCjUftXOv4m93vbAY6XcXSB9sJvDXM+zBAJBr7R1rgJiG9
         YXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305597; x=1781910397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1HJ7r3naWN/gXYFxqoncE94o9SKi21l/ZVbf+vfGC0=;
        b=M5bW7e1W2WlpT7+w9mwNNGRwMuRXglaHMBMnw6gVttfFYZouO4X7G7XbOrLZJu04aA
         1FwIa+24epQ1vqL0cqfcYSIlMitddA8HJ93d6Vxwnr7bXYdTx+80wgC6T7ieHlEPpXtD
         pl5Hyocwg22uun+q0BEUio+mmBYfitj9bpfify3P/JhMhWJ99RgUgsjdUwcQkS7CLru9
         KHb6OVQWyWLmhjDsOc2EJnHhxNM8e6V7RdWEHM6D1HnI7nZzUj/ytfo+eSvXpBHzV3S4
         85wHb53Sza3N3BO1P125lo5OpW52sPfhz19w4Hvm3bZekDWz1+2PhuJO/SFX3UMKuqvI
         vSzQ==
X-Gm-Message-State: AOJu0Yy/hbtLH5938ImV/u1bkcTM775Anx/4uZdlxZU7iy3vLXUDBdgt
	8RW6nPNksfoBp11EStgDel4LAsh5FEb6dp4D7LipxI7VZkHI3Yphoy1/Y0o+j7+sUtnbUHe5+CU
	DoKpyIg==
X-Received: from pfnj4.prod.google.com ([2002:aa7:83c4:0:b0:842:4a9c:2fd3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:993:b0:839:9ad:ee31
 with SMTP id d2e1a72fcca58-8434cdcadcfmr5403349b3a.8.1781305596569; Fri, 12
 Jun 2026 16:06:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:06:19 -0700
In-Reply-To: <20260612230622.687665-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230622.687665-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230622.687665-6-seanjc@google.com>
Subject: [PATCH v2 5/8] KVM: Move nVMX's lockdep logic for vcpu->mutex to a
 common helper
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Extract nVMX's lockdep assertion that a vCPU is locked or otherwise
unreachable into a common helper, as KVM x86 is about to gain another user,
but there is nothing x86-specific about the logic, i.e. the assertion may
be useful for other architectures.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.h | 6 ++----
 include/linux/kvm_host.h  | 6 ++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 6d6cd5904ddf..c6de848bd9ce 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -57,16 +57,14 @@ bool nested_vmx_check_io_bitmaps(struct kvm_vcpu *vcpu, unsigned int port,
 
 static inline struct vmcs12 *get_vmcs12(struct kvm_vcpu *vcpu)
 {
-	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
-			    !refcount_read(&vcpu->kvm->users_count));
+	kvm_lockdep_assert_vcpu_is_locked_or_unreachable(vcpu);
 
 	return to_vmx(vcpu)->nested.cached_vmcs12;
 }
 
 static inline struct vmcs12 *get_shadow_vmcs12(struct kvm_vcpu *vcpu)
 {
-	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
-			    !refcount_read(&vcpu->kvm->users_count));
+	kvm_lockdep_assert_vcpu_is_locked_or_unreachable(vcpu);
 
 	return to_vmx(vcpu)->nested.cached_shadow_vmcs12;
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 27498e990dff..82696b27b145 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -989,6 +989,12 @@ static inline struct kvm_io_bus *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
 					 lockdep_is_held(&kvm->slots_lock));
 }
 
+static inline void kvm_lockdep_assert_vcpu_is_locked_or_unreachable(struct kvm_vcpu *vcpu)
+{
+	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
+			    !refcount_read(&vcpu->kvm->users_count));
+}
+
 static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
 {
 	int num_vcpus = atomic_read(&kvm->online_vcpus);
-- 
2.54.0.1136.gdb2ca164c4-goog

