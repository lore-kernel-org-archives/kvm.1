Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB43B47E3
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940517; cv=pass; b=ZOEJIqvgUb6LOUuZ7ATJpdoHxKz8CrjJI7VLn9BATrr2s7DiKAK9QECVKhQ7kvxqEuLh6qCgeQjK7GLBzCtWvAvLCvgfh/DfiRrCqkF6wL/g0l4F9aMM7R2zFU/ir1t/1QDrbXy3cxIl0jwvnohU/W2L3s6v7l9yulVM39Qt39s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940517; c=relaxed/simple;
	bh=CkwVfY1nmZ3D1jFCA3niLHpZ2cVyZBfyXndQ5/TEkzI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxxuECshvDMQkYsJ3S0thUoPsnKpjM6/qqI2NPIBBbwVwBU+g+WpEbzilx4hOO5kRyZ0xqfzpyiC0ULC74lM6mNh4ya4K5uzFlTXEcb81gq/q192PH1Pb0VHroGBxStQPm9NMOocnTZ4Og9wAommo4qF+TiriprleXURpsCVQwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a1Y7I98T; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a1Y7I98T"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c9878bbe88so10724935ad.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 14:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782940515; cv=none;
        d=google.com; s=arc-20260327;
        b=kSHHKWu4Q/8qRsFb7ijrZ00tGhSVgOLEJ6MgXDG8yQqsUvTtCcJblOtdowxZnY8FNJ
         bLyCrxa91qrAOWEG3ysS7EeU/Otl5q5VXoe+R6iu9FWjhwCKPdx9QFQCriMLlCLzWp7I
         YLUJKFx2+7jSuYLtAJSupIwr0FBgOR9kwJwJfqRuI9B210ME28Zoq3YbNqMTKBlL8GXq
         DJn1yQ/1V7jUnpZ1+BlBepoCpsmIPEDd9O11AeOF3RqxAnpW+zIw2xGvquZ7RuxiC5no
         gVPar8g7WddIQ5T2BhE4zDI1VXGj6yoNmcncyesrMJORayxGZRr0yhqoSEQdrc+7Ql8H
         leGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=hdj0HDgY6Dfd9B3CG41MszDY29ma1ezvlMosUMSNXGo=;
        fh=vZhqcWQo83ssX6+1PfqiT7UtjKE+WlRaE+l+3EK3eZc=;
        b=IqrCCsli5bokZVo6N84ZWvgFS/RKD7YOdV318/ujH4ufkCm2o221kjrH2abbXVAY7h
         7fZVlXnkk786c2H6yW0xm+z+0Updml5HwGlCBNltl7patVdyoSECZZL2F9Ypp7eO1xw5
         ZAJcAtzaA8QaAIbeCWPTF7YPFB9tA61r0ELyaylq5Ukjda4QFNBBZlqOMutEx8ss0ffA
         lajpdHINg/eNadngnu4bxptAE1g8XqgdlRU4+h9wayGSJCwSxhbZb/QC2HlH8ObOvQkc
         VsksHWJjGcYq1cjW8QFxhgkfZjNLSkPQNQzo1RKTsimGUhUtfiBQqWziZYTUWQ1RsnuI
         kgOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782940515; x=1783545315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hdj0HDgY6Dfd9B3CG41MszDY29ma1ezvlMosUMSNXGo=;
        b=a1Y7I98TNmQA8O/yqkNfry3o7hfOTPAMLWDNSFWkrDZw/QnDvPLNXhjQ3ntIvJOnjm
         /YTf5ma8Xrkl/UzFdTQC++pyR8nK11LvGx1tWWUFYaXHwvQ35TuSjb6cJ2b8uWuqWlCo
         QIj1SGR2C/ToGJl9JXdA2stXp8nCrI1hRzYBS+yNfdsHf6LH++lLypdllUv2p9f66gRY
         KUoKNdygGM1MGGEVj6YkVASuEVTGtuhPfjwbv/HchMrOg/8Xd40gi4shgqAj50V1przZ
         VsnPA7aeaZe201207W5PXzdm01xhDX1MJCNH7P1hYwOmw++e7AliYTEGgT6H65NsZ4zU
         6TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782940515; x=1783545315;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdj0HDgY6Dfd9B3CG41MszDY29ma1ezvlMosUMSNXGo=;
        b=ocoESQ8UqKQpTOaPuhmM6GsnvpOzJM9TRnSgkv5e3UNW8veAyQGVV1hrDxOqoXN/GS
         2/HGehQiva2HthXQr6lKcP4wOATJc2/4j5CfX3B+6OyzjYROwQSLTa9hsqUwph8vT+gK
         E9rXkrxAiFGTvSBpJe4/q/lziT8WJExIea6EtRvk0oQYl8OitmcTq0bAsEDmkLK1gsZd
         h6AUJGUrHiZuFYJ6zrHr8maXJYEL2xllmZrgV1YoAXTAslsuuH+VPHBys6lCMdrJAe3m
         Ql2bX6vAkm8pO1k8y2xlXL21lnWK4qlEcHAPzUmBLbpQLoGbCGMXPHxIajYtIVZSATgi
         /Hiw==
