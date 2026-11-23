Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456089;
	b=rNntLqM7GNQE1rSkrY4HvIlJuUVNp5hLU+5nV/2gYSe98EdGR62Ywvbbo2i0J0pke6Wv
	 gggivoNbQ1R6VfGmKEO1zlFo9kIETaCbSY1VuF+mhl/zBhV53on0xYqYEC0yUy41Jd9eU
	 9rvlb6pDPgIy/2COLmUEguC8PjrA3J3NwZWM3zg4DiPQZ+C6S38xBqXC8SkFt0xu1Nrm4
	 N2myvShQwbkDWn1rtXpaxUiT34t6ApDz8TOrf33ErH96Rz8a6eHSfjhHwrhN/wVO/xmVN
	 X77kv9yEOKywsaQK6Kk6XxIXtPFc+FlLNnkNn5x78FUzosJPAyfl1LUVknAlxbiS4Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456089;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=efi+X92Ps3JgkqQpyvgXaDyiPmGb9o+2rCD9ipnlxzQ=;
	b=DDT3qteh9ctQ/5Q+jmMnhQpODvKniU4zUoUmt2/mKmvoiwyqd6HAcPsWpQtO00n29tQL
	 aESwnJYKW+3bow7bkKRhL847exA4Otu1vAXJ8g+FqFcYNlAL8xj2jRglG93aRi4i+5p6J
	 Ev6N+EyueMLb+QN0FXO89dZDxvsuVkH2YbEySZF00dldtc7PXSiKHze+irSxxDLBq9CiH
	 UCVl63ZXNz7o9Q1eG3Nuyp0m4LlODv9prtatV7mUyX0xCA6cFd8SXv9eQCZCo3qvZrsAl
	 VK16vPkUEf0Myznpa/OivIWWQqBYClU4JVZaHfh6kh7cgCxlWptN8TYAK9MpH5YC05A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OvifqpYi;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=I7zYFimT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEED606A31E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 17:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEEED606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OvifqpYi;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=I7zYFimT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795456087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efi+X92Ps3JgkqQpyvgXaDyiPmGb9o+2rCD9ipnlxzQ=;
	b=OvifqpYi+qNMenTeo0KTT3+O4FxsSjqymWBDsEh/u5y4CPbNGO1XHs0o658glK4qTYJAmY
	hYxlhBOiCLVGyMnJn6C05acO0ngqtPegUi9A5AJgJGmW/o3PbbihgDBrpenjIlyfI8xPXu
	aMT65JEGNHIioYx0kjGzzcnX20SwddQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-W9lEfmjfOvm5UOOx-RhANQ-1; Mon, 23 Nov 2026 17:48:05 +0000
X-MC-Unique: W9lEfmjfOvm5UOOx-RhANQ-1
X-Mimecast-MFC-AGG-ID: W9lEfmjfOvm5UOOx-RhANQ_1795456085
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4a9be7586ccso1798295f8f.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 09:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795456084; x=1796060884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=efi+X92Ps3JgkqQpyvgXaDyiPmGb9o+2rCD9ipnlxzQ=;
        b=I7zYFimTiLk4Rzqu2GcOQhrgfJCXrZm/XNcZ2tfv+D2MLltzagr/s2AK5ziRgSrbFf
         521KK/PuYN5ONOC+Kvi5yJpoS84/Ex7dtnbWIV75OSFSAKDRQyHrzyo7ewFA5UieNJuB
         fHFMjJp0i7VnmC1G3+Up7P3E9bM+uJK/KX1TIP+qP+JxtbvI/io5V2ejRC9Zm+T4SZx+
         S/QJvDnxMFT7uFygTGaZc1/qf3kDhzukUzq9fWvJ9Q8C0PPhnRkFhRh51CDBBqwkCQkY
         4c/zJS5tFpDoIsQzUT7bzxnZ2eTamuJdMLjG1LJAIHYKvlUEUk3nt6AGUbi5QXBl0eBF
         u/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456084; x=1796060884;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=efi+X92Ps3JgkqQpyvgXaDyiPmGb9o+2rCD9ipnlxzQ=;
        b=zfOVxW0XXs6+SwDsDu5vnn11gr079xvluogz57OxCc/UY3armvB5pJC8VfGBU7L8MH
         I2N2g9eJ+sB9pJm3mWzIe3c3Zw/qCAsRR/JuSmNEMxG0qKAjyRrde8yzquwFZmGjQwyH
         Ib2b/sMRd4B67sUZo44LE9rrgnM4DHcpoFCa+BJcTzoCQAZmoqCN27kYhcTnn4bWKjur
         IQHR4RhfILrZYLAXcaMgN+STcz3ajqSgVNVsU/0A3YynR8jmrf7IoO3CS7J4QB2Yu2Q4
         antYlSYBrhnyzOLF16g51uDr50XkmEJG7sCESOMLdJvyIe08/Iv9Wl4L4cZfEr3yMUlg
         udkw==
