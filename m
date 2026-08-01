Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1D331B82B
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785573346; cv=pass; b=tCcC8N1xx1ETkNwaBON1EsZh5bOBGbgLS407D9WsAuiRzwOymN9Nwnc373zjLuk2+FvUftJS5obmtEj2Mya3/xnbjArw7S0OgCVe7GNvGOTUP+qzbq/gsPbOEeXivkEnw5VYj6dy4j/Pz77b2VoI8P9zJK87wBVxyEFcprbXi6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785573346; c=relaxed/simple;
	bh=sO8qEfv0wP0XNeJTxP8D18+JoBakW2isgUdDlhsmT64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXRNptc573fyRj1iSZGY+SnDPeAZtkN+UyAWBdPjNDJR6jmo5NAlVwRoY9imQ3Txx+otWbVPbCkw53DD/4GcZdH9ZdpEGZhXm6VWYWogpxatQ26Y5j3qCNJTUcJY2hrvgJO5/mVQ8pW5Dzq0iqgK++ryXKojtyo1iAR0CULxfxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=p+s/tMhp; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="p+s/tMhp"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso2064609e87.3
        for <kvm@vger.kernel.org>; Sat, 01 Aug 2026 01:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785573341; cv=none;
        d=google.com; s=arc-20260327;
        b=cHoyX4aSAlsTOh0Ee0ZwE71PrqUF0zGhteiewfhyHwRZQATJvkl1IsvCO4Ctph3Gsd
         x4k8q3yCAhtPjwECSH74U6j8CfacNcVIs+59Zh+Z9rzdYHd0xQkkZuOlPJEgg2i4edvL
         0EZvt46vYllq7KZEz44/BrqjNk5oid1nmCNHJZ2zZKgmHSw2reKm/NxhMTWOaYA9190w
         xWZiNC7utLUOQXjQb4M5rjAOeKlDOZu8KOqc/nFrYS3BO0QF9m5I8lJZ4fYYOR4wDyIs
         lftm43TeBE2osjPkrQcVXCB4+MQRYSi1iz9VoQgXE/h9Cf1YGFMMJ2fKzoVrsl92RiUs
         VkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ti7qy/Wgg1UvAG+vuSmd4Pnu4gP//7qkOjMeXPRouA8=;
        fh=TqkDo7HJm6C2bTHYqbzn7b/i6oYTm+CMOZGiIKAd8p4=;
        b=T9vLa6bjRiXi1W25BzmBkZBF5jilwlbxtG4PhgJpAGNXf7/vQJPQ/lnSKjA32nN+5N
         CaBi5vzApxxXJ2n51IH8sD0Obc1yBLvi2C179ck+X0AXLdSuTKyf0g4nLyl+tVerGlsX
         KSx3e+MMXMHyzauHT+aQ6Ob7LBKjcxwXeiqOIXOAscuGDXqjbdWg7PbSgY0LHq022/g2
         ajA3WFmkodERy8ZstzbxP9cf1o36FIdercnd1QayYK+7DDETOAQgLkPV8P17V7LN1omO
         CEsvyhw6m60lyeIFcyQ7of+FjGGeI+Kd3e9BrWHx8Zlc2XGn9FD11Aqh7bRChwJVzzZd
         nk7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1785573341; x=1786178141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ti7qy/Wgg1UvAG+vuSmd4Pnu4gP//7qkOjMeXPRouA8=;
        b=p+s/tMhp9jeq4R9DYsIYA1EetyNRVrWF9VwFIY7qV0svE/1JfPWOiOoeuOKKm9wAdj
         bxZQqNcLgKmdXG9GOgtWirGY6VR1bKd5yuv2Oy65JbAi3rxuTXXo88YkVswjrP93xTUP
         zNNwCE0dKsPldSJe4GdJlzq4Q9iv2NvRZBiMlvTDODKS+W3McMs3IHH/HGUy0/+GBOxb
         OP+MGy1xC0Wp6Saz7nwthATotanCi05cfIBA6LdjflScOGuhx5F9bmpNYu09ICWdAqVY
         zxS2NzpbNGqjxwYH9wkbYqQdg+1qib7NyGrpfRq2CggmLLw/0/EanB5C36u1i1W7ToGa
         yDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785573341; x=1786178141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ti7qy/Wgg1UvAG+vuSmd4Pnu4gP//7qkOjMeXPRouA8=;
        b=WAAFehmQOdxD9JQjsPBm+VLdK9rP/b0sX5bpj8+NKFg2UA2g22WUZC1oLCuXSWa5iW
         Rra3nVRCA9RjAR0+ru5zJ9BfC9Tdsy0ryPlCkIKz5eRQw6pIc8QSeh+/nYnZRr5Yo5DW
         o0DC8jepWTuANZfFOTP1ke5JVL+gMvtPpT1iXZiS29nQ0raO9pIXnSwrhR1i0ywj63P4
         kLWy52hU6/ShwFTHuLLp1LVQHY0jUQZKAp73LcVoYeGGKB3q5RNtEs706//xjOlCVBw/
         BYYkwgtBOseH3bBAsSttMaTwLau4l2UwdY+CR83Hkxg5A0VR7xJDdA6bJto4XlVHPHip
         fnsg==
X-Gm-Message-State: AOJu0Yyi1grCXtNlGT2KHXtt3rMqpLcwccfXVS3/qTHq9Am/s8TLSvBy
	VhLzNn+LyasKilmKhqN+Tgsl4A3itKToXqWELoJHI6RkZilGRJoQbnuYHIpIlzHv9Amju1VWQM4
	q37Yu2T9J3A9NAdpVhbBKOfXPzTHbCiX3kMIBqbcq4w==
