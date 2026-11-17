Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923188;
	b=LMY1SBhLFrVQOvDbOxLSwx7ZtDwtd0v5TGjtN12sh8R67MyCadkJKijOXHbz7mUPmAov
	 EnTYqpW0DDnwETHTeTkXJBGXeqyyduq7UBtja1C0zLghifPrG9ZIUvEg5IfEzOojJ8QQI
	 4eQMiwWFvmVcJNu8YL+fG81lptPJcqVf+Zb9+c2/xobAO1FpR1WRiz42UFSQVo0FzxUGY
	 GB39fGO/dGYo9Q/qOMoNKgLKYkV6JLTgAQWgrh8+z9Dhfq8LJx13o89XIPsSHa18Ht9Fh
	 9rsL4sRdXuP7Dd/jLQ6/MzaOa0AppCjz3NXOpddse14c4S1steA20YSIG0a8FQ3fBRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923188;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Scanned-By;
	bh=zCdDseB5r1faGh+gAHeyv5s6L8eJiOqr6GmJ8La+WIY=;
	b=o3A+MUgFakz/gAslwajUimy9GINQ1RA7h4d3qcImG87ayWpoqI4ckGmpVQjZXua48rWN
	 6kIm4FEhngktrpYMwXr+va0O4dZWyC4/2sJ6lufzp/3mEyDARxPC0TRhDq4aP4taQB4XU
	 L0YzuVZ9Cx/f1Fo1RJ009F8wouvtS+C+vurB0cgcFc07UcXFGxZf7ssgc5Rx49DzTsYE+
	 lZVhsibIWqytq5YUepd+DVXiejj7nfyoK6frqXLbj/5b1WMEWmWUaD0A2XOZyE8D+uEgr
	 5+I001bUp4f3pElEn3nHw/UHOIasgtmmtYk5HvMx1V37eVByI+2Fg8iGvzfUi8IgXBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F8gWs2hZ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B267606A329
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B267606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F8gWs2hZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794923186;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=zCdDseB5r1faGh+gAHeyv5s6L8eJiOqr6GmJ8La+WIY=;
	b=F8gWs2hZs1CQWwOEmkkXQuQn7InyaJFfLnjf3NwQf5xmcDWY/tfNvpDXhRKoyAHUMpJDLW
	MXH6jOi8oLK9ymLawMPSAJhGoQPEEG4hXvqTrSkSZDJkVMMVdGb3X84JCeZA/KnnoETnyD
	x0TS8CBdHtwFUaGkp8Iya9YdD3viv7w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-xT1EP6VNP8KRVrb82RUGcA-1; Tue,
 17 Nov 2026 08:46:23 -0500
X-MC-Unique: xT1EP6VNP8KRVrb82RUGcA-1
X-Mimecast-MFC-AGG-ID: xT1EP6VNP8KRVrb82RUGcA_1794923181
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E369E1954B08;
	Tue, 17 Nov 2026 13:46:20 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C9A1428;
	Tue, 17 Nov 2026 13:46:15 +0000 (UTC)
Date: Tue, 17 Nov 2026 13:46:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,
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
Message-ID: <avxapBFgrHUV3rfp@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20261116165002.30939-1-jsnow@redhat.com>
 <20261116165002.30939-5-jsnow@redhat.com>
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
In-Reply-To: <20261116165002.30939-5-jsnow@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Mon, Nov 16, 2026 at 11:49:59AM -0500, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  meson.build              |  8 ++++++++
>  util/qemu-thread-posix.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index d7bcb581c18..ef961df2f64 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2878,7 +2878,15 @@ config_host_data.set('CONFIG_PTHREAD_GET_NAME_NP', cc.links(osdep_prefix + '''
>      pthread_get_name_np(pthread_self(), buf, sizeof(buf));
>      return 0;
>    }''', dependencies: threads))
> +config_host_data.set('CONFIG_PTHREAD_GETATTR_NP', cc.links(osdep_prefix + '''
> +  #include <pthread.h>
>  
> +  int main(void)
> +  {
> +    pthread_attr_t attr;
> +    pthread_getattr_np(pthread_self(), &attr);
> +    return 0;
> +  }''', dependencies: threads))
>  config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(osdep_prefix + '''
>    #include <pthread.h>
>  
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 089606c93fb..967e0f15f6d 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -17,6 +17,7 @@
>  #include "qemu-thread-common.h"
>  #include "qemu/tsan.h"
>  #include "qemu/bitmap.h"
> +#include "qemu/mmap-vma.h"
>  
>  #if defined(CONFIG_PTHREAD_SET_NAME_NP) || defined(CONFIG_PTHREAD_GET_NAME_NP)
>  #include <pthread_np.h>
> @@ -362,6 +363,13 @@ static void qemu_thread_atexit_notify(void *arg)
>  
>  void qemu_thread_set_name(const char *name)
>  {
> +# if defined(CONFIG_PTHREAD_GETATTR_NP)
> +    pthread_attr_t real_attr;
> +    void *pthread_addr;
> +    size_t stacksize;
> +    size_t guardsize;
> +# endif
> +
>      /*
>       * Attempt to set the thread name; note that this is for debug, so
>       * we're not going to fail if we can't set it.
> @@ -373,6 +381,28 @@ void qemu_thread_set_name(const char *name)
>  # elif defined(CONFIG_PTHREAD_SET_NAME_NP)
>      pthread_set_name_np(pthread_self(), name);
>  # endif
> +
> +# if defined(CONFIG_PTHREAD_GETATTR_NP)
> +    if (pthread_getattr_np(pthread_self(), &real_attr)) {
> +        return;
> +    }
> +
> +    if (pthread_attr_getguardsize(&real_attr, &guardsize)) {
> +        goto cleanup;
> +    }
> +
> +    if (pthread_attr_getstack(&real_attr, &pthread_addr, &stacksize)) {
> +        goto cleanup;
> +    }
> +
> +    /* Though there's a guard page, it isn't actually marked RO, so
> +     * just label the entire region */
> +    qemu_name_vma(pthread_addr - guardsize, stacksize + guardsize,
> +                  "pthread (%s)", name);

On the one hand this code is pretty sketchy as it is making
some assumptions about glibc allocating thread stack. On
the other hand qemu_name_vma() is a no-op on non-Linux
platforms, and we ignore fails, so we'll degrade nicely if
any C libraries (musl) deal with thread stack differently.

I feel that glibc itself really ought to set the VMA name
in response to pthread_set_name_np but I'm open to us doing
this in QEMU though as I think it is safe enough.

> +
> + cleanup:
> +    pthread_attr_destroy(&real_attr);
> +# endif
>  }
>  
>  typedef struct {
> -- 
> 2.56.1
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

