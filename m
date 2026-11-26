Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795718562;
	b=Sbd7Ao0LpwvC51rgfsnOj/FGzup2o6jHHSyVVnFu9w0R7VgiB9cpyHeW9IM48QflBFKC
	 jUx9e9F+/o73yYgizsPrYVWXtcPQ2xLq7O0PEFUX4FnpfIxB4rLJoYKFhy45A0La/vMaP
	 eiPqWuUWt4c8y6RQLyLMuDp2jbTD0IKlMpzb45G3D7rbY6A5hVnvgEooAUwPs+cYn4X4b
	 YnfX+oJmiefQ4yiZfdjIL61Vl7rJvYvHqWszMkKx+IEyrp42savk8RF93n/Vr4kJB+p/d
	 3H2Xy4OpWVhM5n7cXAzTto1dksqSuvAa3eHUPFlBS8XJdcV+o3DdDhFjwq/O/690AVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795718562;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
	b=HC8uY7aSUNhB3kgCu/J/XKMCf/4aUFZyq7BzLQmI2fP4cpFgYmtUMal+vCdypgM3AKpa
	 rIqtNK42hLlrMWzB26Of7BWFO9d3baDV9+0qzXMhSNQx9K0vu7a2XCGdwz7Bzo7VDol2u
	 ERk7YOSRAoaj84a3NRh7oomz97f66kE5sQVitSp7uweSz5MShZMrORzmxhVpGM1CTDaLO
	 0rIxYvl+pkrtlw+qn1MZ2pyDiMea/MlUX6Zf6xAE0nQq5VXO1rT3LcCpKDSWti0Zq4e6G
	 ZoouxEfeeDHIxD4HLPSMoLO5aLhgWnz9+lsTn5OLpIlh6Pa0WhWIk9ENQuxf3Iocu/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dSJV2yS5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AfZRd78T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB5C606A329
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 18:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB5C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dSJV2yS5;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AfZRd78T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795718561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
	b=dSJV2yS5i5n4Y0qa8QpYgIlvjQkV6ztVeP14NykEmG4e8ZTbbOguUnFGnuZkgM1hfvob6r
	JsVpE2hnbjdJj2tNxhz/Zlwdqw/UfaoJiNIXP67HDDrgplpsiOxKUG+XGfh9aXwyPW8bpA
	cl83VPqy12HNsmZ2ziLdHqi20GJFVHs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-7PWfgrQSNIWo7kBMkZodsA-1; Thu, 26 Nov 2026 18:42:38 +0000
X-MC-Unique: 7PWfgrQSNIWo7kBMkZodsA-1
X-Mimecast-MFC-AGG-ID: 7PWfgrQSNIWo7kBMkZodsA_1795718558
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-92114c39cadso132578586d6.2
        for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 10:42:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795718558; cv=none;
        d=google.com; s=arc-20260327;
        b=bCbO5qyjFCikxW6nk+hU3ter8sQ+UkP+ivIitA7Z0gC+uVK7mEMgso2s7NPgOC9SiU
         eSvJBxoNYEuuHM1T0Sq5+ahhcxW/WQRNVms6PP1PHQGHkFt2NtkzhtVi8FV8Fa7S8hnj
         wBzRLmIFkkOm6jYAWvOgH7k12mRddVF7YBPwLdu5XAvF06n6VPKvA4W5zptHyv8Z9yoh
         czLLQel0rN6T7ud/V0gmGZuHsy/Zpn8rrKGvaTDgaE0wbaHvZp9CRadNlxQq3qrSSRnv
         DQmljHUVAjBEzfgjlizFKfku5ByGcSck0Iyp1BrWtKP7cfpw59moRTsK/Kbzk8P8i/iU
         28yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
        fh=kuPzeCaPUXD1yAY/OhB0/W66VHnFk2EJX+hFc9wwO8c=;
        b=lsikGlmL2qwmCfxKPTiMlAQ8BPLX2VgHHPP033HEdjK8wxLFIPJqfXauS6lMzNflvu
         5tzW7NwolHG08gWnPywXH5sjqnk9LfSO2YaCfbqV81qqbD0t3COs6rLOxnWZ2wzidvu9
         PQh+nFSJi3V5WXPeRi8hbpgSIJXmQX/3Dlx1j3OylDgpCJ59l4weJ+CB0bAs6pTWwxi2
         1m62+IJmD9rYDfMjXB6mwPMaym1fH8H1vBnfzKpnD27TLRiqk+BW4kYIXoo8qEoAb1mb
         DdH40r6AM2ZuDjuGLh01FdzI13lyBY9FhUL0WnZdwIWRhOOHiMFkUMOqRsz0FTSGsStG
         979Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795718558; x=1796323358; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
        b=AfZRd78Tl2My6cFNYn6J2IoXlWU7jd9dGbwrI6sPcEv8IbdB7fLO2XDTbfQrF+Io//
         ixsvT2itMWfRas0wyep77elrun0b0HGJrXml5mtbVm6K8dyKkh0KXNx0lrSGsPUkPCd+
         htlBpxymRJe/MctD8/s3oBLQrenF1llfpvNVhQu32t7LIWWg1Bh7H8nsKdn3e7FAE3vz
         mQxf/6gLyv6dziabFgdbxxM1bskyM7oKpN9JDuuuJ0aXwEDBLVIA3qoPxkSditthi7C9
         qBl0dW/paw/ir3LbJm8JTGe5BmEL00jx/ma8TFxiJ/0OxfY1hFMGLr2/eSwDP5uNRg0l
         WIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795718558; x=1796323358;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
        b=x0UG0CCnqCe0M5TCpiHi7sLr08q0vCetay+Bfa6JpRBOlL+9yXXwhIPTk9xdc8EBtN
         KeUJ3dIceWziHfea5NWBnuN27MDgpmOYzNE9I+QkNTyMFFXXVL1HElB35l1SRpAPfENI
         H9/qAOC7GKMLHOq9YhjzyY4M3Y0jaSb/14BolJyPkO4TM8bcoDGCOJ2cExl6gaFEWGA3
         c7alHnVSbey390m97Q1+qh66LPqugzE0vmE2QuZojxMI3nvmDMkqY4B9JnIdYlrR4Noz
         btOKsKHisKV4JZHgONtxpW9gz0UZXir0dbudmyfL8XhOEGInBSkcEzcEyibMj3+uGhdW
         pr8g==
