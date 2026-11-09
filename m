Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252596;
	b=4qscwZ11IhRhe+Cng+HJDhqrlsNgTW9kndbViRucv+c00KUTrCtm8rqeXIwuH23I6Rr4
	 tyHvBug818IbM3LX1hHVRxfnCsD95yhwD0xdofNYkvWq4XVwCUtP2pf05qAR4OC2FMf0Q
	 XviFl5ElgMf6BkBut6j+K35/0krACdj2pank5yUgAUcAq711QL/ZqDF3odj0VN6X7sPpA
	 db7AwwelfXitb1S+k8cdFDOjpxL7ZwVVCNaGKRSXJ17zIQtUlZ7diW9c3esieHy4Ffm66
	 I1osI6z7shsBCt+V21Ph5MkJTUe2EOkL2is7EIt02iIGoykiUrNeWLgpV928+isDgUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252596;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Scanned-By;
	bh=yLKJIK5/ZcW8RAnCT7nGCDiPMbPMc6KlTX0/sYBvPAY=;
	b=DNxwGYZDWBbtEt5K0EwoXiMhGOeGrqrSs4PITf/RMav1DD4esiQShrZtXfy6R/TWJzqv
	 UZvWzTPadupMqBJaPc/vUB2wEva9k9NatFrEMDPufBRgKmzdUd4T4+y+PnzJzxcktdDK8
	 D5Hd76jS6oFUV1bxFqrDv6cb/4hwIHkc6F01V8xPUzeFW/xnvrOu8/U9XX4RvhMIqgyjb
	 envBdJY7vSWxDJQJ1nSxFyLJkBCKDoC0jZ9SXlIEf1uUHNqDWICjHPSusfGm20OuunmH1
	 59gESKQuxzfMBnc0zdD5BTtJYDRHD3miDwttjHtqPhLOMXlpjnZxPRykrWCiEDAKYcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J0jl5gJt;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FF5606A325
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 19:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73FF5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J0jl5gJt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794252594;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=yLKJIK5/ZcW8RAnCT7nGCDiPMbPMc6KlTX0/sYBvPAY=;
	b=J0jl5gJtqSqCQ3Sbpv1oQiHk2VmidUGuCtfCYHfiwz8coXZR95HompMHxcYxI405VE8und
	JrqybNQcXdTTZ1Oro51iiZKhGC/Ka3oR9rnyFPiD2tNcB+0KgLvWJbHM0RIQijEbJ3l4Ja
	tSsHalkVZgvmOdtu/XlACbcuzKk8SXQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-X8OwQWWVMZe_ZFXQoFmNbw-1; Mon,
 09 Nov 2026 14:29:51 -0500
X-MC-Unique: X8OwQWWVMZe_ZFXQoFmNbw-1
X-Mimecast-MFC-AGG-ID: X8OwQWWVMZe_ZFXQoFmNbw_1794252590
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B82E118001F6;
	Mon,  9 Nov 2026 19:29:49 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0805B195608B;
	Mon,  9 Nov 2026 19:29:44 +0000 (UTC)
Date: Mon, 9 Nov 2026 19:29:42 +0000
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
Subject: Re: [PATCH 1/7] debug/mem: add utility to name anonymous memory
 mappings
