Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7F39CD0C
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425227; cv=pass; b=NApk9MMN4Stna8rS6A1AzzaD9IXw5xgIQzwmy51PDj8GctTApoCkxv2skHh6Y1DRmyvt4CZJ6nnK2eeNwa9pbhdC9EO8mV0lT3moJs8nwYHx5XnMHYIJJTTFcDWA/M/BUWc+oPgONpB6dDP5LlRAavrik1lcdNGKryaAAcG901s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425227; c=relaxed/simple;
	bh=RErsm8IuxjqeMbKnZnpM9fWpr2T2HyUPVGa44TsRw5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUf1yxSomrme3sYvuH53Gb7AoOSIR5k19s4/EZNeDqN3Dv+y8XTVAq1+/FpY9LOIE5VYfuhLVU8KmAscxkU5D3/2eWdreHI+9dIL98LFiJ0h7g1i8NJkAcJIaHGooONhH3M0gW9wePceq8v9VolEUIWJ59vFMpi0rXfc2iUOfPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vu2PqzsO; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vu2PqzsO"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a613a6bcd8so895a12.0
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 15:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789425224; cv=none;
        d=google.com; s=arc-20260327;
        b=MQzvpjn5UHMv0wEdto0MPvhNV9zo1lCbAcZcbL4R+C95Tz826tPj2TMP/FAF3Ex2uJ
         v8k726gUS7c+/lEYuAYPGaly3iayJuzaZXRAqzYbbwVH82gBIoGIcGhr1vaZ+X8dkQYV
         LT7vc66/2z9MrHBmLQWftrr4d0zgJgf8s7XU0pNpYgpBbuvAWCn+CvDcvr8oh/dirrCT
         paXHDOfr/Sn4ZtRSeCjqod2xsWn9Ddd0iT9L38oNh57eUdIet7g9qexedTM0PBgqkDtW
         xDiJ2QFgWNOaBCPAbQE4BkSlSnYm45zxhqxDGlNP3IM/ChcgXSpoieLbdgc9f5OtuqR5
         OcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8R+DoiNw8tUga/vTi1Xfm5DnH9rWZFwdCJZG7HXQcWY=;
        fh=yl58DejhAICc5YW8UN6sa5Wr5J9DZzUsdxBm8B+lm84=;
        b=hG3bsicgfF9l3DfLDTCOzXobZTBdHNgvXKVO+wAjXWr6WD5qklK2nHe+bsvEpXGtHd
         xuJu/Ozgwjhj8WlzcSi2XsnG7JU6BRVy1HT8XOoXOBNrjjOAMIZIKMWCWI+8ubeJXtHc
         VPqw2ls4eK7BtwwubRZKRFUkkOnziZYrhg0UyGV8099UfPIYcyCR5dijWzGCGWa4p56/
         nbOJVoihpJhO9G46MQ9XEM+9NWMKqSOEwSiQDLvgzOVsgxipx3gF0NWyVOfcjqNlvso3
         nyPjUi6m6FxzsDxCPsEVFFTl+ASmUz5fv3S9dWXYFe7/TPxRY2ACriraXVBHM2zcDalv
         PdfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789425224; x=1790030024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8R+DoiNw8tUga/vTi1Xfm5DnH9rWZFwdCJZG7HXQcWY=;
        b=vu2PqzsO2PGG4ZpWIE6PJG3dJpgI0uOEXP7raWzusWjJdCwp0KIVCt46YaTHZlnObq
         SCLsRVU8Em/iuHCYo4nm5B6Dq+cBTK4BL9YBwV3KQr8XRYeMnvtUdf1buSsT2eXVfTtt
         yAli95KJpEuTUVhyZ3bFG66fCnlz+CqtfEjr2mh8YCrWEuUEI2ubgTf9DOOMjFE7vn/7
         Coc83N7yezeAniKnHkkFoH0kg+WFBQNECXtxpgWaFTnwMt86nWvYDI0a8Udnm27+JJ89
         WZnSgS7brpAiTTcp5cp09WVcIFN1i1KoaFynh328uYMVKpL+RsCsCABVNb34xCqa+NmM
         h5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789425224; x=1790030024;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8R+DoiNw8tUga/vTi1Xfm5DnH9rWZFwdCJZG7HXQcWY=;
        b=z8B8Yh4z066h/lIVu+RrSMmwHPZRo7Q9fEQxbf44sMOEY0kicENF2XiY7BTdIAs0rL
         7oCY/4A/sF8+Ujj5yHtZndEgvn4XLUhxedZl3FBF/0JwK9N7BMSbIMZJcEEYmV1ea9Cq
         mbhcCKebK3rUG+T4OoICumn8/TCUMeZ4R0GnrMYMpfrHT+PgnCXhH8otsLQSu4Kye42Q
         d1v23TJpwoE0KtjJjJQKh6VYikGm41bm1sPBfHb71u9x1eC317P26LyPsRzhgVw7Wm6Z
         aIT/uGaKo6O4sJ2zSHMNDk7R6+FG2812IzE67K4bvA59QMrEngqC0rNcEl0Mkb4iyy9E
         mhcA==
