Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021F235AC31
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 06:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359530; cv=none; b=j7Wt6kSpV/vbFIxLYQs437GrndWPggCzjv6ZnlE6JAYWViia44IgW7DH0eG0IXFr+4sGq8Ei/QCL8gMwKuKe00JmQzTh9uJwDknG+P2RLhfUg0rIVFwviVHQa6SLAwGjc/I7cSX631617gqCJGqeQeq0GKGr9VuybQbYqZfAtyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359530; c=relaxed/simple;
	bh=Ke8bRUdqBfahDaxMnO0T+9k2veTih85VQpLRCZqciuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWdcpkFoCAJuflRLxwAF1vc/1ql8o9bb2qHBR/u4OhZkDFH4I4qOvFFdoE757u5iSh2uaBzl75SiRaVy8DSWjkYc7HIEi82ggBUqaX7EDDwzjUmXbPng5gASatgVExd3/ChAKXfbO0Z3VS/8OioOFZ89Pk6vGSYq+OGp4dxbYWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56db1b3626bso7188316e0c.1
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 23:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777359526; x=1777964326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PF3j+sY6VDn/b3XG1Y7Z+9M+AzE58WOK8UHU23nNvI=;
        b=NWlEln0K6zXcitOdF+btVBGGr5lvaI+HkBx5rbsTkWiY6+19CIly6TIY7jVhmJE2Rm
         1wJHIh9KE0yHx/qoZAQzSHf+p5/N7DkWM+1ExnQpdVpPf9bnpU8Nbk08+jLxmtvl9UsG
         N2NSWq8UWYzfl6DNfflFlNN0BUoGrmN7naUpIyO1oqGoQfbZ6UFrefnlwZWpY4ahcZfS
         xhjMu3MonZikivFVu5r9oXx6norMWlqx08TNdcLLStHiGlTVGZfGr8MejCE5060R3dth
         W+5WSwBhxLbpgIWc3OffIjI8KbVwHB+onNvlVbQOA9Efs5MJGQq09e91xp91MFpdLZfB
         rW4g==
X-Forwarded-Encrypted: i=1; AFNElJ9X93fY+ZkCGPJvrLvLVzsNgZwhY9/oVxMiK+U2UHHevwfVTwgj/nxdggMUbwtX5IBPogQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzub/gY7cXynAHWenR3X5EmG4jNj2U5YcwIhNW7lNAUUzH1z6tO
	42jtsK3B4+4B4/jsdRkwHDgmXNgBf8LW2yonsQL+R8YFsMudpkTVqnkyiTSFiZiypJE=
X-Gm-Gg: AeBDiesBqBKAWVcRBfksGJHxxBmHDS1ID0VB+Fw+uXKjghUfn837FpWPh28zdb+ckC+
	2bfn9i8xl5Xx9Mu/MD9pAN/Zu6ZbIp/Sqp12ZRo5XEEdFt8wx+leaOryi5Ve5ulptZT2nvsRFNZ
	ygpU8PtJWT3F40/h8ySYc3/EesCNdximSeAV4Xad36Q3Chsqep2fzqr0qsydw5tely8FpGuaRTD
	SzzLMRgOdgvWsbCutNkBjZNWt2gDpUipw5k3etN3FrgWmjJX1Jz5jk+3Dj1eIUhNUcHTFnVUJFn
	xhgXxhfJHy81NnozeKy0Q3iKVXkFFipouLRBY980kdQnfLCMrmdqeI8BtQieEzvqBRMK7qbgN4s
	0TXhnjnRtxeUkxDaRDdC41E5QUEVK+FI1zS7y4Zvd6TkfXDkDRlhFJZevwIKEJlSVos+kpVSk4Q
	qYdGGf0y4tVyeAr6gy9LmvqCkgDwf5Foh/8aWcejkKwxmbr/f9e2Qffcv6KS46lT8Ni04tvQDWH
	h54cuRZwg==
X-Received: by 2002:a05:6122:311c:b0:56b:7d4d:4d11 with SMTP id 71dfb90a1353d-573a55155b5mr816031e0c.1.1777359525777;
        Mon, 27 Apr 2026 23:58:45 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573a433630fsm1075097e0c.2.2026.04.27.23.58.45
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 23:58:45 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-605a27fa8d5so6020773137.1
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 23:58:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+h9wbKubskjq22XFN6rf/lUFSqv4AyG3ql713eMP+xwrom1YWovmnnsZ6kqh9Wg7mBiig=@vger.kernel.org
X-Received: by 2002:a05:6102:950:b0:607:7991:8edd with SMTP id
 ada2fe7eead31-6280a8c5705mr640942137.19.1777359524824; Mon, 27 Apr 2026
 23:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427105810.23761-1-pbonzini@redhat.com>
In-Reply-To: <20260427105810.23761-1-pbonzini@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 08:58:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvehWeTwdN1czjvv7OjGsu_XaaYS1R6Tg557mDqP+fSg@mail.gmail.com>
X-Gm-Features: AVHnY4IUbWltZt4Nuljx-hPEgpXnbRcqSixeYk6RCQC_1EScDCPPRIuQFIAQkWQ
Message-ID: <CAMuHMdUvehWeTwdN1czjvv7OjGsu_XaaYS1R6Tg557mDqP+fSg@mail.gmail.com>
Subject: Re: [PATCH] mm_types: remove references to s390 gmap
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-m68k@lists.linux-m68k.org, "David Hildenbrand (Arm)" <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
> s390 does not anymore use special struct page for its shadow page tables.
> The honor of giving a special meaning to pt_index is now m68k's, so
> rename the fields and adjust them for the desired type.
>
> Cc: linux-mm@kvack.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: David Hildenbrand (Arm) <david@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

>  arch/m68k/mm/motorola.c  |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
