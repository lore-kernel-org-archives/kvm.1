Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84B2339A8;
	Mon, 13 Apr 2026 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115964; cv=none; b=qv1Z3hoViUHTx2f6dj5bp1M7BUrJkr4uWyL8FtnubP6XaCqmcUBdnNpWXSJN+WJCpkq+h83+H7NZrd0OPwmtDSNEGg8y9zFpOoOoZFgRML5Z1JYUbGYoU0LVhgdImaAgIe8ruXsIhSIQLm/cJuSxGKe55YajuApzRFQpXlYfO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115964; c=relaxed/simple;
	bh=oXK3POGvspD97Z4RufOYHwBANWgOlSFIYW71OCn/5gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfonOS6eQwUIOBBJNmcLELFp3Ks2x0nQcjISW+8kQPJKQdFB97iY6OUTIXssnc7qWxvUYDZwTNVezTRRMJE5YEu0YLEdSDQQxYvrUQsOzz51kJdnvFyhKCR0XPQ4NEQI678vPS5ectmqB1I0ds+m6jBRqRE6DY4vquenY1Y2ouU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KcTl8UXW; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KcTl8UXW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1776115964; x=1807651964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oXK3POGvspD97Z4RufOYHwBANWgOlSFIYW71OCn/5gY=;
  b=KcTl8UXWiHBLMKRmCWvDKP+hGrZET97ZfTYiOv1/kjW9Z6EzgTnU5dG9
   PPD+FvWRH7SxUeFU4f0aX3le/ULnf7nQ/Q9DuaJfj778CCPEsvxYn3TmG
   A0BoV3a4hNvnfi+4LoLcMlyCAdqNsg9hEE3teAwPADnv5CeyCjreyKAPb
   6f0aWrV7xvzQMxWEzajc6wcsi51qeY5Q4pUULrss7HiLVfYR7HuNOL03Y
   hC5zK1/yxDbInJT6gWUOGH4FSz3G8J06ovSPqyBQhmxyaQbNAZB1KVP2C
   85Yy2uFBWBGlWJ1AkNBlaPtveqbMWOaGeVmW/GAIkqvgVKjW+qzVOUbbh
   w==;
X-CSE-ConnectionGUID: beEj62bVQ2m3SpsHnRSmzg==
X-CSE-MsgGUID: 33lN8RueTWWjb15wRfUtaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="236745313"
X-IronPort-AV: E=Sophos;i="6.23,178,1770562800"; 
   d="scan'208";a="236745313"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 06:31:33 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 7677F1002BA1;
	Mon, 13 Apr 2026 21:31:32 +0000 (UTC)
