Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7737F8DB
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541119; cv=none; b=Skq328PYX0RVO2tHr9dXJw1JxpCyi3xsdi+vjmTcew2JwrTKY2+CAVvDE7OK/gtwvz1O72sfDzlV8pkDeYWEHmYwIIrPeePMhqQjPFqC9KckaS/NeCDMGQtocB19NdtbXVo4eXnhYGTQCeYes48t7soUYev4B0aHG1sg2hhCDvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541119; c=relaxed/simple;
	bh=zKG0iS70PV1ZsDDU0ojNP7wKsx3DKqaKvtYhgGjhqec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=maItTNNKySmDZesXkqexGkLLxRwnQ8qMpmWVcxGeLobQ5MnMRLwB31E09n1F/AqijRfedvTDMKf9YjVrOp42b/BUWdUFbkr3zPKsq/al/1V7QWRD7uhmSX47UxkERQmcKdOD7A88ktbv/UhzNzOvQkPVT/HMG2BwgyI+GukoYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W1vKjvQW; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1vKjvQW"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8486ffba174so2723305b3a.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 16:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785541117; x=1786145917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dmKsJOviftvACUGPABBN88S+tJ91thYPhBWQcoJdx18=;
        b=W1vKjvQWU2LANf0hil7JAJKIzwtCO2qQsxWxRYPJFktMEYoEosVjNuPvQOlgo+yN9/
         9Efpz3ACwONT5oj34ijQIr2zrNOzFUt4rGxNkk60pwlO+u7i7ffdexxCEMoAu5wHU8V3
         zSYEsX3fR7iSQ3V2wDi6NUbH1MML9uI9P+KstO/dBj6nLwyJMr1hj0fLNUxQOqvAp3iY
         +2MOL7MJnmK0fI8Qg2svBwS8be/XAIq3dym2AI6Bojk/7SaU4IG0ju0nN+ulP7vGKdGA
         s662rLvG7wrLlDQYX7IxYNoaznEWfUsgM2VTbRVLusuNNfL6/ngs6/HhtedAOSKMdZoc
         guHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785541117; x=1786145917;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dmKsJOviftvACUGPABBN88S+tJ91thYPhBWQcoJdx18=;
        b=cqH9vC8fMP0TLKaNJYUdixNthsFQn5Cz6nTs+ByimZ8NiRez9MNLlNkVyJRvUAb5d0
         prlSSiCAPDiVZSMx1xAOOXDj74/115zNYo7l9Gm17wahvf9DNoHyQlNfJIs2VzxuxyuG
         sbklZ2yIDiYpluNc2cZreTvW/P3waBHOmHQRBp51Ad4MDiUUsRNTpaxnUCT1NCJbBYL0
         yD+oTXcWfyFyeLUbrTlTC8QwgWEzDnnyQVFKiRCpbHbjAzOqRtTJpdq+qehL8uHzqMpR
         vbvTdmxH51dYyTjeRtsQWiFz0kAK19vRXWF4A7NvZbtF6P/eCeBv00z9k6+hy5D3uCGR
         QxNA==
X-Forwarded-Encrypted: i=1; AHgh+RpQu6EYlDd9A4BJAMWs1ecb5euQqsnTkpChTDn+eMUWKfgqJLRCrl1rVwa64y8RI1x3pBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRuyyq+zXcIizin5meDLcyLNAXGLWZS8GyD9Fi/qd+RoSV1rq
	r0UvOL56e7w36llnYg2HW1GyY1eyVmEbY6+rgtReqdq2SsvCMPUbe3Eg1/jDMbyyvjh7awDkM1J
	MdG3LUQ==
X-Received: from pful5.prod.google.com ([2002:a05:6a00:1405:b0:847:a85b:6c23])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6c8f:b0:847:8b0f:2508
 with SMTP id d2e1a72fcca58-84ee47789c4mr1324782b3a.13.1785541116639; Fri, 31
 Jul 2026 16:38:36 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:38:36 -0700
In-Reply-To: <20260728144954.355376-35-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728144954.355376-1-dwmw2@infradead.org> <20260728144954.355376-35-dwmw2@infradead.org>
Message-ID: <am0x_ORC0olomizu@google.com>
Subject: Re: [PATCH v7 34/36] KVM: selftests: Add master clock offset test
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> Verify that KVM master clock mode remains active when vCPUs have
> different TSC offsets but the same frequency. Creates three vCPUs,
> sets one to a different TSC value, and confirms:
>=20
>  - KVM_CLOCK_HOST_TSC is set (master clock active)
>  - KVM_CLOCK_TSC_STABLE IS set (master clock =E2=87=92 stable flag)
>  - PVCLOCK_TSC_STABLE_BIT is NOT set (offsets differ)
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Assisted-by: Kiro (claude-opus-4.6-1m)
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../kvm/x86/masterclock_offset_test.c         | 180 ++++++++++++++++++
>  2 files changed, 181 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86/masterclock_offset_te=
st.c
>=20
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index 95539deea266..f6027a35f790 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -108,6 +108,7 @@ TEST_GEN_PROGS_x86 +=3D x86/pmu_event_filter_test
>  TEST_GEN_PROGS_x86 +=3D x86/private_mem_conversions_test
>  TEST_GEN_PROGS_x86 +=3D x86/private_mem_kvm_exits_test
>  TEST_GEN_PROGS_x86 +=3D x86/pvclock_test
> +TEST_GEN_PROGS_x86 +=3D x86/masterclock_offset_test

