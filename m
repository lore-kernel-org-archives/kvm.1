Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558653BB10E
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426992; cv=none; b=i4UXEX/wMJSrNWo3Ej61sVm6zkbAGzk8ETpJI26safZnu3CB2lEjJqTC7yhcneezOU6Pzb3egqVgZL3S2HMvTWCQHGeXyqMEEcKCE1r9w+3XDAZxFNQzPEQWPNlKzfReHZAt2aoBzGN59jXGJm8XDQtJWT3eBPTgVtqOHWV8j3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426992; c=relaxed/simple;
	bh=8HxPBU9SZPjdBMrZy4CVoqrwUO5xu5o2avqHHSOyEMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R99CiLS+JkDsCbux7KnS+8BWCNg7oqieMKeNw2e0CNF+y5edtT2lsbeaR3HixzQnd2pEbzWPAXa4pOSlvkqKaies6nayKxDJezbuf6C9O7XGalHrJVlqnvJo2ESIOb3lVRTM7UpHHXROpeavVsiAGhJVQhBTl7S3qUqgL0grPWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LITPLLL6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LITPLLL6"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37de9c29aecso309185a91.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426991; x=1783031791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OmCzffinlUA5U4j9SV2YuKuYabtz/0IJql9W8lgHC5g=;
        b=LITPLLL6Myg27ooFOhRuWwnAJ5M4zUV7r+tzf+irv1M50Il9cFwz6EgXmC18yeKPuv
         BH9jhzmsfd57laGkMUXKY/139PbDVNcFLAgwyJ0e6hiA934FhPHc+jWpjnz66BObuzT7
         uXT6AkswLlipgzI/UFBkJ0V0wSsZTpqgJXc5ZNTW6HpMsO2O9nY7M+7vh2KepAXvwZmo
         n4ld7s35s+mXyg7Hhsu2/M0407/4Znq49hACeBb47zhLV7siFG+sPuYKPkA5j+IDZ1pu
         u8uH7aOiNfJO5QezMlSYnumZgF4dF7yD3hKYnpcneki/TAOXYIZQewHaz2GRKXh9Q7ev
         kC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426991; x=1783031791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmCzffinlUA5U4j9SV2YuKuYabtz/0IJql9W8lgHC5g=;
        b=C793ornAcMIG8xqpTxSjPxKj0loC5MmN1WbTqX5uW/F69Voa2OFdRvhlqJOKmmeVGP
         Pmm1u46JX9olB1sxZJ3q531EKFiWDHKWbIR466p4WSy6ZHRPzfmHM4D+eqaHSKYqlJtF
         cPrw0R40SHLXM31HgPoh+FgieRnRaxC9nUWw8X1fd4l97yav+srkrGCuKNVWD2yKw5wu
         i0CzFZ1O6DqF4awbBKOiwRKc1WIkR9J29z24+snD+O7ybTDx7zHsmw5ROPD1AQ8rdxC0
         KcIh0gU+EMEb27Ngdj67+exClaEvmpmz1vLXeJCplUAEnYEN4eKE+yZWaIJ8IP51uX9T
         w77w==
X-Gm-Message-State: AOJu0YyQ5VjZfof6veWXRgteGHjnB0b0HwcOTzLWRjZixwbJ1qr0bKT+
	NWNZkcNO5JjakmMwVhvMc1qgvZAZF/FYTex5IHEdFHDExjBwLgM8pcbjJxEQGrVT/ZFvUNb7P5o
	1hR0KkA==
X-Received: from pgbaz13.prod.google.com ([2002:a05:6a02:4d:b0:c8b:6fd:f93f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:270d:b0:37d:d204:d14d
 with SMTP id 98e67ed59e1d1-37dfa1c70b7mr4442374a91.6.1782426990409; Thu, 25
 Jun 2026 15:36:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:36:18 -0700
In-Reply-To: <20260625223623.3376478-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625223623.3376478-6-seanjc@google.com>
Subject: [PATCH v3 05/10] KVM: x86/xen: Consolidate checks on Xen vCPU ID for
 singleshot timer hypercalls
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hoist the checks on the Xen vCPU ID when handling set_singleshot_timer and
stop_singleshot_timer hypercalls out of their individual case-statements,
so that both checks on the ID are in common code.  kvm_xen_hcall_vcpu_op()
is already doubly committed to handling only singleshot timer hypercalls,
and even if that were to change in the future, the function could simply
be renamed and turned into a helper specifically for timer hypercalls.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 27c1aeeab8af..db10f12d10cf 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1614,13 +1614,13 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
 	if (vcpu->arch.xen.vcpu_id == XEN_VCPU_ID_INVALID)
 		return false;
 
+	if (vcpu->arch.xen.vcpu_id != vcpu_id) {
+		*r = -EINVAL;
+		return true;
+	}
+
 	switch (cmd) {
 	case VCPUOP_set_singleshot_timer:
-		if (vcpu->arch.xen.vcpu_id != vcpu_id) {
-			*r = -EINVAL;
-			return true;
-		}
-
 		/*
 		 * The only difference for 32-bit compat is the 4 bytes of
 		 * padding after the interesting part of the structure. So
@@ -1648,10 +1648,6 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
 		return true;
 
 	case VCPUOP_stop_singleshot_timer:
-		if (vcpu->arch.xen.vcpu_id != vcpu_id) {
-			*r = -EINVAL;
-			return true;
-		}
 		kvm_xen_stop_timer(vcpu);
 		*r = 0;
 		return true;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

