Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4EB25B09D;
	Tue, 28 Jul 2026 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207743; cv=none; b=ClPvN2mqCyeYnBE94YGvIQSILmkBOPZur3VCsAqVFAQodkrZ1pDSwHLzq9UiKhvabgW4Egwixnpw9W/gjCJ2x+IrfAncRTR/UE4BmALXf0avKkZjLxR1Td36WWcSsStdZpq/gOXKQ168BH+WYkcUIRXeo5i5Ikqm9CfDUcndDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207743; c=relaxed/simple;
	bh=wh5YwZwaGknr6EpwXFu7UyVjLB0ZfiiVHz+cteoeiB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXYVL3NV7CAw6+QVGrvwSWwMEoJFHUWsHFskJY/aO20slY2RvkT6se6eR4W0rX4hNyoaWl32zijdGW85/jrXibVRN0okpgRqnmHhLkfjUdSa4vNaWFScpwZMpKri1czoPZmqSV/fQ4EEONc3afAaioXuo8ligopP75ZmGT8y9z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KK+2RmAB; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KK+2RmAB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ZG7Oc9b8CGK+tOhTJkXqQqTec9nJil0TbgVpqIzq7yA=;
	b=KK+2RmABtHb2F/b+eAvSUSuqh3SEMu0ehVF0LIx6Z2C7pPys3ADoCN3ccrFaV0
	jvPSt3GkhCfeM4wVjeP/OpNVFv61fqGGowcNIrA6173BICGGXwMe0Dxd2/WaGio9
	PA7rRGeXdW7fcejPEltGvqBg7+DvqmUjFc6L1isqg3pk8=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC3IPmlG2hqXrw9MA--.63495S2;
	Tue, 28 Jul 2026 11:01:57 +0800 (CST)
Date: Tue, 28 Jul 2026 11:01:57 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hao Zhang <zhanghao1@kylinos.cn>
Subject: Re: [PATCH v4 6/6] KVM: selftests: Extend the invalid nVMX guest
 state test to cover RSM
Message-ID: <amgbpV4CW9livlfU@192.168.1.215>
References: <20260728004351.887076-1-seanjc@google.com>
 <20260728004351.887076-7-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728004351.887076-7-seanjc@google.com>
X-CM-TRANSID:_____wC3IPmlG2hqXrw9MA--.63495S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1rJrWfCF4fCF15Jr43Jrb_yoW5tryrpF
	ykCw4avrW5JFy7Xan3GF4IvFWrCFs7Gr40gr9xX34jyr1UKwn3tFn2grW3ua15CrZ7W3W5
	A3WUXrZ8Ww4DtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-Ma8UUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+QWkl2poG6U3xAAA3A

On Mon, Jul 27, 2026, Sean Christopherson wrote:
> From: Hao Zhang <hao_zhang_kdev@163.com>
> 
> Extend the invalid nVMX guest state to cover RSM, i.e. to validate that KVM
> synthesizes SHUTDOWN for L1 if SMRAM is clobbered with invalid guest state
> during an L2 => SMI => RSM => L2 sequence.
> 
> Note, unlike the existing testcase, clobbering SMRAM should result in L1,
> not L2, getting SHUTDOWN / TRIPLE_FAULT, as RSM is architecturally defined
> to trigger shutdown if the CPU detects invalid state.
> 
> Not-yet-signed-off-by: Hao Zhang <hao_zhang_kdev@163.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../kvm/x86/vmx_invalid_nested_guest_state.c  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
> index ab00265d6c94..6f546deb193a 100644
> --- a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
> +++ b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
> @@ -2,6 +2,7 @@
>  #include "test_util.h"
>  #include "kvm_util.h"
>  #include "processor.h"
> +#include "smm.h"
>  #include "vmx.h"
>  
>  #include <string.h>
> @@ -11,6 +12,22 @@
>  
>  #define ARBITRARY_IO_PORT 0x80
>  
> +/*
> + * The 64-bit SMRAM state-save area starts at SMBASE + 0xfe00.  TR starts at
> + * offset 0xfe90, and attributes is the second 16-bit field in the descriptor.
> + */
> +#define SMRAM64_TR_ATTRIBUTES_OFFSET	0xfe92
> +#define SMRAM_GPA			0x1000000
> +
> +/*
> + * SMI handler that runs in 16-bit Real Mode.  Syncs with L0 via port I/O, then
> + * executes RSM to trigger the consumption of invalid guest state.
> + */
> +static u8 smi_handler[] = {
> +	0xe4, ARBITRARY_IO_PORT,	/* IN $ARBITRARY_IO_PORT, %al */
> +	0x0f, 0xaa,			/* RSM */
> +};
> +
>  static void l2_guest_code(void)
>  {
>  	/*
> @@ -114,9 +131,45 @@ static void test_invalid_l2_guest_state(void)
>  	kvm_vm_free(vm);
>  }
>  
> +static void test_invalid_l2_guest_state_rsm(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	u16 *tr_attrs;
> +
> +	if (!kvm_has_cap(KVM_CAP_X86_SMM))
> +		return;
> +
> +	vm = vm_create_and_run_l2(&vcpu);
> +
> +	/*
> +	 * Inject SMI while L2 is active, run the vCPU to get I/O exit from L1,
> +	 * then stuff TR in the SMRAM state-save area so that RSM restores
> +	 * invalid L2 state.
> +	 */
> +	setup_smram(vm, vcpu, SMRAM_GPA, smi_handler, sizeof(smi_handler));
> +	inject_smi(vcpu);
> +
> +	vcpu_run_to_io(vcpu, false);
> +
> +	/* Clear the present bit in SMRAM to make TR unusable. */
> +	tr_attrs = addr_gpa2hva(vm, SMRAM_GPA + SMRAM64_TR_ATTRIBUTES_OFFSET);
> +	*tr_attrs &= ~BIT(7);
> +
> +	vcpu_run(vcpu);
> +
> +	/*
> +	 * For RSM, L1 gets the SHUTDOWN because RSM is architecturally defined
> +	 * to result in shutdown if the CPU detects invalid state in SMRAM.
> +	 */
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_SHUTDOWN);
> +	kvm_vm_free(vm);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
>  
>  	test_invalid_l2_guest_state();
> +	test_invalid_l2_guest_state_rsm();
>  }
> -- 
> 2.55.0.229.g6434b31f56-goog
>

Yes, please feel free to change my Not-yet-Signed-off-by to:
  
  Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>

Thanks,
Hao

