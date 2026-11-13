Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794577796;
	b=HoGarUzDStVuIQtexoTUkNObBbW2QYJluZgdCQaYmI48IjWppAUksV+B1rF2M/oOWKMp
	 ZyZDIryZrBckCpMN/vxsNo7oG5pYe2hl0Otj+1fYSzBt75F79NbTaprAnCeBcljsN/Zeo
	 GObFghG+vUlR2MzOu8L70lr2+1of/kHq9YoB/DC9bmU1t/jXiDny9exTBTXfUmdVs/Bu2
	 0rP6gMr2h67ZY033+ERUQhPikZ7rk8pQGfOAstTYUm88uWxVtUDdGzdDW8rGPHo5xJIO6
	 36sIqP9dAoc9PdrbSYSRUEYpWF9Fj9eosE4X/wzUTOkHU6nyBbLp0sxUZfJteM1gPKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577796;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
	b=Dg8jBYMepQLQFPha/V3nHh1U0FJ+WAaNGUFOV8+Lxt4uvVokafPpkM/pweXvaIJCAPbl
	 IIWJc68JUSyDKiTbOcrhMv+rY5rgzqtXBhH1imU43rM1DHA7nWxuBjpajkBAgYM9MRa83
	 m3kprw3b763k80vtM4hLIL5qVRQmnYjJyf1YPeDwWM58iCCZMRAlwLBuWFLQ9b6PBfscZ
	 ty3cK1ZuHk/u959FrA4BD8H5R9MD4mZnbeS0IhpP0e7O1fEcY2qA150fJG8nAFAZO3GKO
	 1mROjajWajqIwDOR1qnnvQCA8Hs6K9qxZeSJPn+aUUyZNunPjGHcYQduYTkX7I8lBFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dnr4bWaa;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ga5oluTv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1103F60A3833
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1103F60A3833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dnr4bWaa;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ga5oluTv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794577795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
	b=dnr4bWaah9/wySNrHe71UxG7yxYO1hP4OJsDO4UuONplGfOBRiaQICVPWXH0a5xAfClVPc
	t+VpNg58eHK3YP5XWW59CAcUzV5E/GfH9p/c18EmHQRz6zpg7GqxOWWu1kW44oqkX5txvm
	zu2Lk64sIPPATltWgXHym6Mxatxh5HU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-AIxoY3VEPLWnYAZ-aKMQ5w-1; Fri, 13 Nov 2026 08:49:54 -0500
X-MC-Unique: AIxoY3VEPLWnYAZ-aKMQ5w-1
X-Mimecast-MFC-AGG-ID: AIxoY3VEPLWnYAZ-aKMQ5w_1794577793
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91eee6fa56bso10504446d6.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:49:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794577793; cv=none;
        d=google.com; s=arc-20260327;
        b=j8nX22KejyC4NryhtZmuHfSDRAeepTKsBHy9+jeMK8FsDY0/4pZ0Ssk9yxuCiBbnt3
         KVFq67YxQgEPvVMLuSp4rnghZsr6Myk5S/wEGwwtFl0Ka6C0lRNMYSejUXfrQOOLRW3d
         fi57Rb3Ykp4PmD5BcTsc/5XC6mtKlAJ+8L0cBZUxUSrjuvBWeHdINwPQkXiEY7I+6byp
         N2oiQo7fTn7c/stHlIUCMxeIINs7CF7zMDsDlCC+QOdl1Qvb0Y4F5WgdipgJzElArOw2
         5bvcZb3Ck/TXX+hK1cJcDpVsypPn269lscFq2gCaNSnMnVwlOWpcQCLlpBwmxLMdQ969
         8TFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
        fh=EReebtxhq41lm14Vtii6RrOmEmsjgJ12YeYyoidGymA=;
        b=mgedT87mb6NML/Rf5wqUIy1/rLUkrvPAXtxdnI9FUx8v124cYAFXPkspDPH583dKgT
         WHu1BAFuxwZbvzhi1Nd8mL2OR4+tz3MyJA+9kHiujO7ZkfDDwBw6S72fT96HJbe1Sopr
         wOHqoVQLhFDMDFUzX6alzHI+frPhvs6ULExGSv61LvzaUEmKwajrmyMSB3U6/BOYfwwM
         lumyvANncTBB8iQdHR8Qe+IiBvDLg5JoN3Chq+HuMI6DhMxplMIivwuvwMPtIIwAaEst
         eeayvK+qtfbr5AA5N2byq/aJj1b/s7hzI/xvZx2AMWEStBdAEWfOkk8jAVBGTk+8F99X
         iYPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794577793; x=1795182593; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
        b=Ga5oluTv2VoCAk4tJJMwd4DcHxnzZN8P5RMMfsYuwHSiMT40x247pqXYZppw40aUfp
         AgXHj7O5P5EGzLh4fIFmrS2LDUH+QEQZYT3NfXESJ7+2AAzl/5iG4ssuum/lz5MnkbiY
         FEWaupRQi3hJm3DKU1Rj2ZQVesMwID+ZlD3yg4Dcq13ucBIA2y5CuZZ0qDg+hag5pCQ2
         rQ5GzjunzI61xrZyS6U/SOWzCL5dpAMnK6H42AAF/0so3HDc8I1e5CduBSEcu1Nj+iKT
         Na7YqNXXzrX2iDdPop6PnLFczlm8s6Y4c3Y6Takf75DT2e9wYXuz0ZE7I3UrxJfbFVUJ
         fD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577793; x=1795182593;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
        b=Ci4WpZeSRmpoMhcwPpeuIQz/fw1O9Ws9Jbb4rYbUEhBGkWod0nCb1BsCYjevB5PpPl
         t0olHS7GeD0omCrYqnEELgmpWtVI0jyb7YyeK+ojs54/fr5l4LcQDdhfBlolAy16hef4
         oVBaE8Zp9ONxJ0cloe4mYoTNjb6gsbYMaHKnIIZoJph8+6jkwcJF/UZEM1sbIwbfHiiF
         JVd+rZ+R0nEPcYtQoxx6u6nYhzRqPldPRqDiOem0CAiMlYc/XW70f2ILtsKFikT2UIKw
         qODj7bCYpiXUlIrNzluaofUNsXzauod0PSGTUc9K6xEUJrejCjWn6sJKp4/9jCRAwpbI
         vpZw==
