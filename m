Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39221B185
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073411; cv=pass; b=GfJOULMbvIw8r8YxvejvCsNEw49RsCUYBBc8OXEcxb0mN0eM5RAOwtLIKFfUoyRCU7XM3/eNyLYgeILoRVw8XNQKqeYhlmSnGEcxR2Q9iyCrURWmJffoubf3O90CKDv0Ns6XQitOnyFdbbfy9DKCfp+GR1iwcN4FWx3PqfBRsNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073411; c=relaxed/simple;
	bh=nSNXOglq4wwn9niamyNI7V0aMFP09HfF61aqrZK8QCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7HODm+nG5XSdwah9R+HqziY6MYWYlF+f4PQBTy9QaLV7wQI6nV3YVP78f0cesyvNkOWQYRTJ4tBwvSMvvY21SRzZGrfj2DSDRmNWbiBMyA5Ux1R0e5s/BiK/vg6SokBq+DUBBgaZrrZC9JkpIY5hTCPuHQUVmGCxm8HhVQocKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMAzglfB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFyXQDqA; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMAzglfB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFyXQDqA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776073409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=up0W45gtoNI4pHs0kRq4cu9I3A/mCEQzypUKR4wYWZA=;
	b=AMAzglfBHUG5qZOGhQLNX3nj+p+xhjeKeALJIyDax2gVXq49w/90BJsgTvEH50SIH471Of
	Ja2g13ODBdrt7TtDwn88LKPCtZoiVmQfzKJddszFroimakKlnZC3H7Yq7+mFhmub5smzY8
	BSHkxuU/j1/xes+ISrbu8ynS46+tCPA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-K-H3fgHJNcqbN0Ooie66Kw-1; Mon, 13 Apr 2026 05:43:28 -0400
X-MC-Unique: K-H3fgHJNcqbN0Ooie66Kw-1
X-Mimecast-MFC-AGG-ID: K-H3fgHJNcqbN0Ooie66Kw_1776073407
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d780601b7so417499f8f.2
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 02:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776073407; cv=none;
        d=google.com; s=arc-20240605;
        b=Krmt0qwus38q9Er2l/4L8A089XaltThT8qXsGZU5ELKWev0+P/aCbPqgZkLoTbHo6G
         s9lpvssJ/EQm8g3BOZPswFVNX+PoOZv3s6Vaxbuo8rQBSG2VfHpIzEh3YDLkhegbs/+e
         fLa7GaEgpz7HLvJ2jRQHqxF/8QQB6yMWIHLIcl9qQOBvaBcr4Fmqs27WUgxIZE/VeUGe
         d2ZSv/8UVrIybP3n9XJKa/iFidyy+yg35hKY0eBJoX/YdnswcXXZ0gnR6l6B2Q8bYawP
         wWCvcKQOKSXpPHwRg7OjtJl3mI1O5hD6aOuDPVVqO7W1Yd2pl8jfGdeUZRDxhzXqsus0
         nXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=up0W45gtoNI4pHs0kRq4cu9I3A/mCEQzypUKR4wYWZA=;
        fh=TnuaC39qp6CH7+nZ/OKQrIQTvTXIqnQoKKB2Uqp0OFo=;
        b=UCJYIUANi/eUIuCoZb6cvRzOU4JodPu8j/qWBxozew7bOcCpQVfiBMbiCXmMN/8nTn
         +clwzKU5lxluBC4d208DNI6da0ct2GqG1udH+i5RoFN9m/Ld6xho7KsTaVjMSQbg4PLX
         fXJrHL67a/7Zm/OBCTxjej8LPOOlcP4yVY9Pns6RNYL6pY+5LweL6+JhbpvoUKPU5F16
         Zje/w2958DI+pWKR4CNC39VvNdXq+IFKnd9OKGiDuAiR9l8AlTPJuKuOa3XYJg0dBB/8
         DqRhZiksXf52gB+Q81boJ+XXa1vD+ZO44mnNN+zTc9c8PVm/LmNH4DKJzjt9uArSSobd
         l4uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776073407; x=1776678207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up0W45gtoNI4pHs0kRq4cu9I3A/mCEQzypUKR4wYWZA=;
        b=YFyXQDqAvaYmzUJlHiY9/+TMpco8UULfl/BNhuvQq1aj4hwdYSvO69q+r1PYFDmMQ0
         NphA5FcZm16kw/fj71Utjoe9PphUTDTVKxmb3/w8uF9MAqT8X/CIZz+h9iS/Ip/Kr/Ud
         3tHah0FenCOKQes1tmDrBVpLigiCRztncCTBQTp3+f6RwYXRXCFM4t8p0y8n8ElBkXiP
         s6tHA/qgp9xLXLyilY89pvG2m9J1hPav3OZw3TK8+JKrjq0LdjMQ8bMMJinRk1xE5+db
         0kIZ6/ysxJxNu+u8r+C7OAkfUYJxOpHkfFIIBoxvwaMuJL/UUT4kCxKHrcXMpu+JPy9h
         PMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073407; x=1776678207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=up0W45gtoNI4pHs0kRq4cu9I3A/mCEQzypUKR4wYWZA=;
        b=pv/+yE7ZnUDuZ8KrQVike1cP/c7Z8WD2TQOtJvxQEgl5dJRqcwRVZA/fWZe8N72g/h
         QIwQUYk//J2yrTRNWD1MyO+o7/B7VKt9t2fHQOpWF6VkTIrtksTD/royq7qCfkyHH3AM
         bo3ruduUlqibicQoSfM3wUjqaTpf4fxg/2GTCSm4JsSl6NcEYMqfTLA1o8O1hB+9rvQp
         uYWRnXe/nBzdMao4//m7AsCmoZIXkk7rOapJzsQTqCXi6Xh0ueR5s5Chen5bFTz69Q9u
         X9EHsUtHYMYLxyT2r9TxFOq2KoFZjJJ170ZJA1tUw6BQFjtev6IlC9d2QTU3g7lXqGu4
         x/XQ==
