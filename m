Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645CD41A931
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070635; cv=none; b=HUjjcjwlRRsKQn2Wu+BLXeqGun0e//o0G+K9DMq3W04AEPE3o8C4SJJRdqoXOrk9B7eLV352T2hrDNSg/DafxOoOeZ2ZSgfc8R6moq9ybrQUmMEmdzzpvxPOyFNROqO5Au4rDqLZxjupHZ6pb7ztfOA3UiVOYz/ihUtZDWXb/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070635; c=relaxed/simple;
	bh=JVKNzQsp+I7eOcRjNI53/TPW+1qioHsNQBp2VmMJGls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B0zsmnqD6QxppzLjGeWRqbrB5jF09A4MJX31gKTbMjms6iShE/XjFxdsnjlYS6+CYbYtLSUoXONUxLHC+xyFFD5UfDLUw3HP2tTK5cpCFnBdmxH72bZSXAvn+xVnGh03m7ksvTAI9FNLkj5Edjad3Zv1r6nEw1ivn4SU3qP4ens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOMtl06K; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOMtl06K"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ca860baea9fso3463716a12.2
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784070630; x=1784675430; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TkVP/QC6GYBOjGmFAKL/AZv0PRMUOYSMFnc3s7NXiA8=;
        b=pOMtl06Ky0kvefdSQvFlEvY7qkuAbFyqtGP6NXf2BTF2riZZ01jJK96UHNxX5MuZkz
         b/6LnIhkjDkfpfWP5DNfVz4gNSCQHqgME7jmqnrLExDP3SnBCnlAscZTV0dPE9SYjA4f
         gHaqK974WGB4ePGKQ5kgJs6LfBNhekGZxf50p2k4t82n5yg4ceHLPPsh1IxxujqAiRD/
         txC9K2F2I34vMWEYwcblxojAxIqOGHDovSPEQnClrqPXELESZyEFZqqCX3r90UlotvRU
         uroqjI5eFCc8TJXSzIhOwWBTonwgpSd4qHl+muwp2U3xu6AQY4RGJzI4AFIhr9VEJdyS
         MHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784070630; x=1784675430;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TkVP/QC6GYBOjGmFAKL/AZv0PRMUOYSMFnc3s7NXiA8=;
        b=nb8wq1gDrRmku898PqhE9+9Lzg7TvKrFSOjZKLPAgF5ztGlbUNSgnSfrG7p8BiYTSr
         GKw5wm9hwtS4LhAxfjYqBoP8htE44a51lqSnEeIOQ6BlpihrjrehdvZiGhriIGCpCqNi
         aUPjIUyzQghQUh7v0Pq3XO/Vdp3nkM474IUyJThzT+N7kLSmvqE6NKyiLuGB5mcykXUf
         +s/syKZhYxMMV6wW0jWOInk/d+tLxjcjtplH1wJUYVRaWJWl6CiY8qYR9Gy2+BdQh36a
         c01OJHVzHC6pekW0VAp1GF3x6f8KIrcexeAWmFuzzyxOZiFeg34SjbAklvwfB3QdHFPR
         4YVw==
X-Gm-Message-State: AOJu0YyWI29rpk8XmaoCwi7neYI3MaPZxWeiqw8g8s14zWziLGQR/gHG
	L//NzL6cXC08n6b0IFErN3R0xZ1MvnSMDZQy7wJXdV1zhqD1F2Uzzf61FTrRnkxuN/F3n9yR4jV
	sgMSnPw==
X-Received: from pfbeb6.prod.google.com ([2002:a05:6a00:4c86:b0:84a:37df:a3b1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1398:b0:843:49f0:f5a0
 with SMTP id d2e1a72fcca58-84889649003mr14779210b3a.32.1784070629377; Tue, 14
 Jul 2026 16:10:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Jul 2026 16:10:11 -0700
In-Reply-To: <20260714231015.3337831-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714231015.3337831-4-seanjc@google.com>
Subject: [PATCH v5 3/7] KVM: guest_memfd: Drop the redundant printk on arch
 gmem_prepare() failure
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop guest_memfd's ratelimited printk to log "preparation" failures, as KVM
SNP alreads logs more precise messages in all error paths, and whether or
not failure to convert the pfn to private is "unexpected", i.e. warrants
logging, is firmly an architecture specific detail.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index d5d227476cda..62c2c157f0c1 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -66,15 +66,11 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 	kvm_pfn_t pfn = folio_file_pfn(folio, index);
 	gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
-	int rc = kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
-	if (rc) {
-		pr_warn_ratelimited("gmem: Failed to prepare folio for index %lx GFN %llx PFN %llx error %d.\n",
-				    index, gfn, pfn, rc);
-		return rc;
-	}
-#endif
 
+	return kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
+#else
 	return 0;
+#endif
 }
 
 /*
-- 
2.55.0.141.g00534a21ce-goog

