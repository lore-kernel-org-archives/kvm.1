Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD201233920
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781307950; cv=none; b=Kfgi87EWYN0d90UQJ3n1ir5aJxbZnYco604J+JuEeHT6ddsbMQUZsZBYr7nDJnadssosAQfivH+pIZa1BrjtYlPXhf7JE2o88d7SmMCD7nxPfzVEdKFERNZOuq69taYBctIrdpA2yKnZMnhJpgSIg6o4D+bNCWMTAsXinBPVcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781307950; c=relaxed/simple;
	bh=ZpzJ+DT+CutZOfbYSkxts9QirdeLvJOFApvLfehusbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcAidukPFu/X5k2rMVRDvC+8wchfxmelBdlxYA6CGNpG9I4arejp7OV1osqqbdb/uXJntnVgwSFQNY2ix9K+4eR7O5Z5woz2GxXWzb6+zITmBUIjXVMan69qZOulr/iHeUpTuqHMzx0Qw3Y+LsIDWmZJVNWIFjDpdwY1y9ehdvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mj+gsEni; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mj+gsEni"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2d865383so17525ad.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781307949; x=1781912749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lAHtPY+/xBPLLk/0YauTqG4szlUQHGM83CP7gLoGpLo=;
        b=mj+gsEni8ooOLbvT3oRPgoHBmhedPo2yOg5TLWaZ3qcLI4PFfqR6uotjetTCKCiuNn
         glsazqwmQdDTJghe6laCpvUDEAvyupS+SGe91dprMk9Q1ulgRG2/f2P4irMz775FYPcn
         UfWH2wE1lY9iCuwTYwYy8lavCq2CPVb6LiAIvKpn7Nb+XBg8zY5QyxG90Lt8536WLcTV
         w08JYhi3dlyyit13K6Wl9zu/npsJhNXH1iqrAN/8JRzXdxwwH858drnpVt/jVJJEwBpb
         o8DvK+D1KGB5IQ2lPyktvUq8GJkmGInihRc80VOy+IeA+/mCtN2XqYz8L67ulaTj8w1b
         ggwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781307949; x=1781912749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAHtPY+/xBPLLk/0YauTqG4szlUQHGM83CP7gLoGpLo=;
        b=cFpfVrKucr9uVpJHzG0Y6VHss1hp2FUNGYBozLza1j6503y76UKHWwtfAqua5a+veb
         MadzFN6GIZuk+L2aG2+j+RTPW4BkyMfuI9DtZ9FDKA9l6zDiwzq3Ncfd3KbT6HvBDFoU
         cfWxtT0CAaAvW49PTyxr0ShUUrW6ky5x0G5kyxrWVjL9GstZu2ugh1WQupz4wPG8mPNr
         EX297sK1ufdgSyqsGNtrT8JUKy2Vk1GGEpUSexQ45sSFn8C/3RTZ2ug1CQahP+Du2noh
         v5Ou+WCYexUjaAIpo02NASpTYl9QjmKmHtJWSRUMOvMM9y+7Wjb2j1VTznHxsG7QzXE9
         9CoQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FrNgJLJlawfePVtmeo7ATuzTyEUWMhBvcnBNlifL2lqi3SE4cgej8h68oKelUo/vdH2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6vx88JH3bOTRPyj5a7fagzPHAwAfgZYApM6KhPjYp846P/j6T
	nu8gxY8P2HEYoI3HZ09gyoohU0YnBQTAF4uhO+Zf4awWu3thK2sWJT1W/rVY1CvbRg==
X-Gm-Gg: Acq92OH4D6hlYkfiKZAyjpffX2JQGAWTIByCEvQE+IlDm7v4C6uZ48DzAYQeThU+/3P
	5smEJN2s0Omfxy2NyP5Wpubcbh6szl9uR+p8iVmxqL7d6qAfp+2UKBLg5X8EVY1stQkhbH0Iliu
	Qi70oAkulo5LfRvBsAK1g1Bq13iYXHDJS7ExsCPWHPNHGzIktn2JRqk21S+IFS3HMom1Y3f8Zwp
	oskrIIT8gJMhIYmXlen3OqjyyNGlQLh3bHubbX89yOckDu16seSnR3ESdD8LmuIoVIicZU2hP/J
	dQMredhINxuu8vcQygT5Lp8LkDWOO1TeUU8tWwcclzWmHNsPuJefUYUQZxChWNAKQU1vwaDwfAT
	zlpK9M+4P84Ky2fzBvg7V/H3+6QSNBtCS9n7YH9jYY2AU9nGYOO3XP7vWrp7F3ip2n/LiXHaIl2
	8KhJt+419HITCNKCM5PJMuH8bTX36UuacaBi2m9LpOO1sjbEJH5/kmC22Q+UEL
X-Received: by 2002:a17:902:e845:b0:2bd:6dad:7ccd with SMTP id d9443c01a7336-2c665ec6b7cmr458895ad.25.1781307948223;
        Fri, 12 Jun 2026 16:45:48 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e5590sm35963325ad.14.2026.06.12.16.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 16:45:47 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:45:43 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/vfio: avoid VLAs
Message-ID: <20260612234154.GA667942.vipinsh@google.com>
References: <20260612-scratch-amastro-vfio-selftests-avoid-vlas-v1-1-ba3acb635f0a@fb.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-scratch-amastro-vfio-selftests-avoid-vlas-v1-1-ba3acb635f0a@fb.com>

On Fri, Jun 12, 2026 at 02:58:18PM -0700, Alex Mastro wrote:
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
> Signed-off-by: Alex Mastro <amastro@fb.com>
> Assisted-by: Codex:gpt-5.5-high
> ---
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c | 28 +++++++++++++---------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 94dc5fcecbeb..0b437435cce1 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -30,13 +30,12 @@
>  static void vfio_pci_irq_set(struct vfio_pci_device *device,
>  			     u32 index, u32 vector, u32 count, int *fds)
>  {
> -	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
> -	struct vfio_irq_set *irq = (void *)&buf;
> -	int *irq_fds = (void *)&irq->data;
> +	struct vfio_irq_set *irq;
> +	size_t irq_size = sizeof(*irq) + sizeof(int) * count;

Nit: Can you change it to Reverse Fir Tree style? Same for the other
change.

Other than that this looks good. Thanks!

Tested-by: Vipin Sharma <vipinsh@google.com>
Reviewed-by: Vipin Sharma <vipinsh@google.com>

index 0b437435cce1..c70636c214bc 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -31,8 +31,9 @@ static void vfio_pci_irq_set(struct vfio_pci_device *device,
                             u32 index, u32 vector, u32 count, int *fds)
 {
        struct vfio_irq_set *irq;
-       size_t irq_size = sizeof(*irq) + sizeof(int) * count;
+       size_t irq_size;

+       irq_size = sizeof(*irq) + sizeof(int) * count;
        irq = calloc(1, irq_size);
        VFIO_ASSERT_NOT_NULL(irq);
        irq->argsz = irq_size;
@@ -119,9 +120,10 @@ static int vfio_device_feature_ioctl(int fd, u32 flags, void *data,
                                     size_t data_size)
 {
        struct vfio_device_feature *feature;
-       size_t feature_size = sizeof(*feature) + data_size;
+       size_t feature_size;
        int ret;

+       feature_size = sizeof(*feature) + data_size;
        feature = calloc(1, feature_size);
        VFIO_ASSERT_NOT_NULL(feature);
        memcpy(feature->data, data, data_size);

