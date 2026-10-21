Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548942;
	b=4J9l3lMWJlLViRU5W2k5SqzyDy4H2JMRV3Arlg4+3yiWhcBeL8sb9hczUJmyjoVMWmtD
	 0izxrFHP2cuheEycrhZEQAePtUS01LjxsCIA/KdHZl9JAT2H3PnkJ+lbiU4iTJ+rO5/9w
	 JlMLZTevt79M8GRt6FtLAEDSayT7zwQm6IOYvLJWLNk866VdEas88+0P0EL0iNeMQGrDA
	 OP8CDAp30nTJzGmHKgUo6ZHi7W0pbM7sjebBRueMvKtp72ys+rBGvcFg89Hf9+p9AK/U7
	 jm8k/Gx22K5wztOluFQLvlA/2DelinFDb0w6gpD+6D4Ddkgtc55LcoSS2Gwj1NwYtEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Content-Type;
	bh=3QqxkdGBMdHAyyER16pFtqlovnizPsQ4fu1kq3Zl4x8=;
	b=t8GzED7IPdCY0CL2H5tSNppAdMqIYq3xPJ5nfMGJKICBLiLhAVgAKKEELkotnreqJDTa
	 wegW7OMTXiZXir64FLmC+9hQRFHy7+8gFW1U92hSF8eo0b4KbCGT2RP9ICgRyEPfNjWMl
	 FH5Ti3Ty0YbVzhoRz9p+xJHiZsmSB+hP8ojR0oPorOFJVir68uNJMpMivJpNMpQQ3gha0
	 XGfW2oDSm6O8/Mf35u+k/Fzr+BqXHZt9BpHYECVpeFXaUtIKtBv2xi7I72g1VSs8fySDC
	 4zQTcqTTGYUuuq+mBDeHdFKXqItHAXOz1eLAnq2l316MrJ5MrLxI4UTzdLs6aL98EmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Az5L5EaJ;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336E6606A31A
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 02:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 336E6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Az5L5EaJ
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd65285537aso60904a12.1
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 19:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792548941; x=1793153741; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QqxkdGBMdHAyyER16pFtqlovnizPsQ4fu1kq3Zl4x8=;
        b=Az5L5EaJiyenvi16QLKUs79KsurZAbsB2puKZ/p1h2m/38WBlx7FeywhxS6wo1N4nm
         TkqpwYXOem3nzW4hnew1NQsS3hze49rRO/HaPxhmMMFXAN44dsKwLhzLwm6zGq/oXXWK
         8AexqGakIxWX2c16gvpXKc7iOP+DZlFhLtFWxdXiHIUxeaKN0TC9eMF9cBDElASCVjKo
         CnjWQojeTOryy+/Cp+iOTOOoAxPue0Q2B1yeAGOHHGshqdGW+eyva5fVoKw1Cd4tz8qe
         iCmZVJfxVyDEdUUi5MeFtaAsYWSSb3CM4G0VwzFfwNsaiijsSk1wmloVdz9ID7CjS4DN
         yG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792548941; x=1793153741;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3QqxkdGBMdHAyyER16pFtqlovnizPsQ4fu1kq3Zl4x8=;
        b=VsSQ+FK1+5SzxyNn0WjI/AbI9YrPnpmpN0Ky4ytEOvuup3GeOrs59a0Mybu53Bb5V1
         56S0cunsq0+TZNtQX/+CX0mH0hulbgkFAPJvMSUpuiswqm2lRGfhQEV8SpIedoAf7G4F
         Yp5XAbFtj7V4kujCmi3rQDoLw4L9GwwULnmt3pf4q+erUb3z2BvGBHTCIN8PH+eod94l
         2BEGLqGDhRSK9yjcNAB/6wXVJz86UIS9Xl10g/euCEoE4unAc+MlLOljYgID8yWnINQn
         TwRdoyEicO1f847GrpHV1tfydb0oDZYtwJP7Lz6PWryPTVO5gLEmbyFC3KJUcNsEM0rC
         oXSg==
X-Forwarded-Encrypted: i=1; AKwUvBy9t9pKQOBeyCI4FMcmOwqSiajtX1AVcRmjb1Y8HTQlDRsERSz1cnReCoOLt/6TsQBIQMA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjspD+vx4qZN3tuCLUorAZ+G9LJ48V8R49tEt5bjBP7AUqWMh9
	Yy6O+XHKbs5DLXghVJ+vZXxKophhtXYGdWhri1Wfu81b6Piuv0zMbpnwxUT5BgPorWkv+U49xeb
	acASfLw==
X-Received: from plblv13.prod.google.com ([2002:a17:903:2a8d:b0:2e8:4252:d40c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e54e:b0:2e9:5d1f:dffe
 with SMTP id d9443c01a7336-2ea43c2ee00mr6182505ad.57.1792548941055; Tue, 20
 Oct 2026 19:15:41 -0700 (PDT)
Date: Tue, 20 Oct 2026 19:15:40 -0700
In-Reply-To: <20261021021221.1703700-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021021221.1703700-1-seanjc@google.com>
Message-ID: <atggTIqJ9bHI5vIk@google.com>
Subject: Re: [PATCH 6.18.y] KVM: x86/mmu: Preserve nested TDP shadow page
 tables if they are used as roots
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 20, 2026, Sean Christopherson wrote:
> From: Hyunwoo Kim <imv4bel@gmail.com>

Gah, I'm rusty sending patches to stable@.  This should have:

[ Upstream commit 7a2c70e777a00c32ebafd376a6fe31ebb91c5b20 ]

I'll spam a v2 right away so that I don't forget...

> kvm_mmu_zap_oldest_mmu_pages() excludes a shadow page whose root_count
> is non-zero from top-level reclaim, because such a page cannot be
> freed. The path in mmu_page_zap_pte() that recursively zaps a parentless
> nested TDP child has no such check. As a result, a shadow page can
> be zapped even if the page itself can't be freed; as the comment in
> kvm_mmu_zap_oldest_mmu_pages() notes, zapping it will just force vCPUs
> to rebuild the page.
> 
> As in top-level reclaim, do not recursively prepare zapping of a
> nested TDP child whose root_count is non-zero.
> 
> Fixes: 2de4085cccea ("KVM: x86/MMU: Recursively zap nested TDP SPs when zapping last/only parent")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 205d314a7583..1fa251ca4dcc 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2630,6 +2630,7 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
>  			 */
>  			if (tdp_enabled && invalid_list &&
>  			    child->role.guest_mode &&
> +			    !child->root_count &&
>  			    !atomic_long_read(&child->parent_ptes.val))
>  				return kvm_mmu_prepare_zap_page(kvm, child,
>  								invalid_list);
> 
> base-commit: 2ff600d29ee478d0a8d46ef8a58afb5e038fe692
> -- 
> 2.56.0.218.g1ec904b173-goog
