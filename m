Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7B33260F
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860192; cv=none; b=eNcyZl8yKJFjefaCHf+QYx1/gKbNXu0+2GfGWjgOdObhy2c8bHHah4Nw7F1tuyb1RjG3s0vz5thmUoiEiySowyM9SuxXZPrlwrsfFaSOPSbT/jV57ItaVAbhAOq0u+PzJxqgoPZCphLarMMy+gEGyc9a00KRkZo8qzVgXfV/sz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860192; c=relaxed/simple;
	bh=eCGtm3dh083r/pMrL3HoLuJuSVGXkM1waoKJroQbaEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dLxOS7RMQ9lE3Px/RzTfmndzgITh0WvHhlA3d9yO4LLjgO52FWc1gG/nnLC9+S44NhTZMMvDcPscT9Q1ws1Y+z4JYtLOgMAS+xnb++mkcXKJIMRCrJt4a8fF6jOnduLA1H8uHNBiKqe3YPJML+BxfHn3WmDrutgFFfBjoQh8d1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuy0nBvo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuy0nBvo"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-38096521198so129976a91.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782860186; x=1783464986; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yZtap8X6mumQ1mfifTQCUTVmeWh9t5D1YVARVwe2KEM=;
        b=nuy0nBvoyhZOZzia0e0uVIDrESVpqrNp9PWYnl6Gbogscu/woJMxJDhCwbPvN97iBC
         gP2JpUxk6OYtVX3+NklEsZrPQ+kiYnlJ/lOJHpxshSwn65zylEXNqFRB77KUBQ46t/vE
         cMCIDoGaKXMK6I18/zgr3m77hPqAymQXizPTWy8XZFmF/Suya19uwGnVWwv9wzcTGHdH
         sPMo+7iyDY6eoby//QRpLtFIJ6WRw09gyIjgFYEZlA1QiaiVowoa9TKnZ2a1hYKC84H2
         P3awVJzPxRQN8SZXIvnNu0rV9gj84dw7KIYskz5kBVpVcDR0hVDS/qLxYl+7Q/Scyakm
         m6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782860186; x=1783464986;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZtap8X6mumQ1mfifTQCUTVmeWh9t5D1YVARVwe2KEM=;
        b=hBFfjvuKYfYLzeL2XU5ossbX8pKp89bpu9NL2X0uzCB7NHLPLRiJgEIQEeAGCOXBZc
         1BDQ0KRha8tEd6WO1GauGbMeSnccPOAJLVfFSJDGZA9sBSw093RVb5n5etEZJFCor7Cb
         4HyHPU/cTrDAHZ8NjG+5nz6Y6ILqZT8MDA334L0SDbWb54pMOjCAM0cbqE5JaO27lB0Y
         ENQ91Y6Wu676TMKqprfsh16/ZnCrhsSCSqPBcjxRMLwAdt50TEuZvryCzf5ORCr7AFmG
         0JwV9GbWGejpLIWNfYeofUjm09yy2EInizbzS8m6fr58mUDIW8UHdnNQ8au42WHLwqe/
         30GA==
X-Gm-Message-State: AOJu0Yy3DHW+X+oZOSt7u/uTC/n2zGf/NobpFAkxvYVm0ErLaviH/mKH
	A0wjkFDDNorzUq91853S6E+7efUvtNS44qgBFzX0QqzJylsYVPToMz+ezzbjGjWleMxuMcLO4k/
	0QdoVvw==
X-Received: from pjbbv24.prod.google.com ([2002:a17:90a:f198:b0:37c:5da3:8742])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e707:b0:37f:d265:18c5
 with SMTP id 98e67ed59e1d1-3808c0c7c2dmr1871593a91.18.1782860186114; Tue, 30
 Jun 2026 15:56:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:56:12 -0700
In-Reply-To: <20260630225619.511632-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630225619.511632-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630225619.511632-6-seanjc@google.com>
Subject: [PATCH v4 05/11] KVM: x86/xen: Consolidate checks on Xen vCPU ID for
 singleshot timer hypercalls
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Hoist the checks on the Xen vCPU ID when handling set_singleshot_timer and
stop_singleshot_timer hypercalls out of their individual if-statements,
so that both checks on the ID are in common code.  kvm_xen_hcall_vcpu_op()
is already doubly committed to handling only singleshot timer hypercalls,
and even if that were to change in the future, the function could simply
be renamed and turned into a helper specifically for timer hypercalls.

Opportunistically add a comment to explain why the check exists; the code
looks rather nonsensical without the knowledge that @vcpu_id is a common
param for all per-vCPU hypercalls.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 3ed6686e0a1a..7a0d89faca85 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1614,12 +1614,18 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
 	if (!kvm_xen_timer_enabled(vcpu))
 		return false;
 
+	/*
+	 * Reject the hypercall if the guest is trying to start/stop the timer
+	 * for a different vCPU.  Xen per-vCPU hypercalls take a target vCPU as
+	 * a common parameter, as all per-vCPU hypercalls *except* single-shot
+	 * timer updates can be cross-vCPU.
+	 */
+	if (vcpu->arch.xen.vcpu_id != vcpu_id) {
+		*r = -EINVAL;
+		return true;
+	}
+
 	if (cmd == VCPUOP_set_singleshot_timer) {
-		if (vcpu->arch.xen.vcpu_id != vcpu_id) {
-			*r = -EINVAL;
-			return true;
-		}
-
 		/*
 		 * The only difference for 32-bit compat is the 4 bytes of
 		 * padding after the interesting part of the structure. So
@@ -1644,10 +1650,6 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
 
 		kvm_xen_start_timer(vcpu, oneshot.timeout_abs_ns, false);
 	} else {
-		if (vcpu->arch.xen.vcpu_id != vcpu_id) {
-			*r = -EINVAL;
-			return true;
-		}
 		kvm_xen_stop_timer(vcpu);
 	}
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

