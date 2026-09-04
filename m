Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171133E1D17
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566348; cv=pass; b=uhhUIA45xGtV1h3RljANH2cKyQSw5YgZSB+V6kOnFj0VksCQX5r/tUZL3lOg8lC+gyPYDAabQcn/3X01xFTp8jH1r8bIGtFqIhDqUz3FAGqmHamojfelNZVfRmnEGzce7s/YzoMTyGRjl7PhQzJgN+dSAiQ4kCBwmOTO+AdsJzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566348; c=relaxed/simple;
	bh=krBmnFRbIq8gF67j4Y7+7n50O8rGry2k/xf6HDV+HQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IE+5CNa+g0OL9n+U7YyBET38UxR6bI+99n75UnOhlEc5MMNbFh8+EGAccHeeDd8ADYht/SikhAL1s3DINfb7TFDv/AVPJ14poxBFIufVHGC0b5uem7ha+j0/6jIbRlIdzWXyUDqsF1A9bVTxLhAcYxYl0BGuWAzGQA2FXAaVh4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPfZhjQh; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPfZhjQh"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fd8d88so2491a12.0
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 16:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788566345; cv=none;
        d=google.com; s=arc-20260327;
        b=OgreVJDzHZOd4We0bS5aCdOSGw06GUHIZZm1T8XArhrChyVey1kq3LnNqBLmsk9ZY/
         M8E04XxqRILiSR3Dgt8JKU5L6I18g1V45YOfeewM2SC32yQ37agoKDXayLkbqorfl5zJ
         cYK8+uekWJdrtiLAWkHuH0Iv9Zd4SVh+0FS2cWSqr78vftEkvS0Jz95jsbdYODCJYZt1
         beLWL+946lS/BH8MmPBtFmPlSi9w/n5RL5NqT8rQgVglph+1Vcy2G964f/lONn/0q9gN
         NQ7wX5kPO5A/VvlRZAsbKAsv9MEh1xqjo/FaGCiUnQLWtnVry07H1g8O2rihg+4j5bJH
         ntvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P15M9YH6S+kcXbz1rCaJgiRw7qh7wUbJsCq2CIKQ2jE=;
        fh=9Eh1rkeYC/LIEUdAhK7U2pHYj/s15GHWV9h8b3gjGrQ=;
        b=fk/8Qg33aK2blrbx72qXUxy8ud13csIOXbi2t5BZx5m379ZgHclOwsZRghNR5DF2fj
         5w+u2jYOCeBQjWkZ4jqqlR7ympqBzozbFCWJprStxNOXBavznXyURTZ8EHzXH3Csce/B
         DDfoTdZun40fMt2DgFmWU+YZ2DdQJnzBWr0GF9/LsMsGl8kjESrP7SHXkrqTYE76Nfor
         1mt8OvSi3YNYB3ldq4osSsSbWzwtad5FpYEcBxiOGtPbYDQHri7Qq2vb0BiqAycf1viu
         WySfdEQC4X1aS0hR971H7gtiuJCFj7pcXLimgrqPpE7yHF+o/1B126D6swOavww3qd8R
         +cLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788566345; x=1789171145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P15M9YH6S+kcXbz1rCaJgiRw7qh7wUbJsCq2CIKQ2jE=;
        b=tPfZhjQhDVwmNy1sVnstD0Be7ummGaDZcrFc8j11i9CKV2eqKlaBGDmMJ901e8Xtjq
         INWzo1vj34VIbPo4v7d0V8PgxdbpnpTYxeB+q7WUqa0LnoxAQRUtdcZzIW629DdFomkA
         fICmank83k1iDHCMF4GUMcZf1yZl//9EmgQHpUlYYhBdzoul1Z7BQYEMFPD9/8qh9+Nr
         w01B7J0z8DHEdg24wiE8ive+B3kxmXhfAQdxYdnXsV488N0wd7tgzq9HGew+L9sIzdJQ
         LXWpyiVUKbUCCZF85YM7JHaXRoguDSWDVu+ntMLpEF3Sp8V/u/H5cDGzkgXmmLPj7A2b
         4qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566345; x=1789171145;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P15M9YH6S+kcXbz1rCaJgiRw7qh7wUbJsCq2CIKQ2jE=;
        b=E9bQB3Su2vbe/83rC0xaBuq1Qpu5RktI1nzTZv1suCLbsGKRXpNQdnqL/uV9+u0Ctz
         tlsdigtTksvQQ5TI83N4WfehQpjOJCuIy+PLjgFOMnMdP4xsj3C4Wvhj/rPUgO0Smw6O
         QvRAgjV4pddMecpPi+v3rHJHTGgw8XViyfJ4KnAbhYCz4svBCW0kMKoDExBcC24k+zCI
         cjdTwBNZp3Gg/FWoHYL0yxeGBi4xDkOj8nofXknbKBqXTXFQOlJa2F3qliqqNmpUqx0i
         EC7Ncu2sxZiwS9iJylrilPLi0hHyV5wUZLCdIqBt8r3+e4tplz66+MGWmPBV/+qWNYFa
         HFtQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgpLOsqWLXoKTFeFXxKNqUgh7g4IBVQw38QEjXeAPOYj9DmCwWz4TRQk/I3uJHWiPZB/s=@vger.kernel.org
