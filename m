Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E88949DB80
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286868; cv=none; b=i3zo4c5K//ORMGOWVl1MIoFSnWtHZWL9gKOMrCT5JVcUsd3G1VB5M5fyqkt+gupiDCEkQYJSPGJN0R4hdLgAKhr0IVH1IL36rbG6JxfZQmudwVKOzju8B9ClVPmVe1jg5jDJX8v2vf2SoyNEmJP+g5Z0qRd3rFtXp5N78TYa7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286868; c=relaxed/simple;
	bh=K/LIHyiYa5gID+5jEsxZuhFyjO7rvUwqI7ZTaB8OIBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sYVaWH1p1rmN3IpKs09phzGgv9QF7Zw3f3qm5N878E99BuAusc+ft3Y4AHtzg4efZi+gidqegsOhQLl8f8Y+7uFY2MdKW9ctxVKJVNoP8er9CSOUQQld7NjOX1UuWc1x7vrEMxWWR45Or9D8dgwYy5v3Ihkx+giDFUUBN8bUp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rxQaQub3; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxQaQub3"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2dd53f2b27cso2254275ad.0
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790286867; x=1790891667; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SQ/usSA1tKKAOs+40+4Ubs2RZtDv59Vb7xFxUDV6QEU=;
        b=rxQaQub3iwMbsTXUwk6tRJ4UjpNa3yE3a6PzUgyee7tp5YCXyRR6LsUrOG0oE1Nlo+
         /0+GW0X81J/SD7aQXNcB47FTLO624XPfjvjVeibZFp1fINT6zI+DGgP3o+cTp5pd7kKF
         pr2ekLHTVfdNHe+Gsf5yWMUuD4R/s6nq5BmpRf31oare9QDL0vYO7PtRPpDN643NHB+d
         5TX+e+w81LBxciFxKoVZCj8gfk6CB58o7h0bxRyWvk+09XQV0tLwP2gyqt0TRf1NqgZe
         tDg1WhVMbffEVtSNn/Gkl83tCXQwMnzQJ7pRFzolk+VRnGjDSquku/Qo/GXRl4I0DOp1
         eHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286867; x=1790891667;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQ/usSA1tKKAOs+40+4Ubs2RZtDv59Vb7xFxUDV6QEU=;
        b=uZShnenksoIgz1DhtIyq6tjx5Cl/6FKQId3X2i77fs2dz02+k1Kdi7szfdFEiXhhAG
         CsnbkIGu6RZ9HgOaT1o06eGMa8VUNEsSePFbFH4v25i0pp86vZ0B+X4Ej8jqmZpQAn3b
         IuC9QN2NPvHX2pPQw2Y/dXT53ASUs112VGzEm2Na+BgBz+KV7OeuD82se+PoIBgqS6ms
         CKEd5+UavDSQaBElhxspLmitkiL2ivQGTMw67T4jEV44q4+0Y/MqcHNLfxlfOcrpxt0f
         h1D1HVvNWLBlpwSwbNN1WAD0P0oGr4T5fDJxJrs8xto0Qj4eV/BeatNCtzUh9fz4+0hX
         LBAw==
X-Gm-Message-State: AFuF++mNGPBUjoP6GhM0nVsevqoGzDm+5p5v/2t+EywWgPdzAVv7LlMm
	u1fpBjMN5XEcd1tlQ5cfh/lGP8tjHgsKeRF6dw1xj9/fWwSY6pGI3acOXYEVbKvtIsH1kRpHGOv
	TKuYY6w==
X-Received: from pgbfq21.prod.google.com ([2002:a05:6a02:2995:b0:c88:e5cb:265])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d07:b0:3dd:a195:dd57
 with SMTP id adf61e73a8af0-3de0e933c4fmr3612027637.57.1790286866556; Thu, 24
 Sep 2026 14:54:26 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:51:57 -0700
In-Reply-To: <20260901-gmem-unbind-fix-v2-1-12febe1d2216@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901-gmem-unbind-fix-v2-1-12febe1d2216@amd.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179028369935.2007941.14069102369239125063.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: guest_memfd: take the invalidate lock when
 unbinding a dying file
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Shivank Garg <shivankg@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, 01 Sep 2026 07:20:38 +0000, Shivank Garg wrote:
> kvm_gmem_unbind() takes mapping->invalidate_lock only if the
> get_file_active() succeeds. When the guest_memfd file is dying, its
> reference count is already zero so get_file_active fails and the binding
> is removed without holding the invalidate lock.
> 
> kvm_gmem_invalidate_{start,end}() checks f->bindings independently to
> decide whether to begin or end KVM MMU invalidation. So, the bindings
> must therefore remain stable between the two calls. Otherwise, unbind
> can remove a binding after start increments mmu_invalidate_in_progress,
> but before end finds the binding and decrements it.
> Example, unbind race with memory failure:
> 
> [...]

Applied to kvm-x86 coco, thanks!

[1/1] KVM: guest_memfd: take the invalidate lock when unbinding a dying file
      https://github.com/kvm-x86/linux/commit/0ee2c883b62d

--
https://github.com/kvm-x86/linux/tree/next
