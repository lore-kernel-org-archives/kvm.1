Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792650471;
	b=grqQgtOXu5D75ZKMMq/3BO+iPZxRs04MBJL9gRj8k1iYBA7WlmG4TaS/gtX8z2O8ueq/
	 AXEntotZITGdXPgmUpNA5XO+XzwNETOQWDwt9AJ57qV7qO24m6dXFIT52uWf9j9qcvWbf
	 F2cQ4NdMKAKYRkCltve0MWnEYQfQQON95qtX1Wp45JsPhrBmPszNaegh+qpZFDms7sin8
	 i54XAM9LtKxdwvT0buI/b+FLAgFic+62sqp2QDvz0Dk46QJe1uBNsL5NsfXRO7Zui9HWZ
	 RxZSuiY3QBkbv/LyBw4FtsQcLJYQT/wHua3wJu3ubRY7/GMLnWuZuXkLPfyQ5hjzwtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792650471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=c8KWIoZNW6/QAD3FZ28O4CFbS3YPAHolywa/ZQAktrE=;
	b=haBYtyeTG+e3dcz9kCxSZMFeepX1fHNSpXl0b8rusamr06/W2UeW5fi2/fVjqyfPgyZS
	 moq3fweie1PYuyl8UMg1VFoEijvcrRMd1DW8VvZvZ/ke0P/55+fh4A8uMhzzx4hqoXcKX
	 sTI6fDeWrjHRHgoqkHuPqYwOickgMwbi7b74sm0ICHTiN44KEiDohZoyI3Gc7F3m83ooN
	 8omtTF1MjxmVtd5cP90KGlIT6BD70yzAXbQp5KrDHmXUVSRVgULn08w4KEFT4gc9mgX9a
	 lrtMIkJem3AqMVhd15Y+ysMMCZCxb3FU5pZj+6xtzCJZvyE3TtZ0DACIeSltoJVSOCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=I6BJalyR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C47606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 06:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53C47606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=I6BJalyR
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ab4891fc73so13129551fa.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 23:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792650468; cv=none;
        d=google.com; s=arc-20260327;
        b=MLAX8CQftfTE7FnPl5BwJ1jKC0g+WSgCtNt/piNQA5V4X+5GQjjAnSz+hQG6D5dfvk
         ElOKJqBILFqcQt1p0M04kTlpKeEbfRmyCwF7NDFMcOXwuija/8ulqD9wiFzZhadZuXoT
         Py6h+y3o/J3wG/McZ67vW4o/ci5axWKeT7gOLxL8KUIiejTPzJLJN2BwQ6EliVYPgIH7
         R1ES0pTQu21CWCHF52HaEgNlW51ITeSePvtM/Tiu2kzkkWINTQ26ngJuqINZhxgdCVNG
         aOdP9UINARvMA9vzp3p3Cykq8KVmM1n//BHY934zRvwZFvuUBwGC/poUNKRLtyi81LNe
         Z6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c8KWIoZNW6/QAD3FZ28O4CFbS3YPAHolywa/ZQAktrE=;
        fh=QRAsW/+httKe8R3eji7tST9Kot/RbatW7EAU9E79dkw=;
        b=ZS3B47C63LgSPbNHXjx20VaIm3V3NYOJaxWFgmLYJY5/xk7wCZA8apD7E7MpU4Yl0R
         5UpZuclk2RCNXm4Dd/SHmAc0a0hvg9z5qMrbb/PiWMFT9JU18Cyf4YC5Vcby9kA8Th4+
         sgPmKFxH9YevPGeqVsPxJR1kuwhICL2Z6itFlCwaC2aJcdw4ZzweyO1WqCEB9w4KM9GT
         48ntmAjfpgLLCTfFHMjy4HOdLvJolCbIo6zgR1Bb7xPy1KwSAPqo0WLuvBcRBj0fM/Dx
         7g52oiT1OqSq89aTnmWNP7DlEXsDZ4WKV+HtJJ+TuyViSSK3yu61pSycvLEaVLAHUieR
         F29w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1792650468; x=1793255268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c8KWIoZNW6/QAD3FZ28O4CFbS3YPAHolywa/ZQAktrE=;
        b=I6BJalyRUjlXbBnTqLj/Hw9e0stD1hDGncpWi81zlLKHhhX9z55e2piXfBA2ShEicd
         js+eeYjcAscnQ1MR2guAhdfiIgd97VwaWxDn+3saZwZwoqyxwsmPxQwCBReVsef3fi4p
         HEicD/7M6zZU/EAZiEqlwV94O9rbzRJkdL83ScTGERS/129XNqV2yh/Hh2s/GU/rg9ge
         DoqCjcnoMxuiGu6E6gcAmJyT4Y2sR4GGSTnfKptQqRlRKYVm+KrnjwXvBBM+fKAI1zlB
         K5EAwtzHBKSotwtsXA1CbDDeNN0sAqJ8tryxfVR/RMqCO3lBl3delvIcRWlgb+9Kj9+j
         eUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792650468; x=1793255268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c8KWIoZNW6/QAD3FZ28O4CFbS3YPAHolywa/ZQAktrE=;
        b=JmOVG/SNkL8+NLY7ohn8Ntr2ADUEeRxRcUO0arlHedtWAQotzYq0NOIKJ7bY5rwB6E
         Fs2jv7Qu4TSZ31tYoIAwUADFJudKWCvap3EHxaVImG6vW24pEbWt35FPFu473DVmtCB7
         09ungtbafo7uwZlKZcgirYSPbLgDQffBfnBzU5rhC6fqwCpkDPfzync0tacOHseKP8m9
         mFs6ZQ0/s0L+nceMWAITRcKQYZZWT+XUyki/Pm30oRKRvsP90ImFNkcxdaJdaVeWDhVQ
         0q9TsijIfDzJ0pInzC+cox2T1eVRQWmy6IsgaTSdqAlhe/PggSxqX1+kwb8rZ0f6ygC8
         pGcw==