X-Forwarded-Encrypted: i=1; AL+hErGJDzKVDDu1N6Xd9Dr0OfpwWS7V8Kx9+KKcgvdfaZcOkk6k1dp24eNCW8nVk8j+n0/G6gw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yS1o7XsMS34vDaFnPiagu8clrlDA+8R0vARw62f+3oD5p/I6/
	L/S9UmFYo4VcgQisbRFmBNOq7zPXb3bKv1xqPsIn6wdypIld2/hu9iV4SGmygA4f24gel0mFfIj
	56H+9pzvDMOmUaNLIUYd4nF+2xK8ka0xnJm/awVs4zhMa42tjv343kg==
X-Gm-Gg: AZFdTZdfqbkd1GWAryoLFeZ609KVn8GLW5pAdwCjhxpDh/IcJbYz9cMtECtZFuHaUh8
	wvTCLiRH1AMBymtQ8OOSEs83okkO3ih5UvoGWl3/e7F76OW8xBCxWReRM+IZZcfZh7lqtDD7z71
	JDi9JEK9WFaDrp9/t90RO1lxNieAa4wzr0WP44uJQIcTuRNdtDSvdWi17310Dt7K2565Gjpq59s
	qE/vR2zZuuQbHGQfqiERh/Qh6bmfepNm9UVmmUIMWEZvMhl8MrNI85ud5NM/ZDJd2YdgEm1CtF3
	AIJeIqlU1MJWgm9W7QAqXFksCQbXWUWAbnjerYI4Yw73144N80LfTHVDwpZgMW0ykAClxqURJQQ
	xHDvNDWe7OwrWJopVcfS/+MkDQn7nDvW5Jlz6dMxm
X-Received: by 2002:a05:6000:4012:b0:4a8:f1a5:efb3 with SMTP id ffacd0b85a97d-4aa550796b2mr30453921f8f.11.1795456084338;
        Mon, 23 Nov 2026 09:48:04 -0800 (PST)
X-Received: by 2002:a05:6000:4012:b0:4a8:f1a5:efb3 with SMTP id ffacd0b85a97d-4aa550796b2mr30453857f8f.11.1795456083757;
        Mon, 23 Nov 2026 09:48:03 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1524:9e00:c39b:a740:e7:3fcf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989eesm23541150f8f.50.2026.11.23.09.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:48:03 -0800 (PST)
Date: Mon, 23 Nov 2026 12:47:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost/vsock: annotate lockless accesses to guest_cid
Message-ID: <20261123124426-mutt-send-email-mst@kernel.org>
References: <20261117164916.2332953-1-phind.uet@gmail.com>
 <20261118012321-mutt-send-email-mst@kernel.org>
 <a7752192-b417-4e70-8f39-a3cdc983f447@gmail.com>
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
In-Reply-To: <a7752192-b417-4e70-8f39-a3cdc983f447@gmail.com>

