Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A30D3BD24D
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086933; cv=pass; b=k4kxO9W/M5nU4S6higefFuX85exJ4rGCZcTEmCpz+HSRHsfmsSMR+gkKlhJgfOlY1sMxzWp5+D0PuMdzzmvO+ExmhULAm8rCzE3tRgdXoJGHKjASDuJ/+HWZJTWctxWI7Q9ODW5nN8GYHbzvB17ccrbkKpLlWafAnzxgZjHe6Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086933; c=relaxed/simple;
	bh=qacV+HuBZ2gtB7U/IqUOCYRQ36+TsA2+7UYhwty8ejA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaTDNU7tCmvaocd4NtccX9YiJFY1JK1aijm5W73gPiSMl7hYsViWHBuqIhayUB8PXI3oZnlA0BeyORNBv/Jc3sHcpIju5M50XXaz2k5161BHWv/7RP/xRBProFy8VuzP2VEvYtTmUz7ASheGCa0taSQiXHsp2M/BVu+f+dzUbtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGLkj0oC; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGLkj0oC"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-509062d829dso133941cf.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 16:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775086931; cv=none;
        d=google.com; s=arc-20240605;
        b=PjTJSrc5QzBm0NGaMxm9cwsclc6/Wdet7X1Ow9e8n4yqnmVLtAWP5euO/v8kr5mGat
         LXEsKx/GOFI3+5KIR+nLDHdt4ORH8uCkc0fLQ8EGI5lt1j2yKe51Els5sdhJowiXIeW2
         p/FAzia+CrzmZoUyKE0J6LjWCvLy8GhSmFwparMaYQeS0eaXNR4jEOcyEpCAkQNPHZiT
         0a53XaciztMxz262nB5JZ7TNfX4AACBRL4D5xT0ZjFrq7jZQGE8OVmmYLlR1Zgo2V+XQ
         F+u8uVbs4UpXaBtA8XFIf1IyJSOXSDHjBGbpKOx9hUal8vGiSiDF6i/CfDEFLJOKb4x+
         yKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8IIkG56WRx+WvTtHjw+aCl7tZOQ45h3Y1TK/DdqOefk=;
        fh=MMPaHln5xm13/IHH+9tFANM1Ko3gh1QnbFwjf0Shi8E=;
        b=HCC5d8HWz19Ig2BO6VuBAGULrnEKS0lAo1E80JNKytQMDBSt7d+HJDUQNf4igJHvSy
         lcMH/paZWhoS+qZKQMhJSmFFhOAKqUp4u4H1yOfbMbb5k5OEyfZTpEYi9mC+wezXwBH/
         AJJ+LIcgR5oOFOSJ7XVpTTKFsZBqMyDPtFc/VJ60ZS4Wdv2gb5m4mrGMHMRCG4KsPWE9
         664igMMcbSBtC6uy8+whSH/L7ZfwcVMPyDpjttJidGaTGoNklVP2WikJlrLJmd61SFwQ
         IGrKyIWIg5+ypMZW6nRlnUJdwv73aEwz0iRgSY12LtuMsuduZrXLAk6rdHo2gopvwB1x
         slmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775086931; x=1775691731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IIkG56WRx+WvTtHjw+aCl7tZOQ45h3Y1TK/DdqOefk=;
        b=wGLkj0oCmsnwsBL4Zh/U3oY+rmnsWKW5na7sF8JvHsqIYjrF+BB/6h78AIg0Ksug2V
         pXbqZAV46NTh5l99fA76Ea/C1O20ErAJ9OEtOf12p2iEvZPrjmoC93ICdIKR0oCM7I+U
         Evk8+jF8I/5BTIHtscsKr4LtfpTiJbHfDPannpfN8U/aoziXbkfZhYzvssNOzeGV14Q/
         MhjqwscuYk5Lg6WbSIE+ngnH2uBo8ZUFjJIJbYkaoCfX+Oi+M1ZDsPv+uonxW80m24KW
         aKLU+HF7g+h9bAcZL9T2tDNP7fRk6kQbEWZeSPOIYydH52bOTzRbuBtaJH5t7m8U4a5R
         3k+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775086931; x=1775691731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8IIkG56WRx+WvTtHjw+aCl7tZOQ45h3Y1TK/DdqOefk=;
        b=XzU3xBbKuwqPYhloGTcSMG3gUmcAqg1wrT/852cRbzsCNgJm5F2HZsmQsv87fyajzq
         rBvUMOhU2JkxuXDhSuAk2Fj73J+D6IFAco7vPz7GnxFnkjvLKeSQqySwFcGSZkPG+oH4
         UrAhNoqh+d/dAKH0052fOBrMRXKz+ZK1z9B3hzMm2T6Kne0WpIKXFG8s9a+qazklAVjl
         HfZDd1LoeRTrXhfAt67V2x5d/y8atg7Tm3IHpVhunDEzIqayxOtkTAiHpfVYPB4L8+Nz
         eSUzk9BszhPM1ttXl5QPXssiuEtZrNbd4SEJ089ViPXzHk1VAVY8owIlwRmCgXuQY5aV
         gx9A==
