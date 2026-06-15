Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014840FDA0
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541931; cv=none; b=L7dgHgYkxOmIGmRrOiS37Ns3qe2v55tpZPPO2rTGxm0K0AyAcIMkFrK1VJ0PMbS/ItCuJEMO4ZnGxsuVH/GgyfPzD75aNZefMT8nuDIsJAG/s26X2ITbIwLk2itc5jiOU72+VIsZseCsqhEsClO1iydx3wdj01SbgwDnmunGiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541931; c=relaxed/simple;
	bh=Am9Jq8ZPWVvsetHtt0SyO5DKTSf2oVvFUTTjrA5taFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAKndg7RYxwUc8+EbZ2RqY29C/yuwSE/6epEqArrb8HGggqD4ubiFa7snFLfB2EYupZYQOpp3qCWkZKgZ1KYmZ+8PkZm/a4Ln62Re7xQfZE8g1szYI/1o/ChAAc6NRoGWdGHXesMgmwAwAw0LSxlng0O5boxnLfGR5DMjIoP+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IzCPkZzF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IzCPkZzF"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf237e1433so43866745ad.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781541930; x=1782146730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5AymUI1dDecjLNnO9PnzUKcv1HNQ3H3YwtBEkoZtTw=;
        b=IzCPkZzF+4aBzIOKuRT6HgeEYcT06jZWUb9aibx6KubStCPYkufajKTPBT9bnqh84f
         qnHHc7IVhtDQT7jgTjJIz/UseEDiC8nnJ76Kodm0r0jYqpK8oB06kqdSQwkKLcYmFdYm
         iwN4nSeM6BH1FxVkgd3uqlRZIqVgy90puKP9TVoq57R6F23mPbzEcwFdSHXM83iGf6LN
         LCBFn9yfVz0TwEWw8xQXF+ZMmUJVAgD4SGhGaAdllmj1OdJte/I8PfYDEz4nVsRIVsXQ
         eU3E6jPnl+SvQE05FTE+1fe7BE1Ejg0yNDSMUuRUSs52Jz9A+/7rorpQj4rebrz44RrS
         LdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781541930; x=1782146730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5AymUI1dDecjLNnO9PnzUKcv1HNQ3H3YwtBEkoZtTw=;
        b=jQ5Z/T121IAR/xhkg+Jd/lHN28aoww5raNNUEx1cUvU7MwEaWe0CuuTdAHbzLDHkvD
         6W7yKGZlS8eHgvvET2bcaFXZ4QKIh7i48GK++u+F2Bzn+myaMAXO0RGwRldcb0NDXf2g
         BgLnNKdS6M+jtEJz76FscazBRtsFjdrwxRwWCEbW05/Z7HqYpen3d3Rl7QHxMB0SROxb
         Ydt/TPUnKaIBSnIhaxtTMSDCwbKd+MjgLfppDnhyT4Rp9gHlxZsgyyjMs6EdGrhC5PDs
         MQU0VBGecEEllsukVaiL8AoiijkwG471wVUXKGRvoUJm9Pnty7/xIfrXK7oK+aOIEPnA
         1YRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8iADt2hcpFYByLxChcFZl4I/t31Kj5t9HYWvSA3nFV7GI4C5Ed5Zxdu9XYgRdzVCqSM00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBhllOoi6FsyOmPR98B78nMp62ZcLn1KqUOFpbitZEzSZJPDFO
	fifActk+SNO2OolftmwbGbYuJYzvz8XIMZiAOcLqcmuurf7Jmrvi0fCCM6Fq6rmsQQ==
X-Gm-Gg: Acq92OE9REbm+gMDhsWRzCOCTVDjJnsHEFJUgo8Qm38wrrXFDe+Fxy6C2g3vHfTHiim
	vYFlnrGtjBgu3TYqEbtmKKKr5qJYxFoOMJYqJFBPEU31DD+xuaUQQ8TCBnY7PCbgOhPrsxl3Pwj
	LCsj51EsbGoLjFUIqaeLl8rTpJI8zKXM+JzM2dI+uU+rvnkdCUzijIqjLpSm11vGSZhgCq3wGg2
	gIcolho+hUNz6oIMhJCcbfxr2ufuEokYArr3yML2DFY0aQI2jI/PUqM7zCiTHV/oUI8OG0kUBYu
	UVtV5SKciaLs+QUHb8uBE0U2SioMnKVRrVAK4FQ+dHz334el+g7ft+BnTSUqa6RI/B0y8QrLNtw
	+kzYK0Ol1evO9jtbew8+hm+EciTMs1mv5H420N6tcjcfvilIu1ZGCdG/yj3tzoZPTf4Oe281Tqg
	TigD/kGxxy56xg6ERaD50Ikt3otlYeyfVVRCr+wzo1Ne9cUpiYHcAORaXwSO6MgQ==
X-Received: by 2002:a17:902:e78f:b0:2c0:b7e1:7f08 with SMTP id d9443c01a7336-2c41235c53emr158816355ad.28.1781541929234;
        Mon, 15 Jun 2026 09:45:29 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c6c5dsm104582015ad.21.2026.06.15.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:45:28 -0700 (PDT)
