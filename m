Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E93570D5
	for <kvm@vger.kernel.org>; Thu, 22 Jan 2026 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078368; cv=none; b=hitStlgK7XrCTTIaAXgxbk3uxlm+63/RQxeVvyVOX1rL2r3vjgU+t1KRlUUQiEQkc0TJ2+H72RcgQXCT+gR7y1Vr1QneOY54MLnmNYVziKNky36RlkILOKUhXC8WWh4pzKwhzBgZDSTnZip2dJ1YsX+cUUgCo0n/defaCvMunFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078368; c=relaxed/simple;
	bh=kTkn9dKFxK78ry+E5IsJ53+woTbpn56g+SaHZqO+i0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY+W+OGu5lRxJL+um3EcQyaSf23yWtkMxGpYtXTccGGNn3BVZClWVFvcLW3liDBQjna/e4hAHkTyR6CU2GfaqjuhpUMg578NRq95HMnVNQmUHl411Lo9BZzak8O9Zswirtl0v2qCbSO+wWcLK8tt1D6DWSFHzUB35EjacjhKo0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcPe8NDC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcPe8NDC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769078365;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGdv90XXh8msA511nPdVamGcuIccPguss5F3Ju7xRJU=;
	b=VcPe8NDCfcRINncYQLfip1yysrcxw6tiE3ZD9JrC5qV71QpG8QkwJ1VXcHb9mth7N6Fsev
	/LsVFrTIDT0Ly3VQotcqHxSuWJibGDW14EV9GlQgcSbvC9/+1837T1GlQlCPAAkOBBw0yx
	hu4Q/sLXgdK7blSqCwLaeS8KoR1Y6dI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220--YW5eXeRM8iMGNXAJN6c8w-1; Thu,
 22 Jan 2026 05:39:21 -0500
X-MC-Unique: -YW5eXeRM8iMGNXAJN6c8w-1
X-Mimecast-MFC-AGG-ID: -YW5eXeRM8iMGNXAJN6c8w_1769078360
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DBE81800378;
	Thu, 22 Jan 2026 10:39:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38F4B1958DC1;
	Thu, 22 Jan 2026 10:39:13 +0000 (UTC)
Date: Thu, 22 Jan 2026 10:39:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
	Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Alex Bennee <alex.bennee@linaro.org>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	John Levon <john.levon@nutanix.com>,
	Thanos Makatos <thanos.makatos@nutanix.com>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: Call for GSoC internship project ideas
Message-ID: <aXH-TlzxZ1gDvPH2@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jan 22, 2026 at 02:22:28PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jan 22, 2026 at 2:14 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Jan 20, 2026 at 04:42:38PM -0500, Stefan Hajnoczi wrote:
> > > Hi Marc-André,
> > > I haven't seen discussion about the project ideas you posted, so I'll
> > > try to kick it off here for the mkosi idea here.
> > >
> > > Thomas: Would you like to co-mentor the following project with
> > > Marc-André? Also, do you have any concerns about the project idea from
> > > the maintainer perspective?
> > >
> > > === Reproducible Test Image Building with mkosi ===
> >
> > > This project proposes using mkosi to build minimal, reproducible test
> > > images directly from distribution packages. mkosi is a tool for
> > > building clean OS images from distribution packages, with excellent
> > > support for Fedora and other distributions. It should be able to
> > > produces deterministic outputs.
> >
> > Aside from what I mentioned already, the other issue I anticipate
> > with mkosi is the mismatch between what hardware QEMU needs to be
> > able to cover, vs what hardware the distros actually support.
> >
> > Fedora in particular is pretty narrow in its coverage. Debian is
> > considerably broader.
> >
> > Neither will support all the QEMU targets, let alone all the
> > machine types within the target.
> 
> 
> That's right, the goal here is not to cover all possible images though.
> 
> I picked Fedora here as an example, because it is the best supported
> distribution in mkosi.

IMHO to be worth the effort of integrating mkosi *and* maintaining its
use in QEMU long term, it has to address a broad set of problems that
we face in the functional tests.

IMHO the inherant dependency on distros is the underlying problem
we have, as we try to achieve testing coverage across all the
machine types in QEMU.  It leads us to having a random selection
of different approaches, and mkosi does not look like it will
reduce that problem, or help us fill in the gaps we have.

> > While there is value in testing a full blown OS image, IMHO,
> > for most of what we need it is considerable overkill, and
> > thus makes functional tests slower than they would otherwise
> > need to be.
> 
> mkosi can produce initrd images, which can be small enough and
> customizable. Although I lack the details of what is possible, this is
> part of the project research.
> 
> Imho, building all images from scratch cannot be sustainable.

I'd say the opposite - relying on distros, whether using mkosi
or not, is not sustainable.

Once we have written some scripts that can build gcc, binutils, linux,
busybox we've opened the door to be able to support every machine type
on every target, provided there has been a gcc/binutils/linux port at
some time (which covers practically everything). Adding new machines
becomes cheap then - just a matter of identifying the Linux Kconfig
settings, and everything else stays the same. Adding new targets means
adding a new binutils build target, which should again we relatively
cheap, and also infrequent. This has potential to be massively more
sustainable than a reliance on distros, and should put us on a pathway
that would let us cover almost everything we ship.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

