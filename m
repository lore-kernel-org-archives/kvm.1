Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5863C2772
	for <kvm@vger.kernel.org>; Sun, 17 May 2026 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032468; cv=pass; b=VYVHNv6U9VLGNQHvDwyvF9sGirGn/D/H9MRfHx7SuQZEWwegjI7EN/r81yztSmRSrqwoHA/K56pJqliwRMU+oLRWW3jZK5bxBMp8mddigO1LzxQ96PPRf9lYYDkjE1+RdkQdwe4ZtODPcd3kPGOVvuwI2vFwK3cyRPAfmQogDKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032468; c=relaxed/simple;
	bh=GRgD5+JTciGD1tUBeEc4nxDNdhOItlQB81Qudo+c9hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivKTM2afanBr0aVwrx0uAMaQYIKvSZgKbsYU2w64Idm6rSnKMv8GgaJS7POvaUjhwX3QsNIwSdiV0cmHvBhnsWl83lEsBLagDN6x0KcU2+Yx5qgZrTDMUsoPg2wi9HMSsy7zwUQ8jNAl843MSG+E1oTphaEBA/l27kyGnVeJ93Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=jWOiACRZ; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="jWOiACRZ"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e4004a4a6fso1749025a34.1
        for <kvm@vger.kernel.org>; Sun, 17 May 2026 08:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779032465; cv=none;
        d=google.com; s=arc-20240605;
        b=eTTTDh9E3GbpmQTG/TpLH6ghGjCBnzB5ISWKvf/UkhLjXCetpoOVRMPMN9N6UzAF73
         +3FkvlL3CGhfrcM1RFB3j7PcyK3Zjnaoni0yT6BPSsXngbN30fmhu6QMkjEphbztMIQs
         HnFDaUCPHWORGY2ToRZxpM+fXx+pNmK426lhSu/wOEhte3cfNHcBjBjHW6iC7ki5uamv
         parneeagGOQ/1P/96AQ4Nx60NDVNyX3E5lZ4tAYcrCeaU1vTn/ZKqWe44h52SVK82B/+
         atq0pdth5/GUlLbkDiSQl+OQGGAzVhDgBPCFRM0EfwPvHj22QduCdtVPiFQyjK0PAJGc
         l7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M0PlNFCE2Ddf3BbVrhfMNR8SsVsSBHNtjC+3F7OAG5Y=;
        fh=RmnAn2h7+DCXerIDfUO8bloHF4MM2bHrfJu/yNMcwwU=;
        b=YGY3jY+nytOZ7Crji3PqjcYrgvV9vlXiUSUw8/WlZcOHl4G7FIao67e0sCZndVzDJ1
         CKnsXT98gwr9xwXHharaj19gHuie/nkbmmmCy5ou1Qb3ukICMHx09C2LXlvTCcVDD7UM
         l4iRq8lYN92+L4qed0FMJ/nCoHVQmavLUIaXblmQAck5LInuEkESHM0iueXH2PdOU5CA
         6lN2jZ56G4LJdc0MQtXxpt79D1+nQpLI0unonevBotk+ceLbJ+C4ySp7hazpJwGZGGS+
         lSh+JqxIvVuV1YN0dtigA8QOURVHxqQO5ilY6JyALdSdfmy351wwm42O7xZ007Ezfct5
         we5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1779032465; x=1779637265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0PlNFCE2Ddf3BbVrhfMNR8SsVsSBHNtjC+3F7OAG5Y=;
        b=jWOiACRZ48MtreyFdx9nb+NpKrNEelqFfJaswr1xSgM9eveRMnThGQ2hkAObjw/6NE
         Af8JB+0QEtdpd/FqPvpcQ5Tj++74HBHBdVQGu+gek/AFFCGnRVy0sdM793uXySqUT4gl
         R1IuzVNFg5Tp+UcC2HtPS/3yb3Dj+d+yGgThmnZ5CbIgDLlZtPzxy+i9rRJbGwvthxqW
         AhinxlsQewrzb9K9gpw0bxZMtOc8kXCYyNQS+n2lsg1Bx966PwDdW32NETghLwOwouwA
         Ql1Ie0rRpqVpEIO2aotpHfZXL6XfkVTt8gCTmjYu/I80hSehyMsFeGPZJ+chHqWJN0/U
         1uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779032465; x=1779637265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M0PlNFCE2Ddf3BbVrhfMNR8SsVsSBHNtjC+3F7OAG5Y=;
        b=cz2hTwLuzqewi79ahFj0iH1+BBjo+CVlVYd5lNp1dyoZHuZXDLJdq/M0WYwnOlg5pG
         DWZrWfUt53Jvr2kVikxIu0CD24XjGmD88CsuvTwOsqNZpg+4morTwiB1tMR03JhsTzNN
         fPdkZaPh2ug2NDLNOy2tBUf4qjBiTReJnIHCDMpz6JFhAL1eOQ9RxHMapbK5DeMXXfj8
         2buohv/MrzvcFy28r/dIyf44Q5Th6DNiu3gQUkJn/6I/jbhGWdX7Q7o+a0tUYhjyscBt
         SUYMpf7Q1dZAVp2KQ0/q9mzRN926UIp0iahnmLm0d/ov795HZNGYpER/SaDl6hrcATlk
         BQrA==
