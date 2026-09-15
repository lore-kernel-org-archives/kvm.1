Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE05D4BA1D8
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488538; cv=none; b=Y8T1yBxFKmhTVUbjnTIduB7OLOgUG5z9Vryh9KT00y6WjfxHFaEGj+6KTzpQKIBKtnHx/rkAGfbt3xrPIxt9KGocK1ARFywjQSKzGun6a2zZiDobRAUvL98CmMkmRUOZpiCLL/mtuukYIKV7PirgkaQVel3CYca569E3QtL2LRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488538; c=relaxed/simple;
	bh=TaD3IKHcoZf0PQ+wUUh3mHvOgYZf6uXYuUZRFHNcE+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4E6I2Auj9j2ZMqD2FozpippRq7QXangzanATefiLayt+VxBtEqLynhko3MgAlzaf0VuxEyodKkIwDP9ISCLOFwkhGGSBdf5zFZ1RIY8OApD4fmIWnnFKXtkWkEM57yi5szGrgCQW0XYKZ9/IZE7vU6IkBPbQMBjxV7/YiQijPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DKPT1Y6M; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DKPT1Y6M"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a98604f6b4so5118362a12.2
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789488531; x=1790093331; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=DKPT1Y6M92md+bQyFQsx6CorRSMuXX8r2ZAhx8PuP2sk+j8hKNgc1gsrOZN3CzIifx
         63s+LWP2y6cRyR9RZg6B5wYeaddUIA/vY0smyLFOrSRvZsl3vXp5AlLrnrIHSV22ERgh
         pzoUu/wo9Y7lAt0B1Akktl1mBR+KR+NKyfSmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488531; x=1790093331;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=fY7jFbKFj5XVw7GDF054rkDrc0zwqaKAeAh/S4zfcMaADPHsNCkoPgMex8JuXN4MXH
         yiAkRatvmDh6hIDhEHw1C56Ps10koWAv3fGynU+5LyJB5aFvjpHVkq/KkZNVUYdzN3zq
         ocikTFf5tniEI/ETGHAx4jNGsQpFKz6pVommn0WtwB/8khtDnsXCxu7gDNCKfNYfgge3
         XiWNw7S+bmrPMAbeYwyWyW6AoUgKUi713SfSfwifzwyyl7WiSbPs4ff8BKTLR+gIlE6s
         BFCTPbneQFZTjUx+oeQK0i0pC2G0yU3NIdyGvcaelEvBJYhVO0leSzvIwkKSrCEqGHO9
         SdfA==
X-Forwarded-Encrypted: i=1; AKwUvByH5HntGgqqzknXiZ313qma1FAXfSeZb2n1DJ1C6vII6JKCfPazCozuEPAXPp09xfyvfqU=@vger.kernel.org
X-Gm-Message-State: AFuF++l+vzTJxageo50xeIlOU8UTg9PW8VDE9pVES5TnWQ+MbM7/t07n
	ThuYV7i15d74NN4EJk7Czi/vCzoTL/XQ4HQPkdx8Non4X9dnyCZbFUtiS1UEjyWopUuRdmCjLJK
	kFGdDfNE=
X-Gm-Gg: AYBFou0/5184SzMmY430pHFRTMUdXDHBRcUhVkmtSGBFIll5YJKWcs+eGNSWNkqlGOs
	Jv6zA7hEfDTYJrKreUEAI/QfeVR+ZI5dec43953wNWHcYPS7iXNRuF+r/NAs+VtXC0Bo7Ti3Kd7
	TM7hQMrIEcv6Q0v3dNdtcfphlXh2iXiNhb7QRcWulH3DuIFjC/hCO9s+EAMG5yzSPT/aRsp5YJa
	z1c5/jZowv6DkXLZS6NUbR+RgIWIVH9AQYO8vX/r+v7NhyfJ5BL+WfGi8Kd5UL1YWaIl2srEH28
	YV8fTD0zK2ZwBAVj5EfYsCXm6IXwD76GXPtdMTp/gwdiOWpEjbOvg2Z+/g7gn2OSQmMBW837B4F
	bIAoogkha70zrqXhWU7DY+NkGrjlRvyQzZwJL/PjFR42WHPThPJqMOBcAy1a9DIuCjFRCXm3iF8
	ENQX/41FhfQIbb40XRAGnz23AIftLh3T8wonok5NyIoa6rCovfWKb6W3EmTXWVrpjOgYaJI+XbW
	sVHNKdgK1JSBctZqd2t/g54kx+g/AqpKWA9DWBSH83VCaQs
X-Received: by 2002:a05:6402:21db:b0:6a7:ee55:dcce with SMTP id 4fb4d7f45d1cf-6a9f63d97admr4411852a12.29.1789488531022;
        Tue, 15 Sep 2026 09:08:51 -0700 (PDT)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com. [74.125.228.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b58f8528sm6150621a12.5.2026.09.15.09.08.50
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 09:08:50 -0700 (PDT)
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99cd5115bso5812758a12.3
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 09:08:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzkAWGc4ac31NDBga6Q+0wQTogb6sgbQWuaZpKLU3qH64XOeNYClSCWCczrSXxbhKk3pSk=@vger.kernel.org
X-Received: by 2002:a17:907:cd0d:b0:c29:439b:d5c1 with SMTP id
 a640c23a62f3a-c29b86141b9mr553591866b.16.1789488168046; Tue, 15 Sep 2026
 09:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:02:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
X-Gm-Features: AcwNN1WK06t9f9BcKFBIanysXcyUXK4eRICuH4x14s60AdlpF6ijCATIYaYAAvQ
Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
>
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

Honestly, I am *not* a fan. At all.

I think this adds complexity rather than removing it.

The diffstat tells a story:

>  106 files changed, 962 insertions(+), 861 deletions(-)

in how this adds a hundred lines more than it deletes.

But to make things worse, it adds them in bad places: low-level
architecture assembly code.

Those extra lines are *not* making complicated code simpler. Quite the
reverse. They are taking fairly straightforward "just deal with errors
with normal cleanup in the place where it makes sense" and makes the
*straightforward* case simpler, while making the big picture more
complicated and subtle, and adding new code to places that are not
simple and just blindly do somethign that makes no sense in that
context.

IOW: it's more code, and it's more abstraction, and it DOES NOT HELP.

And yes, most of the well-maintained modern platforms (read: x86 and
arm64) use the generic infrastructure and they don't show that
low-level asm effect. So for those cases, it's mainly just  that added
conceptual complexity and a new odd rule - and makes a *successful*
system call go through that "extra work" and indirection phase that it
didn't use to go through.

So it just spreads out the work, and moves it to a less obvious place.

All for the very questionable advantage that you can now randomly add
a file descriptor without the few lines of fairly straightforward
rollback.

IOW, I do not see a single real upside to this, and I see immediate
downsides to it, and a more abstract complicated machinery.

I do *not* see why we woudl want to make this be a "every system call
exit" kind of thing. If there are places that think it's complicated
to do, they could have *their* local little stack of fd's pending. Why
force it onto the low-level system call entry for every system call
when there are only a small handful of actual real cases (the vfs
itself, and random ioctl's by odd driver subsystems).

              Linus
