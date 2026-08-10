Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1381B357702
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786343592; cv=none; b=RZJZ9oN68itj8pgvkXhtsCpfSGudKDdLfw9ULcILd3iJwg/PPxCilfrCHwN9QYgg8322N+70NVPWIy/LvoxdJEAQsSMN5EulCel/l72ROaONOJhAan23vvwv/QdP91zJHC17Og0JJ40d1EWQti5VMm1M8cYNJmMWftXR/adc3xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786343592; c=relaxed/simple;
	bh=qbFM5oj8554Dgejb2mymwFlL3h32rAdZ9nr+5aQEfEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vvfou8wq/3Tsa9sfFwivpareaPPEaj31AEk5wd4BmyXGX4njy0NsI5fr3eHzDFdqm8lxmyyCJxXoR0LDhDFMl1ehSqkRw2TOtHuB0CnhoOMOshCBYyeRGj0vOyfyxC6WFik+/7T5v8gK8cF1N8Q4P23M01lWSOy27Ezn3h0zsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlgHuJXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlgHuJXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F81B1F000E9;
	Mon, 10 Aug 2026 06:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786343590;
	bh=3kHhKLLfaCOKAjEgnRoTkxOpQe6bwTtNeB1xKakjCV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hlgHuJXN4oBlOL42DKWst1vkHo5b9ENMQglTs+5fJX/LlHlxnDzWzxTfj5mWQF5c3
	 xmlvKOh9vZDXfZMdRDAXlwqDJMspkP2ckHFLoa9iJ4nuhPOZOB/HIrbpKnTbzOr/IJ
	 OXkEb6nOOLSjHkTI9nJUU91j03lPfEPruZLVt5ZPNe26pc6pNWnPcgHlp6CQd6d7xr
	 AJeyAj12fRm73C1INERAH0mM74nZQXLCHIIA1PaB6DMembkmz19W7hNk4R/QedRkzV
	 xBLyiBW7FELyttD2qGAnUfr7/Vd5XjEPk5h/uSity4Losgx+uEgWqr4/Heysxr7YZe
	 pLkpicOeMYzxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: selftests: Verify failed IOAPIC delivery
 preserves state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Zhang" <hao_zhang_kdev@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <anluERKCXkZglDEe@192.168.1.215>
References: <anluERKCXkZglDEe@192.168.1.215>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 06:33:10 +0000
Message-Id: <20260810063310.8F81B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Uninitialized `struct kvm_irqchip` passed to `KVM_GET_IRQCHIP` i=
octl leaks stack memory to the kernel, triggering memory sanitizer errors.
--

--- Patch [2]: [PATCH v2 2/2] KVM: selftests: Verify failed IOAPIC delivery=
 preserves state ---
commit bdb3cd0c37699df03cd34fd3d221e67589076c39
Author: Hao Zhang <zhanghao1@kylinos.cn>

KVM: selftests: Verify failed IOAPIC delivery preserves state

This commit adds regression coverage for I/O APIC interrupt delivery when no
local APIC can accept the interrupt. It verifies that failed delivery behav=
es
correctly for both level-triggered and edge-triggered interrupts.

> diff --git a/tools/testing/selftests/kvm/x86/ioapic_state_test.c b/tools/=
testing/selftests/kvm/x86/ioapic_state_test.c
> new file mode 100644
> index 0000000000000..3613a67f4b217
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/ioapic_state_test.c
[ ... ]
> +static void set_undeliverable_ioapic_entry(struct kvm_vm *vm,
> +					   bool level_triggered)
> +{
> +	struct kvm_irqchip irqchip;
> +
> +	get_ioapic(vm, &irqchip);

[Severity: Medium]
Will this leak uninitialized stack memory to the kernel?

Since KVM_GET_IRQCHIP is defined as _IOWR, the kernel uses memdup_user() to
copy the entire struct kvm_irqchip from userspace. Because the struct conta=
ins
a 512-byte union and is declared uninitialized on the stack, passing it to =
the
kernel will trigger memory sanitizer or Valgrind errors during testing.

Could this be zero-initialized?

[ ... ]
> +static void test_no_remote_irr_for_undelivered_interrupt(void)
> +{
> +	struct kvm_irq_level irq =3D {
> +		.irq =3D TEST_IOAPIC_PIN,
> +		.level =3D 1,
> +	};
> +	struct kvm_irqchip irqchip;
> +	struct kvm_vm *vm;
> +
> +	vm =3D vm_create_barebones();
> +	vm_create_irqchip(vm);
> +
> +	set_undeliverable_ioapic_entry(vm, true);
> +
> +	vm_ioctl(vm, KVM_IRQ_LINE_STATUS, &irq);
> +	TEST_ASSERT(irq.status =3D=3D -1,
> +		    "Expected failed interrupt delivery, got %d", irq.status);
> +
> +	get_ioapic(vm, &irqchip);

[Severity: Medium]
Does this struct also need to be zero-initialized to prevent memory
sanitizer errors when calling the KVM_GET_IRQCHIP ioctl?

[ ... ]
> +static void test_undelivered_edge_interrupt_stays_pending(void)
> +{
> +	struct kvm_irq_level irq =3D {
> +		.irq =3D TEST_IOAPIC_PIN,
> +		.level =3D 1,
> +	};
> +	struct kvm_irqchip irqchip;
> +	struct kvm_vm *vm;
> +
> +	vm =3D vm_create_barebones();
> +	vm_create_irqchip(vm);
> +
> +	set_undeliverable_ioapic_entry(vm, false);
> +
> +	vm_ioctl(vm, KVM_IRQ_LINE_STATUS, &irq);
> +	TEST_ASSERT(irq.status =3D=3D -1,
> +		    "Expected failed interrupt delivery, got %d", irq.status);
> +
> +	get_ioapic(vm, &irqchip);

[Severity: Medium]
Does this uninitialized struct also need to be zero-initialized for the
same reason?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/anls-aUppuiFolpS@19=
2.168.1.215?part=3D2
