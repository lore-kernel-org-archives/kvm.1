Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB7D392C32
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140583; cv=none; b=j+Vb2NUl3IiHH9JWhVWSm+H4Bp4evPkuBNhrY3xtOFMhJMFNmqdNhmTl5+palL242CSJb34z9DQWgxP0ViQ7qZjHCN9Dl7b82wF6CfWNn+o8+gz2odVjDXJ3IrZ5fnmSWd288vmkkqebURxSksdo+F735J54kbe9NhIxiy6gINs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140583; c=relaxed/simple;
	bh=RvCbP2n0Dm4RAtx7BwIh/SDybR2vfj2oNhoieR6sY5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAWWAcQmcI8Zdbjd3EH0YLb88fy6RakzWVYLArMOZZP/8v5gm0ID8I8HJvL0O7LuAteXWCJ6EYg1+IrakEQ1mcCP1qOtiR+/pIjfDO9F7wWaph8qfYXPO1ReZhd07mMv3dJ8C1QZMSoRHLSdenv0LZ1NiADNaDuEaSImtNxjhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1Gs5tIZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1Gs5tIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785140579;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6lOAHrr1Dw2w/S0fTULvS6UvPR8X5P8fRAdv/0dmbxQ=;
	b=P1Gs5tIZeiaACN1dfrKsdJZlDCX/nmuFUCAafA2+Nz9JKmtvPD+1RLKyoaf0kJQaKAJF6C
	sRsz7IeLn+Jtpw2Ko6SHcq5ONfwvH6hAIN1RCl2m+yFMyjnHhdoXt3iaN1qVrOhaL0c1dy
	NfeWtM6YWVHTQRhQadACYkXtX8u857Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-K8_tC54rPRmlHLiiIGIOig-1; Mon,
 27 Jul 2026 04:22:55 -0400
X-MC-Unique: K8_tC54rPRmlHLiiIGIOig-1
X-Mimecast-MFC-AGG-ID: K8_tC54rPRmlHLiiIGIOig_1785140574
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF842180135F;
	Mon, 27 Jul 2026 08:22:53 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.196])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16673429;
	Mon, 27 Jul 2026 08:22:50 +0000 (UTC)
Date: Mon, 27 Jul 2026 09:22:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 2/5] ui/vnc: fix OOB write in vnc_refresh_lossy_rect
Message-ID: <amcVV5g4ENihVXpk@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-2-4b83a70e9f3b@redhat.com>
 <f83491f5-6ef7-45ba-bb84-26341835cb25@tls.msk.ru>
 <CAMxuvaxUWc=Qr9pQQ6wW6XnAzp4mf77aYpcFuXvret1KL_W9kA@mail.gmail.com>
 <0b2bf915-d2d5-4a21-8ee1-d11427476d40@tls.msk.ru>
 <CAMxuvaxU3HJwkyvD0WtifFCMfcivNiUTK4U9Yg0j7cpc5LXLaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaxU3HJwkyvD0WtifFCMfcivNiUTK4U9Yg0j7cpc5LXLaw@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Sun, Jul 26, 2026 at 09:53:05PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Sun, Jul 26, 2026 at 9:14 PM Michael Tokarev <mjt@tls.msk.ru> wrote:
> >
> > On 7/26/26 20:07, Marc-André Lureau wrote:
> > ...>> Unfortunately this (additional) fix does not mention the
> > >> previous fix, so there's some confusion about which commit
> > >> actually fixed this issue.  It looks like the first fix was
> > >> incomplete and this additional fix were needed.
> > >
> > > That's correct, we reused the same CVE
> > >
> > > Daniel P. Berrangé said on the issue:
> > > We didn't release master yet. As long as we also didn't release any
> > > stable branches that claimed to fix it, we could re-use it IMHO.
> >
> > Heh.  This is exactly what actually happened - there were
> > 2 stable releases on Jun-25 (v10.0.11 and v11.0.2) which
> > contained the first half.  Now there are 2 more stable
> > releases from Jul-24 which contains the second half.
> >
> > Unfortunately I haven't noticed this duplicated CVE#,
> > or else I'd add a note to the second half in the stable
> > pick-ups.
> >
> > I know you don't like me rushing things to the stable
> > series, and this is an example why this might be bad.
> > Fortunately this is not a regression, at least.  And
> > usually security fixes come in faster anyway.  Ohwell..
> > I'm sorry to disappoint you further.
> 
> for the record, I do appreciate your work, and I make mistake too :)
> Next time I'll check if a release was made already with the CVE#

Or we just declare a strict "never reuse a CVE once a patch is
merged to master" rule.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

