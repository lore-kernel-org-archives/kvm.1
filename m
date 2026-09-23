Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BAF47A88C
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174227; cv=none; b=OsFfwhtuRfOfMvSs68mSTDRt+PZQfQOXSP3OY/8d34+dhKXodX4kot+fr1PeUomedTF0u6n3vkKlEzoA535gALbaqicF2gnTsx+sXwzeU4XyTmIcqB6QZTeGrnY8OVSCI7M1j7URjYfgDLPYB100BdFsBMj31tfWNgw2zDDmfb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174227; c=relaxed/simple;
	bh=k0ZbofIBkT01/yCpDZCuFZA8fyg/b51+Hx0Fsia20Bg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fWW9Lk9E+Im1R5DJLo4RaiP4rfSmnZrm+Wr9wJ4VB7mHNSzPL6q6VDUhgce/jGll7xmL//aAy5sBXHpJAsMHj6hQAg3FCTOTHuAsCMKmfG3XBlD2hA4tY+E8RyMsuNnw1KJJIyYLouaypKDgGEzLc5e3V2JeolU5LgIFKXUjURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d69TI7Xg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d69TI7Xg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E50A1F000FF;
	Wed, 23 Sep 2026 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790174226;
	bh=UDZgslO+q/yeDwlhPBtTUrbr44Yo+ilsJvPBOIdZNqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d69TI7XgV9jQ/xrvsq1G5RbbCi+bkL+7AnkVSaQ3uB9Y7ga7za0psG8XPkVX8a/9z
	 m26wycArd/5esAwBpwh9pT6Bc2Ff4LjzQCCnWvPwxV94YMKQ2tPEHi342K4OybHGwU
	 6GHC8vpy7r7cwdw08v8J5mIwCc1B6mh7cPR10eu/DjkQQA8RvPTIPQtW+s86SY4siK
	 /MJmj5V+AHgq6Fsgmuq4u7QfBvoeygdD7F9lw5gt/jmfO5TdJjDvUsitqckaudrhY1
	 tk8AfWoSWGf9mqxSYT5g9P18aXic3nEv1SNEXYCCSJXvxzpyJT1NjAbj+HDgatixo5
	 Qlg77u5i4pXsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 8/8] KVM: selftests: Add nested SVM DecodeAssists
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <b16dc4ca74d0337c5535813d48f5ea206b3d5a87.1790171702.git.zhang_wei@open-hieco.net>
References: <cover.1790171702.git.zhang_wei@open-hieco.net>
 <b16dc4ca74d0337c5535813d48f5ea206b3d5a87.1790171702.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 14:37:06 +0000
Message-Id: <20260923143706.7E50A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kvm: selftests: missing .global directive on inline assembly labels=
 causes LTO link error
--

commit 08e87505d5c0bae297f7e3e768c2e12a61d10322
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: selftests: Add nested SVM DecodeAssists test

This commit adds a nested SVM selftest to verify KVM's virtualization of
DecodeAssists. It covers instruction byte extraction for various instructio=
ns
and edge cases such as synthesized nested page faults and userspace-injected
page faults.

> diff --git a/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_te=
st.c b/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c
> new file mode 100644
> index 0000000000000..aba91d8bb1a28
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c
> @@ -0,0 +1,590 @@

[ ... ]

> +extern u8 l2_movsb_insn[];
> +
> +static void l2_movsb_code(void)
> +{
> +	asm volatile("mov %0, %%rsi\n\t"
> +		     "mov %1, %%rdi\n\t"
> +		     "l2_movsb_insn:\n\t"

[Severity: Low]
Is a .global (or .globl) directive needed for this assembly label?=20

When building the selftests with Link-Time Optimization (LTO) enabled, the=
=20
l2_movsb_code function and the functions referencing the extern l2_movsb_in=
sn=20
array (like test_synthesized_npf_after_hardware_npf) might be partitioned=20
into different LTRANS units.=20

Since this label lacks a global directive, it remains strictly local to its=
=20
inline assembly block's partition. The linker therefore cannot resolve the=
=20
extern declaration in other partitions, causing an undefined reference buil=
d=20
error.

> +		     "movsb"
> +		     : : "r"(&mmio_source), "r"(&npf_target)
> +		     : "rsi", "rdi", "memory");
> +	GUEST_FAIL("L2 MOVSB did not cause a nested page fault");
> +}
> +
> +extern u8 l2_userspace_pf_insn[];
> +
> +static void l2_userspace_pf_code(void)
> +{
> +	asm volatile("movzbl (%0), %%eax\n\t"
> +		     "l2_userspace_pf_insn:\n\t"

[Severity: Low]
Does this label also need a .global directive to prevent LTO linkage failur=
es,=20
similar to the l2_movsb_insn label above?

> +		     "nop"
> +		     : : "r"(&mmio_source) : "rax", "memory");
> +	GUEST_FAIL("Userspace-injected #PF was not intercepted by L1");
> +}
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790171702.gi=
t.zhang_wei@open-hieco.net?part=3D8
