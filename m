Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499242E8D1
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571004; cv=none; b=SKh9wZvoFVXpFiaSSoZFnUVwICwVo48MBprPoGKKhNEWBTM6SX7FU2257R7BS9oIDAyK4ouRtK1KLjlW1LuQW2bgwSSdSNZQQv6TqKYKvp9UICuSP248suqjC2jgdun10jnKkt5TOX6r8O304CB9uEE4Xp6k+En+oMAhQ6ZzUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571004; c=relaxed/simple;
	bh=1uEDg/FV/ey3tIvkZiDPcz/YbhoRq4tudt2FBCrZf4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbffIPgm3LHaTyCs2BKz7j6HmCcb5Bt7LNrXhJ7z2dFYSNVItoTMZ/OkWtpSpMomeyGcjbQEFrCm2/wHqGi2LF/WEv+hhDnyClZ4LYQNrwD1SSSfv7OSX4mAYZAOXnyagllk9MjX/cWCYmjJhg/IwPvjoo02XrwzoVFNQoc2Zrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rh4/HnRT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rh4/HnRT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cab97c86bdso423605ad.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784571003; x=1785175803; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GgL1Eiw85Kb5Jf3gvbIyNxC+Rnz0Bkj4TViq+kO7G5c=;
        b=Rh4/HnRTVCJStb8xVeselAKL6WK9cf0QIWfixABg705b8jHkOj+0tXS/ypIoPlg5ap
         CxLhfcaDWjh7vZjRjjI4MV9RTLCiHSIUu2lvbjVIkgSGj8D779vtIP2BLpa8gPd6RASA
         V592amvOWDJSK2qP7W/mzpgSa9BK+eyeZBlGO2JQBg3fJ18QS3en+xMMuIlYoE8r4/Aw
         KeL+8oTGUCuOr+w7rB1GbEuVyOijCvtSwJCg4ohDEQK1zGlQVJLXrdkIGDDXqicJEf52
         4l9tKV4nQSSMhVMO/UD3Q5Rq+nRDABNawKqnCBlbh5GhGK+lmJfP0URRK0f/P0vw37qc
         CUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784571003; x=1785175803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GgL1Eiw85Kb5Jf3gvbIyNxC+Rnz0Bkj4TViq+kO7G5c=;
        b=Iwgm1lfECu5WmLnNaNClHD1y103VToxGVTdS0mSgIB8xEzd+v2iIgU3BCMuf95bkmH
         KA9h/P4BiICh7t7QsEuhTN9g45s/DCthoaR+gDxiTyIUhIW0/Vf3u84yRKd7OlVGaGer
         BpME3mzkOTBgv/PKdAflsOV/38M7mH9uvtIbalv6XUWrWAyWvRVZh7e1Mz/7wQAqVS8V
         gJhq80eI+nRKdJgYEaK6/nGeym+FvBoc19fk91aFnhonKswv6xw+dApqeb+JeRhFqlWw
         8W0FrdTtTx8Ed0+Z98nq1fLuvhKahGNY7lQ7RrapykIgVDe29eiezptcdOjKkpEzY2D9
         Gg8g==
X-Gm-Message-State: AOJu0Ywn4EFqrtYgnK8I5zRRLURdOgppRqvsC/3lQhfZoG0uEmoq7MWo
	ma4Rk+O2WOcKBSW1bjQpmJWeTseiL0URrlzQn1Q4POYG2/dSqLMFFg3+3wAhS5Sxn9dHKSASd6J
	ATYqTNcObGNk=
X-Gm-Gg: AR+sD13K7+4qo7+ZrMLXRDvNV6GR7v0WCTWOTZsNamqG01qqbfYQffSTxC7XGecnTT+
	IUdHPlsALfzaHT+AJpAwyjJ1VUJp/j3/nO358NCAL7OtkptNlNA6T490hLdsvhONkBqPQWfwMV1
	ajylMWMy8ITFWTwnm2S3PPbm0+NdOw+xHJ4yoR215TsTRzY9MYJJ4Gt93GEdGBxpynDfwCqfYfW
	6EkZ+lGa91bXUGb+4sG1zL3uGGg1CPHY4lJZ/p4VAKdvbz+bExumC/2JsS0+CEfMSR1TLzXF0vH
	/aw9CETW/f6xsAYGgEJWbm1HDoszFHA3kHgS/LK6xDJx4GBn4zzjyAtslBy1BKlWUrj70iOuyVX
	jwqgoeFrXvUrsp0wDNuRWfrmzHEqbHzRC1BgX0QeoX3+t5R/jRwHVTGPp0l0JiAAjmf0R16ET49
	BQ7bgjRZL6J5uT8/jYO8vnNCV+4TFZNTOQ9ryh
X-Received: by 2002:a17:902:c94e:b0:2cc:a859:d404 with SMTP id d9443c01a7336-2cf7b6d3247mr1941935ad.23.1784571002014;
        Mon, 20 Jul 2026 11:10:02 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519de34d4sm5357853a12.26.2026.07.20.11.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:10:01 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:09:57 -0700
From: Vipin Sharma <vipinsh@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v5 11/20] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
Message-ID: <20260720180910.GC1381701.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-12-vipinsh@google.com>
 <20260714152845.50CA91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714152845.50CA91F000E9@smtp.kernel.org>

On Tue, Jul 14, 2026 at 03:28:44PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The function `pci_liveupdate_is_incoming()` is called but is neither declared nor defined anywhere in the kernel tree.
> --
> 
> --- Patch [11]: [PATCH v5 11/20] vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD ---
> commit 27d87a41631434a0adb6626f478ee97f35b6c917
> Author: David Matlack <dmatlack@google.com>
> 
> vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD
> 
> This commit enforces that incoming VFIO devices preserved by a previous
> kernel are retrieved using LIVEUPDATE_SESSION_RETRIEVE_FD. It adds checks
> during device open and group device fd retrieval to return -EBUSY if
> an attempt is made to bypass the preserved state.
> 
> > diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> > index e4b72e79b7e3e..496180950eb6d 100644
> > --- a/drivers/vfio/vfio.h
> > +++ b/drivers/vfio/vfio.h
> 
> [ ... ]
> 
> > @@ -461,4 +462,21 @@ static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
> >  static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
> >  #endif /* CONFIG_VFIO_DEBUGFS */
> >  
> > +#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
> > +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
> > +{
> > +	struct device *d = device->dev;
> > +
> > +	if (dev_is_pci(d))
> > +		return pci_liveupdate_is_incoming(to_pci_dev(d));
> 
> [Severity: Low]
> Does this code compile successfully when CONFIG_VFIO_PCI_LIVEUPDATE is enabled?
> It appears that pci_liveupdate_is_incoming is neither declared nor defined
> anywhere in the kernel tree.
> 
> Could a prerequisite patch adding this functionality to the PCI subsystem
> have been left out of this series?
> 

This series is built on top of in-progress PCI Live Update series
https://lore.kernel.org/linux-pci/20260710212616.1351130-1-dmatlack@google.com/

> > +
> > +	return false;
> > +}
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260714151505.3466855-1-vipinsh@google.com?part=11
