Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905CE2EC09B
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410746; cv=none; b=jMQYSOqvPUaCzXW1BmDAtffS4FkWlA+xAV8vYHklVloci0S04xVwZB4uxfZBfaUIsH0ITlB8XhL6UXc6raO31N2GtBAMQLBZMFjrrqmwnxcvnK6tl2hVEkNMrDhopxdKPkG1Fs7dkpv3W9xyUQiSCeL/QTdN+2hVi+Z7l/7cX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410746; c=relaxed/simple;
	bh=fV4izBefvZEoxUl+7mHUvnJNRlxtYC3adg9oNSUinso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEk2SbdWCGlL9bVkUIkr6GvgRHcVhg3Kke7Q7wofYhEyjoFjh15A4uh0CLQVgzOULYYebaPNmvfxXOeR7GNxQxgpb8/Dakgd5POdFgJiyzlWsSUpJ29s/L6pNJOoC+jbLmbXo/551SMrzJ+i2DR301NSw9t+kA4j1D+7nlRY+ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rysl233Z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rysl233Z"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so29033155ad.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 00:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783410744; x=1784015544; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GwFhZEe75QOrrpFepxS56/oDOfKBPpluDLwFIaqy6V8=;
        b=rysl233ZgtZMaDG4S6THPazUJcYKhuy4JgjvDRmsjtvciKdDTYZN3lMB+NadeHCwq5
         bL4UjrEusO4qh/H4/xjrd4q63CKwYCR6efxB5GXH+CVx6WKggMaSJ5o9OxhWu83mC3BU
         B781VvVERzG52cUVSHDvp896Desc7trBvLqAcmEXpANrPA337xJA1sOGE3zotB8iOiLE
         fsy/Op4PcAan87mYHuhi+M3nf39u7ZFfJsUAO1rAXncd9DXxMHuwDi9l5VxNYkHGhOmr
         bRyRQlycO8ffR/ZTHNYAt7ZVUVCTSqLqU/nERdmtnOF2ciK17mLsGX6tfHhu/b7Peyir
         s5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783410744; x=1784015544;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GwFhZEe75QOrrpFepxS56/oDOfKBPpluDLwFIaqy6V8=;
        b=B5VMHe7hdvD69iheXCylIhxYQ/8H5iJJ0xXuQ7CQnx2Bz91N7O54JYhh0FwTS8v3Ww
         LczWhaReHLBA8GdHb8OKQI8CAnBwfjGOuU0QJzW0jfih5gt3iWMx1ldrWuHqjgfXagdj
         xlTqo7twg/b8It7eMtEV/gKIvjhHl8sKuPPLCQYnQNnHtNjYWWvvytGOZg56dUAYVpxg
         8/D0HoiQVtZhLkmeL+tboxI4K3j57Zm4BzqmgF09YcwvcNtYtbq3epFtn+TfdJ/iB3Bd
         yM6xz4bKhWsg3dTkcvwcs7xcTjvKZAZYFZtDg92sVz8QkK0+P3NjjXyvFdLSzj0n+NP7
         70MA==
X-Forwarded-Encrypted: i=1; AHgh+RogN4pIbNMAvfx8eUSEgqdwkP5Jt8FhStI1AIWipTGfNFpU1tLNr1bDWBvzuKETbRVOknU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtJs5LiL7/erL4AB2Z7N1Rp6VT8bcFGAw8YTHAhx1yIXtOxuB
	YSsk4TTvvmvmfKKCU+YDj8LMXttpMjN9xT8UG2DBXYQvoAiBKpICjYcU
X-Gm-Gg: AfdE7cl2/7/pngr8n+94ToRYdgtQXMJMt0XOcOYOqH5AH2vZUg9r4EjLABfSed6mGhp
	IwkbbWXu08QE3uYDF7PeW0lfPQ5LQj0N6HAK+xloSGF4iW3SvpP9gVnv9cmH8DYYgUi+WyE3YBt
	xUCD6lwaL30Qah+qEm4TTM9VTLcc9UNXPqn50bkmdbtDXLFa49hvKWxpDksr18waVITxykxJKqc
	0Gqr3saTZ2NK+5Vltbg7JH0E1bgrt2CkDyDI3fbNE45X6ZlWTxjuxo9edz2/0rnZmcTj6cjcgyO
	DpFDlXRto4hlFBIuhvhhANi3wQbUoZjgGxELWlpdHmqH8dII6DqkYIX9TCB3TF6iowrTjXugdyv
	iVEMt3n0qd4/1o55YHEgjeRDh5w9/1zSdnH0DJWPQawWB+Hekjp2tB8Ygu4kcS4a+vaj9L57/UG
	g=
