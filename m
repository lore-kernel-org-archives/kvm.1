Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE43E44ED
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883153; cv=none; b=nlKiR4Lz5ScQmGzrGdTXJFFdgzIERlLpI0AMT1XpGCIkHQycQW9tr0TB/AXsXWUoEyGOq+bDlKJf6HYx04Y0aamcwo8VQP+KYvt2chySJoQOvgej84r7mthyi1QYqUfjifkyqPiCw72IHAAjdrdM+3puLzjGyh6hPD9QnMDnq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883153; c=relaxed/simple;
	bh=9ifxJXmHIdOpbrwVmaxz9CH5L1s1R8aDY8bfmqlUzMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pj91GYLdNzFQnrdrZu36pV7AcQOiPuikqG8kmaKfm7+Kw8NAqttZG5NCpBj1T1gcgoGr0wLl9oEU22oDajpMABiErY/EHs+8BMEqnmdx6DEp6MEvFM/jvo+bTVliMePntxch1nV8QyHbSzcR3/tZseTFjypkXczsjbVrOqCYERc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ov0VuveL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lLtyGA2q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ov0VuveL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lLtyGA2q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791883150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ifxJXmHIdOpbrwVmaxz9CH5L1s1R8aDY8bfmqlUzMI=;
	b=Ov0VuveLeObjOwaRB2qWt+D6F5dKBKjkhAlBPOHenH9CoDyOPb1sCNogT+qLPcnB5Rp/P+
	OgxByoDspTZ5ajLesyi6blBjkU3eoS79i4OKgiVMlcjcfIQn/LrngPdTWHcsIuhsBaF6KD
	hn5/n8PGOIRnxqdvhe1L2kbF8fEfGp8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-whsyZIUaMA-0dzarWISYrQ-1; Tue, 13 Oct 2026 09:19:07 +0000
X-MC-Unique: whsyZIUaMA-0dzarWISYrQ-1
X-Mimecast-MFC-AGG-ID: whsyZIUaMA-0dzarWISYrQ_1791883146
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a01c621dc2so21273455e9.2
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791883146; x=1792487946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9ifxJXmHIdOpbrwVmaxz9CH5L1s1R8aDY8bfmqlUzMI=;
        b=lLtyGA2qfs1FtYCSfcwC6xDHa7fRYIYKmkjAQdzIdRx4KQwBGW0ewSyWLoF37tq0m1
         FRszzSMj9Q3vTc3cWpVCjEKPgWfvtFcZMPMS7edla2ZbzHZfgQBtBivvY7PO4cd7cRr5
         9QFHx3WYsoGPvKMAKeKhOOZpq3b9R4Gyty0ta/32T6cPKN1WpTiMZnXldjUdXUf4WebX
         px0UYBX1NwGsCt23gSu444LRzKa3+sYab2Q+zxqYsYzdJimKGidUBD7HjaAa2wMqCxig
         /8UMQQ94FPeLFFWf/12EIQ9JwNi7lcJrARSU7P+lvaGlmZBrO5cETSsj+ZRrLqx0af5k
         g2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791883146; x=1792487946;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ifxJXmHIdOpbrwVmaxz9CH5L1s1R8aDY8bfmqlUzMI=;
        b=qYjomhtApTf29Acr0htcBAH1OwS/Rl2zm7NxLMuo15spShPZOMf8Y3g/BKSmQdOUAT
         gwLquoOBKYIGzr0iTLxURYgRkU2CSmboOXTnQEjtoFQlcedbef7Ed+HN2doSsE41EZw0
         EjuwCxx4dtJaBUFTbtA5YIMQLlTAeZfao5dCsGbZx8J2yhJDxGpkky1zduUwWaDHhmlz
         36bT8yULIIMxUIdtC0ehjxzYsNqbHpnec5hBAVb+5LUUKw7mKlsCV8PBsXUrznlANLgO
         xOh7JiwZuuIl15VSVJLMvyFdHHYc8GyXOt+xQrAyOKfjk8EwchSo43P5R3YUgTBozuKY
         u96g==
X-Forwarded-Encrypted: i=1; AKwUvBz7NH/+cI3QghzkLTyYQg7sDcMMHjkKuVnDS8zx0t0Ip4qZOTBVGc9cUJPeRPEge2r1eno=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoLHItPlxmi4oYbm8njmsmpEH2o4voRwjaAGbbq66bG+SUkiU1
	DrbKC3/Wtzi+9l4fBkmGlBMHfYHpnmQRCWDow7hX9WZ6UoPHrA2vxcrsv3o+gXl1sIO0KNsnRbu
	+EXlvie9e1pT2SWcqMlKFAr4L1prUxGjfYbTq3i44RDzY05LvHM7r1A==
X-Gm-Gg: AYBFou03rjDRr32hQqLSXBSuaTeCJ2B17oBwWMPTtjvjLsf9WXU5lNijvtXa4+6GxMf
	+TNkPDvv3Dk4kf57lHF7Ypzoe09B387ILXWHScEsM1ha6P4F/Vq4aKvFHc1jj0Vikr/1KDaWr2L
	oBeMB7GyyUI9zaspXQyKIk/N6bnOjDkGNIOORJR7Eev/1/gBafSuYCFv9+LfTVFyvEx5WT2L5XH
	j5DGn0RfVK7s7LvjhBOFWnrxDKFt9USvvahbEyu22WILDdirFv909eMin9UOg0W5D4sVkSPgOH8
	si47tGp68wGIClVQid6WV8vwc2VW+dJaJyX9YzS974GIvC+GSQZGLl1ZHCbDcBGxUiBTnzvTPKq
	qyix8cw==
X-Received: by 2002:a05:600c:4e8a:b0:4a1:78dd:dd28 with SMTP id 5b1f17b1804b1-4a18e4d2b31mr237237675e9.27.1791883146090;
        Tue, 13 Oct 2026 02:19:06 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8a:b0:4a1:78dd:dd28 with SMTP id 5b1f17b1804b1-4a18e4d2b31mr237237135e9.27.1791883145585;
        Tue, 13 Oct 2026 02:19:05 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.127.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm508318675e9.9.2026.10.13.02.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:19:04 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:18:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: add Bobby Eshleman as vsock reviewer
Message-ID: <as32zxVBpgdtMUOU@sgarzare-redhat>
References: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>

On Mon, Oct 12, 2026 at 12:58:08PM -0700, Bobby Eshleman wrote:
>I've been reviewing vsock via lore+lei for a while now.
>
>Finally adding myself as a formal reviewer, since vsock will continue
>being stuck with me for the foreseeable future.

Thank you so much for agreeing to help when we met at LPC xD

>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> MAINTAINERS | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

