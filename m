Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923281;
	b=RyihA2gsY09ENeWJg4N55Swgq14ozqvM0+PNweaz1zIhv+x1CuvBoX18qeaqAHjFuiNY
	 O1bhzPbQ+5oCdURt8ln/49tk/xj1sQ+8mpKVoAUDbZxn1s1gTYPEG6O/gIY4Ouv/6w4Rn
	 eBN1NHPfWeOwVac/yhMGj09YwoE9BiFTeRcgOQ023IJvG+sNezuEWtD1n7uIqiF/qFoxq
	 yKMr/oTgU6aTMwhPW/4SkmJ6Qcwo9LF3nrZn8VMS2nl3FKe8Ymc4ZTkuqA6w0/o1uLzLc
	 /nnwSd1QVBQyMnIW41besUaXMq+d5OBOAnfq+4YmVNKizSCyo7dxah6XZFlNeV3wjew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923281;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:User-Agent:
	 X-Scanned-By;
	bh=14UVjjrtXaLimJ0dPNu2/7985kENti5IxkJtxTPyBa0=;
	b=Yanv0OoLuxSSDjVSUN4vGVBfSeaiYuHCtymn9ROhIL7w9+9qdUjUoFREyEWx+7On3N4B
	 lUBSICRPjxuS1V3fNPGdQIOIWRyaB+YMgqRvmEO7lEgDf5CvB8vCn1y4v+5pJNGTx2jAB
	 Ga7auZIE4cnOmsXdO2PnJN5yunjYW0z984OZxTu03/MscwIz2XCVuS7uy0M/+EWIyIRlE
	 cyLK/ki3Gkvtn+4pBfuyqrc/QILMXUjpMsoGxL/oBUALuA1mJODmmhKiSe8AvYXN5r6Hu
	 IGeSEdv9/KkN5iminnTNzHb5QcRyhKBZO27tPvQnwOmBc+iOL+K6usKmm6CxMNy/+Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UJdyEeCb;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389EE606A323
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 389EE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UJdyEeCb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794923281;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14UVjjrtXaLimJ0dPNu2/7985kENti5IxkJtxTPyBa0=;
	b=UJdyEeCb1WBsZNNLj0Ky64MxVtNrL7VHwcFklHCYcpWHQ+wjnuVcyI7577J/EGSvxo4tAJ
	HBImI2zGKsRgluBjbHOBMwfAMlS4mibLE3fkf+UUBkWJBDaorcCVi1cWhVTLjaj7kn7fYz
	yAvxm4ezsRSI4sObet2QbnKQbIqVQU4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-FK9GctNVNaKM8bEVmu_D4A-1; Tue,
 17 Nov 2026 08:47:54 -0500
X-MC-Unique: FK9GctNVNaKM8bEVmu_D4A-1
X-Mimecast-MFC-AGG-ID: FK9GctNVNaKM8bEVmu_D4A_1794923273
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C70B19560B3;
	Tue, 17 Nov 2026 13:47:53 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10F9518011D7;
	Tue, 17 Nov 2026 13:47:47 +0000 (UTC)
Date: Tue, 17 Nov 2026 13:47:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	kvm@vger.kernel.org,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Fabiano Rosas <farosas@suse.de>,
	Alistair Francis <alistair.francis@wdc.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 4/7] debug/mem: name pthreads
Message-ID: <avxbAf6FlGMthTCE@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20261116165002.30939-1-jsnow@redhat.com>
 <20261116165002.30939-5-jsnow@redhat.com>
 <avxapBFgrHUV3rfp@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avxapBFgrHUV3rfp@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Nov 17, 2026 at 01:46:12PM +0000, Daniel P. Berrangé wrote:
> On Mon, Nov 16, 2026 at 11:49:59AM -0500, John Snow wrote:
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  meson.build              |  8 ++++++++
> >  util/qemu-thread-posix.c | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 38 insertions(+)
> > 
> > diff --git a/meson.build b/meson.build
> > index d7bcb581c18..ef961df2f64 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2878,7 +2878,15 @@ config_host_data.set('CONFIG_PTHREAD_GET_NAME_NP', cc.links(osdep_prefix + '''
> >      pthread_get_name_np(pthread_self(), buf, sizeof(buf));
> >      return 0;
> >    }''', dependencies: threads))
> > +config_host_data.set('CONFIG_PTHREAD_GETATTR_NP', cc.links(osdep_prefix + '''
> > +  #include <pthread.h>
> >  
> > +  int main(void)
> > +  {
> > +    pthread_attr_t attr;
> > +    pthread_getattr_np(pthread_self(), &attr);
> > +    return 0;
> > +  }''', dependencies: threads))
> >  config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(osdep_prefix + '''
> >    #include <pthread.h>
> >  
> > diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> > index 089606c93fb..967e0f15f6d 100644
> > --- a/util/qemu-thread-posix.c
> > +++ b/util/qemu-thread-posix.c
> > @@ -17,6 +17,7 @@
> >  #include "qemu-thread-common.h"
> >  #include "qemu/tsan.h"
> >  #include "qemu/bitmap.h"
> > +#include "qemu/mmap-vma.h"
> >  
> >  #if defined(CONFIG_PTHREAD_SET_NAME_NP) || defined(CONFIG_PTHREAD_GET_NAME_NP)
> >  #include <pthread_np.h>
> > @@ -362,6 +363,13 @@ static void qemu_thread_atexit_notify(void *arg)
> >  
> >  void qemu_thread_set_name(const char *name)
> >  {
> > +# if defined(CONFIG_PTHREAD_GETATTR_NP)
> > +    pthread_attr_t real_attr;
> > +    void *pthread_addr;
> > +    size_t stacksize;
> > +    size_t guardsize;
> > +# endif
> > +
> >      /*
> >       * Attempt to set the thread name; note that this is for debug, so
> >       * we're not going to fail if we can't set it.
> > @@ -373,6 +381,28 @@ void qemu_thread_set_name(const char *name)
> >  # elif defined(CONFIG_PTHREAD_SET_NAME_NP)
> >      pthread_set_name_np(pthread_self(), name);
> >  # endif
> > +
> > +# if defined(CONFIG_PTHREAD_GETATTR_NP)
> > +    if (pthread_getattr_np(pthread_self(), &real_attr)) {
> > +        return;
> > +    }
> > +
> > +    if (pthread_attr_getguardsize(&real_attr, &guardsize)) {
> > +        goto cleanup;
> > +    }
> > +
> > +    if (pthread_attr_getstack(&real_attr, &pthread_addr, &stacksize)) {
> > +        goto cleanup;
> > +    }
> > +
> > +    /* Though there's a guard page, it isn't actually marked RO, so
> > +     * just label the entire region */
> > +    qemu_name_vma(pthread_addr - guardsize, stacksize + guardsize,
> > +                  "pthread (%s)", name);
> 
> On the one hand this code is pretty sketchy as it is making
> some assumptions about glibc allocating thread stack. On
> the other hand qemu_name_vma() is a no-op on non-Linux
> platforms, and we ignore fails, so we'll degrade nicely if
> any C libraries (musl) deal with thread stack differently.
> 
> I feel that glibc itself really ought to set the VMA name
> in response to pthread_set_name_np but I'm open to us doing
> this in QEMU though as I think it is safe enough.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

