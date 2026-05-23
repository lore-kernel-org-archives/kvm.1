Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7443002DD
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779523503; cv=pass; b=VrwaK8mL+WHen4l+pJDoWWHJzAQUf294RLR0R14lmkgFOTlLzSfOKVoHranc57FMOteFhn2q1aOsQlUK2K/3GH/8+3/h9ENa6B+hXmrez/wf3hcIQzzWAypfbyQe7RsmlejgYbzQsxgg60misSmiYaQwO1Ta8qH8gBx3/2A7z+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779523503; c=relaxed/simple;
	bh=mmkAID+IJO+Hy8aLfdWzLZnA/KqKrIg7tcjpof9RRTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEeXV4xVbmgf3304WXQNSrxjUQbuDYAVGZJW0/Lkq3kJazORYtucJATRHCTzkjwLZV5UI+kR6wzUOHszzVwCZO+Pl0QnNjvi5zYv5VJN6+YsDouh+sS+lNjQ+VLRATmPHC4FLWsMZGaw7+UHJl/ZbP7RY/PcNvKawKxLjockFwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZvjh+jr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tRnKFrr/; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZvjh+jr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tRnKFrr/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779523500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6lOELN7ZYTPndYRuMvfJzrgaHiXzqIeclIzONy8ARI=;
	b=MZvjh+jry4/6BLVx65iMh+2395Ds/Adbn5BzAmnKEGzCFlKUVDpKMqyC3nyg38O+APCSM/
	wzVRdzJujIwMcMW0Vh4B/vaFvQYazsYfFDFDc4WJLzsBGvCUXLdk8ArqGM3Qlez8cALd5/
	juduJhL/l1rdIe7+A2g4gHVrJisab5k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-T7hkDsLoMvOUn5o3qZOc0g-1; Sat, 23 May 2026 04:04:58 -0400
X-MC-Unique: T7hkDsLoMvOUn5o3qZOc0g-1
X-Mimecast-MFC-AGG-ID: T7hkDsLoMvOUn5o3qZOc0g_1779523497
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4904bbc6094so7601175e9.3
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 01:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779523497; cv=none;
        d=google.com; s=arc-20240605;
        b=aXsqGe3OZa6bWF0nd1aDAe1ytbXqCFJEOezwEQhlMufIbySjtoa9TDol9rUMdzYmcp
         xi9/XRV1+f9Jnj2DYl939zcDyspU7/pRF9OCLeIWxV8kiagiYdICzSuwRDCgNNjlVaoW
         4bJ72pFQM+2DoAENCLeshSeaAGNa//98PvsBcO4MZ2efrKQwTpaM+mRTpECHPN5ehXZ9
         qE9zl5nTmaKQFsAO1usLhQ/p4h0nM33K2S60tAoZHqvpIzrlUANSJQJbrCfJON7HIJuE
         KojJf4t/7SLLE9VeO3hTjuifO4OckUZ4Rktz3VNuekHuH5U6h7IfyVZhRzfB+ob8fi+N
         /WfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/6lOELN7ZYTPndYRuMvfJzrgaHiXzqIeclIzONy8ARI=;
        fh=XSN8PiKc2JyLzD81lx4cwBxZeILVh1zt/O07AJUr2t0=;
        b=ZlnWKj7lyhmh/b9gNf2Z0+o2wH9yPaqUtmqzrmjxz3vanaMfBoVZ5awaDFOs3jCkYY
         2UGD/FwY1CYOggyhsMrciNuyq39lV7bDgsh3afbmrutTxeMnMk4+j3zPCjnbnJ9UAQZ8
         OAzD8InptEFWEVg6fil7byCH5xx9KisEWShr/wVvCHewyi5R110mqPn1+srPrKZyU61b
         HbNKtzKNyL/C3z0sh+/3vhd/AwRIT1iYx8qysfuU+HfHX26w3QNcONKxyFKRiFRLiobH
         G8fzcHYxwkxHK7E8RjOC7fhCIPEWrjjpXt1tkf5WrdXZrpGzRynaYP6GHFKQ90I7jyYJ
         HnEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779523497; x=1780128297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6lOELN7ZYTPndYRuMvfJzrgaHiXzqIeclIzONy8ARI=;
        b=tRnKFrr/odP/j7+G4LK7ccDUDmGwoApDOjHIh32pHVY2Br2RzGpHKSsDy6j1xiwFDa
         WLTx7eJooQcwLAlUtGJE/ljlQdhj9eIB51h12EqhDkaeBySVKh1GVqw0uc2rqcYULHAE
         jxPCk0pkEoOH0GP96H4AkW2D+L961PkqKm3quSo4FEjYnTZs9k/ixbCMUciZTyoBffUT
         4OKmFYN2knNq7iGdBfug2BDrMgv4tu1tTPVsxS1UaY2cGuAwmAXfo1xeExhjGK36aaKU
         hJWTe9D0lfkUcUB+fKkk5xj0kdyIE1A7AcrXE7l8XAurvTJiTJ+eui1SSN0ltAULfVV4
         rD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779523497; x=1780128297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/6lOELN7ZYTPndYRuMvfJzrgaHiXzqIeclIzONy8ARI=;
        b=eq/XMZn6tXJeQj4ZBihHzXcrpXtVsBJsq9PkX9qTY5sxizYAMBnJHNm3W8O/23xXur
         HnMEo/MwP1mEOrw2UtpNx7zWj2GIrYoOp4o4uugtetADdnkLdxSy3bz5wd6nGxSJGm9o
         H2mpsHWwOmBBnUyHvQmUL4grAVKC+McLpUXWENjZUWpK1M5/hTCFdOEk20BlAjQsQKEa
         eG1yuZjdtpS1GbN6WG3aDi4YMibVuv8nzl0UUnY+wPaFtg+tVivb7CUjcF6riCUhD3zK
         q1wiReHKPD6Xl25WS9+lCBJYv4aAqv81ksT8AAlGjRumBWfzqo5GsYkGrL+YbFn73YGG
         WRWA==