Received: from az2uksmom3.o.css.fujitsu.com (az2uksmom3.o.css.fujitsu.com [10.151.22.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 2E4AD86124A;
	Mon, 13 Apr 2026 21:31:32 +0000 (UTC)
Received: from sm-arm-grace07 (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmom3.o.css.fujitsu.com (Postfix) with ESMTPS id 52CBE1000361;
	Mon, 13 Apr 2026 21:31:26 +0000 (UTC)
Date: Tue, 14 Apr 2026 06:31:22 +0900
From: Itaru Kitayama <itaru.kitayama@fujitsu.com>
To: Wei-Lin Chang <weilin.chang@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 3/4] KVM: arm64: sefltests: Add basic NV selftest
Message-ID: <ad1gqsqqOXyYmJoG@sm-arm-grace07>
References: <20260412142216.3806482-1-weilin.chang@arm.com>
 <20260412142216.3806482-4-weilin.chang@arm.com>
 <adwofV7yf71OdMFk@sm-arm-grace07>
 <ddr6exocupk6mzshjwvu6sqt57aeqiyxqss3rpgcxxyh54cw4g@rxvm5zh3ybrw>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddr6exocupk6mzshjwvu6sqt57aeqiyxqss3rpgcxxyh54cw4g@rxvm5zh3ybrw>

On Mon, Apr 13, 2026 at 10:18:42AM +0100, Wei-Lin Chang wrote:
> Hi Itaru,
> 
> On Mon, Apr 13, 2026 at 08:19:25AM +0900, Itaru Kitayama wrote:
> > On Sun, Apr 12, 2026 at 03:22:15PM +0100, Wei-Lin Chang wrote:
> > > This selftest simply starts an L1, which starts its own guest (L2). L2
> > > runs without stage-1 and 2 translations, it calls an HVC to jump back
> > > to L1.
> > 
> > How do you disable both the nested guest (L2)'s MMU and stage 2
> > translations?
> 
> Guest stage-2 is disabled by not setting HCR_EL2.VM in prepare_hyp(),
> and stage-1 is disabled by not writing to SCTLR_EL12 in init_vcpu(),
> effectively using the default value set by L0. However since SCTLR_EL1
> has many architecturally UNKNOWN bits (including SCTLR_EL1.M), it should
> be better to write a value before running L2 I suppose...

Thanks. What do you think of using copy_el2_to_el1() macro in at.c, so we
can prepare in guest_code() to manipulate the SCTLR_EL12 System register 
with the sensible programmed values?

Itaru.

> 
> Thanks,
> Wei-Lin Chang
> 
> > 
> > Itaru.
> > 
> > > 
> > > Signed-off-by: Wei-Lin Chang <weilin.chang@arm.com>
> > > ---
> > >  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
> > >  .../selftests/kvm/arm64/hello_nested.c        | 103 ++++++++++++++++++
> > >  2 files changed, 104 insertions(+)
> > >  create mode 100644 tools/testing/selftests/kvm/arm64/hello_nested.c
> > > 
> > > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> > > index 3dc3e39f7025..e8c108e0c487 100644
> > > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > > @@ -168,6 +168,7 @@ TEST_GEN_PROGS_arm64 += arm64/arch_timer_edge_cases
> > >  TEST_GEN_PROGS_arm64 += arm64/at
> > >  TEST_GEN_PROGS_arm64 += arm64/debug-exceptions
> > >  TEST_GEN_PROGS_arm64 += arm64/hello_el2
> > > +TEST_GEN_PROGS_arm64 += arm64/hello_nested
> > >  TEST_GEN_PROGS_arm64 += arm64/host_sve
> > >  TEST_GEN_PROGS_arm64 += arm64/hypercalls
> > >  TEST_GEN_PROGS_arm64 += arm64/external_aborts
> > > diff --git a/tools/testing/selftests/kvm/arm64/hello_nested.c b/tools/testing/selftests/kvm/arm64/hello_nested.c
> > > new file mode 100644
> > > index 000000000000..97387e4697b3
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/kvm/arm64/hello_nested.c
> > > @@ -0,0 +1,103 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * hello_nested - Go from vEL2 to EL1 then back
> > > + */
> > > +
> > > +#include "nested.h"
> > > +#include "processor.h"
> > > +#include "test_util.h"
> > > +#include "ucall.h"
> > > +
> > > +#define XLATE2GPA	(0xABCD)
> > > +#define L2STACKSZ	(0x100)
> > > +
> > > +/*
> > > + * TPIDR_EL2 is used to store vcpu id, so save and restore it.
> > > + */
> > > +static vm_paddr_t ucall_translate_to_gpa(void *gva)
> > > +{
> > > +	vm_paddr_t gpa;
> > > +	u64 vcpu_id = read_sysreg(tpidr_el2);
> > > +
> > > +	GUEST_SYNC2(XLATE2GPA, gva);
> > > +
> > > +	/* get the result from userspace */
> > > +	gpa = read_sysreg(tpidr_el2);
> > > +
> > > +	write_sysreg(vcpu_id, tpidr_el2);
> > > +
> > > +	return gpa;
> > > +}
> > > +
> > > +static void l2_guest_code(void)
> > > +{
> > > +	do_hvc();
> > > +}
> > > +
> > > +static void guest_code(void)
> > > +{
> > > +	struct vcpu vcpu;
> > > +	struct hyp_data hyp_data;
> > > +	int ret;
> > > +	vm_paddr_t l2_pc, l2_stack_top;
> > > +	/* force 16-byte alignment for the stack pointer */
> > > +	u8 l2_stack[L2STACKSZ] __attribute__((aligned(16)));
> > > +
> > > +	GUEST_ASSERT_EQ(get_current_el(), 2);
> > > +	GUEST_PRINTF("vEL2 entry\n");
> > > +
> > > +	l2_pc = ucall_translate_to_gpa(l2_guest_code);
> > > +	l2_stack_top = ucall_translate_to_gpa(&l2_stack[L2STACKSZ]);
> > > +
> > > +	init_vcpu(&vcpu, l2_pc, l2_stack_top);
> > > +	prepare_hyp();
> > > +
> > > +	ret = run_l2(&vcpu, &hyp_data);
> > > +	GUEST_ASSERT_EQ(ret, ARM_EXCEPTION_TRAP);
> > > +	GUEST_DONE();
> > > +}
> > > +
> > > +int main(void)
> > > +{
> > > +	struct kvm_vcpu_init init;
> > > +	struct kvm_vcpu *vcpu;
> > > +	struct kvm_vm *vm;
> > > +	struct ucall uc;
> > > +	vm_paddr_t gpa;
> > > +
> > > +	TEST_REQUIRE(kvm_check_cap(KVM_CAP_ARM_EL2));
> > > +	vm = vm_create(1);
> > > +
> > > +	kvm_get_default_vcpu_target(vm, &init);
> > > +	init.features[0] |= BIT(KVM_ARM_VCPU_HAS_EL2);
> > > +	vcpu = aarch64_vcpu_add(vm, 0, &init, guest_code);
> > > +	kvm_arch_vm_finalize_vcpus(vm);
> > > +
> > > +	while (true) {
> > > +		vcpu_run(vcpu);
> > > +
> > > +		switch (get_ucall(vcpu, &uc)) {
> > > +		case UCALL_SYNC:
> > > +			if (uc.args[0] == XLATE2GPA) {
> > > +				gpa = addr_gva2gpa(vm, (vm_vaddr_t)uc.args[1]);
> > > +				vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TPIDR_EL2), gpa);
> > > +			}
> > > +			break;
> > > +		case UCALL_PRINTF:
> > > +			pr_info("%s", uc.buffer);
> > > +			break;
> > > +		case UCALL_DONE:
> > > +			pr_info("DONE!\n");
> > > +			goto end;
> > > +		case UCALL_ABORT:
> > > +			REPORT_GUEST_ASSERT(uc);
> > > +			fallthrough;
> > > +		default:
> > > +			TEST_FAIL("Unhandled ucall: %ld\n", uc.cmd);
> > > +		}
> > > +	}
> > > +
> > > +end:
> > > +	kvm_vm_free(vm);
> > > +	return 0;
> > > +}
> > > -- 
> > > 2.43.0
> > > 