X-Forwarded-Encrypted: i=1; AJvYcCWpk+0eyCHECfreED7EPqIHBiLn6iYbzstYAr0ylcmSanf/MpYVeX4l1Rj9RK9fBZyn1ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNSz4HscmnvUmirZOMvJGdWDd8Qrc8QOJV2+Ve5SsZKkWbtbxf
	5kDgLA6OgtrEApdW2j4edhxoQ8ZB0iqdVavV16c5fLbb8yakAmnFjjbuk3RQo1POBqSonaAVaxv
	12DIrUWfvJ0NfjScdyKsNL0EfdtjG+ahy7lDwXoo=
X-Gm-Gg: ATEYQzxRFje7lLFKPp1uu7rjiSu4vx9cLC0rIllIaAftR/+5apES7iAyQy/Y+W7PrM1
	81ub6pt00RdcZNR1+SOLuAL46OtxSftpdBOgQcbAxjAzwjnOlNqieeZmqq+r+SXde95vfhCmKIF
	PewuVfR3R4CtOlZyKuwRL23P8Ty6L/DdEHC4SMQuSL/zpH8ClyyaEcXIaLThMf5B+I5g5DaQIpU
	MYgxqETbZZcV+aF+b4gqMfH4ZlFmH7Ipomr3riC3RMgFzLS4/+TBx6/ymQTR64ZIFP6GCMtxTQW
	Xg0V+EBaJsbCLKlWbDEvAwgdxlb41JHnq+2N
X-Received: by 2002:a05:622a:1985:b0:4e8:aa24:80ec with SMTP id
 d75a77b69052e-50d507a99aamr814131cf.14.1775086930545; Wed, 01 Apr 2026
 16:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <ac1hI93pEo-x-7YU@google.com>
 <ac1pUx_jYv2yCMnX@google.com> <ac1s55_oLEUQx8Hs@google.com> <ac18LHQLalPb4z0-@google.com>
In-Reply-To: <ac18LHQLalPb4z0-@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Wed, 1 Apr 2026 16:41:59 -0700
X-Gm-Features: AQROBzADt__uEdh14omoQ4LFvQofVsPpy54qfnn49Uzotn18dRLCs3pEM31g1fM
Message-ID: <CAAdrzjugqk=APteY4oZNsa2e5kv5-=HBekyYfpzrwFUZ_WapsQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] KVM: selftests: Link with VFIO selftests lib and
 test device interrupts