X-Forwarded-Encrypted: i=1; AKwUvBy7+hcvE61w8Jgto3tILc9speMofNET0EcJ7ZO/ksRbfAz+DXPkJeRaNXI5lydnVEF2qxs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOHRnPyaXE8fg3lMOH3KsAjU+B2R1LJCRvpLzcFCB11fMlmj4P
	Cpf/B4vXpefvJDi07Dn5g3N4jZSqUkk8y56PEEmpj6XptJov9XFcUE2AiiMmefkZpkoZ6DFaxMS
	tS9XE8ifJor0ZNPTCikx2jFGVK0LK5gnaVgfEIrIYxg==
X-Gm-Gg: AYBFou0o4k/4A7BUOXhMr1JgfkJTnLoWtGtpo658jsIHUOvgnG8Q9LcxaXxTHE3emfH
	Wx7S4f7cSsSiLjVToB41/XQPHUhCsuw93G0fPIQX7w4ifNjUBzGE1qWnSm0Gqw2OWTCPrqC6g9n
	e8TP/ep3N4IHSu/t2Ap6um/6EyHIpUTDb9WRnJTt/mnutnDTtydoMpKwdjirIprlX0yENpzsjFC
	aJ9mdUugG5HyH8dQAKBVezdwEoPgfEf5ZJc39bWCtOanmFYSuzRQw5KC4Uvdcajbg9WwRaRq5LI
	pC8twCChgx9pdAlyQyuiO5HRQFScAaODK7M1frNv+Z8aY4RQIG0A9pWL1rbU5Mty0EBgs/p5MjU
	15FpMC2bx18o/ACMtFqcOpJ7OsCygkq3XqKVXv3o2wup4k/Yi72kQGgH/NYhMGXdziyQv+cAY8Q
	ndcz3t2Zk+rBOlscVq8hEq1x+UfzSIEgVq5McRCkziY4RFOp6OPpE/1jDEJjaqhUy+akXfjHGj6
	vGrgw==
X-Received: by 2002:a05:651c:3134:b0:3a9:9a3b:6036 with SMTP id
 38308e7fff4ca-3ac440b53c8mr12628651fa.2.1792650468375; Wed, 21 Oct 2026
 23:27:48 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014224239.963635-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261014224239.963635-1-heinrich.schuchardt@canonical.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 22 Oct 2026 11:57:36 +0530
X-Gm-Features: AclHuK-9TFsRegjYZcIPEHWDYDOWlB5NKzsnn-yH7Qq40hb2qm3j1NzJo9FfRwI
Message-ID: <CAAhSdy39UtV0sUqL0=FX+HWa7oAH0fkei1cFKiF6OBSSFT=gdQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] RISC-V: KVM: Allow Zicclsm, Ziccamoa, Ziccif, Za64rs
 in guest
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sarah Emery <sarah.emery@canonical.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 4:12=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Extend the KVM ISA extension array to allow KVM userspace to
> detect Zicclsm, Ziccamoa, Ziccif, Za64rs.
>
> This is just notifying of hardware provided capabilities.
> No KVM specific support is needed.
>
> Add the extensions to the get-reg-list test.
>
> Heinrich Schuchardt (2):
>   RISC-V: KVM: Allow Zicclsm, Ziccamoa, Ziccif, Za64rs in guest
>   KVM: riscv: selftest: add Zicclsm, Ziccamoa, Ziccif, Za64rs

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this series for Linux-7.4

Thanks,
Anup

>
>  arch/riscv/include/uapi/asm/kvm.h                |  4 ++++
>  arch/riscv/kvm/isa.c                             |  8 ++++++++
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 16 ++++++++++++++++
>  3 files changed, 28 insertions(+)
>
> --
> 2.55.0
>
