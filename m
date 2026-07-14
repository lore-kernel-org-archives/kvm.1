Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BA42BEA9
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057375; cv=none; b=AeoWCZodDPAu1NzpRzuOdFiNjhv/xS3/+MVqlM9iIfuKhfDyIqzkDaTC+P69NH1XZyFhihlUmZXqL0LjyhW35Pa1c5ZgtgEn8eunX5KptMhw4sYYPUY3vpOyJjc9XQ/5iCk9ZrGtArYMYoUAfuZml0V4gF7EpBXdrUy5y1rykvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057375; c=relaxed/simple;
	bh=5v0pjtg16nOYoh0LqjejD+BH5n9SM/7iCdtqM2SxC9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CIfg13zo2969Q8GlNQgzOzmhH89MlZLy/bpLZhhGzRITSgbDMGq88TZZQzPJrtd1hprE9gGh7v6Dv2YK49q8z23eGhQ8HF6BESrQbscjDAlJ/aaXqEzBfxRl8mcDXEjbAICFgAQUTBMfRurzNxglzRGsTIBSAPnsuf7/Qg4S5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlTDSMGe; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlTDSMGe"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84865f326efso5128737b3a.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784057373; x=1784662173; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NaWAefms5g2sZE1zJRpUsheJBiizyXeD+J/SLEPa9K8=;
        b=IlTDSMGe9vScsqElhWXO8w4mRHJ/2O5URvu2scmA8SCNn98pTofBe8KdnzVk2vYQ64
         cfpXijlLwmLgszKZZzs1acdTZRo10cwxtkjlUouTnT7AooCZ2myGxjHNGVGfLUNrLt/q
         MQL1vqJ5E3i8X8PqB++dtkNWX6yNo8pEfiHnG34AXkQ0bxobPxeNR4tiHS4xr4eb0uBp
         fGZPDSYxZBsIRDJ7lgVQDFBL2VpPTq+rv2N9ltzmkYzHOp4jF3+Y7EZFgwamrSHx35F5
         2Pm33BSTuD1nJA9MBoXaHwPDHo0xwZSlxHD2nebXC7Qk3xt2kTn4WHjXHhSIZR5OWhEs
         Tjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057373; x=1784662173;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NaWAefms5g2sZE1zJRpUsheJBiizyXeD+J/SLEPa9K8=;
        b=idN9E8dQ7TuC79J6qQxAAg6gy0OejwphBlSKyWWQ6kRJD+6mrd9aWtt2fdXbeSlg5Z
         FA4Qb22pcO1Lw+lCUmjc5UHpQn0/KRuogGEKfLFXWSdbxnmmPNrI8sR2SNQmg/GutcXj
         OswcevdZ3LMadj+4Fw+TngHTn0L6vaP4RrW0i+Uh5P4plNYk2lwLlc9eaiNss45jV/jP
         gVfh6f5SLi3TZdClwYj/z2DE8SGqWaQmmGYC+tP+YMuHi0gZhYHbZ47h92vqDpO6sySq
         FiH3sRosQtY6d5KywLCwmqsvB3GnZkdS72OOwnD/ddqm+XQfIKl7QXZ/DhohzI3QUVAk
         A/YA==
X-Forwarded-Encrypted: i=1; AHgh+RpO9jjvga04DfcKLSZmtF4uea/4h7usa9rhm9vMfW4njy9AxM4PWMU0GqY0Xsk61QVtoHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxcWIw47lLsZUwrrK1nXlfcoLBMQHu0rRKSWrxJfI2p8tZUAOj
	QIHdxdlvFz2EwGCbesKOkYLxSCUHwC7yFsusdqkHdRflcwb6Xouf4rlCREsmje41m3Ry/plsepw
	rLtOMvQ==
X-Received: from pfee10.prod.google.com ([2002:a05:6a00:bc8a:b0:847:8fa5:76bc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14cd:b0:847:83bd:6671
 with SMTP id d2e1a72fcca58-84889667647mr13185570b3a.19.1784057372703; Tue, 14
 Jul 2026 12:29:32 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:25 -0700
In-Reply-To: <20260630213711.479692-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630213711.479692-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405433333.3142919.4680610079893572404.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: x86: gmem populate fix and cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 30 Jun 2026 14:37:09 -0700, Sean Christopherson wrote:
> Fix a user-triggerable WARN due to KVM not pre-checking that userspace
> provided a source page for non-ZERO pages for SNP_LAUNCH_UPDATE, and then
> clean up the equivalent TDX code to also explicitly check the incoming
> source page *before* calling into guest_memfd, and to return -EINVAL, not
> -EOPNOTSUPP.
> 
> v2:
>  - Rewrite the SNP patch changelog.
>  - Tweak the code to avoid checking KVM_SEV_SNP_PAGE_TYPE_ZERO twice.
>  - Drop what is now effectively a sanity check in sev_gmem_post_populate(),
>    so that we don't have to duplicate the logic when in-place conversion comes
>    along.
>  - Tack on the TDX change.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/2] KVM: SEV: Explicitly disallow NULL user address for SNP_LAUNCH_UPDATE
      https://github.com/kvm-x86/linux/commit/2abe1ff20151
[2/2] KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL INIT_MEM_REGION source
      https://github.com/kvm-x86/linux/commit/eb606a243863

--
https://github.com/kvm-x86/linux/tree/next
