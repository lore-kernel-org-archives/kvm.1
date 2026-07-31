Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96C335F18B
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477431; cv=pass; b=BOYutBpbfF3zuVGLXg6CqHizvZtQIfkwNsKKtxO/hvBmYjAjYYUpATOoEyWRSAF8clBWFN1W48itI2BWbFoQkmnBwxNgVrNgmUupz1AUNRwGxvNc8t6YuZKMDGAGsIE9pIK4C17/QzgIotSfFmq7e7/KG53Jo6rAzC3reRD7U2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477431; c=relaxed/simple;
	bh=Znpmsl97Q0V/K29vwN2lNbYxoKMMuJZF/f25RYJSwPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixpQgGG1HcdnQ2d1oxZcWQi6AfgoRb3PWXmdD9BvlHNR1YpajDOVgpF1DBHBoEem83S76tPL/rAWtQ2zGg7QJO+k1EfEKKlUNAQRe04H/rxpa9UJZDljc145OZgPgQH4Din1CAjfYVHxCPV4kOKZkyf0mThuSlOQUCsCjtmUDK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=KqK13oQ4; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="KqK13oQ4"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b01146b205so389539e87.2
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 22:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785477428; cv=none;
        d=google.com; s=arc-20260327;
        b=AmfGqVkv5ck2K+6yCMUXOoPkhDjZgsfshvNTXF/jx0u4i9qOySdhWDayyY7kLQWTfw
         8rISs4jQ8vUD0QjGkOyY9oXKX+/ZqriJsz3cFvziDutf42P5YJPeWs4TfUzz1rd6KH78
         mFyjZI78i1PRsF9c79EgJsyU8tn6J7oLx0KBbFzCNTDq0PFxfmtLIOMFXMKoNNqu3R60
         7VhNvzerqPO1h0slMNt3j55INz0ACY2bUNAkWGgb2/yXnnbOkASo7yZ9IxLerRMs7FaO
         iKDtD2dCq9Ww0BPfNcngyCZEty2gUJG/smYN6zVE9z3+C8jXQ9SFbx9HlNTpkaBoYEEC
         jBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IipFgVRsoH3iYGVOTYy4qykSaenCoVmPpYiCJWUhT30=;
        fh=TqkDo7HJm6C2bTHYqbzn7b/i6oYTm+CMOZGiIKAd8p4=;
        b=bqfMQhUUWm1DZ7EV2RxaSC8RQJHbQq38kKgKzgnfdRFVTZNtuapIbgf6UvodSK1yd7
         HOi4c3nHEQPF4zIl8J8tZMIB0i5EWNruMpNxA4sOHlhWGAi8pwEVKkeH1Z1zQSbpE3jP
         bCMgW+ldMHdjvBMMJr1ja5Ld2sINO1dfNV94nkBqj5rfFv6ly7mSGjZjXuiKMGmN6Xnv
         qTrxZB0/6ixej+j3Lw38U8IxeGuQlcH7gdnrMcEZdKpSTXZzfIPriKpcBzVEKeGuiSr/
         q90nw6yXvaO53uKTk4KuaYO+yPromPIGdpWAQEpDMAGwT1Xmu23vETRhfVaQm2ZFWo/A
         vp/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785477428; x=1786082228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IipFgVRsoH3iYGVOTYy4qykSaenCoVmPpYiCJWUhT30=;
        b=KqK13oQ4/BXZTj7rVeHoAdduIN5ppDIjM9e+CSwRVgfoPVv4aChQBpuCImDCce+9gL
         chSAbQCgj4VRWM/VK9YCMsuozrs25CJukvTvm1EnKK9AQQEXfIK93SNgYAJZYgAbpKaT
         7WY8JlGe8QwP7hxVcIoWXk8eHaCYCU9k7nQRRQZpUguVntnDjFiXlgHkTczlTOBZrvom
         9DQtjtq0TSdi5/xADNW0NV7y+KATuEn7hMnOiV9lWhGRSJhjis8d/Vo0vyw9RdKOMf9d
         7bxJHax1y81/Hwxc39mehpUiJlCB8SUDa3eWveQliJdh7S/ngk5GDspwO4NSViB2BOgI
         rN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785477428; x=1786082228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IipFgVRsoH3iYGVOTYy4qykSaenCoVmPpYiCJWUhT30=;
        b=OUfNNzhv3xOQ+42zeQ0Yn1MamK4EDhAmaAsnW+qH2n/KukTRaREom3qvS4CSwYPExg
         78W6y5GCo/UnsBDeBu6RKoysev8uR2RnU1pI+5ptBG9BDIGyKJf5zo1hU21gKkzVcg+m
         SZ6r6/F5NfqpsErdVEwhF5zKWQ5bKZLDvu/CVctsknK9NYCCt3VM/IPQoY2aW5Pl/i4v
         aMkOwYfwa/f1HYyIubOIQNB8WUHZWo1B8X8+pklYN5ajqACnKP7KpAhHSTSlGn48AP1q
         Nwr+NXHdUMlunasviYNflxh+Y2IyidedDru0SCcz7SGaOKhF5Uw/0hD/mTg2pnuWcTsL
         W+kg==