Date: Mon, 15 Jun 2026 16:45:25 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/vfio: avoid VLAs
Message-ID: <ajAsJXWxRQtkIaCf@google.com>
References: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v2-1-4e4df462908a@fb.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v2-1-4e4df462908a@fb.com>

On 2026-06-15 08:47 AM, Alex Mastro wrote:

Please follow the local convention for shortlogs:

  vfio: selftests: Description of the commit

> Allocate VFIO ioctl requests dynamically instead of using VLAs. GCC 11.5.0
> rejects initialized VLAs with:
> 
>   error: variable-sized object may not be initialized
> 
> The replaced stack u8 arrays also do not guarantee native struct alignment
> for the aliased pointers.
> 
> Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
> Fixes: 20face8c75ff ("vfio: selftests: Add helper to set/override a vf_token")
> Assisted-by: Codex:gpt-5.5-high
> Tested-by: Vipin Sharma <vipinsh@google.com>
> Reviewed-by: Vipin Sharma <vipinsh@google.com>
> Signed-off-by: Alex Mastro <amastro@fb.com>
> ---
> Changes in v2:
> - Reverse xmas tree variable ordering
> - Link to v1: https://patch.msgid.link/20260612-scratch-amastro-vfio-selftests-avoid-vlas-v1-1-ba3acb635f0a@fb.com
> 
> To: David Matlack <dmatlack@google.com>
> To: Alex Williamson <alex@shazbot.org>
> To: Shuah Khan <shuah@kernel.org>
> To: Raghavendra Rao Ananta <rananta@google.com>
> To: Vipin Sharma <vipinsh@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c | 28 +++++++++++++---------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 94dc5fcecbeb..c65d5ed33e51 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -30,13 +30,12 @@
>  static void vfio_pci_irq_set(struct vfio_pci_device *device,
>  			     u32 index, u32 vector, u32 count, int *fds)
>  {
> -	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
> -	struct vfio_irq_set *irq = (void *)&buf;
> -	int *irq_fds = (void *)&irq->data;
> +	size_t irq_size = sizeof(struct vfio_irq_set) + sizeof(int) * count;

optional nit: s/irq_size/argsz/ (same for vfio_device_feature_ioctl())

> +	struct vfio_irq_set *irq;
>  
> -	memset(buf, 0, sizeof(buf));
> -
> -	irq->argsz = sizeof(buf);
> +	irq = calloc(1, irq_size);
> +	VFIO_ASSERT_NOT_NULL(irq);

Could you add a precursor patch to add a calloc_assert() helper to
assert.h next to ioctl_assert() and snprintf_assert()? It looks like
there's quite a bit of code that repeats the
calloc()/VFIO_ASSERT_NOT_NULL() pattern.

> +	irq->argsz = irq_size;
>  	irq->flags = VFIO_IRQ_SET_ACTION_TRIGGER;
>  	irq->index = index;
>  	irq->start = vector;
> @@ -44,12 +43,13 @@ static void vfio_pci_irq_set(struct vfio_pci_device *device,
>  
>  	if (count) {
>  		irq->flags |= VFIO_IRQ_SET_DATA_EVENTFD;
> -		memcpy(irq_fds, fds, sizeof(int) * count);
> +		memcpy(irq->data, fds, sizeof(int) * count);
>  	} else {
>  		irq->flags |= VFIO_IRQ_SET_DATA_NONE;
>  	}
>  
>  	ioctl_assert(device->fd, VFIO_DEVICE_SET_IRQS, irq);
> +	free(irq);
>  }
>  
>  void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, u32 vector)
> @@ -118,15 +118,21 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
>  static int vfio_device_feature_ioctl(int fd, u32 flags, void *data,
>  				     size_t data_size)
>  {
> -	u8 buffer[sizeof(struct vfio_device_feature) + data_size] = {};
> -	struct vfio_device_feature *feature = (void *)buffer;
> +	size_t feature_size = sizeof(struct vfio_device_feature) + data_size;
> +	struct vfio_device_feature *feature;
> +	int ret;
>  
> +	feature = calloc(1, feature_size);
> +	VFIO_ASSERT_NOT_NULL(feature);
>  	memcpy(feature->data, data, data_size);
>  
> -	feature->argsz = sizeof(buffer);
> +	feature->argsz = feature_size;
>  	feature->flags = flags;
>  
> -	return ioctl(fd, VFIO_DEVICE_FEATURE, feature);
> +	ret = ioctl(fd, VFIO_DEVICE_FEATURE, feature);
> +	free(feature);
> +
> +	return ret;
>  }
>  
>  static void vfio_device_feature_set(int fd, u16 feature, void *data, size_t data_size)
> 
> ---
> base-commit: a26b499b757cfc8bbff1088bb1b844639e250893
> change-id: 20260612-scratch-amastro-vfio-selftests-avoid-vlas-395eb3dcb3ab
> 
> Best regards,
> --  
> Alex Mastro <amastro@fb.com>
> 
