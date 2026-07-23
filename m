Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA03E00A3
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840905; cv=none; b=pH5/KXvF11UxdzAO1D61ll0mxmn9uLxZ2Uj8MmtgGXDW6f2Oprfz59R6PshJGyc40GqU5vvomeHJ0T1Ca/JIIu8TUkjKtF1R29e7vtsuLKiEX7XuVWXaajfBqhzEEWxdypXa2o56PrreI5kEz0sS7ofSaSMYZFc7vuEFKR+0H20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840905; c=relaxed/simple;
	bh=LljWRFUKb6b8P53VSK2dy8jrpSiFxDei2TKifqh5AZk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mkk3aSOZv6EMq1h5IfLgF8DaV5BMKGG1hN6XoZl6/KGt24dJ52SR9buY954aTaEAcrIInYq4yhnhQg0vKTs+VhH1zjWsVkQ4SbsP5dK0VjlZYpxD7SvDEutmfeekQ3KG8XMBDWadX8GCQLc+1NWFtjLP6JltNyXnzkajHdHngxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rm7SvqAC; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rm7SvqAC"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84865f326efso1185452b3a.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784840897; x=1785445697; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fbwF6vr/AOTW7Vn1a0v89zwGTRmaPYHRuV1v74U/8hY=;
        b=rm7SvqACJnm73fOfx2fHpCKKV24BxWiWPI5zs4xZQtyfPvKob3YETVXUgMaC8Uem/i
         65E+h5749uVYPSW1H/IWud/Yz7+UXX2b9od4iEQuPdartpsfYGosUI9SWgt4Kw2odRFN
         ImWfHTTVuU7WAzSmllm+dggRi+froCMucB3sFixAn/8mzHmQzQzRozYTI10gpEkACTRP
         Hr7OIy7PPjQ6aIThEJFAKB2aLDWY5ARjxAlYcGXmPg/c8TZ4TCWMhUxmvOXoUE8IVIik
         NPuKQptPsct4J1AeTMwWMWnQmXmF1EFwZREU6P5t15qKZzZLpedaKlloAKbRGCphXnqa
         wx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784840897; x=1785445697;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fbwF6vr/AOTW7Vn1a0v89zwGTRmaPYHRuV1v74U/8hY=;
        b=BKOEIOtbH31rmv0O8pXcXICAOy6bu41sXLBwCfmx26/yVku1nc9nOiBUVK/QMLLuFf
         +rUkLFafQ3rS5yu5RrNIdiU5i7F85gsDmBJHdRTw1IFUmtpBUDqhzZ102r6HRpCq4yYg
         binx0M/az34K+hshULck2bRvxuYky0I7jPnomi2uinYmvH+PH2BSOQdaITwQcBsVATgf
         noOYdjjZ4r5Mjzl9KAOa64UvWiJSdo2u/RPpO9BB8HkAwmYBl9l4yQ3zAS9yEGdA49Dj
         CEhILK9ocauuWMaKHtCWBFoI2zbIXhMbwecEhdbDJyXXsiZMHcYuCz54OSWY/cTvRBpQ
         jNnQ==
X-Gm-Message-State: AOJu0YzFaytK7s8PnMdL5ZLW6myKkite/+Px9y1y9BDCXipBUSKyiUay
	890Ynh+aKrDxFWXvIClLQXtv520fepBNR7tnC6ICqoKAchix/eTYDFCQ6nIIGACJOvfXH3qwcVa
	EJZ1rCw==
X-Received: from pfeu4-n1.prod.google.com ([2002:a05:6a00:c0c4:10b0:848:2a35:eb83])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b902:b0:848:2c6c:dfc0
 with SMTP id d2e1a72fcca58-84e2b898e78mr5346341b3a.24.1784840896735; Thu, 23
 Jul 2026 14:08:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 14:08:06 -0700
In-Reply-To: <20260723210811.72720-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723210811.72720-5-seanjc@google.com>
Subject: [PATCH v6 4/9] KVM: guest_memfd: Drop the redundant printk on arch
 gmem_prepare() failure
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop guest_memfd's ratelimited printk to log "preparation" failures, as KVM
SNP already logs more precise messages in all error paths, and whether or
not failure to convert the pfn to private is "unexpected", i.e. warrants
logging, is firmly an architecture specific detail.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b5272645a98d..2effff582f50 100644
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
2.55.0.229.g6434b31f56-goog