X-Gm-Message-State: AOJu0YwuzZDzxxG7GDDT0zlkM3so/o/yqLPlz8b3yNw/Kt9c+jjKQoT0
	fB7omObGxcecqiapIbOjr2RxZ0RQqAwKh8YfJ1n7P880lCWWWA4sj2FUfVteTuZWJxBdDyJO6ez
	iPms4wSj36Ub+5uy5DXFS2X9/EdUVt6JfwDXtUozQ4A==
X-Gm-Gg: AR+sD11UlkwFtofVp2aa7N8M3B9CSe+FkbfJe0T7UU93GBW1/303HJsDY4okusjfnGY
	IQyy/ThtAhIRcX03zC/DfQvyszNDbj0qsLmHxHSDIOKcHRv80OV2Tl+FQCQL3C5I6oExQRc++ef
	dPomzlZLnXFzZfFqpOHflRR+OPO3f8jgTtQhZg5PmA6KmO+8xZgDFMFP5neR9amUYRGvoHpPXkv
	IUsqd54y/P2LCBnlF3/XdDnBuKV0aGuyM/qpNaidohAlIwAjVNUzEj7uq62Jzq8NzYn+XdBlAUr
	Rn36p4kVKax4I0qFa/BFXckjqcop87aqEYa7sqIMuqyWxxCeDlL9lRHwUBvz2YyJP5mQeynpz9x
	BPdZEE8jbldNNMGV2tk/HNQQwxf4Tu1TThjevAlrytexKTOn2KuA69QX13ls3AhMg
X-Received: by 2002:a05:6512:a93:b0:5ae:c3c1:822a with SMTP id
 2adb3069b0e04-5b2e1fff9c2mr193171e87.58.1785477427605; Thu, 30 Jul 2026
 22:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707125034.416521-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20260707125034.416521-1-wang.yechao255@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 31 Jul 2026 11:26:53 +0530
X-Gm-Features: AUfX_mwuaZ3aS-ay5M9hKbAlT0MobWOtVi1EJNb4YGPNHeO6jd96joBWaB7jDwQ
Message-ID: <CAAhSdy3bBQTwj80cmBvWYfqWgO1e8_Y85x=QG46UamGEbYy+UQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] RISC-V: KVM: Optimize hfence request handling for
 SMP guests
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 6:22=E2=80=AFPM Wang Yechao <wang.yechao255@zte.com.=
cn> wrote:
>
> This series improves the hfence request handling in RISC-V KVM,
> targeting scenarios where multiple VCPUs are running an SMP guest.
>
> The first patch Introduce make_xfence_request_nodata for FENCE.I
> requests and moves the hfence data/type validation out of the
> VCPU loop to avoid redundant checks on every iteration.
>
> The second patch fixes a more subtle performance issue: when one
> VCPU's hfence queue becomes full and triggers a fallback, the
> current code applies the fallback to all VCPUs indiscriminately.
> This unnecessarily degrades healthy VCPUs and can cause their
> queues to fill up prematurely due to lack of processing it.
>
> With these changes, fallback is applied only to the VCPUs that
> actually need it, preserving the efficiency of the normal path
> for others.
>
> Changes in v2:
>  - Fix the patch01 broken the KVM_REQ_FENCE_I request(Sashiko AI review).
>
>  - Link to v1:
>  https://lore.kernel.org/linux-riscv/20260707113715.413265-1-wang.yechao2=
55@zte.com.cn/
>
> Wang Yechao (2):
>   RISC-V: KVM: Introduce make_xfence_request_nodata for FENCE.I requests
>   RISC-V: KVM: Separate req and fallback_req masks in
>     make_xfence_request
>
>  arch/riscv/kvm/tlb.c | 46 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 11 deletions(-)
>
> --
> 2.43.5
>

The PATCH2 is a fix independent of PATCH1 so re-order
and make PATCH2 as first patch which can be applied
independent of PATCH1

Regards,
Anup
