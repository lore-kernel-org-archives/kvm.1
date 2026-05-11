Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9293CF660
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515967; cv=pass; b=R3Uw6k/l+f/ODLGf3nj3p7/nSO1vhst3ccOaDz/RBP2YHfXAz2ANOYmM7QVod8FxTrjTQOneTec/x5KrtoEu+Ps8gZm4Pwb075L1GHtdeJbvNzDMm8yGb6Jy8EMjO9TuIR2VNb4PweR0JLx7ekmIsrCHtVVDTyWTCrLb0VJXN6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515967; c=relaxed/simple;
	bh=ErZWr3wkhTCS0rgDSDnZN3J2yBKYi0K22iPd6Jyuuyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzeT1URllXIi1llz3ZrBsgt92gvDOunAnHF31bA+sWFWPFpZ+ONB71HAW7h/6dF7W/gK15MY+dpPgSSxTl9hNzTEt+Q0onqQ6rd8qWckkC4lS+VtnGdBLCFhKUD+mND+rS2yLbG8aYhKdNgCQsaLKRfu21raINhuVOaGw1/fn5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BsY3xL7K; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BsY3xL7K"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50e61648f10so1561cf.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 09:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778515964; cv=none;
        d=google.com; s=arc-20240605;
        b=JDZKW6oPAgiKt/886bUweFUIfUNzYylMEwwSQ5CTw5a3ekfncljCLZFRrfPYhX+0vg
         6Oxcz+Cq2oeOmICgLfk0vfoCICEEyw2sqCIikbsTE04Dye8nDuzumJJX5Q9cWKsd1GSl
         308zS7mnLvYvMLJVaaMP8Ka/6rpJuNn4mQHbU7fEFPUX9zdifRb0XpH4fjGDHda9/MwL
         tbPSj2uJhFENnGx9jFEm2TZmnC90i60PtNLkx0R7SWrh0cDvQ28SesP7YPUSd9e42dft
         /QtXJYa9+0NEwjQ0bQLWQkyEjm60G2Kc9bMvFiBoInDsaV71yqp1bny/UYh6LzimdfvF
         8B2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4rNfhoFx9xojUGq9ciF+uUtzvbjXhUhlWCaPwy7RkMg=;
        fh=+FU6X/LPcxLErLrq9MDiZ1DwjROzV5NlzUkF4Oz+nYM=;
        b=XSiNkuaurC6bYgK5st1t1FQXN2bFC5MWkQ1LYxY2C+O9PZp2dkAicxievtcKG997LN
         NcrYy0KCKZPTMA+pdauCMtmtZeOpx5ICAtAe9d5Buboets87kKcCgh7eSYRyr1y1F1w0
         Uwp6UXf+3s+ovlqlG5nKFYdWJotFMtjX/LZDGYAZgJbMJXCBj9EMQivrHRX/WXTXYjR7
         MIbYkfxGoyVIN9hFIlvZOglQm6JPTxCCUqECxAlznH+aAdO4VSWNwuSFOCmdfzIK+kW6
         gZXgTk6ka+clc96+gUSwvPKUXkF5Gn7ijHuiSGas7PwcAN9BVXPxl8FpXnilqjyxdHfM
         pG7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778515964; x=1779120764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rNfhoFx9xojUGq9ciF+uUtzvbjXhUhlWCaPwy7RkMg=;
        b=BsY3xL7KNfed7qCjiaWgQLxa2WsUD/BoD8spWpMVUUT5VXadwaz9ZuXIYNIpIwoqur
         iWJTHcp05rm+mM1pGMf/Xq1dqr+WyMRFUxj3EnPsalldJElb1XGtLgCUd6s/naeC+lAQ
         FuW5oQZq6/BoGFvZPjwonfc7ntsNg0IH13GXVCLosTq9B5RL25ynDc9Vx8faGkiEI7j+
         ICJ814Hr0mBcsiITLa6hE6HRxrmw4Zv2ocOnUVImssZIP0lcANa5zvkRB5DHpHnRZ+MI
         kAVGA9ceDLrH3fV8N3yCFl77hKZi2QJv6Rn63SwEvho7yQX+gzt+bLM1EZTN73C/THW3
         Zc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515964; x=1779120764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4rNfhoFx9xojUGq9ciF+uUtzvbjXhUhlWCaPwy7RkMg=;
        b=UwEF/pzQHkEdXHWFosNdBdtGIzY0KWG7MxbG52ja6v7aQ/q66NZ9eNtnN2wiojfIhz
         XK9bdYghcf9Nteh5KnQwaZEYH0OfoifjkyGe87mQHNXDW4npQVokrBdmtO2mvCElmb5O
         H6l18MRvNvK2TkSbLv1oiZbEfMluFAOUqnt+U2nLg6c8K7Qm274KnqC4dkBROLv5fJHz
         IyWbC6Y49IGdTHYtWJibVYkcHEflHJVzkS6V10yp08JQDITXdE0PB3k3isQdYrB9qU/g
         H+EuOp7c0dXHwWDTOFZvj2VZJ4AWnhN67JsP0KFGm7HgBCqKk6smnE2+T5emeSLA86fU
         gErA==
