Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792625665;
	b=WS4vq96ZPOqkNvzrqlIzhknpzFMyxWD2h5KLj8SyK4c44YUYvwyadJtDeUNLC/M4jycN
	 VsSsq60qysm432EIRO/R0LtmO3ZU97k/iBdKBXNFFAxRuaEX6T8CcwNKrdn9SbVr1lJcP
	 BWpHoFaxUWw1TTxyA0RWq11a3KRelAABrqxLfys+EmORBkCtDESq0U+zcEhuPqs3cvj/X
	 M4yWTNcd3145wpc6EEn/rvWSjkVOZRLmLNmyIFjVFdw8FOyZfJSN0mr8XHSkg9Fas/xpx
	 oIzohwolzqQESkkzk9I3IexEiePvdI0zSy+bx3WrckmVOffO0RDvDAmLrjg/eLuRgpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+FP6KI1E0WI+ATvprP88F8rImT8RMOfmVLaZJFbAxPw=;
	b=IMapoaTPhrMdcmC3NSlNUaOtWH0Oo865vhA75soHX6l9yaWN1ntcc9FvINkrFGIbFT7C
	 RzFjAvSk9bDWRCfYtu+yTTPgJRfm8bvXklTUBcemsyz7/zsUoDnGrk+NLsQOBBlxzq/Cb
	 NtHla3zJ8WRpsmD/13hKGB0CTsIKJVszVwaUU1+oMg6vE9XujoNB9Nnp3l7d8RUbEQzEP
	 dW0bTFvjqRZfT80ThbFE40T34tNBIn64/1Dkf8qW9sh+55wXZnZuh6iQ5Su2+kE8TjNtg
	 Uq72tY9AUrkPC+arW9ouVIlqcgYczMTejkAsz4OIpbIQzwD75GSUhOWlFq0S7/kRiXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LdnzE0zJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C10606A31B
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 23:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88C10606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LdnzE0zJ
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2775a12.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792625664; cv=none;
        d=google.com; s=arc-20260327;
        b=JkBX/elTv+Mqtb6ehioVjO7SzQcgNxhNo5RfNp40i5CwJvR8jldV8c90z8wmdkwo7a
         Q7iqnO6bQza2/l6D4L22ZVmvB5JQ/0cQtrQwqFmdPoa31sdUY5hGYzoasJZZibR+h0GF
         aCcJQoDyWFGdxFyJXySeygKpHwBT4GVCuoRvYNZcB46Br9M1DtSRzdCCv6E39D679Uqy
         OHy0t48GYivCe2y9Wj2qnUzrKj5t60mxr0b32diqTP2ff3njApsDdBVErw0Vk8PZTmTL
         Mc3lue29ANcaJh08ffu+PrZPnNrrsK93ddRIr+2JdtUSwE+qRL4ZXXgtlsYP2JBsLKDW
         VX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+FP6KI1E0WI+ATvprP88F8rImT8RMOfmVLaZJFbAxPw=;
        fh=n+joK8yClKi/kQhnE16dfXV0bL/TKlsNwI6wrqXPSfU=;
        b=KWSFBTP/FLzSjdfTp2QjVtOvtCbBn8MX/1RwqEiotsrtwiRQqIrF203RFzYJqRyZoy
         7nrh6M0iYJ8jKuG6W1Sx+Dl7TmIpQzXKO6qLTcaPtAyCE0IqO6xpJsxNTWZPD4yJ3OrA
         4nZp1YksabRIWZKakmxugSUxc//IXTxNkTmuPQnx+R+NrO0Mc/68Ylilgac76FvRcFGI
         XsVO0Z0RF06DvaTowOlrEukM5YbsAjhq8GCiBJ14nzL7HJItN2cGIWEUgpT7NxDHwfGe
         RuRxIu2VgCkhtrouVur3wbwEN90r1EnoeHa4lmB7LBuWyxtq5uMgcwkJSjpy71E4rHEE
         55MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792625664; x=1793230464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+FP6KI1E0WI+ATvprP88F8rImT8RMOfmVLaZJFbAxPw=;
        b=LdnzE0zJquVjUHmlmSxeqD4jOmflRdqRlDQ3XcYK1BlPGsbAAi2zlAqYfQhnSIE25/
         cPcMktJPyAE4aNRAKrqq97X3mOBvXrdK0UATWJsV5ZwcBhmiNawNw7lblKkcdpFGPoN6
         by8epEvuLM5AhlRJhQVYjBSa2WyTysM3yhC8E0g/WQCVQaYHh3ue5xlxpSUGO5F7Aijp
         Dg4l24JDX+e/KyNalYUZh3BtXL/I2ohWMOPZiVp2i/IC6j4ZvIxW2wUo9CfU3Bz1OcsM
         SErjL7K/DS/CVNrLVtaHvGTF1LWefbYArqsphI1ZoW9dfwlGWeYwQg96osf6M541+FB2
         X8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792625664; x=1793230464;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+FP6KI1E0WI+ATvprP88F8rImT8RMOfmVLaZJFbAxPw=;
        b=utESgfcBaVx/gaBJ14zlwrsT1EvGMChH/tia9gqeJOX645TUcBewE9ZMfpeGGrF+jB
         mDPmuaS61KwYDsbEL9oEFoU1msRbYP1IL2CwZBo8k17My2Wi5kwGOD4q3fjMtr1tPaJS
         gfzCGrJvNfZdbMAIRUMBPS8956Dw7k4Wj6VV7+XIpsVRIeZSK2fcd6Sk9WBiWHlILuOT
         Iok6w5yydyKjioepwxkN8FQ6CELXmIwD3inV8lxPXrPxSZhtD3P472qAMBEDwNbGuISr
         pl1h2f4G+3SfftGkg0d4Xp83TwCjjifM7qv7Y902tXznSh4Wk8SlQwgar3ICNVRSGw8F
         c5NA==
