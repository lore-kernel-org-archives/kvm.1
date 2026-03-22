Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D119992C
	for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774194630; cv=pass; b=gtviXUZbfTt8eN+wLxP57zvscKyweQA7Y1Dn8CAYMofP62wptGtGp+x6W5E3XC7NlnVzxGmMkj3cq5mKqRBsEYLeA3+HBCSfak85e3T0NRPDuGWawiPeT6i91XbJELEzVQbmBnBI4AoauEC3b/6EWeMIqz1cDPtlWpYrMFGtm0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774194630; c=relaxed/simple;
	bh=BhBOLtHAp4YM9Z087VBxs34GLhAwhGBDe2xmAhBFqjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oj5S2LsX4xccoLQmyU/MGn6+3tL5zdv8qeX0g2jfqicTLAwMoi5NtpQNGrJcKVxuDM4V82Mqj9ZrQFkpiC6kiDnQBiSgRtLTMO8UEI8lL1gotB3IBa7dl7lh6Ct/989vOcvwAKCg2WpIilVYuYH2X2I/kX0Scqs+PjI0eP1WF0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GxpAf2X5; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxpAf2X5"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50b30d61be6so932471cf.0
        for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 08:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774194628; cv=none;
        d=google.com; s=arc-20240605;
        b=RuicOCbB19Z4iZWGOHYvwxvwxKShCSV51s5sYQpqgN39A19lWLQxKggL8kx4mpbYr2
         gTagDKdUjrlOdJMkinWKF7aNbo9ZF6h26Txzwb17lmdxYvhLnKb5padi11joB/zcGwFE
         oUWLzPTVtrJ9LBbE1YOMVxKwslg64XL35djBiWCECkOYx26OT0KGit2/ryQd7jepnnWB
         TM5O7+Iu1unZpGuFfLIS7LKBeSJH/cw7xW+crTnMx6ucOmrTiqt+XzwGUpfXWX9fJFWb
         FjMhPXZjrUPICylufkJ3y4CdiWHPm52826OCYx5iWEVsEKhSgvNza6FKnmyKjt7y0gE3
         Hv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9TMp7zsq0XX2Ydy/N6WFEOqdEvOC8DyuCjYsPFMbMJY=;
        fh=9FuY5UkvR8sHwuiKMyqYsOnq7GYV/3/TA1MdqFJy2EQ=;
        b=cSYqYvZlkaMhsWOEmG/QM4S7B9Xvvv0FtNSi/6rZfvjUnVzXEeMeGVD0x7ZjfhcLKu
         r+8m9gxQxh28mtwxcSl04X4z5Nfdt5aBE2L/US0cVrCLd3l9zBFOh1TVejWcjFT6rY4r
         gnimViZaGel8KJq+5TI+luifZWQXf8dmfXGK9mpSrT6U/uisd5qbuf0ZmAJqHR2yKyB9
         rBkqB2YGdkidufH6S/NK7jeTGEWn9BdNS/iftllIkhKmRsCGQ3nzU9poMt6zk99RO6GJ
         3X33fdDKBUJ6kafma+1WrjokxG+xbM71y9Lo8xEHjtvANzTOq++gHCaVIJYcZO938RCO
         ybCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774194628; x=1774799428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9TMp7zsq0XX2Ydy/N6WFEOqdEvOC8DyuCjYsPFMbMJY=;
        b=GxpAf2X5ZNRD9WROtxBEQMQTtpE3dAxPw+JfBcT+tz1uurmZS0Nn8vZo0E6eQah+R0
         6cPBdM/FfydJrCfI6QKyEgY40Ct2lWQh2CIT5IITVzwzlSijPp1K+mZztjrGgUM6udcw
         n7MV9NNQ0CUR3WT66ONmLkmnyMJu3F/V2PPJICD91Pu/2GzI4kYayPUYbxLTWS6b/AOv
         AsimuY4Apqz6H4pcyKzqFhXpX2ZEP1Z2JNpV/SDcbAvfeQkE9/fm1+r7EmFAMO1BHpKr
         9WtaNgQHb0rp+RtHYzNul2t3q5XANwfgDUWAiZmSX5hsF8h4cF9SiZdkPzhxwemh0gip
         BSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774194628; x=1774799428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TMp7zsq0XX2Ydy/N6WFEOqdEvOC8DyuCjYsPFMbMJY=;
        b=g8qwnPDPXDvLdYUfK1/rcD79UJGCqVOp/tbbh5H9ykrgCk182l2ssC6XL/upYS58jG
         t7azKTfmBdDsI+58qdi6Xj2swSdWUD8YiCa54hM16wGGCq70RHKMebPG5DIsvTEhW2uk
         a9ale39zD2XaTkVVa6pLkiZgBW337GWA/iWPhrGgtAQnQftNDsrFu+Kp6ssZxHFVO5SH
         XZ/8rnTRYeYlK8JYdXSJfF9knaQgubgTbeayPBRZN9ukzzyU/lrKxbIJRFMJlEjaHYef
         vOwK85iq030M0Fw+lQW5wL/hO7C3GYmEsfW2+ELNXKv4CD0e+u4Ww3c2CR1kRQ8lIv8z
         FuNg==
