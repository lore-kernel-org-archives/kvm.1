Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909E1ABED9
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776733213; cv=none; b=lvFQAdL5ZY9qCqB0Gvisv4YUmU+8J76vuzNiH6CzBh2mmTuZileB0gts5hHOU81YP/h6rfr1Iti8rlOIMB/0eeMMhTM55A6ypfCKZRRs+I3vGgg9nLOzBOK/feoR4BtuqGzHYleGhX/R1lZNBo6CWMjJgaXK+TCC1pNRGMomvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776733213; c=relaxed/simple;
	bh=oEO30ztsKctOLpdL2XX3wkBEOzL67NuYyrKqT5J7ndE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Boc5XnB+ZNBMFh05wegOFJkj/akigml5lR4Y+AeZuIwTUzvpNduaOO+/hhKc0rqMsr6oc+ElwQgp5ibeOMycKvzJaVgqodqPpKsUfCYbleK0GHzX7ghb4hh/kUjuKRGJqlme9js96Te2Z6SVCooac1MQ801xVyUoBVDLvzaY8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fxEWc35x; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fxEWc35x"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b941762394aso501732266b.1
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 18:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776733210; x=1777338010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qWBYQ89FTEMomqqaF2jg/32rMwRugYJ3XxL02PXajCs=;
        b=fxEWc35x76b7U6MWTTduEdmxyY+JFsUQI0ma5f9a8T5hPqGQlc68NvA/sF98D1EO8A
         DSFcLk+w7YLU7MEbf0eBT10yrPuSjRjhh8vSHNRpQeXQWVKTDBk8W91tUzAGlLkhyh1r
         9OVCcxcLpLTaC9yJHcG3deIBOoerLJr0nMF6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776733210; x=1777338010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWBYQ89FTEMomqqaF2jg/32rMwRugYJ3XxL02PXajCs=;
        b=l+RkxsFzew3VY4W4oVbSEi65+TSlud3Q+zKRIF9HEoWNEnmpQ8ao65CGZR/QIl4fOk
         nK3ulFde0J7a8mJkkI8MqFc4TtKw6OS0Fo0c3Y9da2WBvtISeCA52a0s3GZF3XYgSsd4
         1AAQyL9HKXHwq6N+aHGh+9dB2RmsXkYTYxHbmExSTlgiNCKyfkDa46SPigsW/sSvPcoz
         oVttg7J17H5ZaiTZr2G9LbJkRirH0mkBIijeGEytMr7njQYDXyy2BlGyotpUbK63nH52
         8q5BaOccRPCoPcdm0jSdHXoDZWroVLW510w2/Lm70hep+apwP4J0vBUW14HpHLOs7smq
         CTTg==
X-Forwarded-Encrypted: i=1; AFNElJ/NaljRPcKjllmXwNlf2tKHoNi6ak3M3yIzAhrELG/JsNWSr5s7s97iICx9sfvsNuwIYR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGw7qGGrFiaEAsOJK3Uos2XLxOaspZc9Tn6XkAiIgQ30MKKNbJ
	Nk+V0sWBHzuL7Qj0bW132y/SVDBOFRIGE0aj1dYQFZejjw84Oy2/2CsLF2xsPKPhFFNcmCAsXqn
	zu3NgBYU=
X-Gm-Gg: AeBDieubPQvEWJkzzDOECXnDZkd+cqinLv6dQB7Aes5Wh+VZskMeqd2ADjAvqwlZAzk
	Mh3fQa6JDd49tYQKDB2FSKnJa+zfI0+m+8SzbtvnRbDik8vWnEZoeKPHQsjm8C+cRYXowv6KkKb
	/7tVVW5LfgnD88aXn5Q8lDs1sSvT0cg+8ay1JnrG4t0WpL2uxMhilaD24QIFaPhoBROlI4I53uw
	B/nKv6iajDFyKpfx3ufMryz+fJ3dWuuADF4k6/tX+0jCywSMDsPP9Y/olK+xKHOUObNVbVtatG/
	5cLKSbyVXosjndWp25Z0Rgbw5/dUDrZBXihlX1elxj8ezUY56TWev3fC+eINkR31byhCz+1Ssh5
	UNnqyvtvRO7YGUIFRRB20XldAKyU40zo6BDAIzNISpPBW7zP09CsBYNJCjDl7JR4yvUf+fs+Quz
	vgFehKwohWwbZzkBuHcbMfMBIIhYimTGXLDx/pliTj0D8fMvYs7qH2jdp2WzfGo6QgZ3VCpX5mL
	CgrN0J/rwQ=
X-Received: by 2002:a17:907:c1f:b0:ba5:85fb:d0de with SMTP id a640c23a62f3a-ba585fc891amr622282166b.3.1776733210392;
        Mon, 20 Apr 2026 18:00:10 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455539817sm392620966b.56.2026.04.20.18.00.09
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 18:00:09 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-671c5eb7fb0so4601359a12.3
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 18:00:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9JG5Sye0w1IUIF0geeprss+E6WLdiCve7lHSxoEUwQn6Rksvg2w4JHJu3lg2uEZPcyCxk=@vger.kernel.org
X-Received: by 2002:a05:6402:e8d:b0:673:b696:8900 with SMTP id
 4fb4d7f45d1cf-673b6968c94mr5598250a12.18.1776733208743; Mon, 20 Apr 2026
 18:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416164526.171467-1-pbonzini@redhat.com>
In-Reply-To: <20260416164526.171467-1-pbonzini@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Apr 2026 17:59:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieqGd_XKpu8UxDoyADZx8TDe8CF3RmkUXt5N_9t5Pf_w@mail.gmail.com>
X-Gm-Features: AQROBzA32fSh-WmTALz2whADr05HsYe0SdR-giW99LJOENiaR6qExBbtUy6nkCU
Message-ID: <CAHk-=wieqGd_XKpu8UxDoyADZx8TDe8CF3RmkUXt5N_9t5Pf_w@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for Linux 7.1
To: Paolo Bonzini <pbonzini@redhat.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>, 
	Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Apr 2026 at 09:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>   https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

Bah. Having been busy just merging, I didn't notice until now that
this pull caused the kernel build to leave a strange turd in the
filesystem that "git status" then complains about.

I fixed the git complaint the obvious way - by just adding a
.gitignore file for this - but honestly, that code is just *silly*.

The code to autogenerate that file in the Makefile is LARGER THAN THE
FILE ITSELF.

That's not "autogenerated" content. That's just pointless. Having a
makefile rule that just uses "echo" to create the file is pointless
indirection - when you could just have added the file, and doing so
would have made not only the build system saner, it would make it much
easier to edit it if/when new situations arrive.

This needs cleaning up.

           Linus
