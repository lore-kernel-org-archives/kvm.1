Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F919993E
	for <kvm@vger.kernel.org>; Thu,  5 Sep 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543334; cv=none; b=QO3zsQjxo8OukEYpulrwVpcA7riy2bZKEoO0XQ64yaB4EmSCAx6Kuz40t5cKyVjsoYjBHd84jXHcNnhbsfQkEtQhCw0RjOiMQD4pNtUG55eF2lZCmJ5PQAih8vUxS5Ln2gKqTRsHZfOxWReNrxLW2deWRP++/En6aDz3wmqrDto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543334; c=relaxed/simple;
	bh=j6F0tW2h+YFB/XFzIZ3wBpoQulFAEjG1KO6HiUVHwkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQYXgyEawZB9K7vkj4paBt+zU7kLPi1iz6qTs+20vLJmofT2w3KrCZkHUBIwE+rQZCr6IcA4Tp1e4qeqIsM70B3WeIYQ0yP51hZCwEbPQvDE5Hn1fQzs24NgKgCymmGFN+fV/4/szdmws4LDmQPUtv/1oDvDC/+Z3j20nGH5L+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jJS12BcV; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jJS12BcV"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a7f94938fcso53573985a.1
        for <kvm@vger.kernel.org>; Thu, 05 Sep 2024 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725543330; x=1726148130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IpOxL4urdpp1yZVeRAEs+P+Hwe7g6Zv+yPVszVvBbKI=;
        b=jJS12BcVf75n0ENMY/wqNvPfpM+8WlFKmUPZxpQ2cL/B2oZ8xRYwtESdUIFe19RBIf
         VbjlM3g6Ic3Sqdn+E8aTrFuKX0XlkG9E4bgafRVSZXPTzXP4cvhxAr6l27nNN/VvcnQV
         SBxoZ9M4fUKFTHuZV62rwXH/GwBTSG2ENQcITkMaYstcoweCDFjV3qVeP6+Xbfs4/vAS
         tY7fYit/gGFQOXQQCl3HJdNKyd9SXF7s/n2ZtyZmNYQfUcNweKZovhsOcK3eFkCBD2hn
         5wYjXIWGi18fu+biT43d9bqgdafDVTkVsnaIA0B0143JkYYFpeRi4Xx8vGe1oM4Jt2cT
         8WPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543330; x=1726148130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpOxL4urdpp1yZVeRAEs+P+Hwe7g6Zv+yPVszVvBbKI=;
        b=v71prQmcEaVB7V2KSnuZ/ytHEyA+E/EIfphMblvrrPEd8d6KuHxS35Un1GDuT624Dm
         I2C/SLXnRi/Q/mr0oYbjbTaiSKOkB1zHWpY0AOTf0ePiyc01E7xmxhUTcFgU59KeKvYQ
         4I0+Ipzr8mTYBo9g8jg4B8flq1SMr43Rd59dfZu4Czfje+Sxro+E9tfDCgczx1VPCrbT
         gkfk2yNbOAsuxfDL84RM8Muhm+koPhjazFO7/7l4cEb+u/K35SzoMQD99usRVnAhlo7+
         PpCrTWW2oslYTyyx4OtgTmMxbX53mxGrE6ZIXqMLL+wAbBJYVcr6Vil/Lwv/GJjKmx3A
         dQUA==
X-Forwarded-Encrypted: i=1; AJvYcCUPlGJ3UqlaYpId8fTYstK1I6ZQTnFtEqym1AiN1GUT3plTqT/1zMHiLjetLncKgMi38CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEYkHi10YFtTK81+4VViThz7k7bsLQzEINc3HWbP/h17K7NGNE
	aAkAzujBKuFH4shnqbRE9a4DfUFRiXO/G3705a+4OqsJpaVU0zfQpm8I0Slt5x4=
X-Google-Smtp-Source: AGHT+IHV0jZMTRMsE3nb1LkFXkfV2zMtPAqI54kIfQ4dONz12u2gnZgB6TfDHtlg7qXlKGd5oSvr/Q==
X-Received: by 2002:a05:620a:284a:b0:7a6:68d1:7dfa with SMTP id af79cd13be357-7a8041b2c4dmr2431357485a.17.1725543330285;
        Thu, 05 Sep 2024 06:35:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1e6efsm75677685a.23.2024.09.05.06.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:35:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1smCe1-00CXjv-7C;
	Thu, 05 Sep 2024 10:35:29 -0300
Date: Thu, 5 Sep 2024 10:35:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: kwankhede@nvidia.com, alex.williamson@redhat.com, kvm@vger.kernel.org
Subject: Re: [PATCH -next] vfio/mdev: Constify struct kobj_type
Message-ID: <20240905133529.GH1909087@ziepe.ca>
References: <20240904011837.2010444-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904011837.2010444-1-lihongbo22@huawei.com>

On Wed, Sep 04, 2024 at 09:18:37AM +0800, Hongbo Li wrote:
> This 'struct kobj_type' is not modified. It is only used in
> kobject_init_and_add() which takes a 'const struct kobj_type *ktype'
> parameter.
> 
> Constifying this structure and moving it to a read-only section,
> and this can increase over all security.
> 
> ```
> [Before]
>    text   data    bss    dec    hex    filename
>    2372    600      0   2972    b9c    drivers/vfio/mdev/mdev_sysfs.o
> 
> [After]
>    text   data    bss    dec    hex    filename
>    2436    568      0   3004    bbc    drivers/vfio/mdev/mdev_sysfs.o
> ```
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  drivers/vfio/mdev/mdev_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
