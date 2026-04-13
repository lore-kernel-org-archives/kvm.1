Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C9B30E84B
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073609; cv=pass; b=ZX170bO+SeI/kPgQ7TGrk/V59FW8+22vHixuLcrbnt0sYT2H2Fm4SzYs/qmDn7GVFxsJSXjTk2rKTWe/reY7HfuOb5KgDIm9XzinXPz5wXB1QN01MTe099GHX4C1PEUqrQHw8P2eUOSOCOBV2FBatJhnXdL8ytzouu5eP6wPVC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073609; c=relaxed/simple;
	bh=6Kvd5k21t20YtvqeCZelB9p2q5tUgS1BCP/iDrVjDPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiLPEnJIBmN8WJkJpKdSBR3DNnbvoamq32UH/ezp7e1lYnbPYIb5fxoDKUzotYCZlhqfu7rPGE4NxnhVaAltZVKt1Pt2AArzodB1e971SrmU5kmohSMTYO9I6X9dyHqWhk6Bu5SvCJGr0jP4jiPoO2xVu3vIH+30616jZFr3COk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuIpNUfW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZyLAh0NR; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuIpNUfW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyLAh0NR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776073607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqOOpFXr472jplXX81IjB0fG69DkhTvRYkUZqOIVbjg=;
	b=DuIpNUfWMt96E/RP76APnXWTaLHK7Mlej+qMJtiAT/+yW8BTyervBBNIjdZBg9QPJC/GMS
	Tdjgo5+oohvAxc6U9OJufvU6J3ZCIWfFdSbLX6NWt+U9m20SRoNZSe08eRjoILLIlNy1Sk
	VnpeoZAeW19ihr98JM4YkQfVH59+Sac=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-mavKZsMHOza9DDe43LZWaA-1; Mon, 13 Apr 2026 05:46:46 -0400
X-MC-Unique: mavKZsMHOza9DDe43LZWaA-1
X-Mimecast-MFC-AGG-ID: mavKZsMHOza9DDe43LZWaA_1776073605
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7757463eso401245f8f.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 02:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776073605; cv=none;
        d=google.com; s=arc-20240605;
        b=RcOryBLiezdgXQ+lzSadvBwOUybzhOVPvpR4OB4t1tDwc7LKKXsZ+GljMQB9StvOU8
         64dIBcQ2v5sTlj3vAmi33VltAH4LktQ1Rs3N/upTB+1y5wMuxONPY0MDhk9IsVg1uhma
         zZGPxiQnPOdI/lcZjQrZw58doPvz4vFS0NHBMZl2uiLUMC6NUGUaYbr+X71tX3TeSeHw
         tXw0dWn6hSoZefQJCiTcD4kAEIT/ZjyMYQU08NXI8MuIjlZu9I+rdQBFOLnhyVp76LL4
         DQOWC0iLQcrCmtTL2QZvW1qsTfGRirXR3nULmOKLDoJckrm2HyTUNWuawz4s4MlpPovt
         hKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pqOOpFXr472jplXX81IjB0fG69DkhTvRYkUZqOIVbjg=;
        fh=D1zLd+DhMTPXOpyaqkzGdGaUC8rFtCv2REoYm75n6O8=;
        b=jIbpfYpWawBY3JdC4HWzAOnFwqOfEuIzazAZbRbzk30R//AV0vZSWEj5O7H2qc41JG
         pgejb2hsAfsltEmDy4xqsUcuT46xGnnTpTcWCqdkEnrbFLkNGUA+hIzOLxS6YVh5DsIx
         FDjj0eKMH8JaHuYyGvgBnIqSpnOVby8sGvLjzuaHghhA5gT5I8YN0fmHF+LmY+H5wCrI
         7BUlQcdam60q77QNYt8aKDhLzuQn8Q4MY7omELtWt8zcxWArzcpVduT0epEONk/GfQ1I
         oWdlfo9S0pEPVoS+gBHTstHKWSGpcJlkJ2mVs1CphJ4yFd9YDyGfKEuf68DpMNgrc1F1
         Eydw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776073605; x=1776678405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqOOpFXr472jplXX81IjB0fG69DkhTvRYkUZqOIVbjg=;
        b=ZyLAh0NRliVB4Bxypq+fh+duGbubFx7sMM8AMsaoRqz0dwpxj3nb6ekcyVPMKncpfM
         pi/5pdlDcrktk6VcAhQj7Gl12QU8OMSpHfc+6K75CnnMZPiWsE8rXI2wq2b7/OuHP08Q
         xoglubizyBG+dhzaJNZNhW1QOSiV1lXWIeS4lYVl+rqPjRsN7t29yiiasOhYcP8AMije
         tMZyOplKBax9bzQTYHiosWQ99qCaap1elHhqNETapEJ7E8nWcZgVeBpaWP92xyU+UCrw
         PMg002f82SW0TR+RKSWHYDu/gMnJc8ItXKlxnSNkCJ0/PdfI8l5oyi6+rZCkRBw3FGtA
         Dxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073605; x=1776678405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pqOOpFXr472jplXX81IjB0fG69DkhTvRYkUZqOIVbjg=;
        b=SIC7usAOVGxp22w+qpW77z5UvqC42+78ct/R0X9UuIZEuByqV3TM/Idg5nMwUtZHXc
         qWyTaQA+8PGteCspiru0JfWIlS4i3jTGnD8wqO6W26RBSTW8KCrVw5SDAihQhFptFkqE
         VedcfvWBwP5XBk5FLZc98ndzzFo7F0fASCs+GaFZ+aAXMOUS8CMSj/ygW4Qiwbj/bGwP
         J4X7tGl8787jmMkwTAgnZHJ7YsnU0Jh1UX8mS9nWb+IvKokQRAaSf5eLl1udoWpiWt/q
         Nc6wQGih6SoIuuHTios/3mlb0dHvAla4zVW058bvEIC2nZ5+iBuWpi7NzdEQsvV9Li7g
         ixmg==