X-Forwarded-Encrypted: i=1; AFNElJ8VZu8o2lucjq1OFiUs5zrbJ+jBFpHVIhqfbq3nEJNzS8u96LyP2lMJzzC01oW+oKVEsVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/B9omebGUSk46lKUxj3GC6bJVB0tpeho4O1fji8AvjVs7oOXU
	7BLN5dlZ+lEnaTiQY+XmlGkEaWgKwBe8tOuAopaIQ1u3xn0XDl/9Sq7WK4yB/g6XImb2HvgAJ8J
	GVokIYmeQvjKpmLeAhiTv5k1EEb85SYWMTrT1/9myBZ5ArsH8xsMxvfdLOe0yx48sdI2f4CUyd5
	X2RESXiWkRmaYCGfLJj2vuPkHbwXuD
X-Gm-Gg: AeBDies6EpH47mWNKptmjKM74k6OetF+n0urV5cokAsWEzAyIi+ZFj3LS4EeC6BtUt2
	tPZN0Qs9PKDblP1jZNclb8Utu0mXMTWbl2c7w+TbYVwlZW00I09WXwdQI6w0NwpmE7VP2tRp7vt
	9HO27WeOMy3WrD7BTeMaJbNc1cnB3d4vNdEEHf1Rr6q0nRE5K1DKzpZeim/JBgYI+ZRgKfFWxGn
	BJw7xlyIu3RWi8H3sPvx7JNvl+Do6AW+jSczBwuk22t3HvENbtJAsBm9eiMGdApAJT9KrEmvNFa
	e4py
X-Received: by 2002:a05:6000:2dc1:b0:43d:7af0:3a83 with SMTP id ffacd0b85a97d-43d7af03e3emr2720427f8f.41.1776073406827;
        Mon, 13 Apr 2026 02:43:26 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc1:b0:43d:7af0:3a83 with SMTP id
 ffacd0b85a97d-43d7af03e3emr2720372f8f.41.1776073406289; Mon, 13 Apr 2026
 02:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhSdy0sU997x67zZe00ZVPVrOT-=X8zOUk3OxWXeDcn-rHeXA@mail.gmail.com>
