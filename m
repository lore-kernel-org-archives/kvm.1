Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828AA4BA1CF
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566279; cv=none; b=GV/um81Y/o7+z1T+UN+rgtq784O7xQRFxhATDn75SNZxwmm5AapvIRZVl8bveWNe+2IMf6iYODrf4cKwVDzopywJ2uUuTWYWOVyJC3VgzebogpBGf6274BD3QEdtYrv4hyxAXI3TMxQWYD+JPjnZ+UuwgtTj0j6mOFzhzQJ1oIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566279; c=relaxed/simple;
	bh=Xc9aQoXRYYIls2agLerlt82ylcfD6hojYRdrfNu2sLA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TGC6NeWY9HlX5sdZz/R/OTJH2g6DqsdWm/c8l/0Z7xjoxIX2fG04mMyhdEFjZR1JxVTCsguTUtkfB9IEvds0goXJrRSsQsnDLSBKxyhD1y0EYxmFnhlTNahdBQHwqlvqj9EKQOgu4zkLOvsjTSzpdEW3ddbzjMgQivMn7HC+5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7aDMPU0; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7aDMPU0"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39b6416441eso10830818a91.1
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789566271; x=1790171071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bU1yWMfUZDKjZfhObCQxqtsz3o7IutVdnlaaxEO2y3k=;
        b=u7aDMPU0Xns8FvSBXb51gMFMF2EJjSOdO7Jvub9cdM63TY8HOgEcWbrgI7R/HRdXOQ
         HEa0pGjEM/VZruWUaqKxJ47EDDbjXoUuXkez/NkFXk4bHqRdYY4xwV8eP47qbfYC1l4d
         600cT0ilXrjl7fQ4r9kp3jBrl1J68pMTRN0sLWmFp+74xn55Wynv9MxQp5zrVabc/fYb
         /tvICxtoHTCFUPzbn/IDRWcIruc1Ofy77zjyv0KcmkbDp9S+jhFMbPpkQBAk6F9BxTlx
         kR6W3Fr+eNpjwY75GTPBuy/I4UhHrV+VVMncctFe7ol2Shut398GyaczEYsXsslQcB2e
         ar+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789566271; x=1790171071;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bU1yWMfUZDKjZfhObCQxqtsz3o7IutVdnlaaxEO2y3k=;
        b=lBy6YT7iq0v/Nb9nlvksJrXw3aWTXc9axJ2qum7D0WbFDHwUF/Th+VREuElfXsQsel
         ISAD3WiE9AkM29Ho+H5SBob5+JbY39kKS7qtxcZjJRH+aiawRLLR0erQsXd/J7s4SiEW
         cMnfsjQ1/LQ4GlAiJk7ymkfJSClYqKU6T+C/AdPKfZt3HmYygkMRAgM/GObY48z7uMd4
         0Mz8iZdxFVDbbEDUMdYC7iSq9lxfSpVgcM9FGOIziO8+L/cyzHCwSUQDeNvNi6PgJYSi
         DOg7tLph40mNjK5+ijLlELgfQdOBtLFFEXjrhmo1gvl6PB0/kOw08EwjaAY9x1YQ89if
         uPvA==
X-Gm-Message-State: AFuF++laoSZS+YBRnC281tXTIeAtXheRnyc3Xz+iv/l27H4dZ8kp+ZKb
	PtRgMN3n2b0QigyQmhviaBXHXiBtlz6KXpDDaxBX9q0qKandqIsqjU6Dg9GTcpx/wQYFrdqEa0q
	/0h/8Hw==
X-Received: from pjbmh3.prod.google.com ([2002:a17:90b:4ac3:b0:39d:f3a8:205b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5445:b0:39d:f4a8:75ef
 with SMTP id 98e67ed59e1d1-39e1e23d60dmr5966121a91.1.1789566270790; Wed, 16
 Sep 2026 06:44:30 -0700 (PDT)
Date: Wed, 16 Sep 2026 06:44:30 -0700
In-Reply-To: <20260916100452.1837412-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916100452.1837412-2-clopez@suse.de>
Message-ID: <aqqdPvUWUgocwsEj@google.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Fix NX page unaccounting for TDP MMU pages
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Vipin Sharma <vipinsh@google.com>, 
	James Houghton <jthoughton@google.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026, Carlos L=C3=B3pez wrote:
> unaccount_nx_huge_page() unconditionally passes KVM_SHADOW_MMU to
> untrack_possible_nx_huge_page(), which is incorrect, particularly on
> the path from kvm_recover_nx_huge_pages(), which handles pages from
> both MMUs.
>=20
> Fix this by adding a helper to retrieve the MMU type of a page and use
> it to pass the correct variant down.
>=20
> Fixes: 6777885605e1 ("KVM: x86/mmu: Track possible NX huge pages separate=
ly for TDP vs. Shadow MMU")
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
> ---
> v2:
>   * Use a helper to retrieve the MMU type to avoid referencing KVM_TDP_MM=
U for
>     32 bit builds (Sashiko).
>  arch/x86/kvm/mmu/mmu.c     |  2 +-
>  arch/x86/kvm/mmu/tdp_mmu.h | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 9788ff180374..fa3e9ff7bec1 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -868,7 +868,7 @@ static void unaccount_nx_huge_page(struct kvm *kvm, s=
truct kvm_mmu_page *sp)
>  {
>  	sp->nx_huge_page_disallowed =3D false;
> =20
> -	untrack_possible_nx_huge_page(kvm, sp, KVM_SHADOW_MMU);
> +	untrack_possible_nx_huge_page(kvm, sp, page_mmu_type(sp));

I would rather pass in the MMU type.  That avoids page_mmu_type(), and also=
 makes
it clear unaccount_nx_huge_page() is a common API, whereas account_nx_huge_=
page()
can only be used by the shadow MMU because setting nx_huge_page_disallowed =
needs
to be done before the page is linked in the TDP MMU, i.e. needs to be decou=
pled
from the tracking.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c254d96bd332..482818947737 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -864,11 +864,12 @@ void untrack_possible_nx_huge_page(struct kvm *kvm, s=
truct kvm_mmu_page *sp,
 	list_del_init(&sp->possible_nx_huge_page_link);
 }
=20
-static void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *s=
p)
+static void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *s=
p,
+				   enum kvm_mmu_type mmu_type)
 {
 	sp->nx_huge_page_disallowed =3D false;
=20
-	untrack_possible_nx_huge_page(kvm, sp, KVM_SHADOW_MMU);
+	untrack_possible_nx_huge_page(kvm, sp, mmu_type);
 }
=20
 static struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu=
 *vcpu,
@@ -2835,7 +2836,7 @@ static bool __kvm_mmu_prepare_zap_page(struct kvm *kv=
m,
 	}
=20
 	if (sp->nx_huge_page_disallowed)
-		unaccount_nx_huge_page(kvm, sp);
+		unaccount_nx_huge_page(kvm, sp, KVM_SHADOW_MMU);
=20
 	sp->role.invalid =3D 1;
=20
@@ -8061,7 +8062,7 @@ static void kvm_recover_nx_huge_pages(struct kvm *kvm=
,
 		WARN_ON_ONCE(!sp->nx_huge_page_disallowed);
 		WARN_ON_ONCE(!sp->role.direct);
=20
-		unaccount_nx_huge_page(kvm, sp);
+		unaccount_nx_huge_page(kvm, sp, mmu_type);
=20
 		if (is_tdp_mmu)
 			spin_unlock(tdp_mmu_pages_lock);
