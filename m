Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795193687;
	b=OwabNTi/cGDXs9VZvcbIfEYhY/W6sRw/WtGwY5RgaBoHgMTp5a+vT5HSEj4a4CEIjRLP
	 5ftQjUI5dmuU+o5ShApYPTxZiMWKofmGDvQIpYStAGjBqY7jfvkf21t7Ui2q4ug+NOR3s
	 19N4pqaHb/nz2mtnA4yuTbkAbHE5zXQ0I6sKEXMUtxT/EaZpW5kjBsBm85NzJCn2fX/lW
	 KpaApcu8lfOLSRWDbSlmbAlvVj3WibN23x/yb1xahWolKI5v2J25EXfPgcz994XEjvn0t
	 cSKHUIet287+AAlSqnPLlqlKRAO8ms9KtlBMV6+rMO8695Q0IgsQpmeuMvHKiCpgbCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193687;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=GoK52sV9iYkRCVLGrLj4ttkVHmfRaxoQO9rnKusqNO0=;
	b=02jMdHU5wiW4JxqzzdTZYuaLgJxifB4LPA3TJJVR9GDZVh4XKyjhcymSv+JMWbxDTh75
	 lX4QART94O40/m33XbDve2F7S97AKNoczjVDsgp/Ta6eFgJOcX4UmN75Zbyi0+Pc2lDxm
	 1G8wN6WwTjJcLdSiuwLIF0AA5jCF7mDSYf5+V+CykJaNWtwjj83kAUP2ug8jPHl6dJHYm
	 liCPSpZm0XMlCKssyPnQTam9oMPpRR8tlPeBzYe8oEWzdqWGdN1Xd0uZYRMrC1NT/vgu7
	 ip8lROr+v5ES0T3N6+pEfBtyZIw0TgFuaI5HQ8kCzHj/I5ya2GF5X/c7Z+bZCOn/OoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MzjCY2lj;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=J1dU570H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5F606A325
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 16:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C5F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MzjCY2lj;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=J1dU570H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795193685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoK52sV9iYkRCVLGrLj4ttkVHmfRaxoQO9rnKusqNO0=;
	b=MzjCY2ljjBG3EF+eVvW3DJDiAOv7hYc7w65OjPluQCIholsa7/uTNh/83uztghop686Gf+
	jlU/xGwpyYLcBQEmbdSgj1nukVyvQBJpyBditgaKnpmuPdOrDCVerswH2LG1SDkgLQN0Fm
	QbH+Q7L5As/Wgq8CW4lBm9yGR5vm/RM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-HLOcKepjPM6eG1kuy-lgNg-1; Fri, 20 Nov 2026 16:54:43 +0000
