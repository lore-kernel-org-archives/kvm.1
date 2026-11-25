Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795585840;
	b=h2+liMe3LNgpp/CCW9/PNeLw1uvsFLrxPP/zC0mYNtQjVaXqn+6q5Tz5On0Ly6u9L3JD
	 l89eQOIPOx7eL4to2l7ukwl16lA/1UVdi85/2IDHTJhKSnbmWr3In119ttz+Ui9j0mFod
	 o+7MaecXRvKFbzc1upuNYu3lPcBC7Z+jnZQ89Spa9JZTA7Tbnzo+ADkhrk3Ljfazm2tAB
	 PYCCVV4Xkt22rwROm6N+sGK1+rjVx6fcZNiDBKxBCKmr5GQrqyAT2aKQjXPTJTGGHmZ04
	 XUfRSjPTJzzUn8enliSNDJ3YOsCV6nC6uR41ZhCKJvVYvLU+8aODR3GXiZ7qfZX5fiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/ey3VoMnoIASJUisM8PXIjosjBIaHmMcX0osRpbhk3U=;
	b=fxVVTF5MuWUIMTi5jICFd4uaM9YwqrrDR6iuYyRiNbqcdpDb/IFiYS8jDhYRGu+hwxQy
	 XeAFPAy8PEQGzfLsZsErFwtNk+120aKVb3PJ1KrmdrVc3eNRLaRpgwLE0NxZRuuZFiY/n
	 S5qByPsJdrGNBkwC0u3GrLdu1TN2KEKqxfgR7Ipqb3hOxWjOGhm6JPv7nj5hzKklblV5C
	 taq7BLpPwjVNSpdo11SJWUDm39/oXQTmXSqCLYZO40nnJT1uvCwGtSTVdd5oNqjpLfrbq
	 BN6jVkj9ANwFXVxyqsudKxC9GYgtiluAce2BfKjWrAUY4ltV71uLEYEhEovCZKmzX0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=nZYWhBA6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163F606A329
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 05:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9163F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=nZYWhBA6
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so55050595e9.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 21:50:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795585839; cv=none;
        d=google.com; s=arc-20260327;
        b=mFvz0/g1UXknhu4bRt2Uew8s9sSvV9jlmO5XtIfg5umk/0amIxM6+FyF3fsWq3oIeX
         SvRJOXWnyRCiP7m8F9yzfUMZNm5z1h+aBRmjNVWA4/fNarn1H4N7Lmkf0X9JSKB2+FXA
         6PSFFy5k1Cq16y9hFqhIw8dzFRufM+yTsSJe0nif6vJzMXBRpZ2Ivzlxe++aEYQCLbEx
         v/EDy3c4PWKIIx96GN+3JkdSCmeocc3BnUr8lVzeU16grvQ8jN4bS/Ib3L3SaeoyhLps
         bxaP/cdVEx9bMv59jrf4k0B3pkAn7wy7++swtQHtKegwwYv50eKv0fQf+VCpSU7FLisX
         wnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/ey3VoMnoIASJUisM8PXIjosjBIaHmMcX0osRpbhk3U=;
        fh=NeRDsOvowMnefBPx+qaoLl7Rf5uk+/rZfFBmWQqefJU=;
        b=ck/qlGI6+Pj8abG9adXxTe2dBwv6DmYW/uMi2Su0lysCJ9hifNc4/34YsFkoBhNjSv
         9yR7N5VVlF9DVXv7t3XU+Y+ipfETdY8lIPbQ8tqllvNndU0R9jIBJiH1vF8ow7sepx8e
         6nRLn5vRVFUqsRxsazdj+Ky50abQwHBvBL4+L7vgpSGJGLiEuKJ3pU6yQiFj4gFMna3V
         1kLFZ8QDVU6+v/ayfitHRKKUNzjFzskD+02BE8W/GZg9v9y6Yfm9MiJm2S/+R/luF80i
         9ZmQ/7/r6etHNVE59AajgzpMaWhAP95H3e4rT7PNNjiLXXT/7ApI3a5YjqcpoYXG2MhG
         0RHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795585839; x=1796190639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ey3VoMnoIASJUisM8PXIjosjBIaHmMcX0osRpbhk3U=;
        b=nZYWhBA6uLmFCmYkRj6Hb23eKcgz+JHE6oXpmo8lQPu5j0NQNzkvAn0y9O3zkGUHQn
         4hZ1p6FNvTHUaM87r8QtUCCpkBQseohuL+Fa60VOcnNm+t+yfxzZDvrFKVAH40V3Mf/m
         jBWf91OCH/yXDz74Rk4/qXYVtlcfHVi9RBl4xKo3vpN/o308lpx2JRAcNhmSJdLNKabU
         efkCwWeBxDIbRtCnNLNzwrjolMrI2ArAnLMLpzRx41JdiTzynlcj6ueKqVl4mbUDyG1K
         jnQKFk7a9UQHUrpiOGYPgzH10Zp8DeOGC14Ux0n5HKfgDgG0lCOX7W334NWU2IzQI0Gr
         XeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795585839; x=1796190639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ey3VoMnoIASJUisM8PXIjosjBIaHmMcX0osRpbhk3U=;
        b=ARYkhrz//GF9UEO2DKuifjEKOsN/b/SRgidoIkth3AqGiXcKgBq9igUDgH0HhZb4jM
         vkbdFw+UWf7OlxPCJ9tXYf9PZkJ7DTGIP3nj6JE8Elq1pqRbkTE5iUI1P/fqIKUyE/Ta
         J/P1/ccixAiI6uJlCb8Idi8mfnwdvdPKrayhYb5Dhg3nkQqDqjeQkSjlVtMi5wBPD654
         Oytsa1qrrwBhXFu+DL9SR4oCrArNxZKgjjFp2sUdC/X9RYE+oJK4c6wcxLEFroqEXb3V
         sqzwefwj3kXeNhV+mrFu3z2E7iROSY7oN8S5ABT8NOEG2YNa4Z5l9ebkUAatJRtOxQru
         sODQ==