X-Forwarded-Encrypted: i=1; AFNElJ8oAUBJq7Er2YxGHNL31R33fp8hI4nkqnUPI2G5ajqP+uWqs5cx/AAkwtCyeaNp+VJAaiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+gREZX/4Fcwp2CHJz0NIc3IpGkWkjxoYJbISb+1Qzz6pDaqr
	zmcnmTAexTOtO4H16I45XepS5xb1pKJ2/nb4IqR8Ovz4SeWXlx8KacUzM2kbJvx+kniQAOPiUc6
	w+/W3sr9GWQlu1auA52FdwwJVHPYtF4Gsg78dtC5Fs5C9PgIwe/DU7ASX0WuWx3RWucrt7db2s3
	Tz3TFsm2aqUlfFUrPxt7tcfAf96x2r
X-Gm-Gg: AeBDieuBSjM0BuZqagkm3dllD3A2yBGQcRt4ZoGe68yPF2Sg66wiuwCCstgNZ7TFwtY
	fWd0V2qyPQb6JKqRjDpPwPjYNnIRfKaCZDHsZIzdwnvWGJaHKY0DyfRS0kO5Tit4mgnKXXbt4Zj
	1flrsmz9kL5ulYNZ7lrsCB78xU7mejKQwIW02yTcpa1emsj4wHYZwK3MxX2AOVNH2KuEfnzDvRA
	kjCxEdENPEd7bE6c/A1R43zYUQWT8e78pHFcqXQPXNsims/6/Ykyf6yIpM6Gt3PBxESvUQB+tIc
	x2Te
X-Received: by 2002:a05:6000:178b:b0:43d:78ae:b785 with SMTP id ffacd0b85a97d-43d78aeba0emr4286961f8f.21.1776073604626;
        Mon, 13 Apr 2026 02:46:44 -0700 (PDT)
X-Received: by 2002:a05:6000:178b:b0:43d:78ae:b785 with SMTP id
 ffacd0b85a97d-43d78aeba0emr4286905f8f.21.1776073604121; Mon, 13 Apr 2026
 02:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410102245.2749691-1-chenhuacai@loongson.cn>
