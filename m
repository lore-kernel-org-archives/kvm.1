Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA2C43CEED
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539395; cv=none; b=KjVOAGoOBhFOfysphboSR5UKMdnQiy+QFkhSENbeYo+UQYt73XnGQSliZI2e9/F+f2aAvsD5oqC6IJQSxssFWuLThDUoyXYhRJSLcx2QmEEaOK7g2Tl7vk7P+jrbs83rXldgJQVBBa5uhG2fg2e0F10k5omgfeGJg6GCgEtLZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539395; c=relaxed/simple;
	bh=qCQ5vVd9hvs873dfwrrsv7PJkSHkES7vZkCYqGWPE38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ildw2/NEEIlJRp3YyjhsMtMWxoksl3J3Y259vSwJPAHik9oKR9gd4lz34HEh5fFG5XY0p3A0iuAWg+i+2I+qS96Xl6ULLgkozGCTvep/fEp75SRLse17CRNusVEvMbHOs28i8bECKnpVuchRh2rEe8VFGDyTjZMnpY3oaTa6ZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tg5/dqGq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tg5/dqGq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48F081596;
	Wed, 12 Aug 2026 05:56:27 -0700 (PDT)
Received: from e143914.arm.com (e143914.arm.com [10.2.213.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F2AD3F632;
	Wed, 12 Aug 2026 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786539391; bh=qCQ5vVd9hvs873dfwrrsv7PJkSHkES7vZkCYqGWPE38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tg5/dqGqlXnBTt/6+eVWrJsiAx2QzQF4N2wLDifhSBPmkYPN6qMBSmlRpSiXkJ4UD
	 9i/hfZzC1zpZcehx0GqCXtkYBp+oI5vhQcYx7aSCNAoGY7kLoEVEsZBAp+WU02tSq3
	 RuQb9J5AVwo3WYH1plawk5dFNrQd2HKhvJUzz2uQ=
Date: Wed, 12 Aug 2026 13:56:27 +0100
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
Subject: Re: [PATCH v2 3/4] KVM: arm64: vgic: Reject out-of-range GICv5 PPI
 IDs
Message-ID: <anxte33cYsGjjoC5@e143914.arm.com>
References: <20260811150941.941295-1-sascha.bischoff@arm.com>
 <20260811150941.941295-4-sascha.bischoff@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811150941.941295-4-sascha.bischoff@arm.com>

On Tue, Aug 11, 2026 at 03:11:18PM +0000, Sascha Bischoff wrote:
> GICv5 supports up to 128 PPIs, but KVM currently implements only the
> first 64, which contain the architected PPIs it supports.
> 
> An encoded PPI with an ID outside that range passes irq_is_ppi(),
> which only checks the encoded interrupt type. vgic_get_vcpu_irq()
> therefore looks it up in private_irqs[], where array_index_nospec()
> clamps the out-of-range index to zero and aliases PPI 0.
> 
> Include the supported PPI range in irq_is_ppi() so that KVM interfaces
> reject unsupported PPIs. Also reject an out-of-range PPI in the lookup
> as a safeguard against callers bypassing the predicate.
> 
> Fixes: 4d591252bacb ("KVM: arm64: gic-v5: Implement PPI interrupt injection")
> Fixes: eb8bce08ecb1 ("KVM: arm64: gic: Introduce interrupt type helpers")
> Link: https://sashiko.dev/#/patchset/20260724104819.1296803-1-sascha.bischoff@arm.com?part=27
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  arch/arm64/kvm/vgic/vgic.c | 2 ++
>  include/kvm/arm_vgic.h     | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
> index 352d52bd6315c..b25303d9919fd 100644
> --- a/arch/arm64/kvm/vgic/vgic.c
> +++ b/arch/arm64/kvm/vgic/vgic.c
> @@ -118,6 +118,8 @@ struct vgic_irq *vgic_get_vcpu_irq(struct kvm_vcpu *vcpu, u32 intid)
>  		switch (type) {
>  		case KVM_DEV_TYPE_ARM_VGIC_V5:
>  			intid = vgic_v5_get_hwirq_id(intid);
> +			if (intid >= VGIC_V5_NR_PRIVATE_IRQS)
> +				return NULL;
>  			intid = array_index_nospec(intid, VGIC_V5_NR_PRIVATE_IRQS);
>  			break;
>  		default:
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index cefddc9c621de..1a549cceecbec 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -65,6 +65,8 @@
>  		switch (t) {						\
>  		case KVM_DEV_TYPE_ARM_VGIC_V5:				\
>  			__ret = is_v5_type(GICV5_HWIRQ_TYPE_PPI, (i));	\
> +			__ret &= FIELD_GET(GICV5_HWIRQ_ID, (i)) <	\
> +				 VGIC_V5_NR_PRIVATE_IRQS;		\
>  			break;						\
>  		default:						\
>  			__ret  = (i) >= VGIC_NR_SGIS;			\

Reviewed-by: Joey Gouly <joey.gouly@arm.com>
