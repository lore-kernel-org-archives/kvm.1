Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF90F35F5F3
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780240254; cv=pass; b=LzPTbouKZCWOHL8FO9J5cvQ22qilzt/AABth4EJNOXULd4BQsnyiL4P+1X1j7EhfRCx0V/klZWQAPfJpt397PFQ4R91xBsjzkYCVQ6Tsec8h85E+hh/oh7Zmq48c+S8LPYUh0GprGimHBOTVo1FWwC42E6vLYjonqTcUkWxsVoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780240254; c=relaxed/simple;
	bh=zz7AH1QdbbzXd1BRKJsbjBMpMpxYEmm59Bs6MbI1xqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcN2OWjiWlu/At0FLvzUpF/ae4gmsu4EiRPxyPH3gLDvbqm4tiKZRPMzP3jEYOEdJIO+6b8wiJLxGBT1TX3S7SrvTWmPwGZGGXxek+DgLVXv8zG8XEDwcWsBFZ2n5SETIKUWIFA4LbmGaMKB5TI2wc6SQEdZ108Ri5vfdnXQBxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=gmoeRJx3; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="gmoeRJx3"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69df5352d0eso2383293eaf.3
        for <kvm@vger.kernel.org>; Sun, 31 May 2026 08:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780240252; cv=none;
        d=google.com; s=arc-20240605;
        b=DOfMLUktWb+6DMZv4L2S39ablMkS/E2VR5Oecd6Fd3TWrOEEinklM2alcyaEsqxUwh
         tLkVp25vJNR4to3Tva1jULxIHMnzca/CLiowJwepwO/aSIcIfDywT4dGw4Rh90yrVM5i
         LLs8y6P3KYjNwG1QuHekxqPYL2yxY/+OBkbI9vFqr4HvmU0Rf4ldyzQWxR3Buk4T8nc4
         sW+AB2J8k6kkz5edcc1Ik39fya6hJdbl0A5oyfTnNdP+OuElBeWFQt3B6eZyJBmuDSW6
         aR0BmighPOQASqOsF8anKpj0Y9FoL4s/14QhPkerJ1deDAEHHHLT20fUkzqcSfJ0ITGa
         ZcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bdZCVhEgQOhgz7irK0pHZdssXKMhcpXPjOMZKGA5lkg=;
        fh=5jkhHWwpoBWWIqxulfVK4gSW1tt2To6cW5q3oHSVbC4=;
        b=JNUbzNr2bx8MAsKGlGvMSDslXy6cffSTD2DDDDLhyBi6L9QsSRmWvz6U01UbR0d6u3
         TL7EVwjiUaIaPNJpqyD9Wkjk/1bQa34XCmDCmVl8+Pnz6fsrCdmzvx6DvNuOoVkyJxTf
         LIguRtJdrlZABg2aflWZSYrNyLX0I/xgWtdUU55/kapIcaoOHF8vWUO/FhRjEN+TIxX4
         rNLLnC7Fs9c/naQLGD7IteplYyO5xffcx0kCSUGXv9vV35HBFT/AVPNm/VTWcTFZYpTR
         HvN34e3fHZZecb2m3VYCgBn4iIdXb4iKpPFoO1ybrihAbXjoOzpyt2A9u34EZryTU5fY
         sEgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780240252; x=1780845052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdZCVhEgQOhgz7irK0pHZdssXKMhcpXPjOMZKGA5lkg=;
        b=gmoeRJx3LbO/SbHREYFBm7FtP4UjW3Tsqcz8Is1Tb7mmpNzextyZ1M/mxBElgPTEAe
         wXSW45uE/fd5XCH0BB+cCBasWleqVkVrNUq166LR9cvCwOO06kkGWXnPYLZHhSCwHveB
         nCc6viCiErqkU8LMr/FQ+VBuSyUv9zHuARZRNHXcg0WL8+pQbDqViD5oIV6MW0SxxNC0
         JV/NydYh6xAAhFnSO+V05q6RnAvW4wy8/ujj3wsac187aNMjPCLdky4l1CdQu4LIlryR
         d7WP6wUrnfVhC/kY5/0Srn/4/2sG3POU6ZhDHbLy/xniW5TQPIiCkJnSIbcoJokxopgl
         PEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780240252; x=1780845052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bdZCVhEgQOhgz7irK0pHZdssXKMhcpXPjOMZKGA5lkg=;
        b=kyUZaKJxmsamrlro4OBEu043ir5vNuX3PiYKy0EGzzAHZt+VoGkX9z/oFjtHUsvDYs
         NgrIxElKQ2oTvsuDiPlsDhJbWziHLZV0EV5yIbdwFt7hsr7fio04aEuJRr/wv1k3Jncy
         J71M7OXVEmAaF3UhZbWOsA7peatIzPRmA5QdISojAXbGVXIy0NRILdHQC7dO3qV+7jzH
         6bp8C7xv5EyAdhexzDOHcHkwS8BY7sYMNBBTFVlsPPaAxkCbEG2q8KZSvX6kYVA7FW8U
         GTNDN4w+HY/RRT7laKwcoNyVtUQtiSWfoqcv962ooUzWzz3w7ZL7NbbSrGqzuZ5jHdOf
         HNAw==
