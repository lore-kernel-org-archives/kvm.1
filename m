Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FCF27442
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497418; cv=none; b=DpuzN938LC4p6aQB+oWl84KOYG/rH1p5VVTAFQsI7wwMM/vc098ONnMV6ho1JkDk0FkqAB6+uEWyDXXnk2VDFkNW/CEIDTKkuYMIqNuwBNfE9QSGRfcagmx9gwQe3m+HFvODFazl+eC9wgvfdFJ1izJ6bhhOW1Ytuly4ttvivqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497418; c=relaxed/simple;
	bh=FYqnlFCwpb8xs6n1vwK8VK227l3P1BAeHI69gKZCA54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFPxsHemNnFEq8nFn1xhOQcNDqdstcltc2QfmT2iHT6qid+lQVRmNvrJmPckkF4sJsXrCPKw+oQvsQ89jZTJK5Iu5fm/JKYkjwn6lNJmBaWf6jDTZC9cFgUpKmQDmhKyRB7HjvjuWxN2y6Aist51jgVoHLZEILlsCJunw+/RBck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r2zIRGl3; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r2zIRGl3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778497407; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=aa3sqwAfHWDJfAzPcUpQ5Gk/NxgBvpG/vZ758TZknkk=;
	b=r2zIRGl39mpMi9hphMC6k8Ce++jCTJlvQjcGrnuzhdg5suilDlY3Vk2/QuQztlRfXmjIQN2Q6b8Lnj/cyQulSKS30sp0dQ4E37tNpmm5Ty4pTZVN5y8Da3FtKB1qRom0oU68beRrti2SEOCmWI30iyx14Luso5CGTl4vk7KvI38=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X2iOJIK_1778497405;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X2iOJIK_1778497405 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 May 2026 19:03:26 +0800
Date: Mon, 11 May 2026 19:03:25 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Jonathan Cameron <jic23@kernel.org>, 
	Eric Auger <eric.auger@redhat.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Maxim Levitsky <mlevitsk@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [RFC PATCH] KVM: arm64: vgic: Skip vCPU trylock for pre-init
 register access
Message-ID: <3ijnoudux4iyddpd25yr53s2zqrslplixjqfod225ix43y4z4a@heoklijpq45f>
References: <6564c8b967948e30a8d3f35b6ef5de79dd5feeb7.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6564c8b967948e30a8d3f35b6ef5de79dd5feeb7.camel@infradead.org>

On Sun, May 10, 2026 at 11:11:43PM +0800, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> When creating a VM, userspace sets pre-init distributor registers such
> as GICD_IIDR before the VGIC is initialized.
>
> Strictly speaking there's no reason this couldn't be done at VM creation
> time before any vCPUs exist at all, but the design of the userspace API
> does require vCPU0 to have been created, as the system-wide registers
> are effectively accessed via vCPU0.
>
> So a VMM can't just set the IIDR at startup before spawning vCPU threads;
> it has to be done once the vCPUs are being created.
>
> However, kvm_trylock_all_vcpus() makes it unreliable by causing spurious
> -EBUSY failures if any vCPU cannot be locked. So userspace is forced to
> create the vCPUs (well, at least vCPU0), and is then forced to have a
> full synchronization point and quiesce them all in order to reliably set
> the IIDR.
>
> To slightly reduce the pain of all this, skip the trylock when the VGIC
> is not yet initialized. There is no need to lock the vCPUs if they can't
> be accessing it anyway.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> Other options would include making it possible to set the IIDR before
> creating any vCPUs, either by creating a new device-level attribute or
> special-casing it not to require vCPU0 for DIST_REGS that aren't really
> associated to a vCPU.
>
> Deprecating kvm_trylock_all_vcpus() and killing every user of it with
> fire would also be a good option, perhaps... :)
>
>  arch/arm64/kvm/vgic/vgic-kvm-device.c | 38 ++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/kvm/vgic/vgic-kvm-device.c b/arch/arm64/kvm/vgic/vgic-kvm-device.c
> index a96c77dccf35..e17ea9f07f5f 100644
> --- a/arch/arm64/kvm/vgic/vgic-kvm-device.c
> +++ b/arch/arm64/kvm/vgic/vgic-kvm-device.c
> @@ -540,7 +540,7 @@ static int vgic_v3_attr_regs_access(struct kvm_device *dev,
>  	struct vgic_reg_attr reg_attr;
>  	gpa_t addr;
>  	struct kvm_vcpu *vcpu;
> -	bool uaccess;
> +	bool uaccess, vcpus_locked = false;
>  	u32 val;
>  	int ret;
>
> @@ -566,18 +566,37 @@ static int vgic_v3_attr_regs_access(struct kvm_device *dev,
>  			return -EFAULT;
>  	}
>
> +	if (!vgic_initialized(dev->kvm) && !reg_allowed_pre_init(attr))
> +		return -EBUSY;
> +
>  	mutex_lock(&dev->kvm->lock);
>
> -	if (kvm_trylock_all_vcpus(dev->kvm)) {
> -		mutex_unlock(&dev->kvm->lock);
> -		return -EBUSY;
> +	/*
> +	 * Pre-init registers (e.g. GICD_IIDR) don't need vCPU quiescence
> +	 * since the VGIC isn't live yet.  Skip the trylock to avoid spurious
> +	 * -EBUSY when vCPU threads happen to be running.
> +	 */
> +	if (vgic_initialized(dev->kvm)) {
> +		if (kvm_trylock_all_vcpus(dev->kvm)) {
> +			mutex_unlock(&dev->kvm->lock);
> +			return -EBUSY;
> +		}
> +		vcpus_locked = true;
>  	}
> -
>  	mutex_lock(&dev->kvm->arch.config_lock);
>
> -	if (!(vgic_initialized(dev->kvm) || reg_allowed_pre_init(attr))) {
> -		ret = -EBUSY;
> -		goto out;

Hi David,

> +	/*
> +	 * If the VGIC becomes initialized between the above check and taking
> +	 * config_lock, drop config_lock to lock the VCPUS.
> +	 */
> +	if (vgic_initialized(dev->kvm) && !vcpus_locked) {
> +		mutex_unlock(&dev->kvm->arch.config_lock);
> +		if (kvm_trylock_all_vcpus(dev->kvm)) {
> +			mutex_unlock(&dev->kvm->lock);
> +			return -EBUSY;
> +		}
> +		mutex_lock(&dev->kvm->arch.config_lock);
> +		vcpus_locked = true;

Question: Why not do vgic_initialized(dev->kvm) and
reg_allowed_pre_init(attr) checking after take config_lock,
and depends on the checking result to decide trylocak all
vcpus or not ?

>  	}
>
>  	switch (attr->group) {
> @@ -612,7 +631,8 @@ static int vgic_v3_attr_regs_access(struct kvm_device *dev,
>
>  out:
>  	mutex_unlock(&dev->kvm->arch.config_lock);
> -	kvm_unlock_all_vcpus(dev->kvm);
> +	if (vcpus_locked)
> +		kvm_unlock_all_vcpus(dev->kvm);
>  	mutex_unlock(&dev->kvm->lock);
>
>  	if (!ret && uaccess && !is_write) {
> --
> 2.43.0
>
>
