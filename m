Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA93E8338
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886673; cv=none; b=KUoBlcSvcsgyTwvzSmqeYpt047jDcljJFB4REXL4tqrZ+jzNJZMymmzBkqJ1Dfe+C7BVUQ7NoR9b3pNvC77LMo40sd8RmXaUCrTyXI7XrE//CVgZ7VOlCHsY/8hqYGT+94Y1atBc9lQKU32JgiZM2YfLnnVMXUETVwxq/yRLkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886673; c=relaxed/simple;
	bh=mIerHSoA0UPEkltbp9WWAtUXDdAGlSICZDdSK7TN0Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+6FJeefGIzU0r218RT1527ZrIap+/r/BAHtXUc5SBY1qnePH3ukrd2tWAON8NNyjHi4F8n5YYL9hT3kxdza0hogLtd+vVfAHaxOZdC/V2bZ2uKBVgssV7gEs4ApffchiaXNKT2Omw38EWRP9aD9ZxYnw+d2QyCvLkHghIfD2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoQeNOv6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GU8qH6o4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoQeNOv6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GU8qH6o4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791886670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TQm+7FhyHN6+IiGzitNgRTZSKN6UAw4IPMrNRyYA++I=;
	b=hoQeNOv6aULh/9QEeCfQ0ehKbAoFVJs09vHbUFncSxR9fiKdv6NBATz+x4KTyG5oJmW1Rc
	6O/1oujaHjsFiid2YAFPdu+lENtlsVosIfaMPTNSyKkPZsdHpo1JunbAYbe+IIaLZmnTu2
	pGP4LfVABcBKLX7Lc+DZPHq93PaMBXA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-Yws88rJ4MKiBFMRhcSLoaA-1; Tue, 13 Oct 2026 10:17:49 +0000
X-MC-Unique: Yws88rJ4MKiBFMRhcSLoaA-1
X-Mimecast-MFC-AGG-ID: Yws88rJ4MKiBFMRhcSLoaA_1791886668
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-486f9d150c3so1667107f8f.3
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791886668; x=1792491468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TQm+7FhyHN6+IiGzitNgRTZSKN6UAw4IPMrNRyYA++I=;
        b=GU8qH6o4wR2Oz0Y2zwKYOhV51o3IevFPSmp5nuWzvuy9Kdpf3gqsscKuGMbH+btojk
         90A4SLFmJape0AqbvsR+Vdc/2kJ/BgcpkRapopph8nkrXUYtYiTf2sOIkVv1C10G0AMY
         c9U6r1fYLJnw0scbhjPHgDFaFK8YU4hUue5iUzlhKEkEX3fKnYNMF6pUJb3VdkheYKDF
         dQ81GlD58TKEGpUnrprDiTHM4g5ykbmqRzzkJ+yuTSNdiEPf8QukudCLHEkDZ+yahPqT
         v3YD0ieqkG+3eAjLhCraHgjF1G+NV9awX4eE0cQlYGnAzZEw+MS2Eo+wdcbigTxgjD/V
         e0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791886668; x=1792491468;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQm+7FhyHN6+IiGzitNgRTZSKN6UAw4IPMrNRyYA++I=;
        b=1sYJAkIuBz8gEAzjY9s7Zz9sUHNxVbRcwaUeKiY/LH30kvTc6XMXx1MC0ZQnLA+vLu
         +Z8DIUBzoEeh4bEIw9mrGTJn+675SNLfxu/T07vw2hfzXGO1LeMTAdVZEuZho6UQt8fX
         dUzri/YbYBzN4Xn0lx3Hh9AuKbrMdfnHgKgFbscGc/1/Pin1MUmR8XpCwb5Eqx2ZoToF
         1Nog7grtAtLKSHTr3nJg9euCX6WADaiXRV7fjHGiMycE9s0x53Rprok6i0Pwj2u+FmNg
         MDyZYmFiAHjyrtu+YXMFL1AdPy7PdJctJRmjU3O2rXkUDH7vY5t0lcY4wADsMgYv7VeN
         9wjQ==
