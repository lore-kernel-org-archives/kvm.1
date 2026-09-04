Received: from mta1.migadu.com (out-217.mta1.migadu.com [95.215.58.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F43CF032
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511164; cv=none; b=XVew2Od28EySGXPglAMBQUROkaRScUqD2tk0ccFn5kASeDTLT/xg48OpdYXqycblCEHn0u419xBzcr+VFBp2dApGmpgQWHdu5wCe99U1aUqlEExc2JkXy+EDwnNUuehEgOWjseuPlgMPkHgrbCmQRkRIkwlhGTBjyq6yKBW675k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511164; c=relaxed/simple;
	bh=ez4hNx4DVEe8KBHqNb84IrBjM+F93g8WM7rAblDyLXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBHz00GfPvJUBsU63T99Evi3yZhq4JyXymyQSRh0cm38PvBThrHvrpJX+kPUmXaGYt1UjGLuBasHhWpdJxHVa6gDo+V9mxfrcX9ox24TAE0SHizQo+BcZAUyNwv7GVMPc2kf+EAEyElPbM8cdqwoxdJ7Zte0LSqv+oIvoPXSEcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e4UOZ6vI; arc=none smtp.client-ip=95.215.58.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e4UOZ6vI"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ez4hNx4DVEe8KBHqNb84IrBjM+F93g8WM7rAblDyLXo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788511161; v=1; x=1789115961;
 b=e4UOZ6vIMXhuK9P5CFFsjfFasTlJagdI08gP8jjdx9yp+eaPDOAuN/0/CUGeJQHJEbkuFx7/
 cPtAEy6/kD256YMDHvEmBFFgGlD19X+VL4oaE+2KoDtkTVTPVfu9WvYNlPKaPaiIFmzFIkp/O8x
 dKIQT8SsQzQioZ+XipyVCaJk=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b0220d7eca2af7e0;
	Fri, 04 Sep 2026 08:39:21 +0000
X-Mizu-Trace-ID: b0220d7eca2af7e0
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b384c4so3597e87.1
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 01:39:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxr25xCQ7O3whTg6PKiB/kYNbLtjiXSTTy7+qnoWZMCiBhBQEOnxfhCiTUHNu+cnxvtB5k=@vger.kernel.org
X-Gm-Message-State: AFuF++lDQTO9vQ7Fvg3ISiJkoWj2r0Ifa4GlV6MQImO0hm1rvpfb7knz
	BRgHK3mi3A8JitUNnnjipOYPNBQ5Yv0oKu3Qxtxv+/ltv7lUaPHm860kbWTS9gWAxizkGodGjMB
	aknQ4JWfwY0W9L925Gqa8vzfA+EZhVnvJ9u2qAXrB
X-Received: by 2002:a05:6512:2352:b0:5b4:9dba:7401 with SMTP id
 2adb3069b0e04-5b6182512c1mr68725e87.11.1788511156074; Fri, 04 Sep 2026
 01:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826-arm64-52bit-va-v1-0-14ec98211363@fujitsu.com> <20260826-arm64-52bit-va-v1-1-14ec98211363@fujitsu.com>
In-Reply-To: <20260826-arm64-52bit-va-v1-1-14ec98211363@fujitsu.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 4 Sep 2026 09:38:39 +0100
X-Gmail-Original-Message-ID: <CA+EHjTy6EH-d=O+dtRdWdTUkS0zkXeW=auxiK6N5Dc-yihrYRw@mail.gmail.com>
X-Gm-Features: AcwNN1Ue3UiJZXsq0JIrKBZUTapvpCHZ2jnrY0FG9kKB_BUUN5ArhPu7u2gQg_E
Message-ID: <CA+EHjTy6EH-d=O+dtRdWdTUkS0zkXeW=auxiK6N5Dc-yihrYRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: selftest: arm64: Support 5-level paging in stage
 1 translation table
To: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Takayuki Okamoto <tokamoto@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

Hi Itaru,

The usual subject prefix in the tree is "KVM: arm64: selftests:", for
this patch and the next one.

On Tue, 25 Aug 2026 at 22:18, Itaru Kitayama <itaru.kitayama@fujitsu.com> wrote:
>
> Add p4d_index() for when 5-level paging required, i.e., V52 guest mode
> IDs. With the index helper function, _virt_pg_map() handles 5-level

Only VM_MODE_P52V52_4K has five levels. The 16K and 64K V52 modes get
four and three, so this is for the 4K granule rather than for V52
modes as a class.

...

>  u64 *virt_get_pte_hva_at_level(struct kvm_vm *vm, gva_t gva, int level)
>  {
> +       int start_level = 4 - vm->mmu.pgtable_levels;
>         u64 *ptep;
>
> +       TEST_ASSERT(level >= start_level && level <= 3,
> +                   "Invalid translation level %d, valid range is %d-3",
> +                   level, start_level);
> +
>         if (!vm->mmu.pgd_created)
>                 goto unmapped_gva;
>
>         ptep = addr_gpa2hva(vm, vm->mmu.pgd) + pgd_index(vm, gva) * 8;
>         if (!ptep)
>                 goto unmapped_gva;
> -       if (level == 0)
> +       /*
> +        * Stage-1 translation starts at level -1 for a five-level page
> +        * table, and at levels 0, 1, or 2 for four-, three-, or two-level
> +        * page tables, respectively.
> +        */
> +       if (level == start_level)


This changes what level means for the existing three-level modes:
level 0 used to return the top-level entry and now trips the assert,
level 1 used to return the leaf and now returns the top level. No
caller in tree asks for either of those two levels, and the new
numbering matches the architecture.

...

> @@ -321,12 +356,14 @@ void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
>         case VM_MODE_PXXVYY_4K:
>                 TEST_FAIL("AArch64 does not support 4K sized pages "
>                           "with ANY-bit physical address ranges");
> +       case VM_MODE_P52V52_64K:

These VM_MODE_ enumerators arrive in patch 2, so this patch does not
build on its own:

  lib/arm64/processor.c:359:7: error: use of undeclared identifier
'VM_MODE_P52V52_64K'; did you mean 'VM_MODE_P52V48_64K'?
  lib/arm64/processor.c:360:7: error: duplicate case value 'VM_MODE_P52V48_64K'

There are other build errors from the same cause. Could you move the
enum values and their vm_guest_mode_string()/vm_guest_mode_params[]
entries into this patch, or a new one altogether?

>         case VM_MODE_P52V48_64K:
>         case VM_MODE_P48V48_64K:
>         case VM_MODE_P40V48_64K:
>         case VM_MODE_P36V48_64K:
>                 tcr_el1 |= TCR_TG0_64K;
>                 break;
> +       case VM_MODE_P52V52_16K:
>         case VM_MODE_P52V48_16K:
>         case VM_MODE_P48V48_16K:
>         case VM_MODE_P40V48_16K:
> @@ -334,6 +371,7 @@ void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
>         case VM_MODE_P36V47_16K:
>                 tcr_el1 |= TCR_TG0_16K;
>                 break;
> +       case VM_MODE_P52V52_4K:
>         case VM_MODE_P52V48_4K:
>         case VM_MODE_P48V48_4K:
>         case VM_MODE_P40V48_4K:
> @@ -348,6 +386,9 @@ void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
>
>         /* Configure output size */
>         switch (vm->mode) {
> +       case VM_MODE_P52V52_4K:
> +       case VM_MODE_P52V52_16K:
> +       case VM_MODE_P52V52_64K:
>         case VM_MODE_P52V48_4K:
>         case VM_MODE_P52V48_16K:
>         case VM_MODE_P52V48_64K:
> @@ -578,6 +619,42 @@ static u32 max_ipa_for_page_size(u32 vm_ipa, u32 gran,
>                 return min(vm_ipa, 48U);
>  }
>
> +u32 aarch64_get_supported_va_size(void)

This repeats aarch64_get_supported_page_sizes() below it and builds a
second probe VM one line after the first. Could it take a u32 *va
out-param, so both ID registers come off the one vCPU?

VARange is the 52-bit VA indicator for the 64K granule only, so a bare
52 or 48 reads as granule-independent. The caller in patch 2 only uses
it for 64K, so nothing is wrong today.

Cheers,
/fuad


> +{
> +       struct kvm_vcpu_init preferred_init = {};
> +       int kvm_fd, vm_fd, vcpu_fd, err;
> +       u64 val;
> +       u32 va_range;
> +       struct kvm_one_reg reg = {
> +               .id     = KVM_ARM64_SYS_REG(SYS_ID_AA64MMFR2_EL1),
> +               .addr   = (u64)&val,
> +       };
> +
> +       kvm_fd = open_kvm_dev_path_or_exit();
> +       vm_fd = __kvm_ioctl(kvm_fd, KVM_CREATE_VM, NULL);
> +       TEST_ASSERT(vm_fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VM, vm_fd));
> +
> +       vcpu_fd = ioctl(vm_fd, KVM_CREATE_VCPU, 0);
> +       TEST_ASSERT(vcpu_fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VCPU, vcpu_fd));
> +
> +       err = ioctl(vm_fd, KVM_ARM_PREFERRED_TARGET, &preferred_init);
> +       TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_ARM_PREFERRED_TARGET, err));
> +
> +       err = ioctl(vcpu_fd, KVM_ARM_VCPU_INIT, &preferred_init);
> +       TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_ARM_VCPU_INIT, err));
> +
> +       err = ioctl(vcpu_fd, KVM_GET_ONE_REG, &reg);
> +       TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_GET_ONE_REG, err));
> +
> +       va_range = FIELD_GET(ID_AA64MMFR2_EL1_VARange, val);
> +
> +       close(vcpu_fd);
> +       close(vm_fd);
> +       close(kvm_fd);
> +
> +       return va_range >= ID_AA64MMFR2_EL1_VARange_52 ? 52 : 48;
> +}
> +
>  void aarch64_get_supported_page_sizes(u32 ipa, u32 *ipa4k,
>                                       u32 *ipa16k, u32 *ipa64k)
>  {
>
> --
> 2.43.0
>
