Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C4E38F934
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781555755; cv=pass; b=Szz6ioiDry6nJyw+q1+HQq/qIsv2cumBAeYVA5yf6XHbLXWp0Vyqn9fMJq8jUiTH1cn6etdQcqgPJ3DmVqQu1FyNSwvAajZd33ewHG/ZeQGbzZuYJF8RYzaeR+1n0pXA2hOPvmcPZbrTfojsG5kJJ16YX18r6UYy8Hs7+KAZ5bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781555755; c=relaxed/simple;
	bh=G4lSX2RGOs04PiMPaq7YPMfkUB46XsBORCSI627WDGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIXNjyzbo9YmwIIzySnbzWdB4+/fo8r7a/sl5ZMg3pkEBkQCYRnPtMKl1QfQ9IB+78i+/3gJoA+hNdxh5EG7/0nXTjrj26CBvhG3SbOrxPtbOXNUnQy5/sPza5V/NZPQbRS6SR23u9SkxMopRAk49oAsAX6eXZlXavI0BHYc7ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=No5SJ3Fc; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="No5SJ3Fc"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so3230a12.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 13:35:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781555752; cv=none;
        d=google.com; s=arc-20240605;
        b=YQsm1mevCMGavnz/WsjcxyN03UWB9oGxObVkS/hldFDYyQU3Z24JKyw6tnjMimK7Th
         HaAT5HpAioHmOs3o99Cu6PeBJ63rQXLd4YZXlZB9Qxmnogx9TBRicj1bDHaqiQ3SUsK2
         Ony+zdhIpHDvaglOuSgZ7x33tDa2M0baLP6q8LBs8SfcBlBbEwej6ZrIbgkHe57qElSX
         5UjZMggs4GMK+q5dIeaP1pe6QxbDI6YfuIpIAmEcStCBUKkxWVFX6R3ClzoBeCf2yzaK
         YN5V1SOVEtw2ULBFApwR3IZ7tCMYPNstjPQsAFZt3uMvIpqjVOvcdpIFX5SJ9jaHajG8
         hEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cdM8zKDetkcls/vdqGYb8yUYZ48F53j3/nNEOttt5z4=;
        fh=3Lf2bRXhip4xUcelDW3I+ZgNQ8b1E3Z1+WCyiSaHxgg=;
        b=aYY4M3T72osChDDg98ceQhGNGuxF7rH29LblWm2J4T0rg/U9iBhAaCAfsYmPSfV+9b
         66vOgWujoHOe66nJt1vjgnU9U05Dm3N8A0vAhOZcHBCeF1hZYjI9MokWhgyplDQ4Aiij
         2RlFnHS0QYD6ihS8N4SA2uwB2jlHe5foXcZ60mi6lVAcsj/PPX6gfM8L6lmxsJJxUqWV
         Kqc8y5KLoDeJaH7IXDMAQjc2npUVoqtKaIKjWQNDdBA4oF/mh3R+0oUKD/YYsbeVSd63
         Tj1a/qcOy5Ci3YAOW9CrEtgzwpH64+5/AendCVWdgFrHvv+2FLE3sy+SuWy4b0i530Gf
         1ksw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781555752; x=1782160552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdM8zKDetkcls/vdqGYb8yUYZ48F53j3/nNEOttt5z4=;
        b=No5SJ3Fcp21s395I27V+imtqveWvPE/38QABnxQCfUd/4/ZN/bHElfbOxzZ7sq81B6
         d06HTpiwMEyaooHm+ZvgkBYigWF46sDN9+/75/x1OJDuYURL6uWfQc5NV6ufVK4bolWm
         GXJ1Qtd1UtlCfbmH3zhD+vm4JDGM43OnwPRR8p0+RbKJ+YrrLAM/YP7MgpHMhVwM3WWb
         u0246Ynr1hVBX30lfAG0waORKKLk424OMNeSMvBv6Y2v+1Vo1sTmYb33VEoGqp4iyZpe
         2ZI/0zi8P3+SWAyPWyBmdK/iID3mP4vESs44rycpUyou8SkqIYmT+TaToWMYehRNQcBE
         f8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781555752; x=1782160552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cdM8zKDetkcls/vdqGYb8yUYZ48F53j3/nNEOttt5z4=;
        b=cI7zbDDMf7utH8oNFOy8e+waIybMkttgGjyZjucEkLaRUnEY0OLsk92TjK604mdnGx
         YdW80XExEw+Y+HuIhp8N/3+u17tSW6Ql6bYIg8uFLnYISK5kj16GDUvtSDC/Xtq9U24u
         nPHqd2FP3sjrQq1UZgOlG6TYWZUUj+0iuZRpOP4qjzOL135KtfrQC9NWwXmdZcDxEpGQ
         iilRftoTtL4Zdb/Z9q3DD8IYn4JLB6rvx9N9WVEqaaj9/S968TRH8ij42NecqMKIul8s
         sJPX82UCwSIljJ7GT+G/iKEWjqWbfFxsoNLq+9uwapqJgBxr8s8DWHpwEazI8zTxX+1d
         hshw==
