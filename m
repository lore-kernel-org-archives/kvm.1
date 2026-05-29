Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0503BCD0F
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093367; cv=none; b=WudoWvE8wO0Wm2E1zP/NIzAxFAh00wVzCHjanYNolI/HFyBX5wZ6IubpbZQ6Rwwcd+0yRi4fJMoa9ZSxrXcKX1UNW5PLlfAr/jEBYShzky83GCOb546Kx5uEKef6Wb9keTyZV6q1ogB9RU3k41RgAQ2K6yksqr9Co+Cbzz/B3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093367; c=relaxed/simple;
	bh=CdEPrCw2bOZnD6mQAwYnCo+zNToy/znjkjkLqqXPq+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b/lT5gdPkEIoEkfXiRSzAKzaEBy/yxbOV2h5EeTPfRdDFDYwvY73Zk6caP9rULpDIS/Nrzxf5WvpHmhpPgygAaYpoUR5RFmMednXirmwxmthvdJgoQo7E9s3hg87gWvyXbS+e6KO8GTkB0fdO8kWHPsQ3A55cfiIwEyzSyF+1wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3nFK79q; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3nFK79q"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36ba98cc003so1282596a91.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093365; x=1780698165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8I5HJekqNdLlzk9wWpRps9qAFoWEmeMnW4XpaBDLerI=;
        b=A3nFK79qpr5i2829Ll+p6ndqC8iAb8z2OnTP3h+gg1//PWgZ/0C6hAt2cW3bObed1Q
         07ZUJkkJZOWXQ4u3claoMPIDJDQOiziIu4tN/g6+7R6kxPUJ64uuKdWa/0yL4veOR+o+
         lmawTYnKoD2LuRBtSWJW1vifbnvHjRI5df7i3KONVf9s634br4b/gm/YkhPgiGVrwBli
         qMVLVgCc1LXII62EK2hyWQFN7PujOXF87woqEuk5I8D4nI6O17n9mGot3riDZ8qRJyDA
         YfOIIfn0niJrUi77b/GmpccUF5keHthiRAG9yRAWB2GBYy4ntu2zFW1d281xgHxYXnKW
         mm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093365; x=1780698165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8I5HJekqNdLlzk9wWpRps9qAFoWEmeMnW4XpaBDLerI=;
        b=MeRIxppojUO27MgOlLQvsuyNxxf0/9woFFVxbhodWTO0urhzCaORAwv+0q/gr0Bb+p
         y/GuOC6eZrlZAdYZHI+E4tXVI1UURNUj8WIIUaquE10vfdx+DrqiqTR8cZCeV2Acladb
         VPip1ky/3P325B4nAkDOU4G9LQaAHRDOSfgKOAENf6RTxfabDV1/Y9uSi6Mcnm9/BQtZ
         cXEuEek6O5xB+H7xgO+Zd7kglwXdQLgkfMzwCJq+XzI+mg1Xxy9vNnj66hfcj5SNOQeh
         CrypqhI2vuKGr9KZZRR19RxVS6zEDAoUkSICcj9iT2uzb/A/xSFftcBOyzazYGSHG2nP
         uwiQ==
X-Gm-Message-State: AOJu0YyzlHM7L68YoqZzm6yPM6WE/bU3DylXsn6QkXE4YGEOeKkQpkGR
	ICKtfIMKoIDodDlRh0NLDXBO+b0M8n2TRvBD8aknIdQsbOyxLzjmEUrziSCO2I9gsTFdZ4G0WjF
	z3/NGbA==
X-Received: from pgam4.prod.google.com ([2002:a05:6a02:2b44:b0:c85:85c9:de8c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50cc:b0:369:b9db:b885
 with SMTP id 98e67ed59e1d1-36c501db446mr1012982a91.15.1780093365369; Fri, 29
 May 2026 15:22:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:45 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-3-seanjc@google.com>
Subject: [PATCH v3 02/40] KVM: x86/xen: Bug the VM if 32-bit KVM observes a
 64-bit mode hypercall
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Bug the VM if 32-bit KVM attempts to handle a 64-bit hypercall, primarily
so that a future change to set "input" in mode-specific code doesn't
trigger a false positive warn=>error:

  arch/x86/kvm/xen.c:1687:6: error: variable 'input' is used uninitialized
                                    whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
   1687 |         if (!longmode) {
        |             ^~~~~~~~~
  arch/x86/kvm/xen.c:1708:31: note: uninitialized use occurs here
   1708 |         trace_kvm_xen_hypercall(cpl, input, params[0], params[1], params[2],
        |                                      ^~~~~
  x86/kvm/xen.c:1687:2: note: remove the 'if' if its condition is always true
   1687 |         if (!longmode) {
        |         ^~~~~~~~~~~~~~
  arch/x86/kvm/xen.c:1677:11: note: initialize the variable 'input' to silence this warning
   1677 |         u64 input, params[6], r = -ENOSYS;
        |                  ^
  1 error generated.

Note, params[] also has the same flaw, but -Wsometimes-uninitialized
doesn't seem to be enforced for arrays, presumably because it's difficult
to avoid false positives on specific entries.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 91fd3673c09a..6d9be74bb673 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1694,16 +1694,19 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 		params[4] = (u32)kvm_rdi_read(vcpu);
 		params[5] = (u32)kvm_rbp_read(vcpu);
 	}
-#ifdef CONFIG_X86_64
 	else {
+#ifdef CONFIG_X86_64
 		params[0] = (u64)kvm_rdi_read(vcpu);
 		params[1] = (u64)kvm_rsi_read(vcpu);
 		params[2] = (u64)kvm_rdx_read(vcpu);
 		params[3] = (u64)kvm_r10_read(vcpu);
 		params[4] = (u64)kvm_r8_read(vcpu);
 		params[5] = (u64)kvm_r9_read(vcpu);
-	}
+#else
+		KVM_BUG_ON(1, vcpu->kvm);
+		return -EIO;
 #endif
+	}
 	cpl = kvm_x86_call(get_cpl)(vcpu);
 	trace_kvm_xen_hypercall(cpl, input, params[0], params[1], params[2],
 				params[3], params[4], params[5]);
-- 
2.54.0.823.g6e5bcc1fc9-goog

