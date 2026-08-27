Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12ED2DB7B9
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813533; cv=none; b=JHLLmzs4PwYFzSCFTyOAM3yEE37PLVTF7RKqvLEZhV8UQ8Tx/AQSB9ufPPpCixmOHwmkVmAEDWjmpIIEoexsUQcydnPUm7KJC1GILE1aeLTZ/uLGPvLAmb8fdhBObF4lpFAonTtRbK23qgmz1PZbejxJ1glqZ7D/9okAchCMs20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813533; c=relaxed/simple;
	bh=Da0fXsfwuyG6dNJ6cZ9jptzuJE6lm5EZ7jZn7IqpEsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaN1Rk6PkN2pvXSZsyDM/ssqqJERjKcCBpDfgznWa+0WZH/DnMY6+xCr8wIie1cbsvbbwNAFQu016xiEhC42j9Rn7uwVTNGR6HdB3wYRf2B9qe92vtBdFMo2kVCLI0smAPB5MUm84SS9HmF+zyC2p7wslEdfAUlw5ZgOkUpMr94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItaaOz6b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItaaOz6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B971F000E9
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 06:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787813531;
	bh=wVi2eZPfbYuqP485PFkN0tjwr+z1YH8ptpjfhnz9BuQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ItaaOz6bCwnhLml7kTaU5Xs2zuoGjsOIOhI0blxBGWNYeXMMSV5zo/PKh14ODCOam
	 fdTm7TzXlsCOZRzfByOWS5CYgxZVswlzG+n/MY5iNP2TC9nqulrz1DRGNCdB7PNs05
	 Yi8Efcx47LmGX+5GnXpr08BWmNnTLj3Tafkd75vJsGrRw2kUUASiPnRD3U3mDZXTEg
	 Bgq22Gj7sjpuDQilUaWVme2q2A8vlEj5tkBjhojyGdGICWj0pD+DvnC8qcHH6jJ/dV
	 5lyuMlUxGQPo5Blf1U8Vt66RltlX7xw/q56+6LB0T8sBTl+2WUFb97f3fVwIEE0RHQ
	 hyEnpjbtVBd5g==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so1215131a12.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:52:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpVQShe7wphMaxsJf7HlFfEPjpXMBctioXdAPIeSjGORn/Xu7FS5llDI62oH4UXqcEExH8=@vger.kernel.org
X-Gm-Message-State: AFuF++l2lV9OZSWijuPgrf4TZVm5NWasuWf6Vm7ZlUjYyQX3VLYMK30E
	iNqFOmAyKr2QnoqzabhKgE7PBbwDYq9q8R19yCCa5zVzm1leaLvcyOVkPv8X4l4cmobSDbfcpqs
	hbzzMj5QAROpTvAdlda9mwZkX1MLdefc=
X-Received: by 2002:a17:907:934b:b0:c20:7cb0:f33c with SMTP id
 a640c23a62f3a-c253614e259mr286595366b.16.1787813530578; Wed, 26 Aug 2026
 23:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com> <20260826233919.998904-14-seanjc@google.com>
In-Reply-To: <20260826233919.998904-14-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 26 Aug 2026 23:51:59 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOOq05nWk6c1sCnPAimFTuZLxc3BDrZLro-fXPR6ZMmTw@mail.gmail.com>
X-Gm-Features: AcwNN1XTwuTKdT-sv80CRHYM3m8PSeG1T_AR1bTACKJVAgElSchB7D80CH8cH6c
Message-ID: <CAO9r8zOOq05nWk6c1sCnPAimFTuZLxc3BDrZLro-fXPR6ZMmTw@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] KVM: selftests: Add and use double-underscore
 versions of vmlaunch() and vmresume()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	f734222792@gmail.com, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:39=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add double-underscore helpers for VMLAUNCH and VMRESUME, and have the
> "outer" APIs assert success, as is common through KVM selftests.  In
> addition to providing more familiar interfaces, this makes it more obviou=
s
> which paths expect VM-Enter *failure*.

Nice.

>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

Few semi-related comments below.

[..]
> diff --git a/tools/testing/selftests/kvm/x86/aperfmperf_test.c b/tools/te=
sting/selftests/kvm/x86/aperfmperf_test.c
> index 11f5894d8ac7..a082658c1e48 100644
> --- a/tools/testing/selftests/kvm/x86/aperfmperf_test.c
> +++ b/tools/testing/selftests/kvm/x86/aperfmperf_test.c
> @@ -83,7 +83,7 @@ static void l1_vmx_code(struct vmx_pages *vmx)
>                 vmreadz(CPU_BASED_VM_EXEC_CONTROL) | CPU_BASED_USE_MSR_BI=
TMAPS);
>
>         GUEST_ASSERT(!vmwrite(GUEST_RIP, (u64)l2_guest_code));

Do we wanna give the same treatment to vmwrite()?

> -       GUEST_ASSERT(!vmlaunch());
> +       vmlaunch();
>  }
>
>  static void guest_code(void *nested_test_data)
[..]
> diff --git a/tools/testing/selftests/kvm/x86/nested_emulation_test.c b/to=
ols/testing/selftests/kvm/x86/nested_emulation_test.c
> index 2b38eff4f516..11fe4a31eda0 100644
> --- a/tools/testing/selftests/kvm/x86/nested_emulation_test.c
> +++ b/tools/testing/selftests/kvm/x86/nested_emulation_test.c
> @@ -102,7 +102,7 @@ static void guest_code(void *test_data)
>                         exit_insn_len =3D vmcb->control.next_rip - vmcb->=
save.rip;
>                         GUEST_ASSERT_EQ(vmcb->save.rip, (u64)l2_instructi=
on);
>                 } else {
> -                       GUEST_ASSERT_EQ(i ? vmresume() : vmlaunch(), 0);
> +                       i ? vmresume() : vmlaunch();

Ewww

>                         exit_reason =3D vmreadz(VM_EXIT_REASON);
>                         exit_insn_len =3D vmreadz(VM_EXIT_INSTRUCTION_LEN=
);
>                         GUEST_ASSERT_EQ(vmreadz(GUEST_RIP), (u64)l2_instr=
uction);
> diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/t=
ools/testing/selftests/kvm/x86/nested_exceptions_test.c
> index 50c271a03692..c36c11b5f518 100644
> --- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
> +++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
> @@ -112,7 +112,7 @@ static void vmx_run_l2(void *l2_code, int vector, u32=
 error_code)
>  {
>         GUEST_ASSERT(!vmwrite(GUEST_RIP, (u64)l2_code));
>
> -       GUEST_ASSERT_EQ(vector =3D=3D SS_VECTOR ? vmlaunch() : vmresume()=
, 0);
> +       vector =3D=3D SS_VECTOR ? vmlaunch() : vmresume();

Ewwwww

Can we make these if/else statements? It was already ugly, but it
looks even more ugly outside of GUEST_ASSERT_EQ().

>
>         if (vector =3D=3D FAKE_TRIPLE_FAULT_VECTOR)
>                 return;