Keep these sorted alphabetically.

>  TEST_GEN_PROGS_x86 +=3D x86/pvclock_migration_test
>  TEST_GEN_PROGS_x86 +=3D x86/set_boot_cpu_id
>  TEST_GEN_PROGS_x86 +=3D x86/set_sregs_test
> diff --git a/tools/testing/selftests/kvm/x86/masterclock_offset_test.c b/=
tools/testing/selftests/kvm/x86/masterclock_offset_test.c
> new file mode 100644
> index 000000000000..88e2bd2edab5
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/masterclock_offset_test.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Test that KVM master clock mode works with different TSC offsets
> + * as long as all vCPUs have the same TSC frequency.
> + */
> +#include <stdint.h>
> +#include <string.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +
> +#include <asm/pvclock-abi.h>
> +
> +#define KVMCLOCK_GPA	0xc0000000ull
> +#define TSC_OFFSET	(1000000000ULL)
> +
> +static uint64_t pvclock_calc(struct pvclock_vcpu_time_info *pvti, uint64=
_t guest_tsc)
> +{
> +	uint64_t delta =3D guest_tsc - pvti->tsc_timestamp;
> +
> +	if (pvti->tsc_shift >=3D 0)
> +		delta <<=3D pvti->tsc_shift;
> +	else
> +		delta >>=3D -(int)pvti->tsc_shift;
> +
> +	return pvti->system_time + ((__uint128_t)delta * pvti->tsc_to_system_mu=
l >> 32);
> +}
> +
> +static void guest_code(void)
> +{
> +	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, KVMCLOCK_GPA | KVM_MSR_ENABLED);
> +	for (;;)
> +		GUEST_SYNC(0);
> +}
> +
> +int main(void)
> +{
> +	struct kvm_vcpu *vcpus[3];
> +	struct kvm_clock_data clock;
> +	struct pvclock_vcpu_time_info pvti[3];
> +	struct kvm_vm *vm;
> +	uint64_t offset0, host_tsc, clk0, clk2;
> +	int i;
> +
> +	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
> +
> +	vm =3D vm_create_with_vcpus(3, guest_code, vcpus);
> +
> +	TEST_REQUIRE(!__vcpu_has_device_attr(vcpus[0], KVM_VCPU_TSC_CTRL,
> +					     KVM_VCPU_TSC_OFFSET));
> +
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> +				    KVMCLOCK_GPA, 1,
> +				    vm_calc_num_guest_pages(VM_MODE_DEFAULT,
> +							   getpagesize()), 0);
> +	virt_map(vm, KVMCLOCK_GPA, KVMCLOCK_GPA,
> +		 vm_calc_num_guest_pages(VM_MODE_DEFAULT, getpagesize()));
> +
> +	/* Get vCPU 0's default offset and set vCPU 2's offset higher */
> +	vcpu_device_attr_get(vcpus[0], KVM_VCPU_TSC_CTRL,
> +			     KVM_VCPU_TSC_OFFSET, &offset0);
> +	uint64_t offset2 =3D offset0 + TSC_OFFSET;
> +	vcpu_device_attr_set(vcpus[2], KVM_VCPU_TSC_CTRL,
> +			     KVM_VCPU_TSC_OFFSET, &offset2);
> +
> +	/* Run each vCPU to enable kvmclock (with offset already set) */
> +	for (i =3D 0; i < 3; i++) {

ARRAY_SIZE(vcpus)

> +		vcpu_run(vcpus[i]);
> +		TEST_ASSERT_KVM_EXIT_REASON(vcpus[i], KVM_EXIT_IO);
> +	}
> +
> +	/* Check master clock is active */
> +	memset(&clock, 0, sizeof(clock));
> +	vm_ioctl(vm, KVM_GET_CLOCK, &clock);

Provide an API.

> +	pr_info("KVM_GET_CLOCK flags: 0x%x\n", clock.flags);
> +	TEST_ASSERT(clock.flags & KVM_CLOCK_HOST_TSC,
> +		    "Master clock should be active, flags=3D0x%x", clock.flags);
> +	TEST_ASSERT(clock.flags & KVM_CLOCK_TSC_STABLE,
> +		    "KVM_CLOCK_TSC_STABLE should be set, flags=3D0x%x", clock.flags);
> +
> +	/* Get per-vCPU pvclock in order 0, 2, 1 */
> +	int order[] =3D {0, 2, 1};

Please don't declare variables in the middle code.  Yes, it's now technical=
ly
possible thanks to all the guard() magic, but it's still against preferred =
kernel
style.

Though this itself is probably a really, really good indication that this n=
eeds
to be split into multiple testcases.  Maybe using TEST_F() and a custom fix=
ture?
