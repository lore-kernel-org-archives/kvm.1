Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7A5376BD9
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327143; cv=none; b=F5w8RLnvYHzZBcUT7MTNp0CTByR52dgubSIAIyA17pYfOKeo74oTiecMvdp6Ypmmd8RNIVCCc75EjYL+IoeVu7PVR4snDMGLjzE39hhTjFNeb8U0Jr+OkvImnz2OD2moRmYs0tGFrCb+2MlhFneUJRJGPix/f/CtmKziqEjr+X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327143; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYtTr8J9xHwjX4JGoiCFegheVya9LkrAms2AtSFEkgmzIJb1Fx1ahZuOgbHtoUMkTS6FyIrCQr/lBc3eYHbCjzq5bdUYvLxJA2NYhFpoz8LrduUcDZhv7OWiJ00ND9A5JQO9TT/2jdtJu8g4s1gyBMGVVAU2SH4lhoBLkzO93Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cPXvEqui; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cPXvEqui"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66e8cf72a93so13206164a12.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 14:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777327140; x=1777931940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=cPXvEqui1T5bcJBjOnq8O09mIfqgqJtluZSeRrLVD23pb8MObPAxPWG/74F+bTQeS4
         ysxwAdGdyQBOC02ftjbj5neBqRvOkc+ySQt5i6oUKOQu4vU3JW8eqVzjJioJ5V4BpcFc
         mXS7/N1sVylrj83SnLW9Xv25W/UOb8tptsp1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327140; x=1777931940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=KLuHtDDHlWUle8gK16EsL2m+AkdQVID+vAA3Zkd+ZnfF3z/d6PHys8MYX7u8UrR/vK
         wg1m7UyUdtwXemPZg8t5hRAhLvrJnMZ8Sr3EvCfe7eS82RHWtaXtTRMCGGqEbiXY0z3E
         NrPHvndjbpOTrT3WY0/8Rsc7X5kco7IbT8ihAR3SGv42pNUTXuT9XPeh8RlmVGWXKnJe
         7VEQ9RrhD4kzYDFvIQXTkUgujGzdHiH0baw3Yr+Kqozw2Uipi8rQ6QCdlLf+AqPvaucI
         qaRXIx771E2vY9xaO3q5TPtltQ5syAUKMfGCtb9SvjTd0o5KBlPNmG2Rj5rVFi+hd1av
         clYA==
X-Forwarded-Encrypted: i=1; AFNElJ8H5kVt2LsnmIZjPD3Mj9lkoIBIeZSQlXdwQZ9itbrwP5Ys4WxThUJ8eE4YSY7w2+HvDoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMUrsczY/6unMdvPPOG2keyuq9ycUrJNX3z/N24AwalC/HHkc
	W9XKchNG4TDNjnary54Q5tRIq3Rb4IxwvRw9sKgP+ygvV9nuRtRmYbLqjWteUPx0R8xAjxQVEzD
	2VzsQvDHZZg==
X-Gm-Gg: AeBDiesxRClMTYIpVBYDtrwx0pdGYBUrovGD5HyXjCW3+4EF7TZM3cJQIvtF3GGYDMQ
	L1U3HT67FkXrsZlWgD/d+AwePfhjnGqFOHFwpZZsHd345iVVvCehuLXBbCeWt3Gs7NSLPnlFJwn
	c3ltF99gNSLkBD2Dj/nKoHt6Jc0Hr2WD41p9eAttwJ7M0jiZzim2YBjQSQjN39OzuJHJl6KYlJC
	lKef33BDyYhPJQPGSQkbOYsdkj+GXfHv3Qm+nQQKP0EdEP4NDikzreO4tHODZphdPNqn47Sv5HT
	Qzd4dnQwr6ex2CdoUgJ5S3jn43REsZUZSDFmxuxCf8Qu5eolgkSRTc4cTCZZ0d0XvPXd3umJZGd
	/5HyELMZ2/tinkds84Xi8UT+n68bWQ+RnIYO0+//hHPIsUv1+k9MGT5KX5BINw5FM+EskBZj7Fr
	Sx6sQcx8tZs0/tgOcZ3Zv6ddYbm46c64/tupy+/WVep7rW9kg++noRQfjOwbORpO4jsoMRZE11b
	E43JhiE8R0hNSs5lJgTBg==
X-Received: by 2002:a05:6402:505b:b0:671:dad8:80d6 with SMTP id 4fb4d7f45d1cf-679bb04a831mr152644a12.6.1777327140197;
        Mon, 27 Apr 2026 14:59:00 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b67ccd49sm147773a12.6.2026.04.27.14.59.00
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:59:00 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-677f7c29af6so9399088a12.2
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 14:59:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/4FJlWuEQIo6mghbqJpNOuDwSdBETSjAxG31YyR1CbmVJRU9AUmfn7n8HT3RgJkgOVqzM=@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus
