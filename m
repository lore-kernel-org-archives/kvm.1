Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4723449B34
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499793; cv=none; b=TVhX5mmMfeya9PGnS3TRoEPSsfaw4qnBBvgSlyZp89zAN9qTKW1nw1t1ploVlCVy8oH1G6U1nUplRiocRAdtXguX1lh37r0smq3384Fd+W+m4QXiIRMj6+DVQMkuYlYf9tdX7w5hOeg0cUW90cB5uAvxDYGL6pj1TcP0FjdC5Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499793; c=relaxed/simple;
	bh=AGk4y8oFpNibhByHKIxcRS7KnQx6z20Q8VC6dFl1tNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHZSGgYi0cIjkuvq6FzEkEytFBY9dWrG3DhZze0txL51+Pek86K9Oz4kSC9ss1aC/WBHJs+DGgaKt9ATYuezkdSytmV4ceiMBoqp9JG4i5h+4R6qBNGW0x+txD50SURCZU4c4IhW2i2h/MutOZLCNNUZAs2j0T7igVIomBzPikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A8yXWcS3; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A8yXWcS3"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b74e0c2e4dso143706e87.0
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789499785; x=1790104585; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=A8yXWcS34sIoDVeMWumeHNqhFc2mpOsZMnirvIv6V4VTu6yvpxQS6BtZWm3bpbfnkH
         1Z8eG7/9XNyjMsCDT1cOlnj3l6PWBbxLLivJR4SChhhyZG4LwqmwVSzm6xyiwN5YRYzS
         66OUKt3BXFIUp3h8f2DpfTO0PwuUXAYbjSMJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499785; x=1790104585;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=NI4fu+pflzQSlOhRIk59GBD/0UlQCv0K+nWHtVtPzsrrhEDk5cmMVOIuQLFHdVugTj
         ME+dmoYR30DU9+iHVjNppeAuHNrTF9jcC2s9LCjz9mznbJlQw8Ag+VO/DpkeBEsNn0gA
         XmwEDwnLVCtLMKVo8UhfVYBcj4jWtFf2xodbvjIdNqjrREeGBba+Uiom4EegFPfBlScg
         wXKNV2HIpQZSNHMPdda7a2bnZU9CBEm0bbCuNGdpUUKVLKmXSRHHuf1ifkZ2JxtxhRFw
         fQFKAMu24/rEklBKldynLs8BU0pBpHjqGia7/a9ecAWcJQLey1LWG7TQjIhp30GyaFjv
         wG1g==
X-Forwarded-Encrypted: i=1; AKwUvBzDKHarmT00u5GTaick2CiwbT+2hTReiJU5SR0gyR7I+KAGE7AuwZ+MhKAPrZNQ2Tmn/qo=@vger.kernel.org
X-Gm-Message-State: AFuF++mLEL5vQQQ5espACdsJbhOFNPCAmPGC/qdJszV088/5at/iva+A
	8boPJmtR9dpgOtlM0aXzssJiMS1PTWVhmoK4gboQTz/iu2xnbI/p1L9usvKw2WCQcWf0mljfSYU
	RKZuMqyAsSapS
X-Gm-Gg: AYBFou27wyjtZnSq0qUrPQxv93ZgFVVBB3Ztrtc+RRF+Ok3sS1i7vx/8LDp2P3dBDxd
	gwaD5/ljzbi+YKpuKk53QScn+6aG4JzbX/fjbhcbzJHabdL3Ad48Yrb7sv/XBmt3xECmIoekAf9
	QX59kTktHji+SgVN0b50Hk/1xNxX+JMCcrPa28S0IBb2kK+JmE2hDpxsxnevlMYVGn2GrZ22duZ
	Njx+G3axzX+XSncSNBoOOCF0FvZFaCfCS6bn5PgvudBnaEf6f+0P0pRui7FgumA27bsxLYH+uTl
	7f4XHCiFR3YP+QVLP0WM18Nv32em+zgIBH6G7dUIzzaEdHKH9aB4AAG0TsR1hKEA7RzoM75KCGr
	8WYnlLh+paaUaD72P9KDPR4illyLE7uqPIt9y5bVYSwrhhy8aKVSURZHOcnW5+aLqLWWCbJ6iil
	8Iy1p4+mF8T0DlzcZw9dDJHY2EYgjeDpgEJDttG1A2iwwFghBMCWzYmRYRv6izWdSpENvuhLDZA
	Y4rcpvFekSrooXn5Zv4kdOlADIGDkPdhFb8F3o4jRn/jrpInZmzX767M/fu
X-Received: by 2002:a05:6512:32c5:b0:5b1:5ab5:ea09 with SMTP id 2adb3069b0e04-5b8ae63580bmr4776535e87.0.1789499785254;
        Tue, 15 Sep 2026 12:16:25 -0700 (PDT)
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com. [74.125.229.204])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57e017bsm171942e87.57.2026.09.15.12.16.25
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 12:16:25 -0700 (PDT)
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b74e0c2e4dso143694e87.0
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 12:16:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxBKSG08XchfhJa6cEGikq4mtVUQdULnxMcfmpCqtO/NsUuEUBinOtV4iBAOAHxRoWcPSo=@vger.kernel.org
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c29b839a057mr1176039766b.2.1789499355710; Tue, 15 Sep 2026
 12:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
In-Reply-To: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 12:08:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Gm-Features: AcwNN1VCm0LMG7z3Jned014oJh6WBcf4uOx0OBk98_hrtHKbrhcQiMMJ_A-fmB0
Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
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

On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
>
> Is this mainly about stuff like "we installed a file descriptor and
> then the following put_user() failed"? Because if so, I think a nicer
> fix would be to have a policy of "if userspace provides unwritable
> memory to a syscall, just keep going and pretend the access worked",
> and maybe have a sysctl that kills the process when this happens to
> emphasize that userspace should not be doing this.

We've done that before, where we just ignore put_user() errors and the
user gets whatever the user gets.

It is maybe not optimal, but it's fine. You can find quite a lot of
unchecked put_user() calls with a pattern like

        git grep '^[[:space:]]*put_user(.*);'

and some of them are in core code - see the two in kernel/fork.c, for example.

One of them says "if userspace has not set up a proper pointer then
tough luck". The other one doesn't even bother with a comment.

The scheduler has two cases too, although one of them is admittedly
for another error case.

So yes, saying "if you pass bogus arguments, you get what you get" is
a valid model. It's perhaps not the *preferred* model, but it's not
wrong.

It *would* be wrong to take code that already has error handling and
remove the error handling, though.

                  Linus
