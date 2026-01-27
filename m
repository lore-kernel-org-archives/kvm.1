Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230130C366
	for <kvm@vger.kernel.org>; Tue, 27 Jan 2026 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512659; cv=none; b=DV+pVS15hOXIwJk4RXdutaIVdRUpLegbCozw8LkwBCR+mQ/nw4m9Wr7ikXYEaVsM37s5isJIa0gEjYomC8RBvNRcuGvALiwkwuq1LXpB4kFyG9IkmdcHUVSYyQTxqSazhB7an7x7unrp8L5JRpXM8LWonwFCTD12HdzMrsN99PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512659; c=relaxed/simple;
	bh=F7qUAxjxHiziwsYsZS48VwCHNig9BbM/YJ7Dq6D7M/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPZ3a34Fj7R/SKW4tNfAAR89O7sueu49I1CqsX9V9yM1SJc4bNCofctfGYnK3Fwa7zxKgv/wy9DlPhUrgP8eACVdQ4+27JIwXCkQMKT1c8KTMJ35gPVkBDvQmBwZHDSZK7xQZse5KxLrvDzO/fdNcb2rQfQBU0TOoHat337akQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duhR2kaH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duhR2kaH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769512656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOjAJfProoCB2ZNiIiBQqNee8INRqMIJyl6k7o/1Yck=;
	b=duhR2kaHIbQsj9nhin1VdTvrwZjMSy/mbe5xj0dT4AzzjQerewdzYQzOp8EhhIzx31u83p
	/vET8rFAmZNTXU2sWDLNE14QENpEcezNQ498aK+n0pJpIS4iyd7XZwUHHp8/KCUrFn/0qS
	ml/ATPn2PiE6uxdGzER2CGid4+OEbeY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-OKvb0TYSNTCqXyALnCoBFA-1; Tue,
 27 Jan 2026 06:17:33 -0500
X-MC-Unique: OKvb0TYSNTCqXyALnCoBFA-1
X-Mimecast-MFC-AGG-ID: OKvb0TYSNTCqXyALnCoBFA_1769512652
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBE8A1955D84;
	Tue, 27 Jan 2026 11:17:31 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.149])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8FCE180009E;
	Tue, 27 Jan 2026 11:17:25 +0000 (UTC)
Date: Tue, 27 Jan 2026 12:17:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
	=?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
	Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
	Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Thomas Huth <thuth@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Alex Bennee <alex.bennee@linaro.org>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: Modern HMP
Message-ID: <aXiewxB60hasi49R@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <871pjigf6z.fsf_-_@pond.sub.org>
 <aXH1ECZ1Nchui9ED@redhat.com>
 <87ikctg8a8.fsf@pond.sub.org>
 <aXIWLi656H8VbrPE@redhat.com>
 <87ikctk5ss.fsf@suse.de>
 <aXJJkd8g0AGZ3EVv@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXJJkd8g0AGZ3EVv@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Am 22.01.2026 um 17:00 hat Daniel P. Berrangé geschrieben:
> > Does the new program becomes basically an external project unrelated to
> > QEMU, that simply talks to QMP like libvirt does?
> 
> It could be a separate project under QEMU on github, or it could just be
> binary in qemu.git. What matters is that it is out of the main QEMU process
> eventually.

I think the basic requirement for any HMP replacement is that it just
works, i.e. no manual setting up of sockets etc. like for qmp-shell.

If it's an external process, QEMU should just launch it automatically,
and the user interface should still go through the usual chardevs so
that the current backends still work and the default of '-monitor vc'
can be retained.

(Of course, once this plumbing has been done, it could be reused for
qmp-shell to provide a nicer and more integrated option there, too.)

This pretty much means that it has to be in the same project, or at
least a subproject that is automatically downloaded when building QEMU.

Kevin

