Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA743822AC
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368341; cv=none; b=n1pwu1Kv1NH9VoUghDjFFYUZqsLVXEAtCzOKRZ+pE0ccfB8LvX/21xL0jyGqEaF9jbVWQp/TY625rKoLIXfxjaVLCzixxUOsRFrzjdcSL+N+Yjjel73/9sgw5La/xEewgDjH4BwvRkpcph/FBKShs6+2ayLdCPuWM95RVxMOb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368341; c=relaxed/simple;
	bh=WZ0dv++aH+AeLwkvbNXxLqu7wJ3mA6GpS63WG1N27Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U461UO6dJ7gqNBzGzI8heLmpDmmGY8z5WUM/oLN1c221aIocMerZvDT1F5D6ll/oduXZDPmOUKmIYjqU5+HKdElK2qRH5SfcAJO+Vi/MAbqQWYMh8yqfumRvT9mwBOO7eV3hFspSTPtiTfFJGMf7seBYc3g5xO6YOutLBqwAeJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-678a526f374so7365230a12.0
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 02:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368329; x=1777973129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=EAdUPn83IMdvfvI6JZX4wAgRKlvzzNC5kUwf9xUNpvyvbZcBWW0nNBdD/AgiIZGxBT
         0Um3j7npkIrWQWMUVr6mkkw8IPDqk8EFcAG6feq4jo4Gs6YDEqk5IOfSf1PRAVv/ag2R
         ok3m0zY5qLeWHRIB+PrWtMb0KdQdnvc77RmDMw5hNqQHqv8edb1PHnWGjsmtdFRGzIG1
         8Avoez7yUWC4JTT+tnWMLJR4Ar46oQaZJ796lHc24UBPRmxhJJfkuoJBx6kCxEVkIloa
         mvtkh7JqCoE1Ts1wGOHJNVNY8B62tu0rPCDrVIcq6gP6uR/nsnnSAbHGyoZeelYB/Hp7
         LOOg==
X-Forwarded-Encrypted: i=1; AFNElJ96YlXo3Chpmqas+WRJzdQh6UV2in83wux9e0CQnrDdAYMGpP1pcI4kwOkJ/n2GTuOFJzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/2bQr48zbfz/TpIQodOlXqV1HzdPPG21/WUUoxdISCYSb5sc
	HAr3sQnLVJOc3ArSUxv4FqlypA3xrw37Sh9OkqzZQma7jRh4xX/fGEVDcZ8v4takjis=
X-Gm-Gg: AeBDietO+i70OukiDD2BTEgvliFQ3DPxFmLrls7LQ/rMNRIVuXQdc7MQB2hmLPsw7Gl
	8sXi6gAxzAmh8hWnEfwMePLThTok9hF/drek7jvgWxYZwktLz/WnPaoAlF3l0PCQ30cSt5v7uoY
	Ehahnmd4+0xS1MvsKvGCiH9CcSaNyy0TgMaMioe1woGrt1R97iHrg338QE3WFdaHBgLeG7zzfxf
	k4+VXZXweOQZwjPSs4d2FYI6jA4TZKtzBm2ZobySTg/eyUZjQ1chs6fsMCJZn4ubLGQtnLasJZA
	wGek05i/8w+r8WQH3EaIZyBvyvly4MIF0YiJMbHVacSpN/rfoGn0spRGWaem0KwKOjhNooijv47
	f1CE2vbLyeRZbzwjAiYdZq3ug5tyg/yP6EfCJ0Yi4YWV3yCflftrOXQluYifeoOTOTXY2ogQ7nU
	T3P6UYc8fwe6Vi5DN87pj9V1heqvo5Z5Tmx5+rY7na+dT2wuAQYIkramZqAJ5NgtyoMiw7q+Y=
X-Received: by 2002:a05:6402:26cc:b0:674:bbc4:be21 with SMTP id 4fb4d7f45d1cf-679bb0625e3mr1120329a12.10.1777368328716;
        Tue, 28 Apr 2026 02:25:28 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b68430a9sm501031a12.15.2026.04.28.02.25.24
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:25:27 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-678a526f374so7365045a12.0
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 02:25:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9v/nYSGlaTUzfR+fJfCdNd8Ji9ahAjPPP+5BAewJwbZf4sPZ/vTfN6yfDYdyuzsmQIt0k=@vger.kernel.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
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

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
