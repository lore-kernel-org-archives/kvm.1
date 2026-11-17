Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923248;
	b=Tb0ZWiHhc8ptjrMUdearQJM6xISlhwuBPNPj7J3xyzXM4ddc0xlTUzLG5PNLvF6R0cTn
	 buL7UXZOksZvGUar2cUWM6zmDg4zxMUSpiUliWVI1RoSSX0tafN81/XXibi3TPjiqPHaD
	 vK5q7cpaVFoS2uk01Kq/8fenp/FEYXQxOOZ+bDOh5fk1DK9Sfx5ZdqwWJBEDLqF7GR9li
	 O/Ru4rLDnhUDXP3CWxZXs+uOu2NBY3xv4UAn/hUBn89tQfFoUuHubbc2Zdk5jqGwwZ5R7
	 6qD/ZIeTjbzZklX029l9Jp1tNWASBaMAA//ZhAwJ7dnhWWallMPGb3d8wiDU5P9BJKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923248;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:User-Agent:
	 X-Scanned-By;
	bh=D7DR9dhul1UmFPsGGO/WlqzcYOaev5tRcdAVkWpsUdM=;
	b=crDINV3FlpoATBzDIlzt/ALJvgCU4lJg2tdGAbjklSQ8onnEgChEfbwTjEAG/d3/PSSM
	 rR222vBhw2RJB8pQZSClv2SydBoYGf2auI7ZxtcSRVo5yNkClIFDuTH1GAb+toaiPCCan
	 q/0QfgthbNB+aSmN8f8vsv9feF4qqEL/4aG8qecy2ZQiFRJBXZBIZYFgwOwRwIGPxkGeT
	 LuKhtsajh1C2ERGsrrkg8Gtu9DFN2DbOPD8l4s8p+z7Ot9LOzC2JTDJAP43gFLo5liyGl
	 8OsxFZVcyB3sVYi2ilrB10QhYnOKFubflfB6Jt/hzgapzM7evcodtdcQh6o7B3OyDlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=clMdroh4;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95880606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95880606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=clMdroh4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794923246;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7DR9dhul1UmFPsGGO/WlqzcYOaev5tRcdAVkWpsUdM=;
	b=clMdroh41S9mY523EWsxj8H5AC3UgmIdWPEo4Vp6IXzGr2Xg6U8Uc+hw8pXMIvkJ6W3oTq
	mMYLJuwn0ePsgovm19pSiSY4BLA9ywDZK7y2Qp+xuytXihA5oEueLkGmpPrzUAHtr74Qcp
	T1sqACme6u0FmZQ5ALCAUIsmFPkoKQQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-EyM_eYOfNyaiAJf1rFrEuQ-1; Tue,
 17 Nov 2026 08:47:23 -0500
X-MC-Unique: EyM_eYOfNyaiAJf1rFrEuQ-1
X-Mimecast-MFC-AGG-ID: EyM_eYOfNyaiAJf1rFrEuQ_1794923241
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFE8619560A6;
	Tue, 17 Nov 2026 13:47:20 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2016E1956055;
	Tue, 17 Nov 2026 13:47:15 +0000 (UTC)
Date: Tue, 17 Nov 2026 13:47:13 +0000
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
Subject: Re: [PATCH v2 5/7] debug/mem: name coroutine stacks
Message-ID: <avxa4ZVUP5GcWi5v@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20261116165002.30939-1-jsnow@redhat.com>
 <20261116165002.30939-6-jsnow@redhat.com>
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
In-Reply-To: <20261116165002.30939-6-jsnow@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Nov 16, 2026 at 11:50:00AM -0500, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  util/oslib-posix.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

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

Our coroutines are crying out to be named in the future :-)

> +
>      /* Stack grows down -- guard page at the bottom. */
>      if (mprotect(ptr, pagesz, PROT_NONE) != 0) {
>          perror("failed to set up stack guard page");
> -- 
> 2.56.1
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

