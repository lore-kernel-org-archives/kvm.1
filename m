Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E518F45DF40
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886782; cv=none; b=FUkKz8QsK574XE7hGnjyyuABXFhhfDQpUR/7Xptvta6QYydquJK5FX+wyLjaMqvrnwOWRFjvup9zUA09upqtQ5mMKm/Z/9YedupY3FXWE5Mr14cpu7TWcbDTLq2GAw22hBIux5j/9419JWX6fbiH2KyPtVLVHvHRmOQGuzGLmiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886782; c=relaxed/simple;
	bh=4cNseqJHyCRSmBZnTa38ZFFXEI0fQN1xPMl3CqlFtU4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hP3tbNE/H2JoF3fx8905MO8RKI4uusgPbXb0tZBaMB+7T9zbSclTUdWis2Ua8gXDYZ/TOorc2THqJ/qeH2XminzEFZYOFkPSMh1txI4JJu65WCf0NgRdUSm/HQLpx7xDgveOqe/vjY5K+P3or+vF20mVcEUt9iYYdLG+MFEkE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gg+Th5ao; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gg+Th5ao"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84859a64079so594987b3a.3
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886780; x=1786491580; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ylZqUeoLaLfQt/SbHDySdKd2LUI+wnxs3fPQEqBHbJQ=;
        b=gg+Th5aoEcwvkEwH2kUQf9XXHxPS7rqMPfS9MuJMu7q3LVrTj1NJrkMH7AYuxJepRC
         GJP1iWkQ3vLsow6bXWnRXXKhIFaCAtjire4IbfvIyq6GmFlrvQmht5NlBEUWxteBQo/l
         ynOMvhAHfio/xNROEs5SjAhyiSjMEh5FJimMd4pQsZnBxZB03plH3eP++e5vspD/C7M6
         7OibgjUyoy9LkhREMooGNYBjzEAT59fdKV8Ch3toVrNhmJ6Wg3BTp8o0hPSKw1XrihIB
         Y2iOq/HHjlG0gS7yunMtXHcmtoth1N1B4vyKbVGrl7HqpEsu9LEB1lCsBeqy9Iu8sBJG
         ZPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886780; x=1786491580;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ylZqUeoLaLfQt/SbHDySdKd2LUI+wnxs3fPQEqBHbJQ=;
        b=Z9QmKs50lAI9LZUQnVt3hCufTKghXlfz9eNPyyedy6948UBzOZ3uCkDEWBbzi+OQBY
         bgZLStUMD1NybyE4KdOnvt/TBvBRoCLFjnTNGCr1ZlQzss4yg8M94n76ZraIkyDTPuja
         YcthzkGHwj/NdMspKHaX8OARjSDLkYRNNENCz4yeJEPCVosB36nGvXIfjIOLmAGurgxv
         AZTV+EqjmHm0P1CblkUuGo+O2vZEINRUoNPli2nAJ93sb+qvwbdt7beVeSm28DPLFtvk
         6iT5jziznAa0GRKBhTfR6+GXj6r44kRGffpa/x8YnVwiI/pHzXY07nDWrA72Fo1Ww8UO
         cfEA==
X-Gm-Message-State: AOJu0Yxoo5SB7UMKLwnhw5QhBh2AbU+h+uFXUxEt2QtR/gI/2/Qq8HDa
	5hBU0ZP7KDuF0P0XXg5Pc+1yhNhLu91Jl0AFFxka9TF2ujH5QYB9bEOYTwx18M/vEibyjfYHYoc
	+zT3tgQ==
X-Received: from pfbhu27.prod.google.com ([2002:a05:6a00:699b:b0:84a:3b83:9673])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c89:b0:848:7f56:1e44
 with SMTP id d2e1a72fcca58-84f2dfcfcfbmr2273989b3a.7.1785886780109; Tue, 04
 Aug 2026 16:39:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:16 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-13-seanjc@google.com>
Subject: [PATCH v8 12/17] KVM: x86: Fix compute_guest_tsc() to handle negative
 time deltas
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

The compute_guest_tsc() function computes the guest TSC at a given
kernel_ns timestamp. When the master clock reference point
(master_kernel_ns) is earlier than vcpu->arch.this_tsc_nsec, the delta
is negative. Since pvclock_scale_delta() takes a u64, the negative
value wraps to a huge positive number, producing a wildly wrong result.

Handle negative deltas explicitly by scaling the absolute value of the
delta and applying it to this_tsc_write with the appropriate sign.

This is believed to be unreachable in practice; no path has been
identified which invokes compute_guest_tsc() with a timestamp from
before the vCPU's TSC generation was established. Fix it for
robustness, in the spirit of defence in depth.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ec39ca82633b..5667cd17672b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1054,11 +1054,15 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
 
 static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
 {
-	u64 tsc = pvclock_scale_delta(kernel_ns-vcpu->arch.this_tsc_nsec,
-				      vcpu->arch.virtual_tsc_mult,
-				      vcpu->arch.virtual_tsc_shift);
-	tsc += vcpu->arch.this_tsc_write;
-	return tsc;
+	s64 delta_ns = kernel_ns - vcpu->arch.this_tsc_nsec;
+	u64 tsc;
+
+	/* Handle negative deltas gracefully (master clock ref may be earlier) */
+	tsc = pvclock_scale_delta(abs(delta_ns),
+				  vcpu->arch.virtual_tsc_mult,
+				  vcpu->arch.virtual_tsc_shift);
+
+	return vcpu->arch.this_tsc_write + (delta_ns >= 0 ? tsc : -tsc);
 }
 
 #ifdef CONFIG_X86_64
-- 
2.55.0.571.g244d577d93-goog

