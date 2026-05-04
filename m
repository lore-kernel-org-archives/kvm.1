Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC4388E64
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777936251; cv=none; b=gIaLoUNK02Ju4mYtddFNbeZZ8pjwsSy32+qBxkPAvq1J4terft94N5aLtlVgyQrdUAewRhTb8sADxfoCvmJRKopw2nR664ucXsJgKc1IZ7C0mM4lwkQaB5s7DxQEyXpcRI5cpbBw/f4LULJdNzQTCDrDzN9r8w+KZXMSlCzKCDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777936251; c=relaxed/simple;
	bh=e1v+wg5Mt+4G2ehJr+dbUseIs8rNc8zIUsahECLU2nU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TXXjmKR2l69opdHzQClu263KUrpDzCUBU3jBjaf5Sh5QX24j4ViGa8upvoth6OGjYUg2EHlejwj3vUyeN48IR+dweko2ATwo7eUSsMUCpDQyIaOCnZbFvl2nyZPLQ8N0vp8ek+r2M59ZNkGykuI7yN4PcfckELE5viHklmrGCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RzmO6ZuJ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzmO6ZuJ"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36512f223d8so4713465a91.3
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 16:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777936250; x=1778541050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAttJD+RV5lk5kNpW7EPj87JP+4oaqPyp5frl0M0LOQ=;
        b=RzmO6ZuJiopjK38sYolMzLnHfoNKdZUPClmlYeciE2hDCq/GK68Af+Aq4ilU/LBOyu
         HJgBS3Rjnc7jW3gfRj9bBOY7lYfn8muJKT+JUFj9JRmWwhHAL5TCRNNYb2Fz0eG6Au2O
         lATPW9Wnlpi43hQ5ZZNncwTF+LkssYpWjZKAGzDtodO9AWVFumfKNdH5kOCopS00GhJi
         W7EtlDbcGr/xMPMltlyKoeKW5SZvrTbxNmdDqyjcYcfJ/XASjAdYvasigg1MnxkeeCCU
         EKsOWAY8ND2hZDD1rGaRpaRxKED4xNaaKQJkAcfTu2GsDkLoZuoKtAgSycAa59PCwreb
         meCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777936250; x=1778541050;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cAttJD+RV5lk5kNpW7EPj87JP+4oaqPyp5frl0M0LOQ=;
        b=SlHkaBW2J28KIfqpxSb9NnqCxB+GA3ZnS911hBXpshhDCuzqZxA0DmK4Lvw54xozHX
         byiVyhT/3k1+YXmvDS1+X2oqnEDa5tar50/Vr0dnFifkgKhXoKNfofaT2XhSD1Q1xsrT
         vruOaqKUhu4Hsi2ee3yc2GzHhA/5YpfLJ4CPOwG9QxRt2aXz5GRP9WjWe8mMPIPjg1g7
         kc29FGg/3IgDwRyl4OBrWdq8zrvSRZkbD0AMj2uZQgVkC4i6r4fiDIeyMJ1ctV12b8la
         BqDiTdgy2MSPBofD5Zq3MHWZ1SV6C3avCJR8+xjIcUOe/l/ML45/tdfvQ+WOdYEU7IKB
         xxBg==
X-Forwarded-Encrypted: i=1; AFNElJ/q8RBgTca549dpsE9+2MnvXzPqGjjFKEYtybvbFV6ANJn0qWlNYsT3Mb/bAnsCbVjycfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcpMeSj6bFtHs+ceiAXQ/PCHHnzoaa+UKuPP8k09YHFAH6cxDX
	Fmd2eVWQPa9DazEDHakmNqg+UztvMNniJwgncz/DKsSyWp0SxL5tvEclfJHzWhWZdl1FAaO1esf
	KLnSoZkItjQolchhIOJ8/iA==
X-Received: from pgbcs4.prod.google.com ([2002:a05:6a02:4184:b0:c79:8b14:e151])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:580f:b0:35f:bae8:3531 with SMTP id 98e67ed59e1d1-3657761ae72mr698785a91.25.1777936249486;
 Mon, 04 May 2026 16:10:49 -0700 (PDT)