In-Reply-To: <CAAhSdy0sU997x67zZe00ZVPVrOT-=X8zOUk3OxWXeDcn-rHeXA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 11:43:14 +0200
X-Gm-Features: AQROBzBQfjt3xV4dcP8Nj1D_N7gw5YuFZWv1XYE0RCatLaN8XwSCpf4fd4AGGbo
Message-ID: <CABgObfYosYD=xmLgxyDhL44yPvw06bB3ApaD6D4BRxte3tnPGQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/riscv changes for 7.1
To: Anup Patel <anup@brainfault.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Atish Patra <atish.patra@linux.dev>, 
	"open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, KVM General <kvm@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 3:14=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> Hi Paolo,
>
> We have the following KVM RISC-V changes for 7.1:
> 1) Fixes for issues in steal time accounting, vector and
>     PMU which were discovered by KVM API fuzzing
> 2) Split huge pages during fault handling for dirty logging
>     so that write permission is restored for smaller pages
> 3) Improve kvm_arch_vcpu_load() performance by skipping
>     CSR restore if VCPU is reloaded on the same core
> 4) Implement kvm_arch_has_default_irqchip() for KVM selftests
> 5) Support configuration of per-VM HGATP mode from KVM
>     user space
> 6) Some more preparatory changes for nested virtualization
>     such as:
>     6.1) Factored-out ISA checks into separate sources
>     6.2) Added hideleg to struct kvm_vcpu_config
>     6.3) Factored-out VCPU config into separate sources

Done, thanks.

Paolo

