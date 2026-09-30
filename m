Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DC81ACD
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727091; cv=none; b=GhxmC6bjzWzgfVkv+BDDgvFHYor6Yv8/GzifdpQ9eNEPDTTcgun9fdbPSIumgAlqawYFb4TdrVjYGEoYIbhHSiKc4on2xVNZWVQkZ9HG/OEyGHL9PhMKUWXVyqO/kn+vHPCv9izoUX28C7cdh/7IvDfCw5Klk1AFbk0son4Lw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727091; c=relaxed/simple;
	bh=sKu78DjCAmODtHCgPAWQiNR4dngtKwV0Ou54EIH4260=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=coo56vyrNkQrXp5hytWyJIYqGEW3dXoPTnDj2igsKinj4Io+fxu1ZTDY/V5wDZTiOmNfR0DTX8tRIJdn3Ng1ho56CYRvs0TrIhisQq08+KHQW/HAP1oteQ1CvBpTwdTl4Hrt0qI6nNAJXyg1eGTUjE6KDu7CyAAGNFbopLeapyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mpo2smH2; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mpo2smH2"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so4455074a91.1
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 17:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790727089; x=1791331889; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/6ZGHDCmf5a7XSgxL4bcU9VK02Sk8HaCmnaTNrb7Zr0=;
        b=Mpo2smH2eBR+RKrkmjryF26I+Ya/CeLeWh+IcTefKn8uO8raV0jo5msZdpBkhuaaUr
         +jMGpj5ZuVU5ixI9sIz7/OCi62wVV92DKwSI7H4DI2a7BOuyNxpdfjwMuUYhD9J6R6E7
         IYQpn5N8nA5rDAVA93VO5qXve+CdO0UBjEEdZj971x4QZDOIiJQndPeG+OiXvmw/NdUf
         sfcclGBD/jaGBwHLmdsXzBi4Bmdq/58Q6Xy/8lXAx1ZlPi+mAKl4qy9M0H2VujpNS33r
         NT6SDBDdwBYBw4L6HhsCIajA9Cn7eJ2qXXM187Gjk/Ukxx9AiKaHf7WZanLMEZNZRo8E
         v1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790727089; x=1791331889;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/6ZGHDCmf5a7XSgxL4bcU9VK02Sk8HaCmnaTNrb7Zr0=;
        b=Zbe+m661VgGpsPXHgCeNSs4nACsCWshAQRVFXV1DaATK/eCQTx0JwbfgykVPXutqOg
         KtxjjmKkDbgndwkOuoNhDbdiqc4brjnIe7DbevOzNBYyvj1zv+uSjR2en8VaoArEMLqc
         lvcSl7cotIPFvDKsYd+1b2IqayIBNGuYqXTUReybTv4UqBGjLR9of8HKD0EeR1Gpt6yp
         ZgiO7jna/KZKq6UWGAk+71uxl1mwsHS48ZOv89xzp68MRLs38Nf7sZs+qvbB7jdXDalO
         axnzsS98cxDAMNDbMTCh5fosZYmw+Y1MUbXsuNWjLRmADyXHNziUzmQlkfQ0lcfi0JEa
         0eRg==
X-Forwarded-Encrypted: i=1; AKwUvBzAfgV/RZrM0AP18PzZG8C29c5UyUw+GnhXkFjk7cCvdzn3URHIF8uKV2r+sy1HgvM7Dv0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpfWrhu78C5oW0m3kkJMzHP0vyobwn+4JRqsf+Oc7b5Tuel0Ht
	FYYxltBWHUvMsXYRq92+yyztvTqb1mhxP1H5O53Lm7n6Vh/Yg0ruOHyNp4I1Kh0c0+1ApLqQwJH
	xNsmOPA==
X-Received: from pgbaz14.prod.google.com ([2002:a05:6a02:4e:b0:cc7:d698:697e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7cf:b0:39e:6795:f7da
 with SMTP id 98e67ed59e1d1-3a4bfdd4f20mr819262a91.19.1790727088949; Tue, 29
 Sep 2026 17:11:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 17:11:24 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930001127.3170009-1-seanjc@google.com>
Subject: [PATCH v2 0/3] KVM: TDX: Syntehsize SHUTDOWN on unhandled EPT Violation
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

Signal SHUTDOWN instead of -EIO if the guest accesses an unaccepted page and
has disabled EPT Violation #VEs on such accesses.  Returning -EIO is all but
guaranteed to mislead the VMM into thinking KVM (or the VMM) messed up, and
will likely result in the VM being terminated instead of rebooted.

v2: 
 - Return SHUTDOWN directly, via a new helper. [Rick]
 - Ratelimit the error message. [Sashiko, (and past me, amusingly)]

v1: https://lore.kernel.org/all/20260923163315.1580860-1-seanjc@google.com

Sean Christopherson (3):
  KVM: x86: Add a helper to prepare vcpu->run for a SHUTDOWN exit to
    userspace
  KVM: TDX: Synthesize SHUTDOWN instead of returning -EIO on unhandled
    EPT violation
  KVM: TDX: Ratelimit the "EPT Violation on pending acceptance page"
    warning

 arch/x86/kvm/svm/svm.c   |  3 +--
 arch/x86/kvm/vmx/tdx.c   | 11 +++++------
 arch/x86/kvm/vmx/vmx.c   |  3 +--
 arch/x86/kvm/x86.c       |  3 +--
 include/linux/kvm_host.h |  8 ++++++++
 5 files changed, 16 insertions(+), 12 deletions(-)


base-commit: a0bc8e1d7a82bb143b8f8f44ae3a01938f37c2ea
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

