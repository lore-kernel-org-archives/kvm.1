Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F63E5A04
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646300; cv=none; b=f/xz3Qk/iOGAcOZ8vAzz5dc0Mh1g5XGDWpjBnDTP71CVZ23B7o58KcTTv7c4DNccI0r23FowXasMLMMmKC23H2xcndt1KLPyRFErm1y/8bFmFnz/dJwIhq/83/4k69Bc3eZ5qnWkF8gGSPz0Yb8rx8IHJ69KLIeTy53NZBASB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646300; c=relaxed/simple;
	bh=RwKW0EGW5cLnrKSVig63FKyCJTHL+shTDFaKIQ5W8Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC06dA1yJJM5W6yz8qvdfpAJFancTt9T4XwUH12YWnXO79MKOAf7R+v/GlZJSFUwAAwCvltD7EBBjWkYibr2LLL/IKs6LgISr2Qp9b0vJ8MQ+X5Hmxh/kkiV1WhvyzcsUJqWtN5QeytZ86l/LqMynfVMKCgyEtJYzS83VpGg5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVNn6rs3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVNn6rs3"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0a5354da1so13252105ad.0
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780646298; x=1781251098; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U0wGo+/dZuxgW4szuH8gan5ReO5OZDCnLg0qgexAPWw=;
        b=MVNn6rs3u0CApKo5QwSD/ExIRIQ9IZxWGMSlA08Tgluo/ChBd/Cy4DXBEVW6sMXkBT
         MUAyGbwd0E3RzIetU/PzN4+R5DPArfT3gI6jtErCSByw9oDjuz3SL44Gg4UfypgY8ftm
         CsFM4GUm5Jc+i82OkQdur8GalS6sSzkIO6z2ag6QOCS3pwkNNpZIhxWIzcJbtu4eP50F
         hnUlLOqTNJsh2Xs472uN0qaBChdT5lWiZbjQwIWSyiPUKU8moy3Mghad0IjvKYZIkCjP
         uZHO49Woz/5nvVo3oepNqPFvA7ZRwbOtkqznC0a/9UYh6/PbldlvcfP0cCMQiLgaXkrV
         iWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780646298; x=1781251098;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0wGo+/dZuxgW4szuH8gan5ReO5OZDCnLg0qgexAPWw=;
        b=dBI4hYtwWWsMybjAEwcuDeeo1YWuVyltHQ9WScdc3pFMjigNxabjbpPgWJxWznd6Oa
         9PDaAIZ9rhunwccRVkof21PAjKhNcNmf/a1F0GuHe5uW1kwBBYKA4hEg4mmrTNX8AWH1
         aUJa1e8svdyehHugsUgjXYx5oMwAuXezIr2hxLiUMeG21cI7VuK+RbzvXptHS7i6JOe5
         eEn5OVZg0drhJ9Ozv8ZCZnNprLBLwJDSmkDPPKV0BDrhNFRfQwkioDtXPW674GUGs6oL
         0tdos6QEQT5njTEBWxNg0tot2Hjqa7VYD459e8FBUaJsuAxreM5K96nPR5huxOhJGGD3
         CMLA==
X-Forwarded-Encrypted: i=1; AFNElJ8yfFPdUdlolFeaRZUcNuD3HZNIt4qShzGGvDmqkV9Tfu8Pmkjt67RbKJxiBViqGp0Gxes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRoGjEh3Bhublv0A4X8Dh2GEVFuC8ODYGyq8Z7CXvHJ3t2CTGl
	XTwi4NLPFHFUBmiGygt1GcHpOul+aj2rmUBc3sac/bA0GkGQSKcfpSpe
X-Gm-Gg: Acq92OHt6DDG8jMM4PZUtthQMO8m4RxjqRk0aBA20z9X2MZGcAeMeSPkqbOXbVex9BY
	Cs1Oh840BdLdk/PdEg89nP8Bb7jU2ACXdU29d8adi5u2QUud9NNqX7+TRO5AHS1TnGcaCNHE2Bm
	EtBPG00WJ+k+EwMezskxUfU67LMLqbPb9Zus6JCeVUa13tnRtI94GlukQwC5tqqqE8lIiq4uwXw
	apv7B+pdIUkNcEFkhVwEmyv/CoW0YuUubfs1+np0vAczypWnjDwRUQKYq4xKkEvX3KO8At0Zyfb
	svje9BkQuO256p4B9VKUpxmFotTFSUFHdsUXvaboo4kfQaafOiU65QVGQ4bF63r8niCzdS6YNSJ
	kT1S4VyzaI1ubNbL8VfRLnw1p7EPzBvJcUSRrYS0VZeFbQPqlkTfVRujh5xIfoSJIhaEqzlECyK
	U8uGB8fnupH7ZPk2IOIy8dP34IIiQeUwAqrw==
