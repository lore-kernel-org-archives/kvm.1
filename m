Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B553009DA
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249514; cv=pass; b=JBehqLljPdVZVEsfLHNvYObk8oJ1zN9FkcjXTHhuhPb18wYJPNOZiXVXS6tXvc7wcPmFe+DN2EffDxPUPostGCpISiRr7oC+sKhW9ny2xdFx2DUboD5VL2qxpxXB8Dp34SaT1leUTjbAhvMwtkUWYPRB/8jumN4s/f46Upn7bjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249514; c=relaxed/simple;
	bh=foOk78D3JIgTIfcuSEjX/vfLimtUJinsVHko7j0mesA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hO3M/G60aEKi3Vjbxkm1ifA0ZcpmjMvB+UXL3Y4wSHkrT6Y/+Bvv3MZyHBEGVH9aBMluWTT1cc96gMpZLqgs76tIxsxa9qMaYoG7pnMY1TadYbaubY7VSZ6RkohQLTio4q92odgKBkQe0Lfg9M9d/mqtGh783W6oYXCy9OSJFeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbFTpPnU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nzHld6Fd; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbFTpPnU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nzHld6Fd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773249512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptmQhjKn8gfhE/3QmoRJXKe1h5nH8MiDy/YRTmOjOKU=;
	b=KbFTpPnUHuYHQ3q9VAA+apP/2Ayqa7zDrRZMky//ElCBXt0YoTdJlvIrZ3faTLnxmZ85FJ
	jev4lZvKn1mkJMrW6stbx6HaxfGGzqO0sPbVWQXLZxbVqLPQtyAD8hgA8RQuqG412kR1ty
	0tGeYm8LW5xV+zSo0E8Unuzo9t7+W1I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-6oM9b6b4O7WuonOa5qF2yw-1; Wed, 11 Mar 2026 13:18:31 -0400
X-MC-Unique: 6oM9b6b4O7WuonOa5qF2yw-1
X-Mimecast-MFC-AGG-ID: 6oM9b6b4O7WuonOa5qF2yw_1773249510
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48531e6012bso848555e9.1
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 10:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773249510; cv=none;
        d=google.com; s=arc-20240605;
        b=hdvthYxYYHsx5jhXGgzx5q9HDaK99SjZRqVpn7YIckFs9SZKxynQkA3j0eJFCfEr1S
         e9WTEY5XK8UPFqmma5fphxaQjUeptAuoYflTrZMCiLBWnOvfB0of4V8pp5u0DoeLU4Tn
         smaZl4zLHARkAjVDBHHNlZD21wxtBvaNQ/zwJEJisul/qZviVi3UmpavkmACKx6G/VPp
         atb8WeaZjtU8xmUfRqrDtr1dEX9jRHK2ykDkr1foPPk2LxU3qqzRsA2DjecJxexg8MI/
         zZw9Apj64ZH5k24BlkME/dSD7GsYBspibhU7oKiChYRQWJYmo9MGm+EF2TxgTNmCnqyj
         E9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ptmQhjKn8gfhE/3QmoRJXKe1h5nH8MiDy/YRTmOjOKU=;
        fh=ZuyXBFx7jA2cz000tH00IX6m2ogOa3p9vSbBT3Z1SlU=;
        b=Ob+/pZGOfCP1mFhExq2VXIPE40QpFT6wmbvQGK3EE2nL1E5mgj2Q+4bNh/s/Ed3dr+
         huLyZcjc/L7f/LbXvzEk40VwcaefJQmuEAw/5BzAnq/IQIy4qij87cBCofUC+Iq7P4a0
         lT5aD5tYYRBPhGzwS6EklOax+uqV+jNn3ch68/gFpvVJvvu5S67rLMjDTECHMziu2t8n
         +NMWDVS73m3GRHilSCs9Xcx6tASOB2tkA13CKKl8ZvFzaUVV2421LHNRtXlx3uZNvi2d
         RgqqBpoe8rRnRv1x36lfEABLxRmn4rfXwaNz4dhANGUl3wnRcti0TNA32fiPOqbaUrLr
         cVlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773249510; x=1773854310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptmQhjKn8gfhE/3QmoRJXKe1h5nH8MiDy/YRTmOjOKU=;
        b=nzHld6FdDulDM9LF5pYdxheEfZm4rU1bcfoBmfmManhWnz2noukdPjqYJFqsrVmdEm
         k3enK52OF3e0zWUN3C55lxGqueMVUNGZoX709AtoG+wesbEfuLEyGWnqYIy+QKKWUK5t
         bhuCHUa2jlPllfWs5Uzpsy/BuMxKexYSQU9C0KKkTD55MXdSZiWuUxdC4aF36C9x69mT
         kxX7FwyjME8g4EYqUnN2DiZcuWqoY/Us3rokz1JhI2esxEPaL02N9Y+cnLXRNnWpLDuJ
         6o07V5Csa+/FBRHHPFJYK9V4laE7NTCj5yy/YBiHSsZs9jhMMlhqbX3uUGCVR1udzMFK
         QoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773249510; x=1773854310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ptmQhjKn8gfhE/3QmoRJXKe1h5nH8MiDy/YRTmOjOKU=;
        b=QUViQdim8sRzjdobAk9yWTQ+EWwfzmzP5d5xiaHtKjwmmEBO202jJF0g+cGqev/zLQ
         IHvi9QbcyaQm2SBSwvZieYnLoDt+Calk5MyjbUF8moinRDRzoTebMKOIDfUfbzbSvNii
         u82VRbCHErrtOuaM3svFnqV37GnWLVnJTUkpi9dSsspkAPXNAfYGtccargobSdZnUvKC
         k5LU/ntFV4ofUfjr4uuumUr3IwcKbuK5hsrZjjQjOLa+uIxlefBz31QXwdpL7ou2qWEf
         kkEijN8xS+K/I7RtnuflhBdYaF+JzISp7G8rUdBhBAKamriE560TULEidD2Mhysj8eNJ
         4scA==
