Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5C3A3E78
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511467; cv=pass; b=pkbFZ14vWL3aowStRetZbjtOhjRazseyLh5n1D2UwxmIN6Yb7+F1wi4lrklaeBxWtFi/8TjKVnQJMHwQp1vYSkFuVS5Qv1qe7s6fM22vPVWFIFBnqlpWXDCP0FiIXKssyITc4KohS/q66y+s6wkKw0bnUwZTz6Dq618UPt8bQqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511467; c=relaxed/simple;
	bh=lz8aaji5zgC3mWJC1SnLk1rnhhRMJ2GV0lKLpP1PYaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDv39cFIFiAoW3EIGLGOLoQKbLr3l7dmlc4cpzRq3mJkaaNjvZBFJudoGmL6Ys+0NHMPTQHcoFuSbJ3W8WU0akgEtwFtEpt3t7JLi0saFz7ixtRlsuM1bX/hv/rO8O/c/tu4KUqjXamudwBUzmCecGPkN96hnM2uYNKfp3vspKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZPtgiS5; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZPtgiS5"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-498012a61f6so47755e9.0
        for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 11:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787511464; cv=none;
        d=google.com; s=arc-20260327;
        b=mrY8OC60ygCN3NTyBFbwiL8V7C+pse9AnaIKf9EY32sG6GRhbKycSTukel6UxmHWyp
         voDfNx50tZaqHla+Xeq1uxDYxQX0gZzdpd9PtZJrRm+AZIvHpX8oBFWzY0TCWUtJxo/1
         Tqo7L3wC5XO7ERRdq++IK3eVZm+1pLj+cyVmE65C9YwYTZ0kWtjvJNqIUVF4OX36l56w
         hbtOD6cieOWD2WULz2Z+QcT3pk140MRGy8h/JfUfVB+iASfhQeYJgGkKH5CE0y0IdBnl
         M7gcRIDASB18QJhGHMrK7rpM7UzIR8eIw9W6331BYTFNKoC0qezQdW3rOWd8wIVxjnOb
         M9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z2ncKZyTY/9/D1QKVtbf5dvrVylSRPaXMNaiLdOiT18=;
        fh=nduEUYzXk2zNQu38MyHsOlymB5cCKxkSPbq3KviKEcI=;
        b=S31cjZ1qwNqpsO0JWa129gnCK+9zyYlxBRU1Kygrs06fLL8jesQ2cwK95vOGmfxz08
         fTsxqS87l4W7TcI+LuDAmaWPKuO8Zwz3qIPwWF49xMnd8weXiB3n6Hl1RRP/q8HypuqF
         HBVb38gDb84TXH/mzwLuGgb3D1+WBR9n+8G5rRQrmI3AeErV4CtZBy73sc1tzlnqOWHe
         XPBO1FqDKbiCNRI2oyuWdKj8uiSEJDPEOENr9NZRF3UvURhZLN33MS+GfWpDudN0YX37
         rSDhd/Pqmy0xCRtMaDO0uaPZu5oof5g3w/UNXGZCHmq2yhK5Rv04HQJBLFXd0D/giD9I
         UJbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787511464; x=1788116264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z2ncKZyTY/9/D1QKVtbf5dvrVylSRPaXMNaiLdOiT18=;
        b=IZPtgiS5zTW1pyr94iqWZu1P6Mp67tEohpei/mxtmuKQRxgpxY1NZL12syfm9E9/RP
         cmi15yrAWu+GOmZddJbyu0s1oMjKsjZKCYt6wqRNnRh5S1neNiuNdKMH4bX+N7+c6+Is
         b69utd737kdv7qjPq4rN8O29AlDcFP+ZT8iUO/sBkL8c+XtQuOS9d+p/cDyYdRxDlxH8
         orkmljAg6bHKlx6IJXgon1tLdyuuvYDnye4UUiY7XndFtvdl+1RHUKmvA3UzJQehB6kU
         7quwDvnD4ZeD42vlTi36tPjjureLUotChpYfjYS/N2thPy/S+rdeKv16lDaUh1S0dt2o
         OxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787511464; x=1788116264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z2ncKZyTY/9/D1QKVtbf5dvrVylSRPaXMNaiLdOiT18=;
        b=YUxL1Txk97t3ljn3RsM4WGjTTgii1/A7k0bMT85xOLIeWfOKM70xeLjEKHHo2L/Smu
         vXtgT2Ca7/x7WF0we7teBGK5MLpBXFBy8MsldNkASs3L1zphOpgxPM36lz+sf+AlLisK
         QsWUW22adL/34C7xR0R6IrwwqBe47Hd2ztAhmOTYeQiZVKrD7VeB1HDMx6dMV4fEe+Sp
         e1/WJQ4usIDsRtl/p1P1f7f1fvHA3Eslho0DbY3MpFO+M+aHp7vY+UPlRJRjJHUgL5+W
         SbN2MLMpcrKkjB03LsWqC/13jqWgTfb/sb2lcrjjhH3U3CrMILqM1BrrTyK3wzdppImq
         PBDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq85U3U2DOlIQ/DSNimX0t4rQqkgvMFjpImSzQDHNjy5j+5Vw2TKRj5B5VAzELzRkCyRNU=@vger.kernel.org
X-Gm-Message-State: AFuF++lUVwxmenG4b3sRGZ2ZGb3WfAo+Bq18y0FCD/93Tqa1Ckyu5SIS
	eDXu4M1Jjl8PRXI46rvkhB6iUS/jbtArQ2V7VFQ4nO5IjG4jiMuXD/yt/r+374AbxHu4+56Jvou
	Cu0GVknnoVbpmltLvZlPyC7Sz2HO1ZypPHYaU2KAz
