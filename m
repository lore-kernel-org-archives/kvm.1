Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74965165F16
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762745; cv=none; b=UyJ4JuD3tjlWIuclamQ/NNPmGITBQh3kRR1ybqP9yWiY8V2ue38y8eSbtH6MJO7hdyRO+TZfS3jrQbXLq6+YUzNY/15w7CUwAb0g5l70mX8/34tETuv9+kAdFR7c6nxHUO/NJhG2IG4vkX2pwLzoKcinqqezp3owi3e2aYALQks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762745; c=relaxed/simple;
	bh=In3woKIzy/DEvOmthNNzUTK9vJMwlTjoWgqZR7HOkCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBBjbdKoOwzLiHoLp98LdCrcGzPTR/1aGivv7wYu/yK5PlzeoZBk0Ywt6JEKTBh/luLg4LuhF15ZmZkDHSYkzMIiHpFYu0UruTmo06GVifA0WS6ecyUMvYXw2rR9s3cASUs58+HhjTyiN9qEjFspQwORUSnW+qPefnlg8a33Hnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSXiGvMF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vrcm0W8x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSXiGvMF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vrcm0W8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773762743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/pgd8xNqc4Uj/DdymXAL8NviCvbDZWqQRqr0Gu642Cw=;
	b=OSXiGvMFnrMc0KHMOFIx6A98LRRk6cTsapoI9b0U+zQJPq9L/IvXdpPQYeVNpP8pbBc4Mz
	cdL8BUxgUcoByH04qmawc3iNLf0RB53a3NYLI6ZagqfPMnk/15JkZRj9JoQ+CR+xhwgZtv
	eExcvzfS3tYv/uJ9ZNM1qFBZxiAnLpA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-CFb837DdPXqJAndsWJkm8g-1; Tue, 17 Mar 2026 11:52:21 -0400
X-MC-Unique: CFb837DdPXqJAndsWJkm8g-1
X-Mimecast-MFC-AGG-ID: CFb837DdPXqJAndsWJkm8g_1773762740
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50917afa521so1528671cf.0
        for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 08:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773762740; x=1774367540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pgd8xNqc4Uj/DdymXAL8NviCvbDZWqQRqr0Gu642Cw=;
        b=Vrcm0W8x7CHTFyAlaKVQXEuPBbqlyNQvPs6Wl+xaHs/cFzbeduBrK/Bizwbtb5L8v/
         8zgoao1I9WfqZpKsbv3tFq9HZnVCjze8Xvzr7vyEVuxsjco4i1Vk4GovjxkPMniLh8a2
         JsUnDlu8E27eta/PBUgGMwBOggPjq2aZK6fuHdHk1nmVw5ZGv/Uqbs5Ko1eKt9fGpYGI
         UZzCYsF3dE1u8jx+3fJ2mBXbQCWrH5NdrPuv+5FzFO3cHwBiPgFz2jHefvjnjEwe0j6E
         W0OFyNpLDgv9LDZZZPkjaJvjqMzNOOxECyVIQa8UQKQB740iKIGZDPwHVUp/XJ/QMaNb
         fztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773762740; x=1774367540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pgd8xNqc4Uj/DdymXAL8NviCvbDZWqQRqr0Gu642Cw=;
        b=oSQDlkfwQc/7kf61bF1kMdpsIFiU/yIN1s2pnIxSAF4sMqrpk8qsDbiydvKXuTrGml
         GZbE7mDx6BDxJSckfOFK4M9RrgxiGugdz73VYaCBCOOgWZYdTdG+qQ3gOJykyp+T6Wje
         8o6ICIXCiwIzFx1agObIikQM7Mvj0plr7w98zlDLeZOCUeU6gukEPrsYmJ5AMN/JMoM3
         yySymnrRQYYLjlTLKBpPfYXh+vFmOL+lAVqFBYJmLiyFaXDSk9NSSEysX5VdlIznlqHn
         IZAW8WbkO+XYsIoDGHCnrYJb/kDXfmt19LYEFrgZA5fEFcQSbGAxvOndnatU4tklL6BL
         QzRA==