X-Forwarded-Encrypted: i=1; AL+hErF0qoVpgLUDQRHWFmXx6JCwAWJWn3+xtKmcD9OAAnXfYcn4PPyNQljdyvv9GlHO9eQAt6E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oHBcmFT/Sj58ecdpKt2PtCTUfzqehcUXzH/yr1Z2UvrI41zRK
	IE5hHuZqzaXr+1ZUnBx7/ekq6LgjhMvV3MNb2TVyEoDCzzDaSV3bJQ8pZp700SDe6MBlzn/qHaQ
	i3ZFzCorByZKLqZ8P8qPXOIHvTpoPOL/YxtNItN4lxQ==
X-Gm-Gg: AZFdTZe3z5eJ0ZyxzEA/k5GrzDG9EMgv0EO1amd3tlNDlh6vy7D7aLCaBQB/q3Lac+U
	j/XrmbZ+RUojO4RXBfHVlb+lmc+8qWedjOScrCSrmJufHhXrvS/cq4MB+gUKQRj8XLl8FWmf2YZ
	Q6DnzWee3G8Yf9LQNDTDi18uNPGiGocS1SgrWUHlbetetYTULYAWFirtyyp8xBi7zQNCf9CO7Dj
	OBsIRYj1SQrR6CNVaetq18bR2InzmRyJuwku+RsvP6AvzZtDdkl2sdgCEam/vVHohTC+cphdeXU
	jjmsso052r39zzps5/oHNgyoRT/IH4t4sYcA1bdESCnhfQIQfEiH0mK75Ws/RuAY5KlKAAQMLsA
	RX1QaDkLw4D8twQnyziJlWfs5PRvBKwDy0BWIbHAIE5EhBJjLmHLCLlPfc2pL5JYOxDyZXq1rlG
	8CIdFqb9XSFZ2DUpEU2zcO5LFsH6wsSxJ/Ilfrfa0KiVsjX4UL65Bo4gwrNiCx8FV8jo+CVh6xg
	QzL
X-Received: by 2002:a05:600c:46cc:b0:4bb:69b3:2b42 with SMTP id
 5b1f17b1804b1-4bb888277b3mr355988315e9.16.1795585838954; Tue, 24 Nov 2026
 21:50:38 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260921111402.120911-1-suunj1331@gmail.com>
