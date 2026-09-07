Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F361282F01
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788820377; cv=none; b=qRNtx8crOvzoPPpwOAMvM6a518fi2EXEK8mu/Sbu4Q0GTYbEM0AhuU4vjZgGiOv4/MfQzASTlWqOerUyMhAj39X2FdndGxsFrdZKdpqt2OzJkrqKfn0eG1xo4TxCs+n/WCtwFh5V3j8xCas1aOnvTqI6c4GQfYvsNEJwR7+UmP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788820377; c=relaxed/simple;
	bh=9RNlViBMP5gSfl6YGM7J6Ko4HkVsFl5+nPinarDZvEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1RXEFtiMKwUv/1MSeEvAx3OW6+bgpBSahn/QiqYO9Q4rUOhqwOIUbEhAtO2RjGEy9p30i+95kVZ/eFsiNeLKOxmF6+gjyInfUgtzYQVbJel4dVozqkN1FXBO9wyy6Mulliyn5or7kXvqQYBkySTf/159yTB6hw5zZonabx+4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWm14lAR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWm14lAR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49d0726ccc2so16080535e9.2
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788820374; x=1789425174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mnujOlryOcOB2B/LvIPxTaLmbwXh/kZV9FXNR3oxSFM=;
        b=UWm14lARKYLQM+ND1gFensmfZyfXbYFhflN8KeZsSjpLigjKDh89DrUCkOrImEbPTF
         JR9nLfnLiSVriZSXzabdDDA6LPWs5IAaAHFEuhGIRkdC7nIPNTT+Gq6t+uqZ3dyoVBj5
         94mHUvmvPGJIPNcHogt1cYmeXsYkoQXixg/RxNUCa9rXuTjz8cr9Z6EhFnsC+71MFl8A
         xdE/vOWoJ1vcWYd5/BsQ4CSoyk5H+1FbJoBzdBmilX5EKX+7Ga8xpjJFqPxELpxUXMXs
         BwllPAFP2eVxdks/aBLXMO4h1e0Gioh6kbwG+YsZwMZZQO8wgyUJCI9S7FxqR/uAnthP
         Wqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788820374; x=1789425174;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mnujOlryOcOB2B/LvIPxTaLmbwXh/kZV9FXNR3oxSFM=;
        b=DZT5LdVvgG7A4Wjt9XTJQrMEhuXgWwZQtmte4OTZd9yCT8vyFRYRAJgqZDKxyKm6Ko
         BMGwT0R5uxiXgQnzKjnHD2IlGj+uFJtyeb+Cv3NWo60TgVdd//FEf/Pf+mTkVft8OovM
         OZSXcK/M6RPTRw0/OVRBm/C7Q9MwCc92LYF2rmOYsuT5ufqK9HDIQ5DdySiEgsVktX4Q
         ixWDQdZeR3ox8mRe0o71pvfxli9PbpSOl560VpdEelKmHibfqKC4Ht0Hz5/X+1qJwW0Z
         U1iiPyEe01NKOC8E2KLbvmzyDjtFrsPoJ84km1a+AdC5Wg3+jm54QykSNme2c4SYyX6X
         CjRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhtCvosMeUAyTifWLP1H5nWb54hYCu2jFrmHn3HylhCIdUrtiKIgabS6thZKPKLjgFR9g=@vger.kernel.org
X-Gm-Message-State: AFuF++nqvqRBMN5J2SH51IPh7yy9PfwOo3rQUycAN7FPZ/4lrEsyr5cc
	zhh2iBugMEruUWtQ5d+u4ybUkc5Wa3Zveswwag/epwkeqxVrlF8R8wdb
X-Gm-Gg: AYBFou359xE1yhbwcnCpWYaG72op1k0784kh/XKpOGSqbfXzzFhRjL951UCR9fgNdHR
	NtkK/jkv0n8BUVVoACRyksEEKAFD0X81esIW2eZZMqR9mHMz3Ny/sE23bRYJBHYe/eNAtpi5/N7
	UJ6yuA5a4jL8VKLXKNZTUzc7WLvwx6krgptcS407EglCfiyEkBmgvWWJ4pTdw5THCTuDe2fqM9v
	RN8AWrMQN0DKOgjaY9k62/w/UidaQMsgufIUDbrt3pk2WWRRaQLUohcN8az+4M/88KBvdoJBneH
	mSE1KM294DMpTkudHGVKXHrjYxbffjWkv/kK99XH6fC/PfDGTZ6SyJj7VLRYb6vZKkMrt7kEo7h
	uZoxKwblax8V5aB8EKwSNWlzXHVJf+qhFEBXg1KEPazbFZFkhBV+6D4ubjnP+SJgtD3Cz/wo9xZ
	rYipc/vGoPrfq6XHDW0smxDvx7CkU6Vk3CPmfKVr9AnNITx7if8i7dlaVGO9d82f+4Td+BOBpen
	Gaxs7YShnjjY1kgw1iPMzExVFvCekOpYM3F9d7Kl7G2HpRPa/F2wFdfgU1vUwRr29htjAdyfQZ3
	8lX6ixlfObNgURKgmd/8ZiYuc4pwheYVTOtBPtbWfQ/JBLTWEehgzFURXt87NXpkYbuu5TG2fCJ
	b
X-Received: by 2002:a05:600c:a0a:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49cf81e6cebmr448618745e9.4.1788820374459;
        Mon, 07 Sep 2026 15:32:54 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-b0c9-3601-cdce-ba4b-d0e3-dede.310.pool.telefonica.de. [2a02:3100:b0c9:3601:cdce:ba4b:d0e3:dede])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce551bf7asm289518525e9.2.2026.09.07.15.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:32:53 -0700 (PDT)
Date: Tue, 8 Sep 2026 00:32:47 +0200
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
Subject: Re: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering
 input device
Message-ID: <ap87JrBAxjbPe_jX@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
 <20260907174559-mutt-send-email-mst@kernel.org>
 <ap82pFlX8enNG0gZ@gmail.com>
 <20260907182153-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907182153-mutt-send-email-mst@kernel.org>

On Mon, Sep 07, 2026 at 06:22:09PM +0100, Michael S. Tsirkin wrote:
> > 
> > "Assisted-by: LLM" is the form Documentation/process/coding-assistants.rst
> > gives now.
> > 
> 
> really? not what i see. in which version?

Since v7.3-rc1. Christian Brauner proposed the change here:

https://lore.kernel.org/r/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org/

which became commit 816d9992d9ed

Thanks,
Karl
