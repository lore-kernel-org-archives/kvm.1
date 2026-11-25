Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795585828;
	b=zHOuLXkLogLaccG4nokkw9Akabwk1LJEnB1/ZIBFUqXKYwwBYO7AAsqybFYzvzuHjVt0
	 gEVv/lban4tSgvOX9zzblCnGAKwvl1ST0yAiZtXlbZIx6kghFWJoJlLASImvS1ruO1Y9e
	 kMzjwAceWjpqUmBcKQokd/MW8HZqjGMKZz50sMbc1WUwAC2adlaj3BXm+ZoLwTfhk0V3G
	 0oEakFq+Q2Hzu/YhcxwxmHUoFWDIuK/zcrbWeM2JByOwFaGquHLBIB+fEr0D0Qf8yH3Db
	 +W+SSP/rrY8hJt+rU/AMxNOAIQry2TleVQRXCrEp9g1CzW7OWrMaMZByczJkq51BmAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=h0QzRh8muxydOHGjX2h5cehhw+NrrMdYMgJiE84UVD4=;
	b=w9B8hBSmOJx7Wm/rdPtWxAqQcEy8xNE1zcjddyVbhTnMteFwFjfv/8c1+8WVZv5kza26
	 biFBYf8+oI0rYNU3C+5M1d3+zVlSws0aic820MKTRcOhz7qmfu1YdWyvfBZ+IMzQSJauf
	 CUEg/DcuCBD8rwzXq/wwCOWtk39uXmi59mmQY9UPlYH4OUi3O0vBHpLypHTpJjf9aD6U5
	 SNohzzLjK9iaHUf8E6hgGDlZk6UX9Uh7wPY1FTKXHRFkHiTX0S9ABdoQMVsEwW+CL3ahh
	 NC02UCv+FsPtPf7beQN+omKNEV0UHJEMquTqp1h8mKdMVrJZsmL3tsxfY+rtJjvJ2OA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b="qvI/3qli";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3102606A329
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 05:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3102606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=qvI/3qli
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso3026302f8f.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 21:50:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795585826; cv=none;
        d=google.com; s=arc-20260327;
        b=YiGOyuNohG+HvlWJwtpg6K4J8P8dCgIIQhBiTCV94zXSCAW3oelSGB6w+ZHKZxrdCj
         viwEVkD8vlQGRMaJodcm0NqMQSYL/4BDS5jRBul2+4uYEMS1kaE+PSHbY6K653K864zL
         OumP40ZOXubFJmBoYmxDz5kxXfS8wdOhfpZ3Pj1O+hz2DLu3V5+sIr+6RvXFeQnLPIXW
         Dg9GBKZmrpsV9FgZKBdIe110jn3cqMz9J9K0dzqKY9AtSLuduJkXP9vkdnxjC8TDHGAO
         EFPLZ+URIAu5AXfyX0332xlx0NP3DFh2JbrC+DlqV6fbJ7yQefG21liJpfmGD5XWRw/h
         FA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h0QzRh8muxydOHGjX2h5cehhw+NrrMdYMgJiE84UVD4=;
        fh=RxjcduaFltxwN6gZP9xTvSMtrPBmq/x4Qc/I7PEM//w=;
        b=hbh3jq0bdQo2V2uJ+LOZv4idIK6Cta6pc6teUdgMkcceeBe4l7jf+Yg7pRkvjvjL53
         654evo30QpyHsKXr45J01+8mIl2+AwZXNEohAAV8TN6U/u52zDlKGOoDEKhHbpbc1D2e
         b+huwtzB2eZLCz7H13X69X7wwZucCxL8S0TkMk7RR7Jiezag6THCqlEbJuH9deDnHxK4
         co2RaMDdb2uYYOr3MfV+90YVDS9MT/BbQCJfa7E7CozbLqkmc02ZjBDBCLJda7sS/TTL
         CTnZVqjQau9wK42EBo7JemjHXA0amVQk9kNmlmsm9ep01s9QMrqI/6ec2wwGutfF+lJW
         hLHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795585826; x=1796190626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h0QzRh8muxydOHGjX2h5cehhw+NrrMdYMgJiE84UVD4=;
        b=qvI/3qlibVawrt3J6HO0mHmcB38ldsVi0ERoyN8hcddPDVGOUsBBPxFi7GtPAzOkTi
         jHIBO5XgIkS8+qSRnSfu4AF8lGN6QtSJjMhDbZ1KsvQD2iwRkNMtBWiQc/J0pUim1FpV
         v/oQaDD3ahh2NxhAAqI7UiKrzbGwz2GqH4Ml18/vQ35P9wrkEVq9Md9WtFNuJNk/1Yrd
         4BdqavPaMAcr8qq2fp96HXbd7ynPJJo9ZiI80vXFwb0NA+s0ibHDEgTDMtVdK+zqXVB+
         QwMZLULdd2+Nl/KZnrZD8+VkGgRF6o2Q5Lriml25R3ZYM4MT3oy9qrhNATOjs0DoaDt8
         0K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795585826; x=1796190626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h0QzRh8muxydOHGjX2h5cehhw+NrrMdYMgJiE84UVD4=;
        b=HmJMmgfaklS8f/wlV9TVdzm97dQiYi4lUDYp0SjIVg6jC2rX65rMB6VUAyMQaweJJA
         gqIcWT8nv0Bu2skzQm3SFvBgg+bQ2JV740YeSVT53qsAN2z8t10DdfvsiXk2VSRoL3Jo
         Cuz4QDlzlQXbIVYQx4P5ulGERiJBXzFMICW+Jkgh80ek9uqGingJb9PMOxfoyFrFHmtd
         dZG1l+v3wrd1iPccGh/Cz7FfYNgVURbTWjZAssiF7Ls+24fisghhKD4DeK9kaaHD3ulE
         vTWgvoVF0MRM9byRH8TQIsdzfZD68VRaO2XTk1JP5Im9p+/4yyw5w2iGGmwrmXCi2ujp
         xZvg==
