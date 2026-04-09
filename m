Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1A83A451E
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778993; cv=none; b=ngsB/O2XrUMkQe76BssF5R61dkUos5g3dqh7bjd4KMvaTlSn3348bfMyM7zZ3rdG9e2OElbu6OifKkHzsJ+CRTDHvDx5xPF8b5Uz3TIiULi7Xx7T9Ri+Rkk2pUyRFNnxyG+JIDfFwKXsB1UJm5QarR3ECCdG8+71Z/eS0iGyl1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778993; c=relaxed/simple;
	bh=MLPbDs7G9OqZY/ATYYqkDlE0YrwaC5HEkVfQitezKW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a10C+3KY6OaQA7/L4Wgu/oK7BOmp/NsV/R1bFtG9y97a8lcwJxAQQBBhvGK0ezR3zbfO8ceCyzmBTirGZeVL2EkzRFwMs7e4p6V9jBrwsNCZV/bxYKwL2hgV3QV29+6hmDmmhv6WtOTKcGsGDHjA4uSFiwIocXQAGbdAwiRa/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEKwJbK5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEKwJbK5"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2489af602so12889535ad.1
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775778992; x=1776383792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kvn3DIliRC0vkcJ5m6p3NVdVRox9S3W73snYIAUbEYg=;
        b=WEKwJbK5T+pAAOtT56/2OujCCD7ub1UTxyM8oHL1gq+oqFwEFuvq9/igUHqIdiHpPO
         zYxtkqe0Z597t9M1jGcZXVReI4+jQ7rHC+Ck+fd1jfZ5u8WLeH+MsYa6QHnlW6I/DGoX
         mhd3JVXt2FL2dywPLBYfT2zyZGv7W10n3apvYr3l76zqNSPXrVkQc0p4taWMGmeLzBu4
         vXoGWDzdffHcj+u4rw9l1RZ1efQ6kC33omL5VnPp0dtw2sNahIsAku7J2txTOx324lCw
         p2nDcu9QKZWo85PGkf3ZGiNtILE1ibELNKHUw+UQ604MLfeQZROYOs5VbDCx+yJpe0Te
         9FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775778992; x=1776383792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvn3DIliRC0vkcJ5m6p3NVdVRox9S3W73snYIAUbEYg=;
        b=X2XFJwRvjGwKyA92PbggGgd/c+lxk6HNfv1Xd83ye341iymf5BEwx5373HkqKZsjJu
         lINcEH67fFfKsZGaLC7gh8n1em5k/GqRRl/9hrKneGeUq4g2OGkGBIGo9XULkzrV8ngq
         22/6fQ69iACBUM5s1FwKaWNwKK1QORxR1yFq+0DUO/JW2SZ8DAb4o69ezjt4TgMiQo9i
         MX63kLjB4E6GgaScRsLWzvf91JsInFpQQSVhei3jmX0lDeT3NIu+hg6891Bc1hKUVuJ3
         U9/Q+2kFRYvkSIrBA9mQSKRfm6exXF7UQHqUQwkWEdQbbAQ79GyE9A1RIOnYS5sF31wV
         C9Ug==
X-Gm-Message-State: AOJu0Yxwbb4EZ0+4YxUSCwZ/80C1OB+jGWEIYRKDND/x2mNPUrGnCQVm
	YT9suvuAYmNy9H3Ped2Aq2JqwlXLZ72FpPBhNPwhEFFt/oXaDt2aq5eCoBzt7QFTYvGPFs12VCI
	Xae19VQ==
X-Received: from plrx22.prod.google.com ([2002:a17:902:b416:b0:2ae:815a:73f4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:120a:b0:2b2:6cab:3127
 with SMTP id d9443c01a7336-2b2d5d7a278mr6355145ad.20.1775778991635; Thu, 09
 Apr 2026 16:56:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 16:56:13 -0700
In-Reply-To: <20260409235622.2052730-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409235622.2052730-3-seanjc@google.com>
Subject: [PATCH 02/11] KVM: x86/xen: Bug the VM if 32-bit KVM observes a
 64-bit mode hypercall
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
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
2.53.0.1213.gd9a14994de-goog

