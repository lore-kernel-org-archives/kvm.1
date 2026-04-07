Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C92346E70
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595224; cv=pass; b=cjFp7lgKGKKKSarT7zDAdHgywzWkqVj9pBdr4FSPbL32HIeDt3ihfJxtbTL07yPF0sRFTKYxlFHbn6TUo6QDKhnxtymbaHk4u/UfWfFN04Qh0T28tH6rfNkDDlUk3gfjqCJLmwN+gQhtnJ6v9aS79783PRxJwI7Ghrhj7vVfPlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595224; c=relaxed/simple;
	bh=hAYL3ZhdW2F5eHwp+Hfkeql6tYPYXzmgecrqyASwpsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ld/4/INuA4R5Ip0g09n7WZVch4FNiDg3RCcvKi81Nyi6qImXpGnXBhi4HZJjOF7yrUxSqzSGjQrGdV/pblkWyLC5dLx4Yb+fjrQMFP44gmLSAEuq+bWei+ZHffHBtEr6WgcLJ772c+5dKQ8xx+41goigx5X59CCe7fY2gbnSgTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k4y/I/8V; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k4y/I/8V"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so3425a12.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 13:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775595222; cv=none;
        d=google.com; s=arc-20240605;
        b=il11v4i+slOVAEWud16hyIZBVLNkaq7uLa11XP4rG2G347zlFgR7b6d+G7MwXf2MLz
         gWzpWcv8haHyIoxnjVa02CcQYQgR0TZ4GbMcXJmUiOyDh7J4C/9gNCg2uhrfeyhPDaIp
         BQHIAIFmNbRyLlEjcSTLNTQiMzimoQadnDgZo1Ty0UT/LTOB+izJ/4iHPo2HwNTfw7il
         7gkKa7/AQJejzMHyFfIXkkQv8BYYsbXeOp9CrYgvevJmytA+tydV/adUAwOqkfZ3W9N+
         tmbYKpEfbwbtXUI2e0V0NLEHNPXVTbwvGRX2DZXe2Amm5pDZ/f4H1wmjqMYMBNqZadKx
         Ia3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hAYL3ZhdW2F5eHwp+Hfkeql6tYPYXzmgecrqyASwpsk=;
        fh=y/Ii4MZ9mQuNToBgdCgsu0oiatj1iCFnQQuzOrHzvEY=;
        b=BpTyP4wOnReK+GS79fXj6aJL3ntB4iNyVEcOaMd9iZKlNPctbnUnTvQw1zu/A35X9u
         58YWAo9n4K5W+uwY8JcHLxCGjizlBBQQ6jrRF0XVjUArM86fLzefRicSuxbV183TkIBQ
         VqIHWD3t/AWtamDAu9ZMezIiQZ5IyuH72UcqVKAUvzvZQVfii9qq+Q6lZ07lGg5oxlqQ
         Ekn6B29gDOOhAFq7p6B7d/5dR/og1wgi2R1r+gegjBLogA7djiXLnoNJlWTHl10a26cT
         0sQilfMuynds+CI/C+336O1eE1WPHF0Ii66HBIwkfRIPSKMRfu1Ca7IJ5E0P1e9Jo6ud
         KnJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775595222; x=1776200022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAYL3ZhdW2F5eHwp+Hfkeql6tYPYXzmgecrqyASwpsk=;
        b=k4y/I/8V5zgfQhXndP3mWx4YnmDYDu6ou/59VoGIYXXs2IBQ+h8CshdHAniJdJPXMN
         1w8q3lbA9SqF5FPPJFiAapFx5N+8JVxH1DET1hrLHy/B4rkJZqADEOClFmhk+vb6MWGm
         2+3k1enRL9AxIMsZsREEWQbUkeY4gzAVKz6p/aUlF0nUpZ0UNvnG+f56ak+9X8Ku5Z2i
         xEs69JLh9QMHFbg3VIWRzNRZlhQMtABwv+bbj3aSQWvE7Zjaaa9adHy7VKqhiKNYlgBo
         eE98y7Wr1O3tMHDhNHSk2XdvSdXrGfX/pDeUSo6u6gzWe60JN9fraaBwNYmUnrm1+Ilt
         lx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775595222; x=1776200022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hAYL3ZhdW2F5eHwp+Hfkeql6tYPYXzmgecrqyASwpsk=;
        b=tI78+YldkU6ObefLQtMMuNrJluOxd3o4eAFwt+8qw90r2RcybXMaGreNbk8PLEwq96
         Et0ji1wOAHz72DWkRCZ927vxHRfJVHZMSaUe528qWBzi0W7yH2Jgun6eDc8ZCvPylana
         n74zC4tCocN7Qwgb1kKtlJUSMHxdJn1qwxcPPvCbum5HQHAq5jslnlmaHbxtLlF3Qijz
         JP7zczyse/r2Gc5MeWoQV20lbKIRqmRvCXafNKTrQgvSAnQQpKP+qA3X9Q+pVNJ16oQv
         HUIQKST9kR59KDFEH/zZNU9xBJ8ue3OFSaeNhNJt2Maz6L5VA1TyxjQV7jVFIK5hSKUj
         +d/A==