X-Received: by 2002:a17:903:4b30:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2ccd6ded718mr1949235ad.7.1783410743761;
        Tue, 07 Jul 2026 00:52:23 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d45csm7010035ad.62.2026.07.07.00.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:52:23 -0700 (PDT)
Date: Tue, 7 Jul 2026 15:51:47 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Anup Patel <anup@brainfault.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sergey Matyukevich <geomatsi@gmail.com>, Thomas Huth <thuth@redhat.com>, 
	Deepak Gupta <debug@rivosinc.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH v5 1/8] RISC-V: KVM: Add support for Svadu FWFT features
Message-ID: <akyv9SQ3CIV1YF29@inochi.infowork>
References: <20260706022046.214956-1-inochiama@gmail.com>
 <20260706022046.214956-2-inochiama@gmail.com>
 <akxm_sT7R9u4OIXo@inochi.infowork>
 <CAAhSdy3uPsYQUm5S+XHmAHunxB3M999GxNyM0Yj=9wakAVW=KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy3uPsYQUm5S+XHmAHunxB3M999GxNyM0Yj=9wakAVW=KA@mail.gmail.com>

On Tue, Jul 07, 2026 at 01:13:58PM +0530, Anup Patel wrote:
> On Tue, Jul 7, 2026 at 8:16 AM Inochi Amaoto <inochiama@gmail.com> wrote:
> >
> > On Mon, Jul 06, 2026 at 10:20:37AM +0800, Inochi Amaoto wrote:
> > > Hardware updating of PTE A/D bits is controlled through ADUE bit in
> > > henvcfg Expose the feature only if both Svadu and Svade are supported
> > > for VS-mode.
> > >
> > > Allow the VMM to enable/disable this feature by change the ISA
> > > extension state in the guest.
> > >
> > > Assisted-by: YuanSheng:claude-4.7-opus
> > > Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> > > Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > ---
> > >  arch/riscv/include/uapi/asm/kvm.h |  1 +
> > >  arch/riscv/kvm/vcpu_sbi_fwft.c    | 77 +++++++++++++++++++++++++++++++
> > >  2 files changed, 78 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> > > index 504e73305343..7bbea8812d92 100644
> > > --- a/arch/riscv/include/uapi/asm/kvm.h
> > > +++ b/arch/riscv/include/uapi/asm/kvm.h
> > > @@ -240,6 +240,7 @@ struct kvm_riscv_sbi_fwft_feature {
> > >  struct kvm_riscv_sbi_fwft {
> > >       struct kvm_riscv_sbi_fwft_feature misaligned_deleg;
> > >       struct kvm_riscv_sbi_fwft_feature pointer_masking;
> > > +     struct kvm_riscv_sbi_fwft_feature pte_ad_hw_updating;
> > >  };
> > >
> > >  /* If you need to interpret the index values, here is the key: */
> > > diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
> > > index ab39ac464ffd..01db40b53295 100644
> > > --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> > > +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/kvm_host.h>
> > >  #include <asm/cpufeature.h>
> > >  #include <asm/sbi.h>
> > > +#include <asm/kvm_nacl.h>
> > >  #include <asm/kvm_vcpu_sbi.h>
> > >  #include <asm/kvm_vcpu_sbi_fwft.h>
> > >
> > > @@ -94,6 +95,45 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_feature_t feature)
> > >       return false;
> > >  }
> > >
> > > +static void kvm_sbi_fwft_env_flag_reset_helper(struct kvm_vcpu *vcpu,
> > > +                                            u64 flag)
> > > +{
> > > +     vcpu->arch.cfg.henvcfg &= ~flag;
> > > +}
> > > +
> > > +static long kvm_sbi_fwft_env_flag_set_helper(struct kvm_vcpu *vcpu,
> > > +                                          struct kvm_sbi_fwft_config *conf,
> > > +                                          bool one_reg_access,
> > > +                                          unsigned long value, u64 flag)
> > > +{
> > > +     struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
> > > +
> > > +     if (value == 0)
> > > +             cfg->henvcfg &= ~flag;
> > > +     else if (value == 1)
> > > +             cfg->henvcfg |= flag;
> > > +     else
> > > +             return SBI_ERR_INVALID_PARAM;
> > > +
> > > +     if (!one_reg_access) {
> > > +             ncsr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
> > > +             if (IS_ENABLED(CONFIG_32BIT))
> > > +                     ncsr_write(CSR_HENVCFGH, vcpu->arch.cfg.henvcfg >> 32);
> > > +     }
> > > +
> > > +     return SBI_SUCCESS;
> > > +}
> > > +
> >
> > Hi, Anup,
> >
> > The sashiko bot point out calling NACL helper is not safe here as
> > preemption is not allowed when calling this_cpu_ptr() and it is
> > used by the NACL helper. Since I have no idea about how to fix it,
> > is it acceptable to use csr read/write directly here as other FWFT
> > feature?
> 
> I think its okay use regular csr_read/write() over here because FWFT
> calls are not in hotpath so it won't have much impact on nested
> virtualization performance.
> 