X-Forwarded-Encrypted: i=1; AL+hErGJg/ZIYPCNxoL3D1E0bOsMW0tw+Z1khbAiYTJXIZodoms3gAiZu3qFFZE6CLZsAZshwj0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JUnNQUqIuonLXe4/P0KSJECekr3ElOZ1Gn8Atw0tqiYghx+cy
	NbqYwu38A1r28TfAonQnyI48q4TdFxW2X4+S6JAYb850P42hzdy13JiumqVPX0HgRvmyaBKup0l
	fMaO1Fp1do0p7zWpmt7pV1oYxbVXmI0shCbECadEGXHv50zaM8KgwTNb0lszyNpipaSydMM33FW
	gvADFkWQDPEWnuVDfWoI5v3F+mAIF5
X-Gm-Gg: AYBFou1pcecXsOD1NdWeB849aBtrFjzQONx2yk3DMw5Qi22AH+WIPNaYTb48OkNz2Vo
	63LWnQwufhxkF+r+86yzJ+A9n683AvFu121gXps0pRITgUwBE6Q9A1o4Nl8EkGgE2C7q0Jg4w4S
	ashWsFuP/qi4wnyZ9RuJ6HBOV5t7SUJXbBZjNsAMwhpM7b6P2ij2Isubg=
X-Received: by 2002:a05:6214:85cd:20b0:91e:89d8:a330 with SMTP id 6a1803df08f44-91f241f6d2bmr27649236d6.25.1794577793121;
        Fri, 13 Nov 2026 05:49:53 -0800 (PST)
X-Received: by 2002:a05:6214:85cd:20b0:91e:89d8:a330 with SMTP id
 6a1803df08f44-91f241f6d2bmr27648836d6.25.1794577792581; Fri, 13 Nov 2026
 05:49:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Nov 2026 07:49:50 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20261113080506-mutt-send-email-mst@kernel.org>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com> <20261113080506-mutt-send-email-mst@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 13 Nov 2026 07:49:50 -0600
X-Gm-Features: AclHuK9yYj2AE7jCL2Q7aluEqsTHouql9M7zvOo0Tu9GOsA54iFCZqauW8Q06G4
Message-ID: <CAAiTLFXvuHY=r8FPM7TFNTAO1oyco-brcc6YAc=YN432h87RSw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/8] vsock: add datagram support to virtio and vhost
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Nov 13, 2026 at 01:47:33PM +0100, Sergio Lopez wrote:
>> This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
>> the existing AF_VSOCK API. It is intended for guest and host services
>> that exchange independent requests, responses, or events and need message
>> boundaries and sender addresses without a stream connection or application
>> framing.
>>
>> VIRTIO_VSOCK_F_DGRAM gates virtio traffic in both directions. Each virtio
>> send carries zero to 64 KiB of payload in one VIRTIO_VSOCK_TYPE_DGRAM
>> packet. On the RX virtqueue, the device may split a datagram across
>> page-sized guest buffers.
>> START and EOM delimit the message; the guest reassembles at most 64
>> fragments and 64 KiB before delivering it to a socket.
>
> where do these limits come from? how does peer know not to send more?
>

The 64 KiB limit comes from VIRTIO_VSOCK_MAX_PKT_BUF_SIZE. The number of
fragments is a reasonable number to prevent the driver from putting too
much strain on the device.

Both limits should be part of the spec. This is the relevant part from
the draft I have put together so far:

+When VIRTIO_VSOCK_F_DGRAM is negotiated, each rx virtqueue buffer supplied
+by the driver MUST have room for the header and at least 1024 payload bytes.
+The driver MUST discard a received datagram packet whose \field{dst_cid}
+differs from the current \field{guest_cid} configuration value.
+The driver MUST reassemble consecutive fragments with matching address
+fields and MUST NOT deliver a partial datagram. It MUST discard an orphaned
+fragment, a fragment with an unsupported flag or operation, and any
+incomplete datagram interrupted by a new START or an unrelated packet. It
+MUST discard a datagram if its total length exceeds 65536 bytes or it has
+more than 64 fragments.

Thanks!
Sergio.

