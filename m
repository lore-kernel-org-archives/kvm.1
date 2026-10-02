Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD3471CF4
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932413; cv=none; b=CS2BwcHGcgIn9Shro0o2RMGVeyN/GStox3sYST3X+t3xRWLeVuTJduac8YQFxPtLgiq/UDTGIp13AiVL+WhXxB1eFeDKFcK8xRurebXrD62rqVpxpkdUI1fdDYxsuHYNXvB5C8vZqK5KEiJ9BI/QKwAAlXcbh6dI/ClHPD9agSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932413; c=relaxed/simple;
	bh=WcgE501MLFPAPQlIlWSN9FgewT3IHmG4n4Mp7JQZcUs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sQf047OxYzz0VLcY/fkY4qJJsS5QXtTZpbTFJhGxwqNIRZZht6jYbHJ8kGx88k1dcEsXZ/ZYZhePohZQ6A7NVBtcFHkGMqAgCcyvjPcDMR1n0/lQupaDdbH2IfFnd6Hb5VOeQ7+rTddJ6Nuduaouoq9Dpiyk8HyTToO0RZyY09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5mLk8n9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5mLk8n9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA23F1F00893;
	Fri,  2 Oct 2026 09:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932411;
	bh=IzdEFgBON/m72qvVCi7h7ai0NU3Yfpg0lhF0jBgLnZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P5mLk8n9ngJyejdfr7aYKFpj8JBgMxI1eEbgAF3OZP+HePT3Sd1rcXWExZl5Uur6x
	 XCHyp6is/4eVi71EJNIKTNMHhVI3qLHV3/vzyhpJqGS+WGi15jrrqqofV5ae5eCuh3
	 5J4laMAEQ98mos+QeOoj1HAv05M+5LG7W72QihYPAjncWDQSzEk0bJnkaYMlEOdnIz
	 8pnX8UCf3u+Ajnzv4Uf6KUXmJQUknhn0YgLjqhyjvkEa0ucqJpLtg0e7J9MDbNd/4y
	 NBTV7C5vm/5X9vs7ZJB8qZf9C5RxnXTdj07V35lGibbHLD1WJ/KSW8MgjS92HGdevA
	 r0//6N03OnM8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 14/23] KVM: selftests: Expose function to allocate
 vCPU stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lisa Wang" <wyihan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001-tdx-selftests-v15-14-7c62a5d8a992@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-14-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:31 +0000
Message-Id: <20261002091331.BA23F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests: replace descriptive X86_EFLAGS_FIXED macro with magic nu=
mber 0x2
--

commit 450df5680580dea1fd0ac5294cee549f78bbf604
Author: Sagi Shahar <sagis@google.com>

KVM: selftests: Expose function to allocate vCPU stack

This commit introduces kvm_allocate_vcpu_stack to handle vCPU stack
allocation separately. This is done in preparation for TDX, where
the vCPU stack address is a property of the specific boot code rather
than being initialized via the KVM_SET_REGS ioctl.

> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/test=
ing/selftests/kvm/lib/x86/processor.c
> index da430d4e7765f..4a753fb43007f 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c

[ ... ]

> @@ -864,8 +883,8 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, =
u32 vcpu_id)
> =20
>  	/* Setup guest general purpose registers */
>  	vcpu_regs_get(vcpu, &regs);
> -	regs.rflags =3D regs.rflags | X86_EFLAGS_FIXED;
> -	regs.rsp =3D vm_alloc_stack(vm, DEFAULT_STACK_PGS);
> +	regs.rflags =3D regs.rflags | 0x2;

[Severity: Low]
This isn't a bug, but was it intentional to replace the descriptive
X86_EFLAGS_FIXED macro with the magic number 0x2 here?

Using the macro helps document that this sets the mandatory fixed bit in
RFLAGS, maintaining code readability during vCPU register initialization.

> +	regs.rsp =3D kvm_allocate_vcpu_stack(vm);
>  	vcpu_regs_set(vcpu, &regs);
> =20
>  	/* Setup the MP state */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-tdx-selfte=
sts-v15-0-7c62a5d8a992@google.com?part=3D14