On Tue, Nov 24, 2026 at 12:48:34AM +0800, Nguyen Dinh Phi wrote:
> On 11/18/2026 2:33 PM, Michael S. Tsirkin wrote:
> > On Wed, Nov 18, 2026 at 12:48:43AM +0800, Nguyen Dinh Phi wrote:
> >> vhost_vsock.guest_cid is written by vhost_vsock_set_cid() under
> >> vhost_vsock_mutex, but It is also read without that mutex in
> >> vhost_vsock_handle_tx_kick(), and vhost_vsock_get().
> >>
> >> KCSAN will report data-race if we issue VHOST_VSOCK_SET_GUEST_CID
> >> ioctl while the device has TX traffic. For example:
> >>
> >>  write to 0xffff88810f1596ac of 4 bytes by task 7914 on cpu 1:
> >>    vhost_vsock_dev_ioctl+0x25f/0x720
> >>    __x64_sys_ioctl+0xc2/0x110
> >>    x64_sys_call+0x299/0x20a0
> >>    do_syscall_64+0xc9/0x510
> >>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>
> >>   read to 0xffff88810f1596ac of 4 bytes by task 7910 on cpu 3:
> >>    vhost_vsock_handle_tx_kick+0x41b/0x740
> >>    vhost_run_work_list+0x97/0xc0
> >>    vhost_task_fn+0x98/0x1f0
> >>    ret_from_fork+0x2e2/0x3c0
> >>    ret_from_fork_asm+0x1a/0x30
> >>
> >>   value changed: 0x0000004d -> 0x00000032
> >>
> >> Both readers load the CID once and works correctly with either the
> >> old or the new value.
> >>
> >> Mark the store with WRITE_ONCE() and the two lockless loads with
> >> READ_ONCE(), so KCSAN knows the race is intentional.
> > 
> > You make it sounds like it is just KCSAN false positive.
> > Is it?
> > if yes, this should be data_race. If no, document why.
> >
> 
> This is an actual data race, not a false positive. The value of guest_cid
> can change while the TX worker or lookup path reads it with plain accesses.
> Because each check loads the CID once and either value is valid, the result
> is equivalent to the read running just before or just after the ioctl.

So, no bug. Pls clarify in commit log.

> Even so, plain concurrent accesses are a data race under the Linux kernel
> memory model, and using READ_ONCE()/WRITE_ONCE() also prevents
> compiler re-fetching or tearing rather than just silencing KCSAN.

It never happens of course, but avoiding this
in case code is refactored could be ok.
Pls document that as the reason to prefer READ_ONCE.


> >>
> >> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> >> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> >> ---
> >>  drivers/vhost/vsock.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >> index 88a310390eb0..f26c59013075 100644
> >> --- a/drivers/vhost/vsock.c
> >> +++ b/drivers/vhost/vsock.c
> >> @@ -78,7 +78,7 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
> >>  
> >>  	hash_for_each_possible_rcu(vhost_vsock_hash, vsock, hash, guest_cid,
> >>  				   lockdep_is_held(&vhost_vsock_mutex)) {
> >> -		u32 other_cid = vsock->guest_cid;
> >> +		u32 other_cid = READ_ONCE(vsock->guest_cid);
> >>  
> >>  		/* Skip instances that have no CID yet */
> >>  		if (other_cid == 0)
> >> @@ -572,7 +572,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> >>  		hdr = virtio_vsock_hdr(skb);
> >>  
> >>  		/* Only accept correctly addressed packets */
> >> -		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
> >> +		if (le64_to_cpu(hdr->src_cid) == READ_ONCE(vsock->guest_cid) &&
> >>  		    le64_to_cpu(hdr->dst_cid) ==
> >>  		    vhost_transport_get_local_cid())
> >>  			virtio_transport_recv_pkt(&vhost_transport, skb,
> > 
> > Will prevent compiler from hoisting the reads out of the loops.
> > Does it matter?
> > 
> 
> Not much in practice: because the loop body calls non-inline functions, the
> field needs to be reloaded across calls anyway (and in `vhost_vsock_get()`,
> the `vsock` pointer changes on every iteration). I checked with gcc 16.2 and
> clang 21, and the compiler does not hoist the load out of the loop even
> without the patch.
> 

