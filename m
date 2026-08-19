Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF5B3C5827
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119888; cv=none; b=cTWKHb06MC8UDqezySSzOFXih1HYuRHOLn/lNgaaGBdu8fmGHClshJNLTF9OVQAxNNcJ91gKBgt1WDyEIMY8YX9uk59r9w2o+KR8DLg42eoIYeT+ZMoyVWZHJddTCZ0chZ9C9ySlscE20TjCoyqyhHu0IKu+8PsKMozEG4KnSRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119888; c=relaxed/simple;
	bh=mhxz/hJMvCAjxYYnmTu5pBVMeuXKv3IxzBGJb/lpcKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nHF2fd7VrGwenngtfn/HYSV0EAXdGuDyRPmiwAR8W0Jyp4P2l3wI+Jo8hjg62XFjrOFVGWTRfkFplxjDqjnx2KuF75PL+WRS8CJQnWbwr2LEbnQfW9+0rIwNYfFjlNqmQNoq6eMyVyWwuUmMkDOGncBxwX8ob8n8Ql21JH6Z6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNJ17Jhh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNJ17Jhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E84C1F000E9;
	Wed, 19 Aug 2026 06:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787119887;
	bh=Bx4tnsKVcwZsOBJXSkQHw66XyPsT3LZ4+Sc6+gUYc3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gNJ17JhhQ5hkH7CqNCcPu7XcQ5qxEhYZ6CyqG4h5f1aW436guSsWht2lN8DDKNgIS
	 3j9LGYW9Sb8CkgeY3nz82E0xJZVEbhmiMYGoGwGUWZN/5+0jHwhcagUDEEdgT44iaE
	 2wWj887FZiwOwmzX1pc2JD73g8yCZQtHM5iMJFQHzRAS+jJZsJjxhm6s90QwxCSlAb
	 9zOxjUinUcezJocsL/JX6G1QhgbO70I7P/+UJn5Mb/uaNQpyq+wcOUdMMBM/POkMYw
	 s8k+yFj8nCI1bxn4bu1pTn1XTfFUx/U4Fe94EikZUt0C8BgbuSA0mpMU8+OETh5e+2
	 JhpZGmLBFc4rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] KVM: x86: Track emulator-originated nested #PF
 VM-Exits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <e1860aaffc3a07d289dd083d2f3dd37b4d4bcc9c.1787116250.git.zhang_wei@open-hieco.net>
References: <cover.1787116250.git.zhang_wei@open-hieco.net>
 <e1860aaffc3a07d289dd083d2f3dd37b4d4bcc9c.1787116250.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:11:26 +0000
Message-Id: <20260819061127.0E84C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly added `has_emulator_context` field is left uninitializ=
ed or improperly cleared when queueing non-nested exceptions and restoring =
state from userspace.
- [Low] The `has_emulator_context` field is populated but never read anywhe=
re in the codebase.
--

--- Patch [5]: [PATCH v4 5/9] KVM: x86: Track emulator-originated nested #P=
F VM-Exits ---
commit 224b6e38736ada4f6f56c322ba1950bffe0ab244
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: x86: Track emulator-originated nested #PF VM-Exits

Add has_emulator_context to kvm_queued_exception to record whether a
queued exception VM-Exit originated from the current emulator exception.

> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 283847619ff88..eb9f1b9afeb7d 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -688,6 +688,7 @@ struct kvm_queued_exception {
>  	bool pending;
>  	bool injected;
>  	bool has_error_code;
> +	bool has_emulator_context;

[Severity: Low]
Does this code ever read the newly added has_emulator_context field? It
looks like it is populated here and throughout the exception queueing paths,
but is never actually consumed.

>  	u8 vector;
>  	u32 error_code;
>  	unsigned long payload;

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d94b59140c452..75d00340c71fa 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -473,7 +476,8 @@ static void kvm_multiple_exception(struct kvm_vcpu *v=
cpu, unsigned int nr,
>  	if (is_guest_mode(vcpu) &&
>  	    kvm_nested_call(is_exception_vmexit)(vcpu, nr, error_code)) {
>  		kvm_queue_exception_vmexit(vcpu, nr, has_error, error_code,
> -					   has_payload, payload);
> +					   has_payload, payload,
> +					   has_emulator_context);
>  		return;
>  	}

[Severity: Medium]
Is it possible to leave the has_emulator_context field uninitialized here?

Looking at the rest of kvm_multiple_exception(), the new has_emulator_conte=
xt
parameter is passed in, but it isn't assigned to the vcpu exception state in
the normal queue path:

    if (!vcpu->arch.exception.pending && !vcpu->arch.exception.injected) {
    queue:
        vcpu->arch.exception.pending =3D true;
        ...
        vcpu->arch.exception.has_payload =3D has_payload;
        vcpu->arch.exception.payload =3D payload;
        return;
    }

Could this result in leaking stale state for has_emulator_context?

Furthermore, does this flag also need to be explicitly cleared in
kvm_vcpu_ioctl_x86_set_vcpu_events() when restoring exception state from
userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787116250.gi=
t.zhang_wei@open-hieco.net?part=3D5
