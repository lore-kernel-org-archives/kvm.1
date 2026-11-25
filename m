Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795585817;
	b=SZDDx7nWKPW+xQJcM66B2VMxLnw/iiFgT4t1oMzBfrmWKB8xyVmf/bxVQylkAWtHc6v3
	 IOASgIwvQN8pfTrDZw1cqV8qw4U1SPdMwdUqP6spp9P5QuZg1/9E2g2zMdN2+PLBXCj2b
	 7VRQk+V6spZK3s8hWPGDpbSx0BDFyxgltGh5z5dlQHBchJFTfCSguzQwsT0/FED47g1AF
	 N2vmSt9qOFV00MKByaD7p8O0Zg9hucdOr+aaZrvjUwrUgq6O1Yu80F6JbcEs0Ei/dmuUG
	 Uu3rA0jGnrIfw2CuFUd3gYJNtdTVJFcA6OWXzyeNaIU5l+LA/7Y5/nehC7DskEqOh4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kT3tic/d91/ykIxW0D8n99nUbZymWMEwweL5i2/3Bio=;
	b=f3mM7vBaYIgs9cCCgUHk6URvXtM/xuzJNvvf6y/EBQVnOQFP21HofVK66mJb4rxs+FDV
	 NYH5LhZvtAMNJyHtPKruxDXQccSeA/0BiZBCSDTfrmcrebfI24GN89GKY+qsab23OVQK6
	 2ya4aIGC3QVcYnCz0DLjbY9r7cW3T6mj16NWDKwB4V+VzzI2nUTkPs2Q2A9Xt5BnuP/YM
	 ROCeDD0gjAAmWuXGSaO0JyU8sfo2AsybNmD/bMFRLezNQlCe3DtkX7WtYbYNRrxelMpXW
	 gvpv13OsRTowA5qz5mKaQgkJ5I36L4SY9a733Zk+WFDtRXkJrKw1jVWkkhLI6vfZwdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=K+2UvfK1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A987606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 05:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A987606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=K+2UvfK1
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a32576da88so3039859f8f.3
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 21:50:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795585815; cv=none;
        d=google.com; s=arc-20260327;
        b=MvTP501mvc/YKtZUszzPu7hRRtWWhSWHPEDf2gBLXZeLIGItph9sPm5Ah+GNf2GgUg
         qinf9exzybMkwpPoaBcAFL5du9qKAndK/ZZoAvdpVBxs4xRSC6eT3fNdqA/7akN2ieLi
         2kos8JkN3J3DnPoDGt91vaxoQ9ua83QAjlarOzfdGkxbqEiAv0oRbbpQtgnMSPKSqcK8
         hoajhOUQKhXcaL1OWYZqSrvqY3qPAJDs8szYgwYNZqHjoAjqW6iPzWJOeRZKEidG7OJh
         3aAJSsUPCQS+CCtY7kf/Lw9vQ9T1+qKFYzSFJ6FD/VKgzXkc63rQqiF6mey/g6Qk48HS
         RFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kT3tic/d91/ykIxW0D8n99nUbZymWMEwweL5i2/3Bio=;
        fh=APDGMvY1PqDCAaIewn3jmgI8peK8CiK33ugfKga4Rb0=;
        b=L5nj/jzZjyQZtVjevxCYeQJ6uJilpXqakqVzp55lQz1Q0mcvGBCwlE1/6WiR01zGa8
         g8LyQKKMaa1MkcrIg8yOIBCdN9e5t9Z2gb0EACOWZLbR+8hx/7BTIshZ3ok0RgEoKVv/
         1dNr45gdmEbv8f0MK/V0KFsduOHgh2s3j9uNXiSweEW8Z+WE4l8m/8KLlzejYWZoRSas
         PjVqyJvhwOV40s1G+A2//41YiwV2Mc01o5j+/t+3R6qphuG6ubzlRvF9nqoC2CVOdsK5
         8ZwKORVYu2WcaUPQN0L8zSDyiEzn5S5JPVBsMwB+7BtRtjY/O0LV+FG6RBRse+Z5b4OY
         fgyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795585815; x=1796190615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kT3tic/d91/ykIxW0D8n99nUbZymWMEwweL5i2/3Bio=;
        b=K+2UvfK1cwBf5HmQdBywYL5uXo1ci7tIKtFEzkLOJ08wVBn4ZypvJX9+bdyaWIeB2y
         bO06EcyZ1zOeV4zqpL5LJUNDPh7Rx1xdmMijDMwW/8QbZtxz/HD/2isNx2f6PlW9ytfR
         BKW1xIwbuWGI8d9GTmbD35rVf9p4jObioXtvmG4y2cSL03NdvmLuTEg4fGAaBuP1IbLV
         7GRLlTTSJ94aUx6JU02YWFpAgrU42AhrTSckIVlVYKZU0Vq4f1tfzcu8Ptdz+lIGuNjw
         +V4os65oqMMltzRs+fAEqyAYRkF6GnJoy+ydz2O9hTOoAvCF4ex6OVmFxmM+ylTLbrIE
         euvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795585815; x=1796190615;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kT3tic/d91/ykIxW0D8n99nUbZymWMEwweL5i2/3Bio=;
        b=PcAg6fWPxoQLjt4Z86bgZq5dezukWCnF7C+aYSBpbkWaR70IhJI9nTtWfxdA9McL1h
         D4cT1/NyPQp+XPGYQs3fae1XkSN2M4/7jIDyNqajlEgMXznW1v7Ih/FJ3XBby17ODIzZ
         CdfJZXg/NRdjNp7VbRLBFMt9QwzUno4CpJtGjD/e0s6XckezaAC98VsMjp1xnHQf0Kqy
         Lir3zGf+3aaSiih1fVIxx7RjRYfT/DMOBgdKJ0G72uEffPkwHkZjrZKzdTvlaOLjFLYZ
         w/f7qtkZoo9R/EJXlUCwthSVM87ySR2F2Jjl8eLF36qQwH7z6/C3UhgtXIAqAkzQvpMk
         1aBQ==