X-Forwarded-Encrypted: i=1; AL+hErGyRmMBPQoXcYCh3w5gmN5J2+p7ie2hm5LErsNvB+nLq1HbqKWzRvA9rBhiOwIEIdyhV68=@vger.kernel.org
X-Gm-Message-State: APuU4Z/osfuh+JnZ9hFSN7KtcciJXhNGFYEURAee3BtVvN0Mo4lwPOga
	Of/UqrHJ/WxfZdVgf0bTM2TdnJ+d828NTvztzxgrODXbB7XSibhLhp3lH72aUAJ22itkT03nntn
	9oRGKZOR6RaKZIKCHGvWTCTI5XDTej0/ihFI13BbbwzQV+LkCIYumvHPNZWZ0soELRdGAdIeyPn
	feUX+skU3PlIVlmegfuMuaZSr8/Gob
X-Gm-Gg: AZFdTZcjNDTQSRnm8tMxA2xRc1MCBsbJMWelLbRaWHjKP8Vh1+xeWdpWCTQqmgQZ1Dr
	/4Gg8qmXeDTzF4gTCGOuCkjSCC39JdHpUc9WBjpNbmMBudR5pe2fsa/LsjGY7InZeNpwvvxgsi4
	xjTnPqt737ECvrSLBJZqS92+fY8R/XhDqfk10wAuC8InY9XmF+g98PA5Y=
X-Received: by 2002:a05:6214:5701:b0:921:7c1a:5953 with SMTP id 6a1803df08f44-9217c1a5a29mr99541846d6.14.1795718558219;
        Thu, 26 Nov 2026 10:42:38 -0800 (PST)
X-Received: by 2002:a05:6214:5701:b0:921:7c1a:5953 with SMTP id
 6a1803df08f44-9217c1a5a29mr99541386d6.14.1795718557797; Thu, 26 Nov 2026
 10:42:37 -0800 (PST)
Received: from 821463759402 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Nov 2026 10:42:36 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <awhAaTuR375RpyAE@sgarzare-redhat>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com> <awhAaTuR375RpyAE@sgarzare-redhat>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 26 Nov 2026 10:42:36 -0800
X-Gm-Features: Aa3M54odw2FRTdRy2uflU_aL9ZEV5X35-hMgLihiDc4DudGmLOU2wiibEdItlhY
Message-ID: <CAAiTLFXT_Dqs8sUY+dL7KhXL=-QYudikb9kVFFRvGv9Ri7y7ow@mail.gmail.com>
Subject: Re: [PATCH RFC v4 0/8] vsock: add datagram support to virtio and vhost
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, Alexei Starovoitov <ast@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Sashiko AI bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Stefano Garzarella <sgarzare@redhat.com> writes:

> On Tue, Nov 24, 2026 at 01:20:18PM +0100, Sergio Lopez wrote:
>>This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
>>the existing AF_VSOCK API. It is intended for guest and host services
>>that exchange independent requests, responses, or events and need message
>>boundaries and sender addresses without a stream connection or application
>>framing.
>
> Thanks for restarting this work, I have finally found the time to took a
> quick look, sorry for the delay.
>
> Reading the cover letter, it is not clear to me the changes we are doing
> to the core and VMCI that was already supporting DGRAM. I'd like to
> understand better how the backward compatibility is handled and how VMCI
> behavior is preserved. Also reading commits, most of them just contains
> a description of what the code is doing, but they lack the reasons
> behind the changes (i.e. the why).
>
> Overall it seems the right direction, but I have some open questions
> (some of them discussed with Bobby, Stefan, and I at KVM Forum some
> weeks ago):
> - Can the virtio flow control be affected by a flood of dgrams ?
>    See https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-5720001
>    and virtio_vsock_pkt_info.reply / virtio_vsock_skb_reply(skb)
>    handling.
> - Did you test virtio transports when VMCI transport is also loaded?
>    That one is automatically loaded (for historical reasons) first time
>    AF_VSOCK socket is created, if af_vsock.ko is not loaded. So could be
>    a common scenario.
> - Any limitation of the current implementation that we will need to
>    fix/implement in next steps?
> - Any performance number?
>
>
> About patches, I started to review, but I hit a wall with patch 6. It's
> too big and really hard to review/maintain. Please split it (e.g. the
> refactoring for vsock_assign_transport can be moved out, etc.). Also
> there are too many if() with conditions duplicated and few comments on
> those conditions, for example:
>

I agree. I focused too much on quickly addressing Sashiko's feedback and
things went out of hand. I'll rework the series with a focus on
bisectability and readability.

Thanks for the review, Stefano!
Sergio.