Message-ID: <avIfJqbcTHFAGvqf@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20261109185907.3220584-1-jsnow@redhat.com>
 <20261109185907.3220584-2-jsnow@redhat.com>
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
In-Reply-To: <20261109185907.3220584-2-jsnow@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Nov 09, 2026 at 01:59:01PM -0500, John Snow wrote:
> Add support to name mmap'd memory regions using
> PR_SET_VMA_ANON_NAME. On supported platforms, the QEMU utility
> functions are no-ops.
> 
> This is useful primarily for debugging and profiling QEMU; beind able
> to see and correlate each VMA segment with a specific use within QEMU.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  include/qemu/mmap-vma.h | 18 +++++++++++
>  util/mmap-vma.c         | 67 +++++++++++++++++++++++++++++++++++++++++
>  util/meson.build        |  1 +
>  3 files changed, 86 insertions(+)
>  create mode 100644 include/qemu/mmap-vma.h
>  create mode 100644 util/mmap-vma.c
> 
> diff --git a/include/qemu/mmap-vma.h b/include/qemu/mmap-vma.h
> new file mode 100644
> index 00000000000..763ea5a5cab
> --- /dev/null
> +++ b/include/qemu/mmap-vma.h
> @@ -0,0 +1,18 @@
> +/*
> + * Utility for naming VMA allocations in linux
> + *
> + * Copyright (c) Red Hat, Inc 2026
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef __QEMU_MMAP_VMA_H
> +#define __QEMU_MMAP_VMA_H
> +
> +#include <stddef.h>
> +#include "osdep.h"
> +
> +int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
> +    G_GNUC_PRINTF(3, 4);
> +
> +#endif
> diff --git a/util/mmap-vma.c b/util/mmap-vma.c
> new file mode 100644
> index 00000000000..7dcef3b7455
> --- /dev/null
> +++ b/util/mmap-vma.c
> @@ -0,0 +1,67 @@
> +/*
> + * Utility for naming VMA allocations in linux
> + *
> + * Copyright (c) Red Hat, Inc 2026
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +#include "qemu/mmap-vma.h"
> +#include "qemu/osdep.h"
> +
> +#include <errno.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +
> +#if defined(__linux__)
> +#include <sys/prctl.h>
> +#endif
> +
> +#define VMA_PREFIX " qemu: "
> +#define VMA_MAXLEN 80
> +
> +/*
> + * Give a human-readable name to a previously mmap'd memory segment.
> + * This feature is only available on Linux >= 5.17, and only when the
> + * kernel was configured with CONFIG_ANON_VMA_NAME=y.
> + *
> + * For systems without this option, prctl() will return -1 and set
> + * errno to EINVAL, and can be safely ignored.
> + *
> + * For systems with this option, these human-readable names will be
> + * visible in /proc/$pid/[s]maps, pmap output, etc.
> + */
> +G_GNUC_PRINTF(3, 0)
> +static int qemu_vname_vma(void *ptr, size_t sz, const char *fmt, va_list args)
> +{
> +    int rc = 0;
> +
> +#if defined(PR_SET_VMA_ANON_NAME)
> +    char strbuf[VMA_MAXLEN];
> +
> +    assert(sizeof(VMA_PREFIX) < sizeof(strbuf));
> +    strncpy(strbuf, VMA_PREFIX, sizeof(strbuf));
> +    rc = vsnprintf(strbuf + sizeof(VMA_PREFIX),
> +                   sizeof(strbuf) - sizeof(VMA_PREFIX), fmt, args);
> +    if (rc < 0) {
> +        return -errno;
> +    } else if (rc >= (sizeof(strbuf) - sizeof(VMA_PREFIX))) {
> +        sprintf(strbuf + sizeof(strbuf) - 4, "...");
> +    }
> +
> +    rc = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, sz, strbuf);
> +    if (rc) {
> +        return -errno;
> +    }
> +#endif
> +
> +    return rc;
> +}
> +
> +G_GNUC_PRINTF(3, 4)
> +int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
> +{
> +    va_list args;
> +
> +    va_start(args, fmt);
> +    return qemu_vname_vma(ptr, sz, fmt, args);

We need a va_end here too.

> +}
> diff --git a/util/meson.build b/util/meson.build
> index fa174c07a57..861ee228d5b 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -1,5 +1,6 @@
>  util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
>  util_ss.add(files('thread-context.c'), numa)
> +util_ss.add(files('mmap-vma.c'))
>  if host_os != 'windows'
>    util_ss.add(files('aio-posix.c'))
>    util_ss.add(files('fdmon-poll.c'))
> -- 
> 2.56.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