In-Reply-To: <20260921111402.120911-1-suunj1331@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 25 Nov 2026 11:20:26 +0530
X-Gm-Features: Aa3M54qb1blyKaEVtKNBi5ctu8cJHJ3FLqTUOGiPqQSapaUrHW7z2azgq7gQGnk
Message-ID: <CAAhSdy2BkWEY3+FDpcLwFtrP+03GSfJHCmsCmu5513M8AMyPpg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] KVM: riscv: Age G-stage PTEs locklessly
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
> This series lets RISC-V select KVM_MMU_LOCKLESS_AGING, so G-stage
> aging can run without mmu_lock while protecting page-table walks with
> RCU.
>
>   1. Age all G-stage PTEs in a GFN range
>      Bug fix, posted separately [1] and included unchanged so the
>      series applies on riscv_kvm_queue. Drop it if already applied.
>
>   2. Read G-stage PTEs once when walking page tables
>      A lockless walker must derive presence, leaf-ness and the child
>      address from a single snapshot of each entry.
>
>   3. Write-protect G-stage PTEs atomically
>      Aging will clear the Accessed bit without mmu_lock; the plain
>      read-modify-write in GSTAGE_OP_WP could clobber that update.
>
>   4. Free G-stage page tables after an RCU grace period
>      Table pages and the root outlive any RCU reader. Root teardown
>      keeps pgd_levels intact so a walker holding the old root sees
>      consistent metadata.
>
>   5. Age G-stage PTEs locklessly
>      Select KVM_MMU_LOCKLESS_AGING and walk under rcu_read_lock().
>
> This builds on Jinyu Tang's rwlock and cmpxchg helpers already in
> riscv_kvm_queue. Wang Yechao's huge page recovery series [2] adds a
> second page-table free site in kvm_riscv_gstage_recover_huge();
> whichever lands second will need to switch that put_page() to
> gstage_free_page_table(). I can rebase the series as needed.
>
> A possible follow-up is to run clear-dirty-log and the general fault
> path under the read side of mmu_lock, as arm64 and x86 do. Patch 3
> provides the atomic write-protection needed for the former.
>
> Testing
> -------
> QEMU virt, -cpu rv64,h=3Dtrue (Svadu), 4 vCPUs, TCG. The host kernel
> was built with KASAN, PROVE_LOCKING, PROVE_RCU, LOCK_STAT and LRU_GEN.
>
> After each patch:
>   - dirty_log_perf_test -v 2 -b 256M -i 3
>   - access_tracking_perf_test -v 2 -b 256M -s anonymous_thp
>     (2M THP disabled and 64K mTHP enabled)
>   - 20 VM create/destroy iterations
>
> With MGLRU aging forced on the VM's cgroup every 50-100ms:
>   - dirty_log_perf_test -v 3 -b 256M -i 3
>   - 30 VM create/destroy iterations
>
> With CONFIG_KVM=3Dm, 5 module load/unload cycles, each with a VM created
> and destroyed immediately before module unload, to exercise module
> teardown after queuing RCU frees.
>
> No WARN, KASAN, lockdep or RCU reports were observed. The kvm_age_hva
> tracepoint recorded approximately 65k events per aging pass.
>
> Performance results from dirty_log_perf_test -v 3 -b 256M -i 3, with
> lock_stat enabled for mmu_lock and 86 aging passes:
>
>                            no aging          aging
>                          before  after     before   after
>   guest dirty time       12.5s   12.4s     18.6s    16.7s
>   mmu_lock W wait total  0.15s   0.17s     44.4s    0.15s
>   mmu_lock W contentions  35k     35k      1.0M     30k
>   mmu_lock R wait total   0       0        7.5s     0
>
> Before the series, 93% of write-lock waiters were from
> kvm_mmu_notifier_clear_young(), and the dirty-log read-side fast path
> waited for mmu_lock 352k times. After the series, aging does not
> acquire mmu_lock.
>
> Absolute numbers are inflated by TCG; only the relative change is
> meaningful. Under TCG, the atomic write-protect change in patch 3
> increased the clear-dirty-log time from approximately 16ms to 30ms,
> as TCG serialises AMO instructions; hardware numbers would be welcome.
>
> [1] https://lore.kernel.org/all/20260918072622.284188-1-suunj1331@gmail.c=
om/
> [2] https://lore.kernel.org/kvm-riscv/20260914055936.3672758-1-wang.yecha=
o255@zte.com.cn/
>
> SeungJu Cheon (5):
>   KVM: riscv: Age all G-stage PTEs in a GFN range
>   KVM: riscv: Read G-stage PTEs once when walking page tables
>   KVM: riscv: Write-protect G-stage PTEs atomically
>   KVM: riscv: Free G-stage page tables after an RCU grace period
>   KVM: riscv: Age G-stage PTEs locklessly
>

Queued this series for Linux-7.5

Thanks,
Anup