X-Gm-Gg: AR+sD10Vif3QTef4ZR0oiW7KnIFO0dO9SkD8WZEGSOqC1HiV05iaP5fhteRthZqEfn+
	2iBnCcCVByr3yFN6oYrxxlrNOO0+Q4u3DmBuSGai34GDIKJ+epqfF04hSereXArqYXMv9aK5py1
	YaWFVxfnXjqZVApNOzZSl+0N5R7WTdeclEO3+G0dvlmDAhm5EqfRFBALNL0boBE8HEaT20Rhtw+
	isxAj/9UoC+OXfVw5Adl0y4hT8IJwd863ssNIvScFG21RDl0czUtxRQ8ddDPKWn+yk0FLC87u/K
	Hj+ZKWC3mbKc5lbbDzgYSgULXip6eWS+vu+++sepIPTng8mju+jIIN5MV7xWyClan0B/A7qSdv+
	F
X-Received: by 2002:a05:600c:5944:b0:499:a6a5:a687 with SMTP id
 5b1f17b1804b1-499c198e4b7mr1421055e9.0.1787511463662; Sun, 23 Aug 2026
 11:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818112920.26252-1-likexu@tencent.com> <20260818112920.26252-4-likexu@tencent.com>
In-Reply-To: <20260818112920.26252-4-likexu@tencent.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Sun, 23 Aug 2026 11:57:31 -0700
X-Gm-Features: AcwNN1UKm1Q7lz-ubUFGA7ulRgZVArWjC692yzAJA6eP0LdE_OW76ZW46Y7eb_4
Message-ID: <CACw3F51+V9fuYeEPH20+KV6589z36OBDsr+Vgmgs4TS+7V=zEQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] KVM: selftests: arm64: Skip sea_to_user when EINJ
 places no poison
To: Like Xu <like.xu.linux@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 4:29=E2=80=AFAM Like Xu <like.xu.linux@gmail.com> w=
rote:
>
> sea_to_user injects a memory UER with EINJ notrigger=3D1 and expects the
> guest to consume it and trap to KVM as an SEA. On some firmware the test
> aborts instead:
>
>   arm64/sea_to_user.c:223: exit_reason =3D=3D (41)
>   Wanted KVM exit reason: 41 (ARM_SEA), got: 6 (MMIO)
>
> notrigger=3D1 asks firmware to arm the poison without consuming it, but o=
n
> these platforms the poison is only armed as part of the trigger step that
> notrigger skips, so nothing consumable is left in memory. The guest reads
> back the sentinel, no SEA occurs, and GUEST_FAIL fires. On arm64 a ucall
> is delivered as an MMIO write, which surfaces as the KVM_EXIT_MMIO above
> rather than a KVM bug.

Thanks for the fixes, looks good to me.

Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>

>
> The file already documents that the test must be skipped when firmware
> cannot deliver a consumable error. Detect the guest abort that follows a
> missing SEA and skip, instead of failing on a firmware limitation the
> test cannot control.
>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  .../testing/selftests/kvm/arm64/sea_to_user.c | 24 +++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/arm64/sea_to_user.c b/tools/test=
ing/selftests/kvm/arm64/sea_to_user.c
> index 7cf95da8e594d..d4af6e0eed288 100644
> --- a/tools/testing/selftests/kvm/arm64/sea_to_user.c
> +++ b/tools/testing/selftests/kvm/arm64/sea_to_user.c
> @@ -215,13 +215,33 @@ static void run_vm(struct kvm_vm *vm, struct kvm_vc=
pu *vcpu)
>
>         ksft_print_msg("Dump kvm_run info about KVM_EXIT_%s\n",
>                        exit_reason_str(run->exit_reason));
> +
> +       /*
> +        * The guest's read of the injected location is expected to trap =
to KVM
> +        * as an SEA. If it does not, the injected error was never placed=
 as
> +        * consumable poison: some firmware honours EINJ's notrigger requ=
est by
> +        * arming the poison only as part of the (now skipped) trigger st=
ep, so
> +        * nothing is left in memory for the guest to consume. The guest =
then
> +        * reads back the sentinel value and reports it via GUEST_FAIL, w=
hich
> +        * arm64 delivers as a ucall over MMIO (hence a KVM_EXIT_MMIO her=
e).
> +        * Treat that as "this platform cannot host the test" and skip, m=
atching
> +        * the requirement documented at the top of this file, rather tha=
n
> +        * failing on a hardware/firmware limitation the test cannot cont=
rol.
> +        */
> +       if (run->exit_reason !=3D KVM_EXIT_ARM_SEA &&
> +           get_ucall(vcpu, &uc) =3D=3D UCALL_ABORT) {
> +               ksft_print_msg("Guest consumed no SEA: %s", uc.buffer);
> +               ksft_exit_skip("EINJ notrigger placed no consumable poiso=
n on this platform\n");
> +       }
> +
> +       TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_ARM_SEA);
> +
> +       /* arm_sea holds valid data only for a KVM_EXIT_ARM_SEA exit. */
>         ksft_print_msg("kvm_run.arm_sea: esr=3D%#llx, flags=3D%#llx\n",
>                        run->arm_sea.esr, run->arm_sea.flags);
>         ksft_print_msg("kvm_run.arm_sea: gva=3D%#llx, gpa=3D%#llx\n",
>                        run->arm_sea.gva, run->arm_sea.gpa);
>
> -       TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_ARM_SEA);
> -
>         esr =3D run->arm_sea.esr;
>         TEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_DABT_LOW);
>         TEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
> --
> 2.50.1 (Apple Git-155)
>