X-Forwarded-Encrypted: i=1; AKwUvByf6U8MSewshitt1YF+gzLzJXjXfi8ZOjyA+B9fKFjHE5LJ5dlguFdubWFPMC7D3D5qiwE=@vger.kernel.org
X-Gm-Message-State: AFuF++ncLOBiAhxKa/+QDw2MNyZtBNSybv9GhrCnJLngxQDR2++8HbUA
	/BTWi8jkyCoprNKWhVNvuNzoMUYtkC6POYfnHgruLJo79kACVgrzT8rcFu9VnXTOl99CYIZE5m/
	wYc0JzzuzJDVB3hUNG7WiERS5560MrzGQ53x01WG8
X-Gm-Gg: AYBFou1ahhR1PCXDw6RpyCb0drj20YNJlzOKmoYYfFqPz4Qa9jdzamfgERpMpyUiBjQ
	LH+SWzBlrPBiCk7UlJShommB87QdUDbSBc5skVe/6u+fmngLdR0cYqKuVmQtFoEhAwyodWQi5DR
	u2FWCg6JJrp25p0MUI57yNuC8OmCcB43ca2Ch8xMdJbSB/nreccZNh0P3Qp+855ZBcAVlwSEnMG
	bdnbKORMLjNli1XHX7T1deqYK+bIS0aeaufwpbfjokGm+Xe0+UE3z98J+DoCah0Wk1rqbjVTTrc
	b9DZtnAMWr0RgqjMNeX0CaFA5dsjRUVKxx+BcNUWRUzhURl0WvCxpcE=
X-Received: by 2002:a05:6402:1c0e:b0:6a6:871a:ab96 with SMTP id
 4fb4d7f45d1cf-6aa043c1f89mr24144a12.10.1789425223409; Mon, 14 Sep 2026
 15:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789281096.git.zhang_wei@open-hieco.net> <016ecb3a3187b20fac299f1c2cb15aac01358412.1789281096.git.zhang_wei@open-hieco.net>
