Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CF42DA39
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402510; cv=none; b=NrFkolsbbDBghDqKQaDZKx4LmBeH+NqfONCw2XWimz2LK5fDPrvXegeCR0iVkkL0uALz3GmvHlvoUWc7uPmV6yjnzsktZmOd8S6d9yZagRI+ivYpwHXA0kjobE8olAG3gH55r3dvlGU1H8svPPA+SRSoFiqgK0d6SgVk/XtF7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402510; c=relaxed/simple;
	bh=Enz6UW5jzOGeDIUWfw2NOrqdPdPLO7aFr63mUWyvVPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OPH+1yuDSRRFNbC7Aw6HLqo0YZP8/QIWwxbPHvhY6CYW9C6FckUuH9H1DmgPiVnbh8lly8AWnrytLzlu3lkSiACLoagnElLHCuPmBP2cDfST0fXt1PZKhnSfMyXQOXiPA7Vu0XTRoJAgtkGy5TgfWT325bAGDE8InYFPRtV6C/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m1lUxP8T; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m1lUxP8T"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso3680812a12.0
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402508; x=1787007308; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XHzSwUqdKhsWaqPZjcPYfGCwbZbHLD3pwjjXIIUeXRs=;
        b=m1lUxP8T4ZJmp5xD9IVYcfnx/+Bdp5OyuYe7HT6d6sHS8YlfBOAJbiLIvONkiGTxef
         71+TXixa8wkAM2M7u3LeBuR+ASfVsrFz7npgb63MYaZ0olYDDXmPMnm9fleBUSNZdnet
         QM1l3gYU31xfGM++UUR8pD4wLTLzLR7nqg0coZqAR/22VW69BPYfgpGVC0OoMRSnmTh5
         l09eAuA1AXsw5aiwgscEWIQpelvkfw/dCYtwzL4Nvsr7Pc/wCjoGe2iCG+9+qLjOQDGR
         SdmzjNwmhAvROy571j5okcjWdLSEH4mp/VldaZ4wB7JWJZAjz20IlV2EGl7Lq4roPjs9
         u0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402508; x=1787007308;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XHzSwUqdKhsWaqPZjcPYfGCwbZbHLD3pwjjXIIUeXRs=;
        b=CQN141v6wEioSkfRDVMaegl4FXwM98q7SaQXN8RPvMe60Be0SUn8sexm3+PwuXaJYb
         CaO+HPJno6s2A0h4op2eOnQWxENtfG+PkCVbu/+Lg9EIW/PgqXgL8ulze/jf+V+PPDGX
         6L0dFV5uV/tMAMfB7OvPmBeGUmhN01j+d5+d9RuE6gnOaCCqB/93qIQF0f62kgTRFWpW
         ppBGQz+Hi2a/vyvc0LOkSTrrXazXAxr7poKVn+qlb3+S1dEiVfIz0Wk4/YnTM0H9u/AG
         tzvrpnVYbuK1GHzw/dvE3bSg15P98XPAUCXR1w9hL/l5HsiJe3sTVOygcXaxWx4KgRQW
         XpQw==
X-Gm-Message-State: AOJu0YyCEANfHDmFxTKHWQIg17o24OAfysClj90/vy/1M0BPctZZB2ef
	KU9iGcY0ZxKemBSsQ5Wj+QQiNWATtMp9pEVmL8TucyDClykYewXqEagfoN9DXFqQT3xFITrsKvp
	kG05t0A==
X-Received: from pggq19.prod.google.com ([2002:a63:d613:0:b0:c9a:2926:8ac3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:92a6:b0:848:2a55:7110
 with SMTP id d2e1a72fcca58-84f6976eda2mr25023581b3a.36.1786402507740; Mon, 10
 Aug 2026 15:55:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:42 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-5-seanjc@google.com>
Subject: [PATCH v9 04/21] KVM: x86: Activate master clock immediately on vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

Previously, the master clock was only activated when the first vCPU
processed KVM_REQ_MASTERCLOCK_UPDATE during KVM_RUN. This meant that
KVM_GET_CLOCK could not return the host_tsc field until after the
first KVM_RUN, making it impossible for userspace to follow the
documented TSC migration procedure without a dummy vCPU run.

Fix this by calling kvm_update_masterclock() directly from
kvm_arch_vcpu_postcreate(), after kvm_synchronize_tsc() has already
set all_vcpus_matched_freq. This ensures the master clock is active
immediately, and KVM_GET_CLOCK returns a valid {host_tsc, realtime}
pair as soon as a vCPU exists.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ce6d155b2ee6..137a1dd2b85a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9447,6 +9447,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 		return;
 	vcpu_load(vcpu);
 	kvm_synchronize_tsc(vcpu, NULL);
+	if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
+		kvm_update_masterclock(vcpu->kvm);
 	vcpu_put(vcpu);
 
 	/* poll control enabled by default */
-- 
2.55.0.679.g6767b8d81c-goog