X-Forwarded-Encrypted: i=1; AKwUvByfTo2xrldq202r7YeGvTDHe/x3WMK9g7ZEZpN6PEmwqMIh9wg7LxlX+3rK5ykMI+3+5zE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcor3A/nzd/apW8yybZAo94FRBPIIFMldPc+Z25nEhbaVKQqKa
	3VK29dufrCKh1ton3wQfc2lvhxPXTD1OaTLB9JwTn2QZZ9Hyp5YqMfk5MKqXm6Q537qhlTSNLk8
	w7obmrX+XEAK/fPTvn1e7ZONszw7XZoAHxfj5tFaH7HqkkNRY44N0hw==
X-Gm-Gg: AYBFou2MB2wj2Iq1b/de+tJhY6iV36IHroIQNPyjq0hPqAr274cGW/aP+W9KcoShINe
	Un6fyeLeGnZCVomJAp/l2NX6XDYKwZdTXMTC1Ojw1aE3vYDlNgPXsf7LQJWH4owI4NSlV3VF5Te
	oQEH//2gCm+RXILmJgJbJJP35PgZJM0BOgMLm0MpGTRyFFI4cA3HNRCK0Zz1b2kIRaYme6VD9mD
	aq2C/KlA++u6IbCgzyQqoGPM0xJ4EJeaAmkSGYA28VfaBHhT7N6m8BBSQSPrVcfEOxJ3kSNaFyc
	MOjfU+QH2dWDhZv97Oxc+XA6OZp4yVCcT70JKhLbRLByJmrnydT+/BwGo2EQ/v/6/p46oQ==
X-Received: by 2002:a05:6000:470f:b0:48b:74b:4ce1 with SMTP id ffacd0b85a97d-48dbad00328mr20458005f8f.32.1791886667592;
        Tue, 13 Oct 2026 03:17:47 -0700 (PDT)
X-Received: by 2002:a05:6000:470f:b0:48b:74b:4ce1 with SMTP id ffacd0b85a97d-48dbad00328mr20457934f8f.32.1791886667017;
        Tue, 13 Oct 2026 03:17:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc5e0asm4276759f8f.50.2026.10.13.03.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:17:46 -0700 (PDT)
Date: Tue, 13 Oct 2026 06:17:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: add Bobby Eshleman as vsock reviewer
Message-ID: <20261013061724-mutt-send-email-mst@kernel.org>
References: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>

On Mon, Oct 12, 2026 at 12:58:08PM -0700, Bobby Eshleman wrote:
> I've been reviewing vsock via lore+lei for a while now.
> 
> Finally adding myself as a formal reviewer, since vsock will continue
> being stuck with me for the foreseeable future.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>


Bobby's doing a stellar work.

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f53047aa8d3c..cc1341f6e15c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28840,6 +28840,7 @@ F:	virt/lib/
>  VIRTIO AND VHOST VSOCK DRIVER
>  M:	Stefan Hajnoczi <stefanha@redhat.com>
>  M:	Stefano Garzarella <sgarzare@redhat.com>
> +R:	Bobby Eshleman <bobbyeshleman@meta.com>
>  L:	kvm@vger.kernel.org
>  L:	virtualization@lists.linux.dev
>  L:	netdev@vger.kernel.org
> @@ -29145,6 +29146,7 @@ F:	drivers/media/test-drivers/vivid/*
>  
>  VM SOCKETS (AF_VSOCK)
>  M:	Stefano Garzarella <sgarzare@redhat.com>
> +R:	Bobby Eshleman <bobbyeshleman@meta.com>
>  L:	virtualization@lists.linux.dev
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> 
> ---
> base-commit: 8e2fbe0e75d38690d551456658194c632933cb57
> change-id: 20261012-add-maintainers-bc6e8a6fa68b
> 
> Best regards,
> -- 
> Bobby Eshleman <bobbyeshleman@meta.com>