X-Gm-Message-State: AFuF++ncL52SwEtq9hGVYf42RaruE2RsGTy7vRdSWApo/OYqsPFi5SKB
	lpamXSQGfHon7RBmsgfRhATfdymDwiPzLN5JfdizywQmw/scFakzvUWG7FoWOXjFXafu6+oL67N
	CYgDLtM22vg/f11bBPZ5cMdjh8XbGcZCq+3V4J/xY
X-Gm-Gg: AYBFou0PJCuT9YM5gl5wS2l5VX+da3Ts5CypX9tIGC09Axzdt9sJG959dzo/UMgNkG+
	qVtkBewpRLP3hwe+BWjc4k5L6vsPyZ/SufNDdb6PRBJJLgCh0P+iYSgSsG/FUt98BfFvbmxdZ0I
	wRGOlUDLBLLnFZsFJxtQneKMJvouu0TXHv28x8UAASierCHDg9A/XKVF3bEqJo8wvVTvBk0O7wz
	kAqdkD3KepHoS1YW5DxRNgnRxUR+FcrMlU55/4RPQjrw7csxsXX9cLIp3wHEPTokqI3QgXsYZPg
	AvQ3tBh/mzPIidyhDNBjdrROnuuGfkj8de1ZtNVuD0X4
X-Received: by 2002:aa7:c0c3:0:b0:6a6:967c:3186 with SMTP id
 4fb4d7f45d1cf-6a7f67ae76amr12701a12.2.1788566344746; Fri, 04 Sep 2026
 16:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824123954.315112-1-zhang_wei@open-hieco.net> <20260824123954.315112-5-zhang_wei@open-hieco.net>
In-Reply-To: <20260824123954.315112-5-zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 4 Sep 2026 16:58:51 -0700
X-Gm-Features: AcwNN1VzwHjjOpDM8aPo2_uyIHXlBmHXB-Cus8IcnrfXF5YVspG-M2LzaQS3L0E
Message-ID: <CALMp9eR=TNUqfbNCFkxmg=O_Obcj11Tu9jAmX6Pe60qvvNx-2g@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] KVM: nSVM: Propagate hardware DecodeAssist bytes
 to VMCB12
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 5:40=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
> DecodeAssists provides instruction bytes for nested page faults and
> intercepted page faults caused by data accesses.  When the feature is
> exposed to L1, copy fresh hardware-provided instruction bytes from VMCB02
> to VMCB12 for these exits.
>
> Clear the VMCB12 instruction-byte state before rebuilding it, and leave t=
he
> length zero for instruction-fetch page faults, unrelated exits, and exits
> without fresh hardware bytes.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  arch/x86/kvm/svm/nested.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 6770721d4e4c..2db0ec66e8dc 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -42,6 +42,20 @@ static void nested_svm_clear_insn_bytes(struct vmcb *v=
mcb)
>                sizeof(vmcb->control.insn_bytes));
>  }
>
> +static void nested_svm_copy_insn_bytes(struct vmcb *to,
> +                                      const struct vmcb *from)
> +{
> +       u8 insn_len =3D from->control.insn_len;
> +
> +       nested_svm_clear_insn_bytes(to);

It's not obvious to me that this clearing is necessary (except in the
case of the early return below). The APM does not say what happens to
the remaining bytes if there is a short read.

> +       if (WARN_ON_ONCE(insn_len > sizeof(from->control.insn_bytes)))
> +               return;
> +
> +       to->control.insn_len =3D insn_len;
> +       memcpy(to->control.insn_bytes, from->control.insn_bytes, insn_len=
);
> +}
>  static bool nested_svm_vmexit_has_insn_bytes(const struct vmcb *vmcb)
>  {
>         u64 exit_code =3D vmcb->control.exit_code;
> @@ -67,6 +81,25 @@ static void nested_svm_clear_vmcb02_insn_bytes(struct =
vcpu_svm *svm)
>         svm->nested.vmcb02_insn_bytes_fresh =3D false;
>  }
>
> +static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
> +                                               struct vmcb *vmcb12,
> +                                               const struct vmcb *vmcb02=
)
> +{
> +       struct vcpu_svm *svm =3D to_svm(vcpu);
> +
> +       nested_svm_clear_insn_bytes(vmcb12);

Clearing here is premature. If L1 does not have
X86_FEATURE_DECODEASSISTS, the "Guest Instruction Bytes" fields of
vmcs12 should not be touched.

Moreover, as I pointed out earlier, if L1 has
X86_FEATURE_DECODEASSISTS, and the VM-exit doesn't have instruction
bytes, you onlyhave to clear bits 7:0.

> +       if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS) ||
> +           !nested_svm_vmexit_has_insn_bytes(vmcb02))
> +               goto out;
> +
> +       if (svm->nested.vmcb02_insn_bytes_fresh)
> +               nested_svm_copy_insn_bytes(vmcb12, vmcb02);
> +
> +out:
> +       svm->nested.vmcb02_insn_bytes_fresh =3D false;
> +}
> +
>  static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
>                                        struct x86_exception *fault,
>                                        bool from_hardware)
> @@ -1332,6 +1365,8 @@ static int nested_svm_vmexit_update_vmcb12(struct k=
vm_vcpu *vcpu)
>         if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
>                 vmcb12->control.next_rip  =3D vmcb02->control.next_rip;
>
> +       nested_svm_update_vmcb12_insn_bytes(vcpu, vmcb12, vmcb02);
> +
>         if (nested_vmcb12_has_lbrv(vcpu))
>                 svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
>
> --
> 2.43.7
>
