Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9DA4766AF
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763142; cv=none; b=DF7nGhUXOG/enMwd1xbeHOe7ifehoodHnqY49flYqeB4lSL8681NNRCzNlJOyJC9u+qbEq2LJ7LEL5pdhaWPZQxzH3eeQrzC/XlDtTq2u8gh4CMLLoEjK7lMqlbtXopaTsQ11q6CQIp2cp13FxjirsaFabEx03rqWOcaBuY1sYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763142; c=relaxed/simple;
	bh=lkREA2G11nmz7SRzyOBJcWNNVt/g5f2pdE4DPPDUZEo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sBzFGa8JkFHGNhvv4YtfiIhUymdJHpst7enpRRVsGZhBaREiOl2KkVDP4KXTm2FcN3g6s2ynJMAsmOnpQD99ORl1CMNtjZ8D0YP3iC7LkmyPxxMFE5oL4nff/DCkGetCtVLLr8CDOxwHGQVA3qtA8jfs4Uljzw9Yc/6Rix37w9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vo4FJ53o; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vo4FJ53o"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8544b721ce9so654168b3a.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787763117; x=1788367917; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ujy1nVQKuNPW+jM2C9zxuyxo4JdDQzwfltAGwj8ml3w=;
        b=vo4FJ53o3OdED7nWPwpUFc3sSIM6FYPxzjUQthZd9zl3TG9PwM/rxiyfRTopWs1IeD
         IP+1Pmk96Ia0E1+pGinbGOXHwtOpo9XnFagecW+Ar9NS5sOm+R/JC6WzThAAe4BiL3BH
         7nZm3zFrv3NCijHB/rXCeq+8AUmlQ03YkRjru0Y1L+gXKGmFf3azMM4GVUbLHxgGfjqK
         CcuXEIiKheRn7ZLzjfoX0bGz2TbSZC5spJ0RW+PJx+pIrO7Aa1+JeD18kz3qY5Gs9Rb/
         arDWN+bjAl4nE1ayxGGlYvKWQO4Vyo7WIV4oK+Bpe/n/q/Lbhgh7LY6MIL5kg64bsc4J
         g5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787763117; x=1788367917;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ujy1nVQKuNPW+jM2C9zxuyxo4JdDQzwfltAGwj8ml3w=;
        b=lUSjiZAS+g340qPVy9rTYw4zUpPiqMP8UVoIMkVDdncU1D44GcVywHXKZ40ZOvPmrf
         74B8lRA95SICKX9gaBflVAwPFiE1w7PPayKFSIUVEWx0dN5++esS7bckXWHPFcFQ3quQ
         JzHWr/PwfJczxFNjk5NB/BWB5Ywt0hvTEd89bh0Oj06CYJuAn/3bGI4aRnT17M+DEaxC
         OKC5VONDCgyGwGzL0fOwUkKX3v2z3FEX1lfk4quLI525MlaciiB+aj/Le0ZDQVcfuBWN
         C4OJgPKC7pljWhsHGvPIS2ElBCNYd1XYT91Kx/Gt7JNRKbyHbmvs7oOs731y6rRPbKbE
         1iSQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrlcs9ULFdU2dbbSoQYfIFG09wEpIJYHaoIW24Uwmxp1OzezmNIcz0LYhiR/NpjIT96v3A=@vger.kernel.org
X-Gm-Message-State: AFuF++nrkpvoi8bMmO/zVEGg1kerjnUbk61NDQD9dJtwJodeKQdGpXcR
	xtBZh7EePlH18VvBoXSth6no5HVG063mrjGszQj8bxwLOqprjiLbE0fn9loZ+ydxMRVgZWNZ+hR
	pqMxqZA==
X-Received: from pfiu22.prod.google.com ([2002:a05:6a00:1256:b0:84e:a25:1e6b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e08:b0:853:6571:9567
 with SMTP id d2e1a72fcca58-853720af96dmr14898598b3a.4.1787763116351; Wed, 26
 Aug 2026 09:51:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 09:51:52 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826165154.766699-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: guest_memfd: Handle xarray binding errors
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Handle errors when inserting into guest_memfd's binding xarray, e.g. to
do the right thing on ENOMEM.

Patch 2 is a related cleanup to remove a superflous WRITE_ONCE() (unwinding
the slot update on insertion failure isn't an option if the slot is observable,
i.e. if the WRITE_ONCE() is actually necessary).

Sean Christopherson (2):
  KVM: guest_memfd: Gracefully handle xarray errors when binding a
    memslot
  KVM: guest_memfd: Drop superfluous WRITE_ONCE() when binding a memslot

 virt/kvm/guest_memfd.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.887.g758fc8c411-goog