X-Forwarded-Encrypted: i=1; AFNElJ8duwx+jRmk9OziPBbgdpHw/zxe5I34J87gs/qn2f/nJsSuClmf+XUd6c6ASNRno5s7ghw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd9gGPvVa1DagHYSH3mytpe5O8ajF7VCYMnsjT2als/Pttzd8r
	o+4hloZ+ZvKB0okLadqPgjIu5FWU2czd/ZfVSejoCAGfeRDlzsdzi6BlcGsNBjtoAQnPT7NHWZg
	ztV9DED9RUiDcpXDb0fOtH1UeglINsJEV0Tp5+Kd3
X-Gm-Gg: Acq92OHDvrgL6hLxHytLVb6YEixGk3vFdgJIDj1ySqbk7P0Zs6dMvaWzOmP6EJ9xxiC
	daEEuqbXzT7iamGGt010Gv8Z4+SMn9j83l+oAiBKK6N6d9YD9eww889ic8GS/+mhun1pTDjh0aA
	CL6nj1CMlYWPkDfYIovimaORNvJWLv5DtFebxVIP0vnte+e2SQw2yYJuq03bMfmOSVhO4OD944K
	oQ0AyFWQ2uF1XtZZXva0BFQtjJNYS5wAVDSu18gFhkDVIgxC+Lgpia6cLsxkkZmOj5Ih+82DvWb
	5hq6S0M=
X-Received: by 2002:a05:6402:208d:10b0:693:17e4:c6b0 with SMTP id
 4fb4d7f45d1cf-6950f6e5086mr1463a12.9.1781555751795; Mon, 15 Jun 2026 13:35:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com> <20260612230113.684301-8-seanjc@google.com>
 <CALMp9eTDfP908gH7OH8HAJKAsaixNfA5dHnPXBKFquQRFVCxFA@mail.gmail.com> <ajBNuya3czCahy4K@google.com>
In-Reply-To: <ajBNuya3czCahy4K@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 15 Jun 2026 13:35:38 -0700
X-Gm-Features: AVVi8Ccqn6ZYKROUGOtGuCntGjr6lOSfW5iZxoJLuc_mDOXYz-21cYIItTEsD5A
Message-ID: <CALMp9eRSHdyMv2TRUbgBer6WHBQ7hwNEzTmqji0yFrRwKPdrZQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] KVM: x86: WARN if MOV DR emulation hits a "too
 late" #GP
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, 
	"Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 12:08=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Mon, Jun 15, 2026, Jim Mattson wrote:
> > On Fri, Jun 12, 2026 at 4:02=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > WARN if ->set_dr() =3D> kvm_set_dr() fails when emulating a MOV DR wr=
ite,
> > > as the emulator _must_ pre-check for #GPs in order to get the event
> > > priority right when emulating MOV DR for L2 on SVM (all exceptions ha=
ve
> > > higher priority than the instruction intercept).
> > >
> > > Opportunistically update the comment as the blurb about "#UD" being
> > > checked is incomplete and misleading.
> > >
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kvm/emulate.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> > > index b1799ed01939..e030ef9b9744 100644
> > > --- a/arch/x86/kvm/emulate.c
> > > +++ b/arch/x86/kvm/emulate.c
> > > @@ -3298,8 +3298,12 @@ static int em_dr_write(struct x86_emulate_ctxt=
 *ctxt)
> > >         else
> > >                 val =3D ctxt->src.val & ~0U;
> > >
> > > -       /* #UD condition is already handled. */
> > > -       if (ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val))
> > > +       /*
> > > +        * A #GP due to an illegal value should be impossible at this=
 point, as
> > > +        * such #GPs have priority over MOV DR intercepts on SVM, i.e=
. KVM must
> > > +        * manually check the value *before* emulating the write.
> > > +        */
> >
> > This comment seems confusing to me. Isn't an illegal value impossible
> > simply because we already called check_dr_write()?
>
> Yeah.  I'm trying to explain why KVM WARNs, and also to guard against dro=
pping
> the value checks in check_dr_write() as future "cleanups".
>
> Is this better?
>
>         /*
>          * Yell if the DR write is rejected, as all inputs have been vali=
dated.
>          * KVM must manually check for exceptions *before* emulating the =
write,
>          * as all exceptions have priority over MOV DR intercepts on SVM.
>          */
>
Better, thanks. With that change,

Reviewed-by: Jim Mattson <jmattson@google.com>
