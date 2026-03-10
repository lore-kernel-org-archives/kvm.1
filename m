Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221353CAE77
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186543; cv=none; b=sUi04HgffsKhnmGpvkFUyPnO9sF0RcHJ2dqWIM/NVZyjgON4QyNDfNfZn09vRjdfGYVvQSowl7HEjyKbOHlGnhRao1QeW6RURTRDqIz2MWqmG1NKCmMx11t4ZxO0H9oKV/KnmaHFeCrPHvZD0X7HKdw0BZIK8oSsbNpVA2LtLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186543; c=relaxed/simple;
	bh=uVoR9Xe4mRfHE6loxSVhvjcSNc6aBMfQ8wHKJPqrrOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Eu8us8ie3/OJ+BMK6GsS572i7bi/WIjCBQ7Pvz2h5g93dYBR/ggXaD0HL4gIoZ+EnW1eIcYC3wh2bWggQlyMg0vYao96WqRIGSKBtn86EoImxeOOR6gAj3i2nmetJlyn7OrGxPvesLLphjRcrBAEL299c+VlcsYzB0tSfrRK4Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j0n9jp7h; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0n9jp7h"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3597baf976dso38534293a91.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186541; x=1773791341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gENHh+LHHspcmPyJqV4yOmmwYVieLWgsYWBJG3PvZfE=;
        b=j0n9jp7hWsJEOfwS46O4qU5dAFnw1Ded1NVV1k1Co0N5SebsGDwWPE4wlsMXfSgsuK
         LHFSadnR4VJuJXJDqD1mOADzwtUp1A0ZSXS3FBLZz/+6TAeBx9yElMEcTOJAoAijDYRj
         9KzJr2VfDwiJY6tu6Zf17LRswD4MPFY7wULU+AGVNJuZHXX1O47QVABXLcu/D/EeibgM
         VclmVIZUnlzakmTeYOoRiZoPRgmE1rpKZ7HbF8VEmSB6HMIlKWF6NtuCRNSih/JyrbUz
         rYNbKu1YlJLbL9907i/cUX0qa+dMqaKjtvv1Agva9YhQ/TTKzMUi+VywefHakOlmA6kQ
         5lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186541; x=1773791341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gENHh+LHHspcmPyJqV4yOmmwYVieLWgsYWBJG3PvZfE=;
        b=wY2bvD1DHTOM7OsnT5pDOxI3Mfj1iCBaZnqGgXMQCpsCFBFXutV/taskcSB3C/y9ew
         Iex5P+5uNYqlB7gdipEIWTkQoRQ6DObJmP61OCcMcgu9wyIoIwHstSGnymL/faTmqOW7
         dBrUp6XARRY4mVKigSaD2Uj7Sb8bHxkjWvoj5xkQecZU9E+i4Q3Y0AMYmUIkxBJXi2kz
         ms70M+8QFUi0uCCFzQnND5mgH+vjWCH+d25P43Dd++RN6pFO2VCTpCR25u+OhLLUugtX
         qYUhVImOLvzJ1dhp6jN5/UuwGL9z8GdtU9ojrU1rC2eECzg5A+mw6div496QDyd8YfDh
         LBbQ==
X-Gm-Message-State: AOJu0YySn5BymHOm1nY/Ws3/hT/u9NiZwgN5VMP4H0xNMO9qsC98wwKu
	taZNTUMSQ23kDEkTX7TcPvT/j/uhKNV8NnG3zDqy8kf06EWlAnYnqI0JaBIiWR65lGfB2CprZ6u
	z3BJEPQ==
X-Received: from pjbbx13.prod.google.com ([2002:a17:90a:f48d:b0:359:f1f1:7bcb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5743:b0:34c:fe57:2793
 with SMTP id 98e67ed59e1d1-35a0138a096mr508515a91.20.1773186541445; Tue, 10
 Mar 2026 16:49:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:23 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-16-seanjc@google.com>
Subject: [PATCH 15/21] KVM: SEV: Assert that kvm->lock is held when querying
 SEV+ support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Assert that kvm->lock is held when checking if a VM is an SEV+ VM, as KVM
sets *and* resets the relevant flags when initialization SEV state, i.e.
it's extremely easy to end up with TOCTOU bugs if kvm->lock isn't held.

Add waivers for a VM being torn down (refcount is '0') and for there being
a loaded vCPU, with comments for both explaining why they're safe.

Note, the "vCPU loaded" waiver is necessary to avoid splats on the SNP
checks in sev_gmem_prepare() and sev_gmem_max_mapping_level(), which are
currently called when handling nested page faults.  Alternatively, those
checks could key off KVM_X86_SNP_VM, as kvm_arch.vm_type is stable early
in VM creation.  Prioritize consistency, at least for now, and to leave a
"reminder" that the max mapping level code in particular likely needs
special attention if/when KVM supports dirty logging for SNP guests.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 7bb9318f0703..cbb5886304fa 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -107,17 +107,42 @@ static unsigned int nr_asids;
 static unsigned long *sev_asid_bitmap;
 static unsigned long *sev_reclaim_asid_bitmap;
 
+static __always_inline void kvm_lockdep_assert_sev_lock_held(struct kvm *kvm)
+{
+#ifdef CONFIG_PROVE_LOCKING
+	/*
+	 * Querying SEV+ support is safe if there are no other references, i.e.
+	 * if concurrent initialization of SEV+ is impossible.
+	 */
+	if (!refcount_read(&kvm->users_count))
+		return;
+
+	/*
+	 * Querying SEV+ support from vCPU context is always safe, as vCPUs can
+	 * only be created after SEV+ is initialized (and KVM disallows all SEV
+	 * sub-ioctls while vCPU creation is in-progress).
+	 */
+	if (kvm_get_running_vcpu())
+		return;
+
+	lockdep_assert_held(&kvm->lock);
+#endif
+}
+
 static bool sev_guest(struct kvm *kvm)
 {
+	kvm_lockdep_assert_sev_lock_held(kvm);
 	return ____sev_guest(kvm);
 }
 static bool sev_es_guest(struct kvm *kvm)
 {
+	kvm_lockdep_assert_sev_lock_held(kvm);
 	return ____sev_es_guest(kvm);
 }
 
 static bool sev_snp_guest(struct kvm *kvm)
 {
+	kvm_lockdep_assert_sev_lock_held(kvm);
 	return ____sev_snp_guest(kvm);
 }
 
-- 
2.53.0.473.g4a7958ca14-goog

