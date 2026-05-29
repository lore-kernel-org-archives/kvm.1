Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EED47B43B
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093404; cv=none; b=G16WEpNHkpvBhS5Fo1f8YZpPBNkXgCi/UUpPq3Rbx4QAEd5W5S0jyZXrEMKxZH3rQPbJTh6EPcNNgZv4IyQVH/5BIi4RsD7NF1AHs0UTItOpQVACr0tXq7Zlpf/vairmsQrvi3RPQMjdDXtZTc5/cTQU8AgYC59pPsZ7XGnfcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093404; c=relaxed/simple;
	bh=L4ZZHusyWBmw7VMjY6K30cfDZe1TEcBzTRn7gHmkge4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PHdII20Z/PDaecqmjINCOPjSKlIUZMfN48AIxwwGmVflvgJSyCYqc3+3iu00UDK6HVI52G+liHhVPwxJN6JTrncqu4PvCiSGMqlnMvJ996IrcVFVhENANo9pRyTymEcqYei13Y+e82PuZDbRQSAf9rvm/Ln9/z6q02wjlFicfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lwCeJQvv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lwCeJQvv"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36603ad6709so12066997a91.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093402; x=1780698202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GWLlWBc07Hx2by9RWraHiTLfxGizbsphDkdU8UthhCA=;
        b=lwCeJQvvk7Kzv+Llr+nCf2aWR3+21bPa84GDmpzXDkXbhImD+YFxJuInBX6uO+fGEn
         pHWWPthrzCiKDYZ/5EVbgsfn4cHgLKQEEnw5EA3+DfMSUxdMZgKS7D5NwWJRRiMEoP6p
         fdHkKyjuQ3c05JPkjjnztRCoyDft9altCjAXsXG2RZCDhPwlUtJp4AFfSDyYiTxUn0+K
         Pi66BeDTVp5rbf+F3ppymi4/HBDINYbuk1Nr2bphOBLDAxcER9Wae66wPVzcQR3b4iAz
         hPZ8NqfRaV+u7gymA/aXmrO/DKdIslycaKvvvZkz5aazGtA5B1FuVoD6hxfwVMh/qHSB
         l8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093402; x=1780698202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWLlWBc07Hx2by9RWraHiTLfxGizbsphDkdU8UthhCA=;
        b=ROwlp+Tl19MEwXd4iIGcY9AoDvmZuH5td23WOnIKQdGQi3rOAfwx16CQ6G01SosDNQ
         2bcdSiZzeGauMppPHolH90NftJq5NeCHMzHqQZCceUlKJbBbRX6X98+mxwn2Tkh7dQ72
         lXJBzglNXGnJ8epu8Igdn4vx/rbaru3ZLBn7wsZ42MTukSL7ymNh7VRhHd8XC0AFnv3q
         S6K1cDJ+LgHqcRt3GKpOKYb9iYGx1TcIHMm5tASEn2v28e69EQBLyVBweYatmFmr4k27
         tmXJ9N6anZ/BYqu04xjwnkQHODTS4tW+lzLtqco0fVZqLl/1OF/awYPzduiRmLi+QBXB
         uAeA==
X-Gm-Message-State: AOJu0YzOmp1Dl8V4ZuCDDA07JqAoKmlp8EjRrJ8BVaJ0nxlKHjPyDCzA
	6Bc7+iJEs7/P6f88gf0TI8MRtlYjNUaBk8uMYBjil5KfQnG9hcdepxYdm4WxFlG4wB2f4JpTjnk
	fYraDpQ==
X-Received: from pgvt11.prod.google.com ([2002:a65:64cb:0:b0:c82:743c:ea8f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f0f:b0:36a:95c:7613
 with SMTP id 98e67ed59e1d1-36c4ff61422mr1094560a91.10.1780093401711; Fri, 29
 May 2026 15:23:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:15 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-33-seanjc@google.com>
Subject: [PATCH v3 32/40] KVM: x86: Move LLDT assembly wrappers into VMX
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move kvm_{load,read}_ldt() into vmx.c, as they are exclusively used by VMX
to save/restore host state, and have no business being globally visible.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 12 ------------
 arch/x86/kvm/vmx/vmx.c          | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f217403e18fc..3e0884a862d7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2334,18 +2334,6 @@ static inline void kvm_dec_apicv_irq_window_req(struct kvm *kvm)
 
 #define kvm_arch_has_readonly_mem(kvm) (!(kvm)->arch.has_protected_state)
 
-static inline u16 kvm_read_ldt(void)
-{
-	u16 ldt;
-	asm("sldt %0" : "=g"(ldt));
-	return ldt;
-}
-
-static inline void kvm_load_ldt(u16 sel)
-{
-	asm("lldt %0" : : "rm"(sel));
-}
-
 #ifdef CONFIG_X86_64
 static inline unsigned long read_msr(unsigned long msr)
 {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index bb19f6df921b..c8ff787d330d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1186,6 +1186,18 @@ static void vmx_remove_autostore_msr(struct vcpu_vmx *vmx, u32 msr)
 	vmx_remove_auto_msr(&vmx->msr_autostore, msr, VM_EXIT_MSR_STORE_COUNT);
 }
 
+static u16 kvm_read_ldt(void)
+{
+	u16 ldt;
+	asm("sldt %0" : "=g"(ldt));
+	return ldt;
+}
+
+static void kvm_load_ldt(u16 sel)
+{
+	asm("lldt %0" : : "rm"(sel));
+}
+
 #ifdef CONFIG_X86_32
 /*
  * On 32-bit kernels, VM exits still load the FS and GS bases from the
-- 
2.54.0.823.g6e5bcc1fc9-goog

