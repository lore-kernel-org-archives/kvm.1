Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792479125;
	b=w/gmB1GELW4zCU9bWFZ9cIfmjgm4EPYBHTFY5jjsBEl9daViFmlwFYaF0hUwfp2TwIsE
	 pD4+Ex+ARbPpNkEoPWiHpfYpZeloIopB0xYp5Z8W+B6yMDCZ03MkMDXqsWQtOuhcpK/dg
	 qr0K//dhE3Jq1UB2VsoozykW32SbdeEamBS/KRbTpfvWdfKumhMMTcsOv6cTccG8zU710
	 iRQ0dTSZNQ27eAsMs5Ilj4US6YlhyP5OAI9P2Hs3Qq1qyIdhFsPz1wXqKK8CxVlxh2jJy
	 Mus7G6Bte56jWsx3w8wCLM4swXSUtxMMmK3vTHi8DfikjjFyIASnSZ1ENbh37HRUFEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=oDF42rmnmkhzedotr2E1sl7hiMAx0kNtO/q61gkgaPI=;
	b=RBYk7ODXipVxGp9WvV69mHLEQRtul5wC2GnWXTQ/DmTT4XSpum6h/v0e0ub/IJ7EHkK/
	 /v6ICJTPH2ykqEoXuuNo3zwLgRt29WgOvQKF2j+X53xAb0VHEUjwjp+X2b1EZF/WnKb5e
	 gam4TrpwEDDIFN2ZYBxeN5ebjIxoUoMxvv28NdFZMPVU9NBP6IhaKB3auJF4RZaDvO5VP
	 Oit93Gs55UcEEg7PLh2JlLE2NwbYBNYIZThIPFptHO6RPKNlh9i+yWK0emT3UdygitYIS
	 VQ0hWUCN8UfhbpV/c3PkMeAATsmr7nfOpHJNKKMqXZVwNtUtTfS2P+IkCF9K4zgexew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2F7606A32E
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 06:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F2F7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso3985043a12.0
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792479123; x=1793083923; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDF42rmnmkhzedotr2E1sl7hiMAx0kNtO/q61gkgaPI=;
        b=T2ieWWm2fJMs0ly/lKc+VBaeNbR7JULdp/Yv1onwgfgH6q5MD5rmGllkC4r1IGDjPh
         b/oViX0b6w+uMFqC5z0zvmY+lbDh55jK+TCaZMeqXjulSW3NEhRsiuz2anP+CryhJBrp
         lyXFOsCuCjD/XcDxIqSfX1dJPC9p/wimpItQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792479123; x=1793083923;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oDF42rmnmkhzedotr2E1sl7hiMAx0kNtO/q61gkgaPI=;
        b=0wACPqOdJx7Q+pbWhIIf58AdPo9fg+F2d7v6MDiGoe5YgUdKX/RL5XsMqYlVbpVy43
         pHdPeA3/sQH2PTUV60WphlPj3bonCrdhMcLSvuU5b2gWMfjzRUxw/yCwFWum67LMwrV0
         r5IRU9QEKduBb1E31rlEmFf069/ca8W/GrbHDJds5+Oh3WktDhETApiqFgs61VDokdet
         FIZ0etwJGS0Kj5UOPiP+zBnKglhlN45a38zbK7wfRpfAnb1jg5GmDZ7xQHvlqOxdRUUm
         l3e3DHncMPKUc72hEZ0upvJqmOa/D6IjAPjA++wQV2/U7HFgkjR+8FgeySlboopmzrn7
         XaEA==
X-Forwarded-Encrypted: i=1; AKwUvBzq87kpKiT0IdNZpo7qqwpb4HAwSIr3/uNUCWxT3ye+k+sm4HM77GSGvNlmHq/0ougAExg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkOU++vrWcj4f0rODeEzHrIyFHBjzVMulxMjen8zwldgI0wQkw
	S83A8PPVYV1QqpmdB4285GQl6yOYn1G8XZ2ItnE5SkhAOYF3GlsIuNP24VwtVOJgWwwZfC63I1l
	Q6xyjEs8=
X-Gm-Gg: AYBFou2NtvGMKFMTgwi5TCQf2H8UH2IciGgzHTpzT57ssk05w1g+fYPxhUkTYvCcgwe
	t1CAVfEq1AOpI2tFFZBQWlRHF/ttXzDT5nkG22ifo36sCZcwgvEwcndwhv2+MEt4hSSjdL2S5ch
	YJ7d8UjN8Q6yL0S932doIP0TY+1o2rdEheUQ9VywV8tlYnmDBf7iuT1GCM4qKrC9SfPFsH+9Qcz
	slgv9L0nRqYDE5UUG0CUUylijykTh3MOzyATamHVaE+bTRE7B4qNjEJWtVjD+jD2yEvG/EBLZOe
	7mFT1k3QKdOkJAm/lluV0zlNVI8ZQKERVNPSw417r+BIi/cWjWQ+dZdIZ8vjUu4zkRGxGxKT6i1
	E2L5o/Utft5r21TW6+ORxOF7U5JiIYEuKo0nBWolgHHN3iEcix0AOCAdxSAgvQXGJHVdpulGRNR
	grXVDFAIuxL+HYE3c3z8+qfCd2e51q3aUUz1h4yngWwlVBYu6AJeJUfvaULJLnPVo6EvBvGwj2T
	XcqAUEmLjMMfPA6pJjhDiKzp/nLK7n/8ISfKDlfilMfzTU=
X-Received: by 2002:a05:6402:20ce:10b0:6af:859a:f306 with SMTP id 4fb4d7f45d1cf-6b3a8209426mr4393775a12.36.1792479122483;
        Mon, 19 Oct 2026 23:52:02 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1dacb6sm5006639a12.28.2026.10.19.23.52.00
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 23:52:00 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso395123066b.2
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 23:52:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwKaJQlZlzqttAMN/mo+NXTIXqZpNCqCdp8LgE5QCLC1hGdLnZ8I21k86+2hLwS/yJM2T0=@vger.kernel.org
X-Received: by 2002:a17:906:dc8d:b0:c46:645f:cedd with SMTP id
 a640c23a62f3a-c46645fd0e1mr41541566b.8.1792479120078; Mon, 19 Oct 2026
 23:52:00 -0700 (PDT)
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
 <20261020021924-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261020021924-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 19 Oct 2026 20:51:43 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
X-Gm-Features: AclHuK8XyMOfalc2h8xLYAwuI7OOaq7eZ0Xa-sCHFlL0Wx6hRPrX61Uqe-VGGwI
Message-ID: <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wang Haoran <haoranwangsec@gmail.com>, jasowangio@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 20:31, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following seems to work for me. Testing would be appreciated.

I have a whole branch that removes __get_user() and __put_user() entirely.

Somebody should check that I did it right. But I didn't want to do the
pagefault_disable() around the vringh_notify() part, so it's not quite
the same as yours.

Let me just push it out. I was going to let it simmer, but your email
made me go "I should just let more people look at it".

Mind taking a look at the 'uaccess-cleanups' branch?

It builds for me. That's all the testing it has gotten so far. Blush.

                   Linus
