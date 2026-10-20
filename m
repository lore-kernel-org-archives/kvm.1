Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481265;
	b=CRDiYbuVM42WOa2R+W5P5/YtOQnWjEQfCTxRg1ZvoG7gBVuh+NXHwgq2QgNzppSUpSYj
	 6fJRD/6TpOhm4KdzCrJMUJvNPLUbTCBfv7tNVrxwCPLuQAn/5p7EUmj16fmSq2g6utSXC
	 JkjyxKkJjOlx2LCrBv5L3RIgtklyJKyDrAro836ISlMVM6d7OUtPuSPm5tpiKCJPL5yba
	 4JHhdy7BxTtjYPREbl5T5JKrPdTowfT/jomRINiO48ALdWN0Q4TooHuI9xu6vMNNPrbDd
	 ee2cEHCA5obgwKG7rAsj8FmDkamPbptXgLoaiSIGT9pwTnbqKiNlXpguZIZcSvdiOcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481265;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=D7VUKLyWmSTuNvyPZCaInGeXEgxZCqef2mwHv3QbNDQ=;
	b=5Zk5059YxAhzHJdHBudoNKulRK0CRTAviV7IPEmuKTESe+b4y07EAqUPW7iGO9ujk46+
	 XWPcyzz8r6DYMYES90Z/Sw9EVfIl7YOYs7IEodvLG38OvJE8WpyTCPwjiuzfqN3gzQSlF
	 3K+qB4kRfT0yXqOE2iN80qADn3h89Ds2n/4gW+Pp178xUduMfDkYycKYhXgcw5OQbqCSQ
	 qH3FtBQHNs34JVumnVmPRQP3TWLJjVlieMyLne4xs3HzEvM8X1O8hVRVyYtP1NoNYKo88
	 mgxTXZgl/grbkyJRYKJpce8kNGwnFI/kIZY0ClEwX0dA2v0Wz1kl4B/WWwcHPwQMa4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eSQ+s7TR;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jlanOOup;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C4606A319
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 07:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E0C4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eSQ+s7TR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jlanOOup
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792481261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D7VUKLyWmSTuNvyPZCaInGeXEgxZCqef2mwHv3QbNDQ=;
	b=eSQ+s7TRXYbWsOxv31ZSc6it2idGKzhswo3SmWcF9GABoYyiEjDRcFZEJilKE+HCIVpOyn
	aeIDvapDz8KqEqgs/PqUWFlgZiqt6qLKhimRfkui1LfPHsdsfglRk370VrSXTk0IQeqnpT
	qkclM45PJW9VIzyYZExK3ih3NLE8kcs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-9O0xiUL6Pm2KmgZaO7R85w-1; Tue, 20 Oct 2026 03:27:34 -0400
X-MC-Unique: 9O0xiUL6Pm2KmgZaO7R85w-1
X-Mimecast-MFC-AGG-ID: 9O0xiUL6Pm2KmgZaO7R85w_1792481253
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0af48c18so2157943f8f.2
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 00:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792481253; x=1793086053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D7VUKLyWmSTuNvyPZCaInGeXEgxZCqef2mwHv3QbNDQ=;
        b=jlanOOupnmRinGJ9UoP3hh3EcuaDE4JfW73D4J+iyc79nMc9rVkIsIq5kE7GbHKrRT
         pW0Esnh5erpiYElZX9jOHZv1GrffrldlnlVCCGvPcyo+M1PavB2BUgDDste65XwVx8K0
         dPN9qG6IcQTXrwEMwPKaUjGbsAoe6Hn57tiMDKLA8RXojyMaUJZazm2sqjKJgfD9m0+y
         0KhJGjt9AZ66pkoUjru164VsovDaR2GgcRcPEQ4gSgHvFexLxGFYCrb9EwZvjwNZKZdu
         EtZj2G0tAqCJ6Iup8xVePbsh7d4ZKVfMi9jmNc/0EBNJbSVRtNY46mqkKYsa59kWutS9
         Uxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481253; x=1793086053;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D7VUKLyWmSTuNvyPZCaInGeXEgxZCqef2mwHv3QbNDQ=;
        b=eUwlpw7WWUl7s4NSwsXRlG7OhUvCo2jK+aNy0uQp74RtWvn/XMK/Xl4pnsdQVI6JZk
         PsQQrl5F4JHWMcPCtSdK6Gk/JNqOAAb/lPAcoqhFV5gZ1Bmswn5McoKnysQSpcC5f2ln
         0lspF0lEd1RU7EKyxoZbHJ6noWJxsorkv6wCYivwaBJX1pBrdD6wYSgZl+hRhWt2SAZe
         uVSgokyBJ+2pM8ndQSqYhTuOpXlk3P9l/mixev18TA/b1VynvEU2pEy8pbLfGqNhw1w7
         RfYwZxuNikIDYR+AGYC7zaBI4mY5LDl9qsYXZ1iB9BHOxIHgBnMBvdHbbgtA/PSCSWCL
         +ZXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkxerZT4hWl0qTp0UmBljIm/8jpO+2s2avYMyDBY+Tw6OUASVVY1BD7mVI7fKniz/iWPo=@vger.kernel.org
