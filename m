Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9071F4F85DA
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026061; cv=none; b=O/XhsvXV+TgI5O9+5+yJbmhMPWOdltqczBgRdLFR0SjvdgpKzdS3SoQw996wOdhVGy/qVpjxtLUk6bUlWIXO3ejIXtOTppa6QplBRW6z9+XJuKqlZ51WzxuRFHoSv/80OAEOCj9To90Olk+6NPq0ymMit84jveuvXpAhvLgKr/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026061; c=relaxed/simple;
	bh=fo8XdEe5FSjrfsUHQCe4iJ/9r57GZB37hHQK3O7IOQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UPam3RVP/kWJj4yY2PIS8o/QwHyMin8BCdVUxl31M6/HAihS2ajdxoMKaqWXUOb1mKdTyXneYsbqGbxSD6xSFqB1QhcTp6TyKW16WiFl20LR+Oj26UKh2V28CL3VLW+ZDe6XC1KxTYNmphFAGnpODdrrOIYsW8t7NOkCSsdajXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DwZ4pTbT; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwZ4pTbT"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d7443e0f0bso64183345ad.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790026060; x=1790630860; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=imbcA+h5CSacGkPDqFjCLKSXoDxa8F5RkkDF7GogBlU=;
        b=DwZ4pTbTkwqk2YZw2boNEan8wHMAvyoWPT6saBrUKhOgHB0HCFfq/lA9Sk+DbuIGEm
         2v4+E/WKdLQfO8B+VCV6WxOhlfbMCDXARkqwdLVLAsN80bGO6VoffR7gJQHdAbQkm0Cc
         HnsHofJ7mDsSfrkU/ncpblbkw6rCv0iVnlNa0J0JikkMKG2a+gms06OQ6DPXpwNqg5Yj
         T9CXA76XIoXxjTv13EQuQLTOnBnEyyY0m3aZTewtv7EQXfPHUxBFVfzGvLALlAytkjPc
         Dl7gTYpphxZ0FON36ZDSMDlCkmKcxhnIR0etEx8rGrQx/l7h7fK0ZAtsMUXte5uFsakk
         J/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026060; x=1790630860;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=imbcA+h5CSacGkPDqFjCLKSXoDxa8F5RkkDF7GogBlU=;
        b=H0JwFqKFtnJGJl3x11SNOfg9J4EyDiql3vOzlKr6WOntJU+k8Kj3e4lYdoLbWCOMgV
         /vsLLDUF1XKnkzGYaX5Oyep+CsTkrXhX6GKL/fFcT26mMGgG3UqRjREiQpkg858udV6n
         gS/dzRrnT775smYY6EY102imGt2uME6uzcrKNbAiNvDkGqCyFrCN/0e6B30vZmLp4OOh
         CwBc2sj2SAf32gQXII306/bxKdOFvmK75P6oBD0ksfUOk4i9WSaRYR1ogqAcYDNm/m3v
         4KFmc/DcurC7R4kl+EjYXHaUvMLKN3CYejSs/xSxruMCN7nsW7wir5ahglUqyDeHtme2
         406w==
X-Gm-Message-State: AFuF++mlpjKwRTIOlz0p82Ajf3qOXWpoKhsS7xGykdd0P0NHRyUrRszL
	IM9xE1E2uz+8z2+RUoaayU3y97HGKAErd+B7gQzzVhn+EgdHuBnYVPrG9YSHxbWuzt8slDlGLgb
	UsIdNJA==
X-Received: from pldu3.prod.google.com ([2002:a17:903:1083:b0:2dd:7e95:7c98])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c947:b0:2dd:ad73:c93a
 with SMTP id d9443c01a7336-2ddb1bca6e2mr171876505ad.27.1790026059668; Mon, 21
 Sep 2026 14:27:39 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:27:38 -0700
In-Reply-To: <20260921211941.5E8A91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921210616.1024168-1-seanjc@google.com> <20260921210616.1024168-5-seanjc@google.com>
 <20260921211941.5E8A91F000FF@smtp.kernel.org>
Message-ID: <arGhSlb-q8RkDiCO@google.com>
Subject: Re: [PATCH v4 4/5] KVM: guest_memfd: Establish memslot<=>guest_memfd
 bindings *after* memslot is ready
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 21, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> [ ... ]
> > @@ -1944,6 +1945,15 @@ static int kvm_set_memslot(struct kvm *kvm,
> >  	r = kvm_prepare_memory_region(kvm, old, new, change);
> >  	if (r)
> >  		goto err;
> >  
> > +	if (change == KVM_MR_CREATE && (new->flags & KVM_MEM_GUEST_MEMFD)) {
> > +		r = kvm_gmem_bind(kvm, new, gmem_fd, gmem_offset);
> 
> [Severity: High]
> Does this new initialization order break guest_memfd creation on arm64?
> 
> By moving the kvm_gmem_bind() call to execute after kvm_prepare_memory_region(),
> the KVM_MEMSLOT_GMEM_ONLY flag is not populated in time for the architecture
> specific hooks.
> 
> In virt/kvm/guest_memfd.c:kvm_gmem_bind(), the flag is assigned:
> 
>     if (kvm_gmem_supports_mmap(inode))
>         slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
> 
> Because kvm_prepare_memory_region() now runs before this assignment, the
> architecture hook in arch/arm64/kvm/mmu.c:kvm_arch_prepare_memory_region()
> evaluates the flag before it is set:
> 
>     if (kvm_slot_has_gmem(new) && !kvm_memslot_is_gmem_only(new))
>         return -EINVAL;

Argh, all that time spent trying to avoid adding a "prepare" phase to gmem, only
for it to be all for naught.
