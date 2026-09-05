Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C17351C02
	for <kvm@vger.kernel.org>; Sat,  5 Sep 2026 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788620845; cv=none; b=uLe8DYqyMq3m2xcM6s7fLC9DGX7fmvt7sGFe9zurxTI7gzusFGYML5qw/fBn0HQBJKiSk3uSn1qut8/NgXdaokMpDq7P9aNYsfBqqHts0zYn3UwtoLhooaNIYeyEqzwbcWjNm5Vm3I08uBTneUxY6Wb/ZJEMOh8c8Q1nxWGnISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788620845; c=relaxed/simple;
	bh=nfRwOgjJOsyUJIOjBR6d6Lmr27CveS+qolynNbvilUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUyBFM4uHX54DA1icdfXIc0Z/dCd5aODiP5LfRqtXXoX1kLsn2Bsx/6/mwZP6Os89wWiLoJDdIZmjY1H1huZ7AEYDgYr5ki9eoY0iYy4N9s9GWst29CwYnO69cL+Uoc3MM+JE9Fw9toyTiAoeGMcTHJaVkA4OxjuaVy6MX4xkp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB8qnEQ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB8qnEQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003AE1F00A3F
	for <kvm@vger.kernel.org>; Sat,  5 Sep 2026 15:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788620844;
	bh=GNrwivmV53YoE5aiNIGWHcSAlCfGZ0bCLDEagzO10yI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VB8qnEQ7rL0aP3xFdp65UxRsB1VhP5Ju5MGYn+x070+6QjmI+rkcoMHp+uGd7qG5s
	 yxtXqCMQ8zuDisHXX2HXGHORtBZM0aSrZuzRT2mhlkyfoPd45/YGi6h6SgFcSDDOQ8
	 pGkFsQRhYN9EA2R1PupYMzUTDDwCmD5EeOl1EzErWTeC8jAcQ9fSiMtwWumJsdnVkR
	 da05TzOMXwjQ5pPtx8m7SMegRaYrYxWd2vHbJoMUMQbfmuXqJWuhegJVj1a+6jy+G8
	 0MEryM5cq1809tGwT3IPzNeYFTKHKYIDHGpm0joM13zWdAFahoEz3Rv/rWwCTj0K/4
	 FGi6E4hzfe6tQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a600a1caf8so3272494a12.2
        for <kvm@vger.kernel.org>; Sat, 05 Sep 2026 08:07:23 -0700 (PDT)
X-Gm-Message-State: AFuF++mtM53rXPyA/Jg3bNTtCk+rsPe5hAVmKcYkge+uyrKDH9RZpewD
	i+XOvWli9BVW6DGI1x63uKy/sgxhyAzx33L0bT2MNLxhsAF66ZVScfReCy7O63yto8ApfKQ3+H3
	LMgSs+lda1VvW8jmSoDUr6UzUt6emS8c=
X-Received: by 2002:a05:6402:2549:b0:6a6:1c30:bc4c with SMTP id
 4fb4d7f45d1cf-6a7e8d25de8mr4701468a12.5.1788620842659; Sat, 05 Sep 2026
 08:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812040132.113812-1-maobibo@loongson.cn>
In-Reply-To: <20260812040132.113812-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 5 Sep 2026 23:07:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6WtpF2_nsBwgjPWGBGs3veT2st1P3hUwbPTan1xeB50w@mail.gmail.com>
X-Gm-Features: AcwNN1X-UynZDXm-MSD8BbREYdy2QcNDTWRNTljynK7ewKSv3_B1Z7CX3OJb5R0
Message-ID: <CAAhV-H6WtpF2_nsBwgjPWGBGs3veT2st1P3hUwbPTan1xeB50w@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Remove unused function kvm_arch_flush_remote_tlbs_memslot()
To: Bibo Mao <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.


Huacai

On Wed, Aug 12, 2026 at 12:08=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> Function kvm_arch_flush_remote_tlbs_memslot() is not called any more,
> and it is unused. Here remove this API.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/kvm_host.h | 1 -
>  arch/loongarch/kvm/mmu.c              | 6 ------
>  2 files changed, 7 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/inclu=
de/asm/kvm_host.h
> index 23cfbecebbd7..5682b8c847d1 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -350,7 +350,6 @@ static inline void kvm_arch_vcpu_block_finish(struct =
kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_mem=
ory_slot *slot) {}
>  void kvm_check_vpid(struct kvm_vcpu *vcpu);
>  enum hrtimer_restart kvm_swtimer_wakeup(struct hrtimer *timer);
> -void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm, const struct kv=
m_memory_slot *memslot);
>  void kvm_init_vmcs(struct kvm *kvm);
>  void kvm_exc_entry(void);
>  int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> index e104897aa532..2c08402bfd3e 100644
> --- a/arch/loongarch/kvm/mmu.c
> +++ b/arch/loongarch/kvm/mmu.c
> @@ -939,9 +939,3 @@ int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsign=
ed long gpa, bool write, in
>  void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *me=
mslot)
>  {
>  }
> -
> -void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm,
> -                                       const struct kvm_memory_slot *mem=
slot)
> -{
> -       kvm_flush_remote_tlbs(kvm);
> -}
>
> base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
> --
> 2.39.3
>
>
