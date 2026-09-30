Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC2244667
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728281; cv=none; b=ebpY+qsgumDLlLa+nyPpq6sHyIqxwJWSCVYvW3zFDISvirpsA9qCYVQMmPCK/modLJSJekyxKrt/ddXGVjKe7Nio1pwuvqCg2AAHHCENCUrwTlg0zZBbfDSsYO+EXU1M2U0QXItVE2ZL3Pf3rblMsbqPlx6u3EGYwmgfn/PqEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728281; c=relaxed/simple;
	bh=fwU2xGm0fOP4M9PWft4gM/p3oSNJrr/vtk7ValJcvjo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m9XHHALET02y4tsFYPROTiJs973+tXNnZtfZPZ6wRZlbYLUh3rhtmW0od2JkpEe1mCFSrdjRKjaMZ4OimFx1nmlxQcaC0+CYxBsM0BTsAylVJuaNX08gdegKdrJ4JW1uhzIjM47ScpcXhvO+0at0XkUpabew8adsr0Js9wkaIck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3SeRK7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3SeRK7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC101F000FF;
	Wed, 30 Sep 2026 00:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790728280;
	bh=Lj2sNPrBlbiQWA3MSuqqOJRheGi1DFrXG3MYhu0PMMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X3SeRK7O5XqQ2zRBMQidjejH6HNngx+5TFeYQlqsnY4zFGMTlJ0zYft/x1YoBcTST
	 Iw1NqELrbNxqLwhPntJrnlTTvSTZZfHkn1oLa72UCPpogyoogJQ1lLBBXpwEJEB5hr
	 /Jo4mpJol1t7brLmMmJ2viV30f9xiUa+xIoCxaCjxKRes77msLv6f1jY+hRqEXynxg
	 cvOHAXX7644qeQjO6lDOHCPT77GsWvkIfXVAQ7hX6df1yCFzkXCAeXaihG41M5eWc7
	 Q/3ilQh3zKXr+CFBylipw4Z5yvK5Dh17RaRp71uDCzw58uFNh9Gu+ryGb9e0fvEUfa
	 ulB3PM2sjYO6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] KVM: selftests: Add module param API to check if
 nested virtualization is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930002140.3174449-5-seanjc@google.com>
References: <20260930002140.3174449-1-seanjc@google.com>
 <20260930002140.3174449-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 00:31:19 +0000
Message-Id: <20260930003120.1DC101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] kvm: selftests: kvm_is_nested_virtualization_enabled() aborts on=
 Intel
- [Low] kvm: selftests: get_common_kvm_vendor_param_bool() returns int inst=
ead of bool
--

commit 680296c2620e4e5c37fadd1bdce211406dcc250c
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Add module param API to check if nested virtualization is e=
nabled
   =20
Add an API to check if the nested virtualization module param is enabled,
e.g. so that tests can verify KVM's own enumeration of the corresponding
CPU feature. Provide a big warning above the API to make it as obvious as
possible clear that tests should use "kvm_cpu_has(X86_FEATURE_VMX) ||
kvm_cpu_has(X86_FEATURE_SVM)" when checking for nested virtualization.

Link: https://lore.kernel.org/all/20260910115414.3015260-2-ewanhai-oc@zhaox=
in.com

> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/=
testing/selftests/kvm/include/x86/processor.h
> index 6e6f70035508a..1608ddb91b6e6 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -1429,6 +1429,14 @@ static inline bool get_kvm_amd_param_bool(const ch=
ar *param)
>  	return kvm_get_module_param_bool("kvm_amd", param);
>  }
> =20
> +static inline int get_common_kvm_vendor_param_bool(const char *param)

[Severity: Low]
Does this function have a type mismatch? It evaluates vendor-specific boole=
an
parameter helpers, but returns an int instead of a bool.

> +{
> +	if (host_cpu_is_intel)
> +		return get_kvm_intel_param_bool(param);
> +
> +	return get_kvm_amd_param_bool(param);
> +}

[ ... ]

> @@ -1472,6 +1485,16 @@ static inline bool kvm_is_lbrv_enabled(void)
>  	return !!get_kvm_amd_param_integer("lbrv");
>  }
> =20
> +/*
> + * Do NOT use this to check for nVMX or nSVM support.  Querying kvm_cpu_=
has()
> + * for either of X86_FEATURE_{VMX,SVM} is the idiomatic way to check for=
 nested
> + * virtualization support.  Use this *only* to validate KVM's own enumer=
ation.
> + */
> +static inline bool kvm_is_nested_virtualization_enabled(void)
> +{
> +	return get_common_kvm_vendor_param_integer("nested");

[Severity: Medium]
Will this unconditionally abort the test suite on Intel hosts?

The VMX "nested" module parameter is a boolean exposed via sysfs as "Y\n" or
"N\n". If this helper uses the integer reader on Intel, it will read "Y\n"
and pass "Y" directly to atoi_paranoid(), which throws a TEST_ASSERT because
strtol() fails to parse "Y" as an integer:

tools/testing/selftests/kvm/lib/test_util.c:atoi_paranoid() {
    ...
    TEST_ASSERT(num_str !=3D end_ptr,
                "strtol(\"%s\") didn't find a valid integer.", num_str);
    ...
}

> +}
> +
>  u64 *vm_get_pte(struct kvm_vm *vm, gva_t gva);
> =20
>  u64 kvm_hypercall(u64 nr, u64 a0, u64 a1, u64 a2, u64 a3);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930002140.3174=
449-1-seanjc@google.com?part=3D4
