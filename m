Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827D44E5349
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610097; cv=none; b=Y+tAyKf0Mkx+MtD/NJmpNgwu41llMSnt2S23kR4qPrcHZ/Yp/N/ebMALAwtnPfspK2iQwxT9y2r2kTOVPQRkUMDl5KDNsoXuFNVQjlimFU+U18uWXgnvD50kqfUYikW7Lh2+rocqkPoMw7WPqotEFR/qdZvi0pmTykk0M/cmaUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610097; c=relaxed/simple;
	bh=9Msw6I067+6iBsgwsr/Bt4ePiirOGUBNmkcsMmUbeO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ki2oNC7Jjt/+A5qRre1iEZ7QRv6QIGk/sy1d8sLtKK9scRXLrjBTn/xyj/fZTWNPYcgZFzLmHKhHORkhgBMdllxHBj96WXbcOUpvgFABNMnqruLXVijB7PXTvTZ8Olks0c7tZJpIZRLRlzvzvZQFLgRprBmRdA2Fy+WThb7fYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJo6vSKr; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJo6vSKr"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc489e7a701so3899698a12.2
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790610096; x=1791214896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vK0Krog7rzU4pR4Isc7XjCheGIHMrcN1uvJXgDIv7WA=;
        b=UJo6vSKrdb1FJJmAC5rwm2jy7fh5IGeHhMa36zwuacU/6z2+ufQhkslHMue57nkQMD
         oskhJF+Q9a8/+Vfetl2OlnyDeoTtllz7n3aER8GpcZRG7qgg7IAnUwWUB21Xc44Avdui
         xVhjS7OXwiqJn14gn/C67rQ7ZfKINQjlvlUmeqZgXJvoL4smzR8rImsCadLq14q3o1WK
         ZtwTICgXPU13Q2b80JcoMJbUiAzDtf93Yc1SXdaZ+t49vFqg9uJicghzDiSjKSfDn8xl
         QAin0+mbMBr+DTIc/E7e+gzPPcjGKJM31lxfrqFOQTMqA1rVUh0a0B5Siy080/mBuYbF
         ZLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610096; x=1791214896;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vK0Krog7rzU4pR4Isc7XjCheGIHMrcN1uvJXgDIv7WA=;
        b=dwjgfOk0xvxbR2tCPhJQ023KmEXNV7jBpy6PRdzvJAAjYqTw2o0pfurm+HvU1aJ4u3
         Q6xUeofnCEweDd10rkM4ZfDHfPtSSFsq6NcIglK6jTomkDtEwZRdARtbSoKNkxCjekOE
         769biLa3QSl43ZJe9izDdZxSmimrCtl6xMEf+ON4uxExkqQM0YmeVFSpaqBjjLpAPLTi
         dmMcVizkDIQIT+o1Sbx1+nd0UMepweFSvycZF57GusuDntkyfZc52MocnzznMzqpO1bI
         uxKwcNe22IBFC9XIWNrfGQNeE/C6PSql5wEVtfs5IgnK1mBGW0ug9vO2tuhyHluq6qdP
         HnWw==
X-Gm-Message-State: AFuF++mZOYox1m/A7+6nHW8alfFUACa/p5qpknJCjkkjHpq6y+/c3P18
	knRPQbpwvwaql9+AAiTKZhAzVOwAHlAjnnJ/RXNWu/mIya8218JSkfWeHGaS9jzfMBtErGlggKm
	5xVV6bg==
X-Received: from pgbbm24.prod.google.com ([2002:a65:6e98:0:b0:cc7:85ef:361e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d48b:b0:3dd:85a8:cb7f
 with SMTP id adf61e73a8af0-3de0e8a05bamr11668505637.34.1790610095566; Mon, 28
 Sep 2026 08:41:35 -0700 (PDT)
Date: Mon, 28 Sep 2026 08:41:34 -0700
In-Reply-To: <CABgObfZeA_q_prxJhbdNqYpE8quPD360LhVBQv8ypcPpLA-Mhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260925233321.2381319-1-seanjc@google.com> <CABgObfZeA_q_prxJhbdNqYpE8quPD360LhVBQv8ypcPpLA-Mhg@mail.gmail.com>
Message-ID: <arqKrvYupBpAM2WI@google.com>
Subject: Re: [GIT PULL] KVM: Fixes for 7.3-rcN
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026, Paolo Bonzini wrote:
> On Sat, Sep 26, 2026 at 1:33=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Please pull a variety of fixes.  Nothing is super urgent, but all of th=
ese can
> > be fatal to the host and/or guest (except for the selftest change, whic=
h fixes
> > a regression that was introduced in 7.3).
> >
> > The following changes since commit d599822bdb66aeec5ec76297b0fc6efaaeef=
e07c:
> >
> >   Merge tag 'kvm-s390-master-7.3-1' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/kvms390/linux into HEAD (2026-09-04 17:34:28 +0200)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-7.3-rc5
> >
> > for you to fetch changes up to 119e9db233ad0f4cbd4cfb9f9385a7bca378b37d=
:
> >
> >   KVM: Don't pre-reserve xarray entries when storing empty/NULL attribu=
tes (2026-09-22 08:36:16 -0700)
>=20
> Pulled, thanks. I added on top the SEV cache writeback patches which
> are not present here.

Heh, because they're buggy.  Sashiko pointed out flaws in both[1][2].  I ha=
ve
fixes (will send them shortly); I was late on posting v2 because it took me=
 forever
to figure out a not-awful solution for the double-free issue due to the ann=
oying
CONFIG_CPUMASK_OFFSTACK behavior.

[1] https://lore.kernel.org/all/20260923165304.1662E1F000FF@smtp.kernel.org
[2] https://lore.kernel.org/all/20260923165349.CAAF01F000FF@smtp.kernel.org
