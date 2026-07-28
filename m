Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C725B0B9
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199440; cv=none; b=JVrEa7F4weEpYP2kZ1Xocft35c1N1Gj8W5RJRiowv9vCDgIVVvQYvT0Xb1e8kuvSPva5dp8/P5yIn+AtN0W/51WMDSChxDWOpTkUfUkRk46iJP6qWdr+WpPGuKpiKHcFrNKF5RnBuKWg0Vkuf8SYDR3T15O0lNkAhIz1xPhp7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199440; c=relaxed/simple;
	bh=9jeaQH/7DCE6+AeAgv8gNGKyrpVXBrO+HYPinO93xq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=duiP2Bbkiknyz9PEhv30UAmmdpXptL7V/s2z/8Fwy6qb3GBlk09IJbT5VZNVCJi2oqi6dMLj7BIF9k5k0hlGMgR6ufnIOCwGwVvErfR6a84ly1hCGCKFbmwkBvBV0lbzYVsOPgnsUmmmCogshSEqfVzrK9FeaTXLsUg5ClZxg+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W0aS9sOw; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W0aS9sOw"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dd87656d3so3977021a91.2
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785199438; x=1785804238; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=golb60ha+p4Uw7cXywxBMbwP5Eh5UIglUziZBs6F0Ps=;
        b=W0aS9sOwhktWgIQNIfnJtECbUwM9PRCxa+lKtm+aq6xAtRzivdgYBprMt63M2hFUMQ
         FoMBZmAgBy1MnxCOc/cWuntk4aN1nGp0rPwQQhAK4wii/QwNbHBYy6tRRpCcn0sjgyDH
         odLImQ+oZEclougvdzizyceRfmbb+TkYNJU8yKBkrrDswqbNW+k6mZLtgV5MTQgSN9Am
         FYEceuNbSy6W8GalQMPeQDcLxMDoM0GVfoR8Ios9h56M+OJF72y2bSJsz5YqqWXk+K35
         NmZ6MbS9GCSqQqtYHTgEd99npCMrSluSNFLQ3eg6NQbrlwXWFeSMKzlPyg3LW17jnS4g
         eRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199438; x=1785804238;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=golb60ha+p4Uw7cXywxBMbwP5Eh5UIglUziZBs6F0Ps=;
        b=E1Gj/A+3EOuIMFtdHBqoBVH5Dfs0WpEzm9y8vIXFZemGQfujqgw2TG+R3GrXfs/B2L
         TUQ8FuNp9dO5fO88IrBdC9ho4SUjTfiBVngOZB7XgPWrMIVa5tHbYp5JvSydbLvjfEMl
         wyobsGMoT/0Izdgpw1teADy7Sl1RFLR16I2tFB4zp1ofymPEkT1ifHApyg7d3T4LlapO
         4+iOMDcz0qYs92nuUW6NozEf+ZoOI6MLx/sjS7iAINdLKZxZEHNyDkbC4D4dTGRKvo09
         3LQR20YomPq7Of1h6VNrlDxAD3Ayz+VqVRkTLAOJTmWNKaAsBvciP3y2PDqzHm8yvQ7X
         1pkw==
X-Gm-Message-State: AOJu0Yy1tfuvAu5zzCjn/Wp033PAXBs8xpGUcomTxcGqFmY82TXTUKVo
	Bg082fZC+HSc9y2oHUrjP0ME9sCGk8ilj/lNJZBr3cavhcJz7QWWDpYjOveA5io1Dqd+7IM0QU4
	ryKsj5g==
X-Received: from pjbpd1.prod.google.com ([2002:a17:90b:1dc1:b0:381:386f:cb7e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39ab:b0:38f:474f:e78
 with SMTP id 98e67ed59e1d1-38f6a5690bamr158140a91.38.1785199437526; Mon, 27
 Jul 2026 17:43:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 27 Jul 2026 17:43:49 -0700
In-Reply-To: <20260728004351.887076-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728004351.887076-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728004351.887076-5-seanjc@google.com>
Subject: [PATCH v4 4/6] KVM: selftests: Use port 0x80 in invalid nVMX guest
 state test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>
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
2.55.0.229.g6434b31f56-goog

