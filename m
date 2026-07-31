Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0044379C4F
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528702; cv=none; b=kZZZIANPNHmOiVePqr20uTMpdOYUm2SAqgxRn0IdBw2rgMKLIk0tbdgF+XPzxJXT+bT08RhoqWHjecITusAFzxcTpPZ9VxluFWBpWQRIMJYV8FiL2JWyBLngWxi5E0nE7YDvUKy771FaBHQR2G5ZtT7oFFgMRa8/FT6kEKyP2cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528702; c=relaxed/simple;
	bh=+8SnJBBx/ztZWOEB0rX5OcIIHjP0Jk2UhjGoGXECl6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DFSEVAcg2/QTDk8ohmqm+7mMCAaerdDpCqNd0ALQFpMgFBpiRuO8TGQPo7rnmvi60gfsVcR5T05zwhsHZj4IYfLbkxAJwveJbqXgy7sOe14/dcjfTQzgx2D3wtYV/QjzF5eEzN2zlcGo6Bq10bwaBRwRA+AtdKv/xKL8yc1HomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBgPCoq4; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBgPCoq4"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso1582526b3a.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528700; x=1786133500; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PIIW3zze/gc7+/5TXWZ7ScLNciQfdvJlTxagUbQZKRQ=;
        b=SBgPCoq4uUpfsY1Phs1wtXH93eq/9icp5SdSefTYYUzEzcsJeqIhvXQB3q6h7BSCF/
         FPfNKgqNYvSm+jHrNGl4Lfv/prKZhFqbEggtx/KQScplLIEvWVK/vvonjQcy+x9WB8pt
         OUrftHiM6erBec+RwbQr2cH+haws89R+i55DUtaX5n7ch/sy5MQG2qgGtzNKEaZ3gmRq
         nQfRKtMUH29P8dbcWFXqbDg+1FUwveBwu+YQNIpg9isJcFfe89FO2gGEZWV/V5cUOcIQ
         TETP0+A0qeXczTqGSs/PeHZBiCQmG7dAuuZdamakmwNrI7q6r6IQ9bjUzOF4519NKMvy
         4s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528700; x=1786133500;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PIIW3zze/gc7+/5TXWZ7ScLNciQfdvJlTxagUbQZKRQ=;
        b=bKXJptLu4qjbaaUbe9TmDHOijx38kCbP04Z4TEg0Zf2XakNe+G5F7kqG4oKYPh2yKd
         H3I63fnTDfu4mU7kkIlnWyLQHiNViSgAuA3SIF81Ie5B/lar6dnwsACO+URp62jei/M2
         zzeDmcEkX1O+mQlex1m4uMcgQ41E4WY7hFS19WGeb0ZtmDZwO4WLEdkTliS4TIealRNV
         eHxwW0f8ks7PDDDxkQXuysZSKsfkUo29RVK4FuRwHVVWFB70VGmNJ4mm1a2nMB8qpu0I
         ikXQl4cr0BMJOpCUdINpSQ2h8tZr79QXOo/eAeu71NUl2hNNSfd9V7YTKNRqB4KkEgnG
         yobw==
X-Forwarded-Encrypted: i=1; AHgh+RpwwcVAClkcQVgd8B8niPlhHSuZJRwC5YP3lxMq1fmrXVzdzNwZ+b9bbwOCCZk6lfeVvrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6wNyoGq47HYdOuVjSTrrDW7ABi+gmWMdYyasGQhtBjJR3H2Y/
	ayyuvZu0YuXQREM8etGh5A50RsdWN0Rpk7mtkHKkI8nZUhm/B/Yv3QConCdBlK6jzyZgeVjaNgo
	lX/4ing==
X-Received: from pfbhj5.prod.google.com ([2002:a05:6a00:8705:b0:848:49f6:6f5c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:178d:b0:845:e9e8:6458
 with SMTP id d2e1a72fcca58-84ee47d50e3mr732442b3a.20.1785528699809; Fri, 31
 Jul 2026 13:11:39 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:10:09 -0700
In-Reply-To: <20260728174232.2423257-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728174232.2423257-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552796387.2700347.9476724036977525615.b4-ty@google.com>
Subject: Re: [PATCH v5 00/13] KVM: selftests: Stress save+restore and #PF (ft. nested)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 28 Jul 2026 17:42:19 +0000, Yosry Ahmed wrote:
> Add a stress test for save+restore while the guest is triggering and
> handling #PFs, in both L1 and L2. The goal was to create a generic
> selftest that would catch bugs like the one fixed by commit 5c247d08bc81
> ("KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12 on nested
> #VMEXIT"), instead of relying on high-level testing (e.g. building GCC
> in L2) to catch it.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[01/13] KVM: selftests: Use __stringify() instead of custom XSTR() macros
        https://github.com/kvm-x86/linux/commit/9be54a82656c
[02/13] KVM: selftests: Fix RAX and RFLAGS VMCB offsets when running L2
        https://github.com/kvm-x86/linux/commit/53f4ad49d76b
[03/13] KVM: selftests: Rework GPR registers switching for SVM (and fix offsets)
        https://github.com/kvm-x86/linux/commit/546455d9c724
[04/13] KVM: selftests: Handle rflags save/restore for SVM in guest_regs
        https://github.com/kvm-x86/linux/commit/9547309406d5
[05/13] KVM: selftests: Reuse GPR switching logic for nVMX
        https://github.com/kvm-x86/linux/commit/3d31fea7b6d1
[06/13] KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
        https://github.com/kvm-x86/linux/commit/2bdef77c6019
[07/13] KVM: selftests: Add a blank line before logging assertion failures
        https://github.com/kvm-x86/linux/commit/12f4d8b06a53
[08/13] KVM: selftests: Expose PTE masks to guests as part of an MMU
        https://github.com/kvm-x86/linux/commit/e21d4dc0ca63
[09/13] KVM: selftests: Do not intercept #PF by default in nVMX tests
        https://github.com/kvm-x86/linux/commit/7317f5b143aa
[10/13] KVM: selftests: Add basic stress test for save+restore and #PF handling
        https://github.com/kvm-x86/linux/commit/d24dde74f72f
[11/13] KVM: selftests: Trigger save+restore randomly in the #PF stress test
        https://github.com/kvm-x86/linux/commit/d99ad3c842f0
[12/13] KVM: selftests: Support running stress save+restore and #PF test in L2
        https://github.com/kvm-x86/linux/commit/1494b3d17c95
[13/13] KVM: selftests: Trigger L2->L1 exits stress save+restore and #PF test
        https://github.com/kvm-x86/linux/commit/583ad2052ddd

--
https://github.com/kvm-x86/linux/tree/next
