Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE048B374
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035969; cv=none; b=umpm7/44qq3LS/hog6iIy24NKCYtHNqHB8ABdTwBIyzaebrTlrHzYG862nKELGvP6+aFV+365IQ8mMTXD7WGeFQAyT67dskABbVc/0mcPJqGisk6TyHOHwMnDIa4R8Iyt9pVx0zOBkWrijHnFXSUwllNtMq7gFIbal13rBpoFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035969; c=relaxed/simple;
	bh=8QsSGiEAaqCQy0cZvG0XEQmjL6NBrQ5rQlcU3Mw2rGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eag3gyNJ1uJL9eCbLX7HSR8SKuFpsUlZBkJPaKcbfQViwP2zI9/OCP3C5WeiuQ3mqfOifUAyuTfulXV26D0ZkDsCD0ayoiWaVYzHQYRnNI4cQcwfyewnvWejEjy2EBeCh7IXwqMQ3HMYdbS87+i75D1lLcMdLl34lvAITH1q8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fP2iZSTF; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fP2iZSTF"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c89704da8c7so3498895a12.0
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 10:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786035967; x=1786640767; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aIw+FKSYh9yZePv09d+Ay5MUcxdlIRKZjplIOJy/wbw=;
        b=fP2iZSTFxkuWhjT+jkV2Rf/pnBgK4ScRDqtybDhg8DKOLjLQmBja6qzROtKTvG8J3v
         6OM3D2kgZA8puRH1QgmGsWT4+H1tM+iiZpEiMD1PjfXefUrYH1hu6Kt1O+K2z93UBgFC
         X4dcdlufB9CXLu995WsO9QFKIE+kqyvt6D5D/RR/JTUFqWyoXyAOEuCMa7qc0n18AEEI
         3baIz55hTn3e79wjTJBtUFuqEcV/6RWAbCFWdNwd23EBYc8Tkhr6LwiVfYJjGpdedSIo
         8Zm6i6OmMyAPlAEV/X6UxRFnlA7K7C7Mm5DAs9d40KTrFAm1wVx5uaCSvkIi466c5I3W
         opIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035967; x=1786640767;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aIw+FKSYh9yZePv09d+Ay5MUcxdlIRKZjplIOJy/wbw=;
        b=ZKTY/QOdBu4wJ2cj+rPiOp3eMvTij7S00SAsu7H/+c8ZPbNOtFpO9DTMTZiv+PS2rU
         fUkApEmc/kU/WmFc6NrXXj0OoO8LXXwcgEcttP9Ufc7Q5XYCKqSA3UWVeKYWdGbRTjSi
         RiGn9q+4sDmxgfIXfuUBlhndKt3be5mXbflBMgrkF6HKj5aFhh02p4gGEdM5WPS9uQSO
         OTbLSjeHD3uu2C7RJ+UheplEWB9WuhAuYY9/XhpMGHiuCxVKGofEe0r24booPkl/uImG
         vJVk7QTYX/r898TrWOLzBPEPnJXd3dEla4LUM/PgtBW6JyPb9ENbSFHDliUOtRiL8zFr
         gdAw==
X-Gm-Message-State: AOJu0YyWKiwAjNj11OdHuFG722HtRBIZfhntpM+XUPawz5HoRJi4wkD9
	7EQH0ilTtV5NDTLTxukjftE9ttFzgbzLlum8WENII9McQCwwUUDmxPpSRw9q5nAFbe/X1qOkygD
	1MZcKIQ==
X-Received: from pghu18.prod.google.com ([2002:a63:ef12:0:b0:c98:2639:852c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:164a:b0:3c3:a08d:5b44
 with SMTP id adf61e73a8af0-3cb85ef9234mr20536509637.23.1786035967107; Thu, 06
 Aug 2026 10:06:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 10:06:02 -0700
In-Reply-To: <20260806170602.4112602-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806170602.4112602-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806170602.4112602-3-seanjc@google.com>
Subject: [PATCH v2 2/2] KVM: TDX: Fix a benign off-by-one bug on the end GPA
 for INIT_MEM_REGION
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Ackerley Tng <ackerleytng@google.com>, 
	Haotian Jiang <jianghaotian.sunday@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When verifying that the incoming GPA rage for INIT_MEM_REGION doesn't wrap,
check the inclusive last GPA, not the exclusive last GPA.  Super duper
technically, it's ok if the very last GPA is -1ull.  In practice, the flaw
is benign as KVM x86 disallows memslots with GPAs that exceed MAXPHYADDR,
i.e. INIT_MEM_REGION would fail with -EINVAL anyways due to the memslot
check in kvm_gmem_populate().

Opportunistically use check_add_overflow() instead of manually checking for
wrap, mostly so that the inclusive math doesn't need to be copy+pasted in
the "is private" check.

Fixes: c846b451d3c5 ("KVM: TDX: Add an ioctl to create initial guest memory")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 929115aeb9ec..85699ea021fe 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3219,7 +3219,7 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 	struct kvm_tdx_init_mem_region region;
 	struct tdx_gmem_post_populate_arg arg;
-	gpa_t nr_bytes;
+	gpa_t nr_bytes, end_gpa;
 	long gmem_ret;
 	int ret;
 
@@ -3241,9 +3241,9 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
 		return -EINVAL;
 
 	if (check_shl_overflow(region.nr_pages, PAGE_SHIFT, &nr_bytes) ||
-	    region.gpa + nr_bytes <= region.gpa ||
+	    check_add_overflow(region.gpa, nr_bytes - 1, &end_gpa) ||
 	    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
-	    !vt_is_tdx_private_gpa(kvm, region.gpa + nr_bytes - 1))
+	    !vt_is_tdx_private_gpa(kvm, end_gpa))
 		return -EINVAL;
 
 	ret = 0;
-- 
2.55.0.679.g6767b8d81c-goog

