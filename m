Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8231E37D133
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015230; cv=pass; b=JnwGtUKw2/L+2hJv4UhWx7lqDd2OvqRK4tuJ52yVKnlbrsBNEOQg82e3ttdk3cE6MokTutrC1ut5Qs6fFY8BFDJjG7CaOC4Bs9ClkDm2hms+QVw68mF1LVwraY+0/RgYOyMBc3vYuFcSJmslw55Its6jV+FWmPv7GmSR7bgAxeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015230; c=relaxed/simple;
	bh=/emYiK4WsQd1Xqtv4k4lCJqP5pFnFmHRgERYuuippP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnHopMlQT2XnjV79aDUYY3bnalWsLnYfByijEy9fnIf9lxH8vIeckDg+dHKNSdDcbKx3Sy1e1rEDfcrxu985lWoviYzgBSh7EfScU/YykOE5y30STFAvNaFyA93bB3vyPPYcOVWD6ikQT2QKb29y+UaUzmaW/xjIS+ony+KxPt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RexykTj9; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RexykTj9"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso346a12.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 15:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792015228; cv=none;
        d=google.com; s=arc-20260327;
        b=KU/Zup7gDBmxCN7m74PYaEmpUuDBuqvIwy5hfHYso2ipYfhdFSBGEd7J3bwuzF1kaR
         7CN0HUZgdzrIIvJYudm57L5YqqqogD9lVap+3P8Qc7g7FwZewE4U6dxGT4jBtZ4U8qLB
         MLX1jTfUsqKYv68n1WbK5lMu64F+dN++sXH+8aHdDzL4iv136CHj4T9HJ5zPC2+S9tkv
         GiSutONWLLaGbxz6GSYNfqJI+syK+3uinuhcDJW/jTn4a+KdVxyiTGY7guQFQEXaH1yt
         7kC6g04H7cvI8KdcLZCbFoDHfgs7g5upLIiCeYQDkKGzLXF1zEdRKvOjv835PvOKgEtE
         erdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6OebQYdvKbMgqOD64fFAkplCh9Qs+Q7ZSU1pBW6WnQI=;
        fh=Om1UfvugDW8ncDJk4nRB+htT5CwogDdrhW2AjzjEXO8=;
        b=KSsezVNXy3XgbsMd4y2rf3qjYGwtZPwTsGR8EML2f0m7yeZQRGx7FrtIDIOzOurE8C
         jsYatvEYfYzd1ZdxpYHV9BQlhbml/Bw474AYSzTbnZ85rxy4NicXQ45o++0vKyY29ONw
         r1Jq9DeRMQB4rZaXBuwBQCV+T/wGEhAh8jKpmnpFQ1PUUyeiurLptrW/CTwmL8KwZscG
         1QKUtbdDch87Do2BD3eK+mS9SRYkht65gKEGzMR1NKaNv0pwRcAfjQi7kXvqJLaWUQXb
         bfgFRa17hx/yGgmipd4jyYQZ0F0YmbDPvz7nIGQIPkQPRx1u5uY28iFz0UaQanYiRL8P
         nKMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792015228; x=1792620028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6OebQYdvKbMgqOD64fFAkplCh9Qs+Q7ZSU1pBW6WnQI=;
        b=RexykTj9dd8jH6nIbPym/TArpSjq6D6yXx78jJGNW8LDpTv20a7IGt01pkeam9fI+c
         J1CEZYgY7YQM6cFa4jwpCm4P/l8ExwI/X7xvSqo1oDHySVAJb0mm9CRE7fpLZ0+3+vAa
         81ekCKeZXHW96nOLFnEGeW39ceFm5XdntwtsFmP9vGJxjqfe0pgnd6FREAJ2TXYOaOC2
         6H++/ngBpeZwXv88Qf/NtA6V9p8SOUxuWB0xi2eDdrv0gUnGOyt+2xC26J6XmfG3HYn4
         2IuE9gzI3OI+dbASrLHtiPk8jZmxwYLhEIf5YxF0gVarBd2HmdWFUSuDQt/a5W6xnT5R
         5FpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792015228; x=1792620028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6OebQYdvKbMgqOD64fFAkplCh9Qs+Q7ZSU1pBW6WnQI=;
        b=ccHhTClP/avCtC+j2zu2FaAe3hKzUq2c2CuXXexpHwk3owKPxiaRx/Ump+WplMieQf
         DpTttrkv+zZBJ4p1r6h8/jREca/jHVRsinVGqNrJ5yzuC+buSZQaS9qpONz1jCf8XBFr
         f33UacQJkElsIJTGzIGA0sETWeS+VvCl6G1Q9GhZjFH2JTpCmv74EUhTAFVY0Px5y+Il
         WgAuQFhtnpjewLxxQkgnxQ+ZkIx1ptl17Z/No+NYGnxoQIoJlCc8OkbcXH2gEvbOp1LM
         5xlHZWMN4568eBmpvk2ynlyTBphrFKVYCxcS91F5wHXtiG6v1eG7ukW8bjvQxopnH6b6
         fBAQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5sk8usU0Foo1BOc903wPduHg8rs1Z98eDVT9KvZJ4WFkQxYDbaMXJtYrpPQgwLD0vEic=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFq0o09Apzx8URNrHYjhe/w3njCCr+QBQoTt5+yWPd0ODemMsW
	5T76zGHo3VqgOlzsWH1Pbgxq2qnzlqdqG+bkdqPN5nIwjXCWwmMaHVPNF++d7lEm/HnB1IDAURD
	WQZqstaM6hz9I0Vq0+t15pQpPBn0mXTQO3N2z8jsjSPQnHkCBu+bKhf563g8=
