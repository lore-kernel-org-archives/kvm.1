Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140244;
	b=CLXPQzokv0/GPIC7Ue4ytBWP/0ACtCiQrlmnLCxs18lzhpfkJRQJ3lctUQ+1wtKhLY0W
	 samyPNOq52S9lU/tfi0xNLM4uGl2mA3tNHXcKuJXBPoeNTXNP02mK9J1GeYuc+Ijshnzz
	 OYNvl4d5XT2Kru6Xb4DtjPfBXYipcq+xdKn0IS+Zl3EPqBOWLZNrchqNyUnFP/2gpDzFa
	 uF6dS7KL5j0bkDlAOpS79jahSDW62L5T0l+gczOJaW/3tFsV9bopjfkTdrCla/W5fxGPH
	 D9pVklbBWV1LcVZ1x4XEnFqfoW1eShNe0NH50BkHKjgzXWAjV/425lC+QPdS3mHzwuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=BoPUymxOglcKvNzSLxc2ZHRNuJgwJeLzW+FbyED8JEk=;
	b=dEqDUkmLnpOdCGqnsd/ZkFMiKfrci7efpt5LQCqX0ZaVMzQTs7h0UYMKvIVD9pqlS+5S
	 ou6MJqDI7wkT1PW3idZlJW/iUYYHxuHP9iSHgY4eUk3q12HL6Baq/j54jLi3QurAEqKg7
	 eLw9zbIQXWDNAeW3U5zJdT822xhu6mBqSu0rAW114NYPbzAWtuQip2sTWfC9OYkFqMCCu
	 bsT5WV9YNATfsxaYgdnaaDi7rBIvdloXn87Jo067oQ7458yw2gFUk2fAWuu5EPKxLiIyh
	 PH9YCnhaIanRr577mFCYqHGDdFsq+s+GJtcA4uZCbxrK/Ww2WyQTyJzGjVbk2+VUhCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jyAK7mlt;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565D0606A32A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 565D0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jyAK7mlt
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdac8b7169eso271969a12.2
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140243; x=1793745043; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BoPUymxOglcKvNzSLxc2ZHRNuJgwJeLzW+FbyED8JEk=;
        b=jyAK7mltDDLF55BUGL0gZ9XgqjgHYfNVYN3pF5fCNlieCcjG/7JJ0V4SDgyIpBiN/n
         JZBLPqzWj+8ufNC6pVei+0NAo0hcDQU1X2lhURVxkUZZtns4+EBZgzwD60y536vG15fz
         GgQ1NQ1wrFFpOJe+gP0MEV0vUxyiYDe+MWbPeoY5URJaLTvzInzMrOKWcKIg58DQ95uS
         pVJcz8G8lbXia6lLQ4Qir86ZI1PAJ4sV16ff3yfqxaVv5JDGddVmfZGxrEbqQIZWcf+f
         3gAIIcZz/Hdwl1u4rplelobWDcMfqW+wmqSPY8huaHpK2CyAbSkFzWStyal15HwwLNPm
         feDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140243; x=1793745043;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BoPUymxOglcKvNzSLxc2ZHRNuJgwJeLzW+FbyED8JEk=;
        b=L+xLyF+/rJ0rLsXRm5PZQtxsJg43/EuFgUK37u9+0O8Q7dSooowVIThDwwWt2BGOx9
         mPvOVS3LwotVKg3jUCOTQq2GZcBqG8622j7i+k0ksmjArI/IuylBOEhCeEQYX7QWwR+k
         c3GhR9SergNXf9Yb3+4d3Lg1qyP6HlQlJiv5GGDNYt8jRQtXTg7SmvdJa414x/o5fQTs
         WvcPQ6atOTYBu6/JLYrUN2vMTm3774uqX7mdfb8mCrvPjoQRsbSet2ebzul8iu3douMx
         SCMu0P42FAbpCr4xmOfWm0TPA6BzvFqEtpjOU5vUiIvv3HXEm+3y0THJA4PI/E//fufq
         81XQ==
X-Gm-Message-State: AFq9FYJWafBYRpkyuHqy9OTsxg4oVLc3xYAe39wW8176fjGHtfyVEwts
	5V2IcEGkXo98YDFvQZ0YX1uo+jllfKCogIadIbgb8lra18YWxU70DYKI+bmBR5LgxZwmnxQw3rO
	f8tLs1A==
X-Received: from pgp3-n1.prod.google.com ([2002:a05:6a02:62c3:10b0:cc4:aa77:305b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f91:b0:3e2:a0a4:8ab2
 with SMTP id adf61e73a8af0-3e9020cfb89mr533497637.2.1793140242552; Tue, 27
 Oct 2026 15:30:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:30:36 -0700
In-Reply-To: <20261027223038.1566931-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027223038.1566931-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027223038.1566931-2-seanjc@google.com>
Subject: [PATCH v3 1/3] KVM: VMX: Update EOI bitmaps even if APICv is
 (temporarily) inhibited
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset="UTF-8"

As KVM does with IRTEs for device posted interrupts, update the EOI bitmaps
if APICv *can* be enabled for the vCPU, not just if APICv is *currently*
enabled and active.  I.e. keep the bitmaps up-to-date at all times so that
KVM doesn't need to refresh the bitmaps if APICv is unhibited in the future.

In the worst case scenario, failure to update the EOI bitmaps means KVM
could miss an EOI and effectively break level-triggered IRQs, e.g. if a GSI
routing change occurred while APICv was inhibitied.

Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-180887@kernel.org
Fixes: d62caabb41f3 ("kvm/x86: per-vcpu apicv deactivation support")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..d8e66d67138f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7079,7 +7079,7 @@ int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 
 void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 {
-	if (!kvm_vcpu_apicv_active(vcpu))
+	if (!lapic_in_kernel(vcpu) || !enable_apicv)
 		return;
 
 	vmcs_write64(EOI_EXIT_BITMAP0, eoi_exit_bitmap[0]);
-- 
2.56.0.307.g5fe7bd680c-goog

