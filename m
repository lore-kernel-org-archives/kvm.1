Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ACD33507C
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860193; cv=none; b=fXuQIhLeQfIET1Qv9iurLCHEhf8cTS+SDJsWQxQk1sfJelijNNV2LHBCeIeqe/XQQ1CpiXKo9BqnFU/85vcfRPPa/RF0s3r8UVVNmO4I6LyX3HiAnZqI0Vm4c8un4ysRRqtAJK+9vvLORa4lu8e0Ns1BQ2tBxYyC9i26+XFBRcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860193; c=relaxed/simple;
	bh=1kNFPkL0jjqmM1CIfdQrQjKKjNMyqeQX86Cc49gOi6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KMFXCOcliHXN5mEs4VTHtuJ3pFvlMSRiRqB7BOVFmteFkANaW365dDyCurb8mkR88IQ25uYVEWwND88b7HK8kkpZ9dlewbcrTYNvds2AtJ4wn3Q/eDhosRURtVJjeF3u3HWcQQdprhS2C4lemyMtdTb/xF+r8E5NW1f58lexaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZbnVTFi; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZbnVTFi"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847902a694cso78119b3a.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782860189; x=1783464989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=a16gRjtRn86UfUtiEbOop3NuB+KG8sDr/q18ZbA3jUg=;
        b=aZbnVTFiJuJgkwuMmKejFh+tqLlk1jHzkyKrHntUOlPcDyxL9tXTBqx3X3udMK8WS1
         x/Jds45lcAMm4XJ63HE5mOgweYf+zsqdpQ/xeHdOwH3YNdGIWOg0sgjdNPhaetZGlqCm
         WP+Ah48OlHbz7a4+w0CRV7wDOpmc8M+6XQ9MRCbET1g/9HZdMNf9NlywR2J0WVF0PuYK
         EjLb+kCtKTp5e7Ms5yNjbbb1M5aqtJms3A6Y1qmAUKvQtKla9y8bE095SNzoTv9HIB6C
         mhdpz+v1FdPtq1K7h7S4RBepPUiBQcWHYnjrpgAb4vDad72TmEg4DnKoLNMRtQ7F/9Uq
         9/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782860189; x=1783464989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a16gRjtRn86UfUtiEbOop3NuB+KG8sDr/q18ZbA3jUg=;
        b=oV2862UqsH4JJYs3U5lAtWJJCprADnQV4DoozQtJFXd8nZPFYUH1yKnyoXyy5GkjK3
         IEXK9BIEoWPQYmoAw65c9OaSa6EwVEfJrAvuuISv88cQfECY+xoOAccWIpyKgftlyQVR
         yjPKUPfpO2q4zSH+yVVeG5rH3XIfxC6nT3KjTJm9nG4hOCP3moopcc9X/brhh8OU3cpR
         Bbk77qJxRhXKEfktkquR5owmqzcSp8nXt5NEjsVz4e7YZANRy9WLzct5yhkf1sMCB4WL
         EWUGTYV+FHuV4Ui+QXTWZ/Ke82o+xIdeseIrVUO9biieBDbXCKGkMIzmUHxtrH+OcnzN
         AWEQ==
X-Gm-Message-State: AOJu0YwdLz9Z2O/VEDgjudAUSrTCDA5JellzlkJA93Iz82JJRUS8eD8/
	8xlLYdm5sjav6q56JcWExDAc9qCeYF0y4QtQjqKQPxMHOykl0YV1N89EA/v+RNLjn6DSlCi/v/H
	gUXfxEQ==
X-Received: from pfnj5.prod.google.com ([2002:aa7:83c5:0:b0:847:b1ea:950a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c09:b0:846:bc60:5bf7
 with SMTP id d2e1a72fcca58-8479f0dd9d5mr4923141b3a.6.1782860189484; Tue, 30
 Jun 2026 15:56:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:56:15 -0700
In-Reply-To: <20260630225619.511632-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630225619.511632-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630225619.511632-9-seanjc@google.com>
Subject: [PATCH v4 08/11] KVM: Move nVMX's lockdep logic for vcpu->mutex to a
 common helper
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
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
index ab8cfaec82d3..b10814f99a50 100644
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
2.55.0.rc0.799.gd6f94ed593-goog

