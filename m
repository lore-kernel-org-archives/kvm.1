Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D74D4766AB;
	Sun, 20 Sep 2026 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941104; cv=none; b=ZVb/UxwWaxv3WwIZRQjlVw+rSNNmCabPvevpHbutG8nzApqRpZ8de4eBkMD00gi/OV4nUnzlFih/hEVhK5Bq+cSgj1dNNaXJPJxw7KfrM5lvgkNe91dTCBhO+Se27ueeXZR+/a078DhApOLnnkuCA4IWjuuXKP5iNPGAhGJwxVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941104; c=relaxed/simple;
	bh=8lrFdJCK0hP8tBo0/L0O4KfvrChkLlA/DsFw5acZxJo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GBrrdXgr5yntaBJKHb4anHn+fgopTOePQojPxOzb56m7jcvmq5FLUJfKRroYhJdZ+rGCz5tzE6S4afyiNMuhakPD9B94bZV7OGbozWX2llU/Z5PxtKXVjFdGAu0pTOGn8DlH52/F6RnYj6fqMXBL3+HU1geDgmCzyKZ4tmFNtes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gct7GEXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gct7GEXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BA41F000FF;
	Sun, 20 Sep 2026 21:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789941089;
	bh=NYfVHbiVNvz5mJ9infrMi9C+SgVaLYLdUDj7Xrq5Dyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gct7GEXD93mrnkmTFRyk+sVwHdnuOmN8MziPrdc4JNxemykIPljggkOouDnHCOHIl
	 7+qQPYBPm3m5LOglXdcjIAwlS08fYw5O8E9gZX6zbF6upxiok75c63fE0z3/PZQj7i
	 SLF2orq/aPyW0PcGmw5gSD+capVJoODExiClzuZCPXK4jjEHJtRTJxQ2gmCecOun+q
	 /iNH/sK2FFBEQsmToasQSyBSUaYJFKOpi1OM3Pm6bt1OjUA/o1OQ6LBL3YQ2KmXh/S
	 9yaxhkYyvQKUSWIbn47CpajuklBZOF2evk+Xed7CaXQTZ5Hz7iIiP+5LDRcsiLD6kC
	 o/87O0qVsDoxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/17] KVM: selftests: Add nested VMX APIC cache
 invalidation test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260920211920.928306-13-dwmw2@infradead.org>
References: <20260920211920.928306-1-dwmw2@infradead.org>
 <20260920211920.928306-13-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 21:51:28 +0000
Message-Id: <20260920215129.03BA41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: selftests: test randomly fails on KVM_EXIT_INTERNAL_ERROR
--

commit 9c12532066400c0055054c635c5df9f04407d1a2
Author: Fred Griffoul <fgriffo@amazon.co.uk>

KVM: selftests: Add nested VMX APIC cache invalidation test

Introduce selftest to verify nested VMX APIC virtualization page cache
invalidation and refresh mechanisms for pfncache implementation.

> diff --git a/tools/testing/selftests/kvm/x86/vmx_apic_update_test.c b/too=
ls/testing/selftests/kvm/x86/vmx_apic_update_test.c
> new file mode 100644
> index 0000000000000..8dd15c92fa906
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/vmx_apic_update_test.c
[ ... ]
> +static void l1_guest_code(struct vmx_pages *vmx_pages)
> +{
[ ... ]
> +again:
> +	exit_reason =3D vmreadz(VM_EXIT_REASON);
> +	if (exit_reason =3D=3D EXIT_REASON_APIC_ACCESS) {
> +		uint64_t guest_rip =3D vmreadz(GUEST_RIP);
> +		uint64_t instr_len =3D vmreadz(VM_EXIT_INSTRUCTION_LEN);
> +
> +		vmwrite(GUEST_RIP, guest_rip + instr_len);
> +		GUEST_ASSERT(!vmresume());

[Severity: Medium]
If the VAPIC_SLOT memslot is moved asynchronously and leaves the VAPIC_GPA
unbacked just prior to this VMRESUME call, will KVM treat the unbacked
APIC access page at VM-entry as a misconfiguration and exit to userspace
with KVM_EXIT_INTERNAL_ERROR?

> +		goto again;
> +	}
[ ... ]
> +static void *update_move_memslot(void *arg)
> +{
> +	struct update_control *ctrl =3D arg;
> +	uint64_t gpa =3D VAPIC_GPA;
> +
> +	wait_for_start_signal(ctrl);
> +
> +	while (is_running(ctrl)) {
> +		usleep(update_period_ms * 1000);
> +		gpa +=3D 0x10000;
> +		vm_mem_region_move(ctrl->vm, VAPIC_SLOT, gpa);

[Severity: Medium]
Does this background memslot move leave the VAPIC_GPA unbacked precisely
when L1 is about to execute VMRESUME?

> +		ctrl->updates++;
> +	}
> +
> +	return NULL;
> +}
[ ... ]
> +static void run(void * (*update)(void *), const char *name)
> +{
[ ... ]
> +	while (!done) {
> +		vcpu_run(vcpu);
> +
> +		switch (vcpu->run->exit_reason) {
[ ... ]
> +		default:
> +			TEST_FAIL("%s: Unexpected exit reason: %d (flags 0x%x)",
> +				  progname,
> +				  vcpu->run->exit_reason, vcpu->run->flags);

[Severity: Medium]
Does this unconditionally fail the test if it encounters the resulting
KVM_EXIT_INTERNAL_ERROR?

If update_move_memslot() occasionally leaves the VAPIC_GPA unbacked
precisely while L1 handles an EXIT_REASON_APIC_ACCESS, the resulting
KVM_EXIT_INTERNAL_ERROR will cause this test to fail randomly in
CI environments.

> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920211920.9283=
06-1-dwmw2@infradead.org?part=3D12
