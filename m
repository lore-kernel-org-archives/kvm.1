Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22B13812EF
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 04:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791000137; cv=none; b=sqbaIo4PzrhEvGizRrr9mz1MqEzCNV/AJxk8o+R3/Z2W0X8KTNELiobR3SiHGxuJ4aHeR/70/MRQpw65mQrPDdYhiB6DqF/brnKvkunO20wMbL6ewtxkPak1JDC1RCijCXSLdnBJ47/6Im2jruM6GN3xPB+4ovalLpjrsrS52i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791000137; c=relaxed/simple;
	bh=ukC5m089gJ4UEbX0kUL1PaFjcKDE1XJ+qB4QhjOFdgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c78i0NOWyDOQFkrzp6kua3RE6oyKHHSvjOCXxUWT/cvV5yGDR57oEUH6ICBVvw5LqGQKD6bqPGbjzJHQLSEtNAUuwClm28rClyQEOB4p1Y8uHDbui2wuvUcGZ1d3SbauuwsK/oC8jFjXjxglP+QCmfzMHFF+cbaqrzfhEFooASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdYpxbcK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdYpxbcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59421F00899
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 04:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791000135;
	bh=NZgAWVx+aR/FA4jplnUS2/mjOX6gx3dDfqwv9kzzHsg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FdYpxbcKuWaOHXr8pLAh7erPWl1b/Q4LYBESvPxjU2fMZ50bH4tCpJ1AtpvkaFjXy
	 ubUJKYHsC9eNIBuU5ZTerGojyvVLTnY75wav61FLf4E93S94vJMPUwv7N1bH7KtlFM
	 ewCNTf3jxzfvD4RZm3OImuTIimPXglynS4OidGogIqqHjaBTOuCXZnKzL0ucDOo32I
	 txItD8hpdAVV3MsZo/RjdNl4Mj7IFex8Ov9fHKaIFPYPe52jTLO0svXVyjoFwbUFj+
	 Easrg9eLqK4LcBmw1K0uA8rkpN1rz1VcnJdBdy+rNdjT33vDe7Bz32FrwpP4Sc+y01
	 eTfT/f9V1I/FA==
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6af7d702c76so122161a12.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 21:02:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxvod/qtNtLrJ6Jcu4OCKnBZvF/JPWWkaUQ0QgV7oUPgpGEjGssdzVuDd5xAJDuw+YTims=@vger.kernel.org
X-Gm-Message-State: AFq9FYImzvQeZgTczBmMKCUPNytVXXJzeyOaKYaQENyCv+7kw42VGxYQ
	srihQ7A9bd8q6YFWIqe7By4FNiqjfbwmHtGldCFa/fR4bgwc1sHZ6Mci4GIDdlZaYIms6gOcTBR
	b5EXdv2XWHw+2Cw3bbwyPfeYDRK7zOoE=
X-Received: by 2002:a05:6402:46c1:b0:6ae:550e:59e2 with SMTP id
 4fb4d7f45d1cf-6af9e30f2c3mr3292727a12.35.1791000134349; Fri, 02 Oct 2026
 21:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831094716.4016652-1-maobibo@loongson.cn>
In-Reply-To: <20260831094716.4016652-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 3 Oct 2026 12:02:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Jx5DFKE38ceXd=-_Vt_eObhrViE4QZmvJUQBT6Rqgaw@mail.gmail.com>
X-Gm-Features: AclHuK9pNRIer0dlZ-vhdZebvGAvWdALOK7rWuc0tUuF2DCz6OLs4gFc1cAa8X8
Message-ID: <CAAhV-H6Jx5DFKE38ceXd=-_Vt_eObhrViE4QZmvJUQBT6Rqgaw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] LoongArch: KVM: Add separate vmid support
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.


Huacai

On Mon, Aug 31, 2026 at 5:54=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> LoongArch KVM hypervisor supports two-level MMU, vpid index is used
> for stage1 MMU and vmid index is used for stage2 MMU.
>
> On 3A5000, vmid must be the same with vpid. On 3A6000 platform vmid
> may separate from vpid. There are such advantages if separated vmid
> is supported.
>   1. One VM uses one vmid, vCPUs on the same VM can share the same vmid.
>   2. If one vCPU switch between different physical CPUs, old vmid can be
>      still useful if it is not expired.
>   3. For remote tlb flush, it is to flush TLBs which are mapping
>      GPA --> HPA, only vmid need update and vpid need not.
>
> Here add separate vmid feature support, vmid feature detecting method
> comes from CPUCFG8 capability when LVZ is enabled.
> ---
> v2 ... v3:
>   1. Merge patch 1-2 into one and patch 3-4 into one.
>   2. Return directly and do not update vmid in function __kvm_check_vmid(=
)
>      if feature cpu_has_guestid is disabled by AI agent review.
>   3. In function kvm_arch_disable_virtualization_cpu disable feature
>      CSR_GTLBC_USES2TGID, similiar with enable cpu virtualization,
>      the same from AI agent review.
>   4. Rename USEVMID with USES2TGID, VMID is KVM software word and S2TGID
>      is hardware word.
>   5. Set cpu bit with vcpu->kvm->arch.tlb_flush_pending with
>      KVM_REQ_TLB_FLUSH, similiar with request KVM_REQ_TLB_FLUSH_GPA.
>
> v1 ... v2:
>   1. Move vmid together with vpid in patch1, rename it with hw_vmid.
>   2. Rename kvm_check_vcpuid() with __kvm_check_vpid(), and function
>      kvm_check_vmid() with __kvm_check_vmid().
>   3. Merge part of patch 2, patch 3/4 together.
>   4. Use bit8 of CPUCFG8 as guestid capability rather than LVZ version,
>      since it is hard to decide whether this feature exists with high LVZ
>      version in future.
>   5. Set cpu bit with vcpu->kvm->arch.tlb_flush_pending rather than
>      using add request KVM_REQ_TLB_FLUSH_GPA, it needs flush TLB on CPU
>      where page fault happens and vCPU maybe migrates to other CPUs.
> ---
> Bibo Mao (3):
>   LoongArch: KVM: Add vmid support for stage2 MMU
>   LoongArch: KVM: Implement vmid updating logic
>   LoongArch: KVM: Enable separate vmid feature
>
>  arch/loongarch/include/asm/kvm_host.h  | 10 ++++
>  arch/loongarch/include/asm/loongarch.h |  5 ++
>  arch/loongarch/kernel/asm-offsets.c    |  1 +
>  arch/loongarch/kernel/cpu-probe.c      |  6 +++
>  arch/loongarch/kvm/main.c              | 71 ++++++++++++++++++++++++--
>  arch/loongarch/kvm/mmu.c               | 30 +++++++++--
>  arch/loongarch/kvm/switch.S            |  5 +-
>  arch/loongarch/kvm/tlb.c               | 19 ++++++-
>  8 files changed, 135 insertions(+), 12 deletions(-)
>
>
> base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
> --
> 2.39.3
>
