Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6242E43E
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780004; cv=none; b=Far4b8bc52bKyDEeVuNjxy8f+6c2SnHAMasqi5y+DFYxeclbcAGfX5YKYgFY/h4Z0Ma5piiw6qy0aJw7JQ9TUZMXKYFvsAT8Y4ec6/Ebzd9JFKhyV/fpDqUHnwxWmalDXAaTHCsmWoZmwCwsTCfY1neX3Fim7WfrKa4uavrs++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780004; c=relaxed/simple;
	bh=HjzfaZn7iMtm1a+7Rn0/BRb39wt8D8ryTBsWCam3NPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=flY4HSJzdCqEpNz+GaUxpvDiCJCcCRXBLSfStS2DMkVaDZrmXz7RfJrwYgQMd/E1Xh7QD8vQbB6wljU+hnMmRko6KN96Yuj3Trt9fgmQ70dLLPFDCLnZyDUyQDmHlxDgYKr0nEUPx2l8Hxql6AAqZJRXj4FQazcY5bZem3jiFYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=epVsk11b; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="epVsk11b"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so17067925ad.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787780000; x=1788384800; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=brsNxXs+z/LAPT3lGQq+uK9uE3dmP7i0Bl49SpdLG/o=;
        b=epVsk11bPDVoP8V12aCESMuGxIXRylWmW/lFgzmUuw33YzFXY2FnS67l7ywE9i4y5m
         PhvE8s0c9bdca5KnpQV6Oo0mXpzsGJseuqeEyihVCqjimDmolywKRpNrb9q8tLO9ZD6N
         ZPmoYIK97BoQVHMIMaz+oH1QxLnfoWcJrmb6AszIDlo/dhuVQ0VYWfWCdMzP2ClzCJJ3
         WhUj3CGmobodtIcrSOofZuPP22k3JQRZYcGN2VWLcl88/XcEMlILlj0GseaNZVkKXkfy
         Ih8VVD53DG6OPHTRNR/PfL+2MU8T5HzBFsDJQ3czfROHyWIKYg2ZQzzCXcwWwdWh9K0W
         Pd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787780000; x=1788384800;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=brsNxXs+z/LAPT3lGQq+uK9uE3dmP7i0Bl49SpdLG/o=;
        b=tKOrGHQDaewHBRrV9FaQn2d6B7MVeIq6xxfEp6mJGleRdkpKOQjh9TLGO860zB8t6g
         kg8MXUzOrH4x64XEIhnQP3MpH9ZdIOAAIHzT0oW4eSeP2SG2DZZBpDlBzf3oHbHvONEN
         j7ZQaNuALJMjqqq0tXpSGQQw/udCIlJ/mraeFqfB0bhCt/jRVRSp/jOvhhcreUIPBQGG
         Sq96rwfAQyNJNzu4rltiKW5spq2N1OvZaIQIG3EqqAAgx7JZobEYsWzAUbsx0GlUgPhW
         3mTW8uJQvu15AiBM294ZZ+X095wXfPI1+Yed2T7ouThSB34Y+R9LJanl0tORRaRPq2Xy
         60lA==
X-Gm-Message-State: AFuF++mIM5ee7MJSja92Qwk31LiiVuMbxM0JD4eG0qkZvOn1ewBHe0Yt
	JVMVn53ZncdppL11S7clXniTe9zZanFDIXmEHmAsIHdYUuVliHMxIJ1mPpQ+0ibeNxh09vyBQDV
	bdVLQ3g==
X-Received: from plbkh12.prod.google.com ([2002:a17:903:64c:b0:2d3:7c58:b100])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:950:b0:2cc:777f:d67c
 with SMTP id d9443c01a7336-2d707c07e9cmr181434615ad.13.1787779999707; Wed, 26
 Aug 2026 14:33:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:53 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-14-seanjc@google.com>
Subject: [PATCH v10 13/21] KVM: x86: Fix compute_guest_tsc() to handle
 negative time deltas
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
index b9b7ae965d6d..09435f153b5b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1056,11 +1056,15 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
 
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
2.55.0.887.g758fc8c411-goog

