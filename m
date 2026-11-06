Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793942581;
	b=E8TqsjitL++0v47ANXDSmnGdHuN0WaRBjlWZ4h1kGuNUCGfzG20JBAcLALequ1FkmWQi
	 VNqXEmOCzg4xfN5JzaF7VpPE6VNVrtYltdXjRkkdLMZsnm3lEiv9BqByGSvzJLhxIpeRt
	 A699zHxVgLFeQOKJ+FVhLzBfSD1UUnkLFETDy/eKt+KSJnvBBj1XaEcEPiVNtdpgKtUpR
	 f1iMfFK7PZ4o/ynXkBzeN7sGLFy1aN9yaFq/PVt6l0gEFJBDxlkNqy04dVX7YVjTcdzXT
	 T2npB7XaY4ZtoT+G8p5tFGvszT49X/voaWuaFveb74AYKvFC5CU+FIdU1I24CagzZvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793942581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Lr3lGEbBwXSP6n4uutvUzv2qEuwZ5jDJob60Za7bOmw=;
	b=L0upl4yaYrpFlvkzmY8Zx5pXvhh785jAHKIFrA7BKNlXRv6UySUgc/q38B7dRqn6yyd6
	 9jz7eMx9BoVkmBSi80xe4u3oSV3vvoS8+qotFh7SBOV769lnbIxBP8FmnzTX70w2AgroO
	 8GX6cWASDyo/TBXQjSXaA5DKtOIHqp3cmgXbQ12MZ2Xmkofs7LHLqwGbqudx+vP/6zn1T
	 vUrNz5+R+qhvyC2+rukkHOvQtaK9/gFU2zlL2rwcKwRfJ+ph2AiAlAy30Fli35kDnFWO7
	 FO3Zv2rBtl+WVLvpPvJraMDNTAvmzuR/9QepVpH8TTv6thN+PbAMRXCEETl85FsSzzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ONJudjMy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1554D606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 05:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1554D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ONJudjMy
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b6966d9508so965a12.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 21:23:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793942579; cv=none;
        d=google.com; s=arc-20260327;
        b=ec3fbA5Yd6VKPZMm0ClD5Ijw/V0Xg0OtwiOcdqeRZ/z9lajqiKNfI8bgVsK4n7U7aB
         sslWpHjsdyZ8jfs5we7DIQJkbxJoe0tR+Jql0KSE1FJ7sci0QlxswqMgaw3p5W+2pwVo
         l9M34s867TcDKzFV9jVv/KsZkZiL+yV83ysrn8HSIoSzwnx3HRYPPhMcLfP0LOWEAyY9
         6MdoFtiKkUdIWIQGg5KLrEZcMH2PmpN5znuYjgLB9Ww8JDCC9gWBJ7Dj5KP/GGYn9bJR
         fC/n8iqNp9sg7KKZBpdgODdHytwQJeFJxt5DJ5ghSksm8cmu8m/88D/xMhbM2mzMYrw0
         Lj/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lr3lGEbBwXSP6n4uutvUzv2qEuwZ5jDJob60Za7bOmw=;
        fh=LRNIxDJSHsswzi/2lR1Vbr7Vcza9mqKBveS55qhE+98=;
        b=ZFvUvEIDrWQ2Y9uujITDRfENx/6AtydPwlg80hNHiwobUgbJQdw2o5fiE/ozVSpSTt
         ADw/0JI/z7EUm4kBEmnzFrjK+7DYh3V1n5W84wjdFNMu1og2v/9MvFSMI529RhIp3rmZ
         mme7NOKlMNy7rQ2UVq4joXMO7mXSpZOVaoQhvbi9WqClPpzlIRJ6qk23XNK8m7HnKhWL
         ybecUxAjG4/Bg/6Id2NiDS9UwGq4DDFj6rF1xyl0pQaeMuVMV5Lb+aoln2s0ziunwh/B
         Llsk0dWYHg0XI+Vh0tCy+axyd0O6KBsUCZVjxj0As8ZUC1O9pmLkEas0RtNEV0NK+CCa
         xLcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793942579; x=1794547379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lr3lGEbBwXSP6n4uutvUzv2qEuwZ5jDJob60Za7bOmw=;
        b=ONJudjMyVOz/70HwL+Tv3/G4CGT7PaUqbIp00v7j0xfPaSJk+HszI4m25qimBR1etI
         rNCU7/jFiNLkxkyom4hodFFIbExdEJW5Uo0t1+1huNIfW9hI4ThHNt9/YMIfa++XUwBj
         Xkyp/Gv9M0YXSEyharL9gyekNjwHKdlu2EpO4HqyA8xBOyRWZxDUQj0/W1AFHjyHHTlk
         4/OfrUZasB6e6Q9pS5PScsYayx8hmDGVp2TTqaKsASGcCc/BEfXbqLw/z+5bMCRlvxFp
         GHI1TLGaYPNuzd/IvxZDB7MKsz9cxCV7LwYOcNzCe40VaD9950hnsX1zqP4uSMF4w10d
         lP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793942579; x=1794547379;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lr3lGEbBwXSP6n4uutvUzv2qEuwZ5jDJob60Za7bOmw=;
        b=JvOepJA7KjBzu6Dj7AMtJByeOYGiQHIw/GKq74vdxiO3Zu1BPIJgBMIoUKlWzxwDY1
         olIbTv/Jg5/D0h7PF0zahs8kGLu4gov2ChByB7GDBZl7w6wM8tcbpyp5QBE8yITSjBSg
         zurzTOO0gvntuPIq9YF3cSXfEeM6CZ+fq7XL63Dv8yOOFI1Oem3+J1N264aGpPe3LYjH
         O6O3MlfWgm31Az06PNuqBN3do5Rie4hYOk4Ti+0hytf8PHW0es+0lhY0Z9uPqyB6uUps
         U3o3RUZGiFlu6FgV3w0iCFfSeF6JJusa0DZwp3ivfADleYhguTrJJbloXttnjY+sey4C
         HfzQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRyYDo+NacmnBioH+yAPYoq212dxqKiMtGlqQX6LHEdXShOTaSmLhE/GTVWl+rGD8S2gM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/anbsUKzbztBfkqXdaggU0jzClfcgfYtVOG1DdRgDg6pTETXVU
	QI3fCraa+9bixyDwcoe4VmnUT65aHj5TsVQ7eMB04hmpqE2IPS1SOvLDqZpDJAXXSM9MykOzuyt
	sqpHBUp1WuvUOvU6ZD5qxih72qmAE5toOo+C5GjeTE8qw+xU4V9C2nFZhzo4=
