Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241032FA1B
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860194; cv=none; b=IBFb5Ge1S1uvpDxNX6/pobM2GW2N1Wl0b3eviH9sXgHotOw6+75ugSELJxpZGIS8ytBQroxOgLGmG8Q36wXhlTeinREQcLfqrzNh7RY8xHNT7OyqZul5briXKPUbdd+JcQRRVIHKG/EGrz40ga38n4p5Cy0Rf2tdeXs83dkzGkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860194; c=relaxed/simple;
	bh=MJMJSRlF5r3+tmZ0m1lotCOKLe9s9kaI30CjRDVM5h8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GEEVcffOSBVIF57Zl2enge8xxjOfyNk9x7RlpRSXEP5N3ErBHw9irtapKHOMB2pEyxh3qOWAzb1WC/Amd+zKjJ3vFAyRth8zT3/Xg8XM0rmfZ7iWWHEbKWrfaESyi3zadQ0sD9WxK/mFogkVcY+VteUqHyyUu4DCR1mGEMD42FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KiX+nuqe; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KiX+nuqe"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37fe90ee192so54748a91.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782860191; x=1783464991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=saiGWJ+1qIp4vGwoKItcqKkB3ikEVHldv3doWsecfgE=;
        b=KiX+nuqeFAwoMVF4jzvZqXtidhyTXNhV1afuSg0CGdkCH+nKDR0xcM8OIhUzHd0dv4
         o8CAHCVlL3C2e+1vv+jwCqaE5px4nZx1ak3fLAd86ztiMM+6mSwU4/JKRidxwZsgd8xv
         o3SyMlGbMMdR7zXc3ki7zGfMyZvv69nWU8ooz3/smpmTtEVHiOAYwlJ0NyX8gvuULlKr
         tJD0ULSjRrVizLTIeHTyjQJ8ZCch2bPX6BcoPNmTIliNlnlSYR248PrHZN76r2bzVHqC
         mcR2K6WNBc09qeW4ujRfRvpTi0p2TlStg7jI6Mr7u7DntFlQoe9G1Y/frj5No0Vs5d95
         2uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782860191; x=1783464991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saiGWJ+1qIp4vGwoKItcqKkB3ikEVHldv3doWsecfgE=;
        b=NY+iczO/fxBN3o3FCcTGlPI+l5wb6ktqVBdSQB/uh7ZNiS7PUXAcgO9dYz6NQDnu+v
         aDwrStCZeF8Dzd6Kem5Q1ULfzVTB0QOoHG8v37yN1tc7mgI+sSBtFVJD1Ns7OIt5Ghu9
         BHMZBLf3NTM+iN006blKdsIdc3Nn9KA9pGg7+v/Hiy74xFDjpW9fCAGAGHFhq3fpVDG6
         mWgGTyS5zOlhIcEXvavA/6wxaXBJ8Y72Rk/BNNpIR5phrKtjtco1+nb9u9CJT31pTezc
         hEdIEHcF5bxAIm8Puv8yJ/LDk6bwHvzwXOB3VRX48Bsrvv1t2jGn79IE5zi7Hzns8I8B
         bm8g==
X-Gm-Message-State: AOJu0Yxh0AgaZevpNAQsNxIYNYu+uvuvBDPXxxXVZJ6AVO4Al8LJHUmj
	iIPeou4qdcCRr+iFDDY5ue2mlM4aFdrg2YEavk551ISaGPfV+0PI7p8pbuk0FzNlVuXDh5FX5P4
	qsBQTZA==
X-Received: from plbmg11.prod.google.com ([2002:a17:903:348b:b0:2bd:8434:6d14])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2349:b0:2c9:99a3:911d
 with SMTP id d9443c01a7336-2ca5a52fae2mr21898975ad.9.1782860190491; Tue, 30
 Jun 2026 15:56:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:56:16 -0700
In-Reply-To: <20260630225619.511632-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630225619.511632-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630225619.511632-10-seanjc@google.com>
Subject: [PATCH v4 09/11] KVM: x86: Treat a vCPU as unreachable if its index
 is invalid
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

In the "vCPU locked or unreachable" lockdep assertion, treat a vCPU as
unreachable if its index is invalid, i.e. if the vCPU is in the process of
being created.  Until the vCPU is inserted into the array of vCPUs, the
only way to get at the vCPU is via kvm_vm_ioctl_create_vcpu().  Note, the
actual index is set _before_ adding the vCPU to the array, i.e. there's no
risk of a false negative on the lockdep assertion.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b10814f99a50..0bdfa3699352 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -992,6 +992,7 @@ static inline struct kvm_io_bus *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
 static inline void kvm_lockdep_assert_vcpu_is_locked_or_unreachable(struct kvm_vcpu *vcpu)
 {
 	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
+			    vcpu->vcpu_idx < 0 ||
 			    !refcount_read(&vcpu->kvm->users_count));
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