X-Gm-Gg: AR+sD122lWmvi0urDkL0Vp69DWJsm+JruxOJkGKTf57BJq+HR901e3XUoDASvW/n1BK
	R94GCIoI/UL13xR+dNwhXLn3F/bt7hKTY+dLqVFdU0w3VkCMvqgYzI3uQColc3M/+1W5c2+EOA9
	USgr/6HFx6G6nj7+ShPxeBExxTt+niD9K1jNz5c3tiluKyRzEWBq3B11QUTMhSHmWrs+K18rL9j
	TfUNcz0dkyWsXIIimAsX1vJm5Ka4fxQjx/hk4RoLStbBGfU7/ckN9orAumejmEj3VjdZ48doCQt
	U21iE0Oxsz7oFDGnTWWZfWhdbNhwR9ZLVtJmm9QGPRYK5MY/FjQANI+UBazhWewNymuaoWLAyT9
	MS4HnJ2J5GZfe/7nABjynymydPPkB7GyQctovmC48OVYdMVeC0nUTgbCOyCMjOMBX
X-Received: by 2002:a05:6512:6884:10b0:5b0:12cf:ae28 with SMTP id
 2adb3069b0e04-5b2e4f6d20bmr309861e87.34.1785573341398; Sat, 01 Aug 2026
 01:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731091215.1549430-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20260731091215.1549430-1-wang.yechao255@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 1 Aug 2026 14:05:29 +0530
X-Gm-Features: AUfX_mz53XbCAJ1CS-mX5hYkoLEkQs_MWRVhje-M7z7-nmkWZgGhs1bk87PQqdM
Message-ID: <CAAhSdy15rQDkLVncPmdQ3+tKyFXv6HiuUe1=xKCG+Q1rzBOqVA@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Implement Eager Page Splitting for RISC-V
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 2:45=E2=80=AFPM Wang Yechao <wang.yechao255@zte.com=
.cn> wrote:
>
> Eager Page Splitting is implemented on x86 and ARM. It improves the
> performance of dirty logging (used in live migrations) when guest memory
> is backed by huge pages.
>
> This series implement Eager Page Splitting for RISC-V. The Implementation
> similar to x86 and ARM. It provides two ways to split huge pages in ioctl
> context instead of on fault in vCPU context:
>
> - Split huge pages when dirty logging is enabled when
>   KVM_DIRTY_LOG_INITIALLY_SET is not set. This happens when enabling the
>   KVM_MEM_LOG_DIRTY_PAGES flag of a memslot, and splits the whole memslot
>   into 4K mappings.
>
> - Split huge pages during KVM_CLEAR_DIRTY_LOG when
>   KVM_DIRTY_LOG_INITIALLY_SET is set. This happens when enabling dirty lo=
g
>   in small chunks. It does not split the whole memslot, but only the
>   requested chunk range.
>
> Changes in v5:
>  - PATCH1: Move pgd_split_page_cache freeing to kvm_riscv_mmu_free_pgd().
>  - PATCH3: Add a comment to explain why TLB flush is not needed here.
>  - Link to v4:
>  https://lore.kernel.org/linux-riscv/20260701120954.129873-1-wang.yechao2=
55@zte.com.cn/
>
> Changes in v4:
>  - Rebase on v7.2-rc1 version.
>  sashiko-bot AI review
>  (https://sashiko.dev/#/patchset/20260624160054463wcDvJaMoydSggcNOWgcfB@z=
te.com.cn)
>  - Add the rwlock_needbreak() check when toup split cache.
>  - ALIGN_DOWN the start addr to PMD_SIZE.
>
> Changes in v3 resend:
>  - Fix patch format to ensure emails reach the linux-riscv and kvm-riscv
>    mailing lists.
>  - Move the free pgd_split_page_cache into kvm_arch_destroy_vm().
>  https://lore.kernel.org/kvm-riscv/20260624160054463wcDvJaMoydSggcNOWgcfB=
@zte.com.cn/
>
> Changes in v3:
>  - Rebase on v7.1 version.
>  - Add patch03 to remove the redundant TLB flush operations.
>
>  sashiko-bot AI review
>  (https://sashiko.dev/#/message/20260603104847.9692C1F00893%40smtp.kernel=
.org)
>  - Check the kvm->arch.pgd before split huge pages.
>  - Align the start address to PMD_SIZE before split.
>  - Flushing remote TLBs before Dropping mmu_lock.
>
> Changes in v2:
>  - Rename the split_page_cache.
>  - Rename the kvm_riscv_split_huge_pages and
>    kvm_riscv_split_memory_region.
>  - Add lockdep_assert_held check before split huge pages.
>  - Update Documentation/admin-guide/kernel-parameters.txt.
>  - Link to v2
>  https://lore.kernel.org/linux-riscv/20260603175256408L0jnqGs1cJGc0ijCduj=
ci@zte.com.cn/
>
>  - Link to v1:
>  https://lore.kernel.org/linux-riscv/20260513153656847l3c4fI5hBsAyoIZi8aG=
Is@zte.com.cn/
>
> Wang Yechao (5):
>   RISC-V: KVM: Add the split page cache for ioctl context
>   RISC-V: KVM: Split huge pages when dirty logging is enabled
>   RISC-V: KVM: Remove redundant TLB flush operations
>   RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG
>   RISC-V: KVM: Add the eager_page_split module parameter
>
>  .../admin-guide/kernel-parameters.txt         |   7 +-
>  arch/riscv/include/asm/kvm_gstage.h           |   6 +-
>  arch/riscv/include/asm/kvm_host.h             |   1 +
>  arch/riscv/kvm/gstage.c                       |  23 ++--
>  arch/riscv/kvm/mmu.c                          | 100 +++++++++++++++++-
>  5 files changed, 120 insertions(+), 17 deletions(-)
>

Queued this series for Linux-7.3

Thanks,
Anup
