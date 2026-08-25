Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777331D39A
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673608; cv=pass; b=OSCbGEgGftFCYZhsXT8HYOqwy0pIfNets0RxFiXZd3H2VDqT7wDmFFCsasBp5IUw/X+kBHZVOtFmum+R/KxDltP6gMxuPcMIc4MlhCc1WU093YDSyuAQWaN/dP4Y5RloWCWLnoD92huINGm/qNSZxkFq+CZFvikJl2URuW7lG9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673608; c=relaxed/simple;
	bh=RhpfYGCqir8KeDrbfPrat1IMH9lAxqGYsr7KbVABAV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/zewb6uB7jFWCyh9Vygjg7eY+L0DFGk6nGi+SL3eIaqAinqxRn1fN1wORv9lJyzzYklROFw2Y7T7f0/AaPxRT2hUILcVx+zXfBvpeWAmvHz1/+BG9w4BcfaIFsZ83GpTMmjXurtUJW2/LMJXD3ulTwcD04hGLXKCHid1Gd1W9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3m+i+6s; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3m+i+6s"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2022323c37so776833666b.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 09:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787673605; cv=none;
        d=google.com; s=arc-20260327;
        b=jLjRJ6F7rFM9sir08ayFxSA/0M8CUoEBNOlXljC9AS4lEyrgMmRPVO1uLkNiD4tZO6
         oUCx+xFRVlOMMLdqW7H77cxPLd3FMKDQw3o5AX1lvA26reLbm+kBRUetQyYX2vqhg09c
         VSVI7i3rfIaltd9ByUw/LJcc39f7I2ncqKFU2IsIUSglvZsbpJ5dncOWHE2wHYOWquhK
         92W8FfelC4RTcL+ZwGXoPNb0cIzg2SZ70lL3HFLq9r+keGCorAOdvZBPkqSjvQEUo63E
         bsAPbfph9Sov4dmEOQn70rKuZr70uxylk2tQimrb3xedPjUSoD+OXveIuhXyiWCvhufI
         wWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RhpfYGCqir8KeDrbfPrat1IMH9lAxqGYsr7KbVABAV0=;
        fh=lkKI2Tl0Nk3ewYs7kuQrjsq9ZC4iojX6bWrQe9ZVFMM=;
        b=U1CcFB5gAQdkVZemjVHlyAUcUnvqvkJUPpgojrp5WFGAskYONs4prht7VThtBIuS3k
         RCL7qun6P8AIn0XpOojSRgT5VaE7yqE2U3pig5UTTAvTULJraXZx+cKOLhB2xL5cMOkQ
         TydL+9UReoVOU58+zIVFkmYbGSX3qaxm8Bezh8tGtR6hHGdNgEXFFr0aivFLAicszFQz
         8zj6ZKV9CYfyoXjoArG9Bcphz9DtCefSySAW+mTdpXiXoiIDrGTD2Qat84EUj6xJ3gN0
         Z6gV6RH97yraj4ebsAZBrNhwj/cuFETGwZhjUZftpUaXZ+2T2GU1a4v/Ub2hqjxq8pQJ
         bxtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787673605; x=1788278405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RhpfYGCqir8KeDrbfPrat1IMH9lAxqGYsr7KbVABAV0=;
        b=F3m+i+6sBtMz/RFsGWZAYAsLao1wja7BR5vEI4ng9odY5CNrIp2PEVoBlv5o92Dlco
         ty4S1r31SJzpOZtm0qqorZUjULHC5WSCBPgpmUvwwd9ojeZT3wQAOtbJrQ63QgsSZ6td
         3rk+XADpdbxExS5VGPjCFBV4au8O7x9LISgWSR6sKqmcnnKA23q2KC1fG6FZUYX84LoV
         qM+EHKuZElDQ6mdkTkkcIrElq2WZwIukV8x5C5EkF29/XRig5aUj8V4AE1QlQhlGksNs
         StBz19tEQwpNw7q4WpOndGPqeKVCIrUPTNiQxJpbIncA45h3mwXVyLdp5T9c3LprvqNb
         fuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787673605; x=1788278405;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RhpfYGCqir8KeDrbfPrat1IMH9lAxqGYsr7KbVABAV0=;
        b=FGCRia5k8zWnwU0AZ2tawo3aAtmjshaQWM68t/I580tnOo9j2Fx/m8vLxq5UIProaj
         sfiy8d47GdlnjlN38ig3K1qLOvANAs0lYL2+YiXbcENY1OBrVa6M+pnWfBKepeZbI33i
         DuTCelQ7hpop5L93lVjFkVCcS4OZ5S+7LSW4Pfm49Y3SLWh3fs99CvIM2Hb7XvvoQQ7k
         /xd5B5ydYtiakpzw5UOsoWhPaVxr5zRrnivpq+gr78fPchuTA4ksSP6+2jUeKXyMZKw/
         IX51PaB1yutglfaP/03ZzpEcMYo33qP67Em1LWi+9KZhc+v+ouT+K38L5xa1tlxQWYzp
         Kw5w==
