Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252898;
	b=NCgCa6DcrSr6qUjSc1yQFL4RNEV2Po9jxMDyGBWtDIkO+yL8bZ02sJTkUnHXZD5df+Z+
	 /lUG9xQoLVzd1CudExe3/f9Bt4k4M+bbU4gBJaXWaTPoyFlQ9vnZFH0OV2AWzvRs4kEby
	 K+JaGyJXUeRgFJ7E2ZhwFWl6oirV6gXv2WyKTkQ/NukujRGKp+9me8KSWtwMilRi2rwNL
	 U+GI76zwpvWOHtRWCP/uWiovsBb3bdnhvcHI2RaKYJvrJ0WVzRAgyuCpB3aW6GwAuornw
	 reuTTyYRzlvpHcz02nXi7Yjt4gDFayygZppZNOyZwaxJvkvQDNCk2KknWi3A6LmHH6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252898;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Scanned-By;
	bh=m5DQOa03jNTEqGq+HMzcF7pBiVnfF3leM3KBwbxc4uU=;
	b=Oq67+QN1QAfihu6FE50V3XTPkJZpjw5UdydNIaB/Av+60s1ABAq2tjcvXoa94DruTjE7
	 jUMASWXEVuluGmU0yA5bdUkMOszT5dzgrsGh9EkWJ/DlH72FXgcZlfPLQXL0aV4tLgHCF
	 B7XoR7U8Z1vpVE82qKytl6UKJow1MTs4yH9jZhfNRPlo01CXY7zTwJWoI9mZiQpA9t424
	 McuqwiiAvp/0SRz8c/QX3+TeDr0E0mtGBLPf6eq64jiJfNzwAGvVa16sGEJbwFo68gROQ
	 r+1PeEdzaUefTNHQur3/xiBIEgDuyS51wbW21j2cZXyi1F22an91mvAsEGcH/0PkyjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N3ldIGYl;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D5606A325
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 19:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 313D5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N3ldIGYl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794252897;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=m5DQOa03jNTEqGq+HMzcF7pBiVnfF3leM3KBwbxc4uU=;
	b=N3ldIGYlj2sHUaSajc065QhJcxFT4AJ0NhVE0jPkum6hzh2otEzI1MVFO60Jc/FLMwVrlV
	KZXdIxf88QSXiiXCa+dKjKlaKfv5unaRQNGobByzqPZxMAmNdtd1BcrZe1LQHFg0jVJvAs
	doDl0sFxiXSd5nNZ15suB+ek6rkI3i0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-enz7dfZCNnawZbY5ANcNAg-1; Mon,
 09 Nov 2026 14:34:55 -0500
X-MC-Unique: enz7dfZCNnawZbY5ANcNAg-1
X-Mimecast-MFC-AGG-ID: enz7dfZCNnawZbY5ANcNAg_1794252894
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A195119560AE;
	Mon,  9 Nov 2026 19:34:53 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA36F431;
	Mon,  9 Nov 2026 19:34:49 +0000 (UTC)
Date: Mon, 9 Nov 2026 19:34:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Alistair Francis <alistair.francis@wdc.com>,
	Stefan Weil <sw@weilnetz.de>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH 5/7] debug/mem: name coroutine stacks
Message-ID: <avIgVo9ZxngkRUxO@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20261109185907.3220584-1-jsnow@redhat.com>
 <20261109185907.3220584-6-jsnow@redhat.com>
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
In-Reply-To: <20261109185907.3220584-6-jsnow@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Mon, Nov 09, 2026 at 01:59:05PM -0500, John Snow wrote:
> Simple enough.
> 
> RFC: Is there a better name we can give these to help tell them apart
> during analysis?

We would have to give a name to each coroutine, and then pass
it into qemu_alloc_stack. Would probably be fairly useful thing
todo as we use coroutines for lots of different things and by
way of comparison we give threads useful names too.

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  util/oslib-posix.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index dc001da66dd..454579c72df 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -60,6 +60,7 @@
>  
>  #include "qemu/memalign.h"
>  #include "qemu/mmap-alloc.h"
> +#include "qemu/mmap-vma.h"
>  
>  #define MAX_MEM_PREALLOC_THREAD_COUNT 32
>  
> @@ -742,6 +743,8 @@ void *qemu_alloc_stack(size_t *sz)
>          abort();
>      }
>  
> +    qemu_name_vma(ptr, *sz, "coroutine-stack");
> +
>      /* Stack grows down -- guard page at the bottom. */
>      if (mprotect(ptr, pagesz, PROT_NONE) != 0) {
>          perror("failed to set up stack guard page");
> -- 
> 2.56.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

