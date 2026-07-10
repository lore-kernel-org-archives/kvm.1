Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8D123ED5B
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691594; cv=none; b=WPpN+iewRGIDRQa5oRCfZNSFOMRBBBol5Fnbv9CLGehDKwMsT+e3EAARh+NGRELNE+mCscFarqcbf08CiIOu8NQO2oBhYk/xQGcXahB5/943f75kqiut8Tra2ZkLiP46XaF2pYFFTsJP+HeZEGTEIG1zwo9+eif8A169BWLXjxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691594; c=relaxed/simple;
	bh=+XOxogbpCWummPUfmXZng9p0tQ0BqwQficZ2tq4Zp2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hZowGqVO8tYzzVnai1aqTRkZDSOBlzPnqPDzKlxWhe4XrKMKXVUeErR0FKZjP/YKeKMSOyTNUJvk0qCOjXr6ZhbrBRdpuvgIaKwiq6rDpTBVe1N7JqACOOuvju6wnIPQASiEG/Xk6tew7+ZHT1fuhXsRrzfHznZIT3HWBHrHMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfvPyTFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfvPyTFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD74F1F000E9;
	Fri, 10 Jul 2026 13:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691592;
	bh=gL88hcWRMhZaHiNtCJRYwVeobOruB6y/EfiLI3RU7+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bfvPyTFuZMzNWLQ5tXu0sVhwbmERJ3+pWwSW9qW5ppsuCz0b2+HsIOmj/kGumPtyq
	 EEt7k4HjXboOigBdUsqJHhPH3QgiiMmV4gsw1wPRBpCmQgoUHgM68XTgKoAcRuU1Kb
	 +5x/LBp6dfFznWkf4gSvvtWdAfM2vKlSjOhfLG00CJmKJjMJ+afimPcdsEclZYhW+P
	 5DpBe0DTsMQSt333PGwQ7qPFl8TGdrjcKPven8h4lqqPB9gBKFFaEo1tQTCjTKGpnh
	 GZjeVQxX+9Y4Yxmj0WkfUJScVPyhYjmU1i9YueiH7sgHg2vghBvz1xT2asUKxakxUq
	 lgpz1En5WYg8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86: Fix null pointer dereference in
 trace_kvm_inj_exception
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Paziyski" <danielpaziyski@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260710134055.16432-1-danielpaziyski@gmail.com>
References: <20260710134055.16432-1-danielpaziyski@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 13:53:12 +0000
Message-Id: <20260710135312.AD74F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The proposed fix is based on a false premise. The commit message=
 incorrectly claims the original code causes a kernel NULL pointer derefere=
nce, but the original code safely handled the empty struct.
- [Low] Removing the variadic argument from the `__print_symbolic` macro ca=
uses a syntax error during macro expansion, which unconditionally breaks th=
e kernel build.
--

--- Patch [1]: [PATCH] KVM: x86: Fix null pointer dereference in trace_kvm_=
inj_exception ---
commit ed0cb139106d0eebc245569ae242561a63dc2bb7
Author: Daniel Paziyski <danielpaziyski@gmail.com>

KVM: x86: Fix null pointer dereference in trace_kvm_inj_exception

This patch modifies the kvm_inj_exception tracepoint to remove an empty
struct passed to __print_symbolic for formatting the exception error code.

> An empty struct is being passed, which makes the
> kernel derefence a NULL pointer when the error code is 0. Remove this
> stray struct in the invocation of __print_symbolic.

[Severity: Medium]
Is this description of a null pointer dereference accurate?

Looking at how __print_symbolic expands, the empty struct { } safely
initializes the first element's name pointer to NULL. When
trace_print_symbols_seq() is called, it handles this gracefully:

kernel/trace/trace_output.c:trace_print_symbols_seq() {
    ...
    for (i =3D 0;  symbol_array[i].name; i++) {
    ...
}

Since the name field is NULL for the first element, the loop is bypassed
entirely and the function safely falls back to printing the error code as a
hex string without dereferencing a NULL pointer.

> diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> --- a/arch/x86/kvm/trace.h
> +++ b/arch/x86/kvm/trace.h
> @@ -490,7 +490,7 @@ TRACE_EVENT(kvm_inj_exception,
>  	TP_printk("%s%s%s%s%s",
>  		  __print_symbolic(__entry->exception, kvm_trace_sym_exc),
>  		  !__entry->has_error ? "" : " (",
> -		  !__entry->has_error ? "" : __print_symbolic(__entry->error_code, { }=
),
> +		  !__entry->has_error ? "" : __print_symbolic(__entry->error_code),

[Severity: Low]
Will this change break the kernel build?

The __print_symbolic macro expects a symbol_array as the second argument. By
omitting it, the preprocessor will expand the macro to something similar to:

static const struct trace_print_flags symbols[] =3D { , { -1, NULL }};

Does this result in a syntax error during macro expansion due to the missing
expression before the comma?

>  		  !__entry->has_error ? "" : ")",
>  		  __entry->reinjected ? " [reinjected]" : "")
>  );

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710134055.1643=
2-1-danielpaziyski@gmail.com?part=3D1