In-Reply-To: <016ecb3a3187b20fac299f1c2cb15aac01358412.1789281096.git.zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 14 Sep 2026 15:33:28 -0700
X-Gm-Features: AcwNN1UeF8yVhm34VZLyZ4GqN5kQf1hbSkumsh5DDm3dMWJVzB8VwSpiEFZADUQ
Message-ID: <CALMp9eSnoFAk5PN-JudLc=xB6jzKzERfTVPEeAaRbLTYqtnKKA@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] KVM: selftests: Add nested SVM DecodeAssists test
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 11:44=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco.n=
et> wrote:
>
> Add a focused nested SVM selftest for DecodeAssists.  Verify that KVM
> exposes the feature to L1 and synthesizes EXITINFO for representative
> MOV CR/DR, CLTS, INTn, INVLPG, and INVLPGA intercepts.
>
> Exercise instruction bytes for hardware and synthesized #NPF/#PF exits.
> Cover a synthesized #NPF that follows a hardware #NPF in the same emulate=
d
> instruction, an unreadable instruction tail that leaves only the cached
> opcode, and the absence of bytes for an instruction-fetch #PF.  Modify th=
e
> MOVSB opcode while its MMIO read is pending to verify that the emulator's
> cached bytes are preserved.
>
> Inject a userspace #PF while an MMIO read is pending.  Verify that after
> MMIO completion, L1 receives instruction bytes from the current RIP,
> not the previous instruction's emulator cache.
>
> The synthesized OUTSB #NPF and userspace-injected #PF cases run by
> default.  The forced-emulation #PF and instruction-intercept cases
> require kvm.force_emulation_prefix=3D1.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
> ...
> +static const struct instruction_intercept_test instruction_intercept_tes=
ts[] =3D {
> +       {
> +               .name =3D "MOV-from-CR4",
> +               .code =3D l2_fep_mov_from_cr4_code,
> +               .intercept_cr =3D BIT(INTERCEPT_CR4_READ),
> +               .exit_code =3D SVM_EXIT_READ_CR4,
> +               .exit_info_1 =3D BIT_ULL(63) | 10,
> +               .exit_info_1_mask =3D ~0ULL,
> +       }, {
> +               .name =3D "MOV-to-DR7",
> +               .code =3D l2_fep_mov_to_dr7_code,
> +               .intercept_dr =3D BIT(INTERCEPT_DR7_WRITE),
> +               .exit_code =3D SVM_EXIT_WRITE_DR7,
> +               .exit_info_1 =3D 3,
> +               .exit_info_1_mask =3D ~0ULL,
> +       }, {
> +               .name =3D "CLTS",
> +               .code =3D l2_fep_clts_code,
> +               .intercept_cr =3D BIT(INTERCEPT_CR0_WRITE),
> +               .exit_code =3D SVM_EXIT_WRITE_CR0,
> +               .exit_info_1_mask =3D BIT_ULL(63),

Should this be:

.exit_info_1 =3D BIT_ULL(63),
.exit_info_1_mask =3D ~0ULL,


> +       }, {
> +               .name =3D "INTn",
> +               .code =3D l2_fep_int_code,
> +               .intercept =3D BIT_ULL(INTERCEPT_INTn),
> +               .exit_code =3D SVM_EXIT_SWINT,
> +               .exit_info_1 =3D TEST_INT_VECTOR,
> +               .exit_info_1_mask =3D ~0ULL,
> +       }, {
> +               .name =3D "INVLPG",
> +               .code =3D l2_fep_invlpg_code,
> +               .intercept =3D BIT_ULL(INTERCEPT_INVLPG),
> +               .exit_code =3D SVM_EXIT_INVLPG,
> +               .exit_info_1 =3D (u64)&npf_target,
> +               .exit_info_1_mask =3D ~0ULL,
> +       }, {
> +               .name =3D "INVLPGA",
> +               .code =3D l2_fep_invlpga_code,
> +               .intercept =3D BIT_ULL(INTERCEPT_INVLPGA),
> +               .exit_code =3D SVM_EXIT_INVLPGA,
> +               .exit_info_1_mask =3D ~0ULL,
> +               .check_rax =3D true,
> +               .rax =3D (u64)&npf_target,
> +       },
> +};

If you omit the FEP from the assembly in
instruction_intercept_tests[], KVM will copy VMCS02's EXITINFO1 to
VMCS12. Assuming L1 itself is not nested, this can be used to validate
KVM emulator behavior against hardware. (Maybe this can be used to see
if I'm right about CR0_SEL_WRITE, which is currently untested.)

> ...
> +static void run_intercept_test(struct svm_test_data *svm,
> +                              const struct instruction_intercept_test *t=
est)
> +{
> +       struct vmcb *vmcb =3D svm->vmcb;
> +       struct vmcb_control_area *control =3D &vmcb->control;
> +       u64 expected_exit_info_1 =3D test->exit_info_1 & test->exit_info_=
1_mask;
> +
> +       control->intercept |=3D test->intercept;
> +       control->intercept_cr |=3D test->intercept_cr;
> +       control->intercept_dr |=3D test->intercept_dr;
> +
> +       control->exit_info_1 =3D ~0ULL;

Perhaps you should poison insn_len and insn_bytes here as well?
