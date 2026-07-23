Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB3F3F3288
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840907; cv=none; b=XnXvR9hmLXGFfb06/zXdolB7Nu8bqGBYLfqxVmFsaaUO7BP1hwf1EQYPRyPLBk/upupWXTYg6Q4Re1pl2/PlK/95KKzx+TO5hqUgKqXZfLCMYr8ChO2KL6qwKEK7pf//QfZ3MQvJvzesZG//P7l4HfWpwJoxAsL8g2J7aZ6ZQ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840907; c=relaxed/simple;
	bh=il5fIgZarUP1i40dd38C4qltoZmuiFcM1dhxxldYAls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U6a3xKIKVoy7X8Pkt+i6TMeFgHE41uyImNakIexNnYVY7KTsHg3W5rVCgvQtUJDVewpCO+P8kfrlhmMIyYXPsoDN2SiX18EPk9GfwQgUkgl/oZbVO3XRsEoGXW/Sd0XVYJ40l0pNVAGD1VBF7B4HBUXRov6IWL9bCHSauyu1x6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2CQpFHB; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2CQpFHB"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848544a8496so1250701b3a.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784840899; x=1785445699; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0RRn9GYYGgZRcSQviEMPgCBppz0KQJ7kyoL5I72dbzg=;
        b=C2CQpFHBlSOJWv5/sTEL811ABB69eR8brYbJ2Vv74yoXB2du9mpW3Plka8ElTcVXJ6
         yblLCaYXqW9DKG89nLNMKbvJAc4L65plKluvGOjIfmMCa9Npo3jYip/chceU0iuak67L
         izcJBuzVJqnu2xS1VNcQsqpZ92/c3fLwTTl2BJpflJ5sMc0PjwgdC3vOtW8PGlSAc2Aw
         gAS+nu7WMMGvGgwpfwj3HeUexaKdhmS738htuZkOYA9eq4LLjjtKg4hnC6fdnFwze0Sv
         OuZUr9SyX/TrSl8PriDHizMCH82EkfNFNQBNSF8xQqODrTmROkpvaA5bJT7ad7/Ekgm8
         tLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784840899; x=1785445699;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0RRn9GYYGgZRcSQviEMPgCBppz0KQJ7kyoL5I72dbzg=;
        b=TojGV9AELO6DV0fK31lOQD5vu3d87tt8XEev4xgzsMNZGWY3QjfPCVcWOyGHvGD5dQ
         RN0oQbrwjTTCw+W1A5oI3ye4C0WV+o6NmHL3588OTLc7ewPPnuZulnEAp+95YwKX974t
         Zee1ko9qfBssZrUWb8XkbxNEAACU+HGIWs69iV3RqhKqGLiV+ewlti3Zd6/BttyO3qCF
         83ScAA0m3wCz2T5THr619/61E73geYHWTnzVQIZLzgwVzJiL/HX9ZONXf8Ui4l/36JE7
         t2DKFiVUq8BiAEalMYxSJgGzfshIHkosGS381dNMWpJtYL0/bOM8xO4tqEJLMMYPKCNp
         PoxA==
X-Gm-Message-State: AOJu0Yzg6EFoeYQoTftVY9MaoisYEH4fh7koFBi/ipphUchZJWxS1ru+
	9iDzJ/6akksq06qQ0fATU4dHCBuUARhiLNddcItBSOQCj2n0uXzF1BkZ8eiaqo8A19ss73Llfcl
	MOpxWPg==
X-Received: from pfll21.prod.google.com ([2002:a05:6a00:1595:b0:84e:4f2:22c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21cd:b0:845:ba94:a56
 with SMTP id d2e1a72fcca58-84e2b82f77fmr5623035b3a.5.1784840898995; Thu, 23
 Jul 2026 14:08:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 14:08:08 -0700
In-Reply-To: <20260723210811.72720-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723210811.72720-7-seanjc@google.com>
Subject: [PATCH v6 6/9] KVM: guest_memfd: Only "prepare" folios for private pages
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

When getting a guest_memfd pfn, prepare the folio, i.e. convert its pages
to private, if and only if the page is actually private.  The misnamed
prepare() hook exists specifically to allow x86's SNP to assign pages to
the owning VM in the RMP when mapping private memory into a guest.

Guarding the call will allow renaming the prepare() hook to better reflect
its role, without creating a semantic mess, and will become a hard
requirement once in-place conversion is supported, i.e. when CoCo VMs
support SHARED guest_memfd pages.

For all intents, no functional change intended (the sole arch hook is a nop
for SHARED memory).

Suggested-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
[sean: rewrite changelog to fit the context]
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index e9d61410e5fb..f64cd87ec8b0 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -814,7 +814,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		folio_mark_uptodate(folio);
 	}
 
-	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
+	if (kvm_gmem_is_private_mem(file_inode(file), index))
+		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
 
 	folio_unlock(folio);
 
-- 
2.55.0.229.g6434b31f56-goog

