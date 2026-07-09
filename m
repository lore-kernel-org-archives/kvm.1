Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C994343E5
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630211; cv=none; b=DxfNxkOGpfAVjqO0dSczDOjXlxE7uVSUKrh0qkKUcp9RFJyM27IeQUKjDT3dHNOn3hQJ4HgJ6R3nGA+3GebriwRHvLbMY4Z5q+eVBam9cSfZnJ82swejPUVwrGItxk5998KLR0FDvpXdYU4p5/9cy2DbvAUpoqotr9jD/Kp89Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630211; c=relaxed/simple;
	bh=sN7EOmhfbdWWBf6tg/SVHJ9RGHkeFOcz/Gn/S9KQhZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Od6xpXxxBH5+2wAiBgkjC3c2CXOceht02aVOY6cHQD3V3CRQnCXdziflP3GgYhYBtFhDd+ZEdsKYNQdicsy2AC6ZPfRYnS+jj0MLlRGoQsOKXuiHGzmk8NzvZw8mPMQpHrOgXCpZYmcApK6w7DLPhVfoACVoblEiVefJKd/PUp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJdA/f1V; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJdA/f1V"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cc8bde6318so2838345ad.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630209; x=1784235009; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U+3Iis0sU29jrcmmXd/DJV03ZbZygojCmBlJWK/r8Oo=;
        b=uJdA/f1VUsxPHyQwt7vNaRhWRMx8Vjlz3kBp47RSSbxV/JiWTPJfm5OCjAttUbZgVz
         dx3SjJEPfToO43Bsyxp9C6tX2KU9aavADSU8lMPidgcPuK4xiypK9yjdNXYoeSvJP/E8
         qa2S+V97e4QfIqwadMFKBuAcQuvRlCGIsKWLSGKU81WE4txv4iXUg1d57gJZC5pW8YDd
         V7XaV3O24Ptm615dKybO2OZD74kPvoGOYEashuhyIl6Ktj/VyJmCWgQ9jcI6Eu9Fvj7f
         SnjBMf+0HQwSmV9O20qR6t79R/my6JAxYQFlE8CZ7TtYktTtrkn3qwvDZOy9db2tE1t2
         x0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630209; x=1784235009;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U+3Iis0sU29jrcmmXd/DJV03ZbZygojCmBlJWK/r8Oo=;
        b=NbM5yKu8r61EUVfQ16ZyF6Ks507O9w80jh/esbhTOec1896qN4pcvaLf8lXyPTEcW7
         uqk/8w5jVYkGoyab1we+R+qoMm3DclKwvf7oilkJtIykWP8pWTRU/K1MFaE+ksxt6dsM
         8tLOoWrjFDkuzPECTHhHY5IAUc5K2TU3ZHuuPSxo66lmaIOxvFCicXMD9Fl5RZO10iFY
         rrS2jSpv5SO8ssDOoAW06mXtnEGYbY1tmrWzJY/m8GaLxJ4/rRwxKCaukfqdJLazLulP
         Gdakd9oKAMSdJhDhpYWrEJAuzUGmc7SrfzqoDbzXU/uIxJjcjsQSKtbnqThpyTC5IGpJ
         mRSA==
X-Gm-Message-State: AOJu0Yze7GQ4TjCsnOGzkMVjjwM75wNlmmJG3DctGQgoxkPPXzjpLqdG
	zweddSU0rXI34E06Gm14t6FaDC2yFp3XWuXPsgOtIa3BkC+01sTPOMXZYlvU3yf6K+qEkzeSrON
	7rI1ivA==
X-Received: from plsr16.prod.google.com ([2002:a17:902:be10:b0:2c8:219a:17e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b83:b0:2c6:9f66:d573
 with SMTP id d9443c01a7336-2ccea373102mr99680565ad.2.1783630209448; Thu, 09
 Jul 2026 13:50:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:47 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-18-seanjc@google.com>
Subject: [PATCH v4 17/18] KVM: guest_memfd: Align the gfn as well as the pfn
 when "preparing" a folio
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

When preparing a guest_memfd folio, align the gfn as well as the pfn, i.e.
preserve the effective gfn+pfn pair provided by the caller.  If the folio
is larger than order-0, aligning the pfn but not the gfn would create a
mismatch set and unintentionally crash the guest due to assigning the pfn
at the wrong gfn.

Fixes: b85524314a3d ("KVM: guest_memfd: delay kvm_gmem_prepare_folio() until the memory is passed to the guest")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index cd7a795834cb..4082cde3f3fc 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -87,8 +87,8 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * checked when creating memslots.
 	 */
 	WARN_ON_ONCE(!IS_ALIGNED(slot->gmem.pgoff, nr_pages));
+	gfn = ALIGN_DOWN(gfn, nr_pages);
 	index = kvm_gmem_get_index(slot, gfn);
-	index = ALIGN_DOWN(index, nr_pages);
 
 	return kvm_arch_gmem_prepare(kvm, gfn_to_gpa(gfn),
 				     folio_file_pfn(folio, index), nr_pages,
-- 
2.55.0.795.g602f6c329a-goog

