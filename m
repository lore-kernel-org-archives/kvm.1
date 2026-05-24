Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A702FE071
	for <kvm@vger.kernel.org>; Sun, 24 May 2026 05:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779600369; cv=pass; b=AU4f/tXAgBcUgIXiIYsfQqxctPGJSBMC2yJmH+ur+I9uDyPpHkOk+s/w11TOgSn9nk9Z6aN9f13BAtWCHWWEhdnP8CbeiBHQyR3orluu0rHGQp+VfAYRpX8YWUFUSBnLKaS0kwYECt+0tihQzOzWKsm32Q6Y4C9aAeNQsB1+Wk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779600369; c=relaxed/simple;
	bh=+5Z90PBJWOJo8RFEuayhoFgNxcLIQkkdSw1cZjc7/50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Akwn4htVax6FyDhPLT1mCAX9Vz3yax2QVzn71oZpUlZQG3tVpm7RNi0G/dMquTuYe9gZoHnlJjn9K+Kv8YrzJA91PsTGM/QRPLYGRFbA4s1EKf9iBj6G6CysEod5D51+RQcK63Sx3eKD7L6PhvHVDtULojyr+Lq0O63ZtYuTnwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=ZL2CEazT; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="ZL2CEazT"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dcdd23fcdfso4597814a34.3
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 22:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779600366; cv=none;
        d=google.com; s=arc-20240605;
        b=OIO9jFPz+gaaAoG0v3j5AqJytadjlu/Vr4gD0+8tx+MJuSG+MNLAxM65oZQXYHZ1EL
         xfthII+HljImDTLdQRw7JZQ1FvRAM8yGEF9hqBCb17J1g0nuqY1aJ3Kkamymg3C66opN
         RSfRMtJKm8h3Y9BqOzcXjdlH6g87NOZqBCh1GYf0d7ENRyqoMsBioQSwwXIhMVH7sYBW
         8QULQQyHVJ5HgMMw8bfkJW8XPyEPkBg2tygukF0RhL7YbsgQrPY+o22s9DbW19XsPL/S
         7059zGivGcIxzBaFs0Xrd+c0VUpJw0lUi0O4/boL+fgEITBdhlxz7UerH9LelwZZT4u/
         kp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eE6+eEhD+C63Fu1K/v95BeKlMaBi30euPUmiLWrnqTo=;
        fh=BkCRxnhf8kUJmYjA+t+SEM49KVG2ncmS7/5YdpZIEyc=;
        b=bb7QJfTvlfsvk7B5llGjc/LU43GVE+Xju0wGu8ZKWn9cpZnYoqalUR3inNxhCn+071
         u1h2yPx/E0axv2UbMfz3Ry6Rp6TCKriZMUF5mW/+dK60454fzqBg3GOJhJWjvo2PFFmM
         D4XWvDmPcjDvFGHcjanakG3Sk9WKYwWQMk+oQ0nNoLtgZVl7NiUpxR8wahiOB39Srz6b
         yhqXlpZV9fKG80jOJx844Vgw/Aiy95NmxMq8J7/klE3E3j6mEps8IuiuMQBN/CxAo/RN
         IZ4EKx5/5qZ8bSEJWxRr99jhXTa4pvFxE1dLXrCwN7wlYN0glrgndq81L5Fx8KetKlrJ
         jTxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1779600366; x=1780205166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eE6+eEhD+C63Fu1K/v95BeKlMaBi30euPUmiLWrnqTo=;
        b=ZL2CEazTA2PfHe3+rM6KbyAfbUTxYBt7HBr5kS/GdZRE/maDMo/Y6sLRxKcdlChO1C
         Ou3MbL60mmdnYW7rjXmY8K49FouqaVsJggcALQe3XMZGUTGHhsWAnNjY0cIjRWV4ZnJz
         mimNaiJ3W7mYQEZsrwHcn4aYPz22bXowzuk54sd5BRjoSo2/5lti5Gb04LRCdXwcfEgt
         c6JJ78pPknRvuus77AEOjsboOf+2EzH/ufSy8/pgyF+bLM9qOLS3ZzArXb3oXzGD2OE2
         7rd+jYnw5sAbHrdltEWLDaOy5i1f/4ratyhNP4FCoihYdaq72hTSzZ3LzmbNsDBGgXko
         aVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779600366; x=1780205166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eE6+eEhD+C63Fu1K/v95BeKlMaBi30euPUmiLWrnqTo=;
        b=CQYesQMSObdvhJ1IbCvBwgeZ+wooBDnrF2GuykYbaVnbN69xAuCJFgZ/UJatWa/TQe
         2x0rfr9rz+WSgH3S80VQWJlxnPJW9unIIc3nPZDCwf9bNmLVi8fVDSWomKAJ1/WlShXc
         ShWjDK3Ss4p1+GM4aT8QKUtCQ2uRohr50sxU/DbxKfaHlZPJl95G2VDMhDl+lJn5HDhL
         K6u6Gs6O68zQnAjGNq58WRzVWMMI0n5hLxynbnUs3eNXpShEk+NPseCMLwTR72yN1GPx
         WmrZFU9vmLQnms9iYMxUqMcJzXaU8oDVOt6cJbR7wqyzAPV4yW5OB1RJhj0jR5lIUfTw
         3tFA==
