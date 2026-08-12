Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FF5438029
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540461; cv=none; b=PQU8tnc1Y7stn1FzPdDKJngp7bSXVCFNc0oypUrKFqz77yoS9yZBhAb1HBg6WxC4i1cq837nYAjFhZf8800oaGem/HE/G4p6nWq6GowUNHMMSXmFq17p0vtjEgiwmfjTmUwX6XB7en5pELHqZbSeJ6BFXFqeKTuYGNaKoJt3cRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540461; c=relaxed/simple;
	bh=/Mr3bC5Q8kCOVh3qoyQ0+5KAEKLL04lUmM0yK72ZsaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5i0YeZgSSDX/vk5X9ASjjhTjZrBzPOBOVSHvll6QFInbLccllrAu+wHuKXNHiclyoNxpOJo43wF13lp/z7zT/QJEcZ5nG5GTR/GreVmv1Sbru208WK7dw09zNlz5L9ruh/ylidyL/hh96o5h75pncHg15p9OE3k97cgEJyFkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nl/S3OSB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nl/S3OSB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB356153B;
	Wed, 12 Aug 2026 06:14:15 -0700 (PDT)
Received: from e143914.arm.com (e143914.arm.com [10.2.213.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30E993F882;
	Wed, 12 Aug 2026 06:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786540459; bh=/Mr3bC5Q8kCOVh3qoyQ0+5KAEKLL04lUmM0yK72ZsaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nl/S3OSBZQYuw8kfWWZek0nQBIb6s5Yv1EF1NRuOmse06XTEn/PLthNmNCn3ohugU
	 ohBQvbkJuyUPQHXtOku21faVOi7O4lq5pVAeC3HuhwFbqQviO9DU3sYMWYYrtk/TKJ
	 DBT+XcUuD3e/1W2wJY0IIgW9gmID8rUR/wMHhODQ=
Date: Wed, 12 Aug 2026 14:14:15 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Sascha Bischoff <Sascha.Bischoff@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, nd <nd@arm.com>,
	"maz@kernel.org" <maz@kernel.org>,
	"oupton@kernel.org" <oupton@kernel.org>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>
Subject: Re: [PATCH v2 1/4] KVM: arm64: vgic: Free gic_kvm_info on
 initialization failure
Message-ID: <anxxpxy6JXeyI2X9@e143914.arm.com>
References: <20260811150941.941295-1-sascha.bischoff@arm.com>
 <20260811150941.941295-2-sascha.bischoff@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811150941.941295-2-sascha.bischoff@arm.com>

On Tue, Aug 11, 2026 at 03:10:17PM +0000, Sascha Bischoff wrote:
> vgic_set_kvm_info() allocates gic_kvm_info for use by
> kvm_vgic_hyp_init(). When a maintenance interrupt is mandatory but not
> provided, kvm_vgic_hyp_init() returns -ENXIO before reaching the
> common cleanup path, leaking said allocation.
> 
> Route this error through that cleanup path so that gic_kvm_info is
> freed and the global pointer is cleared.
> 
> Fixes: 0e5cb7770684 ("irqchip/gic: Split vGIC probing information from the GIC code")
> Link: https://sashiko.dev/#/patchset/20260724104819.1296803-1-sascha.bischoff@arm.com?part=1
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  arch/arm64/kvm/vgic/vgic-init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
> index 907057881b26a..65e203d6a2cf4 100644
> --- a/arch/arm64/kvm/vgic/vgic-init.c
> +++ b/arch/arm64/kvm/vgic/vgic-init.c
> @@ -787,7 +787,8 @@ int kvm_vgic_hyp_init(void)
>  
>  	if (has_mask && !gic_kvm_info->maint_irq) {
>  		kvm_err("No vgic maintenance irq\n");
> -		return -ENXIO;
> +		ret = -ENXIO;
> +		goto out_free;
>  	}
>  
>  	/*
> @@ -820,6 +821,7 @@ int kvm_vgic_hyp_init(void)
>  
>  	kvm_vgic_global_state.maint_irq = gic_kvm_info->maint_irq;
>  
> +out_free:
>  	kfree(gic_kvm_info);
>  	gic_kvm_info = NULL;
>  

Reviewed-by: Joey Gouly <joey.gouly@arm.com>