X-Forwarded-Encrypted: i=1; AHgh+RqqFu0wUVI3mx/QoFkPyneevED481XMAHXzQ0AA+9G5rwqs8lnkNZXdU+8/m4qeA1Rv+a4=@vger.kernel.org
X-Gm-Message-State: AFuF++ksrfL3p7XekAebUBc13dSF08Bw/HtUlgPHYEuPX3zJNAuC6sHS
	MXzmKLylvDfJ2IVghEh6IIidOibY4Kte45t0HrU03nzLVjsLivNV3snu3ZFAT86rR+aPGMVFBfR
	x4QnQoL0oolK8GQTnBAgItAQ/kV34k7//sIMSF/hl
X-Gm-Gg: AR+sD13k+Jxai3lln3koB1dO91XvglewJo1eJBckUpIotbAynndfvgfTIKR9S7FZq5d
	o1DreRmIm+MMiKd7FgLC5HK3nMQh8+zuQnZqb7pIkGbmIkHaj8uTcP5ZDqQcdFo8IriCMahr1U1
	RAKb+HyCj2d5wtZkF1Zwlhem4XEqzPtdLhyqIv7Ej32pjbFmiHK1zE7nsnbQcxw3n9Z5z6Wq1h0
	961ib0jiZ9oJ6KPBwzpW/WzjdmBZVW6t7z+qKSyah3VrPnbJk17X9ozYPk57P0TFrrSdr4QGYba
	sYUqJb5KhAvDFRqIvcFJfyBrOvigkj7NP7pWSg8pbLPbulo7BtvaPmFK/Hc0tfSMTuYHqLLlFfV
	M+S4CBHg5W7rnoPJJFI5ysYWhIJZ76L+6hLMyBx0whAEM53+PD32THblTWZllZHF8MFvK4qUftD
	1x8/jdeuPhz0sS
X-Received: by 2002:a17:906:f592:b0:c19:473b:dc8f with SMTP id
 a640c23a62f3a-c24e584dc43mr734821066b.3.1787673604387; Tue, 25 Aug 2026
 09:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825140159.70997-1-mamarang@amazon.com>
In-Reply-To: <20260825140159.70997-1-mamarang@amazon.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 25 Aug 2026 08:59:27 -0700
X-Gm-Features: AcwNN1VkSyXRdBKij1yS8oI0WNaMBFOAjb4p9o1t4A3_Sp1rzNrjSQHmCz5Jkt0
Message-ID: <CADrL8HUcr5Fei1PX179bkFmMJ_S+eD267SVgc85cm-rpcahwmA@mail.gmail.com>
Subject: Re: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page faults
To: Marco Marangoni <mamarang@amazon.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-patches@amazon.com, mancio@amazon.co.uk, zoumboul@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 7:27=E2=80=AFAM Marco Marangoni <mamarang@amazon.co=
m> wrote:
>
> The TDP MMU installs one SPTE per fault, so faulting in guest memory via
> userfaultfd (e.g. snapshot restore) without hugetlbfs costs a VM-exit per
> 4KiB page. Mirror the shadow MMU's prefetch: after a 4KiB fault, resolve
> the forward run of host-present pages in the faulting leaf table (one
> guest 2MiB region) with one non-blocking GUP and fill the empty SPTEs.
> When userfaultfd populates in large chunks this maps up to 511 neighbours
> per fault, cutting EPT violations up to 512x.
>
> Touching 128MiB backed by userfaultfd with 2MiB UFFD_COPY chunks:
> c8i.metal-48xl 129.1 -> 100.3 ms (-22%), nested 495.8 -> 121.5 ms (-75%).
> With no batching (one copy per fault) there is a ~2-4% regression.

Hi Marco!

I think part of the problem in this case is that UFFDIO_COPY will
install 4K pages (IIRC), I think a more natural way to fix this
problem is to:

1. MADV_COLLAPSE after doing UFFDIO_COPY.
2. Make UFFDIO_COPY install PMDs when it is able to do so.

These don't solve the exact same problem, but really userfaultfd
should already try to install PMDs when it can (#2). If we have #2, #1
is mostly a no-op.

What do you think?