X-Gm-Gg: AYBFou1r/BanBbBq4RB1dMNWFWE1IMZqrmknMYxQ87MFSHUQMZrIIx/Yby/t11iI1EQ
	huq3SuDELi/qIf/h9rLkJ+qK5AW+NHID+uIL4ESa0vIMXvCp+C5TApKX+KbAvt8HzSzZE42x4tr
	fwY6FjA+3qGVnMdmDt0o0htLJcBiMoFeBw3x0qRwpvwxu2CL6BWV89lCNfvQ5EiuIoJHMHBZOgA
	kmnY7+BYdtxNC+ggVziYIiT7ZMv9F/JTbWTBwdS933jqahOZtpcAl59Kv6+H9DiDpu5Q+2Kmc+L
	YDfMrzAAc4fgAS7eUCB9zoyvbwgxWjdozs1ybyz65IAQv+S1+GLmUdPDEiDuMsnLQja5L8IB9Yx
	cVMit8QccANi9F+DmINMQhykOxUVLaBwrEm8OObhYrYIjtNACgGtKTvGKpUcN8SkViOc9YQ8uOT
	U6RehKngxK37qaADLhlpQCPV4mBVoZx0s5CPvYbMCLHOR8XQ==
X-Received: by 2002:a05:6402:54b:b0:6af:97c0:ce51 with SMTP id
 4fb4d7f45d1cf-6b6e76192a9mr2321a12.13.1793942578969; Thu, 05 Nov 2026
 21:22:58 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-20-chang.seok.bae@intel.com> <20260930214824.158FB1F00898@smtp.kernel.org>
 <f56b02c9-0954-4d53-9e51-f9b7cfc5baf4@intel.com>
In-Reply-To: <f56b02c9-0954-4d53-9e51-f9b7cfc5baf4@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 21:22:45 -0800
X-Gm-Features: AclHuK8GnBbvokQKB0pCMrxKYOwTMrjXF2igv3lvpmfxhvOjlAOs2IZM4IKwEVw
Message-ID: <CALMp9eQqbj0is11H9vN_a7hGh4R_PVuzdXu4KX9Z3ZJNcGk_=Q@mail.gmail.com>
Subject: Re: [PATCH v8 19/20] KVM: x86: selftests: Add APX state and ABI test
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 1:34=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.c=
om> wrote:
>
> On 9/30/2026 2:48 PM, sashiko-bot@kernel.org wrote:
> >
> >> +static inline unsigned long read_egpr(int reg)
> >> +{
> >> +    unsigned long data =3D 0;
> >> +
> >> +    /* mov %r16..%r31, %rax */
> >> +    switch (reg) {
> >> +    case 16:
> >> +            asm(".byte 0xd5, 0x48, 0x89, 0xc0" : "=3Da"(data));
> >
> > [Severity: Medium]
> > Does read_egpr() need the volatile qualifier on its inline assembly
> > statements?
> >
> > Since the asm statements only have an output operand, standard compiler
> > optimizations can treat them as pure computations. When called multiple
> > times, the compiler might cache the result of the first read and skip
> > subsequent executions, leading to stale register reads.
>
> Without the EGPR option, the compiler shouldn't include EGPRs in the
> optimization options. These tests are built without it.

Sashiko is right. All the compiler sees is a non-volatile asm statement
with an output operand ("=3Da"(data)) and no input operands. Per the
GCC/Clang extended asm rules, an asm statement without volatile and without
inputs is a *pure* computation that always produces the same output.

When test_guest_update(), test_userspace_update(), and test_guest_apxoff()
are inlined into guest_code(), the compiler is free to CSE or hoist the asm
statements in read_egpr() across GUEST_SYNC() and reuse the result of the
first read--without knowing anything about EGPRs.

Please add volatile to the asm statements in read_egpr() (and write_egpr()
for clarity--even though an asm statement with no outputs is implicitly
volatile).