X-Gm-Gg: AYBFou2o3yVasuuOn2jurP9ao27IQB7IlX/CMJwnf8n2O2mzIokf7aR/1r1hnGlE0/z
	WkdEXeIDDCBdwxd9SP0xTk4YEAWejc+bSp5BSteUdlbw7+eagF/s7/DU3iup/pwyPAHf4iu77wV
	5P4jJQLIrM6/agQSSHxKN7BnOoRb0zUavEVmZj7iyv4h2bFIQwZBYROYd7PVec8TRZLzYdN8AqU
	dh3ayhBOOqg4rtjd3P5uY+2JocN2Jlgfveag1dk4rQs2h+Lu1TIf4Y60n6WZI3uNglr8mGsJKuU
	fJ833YEg3hxstM6EANVkFIDofVi4Ro1tBnVmgxOEHbiRFjtbwI3FM5MVrnouTaizGg==
X-Received: by 2002:a05:6402:424c:20b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6b20aad4720mr18371a12.9.1792015226706; Wed, 14 Oct 2026
 15:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-6-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-6-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 15:00:14 -0700
X-Gm-Features: AclHuK_0kBrRqooEuDpz6sx48p3ynl5vzugVYTkfuTyIPrqM8TsV36JOMpwehkA
Message-ID: <CALMp9eSWazT=0tXKvGb9UNWBv62di33QgugQHOa+Bo2sq0qUCQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/27] KVM: SVM: Add helpers to set/clear ASID flush in VMCB
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Introduce set/clear helpers to set tlb_ctl to
> TLB_CONTROL_FLUSH_ASID or TLB_CONTROL_DO_NOTHING. Incoming changes will
> eliminate the use of TLB_CONTROL_FLUSH_ALL_ASID except as a fallback
> when FLUSHBYASID is not available, so the helpers will create a common
> path for this.

No functional change intended? :)

>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/svm/nested.c |  2 +-
>  arch/x86/kvm/svm/sev.c    |  2 +-
>  arch/x86/kvm/svm/svm.c    |  4 ++--
>  arch/x86/kvm/svm/svm.h    | 10 ++++++++++
>  4 files changed, 14 insertions(+), 4 deletions(-)
>
[ ... ]
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 6d0242966dc87..ba5077b9838c0 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -480,6 +480,16 @@ static inline void vmcb_set_gpat(struct vmcb *vmcb, =
u64 data)
>         vmcb_mark_dirty(vmcb, VMCB_NPT);
>  }
>
> +static inline void vmcb_set_flush_asid(struct vmcb *vmcb)
> +{
> +       vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUSH_ASID;
> +}
> +
> +static inline void vmcb_clr_flush_asid(struct vmcb *vmcb)

The name of this function makes it sound like the inverse of
vmcb_set_flush_asid(), which it isn't. Maybe vmcb_clr_tlb_ctl()?

> +{
> +       vmcb->control.tlb_ctl =3D TLB_CONTROL_DO_NOTHING;
> +}
> +
>  static __always_inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
>  {
>         return container_of(vcpu, struct vcpu_svm, vcpu);
> --
> 2.56.0.385.gd3acb90ef8-goog
>