X-Received: by 2002:a17:903:230f:b0:2bd:9b0e:b43a with SMTP id d9443c01a7336-2c1ec7a81e2mr15580255ad.7.1780646297700;
        Fri, 05 Jun 2026 00:58:17 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa0236sm84894355ad.33.2026.06.05.00.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 00:58:17 -0700 (PDT)
Date: Fri, 5 Jun 2026 15:58:15 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Anup Patel <anup@brainfault.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Enhance the logging check for mmu mapping
Message-ID: <aiJyHGne7VAkRD3g@inochi.infowork>
References: <20260528113840.2629186-1-inochiama@gmail.com>
 <CAAhSdy096z4SdwQKBxM0ZtE5=i3UZrhMD-BcES9UdP5OgajqEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy096z4SdwQKBxM0ZtE5=i3UZrhMD-BcES9UdP5OgajqEA@mail.gmail.com>

On Fri, Jun 05, 2026 at 12:19:03PM +0530, Anup Patel wrote:
> On Thu, May 28, 2026 at 5:08 PM Inochi Amaoto <inochiama@gmail.com> wrote:
> >
> > When enabling dirty ring, the dirty bitmap is disable, and the logging
> > check is always false as the RISC-V architecture does not select
> > "NEED_KVM_DIRTY_RING_WITH_BITMAP". Although the dirty log is recorded
> > since the write path already trying to add the dirty log, the logic for
> > logging check is broken and some side effect will occurs.
> >
> > Enhance the logging check for mmu mapping so it can check both the dirty
> > ring and the dirty bitmap.
> >
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  arch/riscv/kvm/mmu.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> > index 2d3def024270..b5873bca9dce 100644
> > --- a/arch/riscv/kvm/mmu.c
> > +++ b/arch/riscv/kvm/mmu.c
> > @@ -142,9 +142,8 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
> >                                 enum kvm_mr_change change)
> >  {
> >         /*
> > -        * At this point memslot has been committed and there is an
> > -        * allocated dirty_bitmap[], dirty pages will be tracked while
> > -        * the memory slot is write protected.
> > +        * At this point memslot has been committed and dirty pages will be
> > +        * tracked while the memory slot is write protected.
> >          */
> >         if (change != KVM_MR_DELETE && new->flags & KVM_MEM_LOG_DIRTY_PAGES) {
> >                 if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> > @@ -433,8 +432,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
> >         struct vm_area_struct *vma;
> >         struct kvm *kvm = vcpu->kvm;
> >         struct kvm_mmu_memory_cache *pcache = &vcpu->arch.mmu_page_cache;
> > -       bool logging = (memslot->dirty_bitmap &&
> > -                       !(memslot->flags & KVM_MEM_READONLY)) ? true : false;
> 
> Why is this not correct approach to determine whether logging is enabled ?
> 
> KVM ARM64 does a very similar thing (Refer, memslot_is_logging() in
> arch/arm64/kvm/mmu.c).
> 

ARM64 is correct as it select NEED_KVM_DIRTY_RING_WITH_BITMAP, which
will add a backup bitmap when enabling dirty ring. However, the RISCV
does not select this, which means the bitmap is not present when the
dirty ring is used. 

Although we still have dirty log with dirty ring now, it comes from
the check in the mark_page_dirty_in_slot(). And the check for variable
"logging" is always false when enabling dirty ring.

Regards,
Inochi

> > +       bool logging = kvm_slot_dirty_track_enabled(memslot) &&
> > +                      !(memslot->flags & KVM_MEM_READONLY);
> >         unsigned long vma_pagesize, mmu_seq;
> >         struct kvm_gstage gstage;
> >         struct page *page;
> > --
> > 2.54.0
> >
> 
> Regards,
> Anup
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