X-Forwarded-Encrypted: i=1; AFNElJ9EYxwmnbiWW9PtL19eos6M+HHFqOhTPyoSTOVKMqgs85o/RlZJVZcLhWBVCLwCoTgeJpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfmbHEBfSt/pOPu7fwGE3YnyIyOM3zznjD7d/7Wt211DFzgfmW
	iXOk6EzzuD74XFrn0lf36DS1qONsfvJVma3/y+uuWKrHchl4b8katoS+D8XcqeBal90DLSAjyP6
	RF5gi4NN4/zEpUUM2AvLgiTt4jIS9R/S7gMc4iU8Huw==
X-Gm-Gg: Acq92OGLyNf4DsFyTDOgEJFmKnAT94iEoETlDkGlwJ49VVYHLf8AFiyKzALHWqbjJ1Z
	UHPlj43YoQB+VKfN55L9Jq9vQFEYMYhT7l4wOytz1Zc8Z7DokllM3ps4y7o+YJbcFLUXwiTd72C
	I4Y0LNRU/Po+6I41OupeGoZk+PqtgUzWsPhjG/qX0oVsY0bQVsymJ3Dwzu4Kdgdd7BLK3rZJSk5
	+019A5gBhBJEYTr9mu1ofGesHbpNf8F0/vGt5tTPCC6wJoAVZR4kWnR5uuDjduOJ2fUL9IeQDEu
	who3iW5W1eA5cHu/w1HOgr3+l9hdp5Q1XuRDMu8lrpAymB9VO5OJfXkSrYqn7v1LflFaMBzZ4yV
	mK+slIF8s16+0Vw3IWVZ1etrYwambo5qm9Xn1LA==
X-Received: by 2002:a05:6820:8c8:b0:69d:9b0a:bf8a with SMTP id
 006d021491bc7-69e10405f06mr3644904eaf.46.1780240251800; Sun, 31 May 2026
 08:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525094945.3721783-1-anup.patel@oss.qualcomm.com>
In-Reply-To: <20260525094945.3721783-1-anup.patel@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 31 May 2026 20:40:40 +0530
X-Gm-Features: AVHnY4LvhtY5JdkqVSNebuIYrOc1ssW4cm3YLUbYzFnlCcU5uLzs500fJwz5LYU
Message-ID: <CAAhSdy31hjQq4mt2J-eQSoQUycSFqwgg6KnMvY-68ZQX-viOTg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] RISC-V: KVM: Convert HGEI management to fully per-HART
To: Anup Patel <anup.patel@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	"Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 3:19=E2=80=AFPM Anup Patel <anup.patel@oss.qualcomm=
.com> wrote:
>
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> This short series converts RISC-V KVM AIA's Hypervisor Guest External
> Interrupt (HGEI) line management from a global "one-size-fits-all"
> model to a fully per-HART (per-CPU) model. It also performs the
> corresponding changes in the IMSIC irqchip driver.
>
> The motivation is to properly support heterogeneous RISC-V SoCs
> (big.LITTLE, multi-vendor core mixes) where different HARTs may
> expose different numbers of guest interrupt files / HGEIE bits.
>
> After this series, HGEI allocation, freeing, and interrupt delivery
> are completely per-HART and there are no remaining global assumptions
> about number of guest interrupt files.
>
> Changelog:
> V5:
>  - Avoid re-initializing hgctrl->lock in kvm_riscv_aia_enable()
>  - Setup free_bitmap only once in kvm_riscv_aia_enable()
>  - Make kvm_riscv_aia_nr_hgei so that it can be concurrently
>    updated from kvm_riscv_aia_enable()
>
> V4:
>  - Don't modify kvm_riscv_aia_nr_hgei in kvm_riscv_aia_enable()
>    since we use kvm_riscv_aia_nr_hgei mostly for HGEI enable/disable
>    checks.
>  - Use GENMASK_ULL() instead of `BIT(hgctrl->nr_hgei + 1) - 1`
>  - Always setup SGEI interrupt irrespective of kvm_riscv_aia_nr_hgei
>
> V3:
>  - Move PATCH3 as first patch and kept the nr_guest_files in
>    global config as the number of guest files across all CPUs
>  - Droped original PATCH2 and squashed original PATCH4 into
>    original PATCH1 which is now PATCH2.
>  - Addressed comments in original PATCH1.
>
> V2:
>  - Add per-HART IMSIC guest files to compute final HGEI count.
>  - Add min(local->nr_guest_files, nr_guest_files);
>
> V1:
>  - https://lore.kernel.org/kvm-riscv/20260421145451.1597930-1-guoren@kern=
el.org/
>
> Guo Ren (Alibaba DAMO Academy) (2):
>   irqchip/riscv-imsic: Add nr_guest_files in per-HART local config
>   RISC-V: KVM: AIA: Make HGEI number management fully per-CPU
>
>  arch/riscv/include/asm/kvm_aia.h        |  2 +-
>  arch/riscv/kvm/aia.c                    | 88 +++++++++++++++----------
>  arch/riscv/kvm/aia_device.c             |  4 +-
>  arch/riscv/kvm/main.c                   |  8 +--
>  drivers/irqchip/irq-riscv-imsic-state.c |  9 ++-
>  include/linux/irqchip/riscv-imsic.h     |  5 +-
>  6 files changed, 68 insertions(+), 48 deletions(-)
>
> --
> 2.43.0
>

Queued this series for Linux-7.2

Thanks,
Anup
