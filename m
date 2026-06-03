Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC426C38C
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780447529; cv=none; b=Lb6xaxLS1FBstaLD03Sv+O3SrsIfRzcDlHMK+mFU4psfxn0vS3Lji+CVb0FP54oXzGQUY9uTWTFF6w6nb6N3OuXd4sFAr5kiE8E2Y69i5bR27es9KjUws/gbeLxMeNMtjSoc92DzKU28ZEC9+aVVjortczc9QMisTfW5RTPnLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780447529; c=relaxed/simple;
	bh=fYeJX8joKmObdhrh8tQtfCeBM4ISEnrgCnjg5ucGFT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwgI1SSvCcTlJX4b9elnH5Vl0P52RG/BPcBxNKjUQ6MSrtD5K2jTGLFA5HI5GSEJTNeeFhu7K2V54+VyhXrsj5JOKD7oKkmNdv4CoGBT/Wiu6tBUVTfEQWpGhIILNh21Tb9yMpglx2YkDjvgTgonFgE3Wpacwf65EO2xXrQtok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DBp2IZn6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DBp2IZn6"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-91587626ae1so88010685a.3
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 17:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780447526; x=1781052326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3KDvAGi+1n2YXetnWM+OO8ay/rFVkZZd+3BY7j695Gc=;
        b=DBp2IZn6OJXydpul5Shl7SAnVhkJ7EaDXGakzzRWZlhjWPbvDQqjUO8oDqRFRH6qrI
         Ku7bKh1s9J78XTIu9iujQC0nE4qID9UejKWz31vPhpI39Xz/xnjeTdbUvZsi4m7RtYLc
         qRzQ5sxmrEunz3BptU8jN91XuNFv6E3SxPZwT9J49+NC+gbrwzfpHKheg4NM5TA/mKkr
         8Qyf1EQ0yCaC4y5dV8omoclZZvf+FJBVr9u6Or24tkpO3moazrvIKF7jsBCd5yxxux5l
         zPZPQH6v/oSnpyLJZGws2HaRy6Je5IWOn4A9wi5O+gQWIETPJpItAyg0S+IcNEU9HfBp
         tmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780447526; x=1781052326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KDvAGi+1n2YXetnWM+OO8ay/rFVkZZd+3BY7j695Gc=;
        b=CEAcZ8VoluRmSeFNOip8iARxc1gYyWF4BkrXU1vvcaw3fwkpI0lyEbMbnXfV/tY05J
         JyHz+hq/UGZl9mPfSNWUhW51stCcc9ob5PlFfERx+qzzLMuqM6GgSmKMIUAYDSvUMgBG
         G2BQHO9PvdApd1ssmLI5hIAXotG5Gw9F8I47PxLzHFV+YQ5D84Osk7gtsWCRFkmZNxAw
         5aLiCyAXA8Wm+1ezEnoFxihTjHuHylY3SGItFAO9oRP+JekQKuKNk5VCd89BsDmOf5N9
         aB3yW8tWz0bASgpCjejuhBx9n+vj9UUC0QBWqY9ROq7hYDOheYAi2J+A0YtbKSkmtq/f
         luvw==
X-Forwarded-Encrypted: i=1; AFNElJ8b19kDRBMjMqNzjslDKYXV8EHqJ2xo+Lq8T4zFE+teFD/EXzqynMYn2IYHvkizefk1+7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBGpcTYSbOaHMYyzKzqBd8IyI4naP/SihLBB8Q4/EsBOyvmnP
	nQHeBfcXeEIbbLtGkDbSTKPulIOSWKRAOYBU187kSjeegiGrin8tbG8MTTA4c2ajsK8=
X-Gm-Gg: Acq92OFfe+MyvJ/FPtuggBEZKj92acXaHcgbxLt19C6j1krnwcmOrm3op0LWhbCNBbh
	34dgmIaoGMoER7DCtnPq2++jmtDrsfVOznluOkiM3AoHVZc/DuntcUN2gps9ZZODP2e5kyMFnNH
	WSNTjDXTY1Gw+77PQh4yAk+ogjt2prqkZa3pviRmZ2fdncjnFV+M1qC3M/JO1ohSMekgOp4SzNT
	dhqRbnpg6/BJyW9rfM9po55Wclp2UJrq6aVgUz9JnBjKz8pE8OBpBHXsNNIgp4lfsON/Ybb7gpg
	EJzIPrw99W19Net8lkAdFi1oaLBVciatmJaDfYEylQTsDl/JG3+dXp8tAuyUYW6g0quw0BmEtMD
	fWiQQ+Co/5sxCS53sWzANVyW0+gHizSje4M1q7ovaJVQkLi+eXolBxBaoKDYq/HMJ2VLnzAxZMR
	6bg64MGiggjH7hwLCRY2b51H+iwyd0XPrHdJIhNBL/z/56RXcrHuO3PKqWEfrze8EaulW0ssYRz
	rrA/96i8rgjsEKe
X-Received: by 2002:a05:620a:488c:b0:915:8010:c2a9 with SMTP id af79cd13be357-9158a82bcb7mr247072785a.52.1780447525938;
        Tue, 02 Jun 2026 17:45:25 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00b104sm102180185a.4.2026.06.02.17.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:45:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUZjY-00000004wLd-2FXa;
	Tue, 02 Jun 2026 21:45:24 -0300
Date: Tue, 2 Jun 2026 21:45:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, wathsala.vithanage@arm.com,
	helgaas@kernel.org, wei.huang2@amd.com, zhipingz@meta.com,
	wangzhou1@hisilicon.com, wangyushan12@huawei.com,
	liuyonglong@huawei.com, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 0/8] vfio/pci: Add PCIe TPH support
Message-ID: <20260603004524.GL2487554@ziepe.ca>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
 <20260601095840.3aaaa508@shazbot.org>
 <59c82855-59a7-4f0e-b534-d35535d04b93@huawei.com>
 <20260602170847.75bd159d@shazbot.org>
 <3f8d1722-6749-4f3a-b630-c96303cec284@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f8d1722-6749-4f3a-b630-c96303cec284@huawei.com>

On Wed, Jun 03, 2026 at 08:34:53AM +0800, fengchengwen wrote:

> This translation helper is required to handle varied TPH configurations,
> including cases where ST entries live inside device private registers
> instead of MSI-X or TPH capability space.

I thought we agreed vfio had to block that feature in config space due
to security concerns? That's what enable_unsafe_tph is about, right?

> Prior discussion with Jason (
> ref: https://lore.kernel.org/all/20260414151125.GF2577880@ziepe.ca/)
> indicated VFIO-PCI is the correct component for per-device TPH
> implementation.

> > The host-only opt-in issue above also doesn't appear to be addressed or
> > rebutted.
> 
> enable_unsafe_tph host opt-in already fully gates all new TPH ABI:
> TPH cap + feature ioctl are completely hidden from userspace when off,
> no userspace opt-in needed.

I agree in general that the presence of enable_unsafe_tph VFIO has to
report the per-device steering tags to userspace so it can program the
device specific registers, nothing else can do this.

But I don't really get what is going on with all the new uAPI
proposed.

I don't understand what VFIO_DEVICE_FEATURE_TPH_ST_CONFIG is supposed
to be for, userspace should not be able to directly program registers
that are kernel controled. In this case it is 'safe' and it should be
only programmed by specifying abstract information like TPH_CPU_ST
does.

I'm also wondering why it needs a shadow entry, that doesn't seem
normal for config space tables..

Jason
