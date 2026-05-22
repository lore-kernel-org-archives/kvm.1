Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9259F19004A;
	Fri, 22 May 2026 02:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779415393; cv=none; b=uR5eNZqy0H1+3QXnJr7bLK+R0xLR5v19JvU2pU1nhBi2hts1uT9+SgEbeMAQIMCzv9BpzeE93BTnKVkRfUY0/NMbjq0cs9imJaqqWG8Fb5vWBfFpq318LLBJENMmfKCeTWf51beWjpQZ1O+Dqzc5DDVQ/N9jeBSsDCZJh6ILqRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779415393; c=relaxed/simple;
	bh=FlVvE14imAmP+5N93mSJus2vdRTgAjydz028XS3eni4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jo9N235XORyQeZyCQonQLIPmh51hR2cAYzidcurTcHVIUw3Bat6ey9wigC8pH/dJ/v0emC/vXR1ayej25t9n7Cgly8+zgjvh4qUyi9l3M7aJGVNdsqP5Za3JfehCtdYRnWxUoz48gPz+fCIT6kHmnShBnvtDE9suUz/cAW4/d1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=UZTXlnCU; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="UZTXlnCU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1779415392; x=1810951392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FlVvE14imAmP+5N93mSJus2vdRTgAjydz028XS3eni4=;
  b=UZTXlnCUYJ64c3KqDYFeSQBUnVfntx9gN32Is2aqKajqjR7061R/HFX0
   Y9ZXO13VYiUGjTUsFHXDuY+vdd+9I8scRfvPEvWbPw7Ikikp9LgFS9Gdj
   mM2PFmMX5k5KS3RJOd2klfqQPrlhWbvbYFgLhnbhvabaIhKx4V9nGidyW
   KycTnVYPj8VPseASwQ6SdAkkWt56pNgeOr3NxBhZxKFnbR76JavafxlHn
   onBXKarrLtvUrRAn3r0sgMpAYHXRincSnGVetVZCaaT4q2IN+0Q0moSVv
   cOfHaTuplwF9yO9n7EjjYWjInqroC4nhZwZXZjEWxbGGJPYiWwcuGedxM
   A==;
X-CSE-ConnectionGUID: lopigGizSVekxqNsTnfPgQ==
X-CSE-MsgGUID: rZyerfVeT9yLJXaj3oTQnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="228793664"
X-IronPort-AV: E=Sophos;i="6.24,161,1774278000"; 
   d="scan'208";a="228793664"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 11:03:04 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 2533B1C000A7;
	Fri, 22 May 2026 02:03:04 +0000 (UTC)
