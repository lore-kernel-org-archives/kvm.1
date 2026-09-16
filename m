Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718E7412BF7
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562181; cv=none; b=PKFRCrv7g66Z8lcrIgvH4PVHF/+nWwKSWewTVTkpqBkjgJKAt8AkEuZNwuw6WoEe/f0Rvgxv6KgyfdPKAZbQDm+vb2n4t2VZMDeCs1yzztv6PVytu9Lr5vJu4pVOnR3W2dxg4Ivjg0SSFgBnOhaBjECMQ3CsPx7UU5O4NMTEOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562181; c=relaxed/simple;
	bh=j43LFPCZ7rUBOiUq13DB94/P46Wvh+c5n7GJVgSSa8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajMYOl0ED/urtB+Mu18JiB/3rkpyX/tvhMPnNYKPviMK0w+GpebFxw2tjozAlu5pOmRCQ/f2WyrlYLddvqsY2YK5JxLuI/2x8EFrdJ4lvZyh36nK9YqKd+hKcR+ziZXZN4/rhqp9cDvyVQ6btJdKVSfBue1fEUyA+w+iYSgp0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EvAfabXl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikcLr5Fb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvAfabXl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikcLr5Fb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789562178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j43LFPCZ7rUBOiUq13DB94/P46Wvh+c5n7GJVgSSa8E=;
	b=EvAfabXl/qEudjdbqezYT4ZZbT77u0m8hnuQmMLdpNQHaETG7Gf72TtaCJm2oJltK3rW76
	wTmq3vka6ru0GrV5Rj0e+aDxLzYi9cqcyqMRcicg115lk0RklPa6koSK+Yuf614XKOYdh3
	2mzl096OoQ6rKQ5RkAlT9dS6KnSlfUE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-XVQdqRv8M3qX5Hvm74JFlg-1; Wed, 16 Sep 2026 08:36:17 -0400
X-MC-Unique: XVQdqRv8M3qX5Hvm74JFlg-1
X-Mimecast-MFC-AGG-ID: XVQdqRv8M3qX5Hvm74JFlg_1789562176
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cf9df1eadso54739205e9.3
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 05:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789562175; x=1790166975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j43LFPCZ7rUBOiUq13DB94/P46Wvh+c5n7GJVgSSa8E=;
        b=ikcLr5FbZMq85EGq9fBe8+Pc1Dy101TfX00wqJQ1Hl0MXhXFi1le4K1PYcOPIe6L64
         rYDWn8FfV7G1Q1C8SgVc27kq8nbT1WrRNm/0RjchbUsdZJvY5IQEcQ7oxTYoHIqrBcoz
         3ioq/NLHSs6ley7/cWxh+PHx1YFVjieSx1TfPi4DrCP+ejAaMI3tnOhfipXDmij7oHSP
         /DmWzOJaFLYUcN4lTsiSJyTzYPRZUxr0MqswO2tamt4y08vHGE+kKzv5fD5PTyNxm1WJ
         ZnPPpnw7IQ9fLTWZ9/SVPy+P55Dy+7x0oPiBD3//UgiSSUzpNT8k+DU3ofnrGyhJiXpd
         tL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789562175; x=1790166975;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j43LFPCZ7rUBOiUq13DB94/P46Wvh+c5n7GJVgSSa8E=;
        b=Vq+pHPndBkc23ISb5cgy+rcSbkw/iC6MzPwU6PpfxB/oP+x5dspWBFVlXpQoCq3LA6
         7kOcLl0jJqLwWxPlkqBMXtkBBDBxvKqYX3S3TukZM2X7bn2eLZuAijQcUvdTWD6TyK8H
         Os+EGTyPLtAX9zx/wguw8tXAj1mYb85ll5hiebK4N4ZP7VdgjyLAOAC+Ph151ZayZg5M
         ++LBIICDg2BVtW2ri4xY4o81/0xluEGB0mMRiFpOMmK/Iq5udt+IIB0jDHz4XuiNyJ39
         iLW4Kqu3b7xrFtSrIpoIY3FKBDy6GP/lBKKmxFDytXt4x+qcSL/Ku2+6OF0Gjpi7KvB/
         joOA==
X-Forwarded-Encrypted: i=1; AKwUvBx/agC25T6oAukbCD+36dYicRB4twWzi7Ck3flXzOC7/cqcj/upALxIzdv4cPI5CRLrdlc=@vger.kernel.org
X-Gm-Message-State: AFuF++lHhYfyH4srsf7DWkfEACEn2rJ2yeVBPL5dAvTli6rypvJZSKvi
	IxhqDGW9Qi/WoLD7EI41W5DAuIrZcgr3NcwpPzREejSZ4OAOkxWOGxjkk4sqYhzboAwkWhCQSDc
	gH6wnw1IOH+gGUKcB5Og5D/a9DBjxX7aXYmyRwFsRDU+SGODT28jKnw==
