Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F164C9E0B
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578033; cv=none; b=rKHr+BDaSbiUHACQgbUNYuU1FBSbQxB74RMSh8TTVXKcgs971YZKGXihRtT/YP8yoguLyMt2xNkMjiUg7uO2xrkhc41FxIVLncMwr0f4wiXvFz/JhpdPfZNN4G0YG3X68O+F8D7rT7tgKDt85aM2ecf+HTR7MjZwzgZxZsslwYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578033; c=relaxed/simple;
	bh=Ky6tqUlPctwf9kmSA68nL3wRxEYqHtONMZuz2rSl+Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yf2NVw45JcQAtIJGE01C4wvh+nYM6qUEBcvv8DwGfluiOKtWKL01s5/2ELTrht+ntbyUf+IF6LFfWMHVUvJGuHE+IOQFzUZTNTiLsxJgT2jGK7zMvpeque+2MfTYA7xSYPMyAo3l6QCbvj+YVmsrMzlbo1zSzSYWh7CB6bey6eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwleqU+q; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwleqU+q"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-80a4e050a12so875553a34.3
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789578026; x=1790182826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kV5xMCFq0mEVtZsKF5EmMvJNOJj0hLOiv+MHAekOLlU=;
        b=CwleqU+qwDJqo0nfZyXSHaniEuvEjmfULs6m04T6ewFsw9SzfvGPJvlX9oI70uDtFn
         iKChCRYV7Qdr0g5vnglAOA0bs8/kgb5MGs1MzJF/8vovGSYvEyoA5YF/AvlX/ETDbeZ6
         R+Ua9WdMASXl1NPG3EGT5F8W6VSLE+hCNHSGsGxE1GDs+RIPYNOaRg/qYo1maPOqZkGO
         S3jk9YUPE8eg2eGHwpOLLBt/hF6tveJZWcQ77RIkfmzqWpfHG3hFOTT30/czZqE1EkUC
         LooNvuRExj1xly26BNGdCcM3Aoxlbunrlq8jhSaanWYR/HihhpypzvaAoooFm3L9STlw
         RgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789578026; x=1790182826;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kV5xMCFq0mEVtZsKF5EmMvJNOJj0hLOiv+MHAekOLlU=;
        b=TG+ICMI/FPeDlBOS7JYRgOOudJNAquqq8slAPcw8Icd9dx2+Q/GAnpqFKjQluG2Sya
         bI2Tj7klG5waT7eYTP5o6vkgT5/ERgNpu9f3Kx2+RwIhmaRrgvIUxFYY4gpWglMXuFpU
         iNZHTDvRaf5Q4nGMA+W8mn5KOmsRRLVnZ5I+GYKqnWZzfVh7a0j8Jr36PEMNiMu4DvRh
         RuIWWR9U9qrLhN80ATNsngcNmf0XhzphRmnVyFgi2Nt6Y8jKubW7UV5QAfieL1Yh6ino
         dyjwGJJUDU67Z24tMSEnr6jEwqEAU4fYn4/OHDtLUKgNOD0Y+lei47y7N6RKNpqT3T9l
         LfJA==
X-Forwarded-Encrypted: i=1; AKwUvBzD/Sj63ojq7kHdZIh7e4L0C4GUvp5LPtuXLxyu7hk0fRIQNb7sea1h9PWWUgPhnmwS4F8=@vger.kernel.org
X-Gm-Message-State: AFuF++mAa0lKlsmmlGHGusjokNPrDk77Lb2RdT2axtKKn4Bxt6XxVVmu
	oTI0wpOKmUWf2c+2Uk/5YNxm1UGsK5u/n6RuXXncNry/jqWbpWKVLysR
X-Gm-Gg: AYBFou2OD1dwaUUbzSBV2Tpcr3WwrA3+BHFugl7RvH0bWJ+tih61vBXp/YumQnYlT57
	5IKXomc2xr4aNTRKX/BUnD0+B2MjbRDZpHURLkwxtRRA+PxtoDJzTdR7TokqW0ffoHrEYNiSAE0
	CdU0Ywa6exHJRcu95qBNeL2t4NiUqeJWS8zRBT3tVBAdfiZUwb/en8+ccEWM6GhbT/NzRG7RA29
	hguVGwQ0emLVo14UV5YSZWJabVCc7n4S5scrb7tfeAs1en2ZUV7Mr5ZnATfsvscdw0QQHC4oRZI
	IpObsRLx0C96tNYUJwj08oyf+R4BbyLCYlmVJFkobVx0gcff7xDwkbkcayg7xO7Xn2c5fppxUKs
	VpdjCl0M4nQ3OqpmRoMppP3yC0MxsdOfsmRp6gDTSDGtoAjn7ktjv/a9qPkd0oSaJ6GBlxYkO2Z
	+7YyaB+z1mckgY8at54nYYHMcaM3KFnTIdAWHVlxFc87qOA9isYTcAt6vOWomgN4kaFrAEZKJn6
	kMRWPi+tQNTAsoA1I3S