X-Forwarded-Encrypted: i=1; AFNElJ91eRhsRgLDJ27QolwtPj7OJeM7JKB+Oc11VwvVoSEw1AJMCZOc6JnU3QhP9+usfvwc8ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypwait3xnpH9LSqcOwJXjxatNDVV/lPZ0gwCX76OEET7i4rhqe
	Opx7Xx2qXlCRMWe5YJW2d6+pxFr264ExGdKKemuLEXKFOO0hwKeOKtrB9GhEoJA2lmALIuDL29t
	hm49ouQOK3/vWFkoVH4K55CFGdKHurAn4wWBgzX2/Hw==
X-Gm-Gg: Acq92OGHUMB4VYceaRW61ZS4SyY1hCM7Kr8ejgXEvsQ1YqXHFMRcB0+9bX/pk/66EXf
	7qOl0FG0hU6qij6/ARjvE62kdUEyGGp3WWWP5xfUNzQg4SLXS/I5qO7xgpaxyYdAIe3diFLTYRq
	vIUKZCAIhKu7PlNTsatJuVsE8dXSvZmabB0bxQrVAtIs0wguhwHDGHvrkMpcBfq3qsMz4Ts8nFc
	4+ZJTmQrSrVAex0pucaMkEBf+BF8uMWcgkD8RBhJmSE3t2vk23O15DXXgohUyQxz3daFjvELUNE
	TQgoJzEfvFv7pNzxQDiMeAx/Mt8U6+J/Ek5onAkD8AQnMev3FmQjXsKkyx3S2Ig0kFWQQTYz5iX
	Np9tv011q3JHt5uN72V8JSF3hQw8JHBVp6HM7
X-Received: by 2002:a05:6820:1b05:b0:696:2674:8a18 with SMTP id
 006d021491bc7-69c943688ffmr7938889eaf.35.1779032464846; Sun, 17 May 2026
 08:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517124414.420919-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260517124414.420919-1-xujiakai2025@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 17 May 2026 21:10:53 +0530
X-Gm-Features: AVHnY4LJK5mceV0jtKoEXm7BnXz6dh6qkKEbPTaVu6WNg2Byna91HbXT0gIv9pg
Message-ID: <CAAhSdy3JTPZACJyKTCVsQeiDf+shPn9qnn2eLa=7Yr+73HjqeQ@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Fix NULL pointer dereference in SBI v0.1
 SEND_IPI handler
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 6:14=E2=80=AFPM Jiakai Xu <xujiakai2025@iscas.ac.cn=
> wrote:
>
> The SBI v0.1 SEND_IPI handler iterates over the hart mask and calls
> kvm_get_vcpu_by_id() to find the target vcpu for each set bit. When a
> guest provides a hart mask containing bits for non-existent vcpu_ids,
> kvm_get_vcpu_by_id() returns NULL, which is then unconditionally
> dereferenced by kvm_riscv_vcpu_set_interrupt(), causing a kernel crash.
>
> Fix this by adding a NULL check before dereferencing the return value.
> If the target vcpu is not found, skip it and continue processing the
> remaining valid harts.
>
> Fixes: a046c2d8578c ("RISC-V: KVM: Reorganize SBI code by moving SBI v0.1=
 to its own file")
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> Assisted-by: OpenClaw:DeepSeek-V3.2

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this as fix for Linux-7.1-rcX

Thanks,
Anup

> ---
> V1 -> V2:
> - Changed break to continue when vcpu is not found, as suggested by
>   Anup Patel. Non-existent VCPUs in the hart mask should be ignored
>   rather than aborting the entire SEND_IPI operation.
> ---
>  arch/riscv/kvm/vcpu_sbi_v01.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_v01.c b/arch/riscv/kvm/vcpu_sbi_v01.=
c
> index 188d5ea5b3b85..c9c323d4577a9 100644
> --- a/arch/riscv/kvm/vcpu_sbi_v01.c
> +++ b/arch/riscv/kvm/vcpu_sbi_v01.c
> @@ -55,6 +55,8 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcp=
u, struct kvm_run *run,
>
>                 for_each_set_bit(i, &hmask, BITS_PER_LONG) {
>                         rvcpu =3D kvm_get_vcpu_by_id(vcpu->kvm, i);
> +                       if (!rvcpu)
> +                               continue;
>                         ret =3D kvm_riscv_vcpu_set_interrupt(rvcpu, IRQ_V=
S_SOFT);
>                         if (ret < 0)
>                                 break;
> --
> 2.34.1
>
