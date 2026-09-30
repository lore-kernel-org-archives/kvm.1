Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9551643B
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727094; cv=none; b=fJF3vKoYdYLPkqS7rKLrGXApgwxeLW2DNO9GMq2yot6zI4I5EH5raYGM89r4n/fUs66W3T47SdQREk+Ef+ajYF9g7ihXGIii/FWHekLWObgRZXGWK0Oww4lygdbGL67xTlZM7PlHg8iHyNdJZLc95GX4HFym8ORuH/Fzy3vOBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727094; c=relaxed/simple;
	bh=rsmJJopby/zjOBBYlbUWEXvU10fwIFhLZJz8OKxRHo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WSzd3d2jCCRqiWXI6qx/fm0B0VXlPZOVOmBsUmJJBn3dWxLS0CKsYxWrR6KGrTTCI6P6oo7XOi8aRHCBg8mUoGyUIr2TuK/1f+qU4nZBr12zukJpxicN1zGqQtI4XPjdCquwd3k9f7cWCF96q1GW32GrQfLLkAaI5tYqRsh4q9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3wuISXc; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3wuISXc"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d94a158dc8so67429835ad.2
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 17:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790727092; x=1791331892; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hc+7AhFKRyAVFY2si4O9j85hgjPeFQ1ZmzMpM6zVemg=;
        b=l3wuISXcAqZq7g0nrAN7MH2boD+mM1ffv+kLPTUb0OYgL6gBBiCxdq49/8krZl3xw9
         qe/ML2/xv6wkTyanjrPMxAoEdtmLTxSDD5NgVYWg0d9SUaPQ/Mt0wPe3VYw3q+90Cym9
         jvwed4sjcq2KpxA62CckshCRVZXbBtrrcKa+ZcTvqWvLKY7pRoyslVDXmtHtwY46xqYE
         S6a5N9Tpa61Z8wdhZ9xwMzwMKy8KnEStMbFa8hKCdmleQorqFgk2RBq4l3Ben1n2EMQ2
         CNgT3C6Yyuxu76HNbPDRjGxSF9kfDfwK0/WiWdMcD3MklATjLIxlhmhiOTPc7CKoB0E5
         RRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790727092; x=1791331892;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hc+7AhFKRyAVFY2si4O9j85hgjPeFQ1ZmzMpM6zVemg=;
        b=WhUz3PdMVjtmgwHf7D10Hw+jTAbo8WwtoCWr89eOEPw9wKiFHjY62hmEyqYm3V0rQo
         qTt1icnkgjlhygCPTMqUYtQplxQO7aHc4+rojxunX0MDwAcFzQOWDJi4Kya4RXngLHLW
         rb6yrR1TXY0HHdXEabSu1tU+rccYxLAylO5ggVTZfJakPlJfhzlCDJo2BsIxX6mqxrrK
         M+GR3DXYcKEcCj+e9k+WNk3S1NYh8ISxJUTIxFd8jg4CCQl2PJveoQJviT6XmfM4aCv5
         Y4VPwq0149L7yZ331XU6dwx+xMlU9FGAo10BMsiP9EaXWfp+w8iqhdAnICMJ/Zi9PoAV
         4ZKg==
X-Forwarded-Encrypted: i=1; AKwUvBz2JNKTUkdzxV9Bqh9VtQXDS+fiOj6Y6/6Q06BfQ0fik4rwJ8SsZ6UJP1U6zuxQ5dbpOHY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQAxeP3G6W6SQ+2jFfvAVrUqNlJcwjJs1cltu5q4DSkfpW6qjl
	un6133tlyaDjbR5dJ4z/bFSGVQUj0cIMQ8+kmQYZyLn0OU1w787HCCk3L8W+/fawQLEo+QrMozc
	MvrSMbA==
X-Received: from plrd9.prod.google.com ([2002:a17:902:aa89:b0:2df:9a43:558b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d587:b0:2db:2413:87d2
 with SMTP id d9443c01a7336-2e2de428559mr5369495ad.4.1790727091670; Tue, 29
 Sep 2026 17:11:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 17:11:26 -0700
In-Reply-To: <20260930001127.3170009-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930001127.3170009-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930001127.3170009-3-seanjc@google.com>
Subject: [PATCH v2 2/3] KVM: TDX: Synthesize SHUTDOWN instead of returning
 -EIO on unhandled EPT violation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Ackerley Tng <ackerleytng@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Exit to userspace with KVM_EXIT_SHUTDOWN instead of returning -EIO from
KVM_RUN if KVM encounters an EPT Violation due to a guest access to a
pending page.  Returning -EIO implies KVM is buggy, and most VMMs will
respond by completely terminating the VM, versus rebooting the VM in
response to KVM_EXIT_SHUTDOWN.  I.e. give the VMM the option of trying to
keep the VM (from the end user's perspective) alive.

Ideally, KVM would probably exit with KVM_EXIT_MEMORY_FAULT, but KVM would
need to extend run->memory_fault so that userspace knows the fault can't be
handled.  This scenario specifically occurs when the guest has deliberately
disabled #VEs on unaccepted memory for security purposes, i.e. the guest
literally disabled the mechanism that tells it it screwed up.  But, because
this is fatal, and the whole point is to NOT try to fixup the fault,
jumping through hoops to return MEMORY_FAULT instead of SHUTDOWN doesn't
make a whole lot of sense.

Don't bother bouncing through KVM_REQ_TRIPLE_FAULT as
tdx_handle_ept_violation() is a top-level exit handler, i.e. there is no
need to worry about failing to actually exit to userspace.

Fixes: e6a85781f783 ("KVM: TDX: Detect unexpected SEPT violations due to pending SPTEs")
Cc: stable@vger.kernel.org
Cc: James Houghton <jthoughton@google.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 29d4751f37fb..e3723f1222fc 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1939,8 +1939,8 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
 		if (tdx_is_sept_violation_unexpected_pending(vcpu)) {
 			pr_warn("Guest access before accepting 0x%llx on vCPU %d\n",
 				gpa, vcpu->vcpu_id);
-			kvm_vm_dead(vcpu->kvm);
-			return -EIO;
+			kvm_prepare_shutdown_exit(vcpu);
+			return 0;
 		}
 		/*
 		 * Always treat SEPT violations as write faults.  Ignore the
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

