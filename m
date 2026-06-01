Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F13341AC7;
	Mon,  1 Jun 2026 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298316; cv=none; b=f34cR7KAdF6LdI4KqXKWuUg3f8biF8OnXPy1ur7BM2ncj/YOIgbDmwYqK0TXLfpzsGZ6/41o1lLGGmq7EjRQnULKsE6wZeHIq79ZVm4KY4qZcEfr510NTchC0ckqHAg/nzHlLXxdZk3f/VXJcHxGTmJKtIUnX1yylD70J+I+8Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298316; c=relaxed/simple;
	bh=vMRh2mmrS/doVWAOoKU+iZLLwSyFay2HTMVUXT94W7Y=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=jkKF20Nj/aq/CM1lROh3ch6DHD/eC5rTfePYqNJeKzPsF0J00IlMs+j0VK6L54azUvTUplnPJ15BUKbXH1nWRzvnty8yPk+TTJ2CmaQfeGP5Iw1Ba8bP43D8RovERQ2xvNVrt4DoMK0RsG9OC4e3WVlgV7vQ53TjxbcIgVBBqjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gTQL02cfMz5B13X;
	Mon, 01 Jun 2026 15:18:32 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 6517IPnr005080;
	Mon, 1 Jun 2026 15:18:25 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp05[null])
	by mapi (Zmail) with MAPI id mid12;
	Mon, 1 Jun 2026 15:18:27 +0800 (CST)
X-Zmail-TransId: 2b076a1d324392a-859ef
X-Mailer: Zmail v1.0
Message-ID: <202606011518277289v9DwCtREfa34rRwjUhqn@zte.com.cn>
In-Reply-To: <CAAhSdy3W4U_wYuH_pKq-V6iP6UE7e9h9Zhv=hKLykvWpiTEGVg@mail.gmail.com>
References: 20260429173002565bdp1o7P0bvOs6yTz64yNx@zte.com.cn,20260429173529259zFOx-ZsqSl_DS82KLXv0S@zte.com.cn,CAAhSdy3W4U_wYuH_pKq-V6iP6UE7e9h9Zhv=hKLykvWpiTEGVg@mail.gmail.com
Date: Mon, 1 Jun 2026 15:18:27 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <anup@brainfault.org>
Cc: <atish.patra@linux.dev>, <pjw@kernel.org>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <kvm@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAxLzNdIFJJU0MtVjogS1ZNOiBSZWZhY3RvciBrdm1fYXJjaF9jb21taXRfbWVtb3J5X3JlZ2lvbigp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6517IPnr005080
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 01 Jun 2026 15:18:32 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A1D3248.001/4gTQL02cfMz5B13X

> > From: Wang Yechao <wang.yechao255@zte.com.cn>
> >
> > Refactor kvm_arch_commit_memory_region() as a preparation for a future
> > commit to look cleaner and more understandable. Also, it looks more
> > like its arm64 and x86 counterparts.
> 
> This claim of making it similar to arm64 and x86 is incorrect. See below.
> 
> >
> > Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> > ---
> >  arch/riscv/kvm/mmu.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> > index 2d3def024270..dc6a8efde99e 100644
> > --- a/arch/riscv/kvm/mmu.c
> > +++ b/arch/riscv/kvm/mmu.c
> > @@ -141,12 +141,22 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
> >                                 const struct kvm_memory_slot *new,
> >                                 enum kvm_mr_change change)
> >  {
> > +       bool log_dirty_pages = new && new->flags & KVM_MEM_LOG_DIRTY_PAGES;
> > +       bool read_only = new && new->flags & KVM_MEM_READONLY;
> > +
> > +       /*
> > +        * Nothing more to do for RO slots (which can't be dirtied and can't be
> > +        * made writable) or CREATE/MOVE/DELETE of a slot.
> > +        */
> > +       if ((change != KVM_MR_FLAGS_ONLY) || read_only)
> > +               return;
> > +
> 
> I don't see how this is same as what x86 and arm64 does. There is
> no special casing for KVM_MR_FLAGS_ONLY in x86 and arm64.
> 
This is closer to the `kvm_mmu_slot_apply_flags` function on x86, so perhaps
it would be better to refer to the arm64 implementation to modify this function.

> >         /*
> >          * At this point memslot has been committed and there is an
> >          * allocated dirty_bitmap[], dirty pages will be tracked while
> >          * the memory slot is write protected.
> >          */
> > -       if (change != KVM_MR_DELETE && new->flags & KVM_MEM_LOG_DIRTY_PAGES) {
> > +       if (log_dirty_pages) {
> 
> Why drop "change != KVM_MR_DELETE" ?

The above condition "change != KVM_MR_FLAGS_ONLY" already filters out the
condition "change != KVM_MR_DELETE".

Best regards,
Yechao
> 
> >                 if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> >                         return;
> >                 mmu_wp_memory_region(kvm, new->id);
> > --
> > 2.43.5
> 
> Regards,
> Anup