X-Forwarded-Encrypted: i=1; AJvYcCX47EmfeiJk9At3Jt40MMkQO/qOJU+rSbtCwsPi/qgptGKnCLQrD/1S6TlAt2bbNrJbDj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5pG9iCXTbAzyWvvnBMnArlUDyu29IcdzXs3RrYFQSJ5PN02/
	FlzYUFsfBwifnimbRotRdN6Jfvomksngnbdhh4r6QCzeMjJpKmWd9N/o3cs8fL5afuOTBcx0C2x
	BbYabUBnfCMw7F7b0jNcMI9HyN9UXtNF64jtNrTa9
X-Gm-Gg: AeBDietOqoqjOB5/g6qmOLoP4t/1OIwggTDiu5SpBWPQ28Xj108GCwJZVxWXINq1bw7
	RGIwJYQcyF9IJsmWmh3uskv8lv5IASgidfCxjObwPkayjH1haspozDM/Nv8biuOu+RECd8jvCbx
	VdlEEG81y83LW+agecJD4xHW+ozmcI9Qa50buIUpySlLlOTALdJh+SSiLtWW+hW2DLl/9LpoT1t
	9DPyc7uOsD98VcBTfvS8rPSM4uzNbzY6Jm7Yvxfv14dZ6c860nhbKcePPPOldb5/0MWezTN9jVY
	r3Y2TJg=
X-Received: by 2002:a05:6402:5192:b0:66b:b6d8:c0f7 with SMTP id
 4fb4d7f45d1cf-66f9e8a747amr784a12.0.1775595221201; Tue, 07 Apr 2026 13:53:41
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403233329.fb2ppifgwm3um6ny@desk> <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk> <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk> <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
 <20260407171151.2gf2idjbmph35ypb@desk> <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
 <20260407191128.b2hr2ttkdpyunhrr@desk>
In-Reply-To: <20260407191128.b2hr2ttkdpyunhrr@desk>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Apr 2026 13:53:24 -0700
X-Gm-Features: AQROBzDTwGQS7R5PAsEU3h53Sr6ks4a8QPBLHblMF9o5FM5amaSGtHZz6ABr9Kk
Message-ID: <CALMp9eTK0o7Z7-oTB8ohvmoh-vy-Y2qjdUvbqD6HaEhOEPZmhw@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 12:11=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Tue, Apr 07, 2026 at 11:40:57AM -0700, Jim Mattson wrote:
> > My proposal is as follows:
> >
> > 1. The (advanced) hypervisor can advertise to the guest (via CPUID bit
> > or MSR bit) that the short BHB clearing sequence is adequate. This may
> > mean either that the VM will only be hosted on pre-Alder Lake hardware
> > or that the hypervisor will set BHI_DIS_S behind the back of the
> > guest. Presumably, this bit would not be reported if BHI_CTRL is
> > advertised to the guest.
> > 2. If the guest sees this bit, then it can use the short sequence. If
> > it doesn't see this bit, it must use the long sequence.
>
> Thats a good middle ground. Let me check with folks internally what they
> think about defining a new software-only bit.
>
> Third case, for a guest that doesn't want BHI_DIS_S, userspace should be
> allowed to override setting BHI_DIS_S. Then this proposed bit can indicat=
e
> that long sequence is required.

That case can be handled by the paravirtual mitigation MSRs, right?
