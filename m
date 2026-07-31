Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4944E053
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519233; cv=none; b=m4nBhHU/bcb4vPC11w/fVs+ASFntlqZABp3yC0AmsAKi53Wm6AtyllaVV7Ej40EeRKZsKC/ZQABSGnp+fxOwFcUeI4cUuen9Yvzem8MsScWe+IVG9IRH7BYGT3KB7CbCSJ0B3j5atVTj4YlVaz4xoaK/skFBYLKfwdcPPwHRWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519233; c=relaxed/simple;
	bh=/9IaeOvoXcU42Ex+UfeVc8spxZ4BxaqPlkHGOrDK7e0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mTM7oxce8eNXysTwfto9V5zbLyxOpUrlywrbXh/KT7z80XgamUxgMaSRVyor8NrZEIwhsBeEOX+8YQBxhZCoSqJ8r57MC56YGJNlmPB2o498HyIHZMLjmD9erqvsWHETBW09t4wQ1xx0CaxrU6Ma907jo0tWJDsUTY3sepVFpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAihRKru; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAihRKru"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85798977dcso1931588a12.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785519227; x=1786124027; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8ZTp5IeGTNDM5j+o13PTbyW/bv5QJuW6fwzK9SHEypE=;
        b=LAihRKruYB/Aa3uP3CWMZHf3dZ0hO8wythwIAHD7oo1AMD+GDQcg8m43sVXdAmbVWN
         eUN3UHAxvAfsglGQCcH3hm6crSUmrFP8eKWqK4+tGAhipp5jW3DNJ2WrQ4ijnIjLdGIF
         TZOoTnNhv6IK2WYCv4bljwzKvcWFjqh9e7E3UrcTk26aPCeX2QdSn4jijHBJrGMZSEJe
         BT9bCNouTlYCmIj/8wKK81inxgJ9/6wSBIPzJRp0ns4GMbVDNZk1vUvDQQYLpfWP3TUR
         6nmV6/7AICuoR1U99QOhJv3m3XmWMc7cNFZ6rqn+vTPlEX299SgHqFiCXf1Iiov7++DS
         kSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519227; x=1786124027;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8ZTp5IeGTNDM5j+o13PTbyW/bv5QJuW6fwzK9SHEypE=;
        b=M7coeO2l9yj6hRpF3pS4pCuRJ7F7+bvrtTavxYW9WilVqSS+vdaoGLFByfekh560bd
         KWF8c8L1YIgXZJxQ9PU8lW3PGNr5imRZDmJUifC769U+qiBsh9koAbVrCxQc2dkjHVc6
         pAlyop2cq78jeh8satSOaxbcnjopmnG+e5OYvtlAoHw1qxWdZR0qWTbCDTgZkovOVzMK
         Pn0qt+jgpJOW+d/4d3vSAqZ4ZQqsMwOhnFkRDg9UrKdOKC2DMslQOjR0gWkiUYMSgCOL
         7QbasDreFAJI/1jNvx+VQFUtJjTtn91SSaWfwMWdroigOwrDDGDVsTOEqpQcnd08gYhA
         OtXQ==
X-Gm-Message-State: AOJu0YzE55nliS+e19jKiNtwtusGsmaLfEGQBMMgmhui4y/LM9LO3QXe
	yIYswl5brS4cpvbjKVZXb90l4pWfL0+2NYKl67NSPqZ0jfmb3RivraP0uoqCpdvB8DEX+NHsWpg
	YlYf+Xw==
X-Received: from pfqz16.prod.google.com ([2002:aa7:9e50:0:b0:847:9be8:84d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8b93:b0:845:cf73:c1d8
 with SMTP id d2e1a72fcca58-84ee47f6f71mr316580b3a.14.1785519226974; Fri, 31
 Jul 2026 10:33:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:33:38 -0700
In-Reply-To: <20260731173340.2644656-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731173340.2644656-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731173340.2644656-5-seanjc@google.com>
Subject: [PATCH v5 4/6] KVM: selftests: Use port 0x80 in invalid nVMX guest
 state test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>, Hao Zhang <hao_zhang_kdev@163.com>
Content-Type: text/plain; charset="UTF-8"

Use port 0x80 instead of 0x2000 to trigger an L2 => L0 VM-Exit in the nVMX
invalid guest state test, so that the test can be expanded to cover RSM in
the L2 => SMI => L2 path without having to manually encode a MOV to DX (the
immediate form of IN only supports an imm8).

Use port 0x80 as it's a well-known port and is used by other tests, e.g. in
the coalesced I/O test.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86/vmx_invalid_nested_guest_state.c      | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
index 578283893ab3..fb9444ca0d7e 100644
--- a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
+++ b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
@@ -9,7 +9,7 @@
 
 #include "kselftest.h"
 
-#define ARBITRARY_IO_PORT 0x2000
+#define ARBITRARY_IO_PORT 0x80
 
 static struct kvm_vm *vm;
 
@@ -19,8 +19,8 @@ static void l2_guest_code(void)
 	 * Generate an exit to L0 userspace, i.e. main(), via I/O to an
 	 * arbitrary port.
 	 */
-	asm volatile("inb %%dx, %%al"
-		     : : [port] "d" (ARBITRARY_IO_PORT) : "rax");
+	asm volatile("inb $" __stringify(ARBITRARY_IO_PORT) ", %%al"
+		     ::: "rax");
 }
 
 static void l1_guest_code(struct vmx_pages *vmx_pages)
-- 
2.55.0.508.g3f0d502094-goog