X-MC-Unique: HLOcKepjPM6eG1kuy-lgNg-1
X-Mimecast-MFC-AGG-ID: HLOcKepjPM6eG1kuy-lgNg_1795193682
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b3fa6c8d4bso2428721a91.0
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 08:54:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795193682; cv=none;
        d=google.com; s=arc-20260327;
        b=dAhM7fXui5wQ+oKgdzGLBTSazPtOvhVR10o1UC+FxD3yYA7oQTpynwlaZcrxDxD1uh
         QM1vdTpmq7AlN4YzA0dcXY4P02dvW+LcxCMtT98bbymZEAkDx56RlxdvX1SdSg+mJZ5G
         8VmZMdeu6RVYHAUSRgtZ5NoBIJI9C5EIxrxY31ltW1tbwLQds8LyjP4GS89KVRwlIdsS
         pan06S14xwrm8o+TlcZiBKDA637xmooHcwD4I2vb9hCueOAIrW6Ms49VN9EDFPT3MUuI
         ekBCtNyKQzje6wWJZKliZhXbOgicjzqPsx1n0HGV1wW359bbwmM52qp7/h3kOBHCmcC5
         cFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GoK52sV9iYkRCVLGrLj4ttkVHmfRaxoQO9rnKusqNO0=;
        fh=1pA1Rgp/lHHFDQxApc/PCRvs3Ckwu5yLTPu9WNfynEo=;
        b=aKGpFN/GmnSLsXYzuRjrgZ/tV0IT6REM/qulCUaqdaktTo6vNwbSoaXwtkP1wxUw/f
         YI49LzwlmqNaQl/hIF3AfauGvGVhlmQn+MuXK9X8DMPecLZVhFrqeQygHKoMua010u0Y
         j4g2YJa9kaQVgI6g9RAK81NepCt0YKgx6i1yZg9v8hMuwoL6SCDg1OCCFBWbQdd9o8Zq
         vK3x3Y0XQGYdJZz/qs9+YOfPK8T6oCaeRnoSph3xyuCbReNuq0AjIN3nYdH2xlh6fOrP
         OzkS4JKfpaKORU5ZV+SLtZB/ZAzcU8mcmBLeXp8NqK/20dtz2XzixX8F9QnDaudo/vqS
         u5Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795193682; x=1795798482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GoK52sV9iYkRCVLGrLj4ttkVHmfRaxoQO9rnKusqNO0=;
        b=J1dU570HJUtGAvGs8RUQ2NUlKfOT5gGKLJXKO3mExI6zjUWSAIiSYausr4LFAv+BKE
         aNyuM40sMBZvhyK06GH60qoxLymVRvRRjsjuLS3yHYmjro2jZwWRncS9KZ9g06HCa5JH
         vIfCxJr0RzLzzsSbYM+SSjXRRTIYHZStUoYzzvVH52olnn36EacdgMQ4pKzzOF5/QnkH
         zxGMeB2Jdz8/nYD4n8dQJYT/1PqtzeMSsyHsCUpS4j8dwZHN8HNXtEFLvEvCPPg5Nztu
         w34+gQL30b6IvULHV7AiO54mcQ1g5NDXNaTlBbDyfsMfMawC7ut2oLL7QBWfFpFk5K91
         o+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193682; x=1795798482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GoK52sV9iYkRCVLGrLj4ttkVHmfRaxoQO9rnKusqNO0=;
        b=z8fQab6CxKfoEah3y8WzVfAavrNiU8sB+lo5SIJKDX3XHSFImkewvsWZ1lC7F6CXBB
         K/jTQKtGHS5fkL6wsUVrjj0aWSgJlwWR4osBB0TjLqxZVLvipmo70b6h9oo3mpoDGhGc
         WyVc9LjVhZwXJZeRkTyFgc9wzCDPpNfDkmiI2At0IbjZ0Q5Ofm5o6W72ZfG5qLmrHFuv
         ClQ5heuiCMjIpS/gYD5+i90aWZfac2zZXlV8lLs+4qZdA/QWgRNPCpp3Jh2kS8xuc4wy
         gUVX90yG+dYUqt8jmxA26HY6gMQKSaq6qDaPJn4t9MTBmqdf5zOtbLdMcX8i7JHwfkjK
         +3lQ==
X-Forwarded-Encrypted: i=1; AL+hErEB0Kw6MvGeBwyPRUGSfoQMtmeqPH/NwyLGbk8vAJXn4XRWdR5LWi0SOhhXovzBL2jhf80=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dflmsdQ409ygHUdl4KQosp6nTqLJ8eVArUTEmxll4poGJVWjh
	I2G8HnNi4WpUK2WNGk/9iXjCitxQrOGcjQCasBiklAAFKmUEw2iNBVVWEQKBcHJNg+xh70/LPkF
	MLRk2/tofSdBYegH4BtbteQ4Cyl8xcJMbYYMempbC0XMapyc5iWCn/pM+nC9ASkTrsuCP3OlBQG
	jM65dZhWxu6SsLiE+N3rdTKkD27Kr4+FCf9TW5
X-Gm-Gg: AZFdTZe+PG//XUGG1mE/ZnrC5JwdUolGR3VTpAmlJzFbFT9OGGCMvnNQGS9mlGy27+G
	iT3ROqH/8naV2DAkQhmboc640P6dNFkm0SieD6NIfy0MVz9SHeplRC7ZeMKN/2/Oqi/CoEp3vKG
	HNHnKOgQW0cSCmGIamCUl4cDW/hZZgXbilKkVIIL4Ll5wYPwja0f5C6Bf/nN9zwVqoqTP6WpmGn
	UDdivZe+rPsDZS9DgtD3LNwCPAT4T5YtMK0IzOSi2112S1Oo5n/n3jVZPOjXxDqDAujAFP6pVoh
	ji8EsRV9g/+ualsVNQkE
X-Received: by 2002:a17:90a:e70c:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3b41c7bc5a5mr2651368a91.3.1795193681982;
        Fri, 20 Nov 2026 08:54:41 -0800 (PST)
