Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004C40960B
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630208; cv=none; b=dJEeUCAcNdgV6fdCIelSLUUse23oNRVCjTEyB9BwU0V6/XQFnM7AlR1SpsW9I7Ayi5aVhXvagxKutf76lpqvCJ6j3eRGxkQV2qjP5+2Sq87XkKo3SObviz93pCu5RdtKDcGQCYTjamuheGiCe3jMOvHl4jG8rkACIo1IYOWS8B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630208; c=relaxed/simple;
	bh=CLopC9ueBQIpZiMex7cJSz/lEEuWBgcn82yu9QM75fw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lgcE+lvoG1dvXi6DTio/r0a7HDjawcWBDmwPWbFsN9JCkUT7OMfI30eWHD6F+We5zSjg9DBSdBsMAD4XtxdjxMEeLmjWgQMzZt79ZE1h60eg+mzxIw8P2GQPhdf2LJ1QAEeCncf46U8h576IDLcHxe7fSBHlOUY1p4DzLzH9lSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRt0nA6f; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRt0nA6f"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37d4f23eb37so456728a91.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630206; x=1784235006; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y+YnjyILCJ/LQYr8IHTZJIswKUs28JqFys7E1ZCvu7I=;
        b=rRt0nA6fd37bbDibrlKCDteErqiW+TltEUD0oPhpLi7ZtkL3tBg4WpxvzF6g5wg5hO
         sCJiXCNbCf5n7Ip/gZI3vZzIrryKt06SILctpVNlIEFKObPS+H8sNhUZHNYrdX9Yhnkj
         AlFHOU7mIDW5bj4JA4MjA1Ju10VwBhaqWCtZT0JsaZZN4kUgXCkQ28UqIERmjL/XCENh
         7jHXCqJI7eLKLxWjN1iANMGb9tuXcXpU3m8xx/z1/uh/Ui14ADSNbhu2l1rv/lN3k3+3
         X4XidI4pHYbZuM+7zT89RPu4h4qzjlLide51Tcqkfpju1tJWjhGDPAuqg8u1XvvEqDvN
         ReTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630206; x=1784235006;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y+YnjyILCJ/LQYr8IHTZJIswKUs28JqFys7E1ZCvu7I=;
        b=G8H6VKXV+GUatu6hBiVR7iXK7XJY0bSvajoUE7UxZBq0f+AUNr0M6Fdju5mqB1dpll
         YiJu5mey31N+B4r//im0/bVYvp7Ry2fNNru+YoKxz5AUicp8RI6BoMe4+y0iLl0Ad864
         X8JnFT7bO6+S06zWO139bWwtaS+nqY3RrFKyjA7n1S/aTw5Ke5+yKP+SE/YR/aDmq0nc
         eVWnkHGnTyGwI5dj3iCklXgohB4JbABHsvmOSJ9bZdErPzLH+2rR8uji5FOcTkBtSiPV
         T830DHN80PixrBMBnMlQI4daIs85y6Gt1VZR7VfImLzm65QUTs/XTZLShxsFzDm/3vgn
         qSqA==
X-Gm-Message-State: AOJu0YypJgZSTUPd8/lMa/twPerGYh60dxB2qdDTpYd48BK4gj9LoGyK
	d9NperbzTS06BJiOLKEl34EagLWQj62mzXvqCMG0PHxz2EupZY2JNX6nTuTvD0vRKezKd+piOlm
	WFYEPtQ==
X-Received: from pjbqo5.prod.google.com ([2002:a17:90b:3dc5:b0:381:ef4:4373])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17d0:b0:382:1aaf:4bab
 with SMTP id 98e67ed59e1d1-389416e7dbdmr8322970a91.27.1783630206130; Thu, 09
 Jul 2026 13:50:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:44 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-15-seanjc@google.com>
Subject: [PATCH v4 14/18] KVM: guest_memfd: Drop the redundant printk on arch
 gmem_prepare() failure
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop guest_memfd's ratelimited printk to log "preparation" failures, as KVM
SNP alreads logs more precise messages in all error paths, and whether or
not failure to convert the pfn to private is "unexpected", i.e. warrants
logging, is firmly an architecture specific detail.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 7ad656e30f9f..f4f8635d1a10 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -66,15 +66,11 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 	kvm_pfn_t pfn = folio_file_pfn(folio, index);
 	gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
-	int rc = kvm_arch_gmem_prepare(kvm, gfn_to_gpa(gfn), pfn, folio_order(folio));
-	if (rc) {
-		pr_warn_ratelimited("gmem: Failed to prepare folio for index %lx GFN %llx PFN %llx error %d.\n",
-				    index, gfn, pfn, rc);
-		return rc;
-	}
-#endif
 
+	return kvm_arch_gmem_prepare(kvm, gfn_to_gpa(gfn), pfn, folio_order(folio));
+#else
 	return 0;
+#endif
 }
 
 /*
-- 
2.55.0.795.g602f6c329a-goog

