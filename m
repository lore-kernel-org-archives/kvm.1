Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3DF3F5BD8
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817286; cv=none; b=lrA+JEY9+sIMuxrGCcc3KVMybRUMCbkDW5SIHBm0ObVlshX1BC7dRjR0Lwfy22WqvkTk1Kiw3O5n1vmfbHsvjHC8JpvVw3pbVGcUseq7MUOK0aGA2gzhGMeb1TSHsXQBQMSfj6+sDP8jbnxrxjpexxQTzh1aLNOaUKvaelLAIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817286; c=relaxed/simple;
	bh=1i31BeRMFT9Vp3AcAN/RmvKH0I2VjZNU1gijNLV1tQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFua/5f6hqiRQ/azOawWx3TAI+DbOUvlA4g+Cx0iaWmxIWJPidD8axhivtzql25cVTI+WlWsJCs/BC7dRu4HOcapyyXhv31rMenaHxaMG70lbkhNcOVxIlRgZnuRMA5YaKJ1kBnXialKfk/aR8mufcACOzhYLPQYMnVnXP7o4Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAKIKa1Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwbZ/tou; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAKIKa1Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwbZ/tou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788817283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JaECoODu5PWLeAxmwxwy2TeJHbPjZIpe/fjVw/Ok5Aw=;
	b=cAKIKa1ZYohFm/NhUl+RG8nJyjM+r8RcUeq4UfqyixAgMboSjp7T8ydcjktr1rURruCSXP
	arTs/cHbaiFjWflxndWbwgjlJzxvq0mk/CX9uxR+cVjmx+l4n6FV9nzSv9IgReOiCTwXYD
	C20ACJFffn2Q91m/Oqniige6GyrYEVk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-p4PGUuskPGKT9AX50WJraw-1; Mon, 07 Sep 2026 17:41:22 -0400
X-MC-Unique: p4PGUuskPGKT9AX50WJraw-1
X-Mimecast-MFC-AGG-ID: p4PGUuskPGKT9AX50WJraw_1788817281
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49ccf17d3b0so27672525e9.3
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 14:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788817281; x=1789422081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JaECoODu5PWLeAxmwxwy2TeJHbPjZIpe/fjVw/Ok5Aw=;
        b=KwbZ/touk+AoUhpw0CA+kuWP4KJaWRcAs0VioiQxmHKxPu3u2ryvllNKDnaMU1GWu3
         U1pvRlogoiJOzpRfgLS1XYugdwusm4fV32DY63FJwQOndhcRbD6css1FjEgq5muyJMrm
         rodi7NG6Vsxa71/PB6KOwoVUDzb3cka4Pobt+euydUgxhycKec9zbo1CuzwB31lHlO1n
         zIllMmJXB0vgkrY7Lw+Gu9QxW7QIp6z99phXK3b33/GVYptr4qxyC9lu8a1LKea3BcQU
         zk9Rs1JO8+xIPDqqhGuNW+Bk77hTMpTDUFbY5Hvl/YGOhhNpGV8DPQqARGwNiiyFCkcX
         1+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817281; x=1789422081;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JaECoODu5PWLeAxmwxwy2TeJHbPjZIpe/fjVw/Ok5Aw=;
        b=IqNF+6UiHqWv/eJ3tt7wzna36V068dJcfc6bdGhcgN4KCb0/ZEWyDX3Kp7LwClo4Xt
         fs7j8amXcWVhXNhxb+PCas8FHbHW0Qx2bcen+aqtjsEe+1sn2lt5n5mwB4Ix4v4rp67M
         02+eL2bD396Z5KRGWHGvuOWH4ti4Dd+1BLKMuSNaSM4RaIHk1u5yZVVgEjanRsV4bQgl
         jwIf/IbIeM8/LqoQuP3dKj7NQlj0CH4jzF2NgX4l8j9ccp631nOuFYF9RlHBrd/YCTs5
         Med+HOgxl9GAHEOqRKk8QcP/piKwkH9GCE184EkU6ndIO/o1OEo0ePwJfMi/7LiVmoVi
         OG1Q==
X-Forwarded-Encrypted: i=1; AKwUvBz56Nr2L0nWRI5Ra4ErsYR3uEGXa1PZOvUU9KimcTKzsRVOVR9N+hwiZY8haRqhyHZx3wQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kCRMeKIIp3aUIz4rOW/G+yHBdqdUoKCtXEVyXH3BUgqCdvR9ha
	PwufTSBI+/b/3rvGiiyW2FSwA/dgmmON8AP5wz6tOywQaYfKXGw9MxgO6+EYSRfnBcG2P6Hqq2Y
	Uwui79M3hLZ44rs005LJNZMP+hG4AY5TT03hxAPoQdTdnxSJmX/lIEA==
X-Gm-Gg: AYBFou1djiHe532qBO3h0xCtncNDh/rHLbiQ+yzBeksRgXlNtxYkW5Tbqzqq3qVsmrP
	0M+3K7IdeymE9VZdGDsXqf33oD4dGQNr2g8W/iAguoymZk60VFzTV/fHjQ7vGMX4gSm7eZFC0Zx
	cYSifAK0ESUJQcAFor7/HU/PMuv1AAs7Qxh942g7YQ5+KByxOfcWLrxtU871m8NX6+pp0Cjhaak
	FOLrAPF+yme/vodhN530hdEoVHs3fHi54vFGWG35zR0HSLwVw2e1ZI4hFI9vyze4KTqVS4k4R22
	RhwMkau5T916Ept17vKByByQv9Nte9gCypwMT+fgVJi16ot2utwrYuP9GICZtaYbsKatrgmmkK9
	vsU/IrzSCrpElZyBe1S8lULE=
X-Received: by 2002:a05:600c:3d92:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49d0726cd2emr320765855e9.5.1788817280986;
        Mon, 07 Sep 2026 14:41:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3d92:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49d0726cd2emr320765175e9.5.1788817280462;
        Mon, 07 Sep 2026 14:41:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm892607965e9.0.2026.09.07.14.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:41:19 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:41:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <20260907174032-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260907091033-mutt-send-email-mst@kernel.org>
 <ap8rCQII9fASEosZ@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap8rCQII9fASEosZ@gmail.com>

On Mon, Sep 07, 2026 at 11:23:19PM +0200, Karl Mehltretter wrote:
> On Mon, Sep 07, 2026 at 09:13:28AM +0100, Michael S. Tsirkin wrote:
> > got all 3 patches now. it's a good start, thanks, but they need
> > a bit more work, in particular addressing sashiko comments.
> > I'd also prefer patch 1 to be split: moving code from pci to core
> > is separate from ccw fixes.
> > 
> > Pls write or at least edit commit log messages yourself,
> > after reviewing Documentation/process/coding-assistants.rst
> > 
> 
> Thank you for the review and feedback. I'll work on a v2 now.
> 
> Karl

FYI I picked the virtio input patch, no need to repost that.
If you want to fix the evt leak, it can be a separate patch.

-- 
MST

