Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794876839;
	b=qDgkkTMqjxKsw5jm+IwSD7jsIbD6qizzHR0sVNHkXdOK3wQgtSMcQJLLvcegA6TLjV7v
	 4y9SwCqFw90L0TsE9i5o4rQqxOYozAJyZ0VFavSmNqFLzW6e7FUy16DucgrCNfUfdljhN
	 1r6xFt8SbBfWTa8+n2kg8+e+qLj5ne8C0zGPH7h4u7/nx7BgmEIijoPfpCYn9bpPVWCFQ
	 tLKynVzuzocghX3TKCTN76WAL14h8kqqiIo1jazXYjVEWGHmBImY4QpOyG2yvoVnQIKdT
	 spF92Sj4jKATGSkowceF8NKcRBNP1/8oS5U80OVGFiP9qlknD2khh36ERmafSZJ8vJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794876839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=A1hmyks7PnfUxhgzPsJhSUpf+ZPr50/wwC2v05STh74=;
	b=EATaXVpzyGMT2TSOtFwofkhyPyp/ZLpe4+fyrsrYBFhjjVxBJBF5HRL2MFxh3hV6nyzu
	 OUDhD18XlMrt6g/KF1/NcHUrpsyWhGTJAdedTRVRLMZYkPCBNB5+9PTX6euZXzutAcO6Z
	 p6wLJ1awzofEE7hbTxZ1+7K76uS2FSQ5d5DTzOP9a+2sgM3PR1GE7BrD3ao5vSJmmSoA1
	 dd7rOMoznWl5/cl/7NwBxlnVC2d/Fh9UIqc/Nw76Z4GGAH0ZdoqIdun1Bnm/ycN30LF5X
	 u9J6763HvD5fbGgLbnWGE+R2ZeNrgyfthGQJeyUP0DHay8fNnU6vz1mbAEZM/V7OeEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N9RkPRkY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C5606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 00:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C68C5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N9RkPRkY
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso6623a12.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 16:53:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794876837; cv=none;
        d=google.com; s=arc-20260327;
        b=eUkQvQ4fb8NG7E3gJupcr4cpJ2+jnOrVuHP81xmlLeTLUf/lvRrKyOmE8wJqCH0xK7
         7j7d7KOZATB0tupGLlXyP8pxBZIgH0fuKnmz9NuWKdOMGO1hq0jmAlLD6nZsgKmcEJlD
         f0QceRMbmu9CwI8BsqR0CZ0FMlajhbzsSWC9wtuicw+/UWOVwZdjAcFhFY5Uywn2s0pq
         pqT4r9WS9uViIZja1K554CU7Ayo94p2THHjekO89RTB35gadWbijrNrSz1tO9vNbk0Ct
         zqbjJKRmXoblr6FI7rjHQTPVzfF0kCvpthhnpzCcdJzkcvPF7+7J2kkZhKURMA3ZwatX
         bmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A1hmyks7PnfUxhgzPsJhSUpf+ZPr50/wwC2v05STh74=;
        fh=bn2AwvhAXViUidqTt0NbjUNSAJpMssipI3wcbIfsOlM=;
        b=nZfdXFB4Khol7z54NZPsqpGOMgqeUXFe0s3kCE2FqMSg8vh3nTWYeaej/52gSqAX4k
         2F6/K47BUSF5IR+WYOJd+KKC1FXufSz9UYjpC5b3Y05MNw2Ptt1Nf9LaQw/KONJMkE6N
         cyPz0iQsVm2Ojf2OdUaU5fKnL+Dl4YSXR5drOnwRJn3Jo4visrp0b3LvjDTk/5lAkWvp
         Ys4JUI9P1Vyeuj//lTBbgD9yiQ8/AMhAh3DQvBaMvSuMFZHpNdHX/3oqh1ioDDu/00Uj
         z8X+c/Dvps4QerE4GGj0vKzzm93nFk9WCszku4kQ10IM7Kq+YNZnmOevEeaUCkGTgJe3
         WlSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794876837; x=1795481637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A1hmyks7PnfUxhgzPsJhSUpf+ZPr50/wwC2v05STh74=;
        b=N9RkPRkYuf4T11DtciheLdnFwdPQCj2TpBljehj/77HdGh7+YiIBbfkA8agWdrUl4S
         uDcyleuqudTX4u9OViPhZmIEVJKYvKLcQ1YLZJyFYiHgUnDNMls5Yl5Np7DkiFExwZdu
         hETjmzz7HO5hEU2EfTpqmZccFb6W8Ct4cu/+6MRsnnEfRgndStwrcv3ThG7IPGfXMb2f
         X8gpj6fs987ZLM/1hRAVBLkrxbAE5qhhoyl7zH8L4ea/A5LotkTY9hCZbIUSxSrzFcTY
         FMHDkPd8uba8F+VzxMyZkOyY8TuHGHw9fb8NkJmPFUhXvDNgH/7bH7bOyY4cFvTgQ3Jz
         e1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794876837; x=1795481637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A1hmyks7PnfUxhgzPsJhSUpf+ZPr50/wwC2v05STh74=;
        b=jnSxxlk3M+B1zpDJja192SEW6madwe6T1Bz37iLqi543aCVcUXj6nxq8CZt5ljEygp
         l6z0noZ0T2SH4DykQD3q0u0E3heHit3ocsjCW4sVV8g9IO/HhaeSrMF0i/MluL/LrGcp
         ROfNwry0uMmjDzgVuD39yuFjCHGw/CArn3miF/tIBQKGMdrd9Ibvk3It/mtCS/jjrvR6
         9H+kLLrkH2IYjL36RnlJh2lIDZrgZZ15sWJw/WmBJ/4dBw7z8tsSYIsMdBqoyHDkRs1l
         +Q4GhPOCs3IRx/YjvL7hmVeA8tq8xxPQKAgne7y2CqS2T7idjwhRl11/oqfQjlRhiGr5
         kH5Q==