To: David Matlack <dmatlack@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 1:12=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> On 2026-04-01 12:07 PM, Sean Christopherson wrote:
> > On Wed, Apr 01, 2026, David Matlack wrote:
> > > On 2026-04-01 11:17 AM, Sean Christopherson wrote:
> > > > On Tue, Mar 31, 2026, Josh Hilke wrote:
>
> > > Agree this would be nice to have. Is this a blocker for this series?
> >
> > Yes.  KVM selftests need to assert there's a driver before trying to pr=
oceed.
>
> That exists in the new test:
>
> static int setup_msi(struct vfio_pci_device *device, bool use_device_msi)
> {
>         const int flags =3D MAP_SHARED | MAP_ANONYMOUS;
>         const int prot =3D PROT_READ | PROT_WRITE;
>         struct dma_region *region;
>
>         if (use_device_msi) {
>                 /* A driver is required to generate an MSI. */
>                 TEST_REQUIRE(device->driver.ops);
>
> But I think you are also asking to have a helper that prints out the
> list of available drivers in this case. That should be trivial to add.
>
> VFIO selftests could expose add a helper that handles checking for
> device->driver.ops and, if null, printing an error message and list of
> available drivers and exiting with KSFT_SKIP.
>
> One wrinkle here is we are probably going to merge a driver soon that
> does not support send_msi():
>
>   https://lore.kernel.org/kvm/20260331172241.50456-1-rubind@nvidia.com/
>
> So we should also have an API for that. e.g. Add 2 helpsers:
>
>   - vfio_pci_has_driver()
>   - vfio_pci_has_driver_send_msi()
>
> This test would use the latter.

Ack. I'll add a patch in the series to add these functions to the vfio
library in v3.

>
> > > > struct vfio_pci_device *kvm_vfio_device_init(const char *bdf)
> > > > {
> > > >   struct vfio_pci_device *device;
> > > >   struct iommu *iommu;
> > > >
> > > >   iommu =3D iommu_init(default_iommu_mode);
> > > >
> > > >   device =3D vfio_pci_device_init(bdf, iommu);
> > > >   if (!device) {
> > > >           vfio_pci_device_print_drivers(stderr);
> > > >           TEST_FAIL("No driver found for BDF '%s'", bdf);
> > > >   }
> > > >   return device;
> > > > }
> > > >
> > > > Because as is, this requires way too much a priori knowledge and ma=
gic for
> > > > upstream.  The user shouldn't have to dig through code just to unde=
rstand what
> > > > devices are supported.
> > > >
> > > > Ideally, VFIO selftests would also provide a script, utility, and/o=
r helper to
> > > > identify BDFs for devices it has drivers for.  In my experience, bi=
nding a device
> > > > to VFIO is trivial.  Finding the device in the first place is more =
annoying.
> > >
> > > Agree this would be nice to have. Is this a blocker for this series?
> >
> > Yes.  As I mentioned to Josh off-list, I'm not willing to accept a "we =
pinky-swear
> > we'll make this stuff user friendly".  It's not that I don't trust you =
and Josh
> > (and others), it's that for me, this level of user-friendly behavior is=
n't nice
> > to have, it's mandatory for these tests to be usable upstream.
> >
> > Internally we can squeak by with barebones, unhelpful tests, because th=
e run
> > commands are often hardcoded somewhere and there is piles of documentat=
ion elsewhere.
> > But for upstream, none of that holds true.
> >
> > If it were weeks of effort, I would be more open to treating this as ni=
ce to have,
> > but AFAICT writing the code should be less than a days worth of work.
>
> Yeah that's fine, I don't think it adds too much extra work, and it's
> something I'd like to have anyway. I just wanted to confirm if it should
> be part (or merged ahead of this series) or can be separate. Thanks!

So I need to add kvm_vfio_device_init() and it will call
vfio_pci_has_driver(). Then, kvm_vfio_device_init() will TEST_FAIL if
vfio_pci_has_driver() returns false, correct?

Should kvm_vfio_device_init() live in
tools/testing/selftests/kvm/lib/kvm_util.c?
