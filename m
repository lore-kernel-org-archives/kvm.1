Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509840;
	b=pOPUj1gSlvm1w7JrPs8DnbtTM8q9HLODtD/8D1uus92WrLaSFH4VzW23rdVZdMKXaQ8R
	 maRqnDsG2pbZ5nLUpQ4leOR116PyyaqrLqhBizub7wf8Axes5KDe/3u74ddzwyjDkHxQr
	 gTLMnqm4Zc7MYTY9NwPjXIHsTmqvfpxQPvw1UfMOmIr25GWYwEjyRgI+Uc2NX6jbtCfXm
	 BpIWoJBZuyqiNNCIEM4z57VRSdY+GQCzGqVJfCK31sixBMYucBGXhjC6i4D5BzbZdOAxd
	 tyHiPpZycYBAAzoFmaM2N6GgwXbQlMRINeFKyx5WULJq5rfi/KPX9Eerppumkz6WSXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509840;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=80CiTGjH5Hdr3PjM7hQctIDbA2YeYVq6CaZ6FaFB58Q=;
	b=UTi6yaNO5M4P1B3iUJWPXXleJ8CGkaw3cqc2FtLCPRAkIecf0GHh0cgQKS4PD1+MHpcO
	 u5kHCFRN8GER7jNvfYSUmEMnKMUZeWlVLEgnXr+AEd0I3kyN2R57h5OZQdr8NP2uAclSB
	 lv3oOGs9tZt9MPTllNe311x27j+g3pBjhK0M1fuxnV/yy7yIPToh5uR4pdRS/tUWyyN5i
	 HMboABU13Z7W+cbL39vNbbX2dke8W5RdYte1D+Az97cVNSlNDJ5LrKbTQnui5ZqPz0zWv
	 N44B4fMew1lfNb3DWCnu0yhJtcAJYSVb2ZY/AU94pMxm6mLP/1voTCZnGuS8sJiUjww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HAnHcKJq;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Bmf5Fpj8;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F29606A333
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 08:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8F29606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HAnHcKJq;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Bmf5Fpj8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795509838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80CiTGjH5Hdr3PjM7hQctIDbA2YeYVq6CaZ6FaFB58Q=;
	b=HAnHcKJqLqn+GmOd23f/AaT3loXDn/KN4f81J48EjELvs3zi41a8xQUTUo8Aa7sqaiGFdc
	j+6QLfLH8Z0mFqM2XIAsGmnFXOknwyfm2Db9IRBvQxwM65xBg2JbndMHnCWSH2Synqsonf
	ur7/7DRricEmMmlb8++z3PMjOhbnjoQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-71G-SBkzPoKi9ES09j_Vpg-1; Tue, 24 Nov 2026 08:43:55 +0000
X-MC-Unique: 71G-SBkzPoKi9ES09j_Vpg-1
X-Mimecast-MFC-AGG-ID: 71G-SBkzPoKi9ES09j_Vpg_1795509834
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bb8ae35aeaso34613765e9.3
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 00:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795509834; x=1796114634; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=80CiTGjH5Hdr3PjM7hQctIDbA2YeYVq6CaZ6FaFB58Q=;
        b=Bmf5Fpj8dfj9+YAzmmLs7zprxnhD6SqSw7cHcSsRhi3zs08vLSTERt6nt4VFpGF+xI
         KoxO5EfFihJmwOURYPuFSB9O+JlD7uaO+a0YalrQu+uG977ZkSP02FXU+hAmYXyKAqfD
         mlVrBXqV46SdsqcpXsQGiaPMoTTKEyLpYRgaivhxGsf21PvD7DyL5beRToY6e3rrPLAD
         X1RSVBzY5i2z5vmkcIiCT7ppgobuzIqjYfvKLdRcYGUMJKT7f4jtkS6Wg3jNTI977RGf
         Rv4ekNdCva491+zTMeUrOTY8gWTtDDffnC/0y0Qmkmp99TYluuZ82yaUGnprC1eQvwlw
         ZklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795509834; x=1796114634;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=80CiTGjH5Hdr3PjM7hQctIDbA2YeYVq6CaZ6FaFB58Q=;
        b=snwizsF0jkHAaQxwNRc6Hl1zjp1lrxgbSVYoTyBFAR/mg7+oMsv3qTTBeLWgiVAgaE
         l0F9UpwZo5IV4IKR+oGZ44OuxIkTDd7CZ9d4cIBxlca7aMMBP77mpdNzX214iWXeTffl
         i3cGnJMpL642agRNo8WdFH/Lwr1rb+Hs9elWpwGhU07i2yBRbkmgCyVg9t+1Uyf/FiZJ
         mQ1SuKBhkKzCXmEZvSm+oinJO3F10quL/WrOMLGwK5qWou3jGX/R4mqKf9lOyCVuONt3
         D88aIIjJy1Fkx2odAszXl76fy/NgHxEff89BAwmwv1unbKS7EJEaeLLtFDPpzAZ39/VS
         Y/WQ==
