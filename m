Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2134752B
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 05:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500740; cv=none; b=Uf4L6CC/dsth8/w/9RfWlKElJt8vVP9WbYh8lfTL3wX9pNumuNl912jRKCW04EuolKL3bzuDAM6bbGTjDSU80QnidDCTv7bdNg4vQpX4l2d2hH7DhIOLB/3NEiyHwTcHSoPQPaBlKyVcUBurmdzjAy9Q5sE/LG+pSirJOpbkZkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500740; c=relaxed/simple;
	bh=B73boCMNRz9eQScrXS9asoIvCbV6OOGH4mI8j0mlsy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRdJt5nyRFdDPu8RkDh3JQpyTv/7qgYadyyW5GWQecyv70jUd5b7fr6WCpn9ppaQqKWXUVjcb1IASqc+ETTBk0fBGCTrTkqDPtzIHJU3CtUIWVRQX4vs4WRXmtqu+V8gPk6/YqUHBS2MKQKSZ2UjNcOfC8VNrREOZ+B70m8CVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vvqr5089; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vvqr5089"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788500738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nTotYGPu90JhCnYNifYML+HWUdaK6vkzUYREYlvxQ5M=;
	b=Vvqr50890suga2QbxopBPe2w6mtda2etkZWK5UaMD8rm6Zn6k25sXb6VY5zRfeuR2dsFAM
	Vex5Q88bzBJOOfIA3fS+hogTbFvzhhBaSM5FtjTuFlWzgQPxGH1TnR3iVP0fC6ik8d4BQL
	EhuE5DLtPz4vkGJnhj3vjftKdj3oIxE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-zW7PY-abNOWSJpRh2eTr8g-1; Fri,
 04 Sep 2026 01:45:34 -0400
X-MC-Unique: zW7PY-abNOWSJpRh2eTr8g-1
X-Mimecast-MFC-AGG-ID: zW7PY-abNOWSJpRh2eTr8g_1788500733
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42E451954227;
	Fri,  4 Sep 2026 05:45:33 +0000 (UTC)
Received: from ghoffman.nuc.csb.home.kraxel.org (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9401D1800598;
	Fri,  4 Sep 2026 05:45:32 +0000 (UTC)
Received: by ghoffman.nuc.csb.home.kraxel.org (Postfix, from userid 11758)
	id 692B34006269; Fri, 04 Sep 2026 07:45:29 +0200 (CEST)
Date: Fri, 4 Sep 2026 07:45:29 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
	qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
Message-ID: <appYz1617QTPH-Qf@ghoffman-na.rmtde.csb>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
 <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
 <apk1djopa9z3tfYR@leonardi-redhat>
 <CEF80B59-E81A-4B97-87E5-9087FAF3680B@redhat.com>
 <aplQKjieyMHUoCWs@leonardi-redhat>
 <aplfB4L_WoFdpeBD@redhat.com>
 <aplz6Wvb-IhgUJ59@sgarzare-redhat>
 <apl3wnsHORCNP4k-@leonardi-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apl3wnsHORCNP4k-@leonardi-redhat>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

  Hi,

> > > If the user choose to override policy on the CLI, isn't it now just
> > > their problem to also figure out what the new expected measurement
> > > will be ?
> > > 
> > > Why wouldn't we just honour the IGVM by default, and if the CLI
> > > has further customizations let them override the IGVM, and leave
> > > the user to figure out the implications.
> > 
> > I also slightly prefer this behaviour too, I see some advantages,
> > especially for testing and debugging, where you don't want to regenerate
> > the IGVM. But I don't have a strong opinion on this; if there is a
> > mismatch, though, I agree that it's better to get an error than to
> > ignore the CLI.
> 
> In this series, if there is a mismatch between IGVM and CLI, QEMU returns an error.
> Debugging sounds very reasonable to me, so I'm fine on letting the CLI override IGVM.

qemu should flag this mismatch in any case.  Either throw an error and
exit, or log a warning and continue.  Given that changing the policy
changes the launch measurement I'd tend to prefer an error.  If people
see value and real use cases for policy overrides I'm fine with a
warning too.

Silently accepting the override is IMHO not an option.  We had enough
problems with qemu silently doing things not expected by users in the
past.

take care,
  Gerd

