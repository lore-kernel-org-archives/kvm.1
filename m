Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577685;
	b=Mdz1VDySTn07b8SbcDmnFzhFiAOu8AJX2pEu9rEjv8XVC8R2nNubt35Ff+PU26S8Sz9k
	 OmcwK/CFTqz53sqZLCG7TXfyr10cB1YHYuQIPrGPWgwIgOWzO6DPC/lPFuMIKZp/SNeuh
	 bcytQ1Wj8RPkwDvvFh0uFgM4/TVs45sivAZVYGjhbaiL4dO3GG1Z9PbblhQmesci/WCCz
	 rWiNvSLPSNhMxK5SEPJTG4vBTtMW/0OhrdRPAXSUU5sbrY/PxrpM2XLWZC75xcBDoXmfS
	 xX1msOp1XiWmfUgbcJOE5mCmMK9bly6u2n3g1YScq/Y4p3TiVflS+YCHDfR42YAYWmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577685;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LaMrw0UGiuCnM59eNBEdevbmBZ2o/qyOQGg9zp+WMrM=;
	b=Q6sne5CWzkQ1hnWjoLzIk6a51z5FfzaoI/ltL/EnGzY8XQfk2eKJnCqBIkRIZ5m/fLrf
	 P+QdQIbKc7GMAvLLB9SRKbgiNXa9O9t8UZQzHY9PBBFhEsKys5aWqIdM77cbaditPaUC9
	 i93kbMEcLsWj2M00yRhfUPBAevtKKWLk0AUFTK1CbNci3CjdsTH1yTr7B2hzD5Bgz4Xlh
	 t7JEm0FLr8kj+9hQ7Vvxo/motSYC6RawTDpVLgDna0xdMTXZAfkdwiWOltLwNUpRXuJDD
	 zpko2m8QVl5Iv9bZzJ3tUxu5sBdAevarvbVRzX/CCNqjN2WbL6fbWzdJiACA2aCeZ/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TpixcOcI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ejAaswOC;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA99D606A31A
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 10:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA99D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TpixcOcI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ejAaswOC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792577684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LaMrw0UGiuCnM59eNBEdevbmBZ2o/qyOQGg9zp+WMrM=;
	b=TpixcOcIc+qEmEDiQ0FLw+S+qtpggT3NqH0RIXuzC8XKV/f9YbgNr3ahFBE7fZ+GDb2aiM
	MJ8Tu/HXmRNLwBcF7ACuwPEadiowaMAmgZJ/st10hS9I3uA3Zr1aRYCnlG+rN/XIpsvwi5
	q+58VurQ3uB5vhiS4wynDKnC3HLs7QE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-cURSInuvMBe7srSPg4GfLw-1; Wed, 21 Oct 2026 06:14:36 -0400
X-MC-Unique: cURSInuvMBe7srSPg4GfLw-1
X-Mimecast-MFC-AGG-ID: cURSInuvMBe7srSPg4GfLw_1792577675
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e1ad3cb66so282114f8f.3
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 03:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792577675; x=1793182475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LaMrw0UGiuCnM59eNBEdevbmBZ2o/qyOQGg9zp+WMrM=;
        b=ejAaswOCkEY3H7XHMvAZgqt+YFWmaA2GRwEj+PstMfsG6vKej3aW9Mc3rh9fAEWYEb
         pg2JMCkAPE82ExN+TJKKaHRxxf+3uJRlOUFuBXopOsn1ymGHjdcQSgg7go7o2YFOI6B4
         5Be9HrAfZ3MzPuPr3CKBSUBj4Qny302DJ5AAyOadKTYOToXS4tMVBUuwRD052omVT7J0
         MD1H88CSDfGxOULqFgCsw8YcCa6ZqWGbgLZXdbr5TZ9li9gphxupZM28UZ3UNFe32CXU
         Z6TO6k+AYwCq6yZ5V00AlM8z7dgnk6dWXWcf/KseDK8hkirdiHm+lEyFTAzhw2dNekkJ
         r8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577675; x=1793182475;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LaMrw0UGiuCnM59eNBEdevbmBZ2o/qyOQGg9zp+WMrM=;
        b=Htv9uxogKE2iMsRsp2056o/LsD88o7o2am1aFq1iBlwPPXA0x/Adi7FHHqTkGQPd3E
         GIQctHJ3j1Aw3S6HjeHHYv30XmHhdJ9kOhsfQxYARMXRcb5mfSE8K5yvY/WNEuOXRaiU
         OfDVZw1HhoY+d4aJscelyFeaT7BG0prDiCXkvU0V8rvZ3c/cK5bQRkPIsAOpTJVNjAJU
         Alr+IGemVxe3AxZaG+cSBKLtfpuW6BjVIoCx2homRVnRkH0UBw+U9hoUPuFUabvKhHoT
         kdaPGVufRuXDqSJLCVkvzG4oVCwip9p1Rf8Yh9uxjuzv0OgcTeixmX13gUzvMtagOqgB
         FITg==
