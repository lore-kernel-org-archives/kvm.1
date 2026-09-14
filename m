Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C99A37187F
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 05:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789362314; cv=pass; b=e0MC/6keJ1OnfVLY2zahqY71HrraO1yjA/0sIEamSTyADUcNckUDLd1JlX+29RUIKsXvolUqRoqCHUhkoUsPEh3GdsvBu6RbIbiq4Wd64Pc2HSZQd/KKsDeQOYQ+uqSJ2GadYpE4A6pZpt4Ao0nP6QroJnLN/y5FeEONww7ByB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789362314; c=relaxed/simple;
	bh=3/NGhGUhliQp1YZrkIH7Rm4z6KPJQjJZGZasUOJhwDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFqLT6d0S5NZ7ptVjPXyoE8xcII9Cu46sz3FoKFOm+PX6AMbQlpHK+V058opMM4CzeUZbyvBpsitiSn9FRrNI/00rJKpzg7orL2Rs7vXW+TgVIdk3Lbty6jfbWpVCsxvctmZnMYZcaikXfw9j4XDN668b3uKls2oaNZ4NhVnyR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=Wg9JnYZ+; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="Wg9JnYZ+"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843378fb37so627729f8f.3
        for <kvm@vger.kernel.org>; Sun, 13 Sep 2026 22:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789362311; cv=none;
        d=google.com; s=arc-20260327;
        b=Ty1cGE6LzTOGNH13XijKBChEikZwMb4lSRbcbPnelC9FZsf9J0JeCtdEPPXKZDpAj0
         MfAiduC8joV/p9NgOH7yVuT6AXtg3BXz9DACEMSd6PEgrl9oXadkF72bM765VFf00I1i
         FTNK8qubvHYB4YzwXhiHxxt+mGJgjdoiaAKDN06m2I8PRZi0OMeTaQuenS5A6W4PwjmG
         A/EzR5eMR2jVBR45moB2/johX3iKrEXVyGtO8UtYdliAgACmlRdozKnbRGPogkAh6daQ
         Q6csd+3FhhQu4Mh0xc4RQMRLizIA38+5DMP0sCK+qv1MjM1+vzN5xFDZ2gxLfs7cMwh8
         5DIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2lFbqmyGf2+vEHGBSIgu/0dJXwPUBsUwy+yR+CvMM8g=;
        fh=ZIMXD5BjvhB4xGQAByS6fhYlCYxasPGRyWb1YhOttJs=;
        b=T+1xJsBZH+wLQPgT9G/xE8BX2iULs7BQWtsAyzCkWKwwBRrGANqK3EilmrHW1UZ7wl
         bXF4MllU/BuueTdA6/2Lm4L95dd5QyCFU+R0CnKtusc6mcsrk3DS1kdgspWCqBmtdJZD
         wMNQHJSaeLT8hc5auiXLB8/xNm40l+YdzznHVjlu6bQoTDFzlx5e6e1N7NlOySGJ/RQ4
         7f12tKpvA31fz9AUhugRAf9K5WVml1ftH82eSlb/4/4eQMTSgjIdo1LDtwdBuzjscu4M
         64F5cOSTuwE2WusOl4GmJw/8xd26a1TD0riDuHtIoXDlAjmpUP5xNWymAW5xF/o95FXB
         Wb0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789362311; x=1789967111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2lFbqmyGf2+vEHGBSIgu/0dJXwPUBsUwy+yR+CvMM8g=;
        b=Wg9JnYZ+Ep+njDyjBhs2LCy/x2FnoqgIBuORrgzV01Rul7hBESWyGCCkQCFJk+mzck
         jIrjP5nQEhl5o95O0QwMxZ0vc9ONgXpqvIx3o2YKkczgbrJLgYi5o7+EVlelR/INpKD9
         qeZoC3a2zEd60XAsw6WxWSP0Vt2gXsG9B5SPkxE6AHgdNauvS5uTEGrTqd6mZWTjvhXd
         ByUbygPNwf6W4yK274A2CXi93kTLPgmcKmMB6zwW8DOZubRltDK7Pr0ZESMZk4II9WBR
         oSRB4MwsqsK1h4WFM1YFwGA08WBaD4tObTWP2fgO6Lwuv1ocqSxo3PLsfMUsNBo61nG4
         Wyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789362311; x=1789967111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2lFbqmyGf2+vEHGBSIgu/0dJXwPUBsUwy+yR+CvMM8g=;
        b=Y7PmoH+s+g9wchjzBYmfFBlQufuMkSQBsWkx70zu7+/pZwcKRjU5ivZUDdzgja8Rgv
         IMLNOaj+up2MWVOGuwEtlGVE8QO5CCb+4YDOoSIWiVbu2l3GZ93Uc2Ej6sj0RCWAqdik
         TrESad34TADRoCtx+gSlx6kwJJZAxEiexs7jluLpBpqmzWKm6Y3Hy4NHIkp/K3A0bDBa
         HikvHfYwxVtkufHusOHEWvdLgLjN0GRGwqa4LJFyXPKDpwI2h3EYKKUSYPHKG2JpXOvd
         GiV4jLNORi5kjZnIp7Otm9FO3bvYf1Z6bqk8kuiRvtl2EEQQjILQ3i3rmfDgI2IMnrKI
         vXwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiCwJuadQ3IhnIE+lKeF0b2mlTxxqtaq/zNRU8YvG8O3TalVIo+CpXErMeEsgz//hzbnE=@vger.kernel.org
