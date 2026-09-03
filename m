Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C901B808
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394588; cv=none; b=FaufwMZD0IlZr/GVR8AhqF/LM0y1/NvpgRDc+wt/jwk38fuaj6lGwwHgyUMyDktftuNAsF+uJ0eouzQBQO6/eWosFqgpzN33UrXMLoqhXU5PlLUvv9KEOnzkNuGnG6ig1sUQqJGsG9erKvcSJHtcepoHPuIa2+VkIZtoEDoG4HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394588; c=relaxed/simple;
	bh=p3kIujUfclIHgrp+ae99x6feuE7UCrPnVXI5HMFwwzc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LSFduhW25WQtgxCHvv13K0Q3WlQnWJ4qOx+QUu1q9vK+Ff5szT3Zid00BXHZi9hBA212ZTXbgXM8vFjvZxFUYjLUO1bL10gzK82RS1EVxC0Fg2KPoJDZFilznTuOtb++QC7qrjxDd1arFrMnLNNIVnVubtm2egCjwnLX1c0uCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=efKg0w/t; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="efKg0w/t"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-395543dc382so2334130a91.0
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 17:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788394587; x=1788999387; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vzm816r0LGTVzlU6FqzDKHr2Q746+h0dW3Jpg0VBIpA=;
        b=efKg0w/taBRBJcPdfJpXdvZ59L2HHla0sWveYv+OxG4yzMf4YiBxTzU2H1Dmr/MFMz
         PBREBteo5oDWHOsXcZCUe2nMzG4jSp+glQbu3U7ufWuNqWw/slBoI9GEQD+C8DMR98ng
         2ksIaJItybyM5mHiydhBB+WYfwpdmcBvqhZYey23d9mACKbke81gsHQV0v/if4apnub6
         SAFHbJM23L2fAxTHHnLOVwCPuZdj9l9j394ckVYPebfxewdz+GN6iGq0opdrcY1mF4K4
         UYpxKVGzsYGjD35h1BDcQTAzGSC5zZQaD7W9KhBBRZRr6Zzpr612eUk6eM5nTB2534XC
         c3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394587; x=1788999387;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Vzm816r0LGTVzlU6FqzDKHr2Q746+h0dW3Jpg0VBIpA=;
        b=Y6RLSnYh/qP4xzO35RVU0zRbCUfFNqyY2hC52jGjAh7CDlnENKyZaR2WAngAXuS2v9
         HWlWPDb5FZudMlMend6SltCIgRP0z1M8sNQPIs4DA43gx8ebDMiWPdM8Y+LIlPKZSsCy
         hfP2W7pLXsSt4O2E8TUx0OfgiZzoPhQDnYDY50LCwKVi1bkOKAlh8cbQzthF7ozdCLXS
         Z0Q7O/02XEnUvPi63o/oLTVhxgLotf/YXorXDwwnSS3Vf8OZ7ihEp9oVAlepKmOokvyl
         LbloPAj3TdKQ7muNvgNIje9K9qAM1cb+xxkDVMMDBOXtH3fdDm9/Op4EUqYdDmPO8uoz
         Hjkg==
X-Gm-Message-State: AFuF++kv2RRRJ0tEFL+e0OOXUdwuTxML8TizVrUKBsDmZL9DKfRuaHFS
	WsZEx+I58QMIm+MtbdevULo7dzPYIOPKYKnOFOPlYta+ISzV5y+TJrZhKERwtrueMwZdAHpsiX0
	fhwke0A==
X-Received: from pjzj20.prod.google.com ([2002:a17:90a:eb14:b0:398:c817:fd48])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57eb:b0:398:9be6:f995
 with SMTP id 98e67ed59e1d1-39aee1110f5mr12722550a91.20.1788394586534; Wed, 02
 Sep 2026 17:16:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 17:16:18 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903001625.2792367-1-seanjc@google.com>
Subject: [PATCH 0/7] KVM: selftests: Fix maxnodes bugs and cleanup related code
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shivank Garg <shivankg@amd.com>
Content-Type: text/plain; charset="UTF-8"

This is a spin-off of Shivank's series[*] to fix "flaws" in KVM selftests
handling of @maxnode in various sycalls.  In quote because the flaw is that
KVM selftests followed the docs, and the kernel has a longstanding, poorly
documented off-by-one bug.

Along the way, massage the xAPIC IPI test to automatically run its page
migration testcases when possible, because that's the entire reason the
test exists.

I didn't included the guest_memfd changes that were the focus of Shivank's
series, as they are bigger and more involved (I'll let Shivank tackle those).

[*] https://lore.kernel.org/all/20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com

Sean Christopherson (5):
  KVM: selftests: Account for kernel's off-by-one bug in NUMA node
    syscalls
  KVM: selftests: Compute node masks on-demand in xAPIC IPI test
  KVM: selftests: Add common helper to get mask+number of usable memory
    NUMA nodes
  KVM: selftests: Automatically run xAPIC IPI migration test when
    possible
  KVM: selftests: Skip xAPIC IPI migration test when forced but
    unsupported

Shivank Garg (2):
  KVM: selftests: Fix maxnode argument to migrate_pages() in
    xapic_ipi_test
  KVM: selftests: use BITS_PER_TYPE() for NUMA masks

 .../testing/selftests/kvm/guest_memfd_test.c  |  2 +-
 tools/testing/selftests/kvm/include/numaif.h  | 43 ++++++++++
 .../selftests/kvm/x86/xapic_ipi_test.c        | 78 +++++++++----------
 3 files changed, 83 insertions(+), 40 deletions(-)


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.970.g62bdec98f9-goog

