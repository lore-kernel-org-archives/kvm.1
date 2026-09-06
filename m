Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E2536167F
	for <kvm@vger.kernel.org>; Sun,  6 Sep 2026 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712368; cv=none; b=cHPiXmXBrGg1w/w3/1W/9dWmFXcsNEeSkFe+Bc0tWFpLwI9qZmp3RfeHnUExTcuvjqCACeT49U53qOIDofbag+LA8YHiI1f0j+4l+zXkX/Q6JnZOgmybHL+d4yqgzicmZaNoMsLvnZfbhFXLEXkOIr2RS2r1ijY/S1LGMrKLlY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712368; c=relaxed/simple;
	bh=VC9CS50hEkPgNN2KRwyNAMzImJHMiYhWfiuDpnpliw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bjqa/8VR9gQt7VB8PEoGjQhnJvZy4qSTTU8w6vy0cBFliI7qX2w0ZiWPGT+JNEWz8fEVxEz5ZrJbOBXJgbKkPAtCyBRxfvqfRx/Pkn6I2+q4NjU8l7mTbhvAYB32JP0jclme+2nIz59PqD72jiUOLkryIBDXPkowTZsGdORadYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qaRAjTK8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaRAjTK8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49cf4f81d86so20557025e9.2
        for <kvm@vger.kernel.org>; Sun, 06 Sep 2026 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788712364; x=1789317164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oSMRVQ2ffl+GqdtcpJsergu6EJ70aiuLEE/q2zryERM=;
        b=qaRAjTK8Gl9qdB2NOyEyV9nOSsFGJeUA9eZ/2aZ06snn8uHZ+JTqqP9KEYdvEetq1K
         ks2p/PxsJ0P7cY9wOJq77cghACviGLg4vtBEGYnzkS3OuZi6yt7teb2zLbsqJdulZxNC
         n97SiAFduflUhXxPDIZTzC1Z7iPU9mrsrpsQXPKhsLsmb86Z3m0uXq0CSJpGx+fopu9S
         wvAvdt+SqsWW/l/T18gMcN0qwQKxdqdAJa8b2lmVAb1KJ/N3sH2mkkJPz75lUMmtVIqZ
         51NmQjr+VBfU+mOPsSOiK9uFBE+XNwkOmKhBA2PRBAmFVSG3sgAyDrPlz/DprkqsF7bu
         V0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788712364; x=1789317164;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oSMRVQ2ffl+GqdtcpJsergu6EJ70aiuLEE/q2zryERM=;
        b=gXPyftSM66q4+AbaQMzM8elkYFKZ4iIVd5zLpiJX/v82tbxx+3IMFcBOfPvTW5XYPs
         q1Ui6cgsU4Hy3liTLi8Sjfi4cHMSl66eui8O8CAVLyAocVwJ1LlDYfHjqR4aTMv5AS9J
         giLbvfTiHzLtz6K518HyLm+glrPxyDtN/rfhbDdC23L4G4HcWCGIvMFYFzunT/bzQXD4
         yBV0Ki16YQrdWVNurlOCq2kxwWZqvEQZCDmyFpyx/EIsnt14SCOekK8t4V6f7B3dK2oy
         5WR+UylzOg+cf/Kg+e+sGx8LFEU4vrDRTiKzfFnaNxK2o3CqTi+nKF/ow4sj+wKgg5bd
         k99w==
X-Forwarded-Encrypted: i=1; AKwUvBz1/bwWEIKphqi89GhMgAmNaHim87bUPkshvZBMgSTg8XxcvARv6DsvQcrTbsMrlPVByXk=@vger.kernel.org
X-Gm-Message-State: AFuF++mUyBcJ9WgPhWNswRhqWDl2rUJlmjXzUEGPqoxgKCBK1k+wZoDP
	K5Pg5gxMfRDXWGSfVusq4kH7NtE+sWnM+C1NBAqzqgUzUl38CLDNWsud
X-Gm-Gg: AYBFou14G0typktPZnNqpCCHoKxRMQvDLObC4by7DIwxJu86/TujziY7OfZ0BC6o2hu
	mGviO2zc666j9M6x49EbhqJWdB9sKWnzFw/Yfl66ht24tNWpAFWC+AbLSIhBrTlDN61KNxKyt2K
	XG6lKhwUyQgt1czwKhBZSa3IW4LHXxnYDd0omeOcS54C2rwkzEmhrcVYGfyUazL4Q7IrP9qeCk/
	26vLeH/PHs+x0Dnv5GGeTeP/Gp5lrIminiy1Pb4bzalaexWabhupVeXvVQsXcKyUkanf/HXHb/W
	2unLPLUbfdogv6YOnjoY5Lu10cIt7sPCeNyfc7PI6mDbkJWs9E7rleB/7M3ZLSdQiW2TkF3oQog
	lH+pTfNbJ3ezmoclTemXcV/DnEDksCqU+PK0TPUaWpfoKXz8jJjhf1C6ps/dP8kW2YJJ1eLbgSk
	EV6M4vurOAyFbjH4BA0x2MJzcOnLOY/ITzwHstfyKX1br7c01oIxXe+0pwHQCEEJfmBzdodHw1N
	2zKSo4ZyTh1vbliYoXYGtVWfG4DZ4L2VFVgB28Fsfdvb59i7EH/Cnk6hemBGQnRakK3MAPdUicr
	084mi9YuwEs9Pa0BEAoOoIE2SzIdtWOdtGsqW/9dSACPQAQ08SptDm8ogIYLqX22mnb35+EO2Ie
	Bxl+C
X-Received: by 2002:a05:600c:8b04:b0:49c:fc6c:be11 with SMTP id 5b1f17b1804b1-49cfc6cc0c3mr138648845e9.23.1788712363826;
        Sun, 06 Sep 2026 09:32:43 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-9d84-5101-9c80-d25b-14b6-410c.310.pool.telefonica.de. [2a02:3100:9d84:5101:9c80:d25b:14b6:410c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588394fa1sm21761428f8f.8.2026.09.06.09.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 09:32:43 -0700 (PDT)
Date: Sun, 6 Sep 2026 18:32:40 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, 
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	virtualization@lists.linux.dev, linux-input@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <ap2VJkoIsBbsqcNm@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260906025249-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906025249-mutt-send-email-mst@kernel.org>

On Sun, Sep 06, 2026 at 02:53:05AM +0100, Michael S. Tsirkin wrote:
> You didn't send patch 3.
> 

I resent it to just you now. Mail must have gotton lost somewhere.

If all else fails, it's on lore:
https://lore.kernel.org/r/20260905152059.89560-4-kmehltretter@gmail.com/

Thanks,
Karl
