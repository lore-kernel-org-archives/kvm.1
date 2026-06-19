Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D653438BB
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875356; cv=none; b=hhhZFoM2NHVxlYBY9IXJjXRT1HPrNlWxTqPOMYKCVsW80mjLKMRttJjKWDPfp1Rhah9jwpnlsXc+sBt/FqvtTwGVR9vBriGAdbuFs51FjT2xTqWnv+ttNEiKNIqLt6qz497aPwffASSO6kETRPXKzWTsycK4JAzBsVkiCQnxwJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875356; c=relaxed/simple;
	bh=T6cAHcE2doTEOQHDjqfuv/jaDnjoSBy3geH/6utKmXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjSri/N6G/W/X2JiYYuMuwWGaGST3cu0f06j9ZQ5c9ObWGDAhvwfuyL9slKkgyGytLbt3978ow/lGIPM5FD8faN2V8F7fjRIsNr6PJz9h8PcLNvZn6uQ0Xe/QbHyTCoKRJe4UPvOOKj099+5hKVNLs5LU/5P2tU9UnVAijU5na0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sLdEE6z7; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sLdEE6z7"
X-Gm-Message-State: AOJu0YyVsdwAbbtUaNeM0OQyykWY140JTpgvy3AlArgidXKzrK6WJdAI
	7g8V9yVL1xKclwHU+mUIb1T+xsicNzxOMPXG1xGxjs/DedJJF1waWdzkyCexNqtKj+Iv/+i4diL
	Pp0xIzJoy2Pe34BH/smkZJJQoY8kuTXfcaMJIJq2c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781875353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5MrtgEjreSkQQvk/WxJaOTdpRgzlUpKOdatA6KwnAng=;
	b=sLdEE6z7UCBhFsFZJEahg+DDOZG8HKGSK1UjqY/CF/faiCsr3YNBHj2hEnvXS03x9S8RQX
	J5GDF9838heodREXTktIa3o7kIdkFjgyX5sNaM81bKDO4n5PnnGRpP165BT8khA5MKOQMo
	3RMT/oefB7pDM7lvHW97mLuR25zHcns=
X-Received: by 2002:ac8:5e0d:0:b0:50f:be7b:923a with SMTP id
 d75a77b69052e-519e890f9bfmr6702791cf.9.1781875349714; Fri, 19 Jun 2026
 06:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619115415.5475-1-will@kernel.org> <20260619115415.5475-4-will@kernel.org>
In-Reply-To: <20260619115415.5475-4-will@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 19 Jun 2026 14:21:52 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyG8uPx55LFwD4Xvp2wpv8r=ueKro-boi4PsjA+1Vu1WA@mail.gmail.com>
X-Gm-Features: AVVi8CetRNZBaor3jQz_Jt_KRo1H_04XyK3SViaZ6UD2XURw4EUgSWNMoJbldcM
Message-ID: <CA+EHjTyG8uPx55LFwD4Xvp2wpv8r=ueKro-boi4PsjA+1Vu1WA@mail.gmail.com>
Subject: Re: [PATCH kvmtool 3/4] virtio: Add helper for enabling VIRTIO_F_ACCESS_PLATFORM
To: Will Deacon <will@kernel.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Andre Przywara <andre.przywara@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Fri, 19 Jun 2026 at 12:54, Will Deacon <will@kernel.org> wrote:
>
> In preparation for supporting protected guests on arm64, introduce a
> virtio helper to advertise the VIRTIO_F_ACCESS_PLATFORM feature for the
> modern transport.
>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba < fuad.tabba@linux.dev>

Cheers,
/fuad


> ---
>  include/kvm/virtio.h | 1 +
>  virtio/core.c        | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/include/kvm/virtio.h b/include/kvm/virtio.h
> index c95183b..dd3117b 100644
> --- a/include/kvm/virtio.h
> +++ b/include/kvm/virtio.h
> @@ -277,6 +277,7 @@ void virtio_vhost_reset_vring(struct kvm *kvm, int vhost_fd, u32 index,
>  int virtio_vhost_set_features(int vhost_fd, u64 features);
>
>  int virtio_transport_parser(const struct option *opt, const char *arg, int unset);
> +void virtio_modern_enable_feat_access_platform(void);
>  u64 virtio_get_modern_transport_features(void);
>
>  #endif /* KVM__VIRTIO_H */
> diff --git a/virtio/core.c b/virtio/core.c
> index 8c5086d..96bbf96 100644
> --- a/virtio/core.c
> +++ b/virtio/core.c
> @@ -355,6 +355,11 @@ bool virtio_access_config(struct kvm *kvm, struct virtio_device *vdev,
>
>  static u64 virtio_modern_transport_features = 1ULL << VIRTIO_F_VERSION_1;
>
> +void virtio_modern_enable_feat_access_platform(void)
> +{
> +       virtio_modern_transport_features |= 1ULL << VIRTIO_F_ACCESS_PLATFORM;
> +}
> +
>  u64 virtio_get_modern_transport_features(void)
>  {
>         return virtio_modern_transport_features;
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