X-Forwarded-Encrypted: i=1; AKwUvByjERdlTZWIzsMfFa/MCbkBeTuOiTV+uPMT+0pkK0twbVf8jAaRf+nbOSkj/EhkI0P8yxE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL17sZvqbsGh8lGtoy++j9VgvOWBGTQw1CUaX7WjPnKWYNTZdAw
	wShXhC95IhMiDtKLGGnL4i5SY4c9mkIpffdD7ixknmH0Vxl6tcheF1FDFbr8jPGPpeIyom9xB/S
	qhNwJlsafy8LnhwK08dRRgvYueEshIHI9VmswBzPLrCQiSDjT9uKZ8w==
X-Gm-Gg: AYBFou1THPWu9RPGNYKECkEfUpGBCMCn0hhjSnKNWVK6/E5D7Esk2VAECj8cBnohrVJ
	4WZAruTI4qwXj96EuGWJp8zNKRS+Ue9z2JZIUIFBrKj05sR7pZvGNKys5s3FDfWIa1QKYQmwA9r
	b/n9pnWa1PpV770MN/adtk/bLp1XXfU0IZ4hnqHYojph/yT9FJ/YSmeg369Zul98MxwyxkIlrSJ
	uF+Ae8qSHcXCabmrYI/vdmtW6prV3v7E7zsaIQ7Jvz2+4l9jpACkm8c3017OefF1kozVHE1ept2
	zlIdbLJWJRnHbtncKT1eDaHKfgZyihIbxpVGSHvZk3f5jYlItm8MdvEolOwj7o2WiGxtTZAqFb5
	1bKLdhw==
X-Received: by 2002:a05:6000:4213:b0:488:8931:b1b2 with SMTP id ffacd0b85a97d-48e264bd584mr3754113f8f.28.1792577675529;
        Wed, 21 Oct 2026 03:14:35 -0700 (PDT)
X-Received: by 2002:a05:6000:4213:b0:488:8931:b1b2 with SMTP id ffacd0b85a97d-48e264bd584mr3754032f8f.28.1792577675060;
        Wed, 21 Oct 2026 03:14:35 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.178.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f0bc2sm4512724f8f.1.2026.10.21.03.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:14:34 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:14:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v4 3/7] vsock: pass the netns to
 ->has_remote_cid()
Message-ID: <atiQfOneKTIyhGHX@sgarzare-redhat>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-3-047527cfccfc@meta.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261020-vsock-guest-ns-v4-3-047527cfccfc@meta.com>

On Tue, Oct 20, 2026 at 06:15:06PM -0700, Bobby Eshleman wrote:
>The transports only use the socket to find its network namespace. Pass
>the namespace instead, so that a later patch can ask whether a CID is
>taken in a namespace without necessarily having a socket on hand. This
>will help with avoiding CID collisions when devices move between
>namespaces.
>
>No functional change.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> drivers/vhost/vsock.c            | 4 +---
> include/net/af_vsock.h           | 2 +-
> net/vmw_vsock/af_vsock.c         | 6 ++++--
> net/vmw_vsock/virtio_transport.c | 2 +-
> 4 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