X-Forwarded-Encrypted: i=1; AHgh+Rq+8Tbr//ci1tee1aVqJmG4AUXkexM3F5XX2dvwgMiq81aydmHYIqvRWt6VuaMBlZGm1PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg5cEUyLhlfzgff+a98Mx8+smAjjQhdmhWufFkj7enneFYDELB
	+D9HQ2eKtJFV3x9MbOY528rwPCU5TgyA+80YEXYeLQk9qM7VBrJBItIq5S64OavnEmf0nTc/4lt
	2K8jKbZZEPPpJBNFviDABi7r96/u2pIbjOHRanBsL
X-Gm-Gg: AfdE7clpTV7FM642g3cGmX/d0NlCzb0P/KQxsWuWIobWeb6RoVptaY/inJaN9V3pO+y
	lnTphJ4ITzEW7Q8fdZCCSES8ex3ThnLTAF5Wkc7XzG5IPcwyDqjTE+95DkTsyXlYiYhnl7iz0cx
	XNG25OFJfvt58ssBEqQHkbOf5RyJFMvxIvoza0zPOnA4KJZToj/AYm6pVhRTEub2mbZf8uUNEiH
	B21e+vr0GktjCP4M9WUhPWw8zCxRISqfEyLOWCswt5I4ViS/0+ExoC3AjevhwqKTfCQFHo9fim2
	aghyMQDa4G8GQl07fDxx47hpainm5kQAImrVSJpdQjPUYgl2v4IOT3BrO6A=
X-Received: by 2002:a17:903:fa3:b0:2c7:c385:c5a7 with SMTP id
 d9443c01a7336-2ca44a3c734mr65598715ad.26.1782940514709; Wed, 01 Jul 2026
 14:15:14 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 14:15:13 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 14:15:13 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260630213711.479692-2-seanjc@google.com>
References: <20260630213711.479692-1-seanjc@google.com> <20260630213711.479692-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 1 Jul 2026 14:15:13 -0700
X-Gm-Features: AVVi8CePIGZCD784dZYKnrRLqlsP0VAkKm3avleV_AoQHT__5sr4MRrtBRokfdg
Message-ID: <CAEvNRgEK+LH+M32LrxFSbN3Nf9sYtAVkr2c2vYq5FHzJmJqL7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: SEV: Explicitly disallow NULL user address
 for SNP_LAUNCH_UPDATE
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> From: Joerg Roedel <joerg.roedel@amd.com>
>
> Explicitly reject a NULL userspace virtual address for the source page of
> SNP_LAUNCH_UPDATE instead of relying on the post-populate callback to do
> the check, and don't WARN on failure, as the scenario is blatantly user-
> triggerable, as reported by Sashiko.  Waiting until post-populate to check
> the address "works", but makes it unnecessarily difficult to see that KVM's
> ABI is to disallow a NULL source page for non-ZERO pages.
>
> Note, several existing VMMs pass a valid userspace address for the ZERO
> case, i.e. KVM can't *require* the userspace address to be NULL for ZERO
> pages, at least not without breaking userspace.
>
> Fixes: dee5a47cc7a4 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_UPDATE command")
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260611125849.9ED631F00893@smtp.kernel.org
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/sev.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 74fb15551e83..621a2eaa58f2 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2330,9 +2330,6 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>  	int level;
>  	int ret;
>
> -	if (WARN_ON_ONCE(sev_populate_args->type != KVM_SEV_SNP_PAGE_TYPE_ZERO && !src_page))
> -		return -EINVAL;
> -
>  	ret = snp_lookup_rmpentry((u64)pfn, &assigned, &level);
>  	if (ret || assigned) {
>  		pr_debug("%s: Failed to ensure GFN 0x%llx RMP entry is initial shared state, ret: %d assigned: %d\n",
> @@ -2421,10 +2418,12 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  	     params.type != KVM_SEV_SNP_PAGE_TYPE_CPUID))
>  		return -EINVAL;
>
> -	src = params.type == KVM_SEV_SNP_PAGE_TYPE_ZERO ? NULL : u64_to_user_ptr(params.uaddr);
> -
> -	if (!PAGE_ALIGNED(src))
> +	if (params.type == KVM_SEV_SNP_PAGE_TYPE_ZERO)
> +		src = NULL;
> +	else if (!params.uaddr || !PAGE_ALIGNED(params.uaddr))
>  		return -EINVAL;
> +	else
> +		src = u64_to_user_ptr(params.uaddr);
>

I think separating validation from src assignment logic is better, like

    if (!PAGE_ALIGNED(params.uaddr))
	return -EINVAL;

    if (!params.uaddr && params.type != KVM_SEV_SNP_PAGE_TYPE_ZERO)
        return -EINVAL;

    src = params.type == KVM_SEV_SNP_PAGE_TYPE_ZERO ? NULL :
u64_to_user_ptr(params.uaddr);

This version is also slightly stricter, since it enforces that
params.uaddr is aligned even if params.type is ZERO. (unless the
intention is to really not care about uaddr and permit an unaligned
uaddr?)

And then with conversions I'll add

    if (!gmem_in_place_conversion &&
        !params.uaddr && params.type != KVM_SEV_SNP_PAGE_TYPE_ZERO)


Just a suggestion:

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>  	npages = params.len / PAGE_SIZE;
>
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
