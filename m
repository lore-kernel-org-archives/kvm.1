Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795585804;
	b=Lg+T3guUi5xAyFH7abGLwHafjA7kBhaF686BdDWWbZQTrNPLyIblHsJxQBpK0CmWbnXv
	 t0+5ULi9JBe71wcoNKoUEAx296J5PqkARw9H9nYqwbqeufVqGARuVKC4Mne6MFS7b93qe
	 7uc+AoSNc6HCDdMyhAs6ZQsehBbJ2bnaeT3hs8s9oIuphNNvvwme96PeegS04mlMN+/hU
	 TCOkr/62EBl1o1GMPcSKQ6QI6K5+XrQWZOU2uAP17FhsH7VYZpfXJfHM3tZXajYhEhw5F
	 2ztPcizY5Z5J/L6jQDufCQ/Uwfu1lqy0Whz130cklefcGRjGZmqUUFO1wg2OtooSy2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AJcWadRJU+vTeGGYfzg2TttCaXCo1woljVumAlihtvo=;
	b=q3zNN7WLeFZNMsm6Zzq2Eb2x6UfeNH7vqoag0YJjRI9IBp2CiAvhDw67/LnotYg3Pudx
	 2Zo6nsMPkXL0kYsDupxRT6+oIwGXKZKx+IFb927F9LVYSj1NVeI+e8oMx5e4MvqUNBooo
	 y5xTHurSCClblp7sDFAyi+KN5KJFYaU7JksxKPuUc38brIdY6MEuvJ5VHbEE+slUL3el4
	 vTWEqtPm8czvAwfiqQk8AR0RLWglPOopI7BqzIjD7/ZhBIcjRYZw3zoOUN/bM1eJafeEI
	 RQbDkAMtv8/Ha+cJBROXaORFZt2p5C5zsdDZl7Nf98Yu6iRAtlticsO2AznhcRbH51Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=tzN+erC5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74D606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 05:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA74D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=tzN+erC5
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so42350485e9.3
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 21:50:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795585802; cv=none;
        d=google.com; s=arc-20260327;
        b=sKLrLU4DYxf11yjZAiA2DOOnRsOWMj4GIw+pr48cruMWDVbtpLzXIBLg7Biv7qtJkK
         Iao/51F+VbffaupjUN86NqyyeM+ZhJVP1FJl8X123svSfOivwwbnFi1V8pEUdatLdziY
         FzMLUzJl9L9zFr7v2ogrbtAj7TYD/qCVLqaEo6gGaHU5LyUhWItnzjxVQ3/fCAiedKBE
         V3E8inEG8mYfTtkZrtIiZygs/kucO4YzMRsvpHiNujhS5SKiLrji+XR6nt2aRYW1kEE5
         o9O7Jd9d2j2HyaQmjR+ZevFNgabziMg4xLcC8cuUWm6mFibP0Wa3A1jsTtCJu+2ItHes
         lX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AJcWadRJU+vTeGGYfzg2TttCaXCo1woljVumAlihtvo=;
        fh=iQ/f/oeKohPv7ALkqHHxdZ/vsu+W6a7fyMJPiILI5eI=;
        b=XhCRnQkitb1swI9VzyxzfdSMEyAFHUh3iHYZpCAHfJe5HPCJPTXWkR9MpHx09AeV5W
         XbSKT7/eojLkDEe6y6mmlCQ7GfURMoMTPXCgayMJxarG3OvLN9l3xuQ5OPL6HzBtqbwe
         MZ60asAExYmwVtzEQpao3u3hVPLQGnSXk9zlwO1GJO4R/LPYKoOv6n7U4DtHw6mndbvd
         +jYeXEF4JRsg8X7sT7tmDg3OgRqh0uaX6M6cSa5cn3Re8A1Bco+ZcBu5nbiVXtIWPKBL
         RuqFwY+2LCkTE+ndjCmuhvNNprox992wRfGxqZ88j/TkD52B13uJytu09nFzLyTdZuM8
         ePGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795585802; x=1796190602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AJcWadRJU+vTeGGYfzg2TttCaXCo1woljVumAlihtvo=;
        b=tzN+erC50EEU8sQeewE5gH/TIFhlCV5lhXeoB+nc/rOmLxtQAV0bsyE4IjAvqii4pa
         qJnh3HVDVnjYAWeu1g3I7JnCk3Hzefgjz4OjEFrnIw6clNSfMdQYuds4+ge6YDJigy31
         RNYt+9P2Ia7X9bwRqJHTrkUF0qCNPheN3IANNox4eGKRHaNXGfUv4yvtgwoKiRrAnWoL
         tSWYl+ht1mr60EvgJfFOm+seUlsG49AWW72E9YxPpH+jf9Xmerhl4QfuVdkouxWH8v0D
         uMr2aEPlkKFKoOtrfDsscgfoA4A5A9ac1GSDmneUYq1vPNxb4uLlMaPG9DDCAsP7VSOh
         eSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795585802; x=1796190602;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJcWadRJU+vTeGGYfzg2TttCaXCo1woljVumAlihtvo=;
        b=b9f7pM8SAmg7drcli5Tavy2AVh+54FvOr4CMciMqDWheCsO/7V54DITh5Tclls6yrl
         WVk6XhTVOgBGFRg8HFgp1iMLI0Txhav2w+LN5LGELkqaF7peFGNaA1dGiLq50VgahoPG
         Ceqo1nhM92D+W/e24W2TcttuTlSeHEXRDy4YeZWB1bPLZtB0lMnFxtmaaGuWQ3yrK5gV
         fYLwZEBWA5ruKSEjMCkP5RMeHKZWCDIbbNSDszyRiEvjXtIQ6vhVKGinAIxr6/mS/WMF
         t72TliAhJ/snPAAH3YieENK45tpCdRKHTLje8jUUlyH+P7EguRMMbujE6gXcJnXYFadd
         JrUg==
