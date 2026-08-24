Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C04F37EFE4
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593779; cv=none; b=SUXA2WxM7s9I4FLyiRuWhNfIIlgjzhDo6GmBmHwDxP/Fu7VeyBZ/qc6IAOG4As4riDEq8iCv+dK+Qwz4bCAG6zqkzKu331kINVqhuv0XHk6PVdg9x2mat81MwYxL0tqe0WHoR1GgWq1l5leEjUjKWvykuW0KxZ3jYwanU8W89FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593779; c=relaxed/simple;
	bh=PPDJlqSUvHay03xyBP07YiG5iuuiA6STLjyjRlcztdc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=asU5DSBGPcy+0ZO+JQNluxtjmWAaTxBuUcIp/6r8conYsw7r1Lb+iqDX1hFigdolZmAXdEEBnd61GQ+WJZa/KNr8iv6lrz2jrudlU0EuVOA+Vasj1uzzJMvYHmnDzzQpQFkPg4298LBSMxHGm0tNYQaL3u9G7IWSpYPY/srUgIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ouJioJJG; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ouJioJJG"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d55d8cd938so70138465ad.1
        for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787593778; x=1788198578; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Z/z5YUBWrEARW+uT0SGoD2jo4BnRQlBc+8qnsY9bew=;
        b=ouJioJJGE+dbzq5MtpkOCN6ycveqW9/ropQpCz4Zi3IlFR5aHpvSoHMocOqs8w2+g0
         cPH1gX5/zqBBBjBzhj5RID/mk1Qtpo9Jt0eEEYJKksgUrttrEr/04fay2Zo2FD/6RScG
         IWgTiOcEANzztypKp1ivH4T7rNX0SYilohno9FJdWRJPoNMdtxJxLZ4jydLJwdKcFVe+
         1+VSW6U3WWrW6a9S6YguRQYOJcXzAQojjzavRqhLX6mBNh1WmQdox1DxUTWdruykoRKT
         YF3Azpe7Cd9NqqM3VfTou6moDVtgdErIAKII8wl61JF/bNO7kE29DuyulCCvf6tVQj35
         rorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787593778; x=1788198578;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Z/z5YUBWrEARW+uT0SGoD2jo4BnRQlBc+8qnsY9bew=;
        b=BAV7ICc4x3PIXtO38nThMb5twJrdXFlGZ6vU+f4+20SsfOXZzI/PDEotGr8g0FpDvo
         4OeOv1Nsk1GqgRGUAg52Pe5L+uwyxKIWiMP+dPc6+b3XYWBg0kDzWd5qL/hJymCvddxx
         dGdur5XJGNLTKmq0stKLwiKnnM5+rR9dxCM6gVgup8NbUEebeFKGrELryn57DNlzLiA7
         EBdxRwM9S5nbT+V6ZCpQOFNLTW8XZWql46cN6sPeIX1LaEcOsl6OIghsf6hbhQdqczRp
         yrTo4y/4Kuz92/QqauABnULp5V+5+0KJD/GqsKZneuOkAyH1xffVHxPN1fTbicL0MbY5
         XmlA==
X-Forwarded-Encrypted: i=1; AHgh+RrAtKQDxfTaoI4H5v6kGiGy3OvEy8v7OSlrYoJLZwEMnQy0n0xN0KouDsxVJ4aB7JR66ZY=@vger.kernel.org
X-Gm-Message-State: AFuF++lYtfeDZg8R+B2PS2SaFsef9qnmW3QIpsEvY/pbiafXqA85c/Wb
	y2QXO0BNSXPfJ58nmpGhYlBus6PDjAHBn2ml8eOcyBi25J63z1EMxvnIfXFPuJh5gZtdAEOuYZN
	/2j9D0Q==
X-Received: from plbjf12.prod.google.com ([2002:a17:903:268c:b0:2ce:9b92:ec60])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3888:b0:2d0:cc92:f7c2
 with SMTP id d9443c01a7336-2d670b4cdc9mr375142645ad.1.1787593777427; Mon, 24
 Aug 2026 10:49:37 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:49:36 -0700
In-Reply-To: <20260822190224.3788887-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260822190224.3788887-1-nicoyip.dev@gmail.com>
Message-ID: <aoyEMBz-SYLigbGp@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Protect noncoherent DMA zaps with SRCU
From: Sean Christopherson <seanjc@google.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Yan Zhao <yan.y.zhao@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, Aug 23, 2026, Chengfeng Ye wrote:
> Fixes: 362ff6dca541 ("KVM: x86/mmu: Zap KVM TDP when noncoherent DMA assignment starts/stops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  arch/x86/kvm/x86.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 69469bbdc84a..2114553f3159 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -14092,8 +14092,12 @@ static void kvm_noncoherent_dma_assignment_start_or_stop(struct kvm *kvm)
>  	 *
>  	 * If KVM always honors guest PAT, however, there is nothing to do.
>  	 */
> -	if (kvm_check_has_quirk(kvm, KVM_X86_QUIRK_IGNORE_GUEST_PAT))
> +	if (kvm_check_has_quirk(kvm, KVM_X86_QUIRK_IGNORE_GUEST_PAT)) {
> +		int idx = srcu_read_lock(&kvm->srcu);

Please do:

		guard(srcu)(&kvm->srcu);

even though this is tagged for stable.

Alternatively, what if we have kvm_zap_gfn_range() acquire SRCU?  Nesting "locks"
is a-ok, and two of the three users of kvm_zap_gfn_range() have had this bug (see
commit 074c00800719 ("KVM: x86: Use SRCU to protect zap in
__kvm_set_or_clear_apicv_inhibit()").

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6c13da942bfc..34e9eebb38af 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7072,6 +7072,8 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 	if (WARN_ON_ONCE(gfn_end <= gfn_start))
 		return;
 
+	guard(srcu)(&kvm->srcu);
+
 	write_lock(&kvm->mmu_lock);
 
 	kvm_mmu_invalidate_start(kvm);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0626e835e9eb..9ecbaea69677 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7875,10 +7875,8 @@ void __kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
 		kvm->arch.apicv_inhibit_reasons = new;
 		if (new) {
 			unsigned long gfn = gpa_to_gfn(APIC_DEFAULT_PHYS_BASE);
-			int idx = srcu_read_lock(&kvm->srcu);
 
 			kvm_zap_gfn_range(kvm, gfn, gfn+1);
-			srcu_read_unlock(&kvm->srcu, idx);
 		}
 	} else {
 		kvm->arch.apicv_inhibit_reasons = new;


> +
>  		kvm_zap_gfn_range(kvm, gpa_to_gfn(0), gpa_to_gfn(~0ULL));
> +		srcu_read_unlock(&kvm->srcu, idx);
> +	}
>  }
>  
>  void kvm_arch_register_noncoherent_dma(struct kvm *kvm)
> -- 
> 2.43.0