X-Forwarded-Encrypted: i=1; AL+hErGy99w0j6W6Ct6FBjSQ5XSAJBANQ9w/mlI/doRweUrz10PLYgmT/skuRMwTsVw8WagdRbM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8u48CyD6SY10un4hmX7XUE08zrqWBs2VGHafIPe3EwvZ8fOMX6
	tqw6b19QB9fDgHssvVPQOpevurzwS7999SEfBepDrDr7EGrIXmohZ/P31XJGk0oYNLvlQMufmfy
	8acKyuUHrQezhoQM9YCu2/Rxc9vzBnzs7dNMf8fIB4A==
X-Gm-Gg: AZFdTZfOCHPMZOt6UcDpHEJvDDDIz5sCdjxPoLOnzM2gQR9JxcOIHNouawYAxc/pgcc
	fDi9T3c7HnkbyKjUZuvQ9Hz9yW8Huv9RbOe1aqUkuonItQRz4fZsy6+8egDdG6sjjWsf59HrJ0U
	vevCwOOwwKX6LXW1fODWebRQpw5VgMCUrnie0E0XaDyq32HVyNIxmOY3HJ/aTtLL3SeJAhFIpdo
	7hrvJ1chOTbeDOwLQUKUP1P6dIRVYzkBZKQWEZumXdrjrnZa8W5MAr8dBhvgOCxT8jDiLhqF1NS
	ieeU9ivpoZxtx0q80natWbXjkpgeJ5fEertx8ehoH8pL7S/zVTwxkJnaXdOz7IcTgSwWKWsKDhO
	DX8mvWbho2bHbazJcYFff9G5niIO9yAqbhfzh3R4Xn9zu1iaALW6py5YuDbVArLY8zfQ/+0ZMPN
	tSJT9uJ9uJlqXsi5m1iIGYjGbzt+mIbOWTBygj+7VdyFjE+O/0DvV+ll4=
X-Received: by 2002:a05:6000:4008:b0:4b6:8c1:bc3d with SMTP id
 ffacd0b85a97d-4b608c1bc69mr9271540f8f.57.1795585815308; Tue, 24 Nov 2026
 21:50:15 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260921111402.120911-1-suunj1331@gmail.com> <20260921111402.120911-5-suunj1331@gmail.com>
In-Reply-To: <20260921111402.120911-5-suunj1331@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 25 Nov 2026 11:20:02 +0530
X-Gm-Features: Aa3M54p30lsdKRUsZb_oZ9Ir_KFeKDghmbl1hKMXGWdC2yvUELIJH6ADrwgQ5jc
Message-ID: <CAAhSdy1XYx+Piha+gkpMNgFprSwQ=P4gT9SwWgwQfLzhP1thbw@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] KVM: riscv: Free G-stage page tables after an RCU
 grace period
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Jinyu Tang <tjytimi@163.com>, 
	Wang Yechao <wang.yechao255@zte.com.cn>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 4:44=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> G-stage page tables are currently freed immediately after being