X-Forwarded-Encrypted: i=1; AJvYcCXD6Nb7hVtOyyEADVfpGQlXHetajJDESLOHpwPSMy/Tt0S+VQ5QLkC38BAU3NIif0JiKv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaAeD1SewgN6m6BPqh7aB6XsWdybF3NSGFeaEK0cmDycS3eZms
	SAJkiXoPOHCkxXEY0CDAoycXXqVYmd4HuazDezz/0iwgLmKN6D5vCOmV3/RJW8Fcjh3mKYeKAB4
	Jx72QSBcP3CU+IeWHyXcOXHm7D9c8hCftFbIpKJrS
X-Gm-Gg: ATEYQzzQPBJUH2oDVBKzxwx0YPNB7PP6O8Z56B9Md2FjN0x5zWxd7Tue4ZHg8hmJtD1
	9EbcICRhGG5nGj3g3n8GjHVdxVOLkfqyyFAc3UksVo8SsiydvFImNDOEfoauTkaWQ3PTLmpfI1l
	cGlB+Qkd4ICFL62gpsX8Jieia5fsT8E+0EujK4hXTTeAHgFzVgAaq5/fJ/OIyRMuUZlqR9tGJeI
	lXrsIjChzaylZ27eAyWu5HWKo4oC3cZ+qaHetf8K+QTdEoCRTqJ0H68IYp67mFpecWZuDevbctI
	ewwFu4jx
X-Received: by 2002:ac8:5f8e:0:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-50b48098112mr16468731cf.5.1774194627629; Sun, 22 Mar 2026
 08:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321212419.2803972-1-maz@kernel.org> <20260321212419.2803972-5-maz@kernel.org>
In-Reply-To: <20260321212419.2803972-5-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Sun, 22 Mar 2026 15:49:50 +0000
X-Gm-Features: AQROBzDQA782Knk4hyvgu0Qa0fNpkNAT5ojfrw4qkd--fM3yU2R8wbZU-YGI_Xs
Message-ID: <CA+EHjTyeuE3aqqmx8Fe4REOM7WstEAp_A0tvMNygPJCLT7V7wQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] KVM: arm64: pkvm: Use direct function pointers for cpu_{on,resume}
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>, 
	Mostafa Saleh <smostafa@google.com>, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Sat, 21 Mar 2026 at 21:24, Marc Zyngier <maz@kernel.org> wrote:
