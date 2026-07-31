Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24744781A
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540781; cv=none; b=Oqx7LvQTLOZfJx9I+cj1ibd7Xj0GYggqEcd6CcqXvtSJoKQ3RC643tmPoZohKrGu/h/0tJiIgWGEB7345VYzlWo9VeuEUeVJVwU0UmMttwrfyN7Kn+A8gK1kkAITIvU8QRlgZpqHBhGX4jILJ5u7zB3VOrDV8XsHgAcJ+i6aJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540781; c=relaxed/simple;
	bh=t+Cf3qmtd23qA0r4BDXkizW3SEklEe7ujMZOzL2AWCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dKywXAhUISQ+XKAgDvbKJCq8S3NqJKD+xAOTIjkKjRuk0m3M3sVo3PaF0ji/+OnNcpy3bC1OvLiRoJc3kPa8FfV5tTQ/Y5h/ZRttAR9Cly0KFwLPEPohHQ2UlhyJUHQdZ9j7tmLPFv1TSSyioPioZv00D3rYzPoTbcz7xghfa48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgk+Y4bv; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgk+Y4bv"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso1760691a12.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 16:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785540779; x=1786145579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8/b1huLAEdiKYHbWYUwfN/XZnmcBk/ZLpbBd8pgF/SE=;
        b=fgk+Y4bvva3BMtU4tIH1kM66mbRCYtM8Bg2dPRChe14j5kVr0u86mcpHjdxzxmDAhV
         f7vn9ECkcG2UmHM26vC3fnPIcSyhnCkwiFkELGQY/cRL5zU/C2a+iq/iiE1Wm9Rnl281
         /3gckBJ7xh4faEhLhwBMbB2ZzFe8OrNdYq5eMsKOGuXOyhUl8dJfxywL6s89BKBn4g7j
         ji+Ffi4vTp5cno3pv41Z5N1+JKUvNiI4G2L2JCztABMWDK8Z03U1Va2KNTqWJZWLZb1T
         1SdfKPR2Q8jYti6SE5+zLiBupHAFTUtm96f1LhbVLZ/EbXTWWh3JQbZ6KyI8DCsgPkrx
         bdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785540779; x=1786145579;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8/b1huLAEdiKYHbWYUwfN/XZnmcBk/ZLpbBd8pgF/SE=;
        b=H6Vcg7M2CH+Vi9IGS515V8o2TJmZs0SWTOUK8RyICvl2aj/274RQQTXcrUYKEch8Ek
         YvvFqgitMSLRruRvreTWnxybUqbo9QgEYTlRdKxEeYR13QZkaHhz1BTPiieW2j8TMHNA
         G6Ztefp+YPDwAqGVAi3XeMU5JxTmfZnsuXaCEAXtyZVNonhByjz3hYwzemqtry/5RN+n
         bdaIQSCdWcPwco2PZcZ0VW5Wn6Eg5MngvunIOPrCd8Mdoj/GPDGydWk49cvq+sHWxPxW
         FCu11L6HCRsQCOE/7FULUPs9FM4Z3vI6eDhV/Wn7j27DST12rnLa+BRCRZUXVu6jHjx5
         a53Q==
X-Forwarded-Encrypted: i=1; AHgh+RrMT/vaZzEpO+cPzhrF2TfDj764KQsbQdOOJ12Xyij21KjZMUp5SpkghX7hAKSXINW9VoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM31YT4mz2n4QJcg1InOT8CJMmryv1Pp+rH40Q8Q7Qi5zu7RhJ
	EkiEDAcKrDsnCnMrChX7vzN7chb7Ki5m8q78WAijfoffMfPIYgAsILrZ73G8qeNCz/Jtrw+Iovq
	h3GkJWA==
X-Received: from pgbs63.prod.google.com ([2002:a63:5e42:0:b0:cbb:5dd3:9904])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9e0e:b0:3c0:9c18:d5a7
 with SMTP id adf61e73a8af0-3c92a8d8717mr1547928637.68.1785540778920; Fri, 31
 Jul 2026 16:32:58 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:32:58 -0700
In-Reply-To: <20260728144954.355376-34-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728144954.355376-1-dwmw2@infradead.org> <20260728144954.355376-34-dwmw2@infradead.org>
Message-ID: <am0wquLHtd28syfx@google.com>
Subject: Re: [PATCH v7 33/36] KVM: selftests: Add KVM/PV clock selftest to
 prove timer correction
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