X-Forwarded-Encrypted: i=1; AJvYcCVq9wUqEkXMtCeG2LzjVtCSvhKu+UtJ7d9PSuzwMjhvcjJeEibBVpEi/nxlp/bmpP7Tovw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2hh7xFOV0OHzF9QK8wWIrbXbl3j8DcfCuOqMMlkTqRmNkRyXh
	/fqMWEZUFLHbx8+Lcy6Z/5V+5V9tOVaAc63osXE7wVMhSJea12rNL8lbyqRuirMg1/W16SwLbwR
	jUugByO1/V2OG8BukKQ/oWKIM8WgVGQXGj30UU/2dC6O+Ihd97CO5HQ==
X-Gm-Gg: ATEYQzwUhv2tK4c1oUYsqc+6FWUaogQfhXOA0Hq/ZTcDqaVu7v+4dK331C33mDcENCc
	om1O8ISwkR4DvtxXF5JAy4mKw9gU3sQIsczrNcj1StlbOCB6a3/HqRJQMRd4V9JZuDYYP+77tTS
	JeiHHyFhcwEEyBEmp/QNrgH7YLccMr3NHePG4SZCeTQJTi0+RrcsAZT6jZwyF1LyvEaQJtQiTij
	PQ5vCnfein+/2owyVmwsjZBbkBeS6uEDAzlmScKgmuLr0f9tLhyZe33pe3dgq21ZV6pdtGLFEGs
	roMAVCNhy9vA1FRQmVZeDL/uus7ySy8kUzhfyNVaocZZztdR0qjVRrVentB0xWv9AJXQ6ITCTAY
	pGFPzAicscHkT/A==
X-Received: by 2002:a05:622a:c6:b0:509:1be4:97d1 with SMTP id d75a77b69052e-50b13a4346fmr1529471cf.34.1773762740263;
        Tue, 17 Mar 2026 08:52:20 -0700 (PDT)
X-Received: by 2002:a05:622a:c6:b0:509:1be4:97d1 with SMTP id d75a77b69052e-50b13a4346fmr1529031cf.34.1773762739702;
        Tue, 17 Mar 2026 08:52:19 -0700 (PDT)
Received: from x1.local ([142.189.10.167])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b134ac5e6sm1425121cf.11.2026.03.17.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:52:19 -0700 (PDT)
Date: Tue, 17 Mar 2026 11:52:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Alex Williamson <alex@shazbot.org>,
	jgg@nvidia.com, kvm@vger.kernel.org, kevin.tian@intel.com,
	joao.m.martins@oracle.com, leonro@nvidia.com, maorg@nvidia.com,
	clg@redhat.com, liulongfang@huawei.com, giovanni.cabiddu@intel.com,
	kwankhede@nvidia.com
Subject: Re: [PATCH V1 vfio 6/6] vfio/mlx5: Add REINIT support to
 VFIO_MIG_GET_PRECOPY_INFO
Message-ID: <abl4sV6-wLwKgKe8@x1.local>
References: <20260310164006.4020-1-yishaih@nvidia.com>
 <20260310164006.4020-7-yishaih@nvidia.com>
 <abL5wKfPGzi88iBy@x1.local>
 <20260312130817.69ff3e60@shazbot.org>
 <abMfLQPzVFK388q_@x1.local>
 <fb6cb519-25d0-4cba-b13f-513349fb49db@nvidia.com>
 <abhZBIe-vR-GX3TT@x1.local>
 <accc2aeb-6ae1-4aec-867c-c9927e98f903@nvidia.com>
 <ablf_dVtYlZOoIcp@x1.local>
 <a1ff85c3-2021-4c22-b74d-cafd490221dc@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1ff85c3-2021-4c22-b74d-cafd490221dc@nvidia.com>

On Tue, Mar 17, 2026 at 05:22:22PM +0200, Avihai Horon wrote:
> Yes, I don't think either approach fits perfectly. We can discuss this in
> detail as part of my QEMU series or as a separate topic.
> However, I don't think this is directly related or poses any problem to the
> precopy REINIT feature.

Oh definitely, it's a separate topic.

I hope what I will propose will make it accurate again, but we can wait
until seeing the patches.

Thanks,

-- 
Peter Xu

