Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9E32C957
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814790; cv=none; b=fAi0QzfNtJsjlMfVr//wT62OKDgp+25NLotRaSuIQIUM3IUmJF7SsbP9+NjSRhvMKbi7f46DnpwKG3Kt03vEfomyvgt8o4+vT6BXw64clfUTkIusCtM8Rmg15upv7GYlYJ2EdEDGQqAaZ6FuP1FggPhbfSb0daNrCee6/DFi04E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814790; c=relaxed/simple;
	bh=vC4qQclBoV67ud2evHeSbDFkaZmPoEXMBUWK5AoYXEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYPd9pdhIFDb2uxSi7H9fZXzFjRK3o1Oj8QwUNCB+r2U7XLFfVqLL2Kj1b+IBaXBIRIodvfl5B7byN0PTU56s5Fro8N+2Nk/+zff5MDex6Jvx7Nky1SrdkZXcPUz4IvF4Q8H9/78Fzbmawe0RpWMiof/v9dJxR/f6Wwd5n6hgkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Juk83/iO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KeLwA2vK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Juk83/iO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeLwA2vK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785814788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diYn9AH5DOp5LofRkeGafvYOwV70LwGGTt9FgR+upFQ=;
	b=Juk83/iOdm0tjHtFCgUmf5Klhrj8uE5QeKkrODXz3iqDV1szgft0SGbIgt2KBavmJFPFCP
	1h0RXKJ8783kGOvkIzzRAcma5EDT00isVUvp9m85YGOcK6TOXEnq40XkYL7pi4FGKWzyvy
	jinodFs57F1V/q+Vtjvuhp9/Xr6SDwg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-RNGoaGdBOQuJQGjB-DG3tA-1; Mon, 03 Aug 2026 23:39:47 -0400
X-MC-Unique: RNGoaGdBOQuJQGjB-DG3tA-1
X-Mimecast-MFC-AGG-ID: RNGoaGdBOQuJQGjB-DG3tA_1785814786
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15e82278cbso334494366b.2
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 20:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785814786; x=1786419586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=diYn9AH5DOp5LofRkeGafvYOwV70LwGGTt9FgR+upFQ=;
        b=KeLwA2vK3RZo27HZPVubdSmwRL0xIBz119y5Vq7xH3jZFqXyqktSwargQSQrSlBucx
         uxv79aGqfx+actWpsxMaj0XZ3Yzexl/Lf7ljqnFot2hChf17qqgsX9hwdH1+j1suxxE/
         NhMhEYfFPQhkMgIvHBnZ+AfVQf4WXBMfSCoBlnnIvYdVqTnibHtwsGrxnk/TuQU49z4p
         2XFhAIPATmmsA5PWKwCz/ZSyMZnOv0PDDzt699oQywO59x+A0177013ovKZ2af0iT1Uu
         MWeE09ukGQmq3LGhc7SVtfG3+60c4q2Lrcq7oUXqYh/7i3ctCnRsvdYzoohB0S+iOerf
         /Tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785814786; x=1786419586;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=diYn9AH5DOp5LofRkeGafvYOwV70LwGGTt9FgR+upFQ=;
        b=SK2OMqcjuBXnUGae2vLi21RlVxqK+1sYEh0qjI3FUH2KsQYrfl4jd2oK+ZANBsx2un
         U+LiAjbGKnr7hliutC3coI0AEfu50cgbpvpkf8MWFoOj9ioJYtNVQ3hMAM2fg+H5t4OG
         VSs1mN9M2W8lawst3KtoQNeOkMP7LNBoUK7gSHDQojvaeLT02FsOriWI/hPzq5wBA+38
         wNji8Gpv97hxGUSWMrw8rI1DYny8sytGkDH7b+jjh4X1yCfuovdQwwaMn2CBCuwOxCfd
         5n8NjXSQJeJNLXo0ot1rhiUi2cKiWAMXYOmPDhwwiW2UocW7sUzqRTns45WEHNa+Qcy1
         5d/w==
X-Forwarded-Encrypted: i=1; AHgh+Ro8wgx3g/iLSRnhpe/2ilIcL1H2cCUO6ehDRle7priOySQJh0CCEkwEYEeq6erlkOB/xmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/4Op5DhyyZiWFBFmsoVpRAptTOx1QJtRMX8K9QVQZ0MvwR3ya
	d3Ed3qVzusqG8/0FbJMR9q1bJneHyKd5h1bejCxeBdr8M6rAy5vgT7RiNgVaAiPUJbIwOFSEZXz
	hbCLhT4FDSIpJl++DT2fcbVMx6QkYD+1OAdfSqiT/B+TutA/VjjXepw==
X-Gm-Gg: AR+sD12hEatk9nCvy9J4oQqO1UXI/1uji62qYfRh92GuVrV6auak6Siwu1MKkH+ru43
	8AOypPFROrV4ZpEcDf9/DP/bdojG338G2YBYlXcMUtK+9NP3IaQfuu/bljIBDKOu/RCcOtK3FWv
	i9uHtORwS5F7RUqPru9kqiKcJndYfPPyGL9a8CnKRlByA6B9Wv6SzV4pT7tHK6icj0JuDYjLhrf
	aL/ybqs57bTegY+m74TQTjti1kQK6E+lsjoUZ5T6cEbE3gTQAvIPOydTjsVTf7Vb61dyYRMthEy
	3imhADF1R1KSns2MCUS4mKqV17yf1kvuqRdHnp6jOid9+UYv1ZQNv/6amCYyvR0mVbbk
X-Received: by 2002:a17:907:1c22:b0:c15:d4f8:dade with SMTP id a640c23a62f3a-c1fe7eebb0amr1148196566b.2.1785814785642;
        Mon, 03 Aug 2026 20:39:45 -0700 (PDT)
X-Received: by 2002:a17:907:1c22:b0:c15:d4f8:dade with SMTP id a640c23a62f3a-c1fe7eebb0amr1148193466b.2.1785814785204;
        Mon, 03 Aug 2026 20:39:45 -0700 (PDT)
Received: from redhat.com ([186.247.166.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c93a87sm631061866b.18.2026.08.03.20.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:39:43 -0700 (PDT)
Date: Mon, 3 Aug 2026 23:39:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Jia Jia <physicalmtea@gmail.com>, jasowangio@gmail.com,
	pbonzoni@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: flush backend after device ioctls
Message-ID: <20260803233841-mutt-send-email-mst@kernel.org>
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
 <3d2dfa19-42f8-4d1f-a411-c72669f4c4bc@oracle.com>
 <20260723105451.1563439-1-physicalmtea@gmail.com>
 <45a33302-0b28-4d00-8724-c3af6e1783f6@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45a33302-0b28-4d00-8724-c3af6e1783f6@oracle.com>

On Mon, Aug 03, 2026 at 07:02:43PM -0500, Mike Christie wrote:
> On 7/23/26 5:54 AM, Jia Jia wrote:
> > The owner must keep the old mappings valid until the ioctl returns.
> > Remapping or dropping them from another userspace thread before then is
> > outside the lifetime assumption of this transition barrier.
> 
> Ok I get it now. For some reason I thought that was valid.
> 
> For the patch we don't want to flush if vhost_dev_ioctl fails
> and there's no reason to flush for operations like
> VHOST_GET_FORK_FROM_OWNER or VHOST_SET_OWNER.
> 
> Could vhost_dev_ioctl return when a flush is needed?

I agree but also this is consistent with all other vhost
devices.

So I'm taking v2 of this, and we can iterate to optimize
all devices with patches on top.

-- 
MST

