Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49C42122E
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351731; cv=none; b=T8CtI1YSgdp5Z+4HmttsiMP1eM/7J4JE4EUbBRh06dKnNAudIZcP87OKNSNBLzPsGZcOmbMDOczkOX1F3DWIIeXDLDmIlu7XPD8j86k5aPgZEubuUCkU9QWEVQW5RWtp8Ke04F3TtZoCp2WoGIiNsQiPQQsUNRTRXFWoJMqHto4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351731; c=relaxed/simple;
	bh=SADSghC6V0in2b5nvz0peZCeFoDTgJ3tZAP7qtEX2VY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O51oZlpXKrdC+otZ2nFE/GjFvsXnqRxNSLfqkpg5fpxeynxzzqxXuJvqsxhZdPyS2y+pln0vCFAQaqmKmQAXRsCFa4ZNEci3cS/1DJkilJTQ73LQe0R1MxnhlBvlswG7KTqvqVsBVXr1iBhue6sdXhYi9bl2sL7JTt/31LOBYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7mu2udj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7mu2udj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865E61F00A3E;
	Wed,  2 Sep 2026 12:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788351729;
	bh=oywu5JlZN/nW9DH3LKPP3HJknMkoG8YT4h/BjWGj2a4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S7mu2udj6HgGIuaU6sv0OsV2f3blbtXn9NdHwBIA7qXUHamg04SoxdVmo5DT5E4sl
	 AaY+fAzJUnqOk+Gv10mYs79FuUNwlXbly6c+iC0nFumGW66+zkydXSD6oKy9BcvwQ0
	 jqLud4ZmyybYB2EDcYkxz5B6QFH4VIJ2KMDxOkoKaoZONW/yEIr8SbNe/UwdhPHm9k
	 HY1PfKC/rlWfTPbiZIC7rAibs9DY55rZqS+YC4clwIOzep3UJPBHsSq76mh3dyfNup
	 PQHAX0Z64FArkNJ2IWF48lxjGk0LEe7Fy0RbwXkt01oTyg0Pkq0QN+ZoraZX4vkqS4
	 89Ontr+TptTFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: selftests: Actually compare sregs and events
 in sync_regs_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902120235.18486-2-hemanth.selam@gmail.com>
References: <20260902120235.18486-1-hemanth.selam@gmail.com>
 <20260902120235.18486-2-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 12:22:09 +0000
Message-Id: <20260902122209.865E61F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] KVM's `__get_sregs` does not zero-initialize the `interrupt_bitmap=
` array, leading to stale interrupt state remaining persistently visible to=
 userspace in the memory-mapped `kvm_run` structure.
--

commit fa07ac80146018f01ced6cfdfcb90c42aec2c65c
Author: Hemanth Selam <hemanth.selam@gmail.com>

KVM: selftests: Actually compare sregs and events in sync_regs_test

This commit populates compare_sregs() and compare_vcpu_events() to verify
all fields of struct kvm_sregs and struct kvm_vcpu_events. Previously,
these functions were empty, meaning the tests only verified general purpose
registers after each KVM_RUN.

> diff --git a/tools/testing/selftests/kvm/x86/sync_regs_test.c b/tools/tes=
ting/selftests/kvm/x86/sync_regs_test.c
> index ed0c21b427c90..c7d1f3cca16e4 100644
> --- a/tools/testing/selftests/kvm/x86/sync_regs_test.c
> +++ b/tools/testing/selftests/kvm/x86/sync_regs_test.c
[ ... ]
> @@ -70,13 +70,102 @@ static void compare_regs(struct kvm_regs *left, stru=
ct kvm_regs *right)
[ ... ]
> +	SREG_COMPARE(efer);
> +	SREG_COMPARE(apic_base);
> +#undef SREG_COMPARE
> +	TEST_ASSERT(!memcmp(left->interrupt_bitmap, right->interrupt_bitmap,
> +			    sizeof(left->interrupt_bitmap)),
> +		    "interrupt_bitmap values did not match");

[Severity: High]
This is a pre-existing issue, but does this new assertion trigger test
failures due to how __get_sregs() handles the interrupt_bitmap?

Looking at __get_sregs() in arch/x86/kvm/regs.c:

	if (vcpu->arch.interrupt.injected && !vcpu->arch.interrupt.soft)
		set_bit(vcpu->arch.interrupt.nr,
			(unsigned long *)sregs->interrupt_bitmap);

This function sets the bit corresponding to the currently injected interrupt
but never clears the prior contents of the array.

If userspace relies on KVM_SYNC_X86_SREGS to capture guest state, KVM copies
the sregs state to run->s.regs.sregs via kvm_run_sync_regs_to_user().

Because run->s.regs.sregs is in the user-mapped kvm_run structure and is
not zero-initialized by the kernel on each sync, it continuously accumulates
injected interrupts or retains stale data placed there by userspace.

Could this lead to spurious interrupt injections or corrupted state during
live migration for any VMM using the KVM_SYNC_X86_SREGS API?

>  }
> =20
>  static void compare_vcpu_events(struct kvm_vcpu_events *left,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902120235.1848=
6-1-hemanth.selam@gmail.com?part=3D1
