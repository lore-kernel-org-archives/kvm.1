Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DAC338936
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780133861; cv=none; b=PvOvizWg3XFtLFWVP28v9YB1kPkCL8SeFDsn5FX0oLmRluqNDkYIRdhkB+jzokocXFgZXyZGV1tJZUunPfPfUexX+yB4a+gDfp3cGX3doGM5FNj0tsFwm8QCNFpGRUhIEjqNUlJ9F+rl4dfzjdvs2vndc+U3rDdz4TeWJsqHrjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780133861; c=relaxed/simple;
	bh=wILrgtDNTNSLhi3OrsZQGXwV5i7VxqmMt+VUoClE+Nc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Symw/8UhhMGGwMoHoxkwPjm+MYPVbA1NicoVtrY42QfheMXOJrLyiyxCnOFOKqtK+HMHteEuRs16Rr9H7wPfZESQI3oeVa1G1pvbwIyMtypP8F+1OztEbVz8yAyx0lW7r7l1isPAC8YShJCYwPjMKo5Qom6RZoEKkm6U6oSDXZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg0C//gT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg0C//gT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F0D1F00893;
	Sat, 30 May 2026 09:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780133859;
	bh=GrYRs93xjLlv46mu57hX6DsU0ZJXv/ItU0LGSmkEBEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eg0C//gTSIxX6o5kqmyleTtriGz4rIsRelPzKybmc3xcLfV5KWxr9wodVmkINCUYt
	 wXiwYbxL3E7q9xfsPQLDC/5p9sVc5U69O26gWkzd1JhepXUI2G7LTiPB5SXHDdD8K8
	 NoLT15t804mIWt517RUnpz+ziiAi5nKcquTKq2kWyH0aa4JDfFePbigg5Ut3xgPaxK
	 D7mCd+GiIQpVbrKGmbrD+U8P6lxYLkvU1GjqzjK4aS6SC/b4RLoG/uqGXaRuPy2KKo
	 OSh/AXPdd1FwvsilowkFCdlcn0wTnyYdacK4DT+eMbqLz4wiZHM2mstL3T8PtpQFAz
	 rTrx40PIa1lwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 27/27] KVM: s390: arm64: Enable KVM_ARM64 config and
 Kbuild
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-28-seiden@linux.ibm.com>
References: <20260529155050.2902245-28-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 09:37:39 +0000
Message-Id: <20260530093739.80F0D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The Makefile uses GNU Binutils incompatible flags `$(NM) -jU` and =
`$(OBJCOPY) -O default`, causing immediate build failures.
- [High] Compiling both `kvm-s390` and `kvm-arm64` causes fatal linker mult=
iple-definition errors when built-in, or duplicate-export failures when loa=
ded as modules.
--

commit 8f8fd4d3ea8855f34fafa2691472eea31e58dd4d
Author: Steffen Eiden <seiden@linux.ibm.com>
Subject: KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild

This commit adds the Kbuild/Makefile configurations to build a second
KVM module on s390 that implements the arm64-KVM API. It mangles internal
symbols in kvm-arm64 when compiled as built-in to prevent symbol conflicts
with kvm-s390.

> diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
> new file mode 100644
> index 0000000000000..d0aac34b8d2ff
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/Makefile

[ ... ]

> +ifeq ($(CONFIG_KVM_ARM64),m)
> +
> +kvm-arm64-y =3D $(kvm-arm64-obj)
> +
> +else ifeq ($(CONFIG_KVM_ARM64),y)

[Severity: High]
Does this bypass namespacing entirely when built as a module?

If localization is skipped, it seems both kvm-s390.ko and kvm-arm64.ko
will attempt to export identical KVM core symbols (such as kvm_init).
Will the kernel module loader refuse to load the second module due to
duplicate exports?

[ ... ]

> +quiet_cmd_nm_filter =3D NMFLTR  $@
> +	cmd_nm_filter =3D \
> +$(NM) -jU $< | awk '							\

[Severity: High]
Can these nm flags cause build failures on standard GCC/binutils s390x setu=
ps?

The -j (just symbol names) and -U flags appear to be LLVM extensions that
are not supported by standard GNU nm, which might result in an invalid opti=
on
error during standard kernel builds.

> +{	if (match($$0, /^__export_symbol_(.*)$$/, exp_sym)) {		\
> +		exp_syms[exp_sym[1]] =3D 1;				\
> +	} else {							\

[Severity: High]
By filtering out exported symbols from the localization list here, do the
exported functions remain globally visible?

If both KVM implementations are compiled into vmlinux, this looks like it
will cause fatal multiple definition linker errors since they both compile
their own copy of KVM core files.

[ ... ]

> +define rule_oc_o_o
> +	$(call cmd_and_savecmd,objcopy)
> +	$(call cmd,gen_objtooldep)
> +	$(call cmd,gen_symversions_o)
> +endef
> +
> +OBJCOPYFLAGS_kvm-namespaced.o :=3D -O default --localize-symbols=3D$(obj=
)/kvm_symbol_list

[Severity: High]
Is "-O default" supported by standard GNU objcopy?

Standard GNU objcopy does not recognize "default" as a valid BFD output
target (such as elf64-s390) and fails with an "invalid bfd target" error.
Could the -O flag be omitted entirely to retain the input format?

> +$(obj)/kvm-namespaced.o: $(obj)/kvm-unnamespaced.o $(obj)/kvm_symbol_lis=
t FORCE
> +	$(call if_changed_rule,oc_o_o)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D27
