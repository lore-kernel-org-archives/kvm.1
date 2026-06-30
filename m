Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191833067C
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858383; cv=none; b=fDpcnbofO3lB5Txst/SVbdFY5sSkN1vIEg4IsxEh37zYHrnwMa5zi7EpTSr2zbJ9g40twLlUAG4HA1UAhnqjjFGuNJn0l/YqPU7fr/w9rjNwqMUvGPEHBrxKK/c+WoiEvtQhWFMXRyv0sY79oog5qbaJGMOZ0TsNJJfZFlLXt9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858383; c=relaxed/simple;
	bh=E9ihg4CHtc058MnIOzPCbYMNOhGQmD9c54Rla5v86N8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BTi6lmRVZmcN5M4F+6f/8F0m5p46rYH9s6XZR1/QM1YQ5w5f7e6LzjxuISDWuHTH5TdREejt0Cse7G25b6Kzzs+Uai3ya6b+V42NYTcxvcIePQ/JYkc4boO3GXV/cfgHyv7a76MK/tBhg7jDn+2lEiXh0vCMm+DXTsxNsWDPEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFQdX5Ui; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFQdX5Ui"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-38096521198so90022a91.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858381; x=1783463181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tgBpkd6omwsYzKK6kftzN/wsFiku2LUumiGt5apq1+o=;
        b=VFQdX5Ui8g6u2jazSVpwznpByc/pmTgLvEhwSIejBn6wNRxcHYWYeDK7AscuXIc99s
         J/aJnZvl3jrorqZhWaiaT0maJEvZXk1+ZHC2c7oPIQdLGE+RWGQwu7kVrNmew+zNC6ts
         EMpf7+tzYZ36QJTaWwkfzs0Y+G0+FG/aCQ57HBHxOhDjojpP9rFEPbfEgQ6afOgt9R8W
         RZ1mrsbV9mW+jYi/NcUAjHFyHS3eZJ1kgAa2qijYAlpfFrunm7ynH2PnPRWUdlnH4FPT
         BSZJLFgG0OtZs7+EW30e/BjS/dVCi50Ar8LTOn1PGYOvVmtz93wq/y4a5WVZ9z2/9veT
         Nkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858381; x=1783463181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgBpkd6omwsYzKK6kftzN/wsFiku2LUumiGt5apq1+o=;
        b=KWxAykKy6PPWp1H/LvwNnsF8rTm2qImepQNXc/UCsUtvgOiSCucJr1TnI6kTd86Vmp
         1GKZFneHvmEk0fau32FpbCZs+qsaUHom3V8RgqozPU8BdMxoUCM6PM8OA7wovBSx1p4j
         zAit/IboOXmRsDNLl+gQ87p3T86lFJG7pisCFb/dPzEuSPb/g9vn9hTpxBp6bdw7eSen
         5Psx9FyPYZD9YnihZOWWgYpsGHb9oErZOf2Zhjs9z7qDy+O12FW69uYVNDRCknQJgoaU
         lvmtqO/YAJ7tyYzALYMDhG1/zg9Dx9IpvgDfZ+DHY4NHrE0btEwk91MAKuwSAV+wyQTI
         au1g==
X-Gm-Message-State: AOJu0YycJloOP0/yixiEehxONy8yZhbVx+IRV+n2aVzJwvDvL6taHFX9
	uV55YhcLO2qthIJZfE+99FbHAKzWc4+1Nsinq2H7RpZZvWu0Avd+Q0KqnJEOFb+8+UvBXAq/zpr
	oGJvV+w==
X-Received: from pjbbb9.prod.google.com ([2002:a17:90b:89:b0:37e:2497:f36c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5241:b0:35f:b987:4dac
 with SMTP id 98e67ed59e1d1-3808bd6a8a3mr1932999a91.12.1782858380975; Tue, 30
 Jun 2026 15:26:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:26:06 -0700
In-Reply-To: <20260630222607.497895-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630222607.497895-12-seanjc@google.com>
Subject: [PATCH v3 11/12] KVM: x86: Guard .gmem_prepare() declarations with HAVE_KVM_GMEM_PREPARE=y
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Wrap the .gmem_prepare() declarations with HAVE_KVM_GMEM_PREPARE so that
non-SEV code doesn't try to wire up a callback without doing the necessary
enabling.

No functional change intended.

Fixes: 3bb2531e20bf ("KVM: guest_memfd: Add hook for initializing memory")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 4 +++-
 arch/x86/include/asm/kvm_host.h    | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index deb3ded5796e..39247d2f29d6 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -146,12 +146,14 @@ KVM_X86_OP(vcpu_deliver_sipi_vector)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
 KVM_X86_OP_OPTIONAL(get_untagged_addr)
 KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
-KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
+#endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
 KVM_X86_OP_OPTIONAL(gmem_reclaim_memory)
 #endif
+KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
 #endif
 
 #undef KVM_X86_OP
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 93af3bb82869..cf2ec19212ad 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1903,7 +1903,9 @@ struct kvm_x86_ops {
 
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
+#endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
 	void (*gmem_reclaim_memory)(kvm_pfn_t start, kvm_pfn_t end);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