X-Gm-Gg: AYBFou04bSfnjnz6do8g5PO/MbV68kNHnhOmX7QYXmsLTYHT17rOndBhUHG+TZfaTjt
	WX8BPNgJdY3On7BbfavNlofDjSKY2UlK6Ahl+n4nclPuJ/XcxUbh9M0vTFjJ3deiV+dNjNH/oeo
	9qqPnsQoekU3Z6AAcusTc1XlW0qwelzjIr3aF4hW5MnOJJnXDTRCfoUODvNCwCSwbfX/S4Fp+5e
	BxdFI4A+GE3lqHZAoXR3jqsM28/+351BF8amGrA3uawJDwNU8HBVjPSziXDlxj1L29Wr6QT8LMG
	4wkud+6ddm2RB0tbHFdGz2O+BYwxVwz+xNR8WlXnU+8wrtlutqztpioPri5a3qHZ4Euhhj+m9Ge
	0bW+a4UoldpiM0Qo+UKoVEP4ACmZfRT6D5KzPo4vutfJK/g==
X-Received: by 2002:a05:600c:698e:b0:49c:dada:f57f with SMTP id 5b1f17b1804b1-49eac4638d8mr29033485e9.7.1789562175596;
        Wed, 16 Sep 2026 05:36:15 -0700 (PDT)
X-Received: by 2002:a05:600c:698e:b0:49c:dada:f57f with SMTP id 5b1f17b1804b1-49eac4638d8mr29033135e9.7.1789562175106;
        Wed, 16 Sep 2026 05:36:15 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83da071asm93775155e9.8.2026.09.16.05.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:36:14 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:36:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 0/6] vsock: assign the guest vsock device to a
 network namespace
Message-ID: <aqqNEl6Hyk_h9C8r@sgarzare-redhat>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <apqGcFDFm9_Wtw4q@sgarzare-redhat>
 <apsANK7ySuRzzK0V@devvm29614.prn0.facebook.com>
 <aqkaTXHDf5nfPL9w@sgarzare-redhat>
 <aqmDuxMuEN5lS/0J@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aqmDuxMuEN5lS/0J@devvm29614.prn0.facebook.com>

On Tue, Sep 15, 2026 at 10:43:23AM -0700, Bobby Eshleman wrote:
>On Tue, Sep 15, 2026 at 12:16:47PM +0200, Stefano Garzarella wrote:
>> On Fri, Sep 04, 2026 at 10:30:28AM -0700, Bobby Eshleman wrote:
>> > On Fri, Sep 04, 2026 at 10:55:17AM +0200, Stefano Garzarella wrote:
>> > > On Wed, Sep 02, 2026 at 04:00:46PM -0700, Bobby Eshleman wrote:
>> > > > vsock network namespaces let a host put each VM in a namespace of its
>> > > > own. A guest has no equivalent yet. It has a single G2H device that
>> > > > cannot be assigned to a network namespace.
>> > >
>> > > Thanks for this, I'll do a proper review next week, in the mean time some
>> > > comments below:
>> > >
>> > > >
>> > > > This series lets a guest move that device into a network namespace. A
>> > > > new ioctl on /dev/vsock, IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS, assigns the
>> > > > device to the namespace of the calling process. The namespace's existing
>> > >
>> > > Why an ioctl?
>> > >
>> > > I'm asking because I'd like to know if you've already considered any
>> > > alternatives (sysfs, netlink, etc.)
>> > >
>> > > How do you think the ioctl should be used? Should we provide an userspace
>> > > tool, or extending some existing tools?
>> > >
>> > > Thanks,
>> > > Stefano
>> >
>> > Really only because /dev/vsock exists and the prior series used it.
>>
>> Yeah, I vaguely remember that we may have discussed switching to netlink in
>> that thread, but I can't find it.
>>
>> >
>> > Considering netlink, it might be the better option because there is a
>> > lot of prior art solving problems we might have in the future. For
>> > example, I was thinking about when users suddenly lose access to vsock,
>> > with just the current assign ioctl there is no way for apps or users to
>> > figure out why this happened. We can have an ioctl() setter for user,
>> > but in netdev world users can actually get a notification via netlink as
>> > to which namespace the device went to and what its ifindex is there (see
>> > __dev_change_net_namespace() for the RTM_DELLINK and RTM_NEWLINK
>> > messages). There is probably more, but that's the case that comes to
>> > mind.
>>
>> netlink seems like the right way to go, do you think it'll be a real pain to
>> implement?
>
>It is really not bad... it'll include a yaml spec in
>Documentation/netlink/specs/ of call names and perms, a new target for
>generated code in the Makefile, a handler, and then
>tools/net/ynl/ynl-regen.sh generates the plumbing.

Ah, nice! So, do you want to try that direction?

Thanks,
Stefano

