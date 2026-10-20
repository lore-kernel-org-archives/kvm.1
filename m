Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518657;
	b=oetVMBZgMMohv/toes0iFitcU52EGi8INYI5SQtXoLLfDIeit7BdQNWof4DUAXsVx/X9
	 8MzQhQSUHIroiren459zsKQWw0Vs5B6w+B/+nkOUk8305ODKxK4lcrS59nCykCa4+NO8q
	 SYk+twUIxn/L16VsE1EPuKLQ/TtHexUPLoJ8EBIQJ4FyyjxNhO3xu+6hbJQzcYUzFUfOd
	 oW8meA8RTCqNVeq6E/n9nkULSahWMWVkCx8Bl0QU2+KSfXVLk06gnOx2o4UzXkUPlKCvx
	 iryMGRyFP3m9/iX6TajNM36mQ77b5OEfxsefgAgHuL8eKQ8Bz9p0gydOrZA9T06KVsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=pUauNVWehf9yJlxoCpgSpQ8hZTVkN4yj1GOVaT5sy9U=;
	b=o+/E/LoVlvCm5B2kSTBEq3oMh/54/vMSWuobrb3AfT1GxDKTJlQkRKrQOfMr7skAOZ2u
	 FBg6Xa2U9DYzgMbEYL0e/d7SFrPa5QrbhPaV92E4f1elaHwGfgT9kmfbYIKx4eKOqnQ82
	 odGiSUKBY/63N+bWGgm5fVxbrTklpBWNZ/ZE8Nuz08ra9qVPVEpdy4mA6gZ7RHry2SpQr
	 N8JRTuoJMrmYdMpIz6KgL5nVsV1hj6VDES9Kluc7xAJwshFQouxM4E7qzOf/PRre4WVXY
	 FzeSh0RSro77OdGPMLeONVCSEA1mSxMcyZzmFCfxZuGh1NCqq/BJ6SpOUF4sn4IUHPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=FaXZZkDT;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26AE606A323
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 17:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B26AE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=FaXZZkDT
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c37b612635bso476562466b.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792518655; x=1793123455; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pUauNVWehf9yJlxoCpgSpQ8hZTVkN4yj1GOVaT5sy9U=;
        b=FaXZZkDT4JTAJD9dls5zNgoYwqN4YoaMS9ggdsn9VJDCOrpWIPpIJtnKJc5VsnFaa6
         NstxfC4k9ERrs0kvhRAeH1sHz2ZLoi6fy7GQyMHWaqdZYp+tOqS9UKf4ZqNmZ55I/VYB
         BJUlcKtqh1qMtChxYdXTyHU7LwFIy0XxNhEeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792518655; x=1793123455;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pUauNVWehf9yJlxoCpgSpQ8hZTVkN4yj1GOVaT5sy9U=;
        b=E2tD5XqvTWdjWtTU3ckweWUtWiSeMQ/gSx7P5jRLmyMGLC5IqMG5Lp5P+AYoU0r9Mf
         2ANXXmM0zxbYcLg8rMjKmmb9pXAbrzmJLcQs1CB/ZD6D5OZ8gbXdlsP0GmJxWV1qFhBC
         /ewnpZ6TY/WfphcQhfVtGA2ealsXf2BeUftDy6plvXpsXA0MkV58fvqN5TLTnq30Crcj
         ZPBEds3d4+z3a0o7Cj4spvjpp2Jr9YJB8ieB+UBLPN7ySTNJoQCryZnauagnUlk4/2El
         5YBIVNfpBa8I3uqSwX0Bh62wESYuaVhigUi1LPoTAAogMeb82QnkUgMZc9jT8KxqLNJr
         CgDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFrvLdPpW+U9Vdf+IC906DEPXAWijyTr0VK6I8+f1PbSEYmQIMkxbZx66FZW5PV/c+UYM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1NzVIvjVHMjD4AGIRZdQWRMimEeuIMkkRzJxWisJraTFKsT69
	uFtTShc7y4Nfr5IiNCFqS5vk5e5kYeSh1brgjVSZmESySRmlXiVTTdZOKei2IASV4Biww6KHOCO
	hv6FipsQ=
X-Gm-Gg: AYBFou2dupMRXhTJPiAM0MDPjsJ9zV1lqzwtX6bFjrhuDWffa6Y6GJ56R+3QuAs6Q5w
	CdW1uFXDxIHnK9sDPgcz36X7u5C6jCgZk8iL5ppisMBB8uhwB4I2zZERQ1eZtnSFC4lEFocM7hn
	0HXf4PrxnicDBd6x3q+lofCBEDaskjdbJF5VIUqNNVxQp8/ZBidocKhVMg+VwEM05MynF97NzSZ
	MleG+SNlbetckPprJpY2CLhP/6QnPJOHtgiq55JLcIK/E9YYumPaE9/651RdKpUbuuD320w4TN8
	/VDv8JX+UnjyFegvkMNSiastwSqelSK+jYv3+ouGvau5oDyyfZOFBbNqkV6TbjbTeE+0mgYDQtZ
	t/Li2N2GsP/jmMd557c0M0ptCFOt06Q04XrDu0bc850EHasyI79xBcHDhV926HbE2jMKwx9KrTW
	s+IMo30zFRo4myHjuDM4yN5w6EuoYbgyL8HDj+007sWoUfygSSVg3NIOXTHJbWElzKMh3ojH98S
	cvxxWbwPVSMMWciVUcTAQnkJxg5pjNd22dvS6oIRzPA3IE=
X-Received: by 2002:a17:907:e0d8:b0:c46:645f:ced7 with SMTP id a640c23a62f3a-c46645fd11dmr145935866b.39.1792518654945;
        Tue, 20 Oct 2026 10:50:54 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4678fd7eaesm652066b.59.2026.10.20.10.50.54
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 10:50:54 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2a4e013a44so476284666b.2
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:50:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByHGt/7p3JXHoq3JRLUQ+sFlvqlXpxH7XmHBXjSzgZjwkbBBZNgXzA/O7PuCon7UmK9mZw=@vger.kernel.org
X-Received: by 2002:a17:907:d2a:b0:c41:21ef:26ef with SMTP id
 a640c23a62f3a-c419ef2407fmr811663866b.20.1792518653997; Tue, 20 Oct 2026
 10:50:53 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org> <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org> <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
 <20261020102134.745ff48a@pumpkin>
In-Reply-To: <20261020102134.745ff48a@pumpkin>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 20 Oct 2026 07:50:36 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjUb=G+9gtaSO4bfUYKL+tVBVQq-Zfn_pGbCfxNWbz9AA@mail.gmail.com>
X-Gm-Features: AclHuK9rATEm1NS_MFfAyhy60SuMBv6wKyZqfF_GIdeIDY7VES_ZxkiFI1mL3aE
Message-ID: <CAHk-=wjUb=G+9gtaSO4bfUYKL+tVBVQq-Zfn_pGbCfxNWbz9AA@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: David Laight <david.laight.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wang Haoran <haoranwangsec@gmail.com>, jasowangio@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 23:21, David Laight <david.laight.linux@gmail.com> wrote:
>
> There should also be very few (if any) access_ok() calls outside of the code
> that implements user copies.

Note that that branch only removes __get_user/__put_user - and only on x86.

So there's still a lot of valid access_ok() calls left. Some are
around things like raw_copy_to/from_user() etc.

But some are around things that just want to verify that it's a valid
user address for other reasons. On example is in fork.c that just
checks that the stack that is supplied is ok.

But yes, the branch does remove a number of access_ok() calls. Fewer
than you'd maybe think, though.

                  Linus