X-Gm-Message-State: AFuF++mCHfZUtVP4y+vyZ0Au5E5lvsXNt/q6nVH9lyc+3zPbKA8hLsVl
	+QvfGUYXCQIkSD3rjnPvU2ePxHh92vOevPKqNXGtoXbKWgx0CeBduMmMTD6H4Zawvqqv54QxiLb
	Zy1BESpeNEEyFBTyuVC3r+b3eKojaRyOrTJAi+95OZQ==
X-Gm-Gg: AYBFou1yRK8uViLVq1r+TjCzCzG1PhnuIx2iNRZurQS+CsERpHwAJIWSpsJj5r+AFUg
	V2ZRXLyOpNStXeobClzIkr0wbHfObDeAlT7ChzKtjW5FkPZ1/COOU2aAICS2IXzcbY1b/VrlcH/
	WNBTIaqVLJ83kiNmVkD+4a7+uDdPkM/9LukSBNJzoh9Mhcs5URaxC82HQqNUY9sgyJXCE+K3fTW
	NVJSJWeJndP1TlLAHfFplpXadLTZq3ldzTl3VPi2DnptVPQE+ZuNwwSt8fTKYU2CuTVoqzh9m1h
	M13LJHKOie0H3w5BUITbgK021VLE0PA+a7X1iJMwpom/2fCzXk3L3JJhj3ByE+ZmA2Qe+d0Cayi
	/S0HrOPk5TQtGR7pOUa8Qb9dggPIC6Fd2QI2Qi2AwiI5KI2NV9WCblsslB/qtX8Qf20Kx90fjfg
	==
X-Received: by 2002:a05:6000:2891:b0:487:212:a412 with SMTP id
 ffacd0b85a97d-48702ae4de6mr759634f8f.9.1789362311187; Sun, 13 Sep 2026
 22:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825083719.643970-1-suunj1331@gmail.com>
In-Reply-To: <20260825083719.643970-1-suunj1331@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 14 Sep 2026 10:34:59 +0530
X-Gm-Features: AcwNN1UE_9mObcL_0yUCsop8W1hIdGl2EPgpfLQFtwqx2oRTCfP20KwRbzdJA5Y
Message-ID: <CAAhSdy33LqjYrozd0X7c6kLGz=bHgOuPAk+r6Je2R9a5Nh_-VA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] RISC-V: KVM: Fix PMU counter handling issues
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kernel-mentees@lists.linux.dev, me@brighamcampbell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 2:07=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> This series fixes three issues in the KVM RISC-V PMU implementation:
>
> - preserve firmware counter values across stop/start;
> - report failures when writing snapshot data to guest memory; and
> - fix perf-backed counter accounting across read and stop.
>
> The changes were tested with the existing KVM RISC-V SBI PMU selftests
> and additional tests covering the affected stop/start, snapshot failure,
> and repeated read paths.
>
> SeungJu Cheon (3):
>   RISC-V: KVM: Preserve firmware counter value across stop/start
>   RISC-V: KVM: Report snapshot write failure to the guest
>   RISC-V: KVM: Fix perf-backed counter accounting across stop and read
>
>  arch/riscv/kvm/vcpu_pmu.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
>
> base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
> --
> 2.52.0
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued these patches as fixes for Linux-7.3-rcX

Thanks,
Anup