X-Forwarded-Encrypted: i=1; AFNElJ+Zbn716GliTBFQpWRp8Ag9RgZhxHp1R0zGb4MVHrPIyrRe6AnZqWYev/WbofWpwcuzfLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/6mxqB1vvgfiA5Gp+4u2HqVT5UuN5FV8LwDe9A6ekM7bCO4BK
	LvQz2GeUEC31ZaX+bi07hxT/EjMkwFtu4bEetbPPNjhwI96UQUm8nqAmB22sq4ElAkrwMJIYsFr
	sGYuAD2LXqNeYTTdfvL8l2Qsnv8ArROvUCfF9ZB4=
X-Gm-Gg: Acq92OFKsgawVAlh04zEVtaFewga35q3YacVBYu2eZKqpUoegIdCMDgROmafi5NgMhk
	3ftglcrLv/R2z8kMt66vkMdVja1Wbm1Fv9O9W5R/71t6rdQlDxVFcZM3wyZgRUeAkqhvh+FVquZ
	LKQ/y5oftdBgpi/VWlbBQa7nG6srYMqIgAgG+rQgeDbfc5vx+DRqDOvONWKHjnK6BzjOo18Iisk
	81UVpQpjdz05zKCto5Not/kSXo/JsWmd049NTltq5fIWeYu6p0gIRHR3wQ0aywvT2zXaT4mZnHW
	Y48a1VS43txsow==
X-Received: by 2002:a05:622a:4c12:b0:50f:bea3:9485 with SMTP id
 d75a77b69052e-5149f2aa66amr32297791cf.2.1778515962359; Mon, 11 May 2026
 09:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414230943.41198-1-jrhilke@google.com> <20260414230943.41198-2-jrhilke@google.com>
 <af4oqOB-zXgVgkLf@google.com> <CAAdrzjtvG2XrzjxFqGPOyiFL0QWeg-cY3TMdsj77ZdLivO8R1g@mail.gmail.com>
 <af5hqRVaI04EG019@google.com> <CALzav=fhgJwdk512Xzr94woo_7JsOwNNZs-E43HOP6+e0sda0A@mail.gmail.com>
In-Reply-To: <CALzav=fhgJwdk512Xzr94woo_7JsOwNNZs-E43HOP6+e0sda0A@mail.gmail.com>
From: Josh Hilke <jrhilke@google.com>
Date: Mon, 11 May 2026 09:12:29 -0700
X-Gm-Features: AVHnY4JKv7wXd1j7JX5SdHHGr0ywcROEE4fu7h3gMwCdMq91MHBf3ViFowG1qpQ
Message-ID: <CAAdrzju9p4tcTXh6OFJtwnphUAM__=CG0qbTaNa3gMxgLFMiag@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] vfio: selftests: Find devices that have VFIO
 selftest drivers
To: David Matlack <dmatlack@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Alex Williamson <alex@shazbot.org>, 
	Vipin Sharma <vipinsh@google.com>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 3:50=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> On Fri, May 8, 2026 at 3:20=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Fri, May 08, 2026, Josh Hilke wrote:
> > > On Fri, May 8, 2026 at 11:17=E2=80=AFAM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > On Tue, Apr 14, 2026, Josh Hilke wrote:
> > > > > +# Print the segment:bus:device.function numbers of PCI devices t=
hat can be used
> > > > > +# to run VFIO selftests.
> > > > > +function main() {
> > > > > +     local vendor_device_id
> > > > > +
> > > > > +     for vendor_device_id in "${DEVICES[@]}"; do
> > > > > +             lspci -D -d "${vendor_device_id}" | awk '{print $1}=
'
> > > >
> > > > For ignorant people like me, it would be helpful to capture what de=
vice was actually
> > > > found.  I mean, I don't necessarily know exactly what these devices=
 do, but as the
> > > > list grows, at least having a general sense of what device I'm goin=
g to be feeding
> > > > into VFIO would be helpful.
> > > >
> > >
> > > Sure I can do that.
> > >
> > > > # ./devices.sh
> > > > Intel SPR DSA (8086:0b25) Device IDs:
> > > > 0000:6a:01.0
> > > > 0000:6f:01.0
> > > > 0000:74:01.0
> > > > 0000:79:01.0
> > > > 0000:e7:01.0
> > > > 0000:ec:01.0
> > > > 0000:f1:01.0
> > > > 0000:f6:01.0
> > >
> > > How about a "-v" (verbose) option which prints the device name
> > > alongside the BDF?
> > > Works for me.
> >
> > > $ ./list_devices.sh -v
> > > 0000:6a:01.0 Intel SPR DSA (8086:0b25)
> > > 0000:6f:01.0 Intel SPR DSA (8086:0b25)
> >
> > Maybe add a dash to visually separate things?  E.g.
> >
> >   0000:6a:01.0 - Intel SPR DSA (8086:0b25)
> >
> > > This approach preserves the ability to pipe the script output into
> > > /tools/testing/selftests/vfio/scripts/setup.sh to automate binding th=
e
> > > devices to VFIO by excluding the -v arg since the setup script expect=
s
> > > a list of BDFs.
> >
> > Alternatively, -q for quiet?  Or:
> >
> >   ./devices.sh | cut -f 1 -d ' ' | setup.sh
> >
> > Or have setup.h do the cutting?  I'm a-ok with a -v, but if the script =
is mostly
> > going to be run by humans (no idea if this is true), it seems like it s=
hould use
> > the more verbose version by default.
>
> Let's do -q. That makes the default (no arguments) usable by humans.
> For scripting, it's easy enough to pass in -q.

-q sounds good to me. Will do in v3.