Received: from az2uksmom1.o.css.fujitsu.com (az2uksmom1.o.css.fujitsu.com [10.151.22.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id C5B931C4DE84;
	Fri, 22 May 2026 02:03:03 +0000 (UTC)
Received: from sm-arm-grace07 (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmom1.o.css.fujitsu.com (Postfix) with ESMTPS id 56A15180113E;
	Fri, 22 May 2026 02:02:58 +0000 (UTC)
Date: Fri, 22 May 2026 11:02:54 +0900
From: Itaru Kitayama <itaru.kitayama@fujitsu.com>
To: Wei-Lin Chang <weilin.chang@arm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 5/9] KVM: arm64: selftests: Add shadow_stage2 test
Message-ID: <ag-5Tgd5WOymIE_p@sm-arm-grace07>
References: <20260516183003.799058-1-weilin.chang@arm.com>
 <20260516183003.799058-6-weilin.chang@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516183003.799058-6-weilin.chang@arm.com>

On Sat, May 16, 2026 at 07:29:59PM +0100, Wei-Lin Chang wrote:
> The shadow_stage2 test is aimed to exercise the shadow page table
> management code in KVM. In this first patch a basic test similar to
> hello_nested is created. Right now it doesn't turn on stage-2 for the
> nested guest (L2) yet, therefore the shadow page table code in KVM will
> only be triggered minimally now.
> 
> Signed-off-by: Wei-Lin Chang <weilin.chang@arm.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../selftests/kvm/arm64/shadow_stage2.c       | 128 ++++++++++++++++++
>  2 files changed, 129 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/arm64/shadow_stage2.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index e8c108e0c487..c0fac2ba1339 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -176,6 +176,7 @@ TEST_GEN_PROGS_arm64 += arm64/page_fault_test
>  TEST_GEN_PROGS_arm64 += arm64/psci_test
>  TEST_GEN_PROGS_arm64 += arm64/sea_to_user
>  TEST_GEN_PROGS_arm64 += arm64/set_id_regs
> +TEST_GEN_PROGS_arm64 += arm64/shadow_stage2
>  TEST_GEN_PROGS_arm64 += arm64/smccc_filter
>  TEST_GEN_PROGS_arm64 += arm64/vcpu_width_config
>  TEST_GEN_PROGS_arm64 += arm64/vgic_init
> diff --git a/tools/testing/selftests/kvm/arm64/shadow_stage2.c b/tools/testing/selftests/kvm/arm64/shadow_stage2.c
> new file mode 100644
> index 000000000000..cf76a2b0582d
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/arm64/shadow_stage2.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * shadow_stage2 - Test correctness of shadow stage 2
> + */
> +
> +#include "nested.h"
> +#include "processor.h"
> +#include "test_util.h"
> +#include "ucall.h"
> +
> +#define XLATE2GPA	(0xABCD)
> +#define L2STACKSZ	(0x100)
> +
> +#define L2SUCCESS	(0x0)
> +#define L2FAILED	(0x1)
> +#define L2SYNC		(0x2)
> +
> +/*
> + * TPIDR_EL2 is used to store vcpu id, so save and restore it.
> + */
> +static gpa_t ucall_translate_to_gpa(void *gva)
> +{
> +	gpa_t gpa;
> +	u64 vcpu_id = read_sysreg(tpidr_el2);
> +
> +	GUEST_SYNC2(XLATE2GPA, gva);
> +
> +	/* get the result from userspace */
> +	gpa = read_sysreg(tpidr_el2);
> +
> +	write_sysreg(vcpu_id, tpidr_el2);
> +
> +	return gpa;
> +}
> +
> +static void l2_guest_code(void)
> +{
> +	do_hvc(L2SYNC, 10, 0);
> +	do_hvc(L2SYNC, 20, 0);
> +	do_hvc(L2SYNC, 30, 0);
> +
> +	do_hvc(L2SUCCESS, 0, 0);
> +}
> +
> +static void guest_code(void)
> +{
> +	struct vcpu vcpu;
> +	struct hyp_data hyp_data;
> +	int ret, i = 0;
> +	gpa_t l2_pc, l2_stack_top;
> +	/* force 16-byte alignment for the stack pointer */
> +	u8 l2_stack[L2STACKSZ] __attribute__((aligned(16)));
> +
> +	GUEST_ASSERT_EQ(get_current_el(), 2);
> +	GUEST_PRINTF("vEL2 entry\n");
> +
> +	l2_pc = ucall_translate_to_gpa(l2_guest_code);
> +	l2_stack_top = ucall_translate_to_gpa(&l2_stack[L2STACKSZ]);
> +
> +	init_vcpu(&vcpu, l2_pc, l2_stack_top);
> +	prepare_hyp();
> +
> +	while (true) {
> +		GUEST_PRINTF("L2 enter\n");
> +		ret = run_l2(&vcpu, &hyp_data);
> +		GUEST_PRINTF("L2 exit\n");
> +		GUEST_ASSERT_EQ(ret, ARM_EXCEPTION_TRAP);
> +		GUEST_ASSERT_EQ(ESR_ELx_EC(read_sysreg(esr_el2)), ESR_ELx_EC_HVC64);
> +
> +		if (vcpu.context.regs.regs[0] == L2SYNC)
> +			GUEST_SYNC3(L2SYNC, i++, vcpu.context.regs.regs[1]);
> +		else
> +			break;
> +	}
> +
> +	if (vcpu.context.regs.regs[0] != L2SUCCESS)
> +		GUEST_FAIL("L2 failed\n");
> +
> +	GUEST_PRINTF("L2 success!\n");
> +	GUEST_DONE();
> +}
> +
> +int main(void)
> +{
> +	struct kvm_vcpu_init init;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	gpa_t gpa;
> +
> +	TEST_REQUIRE(kvm_check_cap(KVM_CAP_ARM_EL2));
> +	vm = vm_create(1);

This assumes the default P40V48 4KB guest creation, so perhaps you'd
want to change this to __vm_create(VM_SHAPE(), 1, 0) so the test runs too on other 
16KB and 64KB kernels? I've been testing it with your stage 2 unmapping
optimization series together with this v3 KVM selftest series.

Thanks,
Itaru.

> +
> +	kvm_get_default_vcpu_target(vm, &init);
> +	init.features[0] |= BIT(KVM_ARM_VCPU_HAS_EL2);
> +	vcpu = aarch64_vcpu_add(vm, 0, &init, guest_code);
> +	kvm_arch_vm_finalize_vcpus(vm);
> +
> +	while (true) {
> +		vcpu_run(vcpu);
> +
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_SYNC:
> +			if (uc.args[0] == XLATE2GPA) {
> +				gpa = addr_gva2gpa(vm, (gva_t)uc.args[1]);
> +				vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TPIDR_EL2), gpa);
> +			}
> +			if (uc.args[0] == L2SYNC)
> +				pr_info("L2SYNC, L1 info: %ld, L2 info: %ld\n", uc.args[1], uc.args[2]);
> +			break;
> +		case UCALL_PRINTF:
> +			pr_info("[L1] %s", uc.buffer);
> +			break;
> +		case UCALL_DONE:
> +			pr_info("DONE!\n");
> +			goto end;
> +		case UCALL_ABORT:
> +			REPORT_GUEST_ASSERT(uc);
> +			fallthrough;
> +		default:
> +			TEST_FAIL("Unhandled ucall: %ld\n", uc.cmd);
> +		}
> +	}
> +
> +end:
> +	kvm_vm_free(vm);
> +	return 0;
> +}
> -- 
> 2.43.0
> 
