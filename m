Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED5D379EEC
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874989; cv=none; b=k0IVIMFmSy0+qMthu5piqdfYJLdw2J13ZD330RHnNf5WHFCPjTQ8Qv1T8XOw5FsPfuJy7YdV5zImJ6uginxRyJBt1ldzLR0f3+QxQUnE3sn+ZN74S0vQiHDV8urgnNQ1taGGi9k8lJt/40BgmST7WHKXB0bT/0LMBSZl44D+JpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874989; c=relaxed/simple;
	bh=cSMiacCR/NhFzUMt8a+DdUg28wHFgcF9afPQjBPkbEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2OZlM1JmWdFo66Sep8zc1daedJGQNd0so4XjeLO/K9g1TfHPmugocanWyNK/UjU8W4M2vWH+J0td3J293v/gKCUFtdMo4vp2+0KY5zsn4T3+HdIdQfmi7l0H7XeklRJv1UNnFzUEG0r/wfpLmriRL2FpnUmOkMgAOsmi1/QUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lefqLmI+; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lefqLmI+"
X-Gm-Message-State: AOJu0Yye5Y8HvysDWuwzC3tc+GPzrEwgGS6CUmazmLTi/Ky8dJ6mNNFU
	7vMDXg2JUWTHE3KCY5okIWFCGtSwOfM/b8+lbNTlDFV9GEtW/rsxli9JuVoxCwW+nO080W2MRuY
	C083nsacVLz54+JdHF6l1oaEGaPoEKa1Y38xj/aqF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781874986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JaqxoP8Y/RWga5oiHZKiDlOlv+f25+H1YxznesJ/Rxo=;
	b=lefqLmI+7RixNNQuHWA0+RnlbpFLpSt/SqX9/31maQKs/JSr5p6V1WLRXfX16/uGAPKw1j
	ppsvtrbwz08HqkLh7+0IyReO8PUbqv+/jsRkqg7cafqwCKTv70YmFFlvnScyx9xAJIY+rU
	AWHyEMSjI4LskgJceEKWRF8br3k9j1I=
X-Received: by 2002:a05:622a:1906:b0:516:4f62:85ea with SMTP id
 d75a77b69052e-519e8d3111amr6097501cf.21.1781874982465; Fri, 19 Jun 2026
 06:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619115415.5475-1-will@kernel.org> <20260619115415.5475-3-will@kernel.org>
In-Reply-To: <20260619115415.5475-3-will@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 19 Jun 2026 14:15:44 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzAX3ytCEgva5f-aAKMUDuxaz1osKK1wssKB8V6tw7a8g@mail.gmail.com>
X-Gm-Features: AVVi8CeVsNKOUeBxheL4B4SdGYXKyaTc-W3sqpBfaOc-V3opD4Rfr4v22_RNdFs
Message-ID: <CA+EHjTzAX3ytCEgva5f-aAKMUDuxaz1osKK1wssKB8V6tw7a8g@mail.gmail.com>
Subject: Re: [PATCH kvmtool 2/4] virtio: Factor out base features for modern
 virtio transports
To: Will Deacon <will@kernel.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Andre Przywara <andre.przywara@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Fri, 19 Jun 2026 at 12:54, Will Deacon <will@kernel.org> wrote:
>
> In preparation for optionally enabling VIRTIO_F_ACCESS_PLATFORM,
> factor out the base features for modern virtio transports.
>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba < fuad.tabba@linux.dev>

Cheers,
/fuad

> ---
>  include/kvm/virtio.h | 1 +
>  virtio/core.c        | 7 +++++++
>  virtio/mmio-modern.c | 2 +-
>  virtio/pci-modern.c  | 2 +-
>  4 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/include/kvm/virtio.h b/include/kvm/virtio.h
> index 8b7ec1b..c95183b 100644
> --- a/include/kvm/virtio.h
> +++ b/include/kvm/virtio.h
> @@ -277,5 +277,6 @@ void virtio_vhost_reset_vring(struct kvm *kvm, int vhost_fd, u32 index,
>  int virtio_vhost_set_features(int vhost_fd, u64 features);
>
>  int virtio_transport_parser(const struct option *opt, const char *arg, int unset);
> +u64 virtio_get_modern_transport_features(void);
>
>  #endif /* KVM__VIRTIO_H */
> diff --git a/virtio/core.c b/virtio/core.c
> index 50c9ddd..8c5086d 100644
> --- a/virtio/core.c
> +++ b/virtio/core.c
> @@ -353,6 +353,13 @@ bool virtio_access_config(struct kvm *kvm, struct virtio_device *vdev,
>         return true;
>  }
>
> +static u64 virtio_modern_transport_features = 1ULL << VIRTIO_F_VERSION_1;
> +
> +u64 virtio_get_modern_transport_features(void)
> +{
> +       return virtio_modern_transport_features;
> +}
> +
>  int virtio_init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
>                 struct virtio_ops *ops, enum virtio_trans trans,
>                 int device_id, int subsys_id, int class)
> diff --git a/virtio/mmio-modern.c b/virtio/mmio-modern.c
> index 6c0bb38..7787508 100644
> --- a/virtio/mmio-modern.c
> +++ b/virtio/mmio-modern.c
> @@ -11,7 +11,7 @@ static void virtio_mmio_config_in(struct kvm_cpu *vcpu,
>                                   struct virtio_device *vdev)
>  {
>         struct virtio_mmio *vmmio = vdev->virtio;
> -       u64 features = 1ULL << VIRTIO_F_VERSION_1;
> +       u64 features = virtio_get_modern_transport_features();
>         u32 val = 0;
>
>         switch (addr) {
> diff --git a/virtio/pci-modern.c b/virtio/pci-modern.c
> index ef2f3e2..888afa5 100644
> --- a/virtio/pci-modern.c
> +++ b/virtio/pci-modern.c
> @@ -148,7 +148,7 @@ static bool virtio_pci__common_read(struct virtio_device *vdev,
>  {
>         u32 val;
>         struct virtio_pci *vpci = vdev->virtio;
> -       u64 features = 1ULL << VIRTIO_F_VERSION_1;
> +       u64 features = virtio_get_modern_transport_features();
>
>         switch (offset - VPCI_CFG_COMMON_START) {
>         case VIRTIO_PCI_COMMON_DFSELECT:
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