Date: Mon,  4 May 2026 23:10:47 +0000
In-Reply-To: <20260504224213.1049426-2-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504224213.1049426-2-jthoughton@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504231048.1184273-1-jthoughton@google.com>
Subject: Re: [PATCH 1/5] KVM: arm64: Grab KVM MMU write lock in kvm_arch_flush_shadow_all()
From: James Houghton <jthoughton@google.com>
To: jthoughton@google.com
Cc: chenhuacai@kernel.org, gshan@redhat.com, jhogan@kernel.org, 
	joey.gouly@arm.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, loongarch@lists.linux.dev, maobibo@loongson.cn, 
	maz@kernel.org, oupton@kernel.org, pbonzini@redhat.com, ricarkol@google.com, 
	seanjc@google.com, shahuang@redhat.com, stable@vger.kernel.org, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, zhaotianrui@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 3:42=E2=80=AFPM James Houghton <jthoughton@google.co=
m> wrote:
>
> kvm_arch_flush_shadow_all() may sometimes be called on the same `kvm`
> concurrently in the event that the KVM's `mm` is __mmput() at the
> same time that last reference to the KVM is being dropped.
>
> T1              T2
> KVM_CREATE_VM
>                 Get VM file from T1
> close VM
> exit_mm()       close VM
>
> T1: exit_mm() -> kvm_mmu_notifier_release() -> kvm_flush_shadow_all(),
>     with only the KVM srcu read lock held.
>
> T2: kvm_vm_release() ---> mmu_notifier_unregister() ->
>     kvm_mmu_notifier_release() -> kvm_flush_shadow_all(),
>     again, with only the KVM srcu read lock held.
>
> This leads to a potential double-free of
> kvm->arch.kvm_mmu_free_memory_cache and now with NV
> kvm->arch.nested_mmus.
>
> Cc: stable@vger.kernel.org
> Fixes: e7bf7a490c68 ("KVM: arm64: Split huge pages when dirty logging is =
enabled")
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h |  1 +
>  arch/arm64/kvm/mmu.c             | 23 +++++++++++++++++++----
>  arch/arm64/kvm/nested.c          |  4 +++-
>  3 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kv=
m_mmu.h
> index 01e9c72d6aa7..30d5c24fcebb 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -178,6 +178,7 @@ void stage2_unmap_vm(struct kvm *kvm);
>  int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu, unsigne=
d long type);
>  void kvm_uninit_stage2_mmu(struct kvm *kvm);
>  void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu);
> +void kvm_free_stage2_pgd_locked(struct kvm_s2_mmu *mmu);
>  int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>                           phys_addr_t pa, unsigned long size, bool writab=
le);
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index d089c107d9b7..4bab407d43bb 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1021,7 +1021,9 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm=
_s2_mmu *mmu, unsigned long t
>
>  void kvm_uninit_stage2_mmu(struct kvm *kvm)
>  {
> -       kvm_free_stage2_pgd(&kvm->arch.mmu);
> +       lockdep_assert_held_write(&kvm->mmu_lock);

*facepalm*.... this doesn't account for the other callers of
kvm_uninit_stage2_mmu(). They will get lockdep warnings.

I've attached a diff to the bottom of this reply that *does* deal with them=
.
:( Sorry.

I'm guessing Marc or Oliver will probably want this patch to look quite
different, so I'll wait to hear from them before actually sending a v2.

In the meantime, I'll properly retest with lockdep enabled.

> +
> +       kvm_free_stage2_pgd_locked(&kvm->arch.mmu);
>         kvm_mmu_free_memory_cache(&kvm->arch.mmu.split_page_cache);
>  }
>
> @@ -1095,12 +1097,14 @@ void stage2_unmap_vm(struct kvm *kvm)
>         srcu_read_unlock(&kvm->srcu, idx);
>  }
>
> -void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
> +static void __kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu, bool locked)
>  {
>         struct kvm *kvm =3D kvm_s2_mmu_to_kvm(mmu);
>         struct kvm_pgtable *pgt =3D NULL;
>
> -       write_lock(&kvm->mmu_lock);
> +       if (!locked)
> +               write_lock(&kvm->mmu_lock);
> +
>         pgt =3D mmu->pgt;
>         if (pgt) {
>                 mmu->pgd_phys =3D 0;
> @@ -1111,7 +1115,8 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
>         if (kvm_is_nested_s2_mmu(kvm, mmu))
>                 kvm_init_nested_s2_mmu(mmu);
>
> -       write_unlock(&kvm->mmu_lock);
> +       if (!locked)
> +               write_unlock(&kvm->mmu_lock);
>
>         if (pgt) {
>                 kvm_stage2_destroy(pgt);
> @@ -1119,6 +1124,16 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
>         }
>  }
>
> +void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
> +{
> +       __kvm_free_stage2_pgd(mmu, false);
> +}
> +
> +void kvm_free_stage2_pgd_locked(struct kvm_s2_mmu *mmu)
> +{
> +       __kvm_free_stage2_pgd(mmu, true);
> +}
> +
>  static void hyp_mc_free_fn(void *addr, void *mc)
>  {
>         struct kvm_hyp_memcache *memcache =3D mc;
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index 883b6c1008fb..977598bff5e6 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -1190,11 +1190,13 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
>  {
>         int i;
>
> +       guard(write_lock)(&kvm->mmu_lock);
> +
>         for (i =3D 0; i < kvm->arch.nested_mmus_size; i++) {
>                 struct kvm_s2_mmu *mmu =3D &kvm->arch.nested_mmus[i];
>
>                 if (!WARN_ON(atomic_read(&mmu->refcnt)))
> -                       kvm_free_stage2_pgd(mmu);
> +                       kvm_free_stage2_pgd_locked(mmu);
>         }
>         kvfree(kvm->arch.nested_mmus);
>         kvm->arch.nested_mmus =3D NULL;
> --
> 2.54.0.545.g6539524ca2-goog

And here is the diff that should fix this patch. (Sorry!!)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_=
mmu.h
index 30d5c24fcebb..e32e844943be 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -177,6 +177,7 @@ void kvm_stage2_wp_range(struct kvm_s2_mmu *mmu, phys_a=
ddr_t addr, phys_addr_t e
 void stage2_unmap_vm(struct kvm *kvm);
 int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu, unsigned =
long type);
 void kvm_uninit_stage2_mmu(struct kvm *kvm);
+void kvm_uninit_stage2_mmu_locked(struct kvm *kvm);
 void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu);
 void kvm_free_stage2_pgd_locked(struct kvm_s2_mmu *mmu);
 int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 4bab407d43bb..98ba8116676c 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1019,14 +1019,6 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_=
s2_mmu *mmu, unsigned long t
 	return err;
 }
=20
-void kvm_uninit_stage2_mmu(struct kvm *kvm)
-{
-	lockdep_assert_held_write(&kvm->mmu_lock);
-
-	kvm_free_stage2_pgd_locked(&kvm->arch.mmu);
-	kvm_mmu_free_memory_cache(&kvm->arch.mmu.split_page_cache);
-}
-
 static void stage2_unmap_memslot(struct kvm *kvm,
 				 struct kvm_memory_slot *memslot)
 {
@@ -1134,6 +1126,24 @@ void kvm_free_stage2_pgd_locked(struct kvm_s2_mmu *m=
mu)
 	__kvm_free_stage2_pgd(mmu, true);
 }
=20
+static void __kvm_uninit_stage2_mmu(struct kvm *kvm, bool locked)
+{
+	__kvm_free_stage2_pgd(&kvm->arch.mmu, locked);
+	kvm_mmu_free_memory_cache(&kvm->arch.mmu.split_page_cache);
+}
+
+void kvm_uninit_stage2_mmu(struct kvm *kvm)
+{
+	__kvm_uninit_stage2_mmu(kvm, false);
+}
+
+void kvm_uninit_stage2_mmu_locked(struct kvm *kvm)
+{
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	__kvm_uninit_stage2_mmu(kvm, true);
+}
+
 static void hyp_mc_free_fn(void *addr, void *mc)
 {
 	struct kvm_hyp_memcache *memcache =3D mc;
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 977598bff5e6..f61f0244f0fb 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1201,7 +1201,7 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
 	kvfree(kvm->arch.nested_mmus);
 	kvm->arch.nested_mmus =3D NULL;
 	kvm->arch.nested_mmus_size =3D 0;
-	kvm_uninit_stage2_mmu(kvm);
+	kvm_uninit_stage2_mmu_locked(kvm);
 }
=20
 /*