X-Forwarded-Encrypted: i=1; AJvYcCV6kn5fHqhQlg7F8IeqoxCO24hj8FN5fFw+eQGvr6DQs369F822pJa8ODy/mcqzkvSqYGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwRowLQF4t3Dn3xCe7RRWe3jFWMjMY/aXkV4Jud/+UHwBBCk53
	z0tIvmOC7K5Ai77xTZpVHJREZ+UoJu72TuJF0/9/ow3cO3C1otamTHOahTNNdyU+u1woSY3pc17
	jraVSmDqb5CpMbD4LW4UKORWwoMLfIXbMG4RzsBg1xUbWvClcWgeZA9hRGsqV3UyYuWeBSXaiS1
	/w3c1aPRBC2N2VwDOjzRO1T8jXpk8k
X-Gm-Gg: ATEYQzxLdgGgnDQFu19xeSAKm8ORdpXdhcXkZwauxJdHrjHODZy1nf6lNW9hEswONG6
	EoMj1yxZeB0pOSmNiANRfU8GO0rjSW+PWOLBm6koDQlrWhKDL5xGW2PGsiAZhcb8B419L265hbV
	Uan99OhsYjqnvHmtBLMPMvQABoRm0NlmyE3NrUGnV0OryGlNCBgc0szlGwO/DL2lqs+m6pyhOf7
	2kDwAQZfxiG9mv/Cy1wfNwGgwSdcffZywAIk7VheIPwYtMPw2DIBWKsO10ZolDHW0zKhHYt2WDr
	NRT69hg=
X-Received: by 2002:a05:600c:3103:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-4854b0acb1amr53192575e9.5.1773249509606;
        Wed, 11 Mar 2026 10:18:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3103:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-4854b0acb1amr53192065e9.5.1773249509123; Wed, 11 Mar 2026
 10:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311095405.26297-1-hi@alyssa.is> <CAFEAcA8GCz2c18e3+bwFooAxYZzBrX3OjjQ58CWJOdLfTYL_dA@mail.gmail.com>
In-Reply-To: <CAFEAcA8GCz2c18e3+bwFooAxYZzBrX3OjjQ58CWJOdLfTYL_dA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Mar 2026 18:18:17 +0100
X-Gm-Features: AaiRm50pcEDyXv7xD2lDu3z8yY4Td2KLNxWd2RJSWdw_O47KQFbkXprdMmcDbIo
Message-ID: <CABgObfavGAHLz0FZy66QTbXHTS7YqWxc_eVmEWnCWo+QBPiN1g@mail.gmail.com>
Subject: Re: [PATCH] target/arm/kvm: fall back if nested unsupported
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alyssa Ross <hi@alyssa.is>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
	kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
	Miguel Luis <miguel.luis@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 6:03=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Wed, 11 Mar 2026 at 09:54, Alyssa Ross <hi@alyssa.is> wrote:
> >
> > If I create a machine with more CPUs than KVM supports, but specify
> > multiple accelerator options, QEMU will fall back to the next
> > accelerator.  This is great, because if I've explicitly specified
> > multiple accelerators, I've told QEMU I'm fine with any of them being
> > used to provide the machine I want.
> >
> > When I create a machine with nested virtualization enabled, though,
> > this doesn't happen.  KVM often doesn't support it, but TCG always
> > does.  The nice thing to do would be for QEMU to fall back to TCG if
> > KVM can't provide, like it does when too many CPUs are requested.
> > This patch adjusts the behaviour to do that.
> >
> > This is very helpful for OS development scripts that run an OS in QEMU
> > =E2=80=94 I want everybody to be able to run the script, always with
> > virtualization enabled because the OS requires it, but for it to take
> > advantage of KVM acceleration when available.
> >
> > Signed-off-by: Alyssa Ross <hi@alyssa.is>
> > ---
> >  hw/arm/virt.c    | 6 ------
> >  target/arm/kvm.c | 8 ++++++++
> >  2 files changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 7456614d05..0b63b2eac3 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -2372,12 +2372,6 @@ static void machvirt_init(MachineState *machine)
> >          exit(1);
> >      }
> >
> > -    if (vms->virt && kvm_enabled() && !kvm_arm_el2_supported()) {
> > -        error_report("mach-virt: host kernel KVM does not support prov=
iding "
> > -                     "Virtualization extensions to the guest CPU");
> > -        exit(1);
> > -    }
> > -
> >      if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enable=
d()) {
> >          error_report("mach-virt: %s does not support providing "
> >                       "Virtualization extensions to the guest CPU",
>
> I think there is a bigger problem here. The code in the virt
> board init assumes that the accelerator has already been
> selected: based on whether kvm_enabled() or tcg_enabled()
> it decides things like which GIC version can be used, whether
> "-machine gic-version=3Dhost" is valid or not, and so on.
>
> This bit we're deleting here is just one of multiple checks
> we do that assume that we know the accelerator already. If
> we actually don't know if we're going to be using TCG or KVM
> then all this code needs to be rethought.

We do. This code runs at the very end of qemu_init()
(qmp_x_init_preconfig->qemu_init_board->machine_run_board_init).

The bug is on the KVM side, as it lets the configuration slip even
though it's not valid; the above KVM check should really be more of an
abort() if anything. (This is also why I picked it despite it touching
hw/arm/virt.c - from my point of view the KVM fix made the above code
go dead).

> Paolo, can you unqueue this for a bit while we think about it?

Yes, of course.

Paolo