X-Forwarded-Encrypted: i=1; AFNElJ+und7LF1ck+0NLHotoA3nMMZDCSwynECQnB6WInFWqgttaAKNLNUbJ1ZS5aUhNwUsDFBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx15vX9mKZvuT7NJmHMGnqu5Z2Z0uKWMlb1DKcK1GwVNSxGWSgF
	85hXYqXvHY2WkqX3rPyEZjky+vqFd3CCCzpNqo15+W9O+LPD5c5DKFFDDXfgZCk4sohTGoymqE/
	/yz9eTpx9LTO3AE5kn1KvcE6tShScfB+oy3ZdnAllfg==
X-Gm-Gg: Acq92OFeFXUuZd2317WUfV1YYpStl9NtDINjAmXHUFn5zyfvmXPoKVH9o63oIlBgND3
	Mh+AUm1rhGearYKbJQtKWmdIFCy0UwTKfyR4vkE/GVErEwLEr0vvs4Mt63xl+ugnIWogqmC0Nkv
	tp7RfPNpIucfeq44tTCkUmphMTbT6CKoVv05qPT8lfo+FM2d4u20YQoReJSl1dOltP6Jl1rptKI
	sU/z5vhqkVZK0Apu7YQpURUE0C1rg6gXqAwzYJj5RF6QVqGKnpnLJIfPHMvjeDld03SZmf4J0Lc
	WFUslcOTbEaCR3+6/Zf8JgJ2Rinb5qq8dWEMCjqjNBA9Yprzi3g/oyWj25mHnEqJgcEA55fW651
	4UuHKebaR6Ov/l6Vo8aBHhgnUhBI=
X-Received: by 2002:a05:6820:868b:b0:69b:5f97:de79 with SMTP id
 006d021491bc7-69d7eb91b64mr4064957eaf.19.1779600366573; Sat, 23 May 2026
 22:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425005916.3321811-1-guoren@kernel.org>
In-Reply-To: <20260425005916.3321811-1-guoren@kernel.org>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 24 May 2026 10:55:55 +0530
X-Gm-Features: AVHnY4JBNFDLe44QojpCNBOQNUnwD6PWyRl75taA_4p2OczkddPd-j2jxpb_QyM
Message-ID: <CAAhSdy3T32AuG=MujHOhjw08h7h8UAyYjkORVNxUgR77Gn1ZWQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] RISC-V: KVM: AIA: Convert HGEI management to fully per-HART
To: guoren@kernel.org
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, atish.patra@linux.dev, 
	cp0613@linux.alibaba.com, fangyu.yu@linux.alibaba.com, gaohan@iscas.ac.cn, 
	inochiama@gmail.com, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, me@ziyao.cc, 
	palmer@dabbelt.com, pjw@kernel.org, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 6:29=E2=80=AFAM <guoren@kernel.org> wrote:
>
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> This short series converts RISC-V KVM AIA's Hypervisor Guest External
> Interrupt (HGEI) line management from a global "one-size-fits-all"
> model to a fully per-HART (per-CPU) model. It also performs the
> corresponding cleanup in the IMSIC irqchip driver.
>
> The motivation is to properly support heterogeneous RISC-V SoCs
> (big.LITTLE, multi-vendor core mixes) where different HARTs may
> expose different numbers of guest interrupt files / HGEIE bits.
> The old global `kvm_riscv_aia_nr_hgei` and
> `imsic_global_config::nr_guest_files` assumptions are no longer
> tenable and are removed.
>
> After this series, HGEI allocation, freeing, and interrupt delivery
> are completely per-HART, the code is simpler and clearer, and there
> are no remaining global assumptions about guest interrupt file
> counts.
>
> Changelog:
> V2:
>  - Add per-HART IMSIC guest files to compute final HGEI count.
>  - Add min(local->nr_guest_files, nr_guest_files);
>
> V1:
> https://lore.kernel.org/kvm-riscv/20260421145451.1597930-1-guoren@kernel.=
org/
>
> Guo Ren (Alibaba DAMO Academy) (4):
>   RISC-V: KVM: AIA: Make HGEI number and management fully per-CPU
>   RISC-V: KVM: AIA: Replace global HGEI count with simple enabled bool
>   irqchip/riscv-imsic: Move nr_guest_files to per-HART local config
>   RISC-V: KVM: AIA: Use per-HART IMSIC guest files to compute final HGEI
>     count
>
>  arch/riscv/include/asm/kvm_aia.h        |  2 +-
>  arch/riscv/kvm/aia.c                    | 66 +++++++++++++++----------
>  arch/riscv/kvm/aia_device.c             |  4 +-
>  arch/riscv/kvm/main.c                   |  3 +-
>  drivers/irqchip/irq-riscv-imsic-state.c | 10 ++--
>  include/linux/irqchip/riscv-imsic.h     |  6 +--
>  6 files changed, 53 insertions(+), 38 deletions(-)
>
> --
> 2.43.0
>

I will send out v3 series to avoid some back-n-forth.

Regards,
Anup