> +int main(int argc, char *argv[])
> +{
> +	static const struct option long_opts[] =3D {
> +		{ "sleep", required_argument, NULL, 's' },
> +		{ "help",  no_argument,       NULL, 'h' },
> +		{ NULL,    0,                  NULL,  0  },
> +	};
> +	unsigned int sleep_sec =3D 2;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	uint64_t host_khz;
> +	uint64_t freq;
> +	int opt;
> +
> +	while ((opt =3D getopt_long(argc, argv, "s:h", long_opts, NULL)) !=3D -=
1) {
> +		switch (opt) {
> +		case 's':
> +			sleep_sec =3D atoi(optarg);
> +			break;
> +		case 'h':
> +		default:
> +			usage(argv[0]);
> +			return opt =3D=3D 'h' ? 0 : 1;
> +		}
> +	}
> +
> +	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_TSC_CONTROL));
> +
> +	vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> +	configure_pvclock(vm);
> +
> +	/* Check KVM_GET_CLOCK_GUEST is supported */
> +	{
> +		struct pvclock_vcpu_time_info tmp;
> +		int ret =3D __vcpu_ioctl(vcpu, KVM_GET_CLOCK_GUEST, &tmp);
> +		TEST_REQUIRE(ret =3D=3D 0);

It will likely be a moot point since we should have a CAP, but don't do TES=
T_REQUIRE()
on a local variable like this, it completely defeates the purpose of the ma=
cro
shenanigans.  Becuase this:

  1..0 # SKIP - Requirement not met: ret =3D=3D 0

is useless information, whereas this:

  1..0 # SKIP - Requirement not met: !__vcpu_ioctl(vcpu, KVM_GET_CLOCK_GUES=
T, &tmp)

gives the user a starting point without having to go search through the tes=
t code.

> +	}

...

> +static volatile uint32_t vcpu_counter;
> +static void guest_code_stable_bit(void)
> +{
> +	uint32_t idx =3D __atomic_fetch_add(&vcpu_counter, 1, __ATOMIC_SEQ_CST)=
;
> +	uint64_t gpa =3D KVMCLOCK_GPA + idx * sizeof(struct pvclock_vcpu_time_i=
nfo);

This series needs to be updated to catch up to upstream.  Selftests now use
u32, u64, etc.  And at least one patch missed an obvious opportunity for gu=
ard().=20

> +	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, gpa | KVM_MSR_ENABLED);
> +	GUEST_SYNC(0);
> +	GUEST_SYNC(0);
> +	GUEST_SYNC(0);
> +}
> +
> +static void set_tsc_offset(struct kvm_vcpu *vcpu, uint64_t offset)
> +{
> +	struct kvm_device_attr attr =3D {
> +		.group =3D KVM_VCPU_TSC_CTRL,
> +		.attr =3D KVM_VCPU_TSC_OFFSET,
> +		.addr =3D (__u64)(uintptr_t)&offset,
> +	};
> +
> +	TEST_REQUIRE(__vcpu_has_device_attr(vcpu, KVM_VCPU_TSC_CTRL,
> +					    KVM_VCPU_TSC_OFFSET) =3D=3D 0);
> +	vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &attr);

This quite clearly belongs in library code.

