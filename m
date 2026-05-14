Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203D3D16F9
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795647; cv=none; b=mZ7vJo/DvgcqtNICYyQXSsNyg97q3Xrlqvg7r61XNBOc8Anz+yilh4TN8U/pB3NlhVaWvmnz/2R2moo7ZjP62YtfdjJ6WNx7oA+evhdllS9oYJUy5BfrmkRZBCCNHV0xvAwem2C4+PWyZl6VY19GTIDm2mXniyl0AcgG6aEZ0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795647; c=relaxed/simple;
	bh=dTA/3VR9EH1sMFnfWIiA6Io9L1zUxuNockTCKHiOFxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pg692R7zO1+u/BwMJywbr14rIc2gccWFpSkb2qPSw0HV3KqDk14sr0yOfUmA/PYp7G/jC9jUPagLCPizmaOwxfr6y3+ia+ofdGZg8yU7PYqlcHma/3drqY4meS2c4aCcbT4lTtqBbF/LNoiW/IrBHyGD5Mqix/XWl9WjvhrsYXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SzNulJe+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SzNulJe+"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8024fc7032so4395755a12.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778795643; x=1779400443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9oYhOatBSTmYuzHR8azx31RA/Ba7pTesr7fCEDkJz5c=;
        b=SzNulJe+2zTaydoWpaVvUlC2Z4r9xumpue/Tl7hqVsY5/Zf4IIvB2JQS7pkKk3LJGa
         xM7uHjcYpuKBDq32bVqFLtaaC1XB1H2titmu3nLNNO+YxdCXoYQAEBzU5sdTt+uUqjk2
         UgXMInHWc/lGhpNgZsyoDn1Fmaf+bKbPkdaFjw/VqCfPbB5tG+u6dYD4RRcY593yjDfJ
         VG8igONsAtTaTmKj6r270UpdbFZTXHSukLEzm3BJ5HB7Ez/JXymNpBH5JLTx59S+nD7n
         ++hYltk+EBpspg6t2Ppdt6IvP765Uya7d7uZp2xHsuNbmFDBLTfKM+kg27B+4yZmBWVw
         x6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795643; x=1779400443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9oYhOatBSTmYuzHR8azx31RA/Ba7pTesr7fCEDkJz5c=;
        b=NTPBYo0LXZHRHcAzmdsrbYV9yS95Nmcs7t1S9etpbUILhOYqWOYKlaPVA4v81qazz2
         aZH9LwkZ5RJCDRK6OAid79IZZcVIKP5xdHdQmWWRIrkjsR0PBSmSurHP20/vwF6yMDY2
         Qkq5dtjcJr/ZZJrvTfr4eR/j7QGItHoPB2wGoZL7kqwEkmcAcO9ZztU2CrNkKdGvp5Jw
         mtpKcywBREifgoVUupR5BUzpUt0K4wGuiB8ZN4axUjLtgAVq0jvkUOF4fBJRgkjk3Vox
         FSuuHJG+JrFAbtcAwQ7aTidze1DnW5tayBhqinafG4i2sr8XrYaghAdbJUP4t/vUTdND
         CgHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+blRDLtTKqFes7HMjtBv/uoJVodkJt0Qrgj2oNMDQnr+97w9WfWUzALVbWyd6fXieXPrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqAvfwetxlYdPLmNw0HB/WNBs7EiYP9sSuzI+fEso45ai/YAWG
	9EFrwgTNaJhJRQeTT94NURmTOk5q40F/A2n4qwH0BHYNVKd20aKgTDBkFOgGTB93cbnYN2RieVx
	4zswjBg==
X-Received: from pgbdn13.prod.google.com ([2002:a05:6a02:e0d:b0:c82:7498:e3b5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244d:b0:3b1:884a:c3d5
 with SMTP id adf61e73a8af0-3b22ebd8ce1mr963273637.24.1778795642494; Thu, 14
 May 2026 14:54:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:53:45 -0700
In-Reply-To: <20260514215355.1648463-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514215355.1648463-6-seanjc@google.com>
Subject: [PATCH v2 05/15] KVM: x86: Trace hypercall register *after*
 truncating values for 32-bit
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

When tracing hypercalls, invoke the tracepoint *after* truncating the
register values for 32-bit guests so as not to record unused garbage (in
the extremely unlikely scenario that the guest left garbage in a register
after transitioning from 64-bit mode to 32-bit mode).

Fixes: 229456fc34b1 ("KVM: convert custom marker based tracing to event traces")
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 209eae67ab18..23b3957b9ae0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10430,8 +10430,6 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 
 	++vcpu->stat.hypercalls;
 
-	trace_kvm_hypercall(nr, a0, a1, a2, a3);
-
 	if (!op_64_bit) {
 		nr &= 0xFFFFFFFF;
 		a0 &= 0xFFFFFFFF;
@@ -10440,6 +10438,8 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 		a3 &= 0xFFFFFFFF;
 	}
 
+	trace_kvm_hypercall(nr, a0, a1, a2, a3);
+
 	if (cpl) {
 		ret = -KVM_EPERM;
 		goto out;
-- 
2.54.0.563.g4f69b47b94-goog

