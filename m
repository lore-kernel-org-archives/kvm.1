Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252652;
	b=DKYm2rjzmZWG9xrBbND+6IQ1b4qlYvqC7A4rFMiPEBRw4NOPXGrbZwBrA87mmimdGxJf
	 P0XoC2wM/SRUH5VxDFCYArlOMW2cJIPSP8MC1JUszJT78cEwKuGQM3q9vNbX7cbDUFRcC
	 6UrFCf3mkmPDfEGmpmc6jat6QyWSHeC/5ANxkBz7ZmKeBaZxy4i2YLJcMvwWzrq4BZSfo
	 8URxL/POhNgPsHvkFOfEU8J6UwZz/UxdiA1JzA9KVQ7p2XgD7AHqDeFVkfRjDQfehuZTb
	 4GbV45kFXW7y8JdhNPkavBmr96a8nl3kf8+9nDPwsgjUG+cQ9Ib7D0V3s2q+FU4hocw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252652;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:User-Agent:
	 X-Scanned-By;
	bh=hpaGa/vKmVaBVUSzvo/zy2DZqHpjno352QUeE3Xz7VU=;
	b=js21UMYEd+EtqBHB+bzXcKqPnibTKYr1QiAHF3YIhEEVi8awR27NsaugWltijnPZFz7y
	 cwLVrjOuuAljdH/zPt0SKMiW0v6MDEaS+h62CI10LarnCILAGISwEZs8jbbT4kOJyESlj
	 A99upvhlld3qi1lDepx+S685CtidcWJ7dy2ZXVGZV6xibzZu9K8L/E3o8+o+WoBgL9Stg
	 1l5bSRT2NMlJLSiwG8gYF1yd6lmeuzDt4zK+muAR06zt1/ZaiOQReTMVszv8/fwbUtWK5
	 cO+KlrVG8+LDp+qGk4R8/wochwCvGVUYoLJ0kDfD11T9GwGwHoJ08JwabDa7KB/sNOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VFaUjeJB;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49949606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 19:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49949606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VFaUjeJB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794252651;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpaGa/vKmVaBVUSzvo/zy2DZqHpjno352QUeE3Xz7VU=;
	b=VFaUjeJBGbAtEieBAOrSlkRCQrjQg0qj/qHNu0EsgfSlFzu1Ln/t0ggOklKJzkGRh6A/eZ
	MaX0St9bpYhkyesYUn7nWP7cGe8+x2Kdk4SJQIUzxmoDyeanlElt7sI6+ytLYG5VHOolay
	A1beFGt+kUlfWv/QqH1IguhhlLgM3WQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-L20tV4d6MAybMqUd80iwbg-1; Mon,
 09 Nov 2026 14:30:47 -0500
X-MC-Unique: L20tV4d6MAybMqUd80iwbg-1
X-Mimecast-MFC-AGG-ID: L20tV4d6MAybMqUd80iwbg_1794252645
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74F501955F01;
	Mon,  9 Nov 2026 19:30:45 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C27B1800446;
	Mon,  9 Nov 2026 19:30:39 +0000 (UTC)
Date: Mon, 9 Nov 2026 19:30:36 +0000
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
Subject: Re: [PATCH 2/7] debug/mem: add tracing to qemu_vname_vma()
Message-ID: <avIfXFCNp2NZrWvh@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20261109185907.3220584-1-jsnow@redhat.com>
 <20261109185907.3220584-3-jsnow@redhat.com>
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
In-Reply-To: <20261109185907.3220584-3-jsnow@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Nov 09, 2026 at 01:59:02PM -0500, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  util/mmap-vma.c   | 6 +++++-
>  util/trace-events | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