X-Forwarded-Encrypted: i=1; AL+hErEjEPaLTmUVDh8LhawYphP/OZEUScPrsNImiOrnxFkWnaLYFhpFZwQQMdPVw8dkHch9eIA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8eWbJr12r7j2JOxhXTGppOmBXVIU/4wVNfeR6wrIL6IOSzlyqA
	6oDE+VssMjkZwxoUr3Si0lZeDm8179G8yPrM/SvYhAiCqe6pfkMSwoNvLfnm1EZCr3GbR16/MjF
	BOA/Zhgetc4wT4zjmOIXkPnMqdxQ/BztXt+9JrU0wgXk0QMd3PsHBDw==
X-Gm-Gg: AZFdTZeNLtGpEWHBJqVog+hH3Vy8Z2HEHJFrmAfZ55Hx7kJGqhJbYw7nFPbkCb++gcd
	CWRDEpD+PQ5F01Kgb0cVPQ9QqCRYmknBzuHUIa5qAmzS/ORCh7s05DAqmtCAULtofZgPYJOTLNl
	dWN2RvPLiOkNrOM1OGXnaxka1uQU0jwg/v+A077p2Kgepnr5xcybvlHHnoWgLHTCGKlqGUO5nbn
	MYSz2Pv8JbeZl8k9jOAp3EJVUe6tkTt0XKurQ2M0h7D/jvkrshXGA3BkLg3/AITB3gbyO13ecur
	lb5qNI23ILfqu4TXrU1al4tRUBXza9J8ZqAfgwlts/siZq2qHqSvuUDgF3vGVi4R6vCkTpSO28N
	kXdvJGWUvdgI1cH1MpDpL215YOFumoSOw/zwzBpLOXyCOi+PNMrzRpg==
X-Received: by 2002:a05:600c:4f10:b0:4bb:60bd:5398 with SMTP id 5b1f17b1804b1-4bb88804d35mr314618125e9.10.1795509833906;
        Tue, 24 Nov 2026 00:43:53 -0800 (PST)
X-Received: by 2002:a05:600c:4f10:b0:4bb:60bd:5398 with SMTP id 5b1f17b1804b1-4bb88804d35mr314617705e9.10.1795509833526;
        Tue, 24 Nov 2026 00:43:53 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b216esm472636285e9.12.2026.11.24.00.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 00:43:51 -0800 (PST)
Date: Tue, 24 Nov 2026 09:43:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: only deliver taps to namespaces that can
 reach the device
Message-ID: <awVNJ4gXA7ZxvZcb@sgarzare-redhat>
References: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
 <awQJo8WE5Gn4nYHp@sgarzare-redhat>
 <12a2b44d-3d24-4b77-9dd5-24361d5fe910@redhat.com>
 <awQ5xzF8P0NJiCsv@sgarzare-redhat>
 <awRnZ9S+3B996VqJ@devvm29614.prn0.facebook.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awRnZ9S+3B996VqJ@devvm29614.prn0.facebook.com>

On Mon, Nov 23, 2026 at 08:18:47AM -0800, Bobby Eshleman wrote:
>On Mon, Nov 23, 2026 at 02:17:54PM +0100, Stefano Garzarella wrote:
>> On Mon, Nov 23, 2026 at 12:58:38PM +0100, Paolo Abeni wrote:
>> > On 11/23/26 10:43, Stefano Garzarella wrote:
>> > > On Mon, Nov 16, 2026 at 03:46:49PM -0800, Bobby Eshleman wrote:
>> > > > vsock_deliver_tap() clones every packet to every vsockmon device on the
>> > > > system. Creating one needs only CAP_NET_ADMIN in the owning user
>> > > > namespace, so an unprivileged user can capture the traffic of local mode
>> > > > namespaces.
>> > > >
>> > > > Pass the packet's netns to vsock_deliver_tap() and only deliver to
>> > > > devices that pass vsock_net_check_mode(), the same rule socket lookups
>> > > > use. vhost passes the vhost_vsock netns, loopback the sending socket's
>> > > > netns, and virtio-vsock NULL (global mode).
>> > >
>> > > For local namespaces I think we are fine, but what about global?
>> > >
>> > > Is it okay that a namespace with global can capture all the packets of other global namespaces?
>> > >
>> > > Asking because at this point the CAP_NET_ADMIN is useless, since an user on a global namespace, without CAP_NET_ADMIN, can just create a namespace to have CAP_NET_ADMIN and access all the traffic. Should we fix also that?
>> > My take is that the above question is quite orthogonal to the current patch
>> > and may impact old applications relying on the legacy behavior.
>>
>> True, but I'm not sure that behavior was correct since the beginning.
>> E.g., what is the point of having CAP_NET_ADMIN requirement if an
>> unprivileged user can just crate a new namespace and get it?
>>
>> Anyway, it's eventually pre-existing netns support in vsock, so it should be
>> fixed with a followup.
>>
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Thanks,
>> Stefano
>>
>
>Its a fair point and I agree we should take it up in a follow up. My
>current instinct is that CAP_NET_ADMIN probably shouldn't be enforced
>for some (all?) of these global-mode paths.

Why not?

I should take a closer look at what’s going on with the NICs, what 
permissions does someone intercepting traffic need to have?

Ideally, even though the addressing is global, maybe we should set it up 
so that within a namespace, you can only observe traffic generated by 
that namespace or its children.

But honestly, I don’t know how complicated that is. In fact, if you want 
isolation, you have to enable “local,” and at that point, with this 
patch, we’re all set.

Thanks,
Stefano