X-Forwarded-Encrypted: i=1; AKwUvBxeNlwhmnspE0c+WyTPBk7hah/g9/wZIZVEtdDveqcpHYqbuWa1TW8LWsqszN8CbuTp/ww=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2A9nu7G3MCL/z/BpaaUpntMrcdW0NvvKSAqBkcbHyh01Zo57G
	1wk3HxMJt5GS3YV+EsKSpE6hNaRi2/ZrSr+rvg/qpUXgOuzE3LTBAaz7t3s640MZos7WCYoqXrp
	Z3PmKV4f6Sbvnjwr1EnD6vTsmpdHiCL0fooZK+NXT
X-Gm-Gg: AYBFou29vrNmomBYBBS5cmRoOPeCQywjIHIitIDZWn4kxFp6bXxs+QF008m4yDnWXCG
	KWfav2Dj3k0BJZyykpcQI4KEe/etJtxsriSCCJ5v1JQ2amUA+eoydxAM6jGqmCcB+AjFT4vLOmO
	dGBHXWLnpyFLr7QG1gGvCcAsulLxscDGP8aC6Kr0jzCEkbIb6/MSUrcJZctxx8KHQ3omIn/yl9d
	PdZMO4HUXvrYpjjxwh9UtUXDcoQWKQQO+luJeFnWSTLumt9ROQjtPOr3tQOeerpu8da/2nrSwQ5
	cc6oGdmX8q98PSfMw4HYH+UsH2PlVMxqujF8ddo+Q7GXB5UjFJbXW0GDmOEoqoMxtoWZvmCFw2Z
	QFZjT630O6KP1Yb+YYLHWnFwybpMuyOK/pevp
X-Received: by 2002:a05:6402:3258:20b0:6af:97c0:ce51 with SMTP id
 4fb4d7f45d1cf-6b42036d1eamr8171a12.13.1792625663534; Wed, 21 Oct 2026
 16:34:23 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com> <20261019210532.378628-5-shivansh.dhiman@amd.com>
In-Reply-To: <20261019210532.378628-5-shivansh.dhiman@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 21 Oct 2026 16:34:11 -0700
X-Gm-Features: AclHuK8Fq2OFwJbDGTBqUL2KjFhS3p59umi4aJ4iOn3Aabk6CQHJXunrqbDFxu0
Message-ID: <CALMp9eS+vfR=Gk5QhLFrCZ4MyCq1YrunViB=tB5OLo+L8Ka+OA@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] KVM: SVM: Enable hardware-assisted LBRv2 virtualization
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:07=E2=80=AFPM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
>
> Enable V_LBR so hardware saves and restores the guest's LBRv2 state in
> the VMCB, and pass the LBRv2 MSRs through (by disabling interception)
> to the guest while it is set. V_LBR is enabled lazily, only once the
> guest turns on branch recording, just like legacy LBR keys off DEBUGCTL.

For a Linux guest, I think lazy V_LBR toggling is a bad idea for guest
context-switch when LBR is in use:

Context-switch calls perf_pmu_disable() -> amd_pmu_lbr_reset() ->
perf_pmu_enable().

The PMU disable clears LBRV2EN, so V_LBR is cleared. As a result, KVM
intercepts all of the LBR MSRs written in amd_pmu_lbr_reset(): 32
stack writes plus LBR_SELECT.

> Co-developed-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---
>
> Changes in v2:
> * Check svm_lbrv2_active() in svm_need_lbr_virtualization(), which is
>   a newly added function.
>
> ---
>  arch/x86/kvm/svm/svm.c | 45 +++++++++++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/svm/svm.h |  1 +
>  2 files changed, 45 insertions(+), 1 deletion(-)
>

[ ... ]

> +static void svm_recalc_lbrv2_msr_intercepts(struct kvm_vcpu *vcpu)
> +{
> +       struct vcpu_svm *svm =3D to_svm(vcpu);
> +       bool intercept =3D !svm_lbrv2_active(vcpu);
> +       int i;
> +
> +       if (intercept =3D=3D svm->lbrv2_msrs_intercepted)
> +               return;

This replicates the bug I just fixed in
https://lore.kernel.org/all/20261020234535.3182385-2-jmattson@google.com/.

> +       for (i =3D 0; i < 32; i++)

Nit: 2 * SVM_LBR_V2_STACK_SIZE.

As I asked on patch 3, what if the guest CPUID.0x80000022:EBX[9:4]
declares fewer than 16 LBRs?

> +               svm_set_intercept_for_msr(vcpu, MSR_AMD_SAMP_BR_FROM + i,=
 MSR_TYPE_RW, intercept);
> +
> +       svm_set_intercept_for_msr(vcpu, MSR_AMD64_LBR_SELECT, MSR_TYPE_RW=
, intercept);
> +
> +       /*
> +        * DBG_EXTN_CFG stays permanently intercepted for non-SEV-ES gues=
ts so
> +        * KVM can observe LBRV2EN and lazily toggle V_LBR.  SEV-ES+ gues=
ts must
> +        * delegate LBR virtualization to the processor (per the APM), wh=
ere
> +        * intercepting LBR MSRs can be fatal, so toggle it with the rest=
.  See
> +        * commit b7e4be0a224f ("KVM: SEV-ES: Delegate LBR virtualization=
 to the
> +        * processor").

Is intercepting LBR MSRs fatal, or is clearing LBRV fatal?