>
> Instead of using a boolean to decide whether a CPU is booting or
> resuming, just pass an actual function pointer around.
>
> This makes the code a bit more straightforward to understand.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_asm.h     |  3 ++-
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S   |  9 +++----
>  arch/arm64/kvm/hyp/nvhe/psci-relay.c | 39 +++++++++++++++++-----------
>  3 files changed, 29 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index a1ad12c72ebf1..f4c769857fdfc 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -291,7 +291,8 @@ asmlinkage void __noreturn hyp_panic_bad_stack(void);
>  asmlinkage void kvm_unexpected_el2_exception(void);
>  struct kvm_cpu_context;
>  void handle_trap(struct kvm_cpu_context *host_ctxt);
> -asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on);
> +asmlinkage void __noreturn __kvm_host_psci_cpu_on_entry(void);
> +asmlinkage void __noreturn __kvm_host_psci_cpu_resume_entry(void);
>  void __noreturn __pkvm_init_finalise(void);
>  void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc);
>  void kvm_patch_vector_branch(struct alt_instr *alt,
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> index 2e80fcbff2dff..64296b31da73d 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> @@ -173,7 +173,7 @@ SYM_CODE_END(___kvm_hyp_init)
>   * x0: struct kvm_nvhe_init_params PA
>   */
>  SYM_CODE_START(kvm_hyp_cpu_entry)
> -       mov     x1, #1                          // is_cpu_on = true
> +       ldr     x29, =__kvm_host_psci_cpu_on_entry
>         b       __kvm_hyp_init_cpu
>
>  /*
> @@ -182,11 +182,10 @@ SYM_CODE_START(kvm_hyp_cpu_entry)
>   * x0: struct kvm_nvhe_init_params PA
>   */
>  SYM_CODE_START(kvm_hyp_cpu_resume)
> -       mov     x1, #0                          // is_cpu_on = false
> +       ldr     x29, =__kvm_host_psci_cpu_resume_entry
>
>  SYM_INNER_LABEL(__kvm_hyp_init_cpu, SYM_L_LOCAL)
>         mov     x28, x0                         // Stash arguments
> -       mov     x29, x1
>
>         /* Check that the core was booted in EL2. */
>         mrs     x0, CurrentEL
> @@ -204,9 +203,7 @@ SYM_INNER_LABEL(__kvm_hyp_init_cpu, SYM_L_LOCAL)
>         bl      ___kvm_hyp_init                 // Clobbers x0..x2
>
>         /* Leave idmap -- using BLR is OK, LR is restored from host context */
> -       mov     x0, x29
> -       ldr     x1, =__kvm_host_psci_cpu_entry
> -       blr     x1
> +       blr     x29
>
>         // The core booted in EL1, or the C code unexpectedly returned.
>         // Either way, KVM cannot be initialized on it.
> diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> index c3e196fb8b18f..cc698ceee9c8c 100644
> --- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> +++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> @@ -200,23 +200,12 @@ static int psci_system_suspend(u64 func_id, struct kvm_cpu_context *host_ctxt)
>                          __hyp_pa(init_params), 0);
>  }
>
> -asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
> +static void __noreturn __kvm_host_psci_cpu_entry(unsigned long pc, unsigned long r0)
>  {
> -       struct psci_boot_args *boot_args;
> -       struct kvm_cpu_context *host_ctxt;
> -
> -       host_ctxt = host_data_ptr(host_ctxt);
> -
> -       if (is_cpu_on)
> -               boot_args = this_cpu_ptr(&cpu_on_args);
> -       else
> -               boot_args = this_cpu_ptr(&suspend_args);
> -
> -       cpu_reg(host_ctxt, 0) = boot_args->r0;
> -       write_sysreg_el2(boot_args->pc, SYS_ELR);
> +       struct kvm_cpu_context *host_ctxt = host_data_ptr(host_ctxt);
>
> -       if (is_cpu_on)
> -               release_boot_args(boot_args);
> +       cpu_reg(host_ctxt, 0) = r0;
> +       write_sysreg_el2(pc, SYS_ELR);
>
>         write_sysreg_el1(INIT_SCTLR_EL1_MMU_OFF, SYS_SCTLR);
>         write_sysreg(INIT_PSTATE_EL1, SPSR_EL2);
> @@ -224,6 +213,26 @@ asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
>         __host_enter(host_ctxt);
>  }
>
> +asmlinkage void __noreturn __kvm_host_psci_cpu_on_entry(void)
> +{
> +       struct psci_boot_args *boot_args = this_cpu_ptr(&cpu_on_args);
> +       unsigned long pc, r0;
> +
> +       pc = READ_ONCE(boot_args->pc);
> +       r0 = READ_ONCE(boot_args->r0);
> +
> +       release_boot_args(boot_args);
> +
> +       __kvm_host_psci_cpu_entry(pc, r0);
> +}
> +
> +asmlinkage void __noreturn __kvm_host_psci_cpu_resume_entry(void)
> +{
> +       struct psci_boot_args *boot_args = this_cpu_ptr(&cpu_on_args);

This should be suspend_args:
+     struct psci_boot_args *boot_args = this_cpu_ptr(&suspend_args);

With this fixed:

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad




> +
> +       __kvm_host_psci_cpu_entry(boot_args->pc, boot_args->r0);
> +}
> +
>  static unsigned long psci_0_1_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
>  {
>         if (is_psci_0_1(cpu_off, func_id) || is_psci_0_1(migrate, func_id))
> --
> 2.47.3
>