X-Received: by 2002:a17:90a:e70c:b0:3a0:d7f2:5a58 with SMTP id
 98e67ed59e1d1-3b41c7bc5a5mr2651362a91.3.1795193681478; Fri, 20 Nov 2026
 08:54:41 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAAhSdy32nAjcz2vyN37Fb7nKc9jbUxWjUYjiYGda7NPhweJhTw@mail.gmail.com>
In-Reply-To: <CAAhSdy32nAjcz2vyN37Fb7nKc9jbUxWjUYjiYGda7NPhweJhTw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Nov 2026 17:54:29 +0100
X-Gm-Features: AclHuK_cN9rwoorx-PqMlIeeT3j5FStKrFrMBtqWNaFqSpH_A-AQRm27GLu6w8M
Message-ID: <CABgObfaQNmyDgwRNdM7O5MbK=c-TB-GhAMzMR7ds_2oz0r9zwQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/riscv fixes for 7.4 take #1
To: Anup Patel <anup@brainfault.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Atish Patra <atish.patra@linux.dev>, 
	"KVM RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, KVM General <kvm@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 12:25=E2=80=AFPM Anup Patel <anup@brainfault.org> w=
rote:
>
> Hi Paolo,
>
> We have the following fixes for 7.4 kernel:
> 1) Validate AIA MMIO address ranges before AIA is initialized
> 2) Disallow GPA-width changes after AIA is initialized
> 3) Fix double free of the split page cache
> 4) Do not touch the envcfg CSRs on the SiFive P550
>     (Note: SiFive P550 is based on Priv v1.11 so it
>      does not have envcfg CSR hence this fix)
> 5) Set Accessed bit in dirty-log write fault fast-path
> 6) Validate PMU counter info using available counters
> 7) Fix G-stage page table memory leak on VM destroy
>     (Note: This one was a pretty embarrassing issue
>      which we totally missed over the years)

Pulled, thanks.

Paolo

>
> Please pull.
>
> Regards,
> Anup
>
> The following changes since commit aebb7274476403040d582c61478df8f4a7bf9c=
d3:
>
>   Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-riscv/linux.git tags/kvm-riscv-fixes-7.4-1
>
> for you to fetch changes up to e9bf49bbc4227048685c78f97e1446845760df4f:
>
>   RISC-V: KVM: Fix G-stage page table memory leak on VM destroy
> (2026-11-16 18:06:25 +0530)
>
> ----------------------------------------------------------------
> KVM/riscv fixes for 7.4, take #1
>
> - Validate AIA MMIO address ranges before AIA is initialized
> - Disallow GPA-width changes after AIA is initialized
> - Fix double free of the split page cache
> - Do not touch the envcfg CSRs on the SiFive P550
> - Set Accessed bit in dirty-log write fault fast-path
> - Validate PMU counter info using available counters
> - Fix G-stage page table memory leak on VM destroy
>
> ----------------------------------------------------------------
> Davidlohr Bueso (1):
>       RISC-V: KVM: Do not touch the envcfg CSRs on the SiFive P550
>
> Li Jinyue (1):
>       RISC-V: KVM: Fix double free of the split page cache
>
> Pengpeng Hou (2):
>       RISC-V: KVM: Validate AIA MMIO address ranges
>       RISC-V: KVM: Disallow GPA-width changes after AIA init
>
> Qingwei Hu (1):
>       RISC-V: KVM: Validate PMU counter info using available counters
>
> SeungJu Cheon (1):
>       KVM: riscv: Set Accessed bit in dirty-log write fault fast path
>
> Yangyu Chen (1):
>       RISC-V: KVM: Fix G-stage page table memory leak on VM destroy
>
>  arch/riscv/include/asm/kvm_gstage.h |  2 ++
>  arch/riscv/include/asm/kvm_host.h   |  1 +
>  arch/riscv/kvm/aia_device.c         | 49 +++++++++++++++++++++++++++++++=
+++---
>  arch/riscv/kvm/gstage.c             | 22 +++++++++++++++++
>  arch/riscv/kvm/main.c               |  9 +++++++
>  arch/riscv/kvm/mmu.c                | 12 ++++-----
>  arch/riscv/kvm/vcpu.c               |  6 +++--
>  arch/riscv/kvm/vcpu_config.c        | 16 +++++++-----
>  arch/riscv/kvm/vcpu_pmu.c           |  2 +-
>  arch/riscv/kvm/vcpu_sbi_fwft.c      | 20 +++++++++++----
>  arch/riscv/kvm/vm.c                 |  5 +++-
>  11 files changed, 118 insertions(+), 26 deletions(-)
>

