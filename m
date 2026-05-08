Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942039D6D5
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278828; cv=none; b=qMiAex0AzjH/07u+w3ORLi4GU8ApiQBoiIoXS/A7F9U45AOcb2yqIxP47ChQiv51ryUGjpe5tRPQSD3TpuYd113Gd7A/OSQpxfCjyQph/NfeLjD0Suqg9bnGTgV1XRihwpo8pFqeNtIK8zKBLiWY4wFOoyI4bP4K3Qyl7AUvNBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278828; c=relaxed/simple;
	bh=4uFFv5MvAur3RLvJlpUt1T+THlEFP25FUijFCqNt23Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N4PSNPad5MgRiKpwAQ/1DOKFHKQMbSw3VrN9k+OopVqgQnA1jKzOjbqk1RkMK5b++6WfGTrRHLWQnzCkOpKLSjW9z2vX2rQSO9SzRh5ccZYG9wqmWX0R1zLST2Dkpvj+jnxTHr6lwReXnlAy0t+8HkGsh3J/8YqvMgu8mNC0ULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FWxg7kF2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWxg7kF2"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2baf7378ad0so9930315ad.0
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 15:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778278826; x=1778883626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbnJr8V3f4FccvTLLN48pS9vxFL7/axfr6qZXL890Pc=;
        b=FWxg7kF27NCp22cwRCYadQta4DPEfsWleJPwrEinQj/15dy2b3YETCsbOdWzjR/XJt
         GSXPwygqAMqfSpGUzkA4Zp8CgBG4aYcrLoZoO+HU8rHV11v/COSedMidDsQHPH6SBQgO
         BHVIHMGmCUIfBYa0lQQuItw4J7+nsWiuPg6PXOJ2e8eZu9s3rtj2m/VgJ1uU057scLd+
         Ah/U0bSys7X2yVqUjP2eV9cH8K6uQ1e7E88xTXW57G8hdyQPj+q3fkd6p3t7Ez1h+8tU
         DYQ7QV9PWU3T75WuozdJj2/6XZ/6hfqD7rDW0IucKGEvZU+Z+tAwl6V0CiJM0gsPbI/9
         nVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778278826; x=1778883626;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dbnJr8V3f4FccvTLLN48pS9vxFL7/axfr6qZXL890Pc=;
        b=H9xE3DoYAWhdzGDeQETyf7h45Ly9z0E1+5ucXHSy5bBQ5zJUqapCMNSkZNFUwms111
         fDhkZAPs/hrl8vH59Pjojeji2aDthi14ze3s/GaoBSVwVGZ4NE3dWunEE/3D/8KHhJRk
         MWR0a5fvs/uJZn00x086SkClV7WJPBkQjlMSilYx+S1CpNFglmUqsHsiZf1yj0lM3XGA
         ub+v4zwW8Itk4imhTtDHa9c9X8TqFpFV4gDpNtASOoZ5m7zN5CIXjH0UmhhjeNyBOpEY
         t2hg7D7fitvnDs105KwpNbMyPeyEAc7XnQwmN4Ku+9t1qTPMnCxvEUeBuQae77Ei35Or
         RY5w==
X-Forwarded-Encrypted: i=1; AFNElJ+eM7LW6m3mmAEfVuenNwNnmnLzow/W/NErdOobbNglYlMrNwn46/P5pOJBiTEsIkG9Aq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvBZIRmi/7mZheRCwO1+RBmT4nzhi383nMGrtpvd2O3OyG+R+3
	gQA3KENBWhxnv03mb1BT6Lq4C6qklJJEiqnr6cYj1bUE3d6xpoqzzn5tol3e/CNZbPLl1WVsYG6
	XyENoLw==
X-Received: from plbd11.prod.google.com ([2002:a17:902:f14b:b0:2b0:b1aa:e23f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3847:b0:2ba:77a6:1d4c
 with SMTP id d9443c01a7336-2ba798c2a93mr143912645ad.26.1778278825873; Fri, 08
 May 2026 15:20:25 -0700 (PDT)
Date: Fri, 8 May 2026 15:20:25 -0700
In-Reply-To: <CAAdrzjtvG2XrzjxFqGPOyiFL0QWeg-cY3TMdsj77ZdLivO8R1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414230943.41198-1-jrhilke@google.com> <20260414230943.41198-2-jrhilke@google.com>
 <af4oqOB-zXgVgkLf@google.com> <CAAdrzjtvG2XrzjxFqGPOyiFL0QWeg-cY3TMdsj77ZdLivO8R1g@mail.gmail.com>
Message-ID: <af5hqRVaI04EG019@google.com>
Subject: Re: [PATCH v2 1/1] vfio: selftests: Find devices that have VFIO
 selftest drivers
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2026, Josh Hilke wrote:
> On Fri, May 8, 2026 at 11:17=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Apr 14, 2026, Josh Hilke wrote:
> > > +# Print the segment:bus:device.function numbers of PCI devices that =
can be used
> > > +# to run VFIO selftests.
> > > +function main() {
> > > +     local vendor_device_id
> > > +
> > > +     for vendor_device_id in "${DEVICES[@]}"; do
> > > +             lspci -D -d "${vendor_device_id}" | awk '{print $1}'
> >
> > For ignorant people like me, it would be helpful to capture what device=
 was actually
> > found.  I mean, I don't necessarily know exactly what these devices do,=
 but as the
> > list grows, at least having a general sense of what device I'm going to=
 be feeding
> > into VFIO would be helpful.
> >
>=20
> Sure I can do that.
>=20
> > # ./devices.sh
> > Intel SPR DSA (8086:0b25) Device IDs:
> > 0000:6a:01.0
> > 0000:6f:01.0
> > 0000:74:01.0
> > 0000:79:01.0
> > 0000:e7:01.0
> > 0000:ec:01.0
> > 0000:f1:01.0
> > 0000:f6:01.0
>=20
> How about a "-v" (verbose) option which prints the device name
> alongside the BDF?
> Works for me. =20

> $ ./list_devices.sh -v
> 0000:6a:01.0 Intel SPR DSA (8086:0b25)
> 0000:6f:01.0 Intel SPR DSA (8086:0b25)

Maybe add a dash to visually separate things?  E.g.

  0000:6a:01.0 - Intel SPR DSA (8086:0b25)
=20
> This approach preserves the ability to pipe the script output into
> /tools/testing/selftests/vfio/scripts/setup.sh to automate binding the
> devices to VFIO by excluding the -v arg since the setup script expects
> a list of BDFs.

Alternatively, -q for quiet?  Or:

  ./devices.sh | cut -f 1 -d ' ' | setup.sh

Or have setup.h do the cutting?  I'm a-ok with a -v, but if the script is m=
ostly
going to be run by humans (no idea if this is true), it seems like it shoul=
d use
the more verbose version by default.