> unlinked under mmu_lock. This is safe while all walkers hold mmu_lock,
> as a table cannot be freed while a walker is using it. A subsequent
> change will allow aging walks without mmu_lock, where a walker may
> obtain a child table pointer just before a concurrent unmap unlinks
> and frees the table.
>
> Defer freeing unlinked page-table pages with call_rcu(). The parent
> entry is cleared before the child table is retired, so new walkers
> cannot acquire it while existing RCU-protected walkers can safely
> finish using it.
>
> Apply the same lifetime rule to the root PGD. Unpublish the root with
> WRITE_ONCE() and defer its free with call_rcu(). Keep pgd_levels
> unchanged so a walker that observed the old root continues to use
> matching page-table metadata.
>
> Wait for pending G-stage page-table callbacks with rcu_barrier() when
> the RISC-V KVM module exits so that they complete before the module is
> unloaded.
>
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> ---
>  arch/riscv/include/asm/kvm_gstage.h |  2 +-
>  arch/riscv/kvm/gstage.c             | 16 +++++++++++++++-
>  arch/riscv/kvm/main.c               |  3 +++
>  arch/riscv/kvm/mmu.c                | 16 +++++++++++++---
>  4 files changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index a03db1a10095..caeed6de6dbe 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -111,7 +111,7 @@ static inline void kvm_riscv_gstage_init(struct kvm_g=
stage *gstage, struct kvm *
>         gstage->kvm =3D kvm;
>         gstage->flags =3D 0;
>         gstage->vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
> -       gstage->pgd =3D kvm->arch.pgd;
> +       gstage->pgd =3D READ_ONCE(kvm->arch.pgd);
>         gstage->pgd_levels =3D kvm->arch.pgd_levels;
>  }
>
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index f7e4756ce15b..fc39d188b20a 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -22,6 +22,20 @@ unsigned long kvm_riscv_gstage_max_pgd_levels __ro_aft=
er_init =3D 2;
>  #define gstage_pte_leaf(__pte) \
>         (pte_val(__pte) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC))
>
> +static void gstage_free_page_table_rcu(struct rcu_head *head)
> +{
> +       put_page(container_of(head, struct page, rcu_head));
> +}
> +
> +/*
> + * Defer freeing an unlinked page table until lockless walkers
> + * that may have observed it have exited.
> + */
> +static void gstage_free_page_table(pte_t *table)
> +{
> +       call_rcu(&virt_to_page(table)->rcu_head, gstage_free_page_table_r=
cu);
> +}
> +
>  static inline unsigned long gstage_pte_index(struct kvm_gstage *gstage,
>                                              gpa_t addr, u32 level)
>  {
> @@ -406,7 +420,7 @@ bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstag=
e, gpa_t addr,
>                         flush |=3D kvm_riscv_gstage_op_pte(gstage, addr +=
 i * next_page_size,
>                                                          &next_ptep[i], n=
ext_ptep_level, op);
>                 if (op =3D=3D GSTAGE_OP_CLEAR)
> -                       put_page(virt_to_page(next_ptep));
> +                       gstage_free_page_table(next_ptep);
>         } else {
>                 if (op =3D=3D GSTAGE_OP_CLEAR) {
>                         set_pte(ptep, __pte(0));
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 89568ccce01d..5fcf425f7150 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -262,6 +262,9 @@ static void __exit riscv_kvm_exit(void)
>  {
>         kvm_exit();
>
> +       /* Wait for pending G-stage page-table RCU callbacks. */
> +       rcu_barrier();
> +

Just like TDP MMU in KVM x86, this should be part of
kvm_arch_destroy_vm() instead of doing at module exit time.

I will update at the time of merging.

>         /* Unregister CPU PM notifier */
>         if (IS_ENABLED(CONFIG_CPU_PM))
>                 cpu_pm_unregister_notifier(&kvm_riscv_cpu_pm_nb);
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 342f606399e5..8aed69abf814 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -761,6 +761,13 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
>         return 0;
>  }
>
> +static void kvm_riscv_mmu_free_pgd_rcu(struct rcu_head *head)
> +{
> +       struct page *page =3D container_of(head, struct page, rcu_head);
> +
> +       __free_pages(page, get_order(kvm_riscv_gstage_pgd_size));
> +}
> +
>  void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>  {
>         struct kvm_gstage gstage;
> @@ -773,9 +780,12 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>                 flush =3D kvm_riscv_gstage_unmap_range(&gstage, 0UL,
>                         kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels), =
false);
>                 pgd =3D READ_ONCE(kvm->arch.pgd);
> -               kvm->arch.pgd =3D NULL;
> +               /*
> +                * Keep pgd_levels unchanged for lockless walkers that al=
ready
> +                * observed the old root.
> +                */
> +               WRITE_ONCE(kvm->arch.pgd, NULL);
>                 kvm->arch.pgd_phys =3D 0;
> -               kvm->arch.pgd_levels =3D 0;
>         }
>         write_unlock(&kvm->mmu_lock);
>
> @@ -783,7 +793,7 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>                 kvm_flush_remote_tlbs(kvm);
>
>         if (pgd)
> -               free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage=
_pgd_size));
> +               call_rcu(&virt_to_page(pgd)->rcu_head, kvm_riscv_mmu_free=
_pgd_rcu);
>
>         kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
>  }
> --
> 2.52.0
>

Otherwise, LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