> +}
> +
> +static void run_vcpu_once(struct kvm_vcpu *vcpu)
> +{
> +	struct ucall uc;
> +
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +	switch (get_ucall(vcpu, &uc)) {
> +	case UCALL_ABORT:
> +		REPORT_GUEST_ASSERT(uc);

Gah, we really need to have vcpu_run() handle guest asserts.

> +		break;
> +	case UCALL_SYNC:
> +		break;
> +	default:
> +		TEST_FAIL("Unexpected ucall");
> +	}
> +}
> +
> +static void test_tsc_stable_bit(void)
> +{
> +	struct pvclock_vcpu_time_info pvti;
> +	struct kvm_vcpu *vcpus[2];
> +	struct kvm_vm *vm;
> +	int ret;
> +
> +	pr_info("Testing PVCLOCK_TSC_STABLE_BIT with matched/unmatched TSCs\n")=
;
> +
> +	vm =3D vm_create_with_vcpus(2, guest_code_stable_bit, vcpus);
> +	configure_pvclock(vm);
> +
> +	/*
> +	 * Case 1: All TSCs matched (same frequency and offset).
> +	 * Master clock should be active, PVCLOCK_TSC_STABLE_BIT set.
> +	 */
> +	run_vcpu_once(vcpus[0]);
> +
> +	ret =3D __vcpu_ioctl(vcpus[0], KVM_GET_CLOCK_GUEST, &pvti);
> +	TEST_ASSERT(!ret, "GET_CLOCK_GUEST should succeed with matched TSCs");
> +	TEST_ASSERT(pvti.flags & PVCLOCK_TSC_STABLE_BIT,
> +		    "PVCLOCK_TSC_STABLE_BIT should be set with matched TSCs");
> +
> +	/*
> +	 * Case 2: Different TSC offset, same frequency.
> +	 * Master clock should still be active (frequency matches), but
> +	 * PVCLOCK_TSC_STABLE_BIT should be cleared (offsets differ).
> +	 */
> +	set_tsc_offset(vcpus[1], 12345678);
> +	run_vcpu_once(vcpus[1]);
> +	run_vcpu_once(vcpus[0]);
> +
> +	ret =3D __vcpu_ioctl(vcpus[0], KVM_GET_CLOCK_GUEST, &pvti);
> +	if (ret) {
> +		/* Master clock disabled by offset mismatch =E2=80=94 old kernel */
> +		pr_info("  Skipping offset tests (master clock requires matched offset=
s)\n");
> +		goto out_stable;
> +	}
> +	TEST_ASSERT(!(pvti.flags & PVCLOCK_TSC_STABLE_BIT),
> +		    "PVCLOCK_TSC_STABLE_BIT should be clear with offset-mismatched TSC=
s");
> +
> +	/*
> +	 * Case 3: Different TSC frequency.
> +	 * Master clock should be disabled entirely.
> +	 */
> +	vcpu_ioctl(vcpus[1], KVM_SET_TSC_KHZ,
> +		   (void *)(unsigned long)(__vcpu_ioctl(vcpus[1], KVM_GET_TSC_KHZ, NUL=
L) / 2));
> +	/* Write TSC to trigger kvm_synchronize_tsc / kvm_track_tsc_matching */
> +	vcpu_set_msr(vcpus[1], MSR_IA32_TSC, 0);
> +	run_vcpu_once(vcpus[1]);
> +
> +	ret =3D __vcpu_ioctl(vcpus[0], KVM_GET_CLOCK_GUEST, &pvti);
> +	TEST_ASSERT(ret && errno =3D=3D EINVAL,
> +		    "GET_CLOCK_GUEST should fail with frequency-mismatched TSCs, got %=
d (errno %d)",
> +		    ret, errno);
> +
> +out_stable:
> +	kvm_vm_free(vm);
> +}
> +
> +static void test_clock_guest_with_offsets(void)
> +{
> +	struct pvclock_vcpu_time_info pvti0, pvti1, pvti1_after;
> +	struct kvm_vcpu *vcpus[2];
> +	struct kvm_vm *vm;
> +	int64_t delta;
> +	int ret;
> +
> +	pr_info("Testing KVM_[GS]ET_CLOCK_GUEST with different TSC offsets\n");
> +
> +	vm =3D vm_create_with_vcpus(2, guest_code_stable_bit, vcpus);
> +	configure_pvclock(vm);
> +
> +	/* Set different TSC offsets on the two vCPUs */
> +	set_tsc_offset(vcpus[0], 0);
> +	set_tsc_offset(vcpus[1], 1000000000ull);
> +
> +	/* Run both to establish kvmclock */
> +	run_vcpu_once(vcpus[0]);
> +	run_vcpu_once(vcpus[1]);
> +
> +	/* GET_CLOCK_GUEST on both =E2=80=94 should succeed (master clock activ=
e) */
> +	ret =3D __vcpu_ioctl(vcpus[0], KVM_GET_CLOCK_GUEST, &pvti0);
> +	if (ret) {
> +		pr_info("  Skipping (master clock requires matched offsets on this ker=
nel)\n");
> +		kvm_vm_free(vm);
> +		return;
> +	}
> +	ret =3D __vcpu_ioctl(vcpus[1], KVM_GET_CLOCK_GUEST, &pvti1);
> +	TEST_ASSERT(!ret, "GET_CLOCK_GUEST on vcpu1 failed");
> +
> +	/* The tsc_timestamps should differ (different offsets) */
> +	TEST_ASSERT(pvti0.tsc_timestamp !=3D pvti1.tsc_timestamp,
> +		    "tsc_timestamps should differ with different offsets");
> +
> +	/* Sleep to let time elapse, then restore vcpu0's clock */
> +	sleep(1);
> +	vcpu_ioctl(vcpus[0], KVM_SET_CLOCK_GUEST, &pvti0);
> +
> +	/* Run vcpu0 to process the clock update */
> +	run_vcpu_once(vcpus[0]);
> +
> +	/* GET_CLOCK_GUEST on vcpu1 =E2=80=94 should reflect the correction */
> +	ret =3D __vcpu_ioctl(vcpus[1], KVM_GET_CLOCK_GUEST, &pvti1_after);
> +	TEST_ASSERT(!ret, "GET_CLOCK_GUEST on vcpu1 after SET failed");

Please add proper APIs instead of copy+pasting the same code everywhere.  E=
.g.
this should really be something like

	vcpu_get_clock_guest(vcpus[1], ...);

where vcpu_ioctl() asserts success.