> Please pull.
>
> Regards,
> Anup
>
> The following changes since commit c369299895a591d96745d6492d4888259b004a=
9e:
>
>   Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-riscv/linux.git tags/kvm-riscv-7.1-1
>
> for you to fetch changes up to ddbf9c76c4020bf63a0799b00faad40caa3de6c2:
>
>   RISC-V: KVM: Fix shift-out-of-bounds in make_xfence_request()
> (2026-04-06 09:43:02 +0530)
>
> ----------------------------------------------------------------
> KVM/riscv changes for 7.1
>
>  - Fix steal time shared memory alignment checks
>  - Fix vector context allocation leak
>  - Fix array out-of-bounds in pmu_ctr_read() and pmu_fw_ctr_read_hi()
>  - Fix double-free of sdata in kvm_pmu_clear_snapshot_area()
>  - Fix integer overflow in kvm_pmu_validate_counter_mask()
>  - Fix shift-out-of-bounds in make_xfence_request()
>  - Fix lost write protection on huge pages during dirty logging
>  - Split huge pages during fault handling for dirty logging
>  - Skip CSR restore if VCPU is reloaded on the same core
>  - Implement kvm_arch_has_default_irqchip() for KVM selftests
>  - Factored-out ISA checks into separate sources
>  - Added hideleg to struct kvm_vcpu_config
>  - Factored-out VCPU config into separate sources
>  - Support configuration of per-VM HGATP mode from KVM user space
>
> ----------------------------------------------------------------
> Anup Patel (6):
>       RISC-V: KVM: Introduce common kvm_riscv_isa_check_host()
>       RISC-V: KVM: Factor-out ISA checks into separate sources
>       RISC-V: KVM: Move timer state defines closer to struct in UAPI head=
er
>       RISC-V: KVM: Add hideleg to struct kvm_vcpu_config
>       RISC-V: KVM: Factor-out VCPU config into separate sources
>       RISC-V: KVM: Don't check hstateen0 when updating sstateen0 CSR
>
> Fangyu Yu (3):
>       RISC-V: KVM: Support runtime configuration for per-VM's HGATP mode
>       RISC-V: KVM: Cache gstage pgd_levels in struct kvm_gstage
>       RISC-V: KVM: Reuse KVM_CAP_VM_GPA_BITS to select HGATP.MODE
>
> Jiakai Xu (8):
>       RISC-V: KVM: Validate SBI STA shmem alignment in kvm_sbi_ext_sta_se=
t_reg()
>       KVM: selftests: Refactor UAPI tests into dedicated function
>       RISC-V: KVM: selftests: Add RISC-V SBI STA shmem alignment tests
>       RISC-V: KVM: Fix array out-of-bounds in pmu_ctr_read() and
> pmu_fw_ctr_read_hi()
>       RISC-V: KVM: selftests: Fix firmware counter read in sbi_pmu_test
>       RISC-V: KVM: Fix double-free of sdata in kvm_pmu_clear_snapshot_are=
a()
>       RISC-V: KVM: Fix integer overflow in kvm_pmu_validate_counter_mask(=
)
>       RISC-V: KVM: Fix shift-out-of-bounds in make_xfence_request()
>
> Jinyu Tang (1):
>       KVM: riscv: Skip CSR restore if VCPU is reloaded on the same core
>
> Mayuresh Chitale (1):
>       KVM: riscv: selftests: Implement kvm_arch_has_default_irqchip
>
> Osama Abdelkader (2):
>       RISC-V: KVM: fix PMU snapshot_set_shmem on 32-bit hosts
>       riscv: kvm: fix vector context allocation leak
>
> Wang Yechao (2):
>       RISC-V: KVM: Fix lost write protection on huge pages during dirty l=
ogging
>       RISC-V: KVM: Split huge pages during fault handling for dirty loggi=
ng
>
> Yufeng Wang (1):
>       riscv: kvm: add null pointer check for vector datap
>
>  arch/riscv/include/asm/kvm_gstage.h                |  51 +++-
>  arch/riscv/include/asm/kvm_host.h                  |  23 +-
>  arch/riscv/include/asm/kvm_isa.h                   |  20 ++
>  arch/riscv/include/asm/kvm_vcpu_config.h           |  25 ++
>  arch/riscv/include/uapi/asm/kvm.h                  |   8 +-
>  arch/riscv/kvm/Makefile                            |   2 +
>  arch/riscv/kvm/aia_device.c                        |   4 +-
>  arch/riscv/kvm/gstage.c                            | 198 +++++++++++---
>  arch/riscv/kvm/isa.c                               | 253 +++++++++++++++=
+++
>  arch/riscv/kvm/main.c                              |  16 +-
>  arch/riscv/kvm/mmu.c                               |  70 ++---
>  arch/riscv/kvm/tlb.c                               |   3 +-
>  arch/riscv/kvm/vcpu.c                              | 111 +++-----
>  arch/riscv/kvm/vcpu_config.c                       | 103 ++++++++
>  arch/riscv/kvm/vcpu_fp.c                           |   9 +-
>  arch/riscv/kvm/vcpu_onereg.c                       | 284 ++-------------=
------
>  arch/riscv/kvm/vcpu_pmu.c                          |  33 ++-
>  arch/riscv/kvm/vcpu_sbi_sta.c                      |  16 +-
>  arch/riscv/kvm/vcpu_timer.c                        |   3 +-
>  arch/riscv/kvm/vcpu_vector.c                       |  11 +-
>  arch/riscv/kvm/vm.c                                |  49 +++-
>  arch/riscv/kvm/vmid.c                              |   3 +-
>  .../testing/selftests/kvm/include/kvm_util_types.h |   2 +
>  tools/testing/selftests/kvm/include/riscv/sbi.h    |  37 +++
>  tools/testing/selftests/kvm/lib/riscv/processor.c  |   5 +
>  tools/testing/selftests/kvm/riscv/sbi_pmu_test.c   |  20 +-
>  tools/testing/selftests/kvm/steal_time.c           |  98 +++++--
>  27 files changed, 956 insertions(+), 501 deletions(-)
>  create mode 100644 arch/riscv/include/asm/kvm_isa.h
>  create mode 100644 arch/riscv/include/asm/kvm_vcpu_config.h
>  create mode 100644 arch/riscv/kvm/isa.c
>  create mode 100644 arch/riscv/kvm/vcpu_config.c
>