X-Forwarded-Encrypted: i=1; AL+hErHExo9dXcjApPzIm7Zo16YJx3p2RjRtLBH4/No1xBLYjKYaGw0tMvnENxNVxovw+FHrT+o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/ukEsXCDX64yOWhBbWg8g7hrI9gN2zq3KMUAhMovgDUHVUpZQ
	LuEnlM1rQW/xx5gtuxoEYlrzYsKSb+cPUk+coJaIwEqQyGg0XWg/bjy9ynoaBUlfJfYvyxkAKx4
	cJ4YP5GEJMJIQS9RRbNK2/tcNWYTO8zdwtzTn06Df0bU4BOHqQ66k8IrL
X-Gm-Gg: AYBFou3XpcDnLxymKrj2nXrkgnRjYgmE7MkrTPMwEVScGovKdzmH+Iz6emOcbfFZvmN
	ZT8FFiIEsTU/2W6AvqqXLQe51hoy++mELYZ4nDuLig+NRrTZ7R3/vBywTTT4h+Sf+IxHpfZNRVi
	v15LUA91J6kLWWU5B8B/O6LAazVkfs15sx6u6bpX8rLE0HYIB7VX8SzRbPj51FHVG5/QzCPBLa2
	/6rxCko6KjU7sTpg+1heSRdqF/CwkhgXtFkIhB3o8x9g8niCydvpxI6Jdua871uwrD+gBPIyUoT
	qJ/uL3HyBWs3Wxsr3YtofYDamZotpoda6lF5nJmHYMuY9+Jxu/bsuWIjNJtYxEDbyIRNnPewm8P
	RL/D0tYyTleUeVB/8zpvq5q540vVbz6zdcwoNi+7dmRLsBnSeSKRm8EjQDpNGvXUY/DKkW2Pv
X-Received: by 2002:a05:6402:404d:10b0:6b1:c6fc:aba0 with SMTP id
 4fb4d7f45d1cf-6b862ea1772mr26359a12.7.1794876836831; Mon, 16 Nov 2026
 16:53:56 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116223033.3866283-1-ma.mandourr@gmail.com> <20261116223033.3866283-4-ma.mandourr@gmail.com>
In-Reply-To: <20261116223033.3866283-4-ma.mandourr@gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 16 Nov 2026 16:53:44 -0800
X-Gm-Features: AclHuK-_ONAvoQV2AWzEnSTuAEHX60cMUswZ9NZQ6pnplSH0FpE2bJQY3Yp04zM
Message-ID: <CALMp9eTadwjDENTw=oFixE_5Dp+762i0CuGVTt0pjN1q8S-fOQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] KVM: selftests: Verify nested VM-Exits while
 vectoring INT3 and INTn
To: Mahmoud Abumandour <ma.mandourr@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 2:30=E2=80=AFPM Mahmoud Abumandour
<ma.mandourr@gmail.com> wrote:
>
> Verify that a VM-Exit while L2 is vectoring INT3 or INTn through the
> empty IDT reports the event and its instruction length, and leaves the
> VM-Entry instruction length alone. Only VMX is tested, as both lengths
> are VMX fields.
>
> Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>

You might consider testing the scenarios that Sashiko flagged in V1.