X-Forwarded-Encrypted: i=1; AL+hErEQxAZewv4HGQQbMzgVKdV3xFVjKrJR5QvIfruG48EzwPWgzZVMpFQhC4ga4G6a+yqFlX4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9z3gJjh4Uuj8Rpn4pxxvBE+1BtDT5+6dci4jjszqj6J8MvNR4+
	yHhGDYCGZ8kZf64B2I1BJdn/HCta549lPhnbayQi9EtpU0aGt8eesOKzXWzqJ+b3Hs8nV9iqDxJ
	5OpDJB9NGc8sxaX25dzeYfYbgLLJMwFVEqfMwriab+g==
X-Gm-Gg: AZFdTZcBv7EHMPl/fIvY3XbRcyzQnNknu/qoWQeh1hMw6FuCTHEOZFiSTtqEfrzZUzj
	/yIG39qy8JIsV9iBGF2pTRs9P8BDbEzrzq22A0rL2LUIDIajR4VTWSnsvj5n1/FAzuIQ+ERYqPF
	I0spsEdsJhNT8XeTA6A9NicPkMb80nE5B+ZHtam4nQpcMUj4rTZ2aWOdcxWy0h01DBNvY+Yt0ED
	yueZ48m0TBJji8gh0ps/yJvVNOAzUeYX/ilyqke+YbBBKsLYhsJV0hLuXye3iBahnhHISYMm/Sk
	D9pZwPIiZ5GmJwqDdzwkB81ZtNLyin56PdH/Ivj+2lGYmQVMVLIL2FVpr9tJUC81ztsa6nyH8PZ
	LPFGIroAV8bJKH/TLAhnX0KTJmQY7sgm4z8tXMF4m0niPgjCSADpziXhtjURwzMEglsXHYp6m2w
	A1shwOqp4aasLwDhgnFaPEPGAPjFC8ivZlMjrJHa1iHJj7zCuuG96zwSw=
X-Received: by 2002:a05:600c:670b:b0:4a6:30c3:1114 with SMTP id
 5b1f17b1804b1-4bb88922df3mr317698415e9.12.1795585802059; Tue, 24 Nov 2026
 21:50:02 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260921111402.120911-1-suunj1331@gmail.com> <20260921111402.120911-3-suunj1331@gmail.com>
In-Reply-To: <20260921111402.120911-3-suunj1331@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 25 Nov 2026 11:19:50 +0530
X-Gm-Features: Aa3M54qit6VRNciPHtVoHbdaqRLIxhuX2UY4YW1iBU3P015oUnZkIIeZ7ncDCSc
Message-ID: <CAAhSdy3aJo_S=miuWjFRwaMyd9XwDOWT94OLRysgZ3+r6-cvYQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] KVM: riscv: Read G-stage PTEs once when walking
 page tables
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
> gstage_pte_leaf() dereferences the PTE pointer, causing walkers to read
> the same entry multiple times. This is safe under mmu_lock, but a
> lockless walker could observe different values when deciding whether an
> entry is a leaf and which child table to follow.
>
> Make gstage_pte_leaf() take a PTE value and use a single snapshot for
> presence, leaf and child-table checks. Also remove a redundant leaf
> check in kvm_riscv_gstage_set_pte(), where mmu_lock prevents the entry
> from changing.
>
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
