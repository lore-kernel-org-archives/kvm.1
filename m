Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C40380FC7
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420165; cv=none; b=nd1g0a95juD4OlXFy2VV9UZT/0rNleLRbEfsMNCyYSWW0HdUtgaMj7rXZAOzfcsIJ9yovGkGUh3DBiIUZVO9CEG54UCLCgEaE10NXLjh+0t7npcLMYaQ8ObdLVkYeSFXtPm8ltM8ceBmvh4r+VlfFtNQ3uhJYOvVlN4T/Y/eOWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420165; c=relaxed/simple;
	bh=6rTR31kB6avfq3MvmleHep0ECW/oh2n3nTMgoYl8SjE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I8Y8brVRoeRFVZjRu3Dkv4CdCzhkcuOmALRaE7EaO5hZhE5L+m9onnxtvqyeYTQNl7nUc2u8vcLDK6O0QBzOLgf4pK0h21nyP8Ci6CJ/mjNanA4cULL+QM0dBVnQND+I06BeWpUsNFWJcGI4yoWt56uhePAFLNY2eA5gY4zGQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SlKoWlBf; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SlKoWlBf"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f424d5bso1999414b3a.3
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420163; x=1781024963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ca5/RrcPCE0biJRsq797bgCXdqD1Fn5qsZLMiW22Pc=;
        b=SlKoWlBfjUQDWwX9m8MVfI2YvbimNnr3kCz19pRCj2l/Y1DQxtLSzfdALPzvoCJNsK
         fCTZeFhUmh20uQ8Z3FlFrtK6bsOWjRbUc3f70upZu97gUusTU1InFaZawhyfpZCQ6oV+
         3s8jMKBmO/uCJFAVpOO0ZhpllWjm71fEMd/rO1cTkkALHdUCkwM8vG3w/4QP7ANGDc4m
         0kuESahT0Kj36MF8c7vaLZ6wWxTEOB13FCicJzrE5mkAxXnJ3dehP6jADb704GoGb5cP
         2DytDp9D0ayp7EWT/DCRALv2oY4yp1J0MSOz8WVAhMvk94ieYsVea8IcKU+r7aWGXId2
         6B5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420163; x=1781024963;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ca5/RrcPCE0biJRsq797bgCXdqD1Fn5qsZLMiW22Pc=;
        b=MckMXqN2Uj38Fq3lgZbwgMHyVjcq0VY2jnDc2jolKEq/mI1ErmT1CQFbOxYsVh4seK
         K+TF/s/qhSRzicgEVG+zoiHUSoyOJnLlz70CCO6d3B69bfEjns0wcuKHj0PTyrcOIrhx
         Y7zsp+eUdMtHsSmz54UK6dBT+kYK2bwXnxnkgR5TxUaz34FD4rV2v6/c7lpvsJdQJN/c
         lHYb7atcMF0/eoKHlwxIJ7jIu2faRD36khR9x2MMd/ZFnHbRyi1gA/Q0TCu9hgStgxkr
         tOxLiLxzvWPDq5riRjANTcp7dzVbM6Snvq1pkr89rKS8MJ1elvPowp4tD+bYMlKFKyGW
         Ibbg==
X-Gm-Message-State: AOJu0YyJUz2haZCH9IqB4EHXFJTmecyOdMpkvr7hRQqeswKqi5CxwrtW
	/fIaFPG5tKGId4QqNkzbGQYXg6PPJurc74EHQrWaYW98h4xbcf+t+VNh7RRftUn26LU5aUGx+zo
	djH/4aA==
X-Received: from pfbcz12.prod.google.com ([2002:aa7:930c:0:b0:82f:7163:35c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:188b:b0:83d:b11f:7979
 with SMTP id d2e1a72fcca58-84282f79dabmr465714b3a.29.1780420162424; Tue, 02
 Jun 2026 10:09:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  2 Jun 2026 10:09:18 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602170921.1304394-1-seanjc@google.com>
Subject: [PATCH v4 0/3] KVM: guest_memfd: Fix signed offset+size goof
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Michael Roth <michael.roth@amd.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a bug where KVM fails to reject a comically large offset into guest_memfd
if offset+size results in a signed, negative value.  Add a testcase to prove
the bug, and to serve as a regression test.

Note, v1 and v2 was part of larger series.

v4:
 - Collect tags. [Mike, Ackerley]
 - Use "INT64_MAX - page_size" instead of hardcoded literal. [Sashiko, Ackerley]

v3:
 - Use uoff_t, not u64. [the combined might of Sean and Ackerley]
 - Explaining exactly what is broken. [Ackerley]
 - Add a regression test.

v2: https://lore.kernel.org/all/20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com
v1: https://lore.kernel.org/r/20260522-fix-sev-gmem-post-populate-v1-0-9fc8d6437b65@google.com

Sean Christopherson (3):
  KVM: guest_memfd: Treat memslot binding offset+size as unsigned values
  KVM: selftests: Expand the guest_memfd test macros to allow passing
    the VM
  KVM: selftests: Add guest_memfd regression test signed offset+size bug

 .../testing/selftests/kvm/guest_memfd_test.c  | 24 +++++++++++++++++--
 virt/kvm/guest_memfd.c                        |  8 +++----
 virt/kvm/kvm_mm.h                             |  7 ++++--
 3 files changed, 31 insertions(+), 8 deletions(-)


base-commit: d1568b1332b6b3b36b222c2868fc102727c12a34
-- 
2.54.0.929.g9b7fa37559-goog