X-Gm-Message-State: AFq9FYISyaFUYlyjlMYdjolPFCGlmB0Ik3Ip8Fz2luSIt57kMAun5an3
	noqgSWv5JjexRBi7gSAHHKdkf/bwl1znb1vJGEbP7Z9SLsWyxba02rlz/vI2WQj7JpnXoRntIsZ
	q25OvoAYvj5AQYuOi1svX49HOwOscdRb/FqCGzHgmecw+jIJQ6tGFeQ==
X-Gm-Gg: AYBFou0W/iHclNV2oHWMHmS4xVlkUb9Mt5g16iMmXD2j6vfeVFH5bGpgPtHsvKR+Lzs
	fDjfol8zVSRnIPrIEbKlvOpRXSDPgxc11+koZ+YyUqs63EuR/No1Rl0WlLwBBxDCxLCYViQv7YO
	6EIuY/Svdg1oUG+J3kJOTfJL90GaS4m6O5y6xqwJ3SrPZqZtXFniDUpG68/uPyisSjMjo59uGXG
	2kl2wgRAAlTMf70Wozwz8pOdOcLe0LsbXSiEplKqCoH3wth4mUlMf+hdP+K8pBL3FgXgxfpIgUZ
	Kw2JDe7LHEtmbnF2i+HExb2Eil2Q6v/lTJ+BXr7Tn+eG3trEEsMzHQEFVpxPoasNYrrlwg==
X-Received: by 2002:a05:600c:3b22:b0:4a1:7690:d878 with SMTP id 5b1f17b1804b1-4a1d7615cb9mr212725755e9.17.1792481252768;
        Tue, 20 Oct 2026 00:27:32 -0700 (PDT)
X-Received: by 2002:a05:600c:3b22:b0:4a1:7690:d878 with SMTP id 5b1f17b1804b1-4a1d7615cb9mr212725125e9.17.1792481252104;
        Tue, 20 Oct 2026 00:27:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cb8d5csm54348855e9.6.2026.10.20.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:27:31 -0700 (PDT)
Date: Tue, 20 Oct 2026 03:27:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Wang Haoran <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, eperezma@redhat.com
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261020032524-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>

On Mon, Oct 19, 2026 at 08:51:43PM -1000, Linus Torvalds wrote:
> On Mon, 19 Oct 2026 at 20:31, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following seems to work for me. Testing would be appreciated.
> 
> I have a whole branch that removes __get_user() and __put_user() entirely.
> 
> Somebody should check that I did it right. But I didn't want to do the
> pagefault_disable() around the vringh_notify() part, so it's not quite
> the same as yours.
> 
> Let me just push it out. I was going to let it simmer, but your email
> made me go "I should just let more people look at it".
> 
> Mind taking a look at the 'uaccess-cleanups' branch?

At the virtio things there? Sure, 'bit later.

> It builds for me. That's all the testing it has gotten so far. Blush.
> 
>                    Linus

I can help with that.

