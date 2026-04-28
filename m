Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D873A63FB
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369453; cv=none; b=aHTIuf7pseaXiZfn95ul9ZUiscALH93JMyyzIoEatAgz7r196sA3XPs9V0L3o0lLxmrdsomlhR1Tmk91QRN5Cryxmnw9pWB8TFTpVs/Q9RuN4tfcGkY+jwkYpARB1/hV3xyWeSA36uEGSEKwYGTli+ZMf7pmc9F3m//d7zRb1B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369453; c=relaxed/simple;
	bh=5p8/l8hxy6UGncfbmqpvMFhiayusbzRLWCQfCfD++YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCGo1DxxjjTInH+kABjhWb1+ETSqdEqPao2Rt8LLY3fgcLVuw9bL2UD+uLb4wfTwIVem90bE+hdw8wOHuDnAai7eWOuW7pFgfl2trCLaTsMa82UZC9RTGq+b01XOiSw/uJwQVdqXN+ch0B1he5x5AKTta5hMO0z4qXNl496SkHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ba545100a13so1283681166b.2
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 02:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777369451; x=1777974251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nWrICmexI+A6dB2ZQxQugwwArdZmj01ZZbEQAQDplTY=;
        b=a17vJmGSZPcXbevCPSHru4BqLB+jVLtQk55Puu+TdFRyskTh/U9mUqD7ATdd78EQ20
         2yrGZtmZeeMsSQxeCErVcHCg4zrMrG/gJKk4aEiifo2i4oF9rVkZmHUjbh8InXXV0GnC
         debmikiB6WMfkwfrCN0ChGn/Px05oemFB+MtWuGxEBALMHeqZsw0RDY7lilctFh7etM/
         XtKSZFlQGvvWtccIlI3MFzHzG+TeoaJgFgsKTSb9ancPCFm6JUWuzgszQS/qcGW1A1eQ
         1nUzUhlivRZmuiGZuOw6ucljko+5+3r7+2prsXj8ILUdXlR7xQ+UWtcB7r383GN3cXE1
         b3sQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IoXLVgQCVDL+s/5xLfgJBVsGNgxgiJBW4BrprDzP1jB9xblPHnXGTrj1VARIZooujnHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+QjdzCOA7/TjRFuPc84KPhqYUa03B98m1kRyQf3FJc7+JDTZ
	dJ820OOISrV8D4JlNvHyDskMmiEZiPjjcL/YOqYwP59O701z0XyP2zyCarA8Cke030E=
X-Gm-Gg: AeBDieuYGhjTytqxe8C7ikIX2Je/h6Vme1VmGi396YODPofL5MfiGSXfH5XOdC3k3Xr
	8Ct/UX4zbcZj6tDIgGeEyfrFQjd1bvnEpS/NCFXeoYksSmOzJs3OvvnVzweRG3l5kam3r7WBih9
	hIr8DUfua3R2oDVlvpFujNP/iuvi+MmdeFQZ9M8DKZGM5m36nVNOHlVA7DX1eRBnlEuD56Rm3Un
	3Bzma4sO2zwUtHqQoaOl0q05xlH7o3/lPOzO83ZVLSqyTQ8idw7BCzMfY9F824M6qLTcHz2KtlW
	fujSMKZShD/1QytJDEV6XpKfxG6ZeNRDCTCAzIS4s6gQDDjNxhVcZcv5h4qrqj8n+lmS++nO9fK
	OgVlyoMlxcG040D6VZKtOKhxvg6K+Tu2Q4WN25uqHlWmH7CY7BzYNPY/sRF6l5Qxh58qylsbkdi
	/pUP/MQZoqsh7SpCYbY23y5w0g5azcgKWaAmiNUuewG3dbxc/aZ+TOV4EsdUZzYSRiOq4TqMw=
X-Received: by 2002:a17:906:c105:b0:bab:c646:dc7c with SMTP id a640c23a62f3a-bb803e63664mr149910366b.34.1777369450513;
        Tue, 28 Apr 2026 02:44:10 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b67d5ffesm564707a12.9.2026.04.28.02.44.09
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:44:09 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66b2d49ffb0so14186978a12.3
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 02:44:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/aGTFVDcbdziqVheBKwCGzUZPEGMEES/NfTlirnfldn/IDXTIZe8X1OJo5v7MG3wErPgA=@vger.kernel.org
X-Received: by 2002:a17:907:c80d:b0:ba7:9857:2fa9 with SMTP id
 a640c23a62f3a-bb801ad7348mr148812966b.14.1777369449228; Tue, 28 Apr 2026
 02:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427105810.23761-1-pbonzini@redhat.com> <CAMuHMdUvehWeTwdN1czjvv7OjGsu_XaaYS1R6Tg557mDqP+fSg@mail.gmail.com>
 <CABgObfa+2ERN1TmVeeWxCQKzra_OThkgkVkBGgDfu5yOsjOH1A@mail.gmail.com>
In-Reply-To: <CABgObfa+2ERN1TmVeeWxCQKzra_OThkgkVkBGgDfu5yOsjOH1A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:43:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXrt4khjgV41Qt2kDWR3RfMXvOgghi83ovyMnEqJFNU6w@mail.gmail.com>
X-Gm-Features: AVHnY4J_GAQdlnmtDpgrREfPjFiZlxFdEnKGHr11C0hlHFvtBM-VdB5gtX4hf-E
Message-ID: <CAMuHMdXrt4khjgV41Qt2kDWR3RfMXvOgghi83ovyMnEqJFNU6w@mail.gmail.com>
Subject: Re: [PATCH] mm_types: remove references to s390 gmap
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-m68k@lists.linux-m68k.org, "David Hildenbrand (Arm)" <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Tue, 28 Apr 2026 at 11:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On Tue, Apr 28, 2026 at 8:58=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Mon, 27 Apr 2026 at 12:58, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> > > s390 does not anymore use special struct page for its shadow page tab=
les.
> > > The honor of giving a special meaning to pt_index is now m68k's, so
> > > rename the fields and adjust them for the desired type.
> > >
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-m68k@lists.linux-m68k.org
> > > Cc: David Hildenbrand (Arm) <david@kernel.org>
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >
> > >  arch/m68k/mm/motorola.c  |  2 +-
> >
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
>
> Thanks, do you expect it to go through the mm tree or are you taking
> it yourself?

I assumed the mm tree.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