X-Forwarded-Encrypted: i=1; AFNElJ+jF4mu8C9nm5LyFVIBJU9KGO3RMjZfx9TEFHop5Y8p8ZoU/ge79A31x+el2hGYwixdi9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxBVmCKUlPWD++5nc0ZP673cMIRaQKlq3CA4KN/FyuonFquiBE
	aS1FFgiD6wbSuYzto3ci3e56FWEQGfpY5V7HfCVvVlhJrAYINVOQ+gSh4/P4OvYo6NvmAdYd5KZ
	hr/8dlPQe++Na3nDeaL0w1wEI9INKtzdUfAizWczMR3czk75VmDN9eTktvwGBQ0FtCpg+0pNWQA
	DD8QPNVKxKUJIbFe+A+iqTS47vQg+Z
X-Gm-Gg: Acq92OEHv1A+A9CMjlHVzqDhe5/UAR0ViGAHx5rZ0+YG9M8zJe68Erdgo/PP8CMvWs3
	C/7YkAxudGfi7PewVC3qhq31L4LJZTWPVAyAwyJHCjqxIbhAizb7mWPg9lJK+9M8p2OdIkc/Klp
	OArnRvPolRm8wJJdg/o56wZZdYViQVD5y5TCr1E1DYmTcsYwd+EdYNTrbDH0XsPeA9SxJShlca9
	yjRpfdLq7v69tYt5dv69BaI1OIvwKkMylIxwsMWFm8SDHG5sUQSdN/vb0bD6xS7WR5lR/1md+QB
	F1ZV/2o=
X-Received: by 2002:a05:600c:4510:b0:48f:d5a0:284e with SMTP id 5b1f17b1804b1-490428e03b8mr101727165e9.28.1779523497076;
        Sat, 23 May 2026 01:04:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4510:b0:48f:d5a0:284e with SMTP id
 5b1f17b1804b1-490428e03b8mr101726795e9.28.1779523496671; Sat, 23 May 2026
 01:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhSdy0-joewqwsJNkMgzKvc0zh2cTFgTqdP+LZAAxmfEd+Mpw@mail.gmail.com>
In-Reply-To: <CAAhSdy0-joewqwsJNkMgzKvc0zh2cTFgTqdP+LZAAxmfEd+Mpw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 23 May 2026 10:04:44 +0200
X-Gm-Features: AVHnY4LmO1eiTue2Ym-q3YsTPGm0iPVz1DvdL1ekeTtanMGSUFVES61GYaQ5wM8
Message-ID: <CABgObfY4SnyfuXZXDvBOj7bWKTziHky8JRVSQ6-012x6TZV-EQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/riscv fixes for 7.1 take #1
To: Anup Patel <anup@brainfault.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Atish Patra <atish.patra@linux.dev>, 
	"open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, KVM General <kvm@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 3:06=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> Hi Paolo,
>
> We have the following fixes for the 7.1 kernel:
> 1) Fix invalid HVA warning in steal-time recording
> 2) Return SBI_ERR_FAILURE to guest upon OOM in
>     pmu_event_info() and pmu_snapshot_set_shmem()
> 3) Fix NULL pointer dereference in SBI v0.1 SEND_IPI handler
> 4) Fix sign extension of value for MMIO loads
>
> Please pull.
>
> Regards,
> Anup
>
> The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23=
c8:
>
>   Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-riscv/linux.git tags/kvm-riscv-fixes-7.1-1
>
> for you to fetch changes up to c7832534a8160276cccb9a8cc8cafb5614c579d0:
>
>   RISC-V: KVM: Fix sign extension for MMIO loads (2026-05-18 10:19:18 +05=
30)

Pulled, thanks.

Paolo

>
> ----------------------------------------------------------------
> KVM/riscv fixes for 7.1, take #1
>
> - Fix invalid HVA warning in steal-time recording
> - Return SBI_ERR_FAILURE to guest upon OOM in pmu_event_info()
>   and pmu_snapshot_set_shmem()
> - Fix NULL pointer dereference in SBI v0.1 SEND_IPI handler
> - Fix sign extension of value for MMIO loads
>
> ----------------------------------------------------------------
> Jiakai Xu (3):
>       RISC-V: KVM: Fix invalid HVA warning in steal-time recording
>       RISC-V: KVM: Fix NULL pointer dereference in SBI v0.1 SEND_IPI hand=
ler
>       RISC-V: KVM: Fix sign extension for MMIO loads
>
> Osama Abdelkader (2):
>       riscv: kvm: return SBI_ERR_FAILURE for pmu_snapshot_set_shmem() whe=
n OOM
>       riscv: kvm: return SBI_ERR_FAILURE for pmu_event_info() when OOM
>
>  arch/riscv/kvm/vcpu_insn.c    |  9 ++++-----
>  arch/riscv/kvm/vcpu_pmu.c     | 12 ++++++++----
>  arch/riscv/kvm/vcpu_sbi_sta.c |  2 +-
>  arch/riscv/kvm/vcpu_sbi_v01.c |  2 ++
>  4 files changed, 15 insertions(+), 10 deletions(-)
>