X-Forwarded-Encrypted: i=1; AL+hErHWmfsmBu8WTmAPmBU+PDGtBZoTHwmA8RH1u7gpVFefsyUccv9mh+RydbG0bPgotFf/eng=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QSjMhbwPLO4aUB7ZZJ+NZKGRE4557zEoszies9792amKaPGxo
	iXOVpBC+g2NEuGzWv6eCOOv/bppO0ZQVKVQx5j/TGPkOhttXVaxl7k+G1MLc3zPszalp493fu8s
	t3yQEJ0AU0xp0gfMUDD6F5xuaAYwGZepM3ulKMARTbA==
X-Gm-Gg: AZFdTZe1pf74SR+JgS4MeK/EsgH2vdPMCMWiJEgZw8ugdqH19o9RKT0z7kNpS1jgI74
	G4UBF7P70dwQOftqKg+IKjoZGvrhaY/hC++VO7/QMqAJb7dHOZIHD1Pq7U+P/jRVpwqOFaPetM6
	Xk3uIvRtRL2zudUfgCHhygfFV7okLYg3sGEgE+eG4XanmQeLSALQdVaSbYFAlye+XvIvnjowDVz
	HeFJzXrwAuXtuQBcGdadErZ+NcUu+WhCM8oZxn/yvroCu1h9/+U2hBDgrL1vIs/A8QJbgoUBOIX
	ONAKK05ZQPpMDCfEEdzZuqbzYe0nBsI7DKGm9xAiw895QLa5DOhSO7ICwbdwox5sUi3E5YObj7n
	N0tX4UkJ5xVoI7CZHXrQkW3RFE/aT6bthSAaKswNhz985resB3jopb7etY6GtzD2cJK8igaQfQ/
	0mQKm+AEgk99MHwQNXzp7V4p3pI9XJR20VEonwlCF+w+l1BNHIUWS3xTw=
X-Received: by 2002:adf:e00f:0:20b0:48e:932:aefa with SMTP id
 ffacd0b85a97d-4abb27268e7mr22701177f8f.26.1795585826178; Tue, 24 Nov 2026
 21:50:26 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260921111402.120911-1-suunj1331@gmail.com> <20260921111402.120911-6-suunj1331@gmail.com>
In-Reply-To: <20260921111402.120911-6-suunj1331@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 25 Nov 2026 11:20:14 +0530
X-Gm-Features: Aa3M54oFEe_Kg5fzllo_hPF_KMY1sHlitMVjRaBnJClbHNybVQLzGtgAKkyplS4
Message-ID: <CAAhSdy3-0fHHE2tpRRimhOTUWrN01Ju8Mdt4=R1UUp1atwsifA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] KVM: riscv: Age G-stage PTEs locklessly
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Jinyu Tang <tjytimi@163.com>, 
	Wang Yechao <wang.yechao255@zte.com.cn>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 4:44=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> Aging G-stage PTEs currently runs with mmu_lock held for write, taken
> by the common MMU notifier code. When MGLRU or kswapd ages a large
> range, every vCPU taking a G-stage fault blocks on the lock, and the
> dirty-logging read-side fast path blocks behind aging as well.
>
> The preceding patches prepare G-stage page-table walks for lockless
> aging by using consistent PTE snapshots, preserving concurrent
> Accessed-bit updates, and deferring page-table frees with RCU.
>
> Select KVM_MMU_LOCKLESS_AGING so the common code no longer takes
> mmu_lock for aging, and protect the G-stage walk with an RCU read-side
> critical section.
>
> Read the root inside the RCU read-side critical section and check the
> resulting snapshot instead of checking kvm->arch.pgd separately before
> initializing the G-stage context. This ensures that the root used by
> the walk remains protected until the walk completes.
>
> On QEMU TCG with 4 vCPUs, running dirty_log_perf_test -v 3 -b 256M -i 3
> with MGLRU aging of the VM's cgroup forced every 100ms (86 passes):
>
>                               before      after
>   mmu_lock write wait, total  44.4 s      0.15 s
>   mmu_lock write contentions  1,002,092   30,092
>   mmu_lock read contentions   351,937     0
>   guest dirty-memory time     18.6 s      16.7 s
>
> Before, 93% of write-lock waiters were kvm_mmu_notifier_clear_young().
> With no aging, no meaningful difference was observed between the two
> kernels.
>
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