In-Reply-To: <20260410102245.2749691-1-chenhuacai@loongson.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 11:46:31 +0200
X-Gm-Features: AQROBzBCxZ_O2q5gvgr11sGkXKrARbdo_rIJ09vTpuizMA__mmpaLs_IJqSTAh8
Message-ID: <CABgObfapzrFmCndV1HVk02rvTwvx4n1WvQ4AW0cySV6mZvWF7w@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch KVM changes for v7.1
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 12:23=E2=80=AFPM Huacai Chen <chenhuacai@loongson.c=
n> wrote:
>
> The following changes since commit 591cd656a1bf5ea94a222af5ef2ee76df029c1=
d2:
>
>   Linux 7.0-rc7 (2026-04-05 15:26:23 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson=
.git tags/loongarch-kvm-7.1
>
> for you to fetch changes up to e47b8e1db9a9bbef6765e85b11e87f48e6b56846:
>
>   KVM: LoongArch: selftests: Add PMU overflow interrupt test (2026-04-09 =
18:56:38 +0800)
>
> ----------------------------------------------------------------
> LoongArch KVM changes for v7.1
>
> 1. Use CSR_CRMD_PLV in kvm_arch_vcpu_in_kernel().
> 2. Let vcpu_is_preempted() a macro & some enhanments.
> 3. Add DMSINTC irqchip in kernel support.
> 4. Add KVM PMU test cases for tools/selftests.

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> Bibo Mao (4):
>       LoongArch: KVM: Check kvm_request_pending() in kvm_late_check_reque=
sts()
>       LoongArch: KVM: Move host CSR_EENTRY save and restore in context sw=
itch
>       LoongArch: KVM: Move host CSR_GSTAT save and restore in context swi=
tch
>       LoongArch: KVM: Make vcpu_is_preempted() as a macro rather than fun=
ction
>
> Song Gao (5):
>       LoongArch: KVM: Add DMSINTC device support
>       LoongArch: KVM: Add DMSINTC inject msi to vCPU
>       KVM: LoongArch: selftests: Add cpucfg read/write helpers
>       KVM: LoongArch: selftests: Add basic PMU event counting test
>       KVM: LoongArch: selftests: Add PMU overflow interrupt test
>
> Tao Cui (1):
>       LoongArch: KVM: Use CSR_CRMD_PLV in kvm_arch_vcpu_in_kernel()
>
>  arch/loongarch/include/asm/kvm_dmsintc.h           |  27 +++
>  arch/loongarch/include/asm/kvm_host.h              |   3 +
>  arch/loongarch/include/asm/kvm_pch_pic.h           |   3 +-
>  arch/loongarch/include/asm/qspinlock.h             |  26 ++-
>  arch/loongarch/include/uapi/asm/kvm.h              |   4 +
>  arch/loongarch/kernel/paravirt.c                   |  16 +-
>  arch/loongarch/kvm/Makefile                        |   1 +
>  arch/loongarch/kvm/intc/dmsintc.c                  | 182 +++++++++++++++=
+++
>  arch/loongarch/kvm/intc/pch_pic.c                  |  15 +-
>  arch/loongarch/kvm/interrupt.c                     |   2 +
>  arch/loongarch/kvm/irqfd.c                         |  10 +-
>  arch/loongarch/kvm/main.c                          |  14 +-
>  arch/loongarch/kvm/vcpu.c                          |  29 +--
>  include/uapi/linux/kvm.h                           |   2 +
>  tools/testing/selftests/kvm/Makefile.kvm           |   3 +-
>  .../testing/selftests/kvm/include/loongarch/pmu.h  |  66 +++++++
>  .../selftests/kvm/include/loongarch/processor.h    |  15 ++
>  .../selftests/kvm/lib/loongarch/processor.c        |  15 +-
>  tools/testing/selftests/kvm/loongarch/pmu_test.c   | 205 +++++++++++++++=
++++++
>  19 files changed, 593 insertions(+), 45 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
>  create mode 100644 arch/loongarch/kvm/intc/dmsintc.c
>  create mode 100644 tools/testing/selftests/kvm/include/loongarch/pmu.h
>  create mode 100644 tools/testing/selftests/kvm/loongarch/pmu_test.c
>