Great, I will switch to the csr_read/write() in the next version. Thanks.

Regards,
Inochi

> Regards,
> Anup
> 
> >
> > Regards,
> > Inochi
> >
> >
> > The original reply from the bot is
> >
> > Is it safe to call ncsr_write() here without preemption disabled?
> >
> > KVM handles SBI ecalls with preemption enabled. The ncsr_write() macro
> > evaluates nacl_shmem(), which relies on this_cpu_ptr(). Using this_cpu_ptr()
> > with preemption enabled will trigger a CONFIG_DEBUG_PREEMPT warning.
> >
> > Could the thread be migrated to another CPU after computing the pointer but
> > before writing to it, resulting in per-CPU memory corruption by writing to
> > the NACL shared memory of another physical CPU?
> >
> > Additionally, when NACL is disabled, it falls back to csr_write(), which
> > writes directly to the physical CPU's host CSRs (CSR_HENVCFG). Could this
> > leave the host with modified hardware state if the vCPU thread migrates?
> >
> >
> > > +static long kvm_sbi_fwft_env_flag_get_helper(struct kvm_vcpu *vcpu,
> > > +                                          struct kvm_sbi_fwft_config *conf,
> > > +                                          bool one_reg_access,
> > > +                                          unsigned long *value, u64 flag)
> > > +{
> > > +     *value = (vcpu->arch.cfg.henvcfg & flag) == flag;
> > > +
> > > +     return SBI_SUCCESS;
> > > +}
> > > +
> > >  static bool kvm_sbi_fwft_misaligned_delegation_supported(struct kvm_vcpu *vcpu)
> > >  {
> > >       return misaligned_traps_can_delegate();
> > > @@ -137,6 +177,34 @@ static long kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
> > >       return SBI_SUCCESS;
> > >  }
> > >
> > > +static bool kvm_sbi_fwft_pte_ad_hw_updating_supported(struct kvm_vcpu *vcpu)
> > > +{
> > > +     return riscv_isa_extension_available(vcpu->arch.isa, SVADU) &&
> > > +             riscv_isa_extension_available(vcpu->arch.isa, SVADE);
> > > +}
> > > +
> > > +static void kvm_sbi_fwft_reset_pte_ad_hw_updating(struct kvm_vcpu *vcpu)
> > > +{
> > > +     if (kvm_sbi_fwft_pte_ad_hw_updating_supported(vcpu))
> > > +             kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_ADUE);
> > > +}
> > > +
> > > +static long kvm_sbi_fwft_set_pte_ad_hw_updating(struct kvm_vcpu *vcpu,
> > > +                                             struct kvm_sbi_fwft_config *conf,
> > > +                                             bool one_reg_access, unsigned long value)
> > > +{
> > > +     return kvm_sbi_fwft_env_flag_set_helper(vcpu, conf, one_reg_access,
> > > +                                             value, ENVCFG_ADUE);
> > > +}
> > > +
> > > +static long kvm_sbi_fwft_get_pte_ad_hw_updating(struct kvm_vcpu *vcpu,
> > > +                                             struct kvm_sbi_fwft_config *conf,
> > > +                                             bool one_reg_access, unsigned long *value)
> > > +{
> > > +     return kvm_sbi_fwft_env_flag_get_helper(vcpu, conf, one_reg_access,
> > > +                                             value, ENVCFG_ADUE);
> > > +}
> > > +
> > >  #ifndef CONFIG_32BIT
> > >
> > >  static bool try_to_set_pmm(unsigned long value)
> > > @@ -246,6 +314,15 @@ static const struct kvm_sbi_fwft_feature features[] = {
> > >               .set = kvm_sbi_fwft_set_misaligned_delegation,
> > >               .get = kvm_sbi_fwft_get_misaligned_delegation,
> > >       },
> > > +     {
> > > +             .id = SBI_FWFT_PTE_AD_HW_UPDATING,
> > > +             .first_reg_num = offsetof(struct kvm_riscv_sbi_fwft, pte_ad_hw_updating.enable) /
> > > +                              sizeof(unsigned long),
> > > +             .supported = kvm_sbi_fwft_pte_ad_hw_updating_supported,
> > > +             .reset = kvm_sbi_fwft_reset_pte_ad_hw_updating,
> > > +             .set = kvm_sbi_fwft_set_pte_ad_hw_updating,
> > > +             .get = kvm_sbi_fwft_get_pte_ad_hw_updating,
> > > +     },
> > >  #ifndef CONFIG_32BIT
> > >       {
> > >               .id = SBI_FWFT_POINTER_MASKING_PMLEN,
> > > --
> > > 2.55.0
> > >