X-Received: by 2002:a05:6830:67d5:b0:7f6:96ad:36a8 with SMTP id 46e09a7af769-80b2d416a86mr4148110a34.8.1789578025959;
        Wed, 16 Sep 2026 10:00:25 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c4619a868sm391941a34.8.2026.09.16.10.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:00:24 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:00:21 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	sargun@sargun.me, jlinbox@meta.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 0/6] vsock: assign the guest vsock device to a
 network namespace
Message-ID: <aqrLJWnHJ8DxK8cF@devvm29614.prn0.facebook.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <apqGcFDFm9_Wtw4q@sgarzare-redhat>
 <apsANK7ySuRzzK0V@devvm29614.prn0.facebook.com>
 <aqkaTXHDf5nfPL9w@sgarzare-redhat>
 <aqmDuxMuEN5lS/0J@devvm29614.prn0.facebook.com>
 <aqqNEl6Hyk_h9C8r@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqqNEl6Hyk_h9C8r@sgarzare-redhat>

On Wed, Sep 16, 2026 at 02:36:07PM +0200, Stefano Garzarella wrote:
> On Tue, Sep 15, 2026 at 10:43:23AM -0700, Bobby Eshleman wrote:
> > On Tue, Sep 15, 2026 at 12:16:47PM +0200, Stefano Garzarella wrote:
> > > On Fri, Sep 04, 2026 at 10:30:28AM -0700, Bobby Eshleman wrote:
> > > > On Fri, Sep 04, 2026 at 10:55:17AM +0200, Stefano Garzarella wrote:
> > > > > On Wed, Sep 02, 2026 at 04:00:46PM -0700, Bobby Eshleman wrote:
> > > > > > vsock network namespaces let a host put each VM in a namespace of its
> > > > > > own. A guest has no equivalent yet. It has a single G2H device that
> > > > > > cannot be assigned to a network namespace.
> > > > >
> > > > > Thanks for this, I'll do a proper review next week, in the mean time some
> > > > > comments below:
> > > > >
> > > > > >
> > > > > > This series lets a guest move that device into a network namespace. A
> > > > > > new ioctl on /dev/vsock, IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS, assigns the
> > > > > > device to the namespace of the calling process. The namespace's existing
> > > > >
> > > > > Why an ioctl?
> > > > >
> > > > > I'm asking because I'd like to know if you've already considered any
> > > > > alternatives (sysfs, netlink, etc.)
> > > > >
> > > > > How do you think the ioctl should be used? Should we provide an userspace
> > > > > tool, or extending some existing tools?
> > > > >
> > > > > Thanks,
> > > > > Stefano
> > > >
> > > > Really only because /dev/vsock exists and the prior series used it.
> > > 
> > > Yeah, I vaguely remember that we may have discussed switching to netlink in
> > > that thread, but I can't find it.
> > > 
> > > >
> > > > Considering netlink, it might be the better option because there is a
> > > > lot of prior art solving problems we might have in the future. For
> > > > example, I was thinking about when users suddenly lose access to vsock,
> > > > with just the current assign ioctl there is no way for apps or users to
> > > > figure out why this happened. We can have an ioctl() setter for user,
> > > > but in netdev world users can actually get a notification via netlink as
> > > > to which namespace the device went to and what its ifindex is there (see
> > > > __dev_change_net_namespace() for the RTM_DELLINK and RTM_NEWLINK
> > > > messages). There is probably more, but that's the case that comes to
> > > > mind.
> > > 
> > > netlink seems like the right way to go, do you think it'll be a real pain to
> > > implement?
> > 
> > It is really not bad... it'll include a yaml spec in
> > Documentation/netlink/specs/ of call names and perms, a new target for
> > generated code in the Makefile, a handler, and then
> > tools/net/ynl/ynl-regen.sh generates the plumbing.
> 
> Ah, nice! So, do you want to try that direction?
> 
> Thanks,
> Stefano
> 

Let's give it a go. I have a draft of it for v2 and looks reasonable to
me.

Best,
Bobby
